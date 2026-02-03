Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B14E8305C
	for <op-tee@archiver.kernel.org>; Tue,  3 Feb 2026 07:43:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8953243722
	for <op-tee@archiver.kernel.org>; Tue,  3 Feb 2026 07:43:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=A34NOF/3;
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011063.outbound.protection.outlook.com [52.101.65.63])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 709C541B9B
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Feb 2026 07:42:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSyUvZsirIOJ0wQXCEih3QILpvMV3cMYBpG7Xh4H+fi9euDhiQWEFbKbkaCfmlYkNfe0vEp5WxkBooBWu4Lp0QgC8+rqrsBmFQnWkyVJ7jbeoZVTE20IT5Ufcs5nrQ69ahiymN8z3dOiMUzGOhTet0E2mF1lTfQ4H1Qb1cBeonZ7M77PrE33ID+89v0hIeALLvgZH55TscoxSkgKRC1ZVoC2uM/WGArUq1xby7VMAFZ0rpmmIWcaazeN5AOpKKnG1TRtYyZ8hP2rybF3X4wlxVxYTNmOoRzAgPqnQnPlQsCII3mhA4ql5iWAdE/PW/EHpxVyX2HQS+l7FEZW/4i8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjwvWtHAFtaI/Xpqg9QGqz2wBbxFJWLTn36wZzoBzdA=;
 b=gtaT29TYRu+zhvm+fdKitrVVKcGrxrS5ltIueaHegVPAWdHAxbZMrZX5A6OhZiXhZREn97osAtLFF722P7pzxH9NGKEfeGZb71TjrqiROFQMF+RZnk2Sv7gxS5c+CUZiiFTnruBrLQTivTVoQpPXDTKnr/YoW7ZBOCCedv/i6fVcMd8sg7FATs8Htxe36LxM1Rp0JJANm5BttZ8wDByeUz3zl7kZAu/nZX1DPMihVUXJuha1iYvHmOAnlPoxSEIDO3TTeoJSBLKkEY4F56uPTWNLMxC2KFFUW0jt4wHQBlPexdnlk9/1TrBDR4XSn4S2uey97N+UI1UmWezMYrOkAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjwvWtHAFtaI/Xpqg9QGqz2wBbxFJWLTn36wZzoBzdA=;
 b=A34NOF/3cxBNUT83bRFp6DGRoxbXZFH5UZN5B9QwWTnkQK2cecN0w4b9spjYsbgthn26oon7oIiGe65AH1BoezLXk9ZIYL402JkZYzjSlknGy7jl0MI17wFir7HryViTQN+R/KJ4vN62YpNExYSzPvUaGG7rgCKGvcROGbiJ7R2jJokriCufoCDa4ASltpWzT5bxYJ+A8prVUZNqloYBqBocy7jbGi9HbPC3KWAWBIQQbWFXjjSUySzgyDjIaD7Ppa/CC4wqAC+1h3DlqQGXuT/6IaHRXnygV3WK/1KWCxOAE4eM6acVmpletswFQLjABYaIUPG+2/aA89KhvgFd+Q==
Received: from DU7P251CA0008.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:551::21)
 by AM0PR10MB3140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:42:37 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:551:cafe::47) by DU7P251CA0008.outlook.office365.com
 (2603:10a6:10:551::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:42:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:42:36 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 08:44:22 +0100
Received: from [10.252.26.182] (10.252.26.182) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 3 Feb
 2026 08:42:35 +0100
Message-ID: <a17c017a-15f5-4ebc-9dd0-baab718dbe0a@foss.st.com>
Date: Tue, 3 Feb 2026 08:42:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-stm32] [PATCH v20 1/6] dt-bindings: firmware: Add TEE
 remoteproc service binding
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: Sumit Garg <sumit.garg@kernel.org>, Rob Herring <robh@kernel.org>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
 <20251229232530.GA2753472-robh@kernel.org> <aVOzHWmlJ-eneS-2@sumit-xelite>
 <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
 <aVtqITUxy--E8HJt@sumit-xelite>
 <49f1808d-1e08-4f47-ac3a-5f2274086060@foss.st.com>
