Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0F4CAC59A
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 12:26:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0A98341855
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 12:26:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pwrowh5Y;
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6937441847
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 12:25:46 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07e3a77b72so286831366b.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 05:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758198345; x=1758803145; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WO5w8wVpyDMRZrArSRp3gDeYYYwk2gERvSbhsNUFqqY=;
        b=Pwrowh5YxlQmlW8VA0RZ59Vet9rV+Dcp8uxXm4W6UIv1cVE4QeS9b/Gja+1xuiFTzO
         LUJKk76R77Uswl5ymaVQrghdroytYStwRsFBTS4aPzHnkqpcGrjuNS4dTseDFU4mICD2
         wfnzx3tZNo6htwBAiEJpOBNUFZ4f82amPEqo1PYfnI1rUxjJgmCscLFFnJmquXcA18Y2
         4uBlp5g8FqZk5L2HQe5xGMNZ9c8e0LaZUq+fbjBz1SJv1rd9iH++BC4MXxa8HNG9QlOC
         hI5cO0PPydJtuKcWrRDiRc6WBuDVyoXohKahM+jQfwRQkKYdm7/rjlINYa+pk4O/5h8k
         voJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758198345; x=1758803145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO5w8wVpyDMRZrArSRp3gDeYYYwk2gERvSbhsNUFqqY=;
        b=OLd8PtVVBeWd4ce354u0LD88GXv7Y4kxwUrBDD3KUgGiAcpRssTEHxCE8xVK2FVUtt
         jFNzXxcDzmwed+JOPi2TUFq1ypEeWHFclXZFldPEx5svfLoU6ZSCVGh9+xMCdEyh9jkH
         o+oeMd+I6mFZUYd+vS/8eWQmmHFP0uSAXBXFimfnKtZV9GUVw7JdM71Kh/VQXpt8GmvC
         tE02kyBlSKcJb94xIuZUHp6kRD4H+7o7FHxhAB6l6kmdFj6YoZ9aiaghl2z+Afsm6ZmW
         +m69jNZxelWFuhs5JFXg1oYwuzMUhNyyANkaZLaTSzZ0hoiwvPpLoYT3FSe3TY5diYK2
         Z/Iw==
X-Gm-Message-State: AOJu0YzUYgVAhhMmfrzCH6m/NcU5wxAJPc2+e3KjeipgvDYD8I7ps9hG
	0Ihk35Jd/WKn3pwkob6jpxUYLku07AeZEy5Kgfo2K6Zx05azC39ImGqhEqod2oOaYL23GQ==
X-Gm-Gg: ASbGnctMPRYa+Y7Rd19ozrRAsHRAfGUnuCZ0CRS6zXedN/tn9ZzwH8gTRaQ4ZYAMYy9
	7vXF3J/Tw0P7JNQr4EUkcEu4kHH3KLO0Rb+GNU8448IDnP0CMs70kpPsC3VleY+xuPpQR9JM5+K
	wZB2iDpj/Ij/RwKaij29uwcT+1ZBpA6uPiAxgvjJkHxxNyD51Af8j18hpbOdTEjLiU2/lwJPjRL
	dcLOAgUm/0jrzTvyCJOTtMXNgNuhdps7B8CfqfmQUZubY5ORBLHydpxjEG42gCu7/ad6X54fSjZ
	SxmxZAZvSpRvBWEd7FNTz5+ie/qX2psyI1juqFz9mBO9yKT5eE4j0ShJvKkBuBGeKjliqBFfgDl
	wUk8otxHB7URgf+lW9VM92M/zYxjeOUe9EZ/FFxxR9Tv6t75bO7NTmpfYAGKfMiP34jHfBITE5P
	vb7AAJeek=
X-Google-Smtp-Source: AGHT+IFod7PCz+PgFskqGgur7UPoiBS4D10R8MBJ/w/wG7+WkAk/PIFajsLe5vKpzLiCrvlZ7LEYBw==
X-Received: by 2002:a17:907:3d4c:b0:b07:6390:322d with SMTP id a640c23a62f3a-b1faa40a70cmr335569466b.9.1758198345235;
        Thu, 18 Sep 2025 05:25:45 -0700 (PDT)
Received: from rayden (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5cf9bf2sm1341237a12.3.2025.09.18.05.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:25:43 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:25:41 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: Masami Ichikawa <masami256@gmail.com>
Subject: Re: [BUG] tee_shm: NULL pointer dereference in unpin_user_pages() on
 invalid shm pages
Message-ID: <20250918122541.GA2693176@rayden>
References: <CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com>
 <CAHUa44FmMj-=5cd4TNGS0ve6jryeCUWeYt=2Um4c_1St5wvL3A@mail.gmail.com>
 <CACOXgS85UPo04u4z35M+sKe21gU6=8a-y1kALqeTWXv7UkZkag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACOXgS85UPo04u4z35M+sKe21gU6=8a-y1kALqeTWXv7UkZkag@mail.gmail.com>
X-Rspamd-Queue-Id: 6937441847
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.44:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: QOVJZYP2PLMFLMWSA4AUYVHREILCW7TB
X-Message-ID-Hash: QOVJZYP2PLMFLMWSA4AUYVHREILCW7TB
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, sumit.garg@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QOVJZYP2PLMFLMWSA4AUYVHREILCW7TB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Masami,

[+Sumit in CC]

On Wed, Sep 17, 2025 at 10:58:11PM +0900, Masami Ichikawa wrote:
[snip]
> I wrote a test program and ran it on both 6.17-rc5 and 6.14. I was
> able to reproduce the crash on both kernels.
> 
> I uploaded test code and test results to my gist.
> https://gist.github.com/masami256/11e21a7503812af7ee1e890080093a2c
> 
> The test code is crash_test.c. This program takes 2 arguments. First
> argument is malicious buffer size and second one is actual buffer
> size.
> I can reproduce the crash with the following pair.
> 
> malicious buffer size: 0xffffff
> actual buffer size: 0xff

Thanks, that easily reproduces the problem. The following diff should fix it:
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -318,7 +318,16 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 
 	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
 				     &off);
-	if (unlikely(len <= 0)) {
+	if (unlikely(len < num_pages * PAGE_SIZE)) {
+		if (len > 0) {
+			/*
+			 * If we only got a few pages, update to release
+			 * the correct amount below.
+			 */
+			shm->num_pages = len / PAGE_SIZE;
+			ret = ERR_PTR(-ENOMEM);
+			goto err_put_shm_pages;
+		}
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
 	}

Cheers,
Jens
