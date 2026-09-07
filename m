Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4479CC79F89
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 14:00:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5F6AC45220
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788789629;
	bh=EgLK3o+julTVE6C/8v3utQVcxVTdU7XWXdzws8YaC20=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BIRYE6YUx76UKIJABaZg1nqEoqnzIbmHLcWZFDtJ/LwUd3tdC1bbgak4ErWfG0ncr
	 ZO1ec6mAZD3e4BYO0uXPQEDVP4nY1wqEjAlwapikBt5tF2AouP1Di8nBuLVYU3wCFF
	 KzWmmaNh7ypflNs9e8c7Pv0CmYCyrLDdvDnxjh9JODP04bjdijgJhH7iV7G80iDu7t
	 cAQu7iS344ATmWrDfYf9FzqIXnL5YO0/rmnovU1IV5XDnlzmTmkfLnX5r2mG8OG87u
	 cq2Ae0DOJwxdI04zieCAYKfxmtwdy+f3DZ1fgbuaOtypQw2+CrIl5nbV777BGigZxj
	 vNgQXGNlQbspQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 114AE44441
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 14:00:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gtOe0lI4;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 476184086C;
	Mon,  7 Sep 2026 14:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985261F00A3D;
	Mon,  7 Sep 2026 14:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789622;
	bh=EgLK3o+julTVE6C/8v3utQVcxVTdU7XWXdzws8YaC20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gtOe0lI4tICmFeXO0VXaSZWun1zD97NtGKzB00Fxz4Ka/Zpm56GHzGCFmpkzXvwya
	 IjgdW5ASTJB+qKa5sg3xhHy+2z3Tif4EUzgG6v2G0AqXAMe/0BNO4ao6/A+PGKiEDt
	 LiunuR042Q+3iJ1jf+LikMpBoAosls+iqBo1ld1uAEuNgD3FyixqBGd1NK8XwlELz8
	 0aXr47TpsMtDRS4WsQVvIrdjIekWTZVzwY14LA7ppw9cLIVA/gJznyINUg586mqoJr
	 i4bMWj2QqqCUzgdxYWZPl2+vXlMSa8ApBf/xkklnj7o+nTfBb5pP16MUu53RogA7JW
	 PhrukphYxcyLg==
Date: Mon, 7 Sep 2026 16:00:19 +0200
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v9 02/10] of: reserved_mem: Introduce "ll-map" property
Message-ID: <ap7CAowlFTFhSFP9@orome>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-3-vdonnefort@google.com>
 <20260902172436.GB1440252-robh@kernel.org>
 <aplF4NaoFk73d-c5@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3ihzba4bzldpza5m"
Content-Disposition: inline
In-Reply-To: <aplF4NaoFk73d-c5@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.60 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.98%];
	SIGNED_PGP(-2.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 114AE44441
X-Spamd-Bar: --------
Message-ID-Hash: KJMPZDQYZAG6JNPV4BDCSTWJ7S2IV2HU
X-Message-ID-Hash: KJMPZDQYZAG6JNPV4BDCSTWJ7S2IV2HU
X-MailFrom: thierry.reding@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rob Herring <robh@kernel.org>, catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KJMPZDQYZAG6JNPV4BDCSTWJ7S2IV2HU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Thierry Reding via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Thierry Reding <thierry.reding@kernel.org>


--3ihzba4bzldpza5m
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 02/10] of: reserved_mem: Introduce "ll-map" property
MIME-Version: 1.0

On Thu, Sep 03, 2026 at 11:03:12AM +0100, Vincent Donnefort wrote:
> On Wed, Sep 02, 2026 at 12:24:36PM -0500, Rob Herring wrote:
> > On Wed, Sep 02, 2026 at 11:47:04AM +0100, Vincent Donnefort wrote:
> > > Keeping last-level mappings is interesting on some architectures as it
> > > allows mapping/unmapping pages from the kernel direct map without the
> > > risk of splitting blocks which, under the break-before-make rule, may
> > > trigger page-faults the kernel can't handle.
> > >=20
> > > Add an "ll-map" property for reserved-memory regions. When set, it
> > > splits the underlying memblock and sets the MEMBLOCK_LLMAP flag.
> >=20
> > Where is this documented? Any DT property must have a schema.
>=20
> Ack.
>=20
> >=20
> > Though I'm not thrilled about more flag properties. Handling all the=20
> > combinations of properties has proven to be painful. Can this be implie=
d=20
> > from the compatible string instead?
> >=20
> > Rob
>=20
> We need this before the kernel direct map has been created (paging_init()=
).
>=20
> I would have moved that directly into the driver lend_pool.c, but then it=
 is
> probed too late (unflatten_device_tree()).

Any of the node_*() callbacks from struct reserved_mem_ops get called
prior to paging_init(), so these could be used to manually set the
memblock flags in the corresponding drivers.

Thierry

--3ihzba4bzldpza5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqew3AACgkQ3SOs138+
s6EXOg/9GV2dPaIR220HG9xlVLIy2HRX3X54lD7NjYUcMI5dH74ozC8XZ0/nWFsD
64xYzCwkpDDlOUBftQPPgM44IfYfqHh4kLJjur9/fq03owom1beg4m9zIVIw4dBw
ejIByjlSLI0Jy0xt5eQhc9VfpkfrO5/Oq44bkGKeBtuPRefpomIIcSV5C/aU8QDa
cQv6aVjg6ZR2XncJrS3BA53s5Zc9Khwv7/O/Lb85rppj7aEHj7newBIEakVNB4pU
lmOAY1Q3ckSBZ4xZkjGPGOc9eSMxdpXx7JLHPERWIXTz9qdumMHpXKT+WXUpRtgv
cYT/O3KlrdSOC8K8t/2/lXVQ3J4HKSxP3T+cxvoWmkPHSeE4w17I9+62IhX0V0n2
E3mxg820SetJTFz5VJAXV8QeheO/ZGqieBraWwvQcyDmQnqKddmQdFd8EuqKusC6
M4vCBNFLt2/XEDoir9Q+3zqiDVJW32wMboSGe4P6VPhW8ojvOs43jE1owQRXCuOS
Z3gqcw1c0fcxuvHYTEV77UI0la6H5DeWQJWJiolfJs74swqdx9Rp9sMNlqvGcHdS
dRb5ltaA1WoYYMBhatF1gLHeFoZDvcOfmzF0dSNNEUXgR6g26s3Y5bbTVkB6+7cx
hSybBcQOnVt7rYODTdksd+66a8PcOeXTzpy33pFoG9LaH9wWFbs=
=iMEe
-----END PGP SIGNATURE-----

--3ihzba4bzldpza5m--
