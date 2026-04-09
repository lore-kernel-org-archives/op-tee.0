Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04379F364A6
	for <op-tee@archiver.kernel.org>; Thu,  9 Apr 2026 17:41:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 33353443A7
	for <op-tee@archiver.kernel.org>; Thu,  9 Apr 2026 17:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775756464;
	bh=f/VsT0ySV4oC5Jms8ntbt0uI7kFwRYITGhS+e6tgKwc=;
	h=Date:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=UH8FJS9bMHqrb54Y5+3VzTHHdOSYzZNHjL2CfrTE84FFgqaba/+SxG1Z7r7YKoCwg
	 i8vQF/0g+YqiESg1xeFzdm269JDbyGkcgs1KiXE6nV163klqU+FdQ4WYbnc/JUSdz9
	 jIGv996CepjVpiqFgWJPdpFz0huBbEExRVOrEYiKPczuvo2iJb87WcYQ+TVz0il+CL
	 hmaskR30uwJxCjQrXrGyS6SnmJxPhOkr4pPB2jWObNbMv7onVOXZcPY5osh/lVKUZx
	 w35ASs7Gtn93dnK29cfO4cBkVSCVlD08bmi4wHBLSvZ4BhEOzBfjk2hBdfvq9sbNze
	 WSZAqPLicSiYA==
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C735A41B8D
	for <op-tee@lists.trustedfirmware.org>; Thu,  9 Apr 2026 17:40:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jFTSOKyu;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBC4lgJIHfu2QJvmgeD/zkaEzq9CUIkQhn4467LFVc7v1mQNK0d0+FP8pmmnpxH4KlFvIN5dp+6RhGytcNOVTy6aklspIVLbBOPrW6xeFF8D9fZGWKP0484LiefzCTI0ybCqzs/NJFxrU9/buml7ZnPMvqzJPMTRbp0WeaXsYIoQSiYn1D7ojhk8ApJsHhwhRRWf62rFRPv3wCB/3M+a73ARvBNhCpmo1I700jR/wrn2m/j2r6sYB/ShyYav8JxANzMuTLWtKgU7MJ0RQNIrzAj3tn7guW4t2T9+K0WWwTKHLbofKxYyelqBk+U886w5xwKZzUPB29t/wU81aHG/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbix2KeEshWlutimnXCg6L9xtsT1mXcvwlO99G8un7M=;
 b=lt1IoP6KAjCBzKUVnavk2dAmRBJ94e/U5B0hbYrtC+mU6B0q6T/+e+n/ihfFJ1W6QaJaGnefw2ES1RJ3w87uLn9eDO8VkEqZp8TDqJPwOTJMM7qS3FLZ9X64w0sIiRlqli9dMfyHcq9QqUWdNjnbbNTx2XUtU0MwCFiTpArbb0qE5DMXmgl0o2l3HBnrfNNAjP9XTZ4EeG+hPin4yakp+LglIkcw0za/zjWdZgrVh8+qNSKe62D+/kD5mfTZPgaIP40BTmS3mhQyXg9GgQhHvE0UrkBJ1Wj6x1+azbpt+1PgUg5NG8aIHf316BhAvms774PNG5F7XZ/7qMtA3Y9AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbix2KeEshWlutimnXCg6L9xtsT1mXcvwlO99G8un7M=;
 b=jFTSOKyubyp2825+9DFXrcq4u4NimwHS6iujLb6JwqfXyzCQbI2gVnNorJ2grUCTvwgQHDS7vAqpa6IzmD2ylDrF2QssfMcWYs8MqIVY2w/mI79rU27JozZ3X0CXJ7I6nLPKHeMlGDkv/Mrr9oTrU8hT8ud4mx3i1/QWCzxrxfI5wCyq6LWK2g9JzQR/tRez6nEP/LslfeaI7TVf/M3XdzDJPLvc0XijRXUPdkj9YEk8PCg8ZdWAubo28F7GBEqQ0Yogz5O4XC2QY2m2jy1vfUAxE8bc5hWGKmZFpmDZakYVLpL1VevBTbriG7bVQiuTUMeoErb7nR5OmRPNR+3DeA==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB9007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 17:40:51 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Thu, 9 Apr 2026
 17:40:50 +0000
