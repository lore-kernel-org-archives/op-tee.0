Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE9DC79FB6
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:07:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id ED8C9453CD
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:07:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VS5iTiYW;
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A013243814
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 01:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfuQ6H+Sg8N6B5JAzYBKlb+rlZ+YM7bIlc/hmclc2+mnuzVYuX/ghdGCgni6MT1ehKJUoWJiU7knFc3N2jZIoPVD8LirzY29Wz6PdWNf6ZYG9aim9jD5sz24SA3eGyiOKSgrIbJTnYHueSEXYYMNkdROSitsZhPHyU09u8dW7gpSYEP/Qd594Z2MkfKsn8mR9grS2Nw7KL0k03YwQPgBqNU5ZJ7D/9cZW7iHsPJlrNzuz8qL1wWbJVmpifZLdnnI3s5gc4nbh2yDLTUi066mcYQWiEAQWC8Y9ykzrYaoc7N9DdjUYDM49wwR7fylCtcauuX57rUngjkwGaHHxd7CIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGN7LcnBM97XktJVqW9gD6ISYKox8s5VA6hBgJrr2ZQ=;
 b=v85UGhjD+ucXw4b6ZEA2mm/0Z+V2WkR2/VVgBaJ/581GOxnQIvK/44mff65LNn74OOn0xCcB83+wmNC9pMkG2MTdmOMKmNPlE51Hrqg162E9RCAPy/z3mNzLfqxQWE+D8ste2n9jc9OySSiez+AVnYS/2JtM4xPkRIOCZ21gbxNG8pZTbMJSb7XSg6Ioszh8fPJY3xv0DybhZ6IRwH7lZExWIJ4yHi0FGaW71HIM7cPh9BWDoGCjLoRYJwPMLhAlbruX0sDTzrD0x8Ouvra9yOmMFhxPc+KP06D+0AahJSX/eJ/LHPd3Ekgrxql7MXfFtbGxtwZnavP+nGiKdXfgwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGN7LcnBM97XktJVqW9gD6ISYKox8s5VA6hBgJrr2ZQ=;
 b=VS5iTiYWz/6tEox4HSAwWSbCSQC25k0ruQ1PwMSQGPTtkTvO73a+kdYbQU63fV/FUzGDKma5DWYiBiQ0gP1OFFtQXK/7zaclyuBtBMsWCGbYR8Ycfz9g4hF+nvO0UNbDRPLTAFm8jQLnxbt2OxCOiRx6aH5JY8ct7trTcXKD4+dmXONqwjS5UcQwSgQvYyub4ju9UGQ6LQGm+Fqse4dWhfuS+XnWtlxBIqfQPKtW9ONG5+8NfcdJCvAqq6uTKnXamOe8dps2pgwAqgJOoRkM4N7TfZofkfNQRjw/5cUtvZVCehGFR0Wy0pUutlip2bwvfERjTIlihyGUX2wBUFkwBA==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 01:07:06 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 01:07:06 +0000
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
Subject: [RFC PATCH v1 0/6] tee: optee: RISC-V support over the RPMI TEE service group
Date: Thu, 10 Sep 2026 03:20:51 +0200
Message-Id: <20260910012057.106966-1-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0038.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::18) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|GV2PR04MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: 173ebbcf-8204-4875-2b22-08df0ed7d4ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|23010399003|6133799003|18002099003|56012099006|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	d6khGMaO7EDs2N4TeMFj1yTTxwpGB+gh9si0B+y55AdCLrWR+wZ7upMjlLFh/G/F1Yx/3E+2kZlXWeXfRsVSGa59LgxbjwarIwnSggj7+Us8lhTQALmiFkc92HrYAr0AoPSGyFTntZ42H/OapM1rXYiWs/CHiMDMXd0KteZViuD7Zr8F5cyZoyzuhKKt1/sDGiEuFmsMse0lrzRsDnhCGRZe00ctIhwHIqZgO5gUQtqi+z2sHX754MQOzmLZ5hUv01ti+WCNWcNI27M4eBJJLlEhTZsEhuWxPWryqbQXRrVONYE68jvcAvZWQpu1VI2aWWcdb4UDiRJJfnlAmsiIkd0/d+965GG9kTnHdvWNR7lbHi37HEscmTVLx3sMAS93EuqtgRErCKEKmBF/PHjRP/aIF9oMzx54lePy+l8P5ZvVpwgWiy65j6jchDLEruBjBO/mge1pkJM8Yn8uC9sr3/T6dfQFUKUWrCo5ww++yR/E/SfcPrGvuQ1tEyiCPoiLD/WTNrV+vkxu7aip2BpYkfLJArEtYMlbBdO4oOSlUy9+Fa84s4w/DVSrV6zfToDDnMw0/4Y4wZ/5TVQEGL4/bRmywDhCikh97bwc/6a13WXPzRPBAVMlTPfoufs+OuzU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(3023799007)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TY2H15wv6HJVqbT9667ic6hSok30FsbL/8R50jcUtm9qzGyhp3QS4omgvEw3?=
 =?us-ascii?Q?5/7J0IowpYZ25NcCCpnrj2VJFDnbLYwY5oizs+YjTQRWWCO8RJn2xn/c0SKG?=
 =?us-ascii?Q?4n5Y1YdtjIWUy4okkfEJ0f+l4Lkd+hcI2LuD8r8OTCWWsT04yJ0of4alH5DK?=
 =?us-ascii?Q?snc6ChddOFQZZQOn2h+AiyzAkwqRRxQnlt/Jpa1kBfDzBhIZS4LIgOZQr0xV?=
 =?us-ascii?Q?nfa9UjfZNvQahVKejav+r9l1vds8TgbWU8LlgWf72TEwcpkHwU6gnhgQ07US?=
 =?us-ascii?Q?/Mvmi8GSBtUdAlE7BnXYMaHma28DStL2E4hVnDQEWZ07a5aF+pmDtsgfWmZq?=
 =?us-ascii?Q?WJUgQu7XKoPkOP9POay1Xt0KRV9PI7CI8rSEgm5WgxVI41OaxZWQ42PcqRTX?=
 =?us-ascii?Q?P21UbaOITjaw+1RjPv4vA1GdFfedVsNpM8WSX3nRkNrNVJ9yZRMuYJA3Z8MC?=
 =?us-ascii?Q?yCBFdkQIPL/3HQFiFI+/97pbfnlpwU2pQOs1ISnPibVRYmTjSHzmFcDGvKMQ?=
 =?us-ascii?Q?dmykHYz40phC/Zf4XXzLA3NOaWuY3d/hmUIEgzNMnYCzJ9yVcMgWqscjZRRz?=
 =?us-ascii?Q?w7Lf3IiDMmDwgMATIdGK84vGGXds9qiVdk7jaODzMBclYZV6FTa/3+NGhsXd?=
 =?us-ascii?Q?T8M4cDO9YeLMEXzqlcwSfcgbj7EWoGtD5aiJeDXMTraAkSYi+uZ3kf4o5aiN?=
 =?us-ascii?Q?BCxLgSTQdGFXvlzYmudyzF9vnpShKz3n9LoPV10no4J3btqaYVTjlEncnhwk?=
 =?us-ascii?Q?k2FGBZp3x/vOJlF/roL6DMBvWDGekDk4fLEKBhbTbuuxTbh/kf/wswWn3DtG?=
 =?us-ascii?Q?5CjpX8/ec3ZhMTq2N3SS1KVXFCr6LY/1/R+XvPP5pUjL5SjWWjE62dOq21cJ?=
 =?us-ascii?Q?TLHTYBoB5B2/q9agzS2rR5rZuamNE9Faaucouagoo1bI+wBfDT0q2ZHJ7bIF?=
 =?us-ascii?Q?6vWDpigQs4XreeeVMrri1F0F0gyPvdhOb3NfqNbco85do6eL2WxvpOWD+qzq?=
 =?us-ascii?Q?Mq0V/zVOvkxpyXKRwsdv/ayOIuLagg71qireAQ1YQihZG0+HcWNABdjKLB6d?=
 =?us-ascii?Q?OgFKK3GVw98maGyN0OviOa/0fzcyi0xx09lSPwWw7CLVq6HZ0E+EWzmIU7ph?=
 =?us-ascii?Q?w6bKBhDSfkvzgB8AVDT6RS1CTROzmOuF28C3OKlC7Rk6zmJ1lRw/5cR5XwGl?=
 =?us-ascii?Q?ee8Ko5dpkg8Z4KlxXuCifgpvo/mMk7VrP4fYqh47Su9odp14TXsEUrBESKx0?=
 =?us-ascii?Q?+JudMTyzGz9fdqNIYDcSVPB3PzeGQnn9C5QAw3UhBa7wK31quLqTpn8/V3DV?=
 =?us-ascii?Q?/3UCt9gk9iRpHNkSSCqc+Eew96bZey2uOrEU1+fO1SINNaUsKUXjIvQMTa2W?=
 =?us-ascii?Q?MSPsoGoSQ1t/YsXHY1K/ub/sDo4pkYrbVw+b5uepndBMM8lv+l/O1QUMB1si?=
 =?us-ascii?Q?RgFrzOYOs70suL06KIublmk8K8EzmMGyCwFXm0P20TyanUBYbR3LaVS+nLCo?=
 =?us-ascii?Q?MAE0DVffRtH07KgO+fKApLa5+FuRZKyGRHnMCVAtMUMr973yeqH291NynCks?=
 =?us-ascii?Q?gz5Axf2KlptMLuNYOUWT9SgnZ0Q2UIv6+pox+lBTyFk6RVtDB+vdl4BV84SZ?=
 =?us-ascii?Q?IdQXL2XciggAuHZ3oAV+Bbofs+CgvYD7uaMg3ivIhObfV00MmkieFT0IB/Zt?=
 =?us-ascii?Q?BuoKeKNttT7jftO3kt9ak6ZJ2cCOTkR5vh7KvD1G71agsSTFCZ0YdbzQGnWN?=
 =?us-ascii?Q?BqwVRcWsa791dVQ5pV6EtWtcvtyKaS1mKz5TL+p093oqP0JGoTqgWh0+syDy?=
