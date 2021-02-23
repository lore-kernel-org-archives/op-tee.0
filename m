From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Tue, 23 Feb 2021 08:59:22 +0100
Message-ID: 
 <CAHUa44E-_czjhRxr2JjggYu0sDCsRvOA3Uc=hqp7j5Cmtb9q0w@mail.gmail.com>
In-Reply-To: <20210210144409.36ecdaed@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3699578515595353178=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3699578515595353178==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jisheng,

On Wed, Feb 10, 2021 at 7:44 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Add tracepoints to retrieve information about the invoke_fn. This would
> help to measure how many invoke_fn are triggered and how long it takes
> to complete one invoke_fn call.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>
> Since v1:
>  - add BUILD_BUG_ON() macro usage to make sure that the size of what is bei=
ng
>    copied, is not smaller than the amount being copied. Thank Steve.
>  - move optee_trace.h to keep include headers sorted
>
>  drivers/tee/optee/call.c        |  4 ++
>  drivers/tee/optee/optee_trace.h | 67 +++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 drivers/tee/optee/optee_trace.h
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 780d7c4fd756..0da6fe50f1af 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -14,6 +14,8 @@
>  #include <linux/uaccess.h>
>  #include "optee_private.h"
>  #include "optee_smc.h"
> +#define CREATE_TRACE_POINTS
> +#include "optee_trace.h"
>
>  struct optee_call_waiter {
>         struct list_head list_node;
> @@ -138,9 +140,11 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, ph=
ys_addr_t parg)
>         while (true) {
>                 struct arm_smccc_res res;
>
> +               trace_optee_invoke_fn_begin(&param);
>                 optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
>                                  param.a4, param.a5, param.a6, param.a7,
>                                  &res);
> +               trace_optee_invoke_fn_end(&param, &res);
>
>                 if (res.a0 =3D=3D OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
>                         /*
> diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_trac=
e.h
> new file mode 100644
> index 000000000000..7c954eefa4bf
> --- /dev/null
> +++ b/drivers/tee/optee/optee_trace.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * optee trace points
> + *
> + * Copyright (C) 2021 Synaptics Incorporated
> + * Author: Jisheng Zhang <jszhang@kernel.org>
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM optee
> +
> +#if !defined(_TRACE_OPTEE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_OPTEE_H
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/tracepoint.h>
> +#include "optee_private.h"
> +

Checkpatch has some complaints below. Is that something that could be
fixed or is this so far from regular C-syntax that we don't care?

Thanks,
Jens

> +TRACE_EVENT(optee_invoke_fn_begin,
> +       TP_PROTO(struct optee_rpc_param *param),
> +       TP_ARGS(param),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, param)
> +               __array(u32, args, 8)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->param =3D param;
> +               BUILD_BUG_ON(sizeof(*param) < sizeof(__entry->args));
> +               memcpy(__entry->args, param, sizeof(__entry->args));
> +       ),
> +
> +       TP_printk("param=3D%p (%x, %x, %x, %x, %x, %x, %x, %x)", __entry->p=
aram,
> +                 __entry->args[0], __entry->args[1], __entry->args[2],
> +                 __entry->args[3], __entry->args[4], __entry->args[5],
> +                 __entry->args[6], __entry->args[7])
> +);
> +
> +TRACE_EVENT(optee_invoke_fn_end,
> +       TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
> +       TP_ARGS(param, res),
> +
> +       TP_STRUCT__entry(
> +               __field(void *, param)
> +               __array(unsigned long, rets, 4)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->param =3D param;
> +               BUILD_BUG_ON(sizeof(*res) < sizeof(__entry->rets));
> +               memcpy(__entry->rets, res, sizeof(__entry->rets));
> +       ),
> +
> +       TP_printk("param=3D%p ret (%lx, %lx, %lx, %lx)", __entry->param,
> +                 __entry->rets[0], __entry->rets[1], __entry->rets[2],
> +                 __entry->rets[3])
> +);
> +#endif /* _TRACE_OPTEE_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE optee_trace
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> --
> 2.30.0
>

--===============3699578515595353178==--

