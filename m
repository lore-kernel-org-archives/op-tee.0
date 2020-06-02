From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Tue, 02 Jun 2020 10:08:54 +0300
Message-ID: <20200602070854.GA16602@linux.intel.com>
In-Reply-To: <
 <CAFA6WYMN01WSsMhvqmtzG+hmnQ9+_MfobaH9c_LZ1wj9Z_xDjw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1830868366711237225=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1830868366711237225==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2020 at 02:20:26PM +0530, Sumit Garg wrote:
> On Mon, 1 Jun 2020 at 07:30, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Wed, May 06, 2020 at 03:10:14PM +0530, Sumit Garg wrote:
> > > Current trusted keys framework is tightly coupled to use TPM device as
> > > an underlying implementation which makes it difficult for implementatio=
ns
> > > like Trusted Execution Environment (TEE) etc. to provide trusked keys
> > > support in case platform doesn't posses a TPM device.
> > >
> > > So this patch tries to add generic trusted keys framework where underly=
ing
> > > implemtations like TPM, TEE etc. could be easily plugged-in.
> > >
> > > Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  include/keys/trusted-type.h                 |  45 ++++
> > >  include/keys/trusted_tpm.h                  |  15 --
> > >  security/keys/trusted-keys/Makefile         |   1 +
> > >  security/keys/trusted-keys/trusted_common.c | 333 ++++++++++++++++++++=
+++++++
> >
> > I think trusted_core.c would be a better name (less ambiguous).
> >
>=20
> Okay.
>=20
> > >  security/keys/trusted-keys/trusted_tpm1.c   | 335 +++++---------------=
--------
> > >  5 files changed, 437 insertions(+), 292 deletions(-)
> > >  create mode 100644 security/keys/trusted-keys/trusted_common.c
> > >
> > > diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> > > index a94c03a..5559010 100644
> > > --- a/include/keys/trusted-type.h
> > > +++ b/include/keys/trusted-type.h
> > > @@ -40,6 +40,51 @@ struct trusted_key_options {
> > >       uint32_t policyhandle;
> > >  };
> > >
> > > +struct trusted_key_ops {
> > > +     /*
> > > +      * flag to indicate if trusted key implementation supports migrat=
ion
> > > +      * or not.
> > > +      */
> > > +     unsigned char migratable;
> > > +
> > > +     /* trusted key init */
> > > +     int (*init)(void);
> >
> > /* Init a key. */
> >
>=20
> This API isn't initializing a key but rather the underlying interface
> (see init_tpm_trusted()). So how about:
>=20
> /* Initialize key interface */

Sure (also for others can use common sense).

>=20
> > > +
> > > +     /* seal a trusted key */
> > > +     int (*seal)(struct trusted_key_payload *p, char *datablob);
> >
> > /* Seal a key. */
> >
>=20
> Ack.
>=20
> > > +
> > > +     /* unseal a trusted key */
> > > +     int (*unseal)(struct trusted_key_payload *p, char *datablob);
> >
> > /* Unseal a key. */
> >
>=20
> Ack.
>=20
> > > +
> > > +     /* get random trusted key */
> > > +     int (*get_random)(unsigned char *key, size_t key_len);
> >
> > /* Get a randomized key. */
> >
>=20
> Ack.
>=20
> > > +
> > > +     /* trusted key cleanup */
> > > +     void (*cleanup)(void);
> >
> > Please remove this from this commit since it is not in use in the scope
> > of this commit. You should instead make a separate commit just for this
> > callback, which explains what it is and how it will be used in the
> > follow up commits.
> >
>=20
> This API is pretty much relevant to TPM as well (see:
> cleanup_tpm_trusted()) but I guess "cleanup()" terminology is bringing
> up some confusion, so how about to call it "exit()" instead?
>=20
> >
> > > +};
> > > +
> > >  extern struct key_type key_type_trusted;
> > > +#if defined(CONFIG_TCG_TPM)
> > > +extern struct trusted_key_ops tpm_trusted_key_ops;
> > > +#endif
> > > +
> > > +#define TRUSTED_DEBUG 0
> > > +
> > > +#if TRUSTED_DEBUG
> > > +static inline void dump_payload(struct trusted_key_payload *p)
> > > +{
> > > +     pr_info("trusted_key: key_len %d\n", p->key_len);
> > > +     print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> > > +                    16, 1, p->key, p->key_len, 0);
> > > +     pr_info("trusted_key: bloblen %d\n", p->blob_len);
> > > +     print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> > > +                    16, 1, p->blob, p->blob_len, 0);
> > > +     pr_info("trusted_key: migratable %d\n", p->migratable);
> > > +}
> > > +#else
> > > +static inline void dump_payload(struct trusted_key_payload *p)
> > > +{
> > > +}
> > > +#endif
> > >
> > >  #endif /* _KEYS_TRUSTED_TYPE_H */
> > > diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> > > index a56d8e1..5753231 100644
> > > --- a/include/keys/trusted_tpm.h
> > > +++ b/include/keys/trusted_tpm.h
> > > @@ -60,17 +60,6 @@ static inline void dump_options(struct trusted_key_o=
ptions *o)
> > >                      16, 1, o->pcrinfo, o->pcrinfo_len, 0);
> > >  }
> > >
> > > -static inline void dump_payload(struct trusted_key_payload *p)
> > > -{
> > > -     pr_info("trusted_key: key_len %d\n", p->key_len);
> > > -     print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> > > -                    16, 1, p->key, p->key_len, 0);
> > > -     pr_info("trusted_key: bloblen %d\n", p->blob_len);
> > > -     print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> > > -                    16, 1, p->blob, p->blob_len, 0);
> > > -     pr_info("trusted_key: migratable %d\n", p->migratable);
> > > -}
> > > -
> > >  static inline void dump_sess(struct osapsess *s)
> > >  {
> > >       print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NON=
E,
> > > @@ -96,10 +85,6 @@ static inline void dump_options(struct trusted_key_o=
ptions *o)
> > >  {
> > >  }
> > >
> > > -static inline void dump_payload(struct trusted_key_payload *p)
> > > -{
> > > -}
> > > -
> > >  static inline void dump_sess(struct osapsess *s)
> > >  {
> > >  }
> > > diff --git a/security/keys/trusted-keys/Makefile b/security/keys/truste=
d-keys/Makefile
> > > index 7b73ceb..2b1085b 100644
> > > --- a/security/keys/trusted-keys/Makefile
> > > +++ b/security/keys/trusted-keys/Makefile
> > > @@ -4,5 +4,6 @@
> > >  #
> > >
> > >  obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
> > > +trusted-y +=3D trusted_common.o
> > >  trusted-y +=3D trusted_tpm1.o
> > >  trusted-y +=3D trusted_tpm2.o
> > > diff --git a/security/keys/trusted-keys/trusted_common.c b/security/key=
s/trusted-keys/trusted_common.c
> > > new file mode 100644
> > > index 0000000..9bfd081
> > > --- /dev/null
> > > +++ b/security/keys/trusted-keys/trusted_common.c
> > > @@ -0,0 +1,333 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2010 IBM Corporation
> > > + * Copyright (c) 2019, Linaro Limited
> > > + *
> > > + * Author:
> > > + * David Safford <safford@us.ibm.com>
> > > + * Added generic trusted key framework: Sumit Garg <sumit.garg@linar=
o.org>
> > > + *
> > > + * See Documentation/security/keys/trusted-encrypted.rst
> > > + */
> > > +
> > > +#include <keys/user-type.h>
> > > +#include <keys/trusted-type.h>
> > > +#include <linux/capability.h>
> > > +#include <linux/err.h>
> > > +#include <linux/init.h>
> > > +#include <linux/key-type.h>
> > > +#include <linux/module.h>
> > > +#include <linux/parser.h>
> > > +#include <linux/rcupdate.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/string.h>
> > > +#include <linux/uaccess.h>
> > > +
> > > +static struct trusted_key_ops *available_tk_ops[] =3D {
> > > +#if defined(CONFIG_TCG_TPM)
> > > +     &tpm_trusted_key_ops,
> > > +#endif
> > > +};
> > > +static struct trusted_key_ops *tk_ops;
> > > +
> > > +enum {
> > > +     Opt_err,
> > > +     Opt_new, Opt_load, Opt_update,
> > > +};
> > > +
> > > +static const match_table_t key_tokens =3D {
> > > +     {Opt_new, "new"},
> > > +     {Opt_load, "load"},
> > > +     {Opt_update, "update"},
> > > +     {Opt_err, NULL}
> > > +};
> > > +
> > > +/*
> > > + * datablob_parse - parse the keyctl data and fill in the
> > > + *                  payload structure
> > > + *
> > > + * On success returns 0, otherwise -EINVAL.
> > > + */
> > > +static int datablob_parse(char *datablob, struct trusted_key_payload *=
p)
> > > +{
> > > +     substring_t args[MAX_OPT_ARGS];
> > > +     long keylen;
> > > +     int ret =3D -EINVAL;
> > > +     int key_cmd;
> > > +     char *c;
> > > +
> > > +     /* main command */
> > > +     c =3D strsep(&datablob, " \t");
> > > +     if (!c)
> > > +             return -EINVAL;
> > > +     key_cmd =3D match_token(c, key_tokens, args);
> > > +     switch (key_cmd) {
> > > +     case Opt_new:
> > > +             /* first argument is key size */
> > > +             c =3D strsep(&datablob, " \t");
> > > +             if (!c)
> > > +                     return -EINVAL;
> > > +             ret =3D kstrtol(c, 10, &keylen);
> > > +             if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_=
SIZE)
> > > +                     return -EINVAL;
> > > +             p->key_len =3D keylen;
> > > +             ret =3D Opt_new;
> > > +             break;
> > > +     case Opt_load:
> > > +             /* first argument is sealed blob */
> > > +             c =3D strsep(&datablob, " \t");
> > > +             if (!c)
> > > +                     return -EINVAL;
> > > +             p->blob_len =3D strlen(c) / 2;
> > > +             if (p->blob_len > MAX_BLOB_SIZE)
> > > +                     return -EINVAL;
> > > +             ret =3D hex2bin(p->blob, c, p->blob_len);
> > > +             if (ret < 0)
> > > +                     return -EINVAL;
> > > +             ret =3D Opt_load;
> > > +             break;
> > > +     case Opt_update:
> > > +             ret =3D Opt_update;
> > > +             break;
> > > +     case Opt_err:
> > > +             return -EINVAL;
> > > +     }
> > > +     return ret;
> > > +}
> > > +
> > > +static struct trusted_key_payload *trusted_payload_alloc(struct key *k=
ey)
> > > +{
> > > +     struct trusted_key_payload *p =3D NULL;
> > > +     int ret;
> > > +
> > > +     ret =3D key_payload_reserve(key, sizeof(*p));
> > > +     if (ret < 0)
> > > +             return p;
> > > +     p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> > > +
> > > +     p->migratable =3D tk_ops->migratable;
> > > +
> > > +     return p;
> > > +}
> > > +
> > > +/*
> > > + * trusted_instantiate - create a new trusted key
> > > + *
> > > + * Unseal an existing trusted blob or, for a new key, get a
> > > + * random key, then seal and create a trusted key-type key,
> > > + * adding it to the specified keyring.
> > > + *
> > > + * On success, return 0. Otherwise return errno.
> > > + */
> > > +static int trusted_instantiate(struct key *key,
> > > +                            struct key_preparsed_payload *prep)
> > > +{
> > > +     struct trusted_key_payload *payload =3D NULL;
> > > +     size_t datalen =3D prep->datalen;
> > > +     char *datablob;
> > > +     int ret =3D 0;
> > > +     int key_cmd;
> > > +     size_t key_len;
> > > +
> > > +     if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> > > +             return -EINVAL;
> > > +
> > > +     datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> > > +     if (!datablob)
> > > +             return -ENOMEM;
> > > +     memcpy(datablob, prep->data, datalen);
> > > +     datablob[datalen] =3D '\0';
> > > +
> > > +     payload =3D trusted_payload_alloc(key);
> > > +     if (!payload) {
> > > +             ret =3D -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +
> > > +     key_cmd =3D datablob_parse(datablob, payload);
> > > +     if (key_cmd < 0) {
> > > +             ret =3D key_cmd;
> > > +             goto out;
> > > +     }
> > > +
> > > +     dump_payload(payload);
> > > +
> > > +     switch (key_cmd) {
> > > +     case Opt_load:
> > > +             ret =3D tk_ops->unseal(payload, datablob);
> > > +             dump_payload(payload);
> > > +             if (ret < 0)
> > > +                     pr_info("trusted_key: key_unseal failed (%d)\n", =
ret);
> > > +             break;
> > > +     case Opt_new:
> > > +             key_len =3D payload->key_len;
> > > +             ret =3D tk_ops->get_random(payload->key, key_len);
> > > +             if (ret !=3D key_len) {
> > > +                     pr_info("trusted_key: key_create failed (%d)\n", =
ret);
> > > +                     goto out;
> > > +             }
> > > +
> > > +             ret =3D tk_ops->seal(payload, datablob);
> > > +             if (ret < 0)
> > > +                     pr_info("trusted_key: key_seal failed (%d)\n", re=
t);
> > > +             break;
> > > +     default:
> > > +             ret =3D -EINVAL;
> > > +     }
> > > +out:
> > > +     kzfree(datablob);
> > > +     if (!ret)
> > > +             rcu_assign_keypointer(key, payload);
> > > +     else
> > > +             kzfree(payload);
> > > +     return ret;
> > > +}
> > > +
> > > +static void trusted_rcu_free(struct rcu_head *rcu)
> > > +{
> > > +     struct trusted_key_payload *p;
> > > +
> > > +     p =3D container_of(rcu, struct trusted_key_payload, rcu);
> > > +     kzfree(p);
> > > +}
> > > +
> > > +/*
> > > + * trusted_update - reseal an existing key with new PCR values
> > > + */
> > > +static int trusted_update(struct key *key, struct key_preparsed_payloa=
d *prep)
> > > +{
> > > +     struct trusted_key_payload *p;
> > > +     struct trusted_key_payload *new_p;
> > > +     size_t datalen =3D prep->datalen;
> > > +     char *datablob;
> > > +     int ret =3D 0;
> > > +
> > > +     if (key_is_negative(key))
> > > +             return -ENOKEY;
> > > +     p =3D key->payload.data[0];
> > > +     if (!p->migratable)
> > > +             return -EPERM;
> > > +     if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> > > +             return -EINVAL;
> > > +
> > > +     datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> > > +     if (!datablob)
> > > +             return -ENOMEM;
> > > +
> > > +     new_p =3D trusted_payload_alloc(key);
> > > +     if (!new_p) {
> > > +             ret =3D -ENOMEM;
> > > +             goto out;
> > > +     }
> > > +
> > > +     memcpy(datablob, prep->data, datalen);
> > > +     datablob[datalen] =3D '\0';
> > > +     ret =3D datablob_parse(datablob, new_p);
> > > +     if (ret !=3D Opt_update) {
> > > +             ret =3D -EINVAL;
> > > +             kzfree(new_p);
> > > +             goto out;
> > > +     }
> > > +
> > > +     /* copy old key values, and reseal with new pcrs */
> > > +     new_p->migratable =3D p->migratable;
> > > +     new_p->key_len =3D p->key_len;
> > > +     memcpy(new_p->key, p->key, p->key_len);
> > > +     dump_payload(p);
> > > +     dump_payload(new_p);
> > > +
> > > +     ret =3D tk_ops->seal(new_p, datablob);
> > > +     if (ret < 0) {
> > > +             pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > > +             kzfree(new_p);
> > > +             goto out;
> > > +     }
> > > +
> > > +     rcu_assign_keypointer(key, new_p);
> > > +     call_rcu(&p->rcu, trusted_rcu_free);
> > > +out:
> > > +     kzfree(datablob);
> > > +     return ret;
> > > +}
> > > +
> > > +/*
> > > + * trusted_read - copy the sealed blob data to userspace in hex.
> > > + * On success, return to userspace the trusted key datablob size.
> > > + */
> > > +static long trusted_read(const struct key *key, char *buffer,
> > > +                      size_t buflen)
> > > +{
> > > +     const struct trusted_key_payload *p;
> > > +     char *bufp;
> > > +     int i;
> > > +
> > > +     p =3D dereference_key_locked(key);
> > > +     if (!p)
> > > +             return -EINVAL;
> > > +
> > > +     if (buffer && buflen >=3D 2 * p->blob_len) {
> > > +             bufp =3D buffer;
> > > +             for (i =3D 0; i < p->blob_len; i++)
> > > +                     bufp =3D hex_byte_pack(bufp, p->blob[i]);
> > > +     }
> > > +     return 2 * p->blob_len;
> > > +}
> > > +
> > > +/*
> > > + * trusted_destroy - clear and free the key's payload
> > > + */
> > > +static void trusted_destroy(struct key *key)
> > > +{
> > > +     kzfree(key->payload.data[0]);
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
> > > +     for (i =3D 0; i < sizeof(available_tk_ops); i++) {
> > > +             tk_ops =3D available_tk_ops[i];
> > > +
> > > +             if (!(tk_ops && tk_ops->init && tk_ops->seal &&
> > > +                   tk_ops->unseal && tk_ops->get_random))
> > > +                     continue;
> > > +
> > > +             ret =3D tk_ops->init();
> > > +             if (ret) {
> > > +                     if (tk_ops->cleanup)
> > > +                             tk_ops->cleanup();
> > > +             } else {
> > > +                     break;
> > > +             }
> > > +     }
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
> > > +     if (tk_ops->cleanup)
> > > +             tk_ops->cleanup();
> > > +}
> > > +
> > > +late_initcall(init_trusted);
> > > +module_exit(cleanup_trusted);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/=
trusted-keys/trusted_tpm1.c
> > > index 8001ab0..32fd1ea 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > > @@ -1,29 +1,26 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > >  /*
> > >   * Copyright (C) 2010 IBM Corporation
> > > + * Copyright (c) 2019, Linaro Limited
> > >   *
> > >   * Author:
> > >   * David Safford <safford@us.ibm.com>
> > > + * Switch to generic trusted key framework: Sumit Garg <sumit.garg@l=
inaro.org>
> > >   *
> > >   * See Documentation/security/keys/trusted-encrypted.rst
> > >   */
> > >
> > >  #include <crypto/hash_info.h>
> > > -#include <linux/uaccess.h>
> > > -#include <linux/module.h>
> > >  #include <linux/init.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/parser.h>
> > >  #include <linux/string.h>
> > >  #include <linux/err.h>
> > > -#include <keys/user-type.h>
> > >  #include <keys/trusted-type.h>
> > >  #include <linux/key-type.h>
> > > -#include <linux/rcupdate.h>
> > >  #include <linux/crypto.h>
> > >  #include <crypto/hash.h>
> > >  #include <crypto/sha.h>
> > > -#include <linux/capability.h>
> > >  #include <linux/tpm.h>
> > >  #include <linux/tpm_command.h>
> > >
> > > @@ -703,7 +700,6 @@ static int key_unseal(struct trusted_key_payload *p,
> > >
> > >  enum {
> > >       Opt_err,
> > > -     Opt_new, Opt_load, Opt_update,
> > >       Opt_keyhandle, Opt_keyauth, Opt_blobauth,
> > >       Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
> > >       Opt_hash,
> > > @@ -712,9 +708,6 @@ enum {
> > >  };
> > >
> > >  static const match_table_t key_tokens =3D {
> > > -     {Opt_new, "new"},
> > > -     {Opt_load, "load"},
> > > -     {Opt_update, "update"},
> > >       {Opt_keyhandle, "keyhandle=3D%s"},
> > >       {Opt_keyauth, "keyauth=3D%s"},
> > >       {Opt_blobauth, "blobauth=3D%s"},
> > > @@ -841,71 +834,6 @@ static int getoptions(char *c, struct trusted_key_=
payload *pay,
> > >       return 0;
> > >  }
> > >
> > > -/*
> > > - * datablob_parse - parse the keyctl data and fill in the
> > > - *               payload and options structures
> > > - *
> > > - * On success returns 0, otherwise -EINVAL.
> > > - */
> > > -static int datablob_parse(char *datablob, struct trusted_key_payload *=
p,
> > > -                       struct trusted_key_options *o)
> > > -{
> > > -     substring_t args[MAX_OPT_ARGS];
> > > -     long keylen;
> > > -     int ret =3D -EINVAL;
> > > -     int key_cmd;
> > > -     char *c;
> > > -
> > > -     /* main command */
> > > -     c =3D strsep(&datablob, " \t");
> > > -     if (!c)
> > > -             return -EINVAL;
> > > -     key_cmd =3D match_token(c, key_tokens, args);
> > > -     switch (key_cmd) {
> > > -     case Opt_new:
> > > -             /* first argument is key size */
> > > -             c =3D strsep(&datablob, " \t");
> > > -             if (!c)
> > > -                     return -EINVAL;
> > > -             ret =3D kstrtol(c, 10, &keylen);
> > > -             if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_=
SIZE)
> > > -                     return -EINVAL;
> > > -             p->key_len =3D keylen;
> > > -             ret =3D getoptions(datablob, p, o);
> > > -             if (ret < 0)
> > > -                     return ret;
> > > -             ret =3D Opt_new;
> > > -             break;
> > > -     case Opt_load:
> > > -             /* first argument is sealed blob */
> > > -             c =3D strsep(&datablob, " \t");
> > > -             if (!c)
> > > -                     return -EINVAL;
> > > -             p->blob_len =3D strlen(c) / 2;
> > > -             if (p->blob_len > MAX_BLOB_SIZE)
> > > -                     return -EINVAL;
> > > -             ret =3D hex2bin(p->blob, c, p->blob_len);
> > > -             if (ret < 0)
> > > -                     return -EINVAL;
> > > -             ret =3D getoptions(datablob, p, o);
> > > -             if (ret < 0)
> > > -                     return ret;
> > > -             ret =3D Opt_load;
> > > -             break;
> > > -     case Opt_update:
> > > -             /* all arguments are options */
> > > -             ret =3D getoptions(datablob, p, o);
> > > -             if (ret < 0)
> > > -                     return ret;
> > > -             ret =3D Opt_update;
> > > -             break;
> > > -     case Opt_err:
> > > -             return -EINVAL;
> > > -             break;
> > > -     }
> > > -     return ret;
> > > -}
> > > -
> > >  static struct trusted_key_options *trusted_options_alloc(void)
> > >  {
> > >       struct trusted_key_options *options;
> > > @@ -926,248 +854,99 @@ static struct trusted_key_options *trusted_optio=
ns_alloc(void)
> > >       return options;
> > >  }
> > >
> > > -static struct trusted_key_payload *trusted_payload_alloc(struct key *k=
ey)
> > > +static int tpm_tk_seal(struct trusted_key_payload *p, char *datablob)
> > >  {
> > > -     struct trusted_key_payload *p =3D NULL;
> > > -     int ret;
> > > -
> > > -     ret =3D key_payload_reserve(key, sizeof *p);
> > > -     if (ret < 0)
> > > -             return p;
> > > -     p =3D kzalloc(sizeof *p, GFP_KERNEL);
> > > -     if (p)
> > > -             p->migratable =3D 1; /* migratable by default */
> > > -     return p;
> > > -}
> > > -
> > > -/*
> > > - * trusted_instantiate - create a new trusted key
> > > - *
> > > - * Unseal an existing trusted blob or, for a new key, get a
> > > - * random key, then seal and create a trusted key-type key,
> > > - * adding it to the specified keyring.
> > > - *
> > > - * On success, return 0. Otherwise return errno.
> > > - */
> > > -static int trusted_instantiate(struct key *key,
> > > -                            struct key_preparsed_payload *prep)
> > > -{
> > > -     struct trusted_key_payload *payload =3D NULL;
> > >       struct trusted_key_options *options =3D NULL;
> > > -     size_t datalen =3D prep->datalen;
> > > -     char *datablob;
> > >       int ret =3D 0;
> > > -     int key_cmd;
> > > -     size_t key_len;
> > >       int tpm2;
> > >
> > >       tpm2 =3D tpm_is_tpm2(chip);
> > >       if (tpm2 < 0)
> > >               return tpm2;
> > >
> > > -     if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> > > -             return -EINVAL;
> > > -
> > > -     datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> > > -     if (!datablob)
> > > -             return -ENOMEM;
> > > -     memcpy(datablob, prep->data, datalen);
> > > -     datablob[datalen] =3D '\0';
> > > -
> > >       options =3D trusted_options_alloc();
> > > -     if (!options) {
> > > -             ret =3D -ENOMEM;
> > > -             goto out;
> > > -     }
> > > -     payload =3D trusted_payload_alloc(key);
> > > -     if (!payload) {
> > > -             ret =3D -ENOMEM;
> > > -             goto out;
> > > -     }
> > > +     if (!options)
> > > +             return -ENOMEM;
> > >
> > > -     key_cmd =3D datablob_parse(datablob, payload, options);
> > > -     if (key_cmd < 0) {
> > > -             ret =3D key_cmd;
> > > +     ret =3D getoptions(datablob, p, options);
> > > +     if (ret < 0)
> > >               goto out;
> > > -     }
> > > +     dump_options(options);
> > >
> > >       if (!options->keyhandle) {
> > >               ret =3D -EINVAL;
> > >               goto out;
> > >       }
> > >
> > > -     dump_payload(payload);
> > > -     dump_options(options);
> > > +     if (tpm2)
> > > +             ret =3D tpm2_seal_trusted(chip, p, options);
> > > +     else
> > > +             ret =3D key_seal(p, options);
> > > +     if (ret < 0) {
> > > +             pr_info("tpm_trusted_key: key_seal failed (%d)\n", ret);
> > > +             goto out;
> > > +     }
> > >
> > > -     switch (key_cmd) {
> > > -     case Opt_load:
> > > -             if (tpm2)
> > > -                     ret =3D tpm2_unseal_trusted(chip, payload, option=
s);
> > > -             else
> > > -                     ret =3D key_unseal(payload, options);
> > > -             dump_payload(payload);
> > > -             dump_options(options);
> > > -             if (ret < 0)
> > > -                     pr_info("trusted_key: key_unseal failed (%d)\n", =
ret);
> > > -             break;
> > > -     case Opt_new:
> > > -             key_len =3D payload->key_len;
> > > -             ret =3D tpm_get_random(chip, payload->key, key_len);
> > > -             if (ret !=3D key_len) {
> > > -                     pr_info("trusted_key: key_create failed (%d)\n", =
ret);
> > > +     if (options->pcrlock) {
> > > +             ret =3D pcrlock(options->pcrlock);
> > > +             if (ret < 0) {
> > > +                     pr_info("tpm_trusted_key: pcrlock failed (%d)\n",=
 ret);
> > >                       goto out;
> > >               }
> > > -             if (tpm2)
> > > -                     ret =3D tpm2_seal_trusted(chip, payload, options);
> > > -             else
> > > -                     ret =3D key_seal(payload, options);
> > > -             if (ret < 0)
> > > -                     pr_info("trusted_key: key_seal failed (%d)\n", re=
t);
> > > -             break;
> > > -     default:
> > > -             ret =3D -EINVAL;
> > > -             goto out;
> > >       }
> > > -     if (!ret && options->pcrlock)
> > > -             ret =3D pcrlock(options->pcrlock);
> > >  out:
> > > -     kzfree(datablob);
> > >       kzfree(options);
> > > -     if (!ret)
> > > -             rcu_assign_keypointer(key, payload);
> > > -     else
> > > -             kzfree(payload);
> > >       return ret;
> > >  }
> > >
> > > -static void trusted_rcu_free(struct rcu_head *rcu)
> > > +static int tpm_tk_unseal(struct trusted_key_payload *p, char *datablob)
> > >  {
> > > -     struct trusted_key_payload *p;
> > > -
> > > -     p =3D container_of(rcu, struct trusted_key_payload, rcu);
> > > -     kzfree(p);
> > > -}
> > > -
> > > -/*
> > > - * trusted_update - reseal an existing key with new PCR values
> > > - */
> > > -static int trusted_update(struct key *key, struct key_preparsed_payloa=
d *prep)
> > > -{
> > > -     struct trusted_key_payload *p;
> > > -     struct trusted_key_payload *new_p;
> > > -     struct trusted_key_options *new_o;
> > > -     size_t datalen =3D prep->datalen;
> > > -     char *datablob;
> > > +     struct trusted_key_options *options =3D NULL;
> > >       int ret =3D 0;
> > > +     int tpm2;
> > >
> > > -     if (key_is_negative(key))
> > > -             return -ENOKEY;
> > > -     p =3D key->payload.data[0];
> > > -     if (!p->migratable)
> > > -             return -EPERM;
> > > -     if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> > > -             return -EINVAL;
> > > +     tpm2 =3D tpm_is_tpm2(chip);
> > > +     if (tpm2 < 0)
> > > +             return tpm2;
> > >
> > > -     datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> > > -     if (!datablob)
> > > +     options =3D trusted_options_alloc();
> > > +     if (!options)
> > >               return -ENOMEM;
> > > -     new_o =3D trusted_options_alloc();
> > > -     if (!new_o) {
> > > -             ret =3D -ENOMEM;
> > > -             goto out;
> > > -     }
> > > -     new_p =3D trusted_payload_alloc(key);
> > > -     if (!new_p) {
> > > -             ret =3D -ENOMEM;
> > > -             goto out;
> > > -     }
> > >
> > > -     memcpy(datablob, prep->data, datalen);
> > > -     datablob[datalen] =3D '\0';
> > > -     ret =3D datablob_parse(datablob, new_p, new_o);
> > > -     if (ret !=3D Opt_update) {
> > > -             ret =3D -EINVAL;
> > > -             kzfree(new_p);
> > > +     ret =3D getoptions(datablob, p, options);
> > > +     if (ret < 0)
> > >               goto out;
> > > -     }
> > > +     dump_options(options);
> > >
> > > -     if (!new_o->keyhandle) {
> > > +     if (!options->keyhandle) {
> > >               ret =3D -EINVAL;
> > > -             kzfree(new_p);
> > >               goto out;
> > >       }
> > >
> > > -     /* copy old key values, and reseal with new pcrs */
> > > -     new_p->migratable =3D p->migratable;
> > > -     new_p->key_len =3D p->key_len;
> > > -     memcpy(new_p->key, p->key, p->key_len);
> > > -     dump_payload(p);
> > > -     dump_payload(new_p);
> > > +     if (tpm2)
> > > +             ret =3D tpm2_unseal_trusted(chip, p, options);
> > > +     else
> > > +             ret =3D key_unseal(p, options);
> > > +     if (ret < 0)
> > > +             pr_info("tpm_trusted_key: key_unseal failed (%d)\n", ret);
> > >
> > > -     ret =3D key_seal(new_p, new_o);
> > > -     if (ret < 0) {
> > > -             pr_info("trusted_key: key_seal failed (%d)\n", ret);
> > > -             kzfree(new_p);
> > > -             goto out;
> > > -     }
> > > -     if (new_o->pcrlock) {
> > > -             ret =3D pcrlock(new_o->pcrlock);
> > > +     if (options->pcrlock) {
> > > +             ret =3D pcrlock(options->pcrlock);
> > >               if (ret < 0) {
> > > -                     pr_info("trusted_key: pcrlock failed (%d)\n", ret=
);
> > > -                     kzfree(new_p);
> > > +                     pr_info("tpm_trusted_key: pcrlock failed (%d)\n",=
 ret);
> > >                       goto out;
> > >               }
> > >       }
> > > -     rcu_assign_keypointer(key, new_p);
> > > -     call_rcu(&p->rcu, trusted_rcu_free);
> > >  out:
> > > -     kzfree(datablob);
> > > -     kzfree(new_o);
> > > +     kzfree(options);
> > >       return ret;
> > >  }
> > >
> > > -/*
> > > - * trusted_read - copy the sealed blob data to userspace in hex.
> > > - * On success, return to userspace the trusted key datablob size.
> > > - */
> > > -static long trusted_read(const struct key *key, char *buffer,
> > > -                      size_t buflen)
> > > -{
> > > -     const struct trusted_key_payload *p;
> > > -     char *bufp;
> > > -     int i;
> > > -
> > > -     p =3D dereference_key_locked(key);
> > > -     if (!p)
> > > -             return -EINVAL;
> > > -
> > > -     if (buffer && buflen >=3D 2 * p->blob_len) {
> > > -             bufp =3D buffer;
> > > -             for (i =3D 0; i < p->blob_len; i++)
> > > -                     bufp =3D hex_byte_pack(bufp, p->blob[i]);
> > > -     }
> > > -     return 2 * p->blob_len;
> > > -}
> > > -
> > > -/*
> > > - * trusted_destroy - clear and free the key's payload
> > > - */
> > > -static void trusted_destroy(struct key *key)
> > > +int tpm_tk_get_random(unsigned char *key, size_t key_len)
> > >  {
> > > -     kzfree(key->payload.data[0]);
> > > +     return tpm_get_random(chip, key, key_len);
> > >  }
> > >
> > > -struct key_type key_type_trusted =3D {
> > > -     .name =3D "trusted",
> > > -     .instantiate =3D trusted_instantiate,
> > > -     .update =3D trusted_update,
> > > -     .destroy =3D trusted_destroy,
> > > -     .describe =3D user_describe,
> > > -     .read =3D trusted_read,
> > > -};
> > > -
> > > -EXPORT_SYMBOL_GPL(key_type_trusted);
> > > -
> > >  static void trusted_shash_release(void)
> > >  {
> > >       if (hashalg)
> > > @@ -1182,14 +961,14 @@ static int __init trusted_shash_alloc(void)
> > >
> > >       hmacalg =3D crypto_alloc_shash(hmac_alg, 0, 0);
> > >       if (IS_ERR(hmacalg)) {
> > > -             pr_info("trusted_key: could not allocate crypto %s\n",
> > > +             pr_info("tpm_trusted_key: could not allocate crypto %s\n",
> > >                       hmac_alg);
> > >               return PTR_ERR(hmacalg);
> > >       }
> > >
> > >       hashalg =3D crypto_alloc_shash(hash_alg, 0, 0);
> > >       if (IS_ERR(hashalg)) {
> > > -             pr_info("trusted_key: could not allocate crypto %s\n",
> > > +             pr_info("tpm_trusted_key: could not allocate crypto %s\n",
> > >                       hash_alg);
> > >               ret =3D PTR_ERR(hashalg);
> > >               goto hashalg_fail;
> > > @@ -1217,16 +996,13 @@ static int __init init_digests(void)
> > >       return 0;
> > >  }
> > >
> > > -static int __init init_trusted(void)
> > > +static int __init init_tpm_trusted(void)
> > >  {
> > >       int ret;
> > >
> > > -     /* encrypted_keys.ko depends on successful load of this module ev=
en if
> > > -      * TPM is not used.
> > > -      */
> > >       chip =3D tpm_default_chip();
> > >       if (!chip)
> > > -             return 0;
> > > +             return -ENODEV;
> > >
> > >       ret =3D init_digests();
> > >       if (ret < 0)
> > > @@ -1247,7 +1023,7 @@ static int __init init_trusted(void)
> > >       return ret;
> > >  }
> > >
> > > -static void __exit cleanup_trusted(void)
> > > +static void __exit cleanup_tpm_trusted(void)
> > >  {
> > >       if (chip) {
> > >               put_device(&chip->dev);
> > > @@ -1257,7 +1033,12 @@ static void __exit cleanup_trusted(void)
> > >       }
> > >  }
> > >
> > > -late_initcall(init_trusted);
> > > -module_exit(cleanup_trusted);
> > > -
> > > -MODULE_LICENSE("GPL");
> > > +struct trusted_key_ops tpm_trusted_key_ops =3D {
> > > +     .migratable =3D 1, /* migratable by default */
> > > +     .init =3D init_tpm_trusted,
> > > +     .seal =3D tpm_tk_seal,
> > > +     .unseal =3D tpm_tk_unseal,
> > > +     .get_random =3D tpm_tk_get_random,
> > > +     .cleanup =3D cleanup_tpm_trusted,
> > > +};
> > > +EXPORT_SYMBOL_GPL(tpm_trusted_key_ops);
> >
> > Everywhere: do not use 'tk'. Use 'trusted' in those places. We do not
> > want a new acronym.
>=20
> Okay.
>=20
> -Sumit
>=20
> >
> > /Jarkko

--===============1830868366711237225==--

