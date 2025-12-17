Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE015D65C77
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 16:11:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1C02041B70
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 16:11:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Iel72G6s;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CCC0A40AC5
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 16:11:16 +0000 (UTC)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHFWBYX617538;
	Wed, 17 Dec 2025 16:40:00 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3bbecdfx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 16:40:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVpsd1HH0WUZoBbJ6X7//KBO0R5tVRTwcd4MqCDLQ+P7twBp/8vF1h+8FjbH/2mjK6t9Mjb5Y1Zv+ADoslFNQOPNWtR+9qqWSnoJhoqKzeYl9L6/0SMzXNCCDr5Uo5YvafU1Dx44cYYVfCieMnINNnEsD1ymOCY2OesDBttXses/YlVb0IWWiuCXQMe4AF/U7donHbqwi+sQLJ02j2+qtPiu8BKX2vU7NU3kaWjSFJ1x7lEg/kbp9Sot64S+DK8z1Tu8C8zpYn3AtU+1ZgF9TP2NJ+9cE2ljOQb4muHIk05+zLu4MYNh/tkdDUw/ShWb7o3vkclZR6BEAUMlkYQ8iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xra17NmZ0bE1TL7GUNzTpKv680VBaVNZOky9y00OaFc=;
 b=MDfJZp8TACKcmeQxhZV3Ua5KLaa3lgBewpnI9Oerj8TZ0D2noQNpT4cG46x5C+VuD1hlelaEcfGoosYNBRXqBPdIA+JNWehsdcQRNmpaIyUZWYiDJesuqsOeBlL04lXDM3rupCY/i/sRvjPLlwRdZ6cnAAttH5CHaW8REfcKz8Cm8+k3VRjHKOYCn5+rJlZnuGYG+Juh7qVdQ7P8pKFILdccmftfIT3idjsN5rBHz8vTXTrTWzlwU9Ft0PxJpZgdz65sOMKcNahR1Rk+ei/9A97lMb3pJCai9xW/LWQcX9ucdBFwNHltvrRboDxJyRL4hqdmEkds57ED9BEtqIzJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xra17NmZ0bE1TL7GUNzTpKv680VBaVNZOky9y00OaFc=;
 b=Iel72G6s3MOusdAbwnO2BcCqoP3C1peAiFkMSOBjUYw81g9vy+bhAzEj+qs/SRvbB7hWB9wt6BuaKITyR17mu/IEqEU1q8MMMa3tvJ/iGdCe4FGscNQJ22k7sZIkFN2Ljf49AFP8BvaW/A1Q5NCYQxHIUtWAKL5Ywx84+9ztxWHBaPFT4C2adOvGqTOS/QcfC4T1ht0VVoW/qmx8uiWV2X3FYjbzqHTfIxo1kNnbgV4w8EUxIeUonfHeyOh1hQvywATj8NRN4CYt1+XV7uKcQWzztVgJGHMHgNci8/GYnSqZe4nUgymSnEldU2dugqSjZPDUeAu+xX55fl0aWlHUnw==
