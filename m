Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C45C2A062
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 08:34:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6C1864FF0F
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 08:34:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=UPNMbJJF;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 04EB541A35
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 08:34:04 +0000 (UTC)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058KOCt1605368;
	Mon, 5 Jan 2026 09:33:42 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4betvg4e8w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 09:33:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9I0qm/wRacDUQfiSq7oCfWp4110kkMIOqpqaghSRBqY3qrH8DNg0qpVJ5dH6sQRGlJdXqQoW3YwW/pgjhi04Qb5u00XSwWISZMFmkPoIyCvFDHb66ug19S56toA2Kr2C9RMQxM7/+JkRkFVQtkULzMsGWiYeGWwCE0296JCUHL6oyuh2PSRvxz32QPKhmDmIgQMb7xjm7peJiNZTFiLlqbIReprO1OEHG5Uf/W52kX7Q3ZXxb9x8QyjhxC79uX/jAUhNdFFsov5XhkSYozP3Afd1IcLcMAwfupgQ6Rq/iuz1k+SYYz+YkWldaT/VvfUYNlbdyY1MaBVw5ZUpvsthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JrIZ2l4Va+OcD9mdPPKVO9TaKWN4X+/kH35/jRX3bg=;
 b=YK4jPUvIJHO2ib6VUUymgddBhMoAn1PMZckJfL7e+dwvRMt1gmmkfxgnZaB6ZdoEKrBmJa9Zvug9CJMJ8yqc/+LMHBAhkhic7Mzsr8iYoKR1+325utbKavqhpXsN0FItY3XOD0itF+1JPPZ3zhNzvuLIu0UNdj2ue0CEWA9Hs2hD+55ClRthaimxpcfKFUWxkcl1gROX7+tVgmqMLtXbwiAktucnA6HGQZEsAOC2e2DU+3Hv1Dkyrs1l/I9Mb/16Lw3+OQJmCgfiGuFhzj/HlRy1iSuwxjrW6GtepPoM2/joh5gdt+EpxuWCCmyD8PueWqr8LRzSRsqjvhYkfrbAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JrIZ2l4Va+OcD9mdPPKVO9TaKWN4X+/kH35/jRX3bg=;
 b=UPNMbJJFRtoL1lnX8oJhyWg+blagGQkkrfLZ5bEO46heMhzI8mA3KWSCmGsSThXy5289enMqijdNnESJ3AaZXB0b7YuA/BNCqJ/0lyCp0vIIPPfO2aWbkclC4VHXz5U2oDtKZRCTWGlQ+/Fu+twAwMan5tjCZojsIQPyN3GzAMUf/aZ5vuEJAPA6eUgQvygtdKsIkKYJFJdPLhEEK2Dk2LVJA4WQ+xmfw4dId1Bs9jEMOas1WMZwQC3zYHxgwnrHIn9dXA8L+RLpqTqDHBgH/nljpw4Ka3/wsz03ToQAmC/wQZhwUFywGuNc4qEKl9Rk7296/l+rAVAwzbCqpzOQQg==
Received: from DUZP191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::19)
 by PAWPR10MB6758.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:332::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:33:36 +0000
