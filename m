Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8CAC55174
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 20:15:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 44FAD45010
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 20:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785528945;
	bh=gnf0nbZ2qsNY/p3GjXYAAuVwlYgeUJc5Gh6n5IsuUZc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Fhc6N6TTH2MwIOpmbaRFTYGHg1EkeQ1+1C0gAheHYUMjyM71EvMQBrDPYSoasOyUl
	 AH/Vks2vcep5lbvR6gM1T0y8LIBcpbAxQs6yn0GppmnlGr9bXPbxx+223dRJLgSqiC
	 QEoNyLbsTWFv8fpht8T5ZQd6c4rx7P6A+Rfo1z0hBKNGcSsdZohs1EelbJAHYzX7d5
	 i3RJgnDYCODg6JCt37Jcq3vtQ1oNXlZ9PhX4tWmA/Dvvv6aOa4dU68bbw7/MjbK69a
	 Fv2v8JraYpPLS2VE+kfuOBBP9zANS1jlx6DzeYSIXuO2U15kHbXUvBqyhVHo++NBvB
	 3ZgS+91G+Z40A==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1FDC344D88
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 20:15:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XIcoKZao;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C202600C3;
	Fri, 31 Jul 2026 20:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246E71F00AC4;
	Fri, 31 Jul 2026 20:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785528938;
	bh=smrkd6WlPJv3JC73FVVo5YhOrRs2gOUzXj3M5ZOEgRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XIcoKZaojCQn4oYN/6zTVYmRPSNCzbOLVpzRyBwgwI/99K8zS7znMnfzCqUKw7+M0
	 T1s3SJ7hHXQ/VX37y/O9+BlLsDbvSwO40LkwAtTHmPm1g+9AEFMB2MB/g5oyzL5awL
	 YDnYHEwx/JajP+UBhSW203X3nCP15Uz1CRG73wSX1P52/Tl/k6dBl6o2SGLSI7YqMR
	 IcG+XebgPbOb9jcGjOpTb+OW/1HE0EhAn1L6YERgoET7WD4TVio+iEMlBOXPoUl/ve
	 Fv6ZBkllGlPIciYVR0udlv/BoBK7mWi81Ll5gofBnTM1vf4AhOpmjzwc0OqhbHU00R
	 wd4zXcgupBIXw==
Date: Fri, 31 Jul 2026 15:15:37 -0500
To: Xing Loong <xing.xl.loong@gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add mbedtee
Message-ID: <178552893708.1585375.2477394564041706505.robh@kernel.org>
References: <20260720073558.799755-1-xing.xl.loong@gmail.com>
 <20260720073558.799755-2-xing.xl.loong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720073558.799755-2-xing.xl.loong@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.58 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-2.08)[95.54%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1FDC344D88
X-Spamd-Bar: ---
Message-ID-Hash: ANHULUTID5IZVB2PD7PN3V7TYFQPM4FE
X-Message-ID-Hash: ANHULUTID5IZVB2PD7PN3V7TYFQPM4FE
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ANHULUTID5IZVB2PD7PN3V7TYFQPM4FE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "Rob Herring (Arm) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Rob Herring (Arm)" <robh@kernel.org>


On Mon, 20 Jul 2026 15:35:55 +0800, Xing Loong wrote:
> Register the "mbedtee" vendor prefix for the MbedTEE Trusted
> Execution Environment project (https://github.com/mbedtee).
> 
> Signed-off-by: Xing Loong <xing.xl.loong@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

