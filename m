Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125C3CCD199
	for <op-tee@archiver.kernel.org>; Mon, 20 Oct 2025 11:12:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6ACC0430FD
	for <op-tee@archiver.kernel.org>; Mon, 20 Oct 2025 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1760958761;
	bh=uVTCJWd3VqYrFQItvbayj3jwLW8FSrJLqceWiipyWKc=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XzAf1F86GF/St+nqsQFCoMF89S5Pysft8EeuB3U5RdAB/oIy9OiMGmXZHWRC1UZdD
	 O0RbVK3cnrguUWonuFEPk0GoEGt1dWR/IaqbS2EFSPNSutSFLH7X8hU3JNtrrLfOim
	 Ov0QVlmOyFHMafoqlh0VQuzGr0yXFIonlHS8jtfTuu5jjkb7W595YUv+DZqhJlubiW
	 xAR1zlb6ANBbSSircWmX1zFgpvQCC8eQO583XQBwET7Vw8SKIvW5enotkVSzeBHpRt
	 THXOWpQ+DRk1I0XVBC0MIOupIapw1QNvQsaLzNmKWERfmDiTItobp7iJrCF+QwZuoA
	 /6Cof8w+ANItw==
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BF9CC4FF57
	for <op-tee@lists.trustedfirmware.org>; Mon, 20 Oct 2025 11:12:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=xvX9gBJy;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icv+M5jy6rtOa34x5kpdki7DU2UyN6csuGs0U/Ns/NNCTUeORMFHGKdqVg5k+1un1FUPPZdWJ1KPffKixafaK+mLMz4PUGwDTDrtcHWJLPb9pDRq1yOBqnF3ppPWktuDgNb/nfjLLUAE2gvRAPurFPoUu4hJEt80hV5KX4oP/TTy/muasNIiPki+FlrxU+47fbfmzDt4Bz7x5antHZOSM6eBKcqEJkwEWJpKtMoXwG/nB9pf9q5Ne1+FCZBtIDsHFzGQat+eWF+KDR6yLV8JJ9K0N5ZCnf93eaWz2LriRHWiYf0Hqr8stcp/j82mbnDPHRTqrGurVlXpaWlXrOW98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iB4BYpVH33dbAmCcVRIJ892WshLAKyPdpPf8rCkkKkw=;
 b=LiuymN/oOMODHSACyQ8ktC+rN8bQ3U35hRlOnPP+FNfkxlOwW0yDfQYN6lXCtkETdx6sZSX/jbTo1Y83+8oj20wszbvnDz3RS8HCRbEPiEMBLoa1CHTfkWKEWQnBNVFeDMGIg3uzSa9YFBCfWKhMeHZ5qXd3UYufDguoZjEeVyQqBeSdoVZ/sUyj3qsnOkk5axzSoFVq37KNMeAobjQv4TaznQniGQyWyQfmdkabUceNVJITlAl6DnTpGeOZusu3Z6Fu4KjnDI5QrXjnO6WC9pYfAtnAEQr5yYVGTlwgPSqUIBPqmXRe8IZShYzWDlBcj879QAlLxgfoYG5RUPggRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iB4BYpVH33dbAmCcVRIJ892WshLAKyPdpPf8rCkkKkw=;
 b=xvX9gBJyDqLb3gHP/chIM2dwvxZNWgPXR+SZgSqRZJKhoZScQ0+8lOnZ69IEyWUyxH2XtL2Ex8YOVZESvFashEc5pB1cZP5xSgpZ6rBuOsZc7Xi3vo3ap6MHkgqTxV1L2XjPTxTHcC3q1pN5gg6f0gHI/CpDwZFUb43AtL5EUTqdQTZMnGxao7Iqi7FfwB0nQMZ58hNCXXNTmHVb+lRs6huye4o5OgWtdEf7Q4Yb9mbwe0xUvFDfhlnmYqexCW9T3yIAY8v/sIcjFn5OCJ5XEGNG2pwdMxzBVqfJcE9DO5zvHbGF2uYUF2nhKqeDbcqsyK/bid8vAM2dEkkReTiyzg==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:535::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Mon, 20 Oct
 2025 11:12:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 11:12:02 +0000
