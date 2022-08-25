From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix TEE system compiler warning fo4r v6.0
Date: Thu, 25 Aug 2022 11:57:05 +0200
Message-ID: <YwdHcdEUib7obbbW@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6992508155400648471=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6992508155400648471==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch which fixes a recently introduced compiler
warning the TEE subsystem.

Thanks,
Jens

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-fix-for=
-v6.0

for you to fetch changes up to eccd7439709810127563e7e3e49b8b44c7b2791d:

  tee: fix compiler warning in tee_shm_register() (2022-08-25 11:40:06 +0200)

----------------------------------------------------------------
Add a missing include in the TEE subsystem

----------------------------------------------------------------
Jens Wiklander (1):
      tee: fix compiler warning in tee_shm_register()

 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)

--===============6992508155400648471==--

