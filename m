Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92627C79FB7
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:10:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CABC0453E2
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:10:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fpfUPE0w;
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013037.outbound.protection.outlook.com [40.107.162.37])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 65C744528B
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 01:07:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwZqFbgZNqUsq3bvpZmWKFf9dF0hCOvGPP4/Wc1It1cgoNWeRMRGF+orwbDGFTCaxmIAAErghLvFMqLhz8qtDh3Ozjhu81jitBEDiOPg+7158+kmGnHT/me2KUzlkZa7pOXXOracwCk3+7l8zfGh8VIT/N2edfcXQLwaOv9GTI+ZLdGOiLPkrcO3CdpCDbYVB4obIJLfPW/+yMuaKwkvawC6TtO7IWAE4NdhB7Z7TLOif5fxne6gILYnVtzl5A/zdg62rLp1+ZT8NxgG079jDEw8r6s58ghmyej71Zjvh8FrqZMao5Yi2+666l0ub3jtXjBtLVmZnBaQnTscIHQVqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpgYWSOBIxNZD0aqY68jceBra01upovPObJRiiX2sPs=;
 b=A4vOu4U3MsevJczfHHJ4QZOI23qtgZtXk7/MxmVpkSvLmy8Ls5D4gfeLhUyBAsgtBz3qWuU93WIDpQuBKX1BlKE+qRJDAl/rBn4g1gvR9GyNfwAXfOe1N0ja4gUlijyVJ2dZIQm2yZ+OS7rQZ2rA9Ct8Xf/tdBBxXb1hdRaLjxVVeQcQA94AuwCJ93oFWOBgg/vKe2q7gUBM+ziGSqYET9sPRhbG5EoySBXZvmsEk59lunOv6kdK+QzVr7X8/4aqdR0AavrZDWA9r1D5c9X89h13N8qBfAjJKNQyDCI4RX6htzVaqQBRqa9LRGMFja3FT/3xQ9+GsdhUy/kZQ3AiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpgYWSOBIxNZD0aqY68jceBra01upovPObJRiiX2sPs=;
 b=fpfUPE0w0XFhtb8lr0njd49alCVg9djC0EcQ7HygQURc8YrbJm5IsB849hZrGbaZs8OdfQ/2wLxMpLil00iyGsU2D7G7Lg4J5yafYn9Cwysg2eSGL6mC/OnMHwnhIXhXHk47eqka/OzcfTm3b+YQG+MRh+aZygxsFIVMR9wYinTAMBFEKYaSA1ZlgRP1yqdRxSGrU801SaOUA2mCWlDSiBXKghghxku1pCoJJY2tZ6BlIE6+JiciaHLRw5Mqcl9w1zCp4XGtN4IEO/5e5UIWK07b3bj0pOTb4VH2jYVNmeFuD62LibgFwhAbZ9JgAngPrMVeu/7UOoLltvIjfQJXvQ==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 01:07:42 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 01:07:42 +0000
