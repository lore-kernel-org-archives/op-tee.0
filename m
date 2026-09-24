Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C76C98311
	for <op-tee@archiver.kernel.org>; Thu, 24 Sep 2026 10:38:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8C29F454A2
	for <op-tee@archiver.kernel.org>; Thu, 24 Sep 2026 10:38:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=TnqZuVcA;
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1EC8A4503F
	for <op-tee@lists.trustedfirmware.org>; Thu, 24 Sep 2026 10:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGXZvtyXb8z4LnUa4i3kCczSUyAjNGdKKsxSca0GtZnZq3tyO7Bv4xQWhw0LC7L5zifqj+C4wWFj60QV8lIewYCmjSICeJ9zs6XouacXqiNhXBTQzSfnAlmszWooIkvXz/jS+bQdoPGy/B26JAXLiohvCCH/jVT0Z4qVU7VUGoYyf56T1tynh1WahLSBOpd+nO+tKL4gXCM0cZwGCj1hUMWG771TFQnLhaza02NyeHCIutIg/8Me8bZW4prAfm4X4y5+oWexaGe4rdqYtq6Su4gz/mWKdorWUM99aSrbYeXWJO0XRGeyE/EwqFwMnUeEOFQTCLUsmjM4m57AoNw2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWCo/GWnUpg3/yHkjPmqxiuY/O+02GuGbVM30JWL/Ow=;
 b=xDCGJ3i+9Cvkqr6ZZldXEWBWD9ETTb+ejlPROrMmsf9AdmqGvgy5XmaelZOX6h8XIH93+/kdMpah1cgMj7Z/fje1fnG717ZhTT4loSdRLm0Wag+tUJnDZiK8Ln2K5eEEIxawpEx+lwzSaSQ5PexKEzs1R2Q/VgRhAjJnUBksrABgy9dI92VTqjv6hIFMF6kfVe5sutFWGdiEIP6IzSz53cIvGks0neWb0CXuAY1vifFNkHzSBft6qoBgNCY7rzKHxsuEkcObSxufV1ltBVypFkBmBRqVUFTSxfcCRLXGtIAA2+EQWo5Am/DXBsxkZQc9aPAB1QVBMEhLoTAAEmvUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWCo/GWnUpg3/yHkjPmqxiuY/O+02GuGbVM30JWL/Ow=;
 b=TnqZuVcASiM9iaVq5CZKVad7ixhUvbJ/fOgn7Wye+lIgZKUA9gJLUM8M3fSCYsspyo6FFrLGkxLIDtPK2bCdoenpPFPMHX1tXduQJdxtupAKQIelUVdeiGgmKBmLSleCxY5+SRMDnOjNeckXS/MiGhGdyJlY7ffNo16AqLN8xZGkum+I61MuweOG8dh0gLZBwyVoMG0DVtfg8PZrkW1nnedp7EAAQZ3BfwVbsz9nRm18gdbtwL4QAAXEveGC/TmRdfOZYR8geXRkRi4VoEGCVyCc3sUka3ezcDmhwwjz2cUTpj/f3/N+fkEm8VwO/xBlHWFc+OlOEqkicv+0sk3XUA==
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13) by DB9PR04MB8188.eurprd04.prod.outlook.com
 (2603:10a6:10:25e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 10:37:51 +0000
Received: from PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930]) by PA3PR04MB11203.eurprd04.prod.outlook.com
 ([fe80::80e9:ab1c:dbc4:6930%3]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 10:37:51 +0000
From: marouene.boubakri@oss.nxp.com
To: jenswi@kernel.org
Subject: [PATCH v4] tee: optee: build the Arm-specific code only on Arm
Date: Thu, 24 Sep 2026 12:51:45 +0200
Message-Id: <20260924105145.532787-1-marouene.boubakri@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0238.namprd15.prod.outlook.com
 (2603:10b6:930:66::9) To PA3PR04MB11203.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11203:EE_|DB9PR04MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8539ce-744e-45f9-92ec-08df1a27e25d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|19092799006|10067099003|56012099006|5023799004|11063799006|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	7/mo3NuiyH5ef1PQYm7kgw4Jv+BUENrP4y0BmPDXMSEowamBPO9m9Wl26E1Pu8xuaHGtvzb3bxAWmHHKH5LqO/w6p1QMMrbUU6gTWRlKPEP4tKbbW1+yfe7RurIUTSJtbFmYrp7dmO7cSdG5kSIROhAAECO+msrEYHJuaajeWBFimcTG4rOFZzVbVSbEk33gw3BBlV6tSky6Inyy2ki5hvcEFkciHHNuIKfGXtvBZgcm8aXQUNyMduePILqQtFTTUH1QQ4+AvAhdm9UynfzhVa+okE1+0gc0PwUkgTc7d/ZT0ck3qS5bvjqyLMSXLZYcSPiJSLI5FypLtY3nFhSXjLsW2Ag+Bn7MhK2RBhCMGjPkTz/ZsyV5wSGvfqGz5YZWsZJ/OGtNnWWU6AAx0OxwZQgUwchkNARovyAHcL4k8SuAf4boew+xTBpZOYsYb+NfeNaH7XuFRNToej361hCIivoROLSFYc+QxX0bQaS+UFyVjmuClrAc0jQ357/z2e/mQhrDbwkHqZmF3HEOdyW9AqvqayXf2h0aWBtg8W+DXnTeJhdBUOnxl4yB63i1fln68QH+oZffeXJB/gQiOwBqI+Nk6D5LC44JGeNKiN4Z6GQR6Dgi3ahq+Ckwe0aUJrrOipFqb4fCGmHZj7GddpnycEpvfMYW4RRyatLKND9DYyQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA3PR04MB11203.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(19092799006)(10067099003)(56012099006)(5023799004)(11063799006)(3023799007)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DmfAxIIundQf9ddxxQIkMb8kc4FWqlg14XlSUTTKTaQhkgNnnrcUof9GU3K7?=
 =?us-ascii?Q?5l2gz1VQB8ifTXh+yw3YpLbZj5SDs9x3FmUJt3WGexrWf1mbaXbnDNZeE+9s?=
 =?us-ascii?Q?uTpRvSSiqz95aGAoWKDctWYzwAC+ogwjH9shIBr9c2EodA8Ftac1nTF526k3?=
 =?us-ascii?Q?FJV/69TM26rxp2OzDPMqpCmSv9DmfUTHE6wpwiUN/I9wG3lM6ocqhLLaFUNI?=
 =?us-ascii?Q?U7bCTjZknlHnjY2Dskjmnf0kMCy4Gv2O1tvIoS9R2esOnXGPYpVFtbTtmIw6?=
 =?us-ascii?Q?kJ0ViZUWl0keo+qxU6Mmz6r3BX1x0psLMYFWaPbyb3iypFv9nd4R14UDtzn5?=
 =?us-ascii?Q?mvHwEKw2NBo7vWDCPu72IHNSGttdzU3aFVMoaPBjlwi2ny70nUdg+MLLGgl3?=
 =?us-ascii?Q?GZL4/jofg0z8iDybeA374XTB5BzF7Q8p9sB/+b4K52OazEj9FZFPS7w5iyL2?=
 =?us-ascii?Q?DwcHdgIDQs61Y9jVfminrEk74oLpgD7X7i4SmJknhuWX5nm2GZdQj/qIVXgX?=
 =?us-ascii?Q?oAytF2/7srjDKCHaPPR+6rzoizywsu4gKvto98eH6gO5gJCcaN7yUYtm96v9?=
 =?us-ascii?Q?vzeNPmBMNP8LSIEOu+2mA4RsuIRHDwueT7AIOof8CDfpExITdByROzBGVr4Q?=
 =?us-ascii?Q?+V6qVyuvIuHQrezkI0QD6uF75EdIqOc2LHWBBszwVTFDnKcO4lM9aJKxYbSf?=
 =?us-ascii?Q?Yc1/ZGE/Wis+4lvAQvlT356ZSSZ/3W14oDYYutU8qaf+bSf7sx0M5jEmZCiz?=
 =?us-ascii?Q?/HMiGZt+bVtkzSrA9IpEtFrRGJTYGleuBTKTHVrKFvfUHegSt8ufl6m5LzUe?=
 =?us-ascii?Q?cRL07jc1GsTyhA2obyVIqE97WQxPt3TZMBoWUc7skCE61L6CrDVCNTj6+hUz?=
 =?us-ascii?Q?xkzjWLmwAbLQkStPsTg1ykJaz4PUQD95KrR6sCgOHtNDu9C+SC3YyEjnykfo?=
 =?us-ascii?Q?7d1HUmNa2imxuHwuOa2AdBmFAVdKDN3B1Lh+rZ0sE2mxG7LuMrX0mjXeK8MR?=
 =?us-ascii?Q?OBT7mmZFbBSio9YtXGLwC5bGGW1qslTl8IxkHFcAxGUlpQpRQI+BA3NA2uow?=
 =?us-ascii?Q?iBolFjFg4/fB07UnHDy0ZOgLqYMnThnoRWMbHs36HvIfQmxQuqzkJ26ja1et?=
 =?us-ascii?Q?03sFaL4S9IMBxXBXtAwIP5Ny4USpaZhZMlOaRpKXnif1VGo5dcxE98uLiTrE?=
 =?us-ascii?Q?6lKCnPqfJaSvdHTkvTN8aPpjpQpLtsM8xZfow8X0vAjqKSnFJ1s9rfp68CKm?=
 =?us-ascii?Q?34Jh+ZoEwrZuVv+yyUfQN+h2oyK3PDb3PGmZcQ8xcqy3P7A+wDMlfQKKymAE?=
 =?us-ascii?Q?dBYa9Gmjh2qPYkyAtzzeMRmpFn2LX2BQ0rWFcZh62Z06nfEwh2bxz5qs953O?=
 =?us-ascii?Q?WcFtsWQqMu07Dd7x11ng4lMLo6F/yj7ng+ucdhzInQVPmemjsisCpj3jLT62?=
 =?us-ascii?Q?K3xjT9wZRMzbP+GD4NPzepuHiXjUurV3rknCZ1PtToqQ9vprrCRoc5DmKXnY?=
 =?us-ascii?Q?PwLlRTsg88O+lBjaqc71yDYF7ISVRbCjYK2zwHiH/6xZVPhwb2R1vp66F3G/?=
 =?us-ascii?Q?NTMgoAMIaIz++AVzVE4II8Sj7o7LdgiSQu3MsUyjLI+dU1Icxow6MvO8DNww?=
 =?us-ascii?Q?18nPG029voS2HJIO9gI8wDqxXxJsVVzL3lfaA1JrLLVhokIP4xu26ryw7wqM?=
 =?us-ascii?Q?IWynKNdWoRIGxvyzI7uJLId51AmWUX/CDYk8ulHgRsl7N/BRa1VbCg7R6Eus?=
 =?us-ascii?Q?vt9TxZphZdm64MIMeUf/A+uFzBPQrk7oETAAOpl0RyBMQhKgsoRK72SNCOjR?=
X-MS-Exchange-AntiSpam-MessageData-1: nv5ibMRj52q7dw==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8539ce-744e-45f9-92ec-08df1a27e25d
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11203.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 10:37:51.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JrfsN8u1iN5Lt9giIarSNpJmZSIT9yO72818wfptREZ/ucSYveDltRgEdntRU0HehXzFZeW6gBgQTSS0zbZ/UpT9+Evnz/dNYa2WXeN0TjxeTmd229NAfmfa9/Z/YwjFdekMD90Bz1pidQOpKj6eiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MIME_TRACE(0.00)[0:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.66.59:from];
	DWL_DNSWL_BLOCKED(0.00)[onmicrosoft.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.66.59:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1EC8A4503F
X-Spamd-Bar: ---
Message-ID-Hash: U3M2SW4KDHUNUPXXBN2DQT63AVEBUPAW
X-Message-ID-Hash: U3M2SW4KDHUNUPXXBN2DQT63AVEBUPAW
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, amirreza.zarrabi@oss.qualcomm.com, peter.lin@sifive.com, Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U3M2SW4KDHUNUPXXBN2DQT63AVEBUPAW/>
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
the FF-A transport is enabled, and provide stubs for their registration
otherwise, so that it fails with -EOPNOTSUPP as the FF-A ABI already
does when the FF-A transport is not reachable. Keep the SMCCC header,
the SMC invoke function type, the SMC and FF-A specific structures and
the SMC RPC register parameters in optee_private.h under the same
conditions, and drop the unused <linux/arm-smccc.h> include from
notif.c.

Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT, as it
already does for RPMB, so that the driver is limited to a module when
the FF-A transport is one, rather than built in without FF-A support.
ffa_abi.c is thus built exactly when the FF-A transport is reachable
from the driver, and the IS_REACHABLE() checks in
optee_ffa_abi_register() and optee_ffa_abi_unregister() are always
true, so drop them.

OPTEE still depends on HAVE_ARM_SMCCC, so smc_abi.c is still always
built. The only visible change is that OPTEE=y can no longer be
combined with ARM_FFA_TRANSPORT=m: such a configuration now resolves to
OPTEE=m, with the FF-A ABI available.

Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
---
Changes in v4:
- Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT so that
  the driver is limited to =m when the FF-A transport is =m (Jens).
- Update the commit message accordingly.
v3: https://lore.kernel.org/all/20260922131735.524635-1-marouene.boubakri@oss.nxp.com/

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
 drivers/tee/optee/Kconfig         |  1 +
 drivers/tee/optee/Makefile        |  4 ++--
 drivers/tee/optee/ffa_abi.c       |  8 ++-----
 drivers/tee/optee/notif.c         |  1 -
 drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++-
 5 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
index 50d2051..891dac6 100644
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -5,6 +5,7 @@ config OPTEE
 	depends on HAVE_ARM_SMCCC
 	depends on MMU
 	depends on RPMB || !RPMB
+	depends on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT
 	help
 	  This implements the OP-TEE Trusted Execution Environment (TEE)
 	  driver.
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

