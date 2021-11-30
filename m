From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMD-TEE fix for v5.16
Date: Tue, 30 Nov 2021 08:03:51 +0100
Message-ID: <20211130070351.GA2308099@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0959386815759625410=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0959386815759625410==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix which takes care of a bug where
IS_ERR() was used instead of a NULL check for the return value from
__get_free_pages().

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/amdtee-fix-fo=
r-v5.16

for you to fetch changes up to 9d7482771fac8d8e38e763263f2ca0ca12dd22c6:

  tee: amdtee: fix an IS_ERR() vs NULL bug (2021-11-29 09:55:49 +0100)

----------------------------------------------------------------
AMD-TEE fix IS_ERR() bug

----------------------------------------------------------------
Dan Carpenter (1):
      tee: amdtee: fix an IS_ERR() vs NULL bug

 drivers/tee/amdtee/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--===============0959386815759625410==--

