From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date: Thu, 10 Jun 2021 16:05:01 -0500
Message-ID: <20210610210501.GP4910@sequoia>
In-Reply-To: <20210610074948.GC2753553@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1020578611670135357=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1020578611670135357==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-10 09:49:48, Jens Wiklander wrote:
> On Wed, Jun 09, 2021 at 08:42:25AM -0500, Tyler Hicks wrote:
> [snip]
> > > I've just posted "[PATCH 0/7] tee: shared memory updates",
> > > https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander(a)=
linaro.org/
> > >=20
> > > Where tee_shm_alloc() is replaced by among other functions
> > > tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> > > problem with TEE_SHM_DMA_BUF.
> >=20
> > Thanks! At first glance, that series would take care of the last three
> > patches in my kexec/kdump series.
> >=20
> > I'm a bit worried that it is a rewrite of the shm allocator. Do you plan
> > to send all of that to stable? (I mentioned earlier in this thread that
> > I'm affected by these bugs in linux-5.4.y.)
>=20
> No, that might be a bit much.
>=20
> > Also, you and Sumit don't seem to have the same opinion on kernel
> > drivers making use of tee_shm_register() for allocations that are only
> > used internally. Can you comment on that?
> >=20
> > I'm not clear on the next steps for fixing these kexec/kdump bugs in
> > older releases. I appreciate any guidance here.
>=20
> Neither am I be honest. You're the only one that has brought up this
> problem so perhaps it's enough to focus on the stable branch you need to
> have fixed.

I've already added Fixes tags to all of my patches. If you are
comfortable with them going to stable, you'd add
'Cc: stable(a)vger.kernel.org' to them if/when you merge them so that the
stable team will ensure that they're applied.

Note that I'm not the only person that brought up this bug:

 https://github.com/OP-TEE/optee_os/issues/3637

Once I started digging in, I realized that there were more kexec/kdump
bugs and the series grew.

> If I've understood it correctly it's best if it's possible to
> cherry-pick the fixes from mainline to the stable branch in question.
> So we must make sure to get your needed patches in before any rewrites
> that would make cherry-picking impossible. The rewrite I'm proposing
> isn't urgent so it can be held off for a while.

Thanks for holding off. I'll be quick on my revisions so that you don't
have to moth ball your series for too much longer.

Tyler

>=20
> Cheers,
> Jens
>=20

--===============1020578611670135357==--

