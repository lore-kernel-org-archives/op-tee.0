From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE add notif wait timeout parameter for v6.11
Date: Thu, 27 Jun 2024 11:53:25 +0200
Message-ID: <20240627095325.GA2585076@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1863674160386475346=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1863674160386475346==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull this small patch to the OP-TEE driver that adds a timemout
parameter when OP-TEE is waiting for a notification via RPC.

Thanks,
Jens

The following changes since commit a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6:

  Linux 6.9 (2024-05-12 14:12:29 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git/ tags/optee-noti=
f-wait-timeout-for-v6.11

for you to fetch changes up to 14ca6401d8703725c7297dcc4bf8de73323411ac:

  optee: add timeout value to optee_notif_wait() to support timeout (2024-05-=
30 10:19:28 +0200)

----------------------------------------------------------------
optee: add timeout parameter for notification wait

----------------------------------------------------------------
Gavin Liu (1):
      optee: add timeout value to optee_notif_wait() to support timeout

 drivers/tee/optee/notif.c         |  9 +++++++--
 drivers/tee/optee/optee_private.h |  5 ++++-
 drivers/tee/optee/optee_rpc_cmd.h |  1 +
 drivers/tee/optee/rpc.c           | 10 ++++++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

--===============1863674160386475346==--

