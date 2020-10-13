From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE use UUID API for v5.10
Date: Tue, 13 Oct 2020 08:36:12 +0200
Message-ID: <20201013063612.GA3325842@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5952280363488872306=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5952280363488872306==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch which allows to hide uuit_t internals from
the OP-TEE driver.

I know it's a bit late for v5.10, if it's too late please queue it for
v5.11 instead.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-use-uu=
id-api-for-v5.10

for you to fetch changes up to 57222a1be27e06ecb81cc2f945e897814d5f461c:

  tee: optee: Use UUID API for exporting the UUID (2020-10-13 08:03:18 +0200)

----------------------------------------------------------------
Use UUID API to export the UUID

Uses export_uuid() to export and uuid_t to an u8 array instead of depending
on the internals of uuid_t.

----------------------------------------------------------------
Andy Shevchenko (1):
      tee: optee: Use UUID API for exporting the UUID

 drivers/tee/optee/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--===============5952280363488872306==--

