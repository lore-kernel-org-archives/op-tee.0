Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA65AC79FA0
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 09:19:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B5AC64545C
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788859148;
	bh=jC952bHmiBBRZiJqd17i/7x1m+YVL1dngpkL95OZce4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2WRo7ANKvY3+qYYOooIFhHuLI4XjbcZ4Ezp8td0kL4RXX9BBesb3AdM8LTPjU5XD4
	 uIt0N7myvpWiSjFWtPY6pxwjgA0oV5I24z9/1RCEISLYiUmButv30N1yd/4IypQ+Ku
	 /crsXSjxmW47PnwA4KBR3OQpcXb6bnp8ITC7vpi/GSgJlIYtjJMEV5pz5E0Xb245ve
	 3IU57q+BqyV5IRrAmVwB12xHIPvdHTAJNgun2N4dI/nvA3IGepfAlZvaYuedoUJTE4
	 68XNoccdIUTP73Zh/Se8C5dNvKo9P6miqSPCq/NLYLMVZ9Gbz5za/XfoZbFjhaJgp5
	 hQQ85KAgjpD4g==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6EF9844230
	for <op-tee@lists.trustedfirmware.org>; Tue,  8 Sep 2026 09:19:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9982D43A93;
	Tue,  8 Sep 2026 09:19:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB201F00A3D;
	Tue,  8 Sep 2026 09:18:59 +0000 (UTC)
Date: Tue, 8 Sep 2026 11:18:53 +0200
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v9 01/10] memblock: Introduce MEMBLOCK_LLMAP
Message-ID: <ap_RRSM7RBONvHaR@orome>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-2-vdonnefort@google.com>
 <ap2_926WXr7uAYVX@kernel.org>
 <ap6I1FN_2ylRzFXH@google.com>
 <ap-74AkHSGXbFCF_@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ajtkrsfbue5mdrla"
Content-Disposition: inline
In-Reply-To: <ap-74AkHSGXbFCF_@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.39 / 15.00];
	BAYES_HAM(-2.99)[99.94%];
	SIGNED_PGP(-2.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.103.45.18:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6EF9844230
X-Spamd-Bar: -----
Message-ID-Hash: YPRVS5VEH4PLMRGGOYGXEX5FF35H75B7
X-Message-ID-Hash: YPRVS5VEH4PLMRGGOYGXEX5FF35H75B7
X-MailFrom: thierry.reding@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Vincent Donnefort <vdonnefort@google.com>, catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YPRVS5VEH4PLMRGGOYGXEX5FF35H75B7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Thierry Reding via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Thierry Reding <thierry.reding@kernel.org>


--ajtkrsfbue5mdrla
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 01/10] memblock: Introduce MEMBLOCK_LLMAP
MIME-Version: 1.0

On Tue, Sep 08, 2026 at 10:40:16AM +0300, Mike Rapoport wrote:
> On Mon, Sep 07, 2026 at 10:50:12AM +0100, Vincent Donnefort wrote:
> > On Sun, Sep 06, 2026 at 10:33:11PM +0300, Mike Rapoport wrote:
> > > On Wed, Sep 02, 2026 at 11:47:03AM +0100, Vincent Donnefort wrote:
> > > > Keeping last-level mappings is interesting on some architectures as=
 it
> > > > allows mapping/unmapping pages from the kernel direct map without t=
he
> > > > risk of splitting blocks which, under the break-before-make rule, m=
ay
> > > > trigger page-faults the kernel can't handle.
> > > >=20
> > > > However, mapping the entire direct map at PTE-level is costly. So
> > > > instead, create a new memblock flag MEMBLOCK_LLMAP to enable the sy=
stem
> > >=20
> > > I believe MEMBLOCK_PTE_MAP sounds more descriptive.
> >=20
> > The idea was to have something close from NOMAP, to emphasis it is one =
or the
> > other. But PTE_MAP sounds good too.
>=20
> Could be PTEMAP if you prefer.
> My point was that unlike PTE, "LL" is not perceived as last-level, it
> should be looked up.

We were discussing the concept of enabling entire block mappings to be
removed at once from the linear map, so at that point "PTE"MAP may no
longer be accurate.

I imagine that in some scenarios we might be able to go to PUD mappings
for something like VPR (say systems with a fair amount of system memory
and we want to carve out 4 GiB for VPR, split into four 1 GiB chunks).

Thierry

--ajtkrsfbue5mdrla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqf0voACgkQ3SOs138+
s6EFrw//chVhQxMWtCxc+JK5ON8AveSiC1Dhl62Q8IhDi1Pr5AWMxC7K8li30qSy
0r+vt3im7cyLAkLE4+kAZXtHcCV1288tZZErEnuotKkDkGDaDExBqr5yHlPseVq0
2ekvvxz7mSRh5Wfxn5Tq+MYQcwUYACknVRhGjuplsa05oSZA7GWbViEHFVP25/Pq
14BkCYqXXj/NfSceq84ukKSePfpEG9Jrmnl7Ey73eyGHNeRvziLQC7qd9MuHwiqp
Jn9Geb830b3ufqnZK23k5BuEp/+lAGTkflZGTlEM5A6yTIEnvfVtpimFwGtHret9
L0HZ/xg087+Wj7Kdgu/VjdftAzj81qqnKT8dpnGWH4SwsTLtcRDqxpNZatKlVJsF
NJG1Q8yBEtB+KIIiSK/00K2im6bSroJoGbTljdLQVi/hjBkQuDHtugvyyycXYc5y
cLPWS6i+0eG+IWvM+wGH7zWT9kvJeyYWh8jH4qk/J0sTkVlz5IY25AOerpGGdx4S
slR0PSPzLmGm/uHHm6PpuJK8vjqKJkGmsLiXQ5XkrUgmOG8EkWHG9Uzx358zDsQg
AYe3yJ0IiuCS2fketV+KzHy7VqFU3tC9kgkyrIO3PJSJLSVSeTVFNJ3WTUJTEBBb
ztr3XvA0Jm7feoWXZzfW9fwBYnq+5ey+M+KDQ6qsCZGpgY7FCeo=
=5bgM
-----END PGP SIGNATURE-----

--ajtkrsfbue5mdrla--
