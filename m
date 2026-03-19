Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DBD1075274
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 08:07:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4201643AC1
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 08:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773907629;
	bh=LND9QP38YR3zwrHcZrV2AQ0j85RMG+MUPI/TxNx7ph4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QaFuZLNcPQ0HPRkc4XWA4ziNT5Eo7y08xF7bpYzbkVDPjzCYvsperx4Rhr2+ls3pu
	 npd4VgfVN7ffEVTqpNOH9kvxcSbKZw9kCDLWI1jjLULicTkCwr2Tgi3DR2729UyJFX
	 TOUmlQfhOLLgQovJKG65yfHtVH8BQW3tWBw1GathCpnJso9hVsQ3at6V5jr4l0Wy3X
	 427vaYxpVNN9LOAAI0t0BkHErFhJE9KOwMjSnYo0vSCkNovgt1mOnafxk20uTqHLtR
	 I+srgKFuJ4lqwS1/aTLCtSEpktWT5pzPY9tg/LFCpZyiGqoXLZ7C3wzFHun0QoYlqJ
	 yMGV0lRd8s2KQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E8BB243AC9
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Mar 2026 08:06:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mAoLMsnh;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 822E06011F;
	Thu, 19 Mar 2026 08:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D19E5C19424;
	Thu, 19 Mar 2026 08:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773907587;
	bh=LND9QP38YR3zwrHcZrV2AQ0j85RMG+MUPI/TxNx7ph4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mAoLMsnhwO55TSj97BpIYQ6GGdnoo4+804Ny+0owESLqk3FJnTkHlhyv9bLhrCF99
	 0sT9NpOmTKokTvdExb8z1iErj+uk0TzkZSU4ditf/VT0VWAYsiFFZTHZWFPSA16YBz
	 HGR/abXCzo4q5Nmyw6affJxlSHF78KGysbFhvCPbYOEvMAGCORBZkJKJ0R+UAZYJ8O
	 qAgEa3Sl1SpgbcJmBhJAcZdxXh84wI39Yqazewcwl3riFVXoG6FzQetlqQ50sJ0QmB
	 u2L2i6/3KU4FprDksfvPZ2uG4Xm+QPvcKE0Egk0g9uftSHIuR8QAnY/gyQMB4se5cW
	 +2bWg2UcYBLYA==
Date: Thu, 19 Mar 2026 09:06:24 +0100
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v21 2/6] dt-bindings: remoteproc: Add STM32
 TEE-controlled rproc binding
Message-ID: <20260319-prehistoric-mongrel-of-essence-fea9b0@quoll>
References: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
 <20260317180329.1207625-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317180329.1207625-3-arnaud.pouliquen@foss.st.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.97 / 15.00];
	BAYES_HAM(-2.97)[99.85%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E8BB243AC9
X-Spamd-Bar: --
Message-ID-Hash: AWNBREKRJPMG66EWNTEJZ7NQFQPU4TDP
X-Message-ID-Hash: AWNBREKRJPMG66EWNTEJZ7NQFQPU4TDP
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AWNBREKRJPMG66EWNTEJZ7NQFQPU4TDP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On Tue, Mar 17, 2026 at 07:03:23PM +0100, Arnaud Pouliquen wrote:
> Add a Device Tree binding for the STM32 remote processor controlled
> via a Trusted Application running in OP-TEE.
> This binding describes the interface and properties required for STM32MP
> remoteproc instances managed by the TEE rproc service, including a
> linkage to the TEE backend through the property "rproc-tee-phandle".
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---

Heh, and standard comment...

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof

