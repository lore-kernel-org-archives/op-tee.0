From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE fix for v5.10
Date: Tue, 13 Oct 2020 09:09:18 +0200
Message-ID: <20201013070918.GA3328976@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7546265786810921548=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7546265786810921548==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small fix which reenables the kernel login method in the
kernel internal TEE client API. This fixes a problem introduced in v5.8.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-fix-for-=
v5.10

for you to fetch changes up to 722939528a37aa0cb22d441e2045c0cf53e78fb0:

  tee: client UUID: Skip REE kernel login method as well (2020-10-13 08:42:11=
 +0200)

----------------------------------------------------------------
Reenable kernel login method for kernel TEE client API

The kernel TEE login method was accidentally disabled previously when
enabling a few other login methods, so fix that here.

----------------------------------------------------------------
Sumit Garg (1):
      tee: client UUID: Skip REE kernel login method as well

 drivers/tee/tee_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--===============7546265786810921548==--

