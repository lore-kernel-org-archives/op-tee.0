Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850B7EC01B4
	for <op-tee@archiver.kernel.org>; Mon, 23 Mar 2026 10:22:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B8BF64320B
	for <op-tee@archiver.kernel.org>; Mon, 23 Mar 2026 10:22:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VwbN2RjF;
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E75BB4320B
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Mar 2026 10:22:07 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d556c1a79eso4159007a34.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 23 Mar 2026 03:22:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774261326; cv=none;
        d=google.com; s=arc-20240605;
        b=Jvjdz2RznURmtQmYuoQ5vXQYm5B6acmkW0wI5n/AKmn1lmzqvN5D0WNGjiiOBTJ5Q7
         Ie2C3KUQ5klVGk1ROq7cuNBiqCfhHkN3dN3rljO2afdg9+5gc/nTdZMBnt8vOQR0c8j0
         gHg3eQYqgDmCuhXInjZhe1FcRwT1It0nD2X6ba+MtpKpC9UUfGawTz9Cj3NI6TfvfQN+
         uSthUcDd3a3PYsTrZJjAmROQQV4jnS/fD7HSnzM6F9d3zYHI7MKu8dPVD5dv9GVA+IjW
         WRz69V60FgAkvgfKjUY4tJfZCRqmvAo0lE4wLuvbHFMoojhCQzgzmZk3radliW9Ynn2v
         Obow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xm/9j2HLYBH5cI8dXfs4qm232p6toLiuXuEGWX/yc88=;
        fh=h3kY0GXiFaI5Go/7H8n5Dp/iY05qzVPPzJdGA/Bb43A=;
        b=kLU0rYCHMTCaJixI0KAXkN9NOk31dPCXU8+By5c7rWqVagi/ngsNES9kfkjwRShWJb
         ZDaz2aQ0R3IWBlieGjoWxBaHoZXvqBBS4xbolATgT/pDdmq2ljqrvWfxx3lPHAt5kD4N
         CTBZFA988kEt37IUq6qkGjaAQRRH5GF0mRucZ64w8WJ95rHeaYcPTO0LZpgqXzBoh/pv
         XEmiXBV9jtePdEL4X1T6GBNXTEo5w9G5kBt9hCWAxFZZAUihOLDJ/PO6B1VrFSzNEffL
         qzWA+dFCjqIYQCLX0evMPs40OUSyi8FM6NlZKnPRaVbPF6i33wDzXRVg3q2RwW0fpVVZ
         f6jw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774261326; x=1774866126; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xm/9j2HLYBH5cI8dXfs4qm232p6toLiuXuEGWX/yc88=;
        b=VwbN2RjFTHzs3RH/4RC+4yym0ew2fVJpnML6t0ZOE59XOfzE1TONpE8kAbSFHBtu5a
         S+TgkLBz+J/wcN40RBAXJj0KH6IUrhFX+XMd8+isqoVs3eD6oc/T2zceVFlPJenOuUTv
         u1/LT+RP0xxU02Dvz1jyTMz99yJ2LC3FZIvZomIaEmRzs0aj/Q3Lcs41TnA+nho8AiYa
         ZW0qVA+ONzM/RBh46b/Fj6khxagOzhrtsqOzq1QN7ENjXMs4VaeML6TQ4devCwmyjGnP
         enDcr2M2i6dRmjjTB4vqx+Q7gZig+qqVPnBqz/u4anfOWIgekfH5LIEz2lhNZKfulLfR
         kCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261326; x=1774866126;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xm/9j2HLYBH5cI8dXfs4qm232p6toLiuXuEGWX/yc88=;
        b=KbJKz1D98nj0puUVP9BsD22PF0Gvc5b3hiyHcpXHWWSSu+npF80maMYSgoDvPqlcP2
         ICwQBb7L+WmXzBonWxO2JctMWvyHFM8hfKCgvWs5sm9EHBjOw4gp04VPOsGG25w5NGGf
         e+NaM1Raj+v2xawzyEUgFv5wPCW5FRRED+CrfYVPl+DdQHMfhpHvnWGWKzQmcrdlVwl9
         UOMMde33ceZz+X6wcdX2e7WLgJZyMLvaJkCBjVQ0wk0BHIjiRrAI3m+NcwIdUuCNIn8g
         zAWO+/lcyGJ/xJxt8NOzPEbaxIiWoGmlAwMRYiKBzmXKl67pqQ5iBH1UmjZxFPHDY5Tv
         jF0w==
