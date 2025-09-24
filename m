Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879D2CAC59A
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 07:36:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B4A3D431F4
	for <op-tee@archiver.kernel.org>; Wed, 24 Sep 2025 07:36:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V8X1b+2y;
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D342440AD4
	for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 07:36:02 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so43620255e9.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 24 Sep 2025 00:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758699362; x=1759304162; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MzuWivt0fPkNm9SrHmJP3+hKkJHDd8JHQlpF6y9yW5k=;
        b=V8X1b+2yMmJyzRKGKtTsEey2ByIdVRfl4CRwU2NGjp+F47EzUjIIrq0CpntM4sIpBt
         LTfwKqN92Kfsi5uFKUtt0bmLqVzWNo0TeipxnECsoXbN4HNR3mmGkTqCGokqIBaKhHwV
         juIs71cSFcnqIrjYNYqEwvbSOWYXzfmzTwx7o57pmpV4IHf9gqaFiZpPJq+R4qbAdIJs
         FExOENxCX9hKj8/tmohMY3jkP409KEffcdh7x/9wJsEpFQc+FK+NUoCnOoELo8GXEik7
         dhqImkDXFsgQbn+vT7+jvqao1+eNH/Ai69D1zapg0CIh5tzlWFO017BE2C1zb5BP1rfB
         Hamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758699362; x=1759304162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzuWivt0fPkNm9SrHmJP3+hKkJHDd8JHQlpF6y9yW5k=;
        b=r0wEQGYj9z8584JZZa1A8whqiPqnKTr9i8g2CahHJ6gqdhQeNV+wvcv4YoIxk3gq2K
         AQHpRQ9qgOl365aBxPlKVVkGXpMdrO25Bl9N2Kgm4CG81gbUsR+tdc9dQLgU2axxXtpj
         9A8H0yZEbzTBSShHVp9Sk3L0PXTo/rKLCvLNSAtPnx49+LH4WP3zLH0C6WST/J5ixqD3
         mHRY4AmSLRBsRyfcwFtOnChLD5DkyGmoFg4aV0vDuy175ur1WdkMXWNcpLZ2oFXAQ7hn
         1Ayl4DQoVFl6YWsaErAZy0PDd7OCiJmrdk6sN44n79LsdEnHdPBKJ7O3tfASiCnNtN5P
         QREQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgflAbiNHTPk+BDMcP2PZFReN7jZQHfSlU7MhXJD3PWO8JBYCAMejlcwd/0plqPkObveZQ9qA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzdMKsnZsv+tqlg3yMexLTXqYKoHEAsWOXJevqCoNG8bhTYZx4t
	16gN01p+i78SwBAYCA6uR1DhJRNwOqtsPu8g4dfljv5nJ8JP1Ubf6pQikfzj9CVb0Og7WA==
X-Gm-Gg: ASbGnctOfGYnofhwzR9Gm3EoU29SNdigEvtje+I5RSL5zUH8Olim+p40+qiZ5XN8LH5
	wO/NsDaKSwuQDsEjO8G/u7nnXTRqLKcplk8XctntOOgckJxdsj/KayXA40Zyh+Xei9i5EXcAulp
	OMx899P+mJAl/OzNF3ewKe8oV4iQLWazcnq+11GUjh0qDr2zClI/yMKPKIK7NGVBHicSEqGjZvH
	L4lcuAgLWsHyND5T5NR9V4YEpC1pMq4wcthYQqSzL5vdxZnVVsEJB5vexfUMpGrFSPPCrNxV261
	kFjoMbxM/wNzhXoKtFXrQox4Nu9sLT3topBVRG7ZO1QwDCi3vX+/G5XxvSNwjiwURxvWI08HOEn
	pDbcsNXkSZ0DxqL7LiSzNwJTRrtJK
X-Google-Smtp-Source: AGHT+IEH42ZDWAD5VbXw0upHtx03eZMIIKwgq7R48zFJHivJhT6Mw26u/WOxCLoqGho2YLgjitB5+Q==
X-Received: by 2002:a05:600c:4fd3:b0:45b:7e86:7378 with SMTP id 5b1f17b1804b1-46e1daccb44mr41847475e9.34.1758699361781;
        Wed, 24 Sep 2025 00:36:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f3c118cd47sm17190189f8f.29.2025.09.24.00.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 00:36:01 -0700 (PDT)
Date: Wed, 24 Sep 2025 10:35:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aNOfXlG21HIBR18E@stanley.mountain>
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
X-Rspamd-Queue-Id: D342440AD4
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.46:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[196.207.164.177:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.46:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: IPNURQQNOOEGKXZM37ESQWQU22O5BVRB
X-Message-ID-Hash: IPNURQQNOOEGKXZM37ESQWQU22O5BVRB
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IPNURQQNOOEGKXZM37ESQWQU22O5BVRB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Sep 24, 2025 at 08:58:45AM +1000, Amirreza Zarrabi wrote:
> 
> 
> On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
> > On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> >> Re-order these checks to check if "i" is a valid array index before using
> >> it.  This prevents a potential off by one read access.
> >>
> >> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> ---
> >>  drivers/tee/qcomtee/call.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> >> index cc17a48d0ab7..ac134452cc9c 100644
> >> --- a/drivers/tee/qcomtee/call.c
> >> +++ b/drivers/tee/qcomtee/call.c
> >> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
> >>  	}
> >>  
> >>  	/* Release any IO and OO objects not processed. */
> >> -	for (; u[i].type && i < num_params; i++) {
> >> +	for (; i < num_params && u[i].type; i++) {
> >>  		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
> >>  		    u[i].type == QCOMTEE_ARG_TYPE_IO)
> >>  			qcomtee_object_put(u[i].o);
> > 
> > This is not required, considering the sequence of clean up, this
> > would never happen. `i` at least have been accessed once in the
> > switch above.
> > 
> > Regards,
> > Amir
> > 
> >
> 
> Also, size of u is always num_params + 1 for the ending 0.
> (basically means `i < num_params` can be removed).
> 

Yes.  This is true.

regards,
dan carpenter
