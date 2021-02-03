From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v5.12
Date: Wed, 03 Feb 2021 13:09:53 +0100
Message-ID: <20210203120953.GB3624453@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3487072591834605980=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3487072591834605980==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small fix removing an unnecessary call to need_resched()
before cond_resched() while the OP-TEE driver is handing a RPC.

Thanks,
Jens

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-fix-co=
nd-resched-call-for-v5.12

for you to fetch changes up to 958567600517fd15b7f35ca1a8be0104f0eb0686:

  tee: optee: remove need_resched() before cond_resched() (2021-02-03 08:11:1=
1 +0100)

----------------------------------------------------------------
Remove unnecessary need_resched() before cond_resched()

----------------------------------------------------------------
Jens Wiklander (1):
      tee: optee: remove need_resched() before cond_resched()

Rouven Czerwinski (1):
      tee: optee: replace might_sleep with cond_resched

 drivers/tee/optee/call.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--===============3487072591834605980==--