Received: from AS4P195CA0051.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:65a::17)
 by GV2PR10MB6381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:39:55 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:20b:65a:cafe::a) by AS4P195CA0051.outlook.office365.com
 (2603:10a6:20b:65a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 15:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:39:54 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:40:42 +0100
Received: from localhost (10.48.87.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:39:53 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v20 3/6] remoteproc: core: Introduce rproc_pa_to_va helper
Date: Wed, 17 Dec 2025 16:39:14 +0100
Message-ID: <20251217153917.3998544-4-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000197:EE_|GV2PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d7d29c-6aab-46b8-89bd-08de3d8286ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZLnehrmQXsM0C1MTaB1xIzVCIQ0HOaYIT+ON3EYbpTR68g0SQtNB+LAUxHvc?=
 =?us-ascii?Q?/oWsHhZYwm/DaVHPszrqkMMgYP1dHYg0XcFW9cAWyWh5fY0yvU8K6IjQe4Rj?=
 =?us-ascii?Q?pBKIv7vS6JXWssbHkILq1r5dfHDGfCU9PTMDXyDxG9u+Dk3Guzl5f40ge8Bk?=
 =?us-ascii?Q?RKQJ9j4YELG8G9DzGJpAIdhcDNR5ieAsHVe/ZYWL5lNCOYZkQ+fetdWzEE7X?=
 =?us-ascii?Q?lrdhsRnMxKLFhLhknxj05wddgJ+MxvIiPNByq4FiW7ZtHCVTaUskheu7gs3l?=
 =?us-ascii?Q?xkU2jrG9naotbYa7ugGKkpfT6V3kMyfQAF5KTwlxv2k8oTXV5LAYzdF98Mwf?=
 =?us-ascii?Q?Bk70iO4R1A1F4/7KzTG1pRs/AZZeRSWtBU2QwVSpgj1iKovt+AYVWD2Py6Wa?=
 =?us-ascii?Q?ZJbNPabc4cBEvy64z5vRzg0Qi21gYVYE6la+yeeMy6wUaR4cqawmQPK8RR2o?=
 =?us-ascii?Q?Y94A038FJ4uTGyFHUstgLKAjvbQIqfgbQAkAxoGP2WBBnMWSfTlvmCuA4zFK?=
 =?us-ascii?Q?TeJ0o19H3rKWrsvgGazTUR0Mbc8oNwOmHL8PwiOTWQTOma1CpTjaWMh9Jrc8?=
 =?us-ascii?Q?03VKI7VtoOGIYMbT90M6cZ9jIehoNqhcaFyKsoXHObKdbadwvhP2Eynd7KUS?=
 =?us-ascii?Q?P2b/P0Kp/Xw8+/C7b2q59t++9ZPFC79zsW+IIIp6XxePL10Q3IT4MzQXiEFa?=
 =?us-ascii?Q?JpwLRDAVkB2NpOBzWgGgePlz0JpSoDki8uRJVJHdX9aFGaJN3yBktvq8Irud?=
 =?us-ascii?Q?n8/i5x296qKC2K70fBG4ZDv9q1pguspqxZdP4DqOhQq8I5j38giA2qBH7MSJ?=
 =?us-ascii?Q?j1lQjl+Zbjb+TIhBfSfoe0TukLIP1CXc5oA1NKU8Jzd53KiSiTtYyMy/su+p?=
 =?us-ascii?Q?W8cUH1J8I0rnYZ8lrw1f0tfgohp6OpS5GN1hskG2q6wi1K7n22MPCUGpMigN?=
 =?us-ascii?Q?Q0oxOTQVdR4Nu+n7fXWbdfeNfSwANT30DuBwqTmhyi+s21O1TaTfEaM+XQDP?=
 =?us-ascii?Q?20rGbcPeo4umluGu19JUI2eJBONgsl4/E0lG9b6DRCs5pOz54fkQ0SXwVyic?=
 =?us-ascii?Q?hEs3EAJzCrQqwLGmMKz82+JybFtTxySaHT9D/KuS7+mpd+CBhUDnWGaNfner?=
 =?us-ascii?Q?MEgvTsyAhX/j4JMVSRjAOEl6TY7ncbqP07J2nBLppk7jikJQHmDqxe6kIy5R?=
 =?us-ascii?Q?zn/4/kG8SoLIlKHL+7E5RqOLBXa3Uho5dzmyw6gZbK+gg3kigCrvJtvDq+e0?=
 =?us-ascii?Q?knPBTMSHEuqwpmYdhkyTkgngOxz70oBh+bq73F/EM6p/Se53FzoAUYG8Ah8d?=
 =?us-ascii?Q?Xf2hYqiov4A3FgSYMNv3hiMmJBQvD2KAdJOxqZBrLfZaz7X21DgGvjPGsp4E?=
 =?us-ascii?Q?KYzs/GSeR5cHhYdRdIrujSqYwG48QsDEnp2hhf+0eKnncUxIdWEdzF4HkBC8?=
 =?us-ascii?Q?unPCEQKlrTHEtquhlZjtDIHkZRHRt5jk01NhUz1XyvgpxyY73sBzIOVfwBXg?=
 =?us-ascii?Q?KpgdHx1JTxegJiQR/2klJKC83it7+FM+esYhFWiodh84UTg0GNJN1JfyknsL?=
 =?us-ascii?Q?mbciSeiKssFiXYMGoXM=3D?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:39:54.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d7d29c-6aab-46b8-89bd-08de3d8286ce
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6381
X-Authority-Analysis: v=2.4 cv=JK82csKb c=1 sm=1 tr=0 ts=6942ced0 cx=c_pps
 a=qOkcUHOkeTdS7jQc1VlYeQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=wP3pNCr1ah4A:10
 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8b9GpE9nAAAA:8 a=UTKkbO-VyYAnisI0h10A:9 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: 3EGPlHkhSBc1mYEUuGNLajJxZd2r5HPj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyMyBTYWx0ZWRfXyIhhG+WrFna7
 jdRLpt+9946auDaGtGyjPLEJWngDsM4VwC3necqlolSvYINDm8nZkQt7xna5kT0jcqTD1Lnnfym
 yxnB5DK1t3NRi4AQg6mrOv6ykpLJGl9lbMcWfkF7aIL1X9GXHJi0QeQkDBkwuq28HgIl4KwyWmn
 6ihIDoToBj36WIV6S/ZVFZ1io+Ge2vQyhd01GAkM57d65IOKnGbbiIEgr4qlBCrypEf3Itvu5q2
 JALZSJ5p8vZ/HLi4ibBa7tsAnr/IfgmVIVXMCz5Pf0Ln0gdLYwGlKsXWNGWNrf+mBCyqnpbtSBs
 qxY5ib3jhwFejoynrfqgX8nVlGeV7Vh6ejIbhXE4WpKo0xh3i3aqZnVICJ1nMX0nd5lyjc4dvMJ
 L/sjd/+1B0rcPI+YWPfmmFu+MZLzQQ==
X-Proofpoint-GUID: 3EGPlHkhSBc1mYEUuGNLajJxZd2r5HPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:185.132.182.106:c];
	RCVD_IN_DNSWL_LOW(-0.10)[185.132.182.106:from];
	MIME_GOOD(-0.10)[text/plain];
	BLOCKLISTDE_FAIL(0.00)[52.101.66.24:server fail,2603:10a6:20b:65a::17:server fail,185.132.182.106:server fail,2603:10a6:20b:65a:cafe::a:server fail];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:65a:cafe::a:received,2603:10a6:20b:65a::17:received];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FORGED_SENDER_VERP_SRS(0.00)[];
	ASN(0.00)[asn:52129, ipnet:185.132.182.0/24, country:US];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.66.24:received];
	HAS_XOIP(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CCC0A40AC5
X-Spamd-Bar: --
Message-ID-Hash: 222MPQL7MALPSB223JHGZS53ZYJKLLX6
X-Message-ID-Hash: 222MPQL7MALPSB223JHGZS53ZYJKLLX6
X-MailFrom: prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/222MPQL7MALPSB223JHGZS53ZYJKLLX6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

When a resource table is loaded by an external entity such as U-boot or
OP-TEE, we do not necessarily get the device address(da) but the physical
address(pa).
This helper performs similar translation than the rproc_da_to_va()
but based on a physical address.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 drivers/remoteproc/remoteproc_core.c | 46 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 825672100528..f7c96dbed189 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -230,6 +230,52 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
 }
 EXPORT_SYMBOL(rproc_da_to_va);
 
