From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2 0/4]  OP-TEE RPC argument cache
Date: Mon, 21 Mar 2022 14:03:37 +0100
Message-ID: <20220321130341.935535-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1299256075802539210=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1299256075802539210==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset optimizes handling of the argument struct passed to
call_with_arg when doing a yielding call to OP-TEE.

Prior to this was this struct allocated before the yielding call and
then freed after it had returned. In case many calls are made in succession
this results in quite a bit of unnecessary allocte/free and possibly also
switching back and forth to secure work in order to register if needed.

Another optimization handles the way the argument struct needed to do RPC
is passed. Please see the patch "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
OPTEE_SMC_CALL_WITH_REGD_ARG" for details.

This patchset is based the next branch [1] in my kernel to avoid conflict
with other recent patches.

Thanks,
Jens

[1] https://git.linaro.org/people/jens.wiklander/linux-tee.git/log/?h=next

v1->v2:
* Split out a separate commit "optee: rename rpc_arg_count to
  rpc_param_count"
* Check optee->rpc_param_count before calling optee_disable_shm_cache().
* Mention OPTEE_SMC_CALL_WITH_REGD_ARG in commit message.


Jens Wiklander (4):
  optee: rename rpc_arg_count to rpc_param_count
  optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
    OPTEE_SMC_CALL_WITH_REGD_ARG
  optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
  optee: cache argument shared memory structs

 drivers/tee/optee/call.c          | 238 ++++++++++++++++++++++++------
 drivers/tee/optee/core.c          |   1 +
 drivers/tee/optee/ffa_abi.c       |  36 +++--
 drivers/tee/optee/optee_ffa.h     |  12 +-
 drivers/tee/optee/optee_private.h |  31 +++-
 drivers/tee/optee/optee_smc.h     |  47 +++++-
 drivers/tee/optee/smc_abi.c       | 162 +++++++++++++++-----
 7 files changed, 427 insertions(+), 100 deletions(-)

-- 
2.31.1


--===============1299256075802539210==--

