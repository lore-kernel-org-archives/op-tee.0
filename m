Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C512F36BAA
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 05:38:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3FB0C43EB0
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 05:38:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=X8B9LnQN;
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D10EF43B5C
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 05:37:58 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-471bf5157d7so838674b6e.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 09 Apr 2026 22:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775799478; cv=none;
        d=google.com; s=arc-20240605;
        b=KP+J/BkCQzwOVbpYfeWzDOSo8BPW+062ifoNlbIxSOMFCNm3CiGE7m+OBShMpEySh6
         99WtZbGpXKwNjVktPLGpcGjEkMFNp30BW3cMO9QsUrd7BVG6KzmQNlM2vqtVZbM8mJUW
         jqsi9+/5PAUiBkWVLdqHzkn0DsBuCWqcyRaM2kmdixyK4pF1D7ZIzpCvh5s+U8q4e22K
         AQTTxx3tvCBPHruYMtHs1mi/dGXIokzlNolbKiXQbPveqF86JUAUEfamL2rlJvP3PK1M
         g7tq0/IniShwXe1cBfmzmI/ozlmjb9pqTXInapXBbyux8PJhbToNwrEBGE6jVE+VHI3/
         NTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4h+SVBx6YmrnEAOaa+uOFz+We3aZ1bXP5MCnwZdO1p4=;
        fh=Me1k7dFFJp8hMETkpqMaHzIN8ThW53GHPNzVp+0YN68=;
        b=UF5RMGdlVOE+sPOub+bKDbCs1nnTFh84YluM8S6A6BXomd2PLCBq1WT4CcK371lHeT
         wj6NK/xcYx4UbZaG6EXwR4ZVDsl4Mhts+8Z5gAYyiN4MU8OhaLYt0GtYgIVE+fxz46GK
         VH3eYeQEB7XGcBOzlEPrQU9Fl8erazWaRT7H41btV302JbNNVVnOOt3xOH/lRO370hF8
         utcjiCxmgNHq33XLYwH62JrmD/LwlQTCUzxdYFDJIxPW/5+KBwBTxKxDF6NWhkyCajBX
         WteFOC11Htuyq0ErYzkZZe9Kv7ch2RJwzUy+MKCq6zx/AKjUYjJOO8jg7pxCnEkCqJAr
         2zdA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775799478; x=1776404278; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4h+SVBx6YmrnEAOaa+uOFz+We3aZ1bXP5MCnwZdO1p4=;
        b=X8B9LnQNr5VWHNvnsutkbf7JEaakA7Emgz6eJVfv3iKufjOfWEJoPM82/utWFSbUYB
         7Z5Qd2ps8KwwagrMxktOx99Cg8YLAPj4yS+kgQ+7U8kozebysQAR3i30dorsyaoYInOJ
         Mx1Nb2wWWav7Kq8Oqpr9+WLYjcJjoIAXsmLOY1JgQP1D7j6vG9t8J+URHNHY3+aZQOua
         5IugYRJ3qUQpazf1uOaFJhYEzdtT/uicxnGh4YLQh1xyBwdLo6x/AjzTPmCH57x484Zo
         hHbemKRdErxDv8pzkb/ok9HCQWiN7etRez5swHySXriFzbCbLwek5BAn+5Qyl+mmQrSj
         v3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775799478; x=1776404278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4h+SVBx6YmrnEAOaa+uOFz+We3aZ1bXP5MCnwZdO1p4=;
        b=JcgIJ34HbYNIXVIn/mQpOGO+6iYhJf+tXGyri93MQsi1J2OJoD2utL9Mw7vSj1bwyK
         W6Eyp6XcAy8VylRwzccOas9B+1Mz+rqNH5KV5dsrOR5AIrXTJ7JONmVSfLkT7TSU0js/
         NiTUG4+DLhwG4inNZ/yUD2avxUb9WthM3Myk2gOJ4XMMxd3Tgavx+F7hYpFTrGxZslxa
         kDQqG0FWalD5oO41FWJ3tJFLa/j0FQm177MBMsVeiPHAKgAi0tMsZ9i1zuABC3StyEmH
         XrBYUgXN/g8tix23vL7jdJbWeSt3/qtP8EadV5bPhN0rSt35aAxmPDpe2cwUmfujHsKP
         NAOw==
