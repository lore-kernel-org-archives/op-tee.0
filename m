Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60244606A31C
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 12:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=EJpa9Vp2;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtt1283S
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BA30345521
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795781752;
	bh=Y+fnpb+6sgyx/TICAWkXBLbJdNddcf3dmWbm5GHNfSA=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EJpa9Vp24vMzhoZFzU75WYuIcFiQKLuLnDEbIyHve7PEJ6MonHDf4lvtYURmmjX+D
	 c9o0PGPeNWiqHfHmru21Rr+H9vNP49eyX2o0Y2B7YtSk/DkzvntBsurNPInJyyqMYo
	 HI3FeHYaweh6WI0pUk83FPU/Y2ZGM9xQcQjk99kVy49jvJuf3MW6gaFPolEiF8k9B4
	 GLWL9Yq6y9Dc89Y8b+hFrXhVuPZPLXsRmnMUsrTTNxYjK9TI5PrsLb9HHoEqy74pYG
	 WYOE18UFq0aBz7sFKzbuPE2pDr7MR2Br1e4Fwl3P5LT5teGGdB7nkkwchKw/QmIoFl
	 AJbgrooGleIYg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 497DA5035C
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 12:15:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dtt1283S;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 893F76254E;
	Fri, 27 Nov 2026 12:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B0A1F00919;
	Fri, 27 Nov 2026 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781703;
	bh=iM54K9orOriSVeFYm8Tg3Py4IYE5anR7lg79PbJmHes=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=dtt1283SmVlMJDALB8+fBXMf9DpoJ/7duRnkVxmjg9BRCMUmL36GBysLxMuEUnc6L
	 NW05HR0AteyNXiALdjX0kNEoQS1iGQV3dNU2074CQ6xn5Qy/KAuuQKK7ZgL/v0zglo
	 aQnlcYatWQ/16jLUmzBmCzBq16QBDXkb07IHKc9bPo48Pmn5HEWsuSw3yDu8lDQh15
	 4vVAQNpU+4801ZTfCfRhqVwKEc6VoUKRlrZfCLY1/mdxwi5sjFq5uqSTfpq/rI+j2h
	 t1BrO1KSr6StxWy2CHoeWL3nUFdig+6cQvltOqpUS/feBqaZmViFLklXQ+sMzB/znc
	 Ti308wFpeHxyQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 8/8] optee: Add support for lendable-dma-pool
To: Vincent Donnefort <vdonnefort@google.com>
In-Reply-To: <20261111110738.872947-9-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
 <20261111110738.872947-9-vdonnefort@google.com>
Date: Fri, 27 Nov 2026 17:44:23 +0530
Message-Id: <179578166371.172025.1170602724631713692.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=469; i=sumit.garg@kernel.org;
 h=from:subject:message-id; bh=Y+fnpb+6sgyx/TICAWkXBLbJdNddcf3dmWbm5GHNfSA=;
 b=owGbwMvMwCV2RWpxpe9rmzmMp9WSGLI5S3Stv366/n7plf8Ot9/EukWzz7haXJDOvVWsU4v9/
 t/qn+eWdZSyMIhxMciKKbKkfv02bZvQv9pQqxM8MHNYmUCGMHBxCsBENjcy/JWrfuZ8cN60h88P
 3OLZJalc9e5m+ebZ/w/xd75snDkhw3oaw1/RFY9W6+5S/7WJ+YNH/jKlWJfFzIsSbMtevzAJ+Ln
 f1o8ZAA==
X-Developer-Key: i=sumit.garg@kernel.org; a=openpgp;
 fpr=65F5F696B612FE7D553AC80CD41AA3794DEB3C9C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	RCVD_IN_DNSWL_MED(-0.20)[172.105.4.254:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 497DA5035C
X-Spamd-Bar: -------
Message-ID-Hash: HEF4ESJPDBUE5HO277YA4E7AA67LKBPD
X-Message-ID-Hash: HEF4ESJPDBUE5HO277YA4E7AA67LKBPD
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HEF4ESJPDBUE5HO277YA4E7AA67LKBPD/>
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

> When memory is lent to secure world, fatal CPU speculative reads can
> still occur while it retains a cacheable mapping. Use the
> lendable-dma-pool API to unmap pages before lending and restore them
> upon reclaim.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Thanks for all the rework, the OP-TEE changes looks good to me. FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

-- 
Sumit Garg <sumit.garg@kernel.org>
