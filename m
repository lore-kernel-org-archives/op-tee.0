From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE fix for 6.7
Date: Tue, 14 Nov 2023 16:31:13 +0100
Message-ID: <20231114153113.GA1310615@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4234547185146432559=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4234547185146432559==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this OP-TEE driver fix allowing supplicant dependent devices to
be detached by user-space before the supplicant service is shut down.

Thanks,
Jens

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/optee-suppli=
cant-fix-for-v6.7

for you to fetch changes up to 7269cba53d906cf257c139d3b3a53ad272176bca:

  tee: optee: Fix supplicant based device enumeration (2023-11-03 09:27:20 +0=
100)

----------------------------------------------------------------
OP-TEE fix for supplicant based device enumeration

Adds a sysfs attribute for devices depending on supplicant services so
that the user-space service can detect and detach those devices before
closing the supplicant

----------------------------------------------------------------
Sumit Garg (1):
      tee: optee: Fix supplicant based device enumeration

 Documentation/ABI/testing/sysfs-bus-optee-devices |  9 +++++++++
 drivers/tee/optee/device.c                        | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

--===============4234547185146432559==--

