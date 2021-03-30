From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE memref size check for v5.13
Date: Tue, 30 Mar 2021 13:00:37 +0200
Message-ID: <20210330110037.GA1166563@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8968326259559655378=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8968326259559655378==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch for the OP-TEE driver to remove the invalid
size check of outgoing memref parameters. This code path is only
activated for a certain configuration of OP-TEE in secure world
(CFG_CORE_DYN_SHM=3Dn) so this problem isn't always visible.

Thanks,
Jens

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-memref=
-size-for-v5.13

for you to fetch changes up to c650b8dc7a7910eb25af0aac1720f778b29e679d:

  tee: optee: do not check memref size on return from Secure World (2021-03-3=
0 10:44:50 +0200)

----------------------------------------------------------------
OP-TEE skip check of returned memref size

----------------------------------------------------------------
Jerome Forissier (1):
      tee: optee: do not check memref size on return from Secure World

 drivers/tee/optee/core.c | 10 ----------
 1 file changed, 10 deletions(-)

--===============8968326259559655378==--

