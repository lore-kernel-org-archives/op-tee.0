From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
Date: Wed, 02 Aug 2023 10:04:08 +0300
Message-ID: 
 <CAC_iWjLo=RbFCs5i1jdMXRbx0r-ximrSb5fWFad+98R5r_gpXQ@mail.gmail.com>
In-Reply-To: <e1e9a9c1-db6f-c2f6-1ac0-fd368f79aec6@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9211767857736282335=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9211767857736282335==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Heinrich

[...]

> > +static struct tee_client_driver tee_stmm_efi_driver = {
> > +     .id_table       = tee_stmm_efi_id_table,
> > +     .driver         = {
> > +             .name           = "tee-stmm-efi",
> > +             .bus            = &tee_bus_type,
> > +             .probe          = tee_stmm_efi_probe,
> > +             .remove         = tee_stmm_efi_remove,
> > +     },
> > +};
> > +
> > +static int __init tee_stmm_efi_mod_init(void)
> > +{
> > +     return driver_register(&tee_stmm_efi_driver.driver);
>
> Assuming that multiple drivers supplying EFI runtime services may be
> available in future, e.g.
>
> * generic, using EFI runtime function supplied by UEFI firmware
> * TEE-STMM
> * Qualcomm driver as needed for Lenovo X13s
> * ubootefi.var file in ESP
>
> further assuming that multiple driver probe functions succeed:
>
> How do you identify which driver to activate?

This is really a firmware issue.  Whoever assembles that needs to make
sure there's a single entity that should manage the EFI variables.

As far as the current situation
- Qualcomm doesn't run OP-TEE and IIRC uses a DT-entry to enable that code
- OP-TEE will swap the runtime variables calls if StMM is compiled
along and the userspace supplicant is running
- We got no support for ubootefi.var.  If we ever add that the only
clash I can see is u-boot compiled with StMM support and someone
touches the ubootefi.var on ESP.

I'd really prefer to have the feature be autodetected, but if we can't
do that, perhaps we could agree on an EFI config table that the kernel
could read and interpret on what to activate on priority, or
alternatively re-purpose Qualcomms DT entry?

Regards
/Ilias

>
> Best regards
>
> Heinrich
>
> > +}
> > +
> > +static void __exit tee_stmm_efi_mod_exit(void)
> > +{
> > +     driver_unregister(&tee_stmm_efi_driver.driver);
> > +}
> > +
> > +module_init(tee_stmm_efi_mod_init);
> > +module_exit(tee_stmm_efi_mod_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> > +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> > +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");
>

--===============9211767857736282335==--

