From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
Date: Tue, 13 Jun 2023 00:49:19 +0000
Message-ID: <f078ddef-8654-4e18-fd1f-8b81f8f2aabd@linux.microsoft.com>
In-Reply-To: <
 <CAC_iWjLOhUvp5ggCCkHN5MRNfB_h6FZ2Z14yrtR3aqGn0Ovxig@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3919478477566097733=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3919478477566097733==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Thank you everyone for your valueable feedback.

Alex, are you planning submit this patch series ?
Please let me know.

> On Thu, 1 Jun 2023 at 08:49, Sumit Garg <sumit.garg@linaro.org> wrote:
>>
>> On Thu, 1 Jun 2023 at 11:02, Ilias Apalodimas
>> <ilias.apalodimas@linaro.org> wrote:
>>>
>>> Hi Bing
>>>
>>> On Thu, 1 Jun 2023 at 04:03, Zhu, Bing <bing.zhu@intel.com> wrote:
>>>>
>>>> As an alternative, Is it possible to change ftpm design not to depend on=
 RPMB access at the earlier/boot stage? Because to my understanding, typicall=
y PCRs don't require persistent/NV storage (for example, before RPMB or tee-s=
upplicant is ready, use TEE memory instead as temporary storage)
>>>
>>> I am not entirely sure this will solve our problem here.  You are
>>> right that we shouldn't depend on the supplicant to extend PCRs. But
>>> what happens if an object is sealed against certain PCR values?  We
>>> are back to the same problem
>>
>> +1
>>
>> Temporary storage may be a stop gap solution for some use-cases but
>> having a fast path access to RPMB via kernel should be our final goal.
>> I would suggest we start small with the MMC subsystem to expose RPMB
>> access APIs for OP-TEE driver rather than a complete RPMB subsystem.
>
> I discussed with the OP-TEE maintainers about adding parts of the
> supplicant in the kernel.  The supplicant 'just' sends an ioctl to
> store/read stuff anyway.  So it would make sense to have a closer and
> see if that looks reasonable.
> Thanks
>
> /Ilias
>
>>
>> -Sumit
>>
>>>
>>> Thanks
>>> /Ilias
>>>>
>>>> Bing
>>>>
>>>> IPAS Security Brown Belt (https://www.credly.com/badges/69ea809f-3a96-4b=
c7-bb2f-442c1b17af26)
>>>> System Software Engineering
>>>> Software and Advanced Technology Group
>>>> Zizhu Science Park, Shanghai, China
>>>>
>>>> -----Original Message-----
>>>> From: Shyam Saini <shyamsaini@linux.microsoft.com>
>>>> Sent: Thursday, June 1, 2023 3:10 AM
>>>> To: alex.bennee(a)linaro.org
>>>> Cc: code(a)tyhicks.com; Matti.Moell(a)opensynergy.com; arnd(a)linaro.org=
; Zhu, Bing <bing.zhu@intel.com>; hmo(a)opensynergy.com; ilias.apalodimas(a=
)linaro.org; joakim.bech(a)linaro.org; linux-kernel(a)vger.kernel.org; linux-=
mmc(a)vger.kernel.org; linux-scsi(a)vger.kernel.org; maxim.uvarov(a)linaro.or=
g; ruchika.gupta(a)linaro.org; Winkler, Tomas <tomas.winkler@intel.com>; ul=
f.hansson(a)linaro.org; Huang, Yang <yang.huang@intel.com>; sumit.garg(a)li=
naro.org; jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org
>>>> Subject: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
>>>>
>>>> Hi Alex,
>>>>
>>>> [ Resending, Sorry for the noise ]
>>>>
>>>> Are you still working on it or planning to resubmit it ?
>>>>
>>>> [1] The current optee tee kernel driver implementation doesn't work when=
 IMA is used with optee implemented ftpm.
>>>>
>>>> The ftpm has dependency on tee-supplicant which comes once the user spac=
e is up and running and IMA attestation happens at boot time and it requires =
to extend ftpm PCRs.
>>>>
>>>> But IMA can't use PCRs if ftpm use secure emmc RPMB partition. As optee =
can only access RPMB via tee-supplicant(user space). So, there should be a fa=
st path to allow optee os to access the RPMB parititon without waiting for us=
er-space tee supplicant.
>>>>
>>>> To achieve this fast path linux optee driver and mmc driver needs some w=
ork and finally it will need RPMB driver which you posted.
>>>>
>>>> Please let me know what's your plan on this.
>>>>
>>>> [1] https://optee.readthedocs.io/en/latest/architecture/secure_storage.h=
tml
>>>>
>>>> Best Regards,
>>>> Shyam
>

--===============3919478477566097733==--

