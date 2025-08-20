Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D809CA0EE4
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 11:10:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4E5FF4FC9B
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 11:10:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l0mTpr07;
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2152D42E22
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 11:10:20 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-437727c903aso157345b6e.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 04:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755688219; x=1756293019; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jrb/GtHgKP8+Um4DDhcHolBQ28fCmzlAZRk0c/3lpCw=;
        b=l0mTpr07AYAmeRpJa2PpGEs4CskNiQOwTKXoaPvkTJ2WMoi37SRNoH+bfeRCCsWHuR
         dW005MSjDtGBAXFpU8mVvwYli/FP6K+e6mGXmY5ospLCFnEYldYXrkOpKSiSIfB+XzMD
         uogqhudY9v9X+BMER+JoPPMo5pyavUX2RMZAfTDSs61MBlbSnUXPtUr0dE9zPiPReNL8
         ZAJLoTXImkXLEobI4A1KvQDrX9FeQJQnK8Fc6FCyI8lXVtE6m5HgyWWUcpzoSi9iAnxp
         0FIt9BQkM0PvGLhBWDFZagdquqYf8nTQaj5/Gl71hu2shWcIbmfMLtb++BZS8lLtRzZ2
         OtMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755688219; x=1756293019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jrb/GtHgKP8+Um4DDhcHolBQ28fCmzlAZRk0c/3lpCw=;
        b=V0O0GnRh9PPnY/H642YaPw5LYmSnEZCmxppVd0U2sU4WRF+x6HSGX8CRUSE8TdFjBc
         SJ6qyJ35LqIbdaPRliUHVOIv7qnmSQtMbab3aTCNUV54JUnFjzi0k7qFPRu4EMnUTKGi
         ICMdzGQSCqo2Tam3tam6lmka4oqNFpW79W999/RMhWGI5dmjlElZLpAIop8hiHH67Kci
         UkK4fM+gn8mSQtFAYzWg0yVlQmgPDDAugJTQ7rrhSUj9doAWyGhDVNOmbjEabhjpFHqA
         hyPqkU1PE1LH0rZ4eD3rc57eKLQDWJhUGXuOo8qlCzEE3SEvaq51GwsWsak0ghrLe7qr
         SfSA==
X-Gm-Message-State: AOJu0YxADOeUFM/qJMqzdtniE9mdWV0vsRRsUMpmL8mLEAD8Fxv06zmU
	e/NZHXQXfElIGtRJYJsJW6Q87QUu8IPgHfuabU3rwjeVO+DfVdXkKdBxmASRFs+oVak7qi3EV2c
	l5lygqlWQG1J1Gz9yIaR5YDete7fYtDor4QIpPpC1jhv/
X-Gm-Gg: ASbGncuxAxOySm2VP0exm4iAsVHrxKd7P4EUrWfPK3bEa3LiULNdT6u5EO9OnEpaG3S
	oZDFWpMyOPYQZX2pGHO6KNjp0Fx6LGPpRERl5mTqr6t+tR/viZ2jsIY60Cy5CKyJHqj7g3IKNjz
	NVVMhVzGdxh9VcOT24py5JNLLsIJ5Cvv9qJF9WljADUEDLYjbL5/JcyoV/OOQklalgzIMUYNLuS
	DVcS6DP
X-Google-Smtp-Source: AGHT+IE/5H66m2Tv3rUftv0yh2aoJvI+IAQwu0SMW02rUjQmXXFf6yDKOdFPa2qHKNJHNfx1T68EnyL3zqknDNPuoiU=
X-Received: by 2002:a05:6808:f08:b0:435:94db:5d66 with SMTP id
 5614622812f47-43771ff982cmr1284630b6e.6.1755688219461; Wed, 20 Aug 2025
 04:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
In-Reply-To: <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 20 Aug 2025 13:10:07 +0200
X-Gm-Features: Ac12FXzizlpbxHwl76fKr1JDRsDHXY3iZfcwaJ3N776sTW82UdkohPJBpXvK5tQ
Message-ID: <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
To: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>, Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2152D42E22
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.180:from];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.180:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 5QKRN6KIT3GSESSA6YYZUSCUZD7RX5ZF
X-Message-ID-Hash: 5QKRN6KIT3GSESSA6YYZUSCUZD7RX5ZF
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Ferreira Joao MTANA <Joao.Ferreira@mt.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5QKRN6KIT3GSESSA6YYZUSCUZD7RX5ZF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Thomas,

On Mon, Aug 4, 2025 at 7:09=E2=80=AFPM Stauffer Thomas MTANA via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi,
>
> I'm running OP-TEE 4.5 with PKCS11TA and ATF lts-v2.12.4 on an iMX8MP. Wh=
en I create new rsa 4096 bit keypair with OP-TEE, I often get
>
> rcu_preempt detected stalls on CPUs/tasks
>
> from Linux 6.6.90 (mainline)
>
> Also PID 0 is sometimes blocked for more than 30 seconds. When I create a=
 RT task with even higher priority, this process is also blocked up to 2 se=
conds. For a test I disabled saving/restoring the NS timer register in ATF =
(arm-trusted-firmware/lib/el3_runtime/aarch64/context_mgmt.c), this seems t=
o get completely rid of the problem. Neither creating nor signing leads to =
any issue anymore. This hack may lead to other problems I do not fully unde=
rstand yet. I "believe" that at least since ARMv8, the CPU have their own t=
imers for secure/non-secure world, but I would assume that ATF implements t=
his correctly already.

I'm starting to suspect that we're setting NS_TIMER_SWITCH to 1 in
services/spd/opteed/opteed.mk based on a misunderstanding. OP-TEE can
use timers, but then it's using the EL3 physical timer. So OP-TEE
should stay off the EL1 physical timer. Sumit, what's your view?

>
> Maybe I'm completely wrong here (assuming that it cannot be I'm the first=
 person having this issue on this platform). Hint in any direction would be=
 helpful.

I'm surprised we haven't seen more of this issue.

Cheers,
Jens

>
> Regards
>
> Thomas
>
