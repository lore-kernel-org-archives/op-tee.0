From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] tee: Support shm registration without dma-buf backing
Date: Thu, 10 Jun 2021 09:49:48 +0200
Message-ID: <20210610074948.GC2753553@jade>
In-Reply-To: <20210609134225.GC4910@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3571461490335247620=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3571461490335247620==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 09, 2021 at 08:42:25AM -0500, Tyler Hicks wrote:
[snip]
> > I've just posted "[PATCH 0/7] tee: shared memory updates",
> > https://lore.kernel.org/lkml/20210609102324.2222332-1-jens.wiklander(a)li=
naro.org/
> >=20
> > Where tee_shm_alloc() is replaced by among other functions
> > tee_shm_alloc_kernel_buf(). tee_shm_alloc_kernel_buf() takes care of the
> > problem with TEE_SHM_DMA_BUF.
>=20
> Thanks! At first glance, that series would take care of the last three
> patches in my kexec/kdump series.
>=20
> I'm a bit worried that it is a rewrite of the shm allocator. Do you plan
> to send all of that to stable? (I mentioned earlier in this thread that
> I'm affected by these bugs in linux-5.4.y.)

No, that might be a bit much.

> Also, you and Sumit don't seem to have the same opinion on kernel
> drivers making use of tee_shm_register() for allocations that are only
> used internally. Can you comment on that?
>=20
> I'm not clear on the next steps for fixing these kexec/kdump bugs in
> older releases. I appreciate any guidance here.

Neither am I be honest. You're the only one that has brought up this
problem so perhaps it's enough to focus on the stable branch you need to
have fixed.

If I've understood it correctly it's best if it's possible to
cherry-pick the fixes from mainline to the stable branch in question.
So we must make sure to get your needed patches in before any rewrites
that would make cherry-picking impossible. The rewrite I'm proposing
isn't urgent so it can be held off for a while.

Cheers,
Jens

--===============3571461490335247620==--

