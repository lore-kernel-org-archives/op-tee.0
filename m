From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed firmware
Date: Fri, 23 Feb 2024 14:11:23 +0000
Message-ID: <c80d0ca1-1ae3-4af3-ba84-6dc5efaff1c7@foss.st.com>
In-Reply-To: <8af59b01-53cf-4fc4-9946-6c630fb7b38e@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2491814881860061086=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2491814881860061086==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 2/22/24 10:55, Naman Jain wrote:
> On 2/22/2024 2:17 PM, Arnaud POULIQUEN wrote:
>> Hello Naman,
>>
>> On 2/22/24 06:43, Naman Jain wrote:
>>> On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
>>>> Updates from the previous version [1]:
>>>>
>>>> This version proposes another approach based on an alternate load and bo=
ot
>>>> of the coprocessor. Therefore, the constraint introduced by tee_remotepr=
oc
>>>> is that the firmware has to be authenticated and loaded before the resou=
rce
>>>> table can be obtained.
>>>>
>>>> The existing boot sequence is: >
>>>> =C2=A0=C2=A0=C2=A0 1) Get the resource table and store it in a cache,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling rproc->ops->parse_fw().
>>>> =C2=A0=C2=A0=C2=A0 2) Parse the resource table and handle resources,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 calling rproc_handle_resources.
>>>> =C2=A0=C2=A0=C2=A0 3) Load the firmware, calling rproc->ops->load().
>>>> =C2=A0=C2=A0=C2=A0 4) Start the firmware, calling rproc->ops->start().
>>>> =C2=A0=C2=A0 =3D> Steps 1 and 2 are executed in rproc_fw_boot(), while s=
teps 3 and 4 are
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 executed in rproc_start().
>>>> =3D> the use of rproc->ops->load() ops is mandatory
>>>>
>>>> The boot sequence needed for TEE boot is:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 1) Load the firmware.
>>>> =C2=A0=C2=A0=C2=A0 2) Get the loaded resource, no cache.
>>>> =C2=A0=C2=A0=C2=A0 3) Parse the resource table and handle resources.
>>>> =C2=A0=C2=A0=C2=A0 4) Start the firmware.
>>>
>>> Hi,
>>> What problem are we really addressing here by reordering load, parse of
>>> FW resources?
>>
>> The feature introduced in TEE is the signature of the firmware images. That
>> means that before getting the resource table, we need to first authenticat=
e the
>> firmware images.
>> Authenticating a firmware image means that we have to copy the firmware in=
to
>> protected memory that cannot be corrupted by the non-secure and then verif=
y the
>> signature.
>> The strategy implemented in OP-TEE is to load the firmware into destination
>> memory and then authenticate it.
>> This strategy avoids having a temporary copy of the whole images in a secu=
re
>> memory.
>> This strategy imposes loading the firmware images before retrieving the re=
source
>> table.
>>
>>> Basically, what are the limitations of the current design you are referri=
ng to?
>>> I understood that TEE is designed that way.
>>
>> The limitation of the current design is that we obtain the resource table =
before
>> loading the firmware. Following the current design would impose constraint=
s in
>> TEE that are not straightforward. Step 1 (getting the resource table and s=
toring
>> it in a cache) would require having a copy of the resource table in TEE af=
ter
>> authenticating the images. However, authenticating the firmware, as explai=
ned
>> before, depends on the strategy implemented. In TEE implementation, we loa=
d the
>> firmware to authenticate it in the destination memory.
>>
>> Regards,
>> Arnaud
>=20
>=20
> Hello Arnaud,
> I think now I got your point. In TEE, you don't want to do anything(read
> resource table) with FW images, until its loaded and authenticated.
> Since current design was not allowing you to do it, you had to reorganize t=
he
> code so that this can be achieved.
>=20
> Generally speaking, in current design, if authentication fails for some
> reason later, one can handle it, but it depends on the implementation of
> parse_fw op if the damage is already done.
>=20
> Please correct me if this is wrong assumption.

That's correct.

Regards,
Arnaud

> Patch looks good to me.
>=20
> Regards,
> Naman Jain

--===============2491814881860061086==--

