Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1114F532F1
	for <op-tee@archiver.kernel.org>; Tue, 24 Mar 2026 08:45:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3ED6143E14
	for <op-tee@archiver.kernel.org>; Tue, 24 Mar 2026 08:45:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YX4xRb4W;
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B499F4391D
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Mar 2026 08:44:45 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fe36cfabso19799905e9.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 24 Mar 2026 01:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774341885; x=1774946685; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U83+x6wkw+25P6UMyxbBBiZbmuWAuI7CckONNyqN5Mo=;
        b=YX4xRb4WOPR9rDDiB0CFd44MBkWU9OI+HcXyKVTGaZ/NWaKGc8x1ipOs/CMEDOxAVU
         mTatvxW9merZZdKJGvMmxeg6EiJaZa/rWy/BZkbb5wSxYbcfIH7wY9glKOXCt/2KZFh/
         c8/8IYagX0itl0BYX3Xyh2CwID6aiHgCBbSq5mIfa/jDBbWf/CwnDspPPAGXUF/yieH2
         j0u8GXiZ+1fmnQcnMSs4r47PZXD7Z5mk6/X28MscKLXBe5/kwFue5mBRdrdpeYuX26Sq
         Yk1nsUFcsTmkDiDR4k7OiUp6huk1p2cm3PeEEgw1tauKXxTjq2VWl+kH5Kc/bdZ/kQz0
         05IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774341885; x=1774946685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U83+x6wkw+25P6UMyxbBBiZbmuWAuI7CckONNyqN5Mo=;
        b=Vczyh4iuK012O41tWSFYu98QuusWyydqfSwIZtPXx+R/Qs/HvuqRF8YksUsmqK57+R
         KhjWEZVSVFcjjgy00AxMo6v6gwscLIuQPkmrJH4Z7EQzIdkEfQtp48x54Qz4+xg4pVMj
         /6cXP1sMi3KCGThKtXwTzc1p5AG5tI7A5mn8h53dgXovzLB2RJSuQM4y60T4lWPcVf9I
         bJGj6kC4DTYVUU6mwTN0dkB7WjBPOTA1Yai0btFXtWiDjUnK53idOWVEOTFzpehhb6/b
         gNGnZnqM54WtKMhjeUv2eHqQNCTRksOMXThQNYvCvon3uGfWCwmPd0+09XUaxDD2sKX1
         O9zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtapqo6Pv1VEKycR+Sd9cIdquD2yefOnzg8ip0vGsm51AVokFRaCsOXir/iLW0raLkMIHgvm8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxLpfAYkP0H1H2S+xSkvvZyY3TVq91d/8rxwAgS15mmEfAzt1fJ
	/bfF3ATlHcPzCFrfeb4g7zned4hr4+O/4iPKCkDnCiteqjjBjGv1dsE7p2bNruTJ0q4cZQ==
X-Gm-Gg: ATEYQzzhLw0kxErBM4qtTnTqURolO8bxbSwRIpyktGjZocZQRv8gA6cHdSt/W/qG5yx
	b6b3gQlSd4YAPvmMKTZD6fsLLZScFIIS32NQOCZapYadd0J2C6vKS6aUOs8b+6BBObtqsf9MpxO
	2waZgM6D90TLHGfQUYXViYRXp8B4MnQ2nxNvrRbYc/UQ1a7ZU2BTDyGWFpMUtIBAjYV/sUIBQMO
	ioGDMEdbnqXEptjnGQPvsMA0eoHKoaQkf7ssF/b2FRLQAeRG+tkMLb9ojiNHJJgO5N712bqW0NK
	2mzekX4Ye/Ti0KZMP8kzVi4q69b0y7C12KA+Ov5FnVe9qVTvfQlQ9MwAaExyAGN//ojglQdcyq3
	vKLYr4iUY0DhVlF8W1sL0/iHCBUFf8BwpBJfGhJecCiO3vOM6ZdKtzHyDC9Gq/fvdG0NZNIjwn5
	/i8bc5Q4og4kdLBZ1vtDCvMSvrarai
X-Received: by 2002:a05:600c:4ed2:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-4870f23d28dmr43386555e9.18.1774341884540;
        Tue, 24 Mar 2026 01:44:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae048sm36111394f8f.1.2026.03.24.01.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 01:44:44 -0700 (PDT)
Date: Tue, 24 Mar 2026 11:44:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>
Subject: Re: OP-TEE: memory corruption in
 scmi_pin_control_list_associations_handler()
Message-ID: <acJO-etj8Xu7Nssb@stanley.mountain>
References: <aXyVSfxbrff_GX8A@stanley.mountain>
 <GV2PR08MB79551A173F9B2762E6860FD5EB65A@GV2PR08MB7955.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR08MB79551A173F9B2762E6860FD5EB65A@GV2PR08MB7955.eurprd08.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.46 / 15.00];
	BAYES_HAM(-2.96)[99.85%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[196.207.164.177:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.48:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.48:from];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B499F4391D
X-Spamd-Bar: --
Message-ID-Hash: 2Q2XDVV6KAK36YD26TZ2OAHF5374BKPW
X-Message-ID-Hash: 2Q2XDVV6KAK36YD26TZ2OAHF5374BKPW
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Mohamed Omar Asaker <Mohamed.OmarAsaker@arm.com>, James King <James.King@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2Q2XDVV6KAK36YD26TZ2OAHF5374BKPW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Feb 09, 2026 at 02:57:17PM +0000, Khaled Ali Ahmed wrote:
> Hi Dan,
> Thank you for sharing the proposal. We are happy to accept this solution once
> it has been pushed to a public repository so we can review and track it
> properly.

Thanks Khaled,

I've pushed this to:
https://github.com/error27/SCP-firmware.git optee-fix

I had a mistake in my original patch that I sent because I accidentally
sent the wrong version which still had parameters as const so it didn't
compile...  :/  Fixed now in the commit on github.

regards,
dan carpenter

