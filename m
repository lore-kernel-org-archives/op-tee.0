From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Use kmemdup() in OP-TEE driver for v6.5
Date: Thu, 15 Jun 2023 15:00:49 +0200
Message-ID: <20230615130049.GA979203@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6905102498418768937=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6905102498418768937==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch to the OP-TEE driver that replaces
kmalloc() + memcpy() with kmemdup() at one place.

Thanks,
Jens

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-use-k=
memdup-for-6.5

for you to fetch changes up to 6a8b7e80105416cc7324fda295608ea2d3f98862:

  tee: optee: Use kmemdup() to replace kmalloc + memcpy (2023-06-15 08:49:55 =
+0200)

----------------------------------------------------------------
Use kmemdup() in OP-TEE driver

----------------------------------------------------------------
Jiapeng Chong (1):
      tee: optee: Use kmemdup() to replace kmalloc + memcpy

 drivers/tee/optee/smc_abi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--===============6905102498418768937==--

