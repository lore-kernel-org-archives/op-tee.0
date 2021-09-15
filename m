From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for v5.15
Date: Wed, 15 Sep 2021 13:38:13 +0200
Message-ID: <20210915113813.GA509196@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8842338795944698143=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8842338795944698143==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small OP-TEE driver fix for the shared memory pool
handler. The fix doesn't change the generated code, but it's still relevant
since the problem obviously triggers warnings with some tools.

Thanks,
Jens

The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-for=
-v5.15

for you to fetch changes up to 88a3856c0a8c03188db7913f4d49379432fe1f93:

  tee/optee/shm_pool: fix application of sizeof to pointer (2021-09-14 07:54:=
56 +0200)

----------------------------------------------------------------
Fix OP-TEE shm_pool lint warning

----------------------------------------------------------------
jing yangyang (1):
      tee/optee/shm_pool: fix application of sizeof to pointer

 drivers/tee/optee/shm_pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--===============8842338795944698143==--

