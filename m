Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C53CCCD1BE
	for <op-tee@archiver.kernel.org>; Wed, 22 Oct 2025 05:05:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9498F4FF62
	for <op-tee@archiver.kernel.org>; Wed, 22 Oct 2025 05:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1761109530;
	bh=fCfdauA/9LCwEf0Z6wJQq/tryffJHyhaCkNCqdf7JHQ=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Dt2YvlwTBZx5wQKTesYaAGsgrJsZE1VkZXke9k5aelJPOX6Cp63k8S93mvtdh6aIM
	 LgfNraPeh9oGMSUOD8eS4EXCwrykfKfkCc451d7A+W26BFQ9pY7jzR/yxXVVEOuYBx
	 5Dmf25OX1yeYL4UnSUdPzLvL0/cPlzxXabBj+kWEJn062I3C2Vmfko+ET8mV/cPNrm
	 s/No6+4iL2mwXu+RC/4flXTSIACWW6bj9Gc+UkX2J4BQn8GTBnvqaQsm9o+F35YkRv
	 WPRKjUTKz/vgU9jHOQT74H7DkzsDrNml7SLQib9AuDZ5RoLv0xCPUTWVPaT1E7rhfZ
	 HSJ2QHZGiZBSQ==
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7777B4187C
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Oct 2025 05:05:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ERjRO9qD;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlIb5q3X2GfLWzRU2PZpIJhT9rZSJ7FHeseOMpHJ9CSJflGJRK4GAbZRPMiGP68xJtVufdfgfTso5xXSBG+uvQUMOavZ6Oao5xvdj6v/jxMZol2pSL5YVQrq0/7STPPJONtSgowy0IQEmaqMJxeIq5APvtsVSahY6c7trnJMHGnwiNy3ugWKHB0Bp5/n/0EEwyFNfKUr1PwkZhM6Fsug6wZRFqMZwatIyZUXNuQlfSeJL2hW1C1TVeznQUlBdqsJ1kSqABg8Bgo9nSROAWMTNoSTbS8DB1pTQF5a0A4qwXU2h0GrhqOOFM2u9zIGsHVRQVJYiRP7wwj5QOsevF5GvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouyCN9OoH6iw/C1GvnFUar2u9OYlbKMPaAfhgbN1RCA=;
 b=KBVmXGhmnhaCY2vrtjX7xLpz5S8caGCT9ProOQh7D3hSPRvJH6o0N7c/7OkGhC2+crnOlI73OCO1iR/gm0pyFVtx7ig4maOEJQo7wC+BMeqigoP2anGT73Fygb2g22h7Bg0U+28G8IMT5sop/pnXW94UMVNo0gopzZKXb81MKfNaeokQ5miPsXzEUilIrPZMmSFgVqvC75eiVcsCxlaHpM0IDWBB6/6lEMSXOqdhqN4kGAs4II0Bqc94m8mzp1Hqi5QnC+pJQSgcrGNBoP+2tVf6vZR7BPUTvmiwEE4NRcrGAr47SseBejJp6L/MWkrHpJyT8f9mx4bJwsqS5hZW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouyCN9OoH6iw/C1GvnFUar2u9OYlbKMPaAfhgbN1RCA=;
 b=ERjRO9qD5ILy4jh0Sls7fJMiMVZqWXl99OUSotlKeoHfKgGpWgBZdD+8yO4Ga5x0GhG4CJyMe/lP8HQD2IBCDEDdEZdnz6l8d0VopNdi9Qr7tzcc9u7tOIQnDI5A04uoGCqcz8xyKGTNQV7eFDw8sC8p3zuevbtyPIrxeNkNjuFEwKBZSNY5Di6HxVyKjsPrpvWnUZ1M1AgDLD0WQmfspy039jW/ztwwSoAauxwJBirzXvW6aVAj9XJcmYVl3nzT8Mr8+1ggiSNJlJWtxV158XFWcjwIsQhq+yiS19LOJ5gIyl52upJoRxjYGI61Vtu8lnM5diJyMm78c13fPwKKHA==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:339::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 05:05:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 05:05:18 +0000
