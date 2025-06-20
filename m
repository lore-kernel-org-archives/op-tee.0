Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B42C71155
	for <op-tee@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CE77946609
	for <op-tee@archiver.kernel.org>; Fri, 20 Jun 2025 12:06:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pbdp073t;
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C1690430B2
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Jun 2025 12:05:58 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553dceb342aso1309993e87.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 20 Jun 2025 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750421157; x=1751025957; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJy5qo6dZ8wVICVMB7jVSJbcauzW0OWSzKrIDFygecg=;
        b=Pbdp073tAl+ChtMpWDJXcD/xUmff4+3EUiKepoRsKZh0BkZktg2rnE8ECUf99hvANp
         EPcHiXYhyE6SQzcwBzdRzAr291X9MPXek2YmP/lxnphifO/TKydpH1O3YQYfc5mII1YH
         LtZWp69NZYcPv4g/MM2ae4uKGKXs6v/1U0uEsGND9jPEtvHKbH3bU6BecxQLzfTCpWQs
         ceLuAhw6zphoBIKWzYSCNxAaHxie7l/SrO50m/dGF3umsYBq01ApPmMafylRaUX0ahfy
         ct7GSfDame3mLRjmICfXqqDjuneKwAH/RMQpSN2KeoSacrHKFyEmO2RYZBchgCpykMP5
         meRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421157; x=1751025957;
        h=content-transfer-encoding:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oJy5qo6dZ8wVICVMB7jVSJbcauzW0OWSzKrIDFygecg=;
        b=W6zgXmVPHbr0xIh+nUibn9lvtUxqn1/8OsAOyMmofbm4+N21wax5w5rdPDwDYEGGzI
         exzaipGIt4mLrFAlQqAOQcsWPFG5pjoole5MogiEln8BwSjSDY19UbwbXzOe+HZyRJu+
         3Sm+N4z1IuLcleIKOvMTCgoe2ze3IG0opBdJmt6eDLCRGChJpcBnCxoAkPEQXcuA+TUh
         MUP7fhzA/0bxXo1hVwG0yaJT+Q5B/do4FcaO2021UewJeL5eC/1EDrSNbKcLi3OsCuWc
         NzN/RR/WdoE6x/VHEOYzwUrO3uBxuK2vVs40L0tdEDlnEm7zyuePOyERGNWHkObu04nk
         8Ltg==
X-Gm-Message-State: AOJu0YwpwupCVwNEd0eKrto/fb14dEg14FschyJpK7wcDzsjX/FRgd0+
	NA3hHFyPOKsNtEQQUNsrbImTho1URERpo9G3hHtstSkS5VAoBjmUzwUbdEoBpYZeU2FWulaCn8q
	7Q2DHMT+B5f6XF3I=
X-Gm-Gg: ASbGnctc/lxWXYyby53KIwWxb0sUrPHEZb9YBq9YhkV2q/Eo+8P/FapRDkW+9m5F2c1
	CL7h2u1nUHX3f8dMvfXxueKQIzDqTvQNvIB6HduEZvlapjQB3KeKRWf/z/LZ6dNdB/YVg4Z/8PD
	Jq45LtdMQN9n89ylzN9J8IAcT/6bQ6hQhzUkLhUxa8R0FthX/h4raq9bIkUYrZhOP0vy7qUtm4o
	PaRysWUtF25CI6MnwrCVr3bueYBbbWLZwRSjUUKk5wI5REZ5qD+5NPuCS+/e1atmNzDOUKMJvIo
	phdYIIEe2COFYK4vt4ZKNNxhlkhzhh2P2f+q/Po3BJszsTqF8tLYpeZiBoZN1Ci73UgLvyjzMza
	WdT3dvo8XRpy+xLy4QcdmVfIzrCiSmHc4YBMCzQ8zzw==
X-Google-Smtp-Source: AGHT+IFr+fLYNJpgoD5M2Wf2heWTcOSKf4IPJB1Rwzf1fEjRN78u68UhxvXU8uyq0fMMohC2NDn+Iw==
X-Received: by 2002:ac2:51d5:0:b0:553:34c8:f6ca with SMTP id 2adb3069b0e04-553e3bf21acmr843496e87.35.1750421156911;
        Fri, 20 Jun 2025 05:05:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9? ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8e19sm57120145e9.21.2025.06.20.05.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 05:05:56 -0700 (PDT)
Message-ID: <3ee43fd2-676e-4c6e-a0df-a98c43c694c3@linaro.org>
Date: Fri, 20 Jun 2025 14:05:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Preparing for OP-TEE 4.7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C1690430B2
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.86 / 15.00];
	BAYES_HAM(-2.86)[99.39%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.54:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.167.54:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.54:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: 65SGC3SCQ7KXS2YWUPWRG2NAF24DIFAP
X-Message-ID-Hash: 65SGC3SCQ7KXS2YWUPWRG2NAF24DIFAP
X-MailFrom: jerome.forissier@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/65SGC3SCQ7KXS2YWUPWRG2NAF24DIFAP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

[BCC all OP-TEE maintainers]

Hi OP-TEE maintainers & contributors,

OP-TEE version 4.7.0 is scheduled to be released on 2025-07-11. So,
now is a good time to start testing the master branch on the various
platforms and report/fix any bugs.

The GitHub pull request for collecting Tested-by tags or any other
comments is https://github.com/OP-TEE/optee_os/pull/7439.

We will create the release candidate tag 4.7.0-rc1 next Friday,
allowing for a two week testing period before the planned release.

You can find more information related to releases here:
https://optee.readthedocs.io/en/latest/general/releases.html

Thanks,
-- 
Jerome

