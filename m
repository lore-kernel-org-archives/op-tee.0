Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E55C79F9F
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 09:21:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DE9EC45278
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789032093;
	bh=RGqXXGSwXhjsMD88DEwbjnX3i5ywJ/XDcVssiguJaaU=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=39BcooCXBvYjC32cnI7qo1oZ88kXw7aKGxaafUVc/9sUX0cJ/Kyi3bLPKGntr+5Vk
	 S1rv3UvdariABMiaoKIaq8TFV4gMnIeX3wWSN0/bHBMpl4xR1gFSLZ7j4oy2goVPPX
	 MhSd/UfQOR4FDpwsl167zmKKCDqmXRlbv3eD1AhhShgdA+VcChljgAeVXQntgDHB5n
	 iedezx8At/zp/cAad6+6aVgespEiWdHvRcUPHlQtilUmg4mV2rsMluv9m2uYOcMFB0
	 NF2grgzgERyIk98C82k2wfZC9PQnvfR++jn5ISZTmI654SW+hrEO/YCv2dJgbNLPk3
	 QbJj8mCwrXFTQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9FD7B43E4F
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 09:21:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EM79IyR8;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E13FB41400;
	Thu, 10 Sep 2026 09:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F601F00893;
	Thu, 10 Sep 2026 09:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789032085;
	bh=RGqXXGSwXhjsMD88DEwbjnX3i5ywJ/XDcVssiguJaaU=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=EM79IyR8mF//eCB+qEW3gt6VcUTFeO9heW4KFNfDxQtLOx7H+8w4Lf8+EDsUkyHn6
	 0lk+89wsu8DLQzuvXWLvrnaVTc7kZbAqhtYOoVCcNggU/Qicaadwf9ueDUpqLNtulQ
	 lSl/S/GeEH8PHr0tOrl/rFS6eT662TVsdzVQTraCu8/EOrHwQaRWo/ZfFnt+jie+ry
	 7LemhGSzlqXiQcXQY/e1aZScHs+azxH0HPgTcEgqHRSKu50FlLDDxS0tw+SedAOaxn
	 jrS3IYpqC8f+GzwgmijDgZLRybgJqzbNyo8BI5K3RTs+JR5lDKYsFYomS/6aGgN3k3
	 fYmrQaEZIanvA==
Date: Thu, 10 Sep 2026 14:51:21 +0530
To: Andrew Davis <afd@ti.com>, Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: move tee_ioctl_shm_register_data to above IOCTL
 definition
Message-ID: <aqJ2kXdcapQI-RCQ@sumit-xelite>
Mail-Followup-To: Andrew Davis <afd@ti.com>,
	Jens Wiklander <jenswi@kernel.org>,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20260903175730.1909952-1-afd@ti.com>
 <aqJ0yCHd03ZLsSMT@sumit-xelite>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aqJ0yCHd03ZLsSMT@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-8.50 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	URIBL_BLOCKED(0.00)[ti.com:email,qualcomm.com:email,sea.source.kernel.org:helo,sea.source.kernel.org:rdns,sumit-xelite:mid];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9FD7B43E4F
X-Spamd-Bar: --------
Message-ID-Hash: ERJ7WNBGWYSY6ZZ4CXV5SCU43HM62HZ3
X-Message-ID-Hash: ERJ7WNBGWYSY6ZZ4CXV5SCU43HM62HZ3
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ERJ7WNBGWYSY6ZZ4CXV5SCU43HM62HZ3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, 10 Sep 2026 at 14:43:44 +0530, Sumit Garg via OP-TEE wrote:
>On Thu, 03 Sep 2026 at 12:57:30 -0500, Andrew Davis via OP-TEE wrote:
>>Most of the struct definitions for a given IOCTL definition immediately
>>preceded that definition. The struct tee_ioctl_shm_register_data is an
>>exception as it is placed above the TEE_IOC_SHM_REGISTER_FD definition,
>>not the TEE_IOC_SHM_REGISTER one it is to be used with. Move it down
>>to match the others.
>>
>>This is a non-functional change for consistency and to help prevent
>>someone from accidentally using the wrong struct with the wrong IOCTL
>>based on the struct's location.
>>
>>Fix a couple small spelling issues while here.
>>
>>Signed-off-by: Andrew Davis <afd@ti.com>
>>---
>>include/uapi/linux/tee.h | 40 ++++++++++++++++++++--------------------
>>1 file changed, 20 insertions(+), 20 deletions(-)
>>
>
>Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
>-Sumit

Andrew,

Please check your get_maintainers script, it's too old to pick up wrong
maintainer's email ID. I have updated it now.

-Sumit
