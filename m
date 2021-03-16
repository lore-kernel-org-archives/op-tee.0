From: Allen Pais <apais@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/2] optee: fix tee out of memory failure seen during
 kexec reboot
Date: Tue, 16 Mar 2021 18:51:03 +0530
Message-ID: <9a6c017c-d156-f939-f907-d6dfe83c41ac@linux.microsoft.com>
In-Reply-To: <
 <CAHUa44F5Ew6U80t7PPmV1J4KunXBm_izBxVrxg=x8azjBz0r9Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7572408197450474242=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7572408197450474242==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit



>>
>> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
>> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>>
>> tee_shm_release() is not invoked on dma shm buffer.
>>
>> Implement .shutdown() method to handle the release of the buffers
>> correctly.
>>
>> More info:
>> https://github.com/OP-TEE/optee_os/issues/3637
>>
>> Signed-off-by: Allen Pais <apais@linux.microsoft.com>
>> ---
>>   drivers/tee/optee/core.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
> 
> This looks good to me. Do you have a practical way of testing this on
> QEMU for instance?
> 

Jens,

   I could not reproduce nor create a setup using QEMU, I could only
do it on a real h/w.

   I have extensively tested the fix and I don't see any issues.

Thanks.

--===============7572408197450474242==--

