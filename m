From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 1/2] optee: fix tee out of memory failure seen during kexec reboot
Date: Tue, 23 Feb 2021 09:19:48 +0100
Message-ID: <20210223081948.GA1836717@jade>
In-Reply-To: <8d87655f-27c6-6a66-6eb0-9244279fbf2c@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8797623484363863875=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8797623484363863875==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Feb 22, 2021 at 06:15:08PM +0530, Allen Pais wrote:
> 
> > On Wed, 17 Feb 2021 14:57:12 +0530, Allen Pais wrote:
> > > -	/*
> > > -	 * Ask OP-TEE to free all cached shared memory objects to decrease
> > > -	 * reference counters and also avoid wild pointers in secure world
> > > -	 * into the old shared memory range.
> > > -	 */
> > > -	optee_disable_shm_cache(optee);
> > > +	if (shutdown) {
> > > +		optee_disable_shm_cache(optee);
> > > +	} else {
> > > +		/*
> > > +		 * Ask OP-TEE to free all cached shared memory
> > > +		 * objects to decrease reference counters and
> > > +		 * also avoid wild pointers in secure world
> > > +		 * into the old shared memory range.
> > > +		 */
> > > +		optee_disable_shm_cache(optee);
> > Calling optee_disable_shm_cache() in both if and else. It could be
> > put in front of if().
> > 
> 
>   Ideally, I could just use optee_remove for shutdown() too.
> But it would not look good. Hence this approach.

What is the problem with using optee_remove() for shutdown()?

Cheers,
Jens

--===============8797623484363863875==--

