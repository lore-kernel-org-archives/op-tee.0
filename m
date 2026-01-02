Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B41EFA3753
	for <op-tee@archiver.kernel.org>; Fri,  2 Jan 2026 18:23:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5883A431CA
	for <op-tee@archiver.kernel.org>; Fri,  2 Jan 2026 18:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767378229;
	bh=ZjUiOIWiQOh8mq28n8k2fnthEnoJezWAylTZAjq2lXM=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=4ohT6D1lnHAyO1HaCKCT4S8zPvYDdrPdjlT5X56iRgS90wlekahlkD89CpQ+nVw0k
	 ReWPl8KUpBhkiyPERaNiMPXjprA91noRljWSZozGgW9RGwhYrXoxWRKSB5Jps7Ua+T
	 r0LxSYKQWJBOBCXtL4vAiwYY15xcMZUPdf1OfKINpkpZOrI8beZHnXmE95DOLu7KvU
	 nItQb4CPrZ5/nnh+Cwm1E+wgBO1JcDPwWayw+kM0Viiha8WJxSRZUm6wsnfBgfYZQw
	 hoDJ95P7rUGN4gxTjSh8J8IWyKALrkfqZU6gje3ZoFf0ZPpp4xuVQNXEFf1gZf2ap+
	 9xKe/MOIbhzJA==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BFC0643163
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Jan 2026 18:23:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tWcfmEn4;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2999760129;
	Fri,  2 Jan 2026 18:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091B5C116B1;
	Fri,  2 Jan 2026 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767378211;
	bh=ZjUiOIWiQOh8mq28n8k2fnthEnoJezWAylTZAjq2lXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWcfmEn4RyJdVbd2hr/Ud4FZYvX6sLc4dwmG9+wFiEH0gLIMug9nTCp9W1aeL1E2o
	 38+SJJNJYwblDp7wjNgyHpiL8bJaPHWq7bOhKw/X3UOEoV4RF9LgljVWMx9a0mOJzq
	 ZK3pGKXsa35RFSst7fTfZT9oqdy/mtKndk1Uz33BWEByfunWTxf3Aqn1dFkFCsQ0Qu
	 bvML09yP/Ziq3Yx80COHn2xgiNw2ouVmBv2T3cTfmvLveN439MrWDnlnbZ57kZptq7
	 4Ljph9UknaqUknglwIXVTJZux3V/nd4QqslaMDwYkG8d+izL8CEWfKxJHEkP7O3f5a
	 xasqs48WmVsRw==
Date: Fri, 2 Jan 2026 12:23:29 -0600
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
Message-ID: <a27tcbxmv4pwwvtxddeerrps6nasqpah35mzypz3p5ju2awigg@owrhgvasvuhe>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
 <aTtvHYDOny33yeOD@sumit-X1>
 <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
 <cr5ryvw2zblk44zxb3cbwqglhqs5gq4iy6gcfjrofdal5khvsr@g6txeiqgoneu>
 <5a064c67-2c15-4ab9-ad34-a56a2e0ec150@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a064c67-2c15-4ab9-ad34-a56a2e0ec150@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BFC0643163
X-Spamd-Bar: --
Message-ID-Hash: OYYGJKDC2HMQBS6ZOSLITXVDFPLP7Z6H
X-Message-ID-Hash: OYYGJKDC2HMQBS6ZOSLITXVDFPLP7Z6H
X-MailFrom: andersson@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OYYGJKDC2HMQBS6ZOSLITXVDFPLP7Z6H/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <andersson@kernel.org>

On Fri, Jan 02, 2026 at 02:21:57PM +0530, Harshal Dev wrote:
[..]
> 
> 
> I agree that the defconfig change effectively enables the driver for all arm64
> boards, not just Qualcomm SoC based ones. To clarify this in the commit message,
> let me explicitly state the following:
> - Why we are enabling it for all arm64 boards.
> - From which Qualcomm SoC onwards the driver is applicable to.
> - What functionality the driver provides.
> - How it's functionality has been tested and on which board.
> 
> "
> arm64: defconfig: Enable QCOMTEE module for QTEE-enabled Qualcomm SoCs
> 
> All Qualcomm SoCs starting from SM8650 provide access to the Qualcomm Trusted
> Execution Environment (QTEE) through the SMCInvoke interface, implemented by
> the QCOMTEE driver. QTEE runs in the Secure World domain on ARM64 CPUs and
> exposes secure services to Linux running in the Normal World domain.
> 
> This change enables the QCOMTEE driver as a module to support communication
> with QTEE.
> 
> QCOMTEE has been tested on a Qualcomm RB3Gen2 board by loading and executing
> a Trusted Application via tests hosted at github.com/qualcomm/minkipc.
> "

This commit message looks good to me.

It also makes it clear that all platforms up to (not including) SM8650
_only_ supports QSEECOM, and hence makes it clear that we have reason to
support both mechanisms.

Thank you,
Bjorn
