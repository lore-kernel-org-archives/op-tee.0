Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3FDC7115A
	for <op-tee@archiver.kernel.org>; Mon, 16 Jun 2025 08:00:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7F83240485
	for <op-tee@archiver.kernel.org>; Mon, 16 Jun 2025 08:00:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=0c9dIwqu;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 929EC43075
	for <op-tee@lists.trustedfirmware.org>; Mon, 16 Jun 2025 07:58:34 +0000 (UTC)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G7CeYR023399;
	Mon, 16 Jun 2025 09:58:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	+i+lHnX/EVN6vrUR/l0h3RKfh8qCpnxHX7P/NPNW0MI=; b=0c9dIwquGTCJzkh5
	kaVkI/G/WS1MF/3J+l+qvKcMlBgasLXNergy+PuWRE6Dpj+raFdyGym3csrLhVQG
	aAAUQb2HlED9J56P2wQKBqErZUI3kFQHvCvg3zELbgMBU+3zYzdod39CGprdW04W
	2ZMGwEaDcPND/CZbfCWOus9Je76h3hIiMVc2dJ38Ru0iTSzapS6Nm2IuqFUHZ2qc
	EZsEJDJ8BMxGh6lNyxxP1DQB5l+KmxUvm3UIVWMvW5xfi9VF6UlnmI/baZhGFrpD
	eZkOYK9IkddYsPz6NU5QhHIZgb+7NkpeevHXdZL4bqnG1ZCR/xbs9lTiLjuBpXGg
	VQ+Erg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 479jn4m31j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 09:58:24 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 863D34005A;
	Mon, 16 Jun 2025 09:57:12 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 391264CB032;
	Mon, 16 Jun 2025 09:56:21 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 09:56:21 +0200
Received: from localhost (10.48.86.121) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 09:56:20 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Subject: [PATCH v18 2/6] remoteproc: Add TEE support
Date: Mon, 16 Jun 2025 09:55:26 +0200
Message-ID: <20250616075530.4106090-3-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250616075530.4106090-1-arnaud.pouliquen@foss.st.com>
References: <20250616075530.4106090-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.121]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_03,2025-06-13_01,2025-03-28_01
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 929EC43075
X-Spamd-Bar: -
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:185.132.182.106:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[185.132.182.106:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:52129, ipnet:185.132.182.0/24, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=8262f63a79=arnaud.pouliquen@foss.st.com];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_VERP_SRS(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
Message-ID-Hash: OEZGQJYT6TXLP7GFDWZL4KRM6NJRIFRP
X-Message-ID-Hash: OEZGQJYT6TXLP7GFDWZL4KRM6NJRIFRP
X-MailFrom: prvs=8262f63a79=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OEZGQJYT6TXLP7GFDWZL4KRM6NJRIFRP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a remoteproc TEE (Trusted Execution Environment) driver that will be
probed by the TEE bus. If the associated Trusted application is supported
on the secure part, this driver offers a client interface to load firmware
by the secure part.
This firmware could be authenticated by the secure trusted application.

A specificity of the implementation is that the firmware has to be
authenticated and optionally decrypted to access the resource table.

Consequently, the boot sequence is:

1) rproc_parse_fw --> rproc_tee_parse_fw
   remoteproc TEE:
   - Requests the TEE application to authenticate and load the firmware
     in the remote processor memories.
   - Requests the TEE application for the address of the resource table.
   - Creates a copy of the resource table stored in rproc->cached_table.

2) rproc_load_segments --> rproc_tee_load_fw
   remoteproc TEE:
   - Requests the TEE application to load the firmware. Nothing is done
     at the TEE application as the firmware is already loaded.
   - In case of recovery, the TEE application has to reload the firmware.

3) rproc_tee_get_loaded_rsc_table
   remoteproc TEE requests the TEE application for the address of the
   resource table.

4) rproc_start --> rproc_tee_start
   - Requests the TEE application to start the remote processor.

