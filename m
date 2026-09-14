Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D58DC88E7A
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:41:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8A0DE45263
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:41:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=spl088wY;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 72002452F5
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Sep 2026 17:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHFfzGULBAigzeJaPcMGNk+scztQ8Jb7Q5o8WG6Wf49iF2hv7xiM41xnJ7apzDnRWIIgf5EnTwcLRD5ie5DObPYxl4iwHqYDZw2V+8YG1cZGTp4AnL7T82MqccjVCmlvkf4M8wz6Lkfnb4v0RgNJJmSfe8K1FWHtTheXwLdxLP4p8wBWkk5gcmuDq7bK1s+NjDHDkZRu04gzntcVNtmp4sjiyvNQmpsFzFnV8u8S2ECjGRv5J9D5K9MqhKBTX0bkX6edyuP5afy1O5/TaDSgt0oWyz80gOkbh1mAJIUch4yQ1eqG40RX2p93UvYOCLlaQJjV0YPSN7hQQs4uQMpJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssKp3NwhyA92vxkO+1pEB7NB7HHLhpMbHe01d76udmA=;
 b=Bb+DhvjAoNPDfC3DmxtLvWC2iMkkb7B9BDu33XjjcLs+leuxL9lckm2NQbqaaYdmiKbDbkWua3pEXoPMpM4Rr0oVZw2ZQSYJnJemVupH+1RVoyzFbsV8ZAkiKQQ+h9eKXpp85GeilNeNoVlYhedRSMsAuKPpiN6WLUJtal9Q57M0D1yVSQ2LV92AQHwG8ivHjzjMrsJBfqKb94GsFspUTnpj5HeFIYnB6rbJ0YGUT4SzKzIh7BgJgZEPLYXSygDzvKkIg6VGUwSuXWHv3Ab1aUm04A6+uhGI08FI6kRp3oTX49FqYo82t0fssrzeguwFZsd0lVtbR1T/rv/ZZRsKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssKp3NwhyA92vxkO+1pEB7NB7HHLhpMbHe01d76udmA=;
 b=spl088wYVmZRxH8tK8hEfqccsc9NPIZzj3Qjor6hIFHiv86i8KM8L8OU3XVHH1TDBDRWr1M2z08FWFlnuMCv56m01OQxZm0AXepRediVjMvrvrDF9kF51BnBGA40qn5GF7awRlVJJ5aRZ+PQhIai7DGluBLNYmGxHLiPecJ/KbgpVK8zd1dAgIhNPvpJo0xhk1+AM7p7GiAPfVUDnsHWfGDxxzW8WxcNJWwr1Cw4kSeL0MXydbRkPtx6UeSCc9cHptY0hQ1BOlVxInHXQIm6LlZdbDK/MNIIXyvPG/tVDlsVpzP6jXE/6wgneWJTvWClP+WzPFlCDVj1J13z4fs08Q==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by MMZPR04MB447860.eurprd04.prod.outlook.com
 (2603:10a6:190:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:40:48 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 17:40:48 +0000
From: marouene.boubakri@oss.nxp.com
To: Jens Wiklander <jenswi@kernel.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kernel@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/3] tee: optee: build the Arm-specific code only on Arm
Date: Mon, 14 Sep 2026 19:54:33 +0200
Message-Id: <20260914175435.118303-2-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914175435.118303-1-marouene.boubakri@oss.nxp.com>
References: <20260914175435.118303-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR02CA0012.namprd02.prod.outlook.com
 (2603:10b6:930:a1::7) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|MMZPR04MB447860:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfa5705-99ff-4162-6a45-08df1287501e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|56012099006|6133799003|5023799004|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	NaFWq/z4cN+WbM82kX45V2XYQJyVKwy/xuOjFf52GBIr41mg/i1EtzO24RFt2CghMuSZGueCH1cVJTU36cGePz2ktoMFx9kPUbYeWO3Z1MVL6cfiFp7sSZsKfiSfRfN0Alzay0DPeXahs9SXSQH5vbjK6kWhbMdsRgkyvoRHg7Um4D/LxxRSavlO+taBCQwkBx1Lpzg8amvexG2mXn1vG/36dmyZVYjSFfWsyFm/W7MScmGzVdOLM9gGrPIWw0bV6XkrqSW+QI6X+CVqOv0WVfnMwr2pu+qpOG5tOeDqr4E7YR/TlpF9hbP12E++fpqWmvKBJ24PRTj7FNp9tA0BiNX+IK1mRfyannEpP9iHNodrPCxIW2wnnsbxlGRP7ra2PWZwJC3bOmXKkQGCEqqW9YWSQHEctPauBTBOo1RswGdCcq33T7mc+Y2BQA6CVZ36uqB60PJdm3QekxfB1+glSsi5g4O5sXo+BbZUFxz1+2Xl+bcgJ2C1WS2sLK9RJO8St7CtHVkmSe0xfpWHitcqCakjK5owGurkN0rzRlDhhbkxxm7w0AYg93qn943dOr4mscKzj8zhNgvQijwCxglgf0GVCBXs1QQcARpELSu4py/BrlL8JDyzLLTXYfN7KXPA3XRqLXEFOY5+TLYFlWwuNAMAsrg4zeP9tnGswGNU2LU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(56012099006)(6133799003)(5023799004)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zKh7sK/oZ4m05UXvWhNP4F+OVz5l/5s5zTW5hFMZebQkePlN0hHzpERrjLEJ?=
 =?us-ascii?Q?V9rjHulLurtMbzQyCsYwyx8Oww9Dzi5YndCh8s8yuLteYYB7S1gJjMxL4CL9?=
 =?us-ascii?Q?B62B9PBqCj6mVmM6l/yub3hx2nFdD+igtFGKa8aybIt03TxbOAb4Ju1x0rT/?=
 =?us-ascii?Q?aQjkK33UoOtCjXLVlgac26+UVfCh46NF9Y0IsE4YhSfNWEVn3rRuYSpPaQ9Y?=
 =?us-ascii?Q?/stxEuFug8dZBgkSLo+zJZJR48Qtw5FUS9lXCMzPfTOLf/gtJGIdvpIMzQjN?=
 =?us-ascii?Q?Blutn2VkmFRcGjqrSVvv1/DP84hL/awO9pP0xqzBUhMfjwvZ0LfZc3tpcUD9?=
 =?us-ascii?Q?6ec6nCqXiXmO5mREmDYcUt7uKnURGctZk5x4Sdgs88v23Ll4PnW+R5wmzjL0?=
 =?us-ascii?Q?cmAnG5Eho1RO0gkZ+rzT60AIcOEgtNHHFhGXdOZUZvEDuoUU9LJ1ifzYRyLD?=
 =?us-ascii?Q?FSFUAE8IP3vdAApyoCiiy5/GVi2x+otwtjz8rPYsZ+DInl0AkCbOmyUP2Aeo?=
 =?us-ascii?Q?ubQ0isX0suS5R1ltZdUN2kLkjjaoOlGcMvqZGPVCP4D9aqTqHrsbcl/fb7Kh?=
 =?us-ascii?Q?KSM3dujHvJF//HQ8dm3leaNPSkPbfO0wZivam1Slr5eLhpMWGLho6pP1QkrU?=
 =?us-ascii?Q?F4Yx2jyhFDXENVxrZLx/JwxZbEY6XbTGHuEXnZa2EGdioT3dHDe3uiDvAkdc?=
 =?us-ascii?Q?DLbMKZMZyX/r1+aMrycSSgmF980/wKrK2LJowmAXb57dRNSqnRWxI4ZwPVs3?=
 =?us-ascii?Q?vMQItneST1plJxnceqUOUf6V8Pka9BM3/a8pAYQFyxASlP2y43vP/q8ghhQ6?=
 =?us-ascii?Q?UVnujV3ATkCnYaPXBklNSGQybePfTM/8DSsSi2g4sX4UsAqLtikIH5ry/n8R?=
 =?us-ascii?Q?XwwFi5QvqUmoDBgU8EiaD8FF+TBUF11o17QFi4OgB0vldunV8WebrAeATlKl?=
 =?us-ascii?Q?oMyBfbRiKFZrWbYm6BZqual8OJdojacSsPOq2aShTYOG338OK6/W7hm9Nnwt?=
 =?us-ascii?Q?Gv3Hd04mFojXt0i09EQcH2yCI5AWuIL1Nhwg+tLAjKqYxX6UVtaImxiO42At?=
 =?us-ascii?Q?7iHwxZVKvqRPli9mKqLS2KwDAglSy0q4SAQ1B3p2Y42FMM2onJcZPLkgxPhE?=
 =?us-ascii?Q?Drsjz+yxvqLaIEoIQ8abxU4/YIXYA82Stkd4Gmy3rUNrOWy3n9ygo3VPiZg2?=
 =?us-ascii?Q?GbNrd4IOt4WWSpdk5gl1aC9KHN86h/WtlYrKkLBS4s24UzoIddW0AgRF3b4o?=
 =?us-ascii?Q?6FRRskOMiMarXtH+uvkhssRk8Saq0GlaDTy3uJD85Ba36wJxt90liJ2pMU7E?=
 =?us-ascii?Q?JfJiFmJ99ihgridxkC/HiFZgmuAyvEWR72t9Sa0FUqHj1YOgOXr9t1gvYw0E?=
 =?us-ascii?Q?zkPBxlSMivirE+GCbOppvSxlvpWASip1TffoG0xJtH4qSh7KkgVVd9cv2mh9?=
 =?us-ascii?Q?9VjBI/kL84AyCL4QvHtHqW/riNJ8+0rK11eUhFaNz8T/f9OCNbSb94EDIGMJ?=
 =?us-ascii?Q?Rv+E5MMGsFTozb/QfEJ7mfvdZ/4I0sB2xlwqRkkD4zaRFWlddG8GNbvr6rUA?=
 =?us-ascii?Q?c/0/FgZRvp3sV61yE943bWT2hGW+44t386xslnWHjJRh/kdWi0qOwKnxoHC7?=
 =?us-ascii?Q?s+KDXFetYrhGXt86Anp0/ZG5OTBH/CmawovLIT5z8fjfgymzK7SINHgmQLk5?=
 =?us-ascii?Q?opJRbhw//bvElbgeyavdTp7JJlio8EvMe7xmSuendeZ/BbQGusswKbpiNHS4?=
 =?us-ascii?Q?H+J6jLs/vtLC4S+YuOhKT+Dnf2Cfa7Cun4zbamXfdJfswoki0l16mfhAfSmA?=
