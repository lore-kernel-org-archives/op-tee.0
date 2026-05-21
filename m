Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02F0CD5BAC
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:14:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A33344E00
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:14:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wnU8HTcw;
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CAA6E43824
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 14:14:19 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a8738c178dso5689854e87.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779372859; x=1779977659; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JA1Rl/V+AEIvj3al/H+ZnQroSiQ2kKKMhl7jwi2o2AA=;
        b=wnU8HTcwwZWLStS6L30ZVyqgStXhrkrfDrwF7MwR2S6twttUsOQ0Givozrh0XfF0ak
         uAx0fcQfiSDvNmWkqz0ZqSbMgrYBbtQJxgKdwRN/yMW8YdqqFnUw40Cv6QUPFyP12g1G
         pQYXQHl3SaUbzt1tbwHT0OZW0eIAOyRmPr7IigtJtxfqr7OafJzlPVVV9RnKwhW7z37D
         ftYAWwuZLAlizeHkLsqJoX69Uu7hrgjqz4KPSP58XcI8Q6qeFgH0DGqb380fN7OIVJz5
         JgzRM3xncsFWw0kQdeoARIM30r3p9Cs7tvmXNEX3jFVWAUXqQDGVHuxOHUvAdXyDJLYB
         2U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372859; x=1779977659;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JA1Rl/V+AEIvj3al/H+ZnQroSiQ2kKKMhl7jwi2o2AA=;
        b=Uuhc9UPz9lMfrGn+K1Ww81eVvCeXsbmH6GFpsfAiLqX9SDAd90/Y6N2wJF1S4ZXwk9
         MvhgVdbQ7pgqPA1mbv0JuAdq67tySvpY4MJysmKO/aT01At3fQpHik2HWAKCHsEx7wTr
         wkNpJ61NZWmqfE+UBekqz0x3bYgNGfI1cAeKRcX+73DaCqj0c1fbbBYaloSzoJg3NNli
         Z/OW24VteFjwSuTchuV/82/oGlOdG8APwo9mP+FAzx9+ijAT/UaS5o0IZKWZt16U39t2
         YfMyNcE2VRnOI+J6IKukEj+5qzeJ3ak1ihsyy0wUqIQ9fCkmz9GFnT3yfVXuP19axNYJ
         I9kw==
X-Forwarded-Encrypted: i=1; AFNElJ8RJEsBn53gkFtS4TIMxUMl/UEBdgFJ/nE77O79LFpjm3+SKo9re4W8kUBQX7MUeI5CeHSjVAI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwOYW4UsoBPGtG3WkqdKH4R97nTlPwNC2ikh4PVuCocup+XjmlU
	HvjLioygijiOpjbetCroTeTtJ1YLK2KvhZqaNwHMUsti6nIpx5HI3MUoiYCLMIq2K3dqFA==
X-Gm-Gg: Acq92OHoJmv16FmR2VxtkxpgvOihFAOZZqxJuqvgwecTMRasQlVzT7ScjfAVDjsvYu3
	FpekQGhIDsKQn4wtNoS7OhdnyCVu3D4DfAvxSB3WJNGvH/Ds5XkLA657cDXVDzdGa5g1lSfJkyE
	XWi7sj+lxiwtMt0dkzVCFqeh3yY5+7EI3SnsbkmXDLo63wiiEFEY2a1DTaJ/47/0PYJb4erm9vi
	sE85kMA5UtlSsiOIjTH8JxtyYj2lLASdT1qezmRLHKmxGT5Jh5/8uA9JI0nco0zup4fwcylfDlR
	NBiM09pcFI4MbjSEigTi8kuKp5ICUq2XSMOO9Vk0IWpg28zfBX5xAUe8xV7E4tKd+diXP7Gvcx+
	rQJXKnnbyCtbhZOfOHu0t2E6HDV9dX1oT1a6qnRCENcjaIOjSJYOxb6LKtvUYfzKjUagHPrIXNK
	oNBMIsACETDYBMT9wwu2lgjwBbAUComn0KV7lN7EifhNCkBRLdZ0QN8Z8kRWWjtW2Q0JPC6TLQS
	OaX2HXmUtA0Mx39y4bi
X-Received: by 2002:a05:6512:ba9:b0:5a8:f24b:d511 with SMTP id 2adb3069b0e04-5aa2ba8c089mr1395165e87.26.1779372858502;
        Thu, 21 May 2026 07:14:18 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa2efb66cbsm306094e87.0.2026.05.21.07.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:14:17 -0700 (PDT)
Date: Thu, 21 May 2026 16:14:10 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE fix for v7.1
Message-ID: <20260521141410.GA1708231@rayden>
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.50:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.50:from];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CAA6E43824
X-Spamd-Bar: ---
Message-ID-Hash: SCCRMLNFQP5VZOFPQ3RI27F4MDTUYXI3
X-Message-ID-Hash: SCCRMLNFQP5VZOFPQ3RI27F4MDTUYXI3
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SCCRMLNFQP5VZOFPQ3RI27F4MDTUYXI3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull this patch fixing a use-after-free race in the OP-TEE driver
where a client exiting prematurely could free a request still being
processed by the supplicant.

This is basically a resend of
https://lore.kernel.org/op-tee/20260316071210.GA2470832@rayden/

Thanks,
Jens


The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-fix-for-v7.1

for you to fetch changes up to 387a926ee166814611acecb960207fe2f3c4fd3e:

  tee: optee: prevent use-after-free when the client exits before the supplicant (2026-03-02 14:36:50 +0100)

----------------------------------------------------------------
OP-TEE fix for v7.1

Prevent possible use after free in supplicant communication.

----------------------------------------------------------------
Amirreza Zarrabi (1):
      tee: optee: prevent use-after-free when the client exits before the supplicant

 drivers/tee/optee/supp.c | 107 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 33 deletions(-)
