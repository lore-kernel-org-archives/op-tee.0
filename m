Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCCAD43362
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:14:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 884BB45A39
	for <op-tee@archiver.kernel.org>; Fri, 12 Dec 2025 01:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765502089;
	bh=WiUtEdsxpAhcP+33WtOqvbqjVPW0IOOkxSjPEJ17vTg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qFWSEAonMWOA0jFD91MxNzYQ6mjNMXv7W/cESQbpEMeahhRQSJSBDP48bNGtzbtn5
	 NDDC1wE0ZRGP+G0nqVoyO5F8Xrg4Rr7JG1lwd79mVrNlSqSCfTnuyNIxc6CkOLKzOB
	 cGaj42XL1Jn1tz5tS+sd9oWqneyXJAfk2Mwx+TDCbbl7UXvP9DyMyAzbT5hQ+hda5K
	 MvkPh6RaPOgflct5Ml3ED4sQW1CXy4EA47jt7BMXAOgkHkjIyN1Eolj7vUv1o+E6oQ
	 HMyyQRDL41v16Eyb3bSFkZoyatYEBGDfit1ADET4EXiT0exn8aU907nOGyrIj4zzRk
	 ldsOwOLpbSqAg==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 495074322B
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Dec 2025 01:14:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Pjd4VigT;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 849086013A;
	Fri, 12 Dec 2025 01:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FA8C4CEF7;
	Fri, 12 Dec 2025 01:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765502076;
	bh=WiUtEdsxpAhcP+33WtOqvbqjVPW0IOOkxSjPEJ17vTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pjd4VigTeKcSZQRM1m7x0n1uaNz5WtekPGe1ycasYp034U31nyn/Eqf1FyYTJv5Ey
	 mfWSqRVwmwJvIcRpEBcpw1hxWj+rBBmtdvzq3aYXsQAxOSxHw1pN8dnaLgi3AN+avl
	 Dr7kEx5lnk39MaWWNzbE5pXSMGy1u3kgWXnm6z3vgz+1qJDdAXzz8xgxbGBSx+8Ja6
	 iFDJToXY4XF9/YBbetl8vcav6fln4SDWvO9gAGn7nruM/r+x751XQc+PX+zdm5oQ0g
	 iYNdxe3VvM9s48oxKwcMwB32qmF5971Br6S++cDME6dnigggcKSnRx8lB4JdeASZBC
	 fZN/Bc62gqH2Q==
Date: Fri, 12 Dec 2025 10:14:29 +0900
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
Message-ID: <aTtsdfNxulSTyyoJ@sumit-X1>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
X-Spamd-Bar: -
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 495074322B
Message-ID-Hash: BM4VIB54FXL3IEQN46DWGWAWJBCIVTUV
X-Message-ID-Hash: BM4VIB54FXL3IEQN46DWGWAWJBCIVTUV
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <harshal.dev@oss.qualcomm.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BM4VIB54FXL3IEQN46DWGWAWJBCIVTUV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Dec 09, 2025 at 06:58:27AM +0100, Krzysztof Kozlowski wrote:
> On 08/12/2025 13:18, Harshal Dev wrote:
> > Enable QCOMTEE driver on Qualcomm SM8650+ SoCs to facilitate communication
> > with the Qualcomm Trusted Execution Environment (QTEE).
> > (No enablement required in DTS files since QCOMTEE device is dynamically
> > registered by the QCOM_SCM firmware driver)
> > 
> > Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> > ---
> > Changes in v3:
> > - Updated the commit message to reflect the supported Qualcomm platforms.
> > - Link to v2: https://lore.kernel.org/r/20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com
> > 
> 
> I gave you the exact example to follow. Maybe it is not that important
> for others, so I will not object, but OTOH it is important for me, thus
> I will not give reviewed by. I damn asked VERY CLEARLY:
> 
> "Just mention which UPSTREAM boards (which you called Qualcomm
> platforms) use this driver."
> 
> Usage of something on SoC is not a proof that it actually is used by
> upstream platforms and we absolutely do not care at all about downstream
> users. I spent way too much time on this and even very specific
> instructions were not working, so I don't know how else I can help.

Harsal,

I remember myself following a list of instructions to run QTEE test
application on RB5 which were part of QTEE patch-set. And I do know there
are contributions going on in meta-qcom regarding those libraries here [1][2].

[1] https://github.com/qualcomm-linux/meta-qcom/pull/1167
[2] https://github.com/qualcomm-linux/meta-qcom/pull/1094

So, it would be nice if you could point people to a coherent
documentation which can list instructions to reproduce setup preferably
based on meta-qcom.

-Sumit
