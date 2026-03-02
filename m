Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DFDE9B37D
	for <op-tee@archiver.kernel.org>; Mon,  2 Mar 2026 13:00:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 645F44386B
	for <op-tee@archiver.kernel.org>; Mon,  2 Mar 2026 13:00:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BUj0cbOd;
	dkim-atps=neutral
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D36F540AF3
	for <op-tee@lists.trustedfirmware.org>; Mon,  2 Mar 2026 12:59:47 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-679b072ed3aso3130225eaf.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 02 Mar 2026 04:59:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772456387; cv=none;
        d=google.com; s=arc-20240605;
        b=Qh5wTGVRfu6dbsv3i/FsJD0eL4Z7Y47tnsl9namTmnwQDi8M7dR6LlNqmsVv3OfWbI
         374rV25H/F9fpyPxJ2His9HKyja2mBspTtthVVDLDQ5Ep+Mab2R5W3OEtAl11mv59aQX
         yipxjYsEQ2DEn3fNg0cc3/J4iQtLZ00az+p6/2I48ADYpZDQTJG4g3s4CHTahDKzRMqD
         fc2TwFW4MhLf8dEZGcD5NYpQ0st5G7CfyazJAKQQm+1gBPwSlX1NJGT1KiFhe/ZxMFWM
         OW2FSBtyS8et9i8dDmoSFn/LzlsguptzGD4ZRk6sHAcSBizhVOhH/VAwPp0P/beYhSOH
         7wNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=67W5oUsyBdUBestc9pro8sFdIza/qYqdR8EooQa+eZo=;
        fh=07ZjTOCYG8WUR+ZI5JmLDf5XT5qHBFygfGKG3yClsLQ=;
        b=hp9LMyatKH9dvEKh7h+hAbjyz95nnXb8IwmY08gbDYWQsTItp9OW33tW6CHIL51law
         U5qGhH/5KPBikP/HIWqyUuYjsKvf5pY81kusJqpSx0xYAfUqEq60fU7aFK+cTqGd5esS
         zfSSHFe4EatP0MMk6s+5eiOS3Zvl5Xb7Q+5EQbMwY1JRJVGPwl9jBHN6iaKS/w5s8n3h
         59iDbSX9I9iib4JH4zWaVGpYJnK1bYu9HUitiuvkJc3xzJDk+zTOv6UIYxfwJ6EJD5GW
         XtgBAdgIkJoicfcUuJTRMAPknOfa1RYyJPlhHh26SEm+zRCN29mXxYka0OFZUCbb9lyf
         JdFw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772456387; x=1773061187; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67W5oUsyBdUBestc9pro8sFdIza/qYqdR8EooQa+eZo=;
        b=BUj0cbOdp7XRPW4kZDSZYCunn3wz6Mh4jDSv+ERNF7BJIF5kI/glpkAHs6dRHeLyId
         IzgYarPTNSzQZtXH1SMcEYFQFPzaBAY5hCrupW1yPQ5nu+AE1jhT2TgvVzPeBQGJlf6b
         7sx15w/mBUn4fkA/Xqn7AHRnLudAG8z5DxvZgoz2UBOoBFH9Uu4FQiYb6jzVqkvSR0lM
         UDLyH2WuRwa6zUfe0Y7NEURIVlyDun/EUzGRQopxGMNq9cKQwMvAxF8lqvcC9wdYYGU6
         /v6MdScgsoIqpHqC3zZ5GO0MwiwM8ZR22eYk0+WI8ivSDUf+ZN8uALum5xHGueWpuNxt
         Go0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456387; x=1773061187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67W5oUsyBdUBestc9pro8sFdIza/qYqdR8EooQa+eZo=;
        b=WvmjZdsh++jW5oG/G+Yoggc3aYszniTOr8UJgKC+wFxCnRQnQuK9mOv/URxwWFJGuJ
         Lj4a2Zxq/AyHXJkef7sUa0CfvMHeASf3rYp9vTq183IUYt/6NPHcbx01mKD5H65kxnqj
         SuxzGlohy5R4ZdVfuzCwkxwgiFBwwKoMJcAh/KxvAlryQFZ1VTsJbEpspgSBsBDirgZH
         HTX/UgKVP/1KE2Y5sixp1IQalDTrBfXx49OuIB6lJeKUn6eISrytIKllPkyx4nDMz1iY
         XHQRKDK1VlnAMO/viaN9ZMQNlESBJ/K0NeNkouk3Ua5/GwiLldavbIiRFQDywyOh1aKM
         paOg==
