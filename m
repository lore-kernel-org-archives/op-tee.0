From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/3] tee: tstee: Add Trusted Services TEE driver
Date: Thu, 15 Feb 2024 11:32:07 +0100
Message-ID: 
 <CAHUa44FUmXMCLvJEB8v2_H4j+yNzR+YMU0xSO6uaaqF0BHj_2Q@mail.gmail.com>
In-Reply-To: <ed8aaee7-be14-43ab-981c-d2ac04f4fc71@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0066276060677273306=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0066276060677273306==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 9:59=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 13/02/2024 15:52, Balint Dobszay wrote:
> > The Trusted Services project provides a framework for developing and
> > deploying device Root of Trust services in FF-A Secure Partitions. The
> > FF-A SPs are accessible through the FF-A driver, but this doesn't
> > provide a user space interface. The goal of this TEE driver is to make
> > Trusted Services SPs accessible for user space clients.
> >
> > All TS SPs have the same FF-A UUID, it identifies the RPC protocol used
> > by TS. A TS SP can host one or more services, a service is identified by
> > its service UUID. The same type of service cannot be present twice in
> > the same SP. During SP boot each service in an SP is assigned an
> > interface ID, this is just a short ID to simplify message addressing.
> > There is 1:1 mapping between TS SPs and TEE devices, i.e. a separate TEE
> > device is registered for each TS SP. This is required since contrary to
> > the generic TEE design where memory is shared with the whole TEE
> > implementation, in case of FF-A, memory is shared with a specific SP. A
> > user space client has to be able to separately share memory with each SP
> > based on its endpoint ID.
> >
> > Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> > ---
>
>
> > +static int tstee_probe(struct ffa_device *ffa_dev)
> > +{
> > +     struct tstee *tstee;
> > +     int rc;
> > +
> > +     ffa_dev->ops->msg_ops->mode_32bit_set(ffa_dev);
> > +
> > +     if (!tstee_check_rpc_compatible(ffa_dev))
> > +             return -EINVAL;
> > +
> > +     tstee =3D kzalloc(sizeof(*tstee), GFP_KERNEL);
> > +     if (!tstee)
> > +             return -ENOMEM;
> > +
> > +     tstee->ffa_dev =3D ffa_dev;
> > +
> > +     tstee->pool =3D tstee_create_shm_pool();
> > +     if (IS_ERR(tstee->pool)) {
> > +             rc =3D PTR_ERR(tstee->pool);
> > +             tstee->pool =3D NULL;
> > +             goto err;
>
> Is it logically correct to call here tee_device_unregister()?

It is harmless since it ignores null pointers, but you have a point.
It doesn't make sense to call tee_device_unregister() before
tee_device_register() has been called.

Thanks,
Jens

>
> > +     }
> > +
> > +     tstee->teedev =3D tee_device_alloc(&tstee_desc, NULL, tstee->pool, =
tstee);
> > +     if (IS_ERR(tstee->teedev)) {
> > +             rc =3D PTR_ERR(tstee->teedev);
> > +             tstee->teedev =3D NULL;
> > +             goto err;
> > +     }
> > +
> > +     rc =3D tee_device_register(tstee->teedev);
> > +     if (rc)
> > +             goto err;
> > +
> > +     ffa_dev_set_drvdata(ffa_dev, tstee);
> > +
> > +     pr_info("driver initialized for endpoint 0x%x\n", ffa_dev->vm_id);
>
> Don't print simple probe success messages. Anyway all prints in device
> context should be dev_*.
>
> > +
> > +     return 0;
> > +
> > +err:
> > +     tstee_deinit_common(tstee);
> > +     return rc;
> > +}
> > +
> > +static void tstee_remove(struct ffa_device *ffa_dev)
> > +{
> > +     tstee_deinit_common(ffa_dev->dev.driver_data);
> > +}
> > +
> > +static const struct ffa_device_id tstee_device_ids[] =3D {
> > +     /* TS RPC protocol UUID: bdcd76d7-825e-4751-963b-86d4f84943ac */
> > +     { TS_RPC_UUID },
> > +     {}
> > +};
> > +
> > +static struct ffa_driver tstee_driver =3D {
> > +     .name =3D "arm_tstee",
> > +     .probe =3D tstee_probe,
> > +     .remove =3D tstee_remove,
> > +     .id_table =3D tstee_device_ids,
> > +};
> > +
> > +static int __init mod_init(void)
> > +{
> > +     return ffa_register(&tstee_driver);
> > +}
> > +module_init(mod_init)
> > +
> > +static void __exit mod_exit(void)
> > +{
> > +     ffa_unregister(&tstee_driver);
> > +}
> > +module_exit(mod_exit)
> > +
> > +MODULE_ALIAS("arm-tstee");
>
> Why do you need this alias? I don't see MODULE_DEVICE_TABLE, so how this
> bus handles module loading?
>
>
> Best regards,
> Krzysztof
>

--===============0066276060677273306==--

