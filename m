From: Allen Pais <allen.lkml@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/2] optee: fix OOM seen due to tee_shm_free()
Date: Thu, 25 Feb 2021 14:36:08 +0530
Message-ID: <20210225090610.242623-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6079416895975382139=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6079416895975382139==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Allen Pais <apais@linux.microsoft.com>

The following out of memory errors are seen on kexec reboot
from the optee core.
    
[    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
[    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22
    
tee_shm_release() is not invoked on dma shm buffer.
    
Implement .shutdown() in optee core as well as bnxt firmware driver
to handle the release of the buffers correctly.
    
More info:
https://github.com/OP-TEE/optee_os/issues/3637

v2:
  keep the .shutdown() method simple. [Jens Wiklander]

Allen Pais (2):
  optee: fix tee out of memory failure seen during kexec reboot
  firmware: tee_bnxt: implement shutdown method to handle kexec reboots

 drivers/firmware/broadcom/tee_bnxt_fw.c |  9 +++++++++
 drivers/tee/optee/core.c                | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.25.1


--===============6079416895975382139==--

