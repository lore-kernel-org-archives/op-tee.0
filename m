From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE SHM vmalloc for v5.19
Date: Tue, 03 May 2022 21:29:16 +0200
Message-ID: <20220503192916.GA3288817@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6533140014115136734=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6533140014115136734==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this patch which enables tee_shm_register_kernel_buf() to
accept vmalloc()ed buffers.

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-shm-vma=
lloc-for-v5.19

for you to fetch changes up to 3e47235eaee09488c7e467b9aaccb7c93c862c6b:

  tee: make tee_shm_register_kernel_buf vmalloc supported (2022-04-05 08:04:1=
6 +0200)

----------------------------------------------------------------
TEE accept vmalloc()ed buffers for tee_shm_register_kernel_buf()

----------------------------------------------------------------
Phil Chang (1):
      tee: make tee_shm_register_kernel_buf vmalloc supported

 drivers/tee/optee/call.c |  2 +-
 drivers/tee/tee_shm.c    | 35 +++++++++++++++++++++++++----------
 2 files changed, 26 insertions(+), 11 deletions(-)

--===============6533140014115136734==--