From: marouene.boubakri@oss.nxp.com
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [RFC PATCH v1 6/6] tee: optee: add a RISC-V conduit over the RPMI TEE service group
Date: Thu, 10 Sep 2026 03:20:57 +0200
Message-Id: <20260910012057.106966-7-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910012057.106966-1-marouene.boubakri@oss.nxp.com>
References: <20260910012057.106966-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR13CA0028.namprd13.prod.outlook.com (2603:10b6:930::25)
 To PA3PR04MB11203.eurprd04.prod.outlook.com (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|GV2PR04MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f3f2fd-d374-41b8-2f84-08df0ed7ea71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|56012099006|3023799007|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 
	OF7ckgWmkr6JEhGceqvpgxHUAktlwv06J+a5G7aTu0CB8t7zRkykXYsqSdB5L/Zgiy6i4dFxHLQzVqhDYtz7UGzGSSCfNYBLS2wCpybDW75FC+8oBPtxS19ZvLatr5KLZu7RAbsBn1CAkRNvE+eJEYAkcd7atBJY+ePqbOdlc5WZEOQppPwg3uAcFedDoK5B1wE9DRdrBWOtk9LZLKUXj1kYtQAkr9lB+EHAGJ6ArFtfKdAJ/4q5i73b4AXSHAqskPAEayz3u72nB1w80tJONfAJ6Ebnsx1hnyhalThWRbQpr+Wi3ZmKbNGsaJr+LUB0ZdD/qPuLfPx6cAc+fNaE4Ov6fy3BCzSb5vInzGV1jadGLFTJHlxLCPggVvNnzYAHH2Wrgmht5Bz2CsDrtkH2dkzJHkJiEIOR2L4sHEGF54xyTm4DG1qyFy7g2hSPMdApPO2jZn8t0tcEyMKIOI16loNAmypEX0qgZfbP+6WY2Hg0l1CLg+s7C4GfV64O65xDfFjMnbAwitrdEBjLhud1OXdqQUUeWkYnPgvC5TIkJj3HoRcyG1s4CHPgArwXozL3aIMIdKCkxzIg4JRZO3JSToRZzWPzNOe3wEJ/8bk9VSaJLCSGAFGmqEvXQybf0Yg9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V2GWSW3UmXsoUcypWo4vDH0tEt+OTzEvhI+ry78sF3/DdkW3XrV/1POmsjWb?=
 =?us-ascii?Q?H0ZVTJjQ8u3jD+rx+IJqZwzzZYwqLw6MB1TSNBqiXbbWH6HbdDxLSMYPkvJk?=
 =?us-ascii?Q?NBC0NFnhP/CRaI9E4sOquwyZi2eGFBJAF11GmMLqfxu5FNfpgZVmsl7ACFbG?=
 =?us-ascii?Q?MsDBmCODALaMhT5v+TRD5fwe6oxruqdridaJzFNQzLL8MN8A1Seb4DKwVOZi?=
 =?us-ascii?Q?99u2nGFSA3p5a9QttOIQrnPyU7zmbC8CRVcc8dSc/SAa4mFqrJXiGftUY+5A?=
 =?us-ascii?Q?/G9kgXFQxgFCNtCwY56CpkjJE714J9N4qXGpQY8Nn9MlzB1L0ZzJurDTkmlV?=
 =?us-ascii?Q?T527RSSmMjfI6BvzTsBi96yOC8aWNcpT4/goZ3iSa2TbBL2AqywI16cYkLWD?=
 =?us-ascii?Q?+jfKdauinc8TqEucau8AlhoMHZx0HelpUY5PnR2wqWRu+LQqnAjYOW6EATqE?=
 =?us-ascii?Q?A+LR/VsyRs/Sq0ixSxXzDxYMZ8ouojfPp9lORxkoiVHzMghf20G9IpEfopMA?=
 =?us-ascii?Q?zlvjs8E6uIkSkxJRxLC8eicWqm55/q3/Cv+zh5O+Kw+IPfsOZ9dxjSBxXn0X?=
 =?us-ascii?Q?mFmX9XuK6cVMbUdbT6dTJZmp8ohHtFeMqJnawGo3DZ0Kz5OqoprLb22axl7r?=
 =?us-ascii?Q?pR4QR9PIuELBzLi1miYB+/OCK5mgbNKarVr4gC1PWWE+JPaiq3NMVBUXf8A9?=
 =?us-ascii?Q?kc04lGXgK62N30i59n2bGezNBogypTsfkJB88pjtEP43/ai2ZGeS8qokZ2H4?=
 =?us-ascii?Q?lsy+qKaynJs0FuDljLouZJcAHRuSQdlk61fb85cLGwuMcEYG01NuTofEeBVX?=
 =?us-ascii?Q?oDzZSpGkzuWJf6YsKPFPxeYV/nPoEWE3Rsb9tsd3UjAwisH7tM0dk+A/6rI0?=
 =?us-ascii?Q?tmGKWT3B4q7hPeAI0RPIkPvu5SaWmh8w12kJxL8J3npeLfrWNHsB4Uu9X2jC?=
 =?us-ascii?Q?Wa+jm7+RT7UzVXfZKjLD3tCVckP/BkHTZ5GkdRTkvtKK4W7HkWvhybpFBUdV?=
 =?us-ascii?Q?h8dCMjlOXwXMew1DCjP/S06CmcfbP79n0mi54iuXqTAn4cldsvNvbZdneBu8?=
 =?us-ascii?Q?b2TH4adEjS5nIdCNchCZ9GNpWeRHZnKEHJXh/GqLwUyDPCoaeHLOW0DAwYFX?=
 =?us-ascii?Q?nc54Jlc4R3NVhXxJEt36LCC03n8vRE0i3Atg5HBIqs2PaXdFOAX6VWF7JHGo?=
 =?us-ascii?Q?0fQFAg3mXC25pbUnnXsBRJ6Sn7DfWlKxBkuv+1IGFeEV+CH42QO7dDs+NDPy?=
 =?us-ascii?Q?OUaMYNUCp8Ba04Gus/N4AskJ4cGg2qYeqk5hZpipkVaxue4D6x0BW5F8DrkY?=
 =?us-ascii?Q?dQKap4L0TtHKwgnKdrRiTLoZRrRMTEOeZtky6jzXl3EXbn93Lw5asR08QEx+?=
 =?us-ascii?Q?Z7G7IO88ZHQiTNZynP83Jw3EBEhda5WpnKEfU8S2j1i7TKteGUPgtzXocNyp?=
 =?us-ascii?Q?8Fw+t/WWATU4aWYGyOdLgmP1zJwXEr4pQwc0dQqRjswPeB0p0l4jkq7cWveQ?=
 =?us-ascii?Q?SPTaM1Irp9i4wIqLlkqwa7CalV88NcoKj/GqYij6AfCSDm+kQGER4g7dmrvK?=
 =?us-ascii?Q?0TtKQUgYeBfKhpyCw3XbU/RuS+R/7m5VffS3g8CggKh/AC/zp3X94bJOcwJE?=
 =?us-ascii?Q?2CIMsPKTMYkpf8i2cyCJ7G7/UC5nhiogcTBs+GZa9vv5zkreeizkQ6vYIgyg?=
 =?us-ascii?Q?QK9kH6rE5tVLAXJpRf+1EViJupFShk6wpszrARygGH9lO0HHMKJ7u/t2ZiS8?=
 =?us-ascii?Q?59lE+7GwAGufG4LNHzVBi7bJSbG1jXJ2C6+7cXZ/o+FvK/J+swCLEGPvNgld?=
X-MS-Exchange-AntiSpam-MessageData-1: ONhLjN9x7jlp0g==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f3f2fd-d374-41b8-2f84-08df0ed7ea71
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 01:07:42.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+UvRGsA10skhxh3T5ENj8xemGasjVSb5D6hTFoiXxBb8mwAWomwiqTba9dZr+kHQLF+UlidXc6t3YBtdCyVXk5lFX77Wn2D903Woh8bhAylJVLDWiUVdPdJkqi65bwUflB/xC0ZDHytd5QnPYql4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11739
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.162.37:from];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,sifive.com,dabbelt.com,eecs.berkeley.edu,gmail.com,lwn.net];
	URIBL_BLOCKED(0.00)[NXP1.onmicrosoft.com:dkim,nxp.com:email,oss.nxp.com:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 65C744528B
X-Spamd-Bar: -
Message-ID-Hash: OAHXQXLYHW2J4TQRIBXIOBP7I5IVNENW
X-Message-ID-Hash: OAHXQXLYHW2J4TQRIBXIOBP7I5IVNENW
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OAHXQXLYHW2J4TQRIBXIOBP7I5IVNENW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

On RISC-V, OP-TEE runs as a supervisor domain isolated from the Rich
Execution Environment by the M-mode firmware. There is no SMC or HVC
instruction to reach it: the kernel invokes OP-TEE through the TEE
service group of the RISC-V Platform Management Interface (RPMI) v2.0,
whose TEE_CALL service is carried by the SBI Message Proxy (MPXY)
extension of SBI v3.0. The M-mode firmware implementing the service
group (the RPMI TEE framework) switches the calling hart to the OP-TEE
domain until OP-TEE responds, so a TEE_CALL behaves exactly like an
SMC: it runs on the calling hart and returns when OP-TEE completes the
call, requests an RPC or yields on a foreign interrupt.

Add a conduit for the SMC ABI which sends the register arguments a0-a7
of each invocation as the service data of a TEE_CALL request and takes
the return values a0-a3 from its service response, using the OP-TEE API
UID as the service UUID. The TEE_CALL request and response follow the
specification, only the content of the service data and of the service
response, which the specification leaves to the service, is defined
here. The message layout is in optee_rpmi.h which is kept in sync with
OP-TEE OS like optee_smc.h and optee_msg.h. The SMC ABI itself, the
message protocol, the RPC handling, dynamic and static shared memory
and notifications are unchanged.

The conduit binds to a "linaro,optee-rpmi" firmware node referencing the
MPXY mailbox channel and carrying the REE and OP-TEE endpoint
identifiers assigned by the framework. The channel is requested through
the mailbox core to claim it, and its RPMI attributes are checked at
probe, but TEE_CALL requests are sent with riscv_sbi_mpxy_mbox_call()
rather than mbox_send_message(): OP-TEE executes on the calling hart for
an unbounded time, which cannot happen under the mailbox channel
spinlock with interrupts disabled. Errors reported by the SBI
implementation or the framework, which mean that OP-TEE was not
reached, are converted into OPTEE_SMC_RETURN_EBUSY or
OPTEE_SMC_RETURN_ENOTAVAIL so that the callers see a failed call.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
 Documentation/tee/op-tee.rst      |  18 ++-
 drivers/tee/Kconfig               |   2 +-
 drivers/tee/optee/Kconfig         |  11 +-
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/optee_private.h |   3 +
 drivers/tee/optee/optee_rpmi.h    |  69 ++++++++++
 drivers/tee/optee/rpmi_conduit.c  | 203 ++++++++++++++++++++++++++++++
 drivers/tee/optee/smc_abi.c       |   9 ++
 8 files changed, 312 insertions(+), 4 deletions(-)
 create mode 100644 drivers/tee/optee/optee_rpmi.h
 create mode 100644 drivers/tee/optee/rpmi_conduit.c

diff --git a/Documentation/tee/op-tee.rst b/Documentation/tee/op-tee.rst
index b0ac097d5..b56c32bf2 100644
--- a/Documentation/tee/op-tee.rst
+++ b/Documentation/tee/op-tee.rst
@@ -4,14 +4,24 @@
 OP-TEE (Open Portable Trusted Execution Environment)
 ====================================================
 
-The OP-TEE driver handles OP-TEE [1] based TEEs. Currently it is only the ARM
-TrustZone based OP-TEE solution that is supported.
+The OP-TEE driver handles OP-TEE [1] based TEEs. The ARM TrustZone based
+OP-TEE solution and OP-TEE running as an isolated supervisor domain on
+RISC-V are supported.
 
 Lowest level of communication with OP-TEE builds on ARM SMC Calling
 Convention (SMCCC) [2], which is the foundation for OP-TEE's SMC interface
 [3] used internally by the driver. Stacked on top of that is OP-TEE Message
 Protocol [4].
 
+On RISC-V the SMC interface is unchanged but its register arguments and
+return values are carried by the TEE_CALL service of the TEE service group
+of the RISC-V Platform Management Interface (RPMI) [7], sent to the M-mode
+firmware on an SBI Message Proxy (MPXY) channel [8]. The M-mode firmware
+switches the calling hart to the OP-TEE domain until OP-TEE responds, so a
+call behaves like an SMC: it runs on the calling hart and returns when
+OP-TEE completes, requests an RPC or yields on a foreign interrupt. The
+message layout is described in drivers/tee/optee/optee_rpmi.h.
+
 OP-TEE SMC interface provides the basic functions required by SMCCC and some
 additional functions specific for OP-TEE. The most interesting functions are:
 
@@ -164,3 +174,7 @@ References
     "TEE Client API Specification v1.0" and click download.
 
 [6] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model.html
+
+[7] https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+[8] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 98c3ad083..6434204d8 100644
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
index 50d2051f7..0b6cd91a8 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -2,13 +2,22 @@
 # OP-TEE Trusted Execution Environment Configuration
 config OPTEE
 	tristate "OP-TEE"
-	depends on HAVE_ARM_SMCCC
+	depends on HAVE_ARM_SMCCC || RISCV_SBI_MPXY_MBOX
+	depends on RISCV_SBI_MPXY_MBOX || !RISCV_SBI_MPXY_MBOX
 	depends on MMU
 	depends on RPMB || !RPMB
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
 
+config OPTEE_RPMI_CONDUIT
+	bool
+	depends on OPTEE && RISCV_SBI_MPXY_MBOX
+	default y
+	help
+	  Reach OP-TEE through the TEE service group of the RISC-V Platform
+	  Management Interface (RPMI) on an SBI Message Proxy (MPXY) channel.
+
 config OPTEE_INSECURE_LOAD_IMAGE
 	bool "Load OP-TEE image as firmware"
 	default n
diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index ad7049c1c..4b5a868a9 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -9,6 +9,7 @@ optee-objs += supp.o
 optee-objs += device.o
 optee-objs += smc_abi.o
 optee-objs += ffa_abi.o
+optee-$(CONFIG_OPTEE_RPMI_CONDUIT) += rpmi_conduit.o
 
 # for tracing framework to find optee_trace.h
 CFLAGS_smc_abi.o := -I$(src)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index aefe1e6f5..b90359988 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -424,6 +424,9 @@ static inline void reg_pair_from_64(u32 *reg0, u32 *reg1, u64 val)
 /* Registration of the ABIs */
 int optee_smc_abi_register(void);
 void optee_smc_abi_unregister(void);
+#if IS_ENABLED(CONFIG_OPTEE_RPMI_CONDUIT)
+optee_invoke_fn *optee_rpmi_conduit_init(struct device *dev);
+#endif
 int optee_ffa_abi_register(void);
 void optee_ffa_abi_unregister(void);
 
diff --git a/drivers/tee/optee/optee_rpmi.h b/drivers/tee/optee/optee_rpmi.h
new file mode 100644
index 000000000..89821255b
--- /dev/null
+++ b/drivers/tee/optee/optee_rpmi.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Copyright 2026 NXP
+ */
+#ifndef OPTEE_RPMI_H
+#define OPTEE_RPMI_H
+
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+/*
+ * This file defines how the OP-TEE SMC ABI (optee_smc.h) is carried by the
+ * TEE service group of the RISC-V Platform Management Interface (RPMI). It
+ * is kept in sync between secure world and the normal world driver.
+ *
+ * An invocation of the SMC ABI is a TEE_CALL service request sent to the
+ * RPMI TEE framework on an SBI MPXY channel where:
+ * - SENDER_ID identifies the REE endpoint and TARGET_ID the OP-TEE
+ *   endpoint, both assigned by the framework,
+ * - SERVICE is OPTEE_RPMI_SERVICE_UUID in RFC 4122 byte order,
+ * - SERVICE_DATA carries the register arguments a0-a7 of the SMC ABI as
+ *   little-endian 64-bit words.
+ *
+ * The SERVICE_RSP of the TEE_CALL response carries the return values a0-a3
+ * of the SMC ABI as little-endian 64-bit words. The STATUS of the response
+ * is set by the framework and is RPMI_SUCCESS whenever OP-TEE was reached,
+ * errors reported by OP-TEE itself are returned in a0 as usual.
+ */
+
+/*
+ * UUID identifying the OP-TEE API as a TEE_CALL service, the same value
+ * as returned by OPTEE_SMC_CALLS_UID (OPTEE_MSG_UID_0..3).
+ */
+#define OPTEE_RPMI_SERVICE_UUID \
+	UUID_INIT(0x384fb3e0, 0xe7f8, 0x11e3, \
+		  0xaf, 0x63, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b)
+
+#define OPTEE_RPMI_CALL_NUM_ARGS	8
+#define OPTEE_RPMI_CALL_NUM_RETS	4
+
+/**
+ * struct optee_rpmi_call_req - TEE_CALL request data invoking the SMC ABI
+ * @sender_id:	SENDER_ID, endpoint identifier of the REE
+ * @target_id:	TARGET_ID, endpoint identifier of OP-TEE
+ * @service:	SERVICE, bytes of OPTEE_RPMI_SERVICE_UUID
+ * @data_len:	SERVICE_DATA_LEN, sizeof(@args)
+ * @args:	SERVICE_DATA, register arguments a0-a7 of the SMC ABI
+ */
+struct optee_rpmi_call_req {
+	__le32 sender_id;
+	__le32 target_id;
+	u8 service[UUID_SIZE];
+	__le32 data_len;
+	__le64 args[OPTEE_RPMI_CALL_NUM_ARGS];
+} __packed;
+
+/**
+ * struct optee_rpmi_call_rsp - TEE_CALL response data of the SMC ABI
+ * @status:	STATUS, RPMI error code set by the framework
+ * @rsp_len:	SERVICE_RSP_LEN, sizeof(@rets)
+ * @rets:	SERVICE_RSP, return values a0-a3 of the SMC ABI
+ */
+struct optee_rpmi_call_rsp {
+	__le32 status;
+	__le32 rsp_len;
+	__le64 rets[OPTEE_RPMI_CALL_NUM_RETS];
+} __packed;
+
+#endif /*OPTEE_RPMI_H*/
diff --git a/drivers/tee/optee/rpmi_conduit.c b/drivers/tee/optee/rpmi_conduit.c
new file mode 100644
index 000000000..bc4ff975c
--- /dev/null
+++ b/drivers/tee/optee/rpmi_conduit.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2026 NXP
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/build_bug.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/mailbox/riscv-sbi-mpxy-mbox.h>
+#include <linux/printk.h>
+#include <linux/property.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include "optee_private.h"
+#include "optee_rpmi.h"
+#include "optee_smc.h"
+
+/*
+ * This file implements the conduit carrying the SMC ABI over the TEE
+ * service group of the RISC-V Platform Management Interface (RPMI). Each
+ * invocation of the ABI is a TEE_CALL request sent on an SBI MPXY channel
+ * with the message layout described in optee_rpmi.h.
+ *
+ * The TEE_CALL request is not sent with mbox_send_message(): the target
+ * TEE executes on the calling hart until it responds, so the transfer is
+ * done with riscv_sbi_mpxy_mbox_call() which bypasses the mailbox core
+ * queue and channel lock. Calls from different harts run concurrently,
+ * exactly like SMCs do.
+ */
+
+static_assert(sizeof(struct optee_rpmi_call_req) == 92);
+static_assert(sizeof(struct optee_rpmi_call_rsp) == 40);
+
+/**
+ * struct optee_rpmi_conduit - RPMI TEE service group conduit
+ * @cl:		mailbox client owning @chan
+ * @chan:	SBI MPXY channel implementing the RPMI TEE service group
+ * @sender_id:	endpoint identifier of the REE
+ * @target_id:	endpoint identifier of OP-TEE
+ */
+struct optee_rpmi_conduit {
+	struct mbox_client cl;
+	struct mbox_chan *chan;
+	u32 sender_id;
+	u32 target_id;
+};
+
+/* Like the rest of the SMC ABI, at most a single OP-TEE instance is supported */
+static struct optee_rpmi_conduit optee_rpmi;
+
+static const uuid_t optee_rpmi_service_uuid = OPTEE_RPMI_SERVICE_UUID;
+
+static void optee_rpmi_invoke_fn(unsigned long a0, unsigned long a1,
+				 unsigned long a2, unsigned long a3,
+				 unsigned long a4, unsigned long a5,
+				 unsigned long a6, unsigned long a7,
+				 struct arm_smccc_res *res)
+{
+	struct optee_rpmi_call_req req = {
+		.sender_id = cpu_to_le32(optee_rpmi.sender_id),
+		.target_id = cpu_to_le32(optee_rpmi.target_id),
+		.data_len = cpu_to_le32(sizeof(req.args)),
+		.args = {
+			cpu_to_le64(a0), cpu_to_le64(a1), cpu_to_le64(a2),
+			cpu_to_le64(a3), cpu_to_le64(a4), cpu_to_le64(a5),
+			cpu_to_le64(a6), cpu_to_le64(a7),
+		},
+	};
+	struct optee_rpmi_call_rsp rsp = {};
+	struct rpmi_mbox_message msg;
+	int rc;
+
+	export_uuid(req.service, &optee_rpmi_service_uuid);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_CALL,
+					  &req, sizeof(req), &rsp, sizeof(rsp));
+	rc = riscv_sbi_mpxy_mbox_call(optee_rpmi.chan, &msg);
+	if (!rc) {
+		if (msg.data.out_response_len < sizeof(rsp.status))
+			rc = -EIO;
+		else
+			rc = rpmi_to_linux_error((s32)le32_to_cpu(rsp.status));
+	}
+	if (!rc && (msg.data.out_response_len < sizeof(rsp) ||
+		    le32_to_cpu(rsp.rsp_len) != sizeof(rsp.rets)))
+		rc = -EIO;
+
+	if (rc) {
+		/*
+		 * The SBI implementation or the RPMI TEE framework failed to
+		 * deliver the call, OP-TEE was not reached. Report it in a0
+		 * as the SMC ABI does for a call that could not be handled.
+		 */
+		if (rc != -EBUSY)
+			pr_warn_ratelimited("TEE_CALL of 0x%lx failed: %d\n",
+					    a0, rc);
+		res->a0 = rc == -EBUSY ? OPTEE_SMC_RETURN_EBUSY :
+					 OPTEE_SMC_RETURN_ENOTAVAIL;
+		res->a1 = 0;
+		res->a2 = 0;
+		res->a3 = 0;
+		return;
+	}
+
+	res->a0 = le64_to_cpu(rsp.rets[0]);
+	res->a1 = le64_to_cpu(rsp.rets[1]);
+	res->a2 = le64_to_cpu(rsp.rets[2]);
+	res->a3 = le64_to_cpu(rsp.rets[3]);
+}
+
+static void optee_rpmi_conduit_release(void *data)
+{
+	struct optee_rpmi_conduit *conduit = data;
+
+	mbox_free_channel(conduit->chan);
+	conduit->chan = NULL;
+}
+
+static int optee_rpmi_get_attr(struct optee_rpmi_conduit *conduit,
+			       enum rpmi_mbox_attribute_id id, u32 *value)
+{
+	struct rpmi_mbox_message msg;
+	int rc;
+
+	rpmi_mbox_init_get_attribute(&msg, id);
+	rc = rpmi_mbox_send_message(conduit->chan, &msg);
+	if (rc)
+		return rc;
+
+	*value = msg.attr.value;
+	return 0;
+}
+
+optee_invoke_fn *optee_rpmi_conduit_init(struct device *dev)
+{
+	struct optee_rpmi_conduit *conduit = &optee_rpmi;
+	u32 value;
+	int rc;
+
+	if (conduit->chan)
+		return ERR_PTR(-EBUSY);
+
+	rc = device_property_read_u32(dev, "riscv,rpmi-tee-sender-id",
+				      &conduit->sender_id);
+	if (rc)
+		return ERR_PTR(dev_err_probe(dev, rc,
+					     "missing \"riscv,rpmi-tee-sender-id\" property\n"));
+
+	rc = device_property_read_u32(dev, "riscv,rpmi-tee-target-id",
+				      &conduit->target_id);
+	if (rc)
+		return ERR_PTR(dev_err_probe(dev, rc,
+					     "missing \"riscv,rpmi-tee-target-id\" property\n"));
+
+	conduit->cl.dev = dev;
+	conduit->cl.tx_block = false;
+	conduit->cl.knows_txdone = true;
+	conduit->chan = mbox_request_channel(&conduit->cl, 0);
+	if (IS_ERR(conduit->chan)) {
+		rc = PTR_ERR(conduit->chan);
+		conduit->chan = NULL;
+		return ERR_PTR(dev_err_probe(dev, rc,
+					     "failed to request MPXY channel\n"));
+	}
+
+	rc = devm_add_action_or_reset(dev, optee_rpmi_conduit_release, conduit);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = optee_rpmi_get_attr(conduit, RPMI_MBOX_ATTR_SERVICEGROUP_ID,
+				 &value);
+	if (rc)
+		return ERR_PTR(dev_err_probe(dev, rc,
+					     "failed to read RPMI service group ID\n"));
+	if (value != RPMI_SRVGRP_TEE) {
+		dev_err(dev, "MPXY channel implements RPMI service group 0x%x, not TEE\n",
+			value);
+		return ERR_PTR(-ENODEV);
+	}
+
+	rc = optee_rpmi_get_attr(conduit, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE,
+				 &value);
+	if (rc)
+		return ERR_PTR(dev_err_probe(dev, rc,
+					     "failed to read RPMI max message size\n"));
+	if (value < sizeof(struct optee_rpmi_call_req) ||
+	    value < sizeof(struct optee_rpmi_call_rsp)) {
+		dev_err(dev, "MPXY channel message size %u is too small\n",
+			value);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pr_info("using RPMI TEE service group, endpoints %u -> %u\n",
+		conduit->sender_id, conduit->target_id);
+
+	return optee_rpmi_invoke_fn;
+}
diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index 221939f72..3d5d54526 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1522,6 +1522,12 @@ static const struct optee_smc_conduit optee_smccc_conduit = {
 };
 #endif
 
+#if IS_ENABLED(CONFIG_OPTEE_RPMI_CONDUIT)
+static const struct optee_smc_conduit optee_rpmi_conduit = {
+	.init = optee_rpmi_conduit_init,
+};
+#endif
+
 /* optee_remove - Device Removal Routine
  * @pdev: platform device information struct
  *
@@ -1982,6 +1988,9 @@ static int optee_probe(struct platform_device *pdev)
 static const struct of_device_id optee_dt_match[] = {
 #ifdef CONFIG_HAVE_ARM_SMCCC
 	{ .compatible = "linaro,optee-tz", .data = &optee_smccc_conduit },
+#endif
+#if IS_ENABLED(CONFIG_OPTEE_RPMI_CONDUIT)
+	{ .compatible = "linaro,optee-rpmi", .data = &optee_rpmi_conduit },
 #endif
 	{},
 };
-- 
2.43.0

