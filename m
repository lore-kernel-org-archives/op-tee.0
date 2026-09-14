Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460AEC88E72
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:41:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7ABF145360
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:41:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KvRKheCn;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 607694527C
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Sep 2026 17:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5n9u8rOhfDd4lzJ4KMUpsVAJBItBgrmt7YZq/dr3lkQdYi9Gn4NMapptjZj3JlJFCwNRUZL8lt82QCDREazTRxvCdVlaNfOyiQgq4XnU4UbLEurX3mViJx+PX1Wm4hYjdziSgFPYgNFJzrU0/3TTcQ0R0d+WKRNy4m8m//OL1nvmUEM9DYxr1g7JynlPhgm78z9uNpgnNY5P3YlEBvp8NUpyEoglBSXu0gByDGsSv8JdBVp3uf1FI/9XGS2Nxlh/yDmq+OjFDxET/byyqf6KspvssIdORClVjfV/OWwBJxLDtoqckJtijahFeYXKTbi45dJ7z7LuKAexNoo9+eCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6V87UpBZfaqoXOQXvuyD76WQ8rqyKMLq+4qzSKgTnOg=;
 b=vKA0HR+GS7k1q/DIDF1eADLHyMH4CTBdyJ2Fm1yGnq4EAgVpzTEIpCvKA9EIhpaYU0PAPK1pMBUfSBnbh9Ykp9E98gNgQP42XKiY8MbOl0MLIrm5Bpl8vYdRoj+A0FgVDTpn1PkNatOav7mIr1KCoGCzXQWGEe+m0kl5y1YscBRl7VpGuaURj/YfWnZSc34GGz7geVkC9HdjnxHsuic/hTu3YRha9gTSWsrH0JwWJRczVgPhS3cIlr+h7GvBtMEaeP8xHTrGMg5YWUEbQQ88Zx7fVbORhiwDhcywzHESq7MLhGlWPZ3GN0tDxGTQmlSea3DSN/j+QBveYG7CQMhCDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6V87UpBZfaqoXOQXvuyD76WQ8rqyKMLq+4qzSKgTnOg=;
 b=KvRKheCnrueof41fhNIvBBEA4a7w7CRBhPwiEkMOK6JYVpQuLyEO8T03rCeNkOxutI6R2huMSABHrlo7bQ45VKrS6qOP31yqVLvM1L+HQeJROGEaWwpyjmX2+Udey6SQJHF0uJpIDQ55j5ntUrwtJiMBY9xzFfnrMEEohdVQLXXAcYwg4uinwS4R6XzMusLLVmw0+lkngeOHjecnZEgmre7W6L/EIUoSBq0s+C2a8ljTq9PSJ9K0nVNwvQTf3hHS0YhlsEf+pV5UpN+Tfrsw2HfXiKFGUVAVziOCX+ihpaFNqPg9WJ+zWlOYxp5tcUl/4/DPrKPtwVu5mFN6mZM2GA==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by MMZPR04MB447860.eurprd04.prod.outlook.com
 (2603:10a6:190:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:40:54 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 17:40:54 +0000
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
Subject: [PATCH 2/3] tee: optee: add an RPMI ABI placeholder
Date: Mon, 14 Sep 2026 19:54:34 +0200
Message-Id: <20260914175435.118303-3-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914175435.118303-1-marouene.boubakri@oss.nxp.com>
References: <20260914175435.118303-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:930:d2::15) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|MMZPR04MB447860:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9d794b-23d5-4d5c-295d-08df128753a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	SVjsaVLRtGfG3jMlcpNRL+5JZwNAC0+9cNfvLAsd1sKucxuipTdj51l+yADDSnrNp6bCw33NUFRN4UTwuM0s704MAfGZT2JlQDZdO7r59fGGIfZIBhD4s/vO0x1a1hOR9my4lv6qvE4HvTgYBKqs2Href9KghHcVl9BIxFXpQ6HDgIxebDsIl9c3oheu9QIsIemj8UUWAwmZMyRMFM+gw47pBEdMKAtTEgCPjRtEPg1pYKphfH9C2iwQq0vJ08Bxjsa5ABng/zv7unMI/cTkeXBDzEJH8PRTLuYXk0QEJfiyZgdezAGogGI90zMC5JyhFo/VBZRSLP/5jgeGT8I3JMn1VQDwJq7s9Ix10QGH7AzNzs7x28NCJTZdN4/Ddyw8+iIPEU5cV5z0G7LyG7aUaZZ4zHuBuz1FVYG2pUaHWijRwkbyXzRxIUR58pNmHEET9CBQ+042PcXfGtHY8xWCNJ11mvXNH/JNx50rYDnryJAT9a7uevPQg4IYuGBNHYBp4SDsrAxfEl3uCmDA6pkI3ZqbmYesbookKSjiBlILEYub3aaYvUvGVGQ3iir4TxBy4BMbGbGqolUYnKTuh2zA6Gfk4TKa6idceY4KvLpEwcMcDgzbN6WqK/AttXm+0oxGyzC77218Wod7C5SuafdQ9XuXMjBGjZgAm6VPJYjooYk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QtHXA5RftgNLwfGvLMdPU/5BKdq5KFTqydFN5EOtfPpcHhV2Y2AIXIuUkO6K?=
 =?us-ascii?Q?M3SSxYGadL46VHk4eb6O5ulhEzxRBqv2zE1DSk7lLXJr1BnyuWN0ssQPrXbA?=
 =?us-ascii?Q?6IFAddfXWlP+urcK3DsPUhDuaXQtF+uJV7PrELM73w4OzyBGoYhMy+k6YkKQ?=
 =?us-ascii?Q?d8ocz9qf2FOeE6fDVVsaO+KD4UCczrugMvuvdD1eI8bvHmbgXKYrgYcE3Tlu?=
 =?us-ascii?Q?cNU+hbArveT3/tNi8hWDalqwXeWXTKeAH50bcSmHD9FhKEWmVNOZJVugNyiP?=
 =?us-ascii?Q?tVOrFmGVj51AaVMyCeI39+Ytuw6eRNzHYI8lXkQR3Z49fQyNdEmT9zDJu685?=
 =?us-ascii?Q?zjnGnFxWQyhqSHZEW/eztxyRHc5vVlL6DBcgUfnHofKsZOSsTst484gjtSmb?=
 =?us-ascii?Q?7C7v5mTJyNb4l77BL07xagp1+WjPmCBSCeQRlLT6MnOqnzH6DpM04YlTg5r4?=
 =?us-ascii?Q?MKsYGnUozGl8rEkhA9nHdzrNpQA0FmEH9U/UEEyn3OihojzZ6kQ3KvNOrTiV?=
 =?us-ascii?Q?N8I+GpIVPJhtgifEMvMrUuGUES7v490SdWZRt2VuXxmlqV/jgmakbTWtmmbO?=
 =?us-ascii?Q?yuYwAxDAs9kerAe4y47qvx7m0/oOPpz8se3/8P9vaZ0Q4yM/mcgj8gcu0oSX?=
 =?us-ascii?Q?RDhrc1YsKwEkI6pLFaaeIKaMCYIEvOug7reTQk9ifS6tJbFDAfBIPyzsHWUE?=
 =?us-ascii?Q?4YXzqF2hKiJaYy0QjZUXNNCuPC1Y5WilwUhhRIPq3rtBb8B/RSP1esUL7oXs?=
 =?us-ascii?Q?/1kfzI8TXt+rcpBUjgVoMZRfUFc/I0MyJGb66JDx31EsdcR9VgqdJ5FdIJF+?=
 =?us-ascii?Q?YTSqb35Re7IJdQty8lawYehH/SbVGB8Nt2K0jfdzWfgIn2SWIyNSP2ITPW9Y?=
 =?us-ascii?Q?6ZitBWywpSi/I3HVD2F+2vGe9yXjAooHhIA8i7+L2F+M8nc6+G4W3BSCuJIf?=
 =?us-ascii?Q?v52OmxNy1xG/rx7mfOpaOFlTVqJ6QPAs5LioqjiotVW8EMKSUSGj/Qua1eZL?=
 =?us-ascii?Q?PssU5f1NMln+ZMyqwjaGyrOezDoLSclN+837+IOyV1ATA8c4jFKIE0zcQDeQ?=
 =?us-ascii?Q?fX8tsnBIUyQ6kfih1XeNPT/jMwUDZpqClu7k7Hx0PZxGPDolcPhUpA7Sp9Jg?=
 =?us-ascii?Q?Am7FyijCNyLFtDXEz5i3leyTrnn9YN55Dsa6/hwuXDjlq2KRTxnSLNRCOp8+?=
 =?us-ascii?Q?F2xjQNQ/T1aX/7FzBn+CHsyR2iR3BjedNL7pbk8s27U7hwz2JQn1kF1HXeVz?=
 =?us-ascii?Q?KH4xL+K/En5HfP6MnMwwnuQSJhvSQaNy9AWe7gqU/+JgC8KqL4htjL/AgvKY?=
 =?us-ascii?Q?fEOVGcbwlCPPK4QxCQYO+eHfU4eX/yCSxItpOAlG/zEDUcoWcu1UMykQnT1l?=
 =?us-ascii?Q?hV82WRm4LlrNUs7bPxSCO/3uOOjljaQCdWRcuatvxfeMBsaiyOKg1lBwtjv1?=
 =?us-ascii?Q?Ptf+Vd+FADFPSV6rxN6XGIbJBT1jYOGFTEdEt+/igC8lU5Ovh1V4AzjBx8VL?=
 =?us-ascii?Q?DKOF8dZAd2c0sTHSco3uOiSAWqFFIcZH/WsmzwAjoNieZS5VYjWYY/uTNkPL?=
 =?us-ascii?Q?r3HaXsL5Q6LVwQxkfnOGo0SNbx9jm+/uej4dhtdiAaaiyqFzvJtElWtVwI4p?=
 =?us-ascii?Q?LZOBJITl4hlz1gYWZi48sAyKxNDefN6NY0zl1o6apT23W1g8AGaNqLj2KuUT?=
 =?us-ascii?Q?uue8jELaZdQCrAG5/ozHirO2oacS5Ut91ITtBkcNFUMjXg2fKYq6uDsmtZsA?=
 =?us-ascii?Q?pV8go6Ef2uAI2tFJSlKPL4lo0AVm0+c1g/RPKiWD2nlKYaz80WXz/eu3OHw/?=
X-MS-Exchange-AntiSpam-MessageData-1: GSODr/YpbzZYlQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9d794b-23d5-4d5c-295d-08df128753a5
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:40:54.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD2iobO5OPD93lE0aXaKxkh3wY/5dnhdOrHwLLDNba7gYj94EAjbbIiydERkjyvXvYv5ruCv0wZ9NcwnGelQwjFEmTj6BYK6zYEMrDGJ0c4wESmqw+TFgKICnLbUfBfa8q574rV8xK+lPv0g6And2A==
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.21:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.159.21:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,nxp.com:email,OSPPR02CU001.outbound.protection.outlook.com:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 607694527C
X-Spamd-Bar: ---
Message-ID-Hash: 26JI6TXY6KP3RD5LT5S7S4KKXAXGCIZ3
X-Message-ID-Hash: 26JI6TXY6KP3RD5LT5S7S4KKXAXGCIZ3
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/26JI6TXY6KP3RD5LT5S7S4KKXAXGCIZ3/>
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
2.43.0

