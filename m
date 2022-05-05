From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 0/4] OP-TEE RPC argument cache
Date: Thu, 05 May 2022 07:14:52 +0200
Message-ID: 
 <CAHUa44HHR9Y5y-xM8Ss5+amUokV=yfpymJqMwPfNjcfi1aD4gw@mail.gmail.com>
In-Reply-To: <20220426073338.3048192-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3682340010951331878=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3682340010951331878==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2022 at 9:33 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This patchset optimizes handling of the argument struct passed to
> call_with_arg when doing a yielding call to OP-TEE.
>
> Prior to this was this struct allocated before the yielding call and
> then freed after it had returned. In case many calls are made in succession
> this results in quite a bit of unnecessary allocte/free and possibly also
> switching back and forth to secure work in order to register if needed.
>
> Another optimization handles the way the argument struct needed to do RPC
> is passed. Please see the patch "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
> OPTEE_SMC_CALL_WITH_REGD_ARG" for details.
>
> Thanks,
> Jens
>
> v1->v2:
> * Split out a separate commit "optee: rename rpc_arg_count to
>   rpc_param_count"
> * Check optee->rpc_param_count before calling optee_disable_shm_cache().
> * Mention OPTEE_SMC_CALL_WITH_REGD_ARG in commit message.
>
> v2->v3:
> * Applied Sumit's R-B to "optee: rename rpc_arg_count to rpc_param_count"
>   and "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_=
ARG"
> * Fixed some review comments to "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
>   OPTEE_SMC_CALL_WITH_REGD_ARG"
> * Rebased on v5.18-rc1
>
> v3->v4:
> * Updated "optee: cache argument shared memory structs" to work with older
>   versions of the SMC-ABI when using dynamic shared memory.
>
> Jens Wiklander (4):
>   optee: rename rpc_arg_count to rpc_param_count
>   optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
>     OPTEE_SMC_CALL_WITH_REGD_ARG
>   optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
>   optee: cache argument shared memory structs
>
>  drivers/tee/optee/call.c          | 238 ++++++++++++++++++++++++------
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       |  36 +++--
>  drivers/tee/optee/optee_ffa.h     |  12 +-
>  drivers/tee/optee/optee_private.h |  31 +++-
>  drivers/tee/optee/optee_smc.h     |  48 +++++-
>  drivers/tee/optee/smc_abi.c       | 197 ++++++++++++++++++++-----
>  7 files changed, 461 insertions(+), 102 deletions(-)
>
> --
> 2.31.1
>

I've picked this up now.

Thanks,
Jens

--===============3682340010951331878==--

