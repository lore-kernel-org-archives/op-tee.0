Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315FBEDF176
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 16:09:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 66C3443721
	for <op-tee@archiver.kernel.org>; Fri, 13 Feb 2026 16:09:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hMu75Rel;
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CEDF3431D4
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Feb 2026 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=+MW+1p3xe29QSUgIu2RYNKe1kB/sRfBR1x8LhxaKz1E=; b=hMu75RelIkxHK6uOuV1YKqU7dN
	DnEIQr3TdF0Qw6OviHEVcDcQgkOdlFky1tkWi+OqmgSEqJ7Ul+IcY7GO3sDhU9XlhIDyLr888dZuv
	KmpivRSm9r3sM3fs95HTzU++TMUJRjoyql+l8pnNvagzNd+OnDuhp/bm75Gytz315QCrpRDwAHi8Z
	O2WjuLsDQho3HjbKiOeShR9r3P9HJFlkL9T9TC8bZ94O8PzWbHoKGZLQ2nXEVAssqxi76uxXlEY3z
	T9c7LEQKLndWNZ6qJ0LrtDatUfS4wUExsC7G+b1Jvf4l0wTwAcjJduSMpUfIWYIhq5/vu+Zj75K/t
	I/X3PA3A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqviz-0000000FxKr-2YBG;
	Fri, 13 Feb 2026 16:08:57 +0000
Date: Fri, 13 Feb 2026 16:08:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [RFT PATCH] tee: shm: Remove refcounting of kernel pages
Message-ID: <aY9MmQ5iVvgj3Km6@casper.infradead.org>
References: <20260213113317.1728769-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260213113317.1728769-1-sumit.garg@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	ONCE_RECEIVED(0.20)[];
	RCVD_IN_DNSWL_MED(-0.20)[90.155.50.34:from];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:20712, ipnet:90.155.0.0/18, country:GB];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_NA(0.00)[no SPF record];
	DWL_DNSWL_BLOCKED(0.00)[infradead.org:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CEDF3431D4
X-Spamd-Bar: ----
Message-ID-Hash: APSCUGK5WTUR35PY3BHIZGCR6RBESCED
X-Message-ID-Hash: APSCUGK5WTUR35PY3BHIZGCR6RBESCED
X-MailFrom: willy@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, vbabka@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Marco Felsch <m.felsch@pengutronix.de>, Sven =?iso-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/APSCUGK5WTUR35PY3BHIZGCR6RBESCED/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Feb 13, 2026 at 05:03:17PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Um, this patch is exactly the patch I sent.  You're stealing my
authorship!  This patch should have my From: and Signed-off-by:
lines.  Your role in this is "handling and transporting the patch"
(see Documentation/process/submitting-patches.rst).  By all means
take credit for writing the commit message.

> Earlier TEE subsystem assumed to refcount all the memory pages to be
> shared with TEE implementation to be refcounted. However, the slab
> allocations within the kernel don't allow refcounting kernel pages.
>=20
> It is rather better to trust the kernel clients to not free pages while
> being shared with TEE implementation. Hence, remove refcounting of kernel
> pages from register_shm_helper() API.
>=20
> Fixes: b9c0e49abfca ("mm: decline to manipulate the refcount on a slab pa=
ge")
> Reported-by: Marco Felsch <m.felsch@pengutronix.de>
> Reported-by: Sven P=FCschel <s.pueschel@pengutronix.de>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/tee/tee_shm.c | 29 +----------------------------
>  1 file changed, 1 insertion(+), 28 deletions(-)
>=20
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 4a47de4bb2e5..54e2ba3afb25 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -23,29 +23,11 @@ struct tee_shm_dma_mem {
>  	struct page *page;
>  };
> =20
> -static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> -{
> -	size_t n;
> -
> -	for (n =3D 0; n < page_count; n++)
> -		put_page(pages[n]);
> -}
> -
> -static void shm_get_kernel_pages(struct page **pages, size_t page_count)
> -{
> -	size_t n;
> -
> -	for (n =3D 0; n < page_count; n++)
> -		get_page(pages[n]);
> -}
> -
>  static void release_registered_pages(struct tee_shm *shm)
>  {
>  	if (shm->pages) {
>  		if (shm->flags & TEE_SHM_USER_MAPPED)
>  			unpin_user_pages(shm->pages, shm->num_pages);
> -		else
> -			shm_put_kernel_pages(shm->pages, shm->num_pages);
> =20
>  		kfree(shm->pages);
>  	}
> @@ -477,13 +459,6 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
>  		goto err_put_shm_pages;
>  	}
> =20
> -	/*
> -	 * iov_iter_extract_kvec_pages does not get reference on the pages,
> -	 * get a reference on them.
> -	 */
> -	if (iov_iter_is_kvec(iter))
> -		shm_get_kernel_pages(shm->pages, num_pages);
> -
>  	shm->offset =3D off;
>  	shm->size =3D len;
>  	shm->num_pages =3D num_pages;
> @@ -497,10 +472,8 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
> =20
>  	return shm;
>  err_put_shm_pages:
> -	if (!iov_iter_is_kvec(iter))
> +	if (iter_is_uvec(iter))
>  		unpin_user_pages(shm->pages, shm->num_pages);
> -	else
> -		shm_put_kernel_pages(shm->pages, shm->num_pages);
>  err_free_shm_pages:
>  	kfree(shm->pages);
>  err_free_shm:
> --=20
> 2.51.0
>=20
