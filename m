From: Dan Carpenter <dan.carpenter@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [PATCH 1/3] tee: add support for session's client UUID
 generation
Date: Thu, 23 Apr 2020 20:35:27 +0300
Message-ID: <20200423173527.GP2682@kadam>
In-Reply-To: <20200423151701.111231-2-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8559321253461500351=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8559321253461500351==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, Apr 23, 2020 at 06:16:59PM +0300, Vesa Jääskeläinen wrote:
> +static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> +		   size_t size)
> +{
> +	unsigned char hash[SHA1_DIGEST_SIZE];
> +	struct crypto_shash *shash = NULL;
> +	struct shash_desc *desc = NULL;
> +	int rc;
> +
> +	shash = crypto_alloc_shash("sha1", 0, 0);
> +	if (IS_ERR(shash)) {
> +		rc = PTR_ERR(shash);
> +		pr_err("shash(sha1) allocation failed\n");
> +		return rc;
> +	}
> +
> +	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
> +		       GFP_KERNEL);
> +	if (IS_ERR(desc)) {


kzalloc() returns NULL on error.

> +		rc = PTR_ERR(desc);
> +		goto out;

Please choose a label name so that we can tell what the goto will do
like "goto free_shash;".

> +	}
> +
> +	desc->tfm = shash;
> +
> +	rc = crypto_shash_init(desc);
> +	if (rc < 0)
> +		goto out2;
> +
> +	rc = crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
> +	if (rc < 0)
> +		goto out2;
> +
> +	rc = crypto_shash_update(desc, (const u8 *)name, size);
> +	if (rc < 0)
> +		goto out2;
> +
> +	rc = crypto_shash_final(desc, hash);
> +	if (rc < 0)
> +		goto out2;
> +
> +	memcpy(uuid->b, hash, UUID_SIZE);
> +
> +	/* Tag for version 5 */
> +	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
> +	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
> +
> +out2:
> +	kfree(desc);
> +
> +out:
> +	crypto_free_shash(shash);
> +	return rc;
> +}
> +
> +int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> +				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
> +{
> +	const char *application_id = NULL;
> +	gid_t ns_grp = (gid_t)-1;
> +	kgid_t grp = INVALID_GID;
> +	char *name = NULL;
> +	int rc;
> +
> +	if (connection_method == TEE_IOCTL_LOGIN_PUBLIC) {
> +		/* Nil UUID to be passed to TEE environment */
> +		uuid_copy(uuid, &uuid_null);
> +		return 0;
> +	}
> +
> +	/*
> +	 * In Linux environment client UUID is based on UUIDv5.
> +	 *
> +	 * Determine client UUID with following semantics for 'name':
> +	 *
> +	 * For TEEC_LOGIN_USER:
> +	 * uid=<uid>
> +	 *
> +	 * For TEEC_LOGIN_GROUP:
> +	 * gid=<gid>
> +	 *
> +	 */
> +
> +	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	switch (connection_method) {
> +	case TEE_IOCTL_LOGIN_USER:
> +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x",
> +			  current_euid().val);

It doesn't make sense to use sCnprintf() instead of snprintf() if we're
not going to preserve the error code.  Probably it's better to preserve
the error code actually so we can avoid the strlen(name) later on.

> +		break;
> +
> +	case TEE_IOCTL_LOGIN_GROUP:
> +		memcpy(&ns_grp, connection_data, sizeof(gid_t));
> +		grp = make_kgid(current_user_ns(), ns_grp);
> +		if (!gid_valid(grp) || !in_egroup_p(grp)) {
> +			rc = -EPERM;
> +			goto out;
> +		}
> +
> +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x", grp.val);
> +		break;
> +
> +	default:
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	rc = uuid_v5(uuid, &tee_client_uuid_ns, name, strlen(name));
> +out:
> +	kfree(name);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tee_session_calc_client_uuid);

regards,
dan carpenter


--===============8559321253461500351==--

