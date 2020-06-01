From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Mon, 01 Jun 2020 05:11:32 +0300
Message-ID: <20200601021132.GA796225@linux.intel.com>
In-Reply-To: <1588758017-30426-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4301301742972059515=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4301301742972059515==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2020 at 03:10:14PM +0530, Sumit Garg wrote:
> Current trusted keys framework is tightly coupled to use TPM device as
> an underlying implementation which makes it difficult for implementations
> like Trusted Execution Environment (TEE) etc. to provide trusked keys
> support in case platform doesn't posses a TPM device.
>=20
> So this patch tries to add generic trusted keys framework where underlying
> implemtations like TPM, TEE etc. could be easily plugged-in.
>=20
> Suggested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  include/keys/trusted-type.h                 |  45 ++++
>  include/keys/trusted_tpm.h                  |  15 --
>  security/keys/trusted-keys/Makefile         |   1 +
>  security/keys/trusted-keys/trusted_common.c | 333 ++++++++++++++++++++++++=
+++
>  security/keys/trusted-keys/trusted_tpm1.c   | 335 +++++-------------------=
----
>  5 files changed, 437 insertions(+), 292 deletions(-)
>  create mode 100644 security/keys/trusted-keys/trusted_common.c
>=20
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index a94c03a..5559010 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -40,6 +40,51 @@ struct trusted_key_options {
>  	uint32_t policyhandle;
>  };
> =20
> +struct trusted_key_ops {
> +	/*
> +	 * flag to indicate if trusted key implementation supports migration
> +	 * or not.
> +	 */
> +	unsigned char migratable;
> +
> +	/* trusted key init */
> +	int (*init)(void);
> +
> +	/* seal a trusted key */
> +	int (*seal)(struct trusted_key_payload *p, char *datablob);
> +
> +	/* unseal a trusted key */
> +	int (*unseal)(struct trusted_key_payload *p, char *datablob);
> +
> +	/* get random trusted key */
> +	int (*get_random)(unsigned char *key, size_t key_len);
> +
> +	/* trusted key cleanup */
> +	void (*cleanup)(void);
> +};
> +
>  extern struct key_type key_type_trusted;
> +#if defined(CONFIG_TCG_TPM)
> +extern struct trusted_key_ops tpm_trusted_key_ops;
> +#endif
> +
> +#define TRUSTED_DEBUG 0
> +
> +#if TRUSTED_DEBUG
> +static inline void dump_payload(struct trusted_key_payload *p)
> +{
> +	pr_info("trusted_key: key_len %d\n", p->key_len);
> +	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> +		       16, 1, p->key, p->key_len, 0);
> +	pr_info("trusted_key: bloblen %d\n", p->blob_len);
> +	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> +		       16, 1, p->blob, p->blob_len, 0);
> +	pr_info("trusted_key: migratable %d\n", p->migratable);
> +}
> +#else
> +static inline void dump_payload(struct trusted_key_payload *p)
> +{
> +}
> +#endif
> =20
>  #endif /* _KEYS_TRUSTED_TYPE_H */
> diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
> index a56d8e1..5753231 100644
> --- a/include/keys/trusted_tpm.h
> +++ b/include/keys/trusted_tpm.h
> @@ -60,17 +60,6 @@ static inline void dump_options(struct trusted_key_optio=
ns *o)
>  		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
>  }
> =20
> -static inline void dump_payload(struct trusted_key_payload *p)
> -{
> -	pr_info("trusted_key: key_len %d\n", p->key_len);
> -	print_hex_dump(KERN_INFO, "key ", DUMP_PREFIX_NONE,
> -		       16, 1, p->key, p->key_len, 0);
> -	pr_info("trusted_key: bloblen %d\n", p->blob_len);
> -	print_hex_dump(KERN_INFO, "blob ", DUMP_PREFIX_NONE,
> -		       16, 1, p->blob, p->blob_len, 0);
> -	pr_info("trusted_key: migratable %d\n", p->migratable);
> -}
> -
>  static inline void dump_sess(struct osapsess *s)
>  {
>  	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
> @@ -96,10 +85,6 @@ static inline void dump_options(struct trusted_key_optio=
ns *o)
>  {
>  }
> =20
> -static inline void dump_payload(struct trusted_key_payload *p)
> -{
> -}
> -
>  static inline void dump_sess(struct osapsess *s)
>  {
>  }
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-ke=
ys/Makefile
> index 7b73ceb..2b1085b 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -4,5 +4,6 @@
>  #
> =20
>  obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
> +trusted-y +=3D trusted_common.o
>  trusted-y +=3D trusted_tpm1.o
>  trusted-y +=3D trusted_tpm2.o
> diff --git a/security/keys/trusted-keys/trusted_common.c b/security/keys/tr=
usted-keys/trusted_common.c
> new file mode 100644
> index 0000000..9bfd081
> --- /dev/null
> +++ b/security/keys/trusted-keys/trusted_common.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2010 IBM Corporation
> + * Copyright (c) 2019, Linaro Limited
> + *
> + * Author:
> + * David Safford <safford@us.ibm.com>
> + * Added generic trusted key framework: Sumit Garg <sumit.garg@linaro.or=
g>
> + *
> + * See Documentation/security/keys/trusted-encrypted.rst
> + */
> +
> +#include <keys/user-type.h>
> +#include <keys/trusted-type.h>
> +#include <linux/capability.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/key-type.h>
> +#include <linux/module.h>
> +#include <linux/parser.h>
> +#include <linux/rcupdate.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +
> +static struct trusted_key_ops *available_tk_ops[] =3D {
> +#if defined(CONFIG_TCG_TPM)
> +	&tpm_trusted_key_ops,
> +#endif
> +};

This, I think is wrong. You should have a compile time flag for TPM e.g.
CONFIG_TRUSTED_TPM, not this dynamic mess.

Please make the whole choice compile time, not run-time.

> +static struct trusted_key_ops *tk_ops;
> +
> +enum {
> +	Opt_err,
> +	Opt_new, Opt_load, Opt_update,
> +};
> +
> +static const match_table_t key_tokens =3D {
> +	{Opt_new, "new"},
> +	{Opt_load, "load"},
> +	{Opt_update, "update"},
> +	{Opt_err, NULL}
> +};
> +
> +/*
> + * datablob_parse - parse the keyctl data and fill in the
> + *                  payload structure
> + *
> + * On success returns 0, otherwise -EINVAL.
> + */
> +static int datablob_parse(char *datablob, struct trusted_key_payload *p)
> +{
> +	substring_t args[MAX_OPT_ARGS];
> +	long keylen;
> +	int ret =3D -EINVAL;
> +	int key_cmd;
> +	char *c;
> +
> +	/* main command */
> +	c =3D strsep(&datablob, " \t");
> +	if (!c)
> +		return -EINVAL;
> +	key_cmd =3D match_token(c, key_tokens, args);
> +	switch (key_cmd) {
> +	case Opt_new:
> +		/* first argument is key size */
> +		c =3D strsep(&datablob, " \t");
> +		if (!c)
> +			return -EINVAL;
> +		ret =3D kstrtol(c, 10, &keylen);
> +		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
> +			return -EINVAL;
> +		p->key_len =3D keylen;
> +		ret =3D Opt_new;
> +		break;
> +	case Opt_load:
> +		/* first argument is sealed blob */
> +		c =3D strsep(&datablob, " \t");
> +		if (!c)
> +			return -EINVAL;
> +		p->blob_len =3D strlen(c) / 2;
> +		if (p->blob_len > MAX_BLOB_SIZE)
> +			return -EINVAL;
> +		ret =3D hex2bin(p->blob, c, p->blob_len);
> +		if (ret < 0)
> +			return -EINVAL;
> +		ret =3D Opt_load;
> +		break;
> +	case Opt_update:
> +		ret =3D Opt_update;
> +		break;
> +	case Opt_err:
> +		return -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
> +{
> +	struct trusted_key_payload *p =3D NULL;
> +	int ret;
> +
> +	ret =3D key_payload_reserve(key, sizeof(*p));
> +	if (ret < 0)
> +		return p;
> +	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
> +
> +	p->migratable =3D tk_ops->migratable;
> +
> +	return p;
> +}
> +
> +/*
> + * trusted_instantiate - create a new trusted key
> + *
> + * Unseal an existing trusted blob or, for a new key, get a
> + * random key, then seal and create a trusted key-type key,
> + * adding it to the specified keyring.
> + *
> + * On success, return 0. Otherwise return errno.
> + */
> +static int trusted_instantiate(struct key *key,
> +			       struct key_preparsed_payload *prep)
> +{
> +	struct trusted_key_payload *payload =3D NULL;
> +	size_t datalen =3D prep->datalen;
> +	char *datablob;
> +	int ret =3D 0;
> +	int key_cmd;
> +	size_t key_len;
> +
> +	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> +		return -EINVAL;
> +
> +	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> +	if (!datablob)
> +		return -ENOMEM;
> +	memcpy(datablob, prep->data, datalen);
> +	datablob[datalen] =3D '\0';
> +
> +	payload =3D trusted_payload_alloc(key);
> +	if (!payload) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	key_cmd =3D datablob_parse(datablob, payload);
> +	if (key_cmd < 0) {
> +		ret =3D key_cmd;
> +		goto out;
> +	}
> +
> +	dump_payload(payload);
> +
> +	switch (key_cmd) {
> +	case Opt_load:
> +		ret =3D tk_ops->unseal(payload, datablob);
> +		dump_payload(payload);
> +		if (ret < 0)
> +			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
> +		break;
> +	case Opt_new:
> +		key_len =3D payload->key_len;
> +		ret =3D tk_ops->get_random(payload->key, key_len);
> +		if (ret !=3D key_len) {
> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
> +			goto out;
> +		}
> +
> +		ret =3D tk_ops->seal(payload, datablob);
> +		if (ret < 0)
> +			pr_info("trusted_key: key_seal failed (%d)\n", ret);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +out:
> +	kzfree(datablob);
> +	if (!ret)
> +		rcu_assign_keypointer(key, payload);
> +	else
> +		kzfree(payload);
> +	return ret;
> +}
> +
> +static void trusted_rcu_free(struct rcu_head *rcu)
> +{
> +	struct trusted_key_payload *p;
> +
> +	p =3D container_of(rcu, struct trusted_key_payload, rcu);
> +	kzfree(p);
> +}
> +
> +/*
> + * trusted_update - reseal an existing key with new PCR values
> + */
> +static int trusted_update(struct key *key, struct key_preparsed_payload *p=
rep)
> +{
> +	struct trusted_key_payload *p;
> +	struct trusted_key_payload *new_p;
> +	size_t datalen =3D prep->datalen;
> +	char *datablob;
> +	int ret =3D 0;
> +
> +	if (key_is_negative(key))
> +		return -ENOKEY;
> +	p =3D key->payload.data[0];
> +	if (!p->migratable)
> +		return -EPERM;
> +	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> +		return -EINVAL;
> +
> +	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> +	if (!datablob)
> +		return -ENOMEM;
> +
> +	new_p =3D trusted_payload_alloc(key);
> +	if (!new_p) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	memcpy(datablob, prep->data, datalen);
> +	datablob[datalen] =3D '\0';
> +	ret =3D datablob_parse(datablob, new_p);
> +	if (ret !=3D Opt_update) {
> +		ret =3D -EINVAL;
> +		kzfree(new_p);
> +		goto out;
> +	}
> +
> +	/* copy old key values, and reseal with new pcrs */
> +	new_p->migratable =3D p->migratable;
> +	new_p->key_len =3D p->key_len;
> +	memcpy(new_p->key, p->key, p->key_len);
> +	dump_payload(p);
> +	dump_payload(new_p);
> +
> +	ret =3D tk_ops->seal(new_p, datablob);
> +	if (ret < 0) {
> +		pr_info("trusted_key: key_seal failed (%d)\n", ret);
> +		kzfree(new_p);
> +		goto out;
> +	}
> +
> +	rcu_assign_keypointer(key, new_p);
> +	call_rcu(&p->rcu, trusted_rcu_free);
> +out:
> +	kzfree(datablob);
> +	return ret;
> +}
> +
> +/*
> + * trusted_read - copy the sealed blob data to userspace in hex.
> + * On success, return to userspace the trusted key datablob size.
> + */
> +static long trusted_read(const struct key *key, char *buffer,
> +			 size_t buflen)
> +{
> +	const struct trusted_key_payload *p;
> +	char *bufp;
> +	int i;
> +
> +	p =3D dereference_key_locked(key);
> +	if (!p)
> +		return -EINVAL;
> +
> +	if (buffer && buflen >=3D 2 * p->blob_len) {
> +		bufp =3D buffer;
> +		for (i =3D 0; i < p->blob_len; i++)
> +			bufp =3D hex_byte_pack(bufp, p->blob[i]);
> +	}
> +	return 2 * p->blob_len;
> +}
> +
> +/*
> + * trusted_destroy - clear and free the key's payload
> + */
> +static void trusted_destroy(struct key *key)
> +{
> +	kzfree(key->payload.data[0]);
> +}
> +
> +struct key_type key_type_trusted =3D {
> +	.name =3D "trusted",
> +	.instantiate =3D trusted_instantiate,
> +	.update =3D trusted_update,
> +	.destroy =3D trusted_destroy,
> +	.describe =3D user_describe,
> +	.read =3D trusted_read,
> +};
> +EXPORT_SYMBOL_GPL(key_type_trusted);
> +
> +static int __init init_trusted(void)
> +{
> +	int i, ret =3D 0;
> +
> +	for (i =3D 0; i < sizeof(available_tk_ops); i++) {
> +		tk_ops =3D available_tk_ops[i];
> +
> +		if (!(tk_ops && tk_ops->init && tk_ops->seal &&
> +		      tk_ops->unseal && tk_ops->get_random))
> +			continue;

This check should not exist as there is no legit case for any of these
callbacks missing. Please remove it.

> +
> +		ret =3D tk_ops->init();
> +		if (ret) {
> +			if (tk_ops->cleanup)
> +				tk_ops->cleanup();

Why is clean up called? What is "clean up"? Init should take care clean
up its dirt if it fails. Please remove the calll to clean up from here.

/Jarkko

--===============4301301742972059515==--

