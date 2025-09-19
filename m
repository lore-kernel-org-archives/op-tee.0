Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32183CAC592
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 06:06:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 639EE4317F
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 06:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758261972;
	bh=LF8ITAmwQUqqHoHUuXCraIPKZZTT7t5RTFFwxhd+ULU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wrlGr3Mbkdsu2IS5iw9cj/FAQcFoBBmxdm4lIRWrD4AYd+4O1aj53pMWUc2wIzXUp
	 LgmJIQBam6WgYzlpqgW+g8QrqtFp55xdWW5p//NoBNbTpKDCPbcPpFAefMZCQNF7oi
	 CpKOx886TD6+po9ZbBB6KTPHF+6zPPP3D1ZLvMr9+kh2/B0CLby4GixWIsWYZwhJ6x
	 OOierO6ZVERGzkV/1NhVZGxJ9He3XLMn7A8bcbNJMZap+K40a66q6fQC9DdPJdHaKU
	 a0VlmglHgAPhzoZNzYNm407BB/c02PIII15Jjx1i2smFQcBEnW93Ak4x5UnzXeYQwm
	 TTNJ/N7Z+Ew/Q==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B560D41867
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 06:05:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uSV7lxFf;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CDDA60097;
	Fri, 19 Sep 2025 06:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594FBC4CEF0;
	Fri, 19 Sep 2025 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758261956;
	bh=LF8ITAmwQUqqHoHUuXCraIPKZZTT7t5RTFFwxhd+ULU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSV7lxFfUy745qdYE9kkpsW0AAElH0IggqGWzHjsS6bsf3hgaBqDJTIdKdyFU1F3+
	 75se/c8mu++kCkQHCzTZqcWEv7VFWMvOo8LIXHesmDgNcsiK87+0fIPEMbinW/7DDB
	 50oNMcLLB7NHLOHJkMFlNroSmCLjizVCXzVRJ0Y+XJWl3nAoVGdJhuE85d+FAd+KzN
	 qnJhrFY5OloxuFs+++bHulppVrfFnreSTkpr4gc5/cgBa+U2mOBHCqsTexOlkMlMxL
	 AWmfoJbXrleRf+arrv3WvYOhEIUWYhWi6dXKbGuwT7uYEjEamvmvgYQYlyiEdbg+Jc
	 OGXoMFWUA679Q==
Date: Fri, 19 Sep 2025 11:35:51 +0530
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Masami Ichikawa <masami256@gmail.com>
Subject: Re: [BUG] tee_shm: NULL pointer dereference in unpin_user_pages() on
 invalid shm pages
Message-ID: <aMzyv0BKFOiE9Jgm@sumit-X1>
References: <CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com>
 <CAHUa44FmMj-=5cd4TNGS0ve6jryeCUWeYt=2Um4c_1St5wvL3A@mail.gmail.com>
 <CACOXgS85UPo04u4z35M+sKe21gU6=8a-y1kALqeTWXv7UkZkag@mail.gmail.com>
 <20250918122541.GA2693176@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918122541.GA2693176@rayden>
X-Rspamd-Queue-Id: B560D41867
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,gmail.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: OEETEXFDZICGRUDVCIC464AQZE2REBQA
X-Message-ID-Hash: OEETEXFDZICGRUDVCIC464AQZE2REBQA
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OEETEXFDZICGRUDVCIC464AQZE2REBQA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Thu, Sep 18, 2025 at 02:25:41PM +0200, Jens Wiklander wrote:
> Hi Masami,
> 
> [+Sumit in CC]
> 
> On Wed, Sep 17, 2025 at 10:58:11PM +0900, Masami Ichikawa wrote:
> [snip]
> > I wrote a test program and ran it on both 6.17-rc5 and 6.14. I was
> > able to reproduce the crash on both kernels.
> > 
> > I uploaded test code and test results to my gist.
> > https://gist.github.com/masami256/11e21a7503812af7ee1e890080093a2c
> > 
> > The test code is crash_test.c. This program takes 2 arguments. First
> > argument is malicious buffer size and second one is actual buffer
> > size.
> > I can reproduce the crash with the following pair.
> > 
> > malicious buffer size: 0xffffff
> > actual buffer size: 0xff
> 

Thanks Masami for the report and the bug reproducer here.

> Thanks, that easily reproduces the problem. The following diff should fix it:
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -318,7 +318,16 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
>  
>  	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
>  				     &off);
> -	if (unlikely(len <= 0)) {
> +	if (unlikely(len < num_pages * PAGE_SIZE)) {
> +		if (len > 0) {
> +			/*
> +			 * If we only got a few pages, update to release
> +			 * the correct amount below.
> +			 */
> +			shm->num_pages = len / PAGE_SIZE;
> +			ret = ERR_PTR(-ENOMEM);
> +			goto err_put_shm_pages;
> +		}
>  		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>  		goto err_free_shm_pages;
>  	}

Thanks Jens for the fix, it sounds appropriate to me. I think this
commit [1] introduced the bug in the first place as earlier check for
pin_user_pages_fast() would have caught this issue without crashing the
kernel.

Jens, can you please send a proper fix here? I hope we should be able to
get it merged for v6.17 since it sounds critical to me.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7bdee41575919773818e525ea19e54eb817770af

-Sumit
