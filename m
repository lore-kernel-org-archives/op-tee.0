From: Dan Carpenter <dan.carpenter@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [op-tee] [PATCH 1/3] tee: add support for session's client UUID
 generation
Date: Sat, 25 Apr 2020 12:24:39 +0300
Message-ID: <20200425092439.GT2682@kadam>
In-Reply-To: <29b76307-12cb-c52e-f72f-eb7c22bab012@vaisala.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8082792801563767031=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8082792801563767031==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2020 at 09:16:57AM +0300, Vesa J=C3=A4=C3=A4skel=C3=A4inen wr=
ote:
> Hi Dan,
>=20
> Thanks for comments!
>=20
> On 2020-04-23 20:35, Dan Carpenter wrote:
> > On Thu, Apr 23, 2020 at 06:16:59PM +0300, Vesa J=C3=A4=C3=A4skel=C3=A4ine=
n wrote:
> > > +static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
> > > +		   size_t size)
> > > +{
> > > +	unsigned char hash[SHA1_DIGEST_SIZE];
> > > +	struct crypto_shash *shash =3D NULL;
> > > +	struct shash_desc *desc =3D NULL;
> > > +	int rc;
> > > +
> > > +	shash =3D crypto_alloc_shash("sha1", 0, 0);
> > > +	if (IS_ERR(shash)) {
> > > +		rc =3D PTR_ERR(shash);
> > > +		pr_err("shash(sha1) allocation failed\n");
> > > +		return rc;
> > > +	}
> > > +
> > > +	desc =3D kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
> > > +		       GFP_KERNEL);
> > > +	if (IS_ERR(desc)) {
> >=20
> >=20
> > kzalloc() returns NULL on error.
>=20
> Err...Right. Will fix for V2. Thanks for noticing this.
>=20
> I was probably confused by this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/inc=
lude/linux/slab.h?h=3Dv5.7-rc2#n553
>=20
> As there is no error handling case documented for kmalloc and friends -- I
> was just looking that as there are non-zero error cases in that referenced
> line (ZERO_SIZE_PTR) so we need to check if pointer has error value as it
> was with crypto_alloc_shash().
>=20
> But looking at users of kzalloc then convention seems to be just check for
> NULL.
>=20
> Probably referenced code is then expected to cause page fault on error case
> as ZERO_SIZE_PTR is not error value as such.


Zero size buffers are not an error.  You can copy zero bytes to them or
from them without a problem.

	size =3D 0;
	p =3D kmalloc(size, GFP_KERNEL);
	memcpy(p, src, 0);
	for (i =3D 0; i < size; i++)
		printk("%d\n", p[i]);
	copy_to_user(user_ptr, p, size);

All that's fine and does nothing.  You should never test for
ZERO_SIZE_PTR.  Check for "size =3D=3D 0" instead.

>=20
> >=20
> > > +		rc =3D PTR_ERR(desc);
> > > +		goto out;
> >=20
> > Please choose a label name so that we can tell what the goto will do
> > like "goto free_shash;".
>=20
> Ok. Will update for V2.
>=20
> > > +	}
> > > +
> > > +	desc->tfm =3D shash;
> > > +
> > > +	rc =3D crypto_shash_init(desc);
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	rc =3D crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	rc =3D crypto_shash_update(desc, (const u8 *)name, size);
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	rc =3D crypto_shash_final(desc, hash);
> > > +	if (rc < 0)
> > > +		goto out2;
> > > +
> > > +	memcpy(uuid->b, hash, UUID_SIZE);
> > > +
> > > +	/* Tag for version 5 */
> > > +	uuid->b[6] =3D (hash[6] & 0x0F) | 0x50;
> > > +	uuid->b[8] =3D (hash[8] & 0x3F) | 0x80;
> > > +
> > > +out2:
> > > +	kfree(desc);
> > > +
> > > +out:
> > > +	crypto_free_shash(shash);
> > > +	return rc;
> > > +}
> > > +
> > > +int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> > > +				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
> > > +{
> > > +	const char *application_id =3D NULL;
> > > +	gid_t ns_grp =3D (gid_t)-1;
> > > +	kgid_t grp =3D INVALID_GID;
> > > +	char *name =3D NULL;
> > > +	int rc;
> > > +
> > > +	if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC) {
> > > +		/* Nil UUID to be passed to TEE environment */
> > > +		uuid_copy(uuid, &uuid_null);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * In Linux environment client UUID is based on UUIDv5.
> > > +	 *
> > > +	 * Determine client UUID with following semantics for 'name':
> > > +	 *
> > > +	 * For TEEC_LOGIN_USER:
> > > +	 * uid=3D<uid>
> > > +	 *
> > > +	 * For TEEC_LOGIN_GROUP:
> > > +	 * gid=3D<gid>
> > > +	 *
> > > +	 */
> > > +
> > > +	name =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> > > +	if (!name)
> > > +		return -ENOMEM;
> > > +
> > > +	switch (connection_method) {
> > > +	case TEE_IOCTL_LOGIN_USER:
> > > +		scnprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
> > > +			  current_euid().val);
> >=20
> > It doesn't make sense to use sCnprintf() instead of snprintf() if we're
> > not going to preserve the error code.  Probably it's better to preserve
> > the error code actually so we can avoid the strlen(name) later on.
>=20
> Ok. I assume you meant here using snprintf where we can capture the error
> situation of too large output string. scnprintf does not seem to have error
> returning capabilities.
>=20
> I assume you meant something like this:
>=20
> name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
> 		    current_euid().val);
> if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> 	rc =3D -E2BIG;
> 	goto out_free_name;
> }
>=20

None of the kernel snprintf() functions return negative error codes.
The difference between snprintf() and scnprintf() is that snprintf()
returns the number of bytes that would have been copied if there were
enough space and scnprintf() returns the number of bytes which were
*actually* copied.

But if we don't care about the return code, then we should default to
using snprintf() because it is the simpler looking function.  Always
right the simplest code you can.

regards,
dan carpenter


--===============8082792801563767031==--

