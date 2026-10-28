Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D38F606A31C
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=whTs7Zkb;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EceVUvxL
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C86D545386
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 17:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793207359;
	bh=BD6qRhBmeWVIsbnwZPKsdd2t+THxDGP42Y9YBySpvHE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=whTs7ZkbOVmeT8mQuE5fLbCx9B3X2qCtlDCfvWIGrIIn6iStD93iuS3EesEi2+rUu
	 z4G8vIBJqaDoFDMg0+qrb3tpWX6bSMnKARx8AQs52ZEex+oYbQDmGQKFkd9Do9P7v4
	 sGR+PJ41HBo4izFWQsfTyaSrAGJZEECM5vzfNjY6BPYM7l8j/Z3ARVlyPstChqrGuz
	 owBJXAhQGY4Jdec20VVHnXO6AspJshJQvNTDjoF2si+6rA/XKFPjwGXfghUGdjvza6
	 sgREDDmW3tNGHt9aRJVwUTuEL2o9WQrNCr1GPvWWENgxBQaWrveJyIkm8zdXn7mdOQ
	 xJQEyvhcDt/pQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2587C444EA
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 Oct 2026 17:09:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EceVUvxL;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 73ADD600C8;
	Wed, 28 Oct 2026 17:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17901F01828;
	Wed, 28 Oct 2026 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793207340;
	bh=mzc7Hanv0CDK4THhGHtewy5AYoBUPo6jlbuGdSqeuHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EceVUvxL1OnZids3GRqeq1btRudotGLxGnTzu4CsVMZohND9PtMu9iepxejI6Lc4e
	 lCb+8Gpj01vLylCaE8zNKBJpXIXHsq8qJkTbTCuptNXWEyA7zDptDe1LKby7gYWd+U
	 5pNOxKOAOcEGtsuqqVSOGWGRKrlDwlSrlfvaAfWUMg+Df399cbWJPxKeiRU9M6em+3
	 YT4JnocZn3WzwtlbylfValFVt7mnMvqooGXe7CuDLeahKeCebD01bLSFFfhq+la3dv
	 nkl6EQigdTw4PjDi+Wp+Pdd5BkI5DtlSMnt+fUDuONmDt2aat+HgAm3JXLIi4ChCp5
	 X7T1w9wWUe4eA==
Date: Wed, 28 Oct 2026 19:08:50 +0200
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v2 1/8] memblock: Introduce MEMBLOCK_PTEMAP
Message-ID: <auIsIp-nKJokYmry@kernel.org>
References: <20260921110050.3977591-1-vdonnefort@google.com>
 <20260921110050.3977591-2-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921110050.3977591-2-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.00 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2587C444EA
X-Spamd-Bar: --------
Message-ID-Hash: C3FOX3472ROMB67UEZQPJ3HM3QLD64DR
X-Message-ID-Hash: C3FOX3472ROMB67UEZQPJ3HM3QLD64DR
X-MailFrom: rppt@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org, sudeep.holla@kernel.org, jenswi@kernel.org, robh@kernel.org, mark.rutland@arm.com, sumit.garg@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C3FOX3472ROMB67UEZQPJ3HM3QLD64DR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Mike Rapoport via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mike Rapoport <rppt@kernel.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Sep 21, 2026 at 12:00:43PM +0100, Vincent Donnefort wrote:
> Keeping PTE-level mappings is interesting on some architectures as it
> allows mapping/unmapping pages from the kernel direct map without the
> risk of splitting blocks which, under the break-before-make rule, may
> trigger page-faults the kernel can't handle.

Let's be honest, it's arm64 :)
 
I believe that some powerpc variants could use this too, but they don't
have break-before-make, so either "some architectures" or
"break-before-make" should be rephrased.

> However, mapping the entire direct map at PTE-level is costly. So
> instead, create a new memblock flag MEMBLOCK_PTEMAP to selectively apply
> a PTE-level mapping.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  include/linux/memblock.h | 18 ++++++++++++++++++
>  mm/memblock.c            | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index aa845f488327..13263055996d 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h

...

> @@ -285,8 +289,16 @@ static inline bool memblock_is_mirror(struct memblock_region *m)
>  	return m->flags & MEMBLOCK_MIRROR;
>  }
>  
> +static inline void memblock_warn_invalid_map_flags(struct memblock_region *m)
> +{
> +	enum memblock_flags map_flags = MEMBLOCK_NOMAP | MEMBLOCK_PTEMAP;
> +
> +	WARN_ON_ONCE((m->flags & map_flags) == map_flags);
> +}
> +
>  static inline bool memblock_is_nomap(struct memblock_region *m)
>  {
> +	memblock_warn_invalid_map_flags(m);

I think it's better to check and warn when setting an incompatible flag
rather than when querying it.

>  	return m->flags & MEMBLOCK_NOMAP;
>  }

-- 
Sincerely yours,
Mike.
