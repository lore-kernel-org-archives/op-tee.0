Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2903EC79F82
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 09:27:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 554B244F88
	for <op-tee@archiver.kernel.org>; Tue,  8 Sep 2026 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788859653;
	bh=Ser78ur/Hp5OvdMUy5OZ98mktqdsEMDg1PUdcYQiAxI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=vGkoQaB2yDAsGSq1Si9PsjxloOYNU/4uqHW9arom0GUa2ZPVmkxNGZB96gytyHka2
	 Ykw2JQ0X9hJ2AOiJCqtBzjG2AxJemO2LzBAMSttifdehSopt+fZ+L32ZW5tdbFoRxe
	 mArIBqUPY1aYWkZvble6jH6wmsYi8AUyI7naNZI8G3d0odTPLSNSoMiE8Dv87AOS2/
	 s4hPPjzxBFy7n2vCi2A47YDuhVySi3IWoNOIEvD+c9UH9dyflVkDVF6T7/T5NTkHAo
	 nHB0SGtqKjiRQqcgE1R1L4fN0jj9qRPEgH6ypmqnuqIUa36biQKKHn5gZSdUFcRepO
	 kivyUDLUTRRkg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BBAFB44230
	for <op-tee@lists.trustedfirmware.org>; Tue,  8 Sep 2026 09:27:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PaF/fX3J;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F734601DB;
	Tue,  8 Sep 2026 09:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6661A1F00A3A;
	Tue,  8 Sep 2026 09:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859646;
	bh=e9S4ei21MKUHBJjiz+ftl+IF+EunK9f6ULHxYAUuV7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PaF/fX3J0DRupK9yZ8ExzCVv71/WO0ICJ28j+TyvKhtF/hisGFrPp6LKseCIVXv/Q
	 Xv4AshCcIwMNuKbb8+dxto3+mGjz5rMUQq/QJ2IgqPw+dooCVV2iDULjBmGXzLbgLD
	 rOSVB53nuuWeM8HFhRcmKqJ/CyAipkyYFgAjsw9QpuZe6RgVyP8fpuVv9HwLu6uVex
	 jfAohxfE8UZsnlwsbHyRf8t1dccvI1hCQ0fCo8vMvs6meWiOVcd2Pq0AedZDxTHTkm
	 5hC6JTFuW4s0Eu1Yb+f0+8bQC6rJCaK0bT+r6tHPo6xivVUvui4MB6MkT/727ZDg1r
	 unFw927J5uwSA==
Date: Tue, 8 Sep 2026 11:27:23 +0200
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v9 07/10] arm64: Implement __set_direct_map*()
Message-ID: <ap_UYjvpf1sXBXE-@orome>
References: <20260902104712.2399797-1-vdonnefort@google.com>
 <20260902104712.2399797-8-vdonnefort@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="43scnsiptq6igc3p"
Content-Disposition: inline
In-Reply-To: <20260902104712.2399797-8-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.60 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SIGNED_PGP(-2.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BBAFB44230
X-Spamd-Bar: ----------
Message-ID-Hash: F3AGMFTYAXXU7YE3DJZ42GWV5CU7PD5J
X-Message-ID-Hash: F3AGMFTYAXXU7YE3DJZ42GWV5CU7PD5J
X-MailFrom: thierry.reding@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F3AGMFTYAXXU7YE3DJZ42GWV5CU7PD5J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Thierry Reding via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Thierry Reding <thierry.reding@kernel.org>


--43scnsiptq6igc3p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v9 07/10] arm64: Implement __set_direct_map*()
MIME-Version: 1.0

On Wed, Sep 02, 2026 at 11:47:09AM +0100, Vincent Donnefort wrote:
> Add implementation for the unsafe functions __set_direct_map*(). They do
> not verify for can_set_direct_map() and expect the caller to do so
> beforehand.
>=20
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>=20
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm=
/set_memory.h
> index 1a37f4ef130b..080a40846bbe 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -16,6 +16,10 @@ int set_memory_valid(unsigned long addr, int numpages,=
 int enable);
> =20
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
> +int __set_direct_map_invalid_noflush(struct page *page);
> +#define __set_direct_map_invalid_noflush __set_direct_map_invalid_noflush
> +int __set_direct_map_default_noflush(struct page *page);
> +#define __set_direct_map_default_noflush __set_direct_map_default_noflush
>  int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool va=
lid);
>  bool kernel_page_present(struct page *page);
> =20
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index c59ef17eb0d0..28adab0edace 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -294,28 +294,38 @@ int set_memory_valid(unsigned long addr, int numpag=
es, int enable)
>  					__pgprot(PTE_PRESENT_VALID_KERNEL));
>  }
> =20
> -int set_direct_map_invalid_noflush(struct page *page)
> +int __set_direct_map_invalid_noflush(struct page *page)
>  {
>  	pgprot_t clear_mask =3D __pgprot(PTE_PRESENT_VALID_KERNEL);
>  	pgprot_t set_mask =3D __pgprot(PTE_PRESENT_INVALID);
> =20
> +	return update_range_prot((unsigned long)page_address(page),
> +				 PAGE_SIZE, set_mask, clear_mask);
> +}

I think these would work quite nicely if you rebase the series onto
linux-next, which contains the patches that add the number of pages to
these functions.

You can then keep can_set_direct_map_range() from the previous patch and
call that from the set_direct_map_*_noflush() functions instead of the
simple can_set_direct_map() (which is a shortcut path in the _range
check anyway.

I've used that locally in my tree and it seems to be working just fine.

Thierry

--43scnsiptq6igc3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmqf1PsACgkQ3SOs138+
s6FbJhAAq7rdW+WQpw2aS+4U2xEYrsJtjGRTj94QjexotpKa2p3eyw0SLesuF9zU
+2u/FbYsoxer4kU3QDhJC96FhLS9GwWuldwvOy3tXj+Jgim+5vBbEqynCr0nEGqg
nQCYWjZXMgSab6kJdxEjcywIXZ/noCDsK2bqF5PN1dz/4lhTVuDGHaxmbf3yV/oR
TebCIeTN5gSrIxZLAC9yWHu+1QVl4v5+06tJOJdtuIIiS+V/AKr9MFHxKRw5O4st
ElIm7uM6goaowuUnByavL3kZ1Vm56bc8k2rDqQ/7gcqoJfqUfqH0jPxAzpLsscQO
vXxM6OoEqPLB0bFou1KWnLPvxjQIAtjWjous+w7QTthjSgnwkbsW5UcrOZWw9o1Q
VPc3KGvB/1djAVyBUmV4I00sfrvwqqS4wMAcXkffhZo9likAZCQJG3dNp/su464N
X9aN99o2iMMqCnOzSedwMh9t7i422FTUpUMl4m+hCnqIHqVG7VUVI32s2nx1S5n2
5RBZckCoNgL2LgG1tgsnTpl3My/l+AhW3OwRTqdXIA/b8h6+/DonZVNIoeAcAEeu
0IYdOPIOnagFiYOCWzkMNEl6ce/Vd2AOl6JQ3ZEaIdS2FUMumXbdnbtLftgj9RtP
BB16Tsr/sbJb+A3+9MeoYl9ASll6PDapN/3qICYTCK0NkSRK+S0=
=54Zj
-----END PGP SIGNATURE-----

--43scnsiptq6igc3p--
