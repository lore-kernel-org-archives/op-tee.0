Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB46C88E6F
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:40:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B317B452F5
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 17:40:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QlSKQHky;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7B606452F5
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Sep 2026 17:40:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdMuVJ0/csf4+TvxIeupMo+QZWkJcF4QO5ERmfYbq6lgqdExAQsoObQxp6VxdQkV0PKAU+OvanNBTLlA2UrnJd+Rij8rebtxblAfkG+4KQ7W1EBIVjfUWog4Ze4lGcPy4GcU0BmKwipHH4cf8wPmwbXqVeez8ojvuYrWezmJVkJMdz/WbDqetR2LuNI1MXOzOpADYH5wsNu5ghMiTNV5G+Mw+hDV7RSk/LYwFRTpeovNSj8emVCoNf+3frihMZRqZL+nxmG8lp1vi84B0MHP9bKltgMUGY9MBF2pF6R83dPymPP7pu9bwxGRxsvy/GaGkzuJGI0XclqWhEExWH4SSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFDSJ/Kea3zdi5BzKT1ulBE8Fmf4TDFqawXkdFzwVbI=;
 b=gaz2op5vzEy761AyZZsWPK3HfwNYmYI8dKzEHb+QqQpbtNW92U4eE/1Wtv1L4nOyhV5BnETCJoIlRu0EmezqP8UDHIlqYPxWTH0vOwqcjXMa4iN3+/pTdU98esLn8rvvZrWA60Wmoz6PQfSUCm/elvGcIr2qBP2I5NjMbZ/P3YpGfljYb+iQUBHt/wRO22mxTn27ycXhQ9ukcjVwG2sHDGhMl4moUXArazkXdHMwwdOnIV73Vko7Rly+NiLeS8LkWaryrkt5UVAonsJSpFXt7EyVAhCPW5bhs6dXYi+z7mzQsIHRmsmyXWyOvTqHrjoxA7V12hMKMc+d9X1fkGix9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFDSJ/Kea3zdi5BzKT1ulBE8Fmf4TDFqawXkdFzwVbI=;
 b=QlSKQHkyideg+o5pOT8wf0edG7sqe0f3Vkjr+9VytQ2SJEg9tctUzWaem7fENvMZhxE/T76SBhfWb5WmoJhM+gsVg0pXHj+1+vdEcTgF7PVYmVLdzlXM/ESBx6WpGXfp46xQGM7LM0aWT33E5Rf4EMa8egfAoj60Nz/iHg2uzNKpD/FWWCHCOxgWl/ImmQnYDT2wBkorpy1K0VUb67sO14e7nDFrdicjnWzVhE0gchx65y1a7bkyMs7smiO+nIV/Z3wedUqJQh8ZbeBlc4eBzfYKVsffh0bu2/mWmO+KO64tCjW39GX4IGV6RHj9CK0kSXAAcE6d9TXuwMxcfsyX9g==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by MMZPR04MB447860.eurprd04.prod.outlook.com
 (2603:10a6:190:55::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 17:40:42 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 17:40:42 +0000
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
Subject: [PATCH 0/3] tee: optee: prepare the driver for RISC-V
Date: Mon, 14 Sep 2026 19:54:32 +0200
Message-Id: <20260914175435.118303-1-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:930:d2::23) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|MMZPR04MB447860:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cb2f56-39cc-4681-94ae-08df12874c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|23010399003|56012099006|5023799004|11063799006|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	do6hVAgRzg2e/iRp3XMAwu7MtmU5GBQ40zMpmvtXNjAwnR28CKDndCJZKlv4WbWiDHcP5NQ/PvnhbjMGucUPX43vwSGp1AfIaVIThVcNfmA6NyXMfCwg+9AWsjnBksAnTmOUqHxPK2820u9Nj5haXCa6mJwmFCNxpmG/IAhyTdvnKC3qLLsXtpjXWDNimr8mpzHXDGAk4hL6nMK+uXxWjzxdlgXEYYUNMU5W5PJ8O+SZDabgu+VI6xgqFtH3qBiTu9a4YfSLg34wdVO8UagFbMWEnCMXAbMxZ0CzG9BfY1dQhlhhGVOvGu8FL+q5zxeO3hGrSfVuBvUDYpaXnZjxtBBBnNOMWvS0jIz1ug170AorH22q7Ztqw1mzu8KJ1Das59R4SQmjK/D7cP2yJnqu/gVAx2ZtrGdwQzhvhGhFUlmSwlb5Z4wENa0w/RrLUZfh1iZZbib2Vk8yLtaOZNMcnsquencfy6aERmh4V/zTfH5SCvOp6ytjWsfsgOYOzO/y1ru6XVTeIY12K3yKRxV6AtHS2yC3BwLGTaZTq77zjPt63NtHjR1p0U5GKi0IGBNRKYQK3IpRd2cDCLY+IUY6urmlK31JPHWQPLAG8hun8txJuGcOumnPYV+MZ1NpJACoa1k9d1BRH8SDUA9lyKSpMWzGj2A21yDoY7nnCpXRQf0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(3023799007)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+U0XlpURvK0yTDSz/1f34fG2MMS3dY9vAfAa8SrqIJQw9oOPegQoDYpGQEt1?=
 =?us-ascii?Q?QFMVi1P3HXj2SM3c/EjaS2MvUloLFVtMMpDj9KdIniay3NpCVq8Esdmk6zTp?=
 =?us-ascii?Q?X8wE5a+Q/CokFkLMopMPJbikOY438Bxxl1kBy3ARKSAbeKIr2/fBYd4h7AfW?=
 =?us-ascii?Q?FVwjmp604mT14A10tSBSZj5BsYiVE+goHKwVPm6PPMLqr/6SuO2ZhxtMnrUG?=
 =?us-ascii?Q?CskYwyZXdDC18wDevzv8OFsDmlJOSr9L2JylUpnsiugO3ITtn2dEJ9OleF0A?=
 =?us-ascii?Q?yJo1oOJJvH3jZQua1/tDHvvkZSjhXADMI30Vm+fbaoxO3znhlQNVWBvLQdNK?=
 =?us-ascii?Q?FVbZi+WuRVmEnXo8WIMKjtAw3/g21D1QN4aLKtGLo8j7ficIg1y1eysG92N6?=
 =?us-ascii?Q?wz+bg6OuNwx4+dqWh+TXtoSZhnt1+v+BSxCUWy23OU2AkJGOOUQGAR7j/yj+?=
 =?us-ascii?Q?Gj4g/LJxolE54yC+UkihH1hbhL7LxjuKG2FmiW48q0tPttQIcEE1znuCu1Iq?=
 =?us-ascii?Q?yB69URZfha831SRS3wjHmPVukOkFHK0XYhuN4en1v04HxUQPMxFTf6ka73z9?=
 =?us-ascii?Q?e+MqFegkT3T1dkKj2woAid5f/38QnRINCURUb0wX5ZckuEfOvRBDh6AdsyQh?=
 =?us-ascii?Q?fEu5kjgPkZfE0ht5jIdkSoHw6cXmxq2E+FE1R/7vKgX/OX+1mRgcq0cbexXv?=
 =?us-ascii?Q?RPrc+iUZowOqUTMn1/ckx+WilzK2loDNnMvrB2XvuLoIHDi261V2dmTnQJJQ?=
 =?us-ascii?Q?DPdRj8sNImuF67jDucVu8AVq/yM8AsytlavB28vrvWbi+ojrdOV0+dfhPrSx?=
 =?us-ascii?Q?PvzKURlTbJrvp7GiZITY8HEG9jBxmlFu/ie5aAM/xebL5kRSQapr6sC2oD0U?=
 =?us-ascii?Q?s5RlYH3BExaHeuEWOyyv55BvpYAM5nUs4juhANBRUlBovI9ECFtzuV8hUIw3?=
 =?us-ascii?Q?3tq+9ykNyYelJwVQ8NUa/zSgv/j1SgXlipNVHRfFidpt0WwUY8NExfCpsu4Q?=
 =?us-ascii?Q?xuURd6t4WzIOU52KHzeEZe+B/vxTupWIJN4oGQbRiwsUuilAJYMazI0Sn8H9?=
 =?us-ascii?Q?Ix3ZBsd4DG4UkV6INlN2aScwghnS5Gv/v+b9DmiPpykOUEoBqAzUbgbP9/ss?=
 =?us-ascii?Q?/4cS4Sbb91e1w4ePSdhqQWTj7gOwftbVWmx8qOcdmh5JkwJYijfrJMRkpe0Y?=
 =?us-ascii?Q?Pivhq1oNYHEr9rIQJQCY8KPgcJciDrgZxu1lJLPgjQAvrsO75+hKAjlVS2k+?=
 =?us-ascii?Q?J7ZCnqoPcoXhbq32L1bpzibZPmm1PihWaC6R2RiAAFANcqULtRrWFlQSfSVK?=
 =?us-ascii?Q?TYTRKy42naYsW3OMVzpmprjg+GjEG9Pt55NqCvQK2NJotCrjKuAThOYb0E//?=
 =?us-ascii?Q?jx0vj9zqTaz1jEj/IeepZ/kXV/fOMXU0cq3spA/6RRs6kOsEuBhOKQOkA8YP?=
 =?us-ascii?Q?JvotR3oSAdaoWout2mhmIbb6zUFTzhgS43tfUcP3SGwKGUc0CGCG50ukNuM+?=
 =?us-ascii?Q?d8KbecLwDJ8ckbaXPaGzecgaN7KgsMXxqJBbCgmgAx8YaLQpVhubbXTOGoTL?=
 =?us-ascii?Q?xuLaZGBx+xD6a+OPUwQqbagoSPpFfp4gOxcB8UqmL6/BAFWc5h+7qWtCANvs?=
 =?us-ascii?Q?qwHvA7ckSJLSZ4e7moevkSkTIhSRwbrWsOhA562EeO36nZIO/vnkTW081uF7?=
 =?us-ascii?Q?MCUUKgRdLx/eUj0F/ogDmAESksD4N+8ZfMCmza7iO34bzUO5/a/ALn8Pj9v5?=
 =?us-ascii?Q?GuttJkm7+IJIaW+Kc3goQ4XDgmkmiyEuFmFuDYYwWg3mLPypPzI0Y282dM7A?=
