From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE convert platform callback for v6.10
Date: Thu, 25 Apr 2024 09:28:35 +0200
Message-ID: <20240425072835.GA3258167@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0486285951720774767=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0486285951720774767==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maitainers,

Please pull this small patch converting the platform remove callback to
return void for the OP-TEE driver.

Thanks,
Jens

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-conv=
ert-platform-remove-callback-for-v6.10

for you to fetch changes up to 5c794301eb4e5373822e8898661bacdc7f46ba14:

  tee: optee: smc: Convert to platform remove callback returning void (2024-0=
3-25 11:51:06 +0100)

----------------------------------------------------------------
OP-TEE Convert to platform remove callback returning void

----------------------------------------------------------------
Uwe Kleine-K=C3=B6nig (1):
      tee: optee: smc: Convert to platform remove callback returning void

 drivers/tee/optee/smc_abi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--===============0486285951720774767==--

