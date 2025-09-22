Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38507CAC5A7
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 08:33:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7464641B8C
	for <op-tee@archiver.kernel.org>; Mon, 22 Sep 2025 08:33:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MHALy307;
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9EEE841B5F
	for <op-tee@lists.trustedfirmware.org>; Mon, 22 Sep 2025 08:33:04 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b256c8ca246so515540466b.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 22 Sep 2025 01:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758529983; x=1759134783; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wkIzm5m7B0ssa400o0SQcXX9xaCknpA3DrsUwrYRW6Y=;
        b=MHALy307/6DDUAiSLX8EGqncJdjH9OneVrtbvgePOfiVoQpB+6SkCpWOT6Zfn3e19/
         yHwVoylqprF2oWcfCo5H0nyumEEIeShvf3ec+lVuRN9mUgKGcFU2a3bFCC/8FWpEDWZM
         sAvTjTqbUzNrnZwYBK0z1pxXoHg62i2G416c3asLC9UdZGqWWSiDMVXjK1SZT8iuxcfI
         Mphy5TnriJdeimS0rm32sQVFSB0Y8T0j5aGFHy7bHYXiBxM0oVYz/d1BI0I7lAtFITpE
         ZK/QIDTvbqFgQVR4SEXAcFRQhHeFgsUnKdEZtSz3sRaRLWvYY6WbTmrZHLItwvNud7nn
         gKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529983; x=1759134783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wkIzm5m7B0ssa400o0SQcXX9xaCknpA3DrsUwrYRW6Y=;
        b=tCERHHCi07AolOi0k86kPL9wz7JWMW/REjMPDXk69vv4aPuF9cmQ/4wTQgjlSWznO9
         1kJOqtzuqMuQhxesPyQUDnoWJiZA4OSmM6lsK2KwXl9csDsVoc3JYfa3ak5Kk+XBA2TU
         b5qYrXvGn5FgG7ggwCPCms1Soq7y2KZE1IoY45T4rrTGPE2n8c9mCsvrTbVSGb0CRvHi
         81U7aXydt2TPP2ThX1TkeZ+I2ZQYDRpTLgbCieIy6IRxwhMYbaHhFKxd4W73jd+6cSNi
         7MqWnliMuyZVy1yTW+NXJU/zwNuAX/NWNfuZTTwiInaemRNOjFWLv+QYal1VBMQVH5yl
         nz8A==
X-Forwarded-Encrypted: i=1; AJvYcCWuh+js7i58nebYch0EFmjj/kqUDSQx6Y2nOaaUg8ijyyd3rNNee6NWEiixcB6NbyA4Okr/iK0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzU9cD6d6+CTHYTGXOuAl6U9ws9wXiwBVNhfFY0bIVZkThzgnGz
	zmotqbaqK6vs3l1gKseP8eKp1rsjGyrHiU0gDznBh8GCnK1wNuAxcwEH3cbrtnhNIOPc5Q==
X-Gm-Gg: ASbGnctuzzkeSSGoiIgKCyusoTA0Wz+uKVoJxabDSn8q6aURlbPmhOvLZN94HB6BbVx
	zMEyARXGAKiteTc2NjnxB/3yRrVIOslyLOgxXl7lcAgiLT5uVqjNLgdysYm7e8u2Qqd2emkgylS
	t3529OV+cU8F7YxmT+dvBH/wgaHCZPBj21JGK8InTN3LkvogIleYvNVrJhTE40n3GnIB+y+hVrd
	zTEnQt0e3H1pIvErEfv2fPZDovFdMSOy2LhWRp8eENMzsaQ1bcQwdkMxPDbTGBRMCN3U8cFH9qC
	yp/BeekN4WquI4n/3WmlTUXVpGbJw8zAAT4bQIGkThYtHHKxEIyOGNYahg95nBB8K/ZtpPz+603
	uPLnqI4Bq8+NvbrE2ehAqp9BEE9mSxvDeiR7TMRJeIi7My4IEQFgjHGtD5E/bN98mvLFi92au4d
	4=
X-Google-Smtp-Source: AGHT+IEbPgqjM7/4K73DMablLEbgOSElJBbGuyrxWLRLXPYLxggtPsrNtX/eVEM7H+fF9kMNQPcKqQ==
X-Received: by 2002:a17:907:3c92:b0:b07:e3a8:5194 with SMTP id a640c23a62f3a-b24ef97943emr1080157566b.22.1758529983418;
        Mon, 22 Sep 2025 01:33:03 -0700 (PDT)
Received: from rayden.urgonet (h-37-123-177-177.A175.priv.bahnhof.se. [37.123.177.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb52a2sm613789966b.53.2025.09.22.01.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:33:02 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH v2] tee: fix register_shm_helper()
Date: Mon, 22 Sep 2025 10:31:58 +0200
Message-ID: <20250922083211.3341508-2-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9EEE841B5F
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,linaro.org,vger.kernel.org,gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.218.44:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: JJTJWR6JU43WFBMQUYAYIAO23CVPLO5U
X-Message-ID-Hash: JJTJWR6JU43WFBMQUYAYIAO23CVPLO5U
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, Masami Ichikawa <masami256@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JJTJWR6JU43WFBMQUYAYIAO23CVPLO5U/>
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
Tested-by: Masami Ichikawa <masami256@gmail.com>
Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer registration")
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
Changes from v1
- Refactor the if statement as requested by Sumit
- Adding Tested-by: Masami Ichikawa <masami256@gmail.com
- Link to v1:
  https://lore.kernel.org/op-tee/20250919124217.2934718-1-jens.wiklander@linaro.org/
---
 drivers/tee/tee_shm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index daf6e5cfd59a..76c54e1dc98c 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 	if (unlikely(len <= 0)) {
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
+	} else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+		/*
+		 * If we only got a few pages, update to release the
+		 * correct amount below.
+		 */
+		shm->num_pages = len / PAGE_SIZE;
+		ret = ERR_PTR(-ENOMEM);
+		goto err_put_shm_pages;
 	}
 
 	/*
-- 
2.43.0

