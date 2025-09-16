Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E644CAC599
	for <op-tee@archiver.kernel.org>; Tue, 16 Sep 2025 13:27:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BA7DC4187B
	for <op-tee@archiver.kernel.org>; Tue, 16 Sep 2025 13:27:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=cdQzwsB/;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 518C241821
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Sep 2025 13:27:06 +0000 (UTC)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GC9HFZ013028;
	Tue, 16 Sep 2025 15:26:55 +0200
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 494wr9urvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 15:26:55 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AiXYdYqgTJpZmaw3lLA92basBUT/xIvt+nU5+wBXATrsy1P4bfnMed6Pol2BcvTbdt4tFYVNU1tDNWFl3MWCx1YEOPCsv0CVcZHDYTXBSuDiwOlQYr60L4j7xns9XF9UrzN5GB9psUy8whxtTzKUy/oXUSKEfnIpHOzSpklctk0CT3G5utT1LGuFTc0H41N+Yg1vZ0OvCBNxuIXCc045Ly3jGCKgbgHczJTYsSPo1aAIkwIxdME1iMlVg61BoUXIPWBSgn+wHvTcyNymaXB5loKLQ2qNM6eFmC/XwMfLy8JN16vq4D7i3Li+8zCzxrbtj/JFfgvM2KjYi2ISl/JTvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJvFsulW4qiB/NBOBng5vfuW02X0pla+/tATnDTKSyk=;
 b=xuMj5jzTFOB6BsrBknWUGTexpLC1vAeRxyXPsHRpnz1SO0FTpyxuoE5Yt6wdH4QzGHH2YdITTimsAiHpivYXsTl314Lr43AS1HbqJ04YIoqW29EI4EPWH2zBFcRqz6VALRiMi5tdylnPvjUYeTwHso2h2FLEt9xXnkYCv/PHbiITEEychL37uWgwbg8Lx4d+NQeIbAk7z78O2SpYB1HtEE8X3bvMK+cg5pz3BklJIQOPQvWm9xtn2g33UxAMTAmcpBOUv2fqWtg0FvA5At8d8UINSP+3w52rTX4kPaj0AcHmartUzJno39uxhb5GPL0nFlZY7MIn8Gbc1egKnP+yiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJvFsulW4qiB/NBOBng5vfuW02X0pla+/tATnDTKSyk=;
 b=cdQzwsB/wyEn1kiegDe8aD2rEbZLkDgUaT0NxRW/VrSZCAZHwLb/ldzfYdbNL6J2O6g52DRiPi7zL45sAE6LoH0CqorE1XBgWBaOKnI5l+Wtq4bYqlj3Vh9vFrcruUCocCrN28UpFNZWDu+Z7SuvX6ZvAT720mNC+hWEIbOxPidKWM5Hk4NZLRUQS1XDjp1rZ4NliRb79zVRXckiFC8zJ2m49Pa/qSwZn46a21zDxQ2S1F/XWjQzVQsC70LJsbY4OOcIUkKKBSwXBgNqM+jq22PTV+rbBg1ozNo15EvfzV5/P84Xg5Z8llYFSOjWBIXK3Hb4YQ9kgL1wPauQDmTL2w==
Received: from AS9PR06CA0697.eurprd06.prod.outlook.com (2603:10a6:20b:49f::25)
 by DU0PR10MB6725.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:403::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 13:26:50 +0000
