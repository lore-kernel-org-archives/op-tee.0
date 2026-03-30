Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F338110F3DC9
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 14:16:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 33CFE4440A
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 14:16:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nm7ldxo2;
	dkim-atps=neutral
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 93D3A41B67
	for <op-tee@lists.trustedfirmware.org>; Mon, 30 Mar 2026 14:16:44 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so38195921fa.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 30 Mar 2026 07:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774880203; x=1775485003; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBYto40tU6jkFrycQzo5gIvOBK8ouIXWbEsa4bPLJM8=;
        b=nm7ldxo20Fj2iCYMf/haFZoDpTTXR4zNReU1cu2LakwYEnEKmXDWnpX/gjj7sN9Emv
         Sbzq32yEmcL0paMx0/n8AjC3JwVb38D93KCqXI+ELV2CxCLdYcFQpwLWOe0VIMB9pwGj
         HkEgKw+DgXuPOfCAvtA+NvUynlboVE0IJsqMLNGf61LVEH0HMjqOJnIbVrXdU5klqwyN
         tjrosj9Bm9jJ2fw89dPkruOA+9h5WVK8thpdsBILIvBsHdiJbKAJwi1LGHlcMtTfkQul
         vzeHWmJIPq1iiWAPc7h3ABk52bD+3D0nvL3bU6HnNs0tdkHpM3sE3OjN2g20kO7juYjj
         qsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774880203; x=1775485003;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBYto40tU6jkFrycQzo5gIvOBK8ouIXWbEsa4bPLJM8=;
        b=CrJtwE+towUHZxuMsbOZEhuJoDNb2NwvkyuxxlORwanom3j45gAY3t6GJG1imr/ERT
         MxAupInFd6nRtnv4X7eqWxDe5hq/jzU+T+A/eAfgmXk9ARtWBN7YjVfzLHljgA04xDTb
         GkWi3jP2VgXbwy3C+6nDOhLE90dM8kw9L2axOLRcgiHGBoWoxGKlx2uZbUdy4XrSN+Pb
         0nbxkwwGNV3aWbHyk7fEzyvopLRjH52wwrA6NHYNRwAuak723c60F2FWijcs+J+3Ne2K
         cWeVyZwnDJGFVLbDe61zx8Em3szp8x+b+Dw5FB/uu8fvzNtWWjdPLOWBrJtyoPlP4rFz
         EnGA==
X-Gm-Message-State: AOJu0Yz8/lpwK+9rhBNg+gbvd1rhg3/WEuYuVTr6PLRPgZpSph1WhA83
	vC+3M70Xo4BkkmjQZugHGutzHM1tH/n8q4WWl1pxhzEm+Jku1mtw3LMSWiGIrodp/B3G+Vphu/S
	pXVYa1qJAargfARE=
X-Gm-Gg: ATEYQzxIdnr1zPxElXI22ikGrP52zmkW4KgyW3g7FJqBRkpQ2AiwZJMDLtA7F0Xshg6
	CrXQZyCxdHgKLf7w7o7meVyNwC+0he0eA7XRoN42/4thbKKaKlgpWwtEcmQtu2k1HTkRR6+yjMz
	b6NXmw+kNMFfXLD0HnX2utFzKXND+Q1NPeMRvec57OmQ/nar/Mw0mF/7UUy/9SnfYpugv7KSc7U
	eAs2+u7dsQVsHpwmQbFd+Ali9gVO2MrKcsrjZQ9wvJAsvgF/JYKTuV992Vw4Ov4zTUcO/6kTano
	/B9GVi1D9rQzkUMDlaNuc4AmA9jEVPd8NZGaIfFwG9/ybdDDa8WqLDmxyOcnr3C3sG57qss/M3s
	pQzN9FYtCi9wZ+lNSlmtmjR1M6a7wzdUDZIAyOSdziNWV1WdgjL+t5Peq+PLHWPJ9wOblm9IPBn
	gNCfVDvOFnc+ZHeW14N8CWV8Sb9af1YJFtQ3ByqO76KlpS3HERkXcyGzPj7rTnzDdvog2nTkSHd
	XGOdMIItUbNJO7vxX0=
X-Received: by 2002:a05:651c:325c:b0:38b:e048:572 with SMTP id 38308e7fff4ca-38c72c956e6mr44421321fa.0.1774880202707;
        Mon, 30 Mar 2026 07:16:42 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c83890bbcsm15921651fa.25.2026.03.30.07.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 07:16:41 -0700 (PDT)
Date: Mon, 30 Mar 2026 16:16:38 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Preparing for OP-TEE 4.10.0
Message-ID: <20260330141638.GA3785539@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.40 / 15.00];
	BAYES_HAM(-2.90)[99.56%];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.172:from];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.172:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 93D3A41B67
X-Spamd-Bar: ---
Message-ID-Hash: NOMWMTH7OBOOTBDOUI2AHQ36ABNA3TXY
X-Message-ID-Hash: NOMWMTH7OBOOTBDOUI2AHQ36ABNA3TXY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NOMWMTH7OBOOTBDOUI2AHQ36ABNA3TXY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

[BCC all OP-TEE maintainers]

Hi OP-TEE maintainers & contributors,

OP-TEE version 4.10.0 is now scheduled for release on 2026-04-17. So,
now is a good time to start testing the master branch across various
platforms and report or fix any bugs.

The GitHub pull request for collecting Tested-by tags or any other
comments is https://github.com/OP-TEE/optee_os/pull/7753.

We will create the release candidate tag 4.10.0-rc1 this Friday, April 3.

You can find more information related to releases here:
https://optee.readthedocs.io/en/latest/general/releases.html

Thanks,
Jens
