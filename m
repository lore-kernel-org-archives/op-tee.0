Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6889DD29DF2
	for <op-tee@archiver.kernel.org>; Tue, 13 Jan 2026 09:21:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9D40741A3E
	for <op-tee@archiver.kernel.org>; Tue, 13 Jan 2026 09:21:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=kMHLlA99;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1678641A3E
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Jan 2026 09:20:57 +0000 (UTC)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D9BIUx1650996;
	Tue, 13 Jan 2026 10:20:40 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4bkcs89b24-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 10:20:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdEbPwYAmbw5QhyIPKpCzheV1yCQehaSXV3AGvOi509kgR9n6aPjRDDg+tN+SXNjyYNI/ZDPY46jMbEkw13UYidYKNwSUIqDhIBSXHtZIXIDM8pZYL/HvKl4SGE1Ry2zyYhmbILo0g8kZLcMxthpyZuCRZL4swUDIQUZUahBIGPsGVatm4qok5Cst0pwIXVuZWBIQ1BGVXmpMedVIbgRdWjBta0/WqIY/FLH0UqliLdZuLAxJ5knky4M7ICLIwVsdVBuVkuolid3RqlX7mzElTIbhRJs1uAr5HNZOewuzTj/jKXi315t0eTSag+Ws4qIkJl3krGb1r4nMiHvcKbU/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86jfJbC1ywkJLlYaHLbSBCBZAT+By/i5iEejptSElVM=;
 b=r5sfN+IrmCCxdV6zc/5W59BQ68UOFdi6A1XO2ErostqchwV3E2/bz+zkQxfgOSmReqLvX/0R+tu4p1S4pY/HM2azcQOds9+knh1XWlefXLE76Kp69oGb6w9dMC1L5KVs/dJRRqlvOA8830IHGo+dCEbVv/YY4C+BHliOIz1+r4X3a02AFCquB9OIiyPgaSNvapSJe/X2BrW7n1lNQCL74gFGqefQy7ndqkgnMYGfDiZ52WZgNVBulTKCk84pV1Jl53fLtha2BoTvAoiwk+SYsDNOh8KDX1pbwZdDLY+gxfksX1fZm1Ml9uEw8ZRoVicsPjwIUxb5st+T1U6WcuZ8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86jfJbC1ywkJLlYaHLbSBCBZAT+By/i5iEejptSElVM=;
 b=kMHLlA99LOkLSPj10FHSkaCBwf+SD91nOo9sR5RJhMwbqE9/ftlykwHiFKbJkWR6+ukqmQssWwo46E83wL4Il5sAo6p2sCCP6M7vCEdQ3NAYLxAKi2XZHroEQ2ZX5avO0wUBRtOsU0Zcyps/+rbP41YAwMQrSWQLAtKe9TNhNLYAKFQnXIVaRqxklSSvJkutFfuHswSVbmWRnbh4QjRTMzWN79W0DZQCjGPFh6ZkZTueM8pscQgaHEfAoWjdHFV8Kp6SJAdVAzX6g13jFZdICf+4+yKEU+dY00diStT3vruEzFyRwYgpbQAM+V0zCEloELaB+Tga5z//51AHJSW1YA==
Received: from DU6P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::22)
 by GVXPR10MB5864.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 09:20:36 +0000
Received: from DB1PEPF00039231.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::d4) by DU6P191CA0007.outlook.office365.com
 (2603:10a6:10:540::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 09:20:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF00039231.mail.protection.outlook.com (10.167.8.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 09:20:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 13 Jan
 2026 10:21:51 +0100
Received: from [10.252.31.60] (10.252.31.60) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 13 Jan
 2026 10:20:33 +0100
Message-ID: <49f1808d-1e08-4f47-ac3a-5f2274086060@foss.st.com>
Date: Tue, 13 Jan 2026 10:20:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 1/6] dt-bindings: firmware: Add TEE remoteproc service
 binding
To: Sumit Garg <sumit.garg@kernel.org>, Rob Herring <robh@kernel.org>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
 <20251229232530.GA2753472-robh@kernel.org> <aVOzHWmlJ-eneS-2@sumit-xelite>
 <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
 <aVtqITUxy--E8HJt@sumit-xelite>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <aVtqITUxy--E8HJt@sumit-xelite>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.252.31.60]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00039231:EE_|GVXPR10MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5ac73f-fd2f-462b-ff85-08de52850287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RytMcTdVRVNnVW5wWGg2RkxBUmZsNk9PRWhVYUxSUDR4Yjg3bldsckRyRDJ3?=
 =?utf-8?B?S3kzRVJnSWh2VDBlZytwMEgzTU5LQW1nZFcwMS9WZ25nU1lSYndqS3BoVWl0?=
 =?utf-8?B?N0lyWFVVNDF0ZURzM3o0K3BVR1FkWE9xNVM1QmhIK0Uwak9oUmprV09zcmN4?=
 =?utf-8?B?UWVxWlFxTFFJM0NYZFVTZ0pIdmw3eGJTdWZldUIweE0ycTZESmhTcFQ0VHE5?=
 =?utf-8?B?Rk5jV2pPRWRSUFE5bG9TRlNmZ1ZvYWliSkxyUTBTQURUekRQUGJMbXVFRmxa?=
 =?utf-8?B?ODF1ZFNEM09hblJwbHdubkkrSHZsZVNyNk5KRFU1ZEVHdmNXb1RSYVpxWXBW?=
 =?utf-8?B?eCtwRVp1MnlOQWVPY3UwZUJuT0FYQlZ2Q3MzSW02WFlXZ3hLZ05reWVZSUF3?=
 =?utf-8?B?YWpNR240ZGJ1d3FlSnI0V0tuQ1puaGNMRXkveTdTblBabmRuNTIwa1kySzI1?=
 =?utf-8?B?TitqWFBCRFREYnV6bksxNEwyUUFiTUhRSzhzWlppUHNIOEtQbWxtYTBwemFh?=
 =?utf-8?B?UmRid0dyU2xzVzVzaXNJWkE1OXlidTEvMlFLb044S2hKZ0JWVmhobFNBZGJn?=
 =?utf-8?B?VFpWS0ZENTl3SkV2dmVXUythVnp1cjNpczVUdGE1ZHpaQ3BOOC9kYWx6NDJU?=
 =?utf-8?B?SUdSVys5SmFGSjFGcFNTaG1XMWZGVVlYYXF6T3pJWnRlZjZ3MVRtcG9VRWla?=
 =?utf-8?B?bmlWd2ZpVzg2UklRVTdKRkF4QVBuZjEvZitKNjkxNExXeUpnVnVIUUY3Uklv?=
 =?utf-8?B?aklJMGZwS2QyNTBsYkovU1RaaldXOXIrMURIc3lKZS9rQ3IzeDI5OEV3ZWRN?=
 =?utf-8?B?MXFZQUtUcWwxWm1QMDBIL1RFZkFHb0Q0M0ZaaG8wSkE4cHo5b282M3ZwanRh?=
 =?utf-8?B?cFZOMXg2Qko5YllSTnRJajExenBqYVFSYmxmV3VoNlpNZSt6SWV5eTBWVGt2?=
 =?utf-8?B?NlVUaE8yWVpodjJnVllXazdIbmNLc2xYMHV4dzQ4R2tFM0szeXB6d0RXeVo5?=
 =?utf-8?B?azZNay9wVVdBOTR0SjJ4cnhRd0M2a3pxOXhpQW1nRE91dHhXL0tYVFpSK1dh?=
 =?utf-8?B?TzFIZlVxNVU2ZUNyWmYrWWh0N3BLeVhKazlhYzV2ZWpkenJsVmJaL0t6ajdN?=
 =?utf-8?B?MWV0V2ZHU3pQK0lpUEh5YzhVNWE2VmxsTSsxMUpXK1FHMmJ3M05vTXBYQVdm?=
 =?utf-8?B?ZDJXeUFBNGJpTGpKNndrMXNVQkxXbDZVenVyMFZRVGlETXZxZmg5RHRnTjJp?=
 =?utf-8?B?V2cyUWJuZzFra25tYlFOaVB2M2NGVVpWc2laa2d3dWZkREhkcFB1eUhiUXFm?=
 =?utf-8?B?NGZuU2RJVGJxNUhCRVJHcDZlMzZ3S0dCZzlXTmZSRVl5eVd5OFdFUjA0dkFG?=
 =?utf-8?B?MXlwYUdPRmJUM0QxVlJQM2VIaEZXRVJEUGh0T0hqNW9TL0kvb015OUV5MUx2?=
 =?utf-8?B?ejdvVkJsRHVXWEtDamlVbFYyZnBJVkh6ZzljOTJIQXErNTNTR3F3endCNnRs?=
 =?utf-8?B?cFdaMGlpZTR6VFpySC9tMGdFcHNTeFVwVmNUSGtnTlpaRDM2WCtoL255TEpY?=
 =?utf-8?B?UXRjUmhlTWRVWjdpYUR4Um1tWWYrVEwvbGxlNURpQ2IrUDJmYXFFdjB2ZjFQ?=
 =?utf-8?B?TkowYzk3RkNlQ3Q0eURsK3VDelhoS09VNTBmRjVZSGltbUNyMCtTRjM0eHJJ?=
 =?utf-8?B?cUpwVFRGVlZ2QzNpNGU1TVQxMCtJZzBXMHdPaVo5L3BtV3lNQmt4QnhMY05X?=
 =?utf-8?B?VVpBOVZ2U084UlZEcHRqUTRYWVQ3MkNFeDg4YWxHSVB6WmJ5MzhDYUpYK3BJ?=
 =?utf-8?B?ZnBuaXNlbWwrN2dQdzgzc3RJM0pIU2lpeTFsRGRLNzJjRmJibFpqRXBwdTU0?=
 =?utf-8?B?aHlxQ2x0dE4reWV4UUVRM3pUWlJ5NDdCTUJFeG9EM3pQczY2NllzNytubHFx?=
 =?utf-8?B?T08zYUtMU3FvRUV4YU0vOW1UQjVmOE10bElmT1R2ZGI3RElxVjZFdmpGbEwz?=
 =?utf-8?B?TkZwQ2ZiODM1Mlp6cnJtalVRamtNcDRLYlBVczNsdThQbEcwUGZSS1VQZUN5?=
 =?utf-8?B?SzRaTGc0Rzk0bm8zL1FqS2NBcmhqSHgyV1E1Y2tudTJ4emJ6aUVNRnQwQmUr?=
 =?utf-8?Q?NpDw=3D?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 09:20:35.8660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5ac73f-fd2f-462b-ff85-08de52850287
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF00039231.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5864
X-Authority-Analysis: v=2.4 cv=XfSEDY55 c=1 sm=1 tr=0 ts=69660e67 cx=c_pps
 a=zENiTB/zEOiFyifeSt50yg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=i0FVImxyn9gA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8
 a=xsx64BSX4TkU_5fudAEA:9 a=Hj5wB2MbPpAxq7y1:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: 7PlfaP0p0NewNUEWHksE_lbTOhor3FXu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA3NyBTYWx0ZWRfX91yrjRjOujAL
 BxwbbC8rmt4rL5vyKTAIhr4vHTYfsOviU+fm6WFisLglHG3I/7jklSIs4oRbe1vKl8xx5mVwpqJ
 t7nhpW3ux5X8naNPCAChxSTNsPBfXbmTOr1N0/BcZ7ussHjOIvpPq7D06XdfPDwsyyS0Dz5egxs
 vHTG0Q+bdvk05KHk/g94cnOlabhIxpD/YPLeDAuEPJwWXEAfmASrTu61MJcVmW8ejYUBOjbykK+
 dqJLuKDDRla0FiZzHy+azsnRC1PBucNo3oA4ZWIjSPcNziwrGEhdyJW60uctO7L34+gcC7P4nYx
 32MixUn0fyC2IKMhu3xMjb1EDNZJIxcyMmO2c8bPBEEIZxOvNc9VAFKFtAgqSeW1PJJwwDUR3in
 gG6Z4x0aVJB1JHRN1rkh61mYUs7PIx9qikEf+V0YtCG60lQDGVFTYhB6bURUu2dpJvB1ZsMHB+o
 J0XoZLK/l2TvNewPELg==
X-Proofpoint-ORIG-GUID: 7PlfaP0p0NewNUEWHksE_lbTOhor3FXu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.40 / 15.00];
	URL_BACKSLASH_PATH(4.00)[0.0.0.0];
	URL_NUMERIC_IP(3.00)[0.0.0.0];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	RCVD_IN_DNSWL_LOW(-0.10)[91.207.212.93:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=5473716cca=arnaud.pouliquen@foss.st.com];
	ASN(0.00)[asn:52129, ipnet:91.207.212.0/23, country:US];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[dt];
	FORGED_SENDER_VERP_SRS(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1678641A3E
X-Spamd-Bar: +++
Message-ID-Hash: 7A5LXE5CRC25KTNRPBV6ORKIA6JGRRMT
X-Message-ID-Hash: 7A5LXE5CRC25KTNRPBV6ORKIA6JGRRMT
X-MailFrom: prvs=5473716cca=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7A5LXE5CRC25KTNRPBV6ORKIA6JGRRMT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
X-Spam: Yes

SGVsbG8sDQoNCk9uIDEvNS8yNiAwODozNywgU3VtaXQgR2FyZyB3cm90ZToNCj4gT24gRnJpLCBK
YW4gMDIsIDIwMjYgYXQgMDQ6MTc6MjdQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+PiBP
biBUdWUsIERlYyAzMCwgMjAyNSBhdCA1OjEw4oCvQU0gU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4+Pg0KPj4+IE9uIE1vbiwgRGVjIDI5LCAyMDI1IGF0IDA1OjI1
OjMwUE0gLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPj4+PiBPbiBXZWQsIERlYyAxNywgMjAy
NSBhdCAwNDozOToxMlBNICswMTAwLCBBcm5hdWQgUG91bGlxdWVuIHdyb3RlOg0KPj4+Pj4gQWRk
IGEgZGV2aWNlIHRyZWUgYmluZGluZyBmb3IgdGhlIFRFRS1iYXNlZCByZW1vdGUgcHJvY2Vzc29y
IGNvbnRyb2wNCj4+Pj4+IHNlcnZpY2UgaW1wbGVtZW50ZWQgYXMgYW4gT1AtVEVFIFRydXN0ZWQg
QXBwbGljYXRpb24gaWRlbnRpZmllZCBieQ0KPj4+Pj4gVVVJRCA4MGE0YzI3NS0wYTQ3LTQ5MDUt
ODI4NS0xNDg2YTk3NzFhMDguDQo+Pj4+Pg0KPj4+Pj4gVGhlIFRFRSBzZXJ2aWNlIG5vZGUgaXMg
YSBjaGlsZCBvZiB0aGUgImxpbmFybyxvcHRlZS10eiIgZmlybXdhcmUgbm9kZSBhbmQNCj4+Pj4+
IGFjdHMgYXMgYSBjb250YWluZXIgZm9yIHJlbW90ZXByb2MgZGV2aWNlcyB0aGF0IGFyZSBjb250
cm9sbGVkIHZpYSBURUUuDQo+Pj4+DQo+Pj4+IElzIHRoaXMgZ2VuZXJpYyBmb3IgYW55IHJlbW90
ZXByb2MgZGV2aWNlIG9yIGp1c3QgU1QncyByZW1vdGVwcm9jLiBMb29rcw0KPj4+PiBsaWtlIHRo
ZSBsYXR0ZXIgdG8gbWUuDQo+Pj4NCj4+PiBUaGF0J3MgdHJ1ZSwgdGhlIERUIGRlc2NyaXB0aW9u
IG9mIHRoZSByZW1vdGVwcm9jIHN1Ym5vZGUgaXMgdmVyeQ0KPj4+IHNwZWNpZmljIHRvIHRoZSB2
ZW5kb3Igd2hpY2ggaW4gdGhpcyBjYXNlIGlzIFNULg0KPj4+DQo+Pj4+DQo+Pj4+PiBJbiBhZGRp
dGlvbiwgdGhlICJsaW5hcm8sb3B0ZWUtdHoiIGJpbmRpbmcgaXMgdXBkYXRlZCB0byBzcGVjaWZ5
IHRoZQ0KPj4+Pj4gJyNhZGRyZXNzLWNlbGxzJyBhbmQgJyNzaXplLWNlbGxzJyB2YWx1ZXMgdXNl
ZCBmb3IgY2hpbGQgVEVFIHNlcnZpY2UNCj4+Pj4+IG5vZGVzLg0KPj4+Pg0KPj4+PiBJJ20gcHJl
dHR5IHN1cmUgSSBhbHJlYWR5IHJlamVjdGVkIHBlciBzZXJ2aWNlL2FwcCBjaGlsZCBub2RlcyBm
b3INCj4+Pj4gT1AtVEVFIHdoZW4gaXRzIGJpbmRpbmcgd2FzIHN1Ym1pdHRlZC4NCj4+Pg0KPj4+
IFRoYXQgd2FzIHRoZSByZWFzb24gdG8gaGF2ZSBkaXNjb3ZlcmFibGUgVEVFIGJ1cyBpbiBmaXJz
dCBwbGFjZSBhbmQgSQ0KPj4+IGhhdmUgYmVlbiBtb3RpdmF0aW5nIHBlb3BsZSB0byBkeW5hbWlj
YWxseSBkaXNjb3ZlciBmaXJtd2FyZSBwcm9wZXJ0aWVzDQo+Pj4gcmF0aGVyIHRoYW4gaGFyZGNv
ZGluZyBpbiB0aGUgRFQuDQo+Pj4NCj4+Pj4gSWYgd2UgZG8gbmVlZCBzb21ldGhpbmcgaW4gRFQN
Cj4+Pj4gdG8gZGVmaW5lIHNvbWUgcmVzb3VyY2VzLCB0aGVuIGNhbid0IHdlIGhhdmUgc29tZSBz
b3J0IG9mDQo+Pj4+IHN0YW5kYXJkL2NvbW1vbiBjb21tdW5pY2F0aW9ucyBjaGFubmVsPyBJIGRv
bid0IGNhcmUgdG8gc2VlIHNvbWUgc29ydCBvZg0KPj4+PiBmcmVlLWZvci1hbGwgd2hlcmUgd2Ug
aGF2ZSBldmVyeSB2ZW5kb3IgZG9pbmcgdGhlaXIgb3duIHRoaW5nLiBPUC1URUUNCj4+Pj4gbmVl
ZHMgdG8gc3RhbmRhcml6ZSB0aGlzLg0KPj4+DQo+Pj4gSSBzdXBwb3NlIHRoaXMgcmVxdWlyZXMg
YSB3aWRlciBzY29wZSB3b3JrIGFzIHlvdSBjYW4gc2VlIHRoZSBEVCByZXNvdXJjZQ0KPj4+IGRl
cGVuZGVuY2UgZnJvbSBoZXJlIFsxXS4gQnkgc3RhbmRhcmRpemUgY29tbXVuaWNhdGlvbiBjaGFu
bmVsLCBkbyB5b3UNCj4+PiBtZWFuIHRvIHNheSBpZiBhZGRpbmcgYW4gYWx0ZXJuYXRpdmUgYmFj
a2VuZCB0byBmd25vZGUgZm9yIFRFRSBpbg0KPj4+IHBhcmFsbGVsIHRvIERULCBBQ1BJIG9yIHN3
bm9kZSBpcyB0aGUgd2F5IHRvIGdvIGZvciBkaXNjb3ZlcmluZyBmdw0KPj4+IHByb3BlcnRpZXM/
DQo+Pg0KPj4gTm8sIG5vdCBhdCBhbGwuDQo+Pg0KPj4+IE9yIGRvIHlvdSBoYXZlIGFueSBvdGhl
ciBzdWdnZXN0aW9uIGhlcmU/DQo+Pg0KPj4gV2hhdCBJIG1lYW4gaXMgd2h5IGRvZXNuJ3QgdGhl
IFRFRSBkZWZpbmUgdGhlIGNvbW11bmljYXRpb24gY2hhbm5lbA0KPj4gKG1haWxib3grc2htZW0g
YW5kIG5vdGlmaWNhdGlvbiBpbnRlcnJ1cHQpIHJhdGhlciB0aGFuIGVhY2ggVEVFIGFwcD8NCj4g
DQo+IFRoZSBzeW5jaHJvbm91cyBjb21tdW5pY2F0aW9uIGNoYW5uZWwgaXMgYWxyZWFkeSB0aGVy
ZSBmb3IgZWFjaCBURUUgYXBwDQo+IGJhc2VkIG9uIChpbnZva2UgY29tbWFuZHMgKyBURUUgc2hh
cmVkIG1lbW9yeSkuIE9QLVRFRSBkb2VzIHN1cHBvcnQNCj4gbm90aWZpY2F0aW9uIGludGVycnVw
dHMgdG9vIGJ1dCB0aG9zZSBoYXZlbid0IGJlZW4gZXhwb3NlZCB0byBURUUgY2xpZW50DQo+IGRy
aXZlcnMgeWV0LiBJIHN1cHBvc2UgdGhpcyByZW1vdGVwcm9jIHVzZS1jYXNlIGNhbiBiZSBhIGdv
b2QgZXhhbXBsZSB0bw0KPiBleHBvc2UgdGhhdCBhcyBhIGdlbmVyaWMgVEVFIG5vdGlmaWNhdGlv
biBpbnRlcmZhY2UgdG9vLg0KDQpJbiB0aGUgU1RNMzJNUCBzZXJpZXMsIHRoZSBtYWlsYm94ZXMg
YW5kIHNoYXJlZCBSQU0gYXJlIHVzZWQgZm9yIFJQTXNnIA0KY29tbXVuaWNhdGlvbiBiZXR3ZWVu
IExpbnV4IGFuZCB0aGUgcmVtb3RlIHByb2Nlc3Nvci4gTXkgY29uY2VybiBpcyB0aGF0IA0KdXNp
bmcgbm90aWZpY2F0aW9uIGluIE9QLVRFRSBjb3VsZCBpbXBhY3QgcGVyZm9ybWFuY2UgYnkgaW50
cm9kdWNpbmcgDQpsYXRlbmN5LiBBZGRpdGlvbmFsbHksIHRoaXMgbWlnaHQgcmVxdWlyZSBhIERN
QSBhbGxvY2F0b3IgaW4gT1AtVEVFIHRvIA0KbWFuYWdlIHRoZSBzaGFyZWQgbWVtb3J5LiBPbmUg
UlBNc2cgdmlydGlvIHJlcXVpcmVzIHRoZSBkZWNsYXJhdGlvbiBvZiANCmF0IGxlYXN0IHRocmVl
IGNhcnZlb3V0cy4gTWFuYWdpbmcgdGhlc2UgYXMgbWVtb3J5IHJlZ2lvbnMgaW4gT1AtVEVFIA0K
d291bGQgYmUgY29tcGxleCAoZHVlIHRvIGxpbWl0ZWQgbnVtYmVyIG9mIG1lbW9yeSBhcmVhIGRl
Y2xhcmF0aW9uIG9uIA0KU1RNMzJNUDIpLg0KPiANCj4+DQo+PiBNb3JlIGdlbmVyYWxseSwgaXMg
aGF2aW5nIFRFRSBhcHBzIGRlcGVuZGluZyBvbiByYW5kb20gRFQgcmVzb3VyY2VzDQo+PiByZWFs
bHkgYSBib3ggd2Ugd2FudCB0byBvcGVuPyBJcyB0aGUgbmV4dCB0aGluZyBnb2luZyB0byBiZSBh
IFRFRQ0KPj4gY2xvY2svcmVzZXQvZ3Bpby9wb3dlciBwcm92aWRlcj8gV2hlcmUgZG8gd2UgZHJh
dyB0aGUgbGluZT8NCj4gDQo+IFRoaXMgaXMgcmVhbGx5IGEgaGFyZCBsaW5lIHRvIGRyYXcgc2lu
Y2Ugc2lsaWNvbi9PRU0gdmVuZG9ycyBiYXNlZCBvbiB0aGVpcg0KPiBoYXJkd2FyZSBzZWN1cml0
eSBhcmNoaXRlY3R1cmUgcGFydGl0aW9uIHZhcmlvdXMgcmVzb3VyY2VzIGFtb25nIFRFRSBhbmQN
Cj4gdGhlIExpbnV4IHdvcmxkLiBBbmQgb25lIGdlbmVyYWwgcHJpbmNpcGxlIHdlIHRyeSB0byBm
b2xsb3cgZm9yIHRoZSBURUUNCj4gaXMgdG8ga2VlcCBpdCdzIFRydXN0ZWQgQ29tcHV0aW5nIEJh
c2UgKFRDQikgdG8gYSBtaW5pbWFsIHRvby4NCj4gDQo+IElNSE8sIGlmIHRoZSB0aHJlYXQgbW9k
ZWwgaXMgd2VsbCB1bmRlcnN0b29kIHRoZW4gd2Ugc2hvdWxkIGFsbG93IGZvcg0KPiB0aGlzIGhl
dHJvZ2Vub3VzIHBhcnRpdGlvbmluZyBvZiBzeXN0ZW0gcmVzb3VyY2VzLg0KDQpIZXJlIGFyZSBz
b21lIGFkZGl0aW9uYWwgcmVzb3VyY2VzIHdlIG5lZWQgdG8gbWFuYWdlIHRoZSByZW1vdGUgDQpw
cm9jZXNzb3IsIHdoaWNoIHNlZW0gY29tcGxleCB0byBoYW5kbGUgd2l0aG91dCBEZXZpY2UgVHJl
ZSAoRFQpOg0KDQotIENsb2NrczogT24gU1RNMzJNUCwgd2UgbWFuYWdlIGNsb2NrcyB0aHJvdWdo
IHRoZSBPUC1URUUgU0NNSSBzZXJ2aWNlDQogICBbMV0uIFRoZSBTQ01JIE9QLVRFRSBjbG9jay9y
ZXNldCBzZXJ2aWNlIGFscmVhZHkgZXhpc3RzIGFuZCBzaG91bGQgYmUNCiAgIHJldXNlZC4NCi0g
UG93ZXIgZG9tYWlucw0KLSBSZW1vdGVwcm9jIFdhdGNoZG9nIGludGVycnVwdDogQ2Fubm90IGJl
IGNhdWdodCBieSBPUC1URUUgb24NCiAgIHN0bTMybXAxNS4NCi0gR3JhY2VmdWwgc2h1dGRvd24g
b2YgdGhlIHJlbW90ZSBwcm9jZXNzb3I6IFRoaXMgaW52b2x2ZXMgc2VuZGluZyBhDQogICBtYWls
Ym94IG5vdGlmaWNhdGlvbiB0byByZXF1ZXN0IHNodXRkb3duIGFuZCB3YWl0aW5nIHVwIHRvIDUw
MCBtcyBmb3INCiAgIHRoZSByZW1vdGVwcm9jIHRvIGRlaW5pdGlhbGl6ZSBpdHMgcmVzb3VyY2Vz
LiBXYWl0aW5nIHRoaXMgbG9uZyBpbiB0aGUNCiAgIHNlY3VyZSBjb250ZXh0IHNlZW1zIGluZWZm
aWNpZW50Lg0KLSBjb21wYXRpYmlsaXR5IHdpdGggc29tZSBjb21pbmcgSVBDIG1lY2hhbmlzbXM6
IFN1Y2ggYXMgcnBtc2dfSTJDIG9yDQogICB2aXJ0aW8tbXNnIG1pZ2h0IHJlcXVpcmUgcmVtb3Rl
cHJvYyBzdWJub2RlIGRlc2NyaXB0aW9ucyBpbiB0aGUNCiAgIGZ1dHVyZS4NCg0KSWYgdGhlIHBy
b3Bvc2VkIHRvcG9sb2d5IGRvZXMgbm90IGdhaW4gY29uc2Vuc3VzLCB3aGF0IGFib3V0IGFuIA0K
YWx0ZXJuYXRpdmUgYXBwcm9hY2ggdGhhdCBtYW5hZ2VzIHRoZSByZW1vdGVwcm9jIFRFRSBzaW1p
bGFybHkgdG8gU0NNSSwgDQpieSBpbnRyb2R1Y2luZyBhIHJlbW90ZXByb2MtYmFja2VuZCB3aXRo
IHRoZSBwcm9jIElEIGFzIGEgcGFyYW1ldGVyPw0KDQoNCiZmaXJtd2FyZSB7DQogICAgIG9wdGVl
OiBvcHRlZSB7DQogICAgICAgICBjb21wYXRpYmxlID0gImxpbmFybyxvcHRlZS10eiI7DQogICAg
ICAgICBtZXRob2QgPSAic21jIjsNCiAgICAgICAgIHNwcm9jOiBzcHJvYyB7DQogICAgICAgICAg
ICAgY29tcGF0aWJsZSA9ICI4MGE0YzI3NS0wYTQ3LTQ5MDUtODI4NS0xNDg2YTk3NzFhMDgiOw0K
ICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCSAgICAjc2l6ZS1jZWxscyA9IDww
PjsNCiAgICAgICAgIH07DQogICAgIH07DQp9Ow0KDQpycHJvYzE6IG0zM0AwIHsNCiAgIFsuLi5d
DQoNCiAgIHJlbW90ZXByb2MtYmFja2VuZCA9IDwgJnNwcm9jIDA+DQp9Ow0KDQoNCnJwcm9jMjog
bTBAMCB7DQogICBbLi4uXQ0KDQogICByZW1vdGVwcm9jLWJhY2tlbmQgPSA8ICZzcHJvYyAxPg0K
fTsNCg0KDQpbMV1odHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni4xOC40L3NvdXJj
ZS9kcml2ZXJzL2Nsay9jbGstc2NtaS5jDQoNClRoYW5rcywNCkFybmF1ZA0KDQo+IA0KPiAtU3Vt
aXQNCg0K
