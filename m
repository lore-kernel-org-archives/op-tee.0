Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26643C87FCF
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 12:25:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5667A465FE
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 12:25:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i84cR1kI;
	dkim-atps=neutral
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E05B942E15
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 Aug 2025 12:25:01 +0000 (UTC)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6199f850ca7so102503eaf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 04 Aug 2025 05:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754310301; x=1754915101; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UidEO3p/JExNkZNMYzF9DbeSLXATOoHJRr54KAZUFg=;
        b=i84cR1kIWP0zHt0mEU+OeJsykvHgZ8kSRRgWTS3hGc/N2ITOlyURdzM10VTy5oZ2+6
         TnuMy5d/SKIiIDhSk0NUt5cTyzyhTbs4tZnmIjyDW0rfsBNbPHLuqqKw3JGdWI10AMXT
         NzJTWdE1GNKBncDfqSRODuSxAOnFDScpTAZtegeNmjxYnNfBZtfOMcDniATQ+rNc9pir
         sVK+RqYBbxN8+NIRYfIRGZze3iwTnyja4BSnGiVDD/5OpISltbSqqZbdpMNbJGRsY+sU
         WrZvIZmrRpGGwg1rZZfTSInrCOJ+Lyy3WB3fBG4i/NzaIAEcGUEcauOH/ILVxjvsvEow
         k4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310301; x=1754915101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UidEO3p/JExNkZNMYzF9DbeSLXATOoHJRr54KAZUFg=;
        b=Q2oY8IcPOVWBgAXY6+yVo1DTRvvej6A5jjwswDsnpvSVnxQp4lwHdTIoOO/hPMn5G6
         S0PhGgpUhLFrs7yLCff1O2+4ytDhC3Y8eKWsugRPnzdNNq2IeNu/ePvPRluxIInsc+1x
         uLhLl1pkRIPoCzfHrwoOg5aY0rLEd1KbVQ9/lu9UptLU4tC2uWb0NBmVPd0lWY+goR/E
         7U9SN9lARLh8PkOSTlD7plIZ8TBSifRl2d8trzR4lvg0z074pSrl8mdUYz0LQJGNi8BN
         Mm8Bsb3z9XYM105aV9dnem8ErU908p4jN0CYzMdCRBDSV3z+Li6djUeXCTiS8elBgmdR
         JuuA==
X-Forwarded-Encrypted: i=1; AJvYcCVh9NdrmN0NNjhLlIvRa9uaEToHUJB7bZO+wHH8luQxRFFKQK3t7M45VDw8TZgdZISczO6cXCw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxJ8bRzlq026/yMWdqpUzSm3FXpwGJ4W7m0/0EqrbutNSBokizn
	0iUPxI3K9fTKC6960qVmOBzS2fa6+90LnrOLpC8T8JJBWtjnXHJcjc1UUlsV0WZWPQZWzqs+9Kg
	NpwTbx4gV2yzsA3e+YzBjiAC97LfbDgoTvKsDCQicD4Xo
X-Gm-Gg: ASbGncs/FmFEeQ79U/5iaUuHkcxpjZyk8FN9Q3geL78K2P6m4LklnjAHVUxDUFsYdWv
	eow+8tHMPYkB/ZSjO7K2vIaMcUTOPvqo+xEyRb3aj0fQ+IfMl+t5QZS8E5S8HV6dRKW1ZjPjSrw
	BkezMX/oSHtDvqRekBqI8OpAsSajn+vqybBXqCSF8AeCkByKG7RDgihxYt39RzlnCjzXH6w8DLA
	o0wq8wl
X-Google-Smtp-Source: AGHT+IEwI3DR1cEwvcgcyKde5qW3Qb7yD1S7YRbPQ8PZrFxcjbQGbcaX5K/LoDeEAYkbNEQmXbEvo9mg4UHsZCSbTls=
X-Received: by 2002:a05:6820:1e81:b0:619:ae98:ad06 with SMTP id
 006d021491bc7-619ae98afb6mr1974484eaf.5.1754310301171; Mon, 04 Aug 2025
 05:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <fabd3d7560119e52dd83f4a19ad1f8087862993f.1753236468.git.xiaopei01@kylinos.cn>
 <aIiTVdJib4DLgYnC@sumit-X1>
