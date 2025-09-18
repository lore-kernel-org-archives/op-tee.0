Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CF5CAC59A
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 09:51:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E8E9740B1B
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 09:51:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BPvn6xR+;
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CBEDD430D8
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 09:50:45 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ec4d6ba12eso418871f8f.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 02:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189045; x=1758793845; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/T2Fr2QIkCHSSj1+Ut/Hdbp7X7o/yIWkxiXRdzpcpk=;
        b=BPvn6xR+Bv3/xG9HXZAnH2yFMSR+t2JwuDrJPOWNHki/nZWrSVrNPwcDFHQ3DmY6gS
         sFpW+rMhC6N1QqsV9Xr/iUXNaSStHI0/CkxKtwSY7bXvxIbPeLQLrsmfxfWJTjxq1nTH
         82gmB+1qLnDGcVWd63tfQjx9kBV2srBZz0PClteY+Vooe2xHr+EbfVuPIUPpLOEJrV3Z
         tljjbwhZPylbAh4+HJ0vRfhjITlhFt9Bhh+qQRRyNIFTjp+jVYMM0U5oQdx4zYdy4MVj
         D99O/Np8YDIyC+ceY14gc7oGqr4t/qdjn9Qy2Xotkp6zyG5Gv0PK8SC2BxQULAplxXTV
         vAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189045; x=1758793845;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/T2Fr2QIkCHSSj1+Ut/Hdbp7X7o/yIWkxiXRdzpcpk=;
        b=TJRrfdpOnxA+MWj71HbEcESoKfVUJEnbszAekX24lgXc3fMKmHOKOnFAsuWjN6u/XH
         UDteD7VIYw18WHk9fY0L6nHsnk9uxKFiQ3b7cAfGFz83mX/iBed+dm5DOEnnr/vkuTdH
         +NVhQ0Dm23iMboPUxGJKJnclH6xN7j9DMITNIzde/u74wWQywB5fA/hww8QNVkwMneKB
         7FaSTbuSNNgRJ6DnGQDBigSHzvopVxPGqznjYmLz4wOhkTXnpzHovYl6TOLQPxhCj0cP
         PElFpruqptZ2fRjHgKO8HO/nCpL6DZez8mKx15gUDFynHnEP9+Uuc70Np1hJCjsxXJim
         BL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe8UFG8QssvgexUq0j7wAZd2J/8M794wZQdLgv5U8Lc6lMnRfQazv8ZU5ZbUwcFZBMXI+OXeM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzmVS9w+gut2ZrXg3gvGwJxUVKtzmMQp3pwsuQLawBxGVor0/eF
	oH9OjLMppe4lakxC11qTSxUSSvnJ2qVe0nq9a3RsXIKueUQbJdenJ8DGnACAISE8vZsXyw==
X-Gm-Gg: ASbGnctzZjJ+zFVIxM+iZGvAcAlT1NoUKNUhVCxJcXWgzZ7XzBiZadJSi+gpItOHsFW
	0ghnui32q9JdmxLEM5Oqx0tutMqlDI0qcRNlRxxHYLXQWA5Y0pUqVwNk9HDwMJf1U8qsJl+b1qG
	5QNB0bIooNRHnKQpfhYAAPndXdk+1+mMXTaEuI9s9dH2Tvo0s32o3kRRvcrBEFHmWiHHmLIKItV
	zF4fFhFRVk3JGcqnOcdwh8sEwswtC7nvf/CVkFrv8cMEiIi3JuDtYcEMQBs2vsKW67fELDDFok3
	H8R1gGMmKj/91+hhkRODEP+tZoNk5pVXZ3mHk8OClzddup097WsUxIn4iLuLY/X9Ct/RxwDC5EG
	9oSdufkANXyyyDn3Q8CAd9HxGSZsEvYSqk1gfOdEgaSIz4w==
X-Google-Smtp-Source: AGHT+IF/P3JGmGE10PIfdHqwzm4/ifWKYQ/MXC5mVGrGtyVgrjAOWjLFRwF4sj8gaNTy6XhjFE43Bw==
X-Received: by 2002:a05:6000:144c:b0:3ee:1233:4673 with SMTP id ffacd0b85a97d-3ee12334885mr1189394f8f.16.1758189044856;
        Thu, 18 Sep 2025 02:50:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f5a286edsm37363195e9.16.2025.09.18.02.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:50:44 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:50:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: [PATCH] tee: qcom: return -EFAULT instead of -EINVAL if
 copy_from_user() fails
Message-ID: <aMvV8WIKnqLN3w6R@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Rspamd-Queue-Id: CBEDD430D8
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.99 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.42:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_SEVEN(0.00)[7];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.42:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: SUL3WMCNHXGBXMZQZXXWWQ2BK7YAMJGL
X-Message-ID-Hash: SUL3WMCNHXGBXMZQZXXWWQ2BK7YAMJGL
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SUL3WMCNHXGBXMZQZXXWWQ2BK7YAMJGL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

If copy_from_user() fails, the correct error code is -EFAULT, not
-EINVAL.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tee/qcomtee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index 783acc59cfa9..b6715ada7700 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -424,7 +424,7 @@ static int qcomtee_prepare_msg(struct qcomtee_object_invoke_ctx *oic,
 		if (!(u[i].flags & QCOMTEE_ARG_FLAGS_UADDR))
 			memcpy(msgptr, u[i].b.addr, u[i].b.size);
 		else if (copy_from_user(msgptr, u[i].b.uaddr, u[i].b.size))
-			return -EINVAL;
+			return -EFAULT;
 
 		offset += qcomtee_msg_offset_align(u[i].b.size);
 		ib++;
-- 
2.51.0