+/**
+ * rproc_pa_to_va() - lookup the kernel virtual address for a physical address of a remoteproc
+ * memory
+ *
+ * @rproc: handle of a remote processor
+ * @pa: remoteproc physical address
+ * @len: length of the memory region @pa is pointing to
+ * @is_iomem: optional pointer filled in to indicate if @da is iomapped memory
+ *
+ * This function is a helper function similar to rproc_da_to_va() but it deals with physical
+ * addresses instead of device addresses.
+ *
+ * Return: a valid kernel address on success or NULL on failure
+ */
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *is_iomem)
+{
+	struct rproc_mem_entry *carveout;
+	void *ptr = NULL;
+
+	list_for_each_entry(carveout, &rproc->carveouts, node) {
+		int offset = pa - carveout->dma;
+
+		/*  Verify that carveout is allocated */
+		if (!carveout->va)
+			continue;
+
+		/* try next carveout if da is too small */
+		if (offset < 0)
+			continue;
+
+		/* try next carveout if da is too large */
+		if (offset + len > carveout->len)
+			continue;
+
+		ptr = carveout->va + offset;
+
+		if (is_iomem)
+			*is_iomem = carveout->is_iomem;
+
+		break;
+	}
+
+	return ptr;
+}
+EXPORT_SYMBOL(rproc_pa_to_va);
+
 /**
  * rproc_find_carveout_by_name() - lookup the carveout region by a name
  * @rproc: handle of a remote processor
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index b4795698d8c2..8fd0d7f63c8e 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -690,6 +690,7 @@ int rproc_detach(struct rproc *rproc);
 int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 void *rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem);
+void *rproc_pa_to_va(struct rproc *rproc, phys_addr_t pa, size_t len, bool *is_iomem);
 
 /* from remoteproc_coredump.c */
 void rproc_coredump_cleanup(struct rproc *rproc);
-- 
2.43.0

