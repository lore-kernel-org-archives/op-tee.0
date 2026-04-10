Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92AEE9905C
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 09:27:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 010C343ECD
	for <op-tee@archiver.kernel.org>; Fri, 10 Apr 2026 09:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1775813240;
	bh=vLR5s3UBoNsaNPGyZ1EN8yEYFsG44JlnaBELK+KBOfw=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ag5a7/dsBpNOeHgnTqsJxe8YuODsnzCknS4RXxQ68eoGED19psjmzyp1+REYa2OAF
	 jIIyXXJJYKi1Wa9iEDG7hBQUZ7EBhGzpGeMbg/dtr99r21Df2O7p3PjVsw1C/2AezD
	 2phL4bx2BeISQKD/lD6BX9FaPhv5nQmV0VGu4qWMKzpQqyOtbFlDNEOieJtYVlMFpM
	 zbmYrtCb1Ivl8IAmBytLQgPERlQ5DKzGE8dgaptcg7os4YpsqeSpkRQ8UTCQl7oq7O
	 BahZEkrSN+js+eCByONbDRwC4b192nX7B1JiFOjPTLjyBoESTXx7rzWvyXOW+3fB5Z
	 phQaKSIMwI1dQ==
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5110E43EA1
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Apr 2026 09:27:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=hz1qPX+U;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMgeRGTvT1LaIHQVlCKhFqBEL58E3YuS8zRW+ZQIHxGWUofHlCjs5jewu8x8Ksj8OPitXVFOzCJly4at2B8xnjl3uGDjMcHxlFWJYHBXAQYHc7mr4Ebp98PJahdDFqyFerVNBgGxyNNp8Dm5gP1KkeGutrXvcc19soxyGxYuYoSjZpcQnFnRZoaFdgrT1eNsy9PVjDMPVd93+cT92l0Onjg3eAdbr3KoWL6YwDDRzjUQavaPFqu+zDC01wwRxzqleoKm6+Xnhzbr3WdZ1ToUHy0OBHVoHTpxQkDgJH5dnl0nmHeNcANaA7PepU+s6iR1Sah3U49HnYBleLJT/+wphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXD5JiJQRPbkggDrjMfBdZRgnxRdyYLdVLKj22g4Ap8=;
 b=mT11nzV/U7nSdvXkuqvDMwtauJCE4lwYgK7v6VTG/HBZLznAe5DsdbtiuSl9Q+30aAvpmqfZcCfxT2AP/cPGPSwdRoFz+g0wRdTLnXy9+QrvvNQH8SkfbghGgWmg3gOCIxiS2vYQ907+PRJXHTYtuU6XT8CC7GEqmjCWKraXDfZIayB2kHF2mm0lVzubkbf3+i8YoQP7+q9UfEqq1crh4FT4hiJfk5SNF/Mpu5FnvVJtaqgSsIIwb3xesUR3ZRr+HmEfmbj+YL/LnrLHu1aHkex4lBWAJ8vdlXG2zu5dtBR+O2jGK3cbXozXLGyhS2pyO9m1c13dP96YmqCdjyIwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXD5JiJQRPbkggDrjMfBdZRgnxRdyYLdVLKj22g4Ap8=;
 b=hz1qPX+Uhws5sB5iEhZOVPl/axkmoL0OmL3xO3+SCgHRSf9OswKMpvaEzgoljf3ceeICyeDb9+Uq2D9g6aZU7BID3zxFPuNNYOtKtuQVTePoFntcnlYJ11j0I+Y9V3uGP3bcoQZklbKKKhLPjccVFEAiIdUJV7QMV7CxWM8HBffrbFA5UDRyxkCx2pGqP1gK0GNGowW2eaBOH1M1J5ejDmUMJR44xWQoIoRuRnAfr8LTqZMnsKYYHRa0oXa4SfKg4dODSgt22DDoA/5KQuUoe/tQTEM44TO/utnJtAmeoax+bXJcSTksUwivEiG9TGAPXpCcS5e6ttiq6jGHLz7EmQ==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB5PR10MB7917.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 09:27:09 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9745.035; Fri, 10 Apr 2026
 09:27:09 +0000
