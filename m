Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C955FCD4F26
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 10:01:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F0FBC44F28
	for <op-tee@archiver.kernel.org>; Tue, 23 Jun 2026 10:01:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CrSzWkEh;
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B68B644D47
	for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 10:01:15 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-befee9e5ef7so661131866b.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 23 Jun 2026 03:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1782208874; x=1782813674; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j06OCjxTTpX/OKGIZsD6mhMhISK8tG+kgJFSdyld0Qc=;
        b=CrSzWkEh29IuM6k05HctV8ncLF9HXj0YhjpA6GH1C9oyK8CGxvS65Mt6wiX7ZP9pI1
         HoVCCaa7+gaO1N6ydZPMMUqdT5b466dBafkZlTBECOaL1iLhchvvQKsa/wfErpBggiNJ
         zzozJ0sVWNKvrYHyFpxT3bXPWbCzJrOZcq9/kBCHrbqPq9rlZrvlsLbNIqomkocb/77A
         2/cHSCvlPsLcXiZ8Sbka1ZQXW7kYi1umEJP5dHqCuKNusqXbS8VLUtof96jGZerw4fPd
         jjzKOd2a19/WP9j1B80Vz+6ulBL6TQU3qEUqo7nMhn9PNKPu5x3Ja/7/4N8AkcirCx/a
         tpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782208874; x=1782813674;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j06OCjxTTpX/OKGIZsD6mhMhISK8tG+kgJFSdyld0Qc=;
        b=S3Ha+UlqmgWQTkXWmNMtDLct1gu53zhgyg08yMl+csiwNW8/+reXw7pMg0u/DCIqXG
         8W3FqxLGeZIVIPzQVpcMxxjiXjCUZl4XaqcIZa1wetG/SVQ0LbTOmSTpQxGCEPAMGrN6
         9KHIp62IJL/2KA+Bi17dSWZ2imQqK6Ux9QML+st6fJoGkYSthvDMlytflnHOQZpw81XS
         KUBlCxRJjXC6bGv+veYJbcwoY/+3/wn/2fIoxWiDdZyZ5BmApPNB9xXfzAHwcVS9UAsP
         hw2KVgEr4toauhsIjfBQDASnUHwNo6iAFb8cvpVdIxGYx6+d60h/pVA9dVCqSoUm2CL8
         g+/A==
X-Gm-Message-State: AOJu0Yw/DocP7aVG3q69sKK9r5Wjz56rIhn6UPg//RK4cWWx9SVOX1CV
	UPXtInlRjA3tAtLz3BLNtVNEaWzc1BAxr2NzvmVBKn4X7M6qdcujIsKe9KT6eb+e3n3a1hEV7Ph
	VwYQe9q5PF4SO
X-Gm-Gg: AfdE7cmL9WRae3B15iCTAYcm/LIAGaby/HRSH+qUnarvKNnLSKvGsIIj1J1QH4DRGHL
	NFhOJLM0PgNcegsYdL5C6qqZOTSWHxP1H+CdR/0PxdCO2C7Z51aMuQqLxTAoHGISHYZGKT+P21U
	jYjSMC1sfZpAQkpm6cqjf7vk0kiZ3AAHD0CUAM13Hk+NJOAqBhW4FxqWLJeJBmuX2+vNFjqiC97
	7LpHNLX1J8nS7xI2YAvVuY79KNx4qqywc4IhCFA2VBcf+Iyx5K7u2OwZtq4ig31kiVqUt3nRC1l
	bkM1ohfXRxHkwR8BSbEmhS7m7Mt/Jze9DINzw29px4cd/8x9t905leMggSF+y/U2tyk+pfBUVOD
	oGE/imPSqP/ZtVaK44r0wEqZa6Ku8/cJKo4uPQhT6cS+IeBpYKkXycxTc9hqRSfhMEv9fj/I38P
	gWDxtqC3GMrjOTvYaClSyS19NFDIZN1fxbaN/hBLT66sLVfT41kVC0aQx02LLCqQ3zbglmorvpf
	7b1snEpWg==
X-Received: by 2002:a17:906:4fce:b0:c08:5ec6:19d4 with SMTP id a640c23a62f3a-c097adf2d05mr1099530166b.8.1782208874401;
        Tue, 23 Jun 2026 03:01:14 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5e99b968sm482900866b.24.2026.06.23.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 03:01:13 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:01:10 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE 4.11.0 release (June 17) cancelled
Message-ID: <20260623100110.GA3039742@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.50 / 15.00];
	BAYES_HAM(-1.00)[87.15%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.47:from];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.47:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B68B644D47
X-Spamd-Bar: -
Message-ID-Hash: WSRLNDT7JXFRYHMWMEIAMXDFDOPFFWNY
X-Message-ID-Hash: WSRLNDT7JXFRYHMWMEIAMXDFDOPFFWNY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WSRLNDT7JXFRYHMWMEIAMXDFDOPFFWNY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

[BCC all OP-TEE maintainers]

Hi OP-TEE maintainers & contributors,

OP-TEE version 4.11.0 was initially planned for release on 2026-06-17.
When we discussed this in the OP-TEE contributors forum today, we agreed
to cancel it, as none of the core maintainers are available during the
release cycle.

We will schedule the 4.11.0 release on 2026-10-16 instead.

I'm updating the release page accordingly:
https://optee.readthedocs.io/en/latest/general/releases.html

The corresponding PR is:
https://github.com/OP-TEE/optee_docs/pull/287

Thanks for your understanding, and we'll be back in touch as the new
date approaches.

Cheers,
Jens
