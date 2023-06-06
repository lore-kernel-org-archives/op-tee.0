From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMDTEE fix for v6.5
Date: Tue, 06 Jun 2023 09:58:43 +0200
Message-ID: <20230606075843.GA2792442@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6662586746696005766=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6662586746696005766==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix to add a return origin field to the
struct tee_cmd_load_ta used when loading a Trusted Application into the
AMDTEE. This change is backward compatible.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/amdtee-fix-=
for-v6.5

for you to fetch changes up to 436eeae0411acdfc54521ddea80ee76d4ae8a7ea:

  tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta' (2023-05-15 08:2=
9:52 +0200)

----------------------------------------------------------------
AMDTEE add return origin to load TA command

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

 drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
 drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
 2 files changed, 23 insertions(+), 17 deletions(-)

--===============6662586746696005766==--

