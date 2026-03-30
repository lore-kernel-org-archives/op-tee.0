Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52172FB3CE6
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 09:17:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7DFDA44394
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 09:17:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PIcYNmT1;
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2E69E43A6B
	for <op-tee@lists.trustedfirmware.org>; Mon, 30 Mar 2026 09:17:11 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-41708f6c3feso2699287fac.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 30 Mar 2026 02:17:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774862230; cv=none;
        d=google.com; s=arc-20240605;
        b=NdD+Tv7QONTYh8OVuui+QEp1svHqpoO0Ppc/VudYEc6L9NU0Xfvf8xgpf5Q9f1Cb+n
         iHV2zXU2nmpzvoQqGWYsFSa0hHk3cu6RvWq0v6LW/DnNJ1EQKfkXrZ1NpG8HvfJTMKMC
         wcheJQ3ZsiUHkDaH7uGtX6yrbqEMkZ5RQqrDaygNLuI4lVIbVQ7Hnl1qKCNzn4gH7M8x
         WUOIRmIIXJrSfwEKoo8K6Ea7ELWinE3yb8rKTN61PUqTX/ZZOAB+WXF/jqLukzRV8i5o
         jAYTvKCiOqShsKEYC8oEUO3omnEzih1kHAJoL6u0h6j430eV8hGLlPXeDr9dpC45HQj9
         lGWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDetAEnj9KKrVpUlio5tTKAjcgI5A3fMq4rOkYIkEh4=;
        fh=OBzMKnEkn+k+4sSd50BZtFVUSvX6V8cj+dRnvTATRTw=;
        b=IyM6MPxJT6KdXsUn2x/LbFT3MjLQiLS2Amqi/E0mWUXR3cUvygdRD3fBcZJBVY7UnY
         LgnWWH/yAtc5l7usbLxpXFvrqJ0nY8I4oD4O7ttz2okaST6mtQZiVl6yRVKns18F0rDP
         au6j6we2UhEoik3klAVCs8tfZ6h/2KMB/rGBQuEwjDSuS4vqPnR327peDe/CH8C4iS4W
         4QL9c+hDJFvbS2/LgixNSk8YA63BQom21qXE/tXG7OHyyWieWnJbpqNVVFGCamYpkTd/
         aY1i6tCP0Jore13Jm0KBbUjLDq6Bkd2YTDcqVkDVpWGuvIUPdYkVud7deX0X8n9/Pn78
         N49w==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774862230; x=1775467030; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDetAEnj9KKrVpUlio5tTKAjcgI5A3fMq4rOkYIkEh4=;
        b=PIcYNmT15gMJVPYbDhElE6LfOY5x2w80rzSsq1gTRPdP4PqyJCd62fdhdSfftgP69K
         oza1Fg/NtI7lKSC+N7+Rpwt99EyeDi30IiCfrbDYJ0XZcKUOMg2mQW2bIOxKVB6uHvst
         2YS2dnAS2e5YPDps0N0a/L4Fw9xvwcfWrPu2u8dUWqkfQmy5hCwpl4CxbOcbIWskSotj
         pfu+M8LZFmlIfwx0tx+PqDtILsJWlbiqAGqbKmMQbeVh/oKWPPeCPDZoMrrOw/6ehnYU
         cIFHsRW2GpjD4UVwTL4paHfXCOsdOQV1DaFBpSePiE++mBiVDkt4e2U425/Nu5mK+I8v
         WseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774862230; x=1775467030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDetAEnj9KKrVpUlio5tTKAjcgI5A3fMq4rOkYIkEh4=;
        b=QFfLoW5ZQj1g36bM0uPsMq9KvILY+lYe1IyancFIRKz4w/ErXLiolFdDVB46I9LXPi
         O95y20UZPxI2gfFWjkpQ2LL3BUrv3eG4frTueflyjnNvcoQ+zyOxDi12FF1ffzIRil66
         SG6brO5o/XqAlZYkAPVxo5TJTWsvgPKrpo37Cd8vJbnQZgGzo6SzoXTiuboZedQke3Iy
         TTChlaBTU+xAM904y/ofu5Tt/1thntQybJTc4ze9YnfEEF9nIrgkvF2ZzGjyu4gWF2Oj
         gFSrwnCCjyU1nTOdfoYaw3RNJGdJCFfm17wPfC9C0Nw1fu2pG0aH0hVqvSx7DcD2ll23
         5xDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNgCTSgiwErJHW90USLN+U2CF2cEumMGsGycMlvl/9VgGcO8bCFQEsGxO0jwTBdXj8x8Pp9UU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzZL/dWn9Q3UCn7l4v7OhLE/+5J9v2mFybUyI6sWaBkyiy6ke6R
	ZYZp3yTRxqGR+UyzdV32fMQTHGi9gNqFSzloz4IpnsIwLA7tLXi4UXp7xupRjNwISeDMYFHJlJE
	SnjXUembci5w8M0nsVogY7Zi0CpPeyIWw+oR+akf/zG9l