Received: from DU2PEPF00028CFE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f9:cafe::40) by DUZP191CA0005.outlook.office365.com
 (2603:10a6:10:4f9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 08:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028CFE.mail.protection.outlook.com (10.167.242.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 5 Jan 2026 08:33:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 09:34:49 +0100
Received: from [10.48.87.127] (10.48.87.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 09:33:35 +0100
Message-ID: <516cda61-f02b-47ef-9a66-b66dfb714b05@foss.st.com>
Date: Mon, 5 Jan 2026 09:33:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 5/6] remoteproc: Add TEE support
To: Sumit Garg <sumit.garg@kernel.org>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-6-arnaud.pouliquen@foss.st.com>
 <aVIWt5bWP9R9j7nx@sumit-xelite>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <aVIWt5bWP9R9j7nx@sumit-xelite>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFE:EE_|PAWPR10MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb6dba4-bb02-48de-ba73-08de4c351eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YWdXTDd3c0VHZ3NCU3NJd0RTWmh3NWxrMWhHSXA5aVFLenkvc0llQmI0Qlo0?=
 =?utf-8?B?d1dDNWRIcHpWbVhpakc3cGlTV24weXdpblBpUFFMaGUwazRvT2Q4YkxGcG5N?=
 =?utf-8?B?OUpCU3RKczVJYlo5Q2NndzFvR2tUTmRGWGJaekdIWTI2MmVraFB3SVhEaC92?=
 =?utf-8?B?Ujg4THdXMFdJN2U3OFR1OGZhYTAvMWtXcE9NUlVuaTU4SWs2MGpNblVBa1pY?=
 =?utf-8?B?NTdlU0t1QUNPRnp5M1dyTC9xMStjdkJaNEpLTUVuK1V6YUpheTZ0MmNEdTBh?=
 =?utf-8?B?TFZySFFpekcxOEl3YlJwZkdLT1pwaGc2V2V5dDMyRSs1djdHSGp2VHBKZStB?=
 =?utf-8?B?WEtaL3hqc0V2QzIrd1E2Y3lwMGJCYlpJTzQyMW1nR0YyZ2FxM0ErbkhvMmc5?=
 =?utf-8?B?d1hETmdFU0k5d1REZC9yWDZCRGQ1bE1iaGF5a3o2ckh2OVZJRUVkdDBOck52?=
 =?utf-8?B?djNvZmRWSnNZUG1Wb1ZJNlY0Zll2MDl5WVZBZmxTTDBhczI1K2RWNjNXMU1C?=
 =?utf-8?B?NlRDc1hzK21wQ2ZKVEtTSHB1a0xucm9oM09NdGhVWSsyZ3VJZFl5UXZoMWxR?=
 =?utf-8?B?TnJiblBiK1pZVzdQUGgyNXBQUlRoQ1Mzb2gwLzFGMmZvUDBmVEt5dDBSNDVF?=
 =?utf-8?B?TUdYVzIyMFJaSXliTEZRYzNyZzZ6SUpqSEo5aWwzWjdoVS9HZWMyaWpudkVT?=
 =?utf-8?B?RzYyb3JWakdXTVRjaWZCVkIyb2g1TWc3bHVQR1ZzK2J0ME16SkFJYnNFam5T?=
 =?utf-8?B?RXJmWmRrY3N4cm9qS3lkL0g4M2p2T2Z2L2MwRTF3elhxQm91K0N6cjl0U2Ry?=
 =?utf-8?B?SHI0cGRQMUpmMEpqWFBDcXBmTThvVU41bCsxcnJoTjFMWUFtWUQybGNXNHlo?=
 =?utf-8?B?YitIRmtmenJxVzVWVDlIbS8waVdFUUR4ME1RbmNCaG5Xd2oxL3FNRUhNMWM4?=
 =?utf-8?B?QXVsZXc0M0lOa0liR3FEVXo5alhoY1ZuY0RxMVM5bm9GRlUxY0RhM1Fvc09t?=
 =?utf-8?B?OS9Sc0I2b3R2ZUxqTGVleG42R1VBblErYS9mc1hYck53WVp4REpTZlFXbXJG?=
 =?utf-8?B?S0ltWkVEc3k1VS9GSVJkYU5EekxqVVFsY1NyejRaeGhiekhsMnpYdk9NTkhH?=
 =?utf-8?B?dlhsd1NNK2pTNnVzQi8xOTl0Ymw5WVRtTERyR1BuamExVVhNakhmbDJJVkdy?=
 =?utf-8?B?SG9MdnVtdkJwMFc4V1crdmV4eUN5emFvY1FHcmk1RUZKTEp3QXhsU3JlTlo1?=
 =?utf-8?B?b24wdDVMVFViU0hhTC9aUjltTWVkeWZKbVg5MUlhNnByeEdOaUYxN3dHcTVr?=
 =?utf-8?B?UVJhNWtpdXpuU21CREwycVdrSDRSZy9URWhNcGJsZGVwekhNaVVsaVIxY0Jk?=
 =?utf-8?B?RDVMT21TVWZuNERZSDlvN1JVWmxnbFVWbTZLa2NsM08yc0FvRFlkZjhFa3lp?=
 =?utf-8?B?aE9rVG5hOXlwd1BmNGVwOExDR2lUWTlpY0JOWlUzQ2cwZ2VBNGN4NHlySDFo?=
 =?utf-8?B?ZGxORG9uOE1xQzBERVUya3NyWVNCMUl2RktSa3ZZaFphVUNXM1pJVmNHS0c1?=
 =?utf-8?B?WC9EaUJoYjdjSEdMeGRXMDVOc1B6ZFVuTm1EbWFFVlEvaWd4dmRjYi8rUERW?=
 =?utf-8?B?OHVyM2tLenlsM1lLSDNHL2ZKV1grYTNwclIxRFhKNHFiT3hKZ1lTZXhtVmty?=
 =?utf-8?B?NE45ZDkxcnp0WHcwRkpBQWdobi8wVkpSSFNKOGhsMWg1bjRwMkNQa0VQbG1R?=
 =?utf-8?B?bDRtckdDM0VjNGxNSU1sWmsrMUpVd0Q5RUdGWHFmektCWU9OOXZ2VG1mMGVF?=
 =?utf-8?B?RlpjTGV6NWFOaGFPNkl0a3VLaWV1WGRrNUFuUEh5ZWcrVzJNaGY0THYyamMx?=
 =?utf-8?B?eFRGMDZ6WUhCdldVMFZaMXBvRGJ0alh6SHZXbWRGNXhHVE43ak9sZWp1V1pp?=
 =?utf-8?B?c0lqbm93a0hlM20yZzAzcmZ6L0ovbWEydXBacTJuZ3lvdHhLblZDYUFkWHlL?=
 =?utf-8?B?eVVZNnVzN3pjcjllckFtMUV1UUgyTkdmdFZ3KzhNRUR4aHB6dnRNa1RRRDFn?=
 =?utf-8?B?bElTaHZUU1oxYm9nc2dmbnpMalQ4VTY1ckp2T2JJZTR6aEtrRDd4VkpsOFdQ?=
 =?utf-8?Q?wTZ0=3D?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:33:36.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb6dba4-bb02-48de-ba73-08de4c351eb2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028CFE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6758
X-Proofpoint-ORIG-GUID: UH9vUs1pxDWTwCYYS15Sp88kgGmBg7tA
X-Authority-Analysis: v=2.4 cv=BcLVE7t2 c=1 sm=1 tr=0 ts=695b7766 cx=c_pps
 a=BCF/4kTwNUBN+ixkr4tlQA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=FaiAVIg_d7AZG2YU4VAA:9
 a=-AnMH61VQvFFWhBc:21 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3NiBTYWx0ZWRfXyV8K/+t/2LXO
 bH2n/PSUjd1OJpi6yg/u0IbX8JTgjdIGv3ewzBb05Wr8X8ytVA4bCXTrOZrncfL7gZOslenNXHz
 LVFOhCk1Yzbq631NXVmqaZCt3vXJ0mGpya2nEo7LdUXSfx/3MkgUyoGzW+7j1bc98l9DLJNcUgB
 9GrhCwoInXWMeNeyGqWZ4g8eN3F2ELE0orglTMDV3CVD3Eo/cK71THGihySSmjiTpO+y0OdPY6g
 z6cI/hlkP2E6DxAfeKzOWpOtxvhwBXtGhOIysqmiY5RWhzi5MTG6YnX7WXUO5BsujuWU0HMFslv
 lPnHxK+o5D4iWrNxX45erR3OAgZBrTuvYL1SPSFK85JrTjAktbUdnJfRqtLoIgY0GSrIxRssdGT
 25z0luwn1bvrlauPc4p20soVQ3SzToyxOQCKWOfBN9bT9HKDVgSEuvVQaESa4U7cfWoRYgUBzPl
 4eTE1NBBuAjSHrRe+1w==
X-Proofpoint-GUID: UH9vUs1pxDWTwCYYS15Sp88kgGmBg7tA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:52129, ipnet:91.207.212.0/23, country:US];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DNSWL_BLOCKED(0.00)[164.130.1.59:received,91.207.212.93:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=5465aeb669=arnaud.pouliquen@foss.st.com];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_VERP_SRS(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 04EB541A35
X-Spamd-Bar: ---
Message-ID-Hash: IHN23A5MKRNQ4HQBBD6CIZECGLQXCUGJ
X-Message-ID-Hash: IHN23A5MKRNQ4HQBBD6CIZECGLQXCUGJ
X-MailFrom: prvs=5465aeb669=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IHN23A5MKRNQ4HQBBD6CIZECGLQXCUGJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>



On 12/29/25 06:50, Sumit Garg wrote:
> On Wed, Dec 17, 2025 at 04:39:16PM +0100, Arnaud Pouliquen wrote:
>> Add a remoteproc TEE (Trusted Execution Environment) driver that will be
>> probed by the TEE bus. If the associated Trusted application is supported
>> on the secure part, this driver offers a client interface to load firmware
>> by the secure part.
>> This firmware could be authenticated by the secure trusted application.
>>
>> A specificity of the implementation is that the firmware has to be
>> authenticated and optionally decrypted to access the resource table.
>>
>> Consequently, the boot sequence is:
>>
>> 1) rproc_parse_fw --> rproc_tee_parse_fw
>>     remoteproc TEE:
>>     - Requests the TEE application to authenticate and load the firmware
>>       in the remote processor memories.
>>     - Requests the TEE application for the address of the resource table.
>>     - Creates a copy of the resource table stored in rproc->cached_table.
>>
>> 2) rproc_load_segments --> rproc_tee_load_fw
>>     remoteproc TEE:
>>     - Requests the TEE application to load the firmware. Nothing is done
>>       at the TEE application as the firmware is already loaded.
>>     - In case of recovery, the TEE application has to reload the firmware.
>>
>> 3) rproc_tee_get_loaded_rsc_table
>>     remoteproc TEE requests the TEE application for the address of the
>>     resource table.
>>
>> 4) rproc_start --> rproc_tee_start
>>     - Requests the TEE application to start the remote processor.
>>
>> The shutdown sequence is:
>>
>> 5) rproc_stop --> rproc_tee_stop
>>     - Requests the TEE application to stop the remote processor.
>>
>> 6) rproc_tee_release_fw
>>     This function is used to request the TEE application to perform actions
>>     to return to the initial state on stop or on error during the boot
>>     sequence.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> Version 20 updates:
>> - rework probe. the remoteproc-tee now probe the remoteproc devices
>>    defined in device tree as child.
>>    - creation of rproc-service-80a4c275-0a47-4905-8285-1486a9771a08 compatible
>>    - use of of_find_compatible_node() to find node in DT
>>    - use of of_platform_populate() to probe remoteproc devices
>> - remove device_link_add() as now managed by of_platform_populate)
>> - add "auto_boot" parameter in rproc_tee_register()
>> - rename TA_RPROC_FW_CMD_* TEE CMD in  TA_RPROC_CMD_* command
>> - use of DEFINE_MUTEX
>>
>> Version 19 updates:
>> - rework/fix function headers
>> - use memremap instead of ioremap for the resource table.
>> - realign comments to 80 chars limit, with few exceptions for readability
>> - replace spinlock by mutex and and protect APIs from concurrent access
>> - add support of 64-bit address in rproc_tee_get_loaded_rsc_table()
>> - update copyright year
>>
>> Version 18 updates:
>> Fix warning:
>> warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
>> ---
>>   drivers/remoteproc/Kconfig          |  10 +
>>   drivers/remoteproc/Makefile         |   1 +
>>   drivers/remoteproc/remoteproc_tee.c | 771 ++++++++++++++++++++++++++++
>>   include/linux/remoteproc_tee.h      |  89 ++++
>>   4 files changed, 871 insertions(+)
>>   create mode 100644 drivers/remoteproc/remoteproc_tee.c
>>   create mode 100644 include/linux/remoteproc_tee.h
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 48a0d3a69ed0..75265f3f5008 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -23,6 +23,16 @@ config REMOTEPROC_CDEV
>>   
>>   	  It's safe to say N if you don't want to use this interface.
>>   
>> +config REMOTEPROC_TEE
>> +	bool "Remoteproc support by a TEE application"
>> +	depends on OPTEE
>> +	help
>> +	  Support a remote processor that is managed by an application running in a Trusted
>> +	  Execution Environment (TEE). This application is responsible for loading the remote
>> +	  processor firmware image and managing its lifecycle.
>> +
>> +	  It's safe to say N if the remote processor is not managed by a TEE.
>> +
>>   config IMX_REMOTEPROC
>>   	tristate "i.MX remoteproc support"
>>   	depends on ARCH_MXC
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index 1c7598b8475d..a1a5201982d4 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -11,6 +11,7 @@ remoteproc-y				+= remoteproc_sysfs.o
>>   remoteproc-y				+= remoteproc_virtio.o
>>   remoteproc-y				+= remoteproc_elf_loader.o
>>   obj-$(CONFIG_REMOTEPROC_CDEV)		+= remoteproc_cdev.o
>> +obj-$(CONFIG_REMOTEPROC_TEE)		+= remoteproc_tee.o
>>   obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>>   obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
>>   obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
>> diff --git a/drivers/remoteproc/remoteproc_tee.c b/drivers/remoteproc/remoteproc_tee.c
>> new file mode 100644
>> index 000000000000..081420c35c88
>> --- /dev/null
>> +++ b/drivers/remoteproc/remoteproc_tee.c
>> @@ -0,0 +1,771 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) STMicroelectronics 2025
>> + * Author: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> + */
>> +
>> +#include <linux/firmware.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/mutex.h>
>> +#include <linux/remoteproc.h>
>> +#include <linux/remoteproc_tee.h>
>> +#include <linux/slab.h>
>> +#include <linux/tee_drv.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +#define MAX_TEE_PARAM_ARRAY_MEMBER	4
>> +
>> +/*
>> + * Authentication and load of the firmware image in the remote processor
>> + * memories by the TEE. After this step the firmware is installed in destination
>> + * memories, which can then be locked to prevent access by Linux.
>> + *
>> + * [in]  params[0].value.a: remote processor identifier
>> + * [in]  params[1].memref:  buffer containing a temporary copy of the signed
>> + *			    image to load.
>> + */
>> +#define TA_RPROC_CMD_LOAD_FW		1
>> +
>> +/*
>> + * Start the remote processor by the TEE
>> + *
>> + * [in]  params[0].value.a: remote processor identifier
>> + */
>> +#define TA_RPROC_CMD_START		2
>> +
>> +/*
>> + * Stop the remote processor by the TEE
>> + *
>> + * [in]  params[0].value.a: remote processor identifier
>> + */
>> +#define TA_RPROC_CMD_STOP		3
>> +
>> +/*
>> + * Return the address of the resource table, or 0 if not found.
>> + *
>> + * [in]  params[0].value.a: remote processor identifier
>> + * [out] params[1].value.a: 32bit LSB resource table memory address
>> + * [out] params[1].value.b: 32bit MSB resource table memory address
>> + * [out] params[2].value.a: 32bit LSB resource table memory size
>> + * [out] params[2].value.b: 32bit MSB resource table memory size
>> + */
>> +#define TA_RPROC_CMD_GET_RSC_TABLE	4
>> +
>> +/*
>> + * Release remote processor firmware images and associated resources.
>> + * This command should be used in case an error occurs between the loading of
>> + * the firmware images (TA_RPROC_CMD_LOAD_FW) and the starting of the remote
>> + * processor (TA_RPROC_CMD_START) or after stopping the remote processor
>> + * to release associated resources (TA_RPROC_CMD_STOP).
>> + *
>> + * [in]  params[0].value.a: remote processor identifier
>> + */
>> +#define TA_RPROC_CMD_RELEASE_FW		6
>> +
>> +struct rproc_tee_context {
>> +	struct list_head	rproc_list;
>> +	struct tee_context	*tee_ctx;
>> +	struct device		*dev;
>> +};
>> +
>> +/**
>> + * struct rproc_tee - TEE remoteproc structure
>> + * @node:       Reference in list
>> + * @rproc:      Remoteproc reference
>> + * @rproc_id:   remote processor identifier
>> + * @session_id: TEE session identifier
>> + */
>> +struct rproc_tee {
>> +	struct list_head node;
>> +	struct rproc *rproc;
>> +	u32 rproc_id;
>> +	u32 session_id;
>> +};
>> +
>> +static struct rproc_tee_context rproc_tee_ctx;
>> +static DEFINE_MUTEX(ctx_lock); /* Protects concurrent manipulations of the rproc_tee_ctx*/
>> +
>> +static struct rproc_tee *rproc_to_trproc(struct rproc *rproc)
>> +{
>> +	struct rproc_tee *trproc;
>> +
>> +	list_for_each_entry(trproc, &rproc_tee_ctx.rproc_list, node)
>> +		if (trproc->rproc == rproc)
>> +			return trproc;
>> +	return NULL;
>> +}
>> +
>> +static void rproc_tee_prepare_args(struct rproc_tee *trproc, int cmd,
>> +				   struct tee_ioctl_invoke_arg *arg,
>> +				   struct tee_param *param,
>> +				   unsigned int num_params)
>> +{
>> +	memset(arg, 0, sizeof(*arg));
>> +	memset(param, 0, MAX_TEE_PARAM_ARRAY_MEMBER * sizeof(*param));
>> +
>> +	arg->func = cmd;
>> +	arg->session = trproc->session_id;
>> +	arg->num_params = num_params + 1;
>> +
>> +	param[0] = (struct tee_param) {
>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>> +		.u.value.a = trproc->rproc_id,
>> +	};
>> +}
>> +
>> +/**
>> + * rproc_tee_release_fw() - Release the firmware for a TEE-based remote processor
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + *
>> + * This function invokes the TA_RPROC_CMD_RELEASE_FW TEE client function to
>> + * release the firmware. It should only be called when the remoteproc state is
>> + * RPROC_OFFLINE or RPROC_DETACHED. The function requests the TEE remoteproc
>> + * application to release the firmware loaded by rproc_tee_load_fw().
>> + * The request is ignored if the rproc state is RPROC_DETACHED as the remote
>> + * processor is still running.
>> + */
>> +void rproc_tee_release_fw(struct rproc *rproc)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc;
>> +	struct tee_ioctl_invoke_arg arg;
>> +	int ret;
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		return;
>> +
>> +	if (!rproc_tee_ctx.dev)
>> +		goto out;
>> +
>> +	trproc = rproc_to_trproc(rproc);
>> +	if (!trproc)
>> +		goto out;
>> +
>> +	/*
>> +	 * If the remote processor state is RPROC_DETACHED, just ignore the
>> +	 * request, as the remote processor is still running.
>> +	 */
>> +	if (rproc->state == RPROC_DETACHED)
>> +		goto out;
>> +
>> +	if (rproc->state != RPROC_OFFLINE) {
>> +		dev_err(rproc_tee_ctx.dev, "unexpected rproc state: %d\n", rproc->state);
>> +		goto out;
>> +	}
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_RELEASE_FW, &arg, param, 0);
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_CMD_RELEASE_FW invoke failed TEE err: %#x, ret:%d\n",
>> +			arg.ret, ret);
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&ctx_lock);
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_release_fw);
>> +
>> +/**
>> + * rproc_tee_load_fw() - Load firmware from TEE application
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
>> + *
>> + * This function invokes the TA_RPROC_CMD_LOAD_FW TEE client function to load
>> + * the firmware. It registers the fw->data as a shared memory region with the
>> + * TEE, and request the TEE to load the firmware. This function can be called
>> + * twice during the remote processor boot, a first by rproc_tee_parse_fw() to
>> + * parse the resource table , and a second time by rproc_tee_load_fw().
>> + * The TEE application should ignores the command if the firmware
>> + * is already loaded by rproc_tee_parse_fw().
>> + *
>> + * Return: 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc;
>> +	struct tee_ioctl_invoke_arg arg;
>> +	struct tee_shm *fw_shm;
>> +	int ret;
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!rproc_tee_ctx.dev) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	trproc = rproc_to_trproc(rproc);
>> +	if (!trproc) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	fw_shm = tee_shm_register_kernel_buf(rproc_tee_ctx.tee_ctx, (void *)fw->data, fw->size);
>> +	if (IS_ERR(fw_shm)) {
>> +		ret = PTR_ERR(fw_shm);
>> +		goto out;
>> +	}
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_LOAD_FW, &arg, param, 1);
>> +
>> +	/* Provide the address of the firmware image */
>> +	param[1] = (struct tee_param) {
>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
>> +		.u.memref = {
>> +			.shm = fw_shm,
>> +			.size = fw->size,
>> +			.shm_offs = 0,
>> +		},
>> +	};
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_CMD_LOAD_FW invoke failed TEE err: %#x, ret:%d\n",
>> +			arg.ret, ret);
>> +		if (!ret)
>> +			ret = -EIO;
>> +	}
>> +
>> +	tee_shm_free(fw_shm);
>> +
>> +out:
>> +	mutex_unlock(&ctx_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_load_fw);
>> +
>> +static int rproc_tee_get_loaded_rsc_table(struct rproc *rproc, phys_addr_t *rsc_pa,
>> +					  size_t *table_sz)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc;
>> +	struct tee_ioctl_invoke_arg arg;
>> +	int ret;
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!rproc_tee_ctx.dev) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	trproc = rproc_to_trproc(rproc);
>> +	if (!trproc) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_GET_RSC_TABLE, &arg, param, 2);
>> +
>> +	param[1].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>> +	param[2].attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_CMD_GET_RSC_TABLE invoke failed TEE err: %#x, ret:%d\n",
>> +			arg.ret, ret);
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>> +
>> +	*table_sz = param[2].u.value.a;
>> +	if (sizeof(phys_addr_t) == sizeof(u64))
>> +		*table_sz |= param[2].u.value.b << 32;
>> +
>> +	if (*table_sz) {
>> +		*rsc_pa = param[1].u.value.a;
>> +		if (sizeof(phys_addr_t) == sizeof(u64))
>> +			*rsc_pa |= param[1].u.value.b << 32;
>> +	} else {
>> +		*rsc_pa = 0;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&ctx_lock);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * rproc_tee_parse_fw() - Get the resource table from TEE application
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
>> + *
>> + * This function retrieves the loaded resource table and creates a cached_table
>> + * copy. Since the firmware image is signed and potentially encrypted, the
>> + * firmware must be loaded first to access the loaded resource table.
>> + *
>> + * Return: 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	phys_addr_t rsc_table;
>> +	void *rsc_va;
>> +	size_t table_sz;
>> +	int ret;
>> +
>> +	if (!rproc)
>> +		return -EINVAL;
>> +
>> +	/* We need first to Load the firmware, to be able to get the resource table. */
>> +	ret = rproc_tee_load_fw(rproc, fw);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
>> +	if (ret)
>> +		goto release_fw;
>> +
>> +	/*
>> +	 * We assume here that the memory mapping is the same between the TEE
>> +	 * and Linux kernel contexts. Else a new TEE remoteproc service could be
>> +	 * needed to get a copy of the resource table.
>> +	 */
>> +	rsc_va = memremap(rsc_table, table_sz, MEMREMAP_WC);
>> +	if (!rsc_va) {
>> +		dev_err(rproc_tee_ctx.dev, "Unable to map memory region: %pa+%zx\n",
>> +			&rsc_table, table_sz);
>> +		ret = -ENOMEM;
>> +		goto release_fw;
>> +	}
>> +
>> +	/*
>> +	 * Create a copy of the resource table to have the same behavior as the
>> +	 * ELF loader. This cached table will be used by the remoteproc core
>> +	 * after the remoteproc stops to free resources and for crash recovery
>> +	 * to reapply the settings.
>> +	 * The cached table will be freed by the remoteproc core.
>> +	 */
>> +	rproc->cached_table = kmemdup(rsc_va, table_sz, GFP_KERNEL);
>> +	memunmap(rsc_va);
>> +
>> +	if (!rproc->cached_table) {
>> +		ret = -ENOMEM;
>> +		goto release_fw;
>> +	}
>> +
>> +	rproc->table_ptr = rproc->cached_table;
>> +	rproc->table_sz = table_sz;
>> +
>> +	return 0;
>> +
>> +release_fw:
>> +	rproc_tee_release_fw(rproc);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_parse_fw);
>> +
>> +/**
>> + * rproc_tee_find_loaded_rsc_table() - Find the loaded resource table loaded by
>> + *				       the TEE application
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @fw: Pointer to the firmware structure containing the firmware data and size
>> + *
>> + * This function retrieves the physical address and size of the resource table
>> + * loaded by the TEE application.
>> + *
>> + * Return: pointer to the resource table if found, or NULL if not found or size
>> + * is 0
>> + */
>> +struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
>> +						       const struct firmware *fw)
>> +{
>> +	phys_addr_t rsc_table;
>> +	size_t table_sz;
>> +	int ret;
>> +
>> +	ret = rproc_tee_get_loaded_rsc_table(rproc, &rsc_table, &table_sz);
>> +	if (ret)
>> +		return NULL;
>> +
>> +	rproc->table_sz = table_sz;
>> +	if (!table_sz)
>> +		return NULL;
>> +
>> +	/*
>> +	 * At this step the memory area that contains the resource table should
>> +	 * have been registered by the remote proc platform driver and allocated
>> +	 * by rproc_alloc_registered_carveouts().
>> +	 */
>> +	return rproc_pa_to_va(rproc, rsc_table, table_sz, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_find_loaded_rsc_table);
>> +
>> +/**
>> + * rproc_tee_start() - Request the TEE application to start the remote processor
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + *
>> + * This function invokes the TA_RPROC_CMD_START command to start the remote
>> + * processor.
>> + *
>> + * Return: Returns 0 on success, -EINVAL or -EIO on failure
>> + */
>> +int rproc_tee_start(struct rproc *rproc)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc;
>> +	struct tee_ioctl_invoke_arg arg;
>> +	int ret;
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!rproc_tee_ctx.dev) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	trproc = rproc_to_trproc(rproc);
>> +	if (!trproc) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_START, &arg, param, 0);
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_CMD_START invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
>> +		if (!ret)
>> +			ret = -EIO;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&ctx_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_start);
>> +
>> +/**
>> + * rproc_tee_stop() - Request the TEE application to start the remote processor
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + *
>> + * This function invokes the TA_RPROC_CMD_STOP command to stop the remote
>> + * processor.
>> + *
>> + * Return: Returns 0 on success, -EINVAL or -EIO on failure
>> + */
>> +int rproc_tee_stop(struct rproc *rproc)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct rproc_tee *trproc;
>> +	struct tee_ioctl_invoke_arg arg;
>> +	int ret;
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!rproc_tee_ctx.dev) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	trproc = rproc_to_trproc(rproc);
>> +	if (!trproc) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	rproc_tee_prepare_args(trproc, TA_RPROC_CMD_STOP, &arg, param, 0);
>> +
>> +	ret = tee_client_invoke_func(rproc_tee_ctx.tee_ctx, &arg, param);
>> +	if (ret < 0 || arg.ret != 0) {
>> +		dev_err(rproc_tee_ctx.dev,
>> +			"TA_RPROC_CMD_STOP invoke failed TEE err: %#x, ret:%d\n", arg.ret, ret);
>> +		if (!ret)
>> +			ret = -EIO;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&ctx_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_stop);
>> +
>> +static const struct rproc_ops rproc_tee_default_ops = {
>> +	.start		= rproc_tee_start,
>> +	.stop		= rproc_tee_stop,
>> +	.load		= rproc_tee_load_fw,
>> +	.parse_fw	= rproc_tee_parse_fw,
>> +	.find_loaded_rsc_table = rproc_tee_find_loaded_rsc_table,
>> +	.release_fw	= rproc_tee_release_fw,
>> +};
>> +
>> +static const struct tee_client_device_id rproc_tee_id_table[] = {
>> +	{UUID_INIT(0x80a4c275, 0x0a47, 0x4905, 0x82, 0x85, 0x14, 0x86, 0xa9, 0x77, 0x1a, 0x08)},
>> +	{ /* sentinel */ }
>> +};
>> +
>> +/**
>> + * rproc_tee_register() - Register a remote processor controlled by the TEE application.
>> + * @dev: Pointer to client rproc device
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + * @rproc_id: ID of the remote processor
>> + * @auto_boot: flag to indicate if remote processor should be auto-started
>> + *
>> + * This function registers a remote processor that will be managed by a TEE
>> + * application, by opening a session with the TEE client.
>> + *
>> + * Return: Returns 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_register(struct device *dev, struct rproc **rproc,
>> +		       unsigned int rproc_id, bool auto_boot)
>> +{
>> +	struct tee_param param[MAX_TEE_PARAM_ARRAY_MEMBER];
>> +	struct tee_ioctl_open_session_arg sess_arg;
>> +	struct device_node *np = dev->of_node;
>> +	struct tee_client_device *tee_device;
>> +	struct rproc *new_rproc;
>> +	struct rproc_tee *trproc;
>> +	const char *fw_name;
>> +	int ret;
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!rproc_tee_ctx.dev) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	trproc = kzalloc(sizeof(*trproc), GFP_KERNEL);
>> +	if (!trproc) {
>> +		ret = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	/* Look for an optional firmware name */
>> +	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
>> +	if (ret < 0 && ret != -EINVAL)
>> +		goto free_tproc;
>> +
>> +	new_rproc = rproc_alloc(dev, np->name, &rproc_tee_default_ops,
>> +				fw_name, sizeof(*trproc));
>> +	if (!new_rproc) {
>> +		ret = -ENOMEM;
>> +		goto free_tproc;
>> +	}
>> +
>> +	tee_device = to_tee_client_device(rproc_tee_ctx.dev);
>> +	memset(&sess_arg, 0, sizeof(sess_arg));
>> +
>> +	memcpy(sess_arg.uuid, tee_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
>> +
>> +	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
>> +	sess_arg.num_params = 1;
>> +
>> +	param[0] = (struct tee_param) {
>> +		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>> +		.u.value.a = rproc_id,
>> +	};
>> +
>> +	ret = tee_client_open_session(rproc_tee_ctx.tee_ctx, &sess_arg, param);
>> +	if (ret < 0 || sess_arg.ret != 0) {
>> +		dev_err(dev, "tee_client_open_session failed, err: %#x\n", sess_arg.ret);
>> +		ret = -EINVAL;
>> +		goto free_rproc;
>> +	}
>> +
>> +	trproc->rproc_id = rproc_id;
>> +	trproc->session_id = sess_arg.session;
>> +	new_rproc->auto_boot = auto_boot;
>> +
>> +	ret = rproc_add(new_rproc);
>> +	if (ret)
>> +		goto close_tee;
>> +
>> +	trproc->rproc = new_rproc;
>> +	*rproc = new_rproc;
>> +
>> +	list_add_tail(&trproc->node, &rproc_tee_ctx.rproc_list);
>> +
>> +	mutex_unlock(&ctx_lock);
>> +
>> +	return 0;
>> +
>> +close_tee:
>> +	if (tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id))
>> +		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed\n");
>> +free_rproc:
>> +	rproc_free(new_rproc);
>> +free_tproc:
>> +	kfree(trproc);
>> +out:
>> +	mutex_unlock(&ctx_lock);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_register);
>> +
>> +/**
>> + * rproc_tee_unregister - Unregister a remote processor controlled by the TEE
>> + *                        application.
>> + * @dev: Pointer to client rproc device
>> + * @rproc: Pointer to the struct rproc representing the remote processor
>> + *
>> + * This function unregisters a remote processor previously registered by the
>> + * rproc_tee_register() function.
>> + *
>> + * Return: Returns 0 on success, or an error code on failure
>> + */
>> +int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
>> +{
>> +	struct rproc_tee *trproc;
>> +	int ret;
>> +
>> +	if (!rproc_tee_ctx.dev) {
>> +		ret = -ENODEV;
>> +		return ret;
>> +	}
>> +
>> +	trproc = rproc_to_trproc(rproc);
>> +	if (!trproc) {
>> +		ret = -EINVAL;
>> +		return ret;
>> +	}
>> +
>> +	rproc_del(rproc);
>> +	rproc_free(rproc);
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = tee_client_close_session(rproc_tee_ctx.tee_ctx, trproc->session_id);
>> +	if (ret < 0)
>> +		dev_err(rproc_tee_ctx.dev, "tee_client_close_session failed, err: %#x\n", ret);
>> +	list_del(&trproc->node);
>> +	kfree(trproc);
>> +	mutex_unlock(&ctx_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(rproc_tee_unregister);
>> +
>> +static int rproc_tee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>> +{
>> +	/* Today we support only the OP-TEE, could be extend to other tees */
>> +	return (ver->impl_id == TEE_IMPL_ID_OPTEE);
>> +}
>> +
>> +static const struct of_device_id remoteproc_tee_of_match[] = {
>> +	{ .compatible = "rproc-service-80a4c275-0a47-4905-8285-1486a9771a08" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, remoteproc_tee_of_match);
> 
> You don't need to define this redundant table but instead...
> 
>> +
>> +static int rproc_tee_probe(struct device *dev)
>> +{
>> +	struct tee_context *tee_ctx;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	pr_err("%s %d", __func__, __LINE__);
>> +	np = of_find_compatible_node(NULL, NULL,
>> +				     remoteproc_tee_of_match[0].compatible);
> 
> ...you can get the UUID from device being passed here. With that you
> should be able to fetch device specific DT properties.

Yes that makes sense, if the compatible in DT is the UUID

Thanks,

Arnaud

> 
> -Sumit
> 
>> +	if (!np) {
>> +		dev_err(dev, "Device node not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* Open context with TEE driver */
>> +	tee_ctx = tee_client_open_context(NULL, rproc_tee_ctx_match, NULL, NULL);
>> +	if (IS_ERR(tee_ctx)) {
>> +		ret = PTR_ERR(tee_ctx);
>> +		goto put_node;
>> +	}
>> +
>> +	ret = mutex_lock_interruptible(&ctx_lock);
>> +	if (ret)
>> +		goto close_ctx;
>> +
>> +	rproc_tee_ctx.dev = dev;
>> +	rproc_tee_ctx.tee_ctx = tee_ctx;
>> +	INIT_LIST_HEAD(&rproc_tee_ctx.rproc_list);
>> +
>> +	mutex_unlock(&ctx_lock);
>> +
>> +	ret = device_add_of_node(dev, np);
>> +	if (ret)
>> +		goto clean_ctx;
>> +
>> +	ret = of_platform_populate(np, NULL, NULL, dev);
>> +	if (ret) {
>> +		dev_err(dev, "cannot populate node (%d)\n", ret);
>> +		goto clean_ctx;
>> +	}
>> +
>> +	return 0;
>> +
>> +clean_ctx:
>> +	mutex_lock(&ctx_lock);
>> +	rproc_tee_ctx.dev = NULL;
>> +	rproc_tee_ctx.tee_ctx = NULL;
>> +	mutex_unlock(&ctx_lock);
>> +
>> +close_ctx:
>> +	tee_client_close_context(tee_ctx);
>> +
>> +put_node:
>> +	of_node_put(np);
>> +	return ret;
>> +}
>> +
>> +static int rproc_tee_remove(struct device *dev)
>> +{
>> +	of_platform_depopulate(dev);
>> +
>> +	device_remove_of_node(dev);
>> +
>> +	mutex_lock(&ctx_lock);
>> +	tee_client_close_context(rproc_tee_ctx.tee_ctx);
>> +	rproc_tee_ctx.dev = NULL;
>> +	rproc_tee_ctx.tee_ctx = NULL;
>> +	mutex_unlock(&ctx_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +MODULE_DEVICE_TABLE(tee, rproc_tee_id_table);
>> +
>> +static struct tee_client_driver rproc_tee_fw_driver = {
>> +	.id_table	= rproc_tee_id_table,
>> +	.driver		= {
>> +		.name		= KBUILD_MODNAME,
>> +		.bus		= &tee_bus_type,
>> +		.probe		= rproc_tee_probe,
>> +		.remove		= rproc_tee_remove,
>> +	},
>> +};
>> +
>> +static int __init rproc_tee_fw_mod_init(void)
>> +{
>> +	return driver_register(&rproc_tee_fw_driver.driver);
>> +}
>> +
>> +static void __exit rproc_tee_fw_mod_exit(void)
>> +{
>> +	driver_unregister(&rproc_tee_fw_driver.driver);
>> +}
>> +
>> +module_init(rproc_tee_fw_mod_init);
>> +module_exit(rproc_tee_fw_mod_exit);
>> +
>> +MODULE_DESCRIPTION("remote processor TEE module");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/remoteproc_tee.h b/include/linux/remoteproc_tee.h
>> new file mode 100644
>> index 000000000000..33150cff7a5a
>> --- /dev/null
>> +++ b/include/linux/remoteproc_tee.h
>> @@ -0,0 +1,89 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright(c) 2025 STMicroelectronics
>> + */
>> +
>> +#ifndef REMOTEPROC_TEE_H
>> +#define REMOTEPROC_TEE_H
>> +
>> +#include <linux/tee_drv.h>
>> +#include <linux/firmware.h>
>> +#include <linux/remoteproc.h>
>> +
>> +#if IS_ENABLED(CONFIG_REMOTEPROC_TEE)
>> +
>> +int rproc_tee_register(struct device *dev, struct rproc **rproc,
>> +		       unsigned int rproc_id, bool auto_boot);
>> +int rproc_tee_unregister(struct device *dev, struct rproc *rproc);
>> +int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw);
>> +int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw);
>> +void rproc_tee_release_fw(struct rproc *rproc);
>> +struct resource_table *rproc_tee_find_loaded_rsc_table(struct rproc *rproc,
>> +						       const struct firmware *fw);
>> +int rproc_tee_start(struct rproc *rproc);
>> +int rproc_tee_stop(struct rproc *rproc);
>> +int rproc_tee_pa_to_da(struct rproc *rproc, phys_addr_t pa, size_t size, u64 *da);
>> +#else
>> +
>> +static inline int rproc_tee_register(struct device *dev, struct rproc **rproc,
>> +				     unsigned int rproc_id, bool auto_boot)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int rproc_tee_parse_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_unregister(struct device *dev, struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_load_fw(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_start(struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int rproc_tee_stop(struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void rproc_tee_release_fw(struct rproc *rproc)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +}
>> +
>> +static inline struct resource_table *
>> +rproc_tee_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *fw)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return NULL;
>> +}
>> +#endif /* CONFIG_REMOTEPROC_TEE */
>> +#endif /* REMOTEPROC_TEE_H */
>> -- 
>> 2.43.0
>>

