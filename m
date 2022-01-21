From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 07/12] optee: use driver internal tee_contex for some rpc
Date: Fri, 21 Jan 2022 15:02:06 +0100
Message-ID: 
 <CAHUa44H-t2fVFWHQDU6ZjY7qyk53rbOi_h7=V_pYXTN+TtbMjA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYNo2xJ8VncpwbHG65hTTshxa-SWaPnGCB2v3KCTGogJkQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7369327524994079723=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7369327524994079723==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 21, 2022 at 2:37 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 21 Jan 2022 at 18:58, Jerome Forissier <jerome@forissier.org> wro=
te:
> >
> > On 1/21/22 13:54, Sumit Garg wrote:
> > > + Jerome, Etienne
> > >
> > > On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > >>
> > >> Uses the new driver internal tee_context when allocating driver private
> > >> shared memory. This decouples the shared memory object from its origin=
al
> > >> tee_context. This is needed when the life time of such a memory
> > >> allocation outlives the client tee_context.
> > >>
> > >> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > >> ---
> > >>  drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
> > >>  drivers/tee/optee/smc_abi.c |  7 ++++---
> > >>  2 files changed, 12 insertions(+), 11 deletions(-)
> > >>
> > >
> > > I guess with this patch we should no longer see issues [1] reported ear=
lier.
> >
> > Correct. I have tested [1] again in QEMU with this whole series applied
> > and the issue is gone.
> >
>
> Thanks for the confirmation.
>
> Jens,
>
> Can we have a Fixes tag for this and CC stable? I know it won't be
> directly applicable to stable kernels but we can help with a backport.
>

OK, I'll add that.

Thanks,
Jens

> -Sumit
>
> > --
> > Jerome
> >
> > >
> > > FWIW,
> > >
> > > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > >
> > > [1] https://github.com/OP-TEE/optee_os/issues/1918
> > >
> > > -Sumit
> > >
> > >> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > >> index 88a028d4fb7b..5ec484b42432 100644
> > >> --- a/drivers/tee/optee/ffa_abi.c
> > >> +++ b/drivers/tee/optee/ffa_abi.c
> > >> @@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_all=
oc_pages(void)
> > >>   */
> > >>
> > >>  static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> > >> +                                             struct optee *optee,
> > >>                                               struct optee_msg_arg *ar=
g)
> > >>  {
> > >>         struct tee_shm *shm;
> > >> @@ -439,7 +440,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(stru=
ct tee_context *ctx,
> > >>                 shm =3D optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].=
u.value.b);
> > >>                 break;
> > >>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> > >> -               shm =3D tee_shm_alloc_priv_kernel_buf(ctx,
> > >> +               shm =3D tee_shm_alloc_priv_kernel_buf(optee->ctx,
> > >>                                                     arg->params[0].u.v=
alue.b);
> > >>                 break;
> > >>         default:
> > >> @@ -493,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(str=
uct tee_context *ctx,
> > >>  }
> > >>
> > >>  static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
> > >> +                                   struct optee *optee,
> > >>                                     struct optee_msg_arg *arg)
> > >>  {
> > >> -       struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> > >> -
> > >>         arg->ret_origin =3D TEEC_ORIGIN_COMMS;
> > >>         switch (arg->cmd) {
> > >>         case OPTEE_RPC_CMD_SHM_ALLOC:
> > >> -               handle_ffa_rpc_func_cmd_shm_alloc(ctx, arg);
> > >> +               handle_ffa_rpc_func_cmd_shm_alloc(ctx, optee, arg);
> > >>                 break;
> > >>         case OPTEE_RPC_CMD_SHM_FREE:
> > >>                 handle_ffa_rpc_func_cmd_shm_free(ctx, optee, arg);
> > >> @@ -510,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_c=
ontext *ctx,
> > >>         }
> > >>  }
> > >>
> > >> -static void optee_handle_ffa_rpc(struct tee_context *ctx, u32 cmd,
> > >> -                                struct optee_msg_arg *arg)
> > >> +static void optee_handle_ffa_rpc(struct tee_context *ctx, struct opte=
e *optee,
> > >> +                                u32 cmd, struct optee_msg_arg *arg)
> > >>  {
> > >>         switch (cmd) {
> > >>         case OPTEE_FFA_YIELDING_CALL_RETURN_RPC_CMD:
> > >> -               handle_ffa_rpc_func_cmd(ctx, arg);
> > >> +               handle_ffa_rpc_func_cmd(ctx, optee, arg);
> > >>                 break;
> > >>         case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
> > >>                 /* Interrupt delivered by now */
> > >> @@ -582,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_cont=
ext *ctx,
> > >>                  * above.
> > >>                  */
> > >>                 cond_resched();
> > >> -               optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
> > >> +               optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
> > >>                 cmd =3D OPTEE_FFA_YIELDING_CALL_RESUME;
> > >>                 data->data0 =3D cmd;
> > >>                 data->data1 =3D 0;
> > >> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > >> index 1dbb13b08381..f2ef76451443 100644
> > >> --- a/drivers/tee/optee/smc_abi.c
> > >> +++ b/drivers/tee/optee/smc_abi.c
> > >> @@ -621,6 +621,7 @@ static void handle_rpc_func_cmd_shm_free(struct te=
e_context *ctx,
> > >>  }
> > >>
> > >>  static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> > >> +                                         struct optee *optee,
> > >>                                           struct optee_msg_arg *arg,
> > >>                                           struct optee_call_ctx *call_=
ctx)
> > >>  {
> > >> @@ -650,7 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct t=
ee_context *ctx,
> > >>                 shm =3D optee_rpc_cmd_alloc_suppl(ctx, sz);
> > >>                 break;
> > >>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> > >> -               shm =3D tee_shm_alloc_priv_kernel_buf(ctx, sz);
> > >> +               shm =3D tee_shm_alloc_priv_kernel_buf(optee->ctx, sz);
> > >>                 break;
> > >>         default:
> > >>                 arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> > >> @@ -746,7 +747,7 @@ static void handle_rpc_func_cmd(struct tee_context=
 *ctx, struct optee *optee,
> > >>         switch (arg->cmd) {
> > >>         case OPTEE_RPC_CMD_SHM_ALLOC:
> > >>                 free_pages_list(call_ctx);
> > >> -               handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
> > >> +               handle_rpc_func_cmd_shm_alloc(ctx, optee, arg, call_ct=
x);
> > >>                 break;
> > >>         case OPTEE_RPC_CMD_SHM_FREE:
> > >>                 handle_rpc_func_cmd_shm_free(ctx, arg);
> > >> @@ -775,7 +776,7 @@ static void optee_handle_rpc(struct tee_context *c=
tx,
> > >>
> > >>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> > >>         case OPTEE_SMC_RPC_FUNC_ALLOC:
> > >> -               shm =3D tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
> > >> +               shm =3D tee_shm_alloc_priv_kernel_buf(optee->ctx, para=
m->a1);
> > >>                 if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
> > >>                         reg_pair_from_64(&param->a1, &param->a2, pa);
> > >>                         reg_pair_from_64(&param->a4, &param->a5,
> > >> --
> > >> 2.31.1
> > >>

--===============7369327524994079723==--

