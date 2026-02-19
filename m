Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D02EEE9A04C
	for <op-tee@archiver.kernel.org>; Thu, 19 Feb 2026 07:52:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E517B438C0
	for <op-tee@archiver.kernel.org>; Thu, 19 Feb 2026 07:52:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=hKZfpUMl;
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2883143833
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Feb 2026 07:51:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ+1qh5YjlGjd8mOz7ULC45zCihj7emQppybuyl1dv9j7+tHEN6xYCw4P5le2iAcVUHyIDOT+ZQDZNEg/T4GHb0U/YSgVok4jY5/1NVpPpZB8kjN+Xv4gbrl0M0LxEFiBdWVnc2ceJkvSK2Coa2S7RzMnc2iCqDtY/DEFeXelTsgYbKwEv9rnrj4VggaYqe8nvimgvHCAXHSMs1bePtZ7bAskYkXS0xxy6sFpXs5Nq74gLzpVAgs+Mk4lIBRrsUUPWrcU5KgP+30e/tOtgjB4TknemCcVMww8o3hPoGwAaI2ybo2TztU0VBnnEP9AORtpNlJ7aiepmVbDwqTuo7x6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky8Ca+nZaqHt/yBIku833g6W9mruJMgIWKcDQ8slxPY=;
 b=ZQndicser67LTuH6Wrt16Cuh7SddItTzJr0H6DFYDrDE3t0djpJVesxOS559/17IXDVUGS0ssMXJ7Ctds8x4eoNzX08Ndi6gvN3iOHvPrkY55lWvLZ+wQOATxL3ncgq8KZjY76T8rimSwBAi/acGEuKu+uGakaip5HjykWTaF2SrOdXSOHmxjtq0jEd1nwZWvyVULzHVEY7iYnqlUANxHaNVsIi1/8+rFMWwUlqs/q4tTGCAC1XlvcmMRhEoUqnwYoe9EILhugs/VCphip3nVLA3QUM8umgtnsH2I1s64fFQNbzbrReeEcOCQTP6vt8MafBrfv14K9GUbzN/MpbY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky8Ca+nZaqHt/yBIku833g6W9mruJMgIWKcDQ8slxPY=;
 b=hKZfpUMlJKpuZanFuZNTZ4cmBwjBymDxQnzFZff36Yd2e0FEWgauV7btAqPq6AXwYIgoob7G1Ps9HuTa4GX8wRdGMWUWSDT8C/xGb+UPMLFI1GbFuC+EBDt8mBWnGyK47mCqVitogAWJI/S2eqvAxp8h7WZsRZTJ/gM8BW3/pWlbJ0u0WlLNlGw0A31R4Cep+E/wS1g93F/1vgUIeDNkt4EGVg9H+xWbrFLDFqbE3NGWJIclBugin17hxshu/h6Dzfcw7nCd7LenNqIQnjRjNUv3XuDomHboZtF/KHgoRiqXuWSHc8bju5tbKn3XBP/zLAnQJxzDy0+gie3sgq7Jxg==
