From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE tracepoints fix for v5.13
Date: Tue, 30 Mar 2021 10:22:08 +0200
Message-ID: <20210330082208.GA965793@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4061376666320269292=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4061376666320269292==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

The previous pull request for OP-TEE tracepoints introduced a build
error when building whithout O=3D..., apparently many regression builds
uses that option.

Please pull this small fix for the build error.

Thanks,
Jens

The following changes since commit 0101947dbcc3204f08fb5b69a21dbd4b1535cad6:

  tee: optee: add invoke_fn tracepoints (2021-03-15 12:04:01 +0100)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-tracep=
oints-fix-for-v5.13

for you to fetch changes up to 7ccdcaace80810175bd20b2ece856b42edd43991:

  tee: optee: fix build error caused by recent optee tracepoints feature (202=
1-03-30 09:33:33 +0200)

----------------------------------------------------------------
Fixes build error for recently added OP-TEE tracepoints

----------------------------------------------------------------
Jisheng Zhang (1):
      tee: optee: fix build error caused by recent optee tracepoints feature

 drivers/tee/optee/Makefile | 3 +++
 1 file changed, 3 insertions(+)

--===============4061376666320269292==--

