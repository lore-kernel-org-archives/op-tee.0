Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C78B0E92FE3
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 23:25:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0FC5741883
	for <op-tee@archiver.kernel.org>; Mon, 29 Dec 2025 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767050751;
	bh=gBic61XhRnhOC+5nNfIY22uN2UTZjrJ0gw/UGoHisUw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=oVjXhdZihC7pVfSQeCZAeKsB+TPzrMbfdnSKzvTcDsvYTTS8OGcntvLyTg8VMHp9Q
	 u6CydoMdfOm+WoT2npo3bk9doL/nf4qj5k/seJC2Z8Oic+5UcdS/2UTEpun4b7w4xs
	 Qu45WeMLJe0b0QTrT95nKaVj21TCW7UQmu1Y8VgQuZ/CQWvM0ff005oJ7xSVqAoxMf
	 O9FsbDCe0wFVeG6LNKU9Aa8IsXxpEqnnJEvXYW+7C+T8LZcXDkh317QBu0dWjx5K9y
	 QPRrOEQMLstb2ZBmVvxBGdwnUxge3YpUYbRLGqrrIkCse8aTEAAe+jisYZU9jW+Ljw
	 D305Ofq/gN2qg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B9E604184A
	for <op-tee@lists.trustedfirmware.org>; Mon, 29 Dec 2025 23:25:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aY9VGVHh;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 09E6A41697;
	Mon, 29 Dec 2025 23:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29ADC4CEF7;
	Mon, 29 Dec 2025 23:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767050731;
	bh=gBic61XhRnhOC+5nNfIY22uN2UTZjrJ0gw/UGoHisUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aY9VGVHhUxXe6n10yUd3Ij+dXkWLdgZUtVl2t7HHs71hCLrC6/bpMaQhij2BtIOKX
	 8I9pes7DADMkBv7d6XdEZdDndszB06v88ncLpH1JwJCzwgDIQiwzlEfOBK3CVDDrJ7
	 g6AWyiwCStbcLLy2cD90Xpf77wPXM7KUN3Ziq614OHCEYrBfIKMXAvKJ9+da00RSoa
	 Eh9kpcEtN61/0dJ7xPJwAQ65YtSVVmkC4MX/rIBohFQKt5HUe9P7lLhDT6eM6sme6f
	 supwRhDPB4Lf3Vpl4g88tqGjg4ygBBa7DKyXeAli3xv7pGi007KfbwA4t9pS90CUcg
	 ZBVU67HBEptBQ==
Date: Mon, 29 Dec 2025 17:25:30 -0600
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v20 1/6] dt-bindings: firmware: Add TEE remoteproc
 service binding
Message-ID: <20251229232530.GA2753472-robh@kernel.org>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.45 / 15.00];
	BAYES_HAM(-1.95)[94.74%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ALIAS_RESOLVED(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[172.234.252.31:server fail,100.75.92.58:server fail];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	TAGGED_RCPT(0.00)[dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B9E604184A
X-Spamd-Bar: /
Message-ID-Hash: 4MOI2XSRTGBZIDHZVG43T362KZKU6Y7E
X-Message-ID-Hash: 4MOI2XSRTGBZIDHZVG43T362KZKU6Y7E
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4MOI2XSRTGBZIDHZVG43T362KZKU6Y7E/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rob Herring via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Rob Herring <robh@kernel.org>

On Wed, Dec 17, 2025 at 04:39:12PM +0100, Arnaud Pouliquen wrote:
> Add a device tree binding for the TEE-based remote processor control
> service implemented as an OP-TEE Trusted Application identified by
> UUID 80a4c275-0a47-4905-8285-1486a9771a08.
> 
> The TEE service node is a child of the "linaro,optee-tz" firmware node and
> acts as a container for remoteproc devices that are controlled via TEE.

Is this generic for any remoteproc device or just ST's remoteproc. Looks 
like the latter to me.

> In addition, the "linaro,optee-tz" binding is updated to specify the
> '#address-cells' and '#size-cells' values used for child TEE service
> nodes.

I'm pretty sure I already rejected per service/app child nodes for 
OP-TEE when its binding was submitted. If we do need something in DT 
to define some resources, then can't we have some sort of 
standard/common communications channel? I don't care to see some sort of 
free-for-all where we have every vendor doing their own thing. OP-TEE 
needs to standarize this.

Rob
