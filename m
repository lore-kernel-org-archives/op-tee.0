From: Shyam Saini <shyamsaini@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [RFC, PATCH 1/1] rpmb: add Replay Protected Memory Block (RPMB) driver
Date: Tue, 22 Aug 2023 18:47:55 +0000
Message-ID: <21d6a9e1-a742-6fb-9f23-2418c49ae2f@linux.microsoft.com>
In-Reply-To: <94728786-b41b-1467-63c1-8e2d5acfa5e4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6875220978216724350=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6875220978216724350==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit



Hi Jerome,

>
>
> On 8/17/23 01:31, Shyam Saini wrote:
>>
>> Hi Ulf,
>>
>>> On Sat, 22 Jul 2023 at 03:41, Shyam Saini
>>> <shyamsaini@linux.microsoft.com> wrote:
>>>>
>>>> From: Alex Bennée <alex.bennee@linaro.org>
>>>>
>>>> [This is patch 1 from [1] Alex's submission and this RPMB layer was
>>>> originally proposed by [2]Thomas Winkler ]
>>>>
>>>> A number of storage technologies support a specialised hardware
>>>> partition designed to be resistant to replay attacks. The underlying
>>>> HW protocols differ but the operations are common. The RPMB partition
>>>> cannot be accessed via standard block layer, but by a set of specific
>>>> commands: WRITE, READ, GET_WRITE_COUNTER, and PROGRAM_KEY. Such a
>>>> partition provides authenticated and replay protected access, hence
>>>> suitable as a secure storage.
>>>>
>>>> The initial aim of this patch is to provide a simple RPMB Driver which
>>>> can be accessed by Linux's optee driver to facilitate fast-path for
>>>> RPMB access to optee OS(secure OS) during the boot time. [1] Currently,
>>>> Optee OS relies on user-tee supplicant to access eMMC RPMB partition.
>>>>
>>>> A TEE device driver can claim the RPMB interface, for example, via
>>>> class_interface_register(). The RPMB driver provides a series of
>>>> operations for interacting with the device.
>>>
>>> I don't quite follow this. More exactly, how will the TEE driver know
>>> what RPMB device it should use?
>>
>> I don't have complete code to for this yet, but i think OP-TEE driver
>> should register with RPMB subsystem and then we can have eMMC/UFS/NVMe
>> specific implementation for RPMB operations.
>>
>> Linux optee driver can handle RPMB frames and pass it to RPMB subsystem
>>
>> [1] U-Boot has mmc specific implementation
>>
>> I think OPTEE-OS has CFG_RPMB_FS_DEV_ID option
>> CFG_RPMB_FS_DEV_ID=1 for /dev/mmcblk1rpmb,
>
> Correct. Note that tee-supplicant will ignore this device ID if --rmb-cid
> is given and use the specified RPMB instead (the CID is a non-ambiguous way
> to identify a RPMB device).

Thanks, but we may still need to address with multiple RPMB 
targets/regions in case of UFS/NVMe.

>> but in case if a
>> system has multiple RPMB devices such as UFS/eMMC/NVMe, one them
>> should be declared as secure storage and optee should access that one only.
>
> Indeed, that would be an equivalent of tee-supplicant's --rpmb-cid.
>
>> Sumit, do you have suggestions for this ?

--===============6875220978216724350==--

