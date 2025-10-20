Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E956CCD199
	for <op-tee@archiver.kernel.org>; Mon, 20 Oct 2025 10:05:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9F552418FB
	for <op-tee@archiver.kernel.org>; Mon, 20 Oct 2025 10:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1760954707;
	bh=zpRvRum3gnFu6/YYRyQwDnWDg4qax7HA2LgB36978NU=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=Vo+MdaIrUPDqAzbtAM/VdZE2haB3AVqFGzjeIbw/sYOf3qJRYYSacskaAW3oeZRhI
	 O8pAUiJuuQcvFw9ydF13fO8LxO1zOrlROPaIbxV6p4KVOaGfLyGVufwj90tpRmWvfP
	 P7ZXhvHhZu7pk4dsnpsJGqfj+2bOR/aWFTBUicbhDu1dyl8+hNAHU+S9289ZIhpB2F
	 E/79Vh3ZVe3+Ee0gLwl5t68kFOtSwqALQw4cK8WglEO0b3brW+RMlUckiGe+EQZfxa
	 zFNKcpW2uEr4YWF6h5BTfm8fHwoP1MCVJ4lcEs64FCCcwxJRLnS54i2hBHZi1bdFfp
	 gV0XB0o1kxaHA==
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 111AA418FB
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Oct 2025 10:03:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=0Djb0EdB;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNhuZ810Gg0iw7TPVH3woGfRyBetiqYZgsOlupZi5s9oLQwWIQN7fGgtA4HS4l6Uo/u4pSlh6arIyMl8F0Nj98QrhguXXvYstUnVsr2Eio2t1qR4TKFP4F91rcesfzOKxfhPXNktw9Lvt6UkrXu0l2YPh0w38bnGwfk/E+hHyE8Gt/OroIseWE3ECi4TkTfoTEXEuq7Ecv2OW/SzkebU+YU5FiQbEI+vfyLBkfPsoV4q0N9TrGKyPNj0zuXP/DYwsOn8zL3RGTso06ILCotKYmrp+2WKA7rkkxY6PmIdVLULCMCfzxUVCAAemOO1D16ja3D/X8PGEOMkh9JD8AlJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bCKxwMAoTjkr4WaQaabA9KBD5+ydkHURYBcgUeOJuQ=;
 b=s4UNXD0vSYZ5IhisseHMY8EDysu+KtmVZaTH/hslyv6cgimPTACer+irbTJwZmvr3+3rcL+x4SkrZPS2PQWcDfu/4ZKxCr+BEdARcGpYeTz0ai3RDvQvJgPGwZAy7mAOn7t1ImGB+BmYGdPWt4Dtnf3LN1vModblDiaPcqpl0goNpad5usTDFlzn8bJzJW8oJqohA+FCwuC6o5uNqb/71ft5GucZ427JlQtL33wukikf7aqlxpxQlw2cdoHXhpVG61Tf3eC3KNa6na80AoBJqQ+oYyLJgp+/eKUxy9K+WoDEAMeWxpyuQgSkOY26lEPMaLWbX2HKpn1MCeZxRaWkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bCKxwMAoTjkr4WaQaabA9KBD5+ydkHURYBcgUeOJuQ=;
 b=0Djb0EdBlzxPRqhs2IZNVbdAx6JwtPKL9Xb4H92YvfU89/cDp7C2UGCfXKfdODBOEt1XnNC4f2DgfE5OtOM8iJBQAzva9OQJnnTV1HI0lbxh52ZHyhcioO/RgsAbnmK1ZCyfdItn878fSR+rxKJGyHgyfLtTeFdwNyaq9jZFGQV1N5DYQRZ73a5XjtUE6AP1NO6rEV/xyy2Pu3CUMDV/Cq7vpTjbvyzn/dViqJzUMyNZQtKl9kohOOKYOAMkMFIDzHApVRgKQY/E5SvLbF+LKIBTmBubWGcVZrT1bLfVFqfT94/4b5YDmUPa9CkpRtTISqouZYrU9JbmsgUP8+xnVg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 10:03:07 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 10:03:06 +0000
