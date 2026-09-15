Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F3AC88E75
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:50:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 48BF5450DD
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:50:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oKsAruqa;
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E5C2B45486
	for <op-tee@lists.trustedfirmware.org>; Tue, 15 Sep 2026 01:49:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPViwBjm1QJFsR3RY5d89rYnFs+vrjXrgcmoigNHkYKwmieg9CmLAqC2lEo1P9aklz5spelIPGYRsV+/JyXX1QAEF3/CTYI4tufjA37WgWabZwTwTyLujITxfIjRdoQ8WYR2zh//eNA35VipjA71PH/zUX9n5z0aH9xE3zv90ToX2Ncod55fFK9YU2PqIi3uZSNky0wgUNjv8fdehrJHCRqrtF2i/NxHQImf2M0eCvW+JitKgQyKHzVHAIfTA/eYb54A46S/V+0C+dYLVhBlNY4JDJxoD6iBQ0zHB7sjy9XKXTyrGQGTJnVmd4g+yo39kHY9B1fNS+H9wLN4lIGSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPO4xC9qAIS7YTUlOl988/fO01LUxpA2uRljEFGJHN8=;
 b=dpYAxJFMVQ0fACY/7gPHHJhnJkIMSTbHvgnTTma2IndZ6DXjTPdFiUaGWZBwSF0NZIEM+rfBXiJaD0TXcBStse0v76ZEOGtQmYauCT5Kn/Pby4ZRcykDQhadSM5b4AaPBeXncOa2NAiAI9cL0Pi60xi14SY+BvxcligLnEm8+whZ1Lq8sSLQc205QMYJ5tSG0AreRLNGcj4OwC2LIny2QMdzTP9kgX3F4ltgGsCwcsY60nTIQZAxAzJKUNz6y5K6GGB0YF95tPaVKLCc1prjaDPN712LqiLTVNTqk2H/xyqNKm0IwUzy4Rs6Mp1UaOqt8xg+stMhmOvsYyUB76EDpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPO4xC9qAIS7YTUlOl988/fO01LUxpA2uRljEFGJHN8=;
 b=oKsAruqaPXQlvABO3+XofymmCPCApmC3Axty7DUyXe4EH4I9y2EH7OgrUfBU72cY2AbiEPnoLJgQT1FM06n2mRPmKxM9k0WCB1zUz15OosRmScoddhrPSj9X4caj6wdLfFzw2C9m4KRdR5wfZOncNpAYaO/FXt6s5DUuw2LafHMGFlKPueoy3QBapY/XYQW4Kr+ge2jXteZmOF37pPYopTdhmvLb1vTRonnn30R+frfpMFuKM05pub5OWRMQqGCc5Ry8PUNAxNY4bKn0h5rJ3rSPhv4D0I6nNGxz0LgQc6geGmOaQ1pUt/dAB+giZ4OGlqy1eXsTzszFi38y1hlxaw==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by GV2PR04MB11737.eurprd04.prod.outlook.com
 (2603:10a6:150:2d5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:49:02 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:49:02 +0000
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
Subject: [PATCH v2] tee: optee: allow enabling the driver on RISC-V
Date: Tue, 15 Sep 2026 04:02:35 +0200
Message-Id: <20260915020235.507302-4-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
References: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::22) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|GV2PR04MB11737:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c3f510-25b8-4d20-073e-08df12cb84a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 
	umq0WQROGX/fYNRZRcZ1kMPAFai3YXYhlnHHuAUfmDOZz1M+kHDLIlZE5aVKmnx4i845er40TlnhtfXLpfhbHucUPKEJ+XUzTrlYvx30BQpsWLVUcCR9nLT4bjknfUtzXq2BDjJa4esqr9fHFnMNc99scAPRc2SdE5F6vMcIM7WBpAb73/wNVdl9mKnxhtx8iOO4pxg3+YbsywEBzuJsN9zUPA8w4g0GsfIGVQjfG+8whoL5SPq+A7pRaeUNKok3gP8BdRV8xpwxI97WRA+pU++xKuY1DTSs0leh4UPp3aEDqh82MZ0dbpxXKqt5EMzyd2nvbVWptb6FGSfQWskjdB2aDZBmZThBW3nyGPHt8Vm1Fnm0lh5bkmyqjuGqZ4MhxpMAMKekv5rRuMpKS/VHYRwq8XMYUYVtSITebsH+8KsFz9y5c2PVQ4iSvgpD/KdlO/oSfm12eumn50HRhKF/Ef/PphjFvCyQnlN5tdVfe2ZIKFGMdVVurRl/mMKhzdfqC5ZvSxFIZhQ42Rd8U3jdL/oKIQlcdfuz13l/OdgzH+YCe6pAWPtP/oNeJ/oqAL/wVKRBw7j7t09UdWZ+4wE5ppskjo0GLLs89c4yPQoYruMz8JT+azkUeL4fmJ8BJQvrt2xzGWDwQvslIySSJWNe1J1Buzg6STCHre85NQqhYTE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DqKUN0G2eMgvsTPn9UK5VxxM1aIfhpqSmfhIMiBSjSTxNrRB+ShjQfQEWcfV?=
 =?us-ascii?Q?SKYWcKceaWwk3G4cNGcsMzDP/4eS5/oiyYfnz4C/GpjndZ/MEAqBHr3zNsN6?=
 =?us-ascii?Q?ME59QlYL30UQf+iTYuHcZ5e1qXOwyFmM5gDuIGDUMrayjtZe5QKs7/24G4TC?=
 =?us-ascii?Q?DP2DbUcuui6ZAlO+Slk19annOIMIWG6eTw8xG7sVn4udSMn7pdpNfg8nHedb?=
 =?us-ascii?Q?rxaZ4VxnmhD5LiVwVT7MEVZc4fsa1QneE80dZa3c0bqPkug5+spsoZsHESXc?=
 =?us-ascii?Q?YiOIBk1xYRFx0G0e37j6Q+VSehpwsa/2ztSCvEjRyZ1DTOaQN7qUBrMprD5C?=
 =?us-ascii?Q?Z3Eqh20x4pjNBYVg8MCDpe66zzldkdEz+EGx/64wf53Rx94sc9SnluwQJPzh?=
 =?us-ascii?Q?TUoGGylf1oz51QDFWf0k6EVFekyqkrUcubh1C+a+aEVtYjUeUD3owsQjBYwz?=
 =?us-ascii?Q?Y2ewfnZcLUZ6Xpbya9UW5dL4ax+l83mK6exG/hbbU8T5n4TLmhwEE5m8U5pS?=
 =?us-ascii?Q?LQWLelEdtAnZuT7utl6s9oxlgu2h0C0yu2j9etFvnq8hm6Kw4HeOwL08VYmW?=
 =?us-ascii?Q?hBOm+zCREjrELWCyrWAf8PmkBYXMX9p4hgVGpc1cEP4Wih5M+urHlboqIlyT?=
 =?us-ascii?Q?8P8oN5H+2e/RdwRZYVLi7b+v5+O7RMNW1cOoSZhbeQXwjRmqLJy0in1yQONh?=
 =?us-ascii?Q?c3Dk8cwezNePo0fP//LYlfIwUDrDU7cmx7IxMWPnX8pyksUjKJo6uy49JBm9?=
 =?us-ascii?Q?wOFJgXoIRzP47jZwrhTXM7CWhO1VhFCHX5PG7Hhe/SWx97F6iPTchoDu0LME?=
 =?us-ascii?Q?8F6p3JwwDZ2e1ewOcEpO5KE0nP2OAc5CHRG52eIKj5I3/GAKY5N0mLWhGwGf?=
 =?us-ascii?Q?dh7bjQ3r7zscZSAPhfro6OSKlYDoHfzkbL7DYme3h1b3OIpe0BSaVosr+ggP?=
 =?us-ascii?Q?3uynVmlfbKgOR17UADX+Nog5kRUN14T0hnbH5xDWRzeukTasOdi0CoXBdsKx?=
 =?us-ascii?Q?sXl/DHVI6qPvqyQSQy07yI1JonWMWjZRb4/cDQKbuy624MFerd6+F2GYitcr?=
 =?us-ascii?Q?EGO348Hf1FzWgnI4K34/AHu2ykiYLYv2Fshbriqp9BdRQh6hA/3FP1/NKrZh?=
 =?us-ascii?Q?A28T8QmHAKK2MtpJMmoq4sHawovAKk+dNPEUx0/45jBDZ/P67/A2qn86OnOX?=
 =?us-ascii?Q?24AlXipJMTIANVYWXYf/01rmOt4+EmfSKt+ggFsNBAgEV0VlOnQsWa8CaX5c?=
 =?us-ascii?Q?eXWhZr3VD+cuduqshIu0xbETfR9q5VlPebZFLxYRtX/iOnn/Phb7T58oeFhh?=
 =?us-ascii?Q?IgHYSt6sCT+I2YF84LZiHnAldR+VXYIUNQD0hjDrq4NE5GPU20iM5mikSbXZ?=
 =?us-ascii?Q?f4wqmS0PV9XM/nOCpZ7yN6ycokWponhg2VNNz3Qijk3JpVDC6AT5D81HYKW+?=
 =?us-ascii?Q?/VGt1v2deHqd/Q+vMu7+f2enkpVEmloE+4RX5J6Oyxykhk7ODRdie7La0FKC?=
 =?us-ascii?Q?4a9bp2wdZDerfPKtfb1s37yuQzJqCB72KC58eNrAmE8LFtAJqwbCm3WCWoXZ?=
 =?us-ascii?Q?gPdYeDORUmxXBYjE2Kw8Ek5cWItlrdmO/A7uoWHTCYp8HrSBAMUFm1t1oKXs?=
 =?us-ascii?Q?NIhB1rkl7w+2p3WbiknfIbOtWa5klV7/BQHXJ4DvmPG6mU90RlMa0Y0ajY9z?=
 =?us-ascii?Q?HhtvYxKsCT5Guky6SvOVKZWm0AaFpmqhqJA2esUackE89/s05fUtooVCJkz9?=
 =?us-ascii?Q?gKYc0Mg1ogGBcZtetKpP8XUNvoT31sHuXpT3zxkN2MeiUwxhjTAm6OLlFUGW?=
X-MS-Exchange-AntiSpam-MessageData-1: 68eKT9T4jLfAuw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c3f510-25b8-4d20-073e-08df12cb84a0
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:49:02.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuUTbCjy7t3eCH9qCi0wazcjPVfWFg7QA7AuDJgoR8xdTKWNk3vQpxr+vL1gaJ5eGjseLOl2kszCCZeJHE+KT7YmBDJTjw0ebFZ4RXD3gXsSgHogKyUmJE25rHHr9d6t4E0Ipetm4juYYnF1p/5EbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11737
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.69.1:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.69.1:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:102:4ab::13:received];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E5C2B45486
X-Spamd-Bar: ---
Message-ID-Hash: 5GABV7WSVZQJ2DZCBVSMQI4RMWQYRKYL
X-Message-ID-Hash: 5GABV7WSVZQJ2DZCBVSMQI4RMWQYRKYL
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5GABV7WSVZQJ2DZCBVSMQI4RMWQYRKYL/>
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
2.34.1

