From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 15:49:00 +0530
Message-ID: 
 <CAFA6WYO+EpiECFxdVgmd-Ey9jq1Ybt78WupK_bW5+oDcW-soVQ@mail.gmail.com>
In-Reply-To: <ZGSgCZrg+RjAbGO1@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8681985710632112098=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8681985710632112098==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, 17 May 2023 at 15:06, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, May 17, 2023 at 02:56:13PM +0530, Sumit Garg wrote:
> > Do you mean a pinned user-space page can be paged out automatically?
>
> No, pinned pages can't be paged out.
>
> But a short term pin implies it will be release after a short delay,
> and it is feasible for wait for the pin to go away.

Okay, I see. I would be interested to know the ranges for that short
delay. I guess it may depend on how much memory pressure there is...

>
> For a long term pin waiting is not an option, and anyone wanting to
> do something with the pinned page that requires it to not be pinned
> must simply give up.
>
> > Just FYI, the underlying use-case for TEE registered shared memory is
> > that the references to pinned pages are provided to TEE implementation
> > to operate upon. This can happen over multiple syscalls and we want
> > the pinned pages to be always in RAM as otherwise the physical
> > addresses may change if they are paged out in between.
>
> That's a very use clear case for a long term pin.

...however, thanks for the insights.

@Xiaoming,

Please use the following fixes tag for the v2 along with extending the
commit description regarding the reliability provided by the long term
flag.

Fixes: 033ddf12bcf5 ("tee: add register user memory")

-Sumit

--===============8681985710632112098==--