Message-ID: <1b6b2738-9813-4d22-9ad3-cb3b5d6a1509@siemens.com>
Date: Mon, 20 Oct 2025 12:03:05 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH] core: Relax StMM dependency to TEE_STORAGE_PRIVATE
Content-Language: en-US
To: Joakim Bech <joakim.bech@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee7859b-0f5e-41ed-3e29-08de0fbfddcc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eXVETWZ5eEE1N3BESWNpUzZoRGxIUEYrN0ZseWMyVXZ2WkdwcjE2R1ZZRzRB?=
 =?utf-8?B?K3FsQkMrOEd6WGZrZG85dnlkZTlpS3U5aVNvejVqSXVHVUxPdmYwSG5JRXVT?=
 =?utf-8?B?YWQzTXpncG0weXRubGhJMHNBK2tZc2pxekFwaVlycXp1RWtHMlJ2Z3dPdnhD?=
 =?utf-8?B?dEhCc3R6RDNTV3NoZFEwVkFWNDEraHM4TVpaR3pFRzhSZEl0TzN4ZllZUmM1?=
 =?utf-8?B?TkJYMEVUKzZhR2g5eHA1L3RaRlgyUUVwMm1Ic29nZ01qK1hmdm9XTktkTmY0?=
 =?utf-8?B?YThZNk1Wd1BHL0pzdzIwUzJrR3hxakRCTEc0MVhSL1JCSWtxRlN6WWFIaXdT?=
 =?utf-8?B?RHRWNjh4MkVkdVNEb0RpWHgvdDRSZFgvRE00NEh4aTJxRUVJVlBwQlpoZEJC?=
 =?utf-8?B?cW1jUTliMlNvMGxWaXlVTXJvdjJNdUh6SkZHOWpsS0tQTlVXbHQ1dEMvcWZE?=
 =?utf-8?B?YVFtajgrVnFKb2JCVU1yem94ZGFsM3dDUGtlUFFCVnJiMlA0aHJJZWptbjJa?=
 =?utf-8?B?dU1VV214Q1BpdFltR0c3T0UvS2hrd1llczJqRWJhaHBkckhLbHd0U1cxSUY3?=
 =?utf-8?B?Q2ExVkwwdUtUUXlLaXlJeVFqRDJyUUVJS2Y2em5QcnNrdFVNQWRWYnRycnBU?=
 =?utf-8?B?UUZZWVJDQ0xpVWJ4MGZ0WmpCQzFDWjVkNlFrbFJIelBoMVhvUHVtUkovRXN6?=
 =?utf-8?B?UGw3VjJZbkJDTTNQY1dIU0tFZkJENVozcDdSeis2SFVrY0lHaElyb2k5RDJO?=
 =?utf-8?B?eVF3ellGR292K0hqei9JUUpoVzN4ZVFzMFhDa2dxY3h4NHMvMjg1VlNrTW9v?=
 =?utf-8?B?bzRxUFlZanpCM1VNdUhraElMbWZSTDZVWWZZSWpGc0I2Nmo3TUdtQk5sdEhx?=
 =?utf-8?B?R0dZWExsOHBZVDhLZlptUW96UGtMalRiZ0xNRU5iZWwrWVdEcm5MM3IrTGMr?=
 =?utf-8?B?eEhCclV4OHJXTnFjS0ZERlR6ZnlPdVo1TVZwR3lzVlNKT1ZaODZnSHBDSU1l?=
 =?utf-8?B?ek9WZzVYa1phd2RuN3B5ZnpCSXVaL2JxVkFoZVlQa1pBVCtmNldIZVJrckVC?=
 =?utf-8?B?Q0tLdkMvU1g5cEQ5QWQ3bkRGSVlmT1hzck1ROU4zNHpGOVMrSmVPTVpicXpy?=
 =?utf-8?B?cHcrUi9HQlVaKzlGWTF5V215V0Njdk9keE5pSHY0YThYYkU5VUxnbkdmYzRT?=
 =?utf-8?B?RHJ4MEJuaytkZU8vcWR3dW5ob3RrMzBCbmtMZ2sxWStJVVFtbk1pc29EbTBZ?=
 =?utf-8?B?SUdJbW5DVkhXZWpsZmNkOW9PZnk1MWpSblVaZkRaWUJhUzNJb2ZBQnBzejJZ?=
 =?utf-8?B?MHluajZOdnVlQitQTUd2dStYeE51REc0a1pIczgrZVNEN1JFSWZTT2lDVWxQ?=
 =?utf-8?B?Rm1FWThPM0dYTEdRdUxjcGs4c3R0Y3NvTERVR3pkRjRxckFicmdjSzkzWmNQ?=
 =?utf-8?B?dzZRT08rUWpOdUpNUDJDZEtlSDRic2Q2UzNmanRPU3JJQXZwR3NWNTY0cmxw?=
 =?utf-8?B?c3NHYStlZVFGbWFGQVJKL0RrTVUvU2Fvc1RYNzV3SlU2RTByWERMajQ5ZmJi?=
 =?utf-8?B?bUpoalVheXVNcmxuVTZnSHFOTisvLzR0akEzeXpYNmJ6c29rMXdMSkhvUnlS?=
 =?utf-8?B?SEcwOGV3aEhUVDBXc0o0UldBMXl5NGJieFpSdm1zRVdRVlpLcWs4eGlNVDVq?=
 =?utf-8?B?VGR4M2JTeDJLcjdRUGo1UUpaakFTY1UzaCtVZnZxeld1dUttNXVIaVhXUFdh?=
 =?utf-8?B?bm1ZTzFmeThvaVFLdCtYQXNZbnlsc09Za3VxaGgyc2xOT2ZRQzdrckc5UGFy?=
 =?utf-8?B?cmZiWC84K2lwaHc0bmpCck5Hd1k1aEVraDk3Vno3cDQvd0ZzcTd6ajZUVG4x?=
 =?utf-8?B?c2loeFBMNWdldVQ1dDFDbmNNdUltREc3YXl4d1RjYnV2WjZCK3Y4T3ZYTkEr?=
 =?utf-8?Q?qSXCeJKtAbfZVhyFCault3SyH8OverXF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TEE4KzFsa285ZCtWSkpUdktoWjdQdmZpNDFobENCdkovS0psVW56amN2Uys3?=
 =?utf-8?B?ODJoSVBjUTJ1bkMyc28wckFFSUExWm1BTms5UkZRcGlFNFNxWEZGMmUybm80?=
 =?utf-8?B?SDMxekJDNmIrQ3Z5Z3puVHJZUEZEY2c1NjMwZzMza1dCMHJPSi9tSWRHM1p4?=
 =?utf-8?B?MFU5S1VISlZmWmdCRXJyUXhGRjBNbjdiVHV1Y3BFUVViL2NqV3BZdFNndWtl?=
 =?utf-8?B?N1F2Y3ZJOE9YYWNEazhGb0ZKbktDbkZsRHRHdndrTVRqNXluQy9vRFlGZUg0?=
 =?utf-8?B?RlRVa05xVnJLM05OSFFNNFJ4YXZzaE43QkpGYUxzTzQ0dk9rWkVzSFpEbU1w?=
 =?utf-8?B?b3pTVmRyd0FOQWljbTJtdGxDT1dMRjlFQ0NRRXNJVlMzM29rKzVKZWlrWmFo?=
 =?utf-8?B?UkRQbmJUd1dqWjRHL1hyaEVJUEo1cjFzMUpVaHZFbWFlOW1iTXhMajNyQUIx?=
 =?utf-8?B?S2Q2ZkJ3TFpKL3ZnTVNYWTAvcksxaGNjb0RpWmhaelV4NzFGREkzcHBhTndk?=
 =?utf-8?B?eWllWGZkRG1HcFZRYXU5WmR3VDFtZmJUN0ZsYnRPd0VJVzNRMjlGYmNiQTdM?=
 =?utf-8?B?a1dCWTVHVEI4ZWpmVFBBZndialdmdG9EMWhwRi9zdGVLdWxlOG9tbEtXSCty?=
 =?utf-8?B?K0VtbkV3MWhqaGs0c1RweStxSlVNcmNrTS9uZFA4b0s1aWZIaEJXcUhEU3J2?=
 =?utf-8?B?bnU0a0xCb0thaDE3US9YbHNCMUxIbWhpbmFmeXBtbGY0VUN2ZXNFY01pSkcr?=
 =?utf-8?B?Um0zMm1vMTZNVmNoWlAyRGUreHRTbzlCSURnQmFGdTNZejViU2pQaDBEOXBj?=
 =?utf-8?B?QVUyMXhKV1dqTEszb21aUlN0SEhzS2pLQVZtSGN3YjNxdHBObngzRDVnb3oz?=
 =?utf-8?B?OHFGb0JrMDd5WGorZFoxV01WR0tISXZHd0NFNzQ1SFArSVNFZTRPSml3SW12?=
 =?utf-8?B?SW94bFlsblM2bnhVUFZxejFKUkV5V0FPUnFraUFYbGVIWjVDamRieWI3U2VM?=
 =?utf-8?B?akM1UlNqY0lubDI0K2ZqTE1MRUg3N3BRcTk3OVVMWDBOaHFtMW1qcXVObnJC?=
 =?utf-8?B?QW94Qm5xRXlacEVaK2ZDZXhENXppZHZqZDEvZGFCbjRsaEZZZlh6MFByZlI2?=
 =?utf-8?B?VmtjN2oyc1lXU2hQYTdHOEV4NDNWdnZ6ZENHRG9ibk04eEdBN1B6Y1ZCMS91?=
 =?utf-8?B?bXpUbXJwa1NScFV1VS95aVhjRUhMdDdpQWQwcnRNYlJwNGNqbVltRE1GK2lV?=
 =?utf-8?B?aG5UQUNhYzNYbDJTYzV4aVdoSkZ5eGh0bmlxZTFKYjk2K2RERUJjWmh2TnZE?=
 =?utf-8?B?Sm90SUtDc3pvSW43eTJVUWR4Y2VoZnU4MWsvV0N0VWMvaGQ0MHgxa05PcW5q?=
 =?utf-8?B?ZytFbC9ReXBWWVN4bTJtZ2RnVXhxRSt5K3czYlYzNFRwd0dmY05sdExsaS9p?=
 =?utf-8?B?QUhVQ1JuWFIrcCszM3I1ZkNLYnl5TSsxWHdQSituc3BDYlphQjJmeFNWSWpa?=
 =?utf-8?B?eWZJU25adjZRSTFqYjVXaTh0UEhKVklvaTVDSnl5cUgvZ0xQYXhubjFZcVNx?=
 =?utf-8?B?Nzh5SmpVcWJRNTcweGpnRmtwOWx1YlF6MkZ3UEZXNVJoaWpKVk9GYmdwVGdk?=
 =?utf-8?B?eFpJdjhDV1FIM1lXQWp5NkJFeU90NG5vZEVxUjJHWGpMMW9KVSs0VmxGcjNC?=
 =?utf-8?B?Nnp2MXhPVzgvSW1jLzFudEFDL1FOemg0MWVzRGFPSU1vbXlvWktJYXY1YXN2?=
 =?utf-8?B?SXJvZ0NxdWNDcmJ0Z1NoMnM1ZUVhRmcrY3hjV3lRY3Y3RXZUcEFZMkxaakhh?=
 =?utf-8?B?VnlPL0M5TXVYNmxta0NPZG5lOTY1QS9hQldhWGdMVk15NEJUUjVtcUdHblBs?=
 =?utf-8?B?bmphTUQzMWowdHJBYVVSWW51SXRrbTRLcXBUb2FvYllDRFFPbGpsTlhaZDNa?=
 =?utf-8?B?Rk9DTml3WWlSZzkvVjQ3eDdvM3pzdm1HTmZQSUdtRXhUTWs1MndZSUVFQnNC?=
 =?utf-8?B?ZGZPZzB1MUw0cTcwZ28wVzR3aXl0WU41bU5rYjV0MWdqNUdDWHNia2RYd3Vl?=
 =?utf-8?B?NHdKdTdjTTRFUE9KZDVJVUQwcXlMMXlFd29PeHA2ZVA4NWw2WjBUUGtsaHRK?=
 =?utf-8?B?ZTdDRzlnNk5sSWhjYVFYdU95WlYyL1AySzRCMDc1WDVXZzJQN3VHTkNXVDVZ?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee7859b-0f5e-41ed-3e29-08de0fbfddcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:03:06.9170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymK6au+yQVdWrm59BE8BdqyTgvA0Y4OAd0of9CCuGvBVo6ebs7FwgKzkVzks3QOL54PMxNgD3y4Ps7HbS2xAew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6372
