Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D856C7EE30
	for <op-tee@archiver.kernel.org>; Wed, 25 Jun 2025 09:46:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D522A4095C
	for <op-tee@archiver.kernel.org>; Wed, 25 Jun 2025 09:46:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=MUtoyXLV;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3725145A1F
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Jun 2025 09:42:46 +0000 (UTC)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9Km6S003331;
	Wed, 25 Jun 2025 11:42:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ojmhJAy4kOZ99ywAmMVFOdSAyDd/xKvGbLo9PtJ+AI0=; b=MUtoyXLVTty64s82
	6Z802vYSt/VhKKhT0dyRmpdc7G+/x6ELrqzQoMclRL+iHHJrrFAhBroDqyMGbgW4
	jGJrFYMD2CdUgbNFoCvWtEjf2Tct9/pvRDm58GGdrYizYn7TdyqpDyJ9n6PSN9xx
	3S2JerluaMB2arnVk29q4TSyYKsgtkhDT+6lxw0hnfd9GwQ8Oc2av11HkzfH8qCn
	L76sjPKVRM1p5Uq4iIFKwStOpnuhtn89ktUTuIbAColKeNPaT4WDl9zr3lQnOYr4
	S+ZAU4XW8laizrar6NbpEqBJqkbA9AtZbTAuXzB7Ns1lYpZymiTiYREph/Xr0nrk
	N5Mgdw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47dkmjrswd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 11:42:38 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CEA814004B;
	Wed, 25 Jun 2025 11:41:30 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B07294838C9;
	Wed, 25 Jun 2025 11:40:43 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 11:40:43 +0200
Received: from localhost (10.48.86.121) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 11:40:43 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Subject: [PATCH v19 3/6] remoteproc: Introduce optional release_fw operation
Date: Wed, 25 Jun 2025 11:40:25 +0200
Message-ID: <20250625094028.758016-4-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.121]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3725145A1F
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93:c];
	RCVD_IN_DNSWL_LOW(-0.10)[91.207.212.93:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:52129, ipnet:91.207.212.0/23, country:US];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=82719a3f78=arnaud.pouliquen@foss.st.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	HAS_XOIP(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FORGED_SENDER_VERP_SRS(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[91.207.212.93:from]
Message-ID-Hash: FQL23H3GVMGM3BESGTV54TRLXUKTMXQM
X-Message-ID-Hash: FQL23H3GVMGM3BESGTV54TRLXUKTMXQM
X-MailFrom: prvs=82719a3f78=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FQL23H3GVMGM3BESGTV54TRLXUKTMXQM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The release_fw operation allows releasing remote processor resources
configured during rproc_parse_fw() and rproc_load_segments().
For example, it can release carveouts mapped during these operations.

This operation is invoked in the following cases:
 - When an error occurs during remote processor boot.
 - When an error occurs during remote processor recovery start.
 - After stopping the remote processor.

This operation is required for the remoteproc_tee implementation following
a stop or upon encountering an error. Since the remoteproc image is loaded
during resource table parsing, multiple failure scenarios may occur prior
to remote processor startup, including issues with resource handling and
carveout allocation.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

---

Updates from version 18:
- Rewrite rproc_ops::release_fw documentation
- Improve commit message

Updates from version 16:
- Removed the rproc:load_fw() ops introduced in previous version.
- Removed duplicate calls to rproc_release_fw in rproc_fw_boot and rproc_boot.
---
 drivers/remoteproc/remoteproc_core.c     | 6 ++++++
 drivers/remoteproc/remoteproc_internal.h | 6 ++++++
 include/linux/remoteproc.h               | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index d06eef1fa424..4c1a4bc9e7b7 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1857,6 +1857,8 @@ static int rproc_boot_recovery(struct rproc *rproc)
 
 	/* boot the remote processor up again */
 	ret = rproc_start(rproc, firmware_p);
+	if (ret)
+		rproc_release_fw(rproc);
 
 	release_firmware(firmware_p);
 
@@ -1998,6 +2000,8 @@ int rproc_boot(struct rproc *rproc)
 		}
 
 		ret = rproc_fw_boot(rproc, firmware_p);
+		if (ret)
+			rproc_release_fw(rproc);
 
 		release_firmware(firmware_p);
 	}
@@ -2067,6 +2071,8 @@ int rproc_shutdown(struct rproc *rproc)
 
 	rproc_disable_iommu(rproc);
 
+	rproc_release_fw(rproc);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 0cd09e67ac14..c7fb908f8652 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -221,4 +221,10 @@ bool rproc_u64_fit_in_size_t(u64 val)
 	return (val <= (size_t) -1);
 }
 
+static inline void rproc_release_fw(struct rproc *rproc)
+{
+	if (rproc->ops->release_fw)
+		rproc->ops->release_fw(rproc);
+}
+
 #endif /* REMOTEPROC_INTERNAL_H */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 8fd0d7f63c8e..a2bb51a113b1 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -381,6 +381,10 @@ enum rsc_handling_status {
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
  * @coredump:	  collect firmware dump after the subsystem is shutdown
+ * @release_fw:	Optional function to release resources allocated during
+ *		parse_fw() or load() operations. This function is called after
+ *		stopping the remote processor or in case of an error during the
+ *		boot or recovery sequence.
  */
 struct rproc_ops {
 	int (*prepare)(struct rproc *rproc);
@@ -403,6 +407,7 @@ struct rproc_ops {
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
 	unsigned long (*panic)(struct rproc *rproc);
 	void (*coredump)(struct rproc *rproc);
+	void (*release_fw)(struct rproc *rproc);
 };
 
 /**
-- 
2.25.1

