Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A4606A32A
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAD1AgsO
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6B3E945531
	for <op-tee@archiver.kernel.org>; Fri, 13 Nov 2026 07:16:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tAD1AgsO;
	dkim-atps=neutral
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6CAFB44E8E
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Nov 2026 00:05:18 +0000 (UTC)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2dbe5c4b0so97730137.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 12 Nov 2026 16:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794528318; x=1795133118; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
        b=tAD1AgsOAa7OXYy/RPHEa4Dhzvkqjk2Sh/7VhauWJp8Zhuf1Y5I0N1NhXPvJ+t/Awy
         0cr6EIBNaNdWBxIZH+MaLFGioaZkb76DdGqxIvo8W6godmLFX2fJ0PPfwVnqfWQ4Epfd
         wqVadI1EfQJS8hwZ5FkVXXmZ3GHvlLa2Z6sD3b3qxXJE9iMFR976gCMNkf5Cvg5Dy0f7
         ylmmk7DEf/qU7tKDI49PbsoiVtFe/3oxXc+l2esRV7Mt6uWpzTsjg9UMfYYm6rxVPv/9
         qk1ZvqGRT2r3CAfTt0L+WPXrO4h+pYWxr2h+erLeTPZWd78nUdvgsJM1xCQVI575vXH3
         cq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794528318; x=1795133118;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZP7w34GShAuXcCWiodI7YmsdXNmvF5TzQf1yjJvKrG8=;
        b=BoNdWxAmN0eN8hhMb3rhHILhybN9qyLqS21cCQR5xxtVySpwUbtpJjhhdzH+2ZPVjl
         4BZj9IcscePxLEklayULCu8cO5JHoTfytOFttGBZUFmLSzfJo0YGYzalFJu0w9dJxFFJ
         ZArlOT2yxCGsC7DOKcm203nNYzucih33xGLs1Q0UcpGlsbC590hbWzsUosOUUDYNuhtY
         WffOi4PMvuuIuPA4m6suMODtS49auVkDYhzPtp82zCzD6YDiEwHPe3ngQvJGYA+ZGFaa
         XTEKjHdVszKtgZxpWJw9JMOigcycPe0Bym80mjzohrshtF9y6aSrXnoJKQkD0iqb/H8l
         5itQ==
X-Forwarded-Encrypted: i=1; AL+hErGHEbxgf1NMGExJaLCCPBf1/4T/OmeRicJZSpFpK7jImNwSxPQt2Omtj3cWSYmsBqpexzWIvN0=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/Usv0EdEMT6milfiyFV2Ltr2fh217sxcj1h4UEQ5RWjIgocwsi
	sifLaiNG9M2vj0680u2fdnChLJkpLG6MU6SukQWR9sDLVmLfY3r0zZRe
X-Gm-Gg: AYBFou2/JhhqBPhjLPQbncrtsscnfNOJv/kLdD36sxZUflYDhaWQyPbvIFYjZmv3UMU
	1J5mja35YEhzfn/sJM1kEQlsNLbDLcDY/TLyVXWxP5Kq1wa1kkmKvLjG73q69BEcJPpCZakuTKF
	pxJZlk7B8QgolflBqF+HDXU8OcSicVr4aqfqv+hgDOKUX833vMN80vFWeLB+fO1zVIxSVRU591d
	SYDYzFqDtXwOR35SRV+SDpzlGGgwPP1+h9JI5Hb7oCCl1N+SLQLwKkyAulOziL3X9yypFboKvJi
	gyeBqeQ4l+/r0fQ/sVo17XLJ9cTiLna6WuWw+I4HhHZYqLd1fn0dOZV9BlWiNiRf8w2V9CU5UEk
	1Eo7YJgYlQH+gQReGanv/Dnc//3jG38h9NXqlFTAY0Jvw5CAWDW5XuOEQYlNrAZ9xJQ8JBAyHsR
	bIgPVVKrASpgOYNA/ePhKfl8JjUT8Gy7+5bCSgMf+JNjwhRzVMc9qrAtH+LVnBDsA/bZTsFFZrN
	nlPD2FecxfCsNfocIUfg0auQmKwMgXDhNjsbz9bXxEeVAu25one8xeyhE1KqHPoYtf7avViiCgj
	aasJdEA1xM30yKbdCnmDRKECE50V5P49czsU7XEotiJGiNUn3SrK+A0uf7veUE+77bS+gsrC7JI
	U639psf/Z7CHZcZUz+bl/MD/5dlFe/zwgwxQQu9+LAb0H/okT522pKkur2lDXBnKE7VKnrcm/NW
	n4nUDTVhsQ
