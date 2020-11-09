From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMDTEE driver fixes for v5.10
Date: Mon, 09 Nov 2020 09:08:09 +0100
Message-ID: <20201109080809.GA3862873@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0020096775988306742=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0020096775988306742==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these AMDTEE driver fixes which are needed when opening multiple
contexts or file descriptors.

Note that this isn't a usual Arm driver update. This targets x86/AMD instead,
but is still part of the TEE subsystem.

Thanks,
Jens

The following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/amdtee-fixes=
-for-5.10

for you to fetch changes up to be353be27874f40837327d9a39e3ad2149ab66d3:

  tee: amdtee: synchronize access to shm list (2020-11-09 08:59:00 +0100)

----------------------------------------------------------------
AMD-TEE driver bug fixes

AMD-TEE driver keeps track of shared memory buffers and their
corresponding buffer id's in a global linked list. These buffers are
used to share data between x86 and AMD Secure Processor. This pull
request fixes issues related to maintaining mapped buffers in a shared
linked list.

----------------------------------------------------------------
Rijo Thomas (2):
      tee: amdtee: fix memory leak due to reset of global shm list
      tee: amdtee: synchronize access to shm list

 drivers/tee/amdtee/amdtee_private.h |  8 ++++----
 drivers/tee/amdtee/core.c           | 26 +++++++++++++++++++-------
 2 files changed, 23 insertions(+), 11 deletions(-)

--===============0020096775988306742==--