Message-ID: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
Date: Thu, 9 Apr 2026 19:40:47 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Subject: PKCS#11 TA needs userland supplicant?
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:408:e9::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB9007:EE_
X-MS-Office365-Filtering-Correlation-Id: f8920bae-ffa8-4bfa-18db-08de965f2428
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Qz8oS8KSCMTS6L2l02ZYsfTX72Fd0RTxi3a/83Q4J25P/Tp/m/he/3E4dGElWriM9ocHMj+Nvjx9tpxaeTChaT28M5LhZ17RHIMbmpKoOPZR7XzKoUJvZtHbernJ8Imbmcywtmyc0ISR3cFsmS+JCiu+iYDfTnWefSfsZdehQY9B+vr7d/SVPNBveU3p6JyVuc8C+ROtrFZf9LQ2TkhKLToltU7McPUNXa3xnSisG5bk9lUIv+CW4/vy0Qk8iUpnDH13FGjjj27P/SdXPeL8NpqrU6OXrSIuvuagCtSaMYC0uWRIielbMmP/Ugzqiabui0jvfuozpLTezgHnN04WQTHOmCc5RfEZIz6F9Jv1I+p1DI1WpVIMU6CazK0AJ2BNuKLAzvLCYvaJmJ1QXNo0Ji3ztLwZT4YzLNBUU3Mm4Y/Ew0ag1AkpIhN679i+f0CgTxCp0T1ouRfqBDiyIFI7vMPCWSYHbkVaYJsmc8ntFJYc+jF61l8ii++iaA+JpzKcaetqnDY2A3uxsX0N+hu0lxtROiJmaXo+X4qo7aNjAoYoq0yQ5/fKMblPAGGflPDcnHyJXF9EMPb0T61j97qP3YCRVBSAM5X6CQhKN9zEdWLZ55nkTEEwUGeRI7UuhI7yTS3rFgC+SU7IoPuDve/0rucGDmeHmuVxsXobGCjTCMkgRKbi9zufFp1eH59fOU20FvEov8bqpdc5KN6Co3DDnKPZyx8RrwJ7ksjKI1TOL6o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QURiMUs0allYKzVCZFhRUUNXMUUxcUhqNlA3bkRoWVAzckFjekowOHVmK0dW?=
 =?utf-8?B?MzcvMC9GYllQcXNPdU56UTN0RUorZ0ZDeCtDMFJDenBnUU5aQkxZSEE0RHVp?=
 =?utf-8?B?ajJjeW1xcjhKa09sc3ZoaFFXaGVqSHVUTTA0M2JicEkzRG1odDRmWFpwdm5L?=
 =?utf-8?B?RHZoS0N0RE9ZU3ZuVGNzWm1TOXkyUW4vYzI2ays1M0svbFpxai9Mb0FtWDJD?=
 =?utf-8?B?b0VkNm9qc2dVbVp2NW13ZkFmUmFybWpGTEdUUkdXNThtbFdPeS84YVNvQmdX?=
 =?utf-8?B?RkFsMm5TU0IvMmRQU0hoS3Z5NkJUZVFPMUZKdmlhbU5YZEMxZjBzQVJVRGVV?=
 =?utf-8?B?SEZYYXd0Tmw2QmZySDllbTRjcm9BOTl1KzRLSnlJOW1FVGNlVkV2VGNpYWxY?=
 =?utf-8?B?SFBzaEEvUVJlRlZ1Qm9ldWtKZWdFUHp3RlB0ZmkzSDVXQU1UcndoY0xLK25E?=
 =?utf-8?B?U1hmMzNrVERNSkdSamo1SlQzaFRRdkc1djFZZncxN3Z3RlhkN0syak81YjNn?=
 =?utf-8?B?WjJIOGViZVJ1cnc1T3RtZjdpQnpxa0lPd1dTTW1pQjROMGxSM21DM3l5My92?=
 =?utf-8?B?OXJ3dENrRWF3c3lnWDZjUmVGWGwyRTI1NGxJOWYwVG5MZzAwQTZ3Sjg1Sjdr?=
 =?utf-8?B?b3hUM2VBWXdhT3BTc1Y2Q09ySjdnNlNPbnZiU0tDYzZCc0dyWkxwdGpwd0ZX?=
 =?utf-8?B?QTNJcHBza0xJME56S1ZsV1ArZXg4elR0c3l6K09adDE4cndTbGlDbklJQkZJ?=
 =?utf-8?B?T0pkdXQyN2NDaFhKQjBhN09ScHhnUEtmaFZVbEFGeVJtSjNhWGY4RU50WkRK?=
 =?utf-8?B?NFRKMjJBaFM4MmlkTUtyQkJKUzFUdGpXQ0xtWFNDZzJnS0tjMlZWTFFlQWlZ?=
 =?utf-8?B?VHNINUNXcXk0WFg5TFhkNVhVV3g2NU9ZY3YzYUo2MlFTVlNqZ3YxTkxzOG41?=
 =?utf-8?B?UkVOSzZDcUphdUgycTBKaUFkb3RhWGtQbU52eHlJQnlMQ0JHdU5uRjcxeE9y?=
 =?utf-8?B?U3NyUHBuTEFiUjRmclYyc1krNjcyZFRmSEdoY1NtV09oaTN6WDArRjd2Vk1B?=
 =?utf-8?B?SjVnWkVFc1FiM1Z0VmhJWUlzcHRHVTlxS21RakJvTnhuNzhETmd0OWR5cWFI?=
 =?utf-8?B?WHJNNkZmVlFPYzJyTERFT3VadHhBeHF1Z09CVU1SVjFGUHpGRjlhZ3RNZ2Q4?=
 =?utf-8?B?QzNCNEdoZXJqczBBcmx1dzVwc3pDNkJZdTdHeUVpSFkvalNZTWtiZktCclpY?=
 =?utf-8?B?TUdWdDN4Y2llWkhBaUFpUkpHZjZHUFVwWm5sa1lpcGV1R0pmYXd2TlltOTlM?=
 =?utf-8?B?V2dGenZTY0xvMXJ0dUtCTUw4dE1QbWZWZ3dqNENqd0NjdklYREtjWDNJbkUw?=
 =?utf-8?B?VXlFNENTQnkwa1ZDWHNYMnNNRGY5THcxamhhM0pKUnE4cE5JZXJWQ1p4TFEw?=
 =?utf-8?B?MEZaWGtndm0vT093dmlKZnhITy9jSGVTcms3VVpYVy95WHZiWGxMMHI0TkZJ?=
 =?utf-8?B?VTJYc0tkTkdPNkVSY1JnMlJ1bUdOd1JpN0ZoVFhzNm9SMllmdnJ6Sk9EMXVt?=
 =?utf-8?B?TnFvelE3WEcwM3A4U21rNUtCQ3N5d0VVaGZuZll0YW9KUXV3djB5M3c1clRH?=
 =?utf-8?B?V25iWTg2MlJEd0VqbDVtUGRrK2ZMKzZSdklINkcxTDI0N3FLUjlDTmpnYXRV?=
 =?utf-8?B?K29yeXJhd0xYL3FYbVNCMjd6RkhPQjBxeE9lK3I5UFR3c3hBbklKQmlNL0JQ?=
 =?utf-8?B?c25QNlVCbDFyb3pVR1pTZlBySGRrQk9PSjlvcDg3SWtGYnowZUxwR1V3V21E?=
 =?utf-8?B?NDlwTHBRbzMwQXg3SkVxaWhKQ1JUT0FTek1jaHkrOHgwNGVvUzhkNWx6WVNi?=
 =?utf-8?B?Sk9XeDRIZHlGNjlzVnJNOWJTS1RDM0N5S1NwNW0yWWIyZGd0b2cyTllVb3NT?=
 =?utf-8?B?eHVzS0dSNVd5SXRta1kzRDlCRGJmaFJ5L3BTWk5Gc0pyNCtiRkZicHBaSVgr?=
 =?utf-8?B?REtsWEsxcEVDTlVhR0hlZXZGdmtmNHVlRXpDNm1VSW1CQ0EybzdJbFNVNUUw?=
 =?utf-8?B?QVhMTFJ1N2dMOVdrZzJJTHNUYXI4YkQxMzB2NzlVK1krOVpkMU81b2t1d2RN?=
 =?utf-8?B?UEtleGFQbm5IRWIvWFh1aWxIa2xvM3ptMzQzdit0Y05jOExBa055b0dreldW?=
 =?utf-8?B?VldOeDVoMStBalQ5ZVBFMWZYdmZkOUttOXFLbmpsM2xhOU00Y2pFQUNIWWNC?=
 =?utf-8?B?UFFFNGExdHRPeXp2cVUycU9IUzFJZDFoTWE1V00rWEZlMEtwekR0WjJmQXhL?=
 =?utf-8?B?SUxUYmlEdnJhZXZ5RjUyUGJrdmt1Z0FOTlFhdVFBTHpXWHFLZml1WTF0L290?=
 =?utf-8?Q?/w8aabWqzeq1LXcw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8920bae-ffa8-4bfa-18db-08de965f2428
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:40:50.8084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Qiz1VvvyJVrFQlvDe/4bCQz5r365bSgxYgEUkNPXStmprFs/PKwn4hSlush9u66bP3jWXNW/FdHEmdFSwGwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9007
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.13 / 15.00];
	BAYES_HAM(-2.13)[95.80%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.130.16:from];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.130.16:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C735A41B8D
