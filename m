From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Wed, 21 Oct 2020 11:16:33 +0530
Message-ID: 
 <CAFA6WYM7aJwP9j_ayGvbJPu-cyv87rsm9N4Wj2OCOMnmfDx+Rw@mail.gmail.com>
In-Reply-To: <8e07f9401c9f7e18fb1453b7b290472c0049c6e6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8135532445806613765=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8135532445806613765==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks Mimi for your comments.

On Wed, 21 Oct 2020 at 08:51, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Wed, 2020-10-07 at 15:37 +0530, Sumit Garg wrote:
>
> > +/*
> > + * trusted_destroy - clear and free the key's payload
> > + */
> > +static void trusted_destroy(struct key *key)
> > +{
> > +     kfree_sensitive(key->payload.data[0]);
> > +}
> > +
> > +struct key_type key_type_trusted =3D {
> > +     .name =3D "trusted",
> > +     .instantiate =3D trusted_instantiate,
> > +     .update =3D trusted_update,
> > +     .destroy =3D trusted_destroy,
> > +     .describe =3D user_describe,
> > +     .read =3D trusted_read,
> > +};
> > +EXPORT_SYMBOL_GPL(key_type_trusted);
> > +
> > +static int __init init_trusted(void)
> > +{
> > +     int i, ret =3D 0;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > +             if (trusted_key_source &&
> > +                 strncmp(trusted_key_source, trusted_key_sources[i].name,
> > +                         strlen(trusted_key_sources[i].name)))
> > +                     continue;
> > +
> > +             trusted_key_ops =3D trusted_key_sources[i].ops;
> > +
> > +             ret =3D trusted_key_ops->init();
> > +             if (!ret)
> > +                     break;
> > +     }
>
> In the case when the module paramater isn't specified and both TPM and
> TEE are enabled, trusted_key_ops is set to the last source initialized.

I guess there is some misunderstanding. Here it's only a single trust
source (TPM *or* TEE) is initialized and only that trust source would
be active at runtime. And trusted_key_ops would be initialized to the
first trust source whose initialization is successful (see check: "if
(!ret)").

> After patch 2/4, the last trusted source initialized is TEE.  If the
> intention is to limit it to either TPM or TEE, then trusted_key_ops
> should have a default value, which could be overwritten at runtime.
> That would address Luke Hind's concerns of making the decision at
> compile time.

I think traversing the trust source list with the initial value being
TPM would be default value.

>
> trusted_key_ops should be defined as __ro_after_init, like is currently
> done for other LSM structures.

Sure, will do.

>
> > +
> > +     /*
> > +      * encrypted_keys.ko depends on successful load of this module even=
 if
> > +      * trusted key implementation is not found.
> > +      */
> > +     if (ret =3D=3D -ENODEV)
> > +             return 0;
> > +
> > +     return ret;
> > +}
> > +
> > +static void __exit cleanup_trusted(void)
> > +{
> > +     trusted_key_ops->exit();
>
> If the intention is really to support both TPM and TEE trusted keys at
> the same time, as James suggested, then the same "for" loop as in
> init_trusted() is needed here and probably elsewhere.

Current intention is to only support a single trust source (TPM or
TEE) at runtime. But in future if there are use-cases then framework
can be extended to support multiple trust sources at runtime as well.

-Sumit

>
> thanks,
>
> Mimi
>

--===============8135532445806613765==--

