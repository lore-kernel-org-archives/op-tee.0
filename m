From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMDTEE fix for v6.6
Date: Tue, 03 Oct 2023 19:18:35 +0200
Message-ID: <20231003171835.GA669924@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7796713526185969047=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7796713526185969047==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small AMDTEE driver fix addressing a possible
user-after-free vulnerability.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/amdtee-fix=
-for-v6.6

for you to fetch changes up to f4384b3e54ea813868bb81a861bf5b2406e15d8f:

  tee: amdtee: fix use-after-free vulnerability in amdtee_close_session (2023=
-10-03 19:13:53 +0200)

----------------------------------------------------------------
AMDTEE fix possible use-after-free

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

 drivers/tee/amdtee/core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--===============7796713526185969047==--