X-MS-Exchange-AntiSpam-MessageData-1: h9tz5e5FYAIrTQ==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cb2f56-39cc-4681-94ae-08df12874c37
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 17:40:42.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9HD1WmM27yaM0doNPsuv5M0qePYw8UkQT48KOGqei6EySjHVIDY9dpNwlD1CoKng9jaEXW1Fs3ZiEaro1YcOzeEWUmDSOH5RZHFNETxGHDl9G5gKVSGWGD+VFkg3DBKZMFPHFDfz14G3csttKManQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB447860
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.25:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.72.25:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[nxp.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7B606452F5
X-Spamd-Bar: ---
Message-ID-Hash: TKKY2BGMZKX6EWWGUG7LEVGXHNHVTA6I
X-Message-ID-Hash: TKKY2BGMZKX6EWWGUG7LEVGXHNHVTA6I
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TKKY2BGMZKX6EWWGUG7LEVGXHNHVTA6I/>
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

Testing: [TODO before posting: riscv64 defconfig plus TEE/OP-TEE,
built-in and as modules, and arm64 defconfig plus OP-TEE with FF-A
built-in, modular and disabled, with W=1 at every step of the series.]

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


base-commit: 827751b699b79a6e569983359c02dce67f81b94c
-- 
2.43.0

