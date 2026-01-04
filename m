Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB0C2A072
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 08:10:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B317642FF1
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 08:10:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=aSXcUmvK;
	dkim-atps=neutral
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6C6FA43163
	for <op-tee@lists.trustedfirmware.org>; Sun,  4 Jan 2026 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S+B+I9C6Axbl6RJbwl9HfDr99/TjNLbhwTMGhfk0tSE=;
  b=aSXcUmvKpmAgJzzYO0G84CGy1kGq6+iBHF5uUpgEVYNUjNlL3rHVJq/r
   El/D+BCC/5ABtsscUNJfHt0f4SEqH4wbtmihaupqvVfUzrSl/cXRWqA8B
   KGtUXCRxaJQX49PjjZ3Nei4cxbmbJ/A/ofFvTXi1lo6ua7fJCHWMaR+5H
   k=;
X-CSE-ConnectionGUID: LsDqransQEuUmr1JGII/Ow==
X-CSE-MsgGUID: q390n3o1Qla3qonug8Xvkw==
X-IronPort-AV: E=Sophos;i="6.21,201,1763420400";
   d="scan'208";a="135015474"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.102.196])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2026 18:01:25 +0100
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH] optee: update outdated comment
Date: Sun,  4 Jan 2026 18:01:19 +0100
Message-Id: <20260104170119.291968-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[inria.fr:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[inria.fr,none];
	R_MISSING_CHARSET(0.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[inria.fr:s=dc];
	R_SPF_ALLOW(-0.20)[+ip4:192.134.164.0/24];
	RCVD_IN_DNSWL_MED(-0.20)[192.134.164.104:from];
	RWL_MAILSPIKE_GOOD(-0.10)[192.134.164.104:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:2200, ipnet:192.134.164.0/24, country:FR];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[inria.fr:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6C6FA43163
X-Spamd-Bar: -----
X-MailFrom: Julia.Lawall@inria.fr
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: RMC242AYZNSPU5N2W7NGTUXVYNNQDZJF
X-Message-ID-Hash: RMC242AYZNSPU5N2W7NGTUXVYNNQDZJF
X-Mailman-Approved-At: Mon, 05 Jan 2026 08:09:46 +0000
CC: kernel-janitors@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RMC242AYZNSPU5N2W7NGTUXVYNNQDZJF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The function cmd_alloc_suppl() was renamed as
optee_rpc_cmd_alloc_suppl() in commit c51a564a5b48
("optee: isolate smc abi").  Update the comment
accordingly.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/tee/optee/rpc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index ebbbd42b0e3e..97fc5b14db0c 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -247,8 +247,8 @@ void optee_rpc_cmd_free_suppl(struct tee_context *ctx, struct tee_shm *shm)
 	param.u.value.c = 0;
 
 	/*
-	 * Match the tee_shm_get_from_id() in cmd_alloc_suppl() as secure
-	 * world has released its reference.
+	 * Match the tee_shm_get_from_id() in optee_rpc_cmd_alloc_suppl()
+	 * as secure world has released its reference.
 	 *
 	 * It's better to do this before sending the request to supplicant
 	 * as we'd like to let the process doing the initial allocation to

