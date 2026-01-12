Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54CCC9EC97
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 15:25:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 24F3943285
	for <op-tee@archiver.kernel.org>; Mon, 12 Jan 2026 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1768231514;
	bh=0hPcjqACa4c9Trx9s6SRXrJu1aZz/mhk/6kr/KEL6A0=;
	h=To:Subject:Date:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mHsd6xobHXKAlP9ut+WRCWFwzv/p+5b8u9vBFllmBVOjjwMA0HPabjvz4rV/mGu/L
	 WHQWf03UYRDaDK6Bt1hHcYQcinRsTUHnvWZxmaaamo4imbABAZLiZ7Q08cc/WMyGNr
	 qUC9vD9OhRjrQqi1lhwKAqxG95juzOkoxeLeFQU/rUdkkoza7S4BEBkeicWFubnsHC
	 VX+JWYaePQLa2LF+LwSaOKKRP7ZZ7r3pWNojwdVMHqlBaBaTsd/YlV/Mu05q9Z9F3s
	 CXTKkiMOtixBUo2O8+6vesOiMhAu8dkIOdiysLVIP6d6lJJnfxAItIQ0AhWLec5gWH
	 6k+/184v0sc6w==
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 23ACE41A43
	for <op-tee@lists.trustedfirmware.org>; Mon, 12 Jan 2026 15:24:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SAv4V12X;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UErWv0qbmVZdJuefC/gybnw9QA3RVGcLPUolg3ucpNoUc5AyhS4cjXbzNMwVBj4hfFOCQTjxIz7T+rFUF3hpLtTaD7qaY1ivVKTopbBh42MQQuoIQF1CeIyGqqXNjtM9QcSRmf844ioMgjqdh97dpYUVypw81MTV2+bDzZOe5hacwAtQ2fuIDDYJmiCu7x0/dozin2+t0oIINHfHUFpsxwF4jEgecwj9SbZBaqXIiqCNO5McBPvQpGjXDjkLvYmAbgK5JmPyn+Cr19DcXRFab88+JW4GQsFAo/RY+WzXFX+Io7hRnxTUGFJyIWCsHciBxEJg5+Ba2wSIvEnWgGoVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=US4pPQq2bWErb16MdERYs58zZAxyizMo+nHv8EBZnYs=;
 b=kwUnO41hsREwccqxllby62FKLKLVAyPJGnot/lUj/7hMjg84fvYaQNvRz/zt/+H39aqZ4AbY3eYcl74ZyzZOrU6mFk/y5Y2aBp7ACO6YlI8VCuue+cqnWW+7I5puANgmG3AuwTHWAsWGKHyxpRPjHZ7QVoZfqP7NKMGfW4U9dTicSKi68BXsjHy5Rwd5m1WKq0Ph2ID2XnQNTbM/Bbgk84yMgPceGXGqjnSn/w7XYsaTD9B1IOrrsOiLoG0ksyj8y/YMHts4M0qboF/LOhcVRNEyQ9/oirTTglxfhskJbqAhsm2TWFmQ6Df837G9hkXZDxsH0Wv6huQC5RQvUveqAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=US4pPQq2bWErb16MdERYs58zZAxyizMo+nHv8EBZnYs=;
 b=SAv4V12XElN/nY+Ca8rQPLgglQeCliHie71YGwzqpjYtJw6uqJyyVVncs4rMwsQeCQutNcb+Lk2KlqxCQgjcDaXTnNJjR6vwvSDLo+OXdMCUZ/Xfkt8QIgpjuXgqJA+qr0u4PSzbU/04Hb8K6K5xpY/1ZluFsi6ObKYfPwe9Nv11nBEWoLbKSrlh3zGtVQMp9HzkBObWJUOnSuw9AkMU6CVsHEEdTBX6hpuAauM2JGH7H0oMKUi8r+PO0BWfOGjzKBa7g3hOuz+B/txNK1fkGx9Qjs7Lf/PsszUeC36CX4h/HT04SewbwsJA9sGg3BQq7lHhUhMjXE0A9T4G9UpLFg==
