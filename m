Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D84F33A76
	for <op-tee@archiver.kernel.org>; Thu,  5 Mar 2026 14:37:13 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8C2C843838
	for <op-tee@archiver.kernel.org>; Thu,  5 Mar 2026 14:37:12 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 885F4430A2
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Mar 2026 08:35:29 +0000 (UTC)
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABnieBOQKlp8MneCQ--.11139S2;
	Thu, 05 Mar 2026 16:35:26 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: jens.wiklander@linaro.org
Subject: [PATCH] optee: Check return value of tee_shm_get_va()
Date: Thu,  5 Mar 2026 16:33:11 +0800
Message-Id: <20260305083312.1040969-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnieBOQKlp8MneCQ--.11139S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw1ruFy5Cr1UCrWxKryxuFg_yoWkAFc_Cr
	9xJ3ZrGr1vyw12qF98Kan3Zr92yF4DZF4vvws2vay3Ja17Xw1xXFyxZr17Xr4xG397JFyq
	krWUG345XFn8ujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUUcyCPUUUUU==
X-Originating-IP: [124.16.138.129]
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:159.226.251.0/25];
	ONCE_RECEIVED(0.20)[];
	RCVD_IN_DNSWL_MED(-0.20)[159.226.251.81:from];
	MIME_GOOD(-0.10)[text/plain];
	HAS_XOIP(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:7497, ipnet:159.226.0.0/16, country:CN];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_SPAM(0.00)[0.997]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 885F4430A2
X-Spamd-Bar: -
X-MailFrom: nichen@iscas.ac.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 4HUVPAGJJ6CEQDRLAA6MBFC3WLRAC3GX
X-Message-ID-Hash: 4HUVPAGJJ6CEQDRLAA6MBFC3WLRAC3GX
X-Mailman-Approved-At: Thu, 05 Mar 2026 14:36:54 +0000
CC: sumit.garg@kernel.org, ulf.hansson@linaro.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Chen Ni <nichen@iscas.ac.cn>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4HUVPAGJJ6CEQDRLAA6MBFC3WLRAC3GX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The function tee_shm_get_va() can return an error pointer if the shared
memory is not properly mapped or if the offset is invalid. Without this
check, passing the error pointer to subsequent memory operations could
lead to a kernel panic.

Add a check for IS_ERR() on the return value of tee_shm_get_va().

Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/tee/optee/rpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index b0ed4cb49452..32f7742c094c 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -393,6 +393,11 @@ static void handle_rpc_func_rpmb_frames(struct tee_context *ctx,
 			    params[0].u.memref.shm_offs);
 	p1 = tee_shm_get_va(params[1].u.memref.shm,
 			    params[1].u.memref.shm_offs);
+	if (IS_ERR(p0) || IS_ERR(p1)) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		goto out;
+	}
+
 	if (rpmb_route_frames(rdev, p0, params[0].u.memref.size, p1,
 			      params[1].u.memref.size)) {
 		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
-- 
2.25.1

