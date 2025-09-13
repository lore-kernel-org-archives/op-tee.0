Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48749CAC587
	for <op-tee@archiver.kernel.org>; Sat, 13 Sep 2025 06:07:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 889CE4182B
	for <op-tee@archiver.kernel.org>; Sat, 13 Sep 2025 06:07:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hE4JRMVG;
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 673B140ACC
	for <op-tee@lists.trustedfirmware.org>; Sat, 13 Sep 2025 06:06:54 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-60296e4926eso1396923d50.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 23:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757743614; x=1758348414; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j3DloXtBXCiPNPZKuwJVMOHp22SjYajZ2gkxD7ZsEvY=;
        b=hE4JRMVGUMQZoNqr35kfSdfHLhBNPuK/2/yvSguOTfrco3bosxecdIzlJimjRGCcXg
         uJKd6793yyGDEIcD40CbUkd0+HEeGrKKc/uIXX4Vb/1pxe2k8bz38yl5/qF04RTkMMiI
         wRuUUxbTZeH+v5wbD6pEC/968k2pR6oQ5n1MgwAJsg1W1KtgLJ7wNCLh1fkwoftd1giI
         vhxtRN8O/NhtBG0V5KiOdEocaZqgHGwlu8zAZUvEW7jou6kmjffZK8bPI1lj9M0qZMfF
         2fvbtwigCoU4ne5K3UTakCjdY+GIOvXlDUGi9GDxTMAdzYBmkiE6jCWsQ6N0Ah53u3Uv
         FRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757743614; x=1758348414;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j3DloXtBXCiPNPZKuwJVMOHp22SjYajZ2gkxD7ZsEvY=;
        b=QUZelwN61Pk4BPQl/7MfUvItoYfnHJVJxRBD4wg34DU6UdAYXq6FIQWfOZqrttLQ8o
         6T/RElMGvpUy2qDAqwqi7AVFlttxc0v5cRDo/2V02VgxEWAqtlGgGI7s/0O8Nzy/tuBT
         +ion1t1uVGbzrO7N3Vri3FHxKK1kJtCqlIfs+2a8RyYyF9qF5dozr4BYmQrOP6SxBJDM
         3rZ8imRd9aizMluPLmq+FcoGkwKhyd+ib9dtbDfaGhwd8VgSi9ZtQJqhTIcmEgMQhIdV
         NTqj9BjZT+6tmvzUQWj0WyEgGlQQtqtBiHbf9hebcXdIwY6ZyoVQUDjH3Lb32SMMPDso
         B12A==
X-Gm-Message-State: AOJu0YyiM36y/40pl/EO3lgaK3EXRQLUb+NKhETlE7kt90ZS0xUNYFjQ
	RNJTQAo+5KlNEw4bpMDLQwHr/uO4+lrldlCWvbJtQLUZoK2oxKQVfpL7UBdQtu1JpCvdzQX4WlA
	ryXBETIdJK1sY9ikLD56qinizqSLFQOuK44zlrVk=
X-Gm-Gg: ASbGnctFfFd9FoAHWZnvt4xPTcEt6DpMWZclw8RstD3oJrKjfgBMBtXJkU5+FNaLEy+
	T9wvxcci/iq+zW+zimbLKMNBQ/e7DRlu0CFcDIVpG5DCKvlMO5ovwoLQ0y1/m0mcpcofP6+TyPT
	wr+a+R8pSZGSxb9GG/ppA1+XfV6wBjHaCqcOyQut+biLozjStqnM1DwM+/r0gXVNlIZNqOXlvlq
	Bzdm1RzHPhYFhwS/A==
X-Google-Smtp-Source: AGHT+IGKpIERV4QP0xyACjs6k8sJU+pmkxEhqDYhpW3AdMkoQi3uIsyjujSlIhEg7aQ5M2Bq5cZ9kC7qbXhoaOcMG5w=
X-Received: by 2002:a53:b4c3:0:b0:62b:c97a:502e with SMTP id
 956f58d0204a3-62bc97a5aaamr821980d50.11.1757743613547; Fri, 12 Sep 2025
 23:06:53 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami256@gmail.com>
Date: Sat, 13 Sep 2025 15:06:42 +0900
X-Gm-Features: AS18NWDUKfK5nKrFpeFS-4HKsEA1y3ubomJSoJTXYf4BNHilPUWMvzTo1lvBWww
Message-ID: <CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com>
Subject: [BUG] tee_shm: NULL pointer dereference in unpin_user_pages() on
 invalid shm pages
To: op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 673B140ACC
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	RBL_VIRUSFREE_BOTNET(2.00)[74.125.224.50:from];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.679];
	R_SPF_ALLOW(0.00)[+ip4:74.125.0.0/16];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.224.50:from];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:74.125.0.0/16, country:US];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: IE4UTIKLYYMVEQB5I3IQ5CGYG5M5JI33
