Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8361DCAC5BB
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:04:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BB641431E2
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:04:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 82C034184D
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Sep 2025 14:44:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A2ADF44755;
	Tue, 30 Sep 2025 14:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A10C4CEF0;
	Tue, 30 Sep 2025 14:44:30 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH] tee: QCOMTEE should depend on ARCH_QCOM
Date: Tue, 30 Sep 2025 16:44:27 +0200
Message-ID: <d0b14c3d51245f9eda2341504c05bd0f5b0828b7.1759243439.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 82C034184D
X-Spamd-Bar: /
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	FORGED_SENDER(0.30)[geert@glider.be,SRS0=e7mc=4J=glider.be=geert@kernel.org];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.861];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,SRS0=e7mc=4J=glider.be=geert@kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[renesas];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[glider.be];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: SRS0=e7mc=4J=glider.be=geert+renesas@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: ERTCPV46CX653BRJFPHF2TDPICGA3TK7
X-Message-ID-Hash: ERTCPV46CX653BRJFPHF2TDPICGA3TK7
X-Mailman-Approved-At: Wed, 01 Oct 2025 08:04:05 +0000
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ERTCPV46CX653BRJFPHF2TDPICGA3TK7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The Qualcomm Trusted Execution Environment (QTEE) is only available on
Qualcomm SoCs.  Hence add a dependency on ARCH_QCOM, to prevent asking
the user about this driver when configuring a kernel without Qualcomm
platform support.

Fixes: d6e290837e50f73f ("tee: add Qualcomm TEE driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tee/qcomtee/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/qcomtee/Kconfig b/drivers/tee/qcomtee/Kconfig
index 927686abceb1536e..9f19dee08db491c3 100644
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
2.43.0

