Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0867CD8C9D
	for <op-tee@archiver.kernel.org>; Mon,  8 Jun 2026 15:43:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C7C954449D
	for <op-tee@archiver.kernel.org>; Mon,  8 Jun 2026 15:43:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ICJGtliQ;
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C850543725
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Jun 2026 15:43:41 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so3986546e87.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Jun 2026 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780933420; x=1781538220; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9hDihijSQBjZLpkzpuvEEDmtbe4zNrobLHrcpQjfeY=;
        b=ICJGtliQLxoSpboxTpzVT+6L+mlsqmcGXpmztJvOhm6ija9/Mpjs7NZdF69TIoVuC6
         YG+xzTicerzbKAp76zJi+86+TjdmltfsTvUCQWyRQL3y0cMNsBxpnnmb+zMwI+1noDb9
         JuyapIxGgdVZiCItL6oT3B8003h7BAxsTOgQOSk7IMZKX29ReyF7/YZhwIMs3Lv42cdT
         KDQ3cryGWGSbBKEJPBwg3j8F47gBQf/hOT22vtemByD2nler/g5TSaOvqQg7HUE/iujh
         eDfZPFgUM+TZm7wl7DD12dcZ3m3QpabwUv/jBbq+SnwCmuahfIVwxEQ90l/6WsaWWfSO
         8Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780933420; x=1781538220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9hDihijSQBjZLpkzpuvEEDmtbe4zNrobLHrcpQjfeY=;
        b=rnQ0G4cpK7zAwD7t6PUWaBOwoJB64uLLpoU+2FI8Vk9tg1vBjT6fx8RU2WYOU/cjcF
         S73IdZm+Avr+x/2PlnKfdkx0nhXJPxZ0T97Cu1iPr4H1cWOBn7WL1rO6ma5Zl4WuGMZZ
         0K+t0g0+4cFXkORrICawL3Sf+8KncrE1+cCb3p5lLxo6lA4xG6n1A2XhC/mjO8iXKP/H
         SM0onblO93e2SPcSKaaH66yqxc32sda+S+upto4WkKMxTuAqC6JzphkFWC+eFekCYAm0
         tqfFM+7/91I8w1HGFkcKgDvyTTkm5wY58wFn7Zi+UK7MTGOzcV8YI8Z+NcBbAYooGfOG
         rbIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9j9Z0I2kELkixdbZUuvj84/7Xzy5RtQa1PHi5egudB7Y+8/gHVG+38qWHTKnwVM6Fr3/4p5aw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzb3pM2aePfrN/GO/sYZZN0tsYg91Lt3KNMF+c/0H98o793vIzj
	Y0/n5VeWdh50++/iFdpFsVrkGeQngJ9QPgNB9M5wKWo1k9ATfYaidVJH86+LLfTwizey/w==
X-Gm-Gg: Acq92OFBONDvNc9xETJ/HsXJ/TUij/xPR2ygmubJK/LxwaYR48ot6k1DXLlkuaLH1cn
	6uAsfvyAtbxN/79Rq0EnALb0NstSEpCR02bwKqmtEFRFMEQ2CfbHWNglW9ajTFeXkUkV8l2hqBs
	znCNaPhv6J6RFYdk/cN18S5DHIJa3YpoacvxKTwrRKhL4dchfsbbJR2qtsKEBHU0FUkLNksSFxu
	FwnKeWyrc44TnuQi9lRayemi8Qhio0s4cOJvkw7+jNER0C0n7qtx9VHi+WFFkRTENhraCKPLTCR
	TWhteNFiHH5ye/LUtqWf9oj4adBAohPQse0bSeRTf4XOchzbNOARym5uYBBmtI1ljRSJ8duAbVu
	CaPLNc7ra3oV5vb8TKxx6UG/dh1vm+IyVS+WOxvg5hfxkkbdfeDUtl/NVhzey84YohgerxTLf5o
	YtCScT7FGlkChYh+NSL8d/rkSI7f0xoUyTFbPvInmbWdDTMUHsMg173STof9C1MZnpq9Kvc2II8
	DUn9paYVs87earMdbczD3ozrhldDGutb9+QivKHBw==
X-Received: by 2002:a19:ee11:0:b0:5aa:661b:3fdb with SMTP id 2adb3069b0e04-5aa87c2393bmr3108072e87.28.1780933420343;
        Mon, 08 Jun 2026 08:43:40 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbe1dsm3891024e87.27.2026.06.08.08.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 08:43:39 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH] MAINTAINERS: .mailmap: update Jens Wiklander's email address
Date: Mon,  8 Jun 2026 17:42:31 +0200
Message-ID: <20260608154306.3808356-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.50:from];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.50:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C850543725
X-Spamd-Bar: --
Message-ID-Hash: HBAYLXSAM4NRHBAXNEB5V5WB466EWOR7
X-Message-ID-Hash: HBAYLXSAM4NRHBAXNEB5V5WB466EWOR7
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HBAYLXSAM4NRHBAXNEB5V5WB466EWOR7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Jens Wiklander <jenswi@kernel.org>

Update Jens Wiklander's email address to @kernel.org.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sumit Garg <sumit.garg@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jens Wiklander <jenswi@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index a009f73d7ea5..a0f20a6bbe5c 100644
--- a/.mailmap
+++ b/.mailmap
@@ -395,6 +395,7 @@ Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Axboe <axboe@kernel.dk> <axboe@fb.com>
 Jens Axboe <axboe@kernel.dk> <axboe@meta.com>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
+Jens Wiklander <jenswi@kernel.org> <jens.wiklander@linaro.org>
 Jernej Skrabec <jernej.skrabec@gmail.com> <jernej.skrabec@siol.net>
 Jesper Dangaard Brouer <hawk@kernel.org> <brouer@redhat.com>
 Jesper Dangaard Brouer <hawk@kernel.org> <hawk@comx.dk>
diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..440f855b95df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19958,7 +19958,7 @@ W:	http://www.onsemi.com
 F:	drivers/net/phy/ncn*
 
 OP-TEE DRIVER
-M:	Jens Wiklander <jens.wiklander@linaro.org>
+M:	Jens Wiklander <jenswi@kernel.org>
 L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-optee-devices
@@ -23303,7 +23303,7 @@ F:	Documentation/devicetree/bindings/media/allwinner,sun8i-a83t-de2-rotate.yaml
 F:	drivers/media/platform/sunxi/sun8i-rotate/
 
 RPMB SUBSYSTEM
-M:	Jens Wiklander <jens.wiklander@linaro.org>
+M:	Jens Wiklander <jenswi@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	drivers/misc/rpmb-core.c
@@ -26222,7 +26222,7 @@ F:	drivers/media/i2c/tw9910.c
 F:	include/media/i2c/tw9910.h
 
 TEE SUBSYSTEM
-M:	Jens Wiklander <jens.wiklander@linaro.org>
+M:	Jens Wiklander <jenswi@kernel.org>
 R:	Sumit Garg <sumit.garg@kernel.org>
 L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.43.0

