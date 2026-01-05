Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E49EC79F87
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 13:27:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6FB9E42FF1
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 13:27:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LEl9jN85;
	dkim-atps=neutral
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4F48B4FEB0
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 12:50:17 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767617416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lHT9J4DhsH2RX69SgA6OV023LvbhAbhKj1QDNOw06eg=;
	b=LEl9jN85ye8+ECSDRsGfj5iZ+/C1AAGNvLeigztutbHIFYvIK4MsfV0+4Eo+h4+66+Vsay
	NFpJCtSwMVN1QUVNOaFYyxPfIzuORhxhaAZdrc0M5mKYTRHCdTfZvDh9QKvkaLnx5IGnEX
	lvAAEo6MoULwxbIR/cmJB91JfEEvn0A=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH] tee: amdtee: Remove unused return variables
Date: Mon,  5 Jan 2026 13:49:41 +0100
Message-ID: <20260105124944.47817-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:95.215.58.0/24];
	ONCE_RECEIVED(0.10)[];
	RCVD_IN_DNSWL_LOW(-0.10)[95.215.58.182:from];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:202172, ipnet:95.215.58.0/24, country:CH];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[95.215.58.182:from];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4F48B4FEB0
X-Spamd-Bar: --
X-MailFrom: thorsten.blum@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: GNGSEPQMG5EBV67FJFJN264OVBRCZI6Y
X-Message-ID-Hash: GNGSEPQMG5EBV67FJFJN264OVBRCZI6Y
X-Mailman-Approved-At: Mon, 05 Jan 2026 13:27:42 +0000
CC: Thorsten Blum <thorsten.blum@linux.dev>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GNGSEPQMG5EBV67FJFJN264OVBRCZI6Y/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

In tee_params_to_amd_params() and amd_params_to_tee_params(), return 0
directly and remove the unused return variables.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/tee/amdtee/call.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 4c21b02be4af..460b0c9e511f 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -15,7 +15,7 @@
 static int tee_params_to_amd_params(struct tee_param *tee, u32 count,
 				    struct tee_operation *amd)
 {
-	int i, ret = 0;
+	int i;
 	u32 type;
 
 	if (!count)
@@ -66,13 +66,13 @@ static int tee_params_to_amd_params(struct tee_param *tee, u32 count,
 				 i, amd->params[i].val.b);
 		}
 	}
-	return ret;
+	return 0;
 }
 
 static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
 				    struct tee_operation *amd)
 {
-	int i, ret = 0;
+	int i;
 	u32 type;
 
 	if (!count)
@@ -118,7 +118,7 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
 				 i, amd->params[i].val.b);
 		}
 	}
-	return ret;
+	return 0;
 }
 
 static DEFINE_MUTEX(ta_refcount_mutex);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4

