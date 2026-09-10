Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CF4C79FB6
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:55:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CDAF8453E0
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789005319;
	bh=KI9RgiSQyz4NAIYc6WRNosSFs0Cb1WPyMSdKmudAh4c=;
	h=To:Subject:In-Reply-To:References:Date:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=N3GvRhOrJP1jpNTyHtU+gcZIA+IUFPsaNTDdd80iCaNkglSNNUDnP/z0uB+/NRpCk
	 Zg84ygKxC306FXrpnD9QTAfO9xn5mLU/M++k2lKDFNxahTDA7VNhX+7mberTsSHd3v
	 L36TiifHnjtkbbefxxy0JzSkH5fxtfmJy2UZuiPcSI7/d3e+JezOSqpUZLoOFw1/Et
	 dh5w4K9lqUmebummwNxytUwLNvwMV4tqcAWYayhvVbbuS6DiYoX2vCpWalqX2eSc1g
	 FZeRLD+Pst/nSj6mPbUDRrKQ9AedH9EV11N9GQTxGlwy5+aeL6mXz3IgT47u0OW5jt
	 hVCadgPNLXO8Q==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9D2FF43814
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 01:55:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnSBio6m;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F0C2E41A4E;
	Thu, 10 Sep 2026 01:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943631F000FF;
	Thu, 10 Sep 2026 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005311;
	bh=jH7jvytUi+mK1QimK0iBDM19vPOT7aCdsDa0cDy56z0=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=EnSBio6m20MPbCL01u0LzDonu4vR7RkDAX77/RG5IWpB3+Z3MnNwBGXx/WOYQQeSg
	 oCKeLURU2RzxvkEObRF5yN3OLSgMK13vnnChqD2v5L97aCcS4GHLgJZjTK+Dytaqx/
	 CH+OaIBtXUA/h3hS1PJ0uapz53a3F9k9Ho7oBX8xsQ4am4sVsVcznosCVgI569subP
	 23LYrr+LKRlQehDi/OR+iqtrrL9n+d9BqvFEg3L1xy0yeP538oecL4fchTr+VRpRxs
	 jLTzKIuuqi5L2nxMS+y7zs9O32A5D0zp14g3476UKfkiFo495MOpM8cxXoxPDni1tO
	 qgkRBIyBR+zTw==
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/2] ufs: rpmb: make RPMB usable with OP-TEE key
 derivation
In-Reply-To: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com> (Jorge
	Ramirez-Ortiz's message of "Mon, 31 Aug 2026 17:47:59 +0200")
Message-ID: <yq1jyotc1la.fsf@mail.kernel.org>
References: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 21:55:10 -0400
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.85 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	BAYES_HAM(-0.85)[85.36%];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	URIBL_BLOCKED(0.00)[sea.source.kernel.org:helo,sea.source.kernel.org:rdns,mail.kernel.org:mid];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9D2FF43814
X-Spamd-Bar: ----
Message-ID-Hash: EDMQFTMQU2RRDPXRV55ACQOUZY6PGHHS
X-Message-ID-Hash: EDMQFTMQU2RRDPXRV55ACQOUZY6PGHHS
X-MailFrom: mkp@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: stanleyjhu@google.com, beanhuo@micron.com, beanhuo@iokpp.de, James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, can.guo@oss.qualcomm.com, sumit.garg@oss.qualcomm.com, jenswi@kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EDMQFTMQU2RRDPXRV55ACQOUZY6PGHHS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "Martin K. Petersen (Oracle) via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Martin K. Petersen (Oracle)" <mkp@kernel.org>


Jorge,

> This series makes UFS RPMB work out of the box with an OP-TEE that
> implements the standard eMMC RPMB key-derivation flow, without
> requiring any fundamental changes on the OP-TEE side.

Applied to 7.4/scsi-staging, thanks!

-- 
Martin K. Petersen