X-Rspamd-Queue-Id: 111AA418FB
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.6:from];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: MR3EZ4TWQ4KJLHXOLRYTL6TEWZITINHG
X-Message-ID-Hash: MR3EZ4TWQ4KJLHXOLRYTL6TEWZITINHG
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MR3EZ4TWQ4KJLHXOLRYTL6TEWZITINHG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows to run StMM without the userspace supplicant if the
in-kernel RPMB service is available.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 core/pta/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/core/pta/device.c b/core/pta/device.c
index 39ad3ddda..21c13bd94 100644
--- a/core/pta/device.c
+++ b/core/pta/device.c
@@ -67,8 +67,8 @@ static TEE_Result get_devices(uint32_t types,
 		add_ta(ta->flags, &ta->uuid, buf, blen, &pos, rflags);
 
 	if (stmm_get_uuid())
-		add_ta(TA_FLAG_DEVICE_ENUM_SUPP, stmm_get_uuid(), buf, blen,
-		       &pos, rflags);
+		add_ta(TA_FLAG_DEVICE_ENUM_TEE_STORAGE_PRIVATE,
+		       stmm_get_uuid(), buf, blen, &pos, rflags);
 
 	if (IS_ENABLED(CFG_EARLY_TA))
 		for_each_early_ta(eta)
-- 
2.51.0
