Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC7CD44C48
	for <op-tee@archiver.kernel.org>; Thu, 15 Jan 2026 14:23:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 36029434B3
	for <op-tee@archiver.kernel.org>; Thu, 15 Jan 2026 14:23:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3C08B4310F
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Jan 2026 14:22:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9494443F09;
	Thu, 15 Jan 2026 14:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE7DC116D0;
	Thu, 15 Jan 2026 14:22:48 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] MAINTAINERS: Mark the OP-TEE mailing list moderated
Date: Thu, 15 Jan 2026 15:22:42 +0100
Message-ID: <f9c34212cb33775754b3a1f4231f181574c99aad.1768486765.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	FORGED_SENDER(0.30)[geert@glider.be,srs0=libu=7u=glider.be=geert@kernel.org];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[glider.be];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,srs0=libu=7u=glider.be=geert@kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[renesas];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DNSWL_BLOCKED(0.00)[172.234.252.31:from];
	NEURAL_HAM(-0.00)[-0.998]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3C08B4310F
X-Spamd-Bar: /
Message-ID-Hash: UD37K2L7RJKB7ZJAZXXSN577FYCGKSXR
X-Message-ID-Hash: UD37K2L7RJKB7ZJAZXXSN577FYCGKSXR
X-MailFrom: SRS0=LiBU=7U=glider.be=geert+renesas@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UD37K2L7RJKB7ZJAZXXSN577FYCGKSXR/>
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
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
---
v2:
  - Add Reviewed-by.
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 13e2f2fdc248ec65..9c988eb1cc86628f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19578,14 +19578,14 @@ F:	drivers/net/phy/ncn*
 
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
 
@@ -25693,7 +25693,7 @@ F:	include/media/i2c/tw9910.h
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

