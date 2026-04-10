Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74890F44852
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 13:01:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AF41644AB5
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 13:01:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DBxrJFpf;
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8F6C443B5B
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 13:01:22 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-682d981b025so1192641eaf.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 06:01:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775826082; cv=none;
        d=google.com; s=arc-20240605;
        b=iEu6Ta9Xay0tDE6g2DSwC8DIIwAh2aobEfFgJ1F/q0Irzg1HeussCNd3CqPNVF/vSf
         QrQ5v08SP9DfbAsQiyi9RrtoC81jAuZlMgMxZLRp+e2dONqSkrEewCA/S1n7eHVMrbqX
         W8PjPw3czdFD9qthVJk02HeagnRhfZEccQGJGDuxoeGvOLr63Mdg9O/jDFpuO/gjkwHd
         PESxNjOsiGDkO928qbpiZCrKkqMKApbXIAw6iPD6JoC2Aq7HiSsvw0buFUWxqljPsrF/
         z+cOuBvvtAebJgLnfMONlNCZ35nLK9VTmGtTU3l//H2E9Qp7mkgwTcdTKfeQa4iWhD79
         IxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QdNRUMGPWyRjmCzeFo+I8Ht4wVWV9IjHAG+RXOd9FQ8=;
        fh=Me1k7dFFJp8hMETkpqMaHzIN8ThW53GHPNzVp+0YN68=;
        b=E0Buayaf4dKe/TwmScBIJ/PKXYi0SqMhmBeuKCsWZCKhi8TH7kwEGpt4db3Da0wmQb
         b/KMpnTx+ixXvWFnSoD0+L41/kYDDXkDtR7blswFVMjaiHfw9Er5+Dml+lKypKn60wyw
         e3OuRYIjgSmmicAvcsQIRq+8NVLfQbRWKE6pAyO8eBhYJpvq9j5fyMjoE1CediPXgqKb
         sTyZ4W+PwN92EF9XuE0kqQBO6S/5yJsC/GWBvWSw4L8gLhlJfQATIUwWRcZZkbD4XXyB
         VBT7JYrUVsFeCxVHTEZ9Kt6Iws+1ZHkstkDdi/VMXaI4GPRYxko3+V9/+esZkSnL/4/o
         ZdZA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775826082; x=1776430882; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdNRUMGPWyRjmCzeFo+I8Ht4wVWV9IjHAG+RXOd9FQ8=;
        b=DBxrJFpfpWGbnJq6XeM+g2rphIS/59nTHDVfHANFkEUPU11coC29uqXfZ49dLLp5gh
         QCavXJWaqVMn1vsyKkXzK4m9tLW289Wy6cVvKeXvx/G+vbPzRWDpOXjMGE5eiZxVP4bt
         qOTiqyYofJ/3oNRw7rLMUMlGfTsrhELvwJCzIpmlXfAWViavbSQr9k1WhPdjT4tg3M99
         A2MRuplRYsefeSbIbD6YKXQlvut5FPyeghWxZidnlW5aFQq8ETKiDOb6D8wzuJN5U7rY
         ScyYtBCKvK8H8lkVB/vG9aDtbWrk45Zf2JhCl0/lLPmJVNJGl/p1h4Z3JnwjvZ0NxkCV
         B71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775826082; x=1776430882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdNRUMGPWyRjmCzeFo+I8Ht4wVWV9IjHAG+RXOd9FQ8=;
        b=mhKN+Fl4rAs3t9kVh/6aiJsQhqFABGgPRix1Ratf7Ah8ZiaJ4mXY7M0jZYAFds5yMR
         FkmIT1KKuSlawibVJ5hkA7r2m3w3WZnguXk/gWi4ZO76XTQt6UZkvqpjA1HlSetC/Dfp
         FdA+78305S0phXPLrOApi+3KjQ9XyAkKYvW00JXOlQYPbtYLM7Fp+nrRKdq6Bk+6oDCE
         9m9JLbXzVQlZK4MfiLI7wTZ8fr6GKgRY8WWdANEU0cMQgw8p04RENl947J4DA33/Lq6D
         iI+1HxuhwcPD6RsnVTSCideQPXvTeXdBeRX0HvjLFE53fMYmGcdlsvk5uvWMie5qcE+j
         Yovw==
