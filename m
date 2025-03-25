From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 08/10] optee: support restricted memory allocation
Date: Tue, 25 Mar 2025 14:55:32 +0100
Message-ID: 
 <CAHUa44FXjG1hC9v18Yx1ENPX_Bc9sZW1Z2=+m6+KUsxPMvDE+w@mail.gmail.com>
In-Reply-To: <Z-JWIyd8cKyXQR0H@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4521663137593868079=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4521663137593868079==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 8:07=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Wed, Mar 05, 2025 at 02:04:14PM +0100, Jens Wiklander wrote:
> > Add support in the OP-TEE backend driver for restricted memory
> > allocation. The support is limited to only the SMC ABI and for secure
> > video buffers.
> >
> > OP-TEE is probed for the range of restricted physical memory and a
> > memory pool allocator is initialized if OP-TEE have support for such
> > memory.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/core.c    |  1 +
> >  drivers/tee/optee/smc_abi.c | 44 +++++++++++++++++++++++++++++++++++--
> >  2 files changed, 43 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index c75fddc83576..c7fd8040480e 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -181,6 +181,7 @@ void optee_remove_common(struct optee *optee)
> >       tee_device_unregister(optee->supp_teedev);
> >       tee_device_unregister(optee->teedev);
> >
> > +     tee_device_unregister_all_dma_heaps(optee->teedev);
> >       tee_shm_pool_free(optee->pool);
> >       optee_supp_uninit(&optee->supp);
> >       mutex_destroy(&optee->call_queue.mutex);
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index cfdae266548b..a14ff0b7d3b3 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1620,6 +1620,41 @@ static inline int optee_load_fw(struct platform_de=
vice *pdev,
> >  }
> >  #endif
> >
> > +static int optee_sdp_pool_init(struct optee *optee)
> > +{
> > +     enum tee_dma_heap_id heap_id =3D TEE_DMA_HEAP_SECURE_VIDEO_PLAY;
> > +     struct tee_rstmem_pool *pool;
> > +     int rc;
> > +
> > +     if (optee->smc.sec_caps & OPTEE_SMC_SEC_CAP_SDP) {
>
> Is this SDP capability an ABI yet since we haven't supported it in
> upstream kernel? If no then can we rename it as
> OPTEE_SMC_SEC_CAP_RSTMEM?

No problem. We can rename it.

>
> > +             union {
> > +                     struct arm_smccc_res smccc;
> > +                     struct optee_smc_get_sdp_config_result result;
> > +             } res;
> > +
> > +             optee->smc.invoke_fn(OPTEE_SMC_GET_SDP_CONFIG, 0, 0, 0, 0, =
0, 0,
> > +                                  0, &res.smccc);
> > +             if (res.result.status !=3D OPTEE_SMC_RETURN_OK) {
> > +                     pr_err("Secure Data Path service not available\n");
> > +                     return 0;
> > +             }
> > +
> > +             pool =3D tee_rstmem_static_pool_alloc(res.result.start,
> > +                                                 res.result.size);
> > +             if (IS_ERR(pool))
> > +                     return PTR_ERR(pool);
> > +
> > +             rc =3D tee_device_register_dma_heap(optee->teedev, heap_id,=
 pool);
> > +             if (rc)
> > +                     goto err;
> > +     }
> > +
> > +     return 0;
> > +err:
> > +     pool->ops->destroy_pool(pool);
> > +     return rc;
> > +}
> > +
> >  static int optee_probe(struct platform_device *pdev)
> >  {
> >       optee_invoke_fn *invoke_fn;
> > @@ -1715,7 +1750,7 @@ static int optee_probe(struct platform_device *pdev)
> >       optee =3D kzalloc(sizeof(*optee), GFP_KERNEL);
> >       if (!optee) {
> >               rc =3D -ENOMEM;
> > -             goto err_free_pool;
> > +             goto err_free_shm_pool;
> >       }
> >
> >       optee->ops =3D &optee_ops;
> > @@ -1788,6 +1823,10 @@ static int optee_probe(struct platform_device *pde=
v)
> >               pr_info("Asynchronous notifications enabled\n");
> >       }
> >
> > +     rc =3D optee_sdp_pool_init(optee);
>
> s/optee_sdp_pool_init/optee_rstmem_pool_init/

OK

Cheers,
Jens

>
> -Sumit
>
> > +     if (rc)
> > +             goto err_notif_uninit;
> > +
> >       /*
> >        * Ensure that there are no pre-existing shm objects before enabling
> >        * the shm cache so that there's no chance of receiving an invalid
> > @@ -1823,6 +1862,7 @@ static int optee_probe(struct platform_device *pdev)
> >               optee_disable_shm_cache(optee);
> >       optee_smc_notif_uninit_irq(optee);
> >       optee_unregister_devices();
> > +     tee_device_unregister_all_dma_heaps(optee->teedev);
> >  err_notif_uninit:
> >       optee_notif_uninit(optee);
> >  err_close_ctx:
> > @@ -1839,7 +1879,7 @@ static int optee_probe(struct platform_device *pdev)
> >       tee_device_unregister(optee->teedev);
> >  err_free_optee:
> >       kfree(optee);
> > -err_free_pool:
> > +err_free_shm_pool:
> >       tee_shm_pool_free(pool);
> >       if (memremaped_shm)
> >               memunmap(memremaped_shm);
> > --
> > 2.43.0
> >

--===============4521663137593868079==--

