From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
Date: Tue, 23 May 2023 09:11:34 +0200
Message-ID: 
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
In-Reply-To: <20230517143311.585080-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1186448638600921539=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1186448638600921539==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Sumit,


On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> From: Etienne Carriere <etienne.carriere@linaro.org>
>
> Adds support in the OP-TEE driver to keep track of reserved system
> threads. The optee_cq_*() functions are updated to handle this if
> enabled. The SMC ABI part of the driver enables this tracking, but the
> FF-A ABI part does not.
>
> The logic allows atleast 1 OP-TEE thread can be reserved to TEE system
> sessions. For sake of simplicity, initialization of call queue
> management is factorized into new helper function optee_cq_init().
>
> Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Disclaimer: Compile tested only
>
> Hi Etienne,
>
> Overall the idea we agreed upon was okay but the implementation looked
> complex to me. So I thought it would be harder to explain that via
> review and I decided myself to give a try at simplification. I would
> like you to test it if this still addresses the SCMI deadlock problem or
> not. Also, feel free to include this in your patchset if all goes fine
> wrt testing.

With these changes, there is no more a specific waiting list for TEE
system threads hence when a waiting queue can complete, we'll pick any
TEE thread, not a TEE system thread first..
Also, as stated in a below answer, these change unconditionally
reserve a TEE thread for TEE system calls even if no TEE client
reserved such.

