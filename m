From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add
 FOLL_LONGTERM for CMA case when alloc shm
Date: Thu, 18 May 2023 11:38:20 +0530
Message-ID: 
 <CAFA6WYPgvifYcj_MT7BBcC0BtQDWXV0u+HY8qv0M9nNyiCgkow@mail.gmail.com>
In-Reply-To: <ZGWnq/dAYELyKpTy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5461407135666482099=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5461407135666482099==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 18 May 2023 at 09:51, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
> > In general: if user space controls it -> possibly forever -> long-term. E=
ven
> > if in most cases it's a short delay: there is no trusting on user space.
> >
> > For example, iouring fixed buffers keep pages pinned until user space
> > decides to unregistered the buffers -> long-term.
> >
> > Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
> > unpin in essentially one operation.
>
> Btw, one thing that's been on my mind is that I think we got the
> polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
> behavior it really should be the default, with a FOLL_EPHEMERAL flag
> to opt out of it.  And every users of this flag is required to have
> a comment explaining the life time rules for the pin..

It does look like a better approach to me given the very nature of
user space pages.

-Sumit

--===============5461407135666482099==--

