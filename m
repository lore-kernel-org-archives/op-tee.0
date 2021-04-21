From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v9 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Wed, 21 Apr 2021 16:38:13 +0530
Message-ID: 
 <CAFA6WYOzD-qhHrcnzvd9P7iFvEqWwf0NCKXrgrEgvnB5i_-SxQ@mail.gmail.com>
In-Reply-To: <65dcc9fa28833e6beb1eadf98b0ed3402404d693.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7132006546049236651=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7132006546049236651==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Wed, 21 Apr 2021 at 04:47, James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2021-03-01 at 18:41 +0530, Sumit Garg wrote:
> > Current trusted keys framework is tightly coupled to use TPM device
> > as an underlying implementation which makes it difficult for
> > implementations like Trusted Execution Environment (TEE) etc. to
> > provide trusted keys support in case platform doesn't posses a TPM
> > device.
> >
> > Add a generic trusted keys framework where underlying implementations
> > can be easily plugged in. Create struct trusted_key_ops to achieve
> > this, which contains necessary functions of a backend.
> >
> > Also, define a module parameter in order to select a particular trust
> > source in case a platform support multiple trust sources. In case its
> > not specified then implementation itetrates through trust sources
> > list starting with TPM and assign the first trust source as a backend
> > which has initiazed successfully during iteration.
> >
> > Note that current implementation only supports a single trust source
> > at runtime which is either selectable at compile time or during boot
> > via aforementioned module parameter.
>
> You never actually tested this, did you?  I'm now getting EINVAL from
> all the trusted TPM key operations because of this patch.
>

Unfortunately, I don't possess a development machine with a TPM
device. So mine testing was entirely based on TEE as a backend which
doesn't support any optional parameters. And that being the reason I
didn't catch this issue at first instance.

Is there any TPM emulation environment available that I can use for testing?

