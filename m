From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 0/2] AMD-TEE driver bug fixes
Date: Wed, 04 Nov 2020 11:56:08 +0530
Message-ID: <cover.1604470183.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7367961041817648854=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7367961041817648854==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

AMD-TEE driver keeps track of shared memory buffers and their
corresponding buffer id's in a global linked list. These buffers are
used to share data between x86 and AMD Secure Processor. This patchset
fixes issues related to maintaining mapped buffers in a shared linked
list.

Rijo Thomas (2):
  tee: amdtee: fix memory leak due to reset of global shm list
  tee: amdtee: synchronize access to shm list

 drivers/tee/amdtee/amdtee_private.h |  8 ++++----
 drivers/tee/amdtee/core.c           | 26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 11 deletions(-)

--
2.17.1


--===============7367961041817648854==--

