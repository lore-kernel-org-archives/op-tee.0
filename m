From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 [PATCH v3 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Wed, 14 Feb 2024 17:22:38 +0000
Message-ID: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8234376261126468370=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8234376261126468370==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Updates from the previous version [1]:

This version proposes another approach based on an alternate load and boot
of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
is that the firmware has to be authenticated and loaded before the resource
table can be obtained.

The existing boot sequence is:

  1) Get the resource table and store it in a cache,
     calling rproc->ops->parse_fw().
  2) Parse the resource table and handle resources,
     calling rproc_handle_resources.
  3) Load the firmware, calling rproc->ops->load().
  4) Start the firmware, calling rproc->ops->start().
=20
=3D> Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3 and 4 are
   executed in rproc_start().
=3D> the use of rproc->ops->load() ops is mandatory

The boot sequence needed for TEE boot is:

  1) Load the firmware.
  2) Get the loaded resource, no cache.
  3) Parse the resource table and handle resources.
  4) Start the firmware.

Then the crash recovery also has to be managed.For recovery, the cache is
used to temporarily save the resource table and then reapply it on
restart:
  1) Stop the remote processor, calling rproc->ops->stop().
  2) Load the firmware, calling rproc->ops->load().
  3) Copy cached resource table.
  4) Start the remote processor, calling rproc->ops->start().

=3D> This sequence is also needed when TEE manages the boot of the remote
   processor.
=3D> The rproc->ops->load() is also used in recovery sequence.

Based on the sequences described above, the proposal is to:

- Rework tee_rproc API to better match the rproc_ops structure.
  This allows to simply map the function to implement the load ops, which
  is not optional. The tee_rproc_load_fw() is updated in consequence.=20
- Remove the call of rproc_load_segments from rproc_start() to dissociate
  the load and the start. This is necessary to implement the boot sequence
  requested for the TEE remote proc support.
- Introduce an rproc_alt_fw_boot() function that is an alternative boot
  sequence, which implements the sequence requested for the TEE remoteproc
  support.


[1] https://lore.kernel.org/lkml/20240118100433.3984196-1-arnaud.pouliquen(a)=
foss.st.com/T/


Description of the feature:

This series proposes the implementation of a remoteproc tee driver to
communicate with a TEE trusted application responsible for authenticating and
loading the remoteproc firmware image in an Arm secure context.

1) Principle:

The remoteproc tee driver provides services to communicate with the OP-TEE
trusted application running on the Trusted Execution Context (TEE).
The trusted application in TEE manages the remote processor lifecycle:

- authenticating and loading firmware images,
- isolating and securing the remote processor memories,
- supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
- managing the start and stop of the firmware by the TEE.

2) Format of the signed image:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_c=
ore.c#L18-L57

3) OP-TEE trusted application API:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remot=
eproc.h

4) OP-TEE signature script

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py

Example of usage:
sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key $=
{OP-TEE_PATH}/keys/default.pem


5) Impact on User space Application

No sysfs impact.the user only needs to provide the signed firmware image
instead of the ELF image.


For more information about the implementation, a presentation is available he=
re
(note that the format of the signed image has evolved between the presentation
and the integration in OP-TEE).

https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds

Arnaud Pouliquen (7):
  remoteproc: Add TEE support
  remoteproc: Extract the firmware load from the start
  remoteproc: core: Add check on cached_table pointer
  remoteproc: core: Implement the support of an alternative boot
  dt-bindings: remoteproc: Add compatibility for TEE support
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  51 ++-
 drivers/remoteproc/Kconfig                    |   9 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          | 109 ++++-
 drivers/remoteproc/stm32_rproc.c              | 169 ++++++--
 drivers/remoteproc/tee_remoteproc.c           | 397 ++++++++++++++++++
 include/linux/remoteproc.h                    |   2 +
 include/linux/tee_remoteproc.h                | 102 +++++
 8 files changed, 784 insertions(+), 56 deletions(-)
 create mode 100644 drivers/remoteproc/tee_remoteproc.c
 create mode 100644 include/linux/tee_remoteproc.h

--=20
2.25.1


--===============8234376261126468370==--

