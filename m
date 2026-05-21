Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52781CD5BAC
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:15:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 979A444994
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:15:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XiqBWils;
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 577BF41BB7
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 14:15:28 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a8891febd2so8612378e87.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779372927; x=1779977727; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGBH5couJrf2+imLmZb6M8hd7uyW+GPRfAO1ovQLVjs=;
        b=XiqBWilsAUekbKUJYO+NxJJ4d9bsVE//Miy1km3G3VNZXB0WqFW4zVUi9gx1dlwdCT
         oODjVqyccNDJpbcp9LwPhDWHhFOXYXbLRZcvSFcPgbeWGSH+sVXY90TM0tSE3B0mwDxk
         J119cvn0+gseAg0lKEpb1hWjdalg8ppFzHZ574I9UgkL1x9a1oQMnp57LoSrVGPD0lha
         TS2YSNRwIINqis4JNILCLE3kGL0j4iHvcxHm3DvbjzSglg5qfX8A4J0OYZEmIWozU4m6
         TkiInvsrRoyTtZLQpnL/gx2VKwM1qfcMCDo4GcvX5pYNKowjmBLa3juaCa1B52NThzez
         QUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779372927; x=1779977727;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NGBH5couJrf2+imLmZb6M8hd7uyW+GPRfAO1ovQLVjs=;
        b=q0q6vbJ7zVGH5qStMTQPbPA5SsopiyBshnJ/RBeAGRPAdwKBFOlOSLimrf9Ia2yNBa
         3W6EjKM8jwXyu/y7r5o/fNwo2sCf/AsguA/rJDnvBhWmnjcMhm6WzQsIFuO4C44ZDYo2
         W4dGfxT7wjHEBNJrFFyLeYJ9KjtXODBPg2LWAoOIvTREZJytDuBPlYihH9EBqErN3Yeb
         G2lCW8n7/vYFW4Y2npMnne4jseiqX62eoxFRZYIf7LHfLHyrSJk9cGTB3JlHF7FcLx9R
         c2/tFSCQUxBh+TcaAJhAnzen8vcx6kpqpG9iQPQbMwRTtNT9PLC7UUpTlNki/Zo2OpA8
         oUvg==
X-Forwarded-Encrypted: i=1; AFNElJ+RcrYF7pei0Uxii6eCqiFp+eyIT3BKlKiRYeb2B//CGrV8t3GohaT+/+nD3rxM69gIMeoOiLQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwEyffc7LsXZYZuWr+t2ohm59Js4CYYFQz0YC8uvRlH60m+E02F
	miqaC/nMUvufo1A1//wHWBiPbbTiGP9LYSz1UXWe5fCxhZE9OOy8bwvrLNJv6VWTX2gNkGlkVkf
	FIsYVZ1s=
X-Gm-Gg: Acq92OEmv0d0JqwAAOGmx/1RwVR8+kebk2LuPo+RJHDn1WccdElclO164cx4SNpjVE+
	wri+aY87k6wSh4rFw6R1zM5JyMSgoeETWVJ2DjldEaSX6UtAbsqLJdncvct4gnXi9qOx0IEUIVF
	wTjRS8yI6bGP05YW49nbyr0VycY/QBcqKKZVf5H6X9pc3AgazDUbqnEV1jr3i4oKSU5mjsOWiS3
	kBi5HmSACOM0xDl8mqQt4Aq+0xmLD7lp9VSciWQWpQdH5oxQNC3w9026txgWKuPiAbDllfZsjRT
	cjjZyXlfHaNtpeYKSCeYVyXWt12wgBfHrNNBZjw4c3Nl4kl6nD5w7M3lF+YFAvqDt/x0l3o9d9E
	Ofau0ciT6COsk+FDmYlxhdgmJDtBBxsmKx/9+QRtPsGYgFZQyP3pljJ9PC8RoPsUNmBm64WJ/8Y
	QTIuFrVmsc4GfyC8VWzcUr3f72CGjKhPMiipzar6/yVrHKeu+TsV3iJFV49PI5qTj65M6l7TXqK
	lY2bzUj9I1GfCLfpUXdW9kb7kuU2H4=
X-Received: by 2002:ac2:5312:0:b0:5aa:b6b:f6ef with SMTP id 2adb3069b0e04-5aa2ba9ab5amr902886e87.45.1779372927069;
        Thu, 21 May 2026 07:15:27 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa2f14a417sm294444e87.58.2026.05.21.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 07:15:26 -0700 (PDT)
Date: Thu, 21 May 2026 16:15:22 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] QCOMTEE fix for v7.1
Message-ID: <20260521141522.GB1708231@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.48:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.48:from];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 577BF41BB7
X-Spamd-Bar: ---
Message-ID-Hash: JBEFM67PMIDTHC7MOELLMHL7PVYNL6ZJ
X-Message-ID-Hash: JBEFM67PMIDTHC7MOELLMHL7PVYNL6ZJ
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JBEFM67PMIDTHC7MOELLMHL7PVYNL6ZJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hello soc maintainers,

Please pull this small fix for the QCOMTEE driver.

Thanks,
Jens

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/qcomtee-fix-for-v7.1

for you to fetch changes up to 471c18323dfdfe7844e193b896a9267ae23a1026:

  tee: qcomtee: add missing va_end in early return qcomtee_object_user_init() (2026-05-20 09:22:52 +0200)

----------------------------------------------------------------
QCOMTEE fix for v7.1

Adding a missing va_end in early return qcomtee_object_user_init()

----------------------------------------------------------------
Robertus Diawan Chris (1):
      tee: qcomtee: add missing va_end in early return qcomtee_object_user_init()

 drivers/tee/qcomtee/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
