Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED14FD062E
	for <op-tee@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 35D8643102
	for <op-tee@archiver.kernel.org>; Wed, 11 Mar 2026 06:48:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XVxY6ks7;
	dkim-atps=neutral
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7B9F7430AD
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Mar 2026 06:48:06 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-466ebbf7ff7so1221591b6e.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 10 Mar 2026 23:48:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211686; cv=none;
        d=google.com; s=arc-20240605;
        b=JuZQkmUHX9Rc+9LRLwA8ErOW12H7oajxEDN0Ea5HqvQZ/wmcxOfKgnrVvDHLnCK5sB
         8ttSGNUKzjCcu76NfI0sWB+2z4Gk8WKjGWHwn5peGI4USrzvA5FQVDrbPxjNGBm5BPS0
         HhR+84fUfzhj91l476q8+cYIxYlxKWNiibFYboR+MVAa4HWwm1urRZtm2It/l8+6L1Ep
         PWRCly7/DFZnM0MVSGvfiKYPRSZUmylKeXBSoBQ5j6tt9l/N3/RmlYedznjw1qlgKzgC
         OOG/2BIO7Wd6Uu/hHsFneCKKUw9Fq2nT0gBG0Bz5WRGSIAV3e5r87PD1pp6SQV0v65Ia
         hcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qQjvMLTeZBTwVOHEN4nY/IVON8pNLQGqWANikHkCjPE=;
        fh=L6PWeWRJrkGwFBXn79rvFIgJkXHkUxE+21Q0MRL+yT8=;
        b=Ywy52PE0kOrMVCPHMQTsgPfID8Apmx50JSmjqzWTbLz2YJPQbcY5P0Q8rnkXniJL+1
         PhofSMxuWHMfUUz0VVeCUy4pIdZv8NbLdwXwVUJMN49B8FuWGcX/wCBLKWQtBxjHp2RG
         xkyVIfi6HnrHkMpSgtU5A/MXsljfXdG+/wxhej/U2ncoqWsQpPcebcG1Zyujh8EMLcZK
         eWCCnht1KQ3rwsPRV0HTvGKRWeMyT8a9Miq9qtc+SYVvBySKwbSJNjlNUWkYiCTra9ie
         e/kghnnkvRxXYVfrJAMoeyu0dR6K3WbnewiOBZ2BDcNtB0N5jMfMqZDCJjaNQED4Jwqr
         9rPw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773211686; x=1773816486; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQjvMLTeZBTwVOHEN4nY/IVON8pNLQGqWANikHkCjPE=;
        b=XVxY6ks7XGL6y+2qqe066lUZXVUmrZWgUHe7xmNT/UVX0PSq7ASIjVmZp+APP+sUWF
         HRLIvVtvBd0P8IUBkbIEHnGIPOHqmrwSz1Xf8oijXVSSRIemOi9CXvuCLuflFf6hoYLZ
         hrIjQoCSZ6YZ5+q1bvJWoRPgdWFuiwj+j9OXzcoiklUlGwpyGts5NGm0qdnkqFTcIZOL
         oaVGpQt3AkOU2sROfgE7FK3XHPZXkJjZIZEsuWVNe+nCFUAY7pHFxRM86NxEgL7PyDLh
         J05a0zsMEbCtFJxX2CoFefup5k5k58NdJLnhhQA3Kerc2XSrPhzxABb+NjQHcKEjIesG
         VqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211686; x=1773816486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQjvMLTeZBTwVOHEN4nY/IVON8pNLQGqWANikHkCjPE=;
        b=XcXGO27Le1Bs5RnWgAJpEK33plP6jBPkqKXeKFmcQq8C3eyIBnVocfqqBhvMF1bqSz
         SmhpkMgtdEU5YWsjshBEorJZgEKE31NFnslu0SSJ5102DhKw06qJtc2Qa3qtHE1MkaQ7
         JFrHY8Xyn5+VLyniEAHzRzlnG3FAn/lfon3HylAzB1T1rxsXdKJUTwlth6VRYYzcZ7nl
         ir95adSWLgDrFQhQLbCZyCLZOuEStqd1311OvLrAe84+K/B/LuPDG1+rgSSFEnxHb9Cf
         L7dKZSk6FeVHiv23EeXEUKCpog/SBFQhhKo5WhM+S1VVSOa1HQzt9ZSmjI9itRlJ3yVu
         XliQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt1Ixw5kWt3ZeNIwHbs3jbuZCoO73GFchvf611VRcdKkCgWaCP8EZFkAj9Wtp9sMC6ph3uvic=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzbuva4gZU0enHew/VkAtCewtpIsBRGkN/ltKaSoKwnFWRFCk9I
	B0j6o6AjXEschEddS9SozZO4pbl5lKBIkhuMTgQEGUtud1tej+23IwVTM6yj0AURqD0dM38m4NO
	0tJkyxLuvZ22ZjMiPo3bcd4UOyWXZL0EfTAfN4ziB8ixK
X-Gm-Gg: ATEYQzzhSM1addhDOY3OcjV5eBHu1TApylKg1wdF3wBLljCczhDGsjyHZinKfCrmWJj
	Lze+oTs+umCJJb/Ok0yLagXRTWqa7eKbHTKwVCwVK415Ut/V6VcGdEzd7APC6OelGnx9nhhJPRM
	fBOSyyk0owXn7eYVrWsisq8GiQ3mJwAw5v+bN39ZbrZgGusqEZ6ZojhVWnxxgQnuadh9Y5RkSld
	dzY9wN+DUtawWCYTYtAaJ8Bn/KXTufbH1DvpojvaaG0z6eijyw5yGFIOHiEkSeejjYGG3OuH596
	tewzb4kES3PEGr0fl87kfJ7tXiYb1NRydXrftg==
