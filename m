From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix OP-TEE compiler warning for v5.19
Date: Mon, 30 May 2022 13:26:12 +0200
Message-ID: <20220530112612.GA1511426@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7546119952108804879=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7546119952108804879==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch which fixes a compiler warning in the OP-TEE
driver.

Note that this pull request is on top of and earlier accepted/applied [1]
pull request in order to avoid a merge conflict.

Thanks,
Jens

[1] https://lore.kernel.org/lkml/20220503192916.GA3288817(a)jade/

The following changes since commit 3e47235eaee09488c7e467b9aaccb7c93c862c6b:

  tee: make tee_shm_register_kernel_buf vmalloc supported (2022-04-05 08:04:1=
6 +0200)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-warn=
ing-for-v5.19

for you to fetch changes up to a3b9ecc805e9131476c719111fe347c7dbc0d1d1:

  tee: optee: Pass a pointer to virt_addr_valid() (2022-05-30 08:06:45 +0200)

----------------------------------------------------------------
Fix a compiler warning in OP-TEE driver

----------------------------------------------------------------
Linus Walleij (1):
      tee: optee: Pass a pointer to virt_addr_valid()

 drivers/tee/optee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--===============7546119952108804879==--

