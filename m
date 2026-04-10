Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA57F44855
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 13:05:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4F59C43E69
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 13:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775826350;
	bh=FvMGJg+yCjVk+S+qdwectkLc2YNzWKadJ1WZbTqJ2M0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Y96eOqgbCX97St6jDuxRyAWGx6B7uQkFclPh5R1w74zVQMt6GMhE5/AOV5yFHMGG2
	 2tEW5ZxW5SoJ4j1fJMI/rYsP2tCMTh2+K8BlbyXW2RKLDQEa+nv7DW9SZwpp+fe8lL
	 NaKWIAPJIUmxazOpdheugek3jmjHtzH6oycZY8/SYmH08y1BAM9UvTyS7hTvy52mZr
	 9cQhcmBbGGpvPHaTYxEwraR67p5DoMkbbZQoG6XQTQmQdpFIRMLOvopig/tZEXKyrt
	 ZOnXM6VlrJPuaYkAQVaoVvHjWmgXICJhVS++ErmgO4v9DgcPozBaRYwVG2utk6NJ46
	 dTFmgz3c0QRNg==
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C33FC43DF8
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 13:05:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=GatQJl4s;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRHy5Yykt3v4pk/8nE2YdtR/uRIDuYcU2OKPF+CyUoG7Y6ReYYKFJXPqUyJARFk0sRo9jJXKjZJS9NHlBGPh9CAy29vdEuhZOZ5SLm9sPJmzb75psp2a4X1BwZvA+XRlAe1Bz+jt8M/sOgidNYRz6PnqCOmP6z3MD8IGt/Xl47sJvJ0oHLiES5Q9Ji/XHtaLeU1TU1mGeErJ4U55veZa5IXoMMq3TfSRReodCQFkasIU1uBDw++PF3OrbaGQpYZj8+IGm84vnIj/HDYxWD1Pu1M76TjTF/W/6ynMVcyU//pKp6gj4U8fWB9A0wKxNeqIig489tZW7BZOSbAvKk9ySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znW1zPQUxyPBcXqHmHTxJicTqs9d/KTaPYHwQ3qGdQ0=;
 b=KBqsfcEygjHAvvFVfzyOQrrIsclMFGINX7ws6Z8UYhwmRVL08xBq3KZlr2pmRisD/nlZg5a7KyNiMvWV14bXjZHnen4ffDpoJt0KEjNR2/hS8lg+eA8wKsukuANfnMTStp4mx9iaEmSco8MApx+PpJa/hfhtbFhsCW/r9GiigfjRtO1g+7XOxHuHbVQCWmdsXCqvtVDHLHbIReu4v7vu61+Gc68dut1GxkMslv7W3mZm56Zeq27otiFEak5x7GQbjAy0BzLhS5gpPUg2hJLLCWpgX94+PGzA6b1Jr6YEJ9YxtwA2SORfWDRbxpLka9XrZXQIsCEZGsd12aW0Zvu8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znW1zPQUxyPBcXqHmHTxJicTqs9d/KTaPYHwQ3qGdQ0=;
 b=GatQJl4s/fPgfWe71cajSQvdlyqeJzrbK/Jr76B6Y9Ns0UuQozr2bFsrv8P9qbcRtNCHt4Mm2UxoLepxxwXxWx0jRX3QnMjZsSQyrIfz2wnms2YJgkMxLbIXF9Q3iREwxv8JJ93CcGqT/FSyROEf4ViL2Fbl1twjekNYtonGZBzJU5vTOmQHwuvlpUBWFFli4OSJXmCvO8m0osAo9hMUWTFuvCtSfma4YZumqmlhfEw3UfM6PnteeIDAksnzLavhydt117ks3r4KJApEjIcueNIQK4N9CoGclWN0BDFGLcrsNWnCJCEwEvppuYhZvv84LqfQHr5dgoxKzdwVNhqYZA==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU4PR10MB8448.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 10 Apr
 2026 13:05:37 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Fri, 10 Apr 2026
 13:05:35 +0000
