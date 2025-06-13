Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0C7C71135
	for <op-tee@archiver.kernel.org>; Fri, 13 Jun 2025 09:20:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E010643135
	for <op-tee@archiver.kernel.org>; Fri, 13 Jun 2025 09:20:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=xmCVzlKQ;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 82C413F791
	for <op-tee@lists.trustedfirmware.org>; Fri, 13 Jun 2025 09:19:37 +0000 (UTC)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D8wHNm020220;
	Fri, 13 Jun 2025 11:19:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Qukd4stYOCYEBe2KGcf2tpYpRWJZmwskg2vfqUfUsKY=; b=xmCVzlKQCtuGgHtz
	pUXCmVGQ3ONSiquNM8AvJbe2b/bd2r1R7FQVmDfjwI6Ztf/N52gp85Y3iOSOAnYc
	t+4L78ug3jzrEG0441Cs8UX4zGFErHHGupHayHwXXjmacQCRLOzX0OYroE6ImLUv
	WOdeCRhWKnajWFJasN7CCOYOu4nLybchNgNt8DnWqPWWxspQ61ErvQ4/j8V/7Gcr
	c7eZEkL7meNLk1I7QE7nGYAsdhpig1zoHCZiJJDfWzdy516k/04MfKmGcIcMs+Nv
	bQgcwFa1QXBntuBa+UI484nKk78R/Kd+yCqish+Gu/u8sBLN4xWYnQXsVoLqCvK0
	uLj8lg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474ajakwn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 11:19:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 38AE340056;
	Fri, 13 Jun 2025 11:18:08 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7B050BAD4D4;
	Fri, 13 Jun 2025 11:17:19 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 11:17:19 +0200
Received: from localhost (10.48.86.121) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Jun
 2025 11:17:19 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Subject: [PATCH v17 1/6] remoteproc: core: Introduce rproc_pa_to_va helper
Date: Fri, 13 Jun 2025 11:16:45 +0200
Message-ID: <20250613091650.2337411-2-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613091650.2337411-1-arnaud.pouliquen@foss.st.com>
References: <20250613091650.2337411-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.121]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93];
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
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=82594f44e5=arnaud.pouliquen@foss.st.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[138.198.100.35:received];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_XOIP(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FORGED_SENDER_VERP_SRS(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 82C413F791
Message-ID-Hash: IT3OI245L7PKPEMXHDMSUTYTJELZB2O7
X-Message-ID-Hash: IT3OI245L7PKPEMXHDMSUTYTJELZB2O7
X-MailFrom: prvs=82594f44e5=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IT3OI245L7PKPEMXHDMSUTYTJELZB2O7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

When a resource table is loaded by an external entity such as U-boot or
OP-TEE, we do not necessarily get the device address(da) but the physical
address(pa).
This helper performs similar translation than the rproc_da_to_va()
but based on a physical address.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 46 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 81b2ccf988e8..d06eef1fa424 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -230,6 +230,52 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 }
 EXPORT_SYMBOL(rproc_da_to_va);
 
+/**
+ * rproc_pa_to_va() - lookup the kernel virtual address for a physical address of a remoteproc
+ * memory
+ *
+ * @rproc: handle of a remote processor
+ * @pa: remoteproc physical address
+ * @len: length of the memory region @pa is pointing to
+ * @is_iomem: optional pointer filled in to indicate if @da is iomapped memory
+ *
+ * This function is a helper function similar to rproc_da_to_va() but it deals with physical
+ * addresses instead of device addresses.
+ *
+ * Return: a valid kernel address on success or NULL on failure
+ */
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *is_iomem)
+{
+	struct rproc_mem_entry *carveout;
+	void *ptr = NULL;
+
+	list_for_each_entry(carveout, &rproc->carveouts, node) {
+		int offset = pa - carveout->dma;
+
+		/*  Verify that carveout is allocated */
+		if (!carveout->va)
+			continue;
+
+		/* try next carveout if da is too small */
+		if (offset < 0)
+			continue;
+
+		/* try next carveout if da is too large */
+		if (offset + len > carveout->len)
+			continue;
+
+		ptr = carveout->va + offset;
+
+		if (is_iomem)
+			*is_iomem = carveout->is_iomem;
+
+		break;
+	}
+
+	return ptr;
+}
+EXPORT_SYMBOL(rproc_pa_to_va);
+
 /**
  * rproc_find_carveout_by_name() - lookup the carveout region by a name
  * @rproc: handle of a remote processor
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..8fd0d7f63c8e 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -690,6 +690,7 @@ int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *is_iomem);
 
 /* from remoteproc_coredump.c */
 void rproc_coredump_cleanup(struct rproc *rproc);
-- 
2.25.1

