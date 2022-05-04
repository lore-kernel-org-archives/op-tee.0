From: Sudeep Holla <sudeep.holla@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] firmware: arm_ffa: Updates for v5.19
Date: Wed, 04 May 2022 12:28:53 +0100
Message-ID: <20220504112853.3491961-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4098893122641222920=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4098893122641222920==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi ARM SoC Team,

Please pull !

Regards,
Sudeep

-->8

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/f=
fa-updates-5.19

for you to fetch changes up to f3f3bdbd58cea4fdd088075fdc8864fc47ecd419:

  tee: optee: Use ffa_dev_get_drvdata to fetch driver_data (2022-04-29 14:51:=
46 +0100)

----------------------------------------------------------------
Arm FF-A firmware driver updates/fixes for v5.19

Couple of fixes to handle fragmented memory descriptors and incorrect
UUID parameter passed to ffa_partition_probe. Another fix deals with
the incorrect use of ffa_device's driver_data by the core driver.
Apart from these fixes, there is an addition of ffa_dev_get_drvdata helper
function and its use in optee driver.

----------------------------------------------------------------
Marc Bonnici (1):
      firmware: arm_ffa: Fix handling of fragmented memory descriptors

Sudeep Holla (4):
      firmware: arm_ffa: Fix uuid parameter to ffa_partition_probe
      firmware: arm_ffa: Remove incorrect assignment of driver_data
      firmware: arm_ffa: Add ffa_dev_get_drvdata helper function
      tee: optee: Use ffa_dev_get_drvdata to fetch driver_data

 drivers/firmware/arm_ffa/driver.c | 24 ++++++++++++++----------
 drivers/tee/optee/ffa_abi.c       |  2 +-
 include/linux/arm_ffa.h           |  7 ++++++-
 3 files changed, 21 insertions(+), 12 deletions(-)

--===============4098893122641222920==--

