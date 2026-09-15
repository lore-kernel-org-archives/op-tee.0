Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B245FC88E72
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:48:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D0A994493B
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 01:48:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XRYpUH3P;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 454764388D
	for <op-tee@lists.trustedfirmware.org>; Tue, 15 Sep 2026 01:48:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJgASDMavUxljAt4em20pHcjj/6JOw5GWFZLQHeNXpQNY75Wjp5uGOdxsldV7gGhuEKoNi9qemYDd8JjHbBq/1Mnp7OeJbUL3+V1rVQY7Gx1Jrftt3BUzKHtpSciG1xkNcO2wtUHIqdpvIkPGZ7lYnkVQkGIUOvptdtlpKnOjA5fd7sU1rb8cOOiJDz6xmMNmNElRVNqMB1X9nMgn/A+J+EPeEPW4szwmHijQzMPyPUNY3Gvj5ZstoEH+jdW8Zrqf0yfh4t2lqIgrl6nhyk3HMKIeulpK6bsJwvKLBHGVgRalV5qxWpdqB4LfJQc5DjJCuz8KI84rVIL8xxp1eFQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIynHDBc94pDEmU9/s8YYPjSVA1qnHxkbVhY2g4lxws=;
 b=ATwdG4LiscimCyJ+2PQ5uUJ4dRk9i66dOIMghHqAhr8Rk+hKgvWW2u3/3nRmxvDPqeMKPOrLH/kPbhsSKz7pU+qL77aj4DmGZ7uN2w7f8Qa8ULxgNxG+eHCIir2EOji3ryc59igN9vlBAO93p5XdT8fH/BD3yuV4tfIneN1Eb8MpekIs2DhK8PjgSUCakQ/IDOrg6N4802ziPjWiBRrSJYpuuSlsxWNz4os+bRkaXQHDdBoa6v9KxnzZu7EoY9Zy/cEJApNjV4zWhHO+U5iTsMEgN25awtzxQKiyAhj+HC3a83dBYtyy6/OfcEHQ2GvLaOmh9KfSEAgg+Zo2XBdWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIynHDBc94pDEmU9/s8YYPjSVA1qnHxkbVhY2g4lxws=;
 b=XRYpUH3PN6monLA5+DO7CrGhnXOSAur+m8MpbEwnsobiRHI5ZHCPuvCiYTlQYvONdA3P8fTKJ7nl+4L9W30vu2EnxpJ/8yi34SQbFSoOFCmS5Fs8OzjaHOTU8oaft+82wtSWa9AFPNlVzj5n0UmyXpwWcE4k1ljM+k8lwkHCkWwSmG8LO8l1YdDHmbrXWd064FsBh33ijFDJmpUeMy/ozO4yRMKT+7Ug+IF3g0wuo8HunqHOsxRWZPuwhqn/cvFDMDsbgWDlyR+kp3lZcOlcTzI6Wuus5SEoEFKDrPzm8pvOYSSp/gAtW8Pvp8KwaWzPrbh/1Wc0/HvRxsskrIevZg==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 01:48:43 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 01:48:43 +0000
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
Subject: [PATCH v2] tee: optee: prepare the driver for RISC-V
Date: Tue, 15 Sep 2026 04:02:32 +0200
Message-Id: <20260915020235.507302-1-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
References: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR17CA0055.namprd17.prod.outlook.com
 (2603:10b6:930:12::26) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|PAXPR04MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 450664a6-27ae-4835-bfd8-08df12cb792c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|6133799003|22082099003|18002099003|3023799007|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 
	h7kpcykv2RgkiWXsBXc1qkjJvepjpZYaU1NtefV0WBhzlM6msuGqzS8ytEwWjAH/l+477T20QbSemHkHJvVgjXndXpUqm6fByAAf0+p9Es+vjVg9U6YEV6v4/DonP30eAXWQd0lj8UQ8mFo7S4zyxhjAN3N6R250uouoy3GX6hPhjs0c2YMlNCSuDBgEx6yjEs/eBNDyuVWV/oXdFceEuc1OYaP6m+csVhANDynDFLGtnFg08HOWJ49I6vcpDt4zraOF01euFAKPl7ttjF/ovJgPpE0MaWbbo9+JPaUMv9DxrKVJfoq2HZbvyyWkQRU91ah8dgliYxzFarFY85/3mjsfJihjo8JR6nVuRZeq+xpTwhDKdfp/oYwt2Rn+t7Rj9A92tErXvrzCM4eeWl0moPS2LZVINqOaQFLMWSP4/5Qjw6GzPVJGZDyyR/UI5dirFOtdnvcmGsjXznFh54MNhEVsviQgL+Q8zw/ITs50N65Tf6CQTuAy5dduWd5GIKBF4I42Rj/1Kc91qJd+jxXGlWZ/xD/qCdW5D3ZHy9OXeqfh9/KBFRlKFLMBGojVAnQ4zgmj0rujwEsVLVupjexzxJD+SBLwzBsmtAjCTiLsd+WVte+bQ6OOr6NTSKFzgvh0if77YmF63zs5fgUDR3o9dHBzCQxzsyiDWkuX9UKKGQY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BPNOZd+i02Bf5nmfwNPjNMsRB+/ZGef5lZN4hjRj3StqttHjtAol6qI07mQe?=
 =?us-ascii?Q?1KCDXhWmd0pVND4xkehZwqg8/se4OKK7YJEbqv0njNsG16KjKWD5jqo7LAeo?=
 =?us-ascii?Q?jgTbNQ3IYoIuYAFlq7K0bLORrwrXdkUY8W+HRHcC5eTIGhLFfDbtYYc7FU4F?=
 =?us-ascii?Q?2gkXeRxJB6W1ooAAFNmXnYWL47elIMofAg49/CZE2ipRDzm83xhd6jvCaJEw?=
 =?us-ascii?Q?YglfeqAqqAYKhZKcKb1OOQpGCEFTJbGXmUXqO6EQhSx8fIabFq829m1o0rsW?=
 =?us-ascii?Q?KpTDZSyCE5rxWU7lL+EjnklGUt0w77IY+V6cjyvdaU83vODgP5AO79hRyHb8?=
 =?us-ascii?Q?OzkG1Q9EAStQmOwzWjJXqCmQSpXmyYlJr1/ym3HlobLjM3YcnmnrAeqzOIp5?=
 =?us-ascii?Q?G15o1X/IeXpZbQoU9Pv4o/r/PYqxFThNFe8+hFUjam+vNuKGWaQ51cU3Ko49?=
 =?us-ascii?Q?93kS/pNzqS+GqJAJUf0EAzaGB3I0MOQeRBOX6+6J5nz/jimloYi6CXm18WBQ?=
 =?us-ascii?Q?qFoobteo18LlELGmiip8pKNCxVGJZesniXf2ngxmrboceT/mRiPAvtpAEoPM?=
 =?us-ascii?Q?4O4sGATrr4T3zbFfGMX8ny56F1zuzQGTNFsuwq3RUnfnN0WxeIsYXIDLpZTJ?=
 =?us-ascii?Q?zPe0ZtIf+iqQA/SC44eW4z1Wk6dYyQ+WXLCzH598e/xFNP4xeglZN2AYh/zN?=
 =?us-ascii?Q?/afp9+gF11sL8GS370CvWwbbrhenGhYF6e3ty4MAUxKWEyk6ikBLNB5BnK+k?=
 =?us-ascii?Q?Zny4m/d3GFZHVDGg3uX6ngktZPjhVlQLpeBd3hJmP21ek+ep9xrcbqGO3VGl?=
 =?us-ascii?Q?n+X5zWU46SsBt3/jDChYKc3wahm1GK0fomMqYFPfaODPPZg/RXJMgNOSHRjt?=
 =?us-ascii?Q?Ie1j7QX0xOZkkH2Np7hL6qTAgrWCouWwASlTwXt87Szgk5TKNUbzl7UAFRY+?=
 =?us-ascii?Q?Dd/f5a2pH5QP4rebWfHv6StoJFkp0XVAT7zHIhHL8LG7iBIyb20jRIzL4LIF?=
 =?us-ascii?Q?coMhuEh1Kz9EjH07ioLuErrRaNtbmP0ce5swMGseGZhnM9QUeIzj2RlBJgm7?=
 =?us-ascii?Q?dC6JgDX/X/ZCTKNripAhlHVCfLFlm6XyPK8odTrZR6jAlzCjTo8hz90028xf?=
 =?us-ascii?Q?NCvh8Uz1uJbbdWawpqsRtGAThcFp4p3YMPNx507TSxqm6t7/9wrrRpKOYu6f?=
 =?us-ascii?Q?kYYwliqigXMVssA6a7kI8IQRBhplTjTGQsuqm3xjrPd+itVby0TX/1Gr7R0k?=
 =?us-ascii?Q?E8tN2stHCZNndOyNSbsJ1K06ojWfYlMT9MyzRqfzMWayYVu3Yfy3inyuI+aT?=
 =?us-ascii?Q?Vb5vziuAEDAQVMAOcVmx67mvkAcQgXlIBSxTYQN+JxTQ2twUs2tISFthfFBS?=
 =?us-ascii?Q?tIof0Ceolh/n7vQuMntBRNSHSTy7ph4VEwMQS6l73ed2F84JQ0e86S3REYeK?=
 =?us-ascii?Q?/T1sbzzT4JgTBmDOKMlGq3qrseAKB85ZZEYs6CI0gQ8cdo9Ms9sk9LosJWcL?=
 =?us-ascii?Q?sy7isSs9dq/uji/4GLftSj4ktY4q6lYOn/P45ZAlDry8QX2aqC6RrNVRNJGW?=
 =?us-ascii?Q?pAnyivd3jo9lX7fbl+7l4MvF80NHBs1dDbiL6JUaXU9P3zXTPIlOl/xmG+CC?=
 =?us-ascii?Q?06Q6IKHyj5KZ7POC8pdEGYEylCdTmRVXBwNeqnIXIwSONC/4KlWiWb0Qkbo9?=
 =?us-ascii?Q?S2rmn/KGFc+aV97NUEhyw5WGJRg01XgXWvP6bVYewZZGG70ixoR/AH+k+ey9?=
 =?us-ascii?Q?DfS+IghAfdgfoz02/0fGbKjDD4tJPp7oy2O57ag1plbZAOrtU4NPxOY+dM2/?=
