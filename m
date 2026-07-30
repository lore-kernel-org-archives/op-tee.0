Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22172C55174
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:23:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 70DA145332
	for <op-tee@archiver.kernel.org>; Wed,  5 Aug 2026 09:23:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pr3Njlq/;
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7578F436DA
	for <op-tee@lists.trustedfirmware.org>; Thu, 30 Jul 2026 06:22:33 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ced3386430so17763105ad.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Jul 2026 23:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785392552; x=1785997352; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6BV+RTasTrqeP1Jp4o3Adp3Dn5TZT1GiHMHkH/KgnOc=;
        b=Pr3Njlq/atobVfI+Cl88oxrgevu6ccNNH0Ag5hqXy3sg+TfgCW0MVSOkG8z15XeszS
         f9MZWgSlHqsu/7pLzU5TVvoDNt7XNBdikwYlG71HhP1G+CdqkejG4c2FsUc+dtNL4T0G
         cMFrs05vApKpTIWvMCCzVmTMXQAVOPFd5DB285p7AVAd8egA5upeFOqkw+o8VAWCvWIp
         JZKINJtAPhsi2yRmtAbFR9A56i0ZxAaDaK9eCJn0G1V2XLlm9jGQ8FcNL5o4RF60G0wf
         e9gWnW+OCXlOOA/nUapBUk7jVpTsCjn6Gb7d8ltU9sJq6bQ7tix37e6t8zBcFDdornap
         ThVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785392552; x=1785997352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6BV+RTasTrqeP1Jp4o3Adp3Dn5TZT1GiHMHkH/KgnOc=;
        b=GfgFAU9KXdGqZ7Oz2+Q3I+YNaEBNrYB63TANUIawuGBGeUjWwKo8Qj1Z4uLBCpcgz6
         +3FHU69UoQpzX5XGzBE+WSQyjjpBy3aZn3iTwbxrDvcpfcidpkOQOp3+ci9pVvrPNQsz
         0z0BkoLzYOTN3Z93t0QQXA9KHU42kXSe1eA2W5oR/Bslrmviv4AQRnvUn/Q71Le/AaMy
         C5IM1R6wxS9A/ISvvffRnSXWLsS/tqKcAU3FAhpqiDilobezOJUSyGqC+6PmcO62La9Y
         uZYEz8BkFgwvkBVpGKa3o7S2z8cAimuxw+rIr3ZP3K/5KEV+iI0tWDqxw24ewiRNxdMf
         drgg==
X-Forwarded-Encrypted: i=1; AHgh+RrblyKFVnT8SWLWYdvlY2n9aey61pz0rQpoaiKuxd0T44ynIt/GvhyeMXzKplj8OKb9UF8e/HM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxiECx1JkIULY9bY//nI+CYbbInTxVeoxqwIysuzRysjYluq39l
	XOidRxx/0RJ3XbgrMTeR0SB1/CFFD8imYOMw1bvcHd4vOzRn9+YYJ/AZ
X-Gm-Gg: AR+sD12wC60rfK+D2soNOPNiO6Bjrez5mOrr2zNQciVgZkygpxQjUfYSI32jFWnmhFO
	/VoPsCHqFcM+56lLmYPKiXblJq+BulvX82qm0GRNHfojxbFA0V99BQkgpcySU+ggcNn1981TqOc
	RBhkQCAl/zxzyTA/RIgSZx8QD9kmtvzNOGMB2Jy7Xu4pUlW7vJ2zqqAqbK6uduviTFnYANh4JGk
	gnwRSMgmHIStH2c83e0xOKAoTLOakxOlAabviGb02wPwOHGxyBDcP5nXKjfKj9filCJ/7uUI4pc
	FQ3kv4+9SMmB6rv1VJNAtLW2VEDEBUNY5LkFCEdtELt52xlQfPZAmhG4Fd/Ym5myK2kfurEHlUD
	oM+iHtnkJ9Dd+TLw2XNOK2H9k7PFdquhXz6Qkn0ulEkBa9Bok4PDsP5h4C3RGY9sgCWTP3EilMT
	ZQTGpZrIs9lGQeNof+2Ki5m+w24CDOYKq3YmEBJ4GacRbXvt5zcH7YCJIhbfWm1X/5menEGljqa
	8ipb+CZ3dOF7ZP1NkQyc8cPzQadDUa4xbTniCmt0fNJp3j++w91vwlDNYSxsU48
X-Received: by 2002:a17:902:e946:b0:2ca:6d87:cda0 with SMTP id d9443c01a7336-2d035b9ad22mr14382925ad.6.1785392552424;
        Wed, 29 Jul 2026 23:22:32 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022a151fbsm20950225ad.10.2026.07.29.23.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:22:31 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH] tee: qcomtee: user: check the parameter count from the supplicant
Date: Thu, 30 Jul 2026 15:22:19 +0900
Message-ID: <20260730062219.2836938-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.trustedfirmware.org,gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.172:from];
	NEURAL_HAM(-0.00)[-0.959];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[gmail.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.214.172:from];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7578F436DA
X-Spamd-Bar: --
X-MailFrom: sammiee5311@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: ZMB5BD6KWRIWQIJWECO4FIZHH2WK3SS6
X-Message-ID-Hash: ZMB5BD6KWRIWQIJWECO4FIZHH2WK3SS6
X-Mailman-Approved-At: Wed, 05 Aug 2026 09:14:42 +0000
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, HyeongJun An <sammiee5311@gmail.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZMB5BD6KWRIWQIJWECO4FIZHH2WK3SS6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The qcomtee_cb_params_to_args() walks the argument array QTEE asked for and
indexes the parameter array the supplicant supplied, but it never looks at
num_params. A supplicant that answers TEE_IOC_SUPPL_SEND with fewer
parameters than the request needs makes that walk read past the end of the
allocation.

To fix this, reject a response that is too short, the way ureq_select()
already does for the receive direction.

Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Assisted-by: Claude:claude-opus-5
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
---
 drivers/tee/qcomtee/user_obj.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tee/qcomtee/user_obj.c b/drivers/tee/qcomtee/user_obj.c
index 10452fcc7ccb..2a594ae299da 100644
--- a/drivers/tee/qcomtee/user_obj.c
+++ b/drivers/tee/qcomtee/user_obj.c
@@ -507,6 +507,10 @@ static int qcomtee_cb_params_to_args(struct qcomtee_arg *u,
 {
 	int i;
 
+	/* Supplicant can not send fewer parameters than requested. */
+	if (num_params < qcomtee_args_len(u))
+		return -EINVAL;
+
 	qcomtee_arg_for_each(i, u) {
 		switch (u[i].type) {
 		case QCOMTEE_ARG_TYPE_IB:
-- 
2.43.0

