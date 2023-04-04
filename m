From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE per-cpu irq for v6.4.
Date: Tue, 04 Apr 2023 08:27:27 +0200
Message-ID: <20230404062727.GA2765560@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5089815813920782320=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5089815813920782320==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches which add support for using per-cpu interrutps
to signal asynchronous notifications from OP-TEE in secure world to the
OP-TEE driver.

Thanks,
Jens

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-per-=
cpu-irq-for-v6.4

for you to fetch changes up to b3b4ced12c1bc829888803ce07fff317e590ec1c:

  optee: add per cpu asynchronous notification (2023-03-30 08:27:05 +0200)

----------------------------------------------------------------
Add OP-TEE per cpu asynchronous notification

Adds support for signalling from secure world with per-cpu interrupts in
addition to edge-triggered peripheral interrupts.

----------------------------------------------------------------
Etienne Carriere (2):
      dt-bindings: optee driver interrupt can be a per-cpu interrupt
      optee: add per cpu asynchronous notification

 .../bindings/arm/firmware/linaro,optee-tz.yaml     |   3 +-
 drivers/tee/optee/optee_private.h                  |  24 ++++
 drivers/tee/optee/smc_abi.c                        | 122 +++++++++++++++++++=
+-
 3 files changed, 144 insertions(+), 5 deletions(-)

--===============5089815813920782320==--

