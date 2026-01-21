Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2BBC44525
	for <op-tee@archiver.kernel.org>; Wed, 21 Jan 2026 13:27:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 56EF7436EF
	for <op-tee@archiver.kernel.org>; Wed, 21 Jan 2026 13:27:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rpFI6JiT;
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A3FA642ED9
	for <op-tee@lists.trustedfirmware.org>; Wed, 21 Jan 2026 13:27:27 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-65f6f9d84d6so3883502eaf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 21 Jan 2026 05:27:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769002046; cv=none;
        d=google.com; s=arc-20240605;
        b=fmaq/eS+3sJDmfYm0q4NxzeaM6GnpDrGps3pecNuI2fe9JQpFIprYv5tkn+JkXYYNq
         +9+UJbpDjW9/pJt2gXFyPz0QCpp3x2BVqPqWQALexzrKxwghAxMMKaGlXyiA6patBzCq
         Hbz6frgHpqDF00ZGrn2H6DN9oIT2i+qHDQakzcznTACdVFC2Wz5pqaixu2VGElpnueu2
         R2nzziYZlzJYl33C23ch4v5FZvsjDu4wHxExvbu5Qt3+KfhIYLTkZvCrK9Pe7T3IxX0o
         ix5Vp+KtCt999YNRvSg81Jk0UqWdkZP0CPGA2QWcy333na65LFIGdeoZi3SqKPMh+61O
         Y7gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=twBmvmM9trYzAW7IpN7LUIgFKXVr1KwX2tg6MMtYXOs=;
        fh=ti7oct0RsDXw6/2Q+S6sHhPG2CPVT/IQ9Yun4xZhon4=;
        b=UHHEv3M0fN4OCZ5MAAnTuLN7LxqeNnlssICI85PohsEgHnUCmbe2NsjTcYhrHsoops
         8X3E2Myp75R8Cv44hP1kFKfD/mN7X18Z2pduYoi782Y9WpdDz7VuKsApaV4o/Jt4Ke4Z
         mwVs2fCw25lVa+7kV1JWFrEo1RFzU5NyBvTyWV8yS6M21vuDDnGcX6DTF7B85QMbYO2b
         hEKjNNld9xRbCLAagZWF9o26Aj0R7FZbP34IoPafMYMkQJgsbLAsAQmFNmslxXV4pvzd
         x79IzR2KscQggjrBN7WIBywqVEhPVUjTXNw7npobfVgJZ8dXMx9GmtyaV8EXchsqtMAz
         B1yA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769002046; x=1769606846; darn=lists.trustedfirmware.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=twBmvmM9trYzAW7IpN7LUIgFKXVr1KwX2tg6MMtYXOs=;
        b=rpFI6JiTVaeZbhVrifrd71vVD6K0xGZ8sgf0oz3AR7JGCpfR7j/WBLEuYTDiOZc0bO
         hiDg6y9Jj02UzXGRkextD/newakVS6Km8X3DKSAvnxreiQ4DoL7eQ0vWyQU6//dVRckq
         Z2C4aW3DcjYfzzGXl6SJX7cEBqlgd2no9Z6Vz1KGVwYwGq/b54o96LQmqwBEqTPaQMWF
         U6z9DAi2RCgtu/CIfW2+qkM8ppmF0S1wQUvGydC+fl3+lgPAxb5oDO5l2Z6PNmy6bqn8
         SoWQajx8j1mJp7k/ifk2RnbHMScz+wjPFwGYHkkf567VlRQwipuKeEaAtlnG0GHoKJkB
         BtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769002046; x=1769606846;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twBmvmM9trYzAW7IpN7LUIgFKXVr1KwX2tg6MMtYXOs=;
        b=X6o5w+LfIXXaFoDEVxw7BZs77nVkbdvs/xrToQJfpyNDD1QbzYJLocWzkuufm3JxNa
         zFq6UBFQK95i5CAmmTEiN0mrDuoB94+BkuFm/k2gbboDTxAt16Z3LQ/X1hC5CsACp+r3
         uEzHAV+tVGhSXZbfqEkQZi5FrxN/zVMiLq6zRPVA4JaU6GvnpUlTufxP8nOYj6PnP85f
         q/h5Xnibv3/Sv1Pj5BZ3YuFJ6a0KqgFhw+7IOUbuyMsl60tsI43AucEqB5wmh1JfDnz5
         UtJXmsoZ6XhK0bjttDzihkYEPMckK03QO16Es+yffDoQR1tFY7m8bZ3L738gSYTKcds0
         Mrkg==
X-Gm-Message-State: AOJu0YzAZzQa3IrFa4fZJ52I+gXE5ydYHbD8Tp8AR9pm+Akh0ygP8uW8
	+0IHl+7Q/rXIayV6DFlY2PqS3nvBHM9zeIPVH0eI6gFGOam2hTYy6eFMtY+gbAIvPayF3hJQ+0J
	1wSq72uovxMJVSX2JbZkkzR4cQYHc1fsm1xbSCvmX0i/0JIlLscGjIdSI8A==
X-Gm-Gg: AZuq6aK6sibl/Rq4jQLRRO+Mf7qDWCWasd9uYWhvUrf1+UWf4UQwbCuG33T/J1gA4nk
	/VUGs6yk/qJsgwSXeyB1pyqRgDUIKdoMQaAVgGdZ4R44RUzvzRoi8hq5SyPcumuX7OVZBoeyFtW
	4ZzgM3sRxlGjmRcx7HwhrFeZHfLPFGhMFQaKUbtYhg8dYpb40RyeY537f9Q9DD+i+b+Gj7ay6Xl
	VHMIMyXH3dSrfPsQPtzYhsOxJ7DQqqNn+AuYvwqrJQpC4CntR9DdJaID7V7LsIBG6ToRDmrVjDF
	vEeEcfucqHHDj5EVgRw3r1Ma8g==
X-Received: by 2002:a05:6820:4a88:b0:660:fe2d:312e with SMTP id
 006d021491bc7-662b0063b8emr1637802eaf.51.1769002046223; Wed, 21 Jan 2026
 05:27:26 -0800 (PST)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 21 Jan 2026 14:27:15 +0100
X-Gm-Features: AZwV_QgNwx-iZvoK8bCkW1a4e0-MMTVlrZ0kY_-NBLkS0eZpgoZZMswkyxGMXew
Message-ID: <CAHUa44HAshBt7ZpP=kOZFpoK3hJ0f7+J5QSMvMEciyV8Vi5Q+w@mail.gmail.com>
Subject: Rebase linaro-swg/kernel to v6.18
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.06 / 15.00];
	BAYES_HAM(-2.96)[99.85%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.46:from];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.46:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A3FA642ED9
X-Spamd-Bar: -----
Message-ID-Hash: 2MNRLAIK6ZWEEMX6TTZWY77RXNGMWHR2
X-Message-ID-Hash: 2MNRLAIK6ZWEEMX6TTZWY77RXNGMWHR2
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2MNRLAIK6ZWEEMX6TTZWY77RXNGMWHR2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

I've just rebased the linaro-swg/kernel optee branch on v6.18 from
v6.14. By rebasing, we eliminated a few workarounds on the optee
branch and gained FF-A version 1.2 support in the kernel.

Cheers,
Jens
