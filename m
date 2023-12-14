From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] Improved TEE shared buffer support for v6.8
Date: Thu, 14 Dec 2023 14:41:39 +0100
Message-ID: <20231214134139.GA3098718@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5019149744052873170=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5019149744052873170==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this patch to add vmalloc support for shared buffer
registration with the secure world.

Thanks,
Jens

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-iov-ite=
r-for-v6.8

for you to fetch changes up to 7bdee41575919773818e525ea19e54eb817770af:

  tee: Use iov_iter to better support shared buffer registration (2023-12-13 =
07:23:22 +0100)

----------------------------------------------------------------
TEE: improve shared buffer registration compatibility

----------------------------------------------------------------
Arnaud Pouliquen (1):
      tee: Use iov_iter to better support shared buffer registration

 drivers/tee/tee_shm.c | 78 +++++++++++++++++++++++++++----------------------=
--
 1 file changed, 42 insertions(+), 36 deletions(-)

--===============5019149744052873170==--

