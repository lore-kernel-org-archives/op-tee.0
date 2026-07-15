Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E96C44501
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 10:08:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B7143450BA
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 10:08:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=zpmbl2FL;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q75VdkqB;
	dkim-atps=neutral
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 49A1644D93
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 10:08:32 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CD8D1400152;
	Wed, 15 Jul 2026 06:08:32 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 06:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784110112;
	 x=1784196512; bh=lPHgauackYEA3Zksqy1iO0oh/lPh0KhZioEaiLQkJA0=; b=
	zpmbl2FL+0aHAmLPvKz0L7WnrQuybqcLIuLWUYATyKqyshWvtsX1NeG0ev2jHFbM
	Ml/v5AEdA4xhGLFgYVWHBoCrizCpdNJ9qwN3Ht+eFkMUblh8j5wFkxKEJGo7uxpy
	lmDbfsp7lgOka8hCIe+w5+67dJuk365JJuUBoMnfZKUUKyyj5DobG+9dsaDGuT9O
	TGfRrUz3kQz3PmAFKtkG9yihPvgEhu9rBchf352RlWqYCvwqOVhRqbW/Y1kFrTAj
	LycOrEoIoW/entI4UBUAn5HFrKqRJwtmVH/nrDHiHuOv2IL45CI8U/W194SxCcie
	bc4w1EXXBx5KaQKQf3YTLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784110112; x=
	1784196512; bh=lPHgauackYEA3Zksqy1iO0oh/lPh0KhZioEaiLQkJA0=; b=q
	75VdkqBV1CdQujsmy9tGEaehpaUK1qncRNLECzm42K0jfThpOewueRD6W6yWGwXK
	VpFeLC5qiW9CVgkz/xkTiEO3O17uxB1UUgczsjP7ksuJPbdyDRT4fQz/AVVsErTF
	IvO1LChZ3f+tjWQMKsIhoksbRMLqZrHe5qnfYZFGPb4TZBOFrXBOpB+IMVgxSPIO
	+IqPgvh0FFgunJm/HcT6MXRpmbvTiQz34FaKSFBuZbjgB0Imw2x/WWV9AbpBNJqE
	AVIOkYGN197POJUmAAdDRLuFLxSUsS5ZaLy2E9SeFPMTFBzH8BNwasIzSJPPZoVO
	BssY3Iv1odD3iDG2SC4Kg==
X-ME-Sender: <xms:H1xXajhlKy9vJNoWuEe-UWjkA5QSiTp-1AQx9NHXqMT532XqRJIOfA>
    <xme:H1xXaq08mc1CO2HS4xavsJwSCZvmx0oZ2GybCxRtaj-vnllxIC3T_2y5ry3-3ACCs
    InRe3NJFPE0hs5KL5sNhE_jcTg4f1naEZ0L-d2BhgHtA2_VfQzdesU>
X-ME-Proxy-Cause: dmFkZTFDRUJDyjePgysxqXJQ16EUKXvgSDSCQjVkQltyrtLGqCT9wySOZM3XF1tWSbdksV
    cpyzWH2Gn51lhYYzUHt6Tr7TTPt33i21xMLfvI5Z74kmdlLuhlE587PfLL1VkWjxjc6UHC
    Z5YgkozwGEKnnxxQGQ0sZ8/fBqRNZHy6AWTo5ReH16rlPjUP59Spj9e/cn04bTsVmwvHZX
    ZGeaoibSB9/c/TtSVpn0AUQENB39OXJ8w4GPMqiY6GvE6gohh5c0lIu3W77rE1vFlFjbpV
    elbvcCIQ/hkHCpfE4mP2box/tzJL4x1Djv4k3jve1T0yM010g5qtsTxF8tnQvyTuKsfAn/
    Q4mpBqu5mpuI0ZSidtTd9XufpEQ4vKSiEuFZW28YJaUbwPXpr4goWCp4lUi0Ye+hca8oxe
    r+4u2LEMJPpcNrT6nUS4QqnPUAHoYer1l1yBvGPOspDe5dMVho22Jgfa+Zx4AGhmTHBJvV
    84WV1UEt/yAv5hpZh/OYaEm/zRL9/6AeY8maiFTKu+6TKwSeMGHU/q1KlDmA6/YpNFJUqk
    LOFVx7F+nMsn10nk4tvRYsP9vnQonVOwwTdMVQE4PGJW+mHWDDBr5oArrWFpzZoLTUBjbm
    OKu64K0RfQtNxu26IBNDQn78Ipb7mg8KA8eV7IkK0PodG+tqPMaghrfQIezQ
