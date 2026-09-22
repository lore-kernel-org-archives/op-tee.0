Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655F9C982FF
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 13:03:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6A41E45341
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 13:03:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=O4wpmyNa;
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013023.outbound.protection.outlook.com [52.101.83.23])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1C58644F8E
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 13:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYD1gh/G+b+Lo3XObkME9DJngPLLqXIFFSAoAEWS8QZlPLhS1bMWSlQm+7acOqu594LRCu6n1cXGf3XNHbo+OknZ8jl+FJvMWctwmv1aOhB13Cxvyjz4b5+9doRObpL6+QXRBBcWYHIagzj8c1dKfnTAPpVZC1uyHDkIxZdUsIJ1yDEMqvhU0XZ89fO+CGijW4/fRTDGKebN3eCEvi4IyGLkj3KUO/1zwLr81cR3MA+Kp3q01hwnXmE5tMncpcIFDUain1doHpO9v+cxW9rm/zbINaX4awgCUkD5RXr+AInXYCZhm0Z8QWm9fm+0H3TmVCvpjWxeW9IIew/AqhoDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPwvHdjHOz5lzQ3j5uxX2ReO/ssTp+51DGYtcv6YZmE=;
 b=H4pnJOvJbunN96ZVXmOguRxcJf2/miwp8107EDaNHn+pnQ8VuykCDvAVZRuvmz/MiSsMXRzepHhDYXJLaHTk5WRSDJFSxJD4IyTEtPOse6a/QWPFiF3XOjx6Wjyx359fpd2zotnMrMB9Pw2dGEoQLlPJtiBPDDvcJvFZT260cTPDGe4KxwkL6vOVa4gEhqFjWtS+GEelVoNWfzTMYW46EP7VYKh6VN6Yxv5CsA2Ohf+YT8OfVJezpIPyCK38aa3keR5z7ShSsFFKu6/O2L1d/Pfc5LsVLEAr5Pu51ahWk8I2Q2g7FVmQFoU/6u8h4twHtrPyZg5oDlYRzfxPnFYtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPwvHdjHOz5lzQ3j5uxX2ReO/ssTp+51DGYtcv6YZmE=;
 b=O4wpmyNadsWt/O943HuWg2zRuUczA9sNkyh85Y6jsfFppFufLvJHYZuT5Gg4fRC0bmSDX/5OrCyJ0uFTRCrgg37sceHZP6KziHbxb2VEv18cToJo3PHxVrQtHWpXxh3UwegdIKgoKpAH4RgckHOz0dWexMzj+F0FQew1vfheqN4lDLisxs0PO2QHrUCdF1ad86V197l7yBufi0Y80z+2qej97eSu3t7cMOvx5V4tsAit/xKEz+CwDbIs5WBodnWQn8dOVimuKJMZir45yAWTOh3tZn2s3q7NDc3OIKiFkxymTUKmnJSF0PSOGGRJNuINQn3bH8NEb38o2rvS3WQaiw==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by PA1PR04MB10817.eurprd04.prod.outlook.com
 (2603:10a6:102:485::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 13:03:43 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 13:03:42 +0000
From: marouene.boubakri@oss.nxp.com
To: jenswi@kernel.org
Subject: [PATCH v3] tee: optee: build the Arm-specific code only on Arm
Date: Tue, 22 Sep 2026 15:17:35 +0200
Message-Id: <20260922131735.524635-1-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0107.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::13) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|PA1PR04MB10817:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b12fab1-4fd5-4b22-d1ec-08df18a9ed85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|5023799004|11063799006|56012099006|10067099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	3dPV/10Le/5H6XYrNwxP6BPk6uakwByoLY2VtLQDoGuWePCz9y5i63uDrpJowsuTwJvNl7eMuxXYX9CE9V99ipNzYuiJmze/Lj+OE4kBiUL6KrvdPt4WCWjtX4b52kfxF0hlB2CcOUFyFCg9V4jhKSnUTXh9GCYlmS6CBCoPqx7jUwHMKhVqhEJ4rhgxL2tDk4EORSNhB7iNNqAKM5Mc3QTu/4zFpxB1QZoM1psBQUV8yBSh/fGX/yTnsq4Aar1bt5kBRENe6DUM8+Few3wRaiTf2h+18mkaTfdMX7nM/pw8+WwzxId46vx5zgbVqUpvjTtevVh92Gdf8L2xO21sISl0NGFfLH3f+IAl86ErFGFNf+aHaEgs8mPi0XIXKwNvdjGPA1wmUWhjm75eHhOJc7m7vXnUPHARvG26ZlIbCQcNwqgv6UyR3XUGAgp7DppawDL72ioFkVaP3Rw9OQQv2I8nMVJiEfxxsRC1lkBnw56VmfLDjzjIInZM5Z+4EsJS4A/wlOK0uNYc/+bGBymn7Fei6txBtm3Ax5mx9sqT8JG+743+Nm6FCqkqcdwSnN8+qcS9JYhvG+ZgjiyP9eI3ctZ8KslFkq5VqfFrqrUoF4xgXHpZpIhyjdgj8vY76dcX1FKczI8Q9t7m8F3Cphy3V+3k6eqLAuDrrgZoZfwZsgU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(5023799004)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pOmOgx3ZQB8+Dav96PQdAslZ+wYeCmbqIEAQ7wYwQk60XP/ESjRxgA3Ko3YL?=
 =?us-ascii?Q?mF6m04r1CP9wqoAN4dUV/CFbuBrjMySWtysmtwqoW5boSmOcullx11gQB1zw?=
 =?us-ascii?Q?qIkizJM7VEfrhN+GAQxYUW2X6KIuyXZqEf/U6svgUq/v0XF2LL+j83xqg3b7?=
 =?us-ascii?Q?Cc+nz1xeOQxQlu3zT/4PRo2M9GLWhYXtFkGsW7XfSmsDMZ6qWg4/w3ZwNTJx?=
 =?us-ascii?Q?sIn5y/x3bG19xhhFwmaZzsQUhBDANqyzauAHeYC9d80JDFfCEtXrZrfy8w9k?=
 =?us-ascii?Q?X3+JeYssBqN1lIh+itMQqFxnmXbo5yt0+HiAMDOCzOeq9NSYWB5zOkYHI6HV?=
 =?us-ascii?Q?gLSNs8qe+cef+6esWWN6WG+a6DGA8bVfp7k4Tnffq13Nfr7aVsUoU8zF860J?=
 =?us-ascii?Q?hf2emyMXM9Gwwkd6/JZHXzqa65wcacHr7AwQ8yAWOHr6fytgaXoa+3JFlVc4?=
 =?us-ascii?Q?IoZ7YKPIkXEsOdqj5NOP7mmtJuLqrvUryYkfsuqZ4ZeajZ7TMTnbL3RUZiKY?=
 =?us-ascii?Q?ztqyGdr75itituno7qubYMLOzjwWgfMddLNFEdOU4zDYriHNanFJ96lLxHZh?=
 =?us-ascii?Q?QrCq7hbCkI/SpJi20LSajopvU3yHDTJV4qpxoYtiyRxHMGgpV6aYXhK4rdLk?=
 =?us-ascii?Q?1keCrgAPk/wHFCUCQZpk8q2R1PxcTdhUBJKmj38NrVkY8yF09svY3/k2Aq9E?=
 =?us-ascii?Q?pgY2i6HC+Na297o6puFP0DFDDb0zNpcCaB6N3qu51SdknV8pA5YmgH9/5WhY?=
 =?us-ascii?Q?sG0kiP/zFATh5nOkUShq5ObBLDRfVpOHRZzIaEPNIzFIM9EVKm7tPrE00CjQ?=
 =?us-ascii?Q?8bs1ySYwI1GORN1nqDEDmPIfv0RU0mKoPoiJdQaJV6uQ4+Iwco+N+WbgGQsO?=
 =?us-ascii?Q?O5gIba+ijCndxDVofjneYmyrl1CccOYrC0SY/JVDhuPhC29GHQZAcNGdtgQB?=
 =?us-ascii?Q?GXac6Ys0Oz6nmFjx1qzGxSOFOxX0XoqK85xPTmtTTdk3oEfGRA0cSihlf6cM?=
 =?us-ascii?Q?GpEpq1ccZBeS8FbwDKDZO0lL89jmiGtgEAIVsd6armqWPcCZQMe0aoAZEys3?=
 =?us-ascii?Q?K0/yoLDTdUQBulBgPmRiSAiKijmxVYV0bz0u+h4KOxlB8BOj6qrxFeZ1aSAV?=
 =?us-ascii?Q?AqUthimlM39Bjn1UQRyTcr1b8uTiqv6IOkId4kIk1SQNmVe6WMYMImT9EDRA?=
 =?us-ascii?Q?kFLH7NhRgrcWqUzNr1tstHsw4QutyagL5wtCmNNWDeTz8HjG5q8PRLcK4aRb?=
 =?us-ascii?Q?EZmE0qyLGWKLb49AamY6gsnvDjqND8YNHXBWAQkagVdeDPFu9xWmNVyOmQcj?=
 =?us-ascii?Q?aORx94Tc2HDUZpfV14kGkVmjnNN/vYZW6wseIidkgXRbcW6+m9hTKsc0UY3G?=
 =?us-ascii?Q?UYiywtB08cR54kZmkvhQDJEfbezhaZK3NL5+z2Ip+EcsEqMLjE2He/c9j2G5?=
 =?us-ascii?Q?la8onYC/eT3wNTBnyAPcc+JyZPd7kPh8VAh0zD0pT445dApyAqzLpAo7vFTi?=
 =?us-ascii?Q?JAhBBp1kAKyzK91e5S6QL+MFWKli84Q5tsjAbAHAtfG902s0bsA6vGnN+ul8?=
 =?us-ascii?Q?vbZ/ia7VPE3AaJ7A024v2gCRdTj4lSVvU2aLm69B3r+2HOX9m+mArNRhBMCZ?=
 =?us-ascii?Q?aMHtxWI4W2ferz/lQ5fffu8Z7oBC+4wQjxK8wSFsElC+YOeWxbkG4OKMBCzU?=
 =?us-ascii?Q?ZTEuEzvfvrBrKLam191VaZZ1K1YjjtnEKjE8GevRfvRH2685kFGdKY3osI8u?=
 =?us-ascii?Q?NE4xml7s21pcHLz4Eho7/3BSa2TtYKo9EJTy5e0/MQcDb+My9UNID645QLfT?=
