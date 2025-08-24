Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA66CA0EFC
	for <op-tee@archiver.kernel.org>; Sun, 24 Aug 2025 07:41:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7369B4FD31
	for <op-tee@archiver.kernel.org>; Sun, 24 Aug 2025 07:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756021289;
	bh=fgVMxi6fQpRC3cJSXNUID3MQDm6o+K7n8HIwP2CgVww=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MRzSy+Ewz9MBcqk3IkZ9XmQBCRxOEVG9SGcQQYbZcGZ6pzPfm5FqIovaOW+i5aCIa
	 sJnRndu288jg1wJL8akOKrjQ+88G5WYReBpikS87vXqJA7drvZMx75DOnOjUYyooK0
	 BbEbP5DpiYlXvUkbsm5NkKGRDvv6wLb8QRVvCRxlYHen+fqBY59pOzzkbEzF3hid2n
	 42JKh4aU1OXtByQ+IEgQgdvx6Kdge826S9A8lz1BSlNgxUYPP3bv4a0emD8iwTBlQo
	 BVXVkKwIvkoUUp2yWSNKuDojIDmuqqOaNNyw0Rzb+u/7/zIspK83kb2nY6jAwYCPR8
	 5z6HeMR7E/JVA==
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B604741BCD
	for <op-tee@lists.trustedfirmware.org>; Sun, 24 Aug 2025 07:41:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=yYQZZKMx;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUMl0WmgOhoMBa/0bJ+957Br3kXiLnc2QuDjjboRE4MMdjcmNO7RqAMukmXRAxGkWX+VurflREjiTlbBPKaYGBXz+VEMl9ayzoltp2ptAYq2chIq/G5HXJZkWSVPoSIbKloLmw0f92YPhBPOO5NrtmRKlsOYW7gDtgLEJV+cmr2cOMrOVmU2z0cvil8GVTQ6WJW75Ja6h7Bz1hUIjIQrBymV+YWZQ3NFxS7yk/440Ifdb8N6yW2MNiIcEkyJIMF2nrQKIlja4SyE4ugPqQ+py1ZLhJ8nUFSisSC2go14qIMaQTbXEP5Fb5assdXwPPjpQuNMQIr1tTQUImh7Zk4q/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXoFwItC1tJndq7dWOaqaWYj8Y1HyFnMBEh+AgmHxkU=;
 b=DQtI8vBTfJVuGC9BAZwpgaFe4GL1nLFX3nbt5GsGTpM258DS+eBlId+sl+lMo99FCs/Drp+F+UYIwCQL9n7fmCT3TX64+pYibLcXQyjsbf4/yRBW08K7iub7SiaAmcMwxFD+kEr/PRgrx4o35ObPnbfsP55JqO91NzO5ifHh1Ysw7jId+78tTNhLbFpel6z8709xeyrPAibcKsjGucY0mxVqKfFRJyjnETgAxfwCXXd3pVgzowwxYfM4pyrA5RNnHhGa8JP8qp96c3bc3dE+WX76xsTMygs/BPVyyDRF1h5fn8NPTYh16Zq279ttA9v03So0Hi4bLyAMHjbeC5xLBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXoFwItC1tJndq7dWOaqaWYj8Y1HyFnMBEh+AgmHxkU=;
 b=yYQZZKMxQ+zFacGP9er1BHpotmF6Bia0R372tVwsKPOyB55P3P9qfYh4O/+RSJAmmfWuDBdUZzm1XHz7eb1yjkjwVO+OG/xoUL0TRJZPaL7fwJyKZXp+FubAWrvdaM2l9Y2faMZSsL7Zv3sJUkU1jLRK6+xJSLBiOfn2rZmN4ccZBigVKdsgHpQEdVFYBpFSi/xGXtZ8Ful5TcvPc1+FAv+pt4nOeHIBJtvQjdpPF5avesXS0ACvX9/VIk+t+z4CTsuPrP6RfeJeAI57u1wTJCcyKo3tFTlonRTHjJiRe8gGLGkvI9j4hcidfh1ozbrWIJXrHRRh6IWtByr8vovgYQ==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6265.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 07:41:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9052.019; Sun, 24 Aug 2025
 07:41:07 +0000
