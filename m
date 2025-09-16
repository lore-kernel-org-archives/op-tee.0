Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A05CCAC599
	for <op-tee@archiver.kernel.org>; Tue, 16 Sep 2025 07:46:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B897240FAB
	for <op-tee@archiver.kernel.org>; Tue, 16 Sep 2025 07:46:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Lrl8xlcM;
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EF4B140AEB
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Sep 2025 07:46:30 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-43b40cc73f3so3092707b6e.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Sep 2025 00:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758008790; x=1758613590; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CieiNGRUIucJPuJNa10u9w3VBD5gga61IDYuzBIBRmE=;
        b=Lrl8xlcMqaB18zj8KiznwTIcCqMi8Xn5QLHXXcaphDMwpwo93XfrKrY34fX0sycMYk
         kxF+D4Lcw3bcp/NpEq1I/FQ+w0iqd85zYIbLrVystRGpn3fVZD+Q3r6gm0OoMZYNneQG
         xoFDNm9BS0M6N55mTrOI73P4YpkDoj9mP591w7u/58W9AyxJ3ngbGdmAvFIZZkZwODJx
         HvSarJLlx68q/kTsRay1bAeuoQ7RtActHKnA3UPIm3KFoxvITtem6Kl+/BYZLm88B5ue
         C0DklGe67h/8djir87GkqIG9LdPdnYFB6pHKNjlCkBG1GmSbHDGOtLhtBG1ipNcdnFQg
         n8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008790; x=1758613590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CieiNGRUIucJPuJNa10u9w3VBD5gga61IDYuzBIBRmE=;
        b=O9sukZ9DR/Q1qGQpxW2OzbaELUXYMl/WCO1wO1IXOx/KVpojwTVP2scmxMQ1vpm3Vx
         9yO/8UPBLoCS2DDleEMyYEHS58GneNhjdJ648eqdlgNUIl4AnZW45CHiZ/y7N/PTgEHV
         QdOWXdcpQPBnoMU6enqCJMeC77VEUnr8gepYKLEXLhPO5p2fJc9KxIBBARK5SdM7SQCn
         p1vxLrsE5P++3tKOlnJi5JAvJlU349k0SS7zC7mAjPhF0G/bZDpSAjQ+zn7PKEW1j4Ny
         PcyL6/iXxxWOOlxsFlnym3IV9plETND+XOgo5vIJS/xuXHNR9lq0jAvH1OCgIgWCVA/P
         PNfA==
X-Gm-Message-State: AOJu0Ywzs2N5cITdSjvzoTNR2OX2dcigsq/zvkVMAQvHxEzTlydBL2Ui
	VRgIB1Xu+ojcxWBmaSEoyQALIIrMM17JhKs5ZLe80gZOi4MvnuDx58MmIND9iprb12mO3ow6oZr
	/qNYDndfl9lDADx9CbHnwLPZP/1E+sniGFRm2UgTrOBzj
X-Gm-Gg: ASbGncuviYj5eT9hB8ZGz5tQBKW8IFUgWmSKy5f1AghXbpicfJYRkgdKNsncuuG87z9
	aWWISkPEEq4NgS0bdqrOsrx4jbfqoYZ6NXA5xoG2ig2QVMLijXbU5fz5K/C0yOzq5PbLzkFqxdj
	2FNRQl9nrKR6yUrR7OCtHXMS/0CCMkx2uOhq/JsrI3i/PVRFIMJrvjQ5lJE3f3xJdU2TzHt6p1d
	KMpBQ23
X-Google-Smtp-Source: AGHT+IESeNYQVZpHMKLK1F6/7+wPxrgOGsqmqku9M759nv4FLJJzc1Mj9Nj5FaVLm1ipVeQeRe2QMUdf7kGXRJb9cL4=
X-Received: by 2002:a05:6808:e8e:b0:438:37ee:345f with SMTP id
 5614622812f47-43d3f464bbbmr646826b6e.18.1758008790148; Tue, 16 Sep 2025
 00:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com>
