From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Date: Fri, 07 Oct 2022 10:12:57 +0200
Message-ID: 
 <CAHUa44GkTLCzuSij5FbjBXFBM1CCQROtrCtHHtj70ZRi-3K7uA@mail.gmail.com>
In-Reply-To: <
 <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3615649661033276935=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3615649661033276935==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thu, Oct 6, 2022 at 8:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Oct 5, 2022 at 11:24 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Sorry but you need to get your driver mainline in order to support
> > vmalloc interface.
>
> Actually, I think even then we shouldn't support vmalloc - and
> register_shm_helper() just needs to be changed to pass in an array of
> actual page pointers instead.

register_shm_helper() is an internal function, I suppose it's what's
passed to tee_shm_register_user_buf() and especially
tee_shm_register_kernel_buf() in this case.

So the gain is that in the kernel it becomes the caller's
responsibility to provide the array of page pointers and the TEE
subsystem doesn't need to care about what kind of kernel memory it is
any longer. Yes, that should avoid eventual complexities with
vmalloc() etc.

>
> At that point TEE_SHM_USER_MAPPED should also go away, because then
> it's the caller that should just do either the user space page
> pinning, or pass in the kernel page pointer.
>
> JensW, is there some reason that wouldn't work?

We still need to know if it's kernel or user pages in
release_registered_pages().

The struct tee_shm:s acquired with syscalls from user space are
reference counted. As are the kernel tee_shm:s, but I believe we could
separate them to avoid reference counting tee_shm:s used by kernel
clients if needed. I'll need to look closer at this if we're going to
use that approach.

Without reference counting the caller of tee_shm_free() can be certain
that the secure world is done with the memory so we could delegate the
kernel pages part of release_registered_pages() to the caller instead.

Cheers,
Jens

>
>                  Linus

--===============3615649661033276935==--

