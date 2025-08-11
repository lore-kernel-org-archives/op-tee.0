Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9417C87FDB
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 11:31:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DE0454FCC6
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754911914;
	bh=GOr3YaJ5QCoiT7kyZgVWMiYif9hvoH8OaDNFt+wSCbw=;
	h=To:Subject:Date:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=HgvFoQMxZvYpq9052aqu+mN3vl4AVLfdB4kTUL0NU2MsZInvOtZK3fG8Vs5enbMId
	 kHF4eK7tJblDjcQMv4XfvvG0+yOaKUHWL7b7L0e3ybUggvO69xsn2MX5Oyc2rHBPuo
	 FEddIBLaTDpg2zQJxsKCqETCa+9NsiW+8hyVDJnOg3K/oT6iEv7GAfaSapHzckv9fI
	 9NN0zwX0cM9eZUJ4h0arlptCUWQGc33lnd0Zn03oWorP86vb12HraEnJnFXVm4jVhQ
	 ihD2rczvltWZmR+td3YIfeJGcUwSXldgwqsdlJdtZnM3cCgdCkJgIpVRUWQYUjDhPt
	 RoVtIuN6Pv3RA==
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1684A3F379
	for <op-tee@lists.trustedfirmware.org>; Mon, 11 Aug 2025 11:31:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=P/tbGZQK;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kD+3hbVTswKY1m5HVF1P5A4vE17r/lDGGrXpAMq80+KquBGCbw5xg6qkRDNAbeZCsSu0LZR8H6hC1BQYxs7GWKkjM3sfDhzDxfKNfVfWq3h/1ARKZuUfvKJhaz5aoHkri92BBdxLoXIQ9d5XFPSMkQsJpbND3GXLPMcq24D5zyDJgvjP5yF/uWlBV+dcj6ckCvRZjyXRiAnnF1wHwwBztlpgIVXOe9O+Cd1Vpn8hahP9glsiDYpWi7U4xl2bdX7c//PZLIFqgUyRaNHB69lYo0VsCk36mz3nU5vonLjEGmuaF32FJm2atpTldF64sSqgYFwE9UcJmSBvmhw1JeB8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkbNw6cTGqp1+4kNmo/5buumR/5BOpcp/32w7x/a1wI=;
 b=NCemZqoQd5F6L2hyhDQul8hjJ/+a+Q0UhEIIO01WGsXzRg8o2zQmIIAW8GSnjmbJhkdpht/X08hgQeMnmoiLvOPsAvxsGH6eKIAGA2awXIb26zK3sgFWgxNPmZmw/340KkOaEP8073xfKdO6oxQX76wGR3IB0hCgM16ASOQ9NIcU0kpltLEhJCV9oBbt4vQj4tkGHpvbKB4maqZVWL2Kx4loMm7rIME+lv0I9SEztyB3mooL0w86CgG7ajOZsDpd9KpeDIS2sfh7ccAL6idzCtR9I+KP2bLrrNh3/lf/y8/toOFbEWH6QwuWZDre74MwNs+Bhu70wFsILgEI1bFRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkbNw6cTGqp1+4kNmo/5buumR/5BOpcp/32w7x/a1wI=;
 b=P/tbGZQKLoEIRczt8rmmlwmxtX2TxXv10To7vy3k1Qv+zeAvGNYJ9l6BfqtocqDFjs3sArDGLQu2VgkmiNKFB0GxbAdFqnGSD2CAO/miZ5Fm/TJFbSb3jctOPksmLYRttNaxHsfbEzgK9zLx/rbDiHBCcjgbeT9Jwtz4O9K9mqMpEaYyJm6TirGsQ8GqrvxoHuZdCDArwtdU4umOs4hM9njLy18rQG66oVsW8LfPhjOb7UV4McmwS7ft/2X/jgsdkkN0MqAvn+3QKaC7W8XlCH3nkw86Rwrmq4Xb9s4EB6Y7vOfcRj/2bSEibbjo3HU8YXW21v+l8PhPLy+aAbWx9A==
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 by DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 11:31:35 +0000
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a]) by SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a%3]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 11:31:35 +0000
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Thread-Topic: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Thread-Index: AQHcBs/od8WYF4SHx06Prusko333frRc94UAgABIFO2AAAxpgIAADL90
Date: Mon, 11 Aug 2025 11:31:35 +0000
Message-ID: 
 <SJ2PR12MB8689CB7106ECD0EDB2534208B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
