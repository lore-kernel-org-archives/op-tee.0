From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v5 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Mon, 15 Jun 2020 21:24:57 +0300
Message-ID: <20200615182457.GB5416@linux.intel.com>
In-Reply-To: <1591107505-6030-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5876030848375560724=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5876030848375560724==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2020 at 07:48:22PM +0530, Sumit Garg wrote:
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 47c0415..22632c6 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -72,17 +72,26 @@ config BIG_KEYS
> =20
>  config TRUSTED_KEYS
>  	tristate "TRUSTED KEYS"
> -	depends on KEYS && TCG_TPM
> +	depends on KEYS
> +	help
> +	  This option provides support for creating, sealing, and unsealing
> +	  keys in the kernel. Trusted keys are random number symmetric keys,
> +	  generated and sealed by a trust source (TPM or TEE). Userspace will
> +	  only ever see encrypted blobs.
> +
> +	  If you are unsure as to whether this is required, answer N.
> +
> +config TRUSTED_TPM

TRUSTED_TPM_KEYS

> +	bool "TPM based TRUSTED KEYS"
> +	depends on TRUSTED_KEYS && TCG_TPM
>  	select CRYPTO
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA1
>  	select CRYPTO_HASH_INFO
>  	help
> -	  This option provides support for creating, sealing, and unsealing
> -	  keys in the kernel. Trusted keys are random number symmetric keys,
> -	  generated and RSA-sealed by the TPM. The TPM only unseals the keys,
> -	  if the boot PCRs and other criteria match.  Userspace will only ever
> -	  see encrypted blobs.
> +	  This option provides support for TPM based trusted keys where TPM acts
> +	  as the trust source. The keys are RSA-sealed by the TPM and it only
> +	  unseals the keys, if the boot PCRs and other criteria match.
> =20
>  	  If you are unsure as to whether this is required, answer N.
> =20
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-ke=
ys/Makefile
> index 7b73ceb..03c3ad4 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -4,5 +4,6 @@
>  #
> =20
>  obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
> -trusted-y +=3D trusted_tpm1.o
> -trusted-y +=3D trusted_tpm2.o
> +trusted-y +=3D trusted_core.o
> +trusted-$(CONFIG_TRUSTED_TPM) +=3D trusted_tpm1.o
> +trusted-$(CONFIG_TRUSTED_TPM) +=3D trusted_tpm2.o
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trus=
ted-keys/trusted_core.c
> new file mode 100644
> index 0000000..3d07d27
> --- /dev/null
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2010 IBM Corporation
> + * Copyright (c) 2019, Linaro Limited
> + *
> + * Author:
> + * David Safford <safford@us.ibm.com>
> + * Added generic trusted key framework: Sumit Garg <sumit.garg@linaro.or=
g>

Rather remove David's because

1. Git log gives a verifiable and exact log of authority.
2. David's commit was done post-epoch of Git.

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
> +#if defined(CONFIG_TRUSTED_TPM)
> +static struct trusted_key_ops *trusted_key_ops =3D &tpm_trusted_key_ops;
> +#else
> +static struct trusted_key_ops *trusted_key_ops;
> +#endif

You should just have

