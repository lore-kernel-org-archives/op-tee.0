Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8448DCCF9E0
	for <op-tee@archiver.kernel.org>; Fri, 24 Oct 2025 14:18:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C169643077
	for <op-tee@archiver.kernel.org>; Fri, 24 Oct 2025 14:18:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w5f2N1Gr;
	dkim-atps=neutral
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DFE7B41BA9
	for <op-tee@lists.trustedfirmware.org>; Fri, 24 Oct 2025 14:17:49 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-44575bc8d88so1118544b6e.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 24 Oct 2025 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761315468; x=1761920268; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hkgg5eDj6d/Eq6cv27CO0fs5fTB+eyEnFgCzhAOfpL8=;
        b=w5f2N1GrP7T09scYVBTgarzGHY1kwaPjhg1KOevAukBfv6qtjCxwtpzYfzLMFOsk4Y
         Bl+fX/ssWw3Nc8kxP+Q4vD5cx35XHEu1BTeW+/+yISH5fqXr1TsCGasY2t6LiSox7Xzi
         2VeUwD4LIcTIUpv6+BT7GF7Vsa5Q/RB95IVEWe1jLV5odK9iLmUgMkk+0k3T44Ge0TEy
         z79lK2lKRDoeqIJJWbv/r/wQwN2fo7UTq2A0zk8R9DngEm2XenGNuv/y7IKnvSv9FZcA
         REubLUfzU7oLAnlpYYNm74wzIgjbtxvGu3UPuzsF9GTstBxGuSB8WuDp7wvdSQbvBPPj
         KRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315468; x=1761920268;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkgg5eDj6d/Eq6cv27CO0fs5fTB+eyEnFgCzhAOfpL8=;
        b=RdeNlm/9KFmmqDtn6+NRGcRvmCgMysv3opifDpY8LcMmykG0OLu8wG2ZYXUHV9j3LU
         W8KN518LJcAxsuu6mTtq1LD7nGAs7r5Wlp4gt2EWTGo6+JbbIo3q7KnPDJomsaDTTk5T
         3UkDgn0jiouAlxbSy1z1tbB8HfWwOl4f3eiKC103/Hi8GGqBHNP5rE5HBvvexFjBZUlS
         07K2A0pfdtSOhxGi9D3Rw1dyf7ZieRzGy85kla9u6Jj1xOBMOD1xiYuxmx9rL+ONTO4H
         dO3/+nN1eBGyonZvK8CvCtEIDP0/Vpk6rbVKW2Cw+lgQYV6qroAFQsLeZcC7abFs8Smx
         RlZQ==
X-Gm-Message-State: AOJu0Yx3BRfOP6aUPRbbM/xPo9zzEpN5/3WtDENtBezR4zkv/X0TIhUV
	Zfn5lXCsnqEKwn680isHdpNT4ZJpTUGJwImZnfgfH053CsX8rVW/KcRRyo05Zkoe0lrYXBvOaXX
	8zwxomw4sryswB6K+umoomCvXUWlQPBoFHLbSvEENysKSdpdJ6xIP++4MbA==
X-Gm-Gg: ASbGnctgMGl5e8fXDbA3S+QXMqsLy6HU25SKMdTufpQc9tr7SsHKMAd46eZaDVQdAa4
	Rsoia7ILc/ixp33yrs3hTgeAWITFzprNt1emtyjm7cIQqBBlzKd2AVGkwsN37lWpe4NjJLd/xSx
	fvcLQ9m7DIaH1Z1ynCQPbQqrWyAz+NglcJFCPwYquva1sUdIrjloS7SDOLWk53NqLwFF04h0nh1
	PzsQrcHs1TbGaI1yVW5AvGyTptkPFO4YZ6TApFap3Uixe9PNol+DUK/G9zeDcSdTwQffw==
X-Google-Smtp-Source: AGHT+IGfgjGwcp1BStmx6TB3EibqVLfSl7x7sUVkO+h+vdY/BhJ1p5MHK0Vb2F79zfhX5TzW78H9HXzL+krvje0jOM8=
X-Received: by 2002:a05:6808:1487:b0:43f:7940:69bf with SMTP id
 5614622812f47-44d93de73eamr884112b6e.26.1761315468514; Fri, 24 Oct 2025
 07:17:48 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 24 Oct 2025 16:17:36 +0200
X-Gm-Features: AS18NWARzs755xQxf9MuR2PL9P4JKpN-W4QD81hfskzO1wFShgTi5LEj0ootYy4
Message-ID: <CAHUa44FJwF=B=vdgHPP46TOjW9xX4X+VGqC6x4ZsPRzGOpT8ig@mail.gmail.com>
Subject: OP-TEE 4.8.0 has been released
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DFE7B41BA9
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.02 / 15.00];
	BAYES_HAM(-2.02)[95.19%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.169:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.169:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 3T6W5NKWCQLOZGWEVZPQCMCQVVWHQPAA
X-Message-ID-Hash: 3T6W5NKWCQLOZGWEVZPQCMCQVVWHQPAA
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3T6W5NKWCQLOZGWEVZPQCMCQVVWHQPAA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

I'm pleased to announce that OP-TEE version 4.6.0 is now available.
The list of changes can be found in the changelog [1].

A big thank you to everyone who participated with contributions and
helping out with testing the release [2].

[1] https://github.com/OP-TEE/optee_os/blob/4.8.0/CHANGELOG.md
[2] https://github.com/OP-TEE/optee_os/commit/86660925433a8d4d1b19cfa5fe940081d77b34b4

Regards,
Jens