Message-ID: <6a7a7be3-e5a0-4566-85ae-877b0cca5a12@siemens.com>
Date: Mon, 20 Oct 2025 13:12:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] core: Relax StMM dependency to TEE_STORAGE_PRIVATE
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Joakim Bech <joakim.bech@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
References: <1b6b2738-9813-4d22-9ad3-cb3b5d6a1509@siemens.com>
 <f23c1ae7-de7d-4627-b1e6-e5123c263adc@linaro.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f23c1ae7-de7d-4627-b1e6-e5123c263adc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0449.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6054:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b766cc-2e0a-474a-a16d-08de0fc97ee9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZUN5OXg0Rkl2a1lHeEJmbFl5bDJ2d05raitSbGhDR1J0MTU0czlucWFSWlVs?=
 =?utf-8?B?ZXZhLzg4empOUmMySCtmT1N4T3dVcFhpMk1ncU1SS0k3SG9WQWNwTldhclk4?=
 =?utf-8?B?eTZJRTRBZC9yZzUrelI1eEMrSlRLcVp6Q2tCbEU3MGd5MGRlc2xJVG1rU2ZP?=
 =?utf-8?B?K3ZDQndtZndtQUs1aEQ3VUlSMmRRUURWcFc1NFRGWjdXZlIyUG9EN0xOZExm?=
 =?utf-8?B?ZERFU2syNDA0NWIweWxLLzU1dUI0aXI3L1pCanY3MDFXTi9qcDZPakdMZUw4?=
 =?utf-8?B?K3BtZlh2d05SMU1WQ29lVHVvSEwwRnJTc1phZUJFQXhWdEo1Q1NjeTg1SG9U?=
 =?utf-8?B?V0pWbDlsRVc4a242Tlhsekg2dEUrTGFNNllJSGJoUEJBTWk2d28xVFF0WEk5?=
 =?utf-8?B?N25wR3k0MERTZHZsY1l6ZUg4YWQ5YmZxQ3BkMW9RUkhOaVI2Wmp6Ui9jT2Uv?=
 =?utf-8?B?d2wxbDFyUFVIdVpRVUYxMGRPTG9hTDAzMDk4eDJaU1pOYmxBRmNKLzBwSHNv?=
 =?utf-8?B?OW5yYlRtb3YzN3YrMmo1VDBTdjJBNW1raDJmT2tOa1JmN2daVUVFMWRSMUJG?=
 =?utf-8?B?MGNJV25tRUc1UERFeFNlWWk0R2RiNmZ5SFNvc0RtS1JWQWFuNlpiMVhaZXIy?=
 =?utf-8?B?WHViLytXR1cyZ0p5b0t4REhGbUNzUnhvMWZFWFBiNzlxSGhWZW1jSXZlOUxU?=
 =?utf-8?B?S05LcVJqWC9Nek5wVkRLYmJNaE9iNnFUdkgzTmNOOCttcWIySnZBSFA4bWxM?=
 =?utf-8?B?cmxBQVl3TjVBNGFualQza2JMKzlzWTZjNU1TQjlYZUxxYUJFeUE3VUtwb0to?=
 =?utf-8?B?b1pnZjl3RU5oZHM4cGFtZzE1YmF0Smc5MlNic2RGWmdQd0g0SDU3a1FmdnBZ?=
 =?utf-8?B?cDQ1TXdLcmgrU2hOcW9KU3l3d1RQdEJhS0RIYTF6Vzl0TkIzL0c2VERTaXdv?=
 =?utf-8?B?YXZFRnJCY1lsR2RwamxSWG5rRlhVYkNVZjNITllPQXlleXZDZlFKclpWUUJX?=
 =?utf-8?B?MlZoTUFkMlRWNTVjRzJKd1pyZEF1eDdmTitvOVY2UnlDZXFzU1pXZ1NMT1NN?=
 =?utf-8?B?UnM2dmx5Q3ovcWFGTFpPTThzTytCYmw2K3hpUFVUMmRUelVLQm1wMjZGZVdV?=
 =?utf-8?B?TzBqY3JvRnRzYlNidExYbkFmTWMxZmh2QVhJa2ptanBIdkpCS2FCb01tNFdh?=
 =?utf-8?B?eXFUbFFqMmFtQWtzODZYeDFWdFhkRjNQcHJnaWFQRGF0Snl0SlBXWnpud2VP?=
 =?utf-8?B?MmYyL3NtakdlUHVIbUVXTkEyTDJITHBDWVdYSk1WZzlnUy8wNWpBekw2Y3FX?=
 =?utf-8?B?WWszREF4SDJKU0xySTNXKzdYSnRuSzIydGliTzRQUWJPS0ZmdVd6NGxUbXI4?=
 =?utf-8?B?TkdSWmZCb2x6elVkalpWN1NVOGVnQkN6MW1VcmRLRDlEdFRGQlJvb3pOTjFY?=
 =?utf-8?B?dnJMeU9sdUdiK2VDRUdnNzFUZWRVVEZrSlgzUFVQdlBCUjl0RmIyaGxZWWNu?=
 =?utf-8?B?VGoyZWwrUUptMWx3V3hDd08vTEs3TUE0Z29QdTEvQ0N3MEphcmZnNmo3dEFy?=
 =?utf-8?B?VjZQZWU1N3I4b0h5aWQ4WjdhUVZiM1VEa3lQOS8vbjgra3ZMZFFFb09WUG8x?=
 =?utf-8?B?anNpeXMzd2JEVlN3dnNlNDMrRjYrUytCOWVQT0hIekVTR2hoWXUvNTJLYVlW?=
 =?utf-8?B?d3ZFL3p6YlZuOWhoMUpiWTZQWE9DUTZDZkNta2xUdmthQllQd3lrUHgxR0E3?=
 =?utf-8?B?RVNpQXROeHY2VVp1bTloZHNONGxvbzJMN2p2cGhwRFhPRHF1Q0VObjRFRVly?=
 =?utf-8?B?VlRpaWE5ZzI0QUdtSnJ6MzMwalhkOGF5RzVXSzIyNWtVRkk1T0FjemVobXlD?=
 =?utf-8?B?RHh5dUtUYjhzUnF1b1N2a1VNcDdUb3dSdUNNU2FDeEljUTRJSnJVdGRyczlO?=
 =?utf-8?B?ZEh1VG84enhtVzZqTGc2N1VrMXd6S3NEVk5jMFo3QmQrLzlsVG9sV2FOUXla?=
 =?utf-8?B?OXhuUlJZai9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0gzSXZ3SUpkVElvZGdDZVhBQXU4SERRald2RFhFVHZUMGVQZzJwbkVYcWxF?=
 =?utf-8?B?b3RvTnQvS1hVRmtuQXNmeFhranc5WVYvRFh4V3FoMURKSFJUU2c1alRCSDBT?=
 =?utf-8?B?U21YcnBYaHhCcy9OQzNDUEpLYVg3dHRkQ1VvZmpjQTZzUVRHTUVaVzJiTUM0?=
 =?utf-8?B?SUZURjBibzRwUk95V25FcXdYNmM0U3JrVFVpdURCblM0K1ZhcjQ1Z2FtOHlS?=
 =?utf-8?B?bWxMdVFlbjN5ZVJXZFF2c0lFelRuR0VzU0l0L1IwZ2krVFBiLzJUMW03U0Yw?=
 =?utf-8?B?bERjVnRKTzNRNyt5cmQxQUtHcUJpbWhyN2NRb2swd1drY0c5aFJiejBKVnY0?=
 =?utf-8?B?cUx4TGxGRVpxL1cvVjQrNlZIZUozN08vREdBUXl0a0JkUC82c21YZXl0VXVT?=
 =?utf-8?B?YTZiRnR2MWtFNFpqZnUybFFZdU9SUHQ0ZC9KOXJVc0ZlcHVTd0tXZSt0OG9u?=
 =?utf-8?B?em5JWXU0V0dlUk9wQUhCYmhmVFhtKytKRURlZnpWMStSN2t2a1JWaWxmNkxr?=
 =?utf-8?B?SldOeTRFNUdMNXFxZDhsaHpac3dMSm14Ykw1azc4VW5odzE4SDZ6RkZ3d0RL?=
 =?utf-8?B?Y0FiUU5ad0RMZWlFdTAwUFYweVRWbXFneFNlMGQ4UHhVREdDNWFDM3BFazhN?=
 =?utf-8?B?RUIzQlVYL1k4dlVvZUxuSUVTMkR3MXRKU1hubDV1dlBHQklEK2hYNEdqZlZj?=
 =?utf-8?B?Tll6V05rbVlQbE5oN1pMaVpwemh3NkJrQXc3MnhLY3pHUlAxVm03Qkt0dXVl?=
 =?utf-8?B?My9DdlJwalhSOHpoVzVneWRoNTluMkI3SzhlUkFkUE0yY2JWemhxVWZxWFAx?=
 =?utf-8?B?MWw5NllzdnBUTmwycjBmQ1gzQ1ovQUJ2dmVXa1dzRmgrRHp1VmcxQVp4ZjRk?=
 =?utf-8?B?Wkw3Y3RmQlVXTmU3WE9GNUZEVi9GdUsyM3lvUndHdmc1anFEU3JXYkFnT3BS?=
 =?utf-8?B?SExPYnJ6VlNLRU1qb01PRGw1NFliM1M5MHUxMlZQRnhPV1RjSDErQVoybnli?=
 =?utf-8?B?YjVaWVV3Wktpa2gweCsvOHhOOFNCRjNwTC9uSUtOcE1nR2ppNUdOTUdyTk5r?=
 =?utf-8?B?ZHNPejQ1S1g1YStBTnRUTTdWR2hkSFZxR1ZzNEpqb2ozQlJOMkxYcFJNZVNa?=
 =?utf-8?B?TEtsc2xhQVpPdkNmSXh0c1JhMVJUYWlqTjlEQzNOcG04SGxoOUpUby96R2h0?=
 =?utf-8?B?aUEvRWNnTDVNYThCeGg2YTR3K3h5UXA5WmFCVm5lWHF4TEg1UmVJQWtHYlY1?=
 =?utf-8?B?dWZudUk0ZHN6Y0lUV0dKeUluaDUrbnp0QTIwL0JEdTlXOUtsMVJBQXdCM1VC?=
 =?utf-8?B?OGx3OTFiUlBtZzZhTmRSYkE1anIraFhESE8wd1FrclNEYldkUjlPZ1VHMlhu?=
 =?utf-8?B?SUE1d2paK05zeDRIQzBabEdhWE1NR2hheURrdmlpcXhDMmNPR0hHNVZ1TlNU?=
 =?utf-8?B?Q0N5VXJmbGh1Wnh5VlBhQUp5eUo5UkRuTEIvLzFBUTNJSEFROFlrMkRvd284?=
 =?utf-8?B?OEliM0RsQVBybVBZdlMrM0Z4K3F0R0ZwUEZ0dzNKbGx0OGwrVFhRK3R0RldI?=
 =?utf-8?B?UVhSNFJFNXBQeWlHOFNTQjhKbkpDQTlPWkFVVldPaUVoMFFXdlRxdHBMUkZY?=
 =?utf-8?B?S2RpbTdZTlJnOUlrWHRVdUdUeWI0WjVadDJybG5XY3I5ang2Y0RVUk4rT3Rm?=
 =?utf-8?B?eGpQWlFEYVprZmNxT0VlNnZnc1NZY2Z2SVJSdm92M3VSRXFVUE5vdFpjOFJJ?=
 =?utf-8?B?N28weGtlZy9yUHdJdWFPdHJQMDl4NVZqeFJrVzZKN0JYNXA4K0dMQzA4UkRX?=
 =?utf-8?B?UHAwcWlJY3Y0cXZ0RExiSWcvTVFETGdCQVJtV0FYc3daTW0vZG54cVo3OTMr?=
 =?utf-8?B?ZkR6RDdrSVJVVnRQTmJBWFJsOW9lVmFNMm1DS3dGRm5nRkpqOXE3QVg3clNo?=
 =?utf-8?B?MWkyQ0NUSVU1T0FvVCtpdk5ZZ0FYKzB3MzZMcjZIRFJFV2RGaGZ5UE13MDE4?=
 =?utf-8?B?ZkZyODBiajB0eHZuZHBUS2VzenZEU3pWbllZeHJraTdFWVZtcXFxS2VPMExh?=
 =?utf-8?B?a3dSZUFVOUdydG1YU2R1VFo3OGpvK1hXRzQra0U5QXlzVWhOSlJRclFjYzNC?=
 =?utf-8?B?MDRmb2Nwd29vT1lIUndIajF5QXZEUWlheDRTeGpQZHNQV0gzVnZsS2poVlph?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b766cc-2e0a-474a-a16d-08de0fc97ee9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 11:12:02.6644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ra8IdoAXkLOvNMdvmqMOJL1WF7L+k3r+ajEZxEvTZfCpmx2dsNHRnNwoIKR+k+sb3XWmQHYpsqVuYam2mRJ5BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6054