Received: from AM3PEPF0000A799.eurprd04.prod.outlook.com
 (2603:10a6:20b:49f:cafe::be) by AS9PR06CA0697.outlook.office365.com
 (2603:10a6:20b:49f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 13:26:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM3PEPF0000A799.mail.protection.outlook.com (10.167.16.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 13:26:49 +0000
Received: from SHFDAG1NODE2.st.com (10.75.129.70) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 16 Sep
 2025 15:24:25 +0200
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 16 Sep
 2025 15:26:49 +0200
Received: from [10.48.87.127] (10.48.87.127) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 16 Sep
 2025 15:26:48 +0200
Message-ID: <62bdb238-7440-451b-84ef-79f846b10ba0@foss.st.com>
Date: Tue, 16 Sep 2025 15:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 4/6] dt-bindings: remoteproc: Add compatibility for
 TEE support
To: Sumit Garg <sumit.garg@kernel.org>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
 <20250625094028.758016-5-arnaud.pouliquen@foss.st.com>
 <aMkqifHSdlCs4VjA@sumit-X1>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <aMkqifHSdlCs4VjA@sumit-X1>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A799:EE_|DU0PR10MB6725:EE_
X-MS-Office365-Filtering-Correlation-Id: d4008bba-16e7-4b31-0453-08ddf524b14e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QVg4WWxXdDhWNFdlR2JBMmd4RFR6dTZseFFGTGZJT1o1dVVPbFlBVWQzSm43?=
 =?utf-8?B?VjIrT1VaclFRZnhJbWJzTEdrZFJnUFJzdTY1SGExWmNsMXZyNWFSOUVJK0F0?=
 =?utf-8?B?VE8xZ3RNZU00dmxWOWtFR3dTQlEvWUlrU3AwbXlBN2s2QWovUm5pVzRweTBT?=
 =?utf-8?B?VWZpWnRVdkNwR2RqOE5YK3VqNnNVUzhMbmYvam4rSlliczZMS3dDcWNvb0dC?=
 =?utf-8?B?QmxFei9DQ0FIRzBZK3h1QWs0bVFQUE1zTHgwNnFxZXA3YzZIT29XVnZMbHBP?=
 =?utf-8?B?NHNtV09QR0F5bTVSSzA3TDl4TzV3K2FoTWpzUmNETWhmZmxlRFp2RHJlYmhT?=
 =?utf-8?B?Q1FiaXVWbUplVHhEV2Nja2RMRlhSQmlJTUxLTVQwOWR4YUF2dHRqZEpXc0R3?=
 =?utf-8?B?WXBwWHE5TjhRVWZUNXJwR2xVaHpmNXJ2MzRzTnRIMUoxeXVNYVl5a2NRQ1Y2?=
 =?utf-8?B?MmpUUnF6Q3VYSGIwekIvVG82WGtBdjhIZUVaeXdjckFBaTRVcmhkL2k5ek5Z?=
 =?utf-8?B?MmxrbVRqRzkzc0lhUzh1cGgxUms1bWxMSzlRcVpuTkh2UUtrMTVRS0NLY0xq?=
 =?utf-8?B?NjBRSk4yK3VBRm1lbXpmajhlakZoeGQyQjJvMnc4QTNXckR1QytWV2prQ2gy?=
 =?utf-8?B?dE5CQjNPZWZGai8zem56ekVYaUVGcnlnaVYxRWdJYUJjVDRFS1BGTVZOYXhv?=
 =?utf-8?B?ZzhlV291UnQ4U1pjNXo3R0VZUU1ydTd3NEdpUmY4ejF1TjlwdVVHaWI1YWFO?=
 =?utf-8?B?b1pjMGFBVWQwdXVjS3drTDNnU20xNkIrblBEeFpyTjZncG90NFZYL0FxMXhS?=
 =?utf-8?B?V1AwQmw3d3lJWTZaRDRJVk1mbXY4aUV4NWZvOUt3bTFsRkp4R0ZpaVdsbklF?=
 =?utf-8?B?ODVZQXU4Mm94V3FLZkhhdDBpRGdzNTVzMXNFbk1yeFJmTktnUkF2cjV2eEZS?=
 =?utf-8?B?Yys2dUNkQitBNjZUb2d5dkpaTERHQkllcjRITWFzUXpvdm9Kb21Hb2x2Y0Mx?=
 =?utf-8?B?dGgvK2h2RmJrdzZqUkdPaE9VUUdKamZKMndOQUN2WXlNZXMwVGZCdFBzNE5U?=
 =?utf-8?B?SGF2SWpwZmNnUG51ek9KQkRRUXVGa1IyYjlwZFYrZ1E1Qm8zbU4xQTRhN3Fy?=
 =?utf-8?B?NENnTE5KUGZYR0dXSVNvMmtzN1FPNUtBdkdnNE5vaWE5a2g1ZGQxdFVpWUdp?=
 =?utf-8?B?TkJmaTJBc1pua0d5amhobFh3bzNaV3FzZ09Ic0Rockdtd0p2Zkx4SHp0ekww?=
 =?utf-8?B?eFFtQ3ZadXdjTHFkR1FIWU9OY0cvMWJZQm9pbytXem9sRWdWT0pKUk9LSlla?=
 =?utf-8?B?dlVraCswTTZUNVFhZ2R2bW8wZEN2UkRYOE11M1pmOGxaakFJWGpmUWxlUER6?=
 =?utf-8?B?K3NSbkVLbVJDanZoYzlGN2hZQXJvSGNGNUcyLzY3VENpaWtyQiswUDdBSWhD?=
 =?utf-8?B?YkgvbGh0THAwVTVvNHQybHJXdkQxZElBMysyN3h0amRmRlA0Z0l6YTNDL0xt?=
 =?utf-8?B?QjJCVHRGZW5pbmFxbFVvUE14NXA1V0NVNXFpZ2IrYnFza0RXUG96QjJqOHN5?=
 =?utf-8?B?ckVFTVR4U1BMZFlrUXZ2QThrTEk3RDVUbm82VENFZ2hxOGlySCs3L0VBZDNw?=
 =?utf-8?B?N0xqQ0NHV3ZJMXkrSHhscTVuUGlhcHJKRnBPSlYwbFZCYjBnNkFneXNGdnZL?=
 =?utf-8?B?ZzZPWWZwQ3RwMHhEb3lySEZqNTJuUzVoSS9rSmszV0Y4YXl0Z2RBcUI5V1li?=
 =?utf-8?B?Sm9tNXc1UU9yMTBWbnpNa0dhclk2aS9RUW1GeUt0UDNQUDRxUE1kbTY2Rks3?=
 =?utf-8?B?dVJNT2lCd0IxT1BqMmlEUmRFaWhGODVobGJjMnd5Z25MS3cremZHTFBOUS9V?=
 =?utf-8?B?ZlhVRG4xek5nNzNSV3pjaXJoKzV1Mkp4NEN6WnB3emxRSWxXNmlsWDhJREJH?=
 =?utf-8?B?YUV5ZWdBaXpDWUJUcERHZmxBM043UE8yaTF4NmlLNm11cm1hWGxzVVE1RlFs?=
 =?utf-8?B?OWs4WVpnM043M0g3aDVaSkY2ckNNaUwydVV2cWMzYmhZOUdiV2wzOHhRTEZt?=
 =?utf-8?Q?d4265W?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 13:26:49.7775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4008bba-16e7-4b31-0453-08ddf524b14e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM3PEPF0000A799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6725
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEyMDIyMyBTYWx0ZWRfXzTNoaxMTTf64 0MEkTTFUFTuwiQ5rE+gi8rhRssmDADBXb+zyGdAqGcdrw4YEzJ0JQrE50FhB+zurWXloZooZNDG AxqvrwXI2czdPIf1ZykAECC0QKf4WVhTKlOTEXpu+2qs3obrJPm9SMP4qXxjNCnpmkjfRzKlVkk
 uRDqkSCr3NgLjOZLYFI2W2kd/OlHE2TGr7Fxjfr2xKAcbpzEQ/m2vLYdCQj1fPBKrBdY7M0hwtP AN71NjYkHop6KNihn5NN2Gxb3aYr5fB6fBXe9W8OcjMnCr91OUZbBQTHfufVGfuKUykMATu4Sg9 pFXpucOp7HdHdzYSXjs8zv2fPq5IR8354MTL9Zl+nA8go/I8DZRbMUhQwPEb/ktyYUDl19y4esc UvPBkfDr
X-Proofpoint-GUID: UzLhKG6J0Q0IjCkoOL6EFs0_grlEc8IQ
X-Authority-Analysis: v=2.4 cv=HpN2G1TS c=1 sm=1 tr=0 ts=68c9659f cx=c_pps a=xFT3qlHD+1xS+TaMy1FbcQ==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=FOPVHIcnkjUA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8 a=nnNgWeZtcpC2q1cG_EoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: UzLhKG6J0Q0IjCkoOL6EFs0_grlEc8IQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 suspectscore=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509120223
X-Rspamd-Queue-Id: 518C241821
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	RCVD_IN_DNSWL_LOW(-0.10)[91.207.212.93:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[foss.st.com:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DNSWL_BLOCKED(0.00)[164.130.1.43:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=13542dd892=arnaud.pouliquen@foss.st.com];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.83.58:received];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_VERP_SRS(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 6FLKELVLULT72VQI2J2W5RTBK55THCHO
X-Message-ID-Hash: 6FLKELVLULT72VQI2J2W5RTBK55THCHO
X-MailFrom: prvs=13542dd892=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6FLKELVLULT72VQI2J2W5RTBK55THCHO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGVsbG8gU3VtaXQsDQoNCk9uIDkvMTYvMjUgMTE6MTQsIFN1bWl0IEdhcmcgd3JvdGU6DQo+IEhp
IEFybmF1ZCwNCj4NCj4gRmlyc3Qgb2YgYWxsIGFwb2xvZ2llcyBmb3Igc3VjaCBhIGxhdGUgcmV2
aWV3IGNvbW1lbnQgYXMgcHJldmlvdXNseSBJDQo+IHdhc24ndCBDQ2VkIG9yIGludm9sdmVkIGlu
IHRoZSByZXZpZXcgb2YgdGhpcyBwYXRjaC1zZXQuIEluIGNhc2UgYW55IG9mDQo+IG15IGZvbGxv
d2luZyBjb21tZW50cyBoYXZlIGJlZW4gZGlzY3Vzc2VkIGluIHRoZSBwYXN0IHRoZW4gZmVlbCBm
cmVlIHRvDQo+IHBvaW50IG1lIGF0IHJlbGV2YW50IGRpc2N1c3Npb25zLg0KDQpObyB3b3JyaWVz
LCB0aGVyZSBhcmUgdG9vIG1hbnkgdmVyc2lvbnMgb2YgdGhpcyBzZXJpZXMgdG8gZm9sbG93IGFs
bCB0aGUNCnBhc3QgZGlzY3Vzc2lvbnMuIEkgc29tZXRpbWVzIGhhdmUgZGlmZmljdWx0eSByZW1l
bWJlcmluZyBhbGwgdGhlDQpkaXNjdXNzaW9ucyBteXNlbGYgOikNCg0KPg0KPiBPbiBXZWQsIEp1
biAyNSwgMjAyNSBhdCAxMTo0MDoyNkFNICswMjAwLCBBcm5hdWQgUG91bGlxdWVuIHdyb3RlOg0K
Pj4gVGhlICJzdCxzdG0zMm1wMS1tNC10ZWUiIGNvbXBhdGlibGUgaXMgdXRpbGl6ZWQgaW4gYSBz
eXN0ZW0gY29uZmlndXJhdGlvbg0KPj4gd2hlcmUgdGhlIENvcnRleC1NNCBmaXJtd2FyZSBpcyBs
b2FkZWQgYnkgdGhlIFRydXN0ZWQgRXhlY3V0aW9uIEVudmlyb25tZW50DQo+PiAoVEVFKS4NCj4g
SGF2aW5nIGEgRFQgYmFzZWQgY29tcGF0aWJsZSBmb3IgYSBURUUgc2VydmljZSB0byBtZSBqdXN0
IGZlZWxzIGxpa2UgaXQNCj4gaXMgcmVkdW5kYW50IGhlcmUuIEkgY2FuIHNlZSB5b3UgaGF2ZSBh
bHNvIHVzZWQgYSBURUUgYnVzIGJhc2VkIGRldmljZQ0KPiB0b28gYnV0IHRoYXQgaXMgbm90IGJl
aW5nIHByb3Blcmx5IHVzZWQuIEkga25vdyBzdWJzeXN0ZW1zIGxpa2UNCj4gcmVtb3RlcHJvYywg
U0NNSSBhbmQgb3RoZXJzIGhlYXZpbHkgcmVseSBvbiBEVCB0byBoYXJkY29kZSBwcm9wZXJ0aWVz
IG9mDQo+IHN5c3RlbSBmaXJtd2FyZSB3aGljaCBhcmUgcmF0aGVyIGJldHRlciB0byBiZSBkaXNj
b3ZlcmVkIGR5bmFtaWNhbGx5Lg0KPg0KPiBTbyBJIGhhdmUgYW4gb3BlbiBxdWVzdGlvbiBmb3Ig
eW91IGFuZCB0aGUgcmVtb3RlcHJvYyBzdWJzeXN0ZW0NCj4gbWFpbnRhaW5lcnMgYmVpbmc6DQo+
DQo+IElzIGl0IGZlYXNpYmxlIHRvIHJhdGhlciBsZXZlcmFnZSB0aGUgYmVuZWZpdHMgb2YgYSBm
dWxseSBkaXNjb3ZlcmFibGUNCj4gVEVFIGJ1cyByYXRoZXIgdGhhbiByZWx5aW5nIG9uIHBsYXRm
b3JtIGJ1cy8gRFQgdG8gaGFyZGNvZGUgZmlybXdhcmUNCj4gcHJvcGVydGllcz8NCg0KVGhlIGRp
c2NvdmVyYWJsZSBURUUgYnVzIGRvZXMgbm90IHdvcmtzIGlmIHRoZSByZW1vdGVwcm9jIGlzIHBy
b2JlZA0KYmVmb3JlIHRoZSBPUC1URUUgYnVzLCBpbiBzdWNoIGNhc2XCoCBubyBwb3NzaWJpbGl0
eSB0byBrbm93IGlmIHRoZSBURUUNClRBIGlzIG5vdCB5ZXQgYXZhaWxhYmxlIG9yIG5vdCBhdmFp
bGFibGUgYXQgYWxsLg0KVGhpcyBwb2ludCBpcyBtZW50aW9uZWQgaW4gYSBjb21tZW50IGluIHJw
cm9jX3RlZV9yZWdpc3RlcigpLg0KDQpUaGVuLCBpdCBpcyBub3Qgb25seSBhIGZpcm13YXJlIHBy
b3BlcnR5IGluIG91ciBjYXNlLiBEZXBlbmRpbmcgb24gdGhlDQpjb21wYXRpYmxlIHN0cmluZywg
d2UgbWFuYWdlIHRoZSBoYXJkd2FyZSBkaWZmZXJlbnRseS4gVGhlIHNhbWUgY29tcGF0aWJsZXMN
CmFyZSB1c2VkIGluIGJvdGggT1AtVEVFIGFuZCBMaW51eC4gQmFzZWQgb24gdGhlIGNvbXBhdGli
bGUsIHdlIGNhbiBhc3NpZ24NCm1lbW9yaWVzLCBjbG9ja3MsIGFuZCByZXNldHMgdG8gZWl0aGVy
IHRoZSBzZWN1cmUgb3Igbm9uLXNlY3VyZSBjb250ZXh0Lg0KVGhpcyBhcHByb2FjaCBpcyBpbXBs
ZW1lbnRlZCBvbiB0aGUgU1RNMzJNUDE1IGFuZCBTVE0zMk1QMnggcGxhdGZvcm1zLg0KDQpNb3Jl
IGRldGFpbHMgYXJlIGF2YWlsYWJsZSBpbiB0aGUgU1QgV0lLSToNCmh0dHBzOi8vd2lraS5zdC5j
b20vc3RtMzJtcHUvd2lraS9PUC1URUVfcmVtb3RlcHJvY19mcmFtZXdvcmtfb3ZlcnZpZXcjRGV2
aWNlX3RyZWVfY29uZmlndXJhdGlvbg0KaHR0cHM6Ly93aWtpLnN0LmNvbS9zdG0zMm1wdS93aWtp
L0xpbnV4X3JlbW90ZXByb2NfZnJhbWV3b3JrX292ZXJ2aWV3I0RldmljZV90cmVlX2NvbmZpZ3Vy
YXRpb24NCg0KPg0KPj4gRm9yIGluc3RhbmNlLCB0aGlzIGNvbXBhdGlibGUgaXMgdXNlZCBpbiBi
b3RoIHRoZSBMaW51eCBhbmQgT1AtVEVFIGRldmljZQ0KPj4gdHJlZXM6DQo+PiAtIEluIE9QLVRF
RSwgYSBub2RlIGlzIGRlZmluZWQgaW4gdGhlIGRldmljZSB0cmVlIHdpdGggdGhlDQo+PiAgICAi
c3Qsc3RtMzJtcDEtbTQtdGVlIiBjb21wYXRpYmxlIHRvIHN1cHBvcnQgc2lnbmVkIHJlbW90ZXBy
b2MgZmlybXdhcmUuDQo+PiAgICBCYXNlZCBvbiBEVCBwcm9wZXJ0aWVzLCB0aGUgT1AtVEVFIHJl
bW90ZXByb2MgZnJhbWV3b3JrIGlzIGluaXRpYXRlZCB0bw0KPj4gICAgZXhwb3NlIGEgdHJ1c3Rl
ZCBhcHBsaWNhdGlvbiBzZXJ2aWNlIHRvIGF1dGhlbnRpY2F0ZSBhbmQgbG9hZCB0aGUgcmVtb3Rl
DQo+PiAgICBwcm9jZXNzb3IgZmlybXdhcmUgcHJvdmlkZWQgYnkgdGhlIExpbnV4IHJlbW90ZXBy
b2MgZnJhbWV3b3JrLCBhcyB3ZWxsDQo+PiAgICBhcyB0byBzdGFydCBhbmQgc3RvcCB0aGUgcmVt
b3RlIHByb2Nlc3Nvci4NCj4+IC0gSW4gTGludXgsIHdoZW4gdGhlIGNvbXBhdGliaWxpdHkgaXMg
c2V0LCB0aGUgQ29ydGV4LU0gcmVzZXRzIHNob3VsZCBub3QNCj4+ICAgIGJlIGRlY2xhcmVkIGlu
IHRoZSBkZXZpY2UgdHJlZS4gSW4gc3VjaCBhIGNvbmZpZ3VyYXRpb24sIHRoZSByZXNldCBpcw0K
Pj4gICAgbWFuYWdlZCBieSB0aGUgT1AtVEVFIHJlbW90ZXByb2MgZHJpdmVyIGFuZCBpcyBubyBs
b25nZXIgYWNjZXNzaWJsZSBmcm9tDQo+PiAgICB0aGUgTGludXgga2VybmVsLg0KPj4NCj4+IEFz
c29jaWF0ZWQgd2l0aCB0aGlzIG5ldyBjb21wYXRpYmxlLCBhZGQgdGhlICJzdCxwcm9jLWlkIiBw
cm9wZXJ0eSB0bw0KPj4gaWRlbnRpZnkgdGhlIHJlbW90ZSBwcm9jZXNzb3IuIFRoaXMgSUQgaXMg
dXNlZCB0byBkZWZpbmUgYSB1bmlxdWUgSUQsDQo+PiBjb21tb24gYmV0d2VlbiBMaW51eCwgVS1C
b290LCBhbmQgT1AtVEVFLCB0byBpZGVudGlmeSBhIGNvcHJvY2Vzc29yLg0KPiBUaGlzICJzdCxw
cm9jLWlkIiBpcyBqdXN0IG9uZSBzdWNoIHByb3BlcnR5IHdoaWNoIGNhbiByYXRoZXIgYmUgZGly
ZWN0bHkNCj4gcHJvYmVkIGZyb20gdGhlIFRFRS9PUC1URUUgc2VydmljZSByYXRoZXIgdGhhbiBo
YXJkY29kaW5nIGl0IGluIERUIGhlcmUuDQpEbyB5b3UgbWVhbiBhIHRvcG9sb2d5IGRpc2NvdmVy
eSBtZWNoYW5pc20gdGhyb3VnaCB0aGUgVEVFIHJlbW90ZXByb2MNCnNlcnZpY2U/DQoNCkZvciB0
aGUgU1RNMzJNUDE1LCBpdCBjb3VsZCB3b3JrIHNpbmNlIHdlIGhhdmUgb25seSBvbmUgcmVtb3Rl
IHByb2Nlc3Nvci4NCkhvd2V2ZXIsIHRoaXMgaXMgbm90IHRoZSBjYXNlIGZvciB0aGUgU1RNMzJN
UDI1LCB3aGljaCBlbWJlZHMgYm90aCBhDQpDb3J0ZXgtTTMzIGFuZCBhIENvcnRleC1NMC4NCg0K
Q291bGQgeW91IHBsZWFzZSBlbGFib3JhdGUgb24gaG93IHlvdSBzZWUgdGhlIHN1cHBvcnQgb2Yg
bXVsdGlwbGUgcmVtb3RlDQpwcm9jZXNzb3JzIHdpdGhvdXQgdXNpbmcgYW4gaGFyZGNvZGVkIGlk
ZW50aWZpZXI/DQoNCj4gSSB0aGluayB0aGUgc2FtZSB3aWxsIGFwcGx5IHRvIG90aGVyIHByb3Bl
cnRpZXMgYXMgd2VsbC4NCkNvdWxkIHlvdSBkZXRhaWxzIHRoZSBvdGhlciBwcm9wZXJ0aWVzIHlv
dSBoYXZlIGluIG1pbmQ/DQoNClRoYW5rcywNCkFybmF1ZA0KDQo+DQo+IC1TdW1pdA0KPg0KPj4g
VGhpcyBJRCB3aWxsIGJlIHVzZWQgaW4gcmVxdWVzdHMgdG8gdGhlIE9QLVRFRSByZW1vdGVwcm9j
IFRydXN0ZWQNCj4+IEFwcGxpY2F0aW9uIHRvIHNwZWNpZnkgdGhlIHJlbW90ZSBwcm9jZXNzb3Iu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQXJuYXVkIFBvdWxpcXVlbiA8YXJuYXVkLnBvdWxpcXVl
bkBmb3NzLnN0LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyAoQXJtKSA8cm9iaEBr
ZXJuZWwub3JnPg0KPj4gLS0tDQo+PiAgIC4uLi9iaW5kaW5ncy9yZW1vdGVwcm9jL3N0LHN0bTMy
LXJwcm9jLnlhbWwgICB8IDU4ICsrKysrKysrKysrKysrKystLS0NCj4+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL3N0LHN0bTMyLXJw
cm9jLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9z
dCxzdG0zMi1ycHJvYy55YW1sDQo+PiBpbmRleCA4NDM2NzljNTU3ZTcuLjU4ZGEwN2U1MzZmYyAx
MDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVw
cm9jL3N0LHN0bTMyLXJwcm9jLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZW1vdGVwcm9jL3N0LHN0bTMyLXJwcm9jLnlhbWwNCj4+IEBAIC0xNiw3ICsx
NiwxMiBAQCBtYWludGFpbmVyczoNCj4+ICAgDQo+PiAgIHByb3BlcnRpZXM6DQo+PiAgICAgY29t
cGF0aWJsZToNCj4+IC0gICAgY29uc3Q6IHN0LHN0bTMybXAxLW00DQo+PiArICAgIGVudW06DQo+
PiArICAgICAgLSBzdCxzdG0zMm1wMS1tNA0KPj4gKyAgICAgIC0gc3Qsc3RtMzJtcDEtbTQtdGVl
DQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIFVzZSAic3Qsc3RtMzJtcDEtbTQiIGZv
ciB0aGUgQ29ydGV4LU00IGNvcHJvY2Vzc29yIG1hbmFnZW1lbnQgYnkgbm9uLXNlY3VyZSBjb250
ZXh0DQo+PiArICAgICAgVXNlICJzdCxzdG0zMm1wMS1tNC10ZWUiIGZvciB0aGUgQ29ydGV4LU00
IGNvcHJvY2Vzc29yIG1hbmFnZW1lbnQgYnkgc2VjdXJlIGNvbnRleHQNCj4+ICAgDQo+PiAgICAg
cmVnOg0KPj4gICAgICAgZGVzY3JpcHRpb246DQo+PiBAQCAtNDMsNiArNDgsMTAgQEAgcHJvcGVy
dGllczoNCj4+ICAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IFRoZSBvZmZzZXQgb2YgdGhlIGhv
bGQgYm9vdCBzZXR0aW5nIHJlZ2lzdGVyDQo+PiAgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBU
aGUgZmllbGQgbWFzayBvZiB0aGUgaG9sZCBib290DQo+PiAgIA0KPj4gKyAgc3QscHJvYy1pZDoN
Cj4+ICsgICAgZGVzY3JpcHRpb246IHJlbW90ZSBwcm9jZXNzb3IgaWRlbnRpZmllcg0KPj4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4+ICsNCj4+
ICAgICBzdCxzeXNjZmctdHo6DQo+PiAgICAgICBkZXByZWNhdGVkOiB0cnVlDQo+PiAgICAgICBk
ZXNjcmlwdGlvbjoNCj4+IEBAIC0xNDYsMjEgKzE1NSw0MyBAQCBwcm9wZXJ0aWVzOg0KPj4gICBy
ZXF1aXJlZDoNCj4+ICAgICAtIGNvbXBhdGlibGUNCj4+ICAgICAtIHJlZw0KPj4gLSAgLSByZXNl
dHMNCj4+ICAgDQo+PiAgIGFsbE9mOg0KPj4gICAgIC0gaWY6DQo+PiAgICAgICAgIHByb3BlcnRp
ZXM6DQo+PiAtICAgICAgICByZXNldC1uYW1lczoNCj4+IC0gICAgICAgICAgbm90Og0KPj4gLSAg
ICAgICAgICAgIGNvbnRhaW5zOg0KPj4gLSAgICAgICAgICAgICAgY29uc3Q6IGhvbGRfYm9vdA0K
Pj4gKyAgICAgICAgY29tcGF0aWJsZToNCj4+ICsgICAgICAgICAgY29udGFpbnM6DQo+PiArICAg
ICAgICAgICAgY29uc3Q6IHN0LHN0bTMybXAxLW00DQo+PiAgICAgICB0aGVuOg0KPj4gKyAgICAg
IGlmOg0KPj4gKyAgICAgICAgcHJvcGVydGllczoNCj4+ICsgICAgICAgICAgcmVzZXQtbmFtZXM6
DQo+PiArICAgICAgICAgICAgbm90Og0KPj4gKyAgICAgICAgICAgICAgY29udGFpbnM6DQo+PiAr
ICAgICAgICAgICAgICAgIGNvbnN0OiBob2xkX2Jvb3QNCj4+ICsgICAgICB0aGVuOg0KPj4gKyAg
ICAgICAgcmVxdWlyZWQ6DQo+PiArICAgICAgICAgIC0gc3Qsc3lzY2ZnLWhvbGRib290DQo+PiAr
ICAgICAgZWxzZToNCj4+ICsgICAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICAgIHN0LHN5
c2NmZy1ob2xkYm9vdDogZmFsc2UNCj4+ICsgICAgICAgIHJlcXVpcmVkOg0KPj4gKyAgICAgICAg
ICAtIHJlc2V0LW5hbWVzDQo+PiAgICAgICAgIHJlcXVpcmVkOg0KPj4gLSAgICAgICAgLSBzdCxz
eXNjZmctaG9sZGJvb3QNCj4+IC0gICAgZWxzZToNCj4+ICsgICAgICAgIC0gcmVzZXRzDQo+PiAr
DQo+PiArICAtIGlmOg0KPj4gKyAgICAgIHByb3BlcnRpZXM6DQo+PiArICAgICAgICBjb21wYXRp
YmxlOg0KPj4gKyAgICAgICAgICBjb250YWluczoNCj4+ICsgICAgICAgICAgICBjb25zdDogc3Qs
c3RtMzJtcDEtbTQtdGVlDQo+PiArICAgIHRoZW46DQo+PiAgICAgICAgIHByb3BlcnRpZXM6DQo+
PiAgICAgICAgICAgc3Qsc3lzY2ZnLWhvbGRib290OiBmYWxzZQ0KPj4gKyAgICAgICAgcmVzZXQt
bmFtZXM6IGZhbHNlDQo+PiArICAgICAgICByZXNldHM6IGZhbHNlDQo+PiArICAgICAgcmVxdWly
ZWQ6DQo+PiArICAgICAgICAtIHN0LHByb2MtaWQNCj4+ICAgDQo+PiAgIGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPj4gICANCj4+IEBAIC0xOTIsNSArMjIzLDE2IEBAIGV4YW1wbGVzOg0K
Pj4gICAgICAgICBzdCxzeXNjZmctcnNjLXRibCA9IDwmdGFtcCAweDE0NCAweEZGRkZGRkZGPjsN
Cj4+ICAgICAgICAgc3Qsc3lzY2ZnLW00LXN0YXRlID0gPCZ0YW1wIDB4MTQ4IDB4RkZGRkZGRkY+
Ow0KPj4gICAgICAgfTsNCj4+ICsgIC0gfA0KPj4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cmVzZXQvc3RtMzJtcDEtcmVzZXRzLmg+DQo+PiArICAgIG00QDEwMDAwMDAwIHsNCj4+ICsgICAg
ICBjb21wYXRpYmxlID0gInN0LHN0bTMybXAxLW00LXRlZSI7DQo+PiArICAgICAgcmVnID0gPDB4
MTAwMDAwMDAgMHg0MDAwMD4sDQo+PiArICAgICAgICAgICAgPDB4MzAwMDAwMDAgMHg0MDAwMD4s
DQo+PiArICAgICAgICAgICAgPDB4MzgwMDAwMDAgMHgxMDAwMD47DQo+PiArICAgICAgc3QscHJv
Yy1pZCA9IDwwPjsNCj4+ICsgICAgICBzdCxzeXNjZmctcnNjLXRibCA9IDwmdGFtcCAweDE0NCAw
eEZGRkZGRkZGPjsNCj4+ICsgICAgICBzdCxzeXNjZmctbTQtc3RhdGUgPSA8JnRhbXAgMHgxNDgg
MHhGRkZGRkZGRj47DQo+PiArICAgIH07DQo+PiAgIA0KPj4gICAuLi4NCj4+IC0tIA0KPj4gMi4y
NS4xDQo+Pg0KPj4NCg0K
