Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4EDCAC5A7
	for <op-tee@archiver.kernel.org>; Sun, 21 Sep 2025 06:14:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A82DA43103
	for <op-tee@archiver.kernel.org>; Sun, 21 Sep 2025 06:14:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q1WvjaeC;
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 09B6240B35
	for <op-tee@lists.trustedfirmware.org>; Sun, 21 Sep 2025 06:14:28 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60150590so22869997b3.0
        for <op-tee@lists.trustedfirmware.org>; Sat, 20 Sep 2025 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758435267; x=1759040067; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AojnXTuhkuopZDJGSIrifi2m6vfKyheuFT3tQ1DZFd4=;
        b=Q1WvjaeCP8rXD32aU4K3xHPjCS5yB/u7/TYzYzExy8+VSKrO6w83JKgAwlgK2jslLd
         UH/6A7F0423yRMwk9xkaSE6k+5owUlyGhO49Pl1UfKjYn/arsnIgawqyk3fe7Faknh6x
         25R33i9o4+7TMAekLb3lv9MoqJ1cZl+/rtGe0gDvUURSXfT5txpatOb6y0k2kJeLDOYk
         CBQ6Qqc/zd/JBwkPNuq1FcbCktQNt3QCcD8ZN9tJajuSuoXDtkFhgeqe177/zyAIEWB1
         8PXV4ITw8eU7PlKPFnqeCOoB550M81rMJYQrTCh97psMstlV6icyDtzYgV084YSzFs8f
         /x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758435267; x=1759040067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AojnXTuhkuopZDJGSIrifi2m6vfKyheuFT3tQ1DZFd4=;
        b=xQsc+EtbhOn2pRwQCz8ZwvpymCJVzZ9iKDRf2/Fk5f9lQf/WKKvTq6X9kmzrvQx2d0
         x6A9j5SHiEUj1kZCSM4HTtcyPvkE+dndvSmL48vYGR7HJptNRq6HgddVbkM+jodJre3o
         yUDyRUvPxJPjSN/u267S4HVT4O7LRF+O1i5E0YcAhgshUR6AlfkeZPNaW0mPSh9XitoQ
         NCI8C3Hh0ZZwwSvy0cAK2EpW0uG3Lh8XdxAVCVOBIAS+1OWNK7N7wX0TZvzsqr0/QSg4
         b8UNPeAdHJ0Q6wHs4XkAMYMyVsKbQsEhitKt4fY2B0kw2AxIOZTSZG4GcN0+I3RsYsZq
         VROw==
X-Forwarded-Encrypted: i=1; AJvYcCVpJNV7kNfk7VLMvOsPJxwsrpvKBSmJ7PJdGS0Lwv4TuTV40fe7H9YHGkaGL849AQo3O1cMdZo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxvPTDY8xtqHL8nwn/HOnaOJ+AahXQ5TxZ0D03x356eVw4BM4bx
	DWRzBnOeyKrxeH/8kGi719jKGS+uIeOcga0f8mJfSzXLDUj5bmxvYrrCHeQmYRwLqoirrvKQQRg
	KezGTNQ7sZBaF5eYMX2AmIM93eDBu3+g=
X-Gm-Gg: ASbGnctc4BNjai/NGtmmoDk2meOVeZyq/Ann4KVfrAS0zAcSSPvArmPG1F2o9//VpdQ
	jNgdNY+jT4OxI7wJpYVW2ecfwmrKb4JJOX7HOWehjg+MbXa/s1nbcjWoh4dZN3vV/I6J9H99OD+
	0CKms9GdbPSXnaByKtjmDCCRsk63YSM6LngIXM2t0cC1w2njhtx8HkKZapXn4rI5ntB6MNeQpW2
	yKrHTM=
X-Google-Smtp-Source: AGHT+IEshwwZOaE95eNfvPs+ev8aG1Akgfm3NpGOGPxgdxXazdfE91ijPAySFiDD2wkPtUo8g45aZzylIGiDlySCImc=
X-Received: by 2002:a05:690c:6182:b0:71f:9a36:d5bd with SMTP id
 00721157ae682-73d3ef2b466mr69139097b3.43.1758435267450; Sat, 20 Sep 2025
 23:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250919124217.2934718-1-jens.wiklander@linaro.org>
In-Reply-To: <20250919124217.2934718-1-jens.wiklander@linaro.org>
From: Masami Ichikawa <masami256@gmail.com>
Date: Sun, 21 Sep 2025 15:14:16 +0900
X-Gm-Features: AS18NWCiSCvSKiAJ1yM15ZzGP6XX-bMqSWPpOjNvuBcqsSil-IxTILIg5W2DemA
Message-ID: <CACOXgS9rA=tEfJ85Mw8550Yfq2XvBMLjknzOV+vnR0KTTLGHkQ@mail.gmail.com>
Subject: Re: [PATCH] tee: fix register_shm_helper()
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 09B6240B35
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.182:from];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.182:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: SZNDKOKJLJVC2DU3RT6DEN5NK7DDD47B
X-Message-ID-Hash: SZNDKOKJLJVC2DU3RT6DEN5NK7DDD47B
X-MailFrom: masami256@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, Sumit Garg <sumit.garg@kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SZNDKOKJLJVC2DU3RT6DEN5NK7DDD47B/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,


On Fri, Sep 19, 2025 at 9:42=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> In register_shm_helper(), fix incorrect error handling for a call to
> iov_iter_extract_pages(). A case is missing for when
> iov_iter_extract_pages() only got some pages and return a number larger
> than 0, but not the requested amount.
>
> This fixes a possible NULL pointer dereference following a bad input from
> ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
>
> Cc: stable@vger.kernel.org
> Reported-by: Masami Ichikawa <masami256@gmail.com>
> Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTj=
JAvUbEiQfq=3Du9W+-g@mail.gmail.com/
> Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer r=
egistration")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..6ed7d030f4ed 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
>
>         len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_p=
ages, 0,
>                                      &off);
> -       if (unlikely(len <=3D 0)) {
> +       if (DIV_ROUND_UP(len + off, PAGE_SIZE) !=3D num_pages) {
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
> --
> 2.43.0
>

Thank you for the patch. I confirmed that the patch fixes a kernel
crash caused by a NULL pointer dereference.

Tested-by: Masami Ichikawa <masami256@gmail.com>

Regrads,
--
Masami Ichikawa