Message-ID: <5539d518-5216-4730-a2ab-3c59d98d0229@siemens.com>
Date: Wed, 22 Oct 2025 07:05:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 linux-integrity@vger.kernel.org
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <212818188b192db3b852ec69fde174fd887eafac.camel@HansenPartnership.com>
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
In-Reply-To: <212818188b192db3b852ec69fde174fd887eafac.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: faf5405c-9231-4456-0e88-08de1128980c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U2hJVXlReFBCNzF6WFNzb0poUHJXSDQxL2JiMUFTYkNzT2k0K0diV2xlS202?=
 =?utf-8?B?bk9pYUp4VVdOSG1na05pN09QQjFVSTM2bkFSVnEybDUzSzJBL2s1WFd3dVVi?=
 =?utf-8?B?ajZGbUN2UXJ1ZlJkR1FDZlQwZWJ5YTd0SDZ6NXZPRXBkSHVMbmFFSmt6OHcr?=
 =?utf-8?B?Tmx3ZUk1M2hTQnlSSHR0L1dkUGlJT3NQT3cwajZNZVlhTll4aHIvd3hoMGEz?=
 =?utf-8?B?SUtlU2hVM0d5NmY3OXY5OXB1a3hKeDltVWE5UWg1bExxeEFzN0pRa3pxTXVj?=
 =?utf-8?B?T2hOeXBnWkxhWFMvb04wRmlwTCtFUUpvZERTdmN1bWxqdjMrbU9XV3llaTlC?=
 =?utf-8?B?YkpOcWJBc09veVE1cEJ2aXllVmZUUkREY1VPaGIxZjh1M3VnQzBwb3NrUTV0?=
 =?utf-8?B?YUJJUklDQ0VmSkN0NXhIUWlrL0hCSTN6eEpzTVdWYzRIaXdsaGsxYmZpSXZJ?=
 =?utf-8?B?bWFlaDIzS0pPR0NleVExT0d3QW85Q0VYQzlKM0M5VjJIWVgzdk9uMGZBRTMy?=
 =?utf-8?B?L3V1YVpPQnhBMGJPaURMM3pKYkxlV2QvaThGMEdjQjQ1OHRqSml0VlJUbVBY?=
 =?utf-8?B?SzhSOGxzUXZQVnF5NG5FeUNqVDFnNU5sd0pRTnREZDNYMXpaVytPNTVYVlg2?=
 =?utf-8?B?REtTdk1nWjRtM2ttMFFadG02L3VjSGtjRnZXZzNaWmJFQ1R1c3ZsdnBDS3d6?=
 =?utf-8?B?ZzBnN28rNUhPSzdEd1B4WTQxa21yUWpNNG1sQ1pZazZGMWNsU0ZiQnZIbzJS?=
 =?utf-8?B?S3pPYytDY2xDZ3ZSY3Y4Nm9qYnY2SzQ3bEEzNXBkMjZiK00walNuZ3hTc2Jy?=
 =?utf-8?B?L0VNY21aVVhjZnRhb1l4VDBVTFEza01pTkQ0V1d2R1VhcGNDU0lVN2hPMEJs?=
 =?utf-8?B?WG9OUnA2aHBvd2xvUllMdTJKb2N2eDE3aXBZTWdwMEJaOUNmazRyU1pSRm5G?=
 =?utf-8?B?OXRtOXNWdVlFbkcxR1BrVTU3VXUwVjRNQ09hWklVT3dNK1Bwa0llVlBTRldZ?=
 =?utf-8?B?TGdrdnkxK1VSeDhBQm02dzZ6eVRJOFFHWEtRQ0tCWDNpcUd2MXF6STJzSjc3?=
 =?utf-8?B?bncraEdjbi9LZnRndjdidldyVVlzREluYjRRbXZPRmpPb3NFbnNXOGxnckZC?=
 =?utf-8?B?Ulo5dHRlWHVXWXU4MmorOGlxbEZFbmliWkNHS2kyeXR0dGpzN3JsbThTSk9H?=
 =?utf-8?B?S2F3YWZ5aS80RU91dWthRUNXdVcxdmdFRWd6L3JJcU9xZ2ZaeWZUUlAzUlR6?=
 =?utf-8?B?ektVWXlWTjQvekFXZWFZWlBpOGEzeE9ESy9ONk43Ly9ITktaTkovbzdBUkt5?=
 =?utf-8?B?NENYazBMN3RmR2NVaEhTNWRmSE1zVFZCSGNVZ0o2NHZSNlNNUmZITlloUDU0?=
 =?utf-8?B?SFdpYVlsdDVlS3l1UzBwbmZHeHNPeDQ2ZlUrdDZONVVPSTdsVTlzS21taURR?=
 =?utf-8?B?NFZvNjRjWlgzbUNaLy9IK2VEL0FxQy8zOEdndTNidi8wQzlYZ3J3SUIzWVpz?=
 =?utf-8?B?VHplenJ6VTJlaHBEb2JUQW1uemRuNVZRRnBSRVFQL245SEtQblplcEdHZTB6?=
 =?utf-8?B?UEpiQnNzM29lbXA1dmF6N2RPVTJBNXRCUkF0WjVkRi9aQ1pIM1BmVHBQNmxS?=
 =?utf-8?B?NE5CM3JxVllrWVdjTFhoaXluT0NqNGlsSWV2QVBlSmJzSDFvSkgyMWs4S0pn?=
 =?utf-8?B?OFZ2Qy80L1FHclQ5c2gvVXRCYmFSWFB6TVFrSzRzNkJvU1dVMjU5bzhvWi8r?=
 =?utf-8?B?RTNtcFlVSVNrRXhaUVJ1aW9kWjMrSlFhMXZTRlA0U1REMTZmNWhhVVJ3UmRI?=
 =?utf-8?B?WWZPbktVcFFvSmJjeUNBR2t1eHdFNG14UzJ4Y08vM1l0QkZmTm0vZ2dUUFR1?=
 =?utf-8?B?REJid3BQRjRiODZNckU5Z3BQbmxvZTFLV2lkbzRqVVk0MHVBMjkxSFZGYWgr?=
 =?utf-8?B?V1gwM24rM3J6c01qS3o3ck90RnRQaXRjSWp3cUtOdi9CcmxQcUlRY3FGNXhP?=
 =?utf-8?B?OUoxVCtkL2JnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmdrWVAwYVhKSnVRenVqb2JQYVh5cGZZczdqN0tMclNRZzBmaUFJbEVyaWh1?=
 =?utf-8?B?dC9US0VvQ0FHMzl0RzB6M3BVRGtiRVdaNXcvSUNxWTBRcVdDSzhwNjUreVFR?=
 =?utf-8?B?bjFIcU9RMk93V0VhcDRHQlkxd1FSNC9MVjdUL3BRTk4zeUxUTnZMRUNwNUJl?=
 =?utf-8?B?SG1oNjhmY0V3dmY0QjI1L1AzWThwZVhxbzJhKzNHSURmend0TWNrMUJWT0tx?=
 =?utf-8?B?NW00K01GQndCWDZuVW5YSWY3T256WWpQRVZHQ0xDR0pYOGtiK1NiSjVzTStL?=
 =?utf-8?B?Rk51UjhsTlFId1JzN1Q3ZWVsMUtRSFZKTnV5ektHenNFeFNCS2FSMnNXUXcw?=
 =?utf-8?B?YStoSmdIOFhacWhrWHVPZkJjT0xxT0psVitMWGJUVElyUTZoRHVIM0RWTW9H?=
 =?utf-8?B?bVhOR3ZJN2xIZVVQTlgvcExGZmVWR3RaSUFSYTlEZ2l4Q3dDVmplOWVqYnpr?=
 =?utf-8?B?ZGdvRnM4Q3gyMzdVckJ0QTdncHQra25lWUpwNytZRU9xVm5hTFl2ZDUzYmtM?=
 =?utf-8?B?cjBrYnVNNHVuUjBHYVd4WmRiemVnL0lrRTNpWHVEcjdZcGh3dGIvTW1ua21p?=
 =?utf-8?B?NXEzWTBFVjhBSkVmclcxUWUyZS9nMkRlMUxBQ0xQd2dSSnBaQk1kT09tb2Rz?=
 =?utf-8?B?UEVaRnNUZ0tzd01SVUh5cStQSFFaMm5jZnAranZmVExBbUtNV3NEUGJDQVdU?=
 =?utf-8?B?bno4NHc5YmFQdEU0QTY2VGNPOGg5cVp0TFc4OExjL0xSWlptT3UvT2svd0Uz?=
 =?utf-8?B?dTN5L3FxOTM3YTRQWGlxK0g0WXIvWjRreDNkMndrREpTRCtvSFhvVGVVWTcz?=
 =?utf-8?B?UmZibmFJdmJJOVd4L2NiK0Y0RzZPeWtNQmg5QWlSMzZYS0NTRS9lencvUmpo?=
 =?utf-8?B?OGQ0WXpGMnpWb2pKNFUrd3YzU3BmYmhQMGYzQ0wrT3NoQnBpVXBzL1R4eWQw?=
 =?utf-8?B?emdFcTRXbW9VRGNpTVVEUEgxRWwvbVV5Tm1Da2tzL09ST3dreW9vV0szcXc4?=
 =?utf-8?B?T1NPYit6cCtVd1AxbXBwUVU0R0RBU3ZMbWFVeVVIY2lEaHRrVEQwVDYvZDRo?=
 =?utf-8?B?dUZkaUErSVVhSzRVLy9mblRNdXFiTUV2Q0RNa1JkWG9mRE5aclAxakZqM2Jv?=
 =?utf-8?B?cFpIdUxaZGl2UGwxNkZrUHM1dnludU1hVkhHYzJndkUzS3orL3p3akJpN2Rx?=
 =?utf-8?B?Mi9NaUdqNDB2bWo3LzlQa2d6eXA3ckE0SWtFdzVxQWhPK2pVT1oxV0lXSk9K?=
 =?utf-8?B?dEU3K2k0b2M3cm13S0RyNkdCb3JHaUw5Q2U4STBoNk15Y2d2SWtYdi8yckli?=
 =?utf-8?B?ZVZVclVRNVU5M0dySXJqVENjZmd6TC9sTEdGS0JJNGJsV3krbFBKYkNMYlU3?=
 =?utf-8?B?WEc4aEppbEp1RnJjUXpXTnJEM2hpU05xMXZLSEdJeWFWOTV4Sy8xZTBHVzFQ?=
 =?utf-8?B?QTBCa25YMzVvVFc2NEhIeHdpVUVXTEhOMVlvaS9yeFB3UitiWVZ1SmZ2ZGdX?=
 =?utf-8?B?NENOQTZobGgwc0MrTFRhR2Q0Q0V6ZHc1MkNLMUlKV091Uzd4QmtaZ1B5NzRD?=
 =?utf-8?B?RUpLY3JyUHdGNUhIZFFmUGFpZ3VFVzhrRVE3NWVCcDY1VC9Ud0RIc1Z5UUNv?=
 =?utf-8?B?UHhNZFZydzdYZDY5OFBTUm9RcE5oejVvcHllekQzSXhHNE9GT1JxM1hKZVVo?=
 =?utf-8?B?Tmw1V2Vvc2x3K2RaMC9JaW9aWGp6eWtmOGxyUGR4TFlvbDVrbVFIWUhBcDlF?=
 =?utf-8?B?NWswMmFOUnRhSHR6MmM2TVFQT1IyYVdUR0R4VUs4MEgvUncyOUx2NEwvOGdh?=
 =?utf-8?B?MHZTK2xpdDVxdnZLMmVMN3FlYWZhMjlESE4yb1pMZ1hBOUkwTkgxK0RxWGkx?=
 =?utf-8?B?b2dSVU9oYzdML1o2aVVBMmVtMGJtNnhyaWVYZFpmU1hyV2pNVHVTK3dUWmVa?=
 =?utf-8?B?OStBMGU2U0tjUGN0K0tpOTUySDdIa0l3MEpLKzRCclBMNTcxaE9rbU50YlEw?=
 =?utf-8?B?M2RNT3hyemFCazZJb3BYeWxFVGZDK0xUaFBuRDA5dllmMXNiWEhVZiswSDFj?=
 =?utf-8?B?TkR6ajl3Z1dUdGY2RXJPZ1F2N1Q3NVVoRi9aTnhKN3NIQUdmSmhjNEtYOW1Z?=
 =?utf-8?Q?TE3sXPz1aI1jyqUp8vT4XpwC0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf5405c-9231-4456-0e88-08de1128980c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 05:05:18.2732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb60p27i5dAdFsTt8PYIgmdNjYjErtTaxQAZB/QyCMxCT080E6uvTwzvGBTM8x75DGqyv4Jay2xSZo/lMo3Usg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5353
