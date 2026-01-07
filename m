Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 795A4CFD64B
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 15:04:32 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A64494FF8F
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 15:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767798271;
	bh=wfQGUAW+R8p1I/9nR3cmWgebX5fO3Vm4jMw5HkkYoRI=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=5iI8nbV84iQOWaIkTpmPHpfgpmymlq2IKVsRVZpRsj9CKKcp7vXpVvbDp8vkMYjTU
	 zXfebwOCCEphF6lullEFbMMqwU1TN3+9lC01Ey5h7fdnYe0VZIjczbYuNEE2n21V4y
	 hOwxzbYKahfTnxBFXqZ+CAZTa5QM2ij8gafaXBrbiY2fZhhMutBsNhs5oyLSkHdcKM
	 vTOQxI3/MZMWYv3oS103dW9IWH9rmObfyg46IDKqjm33CCNZ0rS6vYSIn1lIe0ihgP
	 X2aI8dowOjSN0jEnoSwHIdg0nataQgahzBdIM8637MAY2K3vZIZsDJg+TE6AYx5b2b
	 1sMPBj4jbAU3g==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 91F244FF76
	for <op-tee@lists.trustedfirmware.org>; Wed,  7 Jan 2026 15:04:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AvuhFD6v;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CDA4A60007;
	Wed,  7 Jan 2026 15:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0214C4CEF1;
	Wed,  7 Jan 2026 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767798253;
	bh=wfQGUAW+R8p1I/9nR3cmWgebX5fO3Vm4jMw5HkkYoRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AvuhFD6vkDyKPtObaUpbXdCIA6YzOMdokfoLx1l9htjG/RjuCV7casASbPCoehQY6
	 lxQFu5T6jTReVyhK+whCVWpStKJp4GYVTmczv4FRv7RlzhMTwJUnDw5Y++RM9papx3
	 viZw646mm/G43NFtkxTsiiUk2jAT/+9LxMnlyfMIM02PGSMOpGIFk2icSkuCcmOeAz
	 IRg/HwX+o9lh6laTkFuf0T6lVWWB2c4BxeOmvIxkaa8cYJYTBxTz1vPdESYh+nzEii
	 JmHcy3GQlHzo48xii1VuJAsLkqqd9q2+3y5OPJ4TdY1z+slfOxvl8LyYgf49ej2SPI
	 wKUW+fgLRkjWw==
Date: Wed, 7 Jan 2026 09:04:10 -0600
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
Message-ID: <vro3jecpe27dxtkeqsjhpdouqju2rsc5jeqyoxefyfbdx5pahx@rqrt4hzqjrqo>
References: <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
 <aTtvHYDOny33yeOD@sumit-X1>
 <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
 <cr5ryvw2zblk44zxb3cbwqglhqs5gq4iy6gcfjrofdal5khvsr@g6txeiqgoneu>
 <5a064c67-2c15-4ab9-ad34-a56a2e0ec150@oss.qualcomm.com>
 <a27tcbxmv4pwwvtxddeerrps6nasqpah35mzypz3p5ju2awigg@owrhgvasvuhe>
 <83ec99c3-ab34-4344-ac60-084a85e4fb2a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83ec99c3-ab34-4344-ac60-084a85e4fb2a@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received,172.105.4.254:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_NONE(0.00)[kernel.org:dkim];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 91F244FF76
X-Spamd-Bar: -
Message-ID-Hash: L3KVT5YSGN4N7VZQI6BLMCBQG2ZITJ2E
X-Message-ID-Hash: L3KVT5YSGN4N7VZQI6BLMCBQG2ZITJ2E
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/L3KVT5YSGN4N7VZQI6BLMCBQG2ZITJ2E/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>

On Wed, Jan 07, 2026 at 11:50:33AM +0530, Harshal Dev wrote:
> Hi,
> 
> On 1/2/2026 11:53 PM, Bjorn Andersson wrote:
> > On Fri, Jan 02, 2026 at 02:21:57PM +0530, Harshal Dev wrote:
> > [..]
> >>
> >>
> >> I agree that the defconfig change effectively enables the driver for all arm64
> >> boards, not just Qualcomm SoC based ones. To clarify this in the commit message,
> >> let me explicitly state the following:
> >> - Why we are enabling it for all arm64 boards.
> >> - From which Qualcomm SoC onwards the driver is applicable to.
> >> - What functionality the driver provides.
> >> - How it's functionality has been tested and on which board.
> >>
> >> "
> >> arm64: defconfig: Enable QCOMTEE module for QTEE-enabled Qualcomm SoCs
> >>
> >> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm Trusted
> >> Execution Environment (QTEE) through the SMCInvoke interface, implemented by
> >> the QCOMTEE driver. QTEE runs in the Secure World domain on ARM64 CPUs and
> >> exposes secure services to Linux running in the Normal World domain.
> >>
> >> This change enables the QCOMTEE driver as a module to support communication
> >> with QTEE.
> >>
> >> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and executing
> >> a Trusted Application via tests hosted at github.com/qualcomm/minkipc.
> >> "
> > 
> > This commit message looks good to me.
> > 
> > It also makes it clear that all platforms up to (not including) SM8650
> > _only_ supports QSEECOM, and hence makes it clear that we have reason to
> > support both mechanisms.
> 
> I agree, before QCOMTEE driver, QSEECOM was the only way to communicate with
> QTEE.
> 
> I hope everyone else is aligned as well.
> I will send a new patch version with the updated commit.
> 

I said the commit message looks good, not sure why you will send a new
version.

What I wanted to put in writing is what you're saying - that all targets
prior to SM8650 will only use QSEECOM - something that was contended in
the previous discussions.

Regards,
Bjorn

> Thanks,
> Harshal
> 
> > 
> > Thank you,
> > Bjorn
> 
