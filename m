From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMDTEE simplification for v5.18
Date: Fri, 18 Feb 2022 18:56:32 +0100
Message-ID: <20220218175632.GA926082@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2165355670186594091=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2165355670186594091==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small AMDTEE driver simplification to use the LIST_HEAD()
macro instead for a global variable.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/amdtee-for-v=
5.18

for you to fetch changes up to f7b67642dd98617dc569836cdcba041c7ff00cbb:

  tee: amdtee: Make use of the helper macro LIST_HEAD() (2022-02-14 10:57:55 =
+0100)

----------------------------------------------------------------
Small simplification in AMDTE driver

----------------------------------------------------------------
Cai Huoqing (1):
      tee: amdtee: Make use of the helper macro LIST_HEAD()

 drivers/tee/amdtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--===============2165355670186594091==--