Received: from DU7P195CA0018.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::18)
 by PA1PR10MB9179.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 07:51:38 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::1b) by DU7P195CA0018.outlook.office365.com
 (2603:10a6:10:54d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Thu,
 19 Feb 2026 07:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 19 Feb 2026 07:51:38 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 19 Feb
 2026 08:53:34 +0100
Received: from [10.48.87.127] (10.48.87.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 19 Feb
 2026 08:51:36 +0100
Message-ID: <7639bae5-045f-4d56-8bcb-cddcb4e3d87f@foss.st.com>
Date: Thu, 19 Feb 2026 08:51:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH v20 1/6] dt-bindings: firmware: Add TEE
 remoteproc service binding
To: Rob Herring <robh@kernel.org>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
 <20251229232530.GA2753472-robh@kernel.org> <aVOzHWmlJ-eneS-2@sumit-xelite>
 <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
 <aVtqITUxy--E8HJt@sumit-xelite>
 <49f1808d-1e08-4f47-ac3a-5f2274086060@foss.st.com>
 <a17c017a-15f5-4ebc-9dd0-baab718dbe0a@foss.st.com>
 <aYrMp9wqk91-tQXn@sumit-xelite>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <aYrMp9wqk91-tQXn@sumit-xelite>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|PA1PR10MB9179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b3e4717-495e-40c7-954f-08de6f8bb634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?V0wza1JaVEdTQlJFejlqK3hmN1RlS1VzTS9Fb2JudnNaQVBaem0wSWkvdy91?=
 =?utf-8?B?K0pTejV0OVY1RTJXYVpVQ3RxVUdkTU90S0JtcVMrWnFaeXY1NWlWRVNZUTVv?=
 =?utf-8?B?M1RVZXNZZUJlODJ4WDRCeEVlYXpXbktTU3JVSVBrTVd4MWd0TlJPdFZ0Q2xJ?=
 =?utf-8?B?TmdWejc5djFIeVpGdm9nQ3ZlN2xpWVdzaDY4UVdjRVgwQ0FZc0pOMmRWb0d1?=
 =?utf-8?B?Q2hIZW5oSitxblJrSmIwSnJibGllcWpDbUxBU01UWDZTSTBKVHJXTEZSWmVk?=
 =?utf-8?B?T2lTSnllZVlxVUJoMlYwZEE5OFNaM0xBMFFDZDBPZ0syb21wd1crTlh6RXBw?=
 =?utf-8?B?Z3F6NWxjQnNqWWgrME1OTW52ajkxd2NYeW85MWIranJCSjVOamR2S2E3d0hO?=
 =?utf-8?B?dkExRjVsREIra28zYzlDcy9hZWNJb2pqWldnUDY3cXlWOWsvWDVqRW1rdmJG?=
 =?utf-8?B?cjRFa1BTL0Z2Z2U2NVZwT1pBQzR2TzY4cG0yRWpZN0J4cWpUWDZpaVRuY1JT?=
 =?utf-8?B?MVV6Z0Y1WXdwdUFkbmRVYmd5TWtIazJpdmc4WkxhaWwxbC9TMGVzbnhnMktO?=
 =?utf-8?B?c2ppczk0bTczVklXK0dCU3dYbkRoTXhaTlhWV1RDUlZzT0RhS3BLbHZpYk93?=
 =?utf-8?B?ZDNuS0pBM0FTRjBvcFVWSGdqVXY3MnE4M2pSNnJkSWtuNkRlV0UzMGJyRnA4?=
 =?utf-8?B?ajJZRW9SVUxxdXZBdkEvWS9wWXdjOEtYZzhsd0V3eGJ2emxnb1dqTEo5ckE2?=
 =?utf-8?B?MHpNaDV3RkxwL0ZORUVKbkQ4TG9nbDN2ZFR3eXdyQnVqQ2hCOFdNL2RBUWJU?=
 =?utf-8?B?SVp0Q3lLNE9qc1ZpdXRLZFZNSUdsWUpUQ2hYaFFIOE85dEVLbU5qU3JLU3VJ?=
 =?utf-8?B?dmdQV2xKbGlxcE5WZ25FMWNmZ0F1TlNpb1JhL09JOENaaWI5Sm42TWxKZ0lS?=
 =?utf-8?B?WTVYOC8vRXlLa2JreGwzdHpsWkJ5U3JXK2Z4MlNVR0F1aUtVMG1Gclc0Zk5y?=
 =?utf-8?B?NW95ZDBWTkZ1R3J5K3NJaW9URFh2VllsaHp0ditId2JrWGw1YXZiRmh6bTBx?=
 =?utf-8?B?cENJZW1zN25XTDVIbC9LZ3AraGN0NmRGVFZrVVQ5blBaOUJIQ3BIWnl2c0NW?=
 =?utf-8?B?dFc0RFBaSnI0emVGYUROK0FrcVNkc3ord1VqZ0YzcnBmK1o3QVY5R1diY1pn?=
 =?utf-8?B?M0IwQlE1WmhzOHF4L2VOSDBSWGFzMmhWcFREb3Zsb1VpVHlFRmZOUEkvbm02?=
 =?utf-8?B?dGI2eEhHME1xS2VCUmZUVjZzMXN4MFNxeW5IczJ5bVR0MHp5TkZvbmNROE9U?=
 =?utf-8?B?eXE3ajl0Q2ZUOEl3c2drcFpkT2krMW44MG0zQU05WHo4UkQrUkFMWWNuS21z?=
 =?utf-8?B?N0t6R2JIMHpPdmdUcHIvdVFTd2xvc3M0K2JpUCtObTRnSlRabGxBdXJ2cWVz?=
 =?utf-8?B?Z1djUzVaRk9CVHd5aVZRNERuOTQ0QkxmN2dMNE83RUZIOG1vTXE3V0V3dElM?=
 =?utf-8?B?dTB6QjFIcTQ1NkVuczQ2QjlGMHZNaFUxMTVBMjFsT0VhVWEwdFlJM3JBTktj?=
 =?utf-8?B?c3FNYjFNRU9HdXZMRXNFU3J1cjF1QjJVUElVSEU4bTl3U25hcUs5cmFHZzFF?=
 =?utf-8?B?MmwzY0thWm5iSDVuTms2SEdBWlhYdkdGakpTSHRsYi8rQUtuMVMxalpZTVRR?=
 =?utf-8?B?TEk5OHNpdlliaHBxMFl6USs0a3JrQkpsU3ZWSExyRnYvMDdETFFTNHVGOUZ6?=
 =?utf-8?B?MUdiSklWcFZaN3JrdWxhWkV0anlqV3ZBWk9aL0d0VGRIMVBxZUhXSXdmUGlJ?=
 =?utf-8?B?ZkluV1dreDBiK29ZNzNKdzJCbVFrSTNuUFpHRjJPdWM2anpvRXkvVXR5Uzd6?=
 =?utf-8?B?cytuWmhQTzJNc2puSy8rdFR1YWY0SXJ1bzZxREpuNnNJZG11YzVLNUVhOVg1?=
 =?utf-8?B?dGtCU3kwbHFzUGxNY3BoeEYyS2JJYnJuYU1NTlFhRzBSNXFhYktXWnV6Yndy?=
 =?utf-8?B?VDVmVmtkU2RmRmw5RlV6aVFqS1NkWHhsUFV6clFmZVpPcGRUcEtBaVN2YUU0?=
 =?utf-8?B?MmN4RHFEdGE5NWxRUU8zY1g5Q3ZHZ3lOYXlSdjNPUGlaMHhtb3RvUUtNTlRC?=
 =?utf-8?B?RW1xQXZGOEJUNGUrSEEvTzBDVFErL1VDT2QyeEE1VkhnR3BSRFNMNk9xYXpr?=
 =?utf-8?B?NFE2RHVHc0JtRmtndERrMGpKNTBqR3lKR1BuT0hGRGhuSUIyUFVucmlFQTl2?=
 =?utf-8?B?R216dU1sWm5wZ2h1Rzg0amtqcm1BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	/qHmgWioz0gPklVYeoUlobyvOV4KTKN9jl68PoyGuuX0r7m3SUDhkwagoNGPUEqEIwjyQnZi3rI6UkLVIT2dODrREof+5cxee0qvXuX+CGU8mD4oeq+oBpwH3fU4w0KEoaOJqctCT3n2oHzP3xkci+jjSsWO7reBfCWmNCsQqHmdgOCfi7lJAKPTRDbYiFCzPBz1qirRTWYCd3IT43P+eLFn6ZHdKuMNVp29HmO/wrqSKl0mUPPC3SycAbS0QmCwAG8wEPyxoRG1Pn5CaImUgs+V+mcmpmD02HcOMjzUUSlB4t/CINpmYGe+ItLeSjLAGoIKzIiY+or808W11xFxT2kj0j1ydW6dU5n1l4j+HhDeQFve+yL1XW+iAwvjVRCHh8j/g0GRNmKspBixXfbBvchy6C5bUax2ymJ9/s0RTnnkETWr2QRXOBNWUgcKZmON
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 07:51:38.0087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b3e4717-495e-40c7-954f-08de6f8bb634
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9179
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.50 / 15.00];
	URL_BACKSLASH_PATH(4.00)[0.0.0.0];
	URL_NUMERIC_IP(3.00)[0.0.0.0];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.70.7:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.70.7:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2883143833