>
> -Sumit
>
> Changes since v8:
> - Simplified system threads tracking implementation.
>
>  drivers/tee/optee/call.c          | 72 +++++++++++++++++++++++++++++--
>  drivers/tee/optee/ffa_abi.c       |  3 +-
>  drivers/tee/optee/optee_private.h | 16 +++++++
>  drivers/tee/optee/smc_abi.c       | 16 ++++++-
>  4 files changed, 99 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 42e478ac6ce1..09e824e4dcaf 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -39,9 +39,27 @@ struct optee_shm_arg_entry {
>         DECLARE_BITMAP(map, MAX_ARG_COUNT_PER_ENTRY);
>  };
>
> +void optee_cq_init(struct optee_call_queue *cq, int thread_count)
> +{
> +       mutex_init(&cq->mutex);
> +       INIT_LIST_HEAD(&cq->waiters);
> +       /*
> +        * If cq->total_thread_count is 0 then we're not trying to keep
> +        * track of how many free threads we have, instead we're relying on
> +        * the secure world to tell us when we're out of thread and have to
> +        * wait for another thread to become available.
> +        */
> +       cq->total_thread_count =3D thread_count;
> +       cq->free_thread_count =3D thread_count;
> +}
> +
>  void optee_cq_wait_init(struct optee_call_queue *cq,
>                         struct optee_call_waiter *w, bool sys_thread)
>  {
> +       bool need_wait =3D false;
> +
> +       memset(w, 0, sizeof(*w));
> +
>         /*
>          * We're preparing to make a call to secure world. In case we can't
>          * allocate a thread in secure world we'll end up waiting in
> @@ -53,15 +71,43 @@ void optee_cq_wait_init(struct optee_call_queue *cq,
>         mutex_lock(&cq->mutex);
>
>         /*
> -        * We add ourselves to the queue, but we don't wait. This
> -        * guarantees that we don't lose a completion if secure world
> -        * returns busy and another thread just exited and try to complete
> -        * someone.
> +        * We add ourselves to a queue, but we don't wait. This guarantees
> +        * that we don't lose a completion if secure world returns busy and
> +        * another thread just exited and try to complete someone.
>          */
>         init_completion(&w->c);
>         list_add_tail(&w->list_node, &cq->waiters);
>
> +       if (cq->total_thread_count && sys_thread) {
> +               if (cq->free_thread_count > 0)
> +                       cq->free_thread_count--;
> +               else
> +                       need_wait =3D true;
> +       } else if (cq->total_thread_count) {
> +               if (cq->free_thread_count > 1)

This unconditionally reserves a TEE thread for TEE system calls, even
if no client has claimed such system thread reservation.


> +                       cq->free_thread_count--;
> +               else
> +                       need_wait =3D true;
> +       }
> +
>         mutex_unlock(&cq->mutex);
> +
> +       while (need_wait) {
> +               optee_cq_wait_for_completion(cq, w);
> +               mutex_lock(&cq->mutex);
> +               if (sys_thread) {
> +                       if (cq->free_thread_count > 0) {
> +                               cq->free_thread_count--;
> +                               need_wait =3D false;
> +                       }
> +               } else {
> +                       if (cq->free_thread_count > 1) {
> +                               cq->free_thread_count--;
> +                               need_wait =3D false;
> +                       }
> +               }
> +               mutex_unlock(&cq->mutex);
> +       }
>  }
>
>  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> @@ -104,6 +150,8 @@ void optee_cq_wait_final(struct optee_call_queue *cq,
>         /* Get out of the list */
>         list_del(&w->list_node);
>
> +       cq->free_thread_count++;
> +
>         /* Wake up one eventual waiting task */
>         optee_cq_complete_one(cq);
>
> @@ -361,6 +409,22 @@ int optee_open_session(struct tee_context *ctx,
>         return rc;
>  }
>
> +int optee_system_session(struct tee_context *ctx, u32 session)
> +{
> +       struct optee_context_data *ctxdata =3D ctx->data;
> +       struct optee_session *sess;
> +
> +       mutex_lock(&ctxdata->mutex);
> +
> +       sess =3D find_session(ctxdata, session);
> +       if (sess && !sess->use_sys_thread)
> +               sess->use_sys_thread =3D true;
> +
> +       mutex_unlock(&ctxdata->mutex);
> +
> +       return 0;

Nitpicking: should rather return 0 only upon session is valid
(sess!=3DNULL here)  and system thread reservation is supported
(total_thread_count > 0).
But that's not a big deal I guess, can be addressed.

Etienne




> +}
> +
>  int optee_close_session_helper(struct tee_context *ctx, u32 session,
>                                bool system_thread)
>  {
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 5fde9d4100e3..0c9055691343 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -852,8 +852,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         if (rc)
>                 goto err_unreg_supp_teedev;
>         mutex_init(&optee->ffa.mutex);
> -       mutex_init(&optee->call_queue.mutex);
> -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> +       optee_cq_init(&optee->call_queue, 0);
>         optee_supp_init(&optee->supp);
>         optee_shm_arg_cache_init(optee, arg_cache_flags);
>         ffa_dev_set_drvdata(ffa_dev, optee);
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
> index b68273051454..6dcecb83c893 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -40,15 +40,29 @@ typedef void (optee_invoke_fn)(unsigned long, unsigned =
long, unsigned long,
>                                 unsigned long, unsigned long,
>                                 struct arm_smccc_res *);
>
> +/*
> + * struct optee_call_waiter - TEE entry may need to wait for a free TEE th=
read
> + * @list_node          Reference in waiters list
> + * @c                  Waiting completion reference
> + */
>  struct optee_call_waiter {
>         struct list_head list_node;
>         struct completion c;
>  };
>
> +/*
> + * struct optee_call_queue - OP-TEE call queue management
> + * @mutex                      Serializes access to this struct
> + * @waiters                    List of threads waiting to enter OP-TEE
> + * @total_thread_count         Overall number of thread context in OP-TEE =
or 0
> + * @free_thread_count          Number of threads context free in OP-TEE
> + */
>  struct optee_call_queue {
>         /* Serializes access to this struct */
>         struct mutex mutex;
>         struct list_head waiters;
> +       int total_thread_count;
> +       int free_thread_count;
>  };
>
>  struct optee_notif {
> @@ -254,6 +268,7 @@ int optee_supp_send(struct tee_context *ctx, u32 ret, u=
32 num_params,
>  int optee_open_session(struct tee_context *ctx,
>                        struct tee_ioctl_open_session_arg *arg,
>                        struct tee_param *param);
> +int optee_system_session(struct tee_context *ctx, u32 session);
>  int optee_close_session_helper(struct tee_context *ctx, u32 session,
>                                bool system_thread);
>  int optee_close_session(struct tee_context *ctx, u32 session);
> @@ -303,6 +318,7 @@ static inline void optee_to_msg_param_value(struct opte=
e_msg_param *mp,
>         mp->u.value.c =3D p->u.value.c;
>  }
>
> +void optee_cq_init(struct optee_call_queue *cq, int thread_count);
>  void optee_cq_wait_init(struct optee_call_queue *cq,
>                         struct optee_call_waiter *w, bool sys_thread);
>  void optee_cq_wait_for_completion(struct optee_call_queue *cq,
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index e2763cdcf111..3314ffeb91c8 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1209,6 +1209,7 @@ static const struct tee_driver_ops optee_clnt_ops =3D=
 {
>         .release =3D optee_release,
>         .open_session =3D optee_open_session,
>         .close_session =3D optee_close_session,
> +       .system_session =3D optee_system_session,
>         .invoke_func =3D optee_invoke_func,
>         .cancel_req =3D optee_cancel_req,
>         .shm_register =3D optee_shm_register,
> @@ -1356,6 +1357,16 @@ static bool optee_msg_exchange_capabilities(optee_in=
voke_fn *invoke_fn,
>         return true;
>  }
>
> +static unsigned int optee_msg_get_thread_count(optee_invoke_fn *invoke_fn)
> +{
> +       struct arm_smccc_res res;
> +
> +       invoke_fn(OPTEE_SMC_GET_THREAD_COUNT, 0, 0, 0, 0, 0, 0, 0, &res);
> +       if (res.a0)
> +               return 0;
> +       return res.a1;
> +}
> +
>  static struct tee_shm_pool *
>  optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_sh=
m)
>  {
> @@ -1609,6 +1620,7 @@ static int optee_probe(struct platform_device *pdev)
>         struct optee *optee =3D NULL;
>         void *memremaped_shm =3D NULL;
>         unsigned int rpc_param_count;
> +       unsigned int thread_count;
>         struct tee_device *teedev;
>         struct tee_context *ctx;
>         u32 max_notif_value;
> @@ -1636,6 +1648,7 @@ static int optee_probe(struct platform_device *pdev)
>                 return -EINVAL;
>         }
>
> +       thread_count =3D optee_msg_get_thread_count(invoke_fn);
>         if (!optee_msg_exchange_capabilities(invoke_fn, &sec_caps,
>                                              &max_notif_value,
>                                              &rpc_param_count)) {
> @@ -1725,8 +1738,7 @@ static int optee_probe(struct platform_device *pdev)
>         if (rc)
>                 goto err_unreg_supp_teedev;
>
> -       mutex_init(&optee->call_queue.mutex);
> -       INIT_LIST_HEAD(&optee->call_queue.waiters);
> +       optee_cq_init(&optee->call_queue, thread_count);
>         optee_supp_init(&optee->supp);
>         optee->smc.memremaped_shm =3D memremaped_shm;
>         optee->pool =3D pool;
> --
> 2.34.1
>

--===============1186448638600921539==--

