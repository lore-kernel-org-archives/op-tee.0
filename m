From: Mimi Zohar <zohar@linux.ibm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 1/4] KEYS: trusted: Add generic trusted keys framework
Date: Tue, 20 Oct 2020 23:21:00 -0400
Message-ID: <8e07f9401c9f7e18fb1453b7b290472c0049c6e6.camel@linux.ibm.com>
In-Reply-To: <1602065268-26017-2-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4026346300309192356=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4026346300309192356==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-10-07 at 15:37 +0530, Sumit Garg wrote:

> +/*
> + * trusted_destroy - clear and free the key's payload
> + */
> +static void trusted_destroy(struct key *key)
> +{
> +	kfree_sensitive(key->payload.data[0]);
> +}
> +
> +struct key_type key_type_trusted = {
> +	.name = "trusted",
> +	.instantiate = trusted_instantiate,
> +	.update = trusted_update,
> +	.destroy = trusted_destroy,
> +	.describe = user_describe,
> +	.read = trusted_read,
> +};
> +EXPORT_SYMBOL_GPL(key_type_trusted);
> +
> +static int __init init_trusted(void)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(trusted_key_sources); i++) {
> +		if (trusted_key_source &&
> +		    strncmp(trusted_key_source, trusted_key_sources[i].name,
> +			    strlen(trusted_key_sources[i].name)))
> +			continue;
> +
> +		trusted_key_ops = trusted_key_sources[i].ops;
> +
> +		ret = trusted_key_ops->init();
> +		if (!ret)
> +			break;
> +	}

In the case when the module paramater isn't specified and both TPM and
TEE are enabled, trusted_key_ops is set to the last source initialized.
After patch 2/4, the last trusted source initialized is TEE.  If the
intention is to limit it to either TPM or TEE, then trusted_key_ops
should have a default value, which could be overwritten at runtime. 
That would address Luke Hind's concerns of making the decision at
compile time.

trusted_key_ops should be defined as __ro_after_init, like is currently
done for other LSM structures.

> +
> +	/*
> +	 * encrypted_keys.ko depends on successful load of this module even if
> +	 * trusted key implementation is not found.
> +	 */
> +	if (ret == -ENODEV)
> +		return 0;
> +
> +	return ret;
> +}
> +
> +static void __exit cleanup_trusted(void)
> +{
> +	trusted_key_ops->exit();

If the intention is really to support both TPM and TEE trusted keys at
the same time, as James suggested, then the same "for" loop as in
init_trusted() is needed here and probably elsewhere.

thanks,

Mimi


--===============4026346300309192356==--

