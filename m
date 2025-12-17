Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72248D65C78
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 16:14:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9A1A54315E
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 16:14:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KVkoZDgY;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id ADBFA40AD1
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 16:14:05 +0000 (UTC)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHFVkmE502440;
	Wed, 17 Dec 2025 16:40:04 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3de1m1mu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 16:40:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rovbFgVNa1S7fa4L7lEx1DfBdzNA8O9IjYPVftJ/LD1f5ZinAgszPvCeAQ0wJGT7PhfUvi0yqivdMFQ5lVndHjVjP70hafdsD9UavolvlhBsLUjcuGbBes0Fcn2FqntK9Z54pjn0D1LwQnteSPMYqsSUZf64+GRNQAF2BAFwCMHY3qTSy9G/wLwrNJIo+oGHB5ZQhicfgkMcZYwdeZsHcfgOGrpqR/8xmr9ZB2keJ6h9t8GJPoyXnbHWyyxfiglgeqpRr6uKzFqqOkjPZN53mglmQZzV7X6AnjzxDZr8Lvn66NuetAuRIYgsLi9i9QFdzj03v8HwB+37Fl1G22rNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnpB+93P84UT6wXamM8gI1nKYcNDnu8iksv6Z0wXyYo=;
 b=xWLXtb4zpaMW62CgyHDo35fIIn0IMB8+qY7cp17MARdGEGzAyXCyNL/NmrDDpBEFm6AKcX5U7iTPcRwdIdQadXMYKG54SzBcjev0AeAJUg0RRbtOgLHLjrE5YwSpEHXvLXLQDijGOFDsr9/TW8dVW43IGBUy6jGlVtVkrfxACGFdkhuTTmrTh+Qd8f6UdxM4ID/fa5MK8vTf1UINVWZn5tiaIS65gjeHnhBlupLO3uW3vAcgBBXHzp8qhNPHgaOtZYUnfAZsy/QOvxqLWS/X9CmSAdjJuOuV8hFLWBRmiGFixdj710+eUNg6UUZEPLJQ1l6uoO6/OS93btQmsLvNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnpB+93P84UT6wXamM8gI1nKYcNDnu8iksv6Z0wXyYo=;
 b=KVkoZDgYDA8oGb7jtrYB8K4oURRdEboo7iOXrr4qDNJRjaaNbHGF4AU8v6KrEVq5mTsscnbYOB0JAI/+7RuB87e3knE+JuL5CBVt6d7i2AzbnbfoGwJDPqC5gZ+Nh6fyCIbfKF/Q2AyBtnp7AsVZd0n8EzLj0ySk748wMB6Pto/lCBYkEmgyqm9ur6YaO1oJ4AFS/MUpmMTsVoqQC1ZLSYzkjjS63SEWmZDUKjJ/HLmOkdZdRKpppw6k4DYIQsybMSa+zCYDLC2bn1nVcOBisppKkMcNXB/FNfVQfYtGCpq40ql+GBnFjqme4ibXkj4YycTrHJLY7GvNZHll/vxUBw==
Received: from AS4P251CA0004.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::6)
 by PRAPR10MB5445.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:39:58 +0000