X-MS-Exchange-AntiSpam-MessageData-1: FBP0BswDTRcDnA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173ebbcf-8204-4875-2b22-08df0ed7d4ab
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 01:07:06.1505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtlUe5KE0joQyhzc+SisoEU2F7SKrKkvWho//IDrzzn+MH5tPLV4UGuC/5OKvyJAemkp/4Pxy+Z3qDZmjsUitCMw+PLG3l5+GL8JTvgdsXlF3GFudbXvTQBDZt5Lhmggio8xXYTw2j+fOP2VxT6ZyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11739
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,sifive.com,dabbelt.com,eecs.berkeley.edu,gmail.com,lwn.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[NXP1.onmicrosoft.com:dkim,mail-northeuropeazon11010068.outbound.protection.outlook.com:rdns];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[52.101.84.68:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.84.68:from];
	RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A013243814
X-Spamd-Bar: -
Message-ID-Hash: FHLIUMAPWLIEJXSKOY6N3W7HLQZQP35I
X-Message-ID-Hash: FHLIUMAPWLIEJXSKOY6N3W7HLQZQP35I
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FHLIUMAPWLIEJXSKOY6N3W7HLQZQP35I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

On RISC-V, OP-TEE runs as a supervisor domain isolated from Linux by the
M-mode firmware. There is no SMC or HVC instruction: the firmware has to
switch the calling hart between the two domains, and the way Linux asks
for that switch has to come from the RISC-V specifications rather than
from an ad-hoc SBI extension.

