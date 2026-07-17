Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F16C55822
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:20:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DEFC345312
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785921610;
	bh=Asu6LlzeSyRAekEood1ebtTy9RPpVi5m5x1E22q/YoU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=m/tA/TVvFxtClquNDCOZ8Ib2scfkEPBte/bCVUIVm8yt48MH9OZUxBG/MwuGVjTV/
	 wNYrGGNNfy0yvmK2BwJ4CUtLKai+P9G454oY5KbZOxXm6ej3Xnnzc/YLB+F0uAKkV3
	 ZB3rvGvPk1opPEe/JaWGZkhSbfmRjX0wrOGEVi5mE/wgNyIibMh7Tjpb6bHLKYVfd9
	 nqOHNOPgAN5PdT8jXTANSegzAAvK6ndm987hkW3/AG24pG3gvP7qTz4MhJK7+t9JIo
	 u/NSDx5QFZNGeIqrFdpOR0MedAePQj3Tpb+TR0L5YCVEHFRrkEOE1oEJJXtYFPxf6p
	 df0bjpEUYofaQ==
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 60E8B44D86
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Jul 2026 21:10:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=0U/0awyI;
	dkim-atps=neutral
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h22cs5TYJzlh309;
	Fri, 17 Jul 2026 21:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784322633; x=1786914634; bh=3Oj7Es9OxZsQkG/dRxJ0eXNS
	RD8JY6r+FrgE6JkyAd8=; b=0U/0awyIpk5k6id7m2JEDKTPkB/KMf/QDvhkCtRx
	fBNyx0hV7NmRzpmIbE8scq1DqLRZ2gHvOdi3+U7Cd3xq+CHzCM5Kn4y67fi2gxQs
	Ko9xVe2O9+78vE+xAR6YrU4V4IaBrMYomkH57z1iK7qNzHUuUXfjhyK4jlBSwzzm
	XIVf3zINFoHQ9ZpDjMSzzVGUShCw8B9sQL6xU5MKyMzMFJkL2lZZekVW2pL6Fehp
	7W03LJEPaSig8rdd5sTzudUcXt6P5HDt902QEz6EZMGrURY9eyqZ2znOYA8/5PqA
	AqeUYAmbhu4MUDIUk3+/jS8Lq4MHNuZfOdr8kaUQsQqJYw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y5wAkRDxldxh; Fri, 17 Jul 2026 21:10:33 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h22ck14Ctzlh30D;
	Fri, 17 Jul 2026 21:10:29 +0000 (UTC)
Message-ID: <745f117a-253a-4b17-ad87-710f330c56c5@acm.org>
Date: Fri, 17 Jul 2026 14:10:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB
 WLUN
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 alim.akhtar@samsung.com, avri.altman@wdc.com,
 James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 beanhuo@micron.com, can.guo@oss.qualcomm.com
References: <20260715214327.1933560-1-jorge.ramirez@oss.qualcomm.com>
 <20260715214327.1933560-2-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260715214327.1933560-2-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.48 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:199.89.0.0/21];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.02)[54.75%];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:40676, ipnet:199.89.1.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[acm.org:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[199.89.1.16:from];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 60E8B44D86
X-Spamd-Bar: /
X-MailFrom: bvanassche@acm.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: QYAJF446D7KVL7RX7MRKYCTD5O4RVL2X
X-Message-ID-Hash: QYAJF446D7KVL7RX7MRKYCTD5O4RVL2X
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:07 +0000
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QYAJF446D7KVL7RX7MRKYCTD5O4RVL2X/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bart Van Assche via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bart Van Assche <bvanassche@acm.org>

On 7/15/26 2:39 PM, Jorge Ramirez-Ortiz wrote:
> +	/* Retry the power-on UNIT ATTENTION (ASC 0x29); the SCSI core does not. */

If this patch is reposted please leave out "; the SCSI core does not"
because most developers consider scsi_execute_cmd() as a SCSI core
function. Hence, this patch makes the SCSI core retry upon a power-on
unit attention. Otherwise this patch looks good to me.

Thanks,

Bart.