In-Reply-To: <CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 16 Sep 2025 09:46:18 +0200
X-Gm-Features: AS18NWCYKJ_9XAL0MBBWXV0VMCetOZqCNo8xZIHkNMF3WCsIzZ2ioIkvvRCjpsg
Message-ID: <CAHUa44FmMj-=5cd4TNGS0ve6jryeCUWeYt=2Um4c_1St5wvL3A@mail.gmail.com>
Subject: Re: [BUG] tee_shm: NULL pointer dereference in unpin_user_pages() on
 invalid shm pages
To: Masami Ichikawa <masami256@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EF4B140AEB
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.177:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.177:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 7RXHZOYVEGGKJX3T6LWPYLX3TQZEYK6F
X-Message-ID-Hash: 7RXHZOYVEGGKJX3T6LWPYLX3TQZEYK6F
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7RXHZOYVEGGKJX3T6LWPYLX3TQZEYK6F/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Masami,

Thanks for the report. Does the problem also occur with earlier
versions of the kernel? I have more comments inline below.

On Sat, Sep 13, 2025 at 8:07=E2=80=AFAM Masami Ichikawa <masami256@gmail.co=
m> wrote:
>
> Hi.
>
> While doing my fuzzing work, I found the following kernel crash by
> NULL pointer dereference in Linux 6.17-rc5.
>
> [   16.143987] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000008
> [   16.144141] Mem abort info:
> [   16.144215]   ESR =3D 0x0000000096000004
> [   16.144246]   EC =3D 0x25
> ** replaying previous printk message **
> [   16.144246]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   16.144271]   SET =3D 0, FnV =3D 0
> [   16.144289]   EA =3D 0, S1PTW =3D 0
> [   16.144308]   FSC =3D 0x04: level 0 translation fault
> [   16.144325] Data abort info:
> [   16.144335]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> [   16.144346]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> [   16.144358]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> [   16.144412] user pgtable: 4k pages, 52-bit VAs, pgdp=3D0000000048b34b0=
0
> [   16.144432] [0000000000000008] pgd=3D0800000040bb3403, p4d=3D000000000=
0000000
> [   16.144876] Internal error: Oops: 0000000096000004 [#1]  SMP
> [   16.146429] Modules linked in:
> [   16.146775] CPU: 0 UID: 0 PID: 148 Comm: xtest Not tainted
> 6.17.0-rc5 #58 PREEMPT
> [   16.146995] Hardware name: linux,dummy-virt (DT)
> [   16.147181] pstate: 21402005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [   16.147330] pc : unpin_user_pages+0x78/0xd0
> [   16.147763] lr : unpin_user_pages+0xa0/0xd0
> [   16.147842] sp : ffff800084403d20
> [   16.147912] x29: ffff800084403d20 x28: fff00000054aa300 x27: 000000000=
0000000
> [   16.148089] x26: 0000000000000000 x25: 0000000000000000 x24: 000000000=
0000000
> [   16.148235] x23: fff00000004fb5a8 x22: 0000000000000001 x21: 000000000=
000000d
> [   16.148401] x20: fff0000000b2f9c0 x19: 0000000000000011 x18: 000000000=
0000001
> [   16.148544] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [   16.148659] x14: 0000000000000002 x13: 0000000000000002 x12: 000000000=
0037d0f
> [   16.148786] x11: fff0000001dad708 x10: 000000000000003f x9 : 000000000=
0000d1b
> [   16.148925] x8 : 00000000000007e0 x7 : 0000000000000001 x6 : 000000000=
000000d
> [   16.149039] x5 : ffffffffffffffff x4 : ffffffffffffffff x3 : 000000000=
000000e
> [   16.149167] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffc1ffc=
0fd68c0
> [   16.149351] Call trace:
> [   16.149520]  unpin_user_pages+0x78/0xd0 (P)
> [   16.149684]  tee_shm_put+0x134/0x184
> [   16.149783]  tee_shm_fop_release+0x14/0x24
> [   16.149866]  __fput+0xcc/0x2dc
> [   16.149925]  fput_close_sync+0x40/0x108
> [   16.149991]  __arm64_sys_close+0x38/0x7c
> [   16.150058]  invoke_syscall+0x48/0x110
> [   16.150127]  el0_svc_common.constprop.0+0x40/0xe8
> [   16.150227]  do_el0_svc+0x20/0x2c
> [   16.150303]  el0_svc+0x34/0xf0
> [   16.150369]  el0t_64_sync_handler+0xa0/0xe4
> [   16.150439]  el0t_64_sync+0x198/0x19c
> [   16.150629] Code: aa0203e3 eb02027f 54000109 f8627a82 (f9400444)
> [   16.150940] ---[ end trace 0000000000000000 ]---
> [   16.151230] Kernel panic - not syncing: Oops: Fatal exception
> [   16.151466] SMP: stopping secondary CPUs
> [   16.151838] Kernel Offset: disabled
> [   16.151911] CPU features: 0x000000,0000d180,2bbe33e1,957e7f3f
> [   16.152019] Memory Limit: none
> [   16.152284] ---[ end Kernel panic - not syncing: Oops: Fatal exception=
 ]---
>
> decode_stacktrace.sh shows the following call sequence.
>
> [   20.554057] unpin_user_pages (./include/linux/page-flags.h:284
> mm/gup.c:259 mm/gup.c:420 mm/gup.c:400) (P)
> [   20.554204] tee_shm_put (drivers/tee/tee_shm.c:42
> drivers/tee/tee_shm.c:57 drivers/tee/tee_shm.c:587)
> [   20.554291] tee_shm_fop_release (drivers/tee/tee_shm.c:437)
> [   20.554366] __fput (fs/file_table.c:469)
> [   20.554429] fput_close_sync (fs/file_table.c:574)
> [   20.554496] __arm64_sys_close (fs/open.c:1590 fs/open.c:1572 fs/open.c=
:1572)
> [   20.554565] invoke_syscall (./arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:54)
> [   20.554639] el0_svc_common.constprop.0
> (./include/linux/thread_info.h:135 arch/arm64/kernel/syscall.c:140)
> [   20.554719] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> [   20.554782] el0_svc (./arch/arm64/include/asm/irqflags.h:55
> ./arch/arm64/include/asm/irqflags.h:76
> arch/arm64/kernel/entry-common.c:169
> arch/arm64/kernel/entry-common.c:182
> arch/arm64/kernel/entry-common.c:880)
> [   20.554842] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899=
)
> [   20.554914] el0t_64_sync (arch/arm64/kernel/entry.S:596)
>
> I set up a test environment using  qemu_v8.xml in the OP-TEE/manifest
> repository.
>
> ## Test case
>
> This test is based on xtest_tee_test_1004 included in xtest in the
> optee_test repository. For fuzzing, the following data is created
> using xtest_crypto_test().
> It creates parameters like this.
>
> op.params[0].tmpref.buffer =3D crypt_in;   // crypt_in =3D
> malloc(sizeof(uint8_t) * 0xff);
> op.params[0].tmpref.size =3D input_len;    // 0xffff
> op.params[1].tmpref.buffer =3D crypt_out;  // crypt_out =3D
> malloc(sizeof(uint8_t) * 0xff);
> op.params[1].tmpref.size =3D input_len;    // 0xffff