X-MS-Exchange-AntiSpam-MessageData-1: TQP8m2QWt5KS8w==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450664a6-27ae-4835-bfd8-08df12cb792c
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:48:43.3727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDI9MSJWNJ9xmQOyBLJim579e+/uWs1gGtl0C/fskkR69QuwlN32ku7SGWGXuvbwYjzRAmI5AUXKt157+CwYdvwuNQdBrbJXYVJIROnbtWTyNNhV5Tq9/vz87EDh+UfHW6Oj10IGAscaxwrxGf8PkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9328
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.28:from];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:102:4ab::13:received,40.107.159.28:from];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 454764388D
X-Spamd-Bar: ---
Message-ID-Hash: 3WFATADDZASESDPCVA3HVSCHI2TLKECB
X-Message-ID-Hash: 3WFATADDZASESDPCVA3HVSCHI2TLKECB
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3WFATADDZASESDPCVA3HVSCHI2TLKECB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

The OP-TEE driver reaches OP-TEE through the SMC ABI or the FF-A ABI,
both specific to Arm, and the TEE subsystem and the OP-TEE driver
depend on HAVE_ARM_SMCCC. On RISC-V there is no SMC instruction: OP-TEE
runs in a domain isolated by the M-mode firmware and is reached through
the RISC-V Platform Management Interface (RPMI), carried on an SBI
Message Proxy (MPXY) channel, for which Linux already has a mailbox
driver.

