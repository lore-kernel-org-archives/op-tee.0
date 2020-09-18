From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] tee dev cleanup for v5.10
Date: Fri, 18 Sep 2020 16:41:30 +0200
Message-ID: <20200918144130.GB1219771@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8175450756546110151=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8175450756546110151==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small cleanup in tee driver registration. There are no
changes in behaviour, just a reduction in number of lines due to
improved usage of the device driver framework.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-dev-clea=
nup-for-v5.10

for you to fetch changes up to 8c05f50fe8452f9d3220efad77bef42c7b498193:

  tee: avoid explicit sysfs_create/delete_group by initialising dev->groups (=
2020-09-18 10:44:45 +0200)

----------------------------------------------------------------
Simplify tee_device_register() and friends

Uses cdev_device_add() instead of the cdev_add() device_add()
combination.

Initializes dev->groups instead of direct calls to sysfs_create_group()
and friends.

----------------------------------------------------------------
Sudeep Holla (2):
      tee: replace cdev_add + device_add with cdev_device_add
      tee: avoid explicit sysfs_create/delete_group by initialising dev->grou=
ps

 drivers/tee/tee_core.c | 40 +++++++---------------------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

--===============8175450756546110151==--