extern trusted_key_ops *trusted_key_ops;

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
> +	p->migratable =3D trusted_key_ops->migratable;
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
> +		ret =3D trusted_key_ops->unseal(payload, datablob);
> +		dump_payload(payload);
> +		if (ret < 0)
> +			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
> +		break;
> +	case Opt_new:
> +		key_len =3D payload->key_len;
> +		ret =3D trusted_key_ops->get_random(payload->key, key_len);
> +		if (ret !=3D key_len) {
> +			pr_info("trusted_key: key_create failed (%d)\n", ret);
> +			goto out;
> +		}
> +
> +		ret =3D trusted_key_ops->seal(payload, datablob);
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
> +	ret =3D trusted_key_ops->seal(new_p, datablob);
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
> +	int ret;
> +
> +	/*
> +	 * encrypted_keys.ko depends on successful load of this module even if
> +	 * trusted key implementation is not found.
> +	 */
> +	if (!trusted_key_ops)
> +		return 0;
> +
> +	ret =3D trusted_key_ops->init();
> +	if (ret =3D=3D -ENODEV)
> +		return 0;
> +
> +	return ret;
> +}
> +
> +static void __exit cleanup_trusted(void)
> +{
> +	trusted_key_ops->exit();
> +}
> +
> +late_initcall(init_trusted);
> +module_exit(cleanup_trusted);
> +
> +MODULE_LICENSE("GPL");
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trus=
ted-keys/trusted_tpm1.c
> index 8001ab0..e378b27 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -1,29 +1,26 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2010 IBM Corporation
> + * Copyright (c) 2019, Linaro Limited
>   *
>   * Author:
>   * David Safford <safford@us.ibm.com>
> + * Switch to generic trusted key framework: Sumit Garg <sumit.garg@linar=
o.org>
>   *
>   * See Documentation/security/keys/trusted-encrypted.rst
>   */
> =20
>  #include <crypto/hash_info.h>
> -#include <linux/uaccess.h>
> -#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
>  #include <linux/parser.h>
>  #include <linux/string.h>
>  #include <linux/err.h>
> -#include <keys/user-type.h>
>  #include <keys/trusted-type.h>
>  #include <linux/key-type.h>
> -#include <linux/rcupdate.h>
>  #include <linux/crypto.h>
>  #include <crypto/hash.h>
>  #include <crypto/sha.h>
> -#include <linux/capability.h>
>  #include <linux/tpm.h>
>  #include <linux/tpm_command.h>
> =20
> @@ -703,7 +700,6 @@ static int key_unseal(struct trusted_key_payload *p,
> =20
>  enum {
>  	Opt_err,
> -	Opt_new, Opt_load, Opt_update,
>  	Opt_keyhandle, Opt_keyauth, Opt_blobauth,
>  	Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
>  	Opt_hash,
> @@ -712,9 +708,6 @@ enum {
>  };
> =20
>  static const match_table_t key_tokens =3D {
> -	{Opt_new, "new"},
> -	{Opt_load, "load"},
> -	{Opt_update, "update"},
>  	{Opt_keyhandle, "keyhandle=3D%s"},
>  	{Opt_keyauth, "keyauth=3D%s"},
>  	{Opt_blobauth, "blobauth=3D%s"},
> @@ -841,71 +834,6 @@ static int getoptions(char *c, struct trusted_key_payl=
oad *pay,
>  	return 0;
>  }
> =20
> -/*
> - * datablob_parse - parse the keyctl data and fill in the
> - * 		    payload and options structures
> - *
> - * On success returns 0, otherwise -EINVAL.
> - */
> -static int datablob_parse(char *datablob, struct trusted_key_payload *p,
> -			  struct trusted_key_options *o)
> -{
> -	substring_t args[MAX_OPT_ARGS];
> -	long keylen;
> -	int ret =3D -EINVAL;
> -	int key_cmd;
> -	char *c;
> -
> -	/* main command */
> -	c =3D strsep(&datablob, " \t");
> -	if (!c)
> -		return -EINVAL;
> -	key_cmd =3D match_token(c, key_tokens, args);
> -	switch (key_cmd) {
> -	case Opt_new:
> -		/* first argument is key size */
> -		c =3D strsep(&datablob, " \t");
> -		if (!c)
> -			return -EINVAL;
> -		ret =3D kstrtol(c, 10, &keylen);
> -		if (ret < 0 || keylen < MIN_KEY_SIZE || keylen > MAX_KEY_SIZE)
> -			return -EINVAL;
> -		p->key_len =3D keylen;
> -		ret =3D getoptions(datablob, p, o);
> -		if (ret < 0)
> -			return ret;
> -		ret =3D Opt_new;
> -		break;
> -	case Opt_load:
> -		/* first argument is sealed blob */
> -		c =3D strsep(&datablob, " \t");
> -		if (!c)
> -			return -EINVAL;
> -		p->blob_len =3D strlen(c) / 2;
> -		if (p->blob_len > MAX_BLOB_SIZE)
> -			return -EINVAL;
> -		ret =3D hex2bin(p->blob, c, p->blob_len);
> -		if (ret < 0)
> -			return -EINVAL;
> -		ret =3D getoptions(datablob, p, o);
> -		if (ret < 0)
> -			return ret;
> -		ret =3D Opt_load;
> -		break;
> -	case Opt_update:
> -		/* all arguments are options */
> -		ret =3D getoptions(datablob, p, o);
> -		if (ret < 0)
> -			return ret;
> -		ret =3D Opt_update;
> -		break;
> -	case Opt_err:
> -		return -EINVAL;
> -		break;
> -	}
> -	return ret;
> -}
> -
>  static struct trusted_key_options *trusted_options_alloc(void)
>  {
>  	struct trusted_key_options *options;
> @@ -926,248 +854,99 @@ static struct trusted_key_options *trusted_options_a=
lloc(void)
>  	return options;
>  }
> =20
> -static struct trusted_key_payload *trusted_payload_alloc(struct key *key)
> +static int tpm_trusted_seal(struct trusted_key_payload *p, char *datablob)
>  {
> -	struct trusted_key_payload *p =3D NULL;
> -	int ret;
> -
> -	ret =3D key_payload_reserve(key, sizeof *p);
> -	if (ret < 0)
> -		return p;
> -	p =3D kzalloc(sizeof *p, GFP_KERNEL);
> -	if (p)
> -		p->migratable =3D 1; /* migratable by default */
> -	return p;
> -}
> -
> -/*
> - * trusted_instantiate - create a new trusted key
> - *
> - * Unseal an existing trusted blob or, for a new key, get a
> - * random key, then seal and create a trusted key-type key,
> - * adding it to the specified keyring.
> - *
> - * On success, return 0. Otherwise return errno.
> - */
> -static int trusted_instantiate(struct key *key,
> -			       struct key_preparsed_payload *prep)
> -{
> -	struct trusted_key_payload *payload =3D NULL;
>  	struct trusted_key_options *options =3D NULL;
> -	size_t datalen =3D prep->datalen;
> -	char *datablob;
>  	int ret =3D 0;
> -	int key_cmd;
> -	size_t key_len;
>  	int tpm2;
> =20
>  	tpm2 =3D tpm_is_tpm2(chip);
>  	if (tpm2 < 0)
>  		return tpm2;
> =20
> -	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> -		return -EINVAL;
> -
> -	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> -	if (!datablob)
> -		return -ENOMEM;
> -	memcpy(datablob, prep->data, datalen);
> -	datablob[datalen] =3D '\0';
> -
>  	options =3D trusted_options_alloc();
> -	if (!options) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
> -	payload =3D trusted_payload_alloc(key);
> -	if (!payload) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
> +	if (!options)
> +		return -ENOMEM;
> =20
> -	key_cmd =3D datablob_parse(datablob, payload, options);
> -	if (key_cmd < 0) {
> -		ret =3D key_cmd;
> +	ret =3D getoptions(datablob, p, options);
> +	if (ret < 0)
>  		goto out;
> -	}
> +	dump_options(options);
> =20
>  	if (!options->keyhandle) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	dump_payload(payload);
> -	dump_options(options);
> +	if (tpm2)
> +		ret =3D tpm2_seal_trusted(chip, p, options);
> +	else
> +		ret =3D key_seal(p, options);
> +	if (ret < 0) {
> +		pr_info("tpm_trusted_key: key_seal failed (%d)\n", ret);
> +		goto out;
> +	}
> =20
> -	switch (key_cmd) {
> -	case Opt_load:
> -		if (tpm2)
> -			ret =3D tpm2_unseal_trusted(chip, payload, options);
> -		else
> -			ret =3D key_unseal(payload, options);
> -		dump_payload(payload);
> -		dump_options(options);
> -		if (ret < 0)
> -			pr_info("trusted_key: key_unseal failed (%d)\n", ret);
> -		break;
> -	case Opt_new:
> -		key_len =3D payload->key_len;
> -		ret =3D tpm_get_random(chip, payload->key, key_len);
> -		if (ret !=3D key_len) {
> -			pr_info("trusted_key: key_create failed (%d)\n", ret);
> +	if (options->pcrlock) {
> +		ret =3D pcrlock(options->pcrlock);
> +		if (ret < 0) {
> +			pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
>  			goto out;
>  		}
> -		if (tpm2)
> -			ret =3D tpm2_seal_trusted(chip, payload, options);
> -		else
> -			ret =3D key_seal(payload, options);
> -		if (ret < 0)
> -			pr_info("trusted_key: key_seal failed (%d)\n", ret);
> -		break;
> -	default:
> -		ret =3D -EINVAL;
> -		goto out;
>  	}
> -	if (!ret && options->pcrlock)
> -		ret =3D pcrlock(options->pcrlock);
>  out:
> -	kzfree(datablob);
>  	kzfree(options);
> -	if (!ret)
> -		rcu_assign_keypointer(key, payload);
> -	else
> -		kzfree(payload);
>  	return ret;
>  }
> =20
> -static void trusted_rcu_free(struct rcu_head *rcu)
> +static int tpm_trusted_unseal(struct trusted_key_payload *p, char *datablo=
b)
>  {
> -	struct trusted_key_payload *p;
> -
> -	p =3D container_of(rcu, struct trusted_key_payload, rcu);
> -	kzfree(p);
> -}
> -
> -/*
> - * trusted_update - reseal an existing key with new PCR values
> - */
> -static int trusted_update(struct key *key, struct key_preparsed_payload *p=
rep)
> -{
> -	struct trusted_key_payload *p;
> -	struct trusted_key_payload *new_p;
> -	struct trusted_key_options *new_o;
> -	size_t datalen =3D prep->datalen;
> -	char *datablob;
> +	struct trusted_key_options *options =3D NULL;
>  	int ret =3D 0;
> +	int tpm2;
> =20
> -	if (key_is_negative(key))
> -		return -ENOKEY;
> -	p =3D key->payload.data[0];
> -	if (!p->migratable)
> -		return -EPERM;
> -	if (datalen <=3D 0 || datalen > 32767 || !prep->data)
> -		return -EINVAL;
> +	tpm2 =3D tpm_is_tpm2(chip);
> +	if (tpm2 < 0)
> +		return tpm2;
> =20
> -	datablob =3D kmalloc(datalen + 1, GFP_KERNEL);
> -	if (!datablob)
> +	options =3D trusted_options_alloc();
> +	if (!options)
>  		return -ENOMEM;
> -	new_o =3D trusted_options_alloc();
> -	if (!new_o) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
> -	new_p =3D trusted_payload_alloc(key);
> -	if (!new_p) {
> -		ret =3D -ENOMEM;
> -		goto out;
> -	}
> =20
> -	memcpy(datablob, prep->data, datalen);
> -	datablob[datalen] =3D '\0';
> -	ret =3D datablob_parse(datablob, new_p, new_o);
> -	if (ret !=3D Opt_update) {
> -		ret =3D -EINVAL;
> -		kzfree(new_p);
> +	ret =3D getoptions(datablob, p, options);
> +	if (ret < 0)
>  		goto out;
> -	}
> +	dump_options(options);
> =20
> -	if (!new_o->keyhandle) {
> +	if (!options->keyhandle) {
>  		ret =3D -EINVAL;
> -		kzfree(new_p);
>  		goto out;
>  	}
> =20
> -	/* copy old key values, and reseal with new pcrs */
> -	new_p->migratable =3D p->migratable;
> -	new_p->key_len =3D p->key_len;
> -	memcpy(new_p->key, p->key, p->key_len);
> -	dump_payload(p);
> -	dump_payload(new_p);
> +	if (tpm2)
> +		ret =3D tpm2_unseal_trusted(chip, p, options);
> +	else
> +		ret =3D key_unseal(p, options);
> +	if (ret < 0)
> +		pr_info("tpm_trusted_key: key_unseal failed (%d)\n", ret);
> =20
> -	ret =3D key_seal(new_p, new_o);
> -	if (ret < 0) {
> -		pr_info("trusted_key: key_seal failed (%d)\n", ret);
> -		kzfree(new_p);
> -		goto out;
> -	}
> -	if (new_o->pcrlock) {
> -		ret =3D pcrlock(new_o->pcrlock);
> +	if (options->pcrlock) {
> +		ret =3D pcrlock(options->pcrlock);
>  		if (ret < 0) {
> -			pr_info("trusted_key: pcrlock failed (%d)\n", ret);
> -			kzfree(new_p);
> +			pr_info("tpm_trusted_key: pcrlock failed (%d)\n", ret);
>  			goto out;
>  		}
>  	}
> -	rcu_assign_keypointer(key, new_p);
> -	call_rcu(&p->rcu, trusted_rcu_free);
>  out:
> -	kzfree(datablob);
> -	kzfree(new_o);
> +	kzfree(options);
>  	return ret;
>  }
> =20
> -/*
> - * trusted_read - copy the sealed blob data to userspace in hex.
> - * On success, return to userspace the trusted key datablob size.
> - */
> -static long trusted_read(const struct key *key, char *buffer,
> -			 size_t buflen)
> -{
> -	const struct trusted_key_payload *p;
> -	char *bufp;
> -	int i;
> -
> -	p =3D dereference_key_locked(key);
> -	if (!p)
> -		return -EINVAL;
> -
> -	if (buffer && buflen >=3D 2 * p->blob_len) {
> -		bufp =3D buffer;
> -		for (i =3D 0; i < p->blob_len; i++)
> -			bufp =3D hex_byte_pack(bufp, p->blob[i]);
> -	}
> -	return 2 * p->blob_len;
> -}
> -
> -/*
> - * trusted_destroy - clear and free the key's payload
> - */
> -static void trusted_destroy(struct key *key)
> +int tpm_trusted_get_random(unsigned char *key, size_t key_len)
>  {
> -	kzfree(key->payload.data[0]);
> +	return tpm_get_random(chip, key, key_len);
>  }
> =20
> -struct key_type key_type_trusted =3D {
> -	.name =3D "trusted",
> -	.instantiate =3D trusted_instantiate,
> -	.update =3D trusted_update,
> -	.destroy =3D trusted_destroy,
> -	.describe =3D user_describe,
> -	.read =3D trusted_read,
> -};
> -
> -EXPORT_SYMBOL_GPL(key_type_trusted);
> -
>  static void trusted_shash_release(void)
>  {
>  	if (hashalg)
> @@ -1182,14 +961,14 @@ static int __init trusted_shash_alloc(void)
> =20
>  	hmacalg =3D crypto_alloc_shash(hmac_alg, 0, 0);
>  	if (IS_ERR(hmacalg)) {
> -		pr_info("trusted_key: could not allocate crypto %s\n",
> +		pr_info("tpm_trusted_key: could not allocate crypto %s\n",
>  			hmac_alg);
>  		return PTR_ERR(hmacalg);
>  	}
> =20
>  	hashalg =3D crypto_alloc_shash(hash_alg, 0, 0);
>  	if (IS_ERR(hashalg)) {
> -		pr_info("trusted_key: could not allocate crypto %s\n",
> +		pr_info("tpm_trusted_key: could not allocate crypto %s\n",
>  			hash_alg);
>  		ret =3D PTR_ERR(hashalg);
>  		goto hashalg_fail;
> @@ -1217,16 +996,13 @@ static int __init init_digests(void)
>  	return 0;
>  }
> =20
> -static int __init init_trusted(void)
> +static int __init init_tpm_trusted(void)
>  {
>  	int ret;
> =20
> -	/* encrypted_keys.ko depends on successful load of this module even if
> -	 * TPM is not used.
> -	 */
>  	chip =3D tpm_default_chip();
>  	if (!chip)
> -		return 0;
> +		return -ENODEV;
> =20
>  	ret =3D init_digests();
>  	if (ret < 0)
> @@ -1247,7 +1023,7 @@ static int __init init_trusted(void)
>  	return ret;
>  }
> =20
> -static void __exit cleanup_trusted(void)
> +static void __exit exit_tpm_trusted(void)
>  {
>  	if (chip) {
>  		put_device(&chip->dev);
> @@ -1257,7 +1033,12 @@ static void __exit cleanup_trusted(void)
>  	}
>  }
> =20
> -late_initcall(init_trusted);
> -module_exit(cleanup_trusted);
> -
> -MODULE_LICENSE("GPL");
> +struct trusted_key_ops tpm_trusted_key_ops =3D {
> +	.migratable =3D 1, /* migratable by default */
> +	.init =3D init_tpm_trusted,
> +	.seal =3D tpm_trusted_seal,
> +	.unseal =3D tpm_trusted_unseal,
> +	.get_random =3D tpm_trusted_get_random,
> +	.exit =3D exit_tpm_trusted,
> +};
> +EXPORT_SYMBOL_GPL(tpm_trusted_key_ops); > --=20

Rename this as trusted_key_ops and remove EXPORT_SYMBOL_GPL()

> 2.7.4
>=20

/Jarkko

--===============5876030848375560724==--

