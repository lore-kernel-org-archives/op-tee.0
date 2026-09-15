Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A01C88E72
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:49:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 294A5453A1
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:49:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=FaIP4WKA;
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 98F4F45336
	for <op-tee@lists.trustedfirmware.org>; Tue, 15 Sep 2026 01:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaqTjXUFaKb8dr5kIq7B2T7n3VTjg+z1smHWwTXiWeECRGiUDHBV7sd4MIIqL5yWCrrmsUHUfQFIokfxqhocU0Q110FeSE5d6Z6jGWZU99F8GHC8zuleyFnwTEtX2jQVqPm55jfWjD5u7559ER/pBEXMzMblwqLwLzTH7ZrWnzJjiJwnmnx76OwDT6RygxBow8LRlAguJ7mtrcP9IgGsLVjWvF91Oc4BXRx/wU8IxU2ZIGEgs5HmxfI+8V7/7CPLcgLnIVo0SPWcFV2AAQpx2qXt+wA6tNfVt7zfEP8nEIW8tE2fzGr0XUjuCHG6WwgeCpWKGTOPTGKbxDdyhaIEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSzbiskntbLGGLYOp0RZwhgo6nLxeka709LpOu6VhYU=;
 b=GIkydOiPWXzdtel1TOUflXnskCW0fFWWZ1EZbqM6M43dWBF2SmEUSpTFdMDXPVuPQdMPiq/Oz/AwSCUpJOmK42cH0AbQxyHqOTkmigbDJ9IvHxl/vS0kHexi0vGH05o/OxhVcTb/tKGlKgMPFH/Ej2xRGXXt0YTWlF+SEMbiuENO9zMDtuYf5PuxdzA24nZak8oWSG3mj+7WkAcfetfknv3a6F4A2/1HcZFdlVCiMLBfobarCbTRl6O0f9pgrY2ommLytJF8ETOsKP51oKgSquZxOxogg6WUPUk3pQJ01gHu1PxqFMQaRJlpFu2v/d4/OP6nYKdwb2Voggwo5YXGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSzbiskntbLGGLYOp0RZwhgo6nLxeka709LpOu6VhYU=;
 b=FaIP4WKA+t8xyaWsfEXWEkU4vI5e02E15CV7yOfqlJ2Qx+JTrXWd6poz6/l5VAGNsZAFeqIzvMdpULp8XY4O9Iias5o54ZpliPVALWOo/5XR0hPaxv5v4NzAQSZ/n458gqD//66cQCtM9gZZcaGszLuKi+qA/gjIVtx/FSRIPEzcsbTmzoGRMrlqgXXfBBbkh1ulwAqGe6aXEBKhaV42ne6mI8DLiQSDpv8VKWoe76DS/GYLII4fJPbs1dB9bUd1YmgAfMl8EWYtYXzlzVSj2iIiILNoYpJK0yZe5qfyk3J0BBtvonVWZne5yfP7ijf/zn3YP99H7AJ/ukidydlByA==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:48:56 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:48:56 +0000
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
Subject: [PATCH v2] tee: optee: add an RPMI ABI placeholder
Date: Tue, 15 Sep 2026 04:02:34 +0200
Message-Id: <20260915020235.507302-3-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
References: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:930:1c::15) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|PAXPR04MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: c5baf2d4-ca83-4239-c64e-08df12cb80dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	X9Aw2dk8vf+Fwl6P4dHazvIt+Gdh27rzekTL7L7nAqfnKjDcjfzxwlPIwaZuL5MpmY/vA0uxt/E29Mosndt/6aH4y2tEjc3h/+Y+isPi9aAuIZpA31csG/bFFIX+VSijH1TUF5i2J96YSe1aeOsbKeRFTIUuKMIp4tsIdyIuYxJmi7cVt5KTQbqt2yCBwEf3Eu/K8UV24ngRLswM5FhaSrkEZNEcE8zG+BrTv1CuxYSIxx65sSnFFSeFd2b6Gj5csDiREtCANFjz194TOJgJ7dYgijdoi44vkqAftBVt2/dITC8+35eEYhqh+QcAzTYYr2znGqeCd0e7ba4QZ+XIxK+z7YP0c8EflX/nC1yTIPmF7GGa0wYzS++LD0t0UTGzD1eGhgj1CGxpu9IMoBhgqYo0WdHGujT/DLKeM0iZelDpewzGeO22sc//cH2uufLPaieZqTx9TI27np6T9RKsdqD9KvwmJtzyfghIxyN/AazjiKOsXYjD+vBb2zlVb+ZT0wszXzuVDo3xfj/bNcLVSPBKOcKfMY5pVPG9Buiyy/UFatdr+WSZ4BisndZyfiWc3dve/AOwwQyg8pQsRDmDlXcqK94JUzGwrZlir8TWziiP3DTc1ImzitZVO0UkwH1Av4BLLtJX/nezThajOQkmXqbDDfqvcNK3BPM8PklRRHw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YNYbMocbEEnxUE7eUxqggct52W6erVM3DZmlVB0bO7G6/YLO7oZq2un+IFXJ?=
 =?us-ascii?Q?2dP4YbSqXiXlDIx831D1heZ8V1x0e/QTruxkZzp68LReOOaoldOfcqVF+lse?=
 =?us-ascii?Q?fz6O5MKG3vN+nuXvnwINFEX+NcvuqPHsdR2Y+WqpNSfLSWXyGL5+mXpnx6hs?=
 =?us-ascii?Q?zJy0QtTPDRxAoNDyjRQSwE6a/i53sNFK8Pq+YqWckPaJunfvCpKuEdTZSFeG?=
 =?us-ascii?Q?gszXRcrEAXvBx8K1a+xIUECj4jLu9hvaPkK4IRZuTmmhprhFsH0KfpdvqHes?=
 =?us-ascii?Q?rxtqgVFx62baaTN4HqkCX+DpTUfrx8CCWSycZOA+1UOFd9yuNDU/NBJ7Ai5u?=
 =?us-ascii?Q?8rDa6u2YTTj5XQ1J2s98FJpAOKs+Sv0HE57XVEkFpGkluKeOXfUoQ0Le7smV?=
 =?us-ascii?Q?CLZ6Js+X7LDPfeMZxLEM/IdvuF8wsPWOTCa6UTlxEBkwnMbHOerUExkGB8jh?=
 =?us-ascii?Q?s5OA0GBkxRUb7SrvVEUFdZGiraeCSFVbtqGF+amc6EV8Rwl5TER50RGc+sPe?=
 =?us-ascii?Q?01Hmc9EL/dxoZU8qiJO7+Tzww/QNIe4mVP6sOqDO+NNKchZVLh7m/A0Q/NRx?=
 =?us-ascii?Q?bFsr2Qorjk2o9JT7BeGcmhMe9RnoN89bGXkPLF2wIM73gnovOUqN4jWwwM3o?=
 =?us-ascii?Q?WpA+atWcB2/6CerOs0Pb7+yo+294Mfzbybbrf8y9RIZCRv9Duv8my9rZ1lBi?=
 =?us-ascii?Q?s755IGHwtAtDxDdpEPL5k20bn6c/EI+Y2q8WbrgSGb9biUpbPhY29gV3YCtf?=
 =?us-ascii?Q?KLJ4K6ajgmWV/10stBrPCNQYQxILhVTBB5aQF7gmggyW7woA/+Dxn5w/YYc8?=
 =?us-ascii?Q?W/WjbFsPpJOUta1F/9Qehr4f4ihE4p9ZNL6nSe9hVB+XO/CNtlDoSo3IUJCg?=
 =?us-ascii?Q?PhAKpx16xkd1qaiZl/ywL3EMi0ShVFekn3qFlIL3J0zdm8irK+sAhP7qgZpe?=
 =?us-ascii?Q?4S+ato5TktmnhK5+EowFaaxFShNGLASVEXuybDJmEgeRBBW2opcPSlFhzwgL?=
 =?us-ascii?Q?42sQNUVgq3RdaJfmQGQ+ATSl3jM2XzsfHvagwjRvi8xieRpDMBOV8RXP0Ljb?=
 =?us-ascii?Q?QKNtM0/fyrtIq8Cb7VH4UgwHHu0H1CouTqGgEpb2ABmZU1rIsRedFI68dIZj?=
 =?us-ascii?Q?8XHTtJlAhnzgTpGn/QiC8JC6EoiFNk2My3bI7o8cn17XRW9GQZHJx5ibg2fN?=
 =?us-ascii?Q?DszyEweB36RPhBbRRvQBM8YuZSispUU6BUOwB9PDnrgAO0LalIYJ8hXmqvXk?=
 =?us-ascii?Q?hjXPnR/wWp0lsQo3FYE9Dl3/D/CwdZ17oWyVh45EolUGGofMkeTXmRB6F2q/?=
 =?us-ascii?Q?ElxyQz0FObVLBHUef0v8ecYGb1cT9OE5MLInqa5F2csQQQI4eoxxh00LYCkx?=
 =?us-ascii?Q?WLFm8BvCbu1p/VD6xdQkfoopCVqnbE1GoNLYnfXj/IDLCPqTJPZYIU1esNLL?=
 =?us-ascii?Q?BUs2OgLr8WbQxj2D9Bjm5sAK7lVN+NkNeSKtiCUcAVOU3V7ujJwmuuTOhd6c?=
 =?us-ascii?Q?mAD5ri1boxy2c4s2g8mp1KHIndDh9KUwkWgz6julkFquziVP4tuxiyHUcMPM?=
 =?us-ascii?Q?K4mCIdzWeY291+HTMqb3xj7ts8A1ueqDavR2QaxKSowSm4wOV8Fmr0qCG1Px?=
 =?us-ascii?Q?jaLnDANmxgH4IHVGS2TAOpn5QWxrJ4X/mQm1Y4v1yYy9XV8q3WuEEpoESXgZ?=
 =?us-ascii?Q?Lj8G2pQPSRCMAQCzM7RZJGIE98vX2PJOUAqp2LLHKikXnMF79djtzE+++vih?=
 =?us-ascii?Q?StXJ9khEf8eY5pSp4oUUKnAEtjw8gBFuuBO3PksOKOmZgeFV7WSmK9Xjo6P1?=