Message-ID: <e380c5fd-ecb1-49fd-ac78-3b990b1f8cfd@siemens.com>
Date: Fri, 10 Apr 2026 15:05:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PKCS#11 TA needs userland supplicant?
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
 <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
 <4dfd2e07-4627-4682-a8f2-bc13eafa1fe9@siemens.com>
 <7a52b4ec-7e75-4332-b94c-726978a3a7b6@siemens.com>
 <30ddaa03-b2af-4c71-bd0e-b379cc4f2685@siemens.com>
 <4e9643cb-c41a-4242-ac1f-ab3a048f3a46@siemens.com>
 <CAHUa44EGG15Ekd4EvqGVoH49QNKkLVQav5aCSx0DBorebOmaOg@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAHUa44EGG15Ekd4EvqGVoH49QNKkLVQav5aCSx0DBorebOmaOg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU4PR10MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d33632-2624-4d55-7a3d-08de9701dac7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	YzgdDH/m77ZLWxVMsu4e9DUcUcKvV1Uvc4HUEGkrtN3WKwRP79qB6y7dSzKxSEVolem5fqP7xmp5KblF5aK0a024hvyq8P2HTcaDI6hDyie5Tq2G5oQuFP29Ql+DlADFhVvgLh2WiAtKl8h2g2QpnJWpFsrbSNU0F5pKAGa43JRQgstrKlAZn3LAoqyv+pF3aJfkd9QtCqIskZys3P9Hw3i+fuRuKJ0ScL4X+XaeVrte8SSsJaLfVd3Y2JR+hxXNdwyX+KtFOgHAD7Ecj8u4TE4xUxavUBQIdbemMsDpMIIzDpKSa7omtq4jxyuUE9bwzGO8LyhOfVPj52YjwRBr88g/yW9QHZNoy11dKh+MJ046rTPZ2wyOt0NFLCE/L5pxmPNDSus2yKEcoLFpeF0wz1dSmdJ8xoqJOcomlHYySEcE4jMtRSrBmbus9E6dDhI+bZg4ngy0KXYU2c18Pz7S6mwT8uLyK3Iuzbc+WyWHzbzPZqiyQlWpRyeOEuPCF8Qgk4XRAWd5corAdt4C2Pos5A1povqrsRhOlaThraxi0fouvIrw8eAd7m+u3qvKUv7w87qynNCZqJ3nuwcHvz5uFHDHHhffgm9qac+CR0uvmpQwLbfZFCehTw9/K32puXGYi5C+K5AjDo38V7jket2lR3xmOgSfce5EvWcX3xoui/4AbL1IfbZXSKa5Ph1/VQ03KUC+rwm2jomzMsr/g8bUx2Z6vmuW8N0osnaNqKV5aEw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWEyc2NQNFQ4d3pycVNqMGN0dkJSZXA5a29jaGNuWjVDd0FqL2xKeVVYUEVI?=
 =?utf-8?B?Y0ZDcFBxbFptbG5vaytwNGE4d1lYeDlHVkRmNDg1U3E3a3JROTB6eGsxTGRu?=
 =?utf-8?B?VnRBaTZxOHhhNEZOYkVyMTFnS1pUYzRTK0pUbGJNTzZtWDFteXhUU1p4dnhy?=
 =?utf-8?B?MDNFRi9MVE53Tng5OTBkWlBpMFIvWlNVQXFUTnM3MTcwbFVPU3FGeFpmWVQ4?=
 =?utf-8?B?b3JxSFN5V0hHR2orT0plQy9GTkhNeDVld2Z3RGxLa0dWWDRMUU5RcmNscE5o?=
 =?utf-8?B?UnByclNMSXBEVURzWHkzMXR0a2thdmtIMWZJa21BbDNLNDUxRzBPaGNPOHNt?=
 =?utf-8?B?U1JtQktabTBqNHJlRUJTdXlQQXFOTFdNMElJUXNqTE5zVXN1OHZ1RjhiYlZr?=
 =?utf-8?B?ZzU0b0ZwK3doUmNnYnkyMUsxSGxzcDZ1QjI4SXhGV1RsbE9MYTJVdzhxdm1X?=
 =?utf-8?B?R0lzRjM2amhOWDFHblpzZjdtSzkwR3paeDRIaWp3M1BZaHN2Skx6a0RjMThp?=
 =?utf-8?B?SnFSWWtJNkpUT2FCZndxOW1ZNmNvS3g5VHFQUHZ4anlnbmhIUzhNQlpjaUpo?=
 =?utf-8?B?UlF4WDZtdVNoL2o2ZkdYYjhJOHRJdS9JcHJWbWF0WUtpS1c5V09jTFh0dW94?=
 =?utf-8?B?U1V6bUNXUWR5M1FGWlBMekVYWmZpeHlGcDJTR3ZMMHlINGNoYU55MWk0d2Jn?=
 =?utf-8?B?amM0eUlaK09LdndRd0hEV0xTVFU0U0laUnFXZUV6M1pqb3FydnZwQW1PTVZO?=
 =?utf-8?B?b0htTmpycDZoUThNVjJqNG1hSVM4WWM3S0FUam9DZ3JBekdQeDEyQ0drby9m?=
 =?utf-8?B?Tzlzbk01QlRXSWN3dGpIem1VMjlCZmlwYnlJUlA5SWloZGhhU3lnbHJWNzVP?=
 =?utf-8?B?Y1NMKzRINDNtMk40emtIU2w3K3Z4SDFoRWs4UmlpbXVWMERDRGttZlNKeDhD?=
 =?utf-8?B?RlRKaUZDU0xpQUcyUGhxQzFMcXo3REUrTDdFQUZNd3JNSVB2M3dVZWlJVWtT?=
 =?utf-8?B?WGJENDN2aGFkcGJKS2JjK2NuR1NSNFdYcVJqNTgwUEFOQjUrQUwxZEYwMlh1?=
 =?utf-8?B?MnJWaVcxdjVHRDlvaGxRZjNobjM1TERvMTNWVDA2WU9MUTVaWmY2aUpYQnNt?=
 =?utf-8?B?cGJrb3dJYjJ2emZOS3JFK0JvQVRMOHgrMjNaUEFRTUdHKzZENkFCck52M01m?=
 =?utf-8?B?azM0UmQvdmNJQWtvS1NOeTlrcEw4SWtlSWVuWE1xY3ZHOElYYUkwRG15UXFB?=
 =?utf-8?B?cXB2Q1pHd05mSEVPeHREN3FhQitGM08ydTdpTGNGUmp2d0RReUd5NllHc2lB?=
 =?utf-8?B?NVNrRG9DcHNSN0ZoYmN1eTlYMmRHb2xXcnZXOElLQ3dsVHBISWZPU2pkU0l0?=
 =?utf-8?B?SDZPSjZYQ3M5Ym5qbEZNbS9IdGdFRXhhVUhTaERZSVNJYWtaQlR2dXp5ZHN2?=
 =?utf-8?B?QVFFa0pBWTE4MWNSdUloRElQQ0RxRUJBYWtjRFh2SDUyT3B3VlVsNkVZQ0hm?=
 =?utf-8?B?VFBaY1BkZ3g3L0tRdERnTkxCeWFqUG5PSHYxOVczQjlEaEVtZnpIZkwrc0la?=
 =?utf-8?B?WlRHK2NOVUVWNHRIbGpUWE1Rc3U4TldONVFtc1FoOHg2SFkrZUgxQ2Z5cGxS?=
 =?utf-8?B?N1p5SXZaNHlLdEt0aHVwRjRxMTJUcEZuMUd4clJGSElJeE0xRTVzejJweE5R?=
 =?utf-8?B?ekF6S3BmZ2k4c3V4Y2V6bisvUjNUb25LSjVITEFHUFJkWW9KZmdpaU9hai9T?=
 =?utf-8?B?SVg1QVJ0bHJkUTJaRDlqSDA4MFJoVjh1OGpMMHNpRzVqY2l4ckU3RmtQNURi?=
 =?utf-8?B?MU1od1dLUE9mVXZLMFg0R0k0SmNHR0RFVlJCQ1ltRkl2TmhzS2ZXRnpweHNE?=
 =?utf-8?B?MzlGSnd6d21QdTRnaUZvMmFlU241TjJlKy82QWpGeU94Q2tBOGJSZXBEazU2?=
 =?utf-8?B?NnFkZExFVzU5bGRubVYwTDhoNDhTQmhVRi9iZXNzTTl6WjVpNURhS0Fmd2po?=
 =?utf-8?B?YkVYWEcwV3luSkZjZHZpZEo5TnhsMko4WWt0Q0s0bTc3MGxnUlFJRmV3SGdy?=
 =?utf-8?B?UmlrRHZTc3hpL0c1bXhIVVBtNzB5QnlNODNqbjB3aXRSblBTbENFSFlDS0Va?=
 =?utf-8?B?MVZwYXIyWndQdkxjbGlRTmJtZFJVMkM5ZjNBaGZISkxMWkZhbjhwQzZjREts?=
 =?utf-8?B?aXVqajlkREcvRFYxSkpSaEZtQTZEQ05XT0hYa2ZiNTExZEdhWjRQVXRIRGNU?=
 =?utf-8?B?RFBES2lVZlJNNFl4NnlRL3lkbTF2VUJuZnpMUFFVam5BZk5MSURWdTJCU1ZC?=
 =?utf-8?B?cGpwZHlySXVFOTFIQUsva1ZaWU1qZmR5N2E2M005THJHNEtSdVV4UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d33632-2624-4d55-7a3d-08de9701dac7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 13:05:35.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMUv2FKmoWkwT2oItR0N83OOL8HpZoFsL4NZ91IkzuPQrRijU7yZvOkgJTXY0yAA7HR9ZrLrqw2W6RWKYAMB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8448
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.130.54:from];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.130.54:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C33FC43DF8
X-Spamd-Bar: -----
Message-ID-Hash: 3VL6SLTAOHEQWHVTE2TVGWN3ITHW7N35
X-Message-ID-Hash: 3VL6SLTAOHEQWHVTE2TVGWN3ITHW7N35
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3VL6SLTAOHEQWHVTE2TVGWN3ITHW7N35/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

