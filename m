Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49502103E168
	for <op-tee@archiver.kernel.org>; Wed, 18 Mar 2026 12:40:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 84E1B43AC1
	for <op-tee@archiver.kernel.org>; Wed, 18 Mar 2026 12:40:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=tjlZ4MWe;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=fVCS1m1q;
	dkim-atps=neutral
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D590D41A40
	for <op-tee@lists.trustedfirmware.org>; Wed, 18 Mar 2026 12:40:03 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 691191400227;
	Wed, 18 Mar 2026 08:40:03 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Wed, 18 Mar 2026 08:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773837603;
	 x=1773924003; bh=cMsP1ViDg5+W4pJB6stHHF7Nl0q4BrWqMobLx0PpOAk=; b=
	tjlZ4MWe9PaM979xGZvpvNsGyZ/AcWs0oRo5lCY0nNNZTObdfy2AIUokOCi4GAxW
	H6MOK50dkD+vRbRimLBrlAP5uKx7W1rp+1HKHnpM4dwWzolLutF3/uCegCEp4VVM
	a5M+oD2hxc0TTSm6i3toB8nD+PcnZacwHbnFzXYUeXCVbPYBzv56vuRXbnSYXlhM
	wg+WWG0pKJnKOEbxRM5I2Im3D1DGBWU9Vfl0pK9FC5EjrhHWUFif1P8hHiDzadg9
	boCkEygOIt+Sr2IwEMR/358IY6XXeiPu5gRcR6s/I1FEVqkvR728p9AHJQIQaU36
	noJBkbDUkndEWQ49jXJqJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773837603; x=
	1773924003; bh=cMsP1ViDg5+W4pJB6stHHF7Nl0q4BrWqMobLx0PpOAk=; b=f
	VCS1m1qtsMUmrQTaAcRDredHvUIGbCx5+Gsbjj3mrTtLxqwEeA+3mt6LIwarVfeZ
	xEf0Ocb3D3pUo7pDCAZ+Wv4fTE3phDx5xf+sxTp5cYcqX9jxuDRJlarP5oNCSm5b
	TfJgMam/vEdrfaxoZXtFa9wQmazap6eVepyGUO8HnO87TN7DE3Ancth9/+hNHSnE
	m1/5g/9oyGh/ju1mBlzkIrKWFgpsajSHGHbZ+FN0I/J/ZIrfIhOUJa+eiet5s4GL
	El4jOFf4aLUy9GSGunJU+lYtDzNWNpvW978BxjdzZf0W/2RTMA3O+3UK0jyRa67s
	mVT6Z4/easmFiJW/wy9Ww==
X-ME-Sender: <xms:I526aUZoKAr2ABc8Bxq6p-V-WeNALCsnCskTLGNQeGNmJybXXzftaA>
    <xme:I526aaMd-lBZV4M7fUmyzKYEAyntinqC62SRHWUNdAmRz_DTCkZ_AFtplEGsP0xKJ
    9Cf2sMZ_kTj-eEqn8iNNoDL2p9k35EaQMPiNOgLF8S4TrpWPeBQc-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdegudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    grrhhmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhotgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhumh
    hithdrghgrrhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjvghnshdrfihikhhl
    rghnuggvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepohhpqdhtvggvsehlihhsth
    hsrdhtrhhushhtvggufhhirhhmfigrrhgvrdhorhhgpdhrtghpthhtohepmhdrfhgvlhhs
    tghhsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:I526afrMwZuND3ODxHRPsRascj4bUDDvq8TAE6I1mfmg-dPE2LgTnQ>
    <xmx:I526aaGYxkPrEBwQfcbCGFahSc6_62DYojymnYBpddGE-s3jsq7Bjw>
    <xmx:I526ac6eImRoTkQwCKpbaF_DS_elu1kcH2MkehticNzO248xGMfvEQ>
    <xmx:I526aaeYHj9TzXIm5QQfV1iFH9_tL7v1I1EHBsgOtVC0uO_VkKst8A>
    <xmx:I526aRhtQBjnMD8dbafW_JKe82g3aF5s8m2gPD8jY7mKzCZI0rE8lbIg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E93D0700065; Wed, 18 Mar 2026 08:40:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AeiqtKTVlxuV
Date: Wed, 18 Mar 2026 13:39:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marco Felsch" <m.felsch@pengutronix.de>,
 "Jens Wiklander" <jens.wiklander@linaro.org>
Message-Id: <c3f1a10d-8437-4d17-8dfc-286935ba9e51@app.fastmail.com>
In-Reply-To: 
 <dfidrflp5p637dqnn2e6sqr6gbp47gimjlkechjjtlbr7re2e4@kgwofxcumhes>
References: <20260316074150.GA2474723@rayden>
 <20260317-illustrious-finicky-frog-90a86c@quoll>
 <CAHUa44HXjrPbPv0sBxzrW6o1iQVWdp2p-1-jroukZ8dxSvPmMg@mail.gmail.com>
 <dfidrflp5p637dqnn2e6sqr6gbp47gimjlkechjjtlbr7re2e4@kgwofxcumhes>
Subject: Re: [GIT PULL] TEE shared memory fix for 7.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:103.168.172.128/27];
	RCVD_IN_DNSWL_LOW(-0.10)[103.168.172.155:from];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:151847, ipnet:103.168.172.0/24, country:AU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	DWL_DNSWL_NONE(0.00)[messagingengine.com:dkim];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D590D41A40
X-Spamd-Bar: ----
Message-ID-Hash: 7WDHRTRMJNYS7O6FLYBNBBS25BO45YNQ
X-Message-ID-Hash: 7WDHRTRMJNYS7O6FLYBNBBS25BO45YNQ
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Matthew Wilcox <willy@infradead.org>, arm <arm@kernel.org>, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7WDHRTRMJNYS7O6FLYBNBBS25BO45YNQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Mar 17, 2026, at 13:53, Marco Felsch wrote:
> On 26-03-17, Jens Wiklander wrote:
>> 
>> I'm under the impression that it is a fix rather than an improvement.
>> However, since it has been stewing for a while, it's clearly not
>> urgent. I don't have anything specific on the bug fix, other than that
>> we're supposed to stop taking those refcounts. Perhaps Sumit, Marco,
>> or Matthew can add something?
>
> It's a long outstanding fix regarding memory page management. The
> userspace gets informed about this memory API misuse via a warning print
> incl. a backtrace. This gets triggered only if userspace uses OP-TEE
> trusted-keys or the OP-TEE EFI variables. Therefore I would like to get
> it into 7.0 but 7.1 fine too.

Yes, that is clearly a bugfix. I think we'd also want this to be
marked 'Cc: stable@vger.kernel.org' as it should also apply
to 6.18-LTS and 6.19. Greg tends to also pick up bugfixes that
don't have this, but it's generally better to be explicit here,
especially when it's not obvious what the impact of the fix is.

I've merge the pull request now. If you think this should be
in 6.18-lts and Greg doesn't pick it up by himself, maybe
let him know about it.

      Arnd
