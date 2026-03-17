Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B89F3381A
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C498A43A91
	for <op-tee@archiver.kernel.org>; Tue, 17 Mar 2026 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773737527;
	bh=F35u330TQ0Qd2K1i6G71PgX+7Rk66KGKZfQeptXDdCM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RR40xNW6tdqt2eSSKLh1KUjhQREQmOLlb2p72lPFTBWFxDhA0sQhja17R1Gv2x91K
	 GbSVbbptqyWjPZ1W9xB+0JpBK+aJp7mVgvYuVi1MgexunHgi/c7V3PBPhynPvICtFb
	 nmyOJGzobA5xzbnBGA+T7qCKbUTHa+dZngzzlpDidFetZzYNyCR24/iFpmHVFZgXyo
	 lFBlicL/9TjYd8DArm/fELsmY3CqeedTHNlrwmrz0Oa0E0wZvZ4zWye/76t1NchPlo
	 US0CVFNXEkr7XJsw0Eo6tYkmIXqatwgIBDqJqLcRX3YIgQBehsQG+2WK9rM19nJHcd
	 1lM0M1YnHJ+mw==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 886D740B21
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 08:51:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UGvPOCOa;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C3C574374D;
	Tue, 17 Mar 2026 08:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CC3C19425;
	Tue, 17 Mar 2026 08:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773737508;
	bh=F35u330TQ0Qd2K1i6G71PgX+7Rk66KGKZfQeptXDdCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGvPOCOamZpkSFYoFUEh9RdRoPLUAjOrQOj2CX04QJLVvLxls6WoCaEeSZ+e0pCPl
	 AsuauYcBKqUna8nFH3oGiaFVq3R1ezq3LQIDZyWlisNU1HU1DL5apyfkL/IW/eVvRH
	 mnZeNdt1KL8MrPis8aNyHi1gRUCE0sLNXNXRfhCbekWmTCRZwRed+8cUubxC6yGh3O
	 WHmmq4azcKblyaRY1aroLC/xbLwx4MXg4wkEWHpxenz/4MjfumhYmqUm+eQh/yCmk3
	 bHGqrEWojNHx7ToVHtIKBaIpdXW2nCFAimnkfs9UE1osTvy9AdOGgDbCfczUpopqra
	 iMEHTJ8p8Y4Bg==
Date: Tue, 17 Mar 2026 09:51:46 +0100
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [GIT PULL] TEE shared memory fix for 7.0
Message-ID: <20260317-illustrious-finicky-frog-90a86c@quoll>
References: <20260316074150.GA2474723@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316074150.GA2474723@rayden>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 886D740B21
X-Spamd-Bar: ----
Message-ID-Hash: OWD2GXXNRVHH6FYQFGXYL345IQNARGLI
X-Message-ID-Hash: OWD2GXXNRVHH6FYQFGXYL345IQNARGLI
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OWD2GXXNRVHH6FYQFGXYL345IQNARGLI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On Mon, Mar 16, 2026 at 08:41:50AM +0100, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this patch removing the refcounting of kernel pages within
> the TEE shared memory helper. 
> 
> Thanks,
> Jens
> 
> The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:
> 
>   Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fix-for-v7.0
> 
> for you to fetch changes up to 08d9a4580f71120be3c5b221af32dca00a48ceb0:
> 
>   tee: shm: Remove refcounting of kernel pages (2026-03-03 09:03:04 +0100)
> 
> ----------------------------------------------------------------
> TEE shared memory update for 7.0
> 
> Remove refcounting of kernel pages in register_shm_helper() to support
> slab allocations.

That's a supposed fix for a year old commit, not current RC, and the
commit msg does not explain what is the bug being fixed here. Looks like
it is doing improvement, not a fix. Can you provide here more
explanation of the actual bug being fixed to justify this going to
current RC fixes?

> 

Best regards,
Krzysztof

