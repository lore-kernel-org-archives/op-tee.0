Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F29E63F2A
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 06:12:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DF46343879
	for <op-tee@archiver.kernel.org>; Mon, 16 Feb 2026 06:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1771222362;
	bh=BUlrTL04YkJTg3YfYEpa5HqaEr/cdvj1LSAkgHlhiJQ=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=vIB2cDSpQUktyyqjDQQpIoMt9ygsNKANu37EYCi/UDs7tXjQbiHxFxJiMybaMriyy
	 DSRPSoFXLfHC8rkIGtXpUOV+pycYwxnG1z3A6VU8YknyojjzFv4wWlAvJAd/mWn6S4
	 asFLfNZqjnanSQHKOcIb78oofSIaF6ys8PDswx07u1IcI6koxnygPshnrvWhKlSqPt
	 yvGQLKnD7yqsJglUdOnoyEIbn+RBWVXdBWTivT+Z+YcbrPsC7PgOefM/jY3wP8j05q
	 R9iCuRtOuwMDcFk4hgijSXXE1ZnVjmSTAKu3cgwzXeKuyYtHOkF6AKZ1ynJoNb5jtb
	 fKmSYebNs14Xg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3A3F243868
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Feb 2026 06:12:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jCF5oRwf;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A7EFC406F3;
	Mon, 16 Feb 2026 06:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA1EC116C6;
	Mon, 16 Feb 2026 06:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771222341;
	bh=fY+kP4YBwDjhTps+8Ev42mJuQ2PGyMnt8O2c+6gw+os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCF5oRwfkYA1Au/svGJjtPKb1knHldnWQ2zJ/Xfr8HkSCgzajCCy+V4/nLHuCsrLZ
	 G7Dw7l+8pTDQ+XjNNxw1E7RViBYQTlhfy+GbamI85/vBQAWgGBxr550bub17NutpBt
	 V0+qsZ8jro6pUERz9qOcIP7SIeIqUDrRYRBf6lRBcOO8HDJEykJRKDxjIc/WMnrlyE
	 fKw3N5qqk6oODa4zxXgREKxEuni2FvBtmepwBhzFixRaWyWGKk/rqg+plGSaLAT/Wa
	 XgxaHjDfMbBAo1E0uT2Lu9uuNdWgBhjd5YLb4LQ+hB5NsxibRi/FeVu8mCqHhSotA0
	 Q5RO9Sk5/LORg==
Date: Mon, 16 Feb 2026 11:42:14 +0530
To: Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFT PATCH] tee: shm: Remove refcounting of kernel pages
Message-ID: <aZK1PpkK2DhZSNA3@sumit-xelite>
References: <20260213113317.1728769-1-sumit.garg@kernel.org>
 <aY9MmQ5iVvgj3Km6@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aY9MmQ5iVvgj3Km6@casper.infradead.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3A3F243868
X-Spamd-Bar: ---
Message-ID-Hash: JFXERV6YXWUI4T6RYCNASSNHK5YAOOSL
X-Message-ID-Hash: JFXERV6YXWUI4T6RYCNASSNHK5YAOOSL
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, vbabka@suse.cz, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Marco Felsch <m.felsch@pengutronix.de>, Sven =?iso-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JFXERV6YXWUI4T6RYCNASSNHK5YAOOSL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, Feb 13, 2026 at 04:08:57PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 13, 2026 at 05:03:17PM +0530, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
>=20
> Um, this patch is exactly the patch I sent.  You're stealing my
> authorship!  This patch should have my From: and Signed-off-by:
> lines.  Your role in this is "handling and transporting the patch"
> (see Documentation/process/submitting-patches.rst).  By all means
> take credit for writing the commit message.

Not sure how I can consider that diff from you a proper patch but surely
I tried to give your suggestion attributes. However, it's fine with me
to keep your authorship if you really want to vet this patch. Will send
a v2 with the authorship updated.

-Sumit

>=20
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
> >  drivers/tee/tee_shm.c | 29 +----------------------------
> >  1 file changed, 1 insertion(+), 28 deletions(-)
> >=20
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 4a47de4bb2e5..54e2ba3afb25 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -23,29 +23,11 @@ struct tee_shm_dma_mem {
> >  	struct page *page;
> >  };
> > =20
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
> >  static void release_registered_pages(struct tee_shm *shm)
> >  {
> >  	if (shm->pages) {
> >  		if (shm->flags & TEE_SHM_USER_MAPPED)
> >  			unpin_user_pages(shm->pages, shm->num_pages);
> > -		else
> > -			shm_put_kernel_pages(shm->pages, shm->num_pages);
> > =20
> >  		kfree(shm->pages);
> >  	}
> > @@ -477,13 +459,6 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >  		goto err_put_shm_pages;
> >  	}
> > =20
> > -	/*
> > -	 * iov_iter_extract_kvec_pages does not get reference on the pages,
> > -	 * get a reference on them.
> > -	 */
> > -	if (iov_iter_is_kvec(iter))
> > -		shm_get_kernel_pages(shm->pages, num_pages);
> > -
> >  	shm->offset =3D off;
> >  	shm->size =3D len;
> >  	shm->num_pages =3D num_pages;
> > @@ -497,10 +472,8 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> > =20
> >  	return shm;
> >  err_put_shm_pages:
> > -	if (!iov_iter_is_kvec(iter))
> > +	if (iter_is_uvec(iter))
> >  		unpin_user_pages(shm->pages, shm->num_pages);
> > -	else
> > -		shm_put_kernel_pages(shm->pages, shm->num_pages);
> >  err_free_shm_pages:
> >  	kfree(shm->pages);
> >  err_free_shm:
> > --=20
> > 2.51.0
> >=20