X-Gm-Gg: ATEYQzxzQgvqtoWK6ytqqUSafKqI0xEc8wrRZleo0gFIKJdUZzkDgDoU5m0Qhpvchr5
	keSTky5J67B90qDowEGTbUG3bEx3LTjgdsZHTZJn0SWT5djFsxUL7J7TY/Y07m5+AfU84bC3b7/
	KjUH4PA4HMbG9gvDN5MjXvR3AnFkrLup1+22bom1k3zG/8Ra6qwwn+FboSU6+IIUt8HnpqflC6+
	npmwK2rKiCApAkcIGbFxhac/ELQwd5A4YXYPjMHEuqjNZQ4+LqDP3XuWx6UfrTUBmm7AP9PUinj
	B8RWVwTKa6KpQuC2XsSNeMZfN6i4uxTmyfBObQ==
X-Received: by 2002:a05:6870:6486:b0:417:ab68:fbad with SMTP id
 586e51a60fabf-41cec34690amr5786836fac.27.1774862230393; Mon, 30 Mar 2026
 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <d9bb3b058dcd0425b18c77120dae225506b079e2.camel@mediatek.com>
 <acZVg6GQQT17r0OG@sumit-xelite> <0c8f7f5d4736287c36df973c593b7706fd36220b.camel@mediatek.com>
In-Reply-To: <0c8f7f5d4736287c36df973c593b7706fd36220b.camel@mediatek.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 30 Mar 2026 11:16:59 +0200
X-Gm-Features: AQROBzCthc_mp84gAV4mNQ6akqV-RGRzCaIhxDUuEhBedqxLJcTQ10fFJwE_C5o
Message-ID: <CAHUa44EcGEoBcx2J4dOJOSNjE7E9=qCivdfJtFzgrHmqKKB8Fg@mail.gmail.com>
Subject: Re: Possible race during OP-TEE kernel module device probing
To: =?UTF-8?B?U2hmIENoZW4gKOmZs+WwkeeUqyk=?= <Shf.Chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.47:from];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.47:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2E69E43A6B
X-Spamd-Bar: ----
Message-ID-Hash: CNSFOZQIJH4ZP3VC7XL5TLVNW5PJIKJZ
X-Message-ID-Hash: CNSFOZQIJH4ZP3VC7XL5TLVNW5PJIKJZ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "sumit.garg@kernel.org" <sumit.garg@kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CNSFOZQIJH4ZP3VC7XL5TLVNW5PJIKJZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Mar 30, 2026 at 6:07=E2=80=AFAM Shf Chen (=E9=99=B3=E5=B0=91=E7=94=
=AB) via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> On Fri, 2026-03-27 at 15:31 +0530, Sumit Garg wrote:
> > On Fri, Mar 27, 2026 at 09:01:15AM +0000, Shf Chen (=E9=99=B3=E5=B0=91=
=E7=94=AB) via OP-TEE wrote:
> > > Hi,
> > >
> > > We found a possible race condition issue during OP-TEE kernel driver =
probing the device.
> > > A NULL pointer dereference exception can happen when another kernel d=
river open OP-TEE context
> > > with tee_client_open_context() then do a SMC call to OP-TEE.
> > > Below is the exception:
> >
> > How is your kernel driver being probed? Have you registered it as a
> > proper TEE bus driver? Any custom ways to invoke TEE kernel client APIs
> > are surely susceptible to races like the one you mentioned below.
> >
> > -Sumit
>
> Hi,
>
> Our kernel driver does not registered as a TEE bus driver for some reason=
s,
> and we need to use other API to ensure the OP-TEE driver is probed to
> workaround this issue. But, we think this is error-prone for module devel=
oper
> that need to call to OP-TEE.
>
> Although this is not the case, I think that after calling tee_device_regi=
ster(),
> the optee device is shown under `/dev/` filesystem. There is a very small=
 chance
> for userspace program to trigger this race condition, and they don't have=
 clue on
> whether the device is properly being probed yet.