X-Gm-Message-State: AOJu0Yx4WZOQB9tNlTaoL7kMXkmV2HbLdw0asz8oKw37d3Y/JyIUPRZf
	VXhPiqJiK9m45bPANHRskuApUdhtoNnSqyIgjizs61b8HnfcMpu9deghvDEm09wcNMYPMHW1p8s
	JTZnSWdOut1LMRfg5baMcfwcuBJ7A0wt2cVMUSNnk3F18
X-Gm-Gg: AeBDietpZOSUhMgJhJxFvcIWn6zoQ/K8eYIpaNtFkyjmXXlQRdMs3JfxZYwc0g5Hw8h
	KBEeWWEjn9Fo4HykgpDDRC/MRSAXmCXeszfaOhFDc7pnOKnw1u8x6Tc9Rrr9XSDo/3QFRIW2n0C
	aG4II9DD3yPPzUhkjXMykgfC25JiV0P9LTkeoLYP9Phe6MNdAn0p+TEucdl/1M8jZzCeVQpNDwj
	fzQlfGlGaTnKzM670yY9cOosqwExYlxcXiidHtWJBCnSvJIFKjGCY2l+/LSeDnKY2D3Q9nBQcAV
	1qte4ZjepBABIfLgdEkV7gc3mWRQZ4UvaD1ctg==
X-Received: by 2002:a05:6808:c183:b0:463:bef4:c9d5 with SMTP id
 5614622812f47-4789c64afd8mr1138766b6e.6.1775799478089; Thu, 09 Apr 2026
 22:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
In-Reply-To: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 10 Apr 2026 07:37:46 +0200
X-Gm-Features: AQROBzBrTicZGvq17HNVCK84Fq5V3hBXJa6BkX6PUHuY5bDU01pbkr_tQomojQw
Message-ID: <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
Subject: Re: PKCS#11 TA needs userland supplicant?
To: Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.99 / 15.00];
	BAYES_HAM(-2.99)[99.95%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.178:from];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.178:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D10EF43B5C
X-Spamd-Bar: ---
Message-ID-Hash: 57MDDX77T7ISZAMBJT5E26Y52SOJEUJG
X-Message-ID-Hash: 57MDDX77T7ISZAMBJT5E26Y52SOJEUJG
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/57MDDX77T7ISZAMBJT5E26Y52SOJEUJG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Apr 9, 2026 at 7:41=E2=80=AFPM Jan Kiszka via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi all,
>
> to avoid that I'm debugging further this error I get during boot with
> CONFIG_RPMB=3Dy in the kernel and CFG_IN_TREE_EARLY_TAS=3Dpkcs11/fd02c9da=
...:
>
> [    0.359372] mmcblk0boot0: mmc0:0001 QEMU!! 4.00 MiB
> [    0.361779] mmcblk0boot1: mmc0:0001 QEMU!! 4.00 MiB
> [    0.363761] mmcblk0rpmb: mmc0:0001 QEMU!! 2.00 MiB, chardev (248:0)
> D/TC:? 0 tee_ta_init_session_with_context:569 Re-open trusted service 701=
1a688-ddde-4053-a5a9-7b3c4ddf13b8
> D/TC:? 0 legacy_rpmb_init:1143 Trying legacy RPMB init

The in-kernel routing didn't initialize as expected, so OP-TEE is
falling back to the tee-supplicant based RPMB communication.


> E/TC:? 0 get_rpc_alloc_res:646 RPC allocation failed. Non-secure world re=
sult: ret=3D0xffff000c ret_origin=3D0x2
> D/TC:? 0 tee_ta_invoke_command:830 Error: f0100003 of 4
> D/TC:? 0 tee_ta_close_session:469 csess 0xc0210910 id 1
> D/TC:? 0 tee_ta_close_session:488 Destroy session
>
> Is it possible at all to run the PKCS#11 TA without userland tee-
> supplicant? I thought it only needs the supplicant for RPMB, thus should
> be fine with the in-kernel routing (which is active), but maybe that is
> not true.

Yes, I think so. I haven't tried it myself, though. Anyway, the log
tells that OP-TEE isn't using in-kernel routing. You can also check
/sys/class/tee/teepriv0/rpmb_routing_model to see what the driver has
negotiated.

Cheers,
Jens

>
> All is fine - minus that error message - if I later on start tee-
> supplicant and use the PKCS#11 TA then.
>
> Thanks,
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
>
