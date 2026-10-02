Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4ADCA5FE4
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 21:17:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C19A64522E
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 21:17:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=XDFwohhb;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=CjNitlPj;
	dkim-atps=neutral
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5520644F00
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 21:17:47 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id B87E8EC0176
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 17:17:46 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 02 Oct 2026 17:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790975865;
	 x=1791062265; bh=YX7f5u1JAxSjRaaI8LoRy7woQY9evgYyUE4A3mVXrJo=; b=
	XDFwohhbdyvMVgoVNzE34ILFZPZsBzNkZtOVPLOdg2DoLWLMqVn/ZjghTdLoKs6H
	hAixXvzH7jBemHZwf8HA91H16m7D7mmLRx6Iuv96QE6O3ExeXP8CXucJ3iUUP0t8
	Tbb44YKKjoe2t20483jXnOOy5Glaks4SAbKteRAulIwU2m4q7MCy5qVTCOQiGg30
	cQpRbU5Zb+2dOb/nNcses34tdv+xWTO0BUjQaeTA5OLUdP7cbxWyFC2sa6HuB+Fb
	POpHN6nAWhIFHnaINIvcDXxOgYBeSY4qIbWtE0KLSj1l156mXHf6Uzs0/zpFCh7k
	qP3LOYC6g5EK1a00ZpQGaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790975865; x=
	1791062265; bh=YX7f5u1JAxSjRaaI8LoRy7woQY9evgYyUE4A3mVXrJo=; b=C
	jNitlPjJ3/T9rV+YlZjIUQLTMAHuKNNZpI4JdoTwJZLjr7MFnDrAR0XYXi0CwQAB
	cM5nKYx9Iee5QPh1/jdGe2WhH8dwgTJ39RGvwY7pVWfZz0wn+UQuEwJLHVxPy9Bu
	JQOUaBxvDqtr65r9wdjWg86J/jB2pHhp7xm7hR3sGaVEqdaYCw3Rpk9SpM8yTKxG
	EDMzEFwh4BnSDseIib0C1J4e3oNkGMVk8SBt4/oL4iHxDfoKAhnpjL71BhcdlQNL
	Cxk41q4jcwm+y/huAFwnDj7dqOmUAIGGiV3zv/lQruFL11Eq8mJUU9/gWBBah2I6
	cdc/ITP6GgMmG7Tzut4Ug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790975865; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnPg==;
	s=fm1:rsa-sha256:GrerAFWs6mCl1sHYvL0YVEHS5KSZcp2mjk/gPA+IMDCUffh
	eOx2BSKt085ZDCug8E3MyO0R5+yjjhOe6wQdzC2TGrUtCz4s1xF9MoU4qnXPZ2z7
	7AvMgM/Ha5YSK0DwP81lTkujyQYV1i041eLuZrgNpXSXNEpgYxAR9qLpwxAOC2L2
	HWTTar0nwLm+bcu7Vrt955IOaePd7WZhhqakiCQm1gMX14M+xQ7vwT+KasG+1wp7
	8HkECFiC66MAbCNVUv6jYW1qnDtGVfwWR1WcivXp/lxZgGfpBw/+5B9V6AU8TA6i
	FKBnM6RTGLFm2YyKFzy6zt5M3yKqC/ygcyEMfpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OgrhGqbnQeK3nZJVUWQxI+pE8gcw3piOULHYYH0INTM=:SwVzjzCEvI9xgzYskQdRtxzYscx6RxP9paKnYNf4bDY=;
X-ME-Sender: <xms:dR_AaupNS1Ce6Kdq4kz4Wym18PH2nIG-kkw5a9u4q0KvX0m_CDpDFw>
    <xme:dR_Aanc8V3Na32mXaSmdoL1eTJkTM7Zuv8dIo96caY8M1Aa9r6XfhgC5UAo0cy7J0
    Wla46N5w48zuyav1bvHLkM7eAB0R04rC3cMqD3kwSgt0hbx_NMg20oe>
