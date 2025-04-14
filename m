From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v16 0/6] Introduction of a remoteproc tee to load signed firmware
Date: Mon, 14 Apr 2025 15:59:32 +0200
Message-ID: <be981c5c-5252-4650-a148-c2f51d83a430@foss.st.com>
In-Reply-To: <20250325095833.3059895-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2562836039776816436=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2562836039776816436==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Bjorn,

Gentle reminder.

For your information, I proposed to Mathieu that he wait for your first revie=
w,
as this revision is intended to address your comments on revision 15."

Thanks,
Arnaud


On 3/25/25 10:58, Arnaud Pouliquen wrote:
> Main updates from version V15[1]:
> - Removed the rproc_ops:load_fw() operation introduced in the previous vers=
ion.
> - Returned to managing the remoteproc firmware loading in rproc_tee_parse_f=
w to
>   load and authenticate the firmware before getting the resource table.
> - Added spinlock and dev_link mechanisms in remoteproc TEE to better manage
>   bind/unbind.
>=20
> More details are available in each patch commit message.
>=20
> [1] https://lore.kernel.org/linux-remoteproc/20241128084219.2159197-7-arnau=
d.pouliquen(a)foss.st.com/T/
>=20
> Tested-on: commit 0a0ba9924445 ("Linux 6.14-rc7")
>=20
> Description of the feature:
> --------------------------
> This series proposes the implementation of a remoteproc tee driver to
> communicate with a TEE trusted application responsible for authenticating
> and loading the remoteproc firmware image in an Arm secure context.
>=20
> 1) Principle:
>=20
> The remoteproc tee driver provides services to communicate with the OP-TEE
> trusted application running on the Trusted Execution Context (TEE).
> The trusted application in TEE manages the remote processor lifecycle:
>=20
> - authenticating and loading firmware images,
> - isolating and securing the remote processor memories,
> - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
> - managing the start and stop of the firmware by the TEE.
>=20
> 2) Format of the signed image:
>=20
> Refer to:
> https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc=
_core.c#L18-L57
>=20
> 3) OP-TEE trusted application API:
>=20
> Refer to:
> https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_rem=
oteproc.h
>=20
> 4) OP-TEE signature script
>=20
> Refer to:
> https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py
>=20
> Example of usage:
> sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key=
 ${OP-TEE_PATH}/keys/default.pem
>=20
>=20
> 5) Impact on User space Application
>=20
> No sysfs impact. The user only needs to provide the signed firmware image
> instead of the ELF image.
>=20
>=20
> For more information about the implementation, a presentation is available =
here
> (note that the format of the signed image has evolved between the presentat=
ion
> and the integration in OP-TEE).
>=20
> https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds
>=20
>=20
>=20
> Arnaud Pouliquen (6):
>   remoteproc: core: Introduce rproc_pa_to_va helper
>   remoteproc: Add TEE support
>   remoteproc: Introduce release_fw optional operation
>   dt-bindings: remoteproc: Add compatibility for TEE support
>   remoteproc: stm32: Create sub-functions to request shutdown and
>     release
>   remoteproc: stm32: Add support of an OP-TEE TA to load the firmware
>=20
>  .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 +-
>  drivers/remoteproc/Kconfig                    |  10 +
>  drivers/remoteproc/Makefile                   |   1 +
>  drivers/remoteproc/remoteproc_core.c          |  52 ++
>  drivers/remoteproc/remoteproc_internal.h      |   6 +
>  drivers/remoteproc/remoteproc_tee.c           | 619 ++++++++++++++++++
>  drivers/remoteproc/stm32_rproc.c              | 139 +++-
>  include/linux/remoteproc.h                    |   4 +
>  include/linux/remoteproc_tee.h                |  90 +++
>  9 files changed, 935 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/remoteproc/remoteproc_tee.c
>  create mode 100644 include/linux/remoteproc_tee.h
>=20
>=20
> base-commit: 0a0ba99244455fea8706c4a53f5f66a45d87905d

--===============2562836039776816436==--

