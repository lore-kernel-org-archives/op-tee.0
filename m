Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55853F94CB2
	for <op-tee@archiver.kernel.org>; Wed, 22 Apr 2026 05:16:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6BBFF443ED
	for <op-tee@archiver.kernel.org>; Wed, 22 Apr 2026 05:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1776834994;
	bh=FesLDIRUE2+OYs4nvqwXF9CpFARWkMuzi+dLNs5IqRg=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=No0BASBtYMkAITrEDA0QU+6Fu/UQkilcMP+eeZxxUH4Izvkne5voUQ55DXlMBJS2e
	 91N6vZISuw+VLmS2kbDaWfzjPI0aucNGrgMZtricCYJQsoIueMQzVXTDl9WAPwN6Do
	 XNd4ogaXDGzqthvvY+T8RJuT06O7M5OxO3Kw8Fbu+12ObdVFCE1iu6rubwCNe4fEfD
	 AIwe2k6VFQCnQRS1GpNzQiGtCtHslqD7pNpYR4AcCaUd0k1AhTmR2zK2PNUnfysckE
	 y9HLZLK6usYEFRn8e+4DrtpW15UQS6x1f0EXE7wIuqM+gMawIuNsnTeI2hjRvVaVvP
	 77gIJSUc+MRIQ==
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DFACF43298
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Apr 2026 05:16:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=trghVSDZ;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpMz0KE2mNSbu4Erd8K+FZy3XTRwWbpEC+7XHZXOVDpf3JkU2WSP/qeYkjf+H0YtjqnzWI5iS3vtc44C6ljZrzZ75lxy1vv/pTm44badzgO8DTRU0BuAVKRv4b7K6o/sl/zoe9DlBnjs6QHqwHBgyg+mzpXLbyLGRXEqB4RJVgKJGwblnf0wK+MFGBIr6JuagfHkzuSzvDAVKAccoqjj9eNZoxjwiNFjwaHl0TVz8oWvFNPInBbFO3S8mSazuazUHPBhZoQHKcieVPUQF3mVcXWy67fjZOjznanNzaGrpopXmnGmlGrAs1Vylzu/sWk5ucNq7ZzP9zSS7JRUUytwIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMjNsJggv4ktMma4DsljU0+h7noo3+Zj2YvfGJvkhCI=;
 b=D62WXh0B+gtrfhHX3xJ27KDsUMhaP6BRGf8BiQCp4OPRYAQmssBZA+MHmoxRb18tQ/TZxUOwC8cBrCOIjn9DtL0NgB/NMV1dwcjOCXZjO8H+14NEsWhHZpVPPJrx9EisOHAR9G5K45R8SHuyf61uplhONACsok7k3UMsyVqAMPo8plfXMxth3YY5UUcpnBdKNa+Cl3MKOLlnOqWlG11CDqUeQatyHr4z+qORM6x6HeteElPgpFVwjTznEzAy0wsTK5ul3EIswBzPU700fFHBd/K+iOK/kT5in9bXOs76NTn7xQBrdlLGtFJQCouR1Azp5qoRU+vvmPcqzsbTG4yPpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMjNsJggv4ktMma4DsljU0+h7noo3+Zj2YvfGJvkhCI=;
 b=trghVSDZC4e7qVZ7/EMJmSgKKQg8cLAgF9qcwx1MzO/DzzXEBdmkeHYbzxDOsWLmOEikvyLcSiAN/N7bT2sZk4XT8c8LoV3YaO2qt59jflv0BlyGuS6XahFvETKKSyjgx5/hGMC8BWLOXnpMQfgII5tfuAajNaUjvBVTC3d7CJg=
