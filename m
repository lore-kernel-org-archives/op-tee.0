From: Al Viro <viro@zeniv.linux.org.uk>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Mon, 10 Oct 2022 18:57:42 +0100
Message-ID: <Y0RdFni5N6rMsxuM@ZenIV>
In-Reply-To: <
 <CAHk-=whvmR98OHdYf4yOJgp86hq0VMVXJ9b1Qk7P_Rjq_=HU+A@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6267043628155644979=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6267043628155644979==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Mon, Oct 10, 2022 at 10:20:15AM -0700, Linus Torvalds wrote:
> On Mon, Oct 10, 2022 at 12:42 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > I suspect the best long term option would be to just pass an iov_iter..
> 
> Hmm. Yeah, that sounds like a workable model, and solves the problem
> JensW pointed out with my simplistic "just pass a page array" approach
> where you also need to keep track of how to release things.

Except that then you need to get iov_iter_get_pages analogue that would
work for ITER_KVEC, which is exact same problem right back.

--===============6267043628155644979==--

