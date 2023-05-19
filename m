From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Fri, 19 May 2023 16:33:04 +0530
Message-ID: 
 <CAFA6WYOfku70PXso9LeO0G=443NVFKsmxgsZUnMwKwnSZ6bg5A@mail.gmail.com>
In-Reply-To: <83a846a9-8f88-3f66-b840-e84d072bb0fb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4631702728669278308=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4631702728669278308==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 19 May 2023 at 15:31, David Hildenbrand <david@redhat.com> wrote:
>
> On 18.05.23 08:40, Xiaoming Ding (丁晓明) wrote:
> >  From 35fd062d5cbc4d182eee0183843cd6350d126788 Mon Sep 17 00:00:00 2001
> > From: Xiaoming Ding <xiaoming.ding@mediatek.com>
> > Date: Wed, 10 May 2023 10:15:23 +0800
> > Subject: [PATCH v2] tee: add FOLL_LONGTERM for CMA case when alloc shm
> >
> > CMA is widely used on insufficient memory platform for
> > secure media playback case, and FOLL_LONGTERM will
> > avoid tee_shm alloc pages from CMA region.
> > without FOLL_LONGTERM, CMA region may alloc failed since
> > tee_shm has a chance to use it in advance.
> >
> > modify is verified on OPTEE XTEST and kinds of secure + clear playback
> >
> >
> > Fixes: 033ddf12bcf5 ("tee: add register user memory")
> > Signed-off-by: Xiaoming Ding <xiaoming.ding@mediatek.com>
> > ---
> > v1 -> v2: take off the ifdef and apply FOLL_LONGTERM by default
> >
> >   drivers/tee/tee_shm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 673cf0359494..38878e549ca4 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -257,7 +257,7 @@ register_shm_helper(struct tee_context *ctx,
> > unsigned long addr,
> >       }
> >
> >       if (flags & TEE_SHM_USER_MAPPED)
> > -             rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
> > +             rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE |
> > FOLL_LONGTERM,
> >                                        shm->pages);
> >       else
> >               rc = shm_get_kernel_pages(start, num_pages, shm-
> >> pages);
>
> I didn't dive deeply into that code, but I can spot that we can end up
> long-term pinning multiple pages -- possibly unbound or is there any
> sane limit on the number of pages?

I am not aware of any limit that we put on pinning user-space pages.

>
> Take a look at io_uring/rsrc.c and how we account long-term pinned pages
> against user->locked_vm/ctx->mm_account->pinned_vm in io_account_mem().
>
> If user space could only end up pinning one or two pages via that
> interface, ok. But it looks like this interface could be abused to
> create real real trouble by unprivileged users that should be able to
> long-term pin that many pages.
>
> Am I missing something important (i.e., interface is only accessible by
> privileged users) or should there be proper accounting and
> RLIMIT_MEMLOCK checks?

So your observation is correct. With long term pinning we have to
implement similar RLIMIT_MEMLOCK checks. Thanks for your insights
here.

-Sumit

>
> --
> Thanks,
>
> David / dhildenb
>

--===============4631702728669278308==--

