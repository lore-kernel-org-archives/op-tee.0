Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CD4CCF9F8
	for <op-tee@archiver.kernel.org>; Sun,  9 Nov 2025 04:43:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AA8DA50017
	for <op-tee@archiver.kernel.org>; Sun,  9 Nov 2025 04:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762663420;
	bh=5CbNfJSCxl8HnzpXwbj6AAiDFFskY5T1/xV5lkIEmYc=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cWRmlZc8vIwrlls9KA+rZ0aOxElDvdlZCsfp514JQ2LPrAPe2+Sv1GIz/XDOJSIzt
	 BSdiKEzAzZGNCKf/5yU5G7WAltEQzluISOpmxDULjYnK0CnvIBOOEz6sXz5r5LUliB
	 gw9Ly6mjtMPlT9Vqa67v3GOq2H/ZUN/9lMvCiQ01I7Rq7E7x3nJqZrR/Y3DodAKvfr
	 xZe0+f7rSwBtqjZPmHkiF47uyoq3OOWk2gs2V5HFUcUEzP7GHxCU8rfZQwfT4a+Kvq
	 63OCCWAM6OrDNnz5/1g2YUoLTF08pzQC5JCXmAF2X2oxNs+DD/QAsgiGQd33IYW7JO
	 a+LyoJ76+IJbw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A4B9243157
	for <op-tee@lists.trustedfirmware.org>; Sun,  9 Nov 2025 04:43:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gsWT4CJc;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 414C8601AC;
	Sun,  9 Nov 2025 04:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB04C4CEF8;
	Sun,  9 Nov 2025 04:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762663407;
	bh=5CbNfJSCxl8HnzpXwbj6AAiDFFskY5T1/xV5lkIEmYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gsWT4CJcOnoXmiMm7bX3qTOENwIr71B6rdC5ssF0Hglo1gwuLcslrSoalIOlQcTj3
	 qROtz73xYD/cMkB4++r3Uelu/oA51M0+S3zb6/seEtoJDMkn9MI9mnmMH5+fgKx6Yg
	 hZ39g+K/Ng4L56glUYuIZqOU+rVE4URpH0XgcNgYuoGDzRbqNvCvwpr7D0d2ACIQYA
	 QV7W45qHee1T+qIhLUPYjC0u/C9kMjd1s8ouDEM5FxnGdYEnkLgK3Gwi4nDqWlEWJD
	 JM8HGcF6Es08PYV06Y22ab4Q5HporTmG9QxkD/DZHfjh4RFSRlhI8MU7SjGwVl3V/9
	 zemUw3GDPDIlw==
Date: Sun, 9 Nov 2025 06:43:24 +0200
To: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
Message-ID: <aRAb7KEPmPmoyQbm@kernel.org>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <9cbee028-81a7-4be6-aa31-907c7cc683e3@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cbee028-81a7-4be6-aa31-907c7cc683e3@siemens.com>
X-Spamd-Bar: -----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A4B9243157
X-Spamd-Result: default: False [-5.79 / 15.00];
	BAYES_HAM(-2.79)[99.10%];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org];
	HAS_WP_URI(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
Message-ID-Hash: BOSM7BVAM4DAJIUDOGNJM6KVG6CVNUDQ
X-Message-ID-Hash: BOSM7BVAM4DAJIUDOGNJM6KVG6CVNUDQ
X-MailFrom: jarkko@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, linux-crypto@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BOSM7BVAM4DAJIUDOGNJM6KVG6CVNUDQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jarkko Sakkinen via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jarkko Sakkinen <jarkko@kernel.org>

On Tue, Oct 28, 2025 at 06:46:39AM +0100, Jan Kiszka wrote:
> On 27.10.25 20:51, Jarkko Sakkinen wrote:
> > On Tue, Oct 21, 2025 at 02:46:15PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may write
> >> the current time epoch to its NV storage every 4 seconds if there are
> >> commands sent to it. The 60 seconds periodic update of the entropy pool
> >> that the hwrng kthread does triggers this, causing about 4 writes per
> >> requests. Makes 2 millions per year for a 24/7 device, and that is a lot
> >> for its backing NV storage.
> >>
> >> It is therefore better to make the user intentionally enable this,
> >> providing a chance to read the warning.
> >>
> >> [1] https://github.com/Microsoft/ms-tpm-20-ref
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > Looking at DRBG_* from [1] I don't see anything you describe. If OPTEE
> > writes NVRAM,  then the implementation is broken.
> 
> It's not OP-TEE, but it might be indeed an artifact of the reference
> implementation that the fTPM is using because it is also targeting
> simulation:
> 
> https://github.com/microsoft/ms-tpm-20-ref/blob/ee21db0a941decd3cac67925ea3310873af60ab3/TPMCmd/tpm/src/main/ExecCommand.c#L99
> (Page 942 in [1])
> 
> -> ... ->
> 
> https://github.com/microsoft/ms-tpm-20-ref/blob/main/TPMCmd/tpm/src/subsystem/Time.c#L68
> (Page 1075 in [1])
> 
> > 
> > Also AFAIK, it is pre-seeded per power cycle. There's nothing that even
> > distantly relates on using NVRAM.
> > 
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/TPM-2.0-1.83-Part-4-Supporting-Routines-Code.pdf
> > 
> > BR, Jarkko
> 
> Given how detailed [1] is, we likely need to address that directly there
> to avoid spreading this issue into fTPMs. Fact is, that there firmware
> implementations out there which exactly do what [1] suggests: writing to
> NV every 4 seconds on every command.

We don't reference code as a certified hardware product, sorry.

> 
> Jan
> 
> -- 
> Siemens AG, Foundational Technologies
> Linux Expert Center

BR, Jarkko