Received: from CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 05:16:23 +0000
Received: from CY1PR12MB9698.namprd12.prod.outlook.com
 ([fe80::30a4:a862:48ee:be82]) by CY1PR12MB9698.namprd12.prod.outlook.com
 ([fe80::30a4:a862:48ee:be82%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 05:16:23 +0000
Message-ID: <d5b6d46d-4f35-4c85-ab09-99ab5aa9f8f0@amd.com>
Date: Wed, 22 Apr 2026 10:46:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tee: amdtee: store buffer ID in tee_shm->sec_world_id
To: Rijo Thomas <Rijo-john.Thomas@amd.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>,
 Kees Cook <kees@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <6dce58425a88ec3883c7ebf42d7ef367d68b6911.1774597729.git.Rijo-john.Thomas@amd.com>
Content-Language: en-US
In-Reply-To: <6dce58425a88ec3883c7ebf42d7ef367d68b6911.1774597729.git.Rijo-john.Thomas@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0029.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::11) To CY1PR12MB9698.namprd12.prod.outlook.com
 (2603:10b6:930:107::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9698:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 035fdfe4-ebb9-4b1a-935a-08dea02e4bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	20JIYo9WprXVv1mMuePleV7+aCWVF2kEWteOTguB9yV5tAA1QuZfgcB8bBjCHFmqG0FIM3ZgpWaUYoA1vIiTzc+UqMVt3H4lCPjYJMBpbCmX3R13ADwQnf3Wt1SiSK2qMyOIefLtH5tHl0Zrw5zzJ8VUsd65ioEwBcZjq5jXv83JbLbrwO9aMOxk9j78p9me1U780SUDbVyu1wZ5vMw2CXoafGjtwsPKeAl4EzyojCy4adFf6p7Wj+dDv2jQEo/V/tUL9EHvp3ls1LEDl4tQ3/tWo6Xk72cegC7pblao0+mp43R7tzBGFWyouFdzmbx4QcCsWpiAaR/Ys0P19OqFeDQqNk+pctdQpeA0MmgI6ZwZjpx9aaHAcN+GW/KXo2siYkb16yGnF9+WB7WtpSMzHzBtVeCoTJlNoJ11TTccqFk43rXueEHPJtkMdAJ5Bqa+YUKeZURoR+Tb/HMsH4ZA1IQd603NVgt4hqwpJ8GzoKivgPZ5pmffCNJN2uzET0zT8WW5Fav5n4aZS8s1xKl4BgLe7rW+26B3V+SmKq/mUcHiEsmAyiiuLJNlZbI9azx2ZMRSpSq8aX4BYdiVAeZGnkr3dv+LjDyYCrw676VfaqA7EuFMdgDZK0d87V/KIFQO5x2qBHaF0pM1ohHDxt9OfBdLTCQGcMrIJ6vhQXw4jeG0+izA3o98Hkybu9JHc23CR6sD+BH2GqaR0Ckrs1kSgrLvTLRDcpWQWe4PDpAhWGo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9698.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGhvYVRZVVdEbHlrRkY0T2REMldScmp3OGxGbENtWkoveFJvTlZDeStKeVZB?=
 =?utf-8?B?SjcreVZmRzVaTUFGN0lhaFFQRjVPS2I1Qk1BenZsRFY1N096UUxTMnRUY3Ns?=
 =?utf-8?B?Z3pIRjZYNGFNMFBidG9PdmYyNmpaSS8wZjB1TUN0eGpKQis1eVZlSVlSZVdq?=
 =?utf-8?B?cFhjL29EMkVWa1pFYkxYYTg2VlluN1JPT0ZjTkZPUzAzVWNROHRXLzRDenZr?=
 =?utf-8?B?RWN6L0NEVWw3ZGYra3VOM3lFVzFiMmhFSUgyekZ6amZPU0d6TXp6YXYrcHpx?=
 =?utf-8?B?UGd6Zmgya3ZIaDFOYW4yR3VQbER3UXROdVV6SXRuQ0tqM0VxSnhhVmZOUElQ?=
 =?utf-8?B?bXRlbzZlaUtCNnZTN2NaUnNUYzhXNWpBM2d3RkR3djlKdnY1S1d2dFpHcVNF?=
 =?utf-8?B?bDhZdjVvSEc3YkZHbHNWOXpFNmdsZFVLbzIyWXRoTWFoaWtNb0R0U0ZTeUxk?=
 =?utf-8?B?dkRrUjZkUjVHTmNGUFdFRnpZSFkrc2hjT1crYlpHMURFdVZlNS9TL1MwQTFw?=
 =?utf-8?B?K2FZUFQ1MUdwMDdqOEtlMDNhRW9ZQlJOVWRhZnBFMXc0N0E4WVJwYW9OQUhQ?=
 =?utf-8?B?bSt4OE1FYzVaclJRWkQ5L01MM2xiMldLRWVlY0RQOTdGalFKRFMwWE9POFl1?=
 =?utf-8?B?V0FBZStWaEFJY0w1dE1sSnpGcGJCMEN6WGFnUzR5RnBJbEtsOE9DY20reVgx?=
 =?utf-8?B?K1VuU0pBWnIyL0lLeHhMZUt3TmhpcXZIZ0JuYk11R2VZc3E4UVhwYVY1TVZp?=
 =?utf-8?B?cEh6djBSNlpFZnVKV21xTXpBbEJaV2hUV1hCcEQ0VVVDbGw0UytIeDVraU90?=
 =?utf-8?B?WC9lamlGbTlxS2luWkp2NnlHMkYwYmhET0F0ZDZVRG5nVGlCSERpb3hFQ0ZY?=
 =?utf-8?B?RnRCRzRlQkxmTUxYVnREb1czVWhtMkNDK1JUTmh0S1hnelFwMWM5SVo2cHcv?=
 =?utf-8?B?aGxPNW02VWJRQ2NMRi9NUG5jYXF1T3ZFWStsVHJGQ094R2tweU84NGhUeHRl?=
 =?utf-8?B?RTd5T1dYNzZJQWRCaVMvWWUydE81Nk50bFhhV2crZGdmY2Z2SnFPNGMya2tt?=
 =?utf-8?B?Skx0VkJNVDNLOHpYM3hEYUZ6bkd6czZ6UTNDbWpaVktCbHU0WlR4MHYvdytN?=
 =?utf-8?B?MTN5cnMrWmVoWHZiRHZjbVovb3VSb01hVUdMTFVIWjRNV1JWcGxOTlRpODAx?=
 =?utf-8?B?YWVLVjV4cmY0V0kzNS81T1p1RnZUOW1BQnQrUDB4YWwrRjZvbjRHZUVjVzFl?=
 =?utf-8?B?cTN2WkJCTmd0NU10UTJDMXc1WlAyRnZFck5kRlZlUkJtRW9ObmFPWHRYNlNv?=
 =?utf-8?B?WjVxRFlsZnNIMlNYa0tYSkdTQXFYVnJiNmlEcER6bitFSkNBdGJuL25NRmJj?=
 =?utf-8?B?UlhUWXIweExRd1hJQy9obFJpQW9hVDJrZS9kV1VMdmI5aDhJQ0NxUUowMlY3?=
 =?utf-8?B?QldEcjZ5Z2JLMVdDbVNLVzVodG9DaksyeENWdFV0LzRVeUk1VjBGVlBjVGQw?=
 =?utf-8?B?dlVDV0xwVC95ZkZ5bnczRDY0WUJwN0FuWWRFb09TclFzYU15SVVsVnE2Ymdp?=
 =?utf-8?B?VVRPMWFuQVJjRHkzeWMzeVJabmljUUJBTlBpR3FUMVRybXc3WlpUNENzdGhC?=
 =?utf-8?B?S0dtTnMyTGl6NXkrOFhmVDlvZUU2dkw2V0hSWEl0V0VvU2VoRExTejU2eVd3?=
 =?utf-8?B?bThRL1huMGo5SStEQUdjYnVNKytUYUtrd0w0MGZ2ZW1VUG4xSHlBdWtkMC80?=
 =?utf-8?B?NTJWYVh5MVVVZ3VaOWZzUjF0QXJ2bW1LdEtpdGdXVHZNMXNPOXJaR1J5Nkkr?=
 =?utf-8?B?azVYc0dPZlBLQW9iQjFXcHNPUVZTYU0yMVY4R1JFblBYOVB3NXpWT05LUTNV?=
 =?utf-8?B?OXJQSG5GR0EyYmxRVDl0bDhHbmN4aWtjSEl6T1ptSjNwNDRzcUZJOCtQRWgv?=
 =?utf-8?B?Y1VBZ1pzcHh2UWIxTWlLckxWWHYrMHhhRENSdk1EZm0xcUtBc2lZWU1OcFMw?=
 =?utf-8?B?MlhXcHhsTlJFUXJESDB1dlZCanRrdWNqaHdjWTBSVGJvZGJiYkVKYzBiUC9i?=
 =?utf-8?B?MFdWS3Z3bVdQM2JvTndkSS9UMW0ybXZWL3BUNG5wNlR6WjRzajd4NlFrWlZN?=
 =?utf-8?B?OVRPS05FU2E5b3JTRFNISGxkNnByd3kyMjlBUEFMbmpyY2FqaDU2RVhUbCsy?=
 =?utf-8?B?N042bUEwTXl1SEtDaW0rdGEyY2gwNW1jNldxYmpsSW10MVhhWVAzRHE0QWt6?=
 =?utf-8?B?M0s1VGVESjRRUkp5OW5UZzRjQWFiUlhFY1N5RXNYWDVtMlZXTmpaK3RWdENa?=
 =?utf-8?B?V3RnYjRPbHFTbWtQVzh3OUFZZXROZTNBWDgvYmVuMjI4MW5kTFltUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035fdfe4-ebb9-4b1a-935a-08dea02e4bcd
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9698.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 05:16:23.4716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnER/JH+sOgKQtvnpFz+HkaQeIs9hg8diRU5C4DgKA2X5zFmJSI3prerH6CU03rLD9rMattNhs3nUEUzogzm/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:40.92.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[amd.com:dkim];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.93.198.17:from];
	ASN(0.00)[asn:8075, ipnet:40.80.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.93.198.17:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DFACF43298
X-Spamd-Bar: ---
Message-ID-Hash: 5NYHL7PFN22L5UFT7YYXGQD6B3EQH7R4
X-Message-ID-Hash: 5NYHL7PFN22L5UFT7YYXGQD6B3EQH7R4
X-MailFrom: Devaraj.Rangasamy@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Rajib Mahapatra <rajib.mahapatra@amd.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5NYHL7PFN22L5UFT7YYXGQD6B3EQH7R4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: "Rangasamy, Devaraj via OP-TEE" <op-tee@lists.trustedfirmware.org>
Reply-To: "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>

On 27-03-2026 14:56, Rijo Thomas wrote:
> Drop struct amdtee_shm_data and the per-context shm_list. In
> handle_map_shmem() save the returned buf_id in shm->sec_world_id
> instead of allocating a list node. Use shm->sec_world_id (with
> get_buffer_id() removed) in amdtee_unmap_shmem() and in call.c when
> building memref params. Remove shm_list and shm_mutex from
> amdtee_context_data.
> 
> Aligns amdtee with other TEE drivers (optee, tstee, qcomtee) that use
> tee_shm->sec_world_id for the secure-world handle.
> 
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Looks good.

Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>

> ---
>   drivers/tee/amdtee/amdtee_private.h | 16 ---------
>   drivers/tee/amdtee/call.c           |  2 +-
>   drivers/tee/amdtee/core.c           | 52 +++--------------------------
>   3 files changed, 5 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
> index d87050033894..2c5ba02258b8 100644
> --- a/drivers/tee/amdtee/amdtee_private.h
> +++ b/drivers/tee/amdtee/amdtee_private.h
> @@ -65,13 +65,9 @@ struct amdtee_session {
>   /**
>    * struct amdtee_context_data - AMD-TEE driver context data
>    * @sess_list:    Keeps track of sessions opened in current TEE context
> - * @shm_list:     Keeps track of buffers allocated and mapped in current TEE
> - *                context
>    */
>   struct amdtee_context_data {
>   	struct list_head sess_list;
> -	struct list_head shm_list;
> -	struct mutex shm_mutex;   /* synchronizes access to @shm_list */
>   };
>   
>   struct amdtee_driver_data {
> @@ -83,17 +79,6 @@ struct shmem_desc {
>   	u64 size;
>   };
>   
> -/**
> - * struct amdtee_shm_data - Shared memory data
> - * @kaddr:	Kernel virtual address of shared memory
> - * @buf_id:	Buffer id of memory mapped by TEE_CMD_ID_MAP_SHARED_MEM
> - */
> -struct amdtee_shm_data {
> -	struct  list_head shm_node;
> -	void    *kaddr;
> -	u32     buf_id;
> -};
> -
>   /**
>    * struct amdtee_ta_data - Keeps track of all TAs loaded in AMD Secure
>    *			   Processor
> @@ -168,5 +153,4 @@ int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
>   
>   struct tee_shm_pool *amdtee_config_shm(void);
>   
> -u32 get_buffer_id(struct tee_shm *shm);
>   #endif /*AMDTEE_PRIVATE_H*/
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index 441b2ceaafc3..23ccd0f037a7 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -45,7 +45,7 @@ static int tee_params_to_amd_params(struct tee_param *tee, u32 count,
>   
>   		/* It is assumed that all values are within 2^32-1 */
>   		if (type > TEE_OP_PARAM_TYPE_VALUE_INOUT) {
> -			u32 buf_id = get_buffer_id(tee[i].u.memref.shm);
> +			u32 buf_id = (u32)tee[i].u.memref.shm->sec_world_id;
>   
>   			amd->params[i].mref.buf_id = buf_id;
>   			amd->params[i].mref.offset = tee[i].u.memref.shm_offs;
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index a1347d04b3ac..0e56f4cf2697 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -43,8 +43,6 @@ static int amdtee_open(struct tee_context *ctx)
>   		return -ENOMEM;
>   
>   	INIT_LIST_HEAD(&ctxdata->sess_list);
> -	INIT_LIST_HEAD(&ctxdata->shm_list);
> -	mutex_init(&ctxdata->shm_mutex);
>   
>   	ctx->data = ctxdata;
>   	return 0;
> @@ -87,7 +85,6 @@ static void amdtee_release(struct tee_context *ctx)
>   		list_del(&sess->list_node);
>   		release_session(sess);
>   	}
> -	mutex_destroy(&ctxdata->shm_mutex);
>   	kfree(ctxdata);
>   
>   	ctx->data = NULL;
> @@ -152,23 +149,6 @@ static struct amdtee_session *find_session(struct amdtee_context_data *ctxdata,
>   	return NULL;
>   }
>   
> -u32 get_buffer_id(struct tee_shm *shm)
> -{
> -	struct amdtee_context_data *ctxdata = shm->ctx->data;
> -	struct amdtee_shm_data *shmdata;
> -	u32 buf_id = 0;
> -
> -	mutex_lock(&ctxdata->shm_mutex);
> -	list_for_each_entry(shmdata, &ctxdata->shm_list, shm_node)
> -		if (shmdata->kaddr == shm->kaddr) {
> -			buf_id = shmdata->buf_id;
> -			break;
> -		}
> -	mutex_unlock(&ctxdata->shm_mutex);
> -
> -	return buf_id;
> -}
> -
>   static DEFINE_MUTEX(drv_mutex);
>   static int copy_ta_binary(struct tee_context *ctx, void *ptr, void **ta,
>   			  size_t *ta_size)
> @@ -342,8 +322,6 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
>   
>   int amdtee_map_shmem(struct tee_shm *shm)
>   {
> -	struct amdtee_context_data *ctxdata;
> -	struct amdtee_shm_data *shmnode;
>   	struct shmem_desc shmem;
>   	int rc, count;
>   	u32 buf_id;
> @@ -351,10 +329,6 @@ int amdtee_map_shmem(struct tee_shm *shm)
>   	if (!shm)
>   		return -EINVAL;
>   
> -	shmnode = kmalloc_obj(*shmnode);
> -	if (!shmnode)
> -		return -ENOMEM;
> -
>   	count = 1;
>   	shmem.kaddr = shm->kaddr;
>   	shmem.size = shm->size;
> @@ -366,44 +340,26 @@ int amdtee_map_shmem(struct tee_shm *shm)
>   	rc = handle_map_shmem(count, &shmem, &buf_id);
>   	if (rc) {
>   		pr_err("map_shmem failed: ret = %d\n", rc);
> -		kfree(shmnode);
>   		return rc;
>   	}
>   
> -	shmnode->kaddr = shm->kaddr;
> -	shmnode->buf_id = buf_id;
> -	ctxdata = shm->ctx->data;
> -	mutex_lock(&ctxdata->shm_mutex);
> -	list_add(&shmnode->shm_node, &ctxdata->shm_list);
> -	mutex_unlock(&ctxdata->shm_mutex);
> +	shm->sec_world_id = buf_id;
>   
> -	pr_debug("buf_id :[%x] kaddr[%p]\n", shmnode->buf_id, shmnode->kaddr);
> +	pr_debug("buf_id :[%x] kaddr[%p]\n", buf_id, shm->kaddr);
>   
>   	return 0;
>   }
>   
>   void amdtee_unmap_shmem(struct tee_shm *shm)
>   {
> -	struct amdtee_context_data *ctxdata;
> -	struct amdtee_shm_data *shmnode;
>   	u32 buf_id;
>   
>   	if (!shm)
>   		return;
>   
> -	buf_id = get_buffer_id(shm);
> -	/* Unmap the shared memory from TEE */
> +	buf_id = (u32)shm->sec_world_id;
>   	handle_unmap_shmem(buf_id);
> -
> -	ctxdata = shm->ctx->data;
> -	mutex_lock(&ctxdata->shm_mutex);
> -	list_for_each_entry(shmnode, &ctxdata->shm_list, shm_node)
> -		if (buf_id == shmnode->buf_id) {
> -			list_del(&shmnode->shm_node);
> -			kfree(shmnode);
> -			break;
> -		}
> -	mutex_unlock(&ctxdata->shm_mutex);
> +	shm->sec_world_id = 0;
>   }
>   
>   int amdtee_invoke_func(struct tee_context *ctx,

