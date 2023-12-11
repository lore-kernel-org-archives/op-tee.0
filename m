From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE FF-A asynchronous notifications for 6.8
Date: Mon, 11 Dec 2023 11:52:49 +0100
Message-ID: <20231211105249.GA587253@rayden>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8422508590770833098=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8422508590770833098==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches that enables asynchronous notifications in
OP-TEE FF-A driver. This pull request is on top of the
"system_thread_for_v6.8" pull request to avoid a merge conflict.

Thanks,
Jens

The following changes since commit 4b391c9c37646f25118355f414b9e6d9fefe782f:

  firmware: arm_scmi: optee: use optee system invocation (2023-11-17 15:48:03=
 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/ffa-notif-f=
or-v6.8

for you to fetch changes up to d0476a59de064205f4aaa8f7c6d6f32bc28a44d4:

  optee: ffa_abi: add asynchronous notifications (2023-11-17 15:55:41 +0100)

----------------------------------------------------------------
OP-TEE: asynchronous notifications with FF-A

Add support for asynchronous notifications in the OP-TEE FF-A driver. This
is the FF-A counterpart to the asynchronous notifications already
available in the OP-TEE SMC ABI.

----------------------------------------------------------------
Jens Wiklander (2):
      optee: provide optee_do_bottom_half() as a common function
      optee: ffa_abi: add asynchronous notifications

 drivers/tee/optee/call.c          | 31 ++++++++++++-
 drivers/tee/optee/ffa_abi.c       | 93 +++++++++++++++++++++++++++++++++++++=
--
 drivers/tee/optee/optee_ffa.h     | 28 ++++++++++--
 drivers/tee/optee/optee_private.h |  9 +++-
 drivers/tee/optee/smc_abi.c       | 36 ++-------------
 5 files changed, 155 insertions(+), 42 deletions(-)

--===============8422508590770833098==--

