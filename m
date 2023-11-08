From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/2] OP-TEE kernel private shared memory optimizations
Date: Wed, 08 Nov 2023 11:27:53 +0100
Message-ID: <20231108102755.93079-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5618241505380477787=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5618241505380477787==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

This patch set optimizes OP-TEE driver private shared memory allocated as
dynamic shared memory (not from the static shared memory pool). The first
patch handles kernel private RPC allocatations larger than one page and the
second changes from alloc_pages_exact() instead of alloc_pages() for more
efficient memory usage.

v1->v2:
* Split into two patches as requested

Jens Wiklander (2):
  optee: add page list to kernel private shared memory
  optee: allocate shared memory with alloc_pages_exact()

 drivers/tee/optee/core.c    | 59 +++++++++++++++++++++++++------------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++---------------
 2 files changed, 61 insertions(+), 43 deletions(-)


base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.34.1


--===============5618241505380477787==--

