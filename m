From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] tee subsystem pin_user_pages for v5.10
Date: Tue, 25 Aug 2020 11:07:15 +0200
Message-ID: <20200825090715.GA2370775@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2720389832273051171=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2720389832273051171==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch converting the tee subsystem to use
pin_user_pages() instead of get_user_pages().

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-pin-user-=
pages-for-5.10

for you to fetch changes up to 4300cd6374a5192a2c8122a4a48ed647bdcb0214:

  tee: convert get_user_pages() --> pin_user_pages() (2020-08-25 11:01:06 +02=
00)

----------------------------------------------------------------
Converts tee subsystem to use pin_user_pages() instead of get_user_pages()

----------------------------------------------------------------
John Hubbard (1):
      tee: convert get_user_pages() --> pin_user_pages()

 drivers/tee/tee_shm.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

--===============2720389832273051171==--

