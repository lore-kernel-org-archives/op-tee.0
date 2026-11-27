Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E0606A31C
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=D0ynKEue;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIZ2PgCC
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 25C145036A
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795781723;
	bh=Sx4ywZBhiyullZrUtgY82SttR0yq7G5O52iMdmFQsBE=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=D0ynKEuecpQb7pTxnDNwQcynLrCznaCR0Lap6D7oJZv4DYEIszX6pIEY5Bzk71Lb8
	 3FXmqhc8Lb83emoiBvrbig4KYb5moKQvNdt4CGcyRqjyLCBJaXuMSd4CiRxrw8MSAg
	 7A+d4VmQoTwT8SC92R4g0BNKTM8Jca8fwaene/LcVNBNCb6pL4ULFA8ejn3RxDCCNj
	 5Q8yuk7nKygIC6hGn9z6NVZRpcsXZpCWOWFyf63xF+it6AIF4rmVJcbKrLXVpbm836
	 R5yXcvLO0aqjVlaWEK6I47NNjHP2KVt1gy5D2tUlCk7pp8QDKfWBR+bY+zVV57bJtk
	 NLkDBCu6vmzKQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0D1A750360
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 12:14:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIZ2PgCC;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 858874049B;
	Fri, 27 Nov 2026 12:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEA71F000C1;
	Fri, 27 Nov 2026 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781694;
	bh=tM8SXc9WGf6iPLFbf68oH/I2l2oZdLX38iKCsqiqJkY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=aIZ2PgCCSdBh7XmzcJDpf7YgWkZ8/PzA4YV/zcGM11or/4gPkPdmyzwzeb9vzZBJU
	 2zInaHrgLawwRJSVDG3/2z8/A/J4ua/wchlgufVddjLb2qXuTzOsHq19DMrOjjlYGo
	 y/d6vI+nO6hHY28DEzoq5C0Ugv4xhzLEPQkjO/3kYBlbt4wFZbQtZtG6pM2qMSnsNm
	 mqIcvp7NHajVYr5/7FUdPyuZAGi6I9T5LKUUwGzQz13mMpGOZSC6LPs/5t84y60w3O
	 uVvR8ajJcLWMClOKml8jHc6pnzWmLQNzRta+n958LFQOaxkvMwk82yGQjzF3k9H3W1
	 hhLpTPbUqqsGA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 5/8] dma-mapping: Introduce lendable-dma-pool
To: Vincent Donnefort <vdonnefort@google.com>
In-Reply-To: <20261111110738.872947-6-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-6-vdonnefort@google.com>
Date: Fri, 27 Nov 2026 17:44:23 +0530
Message-Id: <179578166371.172025.2529658384273765570.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=sumit.garg@kernel.org;
 h=from:subject:message-id; bh=Sx4ywZBhiyullZrUtgY82SttR0yq7G5O52iMdmFQsBE=;
 b=owGbwMvMwCV2RWpxpe9rmzmMp9WSGLI5S3Q33F0lUXiz/xDP3tOl0RxvDeZkfjTJm7Dr88pGL
 puQ1PbbHaUsDGJcDLJiiiypX79N2yb0rzbU6gQPzBxWJpAhDFycAjCRZAZGhm7vDu0tNkxffpat
 f6wmaad/knepippM+rqdy3k+Zk3OU2H4X/fAReDjgWa2WUuZ9tT9XZR/OTpDcP3+JQtvMH1bE16
 pygYA
X-Developer-Key: i=sumit.garg@kernel.org; a=openpgp;
 fpr=65F5F696B612FE7D553AC80CD41AA3794DEB3C9C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.94 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.24)[96.43%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31:c];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0D1A750360
X-Spamd-Bar: ------
Message-ID-Hash: 32GOR2BVXGKFDF3SZX7J3ZD5ZXERGTBJ
X-Message-ID-Hash: 32GOR2BVXGKFDF3SZX7J3ZD5ZXERGTBJ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/32GOR2BVXGKFDF3SZX7J3ZD5ZXERGTBJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> On arm64, when memory is lent to secure world (e.g. via Arm FF-A), fatal
> CPU speculative reads can still occur while it retains a cacheable
> direct mapping. Introduce the "lendable-dma-pool" reserved-memory CMA
> driver with dma_zap_direct_map() and dma_restore_direct_map() to unmap
> pages before lending and restore them upon reclaim. Devices use the pool
> via "memory-region" or "linux,cma-default":
> 
>   reserved-memory {
>       #address-cells = <0x2>;
>       #size-cells = <0x2>;
>       ranges;
> 
>       linux,cma {
>           compatible = "lendable-dma-pool";
>           reusable;
>           linux,cma-default;
>           size = <0x0 0x4000000>;
>       };
>   };
> 
> If no lendable-dma-pool node is provided, the API falls back to
> can_set_direct_map().
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

-- 
Sumit Garg <sumit.garg@kernel.org>
