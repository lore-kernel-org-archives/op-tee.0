Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A4E99053
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 07:59:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 42EC143E8F
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 07:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775807983;
	bh=uMvymqnnYzgZxMB1Rp3+iL6eTkk8aJV9s4Ms4Mms+X4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OsBPSoZMfR0S9jnuwFkec1WYa8l6jONHQlvlULhyxiWbkNgjiLsFKem885bq31mHa
	 XOpd9Ksvvzsh9brfFml7e0CjQ4hwTXwlRptOo+Jvn5BuBTE362IXj9Q+K+vbKO67Pl
	 yKoyLMjGxBLP09NbsMMzK4n0jq6b9kM21mAY7fycdmoAmTwIADhP8C8IYkwXTkMu/L
	 saHhlp92J9wihsaoakoBqzFOcCnhIT46SxRT8Mu4x+/yLrD0jWblPLsx5i7LUDoYCV
	 oB6rSBcKl+pkLLM1bwEjjvVyDDxF3tvlTehdpr0bO15TZ68KiAibC7L8g/zw4Dy/FW
	 ZOU5TkXUIAAmw==
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D5CB243B5C
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 07:59:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=JXHKCghS;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpeF1m6a+Jqy3Pchk+LHaOrcmd9C4977xIVEw2lQBgirmmvGfC/yQhEaF5nZ6KS3kge/0exqNVzxS02uxpplqT9ElRwOx9+iod2kFgLX4wuiMBe28N3YUt3ewduBD0+2Akrd6Ta+lc3029N1aLJYm0TGRNUFr/+LallIWIcHZ7Po2ZNMW0iYNgu8zwoNhQNqvzQ2p+w2hJXNsta+X9Ll29ByIU32aEp5XmoiRqdlnUdnO8UNtCJGGv5o8pdj8FD0ToVb/wmVnaKoM2gUTjc2KJjV1U4AgxdMm7yTK4qwDe+lF5vZ6LtTxsXk2smeqo22lC+iyt3MVstpLfiE9pfouQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSZsNRplUiWkDDE7I1Y9phA8QHIii0gcGk1Bfh1vuw8=;
 b=qiazAdmCulx2yV7J7Lm8OnaZuGmKTnYO/R/lfy/9vyZAVFJtkepNDiN+hxQLLoyzZikm9ybKcgx/lhrB7T0sMvMIclLfSvpfhCKAVuV2G7uJ1mbgtcSa160eZNfFMf7Xmdmiv4/kWW2Ev3WeGAYkBOQfI2gauk5BcmIkW8ESimJd9gaYweuyKvxU5Wj9vpmyGHVKU5/86miQjqaMz3Z60UFwqR+CCCBFJKRaWoTYqpTb19vB/mkYLQ+YGiDRstBoIamVI0BmlF71HPw8XITzAGGDqSk9Ceoun+jjEZzlska9UZ8K5VpRn9cYMEMcKFaIWhrvmD+RoSRvsnrdTfe9kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSZsNRplUiWkDDE7I1Y9phA8QHIii0gcGk1Bfh1vuw8=;
 b=JXHKCghSu31xjEOtunX43D+aJH3zjMDxkI/8N0kkpjEF4rsoJICh3DVqY+4eVoNtO9iYrwvWXMTB8MoAnUZMi/RJ7NDYY3R8FobksqeZIZmapmirn1Be8EypCZyPo2Ce3+6yn3B1kqCOP6kqM+Vv0ECgug3CKWw8BM5gh15+S1sen4JTYnwbualk09qsYlRAINY8FN+4uXHYm3mN9b9Yp9eyXTsj1UfQw516ChptPXyFqFp+LoJ/XfdWRXe/nwJe1BsN4yPThIXGS+yIGiEY3vSHKsWt0ONJb8S9r51qikrvB8Bs+dYlMgGhhJt6bSnvhqabsHaYE75XsdFwOOtmRA==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA1PR10MB8373.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 10 Apr
 2026 07:59:33 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Fri, 10 Apr 2026
 07:59:33 +0000
