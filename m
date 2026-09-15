Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C422C88E72
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:49:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3B8B945336
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:49:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=sY9tE7Ok;
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 687D0453A1
	for <op-tee@lists.trustedfirmware.org>; Tue, 15 Sep 2026 01:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFAv8P9kaDHyrXmUdJeHON9GFB+t5tUJbpcZXepJeJ5vJJZnuv1T8XxnDAMZyhBO1bCKgn3BPRIHD3+rdVyO3hoPWP0AKB6dEAI/LtDLMdrWcelhdwKD948A3ltxn6UTNOQiHAZXz3TJtN1fC3nRHiK1CIPC8/JWg0ZtpiAyUZ8YOpSomJLf6pMjrCWrNDwb7gTsAoXWFKBEaqn1vhoNKt8bgWvfIzthysyar04qqzb4jReka1vevK0rjV+J2cLTKxr/n2fSa+LvEEkZblWVPz9RTFuSMkPe/hd0FzQmG/DoT5wsrMD9CaO4oWCYP1vVFUeXTyKv4B7UFmUilAyUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0f2kImy79XdzkWqzYewyPlMjrVEugN4L/1jbsy+woo=;
 b=KVg2QyqXwfkiFw8kXyZc/1f4OO4YqTMJZp5+7aVpC8JEi6utM/UZEjfHjanFq52Kg3yZtFrwXwxE3behg+KJm6KJlMQypDj/sZIo5aGsxDl2qMfRGCItLr4HUQNmhHk9PxfRKXBEAV+GXodqjHjb97c6ZVmu2h2208KC6tkxdxpXm1Maswhb/M8mHNywFBGAI1M2+kWR4zfLd+YiR4GqzUYX+KOjNy1+lpSFUH0ThHLosMMuzX9HjtaUtC6v2ULp3v/pUxeJ9eUrrfVt7DXhghLeCmwrmtsIL4hZwDXPREPcYpBXrEGWHb1r754mtI4NiG6vg0ykUtzUdFOE6jGuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0f2kImy79XdzkWqzYewyPlMjrVEugN4L/1jbsy+woo=;
 b=sY9tE7OkUvj6t8NXD1aFQDUgEXqJEWRso5qyTiI+poqBg+Wwg47XPKR9Ervayo64ehwu1ZspeWVbE4N/fhPkf0fOq/oFii0eiVCdwHuO5XWrrbIOSZ7h1Cgw87rLEmDZ/RctFttEM682mAAjC6+i9KKo6NlG8qO7vPcN+mO4d2ucT6om39uFaRxE51i58YJt/c0Pv7+keEsEedRbQPQ9mzg4FcgiNbQEB3+kzzvLsOu3XMETuTUI4r3zsOF+JhqSkagfxBY50RYXCgVSw7NZcFALnIfin14TV5/KTgmHJ8NNV6Qc8Ixb5Zc487GZMVhpYfLdbeyP6AiahnRRZ6JPSA==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:48:49 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:48:49 +0000
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
Subject: [PATCH v2] tee: optee: build the Arm-specific code only on Arm
Date: Tue, 15 Sep 2026 04:02:33 +0200
Message-Id: <20260915020235.507302-2-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
References: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::11) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|PAXPR04MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a419fa-fd89-48e3-4bb8-08df12cb7d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 
	VEKK1+OF9A0hGJya/Sx+4UR984Pg0se7SJ13Dyu9H+bwUsG4LvY0DI4UeHVCoT0t7ZuOe1tw9DvF5flfjM03/TgzKxGGpCgyxZ/6+8BezXCCk7lgSKG+S2okL3cKV6Wlh0c4MV+/yuHi4fw0possPa2W5njNnRk8G6bJaqFy0qU0CLUrwrRdZE16jIuRsHMcfVBkz3FrgZCPA8q99gvQPROMkqQGsn6yM9Yz6/sO4eYzuwboJdggP1fLQOaf/3crTJR/kG5TwGBJN+FfW0p3iuKGEA7qdBvyIJ0+37SGhHaMXluKseRk13OQOeGgKYVyb0FF4gVuJ61PBN6SWWUpnC4GB6SPiblPRKIUNatL+L5DwzTUXJ9t4Y31MzItEGt5/m0KhTzNvwSb/znhblxFwKeWEXJ+tseM6h4G2Rhye2dL1xTe7AB5KEJQ6IC/ROZZk2szg84C+8LZ7v9R/RAj471ArNESvZIf63EYoRXR2ce6jUzI9NYvWAC9p3Xc1MavH2wasSlB4pzCAFO90pMTb4cKlm6d2olgjXJtn0vRZV+bVPUheWhsNPxB5jko6snmJfg/vpen+uaRAj0RktMTkaeIuNFmSB+GqJm27Ndy/mQpTyS+9lJgxwWlNvYBl9BguXeh+Af3HTvO1NYy0fh1k2wPGyJ1LNchP8FtNdsQg4A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ERtFWpBI/rA3EH1NswWqq10DBQenhO3FBekmNMeOVaAXQEM8jrtocgKlNITa?=
 =?us-ascii?Q?yDYqhaYC8iRg0oIaSb70Xst9WcRgzQ4yXMzHhuyyRJDz3n3OquOy+gPr5pg0?=
 =?us-ascii?Q?4ww+dqrccxJ1kRk89T4FsqyU33Jdht8LNLJpG8TMdGZEGXSPRVgGaPl4fy09?=
 =?us-ascii?Q?ObJtCp/E9eXkI0PPJN/vYCkLW2f52j61+fc4LPZZjFQaEuNVjyXwyKigpcJW?=
 =?us-ascii?Q?o/he4/bkeWbD89WhhGbo6K3d1r8h9yjxcaEdipJCUaVue06ntrFmsOEZrQrE?=
 =?us-ascii?Q?w4RYhPyQCBiOy3eR7f1eucePM9NP6w/zsE8MTOu8inzAE9MTe3o2kK7z6hew?=
 =?us-ascii?Q?l5WBYvm7frtWlKOG0KtS0F860/my50eaPj2Jc1i/EWzqURR04OENuyMu5bLO?=
 =?us-ascii?Q?0lZFZpnqS5eZ/fkQjg6xLtzBXq0JqMkL0S3qRLOZGc3FAkG44xXSZuj9QYkS?=
 =?us-ascii?Q?EaVRiEPs4Rsw5ZJEJOI58ZjBPOFWes48Smd10kHMhGXRG9IdCORv27BOT+od?=
 =?us-ascii?Q?gmUR5xQhnPynju+CcuvhVfSLc0c5L+/329XYiaRoGyl10WEE8xzDTiuxuCt8?=
 =?us-ascii?Q?CPZoq+RhThSQaQZ1geundlb2sEWSzfQit62sFhzXF7wsEyWggnvHkZHS4JMn?=
 =?us-ascii?Q?cpalX8cAd9oleFfEQdA0NXxwYT47CB3n+wpJzlZnFeRhekcGv5gwARYqvkJO?=
 =?us-ascii?Q?8JkHpY/RFAa6bRsiHOy2HViDfQniRvaAShAUPWDeBqfsPauRJ3A6CqfI1QWY?=
 =?us-ascii?Q?mlLyEVWv+EajdOspaxiUMY3ZP7Inz9E7LeCJddZTlSU2kudrwrhu3kwnZqta?=
 =?us-ascii?Q?YCVrUaAsm3V0JzwQM/L0NmB9/f+sQPIdlBKadhiDWxBQ2PNTao5tOLH8n/3q?=
 =?us-ascii?Q?kS89OycvgCIMT/Hjhp+dJfCs6sZ5D0O0bB8x8PnwdLyrWQSbOW2KHao9g8xK?=
 =?us-ascii?Q?0VfoqJtLnczdOMunzMnTj0FYUbHBLRAL9pAnYy4et84FYiSoDFZEfQ5BUnyN?=
 =?us-ascii?Q?cBbs/L2mPXxEpdrWmektjv73adsftGE48lMo4wXpvjSD0duxaDPzYxCxUgJr?=
 =?us-ascii?Q?6E5NgAgVOh49FN+1cBS4adkEXZPFOmFp18ocebk/uipMzzbuchtXFo9nCavV?=
 =?us-ascii?Q?EcYfUB5oW8X8FNhtT2VdPLE1ubGb5N3AdV7YVeER6h2GUXHZjni4I47RwtEr?=
 =?us-ascii?Q?3Lq/3wL5U2ieFxfPQE36KS9KmUqDGAAICQR9odTdYPuzGIaZ0FaUVglbU8DD?=
 =?us-ascii?Q?yyMpymAHlwABe/1x8m2EiXdp/cyodwlwTRylwWik5O6y7D1fTqfO9LRfVVvt?=
 =?us-ascii?Q?mHf3xAjKAC69AC86BnKikQ5IZtqb+zP2WmVFi+s86M0VeWy6wALLoCQahm0z?=
 =?us-ascii?Q?8UkD40gFxH6K9ros6PuFnlAoo4+MUzKj60B5qnxuFpYMt4WRKEBkpqBHFHh+?=
 =?us-ascii?Q?1K9xgQzPzV5OjIGgXl3mt3PC6n4xxQ+haKXA8EoMeVo9DvoOftUOGq8MOh47?=
 =?us-ascii?Q?c0E3daL2PFH+XiwXfxWt5KeRHQMLp88Uiy609Kpibjmopz1XAO4jqMkKhgwp?=
 =?us-ascii?Q?NaNMY0Q5cAK7gn4zkM6xat/0RyTnIzhIqBM1aCB8FJ/DJpIvRCJNAF3Fr0/8?=
 =?us-ascii?Q?AMg/NCUSXaQ9E2IlauEgcOHhm8Gy87u2bbupaPiYwAisSsk+Zt4lHR8Shffy?=
 =?us-ascii?Q?S21J8lryfjHG0vI651/T7yEVjNISeLzPwRL2MN02V+ie+/5itjqWb8cpVqdR?=
 =?us-ascii?Q?DLpJmlYubBVrIlYKnEY70lLj/GcQNQ/kT+Cyus3Nhn1aL28iqOHwBNPEzE0N?=
X-MS-Exchange-AntiSpam-MessageData-1: FfC+R90vUD0J9Q==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a419fa-fd89-48e3-4bb8-08df12cb7d28
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:48:49.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVOwZ0MpMaVBROsVrPaJXEwB+0K8wcPz6uNP5q1lcrFw4BQkga2euVX8Qj+B+VlIKFn1zbYI9lMG5wG8z4mCygPbnFgKAq2t0xdBe9ROz955cSLPabDlB5YbuZf+YF1HhnysH7m5oFklv7v6kmQ68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9328
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.162.29:from];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:102:4ab::13:received];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 687D0453A1
X-Spamd-Bar: ---
Message-ID-Hash: 5MTTTKC3N4QYLB2JLK2MBQW4IBBIIUVF
X-Message-ID-Hash: 5MTTTKC3N4QYLB2JLK2MBQW4IBBIIUVF
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5MTTTKC3N4QYLB2JLK2MBQW4IBBIIUVF/>
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
-- 
2.34.1

