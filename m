From: Allen Pais <apais@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 0/2] optee: fix OOM seen due to tee_shm_free()
Date: Tue, 23 Feb 2021 11:47:20 +0530
Message-ID: <7ed919a9-2ef3-95f3-3bf4-70961a18656a@linux.microsoft.com>
In-Reply-To: <20210217092714.121297-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7124322825520525453=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7124322825520525453==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


> 
> The following out of memory errors are seen on kexec reboot
> from the optee core.
>      
> [    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
> [    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
>      
> tee_shm_release() is not invoked on dma shm buffer.
>      
> Implement .shutdown() in optee core as well as bnxt firmware driver
> to handle the release of the buffers correctly.
>      
> More info:
> https://github.com/OP-TEE/optee_os/issues/3637

Jens,

   Could you please take sometime out and review the series.

Thanks.

> 
> Allen Pais (2):
>    optee: fix tee out of memory failure seen during kexec reboot
>    firmware: tee_bnxt: implement shutdown method to handle kexec reboots
> 
>   drivers/firmware/broadcom/tee_bnxt_fw.c |  9 ++++
>   drivers/tee/optee/core.c                | 69 ++++++++++++++++++-------
>   2 files changed, 58 insertions(+), 20 deletions(-)
> 

--===============7124322825520525453==--

