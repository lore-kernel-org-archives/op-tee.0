From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [[GIT PULL] OP-TEE fix for v5.18
Date: Wed, 13 Apr 2022 07:20:01 +0200
Message-ID: <20220413052001.GA49798@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0503108298145175108=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0503108298145175108==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix for the error handling path in
the FF-A probe function.

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for=
-v5.18

for you to fetch changes up to b5e22886839ae466fcf03295150094516c0fd8eb:

  tee: optee: add missing mutext_destroy in optee_ffa_probe (2022-04-05 08:56=
:26 +0200)

----------------------------------------------------------------
OP-TEE fix missing mutex_destroy in probe error handling path

----------------------------------------------------------------
Dongliang Mu (1):
      tee: optee: add missing mutext_destroy in optee_ffa_probe

 drivers/tee/optee/ffa_abi.c | 1 +
 1 file changed, 1 insertion(+)

--===============0503108298145175108==--

