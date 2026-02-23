Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6747EA4FBB
	for <op-tee@archiver.kernel.org>; Mon, 23 Feb 2026 13:19:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3B330438AA
	for <op-tee@archiver.kernel.org>; Mon, 23 Feb 2026 13:19:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IzZnwGm+;
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 497BB43753
	for <op-tee@lists.trustedfirmware.org>; Mon, 23 Feb 2026 13:19:10 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40946982a78so1437539fac.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 23 Feb 2026 05:19:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771852749; cv=none;
        d=google.com; s=arc-20240605;
        b=CmqS4Zv87yGJcNV/5IBHE/Wz/qon2jKSwJXDgIaji1EA52qqPHaBfmrEfRQVeWo/pj
         OrkkOHcweyR8l4GiVhm3HyEcNz7ZtMdE6qbWvU/0qQOp52nC+fsY6TbzR6OmKFd61DDm
         YXTlOvwK1SVV7ss4feibsQfMHuptHgmunpaNbvv+SEDsKz3UtGTFfy8hF8fO4HPuT/Ka
         nf15/dwqei+q5NCixfpVfIXvW5G0mjdQK9xJxNyUuNifcokig0hS0poQu6KYt6bANMYa
         T2FGQcHQ/XfwTAc/PnLj4vydnZtCcOJSJFLYWuVTN9oo9yWBGYH77AyGgMl3gq6wUvGq
         QZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HvDnWTMjn8pBfflJCcPKA0gSF/SZfmCkKyOvR7I4wlE=;
        fh=QMgjRTud3zRGrIikisptnJQ9eIvAhpU2BvrMJA0Z90w=;
        b=dB+Knx6x5nBsUSqZuUV/BaxRkO+op5xKEzTBEX7w/e4xvhWhc6DJMrnI+I6zFjWfXg
         NLDZQpejwRtKHOP+hU6vk5KsVRj+sMyhQcjCjFIRNiPMo96KYvBko3JP5d0VbwDsmhCl
         9lQVHN/nKBIX3ts3FTwi2vCLZpNEaEq6beJ68pJPZrXFCkl28d5jHEL7RMF4CwnZ8UEY
         jOrKNv3s3SREdZQ+JdRDsKhD+YEhhDP75ZsV7HIKqRKvAW7CgF0HBg62ADu77YX2saC/
         vunTeGmLqhA3afs2F4TG957P+xX7NO9d+u8KfK2pL72p7vamiIQXfrzCQ9fga4gI3v0X
         nqiw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771852749; x=1772457549; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HvDnWTMjn8pBfflJCcPKA0gSF/SZfmCkKyOvR7I4wlE=;
        b=IzZnwGm+ld/lQVpnDlwvTd6uWedIvXSrzNL6wqZEYPLemdADdcopkf4lhZlfkamvfN
         8IfSpGGASDtFxXsNQZlz07JmWxz0fckRyxsvi5HK0enOTK/xxmcIasOxO1eBM1yY7OaH
         IIcPuV6hz52HElNIqNXCqtZnW/kblQv93Oo52VUGooLhNsaOvYalNuvqoxFSigO6UMbY
         rcdR2MlXLQIoup06zf7zI6oGW6zykA5nZiONNlWsbPgr5m3/GPAd/MCv5ykjxvsex+iq
         mozQHeGGFJzNIHlgcavhN5bqzdKygJ0/a2rPl855wWztfGLA7HGbzRWP3v16AaEgV0To
         6w6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771852749; x=1772457549;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvDnWTMjn8pBfflJCcPKA0gSF/SZfmCkKyOvR7I4wlE=;
        b=ZINiRGzPSx6BJDP77RPGXJelaQ1vnu6Z50CNOfCn4oTimcziArFkelXf1BOT+8zhoT
         llRK5AHbW+O7OJGIWGZdHATq7+XS8FsNUnP7PoLXrkS/G4fW/n6f/NLcWFhG8U2IPHJJ
         plC0CK1esr1cqoUeaDFQbjIXbkNTYfAhnSthojvqw1OqljoPYc1Y92wc7yXKUqo5j4LQ
         clP73HdBgK7b+Oh5UKaeh3du4N7VykIb0AT29c9xSG6d0i/4tN/sxkrjJmWoUi4NbD5k
         l9HkoUzulsN0M0ha9H+4oi+4TiAiR2O5rSFl5uD+DX37f8CpmKHX0VnFaDopvpxs+Kg6
         VGpg==
X-Gm-Message-State: AOJu0Yw2TZhqFxS/CmKdJqG1VfopwANblGidvE9UeY8XKgivl4qwdZSi
	P2e9txQIf6UiHwvot6HGUOo/NSQHGruVXF1fkbkYk+xQr1tFin6LyAyiXUbz3i4MK7z9rgdW69B
	VjM2pZxGIAepZBmGOT234Ny91lK0Yf9WaUHiqQGhJSgPZ2y6VeNscqsEUoA==
X-Gm-Gg: AZuq6aKP2vltKt4RP1RVrypOh4Q/fKGcY5pEXwIfUbe04Qjd7qzEawxUqEh55YqMkqT
	LH1xA3kgRxXyqp81YPDxBTFVEq0mAZtVmWB4gqP960x5ifZd3PaNJ1rCclvfYe9kd0MM9hNqPtx
	T6+uJV8QS0z7UHhNeNd79c9ces7EEvFhn1Lk5+AjUFdxpOljeae+ZTDCzQLjLeoKIi/zOAAGsDM
	dxLpwLW19eHqwmlb17HQy+BCabp2ybs63gRvQvkMtS4tHQMv6QJeSJpCdJnJqoSWMFe5I7OCAXC
	rsO0OlSWpDZs0DWDmw5aymQuKTr/G48+EFBYFg==
X-Received: by 2002:a05:6820:f06:b0:673:3274:a91b with SMTP id
 006d021491bc7-679c4691faemr4198328eaf.18.1771852748781; Mon, 23 Feb 2026
 05:19:08 -0800 (PST)
MIME-Version: 1.0
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 23 Feb 2026 14:18:56 +0100
X-Gm-Features: AaiRm517xKs9nWcv5svfhz60-I6eLsdtJ5PfQwn6MoA_q0i0EZuVko6I-GeIa2k
Message-ID: <CAHUa44G-tFVAsH6mjOFX04yrpq5Y7q2jrJP+qr2Pa=R2eggCLw@mail.gmail.com>
Subject: OP-TEE Contributions Forum, monthly meeting February 24
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.83 / 15.00];
	BAYES_HAM(-2.73)[98.84%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.51:from];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.51:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 497BB43753
X-Spamd-Bar: ----
Message-ID-Hash: WQYGSI4TVZIG53BVFYVPBAK2RRAQ5MDM
X-Message-ID-Hash: WQYGSI4TVZIG53BVFYVPBAK2RRAQ5MDM
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linaro-open-discussions@op-lists.linaro.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WQYGSI4TVZIG53BVFYVPBAK2RRAQ5MDM/>
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

- Rebased linaro-swg/kernel optee branch on v6.18

Any other topics?

Cheers,
Jens