X-MS-Exchange-AntiSpam-MessageData-1: QkpYo9Sfnlk2WA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5baf2d4-ca83-4239-c64e-08df12cb80dd
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:48:56.1887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+PR1poyOQRpuxTYBPwHpJgZssvlpX50bYovTl85vaWjLNrSeuPfsHIiKogoD4pmvD133olxBdx1WxWiFtMeb25F9/1KKb9PfLizppIlJda5+jv8NXMEIdK3LYV7Hla/n2HqjgNGS/FzTHd37Sv5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9328
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15:c];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.69.16:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.69.16:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:102:4ab::13:received];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 98F4F45336
X-Spamd-Bar: ---
Message-ID-Hash: RFX3TIG43M6C2FN35GJMR72V2RQEZ7EQ
X-Message-ID-Hash: RFX3TIG43M6C2FN35GJMR72V2RQEZ7EQ
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RFX3TIG43M6C2FN35GJMR72V2RQEZ7EQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

On RISC-V there is no SMC Calling Convention: OP-TEE runs in a domain
isolated by the M-mode firmware and is reached through the RISC-V
Platform Management Interface (RPMI), carried on an SBI Message Proxy
(MPXY) channel.

Add the skeleton of an RPMI ABI next to the SMC and FF-A ABIs so that
the build plumbing is in place: an OPTEE_RPMI_ABI option, built when the
MPXY mailbox driver is enabled, rpmi_abi.c and its registration from the
driver core. The transport itself is not implemented yet, so
optee_rpmi_abi_register() fails with -EOPNOTSUPP and the driver keeps
probing through its other ABIs only.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
 drivers/tee/optee/Kconfig         |  8 ++++++++
 drivers/tee/optee/Makefile        |  1 +
 drivers/tee/optee/core.c          |  8 ++++++--
 drivers/tee/optee/optee_private.h | 13 +++++++++++++
 drivers/tee/optee/rpmi_abi.c      | 23 +++++++++++++++++++++++
 5 files changed, 51 insertions(+), 2 deletions(-)
 create mode 100644 drivers/tee/optee/rpmi_abi.c

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 50d2051f7f20..0eaedb34673d 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -9,6 +9,14 @@ config OPTEE
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
 
