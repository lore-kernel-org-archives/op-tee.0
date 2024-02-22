From: Naman Jain <quic_namajain@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Thu, 22 Feb 2024 05:44:09 +0000
Message-ID: <fe4ec29f-7521-4369-a382-bae50dbf0ee5@quicinc.com>
In-Reply-To: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6573411352998274615=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6573411352998274615==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
> Updates from the previous version [1]:
>=20
> This version proposes another approach based on an alternate load and boot
> of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
> is that the firmware has to be authenticated and loaded before the resource
> table can be obtained.
>=20
> The existing boot sequence is: >
>    1) Get the resource table and store it in a cache,
>       calling rproc->ops->parse_fw().
>    2) Parse the resource table and handle resources,
>       calling rproc_handle_resources.
>    3) Load the firmware, calling rproc->ops->load().
>    4) Start the firmware, calling rproc->ops->start().
>  =20
> =3D> Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3 and 4 are
>     executed in rproc_start().
> =3D> the use of rproc->ops->load() ops is mandatory
>=20
> The boot sequence needed for TEE boot is:
>=20
>    1) Load the firmware.
>    2) Get the loaded resource, no cache.
>    3) Parse the resource table and handle resources.
>    4) Start the firmware.

Hi,
What problem are we really addressing here by reordering load, parse of
FW resources?
Basically, what are the limitations of the current design you are=20
referring to?
I understood that TEE is designed that way.

>=20
> Then the crash recovery also has to be managed.For recovery, the cache is
> used to temporarily save the resource table and then reapply it on
> restart:
>    1) Stop the remote processor, calling rproc->ops->stop().
>    2) Load the firmware, calling rproc->ops->load().
>    3) Copy cached resource table.
>    4) Start the remote processor, calling rproc->ops->start().
>=20
> =3D> This sequence is also needed when TEE manages the boot of the remote
>     processor.
> =3D> The rproc->ops->load() is also used in recovery sequence.
>=20
> Based on the sequences described above, the proposal is to:
>=20
> - Rework tee_rproc API to better match the rproc_ops structure.
>    This allows to simply map the function to implement the load ops, which
>    is not optional. The tee_rproc_load_fw() is updated in consequence.
> - Remove the call of rproc_load_segments from rproc_start() to dissociate
>    the load and the start. This is necessary to implement the boot sequence
>    requested for the TEE remote proc support.
> - Introduce an rproc_alt_fw_boot() function that is an alternative boot
>    sequence, which implements the sequence requested for the TEE remoteproc
>    support.
>=20
>=20
> [1] https://lore.kernel.org/lkml/20240118100433.3984196-1-arnaud.pouliquen(=
a)foss.st.com/T/
>=20
>=20
> Description of the feature:
>=20
> This series proposes the implementation of a remoteproc tee driver to
> communicate with a TEE trusted application responsible for authenticating a=
nd
> loading the remoteproc firmware image in an Arm secure context.
>=20
> 1) Principle:
>=20
> The remoteproc tee driver provides services to communicate with the OP-TEE
> trusted application running on the Trusted Execution Context (TEE).

s/Context/Environment?

> The trusted application in TEE manages the remote processor lifecycle:
>=20
> - authenticating and loading firmware images,
> - isolating and securing the remote processor memories,
> - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
> - managing the start and stop of the firmware by the TEE.
>=20

Regards,
Naman Jain


--===============6573411352998274615==--