References: 
 <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJmChHa_BxNO74cB@sumit-X1>
 <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJnJY5hV-Pul8QzN@sumit-X1>
In-Reply-To: <aJnJY5hV-Pul8QzN@sumit-X1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8689:EE_|DM6PR12MB4154:EE_
x-ms-office365-filtering-correlation-id: 3101314e-2190-4cf4-87d3-08ddd8caa104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?ZDIdH/+npONouCZuywuvnWaE8Cf3J6MzSA1RgUDN3pb5xYK3bmiTmXt1CK?=
 =?iso-8859-1?Q?1RORjKHipS2nk/vPAbutyi8RcuEAYrGC/4UoJV0dp6zf9P7Hh16fvcaO4F?=
 =?iso-8859-1?Q?xi0+VgkVN4aDz1x72ZWJQSCq0fK4iBWAmh/PaLONx+BHXP4YD5bizoEXnw?=
 =?iso-8859-1?Q?HucIbz+ye80LPR7e3rlPCUScEcBiuQqU3y/TSQD174pQMZbpj8i3/JKIe9?=
 =?iso-8859-1?Q?Mm5UvvpVcytwUtPkgSFxNgID+tcabNyCwgzhbX8V4QGjj3hCEewqXC+rmm?=
 =?iso-8859-1?Q?xEPhwXQKZaLwXoAPeU6W12s6pkEYQWk8e0GOMTI2i3beqK+70eiac/hIHS?=
 =?iso-8859-1?Q?DHhcMai2Jluh7aWmvRk5NdVcHObg76hoNhWaXAxmKmhOMr5O18uvfLD46W?=
 =?iso-8859-1?Q?CYKWYHIXdx2QCgEWzs9lDMQTFxXM+aG6d8xVTftZ/3fKcqYiKpMNImyAxj?=
 =?iso-8859-1?Q?S9fjsp8c4enVKYjuinMURQkpFRTHZqKhGb9BqksECL3sIDnTQhjzzijEJz?=
 =?iso-8859-1?Q?pwsqN+0BBLYoh3bROa/Q8xsmY++G9e1Jga0TlSH6vyDnabD3nZi+qOlP4/?=
 =?iso-8859-1?Q?ywUx+H80PntNLOrO8wn6b/pYIs8M0XktARRWavMbJc6BLi9Jty/SGXXwZC?=
 =?iso-8859-1?Q?FEoVPUBCR0Wr3BNdAQyzcNp+CKPEhS4BlIi3VW5SDuIJrVAruTA9J9nj1f?=
 =?iso-8859-1?Q?/Eg6NqLj7ykeNJRY0HODR1W/9glXLd4RhnetXpEWvio4njNKsmFBMR4WYd?=
 =?iso-8859-1?Q?it1VayMZ/UhEhn9nxg4+24bjPAT+uhEWD9So00CNDH8vrSLMOV5AH/nCuW?=
 =?iso-8859-1?Q?hemKCGdzdF4b3F2JQdPQ4+OMwxpMCXa0qzdk/kjmG200NMTNahskXolZVK?=
 =?iso-8859-1?Q?F49Nvgq8q3LhpTsBTMsMw7ZhNLApd1TNPkUzQv0MkHyc/7WLVQ41I1v5W9?=
 =?iso-8859-1?Q?L1NRFK3gEe3/U1BtwQMsZZSf1s6JrERLN6IR/UzfeYb4+ykkbvpjHren8m?=
 =?iso-8859-1?Q?PQ8A8PLnlm2WGQHNks4thDU2gvomfKvNhbQwFkKBz/edZuEeWMsasc4OKo?=
 =?iso-8859-1?Q?UqxWJ1z4BxuUqZ95QyFAd0D6EPylD6YKQkNHAR/jNVQ+JeJROylWT6ykjn?=
 =?iso-8859-1?Q?Z17yic4E7p2G4Du1tFDrEJQD4wiH7RMWePtu8zmHlYtgK46bd9tV6BM8p8?=
 =?iso-8859-1?Q?BBosg348Or+dqMUu9KuuGhUA/NiiwhaaEPrBihxctzKYybEhvvm27pc5Cd?=
 =?iso-8859-1?Q?CHxkqk9R2h8wq1MpDm6ifQRlSTVLjmFfligCJuICPUD/FNa3iQy5v+TUvE?=
 =?iso-8859-1?Q?iVH2gkZ314Kn8qelvAdGFQOudf0caSQK4mir51IfYOZZrMFrgE36bfipYQ?=
 =?iso-8859-1?Q?YZNtsVTw/t+lPtqP0moact/Fav1ahRi8SAgJP5VFaE2g2quFkWlYjqDZzu?=
 =?iso-8859-1?Q?hRjRnKxrpbMESf2K7JJJdqAA1gXw7if1M2rbWCdq8tyAoHXtF+/jMD0o+m?=
 =?iso-8859-1?Q?yd+e4Ia6Zf2RK1b336U9Q3fJL6zcuD9Ozgyk2keYMrgg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8689.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?8tsRGhgo+HJOXSyPUBRGgR3IRRuEGyvsOTRWwjABSq0pHS66Ta2yytcFZ7?=
 =?iso-8859-1?Q?P/xXeDwLk1mK1sfPjYDFQbULqUr27mJcPfZ+7mciaUV9qdlf7I8QNPF4Aq?=
 =?iso-8859-1?Q?nQvJFo7ks89VyoJkqdrw8CM1sclmTq50JNFO+XLUfyRqud/MpcgsBlw9eU?=
 =?iso-8859-1?Q?AIOPNMLexz6ws0rAyul6QGENS5/T8dIzpcnrL8whwi87Hu3YukcU9CsIr1?=
 =?iso-8859-1?Q?8qwQveDIGTId0mzKt9SuCTGtD/Fya2cGgYM8S/9zUBcJAx0SrZU+9sIrH+?=
 =?iso-8859-1?Q?TUM/MRvzig/A4P5bSG6/IaVeqgY+IhqlpAulXSl++PO4fmBYAI1hoO0e8M?=
 =?iso-8859-1?Q?/wtU0MoCL4vJ2gP13/9VxOHoUzW0T232Co0x6YZ4crK5PKfYedFtdCS53f?=
 =?iso-8859-1?Q?CWoLWDTwneHckEUjQWe/6GdytBs2BOm4p6FYwxKeLtFLzsJuGDXLPODF5b?=
 =?iso-8859-1?Q?1lk77qnHVa8REYRRtSR6zCWUDmykJxl27xAC3/OZqsRMQX6q4WYapm5Tqp?=
 =?iso-8859-1?Q?Ts9dzst18me1pA5cjb/BfOHVvtjsFpMGgOXi2SCelOgbM8fMRiy55AiHUl?=
 =?iso-8859-1?Q?ED82P4X7kQ0NwL15oMtfX1BBYjwjVR/cBW9mlUdkLTWQFM9h6jDhHz/wWo?=
 =?iso-8859-1?Q?QOGZVWmq6VPCtRjSfNiy38jk8bxrcF/1lVZq2KJeOZwbSbCsz65r23UWlj?=
 =?iso-8859-1?Q?gG1Wo2Nu8CscMybOMkuuIKb1lFuPX1gYmjVbrIGgM9YjONsVeAZ/w0dWvg?=
 =?iso-8859-1?Q?NLCW+ZWXEqKJGEdabkrYbfdR/XWgrdTixDhnwKlFP63HTsCAt2xKy5kPvh?=
 =?iso-8859-1?Q?xRaupGHjRRdklpk+ovhA6/neDhdRu7JETvhztkWbK8NG+bg5B/1aocJbOb?=
 =?iso-8859-1?Q?fwLNlwm5BnqrlYNMgI6LGhfiFxRFW+2VZNsEPJULL7dalFV2z/CXxHzIYa?=
 =?iso-8859-1?Q?/5St7jXuFX1QQ7AhfAPLYQ4vPAbIJhRUA2KW9RH3UaAkC+d2MPmkUDT/ry?=
 =?iso-8859-1?Q?4sstV7k5dDRE13CL1XVzOWpNkOKJ6+sNNnlIyqIISzR3Bk8stc37/V+MlP?=
 =?iso-8859-1?Q?S8zGHfyqqglkj1vyyLLS2tPi/xCJa5mx2HEcg5glWJkl8HgVsLboz6yTBg?=
 =?iso-8859-1?Q?M8vNdVsx+744VD7xmw4Xrhq+kilO2LAeEanfA1Or0ChwGAPZcSdBJJDOV5?=
 =?iso-8859-1?Q?9WuLQbGjPSP6iYxauPTYADc2blnYSJaMT58Pv7symPD9NWdd5jIh9QAj5M?=
 =?iso-8859-1?Q?h04NJ0K0Q/DfYODTljuL86HNx+/R9bM+BtSU8gM2fYkhiDK5mVOzGVxKSX?=
 =?iso-8859-1?Q?xZtz9mhLeJTYih2pYQaJQ3IleGYKS9qNNQnOz53HNU9zbGMJ2bJxM2EpEf?=
 =?iso-8859-1?Q?g1FMKPlEJYtTuEJp5JvqhIZekGbcULic5MNlc4j8kilMb8lN4RkGZ+FwuJ?=
 =?iso-8859-1?Q?KYQvOBVQ/Sx+CKpu9E81KlkNFGYgxxWhf5nWK8ZCvh8EIPByUm2aG6Snqw?=
 =?iso-8859-1?Q?Xx4GnGWXZPpDd6smEXwC0+PJCXyQ1X2+B03sbkDl7+WSbnoFyqYYkbq7lc?=
 =?iso-8859-1?Q?iDaTNj5OLsD/KmN8rnTJdNMArLshV7l+1DzTZPk3Hyi8dF12tSkdpyJ+ON?=
 =?iso-8859-1?Q?gjprLikdTRcJE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8689.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3101314e-2190-4cf4-87d3-08ddd8caa104
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 11:31:35.2517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xJRVoa1krxNtSzIen+rxHFthFUKSkkHyj94DOY/gjzwU+mMa89c1yrgUxKswM4NSAoqicM5OKV9hxURubU0/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154
X-Rspamd-Queue-Id: 1684A3F379
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DWL_DNSWL_LOW(-1.00)[Nvidia.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.237.62:from];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.237.62:from];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: PDCNN47U4KIQXRWWBSPYEBQWLTAU7IBS
X-Message-ID-Hash: PDCNN47U4KIQXRWWBSPYEBQWLTAU7IBS
X-MailFrom: sungbaey@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LMIREU53QUNT7DUHKYTMIM37KMKEOJLQ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sungbae Yoo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sungbae Yoo <sungbaey@nvidia.com>

Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()=0A=
because compatbile is a typo of compatible.=0A=
=0A=
Fixes: 4615e5a34b95 ("optee: add FF-A support")=0A=
Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>=0A=
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>=0A=
=0A=
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c=0A=
index f9ef7d94cebd..a963eed70c1d 100644=0A=
--- a/drivers/tee/optee/ffa_abi.c=0A=
+++ b/drivers/tee/optee/ffa_abi.c=0A=
@@ -657,7 +657,7 @@ static int optee_ffa_do_call_with_arg(struct tee_contex=
t *ctx,=0A=
  * with a matching configuration.=0A=
  */=0A=
=0A=
-static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,=0A=
+static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,=0A=
                                        const struct ffa_ops *ops)=0A=
 {=0A=
        const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;=0A=
@@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)=
=0A=
        ffa_ops =3D ffa_dev->ops;=0A=
        notif_ops =3D ffa_ops->notifier_ops;=0A=
=0A=
-       if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))=0A=
+       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))=0A=
                return -EINVAL;=0A=
=0A=
        if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,=0A=
--=0A=
2.34.1=0A=
