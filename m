From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE driver for v5.11
Date: Wed, 25 Nov 2020 13:01:34 +0100
Message-ID: <20201125120134.GA1642471@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8787635371803319772=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8787635371803319772==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch which allows the OP-TEE driver to work with
ARMv7 based single CPU systems.

Thanks,
Jens

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-valid-m=
emory-type-for-v5.11

for you to fetch changes up to 853735e404244f5496cdb6188c5ed9a0f9627ee6:

  optee: add writeback to valid memory type (2020-11-25 12:51:52 +0100)

----------------------------------------------------------------
Add writeback to valid OP-TEE shared memory types

Allows OP-TEE to work with ARMv7 based single CPU systems by allowing
writeback cache policy for shared memory.

----------------------------------------------------------------
Rui Miguel Silva (1):
      optee: add writeback to valid memory type

 drivers/tee/optee/call.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--===============8787635371803319772==--

