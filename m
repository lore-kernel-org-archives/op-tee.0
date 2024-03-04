From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for 6.8
Date: Mon, 04 Mar 2024 14:27:27 +0100
Message-ID: <20240304132727.GA3501807@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1546213754468161132=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1546213754468161132==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small fix for a panic in the OP-TEE driver that can occur
in the error path when registering devices on the TEE bus.

Thanks,
Jens

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-fix-f=
or-v6.8

for you to fetch changes up to 95915ba4b987cf2b222b0f251280228a1ff977ac:

  tee: optee: Fix kernel panic caused by incorrect error handling (2024-03-04=
 09:49:03 +0100)

----------------------------------------------------------------
Fix kernel panic in OP-TEE driver

----------------------------------------------------------------
Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

 drivers/tee/optee/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--===============1546213754468161132==--

