Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED8AAC79FB7
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:08:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3DBF4452C3
	for <op-tee@archiver.kernel.org>; Thu, 10 Sep 2026 01:08:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=loRZd+I3;
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010049.outbound.protection.outlook.com [52.101.84.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5EC34453E2
	for <op-tee@lists.trustedfirmware.org>; Thu, 10 Sep 2026 01:07:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zF04ZuWWrI5Fsy9QLU42oG7VKYrjPQWtfVHw06hSxzv5O0br3QASSrAwSlb7PqQpanyeDp/xLzvvKwmGlAzADd2osfouWDOd8noOcwjDCH3TOkjFG/XHv5puqjDR50kO4CXFkWRxRWz5qAbfLbRpdbjvy6aJST7CgFUg00sBVDpHADN5K/eWXK0fgy0Dr8F3WMoBpe5TiAU8RVFtiDsmH3QyHsN8eWGIeCtcOkC+gniQZKX+QrrgCnnO3WqHy6vB5P1n1IBMMtXo/VP33WtLynK1WkIpBe9pM4ImI5CGhMZ4dh5CPIn0dV4Al2Bs21ktOaAATXqxM2pUkOB2k3nXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6y89+xMjeRtb8fCd6GgEbugywJry8uMqjJxY4/BrP8=;
 b=Ipv7zeq5Gj7dBmwwQfTkev+QF9F2BfK8kecMXrkdNUbFXAvm260gbmPbUo+MWGyWZ7elZEba4lbq/mwusecNqGOOweyIf12HIX1X/XFXcaazJrA/iCHura9jhLr3BsMHlwvEHUPWtgW6LGgU3TKr208rFE6+n9HXNUJHhGhXkkW2560dtvBoznca3ji6OUJvgkZyBJtg/Y3wO/LKAwma+fxOw5zIrxkTe5Aziyv/uVMxYjidZKQK7MYEAmddXrBRmPBJqy73CIDiMealGOxI/QDPtkmcQvb1uHZx/5p2INB20x4srM0Ux2B0nog7Kc7YfdWerxWgiQ9D3YAds4AGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6y89+xMjeRtb8fCd6GgEbugywJry8uMqjJxY4/BrP8=;
 b=loRZd+I3jt4nWgtCpGwpGhj2ukhi2AYF5uViT438xrg6LkuQ1ScOE/kvV5hjWq8eKPlX7y9uvZ4vIDOUet81wObwAiAYzstq272OHwjV2tXporWukpd4o74wc1/b3nalYUerKUssYRTaIcQdwOZd6ha9AC3NZ+A/n9yvw2j6pYnm05aFzyqpmiFXgu2/zHL4RmDZp2WUFcXwDcY02P4wbpXKFsbiHnMqRaUNE/tDovk2Egffa994513ZLmw+EWa3vZZUQi+o6pbFIt0zb3kr6MRqwzNTU2tejsoenbXiv9cUaeDRa+V70HwqydqTuETBuUYfW1IwUQ8OS3cK9bMxSA==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 01:07:18 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 01:07:18 +0000
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
Subject: [RFC PATCH v1 2/6] tee: optee: select the SMC ABI conduit from the firmware node match data
Date: Thu, 10 Sep 2026 03:20:53 +0200
Message-Id: <20260910012057.106966-3-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910012057.106966-1-marouene.boubakri@oss.nxp.com>
References: <20260910012057.106966-1-marouene.boubakri@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0024.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::9) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|GV2PR04MB11739:EE_
X-MS-Office365-Filtering-Correlation-Id: a97823e2-7d59-4dfb-a47b-08df0ed7dbe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|23010399003|6133799003|18002099003|22082099003|56012099006|10067099003|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: 
	SN3Oy+vzIc929JLSzp5iIiTLOmcefY/CcpRrQlHOptrnuwIYjNxxirua8hyg7IYnJ1ceE16A59w1ZorDZcQtApw6WeqNTD4yWq6ZH98ZsoMoHayY5QOn9vARYRSUk0AjgQK52+5eeS+shT2zBJ5PBziyKdVOGZyiiI/mIoME1ynQaX5/VFeOB83+z5GmkzZ4/pLR58zdwEKpVUbemeggh/1L4EpCi7uTm7i99qY0nqaRyInkvByuOydGsT843YNvGuQ/l5OTgkEZqSyTS6YnMGFcTqeUiRQcRV/0c1SCSJIDWPlaNEl/yNN62zUDsmt6IPj8JwkUg0pJfVIhMsB6JHfrTSgpj1UX9YkDkBVh6AcUCg+VszlYVvXdtLRGjw9HaLnveyPJay8sb0576Amb37BFplarlgD6mtF1p2S4jg5CTCSNpeMoO4pp6GqzS5tW37+n5POfXEtMpKnbggRMh2N3ELlmI3rdOXSSQyn2SYd72392cHs9fIrdRcMNNYEFiWVy5tjmHDwh7AWSrcDaxGIJpkWsS9zpMGCZCPTatiqpjaxgfn8DIJQCym2n1UfKzCbtC5hGzq2eCL5ySF2fHFFyEIj6IAC8hFWLKsX6WXD7QvHhaI9AsIP+yKA+LHjpHuX8W33wymeDpH9ziYKUcP8rwFV0GJYg17Xc2dRb2i0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(10067099003)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AbUrKUgc/VDZ7Rk6xYfFq5XDh0fxupF3GoWi1FID4oHzc2c0jbsLCT7jk7Vo?=
 =?us-ascii?Q?GMNpWFVBC1T+uv9VYqHJnjnJAqxgECabSOzHc0GXWUEu0I9iuywjF3GDpWgs?=
 =?us-ascii?Q?xbew6+54qbAco2Dh/4BS2/7thppajZRaFhAbO9nzH7b/RtLXdeG8lEDiIq0Q?=
 =?us-ascii?Q?VZyAQg5O12edNLv6QuCSHs0jgA5Usa6XpLvPOQRtBr4dezTxW0wcTV5+7Qql?=
 =?us-ascii?Q?g/JcyK/+CijZFi3+QgWU7Sd87i5azdFK76TECt/or1QQHsPqHKn3OxuJeCAS?=
 =?us-ascii?Q?ccwJt1OdHAafCxP7rOcWkJpL4ssSdwBYHlU8gfG68MaHhwSriyRWJKmAVO+O?=
 =?us-ascii?Q?knnG1EMobGLKoR0cAciIxY3w5EYJTufBBlZ4DLeRWH0Gso7UTcxPDVf+kBER?=
 =?us-ascii?Q?YhH4WCz+G0dw4nbMh3Xfpb/RK62GCWcxsyBeDMcw2zBiGXcqwho4FvYg2mgK?=
 =?us-ascii?Q?1V9KCwh6uyWBaOiFsQ3/4VAD1VISp/d1eClRQwvd9Xtbcgb+KuL14swuP4o6?=
 =?us-ascii?Q?XD7DKSaFKEYEdvK7/6lL6kskRYkgmKopA/8lMqvXMmz4ZtC79Fj/xaoeaTQc?=
 =?us-ascii?Q?cNi8BDe4DjC9xoe9z7Eastn6OcmteE6fQIqtGSWjmwEJiDYf7WFsMATGNVin?=
 =?us-ascii?Q?03LvHpY5ntD8+RZOrH1FnrYyFLmDHzxgoH14EW6Ior6LrKr98tYUu9+KXBNg?=
 =?us-ascii?Q?ucoUqvjOKmV/22fLBVxwHJUjbO5EKRjpkn5d2BQD1xkhCe6XzPjlKg/3Q0mR?=
 =?us-ascii?Q?CUtF+d2ghP0nCSU0FORkui19xOydV4m4VmF/6UgRFsojy8rFK7u9IBBysLHW?=
 =?us-ascii?Q?VBppBg55hh44AER6i4ePspOwcDhW6hXp3lwUreXrEdGiwkLSOTTXwhYsW1fp?=
 =?us-ascii?Q?NLJwwUxlaCak9kdYnI7A59v0kX2tUydZMVc0wuCEj5j9E3l6KC1xvoXH3I7L?=
 =?us-ascii?Q?0KU4gB4KYXAbD/76tKc9mOvab1pyMwtsVUzieObMdRhyLEmGp9T3Kp1t2p7B?=
 =?us-ascii?Q?TN9/sG0ukzX6oaW+gws9hf8yYgNGOGjyHjwgQdXrWe2DX41Nhy7ULWZATUq/?=
 =?us-ascii?Q?sn0hTSBA/iSxEZFfJZDVm83eopDNDGwcvtzGBw5BheLUnMnUUyJkSsGHbR7J?=
 =?us-ascii?Q?O8UgZWcFOcUgpwd79AixqdXa0CcrCy3fO+KH7abRoUDb3h/tM80BZGEiByg3?=
 =?us-ascii?Q?P8ndD2haovYJeBLiGS/zRZaZ9lffrI+4ORnIccafqMtKOVJK7M86XbatzCeH?=
 =?us-ascii?Q?IpoqkJu7rOe7NLhMUFEQVq292pbQaVE52c5M9ojKUrURxnPgCgFaC0N+oZ5A?=
 =?us-ascii?Q?jeNJAhU22QoG9q6DqeUJmb89gJZgs9BeQGt9tCKTBgz6scyVzWk/IAhSTPth?=
 =?us-ascii?Q?AsDlX5DIQZrmJ0Sx0WzYTeHF4UJNKUzrTIcvUNuWwnWbLqG+BOdnrU2Z1mcH?=
 =?us-ascii?Q?mKuENT/uP88odKIUJ7BKHAuOhxl/QapNvB2S/saSxljBVLh8FcNj0HWgr+Cb?=
 =?us-ascii?Q?gjfxFeyHRmzghpV2CuNPlu1VLW8u74MoubvjhlonN+bWUrF6z3+qGz+AfH6b?=
 =?us-ascii?Q?wXNkgoPe4hF5jnpHyqLgtGkFx/2JqDm/YoaMWD5+hNRJssBkYBkIkQVyg0eJ?=
 =?us-ascii?Q?xpZsZ1kScTKHvYB+i8AyxRQ5lG+g41mgawOsqPWKdt/6Gr70b3/zO95biMin?=
 =?us-ascii?Q?nv+V3NNuWQoydmpgmpOOFHqJ7KFe63xldSH4PBX8iE6paD46182OWV1WJPow?=
 =?us-ascii?Q?nzGa6ne81DrEmwRoqg7PmCMybgu2TeH391SvfBVP6wvzE/QzKZcYEmZYY3oo?=
