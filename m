Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36288CCD184
	for <op-tee@archiver.kernel.org>; Sun, 19 Oct 2025 16:37:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5877A4186A
	for <op-tee@archiver.kernel.org>; Sun, 19 Oct 2025 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1760891857;
	bh=tlh5hDysGhAEYHTV+B4fsQmp9P8TQe8zZGaNTV8QdeE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=nf4CP+u5ovL/3wbmUbnBCS1TSIddgmBi5VuJx0lgPKkHQj+R9aegqxhpLAmGGfUS7
	 ZjA4iG/gs9Rb4OqMb/Rfgevwy9osHeqkahwb7o1Nvty4lR6QYTr/KyJh7c5cdgKUMh
	 HAiiGbkMYjClzqTJ5mWS3tVG34Qy2nI7zEOdgEZwh1zySmZ/S9bRslQ16E0retW5Ny
	 GC8xAMPBLOij+GkyGZP4WZLTpft9RAHseKeqaXxlAVnHlV9B0aWMW8oXRh7Zooa4+4
	 1+sk8lL1yX/IZtqIF2HUneVhtx83ub7hHLZC9f3OIbKkrXCeNbS2itoB/rNK2zRGOQ
	 qQd/H07PxEfWQ==
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 406204186A
	for <op-tee@lists.trustedfirmware.org>; Sun, 19 Oct 2025 16:35:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=zsW41bzp;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDCxK4zRl1zGPgVrIry6wOnnYuxPLvoeri5SjP8Md4CbDKQYhc5dnFDjLjqi9oB1nVOtatZmsi3z9WTEzD/4ECNyuNPrX4qRY+Ihn7IaO34DZODjNC9n3cDwrEUA7XKNLmuQ2g/s0YnwOpVbYXgm/kbyBlom3CTwsScvwAzxLWQNRSQJSKNVDwflkseBLPv2zCwMSahOt1bGDD4xfW9gsPbMHyGo8v3FJqDEmnsD8NWD0rOMSJxgLfkrAv6S+dcd5uJJviycz5hgpuSUzA9lkcXOd1uWgHX4kVqDtYwiCRI1yQB1cPlXsc23t5NROpzygjXmkyiiM3HoCVusa5j6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mRO+gHTm69VQqC9B7ECyK/bPqMenrL88Ym1Vd3x8h4=;
 b=CPTuuyvo6aQaBp1pgPqkwdSAcrkNtgVR+pzQwnfyDDg8qlZonXAKGrvCJ2OUpvpnefVgkX9Fl1nT8ievFJrAuxTFTSRUVILzlqQjc2f/zOF3gKpq5cwfjJw1WiwIb5PrtnMT3Imb0Vr4Fl3eGOm47hN+7Tjq9BZr5oN6vEHcMTnjcfOjqXtgqIV/Rqr/qm/jCS8Tvn47gxW2IZ/sm0F5GS1rqh8uut0ZSddXojdolY9ur2N3n8ZMrQgBLYeNGY7xHppbEBDMIlCpLrPQ1Zt4QcTL0RgDtGQi3rsJrE/lnTNElUnP5kudq25tu23OvxcYdaGtOMJwrHBQekP/bLKlRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mRO+gHTm69VQqC9B7ECyK/bPqMenrL88Ym1Vd3x8h4=;
 b=zsW41bzpK3Cpt47PEnATP9nx4iG92gz76OtUjboqAo7bOuWeJhe27/BxgzCJESNJ0zx4v1IZYrJIyowcCfpuuAXGxIOZLrSGKlF+CRIv1OKkx2tWZqRfgKS89L/Ftt1NgFBS1DUIej9QwZn4WmB9kjBGMQ2fVxyn42HvOkgtukm6eeO4s2+0Kxh6vYXMOpkDOGW0w9XtpT8dMD+U34kG9XMxKKUv9Xs4WB8XvgpGkjeWbzDpEvWC75HWU6tlDSJqDTnYQUH5U5dja2qlAEqJ0FIN/6Db///6zkN1/fRIO5Bj/K/HB+BraYoV/M5/KGKSFFzX6licYzIAFP1FhV0UZw==
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM7PR10MB3256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 19 Oct
 2025 16:35:36 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9228.014; Sun, 19 Oct 2025
 16:35:36 +0000
