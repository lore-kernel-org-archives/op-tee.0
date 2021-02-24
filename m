From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/2] optee: fix tee out of memory failure seen during kexec reboot
Date: Wed, 24 Feb 2021 09:15:53 +0100
Message-ID: <20210224081553.GB2653493@jade>
In-Reply-To: <cbc963d5-6c4b-7e69-4a9b-3d66b95affab@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6538501931528384874=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6538501931528384874==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tue, Feb 23, 2021 at 09:56:13PM +0530, Allen Pais wrote:
> 
> 
> > > > > -	/*
> > > > > -	 * Ask OP-TEE to free all cached shared memory objects to decrease
> > > > > -	 * reference counters and also avoid wild pointers in secure world
> > > > > -	 * into the old shared memory range.
> > > > > -	 */
> > > > > -	optee_disable_shm_cache(optee);
> > > > > +	if (shutdown) {
> > > > > +		optee_disable_shm_cache(optee);
> > > > > +	} else {
> > > > > +		/*
> > > > > +		 * Ask OP-TEE to free all cached shared memory
> > > > > +		 * objects to decrease reference counters and
> > > > > +		 * also avoid wild pointers in secure world
> > > > > +		 * into the old shared memory range.
> > > > > +		 */
> > > > > +		optee_disable_shm_cache(optee);
> > > > Calling optee_disable_shm_cache() in both if and else. It could be
> > > > put in front of if().
> > > > 
> > > 
> > >    Ideally, I could just use optee_remove for shutdown() too.
> > > But it would not look good. Hence this approach.
> > 
> > What is the problem with using optee_remove() for shutdown()?
> > 
> 
>  There is no problem, I just thought it would be more cleaner/readable
> with this approach. If you'd like to keep it simple by just calling
> optee_remove() for shutdown() too, I could quickly send out V2.

In the patch you posted it looks like you'd like to call
only optee_disable_shm_cache() in the case of shutdown. Like:

static void optee_shutdown(struct platform_device *pdev)
{
        optee_disable_shm_cache(platform_get_drvdata(pdev));
}

and optee_remove() kept as it was before this patch.

Cheers,
Jens

--===============6538501931528384874==--

