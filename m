Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA514EF5865
	for <op-tee@archiver.kernel.org>; Mon, 23 Feb 2026 05:07:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 228E443753
	for <op-tee@archiver.kernel.org>; Mon, 23 Feb 2026 05:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771823265;
	bh=HHRmCIipxN5xiX/HZjoYKjwj5wwfzNvvz6r1/tiMmjE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rJiXrAPEcyMTf5XsF17dbymn0hVdSMgsO1w1o0PQJVdGuz5EDlEch+9DLknGbs/x9
	 kZl+y1dwiwSm7HeLeefZBQQieZpi0hO6zmEszMJKk3ExhRW86MJ+7Ms3vTFC/tb4cd
	 oXqjFnDXg3E/OWlkGLwPLBI6m5q4NPv+9a9uaj2nBwnzbCUX3LDsklQ5WtvjZ6/hBj
	 x7jH18MQ5vYNOtfIDzY+r0uzanOYEX9LgJcVbl6RybaMjPI+7o+yDQ4EnDLjVDvLWT
	 kBDGED9tfzA6dZ5RTEx+kC/qIUX1DyQuoGJFCGXtxrumAJq3c1CRVRvWFx19bywtDs
	 U1pmpsCFCI31Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E2A2343751
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Feb 2026 05:07:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XqLBwvG0;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 50D694396A;
	Mon, 23 Feb 2026 05:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CA2C116C6;
	Mon, 23 Feb 2026 05:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771823245;
	bh=9sirl/LJPi8U+FnNQv8H6dqOhBee+XQieB7AswojCiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XqLBwvG07QXi+ZBtqnZWIGitErhGSWf5bWPfRrGE8LjL3b2yByr0ahC5XRVw84ODy
	 x4xq9cYqQIOBQDt7D3BHk9cG1OYPJtqJf17QCSa+ggsE9GMQbgkMcrtuEIgd9MEX6P
	 eJ9/7JyWe5TwBHcdIaF1q3pjmFPNxj91HySVM9ANOm6jkOdBE4uIQcS2z8WMfh9YLz
	 T5NZtNwMKCrmPEmY5cyReRXoLyVsRiADCAGvrkNEgAakRGJB3vY3XDdetDjnQcKoZq
	 JTOCyKGMFLLXg2rDIy4zPzFSrKukE0OGHSIczrfeWbDayS/4+M98P4GQUp5RsbyyBu
	 u7ZFXnyfVS6cw==
Date: Mon, 23 Feb 2026 10:37:18 +0530
To: Sven =?iso-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>
Subject: Re: [RFT PATCH] tee: shm: Remove refcounting of kernel pages
Message-ID: <aZvghsLXn3rJZBLm@sumit-xelite>
References: <20260213113317.1728769-1-sumit.garg@kernel.org>
 <7546a4ff-485c-4473-999c-08fdf4e815bc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7546a4ff-485c-4473-999c-08fdf4e815bc@pengutronix.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E2A2343751
X-Spamd-Bar: ---
Message-ID-Hash: FN2PXIXUZEY6H3GHV3ZUVFWLKZM6UTY6
X-Message-ID-Hash: FN2PXIXUZEY6H3GHV3ZUVFWLKZM6UTY6
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, vbabka@suse.cz, akpm@linux-foundation.org, willy@infradead.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Marco Felsch <m.felsch@pengutronix.de>, kernel@pengutronix.de
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FN2PXIXUZEY6H3GHV3ZUVFWLKZM6UTY6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Feb 17, 2026 at 12:01:55PM +0100, Sven P=FCschel wrote:
> Hi Sumit,
>=20
> On 2/13/26 12:33 PM, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >=20
> > Earlier TEE subsystem assumed to refcount all the memory pages to be
> > shared with TEE implementation to be refcounted. However, the slab
> > allocations within the kernel don't allow refcounting kernel pages.
> >=20
> > It is rather better to trust the kernel clients to not free pages while
> > being shared with TEE implementation. Hence, remove refcounting of kern=
el
> > pages from register_shm_helper() API.
> >=20
> > Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab =
page")
> > Reported-by: Marco Felsch <m.felsch@pengutronix.de>
> > Reported-by: Sven P=FCschel <s.pueschel@pengutronix.de>
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >   drivers/tee/tee_shm.c | 29 +----------------------------
> >   1 file changed, 1 insertion(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 4a47de4bb2e5..54e2ba3afb25 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -23,29 +23,11 @@ struct tee_shm_dma_mem {
> >   	struct page *page;
> >   };
> > -static void shm_put_kernel_pages(struct page **pages, size_t page_coun=
t)
> > -{
> > -	size_t n;
> > -
> > -	for (n =3D 0; n < page_count; n++)
> > -		put_page(pages[n]);
> > -}
> > -
> > -static void shm_get_kernel_pages(struct page **pages, size_t page_coun=
t)
> > -{
> > -	size_t n;
> > -
> > -	for (n =3D 0; n < page_count; n++)
> > -		get_page(pages[n]);
> > -}
> > -
> >   static void release_registered_pages(struct tee_shm *shm)
> >   {
> >   	if (shm->pages) {
> >   		if (shm->flags & TEE_SHM_USER_MAPPED)
> >   			unpin_user_pages(shm->pages, shm->num_pages);
> > -		else
> > -			shm_put_kernel_pages(shm->pages, shm->num_pages);
> >   		kfree(shm->pages);
> >   	}
> > @@ -477,13 +459,6 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >   		goto err_put_shm_pages;
> >   	}
> > -	/*
> > -	 * iov_iter_extract_kvec_pages does not get reference on the pages,
> > -	 * get a reference on them.
> > -	 */
> > -	if (iov_iter_is_kvec(iter))
> > -		shm_get_kernel_pages(shm->pages, num_pages);
> > -
> >   	shm->offset =3D off;
> >   	shm->size =3D len;
> >   	shm->num_pages =3D num_pages;
> > @@ -497,10 +472,8 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >   	return shm;
> >   err_put_shm_pages:
> > -	if (!iov_iter_is_kvec(iter))
> > +	if (iter_is_uvec(iter))
>=20
> I've replaced (due to compile failures noted by the kernel test robot) th=
is
> with the compiler suggested iter_is_iovec . I haven't checked, if this is
> the correct fix.
>=20
> With this patch applied (on the upstream commit 970296997869), my reported
> stacktrace/warning doesn't occur anymore. I didn't do any extensive testi=
ng,
> but creating and using a trusted key with keyctl worked fine in my short
> test.

Thanks for testing it out, I have fixed the compiler error in v2 here [1]. =
Can
you help to retest with a proper tested by tag?

[1] https://lore.kernel.org/all/20260220084959.1966771-1-sumit.garg@kernel.=
org/

-Sumit

>=20
> Sincerely
> =A0 =A0 Sven
>=20
> >   		unpin_user_pages(shm->pages, shm->num_pages);
> > -	else
> > -		shm_put_kernel_pages(shm->pages, shm->num_pages);
> >   err_free_shm_pages:
> >   	kfree(shm->pages);
> >   err_free_shm:
