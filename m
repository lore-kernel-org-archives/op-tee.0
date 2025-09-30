Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BA4CAC5BB
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:04:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 52E13431E2
	for <op-tee@archiver.kernel.org>; Wed,  1 Oct 2025 08:04:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6BB124184D
	for <op-tee@lists.trustedfirmware.org>; Tue, 30 Sep 2025 14:55:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B20CA444E7;
	Tue, 30 Sep 2025 14:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C47C113D0;
	Tue, 30 Sep 2025 14:55:04 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH] MAINTAINERS: Mark the OP-TEE mailing list moderated
Date: Tue, 30 Sep 2025 16:55:01 +0200
Message-ID: <cc9862625abc5b923c5e7c5de20c6f7c797771d6.1759243993.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6BB124184D
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	FORGED_SENDER(0.30)[geert@glider.be,SRS0=e7mc=4J=glider.be=geert@kernel.org];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,SRS0=e7mc=4J=glider.be=geert@kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
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
Message-ID-Hash: EEJPQ4YELZ7AOIPFMHCTTNK4EANB4BW2
X-Message-ID-Hash: EEJPQ4YELZ7AOIPFMHCTTNK4EANB4BW2
X-Mailman-Approved-At: Wed, 01 Oct 2025 08:04:05 +0000
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EEJPQ4YELZ7AOIPFMHCTTNK4EANB4BW2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

After sending a patch to op-tee@lists.trustedfirmware.org, I got the
typical response for a moderated list:

    Your mail to 'op-tee@lists.trustedfirmware.org' with the subject

	[...]

    Is being held until the list moderator can review it for approval.

    The message is being held because:

	The message is not from a list member

    Either the message will get posted to the list, or you will receive
    notification of the moderator's decision.

Mark this mailing list moderated in MAINTAINERS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc755a50fb150498..5aa2e501231f2aa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19115,14 +19115,14 @@ F:	drivers/net/phy/ncn*
 
 OP-TEE DRIVER
 M:	Jens Wiklander <jens.wiklander@linaro.org>
-L:	op-tee@lists.trustedfirmware.org
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-optee-devices
 F:	drivers/tee/optee/
 
 OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
 M:	Sumit Garg <sumit.garg@kernel.org>
-L:	op-tee@lists.trustedfirmware.org
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/char/hw_random/optee-rng.c
 
@@ -25116,7 +25116,7 @@ F:	include/media/i2c/tw9910.h
 TEE SUBSYSTEM
 M:	Jens Wiklander <jens.wiklander@linaro.org>
 R:	Sumit Garg <sumit.garg@kernel.org>
-L:	op-tee@lists.trustedfirmware.org
+L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-class-tee
 F:	Documentation/driver-api/tee.rst
-- 
2.43.0