X-Message-ID-Hash: IE4UTIKLYYMVEQB5I3IQ5CGYG5M5JI33
X-MailFrom: masami256@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IE4UTIKLYYMVEQB5I3IQ5CGYG5M5JI33/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi.

While doing my fuzzing work, I found the following kernel crash by
NULL pointer dereference in Linux 6.17-rc5.

[   16.143987] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000008
[   16.144141] Mem abort info:
[   16.144215]   ESR = 0x0000000096000004
[   16.144246]   EC = 0x25
** replaying previous printk message **
[   16.144246]   EC = 0x25: DABT (current EL), IL = 32 bits
[   16.144271]   SET = 0, FnV = 0
[   16.144289]   EA = 0, S1PTW = 0
[   16.144308]   FSC = 0x04: level 0 translation fault
[   16.144325] Data abort info:
[   16.144335]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[   16.144346]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   16.144358]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   16.144412] user pgtable: 4k pages, 52-bit VAs, pgdp=0000000048b34b00
[   16.144432] [0000000000000008] pgd=0800000040bb3403, p4d=0000000000000000
[   16.144876] Internal error: Oops: 0000000096000004 [#1]  SMP
[   16.146429] Modules linked in:
[   16.146775] CPU: 0 UID: 0 PID: 148 Comm: xtest Not tainted
6.17.0-rc5 #58 PREEMPT
[   16.146995] Hardware name: linux,dummy-virt (DT)
[   16.147181] pstate: 21402005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   16.147330] pc : unpin_user_pages+0x78/0xd0
[   16.147763] lr : unpin_user_pages+0xa0/0xd0
[   16.147842] sp : ffff800084403d20
[   16.147912] x29: ffff800084403d20 x28: fff00000054aa300 x27: 0000000000000000
[   16.148089] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[   16.148235] x23: fff00000004fb5a8 x22: 0000000000000001 x21: 000000000000000d
[   16.148401] x20: fff0000000b2f9c0 x19: 0000000000000011 x18: 0000000000000001
[   16.148544] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   16.148659] x14: 0000000000000002 x13: 0000000000000002 x12: 0000000000037d0f
[   16.148786] x11: fff0000001dad708 x10: 000000000000003f x9 : 0000000000000d1b
[   16.148925] x8 : 00000000000007e0 x7 : 0000000000000001 x6 : 000000000000000d
[   16.149039] x5 : ffffffffffffffff x4 : ffffffffffffffff x3 : 000000000000000e
[   16.149167] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffc1ffc0fd68c0
[   16.149351] Call trace:
[   16.149520]  unpin_user_pages+0x78/0xd0 (P)
[   16.149684]  tee_shm_put+0x134/0x184
[   16.149783]  tee_shm_fop_release+0x14/0x24
[   16.149866]  __fput+0xcc/0x2dc
[   16.149925]  fput_close_sync+0x40/0x108
[   16.149991]  __arm64_sys_close+0x38/0x7c
[   16.150058]  invoke_syscall+0x48/0x110
[   16.150127]  el0_svc_common.constprop.0+0x40/0xe8
[   16.150227]  do_el0_svc+0x20/0x2c
[   16.150303]  el0_svc+0x34/0xf0
[   16.150369]  el0t_64_sync_handler+0xa0/0xe4
[   16.150439]  el0t_64_sync+0x198/0x19c
[   16.150629] Code: aa0203e3 eb02027f 54000109 f8627a82 (f9400444)
[   16.150940] ---[ end trace 0000000000000000 ]---
[   16.151230] Kernel panic - not syncing: Oops: Fatal exception
[   16.151466] SMP: stopping secondary CPUs
[   16.151838] Kernel Offset: disabled
[   16.151911] CPU features: 0x000000,0000d180,2bbe33e1,957e7f3f
[   16.152019] Memory Limit: none
[   16.152284] ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

decode_stacktrace.sh shows the following call sequence.

[   20.554057] unpin_user_pages (./include/linux/page-flags.h:284
mm/gup.c:259 mm/gup.c:420 mm/gup.c:400) (P)
[   20.554204] tee_shm_put (drivers/tee/tee_shm.c:42
drivers/tee/tee_shm.c:57 drivers/tee/tee_shm.c:587)
[   20.554291] tee_shm_fop_release (drivers/tee/tee_shm.c:437)
[   20.554366] __fput (fs/file_table.c:469)
[   20.554429] fput_close_sync (fs/file_table.c:574)
[   20.554496] __arm64_sys_close (fs/open.c:1590 fs/open.c:1572 fs/open.c:1572)
[   20.554565] invoke_syscall (./arch/arm64/include/asm/current.h:19
arch/arm64/kernel/syscall.c:54)
[   20.554639] el0_svc_common.constprop.0
(./include/linux/thread_info.h:135 arch/arm64/kernel/syscall.c:140)
[   20.554719] do_el0_svc (arch/arm64/kernel/syscall.c:152)
[   20.554782] el0_svc (./arch/arm64/include/asm/irqflags.h:55
./arch/arm64/include/asm/irqflags.h:76
arch/arm64/kernel/entry-common.c:169
arch/arm64/kernel/entry-common.c:182
arch/arm64/kernel/entry-common.c:880)
[   20.554842] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
[   20.554914] el0t_64_sync (arch/arm64/kernel/entry.S:596)