X-Spamd-Bar: +++
Message-ID-Hash: LIMQKSSRIEFOA7EEJAJWA6GOYMKABPCG
X-Message-ID-Hash: LIMQKSSRIEFOA7EEJAJWA6GOYMKABPCG
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LIMQKSSRIEFOA7EEJAJWA6GOYMKABPCG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
X-Spam: Yes

SGVsbG8gUm9iLA0KDQpDb3VsZCB5b3UgcHJvdmlkZSB5b3VyIGZlZWRiYWNrIG9uIG15IGRldmlj
ZSB0cmVlIChEVCkgcHJvcG9zYWwgYmVsb3cgDQpiZWZvcmUgSSBiZWdpbiBpbXBsZW1lbnRhdGlv
bj8gWW91ciBpbnB1dCB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLg0KDQpUaGFua3MgYW5k
IFJlZ2FyZHMsDQpBcm5hdWQNCg0KT24gMi8xMC8yNiAwNzoxMywgU3VtaXQgR2FyZyB3cm90ZToN
Cj4gSGkgQXJuYXVkLA0KPiANCj4gT24gVHVlLCBGZWIgMDMsIDIwMjYgYXQgMDg6NDI6MzRBTSAr
MDEwMCwgQXJuYXVkIFBPVUxJUVVFTiB3cm90ZToNCj4+DQo+PiBIZWxsbyBSb2IsIFN1bWl0LA0K
Pj4NCj4+IEp1c3QgYSBnZW50bGUgcmVtaW5kZXIuIENvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB5
b3VyIGFkdmljZSBvciBhIGNvbmNsdXNpb24NCj4+IG9uIHRoZSBkaXJlY3Rpb24gd2Ugc2hvdWxk
IHRha2UgZm9yIHRoZSBEVCBkZWNsYXJhdGlvbj8gSSBuZWVkIHlvdXIgaW5wdXQgdG8NCj4+IGJl
IGFibGUgdG8gbW92ZSBmb3J3YXJkLg0KPj4NCj4+IFRoYW5rcyBhbmQgcmVnYXJkcywNCj4+IEFy
bmF1ZA0KPj4NCj4+IE9uIDEvMTMvMjYgMTA6MjAsIEFybmF1ZCBQT1VMSVFVRU4gd3JvdGU6DQo+
Pj4gSGVsbG8sDQo+Pj4NCj4+PiBPbiAxLzUvMjYgMDg6MzcsIFN1bWl0IEdhcmcgd3JvdGU6DQo+
Pj4+IE9uIEZyaSwgSmFuIDAyLCAyMDI2IGF0IDA0OjE3OjI3UE0gLTA2MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPj4+Pj4gT24gVHVlLCBEZWMgMzAsIDIwMjUgYXQgNToxMOKAr0FNIFN1bWl0IEdh
cmcNCj4+Pj4+IDxzdW1pdC5nYXJnQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4g
T24gTW9uLCBEZWMgMjksIDIwMjUgYXQgMDU6MjU6MzBQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+Pj4+Pj4+IE9uIFdlZCwgRGVjIDE3LCAyMDI1IGF0IDA0OjM5OjEyUE0gKzAxMDAsIEFy
bmF1ZCBQb3VsaXF1ZW4gd3JvdGU6DQo+Pj4+Pj4+PiBBZGQgYSBkZXZpY2UgdHJlZSBiaW5kaW5n
IGZvciB0aGUgVEVFLWJhc2VkIHJlbW90ZSBwcm9jZXNzb3IgY29udHJvbA0KPj4+Pj4+Pj4gc2Vy
dmljZSBpbXBsZW1lbnRlZCBhcyBhbiBPUC1URUUgVHJ1c3RlZCBBcHBsaWNhdGlvbiBpZGVudGlm
aWVkIGJ5DQo+Pj4+Pj4+PiBVVUlEIDgwYTRjMjc1LTBhNDctNDkwNS04Mjg1LTE0ODZhOTc3MWEw
OC4NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBUaGUgVEVFIHNlcnZpY2Ugbm9kZSBpcyBhIGNoaWxkIG9m
IHRoZQ0KPj4+Pj4+Pj4gImxpbmFybyxvcHRlZS10eiIgZmlybXdhcmUgbm9kZSBhbmQNCj4+Pj4+
Pj4+IGFjdHMgYXMgYSBjb250YWluZXIgZm9yIHJlbW90ZXByb2MgZGV2aWNlcyB0aGF0IGFyZQ0K
Pj4+Pj4+Pj4gY29udHJvbGxlZCB2aWEgVEVFLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBJcyB0aGlzIGdl
bmVyaWMgZm9yIGFueSByZW1vdGVwcm9jIGRldmljZSBvciBqdXN0IFNUJ3MNCj4+Pj4+Pj4gcmVt
b3RlcHJvYy4gTG9va3MNCj4+Pj4+Pj4gbGlrZSB0aGUgbGF0dGVyIHRvIG1lLg0KPj4+Pj4+DQo+
Pj4+Pj4gVGhhdCdzIHRydWUsIHRoZSBEVCBkZXNjcmlwdGlvbiBvZiB0aGUgcmVtb3RlcHJvYyBz
dWJub2RlIGlzIHZlcnkNCj4+Pj4+PiBzcGVjaWZpYyB0byB0aGUgdmVuZG9yIHdoaWNoIGluIHRo
aXMgY2FzZSBpcyBTVC4NCj4+Pj4+Pg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4gSW4gYWRkaXRpb24sIHRo
ZSAibGluYXJvLG9wdGVlLXR6IiBiaW5kaW5nIGlzIHVwZGF0ZWQgdG8gc3BlY2lmeSB0aGUNCj4+
Pj4+Pj4+ICcjYWRkcmVzcy1jZWxscycgYW5kICcjc2l6ZS1jZWxscycgdmFsdWVzIHVzZWQgZm9y
IGNoaWxkIFRFRSBzZXJ2aWNlDQo+Pj4+Pj4+PiBub2Rlcy4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSSdt
IHByZXR0eSBzdXJlIEkgYWxyZWFkeSByZWplY3RlZCBwZXIgc2VydmljZS9hcHAgY2hpbGQgbm9k
ZXMgZm9yDQo+Pj4+Pj4+IE9QLVRFRSB3aGVuIGl0cyBiaW5kaW5nIHdhcyBzdWJtaXR0ZWQuDQo+
Pj4+Pj4NCj4+Pj4+PiBUaGF0IHdhcyB0aGUgcmVhc29uIHRvIGhhdmUgZGlzY292ZXJhYmxlIFRF
RSBidXMgaW4gZmlyc3QgcGxhY2UgYW5kIEkNCj4+Pj4+PiBoYXZlIGJlZW4gbW90aXZhdGluZyBw
ZW9wbGUgdG8gZHluYW1pY2FsbHkgZGlzY292ZXIgZmlybXdhcmUgcHJvcGVydGllcw0KPj4+Pj4+
IHJhdGhlciB0aGFuIGhhcmRjb2RpbmcgaW4gdGhlIERULg0KPj4+Pj4+DQo+Pj4+Pj4+IElmIHdl
IGRvIG5lZWQgc29tZXRoaW5nIGluIERUDQo+Pj4+Pj4+IHRvIGRlZmluZSBzb21lIHJlc291cmNl
cywgdGhlbiBjYW4ndCB3ZSBoYXZlIHNvbWUgc29ydCBvZg0KPj4+Pj4+PiBzdGFuZGFyZC9jb21t
b24gY29tbXVuaWNhdGlvbnMgY2hhbm5lbD8gSSBkb24ndCBjYXJlIHRvDQo+Pj4+Pj4+IHNlZSBz
b21lIHNvcnQgb2YNCj4+Pj4+Pj4gZnJlZS1mb3ItYWxsIHdoZXJlIHdlIGhhdmUgZXZlcnkgdmVu
ZG9yIGRvaW5nIHRoZWlyIG93biB0aGluZy4gT1AtVEVFDQo+Pj4+Pj4+IG5lZWRzIHRvIHN0YW5k
YXJpemUgdGhpcy4NCj4+Pj4+Pg0KPj4+Pj4+IEkgc3VwcG9zZSB0aGlzIHJlcXVpcmVzIGEgd2lk
ZXIgc2NvcGUgd29yayBhcyB5b3UgY2FuIHNlZQ0KPj4+Pj4+IHRoZSBEVCByZXNvdXJjZQ0KPj4+
Pj4+IGRlcGVuZGVuY2UgZnJvbSBoZXJlIFsxXS4gQnkgc3RhbmRhcmRpemUgY29tbXVuaWNhdGlv
biBjaGFubmVsLCBkbyB5b3UNCj4+Pj4+PiBtZWFuIHRvIHNheSBpZiBhZGRpbmcgYW4gYWx0ZXJu
YXRpdmUgYmFja2VuZCB0byBmd25vZGUgZm9yIFRFRSBpbg0KPj4+Pj4+IHBhcmFsbGVsIHRvIERU
LCBBQ1BJIG9yIHN3bm9kZSBpcyB0aGUgd2F5IHRvIGdvIGZvciBkaXNjb3ZlcmluZyBmdw0KPj4+
Pj4+IHByb3BlcnRpZXM/DQo+Pj4+Pg0KPj4+Pj4gTm8sIG5vdCBhdCBhbGwuDQo+Pj4+Pg0KPj4+
Pj4+IE9yIGRvIHlvdSBoYXZlIGFueSBvdGhlciBzdWdnZXN0aW9uIGhlcmU/DQo+Pj4+Pg0KPj4+
Pj4gV2hhdCBJIG1lYW4gaXMgd2h5IGRvZXNuJ3QgdGhlIFRFRSBkZWZpbmUgdGhlIGNvbW11bmlj
YXRpb24gY2hhbm5lbA0KPj4+Pj4gKG1haWxib3grc2htZW0gYW5kIG5vdGlmaWNhdGlvbiBpbnRl
cnJ1cHQpIHJhdGhlciB0aGFuIGVhY2ggVEVFIGFwcD8NCj4+Pj4NCj4+Pj4gVGhlIHN5bmNocm9u
b3VzIGNvbW11bmljYXRpb24gY2hhbm5lbCBpcyBhbHJlYWR5IHRoZXJlIGZvciBlYWNoIFRFRSBh
cHANCj4+Pj4gYmFzZWQgb24gKGludm9rZSBjb21tYW5kcyArIFRFRSBzaGFyZWQgbWVtb3J5KS4g
T1AtVEVFIGRvZXMgc3VwcG9ydA0KPj4+PiBub3RpZmljYXRpb24gaW50ZXJydXB0cyB0b28gYnV0
IHRob3NlIGhhdmVuJ3QgYmVlbiBleHBvc2VkIHRvIFRFRSBjbGllbnQNCj4+Pj4gZHJpdmVycyB5
ZXQuIEkgc3VwcG9zZSB0aGlzIHJlbW90ZXByb2MgdXNlLWNhc2UgY2FuIGJlIGEgZ29vZCBleGFt
cGxlIHRvDQo+Pj4+IGV4cG9zZSB0aGF0IGFzIGEgZ2VuZXJpYyBURUUgbm90aWZpY2F0aW9uIGlu
dGVyZmFjZSB0b28uDQo+Pj4NCj4+PiBJbiB0aGUgU1RNMzJNUCBzZXJpZXMsIHRoZSBtYWlsYm94
ZXMgYW5kIHNoYXJlZCBSQU0gYXJlIHVzZWQgZm9yIFJQTXNnDQo+Pj4gY29tbXVuaWNhdGlvbiBi
ZXR3ZWVuIExpbnV4IGFuZCB0aGUgcmVtb3RlIHByb2Nlc3Nvci4gTXkgY29uY2VybiBpcyB0aGF0
DQo+Pj4gdXNpbmcgbm90aWZpY2F0aW9uIGluIE9QLVRFRSBjb3VsZCBpbXBhY3QgcGVyZm9ybWFu
Y2UgYnkgaW50cm9kdWNpbmcNCj4+PiBsYXRlbmN5LiBBZGRpdGlvbmFsbHksIHRoaXMgbWlnaHQg
cmVxdWlyZSBhIERNQSBhbGxvY2F0b3IgaW4gT1AtVEVFIHRvDQo+Pj4gbWFuYWdlIHRoZSBzaGFy
ZWQgbWVtb3J5LiBPbmUgUlBNc2cgdmlydGlvIHJlcXVpcmVzIHRoZSBkZWNsYXJhdGlvbiBvZg0K
Pj4+IGF0IGxlYXN0IHRocmVlIGNhcnZlb3V0cy4gTWFuYWdpbmcgdGhlc2UgYXMgbWVtb3J5IHJl
Z2lvbnMgaW4gT1AtVEVFDQo+Pj4gd291bGQgYmUgY29tcGxleCAoZHVlIHRvIGxpbWl0ZWQgbnVt
YmVyIG9mIG1lbW9yeSBhcmVhIGRlY2xhcmF0aW9uIG9uDQo+Pj4gU1RNMzJNUDIpLg0KPj4+Pg0K
Pj4+Pj4NCj4+Pj4+IE1vcmUgZ2VuZXJhbGx5LCBpcyBoYXZpbmcgVEVFIGFwcHMgZGVwZW5kaW5n
IG9uIHJhbmRvbSBEVCByZXNvdXJjZXMNCj4+Pj4+IHJlYWxseSBhIGJveCB3ZSB3YW50IHRvIG9w
ZW4/IElzIHRoZSBuZXh0IHRoaW5nIGdvaW5nIHRvIGJlIGEgVEVFDQo+Pj4+PiBjbG9jay9yZXNl
dC9ncGlvL3Bvd2VyIHByb3ZpZGVyPyBXaGVyZSBkbyB3ZSBkcmF3IHRoZSBsaW5lPw0KPj4+Pg0K
Pj4+PiBUaGlzIGlzIHJlYWxseSBhIGhhcmQgbGluZSB0byBkcmF3IHNpbmNlIHNpbGljb24vT0VN
IHZlbmRvcnMgYmFzZWQNCj4+Pj4gb24gdGhlaXINCj4+Pj4gaGFyZHdhcmUgc2VjdXJpdHkgYXJj
aGl0ZWN0dXJlIHBhcnRpdGlvbiB2YXJpb3VzIHJlc291cmNlcyBhbW9uZyBURUUgYW5kDQo+Pj4+
IHRoZSBMaW51eCB3b3JsZC4gQW5kIG9uZSBnZW5lcmFsIHByaW5jaXBsZSB3ZSB0cnkgdG8gZm9s
bG93IGZvciB0aGUgVEVFDQo+Pj4+IGlzIHRvIGtlZXAgaXQncyBUcnVzdGVkIENvbXB1dGluZyBC
YXNlIChUQ0IpIHRvIGEgbWluaW1hbCB0b28uDQo+Pj4+DQo+Pj4+IElNSE8sIGlmIHRoZSB0aHJl
YXQgbW9kZWwgaXMgd2VsbCB1bmRlcnN0b29kIHRoZW4gd2Ugc2hvdWxkIGFsbG93IGZvcg0KPj4+
PiB0aGlzIGhldHJvZ2Vub3VzIHBhcnRpdGlvbmluZyBvZiBzeXN0ZW0gcmVzb3VyY2VzLg0KPj4+
DQo+Pj4gSGVyZSBhcmUgc29tZSBhZGRpdGlvbmFsIHJlc291cmNlcyB3ZSBuZWVkIHRvIG1hbmFn
ZSB0aGUgcmVtb3RlDQo+Pj4gcHJvY2Vzc29yLCB3aGljaCBzZWVtIGNvbXBsZXggdG8gaGFuZGxl
IHdpdGhvdXQgRGV2aWNlIFRyZWUgKERUKToNCj4+Pg0KPj4+IC0gQ2xvY2tzOiBPbiBTVE0zMk1Q
LCB3ZSBtYW5hZ2UgY2xvY2tzIHRocm91Z2ggdGhlIE9QLVRFRSBTQ01JIHNlcnZpY2UNCj4+PiAg
IMKgIFsxXS4gVGhlIFNDTUkgT1AtVEVFIGNsb2NrL3Jlc2V0IHNlcnZpY2UgYWxyZWFkeSBleGlz
dHMgYW5kIHNob3VsZCBiZQ0KPj4+ICAgwqAgcmV1c2VkLg0KPj4+IC0gUG93ZXIgZG9tYWlucw0K
Pj4+IC0gUmVtb3RlcHJvYyBXYXRjaGRvZyBpbnRlcnJ1cHQ6IENhbm5vdCBiZSBjYXVnaHQgYnkg
T1AtVEVFIG9uDQo+Pj4gICDCoCBzdG0zMm1wMTUuDQo+Pj4gLSBHcmFjZWZ1bCBzaHV0ZG93biBv
ZiB0aGUgcmVtb3RlIHByb2Nlc3NvcjogVGhpcyBpbnZvbHZlcyBzZW5kaW5nIGENCj4+PiAgIMKg
IG1haWxib3ggbm90aWZpY2F0aW9uIHRvIHJlcXVlc3Qgc2h1dGRvd24gYW5kIHdhaXRpbmcgdXAg
dG8gNTAwIG1zIGZvcg0KPj4+ICAgwqAgdGhlIHJlbW90ZXByb2MgdG8gZGVpbml0aWFsaXplIGl0
cyByZXNvdXJjZXMuIFdhaXRpbmcgdGhpcyBsb25nIGluIHRoZQ0KPj4+ICAgwqAgc2VjdXJlIGNv
bnRleHQgc2VlbXMgaW5lZmZpY2llbnQuDQo+Pj4gLSBjb21wYXRpYmlsaXR5IHdpdGggc29tZSBj
b21pbmcgSVBDIG1lY2hhbmlzbXM6IFN1Y2ggYXMgcnBtc2dfSTJDIG9yDQo+Pj4gICDCoCB2aXJ0
aW8tbXNnIG1pZ2h0IHJlcXVpcmUgcmVtb3RlcHJvYyBzdWJub2RlIGRlc2NyaXB0aW9ucyBpbiB0
aGUNCj4+PiAgIMKgIGZ1dHVyZS4NCj4+Pg0KPj4+IElmIHRoZSBwcm9wb3NlZCB0b3BvbG9neSBk
b2VzIG5vdCBnYWluIGNvbnNlbnN1cywgd2hhdCBhYm91dCBhbg0KPj4+IGFsdGVybmF0aXZlIGFw
cHJvYWNoIHRoYXQgbWFuYWdlcyB0aGUgcmVtb3RlcHJvYyBURUUgc2ltaWxhcmx5IHRvIFNDTUks
DQo+Pj4gYnkgaW50cm9kdWNpbmcgYSByZW1vdGVwcm9jLWJhY2tlbmQgd2l0aCB0aGUgcHJvYyBJ
RCBhcyBhIHBhcmFtZXRlcj8NCj4+Pg0KPj4+DQo+Pj4gJmZpcm13YXJlIHsNCj4+PiAgIMKgwqDC
oCBvcHRlZTogb3B0ZWUgew0KPj4+ICAgwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJsaW5h
cm8sb3B0ZWUtdHoiOw0KPj4+ICAgwqDCoMKgwqDCoMKgwqAgbWV0aG9kID0gInNtYyI7DQo+Pj4g
ICDCoMKgwqDCoMKgwqDCoCBzcHJvYzogc3Byb2Mgew0KPj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb21wYXRpYmxlID0gIjgwYTRjMjc1LTBhNDctNDkwNS04Mjg1LTE0ODZhOTc3MWEwOCI7
DQo+Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4+
ICAgwqDCoMKgwqDCoMKgwqAgI3NpemUtY2VsbHMgPSA8MD47DQo+Pj4gICDCoMKgwqDCoMKgwqDC
oCB9Ow0KPj4+ICAgwqDCoMKgIH07DQo+Pj4gfTsNCj4+Pg0KPj4+IHJwcm9jMTogbTMzQDAgew0K
Pj4+ICAgwqAgWy4uLl0NCj4+Pg0KPj4+ICAgwqAgcmVtb3RlcHJvYy1iYWNrZW5kID0gPCAmc3By
b2MgMD4NCj4+PiB9Ow0KPj4+DQo+Pj4NCj4+PiBycHJvYzI6IG0wQDAgew0KPj4+ICAgwqAgWy4u
Ll0NCj4+Pg0KPj4+ICAgwqAgcmVtb3RlcHJvYy1iYWNrZW5kID0gPCAmc3Byb2MgMT4NCj4+PiB9
Ow0KPiANCj4gVXNpbmcgYSBwaGFuZGxlIGxpa2UgdGhpcyBtYWtlcyBpdCBhIGJpdCBtb3JlIGNs
ZWFuZXIgYnV0IEkgd291bGQgZGVmZXINCj4gdG8gUm9iIHNpbmNlIGhlIGhhcyB0aGUgZmluYWwg
c2F5IGhlcmUuDQo+IA0KPiAtU3VtaXQNCj4gDQo+Pj4NCj4+Pg0KPj4+IFsxXWh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE4LjQvc291cmNlL2RyaXZlcnMvY2xrL2Nsay1zY21p
LmMNCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBBcm5hdWQNCj4+Pg0KPj4+Pg0KPj4+PiAtU3VtaXQN
Cj4+Pg0KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+Pj4gTGludXgtc3RtMzIgbWFpbGluZyBsaXN0DQo+Pj4gTGludXgtc3RtMzJAc3QtbWQtbWFp
bG1hbi5zdG9ybXJlcGx5LmNvbQ0KPj4+IGh0dHBzOi8vc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5
LmNvbS9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXN0bTMyDQo+Pg0KDQo=
