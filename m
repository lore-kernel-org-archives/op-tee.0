Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBC2CCF9E5
	for <op-tee@archiver.kernel.org>; Mon, 27 Oct 2025 19:51:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B45844FF9E
	for <op-tee@archiver.kernel.org>; Mon, 27 Oct 2025 19:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1761594694;
	bh=Pk4X+7GFkmLsnGR/SwJNrClCir6ovgFLwHy360kWcBY=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=B/5Raqcemh3+wRTjxyvNsWf13sIXM3I7hdPlvcgV0lAsbzy2VdLWoonWbyZWH7VQw
	 pB5zVBzLlFkFT+Or3vhluJaluidRuthPGiQFREINXYGubwDl7SPzvFDrKa5udTh4sg
	 9Fj24m6SrkYgOkcjNyeQyMdAHvy4Vj30SnAtrXEzeJmhP2OPo6FzPswboVo5xZDYnm
	 7v14wdM6dm3TB352l+HNIV0NCfr5Tz383FDjddnnE5lUotG5F591EdCEUhZfCWuZPL
	 JfDvk8eC80p/bKer94O0DmGoOzR0I8L2nvjMosZjXgucXZF9aH1xsBpN3keKfcleBV
	 SNuL7KPmuJH4w==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 598CD41B65
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Oct 2025 19:51:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WQ62Njui;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D03360510;
	Mon, 27 Oct 2025 19:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF68BC4CEF1;
	Mon, 27 Oct 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761594683;
	bh=Pk4X+7GFkmLsnGR/SwJNrClCir6ovgFLwHy360kWcBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WQ62Njuijfkcq9Yzi/L+qU6Gb1+aLtA7bFCHwa2oGLNiBe73pwQ9dd6k0LcgJmUeT
	 jvfTU93ykAt+iwV0YmENlCqN3dxzc18OR5d1jz+RGjI9zag6jVPbkHKaP+BDZSxcmy
	 Ih5yTXi44Gp0yGhrAv3s1ckPc5EkONGBmJMTqBANJ/tdjcN0Q5wEd9By4z/b3SFv3S
	 yszA2vYDGPQZSDsk7LTJwll3MCtr6fWm1ba5QXgcD1MewYRCyFpmCs6HeZ7DDxD/Pq
	 M1bFn+eBM/2WKzmHSgTdMD6aNTlWQQF1vYRdt/Xzi2A3PEnwNyDQmQGLQZ0eSrBHFi
	 +E2UDAHJB7b2g==
Date: Mon, 27 Oct 2025 21:51:19 +0200
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <aP_NN3HwO4Hp0-9T@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
X-Rspamd-Queue-Id: 598CD41B65
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.41 / 15.00];
	BAYES_HAM(-2.41)[97.29%];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	HAS_WP_URI(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: IQECSUBURPBQJ7QG5O72PUHSA6CPQVCU
X-Message-ID-Hash: IQECSUBURPBQJ7QG5O72PUHSA6CPQVCU
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, linux-crypto@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IQECSUBURPBQJ7QG5O72PUHSA6CPQVCU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
> the current time epoch to its NV storage every 4 seconds if there are
> commands sent to it. The 60 seconds periodic update of the entropy pool
> that the hwrng kthread does triggers this, causing about 4 writes per
> requests. Makes 2 millions per year for a 24/7 device, and that is a lot
> for its backing NV storage.
> 
> It is therefore better to make the user intentionally enable this,
> providing a chance to read the warning.
> 
> [1] https://github.com/Microsoft/ms-tpm-20-ref
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Looking at DRBG_* from [1] I don't see anything you describe. If OPTEE
writes NVRAM,  then the implementation is broken.

Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
distantly relates on using NVRAM.

[1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf

BR, Jarkko
