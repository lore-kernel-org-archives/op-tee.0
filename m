Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2401AC982FA
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 10:57:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 51A1545216
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 10:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790074639;
	bh=hLAKKSqlZC0lD4LDYt9Vm1n6yow0jFao9TVHhrHqPz4=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=eKiK8Qaeqq9+E/1XgYPMg40pXsD54dCyh/PFQSC5+YfmOAirNhIQrBEkoQamwJ2BL
	 V/0KA7dOkWm7K/d0VbBRP7qnsd2G+sFX1jr9nCmU92NIt1k0o9jrmMRc724D33toX/
	 1T4mCzIgGZhBGfROxWy+vD2ARly5YJ/M1a7Y1m5MAcLRtB5Y25DywjaRHF3GcQg/EB
	 T/HLdEEgwhV0SZgxRrX6rstV5e+KRclUDGH+oAMnIINS9sDIfEGe3nAPL3/lve21ls
	 kV/rO3O2nybNLKWOZELvmVFPWx/Pzv9D+WxHWWFQ21Hrwa4kFAH0iKeHkdRNY4biqU
	 7tLXCiqBMvzwQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9BBC144D8A
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 10:57:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rq2lHonw;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2AC4B601F7;
	Tue, 22 Sep 2026 10:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502211F000FF;
	Tue, 22 Sep 2026 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790074630;
	bh=UB96pS2lXgKbRferXQ6MVjY4lTebWD1sRvTJ4mcNWqk=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=Rq2lHonwYPyCf0LLYZb2zrrKIpjLsvWXDigwiH5+Vfw1oOnTbWsoaDFGlnn8yAkKl
	 YBtUcTcqQ6S8bDc3xrwMdxRk7g9MqnsSrnTti5Dv9matZxJl+3v37KxReqYELKuHDT
	 A1MxyhZaHxRuSiSDIeTSL1yOggks0CmlBEhGuKS4phKSLfzIhy3hGLXx6xuX+3To7F
	 T9x32aqA7aV1zpniyrAHl0cauBnGJ/2lkq80honi2zzl31bFmeIdOGlZPLa6tk45uH
	 Jpok/CVRDPvfYy5nB+eP3YDsKHSCeV01tKRv2gnUbIm2pKCzR/BdcVSsa6x9ymPLQd
	 cuJMpvaYGHv/g==
Date: Tue, 22 Sep 2026 12:57:08 +0200
To: Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com,
	will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
	sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com,
	ardb@kernel.org, david@kernel.org, danielmentz@google.com,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
Message-ID: <arJcN60nagFKXj2Q@orome>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <arIYtjmSKCs14SqO@sumit-xelite>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2bniudpfuafwp74"
Content-Disposition: inline
In-Reply-To: <arIYtjmSKCs14SqO@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.60 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
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
X-Rspamd-Queue-Id: 9BBC144D8A
X-Spamd-Bar: --------
Message-ID-Hash: BFSU26MBBR6MBCRWO5BAOTC7CHIGKWYK
X-Message-ID-Hash: BFSU26MBBR6MBCRWO5BAOTC7CHIGKWYK
X-MailFrom: thierry.reding@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BFSU26MBBR6MBCRWO5BAOTC7CHIGKWYK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Thierry Reding via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Thierry Reding <thierry.reding@kernel.org>


--d2bniudpfuafwp74
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/8] arm64: Unmap FF-A lent memory from direct map
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 11:27:10AM +0530, Sumit Garg wrote:
> Hi Vincent,
>=20
> On Mon, 21 Sep 2026 at 12:00:42 +0100, Vincent Donnefort wrote:
> > This series is a follow-up to the discussion that has started here [1].
> >=20
> > When memory is lent to the Secure world via FF-A, CPU speculative
> > accesses from NS to the lent pages can still occur as long as it retains
> > a cacheable mapping to it.
> >=20
> > Ideally, lent memory would be "no-map" but that would mean giving up
> > MiBs of useful memory, so let's try to do better with the help of a CMA
> > pool.
> >=20
> > On arm64, modifying the direct map at runtime is generally restricted
> > because the linear map defaults to block mapping and splitting blocks at
> > runtime may trigger fatal page fault, unless the CPU implements BBML3
> > or the entire direct map was mapped at page granularity from boot.
> > Forcing last-level mappings system-wide incurs a severe penalty we want
> > to avoid. Instead, this series introduces targeted last-level mappings
> > for designated memory regions, along with the "arm,ffa-lend-pool" CMA
> > driver to manage unmapping and remapping on lend/reclaim transitions:
> >=20
> > 1. memblock:
> >   - Introduce MEMBLOCK_PTEMAP to force PTE mappings only for a specific=
 region.
