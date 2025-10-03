Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7017CCAC5B0
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 12:26:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9F70B42CE9
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 12:26:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lLK+Q9nt;
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 61E11431E3
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Oct 2025 10:42:39 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso1775364f8f.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Oct 2025 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759488158; x=1760092958; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cnw7imX7M/CNGtCIwlRgS7wbYgVU7qXQP5LaS4EJjWw=;
        b=lLK+Q9ntIqfIAc07S6MjTFCPusJC9CKtxIidNFBV6ZnsZ9Em/R8M+8eriV/tkVV63j
         Tyg4EJi80vKdyKLpTudpJsXnrV4ZWoVjNw+D7rD1QF56B0JYXy/D7cUY0AKqEeZdpxV1
         rGFVw6klC83dy2cg0Yc6K9v0EfZT6VqsJMNB85zNXz3n4b1iyJwxg+qR3uqiKbk5EAnd
         lbSrZtBmbdB/sZ9XMO/A52uFKfrRK8jvCjmsgr23f/nNXKa3JhDGN0rZ/Hsg+3sxiY4U
         GHCtzgqEss8jIjFppAKsKDZhcZ5l3pCin/g+xBCaiftun+ZRfd0FUSmK7ViGR+pW3JoJ
         lRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759488158; x=1760092958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnw7imX7M/CNGtCIwlRgS7wbYgVU7qXQP5LaS4EJjWw=;
        b=cNmgCzyEZUBd6rGcdA6PKn8RAL0EeX6cyFjUAp0BpveNoFLtUqKspGkFM1lLKJhg18
         D831veayDlWoTdlNnwOhHojdkkoSVLuo8x9ggXDY3llW0nG+YLWdtdhm2xjKbLthRzCf
         Fuy9iBfyY95Jeq1Nosdlc+T6P2o1WT2zl9NTMgy0O5lS9KAuR+u6nJCqQT6wkSAU/usZ
         ETwoiaEZKbq10C0Hl47IFdYLXTjoBYWlXvYt6C70zGU5Fhfa5emozWWzk/6yMISf8PBy
         1x6Uvaqd3i7dBi4lyB+cAYAmUoGfwvbR9OS6h42Qwf/IxVMZNHST8drM6WiQVuDJya9r
         TOxw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/GOqLTu7JJYdMQyDQEKQJbQclT99CAZrQYfCX/pvhCtRNhiIVzRvT0asC3+6zKq3AFbY16M=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy3OfPyHu02P1GREA5IYJyyA4TXjjFN2d6bTSDuSsLM5ZB+8syq
	DdB2DYhyd7bCEj4vzs3m8fxnSNzDDKQpExHCp4mS7A6zOa+y5BxIugqN
X-Gm-Gg: ASbGncu1evi0mkNaeL5yBn2dAQMrD+oBdPvo5vzNsIko9An9+Ft+HmtdY8cCpei7N5U
	M/9LObnH3b+wwPJZZp+EmO6Ixfil4LiUrOIHFMaXKzjqPnv9s6etx7qSC+OhtLo9HoHBud08aHj
	0N4XQhd0PhS6tYeCQisfPZYr5H6gY7kLHytqg0cFWauk0I2tzhNV4IB4LIvEUv8dzDCrFH21792
	dbYGZ2+E1JbJKT+j6IVui7MAuschhpFPty8HUqiaBq3e9AqEwOPQ6neCBe1zvthDY5XszPYz69B
	QeFRsmCOzS4lUfcf1PCUNstaLe5RLqK7mCJ/gdnzGEsnCYvTTv8VlcvaN4y7gtGFynx8wOcIqqj
	0wjJrZGWom7wB2mvl34iS2+X7c0bGOAB3joMb6wxwnhgap2+EDif4NK0b7lfSfUqHXKD9ZtaooT
	JmYimvDOCSoqEQKCEGJFcjxzXbC5Efaj3eKbulGsSUubeT28M7s0v6Ckn9cVZ83FkAbJvVRnPTE
	yiHdsjJYtyam8ly0AosxP4Rj9sD1O6uyWpz6NXXSY42Y5TRQ4BmxYsu1AiraqwFTQWsTf0=
X-Google-Smtp-Source: AGHT+IF3xeXbZRFfku8QnhF5YXHdX9BHpydCf/IP5uk05F4Qxom3Ww42auvnGEy/5SBToB7bjHwQOw==
X-Received: by 2002:a05:6000:184e:b0:3ec:d926:329c with SMTP id ffacd0b85a97d-425671c17cemr1665274f8f.56.1759488157951;
        Fri, 03 Oct 2025 03:42:37 -0700 (PDT)
Received: from cypher.home.roving-it.com (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:fb11:2681:e9:f8b:31b:f797])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4255d8f01a0sm7461882f8f.48.2025.10.03.03.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 03:42:37 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: qcom: depend on ARCH_QCOM
Date: Fri,  3 Oct 2025 11:42:32 +0100
Message-ID: <20251003104236.1813979-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 61E11431E3
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.53:from];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[gmail.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.53:from];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	NEURAL_HAM(-0.00)[-0.996];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: pbrobinson@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: EJB2USWSNJ7HFBEU6KB7N5S5SL72ZHCX
X-Message-ID-Hash: EJB2USWSNJ7HFBEU6KB7N5S5SL72ZHCX
X-Mailman-Approved-At: Fri, 03 Oct 2025 12:26:20 +0000
CC: Peter Robinson <pbrobinson@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EJB2USWSNJ7HFBEU6KB7N5S5SL72ZHCX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a dependency on ARCH_QCOM, and compile test, as the driver
depnds on QCom specific Trusted Applications (TAs) and it's
only, currently at least, supported on QCom hardware.

Fixes: d6e290837e50f ("tee: add Qualcomm TEE driver")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/tee/qcomtee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/qcomtee/Kconfig b/drivers/tee/qcomtee/Kconfig
index 927686abceb15..9f19dee08db49 100644
--- a/drivers/tee/qcomtee/Kconfig
+++ b/drivers/tee/qcomtee/Kconfig
@@ -2,6 +2,7 @@
 # Qualcomm Trusted Execution Environment Configuration
 config QCOMTEE
 	tristate "Qualcomm TEE Support"
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on !CPU_BIG_ENDIAN
 	select QCOM_SCM
 	select QCOM_TZMEM_MODE_SHMBRIDGE
-- 
2.51.0

