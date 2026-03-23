Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F4BEC01D4
	for <op-tee@archiver.kernel.org>; Mon, 23 Mar 2026 12:11:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7256443DFA
	for <op-tee@archiver.kernel.org>; Mon, 23 Mar 2026 12:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774267901;
	bh=+V7bc4/5lTZPzVaQcdFvZeZCEi9TT7wqSQRDVxe3JGk=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RAf9nGI1PKe19M7PE3GOtmeCjltA4KkIbvaRl4iUnzDNPvaUE+jvlwJ6RWRdXZ65A
	 hWLGlGjDJVDqsUalQwakVNsOagEPwhqkp7d9jnD6FLQJoT7RziyxO1MVWTYwcxiDsn
	 ygAwZMpqNoEfAa0zi8YFnU+AQBl9ZQnOxWwnye5/Iu64O4mqhzfSEtXPfvF2pW3etE
	 VfWV3PcZPlbMPmFrZtwL5afopeWYnM6rn10DV4LLSFF/JWZkdlZfyo1dVIAZKpSQe+
	 0WlNlovzFP4aeOCXK6aM7XBX9otrpE1JEOJTAyvTK3X6zMCe8+29bdN8gcKcsca1MW
	 Q3zGk34BE5dxA==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CCB8143970
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Mar 2026 12:11:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tu0ZumBt;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2ADF54241E;
	Mon, 23 Mar 2026 12:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE955C4CEF7;
	Mon, 23 Mar 2026 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774267881;
	bh=+V7bc4/5lTZPzVaQcdFvZeZCEi9TT7wqSQRDVxe3JGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tu0ZumBt3+UHF00v+LQcOpaXuKDg8ix9xwyiQhv9gr5cTX3PUTKm3C9iIV3ETlP3R
	 AFrn1TQ5K517Kb73svj5AurL/EXTgh/v7P0dc4oJweP9h2bb/MEOLCOItAJXDCqMul
	 Kwl1ZBt/Hgt0LBPvzilbHk8FwgLnQbtgZG2RT/eCb8noUhoKZLZP4HmjljKc/+vscZ
	 aTpH0gbbFf919Rz/EsWhIJ+qi8V8MZ8iXAImA7EgiiPhWvrCGzSP/HcH6e5jzffcuj
	 dn1oDOgPpuPk5l2UBe6UvbXvx4yrJLQoVN0zP9g5LCjHNtvPm3KHJcRFz7kRQ0C/ZQ
	 SMQi1a36h5XAA==
Date: Mon, 23 Mar 2026 17:41:14 +0530
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] TEE shared memory fix for 7.0
Message-ID: <acEt4roJbZJoRCJC@sumit-xelite>
References: <20260316074150.GA2474723@rayden>
 <20260317-illustrious-finicky-frog-90a86c@quoll>
 <CAHUa44HXjrPbPv0sBxzrW6o1iQVWdp2p-1-jroukZ8dxSvPmMg@mail.gmail.com>
 <dfidrflp5p637dqnn2e6sqr6gbp47gimjlkechjjtlbr7re2e4@kgwofxcumhes>
 <c3f1a10d-8437-4d17-8dfc-286935ba9e51@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f1a10d-8437-4d17-8dfc-286935ba9e51@app.fastmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CCB8143970
X-Spamd-Bar: ----
Message-ID-Hash: AQWCAYSLILFWALJVWEXSA6QZBCUCCEDV
X-Message-ID-Hash: AQWCAYSLILFWALJVWEXSA6QZBCUCCEDV
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marco Felsch <m.felsch@pengutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, Matthew Wilcox <willy@infradead.org>, arm <arm@kernel.org>, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AQWCAYSLILFWALJVWEXSA6QZBCUCCEDV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Wed, Mar 18, 2026 at 01:39:41PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 17, 2026, at 13:53, Marco Felsch wrote:
> > On 26-03-17, Jens Wiklander wrote:
> >> 
> >> I'm under the impression that it is a fix rather than an improvement.
> >> However, since it has been stewing for a while, it's clearly not
> >> urgent. I don't have anything specific on the bug fix, other than that
> >> we're supposed to stop taking those refcounts. Perhaps Sumit, Marco,
> >> or Matthew can add something?
> >
> > It's a long outstanding fix regarding memory page management. The
> > userspace gets informed about this memory API misuse via a warning print
> > incl. a backtrace. This gets triggered only if userspace uses OP-TEE
> > trusted-keys or the OP-TEE EFI variables. Therefore I would like to get
> > it into 7.0 but 7.1 fine too.
> 
> Yes, that is clearly a bugfix. I think we'd also want this to be
> marked 'Cc: stable@vger.kernel.org' as it should also apply
> to 6.18-LTS and 6.19. Greg tends to also pick up bugfixes that
> don't have this, but it's generally better to be explicit here,
> especially when it's not obvious what the impact of the fix is.
> 
> I've merge the pull request now. If you think this should be
> in 6.18-lts and Greg doesn't pick it up by himself, maybe
> let him know about it.

Thanks Arnd for picking up this fix. Last week I was on business travel
hence the delay in my response. I see Sasha already picked it up for
backports.

-Sumit