The shutdown sequence is:

5) rproc_stop --> rproc_tee_stop
   - Requests the TEE application to stop the remote processor.

6) rproc_tee_release_fw
   This function is used to request the TEE application to perform actions
   to return to the initial state on stop or on error during the boot
   sequence.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Updates vs previous version:
Fix warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
---
 drivers/remoteproc/Kconfig          |  10 +
 drivers/remoteproc/Makefile         |   1 +
 drivers/remoteproc/remoteproc_tee.c | 620 ++++++++++++++++++++++++++++
 include/linux/remoteproc_tee.h      |  90 ++++
 4 files changed, 721 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 83962a114dc9..e39265d249d9 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -23,6 +23,16 @@ config REMOTEPROC_CDEV
 
 	  It's safe to say N if you don't want to use this interface.
 
+config REMOTEPROC_TEE
+	bool "Remoteproc support by a TEE application"
+	depends on OPTEE
+	help
+	  Support a remote processor that is managed by an application running in a Trusted
+	  Execution Environment (TEE). This application is responsible for loading the remote
+	  processor firmware image and managing its lifecycle.
+
+	  It's safe to say N if the remote processor is not managed by a TEE.
+
 config IMX_REMOTEPROC
 	tristate "i.MX remoteproc support"
 	depends on ARCH_MXC
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 1c7598b8475d..a1a5201982d4 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -11,6 +11,7 @@ remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
+obj-$(CONFIG_REMOTEPROC_TEE)		+= remoteproc_tee.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
 obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
 obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
