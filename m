Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BB9C88E72
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:42:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8967B434BE
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:42:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=l7mU8uCv;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013062.outbound.protection.outlook.com [40.107.159.62])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1680A45485
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Sep 2026 17:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt1teKoqomw1tx/yb85M8FX5ASEk+4McQW30UPxKU5Cae1TILayO78FmpUWYbhQOBgk4vPR4eVH4nocNFiF0Ld25oByO2UZrxgJmvt8f0+wR3BHz+QEd2WgcR0P5ex6cZJeBPcBAepWdOQiXa9wyu4HpAADA/493+BHnP9IGjTEoqI9Kper3uXIK2DPebZiBjR9pRmBhoLkpwFwCRP78bLgTkcxZOBpJFUT326ixhtImgbym9oG4hT5eDOUZOf7WNU4GcucaCugQiWFKqKxFrTRT3xBT7XxizLvNBHEtrjb8npNj2wjlhWOAdrJ9lGBEQWHHG9hoqhdy63lNg/47Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHwbhE4/ZGLke62Z6OYS1gyBg5z/6dLCqULsdDSOcKg=;
 b=ExiNU/m+k60n26BfZwmAevGPAXdKH8xrrChZMd4/kTHasH2oK4ZIMWpElISxKfEZsKdjU3gazmBSk2Oyl4W5vKNDCwvtGBcGezH+nPhU6YGbBi6ATc7eQKNyNzrPJmpAcr3MKukt/DzF1MT60LwoMvhpiQnv/HvuZIOwMPy/rWjIhlsaFnuyC3+p99Qxn7t4hInDChOqbE5uP8tbIW6XEt01jVl9f51qOcsiu9dkfO51RTD5qYoztntJeNJaZCPo2nGATRDokFTkpnpVXsp5j/PFBclngW2cnju1G8YJAgvFJv2Or0r0vQb/LNt4zkfU31QPV0oHJoFU0PTQ4AYRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHwbhE4/ZGLke62Z6OYS1gyBg5z/6dLCqULsdDSOcKg=;
 b=l7mU8uCvGcVxVIoDf48MY5jZC+kB4ZqH/5RQguINUhQJTZvCVvxavIp7gONkwYITH57TgqatmY0Z73lSwwAyjWsDJWBSjNwAUZ2NJMBcM9p0gjXBQvGxmPlkuRkSuogi9Ewpf9zF2dHCoJi5Pb/LkrmHWv0+4+MSFwR+1ovA0i6EdKGEo2PDuohk0XfSJOK0aoor9m+AzvhM8mZOq5IeH6WEHUJv6V1wjjrWsHQUVyxMC8TdkhEF9iatVE2iflXI7KkNziRcJOw/QNT3bZZsVAwQJHI387GPh3qQRnlgdjyKKuhIjhS8vkJCp/IEro1mYyrn7trFESArY7hp/VWhpA==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by MMZPR04MB447860.eurprd04.prod.outlook.com
 (2603:10a6:190:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:41:00 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 17:41:00 +0000
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
Subject: [PATCH 3/3] tee: optee: allow enabling the driver on RISC-V
Date: Mon, 14 Sep 2026 19:54:35 +0200
Message-Id: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914175435.118303-1-marouene.boubakri@oss.nxp.com>
References: <20260914175435.118303-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::13) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|MMZPR04MB447860:EE_
X-MS-Office365-Filtering-Correlation-Id: 030bf28d-6d93-4acf-d6a0-08df12875725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|56012099006|6133799003|5023799004|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	sHLQaoLfveG6j/3h+BoNWJNauUhB4o7aIK4r9iW56qpjLpSpp1azle8JprQ4O1XQPjiNOC9s3p5f/1PGHsLbtWN6ocZarRHtuWW6/ZGrtjDBTGPVk/IZ5kdHRzEdMxTPe60aKDmZWwRCOQJ6N9nFuQG32xMdKhbf2f5xPcYS6uUPEXOutQ9GJoSHoXZYYGbwShXxeZ691eQ4NFn+wsDMofgwcQWQltcU0SuEa7VWM8n/bwa3UsqJeivCS94i7mwAZAYjYvhKcPyYfAnThdq2qsVtX/qE6DE3NFIZzjududCJXtyg11rP2nAwDM9lbmzUZeWFkya/XT+pKR99F2ZoaMc0EEIR7cg2Dkhaky8p8E/ZeEeHALZ676qMBrBALc1solFxRyLRo0aLO1le71z2l9o43E7hUmvJlrKROZcVcSfnco5GrJq9G4+StgJ5pc9Iq2V4Z03Mh9qYf3m2xzjWdlI11gu/OBqyvWCdZdrsxeKsbyiao2Z3ylyhN3RnJfDLNoJ0WDPhEj4sDwC7ioW2tU0WyQTr8dCD7uEJ3dIcNf2irF+CRmcUdeY2mruB0jdNiuZIsm6n3NwukArraeq2OaxnQET/XWe8HRArPgTBKqazZwJFDGpAumpe3+nRc+Fn583NHLq/q7gkXXJRYS5n309WZueDOVoACh5v77AJ5zc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(56012099006)(6133799003)(5023799004)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gtvq80yq+GNQg5YrGAqbwnTn3uhQhoAyToZPlZ7UQ81ux0MJo3qtr8Wn0ZSj?=
 =?us-ascii?Q?dpx6x6XB2wETf2RcooSNSaqyxy/8IgnVpS2FP67GsmmBz89SSTntS0bdtNlr?=
 =?us-ascii?Q?Yu4JkVkQ0lYlSDRQoTxl8O6dHFZzC59L89guiQhM0v/nDuN+vISLqV9IR9IS?=
 =?us-ascii?Q?iZqMhxWZoCTqL3K0MC65rN2SFKTXNHX6Ayol3igL4+rudfYPSnnU2MnDTkSo?=
 =?us-ascii?Q?3p0PtQlL9I46L2nmxkteDOabGFqvhujAyXY5La13At8kcLCpCdkQmb20N8fc?=
 =?us-ascii?Q?BCc+xb2VEe0i3qaboJslXYlnDXtP84G+wgEldTpnoYaNJ4gf6tAEU4Ocoyt3?=
 =?us-ascii?Q?V3P/eNmDSCq/saKvcMBXDnMWQRXFp+9nFKz6MD7/NQaTDYx9SZm1l0faRnPc?=
 =?us-ascii?Q?lasQImgiDSWWjkObI76SFKWUV7SsRtFNwFVMROHEArbWxq8z/VTQrhz+aZ8C?=
 =?us-ascii?Q?MdzjuBV7SvtewzdlgqS80x/riGnCVfhNu3QasVbY3Nh4zP+/mpv/7TrWyoXf?=
 =?us-ascii?Q?1oH34pcN1Uf8O8FeqgWr0ubVFm55T9qU7q1VXjCQL5DiIQ3moKRlibILhfln?=
 =?us-ascii?Q?Jdjna9iiaWCjHSeDi98O10g23iSWUTKDmBszNiwk+G/1aUNQfV4qJ1Q9BU3n?=
 =?us-ascii?Q?Rhxq//eRF2+YNgL22if55XVVSXckbALwrygOPx/gdjlLlhaApFkxrPnV3cX6?=
 =?us-ascii?Q?edu3SXtC7YHs56UAS7zXPk+o9goaftGS+Id/YyvDC50OMCJyT6Anr5ghUMLC?=
 =?us-ascii?Q?lbCVbF7BRI8vNJA6knpHeHCw1KCIFt568aiWfKFjqafZKhaiCI7Pd9gWXLrt?=
 =?us-ascii?Q?HB2AAMaUrRwg+58MVmrSVCE3j4xwh+EFs3YczjmpskKqs6cXOpp3DE6vF0zt?=
 =?us-ascii?Q?RxLRySD9oBK0Eu2ao18s9uF+vstsWMnSvXR7K74byFQoolAWNx3xdLOtvytA?=
 =?us-ascii?Q?1iMZsjoVnvBwhlUFnGE3VuprRh6+J6txs5WLVm79s7cRYi7ji28nKMjMXv7j?=
 =?us-ascii?Q?wlLPJeMGGC25DyFS7/o8dEVrwzc57zWmN15yO2/bMBbQV4JPup7CrT3O/Z0B?=
 =?us-ascii?Q?A7mvqCTxTcjUXM8bpEmIE/QOpWzKatIDxDbVcNGSuG2QsFocSUYfrQczlEPl?=
 =?us-ascii?Q?oSm9uOm8cD0ZOS9eQ7ihFFLHZxJLng0Kq8e7FLnGO6KtRLe6XPzeq1vWPu3E?=
 =?us-ascii?Q?Ifrkn/hh3K2MREiFt+m4fWJdII7AjWPstyfOzUkl3QxyRlvjW6tQrh8U/Ac9?=
 =?us-ascii?Q?knH5HjyIfjYft3vyfqfTbApdW0FQ66McU8zBGldFwNlOlIBTy1UO33wzXThu?=
 =?us-ascii?Q?x7Z3nHp4jyw8uyyFQx0wG9mutcDc22EChAbYnlHRcwCztk14ESuiDbXYl5iF?=
 =?us-ascii?Q?QTKuRFqd6KpKu/NaW4JiC4kVd3wlsiPt+m3rsNX/PHUoR8OMOzb7Y2DcLq8a?=
 =?us-ascii?Q?Kr0Pj97ySmYCSgCGFKLZkJxOWvvP2jRWdMmDZC47BnykRk3+TVM2UWbnjrnA?=
 =?us-ascii?Q?fagoQHUP2pR4cO7q4xDuEnxg3/j6k2LpHhp59Yhwq0iYAYfxFHB6EC2fs00Z?=
 =?us-ascii?Q?KtojyhLm2rQ6F3YWtvgr0tT4GOV+QIRZbxA+/rfP7KaL2K2L7GTjbx0vtdqj?=
 =?us-ascii?Q?9a1q5qwaCPIiHDh0Pk2tVG45BuaPuebKDnKyJB71mGc437YLVQVxeQ/t2CTF?=
 =?us-ascii?Q?RHM+O8Geo2dKgSe/fLhtGxNOAPeLsnQM3d8BnvxMU//6Apt9qOSrcF+WCQJY?=
 =?us-ascii?Q?hxmM+5NPXJk8ZwNKI5+gHNVgKZOtwpr3WOWjGznED8FCuruhG3LB6F14TGcr?=
