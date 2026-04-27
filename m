Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29544FF8860
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:41:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 499AD43296
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:41:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rImnEOXV;
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 448C543296
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 13:41:21 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6948fb494a0so4140151eaf.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 06:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777297280; cv=none;
        d=google.com; s=arc-20240605;
        b=P/TgqN0o0uKD5UMMuyKtOv0UsgWLLr31iyQJbuKPLi5wDyX8bIoAOGOthnWMDD7EWK
         pNodiVkC+WdQSjQNzsaoRMzNMVosw1hxVJM6d0uUPaCP/XKHqoBmITX+DAWuYDYsN4xx
         i/UfRSDIBVOBKjzcC/al9XvkT+BIwKuZh2Di00138CpaDMJ6/0+ky/HL6x4PggczX5p5
         RqyYTCdU9IRBoe3YZWGOca7iGgS2ELU5BiFDrVju4zYBiQ5IYnPd0o5vd4ESoC2UB1x3
         kVcnc7zfu63z6TBrtezs1Di5y606qqsrzY+gi761KjTPuPiPYrLarbKuyNc61afwj7lT
         FWNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fwyr/KMD+0QPgey2JMgc1xj/yK1FRCHF8OYBDsPQa/o=;
        fh=uJxHwXSvWfo9wbggpACxXe6vhcyfP5aPGv4fTzcoW4U=;
        b=RFc6AmqqsQ86V+s8NW1xmoemBHXsirS2bqk1uRVpZsDSzBk/4xVFVNRlbzwA0sDKln
         VVADhYEtqdBCT+vrT/xyv+PV8RUBPc82XCxvvzesbjRnlhb3XZqTc6Hgh+ukDCPPxugV
         LvfqWlIwuv+mRFS6+e9oDSkdJebgE1DlTYYIUAhNtwPNdj3pvxaQL9znS47ffVdELju8
         C5/JqMWW5++CFPoY4p8hdJ9Z1m9mh9dIIAwSAcdooGQxfLwmauSXprAqz5r0eyMwOJNb
         aVkJ6n9+MA4jc6ESpWeO+H9fLZKX2SlkrmQ1qKEFYnh//r1gc+sJDM6DfT/a0KdjqM4E
         5XNQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777297280; x=1777902080; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwyr/KMD+0QPgey2JMgc1xj/yK1FRCHF8OYBDsPQa/o=;
        b=rImnEOXV5cvZx9e2eobHMujbb0QtRsdNgRX38FYrgsGZCc5jKnP6HifMUUffRwT/3F
         IjRmn4bhEx5d938SnX0ybgAfIxA9jjuofPW8xdFQGRnSjArfhV5FoTba1iHvW9egmZQi
         miov5fmG/KG3FHHvJjZTTHa3upWE7YorB7tvzdi7FGydre5uY6aNZ5zpmBlF1TTyzC6x
         4M9w5yumoPoJE3J+Tu0PaN693YD24ADlM8PKQQf8stb52GSPVeNZsyPzKOt1JcWQmxCe
         3z2JtZtO/eBHAEaAs18+S513+oQuzt16F6oExFT3H1DSmMcCpMX4MOYCEw+ttuBSwv8l
         w2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297280; x=1777902080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fwyr/KMD+0QPgey2JMgc1xj/yK1FRCHF8OYBDsPQa/o=;
        b=Zf9qd001ouAX+WVjHzdFm0V1SrIkYxOadCCS7z+9vs2d3PBk5OFfwvOerVRDFSoIHW
         2PJfF7uY3JUepUEGVQ7brlvhIy1kwlTbN4SbvOxCy5UXEEJm1sZxdPjaTOB3hrecBEMe
         RKttYOYMXL52ee0hSU4TWCGYZuOpFw6Si1IwROQH/VSq4D8554ayuyRX32/ysOTU80Vg
         IKgNTpx10HKJ/8XJ04nR84oQPy74WBZShlCH+NuyI2xTSfjxAqMbbDTRfwrY4E1g/6h0
         t+wqVkfGx0SK5IvD0CTRjxhVWi8iW0HBtc2zAtgA3HeAc28K92+xagGzF3f2VV47w9/c
         IgVw==
X-Forwarded-Encrypted: i=1; AFNElJ/bC7M/qQPaULxNuuvCFuQrXL744daGUd67qrfMwC9KM5ZFlshLXZQf/U9JMLmdX21Gxyt+diM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyhFzOKcANSCvRAelLZexPpNsbvtoSD7hW3iBDWyTrFAlz3+T1t
	fGZ6PBpqeRPRXMcv9Wb4F2RvCnJHXZUrr/InI033VrsNBjpPR4CY7/7tc+TEl+eZdLgYOnKVmuc
	eugZcTOGXmrxca96Um81eWvCCcHvPFQ41+lDxL9X6kRop
X-Gm-Gg: AeBDieuKnScetfjBF25teZXvFGbKlsRUqicnSiPhaVCeVLyWBZ9k/RkbYr9ZzagLRos
	550bSN86f541brzqf8nRvSkMu4j4vMm+a7Y9dBeC3dSb6wa09teQ14i6uNMDs1UEclR52+SMm0+
	witN/4/s7kTyIhC24RM2sI1DkrHZri05nP3DgAZ6G69/6I3lYNM10xiOZ/JH2uokdegoPLqDIyP
	9C39sFrr97QmTkKRaDEr2/e5UW5zmHRXHPg1HBuQ47XObcm6hxMpegdmflfaQoQ+fQCqNU3kRSp
	FY7T1f0vlD0f4NLufAdLFNGyG70ihykGns2aGcbm/1aGcrBU
X-Received: by 2002:a05:6820:2d04:b0:694:a02f:75ad with SMTP id
 006d021491bc7-694a02f7af1mr14774938eaf.59.1777297280605; Mon, 27 Apr 2026
 06:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260408155203.817744-1-g.osokin@auroraos.dev> <adyxWXpcxJ3f0w6G@sumit-xelite>
In-Reply-To: <adyxWXpcxJ3f0w6G@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Apr 2026 15:41:07 +0200
X-Gm-Features: AVHnY4KGDDzcbe_kY_EznatCHWqSNW-a9BNkxArEfnRPZk4daViwyL1DENi3efE
Message-ID: <CAHUa44H2hsPfBFvQwiC4DvSaZ8Lag8S0aOy_KTY5z+b=WQdTLA@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: fix shm leak in register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.49:from];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.161.49:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 448C543296
X-Spamd-Bar: -----
Message-ID-Hash: N6IVB5ZVTV7TNX3WMCNKQUKSXVCTWET5
X-Message-ID-Hash: N6IVB5ZVTV7TNX3WMCNKQUKSXVCTWET5
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Georgiy Osokin <g.osokin@auroraos.dev>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, s.shtylyov@auroraos.dev, stable@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N6IVB5ZVTV7TNX3WMCNKQUKSXVCTWET5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Apr 13, 2026 at 11:03=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Wed, Apr 08, 2026 at 06:52:03PM +0300, Georgiy Osokin wrote:
> > register_shm_helper() allocates shm before calling
> > iov_iter_npages(). If iov_iter_npages() returns 0, the function
> > jumps to err_ctx_put and leaks shm.
> >
> > This can be triggered by TEE_IOC_SHM_REGISTER with
> > struct tee_ioctl_shm_register_data where length is 0.
> >
> > Jump to err_free_shm instead.
> >
> > Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer=
 registration")
> > Cc: stable@vger.kernel.org
> > Cc: lvc-project@linuxtesting.org
> > Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> > ---
> >  drivers/tee/tee_shm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks for the fix, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Cheers,
Jens
