Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A740606A32A
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=o2dy2e5O;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y44GakXv
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8BA1945528
	for <op-tee@archiver.kernel.org>; Wed, 18 Nov 2026 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795033478;
	bh=PvkegSM9pdmN3qDdgBNlTRoStwyUjiU3iIMt+V/URT4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=o2dy2e5OMvYbjPvSZd7wNzAfn2ycwQiznmX1ev91niiZr/Rg8Kb3nHXRm5ku4uVCI
	 6dZEcnN9CJU9WMmFnkSIpxBjGDx/DzR0F0x0CKLoJ34G6O9o8aimapra2XiWpJqM42
	 /bpqTVpf6U8XKNOs6jYMPr9mqy8Q9NUkdiFbTpngybsHeetKIfS987d5B07zIlYNfa
	 6T/lCTNs4r2ek7t+m+8PFGwIZxVh360woisQhBmafcZbV9F07pTVuDtFTZukqazAIs
	 TnLGQUTPzJnr6m4teQSoHvB59xj7tm7ynH0N/oHQyf/diQdDCCGutJROctplgRxJsI
	 1a+7P8sa9oysg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CFD6945230
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 20:24:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y44GakXv;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2300C432D7;
	Wed, 18 Nov 2026 20:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B7B1F000C5;
	Wed, 18 Nov 2026 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033472;
	bh=FxLntHqNI1+h3sJPoaAEyO+/hQb8YRhU4FckPwMqXOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y44GakXvG5GHKA31JnnJ8TOHTL4DJuDPzANJjJWG60MjNDOfyRHhJIm8vJ9IDSIev
	 kJKebboMkeglmR/Z3kWmpAzBb/AQDqIH9Izq2L/2oEbS6SEXi6ZsaYaQUkJZjqCiEE
	 /cEFzHQ3SGAkusbdtG1G+mq2iETbisKSIMwmFp2X1YKr62QeB8t2Omdt7o8wYE65tf
	 74JyKMlIkz2XlLsmuBGfkZAol4hWxO6LXScQh90VN9uTyIGALwX/totrf6ZkzLWXcR
	 OAC91HP6t82IYLn0SO6X1Zc4Z9eHlbMjrylVDrjpOpZr9CRq/RJ7Wgclipi8eTEcKP
	 JLUuYHqvl39TQ==
Date: Wed, 18 Nov 2026 14:24:26 -0600
To: Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v3 4/8] dt-bindings: reserved-memory: Add
 lendable-dma-pool
Message-ID: <179503346493.801350.7313588345506554121.robh@kernel.org>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-5-vdonnefort@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111110738.872947-5-vdonnefort@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.59 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.09)[95.58%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CFD6945230
X-Spamd-Bar: ----
Message-ID-Hash: 7YJBZKAQ5EC6IBMLWXGCQCFJVBKWJK73
X-Message-ID-Hash: 7YJBZKAQ5EC6IBMLWXGCQCFJVBKWJK73
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: krzk+dt@kernel.org, rppt@kernel.org, jenswi@kernel.org, danielmentz@google.com, akpm@linux-foundation.org, sudeep.holla@kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, ardb@kernel.org, catalin.marinas@arm.com, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, will@kernel.org, robin.murphy@arm.com, mark.rutland@arm.com, conor+dt@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, david@kernel.org, devicetree@vger.kernel.org, hch@lst.de, thierry.reding@kernel.org, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7YJBZKAQ5EC6IBMLWXGCQCFJVBKWJK73/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: "Rob Herring (Arm) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Rob Herring (Arm)" <robh@kernel.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Wed, 11 Nov 2026 11:07:34 +0000, Vincent Donnefort wrote:
> Add bindings for the "lendable-dma-pool" reserved-memory CMA pool, used
> to dynamically unmap pages from the kernel direct map before lending
> them to a secure world.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> ---
>  .../reserved-memory/lendable-dma-pool.yaml    | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/lendable-dma-pool.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

