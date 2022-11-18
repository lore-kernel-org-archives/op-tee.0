From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Add __init/__exit annotations OP-TEE driver for v6.2
Date: Fri, 18 Nov 2022 13:18:16 +0100
Message-ID: <Y3d4CHWl3Ofx5OrX@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5772902443702439717=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5772902443702439717==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch which adds __init/__exit annotations to the
OP-TEE driver module.

Thanks,
Jens

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-for-6=
.2

for you to fetch changes up to bd52407221b4702af690456b2b6006fa6440e893:

  optee: Add __init/__exit annotations to module init/exit funcs (2022-10-11 =
11:20:16 +0200)

----------------------------------------------------------------
Add missing __init/__exit annotations to OP-TEE driver

----------------------------------------------------------------
Xiu Jianfeng (1):
      optee: Add __init/__exit annotations to module init/exit funcs

 drivers/tee/optee/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--===============5772902443702439717==--

