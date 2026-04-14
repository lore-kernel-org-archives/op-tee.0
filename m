Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E92FF9D0D5
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:45:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 99080443F7
	for <op-tee@archiver.kernel.org>; Tue, 14 Apr 2026 15:45:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=gAeml6Qh;
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3992344B17
	for <op-tee@lists.trustedfirmware.org>; Tue, 14 Apr 2026 15:45:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVuWV0c6NfXy2cTCBc819XDXuDLAF2mazeWLaFvsaI+igyIHyDT1c+sy6+5WB498H3CSHmciHuFy59JCwM21OUAp8r0rGXHUWxwWzV4W996znzcfnvcHig3DYQks2Jk/hTmjp2TxmxWgw8xOCfRZYK1wXunurMU5Ta8eLoK5UtvzQIs+wXARjckZh+dKpoFyH15XhHXud2M4xJBxACVhleaqdKK7Nbx+1WBSvvzkaMc/q4fnJX5i6nz27xujmGjEb7bbwNcAQGZ53kHFQ8umOdFkSuf4h84Whz9MPMQMPNW5k+BxhxY4NTVCvvqgVF1h9tG5ubPpJPBHH3QhSPLuYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCd2NezaFgM47rHmvlbt59HP9EMJwWsn9NPihC0tTKc=;
 b=AmPW2hJrRP0xwMZT+B82HKZzywDvxycU7J4WYtxm1W0VWk0m78z0c/OcJj9wyeOuewOSWICiuKx8EmgWx3/JQM+HnZ5EZLpEE7nF/pM/yCLhmmDfAaHuq6Hg5EoXkfOBhnII0BjNc2lnCRZ6uElxuXr6YvuflbLjOD/L5EUTfjRXKga8pvujxc4xb9J2vQB5McisPxeQTNDyehhbZo4OxCTxEtSqESPmLctuY/jb3AS62PIS+gI6BmBBDobAgwtZByQ6uG0YctOhweXqFC6cCqE0oKJEn/41SGwwDDqzgT+9b8NrqcVa0yAq20+5WcTttz+I8NPXSzqTwQT/WmpqmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCd2NezaFgM47rHmvlbt59HP9EMJwWsn9NPihC0tTKc=;
 b=gAeml6QhBeRrm85S/d4YNXHnqD8BrYKZWGbgP7DYjT9/VrwiqVUqIyoQqD+Uumu4L06cRXK2ZsbWNrWUGSn5kD2w6sIM7QZbc4Bc87XgsSS1RRVWa3/CL2XNVt0MtMtH1DLacEVeuk4IQlhdZ+k0+/zafinchdZbks3T81ewThdeId6tqjwPAy/jD3h4006fI7OmCa/zeCnxfQgN7O1EUZYDEyFefisnN7X0CQ3h2eC/VRZ2fqIp9gZjb4BBIwiLlfPfpbAHc4Doz8J93jbbI4sv8zdkCahVzUUWR2YNOaUQtKA2qWOEFhTPanitt0SBLfR+xgJ0SP7E3UlKsLKbAA==
Received: from DU2PR04CA0035.eurprd04.prod.outlook.com (2603:10a6:10:234::10)
 by DU0PR10MB9235.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:59c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 15:29:20 +0000
Received: from DU2PEPF00028D0A.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::d8) by DU2PR04CA0035.outlook.office365.com
 (2603:10a6:10:234::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 15:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D0A.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 14 Apr 2026 15:29:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:32:08 +0200
Received: from localhost (10.252.12.46) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 14 Apr
 2026 17:29:19 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v22 5/7] remoteproc: Add TEE support
