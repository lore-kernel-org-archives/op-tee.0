Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8605B606A31E
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=Zt6QdqVr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrGEsf9R
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D9F585035E
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 12:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1795781692;
	bh=H72B6Re7Lfo3dYJpngqffII6YfaUb4iqb0oxwd+0b1c=;
	h=Subject:To:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Zt6QdqVr+wf4qKsytSmBklvi7GNcKA6Ue6NJBrjR6y8QufpIK8XC5a5n+7OMG6yPI
	 00WPYtvxPB5W6/AY3ga2EPxfGUT2vhJFiAF9DbwJ/DSccQa0gBPt7Nj/twZNBLEa4w
	 cq/M01kW30u1QBDlaN/TrVQ8Z8J2/FwIlTfCtk32J7pJaxjSVCMctwL7Oc9cR5hhkb
	 Zm8Y7QDtWX2I2kFlq4uHzCed/nh0fx1U1fPZ4pLAC+o9q9KRp3NImjiytIuR/OF4KT
	 wppxQpDLS1BnvNFRJnhE7mpclKeXzyfGxxseKGf9Nq5IQzwh6Wk6DtHyW3Ji3vNyMR
	 Wz3XdUdHrw5wg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C303844F32
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 12:14:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrGEsf9R;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 247854187D;
	Fri, 27 Nov 2026 12:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA841F000C1;
	Fri, 27 Nov 2026 12:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795781685;
	bh=3w20wn8ciMIi314K9ZKRgL922tIUAQ1fVj1q7jFt11I=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=JrGEsf9RGSAi95mThpsPZiqwBb8CPAROQvgPolW2qIJ2xXEk5VJKACzsGFeqPtsMk
	 12STunPm5NpI3riSYWarempFNzU3lBP52Nu9ASxRNvvlCt5tbzD/Hw69Mx3qSnEwze
	 Tixfxfhgo095X1TISXxrvq2kWiGqVrUKHT1E9npI8SB7mKrHS/umAuWt+Hx6/XLiPW
	 CxkomSEuUSy3wQR8uAzWuBAWKwnbwVNUjdHwpE1WFY5jnYft8hPuN8KnQgWOuemKqt
	 DFUFi5a6yGXRGOdEjpfbF1YQa23ZPwEuA+i7DRrh/a6UUpOg1fAbG/YbyqIeU2kgn0
	 fWfCj2t0bN5wQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] arm64: Unmap FF-A lent memory from direct map
To: Vincent Donnefort <vdonnefort@google.com>
In-Reply-To: <20261111110738.872947-1-vdonnefort@google.com>
References: <20261111110738.872947-1-vdonnefort@google.com>
Date: Fri, 27 Nov 2026 17:44:23 +0530
Message-Id: <179578166371.172025.10770561998032628043.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=sumit.garg@kernel.org;
 h=from:subject:message-id; bh=H72B6Re7Lfo3dYJpngqffII6YfaUb4iqb0oxwd+0b1c=;
 b=owGbwMvMwCV2RWpxpe9rmzmMp9WSGLI5SzTqKoX2v6poOjM7Tepq5Ht5my8u93hEPXlY96rGb
 llxtjyvo5SFQYyLQVZMkSX167dp24T+1YZaneCBmcPKBDKEgYtTACZyuYeRYavT7sI3m/SebpyX
 onf6hgPXAYGpWw5ElojkKeqEbHUztmH4w+Vd9c3uxqQ7AhKnb8xtPv11xZuQkk5zO+20IpOs84t
 N+AA=
X-Developer-Key: i=sumit.garg@kernel.org; a=openpgp;
 fpr=65F5F696B612FE7D553AC80CD41AA3794DEB3C9C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
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
X-Rspamd-Queue-Id: C303844F32
X-Spamd-Bar: -------
Message-ID-Hash: TJFDJXFUVXJJCY4HU545WSOZUSSWLUEC
X-Message-ID-Hash: TJFDJXFUVXJJCY4HU545WSOZUSSWLUEC
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: catalin.marinas@arm.com, will@kernel.org, rppt@kernel.org, akpm@linux-foundation.org, m.szyprowski@samsung.com, jenswi@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, mark.rutland@arm.com, robin.murphy@arm.com, hch@lst.de, ryan.roberts@arm.com, sumit.garg@kernel.org, sudeep.holla@kernel.org, ardb@kernel.org, thierry.reding@kernel.org, david@kernel.org, danielmentz@google.com, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, iommu@lists.linux.dev, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TJFDJXFUVXJJCY4HU545WSOZUSSWLUEC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This series is a follow-up to the discussion that has started here [1].
> 
> When memory is lent to the Secure world via FF-A, CPU speculative
> accesses from NS to the lent pages can still occur as long as it retains
> a cacheable mapping to it.

One thing I forgot to ask during last review, in case of hypervisor
support like pKVM how are going to handle unmap from stage-2? As I can
see from code pKVM doesn't support FF-A lend calls to unmap pages from
stage-2.

I think overall it is important to unmap memory from both stage-1 and
stage-2 to avoid CPU speculative accesses from NS when memory is lent to
the secure world. Is there plan to support stage-2 unmapping like in
case of pKVM?

-Sumit

-- 
Sumit Garg <sumit.garg@kernel.org>
