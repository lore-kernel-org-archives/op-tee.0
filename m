Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778AEC5B572
	for <op-tee@archiver.kernel.org>; Thu, 13 Aug 2026 15:28:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9E81844DCE
	for <op-tee@archiver.kernel.org>; Thu, 13 Aug 2026 15:28:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=heQUmYoM;
	dkim-atps=neutral
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E626644DCE
	for <op-tee@lists.trustedfirmware.org>; Thu, 13 Aug 2026 15:28:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BC835408D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1786634889; bh=qVRpckEi8M3RGXpcyKaTknYqIEBsqHrZyu1cIn1LCaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=heQUmYoMt4jWOg5Zq2KdxS19awWIgQUdZDMEj9GZfv2zFthlp2WDGhcW38kwXCuqm
	 wVI5RP5mlRkxDkO3vpSf3ufjDfhaXPIN/0cdI8yEDZiS2OHDKn/J8fSM4IkxkSGUAi
	 VlWssZj5Q9VYWSu5v+f5iy/Ybmh9FD1YD1uyxXCvByU0eMy/Iw6WyRaMPzC99PsKUY
	 qBmSu/DnfmeCbBWuXAjXnEfG3ZekZxDTVK4+6AXlPws8S0WDlm8dot7zksAKXvatSn
	 aKq0RmQmUPncuC6Ml0+hXHQvvoUsfZkaKZjNyv4SJhaiqN/vLBVXfcU/ypp+43jYdx
	 IEuy3DKkH5fNw==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BC835408D9;
	Thu, 13 Aug 2026 15:28:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Extend the real-time hardware bits
 with some firmware bits
In-Reply-To: <20260813082400.h3MRgRPg@linutronix.de>
References: <20260718175041.QXn9iOFK@linutronix.de>
 <20260813082400.h3MRgRPg@linutronix.de>
Date: Thu, 13 Aug 2026 09:28:08 -0600
Message-ID: <87h5kyhwfr.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.13 / 15.00];
	BAYES_HAM(-2.33)[96.89%];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+a:ms.lwn.net];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	ONCE_RECEIVED(0.20)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:63949, ipnet:45.79.64.0/19, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DNSWL_BLOCKED(0.00)[2601:280:4600:814::1fe:received,45.79.88.28:from];
	DKIM_TRACE(0.00)[lwn.net:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E626644DCE
X-Spamd-Bar: ---
Message-ID-Hash: 6ZZN5YEIABXOAOCWDWZBOMWNN5ZIDPXO
X-Message-ID-Hash: 6ZZN5YEIABXOAOCWDWZBOMWNN5ZIDPXO
X-MailFrom: corbet@lwn.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, "jenswi@kernel.org" <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6ZZN5YEIABXOAOCWDWZBOMWNN5ZIDPXO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> A gentle ping.
>
> On 2026-07-18 19:50:41 [+0200], To linux-rt-devel@lists.linux.dev wrote:
>> I have been reviewing how OP=E2=80=91TEE is implemented and how secure=
=E2=80=91world
>> invocations behave. The goal was to determine whether an OP=E2=80=91TEE =
call can
>> delay the Linux side and introduce latency depending on the time spent
>> in the secure world.

With RT stuff, I never know when something is deemed ready, or whether I
should be the one to pick it up...  I have gone ahead and applied this
one, hopefully that was the right thing to do :)

Thanks,

jon
