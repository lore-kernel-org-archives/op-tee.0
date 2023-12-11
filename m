From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE kernel private shared memory optimizations for 6.8
Date: Mon, 11 Dec 2023 12:58:15 +0100
Message-ID: <20231211115815.GA616539@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0183869118227806825=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0183869118227806825==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these two patches that optmize how the OP-TEE driver private
shared memory allocated as dynamic shared memory.

Thanks,
Jens

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/kern-priv-s=
hm-for-v6.8

for you to fetch changes up to 225a36b96359aceaa9a6399f2dff99627397e637:

  optee: allocate shared memory with alloc_pages_exact() (2023-12-04 14:48:42=
 +0100)

----------------------------------------------------------------
OP-TEE kernel private shared memory optimizations

Optimize OP-TEE driver private shared memory allocated as dynamic shared
memory. Both to handle larger than one page allocations and for more
efficient memory usage.

----------------------------------------------------------------
Jens Wiklander (2):
      optee: add page list to kernel private shared memory
      optee: allocate shared memory with alloc_pages_exact()

 drivers/tee/optee/core.c    | 44 +++++++++++++++++++++++---------------------
 drivers/tee/optee/smc_abi.c | 45 +++++++++++++++++++++----------------------=
--
 2 files changed, 44 insertions(+), 45 deletions(-)

--===============0183869118227806825==--