Message-ID: <4e9643cb-c41a-4242-ac1f-ab3a048f3a46@siemens.com>
Date: Fri, 10 Apr 2026 11:27:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: PKCS#11 TA needs userland supplicant?
To: Jens Wiklander <jens.wiklander@linaro.org>
References: <020c35af-a58e-47dc-b445-841538e62f88@siemens.com>
 <CAHUa44HNAGSLV9onUmYKm8fbKvYGVBNNqCtWjZcEGXtoEfLwCg@mail.gmail.com>
 <4dfd2e07-4627-4682-a8f2-bc13eafa1fe9@siemens.com>
 <7a52b4ec-7e75-4332-b94c-726978a3a7b6@siemens.com>
 <30ddaa03-b2af-4c71-bd0e-b379cc4f2685@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <30ddaa03-b2af-4c71-bd0e-b379cc4f2685@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR3P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::15) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB5PR10MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: d42ee575-d57e-48c8-b2eb-08de96e356d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	1dk/Plhi362rhKSY0a2oSq/v/UWzeRt1rMZSsr+4z5+lYoxNRbL/rikBokx1KSoyyEeawr5i9d+jRI1bPjSCLKDFZT6n5KzLNHctusVDPwdc0xbT107BSVwtX5s8uYHBJG0HfNJfbVNqgL8IXpZOgVasSwtlhUtrAgg1EPKrDX52lQu6oLXdb2qR9EDV1+9g4csGSwRkhEzR7oHVQzU3bIL3iiYD/5Jp6rV8F4eBIJWasesy5nEMZyMYkkxtcVrFD/9RXlUBwL1SzxYt0tC5WAqVP+NhsvAK22BYmOoscF8revNitsypbZ8s1FYsIOiM+wQE5idzU02iglTkL+IgFFdt0djXz1Gb2E9H148NOWHdJzhEf2RN4gDcXnLqlVU3zVCuwPQv7hPN9IOpKwkbhKeodzbXzN49bwqNh+4borAp89mQhQnVDW6hCIEjXYZZvsRhQIdMHgibacu111mq5yuHRO/B/H/asQoFGEPcv0TA2sI0hvYzRHvpNjvVw3wkXUE5xCUFU3bWcHSBuw/+O0EWjsiNC3COk0nXS1dGK9qsCPE0aB09RbfIaAX5HtkQ7oFSZMxgKr0fE/YS8DeOyqrJrUE5wYVFPm9d2bbhSIfMlidE1EybN88E2jAM5U5KW8P+wVeEk6cJVPaA8j3+EI/yOWEsNTMMmhd8X4o4tk9CjGS03OmAiJIgkYfLIU6Y
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SlNtUVQ3QmVtYlRCYkhlN002MTVkcGUvVHlmRjJEYkVtdytIdkNMN1BXMk93?=
 =?utf-8?B?MCt0UVhUemZGZTNHRm5NT0I5QWNZYmw0SFpHSnJvYzNzMi93c3U1OTBYeXlL?=
 =?utf-8?B?TXFXdFR5VEhvN053V3dMZDRhMnIrc1llNVpQb0xuTDZNZERQQXhOa3dET2ZQ?=
 =?utf-8?B?ZVBhQTBCWjJMZjREQkdDcU1ROHkwemVBdERGTWpiZUdJdHBkOFFKNnhmdnlT?=
 =?utf-8?B?K1hOa2djcEhIdWQ1SWxEMmY0ZFJSR1d3aTZsemhMVVJzd3MydDE4TWN2R29K?=
 =?utf-8?B?SmhKWW5zQ2xoaFV4eDZVMFhtcTcxUEFwbGw2NkJaMTZnRGxEVDNqVUhTdXpB?=
 =?utf-8?B?dkU2N1RSREhjRjB1SU12akxhUkNiZm90MGdVWTFDdXVPZ29RNGEwOG5ETUhJ?=
 =?utf-8?B?eUpnQ1UwRExrY2VBVE1BU3F3aEdFS0lOOW1vclU5YzJ6M0dVc0NtcnZJeDhV?=
 =?utf-8?B?WWEvU3N5eUJOY3NPdld0UEQvdFZoOGI3Unpvd1JQSjdwMThCL1BzUERMQW95?=
 =?utf-8?B?V0lFNVJ5cEh2Q3lHVXVHOEhUTzJFRGRwMHVvWXlTc1VyQ1pWcldkZWJVdENn?=
 =?utf-8?B?cTdYVFhLdTdhTnROa2pmYmkwV3ZQSzBJTjJhU2YySVQ3OXBSWmRNZ1gveXJ5?=
 =?utf-8?B?eGFaOVFPT0pFYWZWL2N1VTJGUWtnVEp1R2xtL3VUM0JuVzZJK09oS1hTN3VH?=
 =?utf-8?B?N3dabi9SUVcwa1V4SXlQa1pYdXpNcjRrZnlHUTdBQ0xrbHRiV3dWenNJaTVU?=
 =?utf-8?B?aWo0TG1HNXU0eWF5M25mdkdzZGU2NFE1STFTWjVpdlBNSXJqemw5VmlFZ2xn?=
 =?utf-8?B?NnV3cG9FL1JxWXhEbGdFKy85eU9CS0ZzR05qcU1FT1MzalhHZlpYVGtuTDdB?=
 =?utf-8?B?YVBhb21RTURzOWd4WDVEVEkraWtnQzU0ekhVa05YS0huaUV3cmc0ZW5UcFJh?=
 =?utf-8?B?Mi9ScHR6cHJwdWs4RTF3eU5TZDNRUC9ZTXN3c0piUXdEMGoxU05YdW4rZm1a?=
 =?utf-8?B?RjVtM0ZNZVVWTzEzNE5TQytpYzlRVUVnYUs4SytualRKaXdkMG5oUWxEbVVJ?=
 =?utf-8?B?aWt4M1MxVFFPb3k1NXdxaVBYd2hsdVdwWUkzZVhUV3dQMXU3YXpyNWkyZWJD?=
 =?utf-8?B?SFFDZWRkQ1Z5b0ZWdTZoemFMQTU5NjdSb2ZXZzJkMDZjenB5VkFvdGkwR2tG?=
 =?utf-8?B?VmdoYlExSFpKU3YwMXk5TGRSMEg3VWZpcUlWYjNKREhPZFgzYnJ2WjNRMHJB?=
 =?utf-8?B?VG11bkdVaC9qMWJrTllyaXV5ZHBhcUFRYk1Bei9mZXkyWGhkcUJFT21FK09W?=
 =?utf-8?B?TmxLWjJhTEVDa3BYUEo4a2tuRDc5d0FJQ0w2SXYrMUF6d0Jwd3FsbmhzSmt5?=
 =?utf-8?B?Uk00T1lZcWZDQytZTGNNTk8xWmVid1V5T0twRFhVdHNvZENxTE9LUUpNMlNB?=
 =?utf-8?B?cFlaUnpzZU9NZVNSaWhvcTdud2dHamxkRWNRVkVDY3l3VXkxVXROYm1qUkVQ?=
 =?utf-8?B?ay81aStjblhMdks0eHhJQWNtdEFMY1h4YU9RRENYWjhzQ2JKS1dSMWpyaC9y?=
 =?utf-8?B?eVVTRWRjbGE5TXMvTnAyelpUQ24vUUx5ZnRnd1YzM1pJUDJWUW5OMktzRDYw?=
 =?utf-8?B?OVB2aGUzUEVicC9yQkR0TkMyWmoxOC9lTVk1N1RRR0hVTFdzOU9zVkJlRm93?=
 =?utf-8?B?UWR0Q2xydWlMd0RDYkVyaHdZMENHaW5YWEgzUlFwQlJmVDlHNzRaZ3VSNHZ3?=
 =?utf-8?B?TVd0Y3N4N1pXM1lUcGJqZ0ZKMC9Hem9yalM0YzA5a1dCd0o1S2ZrclYzN21L?=
 =?utf-8?B?QTFxNXNxWWlTNnJJYnlwTmZ0TnJWTmpYc1VrYi9ZWDRQMlUyVWJSVFE2MXl0?=
 =?utf-8?B?bGxuRVVKQUJicit5emlmQ0xxYUpFaWhYL0lTQ01GRUZBM05FYTMzdFhSR1Vp?=
 =?utf-8?B?UGliYVZKdnRUOWQxN2hwVWNQb3RNK04zbTZhSmVMMU9KOWlFL0V4SjMzL1FL?=
 =?utf-8?B?dGtKL2FBUXUvdXF1SFFVWExoUEIzNVl1ZGxJSkRyejZQbE02eVVDVFlxb2J3?=
 =?utf-8?B?SjJDL0ErcXBCVHNZdHA2R0JzTkFNV3dSekg3blpSYVpUbEd5ZzlkcGNvQUZn?=
 =?utf-8?B?SkVESEFDTXZ2dkNSQkpvZkNHNXJUNGd6MytlbytMZXI5ZUgyd2hSVWdqYnAy?=
 =?utf-8?B?LzNidGpaWTIwUUZXbE1DcGwzUUJwOGkrYVllSnpnTjlMbzluN0dkSWFpc2wy?=
 =?utf-8?B?bXIxZkdhSkpvRFFoeXpsRHpySitZWXVPRkxFc1ZreXZ3TnNpMWczNlRJTGlq?=
 =?utf-8?B?TmRpcTd1L01uSjZCRy9xVDJQcG0xb29NdGdzcnpnQjc0enpvN011dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42ee575-d57e-48c8-b2eb-08de96e356d4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:27:09.4373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZkVnGzI6GvPBZcwObSrifsCpRpZdtYqMGYyY2rswyuQAquSlPOoWRTng6J+hlaToXZGffcvAA3RPA5122IkLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7917
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.65.40:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:150:76::15:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.65.40:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5110E43EA1
X-Spamd-Bar: -----
Message-ID-Hash: J5X63LIA2XO57YSHWGJRCWYZJ4JIVPMU
X-Message-ID-Hash: J5X63LIA2XO57YSHWGJRCWYZJ4JIVPMU
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J5X63LIA2XO57YSHWGJRCWYZJ4JIVPMU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