Received: from DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) by
 BL4PR12MB9481.namprd12.prod.outlook.com (2603:10b6:208:591::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.7; Mon, 12 Jan 2026 15:24:49 +0000
Received: from DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::e6e0:ccda:fd50:c52a]) by DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::e6e0:ccda:fd50:c52a%3]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 15:24:49 +0000
To: ryan foster <foster.ryan.r@gmail.com>, Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH][next] optee: make read-only array attr static const
Thread-Topic: [PATCH][next] optee: make read-only array attr static const
Thread-Index: AQHcgX7h/v5OHKBUS0uSXljIUNaP6LVOaYIAgAA384CAAAnBGg==
Date: Mon, 12 Jan 2026 15:24:49 +0000
Message-ID: 
 <DS0PR12MB8294F8C07E39842AC16CBA21AF81A@DS0PR12MB8294.namprd12.prod.outlook.com>
References: <20260109154442.421248-1-coking@nvidia.com>
 <aWTaUvGu9dlvnJO9@sumit-xelite>
 <CAHtS329G-H8vVVr==DZUAetzVNc4couN2OV3tH7qH_7YDGe8xA@mail.gmail.com>
In-Reply-To: 
 <CAHtS329G-H8vVVr==DZUAetzVNc4couN2OV3tH7qH_7YDGe8xA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB8294:EE_|BL4PR12MB9481:EE_