X-Gm-Message-State: AOJu0Yw3d+DNAo9ZBI2PkIFdL4keubZYcGSHnjJtLKp+K2qQdI1+03FZ
	d3jy8/0kcFhlgOnPZiiDo+IiSxv0KIyiG1Zt3dkT9pUCwKciMysDDcidR1hV58gU++G1EFcZ4wX
	Rlns0fernpFpdleby/VRSLoNgoRc4+gahCHLauhHue+gpqBbB2hRIQKbIxg==
X-Gm-Gg: ATEYQzyalpxSGDd2H073zQCuAYK7i7P8Oju1Ym8eZNC0SV9EDUI5/yy8qowrwnOYAxo
	bMj1p44grmOSTjUVOE1J9cKQ0wR6vL4XX7hYG0d+bTQDdyXVfcSC7KP+ijui564e0Tz4J/ncdbB
	7Jwk4KSRv7pR8bxbrORzYBJyX0Hn4krjm7tcC5SNQbeoGHjzrkndzj0HFvZAxuEZXgP2Zfab0aj
	K53KC1GwOdmxNpRBpWqcNXdGkJXHdB3qbNGM7xqvWSFZoHyr7jiFC7iTTJzYHSCWq4wi07LOglL
	pQ8xlBgLdYlvALp7dINVMigRU0nrRm7SkZZH+w==
X-Received: by 2002:a05:6820:628:b0:67c:2d5e:e9d6 with SMTP id
 006d021491bc7-67c2d5eee68mr6812561eaf.34.1774261326279; Mon, 23 Mar 2026
 03:22:06 -0700 (PDT)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 23 Mar 2026 11:21:55 +0100
X-Gm-Features: AaiRm53pzWsZu85eyk4gZ2H4dvGVaKgiidshTW6liUUdG_AGFGVSmHiF8Pq5a-8
Message-ID: <CAHUa44EePioQ-Um0-PQqN6cpEE_adGOG0FLSZB9QJA==+N92rQ@mail.gmail.com>
Subject: OP-TEE Contributions Forum, monthly meeting March 24
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.09 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.54:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.210.54:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E75BB4320B
X-Spamd-Bar: -----
Message-ID-Hash: JMV6TF6TFKNCOOW2P4XFAJZDJV3YEQDG
X-Message-ID-Hash: JMV6TF6TFKNCOOW2P4XFAJZDJV3YEQDG
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org, Marco Felsch <m.felsch@pengutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JMV6TF6TFKNCOOW2P4XFAJZDJV3YEQDG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

Tomorrow, Tuesday, it's time for another LOC monthly meeting. For time
and connection details, see the calendar at
https://www.trustedfirmware.org/meetings/

- OP-TEE version 4.10.0 to be released April 17
- Marco Felsch is working on initial Kconfig support:
https://github.com/OP-TEE/optee_os/pull/7714
  + How to configure? Vanilla "make defconfig" and friends? Should we
support passing "CFG_XXX=y" on the command line for convenience? In a
one-step or two-step operation?
  + Integration with the build git: Do we need a way to ensure the
active configuration matches what the build git expects?
  + Is it possible to make a seamless transition (with no visible
external changes) when building OP-TEE? If so, do we want it?

Any other topics?

Cheers,
Jens