So you have a small allocation and then report a larger one in
tmpref.size. This is an out-of-bounds reference. Memory might follow
the buffer, or it might be unmapped, depending on the state of the
heap. However, this alone isn't enough for param_from_user() to return
-EINVAL as described below.

I've tried making changes in teec_pre_process_tmpref() to so it can
trigger the condition in param_from_user() below. I think I succeeded
in that, but I'm unable to reproduce the crash.

Can you double-check to see if something is missing to reproduce the proble=
m?

>
> When TEEC_InvokeCommand() in libteec was called with above parameters,
> it printed folloing errorr then, linux kernel was crashed.
>
> ERR [152] LT:TEEC_InvokeCommand:730: TEE_IOC_INVOKE failed
>
> ## Crash scenario
>
> 1. modified version of xtest_crypto_test() creates parameters.
> 2. xtest_crypto_test() calls TEEC_InvokeCommand() in the libteec.
> 3. TEEC_InvokeCommand calls ioctl(2).
> 4. tee_ioctl_invoke() in the tee_core.c is called by ioctl(2).
> 5. tee_ioctl_invoke() calles params_from_user().
> 6. In the params_from_user(), it returned -EINVAL because of following
> if condition was true.
>         if ((ip.a + ip.b) < ip.a ||
>             (ip.a + ip.b) > shm->size) {
>                 tee_shm_put(shm);
>                 return -EINVAL;
>         }

