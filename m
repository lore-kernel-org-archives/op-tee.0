From: Naman Jain <quic_namajain@quicinc.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Thu, 22 Feb 2024 09:55:36 +0000
Message-ID: <8af59b01-53cf-4fc4-9946-6c630fb7b38e@quicinc.com>
In-Reply-To: <adcf0c0d-f452-4285-8651-c147fcca001b@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6996530118355560836=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6996530118355560836==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2/22/2024 2:17 PM, Arnaud POULIQUEN wrote:
> Hello Naman,
>=20
> On 2/22/24 06:43, Naman Jain wrote:
>> On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
>>> Updates from the previous version [1]:
>>>
>>> This version proposes another approach based on an alternate load and boot
>>> of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
>>> is that the firmware has to be authenticated and loaded before the resour=
ce
>>> table can be obtained.
>>>
>>> The existing boot sequence is: >
>>>  =C2=A0=C2=A0 1) Get the resource table and store it in a cache,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling rproc->ops->parse_fw().
>>>  =C2=A0=C2=A0 2) Parse the resource table and handle resources,
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling rproc_handle_resources.
>>>  =C2=A0=C2=A0 3) Load the firmware, calling rproc->ops->load().
>>>  =C2=A0=C2=A0 4) Start the firmware, calling rproc->ops->start().
>>>  =C2=A0 =3D> Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3=
 and 4 are
>>>  =C2=A0=C2=A0=C2=A0 executed in rproc_start().
>>> =3D> the use of rproc->ops->load() ops is mandatory
>>>
>>> The boot sequence needed for TEE boot is:
>>>
>>>  =C2=A0=C2=A0 1) Load the firmware.
>>>  =C2=A0=C2=A0 2) Get the loaded resource, no cache.
>>>  =C2=A0=C2=A0 3) Parse the resource table and handle resources.
>>>  =C2=A0=C2=A0 4) Start the firmware.
>>
>> Hi,
>> What problem are we really addressing here by reordering load, parse of
>> FW resources?
>=20
> The feature introduced in TEE is the signature of the firmware images. That
> means that before getting the resource table, we need to first authenticate=
 the
> firmware images.
> Authenticating a firmware image means that we have to copy the firmware into
> protected memory that cannot be corrupted by the non-secure and then verify=
 the
> signature.
> The strategy implemented in OP-TEE is to load the firmware into destination
> memory and then authenticate it.
> This strategy avoids having a temporary copy of the whole images in a secur=
e memory.
> This strategy imposes loading the firmware images before retrieving the res=
ource
> table.
>=20
>> Basically, what are the limitations of the current design you are referrin=
g to?
>> I understood that TEE is designed that way.
>=20
> The limitation of the current design is that we obtain the resource table b=
efore
> loading the firmware. Following the current design would impose constraints=
 in
> TEE that are not straightforward. Step 1 (getting the resource table and st=
oring
> it in a cache) would require having a copy of the resource table in TEE aft=
er
> authenticating the images. However, authenticating the firmware, as explain=
ed
> before, depends on the strategy implemented. In TEE implementation, we load=
 the
> firmware to authenticate it in the destination memory.
>=20
> Regards,
> Arnaud


Hello Arnaud,
I think now I got your point. In TEE, you don't want to do anything(read
resource table) with FW images, until its loaded and authenticated.
Since current design was not allowing you to do it, you had to=20
reorganize the code so that this can be achieved.

Generally speaking, in current design, if authentication fails for some
reason later, one can handle it, but it depends on the implementation of
parse_fw op if the damage is already done.

Please correct me if this is wrong assumption.
Patch looks good to me.

Regards,
Naman Jain

--===============6996530118355560836==--

