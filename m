From: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [PATCH 1/3] tee: add support for session's client UUID
 generation
Date: Sat, 25 Apr 2020 09:16:57 +0300
Message-ID: <29b76307-12cb-c52e-f72f-eb7c22bab012@vaisala.com>
In-Reply-To: <20200423173527.GP2682@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9068882846636920202=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============9068882846636920202==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,

Thanks for comments!

On 2020-04-23 20:35, Dan Carpenter wrote:
> On Thu, Apr 23, 2020 at 06:16:59PM +0300, Vesa J=C3=A4=C3=A4skel=C3=A4inen =
wrote:
>> +static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
>> +		   size_t size)
>> +{
>> +	unsigned char hash[SHA1_DIGEST_SIZE];
>> +	struct crypto_shash *shash =3D NULL;
>> +	struct shash_desc *desc =3D NULL;
>> +	int rc;
>> +
>> +	shash =3D crypto_alloc_shash("sha1", 0, 0);
>> +	if (IS_ERR(shash)) {
>> +		rc =3D PTR_ERR(shash);
>> +		pr_err("shash(sha1) allocation failed\n");
>> +		return rc;
>> +	}
>> +
>> +	desc =3D kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
>> +		       GFP_KERNEL);
>> +	if (IS_ERR(desc)) {
>=20
>=20
> kzalloc() returns NULL on error.

Err...Right. Will fix for V2. Thanks for noticing this.

I was probably confused by this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inclu=
de/linux/slab.h?h=3Dv5.7-rc2#n553

As there is no error handling case documented for kmalloc and friends --=20
I was just looking that as there are non-zero error cases in that=20
referenced line (ZERO_SIZE_PTR) so we need to check if pointer has error=20
value as it was with crypto_alloc_shash().

But looking at users of kzalloc then convention seems to be just check=20
for NULL.

Probably referenced code is then expected to cause page fault on error=20
case as ZERO_SIZE_PTR is not error value as such.

>=20
>> +		rc =3D PTR_ERR(desc);
>> +		goto out;
>=20
> Please choose a label name so that we can tell what the goto will do
> like "goto free_shash;".

Ok. Will update for V2.

>> +	}
>> +
>> +	desc->tfm =3D shash;
>> +
>> +	rc =3D crypto_shash_init(desc);
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	rc =3D crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	rc =3D crypto_shash_update(desc, (const u8 *)name, size);
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	rc =3D crypto_shash_final(desc, hash);
>> +	if (rc < 0)
>> +		goto out2;
>> +
>> +	memcpy(uuid->b, hash, UUID_SIZE);
>> +
>> +	/* Tag for version 5 */
>> +	uuid->b[6] =3D (hash[6] & 0x0F) | 0x50;
>> +	uuid->b[8] =3D (hash[8] & 0x3F) | 0x80;
>> +
>> +out2:
>> +	kfree(desc);
>> +
>> +out:
>> +	crypto_free_shash(shash);
>> +	return rc;
>> +}
>> +
>> +int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
>> +				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
>> +{
>> +	const char *application_id =3D NULL;
>> +	gid_t ns_grp =3D (gid_t)-1;
>> +	kgid_t grp =3D INVALID_GID;
>> +	char *name =3D NULL;
>> +	int rc;
>> +
>> +	if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC) {
>> +		/* Nil UUID to be passed to TEE environment */
>> +		uuid_copy(uuid, &uuid_null);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * In Linux environment client UUID is based on UUIDv5.
>> +	 *
>> +	 * Determine client UUID with following semantics for 'name':
>> +	 *
>> +	 * For TEEC_LOGIN_USER:
>> +	 * uid=3D<uid>
>> +	 *
>> +	 * For TEEC_LOGIN_GROUP:
>> +	 * gid=3D<gid>
>> +	 *
>> +	 */
>> +
>> +	name =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
>> +	if (!name)
>> +		return -ENOMEM;
>> +
>> +	switch (connection_method) {
>> +	case TEE_IOCTL_LOGIN_USER:
>> +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
>> +			  current_euid().val);
>=20
> It doesn't make sense to use sCnprintf() instead of snprintf() if we're
> not going to preserve the error code.  Probably it's better to preserve
> the error code actually so we can avoid the strlen(name) later on.

Ok. I assume you meant here using snprintf where we can capture the=20
error situation of too large output string. scnprintf does not seem to=20
have error returning capabilities.

I assume you meant something like this:

name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
		    current_euid().val);
if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
	rc =3D -E2BIG;
	goto out_free_name;
}

Will wait a bit more for comments before sending V2.

I already updated my devel branch with these for those wanting to play=20
around with the updates:
https://github.com/vesajaaskelainen/linux/commits/optee-login-checks

Thanks,
Vesa J=C3=A4=C3=A4skel=C3=A4inen

--===============9068882846636920202==--