In-Reply-To: <aIiTVdJib4DLgYnC@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Aug 2025 14:24:49 +0200
X-Gm-Features: Ac12FXy0LIz3mNrzQl6ojyMPHYRczjOKU3Drs4kD05hFb2F7PMYVYOyqV-8GnDw
Message-ID: <CAHUa44GB8LF4iPR2tyy8HnVCwFYBXy+B2kLyf1g9GoCmsP8xsQ@mail.gmail.com>
Subject: Re: [PATCH] tee: fix NULL pointer dereference in tee_shm_put
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E05B942E15
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.45:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.45:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: EXNGYQMITI4N6DYPM7CTH626KTNPSOAQ
X-Message-ID-Hash: EXNGYQMITI4N6DYPM7CTH626KTNPSOAQ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Pei Xiao <xiaopei01@kylinos.cn>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EXNGYQMITI4N6DYPM7CTH626KTNPSOAQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Jul 29, 2025 at 11:24=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Wed, Jul 23, 2025 at 10:09:07AM +0800, Pei Xiao wrote:
> > tee_shm_put have NULL pointer dereference:
> >
> > __optee_disable_shm_cache -->
> >       shm =3D reg_pair_to_ptr(...);//shm maybe return NULL
> >         tee_shm_free(shm); -->
> >               tee_shm_put(shm);//crash
> >
> > Add check in tee_shm_put to fix it.
> >
> > panic log:
> > Unable to handle kernel paging request at virtual address 0000000000100=
cca
> > Mem abort info:
> > ESR =3D 0x0000000096000004
> > EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > SET =3D 0, FnV =3D 0
> > EA =3D 0, S1PTW =3D 0
> > FSC =3D 0x04: level 0 translation fault
> > Data abort info:
> > ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000002049d07000
> > [0000000000100cca] pgd=3D0000000000000000, p4d=3D0000000000000000
> > Internal error: Oops: 0000000096000004 [#1] SMP
> > CPU: 2 PID: 14442 Comm: systemd-sleep Tainted: P OE ------- ----
> > 6.6.0-39-generic #38
> > Source Version: 938b255f6cb8817c95b0dd5c8c2944acfce94b07
> > Hardware name: greatwall GW-001Y1A-FTH, BIOS Great Wall BIOS V3.0
> > 10/26/2022
> > pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : tee_shm_put+0x24/0x188
> > lr : tee_shm_free+0x14/0x28
> > sp : ffff001f98f9faf0
> > x29: ffff001f98f9faf0 x28: ffff0020df543cc0 x27: 0000000000000000
> > x26: ffff001f811344a0 x25: ffff8000818dac00 x24: ffff800082d8d048
> > x23: ffff001f850fcd18 x22: 0000000000000001 x21: ffff001f98f9fb88
> > x20: ffff001f83e76218 x19: ffff001f83e761e0 x18: 000000000000ffff
> > x17: 303a30303a303030 x16: 0000000000000000 x15: 0000000000000003
> > x14: 0000000000000001 x13: 0000000000000000 x12: 0101010101010101
> > x11: 0000000000000001 x10: 0000000000000001 x9 : ffff800080e08d0c
> > x8 : ffff001f98f9fb88 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> > x2 : ffff001f83e761e0 x1 : 00000000ffff001f x0 : 0000000000100cca
> > Call trace:
> > tee_shm_put+0x24/0x188
> > tee_shm_free+0x14/0x28
> > __optee_disable_shm_cache+0xa8/0x108
> > optee_shutdown+0x28/0x38
> > platform_shutdown+0x28/0x40
> > device_shutdown+0x144/0x2b0
> > kernel_power_off+0x3c/0x80
> > hibernate+0x35c/0x388
> > state_store+0x64/0x80
> > kobj_attr_store+0x14/0x28
> > sysfs_kf_write+0x48/0x60
> > kernfs_fop_write_iter+0x128/0x1c0
> > vfs_write+0x270/0x370
> > ksys_write+0x6c/0x100
> > __arm64_sys_write+0x20/0x30
> > invoke_syscall+0x4c/0x120
> > el0_svc_common.constprop.0+0x44/0xf0
> > do_el0_svc+0x24/0x38
> > el0_svc+0x24/0x88
> > el0t_64_sync_handler+0x134/0x150
> > el0t_64_sync+0x14c/0x15
> >
> > Fixes: dfd0743f1d9e ("tee: handle lookup of shm with reference count 0"=
)
> > Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> > ---
> >  drivers/tee/tee_shm.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index daf6e5cfd59a..915239b033f5 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -560,9 +560,13 @@ EXPORT_SYMBOL_GPL(tee_shm_get_from_id);
> >   */
> >  void tee_shm_put(struct tee_shm *shm)
> >  {
> > -     struct tee_device *teedev =3D shm->ctx->teedev;
> > +     struct tee_device *teedev;
> >       bool do_release =3D false;
> >
> > +     if (!shm || !shm->ctx || !shm->ctx->teedev)
> > +             return;
> > +
> > +     teedev =3D shm->ctx->teedev;
> >       mutex_lock(&teedev->mutex);
> >       if (refcount_dec_and_test(&shm->refcount)) {
> >               /*
> > --
> > 2.25.1
> >