This series adds RISC-V support to the OP-TEE driver by carrying the
existing SMC ABI over the TEE service group of the RISC-V Platform
Management Interface (RPMI) [1], sent with the SBI Message Proxy (MPXY)
extension of SBI v3.0 [2] through the in-tree MPXY mailbox driver. Each
invocation of the SMC ABI becomes a TEE_CALL request whose service data
holds the register arguments a0-a7, and whose service response holds
the return values a0-a3. The M-mode firmware implementing the service
group (the "RPMI TEE framework") switches the calling hart to the OP-TEE
domain until OP-TEE responds, so a TEE_CALL behaves like an SMC: it runs
on the calling hart and returns when OP-TEE completes the call, requests
an RPC or yields on a foreign interrupt. The SMC ABI, the message
protocol, RPCs, dynamic and static shared memory and notifications are
unchanged, which is why the conduit lives next to the SMCCC one in
smc_abi.c instead of being a new ABI like ffa_abi.c.

Specification status, and how the series is split:

The TEE service group (SERVICEGROUP_ID 0x0010) is part of RPMI v2.0,
which is in development: it was added to the main branch of the
specification repository in June 2026 [3] and is not in the released
RPMI v1.0. Everything in this series that depends on it is kept in the
last three patches, which are RFC until RPMI v2.0 is frozen as required
by Documentation/arch/riscv/patch-acceptance.rst:

- patches 1-3 only rely on SBI v3.0 MPXY and RPMI v1.0 as already
  supported by the kernel, and on existing OP-TEE driver internals.
  They are meant to be mergeable on their own;

- patches 4-6 add the RPMI v2.0 TEE service group definitions, the
  binding and the conduit. They implement TEE_CALL as specified; the
  only OP-TEE specific parts are the content of the service data and
  service response, which the specification leaves to the service, and
  the OP-TEE API UID used as service UUID.

Why this conduit rather than the alternatives:

- A raw ecall to a "TEE" SBI extension, as used by the current OP-TEE OS
  RISC-V port and by the RISE reference firmware, relies on an EID that
  does not exist in the SBI specification and on returning four values
  from an ecall, which the SBI calling convention does not allow.