> >=20
> > 2. set_memory infrastructure:
> >   - Introduce can_set_direct_map_range() to check if a specific address
> >     range is mapped with last-level entries and can be modified safely.
> >   - Introduce __set_direct_map_*() variants that bypass redundant checks
> >     when the caller has already validated the range.
> >=20
> > 3. "arm,ffa-lend-pool" driver
> >   - Introduce the "arm,ffa-lend-pool" CMA reserved-memory driver, which
> >     unmaps pages prior to lending (ffa_prepare_lend()) and restores them
> >     when reclaimed (ffa_lend_reclaimed()).
> >=20
> > 4. Optee support
> >   - Hook OP-TEE dynamic protected memory pools to "arm,ffa-lend-pool" f=
or
> >     both SMC (via DT memory-region phandle) and FF-A (via
> >     ffa_lend_pool_attach()) transports.
>=20
>=20
> Thanks for your proposal in trying to solve this hard problem of
> unmapping pages from kernel linear map. I remember discussing this
> problem last year at LPC too.
>=20
> Have you had a chance to look at a more generic MM proposal around this
> issue here [1]?
>=20
> One of the major concern for me with your proposal is tying the
> protected memory allocation to fixed sized platform specific pool size
> based on DT. Then the cost of granular mappings/unmapping if the
> platforms choose to enlarge these pools.
>=20
> As you maybe aware one of the major use-cases here for protected DMAbufs
> is the secure media pipeline use-case which is memory intensive
> workload. IMO, the solution proposed at [1] seems to address it although
> people have flagged rough edges there but should be addressable.
>=20
> Can you try a port of [1] for arm64 since the author did all the work
> with x86 as reference?
>=20
> [1] https://lore.kernel.org/all/20260726-page_alloc-unmapped-v3-0-6f5729a=
a9832@google.com/

There's a lot to unpack and I'm not sure I fully understand all of it,
but from reading through that series it seems like the primary use-case
is to allow things like alloc_pages() to unmap pages from the kernel's
linear map. However what Vincent is trying to solve (and there's some
overlap with the VPR work on Tegra) is how to remove pages from the
linear map that are part of a fixed carveout region.

I suspect there's some overlap, and we might be able to reuse things
like the folio_{zap,restore}_direct_map(), but given that we already
have a set of struct page objects, the two approaches seem to be fairly
orthogonal at a higher level.

Thierry

--d2bniudpfuafwp74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqyXwEACgkQ3SOs138+
s6Fsgw//dlQUJrbDWiXuqxe3GRzKuh4gFS8vuMFfMkbYyeXhcsFi2RHH2NVZ4O/0
7E51l7U9VQKmCvcjTzd4+9m47q3h2TskmNQsMA1vWWQDFKOWrbDw2yL11vSqZ90D
hcquJSGds+Gu8eaJFKONeIxfUmuGawtaqTl1JtehYNaN6wur68zTbhS/dkDD4OrZ
9MCyUlhaLPSfadqpBQSLucmYM5GhSQikGcqIJMIYkP7kd3HgWfr0XlqW1+tN3PjO
MzP9sBX/LMW6HrsGa1CJNMRSaEhldJ9JFoNaIFyIBiN0+L7UBUyFlByNoFuatUqn
NAQsB90d2EuSmo5zz5zmeuoNGhc4k0jO6i8YS3zVmeL/eIWg1ZbifIm7FTaNB8iX
DMs9aq3ovYnbfGOpOOni1Z5BWz6LD4+2WG7bnOVXhKIWE6wOLG8cW/nTEt6hZ/xA
6wY+TFrZMoIRCOREqxTbz+TImFkTuF8OS4ZIo812FNBgUcGQu9nfbTzrebUs9pGY
bjieIqRLmuyXIXHDayd1NcnmuIxN1OgwzIJO5CQvG6yCJ1sk6DVrgODmKed2Nxoh
vRm9IRG6yWGxpf3DeQmUvHd4ZRogSpRfQ3713PrxjnIj9WUO7fs8yGq6F5xHrmMb
FlXPgJng4yDFZ0eb9bKte5N6yvKoTI8e4jsUD1NL7y/YNh6lWy4=
=42dx
-----END PGP SIGNATURE-----

--d2bniudpfuafwp74--
