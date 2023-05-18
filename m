From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: FOLL_LONGTERM vs FOLL_EPHEMERAL Re: [PATCH] tee: add FOLL_LONGTERM
 for CMA case when alloc shm
Date: Wed, 17 May 2023 21:20:59 -0700
Message-ID: <ZGWnq/dAYELyKpTy@infradead.org>
In-Reply-To: <d4773626-6cf0-c929-c775-a84ac41fd719@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2101597615065388727=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2101597615065388727==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, May 17, 2023 at 08:23:33PM +0200, David Hildenbrand wrote:
> In general: if user space controls it -> possibly forever -> long-term. Even
> if in most cases it's a short delay: there is no trusting on user space.
> 
> For example, iouring fixed buffers keep pages pinned until user space
> decides to unregistered the buffers -> long-term.
> 
> Short-term is, for example, something like O_DIRECT where we pin -> DMA ->
> unpin in essentially one operation.

Btw, one thing that's been on my mind is that I think we got the
polarity on FOLL_LONGTERM wrong.  Instead of opting into the long term
behavior it really should be the default, with a FOLL_EPHEMERAL flag
to opt out of it.  And every users of this flag is required to have
a comment explaining the life time rules for the pin..

--===============2101597615065388727==--