X-ME-Proxy: <xmx:H1xXasFELHaiR5RG-K0iaCWexOi9rvwQIKcJ54EG6s5-Qlgg1MW5Fw>
    <xmx:H1xXam7pOAnF78oyz7P3gQSubXUZgTuMygzJC5sZ3vF5ZaSu64g2Rw>
    <xmx:H1xXalbO5up5CtH0SSSc8YMYkvZc_qJRPmN85cs3iNyZ7ROjSvR4KA>
    <xmx:H1xXakjw7VdvX1J6Laal6AN5hZL6laLLIYxZ7UL1NQox5Ir0iglkug>
    <xmx:IFxXarlduciFxuwEKuAiyqtgj3UMV3Kj51JgUFlruRTyQUhGq8wZ6guw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EC8C182007E; Wed, 15 Jul 2026 06:08:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ARzfbCXOFmpN
Date: Wed, 15 Jul 2026 12:08:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Braha" <julianbraha@gmail.com>,
 "Amirreza Zarrabi" <amirreza.zarrabi@oss.qualcomm.com>, jenswi@kernel.org
Message-Id: <a3b7a752-8cc4-492a-bb62-43121b852c41@app.fastmail.com>
In-Reply-To: <20260715092539.18384-1-julianbraha@gmail.com>
References: <20260715092539.18384-1-julianbraha@gmail.com>
Subject: Re: [PATCH] tee: remove dead select from kconfig
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.49 / 15.00];
	BAYES_HAM(-2.90)[99.59%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:103.168.172.128/27];
	RCVD_IN_DNSWL_LOW(-0.10)[103.168.172.152:from];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ASN(0.00)[asn:151847, ipnet:103.168.172.0/24, country:AU];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[arndb.de:dkim];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_NONE(0.00)[messagingengine.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 49A1644D93
X-Spamd-Bar: --
Message-ID-Hash: HE7TA63LE4LREIOL3PR6VZKD3PH2NIY7
X-Message-ID-Hash: HE7TA63LE4LREIOL3PR6VZKD3PH2NIY7
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HE7TA63LE4LREIOL3PR6VZKD3PH2NIY7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Jul 15, 2026, at 11:25, Julian Braha wrote:
> 'select' does not work on config options in a 'choice', so currently it is
> possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE.
>
> This patch removes the select.
>
> I've compile-tested this and found that it builds fine without
> QCOM_TZMEM_MODE_SHMBRIDGE, but I don't have the hardware to runtime test.
> Please advise if it would be better to make QCOM_TZMEM_MODE_SHMBRIDGE a
> dependency.
>
> This dead select was found by kconfirm, a static analysis tool for Kconfig.

Right, clearly something is wrong here.

> @@ -5,7 +5,6 @@ config QCOMTEE
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on !CPU_BIG_ENDIAN
>  	select QCOM_SCM
> -	select QCOM_TZMEM_MODE_SHMBRIDGE
>  	help

From the implementation, my guess would be that QCOMTEE actually
requires QCOM_TZMEM_MODE_SHMBRIDGE and it only links successfully
because of the stub helpers added in 8aa1e3a6f0ff ("firmware:
qcom: tzmem: export shm_bridge create/delete").

If that is the case, we probably need a 'depends on
QCOM_TZMEM_MODE_SHMBRIDGE' here, and can remove the stub
functions.

It is also possible that the 'choice' itself is wrong, and
this should be detected at runtime. It is a rather odd Kconfig
option, as it sounds like only one of the two is correct on
a given hardware. The CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE variant
contains runtime hardware detection, so it should actually
be safe to enable that anywhere. If this is true, we could
just turn the choice into a 'bool' symbol and remove the
generic case.

I've added a few more people to Cc that may know the correct
answer here.

     Arnd