Received: from AMS0EPF00000193.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::95) by AS4P251CA0004.outlook.office365.com
 (2603:10a6:20b:5d2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000193.mail.protection.outlook.com (10.167.16.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:39:58 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:40:44 +0100
Received: from localhost (10.48.87.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:39:55 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v20 6/6] remoteproc: stm32: Add TEE-controlled STM32 driver
Date: Wed, 17 Dec 2025 16:39:17 +0100
Message-ID: <20251217153917.3998544-7-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000193:EE_|PRAPR10MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ffbc92-e1f8-4af9-2068-08de3d828914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pPMbLjz0ET8W7RadJjV860USfVmkMbclJ+FHD9M19SYmNF4YnaLqSVWPG8H0?=
 =?us-ascii?Q?fKBgXa2RQXg31XKg/lJYNFBGZA36Us4zu+jwT1TdsMTiNQXb2mbqYhNevbvt?=
 =?us-ascii?Q?W+e+LppJHE0xwF6LbXy8m2AVf2mczQtdbGavWQmdCaRUk2wClOX2FRgUc/QD?=
 =?us-ascii?Q?LuTSnVzAX6mlPXwUV22aupmsvMurO8/lVL66KfKcmISVu6A9cSX3BYX78Ryr?=
 =?us-ascii?Q?YM/QJMBaezV447e+zSDVnw3349E0LyyhkYbvIdICUCB6o4c2b/wV5s/aVPDt?=
 =?us-ascii?Q?Mx76rBfeU4YSzFIbSH8uaW7M0WwkAQHqzETKAljKLNUG0aiu4P7hI+9Evt9f?=
 =?us-ascii?Q?mid55cJQs8srFhaH8l9DsJ3wGo41/YKl3pMgXeP5lzZzTOjKVZfhNt1M/sYZ?=
 =?us-ascii?Q?GeMcf0rZrjX0WP8nsFlXwJjorjABjgUg8c/sN2bKSDpKwr+d+Sh8DHxqpmZS?=
 =?us-ascii?Q?AVhUfdJIyXgrKJOQmlwylh2wZQzSFY1wn24XKOshLEnmLHdyzxVpaPp3pFsM?=
 =?us-ascii?Q?arKXs0N0OAcvrTr8KoBwVVsMpXTvUx5gBEZw7jb/RYSW2cChnbVeHPWBlWkO?=
 =?us-ascii?Q?1JU+PTpg0C8fMIYd8F/UfG7QdAzfD2+F72+3Cg/I34ombPx6+MoKVwf1vrZS?=
 =?us-ascii?Q?iN0KFtkB/VTxjbuFzkb1gOty8qGgAlXaYuN4kmCla5cTz0r/tYKMqDJ6e/ce?=
 =?us-ascii?Q?qthl8lalbqvGOzNwU7h3MSmc+RUlp5Qton1KCi2jnoN0uwdckBJ0Tlx1XwQv?=
 =?us-ascii?Q?5/yT18MyLsU+SloYORd3s2xGpAf2Amt1MqUf2lb2KDyMKbeOm9T0RDPk/XEC?=
 =?us-ascii?Q?sQUZ9narPXdx+EcVQU6AOMkRT5fI0DHRxj8BbbyZRgUPqS4lcsiHCmWcg1ZH?=
 =?us-ascii?Q?RFZrca8bltexhrYPDGQz4Qo4uHEqe18fz104+jCooTLXcRWhBHFX4NMpVrtF?=
 =?us-ascii?Q?20+jUmOM2Eh9nrFfoIhEq2FgSaWlwPgzjNXciIQZvTr/UDtTeTQzmIEaMy2H?=
 =?us-ascii?Q?W8+uDnrKbrvx/LHEprkwsUlZ3jtNriJDiW39EI1ah6HTUg7V6OJQwAajDbad?=
 =?us-ascii?Q?PAU3YbQQRM0tqfbVAOHLOwDyIJRWbVxctrMKOoPiosrPrD0XzQS3MC2UOgA0?=
 =?us-ascii?Q?c1N3SNdV7l8WaQP4KfpRslO7+1QGZ8TxcRC7U77AXSqZu88td3ngzhZ/zQqO?=
 =?us-ascii?Q?tmgeEAOAhdjno6CpOQr8jy5jcR0omvOMOGqpdIbdRwRdmd42Gq7Z1ex2ycx9?=
 =?us-ascii?Q?Y7qdun1SLNPGyir1cGT+WiMcFasTuzVIaqVXAVXI24px2Fb1giU0tdGtKf2m?=
 =?us-ascii?Q?qjAyui+3pNO+HolysVdxg/Hc0Tf5PQl3UV1UYHbGfy70RTSCNfzQYd3PuedV?=
 =?us-ascii?Q?gcqEZSj43dgu5FeZoVuj6cHuj1lQZzhq75KXgNF6jDyfWJ5EPJmcSp2Cte9f?=
 =?us-ascii?Q?Zdhn7LClIaxeKNmDlICQGiR6FW//ZpP7B6yTU85bfGpzygSnGFFCSCMsf4iN?=
 =?us-ascii?Q?iAff2p7NuWgC6cPOSgvMFGEvuW1eVeA85W83O82BzPFmg26/qUe7DExqDOzT?=
 =?us-ascii?Q?OcKA/CQWraEKu543zyo=3D?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:39:58.7279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ffbc92-e1f8-4af9-2068-08de3d828914
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000193.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5445
X-Authority-Analysis: v=2.4 cv=JeOxbEKV c=1 sm=1 tr=0 ts=6942ced3 cx=c_pps
 a=H6LALYfxwt1dZiozdb8jwQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=wP3pNCr1ah4A:10
 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8b9GpE9nAAAA:8 a=Hs7IVT9660pjhmUSbEkA:9 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: aOLsqU67KMLcRz4r-okv2wSXMBEMW-gR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyMyBTYWx0ZWRfX/eSKE19fzkXt
 VHkSLwl+ig5qhZ3VP3MrF595fUg+5yFAKCCUex+9Z0d+AYZCTNYZrgNFWVapj7jzMurIr296uOK
 ZKqRwt9Lx1UtGFYt9FPsbQDWVlZAdVj7uaCLZ+tA3glja6BIK8/CxseCR5zT1IVKYES2BSCNrhl
 FBY+FWvEhu30dF+mx73HgxJtmKEa76lJoPadnmrQLWwrqyRejdvqxCYjmd4VAahJ4ZlPInLdwDq
 34IA5lYj3CjnlRyViOU7mjNxrItFLsLw4+tGhGYJ/O+9loXbPCYA7yy9oMfwVtCVwE5DRx90ZPs
 L0NfA84izLRn5NJNdPh+ktSV8piwhuno9SkY2PVapxQJj8EPw++QznNG8urU7MaBm4/lnGunJAq
 9jA77plq7MivajR4z130nsYXkJBB5w==
X-Proofpoint-ORIG-GUID: aOLsqU67KMLcRz4r-okv2wSXMBEMW-gR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93:c];
	RCVD_IN_DNSWL_LOW(-0.10)[91.207.212.93:from];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_VERP_SRS(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[40.107.159.16:server fail,91.207.212.93:server fail,2603:10a6:20b:5d2::6:server fail,2603:10a6:20b:5d2:cafe::95:server fail];
	ASN(0.00)[asn:52129, ipnet:91.207.212.0/23, country:US];
	DKIM_TRACE(0.00)[foss.st.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: ADBFA40AD1
X-Spamd-Bar: --
Message-ID-Hash: PQM45NFDAP6GKGN4YEYNNNTCB5C7OO4Y
X-Message-ID-Hash: PQM45NFDAP6GKGN4YEYNNNTCB5C7OO4Y
X-MailFrom: prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PQM45NFDAP6GKGN4YEYNNNTCB5C7OO4Y/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a remoteproc platform driver for the STM32MP15 Cortex-M4 core
controlled via a TEE Trusted Application.

The driver integrates with the generic TEE remoteproc layer
(rproc_tee_*) to delegate firmware authentication, loading and
start/stop operations to the TEE, while handling STM32-specific
platform resources on the Linux side:

  - Translation between physical and device addresses using
    SoC-specific DMA ranges.
  - Registration of reserved-memory carveouts from "memory-region"
    phandles (including vdev vrings and buffers).
  - Mailbox-based virtio queue kicks and a shutdown channel using
    the IPCC mailbox controller.
  - Optional watchdog interrupt for crash reporting and wakeup.

This enables secure boot and runtime isolation of the M4 firmware
while still using the standard remoteproc and rpmsg frameworks
on STM32MP15.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/Makefile          |   2 +-
 drivers/remoteproc/stm32_rproc_tee.c | 526 +++++++++++++++++++++++++++
 2 files changed, 527 insertions(+), 1 deletion(-)
 create mode 100644 drivers/remoteproc/stm32_rproc_tee.c

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index a1a5201982d4..80f0965bac95 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -36,7 +36,7 @@ qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
 obj-$(CONFIG_RCAR_REMOTEPROC)		+= rcar_rproc.o
 obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
 obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
-obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
+obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o stm32_rproc_tee.o
 obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o ti_k3_common.o
 obj-$(CONFIG_TI_K3_M4_REMOTEPROC)	+= ti_k3_m4_remoteproc.o ti_k3_common.o
 obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o ti_k3_common.o
diff --git a/drivers/remoteproc/stm32_rproc_tee.c b/drivers/remoteproc/stm32_rproc_tee.c
new file mode 100644
index 000000000000..1d492698265b
--- /dev/null
+++ b/drivers/remoteproc/stm32_rproc_tee.c
@@ -0,0 +1,526 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/remoteproc.h>
+#include <linux/remoteproc_tee.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/workqueue.h>
+
+#include "remoteproc_internal.h"
+
+#define MBOX_NB_VQ		2
+#define MBOX_NB_MBX		3
+
+#define STM32_MBX_VQ0		"vq0"
+#define STM32_MBX_VQ0_ID	0
+#define STM32_MBX_VQ1		"vq1"
+#define STM32_MBX_VQ1_ID	1
+#define STM32_MBX_SHUTDOWN	"shutdown"
+
+struct stm32_rproc_tee_mem {
+	char name[20];
+	void __iomem *cpu_addr;
+	phys_addr_t phy_addr;
+	u32 dev_addr;
+	size_t size;
+};
+
+struct stm32_rproc_tee_dma_ranges {
+	u32 dev_addr;
+	u32 phy_addr;
+	u32 size;
+};
+
+struct stm32_mbox {
+	const unsigned char name[10];
+	struct mbox_chan *chan;
+	struct mbox_client client;
+	struct work_struct vq_work;
+	int vq_id;
+};
+
+struct stm32_rproc_tee {
+	int wdg_irq;
+	const struct stm32_rproc_tee_dma_ranges *ranges;
+	struct stm32_mbox mb[MBOX_NB_MBX];
+	struct workqueue_struct *workqueue;
+};
+
+static const struct stm32_rproc_tee_dma_ranges stm32mp15_m4_dma_ranges[] = {
+	/* RETRAM address translation */
+	{ .dev_addr = 0x0, .phy_addr = 0x38000000, .size = 0x10000 },
+	{/* sentinel */}
+};
+
+static int stm32_rproc_tee_pa_to_da(struct rproc *rproc, phys_addr_t pa,
+				    size_t size, u64 *da)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	const struct stm32_rproc_tee_dma_ranges *range;
+	struct device *dev = rproc->dev.parent;
+
+	for (range = ddata->ranges; range->phy_addr; range++) {
+		if (pa < range->phy_addr ||
+		    pa >= range->phy_addr + range->size)
+			continue;
+		if (pa + size > range->phy_addr + range->size) {
+			dev_err(dev, "range too small for %pa+0x%zx\n", &pa, size);
+			return -EINVAL;
+		}
+		*da = pa - range->phy_addr + range->dev_addr;
+		dev_dbg(dev, "pa %pa to da %llx\n", &pa, *da);
+		return 0;
+	}
+
+	*da = pa;
+
+	return 0;
+}
+
+static int stm32_rproc_tee_mem_alloc(struct rproc *rproc,
+				     struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	dev_dbg(dev, "map memory: %pad+%zx\n", &mem->dma, mem->len);
+	va = (__force void *)ioremap_wc(mem->dma, mem->len);
+	if (IS_ERR_OR_NULL(va)) {
+		dev_err(dev, "Unable to map memory region: %pad+0x%zx\n",
+			&mem->dma, mem->len);
+		return -ENOMEM;
+	}
+
+	/* Update memory entry va */
+	mem->va = va;
+
+	return 0;
+}
+
+static int stm32_rproc_tee_mem_release(struct rproc *rproc,
+				       struct rproc_mem_entry *mem)
+{
+	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
+	iounmap((__force __iomem void *)mem->va);
+
+	return 0;
+}
+
+static int stm32_rproc_tee_mbox_idx(struct rproc *rproc, const unsigned char *name)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ddata->mb); i++) {
+		if (!strncmp(ddata->mb[i].name, name, strlen(name)))
+			return i;
+	}
+	dev_err(&rproc->dev, "mailbox %s not found\n", name);
+
+	return -EINVAL;
+}
+
+static void stm32_rproc_tee_request_shutdown(struct rproc *rproc)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	int err, idx;
+
+	/* Request shutdown of the remote processor */
+	if (rproc->state != RPROC_OFFLINE && rproc->state != RPROC_CRASHED) {
+		idx = stm32_rproc_tee_mbox_idx(rproc, STM32_MBX_SHUTDOWN);
+		if (idx >= 0 && ddata->mb[idx].chan) {
+			err = mbox_send_message(ddata->mb[idx].chan, "detach");
+			if (err < 0)
+				dev_warn(&rproc->dev, "warning: remote FW shutdown without ack\n");
+		}
+	}
+}
+
+static int stm32_rproc_tee_stop(struct rproc *rproc)
+{
+	stm32_rproc_tee_request_shutdown(rproc);
+
+	return rproc_tee_stop(rproc);
+}
+
+static int stm32_rproc_tee_prepare(struct rproc *rproc)
+{
+	struct device *dev = rproc->dev.parent;
+	struct device_node *np = dev->of_node;
+	struct rproc_mem_entry *mem;
+	int index = 0, mr = 0;
+	u64 da;
+
+	/* Register associated reserved memory regions */
+	while (1) {
+		struct resource res;
+		int ret;
+
+		ret = of_reserved_mem_region_to_resource(np, mr++, &res);
+		if (ret)
+			return 0;
+
+		if (stm32_rproc_tee_pa_to_da(rproc, res.start,
+					     resource_size(&res), &da) < 0) {
+			dev_err(dev, "memory region not valid %pR\n", &res);
+			return -EINVAL;
+		}
+
+		/* No need to map vdev buffer */
+		if (strstarts(res.name, "vdev0buffer")) {
+			/* Register reserved memory for vdev buffer alloc */
+			mem = rproc_of_resm_mem_entry_init(dev, index,
+							   resource_size(&res),
+							   res.start,
+							   "vdev0buffer");
+		} else {
+			/* Register memory region */
+			mem = rproc_mem_entry_init(dev, NULL,
+						   (dma_addr_t)res.start,
+						   resource_size(&res), da,
+						   stm32_rproc_tee_mem_alloc,
+						   stm32_rproc_tee_mem_release,
+						   "%.*s",
+						   (int)(strchrnul(res.name, '@') - res.name),
+						   res.name);
+			if (mem)
+				rproc_coredump_add_segment(rproc, da,
+							   resource_size(&res));
+		}
+
+		if (!mem)
+			return -ENOMEM;
+
+		rproc_add_carveout(rproc, mem);
+		index++;
+	}
+
+	return 0;
+}
+
+static irqreturn_t stm32_rproc_tee_wdg(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+	struct rproc *rproc = platform_get_drvdata(pdev);
+
+	rproc_report_crash(rproc, RPROC_WATCHDOG);
+
+	return IRQ_HANDLED;
+}
+
+static void stm32_rproc_tee_mb_vq_work(struct work_struct *work)
+{
+	struct stm32_mbox *mb = container_of(work, struct stm32_mbox, vq_work);
+	struct rproc *rproc = dev_get_drvdata(mb->client.dev);
+
+	mutex_lock(&rproc->lock);
+
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED)
+		goto unlock_mutex;
+
+	if (rproc_vq_interrupt(rproc, mb->vq_id) == IRQ_NONE)
+		dev_dbg(&rproc->dev, "no message found in vq%d\n", mb->vq_id);
+
+unlock_mutex:
+	mutex_unlock(&rproc->lock);
+}
+
+static void stm32_rproc_tee_mb_callback(struct mbox_client *cl, void *data)
+{
+	struct rproc *rproc = dev_get_drvdata(cl->dev);
+	struct stm32_mbox *mb = container_of(cl, struct stm32_mbox, client);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+
+	queue_work(ddata->workqueue, &mb->vq_work);
+}
+
+static void stm32_rproc_tee_free_mbox(struct rproc *rproc)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ddata->mb); i++) {
+		if (ddata->mb[i].chan)
+			mbox_free_channel(ddata->mb[i].chan);
+		ddata->mb[i].chan = NULL;
+	}
+}
+
+static const struct stm32_mbox stm32_rproc_tee_mbox[MBOX_NB_MBX] = {
+	{
+		.name = STM32_MBX_VQ0,
+		.vq_id = STM32_MBX_VQ0_ID,
+		.client = {
+			.rx_callback = stm32_rproc_tee_mb_callback,
+			.tx_block = false,
+		},
+	},
+	{
+		.name = STM32_MBX_VQ1,
+		.vq_id = STM32_MBX_VQ1_ID,
+		.client = {
+			.rx_callback = stm32_rproc_tee_mb_callback,
+			.tx_block = false,
+		},
+	},
+	{
+		.name = STM32_MBX_SHUTDOWN,
+		.vq_id = -1,
+		.client = {
+			.tx_block = true,
+			.tx_done = NULL,
+			.tx_tout = 500, /* 500 ms time out */
+		},
+	},
+};
+
+static int stm32_rproc_tee_request_mbox(struct rproc *rproc)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	struct device *dev = &rproc->dev;
+	unsigned int i;
+	int j;
+	const unsigned char *name;
+	struct mbox_client *cl;
+
+	/* Initialise mailbox structure table */
+	memcpy(ddata->mb, stm32_rproc_tee_mbox, sizeof(stm32_rproc_tee_mbox));
+
+	for (i = 0; i < MBOX_NB_MBX; i++) {
+		name = ddata->mb[i].name;
+
+		cl = &ddata->mb[i].client;
+		cl->dev = dev->parent;
+
+		ddata->mb[i].chan = mbox_request_channel_byname(cl, name);
+		if (IS_ERR(ddata->mb[i].chan)) {
+			if (PTR_ERR(ddata->mb[i].chan) == -EPROBE_DEFER) {
+				dev_err_probe(dev->parent,
+					      PTR_ERR(ddata->mb[i].chan),
+					      "failed to request mailbox %s\n",
+					      name);
+				goto err_probe;
+			}
+			dev_info(dev, "mailbox %s mbox not used\n", name);
+			ddata->mb[i].chan = NULL;
+		}
+		if (ddata->mb[i].vq_id >= 0) {
+			INIT_WORK(&ddata->mb[i].vq_work,
+				  stm32_rproc_tee_mb_vq_work);
+		}
+	}
+
+	return 0;
+
+err_probe:
+	for (j = i - 1; j >= 0; j--)
+		if (ddata->mb[j].chan) {
+			mbox_free_channel(ddata->mb[j].chan);
+			ddata->mb[j].chan = NULL;
+		}
+	return -EPROBE_DEFER;
+}
+
+static void stm32_rproc_tee_kick(struct rproc *rproc, int vqid)
+{
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	unsigned int i;
+	int err;
+
+	if (WARN_ON(vqid >= MBOX_NB_VQ))
+		return;
+
+	for (i = 0; i < MBOX_NB_MBX; i++) {
+		if (vqid != ddata->mb[i].vq_id)
+			continue;
+		if (!ddata->mb[i].chan)
+			return;
+		err = mbox_send_message(ddata->mb[i].chan, "kick");
+		if (err < 0)
+			dev_err(&rproc->dev, "%s: failed (%s, err:%d)\n",
+				__func__, ddata->mb[i].name, err);
+		return;
+	}
+}
+
+static const struct of_device_id stm32_rproc_tee_match[] = {
+	{
+		.compatible = "st,stm32mp15-m4-tee",
+		.data = &stm32mp15_m4_dma_ranges,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_rproc_tee_match);
+
+static int stm32_rproc_tee_parse_dt(struct platform_device *pdev,
+				    struct stm32_rproc_tee *ddata,
+				    bool *auto_boot)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int err, irq;
+
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq > 0) {
+		err = devm_request_irq(dev, irq, stm32_rproc_tee_wdg, 0,
+				       dev_name(dev), pdev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "failed to request wdg irq\n");
+
+		ddata->wdg_irq = irq;
+
+		if (of_property_read_bool(np, "wakeup-source")) {
+			device_init_wakeup(dev, true);
+			dev_pm_set_wake_irq(dev, irq);
+		}
+
+		dev_info(dev, "wdg irq registered\n");
+	}
+
+	*auto_boot = of_property_read_bool(np, "st,auto-boot");
+
+	return 0;
+}
+
+static int stm32_rproc_tee_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct stm32_rproc_tee *ddata;
+	struct rproc *rproc;
+	bool auto_boot;
+	u32 proc_id;
+	int ret;
+
+	ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "reg", &proc_id);
+	if (ret) {
+		dev_err(dev, "invalid reg on %pOF\n", np);
+		return ret;
+	}
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ret = stm32_rproc_tee_parse_dt(pdev, ddata, &auto_boot);
+	if (ret)
+		return ret;
+
+	ret = rproc_tee_register(dev, &rproc, proc_id, auto_boot);
+	if (ret)
+		return dev_err_probe(dev, ret, "signed firmware not supported by TEE\n");
+
+	rproc->ops->prepare = stm32_rproc_tee_prepare;
+	rproc->ops->stop = stm32_rproc_tee_stop;
+	rproc->ops->kick = stm32_rproc_tee_kick;
+
+	ddata = rproc->priv;
+
+	ddata->ranges = device_get_match_data(&pdev->dev);
+
+	rproc->has_iommu = false;
+	ddata->workqueue = create_workqueue(dev_name(dev));
+	if (!ddata->workqueue) {
+		dev_err(dev, "cannot create workqueue\n");
+		ret = -ENOMEM;
+		goto free_resources;
+	}
+
+	platform_set_drvdata(pdev, rproc);
+
+	ret = stm32_rproc_tee_request_mbox(rproc);
+	if (ret)
+		goto free_wkq;
+
+	return 0;
+
+free_wkq:
+	destroy_workqueue(ddata->workqueue);
+free_resources:
+	rproc_resource_cleanup(rproc);
+	if (device_may_wakeup(dev)) {
+		dev_pm_clear_wake_irq(dev);
+		device_init_wakeup(dev, false);
+	}
+	rproc_tee_unregister(dev, rproc);
+
+	return ret;
+}
+
+static void stm32_rproc_tee_remove(struct platform_device *pdev)
+{
+	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+	struct device *dev = &pdev->dev;
+
+	stm32_rproc_tee_free_mbox(rproc);
+	destroy_workqueue(ddata->workqueue);
+
+	if (device_may_wakeup(dev)) {
+		dev_pm_clear_wake_irq(dev);
+		device_init_wakeup(dev, false);
+	}
+
+	rproc_tee_unregister(dev, rproc);
+}
+
+static int stm32_rproc_tee_suspend(struct device *dev)
+{
+	struct rproc *rproc = dev_get_drvdata(dev);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+
+	if (device_may_wakeup(dev))
+		return enable_irq_wake(ddata->wdg_irq);
+
+	return 0;
+}
+
+static int stm32_rproc_tee_resume(struct device *dev)
+{
+	struct rproc *rproc = dev_get_drvdata(dev);
+	struct stm32_rproc_tee *ddata = rproc->priv;
+
+	if (device_may_wakeup(dev))
+		return disable_irq_wake(ddata->wdg_irq);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(stm32_rproc_tee_pm_ops,
+				stm32_rproc_tee_suspend, stm32_rproc_tee_resume);
+
+static struct platform_driver stm32_rproc_tee_driver = {
+	.probe = stm32_rproc_tee_probe,
+	.remove = stm32_rproc_tee_remove,
+	.driver = {
+		.name = "stm32-rproc-tee",
+		.pm = pm_ptr(&stm32_rproc_tee_pm_ops),
+		.of_match_table = stm32_rproc_tee_match,
+	},
+};
+module_platform_driver(stm32_rproc_tee_driver);
+
+MODULE_DESCRIPTION("STM32 Remote Processor TEE Control Driver");
+MODULE_AUTHOR("Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>");
+MODULE_LICENSE("GPL");
+
-- 
2.43.0