Message-ID: <48eeceea-9f19-4f53-bccc-7dc566af11f9@siemens.com>
Date: Sun, 19 Oct 2025 18:35:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] sd: Add RPMB emulation to eMMC model
To: Sumit Garg <sumit.garg@kernel.org>
References: <cover.1756019920.git.jan.kiszka@siemens.com>
 <43295d5c-c939-42a9-a684-b7d7f3eed4cd@siemens.com>
 <aK2TBkzW7nDobJ5O@sumit-X1>
 <d9939ae1-b511-494c-8382-fe6b36af6744@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 xsFNBGZY+hkBEACkdtFD81AUVtTVX+UEiUFs7ZQPQsdFpzVmr6R3D059f+lzr4Mlg6KKAcNZ
 uNUqthIkgLGWzKugodvkcCK8Wbyw+1vxcl4Lw56WezLsOTfu7oi7Z0vp1XkrLcM0tofTbClW
 xMA964mgUlBT2m/J/ybZd945D0wU57k/smGzDAxkpJgHBrYE/iJWcu46jkGZaLjK4xcMoBWB
 I6hW9Njxx3Ek0fpLO3876bszc8KjcHOulKreK+ezyJ01Hvbx85s68XWN6N2ulLGtk7E/sXlb
 79hylHy5QuU9mZdsRjjRGJb0H9Buzfuz0XrcwOTMJq7e7fbN0QakjivAXsmXim+s5dlKlZjr
 L3ILWte4ah7cGgqc06nFb5jOhnGnZwnKJlpuod3pc/BFaFGtVHvyoRgxJ9tmDZnjzMfu8YrA
 +MVv6muwbHnEAeh/f8e9O+oeouqTBzgcaWTq81IyS56/UD6U5GHet9Pz1MB15nnzVcyZXIoC
 roIhgCUkcl+5m2Z9G56bkiUcFq0IcACzjcRPWvwA09ZbRHXAK/ao/+vPAIMnU6OTx3ejsbHn
 oh6VpHD3tucIt+xA4/l3LlkZMt5FZjFdkZUuAVU6kBAwElNBCYcrrLYZBRkSGPGDGYZmXAW/
 VkNUVTJkRg6MGIeqZmpeoaV2xaIGHBSTDX8+b0c0hT/Bgzjv8QARAQABzSNKYW4gS2lzemth
 IDxqYW4ua2lzemthQHNpZW1lbnMuY29tPsLBlAQTAQoAPhYhBABMZH11cs99cr20+2mdhQqf
 QXvYBQJmWPvXAhsDBQkFo5qABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEGmdhQqfQXvY
 zPAP/jGiVJ2VgPcRWt2P8FbByfrJJAPCsos+SZpncRi7tl9yTEpS+t57h7myEKPdB3L+kxzg
 K3dt1UhYp4FeIHA3jpJYaFvD7kNZJZ1cU55QXrJI3xu/xfB6VhCs+VAUlt7XhOsOmTQqCpH7
 pRcZ5juxZCOxXG2fTQTQo0gfF5+PQwQYUp0NdTbVox5PTx5RK3KfPqmAJsBKdwEaIkuY9FbM
 9lGg8XBNzD2R/13cCd4hRrZDtyegrtocpBAruVqOZhsMb/h7Wd0TGoJ/zJr3w3WnDM08c+RA
 5LHMbiA29MXq1KxlnsYDfWB8ts3HIJ3ROBvagA20mbOm26ddeFjLdGcBTrzbHbzCReEtN++s
 gZneKsYiueFDTxXjUOJgp8JDdVPM+++axSMo2js8TwVefTfCYt0oWMEqlQqSqgQwIuzpRO6I
 ik7HAFq8fssy2cY8Imofbj77uKz0BNZC/1nGG1OI9cU2jHrqsn1i95KaS6fPu4EN6XP/Gi/O
 0DxND+HEyzVqhUJkvXUhTsOzgzWAvW9BlkKRiVizKM6PLsVm/XmeapGs4ir/U8OzKI+SM3R8
 VMW8eovWgXNUQ9F2vS1dHO8eRn2UqDKBZSo+qCRWLRtsqNzmU4N0zuGqZSaDCvkMwF6kIRkD
 ZkDjjYQtoftPGchLBTUzeUa2gfOr1T4xSQUHhPL8zsFNBGZY+hkBEADb5quW4M0eaWPIjqY6
 aC/vHCmpELmS/HMa5zlA0dWlxCPEjkchN8W4PB+NMOXFEJuKLLFs6+s5/KlNok/kGKg4fITf
 Vcd+BQd/YRks3qFifckU+kxoXpTc2bksTtLuiPkcyFmjBph/BGms35mvOA0OaEO6fQbauiHa
 QnYrgUQM+YD4uFoQOLnWTPmBjccoPuiJDafzLxwj4r+JH4fA/4zzDa5OFbfVq3ieYGqiBrtj
 tBFv5epVvGK1zoQ+Rc+h5+dCWPwC2i3cXTUVf0woepF8mUXFcNhY+Eh8vvh1lxfD35z2CJeY
 txMcA44Lp06kArpWDjGJddd+OTmUkFWeYtAdaCpj/GItuJcQZkaaTeiHqPPrbvXM361rtvaw
 XFUzUlvoW1Sb7/SeE/BtWoxkeZOgsqouXPTjlFLapvLu5g9MPNimjkYqukASq/+e8MMKP+EE
 v3BAFVFGvNE3UlNRh+ppBqBUZiqkzg4q2hfeTjnivgChzXlvfTx9M6BJmuDnYAho4BA6vRh4
 Dr7LYTLIwGjguIuuQcP2ENN+l32nidy154zCEp5/Rv4K8SYdVegrQ7rWiULgDz9VQWo2zAjo
 TgFKg3AE3ujDy4V2VndtkMRYpwwuilCDQ+Bpb5ixfbFyZ4oVGs6F3jhtWN5Uu43FhHSCqUv8
 FCzl44AyGulVYU7hTQARAQABwsF8BBgBCgAmFiEEAExkfXVyz31yvbT7aZ2FCp9Be9gFAmZY
 +hkCGwwFCQWjmoAACgkQaZ2FCp9Be9hN3g/8CdNqlOfBZGCFNZ8Kf4tpRpeN3TGmekGRpohU
 bBMvHYiWW8SvmCgEuBokS+Lx3pyPJQCYZDXLCq47gsLdnhVcQ2ZKNCrr9yhrj6kHxe1Sqv1S
 MhxD8dBqW6CFe/mbiK9wEMDIqys7L0Xy/lgCFxZswlBW3eU2Zacdo0fDzLiJm9I0C9iPZzkJ
 gITjoqsiIi/5c3eCY2s2OENL9VPXiH1GPQfHZ23ouiMf+ojVZ7kycLjz+nFr5A14w/B7uHjz
 uL6tnA+AtGCredDne66LSK3HD0vC7569sZ/j8kGKjlUtC+zm0j03iPI6gi8YeCn9b4F8sLpB
 lBdlqo9BB+uqoM6F8zMfIfDsqjB0r/q7WeJaI8NKfFwNOGPuo93N+WUyBi2yYCXMOgBUifm0
 T6Hbf3SHQpbA56wcKPWJqAC2iFaxNDowcJij9LtEqOlToCMtDBekDwchRvqrWN1mDXLg+av8
 qH4kDzsqKX8zzTzfAWFxrkXA/kFpR3JsMzNmvextkN2kOLCCHkym0zz5Y3vxaYtbXG2wTrqJ
 8WpkWIE8STUhQa9AkezgucXN7r6uSrzW8IQXxBInZwFIyBgM0f/fzyNqzThFT15QMrYUqhhW
 ZffO4PeNJOUYfXdH13A6rbU0y6xE7Okuoa01EqNi9yqyLA8gPgg/DhOpGtK8KokCsdYsTbk=
