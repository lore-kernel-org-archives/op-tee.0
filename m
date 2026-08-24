Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026B4C5DF81
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 08:21:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1549A45235
	for <op-tee@archiver.kernel.org>; Mon, 24 Aug 2026 08:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787559689;
	bh=PyI4A0KpI9jOvLSNjwMY2KXsBhO3njjugpgysKROWv4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ja2POupESBq/4aXKoIlPEC59taq6TTm3+B/JSBXte05obU25JhFCKzAC4wkojfxf/
	 +CFs2lKoU36KyTrWwAwDLhlzln12SIe6YUTb1TulMWYMh941mXPjjuWKTKIZM5gDWo
	 T6v08u6YMBIPX9GT5e2a3/pyxoH4w+gZrB1RILRuvyL5KYU8xQJaJJqFli9F7sGpSf
	 HlaFEDgjojJwivIbLW3w2xlpom8nUcuvIHcrkWjLnF28GWEm/2DS3umR0O5V6tzsdb
	 i23Zs3hWawPS2xgYsg0E6rpuqK76nnrWfK/+rZUPi1yXwgJxG12tfJe0b0B8JA3VsY
	 i+0fmdcCNLLdA==
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1B2E84382B
	for <op-tee@lists.trustedfirmware.org>; Mon, 24 Aug 2026 08:21:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=DwcrOjXl;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oO9y65sshv5ec0EGt6xhN1kFuXuT88JwqGuzifhtMdh7bYIrr6PsQ9M/R93S4RpCNSN1ymZK61fLrnomcjAp7CdFbO2gSGyLWFwXlZV/nuLul8zIhlO0zQOhnH7fNdLW+VPPjnaZGkWUdv1zs7SIFjgcts2fOtqyYweoDhaMpourqhUOBPmjMJ2rdV00tHriZbPfj91yEUMbfPCjgmCMUi4Sj/HvW1pIoecKotTR38OXUsrRQgFSa6wxCn+uJKzeNyGyPiOVln1SEd3TyOYs9NoAoRQv9n4J2LX7vUDKliatywupiDbPhRVpJal/DQGeFBWfcvjnIfMKpaL6CkwVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dP7rxxK8RfP1fG/sYsFcnFSjUOfLKmLwXwjiz7PcOw=;
 b=eJGMlQQbVUWGVOX5fG4wTZV0MamjOk6P6gfVsM/3kvGjn/opACdgkVDPZ17XFX8C85t//epOmJl+STy7+mJy1ynXZuAuV5/0YWg+eFRAf67PxV1y1F2CNDmoU4MqDNPzLl0exiPR6gYi+e8hDCApZUlBPQrvsbm+UePgUDF/MwTZPOk7Cu4UgZ6H+VPPsdpe2ue7yN/XjjmXB7OLAao6FzuECfT25977FP/HZLVuTMVuWltNDT2smxB2bvvdcpXQIFvBlAKJO/b0VflpfP1iyr5AzKZYr8llQ8CKc90T/EB+01gHES4oftiMhJaQg2tMLsIMQ72IMvYhS3izPGzIvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dP7rxxK8RfP1fG/sYsFcnFSjUOfLKmLwXwjiz7PcOw=;
 b=DwcrOjXlJpu6Mfgn8jRoz5DOHDZYQehaLjY+WS/ZAJeTWO0lu/0qshd1KjgaaiX7IsvV+yb/1SO40fvBSrkbTsDo59FaHR5ruiEA4Z2xSaiyDgM00nAhmqH/EkwJChaWEyZOmr5L3lrzypOkVHE444BgMvCXWtVohdzmXYOrD99MZdym08GGIxIy2Q6gI2JCo34Yh/4+r1VL3E6ZYA+pD+ruKJQ4+ShO+X1XSMgBPr68Ra0vamJ1ht9dx3t/B/9vEDiUH5pbn9V/dsd3BQwM4ZSMUd20ohVAY6cjrUKU1FO5r9B0Zbzy9UNtV8f/U0E4zQyhCLf9JnWuPzK/zpo2BQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:21:16 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 08:21:14 +0000