Content-Language: en-US
In-Reply-To: <49f1808d-1e08-4f47-ac3a-5f2274086060@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.252.26.182]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|AM0PR10MB3140:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe294ef-2333-4df3-8e7c-08de62f7ccf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlovdUp4aVdVOUQ1YmpzZHBBWnJFdlVUOEgwSHVocTRtMnNIWDV4S1YzK0tF?=
 =?utf-8?B?N081UUI0NGpqL1BBSXZYL01JRStwdFM5cWJVSC9DQ05IeDFncDRsQUplR0c0?=
 =?utf-8?B?ZCsyT1g5QWVsZGdRODR5N24wM3hvQmhDNENCbFNWVS9zSkdzT1NHSlZjZnN0?=
 =?utf-8?B?YUJWK3ViOXBvZGJESjdWSnM0ajlVRGZ3cFRTRUNvdXJ0ajV0dWNTRUd5bEFJ?=
 =?utf-8?B?cUJNZVErTm5Rb0t0aGpGODZSQjJBYmJxSk9MVHFXVWg2ZVBpOW9PYkNGbDBR?=
 =?utf-8?B?T3N5Uzc1a0ZpSWJkeUVFaFVhZExxZ3d1VDVrbUZFU3hZYjRCTzRzdDZSeTA5?=
 =?utf-8?B?eitFM3JIQ0dUeEJqcXBJSXF6SDhhS0lSa1BHRS9wb0tHdS84RHlPM2VTR3I2?=
 =?utf-8?B?NjdQdXZhd2R5cHRJZkJXNTlYbEQ5Zm5LaXNuMm1WK2xHNGwzdkJsU0lGbFkz?=
 =?utf-8?B?RjVnQWh3UGRVSU9BZlhZU0thblo0anJ6Z0xsZDhPWkNYMkRBcGtZQnl0cVkv?=
 =?utf-8?B?M0R5VnpEK1NYSXpMZDYrWVhra1BTelAvQ2dKSzlvM053N1lIOExLWit3TGNY?=
 =?utf-8?B?U3l5OXdrczNoNTNkQVJGSndQUnhsbmxXQ2tkd2hMZHJvMytSa3hOcUJML3l6?=
 =?utf-8?B?dDh0SG1TVjh4MS9xZnY1aUIzQTdKWUZDWVhlQlFOSnRjdWdnV1J2djZBZnZj?=
 =?utf-8?B?YlVPSUxCSHd2ZXY5WHhrQ1FndW12aUYvUXlPS0FzUWJnMkJuNHRRRFRXMGtX?=
 =?utf-8?B?VmplR2JlU016ajFSNTlHeml6QnJwWncwVVl1ZGlWRDBLd1kzQS9rWUlEZk5V?=
 =?utf-8?B?U3d4RGxSTU1INktUczlyVVN6VzlrdzFMSUpjM1FaNEJzT2pIZVlWVkpmVXpv?=
 =?utf-8?B?dXJ3cjd3M0RENFYvS3JSREI2bFAwcGZkZ2owa0tTZnk2ZEZ6dlVFTjlEZ1BU?=
 =?utf-8?B?Y1paWEpxMGlkTDR6aXJwOVV1alYrV2hJMnpGOUMweGsyalB6Vmw1NU9lQUth?=
 =?utf-8?B?WEFYUm9vakZSK3ZZMTR3eUtsWHRISXVQMTlRbThDelVmU2xIc3JLdFpDTjhN?=
 =?utf-8?B?WXpvTWsya2pKbnVxMmFJS0RwemVFVzZVRjk5QlRiTit0cGVzNFNqVzY2OHlL?=
 =?utf-8?B?cWl2dnZ2cXVlQ3dYZEZIcmdJVWdKZlh0U1hlM1ptWWh2cGYwYWlYL2J1Q3NP?=
 =?utf-8?B?Qm5GZURWelRuTHpEdU1RUmExOG0yeG9nek45dVNHQUxFWkVpNlhiTFVXMlNZ?=
 =?utf-8?B?bWo1NUZRdlR3ZzNtd1d1Y2hEMGo4MlNCY0ord3J4SmpKcktwdDRxQk1NbEtO?=
 =?utf-8?B?R0owbFlGZUxaNm5vYlAyVmpxdUJwU3pYQkNxWEVIckJUNGRQWnQyNDBDRjlL?=
 =?utf-8?B?akIyMnRrQnNrY0NGNHpPTFExc0g5RFljekhHdE5Jb1BkVWZyTnlFTVA4Kys3?=
 =?utf-8?B?RWIvUDVkdUZRMUd6Q0VRZlF4dWtWUFZ5dnd5M1luWE9qOTh2VVlIWHFpbUIz?=
 =?utf-8?B?N1IxZWlybTlzaEdkWXFJT0ZKZGNhM0FYNjh6TWxBTm0zejZCYkFMa01ZMUU3?=
 =?utf-8?B?dlBROEIvZ3FHMnlGU1VCL1hSNXd3MjdlU2RPdjdCZ2JVUWlZdi9VZCtLcEpz?=
 =?utf-8?B?SnVZOGwwMHBuUHBUMUJINzZQaU1aYXIwSkQ3eUplenBKZ2dSUWVVd2lkZXRV?=
 =?utf-8?B?Yy9yMFhkL3AzRGRNL2lTSFRRc2YxVFZXcUMvMWJTL2xDWHRmQ0Riam1TT0tp?=
 =?utf-8?B?dnNwNnZKcUg0enZqd1BkWHBJQldMZ3ZLMFhDZi9RaUVqWFY3ZThoMWdxZ3k4?=
 =?utf-8?B?SVJVZEZLd0F1U0R3clhGUmk1V0I4TjdNUHNlc1N3c21UVUFRMWY0enNmL21E?=
 =?utf-8?B?aGllQ3VZTldhRkNBZWVjQkhtOFVqMDBKRmVSMTBhSWFLZjZ1bHdzams1Q2Zt?=
 =?utf-8?B?Z3E2ZXd3dTdtZXpRb21qSkI0V1prU0hnb1JhbUJZc0RNZUl4UmJYQmJ2cDFi?=
 =?utf-8?B?YmFsVmpnSGRLbDBoYjJhTVhzaHlXbEE4MzJyTlRIYVVnbHdJWGs1bWkyNmZZ?=
 =?utf-8?B?MWNGOEloMEZLVjJGb2dpVnd0blh2VloyeFViTkpQc1I0K1ZXK0VJaEx3bDB3?=
 =?utf-8?B?US9ib1dCa3gwWWxSck1WY3R3SHhnTmVXZVpxaEdkLzB4NE45NDd1M0cwU0Ft?=
 =?utf-8?Q?aBLzhkOYIv9QmaKYw9Lt908=3D?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	16a9bVpkzU7nUJWL2LepSini/6xwA2OdpnKgIKL6IYQ2n6sfp9vSWGnBqCxw8+zjkb5X3XnZCWwsDHf5M3G4vQdbJRtzs8Qwg9z+JREUwo2X0XXJug2rMDxbEg5KidwQCiP8xxVOOPpJd5wSHDjNYSNf+Ucceexi0p/wCC00wG0UgaWjv2wyQ5rntoJl5NmfKiseYY1t3ScNG+F4ILSuTRxhZGfTf5itUbAuq5F40ZvFntwcIJcgjipsAHngsXXVbM+q48FDG7qL4lga8+/Ylc7J8p3v5XLRZFGP543P6ZVmOg8tqJYlnLP/ymdvc6oUxJ6BSJzQ/V7tW8ha4rg2mYQnAAVr9crjzXdmFwPxGsLFR/adySnEJhxKLs+KEo9QPclC+5jJT0D3g5bgFNdI/1xO3ROwVcYdNUMkmE/siuSRjBU7dF9UN7mt6w8/rpfB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:42:36.7104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe294ef-2333-4df3-8e7c-08de62f7ccf5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3140
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.50 / 15.00];
	URL_BACKSLASH_PATH(4.00)[0.0.0.0];
	URL_NUMERIC_IP(3.00)[0.0.0.0];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[foss.st.com:+];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	NEURAL_SPAM(0.00)[0.029];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.65.63:from];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.65.63:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 709C541B9B
