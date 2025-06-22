Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A37BC7115B
	for <op-tee@archiver.kernel.org>; Mon, 23 Jun 2025 06:45:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8C1CA42C18
	for <op-tee@archiver.kernel.org>; Mon, 23 Jun 2025 06:45:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NxFQAlrn;
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DBB913F791
	for <op-tee@lists.trustedfirmware.org>; Sun, 22 Jun 2025 08:30:07 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234b440afa7so33264335ad.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 22 Jun 2025 01:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750581007; x=1751185807; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ba4y9rSMpoG3drHbVgM/Q62fZ7iIVMVCegaFnhMECpQ=;
        b=NxFQAlrn/oS93QtAqx9DT/ITicGB4lNV7PRtBbWYJW8Fv0nAD3Wgdu8GpEqAArd9tu
         71g4GyHoa6N/N74zNzBuZ/ajImex1/As6qTyuLkwKLF1ZSkZyisep3dN12Xfucb5KPJP
         pJa2qjGUPTHX4zr0kPdzLML8t1mtt0mhyXGp5bEuoGaWkBnwIUQLr/PFpD4EHnHRGJbm
         uHkuuBA7SANCjXTNodwHPkWv0R8J6mrgsZQfooJ7K68ZlttMDNkbXGt3oNMcuPNuEKXN
         CIRE2Uxjl3BNkuxj9bqXnucxizCGoLLXqa+my1ziuL32wBFeoGUVYmHYkT3kFeRuujMI
         EpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750581007; x=1751185807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ba4y9rSMpoG3drHbVgM/Q62fZ7iIVMVCegaFnhMECpQ=;
        b=AKeoXTd/NkAULCY2pZ6dBfynchDk0BxS6YyPFGyJqFYeNf4uZ+nbouodRmfbpzpptv
         InFY3RsEwSs9Gs3C0xD35G0XsLEZPPQLDzhW4SgbbsEL9tob76a3kzEE8u2W+SXkh9pw
         UiNjhgzWCGYGSQiGr/D2q/61iKauD47VS8CiJ8xm2iIgl4qxfYrGHAl6Xf26bmuHd0ZT
         aO6oq8/8+ML+sq6IuNwXq83s895226mDmtkq3VXFssd077CvJjoSPyA2iSrWrudx5HGd
         DOKPnQpfY6R4F+2/Vn9rH4NwrrjrQZKagaVw8Dm/2JFTkKiv7LQWORXbhmSduUKHCd0C
         DGVA==
X-Forwarded-Encrypted: i=1; AJvYcCXw10jGeuK9RjBOejOEb2rDEJtR5ym3mVdY8Dql/5GD6HH4ah7NbyTcqhja4PHDdh4bU3YK+cs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwkytXCbJIzKK1FK0N1aZu0d7Z7zbhND9Vdp0Y+05aPGq7xL5xv
	TrzWGv6kgwZpVPt4DuI15o30LPwt7p7lLFeKNBQOhuXXX0J9W4MPK2j5
X-Gm-Gg: ASbGncuttO4p7eYMMRqloYdA6nHlY0ONK/y8DKE5G1ojm0AdAbdwKP1FqlbwTNuTnVO
	oYQXTllq7mFa5psO28fVLW8oHA2rdb/TN8gVSrI1+mPD3fc6j04M6mBgdSTPyufjqX7tYQD5JQ7
	M45D2M6dlH/gZAe3O38eVjy4B4MGKp7dH4rPqVSeIfYtGnT52/UHwPR/xmHZ2Df7H2HziNIdeQr
	T4rSYIJ2o8H+boyNd63GQxtdJlQnwjMlocCDHpUBoIzicEowrq7gr6C4reIptAWeKYaOJ2kaRxO
	aSrOG5zTnXfovRHTMc3XYPPotLQND7XlKRt16bQSyR0up7PMR9T/hM/B2/VyAW0V
X-Google-Smtp-Source: AGHT+IHCOpphmNin6Qqhtmga/k7CEZiwYLnGk9Mf4C1xbYCMX71ZPFGmqeVUra6+85ZXY5SOGNhzQg==
X-Received: by 2002:a17:902:d50a:b0:236:748f:541f with SMTP id d9443c01a7336-237d9891ca5mr140646365ad.33.1750581006806;
        Sun, 22 Jun 2025 01:30:06 -0700 (PDT)
Received: from pop-os.. ([2401:4900:1c94:78d8:20aa:360b:188f:5bbe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86f7cb1sm56520595ad.222.2025.06.22.01.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:30:06 -0700 (PDT)
From: Abhinav Ananthu <abhinav.ogl@gmail.com>
To: jens.wiklander@linaro.org
Subject: [PATCH]  treewide: Replace scnprintf with sysfs_emit in
Date: Sun, 22 Jun 2025 13:59:11 +0530
Message-Id: <20250622082910.13897-1-abhinav.ogl@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DBB913F791
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.214.179:from];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2401:4900:1c94:78d8:20aa:360b:188f:5bbe:received];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.179:from];
	TAGGED_FROM(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[]
X-MailFrom: abhinav.ogl@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: OF23C6QMV2VG7WMHRGAXDG2Z2UU46W6Z
X-Message-ID-Hash: OF23C6QMV2VG7WMHRGAXDG2Z2UU46W6Z
X-Mailman-Approved-At: Mon, 23 Jun 2025 06:45:38 +0000
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Abhinav Ananthu <abhinav.ogl@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OF23C6QMV2VG7WMHRGAXDG2Z2UU46W6Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Use sysfs_emit() to format sysfs output instead of scnprintf() as recommended
by the kernel documentation.

Signed-off-by: Abhinav Ananthu <abhinav.ogl@gmail.com>
---
 drivers/tee/optee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index c75fddc83576..ce44e3498d37 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -72,7 +72,7 @@ static ssize_t rpmb_routing_model_show(struct device *dev,
 	else
 		s = "user";
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", s);
+	return sysfs_emit(buf, "%s\n", s);
 }
 static DEVICE_ATTR_RO(rpmb_routing_model);
 
-- 
2.34.1