X-MS-Exchange-AntiSpam-MessageData-1: GE2/tBs6N7G3Ew==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa5705-99ff-4162-6a45-08df1287501e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:40:48.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbUGE5pxj6JhkDJWtqjOH0h3V+hi3NazHENGd/U436pJ/h8M4ww0kZS3/or0MsoWFznGKrKtJ2K/EuBAmoPJVOhTlXCsySqRteHUJfSRO31H5V3xzZMvhwB1moIRxmzZszaGXmEFPszHa5PIcRE6sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB447860
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.35:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.159.35:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[nxp.com:email,oss.nxp.com:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,mail-norwayeastazon11013035.outbound.protection.outlook.com:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 72002452F5
X-Spamd-Bar: ---
Message-ID-Hash: OEHTTXY5C57XA3V2DWXUKEJT63AAEMUH
X-Message-ID-Hash: OEHTTXY5C57XA3V2DWXUKEJT63AAEMUH
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OEHTTXY5C57XA3V2DWXUKEJT63AAEMUH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

The OP-TEE driver reaches OP-TEE through the SMC ABI or the FF-A ABI,
both specific to Arm, yet builds both unconditionally together with the
SMC Calling Convention definitions they rely on: ffa_abi.c only checks
at runtime whether the FF-A transport is reachable, and optee_private.h
includes <linux/arm-smccc.h> and defines the SMC and FF-A specific types
for every file of the driver. This is fine as long as the driver depends
on HAVE_ARM_SMCCC, but it keeps the driver from being built for an
architecture without SMCCC, such as RISC-V.

Build smc_abi.c only when HAVE_ARM_SMCCC is set and ffa_abi.c only when
ARM_FFA_TRANSPORT is enabled, and provide stubs for their registration
otherwise, so that it fails with -EOPNOTSUPP as the FF-A ABI already
does when the FF-A transport is not reachable. Keep the SMCCC header,
the SMC invoke function type, the SMC and FF-A specific structures and
the SMC RPC register parameters in optee_private.h under the same
conditions, and drop the unused <linux/arm-smccc.h> include from
notif.c.

No functional change: OPTEE still depends on HAVE_ARM_SMCCC, and
ffa_abi.c is still built whenever the FF-A ABI can be registered.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
 drivers/tee/optee/Makefile        |  4 ++--
 drivers/tee/optee/notif.c         |  1 -
 drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index ad7049c1c107..183cdde1ac04 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -7,8 +7,8 @@ optee-objs += rpc.o
 optee-objs += protmem.o
 optee-objs += supp.o
 optee-objs += device.o
-optee-objs += smc_abi.o
-optee-objs += ffa_abi.o
+optee-$(CONFIG_HAVE_ARM_SMCCC) += smc_abi.o
+optee-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_abi.o
 
 # for tracing framework to find optee_trace.h
 CFLAGS_smc_abi.o := -I$(src)
diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 6e85f2f5c516..68014222d7be 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -5,7 +5,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index aefe1e6f5689..94a4f251f5cf 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -6,7 +6,6 @@
 #ifndef OPTEE_PRIVATE_H
 #define OPTEE_PRIVATE_H
 
-#include <linux/arm-smccc.h>
 #include <linux/notifier.h>
 #include <linux/rhashtable.h>
 #include <linux/rpmb.h>
@@ -15,6 +14,10 @@
 #include <linux/types.h>
 #include "optee_msg.h"
 
+#ifdef CONFIG_HAVE_ARM_SMCCC
+#include <linux/arm-smccc.h>
+#endif
+
 #define DRIVER_NAME "optee"
 
 #define OPTEE_MAX_ARG_SIZE	1024
@@ -42,10 +45,12 @@
  */
 #define OPTEE_DEFAULT_MAX_NOTIF_VALUE	255
 
+#ifdef CONFIG_HAVE_ARM_SMCCC
 typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
 				unsigned long, unsigned long, unsigned long,
 				unsigned long, unsigned long,
 				struct arm_smccc_res *);
