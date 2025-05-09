From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE updates for 6.16
Date: Fri, 09 May 2025 08:51:14 +0200
Message-ID: <20250509065114.GA4188600@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3800464009768715089=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3800464009768715089==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull two small small patches for the TEE subsystem and OP-TEE driver.

Thanks,
Jens

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/t=
ee-for-v6.16

for you to fetch changes up to 39bb67edcc582b3b386a9ec983da67fa8a10ec03:

  tee: Prevent size calculation wraparound on 32-bit kernels (2025-04-30 14:5=
7:03 +0200)

----------------------------------------------------------------
Small TEE updates for v6.16

- Remove an unnecessary NULL check before release_firmware() in the
  OP-TEE driver
- Prevent a size wrap in the TEE subsystem. The wrap would have been caught
  later in the code so no security consequences.

----------------------------------------------------------------
Chen Ni (1):
      tee: optee: smc: remove unnecessary NULL check before release_firmware()

Jann Horn (1):
      tee: Prevent size calculation wraparound on 32-bit kernels

 drivers/tee/optee/smc_abi.c |  3 +--
 drivers/tee/tee_core.c      | 11 ++++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

--===============3800464009768715089==--

