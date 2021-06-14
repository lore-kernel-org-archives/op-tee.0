From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4 4/8] optee: Clear stale cache entries during initialization
Date: Mon, 14 Jun 2021 14:06:46 -0500
Message-ID: <20210614190646.GW4910@sequoia>
In-Reply-To: <20210614082715.GC1033436@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5602625187189387023=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5602625187189387023==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-14 10:27:15, Jens Wiklander wrote:
> On Thu, Jun 10, 2021 at 04:09:09PM -0500, Tyler Hicks wrote:
> > The shm cache could contain invalid addresses if
> > optee_disable_shm_cache() was not called from the .shutdown hook of the
> > previous kernel before a kexec. These addresses could be unmapped or
> > they could point to mapped but unintended locations in memory.
> >=20
> > Clear the shared memory cache, while being careful to not translate the
> > addresses returned from OPTEE_SMC_DISABLE_SHM_CACHE, during driver
> > initialization. Once all pre-cache shm objects are removed, proceed with
> > enabling the cache so that we know that we can handle cached shm objects
> > with confidence later in the .shutdown hook.
> >=20
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  drivers/tee/optee/call.c          | 11 ++++++++++-
> >  drivers/tee/optee/core.c          | 13 +++++++++++--
> >  drivers/tee/optee/optee_private.h |  2 +-
> >  3 files changed, 22 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 6e6eb836e9b6..5dcba6105ed7 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -419,8 +419,10 @@ void optee_enable_shm_cache(struct optee *optee)
> >   * optee_disable_shm_cache() - Disables caching of some shared memory al=
location
> >   *			      in OP-TEE
> >   * @optee:	main service struct
> > + * @is_mapped:	true if the cached shared memory addresses were mapped by=
 this
> > + *		kernel, are safe to dereference, and should be freed
> >   */
> > -void optee_disable_shm_cache(struct optee *optee)
> > +void optee_disable_shm_cache(struct optee *optee, bool is_mapped)
> >  {
> >  	struct optee_call_waiter w;
> > =20
> > @@ -439,6 +441,13 @@ void optee_disable_shm_cache(struct optee *optee)
> >  		if (res.result.status =3D=3D OPTEE_SMC_RETURN_OK) {
> >  			struct tee_shm *shm;
> > =20
> > +			/*
> > +			 * Shared memory references that were not mapped by
> > +			 * this kernel must be ignored to prevent a crash.
> > +			 */
> > +			if (!is_mapped)
> > +				continue;
> > +
> >  			shm =3D reg_pair_to_ptr(res.result.shm_upper32,
> >  					      res.result.shm_lower32);
> >  			tee_shm_free(shm);
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index 0987074d7ed0..6974e1104bd4 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -589,7 +589,7 @@ static int optee_remove(struct platform_device *pdev)
> >  	 * reference counters and also avoid wild pointers in secure world
> >  	 * into the old shared memory range.
> >  	 */
> > -	optee_disable_shm_cache(optee);
> > +	optee_disable_shm_cache(optee, true);
>=20
> Naked "true" or "false" parameters are normally not very descriptive.
> Would it make sense to write this as:
> optee_disable_shm_cache(optee, true /*is_mapped*/);
> instead (same for the other call sites in this patch)? That way it would
> be easier to see what it is that is true or false.

Yeah, I understand the issue with the naked bools. What about turning
'optee_disable_shm_cache(struct optee *optee, bool is_mapped)' into
'__optee_disable_shm_cache(struct optee *optee, bool is_mapped)' and
introducing these two wrappers:

/**
 * optee_disable_shm_cache() - Disables caching of mapped shared memory
 *                             allocations in OP-TEE
 * @optee:     main service struct
 */
void optee_disable_shm_cache(struct optee *optee)
{
       return __optee_disable_shm_cache(optee, true);
}

/**
 * optee_disable_unmapped_shm_cache() - Disables caching of shared memory
 *                                      allocations in OP-TEE which are not
 *                                      currently mapped
 * @optee:     main service struct
 */
void optee_disable_unmapped_shm_cache(struct optee *optee)
{
       return __optee_disable_shm_cache(optee, false);
}

Existing callers of optee_disable_shm_cache() remain unchanged and we just add
one caller of optee_disable_unmapped_shm_cache() with this patch.

Tyler

>=20
> /Jens
>=20
> > =20
> >  	/*
> >  	 * The two devices have to be unregistered before we can free the
> > @@ -619,7 +619,7 @@ static int optee_remove(struct platform_device *pdev)
> >   */
> >  static void optee_shutdown(struct platform_device *pdev)
> >  {
> > -	optee_disable_shm_cache(platform_get_drvdata(pdev));
> > +	optee_disable_shm_cache(platform_get_drvdata(pdev), true);
> >  }
> > =20
> >  static int optee_probe(struct platform_device *pdev)
> > @@ -716,6 +716,15 @@ static int optee_probe(struct platform_device *pdev)
> >  	optee->memremaped_shm =3D memremaped_shm;
> >  	optee->pool =3D pool;
> > =20
> > +	/*
> > +	 * Ensure that there are no pre-existing shm objects before enabling
> > +	 * the shm cache so that there's no chance of receiving an invalid
> > +	 * address during shutdown. This could occur, for example, if we're
> > +	 * kexec booting from an older kernel that did not properly cleanup the
> > +	 * shm cache.
> > +	 */
> > +	optee_disable_shm_cache(optee, false);
> > +
> >  	optee_enable_shm_cache(optee);
> > =20
> >  	if (optee->sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM)
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> > index e25b216a14ef..16d8c82213e7 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -158,7 +158,7 @@ int optee_invoke_func(struct tee_context *ctx, struct=
 tee_ioctl_invoke_arg *arg,
> >  int optee_cancel_req(struct tee_context *ctx, u32 cancel_id, u32 session=
);
> > =20
> >  void optee_enable_shm_cache(struct optee *optee);
> > -void optee_disable_shm_cache(struct optee *optee);
> > +void optee_disable_shm_cache(struct optee *optee, bool is_mapped);
> > =20
> >  int optee_shm_register(struct tee_context *ctx, struct tee_shm *shm,
> >  		       struct page **pages, size_t num_pages,
> > --=20
> > 2.25.1
> >=20
>=20

--===============5602625187189387023==--