Message-ID: <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
Date: Sun, 24 Aug 2025 09:41:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] sd: Add RPMB emulation to eMMC model
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <cover.1756019920.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 52814f97-38ec-4475-6bc6-08dde2e1962e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZEU0V3RhaGxlK1ZDMHJ5bDRvK1dweUhLY2ZVc3ZKcG5iTFZoODdzdksyako3?=
 =?utf-8?B?L3k5STlLd1NSNDVDRmcxMFNIV1FybmNQQ0VYd1BpQzFMcjNOV2lucFNqL0pQ?=
 =?utf-8?B?MGVNTy9yS05XSHNGSUFQMmxKU0F6MENUS0hISmUzaFZsMGJYMDZudUJDV0px?=
 =?utf-8?B?aUFWcGRoOGtoL3JZN0VoNGZTczNMNis1cjZCVzFaRHZyQUZQcWt5Ty95UmFP?=
 =?utf-8?B?TVV2dSs5SVo4Y05qaktiRzNWa2JnQjJ0eUlJOWcwMTI4ZC9yeXhTR2JXL3Jj?=
 =?utf-8?B?cjFBUTZkUkN1ZFVLMHdLSWdORDNXWk91VURKczcveFRDTjEzazU5SXlLMHBn?=
 =?utf-8?B?VHo4VlpCOGFxRHBCbkVVT1ppRllMTEJ5WGNYZllNaEVIU1UvQmZKOTVBVFZ5?=
 =?utf-8?B?QThTY3FRNjBleVFsVm0yUm1HTE9aOE5XMHRqL1VkeCtZVE0zUVQ2aWttaXRI?=
 =?utf-8?B?Q3hvczg1bnY2SHlRakZHYUZPNVFJOXRyV3MvNkN0S3ptbm5vTTN2R3hmd05s?=
 =?utf-8?B?Y1g2V2l0RzEvYVc5d09MQWwwNkhIdmZsRWRlc1lWVkdqalZHVTkwQ2xxMktl?=
 =?utf-8?B?MmdsVUxlNHMvYW9iL2crMmpqM3JUSEk0OG5SaG5MWDMxRkhJRHlzYi9FQ0tl?=
 =?utf-8?B?SC95TWtsZnJXRTFwVzlLcm80TEpBdXVXWlJhMDhsZkorK1AwNzR1RnFreXBx?=
 =?utf-8?B?Z3B6ZmRtd3YxWEVSQ0toWDh1TFlET1pyL29PbC9UM1lHYnJUU0M1bXg5R2Vq?=
 =?utf-8?B?M1pwSUpWWDc3bDdSRHpkTXcrUi9LTTdyQ2krclFUb1hoUzUrYUJCTm9BS1li?=
 =?utf-8?B?KzhCVklSOEhydStiYjg3TWN0aVUxZEp3YmZ6a2VhYVJLUyt1Yyt6aFB2dEJU?=
 =?utf-8?B?Z2JTUjYwS3ZraGFOTHNYcmFoTkh2R1IyRGVENC9nOUl3OStvT1haQlVReHBK?=
 =?utf-8?B?NGdzWFlvRzdKRjBTWXgyUm41SG9kQlJkWUlSMkdrd29DNTRLaUlHZTE5K3hG?=
 =?utf-8?B?MEZzZDdUaDVaL3JTVlhMTnF2cUtyWkppUnZqZG83QkxycC9jcGdzZWIxYU5C?=
 =?utf-8?B?TDJDbm5EZWpLK3dXaGhrcWYyMzJFaVZyWTcwVndGcUxqcFBURzlZc01oNm9p?=
 =?utf-8?B?UzZsRUNwcktQUm9wcHpsaDZwQzRaWCtWZjlpd1JwbFUzMjJWSHJYTUYyTmVn?=
 =?utf-8?B?UnFva2U3SFdGa1I0Mi9TVGwraU5kWllXdGNua3EveFpYTWV3YmdxVTNtMUtU?=
 =?utf-8?B?UnFvYVZVOHlyZW9haDF0K2NTYUJwaTVyOTdsbThDeDJQd3FkTWt6bCsyTk5S?=
 =?utf-8?B?V0V0T1lhN3NXYkYyZnVCUXlkZEg3UGJkbE9zbUUySGFvSmd5d01GcHdwUkpS?=
 =?utf-8?B?YzU4TWlIOWhwaU5FdnRIY1FBZzZsOFc5QmhsRGhGRVA3eERHazFteHk5WVJB?=
 =?utf-8?B?aHJFc3ZrTzltdjRHVm9MT2JFSnRTK2NIOGgwRGp0b2lNZnAyN3pIeDgxNmZI?=
 =?utf-8?B?dHYvSUZwM2s0THNwV0lsMndQeEF6QXd4Q3RBdWpGU29Za0NaL3RRSGF6ak9v?=
 =?utf-8?B?UGxVNmdsQ1NVL0t0WlBtWjNtcVRRS1NBQXhGRGRVbVJ6NjFBb1Yvb2dCY012?=
 =?utf-8?B?OWNQQytnVzNrVTFRazdlcWZlVDh2dEV1VTlPRUM1L1J5RHdUeXFFa0xoaWtp?=
 =?utf-8?B?NUg3WVJtM3h1MDl1WXZCNk9BNlhCWkFxckF3cUs3VUpVYitGMTRpNjF6bDhv?=
 =?utf-8?B?ZnA2R1N2RDYzQ2tTeUxZK0I5dEtrb0ZZc0c2NzRFaFF5WE5WQVRSanJOcUF3?=
 =?utf-8?B?M3FvZ25sV3pXeUNDYjNUMzJlV1lSVll5M29VRUZ2T3FaUmdvKzdpbHBNUTNh?=
 =?utf-8?B?cUZNUC9LTjFMSXR0U0xRSURhSWk1c09IUTUraXdlNDdmUHBsRG9hR0xkd1Nk?=
 =?utf-8?Q?QnbYWUyTisU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWJhbVVGWEs2VTVocERDRDY2RElpZWREVzhuVUV6cEJPRFI5TzZ4c0phUTht?=
 =?utf-8?B?bDVXTHBzc0NLR0JjQ0FtcXhWQlhwUnJXZmdkeW80L2J4RkhIckRuTExvU2oy?=
 =?utf-8?B?VXVUay9HMm9EZXNiUjFoWHVZNjBycC9tTWxRaU5DRmV5dXVZYm1uZXRHWTFL?=
 =?utf-8?B?MEp1M3hFOHVJR216Wk56bTU3MUp2cEFBZTlKTDhXd2x3c21tNSt6VTMzWmhl?=
 =?utf-8?B?bURLQ0tRSFVDWjVBNXZnNktPQ0owWmdGRmdpSzg1VThGUUtnZU5RR0pxZE1x?=
 =?utf-8?B?aGYwMVV2UGpyTzhjT3hFWS9mQmZWZU9zVWNpSHM2T2tsQ3JXZHhFT0xLbDRv?=
 =?utf-8?B?TE8yRHoxZlBGODhITmtFak5NQ3lyN3dtZlVTdWtoMDkxZnhTbEtMaEhtcTY1?=
 =?utf-8?B?eTZlWGtGWmZVUlNaeGtGTHNiRVlDSFhuT1RSdGl4cEVtQkMwMlorYlE5Rllp?=
 =?utf-8?B?bEZOS3pMSHo0U3pzc3FhcEVDZ0g1RFlxTmx5LzdaTDdQbTAvWVg5WDVwM1NQ?=
 =?utf-8?B?aXFBM3A1c2xaL3o1bno2eTErZkkzV1R3aFZUR1JyN0FoNTdQOFBsRU5neXVh?=
 =?utf-8?B?bUcvSkxuV2l6UHZhcU1EMFFjbjdlT3FiODh4TWpqejduU2JhN09XNHU5Q1lz?=
 =?utf-8?B?NGtEUVBKekpjb0wzbUZIeWMzUndZN0EyMzg1UEZhMUZUNzcyMS9vWFZjRnhu?=
 =?utf-8?B?TTJwQXZxQ1pRalFNVXQ2cE9Mb3R6OXJSNm92Witzbjdqb3FMUEgxTXhQNkNV?=
 =?utf-8?B?aTNnRWQ0ZkY2emFGeTYxQUlsWUs3RDRpL0FsUTBnQS9yNTFUVGFqSjdCL2pQ?=
 =?utf-8?B?SWhSVit6eDg1cHRQS0JjQ1NxQjZMclVnNkEyNlBBT3kzUWtBaEpyV1lHNW9r?=
 =?utf-8?B?cHdEM3dmVlpjU1pmM1VGUGFIVlY1YlZ2TmZrVStyRkljMkZ6WUEyOGhLY0lu?=
 =?utf-8?B?T2JMY1FzOWFkN0lYcS8vZnhUOW5zSG9OQzl2T1BJYXFHWVpjSTI1VmFUUnR6?=
 =?utf-8?B?dm9jV3hoRG1SZkJjN1FFVGV6OGcxNEc1cWdnU1p5cktCRVhWTWlGREpEd1NE?=
 =?utf-8?B?c3VYNDF4dERKSUVrdXlyeFA3S1JyeFFGZThDUk0xMkxiRmw2UzFCb3BLektJ?=
 =?utf-8?B?Z1VZek40S09HVEtIU1VLYnE1K2xxV0U2U0V2Nk9iWUY4RFh5YXFKZDRreUNi?=
 =?utf-8?B?RDdORS9xa2c1djFmNURqYWc3QWZaVVdkTzF6bTFSbFgyR3hrbGMycktXckxz?=
 =?utf-8?B?RVdZZ283bGZHY01XOWVvampNSHE3UXFicStvcmQzTzhqNXJucG4vUWYxcWY3?=
 =?utf-8?B?WnJkZ2NQL0VjVWRldDY1aHN5ZVVKVkhHVmtyTTI4bTRxMGpFRkc1aVhnNHZZ?=
 =?utf-8?B?NU1uemROSXlNSjRtdDVMTThnTmZlRkFBWldId0dhRXFnTmdobmR0Rldwd1B5?=
 =?utf-8?B?WGQzM0hUdlhGSFJyYVBweGJ2RmdhcjZpa3RSNjNmSXQ5Y0ZJTGo3WTNSSU9K?=
 =?utf-8?B?ODJqVmFBZmxEZU1Oa1hRdUY0ODRoQXhBcXRtRGwvd2xLR3FtMmJkMmZyMlBm?=
 =?utf-8?B?cUt4YWFDVW9SU3ZhQWN6WWdrZEpqaXV0OTBXaEdRM1FLamZPL3FRMHJ5UzFV?=
 =?utf-8?B?SXFWRUdzZElwOEZZT1k2OG4vcWRORTBXWkJubHNySzhlZFlEMzdVMjNuT0hq?=
 =?utf-8?B?YlV1dGNsWlE4bldyZFlsRWhhZzlEVVFHRmo2QlVCSCtMYzRuYWNQMTBWaXZu?=
 =?utf-8?B?cjFZREVpQlJ1cmpacmxSN0t6Y3JrcFlQOFFCemZINUlhVHorZEl0d3lkT2Vt?=
 =?utf-8?B?dlc5WC9Wd0Noa2QxYjFxYkI3Z0pDUGZUK3F3dTM1L1FCV2RNclVKOFVES2dx?=
 =?utf-8?B?emdCcTFyNjZDa3R0a1B2Q1NWbWpyQkR2WE5ZWEZmaTZaTGtSNFFJU09LclU4?=
 =?utf-8?B?dThHaHhmVHg0ODZDdk8zZ0lVc1hUemYzTmh6K25VVTg2NlN3MTFLdXdZQ0Nk?=
 =?utf-8?B?RHVFeVQyK25SLzV2WmtpTjdGYWtqVXAycERSanpraGxTU2J0bkhBaG85MXhX?=
 =?utf-8?B?bG5jUHkwdGRPVDRKcmpNcDY4ZklpMUJxMjJGQVE2dzU1aEJ5Z1VPZWUzQnQz?=
 =?utf-8?B?UVRNNEY3UUFIUmdMOTBqbnRVVnlISm5EUlNYaGt4ei9JaFJpT2xGYlIvTE9P?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52814f97-38ec-4475-6bc6-08dde2e1962e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 07:41:07.4101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwvdxtsJJSdf4ySaxNpCR8COu2ac2ryDoxGizkyisqFv15GrJtL/zcKKXKkGDTsAPssj4uz1Sg+OVAbnfEQA8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6265
