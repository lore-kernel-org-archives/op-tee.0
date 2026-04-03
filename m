Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A3FD730A2
	for <op-tee@archiver.kernel.org>; Fri,  3 Apr 2026 06:12:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1532143EEF
	for <op-tee@archiver.kernel.org>; Fri,  3 Apr 2026 06:12:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rsklpYA2;
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B3A8A41B50
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Apr 2026 06:12:43 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2a70bb69eso1771132e87.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Apr 2026 23:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775196762; x=1775801562; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdQtpjtjPsAZHBtbufNPHIH7Cmv5+AQCAtmPkL4Gwj8=;
        b=rsklpYA2aR8J/xgsnPdlfkhUXrDoPbSfnJQMhcUs0p8jEAfRAxSxYTalHllsmP7G6+
         gMl8TYaQhHt8xNYAcuxW7V6bKcT2L0IGNvaHg29k9yfku49eitQFNkCFR/wnxfSMys1D
         PZvYjabvXONYUHm8kSYP5T/BVAVvGwfurHmh18nbS7OR4M+TaEenHWQwes1TLEiltv8o
         IwtbPx5VnCrKz7zGLOjk2rnoL41FXh5ynpY911SLyWGiQhuSI6vYyqV4FOIlcyqr5qZZ
         jOvr2bQ4MHO6Wte51H5F/mc2IJkApM23P1L3NiDqYVjwR4/qBr5KQRnEqV8fiVCFGh1w
         JWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775196762; x=1775801562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zdQtpjtjPsAZHBtbufNPHIH7Cmv5+AQCAtmPkL4Gwj8=;
        b=ekpo9t0HRMwtc4SdVDWHQHIPwLiKEf8cJUIT3glQ97Ck760085ntog+Lu3TAwnfMNG
         lefJNx09KGEg5pICF2lKgHivJSrxLw5b4P5X8GWoreDvY2emSOhpX2yaxI7Ap3uU/tck
         o+OVd5V619vELo8sievm6EEajnWyW1P/jVZy+1nRiQktiqupF1+5tmppTNnkdFD7Tjtt
         frDgB1QXWHEYbN+RtoXASuMUy1s2Cda22/y72/xjLNKHCoESSFmCf5B+X3qZKRIMmqEk
         Qmo3bcYWsxdy050GHUP/QuvpliI9t3zFmKsWF54vT2n70BQN0yhjrhyyLR9563oVUjm/
         0W+w==
X-Gm-Message-State: AOJu0YwxgOz+kfO22YhxrWj8iUZOUxl8MVvIVnG0Dy2VpB7q7BwNeam8
	+b9Z/SyhvCwSjC2Ymi63siKWxa1lYne1sbQuD4Pi7tFlKRwNq5zmJTu+AgMSo3HXA8igJnmDMlr
	MshlvZcE4pyXG2Os=
X-Gm-Gg: AeBDieuLKwuffkg+rIS7OGHRSlAXnxq9JzMlwp9xvL/Nl07KdMoAU4qRYJ5zFcMT/Lb
	54MdMbAkFXdLqLAeE3i2VfPDlEsNKEzPMLbPfPpvoKYJA30HC7YIeZqN/9Ub5lLfy7Cu8Rg9GL/
	7wir2JMDZVWH7JRdeBf7u4JbDoxIPL0THvewjJK9CMQPyvM1DJ9sLmaHmpHChQJmz56cihEGBdB
	/qv7wCcF+RBk0zJVhj7TGGzkx7pVH0RB4/7kBXdsem2IUEDt3EeWbdId0Gh4Q+xUKV5Q+99af4M
	+OvcnbvX28GCss1JnYeWii14AKNUlyEGjk4OpUB+lOsrKE1T1nwC+hgLx9fz7AwIxrG8rhxfIGa
	5PiQ2+ItR3GZP9fV5VFOH6wZpjdtLagyOWAaM2M/3dOc/bwV6aZlxHGWWtgrQkGPWosmkzUMUnG
	CQBe65awZc6PmCOaGa9nYFAZyq3DugTwtoU95WPuybEA4xKqmWS2Bi0Ht4SQ+nd/Aaeq+20y5oc
	ZEHSvKBmCkLsAKyAf6QHaK+CaPtZQ==
X-Received: by 2002:a05:6512:3f2a:b0:5a2:c3e4:6c1 with SMTP id 2adb3069b0e04-5a337588142mr594371e87.34.1775196761610;
        Thu, 02 Apr 2026 23:12:41 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38cd3cfa5e9sm9524821fa.11.2026.04.02.23.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 23:12:39 -0700 (PDT)
Date: Fri, 3 Apr 2026 08:12:36 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Preparing for OP-TEE 4.10.0
Message-ID: <20260403061236.GA2852506@rayden>
References: <20260330141638.GA3785539@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260330141638.GA3785539@rayden>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.48 / 15.00];
	BAYES_HAM(-2.98)[99.92%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.44:from];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.44:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B3A8A41B50
X-Spamd-Bar: ---
Message-ID-Hash: K4SYPLBU3EKBJH4N5K7OOF57F3SCDXBZ
X-Message-ID-Hash: K4SYPLBU3EKBJH4N5K7OOF57F3SCDXBZ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K4SYPLBU3EKBJH4N5K7OOF57F3SCDXBZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Mon, Mar 30, 2026 at 04:16:38PM +0200, Jens Wiklander wrote:
> [BCC all OP-TEE maintainers]
> 
> Hi OP-TEE maintainers & contributors,
> 
> OP-TEE version 4.10.0 is now scheduled for release on 2026-04-17. So,
> now is a good time to start testing the master branch across various
> platforms and report or fix any bugs.
> 
> The GitHub pull request for collecting Tested-by tags or any other
> comments is https://github.com/OP-TEE/optee_os/pull/7753.
> 
> We will create the release candidate tag 4.10.0-rc1 this Friday, April 3.
> 
> You can find more information related to releases here:
> https://optee.readthedocs.io/en/latest/general/releases.html

I have now created the 4.10.0-rc1 tags in the following OP-TEE gits:
build optee_client optee_docs optee_examples optee_ftpm optee_os optee_test

Please proceed with the testing.

Thanks,
Jens