X-MS-Exchange-AntiSpam-MessageData-1: 476KDskKwWZF9w==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97823e2-7d59-4dfb-a47b-08df0ed7dbe4
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 01:07:18.0905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl2Lj1hEe356kDfGWCn5s6plaLpg3EmSXTDgi6YTVSQsaztZo578yF7eAcVf3Jycj//Nxbo1/IRL7VCbEoWJYEQtzZUD6UbImuxFn+oXx2hkBENqUy/7WGePDA/C8plAi/XFgQXMap2lLkm85lIRsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11739
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linaro.org,kernel.org,sifive.com,dabbelt.com,eecs.berkeley.edu,gmail.com,lwn.net];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[oss.nxp.com:from_smtp,oss.nxp.com:mid,oss.nxp.com:from_mime,NXP1.onmicrosoft.com:dkim,nxp.com:email];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[52.101.84.49:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.84.49:from];
	RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5EC34453E2
X-Spamd-Bar: --
Message-ID-Hash: R66P5DRO3XTY4RRJQILRYYCDEWEOV3JY
X-Message-ID-Hash: R66P5DRO3XTY4RRJQILRYYCDEWEOV3JY
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R66P5DRO3XTY4RRJQILRYYCDEWEOV3JY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>

The SMC ABI is defined in terms of register arguments and return values
and does not depend on how they reach secure world: smc_abi.c already
abstracts the conduit behind optee_invoke_fn, only its selection is
hard-wired to the SMCCC "method" property of the "linaro,optee-tz" node.