This series only puts the build plumbing in place for a third ABI next
to the SMC and FF-A ones:

- patch 1 builds the Arm-specific code of the driver only on Arm:
  smc_abi.c when HAVE_ARM_SMCCC is set and ffa_abi.c when
  ARM_FFA_TRANSPORT is enabled, with stubs for their registration
  otherwise. The SMCCC header, the SMC and FF-A specific types and the
  SMC RPC register parameters in optee_private.h are kept under the
  same conditions, so that nothing Arm-specific is left in the common
  part of the driver;

- patch 2 adds an RPMI ABI placeholder: an OPTEE_RPMI_ABI option built
  when the MPXY mailbox driver is enabled, rpmi_abi.c and its
  registration from the driver core. The transport is not implemented,
  so the registration fails with -EOPNOTSUPP;

- patch 3 lets the TEE subsystem and the OP-TEE driver be enabled on
  RISC-V, and teaches the memory type check of the driver about the
  RISC-V page attributes, without which the driver does not build
  there. It is kept separate as it changes the dependencies of the
  subsystem-wide TEE menu.

There is no functional change. On Arm, OPTEE still depends on
HAVE_ARM_SMCCC and the SMC and FF-A ABIs are built whenever they can be
registered. On RISC-V the driver builds without any Arm-specific code
but no ABI registers, so it does not load. The RPMI transport will be
implemented on top of this in a separate series.

Testing: Tested with the configurations below, riscv64 and arm64,
built-in and as modules, and W=1 at every step of the series.

  - riscv64, minimal config + CONFIG_TEE=y CONFIG_OPTEE=y
  - riscv64, minimal config + CONFIG_TEE=m CONFIG_OPTEE=m
  - arm64, minimal config + CONFIG_OPTEE=y CONFIG_ARM_FFA_TRANSPORT=y
  - arm64, minimal config + CONFIG_OPTEE=y CONFIG_ARM_FFA_TRANSPORT=m
  - arm64, minimal config + CONFIG_OPTEE=y CONFIG_ARM_FFA_TRANSPORT=n

Marouene Boubakri (3):
  tee: optee: build the Arm-specific code only on Arm
  tee: optee: add an RPMI ABI placeholder
  tee: optee: allow enabling the driver on RISC-V

 drivers/tee/Kconfig               |  2 +-
 drivers/tee/optee/Kconfig         | 10 +++++-
 drivers/tee/optee/Makefile        |  5 +--
 drivers/tee/optee/call.c          |  8 +++++
 drivers/tee/optee/core.c          |  8 +++--
 drivers/tee/optee/notif.c         |  1 -
 drivers/tee/optee/optee_private.h | 52 ++++++++++++++++++++++++++++++-
 drivers/tee/optee/rpmi_abi.c      | 23 ++++++++++++++
 8 files changed, 101 insertions(+), 8 deletions(-)
 create mode 100644 drivers/tee/optee/rpmi_abi.c

-- 
2.34.1

