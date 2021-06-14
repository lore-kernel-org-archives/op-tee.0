From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v4 6/8] tee: Support kernel shm registration without
 dma-buf backing
Date: Mon, 14 Jun 2021 10:29:05 +0530
Message-ID: 
 <CAFA6WYP=8dTZB_ffeTG5FfThLuxcegdKM_UjOtkDOt6H80bBqw@mail.gmail.com>
In-Reply-To: <20210613081607.GT4910@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0779789097957640374=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0779789097957640374==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Jun 2021 at 13:46, Tyler Hicks <tyhicks@linux.microsoft.com> wro=
te:
>
> On 2021-06-12 13:49:38, Sumit Garg wrote:
> > On Fri, 11 Jun 2021 at 18:46, Tyler Hicks <tyhicks@linux.microsoft.com>=
 wrote:
> > >
> > > On 2021-06-11 08:10:01, Tyler Hicks wrote:
> > > > On 2021-06-11 10:46:20, Sumit Garg wrote:
> > > > > On Fri, 11 Jun 2021 at 02:39, Tyler Hicks <tyhicks@linux.microsof=
t.com> wrote:
> > > > > >
> > > > > > Uncouple the registration of kernel shared memory buffers from the
> > > > > > TEE_SHM_DMA_BUF flag. Drivers may wish to allocate multi-page con=
tiguous
> > > > > > shared memory regions but do not need them to be backed by a dma-=
buf
> > > > > > when the memory region is only used by the driver.
> > > > > >
> > > > > > If the TEE implementation does not require shared memory to be
> > > > > > registered, clear the flag prior to calling the corresponding poo=
l alloc
> > > > > > function. Update the OP-TEE driver to respect TEE_SHM_REGISTER, r=
ather
> > > > > > than TEE_SHM_DMA_BUF, when deciding whether to (un)register on
> > > > > > alloc/free operations.
> > > > >
> > > > > > The AMD-TEE driver continues to ignore the
> > > > > > TEE_SHM_REGISTER flag.
> > > > > >
> > > > >
> > > > > That's the main point that no other TEE implementation would honour
> > > > > TEE_SHM_REGISTER and I think it's just the incorrect usage of
> > > > > TEE_SHM_REGISTER flag to suffice OP-TEE underlying implementation.
> > > > >
> > > > > > Allow callers of tee_shm_alloc_kernel_buf() to allocate and regis=
ter a
> > > > > > shared memory region without the backing of dma-buf.
> > > > > >
> > > > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > > > ---
> > > > > >  drivers/tee/optee/shm_pool.c |  5 ++---
> > > > > >  drivers/tee/tee_shm.c        | 13 +++++++++++--
> > > > > >  2 files changed, 13 insertions(+), 5 deletions(-)
> > > > > >
> > > > >
> > > > > This patch is just mixing two separate approaches to TEE shared
> > > > > memory. Have a look at alternative suggestions below.
> > > > >
> > > > > > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm=
_pool.c
> > > > > > index da06ce9b9313..6054343a29fb 100644
> > > > > > --- a/drivers/tee/optee/shm_pool.c
> > > > > > +++ b/drivers/tee/optee/shm_pool.c
> > > > > > @@ -27,7 +27,7 @@ static int pool_op_alloc(struct tee_shm_pool_mg=
r *poolm,
> > > > > >         shm->paddr =3D page_to_phys(page);
> > > > > >         shm->size =3D PAGE_SIZE << order;
> > > > > >
> > > > > > -       if (shm->flags & TEE_SHM_DMA_BUF) {
> > > > > > +       if (shm->flags & TEE_SHM_REGISTER) {
> > > > >
> > > > > Here you can just do following check instead:
> > > > >
> > > > >        if (!(shm->flags & TEE_SHM_PRIV)) {
> > > >
> > > > This is a bug fix series that's intended to fix the current and older
> > > > kernels. tee_shm_alloc_anon_kernel_buf()/TEE_SHM_PRIV is not present =
in
> > > > older kernels and isn't required to fix these kexec/kdump bugs. Your
> > > > suggestion feels like something that should be done in the allocator
> > > > rewrite that Jens is working on to clean all of this up going forward.
> > >
> > > I want to add that I do fully agree with you that TEE_SHM_REGISTER is an
> > > OP-TEE thing and not a TEE thing. Ideally, it wouldn't be defined in
> > > tee_drv.h and would be completely private to the OP-TEE driver.
> > > Likewise, I don't think that tee_shm_register() should exist (certainly
> > > not at the TEE level) because it only works with OP-TEE.
> >
> > I think there is some confusion going on. tee_shm_register() is a
> > standard interface that is listed in TEE client API specification as
> > an alternative approach to tee_shm_alloc(). As I earlier mentioned,
> > please read through "3.2.4. Shared Memory" in TEE Client API
> > Specification.
>
> Thanks for the reminder to go read this spec. I had forgotten to read it
> after you previously mentioned it.
>
> Yes, there was confusion on my part due to reading the code but not
> discovering/reading the spec prior to now.
>
> > In the initial times, OP-TEE only supported tee_shm_alloc() approach
> > but with the addition of dynamic shared memory feature it became
> > possible to support tee_shm_register() as well but we had to add new
> > capability as TEE_GEN_CAP_REG_MEM in order to maintain OP-TEE
> > backwards compatibility. It can very well be the same case for AMD-TEE
> > which currently only supports tee_shm_alloc() approach.
> >
> > The reason for confusion here seems to be that OP-TEE driver is
> > providing a way to leverage dynamic shared memory approach in order to
> > implement tee_shm_alloc() but that doesn't mean at TEE level we should
> > intermix both approaches via using TEE_SHM_REGISTER to implement
> > tee_shm_alloc().
>
> I think that was the reason for my confusion. I didn't understand why
> AMD-TEE didn't have the same need to register memory.
>
> >
> > >
> > > That said, I think the first step is to fix the kexec/kdump bugs and the
> > > second step is to clean up the code to remove the layering violation of
> > > exposing shm registration from the TEE interfaces.
> > >
> >
> > Doesn't the following patch sound suitable to be backported to a
> > stable kernel? It has even less changes compared to your patch as well
> > :).
> >
> > -Sumit
> >
> > -------------------------------------------
> > Subject: [PATCH] tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag
> >
> > Currently TEE_SHM_DMA_BUF flag has been inappropriately used to not
>
> I think the "not" at the end of this line should be removed, right?
>

No, actually shared memory allocated for OP-TEE driver internal usage
didn't enable this flag while in all other invocations TEE_SHM_DMA_BUF
is enabled as the driver's private shared memory isn't required to be
registered with OP-TEE.

> > register shared memory allocated for private usage by underlying TEE
> > driver: OP-TEE in this case. So rather add a new flag as TEE_SHM_PRIV
> > that can be utilized by underlying TEE drivers for private allocation
> > and usage of shared memory.
> >
> > With this corrected, allow tee_shm_alloc_kernel_buf() to allocate a
> > shared memory region without the backing of dma-buf.
>
> I noticed a couple things wrong with this patch during testing.
>

Yeah you are right. Apologies for my oversight as this patch was
compile tested only.

> The first is obviously an oversight. tee_shm_alloc() needs to be updated
> to accept the TEE_SHM_PRIV or it'll throw an "invalid shm flags ..."
> error.
>

Agree.

> The second issue is a little more unclear. I am testing these patches
> along with a debugging patch that prints a bit of info when
> optee_shm_register() or optee_shm_unregister() is called so that I can
> track the (un)registrations. I built a kernel with my v4 series but with
> this patch in place of my 'tee: Support kernel shm registration without
> dma-buf backing' patch. I performed 10x kexec operations and then let
> the system set idle for a while. After a while of sitting idle, I
> noticed a couple calls to optee_shm_register() that I hadn't seen before
> (and haven't seen again). It made me worried that your patch could
> result in us registering shared memory that we previously weren't
> registering so I decided to try to perform another kexec operation to
> ensure that the two shms were properly unregistered. At this point, the
> system became unresponsive and I wasn't able to get a stack trace or any
> more useful information about what happened.
>
> Unfortunately, my debugging patch was only printing the shm's virtual
> address and the shm's size. The shm's size was 4096 bytes.
>
> My current thought is that the two new/unexpected calls to
> optee_shm_register() were triggered by one of the tee_shm_alloc()'s in
> drivers/tee/optee/rpc.c. Neither of those shm allocations would have
> been registered before your change but they both would be after your
> change. I think the easy fix is to use the TEE_SHM_PRIV flag for both of
> the allocations in rpc.c. Do you agree? If so, I'll make these changes
> and fold this patch into my series and send out a v5.

Yeah I agree, please use TEE_SHM_PRIV for private shm allocations in
drivers/tee/optee/rpc.c as well.

>
> I still can't explain why the system became unresponsive after the two
> registrations...

Probably the two registrations created a cyclic loop and cores got
hung in there.

-Sumit

>
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/optee/call.c     | 2 +-
> >  drivers/tee/optee/core.c     | 3 ++-
> >  drivers/tee/optee/shm_pool.c | 8 ++++++--
> >  drivers/tee/tee_shm.c        | 2 +-
> >  include/linux/tee_drv.h      | 1 +
> >  5 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 6132cc8d014c..faaa13c9172b 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -184,7 +184,7 @@ static struct tee_shm *get_msg_arg(struct
> > tee_context *ctx, size_t num_params,
> >         struct optee_msg_arg *ma;
> >
> >         shm =3D tee_shm_alloc(ctx, OPTEE_MSG_GET_ARG_SIZE(num_params),
> > -                           TEE_SHM_MAPPED);
> > +                           TEE_SHM_MAPPED | TEE_SHM_PRIV);
> >         if (IS_ERR(shm))
> >                 return shm;
> >
> > diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> > index ddb8f9ecf307..eac0e91ec559 100644
> > --- a/drivers/tee/optee/core.c
> > +++ b/drivers/tee/optee/core.c
> > @@ -277,7 +277,8 @@ static void optee_release(struct tee_context *ctx)
> >         if (!ctxdata)
> >                 return;
> >
> > -       shm =3D tee_shm_alloc(ctx, sizeof(struct optee_msg_arg), TEE_SHM_=
MAPPED);
> > +       shm =3D tee_shm_alloc(ctx, sizeof(struct optee_msg_arg),
> > +                           TEE_SHM_MAPPED | TEE_SHM_PRIV);
> >         if (!IS_ERR(shm)) {
> >                 arg =3D tee_shm_get_va(shm, 0);
> >                 /*
> > diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
> > index d767eebf30bd..3b4a3853a10f 100644
> > --- a/drivers/tee/optee/shm_pool.c
> > +++ b/drivers/tee/optee/shm_pool.c
> > @@ -27,7 +27,11 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *pool=
m,
> >         shm->paddr =3D page_to_phys(page);
> >         shm->size =3D PAGE_SIZE << order;
> >
> > -       if (shm->flags & TEE_SHM_DMA_BUF) {
> > +       /*
> > +        * Shared memory private to the OP-TEE driver doesn't need
> > +        * to be registered with OP-TEE.
> > +        */
> > +       if (!(shm->flags & TEE_SHM_PRIV)) {
> >                 unsigned int nr_pages =3D 1 << order, i;
> >                 struct page **pages;
> >
> > @@ -52,7 +56,7 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
> >  static void pool_op_free(struct tee_shm_pool_mgr *poolm,
> >                          struct tee_shm *shm)
> >  {
> > -       if (shm->flags & TEE_SHM_DMA_BUF)
> > +       if (!(shm->flags & TEE_SHM_PRIV))
> >                 optee_shm_unregister(shm->ctx, shm);
> >
> >         free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index c425ad80d6a6..f8b73e734094 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -207,7 +207,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
> >   */
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t=
 size)
> >  {
> > -       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> > +       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
>
> This was a malformed patch due to this hunk. I think an empty line was
> left out of the context.
>
> Tyler
>
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 8990f7628387..3ebfea0781f1 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -27,6 +27,7 @@
> >  #define TEE_SHM_USER_MAPPED    BIT(4)  /* Memory mapped in user space */
> >  #define TEE_SHM_POOL           BIT(5)  /* Memory allocated from pool */
> >  #define TEE_SHM_KERNEL_MAPPED  BIT(6)  /* Memory mapped in kernel space =
*/
> > +#define TEE_SHM_PRIV           BIT(7)  /* Memory private to TEE driver */
> >
> >  struct device;
> >  struct tee_device;
> >

--===============0779789097957640374==--