Message-ID: <2fdabf22-e426-42f0-bf9a-a1ac4bd62f21@siemens.com>
Date: Mon, 24 Aug 2026 10:21:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OP-TEE Contributions Forum, monthly meeting August 24
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 op-tee@lists.trustedfirmware.org
References: <CAGgiveV6=aBBm4__KBZVZH9rXF70N-Y+iWEEy-Y-BgYeF5uEdQ@mail.gmail.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAGgiveV6=aBBm4__KBZVZH9rXF70N-Y+iWEEy-Y-BgYeF5uEdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0325.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1cfde3-def3-4dd3-7b64-08df01b8a9e2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|11063799006|10067099003|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	mIcVRh5PC3zDwHpNd8UEsptnSLzWoV/2RAr6isJ/pLAP272KPsgL5mES10g20pcZq5b1XosTgJaoksXgGvs4+topxryAROtYnIRmC70cr4C15vzrX7uU8TnHA/ONuHIxMng0qIfwwtEX7WgJ9yLB2zWpIkoRfHpsu80qFliulB3ngpysOcGfRfJrvuvQ5EyDFRPJKBHPT8MRqlQaUrFwtlQoAUMF+LTS+s8WyuDiBrIZksnfTFPu/Mxxn5Bfh809zIRpQqhjkeHUXeiFdu23doh05TOlMZkV2nl/S7PFE7M9s3tn/7E5uUUdXVgDonzfE96LE93eL6yTiu8k+4FhuCUfpF9DoNoqG4aFau3gpZiGkmjjNmVmMhoBPBksaA5hF5QNqswQia3pIcF14di8onjSdwKc9c3BqNtNZ26dw6QeSdlRXVbs0aOhgUO4qb4C4mYH+EVtmGBkLnp0buzCmuVpp0A+V5pU3BGYSJiaDplgCv1W64VylVNhZN1YxFeDQIP6gi3mSPVW5nzeLg1zsulZR9U9n7cWspuq2pn89YNFKigLMeZeMWXyUnpH/9fkJpP56YRCHEA1lsv1mxWEreBEfu4w6AlqfIQ7syAB3K8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dUQ2TytTRWJFMEVWc1l0MEhHbk8zT0NRcXJ2ZkFBM1M2WTVLR2NWRFpoUmUv?=
 =?utf-8?B?MnRId2daMTM0MjlGYTlxMG9Vd2VzdXN0Vmh3V21yL0FnbEw3dm9pVEd1M00z?=
 =?utf-8?B?ODJ1OWJmci83MGFhSkVNUU1kTDh2S1plb1daWE5hZDhWT01MeXFCdXRJTFcv?=
 =?utf-8?B?QXFtN1RVeDNFSEFLazJFdnhPSWVjRTU0bmdDeUh5TnZsZ3dyQXZIV2RlLysv?=
 =?utf-8?B?YTY3SXVQdDJjNEhKaEZ4Vyt6M0FlRzFlZHhidnluckVVaUl5by9aVmQ4NDVi?=
 =?utf-8?B?eWVNOE9XWkxEM096MjZwek54eTRrVDJRT2NaMDh0akt4SHJLQkxlci85ZFcv?=
 =?utf-8?B?M21aRmpiVG1Ec3djdWYvNlQ0ZGI2R1Qvalc0Sm9Ba25ueG1jUXpLTWR6MmFJ?=
 =?utf-8?B?QkVCck9OSzJQSk9IKy80QklmM3p4YmRMbnNxcmc1NEhDWURCY1FyTFZnRC9X?=
 =?utf-8?B?c1BEa3ArS2tOamNEbk1UQXFTQUVNM0lzbjhkd3lDMFNVcTE1bDVVNHgwT3Zk?=
 =?utf-8?B?S2pCTE1vUHJrcUNxUjZadHJjMHBmUEIyUklhb3dMeW5TQWdtRHAreU9lVk1p?=
 =?utf-8?B?OS9nVGZoK3NQRHlRMlYxdlVlNUZxb3pTZ1dJZldNNjdtdS9KeURJUkhmVTVK?=
 =?utf-8?B?NUhRR1VYa3RiZU9nNE1DUk5iYmhiYmhNSUJpY2NRTkpweE1aSFNKc3JYQ3d3?=
 =?utf-8?B?UExkWjBpUmgvRlB4RXNEaWRjblRtNDY2WWthQUxPNVpMYXBwLzFYdXJQT1VF?=
 =?utf-8?B?bi9najV2RTZudmxld2JkZXpWRVZkTFkvVkxXa1ViY0ZBYzcvSWRsaVZWWUV5?=
 =?utf-8?B?R3NCUnk0WW9GKzNpSFFhTXYvd1hIemVPamxqKzBMdkUrWnduL21sWi9kb0pU?=
 =?utf-8?B?K2E0bTY2RVJzT0dnTGpKYjEzYjRmaXhDSVhGQ0E3andSRDNtVlk1TEZLZUx5?=
 =?utf-8?B?Mjg2TU9WOVUyeXRzSVh1WUlaUHRYVWEwY3AwM2MyUlJMWTZUaGZmZ2llVy9y?=
 =?utf-8?B?SThiSDZPamVGMm9sNEJDRS93amR1YzQzb0lWVzJDV2NDcnZDWjFycTg0ZTIw?=
 =?utf-8?B?MS9TZmZaSmljQkVUQmpvZS8wRE9jTXJUTmxqNUJPc1RHUVpuL2lPN3NOeVUv?=
 =?utf-8?B?QkFMV1MwdThmWmJ4aFpQaW16b0pMWEhpakc2dXNmTnFyUHJ0bnNmUjR6SFNn?=
 =?utf-8?B?SG1mczh4ZzlHT0hwUlB1T0cycThkWFN6eG9xNUtmZktzcndJaDVZOUdoNGpR?=
 =?utf-8?B?WGgzVzY1c1ZvUmlrazlITHdBZ2NJY0YyK0xEZGFsNHY1NUhOKzdpdE11Yzhw?=
 =?utf-8?B?QVorQnI3UTlXWlIzRmtPN3psZ0xEUS9pTGlSa1lEL1V4TUEybmdnQldIa2Rr?=
 =?utf-8?B?RjZRbS85T3pJc1FMaFhSbDc2S0RRTWYxclVQV0h2d0o2WkdKVXZCU0p1R3Bq?=
 =?utf-8?B?bUJ1Vm5IVFRaOGRSd0NZdnh1YlpadlRyWHUySFk4OXpRWDJlUG1Vc0hJSkM3?=
 =?utf-8?B?blNpYWdpZVJaUTJvY2laSGhCSjd3cG9zM0xuTkpLZHdHS3NNWXhsR1hsQW15?=
 =?utf-8?B?R2N3RFZzejF3WnBzaDVPcHd4VUJiWkpTSGpPU2VFQnRTbVZmMHcyanZYQjRY?=
 =?utf-8?B?QS9za0FVVlF3VlhOMjhvazV6Y28xMFNCMGVnWHIzVENHYUptYWFtUmc5cDhj?=
 =?utf-8?B?aWJvSUxiVXlQMTZadTFKNnhGelJLWW4wSDJMekRYejI5a2NJenhQTmc5VjFG?=
 =?utf-8?B?Q2VjTzY0MmMwN0ZaTkpSanZhbkJZY1BCOVFiODEzY0NjVFUrM2svTmRTZ2d5?=
 =?utf-8?B?czBYdWxoZHZGYnVGcXk4NWIvU2YrMHpRZUMwaDBrV0ZCTG4rTEZhTi9SbTFy?=
 =?utf-8?B?a24rRExRdVBLRkhRMWdpTWtxU3Q4RGJmWit4NnFyaTl5UTg4QnBmWUFTQWRN?=
 =?utf-8?B?Uzhyd2JiZENzbFpTc3JPOXpZcW1tTUkrcUR0ajB4SlFtZ3VqbndJelF3NjRw?=
 =?utf-8?B?dGJ3TmN0MnAzaHVleXhRbDU5S0EyVndOeGFmVzBXc25DU1lGUDNTbXppWDlL?=
 =?utf-8?B?YmJTUHZjQlIrZHRBbzNDSkZVSGYwUFZybmhiY2crQStwdGRidGF1enZPbnVC?=
 =?utf-8?B?aXRmUDRkQzQwdkJJOTE1TkJaaGk2R3dZTXA3VGF3VUZVNVZOcGkyalpscmU1?=
 =?utf-8?B?ZnFKV1Vhc0tySHVvTmNDY0Npc0ZHdmwzOFo3NVg4RW1OTjZnR3VqeDJmTVIy?=
 =?utf-8?B?eWdQOVhYcEh2ZFFYNjVjWXN5QWpBUVAyck80SlFaNHIxNFRzaE52dGJZQVFD?=
 =?utf-8?B?WERMMGhqRFducHVFWFFLN1FzSzFhOGUrWnZJM0krVXZCcUs0SUR2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1cfde3-def3-4dd3-7b64-08df01b8a9e2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:21:14.6983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roHFI2nz5W7BOUZVzlonwSNxmVLE0gJ8YRFoahylZfLqp3WMXFVe/KNyerGJDOrNeyHbGRuZAxP33fkjGf+jQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5143
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.69.58:from];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	URIBL_BLOCKED(0.00)[trustedfirmware.org:url,AM0PR83CU005.outbound.protection.outlook.com:helo,siemens.com:from_smtp,siemens.com:mid,siemens.com:from_mime,siemens.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:588::19:received,52.101.69.58:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1B2E84382B
X-Spamd-Bar: ------
Message-ID-Hash: LRQS5TKHOJTO4N6CUTRREQN3RO3XQSAE
X-Message-ID-Hash: LRQS5TKHOJTO4N6CUTRREQN3RO3XQSAE
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LRQS5TKHOJTO4N6CUTRREQN3RO3XQSAE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

On 24.08.26 10:15, Jens Wiklander via OP-TEE wrote:
> Hi,
> 
> Tomorrow, Tuesday, it's time for another OP-TEE contributors' monthly
> meeting. For time and connection details, see the calendar at
> https://www.trustedfirmware.org/meetings/
> 
> Following up on some points from the last meeting:
> 
> The OP-TEE 4.11.0 release is planned for October 16. We skipped the
> July 17 release earlier, so this release will be a bit larger than
> usual.
> 
> During the last meeting, we discussed giving Etienne merge rights.
> He's already part of "THE REST" in the MAINTAINERS file, so this makes
> a lot of sense. It's also good to see how we can staff during holiday
> seasons. It would also be nice to have more people in "THE CORE
> REVIEWERS".
> 
> Help reviewing vulnerability reports and their fixes is most welcome.
> We should probably take this offline. If someone can help review or
> even draft fixes, please drop me a note, and we'll figure out how to
> work together.
> 
> Any other topics?
> 

State of optee_ftpm and its TPM source(s) - I will try to dial in and
provide some update.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