X-Rspamd-Queue-Id: BF9CC4FF57
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.70.60:from];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.70.60:from];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
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
Message-ID-Hash: FUS6ZADQZISMOQ6IS53HM552DMYEIPRS
X-Message-ID-Hash: FUS6ZADQZISMOQ6IS53HM552DMYEIPRS
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FUS6ZADQZISMOQ6IS53HM552DMYEIPRS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

On 20.10.25 13:10, Jerome Forissier wrote:
> Hello Jan,
> 
> On 10/20/25 12:03, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This allows to run StMM without the userspace supplicant if the
>> in-kernel RPMB service is available.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  core/pta/device.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/core/pta/device.c b/core/pta/device.c
>> index 39ad3ddda..21c13bd94 100644
>> --- a/core/pta/device.c
>> +++ b/core/pta/device.c
>> @@ -67,8 +67,8 @@ static TEE_Result get_devices(uint32_t types,
>>  		add_ta(ta->flags, &ta->uuid, buf, blen, &pos, rflags);
>>  
>>  	if (stmm_get_uuid())
>> -		add_ta(TA_FLAG_DEVICE_ENUM_SUPP, stmm_get_uuid(), buf, blen,
>> -		       &pos, rflags);
>> +		add_ta(TA_FLAG_DEVICE_ENUM_TEE_STORAGE_PRIVATE,
>> +		       stmm_get_uuid(), buf, blen, &pos, rflags);
>>  
>>  	if (IS_ENABLED(CFG_EARLY_TA))
>>  		for_each_early_ta(eta)
> 
> This looks OK to me. Would you mind posting this as a pull request on
> GitHub [1]? That's the normal way we deal with patched for OP-TEE.
> Thanks!
> 
> [1] https://github.com/OP-TEE/optee_os/pulls
> 
> Regards,

Oh, sure!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