The tee_shm_put() is supposed to balance with the earlier
tee_shm_get_from_id(), so this in itself should be OK.

>
> 7. tee_ioctl_invoke() recive an error from params_from_user() so that
> it run clean up process(in the out label).
> 8. tee_ioctl_invoke() returns -EINVAL.
> 9. TEEC_InvokeCommand() prints an error log then calls
> teec_free_temp_refs() in libteec.
> 10. teec_free_temp_refs() calls TEEC_ReleaseSharedMemory().
> 11. TEEC_ReleaseSharedMemory() calls close(2).
> 12. tee_shm_put() in the tee_shm.c is called.
> 13. tee_shm_put() calls tee_shm_release().
> 14. tee_shm_release() calls release_registered_pages().
> 15. release_registered_pages() calls unpin_user_pages().
> 16. Null pointer dereference is happened in unpin_user_pages().
>
> ## Debugging
>
> I added following debug logs in the tee_shm_release()
>
>         } else if (shm->flags & TEE_SHM_DYNAMIC) {
>                 int rc =3D teedev->desc->ops->shm_unregister(shm->ctx, sh=
m);
>                 size_t i;
>                 if (rc)
>                         dev_err(teedev->dev.parent,
>                                 "unregister shm %p failed: %d", shm, rc);
>
>                 pr_info("%s:%d: shm->num_pages: 0x%lx, shm->size:
> 0x%lx\n", __func__, __LINE__, shm->num_pages, shm->size);
>                 for (i =3D 0; i < shm->num_pages; i++) {
>                         if (!shm->pages[i]) {
>                                 pr_info("%s:%d: shm->pages[%ld] is
> NULL", __func__, __LINE__, i);
>                         }
>                 }
>                 release_registered_pages(shm);
>         }
>
> It showed the following logs.
> [   21.350894] tee_shm_release:57: shm->num_pages: 0x11, shm->size: 0xd69=
0
> [   21.350977] tee_shm_release:60: shm->pages[14] is NULL
> [   21.351003] tee_shm_release:60: shm->pages[15] is NULL
> [   21.351012] tee_shm_release:60: shm->pages[16] is NULL
>
> According to the above logs, shm->num_pages is 17 but the pages array
> contains NULL pointers so that it causes a NULL pointer dereference
> bug.

This doesn't make sense shm->size =3D=3D 0xd690 should require 14 or 15
pages, depending on shm->offset. The tee_shm is in an inconsistent
state, besides the fact that we have NULL pointers in shm->pages[].

>
> I have confirmed that I can prevent NULL pointer dereference by making
> the following changes.

The patch below works around the problem rather than fixing it. The
problem occurred earlier when the tee_shm became inconsistent.

Cheers,
Jens

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 2a7d253d9c55..c5d39a0efbdb 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -34,9 +34,16 @@ static void shm_get_kernel_pages(struct page
> **pages, size_t page_count)
>  static void release_registered_pages(struct tee_shm *shm)
>  {
>         if (shm->pages) {
> -               if (shm->flags & TEE_SHM_USER_MAPPED)
> -                       unpin_user_pages(shm->pages, shm->num_pages);
> -               else
> +               if (shm->flags & TEE_SHM_USER_MAPPED) {
> +                       size_t num_pages =3D 0;
> +                       size_t i;
> +                       for (i =3D 0; i < shm->num_pages; i++, num_pages+=
+) {
> +                               if (!shm->pages[i])
> +                                       break;
> +                       }
> +
> +                       unpin_user_pages(shm->pages, num_pages);
> +               } else
>                         shm_put_kernel_pages(shm->pages, shm->num_pages);
>
>                 kfree(shm->pages);
>
>
> Regards,
>
> --
> Masami Ichikawa
