From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMD-TEE fix for v5.13
Date: Wed, 05 May 2021 13:08:50 +0200
Message-ID: <20210505110850.GA3434209@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1537182023564335286=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1537182023564335286==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix which adds reference counting to
loaded TAs which is needed for proper life cycle management of TAs.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/amdtee-fixes-=
for-v5.13

for you to fetch changes up to 9f015b3765bf593b3ed5d3b588e409dc0ffa9f85:

  tee: amdtee: unload TA only when its refcount becomes 0 (2021-05-05 13:00:1=
1 +0200)

----------------------------------------------------------------
AMD-TEE reference count loaded TAs

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: unload TA only when its refcount becomes 0

 drivers/tee/amdtee/amdtee_private.h | 13 +++++
 drivers/tee/amdtee/call.c           | 94 +++++++++++++++++++++++++++++++++--=
--
 drivers/tee/amdtee/core.c           | 15 +++---
 3 files changed, 106 insertions(+), 16 deletions(-)

--===============1537182023564335286==--