I set up a test environment using  qemu_v8.xml in the OP-TEE/manifest
repository.

## Test case

This test is based on xtest_tee_test_1004 included in xtest in the
optee_test repository. For fuzzing, the following data is created
using xtest_crypto_test().
It creates parameters like this.

op.params[0].tmpref.buffer = crypt_in;   // crypt_in =
malloc(sizeof(uint8_t) * 0xff);
op.params[0].tmpref.size = input_len;    // 0xffff
op.params[1].tmpref.buffer = crypt_out;  // crypt_out =
malloc(sizeof(uint8_t) * 0xff);
op.params[1].tmpref.size = input_len;    // 0xffff

When TEEC_InvokeCommand() in libteec was called with above parameters,
it printed folloing errorr then, linux kernel was crashed.

ERR [152] LT:TEEC_InvokeCommand:730: TEE_IOC_INVOKE failed

## Crash scenario

1. modified version of xtest_crypto_test() creates parameters.
2. xtest_crypto_test() calls TEEC_InvokeCommand() in the libteec.
3. TEEC_InvokeCommand calls ioctl(2).
4. tee_ioctl_invoke() in the tee_core.c is called by ioctl(2).
5. tee_ioctl_invoke() calles params_from_user().
6. In the params_from_user(), it returned -EINVAL because of following
if condition was true.
        if ((ip.a + ip.b) < ip.a ||
            (ip.a + ip.b) > shm->size) {
                tee_shm_put(shm);
                return -EINVAL;
        }

7. tee_ioctl_invoke() recive an error from params_from_user() so that
it run clean up process(in the out label).
8. tee_ioctl_invoke() returns -EINVAL.
9. TEEC_InvokeCommand() prints an error log then calls
teec_free_temp_refs() in libteec.
10. teec_free_temp_refs() calls TEEC_ReleaseSharedMemory().
11. TEEC_ReleaseSharedMemory() calls close(2).
12. tee_shm_put() in the tee_shm.c is called.
13. tee_shm_put() calls tee_shm_release().
14. tee_shm_release() calls release_registered_pages().
15. release_registered_pages() calls unpin_user_pages().
16. Null pointer dereference is happened in unpin_user_pages().

## Debugging

I added following debug logs in the tee_shm_release()

        } else if (shm->flags & TEE_SHM_DYNAMIC) {
                int rc = teedev->desc->ops->shm_unregister(shm->ctx, shm);
                size_t i;
                if (rc)
                        dev_err(teedev->dev.parent,
                                "unregister shm %p failed: %d", shm, rc);

                pr_info("%s:%d: shm->num_pages: 0x%lx, shm->size:
0x%lx\n", __func__, __LINE__, shm->num_pages, shm->size);
                for (i = 0; i < shm->num_pages; i++) {
                        if (!shm->pages[i]) {
                                pr_info("%s:%d: shm->pages[%ld] is
NULL", __func__, __LINE__, i);
                        }
                }
                release_registered_pages(shm);
        }

It showed the following logs.
[   21.350894] tee_shm_release:57: shm->num_pages: 0x11, shm->size: 0xd690
[   21.350977] tee_shm_release:60: shm->pages[14] is NULL
[   21.351003] tee_shm_release:60: shm->pages[15] is NULL
[   21.351012] tee_shm_release:60: shm->pages[16] is NULL

According to the above logs, shm->num_pages is 17 but the pages array
contains NULL pointers so that it causes a NULL pointer dereference
bug.

I have confirmed that I can prevent NULL pointer dereference by making
the following changes.

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 2a7d253d9c55..c5d39a0efbdb 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -34,9 +34,16 @@ static void shm_get_kernel_pages(struct page
**pages, size_t page_count)
 static void release_registered_pages(struct tee_shm *shm)
 {
        if (shm->pages) {
-               if (shm->flags & TEE_SHM_USER_MAPPED)
-                       unpin_user_pages(shm->pages, shm->num_pages);
-               else
+               if (shm->flags & TEE_SHM_USER_MAPPED) {
+                       size_t num_pages = 0;
+                       size_t i;
+                       for (i = 0; i < shm->num_pages; i++, num_pages++) {
+                               if (!shm->pages[i])
+                                       break;
+                       }
+
+                       unpin_user_pages(shm->pages, num_pages);
+               } else
                        shm_put_kernel_pages(shm->pages, shm->num_pages);

                kfree(shm->pages);


Regards,

-- 
Masami Ichikawa