X-MS-Exchange-AntiSpam-MessageData-1: XseSy93bIZMmWw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030bf28d-6d93-4acf-d6a0-08df12875725
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:41:00.2844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDy9p4I/fyTEdUFLX1u2K+68ukBASSwoLhu76YBqAcVVmLIS184+o7klyscvscl3i3kOiLAOaBo/FD/t40y2icbx7lHkKftvuzAHNzCII9Bc6TNulvNW+2rPqolgKVK2gvECfqfgaGKh/OL9kuwZkA==
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.62:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.159.62:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[nxp.com:email,oss.nxp.com:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,OSPPR02CU001.outbound.protection.outlook.com:helo,mail-norwayeastazon11013062.outbound.protection.outlook.com:rdns];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1680A45485
X-Spamd-Bar: ---
Message-ID-Hash: V3CDHLAPDW35YYMZG627V2634IYQA363
X-Message-ID-Hash: V3CDHLAPDW35YYMZG627V2634IYQA363
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/V3CDHLAPDW35YYMZG627V2634IYQA363/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

The TEE subsystem and the OP-TEE driver depend on HAVE_ARM_SMCCC, so
neither can be enabled on RISC-V, where OP-TEE is reached through the
RISC-V Platform Management Interface (RPMI) over an SBI Message Proxy
(MPXY) channel instead of the SMC Calling Convention.

