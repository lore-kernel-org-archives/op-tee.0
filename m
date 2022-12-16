From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Fri, 16 Dec 2022 10:39:44 +0530
Message-ID: 
 <CAFA6WYNMRymyqkqfASYAPVoL0iR2kw0h9YKZ1gBTdeSuHMOAtQ@mail.gmail.com>
In-Reply-To: <Y5u+oOLkJs6jehik@iweiny-desk3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8369004989525902053=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8369004989525902053==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Dec 2022 at 06:11, Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Fri, Oct 07, 2022 at 10:12:57AM +0200, Jens Wiklander wrote:
> > On Thu, Oct 6, 2022 at 8:20 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Wed, Oct 5, 2022 at 11:24 PM Sumit Garg <sumit.garg@linaro.org> wr=
ote:
> > > >
> > > > Sorry but you need to get your driver mainline in order to support
> > > > vmalloc interface.
> > >
> > > Actually, I think even then we shouldn't support vmalloc - and
> > > register_shm_helper() just needs to be changed to pass in an array of
> > > actual page pointers instead.
> >
> > register_shm_helper() is an internal function, I suppose it's what's
> > passed to tee_shm_register_user_buf() and especially
> > tee_shm_register_kernel_buf() in this case.
> >
> > So the gain is that in the kernel it becomes the caller's
> > responsibility to provide the array of page pointers and the TEE
> > subsystem doesn't need to care about what kind of kernel memory it is
> > any longer. Yes, that should avoid eventual complexities with
> > vmalloc() etc.
>
> I finally spent some time digging into this again.
>
> Overall I'm not opposed to trying to clean up the code more but I feel like=
 the
> removal of TEE_SHM_USER_MAPPED is too complex for the main goal; to remove a
> caller of kmap_to_page().
>
> Not only is that flag used in release_registered_pages() but it is also use=
d in
> tee_shm_fop_mmap().  I'm not following exactly why.  I think this is to all=
ow
> mmap of the tee_shm's allocated by kernel users?

No, its rather to allow mmap of tee_shm allocated via
tee_shm_alloc_user_buf(). Have a look at its user-space usage here
[1]. So overall I agree here that we can't get rid of
TEE_SHM_USER_MAPPED completely as it has a valid mmap use-case.

[1] https://github.com/OP-TEE/optee_client/blob/master/libteec/src/tee_client=
_api.c#L907

>  Which I _think_ is
> orthogonal to the callers of tee_shm_register_kernel_buf()?
>
> >
> > >
> > > At that point TEE_SHM_USER_MAPPED should also go away, because then
> > > it's the caller that should just do either the user space page
> > > pinning, or pass in the kernel page pointer.
> > >
> > > JensW, is there some reason that wouldn't work?
> >
> > We still need to know if it's kernel or user pages in
> > release_registered_pages().
>
> Yes.
>
> As I dug into this it seemed ok to define a tee_shm_kernel_free().  Pull out
> the allocation of the page array from register_shm_helper() such that it co=
uld
> be handled by tee_shm_register_kernel_buf() and this new tee_shm_kernel_fre=
e().
>

+1

> This seems reasonable because the only callers of tee_shm_register_kernel_b=
uf()
> are in trusted_tee.c and they all call tee_shm_free() on the registered mem=
ory
> prior to returning.
>
> Other callers[*] of tee_shm_free() obtained tee_shm from
> tee_shm_alloc_kernel_buf() which AFAICT avoids all this nonsense.
>
> [*] such as .../drivers/firmware/broadcom/tee_bnxt_fw.c.
>
> >
> > The struct tee_shm:s acquired with syscalls from user space are
> > reference counted. As are the kernel tee_shm:s, but I believe we could
> > separate them to avoid reference counting tee_shm:s used by kernel
> > clients if needed. I'll need to look closer at this if we're going to
> > use that approach.
> >
> > Without reference counting the caller of tee_shm_free() can be certain
> > that the secure world is done with the memory so we could delegate the
> > kernel pages part of release_registered_pages() to the caller instead.
> >
>
> I'm not sure I follow you here.  Would this be along the lines of creating a
> tee_shm_free_kernel() to be used in trusted_tee.c for those specific kernel
> data?

I can't find a reason/use-case for the TEE subsystem to keep a
refcount of memory registered by other kernel drivers like
trusted_tee.c. So yes I think it should be safe to directly free that
shm via tee_shm_free_kernel(). Also with that we can simplify shm
registration by kernel clients via directly passing page pointers to
tee_shm_register_kernel_buf() (I would rather rename this API as
tee_shm_register_kernel_pages()).

-Sumit

>
> Overall I feel like submitting this series again with Christoph and Al's
> comments addressed is the best way forward to get rid of kmap_to_page().  I
> would really like to get moving on that to avoid any further issues with the
> kmap conversions.
>
> But if folks feel strongly enough about removing that flag I can certainly =
try
> to do so.
>
> Ira
>
> > Cheers,
> > Jens
> >
> > >
> > >                  Linus

--===============8369004989525902053==--