Introduce struct optee_smc_conduit carried by the match data of the
firmware node, move the SMCCC specific wrappers and the "method"
property parsing into the SMCCC conduit and build that conduit only
when the architecture provides SMCCC (__arm_smccc_hvc() has no stub
when CONFIG_HAVE_ARM_SMCCC is not set).

This prepares for a conduit that carries the SMC ABI over RISC-V RPMI
messages. No functional change on Arm.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
 drivers/tee/optee/smc_abi.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index b8a2bdac3..221939f72 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -1464,6 +1464,20 @@ optee_config_shm_memremap(optee_invoke_fn *invoke_fn, void **memremaped_shm)
 	return rc;
 }
 
+/*
+ * struct optee_smc_conduit - conduit used to invoke the SMC ABI
+ * @init:	probes the conduit and returns the function invoking the
+ *		SMC ABI through it, or an ERR_PTR() on failure
+ *
+ * The SMC ABI is defined in terms of register arguments and return values
+ * (see optee_smc.h) but does not depend on how they reach secure world. A
+ * conduit is selected by the compatible string of the OP-TEE firmware node.
+ */
+struct optee_smc_conduit {
+	optee_invoke_fn *(*init)(struct device *dev);
+};
+
+#ifdef CONFIG_HAVE_ARM_SMCCC
 /* Simple wrapper functions to be able to use a function pointer */
 static void optee_smccc_smc(unsigned long a0, unsigned long a1,
 			    unsigned long a2, unsigned long a3,
@@ -1483,7 +1497,7 @@ static void optee_smccc_hvc(unsigned long a0, unsigned long a1,
 	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
 }
 
-static optee_invoke_fn *get_invoke_func(struct device *dev)
+static optee_invoke_fn *optee_smccc_conduit_init(struct device *dev)
 {
 	const char *method;
 
@@ -1503,6 +1517,11 @@ static optee_invoke_fn *get_invoke_func(struct device *dev)
 	return ERR_PTR(-EINVAL);
 }
 
+static const struct optee_smc_conduit optee_smccc_conduit = {
+	.init = optee_smccc_conduit_init,
+};
+#endif
+
 /* optee_remove - Device Removal Routine
  * @pdev: platform device information struct
  *
@@ -1728,6 +1747,7 @@ static int optee_protmem_pool_init(struct optee *optee)
 
 static int optee_probe(struct platform_device *pdev)
 {
+	const struct optee_smc_conduit *conduit;
 	optee_invoke_fn *invoke_fn;
 	struct tee_shm_pool *pool = ERR_PTR(-EINVAL);
 	struct optee *optee = NULL;
@@ -1741,7 +1761,11 @@ static int optee_probe(struct platform_device *pdev)
 	u32 sec_caps;
 	int rc;
 
-	invoke_fn = get_invoke_func(&pdev->dev);
+	conduit = device_get_match_data(&pdev->dev);
+	if (!conduit)
+		return -ENODEV;
+
+	invoke_fn = conduit->init(&pdev->dev);
 	if (IS_ERR(invoke_fn))
 		return PTR_ERR(invoke_fn);
 
@@ -1956,7 +1980,9 @@ static int optee_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id optee_dt_match[] = {
-	{ .compatible = "linaro,optee-tz" },
+#ifdef CONFIG_HAVE_ARM_SMCCC
+	{ .compatible = "linaro,optee-tz", .data = &optee_smccc_conduit },
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, optee_dt_match);
-- 
2.43.0