In-Reply-To: <d9939ae1-b511-494c-8382-fe6b36af6744@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM7PR10MB3256:EE_
X-MS-Office365-Filtering-Correlation-Id: c867330b-8e8b-470f-751c-08de0f2d878f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WU4rbG9SUjVhcFpuZHo5R0FDM2tPK3hHTkdxcTNZSEpvV0ZOaG91cWdha2hE?=
 =?utf-8?B?elZFNzRVVVZ0VERjdUFxK0ZTOE5TWGtiU0ZzenNFZEcyN25SbTVYUEI5UGxJ?=
 =?utf-8?B?c3FjUThjMnJXYkFKdVdsckQxc1FESXlBWW14bDBKMDkraFpOL1oraE9RUVNQ?=
 =?utf-8?B?SGplUjFNTjk5NU5lYU4vRlRxV0V3M0tpdXNNc3VZYmw1YzErdGNwd1k1alFn?=
 =?utf-8?B?VW1ycmJwaThwUi9WWHpyODJTdUdHc1lRL0V3TWZBREJYV25EWFFOWDFtNC95?=
 =?utf-8?B?emIyWWZETHFFUUtBbVk5QWwyeHNaQ2NKcktoOG52Z3VvZ1BUY3pZZWp0WHJh?=
 =?utf-8?B?SlZpNC9mRUdnaVRMQ1RjczlncGdGWDA5Y2lwRTlraHJkQ2xZY21NcXlvUCtn?=
 =?utf-8?B?RnBBZ3U1OXRrNXRNTnBYaWgxaHI5VFpVT21UeDhJNTBCa0NSOVcxanViVEsw?=
 =?utf-8?B?THprQ0ZndkMzL2MxdGxyU3dvU1Jvd1g0Z2dCdy8rSHAvWW4yNStsTDVtZmJy?=
 =?utf-8?B?SXZQZE9NdUQvV2NGT01kVUlqM1BNVmhNNmI5dXYydjRwQ0JaOHN6dWdEUEp6?=
 =?utf-8?B?ajRsTUR6ZkFjcDIwaS82ais4WVROWkJXU3djdFlGeUR2L0hKaEV2REhid1pq?=
 =?utf-8?B?ZWNpM3FuOG1BYVFQRmpRSzFrcFVISU5TZVpFdTFnODVzZVgrYU5TYWpFejlh?=
 =?utf-8?B?enRtL2NTODg2Z1BIRTdpNHR3VmVEU05LMUNpeENEd1g3emNpVEpSb3pmb3NJ?=
 =?utf-8?B?Yldma2xrenJMQkVnMWZaYkpGWmwrc2FqdWI0TVhJUzA3K1llS2VCMG9hb0Ry?=
 =?utf-8?B?dG1oU2p3ZmVUMTZyaWNUZ1hwRzNSUnU1b0tOYXRCbHdub29CeVFnK2MyTDUx?=
 =?utf-8?B?RW5Fb0hKZnJpNjJTYit2UFJMSEEvY0QxQ3pXR3d6RThBR3VhVnkzMmt2dG9Q?=
 =?utf-8?B?VlpKNWJVam1rVWl6M0dTWTljT1F6ZUozVGsxeHowSllJK202enMwaU9UZWFQ?=
 =?utf-8?B?UnRISkVxV2krV0pHL0pWaUVpVERoNmR5T09IR3gvMGthd3hnNjE3a3hpZ3dv?=
 =?utf-8?B?cUJaSjY3SVZtcUF4WEQwNWxVd2tiaFBFcG9qUTdXYUNXb1lQQSt6VElsdGth?=
 =?utf-8?B?TlN6c1F1d0QzRlYyTkFRS2UxV3dYa1d6cTVRaktJRFhUSEtiTXhDazZJUHVL?=
 =?utf-8?B?UXJEUkg5aTlqb0w3MDJZakIwMlR1QmM3bnlma2hKSkFGeWlYVzVtbG1uS2Vk?=
 =?utf-8?B?eXRmVnI4Tkl4U0xCdXQ0K2FXY3VMby9wUEtnNXdIN3YzWVJxa0pkdm9ZWExH?=
 =?utf-8?B?NTZadXhGZmwyRVEvdlB3T2l3aVVMZDhjaEJ4dlVQZDVuVWUvSStuaEhkNlE3?=
 =?utf-8?B?dC96OGRQSDJweTFlMTlyT2tldGZQeTdBR2VFMWk2VUMvMDFpUGwvVktKVUoy?=
 =?utf-8?B?Y0dBc1haTlhCck5OZHEvbVlDV0lZU0J4S2NxQTZRT1dvb3JlbWNwdEtkNlgw?=
 =?utf-8?B?SWxPWlFxVUc0UTJxYkljWGl3alZZUDU4VXEzelBUdDJkY3VLV04vMXhEZ3lu?=
 =?utf-8?B?TzZqL0srYU5MQmxVZzh6b3M5eTNGUlhSdE5YbS9tS1lCZm45SzlPTk9YZzJ6?=
 =?utf-8?B?ZmJST052b29zMU5hczYrMm9oYlJMeDV3V1ZRM2crUWdYRHlOajB6MHhMeXo2?=
 =?utf-8?B?b2dJY0pJRXRRRjNTdDdVU0JHNWlTeS9ldUVjS3Z6cmFqdFNvbXovMVdSWktN?=
 =?utf-8?B?ekxkNG1HUS9DSHM2VWNGVCtkV0RYUFFsNVBYdGdBOFFKbzlleWxnRFlGaUJm?=
 =?utf-8?B?T2FRRktUOHVnMHNRMFVmRERhMWJ4RTZaazMvMGZ3M1pyWFhobGJMZXlrbGZ4?=
 =?utf-8?B?Mm5zdE1XazlsZml3dm9QWS9QM01ENUh1N2dGU2lpV0dJd0hKeldScjBqaXZX?=
 =?utf-8?Q?wWK/lDZS/5QE8dp3Z/4nk2UjT7HcjJVC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?LzJNMi80R3hBSWloZXVrcWZNU0g3a3RVNmg5RmR3RFIyOFRqd2ZZakZzWjk4?=
 =?utf-8?B?U1pQNWZONzJNSkN3TVgxU1JUMUplWDR6Z0YvSEF1ZDFVU3IzK1FlMUVOa01v?=
 =?utf-8?B?aEtrbTYxaklsaVpFYU9yZDhlSC9ubmdvbEdiWGx0K0hrK21JaU1YdFd6QU92?=
 =?utf-8?B?NmlDM2RUaUpsWUswVG5KMFB3WTIxMENEWENEWkxDNlpCdHR4S01NTWlsNDZp?=
 =?utf-8?B?c3JJOEZzdzhmTXY5bkd0YnhSZnZMVkhNMm80bjJVZUpoVW9iOHlMNVdHRWVD?=
 =?utf-8?B?UjRtVUh1d056ZzFWVitnbkV1MDFmdHBKbXIxazB3d0lhenRzUnhSUDdpbG5P?=
 =?utf-8?B?bFdZV0Vwdmd2M2Rab3lCbWp2UXVhMVpVeVZCdzI1RjhQUFNmVHI4WmZLcncx?=
 =?utf-8?B?Q0hUb2oyTEhqTEFLaUVUR2lxZG1hNW1NRkV6ZFVMeTVaQ2ovcllXeDVWMnM4?=
 =?utf-8?B?d3VzK05jN08zZE9WengxVVlPVnI2UW5rM0lxMmlWQmFaTmJOR1BMWDFZTElJ?=
 =?utf-8?B?RlRmTFM3N3ZHU2c3ZDRVWFlhOWF4eks5WUxGTVNSRE5wVkExd2JNVnRKWUNy?=
 =?utf-8?B?VmpWeVpnald3SVN1U3RRRVlhMjlKTkF2SGc3b3FLc0VkU1dNZXJpTnl3cm9C?=
 =?utf-8?B?VGcyV29hN1pnVW9JcWFYcHdJUHFJdVlPeHl0QjVLZmtKZm51WmJmNVY5eXMr?=
 =?utf-8?B?Z000WERVVDhTbk1jUzdGL01nSkUvU09wcDJObFc5WGdiL2htU2d1OFczOTAr?=
 =?utf-8?B?S2E4ZEJsaWQvMXdybnQrYXlhalduYm9DZnVvK1RFS2RpUHhUVHRxenFtd3Fn?=
 =?utf-8?B?MzBGRWZlYWUzY1JLOGFhemlyWFhMQ2lqU2FVYlBHcGpnUkxuZkdaZTNBZU5p?=
 =?utf-8?B?cE5qUVJLWVd3Yno0N0FXV2luaS9sU0xlYU1RdlFyYTJCWGJDbXhQdlJ6L01w?=
 =?utf-8?B?Vjlpb0ovQ1MySFV2U3lCZGxtQmJtUmQ1TS9zejdCQitycnY4bzhyWVM4NnRq?=
 =?utf-8?B?N1NNbURURVRNcS9RT0NNbDVLdGM1VWFER3NIWGsrN3V0UlVCcEhyN28xWHA0?=
 =?utf-8?B?SzM0ZEwza0xTNktwNEVzT1BXUlhwb1VNYjBMZTNnK2h5dm1aWFVTUEE0NmZ4?=
 =?utf-8?B?MGM5NWZ1OHFBNTl4Y2JZbG1LclFqYVNNckc0WExzQ2FyNFpDbU92Um8yWjlQ?=
 =?utf-8?B?N2VBVENFTGRJek9MM2FYYW1mTW95OG50Sk80QmFxQmhDTm9zVlRhNU00aE9Y?=
 =?utf-8?B?aGJtZFNXSGRpQ2IvNlNnR2xpS1VueExyQnhua04zdjMzc2J4dVczUlF1Z0lN?=
 =?utf-8?B?ZCt4TDNlb0ZKaHVpYlA3VzNyNE9WRHZDSjFoSTVoTEk5Q1lhSXdkSzlYK1Jx?=
 =?utf-8?B?RWxtdnZTZ29qVmxSNUd4VzlWYjlrNW1xVzdZVm5SZWxVNjhjOEF6VVdyaXpy?=
 =?utf-8?B?dlFYY21wYzFQM240OFdJUHVDOGRvZ1BWSzZDbjVQT1pyVHE4dHhSdktSZmEy?=
 =?utf-8?B?ZWp6VXIzUzJUYTVNRXdvQU4xQTBKb1FOWDZpV09JUWNsTzJvZjlaRTBnSDJJ?=
 =?utf-8?B?NTBtOUxiM2V1TWxXdmpmd2xwTU9FRTc2ZkZwdFJ6VjlQWXFrRGNsajgzdXZP?=
 =?utf-8?B?a3hNdFEvbGhYb3N0Z3VZOXZ1dEtJWFpQbzlValNUalJVL3dVQm40SmNpa2Uw?=
 =?utf-8?B?ek82QURFNlJEZTlKNXFvcEpDVHRjTlUyQnNnT0tqOVdzbHVoZjVGWkhJdFZJ?=
 =?utf-8?B?NUJCdHdjZ05McDZhYXJ0NGZ3REt1b3hRNW0rM1pCQ1FyNXVuUDJyVFNEK2Zv?=
 =?utf-8?B?c0ROcllMZ29LTVlJbHZNeVNMYnJmTUVWWVFEZXA5VmxhcXpSZXRLWnJUbW53?=
 =?utf-8?B?aEJYM0lmTFBZY0t3b0NWcldROENLQ2YvRXpIcmlSNEV2VFk0TVM0OFFGZUdz?=
 =?utf-8?B?N3cvaE53L3c1c1Z0SFJZbEhKc2dUWnowcW10U1pJN0NRSUFDaGl4WnVOSGdu?=
 =?utf-8?B?TWN3bWU0REUraW9Jd01EcXB1WERBUGRIZTRKSC9wKzVjZ1l4emdENGxBZ3lz?=
 =?utf-8?B?Z2RITmUrWGliRk9JQU5UQjJBRjRpQnJNUENkYUM2YUFIam04bk5RWSttc3l6?=
 =?utf-8?Q?PQartxB12cWMZGlipGcB60OVw?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c867330b-8e8b-470f-751c-08de0f2d878f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2025 16:35:36.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r1xGUC1CXIU/DzjALiNI9MGQyNVj19zXsLH8n6b/58VWbI5mpdogGl0LJJX09/e/FWXzorbH5J6rJdsUFWr8fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3256
