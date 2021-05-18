From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v5.13
Date: Tue, 18 May 2021 12:07:12 +0200
Message-ID: <20210518100712.GA449561@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0825777993088709599=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0825777993088709599==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix which uses export_uuid() to copy
the client UUID instead of making asumptions about the internal format of
uuid_t.

Thanks,
Jens

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for=
-v5.13

for you to fetch changes up to 673c7aa2436bfc857b92417f3e590a297c586dde:

  optee: use export_uuid() to copy client UUID (2021-05-18 07:59:27 +0200)

----------------------------------------------------------------
OP-TEE use export_uuid() to copy UUID

----------------------------------------------------------------
Jens Wiklander (1):
      optee: use export_uuid() to copy client UUID

 drivers/tee/optee/call.c      | 6 ++++--
 drivers/tee/optee/optee_msg.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

--===============0825777993088709599==--

