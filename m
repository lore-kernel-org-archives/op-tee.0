Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED93C5DF67
	for <op-tee@archiver.kernel.org>; Fri, 14 Aug 2026 11:37:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5F9E145391
	for <op-tee@archiver.kernel.org>; Fri, 14 Aug 2026 11:37:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=KPwjjmOA;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SD+7rnhy;
	dkim-atps=neutral
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A7E98443A7
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Aug 2026 09:58:29 +0000 (UTC)
Date: Fri, 14 Aug 2026 11:58:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786701506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxWpvadK3n6moVFqr6tu+oa5IvKI8pRrhdl4IxiG0Es=;
	b=KPwjjmOAAsDjzyu/Gp2Is5rLKWk09wmmsGGZ9DATJ+IesHwSwsi54lqppv1egnGRaCxBl7
	ST66EfYaHfepFz0eHteV3IWCOIW56EJdSMhHg1PM4wjQXqCwOhJhMzpD/7zyyQuTK2nC74
	pD7NNSe7e+IZ3TBFJdGoLbkxnIpUz1SoNVY0Sg+54CiV2OW3K0bQ4NXa4v5oHm9YDMqLWX
	NZyvryIU1QexdjbKQCnfTLgYc0/uwvFgjyg5Z+HBqtGDtcfV2ZrB55CGHgJSTMxgKRbu/z
	jbE/FQn3TfUtf5u0F6KkqCCjlGSIpjGrN2b4gz3O9pGvQet34C3AkPXxGTS31w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786701506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxWpvadK3n6moVFqr6tu+oa5IvKI8pRrhdl4IxiG0Es=;
	b=SD+7rnhyFkknUKZPrIyp/qa1/O3UO5dv+//xZrPWMAe18wi6Xoi9dWFWAZ4ruBrBnFYqxK
	rZHGYxSXaEUiBMAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Documentation: Extend the real-time hardware bits
 with some firmware bits
Message-ID: <20260814095824.yyCVtcMa@linutronix.de>
References: <20260718175041.QXn9iOFK@linutronix.de>
 <20260813082400.h3MRgRPg@linutronix.de>
 <87h5kyhwfr.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87h5kyhwfr.fsf@trenco.lwn.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.31 / 15.00];
	BAYES_HAM(-2.71)[98.75%];
	DWL_DNSWL_LOW(-1.00)[linutronix.de:dkim];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+mx];
	RCVD_IN_DNSWL_MED(-0.20)[193.142.43.55:from];
	ONCE_RECEIVED(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:48314, ipnet:193.142.43.0/24, country:DE];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A7E98443A7
X-Spamd-Bar: -----
X-MailFrom: bigeasy@linutronix.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GWQGL5OKAFR7WIBSHTZDIGVPTILPEY3C
X-Message-ID-Hash: GWQGL5OKAFR7WIBSHTZDIGVPTILPEY3C
X-Mailman-Approved-At: Fri, 14 Aug 2026 11:37:30 +0000
CC: linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "jenswi@kernel.org" <jenswi@kernel.org>, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GWQGL5OKAFR7WIBSHTZDIGVPTILPEY3C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On 2026-08-13 09:28:08 [-0600], Jonathan Corbet wrote:
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>=20
> > A gentle ping.
> >
> > On 2026-07-18 19:50:41 [+0200], To linux-rt-devel@lists.linux.dev wrote:
> >> I have been reviewing how OP=E2=80=91TEE is implemented and how secure=
=E2=80=91world
> >> invocations behave. The goal was to determine whether an OP=E2=80=91TE=
E call can
> >> delay the Linux side and introduce latency depending on the time spent
> >> in the secure world.
>=20
> With RT stuff, I never know when something is deemed ready, or whether I
> should be the one to pick it up...  I have gone ahead and applied this
> one, hopefully that was the right thing to do :)

Thank you. RT wise there is no dedicated tree so I always rely on the
upstream maintainer to apply my bits.

Here, for v1 I wasn't entirely sure if what I wrote was entirely correct
but then Ilias and Jens gave me a few crumbs and I am confident that the
document reflects the reality :)

> Thanks,
>=20
> jon

Sebastian
