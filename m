From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] OP-TEE RPC arg for v5.19
Date: Wed, 04 May 2022 22:17:59 +0200
Message-ID: <20220504201759.GA180315@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5979269630280573847=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5979269630280573847==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello arm-soc maintainers,

Please pull these patches which improves performance when communicating
with OP-TEE in the secure world. A cache of argument structs is
implemented to minimize the number of alloc/free and possibly also
register/unregister of these buffers in the secure world. This boosts
the performance in particular in a FF-A configuration. It should also
save a bit of shared memory since each multiple a physical page now can
hold multiple argument structs, instead of one page per struct as it was
before.

The OP-TEE SMC ABI is also extended to pass an argument struct needed
for RPC together with the primary argument struct, in a manner similar
the OP-TEE FF-A ABI.

Thanks,
Jens

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-rpc-a=
rg-for-v5.19

for you to fetch changes up to 5b4018b959149eb5b5f3004fc0339674af67516b:

  optee: cache argument shared memory structs (2022-04-25 21:13:05 +0200)

----------------------------------------------------------------
OP-TEE RPC argument cache

Adds caching of the OP-TEE argument structure used to pass request to
secure world. This reduces quite a bit of unnecessary alloc/free and
possibly switching back and forth to secure work in order to register
the buffers in some configurations, most notably FF-A.

----------------------------------------------------------------
Jens Wiklander (4):
      optee: rename rpc_arg_count to rpc_param_count
      optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG
      optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
      optee: cache argument shared memory structs

 drivers/tee/optee/call.c          | 238 +++++++++++++++++++++++++++++++-----=
--
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |  36 ++++--
 drivers/tee/optee/optee_ffa.h     |  12 +-
 drivers/tee/optee/optee_private.h |  31 ++++-
 drivers/tee/optee/optee_smc.h     |  48 +++++++-
 drivers/tee/optee/smc_abi.c       | 197 +++++++++++++++++++++++++------
 7 files changed, 461 insertions(+), 102 deletions(-)

--===============5979269630280573847==--

