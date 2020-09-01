From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] optee i2c fix for v5.10
Date: Tue, 01 Sep 2020 12:18:06 +0200
Message-ID: <20200901101806.GA3286324@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5203273183177654273=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5203273183177654273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch fixing a build issue in the previous OP-TEE
I2C patch. The test IS_REACHABLE(CONFIG_I2C) is used instead of
IS_ENABLED(CONFIG_I2C) to see if the I2C functions are available from
the OP-TEE driver.

If you rather have the patches squashed feel free to do so.

Thanks,
Jens

The following changes since commit c05210ab975771e161427eb47696b869d820bdaf:

  drivers: optee: allow op-tee to access devices on the i2c bus (2020-08-21 1=
1:41:45 +0200)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-i2c-fi=
x-for-v5.10

for you to fetch changes up to 539f8fc253ece5501fdea1a6aa227d0618374111:

  drivers: optee: fix i2c build issue (2020-09-01 12:03:16 +0200)

----------------------------------------------------------------
Make sure I2C functions used in OP-TEE are reachable with IS_REACHABLE()

----------------------------------------------------------------
Jorge Ramirez-Ortiz (1):
      drivers: optee: fix i2c build issue

 drivers/tee/optee/rpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--===============5203273183177654273==--

