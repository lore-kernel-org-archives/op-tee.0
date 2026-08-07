Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87137C2A09B
	for <op-tee@archiver.kernel.org>; Fri,  7 Aug 2026 18:33:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A729644FB2
	for <op-tee@archiver.kernel.org>; Fri,  7 Aug 2026 18:33:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=a5YNimiF;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FgltBKpo;
	dkim-atps=neutral
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 19DD843EF3
	for <op-tee@lists.trustedfirmware.org>; Fri,  7 Aug 2026 18:33:43 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA3CF7A0137;
	Fri,  7 Aug 2026 14:33:40 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 07 Aug 2026 14:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786127619;
	 x=1786214019; bh=+83ROu88lRdHGZBoOtDkwCA+Lc2V9LWZEWP8SlAiCH4=; b=
	a5YNimiF7L1f7Z19fhuk+5STRW31cSPxw+ZkHpp75Ltc8YmYelMKtHaoHE14Ot7T
	CDcADweGFtw2JDtulK2bGVriewWw3BSeUFlAK7GwBPp8W3pX16McTLNfvJ/37mhS
	kUE0RptGiEhhp3PtiFCODDMsFGB/GiMo7ymqwAYeP9cl5s9pJYCtVVXstOqBu5ON
	VldMafhYkJatcMBc7gbRb40Ap16PoYLjmFjTDnGpjIkRagvSWDfnUhS41C1yPETZ
	8rXbgSifVKWigXuX9mbSmdprYjlFC+sVHNr0hBBiGqh6dIRUTmEWSIGqkDcT66BO
	I+spOXa96wmXssjmRzs5IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786127619; x=
	1786214019; bh=+83ROu88lRdHGZBoOtDkwCA+Lc2V9LWZEWP8SlAiCH4=; b=F
	gltBKpog3kkeIlzaq6F8DmR23SQYUobr6K/Ya9aXYyH77RnST/vjIp+6a7oNCvOK
	rS/W7K8VwFEXARH9xmFKXGdnGuqTpPpor7MZY8kAKtZx5gTvTzp0G1CRDXstcN/v
	5DFIvrXIFnGRbNcvOcx1X20mt9cRdX2OvMM3WRGpXe5lzLMxjfiy7LI4+DZhEWLD
	8KTM1rX5aewEaYMUdeSJJ2EgzgSdpIMCMC9ZPTqxQWARzYkrqNmY0rRasS69aGUK
	YEL/Ji9AQYE9EQLiaxo3SfvIcM96Jqwq6OBQUTRqU0lbDlxH/4PJTGdUCObVmi5u
	DSHIzHLaUOFMRlUwB0mRw==
X-ME-Sender: <xms:_CR2av2djDCTGcYerfRtZT_4DITI1ag30YVwj58R53ObOEG-bkX2kg>
    <xme:_CR2ao5mm-guU_gpAToLj48pZNozegwPGsre5YTbYg_rXkMf0T8PwsNmFuDpJt2k0
    GANInFnqeqqKVk824RvPV8WWfP4QsHKHqDo-vGftSX-4yuBZQAxqQ>
X-ME-Proxy-Cause: dmFkZTEfIkrECFw70ZARuEcaICLiuZSiCqh3VwtLq2ISHWO+qEk3tofnxZpVYmSurTidOa
    siSpMg4jBav9+Uq1l0fGscbZPeUA2d3T+FqezpMkkrUOC3OyuqIZ9UhoSIOvbTw0HRWzVL
    3agsLlrwOZg7zTJ5bY9DtuvjAnWkv/+U1M2QuoI2x03wQr5CMeXpvDrXU/t9CHy0tiGs4d
    MoU/WW9FILcfuwHlSwo+fCheJh1rSpSYT8LR1CUcRsoggf51DdiGgJ6twLnnoYjFMDCXwI
    7cs2b5P7pCTuj+gHH6HWygLfZdiVN9qzWq/OOLTRIl9IiKj7PO9EK28oX8hNXZaybE6RHi
    EIVvP59FoZvEGIiEdkIByZLwb9T2pJG2J0SeLO5utf88UtjDYoTbhpzzqPf87oUux/NJXe
    CpxADZgaZe3AEkqluio5nZEROil0/d2k3bT9EoH4Ghy9PIXjbj6T7ccdhhNZ7Q1Ey7uyIQ
    +Np9ddxFgTYohntAzlW5nrC5Bd+dqOf6rCyRcWtJE7gj/1QkORgpFi7AKYcyaPwqV8Nv8t
    OxE3mGlkquVZJw8YinvwZdfJlKVyAOjSS/8aiTG9ztWceWBkcC9SK8ug3P6Hp5+jcls+wr
    ACvh94XxuYM0cPrdS4cJ3eh0zU/iYfYT6xFKA/ubOv7HnqcpoJR3wiIyAX/Q
X-ME-Proxy: <xmx:_yR2aqV80Ecw86enCPE3Cp-V0Rudyth6448S9EeYhTxQR_FlHcAK2w>
    <xmx:_yR2ai4aX4-cuQWyao_aXgtWaJt6g0yaY4KgwyI9E_MHMYmogQ46GQ>
    <xmx:_yR2agAcYT1wL3ea3R8sGhEh9Xa_R1G0Ay_LFOfHXOrak6m2RORTuw>
    <xmx:_yR2aueqxXpx7yYoI6PUWhppA5-rRgEmw-qljHECeMy2zyc__kveyg>
    <xmx:AyV2aoNJAR9p1azBJVc99XifWDWKUz31Fw79aHb8HMPLCp5BNApq2Etu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1528632A0065; Fri,  7 Aug 2026 14:33:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: ALRCEgKlol_-
Date: Fri, 07 Aug 2026 20:33:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Braha" <julianbraha@gmail.com>,
 "Amirreza Zarrabi" <amirreza.zarrabi@oss.qualcomm.com>, jenswi@kernel.org
Message-Id: <5722e3b7-f605-444d-be60-6fc0792566cd@app.fastmail.com>
In-Reply-To: <20260807175041.3299349-1-julianbraha@gmail.com>
References: <20260807175041.3299349-1-julianbraha@gmail.com>
Subject: Re: [PATCH v3] tee: remove TZMEM_MODE_GENERIC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.58 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:202.12.124.128/27];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[202.12.124.152:from];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:151847, ipnet:202.12.124.0/24, country:AU];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_COUNT_THREE(0.00)[3];
	DWL_DNSWL_NONE(0.00)[messagingengine.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,kernel.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 19DD843EF3
X-Spamd-Bar: --
Message-ID-Hash: UUTHP2QMAMAXCMWILZQD44JOMR6HYGNQ
X-Message-ID-Hash: UUTHP2QMAMAXCMWILZQD44JOMR6HYGNQ
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Harshal Dev <harshal.dev@oss.qualcomm.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, Kees Cook <kees@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UUTHP2QMAMAXCMWILZQD44JOMR6HYGNQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Aug 7, 2026, at 19:50, Julian Braha wrote:
> 'select' does not work on config options in a 'choice', so currently it is
> possible to enable QCOMTEE without QCOM_TZMEM_MODE_SHMBRIDGE, even though
> this is needed at runtime.
>
> There are no users of the generic allocator option,
> QCOM_TZMEM_MODE_GENERIC, so let's remove it. Then, we can remove the
> containing choice..endchoice, which allows the 'select' to work as
> intended.
>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> Changes since v1:
> - remove TZMEM_MODE_GENERIC instead of removing the dead select

Looks good now.