Now that the Arm-specific code of the driver is only built on Arm and
the driver has an RPMI ABI, let TEE and OPTEE be enabled when the SBI
MPXY mailbox driver is.

optee_check_mem_type() only lets normal cacheable memory be registered
with OP-TEE, since OP-TEE maps registered pages as such and must not
observe mismatched memory attributes, and it only knows the Arm page
attributes. On RISC-V the memory type of a mapping is encoded in the
Svpbmt bits of the PTE (or their T-Head equivalent selected at runtime
by the _PAGE_MTMASK alternative): normal cacheable memory (PMA) has them
cleared, pgprot_writecombine() and pgprot_noncached() set them. Without
Svpbmt the memory type is defined by the PMAs alone, _PAGE_MTMASK is
empty and every mapping passes the check, as there is nothing else to
inspect.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
 drivers/tee/Kconfig       | 2 +-
 drivers/tee/optee/Kconfig | 2 +-
 drivers/tee/optee/call.c  | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 98c3ad083940..6434204d899e 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -2,7 +2,7 @@
 # Generic Trusted Execution Environment Configuration
 menuconfig TEE
 	tristate "Trusted Execution Environment support"
-	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD
+	depends on HAVE_ARM_SMCCC || COMPILE_TEST || CPU_SUP_AMD || RISCV_SBI_MPXY_MBOX
 	select CRYPTO_LIB_SHA1
 	select DMA_SHARED_BUFFER
 	select GENERIC_ALLOCATOR
diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 0eaedb34673d..8998b64df5c7 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -2,7 +2,7 @@
 # OP-TEE Trusted Execution Environment Configuration
 config OPTEE
 	tristate "OP-TEE"
-	depends on HAVE_ARM_SMCCC
+	depends on HAVE_ARM_SMCCC || RISCV_SBI_MPXY_MBOX
 	depends on MMU
 	depends on RPMB || !RPMB
 	help
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index e046aff61828..c29bff224848 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -604,6 +604,14 @@ static bool is_normal_memory(pgprot_t p)
 #elif defined(CONFIG_ARM64)
 	return ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL)) ||
 	       ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED));
+#elif defined(CONFIG_RISCV)
+	/*
+	 * Svpbmt, or the T-Head equivalent, encodes non-cacheable and I/O
+	 * memory in the memory type bits of the PTE, normal cacheable memory
+	 * (PMA) has them cleared. Without Svpbmt the memory type only comes
+	 * from the PMAs, the mask is empty and all mappings pass the check.
+	 */
+	return !(pgprot_val(p) & _PAGE_MTMASK);
 #else
 #error "Unsupported architecture"
 #endif
-- 
2.43.0

