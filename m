From: Dhananjay Phadke <dphadke@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/2] optee: fix OOM seen due to tee_shm_free()
Date: Thu, 18 Feb 2021 10:12:38 -0800
Message-ID: <1613671958-1307-1-git-send-email-dphadke@linux.microsoft.com>
In-Reply-To: <20210217092714.121297-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5327866715947014947=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5327866715947014947==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Allen Pais <apais@linux.microsoft.com>

On Wed, 17 Feb 2021 14:57:12 +0530, Allen Pais wrote:
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

CC: linux-kernel(a)vger.kernel.org instead of linux-mips?
TEE / TrustZone is ARM.

Also, for Broadcom specific -
CC: bcm-kernel-feedback-list(a)broadcom.com


--===============5327866715947014947==--

