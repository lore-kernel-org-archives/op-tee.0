From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix possible memory leak OP-TEE driver for v6.1
Date: Fri, 18 Nov 2022 13:10:34 +0100
Message-ID: <Y3d2OuJ60U30OkZe@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8367126427371620267=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8367126427371620267==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch in the OP-TEE driver which fixes a possible
memory leak in the error path of optee_register_device().

Thanks,
Jens

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-f=
or-6.1

for you to fetch changes up to cce616e012c215d65c15e5d1afa73182dea49389:

  tee: optee: fix possible memory leak in optee_register_device() (2022-11-17=
 09:22:12 +0100)

----------------------------------------------------------------
Fix possible memory leak in optee_register_device()

----------------------------------------------------------------
Yang Yingliang (1):
      tee: optee: fix possible memory leak in optee_register_device()

 drivers/tee/optee/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--===============8367126427371620267==--

