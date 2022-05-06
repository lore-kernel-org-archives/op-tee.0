From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE Cleanup for v5.19
Date: Fri, 06 May 2022 09:03:28 +0200
Message-ID: <20220506070328.GA1344495@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2201174222163578832=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2201174222163578832==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these small cleanup patches which removes two unused and
outdated TEE_IOCTL_SHM_* flags and two unused pa2va and va2pa functions for
tee_shm's.=20

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-cleanup=
-for-v5.19

for you to fetch changes up to d8fc1c7c4c9b705ce5f5bba772ad66a0137c685d:

  tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF (2022-04-2=
6 10:17:03 +0200)

----------------------------------------------------------------
TEE cleanup

Removes the old and unused TEE_IOCTL_SHM_* flags
Removes unused the unused tee_shm_va2pa() and tee_shm_pa2va() functions

----------------------------------------------------------------
Andrew Davis (2):
      tee: remove tee_shm_va2pa() and tee_shm_pa2va()
      tee: remove flags TEE_IOCTL_SHM_MAPPED and TEE_IOCTL_SHM_DMA_BUF

 drivers/tee/tee_core.c   |  2 --
 drivers/tee/tee_shm.c    | 50 ----------------------------------------------=
--
 include/linux/tee_drv.h  | 18 -----------------
 include/uapi/linux/tee.h |  4 ----
 4 files changed, 74 deletions(-)

--===============2201174222163578832==--

