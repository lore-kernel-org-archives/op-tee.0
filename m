Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD47CAC597
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 09:50:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1BEA143198
	for <op-tee@archiver.kernel.org>; Thu, 18 Sep 2025 09:50:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DCHpwJYU;
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4CCA640B18
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 09:50:31 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso781738f8f.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Sep 2025 02:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189030; x=1758793830; darn=lists.trustedfirmware.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQwKqTQzxVu8vPTkPS6AVCaGBlFPjm0mxCJ88MPBe7I=;
        b=DCHpwJYUIuzpX+0E6GUC2NjQRv4PhDA4+Gy1O6pesaF+5UtEIbmLfmn+2AmbeRz0Kf
         3JGFhFIMqJCDtHhqb1vOAZdTgkd3+bQ6VIQ742E3V0R+Q03vcuSB+zNvGN/AXK2rrnvo
         xglqYawmhOSNnHsOTnNQbky7LfSWQT5FckKH3vRvvRZrlYvs3g9mqbQTCLnG17R85/iN
         KscOlqhylS49sP5epck59CQLiKVNSbX9X0TIuXVCWGyIvnwRnQq8w+KcNSLiZQKnIaIG
         v6AGN36/jND+4eL31J66dMmMQqxH2jRbFy1b58WgxaCmwtZj8IgSJzTDPU6oRjyt2NWm
         bo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189030; x=1758793830;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQwKqTQzxVu8vPTkPS6AVCaGBlFPjm0mxCJ88MPBe7I=;
        b=BbvJUTA35V50ja6DzCV1pljrUTG1WO/kyhBViSaL43N5YmZvG7Rza58HPUsFU+HpRu
         1msQux11tugcH9I490tti4KZ/FD6f1njyxOnDoSgjvTyy5cKEjMp4+YWcHukk2CBLd+W
         lvefA5zoJsOWjOtHt9A3211g5lNatHckU5OctXZUKB4Fhqg1CTyOlc2MzppTcXNyywdm
         TCCjijrTWPmL6VZ2+hDs49hu04uoqHrzNKgm8+yytw5C84HC+R2Fh3ukXSMLHq34jlRs
         uN9CDUEcAi7mnWA/p3FDLgk7JEUC+yaCib9+9V2Tr8yda4uH5ddmZcZ3Mi/L3QXM7ZVM
         meCw==
X-Forwarded-Encrypted: i=1; AJvYcCV9bcw0NywgqYMM5mMLXF6nFapeW9tbBynZ7RHZq3kUCMbgPYFLdVpCwUD2DXOMYyg94FcEwvE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxSvz46KOeffyI38iOufL7TScuFBm/f3LHpaiU4LekJIGfrlgtQ
	8IJ6MKJ6qidXGysUfW0kElXQ+SkHwA9hjBuQl9RetiZyesEfh+gbzDxc8jsX4exuvvo9Dg==
X-Gm-Gg: ASbGncvbvN8ath0n/xfgqQteq9FdLM7C7MQsgJkSuKdLGVb9YCNkFskCcXoz+SdAhoM
	R6OXbXnXfuKAF/HA3GsTwQToSODLNCrXAr9NwLyBC+U7kZq19IkIrXPph/YY8n3ZlGfH7a0wmgD
	y6LBNW+a3R45a/CBxut3HCUHOPpLnjbf8fdnPZiz/vsZ0i21fXM0hjw0dEHpvEI62gqsJbXakQW
	p32A4YU9sClxeWT3THoHEMui/LZ73h3DHVEdYyVEAOZA1cdHogVVKXs/0SHaQFM5rfDO93LzoG9
	R+lLK31wNBokcWQ1cPKS295++0Yggnoire8yWlvkRc/52evIrKsHPjgYqre21DOWR8ludR/eHhz
	FZ/4ezAoajJjFKC2v+ENsLkTfQgsuwfAf1bglG5tNcl1Xiw==
X-Google-Smtp-Source: AGHT+IGoCMIZSYVGVdr+LonBDIWcYYTv19TLhpipu3kLj9HY+JsSF6G9ZNs6lLtq6lsBFQeD0PjV6w==
X-Received: by 2002:a05:6000:1a8e:b0:3e7:ff70:1b41 with SMTP id ffacd0b85a97d-3ecdf9c9fc7mr4630089f8f.25.1758189030108;
        Thu, 18 Sep 2025 02:50:30 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee0fbc7107sm3078259f8f.30.2025.09.18.02.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:50:29 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:50:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aMvV4kK386Sni10i@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Rspamd-Queue-Id: 4CCA640B18
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.99 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.221.50:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.221.50:from];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: EQAAJ7KY6L5QHTTKSVR34SRQCEEMVRVV
X-Message-ID-Hash: EQAAJ7KY6L5QHTTKSVR34SRQCEEMVRVV
X-MailFrom: dan.carpenter@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EQAAJ7KY6L5QHTTKSVR34SRQCEEMVRVV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Re-order these checks to check if "i" is a valid array index before using
it.  This prevents a potential off by one read access.

Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tee/qcomtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index cc17a48d0ab7..ac134452cc9c 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
 	}
 
 	/* Release any IO and OO objects not processed. */
-	for (; u[i].type && i < num_params; i++) {
+	for (; i < num_params && u[i].type; i++) {
 		if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
 		    u[i].type == QCOMTEE_ARG_TYPE_IO)
 			qcomtee_object_put(u[i].o);
-- 
2.51.0

