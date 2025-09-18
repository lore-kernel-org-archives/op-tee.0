Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A27FACAC59A
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 14:31:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DB8F641872
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 14:31:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lJcfXaNJ;
	dkim-atps=neutral
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 55F9440B1A
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 14:31:31 +0000 (UTC)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ea5d856ac28so492197276.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758205891; x=1758810691; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4SahLvEvBs48q/p+bf2A8sVsjiqFz6w+nVgWdq8XVc=;
        b=lJcfXaNJoVFu2fXDbjkxxXEy3Y6eoqJUZJqMqM0Rn+rXAMGJuCruNqT0oG6j+7YHOz
         avHl24GIOKPgIGFQISz5ss8VX4gjG4frP0iHpKFsW1Eizg1zZ8R1718L0b1Xr9qwDQQ4
         WeJ4Ua9kR+KHzq+sdCyen6ivn47zewFSj8g7cnrl22IU7um3vh7Y4K5xmczdT7rfrR/X
         LkRDG7+UyxQviSLznfxLAZXv6wO3e2Zd/2NY7zWoLN5ZIfOybane7h9XfzQVM8oi9hcP
         k5qLDj6bmn/zoBJTX9sHlY5GvwuLZ2eW9rKGku9w6whoZc2tLDyHS1qrVI+a6Z8/C9Ql
         YNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758205891; x=1758810691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4SahLvEvBs48q/p+bf2A8sVsjiqFz6w+nVgWdq8XVc=;
        b=K2BRN0CUsMZztcOi2PW48bsY/D56YvUA+hr/PlKblr3KhTgipnlg8aYjdEGm3NgES6
         T4XA/PmXdeUmceEYjhkcVO76/4MqY1kPBa4QUv1lExrq82DhlmaWgad2uQRzgKOAL1U1
         n0DLTypyxR5SM/mxHk0hZKfzha1B04OL2Vv218a7bRrdUUwLMd5oi9RbjI8cP5GuBRI9
         cJbwaRpGbjLMtOiZQunOjFfebpSOeo8QdbzQR9Ot7ndHiu/UiZ13pW5TeDFbLz4+sDe+
         /wpxHNAU9wd1+iF3lqrbhuvGp94Qbqd4y7n4XcIQlnCSq9c4mmZ2EmfT4Iuc5UL9qZSR
         aF9g==
X-Gm-Message-State: AOJu0Yy7tq/zCV3LHo2D6c9WxXh1QvOX9Pu8Pg20Al+oAvdgSml0QqGH
	8sYDnluRTapDnMmz0iyf8bBIeN0h5JNrOHeuNuomRdm9g6P1Y0ZLIgFPR7LjQG/qvX1M0IoaogN
	zr0RWmng3ZDBP8i5iK6Ejynnu/qoEN0k=
X-Gm-Gg: ASbGncs6vXbKwA96OgOEJ5ppA3lt7swTH0vdG+rX+4sH+qaOnlpUYtyr9xNqIcak4WK
	TQwDaB+3lLUxDz29k+2KK6U342m9PmKmQi2FICtIJjqPZSZ2oZckwvVhfQm0jN0lP15Q5No2UJG
	cu/4vE12gEzlsXQG9MSy0LSUBkciDnKSLaPBkx0DGLvfhOo97Wp4XuE12b8s5KJbmABJ6uRFdJd
	guvdbMUic07BVSziWUJhEBZH/KaQIfEaD+b
X-Google-Smtp-Source: AGHT+IEZdvLcOUvTjDWAfangrVcFB0AymxYXrWnFiBR2jziUrcIA5XpNQrjTy5KSm2pDuncRkKKp0cHKxUtdKJN+U9s=
X-Received: by 2002:a05:6902:3310:b0:ea5:b7f5:6e2c with SMTP id
 3f1490d57ef6-ea5c06be899mr5254214276.49.1758205890605; Thu, 18 Sep 2025
 07:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com>
 <CAHUa44FmMj-=5cd4TNGS0ve6jryeCUWeYt=2Um4c_1St5wvL3A@mail.gmail.com>
 <CACOXgS85UPo04u4z35M+sKe21gU6=8a-y1kALqeTWXv7UkZkag@mail.gmail.com> <20250918122541.GA2693176@rayden>
In-Reply-To: <20250918122541.GA2693176@rayden>
From: Masami Ichikawa <masami256@gmail.com>
Date: Thu, 18 Sep 2025 23:31:19 +0900
X-Gm-Features: AS18NWBqs6JnSwiqUETtlZMq59n_50mdK5QfO6Q9pdfE5ePO2HQbZ38LoeEhnqY
Message-ID: <CACOXgS_nNYCYVwwdZzxvKDUA-xR_iyR76rJqO0Hj9nJ9af=4_w@mail.gmail.com>
Subject: Re: [BUG] tee_shm: NULL pointer dereference in unpin_user_pages() on
 invalid shm pages
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 55F9440B1A
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.219.173:from];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.219.173:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: SVA4IU4DAHINEO72BSV3ATKAWQUCPGG6
X-Message-ID-Hash: SVA4IU4DAHINEO72BSV3ATKAWQUCPGG6
X-MailFrom: masami256@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SVA4IU4DAHINEO72BSV3ATKAWQUCPGG6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,

On Thu, Sep 18, 2025 at 9:25=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi Masami,
>
> [+Sumit in CC]
>
> On Wed, Sep 17, 2025 at 10:58:11PM +0900, Masami Ichikawa wrote:
> [snip]
> > I wrote a test program and ran it on both 6.17-rc5 and 6.14. I was
> > able to reproduce the crash on both kernels.
> >
> > I uploaded test code and test results to my gist.
> > https://gist.github.com/masami256/11e21a7503812af7ee1e890080093a2c
> >
> > The test code is crash_test.c. This program takes 2 arguments. First
> > argument is malicious buffer size and second one is actual buffer
> > size.
> > I can reproduce the crash with the following pair.
> >
> > malicious buffer size: 0xffffff
> > actual buffer size: 0xff
>
> Thanks, that easily reproduces the problem. The following diff should fix=
 it:
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -318,7 +318,16 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
>
>         len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_p=
ages, 0,
>                                      &off);
> -       if (unlikely(len <=3D 0)) {
> +       if (unlikely(len < num_pages * PAGE_SIZE)) {
> +               if (len > 0) {
> +                       /*
> +                        * If we only got a few pages, update to release
> +                        * the correct amount below.
> +                        */
> +                       shm->num_pages =3D len / PAGE_SIZE;
> +                       ret =3D ERR_PTR(-ENOMEM);
> +                       goto err_put_shm_pages;
> +               }
>                 ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>                 goto err_free_shm_pages;
>         }
>
> Cheers,
> Jens

Thank you for the fix.
I tested both 6.17-rc5 and 6.14. I confirmed your patch solves the problem.

Tested-by: Masami Ichikawa <masami256@gmail.com>

Regards,
--
Masami Ichikawa