X-Gm-Message-State: AOJu0YyjEkQux2OtbqlPrESdAscT+NEdRBXk+t5+Wh8EckTyAm+jNH6V
	3z9x0BYxLAexF0j/f44NozO1Bi9SbpCoTLFoQQL0EXfBRG+uF1ln8FG3+z7eaK2NRFAQbRCNNSo
	Td3BGgvKh45/8+V3bJXcJXMNSU5UvTWu1g7lqlE4h4mr6sYw0+w1NT0i4iQ==
X-Gm-Gg: AeBDiesu1X4FiRJO2L5fAUxx/O1LDFJwXOB4PyhO0jagnYEj1VWJ0tp9gIRxVx69Rnc
	DBFzjz7JDmRHFgtWcaOaH1oX5zPqicVQIiS6ZsFKcsnxFFgJ4Xz+VPLyKEQqLNGs+xtRAuR9tzF
	kmO84Fk3y9AW6o98BqqPQeXe75Q7ByFywT1xFte5sJYb3nDJns1BEOSoZT9FcnKpVa/bpZMZdjc
	yVWBKUdrWGzMTWuif8fj0tL1FRTfu4wdvI232YUcvKoSquhVUqGJYkPtQm2Z8FVfQl+JrWnwCnC
	MwJxntv5eCt4gZPPLRn3NIn8TR1kZkohE9c5DQ==
X-Received: by 2002:a05:6820:c8e:b0:67e:2905:83d2 with SMTP id
 006d021491bc7-68be6720a64mr1461595eaf.21.1775826081330; Fri, 10 Apr 2026
 06:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
 <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
 <4dfd2e07-4627-4682-a8f2-bc13eafa1fe9@siemens.com> <7a52b4ec-7e75-4332-b94c-726978a3a7b6@siemens.com>
 <30ddaa03-b2af-4c71-bd0e-b379cc4f2685@siemens.com> <4e9643cb-c41a-4242-ac1f-ab3a048f3a46@siemens.com>
In-Reply-To: <4e9643cb-c41a-4242-ac1f-ab3a048f3a46@siemens.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 10 Apr 2026 15:01:09 +0200
X-Gm-Features: AQROBzCuybIQ_zQy-2pQE0PQEj1t8XLMlEVOJp12_kZoJ6S-DwYBGXlCBVvbYhc
Message-ID: <CAHUa44EGG15Ekd4EvqGVoH49QNKkLVQav5aCSx0DBorebOmaOg@mail.gmail.com>
Subject: Re: PKCS#11 TA needs userland supplicant?
To: Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.45:from];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.45:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8F6C443B5B
X-Spamd-Bar: ----
Message-ID-Hash: RZP2XJJXK3ROQGRXKMQOYAF43JINOQIL
X-Message-ID-Hash: RZP2XJJXK3ROQGRXKMQOYAF43JINOQIL
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RZP2XJJXK3ROQGRXKMQOYAF43JINOQIL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Fri, Apr 10, 2026 at 11:27=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com=
> wrote:
>
> On 10.04.26 10:36, Jan Kiszka wrote:
> > On 10.04.26 09:59, Jan Kiszka wrote:
> >> On 10.04.26 07:45, Jan Kiszka wrote:
> >>> On 10.04.26 07:37, Jens Wiklander wrote:
> >>>> Hi,
> >>>>
> >>>> On Thu, Apr 9, 2026 at 7:41=E2=80=AFPM Jan Kiszka via OP-TEE
> >>>> <op-tee@lists.trustedfirmware.org> wrote:
> >>>>>
> >>>>> Hi all,
> >>>>>
> >>>>> to avoid that I'm debugging further this error I get during boot wi=
th
> >>>>> CONFIG_RPMB=3Dy in the kernel and CFG_IN_TREE_EARLY_TAS=3Dpkcs11/fd=
02c9da...:
> >>>>>
> >>>>> [    0.359372] mmcblk0boot0: mmc0:0001 QEMU!! 4.00 MiB
> >>>>> [    0.361779] mmcblk0boot1: mmc0:0001 QEMU!! 4.00 MiB
> >>>>> [    0.363761] mmcblk0rpmb: mmc0:0001 QEMU!! 2.00 MiB, chardev (248=
:0)
> >>>>> D/TC:? 0 tee_ta_init_session_with_context:569 Re-open trusted servi=
ce 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
> >>>>> D/TC:? 0 legacy_rpmb_init:1143 Trying legacy RPMB init
> >>>>
> >>>> The in-kernel routing didn't initialize as expected, so OP-TEE is
> >>>> falling back to the tee-supplicant based RPMB communication.
> >>>>
> >>>>
> >>>>> E/TC:? 0 get_rpc_alloc_res:646 RPC allocation failed. Non-secure wo=
rld result: ret=3D0xffff000c ret_origin=3D0x2
> >>>>> D/TC:? 0 tee_ta_invoke_command:830 Error: f0100003 of 4
> >>>>> D/TC:? 0 tee_ta_close_session:469 csess 0xc0210910 id 1
> >>>>> D/TC:? 0 tee_ta_close_session:488 Destroy session
> >>>>>
> >>>>> Is it possible at all to run the PKCS#11 TA without userland tee-
> >>>>> supplicant? I thought it only needs the supplicant for RPMB, thus s=
hould
> >>>>> be fine with the in-kernel routing (which is active), but maybe tha=
t is
> >>>>> not true.
> >>>>
> >>>> Yes, I think so. I haven't tried it myself, though. Anyway, the log
> >>>> tells that OP-TEE isn't using in-kernel routing. You can also check
> >>>> /sys/class/tee/teepriv0/rpmb_routing_model to see what the driver ha=
s
> >>>> negotiated.
> >>>>
> >>>
> >>> # cat /sys/class/tee/teepriv0/rpmb_routing_model
> >>> kernel
> >>>
> >>> And if I build optee as module and load it later, then call "pkcs1-to=
ol
> >>> --module /usr/lib/libckteec.so.0 -I", it also waits for userspace tee=
 here:
> >>>
> >>> ...
> >>> F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
> >>> F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
> >>> D/TC:? 0 legacy_rpmb_init:1143 Trying legacy RPMB init
> >>> I/TC: thread_rpc_alloc 0, arg->ret ffff0000
> >>> I/TC: get_rpc_alloc_res: bt 0 size 8192
> >>>
> >>
> >> I instrumented further, and I'm getting an OPTEE_RPC_CMD_SHM_ALLOC wit=
h
> >> OPTEE_RPC_SHM_TYPE_APPL, not OPTEE_RPC_SHM_TYPE_KERNEL - this is where
> >> things are failing or blocking.
> >>
> >
> > I think I'm getting closer: We have key-writing enabled for the QEMU
> > target (key is not persisted there yet), and that seems to enforce
> > legacy init all the time:
> >
> > https://github.com/OP-TEE/optee_os/blob/15bbaa331fb6d69466c4880a1af1e8e=
9580c95f1/core/tee/tee_rpmb_fs.c#L1248
> >
> > If I got it right, legacy_rpmb_init requires a userspace supplicant,
> > doesn't it?
> >

Yes

>
> Things start to make sense: The QEMU image we assemble in isar-cip-core
> [1] does the first RPMB access and the key writing already via U-Boot,
> and U-Boot's supplicant does not differentiate between the two
> RPC_SHM_TYPEs - how should it? So, RPMB initialization is already done
> when the kernel later on loads its optee driver and starts to communicate=
.

Yes, but I was expecting tee_rpmb_reinit() to be called from the
Device PTA when the kernel has discovered the RPMB device.
tee_rpmb_reinit() causes the RPMB driver in OP-TEE to restart probing
and should switch from the legacy setup.

>
> In the setup above, though, we do not have a U-Boot, we directly boot
> from TF-A into the Linux. And that seems to send us into the error /
> blocking on tee-supplicant from userspace.

Without a key programmed into RPMB?

>
> Can / should this be changed?

It sounds like the problem could be RPMB key programming. I'm testing
in-kernel RPMB routing where the key is already programmed for each
release.

We want to move away from OP-TEE programming the RPMB key, so a more
advanced combination with that seems the wrong direction.

Cheers,
Jens
