From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Set a flag to avoid memory leaks
Date: Mon, 26 Oct 2020 12:44:25 +0100
Message-ID: 
 <CAHUa44HPHazkiG6TEG7s3Ra3qHi009uQNNADhtYbS+nfAo1_4g@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CPH0PR11MB5077E3F06F573C8D4170A73595190=40PH0PR11MB?=
 =?utf-8?q?5077=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1396421291541546929=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1396421291541546929==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 26, 2020 at 3:22 AM Wang, Xiaolei
<Xiaolei.Wang@windriver.com> wrote:
>
> When an rpc message to release memory is not received, a memory leak will o=
ccur, which should be released
>
>
>
> unreferenced object 0xffff00006871b580 (size 128):
>
>   comm "swapper/0", pid 1, jiffies 4294892673 (age 428.192s)
>
>   hex dump (first 32 bytes):
>
>     80 b3 71 68 00 00 ff ff 00 e0 71 a8 00 00 00 00 ..qh......q.....
>
>     00 e0 71 68 00 00 ff ff 00 10 00 00 00 00 00 00 ..qh............
>
>   backtrace:
>
>     [<00000000f0425299>] slab_post_alloc_hook+0x6c/0x338
>
>     [<000000004705f905>] kmem_cache_alloc+0x1d4/0x328
>
>     [<00000000773c66a0>] tee_shm_alloc+0x84/0x268
>
>     [<00000000ca052f98>] optee_handle_rpc+0x144/0x5a0
>
>     [<0000000015a8eebe>] optee_do_call_with_arg+0x14c/0x168
>
>     [<00000000d51ef0fd>] optee_open_session+0x12c/0x200
>
>     [<000000007146f51d>] tee_client_open_session+0x24/0x38
>
>     [<00000000ea2b35e7>] optee_enumerate_devices+0xa0/0x2c0
>
>     [<0000000068088775>] optee_probe+0x560/0x690
>
>     [<00000000ad1d997a>] platform_drv_probe+0x54/0xa8
>
>     [<00000000e11592d4>] really_probe+0x118/0x3e0
>
>     [<00000000dacd3142>] driver_probe_device+0x5c/0xc0
>
>     [<0000000077c13842>] device_driver_attach+0x74/0x80
>
>     [<00000000106ccc62>] __driver_attach+0x8c/0xd8
>
>     [<00000000e120c345>] bus_for_each_dev+0x7c/0xd8
>
>     [<00000000b79335f5>] driver_attach+0x24/0x30
>
>
>
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>
> ---
>
> drivers/tee/optee/call.c          | 7 ++++++-
>
> drivers/tee/optee/optee_private.h | 2 +-
>
> drivers/tee/optee/rpc.c           | 4 +++-
>
> 3 files changed, 10 insertions(+), 3 deletions(-)
>
>
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c index 20b6=
fd7383c5..522c133b9d95 100644
>
> --- a/drivers/tee/optee/call.c
>
> +++ b/drivers/tee/optee/call.c
>
> @@ -129,6 +129,7 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phy=
s_addr_t parg)
>
>                struct optee_rpc_param param =3D { };
>
>                struct optee_call_ctx call_ctx =3D { };
>
>                u32 ret;
>
> +             unsigned int flags =3D 0;
>
>
>
>                 param.a0 =3D OPTEE_SMC_CALL_WITH_ARG;
>
>                reg_pair_from_64(&param.a1, &param.a2, parg); @@ -153,9 +154=
,13 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_addr_t parg)
>
>                                                param.a1 =3D res.a1;
>
>                                                param.a2 =3D res.a2;
>
>                                                param.a3 =3D res.a3;
>
> -                                              optee_handle_rpc(ctx, &param=
, &call_ctx);
>
> +                                             optee_handle_rpc(ctx, &param,=
 &call_ctx, &flags);
>
>                                } else {
>
>                                                ret =3D res.a0;
>
> +                                             if (flags !=3D 0x0) {
>
> +                                                             param.a0 =3D =
2;
>
> +                                                             optee_handle_=
rpc(ctx, &param, &call_ctx, &flags);

How can you know that OP-TEE isn't still using this buffer? Buffers
can be long lived.

Cheers,
Jens

>
> +                                             }
>
>                                                break;
>
>                                }
>
>                }
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_pr=
ivate.h
>
> index 8b71839a357e..1c1d62e21141 100644
>
> --- a/drivers/tee/optee/optee_private.h
>
> +++ b/drivers/tee/optee/optee_private.h
>
> @@ -127,7 +127,7 @@ struct optee_call_ctx {  };
>
>
>
>  void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *par=
am,
>
> -                                    struct optee_call_ctx *call_ctx);
>
> +                                  struct optee_call_ctx *call_ctx, unsigne=
d int *flags);
>
> void optee_rpc_finalize_call(struct optee_call_ctx *call_ctx);
>
>
>
>  void optee_wait_queue_init(struct optee_wait_queue *wq); diff --git a/driv=
ers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c index b4ade54d1f28..4e76c87b61f=
4 100644
>
> --- a/drivers/tee/optee/rpc.c
>
> +++ b/drivers/tee/optee/rpc.c
>
> @@ -396,7 +396,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx=
, struct optee *optee,
>
>   * Result of RPC is written back into @param.
>
>   */
>
> void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *para=
m,
>
> -                                    struct optee_call_ctx *call_ctx)
>
> +                                   struct optee_call_ctx *call_ctx, unsign=
ed int *flags)
>
> {
>
>                struct tee_device *teedev =3D ctx->teedev;
>
>                struct optee *optee =3D tee_get_drvdata(teedev); @@ -410,6 +=
410,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_para=
m *param,
>
>                                                reg_pair_from_64(&param->a1,=
 &param->a2, pa);
>
>                                                reg_pair_from_64(&param->a4,=
 &param->a5,
>
>                                                                            =
     (unsigned long)shm);
>
> +                                             *flags =3D 0x1;
>
>                                } else {
>
>                                                param->a1 =3D 0;
>
>                                                param->a2 =3D 0;
>
> @@ -420,6 +421,7 @@ void optee_handle_rpc(struct tee_context *ctx, struct o=
ptee_rpc_param *param,
>
>                case OPTEE_SMC_RPC_FUNC_FREE:
>
>                                shm =3D reg_pair_to_ptr(param->a1, param->a2=
);
>
>                                tee_shm_free(shm);
>
> +                             *flags =3D 0x0;
>
>                                break;
>
>                case OPTEE_SMC_RPC_FUNC_FOREIGN_INTR:
>
>                                /*
>
> --
>
> 2.25.1
>
>

--===============1396421291541546929==--