+config OPTEE_RPMI_ABI
+	bool
+	depends on OPTEE && RISCV_SBI_MPXY_MBOX
+	default y
+	help
+	  Reach OP-TEE through the RISC-V Platform Management Interface
+	  (RPMI) carried on an SBI Message Proxy (MPXY) channel.
+
 config OPTEE_INSECURE_LOAD_IMAGE
 	bool "Load OP-TEE image as firmware"
 	default n
diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 183cdde1ac04..a588f6f4cb2f 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -9,6 +9,7 @@ optee-objs += supp.o
 optee-objs += device.o
 optee-$(CONFIG_HAVE_ARM_SMCCC) += smc_abi.o
 optee-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_abi.o
+optee-$(CONFIG_OPTEE_RPMI_ABI) += rpmi_abi.o
 
 # for tracing framework to find optee_trace.h
 CFLAGS_smc_abi.o := -I$(src)
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a52c1f498b99..42a8bcab0cb8 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -220,6 +220,7 @@ void optee_remove_common(struct optee *optee)
 
 static int smc_abi_rc;
 static int ffa_abi_rc;
+static int rpmi_abi_rc;
 static bool intf_is_regged;
 
 static int __init optee_core_init(void)
@@ -245,9 +246,10 @@ static int __init optee_core_init(void)
 
 	smc_abi_rc = optee_smc_abi_register();
 	ffa_abi_rc = optee_ffa_abi_register();
