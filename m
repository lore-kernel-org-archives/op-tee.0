Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85228CD5BB1
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 12:51:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BBAE743B60
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779367885;
	bh=7jzHvKRd/On+GRBlud+zh/apk/tg0aHT5tC2fNXMtRg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FOyDrgUwToguab9SFdcR3IjXSOnUiqyr1IOMcOFxXPUZWdq0INQmHAkSm8zVE7ZDY
	 9nm1gXXYyscH4H5N48AKHxvVxF3G3xRCBQGVrxWvWtnuPz5B0MqTB3w0VlpKtlN5eE
	 RbW1Ir+iaDBy3rZHXf4uqOloCvmj8DS4JQI4wX5suSsmVq8eFfAQ+vqtsva68rGekT
	 vx9cLPJCe9kTi8otyP3qxsxGw44YPRNRnUui5j6TX3BTtEg2uCnRBK0xAnq98kWGYU
	 bTPmBnjDuZGcMhPxd3uGDFYEkB9jz5XjHaJgoFtLa/SAHSs0HfPmCzA8zNHOyUHbj8
	 zud+BSbW4dyCw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6C18141BB7
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 12:51:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BkToSujN;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09E75601F4;
	Thu, 21 May 2026 12:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399F91F000E9;
	Thu, 21 May 2026 12:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779367877;
	bh=53MBMVpYsah1G6NU1zmq3jtKdic1Gk+mrU5myoZHcTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BkToSujNclyXcE88OzhY40ufvQn2cBGui3KuvHUppU/C9uik42OSCjbIQqlUp0FIf
	 01BFXGNtxBBf3a7CeCM8rndojcNt2MN8sA/1RQ2dVXcqPbR9TmXZXbD8RY7XQRqVuq
	 vzMNbPTwmKMeuUjg4JGCRHdyGZkz/GkwGF4/E12viTb43aA+fqmDHYM2cedyi5ikYR
	 ochACvQ3dea/2IQoJjm+7upgYdeJfdaaOItq8r+auwNgK3PZWxquM/lO3XeDuxEH7T
	 xRvHLTIceWp0qqY40Cg6lcme/SuObotCdw1AP8VMP9uTfFKj2C5PgG+k8k8rGhLdBR
	 BXz1IUF6qogcA==
Date: Thu, 21 May 2026 13:51:12 +0100
To: Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v4 2/5] firmware: arm_ffa: Fix out-of-bound writes in
 ffa_setup_and_transmit()
Message-ID: <20260521-gleaming-shoebill-of-artistry-5d738c@sudeepholla>
References: <20260520204948.2440882-1-smostafa@google.com>
 <20260520204948.2440882-3-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520204948.2440882-3-smostafa@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6C18141BB7
X-Spamd-Bar: ----
Message-ID-Hash: F5ZOKXMK4TJIVVYF3UVUI52BCZYWEYWC
X-Message-ID-Hash: F5ZOKXMK4TJIVVYF3UVUI52BCZYWEYWC
X-MailFrom: sudeep.holla@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F5ZOKXMK4TJIVVYF3UVUI52BCZYWEYWC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sudeep Holla via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sudeep Holla <sudeep.holla@kernel.org>

On Wed, May 20, 2026 at 08:49:45PM +0000, Mostafa Saleh wrote:
> Sashiko (locally) reports multiple out-of-bound issues in
> ffa_setup_and_transmit:
> 1) Writing ep_mem_access->reserved can write out of bounds for FFA
>    versions < 1.2 as ffa_emad_size_get() returns 16 bytes in that case
>    while reserved has an offset of 24.
>    Instead of zeroing fields, memset the struct to zero first based on
>    the FFA version.
> 

Neat, I clearly missed taking this approach when I added zero-ing of
member initially.

> 2) Make sure there is enough size to write constituents.
> 
> While at it, convert the only sizeof() in the driver that uses a
> type instead of variable.
> 

Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>

-- 
Regards,
Sudeep