X-MS-Exchange-AntiSpam-MessageData-1: cui661ImozRG6g==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b12fab1-4fd5-4b22-d1ec-08df18a9ed85
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:03:42.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fC1BQ1hRNihR02AaFjjZXQcHBG3Ou9zNzqjnZdTtwCpYanUVkSumr+ByK6Ier0DZZMrJXswpOk4T1HgygXnYraJBd1l9h4nrhZSgMyfcbEVw4c5MhHmYwB1/M+DBMxFsjTH39sIjykp+gcHrIPKyPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10817
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.83.23:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.83.23:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1C58644F8E
X-Spamd-Bar: ---
Message-ID-Hash: MQX7QKBPSTMELVM4I6EZVJIHCOH2AY4H
X-Message-ID-Hash: MQX7QKBPSTMELVM4I6EZVJIHCOH2AY4H
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, amirreza.zarrabi@oss.qualcomm.com, peter.lin@sifive.com, Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MQX7QKBPSTMELVM4I6EZVJIHCOH2AY4H/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

The OP-TEE driver reaches OP-TEE through the SMC ABI or the FF-A ABI,
both specific to Arm, yet builds both unconditionally together with the
SMC Calling Convention definitions they rely on: ffa_abi.c is always
compiled and only its registration is conditioned on
IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT), and optee_private.h includes
<linux/arm-smccc.h> and defines the SMC and FF-A specific types for
every file of the driver. This is fine as long as the driver depends on
HAVE_ARM_SMCCC, but it keeps the driver from being built for an
architecture without SMCCC, such as RISC-V.