X-Rspamd-Queue-Id: 406204186A
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[52.101.83.10:from];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.83.10:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[siemens.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 7U666Z7SPDHFL74NJHEVHOCJ6ND5JMMA
X-Message-ID-Hash: 7U666Z7SPDHFL74NJHEVHOCJ6ND5JMMA
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, cip-dev <cip-dev@lists.cip-project.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7U666Z7SPDHFL74NJHEVHOCJ6ND5JMMA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

On 27.08.25 07:55, Jan Kiszka via OP-TEE wrote:
>>> On 24.08.25 09:18, Jan Kiszka wrote:
>>>> This closes an old gap in system integration testing for the very
>>>> complex ARM firmware stacks by adding fairly advanced Replay Protected
>>>> Memory Block (RPMB) emulation to the eMMC device model. Key programming
>>>> and message authentication are working, so is the write counter. Known
>>>> users are happy with the result. What is missing, but not only for RPMB-
>>>> related registers, is state persistence across QEMU restarts. This is OK
>>>> at this stage for most test scenarios, though, and could still be added
>>>> later on.
>>>>
>>>> What can already be done with it is demonstrated in the WIP branch of
>>>> isar-cip-core at [1]: TF-A + OP-TEE + StandaloneMM TA + fTPM TA, used by
>>>> U-Boot and Linux for UEFI variable storage and TPM scenarios. If you
>>>> want to try: build qemu-arm64 target for trixie with 6.12-cip *head*
>>>> kernel, enable secure boot and disk encryption, then run
>>>>
>>>> $ QEMU_PATH=/path/to/qemu-build/ ./start-qemu.sh
>>>>
>>>> Deploy snakeoil keys into PK, KEK and db after first boot to enable
>>>> secure booting:
>>>>
>>>> root@demo:~# cert-to-efi-sig-list PkKek-1-snakeoil.pem PK.esl
>>>> root@demo:~# sign-efi-sig-list -k PkKek-1-snakeoil.key -c PkKek-1-snakeoil.pem PK PK.esl PK.auth
>>>> root@demo:~# efi-updatevar -f PK.auth db
>>>> root@demo:~# efi-updatevar -f PK.auth KEK
>>>> root@demo:~# efi-updatevar -f PK.auth PK
>>>>
>>>> Note that emulation is a bit slow in general, and specifically the
>>>> partition encryption on first boot is taking 20 min. - we should
>>>> probably reduce its size or understand if there is still something to
>>>> optimize.
>>
>> Can you try with KVM enabled? I suppose that should allow you to use
>> Armv8 CPU Crypto Extensions.
> 
> Worth a try - will pull out some raspi or so and let you know.
> 

I finally found the time to set everything up - just to get this:

qemu-system-aarch64: mach-virt: KVM does not support providing Security
extensions (TrustZone) to the guest CPU

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