> The reason is quite simple:  this function:
>
> > index 000000000000..0db86b44605d
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/trusted_core.c
> [...]
> > +static int datablob_parse(char *datablob, struct trusted_key_payload
> > *p)
> > +{
> > +     substring_t args[MAX_OPT_ARGS];
> > +     long keylen;
> > +     int ret =3D -EINVAL;
> > +     int key_cmd;
> > +     char *c;
> > +
> > +     /* main command */
> > +     c =3D strsep(&datablob, " \t");
>
> Modifies its argument to consume tokens and separates them with NULL.
>
> so the arguments for
>
> keyctl add trusted kmk "new 34 keyhandle=3D0x81000001"
>
> Go into this function as
>
> datablob=3D"new 34 keyhandle=3D0x81000001"
>
> After we leave it, it looks like
>
> datablob=3D"new\034\0keyhandle=3D0x81000001"
>
> However here:
>
> > +static int trusted_instantiate(struct key *key,
> > +                            struct key_preparsed_payload *prep)
> > +{
> > +     struct trusted_key_payload *payload =3D NULL;
> > +     size_t datalen =3D prep->datalen;
> > +     char *datablob;
> > +     int ret =3D 0;
> > +     int key_cmd;
> > +     size_t key_len;
> > +
> > +     if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> > +             return -EINVAL;
> > +
> > +     datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> > +     if (!datablob)
> > +             return -ENOMEM;
> > +     memcpy(datablob, prep->data, datalen);
> > +     datablob[datalen] =3D '\0';
> > +
> > +     payload =3D trusted_payload_alloc(key);
> > +     if (!payload) {
> > +             ret =3D -ENOMEM;
> > +             goto out;
> > +     }
> > +
> > +     key_cmd =3D datablob_parse(datablob, payload);
> > +     if (key_cmd < 0) {
> > +             ret =3D key_cmd;
> > +             goto out;
> > +     }
> > +
> > +     dump_payload(payload);
> > +
> > +     switch (key_cmd) {
> > +     case Opt_load:
> > +             ret =3D static_call(trusted_key_unseal)(payload,
> > datablob);
>
> We're passing the unmodified
>
> datablob=3D"new\034\0keyhandle=3D0x81000001"
>
> Into the tpm trusted_key_unseal function.  However, it only sees "new"
> and promply gives EINVAL because you've removed the ability to process
> the new option from it.  What should have happened is you should have
> moved data blob up to passed the consumed tokens, so it actually reads
>
> datablob=3D"keyhandle=3D0x81000001"
>
> However, to do that you'd have to have the updated pointer passed out
> of your datablob_parse() above.

Thanks for the detailed explanation.

>
> There's also a lost !tpm2 in the check for options->keyhandle, but I
> suspect Jarkko lost that merging the two patches.  I think what's below
> fixes all of this, so if you can test it for trusted_tee, I'll package
> it up as two separate patches fixing all of this.
>

Below fixes look good to me and I have tested them using TEE as a
backend too. So feel free to add:

Tested-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> James
>
> ---
>
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trus=
ted-keys/trusted_core.c
> index ec3a066a4b42..7c636212429b 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -62,7 +62,7 @@ static const match_table_t key_tokens =3D {
>   *
>   * On success returns 0, otherwise -EINVAL.
>   */
> -static int datablob_parse(char *datablob, struct trusted_key_payload *p)
> +static int datablob_parse(char **datablob, struct trusted_key_payload *p)
>  {
>         substring_t args[MAX_OPT_ARGS];
>         long keylen;
> @@ -71,14 +71,14 @@ static int datablob_parse(char *datablob, struct truste=
d_key_payload *p)
>         char *c;
>
>         /* main command */
> -       c =3D strsep(&datablob, " \t");
> +       c =3D strsep(datablob, " \t");
>         if (!c)
>                 return -EINVAL;
>         key_cmd =3D match_token(c, key_tokens, args);
>         switch (key_cmd) {
>         case Opt_new:
>                 /* first argument is key size */
> -               c =3D strsep(&datablob, " \t");
> +               c =3D strsep(datablob, " \t");
>                 if (!c)
>                         return -EINVAL;
>                 ret =3D kstrtol(c, 10, &keylen);
> @@ -89,7 +89,7 @@ static int datablob_parse(char *datablob, struct trusted_=
key_payload *p)
>                 break;
>         case Opt_load:
>                 /* first argument is sealed blob */
> -               c =3D strsep(&datablob, " \t");
> +               c =3D strsep(datablob, " \t");
>                 if (!c)
>                         return -EINVAL;
>                 p->blob_len =3D strlen(c) / 2;
> @@ -138,7 +138,7 @@ static int trusted_instantiate(struct key *key,
>  {
>         struct trusted_key_payload *payload =3D NULL;
>         size_t datalen =3D prep->datalen;
> -       char *datablob;
> +       char *datablob, *orig_datablob;
>         int ret =3D 0;
>         int key_cmd;
>         size_t key_len;
> @@ -146,7 +146,7 @@ static int trusted_instantiate(struct key *key,
>         if (datalen <=3D 0 || datalen > 32767 || !prep->data)
>                 return -EINVAL;
>
> -       datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> +       orig_datablob =3D datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
>         if (!datablob)
>                 return -ENOMEM;
>         memcpy(datablob, prep->data, datalen);
> @@ -158,7 +158,7 @@ static int trusted_instantiate(struct key *key,
>                 goto out;
>         }
>
> -       key_cmd =3D datablob_parse(datablob, payload);
> +       key_cmd =3D datablob_parse(&datablob, payload);
>         if (key_cmd < 0) {
>                 ret =3D key_cmd;
>                 goto out;
> @@ -194,7 +194,7 @@ static int trusted_instantiate(struct key *key,
>                 ret =3D -EINVAL;
>         }
>  out:
> -       kfree_sensitive(datablob);
> +       kfree_sensitive(orig_datablob);
>         if (!ret)
>                 rcu_assign_keypointer(key, payload);
>         else
> @@ -218,7 +218,7 @@ static int trusted_update(struct key *key, struct key_p=
reparsed_payload *prep)
>         struct trusted_key_payload *p;
>         struct trusted_key_payload *new_p;
>         size_t datalen =3D prep->datalen;
> -       char *datablob;
> +       char *datablob, *orig_datablob;
>         int ret =3D 0;
>
>         if (key_is_negative(key))
> @@ -229,7 +229,7 @@ static int trusted_update(struct key *key, struct key_p=
reparsed_payload *prep)
>         if (datalen <=3D 0 || datalen > 32767 || !prep->data)
>                 return -EINVAL;
>
> -       datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> +       orig_datablob =3D datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
>         if (!datablob)
>                 return -ENOMEM;
>
> @@ -241,7 +241,7 @@ static int trusted_update(struct key *key, struct key_p=
reparsed_payload *prep)
>
>         memcpy(datablob, prep->data, datalen);
>         datablob[datalen] =3D '\0';
> -       ret =3D datablob_parse(datablob, new_p);
> +       ret =3D datablob_parse(&datablob, new_p);
>         if (ret !=3D Opt_update) {
>                 ret =3D -EINVAL;
>                 kfree_sensitive(new_p);
> @@ -265,7 +265,7 @@ static int trusted_update(struct key *key, struct key_p=
reparsed_payload *prep)
>         rcu_assign_keypointer(key, new_p);
>         call_rcu(&p->rcu, trusted_rcu_free);
>  out:
> -       kfree_sensitive(datablob);
> +       kfree_sensitive(orig_datablob);
>         return ret;
>  }
>
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trus=
ted-keys/trusted_tpm1.c
> index 4e5c50138f92..bc702ba0a596 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -747,6 +747,9 @@ static int getoptions(char *c, struct trusted_key_paylo=
ad *pay,
>
>         opt->hash =3D tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>
> +       if (!c)
> +               return 0;
> +
>         while ((p =3D strsep(&c, " \t"))) {
>                 if (*p =3D=3D '\0' || *p =3D=3D ' ' || *p =3D=3D '\t')
>                         continue;
> @@ -944,7 +947,7 @@ static int trusted_tpm_unseal(struct trusted_key_payloa=
d *p, char *datablob)
>                 goto out;
>         dump_options(options);
>
> -       if (!options->keyhandle) {
> +       if (!options->keyhandle && !tpm2) {
>                 ret =3D -EINVAL;
>                 goto out;
>         }
>
>

--===============7132006546049236651==--

