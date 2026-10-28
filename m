Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76820606A326
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=Flg/+Jy8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IL3iPKr1
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DB79A453B4
	for <op-tee@archiver.kernel.org>; Wed, 28 Oct 2026 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1793178531;
	bh=fDOEem4OxChHnpeZAcCuO4UTY7zZJt66G6A5x/IaHrE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Flg/+Jy8jFS+lsdVQewzY440rpYGdPTYE2rl//h/UfyyEvmrIlpmotB/KdJmzdLAC
	 RluNtAJ2z3c1AtZs3mEzt7wrAWtBsyiMlyOI6FdDJb8ayr13lAk7+dyJNPhDxt45Tu
	 k9hd6febZakLjDOUNjCgCYfWSkeVoOin8a6wSzDmbp7gpNOiEUnS5muaYQPGHzIN9V
	 MjUNh8en5ponML+/vA/RYjI/WrBnS/4mmPq65+pH4IS87HYI7oVjYVbfAbvX2c07NJ
	 K4t0AzgHggJ1D/l0ZxSrqftW32u/SAH+Ib7yAUmil9agA0Ii0pjM+8GizijW4eQYtI
	 XGvofplDPgiWQ==
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5115544E0F
	for <op-tee@lists.trustedfirmware.org>; Wed, 28 Oct 2026 09:08:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=IL3iPKr1;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7sU3M9thoqk8P7IyWI/27gIETMJJQZkFRzHZ0dAcKMy2VElcz7kK1oAVJMH6BikE9VT4Q5XrFAVfN5Rw9dYHg/thHDJKcgcqpK+cVufJAI35XzDs2VMHsUN8sbfkfES7fes5A8CAqts0f5clZab4YicKpXOEgXNDt5SFORHPNdfTnWPuvUIzvirVGq2Y5nczG2P1U3exYpKZe+wLXh90yoe7MRJGXG+QFtQd7YduRORD43ZszA2j0MoCISS+Xq88zuBCqxgYxsEmdmPKqdAA05v+4oKmywUh2yKdItTKhhaJh3eaENS3pGykb0HC/iMSIVbez0rXRQWsvzIw3PzZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhMP2GSzndqRGZG1tUJDo/oF/s+beANDgJEN/n9KVXA=;
 b=WC3hb9ZmmSt8I5oY9NQqHbkA8yvxDIAvv5dhKsOMYdMIoGEYMBxSCfwtSOw8zjnleZ3BSqk3iTI+DzDK9bqvgF3NkkjOC+OHEcYxvBAqRcGh05oCOBlgdbE61EheA2/+srkWuq0TxwPgHT7S2px087P2bjoKkgjbqwEpaxib5CpRGQuCEfbWiMtigaDxjkuWTFrZYIKVpIHs/FDgBmA0isRVg0i+dt0mT6q3HH95xidJmlTnjpli1Ym8zFmU5zWzkenPfGlA6nrYBDi9zCy8D8PRTVjFP/5VfXSaU1eFtMhY9nd4f5LUqS5bVl8tQJ0nldG6ys7DT9KgaDlQ2D5rpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhMP2GSzndqRGZG1tUJDo/oF/s+beANDgJEN/n9KVXA=;
 b=IL3iPKr18J9fJxIY+B7HkFVE+yNPTNad2eFFNCiYDEUdlwcFLZrU6OSaf3CdnNFdg2SWUZOIKZ9zJzG8Waf2XzdhvLKJsqVHZvkZyFlVyI5Rck1OlF/xCmRYO0Ku6qgJ1/xbs50U9cnDQcbsj139SDLP2jNiu/SgLSXZ4pPFsK8=
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 09:08:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 09:08:28 +0000
Message-ID: <d76d8bfe-e955-4e90-9f5f-e3e914c0869c@amd.com>
Date: Wed, 28 Oct 2026 10:08:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] dma-buf: transfer memcg charges via
 DMA_BUF_IOCTL_XFER_CHARGE
To: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>, Christian Brauner
 <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
 <20261027-v2_20230123_tjmercier_google_com-v3-7-78d2c4cb8647@redhat.com>