X-ME-Proxy-Cause: dmFkZTFk6SJTZ93NKA+M5MmtoYXlTCu0kvb9TOLJqOnPE7J0SxG8MNqPZR74cfLdrecoi7
    nAI3UWr4DeXETGdfJFiAmiWLs9jlAkS8prf/7AupP/qsmbMaNlAJv+i/yStg0CSwIrbrI0
    mW0kj/Yt92wMoCxwno7re/0y0kf/hv7E6/ixPkVHZq1d68Eah5PCBXKG+I8MZ2h6R0iIIn
    3FyBCYfX+zEN4sUB9qqjss6eO8CZyewbVBkEtmzISTAEKudyq1asy4AF8FyKeAkZOCRXe+
    XCi7xBT/hYmV1v9QbscGDx/L8y6F25zKYR4zla0S2anieUYhtCjDRKPXYM3sBkNdQ8EXMj
    eCHe7uJjoDUWSx5Gr93PEc44jkOUFPUeMVKFutR0SU8pbPDQ1t7HT3YtAv1lyWv3hiNIPZ
    YslURpa4JTQMlzJuoDtgU3vRw+EfLSdVj6Qb570RqBEazrDeWPzJtfgWUm3XM1UBJRUOeM
    BIMrU7gs4wTfXKnjx3X+/w5zY5Pt2Fb0yh44DjMjwmB200xMnAAjbA61ww7ukxrh4tEakn
    59MVrTv3kUdIyHvzL71gC7DQnBt0H7X2ovZj9izhY4WA9DTGqZTUnJ4yXd8w3+EPViAU0T
    73bxaWgY+RrJAXijWwfJJaztiTaJOnTyNUEAPQYf87MgjJWz2d21SQDUGgrA
X-ME-Proxy: <xmx:dh_Aarcegph4Yfs-VXEY-JkimoL4oqDeyGxQPKjPxf0jf5QhRV614Q>
    <xmx:dh_Aak6_JNH1OwlQS20eNjz0XAnYsvhyxvxb5oPwhlxwAzZ3noJ2rA>
    <xmx:dh_AauXiMFmN19nwQBNGljdKhyLgDh_9M_BEFdx1d6XN1jbPIKMB1w>
    <xmx:dh_Aaj7Js4qyXLKKhU_qUz7i2ry88WjBcZd9-o_x8fiuz-hlbqoivg>
    <xmx:eR_AapvWjpnnrQ8gq0auOo438PvFBpSK8wXqV5xa6CF9VIFi6dUx3eWK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 979CD32A008E; Fri,  2 Oct 2026 17:17:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Aw6mAajFSntB
Date: Fri, 02 Oct 2026 23:17:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@oss.qualcomm.com>
Message-Id: <67bbda51-d1b6-45ad-b798-d8c0e53bd23b@app.fastmail.com>
In-Reply-To: 
 <CAGgiveXqFFi+nq0834+hwBBnwJssh16aayZBgh0toYCVN+OMmA@mail.gmail.com>
References: <20261002142443.GA778834@rayden>
 <84c1dc64-6380-42e6-a501-9be86666e5e7@app.fastmail.com>
 <CAGgiveXqFFi+nq0834+hwBBnwJssh16aayZBgh0toYCVN+OMmA@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE fixes for v7.3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.99 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:103.168.172.128/27];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:151847, ipnet:103.168.172.0/24, country:AU];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[103.168.172.147:from];
	DWL_DNSWL_BLOCKED(0.00)[messagingengine.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5520644F00
X-Spamd-Bar: ---
Message-ID-Hash: QJHCRLOQ3TQSGG2ZNQ5UCQ3KAV4XGAGP
X-Message-ID-Hash: QJHCRLOQ3TQSGG2ZNQ5UCQ3KAV4XGAGP
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm <arm@kernel.org>, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QJHCRLOQ3TQSGG2ZNQ5UCQ3KAV4XGAGP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Oct 2, 2026, at 21:04, Jens Wiklander wrote:
> On Fri, Oct 2, 2026 at 4:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
>>
>> On Fri, Oct 2, 2026, at 16:24, Jens Wiklander wrote:
>> > Hello soc maintainers,
>> >
>> > Please pull these fixes for the OP-TEE driver in the TEE subsystem.
>>
>> I noticed that the contents of this branch are not in Linux-next.
>> Is this intentional?
>
> I made a small last-minute change in the commit message for "optee:
> register TEE devices only once fully initialized". That's why it may
> seem new.
>
> "tee: optee: ffa: support shared memory offsets on large-page kernels"
> is brand new.
>
> I thought it was better to send them sooner than to sit on them. Both
> are added to my next branch, so I assume they will show on the next
> update.
>
> Please let me know if you want me to keep them on linux-next for a
> minimum number of days before sending the pull request.

Thanks for the explanation, that makes sense. You need to decide how
confident you are in the contents before you send them, I was just
worried that this had not seen any testing at all because it was
inadvertently left out of linux-next.

If you are ever not sure, just mention that in the pull request message.

      Arnd
