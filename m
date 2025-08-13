Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8409AC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 15:08:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C3F2E46612
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 15:08:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oB1O9v2r;
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 566A042EBB
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 15:07:51 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cce50dfb4so24375fac.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755097670; x=1755702470; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7nT3Kc4pE7nNs4YGdhaAsWAayJBPSmBxN32T8u7Mwo=;
        b=oB1O9v2rK7pjOYDC5sLOiMmtfhsXweT/KxUhDlQC2V5rb6LVMqus/H4wBvoSB1fr5k
         VLargHHpRlMT6RcMQAOWdzulUyaQkTxsg9FeeB6c22VbNM3tHwTTJ4NiZ8XHXlpRLO/Q
         Q5FbiPbtM7fTl8G0ApxoJLkUtaQlTDX1e1ULLi0Z8yq09tcN/G3FRa9wr1pz02Br3pi2
         k8mWKqLtU03XXxshklvG5CboJwoDWfnh2YkghPqrgzie7pT2NjsNme6s6Vzrp0dJM9/W
         sR3VXDXSH7eJBg5NbGwu9AASt68LOo7XHwfX6EqNUaBq78e3jjb0fg8CddLF0fMDvdxu
         zVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755097670; x=1755702470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7nT3Kc4pE7nNs4YGdhaAsWAayJBPSmBxN32T8u7Mwo=;
        b=NBPBIYzudrSA48DNbDFEN+cNdvCfCEg/bpbPNR4zbW0BBx7+xBcwgXSnhVE2T6RaPA
         WVEz2qjeiL/+9lFPhJ1cAVydK7b7K9bgZU/mLgXP99pJF1UUNU3lUoVko0vWQZIhXV/t
         VW4foJcl60qzMGa4bFzWUhj1V+0eghqQYy90Y/M1hjQHldJRKKEZQiP5mk3YuLtebNMa
         MZQlfezdj3PB51M7BAdbniY8E9Hi15y+URIK1HrYkuGT5l07rxWcSua0kew70MQs6Ji0
         BKJLjJNSUQqONnO3YXgqHpYEweMCazoush/0UrVBeykvSJfDr5OFSNQhm22wpA51+9qS
         bj9Q==
X-Gm-Message-State: AOJu0Yw28tEj7zPQKnEBO3shB1gZBzVQuERf3k6O/KLZyUmnIBlZfJpe
	a1pGoM+Tf86GAiddrP1CKDRew7SmEOiO9Kd10532IQYjzkerSBkH/89N5KiTnEOAf9Ti277jFQZ
	qY3dZRzujIK49dZWrWB3pSRuyiLDbRjWaJrdyLpwuR5ff
X-Gm-Gg: ASbGnct5Ksap2UeBxCw0J8EfIUJ+yNB3nJVAFgxBTNu9J7CPOwaalkG5fJYhSwbeAS/
	UpCXycBg+vp8iwJImVSL7Rz7ikC5UMo9Akm8LNDpOsSgEGiMh8ON9beJ58pXToqal8x/BGybGOw
	MHWFHMaiXYZiDpaHoQSWuRXewT8N9l3qAQRpvfpsiYzbyy8noa7YRUDzw6/7RisIqwKfW09QAy6
	uzLc2UY
X-Google-Smtp-Source: AGHT+IGEDvAorRNgvJGMmHTtx000fL2JW6cNlz+hF6+niRKtxQ1WuMt9/Q1ejsRgc3gGNZvCkDsrcdJW4/ORBDFEpcM=
X-Received: by 2002:a05:6808:190f:b0:40b:4208:7fc0 with SMTP id
 5614622812f47-435d4246111mr2218564b6e.30.1755097670472; Wed, 13 Aug 2025
 08:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAEhEOQn9TYvdUnf39UOOenydg1Xh1SZYbKrbbprnf5nnXeCBtw@mail.gmail.com>
In-Reply-To: <CAEhEOQn9TYvdUnf39UOOenydg1Xh1SZYbKrbbprnf5nnXeCBtw@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 13 Aug 2025 17:07:38 +0200
X-Gm-Features: Ac12FXwpqxa3FjAuTKYTzjccIH3mwgSzs96mZbA-7FpQWnN_FA8-Kmz8AOTQCyA
Message-ID: <CAHUa44E=8GGVr6CdQT5pDR=HmjVJPqzdnNz93i+k1a-=2B51vw@mail.gmail.com>
Subject: Re: BEE support and TA_RAM usage in Op-Tee 3.10.0
To: Robert Delien <r.delien@payter.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 566A042EBB
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.24 / 15.00];
	BAYES_HAM(-2.14)[95.88%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.54:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.54:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: PSYZWLX75ZV5N6CFISIRLDO3TF7LUFRY
X-Message-ID-Hash: PSYZWLX75ZV5N6CFISIRLDO3TF7LUFRY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PSYZWLX75ZV5N6CFISIRLDO3TF7LUFRY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Robert,

On Wed, Aug 13, 2025 at 4:48=E2=80=AFPM Robert Delien via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi,
>
> We would like to protect trusted application heap memory against cryogeni=
c
> attacks. We think a good method to achieve this is by employing the Bus
> Encryption Engine hardware in our i.MX6UL. For testing, I currently
> configure the BEE in U-Boot, to encrypt the Op-Tee TA_RAM area
> (0x8e100000-8f9fffff), and make it available unencryptedly
> at 0x10000000-0x118fffff. TA_RAM_START is set to 0x10000000 and this seem=
s
> to work, but I have a few questions:
> 1. Does area TA_RAM_START:TA_RAM_SIZE hold all TA code, stack and heap?

Yes. However, on the latest releases, we've started to merge the
physical memory areas reserved for OP-TEE core and TAs. So there's a
risk that things may become a bit more complicated in upstream.

> 2. Access privileges to 0x10000000-0x118fffff have been set to *Non-Secur=
e
> User none, Non-Secure Spvr none, Secure User RD + WR, Secure Spvr RD + WR=
*,
> but much to my surprise, *Non-Secure User none, Non-Secure Spvr none,
> Secure User none, Secure Spvr RD + WR* worked equally well.

Where do you set these access privileges?

>
> I can provide a memory map if useful, but I'd rather not post that at
> forehand.
>
> If this works well, achieves our goal and the performance penalty is
> acceptable, we will roll this into an Op-Tee driver.

Sounds interesting.

Cheers,
Jens

>
> With kind regards,
>
>         Robert.
>
> --
> DISCLAIMER
> De informatie, verzonden in of met dit e-mailbericht, is
> vertrouwelijk en uitsluitend voor de geadresseerde(n) bestemd. Het gebrui=
k
> van de informatie in dit bericht, de openbaarmaking, vermenigvuldiging,
> verspreiding en|of verstrekking daarvan aan derden is niet toegestaan.
> Gebruik van deze informatie door anderen dan geadresseerde(n) is strikt
> verboden. Aan deze informatie kunnen geen rechten worden ontleend. U word=
t
> verzocht bij onjuiste adressering de afzender direct te informeren door h=
et
> bericht te retourneren en het bericht uit uw computersysteem te verwijder=
en.