diff --git a/drivers/remoteproc/remoteproc_tee.c b/drivers/remoteproc/remoteproc_tee.c
new file mode 100644
index 000000000000..6b610dfa1ee1
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_tee.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) STMicroelectronics 2024
+ * Author: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
+ */
+
+#include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/remoteproc_tee.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+
+#define MAX_TEE_PARAM_ARRAY_MEMBER	4
+
+/*
+ * Authentication and load of the firmware image in the remote processor memories by the TEE.
+ * After this step the firmware is loaded in destination memories, which can then be locked to
+ * prevent access by Linux.
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ * [in]	 params[1].memref:	buffer containing a temporary copy of the signed image to load.
+ */
+#define TA_RPROC_FW_CMD_LOAD_FW		1
+
+/*
+ * Start the remote processor by the TEE
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ */
+#define TA_RPROC_FW_CMD_START		2
+
+/*
+ * Stop the remote processor by the TEE
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ */
+#define TA_RPROC_FW_CMD_STOP		3
+
+/*
+ * Return the address of the resource table, or 0 if not found.
+ *
+ * [in]  params[0].value.a:	remote processor identifier
+ * [out]  params[1].value.a:	32bit LSB resource table memory address
+ * [out]  params[1].value.b:	32bit MSB resource table memory address
+ * [out]  params[2].value.a:	32bit LSB resource table memory size
+ * [out]  params[2].value.b:	32bit MSB resource table memory size
+ */
+#define TA_RPROC_FW_CMD_GET_RSC_TABLE	4
+
+/*
+ * Release remote processor firmware images and associated resources.
+ * This command should be used in case an error occurs between the loading of
+ * the firmware images (TA_RPROC_CMD_LOAD_FW) and the starting of the remote
+ * processor (TA_RPROC_CMD_START_FW) or after stopping the remote processor
+ * to release associated resources (TA_RPROC_CMD_STOP_FW).
+ *
+ * [in]  params[0].value.a: Unique 32-bit remote processor identifier
+ */
+#define TA_RPROC_CMD_RELEASE_FW		6
+
+struct rproc_tee_context {
+	struct list_head	sessions;
+	struct tee_context	*tee_ctx;
+	struct device		*dev;
+};
+
+/**
+ * struct rproc_tee - TEE remoteproc structure
+ * @node:		Reference in list
+ * @rproc:		Remoteproc reference
+ * @rproc_id:		Identifier of the target firmware
+ * @session_id:		TEE session identifier
+ */
+struct rproc_tee {
+	struct list_head node;
+	struct rproc *rproc;
+	u32 rproc_id;
+	u32 session_id;
+};
+
+static struct rproc_tee_context rproc_tee_ctx;
+static DEFINE_SPINLOCK(ctx_lock);
+
+static struct rproc_tee *rproc_to_trproc(struct rproc *rproc)
+{
+	struct rproc_tee *trproc;
+
+	list_for_each_entry(trproc, &rproc_tee_ctx.sessions, node)
+		if (trproc->rproc == rproc)
+			return trproc;
+
+	return NULL;
+}
+
+static void rproc_tee_prepare_args(struct rproc_tee *trproc, int cmd,
+				   struct tee_ioctl_invoke_arg *arg,
+				   struct tee_param *param,
+				   unsigned int num_params)
+{
+	memset(arg, 0, sizeof(*arg));
+	memset(param, 0, MAX_TEE_PARAM_ARRAY_MEMBER * sizeof(*param));
+
+	arg->func = cmd;
+	arg->session = trproc->session_id;
+	arg->num_params = num_params + 1;
+
+	param[0] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = trproc->rproc_id,
+	};
+}
+
+/**
+ * rproc_tee_release_fw - Release the firmware for a TEE-based remote processor
+ *
+ * This function invokes the TA_RPROC_CMD_RELEASE_FW TEE client function to release the firmware.
+ * It should only be called when the remoteproc state is RPROC_OFFLINE or RPROC_DETACHED.
+ * The function requests the TEE remoteproc application to release the firmware loaded by
+ * rproc_tee_load_fw(). The request is ignored if the rproc state is RPROC_DETACHED as the
+ * remote processor is still running.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ */
+void rproc_tee_release_fw(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc = rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	if (!rproc_tee_ctx.dev)
+		return;
+
+	if (!trproc)
+		return;
+
+	/*
+	 * If the remote processor state is RPROC_DETACHED, just ignore the
+	 * request, as the remote processor is still running.
+	 */
+	if (rproc->state == RPROC_DETACHED)
+		return;
+
+	if (rproc->state != RPROC_OFFLINE) {
+		dev_err(rproc_tee_ctx.dev, "unexpected rproc state: %d\n", rproc->state);
+		return;
+	}
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_RELEASE_FW, &arg, param, 0);
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_CMD_RELEASE_FW invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		ret = -EIO;
+	}
+}
+EXPORT_SYMBOL_GPL(rproc_tee_release_fw);
+
+/**
+ * rproc_tee_load_fw - Load firmware from TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * This function invokes the TA_RPROC_FW_CMD_LOAD_FW TEE client function to load the firmware.
+ * It registers the fw->data as a shared memory region with the TEE, and request the TEE to load
+ * the firmware. This function can be called twice during the remote processor boot, considering
+ * that the TEE application ignores the command if the firmware is already loaded.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * Return: 0 on success, or an error code on failure
+ */
+int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc = rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_shm *fw_shm;
+	int ret;
+
+	if (!rproc_tee_ctx.dev)
+		return -ENODEV;
+
+	if (!trproc)
+		return -EINVAL;
+
+	fw_shm = tee_shm_register_kernel_buf(rproc_tee_ctx.tee_ctx, (void *)fw->data, fw->size);
+	if (IS_ERR(fw_shm))
+		return PTR_ERR(fw_shm);
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_LOAD_FW, &arg, param, 1);
+
+	/* Provide the address of the firmware image */
+	param[1] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
+		.u.memref = {
+			.shm = fw_shm,
+			.size = fw->size,
+			.shm_offs = 0,
+		},
+	};
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_LOAD_FW invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+
+	tee_shm_free(fw_shm);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_load_fw);
+
+static int rproc_tee_get_loaded_rsc_table(struct rproc *rproc, phys_addr_t *rsc_pa,
+					  size_t *table_sz)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc = rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	if (!rproc_tee_ctx.dev)
+		return -ENODEV;
+
+	if (!trproc)
+		return -EINVAL;
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_GET_RSC_TABLE, &arg, param, 2);
+
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_GET_RSC_TABLE invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		return -EIO;
+	}
+
+	*table_sz = param[2].u.value.a;
+
+	if (*table_sz)
+		*rsc_pa = param[1].u.value.a;
+	else
+		*rsc_pa  = 0;
+
+	return 0;
+}
+
+/**
+ * rproc_tee_parse_fw - Get the resource table from TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * This function retrieves the loaded resource table and creates a cached_table copy. Since the
+ * firmware image is signed and potentially encrypted, the firmware must be loaded first to
+ * access the loaded resource table.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * Return: 0 on success, or an error code on failure
+ */
+int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	phys_addr_t rsc_table;
+	void __iomem *rsc_va;
+	size_t table_sz;
+	int ret;
+
+	if (!rproc)
+		return -EINVAL;
+
+	/* We need first to Load the firmware, to be able to get the resource table. */
+	ret = rproc_tee_load_fw(rproc, fw);
+	if (ret)
+		return ret;
+
+	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
+	if (ret)
+		goto release_fw;
+
+	/*
+	 * We assume here that the memory mapping is the same between the TEE and Linux kernel
+	 * contexts. Else a new TEE remoteproc service could be needed to get a copy of the
+	 * resource table
+	 */
+	rsc_va = ioremap_wc(rsc_table, table_sz);
+	if (!rsc_va) {
+		dev_err(rproc_tee_ctx.dev, "Unable to map memory region: %pa+%zx\n",
+			&rsc_table, table_sz);
+		ret = -ENOMEM;
+		goto release_fw;
+	}
+
+	/*
+	 * Create a copy of the resource table to have the same behavior as the ELF loader.
+	 * This cached table will be used by the remoteproc core after the remoteproc stops
+	 * to free resources and for crash recovery to reapply the settings.
+	 * The cached table will be freed by the remoteproc core.
+	 */
+	rproc->cached_table = kmemdup((__force void *)rsc_va, table_sz, GFP_KERNEL);
+	iounmap(rsc_va);
+
+	if (!rproc->cached_table) {
+		ret = -ENOMEM;
+		goto release_fw;
+	}
+
+	rproc->table_ptr = rproc->cached_table;
+	rproc->table_sz = table_sz;
+
+	return 0;
+
+release_fw:
+	rproc_tee_release_fw(rproc);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_parse_fw);
+
+/**
+ * rproc_tee_find_loaded_rsc_table - Find the loaded resource table loaded by the TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * This function retrieves the physical address and size of the resource table loaded by the TEE
+ * application.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * Return:  pointer to the resource table if found, or NULL if not found or size is 0
+ */
+struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
+						       const struct firmware *fw)
+{
+	phys_addr_t rsc_table;
+	size_t table_sz;
+	int ret;
+
+	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
+	if (ret)
+		return NULL;
+
+	rproc->table_sz = table_sz;
+	if (!table_sz)
+		return NULL;
+
+	/*
+	 * At this step the memory area that contains the resource table should have been registered
+	 * by the remote proc platform driver and allocated by rproc_alloc_registered_carveouts().
+	 */
+	return (struct resource_table *)rproc_pa_to_va(rproc, rsc_table, table_sz, NULL);
+}
+EXPORT_SYMBOL_GPL(rproc_tee_find_loaded_rsc_table);
+
+/**
+ * rproc_tee_start - Request the TEE application to start the remote processor
+ *
+ * This function invokes the TA_RPROC_FW_CMD_START command to start the remote processor.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * Return: Returns 0 on success, -EINVAL or -EIO on failure
+ */
+int rproc_tee_start(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc = rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret = 0;
+
+	if (!trproc)
+		return -EINVAL;
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_START, &arg, param, 0);
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_START invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
+		if (!ret)
+			return  -EIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_start);
+
+/**
+ * rproc_tee_stop - Request the TEE application to start the remote processor
+ *
+ * This function invokes the TA_RPROC_FW_CMD_STOP command to stop the remote processor.
+ *
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * Return: Returns 0 on success, -EINVAL or -EIO on failure
+ */
+int rproc_tee_stop(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc = rproc_to_trproc(rproc);
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	if (!trproc)
+		return -EINVAL;
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_FW_CMD_STOP, &arg, param, 0);
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_FW_CMD_STOP invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_stop);
+
+static const struct tee_client_device_id rproc_tee_id_table[] = {
+	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905, 0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
+	{}
+};
+
+/**
+ * rproc_tee_register - Register a remote processor controlled by a TEE application.
+ *
+ * This function registers a remote processor that will be managed by a TEE application,by opening
+ * a session with the TEE client.
+ *
+ * @dev: Pointer to client rproc device
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @rproc_id: ID of the remote processor
+ *
+ * Return: Returns 0 on success, or an error code on failure
+ */
+int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int rproc_id)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct tee_client_device *tee_device;
+	struct rproc_tee *trproc;
+	struct device_link *link;
+	int ret;
+
+	spin_lock(&ctx_lock);
+	/*
+	 * Test if the device has been probed by the TEE bus. In case of failure, we ignore the
+	 * reason. The bus could be not yet probed or the service not available in the secure
+	 * firmware.The assumption in such a case is that the TEE remoteproc is not probed.
+	 */
+	if (!rproc_tee_ctx.dev) {
+		ret = -EPROBE_DEFER;
+		goto out;
+	}
+
+	trproc = kzalloc(sizeof(*trproc), GFP_KERNEL);
+	if (!trproc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tee_device = to_tee_client_device(rproc_tee_ctx.dev);
+	memset(&sess_arg, 0, sizeof(sess_arg));
+
+	memcpy(sess_arg.uuid, tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
+
+	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
+	sess_arg.num_params = 1;
+
+	param[0] = (struct tee_param) {
+		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
+		.u.value.a = rproc_id,
+	};
+
+	ret = tee_client_open_session(rproc_tee_ctx.tee_ctx, &sess_arg, param);
+	if (ret < 0 || sess_arg.ret != 0) {
+		dev_err(dev, "tee_client_open_session failed, err: %#x\n", sess_arg.ret);
+		ret = -EINVAL;
+		goto free_tproc;
+	}
+
+	trproc->rproc_id = rproc_id;
+	trproc->session_id = sess_arg.session;
+
+	trproc->rproc = rproc;
+
+	/* Create device link between the rproc device and the TEE device */
+	link = device_link_add(dev, rproc_tee_ctx.dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link) {
+		ret = -ENOMEM;
+		goto close_tee;
+	}
+	list_add_tail(&trproc->node, &rproc_tee_ctx.sessions);
+
+	goto out;
+
+close_tee:
+	if (tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id))
+		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed\n");
+free_tproc:
+	kfree(trproc);
+out:
+	spin_unlock(&ctx_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_register);
+
+/**
+ * rproc_tee_unregister - Register a remote processor controlled by a TEE application.
+ *
+ * This function unregisters a remote processor previously registered by the rproc_tee_register()
+ * function.
+ *
+ * @dev: Pointer to client rproc device
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * Return: Returns 0 on success, or an error code on failure
+ */
+int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
+{
+	struct rproc_tee *trproc = rproc_to_trproc(rproc);
+	int ret;
+
+	if (!trproc)
+		return -EINVAL;
+
+	spin_lock(&ctx_lock);
+
+	ret = tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id);
+	if (ret < 0)
+		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed, err: %#x\n", ret);
+
+	spin_unlock(&ctx_lock);
+
+	list_del(&trproc->node);
+	kfree(trproc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_unregister);
+
+static int rproc_tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
+{
+	/* Today we support only the OP-TEE, could be extend to other tees */
+	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
+}
+
+static int rproc_tee_probe(struct device *dev)
+{
+	struct tee_context *tee_ctx;
+
+	/* Open context with TEE driver */
+	tee_ctx = tee_client_open_context(NULL, rproc_tee_ctx_match, NULL, NULL);
+	if (IS_ERR(tee_ctx))
+		return PTR_ERR(tee_ctx);
+
+	spin_lock(&ctx_lock);
+	rproc_tee_ctx.dev = dev;
+	rproc_tee_ctx.tee_ctx = tee_ctx;
+	INIT_LIST_HEAD(&rproc_tee_ctx.sessions);
+	spin_unlock(&ctx_lock);
+
+	return 0;
+}
+
+static int rproc_tee_remove(struct device *dev)
+{
+	spin_lock(&ctx_lock);
+	tee_client_close_context(rproc_tee_ctx.tee_ctx);
+	rproc_tee_ctx.dev = NULL;
+	rproc_tee_ctx.tee_ctx = NULL;
+	spin_unlock(&ctx_lock);
+
+	return 0;
+}
+
+MODULE_DEVICE_TABLE(tee, rproc_tee_id_table);
+
+static struct tee_client_driver rproc_tee_fw_driver = {
+	.id_table	= rproc_tee_id_table,
+	.driver		= {
+		.name		= KBUILD_MODNAME,
+		.bus		= &tee_bus_type,
+		.probe		= rproc_tee_probe,
+		.remove		= rproc_tee_remove,
+	},
+};
+
+static int __init rproc_tee_fw_mod_init(void)
+{
+	return driver_register(&rproc_tee_fw_driver.driver);
+}
+
+static void __exit rproc_tee_fw_mod_exit(void)
+{
+	driver_unregister(&rproc_tee_fw_driver.driver);
+}
+
+module_init(rproc_tee_fw_mod_init);
+module_exit(rproc_tee_fw_mod_exit);
+
+MODULE_DESCRIPTION(" remote processor TEE module");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/remoteproc_tee.h b/include/linux/remoteproc_tee.h
new file mode 100644
index 000000000000..659bd77a4f12
--- /dev/null
+++ b/include/linux/remoteproc_tee.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright(c) 2024 STMicroelectronics
+ */
+
+#ifndef REMOTEPROC_TEE_H
+#define REMOTEPROC_TEE_H
+
+#include <linux/tee_drv.h>
+#include <linux/firmware.h>
+#include <linux/remoteproc.h>
+
+struct rproc;
+struct rproc_tee;
+
+#if IS_ENABLED(CONFIG_REMOTEPROC_TEE)
+
+int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int rproc_id);
+int rproc_tee_unregister(struct device *dev, struct rproc *rproc);
+int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw);
+int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw);
+void rproc_tee_release_fw(struct rproc *rproc);
+struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
+						       const struct firmware *fw);
+int rproc_tee_start(struct rproc *rproc);
+int rproc_tee_stop(struct rproc *rproc);
+
+#else
+
+static inline int rproc_tee_register(struct device *dev, struct rproc *rproc, unsigned int rproc_id)
+{
+	return -ENODEV;
+}
+
+static inline int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_load_fw(struct rproc *rproc,  const struct firmware *fw)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_start(struct rproc *rproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline int rproc_tee_stop(struct rproc *rproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return 0;
+}
+
+static inline void rproc_tee_release_fw(struct rproc *rproc)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+}
+
+static inline struct resource_table *
+rproc_tee_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return NULL;
+}
+#endif /* CONFIG_REMOTEPROC_TEE */
+#endif /* REMOTEPROC_TEE_H */
-- 
2.25.1

