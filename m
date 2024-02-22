From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Thu, 22 Feb 2024 08:48:45 +0000
Message-ID: <adcf0c0d-f452-4285-8651-c147fcca001b@foss.st.com>
In-Reply-To: <fe4ec29f-7521-4369-a382-bae50dbf0ee5@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6885546770968513446=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6885546770968513446==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Naman,

On 2/22/24 06:43, Naman Jain wrote:
> On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
>> Updates from the previous version [1]:
>>
>> This version proposes another approach based on an alternate load and boot
>> of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
>> is that the firmware has to be authenticated and loaded before the resource
>> table can be obtained.
>>
>> The existing boot sequence is: >
>> =C2=A0=C2=A0 1) Get the resource table and store it in a cache,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling rproc->ops->parse_fw().
>> =C2=A0=C2=A0 2) Parse the resource table and handle resources,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling rproc_handle_resources.
>> =C2=A0=C2=A0 3) Load the firmware, calling rproc->ops->load().
>> =C2=A0=C2=A0 4) Start the firmware, calling rproc->ops->start().
>> =C2=A0 =3D> Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3 a=
nd 4 are
>> =C2=A0=C2=A0=C2=A0 executed in rproc_start().
>> =3D> the use of rproc->ops->load() ops is mandatory
>>
>> The boot sequence needed for TEE boot is:
>>
>> =C2=A0=C2=A0 1) Load the firmware.
>> =C2=A0=C2=A0 2) Get the loaded resource, no cache.
>> =C2=A0=C2=A0 3) Parse the resource table and handle resources.
>> =C2=A0=C2=A0 4) Start the firmware.
>=20
> Hi,
> What problem are we really addressing here by reordering load, parse of
> FW resources?

The feature introduced in TEE is the signature of the firmware images. That
means that before getting the resource table, we need to first authenticate t=
he
firmware images.
Authenticating a firmware image means that we have to copy the firmware into
protected memory that cannot be corrupted by the non-secure and then verify t=
he
signature.
The strategy implemented in OP-TEE is to load the firmware into destination
memory and then authenticate it.
This strategy avoids having a temporary copy of the whole images in a secure =
memory.
This strategy imposes loading the firmware images before retrieving the resou=
rce
table.

> Basically, what are the limitations of the current design you are referring=
 to?
> I understood that TEE is designed that way.

The limitation of the current design is that we obtain the resource table bef=
ore
loading the firmware. Following the current design would impose constraints in
TEE that are not straightforward. Step 1 (getting the resource table and stor=
ing
it in a cache) would require having a copy of the resource table in TEE after
authenticating the images. However, authenticating the firmware, as explained
before, depends on the strategy implemented. In TEE implementation, we load t=
he
firmware to authenticate it in the destination memory.

Regards,
Arnaud

>=20
>>
>> Then the crash recovery also has to be managed.For recovery, the cache is
>> used to temporarily save the resource table and then reapply it on
>> restart:
>> =C2=A0=C2=A0 1) Stop the remote processor, calling rproc->ops->stop().
>> =C2=A0=C2=A0 2) Load the firmware, calling rproc->ops->load().
>> =C2=A0=C2=A0 3) Copy cached resource table.
>> =C2=A0=C2=A0 4) Start the remote processor, calling rproc->ops->start().
>>
>> =3D> This sequence is also needed when TEE manages the boot of the remote
>> =C2=A0=C2=A0=C2=A0 processor.
>> =3D> The rproc->ops->load() is also used in recovery sequence.
>>
>> Based on the sequences described above, the proposal is to:
>>
>> - Rework tee_rproc API to better match the rproc_ops structure.
>> =C2=A0=C2=A0 This allows to simply map the function to implement the load =
ops, which
>> =C2=A0=C2=A0 is not optional. The tee_rproc_load_fw() is updated in conseq=
uence.
>> - Remove the call of rproc_load_segments from rproc_start() to dissociate
>> =C2=A0=C2=A0 the load and the start. This is necessary to implement the bo=
ot sequence
>> =C2=A0=C2=A0 requested for the TEE remote proc support.
>> - Introduce an rproc_alt_fw_boot() function that is an alternative boot
>> =C2=A0=C2=A0 sequence, which implements the sequence requested for the TEE=
 remoteproc
>> =C2=A0=C2=A0 support.
>>
>>
>> [1]
>> https://lore.kernel.org/lkml/20240118100433.3984196-1-arnaud.pouliquen(a)f=
oss.st.com/T/
>>
>>
>> Description of the feature:
>>
>> This series proposes the implementation of a remoteproc tee driver to
>> communicate with a TEE trusted application responsible for authenticating =
and
>> loading the remoteproc firmware image in an Arm secure context.
>>
>> 1) Principle:
>>
>> The remoteproc tee driver provides services to communicate with the OP-TEE
>> trusted application running on the Trusted Execution Context (TEE).
>=20
> s/Context/Environment?
>=20
>> The trusted application in TEE manages the remote processor lifecycle:
>>
>> - authenticating and loading firmware images,
>> - isolating and securing the remote processor memories,
>> - supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
>> - managing the start and stop of the firmware by the TEE.
>>
>=20
> Regards,
> Naman Jain
>=20

--===============6885546770968513446==--