I think you're on to something. After calling tee_device_register(),
the driver must be able to handle requests, at least without crashing.
optee_enumerate_devices() requires the devices to be registered, so
that must happen after those calls. But other than that, I think the
calls to  tee_device_register() should be the last thing in the probe
function.

Sumit, do you agree?

Cheers,
Jens

>
> Best regards,
> Shao-Fu Chen
>
> >
> > >
> > > Unable to handle kernel NULL pointer dereference at virtual address 0=
000000000000000
> > > Mem abort info:
> > >   ESR =3D 0x0000000096000005
> > >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >   SET =3D 0, FnV =3D 0
> > >   EA =3D 0, S1PTW =3D 0
> > >   FSC =3D 0x05: level 1 translation fault
> > > Data abort info:
> > >   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > >   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > >   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > > user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000001026bb000
> > > [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000000, pu=
d=3D0000000000000000
> > > Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
> > > Workqueue: events_unbound deferred_probe_work_func
> > > pstate: 03400005 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
> > > pc : optee_cq_wait_init+0x78/0x124 [optee]
> > > lr : optee_cq_wait_init+0x60/0x124 [optee]
> > > sp : ffffffc081fcb7f0
> > > x29: ffffffc081fcb7f0 x28: 0000000000000000 x27: 0000000000001000
> > > x26: ffffff8080e42c60 x25: ffffff8084d46040 x24: 0000000000000000
> > > x23: 0000000000000000 x22: ffffffc081fcb8c0 x21: ffffffc081fcb8a8
> > > x20: 0000000000000000 x19: ffffff8082741570 x18: ffffffe572f8ca00
> > > x17: 00000000fa28650f x16: 00000000fa28650f x15: ffffff8084d47000
> > > x14: 0000000000000000 x13: 0000000000000000 x12: 0000000084d47000
> > > x11: 0000000000000000 x10: 0000000032000012 x9 : 04d4600000000001
> > > x8 : ffffffc081fcb8c8 x7 : 0000000000000000 x6 : 000000000000003f
> > > x5 : ffffff83c86649e0 x4 : 0000000000000008 x3 : 0000000000000000
> > > x2 : ffffff80827415a0 x1 : 0000000000000000 x0 : ffffffc081fcb8c0
> > > Call trace:
> > >  optee_cq_wait_init+0x78/0x124 [optee f6dbc35f8d96acbe1f3c329d7201815=
1d796208d]
> > >  optee_smc_do_call_with_arg+0x12c/0x95c [optee f6dbc35f8d96acbe1f3c32=
9d72018151d796208d]
> > >  optee_shm_register+0x284/0x360 [optee f6dbc35f8d96acbe1f3c329d720181=
51d796208d]
> > >  register_shm_helper+0x1a4/0x2f4 [tee cdd8a0d077d984bda1f31f9e8903836=
edbe46603]
> > >  tee_shm_register_kernel_buf+0x60/0x90 [tee cdd8a0d077d984bda1f31f9e8=
903836edbe46603]
> > >  cmdq_sec_allocate_wsm+0x58/0xc4 [mtk_cmdq_sec_mbox ac82dc958e32252a2=
1c6ce55bb8839ebb288387a]
> > >  cmdq_sec_probe+0x80/0x4a0 [mtk_cmdq_sec_mbox ac82dc958e32252a21c6ce5=
5bb8839ebb288387a]
> > >
> > > We found the optee->call_queue hasn't been initialized when our drive=
r called OP-TEE,
> > > and it might have some issues about the device data structure initial=
ize order in
> > > optee_probe()[drivers/tee/optee/smc_abi.c]:
> > >
> > > ---
> > > rc =3D tee_device_register(optee->teedev);  // <----- TEE device regi=
ster here
> > > if (rc)
> > >     goto err_unreg_supp_teedev;
> > >
> > > rc =3D tee_device_register(optee->supp_teedev);
> > > if (rc)
> > >     goto err_unreg_supp_teedev;
> > >
> > > optee_cq_init(&optee->call_queue, thread_count);  // <----- Some data=
 structures are initialized afterwards
> > > optee_supp_init(&optee->supp);
> > > optee->smc.memremaped_shm =3D memremaped_shm;
> > > optee->pool =3D pool;
> > > optee_shm_arg_cache_init(optee, arg_cache_flags);
> > > mutex_init(&optee->rpmb_dev_mutex);
> > > ---
> > >
> > > We want to ask if the data structure initialization should be done be=
fore the tee device registration?
> > >
> > > Best regards,
> > > Shao-Fu Chen
> > >
> > >
>