+#endif
 
 /**
  * struct optee_call_waiter - TEE entry may need to wait for a free TEE thread
@@ -119,6 +124,7 @@ struct optee_supp {
 	struct completion reqs_c;
 };
 
+#ifdef CONFIG_HAVE_ARM_SMCCC
 /**
  * struct optee_pcpu - per cpu notif private struct passed to work functions
  * @optee:	optee device reference
@@ -149,7 +155,9 @@ struct optee_smc {
 	struct work_struct notif_pcpu_work;
 	unsigned int notif_cpuhp_state;
 };
+#endif
 
+#if IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)
 /**
  * struct optee_ffa -  FFA communication struct
  * @ffa_dev:		FFA device, contains the destination id, the id of
@@ -170,6 +178,7 @@ struct optee_ffa {
 	struct workqueue_struct *notif_wq;
 	struct work_struct notif_work;
 };
+#endif
 
 struct optee;
 
@@ -257,8 +266,12 @@ struct optee {
 	const struct optee_ops *ops;
 	struct tee_context *ctx;
 	union {
+#ifdef CONFIG_HAVE_ARM_SMCCC
 		struct optee_smc smc;
+#endif
+#if IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)
 		struct optee_ffa ffa;
+#endif
 	};
 	struct optee_shm_arg_cache shm_arg_cache;
 	struct optee_call_queue call_queue;
@@ -290,6 +303,7 @@ struct optee_context_data {
 	struct list_head sess_list;
 };
 
+#ifdef CONFIG_HAVE_ARM_SMCCC
 struct optee_rpc_param {
 	u32	a0;
 	u32	a1;
@@ -300,6 +314,7 @@ struct optee_rpc_param {
 	u32	a6;
 	u32	a7;
 };
+#endif
 
 /* Holds context that is preserved during one STD call */
 struct optee_call_ctx {
@@ -422,9 +437,31 @@ static inline void reg_pair_from_64(u32 *reg0, u32 *reg1, u64 val)
 }
 
 /* Registration of the ABIs */
+#ifdef CONFIG_HAVE_ARM_SMCCC
 int optee_smc_abi_register(void);
 void optee_smc_abi_unregister(void);
+#else
+static inline int optee_smc_abi_register(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void optee_smc_abi_unregister(void)
+{
+}
+#endif
+#if IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)
 int optee_ffa_abi_register(void);
 void optee_ffa_abi_unregister(void);
+#else
+static inline int optee_ffa_abi_register(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void optee_ffa_abi_unregister(void)
+{
+}
+#endif
 
 #endif /*OPTEE_PRIVATE_H*/

base-commit: 827751b699b79a6e569983359c02dce67f81b94c
-- 
2.43.0