Date: Tue, 14 Apr 2026 17:29:00 +0200
Message-ID: <20260414152904.1679724-6-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414152904.1679724-1-arnaud.pouliquen@foss.st.com>
References: <20260414152904.1679724-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.12.46]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0A:EE_|DU0PR10MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a97ecbe-5978-4ca1-3d5d-08de9a3a9974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	nd09bHvJPwpuhnN21q4Tz5HGYjwK3W99iC8OsRLXYXMjflECKfE1TomHehpe1Za2SMrvmZORRMl6LA9UDsYiyVnh+S05ZomSQEDkcM33VuR5mDcgWHrk8PyMtCtSlTESYfs7MLtxTGSEUz2/WK70gvLpSyUTDPEk0WuLDPqnkYmNycMMpRfPsNiNGVZPN3f3dQ04b2BAuDvcj1R4LKxCds0GHow52nN4q9EHFTUdS5wxqeTGQ6KI3UkH8Oam79RxviKfKLqNMS6+gy0uR5ELFhLs1WNPPahRa18nUjVVxRicUB0cl7LT9AclgZDdpm4ECG3uPUNzz2y0sJKx7P8ZC3an80tYkQXT64WPUn6LQlWZQyWzViPcd4tH+geO4mBg/nJSAkQgSQbmKPli7yqY9jj3AO76+Sf5pNP562T2bvCKeb+bQsYBkY4qHDmzkbvKXltgxay7aK35hBZ07pfSL8KqezkMX/+P7pBxq2wa/L3eI5+RmkS8eOUQCO0cFvZ3WF7RPBGfB6unn46T9mk3MRU6vxGWbFgMALuH4HOTzKgmJE5moL/UXQc8hnn8kz/xZRuucS6+aNmIUXaS3vqXskEUfv5/hrWIUQaHCABGtDswtRKmZO70DBVLI+yAMo4gUxGgFOeMo+3XiI8WdR/IZoYKk/VzDC1enD4fD7dLoxbdPrWygvo3W5cC9N2YrLopTXwJv2rGAUxFymjzuRUthNoQubEXt4BAZbcrYd4M/Xe106oo0GeUQDQTcm6ylxOJ6VDCIRAI0xZVGJQD4bFr3g==
X-Forefront-Antispam-Report: 
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	h9Yz8TAJQNZf1YWD8G/oOxuq4U7tyVVXsomVXUYLwFaiyEB5SkvJ/dnc9xqd3TxvsIkCWm20DDvHd2foflws6qwBBQx5eP7gOoc7W+ck5EKKKCPo1dxuhQgd68cBn0Z17p1RRNQsvmQecsEDcbVs9malyBTzPGCMm0rMOwfcbwRWMflgicCLWH9VeIlz/zk6n3Zcy1UdCD5Zfl0+tLUnlxl1Mry/Ccvtd299FuKRNIHYni4lJlaDW5I6hrzilxLxH8AEf4WXvaf3oAj4yLB8oBgxrC2bf3fnhPB1NLjqiMBOURcZtZE0cF3686BhTu9O5yGu/aHKvq9gGSK2lJmtzdwyG9Vq3ikLFegrgHnZoIS9Qk1cC52Kcsi5kVf1cTcbax18NAbbuuFGUq8a7ZGydcB8k1MFclridxFj9l+qDTux9IjAXaPcADXDeOws8Xmw
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:29:20.5334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a97ecbe-5978-4ca1-3d5d-08de9a3a9974
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D0A.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9235
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.130.69:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ALIAS_RESOLVED(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.130.69:from];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3992344B17
X-Spamd-Bar: --
Message-ID-Hash: MSXJ2XDRVS3NU6RODD5B7S42V622L2HN
X-Message-ID-Hash: MSXJ2XDRVS3NU6RODD5B7S42V622L2HN
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MSXJ2XDRVS3NU6RODD5B7S42V622L2HN/>
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
Version 22 updates:
- Revert to version 19, as the st,stm32-rproc-tee compatible has been
  rejected. As a consequence, we cannot have a rproc_stm32-tee.c driver
  and must reuse the rproc_stm32.c driver.
- Protect rproc_to_trproc() with lockdep_assert_held().

Version 21 updates:
- introduce uuid_to_str() to compute the compatible from the TEE UUID
- update rproc_tee_register() to provide phandle referenced in the
  remoteproc driver client.
- use device_link_add() to link the remoteproc driver client.

Version 20 updates:
- rework probe. the remoteproc-tee now probe the remoteproc devices
  defined in device tree as child.
  - creation of rproc-service-80a4c275-0a47-4905-8285-1486a9771a08 compatible
  - use of of_find_compatible_node() to find node in DT
  - use of of_platform_populate() to probe remoteproc devices
- remove device_link_add() as now managed by of_platform_populate)
- add "auto_boot" parameter in rproc_tee_register()
- rename TA_RPROC_FW_CMD_* TEE CMD in  TA_RPROC_CMD_* command
- use of DEFINE_MUTEX