Message-ID: <7a52b4ec-7e75-4332-b94c-726978a3a7b6@siemens.com>
Date: Fri, 10 Apr 2026 09:59:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PKCS#11 TA needs userland supplicant?
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
 <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
 <4dfd2e07-4627-4682-a8f2-bc13eafa1fe9@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <4dfd2e07-4627-4682-a8f2-bc13eafa1fe9@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA1PR10MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: e823a11c-badb-4265-74e2-08de96d719c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	BJga7mlUa09WS0dtdR3pqLO2hY0KdKRHWj9cv66+OlINVRgcz7WuTqHnPIw2ie/P6WhnZ4x4axDdMJOB7cdrSAuHn7Qc91YBu329RXL8xUbOu7qPsvmI4E7t6Lp0Hywvj9s3+jSNTWt1N86YbXubs8p+wK7DnP9j2QyI07XL62eO+scP9KukqTWgaWWxxTKMAGPfiKQo4YVhCeneaLAEA7JnMZpPzADJrPUOGvryBGLUUXSgaoINjeI/29KgHnYG+FqnnvLHG/TkRLbI1UQB9CUhJmIJYasjLqcza7Z3gYLHci/RNfyja17wGVkgGXrQmUXq4119seMCSSNZWoFauaRFcs+UIvjZiX0+tAAbaBLGaBeoymqrQAPjRWQ62+6MfquKyKeEMIJ8u/5YgiD4QJD8b/NaGlMgrqgyGI78DYJqigRWc6QKWC+42/ycoAlILv12wIjlPTsmdCypajNiKfFEB6pgtsQT5QSfHIAC8LCnBrelDN72a09tNoMtSHFar1v/U5qEX2DzAx6S6Mses8YGD6ecBiC5ZMfu5Xg+LcTxdPHfU5gQgeEBKMyAnpz0lXrY7PaM3re5VLEipfn8jjgDH0Z6mB/9mCaOlMGsN+OaXjXLd/m8hvZLGKSHwDXYeUgDZNIIFuJxQUgb8If9YPK91L6MHakBmMG4klpKQZe/czVDQPT+Ta+jrfye+ecBWz+WgM5tmZnmBInWAvsFowzkesl+OjKgRV71fHHEx9g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUtOcVE3enduU1FxL2loeDZXSXRxMUF5NEVxaE9rdXEzMmlSRldIbVhOME00?=
 =?utf-8?B?OUx3K1N5bEkrcTV4eHRmQ2pLbW00TlJZL1UrekJhUkVLdGk3VFh0NURPWnBs?=
 =?utf-8?B?U214QWVlUlVIS0UxNStQZFVPdFkxeFRERkl6TFVoTE5UTmJzcURRSWpqRUdU?=
 =?utf-8?B?RWlNdFplRjZFVVhqVTExdUljZ0RSd3h1bTJSeGFaMnE2YjIrRkd5SXdLdVRa?=
 =?utf-8?B?OHZmRjduQ0dVaURqWE1BQzU1Vk5IZk1DSGVCRDVTS3IxNEs5ZVdrL0d2bVVz?=
 =?utf-8?B?UitVUXRpZzlrOWV6cGo3OTY3VWpTZlFpb1c1elZQUklwMEdLRGU3WlAydzdS?=
 =?utf-8?B?cStNTDRuTy80ZjVPcjgxZGZtR1JmUE1YbVdoNHJCTUdCUnI1Rk1IYiszcW45?=
 =?utf-8?B?NVZJRkU5NSs0RmgwUmFRUnBqaC9KbGlwWDNCRFpLQjRIajJoVUR0aWl6MjRt?=
 =?utf-8?B?OXYrdGwzdTZ6UEVzd1dxcU1pNFFaQU1UZFkwbmRNSGJGSzhycGxmNkVLQitP?=
 =?utf-8?B?Wm83ZVZLMWxSekZqRDFsNW5YSi9jRk4vOTNmaElwMXBmRXZPRjlpNm1UL0F3?=
 =?utf-8?B?Snd2NlMrTWhTemNUVmttSHovVURWY3BSNytHUVRQZXp3YXNJSDVMWHh4YWhS?=
 =?utf-8?B?YXJZVVMwdFRxRE4rRityb000VXdOL1htSlh6ZDYyM0x4dDBBbkQyekdZNERj?=
 =?utf-8?B?V2lZektvZ3NxOHJJd290RlgyR1pLOVZkanRSUmhON0g3NXQ3cGk0OFo5OHhK?=
 =?utf-8?B?c29NSmlJNEVaWFpzV1ZhMTQ5dXVWLzd1cGpzakg1dktDVHdwNGYva2RoMjJt?=
 =?utf-8?B?MkZYdzNjUEhxblllNkNpUGNObG5TdTRUMlY0RnpwVEFWUTJRN3dDZHZIemcy?=
 =?utf-8?B?eWtoMld6SFB0VHV1ZWh0ZmJPRmVBY1FsT3ZQOHJmRW9qR3U2QmFuWHpNSG1B?=
 =?utf-8?B?ZG14K1BmVzdVRkRpY3V5UUUwcUNNNXJJUkp2VW1sZStkWDBwQUd6QVJUckpr?=
 =?utf-8?B?Zm9jTG9USU5zbmJ5ZTgybTlKUEVIQmVGaERRaU0zL1R1V1ZQMGlTSEk1WnBj?=
 =?utf-8?B?VGMzWG1MdHQ4eExVdVBocWc3VFRrRlpxRnNIS3BuWk45K0pydnpYdGpsdUZj?=
 =?utf-8?B?VHdYU0FJU1lKcU9WSFJDY3d5c2FmS3hMdmRLbFlBeThCMzNxb3NGR0J0bnpG?=
 =?utf-8?B?WTMxSlljamI5L21kc0hSQUExdmdtNG9TU0tSWFM5MmtsWUsrS3V0MFVjTXdS?=
 =?utf-8?B?NDVLRy9UYTIyd0dueHNXcko4TTJacVZmazFJbXZ0eVI5c0ZvYmcwdWY4NjYv?=
 =?utf-8?B?M1dMVlQ2UENvbG5IOWx1aWw0NGlBM1JsMzNkN1FreExjOVRoYkQvOTc0UTZy?=
 =?utf-8?B?TlE2ZS92OWJWQ0JFQXROaE95emVHZTI5RWs2S3E5Lzd0TUtxYW9valBiMmNy?=
 =?utf-8?B?aFZFQWZsV2JGNG5vNnhRUmZ2S3hmaElPVFEzUHVocXMrWExpVVQvWThyR1pL?=
 =?utf-8?B?NnBXb3hkQ2w3MXprZm91SzZpYlFsUHFHY1lMQTlNTVhvSHY5ZDlXWVVleTMv?=
 =?utf-8?B?MVhGdkVYQ2xaemQ1VVc5NTlNVHpTcXQrTWc0NE0xZElHRmp3WFpDMzI2cEFt?=
 =?utf-8?B?VkdEVjdRUG9sVlc4K3VnRGQ1MlVQRys4Y091TTc1bjdSdDZ2cHo0MERnRE45?=
 =?utf-8?B?SlNBU3JzMjlqbHZnWlNQQ2NNSHZaWUFuSUdINGtMRXZZUjB3cHhKa1JvSDlv?=
 =?utf-8?B?VzBYRjZtbkFBc2FiQzJtK2tEL1JaTllBSUY3WFAyWGpReGJLY0pkRk5RMEUy?=
 =?utf-8?B?VytKZGRJYUlnKzlGRlVXSnErTUVNRU1IRGRQdEFKZVh3THpFQmN6NmpsaEZm?=
 =?utf-8?B?YjNQWThPNjMvWW05SndPcGtCaks1blVFZHZJMG9Fek5IYVJVOEM1Qi9nbWs5?=
 =?utf-8?B?TzhRSTkyVjd2Wm9jVUZJdHhEUDEzcUo1QUhacDIzYUpCUHF6dHF2NVZCWmU0?=
 =?utf-8?B?VEFPNE9vdkduWGQxZkZYMzIrYUFFN1c2blpQMG5hbjh1Z2JQTlByT2ZnQzFn?=
 =?utf-8?B?cHQ5ZTJzTUROZDArVTY1OGJ0NldCdGNtVnVaWlJlWXdsZ3ltUFVsaG1yb255?=
 =?utf-8?B?UE1nWitad1BBY1grdjBXQyt1WGhVYjdQSFZEQUlESkNzNHAwQ0ExcFA5cGNh?=
 =?utf-8?B?cTQ1UUtQaCtDN1RzRDdGcHlwTm5neDB0ZnFHYzRYSFBOVHBMNW5seEdNaWo0?=
 =?utf-8?B?Y1NzcGw3VG1LZi9lU29ZZnNxd3J6dklTVG5GeEpDOXJldjkwVlg1SGxObEtU?=
 =?utf-8?B?dXVLdGFQaVZUditoMlVwOE1nTzFmL3JzY082bWdJR3A4SlJ6a1BjUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e823a11c-badb-4265-74e2-08de96d719c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 07:59:33.0110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2U/kWiaVm4LOX7iKYZvEVWTV4enK1YaVTj0E0jgmy9Y1U2sHyUCGt3/p9MrJJ9Skl4onkHxHnVco188UTMh4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8373
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.83.65:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:150:76::15:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.83.65:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D5CB243B5C
X-Spamd-Bar: -----
Message-ID-Hash: WY7RYKTV3XEGC6Q25WL6AWYZ6VJDQKQD
X-Message-ID-Hash: WY7RYKTV3XEGC6Q25WL6AWYZ6VJDQKQD
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WY7RYKTV3XEGC6Q25WL6AWYZ6VJDQKQD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

