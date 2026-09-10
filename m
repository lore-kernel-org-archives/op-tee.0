Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC6EC79FBF
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 16:11:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 65BC645218
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789056701;
	bh=y1lcczOXV3cXHmL1eeY5P/lJ7hwsShNB3oVhGgqn6ts=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=B2YwqYLSyr8dTNfd2nlIrao8AZsWXmEYwmRIRLNPahLXgxSOBtwCXamPMVGjMQwiU
	 0/rbNnFUzmPJR8QEvZQHPQXYxjWwReog0oGbMTH0oqfG5cLNHGUxoTM9ONcQIitN/L
	 KvsuNwtWlVX0bTCewq1bw3rvZUQypVklK5A9blrfVDz5LGXTPexSIQBF+lgqp/AIu8
	 mx7e1o8o257NZSJtc0pYIWUQzGO9Bl9bskR8iyfzOo4iOlvjsfpbcR4Bhb2/b7y+oh
	 1A9MwadpvR5WqSGJ0W4EWUIQveauQwRuEH+Unq8hu0pskj8bIC2JEVqxhNbVJrK5oN
	 MdTAntTRgwg9w==
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1B1E1438BD
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 16:11:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=dw4JeFh7;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DCzjprHG2kBqCXaHsrWjQZnMc+CdIP1K95GfE3L8o8z3+UKoznArWLfMi8cuM1g9RPLUhQJF9xpGUX5eRBDcb9csgswo6k7IR8yP9tDTH5jvZeDtbfBq4+EXGNRAn//jE2wsPXWT3V9dd7tSOI4HbEuPKEOoeQPDysnokWhBhn2CDPwywepuTWNCqAtIwA8Qyx5kaBcULoJIjx+4feOD+JsJfE4FLVylZHQQk3Ymb4pNONWJuHmkASkd3zc9Qi5Ji/3NXYdNzcy8oTaMEVzbxzP4BEJkfEyVvvY++7Ip92/vFNpHQ/HxG/vbihC33Ii9adMVvlQ26K+NttaaGEeCdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhI3XxyjQJ9AeqbGTgUANmlzQ6x+2qQHXC0I+KLNRKg=;
 b=rz2DM3uPi+PjbKdyrB+wpJMD5WCRBIYSo776eAZZcl3Zp8b+l708XW0JBBrcH8yjfOpeyl3UYIQUYaR4Mu2rLJjEjh03UQ0SgAbz5AObbSJoc7Y2wlCftMEWEFPNccu1iozjzWGD1TgLj8RdxVRWWrUvIdstkppgoe+ovxPZ7VqruOO/tI0opq6A58KxZM4wirx/xoe+au9dBwaTUciaKeyQo9o27TKvzFsRFsEt0sZO+phAoyh/OrH3c4+EyN7k42mhREXV7nNDKGCcLA+guE8sSBuaIJdx57hTBJyu7o2y4PNFIOCFiawR2cs/pNTpd0OdUmqENBLTzXaMqCesaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhI3XxyjQJ9AeqbGTgUANmlzQ6x+2qQHXC0I+KLNRKg=;
 b=dw4JeFh78mPRX/fEZwLfvaT5AlaBjRmOhKWbDl7Rq8qsqjBG1o9QwFBLGf40uh48+vlMP2YEUzPNGNzZcfbM9lXE4PNFLMEAPBxrYvlfofYMFGVag7MLs6cJ3Vj48PA89Q+9UzD47d7AIheZJT1s4VNtptdfe8oMFLI8oFrKkCU2jNwcPqhEVicsaqvxy8GKndrRkiGh0N6bMcIOxgfWUkKQV8sKy98a5KRImp+y1rwnEoUDDgimdoDmXZalZKsUWsdZRfX9UwmvA6ZCb1YqifOe4J1gInk5WIrHuttUFHHvmBKYq45UEBTdEPBa74fPAC/x9CE7VlgCOkEQr9EK2w==