X-Spamd-Bar: -----
Message-ID-Hash: IUOC32V7N3FABVTZSJCL44F3QUB3WBWD
X-Message-ID-Hash: IUOC32V7N3FABVTZSJCL44F3QUB3WBWD
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IUOC32V7N3FABVTZSJCL44F3QUB3WBWD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

Hi all,

to avoid that I'm debugging further this error I get during boot with 
CONFIG_RPMB=y in the kernel and CFG_IN_TREE_EARLY_TAS=pkcs11/fd02c9da...:

[    0.359372] mmcblk0boot0: mmc0:0001 QEMU!! 4.00 MiB
[    0.361779] mmcblk0boot1: mmc0:0001 QEMU!! 4.00 MiB
[    0.363761] mmcblk0rpmb: mmc0:0001 QEMU!! 2.00 MiB, chardev (248:0)
D/TC:? 0 tee_ta_init_session_with_context:569 Re-open trusted service 7011a688-ddde-4053-a5a9-7b3c4ddf13b8
D/TC:? 0 legacy_rpmb_init:1143 Trying legacy RPMB init
E/TC:? 0 get_rpc_alloc_res:646 RPC allocation failed. Non-secure world result: ret=0xffff000c ret_origin=0x2
D/TC:? 0 tee_ta_invoke_command:830 Error: f0100003 of 4
D/TC:? 0 tee_ta_close_session:469 csess 0xc0210910 id 1
D/TC:? 0 tee_ta_close_session:488 Destroy session

Is it possible at all to run the PKCS#11 TA without userland tee-
supplicant? I thought it only needs the supplicant for RPMB, thus should 
be fine with the in-kernel routing (which is active), but maybe that is 
not true.

All is fine - minus that error message - if I later on start tee-
supplicant and use the PKCS#11 TA then.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