X-Received: by 2002:a05:6102:32d1:b0:7c3:a6f0:99cb with SMTP id ada2fe7eead31-7d64db100cbmr246150137.33.1794528316894;
        Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c8424fb8fsm546119241.3.2026.11.12.16.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:05:16 -0800 (PST)
Date: Thu, 12 Nov 2026 19:05:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jan Koester <jan.koester@tuxist.de>,
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.31eb7df44411@gmail.com>
In-Reply-To: <20261112153841.1661720-1-jan.koester@tuxist.de>
References: <cover.1792552161.git.jan.koester@tuxist.de>
 <20261112153841.1661720-1-jan.koester@tuxist.de>
Subject: Re: [RFC PATCH v2 0/3] uid_r: convert tun, ivpu and tee
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.48 / 15.00];
	BAYES_HAM(-2.98)[99.93%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20260707];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,kernel.org,redhat.com,linux.intel.com,vger.kernel.org,lists.freedesktop.org,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.217.43:from];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.217.43:from];
	TAGGED_RCPT(0.00)[netdev];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6CAFB44E8E
X-Spamd-Bar: --
X-MailFrom: willemdebruijn.kernel@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: WQR4MRYNJQN5SBLHA7W2XXHY5HOPEE6L
X-Message-ID-Hash: WQR4MRYNJQN5SBLHA7W2XXHY5HOPEE6L
X-Mailman-Approved-At: Fri, 13 Nov 2026 07:15:53 +0000
CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowangio@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Karol Wachowski <karol.wachowski@linux.intel.com>, Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, op-tee@lists.trustedfirmware.org, linux-fsdevel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WQR4MRYNJQN5SBLHA7W2XXHY5HOPEE6L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jan Koester wrote:
> Hi,
> 
> Building the UUID/GUID id RFC (uid_r v2,
> <cover.1792552161.git.jan.koester@tuxist.de>) with a distribution
> config instead of the one I had tested with turned up three users of
> kuid_t/kgid_t it doesn't build with: kuid_t is a tagged union now and
> has no .val, and it no longer fits READ_ONCE()/WRITE_ONCE().
> 
> 1/3 tun: TUNSETOWNER/TUNSETGROUP write the owner and group under RTNL,
>     tun_fill_info() may read them without it. Mark that read as
>     data_race() instead of READ_ONCE(). Only classic ids from
>     make_kuid()/make_kgid() are ever stored there.
> 
> 2/3 accel/ivpu: the per-user context limits are keyed by
>     __kuid_val(). UUID and GUID users share the (uid_t)-1 bucket, which
>     only makes the limit stricter for them.
> 
> 3/3 tee: the TEE_IOCTL_LOGIN_USER client UUID is derived from the
>     classic uid. With __kuid_val() alone every UUID or GUID user would
>     get the same one and could act as any other such user towards the
>     TEE, so those logins are refused with -EPERM, like ublk refuses
>     unprivileged devices to them in the series.
> 
> These belong into the series before the patch that lets kuid_t and
> kgid_t hold a UUID or a GUID and will be folded in there in v3; I'm sending
> them now so that the reviewers of these drivers see what uid_r means
> for them.
> 
> Jan Koester (3):
>   tun: read the owner and group without READ_ONCE()
>   accel/ivpu: key user limits by __kuid_val()
>   tee: refuse user logins of UUID and GUID users
> 
>  drivers/accel/ivpu/ivpu_drv.c |  2 +-
>  drivers/net/tun.c             |  8 ++++----
>  drivers/tee/tee_core.c        | 13 +++++++++++--
>  3 files changed, 16 insertions(+), 7 deletions(-)

I only received this cover letter. Also do not see the patches on
https://lore.kernel.org/all