Received: from SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13)
 by IA1PR12MB6329.namprd12.prod.outlook.com (2603:10b6:208:3e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 16:11:26 +0000
Received: from SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961]) by SN7PR12MB6744.namprd12.prod.outlook.com
 ([fe80::28d5:2119:63f5:9961%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 16:11:26 +0000
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH v2] tee: optee: ffa: support shared memory offsets on large-page kernels
Date: Thu, 10 Sep 2026 16:11:24 +0000
Message-ID: <20260910161124.1561170-1-mahantesh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904134732.1072541-1-mahantesh@nvidia.com>
References: <20260904134732.1072541-1-mahantesh@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR06CA0021.namprd06.prod.outlook.com
 (2603:10b6:303:2a::26) To SN7PR12MB6744.namprd12.prod.outlook.com
 (2603:10b6:806:26c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6744:EE_|IA1PR12MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e06d745-60b1-40f1-5413-08df0f562a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|22082099003|18002099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	LxD3jpB/v1Ij4wwFe8wExv37OczL9hvJc7EezxZxmRUjD6qtbTPhob4zHKK3wVNj1uEFSbOGZTNFDTx7PxXZmX8EYFacDaIFpNXRs+ZBtGAmkM1qA5WIrvO4sfBy0ZgB1x3KDwwsOcuh0jRkacSmJV0Sb/Q9/Aol4zXUYqq1k2kP7/TSue7kGUMo73Zk0FOmHLJsRos57il2VbYts8/Ub9juNqDti5rkykP1gUufbAlh7Yw7I/I//+o6tKJ9iq5KEgWFn09qoDPrQLGQN5A8rzBqTKjP4iDAZ2JeMDAoewyeerlm24kPYyhVNf3Te1U/s3hmNG9ezHDdYu+UeuVgDuBQL4KJNdPm4Tm+YxOMIBv+BhYhPpXe+l9aNjH31N+Zt/7reghhbr+Z3cAg9UZY8vleLRxhFu09rsvZ9yn/1xtHVIF4xMA0pLddu/0SHUZfuPSJX0x4LtQTAO+MCOIsTYLRHj9Wpygm0SrqQahpOZqCTVYHLvdaP3h0RxPrt0rz3dXlj0NzjRv9glMR+zWUynhNjq6jMt5JNIYsT3HurDVA2dGxBuiKb5LrxKQfji5R5DT+mZaHbXFECxMcHiqOlpexyhUjHTMNVw9JPL00h3qPlbWIwk211pmi4pDdhgYw1pEArgjTqRMkIq03EVk4SkPBSxpL7X4UxMp3WW/hwEc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bYiwK9XU8Ktp/Q55oYKoV7EyLe6MnMPXZiGTGpvxT4nyZbeAWOqX8ZugI9eI?=
 =?us-ascii?Q?qVj2fbXIsUoPxQxoyQBMXpeR6s30x9FaXx4ZbeBvX93kO6Pb5bvCTc6m/CW3?=
 =?us-ascii?Q?0oKkUjVIMxtUZ3GhAFS0AWkZVpXrMd1RE5t6ssfh2sZdKI16g9ZV+L4mbnZD?=
 =?us-ascii?Q?zPvjY66iWAysDy4JYqQ4gCbBU6uYzufV6SLQZNbdlCQYH/GnbjDnKehlKmcm?=
 =?us-ascii?Q?nE3qaPKOh/o0JTjPEhJKisLADjBsEVudmYhRk5G0ZA5+8TowY1bntqElJR56?=
 =?us-ascii?Q?pd2K9s1FhfRzsw6pl5Eyy8iO9GPZUAeAf/NgfMCWQZdcq4UF9zkW7E/ZCtdn?=
 =?us-ascii?Q?32TYyzIVQ1bHOTnbMZsjRrchA2dWiLtmRI5OJWm18Re+oa9bHmOtAx5j4uWF?=
 =?us-ascii?Q?8tKGcTaoTCb8oaCqI+gMT5WQqI167X+W/lvRpQ2W9/UTH/4BwAVohAi7j/Px?=
 =?us-ascii?Q?VURtD3hyIsvtwf2RHg+8TmUrZAIDugzHgROrIKn1SUVHiwt+w7vJdFxGu+sR?=
 =?us-ascii?Q?cPTEVKQnp8vR+5obg/30KHpZH28RE7vn7WIe1QZ4Kq7qopGHRk0GFApq0erh?=
 =?us-ascii?Q?Z5fvtijDgTXPdcHp8fzg5qA5RApArT7imfD1xfP1LhSZHhjdvDqhm0HkaQth?=
 =?us-ascii?Q?38p7pm7Fa3LRv7Xkw1zL2zmMxEy5Ji3X1VV1gOwHMlGasTiPn7NPpw8opIH9?=
 =?us-ascii?Q?4U/wa+2Qs5btMlaMsI+4GYEUMOB7L8ADFYZjXIZM27dFPSY9J+uX7cgNw9S4?=
 =?us-ascii?Q?21ozaKuQzBteBIHRwRi0rbADBWRZVKW+yrjitE7SrdanfJcBEhyCLD5kyhj8?=
 =?us-ascii?Q?24MSQ7rrXlHfPEf2VLpDKceB/Xd0jlpKg+FYwBWaZHi9UaKCyJG1fRCdghKw?=
 =?us-ascii?Q?2jCMM8/fxOXCf2lflSL8eCif5LnGDN6ZdMU2OPSsmgqeENoHUDqvRAFXnovU?=
 =?us-ascii?Q?jKW3pVkBeRGSUNaNpubhmT4bD8wRD3TxJXTLl0zPayojMncR62504EARKwJr?=
 =?us-ascii?Q?tkGw9WldV5dy8zUW57hcBzsd2aaBwHoEYo+iyteSt2MUqaqHB8BVmmSfZkV3?=
 =?us-ascii?Q?ZJBIEN26hJd8IYwqbHj33XKS5co+an6A4d9OOdYK/PZMYxj+lwd/MLXPaO7U?=
 =?us-ascii?Q?gEAhefaqeHSI+dK3LJxRC3aVFvQtDNafKgVesXjR3vU+HtjthfEMfMIZ23Al?=
 =?us-ascii?Q?zpj48NglHwNDc8paajehUDT8Pv69M7Gmx7muO7znd+gquz/qr5auaBYVvilk?=
 =?us-ascii?Q?F9R7WXsVDjDF5BsNHZv4kT56pY2xv34jIO3uOeMqg4/Vf++xjXe98y0Av+th?=
 =?us-ascii?Q?vf20swOPmWfX0JHdTuruS5LbU72Kp3CMXA3doqDTDE00Lva6aeqvnbbS3WgQ?=
 =?us-ascii?Q?r/LONUMnTlggI/ReUHKk3eEQ3l/iwUTh+r5pFpBwgh6MWYHEwzBMGPWNrUsd?=
 =?us-ascii?Q?O3kK/rx0f9NZcAq4q/TI5M4khNC8M2XMVk+qqL4KMtWZhs6w3pY7cqn+2hmX?=
 =?us-ascii?Q?ZlQmUqNj0q37gjSrn3o3fSHc7RgViMNcKfgR+c5lEUhJmHraY5fsMzuJyY4x?=
 =?us-ascii?Q?n5BoG3vkhjhDxNdKiq44bJQFiP05iR0AO8yPwXni1n3w5ClCagyiC4m2+Zdj?=
 =?us-ascii?Q?wuhfPtFUDDCyomgwm2nRua96q9a/aQGCg+GIV/GhBXT6mmQWulXlRmYVppkE?=
 =?us-ascii?Q?ky7vE4n7+NoJN1i3oa57y3lXoVCMr8msp9YM83Oo4lHjSqLrxc1lpl+1Qw4T?=
 =?us-ascii?Q?ly2eRT/uLw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e06d745-60b1-40f1-5413-08df0f562a68
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:11:26.4654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YtV/M8xTa8SDAKOcPVBTSBg2Dum3J1A7a+M8djguC1ait+VtqCuGEkK7jWydQTRPNq8Y8Wacjx84JUU2V5abWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6329
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.50 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[Nvidia.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.85.42:from];
	DNSWL_BLOCKED(0.00)[2603:10b6:806:26c::13:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:from_smtp];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1B1E1438BD
X-Spamd-Bar: ------------
Message-ID-Hash: RS3GD7IN7FLYMIBCT4A5LWIL7CBIFKAB
X-Message-ID-Hash: RS3GD7IN7FLYMIBCT4A5LWIL7CBIFKAB
X-MailFrom: mahantesh@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RS3GD7IN7FLYMIBCT4A5LWIL7CBIFKAB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mahantesh Salimath via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mahantesh Salimath <mahantesh@nvidia.com>

OP-TEE FF-A memory objects use 4 KiB pages, while the kernel page
size may be larger. Consequently, tee_shm->offset can be greater than
or equal to FFA_PAGE_SIZE, but OP-TEE rejects such a value in
internal_offs.

Do not encode the excess page offset in offs_low/offs_high. Those
fields describe the logical memref offset and are copied back into
tee_param->shm_offs on return. Folding the page offset into them breaks
parameter round trips when a memref is reused. They are also ignored by
the OPTEE_RPC_CMD_SHM_ALLOC response path, which uses only global_id and
internal_offs to construct the shared-memory mobj.

Instead, start the FF-A descriptor at the 4 KiB page containing the
shared buffer, the same approach as optee_fill_pages_list() in the SMC
ABI. Store the remaining in-page offset in internal_offs and preserve
shm_offs in offs_low/offs_high. This keeps internal_offs within the
FF-A page size, maps RPC allocations at the correct address, and
preserves normal memref offsets across repeated invocations.

Tested on ARMv8-A with 64 KiB PAGE_SIZE. OP-TEE OS ran as a secure
partition under Hafnium (SPMC) over FF-A. Verified registered shared
memory with tee_shm->offset >= 4 KiB, memref reuse on the same
TEEC_Operation, and RPC OPTEE_RPC_CMD_SHM_ALLOC (xtest regression
6007-6009). optee_hello_world, optee_aes, and xtest regression 1005,
1007, 1008, 4001-4003 and 6001-6003 also passed.

Fixes: 4615e5a34b95 ("optee: add FF-A support")
Acked-by: Liming Sun <limings@nvidia.com>
Acked-by: James Hurley <jahurley@nvidia.com>
Acked-by: Dave Thompson <davthompson@nvidia.com>
Signed-off-by: Mahantesh Salimath <mahantesh@nvidia.com>
---
v2:
- Drop helper indirection; mask internal_offs inline (Sumit Garg)
- Keep a single ffa_offs local in optee_ffa_shm_register()

Link: https://lore.kernel.org/lkml/20260904134732.1072541-1-mahantesh@nvidia.com/

 drivers/tee/optee/ffa_abi.c   | 22 ++++++++++++++++++----
 drivers/tee/optee/optee_msg.h |  4 ++--
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 633715b98625..fdedcab50f23 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -198,7 +198,8 @@ static int to_msg_param_ffa_mem(struct optee_msg_param *mp,
 	if (shm) {
 		u64 shm_offs = p->u.memref.shm_offs;
 
-		mp->u.fmem.internal_offs = shm->offset;
+		mp->u.fmem.internal_offs = tee_shm_get_page_offset(shm) &
+					   (FFA_PAGE_SIZE - 1);
 
 		mp->u.fmem.offs_low = shm_offs;
 		mp->u.fmem.offs_high = shm_offs >> 32;
@@ -284,14 +285,26 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 		.nattrs = 1,
 	};
 	struct sg_table sgt;
+	size_t ffa_offs;
 	int rc;
 
+	if (!num_pages)
+		return -EINVAL;
+
 	rc = optee_check_mem_type(start, num_pages);
 	if (rc)
 		return rc;
 
-	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, 0,
-				       num_pages * PAGE_SIZE, GFP_KERNEL);
+	/*
+	 * Start the FF-A descriptor at the 4 KiB page containing the shared
+	 * buffer, skipping unused leading 4 KiB pages when PAGE_SIZE is
+	 * larger. Same approach as optee_fill_pages_list() in the SMC ABI.
+	 * This leaves only the offset into that 4 KiB page for internal_offs.
+	 */
+	ffa_offs = round_down(tee_shm_get_page_offset(shm), FFA_PAGE_SIZE);
+	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, ffa_offs,
+				       num_pages * PAGE_SIZE - ffa_offs,
+				       GFP_KERNEL);
 	if (rc)
 		return rc;
 	args.sg = sgt.sgl;
@@ -458,7 +471,8 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
 		.attr = OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT,
 		.u.fmem.size = tee_shm_get_size(shm),
 		.u.fmem.global_id = shm->sec_world_id,
-		.u.fmem.internal_offs = shm->offset,
+		.u.fmem.internal_offs = tee_shm_get_page_offset(shm) &
+					(FFA_PAGE_SIZE - 1),
 	};
 
 	arg->ret = TEEC_SUCCESS;
diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 7d9b12e71c03..6c3043f8da33 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -136,8 +136,8 @@ struct optee_msg_param_rmem {
  * struct optee_msg_param_fmem - FF-A memory reference parameter
  * @offs_low:		lower bits of offset into shared memory reference
  * @offs_high:		higher bits of offset into shared memory reference
- * @internal_offs:	internal offset into the first page of shared memory
- *			reference
+ * @internal_offs:	offset into the first 4 KiB page of the FF-A shared
+ *			memory region
  * @size:		size of the buffer
  * @global_id:		global identifier of the shared memory
  */
-- 
2.43.0