X-Rspamd-Queue-Id: B604741BCD
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	DWL_DNSWL_BLOCKED(0.00)[siemens.com:dkim];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.42:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: PLAB2NVXMYLZPAJWIVXBZSDVYT56AWH2
X-Message-ID-Hash: PLAB2NVXMYLZPAJWIVXBZSDVYT56AWH2
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PLAB2NVXMYLZPAJWIVXBZSDVYT56AWH2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

RllJOiBRRU1VIG1vZGVsIGlzIHdvcmtpbmcgZmluZSwgdXBzdHJlYW1pbmcgc3RhcnRlZCwgZmVl
ZGJhY2sgd2VsY29tZS4NCg0KSmFuDQoNCk9uIDI0LjA4LjI1IDA5OjE4LCBKYW4gS2lzemthIHdy
b3RlOg0KPiBUaGlzIGNsb3NlcyBhbiBvbGQgZ2FwIGluIHN5c3RlbSBpbnRlZ3JhdGlvbiB0ZXN0
aW5nIGZvciB0aGUgdmVyeQ0KPiBjb21wbGV4IEFSTSBmaXJtd2FyZSBzdGFja3MgYnkgYWRkaW5n
IGZhaXJseSBhZHZhbmNlZCBSZXBsYXkgUHJvdGVjdGVkDQo+IE1lbW9yeSBCbG9jayAoUlBNQikg
ZW11bGF0aW9uIHRvIHRoZSBlTU1DIGRldmljZSBtb2RlbC4gS2V5IHByb2dyYW1taW5nDQo+IGFu
ZCBtZXNzYWdlIGF1dGhlbnRpY2F0aW9uIGFyZSB3b3JraW5nLCBzbyBpcyB0aGUgd3JpdGUgY291
bnRlci4gS25vd24NCj4gdXNlcnMgYXJlIGhhcHB5IHdpdGggdGhlIHJlc3VsdC4gV2hhdCBpcyBt
aXNzaW5nLCBidXQgbm90IG9ubHkgZm9yIFJQTUItDQo+IHJlbGF0ZWQgcmVnaXN0ZXJzLCBpcyBz
dGF0ZSBwZXJzaXN0ZW5jZSBhY3Jvc3MgUUVNVSByZXN0YXJ0cy4gVGhpcyBpcyBPSw0KPiBhdCB0
aGlzIHN0YWdlIGZvciBtb3N0IHRlc3Qgc2NlbmFyaW9zLCB0aG91Z2gsIGFuZCBjb3VsZCBzdGls
bCBiZSBhZGRlZA0KPiBsYXRlciBvbi4NCj4gDQo+IFdoYXQgY2FuIGFscmVhZHkgYmUgZG9uZSB3
aXRoIGl0IGlzIGRlbW9uc3RyYXRlZCBpbiB0aGUgV0lQIGJyYW5jaCBvZg0KPiBpc2FyLWNpcC1j
b3JlIGF0IFsxXTogVEYtQSArIE9QLVRFRSArIFN0YW5kYWxvbmVNTSBUQSArIGZUUE0gVEEsIHVz
ZWQgYnkNCj4gVS1Cb290IGFuZCBMaW51eCBmb3IgVUVGSSB2YXJpYWJsZSBzdG9yYWdlIGFuZCBU
UE0gc2NlbmFyaW9zLiBJZiB5b3UNCj4gd2FudCB0byB0cnk6IGJ1aWxkIHFlbXUtYXJtNjQgdGFy
Z2V0IGZvciB0cml4aWUgd2l0aCA2LjEyLWNpcCAqaGVhZCoNCj4ga2VybmVsLCBlbmFibGUgc2Vj
dXJlIGJvb3QgYW5kIGRpc2sgZW5jcnlwdGlvbiwgdGhlbiBydW4NCj4gDQo+ICQgUUVNVV9QQVRI
PS9wYXRoL3RvL3FlbXUtYnVpbGQvIC4vc3RhcnQtcWVtdS5zaA0KPiANCj4gRGVwbG95IHNuYWtl
b2lsIGtleXMgaW50byBQSywgS0VLIGFuZCBkYiBhZnRlciBmaXJzdCBib290IHRvIGVuYWJsZQ0K
PiBzZWN1cmUgYm9vdGluZzoNCj4gDQo+IHJvb3RAZGVtbzp+IyBjZXJ0LXRvLWVmaS1zaWctbGlz
dCBQa0tlay0xLXNuYWtlb2lsLnBlbSBQSy5lc2wNCj4gcm9vdEBkZW1vOn4jIHNpZ24tZWZpLXNp
Zy1saXN0IC1rIFBrS2VrLTEtc25ha2VvaWwua2V5IC1jIFBrS2VrLTEtc25ha2VvaWwucGVtIFBL
IFBLLmVzbCBQSy5hdXRoDQo+IHJvb3RAZGVtbzp+IyBlZmktdXBkYXRldmFyIC1mIFBLLmF1dGgg
ZGINCj4gcm9vdEBkZW1vOn4jIGVmaS11cGRhdGV2YXIgLWYgUEsuYXV0aCBLRUsNCj4gcm9vdEBk
ZW1vOn4jIGVmaS11cGRhdGV2YXIgLWYgUEsuYXV0aCBQSw0KPiANCj4gTm90ZSB0aGF0IGVtdWxh
dGlvbiBpcyBhIGJpdCBzbG93IGluIGdlbmVyYWwsIGFuZCBzcGVjaWZpY2FsbHkgdGhlDQo+IHBh
cnRpdGlvbiBlbmNyeXB0aW9uIG9uIGZpcnN0IGJvb3QgaXMgdGFraW5nIDIwIG1pbi4gLSB3ZSBz
aG91bGQNCj4gcHJvYmFibHkgcmVkdWNlIGl0cyBzaXplIG9yIHVuZGVyc3RhbmQgaWYgdGhlcmUg
aXMgc3RpbGwgc29tZXRoaW5nIHRvDQo+IG9wdGltaXplLg0KPiANCj4gSmFuDQo+IA0KPiBbMV0g
aHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9j
b21taXRzL3dpcC9xZW11LXJwbWINCj4gDQo+IENjOiAiRGFuaWVsIFAuIEJlcnJhbmfDqSIgPGJl
cnJhbmdlQHJlZGhhdC5jb20+DQo+IA0KPiBKYW4gS2lzemthICg4KToNCj4gICBody9zZC9zZGNh
cmQ6IEZpeCBzaXplIGNoZWNrIGZvciBiYWNraW5nIGJsb2NrIGltYWdlDQo+ICAgaHcvc2Qvc2Rj
YXJkOiBBZGQgdmFsaWRhdGlvbiBmb3IgYm9vdC1wYXJ0aXRpb24tc2l6ZQ0KPiAgIGh3L3NkL3Nk
Y2FyZDogQWxsb3cgdXNlci1pbnN0YW50aWF0ZWQgZU1NQw0KPiAgIGh3L3NkL3NkY2FyZDogUmVm
YWN0b3Igc2RfYm9vdHBhcnRfb2Zmc2V0DQo+ICAgaHcvc2Qvc2RjYXJkOiBBZGQgYmFzaWMgc3Vw
cG9ydCBmb3IgUlBNQiBwYXJ0aXRpb24NCj4gICBjcnlwdG8vaG1hYzogQWxsb3cgdG8gYnVpbGQg
aG1hYyBvdmVyIG11bHRpcGxlDQo+ICAgICBxY3J5cHRvX2dudXRsc19obWFjX2J5dGVzW3ZdIGNh
bGxzDQo+ICAgaHcvc2Qvc2RjYXJkOiBIYW5kbGUgUlBNQiBNQUMgZmllbGQNCj4gICBzY3JpcHRz
OiBBZGQgaGVscGVyIHNjcmlwdCB0byBnZW5lcmF0ZSBlTU1DIGJsb2NrIGRldmljZSBpbWFnZXMN
Cj4gDQo+ICBjcnlwdG8vaG1hYy1nY3J5cHQuYyAgIHwgICA0ICstDQo+ICBjcnlwdG8vaG1hYy1n
bGliLmMgICAgIHwgICA0ICstDQo+ICBjcnlwdG8vaG1hYy1nbnV0bHMuYyAgIHwgICA0ICstDQo+
ICBjcnlwdG8vaG1hYy1uZXR0bGUuYyAgIHwgICA0ICstDQo+ICBody9zZC9zZC5jICAgICAgICAg
ICAgIHwgMzE0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICBo
dy9zZC9zZG1tYy1pbnRlcm5hbC5oIHwgIDI0ICsrKy0NCj4gIGh3L3NkL3RyYWNlLWV2ZW50cyAg
ICAgfCAgIDIgKw0KPiAgaW5jbHVkZS9jcnlwdG8vaG1hYy5oICB8ICAxMiArKw0KPiAgc2NyaXB0
cy9ta2VtbWMuc2ggICAgICB8IDE4NSArKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDkgZmls
ZXMgY2hhbmdlZCwgNTMwIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRl
IG1vZGUgMTAwNzU1IHNjcmlwdHMvbWtlbW1jLnNoDQo+IA0KDQotLSANClNpZW1lbnMgQUcsIEZv
dW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCkxpbnV4IEV4cGVydCBDZW50ZXINCg==