X-Received: by 2002:a05:6820:4b18:b0:67b:b796:fddd with SMTP id
 006d021491bc7-67bc88b1a3emr1145855eaf.25.1773211685619; Tue, 10 Mar 2026
 23:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260220084959.1966771-1-sumit.garg@kernel.org> <c8bd88c3-a878-40f6-840f-9d779a585ad8@pengutronix.de>
In-Reply-To: <c8bd88c3-a878-40f6-840f-9d779a585ad8@pengutronix.de>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 11 Mar 2026 07:47:54 +0100
X-Gm-Features: AaiRm51BXJFDit2MsP9kFvajFmKq05LkMxrH9pjTnZ5pwSnKnxrGvbRETdM7zmg
Message-ID: <CAHUa44HZk5d3GbnrBQyyHBORMcFjbtSTs1Tyq_DWXAonkO0-4Q@mail.gmail.com>
Subject: Re: [RFT PATCH v2] tee: shm: Remove refcounting of kernel pages
To: =?UTF-8?Q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.177:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.177:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7B9F7430AD
X-Spamd-Bar: -----
Message-ID-Hash: YDUEXUCQGGVKLHKS4U75F3OKMA66MM2V
X-Message-ID-Hash: YDUEXUCQGGVKLHKS4U75F3OKMA66MM2V
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, vbabka@suse.cz, akpm@linux-foundation.org, willy@infradead.org, m.felsch@pengutronix.de, Sumit Garg <sumit.garg@oss.qualcomm.com>, kernel@pengutronix.de
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YDUEXUCQGGVKLHKS4U75F3OKMA66MM2V/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Feb 27, 2026 at 4:15=E2=80=AFPM Sven P=C3=BCschel <s.pueschel@pengu=
tronix.de> wrote:
>
> On 2/20/26 9:49 AM, Sumit Garg wrote:
>
> > From: Matthew Wilcox <willy@infradead.org>
> >
> > Earlier TEE subsystem assumed to refcount all the memory pages to be
> > shared with TEE implementation to be refcounted. However, the slab
> > allocations within the kernel don't allow refcounting kernel pages.
> >
> > It is rather better to trust the kernel clients to not free pages while
> > being shared with TEE implementation. Hence, remove refcounting of kern=
el
> > pages from register_shm_helper() API.
> >
> > Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab =
page")
> > Reported-by: Marco Felsch <m.felsch@pengutronix.de>
> > Reported-by: Sven P=C3=BCschel <s.pueschel@pengutronix.de>
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > Co-developed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> Tested-by: Sven P=C3=BCschel <s.pueschel@pengutronix.de>
>
> tested with a30b36143a41 ("Linux 6.19.4") and removed my reported
> warning stacktrace.

I'm picking up this.

Thanks,
Jens

>
>
> Sincerely
>      Sven
>
> > ---
> >
> > Changes in v2:
> > - Attribute Matthew as the author of this patch.
> > - Fix check for user pages.
> >
> >   drivers/tee/tee_shm.c | 27 ---------------------------
> >   1 file changed, 27 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 4a47de4bb2e5..898707ca21a8 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -23,29 +23,11 @@ struct tee_shm_dma_mem {
> >       struct page *page;
> >   };
> >
> > -static void shm_put_kernel_pages(struct page **pages, size_t page_coun=
t)
> > -{
> > -     size_t n;
> > -
> > -     for (n =3D 0; n < page_count; n++)
> > -             put_page(pages[n]);
> > -}
> > -
> > -static void shm_get_kernel_pages(struct page **pages, size_t page_coun=
t)
> > -{
> > -     size_t n;
> > -
> > -     for (n =3D 0; n < page_count; n++)
> > -             get_page(pages[n]);
> > -}
> > -
> >   static void release_registered_pages(struct tee_shm *shm)
> >   {
> >       if (shm->pages) {
> >               if (shm->flags & TEE_SHM_USER_MAPPED)
> >                       unpin_user_pages(shm->pages, shm->num_pages);
> > -             else
> > -                     shm_put_kernel_pages(shm->pages, shm->num_pages);
> >
> >               kfree(shm->pages);
> >       }
> > @@ -477,13 +459,6 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >               goto err_put_shm_pages;
> >       }
> >
> > -     /*
> > -      * iov_iter_extract_kvec_pages does not get reference on the page=
s,
> > -      * get a reference on them.
> > -      */
> > -     if (iov_iter_is_kvec(iter))
> > -             shm_get_kernel_pages(shm->pages, num_pages);
> > -
> >       shm->offset =3D off;
> >       shm->size =3D len;
> >       shm->num_pages =3D num_pages;
> > @@ -499,8 +474,6 @@ register_shm_helper(struct tee_context *ctx, struct=
 iov_iter *iter, u32 flags,
> >   err_put_shm_pages:
> >       if (!iov_iter_is_kvec(iter))
> >               unpin_user_pages(shm->pages, shm->num_pages);
> > -     else
> > -             shm_put_kernel_pages(shm->pages, shm->num_pages);
> >   err_free_shm_pages:
> >       kfree(shm->pages);
> >   err_free_shm:
