Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B631ECAC59D
	for <op-tee@archiver.kernel.org>; Wed, 17 Sep 2025 13:48:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C8DBF41874
	for <op-tee@archiver.kernel.org>; Wed, 17 Sep 2025 13:48:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Oeg1blQt;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C957640AF2
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Sep 2025 13:48:34 +0000 (UTC)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HB7AXr022993;
	Wed, 17 Sep 2025 15:48:15 +0200
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012026.outbound.protection.outlook.com [52.101.66.26])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxuv2ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Sep 2025 15:48:15 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbHTUIaFkoXoDaT58eKhiHJhvYkaJhhm/NEEfDx3qxbgy/KF+BboZ6ThI0UmoOKhbmHSn/wJVeAWwMU2hYfq9NZRkL45UOjysc2GqjaNb5254EfpdKA0q9ahmq7F5sfSoAJfijUCgeVnuyvbLA73dOWdXkOkETZi9Z/pQVOLQJJwj0NuPLQaQuQhmzyQQkYPOc0Ni8RmGKFm3TmNT1/q22zI6NYouzzuKzn581QLm+yukuAcEOviBhRmCiCz4x1DcxxnvtEEYyFuk2YFyKRJUA/33HyLIqs859rlUdRo69a2NQTZ0s8fvS7uGMm8X5Sjizzeo/UQWZbJAnWlSiMr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7QlJx5YkaYf4BSoOsr67PuqI+N1OPJZr4jBrjlAJhU=;
 b=rUOeY7F86Vbt1kSve2gGgcS5WKezDwWFalUe24OWEM6Rp8ZB5LTPRBha0pkLvjcsppSVssA5lUSWFldSYO537RZIRAz34T38tdsV1YQg4EHaGEpFxNZrg41L01ZUYWZlULMdtisUglzspTkqDL4D7gLu0AOVjfG67hRLkHh5CiizNhxQr9sOSGcHr+ioWIZfMyTCWsBv+KuOLxspeZHQMNRoPi6K/F7cL529ClZiPuRrputqf1nD9ikwqDlz8VuBzr48rNjoIzngFVaXg2PY6CtpnqQg7QTdiYh9IAB9JRNftDXk4otSM6Drk5EqUN6vIZi1Oj/VKrHK86Go/ZE4vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7QlJx5YkaYf4BSoOsr67PuqI+N1OPJZr4jBrjlAJhU=;
 b=Oeg1blQtEuD4v/Sx7j+b18PYNtXeHa25YoLCDDOxU7E+Ttx8rRb/IKd+aPWf3v5M1yNX4b7QDw3XE+uJPqNR1mUW9J3w/Px1MOM6TZrKdkAFGHWmRxDZR9Nu11K+gRqQ1SZwDLaZSOlgWjvIYfXx/FXW1BOO8AYCSu4u4EUtyDEiFUb7PvVuewMJ5tqlwsQ89WP2Pspi+OgO+0S8VwPJBlwWX067oBSVsQbmA1VSNpjpeX5Sfp//7p+ctQCNYOVA8OGnknSPLq7ec6xzIBPp9E8rnF0z1FUZM4uLEXVQn2lVICdNJQvdghI23K42vF38C4Tgr1g61EKhSaf0I12xkQ==
Received: from DB9PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:10:1da::24)
 by GV1PR10MB5914.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 13:48:04 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::8d) by DB9PR05CA0019.outlook.office365.com
 (2603:10a6:10:1da::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 13:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 13:48:03 +0000
Received: from SHFDAG1NODE2.st.com (10.75.129.70) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 15:45:18 +0200
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 15:47:42 +0200
Received: from [10.48.87.127] (10.48.87.127) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 15:47:41 +0200
Message-ID: <8d385f2e-6470-4d66-be0b-a2a448a81fa4@foss.st.com>
Date: Wed, 17 Sep 2025 15:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 4/6] dt-bindings: remoteproc: Add compatibility for
 TEE support
To: Sumit Garg <sumit.garg@kernel.org>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
 <20250625094028.758016-5-arnaud.pouliquen@foss.st.com>
 <aMkqifHSdlCs4VjA@sumit-X1>
 <62bdb238-7440-451b-84ef-79f846b10ba0@foss.st.com>
 <aMqIhFdIqp5auH22@sumit-X1>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <aMqIhFdIqp5auH22@sumit-X1>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|GV1PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: b473709f-9fb0-47d9-f832-08ddf5f0d2bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NkhFeW9ubVlIekJjdWVGSXFSdVhtU0ozNGorZzJXRTJMTjY4QTlqOWt1Rkla?=
 =?utf-8?B?VGpoZGQ4VVI1M2wzU3lCbXBEQ1NSNFZja0MvckQvSmovNzRVM3h1YnRaS1li?=
 =?utf-8?B?TVhQT0RqOHVJWklmK1FvMjZkZVF4S1V5TzgyT1pycHZUL1VMSU1KWktVM2cy?=
 =?utf-8?B?cVlwMTY1VDRLYXFaSld3Nnhrek42UFlmVHlOdUloTXdHZ3VSNlJseVMzcEpQ?=
 =?utf-8?B?QTY4VDNocEc0VE5vYmNDakJMQlBWRE1XYnZHVkM4dGhqa2ZTUWdxQlFmU1dN?=
 =?utf-8?B?RW1uNHVyeWczdDhtckttU2IzUHMxY3ptUnNVQlhIcVZEYkd0cjNDa2hhRGZP?=
 =?utf-8?B?bHVqRVYrUUhXRnlRSzRxRTgxUkdMWWludUpLUzV3K0wraWtzQjZWWmtzNGh4?=
 =?utf-8?B?ckZiQVpxZkppaTFOdGplMXpOTkJ3ZDBBRjlLU05scXNSeW1palRYYitwakJC?=
 =?utf-8?B?b1ZabXZCVVNwMFQ5N0NNdnJOV1ZacFVvdnBOR29zVzJWWHE3RU5pN0xyZzRU?=
 =?utf-8?B?WVk1Ylo3eS8yVklYR1FKdXdHUndGVU50RTE2bXFVZWZSempuVkxkRUcvaDVS?=
 =?utf-8?B?YUw1QlQyQ2lkQjA1ZWlwUVg4U3Z1c05VeTd4YnhsVDdvL2twb0NqZ2ZuSnEw?=
 =?utf-8?B?MEUxUmZoN3BmVDgrMTFTYjBFZFpoRWEwbnB0OWlSSXBtYTgrRzRGN3lFTGF6?=
 =?utf-8?B?WHg1bC82aW5iTk1qMVZOcTJuaEsxQUJvcFQ3WFkxZlBLeTZBSFpMT25XUHR4?=
 =?utf-8?B?cGNYUGFNNDVjTHBReTJjWmtFNm93NllrU2FnTE5pRjd6ZTdXdWJXWXFMcm1k?=
 =?utf-8?B?VC9WS0F0UG1BWjdNOEFkbXF6SGJpQU9oTXRSZTBtcHZOOHoyYkd2K1ZhN0V0?=
 =?utf-8?B?dDRuYVFIZ2tpWnk5MkpWK1Ezd29HN2tUb1phdDV1alNjeUtJZmxjOGx1eGVj?=
 =?utf-8?B?Nm5VL2swMWMxVE8xamhuekZ4YjZNckpDMEI1eVI4QmY5eHdBbjE1YjZ0Vm1W?=
 =?utf-8?B?b3BSZnRPN2NHRGo4c1Fwa0o3TGFDMzVJdXpoTkUwMU1pS3VmYjlkaXRLMnd1?=
 =?utf-8?B?aW5Xa01ieTVQcWhKcWJ3S2hsTllIQ0UvYWRDQjNoVmN1clVMUDA1aGRQZVBq?=
 =?utf-8?B?TzVVQmhhMlY3ZFJWaGN1RU53WFAzNVljempOUTF2bW52Z1JjV1NWMGVrY3RO?=
 =?utf-8?B?SUxnT2pzaFg2S093ejl5Und2Y3htdTU2UW5NOUh0ZHBVRmlZakNtNldzR2Fz?=
 =?utf-8?B?WThBR2xSU1ZVblFDNGlBVmo5VXRRT2NDVzZRZWErNm5NL2ZDL0hBdlRpNHdX?=
 =?utf-8?B?bWxzMExIeWJ2aWJxVklGaURlS3V4a3ZsL3ZBVHNxcFNuQW12dkFuaTQ0Y0NU?=
 =?utf-8?B?ejRGVHVlcUg1Q1Y5UFRXMUJkL2xmbVJmSGhWTG81RjVCdDdwK3h1eTI3QUZh?=
 =?utf-8?B?Nnhld1FtK2VvdGw1SEZNSTFocUltSFFaaW44dWI0MzNWOFAvS0ZmQ09PcUVO?=
 =?utf-8?B?cmpwMzF6aDdrd2FzamhZUzZVNTdGZUxuSHlKSWp6VlVmRysxeHZaTXV0YzVG?=
 =?utf-8?B?YVFSN0I1Sy9vMGxSa0V1OWQzNUVBY1Z4cWI4ejdzL205WWdtZlgzTE5mVkJk?=
 =?utf-8?B?cFJ6d3RRdEhKUkprN0JKcFpidlpHZTZhanBucW5rSkxLMHhnYlNGSlpJVkl1?=
 =?utf-8?B?Tm1xeWRjTVNEeUxyaGNLY3dMbWVPYmM2NjhTdWhrMVJ6dVRaMllvZ3A5c2lI?=
 =?utf-8?B?RDA0OTJsNDV3VTU3SjJGWjd3RVdyQitWRW1aaWF1MmhzOVIwUHUzV1lCbDFm?=
 =?utf-8?B?WVBzdWExcktwOW0yNFo4VlRnMTZtWHd1YVBlazZlaTJxaVpOa0FQZUJtRkZy?=
 =?utf-8?B?c0Fsajk2QktwQ0FuczZMdlViUTVaQzNQMkpBdkhrYVV4Mi9IY3U4SWJycVJC?=
 =?utf-8?B?NUxpVGNHUW16d3RkbWV3a0NvZ3ZLZk4xNHhOYWUxU1Y1bFFRZ09sa2tpbkp0?=
 =?utf-8?B?a1Nuam9td1lBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 13:48:03.1819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b473709f-9fb0-47d9-f832-08ddf5f0d2bd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5914
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyBTHGch09Etv MAa1JAVo5K65Tfbbzqeo6hNM7rq5D9XbrKqcoFRaARzc+ptn3nkpADeATEZa77t5tRRRcmvlboX B8gUtaSrwN/oodfScda6wXwDJljYS9+p7NCqtY7VDaItZEn20KgjadFVWNlN/kzLZjVj5uxg5ai
 0stBY/4aWuayywUwRYIgYckUlZDRQTt8VW2rP5Dmi5buYQf+h4SOeBCSQezFbhnL3KraJh9rOQ7 iuMzuZ/SvTEqBmiLf9Ycmf2WhKAeXZP+7LrR7qXZpYsZrrGaex8TAUZR/ZWXFzfhmcmTWYXMsnK QfvKyfr8k9bt6wFE4QcaLs5+sb0EFGJABh5Xpwa7nWP3kwUnMTbYOVhmuMGcNZk+yymzZKImrAN pA/j+ng4
X-Authority-Analysis: v=2.4 cv=TtLmhCXh c=1 sm=1 tr=0 ts=68cabc1f cx=c_pps a=+fiFqpvOFuJZRCDDiTTDmA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=FOPVHIcnkjUA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=P-IC7800AAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=k1Nz3SOlCHzJLuWz7wEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: sVL-Eb20qOgTUsL_9fhgv9HuYCwjTAi9
X-Proofpoint-GUID: sVL-Eb20qOgTUsL_9fhgv9HuYCwjTAi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
X-Rspamd-Queue-Id: C957640AF2
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:185.132.182.106];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:52129, ipnet:185.132.182.0/24, country:US];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DNSWL_BLOCKED(0.00)[185.132.182.106:from,2603:10a6:10:1da:cafe::8d:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=1355adc703=arnaud.pouliquen@foss.st.com];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_VERP_SRS(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WJBMUKZRNEXXSTR27AEGVY7QNMPPE7ND
X-Message-ID-Hash: WJBMUKZRNEXXSTR27AEGVY7QNMPPE7ND
X-MailFrom: prvs=1355adc703=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WJBMUKZRNEXXSTR27AEGVY7QNMPPE7ND/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

DQoNCk9uIDkvMTcvMjUgMTI6MDgsIFN1bWl0IEdhcmcgd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDE2
LCAyMDI1IGF0IDAzOjI2OjQ3UE0gKzAyMDAsIEFybmF1ZCBQT1VMSVFVRU4gd3JvdGU6DQo+PiBI
ZWxsbyBTdW1pdCwNCj4+DQo+PiBPbiA5LzE2LzI1IDExOjE0LCBTdW1pdCBHYXJnIHdyb3RlOg0K
Pj4+IEhpIEFybmF1ZCwNCj4+Pg0KPj4+IEZpcnN0IG9mIGFsbCBhcG9sb2dpZXMgZm9yIHN1Y2gg
YSBsYXRlIHJldmlldyBjb21tZW50IGFzIHByZXZpb3VzbHkgSQ0KPj4+IHdhc24ndCBDQ2VkIG9y
IGludm9sdmVkIGluIHRoZSByZXZpZXcgb2YgdGhpcyBwYXRjaC1zZXQuIEluIGNhc2UgYW55IG9m
DQo+Pj4gbXkgZm9sbG93aW5nIGNvbW1lbnRzIGhhdmUgYmVlbiBkaXNjdXNzZWQgaW4gdGhlIHBh
c3QgdGhlbiBmZWVsIGZyZWUgdG8NCj4+PiBwb2ludCBtZSBhdCByZWxldmFudCBkaXNjdXNzaW9u
cy4NCj4+IE5vIHdvcnJpZXMsIHRoZXJlIGFyZSB0b28gbWFueSB2ZXJzaW9ucyBvZiB0aGlzIHNl
cmllcyB0byBmb2xsb3cgYWxsIHRoZQ0KPj4gcGFzdCBkaXNjdXNzaW9ucy4gSSBzb21ldGltZXMg
aGF2ZSBkaWZmaWN1bHR5IHJlbWVtYmVyaW5nIGFsbCB0aGUNCj4+IGRpc2N1c3Npb25zIG15c2Vs
ZiA6KQ0KPj4NCj4+PiBPbiBXZWQsIEp1biAyNSwgMjAyNSBhdCAxMTo0MDoyNkFNICswMjAwLCBB
cm5hdWQgUG91bGlxdWVuIHdyb3RlOg0KPj4+PiBUaGUgInN0LHN0bTMybXAxLW00LXRlZSIgY29t
cGF0aWJsZSBpcyB1dGlsaXplZCBpbiBhIHN5c3RlbSBjb25maWd1cmF0aW9uDQo+Pj4+IHdoZXJl
IHRoZSBDb3J0ZXgtTTQgZmlybXdhcmUgaXMgbG9hZGVkIGJ5IHRoZSBUcnVzdGVkIEV4ZWN1dGlv
biBFbnZpcm9ubWVudA0KPj4+PiAoVEVFKS4NCj4+PiBIYXZpbmcgYSBEVCBiYXNlZCBjb21wYXRp
YmxlIGZvciBhIFRFRSBzZXJ2aWNlIHRvIG1lIGp1c3QgZmVlbHMgbGlrZSBpdA0KPj4+IGlzIHJl
ZHVuZGFudCBoZXJlLiBJIGNhbiBzZWUgeW91IGhhdmUgYWxzbyB1c2VkIGEgVEVFIGJ1cyBiYXNl
ZCBkZXZpY2UNCj4+PiB0b28gYnV0IHRoYXQgaXMgbm90IGJlaW5nIHByb3Blcmx5IHVzZWQuIEkg
a25vdyBzdWJzeXN0ZW1zIGxpa2UNCj4+PiByZW1vdGVwcm9jLCBTQ01JIGFuZCBvdGhlcnMgaGVh
dmlseSByZWx5IG9uIERUIHRvIGhhcmRjb2RlIHByb3BlcnRpZXMgb2YNCj4+PiBzeXN0ZW0gZmly
bXdhcmUgd2hpY2ggYXJlIHJhdGhlciBiZXR0ZXIgdG8gYmUgZGlzY292ZXJlZCBkeW5hbWljYWxs
eS4NCj4+Pg0KPj4+IFNvIEkgaGF2ZSBhbiBvcGVuIHF1ZXN0aW9uIGZvciB5b3UgYW5kIHRoZSBy
ZW1vdGVwcm9jIHN1YnN5c3RlbQ0KPj4+IG1haW50YWluZXJzIGJlaW5nOg0KPj4+DQo+Pj4gSXMg
aXQgZmVhc2libGUgdG8gcmF0aGVyIGxldmVyYWdlIHRoZSBiZW5lZml0cyBvZiBhIGZ1bGx5IGRp
c2NvdmVyYWJsZQ0KPj4+IFRFRSBidXMgcmF0aGVyIHRoYW4gcmVseWluZyBvbiBwbGF0Zm9ybSBi
dXMvIERUIHRvIGhhcmRjb2RlIGZpcm13YXJlDQo+Pj4gcHJvcGVydGllcz8NCj4+IFRoZSBkaXNj
b3ZlcmFibGUgVEVFIGJ1cyBkb2VzIG5vdCB3b3JrcyBpZiB0aGUgcmVtb3RlcHJvYyBpcyBwcm9i
ZWQNCj4+IGJlZm9yZSB0aGUgT1AtVEVFIGJ1cywgaW4gc3VjaCBjYXNlwqAgbm8gcG9zc2liaWxp
dHkgdG8ga25vdyBpZiB0aGUgVEVFDQo+PiBUQSBpcyBub3QgeWV0IGF2YWlsYWJsZSBvciBub3Qg
YXZhaWxhYmxlIGF0IGFsbC4NCj4+IFRoaXMgcG9pbnQgaXMgbWVudGlvbmVkIGluIGEgY29tbWVu
dCBpbiBycHJvY190ZWVfcmVnaXN0ZXIoKS4NCg0KRm9yIHRoZSBkaXNjdXNzaW9uLCBpdOKAmXMg
cHJvYmFibHkgYmV0dGVyIGlmIEkgcHJvdmlkZSBtb3JlIGRldGFpbHMgb24gdGhlDQpjdXJyZW50
IE9QLVRFRSBpbXBsZW1lbnRhdGlvbiBhbmQgdGhlIHN0bTMybXAgcHJvY2Vzc29ycy4NCg0KMSkg
U1RNMzJNUCB0b3BvbG9neToNCiDCoCAtIFNUTTMyTVAxOiBvbmx5IGEgQ29ydGV4LU00IHJlbW90
ZSBwcm9jZXNzb3INCiDCoCAtwqAgU1RNMzJNUDJ4OiBhIENvcnRleC1NMzMgYW5kIGEgQ29ydGV4
LU0wIHJlbW90ZSBwcm9jZXNzb3JzDQogwqAgQXQgdGhpcyBzdGFnZSwgb25seSB0aGUgU1RNMzJN
UDE1IGlzIHVwc3RyZWFtZWQ7IHRoZSBTVE0zMk1QMjUgaXMgd2FpdGluZw0KIMKgIGZvciB0aGlz
IHNlcmllcyB0byBiZSBtZXJnZWQuDQoNCjIpIE9QLVRFRSBhcmNoaXRlY3R1cmU6DQotIEEgcGxh
dGZvcm0tYWdub3N0aWMgVHJ1c3RlZCBBcHBsaWNhdGlvbiAoVEEpIGhhbmRsZXMgdGhlIGJ1cyBz
ZXJ2aWNlLlsxXQ0KIMKgIFRoaXMgVEEgc3VwcG9ydHMgbWFuYWdpbmcgbXVsdGlwbGUgcmVtb3Rl
IHByb2Nlc3NvcnMuIEl0IGNhbiBiZSBlbWJlZGRlZA0KIMKgIHJlZ2FyZGxlc3Mgb2YgdGhlIG51
bWJlciBvZiByZW1vdGUgcHJvY2Vzc29ycyBtYW5hZ2VkIGluIE9QLVRFRS4NCiDCoCBUaGUgZGVj
aXNpb24gdG8gZW1iZWQgdGhpcyBzZXJ2aWNlIGlzIG1hZGUgYXQgYnVpbGQgdGltZSBiYXNlZCBv
biB0aGUNCiDCoCBwcmVzZW5jZSBvZiB0aGUgcmVtb3RlcHJvYyBkcml2ZXIsIHNvIGl0IGlzIG5v
dCBkZXZpY2UgdHJlZSBkZXBlbmRlbnQuDQogwqAgLSBTVE0zMk1QMTU6IFRBIGFjdGl2YXRlZCBv
bmx5IGlmIHRoZSByZW1vdGVwcm9jIE9QLVRFRSBkcml2ZXIgaXMgcHJvYmVkDQogwqAgLSBTVE0z
Mk1QMng6IFRBIGFsd2F5cyBhY3RpdmF0ZWQgYXMgdGhlIE9QLVRFRSByZW1vdGVwcm9jIGRyaXZl
ciBpcyANCmFsd2F5cyBwcm9iZWQNCg0KLSBBIHBzZXVkbyBUcnVzdGVkIEFwcGxpY2F0aW9uIGlt
cGxlbWVudHMgdGhlIHBsYXRmb3JtIHBvcnRpbmdbMl0sDQogwqAgcmVseWluZyBvbiByZWdpc3Rl
cmVkIHJlbW90ZXByb2MgcGxhdGZvcm0gZHJpdmVycy4NCg0KLSBQbGF0Zm9ybSBkcml2ZXIocykg
bWFuYWdlIHRoZSByZW1vdGUgcHJvY2Vzc29ycy5bM11bNF0NCiDCoCAtIElmIHJlbW90ZXByb2Mg
aXMgbWFuYWdlZCBieSBPUC1URUU6IG1hbmFnZXMgdGhlIHJlbW90ZXByb2MgbGlmZWN5Y2xlDQog
wqAgLSBJZiByZW1vdGVwcm9jIGlzIG1hbmFnZWQgYnkgTGludXg6IHByb3ZpZGVzIGFjY2VzcyBy
aWdodHMgdG8gTGludXggDQp0byBtYW5hZ2UNCiDCoCDCoCB0aGUgcmVtb3RlcHJvYw0KDQogwqAg
LSBTVE0zMk1QMTU6IGRyaXZlciBwcm9iZWQgb25seSBpZiB0aGUgcmVtb3RlcHJvYyBpcyBtYW5h
Z2VkIGluIE9QLVRFRQ0KIMKgIC0gU1RNMzJNUDJ4OiBkcml2ZXIgcHJvYmVkIGluIGJvdGggY2Fz
ZXMgZm9yIHRoZSBDb3J0ZXgtTTMzDQogwqDCoMKgIEZvciB0aGUgU1RNMzJNUDI1LCB0aGUgVEEg
aXMgYWx3YXlzIHByZXNlbnQgYW5kIHF1ZXJpZXMgdGhlIGRyaXZlciANCnRvIGNoZWNrDQogwqAg
wqAgaWYgaXQgc3VwcG9ydHMgc2VjdXJlIGxvYWRpbmcuDQoNCg0KWzFdIGh0dHBzOi8vZWxpeGly
LmJvb3RsaW4uY29tL29wLXRlZS80LjcuMC9zb3VyY2UvdGEvcmVtb3RlcHJvYw0KWzJdIA0KaHR0
cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vb3AtdGVlLzQuNy4wL3NvdXJjZS9jb3JlL3B0YS9zdG0z
Mm1wL3JlbW90ZXByb2NfcHRhLmMNClszXWh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL29wLXRl
ZS80LjcuMC9zb3VyY2UvY29yZS9kcml2ZXJzL3JlbW90ZXByb2Mvc3RtMzJfcmVtb3RlcHJvYy5j
DQpbNF1odHRwczovL2dpdGh1Yi5jb20vU1RNaWNyb2VsZWN0cm9uaWNzL29wdGVlX29zL2Jsb2Iv
NC4wLjAtc3RtMzJtcC9jb3JlL2RyaXZlcnMvcmVtb3RlcHJvYy9zdG0zMl9yZW1vdGVwcm9jLmMg
DQoNCj4gVGhlIHJlYXNvbiBoZXJlIGlzIHRoYXQgeW91IGFyZSBtaXhpbmcgcGxhdGZvcm0gYW5k
IFRFRSBidXMgZm9yIHJlbW90ZXByb2MNCj4gZHJpdmVyLiBGb3IgcHJvYmUsIHlvdSByZWx5IG9u
IHBsYXRmb3JtIGJ1cyBhbmQgdGhlbiB0cnkgdG8gbWlncmF0ZSB0bw0KPiBURUUgYnVzIHZpYSBy
cHJvY190ZWVfcmVnaXN0ZXIoKSBpcyB0aGUgcHJvYmxlbSBoZXJlLiBJbnN0ZWFkIHlvdSBzaG91
bGQNCj4gcmF0aGVyIHByb2JlIHJlbW90ZXByb2MgZGV2aWNlIG9uIFRFRSBidXMgZnJvbSB0aGUg
YmVnaW5uaW5nLg0KDQpUaGUgYXBwcm9hY2ggaXMgaW50ZXJlc3RpbmcsIGJ1dCBob3cgY2FuIHdl
IHJlbHkgb24gRGV2aWNlIFRyZWUgKERUKSBmb3INCmhhcmR3YXJlIGNvbmZpZ3VyYXRpb24gaW4g
dGhpcyBjYXNlPw0KQXQgYSBtaW5pbXVtLCBJIG5lZWQgdG8gZGVmaW5lIG1lbW9yeSByZWdpb25z
IGFuZCBtYWlsYm94ZXMuDQoNCiBGcm9tIG15IHBlcnNwZWN0aXZlLCBJIHdvdWxkIHN0aWxsIG5l
ZWQgYSBkcml2ZXIgcHJvYmVkIGJ5IERUIHRoYXQgDQpyZWdpc3RlcnMNCmEgZHJpdmVyIG9uIHRo
ZSBURUUgYnVzLiBUaGVyZWZvcmUsIEkgc3RpbGwgbmVlZCBhIG1lY2hhbmlzbSB0byBkZWNpZGUN
CndoZXRoZXIgdGhlIHJlbW90ZSBmaXJtd2FyZSBpcyBtYW5hZ2VkIGJ5IHRoZSBzZWN1cmUgb3Ig
bm9uLXNlY3VyZSBjb250ZXh0Lg0KDQpBbm90aGVyIGlzc3VlIHdvdWxkIGJlIHRvIGJlIGFibGUg
dG8gc2hhcmUgdGhlIHJlbW90ZXByb2MgVEVFIHNlcnZpY2UgDQpiZXR3ZWVuDQpzZXZlcmFsIHBs
YXRmb3JtIHJlbW90ZXByb2MgZHJpdmVycywgaW4gY2FzZSBvZiBtdWx0aSByZW1vdGUgcHJvY2Vz
c29yIA0Kc3VwcG9ydC4NCg0KPg0KPj4gVGhlbiwgaXQgaXMgbm90IG9ubHkgYSBmaXJtd2FyZSBw
cm9wZXJ0eSBpbiBvdXIgY2FzZS4gRGVwZW5kaW5nIG9uIHRoZQ0KPj4gY29tcGF0aWJsZSBzdHJp
bmcsIHdlIG1hbmFnZSB0aGUgaGFyZHdhcmUgZGlmZmVyZW50bHkuIFRoZSBzYW1lIGNvbXBhdGli
bGVzDQo+PiBhcmUgdXNlZCBpbiBib3RoIE9QLVRFRSBhbmQgTGludXguIEJhc2VkIG9uIHRoZSBj
b21wYXRpYmxlLCB3ZSBjYW4gYXNzaWduDQo+PiBtZW1vcmllcywgY2xvY2tzLCBhbmQgcmVzZXRz
IHRvIGVpdGhlciB0aGUgc2VjdXJlIG9yIG5vbi1zZWN1cmUgY29udGV4dC4NCj4+IFRoaXMgYXBw
cm9hY2ggaXMgaW1wbGVtZW50ZWQgb24gdGhlIFNUTTMyTVAxNSBhbmQgU1RNMzJNUDJ4IHBsYXRm
b3Jtcy4NCj4gWW91IHNob3VsZCBoYXZlIHJhdGhlciB1c2VkIHRoZSBEVCBwcm9wZXJ0eSAic2Vj
dXJlLXN0YXR1cyIgWzFdIHRvIHNheQ0KPiB0aGUgcmVtb3RlcHJvYyBkZXZpY2UgaXMgYmVpbmcg
bWFuYWdlZCBieSBPUC1URUUgaW5zdGVhZCBvZiBMaW51eC4gVGhlbg0KPiB0aGUgTGludXggZHJp
dmVyIHdpbGwgc29sZWx5IHJlbHkgb24gVEVFIGJ1cyB0byBoYXZlIE9QLVRFRSBtZWRpYXRlZA0K
PiByZW1vdGVwcm9jIGRldmljZS4NCj4NCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9kZXZpY2V0
cmVlLW9yZy9kdC1zY2hlbWEvYmxvYi80YjI4YmM3OWZkYzU1MmYzZTBiODcwZWYxMzYyYmI3MTE5
MjVmNGYzL2R0c2NoZW1hL3NjaGVtYXMvZHQtY29yZS55YW1sI0w1Mg0KDQpNeSBpc3N1ZSB3aXRo
IHRoaXMgcHJvcGVydHkgaXMgdGhhdCB0aGlzIHdvdWxkIGJyZWFrIHRoZSBjb21wYXRpYmlsaXR5
IHdpdGgNCmxlZ2FjeSBEVCB0aGF0IG9ubHkgc3VwcG9ydCBsb2FkaW5nIGJ5IExpbnV4DQpBcyBz
cGVjaWZpZWQgaW4gWzVdIDpJZiAic2VjdXJlLXN0YXR1cyIgaXMgbm90IHNwZWNpZmllZCBpdCBk
ZWZhdWx0cyB0byANCnRoZSBzYW1lIHZhbHVlIGFzICJzdGF0dXMiOyBbNV0gDQpodHRwczovL3d3
dy5rZXJuZWwub3JnL2RvYy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3Nl
Y3VyZS50eHQNCg0KPj4gTW9yZSBkZXRhaWxzIGFyZSBhdmFpbGFibGUgaW4gdGhlIFNUIFdJS0k6
DQo+PiBodHRwczovL3dpa2kuc3QuY29tL3N0bTMybXB1L3dpa2kvT1AtVEVFX3JlbW90ZXByb2Nf
ZnJhbWV3b3JrX292ZXJ2aWV3I0RldmljZV90cmVlX2NvbmZpZ3VyYXRpb24NCj4+IGh0dHBzOi8v
d2lraS5zdC5jb20vc3RtMzJtcHUvd2lraS9MaW51eF9yZW1vdGVwcm9jX2ZyYW1ld29ya19vdmVy
dmlldyNEZXZpY2VfdHJlZV9jb25maWd1cmF0aW9uDQo+Pg0KPj4+PiBGb3IgaW5zdGFuY2UsIHRo
aXMgY29tcGF0aWJsZSBpcyB1c2VkIGluIGJvdGggdGhlIExpbnV4IGFuZCBPUC1URUUgZGV2aWNl
DQo+Pj4+IHRyZWVzOg0KPj4+PiAtIEluIE9QLVRFRSwgYSBub2RlIGlzIGRlZmluZWQgaW4gdGhl
IGRldmljZSB0cmVlIHdpdGggdGhlDQo+Pj4+ICAgICAic3Qsc3RtMzJtcDEtbTQtdGVlIiBjb21w
YXRpYmxlIHRvIHN1cHBvcnQgc2lnbmVkIHJlbW90ZXByb2MgZmlybXdhcmUuDQo+Pj4+ICAgICBC
YXNlZCBvbiBEVCBwcm9wZXJ0aWVzLCB0aGUgT1AtVEVFIHJlbW90ZXByb2MgZnJhbWV3b3JrIGlz
IGluaXRpYXRlZCB0bw0KPj4+PiAgICAgZXhwb3NlIGEgdHJ1c3RlZCBhcHBsaWNhdGlvbiBzZXJ2
aWNlIHRvIGF1dGhlbnRpY2F0ZSBhbmQgbG9hZCB0aGUgcmVtb3RlDQo+Pj4+ICAgICBwcm9jZXNz
b3IgZmlybXdhcmUgcHJvdmlkZWQgYnkgdGhlIExpbnV4IHJlbW90ZXByb2MgZnJhbWV3b3JrLCBh
cyB3ZWxsDQo+Pj4+ICAgICBhcyB0byBzdGFydCBhbmQgc3RvcCB0aGUgcmVtb3RlIHByb2Nlc3Nv
ci4NCj4+Pj4gLSBJbiBMaW51eCwgd2hlbiB0aGUgY29tcGF0aWJpbGl0eSBpcyBzZXQsIHRoZSBD
b3J0ZXgtTSByZXNldHMgc2hvdWxkIG5vdA0KPj4+PiAgICAgYmUgZGVjbGFyZWQgaW4gdGhlIGRl
dmljZSB0cmVlLiBJbiBzdWNoIGEgY29uZmlndXJhdGlvbiwgdGhlIHJlc2V0IGlzDQo+Pj4+ICAg
ICBtYW5hZ2VkIGJ5IHRoZSBPUC1URUUgcmVtb3RlcHJvYyBkcml2ZXIgYW5kIGlzIG5vIGxvbmdl
ciBhY2Nlc3NpYmxlIGZyb20NCj4+Pj4gICAgIHRoZSBMaW51eCBrZXJuZWwuDQo+Pj4+DQo+Pj4+
IEFzc29jaWF0ZWQgd2l0aCB0aGlzIG5ldyBjb21wYXRpYmxlLCBhZGQgdGhlICJzdCxwcm9jLWlk
IiBwcm9wZXJ0eSB0bw0KPj4+PiBpZGVudGlmeSB0aGUgcmVtb3RlIHByb2Nlc3Nvci4gVGhpcyBJ
RCBpcyB1c2VkIHRvIGRlZmluZSBhIHVuaXF1ZSBJRCwNCj4+Pj4gY29tbW9uIGJldHdlZW4gTGlu
dXgsIFUtQm9vdCwgYW5kIE9QLVRFRSwgdG8gaWRlbnRpZnkgYSBjb3Byb2Nlc3Nvci4NCj4+PiBU
aGlzICJzdCxwcm9jLWlkIiBpcyBqdXN0IG9uZSBzdWNoIHByb3BlcnR5IHdoaWNoIGNhbiByYXRo
ZXIgYmUgZGlyZWN0bHkNCj4+PiBwcm9iZWQgZnJvbSB0aGUgVEVFL09QLVRFRSBzZXJ2aWNlIHJh
dGhlciB0aGFuIGhhcmRjb2RpbmcgaXQgaW4gRFQgaGVyZS4NCj4+IERvIHlvdSBtZWFuIGEgdG9w
b2xvZ3kgZGlzY292ZXJ5IG1lY2hhbmlzbSB0aHJvdWdoIHRoZSBURUUgcmVtb3RlcHJvYw0KPj4g
c2VydmljZT8NCj4+DQo+PiBGb3IgdGhlIFNUTTMyTVAxNSwgaXQgY291bGQgd29yayBzaW5jZSB3
ZSBoYXZlIG9ubHkgb25lIHJlbW90ZSBwcm9jZXNzb3IuDQo+PiBIb3dldmVyLCB0aGlzIGlzIG5v
dCB0aGUgY2FzZSBmb3IgdGhlIFNUTTMyTVAyNSwgd2hpY2ggZW1iZWRzIGJvdGggYQ0KPj4gQ29y
dGV4LU0zMyBhbmQgYSBDb3J0ZXgtTTAuDQo+IEkgcmF0aGVyIG1lYW4gaGVyZSB3aGljaGV2ZXIg
cHJvcGVydGllcyB5b3UgY2FuIGN1cnJlbnRseSBkaWNvdmVyaW5nIHZpYQ0KPiBEVCBjYW4gcmF0
aGVyIGJlIGRpc2NvdmVyZWQgYnkgaW52b2tlIGNvbW1hbmQgdGFraW5nIHByb3BlcnR5IG5hbWUg
YXMgaW5wdXQNCj4gYW5kIHZhbHVlIGFzIG91dHB1dC4NCg0KVGhhdCB3b3VsZCBtZWFucyBzZXJ2
aWNlcyB0byBnZXQgc3lzdGVtIHJlc291cmNlcyBzdWNoIGFzIG1lbW9yeSByZWdpb24NCm1haWxi
b3gsIHJpZ2h0Pw0KDQo+DQo+PiBDb3VsZCB5b3UgcGxlYXNlIGVsYWJvcmF0ZSBvbiBob3cgeW91
IHNlZSB0aGUgc3VwcG9ydCBvZiBtdWx0aXBsZSByZW1vdGUNCj4+IHByb2Nlc3NvcnMgd2l0aG91
dCB1c2luZyBhbiBoYXJkY29kZWQgaWRlbnRpZmllcj8NCj4gQnkgbXVsdGlwbGUgcmVtb3RlIHBy
b2Nlc3NvcnMsIGRvIHlvdSBtZWFuIHRoZXJlIGNhbiBiZSBtdWx0aXBsZQ0KPiBjb21iaW5hdGlv
bnMgb2Ygd2hpY2ggcmVtb3RlIHByb2Nlc3NvciBnZXRzIG1hbmFnZWQgdmlhIE9QLVRFRSBvciBu
b3Q/DQoNCk9uIHN0bTMybXAyNSB3ZSBoYXZlIDIgcmVtb3RlIHByb2Nlc3NvcnMgYSBjb3J0ZXgt
TTMzIGFuZCBhIGNvcnRleC1NMA0KV2Ugc2hvdWxkIGJlIGFibGUgdG8gbWFuYWdlIHRoZW0gdXNp
bmcgdGhlIHByb2NfaWRBbm90aGVyIHBvaW50IGlzIHRoYXQgDQpXZSBzaG91bGQgYWxsb3cgYW4g
b3RoZXIgU2VjdXJlIE9TIGNvdWxkIGltcGxlbWVudCB0aGUgVEVFIHJlbW90ZXByb2MgDQpzZXJ2
aWNlIG1hbmFnaW5nIHRoZSByZW1vdGUgcHJvY2Vzc29ycyB3aXRoIGRpZmZlcmVudCBwcm9jX2lk
IHZhbHVlcywgdG8gDQphdm9pZCB0byBzcGVjaWZ5IHNvbWV3aGVyZSBhbiB1bmlxdWUgcHJvYyBJ
RCBwZXIgcmVtb3RlIHByb2Nlc3Nvci4NCg0KPj4+IEkgdGhpbmsgdGhlIHNhbWUgd2lsbCBhcHBs
eSB0byBvdGhlciBwcm9wZXJ0aWVzIGFzIHdlbGwuDQo+PiBDb3VsZCB5b3UgZGV0YWlscyB0aGUg
b3RoZXIgcHJvcGVydGllcyB5b3UgaGF2ZSBpbiBtaW5kPw0KPiBJIHRoaW5rIHRoZSBtZW1vcnkg
cmVnaW9ucyBpbmNsdWRpbmcgdGhlIHJlc291cmNlIHRhYmxlIGNhbiBhbHNvIGJlDQo+IHByb2Jl
ZCBkaXJlY3RseSBmcm9tIHRoZSBURUUgc2VydmljZSB0b28uIElzIHRoZXJlIGFueSBvdGhlciBE
VCBwcm9wZXJ0eQ0KPiB5b3UgcmVseSB1cG9uIHdoZW4gcmVtb3RlcHJvYyBpcyBtYW5hZ2VkIHZp
YSBPUC1URUU/DQoNClRoZSBtZW1vcnkgcmVnaW9ucyB0aGF0IGluY2x1ZGUgdGhlIHJlc291cmNl
IHRhYmxlIGFyZSBhbHJlYWR5IGRlY2xhcmVkDQppbiBPUC1URUUuIFRoZSBtZW1vcnkgcmVnaW9u
cyBkZWZpbmVkIGluIHRoZSBMaW51eCBkZXZpY2UgdHJlZSBhcmUgZm9yDQpSUE1zZyAoSVBDKS4g
VGhlc2UgbWVtb3JpZXMgYXJlIHJlZ2lzdGVyZWQgYnkgdGhlIExpbnV4IHJlbW90ZXByb2MgZHJp
dmVyDQppbiB0aGUgTGludXggcnByb2MgY29yZS4NCg0KVGhhbmtzLA0KQXJuYXVkDQoNCj4NCj4g
LVN1bWl0DQoNCg==