T24gMTAuMDQuMjYgMTU6MDEsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9u
IEZyaSwgQXByIDEwLCAyMDI2IGF0IDExOjI34oCvQU0gSmFuIEtpc3prYSA8amFuLmtpc3prYUBz
aWVtZW5zLmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gMTAuMDQuMjYgMTA6MzYsIEphbiBLaXN6a2Eg
d3JvdGU6DQo+Pj4gT24gMTAuMDQuMjYgMDk6NTksIEphbiBLaXN6a2Egd3JvdGU6DQo+Pj4+IE9u
IDEwLjA0LjI2IDA3OjQ1LCBKYW4gS2lzemthIHdyb3RlOg0KPj4+Pj4gT24gMTAuMDQuMjYgMDc6
MzcsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPj4+Pj4+IEhpLA0KPj4+Pj4+DQo+Pj4+Pj4gT24g
VGh1LCBBcHIgOSwgMjAyNiBhdCA3OjQx4oCvUE0gSmFuIEtpc3prYSB2aWEgT1AtVEVFDQo+Pj4+
Pj4gPG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnPiB3cm90ZToNCj4+Pj4+Pj4NCj4+
Pj4+Pj4gSGkgYWxsLA0KPj4+Pj4+Pg0KPj4+Pj4+PiB0byBhdm9pZCB0aGF0IEknbSBkZWJ1Z2dp
bmcgZnVydGhlciB0aGlzIGVycm9yIEkgZ2V0IGR1cmluZyBib290IHdpdGgNCj4+Pj4+Pj4gQ09O
RklHX1JQTUI9eSBpbiB0aGUga2VybmVsIGFuZCBDRkdfSU5fVFJFRV9FQVJMWV9UQVM9cGtjczEx
L2ZkMDJjOWRhLi4uOg0KPj4+Pj4+Pg0KPj4+Pj4+PiBbICAgIDAuMzU5MzcyXSBtbWNibGswYm9v
dDA6IG1tYzA6MDAwMSBRRU1VISEgNC4wMCBNaUINCj4+Pj4+Pj4gWyAgICAwLjM2MTc3OV0gbW1j
YmxrMGJvb3QxOiBtbWMwOjAwMDEgUUVNVSEhIDQuMDAgTWlCDQo+Pj4+Pj4+IFsgICAgMC4zNjM3
NjFdIG1tY2JsazBycG1iOiBtbWMwOjAwMDEgUUVNVSEhIDIuMDAgTWlCLCBjaGFyZGV2ICgyNDg6
MCkNCj4+Pj4+Pj4gRC9UQzo/IDAgdGVlX3RhX2luaXRfc2Vzc2lvbl93aXRoX2NvbnRleHQ6NTY5
IFJlLW9wZW4gdHJ1c3RlZCBzZXJ2aWNlIDcwMTFhNjg4LWRkZGUtNDA1My1hNWE5LTdiM2M0ZGRm
MTNiOA0KPj4+Pj4+PiBEL1RDOj8gMCBsZWdhY3lfcnBtYl9pbml0OjExNDMgVHJ5aW5nIGxlZ2Fj
eSBSUE1CIGluaXQNCj4+Pj4+Pg0KPj4+Pj4+IFRoZSBpbi1rZXJuZWwgcm91dGluZyBkaWRuJ3Qg
aW5pdGlhbGl6ZSBhcyBleHBlY3RlZCwgc28gT1AtVEVFIGlzDQo+Pj4+Pj4gZmFsbGluZyBiYWNr
IHRvIHRoZSB0ZWUtc3VwcGxpY2FudCBiYXNlZCBSUE1CIGNvbW11bmljYXRpb24uDQo+Pj4+Pj4N
Cj4+Pj4+Pg0KPj4+Pj4+PiBFL1RDOj8gMCBnZXRfcnBjX2FsbG9jX3Jlczo2NDYgUlBDIGFsbG9j
YXRpb24gZmFpbGVkLiBOb24tc2VjdXJlIHdvcmxkIHJlc3VsdDogcmV0PTB4ZmZmZjAwMGMgcmV0
X29yaWdpbj0weDINCj4+Pj4+Pj4gRC9UQzo/IDAgdGVlX3RhX2ludm9rZV9jb21tYW5kOjgzMCBF
cnJvcjogZjAxMDAwMDMgb2YgNA0KPj4+Pj4+PiBEL1RDOj8gMCB0ZWVfdGFfY2xvc2Vfc2Vzc2lv
bjo0NjkgY3Nlc3MgMHhjMDIxMDkxMCBpZCAxDQo+Pj4+Pj4+IEQvVEM6PyAwIHRlZV90YV9jbG9z
ZV9zZXNzaW9uOjQ4OCBEZXN0cm95IHNlc3Npb24NCj4+Pj4+Pj4NCj4+Pj4+Pj4gSXMgaXQgcG9z
c2libGUgYXQgYWxsIHRvIHJ1biB0aGUgUEtDUyMxMSBUQSB3aXRob3V0IHVzZXJsYW5kIHRlZS0N
Cj4+Pj4+Pj4gc3VwcGxpY2FudD8gSSB0aG91Z2h0IGl0IG9ubHkgbmVlZHMgdGhlIHN1cHBsaWNh
bnQgZm9yIFJQTUIsIHRodXMgc2hvdWxkDQo+Pj4+Pj4+IGJlIGZpbmUgd2l0aCB0aGUgaW4ta2Vy
bmVsIHJvdXRpbmcgKHdoaWNoIGlzIGFjdGl2ZSksIGJ1dCBtYXliZSB0aGF0IGlzDQo+Pj4+Pj4+
IG5vdCB0cnVlLg0KPj4+Pj4+DQo+Pj4+Pj4gWWVzLCBJIHRoaW5rIHNvLiBJIGhhdmVuJ3QgdHJp
ZWQgaXQgbXlzZWxmLCB0aG91Z2guIEFueXdheSwgdGhlIGxvZw0KPj4+Pj4+IHRlbGxzIHRoYXQg
T1AtVEVFIGlzbid0IHVzaW5nIGluLWtlcm5lbCByb3V0aW5nLiBZb3UgY2FuIGFsc28gY2hlY2sN
Cj4+Pj4+PiAvc3lzL2NsYXNzL3RlZS90ZWVwcml2MC9ycG1iX3JvdXRpbmdfbW9kZWwgdG8gc2Vl
IHdoYXQgdGhlIGRyaXZlciBoYXMNCj4+Pj4+PiBuZWdvdGlhdGVkLg0KPj4+Pj4+DQo+Pj4+Pg0K
Pj4+Pj4gIyBjYXQgL3N5cy9jbGFzcy90ZWUvdGVlcHJpdjAvcnBtYl9yb3V0aW5nX21vZGVsDQo+
Pj4+PiBrZXJuZWwNCj4+Pj4+DQo+Pj4+PiBBbmQgaWYgSSBidWlsZCBvcHRlZSBhcyBtb2R1bGUg
YW5kIGxvYWQgaXQgbGF0ZXIsIHRoZW4gY2FsbCAicGtjczEtdG9vbA0KPj4+Pj4gLS1tb2R1bGUg
L3Vzci9saWIvbGliY2t0ZWVjLnNvLjAgLUkiLCBpdCBhbHNvIHdhaXRzIGZvciB1c2Vyc3BhY2Ug
dGVlIGhlcmU6DQo+Pj4+Pg0KPj4+Pj4gLi4uDQo+Pj4+PiBGL1RDOj8gMCB0cmFjZV9zeXNjYWxs
OjE0NyBzeXNjYWxsICM4IChzeXNjYWxsX2NoZWNrX2FjY2Vzc19yaWdodHMpDQo+Pj4+PiBGL1RD
Oj8gMCB0cmFjZV9zeXNjYWxsOjE0NyBzeXNjYWxsICM0MSAoc3lzY2FsbF9zdG9yYWdlX29ial9v
cGVuKQ0KPj4+Pj4gRC9UQzo/IDAgbGVnYWN5X3JwbWJfaW5pdDoxMTQzIFRyeWluZyBsZWdhY3kg
UlBNQiBpbml0DQo+Pj4+PiBJL1RDOiB0aHJlYWRfcnBjX2FsbG9jIDAsIGFyZy0+cmV0IGZmZmYw
MDAwDQo+Pj4+PiBJL1RDOiBnZXRfcnBjX2FsbG9jX3JlczogYnQgMCBzaXplIDgxOTINCj4+Pj4+
DQo+Pj4+DQo+Pj4+IEkgaW5zdHJ1bWVudGVkIGZ1cnRoZXIsIGFuZCBJJ20gZ2V0dGluZyBhbiBP
UFRFRV9SUENfQ01EX1NITV9BTExPQyB3aXRoDQo+Pj4+IE9QVEVFX1JQQ19TSE1fVFlQRV9BUFBM
LCBub3QgT1BURUVfUlBDX1NITV9UWVBFX0tFUk5FTCAtIHRoaXMgaXMgd2hlcmUNCj4+Pj4gdGhp
bmdzIGFyZSBmYWlsaW5nIG9yIGJsb2NraW5nLg0KPj4+Pg0KPj4+DQo+Pj4gSSB0aGluayBJJ20g
Z2V0dGluZyBjbG9zZXI6IFdlIGhhdmUga2V5LXdyaXRpbmcgZW5hYmxlZCBmb3IgdGhlIFFFTVUN
Cj4+PiB0YXJnZXQgKGtleSBpcyBub3QgcGVyc2lzdGVkIHRoZXJlIHlldCksIGFuZCB0aGF0IHNl
ZW1zIHRvIGVuZm9yY2UNCj4+PiBsZWdhY3kgaW5pdCBhbGwgdGhlIHRpbWU6DQo+Pj4NCj4+PiBo
dHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29wdGVlX29zL2Jsb2IvMTViYmFhMzMxZmI2ZDY5NDY2
YzQ4ODBhMWFmMWU4ZTk1ODBjOTVmMS9jb3JlL3RlZS90ZWVfcnBtYl9mcy5jI0wxMjQ4DQo+Pj4N
Cj4+PiBJZiBJIGdvdCBpdCByaWdodCwgbGVnYWN5X3JwbWJfaW5pdCByZXF1aXJlcyBhIHVzZXJz
cGFjZSBzdXBwbGljYW50LA0KPj4+IGRvZXNuJ3QgaXQ/DQo+Pj4NCj4gDQo+IFllcw0KPiANCj4+
DQo+PiBUaGluZ3Mgc3RhcnQgdG8gbWFrZSBzZW5zZTogVGhlIFFFTVUgaW1hZ2Ugd2UgYXNzZW1i
bGUgaW4gaXNhci1jaXAtY29yZQ0KPj4gWzFdIGRvZXMgdGhlIGZpcnN0IFJQTUIgYWNjZXNzIGFu
ZCB0aGUga2V5IHdyaXRpbmcgYWxyZWFkeSB2aWEgVS1Cb290LA0KPj4gYW5kIFUtQm9vdCdzIHN1
cHBsaWNhbnQgZG9lcyBub3QgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSB0d28NCj4+IFJQQ19T
SE1fVFlQRXMgLSBob3cgc2hvdWxkIGl0PyBTbywgUlBNQiBpbml0aWFsaXphdGlvbiBpcyBhbHJl
YWR5IGRvbmUNCj4+IHdoZW4gdGhlIGtlcm5lbCBsYXRlciBvbiBsb2FkcyBpdHMgb3B0ZWUgZHJp
dmVyIGFuZCBzdGFydHMgdG8gY29tbXVuaWNhdGUuDQo+IA0KPiBZZXMsIGJ1dCBJIHdhcyBleHBl
Y3RpbmcgdGVlX3JwbWJfcmVpbml0KCkgdG8gYmUgY2FsbGVkIGZyb20gdGhlDQo+IERldmljZSBQ
VEEgd2hlbiB0aGUga2VybmVsIGhhcyBkaXNjb3ZlcmVkIHRoZSBSUE1CIGRldmljZS4NCj4gdGVl
X3JwbWJfcmVpbml0KCkgY2F1c2VzIHRoZSBSUE1CIGRyaXZlciBpbiBPUC1URUUgdG8gcmVzdGFy
dCBwcm9iaW5nDQo+IGFuZCBzaG91bGQgc3dpdGNoIGZyb20gdGhlIGxlZ2FjeSBzZXR1cC4NCj4g
DQo+Pg0KPj4gSW4gdGhlIHNldHVwIGFib3ZlLCB0aG91Z2gsIHdlIGRvIG5vdCBoYXZlIGEgVS1C
b290LCB3ZSBkaXJlY3RseSBib290DQo+PiBmcm9tIFRGLUEgaW50byB0aGUgTGludXguIEFuZCB0
aGF0IHNlZW1zIHRvIHNlbmQgdXMgaW50byB0aGUgZXJyb3IgLw0KPj4gYmxvY2tpbmcgb24gdGVl
LXN1cHBsaWNhbnQgZnJvbSB1c2Vyc3BhY2UuDQo+IA0KPiBXaXRob3V0IGEga2V5IHByb2dyYW1t
ZWQgaW50byBSUE1CPw0KDQpJdCdzIFFFTVUgaW4gYm90aCBjYXNlczogV2Ugc3RhcnQgd2l0aG91
dCBhIGtleSBvbiBldmVyeSBib290LiBTbyB3ZQ0KY29tcGlsZSBvcHRlZSBmb3IgdGhvc2UgY2Fz
ZXMgd2l0aCBrZXktd3JpdGluZyBlbmFibGVkLg0KDQo+IA0KPj4NCj4+IENhbiAvIHNob3VsZCB0
aGlzIGJlIGNoYW5nZWQ/DQo+IA0KPiBJdCBzb3VuZHMgbGlrZSB0aGUgcHJvYmxlbSBjb3VsZCBi
ZSBSUE1CIGtleSBwcm9ncmFtbWluZy4gSSdtIHRlc3RpbmcNCj4gaW4ta2VybmVsIFJQTUIgcm91
dGluZyB3aGVyZSB0aGUga2V5IGlzIGFscmVhZHkgcHJvZ3JhbW1lZCBmb3IgZWFjaA0KPiByZWxl
YXNlLg0KPiANCj4gV2Ugd2FudCB0byBtb3ZlIGF3YXkgZnJvbSBPUC1URUUgcHJvZ3JhbW1pbmcg
dGhlIFJQTUIga2V5LCBzbyBhIG1vcmUNCj4gYWR2YW5jZWQgY29tYmluYXRpb24gd2l0aCB0aGF0
IHNlZW1zIHRoZSB3cm9uZyBkaXJlY3Rpb24uDQoNCldlbGwsIHBsYW4gQiBpcyBpbXBsZW1lbnRp
bmcgZnVsbCBzdGF0ZSBwZXJzaXN0ZW5jZSBmb3IgUUVNVSBSUE1CLA0KaW5jbHVkaW5nIHRoZSBr
ZXkuIFNvbWV0aGluZyBJIHdhcyBwdXNoaW5nIHRvIHRoZSBiYWNrbG9nIGFzICJuaWNlIHRvDQpo
YXZlIGJ1dCBub3QgbmVlZGVkIGZvciBjdXJyZW50IHRlc3RzIi4NCg0KSmFuDQoNCi0tIA0KU2ll
bWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhwZXJ0IENlbnRlcg0K
