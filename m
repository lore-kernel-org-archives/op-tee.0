Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A554C8303C
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 11:36:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 58EE342E9E
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1751888165;
	bh=UmDGhlqSKQfzSo/PNTfY6HMkS/E8jY5vIJHz2YlLXtA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QDvNkjgsWj/cqzmjgxgceRXZ61qs23QX59/WW8bM8Xn9Blxui4X37gkT9rffOMjq8
	 tZsH77awwKAe6RR/6VVznl6/Ahj6/5vJFms2SwPEZRotrzJD+sxjLSER1tWJhsDx90
	 q7au3OdSFxTXSuBDTGeIkpshIR/NErSnvfJVGJ4oOKgAZnkkTNgM5N++03YxRvFH+E
	 crQPS6RqSzifgTgZTF2zzR6gyovHTxooJCrwo4EEGu8q4ngFAS8HVGZPVCDwODfSlc
	 x3APQPbNdDGsQO91FSHKGIOsAg780+XrZLfAj7phg6ow81H/gJsxeQQHbvGnZozYP8
	 BLtcIvjQXKq8g==
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B32E23F6B0
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Jul 2025 11:35:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=ti-com-17Q1 header.b=QL9vYOT6;
	dkim-atps=neutral
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 567BZebm204274;
	Mon, 7 Jul 2025 06:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1751888140;
	bh=lg+ZPIHi1qu3yilPAV4JkNFTwJxGgjbBBeU49p6xp3U=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=QL9vYOT6w+w9Gty4e3PQ6pvVnLgAP2jxFlit5P6lSFWllRIzHXGwe7haWzplEZ1g+
	 Pm9r92rss6lWI9YCsVF07DymQV47sGrjdo5dporxorFpnE5ta1xCcAstgl2crRTYhf
	 OVqchg2N2zcjSEHRhpZSZ1xj6pVmkA5yMCKIVPTA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 567BZevf2166412
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 7 Jul 2025 06:35:40 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 7
 Jul 2025 06:35:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 7 Jul 2025 06:35:40 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 567BZeL73995508;
	Mon, 7 Jul 2025 06:35:40 -0500
Date: Mon, 7 Jul 2025 06:35:40 -0500
To: ANAND MOHAN Tiwari <anandmohantiwari94@gmail.com>
Subject: Re: Compilation Issue for plat-k3 for am67a beagleY-AI Board
Message-ID: <20250707113540.44emabkmaxytxnbs@jingle>
References: <CAE3nP4gt44hNp_GNzfYXCqXpsw+WSwFnY+Xz=jJAQzdNQ5D6KA@mail.gmail.com>
 <CAHUa44FxVseYXptcKf2_C1AHgGOD_eGyR=2A3FXzwd42XSqcMQ@mail.gmail.com>
 <CAE3nP4jkU_MioO41z2d7UoswSdeDJWfbwPB04iinvb34pXx0Kw@mail.gmail.com>
 <CAE3nP4iG_K6fwAQx=P6m7HAXsZcrauJp-UvKmBO7dyOMHJWreA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAE3nP4iG_K6fwAQx=P6m7HAXsZcrauJp-UvKmBO7dyOMHJWreA@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B32E23F6B0
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.41 / 15.00];
	BAYES_HAM(-2.91)[99.62%];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=ti-com-17Q1];
	R_SPF_ALLOW(-0.20)[+ip4:198.47.23.224/27];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:161, ipnet:198.47.23.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[198.47.23.234:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[198.47.23.234:from];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[ti.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ti.com:+]
Message-ID-Hash: 2XTEQHX32FG6XACCLKVHZKJFOS4GOPZP
X-Message-ID-Hash: 2XTEQHX32FG6XACCLKVHZKJFOS4GOPZP
X-MailFrom: nm@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>, etienna.carriere@linaro.org, "afd@ti.com" <afd@ti.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2XTEQHX32FG6XACCLKVHZKJFOS4GOPZP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Nishanth Menon via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Nishanth Menon <nm@ti.com>

On 12:48-20250707, ANAND MOHAN Tiwari wrote:
> Request you to add support for am67a beagleY-AI board.
> Let me know if i can help in any way for the same.

BeagleY-AI is already supported with OP-TEE, detailed instructions are
here in U-Boot documentation:
https://docs.u-boot.org/en/latest/board/beagle/am67a_beagley_ai.html#sources

I think you need to use PLATFORM=k3-62x instead of PLATFORM=k3-65x

if you need a standalone build: https://github.com/nmenon/k3-upstream-boot-build

if you need the periodic built artifacts: https://github.com/nmenon/k3-upstream-boot-build/actions

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1am67a_beagleyai_hs_fs_all_defconfig736 249D
