From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Fix race condition in AMDTEE driver
Date: Tue, 28 Feb 2023 20:42:17 +0100
Message-ID: <Y/5ZGX0lSTnZz27E@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5465604772983331506=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5465604772983331506==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this fix for the AMDTEE driver in the TEE subsystem.

Note that this isn't a usual Arm driver update. This targets AMD
instead, but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/amdtee-fix=
-for-v6.3

for you to fetch changes up to f8502fba45bd30e1a6a354d9d898bc99d1a11e6d:

  tee: amdtee: fix race condition in amdtee_open_session (2023-02-28 18:39:19=
 +0100)

----------------------------------------------------------------
AMDTEE fix race condition in amdtee_open_session()

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: fix race condition in amdtee_open_session

 drivers/tee/amdtee/core.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

--===============5465604772983331506==--

