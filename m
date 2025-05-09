From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMD-TEE updates for 6.16
Date: Fri, 09 May 2025 08:58:33 +0200
Message-ID: <20250509065833.GB4188600@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0339851882246050331=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0339851882246050331==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these two small patches for the AMD-TEE driver.

Thanks,
Jens

The following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/a=
md-tee-for-v6.16

for you to fetch changes up to 136deca59b1613c22aebfb0c8508dd02363c7142:

  amdtee: Sort header includes (2025-04-29 10:57:57 +0200)

----------------------------------------------------------------
AMD-TEE driver updates for v6.16

- Sort header includes
- Use pr_fmt

----------------------------------------------------------------
Mario Limonciello (2):
      amdtee: Use pr_fmt for messages
      amdtee: Sort header includes

 drivers/tee/amdtee/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--===============0339851882246050331==--