- The RPMI MANAGEMENT_MODE service group (RPMI v1.0) is defined for UEFI
  PI Management Mode communication and its data is the MM communication
  buffer; carrying the OP-TEE message protocol in it would go against
  the specification's intent and collide with its intended users.

- An implementation specific service group (0x8000-0xFFFF) is allowed by
  RPMI v1.0 but would not be a generic OP-TEE conduit.

The one non-obvious part is patch 1. An MPXY message send is an ecall on
the calling hart, using per-hart shared memory, which returns once the
message has been processed. With TEE_CALL that is when OP-TEE has
finished running on that hart, which can take an arbitrarily long time.
Sending such messages with mbox_send_message() would execute OP-TEE from
within msg_submit() with the mailbox channel spinlock held and
interrupts disabled, serializing every hart on that lock. Patch 1 adds
riscv_sbi_mpxy_mbox_call() to the MPXY mailbox driver, which performs
the transfer directly in the calling context with only local interrupts
disabled (the per-hart shared memory is also used from hard interrupt
context by mbox_send_message() users). Harts proceed in parallel since
each one has its own shared memory. The channel is still requested
through the mailbox core so that its ownership is tracked. Opinions on
whether this belongs in the MPXY driver, or whether the MPXY shared
memory handling should move to a core helper usable by several drivers,
are welcome.

Endpoint identifiers: the framework assigns an identifier to every REE
and TEE. The only way for an endpoint to learn them without firmware
help is the optional TEE_PROBE_SYSTEM service, whose response is CBOR
encoded and cannot be parsed in the kernel, so the binding carries the
REE and OP-TEE identifiers as properties that the firmware is expected
to fix up in the device tree. Feedback on this is welcome too.

Known gaps:

- The framework side (OpenSBI: TEE_CALL forwarding through domain
  context switching) and the messaging return path of the OP-TEE OS
  RISC-V port are being upstreamed separately.

- The service group defines no notification events; OP-TEE asynchronous
  notifications on RISC-V are left for later and OP-TEE OS does not
  advertise them on this conduit.

- The byte order of the SERVICE UUID field is not specified by RPMI;
  this series uses the RFC 4122 order. The memory parcel services of the
  service group are not used, secure world accesses registered pages
  directly as with the SMC conduit.

Testing: built for riscv64 (defconfig plus TEE/OP-TEE, both built-in and
as modules) and for arm64 (defconfig plus OP-TEE and FF-A) with W=1 at
every step of the series, plus dt_binding_check. [TODO before posting:
describe the runtime testing done on QEMU virt with the OpenSBI and
OP-TEE OS changes mentioned above, e.g. xtest results.]

[1] https://github.com/riscv-non-isa/riscv-rpmi/releases
[2] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
[3] https://github.com/riscv-non-isa/riscv-rpmi/commits/main/src/srvgrp-tee.adoc


Marouene Boubakri (6):
  mailbox: riscv-sbi-mpxy: add riscv_sbi_mpxy_mbox_call() for hart-local
    requests
  tee: optee: select the SMC ABI conduit from the firmware node match
    data
  tee: optee: teach the memory type check about RISC-V page attributes
  mailbox: riscv-rpmi-message: add TEE service group definitions
  dt-bindings: firmware: add OP-TEE over the RISC-V RPMI TEE service
    group
  tee: optee: add a RISC-V conduit over the RPMI TEE service group

 .../bindings/firmware/linaro,optee-rpmi.yaml  |  79 +++++++
 Documentation/tee/op-tee.rst                  |  18 +-
 MAINTAINERS                                   |   2 +
 drivers/mailbox/riscv-sbi-mpxy-mbox.c         |  60 ++++++
 drivers/tee/Kconfig                           |   2 +-
 drivers/tee/optee/Kconfig                     |  11 +-
 drivers/tee/optee/Makefile                    |   1 +
 drivers/tee/optee/call.c                      |   8 +
 drivers/tee/optee/optee_private.h             |   3 +
 drivers/tee/optee/optee_rpmi.h                |  69 ++++++
 drivers/tee/optee/rpmi_conduit.c              | 203 ++++++++++++++++++
 drivers/tee/optee/smc_abi.c                   |  41 +++-
 include/linux/mailbox/riscv-rpmi-message.h    |  25 +++
 include/linux/mailbox/riscv-sbi-mpxy-mbox.h   |  23 ++
 14 files changed, 538 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/firmware/linaro,optee-rpmi.yaml
 create mode 100644 drivers/tee/optee/optee_rpmi.h
 create mode 100644 drivers/tee/optee/rpmi_conduit.c
 create mode 100644 include/linux/mailbox/riscv-sbi-mpxy-mbox.h


base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
-- 
2.43.0