T24gMTAuMDQuMjYgMTA6MzYsIEphbiBLaXN6a2Egd3JvdGU6DQo+IE9uIDEwLjA0LjI2IDA5OjU5
LCBKYW4gS2lzemthIHdyb3RlOg0KPj4gT24gMTAuMDQuMjYgMDc6NDUsIEphbiBLaXN6a2Egd3Jv
dGU6DQo+Pj4gT24gMTAuMDQuMjYgMDc6MzcsIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0KPj4+PiBI
aSwNCj4+Pj4NCj4+Pj4gT24gVGh1LCBBcHIgOSwgMjAyNiBhdCA3OjQx4oCvUE0gSmFuIEtpc3pr
YSB2aWEgT1AtVEVFDQo+Pj4+IDxvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZz4gd3Jv
dGU6DQo+Pj4+Pg0KPj4+Pj4gSGkgYWxsLA0KPj4+Pj4NCj4+Pj4+IHRvIGF2b2lkIHRoYXQgSSdt
IGRlYnVnZ2luZyBmdXJ0aGVyIHRoaXMgZXJyb3IgSSBnZXQgZHVyaW5nIGJvb3Qgd2l0aA0KPj4+
Pj4gQ09ORklHX1JQTUI9eSBpbiB0aGUga2VybmVsIGFuZCBDRkdfSU5fVFJFRV9FQVJMWV9UQVM9
cGtjczExL2ZkMDJjOWRhLi4uOg0KPj4+Pj4NCj4+Pj4+IFsgICAgMC4zNTkzNzJdIG1tY2JsazBi
b290MDogbW1jMDowMDAxIFFFTVUhISA0LjAwIE1pQg0KPj4+Pj4gWyAgICAwLjM2MTc3OV0gbW1j
YmxrMGJvb3QxOiBtbWMwOjAwMDEgUUVNVSEhIDQuMDAgTWlCDQo+Pj4+PiBbICAgIDAuMzYzNzYx
XSBtbWNibGswcnBtYjogbW1jMDowMDAxIFFFTVUhISAyLjAwIE1pQiwgY2hhcmRldiAoMjQ4OjAp
DQo+Pj4+PiBEL1RDOj8gMCB0ZWVfdGFfaW5pdF9zZXNzaW9uX3dpdGhfY29udGV4dDo1NjkgUmUt
b3BlbiB0cnVzdGVkIHNlcnZpY2UgNzAxMWE2ODgtZGRkZS00MDUzLWE1YTktN2IzYzRkZGYxM2I4
DQo+Pj4+PiBEL1RDOj8gMCBsZWdhY3lfcnBtYl9pbml0OjExNDMgVHJ5aW5nIGxlZ2FjeSBSUE1C
IGluaXQNCj4+Pj4NCj4+Pj4gVGhlIGluLWtlcm5lbCByb3V0aW5nIGRpZG4ndCBpbml0aWFsaXpl
IGFzIGV4cGVjdGVkLCBzbyBPUC1URUUgaXMNCj4+Pj4gZmFsbGluZyBiYWNrIHRvIHRoZSB0ZWUt
c3VwcGxpY2FudCBiYXNlZCBSUE1CIGNvbW11bmljYXRpb24uDQo+Pj4+DQo+Pj4+DQo+Pj4+PiBF
L1RDOj8gMCBnZXRfcnBjX2FsbG9jX3Jlczo2NDYgUlBDIGFsbG9jYXRpb24gZmFpbGVkLiBOb24t
c2VjdXJlIHdvcmxkIHJlc3VsdDogcmV0PTB4ZmZmZjAwMGMgcmV0X29yaWdpbj0weDINCj4+Pj4+
IEQvVEM6PyAwIHRlZV90YV9pbnZva2VfY29tbWFuZDo4MzAgRXJyb3I6IGYwMTAwMDAzIG9mIDQN
Cj4+Pj4+IEQvVEM6PyAwIHRlZV90YV9jbG9zZV9zZXNzaW9uOjQ2OSBjc2VzcyAweGMwMjEwOTEw
IGlkIDENCj4+Pj4+IEQvVEM6PyAwIHRlZV90YV9jbG9zZV9zZXNzaW9uOjQ4OCBEZXN0cm95IHNl
c3Npb24NCj4+Pj4+DQo+Pj4+PiBJcyBpdCBwb3NzaWJsZSBhdCBhbGwgdG8gcnVuIHRoZSBQS0NT
IzExIFRBIHdpdGhvdXQgdXNlcmxhbmQgdGVlLQ0KPj4+Pj4gc3VwcGxpY2FudD8gSSB0aG91Z2h0
IGl0IG9ubHkgbmVlZHMgdGhlIHN1cHBsaWNhbnQgZm9yIFJQTUIsIHRodXMgc2hvdWxkDQo+Pj4+
PiBiZSBmaW5lIHdpdGggdGhlIGluLWtlcm5lbCByb3V0aW5nICh3aGljaCBpcyBhY3RpdmUpLCBi
dXQgbWF5YmUgdGhhdCBpcw0KPj4+Pj4gbm90IHRydWUuDQo+Pj4+DQo+Pj4+IFllcywgSSB0aGlu
ayBzby4gSSBoYXZlbid0IHRyaWVkIGl0IG15c2VsZiwgdGhvdWdoLiBBbnl3YXksIHRoZSBsb2cN
Cj4+Pj4gdGVsbHMgdGhhdCBPUC1URUUgaXNuJ3QgdXNpbmcgaW4ta2VybmVsIHJvdXRpbmcuIFlv
dSBjYW4gYWxzbyBjaGVjaw0KPj4+PiAvc3lzL2NsYXNzL3RlZS90ZWVwcml2MC9ycG1iX3JvdXRp
bmdfbW9kZWwgdG8gc2VlIHdoYXQgdGhlIGRyaXZlciBoYXMNCj4+Pj4gbmVnb3RpYXRlZC4NCj4+
Pj4NCj4+Pg0KPj4+ICMgY2F0IC9zeXMvY2xhc3MvdGVlL3RlZXByaXYwL3JwbWJfcm91dGluZ19t
b2RlbA0KPj4+IGtlcm5lbA0KPj4+DQo+Pj4gQW5kIGlmIEkgYnVpbGQgb3B0ZWUgYXMgbW9kdWxl
IGFuZCBsb2FkIGl0IGxhdGVyLCB0aGVuIGNhbGwgInBrY3MxLXRvb2wNCj4+PiAtLW1vZHVsZSAv
dXNyL2xpYi9saWJja3RlZWMuc28uMCAtSSIsIGl0IGFsc28gd2FpdHMgZm9yIHVzZXJzcGFjZSB0
ZWUgaGVyZToNCj4+Pg0KPj4+IC4uLg0KPj4+IEYvVEM6PyAwIHRyYWNlX3N5c2NhbGw6MTQ3IHN5
c2NhbGwgIzggKHN5c2NhbGxfY2hlY2tfYWNjZXNzX3JpZ2h0cykNCj4+PiBGL1RDOj8gMCB0cmFj
ZV9zeXNjYWxsOjE0NyBzeXNjYWxsICM0MSAoc3lzY2FsbF9zdG9yYWdlX29ial9vcGVuKQ0KPj4+
IEQvVEM6PyAwIGxlZ2FjeV9ycG1iX2luaXQ6MTE0MyBUcnlpbmcgbGVnYWN5IFJQTUIgaW5pdA0K
Pj4+IEkvVEM6IHRocmVhZF9ycGNfYWxsb2MgMCwgYXJnLT5yZXQgZmZmZjAwMDANCj4+PiBJL1RD
OiBnZXRfcnBjX2FsbG9jX3JlczogYnQgMCBzaXplIDgxOTINCj4+Pg0KPj4NCj4+IEkgaW5zdHJ1
bWVudGVkIGZ1cnRoZXIsIGFuZCBJJ20gZ2V0dGluZyBhbiBPUFRFRV9SUENfQ01EX1NITV9BTExP
QyB3aXRoDQo+PiBPUFRFRV9SUENfU0hNX1RZUEVfQVBQTCwgbm90IE9QVEVFX1JQQ19TSE1fVFlQ
RV9LRVJORUwgLSB0aGlzIGlzIHdoZXJlDQo+PiB0aGluZ3MgYXJlIGZhaWxpbmcgb3IgYmxvY2tp
bmcuDQo+Pg0KPiANCj4gSSB0aGluayBJJ20gZ2V0dGluZyBjbG9zZXI6IFdlIGhhdmUga2V5LXdy
aXRpbmcgZW5hYmxlZCBmb3IgdGhlIFFFTVUNCj4gdGFyZ2V0IChrZXkgaXMgbm90IHBlcnNpc3Rl
ZCB0aGVyZSB5ZXQpLCBhbmQgdGhhdCBzZWVtcyB0byBlbmZvcmNlDQo+IGxlZ2FjeSBpbml0IGFs
bCB0aGUgdGltZToNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1URUUvb3B0ZWVfb3MvYmxv
Yi8xNWJiYWEzMzFmYjZkNjk0NjZjNDg4MGExYWYxZThlOTU4MGM5NWYxL2NvcmUvdGVlL3RlZV9y
cG1iX2ZzLmMjTDEyNDgNCj4gDQo+IElmIEkgZ290IGl0IHJpZ2h0LCBsZWdhY3lfcnBtYl9pbml0
IHJlcXVpcmVzIGEgdXNlcnNwYWNlIHN1cHBsaWNhbnQsDQo+IGRvZXNuJ3QgaXQ/DQo+IA0KDQpU
aGluZ3Mgc3RhcnQgdG8gbWFrZSBzZW5zZTogVGhlIFFFTVUgaW1hZ2Ugd2UgYXNzZW1ibGUgaW4g
aXNhci1jaXAtY29yZQ0KWzFdIGRvZXMgdGhlIGZpcnN0IFJQTUIgYWNjZXNzIGFuZCB0aGUga2V5
IHdyaXRpbmcgYWxyZWFkeSB2aWEgVS1Cb290LA0KYW5kIFUtQm9vdCdzIHN1cHBsaWNhbnQgZG9l
cyBub3QgZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSB0d28NClJQQ19TSE1fVFlQRXMgLSBob3cg
c2hvdWxkIGl0PyBTbywgUlBNQiBpbml0aWFsaXphdGlvbiBpcyBhbHJlYWR5IGRvbmUNCndoZW4g
dGhlIGtlcm5lbCBsYXRlciBvbiBsb2FkcyBpdHMgb3B0ZWUgZHJpdmVyIGFuZCBzdGFydHMgdG8g
Y29tbXVuaWNhdGUuDQoNCkluIHRoZSBzZXR1cCBhYm92ZSwgdGhvdWdoLCB3ZSBkbyBub3QgaGF2
ZSBhIFUtQm9vdCwgd2UgZGlyZWN0bHkgYm9vdA0KZnJvbSBURi1BIGludG8gdGhlIExpbnV4LiBB
bmQgdGhhdCBzZWVtcyB0byBzZW5kIHVzIGludG8gdGhlIGVycm9yIC8NCmJsb2NraW5nIG9uIHRl
ZS1zdXBwbGljYW50IGZyb20gdXNlcnNwYWNlLg0KDQpDYW4gLyBzaG91bGQgdGhpcyBiZSBjaGFu
Z2VkPw0KDQpKYW4NCg0KWzFdIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29y
ZS9pc2FyLWNpcC1jb3JlDQoNCi0tIA0KU2llbWVucyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xv
Z2llcw0KTGludXggRXhwZXJ0IENlbnRlcg0K
