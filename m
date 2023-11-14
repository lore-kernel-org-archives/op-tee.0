From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 0/2] OP-TEE kernel private shared memory optimizations
Date: Tue, 14 Nov 2023 10:52:15 +0100
Message-ID: <20231114095217.1142360-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8601950046081073311=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8601950046081073311==
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

v2->v3:
* Simplified optee_pool_op_alloc_helper() by always doing the same thing

Thanks,
Jens

Jens Wiklander (2):
  optee: add page list to kernel private shared memory
  optee: allocate shared memory with alloc_pages_exact()

 drivers/tee/optee/core.c    | 44 +++++++++++++++++++-----------------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++--------------------
 2 files changed, 44 insertions(+), 45 deletions(-)


base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.34.1


--===============8601950046081073311==--