Version 19 updates:
- rework/fix function headers
- use memremap instead of ioremap for the resource table.
- realign comments to 80 chars limit, with few exceptions for readability
- replace spinlock by mutex and and protect APIs from concurrent access
- add support of 64-bit address in rproc_tee_get_loaded_rsc_table()
- update copyright year

Version 18 updates
Fix warning:
warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
---
 drivers/remoteproc/Kconfig          |  10 +
 drivers/remoteproc/Makefile         |   1 +
 drivers/remoteproc/remoteproc_tee.c | 789 ++++++++++++++++++++++++++++
 include/linux/remoteproc_tee.h      |  98 ++++
 4 files changed, 898 insertions(+)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index ee54436fea5a..87d69f200590 100644
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
index 000000000000..b4e01ad84010
--- /dev/null
+++ b/drivers/remoteproc/remoteproc_tee.c
@@ -0,0 +1,789 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) STMicroelectronics 2025
+ * Author: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/mutex.h>
+#include <linux/remoteproc.h>
+#include <linux/remoteproc_tee.h>
+#include <linux/slab.h>
+#include <linux/tee_drv.h>
+
+#include "remoteproc_internal.h"
+
+#define MAX_TEE_PARAM_ARRAY_MEMBER	4
+
+/*
+ * Authentication and load of the firmware image in the remote processor
+ * memories by the TEE. After this step the firmware is installed in destination
+ * memories, which can then be locked to prevent access by Linux.
+ *
+ * [in]  params[0].value.a: remote processor identifier
+ * [in]  params[1].memref:  buffer containing a temporary copy of the signed
+ *			    image to load.
+ */
+#define TA_RPROC_CMD_LOAD_FW		1
+
+/*
+ * Start the remote processor by the TEE
+ *
+ * [in]  params[0].value.a: remote processor identifier
+ */
+#define TA_RPROC_CMD_START		2
+
+/*
+ * Stop the remote processor by the TEE
+ *
+ * [in]  params[0].value.a: remote processor identifier
+ */
+#define TA_RPROC_CMD_STOP		3
+
+/*
+ * Return the address of the resource table, or 0 if not found.
+ *
+ * [in]  params[0].value.a: remote processor identifier
+ * [out] params[1].value.a: 32bit LSB resource table memory address
+ * [out] params[1].value.b: 32bit MSB resource table memory address
+ * [out] params[2].value.a: 32bit LSB resource table memory size
+ * [out] params[2].value.b: 32bit MSB resource table memory size
+ */
+#define TA_RPROC_CMD_GET_RSC_TABLE	4
+
+/*
+ * Release remote processor firmware images and associated resources.
+ * This command should be used in case an error occurs between the loading of
+ * the firmware images (TA_RPROC_CMD_LOAD_FW) and the starting of the remote
+ * processor (TA_RPROC_CMD_START) or after stopping the remote processor
+ * to release associated resources (TA_RPROC_CMD_STOP).
+ *
+ * [in]  params[0].value.a: remote processor identifier
+ */
+#define TA_RPROC_CMD_RELEASE_FW		6
+
+/**
+ * struct rproc_tee_context - Global TEE backend context
+ * @rproc_list: List of registered TEE-backed remoteprocs
+ * @tee_ctx:    TEE context handle
+ * @dev:        TEE client device
+ */
+struct rproc_tee_context {
+	struct list_head	rproc_list;
+	struct tee_context	*tee_ctx;
+	struct device		*dev;
+};
+
+/**
+ * struct rproc_tee - TEE remoteproc structure
+ * @node:       Reference in global list
+ * @rproc:      Remoteproc reference
+ * @rproc_id:   remote processor identifier
+ * @session_id: TEE session identifier
+ */
+struct rproc_tee {
+	struct list_head node;
+	struct rproc *rproc;
+	u32 rproc_id;
+	u32 session_id;
+};
+
+static struct rproc_tee_context rproc_tee_ctx;
+static DEFINE_MUTEX(ctx_lock); /* Protects concurrent manipulations of the rproc_tee_ctx*/
+
+static struct rproc_tee *rproc_to_trproc(struct rproc *rproc)
+{
+	struct rproc_tee *trproc;
+
+	lockdep_assert_held(&ctx_lock);
+
+	list_for_each_entry(trproc, &rproc_tee_ctx.rproc_list, node) {
+		if (trproc->rproc == rproc)
+			return trproc;
+	}
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
+static int rproc_tee_sanity_check(struct device_node *tee_np)
+{
+	/* Backend not probed yet */
+	if (!rproc_tee_ctx.dev || !rproc_tee_ctx.dev->of_node)
+		return -EPROBE_DEFER;
+
+	/* DT error: phandle points to different node than the backend we use */
+	if (tee_np != rproc_tee_ctx.dev->of_node)
+		return -EINVAL;
+
+	return 0;
+}
+
+/**
+ * rproc_tee_release_fw() - Release the firmware for a TEE-based remote processor
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * This function invokes the TA_RPROC_CMD_RELEASE_FW TEE client function to
+ * release the firmware. It should only be called when the remoteproc state is
+ * RPROC_OFFLINE or RPROC_DETACHED. The function requests the TEE remoteproc
+ * application to release the firmware loaded by rproc_tee_load_fw().
+ * The request is ignored if the rproc state is RPROC_DETACHED as the remote
+ * processor is still running.
+ */
+void rproc_tee_release_fw(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc;
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return;
+
+	if (!rproc_tee_ctx.dev)
+		goto out;
+
+	trproc = rproc_to_trproc(rproc);
+	if (!trproc)
+		goto out;
+
+	/*
+	 * If the remote processor state is RPROC_DETACHED, just ignore the
+	 * request, as the remote processor is still running.
+	 */
+	if (rproc->state == RPROC_DETACHED)
+		goto out;
+
+	if (rproc->state != RPROC_OFFLINE) {
+		dev_err(rproc_tee_ctx.dev, "unexpected rproc state: %d\n", rproc->state);
+		goto out;
+	}
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_RELEASE_FW, &arg, param, 0);
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_CMD_RELEASE_FW invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+	}
+
+out:
+	mutex_unlock(&ctx_lock);
+}
+EXPORT_SYMBOL_GPL(rproc_tee_release_fw);
+
+/**
+ * rproc_tee_load_fw() - Load firmware from TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * This function invokes the TA_RPROC_CMD_LOAD_FW TEE client function to load
+ * the firmware. It registers the fw->data as a shared memory region with the
+ * TEE, and request the TEE to load the firmware. This function can be called
+ * twice during the remote processor boot, a first by rproc_tee_parse_fw() to
+ * parse the resource table , and a second time by rproc_tee_load_fw().
+ * The TEE application should ignores the command if the firmware
+ * is already loaded by rproc_tee_parse_fw().
+ *
+ * Return: 0 on success, or an error code on failure
+ */
+int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc;
+	struct tee_ioctl_invoke_arg arg;
+	struct tee_shm *fw_shm;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return ret;
+
+	if (!rproc_tee_ctx.dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	trproc = rproc_to_trproc(rproc);
+	if (!trproc) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	fw_shm = tee_shm_register_kernel_buf(rproc_tee_ctx.tee_ctx, (void *)fw->data, fw->size);
+	if (IS_ERR(fw_shm)) {
+		ret = PTR_ERR(fw_shm);
+		goto out;
+	}
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_LOAD_FW, &arg, param, 1);
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
+			"TA_RPROC_CMD_LOAD_FW invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+
+	tee_shm_free(fw_shm);
+
+out:
+	mutex_unlock(&ctx_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_load_fw);
+
+static int rproc_tee_get_loaded_rsc_table(struct rproc *rproc, phys_addr_t *rsc_pa,
+					  size_t *table_sz)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc;
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return ret;
+
+	if (!rproc_tee_ctx.dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	trproc = rproc_to_trproc(rproc);
+	if (!trproc) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_GET_RSC_TABLE, &arg, param, 2);
+
+	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_CMD_GET_RSC_TABLE invoke failed TEE err: %#x, ret:%d\n",
+			arg.ret, ret);
+		ret = -EIO;
+		goto out;
+	}
+
+	*table_sz = param[2].u.value.a;
+	if (sizeof(phys_addr_t) == sizeof(u64))
+		*table_sz |= param[2].u.value.b << 32;
+
+	if (*table_sz) {
+		*rsc_pa = param[1].u.value.a;
+		if (sizeof(phys_addr_t) == sizeof(u64))
+			*rsc_pa |= param[1].u.value.b << 32;
+	} else {
+		*rsc_pa = 0;
+	}
+
+out:
+	mutex_unlock(&ctx_lock);
+	return ret;
+}
+
+/**
+ * rproc_tee_parse_fw() - Get the resource table from TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * This function retrieves the loaded resource table and creates a cached_table
+ * copy. Since the firmware image is signed and potentially encrypted, the
+ * firmware must be loaded first to access the loaded resource table.
+ *
+ * Return: 0 on success, or an error code on failure
+ */
+int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
+{
+	phys_addr_t rsc_table;
+	void *rsc_va;
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
+	/* A missing resource table is valid for some firmware images. */
+	if (!table_sz) {
+		rproc->table_ptr = NULL;
+		rproc->table_sz = 0;
+		return 0;
+	}
+
+	/*
+	 * We assume here that the memory mapping is the same between the TEE
+	 * and Linux kernel contexts. Else a new TEE remoteproc service could be
+	 * needed to get a copy of the resource table.
+	 */
+	rsc_va = memremap(rsc_table, table_sz, MEMREMAP_WC);
+	if (!rsc_va) {
+		dev_err(rproc_tee_ctx.dev, "Unable to map memory region: %pa+%zx\n",
+			&rsc_table, table_sz);
+		ret = -ENOMEM;
+		goto release_fw;
+	}
+
+	/*
+	 * Create a copy of the resource table to have the same behavior as the
+	 * ELF loader. This cached table will be used by the remoteproc core
+	 * after the remoteproc stops to free resources and for crash recovery
+	 * to reapply the settings.
+	 * The cached table will be freed by the remoteproc core.
+	 */
+	rproc->cached_table = kmemdup(rsc_va, table_sz, GFP_KERNEL);
+	memunmap(rsc_va);
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
+ * rproc_tee_find_loaded_rsc_table() - Find the loaded resource table loaded by
+ *				       the TEE application
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ * @fw: Pointer to the firmware structure containing the firmware data and size
+ *
+ * This function retrieves the physical address and size of the resource table
+ * loaded by the TEE application.
+ *
+ * Return: pointer to the resource table if found, or NULL if not found or size
+ * is 0
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
+	 * At this step the memory area that contains the resource table should
+	 * have been registered by the remote proc platform driver and allocated
+	 * by rproc_alloc_registered_carveouts().
+	 */
+	return rproc_pa_to_va(rproc, rsc_table, table_sz, NULL);
+}
+EXPORT_SYMBOL_GPL(rproc_tee_find_loaded_rsc_table);
+
+/**
+ * rproc_tee_start() - Request the TEE application to start the remote processor
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * This function invokes the TA_RPROC_CMD_START command to start the remote
+ * processor.
+ *
+ * Return: Returns 0 on success, -EINVAL or -EIO on failure
+ */
+int rproc_tee_start(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc;
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return ret;
+
+	if (!rproc_tee_ctx.dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	trproc = rproc_to_trproc(rproc);
+	if (!trproc) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_START, &arg, param, 0);
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_CMD_START invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+
+out:
+	mutex_unlock(&ctx_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_start);
+
+/**
+ * rproc_tee_stop() - Request the TEE application to start the remote processor
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * This function invokes the TA_RPROC_CMD_STOP command to stop the remote
+ * processor.
+ *
+ * Return: Returns 0 on success, -EINVAL or -EIO on failure
+ */
+int rproc_tee_stop(struct rproc *rproc)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	struct rproc_tee *trproc;
+	struct tee_ioctl_invoke_arg arg;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return ret;
+
+	if (!rproc_tee_ctx.dev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	trproc = rproc_to_trproc(rproc);
+	if (!trproc) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_STOP, &arg, param, 0);
+
+	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
+	if (ret < 0 || arg.ret != 0) {
+		dev_err(rproc_tee_ctx.dev,
+			"TA_RPROC_CMD_STOP invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
+		if (!ret)
+			ret = -EIO;
+	}
+
+out:
+	mutex_unlock(&ctx_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_stop);
+
+/**
+ * rproc_tee_register() - Register a remote processor controlled by the TEE application
+ * @dev:        client rproc device
+ * @rproc:      out pointer to the struct rproc representing the remote processor
+ * @tee_phandle: backend phandle args (np + 1 cell: rproc_id)
+ *
+ * The phandle must point to the same DT node that rproc_tee_probe() attached
+ * to the TEE client device.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+int rproc_tee_register(struct device *dev, struct rproc *rproc,
+		       const struct of_phandle_args *tee_phandle)
+{
+	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
+	unsigned int rproc_id;
+	struct device_node *tee_np;
+	struct tee_ioctl_open_session_arg sess_arg;
+	struct tee_client_device *tee_device;
+	struct device_link *link;
+	struct rproc_tee *trproc;
+	int ret;
+
+	if (!tee_phandle || !tee_phandle->np || tee_phandle->args_count < 1)
+		return -EINVAL;
+
+	rproc_id = tee_phandle->args[0];
+	tee_np = tee_phandle->np;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return ret;
+
+	ret = rproc_tee_sanity_check(tee_np);
+	if (ret)
+		goto out;
+
+	trproc = kzalloc_obj(*trproc);
+	if (!trproc) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tee_device = to_tee_client_device(rproc_tee_ctx.dev);
+	memset(&sess_arg, 0, sizeof(sess_arg));
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
+		dev_err(dev, "tee_client_open_session failed, err: %#x\n",
+			sess_arg.ret);
+		ret = -EINVAL;
+		goto free_trproc;
+	}
+
+	trproc->rproc_id = rproc_id;
+	trproc->session_id = sess_arg.session;
+
+	ret = rproc_add(rproc);
+	if (ret)
+		goto close_tee;
+
+	trproc->rproc = rproc;
+	/* Create device link between the rproc device and the TEE device */
+	link = device_link_add(dev, rproc_tee_ctx.dev,
+			       DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link) {
+		ret = -ENOMEM;
+		goto del_rproc;
+	}
+
+	list_add_rcu(&trproc->node, &rproc_tee_ctx.rproc_list);
+
+	mutex_unlock(&ctx_lock);
+
+	return 0;
+
+del_rproc:
+	rproc_del(rproc);
+close_tee:
+	if (tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id))
+		dev_err(rproc_tee_ctx.dev,
+			"tee_client_close_session failed\n");
+free_trproc:
+	kfree(trproc);
+out:
+	mutex_unlock(&ctx_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_register);
+
+/**
+ * rproc_tee_unregister - Unregister a remote processor controlled by the TEE
+ *                        application.
+ * @dev: Pointer to client rproc device
+ * @rproc: Pointer to the struct rproc representing the remote processor
+ *
+ * This function unregisters a remote processor previously registered by the
+ * rproc_tee_register() function.
+ *
+ * Return: Returns 0 on success, or an error code on failure
+ */
+int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
+{
+	struct rproc_tee *trproc;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return ret;
+
+	if (!rproc_tee_ctx.dev) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	trproc = rproc_to_trproc(rproc);
+	if (!trproc) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	/*
+	 * Unlock ctx_lock before calling rproc_del(),
+	 * they may call into rproc core and take other locks to stop the
+	 * remote processor, if it is running.
+	 */
+	mutex_unlock(&ctx_lock);
+
+	rproc_del(rproc);
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return ret;
+
+	ret = tee_client_close_session(rproc_tee_ctx.tee_ctx,
+				       trproc->session_id);
+	if (ret < 0)
+		dev_err(rproc_tee_ctx.dev,
+			"tee_client_close_session failed, err: %#x\n", ret);
+
+	list_del(&trproc->node);
+	kfree(trproc);
+
+out_unlock:
+	mutex_unlock(&ctx_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rproc_tee_unregister);
+
+static int rproc_tee_ctx_match(struct tee_ioctl_version_data *ver,
+			       const void *data)
+{
+	/* Today we support only OP-TEE; could be extended to other TEEs */
+	return ver->impl_id == TEE_IMPL_ID_OPTEE;
+}
+
+static const struct tee_client_device_id rproc_tee_id_table[] = {
+	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905, 0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(tee, rproc_tee_id_table);
+
+static void uuid_to_str(const struct tee_client_device_id *id, char *uuid_str)
+{
+	snprintf(uuid_str, UUID_STRING_LEN + 1,
+		 "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x",
+		 id->uuid.b[0], id->uuid.b[1], id->uuid.b[2], id->uuid.b[3],
+		 id->uuid.b[4], id->uuid.b[5], id->uuid.b[6], id->uuid.b[7],
+		 id->uuid.b[8], id->uuid.b[9], id->uuid.b[10], id->uuid.b[11],
+		 id->uuid.b[12], id->uuid.b[13], id->uuid.b[14], id->uuid.b[15]);
+}
+
+static int rproc_tee_probe(struct tee_client_device *tee_dev)
+{
+	struct device *dev = &tee_dev->dev;
+	struct tee_context *tee_ctx;
+	struct device_node *np;
+	char uuid_str[UUID_STRING_LEN + 1];
+	int ret;
+
+	uuid_to_str(&rproc_tee_id_table[0], uuid_str);
+	np = of_find_compatible_node(NULL, NULL, uuid_str);
+	if (!np) {
+		dev_err(dev, "Device node not found for UUID: %s\n", uuid_str);
+		return -ENODEV;
+	}
+
+	/* Open context with TEE driver */
+	tee_ctx = tee_client_open_context(NULL, rproc_tee_ctx_match, NULL, NULL);
+	if (IS_ERR(tee_ctx)) {
+		ret = PTR_ERR(tee_ctx);
+		goto put_node;
+	}
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		goto close_ctx;
+
+	INIT_LIST_HEAD(&rproc_tee_ctx.rproc_list);
+
+	ret = device_add_of_node(dev, np);
+
+	if (ret) {
+		mutex_unlock(&ctx_lock);
+		goto close_ctx;
+	}
+	rproc_tee_ctx.dev = dev;
+	rproc_tee_ctx.tee_ctx = tee_ctx;
+
+	mutex_unlock(&ctx_lock);
+	of_node_put(np);
+
+	return 0;
+
+close_ctx:
+	tee_client_close_context(tee_ctx);
+put_node:
+	of_node_put(np);
+	return ret;
+}
+
+static void rproc_tee_remove(struct tee_client_device *tee_dev)
+{
+	struct device *dev = &tee_dev->dev;
+	int ret;
+
+	ret = mutex_lock_interruptible(&ctx_lock);
+	if (ret)
+		return;
+
+	rproc_tee_ctx.dev = NULL;
+	mutex_unlock(&ctx_lock);
+	device_remove_of_node(dev);
+
+	tee_client_close_context(rproc_tee_ctx.tee_ctx);
+	rproc_tee_ctx.tee_ctx = NULL;
+}
+
+static struct tee_client_driver rproc_tee_fw_driver = {
+	.id_table	= rproc_tee_id_table,
+	.probe		= rproc_tee_probe,
+	.remove		= rproc_tee_remove,
+	.driver		= {
+		.name		= KBUILD_MODNAME,
+	},
+};
+
+module_tee_client_driver(rproc_tee_fw_driver);
+
+MODULE_DESCRIPTION("remote processor TEE module");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/remoteproc_tee.h b/include/linux/remoteproc_tee.h
new file mode 100644
index 000000000000..8cf805f3b65e
--- /dev/null
+++ b/include/linux/remoteproc_tee.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright(c) 2025 STMicroelectronics
+ */
+
+#ifndef REMOTEPROC_TEE_H
+#define REMOTEPROC_TEE_H
+
+#include <linux/tee_drv.h>
+#include <linux/firmware.h>
+#include <linux/remoteproc.h>
+
+#if IS_ENABLED(CONFIG_REMOTEPROC_TEE)
+
+int rproc_tee_register(struct device *dev, struct rproc *rproc,
+		       const struct of_phandle_args *tee_phandle);
+int rproc_tee_unregister(struct device *dev, struct rproc *rproc);
+int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw);
+int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw);
+void rproc_tee_release_fw(struct rproc *rproc);
+struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
+						       const struct firmware *fw);
+int rproc_tee_start(struct rproc *rproc);
+int rproc_tee_stop(struct rproc *rproc);
+int rproc_tee_pa_to_da(struct rproc *rproc, phys_addr_t pa, size_t size, u64 *da);
+#else
+
+static inline int rproc_tee_register(struct device *dev, struct rproc *rproc,
+				     const struct of_phandle_args *tee_phandle)
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
+static inline int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
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
+static inline int rproc_tee_pa_to_da(struct rproc *rproc, phys_addr_t pa,
+				     size_t size, u64 *da)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -EINVAL;
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
2.43.0

