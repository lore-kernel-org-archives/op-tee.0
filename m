Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51898606A321
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=PhC9dhrX;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzMZ1Oh9
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A9007454DB
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 11:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1794481777;
	bh=oohyDMEtdwXIaw+ORCSP/nWMT+2AZNtGQ7u1pISBfWI=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=PhC9dhrXBhVBhkOWporwT4VkUe+WFrV6vCHeM52fFfoDKhILPxUOP6TcSuoSOPKrE
	 lobqPR0ekdrLLMLma6R5U8f4ziq+7rceyF0rCYct9OxpUbM5vFpnBYQURiEU3OKvFt
	 Yrzx6ZAIUAJ1HlG5h+WQRvoWreEHx5VVI4AsM9bERautrOfKF1JbmH9KMGhCmcEwVP
	 zHQ6vVsPjpD3igXTVGp/ZuTKc/4wLqHqR+n8rBSoo1NdxmfhqjU+b2/kBGtfx9iVUs
	 Y3Vn7w4BTvhRg120IeVxrnMh7NcjSDV9RGilqaLktkisthdgJql2w1CAwZqr8S+2lU
	 Xhvopzg6pX+Qw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B39F144DC8
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 11:08:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzMZ1Oh9;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7443B639FD;
	Thu, 12 Nov 2026 11:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFAE1F00A05;
	Thu, 12 Nov 2026 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481732;
	bh=r8LeQJ3H9vwXd92l8n5mDTq6/jwXyFVP+xBw8qc6N4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NzMZ1Oh9HxHZ6qAk5EfPB8RIuILKq+u/heoaTo1HB53tH9+5pAKywe7KbvOxoq+zA
	 XATFxvjljrWRPI7iflpDvHXoKr30fBFmSTI/XNfdHoHHBI70Yl5971B6lXqcOjBPPG
	 iavS4XP4C9ZWMdrlksAJ6tvnCezzRTD0/4Ty3BOZM5/lQekHC75pQrP4Km93UEIyK0
	 IoPO2Yp4kzZkeJIjSK9qStqxhk+wW7s9m2pgkDzXwaaTkQ9WkbEpsd+YkIXUXCgBW0
	 3PsdCBnlJJ8x3WMAd1B2QG43Rlw/jWyA0Y9rY3LigHytx6iUKLSjfoOBvfehna4gln
	 VIwlv6tgvLALw==
Message-ID: <sashiko-outbox-210997@kernel.org>
Subject: Re: [PATCH v3 8/8] optee: Add support for lendable-dma-pool
To: "Vincent Donnefort" <vdonnefort@google.com>, catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261111110738.872947-9-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-9-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:08:50 +0000
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	MISSING_MIME_VERSION(2.00)[];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B39F144DC8
X-Spamd-Bar: ------
Message-ID-Hash: OD3V3DIEZZNZHQQPAI7QPSJQIAR3FM2T
X-Message-ID-Hash: OD3V3DIEZZNZHQQPAI7QPSJQIAR3FM2T
X-MailFrom: sashiko-bot@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OD3V3DIEZZNZHQQPAI7QPSJQIAR3FM2T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: sashiko-bot--- via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] optee: restore_direct_map_dyn_protmem() called when
  reclaim_protmem() fails
--

commit 1a801ca7487b0859c4bfdf62e4f1116b16a1b7fe
Author: Vincent Donnefort <vdonnefort@google.com>

optee: Add support for lendable-dma-pool

This commit uses dma_zap_direct_map() and dma_restore_direct_map() to
unmap dynamically allocated protected memory from the kernel linear map
before lending it to the secure world and restore it upon reclaim.

> diff --git a/drivers/tee/optee/protmem.c b/drivers/tee/optee/protmem.c
> index be3abf6e8aa6d..10e8f1540e5e8 100644
> --- a/drivers/tee/optee/protmem.c
> +++ b/drivers/tee/optee/protmem.c

[ ... ]

> @@ -76,6 +103,8 @@ static int init_dyn_protmem(struct optee_protmem_dyn_p=
ool *rp)
>  	rp->gen_pool =3D NULL;
>  err_reclaim:
>  	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
> +err_restore_direct_map:
> +	restore_direct_map_dyn_protmem(rp);
>  err_put_shm:
>  	tee_shm_put(rp->protmem);
>  err_null_protmem:
> @@ -112,6 +141,7 @@ static void release_dyn_protmem(struct optee_protmem_=
dyn_pool *rp)
>  	rp->gen_pool =3D NULL;
> =20
>  	rp->optee->ops->reclaim_protmem(rp->optee, rp->protmem);
> +	restore_direct_map_dyn_protmem(rp);
>  	rp->protmem->flags &=3D ~TEE_SHM_DYNAMIC;
> =20
>  	WARN(refcount_read(&rp->protmem->refcount) !=3D 1, "Unexpected refcount=
");

[Severity: High]
Can restore_direct_map_dyn_protmem() run while rp->protmem is still lent
to the secure world if reclaim_protmem() fails?

reclaim_protmem() can fail, for example if optee_get_msg_arg() returns
-ENOMEM in optee_smc_reclaim_protmem() or if the secure world has not
relinquished the memory handle in optee_ffa_reclaim_protmem().  Both
init_dyn_protmem() and release_dyn_protmem() ignore that return value and
unconditionally call restore_direct_map_dyn_protmem(rp).

On arm64, arch_dma_restore_direct_map() remaps the pages as cacheable in
the linear map and runs dcache_inval_poc() across the range, which
re-exposes the still-lent pages to CPU speculative reads and triggers a
synchronous external abort or SError on the cache maintenance before
tee_shm_put() returns the pages to the allocator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111110738.8729=
47-1-vdonnefort@google.com?part=3D8
