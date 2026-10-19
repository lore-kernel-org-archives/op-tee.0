Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED00CCF2E3
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 11:49:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1D8E6452F5
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792410552;
	bh=pKSArXpk/5IJh+/fKSThGW+GIdbiteG9/vEycrk2pds=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OBOsMSENS7FoVUUZ6ALtyN3UaXDMyCVOKMWVdItmS4iKGvjwt9Ozr+u0o5WmdGFiu
	 LzyuA8HxtllNRxDwBXjXHkDL29beV6YbD9wWJmCFUYcsvid3eg5BbR79v+96k34Nqj
	 R66fPKw9lrXbBcus0yFxeq81utRXSCQs8+EY6D9HT7Kq8EJotdHuDB6otbyGgmKKvV
	 Tr7j4mWLHhsjCvjcCuY6jjff4nMac3J/Lv8q84skZJIqF7LmOQhDVnNgt61weowrHP
	 DERmx/s94TIzR+rvAl67MLUEPIUkMeuzacLP04LhRRQzvNiRRXYNO6iszJ/GE4lmj1
	 qelm2EqR8Ltww==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BC10044DB9
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 11:48:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IXrfQasl;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 07B9D40887;
	Mon, 19 Oct 2026 11:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37841F000C5;
	Mon, 19 Oct 2026 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792410533;
	bh=5bVoZnEarRBs9Xk5wqya8DrG3A1bPmlIgxOyF2pbG3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IXrfQaslscILGXoY7dMfLmeJ3rKloCn5sPs9jso2bKegmGYtIIOe7BgHYEPtIdYWL
	 5g3jaVRY1Fdsmot/Xix5bb8Ly1rXPcn+7RX0W+DwPDRGFJ+BPIRLS+3ArjRa5dEfgD
	 WdoImdUbHvqe+7wOoYLqTdEUixfOFJleozd+591RWzmRkpuMZOkgWSvKeIXh/jchC1
	 175kH3lfxu08NTv3x178CilXX1fo7wScY04iY+pPyxYrG60KuMSaXeSkC6Czwkb0I8
	 tfD5BY8dEIq58KmmPN/VWjY7S3REBjKxHMxcl0vvM8lz8yLm5kF1tay7R9l8JJgdOj
	 c88/1pZSqSsew==
Date: Mon, 19 Oct 2026 17:18:49 +0530
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH] tee: optee: allocate a bitmap for all valid notification
 keys
Message-ID: <atYDodGDc3z6Qv4f@sumit-xelite>
References: <20261009-fix-tee-max-keys-v1-1-1462d96bf438@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261009-fix-tee-max-keys-v1-1-1462d96bf438@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	RCVD_IN_DNSWL_MED(-0.20)[172.234.252.31:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BC10044DB9
X-Spamd-Bar: ---------
Message-ID-Hash: VBX67RFF7NMMOPTFFY7EF2DNCTA45GZW
X-Message-ID-Hash: VBX67RFF7NMMOPTFFY7EF2DNCTA45GZW
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VBX67RFF7NMMOPTFFY7EF2DNCTA45GZW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Fri, 09 Oct 2026 at 20:19:48 -0700, Amirreza Zarrabi wrote:
>Notification keys are checked against an inclusive maximum, but
>optee_notif_init() passes that maximum to bitmap_zalloc() as the number of
>bits. The bitmap is therefore one bit short. When the maximum key is a
>multiple of BITS_PER_LONG, accessing that key reads or writes beyond the
>allocated bitmap. Word rounding masks the problem.
>
>Allocate max_key + 1 bits so that the highest valid key has storage.
>
>Fixes: 787c80cc7b22 ("optee: separate notification functions")
>Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>---
> drivers/tee/optee/notif.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
>index 68014222d7be..2bf5ce397233 100644
>--- a/drivers/tee/optee/notif.c
>+++ b/drivers/tee/optee/notif.c
>@@ -114,7 +114,7 @@ int optee_notif_init(struct optee *optee, u_int max_key)
> {
> 	spin_lock_init(&optee->notif.lock);
> 	INIT_LIST_HEAD(&optee->notif.db);
>-	optee->notif.bitmap = bitmap_zalloc(max_key, GFP_KERNEL);
>+	optee->notif.bitmap = bitmap_zalloc(max_key + 1, GFP_KERNEL);
> 	if (!optee->notif.bitmap)
> 		return -ENOMEM;
>
>
>---
>base-commit: becb95e45ef0dda9ffb35156d909d3da7a2789c3
>change-id: 20261009-fix-tee-max-keys-50f2db87b4e5
>
>Best regards,
>-- 
>Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
>