X-Gm-Message-State: AOJu0Yw2sj3VBJiMonYMpL1iLLiQYYHmGLYXeE1ruz5ifaKiZlyKaGx+
	bzIu5wKJhvJ9Lh5J2F0wMz1To5znO5WhS7SVE2QjilQ9qoEzd1fe7qS2p1vg5FNKfu4m6RSBU04
	cB0gvOZ7LW8mhwQNuEOsFBRgK3vpJSS+HEFG8r64xm3/O
X-Gm-Gg: ATEYQzyF1QpzLbUSJNdPzl3bx4LRep+41vVMcMuL0kh2ycMAxRcLoqL9OJjzrfcml9h
	d/8FI2EpgVFIdAvJZNxZKUqOOMlYJ8vskHAFfDv2na5g0hTMiquJtRHQsTzarLnDFLFQ6KkYY4a
	uFxqy5nyiA8wz7LnS0qmfblqao1yEKXG1rSYU3UeXnKlEOD/wJG3fw9NPlGKFFfrcifKdGs7Hj1
	UHt0YWq8+REkqYc2l0TaVg3TXaSnukNCAgx0lEIZMBOcMaJl1XgBv0z4qq3zboJcTCufyGuzN2I
	RNqBmnh+FMRe9GoJAjpL/0SS6B7q2AuYTXALdA==
X-Received: by 2002:a05:6820:6aea:b0:679:a4fe:f02a with SMTP id
 006d021491bc7-679fafc3251mr6699807eaf.74.1772456386994; Mon, 02 Mar 2026
 04:59:46 -0800 (PST)
MIME-Version: 1.0
References: <CABcfEOfmr+xL_uOmmXfQkvZiME0-Mk3-KK1xSS5kCW-ervTTHQ@mail.gmail.com>
In-Reply-To: <CABcfEOfmr+xL_uOmmXfQkvZiME0-Mk3-KK1xSS5kCW-ervTTHQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 2 Mar 2026 13:59:35 +0100
X-Gm-Features: AaiRm50cKejrp7AN4x5DGCcIHeIpfkdlYG3O_ELwcq-AAtz6jem4o4p7jrxkXbo
Message-ID: <CAHUa44EcHjWqJXNgKG=9Pb2yX9k11+8RkjJA=LE3GfqC=qkb-g@mail.gmail.com>
Subject: Re: [PATCH v5] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: Yuanjia Yeh <yeh.ooxx@gmail.com>, Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.59 / 15.00];
	BAYES_HAM(-2.99)[99.93%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.48:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.48:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D36F540AF3
X-Spamd-Bar: ---
Message-ID-Hash: 6PH26EWAAOK5KUHI4V6IQWGIMGFWES32
X-Message-ID-Hash: 6PH26EWAAOK5KUHI4V6IQWGIMGFWES32
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6PH26EWAAOK5KUHI4V6IQWGIMGFWES32/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Wed, Feb 25, 2026 at 8:54=E2=80=AFAM Yuanjia Yeh <yeh.ooxx@gmail.com> wr=
ote:
>
> Hi all,
>
> We can reproduce the reported use-after-free issue on our platform via an
> overnight reboot test
>
> The verifications are listed as the following
>
> - With v2 + Michael Wu's patch: Issue resolved.
> - With v4: Race condition observation and already report to Amir
> - With v5: Race fixed. Stable in our tests, including:
>       xtest + reboot loop (300 cycles)
>       continuous reboot test (1000 cycles)
>
>   No regressions observed with v5.
>
> If there are no other concerns, we recommend adopting v5.
>
> If needed, please add the following tag:
> Tested-by: Ox Yeh <ox.yeh@mediatek.com>
>
> Yuanjia Yeh

Thanks for testing. Sumit, with this Tested-by are, you OK with the
patch? I've tested it locally and it doesn't break anything for me.

Cheers,
Jens
