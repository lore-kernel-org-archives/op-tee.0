From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/3] Introduce DMA APIs to allocate and free TEE shared memory
Date: Wed, 25 Oct 2023 12:26:57 +0530
Message-ID: <20231025065700.1556152-1-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4605338865552180439=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4605338865552180439==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Jeshwanth Kumar N K <JESHWANTHKUMAR.NK@amd.com>

At present, the shared memory for TEE ring buffer, command buffer and
data buffer is allocated using get_free_pages(). The driver shares the
physical address of these buffers with PSP so that it can be mapped by
the Trusted OS.

In this patch series we have replaced get_free_pages() with
dma_alloc_coherent() to allocate shared memory to cleanup the existing
allocation method.

Rijo Thomas (3):
  crypto: ccp - Add function to allocate and free memory using DMA APIs
  crypto: ccp - Use psp_tee_alloc_buffer() and psp_tee_free_buffer()
  tee: amdtee: Use psp_tee_alloc_buffer() and psp_tee_free_buffer()

 drivers/crypto/ccp/psp-dev.c        |   3 +
 drivers/crypto/ccp/tee-dev.c        | 119 ++++++++++++++++++----------
 drivers/crypto/ccp/tee-dev.h        |  11 +--
 drivers/tee/amdtee/amdtee_private.h |  18 ++---
 drivers/tee/amdtee/call.c           |  74 ++++++++---------
 drivers/tee/amdtee/core.c           |  72 ++++++++++-------
 drivers/tee/amdtee/shm_pool.c       |  21 ++---
 include/linux/psp-tee.h             |  47 +++++++++++
 8 files changed, 221 insertions(+), 144 deletions(-)

-- 
2.25.1


--===============4605338865552180439==--

