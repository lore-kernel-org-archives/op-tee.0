From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Tue, 22 Aug 2023 19:07:05 +0000
Message-ID: <226aa02d-1247-a42c-123d-1c86b6b43d9f@linux.microsoft.com>
In-Reply-To: <
 <CAFA6WYMPsBUutjKrm+6qTNHpVr80K2GcSLoYa+MFE3CfLSo8ew@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1547253017565718639=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1547253017565718639==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> On Mon, 21 Aug 2023 at 17:26, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>>
>> On Mon, 21 Aug 2023 at 14:19, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
>>>
>>> On Mon, Aug 21, 2023 at 12:03=E2=80=AFPM Sumit Garg <sumit.garg@linaro.=
org> wrote:
>>>>
>>>> On Mon, 21 Aug 2023 at 15:19, Jerome Forissier
>>>> <jerome.forissier@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 8/17/23 01:31, Shyam Saini wrote:
>>>>>>
>>>>>> Hi Ulf,
>>>>>>
>>>>>>> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
>>>>>>> <shyamsaini@linux.microsoft.com> wrote:
>>>>>>>>
>>>>>>>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>>>>>
>>>>>>>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
>>>>>>>> originally proposed by [2]Thomas Winkler ]
>>>>>>>>
>>>>>>>> A number of storage technologies support a specialised hardware
>>>>>>>> partition designed to be resistant to replay attacks. The underlying
>>>>>>>> HW protocols differ but the operations are common. The RPMB partition
>>>>>>>> cannot be accessed via standard block layer, but by a set of specific
>>>>>>>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
>>>>>>>> partition provides authenticated and replay protected access, hence
>>>>>>>> suitable as a secure storage.
>>>>>>>>
>>>>>>>> The initial aim of this patch is to provide a simple RPMB Driver whi=
ch
>>>>>>>> can be accessed by Linux's optee driver to facilitate fast-path for
>>>>>>>> RPMB access to optee OS(secure OS) during the boot time. [1] Current=
ly,
>>>>>>>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
>>>>>>>>
>>>>>>>> A TEE device driver can claim the RPMB interface, for example, via
>>>>>>>> class_interface_register(). The RPMB driver provides a series of
>>>>>>>> operations for interacting with the device.
>>>>>>>
>>>>>>> I don't quite follow this. More exactly, how will the TEE driver know
>>>>>>> what RPMB device it should use?
>>>>>>
>>>>>> I don't have complete code to for this yet, but i think OP-TEE driver
>>>>>> should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
>>>>>> specific implementation for RPMB operations.
>>>>>>
>>>>>> Linux optee driver can handle RPMB frames and pass it to RPMB subsystem
>>>>>>
>>>>
>>>> It would be better to have this OP-TEE use case fully implemented. So
>>>> that we can justify it as a valid user for this proposed RPMB
>>>> subsystem. If you are looking for any further suggestions then please
>>>> let us know.
>>>
>>> +1
>>>
>>>>
>>>>>> [1] U-Boot has mmc specific implementation
>>>>>>
>>>>>> I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
>>>>>> CFG_RPMB_FS_DEV_ID=3D1 for /dev/mmcblk1rpmb,
>>>>>
>>>>> Correct. Note that tee-supplicant will ignore this device ID if --rmb-c=
id
>>>>> is given and use the specified RPMB instead (the CID is a non-ambiguous=
 way
>>>>> to identify a RPMB device).
>>>>>
>>>>>> but in case if a
>>>>>> system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
>>>>>> should be declared as secure storage and optee should access that one =
only.
>>>>>
>>>>> Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
>>>>>
>>>>>> Sumit, do you have suggestions for this ?
>>>>>
>>>>
>>>> I would suggest having an OP-TEE secure DT property that would provide
>>>> the RPMB CID which is allocated to the secure world.
>>>
>>> Another option is for OP-TEE to iterate over all RPMBs with a
>>> programmed key and test if the key OP-TEE would use works. That should
>>> avoid the problem of provisioning a device-unique secure DTB. I'd
>>> expect that the RPMB key is programmed by a trusted provisioning tool
>>> since allowing OP-TEE to program the RPMB key has never been secure,
>>> not unless the OP-TEE binary is rollback protected.
>>
>> +1 to that.  Overall we shound't 'trust' to do the programming. For
>> example, in OP-TEE if you compile it with device programming
>> capabilities, you can easily convince OP-TEE to send you the symmetric
>> key by swapping the supplicant with a malicious application.
>>
>
> Agree, with your overall intent, that OP-TEE shouldn't expose RPMB key
> in plain form. But with suggested OP-TEE RPMB frames routing via
> kernel, tee-supplicant won't be used for RPMB accesses.

do we plan to disable access to RPMB devices, once we have this RPMB=20
driver in place. User space tools like mmc-utils/nvme/ufs utils
can still access RPMB and programme the key and should
RPMB driver deny access to RPMB ?

--===============1547253017565718639==--

