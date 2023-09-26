From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE device
Date: Tue, 26 Sep 2023 19:16:23 +0530
Message-ID: <a9de0110-99f4-bd32-53c7-0a4f3309822e@amd.com>
In-Reply-To: <
 <CAFA6WYNPRzaa=5HDpqN191KN8bQv1nCF6gXo4RPSG0SZ55WOVA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5109005730543555379=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5109005730543555379==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 9/26/2023 6:02 PM, Sumit Garg wrote:
> +cc OP-TEE ML
>=20
> On Tue, 26 Sept 2023 at 13:47, Rijo Thomas <Rijo-john.Thomas@amd.com> wro=
te:
>>
>> On 9/26/2023 1:19 PM, Sumit Garg wrote:
>>> On Tue, 26 Sept 2023 at 12:53, Rijo Thomas <Rijo-john.Thomas@amd.com> w=
rote:
>>>>
>>>> On 9/26/2023 12:14 PM, Sumit Garg wrote:
>>>>> +cc Alex
>>>>>
>>>>> On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linaro.=
org> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> [+cc Arnd]
>>>>>>
>>>>>> On Tue, Sep 26, 2023 at 8:00=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
>>>>>>>
>>>>>>> +cc Jens
>>>>>>>
>>>>>>>> In a virtual environment, an application running in guest VM may want
>>>>>>>> to delegate security sensitive tasks to a Trusted Application (TA)
>>>>>>>> running within a Trusted Execution Environment (TEE). A TEE is a tru=
sted
>>>>>>>> OS running in some secure environment, for example, TrustZone on ARM
>>>>>>>> CPUs, or a separate secure co-processor etc.
>>>>>>>
>>>>>>> I have been exploring this area quite recently with an effort to have=
 a common VIRIO interface which can support different trusted OS implementati=
ons. I guess you intend to test it with AMD-TEE, right? Any plans to test it =
with OP-TEE? As currently we have these two supported upstream.
>>>>>>>
>>>> Yes, we have tested with AMD-TEE. We have not yet tested with OP-TEE. Su=
re, we will try it out.
>>>
>>> Glad to hear that. I can help get it tested with OP-TEE as well.
>>>
>>
>> We will test it out internally. Shall let you know in case we need help.
>>
>>>>
>>>>>>> Do you currently have any virtio frontend/backend implementations for=
 this?
>>>>>>>
>>>>
>>>> Yes, we have. Frontend is a Linux virtio-TEE driver, and backend is virt=
io-TEE device emulated in QEMU.
>>>> We used the Xen hypervisor.
>>>
>>> Can you share corresponding references? I can give it a try using Qemu wi=
th KVM.
>>>
>>
>> We will share it in next couple of weeks. We have not yet hosted the code =
for external consumption.
>>
>>>>
>>>>>>>>
>>>>>>>> A virtual TEE device emulates a TEE within a guest VM. Such a virtual
>>>>>>>> TEE device supports multiple operations such as:
>>>>>>>>
>>>>>>>> VIRTIO_TEE_CMD_OPEN_DEVICE =E2=80=93 Open a communication channel wi=
th virtio
>>>>>>>>                              TEE device.
>>>>>>>> VIRTIO_TEE_CMD_CLOSE_DEVICE =E2=80=93 Close communication channel wi=
th virtio
>>>>>>>>                               TEE device.
>>>>>>>> VIRTIO_TEE_CMD_GET_VERSION =E2=80=93 Get version of virtio TEE.
>>>>>>>> VIRTIO_TEE_CMD_OPEN_SESSION =E2=80=93 Open a session to communicate =
with
>>>>>>>>                               trusted application running in TEE.
>>>>>>>> VIRTIO_TEE_CMD_CLOSE_SESSION =E2=80=93 Close a session to end commun=
ication
>>>>>>>>                                with trusted application running in T=
EE.
>>>>>>>> VIRTIO_TEE_CMD_INVOKE_FUNC =E2=80=93 Invoke a command or function in=
 trusted
>>>>>>>>                              application running in TEE.
>>>>>>>> VIRTIO_TEE_CMD_CANCEL_REQ =E2=80=93 Cancel an ongoing command within=
 TEE.
