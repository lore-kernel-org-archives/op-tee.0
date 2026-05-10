Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3B0CD3427
	for <op-tee@archiver.kernel.org>; Sun, 10 May 2026 20:42:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0B51A44DD4
	for <op-tee@archiver.kernel.org>; Sun, 10 May 2026 20:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1778445763;
	bh=MyjfEBZq5pH6KsKWeDB3zaIoAuFwjSJXxDWQY9C5GH4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OYyF2dYZXVARDasPoliXC6wBjser0b+bri9uX0L9XgxdrRQUAdkgR90fpnh7OSYTX
	 XtOs7cIqg4tk6qk/lN0lfsvsUhFPbtw1Crmj+Yrfzgf+8+ae0FWnm5C7dsaVKjubv6
	 j1gGHAZPMMAaG9qTGHFVG+hLUOKEnkod75FiFJdwLp+6AaWzknMGgDIDg1f/NDSpt7
	 MCM/CakG70F4Nkm0eDHeLTCf30GSqaXTEBk+7n0NQCNqQSKrHA+BT78M4UMPAjxUXk
	 oKs2/ifCY/aPvtnmuVrVtt9QsES9HbMlpZgsEN+9dLFaTuFzIwPLJ6zkHzyan/IyPM
	 ps/l152mt79Rw==
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013053.outbound.protection.outlook.com [40.107.162.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EBE1743A70
	for <op-tee@lists.trustedfirmware.org>; Sun, 10 May 2026 20:42:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=PmU/sFH2;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKoIXTFHiWMruCKtXJZc6LbAw+yP3PqQfjZTGE7EqDlQlHU+Mb7+uiv7e/RCwJlmZ/cj0/2l4EF3bESJf6hCVYvZZY0D9L1lfg2tsMoonK+7/DtIScJn57UlrImTWJp76Iq8d0hReLCgbQlWs0o+ehxcdMEhexGc4C1nwVsXNKpH+C1ZCysyX12Es0HwuMMdEd0RXv7vhdbLzK7q6id2s2ZGPvJXDD3ijaFIMU6QcGVEIWQPu1JoOKUZ6eo2cIqCDz7MsdKo3m63otUWCehBOmr3dSzquGiRuoIyLYu0lnas5O+HmTGJakFHfMNqTbB2B4CUGWqRUIbN47VminovVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/SrZ/F2Ug/ECFt2Z5AQp7dBg1BRSFk5EpmMDNxPEIY=;
 b=VMPQm8KIjL9jVVil/5zy8fNSgAnuarQkBM0FuKL2DuPlrz1Byx/S7JwRcNSpkcn/ZiseFr9vYkOJD4SucRuZ3FH6hL8sW+R13o0nrxE8eRqE7DhwpMpbLplTXGnUi4J9S7pBhShlvPtVl195SI3Cp/xzxlkXphbwYyUgXvrILtjOpN5EA4gX1C0Hc5ENpB0/erImUOWH9Y1l4tIc+ooq8I9loybmv5EZeXLdMyDPSMPLpcQm/vtgvfVhd+wqaj7v5JA/QFrWyrQDDttEs0KIKcehPnEbDspgUmv5gIMgrcAa5CjHKAGYzlxwNa1flDBX/9ij9SDQivzyEJjZHQIWqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/SrZ/F2Ug/ECFt2Z5AQp7dBg1BRSFk5EpmMDNxPEIY=;
 b=PmU/sFH2S2mNYFiTyYntelwDmC9J8fFEIyX8f03oSoLnY+R4CaOxeBZpj2YOjJDli+ZngY4Vl0577f0ot7klOYraZK3I6CFdU6hL/0nVzfQpxjDddP8vE6hLK7zIgLf6+5A7eN9yze4OdMXTOPWLob2s5qAF9tVM75w4FyUuwjAa1c9E4/vNw3219/00KdSYcZKmcpnW87QYvOxq6C6/Hcli3ro6nFpeKzhHdtSHiPczDdWVkCI/nfzDShHdNUQUQBDoClGB2xwvAL2LOYIq8EjzgkEu4oNa+Rdv5TotjOb8kO3Gv0b5x/3aBr47WfeuzU+pEUcx5H3EUrN7BZfKFw==
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Sun, 10 May
 2026 20:42:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 20:42:31 +0000
Message-ID: <2d00dd26-9190-4e25-bda2-b2ac9bcd5180@siemens.com>
Date: Sun, 10 May 2026 22:42:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwrng: tpm: Do not enable by default
To: Jarkko Sakkinen <jarkko@kernel.org>,
 "Niedermayr, BENEDIKT" <benedikt.niedermayr@siemens.com>
References: <bbc41534-a2d9-42dc-ac8a-ff8a0b4fd41f@siemens.com>
 <aP_NN3HwO4Hp0-9T@kernel.org>
 <96df7b4d-cf1b-471d-9b4b-8741a80fbcc3@siemens.com>
 <af9QQah4QN5VD-4P@kernel.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <af9QQah4QN5VD-4P@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 79426654-cfdd-4ddc-54ee-08deaed4a803
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|55112099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: 
	l2r3xX9T8IWs+nq3LDhFvyp1ln/WVdz2JT4Z0DHU6/pBPkF/ZcXHaaoxaBl1BQXoeQWN0UY6tlsSaE6L5mu+bL9C9yWfPIeIfaCjojPSrwoAX4KJXQCuUvGRa2nWkpgGxtXy5DA6MOc04ZZqkGtJ+gy3HvohCs/S4Da9vKu1dTjYav02PAbH91Wfciaj67ccdAIP8gt0moX3Nex5Jjv6hcHtF6hQfS7AZZ42w7/00TByv6BCLamr7u9pWPoDIEZtr2FE01YlrymUreadqLeRqEU/oLHPFKYGT7/fD5pCdsSEeFDx1j1P4gq67t+pqlZuDomgtz5Pi93W09xrAjW0w6DGp8dfm3X8gAeLqN+sRyYQAlwFNe2WBon49KdRWZ661lF0sgvfPTCxdTaWiyu9JcaN+7IUBhL3vxOWSc0EexiQHYYu2AdSog7UJI5hTr3Tf41aisXIvOnHZfNe3CFlv4GxtEERQAUaDNskjoXx5y/8xQNVdei2mkhSVtfEysoM21kgu87pjnTDnaLvwPqkSyoUu0SDs4L65OygLJMQs2Aa2wtJ91+Ae4kLUOUykJkW3hPfZ/DlU9l75qFiU/nQrt95Gr3mA7MQ+LvGaRnP8qVO8jhHjjeV//7ETf2vLgPkn81yjXY6FvWgeWuUxEBHKw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(55112099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEVSbVRla3FobEJkM0NyZkpRQkZmQ05lYkFSZlQ5dUJkb1RQaTBwYzZtQjJv?=
 =?utf-8?B?VVdhRjBXQXlSRU1pci9kNGNoaEp6cEk4Nlo3d2VOZzZQQ1hROTU0N1B1QXpx?=
 =?utf-8?B?VFRYYXZtUUtIUEY0NHEycVlISHAxeWZoUUdNdGR0SUt3VWVBYWtZdzZramQ0?=
 =?utf-8?B?b2llRGRCUWtUWjRUU2tSUlRmd21rOUtOMUpBYWxqSGtFbFZveXV5UFBCSyti?=
 =?utf-8?B?UlFyNmUwY3JDRkRkY3F5Vll6eFI0VHRVdk1IbVdFUVpPOHhmRFNxUXFoU0Q4?=
 =?utf-8?B?ZjBwQXBxVE5kRHZzVUNNM0tuL2t4ZCsrRTRoT3c3MUxkNVB1UGt4YksweFE4?=
 =?utf-8?B?TURjeEJMV3licW1zd2h4NTY2S1dKdW1UdS9oRzl4L0Y5c2x3QzVJUXFBNU90?=
 =?utf-8?B?SGNJVFdtSmtaQ1NoM0VVcnZhVTh2STZyTjVBRWhpVXR5d1FLRmgyN0tqeTB0?=
 =?utf-8?B?cmRKWlVLZTEvUjRsSlBBTXl4cEh5N1BBbmFzTDJtaDc2eTlyS1htSjU4QWdn?=
 =?utf-8?B?QWpDNjlvUkVwd3Q5bnhkcHhuUndoZURYbXlUcXRtTHh4RlVJNnFmTlpzN2Jx?=
 =?utf-8?B?NDhsNUFXRDBQcy81a3ZHUW5LMGNWV1NGRm5SUkE0Q3NLc0U0cHNsWHc5c095?=
 =?utf-8?B?aGp2QUFIWGFFS2JERzlzWmhQdHY0b2oxTWhFQ05RWDIwekh5cFJUVTdBQ290?=
 =?utf-8?B?UFVwaXF3elljMm95UDBSbTFsaWNPdHpNNE5vcnU3c0psaXBSQnp1VzBzT25i?=
 =?utf-8?B?Tkp6NEtacjFDZjh0dWhGK3VjRWpURlRwRlFhRnBoVkxiNWkxSW5YWk9oeXhF?=
 =?utf-8?B?N2tpZXNTclFFdkJMcWpxYUhhOTlZMFZmdDF4UVhEUzVWWGV0aDRzR3RmTTdU?=
 =?utf-8?B?MjAwRXh3RlRzRmFQN0VEVElBTnlTdldCb0IrYURab09EUEhYK2FBQitiTXdZ?=
 =?utf-8?B?TkMxNHJFclVWaDR6Y1RZQVE4cHoyV0Q4Q1RyMzk1L2pac0Z2NTZ0bEFSRzdr?=
 =?utf-8?B?TUFsaGx0aXNwU3UwTnhPYnFFMndRWEdreklQbDZrRGZTTWlzcjZ3SUxtTEww?=
 =?utf-8?B?dXo1NTJDZXR3WGx3SVVpdTFER2xhajVmWWo3SEl2NCtuVGtLSHlGYTQzVXBr?=
 =?utf-8?B?R3JYMStvc2VZVFBHMGYvZDF6VEVvc2RTcVFEaXFnaW5Ebmo2TVN3d0ZuT3ZM?=
 =?utf-8?B?VU1WQ2cwUXVKVXpZWUxGVmU4ZkwxOFQ5Y2JVOEE5OU43eXVGa2dPMmFERzBE?=
 =?utf-8?B?VGZtZ2UxdVByUllBZzFLM0J0QTBUTHZLd0MzT0RUSlVTdkRyU3pCbFlCeTdw?=
 =?utf-8?B?ZFpzSHRUUnd0bllGTDZzcDlzd1AzZzJDOVNFTjlCM0lWcW1wNnZaN1lhVlc2?=
 =?utf-8?B?MTR3L3kyMjR6bWpSVVFwWi9lTk1PUnJkZE45S0tZUDBpNDJaTUI5MVBTc0hW?=
 =?utf-8?B?VHIrZENib0tuUDkzM3haQTd1VFZVUUJsdzlaUTEvRjV4Yk5qWDRjQ0ZDM3JF?=
 =?utf-8?B?bGZZcjVnUHZWVEdHQmRJckRURXU0VGszTjQ1WVJ5OVhGQVBFOGEwUkVUSEFT?=
 =?utf-8?B?aFE1QWlXaFVvdXV6ZVlJQlkvMDUrMVRGNWlCeUVOSFlpZXlOWHdCZ3pHS1l1?=
 =?utf-8?B?Y2tVeDlvOVhTa25YM1lkQjNYZDNQTy8zSkVTdWVZUERlTnJPZUVSL1pES09B?=
 =?utf-8?B?VkFGTnNzSndub2dPdm5OMngxWi9GaFZkWityWjYyMFJMRXpYcjFtZm1uREJ3?=
 =?utf-8?B?YkxOVGs5ZjVkaFVxNURhdW5sNFM5RVRQRFhOa2d6bEYrUDgyVW12bkt4S3I4?=
 =?utf-8?B?bkE2YVppQUJoS0taL3NFeXUrU2tJK0ZpQmpqeFpNZXFHUkZVdzQ2UmpKWmUw?=
 =?utf-8?B?NnJ0NWR4cysrQ2NKYXBQUm15MEozRXk1dW04UHJIb2RwdVBFWWRGN20rSjAr?=
 =?utf-8?B?SzFpZC9nYjFTTFd1RTlJMWVqTkJWTzNHMGQyWWpSWDBOL0M1ZlJWR1JyaTd4?=
 =?utf-8?B?alZldEwwTktsa1VXYXZ5cTc0d0JYeXFFQjNZb0x6THZhYllmZEN3TkhRR2dO?=
 =?utf-8?B?V042d3hoamtvQklNSFNsc3hlU0kyUXZoYW84d1AxaVBSdlI5OEZRZXJJNGFN?=
 =?utf-8?B?NDhoUXRYcGRreWI1a0hKR0Z2Z2lzOW5wYXdCakp0L25qcTBpNlBmbDNrY3Vu?=
 =?utf-8?B?N3JRREFEY2kyUmZ3bmNMMDBDUTVUVDl0dGQ4UHJKWWNNdUlpdnRQL3I0WG5j?=
 =?utf-8?B?WWs2YTlxK0tkNUlMaGJiaGF3ZUY1Q3I3eDRWUldCdnlEbkg4bVQzV05xUVpK?=
 =?utf-8?B?UC9ZSWhGL0Jad2dnbWdnb2ZRZ0hxcnRybzQxOEU4WFdqc2kycEpJdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79426654-cfdd-4ddc-54ee-08deaed4a803
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 20:42:30.9993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qw6WJUSVukcMJOIqae0djdBKQtdMW80jQgFwaG5bhneSRBPgcJ7H5661ghNa+LaqNNLjoLdDGYJmfbj0AH+Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[siemens.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[12];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.162.53:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	HAS_WP_URI(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,linaro.org,lists.trustedfirmware.org,siemens.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:588::19:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[siemens.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EBE1743A70
X-Spamd-Bar: ------
Message-ID-Hash: JZZ6W6NKRSJYPYOGVVLIUZRDJLCISIKR
X-Message-ID-Hash: JZZ6W6NKRSJYPYOGVVLIUZRDJLCISIKR
X-MailFrom: jan.kiszka@siemens.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Peter Huewe <peterhuewe@gmx.de>, "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "Bauer, Sven" <svenbauer@siemens.com>, "Zeschg, Thomas" <thomas.zeschg@siemens.com>, "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JZZ6W6NKRSJYPYOGVVLIUZRDJLCISIKR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jan Kiszka via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jan Kiszka <jan.kiszka@siemens.com>

T24gMDkuMDUuMjYgMTc6MTgsIEphcmtrbyBTYWtraW5lbiB3cm90ZToNCj4gT24gV2VkLCBBcHIg
MjksIDIwMjYgYXQgMDI6MzM6MjBQTSArMDAwMCwgTmllZGVybWF5ciwgQkVORURJS1Qgd3JvdGU6
DQo+PiBPbiAxMC8yNy8yNSAyMDo1MSwgSmFya2tvIFNha2tpbmVuIHdyb3RlOg0KPj4+IE9uIFR1
ZSwgT2N0IDIxLCAyMDI1IGF0IDAyOjQ2OjE1UE0gKzAyMDAsIEphbiBLaXN6a2Egd3JvdGU6DQo+
Pj4+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+Pj4+DQo+Pj4+
IEFzIHNlZW4gd2l0aCBvcHRlZV9mdHBtLCB3aGljaCB1c2VzIG1zLXRwbS0yMC1yZWYgWzFdLCBh
IFRQTSBtYXkgd3JpdGUNCj4+Pj4gdGhlIGN1cnJlbnQgdGltZSBlcG9jaCB0byBpdHMgTlYgc3Rv
cmFnZSBldmVyeSA0IHNlY29uZHMgaWYgdGhlcmUgYXJlDQo+Pj4+IGNvbW1hbmRzIHNlbnQgdG8g
aXQuIFRoZSA2MCBzZWNvbmRzIHBlcmlvZGljIHVwZGF0ZSBvZiB0aGUgZW50cm9weSBwb29sDQo+
Pj4+IHRoYXQgdGhlIGh3cm5nIGt0aHJlYWQgZG9lcyB0cmlnZ2VycyB0aGlzLCBjYXVzaW5nIGFi
b3V0IDQgd3JpdGVzIHBlcg0KPj4+PiByZXF1ZXN0cy4gTWFrZXMgMiBtaWxsaW9ucyBwZXIgeWVh
ciBmb3IgYSAyNC83IGRldmljZSwgYW5kIHRoYXQgaXMgYSBsb3QNCj4+Pj4gZm9yIGl0cyBiYWNr
aW5nIE5WIHN0b3JhZ2UuDQo+Pj4+DQo+Pj4+IEl0IGlzIHRoZXJlZm9yZSBiZXR0ZXIgdG8gbWFr
ZSB0aGUgdXNlciBpbnRlbnRpb25hbGx5IGVuYWJsZSB0aGlzLA0KPj4+PiBwcm92aWRpbmcgYSBj
aGFuY2UgdG8gcmVhZCB0aGUgd2FybmluZy4NCj4+Pj4NCj4+Pj4gWzFdIGh0dHBzOi8vZ2l0aHVi
LmNvbS9NaWNyb3NvZnQvbXMtdHBtLTIwLXJlZg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBK
YW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPj4+DQo+Pj4gTG9va2luZyBhdCBE
UkJHXyogZnJvbSBbMV0gSSBkb24ndCBzZWUgYW55dGhpbmcgeW91IGRlc2NyaWJlLiBJZiBPUFRF
RQ0KPj4+IHdyaXRlcyBOVlJBTSwgIHRoZW4gdGhlIGltcGxlbWVudGF0aW9uIGlzIGJyb2tlbi4N
Cj4+Pg0KPj4+IEFsc28gQUZBSUssIGl0IGlzIHByZS1zZWVkZWQgcGVyIHBvd2VyIGN5Y2xlLiBU
aGVyZSdzIG5vdGhpbmcgdGhhdCBldmVuDQo+Pj4gZGlzdGFudGx5IHJlbGF0ZXMgb24gdXNpbmcg
TlZSQU0uDQo+Pj4NCj4+PiBbMV0gaHR0cHM6Ly90cnVzdGVkY29tcHV0aW5nZ3JvdXAub3JnL3dw
LWNvbnRlbnQvdXBsb2Fkcy9UUE0tMi4wLTEuODMtUGFydC00LVN1cHBvcnRpbmctUm91dGluZXMt
Q29kZS5wZGYNCj4+DQo+PiBIaSBhbGwsDQo+Pg0KPj4gd2UgcmVjZW50bHkgYWxzbyBzdHVtYmxl
ZCBvdmVyIHRoaXMgaXNzdWUgd2hpY2ggbGVkIG1lIGhlcmUgdG8gdGhpcyANCj4+IHRocmVhZCBh
bmQgbWF5YmUgYWRkaW5nIG91ciBvYnNlcnZhdGlvbnMgaGVscHMgdG8gY2xhcmlmeSB0aGluZ3Mg
aGVyZSBhIA0KPj4gYml0IChob3BlZnVsbHkpIG9yIGF0IGxlYXN0IGF1Z21lbnRzIHRoZSBpbmZv
cm1hdGlvbiByZWxhdGVkIHRvIGZpcm13YXJlIA0KPj4gVFBNIGJhc2VkIGltcGxlbWVudGF0aW9u
IGJhc2VkIG9uIG1zLXRwbS0yMC1yZWYuDQo+Pg0KPj4gQmFzZWQgb24gdGhlIG9wdGVlX2Z0cG0g
cmVwbywgYXMgSmFuIGFscmVhZHkgZGVzY3JpYmVkLCB3aGljaCBjdXJyZW50bHkgDQo+PiByZWZl
cmVuY2VzIGNvbW1pdCA5OGI2MGE0NGFiYTcgb2YgWzFdIHN1ZmZlcnMgdGhpcyBleGFjdCBpc3N1
ZSBiZWNhdXNlIA0KPj4gb2YgdGhlIE5WX0NMT0NLX1VQREFURV9JTlRFUlZBTCBbMl0gd2hpY2gg
aXMgc2V0IHRvICIxMiIgYW5kIGlzc3VlcyBhIA0KPj4gd3JpdGUgZm9yIGVhY2ggY29tbWFuZCBh
ZnRlciB+NCBzZWNvbmRzIGhhdmUgcGFzc2VkLg0KPj4NCj4+IFRoaXMgY29uZmlnIGhhcyBiZWVu
IGNoYW5nZWQgdG8gIjIyIiAob24gY3VycmVudCBtYXN0ZXIgYnJhbmNoIFszXSkgDQo+PiB3aGlj
aCBpcyB0aGUgYWxsb3dlZCBtYXhpbXVtIHdoZW4gZm9sbG93aW5nIHRoZSBUUE0gc3BlYyAoY2hh
cHRlciAzNi4zLjIgDQo+PiBpbiBbNF0pIHdoaWNoIGxlYWRzIHRvIHJvdW5kIGFib3V0IDcwIG1p
bnV0ZXMsIGJ1dCBvcHRlZV9mdHBtIGRpZG4ndCANCj4+IG1vdmUgYWhlYWQgdG8gdGhpcyBjb21t
aXQsIHlldC4NCj4+IFRoaXMgY29uZmlnIGV4aXN0cyBmb3IgYmVpbmcgYWJsZSB0byBhZGFwdCB0
aGUgd3JpdGUgY3ljbGVzIHRvIHRoZSANCj4+IHNwZWNpZmljIHdlYXIgY29uZGl0aW9ucyBvZiB0
aGUgaGFyZHdhcmUuDQo+Pg0KPj4gTW9yZW92ZXIgdGhlIG1zLXRwbS0yMC1yZWYgcmVwbyBzZWVt
cyB0byBub3QgYmUgbWFpbnRhaW5lZCBhbnltb3JlIGFuZCANCj4+IG9uZSBzaG91bGQgcmF0aGVy
IHN3aXRjaCB0byBbNl0uDQo+Pg0KPj4gU28gdGhlcmUgYXJlIGN1cnJlbnRseSBmaXJtd2FyZSBU
UE0gaW1wbGVtZW50YXRpb25zIG91dCB0aGVyZSB0aGF0IGxlYWQgDQo+PiB0byB0aGVzZSBmcmVx
dWVudCB3cml0ZXMuDQo+IA0KPiBSZWFsbHkgdGhpcyB3b3VsZCBuZWVkIGEgcHJvZHVjdCBhbmQg
b2ZmaWNpYWwgYnVnIGJ1bGxldGluIGZvciBpdCB0bw0KPiBldmVuIGNvbnNpZGVyIGEgd29ya2Fy
b3VuZC4gU3BlY3VsYXRpb24gZG9lcyBub3QgY291bnQuDQo+IA0KDQpUaGUga2V5IHBvaW50IEJl
bmVkaWt0IHRyaWVzIHRvIG1ha2UgaGVyZSBpcyB0aGF0IHRoZSBUUE0gMiBzcGVjIGZvcmNlcw0K
YW55IHZlbmRvciB0byBkbyBzb21ldGhpbmcgYWJvdXQgcGVyc2lzdGluZyB0aGUgbGFzdCBzZWVu
IHRpbWUgYXQgbGVhc3QNCmV2ZXJ5IDcwIG1pbi4gSWYgdGhleSBkaWRuJ3QgZG8gdGhhdCwgdGhl
biB0aGV5IHdvdWxkIHZpb2xhdGUgdGhlIHNwYWNlDQotIGFyZ3VhYmx5IGEgYnVnLiBCdXQsIGNv
cnJlY3QsIGl0IGRvZXMgbm90IHRlbGwgdXMgYW55dGhpbmcgYWJvdXQgaG93DQp0aGlzIGhhcHBl
bnMgaW4gYSByYW5kb20gZmlybXdhcmUgVFBNIGltcGxlbWVudGF0aW9uLg0KDQo+Pg0KPj4gQUZB
SUsgc2luY2UgdGhlIHRwbS0yMC1yZWYgaW1wbGVtZW50YXRpb24gYmFzaWNhbGx5IG9ubHkgc3Vw
cG9ydHMgYSBmaWxlIA0KPj4gb24gZGlzayBvciBSQU0gYmFja2luZyBzdG9yYWdlLCB0aGUgb3B0
ZWVfZnRwbSByZXBvIFs1XSBwcm92aWRlcyBpdCdzIA0KPj4gb3duIF9wbGF0X05WKiBpbXBsZW1l
bnRhdGlvbnMgdGhhdCByZXBsYWNlIHRoZSBkZWZhdWx0IG9uZXMgYW5kIGZpbmFsbHkgDQo+PiBj
YWxsIE9QLVRFRSdzIFRFRV8qIHNlY3VyZSBzdG9yYWdlIEFQSSwgd2hpY2ggdGhlbiByb3V0ZXMg
dG8gd2hhdGV2ZXIgDQo+PiBiYWNrZW5kIE9QLVRFRSBpcyBjb25maWd1cmVkIHdpdGggKFJFRS1G
UyBvciBSUE1CKSDigJMgSW4gb3VyIGNhc2UgdGhlIFJQTUIuDQo+Pg0KPj4gQmVjYXVzZSB0aGVy
ZSBhcmUgY3VycmVudGx5IGltcGxlbWVudGF0aW9ucyBvdXQgdGhlcmUgKGUuZy4gc3RhcnQgdXNp
bmcgDQo+PiBvcHRlZV9mdHBtKSBpdCBtYXkgbWFrZSBzZW5zZSB0byBhZGQgdGhpcyBpbmZvcm1h
dGlvbiB0byB0aGUga2VybmVsIA0KPj4gY29uZmlnJ3MgaGVscCB0ZXh0IGF0IGxlYXN0Pw0KPiAN
Cj4gWW91ciBmaXJzdCBmb3J1bSB0byByZXBvcnQgc3VjaCBpc3N1ZXMgaXMgdGhlIFRQTSB2ZW5k
b3IuDQoNCkkgd291bGQgc3RpbGwgbm90IHJlY29tbWVuZCBhbnlvbmUgcmVseWluZyBvbiBhIGZp
cm13YXJlIFRQTSB0byB0dXJuIG9uDQpDT05GSUdfSFdfUkFORE9NX1RQTSBpZiB0aGVyZSBhcmUg
dmlhYmxlIGFsdGVybmF0aXZlcy4gSW4gY2FzZSBvZiB0aGUNCm9wZW4gc291cmNlIHN0YWNrIHdp
dGggb3B0ZWVfb3MgKyBvcHRlZV9mdHBtLCB3ZSBrbm93IHRoYXQgYXQgbGVhc3Qgb25lDQpleGlz
dHM6IENPTkZJR19IV19SQU5ET01fT1BURUUuDQoNClNvLCBpZiB0aGVyZSBpcyBubyBnb29kIHBs
YWNlIHRvIGRvY3VtZW50IHRoaXMgaW4gdGhlIGtlcm5lbCwgbWF5YmUgaXQNCmlzIHdvcnRoIHRv
IGRvY3VtZW50IGl0IGluIG9wdGVlX2Z0cG0gaW5zdGVhZC4NCg0KSmFuDQoNCi0tIA0KU2llbWVu
cyBBRywgRm91bmRhdGlvbmFsIFRlY2hub2xvZ2llcw0KTGludXggRXhwZXJ0IENlbnRlcg0K
