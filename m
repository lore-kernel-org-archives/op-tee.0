From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] TEE fix for v6.3
Date: Thu, 30 Mar 2023 14:48:04 +0200
Message-ID: <20230330124804.GA1943242@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8569582613929789522=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8569582613929789522==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small fix of a call to virt_to_page() in the TEE
subsystem.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/tee-fix-fo=
r-v6.3

for you to fetch changes up to 8671133082176d1388e20ac33d61cf7e3b05adf5:

  tee: Pass a pointer to virt_to_page() (2023-03-30 08:34:52 +0200)

----------------------------------------------------------------
Add explicit cast to (void *) for virt_to_page() argument

----------------------------------------------------------------
Linus Walleij (1):
      tee: Pass a pointer to virt_to_page()

 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--===============8569582613929789522==--

