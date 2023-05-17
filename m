From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 14:56:13 +0530
Message-ID: 
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>
In-Reply-To: <ZGSLiiK/JzD5KMd7@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7204809796694202817=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7204809796694202817==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 17 May 2023 at 13:38, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 17, 2023 at 01:22:51PM +0530, Sumit Garg wrote:
> > > > +#if IS_ENABLED(CONFIG_CMA)
> > > > +     page_flag |= FOLL_LONGTERM;
> > > > +#endif
> > > >       if (flags & TEE_SHM_USER_MAPPED)
> > >
> > > If this mapping is long live it should always use FOLL_LONGTERM.
> >
> > It depends on the userspace application needs. However, I think it
> > should be safe to use FOLL_LONGTERM by default to serve cases like
> > secure media playback.
>
> long term is defined as won't automatically go away during the same
> syscall.

Do you mean a pinned user-space page can be paged out automatically?
The documentation [1] isn't very helpful here either since it talks
about "short term" vs "long term" in abstract terms.

Just FYI, the underlying use-case for TEE registered shared memory is
that the references to pinned pages are provided to TEE implementation
to operate upon. This can happen over multiple syscalls and we want
the pinned pages to be always in RAM as otherwise the physical
addresses may change if they are paged out in between. If this is only
supported reliably with a long term flag then this patch should be
tagged as a fix and requires stable backports.

[1] Documentation/core-api/pin_user_pages.rst

-Sumit

--===============7204809796694202817==--

