Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725DAC87FCB
	for <op-tee@archiver.kernel.org>; Fri,  1 Aug 2025 23:56:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 891D143EA6
	for <op-tee@archiver.kernel.org>; Fri,  1 Aug 2025 23:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754092587;
	bh=dbaFLzCG/5EkHTeHj907dORnHsrShX2dlh1BlaIdXok=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=znFx0I4+VYBzx1ltAH2lvsRKXPfiHDGryEJ3cB17CfF9KCOx6Wy4TCPykwyH2DJLN
	 c4AYtkBeiMXywkUKeYdiDZtmGe9bidtn899SWXFrN+yOzXE7e9BQwDZiYzlYsU/9yL
	 Exs9Crrn2YHWJNnpOJIMLgA4X/OS9H7P8LB04WxUkn2CD1NgT5CSZaAmFvtor7ddTo
	 esWEWe7bSj+rB/fRK5D1TqEvJuctYlFtL3isRvh+jUnaoe2QFtNtUmC93Q810Rdi5/
	 kxrSN/lnt9y7ujagX4nEwfDOaNOqQaPt5SbQo/bHCYFPvim17s7ZE2Djl/WSor4UDd
	 z9Or80ah7fFRQ==
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 09054430E3
	for <op-tee@lists.trustedfirmware.org>; Fri,  1 Aug 2025 23:56:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p8a1t5NY;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 33EE85C4D0A;
	Fri,  1 Aug 2025 23:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4A3C4CEE7;
	Fri,  1 Aug 2025 23:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754092566;
	bh=dbaFLzCG/5EkHTeHj907dORnHsrShX2dlh1BlaIdXok=;
	h=From:To:Cc:Subject:Date:From;
	b=p8a1t5NYG6c2K+OI6nAVg88FYPTy/1li6BCKUEzy4rRRTpg8B/6Y3zLka/U7RjFgy
	 PKKbeziwCQJh3gPrHoWMyrlM/WixH/isi29k61/aNlTAuS+zMdqawoZhNaacTq4FsH
	 NqKEF81yw2JuzXpKrB3R6Pu1MVawZmdyYyRMpTP7TEDeCp9n77VwvyWi2Tvzsk+xXT
	 LLfYahxLDKgyGxeV3uPf9NrBt7sscnMCw9wZeWboYTaNA622HT+d5qc5Rr7p46AtVh
	 Emvs0Ir8MuMTUPxCuIgCmsBwfCasaCsiPbzIzKbyslliw7+6Abto6e6tEp0F0Rbmx1
	 DwCTYmtLjSOKQ==
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: Use SHA-1 library instead of crypto_shash
Date: Fri,  1 Aug 2025 16:55:41 -0700
Message-ID: <20250801235541.14050-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09054430E3
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	RCVD_IN_DNSWL_HI(-0.50)[139.178.84.217:from];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:139.178.84.217];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15830, ipnet:139.178.80.0/21, country:NL];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	DNSWL_BLOCKED(0.00)[100.75.92.58:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: P4JOWGV6F5OF2FE6JZEW44MN2V3NOH24
X-Message-ID-Hash: P4JOWGV6F5OF2FE6JZEW44MN2V3NOH24
X-MailFrom: ebiggers@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/P4JOWGV6F5OF2FE6JZEW44MN2V3NOH24/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Eric Biggers via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Eric Biggers <ebiggers@kernel.org>

Use the SHA-1 library functions instead of crypto_shash.  This is
simpler and faster.

Change uuid_v5() to return void, since it can no longer fail.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

Note: this patch depends on the SHA-1 library functions that were merged
in v6.17-rc1.

 drivers/tee/Kconfig    |  3 +--
 drivers/tee/tee_core.c | 55 +++++++-----------------------------------
 2 files changed, 10 insertions(+), 48 deletions(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 61b507c187801..a84767940fbfc 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -1,12 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Generic Trusted Execution Environment Configuration
 menuconfig TEE
 	tristate "Trusted Execution Environment support"
 	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
-	select CRYPTO
-	select CRYPTO_SHA1
+	select CRYPTO_LIB_SHA1
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
 	help
 	  This implements a generic interface towards a Trusted Execution
 	  Environment (TEE).
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index acc7998758ad8..d079aeee0690a 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -12,11 +12,10 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/tee_core.h>
 #include <linux/uaccess.h>
-#include <crypto/hash.h>
 #include <crypto/sha1.h>
 #include "tee_private.h"
 
 #define TEE_NUM_DEVICES	32
 
@@ -140,72 +139,36 @@ static int tee_release(struct inode *inode, struct file *filp)
  * UUIDv5 is specific in RFC 4122.
  *
  * This implements section (for SHA-1):
  * 4.3.  Algorithm for Creating a Name-Based UUID
  */
-static int uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
-		   size_t size)
+static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+		    size_t size)
 {
 	unsigned char hash[SHA1_DIGEST_SIZE];
-	struct crypto_shash *shash = NULL;
-	struct shash_desc *desc = NULL;
-	int rc;
-
-	shash = crypto_alloc_shash("sha1", 0, 0);
-	if (IS_ERR(shash)) {
-		rc = PTR_ERR(shash);
-		pr_err("shash(sha1) allocation failed\n");
-		return rc;
-	}
-
-	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
-		       GFP_KERNEL);
-	if (!desc) {
-		rc = -ENOMEM;
-		goto out_free_shash;
-	}
-
-	desc->tfm = shash;
+	struct sha1_ctx ctx;
 
-	rc = crypto_shash_init(desc);
-	if (rc < 0)
-		goto out_free_desc;
-
-	rc = crypto_shash_update(desc, (const u8 *)ns, sizeof(*ns));
-	if (rc < 0)
-		goto out_free_desc;
-
-	rc = crypto_shash_update(desc, (const u8 *)name, size);
-	if (rc < 0)
-		goto out_free_desc;
-
-	rc = crypto_shash_final(desc, hash);
-	if (rc < 0)
-		goto out_free_desc;
+	sha1_init(&ctx);
+	sha1_update(&ctx, (const u8 *)ns, sizeof(*ns));
+	sha1_update(&ctx, (const u8 *)name, size);
+	sha1_final(&ctx, hash);
 
 	memcpy(uuid->b, hash, UUID_SIZE);
 
 	/* Tag for version 5 */
 	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
 	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
-
-out_free_desc:
-	kfree(desc);
-
-out_free_shash:
-	crypto_free_shash(shash);
-	return rc;
 }
 
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
 {
 	gid_t ns_grp = (gid_t)-1;
 	kgid_t grp = INVALID_GID;
 	char *name = NULL;
 	int name_len;
-	int rc;
+	int rc = 0;
 
 	if (connection_method == TEE_IOCTL_LOGIN_PUBLIC ||
 	    connection_method == TEE_IOCTL_LOGIN_REE_KERNEL) {
 		/* Nil UUID to be passed to TEE environment */
 		uuid_copy(uuid, &uuid_null);
@@ -258,11 +221,11 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 	default:
 		rc = -EINVAL;
 		goto out_free_name;
 	}
 
-	rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
 out_free_name:
 	kfree(name);
 
 	return rc;
 }

base-commit: 0905809b38bda1fa0b206986c44d846e46f13c1d
-- 
2.50.1

