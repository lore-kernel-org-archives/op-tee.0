From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Mon, 04 Dec 2023 18:12:04 +0530
Message-ID: 
 <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
In-Reply-To: <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5523356071186537043=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5523356071186537043==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+ Jens A., Al Viro

<snip>

> >>>> +        */
> >>>> +       if (iov_iter_is_kvec(iter))
> >>>> +               shm_get_kernel_pages(shm->pages, num_pages);
> >>>> +
> >>>> +       shm->offset =3D off;
> >>>> +       shm->size =3D len;
> >>>> +       shm->num_pages =3D num_pages;
> >>>> +
> >>>>         rc =3D teedev->desc->ops->shm_register(ctx, shm, shm->pages,
> >>>>                                              shm->num_pages, start);
> >>>>         if (rc) {
> >>>> @@ -279,10 +276,11 @@ register_shm_helper(struct tee_context *ctx, uns=
igned long addr,
> >>>>
> >>>>         return shm;
> >>>>  err_put_shm_pages:
> >>>> -       if (flags & TEE_SHM_USER_MAPPED)
> >>>> +       if (!iov_iter_is_kvec(iter))
> >>>>                 unpin_user_pages(shm->pages, shm->num_pages);
> >>>>         else
> >>>>                 shm_put_kernel_pages(shm->pages, shm->num_pages);
> >>>> +err_free_shm_pages:
> >>>>         kfree(shm->pages);
> >>>>  err_free_shm:
> >>>>         kfree(shm);
> >>>> @@ -307,8 +305,9 @@ struct tee_shm *tee_shm_register_user_buf(struct t=
ee_context *ctx,
> >>>>         u32 flags =3D TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
> >>>>         struct tee_device *teedev =3D ctx->teedev;
> >>>>         struct tee_shm *shm;
> >>>> +       struct iov_iter iter;
> >>>>         void *ret;
> >>>> -       int id;
> >>>> +       int id, err;
> >>>>
> >>>>         if (!access_ok((void __user *)addr, length))
> >>>>                 return ERR_PTR(-EFAULT);
> >>>> @@ -319,7 +318,11 @@ struct tee_shm *tee_shm_register_user_buf(struct =
tee_context *ctx,
> >>>>         if (id < 0)
> >>>>                 return ERR_PTR(id);
> >>>>
> >>>> -       shm =3D register_shm_helper(ctx, addr, length, flags, id);
> >>>> +       err =3D import_ubuf(ITER_DEST, (void __user *)addr, length, &i=
ter);
> >>>
> >>> As I mentioned in a previous review, import_ubuf() already does the
> >>> access_ok() check, so we don't need the extra access_ok() check above.
> >>> Also, you should move import_ubuf() to be the first invocation within
> >>> this API.
> >>
> >> My apologies, I re-added import_ubuf() during testing to debug an issue =
and
> >
> > I suppose you intended to mention access_ok() here, BTW, no worries :).
>
> Re-running xtest after removing the access_ok() I have a crash in
> regression_5006.3 Allocate_out_of_memory
>
> [   89.258100] ------------[ cut here ]------------
> [   89.258377] WARNING: CPU: 1 PID: 134 at mm/page_alloc.c:4402
> __alloc_pages+0x674/0xd14
> [   89.258988] Modules linked in:
> [   89.259554] CPU: 1 PID: 134 Comm: xtest Not tainted 6.6.0-g1ebcc18a80d7-=
dirty #69
> [   89.259763] Hardware name: linux,dummy-virt (DT)
> [   89.259977] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
> [   89.260143] pc : __alloc_pages+0x674/0xd14
> [   89.260252] lr : alloc_pages+0xac/0x160
> [   89.260364] sp : ffff8000803f3a30
> [   89.260437] x29: ffff8000803f3a30 x28: ffff8000803f3d70 x27: 00000000000=
00000
> [   89.260705] x26: 000000000000000b x25: 0000000000000000 x24: ffff0000001=
78000
> [   89.260847] x23: ffff00003f52b720 x22: ffff000001442720 x21: 00000000000=
00000
> [   89.261022] x20: 000000000000000b x19: 0000000000000000 x18: ffff8000803=
f3b78
> [   89.261162] x17: 0000000000000000 x16: ffffa7a428b67660 x15: 0000ffff63f=
fffff
> [   89.261348] x14: 0000000000000008 x13: 1fffe00000a4c421 x12: ffff8000803=
f3b78
> [   89.261528] x11: ffff000005262100 x10: ffff000005262108 x9 : ffff0000052=
6210c
> [   89.261739] x8 : 0000aaab0a97c000 x7 : 0000aaab0a90e000 x6 : ffff0000052=
62150
> [   89.261920] x5 : 0000000000000000 x4 : ffff000000976740 x3 : 00000000000=
00000
> [   89.262098] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffa7a429d=
af000
> [   89.262340] Call trace:
> [   89.262921]  __alloc_pages+0x674/0xd14
> [   89.263262]  alloc_pages+0xac/0x160
> [   89.263373]  alloc_pages_exact+0x48/0x94
> [   89.263464]  optee_shm_register+0xa8/0x1f4
> [   89.263591]  register_shm_helper+0x1bc/0x28c
> [   89.263687]  tee_shm_register_user_buf+0xb8/0x128
> [   89.263816]  tee_ioctl+0xbc/0xfa0
> [   89.263915]  __arm64_sys_ioctl+0xa8/0xec
> [   89.264053]  invoke_syscall+0x48/0x114
> [   89.264173]  el0_svc_common.constprop.0+0x40/0xe8
> [   89.264321]  do_el0_svc+0x20/0x2c
> [   89.264488]  el0_svc+0x40/0xf4
> [   89.264578]  el0t_64_sync_handler+0x13c/0x158
> [   89.264714]  el0t_64_sync+0x190/0x194
> [   89.265003] ---[ end trace 0000000000000000 ]---
>
>
> The issue is that, in import_ubuf(), it updates the length [1], making the
>
> access_ok() succeed and leading to an issue later in the page allocation pr=
ocess.
>
> To fix, I propose to add a test in tee_shm_register_user_buf() after calling
>
> import_ubuf()
>
>         if (length !=3D iter_iov_len(&iter))
>                 return ERR_PTR(-EFAULT);
>
>
> Would it be ok for you ? I'm afraid of side effects if I update import_ubuf=
()...

IMO, access_ok() should be the first thing that import_ubuf() or
import_single_range() should do, something as follows:

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8ff6824a1005..4aee0371824c 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);

 int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
 {
-       if (len > MAX_RW_COUNT)
-               len =3D MAX_RW_COUNT;
        if (unlikely(!access_ok(buf, len)))
                return -EFAULT;
+       if (len > MAX_RW_COUNT)
+               len =3D MAX_RW_COUNT;

        iov_iter_ubuf(i, rw, buf, len);
        return 0;

Jens A., Al Viro,

Was there any particular reason which I am unaware of to perform
access_ok() check on modified input length?

-Sumit

>
> [1] https://elixir.bootlin.com/linux/latest/source/lib/iov_iter.c#L1553
>

--===============5523356071186537043==--

