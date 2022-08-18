From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] tee: add overflow check in register_shm_helper()
Date: Thu, 18 Aug 2022 19:00:41 +0530
Message-ID: 
 <CAFA6WYOwXZU6-BUGPg59AcH4QB6oS=Z=Cq9ZwZdfkDa+X5nB-w@mail.gmail.com>
In-Reply-To: <
 <CAHUa44HoS4QgDzVgcsZkgAhK81wGXKQyqLWbLe9tqqrQELx=MA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4831962135791878473=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4831962135791878473==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Aug 2022 at 18:32, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> Hi Sumit,
>
> On Thu, Aug 18, 2022 at 2:41 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Jens,
> >
> > On Thu, 18 Aug 2022 at 16:39, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > With special lengths supplied by user space, register_shm_helper() has
> > > an integer overflow when calculating the number of pages covered by a
> > > supplied user space memory region. This causes
> > > internal_get_user_pages_fast() a helper function of
> > > pin_user_pages_fast() to do a NULL pointer dereference.
> > >
> > > [   14.141620] Unable to handle kernel NULL pointer dereference at virt=
ual address 0000000000000010
> > > [   14.142556] Mem abort info:
> > > [   14.142829]   ESR =3D 0x0000000096000044
> > > [   14.143237]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > [   14.143742]   SET =3D 0, FnV =3D 0
> > > [   14.144052]   EA =3D 0, S1PTW =3D 0
> > > [   14.144348]   FSC =3D 0x04: level 0 translation fault
> > > [   14.144767] Data abort info:
> > > [   14.145053]   ISV =3D 0, ISS =3D 0x00000044
> > > [   14.145394]   CM =3D 0, WnR =3D 1
> > > [   14.145766] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000004278e=
000
> > > [   14.146279] [0000000000000010] pgd=3D0000000000000000, p4d=3D0000000=
000000000
> > > [   14.147435] Internal error: Oops: 96000044 [#1] PREEMPT SMP
> > > [   14.148026] Modules linked in:
> > > [   14.148595] CPU: 1 PID: 173 Comm: optee_example_a Not tainted 5.19.0=
 #11
> > > [   14.149204] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/=
06/2015
> > > [   14.149832] pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > > [   14.150481] pc : internal_get_user_pages_fast+0x474/0xa80
> > > [   14.151640] lr : internal_get_user_pages_fast+0x404/0xa80
> > > [   14.152408] sp : ffff80000a88bb30
> > > [   14.152711] x29: ffff80000a88bb30 x28: 0000fffff836d000 x27: 0000fff=
ff836e000
> > > [   14.153580] x26: fffffc0000000000 x25: fffffc0000f4a1c0 x24: ffff000=
00289fb70
> > > [   14.154634] x23: ffff000002702e08 x22: 0000000000040001 x21: ffff800=
0097eec60
> > > [   14.155378] x20: 0000000000f4a1c0 x19: 00e800007d287f43 x18: 0000000=
000000000
> > > [   14.156215] x17: 0000000000000000 x16: 0000000000000000 x15: 0000fff=
ff836cfb0
> > > [   14.157068] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000=
000000000
> > > [   14.157747] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000=
000000000
> > > [   14.158576] x8 : ffff00000276ec80 x7 : 0000000000000000 x6 : 0000000=
00000003f
> > > [   14.159243] x5 : 0000000000000000 x4 : ffff000041ec4eac x3 : ffff000=
002774cb8
> > > [   14.159977] x2 : 0000000000000004 x1 : 0000000000000010 x0 : 0000000=
000000000
> > > [   14.160883] Call trace:
> > > [   14.161166]  internal_get_user_pages_fast+0x474/0xa80
> > > [   14.161763]  pin_user_pages_fast+0x24/0x4c
> > > [   14.162227]  register_shm_helper+0x194/0x330
> > > [   14.162734]  tee_shm_register_user_buf+0x78/0x120
> > > [   14.163290]  tee_ioctl+0xd0/0x11a0
> > > [   14.163739]  __arm64_sys_ioctl+0xa8/0xec
> > > [   14.164227]  invoke_syscall+0x48/0x114
> > > [   14.164653]  el0_svc_common.constprop.0+0x44/0xec
> > > [   14.165130]  do_el0_svc+0x2c/0xc0
> > > [   14.165498]  el0_svc+0x2c/0x84
> > > [   14.165847]  el0t_64_sync_handler+0x1ac/0x1b0
> > > [   14.166258]  el0t_64_sync+0x18c/0x190
> > > [   14.166878] Code: 91002318 11000401 b900f7e1 f9403be1 (f820d839)
> > > [   14.167666] ---[ end trace 0000000000000000 ]---
> > >
> > > Fix this by adding an overflow check when calculating the end of the
> > > memory range. Also add an explicit call to access_ok() in
> > > tee_shm_register_user_buf() to catch an invalid user space address
> > > early.
> > >
> > > Fixes: 033ddf12bcf5 ("tee: add register user memory")
> > > Cc: stable(a)vger.kernel.org
> > > Reported-by: Nimish Mishra <neelam.nimish@gmail.com>
> > > Reported-by: Anirban Chakraborty <ch.anirban00727@gmail.com>
> > > Reported-by: Debdeep Mukhopadhyay <debdeep.mukhopadhyay@gmail.com>
> > > Suggested-by: Jerome Forissier <jerome.forissier@linaro.org>
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  drivers/tee/tee_shm.c | 23 +++++++++++++++++++----
> > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > >
> >
> > I can't see the v1 and neither a changelog for v2, so my comments
> > below may be duplicate.
>
> Fair point. The original patch wasn't posted publicly, but in order to
> avoid confusion with that patch I chose to publish this as V2.
>
> >
> > > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > > index f2b1bcefcadd..f71651021c8d 100644
> > > --- a/drivers/tee/tee_shm.c
> > > +++ b/drivers/tee/tee_shm.c
> > > @@ -231,15 +231,30 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> > >
> > >  static struct tee_shm *
> > >  register_shm_helper(struct tee_context *ctx, unsigned long addr,
> > > -                   size_t length, u32 flags, int id)
> > > +                   unsigned long length, u32 flags, int id)
> > >  {
> > >         struct tee_device *teedev =3D ctx->teedev;
> > > +       unsigned long end_addr;
> > >         struct tee_shm *shm;
> > >         unsigned long start;
> > >         size_t num_pages;
> > >         void *ret;
> > >         int rc;
> > >
> > > +       /* Check for overflows, this may be input from user space */
> >
> > IMO, this bound checking should be part of the parent function (like
> > tee_shm_register_user_buf() in this case).
>
> I don't see any harm in checking it here even if it will then check
> input from tee_shm_register_kernel_buf() too. Then I'm also reusing
> the result in the roundup() and that should be done in this function.
>
> >
> > > +       addr =3D untagged_addr(addr);
> > > +       start =3D rounddown(addr, PAGE_SIZE);
> > > +       if (check_add_overflow(addr, length, &end_addr))
> > > +               return ERR_PTR(-EINVAL);
> >
> > Isn't this check redundant after access_ok()? AFAICS, access_ok()
> > should limit the upper bound to TASK_SIZE_MAX which should detect any
> > overflows.
>
> It may be redundant, depending on the configuration. It's likely
> redundant on all platforms we care about at the moment, but who knows
> where this will be used in the future.
>

Firstly, access_ok() is the common kernel way to check for valid
user-space access as per quote below from
include/asm-generic/access_ok.h:

  /*
   * 'size' is a compile-time constant for most callers, so optimize for
   * this case to turn the check into a single comparison against a constant
   * limit and catch all possible overflows.
   * On architectures with separate user address space (m68k, s390, parisc,
   * sparc64) or those without an MMU, this should always return true.
   *
   * This version was originally contributed by Jonas Bonn for the
   * OpenRISC architecture, and was found to be the most efficient
   * for constant 'size' and 'limit' values.
   */

So we shouldn't invent a redundant method to check if there is a buggy
arch override for access_ok(). Also, results from check_add_overflow()
are still inaccurate as it can allow addresses greater than
TASK_SIZE_MAX.

Secondly, a redundant check which is anticipated to fix a future arch
bug doesn't qualify for a fix patch.

-Sumit

> >
> > > +       end_addr =3D roundup(end_addr, PAGE_SIZE);
> > > +       if (end_addr < start)
> > > +               return ERR_PTR(-EINVAL);
> >
> > Ditto?
>
> Yeah, same argument.
>
> Thanks,
> Jens
>
> >
> > -Sumit
> >
> > > +       num_pages =3D (end_addr - start) / PAGE_SIZE;
> > > +
> > > +       /* Error out early if no pages are to be registered */
> > > +       if (!num_pages)
> > > +               return ERR_PTR(-EINVAL);
> > > +
> > >         if (!tee_device_get(teedev))
> > >                 return ERR_PTR(-EINVAL);
> > >
> > > @@ -261,11 +276,8 @@ register_shm_helper(struct tee_context *ctx, unsig=
ned long addr,
> > >         shm->flags =3D flags;
> > >         shm->ctx =3D ctx;
> > >         shm->id =3D id;
> > > -       addr =3D untagged_addr(addr);
> > > -       start =3D rounddown(addr, PAGE_SIZE);
> > >         shm->offset =3D addr - start;
> > >         shm->size =3D length;
> > > -       num_pages =3D (roundup(addr + length, PAGE_SIZE) - start) / PAG=
E_SIZE;
> > >         shm->pages =3D kcalloc(num_pages, sizeof(*shm->pages), GFP_KERN=
EL);
> > >         if (!shm->pages) {
> > >                 ret =3D ERR_PTR(-ENOMEM);
> > > @@ -326,6 +338,9 @@ struct tee_shm *tee_shm_register_user_buf(struct te=
e_context *ctx,
> > >         void *ret;
> > >         int id;
> > >
> > > +       if (!access_ok((void __user *)addr, length))
> > > +               return ERR_PTR(-EFAULT);
> > > +
> > >         mutex_lock(&teedev->mutex);
> > >         id =3D idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
> > >         mutex_unlock(&teedev->mutex);
> > > --
> > > 2.31.1
> > >

--===============4831962135791878473==--

