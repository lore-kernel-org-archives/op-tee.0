Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9806C47BD2
	for <op-tee@archiver.kernel.org>; Tue,  6 Jan 2026 09:40:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 032B74FF72
	for <op-tee@archiver.kernel.org>; Tue,  6 Jan 2026 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767692422;
	bh=pUiKZv0mYImq75F2SAM3AOJz7ArMiy13jrMYYAJ0TPI=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=vY8FOFf7ZsgyE7aO5dk6dYXLMAGvIdkM7DBaFqcgLKd4DetscVWgtbnqtQ4IhKHrU
	 SiBxSf/xiLcmtamPIPsIbBvIdD7XJbD9LuUI1lSLK3gJPOLGbct9/W8qcsfDzuhQzz
	 XyssAbK6dSxXYdT8e0EG9jETA0X85LOQpBLo+7ao2u1iSUSuSx5gPLZLT3j3IfMlsR
	 o6qZwbyb1d9YfnsNRfmv6jb0amr0a/qQqc5qvvHhGrhlv8vTa7hItUgsez7Jnpq1XB
	 xhQ8zu44rPVTH9HQC1hwQJSPu6Lb7vXNIrZRo8+qQskyo/FylMcmrXCtvyngzgM1jp
	 C4quwPBXd3lMQ==
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0D3884FF58
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Jan 2026 09:40:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tJIHJL6d;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XI8/0e//fttAIb7OVwZpYDN1/emb17aNbHUxYQY7UKRwGQayLixOZ2ssszRzIsuHe3FH3A6IKwFnv1vW9BwZ/eJX9EL7cM5jyIDP/GhLim9teo2c15oC2PJz1XQLEtsU8fB3iTpyJPyqd83h30vepm785iZWlnjlQYDeYSRz+XnM8SZ2a2kl9THe3lmE1W1XV3wb/CVuzCX1saqe9ioyu5IqJ7ttRrrEk/Hz6kpbbYwlnfIaJqPSABPdoT+zyR+v6agO5ylK15TX431dcAb45pntbiencQMZBx/6AasYSCbGW/l9BBlct7cT7R6VcBqV7/N9gUFFFq9edPiGrP5D+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3X0bQgJ+7urF66T5wmVRlKo19vZNPzZgEdPyCqVva4=;
 b=HGeDtuKeI//CMLTX/KoXTjCpmV9IsnuV3cNyvmonmr5eTWNDN36gorU6objhQSkcKKZXDARkZujw2hLauvKv9hsVvGzGvhjRpLlXbH5LWBJQEoHn5YM9Dmp4v+RJ34irjWzzFYuNBYt/I8M9fdtV8bqdXP1K/t2es7Yuj1IUnGJ+XFy1TSJo6UKxWxKKY5e5g2DiFlKIQa/KIh5qoFjSfKwTxOJx8pY4nDWDPvVmqGVOGDd9R/wd5l4Igt0mRPYXOUtFdAFIxKsMrnKU+pUWagpnT0l+tybwXaWk9PmsuvV+H839kfPmRhm11S8tCQDLfE9xqhVk9aZ8r/XrS6g4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3X0bQgJ+7urF66T5wmVRlKo19vZNPzZgEdPyCqVva4=;
 b=tJIHJL6dEkxPkSemsBWsfjGL7Cz/HyTQEI1ESy6neDd1BWzZmklUXLCwgFeWoUlEIGsobUJF0dM3sxSZrVeKoj2QeyVs4t+ob++dQsPGcqKpTC8uJ1MpGeLtIBU/BejB3EAVSzZWDqbLAomte1sq868gjXnmXrjRmNN3oLcXA8vSjGc4o1Z/J6pqb8wtnljrRIax72oBZcAJReuMMWjjriUNdwLMNWGg2zlXslK20lAmHy8gYQHTs9Cvl/e6vvUB3O33YTrrjFpw3Q/82KhE5O4NgNJEUvFZZSv1eY3blQiMmvHKeMsJn6DU97LHlM9URERBvKxTu0KgUn5TsRd4yw==
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 09:39:59 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%7]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 09:39:59 +0000
Message-ID: <d14a9c41-9df7-438f-bb58-097644d5d93f@nvidia.com>
Date: Tue, 6 Jan 2026 09:39:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver
 callbacks
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, Jonathan Corbet
 <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>,
 Olivia Mackall <olivia@selenic.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Peter Huewe <peterhuewe@gmx.de>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: LO6P123CA0036.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e06cf2f-d2f5-4f35-d98b-08de4d078ec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QWZjYUpXd2VBT3g3ajlmWVA3OVFPbUFzUSttTkhxTEx1ZGJqVWRaZ3Z2b1dZ?=
 =?utf-8?B?dEhMTEtjSWE3UHBLV3lRVVl5QUJmbWN2ZmdidklpTmU3ZlJJMDk2WHZwbHQv?=
 =?utf-8?B?eGRNK0w5cDNrejdiNkVmclMrTmlPTzRIRFhaMkRhRVR2a2RTYUJ6V2xQTUR5?=
 =?utf-8?B?REd3ZWtaSytqemdPQi9OaVU5N1k5c3h6bXpNcGVySXhtZkR5TkI1RzRHWEU0?=
 =?utf-8?B?OUZab0k3Z1VBd3kvaTZ6bzFsVEpidVo3UXBoR2pjTUFjZEdjTFlwVC9pMG9U?=
 =?utf-8?B?MUdmdmMxaVhVMjV5cGZXWTk5WlhQSW12S2Zsbms2QTRLZ3picTBHNnh0RjR2?=
 =?utf-8?B?ZytZVmhzaDVabDNFRU5WT09RTE1MN0NzMEEzQ3V6UHNNWVFNbzZjYXZ2a2Vj?=
 =?utf-8?B?N1hxZE9aUnFWR1lKSHNZeEdXZXdyamdKUERzSzJEYncxMTlSektCdFV6VW85?=
 =?utf-8?B?NG5WS0ZCclBnanhHM2ptdXJIRUxRUmxkc3R3L29sZ05RUWdDME1GbWRwKzlU?=
 =?utf-8?B?aEQyclA2QVVLcURCaUxaZUp0QWZFazhoVXkycmJEZmtscHZ1NVl3MjI3RDZq?=
 =?utf-8?B?TnR2YzZpMzV2bWNTektEY2ZEUmd5RkxRZTVhVzUxVmFINi8zV2w1TnhoQWU1?=
 =?utf-8?B?U3VpL3U3d3drMkNJdmxZVk0vSmJia3lkZHpyTGFmemlXdmZDREZ6ejlKaVpu?=
 =?utf-8?B?dDVsOWdtNkUwUUEzd285TjdIVVJENVpSRHhQRnYyQ0FLOUNwZmp1eE1Mangw?=
 =?utf-8?B?d2tGbHIzeWthdEQwNHp1cXNsTEhoZ3dqMExOa2dQdUJmNmd1NUhuUUVSRDlH?=
 =?utf-8?B?aGIxQ1FyQW5MazJ1VzVtOEN4dVVmWndlL0NUYXc2VUMxL0FoeXVMb3N2U0lS?=
 =?utf-8?B?dUJWL0cyNXlHQ0VZT09ucFI5cVFLZXg0TXpMWVgxaHRBclJobW1uY2xWUnk1?=
 =?utf-8?B?ZVY2dmhZdUwxZDB1ODBKNVRQUDN1NmdYY0NkZUk2QnZLSU5FcUV5SzlZUmdm?=
 =?utf-8?B?TU5oVEdRSVNCWEdZSjRnb2xMemsrUkJLYnZWRWdLdVVQKytxVkEwMDhrcjZo?=
 =?utf-8?B?eFJvc2ltWXVuN3FVVjBrQWx0UkVGNTNZNnJQbW5CamsxUExyMUJMaWY1NkZ1?=
 =?utf-8?B?a2dFNVNVSTdxMlN5S3UrcXVsQmhTRUhybW5XWXBTVkgvek5YQm9YcHhrQ1Q5?=
 =?utf-8?B?THV2WVhWRnQ3bUI0bG1GdDVsMDZRdk9ta3pZajQ1ZnJMdGdLQmRiQStpV2Vm?=
 =?utf-8?B?WndWSlljYWRIYmJla1VELzVwZ0JrQUdMcG0xMUhobFArLzljYlh4aDI4SjBk?=
 =?utf-8?B?OEQ3ZEVYYU5abHIrWTVzd1Y4MGRha2dtZVgzS1JDVzc3M1FwM3JlTXc2Ri9M?=
 =?utf-8?B?L1RGbXNtVVNtUFgweG0xV3Bpa0VZeUpZdlo5VVpNOHhGaGh5dlRCMHBhengy?=
 =?utf-8?B?QjcwNkVvUHNtbHQ2eTR3Um5FWThPamFZdGR3SnplZnlRS1h0anNublBxUEFZ?=
 =?utf-8?B?R210UkFSei9sOHVFbTJybWJkVno1b2JZanZnTXFpN1VqS2xZZVVCWTNEZTNY?=
 =?utf-8?B?bWc0NFltZkVuRGtoY2UzQjJaNThSK2x4NE9KVGprZ2JSam5pRjNMK1IraGhY?=
 =?utf-8?B?dVgrVUcwa2x4cnNpcEF4RHl1QzNTVTlFMURPbGhHRDh4ajRGUmtuZnJSTUcr?=
 =?utf-8?B?OFZJRkFNYkZuVmxlNzF6cXE0bzRlMnYrL3RmbUY0SE9mUVc3UkZZSUc1WExj?=
 =?utf-8?B?TkV1R3BJYjBOQy9VczZuRlpGRStDbU5xaHY2ck51THp6Qkd0V0VJZXFyYWc4?=
 =?utf-8?B?dFVwcGRHQjVURVE0QXFFdjJrMXVTZkhvNlVwQnFmYzNXZ0RXZEJxb01kZWhS?=
 =?utf-8?B?UWYxQjZoTzlZNUhkZXU3ckdtUjNuMHRkRTFBdVpGSDJ4bEFNUC9uUkN2VC80?=
 =?utf-8?B?cGlvbmdZVmFFOWtRMHNpc3pBRW4wQWk3blQvSkNwQkhDcXBjRllZTnh2Nm1R?=
 =?utf-8?B?SkF0VDg0S2NSMFluTFA0NlA3Qmh2TEpkWk0rY1hoQnBIKzdPK1Fka0wzRXpC?=
 =?utf-8?Q?fHgAug?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OEFZbEJaMzZ4UjJHbWxrdGd3WVBnSVI5SmJDWk9KdVh6VFgyVXcrQU5iUkZK?=
 =?utf-8?B?V29xeTFyTUVBRGtWaUwrTUVZUFUrbFQ1VXFrUDRqZ0F4bmljSXgzVzl1TWhv?=
 =?utf-8?B?SzBRMDloWDhCZE9zMS9sV1lwVDc3R1dYMHdNZGkvRFJCYjZLbVNobkNwcGJ0?=
 =?utf-8?B?NEI1ZmJUUlBZeVprTVpKR0p2QWphRU1rbHFLTjdnZHh1Y0RkZzFOSFJBNlp5?=
 =?utf-8?B?ZnV0Qk5MVjZ5aEFQbno5NlhVNjJnU0RyTVJCYXhFU3hEc1BkVXpkd3FSbktP?=
 =?utf-8?B?OVpDblZrTS9pelR2ZVhiMXhKcmViVGZGNFdjL0VFelV5YmxXRGpUSEUxNWtS?=
 =?utf-8?B?ZXgwVUtVc0NWbXI4S0FHUVBRRng1bWJRb1ZPcDJqZUcrbTl4d2loZlpXZlEv?=
 =?utf-8?B?dUt6VDMwMXFPMWU2MGFUeHgydTY0Vk00dW5yK1QrekdaV09tbnFNWDZiMmNH?=
 =?utf-8?B?cDFmVGVzS0RJSm9odVdXTzVRUGdDeHJCTk93cFhYSzg3M1NEclVUdTUydE9D?=
 =?utf-8?B?MkFzQlJKa1ZZTTZHVHhMWnp6L0gwSGl6c2Z6bWRQaVhWRytXcXJoYVp3U0hO?=
 =?utf-8?B?OHRUcHdJTUJsVStSSjBxWEVlNENOVXo3Rng0RlpJajNvMUIvVWVMVFlaRWZ6?=
 =?utf-8?B?cE9BbGlQZTR4Q0NTbEthNDJSb0dGYkV2ZlY1THpyK21WMzRVNlVvdldqU2Ns?=
 =?utf-8?B?YVBYU2pSeWZUOTRtcTZPVzFiM2lzRmQwM0xZdE5uTUNkb2N1S1lkVGluS2w0?=
 =?utf-8?B?b25jYkFHRkhFTitCcGxoWUtwejkzQVNOS1FVMW9FZ091NWJMUHFNTHR2ZUJQ?=
 =?utf-8?B?KzR1b2VWZUVUZVZQVmNKekVNTGJDTGRlWWpuL2hRK1U1NzROdG1nQlJYYlNY?=
 =?utf-8?B?c3YxTGNaODQxNFNlck9yYjlXanJYWVNrcmFkb1d0aXZRYVBWYUJlMzZIZE5E?=
 =?utf-8?B?N2FteVMrc2FLV3VxRXB5Zjc4VHhDUmEzanFSeE1JVzVxSXA5ZWgwL2UrSHF0?=
 =?utf-8?B?bndoSUNnTitVSlhScm44aUtWMTlnS2o1WVNOQ3pya0lLb1BWS25ST0RISlhM?=
 =?utf-8?B?N2luK2l4L013SklidjBaaWdaSktxOTVLem9zQ0hMTDJrNWJjU0h1akFMNHU4?=
 =?utf-8?B?Mk5tS1c4TDdTTURPWjk2RlRvUlVrdXBNWk10NHFSalEveVVlNGtCeGhlYlBx?=
 =?utf-8?B?aFFTcERsd1czSURmZHBDZWZaWHY2WmU0bUFPY3RZdWRtV1AzYkRIdVlZcjdR?=
 =?utf-8?B?emk2OHFWWHdZUlJoNkpDYWswb1pRNldndm1MbGhNb0NOWWFkenhaWTJHRG1R?=
 =?utf-8?B?QUpZYkxDblkwMFNrc3RuVnRGT0JhZ2c0ZFpQYWw3T3pVUU5DME9lczB4NkVG?=
 =?utf-8?B?YmtPWDJtcG5RN0NsN0ZRNUxhcXY2eVZyOFBWdE1pRnFPT1VqMXc3cmY4L0Vr?=
 =?utf-8?B?VTVRVDY4SUZMOVRDM1VkQzZ4RUljQWtOak5TaVJNWERsNTBFR3hJOTdCNzYv?=
 =?utf-8?B?c2cwVmQ2L25LQWQ5em5GOSs0QVBJRlhUd3MzUndGT3F3WDliMlI3TkVzTy9R?=
 =?utf-8?B?a2s5d0FPbFVlTnF0V0gxcFdBclhoZnYrRzNOMTNMWlJwdnVoSERXY3JIZHBu?=
 =?utf-8?B?RkQreVM3ZWFKSHN2amFCWVBUL3dlQVFuU1c0ZG1FWEtrZ0pIbjJRNEF6djk4?=
 =?utf-8?B?Q21nQVB6RlBvYm5PWkFoVFlFNzROT2U4N2t4UENtS0t5OE5sMUJCSHZXY0tH?=
 =?utf-8?B?WlVJYkdyV3dGK3NEamVtSlpTZ09La2Z5eloyUG12M0Y3bXNtNVdjWmpBdlNL?=
 =?utf-8?B?ODZ5aEhVR2NTbkU0QXBIQmxJMW03VU4xZUFMY3VPc3F2SXFyNkU5K0d2RVZN?=
 =?utf-8?B?dmZoWWtqemZJSG9RMTIvOXg5c1pOUE54QlZpbkRVL0lKUW8rMm9RckczZEhX?=
 =?utf-8?B?dTc0K0o3Y2tZMVdNWkZGK25oazJnZUR4dy9GL3RRYldNeUNzSy9jU2RHeThD?=
 =?utf-8?B?M2k5R0duWkx6d1ZNLyt1Zjk1blVhbmR3SEJ5SXlCTjh5dFFjSytiZGdtQVFr?=
 =?utf-8?B?UHdVTXRta3ZMUnQrZ2xrUzZXOVJLR05WbkZtTXNRL1VSYTdsb2ovK1phNE50?=
 =?utf-8?B?R2V0WXBiY3pYbmFIMjUrTTRFL2xVOENjamU5V3ZPT1B4MkhCeUxjWi9QcXND?=
 =?utf-8?B?ZjMzWkFaN2JBQXRMcG5SY1V0b2xkTTcxUDJNak1scGtPdWdaTkRkOHJHbENR?=
 =?utf-8?B?OFpIKzgxNlpjSm1JUE9jOUc5bkRxZmMxMy9QbStHZ1hiNkxmN2dHZHhpRGVF?=
 =?utf-8?B?QU9TZzZWWEUyazM1T3BGWnFmbXlyTUhLSWRqOFc0MW1abXAvUGE5QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e06cf2f-d2f5-4f35-d98b-08de4d078ec4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 09:39:59.1352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCVsIq+4Z0kCrVfTzjjylao1oxMesioQXs7tCHD0JOb1Ldw8+7VrDMP2PahLb4zM5mLw9gHXW9aXTEG9HM+htg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.201.42:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	FREEMAIL_TO(0.00)[baylibre.com,linaro.org,lwn.net,kernel.org,selenic.com,gondor.apana.org.au,bootlin.com,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,arm.com,wanadoo.fr,broadcom.com,HansenPartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[44];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2603:10b6:a03:4d0::11:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0D3884FF58
X-Spamd-Bar: ---
Message-ID-Hash: 3XERMN7OP5OUFUPWXYVHEJGWPMY7VSSV
X-Message-ID-Hash: 3XERMN7OP5OUFUPWXYVHEJGWPMY7VSSV
X-MailFrom: jonathanh@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3XERMN7OP5OUFUPWXYVHEJGWPMY7VSSV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jon Hunter via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jon Hunter <jonathanh@nvidia.com>

SGkgVXdlLA0KDQpPbiAxNS8xMi8yMDI1IDE0OjE2LCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToN
Cj4gSGVsbG8sDQo+IA0KPiB0aGUgb2JqZWN0aXZlIG9mIHRoaXMgc2VyaWVzIGlzIHRvIG1ha2Ug
dGVlIGRyaXZlciBzdG9wIHVzaW5nIGNhbGxiYWNrcw0KPiBpbiBzdHJ1Y3QgZGV2aWNlX2RyaXZl
ci4gVGhlc2Ugd2VyZSBzdXBlcnNlZGVkIGJ5IGJ1cyBtZXRob2RzIGluIDIwMDYNCj4gKGNvbW1p
dCA1OTRjODI4MWY5MDUgKCJbUEFUQ0hdIEFkZCBidXNfdHlwZSBwcm9iZSwgcmVtb3ZlLCBzaHV0
ZG93bg0KPiBtZXRob2RzLiIpKSBidXQgbm9ib2R5IGNhcmVkIHRvIGNvbnZlcnQgYWxsIHN1YnN5
c3RlbXMgYWNjb3JkaW5nbHkuDQo+IA0KPiBIZXJlIHRoZSB0ZWUgZHJpdmVycyBhcmUgY29udmVy
dGVkLiBUaGUgZmlyc3QgY29tbWl0IGlzIHNvbWV3aGF0DQo+IHVucmVsYXRlZCwgYnV0IHNpbXBs
aWZpZXMgdGhlIGNvbnZlcnNpb24gKGFuZCB0aGUgZHJpdmVycykuIEl0DQo+IGludHJvZHVjZXMg
ZHJpdmVyIHJlZ2lzdHJhdGlvbiBoZWxwZXJzIHRoYXQgY2FyZSBhYm91dCBzZXR0aW5nIHRoZSBi
dXMNCj4gYW5kIG93bmVyLiAoVGhlIGxhdHRlciBpcyBtaXNzaW5nIGluIGFsbCBkcml2ZXJzLCBz
byBieSB1c2luZyB0aGVzZQ0KPiBoZWxwZXJzIHRoZSBkcml2ZXJzIGJlY29tZSBtb3JlIGNvcnJl
Y3QuKQ0KPiANCj4gdjEgb2YgdGhpcyBzZXJpZXMgaXMgYXZhaWxhYmxlIGF0DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC9jb3Zlci4xNzY1NDcyMTI1LmdpdC51LmtsZWluZS1rb2VuaWdA
YmF5bGlicmUuY29tDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiANCj4gICAtIHJlYmFzZSB0
byB2Ni4xOS1yYzEgKG5vIGNvbmZsaWN0cykNCj4gICAtIGFkZCB0YWdzIHJlY2VpdmVkIHNvIGZh
cg0KPiAgIC0gZml4IHdoaXRlc3BhY2UgaXNzdWVzIHBvaW50ZWQgb3V0IGJ5IFN1bWl0IEdhcmcN
Cj4gICAtIGZpeCBzaHV0ZG93biBjYWxsYmFjayB0byBzaHV0ZG93biBhbmQgbm90IHJlbW92ZQ0K
PiANCj4gQXMgYWxyZWFkeSBub3RlZCBpbiB2MSdzIGNvdmVyIGxldHRlciwgdGhpcyBzZXJpZXMg
c2hvdWxkIGdvIGluIGR1cmluZyBhDQo+IHNpbmdsZSBtZXJnZSB3aW5kb3cgYXMgdGhlcmUgYXJl
IHJ1bnRpbWUgd2FybmluZ3Mgd2hlbiB0aGUgc2VyaWVzIGlzDQo+IG9ubHkgYXBwbGllZCBwYXJ0
aWFsbHkuIFN1bWl0IEdhcmcgc3VnZ2VzdGVkIHRvIGFwcGx5IHRoZSB3aG9sZSBzZXJpZXMNCj4g
dmlhIEplbnMgV2lrbGFuZGVyJ3MgdHJlZS4NCj4gSWYgdGhpcyBpcyBkb25lIHRoZSBkZXBlbmRl
bmNpZXMgaW4gdGhpcyBzZXJpZXMgYXJlIGhvbm9yZWQsIGluIGNhc2UgdGhlDQo+IHBsYW4gY2hh
bmdlczogUGF0Y2hlcyAjNCAtICMxNyBkZXBlbmQgb24gdGhlIGZpcnN0IHR3by4NCj4gDQo+IE5v
dGUgdGhpcyBzZXJpZXMgaXMgb25seSBidWlsZCB0ZXN0ZWQuDQo+IA0KPiBVd2UgS2xlaW5lLUvD
tm5pZyAoMTcpOg0KPiAgICB0ZWU6IEFkZCBzb21lIGhlbHBlcnMgdG8gcmVkdWNlIGJvaWxlcnBs
YXRlIGZvciB0ZWUgY2xpZW50IGRyaXZlcnMNCj4gICAgdGVlOiBBZGQgcHJvYmUsIHJlbW92ZSBh
bmQgc2h1dGRvd24gYnVzIGNhbGxiYWNrcyB0byB0ZWVfY2xpZW50X2RyaXZlcg0KPiAgICB0ZWU6
IEFkYXB0IGRvY3VtZW50YXRpb24gdG8gY292ZXIgcmVjZW50IGFkZGl0aW9ucw0KPiAgICBod3Ju
Zzogb3B0ZWUgLSBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoKQ0KPiAgICBo
d3JuZzogb3B0ZWUgLSBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gICAgcnRjOiBvcHRl
ZTogTWlncmF0ZSB0byB1c2UgdGVlIHNwZWNpZmljIGRyaXZlciByZWdpc3RyYXRpb24gZnVuY3Rp
b24NCj4gICAgcnRjOiBvcHRlZTogTWFrZSB1c2Ugb2YgdGVlIGJ1cyBtZXRob2RzDQo+ICAgIGVm
aTogc3RtbTogTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKCkNCj4gICAgZWZp
OiBzdG1tOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gICAgZmlybXdhcmU6IGFybV9z
Y21pOiBvcHRlZTogTWFrZSB1c2Ugb2YgbW9kdWxlX3RlZV9jbGllbnRfZHJpdmVyKCkNCj4gICAg
ZmlybXdhcmU6IGFybV9zY21pOiBNYWtlIHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCj4gICAgZmly
bXdhcmU6IHRlZV9ibnh0OiBNYWtlIHVzZSBvZiBtb2R1bGVfdGVlX2NsaWVudF9kcml2ZXIoKQ0K
PiAgICBmaXJtd2FyZTogdGVlX2JueHQ6IE1ha2UgdXNlIG9mIHRlZSBidXMgbWV0aG9kcw0KPiAg
ICBLRVlTOiB0cnVzdGVkOiBNaWdyYXRlIHRvIHVzZSB0ZWUgc3BlY2lmaWMgZHJpdmVyIHJlZ2lz
dHJhdGlvbg0KPiAgICAgIGZ1bmN0aW9uDQo+ICAgIEtFWVM6IHRydXN0ZWQ6IE1ha2UgdXNlIG9m
IHRlZSBidXMgbWV0aG9kcw0KPiAgICB0cG0vdHBtX2Z0cG1fdGVlOiBNYWtlIHVzZSBvZiB0ZWUg
c3BlY2lmaWMgZHJpdmVyIHJlZ2lzdHJhdGlvbg0KPiAgICB0cG0vdHBtX2Z0cG1fdGVlOiBNYWtl
IHVzZSBvZiB0ZWUgYnVzIG1ldGhvZHMNCg0KDQpPbiB0aGUgbmV4dC0yMDI2MDEwNSBJIGFtIHNl
ZWluZyB0aGUgZm9sbG93aW5nIHdhcm5pbmdzIC4uLg0KDQogIFdBUk5JTkcgS0VSTiBEcml2ZXIg
J29wdGVlLXJuZycgbmVlZHMgdXBkYXRpbmcgLSBwbGVhc2UgdXNlIGJ1c190eXBlIG1ldGhvZHMN
CiAgV0FSTklORyBLRVJOIERyaXZlciAnc2NtaS1vcHRlZScgbmVlZHMgdXBkYXRpbmcgLSBwbGVh
c2UgdXNlIGJ1c190eXBlIG1ldGhvZHMNCiAgV0FSTklORyBLRVJOIERyaXZlciAndGVlX2JueHRf
ZncnIG5lZWRzIHVwZGF0aW5nIC0gcGxlYXNlIHVzZSBidXNfdHlwZSBtZXRob2RzDQoNCkkgYmlz
ZWN0ZWQgdGhlIGZpcnN0IHdhcm5pbmcgYW5kIHRoaXMgcG9pbnQgdG8gdGhlIGZvbGxvd2luZw0K
Y29tbWl0IC4uLg0KDQojIGZpcnN0IGJhZCBjb21taXQ6IFthNzA3ZWRhMzMwYjkzMmJjZjY5OGJl
OTQ2MGU1NGUyZjM4OWUyNGI3XSB0ZWU6IEFkZCBzb21lIGhlbHBlcnMgdG8gcmVkdWNlIGJvaWxl
cnBsYXRlIGZvciB0ZWUgY2xpZW50IGRyaXZlcnMNCg0KSSBoYXZlIG5vdCBiaXNlY3RlZCB0aGUg
b3RoZXJzLCBidXQgZ3Vlc3MgdGhleSBhcmUgcmVsYXRlZA0KdG8gdGhpcyBzZXJpZXMuIERvIHlv
dSBvYnNlcnZlIHRoZSBzYW1lPw0KDQpUaGFua3MNCkpvbg0KDQotLSANCm52cHVibGljDQoNCg==