x-ms-office365-filtering-correlation-id: 2f2713fa-eb29-4557-9679-08de51eeb9b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?OU5Dc0FHeTN2TGZYRmlzY0RCcTlkT0IyOFRtYlJJM2lvdFVLSHF5QUx1SlZp?=
 =?utf-8?B?ckNITnVFTHpJeTcyc3BiemtGMDA5Q2pIK1piUXZTa3RVN2xpcTkreDZHZGJk?=
 =?utf-8?B?cnNBeFU3ZlJOYVV4ZkxnMjV4RkM2Yk5ZU00ydVVCUXZBM3RRL0F4SDdENVhT?=
 =?utf-8?B?UDBtem95dU9XdzZXcHpFTzZycTRyTnZhTnoyallBOElNWCtHTnRNSlBCNk5K?=
 =?utf-8?B?ZktlTVMya2ZNY2NaK3QrMWl4MXVzeXk4MEhZWFFhNnlRRkEzZjRzdU9XR3py?=
 =?utf-8?B?bGMvZ1lHcjNQeEYvRm9WWitCQWRrTzQwYTZYeHhuemoyL1NUeXF5c2dOYkp3?=
 =?utf-8?B?b3l1TmpBczAzZXU2a1lrQ0lCeVJJR3U2NzdDL1dManZReWtXa3VUTWJHbEM5?=
 =?utf-8?B?REpzU0dReEx4MHVxaXF5YU5xSWZsMXFZMVkzaDdqcS9XRGF3TGxYOUVlNWdk?=
 =?utf-8?B?RjJnb2VrUCtWdGpJSnNscmQvTUg5V0xxWXNRVjIxdlB3TkxUdEdZUjNkV1NH?=
 =?utf-8?B?K0RDRmRvNnBMeGFSaklDdFQ5cDlCYWJGRDJrbmI3a2d5b3grUHFUUjQ1Z1dC?=
 =?utf-8?B?OGpLMHQya1FoRXQvRyt1a1VGalh0YlBnK3grOEdEVVZ6L25jVTZuQ09vY3ow?=
 =?utf-8?B?aWlsbUsyMVN1cjF0T09RaXlVYzdKajYwNExQanNObDI3VTdFZTNIeURKR21N?=
 =?utf-8?B?V2lxUC8wTmUzVGU1VzdRRVA1aGE1YkNGQjJWNkEzU1Uyc3IwYkFCUXBCM0t0?=
 =?utf-8?B?YjZUU3JuQXN6WGNRYkp0UzJ2SkF6RzcyK1RYOW5GZGNBckMvKzBwdVdJUDQ5?=
 =?utf-8?B?bDBtMmNyV0VJTFBxd3ptMkJKWndOQll4a1pRdklxaXN1bExqUmcvTXRJWnhx?=
 =?utf-8?B?dVN2aFNqcWgwY3ZHTlBwRGxFakRBY3FRY01yTkpPYmdpcnF6dHdocWNobTNx?=
 =?utf-8?B?aGZZZjRRTXc2aUllUEVVWDdFL1dEc0I3bFZmUUNINDBEN2M1ek92d1NTbFZU?=
 =?utf-8?B?Q3I4SVZvMlhtV0dJcldyVGhaWEptOXBSWDlLSUZqWHpPeHBmYjVVdEF5Qmd2?=
 =?utf-8?B?RmxFeDJ6bnhrdTljR0J5SENHaDlCSUZnR3p5VnBGQkxvRlc4NCt1UWExZEVm?=
 =?utf-8?B?OHRUaWMyNDFmajgzUU9ObHlGNEVHTytmdVBiUE1SeUpaRVNtUWxGb2pIYkhk?=
 =?utf-8?B?dXpoUUFiTFVmKys1SE1nU1dvSGwwZW1zdmpSNW1wZXVMRUxLRThsRDJabmpI?=
 =?utf-8?B?T0lmSXhuTmo2NGJ0N3VwYnpVcGd1NWoybDI2aGN4UlAvaEhUbkZpdXMwanpT?=
 =?utf-8?B?MDdHOW9nbVRaYnM5empqbGFNWS9CU2VGcXVzdS9OK0RRWHk0ZS9JenhDaGUw?=
 =?utf-8?B?WitZV0JxVXFvTXhPWTQwbWlrdFgxaTkvYlpkcjljTmo3SXk1UzFpUnhaNnFS?=
 =?utf-8?B?T2dtbzE0OGcvRi84ZEJxcXhGeUlvcDByb0FCc0VTODRHczJGZU15bW9jNW9Q?=
 =?utf-8?B?UkdZdWlRYjRpNTVrUURwZ2kwbWNyL29yM1doNHp4RGZXSTB6eG1FMHlxZkVQ?=
 =?utf-8?B?YlFxSlRTS3lzajQxakhDTGZROVZQcCtUTHFpOHVHK3o4V2pCTEdTd3BtWGhw?=
 =?utf-8?B?L3Z1NWNFb2lQWDBxV0VyWnpjS20xTXlpTGFMTnF3bUlQTXlTK2dFYWFVVHpP?=
 =?utf-8?B?dC9USll3cDY5a1FkelQzcjJja1hLbXZTRDZQZ21qV2VKUzBnUTdQUC83VmVT?=
 =?utf-8?B?Um0vNlAzVG1QcSthWmtFRGRZZTdjTDF3WlA3dDJ1QWJ1bzRrcXlkWlJ1UVRp?=
 =?utf-8?B?TVJmSzJjNkxLMitRcFZ0QlFESmNCQSswMDlOQ3VxSGtKMGhmcUpvR0VNRndy?=
 =?utf-8?B?emFMTFl0MmF0RXNScmdQOUdOQitaTnhNcjdxYlhoZjZxTWd6a3VYempEQzdq?=
 =?utf-8?B?ZlpIamY4bjVOdjh6ajZqWVlocDR6UUFZMXhaV3prMlpLZTZoblJOL2ZNNHBw?=
 =?utf-8?B?ZVc4NjJySTA1QmxzN1BxRWgrOVh3NG01cSsvY1U4V1BRc29BMkdDbWJJNmZx?=
 =?utf-8?Q?OU7LsY?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MG5KNWRpZFFQbXdmdnExRDBKZWwydXkwYlRob09DRjYwVDJLYi9mYlR0ZXRF?=
 =?utf-8?B?TG8xeVMwWVhpdGswUUZpcVQ4em5nODZJRis2a01yRXZHTjNOd2k1NEVwZll1?=
 =?utf-8?B?Qy9uY1psSjQ3WFFid3hyRlNkWGdUU2I0Y3d6MCtQajdkd0RyZ1RFV1BXTm04?=
 =?utf-8?B?TnhvOE1WaUg2aHJSUkpmeUR2RXFtNlYwYnVKY0FMSmZHc1ZkNDdUUWxjaVhx?=
 =?utf-8?B?UzZZV1dFZWFXUENhOHRjdEloL3E4RnJXSVFGMlQ2UTk1N2dXUktML0x5KzZK?=
 =?utf-8?B?S05vMVoyNi9mTGxQcWZqcFhIQ3RxdElkQ3BUWllyL05hVmlJQkhjTkdMV2lY?=
 =?utf-8?B?L0tZVEdVa0tKaHI4V0hOM0tIRCtPbm9YTGJXMXhMMTdZeTBCN3hGOEt4SVo0?=
 =?utf-8?B?bzIzdzYyb2pSd2huZmYwSm1HaVZCTkZ6YmZTSFlzOVFuUUUxNlord0JRNnRk?=
 =?utf-8?B?c2dhemgvUWRNNisyZ3drMVdyQTFVQzVmdm5aZUxtZzhEMENoRTl6U3RneWFm?=
 =?utf-8?B?OW9JbDJidHFBdEZsaEZVYVJ6cHp5cWhZaEFIbWtUYlpBdkRTdDcxaE03eitD?=
 =?utf-8?B?VXZMR0hOb1hIbFJjd09iNnpOVjlVcW5xSjg0MjFCTUlVZ3REZVM4V1pLanNB?=
 =?utf-8?B?VDE2a0dXVE9yTUFidmNBaCtnM1JIdU5JUzluR21MMG1jNHBEc3FMV1NwcWJa?=
 =?utf-8?B?UkpBUkU5NVpCbHF4anlEOGhTVm00RlpMUElOczBqVkhZbXJxMW5GdThra1hS?=
 =?utf-8?B?TldyZ2Zhd3BLdXRyYVlXaHMwUWNrdkJRUkRxVjFCVE40aDBKY3hlR1hUKzFY?=
 =?utf-8?B?OVNiMXNvYUI0cWhOR2hhdHBCMUt6eFY2KzdwS0hzS0xkbnVGa09mVFBCU2I4?=
 =?utf-8?B?TlQrRXZVNFBiOVJGMkJPY3EvQkZMbG9RSG1TNnVzVUtLSHU3WXVRVXRxeEM0?=
 =?utf-8?B?RDRiTHkvdTh1a3RLN0RJdFgzZHlNaGRhLzdreHFZMWlzRTFHV1pET1JrQmNs?=
 =?utf-8?B?bTFLaCtaVWhZaDg0clR3Q0s5OW05NnJwa1ZOME56ejlSUFE5SjlTWWdXSmV5?=
 =?utf-8?B?YTlMTGQ1LzJFaEJiSi9JSGQ1b3BiQUJMUlcxSmgwMjB3NktoQllmOTZ4VlpO?=
 =?utf-8?B?ZkV0L1FRS3ZHaElsTlZCL0VGMCs1eGJLRnRpUmZhTHUxK2ppaW1rVDkrUkY0?=
 =?utf-8?B?RFZuTy8rbXlkck5SdEY3QXg0OXlZUlFLdWxUUFdOWmpFamJyRDdyZzFjVmJk?=
 =?utf-8?B?ZldtWERKWTh1YVdiM2N4RCt1ZGFaV1BqZnFWQW9vTkd4a3pjWFhIMXZsbEND?=
 =?utf-8?B?OTJKVVdBVGh4VFVTc0N0TDQ5T0tubGdxVFZaeHU4NHErTmJodG1SK0Q1cG1s?=
 =?utf-8?B?S2RZdmxWQlh2cWlRano5TlRINjNsRUlkeUZsOWJyYmw4Z1RhSHBZaGp5QkVZ?=
 =?utf-8?B?NVhpZzVTTjB3VDV4ZjdWT1RUOTJkazdvZjJZOUIxanlZMXZacHJNZ0dOY05U?=
 =?utf-8?B?VHlEbGk1bjJCOC92RWR0eXZaQkJkUHYycHlBUlMzdUdNV0JObDhrZlZCaUhs?=
 =?utf-8?B?Y2wrajlEWUV4SlRXNmxJNWdaSWJUZzl4dStjdFFqWVhTYTZUL0FsQzBjV1Zx?=
 =?utf-8?B?SXA3bTV5Q0hYQnIrVWNNRzRiZHZxSDV4Z2txS0JpNzgrZGlPQW90RDZQQVJN?=
 =?utf-8?B?Mm1mdXpVdEhRK0s3b3ZpRUVabGxmS04xc0NNRnJqV0V0YThRczhldXp0MW1T?=
 =?utf-8?B?Nktma1FMMjRRU3g3bDVwRnBDclg3VTNmV3BKdUtCeHFzdVZDbzBDdW5xa1hi?=
 =?utf-8?B?NXlPNXZ1THp1RVpaMzZzWDNDL0NVOHdpQkxIVUtxRVo4dzFiNjV4bGFBa29n?=
 =?utf-8?B?bkdvMm9IRXlJR2tFQlhxQkJLTkI1MDhMUWNadUR1WGRmVnJzUVhZZWtURVIz?=
 =?utf-8?B?T2NqbzR6Kyt3WjEzcUMzVjJtQ0laU3o4T3V5bDR5d1JjcytzLzZ6bGFVZHlq?=
 =?utf-8?B?eFRPTk10elBEWGlncHBnanBvSlpDSFE5YWdNR0NTVVVUMjRjNTFuKzM2eVNP?=
 =?utf-8?B?MUgrNGo4N2E2OXZhbWYxbnFUNXZyYkZMYmJXWGxoK2MrbkowQ0RKT09VdlFv?=
 =?utf-8?B?NVdVWjdma2hJQ2ZCTWFrc04wR0lVc3NES1dNK2g0ZEYzaTkzclN2MGxCMWQ4?=
 =?utf-8?B?UXF3b05VYjd0ejl3eFlQaUlvdU9MTXVCa0JadVBMd0ptVE1GNVVFVVhaM08w?=
 =?utf-8?B?Y1dnMlBKMUN3a0xUb3h5TGYxQWZnYW42alc2K1RjNk1VcCtIaDU2MzEvQ1Ri?=
 =?utf-8?Q?sHBiIX4Vcn3SxFtQHu?=
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2713fa-eb29-4557-9679-08de51eeb9b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 15:24:49.2060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /CHvgIm02+KplSzuP/FpxOQpoKe6doePo0nL4DclRsyFpYIpvGFwR9hPk26ON++nxCTSKZiA4yInq+jHANA50Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9481
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.40 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[Nvidia.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DNSWL_BLOCKED(0.00)[40.107.200.7:from];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.200.7:from];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 23ACE41A43
X-Spamd-Bar: -----
Message-ID-Hash: L4EDC6K4DLTPLLE3E5ZOQU4EELTD4B23
X-Message-ID-Hash: L4EDC6K4DLTPLLE3E5ZOQU4EELTD4B23
X-MailFrom: coking@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7V5ALQW5EGQND2TCGJOCEVRGM4SXSLPE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Colin King via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Colin King <coking@nvidia.com>

