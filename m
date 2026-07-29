Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D97CC54FD4
	for <op-tee@archiver.kernel.org>; Wed, 29 Jul 2026 20:44:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5196B450AA
	for <op-tee@archiver.kernel.org>; Wed, 29 Jul 2026 20:44:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=LA8cMU4t;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pQBqcZ7j;
	dkim-atps=neutral
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7148444B06
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 20:44:48 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BC8114004C6;
	Wed, 29 Jul 2026 16:44:48 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 29 Jul 2026 16:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1785357888;
	 x=1785444288; bh=RMzwvYHivvwMCA4cSUXvZ/AnBt0SLt92Pn3dEMB74zE=; b=
	LA8cMU4tP2r0XnCyvJyQglT7zkjmg8e+Wa4cW2qE0XTFDHY1dxKlWXtHlpTBEl5e
	ZeK2+ZOzfZfjEdRIlULw/H4NAlW6j1l+KM4PS1syQP6GXPBvSXSJeuIQY8bE5Xg7
	x1wUgqHUX7WKXhoedfmH3PkBzQ0f1de1e0Rlyr0W28SijJyD8udNi9deiAUKiTy2
	POEzFqxn0ZP5b9KTEgxzBE62qBU8B84vah5UzGhzHdg+sguBoRFNckezYP6YTID8
	HMGCIOlXlH5KSRu9OrnrxGnAjSjadBOALFmqKnVdHza77yak4z4XWNhJIrwtLht6
	z/PmecUWwzeCjBaQOt3jZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785357888; x=
	1785444288; bh=RMzwvYHivvwMCA4cSUXvZ/AnBt0SLt92Pn3dEMB74zE=; b=p
	QBqcZ7jJYbnShk51U78SPJ5IOP5ydAGyMAbZonA4khjj0p/FF6J/wPAd+QRoYuTl
	Lzf++J2jy24tZMACVvS+PEnrM/e6hlf6O8ihkmel6Gv5Qv5+DJRecyrrZpRo99Lc
	zeld3iKePrEhYz+sAOnJZ3BPbnGNtWwWYjILr3if7fyHOltEkW/CQt3+UBIms7QZ
	Z4nljRfZSG97duC6TW+REN+x17kIbCN4GddtUweFNBnv6t7y1Y2eHQ6JsgWJIJrZ
	mrqlUPykm6WiEjNxiIEc9CtghIUTFCWIt94hDhVCua7Qx60TpehIQrhSRJ2F15jw
	V21KC0lS+++c0JpQZALZg==
X-ME-Sender: <xms:P2ZqakI7AV0ZwB1kwn50hUz7VzMIHhMQWyRlA_KvNlzsdXtqIgJC8w>
    <xme:P2Zqau9aKm07v2pguEYY4OBI3A0e_1btO7DQNsH2l1R-Akn1yDnhe7s0iq5jHhpLK
    aTlGY4tQBPc31BdeBQ3MhRXCRMhhv8oAPj5uhqEOsq64nuaoaiRmAXK>
X-ME-Proxy-Cause: dmFkZTFN2/yijz+VSH0eWUuf1WU5x2LAexjetzkO64FnT9KGZeuaN+V5wUlzIowqmDoGr/
    J1PP/TrCnh03jgMOKmxudEcDdnwH0CktM1aX7AyqtG6mAVmduXqxlQ3V+5Wwcv5DXsGzki
    aXW2SLmt7LOx+kY7GSW663c/u1zZNNzvFr7YhS20DCpsRdOFERuktXxE4ezkR3vNUIgU76
    1SBB565hxKBU8IoqRVv44brhNyjfbAMGl0EKDviLIYg0doi8BWHjvTdk3WiGlqrhC2/0P9
    RlkiuycLIq8+Fe5regAeO4pAdgXxDsA7MQ8mFlcAA+R8DxWnUBrPIXi1j9OQzNwrPX0Pc1
    kIQVCvrA9J8ySSxGlKPWC1Q39xecmMzdiM/hrdJQkEUs7yIqFowQqxpQNA6ayWL3kpRFng
    6h95GrBYlVKXv0261j6sMvbO0oWCz9DWv0TF2t1qqWl67jO9Sk5AFN2pUjrDyBDp531zTu
    VvUpF0xUyMOFVWPNLhXwL82aX1s7apNdXZmFpcNYhd6Yytr+x+q3pJ3aQqSYBpTJuiFAgf
    Y55xPLPJQ0TFVWmzvXxTnFng9+iCbwMNfz2wK+Y2j6b/Wt3D+EK1guSb1c85w3e4faWRx6
    Z6oxp+oO0phzrYE0L3fwKMcSLNaKfcT0pqvapudSAjpggcdN8rFzyDBrd4Ng
X-ME-Proxy: <xmx:P2Zqarb83K04L7q9ifLmtLJWNd0xqWHH06ds7ascgoPeOcxHn_7jzA>
    <xmx:P2Zqan4A2dePuj-80bWICtrBY5gJOQ3wiB9xOjFlvoMhB67sNCpLNQ>
    <xmx:P2ZqagldxDMN4eomK1Iw5dJCmvS6Uf1S5B3ZgBwcWxNy1zz5Tvht6Q>
    <xmx:P2ZqanEA9c-bV93NO55WaWNBjUPUiDk6lJvOxB2UgDTfEqw1OdoAfg>
    <xmx:QGZqaoBNMINy8ZBPsWsOm0mcpsx6GhVgFr482gvZjsXUsDUcoGjboRU5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C8F57182007E; Wed, 29 Jul 2026 16:44:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Afr29kaEQ4co
Date: Wed, 29 Jul 2026 22:44:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Julian Braha" <julianbraha@gmail.com>,
 "Amirreza Zarrabi" <amirreza.zarrabi@oss.qualcomm.com>, jenswi@kernel.org
Message-Id: <fd47a0ce-4ee0-4a81-8d38-5dbd0d5dc05a@app.fastmail.com>
In-Reply-To: <20260729203845.387239-1-julianbraha@gmail.com>
References: <20260729203845.387239-1-julianbraha@gmail.com>
Subject: Re: [PATCH v2] tee: remove TZMEM_MODE_GENERIC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.59 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:103.168.172.128/27];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[103.168.172.152:from];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:151847, ipnet:103.168.172.0/24, country:AU];
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
X-Rspamd-Queue-Id: 7148444B06
X-Spamd-Bar: --
Message-ID-Hash: 4RHNXANWHYCRRDJHFVSUVX6QN2Q5ZSVI
X-Message-ID-Hash: 4RHNXANWHYCRRDJHFVSUVX6QN2Q5ZSVI
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, amirreza.zarrabi@oss.qualcomm.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Elliot Berman <quic_eberman@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4RHNXANWHYCRRDJHFVSUVX6QN2Q5ZSVI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Jul 29, 2026, at 22:38, Julian Braha wrote:
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

Looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