>>>>>>>>
>>>>>>>
>>>>>>> How about shared memory support? We would like to register guest page=
s with the trusted OS.
>>>> We have a command VIRTIO_TEE_CMD_REGISTER_MEM for registering shared mem=
ory buffer with Trusted OS.
>>>
>>> I suppose the commit message has to be appended then. Do you have the
>>> draft virtio-tee device specification ready for review? I would be
>>> interested to review that.
>>>
>>
>> Yes, the command is missed out in the commit message.
>=20
> With the commit message updated to include support for shared memory,
> feel free to add:
>=20
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>=20

Okay. I have asked Jeshwanth to post a revised patch with updated commit mess=
age.

>>
>> We are in the process of preparing virtio-tee device specification. We wil=
l be sending it out to this
>> list.
>=20
> I would also suggest you to CC: op-tee(a)lists.trustedfirmware.org for revi=
ew.
>=20

Okay.

Thanks,
Rijo

>>
>>>>
>>>> In this command, the guest pages are copied into a shadow buffer in the =
host OS. And this shadow
>>>> buffer is mapped with Trusted OS. So, buffer-copy is involved.
>>>>
>>>> One limitation, that we had was that the guest pages were non-contiguous=
. So, the number of physical
>>>> pages that had to be mapped with Trusted OS was exceeding 64 entries whe=
n we were testing out the
>>>> registering of guest pages. AMD-TEE Trusted OS can map a physically non-=
contiguous buffer, but the
>>>> number of sg entries for such a buffer must be less than 64. So, we reso=
rted to using a shadow buffer
>>>> that is allocated within host, and gets mapped with Trusted OS.
>>>
>>> I don't think OP-TEE OS has such a limitation on non-contiguous pages.
>>> So I would suggest you to keep VIRTIO_TEE_CMD_REGISTER_MEM as part of
>>> the ABI. It can be an optional feature for a particular trusted OS
>>> implementation to support.
>>>
>>
>> Currently, the reg_mem (register memory) control is dictated by a flag in =
virtio-tee qemu code. This flag
>> for our testing was hard-coded as false. We will enhance our code, so that=
 it is configurable. The value
>> of reg_mem shall be set to true/false depending upon whether the underlyin=
g TEE driver reports TEE_GEN_CAP_REG_MEM.
>=20
> Sounds good to me.
>=20
> -Sumit
>=20
>>
>> Thanks,
>> Rijo
>>
>>> -Sumit
>>>
>>>>
>>>> Thanks,
>>>> Rijo
>>>>
>>>>>>
>>>>>> Coincidently Arnd and I (among others) discussed this in person last
>>>>>> week and the conclusion was that only temporary shared memory is
>>>>>> possible with virtio. So the shared memory has to be set up and torn
>>>>>> down by the host during each operation, typically open-session or
>>>>>> invoke-func.
>>>>>
>>>>> Agree as I was part of those discussions. But I would like to
>>>>> understand the reasoning behind it. Is there any restriction by VIRTIO
>>>>> specification that we can't register guest page PAs to a device (TEE
>>>>> in our case) to allow for zero copy transfers?
>>>>>
>>>>> Alex mentioned some references to virtio GPU device. I suppose I need
>>>>> to dive into its implementation to see if there are any similarities
>>>>> to our use-case.
>>>>>
>>>>>> That might not be optimal if trying to maximize
>>>>>> performance, but it is portable.
>>>>>
>>>>> IMO, the ABI should be flexible enough to support a TEE with optimum
>>>>> performance.
>>>>>
>>>>> -Sumit
>>>>>
>>>>>>
>>>>>> Cheers,
>>>>>> Jens
>>>>>>
>>>>>>>
>>>>>>> -Sumit
>>>>>>>
>>>>>>>> We would like to reserve device ID 46 for Virtio-TEE device.
>>>>>>>>
>>>>>>>> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
>>>>>>>> ---
>>>>>>>>  content.tex | 2 ++
>>>>>>>>  1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/content.tex b/content.tex
>>>>>>>> index 0a62dce..644aa4a 100644
>>>>>>>> --- a/content.tex
>>>>>>>> +++ b/content.tex
>>>>>>>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
>>>>>>>>  \hline
>>>>>>>>  45         &   SPI master \\
>>>>>>>>  \hline
>>>>>>>> +46         &   TEE device \\
>>>>>>>> +\hline
>>>>>>>> \end{tabular}
>>>>>>>>
>>>>>>>>  Some of the devices above are unspecified by this document,

--===============5109005730543555379==--