+	rpmi_abi_rc = optee_rpmi_abi_register();
 
-	/* If both failed there's no point with this module */
-	if (smc_abi_rc && ffa_abi_rc) {
+	/* If all failed there's no point with this module */
+	if (smc_abi_rc && ffa_abi_rc && rpmi_abi_rc) {
 		if (IS_REACHABLE(CONFIG_RPMB)) {
 			rpmb_interface_unregister(&rpmb_class_intf);
 			intf_is_regged = false;
@@ -268,6 +270,8 @@ static void __exit optee_core_exit(void)
 
 	if (!smc_abi_rc)
 		optee_smc_abi_unregister();
+	if (!rpmi_abi_rc)
+		optee_rpmi_abi_unregister();
 	if (!ffa_abi_rc)
 		optee_ffa_abi_unregister();
 }
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 94a4f251f5cf..5b57d69f1f34 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -463,5 +463,18 @@ static inline void optee_ffa_abi_unregister(void)
 {
 }
 #endif
+#if IS_ENABLED(CONFIG_OPTEE_RPMI_ABI)
+int optee_rpmi_abi_register(void);
+void optee_rpmi_abi_unregister(void);
+#else
+static inline int optee_rpmi_abi_register(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void optee_rpmi_abi_unregister(void)
+{
+}
+#endif
 
 #endif /*OPTEE_PRIVATE_H*/
diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
new file mode 100644
index 000000000000..01d08892eb55
--- /dev/null
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2026 NXP
+ *
+ * OP-TEE ABI over the RISC-V Platform Management Interface (RPMI),
+ * carried on an SBI Message Proxy (MPXY) channel.
+ *
+ * This is a placeholder: the transport is not implemented yet, so the
+ * ABI never registers and the driver only probes through its other ABIs.
+ */
+
+#include <linux/errno.h>
+
+#include "optee_private.h"
+
+int optee_rpmi_abi_register(void)
+{
+	return -EOPNOTSUPP;
+}
+
+void optee_rpmi_abi_unregister(void)
+{
+}
-- 
2.34.1