X-Rspamd-Queue-Id: 7777B4187C
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.66.48:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[HansenPartnership.com,gmx.de,kernel.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 7UZBLBQWQ4QGLOAG34ZYB5MWBSANNLKL
X-Message-ID-Hash: 7UZBLBQWQ4QGLOAG34ZYB5MWBSANNLKL
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, linux-crypto@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7UZBLBQWQ4QGLOAG34ZYB5MWBSANNLKL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

On 21.10.25 18:15, James Bottomley wrote:
> On Tue, 2025-10-21 at 14:46 +0200, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> As seen with optee_ftpm, which uses ms-tpm-20-ref [1], a TPM may
>> write the current time epoch to its NV storage every 4 seconds if
>> there are commands sent to it. The 60 seconds periodic update of the
>> entropy pool that the hwrng kthread does triggers this, causing about
>> 4 writes per requests. Makes 2 millions per year for a 24/7 device,
>> and that is a lot for its backing NV storage.
> 
> The Reference implementation does this because it's NV ram is main
> memory and thus not subject to wear.  A physical TPM can defer these

"NV" strongly suggests that a real implementation should permanently
store whatever is written to it, no?

> writes and condition them to the lifespan expectancy of its NV store. 
> If you've simply copied over the reference implementation backed by
> wearable NV, then that might be the thing to fix.
> 

My impression is that this is exactly what at least half of the fTPM
world does, starting with [1] and now via [2]. I started a discussion
with security experts about how often a write back is actually needed
but have no answer yet.

>> It is therefore better to make the user intentionally enable this,
>> providing a chance to read the warning.
> 
> A standard TPM expects to be a secure RNG source, so is this merely
> speculation or have you found a physical TPM that has failed due to NV
> wear because of this?

I have not worn out any real TPM so far, only debugged the de-facto
standard fTPM in QEMU - and found this unexpected property.

At the same time, what should be different for a real TPM? It will not
have a battery-backed RTC either, thus will live from a clock source
which is reset after power-off. In order to avoid jumping back in its
own time, becoming vulnerable this way, I would expect a real TPM to
record the last seen time as well. Maybe it can do that smarter if it
can still write some bits after detecting power-loss, but that is also
speculation.

> 
> Even if this were a problem, wouldn't a better solution be not to
> gather entropy if the kernel pool is full enough?  We don't drain the
> pool the whole time after all.
> 

That is a valid question, but at least I'm not deep enough into all of
this to answer it.

Jan

[1]
https://github.com/microsoft/ms-tpm-20-ref/commit/0ebdda848e16d5ef78d1342c2fdfdd6dffb1004e
[2] https://github.com/OP-TEE/optee_ftpm

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