Content-Language: en-US
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-7-78d2c4cb8647@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0343.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ee7622-6120-46f2-fa0e-08df34d307d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|7416014|261009223027099003|261009221227099003|261022105027099003|261021121427099003|10067099003|56012099006|261026121527099003|22082099003|18002099003|921020|4143699003|11063799006|261026140227099003;
X-Microsoft-Antispam-Message-Info: 
	XiOXTj8yT69rhwWvN0vqrdJEbKLUJJDVcUfapW1wB/MW7HBtdIl2E/zzn8UOJKWnFWXEzZTJxHdDm/X0oCPsaKSPNyZEVtFAiFA3Cq5sGz4UpIWww6nGFdZORjgKNM3wuTl/yCIkPzTr777wB288omoEpSs/ZyJBxQ4i3LEO+ZWRIReNOI75LPYrGnu5oGaj2lrPO8ZmrkZPcw8tr6jih8FiIpVMnaQUV5i0aCee+3IDIR4O46xFXc6x7u4jKJSEfzFPftl2YqgUu4pZargK5lqVSJXdqpZnIPKMTNb5Ols6Umtwui72QNvYr/LdmqQkznukHb5e5lZ1xjZwezyP8NOzdyM8vfr9rzRdeyo6dofFFqumQo3UnrS4icDQ6budu9B+q3UnPErxU1fPtPD7yEJtTmaNqHH40ywnoBSI5XmFVA+mrkRiXf7ruAbtFwGMEB5YOKjIoOG3JXLS60DHR5EjkekxqhZPay45ZhP7KWvxhS3MOEPjbGtxaPyIc9Ov5yCSTW2SJxwHojjQSccEd16n2VlipI+UiG2ChNsDheXzTI0UjeUkZFOF0PRAtf3L6h2MEyAVxz7SRt8dPuYtZzibR72mzLDfs7mNhCOY8jZzYLwWq1pk5klN7ABNBP4BKIJBfcIFyL2f5vvrzTiEB3z6Ug/FiWqbnKn7ztRxljyUN1vxLJYWOGiK1YsLjMX6QFhh3pN+lH3jNj0sBa4y+A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(7416014)(261009223027099003)(261009221227099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(22082099003)(18002099003)(921020)(4143699003)(11063799006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmdOcm1BRWk0UDNWOGF5clVuV1hWMy9zcmRpSXkxeWdGelFRc1orUWRIMDFS?=
 =?utf-8?B?dTBaNnFtSEdSWk5UVVVpMFIvaHVhQnczNzZPVDkwMzZRWDB4T0lPREUyLzV4?=
 =?utf-8?B?cWxmU3RIQmRKSXVKS2l4V0M5WjZLVFFzTDJ4SDBOY2oxTmwrVmZMQlFRSklZ?=
 =?utf-8?B?c29leUtPa3RVd3RjYWl1eHp1dFNLTWZ6cUxWaG91alhGdURORU5XUTQ1NTFN?=
 =?utf-8?B?ZGowNFd2VDl5bC8zRnZ4WUxjSHRkN09pOVB4WmR2NW01WGdDa1k1TlNiSXcr?=
 =?utf-8?B?Wk51M0tVRC82bGVHblRCWHl0MmllUWMrWnpETmRTOTRPQ2prRDJoaEZUUVV5?=
 =?utf-8?B?aVV0T2Z0SGNSaEtsanJhY095Ui91Yk5HczY3RXpuTE9yVXFWMEFydEdrMFFI?=
 =?utf-8?B?N3hQQmVVV2hyckI3bFdWWmYycHZZa2E0MkZ5cmRrNmdlQ05ueHJjS3ViQ2RL?=
 =?utf-8?B?aUxxcWR2MW00K2sraUNWUi9TdTZyRTR2c0VjWHczT0JNOU5tNFErNGZLQ0ox?=
 =?utf-8?B?d0pwRTM4M3ZlQmR4Yk00YnpvdmRoRXVxZTgvZzRnZGN0ZGRJUStZVDhrUktz?=
 =?utf-8?B?dXliYXIybWh5eHBsdzN3Z0hlUGJvRnF4YTI2TmVIUkJtL2dMc25hVlRJdDFY?=
 =?utf-8?B?bEhGV2RqNk1ac2JEc2FtcDd4ZmhUQk5jcy9lNFNNZkxac2xLNW5POFlGRTVZ?=
 =?utf-8?B?U2hFYXhxUjEyMFE3dEM1akVLSE1yRVovNXFsNElVTDBYRUhwR2VReGpLM0hT?=
 =?utf-8?B?aENSUE52c3cyR3YvRWxmVHhTZVV4QzBDbFdGSFlaSVJHTVUyRDd3OFBDcE51?=
 =?utf-8?B?Y2lUcTAvNERCcEpaNXZQSHV2c3QzSkw3SllWRE5PRmFEQ1JLZmxESkh3aXlC?=
 =?utf-8?B?MmNPZnpZNUJRZlZuZzg4ekRYWGxoNUZHdTZIRlZURW0ya0ZOa09xaUd5Q2Rh?=
 =?utf-8?B?U25GU3U5d1lPTythY3ZjY1VpWUQ4T1ZWb29iK2h3OFBCUG1XY1BuMUorUnA1?=
 =?utf-8?B?ZFNVYmlTbGt1eWsvU2RxRW9PeWZzMFhHK2crdzU5VnY2bFVZZzh1UjVyejBn?=
 =?utf-8?B?SVcyQ1AvbXBvdzNYSmtPRDBZTWI0TTl6TTJNMlpMVGpZSWxjaU5tRURlblZE?=
 =?utf-8?B?ckxKbXBkUzRRa0RBWVRXRjlTcnFiZWZYTGlJVU1kb0xDWGEzNWdsRDRDNEw3?=
 =?utf-8?B?UHNuOXlkN0VIc2tYUnNHVGRJZ3FNT0w1bjJsZzVIOVNyQ0hockduTFVlV040?=
 =?utf-8?B?OFBkK1VjQ2VUa2M1K1hjd3A3cGNWODRvdDNDK0d3YXIzbGNNRnZVeEJSSVgx?=
 =?utf-8?B?cndnRS93ajdMc3RIcmQrQjFvNTdHR2dIYVltL1NUaXlXbTNFbHhhSnVIMnBr?=
 =?utf-8?B?UUpCZ29iRWRSM0pXMUZGVk9ybU9nSDgyc2hmODlQaUt5TXZvTzlMTFRqM0pa?=
 =?utf-8?B?VmFNaHhHZEZtd0ZxazJPVmlLM0ZuNlAzUU9lOXFaQjBkcGFId0JVZkduamlo?=
 =?utf-8?B?Y2h5UmZOTjkyZXh0bEFPWFJ3ZnJWUVpBSGtQMkRvN1FZUzBhNm5NSG9kbWJQ?=
 =?utf-8?B?VWNWU290WDdVc3FvNnVtelRiVTNIRDR1RnMxZVRWRkdmM3ozSzdveG9yMkNi?=
 =?utf-8?B?ZHpKRFJ2TFk1d1RvZmpCbzJKRmpqVy9ZdDlkYTNwbUVDN2lqNFZUT055aHhL?=
 =?utf-8?B?SnYrWHR3T3R0ZVdNVmhkUkRlc2FIbCtsMmhCN0VUWDlTeU8vVjlVankydEpF?=
 =?utf-8?B?L0hzemFCR0IxbkFBOHNNcTdHTUt0OWF3VlQvc0tPNWNjd0tXT0toRHcyWmF2?=
 =?utf-8?B?cXNWbkYvVld1YU1tY2xpcjZsNnJhRGhUVlgzNmZVZTRZeE9QaFZRNmMyeHpB?=
 =?utf-8?B?M2tHOGdsdndhMElsa3QyUFRBazlBa1J0RUE0RTdFdTZ3RnpRb3ZCQVBvdkJE?=
 =?utf-8?B?ZE1HSWpIRTQyR1F3UGludUxHL3BzSEJVRmF2U1FIUXk1STB5TlJLV1pGL2hn?=
 =?utf-8?B?Y3hUNmZRVUFERDFyM2RpTzNvY1phSkVqYXRCUGNrWXBYWTNaTjRBcTZrSW1l?=
 =?utf-8?B?eUxXWHVhWGdBNUo3TkJCS1lYQmRrWlVRMkw5U29QK2krYmN4R0QwVGtZeWZs?=
 =?utf-8?B?Slkwek9wTEdKdUEzUGdNTVp2aU5DV2xBTXRmNkNnRCt5L2VkNG5LaGpibEhn?=
 =?utf-8?B?cXB6SXpEaTJieG55cGNTdFJWY1JTN3J5NXBUc2J6Q2tWUEhtYSs5VEl0bTFM?=
 =?utf-8?B?SmFzREFpS0ZHU1ZyWlVXaTdZNlJXNHFqbUVycDBWWGVMcUZCZnlURysrZDh4?=
 =?utf-8?Q?qd5BzJLRmMjOcnwwer?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ee7622-6120-46f2-fa0e-08df34d307d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 09:08:28.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMr/fKCOa+gWnepBvvs8i7Og/dekWCKSIQ6SCJthCwceZmulpIYkAY9c/maYfKqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,infradead.org];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.85.42:from];
	RCPT_COUNT_TWELVE(0.00)[39];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[52.101.85.42:from,2603:10b6:510:13c::22:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5115544E0F
X-Spamd-Bar: ---
Message-ID-Hash: CEAMUQ2QEFZRNGTWSZRP43BUVYSAXI4A
X-Message-ID-Hash: CEAMUQ2QEFZRNGTWSZRP43BUVYSAXI4A
X-MailFrom: Christian.Koenig@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, echanude@redhat.com, mripard@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CEAMUQ2QEFZRNGTWSZRP43BUVYSAXI4A/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: =?utf-8?q?Christian_K=C3=B6nig_via_OP-TEE?= <op-tee@lists.trustedfirmware.org>
Reply-To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 16:02, Albert Esteve wrote:
> dma-heap already supports charging a specific cgroup at allocation
> time via charge_fd in DMA_HEAP_IOCTL_ALLOC. However, dma-bufs can
> originate from any exporter (DRM, V4L2, etc.), and the allocator may
> not know the final owner at allocation time.
> 
> Add DMA_BUF_IOCTL_XFER_CHARGE to transfer a dma-buf's memcg charge
> to a different cgroup after allocation. The target is identified by
> charge_fd, which may be a cgroupfd or a pidfd.
> 
> The transfer charges the new cgroup before uncharging the old one,
> preserving the original charge on failure. An atomic cmpxchg on
> dmabuf->memcg prevents races with concurrent transfers.
> 
> Not all dma-buf exporters back their buffers with reclaimable system
> memory. Some represent device registers, VRAM, or carved-out pools
> where size is not a meaningful memory cost. Add a memcg_account flag
> to dma_buf_export_info that exporters set when their buffers should
> participate in memcg accounting. The xfer ioctl returns -EOPNOTSUPP
> for buffers that do not set the flag. Currently only the system heap
> sets it, other exporters can opt in as needed.
> 
> Usage example:
>   int cg_fd = open("/sys/fs/cgroup/clients/app1", O_RDONLY | O_DIRECTORY);
> 
>   struct dma_buf_transfer_charge xfer = {
>       .charge_fd = cg_fd,
>   };
>   ioctl(dmabuf_fd, DMA_BUF_IOCTL_XFER_CHARGE, &xfer);
>   /* charge now on app1's cgroup */
>   close(cg_fd);
> 
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---
>  drivers/dma-buf/dma-buf.c           | 43 +++++++++++++++++++++++++++++++++++++
>  drivers/dma-buf/heaps/system_heap.c |  1 +
>  include/linux/dma-buf.h             |  5 +++++
>  include/linux/memcontrol.h          |  9 ++++++++
>  include/uapi/linux/dma-buf.h        | 26 ++++++++++++++++++++++
>  mm/memcontrol.c                     | 41 +++++++++++++++++++++++++++++++++++
>  6 files changed, 125 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f31f49ebd0af..07513ecedc10 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -540,6 +540,45 @@ static long dma_buf_import_sync_file(struct dma_buf *dmabuf,
>  }
>  #endif
>  
> +/* Transfer a dma-buf's memcg charge; see struct dma_buf_transfer_charge */
> +static long dma_buf_xfer_charge(struct dma_buf *dmabuf,
> +				const void __user *user_data)
> +{
> +	struct dma_buf_transfer_charge arg;
> +	struct mem_cgroup *memcg;
> +	int ret = 0;
> +
> +	if (copy_from_user(&arg, user_data, sizeof(arg)))
> +		return -EFAULT;
> +
> +	if (!IS_ENABLED(CONFIG_MEMCG))
> +		return 0;
> +
> +	if (arg.flags != 0)
> +		return -EINVAL;
> +
> +	if (!dmabuf->memcg_account)
> +		return -EOPNOTSUPP;
> +
> +	memcg = mem_cgroup_get_from_fd(arg.charge_fd);
> +	if (IS_ERR(memcg))
> +		return PTR_ERR(memcg);
> +
> +	if (dmabuf->memcg == memcg)
> +		goto skip_transfer;
> +
> +	if (!mem_cgroup_transfer_dmabuf_charge(dmabuf, memcg)) {
> +		ret = -ENOMEM;
> +		goto skip_transfer;
> +	}
> +
> +	return 0;
> +
> +skip_transfer:
> +	mem_cgroup_put(memcg);
> +	return ret;
> +}
> +
>  static long dma_buf_ioctl(struct file *file,
>  			  unsigned int cmd, unsigned long arg)
>  {
> @@ -590,6 +629,9 @@ static long dma_buf_ioctl(struct file *file,
>  		return dma_buf_import_sync_file(dmabuf, (const void __user *)arg);
>  #endif
>  
> +	case DMA_BUF_IOCTL_XFER_CHARGE:
> +		return dma_buf_xfer_charge(dmabuf, (const void __user *)arg);
> +
>  	default:
>  		return -ENOTTY;
>  	}
> @@ -750,6 +792,7 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
>  	dmabuf->size = exp_info->size;
>  	dmabuf->exp_name = exp_info->exp_name;
>  	dmabuf->owner = exp_info->owner;
> +	dmabuf->memcg_account = exp_info->memcg_account;

The initial charging should probably be done here as well.

This way DMA-buf heaps only needs to pass in the charge_fd and we can re-use the functionality for other DMA-buf exporters as well.

>  	spin_lock_init(&dmabuf->name_lock);
>  	init_waitqueue_head(&dmabuf->poll);
>  	dmabuf->cb_in.poll = dmabuf->cb_out.poll = &dmabuf->poll;
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
> index adeea8cd328b..a764167167ba 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -479,6 +479,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
>  	exp_info.size = buffer->len;
>  	exp_info.flags = fd_flags;
>  	exp_info.priv = buffer;
> +	exp_info.memcg_account = true;
>  	dmabuf = dma_buf_export(&exp_info);
>  	if (IS_ERR(dmabuf)) {
>  		ret = PTR_ERR(dmabuf);
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index 23ec0ff23fba..ac0ec88cab93 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -433,6 +433,9 @@ struct dma_buf {
>  
>  	/** @memcg: the cgroup to which this buffer is currently attributed */
>  	struct mem_cgroup *memcg;
> +
> +	/** @memcg_account: account buffer memory to cgroup */
> +	bool memcg_account;
>  };
>  
>  /**
> @@ -505,6 +508,7 @@ struct dma_buf_attachment {
>   * @flags:	mode flags for the file
>   * @resv:	reservation-object, NULL to allocate default one
>   * @priv:	Attach private data of allocator to this buffer
> + * @memcg_account:	account buffer memory to cgroup
>   *
>   * This structure holds the information required to export the buffer. Used
>   * with dma_buf_export() only.
> @@ -517,6 +521,7 @@ struct dma_buf_export_info {
>  	int flags;
>  	struct dma_resv *resv;
>  	void *priv;
> +	bool memcg_account;
>  };
>  
>  /**
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6b30baa79fa9..36fddafbef4e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -679,6 +679,9 @@ bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp,
>  void mem_cgroup_commit_dmabuf(struct dma_buf *dmabuf, struct mem_cgroup *memcg,
>  			      unsigned int nr_pages);
>  
> +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> +				       struct mem_cgroup *new_memcg);
> +
>  void __mem_cgroup_uncharge(struct folio *folio);
>  
>  /**
> @@ -1206,6 +1209,12 @@ static inline void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg,
>  {
>  }
>  
> +static inline bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> +						     struct mem_cgroup *new_memcg)
> +{
> +	return true;
> +}
> +
>  static inline void mem_cgroup_uncharge(struct folio *folio)
>  {
>  }
> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> index e827c9d20c5d..ea957f4b1d38 100644
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
> @@ -168,6 +168,31 @@ struct dma_buf_import_sync_file {
>  	__s32 fd;
>  };
>  
> +/**
> + * struct dma_buf_transfer_charge - Transfer a dma-buf's memcg charge
> + *
> + * Any holder of a dma-buf file descriptor can perform a
> + * DMA_BUF_IOCTL_XFER_CHARGE to attribute the buffer's memory
> + * cost to a specific cgroup, or move it from one cgroup to
> + * another.  The ioctl charges the new cgroup before uncharging
> + * the old one atomically.  On failure the original charge is
> + * preserved.  If the buffer has no existing charge, a new
> + * charge is established.
> + */
> +struct dma_buf_transfer_charge {
> +	/** @flags: Reserved, must be zero */
> +	__u32 flags; /* unused for now */
> +	/**
> +	 * @charge_fd: File descriptor identifying the target cgroup.
> +	 *
> +	 * May be either a pidfd, in which case the charge moves to the
> +	 * memory cgroup of the referenced process, or a cgroupfd obtained
> +	 * by opening a cgroup v2 directory, in which case the charge moves
> +	 * directly to that cgroup's memory controller.
> +	 */
> +	__u32 charge_fd;
> +};
> +
>  #define DMA_BUF_BASE		'b'
>  #define DMA_BUF_IOCTL_SYNC	_IOW(DMA_BUF_BASE, 0, struct dma_buf_sync)
>  
> @@ -179,5 +204,6 @@ struct dma_buf_import_sync_file {
>  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
>  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma_buf_export_sync_file)
>  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_buf_import_sync_file)
> +#define DMA_BUF_IOCTL_XFER_CHARGE	_IOW(DMA_BUF_BASE, 4, struct dma_buf_transfer_charge)
>  
>  #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b841b905759..3adc84fe6668 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5786,6 +5786,47 @@ void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int nr_pages)
>  		refill_stock(memcg, nr_pages);
>  }
>  
> +/**
> + * mem_cgroup_transfer_dmabuf_charge - move a dma-buf charge
> + * @dmabuf: buffer to transfer charge
> + * @new_memcg: target memcg; caller must hold a reference
> + *
> + * Transfers the charge for @dmabuf to @new_memcg and, on
> + * success, stores @new_memcg in @dmabuf->memcg.
> + * Returns %true on success, %false if the charge against @new_memcg
> + * failed or a concurrent transfer raced on @dmabuf->memcg.
> + * On failure the caller retains its reference to @new_memcg.
> + */
> +bool mem_cgroup_transfer_dmabuf_charge(struct dma_buf *dmabuf,
> +				       struct mem_cgroup *new_memcg)

I would make that more generic instead of dmabuf specific. E.g. something like this:

bool mem_cgroup_transfer_charge(struct struct mem_cgroup **ptr_memcg, struct mem_cgroup *new_memcg, enum memcg_stat_item item, unsigned int nr_pages)

> +{
> +	struct mem_cgroup *old_memcg = READ_ONCE(dmabuf->memcg);

> +	unsigned int nr_pages = PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;

This way we can also document in the DMA-buf caller that this conversation must be ok when memcg_account is true.

Regards,
Christian.

> +
> +	if (mem_cgroup_disabled())
> +		return true;
> +
> +	if (!mem_cgroup_reserve_dmabuf(new_memcg, GFP_KERNEL, nr_pages))
> +		return false;
> +
> +	mod_memcg_state(new_memcg, MEMCG_DMABUF, nr_pages);
> +
> +	if (cmpxchg(&dmabuf->memcg, old_memcg, new_memcg) != old_memcg) {
> +		mod_memcg_state(new_memcg, MEMCG_DMABUF, -nr_pages);
> +		mem_cgroup_cancel_dmabuf(new_memcg, nr_pages);
> +		return false;
> +	}
> +
> +	if (old_memcg) {
> +		/* Uncharge old cgroup */
> +		mod_memcg_state(old_memcg, MEMCG_DMABUF, -nr_pages);
> +		mem_cgroup_cancel_dmabuf(old_memcg, nr_pages);
> +		mem_cgroup_put(old_memcg);
> +	}
> +
> +	return true;
> +}
> +
>  /**
>   * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
>   * @dmabuf: buffer to uncharge
> 