X-Spamd-Bar: +++
Message-ID-Hash: 4LWV4XJB4NQR5ONQFD5IQSMK6L5CPI66
X-Message-ID-Hash: 4LWV4XJB4NQR5ONQFD5IQSMK6L5CPI66
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Bjorn Andersson <andersson@kernel.org>, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, op-tee@lists.trustedfirmware.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4LWV4XJB4NQR5ONQFD5IQSMK6L5CPI66/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
X-Spam: Yes

DQpIZWxsbyBSb2IsIFN1bWl0LA0KDQpKdXN0IGEgZ2VudGxlIHJlbWluZGVyLiBDb3VsZCB5b3Ug
cGxlYXNlIHByb3ZpZGUgeW91ciBhZHZpY2Ugb3IgYSANCmNvbmNsdXNpb24gb24gdGhlIGRpcmVj
dGlvbiB3ZSBzaG91bGQgdGFrZSBmb3IgdGhlIERUIGRlY2xhcmF0aW9uPyBJIA0KbmVlZCB5b3Vy
IGlucHV0IHRvIGJlIGFibGUgdG8gbW92ZSBmb3J3YXJkLg0KDQpUaGFua3MgYW5kIHJlZ2FyZHMs
DQpBcm5hdWQNCg0KT24gMS8xMy8yNiAxMDoyMCwgQXJuYXVkIFBPVUxJUVVFTiB3cm90ZToNCj4g
SGVsbG8sDQo+IA0KPiBPbiAxLzUvMjYgMDg6MzcsIFN1bWl0IEdhcmcgd3JvdGU6DQo+PiBPbiBG
cmksIEphbiAwMiwgMjAyNiBhdCAwNDoxNzoyN1BNIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToN
Cj4+PiBPbiBUdWUsIERlYyAzMCwgMjAyNSBhdCA1OjEw4oCvQU0gU3VtaXQgR2FyZyA8c3VtaXQu
Z2FyZ0BrZXJuZWwub3JnPiANCj4+PiB3cm90ZToNCj4+Pj4NCj4+Pj4gT24gTW9uLCBEZWMgMjks
IDIwMjUgYXQgMDU6MjU6MzBQTSAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+Pj4+PiBPbiBX
ZWQsIERlYyAxNywgMjAyNSBhdCAwNDozOToxMlBNICswMTAwLCBBcm5hdWQgUG91bGlxdWVuIHdy
b3RlOg0KPj4+Pj4+IEFkZCBhIGRldmljZSB0cmVlIGJpbmRpbmcgZm9yIHRoZSBURUUtYmFzZWQg
cmVtb3RlIHByb2Nlc3NvciBjb250cm9sDQo+Pj4+Pj4gc2VydmljZSBpbXBsZW1lbnRlZCBhcyBh
biBPUC1URUUgVHJ1c3RlZCBBcHBsaWNhdGlvbiBpZGVudGlmaWVkIGJ5DQo+Pj4+Pj4gVVVJRCA4
MGE0YzI3NS0wYTQ3LTQ5MDUtODI4NS0xNDg2YTk3NzFhMDguDQo+Pj4+Pj4NCj4+Pj4+PiBUaGUg
VEVFIHNlcnZpY2Ugbm9kZSBpcyBhIGNoaWxkIG9mIHRoZSAibGluYXJvLG9wdGVlLXR6IiBmaXJt
d2FyZSANCj4+Pj4+PiBub2RlIGFuZA0KPj4+Pj4+IGFjdHMgYXMgYSBjb250YWluZXIgZm9yIHJl
bW90ZXByb2MgZGV2aWNlcyB0aGF0IGFyZSBjb250cm9sbGVkIHZpYSANCj4+Pj4+PiBURUUuDQo+
Pj4+Pg0KPj4+Pj4gSXMgdGhpcyBnZW5lcmljIGZvciBhbnkgcmVtb3RlcHJvYyBkZXZpY2Ugb3Ig
anVzdCBTVCdzIHJlbW90ZXByb2MuIA0KPj4+Pj4gTG9va3MNCj4+Pj4+IGxpa2UgdGhlIGxhdHRl
ciB0byBtZS4NCj4+Pj4NCj4+Pj4gVGhhdCdzIHRydWUsIHRoZSBEVCBkZXNjcmlwdGlvbiBvZiB0
aGUgcmVtb3RlcHJvYyBzdWJub2RlIGlzIHZlcnkNCj4+Pj4gc3BlY2lmaWMgdG8gdGhlIHZlbmRv
ciB3aGljaCBpbiB0aGlzIGNhc2UgaXMgU1QuDQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4+IEluIGFkZGl0
aW9uLCB0aGUgImxpbmFybyxvcHRlZS10eiIgYmluZGluZyBpcyB1cGRhdGVkIHRvIHNwZWNpZnkg
dGhlDQo+Pj4+Pj4gJyNhZGRyZXNzLWNlbGxzJyBhbmQgJyNzaXplLWNlbGxzJyB2YWx1ZXMgdXNl
ZCBmb3IgY2hpbGQgVEVFIHNlcnZpY2UNCj4+Pj4+PiBub2Rlcy4NCj4+Pj4+DQo+Pj4+PiBJJ20g
cHJldHR5IHN1cmUgSSBhbHJlYWR5IHJlamVjdGVkIHBlciBzZXJ2aWNlL2FwcCBjaGlsZCBub2Rl
cyBmb3INCj4+Pj4+IE9QLVRFRSB3aGVuIGl0cyBiaW5kaW5nIHdhcyBzdWJtaXR0ZWQuDQo+Pj4+
DQo+Pj4+IFRoYXQgd2FzIHRoZSByZWFzb24gdG8gaGF2ZSBkaXNjb3ZlcmFibGUgVEVFIGJ1cyBp
biBmaXJzdCBwbGFjZSBhbmQgSQ0KPj4+PiBoYXZlIGJlZW4gbW90aXZhdGluZyBwZW9wbGUgdG8g
ZHluYW1pY2FsbHkgZGlzY292ZXIgZmlybXdhcmUgcHJvcGVydGllcw0KPj4+PiByYXRoZXIgdGhh
biBoYXJkY29kaW5nIGluIHRoZSBEVC4NCj4+Pj4NCj4+Pj4+IElmIHdlIGRvIG5lZWQgc29tZXRo
aW5nIGluIERUDQo+Pj4+PiB0byBkZWZpbmUgc29tZSByZXNvdXJjZXMsIHRoZW4gY2FuJ3Qgd2Ug
aGF2ZSBzb21lIHNvcnQgb2YNCj4+Pj4+IHN0YW5kYXJkL2NvbW1vbiBjb21tdW5pY2F0aW9ucyBj
aGFubmVsPyBJIGRvbid0IGNhcmUgdG8gc2VlIHNvbWUgDQo+Pj4+PiBzb3J0IG9mDQo+Pj4+PiBm
cmVlLWZvci1hbGwgd2hlcmUgd2UgaGF2ZSBldmVyeSB2ZW5kb3IgZG9pbmcgdGhlaXIgb3duIHRo
aW5nLiBPUC1URUUNCj4+Pj4+IG5lZWRzIHRvIHN0YW5kYXJpemUgdGhpcy4NCj4+Pj4NCj4+Pj4g
SSBzdXBwb3NlIHRoaXMgcmVxdWlyZXMgYSB3aWRlciBzY29wZSB3b3JrIGFzIHlvdSBjYW4gc2Vl
IHRoZSBEVCANCj4+Pj4gcmVzb3VyY2UNCj4+Pj4gZGVwZW5kZW5jZSBmcm9tIGhlcmUgWzFdLiBC
eSBzdGFuZGFyZGl6ZSBjb21tdW5pY2F0aW9uIGNoYW5uZWwsIGRvIHlvdQ0KPj4+PiBtZWFuIHRv
IHNheSBpZiBhZGRpbmcgYW4gYWx0ZXJuYXRpdmUgYmFja2VuZCB0byBmd25vZGUgZm9yIFRFRSBp
bg0KPj4+PiBwYXJhbGxlbCB0byBEVCwgQUNQSSBvciBzd25vZGUgaXMgdGhlIHdheSB0byBnbyBm
b3IgZGlzY292ZXJpbmcgZncNCj4+Pj4gcHJvcGVydGllcz8NCj4+Pg0KPj4+IE5vLCBub3QgYXQg
YWxsLg0KPj4+DQo+Pj4+IE9yIGRvIHlvdSBoYXZlIGFueSBvdGhlciBzdWdnZXN0aW9uIGhlcmU/
DQo+Pj4NCj4+PiBXaGF0IEkgbWVhbiBpcyB3aHkgZG9lc24ndCB0aGUgVEVFIGRlZmluZSB0aGUg
Y29tbXVuaWNhdGlvbiBjaGFubmVsDQo+Pj4gKG1haWxib3grc2htZW0gYW5kIG5vdGlmaWNhdGlv
biBpbnRlcnJ1cHQpIHJhdGhlciB0aGFuIGVhY2ggVEVFIGFwcD8NCj4+DQo+PiBUaGUgc3luY2hy
b25vdXMgY29tbXVuaWNhdGlvbiBjaGFubmVsIGlzIGFscmVhZHkgdGhlcmUgZm9yIGVhY2ggVEVF
IGFwcA0KPj4gYmFzZWQgb24gKGludm9rZSBjb21tYW5kcyArIFRFRSBzaGFyZWQgbWVtb3J5KS4g
T1AtVEVFIGRvZXMgc3VwcG9ydA0KPj4gbm90aWZpY2F0aW9uIGludGVycnVwdHMgdG9vIGJ1dCB0
aG9zZSBoYXZlbid0IGJlZW4gZXhwb3NlZCB0byBURUUgY2xpZW50DQo+PiBkcml2ZXJzIHlldC4g
SSBzdXBwb3NlIHRoaXMgcmVtb3RlcHJvYyB1c2UtY2FzZSBjYW4gYmUgYSBnb29kIGV4YW1wbGUg
dG8NCj4+IGV4cG9zZSB0aGF0IGFzIGEgZ2VuZXJpYyBURUUgbm90aWZpY2F0aW9uIGludGVyZmFj
ZSB0b28uDQo+IA0KPiBJbiB0aGUgU1RNMzJNUCBzZXJpZXMsIHRoZSBtYWlsYm94ZXMgYW5kIHNo
YXJlZCBSQU0gYXJlIHVzZWQgZm9yIFJQTXNnIA0KPiBjb21tdW5pY2F0aW9uIGJldHdlZW4gTGlu
dXggYW5kIHRoZSByZW1vdGUgcHJvY2Vzc29yLiBNeSBjb25jZXJuIGlzIHRoYXQgDQo+IHVzaW5n
IG5vdGlmaWNhdGlvbiBpbiBPUC1URUUgY291bGQgaW1wYWN0IHBlcmZvcm1hbmNlIGJ5IGludHJv
ZHVjaW5nIA0KPiBsYXRlbmN5LiBBZGRpdGlvbmFsbHksIHRoaXMgbWlnaHQgcmVxdWlyZSBhIERN
QSBhbGxvY2F0b3IgaW4gT1AtVEVFIHRvIA0KPiBtYW5hZ2UgdGhlIHNoYXJlZCBtZW1vcnkuIE9u
ZSBSUE1zZyB2aXJ0aW8gcmVxdWlyZXMgdGhlIGRlY2xhcmF0aW9uIG9mIA0KPiBhdCBsZWFzdCB0
aHJlZSBjYXJ2ZW91dHMuIE1hbmFnaW5nIHRoZXNlIGFzIG1lbW9yeSByZWdpb25zIGluIE9QLVRF
RSANCj4gd291bGQgYmUgY29tcGxleCAoZHVlIHRvIGxpbWl0ZWQgbnVtYmVyIG9mIG1lbW9yeSBh
cmVhIGRlY2xhcmF0aW9uIG9uIA0KPiBTVE0zMk1QMikuDQo+Pg0KPj4+DQo+Pj4gTW9yZSBnZW5l
cmFsbHksIGlzIGhhdmluZyBURUUgYXBwcyBkZXBlbmRpbmcgb24gcmFuZG9tIERUIHJlc291cmNl
cw0KPj4+IHJlYWxseSBhIGJveCB3ZSB3YW50IHRvIG9wZW4/IElzIHRoZSBuZXh0IHRoaW5nIGdv
aW5nIHRvIGJlIGEgVEVFDQo+Pj4gY2xvY2svcmVzZXQvZ3Bpby9wb3dlciBwcm92aWRlcj8gV2hl
cmUgZG8gd2UgZHJhdyB0aGUgbGluZT8NCj4+DQo+PiBUaGlzIGlzIHJlYWxseSBhIGhhcmQgbGlu
ZSB0byBkcmF3IHNpbmNlIHNpbGljb24vT0VNIHZlbmRvcnMgYmFzZWQgb24gDQo+PiB0aGVpcg0K
Pj4gaGFyZHdhcmUgc2VjdXJpdHkgYXJjaGl0ZWN0dXJlIHBhcnRpdGlvbiB2YXJpb3VzIHJlc291
cmNlcyBhbW9uZyBURUUgYW5kDQo+PiB0aGUgTGludXggd29ybGQuIEFuZCBvbmUgZ2VuZXJhbCBw
cmluY2lwbGUgd2UgdHJ5IHRvIGZvbGxvdyBmb3IgdGhlIFRFRQ0KPj4gaXMgdG8ga2VlcCBpdCdz
IFRydXN0ZWQgQ29tcHV0aW5nIEJhc2UgKFRDQikgdG8gYSBtaW5pbWFsIHRvby4NCj4+DQo+PiBJ
TUhPLCBpZiB0aGUgdGhyZWF0IG1vZGVsIGlzIHdlbGwgdW5kZXJzdG9vZCB0aGVuIHdlIHNob3Vs
ZCBhbGxvdyBmb3INCj4+IHRoaXMgaGV0cm9nZW5vdXMgcGFydGl0aW9uaW5nIG9mIHN5c3RlbSBy
ZXNvdXJjZXMuDQo+IA0KPiBIZXJlIGFyZSBzb21lIGFkZGl0aW9uYWwgcmVzb3VyY2VzIHdlIG5l
ZWQgdG8gbWFuYWdlIHRoZSByZW1vdGUgDQo+IHByb2Nlc3Nvciwgd2hpY2ggc2VlbSBjb21wbGV4
IHRvIGhhbmRsZSB3aXRob3V0IERldmljZSBUcmVlIChEVCk6DQo+IA0KPiAtIENsb2NrczogT24g
U1RNMzJNUCwgd2UgbWFuYWdlIGNsb2NrcyB0aHJvdWdoIHRoZSBPUC1URUUgU0NNSSBzZXJ2aWNl
DQo+ICDCoCBbMV0uIFRoZSBTQ01JIE9QLVRFRSBjbG9jay9yZXNldCBzZXJ2aWNlIGFscmVhZHkg
ZXhpc3RzIGFuZCBzaG91bGQgYmUNCj4gIMKgIHJldXNlZC4NCj4gLSBQb3dlciBkb21haW5zDQo+
IC0gUmVtb3RlcHJvYyBXYXRjaGRvZyBpbnRlcnJ1cHQ6IENhbm5vdCBiZSBjYXVnaHQgYnkgT1At
VEVFIG9uDQo+ICDCoCBzdG0zMm1wMTUuDQo+IC0gR3JhY2VmdWwgc2h1dGRvd24gb2YgdGhlIHJl
bW90ZSBwcm9jZXNzb3I6IFRoaXMgaW52b2x2ZXMgc2VuZGluZyBhDQo+ICDCoCBtYWlsYm94IG5v
dGlmaWNhdGlvbiB0byByZXF1ZXN0IHNodXRkb3duIGFuZCB3YWl0aW5nIHVwIHRvIDUwMCBtcyBm
b3INCj4gIMKgIHRoZSByZW1vdGVwcm9jIHRvIGRlaW5pdGlhbGl6ZSBpdHMgcmVzb3VyY2VzLiBX
YWl0aW5nIHRoaXMgbG9uZyBpbiB0aGUNCj4gIMKgIHNlY3VyZSBjb250ZXh0IHNlZW1zIGluZWZm
aWNpZW50Lg0KPiAtIGNvbXBhdGliaWxpdHkgd2l0aCBzb21lIGNvbWluZyBJUEMgbWVjaGFuaXNt
czogU3VjaCBhcyBycG1zZ19JMkMgb3INCj4gIMKgIHZpcnRpby1tc2cgbWlnaHQgcmVxdWlyZSBy
ZW1vdGVwcm9jIHN1Ym5vZGUgZGVzY3JpcHRpb25zIGluIHRoZQ0KPiAgwqAgZnV0dXJlLg0KPiAN
Cj4gSWYgdGhlIHByb3Bvc2VkIHRvcG9sb2d5IGRvZXMgbm90IGdhaW4gY29uc2Vuc3VzLCB3aGF0
IGFib3V0IGFuIA0KPiBhbHRlcm5hdGl2ZSBhcHByb2FjaCB0aGF0IG1hbmFnZXMgdGhlIHJlbW90
ZXByb2MgVEVFIHNpbWlsYXJseSB0byBTQ01JLCANCj4gYnkgaW50cm9kdWNpbmcgYSByZW1vdGVw
cm9jLWJhY2tlbmQgd2l0aCB0aGUgcHJvYyBJRCBhcyBhIHBhcmFtZXRlcj8NCj4gDQo+IA0KPiAm
ZmlybXdhcmUgew0KPiAgwqDCoMKgIG9wdGVlOiBvcHRlZSB7DQo+ICDCoMKgwqDCoMKgwqDCoCBj
b21wYXRpYmxlID0gImxpbmFybyxvcHRlZS10eiI7DQo+ICDCoMKgwqDCoMKgwqDCoCBtZXRob2Qg
PSAic21jIjsNCj4gIMKgwqDCoMKgwqDCoMKgIHNwcm9jOiBzcHJvYyB7DQo+ICDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGNvbXBhdGlibGUgPSAiODBhNGMyNzUtMGE0Ny00OTA1LTgyODUtMTQ4NmE5
NzcxYTA4IjsNCj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8MT47
DQo+ICDCoMKgwqDCoMKgwqDCoCAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gIMKgwqDCoMKgwqDCoMKg
IH07DQo+ICDCoMKgwqAgfTsNCj4gfTsNCj4gDQo+IHJwcm9jMTogbTMzQDAgew0KPiAgwqAgWy4u
Ll0NCj4gDQo+ICDCoCByZW1vdGVwcm9jLWJhY2tlbmQgPSA8ICZzcHJvYyAwPg0KPiB9Ow0KPiAN
Cj4gDQo+IHJwcm9jMjogbTBAMCB7DQo+ICDCoCBbLi4uXQ0KPiANCj4gIMKgIHJlbW90ZXByb2Mt
YmFja2VuZCA9IDwgJnNwcm9jIDE+DQo+IH07DQo+IA0KPiANCj4gWzFdaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjYuMTguNC9zb3VyY2UvZHJpdmVycy9jbGsvY2xrLXNjbWkuYw0K
PiANCj4gVGhhbmtzLA0KPiBBcm5hdWQNCj4gDQo+Pg0KPj4gLVN1bWl0DQo+IA0KPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1zdG0zMiBt
YWlsaW5nIGxpc3QNCj4gTGludXgtc3RtMzJAc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5LmNvbQ0K
PiBodHRwczovL3N0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20vbWFpbG1hbi9saXN0aW5mby9s
aW51eC1zdG0zMg0KDQo=
