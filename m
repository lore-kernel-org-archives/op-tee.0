From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] optee bus for v5.9
Date: Fri, 10 Jul 2020 10:52:30 +0200
Message-ID: <20200710085230.GA1312913@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1386209375389558978=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1386209375389558978==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches enabling multi-stage OP-TEE bus enumeration
and also adds a TPM driver for a OP-TEE based fTPM Trusted Application.

The TPM driver depends on and takes advantage of the multi-stage OP-TEE bus
enumeration by indicating that it should be probed after tee-supplicant has
been started.

Jarkko, one of the TPM maintainers, has been involved in reviewing these
patches and agrees that I can include the TPM patch in the pull request.

Thanks,
Jens

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-bus-for=
-v5.9

for you to fetch changes up to 9f1944c23c8cb1c033b73de80cf6c612a2a80a2b:

  tpm_ftpm_tee: register driver on TEE bus (2020-07-10 09:41:58 +0200)

----------------------------------------------------------------
Enable multi-stage OP-TEE bus enumeration

Probes drivers on the OP-TEE bus in two steps. First for drivers which
do not depend on tee-supplicant. After tee-supplicant has been started
probe the devices which do depend on tee-supplicant.

Also introduces driver which uses an OP-TEE based fTPM Trusted
Application depends on tee-supplicant NV RAM implementation based on
RPMB secure storage.

----------------------------------------------------------------
Maxim Uvarov (3):
      optee: use uuid for sysfs driver entry
      optee: enable support for multi-stage bus enumeration
      tpm_ftpm_tee: register driver on TEE bus

 Documentation/ABI/testing/sysfs-bus-optee-devices |  8 +++
 MAINTAINERS                                       |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c                   | 70 +++++++++++++++++++--=
--
 drivers/tee/optee/core.c                          | 27 ++++++++-
 drivers/tee/optee/device.c                        | 38 ++++++------
 drivers/tee/optee/optee_private.h                 | 10 +++-
 6 files changed, 119 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

--===============1386209375389558978==--

