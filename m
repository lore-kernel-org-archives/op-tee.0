From: Mimi Zohar <zohar@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Wed, 21 Oct 2020 08:25:31 -0400
Message-ID: <7b2ccd620a9de5c2fd57b8e8aeb41d5476f83b28.camel@linux.ibm.com>
In-Reply-To: <
 <CAFA6WYM7aJwP9j_ayGvbJPu-cyv87rsm9N4Wj2OCOMnmfDx+Rw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6206491887743815823=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6206491887743815823==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-10-21 at 11:16 +0530, Sumit Garg wrote:
> Thanks Mimi for your comments.
>=20
> On Wed, 21 Oct 2020 at 08:51, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >
> > On Wed, 2020-10-07 at 15:37 +0530, Sumit Garg wrote:
> >
> > > +/*
> > > + * trusted_destroy - clear and free the key's payload
> > > + */
> > > +static void trusted_destroy(struct key *key)
> > > +{
> > > +     kfree_sensitive(key->payload.data[0]);
> > > +}
> > > +
> > > +struct key_type key_type_trusted =3D {
> > > +     .name =3D "trusted",
> > > +     .instantiate =3D trusted_instantiate,
> > > +     .update =3D trusted_update,
> > > +     .destroy =3D trusted_destroy,
> > > +     .describe =3D user_describe,
> > > +     .read =3D trusted_read,
> > > +};
> > > +EXPORT_SYMBOL_GPL(key_type_trusted);
> > > +
> > > +static int __init init_trusted(void)
> > > +{
> > > +     int i, ret =3D 0;
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> > > +             if (trusted_key_source &&
> > > +                 strncmp(trusted_key_source, trusted_key_sources[i].na=
me,
> > > +                         strlen(trusted_key_sources[i].name)))
> > > +                     continue;
> > > +
> > > +             trusted_key_ops =3D trusted_key_sources[i].ops;
> > > +
> > > +             ret =3D trusted_key_ops->init();
> > > +             if (!ret)
> > > +                     break;
> > > +     }
> >
> > In the case when the module paramater isn't specified and both TPM and
> > TEE are enabled, trusted_key_ops is set to the last source initialized.
>=20
> I guess there is some misunderstanding. Here it's only a single trust
> source (TPM *or* TEE) is initialized and only that trust source would
> be active at runtime. And trusted_key_ops would be initialized to the
> first trust source whose initialization is successful (see check: "if
> (!ret)").

My mistake.

>=20
> > After patch 2/4, the last trusted source initialized is TEE.  If the
> > intention is to limit it to either TPM or TEE, then trusted_key_ops
> > should have a default value, which could be overwritten at runtime.
> > That would address Luke Hind's concerns of making the decision at
> > compile time.
>=20
> I think traversing the trust source list with the initial value being
> TPM would be default value.

Agreed
>=20
> >
> > trusted_key_ops should be defined as __ro_after_init, like is currently
> > done for other LSM structures.
>=20
> Sure, will do.

Thanks
>=20
> >
> > > +
> > > +     /*
> > > +      * encrypted_keys.ko depends on successful load of this module ev=
en if
> > > +      * trusted key implementation is not found.
> > > +      */
> > > +     if (ret =3D=3D -ENODEV)
> > > +             return 0;
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static void __exit cleanup_trusted(void)
> > > +{
> > > +     trusted_key_ops->exit();
> >
> > If the intention is really to support both TPM and TEE trusted keys at
> > the same time, as James suggested, then the same "for" loop as in
> > init_trusted() is needed here and probably elsewhere.
>=20
> Current intention is to only support a single trust source (TPM or
> TEE) at runtime. But in future if there are use-cases then framework
> can be extended to support multiple trust sources at runtime as well.

Ok, the last sentence of the patch description, "Also, add a module
parameter in order to select a particular trust source in case a
platform support multiple trust sources.", needs to be expanded to:
- indicate only one trust source at a time is supported
- indicate the default, if the module_param is not specified

I would also change the word from "add" to "define".   The new "source"
module parameter needs to be added to the admin-guide/kernel-parameters=20
documentation.

thanks,

Mimi  =20



--===============6206491887743815823==--