Build smc_abi.c only when HAVE_ARM_SMCCC is set and ffa_abi.c only when
the FF-A transport is reachable, and provide stubs for their
registration otherwise, so that it fails with -EOPNOTSUPP as the FF-A
ABI already does when the FF-A transport is not reachable. Keep the
SMCCC header, the SMC invoke function type, the SMC and FF-A specific
structures and the SMC RPC register parameters in optee_private.h under
the same conditions, and drop the unused <linux/arm-smccc.h> include
from notif.c.

The FF-A parts are keyed on IS_REACHABLE() rather than IS_ENABLED() to
preserve the behaviour of a built-in driver with a modular FF-A
transport: kbuild does not link the optee-m objects into a built-in
optee.o, so ffa_abi.c is left out exactly when the transport is not
reachable and the stubs are used instead. The IS_REACHABLE() checks in
optee_ffa_abi_register() and optee_ffa_abi_unregister() are always true
once ffa_abi.c is only compiled in that case, so drop them.

No functional change: OPTEE still depends on HAVE_ARM_SMCCC, and
ffa_abi.c is still built whenever the FF-A ABI can be registered.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
Changes in v3:
- Dropped the RPMI ABI placeholder and the RISC-V enablement patches,
  this is now a single patch (Jens).
- Key the FF-A parts of optee_private.h on IS_REACHABLE() instead of
  IS_ENABLED(): with OPTEE=y and ARM_FFA_TRANSPORT=m kbuild drops
  ffa_abi.o from the built-in optee.o while optee_ffa_abi_register()
  was still declared, which does not link.
- Drop the now always true IS_REACHABLE() checks in
  optee_ffa_abi_register() and optee_ffa_abi_unregister().
- Describe the current FF-A conditional compilation accurately in the
  commit message.
- Posted as a new thread with a proper subject prefix.
v2: https://lore.kernel.org/op-tee/20260915020235.507302-2-marouene.boubakri@oss.nxp.com/

Changes in v2:
- No code change, the testing section of the cover letter was completed.
v1: https://lore.kernel.org/op-tee/20260914175435.118303-2-marouene.boubakri@oss.nxp.com/
 drivers/tee/optee/Makefile        |  4 ++--
 drivers/tee/optee/ffa_abi.c       |  8 ++-----
 drivers/tee/optee/notif.c         |  1 -
 drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index ad7049c..183cdde 100644
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
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 633715b..08236d8 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -1212,14 +1212,10 @@ static struct ffa_driver optee_ffa_driver = {
 
 int optee_ffa_abi_register(void)
 {
-	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
-		return ffa_register(&optee_ffa_driver);
-	else
-		return -EOPNOTSUPP;
+	return ffa_register(&optee_ffa_driver);
 }
 
 void optee_ffa_abi_unregister(void)
 {
-	if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
-		ffa_unregister(&optee_ffa_driver);
+	ffa_unregister(&optee_ffa_driver);
 }
diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 6e85f2f..6801422 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -5,7 +5,6 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/arm-smccc.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index aefe1e6..02d6f79 100644
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
 
+#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
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
+#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
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
+#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
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

