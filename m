Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D6ACD4F3D
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:02:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 014F644D25
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:02:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aBJGm8Fl;
	dkim-atps=neutral
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8F6D343824
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 14:02:30 +0000 (UTC)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-393925cb1baso68431361fa.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 07:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779372149; x=1779976949; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4EDYvNhidqTpiXQIIrbD6SRTj3Qr1KMzIp666/F87M=;
        b=aBJGm8FlcdESe0ESFly1MXktw4EU9rHCzG4KFbmwHo8vfeVf9M3HCaEBH+mrYqxW3y
         fbEwlyIGWXXSS2EquhNfYcxM/yRI11ycuTiG1azuZiKs2bOh165TZlkYngkXgdP8tMgx
         Tg8/KQfPdghuJHLsTKWn6CTD/Nv3gOmkAhwOGqPYtM8xjlNS0jAy72e4A1lMEAmux6yF
         T2TccNa+euH5dyVvknVbJncxYWE0TA7rYTQO3Q3SyqFA1SxVF8kISuM7G+w9ciY4H04s
         aiLsnYufBfag+Sv69lyYuve+XOaLAnGIpcR3OYplGujG2Lf0qenTfayQ5i3GOADukkqc
         Yl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372149; x=1779976949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4EDYvNhidqTpiXQIIrbD6SRTj3Qr1KMzIp666/F87M=;
        b=QipwgMwSKfgDwxKO4B4lbJOLN5gCisreVueRHYCd2mUzOE7f9/yFnQkZx3tOwGNnSR
         4VXgcFXF/MGE1ZnrskDVwCWLddBnPUxWk8ephucwxKTQ7a8lv5hV92vIi/SL/2m8f3km
         cy7MiWLXBGmuS0NBJUAZdeLWMl1LMt1kWm0I3sNn8KKgPyVePwNwCMOC7WQ04C8QiPGk
         NZiQKzPfHwVNN6mlgiiSGtrv/R3qRKpDYVwmH2rHfw9SshB3/UVRHRZqpobjl5s3e2Sn
         4cFgBP/MuREZ7jrW+QF4m2C9YG77pKIZG2Kwkk0H2hqBlODgZsTyn2VYjDdan8ZbFn8p
         3CgA==
X-Forwarded-Encrypted: i=1; AFNElJ83WawaWFcZM2wgIFn1XPBblMcC7cAsNHp//fQUGlIJfxAFiSxX3U0z01H5+obwUnHe9UyG2Bw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyf3cbvM5WnoYR5p3mvBKCrUjYC4hrK0hRxvv4tOeRvhOl9Ot++
	YAnXu+LED86QhtW7k3JNRzX/ene+/n3ZtmZsOEqt0o8wTJivOeNXOR/yi6VM9+UVgdEZkBNHIPO
	5HUPzYvM=
X-Gm-Gg: Acq92OHOHQnX1NSVN4uxkOiW5sR+DEqcZPdtaRnRUdPg5CQ90DTu58+ciFHyymo91IL
	Pz8SSR0IJ2+asJmqZ+qbfmt6hB63oJtDiz/y8IavWEX7QI2e7jnpGeXZ61lSq6xV+oTfAzcJ/v8
	epcea+Xtpmk8mFrkSnB1adUxCkG2INxsUuUCfFioANXuuDmnCi8oAqKKwZXCbUbRPHDVSXTzFqu
	48kr2dV6G4nitQtgc1gzSTVYzrWNwnYiZKMQYIGZAZ6444lghXyfrtdfvLVCz/TW7jg/soJdG+b
	kn+q/MytDuF+koZOWeTlHAF55YcfRJw8Sy67evAnhSfrTuuQI1ygEVQyuBWZLydjjrHAAyHVzld
	pPvImDhdJEpf0RQU9LJ5eGYCNtFdeGZ3/G5t8XTkqNRihWho8ARVvGLlVc/8m5A8UjWFeeuQ7xZ
	RTr/nylFG+KKPbLA3KAob/0e8m0erX0QxOr/54z8xa02xVWKWeQ30MEN1kvZ8IPTE9x6/gqWpe1
	o0fPRcpBxXZ2HoJJOfB
X-Received: by 2002:a05:651c:b0f:b0:394:3edb:eb85 with SMTP id 38308e7fff4ca-395ca169770mr13907641fa.4.1779372149002;
        Thu, 21 May 2026 07:02:29 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395d09df4ccsm2850791fa.5.2026.05.21.07.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:02:27 -0700 (PDT)
Date: Thu, 21 May 2026 16:02:19 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE fixes for v7.1
Message-ID: <20260521140219.GA1707515@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.171:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RSPAMD_URIBL_FAIL(0.00)[rayden:query timed out];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.171:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8F6D343824
X-Spamd-Bar: ---
Message-ID-Hash: MBVOUJ4TIA3N5AKOS47WGMQ7IYQDHEPF
X-Message-ID-Hash: MBVOUJ4TIA3N5AKOS47WGMQ7IYQDHEPF
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MBVOUJ4TIA3N5AKOS47WGMQ7IYQDHEPF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull these small fixes for the TEE subsystem.

Thanks,
Jens

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fixes-for-v7.1

for you to fetch changes up to 6fa9b543f6b4ed15ff72af266b29f316643de289:

  tee: fix params_from_user() error path in tee_ioctl_supp_recv (2026-05-20 08:49:09 +0200)

----------------------------------------------------------------
TEE fixes for v7.1

Fixing:
- params_from_user() cleanup in error path in tee_ioctl_supp_recv()
- possible tee_shm leak in error path in register_shm_helper()
- padding in struct tee_ioctl_object_invoke_arg

----------------------------------------------------------------
Arnd Bergmann (1):
      tee: fix tee_ioctl_object_invoke_arg padding

Georgiy Osokin (1):
      tee: shm: fix shm leak in register_shm_helper()

Qihang (1):
      tee: fix params_from_user() error path in tee_ioctl_supp_recv

 drivers/tee/tee_core.c   | 56 +++++++++++++++++++++---------------------------
 drivers/tee/tee_shm.c    |  2 +-
 include/uapi/linux/tee.h |  1 +
 3 files changed, 27 insertions(+), 32 deletions(-)