SSBhZGRlZCB0aGlzIGNoYW5nZSBmb3Igc2V2ZXJhbCByZWFzb25zLCBpdCdzIHJlYWQtb25seSBz
byBtYWtpbmcgaXQgY29uc3QgaXMgYWx3YXlzIHNlbnNpYmxlLiAgTWFraW5nIGl0IHN0YXRpYyBt
ZWFucyB3ZSBkb24ndCBnZXQgdGhlIGNvbXBpbGVyIHRvIGdlbmVyYXRlIG9iamVjdCBjb2RlIHRo
YXQgc3RvcmVzIHRoZSBhcnJheSBvbiB0aGUgc3RhY2sgKGVhY2ggdGltZSBpdCdzIGNhbGxlZCkg
YW5kIHRoZW4gaW5kZXggaW50byBpdCwgaW5zdGVhZCB0aGUgZGF0YSBpcyBwdXQgaW50byBhIHJl
YWQtb25seSBkYXRhIHNlY3Rpb24gYXQgY29tcGlsZSB0aW1uZSBhbmQgdGhlIG9iamVjdCBjb2Rl
IGp1c3QgZmV0Y2hlZCBkYXRhIGZyb20gdGhpcyBhcnJheS4NCg0KQmFzaWNhbGx5LCBpZiBpdCdz
IHJlYWQtb25seSBpdCdzIGdvb2QgdG8gbWFrZSBpdCBjb25zdCBhbmQgaXQncyBub3QgaW4gYW4g
X19pbml0IHNlY3Rpb24gdGhlbiB5b3UgbWF5IGFzIHdlbGwgbWFrZSBpdCBzdGF0aWMgY29uc3Qu
IEl0J3Mgc2NvcGVkIGluc2lkZSB0aGUgZnVuY3Rpb24sIGV2ZW4gdGhvdWdoIGl0J3MgaW4gdGhl
IGRhdGEgc2VjdGlvbi4NCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KRnJv
bTogcnlhbiBmb3N0ZXIgPGZvc3Rlci5yeWFuLnJAZ21haWwuY29tPg0KU2VudDogMTIgSmFudWFy
eSAyMDI2IDE0OjQ2DQpUbzogU3VtaXQgR2FyZyA8c3VtaXQuZ2FyZ0BrZXJuZWwub3JnPg0KQ2M6
IENvbGluIEtpbmcgPGNva2luZ0BudmlkaWEuY29tPjsgSmVucyBXaWtsYW5kZXIgPGplbnMud2lr
bGFuZGVyQGxpbmFyby5vcmc+OyBvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13YXJlLm9yZyA8b3At
dGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmc+OyBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJu
ZWwub3JnIDxrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdW25leHRdIG9wdGVlOiBtYWtlIHJlYWQtb25seSBhcnJheSBhdHRyIHN0YXRpYyBj
b25zdA0KDQpUaGlzIGxvb2tzIGxpa2UgYSBtaWNyby1vcHRpbWl6YXRpb24sIGNvbnN0IG1ha2Vz
IHRoZSBsb29rdXAgYXJyYXkNCmV4cGxpY2l0bHkgaW1tdXRhYmxlLCBhbmQgc3RhdGljIGtlZXBz
IGl0IG91dCBvZiB0aGUgc3RhY2sgZnJhbWUsDQphdm9pZGluZyBwZXItY2FsbCBpbml0aWFsaXph
dGlvbi4NCg0KSXMgdGhlcmUgYSBzdHlsZSBwcmVmZXJlbmNlIGZvciByZWFkIG9ubHkgbG9va3Vw
IGFycmF5cyBoZXJlLCBlLmcuDQpTaG91bGQgdGhlc2UgdmFyaWFibGVzIHJlbWFpbiBsb2NhbCBi
dXQgbm90IHN0YXRpYywgb3Igc2hvdWxkIHRoZXkgYmUNCm1vdmVkIHRvIGZpbGUgc2NvcGUgc3Rh
dGljIGNvbnN0Pw0KDQpPbiBNb24sIEphbiAxMiwgMjAyNiBhdCAzOjI24oCvQU0gU3VtaXQgR2Fy
ZyA8c3VtaXQuZ2FyZ0BrZXJuZWwub3JnPiB3cm90ZToNCj4NCj4gT24gRnJpLCBKYW4gMDksIDIw
MjYgYXQgMDM6NDQ6NDJQTSArMDAwMCwgQ29saW4gSWFuIEtpbmcgd3JvdGU6DQo+ID4gRG9uJ3Qg
cG9wdWxhdGUgdGhlIHJlYWQtb25seSBhcnJheSBhdHRyIG9uIHRoZSBzdGFjayBhdCBydW4NCj4g
PiB0aW1lLCBpbnN0ZWFkIG1ha2UgaXQgc3RhdGljIGNvbnN0Lg0KPg0KPiBJcyB0aGVyZSBhbnkg
dmFsdWUgYWRkIHRvIGRvIHRoaXM/IEFGQUlLLCB0aGUgc3RhdGljIGxvY2FsIHZhcmlhYmxlcw0K
PiBhcmVuJ3QgcHJlZmZlcmVkLg0KPg0KPiAtU3VtaXQNCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENvbGluIElhbiBLaW5nIDxjb2tpbmdAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJp
dmVycy90ZWUvb3B0ZWUvcnBjLmMgfCAyICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGVl
L29wdGVlL3JwYy5jIGIvZHJpdmVycy90ZWUvb3B0ZWUvcnBjLmMNCj4gPiBpbmRleCA5N2ZjNWIx
NGRiMGMuLjE3NThlYjdlNmU4YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RlZS9vcHRlZS9y
cGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdGVlL29wdGVlL3JwYy5jDQo+ID4gQEAgLTQzLDcgKzQz
LDcgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3JwY19mdW5jX2NtZF9pMmNfdHJhbnNmZXIoc3RydWN0
IHRlZV9jb250ZXh0ICpjdHgsDQo+ID4gICAgICAgc3RydWN0IGkyY19tc2cgbXNnID0geyB9Ow0K
PiA+ICAgICAgIHNpemVfdCBpOw0KPiA+ICAgICAgIGludCByZXQgPSAtRU9QTk9UU1VQUDsNCj4g
PiAtICAgICB1OCBhdHRyW10gPSB7DQo+ID4gKyAgICAgc3RhdGljIGNvbnN0IHU4IGF0dHJbXSA9
IHsNCj4gPiAgICAgICAgICAgICAgIFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfVkFMVUVfSU5Q
VVQsDQo+ID4gICAgICAgICAgICAgICBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX1ZBTFVFX0lO
UFVULA0KPiA+ICAgICAgICAgICAgICAgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZf
SU5PVVQsDQo+ID4gLS0NCj4gPiAyLjUxLjANCj4gPg0KPg0K