T24gMTAuMDQuMjYgMDc6NDUsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDEwLjA0LjI2IDA3OjM3
LCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IE9uIFRodSwgQXByIDksIDIw
MjYgYXQgNzo0MeKAr1BNIEphbiBLaXN6a2EgdmlhIE9QLVRFRQ0KPj4gPG9wLXRlZUBsaXN0cy50
cnVzdGVkZmlybXdhcmUub3JnPiB3cm90ZToNCj4+Pg0KPj4+IEhpIGFsbCwNCj4+Pg0KPj4+IHRv
IGF2b2lkIHRoYXQgSSdtIGRlYnVnZ2luZyBmdXJ0aGVyIHRoaXMgZXJyb3IgSSBnZXQgZHVyaW5n
IGJvb3Qgd2l0aA0KPj4+IENPTkZJR19SUE1CPXkgaW4gdGhlIGtlcm5lbCBhbmQgQ0ZHX0lOX1RS
RUVfRUFSTFlfVEFTPXBrY3MxMS9mZDAyYzlkYS4uLjoNCj4+Pg0KPj4+IFsgICAgMC4zNTkzNzJd
IG1tY2JsazBib290MDogbW1jMDowMDAxIFFFTVUhISA0LjAwIE1pQg0KPj4+IFsgICAgMC4zNjE3
NzldIG1tY2JsazBib290MTogbW1jMDowMDAxIFFFTVUhISA0LjAwIE1pQg0KPj4+IFsgICAgMC4z
NjM3NjFdIG1tY2JsazBycG1iOiBtbWMwOjAwMDEgUUVNVSEhIDIuMDAgTWlCLCBjaGFyZGV2ICgy
NDg6MCkNCj4+PiBEL1RDOj8gMCB0ZWVfdGFfaW5pdF9zZXNzaW9uX3dpdGhfY29udGV4dDo1Njkg
UmUtb3BlbiB0cnVzdGVkIHNlcnZpY2UgNzAxMWE2ODgtZGRkZS00MDUzLWE1YTktN2IzYzRkZGYx
M2I4DQo+Pj4gRC9UQzo/IDAgbGVnYWN5X3JwbWJfaW5pdDoxMTQzIFRyeWluZyBsZWdhY3kgUlBN
QiBpbml0DQo+Pg0KPj4gVGhlIGluLWtlcm5lbCByb3V0aW5nIGRpZG4ndCBpbml0aWFsaXplIGFz
IGV4cGVjdGVkLCBzbyBPUC1URUUgaXMNCj4+IGZhbGxpbmcgYmFjayB0byB0aGUgdGVlLXN1cHBs
aWNhbnQgYmFzZWQgUlBNQiBjb21tdW5pY2F0aW9uLg0KPj4NCj4+DQo+Pj4gRS9UQzo/IDAgZ2V0
X3JwY19hbGxvY19yZXM6NjQ2IFJQQyBhbGxvY2F0aW9uIGZhaWxlZC4gTm9uLXNlY3VyZSB3b3Js
ZCByZXN1bHQ6IHJldD0weGZmZmYwMDBjIHJldF9vcmlnaW49MHgyDQo+Pj4gRC9UQzo/IDAgdGVl
X3RhX2ludm9rZV9jb21tYW5kOjgzMCBFcnJvcjogZjAxMDAwMDMgb2YgNA0KPj4+IEQvVEM6PyAw
IHRlZV90YV9jbG9zZV9zZXNzaW9uOjQ2OSBjc2VzcyAweGMwMjEwOTEwIGlkIDENCj4+PiBEL1RD
Oj8gMCB0ZWVfdGFfY2xvc2Vfc2Vzc2lvbjo0ODggRGVzdHJveSBzZXNzaW9uDQo+Pj4NCj4+PiBJ
cyBpdCBwb3NzaWJsZSBhdCBhbGwgdG8gcnVuIHRoZSBQS0NTIzExIFRBIHdpdGhvdXQgdXNlcmxh
bmQgdGVlLQ0KPj4+IHN1cHBsaWNhbnQ/IEkgdGhvdWdodCBpdCBvbmx5IG5lZWRzIHRoZSBzdXBw
bGljYW50IGZvciBSUE1CLCB0aHVzIHNob3VsZA0KPj4+IGJlIGZpbmUgd2l0aCB0aGUgaW4ta2Vy
bmVsIHJvdXRpbmcgKHdoaWNoIGlzIGFjdGl2ZSksIGJ1dCBtYXliZSB0aGF0IGlzDQo+Pj4gbm90
IHRydWUuDQo+Pg0KPj4gWWVzLCBJIHRoaW5rIHNvLiBJIGhhdmVuJ3QgdHJpZWQgaXQgbXlzZWxm
LCB0aG91Z2guIEFueXdheSwgdGhlIGxvZw0KPj4gdGVsbHMgdGhhdCBPUC1URUUgaXNuJ3QgdXNp
bmcgaW4ta2VybmVsIHJvdXRpbmcuIFlvdSBjYW4gYWxzbyBjaGVjaw0KPj4gL3N5cy9jbGFzcy90
ZWUvdGVlcHJpdjAvcnBtYl9yb3V0aW5nX21vZGVsIHRvIHNlZSB3aGF0IHRoZSBkcml2ZXIgaGFz
DQo+PiBuZWdvdGlhdGVkLg0KPj4NCj4gDQo+ICMgY2F0IC9zeXMvY2xhc3MvdGVlL3RlZXByaXYw
L3JwbWJfcm91dGluZ19tb2RlbA0KPiBrZXJuZWwNCj4gDQo+IEFuZCBpZiBJIGJ1aWxkIG9wdGVl
IGFzIG1vZHVsZSBhbmQgbG9hZCBpdCBsYXRlciwgdGhlbiBjYWxsICJwa2NzMS10b29sDQo+IC0t
bW9kdWxlIC91c3IvbGliL2xpYmNrdGVlYy5zby4wIC1JIiwgaXQgYWxzbyB3YWl0cyBmb3IgdXNl
cnNwYWNlIHRlZSBoZXJlOg0KPiANCj4gLi4uDQo+IEYvVEM6PyAwIHRyYWNlX3N5c2NhbGw6MTQ3
IHN5c2NhbGwgIzggKHN5c2NhbGxfY2hlY2tfYWNjZXNzX3JpZ2h0cykNCj4gRi9UQzo/IDAgdHJh
Y2Vfc3lzY2FsbDoxNDcgc3lzY2FsbCAjNDEgKHN5c2NhbGxfc3RvcmFnZV9vYmpfb3BlbikNCj4g
RC9UQzo/IDAgbGVnYWN5X3JwbWJfaW5pdDoxMTQzIFRyeWluZyBsZWdhY3kgUlBNQiBpbml0DQo+
IEkvVEM6IHRocmVhZF9ycGNfYWxsb2MgMCwgYXJnLT5yZXQgZmZmZjAwMDANCj4gSS9UQzogZ2V0
X3JwY19hbGxvY19yZXM6IGJ0IDAgc2l6ZSA4MTkyDQo+IA0KDQpJIGluc3RydW1lbnRlZCBmdXJ0
aGVyLCBhbmQgSSdtIGdldHRpbmcgYW4gT1BURUVfUlBDX0NNRF9TSE1fQUxMT0Mgd2l0aA0KT1BU
RUVfUlBDX1NITV9UWVBFX0FQUEwsIG5vdCBPUFRFRV9SUENfU0hNX1RZUEVfS0VSTkVMIC0gdGhp
cyBpcyB3aGVyZQ0KdGhpbmdzIGFyZSBmYWlsaW5nIG9yIGJsb2NraW5nLg0KDQpKYW4NCg0KLS0g
DQpTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwgVGVjaG5vbG9naWVzDQpMaW51eCBFeHBlcnQgQ2Vu
dGVyDQo=
