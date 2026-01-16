Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFEDD4A5F6
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 05:09:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B89B1434B1
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 05:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768540195;
	bh=L/Mep7KV5lU1mViPPfVYqlB7lwGd/yhiBsQZZbSFrwE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JN/V6Ttq8IPEsxbKFygzY1Jt1HkoQSSl8smSX1MtcxNBjSweyJMZa8b5DlEoP1p08
	 m75i4AB+IwZETT5IgMWvs7Nrl56UDMZxX2YCpANwc/inh1yLeDj6EhsNKWffyqPoC2
	 2Oc4iaBPNP9hcDPDgY9WFdDoaxXgEGHFYCPdd17fnJI4+9MZGTnXtVND9hZtWTKaBj
	 pBpEebAKlN9Oiqy8xcaqhkBlWFbvsO1FZMi9JwiKizRso1vkHlDrdUbrE1cmzAbTuZ
	 woLcmbNka2hP+JSz/bMjSnmriFzO1iE2b52OChjU3CydTljE4jGw9bvrqbv/G9gd1D
	 ejGOWGxA3OqYw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4F33341A3B
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Jan 2026 05:09:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=besjak3I;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A9E0060160;
	Fri, 16 Jan 2026 05:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334F7C116C6;
	Fri, 16 Jan 2026 05:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768540174;
	bh=L/Mep7KV5lU1mViPPfVYqlB7lwGd/yhiBsQZZbSFrwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=besjak3IU9UECz5tlGVWGvsjspbt42AmzyzvbRIi4etqWxk3bQJYRmJ+RwzBL5p0v
	 lk0eNiOX4OOShmXgOt2AqLth5C20DB7xBpXrG5e5s9s0nFk58rHgVSBErT7suUbRWG
	 odvpiLVLsI3M3Xni/nEMXnksncfoKsknhdf03FHrRHsQ69OMMaYvHGoWC7ePWtLIlE
	 8/+p6nbWglppSJKM/0txYrJW63BubYBbbjhFfEOBunoHgUF5b4ImShb3E6SrpmraXM
	 LnvNmBRZ7FTTV9o3POUpFp0Dxwn4RnR+XVg6lKT/xLofof2QGaQ+DGl92n35xmMLKZ
	 iyv586t4TC/2A==
Date: Fri, 16 Jan 2026 10:39:28 +0530
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2] MAINTAINERS: Mark the OP-TEE mailing list moderated
Message-ID: <aWnICDluQBNU-8C7@sumit-xelite>
References: <f9c34212cb33775754b3a1f4231f181574c99aad.1768486765.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c34212cb33775754b3a1f4231f181574c99aad.1768486765.git.geert+renesas@glider.be>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4F33341A3B
X-Spamd-Bar: --
Message-ID-Hash: EC47GSCWGSTXF4AMILSDQ2P2NFIBIAYZ
X-Message-ID-Hash: EC47GSCWGSTXF4AMILSDQ2P2NFIBIAYZ
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jonathan Corbet <corbet@lwn.net>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EC47GSCWGSTXF4AMILSDQ2P2NFIBIAYZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Jan 15, 2026 at 03:22:42PM +0100, Geert Uytterhoeven wrote:
> After sending a patch to op-tee@lists.trustedfirmware.org, I got the
> typical response for a moderated list:
> 
>     Your mail to 'op-tee@lists.trustedfirmware.org' with the subject
> 
> 	[...]
> 
>     Is being held until the list moderator can review it for approval.
> 
>     The message is being held because:
> 
> 	The message is not from a list member
> 
>     Either the message will get posted to the list, or you will receive
>     notification of the moderator's decision.
> 
> Mark this mailing list moderated in MAINTAINERS.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
> v2:
>   - Add Reviewed-by.
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 13e2f2fdc248ec65..9c988eb1cc86628f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19578,14 +19578,14 @@ F:	drivers/net/phy/ncn*
>  
>  OP-TEE DRIVER
>  M:	Jens Wiklander <jens.wiklander@linaro.org>
> -L:	op-tee@lists.trustedfirmware.org
> +L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-optee-devices
>  F:	drivers/tee/optee/
>  
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>  M:	Sumit Garg <sumit.garg@kernel.org>
> -L:	op-tee@lists.trustedfirmware.org
> +L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	drivers/char/hw_random/optee-rng.c
>  
> @@ -25693,7 +25693,7 @@ F:	include/media/i2c/tw9910.h
>  TEE SUBSYSTEM
>  M:	Jens Wiklander <jens.wiklander@linaro.org>
>  R:	Sumit Garg <sumit.garg@kernel.org>
> -L:	op-tee@lists.trustedfirmware.org
> +L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-class-tee
>  F:	Documentation/driver-api/tee.rst
> -- 
> 2.43.0
> 
