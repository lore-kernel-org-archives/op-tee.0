Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F784D68BE8
	for <op-tee@archiver.kernel.org>; Thu, 18 Dec 2025 07:31:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C26EA4FF3E
	for <op-tee@archiver.kernel.org>; Thu, 18 Dec 2025 07:31:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Kvq6K6b1;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 266A640AD1
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 15:46:27 +0000 (UTC)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHFdn8t072175;
	Wed, 17 Dec 2025 16:39:57 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3gavkjdq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 16:39:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=So7HCY1GK9Qh+RwlMYwpkp5TNJbNC/c1lAo1mc0nbmsRHjoZsxOUip9NYRGl4zQFWc2lgXMEMjrtxmrzfhkimDkoU4Teye7UjmtevcfSA52Wty+JDq7L4jVBJd1lberCZdKBPHpmMGjJKx6OgCFTEOeotRlzyyaLMxjRfvU+yJKIn0JQGSOsDIKAZ0J7JM53blo4uJ0cwfgqi2WJVee9h14WAFXRo2putCMSJE/aZt41RUB1OQHv/WDQmjagLSCi/fylFdnwR87rloAPVBpHbJYcq+JqQ4tD0jsHlm7FHq8rgkKhfwrgZuk0CxVp2o2mGczJXZyOgcu1Di0DFMzQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVnX47y9eLUnyonTmsIYsd1TzbP1+Mgmimqn69+e4g0=;
 b=NWvU5pGCXiE5F0/zjmCAgPyLqDZ+XLFalH0cu2vULerSnTE7sQ7xIgX4tVz4MviPQ8+ZimDb7suU6eZRVybjMkQNEVykc+2phAzbxkqf+nrxkAeWSW5Zop6tVEnMz8CMJ4vavuDaYOgR2abRNnSTnvD53cFqyZq/gKW58RgBfY08dHYlKN+6xARH+jBa8mxqcutJn49tnhGCq2QpJ+mPQ62R/pXqLvtBPKewaLld2KAzzFhWM8n6Le8GIBJulF26AzPsZbMoR17K0o92qUFG0uHGmRCPVp7AjsYBKtmdMjM5OVwFf10pwjesnamRmHJSNgbzR4+p4UUFA+0JF7spCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVnX47y9eLUnyonTmsIYsd1TzbP1+Mgmimqn69+e4g0=;
 b=Kvq6K6b1mqmdhtH+/yJK2pnJuaFYLuU8tMveMOginleTrW3BzBgVIsZjC7G9qCg1u81tiPq4jKPKJOzODFe5DWHrlR4Ec3K+6ef+E3zVW29Sc/mIQex4Dodcu0MCbroMi4YhUkBhoE5TSE4vVqorHdIOuEGn91TXUQXUCdRYpGnNSXhPn6rtJqI87fjQH8sn1Ln+svji+CSMUeFDcwErgak5O9WZC1XHZIYqrFcV0GKEiHzTpVAqjlpyvN7fpCUZpVbpBnwN6LgmXyofg3g7bhB08javgLasCfCJmBnhbuBMBNULDnmX1IR0sQiiORz3T+8Di/olHCRGlJU2VDN0EQ==
Received: from AS4P251CA0014.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::14)
 by AM7PR10MB3271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:39:52 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::d4) by AS4P251CA0014.outlook.office365.com
 (2603:10a6:20b:5d2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:39:52 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:40:40 +0100
Received: from localhost (10.48.87.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:39:51 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v20 0/6] Introduction of a remoteproc tee to load signed firmware
Date: Wed, 17 Dec 2025 16:39:11 +0100
Message-ID: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|AM7PR10MB3271:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ff0a73-4e73-4ed9-4687-08de3d828544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|7416014|376014|30052699003|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/APLkWxUSO8J68BORPUBP0x2lV1vVsx6XlGESciGBywAEcuL1yrLjJ8zZIja?=
 =?us-ascii?Q?cqK04FOVJWHPpPpfkhEYOHt1Y/1By3VsP/D5bVX/9lLhV+InYiFlLe4rP8PV?=
 =?us-ascii?Q?N6kjD8+9kyg31K9nMrA3z3LFs82DDY+zLvjAlYFR/kDCwUChxtGWxG9CQQUr?=
 =?us-ascii?Q?ZNbbh9L9MtEeEpG7xO4+4niDt2J3LZr0iEy08gxD5sQdTLIGc3gGwE23XTjd?=
 =?us-ascii?Q?KH74/7Kg/mtzLGAE2gvVwl6xJpYlQlkg5GV2MFQgRhBfrJOV9P0jCwgeExZE?=
 =?us-ascii?Q?JV54Xa04wFw6Wmh0t9p+ZCLHwtZ5X8VHUzbkKQYGTfkEk5pFeUg5n80HrPcA?=
 =?us-ascii?Q?Ey/Oiv410u1k4RrrPcIKzeABm+pVB9xI3D00pc2o6WFDa6Mm5j9JCKGIlX+o?=
 =?us-ascii?Q?gh1DqLqt82yh+NYwjwZocddeZgb6bBHfu7UTHE403t3AZSQWILzKS6OIljY4?=
 =?us-ascii?Q?pxcQCztx38pWjX6nngnNJFSQ53a/GZIzeaiohFMzmq00K2BooKn++GkuHAiW?=
 =?us-ascii?Q?4gcmSICfbKDXfGlX8bIqANQqO/O3UFAPNpH59cH3AxM2BmRNpjbSJyIPkJ1W?=
 =?us-ascii?Q?YbhNBi9od+8b2C7tUDa7+dByyGGkT2MnMrO3+0m/Gi3g2G4ToAf44lGamt1m?=
 =?us-ascii?Q?Rm7k8u7XK5C5GfFqF5oqDvR7RgqvKC5vmC51dWZq2UBJOdxrsBacdhpSgNb3?=
 =?us-ascii?Q?FDsi4mLamGfTUo6+9arv6EbeO4IOVSnJlMptHVkmpLK7fEDwHy51h7L5SlDP?=
 =?us-ascii?Q?nUGH/m2d6nQS5ppn5aczvvdbUcV+akqknrIRV/7Eoha1llwkifrwBoYjVc0t?=
 =?us-ascii?Q?GBhJPOfuWb7FN1idqczNAob7ceZCoGrjACI/SJpiirt8CEMxqohln0EdPUhn?=
 =?us-ascii?Q?6x/EvNb/dLL//Yxu4Amna0VYYlw3YcysGCAFOaXZ4JJKAc9d0zKzsVu5q9pR?=
 =?us-ascii?Q?yqxr7Kbxr5pRXXeVKWFL19W/QUH39umht0GbEknSPZJLA78kzYmuw+7MWISS?=
 =?us-ascii?Q?brUeAlfPp5MIgeCr4MLR7crpJQic2BXEVHhBQpjVa5EIz5VcCc9OkC7maKK1?=
 =?us-ascii?Q?lAqUZvgVsQ8XUzGNMBTanCimUeerEQm2rnZizwwQuc+e2SFxsfK/jJm2QWry?=
 =?us-ascii?Q?uGl5L15rez/YAht3czg30DSgrGV8bHjNntz+fgNtMN2UCxUhiNmo8AK8K0sx?=
 =?us-ascii?Q?82HfpQ5hcica3id34mw6MoWJtuc/ovVhCAWPSbMIDSOh93HpcC7RnGh3u9hU?=
 =?us-ascii?Q?pMmuTWZ6NJP6VCZq5ymxjSnxoP+61wKqsKneV3lAfEgkTrXOxfMUuDw939go?=
 =?us-ascii?Q?9inJJegFwwibx1dovDoULsnF65WZEMJz3qRk26Q1kpwWgoNOqfzmeNW2EtAA?=
 =?us-ascii?Q?jVg28KSkgUNQK1DRHmVwB7eKlC+TD4o3BgO+gEHVRAFo/7/QgvBMp5zbefbv?=
 =?us-ascii?Q?ZFMojKO7EhM/4/PdIrXsEJBkCpr1BU4neDgLjk861RhiKiQitAHnirEZV4ma?=
 =?us-ascii?Q?0vI6EacrjuespzCTjnRrWOq3zg5Rcx6knFuXXBt2cgcM49QeZz2+xs93KdKH?=
 =?us-ascii?Q?Rcr2sUDNbFvMplc3j/bgYvrDiNerYRqZtHOmLFUn?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(30052699003)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:39:52.3319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ff0a73-4e73-4ed9-4687-08de3d828544
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3271
X-Authority-Analysis: v=2.4 cv=Ba3VE7t2 c=1 sm=1 tr=0 ts=6942cecd cx=c_pps
 a=LGnPzPuKiaZPXrRM6phl+Q==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=wP3pNCr1ah4A:10
 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=dChbvKt_AAAA:20 a=KKAkSRfTAAAA:8
 a=CVn58vbsVnitWPl08coA:9 a=T3LWEMljR5ZiDmsYVIUa:22 a=cvBusfyB2V15izCimMoJ:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: Ps7pOUVlAHsT05AjUTPEt2XMDZgAz_ai
X-Proofpoint-GUID: Ps7pOUVlAHsT05AjUTPEt2XMDZgAz_ai
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyMyBTYWx0ZWRfX+IDZLVVNRtHS
 70rzpoSjCsXuLaI3t55jltMJVmF3ywIHD6RAu2yhkg1GmG5HbIJ5+J7mRYwbjnCGDWpoUA+nRUV
 BeXokmA3yJG8R4aFcyN8rYkEqSfAw/N/DjwHruJEhQGTL2LTfRYYCz2tFUpEKFRy6h07Kr+1jcP
 x5fXdz36UuO3kfDmPFy7Kuw8IU0WPTtrAVRhuVA71I2aZXcBVnxEfiF4LTe9xz3qOwdqtn0fpEI
 qLalCABEl73tD7Y7JsVeUVztSVYUCLGtqFbvkR24z6dlkZhNUzE21Uvl2uBr9TEl9uYjqKRL+Ov
 dOBEg/9yMK05k4Kg4DCTD/BcsFEm/owVKg+pUdPa16OJeidaYOhg/4gonzFRHz6AzzzbFMPyzal
 ejHnONZkuPa55Py/aLm6Okr67sNrAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170123
X-Rspamd-Action: add header
X-Spamd-Result: default: False [4.90 / 15.00];
	URL_BACKSLASH_PATH(4.00)[0.0.0.0];
	URL_NUMERIC_IP(3.00)[0.0.0.0];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	RCVD_IN_DNSWL_LOW(-0.10)[91.207.212.93:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	GREYLIST(0.00)[pass,body];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:52129, ipnet:91.207.212.0/23, country:US];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:5d2:cafe::d4:received];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_VERP_SRS(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	BLOCKLISTDE_FAIL(0.00)[164.130.1.59:server fail,2603:10a6:20b:5d2::14:server fail,2603:10a6:20b:5d2:cafe::d4:server fail,91.207.212.93:server fail,40.107.162.9:server fail];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 266A640AD1
X-Spamd-Bar: ++++
X-MailFrom: prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Hits: header-match-op-tee.lists.trustedfirmware.org-0
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Message-ID-Hash: S6EP46PRFXIFKVWXR7C46IT6CYF2ZSS5
X-Message-ID-Hash: S6EP46PRFXIFKVWXR7C46IT6CYF2ZSS5
X-Mailman-Approved-At: Thu, 18 Dec 2025 07:30:43 +0000
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S6EP46PRFXIFKVWXR7C46IT6CYF2ZSS5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
X-Spam: Yes

Main updates from version V19[3]:
--------------------------------
The devicetree is now structured as follows:

	firmware {
		optee {
			compatible = "linaro,optee-tz";
			method = "smc";
			#address-cells = <1>;
			#size-cells = <0>;
			rproc-service@0 {
				compatible = "rproc-service-80a4c275-0a47-4905-8285-1486a9771a08";
				reg = <0>;
				#address-cells = <1>;
				#size-cells = <0>;
				status = "okay";
				m4: m4@0 {
					compatible = "st,stm32mp15-m4-tee";
					reg = <0>;
					mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
					mbox-names = "vq0", "vq1", "shutdown";
					memory-region = <&vdev0vring0>,	<&m_ipc_shm>, <&mcuram2>,
							<&vdev0vring1>, <&vdev0buffer>, <&retram>;
					interrupt-parent = <&exti>;
					interrupts = <68 1>;
					status = "okay";
				};
			};
		};
	};

As a consequence, this version:

- Introduces a new stm32_rproc_tee.c remoteproc driver.

  Instead of further complicating the existing stm32_rproc.c driver, a
  dedicated TEE-based driver is added. Both drivers are intended to also
  support the STM32MP2x Cortex-M33 remote processor in a next step.

- Reworks the bindings:
  - Drop the st,stm32-rproc.yaml updates that were introduced in previous
    revisions.
  - Add remoteproc-tee.yaml for the
    "rproc-service-80a4c275-0a47-4905-8285-1486a9771a08" compatible.
  - Add st,stm32-rproc-tee.yaml for the "st,stm32mp15-m4-tee" compatible.

- Reworks the probing sequence:

  The m4@0 device is now probed by the remoteproc-tee driver, which itself
  is instantiated by the TEE (OP-TEE) bus.


Main updates from version V18[2]:
--------------------------------
- rework documentation for the release_fw ops 
- rework function documentation in remoteproc_tee.c
- replace spinlock by mutex and generalize usage in remoteproc_tee.c


Main updates from version V17[1]:
--------------------------------
- Fix:  warning: EXPORT_SYMBOL() is used, but #include <linux/export.h>
  is missing


More details are available in each patch commit message.

[1] https://lore.kernel.org/linux-remoteproc/20250613091650.2337411-1-arnaud.pouliquen@foss.st.com/
[2] https://lore.kernel.org/linux-remoteproc/20250616075530.4106090-1-arnaud.pouliquen@foss.st.com/
[3] https://lore.kernel.org/linux-devicetree/20250625094028.758016-1-arnaud.pouliquen@foss.st.com/


Tested-on:
---------
commit 7d0a66e4bb90 ("Linux 6.18")

Description of the feature:
--------------------------
This series proposes the implementation of a remoteproc tee driver to
communicate with a TEE trusted application responsible for authenticating
and loading the remoteproc firmware image in an Arm secure context.

1) Principle:

The remoteproc tee driver provides services to communicate with the OP-TEE
trusted application running on the Trusted Execution Context (TEE).
The trusted application in TEE manages the remote processor lifecycle:

- authenticating and loading firmware images,
- isolating and securing the remote processor memories,
- supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
- managing the start and stop of the firmware by the TEE.

2) Format of the signed image:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_core.c#L18-L57

3) OP-TEE trusted application API:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remoteproc.h

4) OP-TEE signature script

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py

Example of usage:
sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key ${OP-TEE_PATH}/keys/default.pem


5) Impact on User space Application

No sysfs impact. The user only needs to provide the signed firmware image
instead of the ELF image.


For more information about the implementation, a presentation is available here
(note that the format of the signed image has evolved between the presentation
and the integration in OP-TEE).

https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds

Arnaud Pouliquen (6):
  dt-bindings: firmware: Add TEE remoteproc service binding
  dt-bindings: remoteproc: Add STM32 TEE-controlled rproc binding
  remoteproc: core: Introduce rproc_pa_to_va helper
  remoteproc: Introduce optional release_fw operation
  remoteproc: Add TEE support
  remoteproc: stm32: Add TEE-controlled STM32 driver

 .../arm/firmware/linaro,optee-tz.yaml         |   6 +
 .../bindings/remoteproc/remoteproc-tee.yaml   |  47 ++
 .../remoteproc/st,stm32-rproc-tee.yaml        | 100 +++
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   3 +-
 drivers/remoteproc/remoteproc_core.c          |  52 ++
 drivers/remoteproc/remoteproc_internal.h      |   6 +
 drivers/remoteproc/remoteproc_tee.c           | 771 ++++++++++++++++++
 drivers/remoteproc/stm32_rproc_tee.c          | 526 ++++++++++++
 include/linux/remoteproc.h                    |   6 +
 include/linux/remoteproc_tee.h                |  89 ++
 11 files changed, 1615 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/st,stm32-rproc-tee.yaml
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 drivers/remoteproc/stm32_rproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h


base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.43.0

