From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 01:08:42 -0700
Message-ID: <ZGSLiiK/JzD5KMd7@infradead.org>
In-Reply-To: <
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3714368436993576040=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3714368436993576040==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, May 17, 2023 at 01:22:51PM +0530, Sumit Garg wrote:
> > > +#if IS_ENABLED(CONFIG_CMA)
> > > +     page_flag |= FOLL_LONGTERM;
> > > +#endif
> > >       if (flags & TEE_SHM_USER_MAPPED)
> >
> > If this mapping is long live it should always use FOLL_LONGTERM.
> 
> It depends on the userspace application needs. However, I think it
> should be safe to use FOLL_LONGTERM by default to serve cases like
> secure media playback.

long term is defined as won't automatically go away during the same
syscall.

--===============3714368436993576040==--

