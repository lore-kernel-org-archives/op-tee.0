From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 02:36:09 -0700
Message-ID: <ZGSgCZrg+RjAbGO1@infradead.org>
In-Reply-To: <
 <CAFA6WYPOMwmrA3J84AHzoD2eAtNkpMxr754qHpc-j6XRkgFFvQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3862502440008220124=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3862502440008220124==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, May 17, 2023 at 02:56:13PM +0530, Sumit Garg wrote:
> Do you mean a pinned user-space page can be paged out automatically?

No, pinned pages can't be paged out.

But a short term pin implies it will be release after a short delay,
and it is feasible for wait for the pin to go away.

For a long term pin waiting is not an option, and anyone wanting to
do something with the pinned page that requires it to not be pinned
must simply give up.

> Just FYI, the underlying use-case for TEE registered shared memory is
> that the references to pinned pages are provided to TEE implementation
> to operate upon. This can happen over multiple syscalls and we want
> the pinned pages to be always in RAM as otherwise the physical
> addresses may change if they are paged out in between.

That's a very use clear case for a long term pin.

--===============3862502440008220124==--

