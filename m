Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B82CAC5AA
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 12:42:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6F86A4319F
	for <op-tee@archiver.kernel.org>; Fri, 19 Sep 2025 12:42:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gW3K2+XN;
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7BF1D40B16
	for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 12:42:38 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b264afcc5c5so75009566b.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 19 Sep 2025 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758285757; x=1758890557; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wj7WblQsPSyrGWWKSxzzmKooYDH1YcR0H73P9e5XZO4=;
        b=gW3K2+XN9TUpQa+IJ+heqgRMfHTQRJW201nORHh8hM+hrT61ekAkQeEEMwyvnvki9D
         78EkBHjL1FpxPhwqY/RLwXieov0ZJIyzxxxKmCDJkP0IRqt8odt35hDSf+jTW0FZjD/1
         7/bU3bProwqKscNn8Yd2e34/ZP1ldb9dYcyY4WufDlSPdlOS0yATM38bw7m2U1xVjGl3
         6C4DZlGvrHDe2QkX2hg+CsfvF3S8M30+oQYgAcExr31rRyu3fcGkMjzuKsDHyB3Fq8X6
         slVjEMk9aB1Jab9TNamkc7s1aMeBJz32RPtuH7ZzxcFNAoc4OcFg+9XwBP8lhiqlBOJ9
         ksbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285757; x=1758890557;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wj7WblQsPSyrGWWKSxzzmKooYDH1YcR0H73P9e5XZO4=;
        b=TBcfk2B3vXGS5o9hqo0VKf2O265DX9ZWX/b4gcTJjXGkuxgvrsu/RK25lQl49fX9FP
         H9p2gxTo1k5no1uFERvwE0B8sbAsROo7/Hbt2PM4I2He1tagYhW4rkXPyMdcCNUXzm99
         Gg/WRDsR9K6nD/r/FmnazCdS6kmDTMDuysKPHqh8ct83mghgdhWHnBH9/cf8hQuJ5Agd
         KfBSN12p3qM5pyOUioZYniO8k5WX/F5nJutVGmuVldl/S3ddhY9oigdh4pFv3jAoEP3g
         C1juVoOPM5UsW3rFmhF7LVZ3EkEKSIhSjG2u2SEojVcXBwd4kD9gZdTrVDAyUHVZeeGH
         DX5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzG/fTUAGEPhjZsy8huBScP9Y6+3o8Xl+o2jBfRvYBpcoRMRaHZ4wOzGUwu/O5VYoTCADNOp0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YymqeP/GHKYFFi1Z5XuXCF0l4z+tV86NzMA4EuAsZvwk9idsKeP
	bX56VkEbMQpVK/yv02UTwUlzzyxN6iPrhYg7NmuYnb/PItcMXnCsUfiu1/nErKaE6LIFKw==
X-Gm-Gg: ASbGncvBnfdJd8BFRu/DtzabPRAsNExpENWc8mmozzc9ULiMA+dPAdyWmsXE8HlzQXB
	0F71UWWFkdpCF+Qm+5fB8kmvC3/15FMe2wH9DyV1WtCZhEUWdmAYnU7ocv2fBQpwAeeYXW1qGmG
	gOWlCAglalDW1UtIG10qRlF1Xv4WpTT8Ud6YuGnjCiFQ/Q9M6qNxXPuyCFN3ZHNp/80BP7q058s
	tqc2BAcqXsDohXaMh+oJD4XwneYz6cC208fM6kaTz6F3WSQbTwo1jcGTJQJkfarcitNoif/cUT0
	zxk81for/0XcIrEMFIk374MA14YKRXPGIZJccbLDzjhr+FEgZ8XvHmGTmToCh7rf8PbEfG2ics5
	ArDzwE+Oq7q8qF8uI6EglLb7ON9AVmINc74L5HrmbVHPrq4czuYaTV/Npu8PQsS7TYMnb589mYx
	U=
X-Google-Smtp-Source: AGHT+IFr1BTounEptyjlbKSLG3yb0rrKq8OODXhqwAInRGVZzvO/n5qSDVMOGac6sdWkTXPIaFNEFQ==
X-Received: by 2002:a17:907:2da2:b0:b04:6e60:4df1 with SMTP id a640c23a62f3a-b24f50aa963mr308717466b.53.1758285757281;
        Fri, 19 Sep 2025 05:42:37 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd262993asm429170166b.94.2025.09.19.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 05:42:36 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: fix register_shm_helper()
Date: Fri, 19 Sep 2025 14:40:16 +0200
Message-ID: <20250919124217.2934718-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7BF1D40B16
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.41:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.41:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: RC654GHM2KLUXT43FC4SLSNN26PTXA6J
X-Message-ID-Hash: RC654GHM2KLUXT43FC4SLSNN26PTXA6J
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RC654GHM2KLUXT43FC4SLSNN26PTXA6J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

In register_shm_helper(), fix incorrect error handling for a call to
iov_iter_extract_pages(). A case is missing for when
iov_iter_extract_pages() only got some pages and return a number larger
than 0, but not the requested amount.

This fixes a possible NULL pointer dereference following a bad input from
ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.

Cc: stable@vger.kernel.org
Reported-by: Masami Ichikawa <masami256@gmail.com>
Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavnTjJAvUbEiQfq=u9W+-g@mail.gmail.com/
Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/tee_shm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..6ed7d030f4ed 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 
 	len = iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_pages, 0,
 				     &off);
-	if (unlikely(len <= 0)) {
+	if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+		if (len > 0) {
+			/*
+			 * If we only got a few pages, update to release
+			 * the correct amount below.
+			 */
+			shm->num_pages = len / PAGE_SIZE;
+			ret = ERR_PTR(-ENOMEM);
+			goto err_put_shm_pages;
+		}
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
 	}
-- 
2.43.0

