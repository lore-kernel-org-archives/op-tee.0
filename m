From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v3 0/4] OP-TEE RPC argument cache
Date: Wed, 13 Apr 2022 07:44:14 +0200
Message-ID: <20220413054418.71996-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4067309959153481810=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4067309959153481810==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

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

Thanks,
Jens

v1->v2:
* Split out a separate commit "optee: rename rpc_arg_count to
  rpc_param_count"
* Check optee->rpc_param_count before calling optee_disable_shm_cache().
* Mention OPTEE_SMC_CALL_WITH_REGD_ARG in commit message.

v2->v3:
* Applied Sumit's R-B to "optee: rename rpc_arg_count to rpc_param_count"
  and "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_AR=
G"
* Fixed some review comments to "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
  OPTEE_SMC_CALL_WITH_REGD_ARG"
* Rebased on v5.18-rc1


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
 drivers/tee/optee/optee_smc.h     |  48 +++++-
 drivers/tee/optee/smc_abi.c       | 162 +++++++++++++++-----
 7 files changed, 428 insertions(+), 100 deletions(-)

--=20
2.31.1


--===============4067309959153481810==--

