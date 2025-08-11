Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96DDCA0EC0
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 09:58:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EC08E4FCC5
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754906296;
	bh=r+WJBTUmBi3wWh94OlFaRTF2lXgz9Sh0FsgnQjxYUXQ=;
	h=To:Subject:Date:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=SDUFMgOB4UjnzNLZcFoaDMf+7tm/BZmWB8FtzCNqU5WWlZPZ1q0DdcJm9Mo5RMF29
	 utQD8f3wDUoLuETsn2ddxsEGabY7kV2G10oBnwQCAzVsy6i4twsGWbLKimH9PYjFNT
	 d1UjM3B/+ci1zJ7GTOQToaQgFP/5wUW6DqWtgpjEA/4TS4Qnw6ks0CV1o5JDyRNmOI
	 qNH2U6fbcra7Baqakw50d77UF+hjC6O9Q0GiXYhpUWLQFiqEHwnaxN84oRAW9mRAGa
	 PiNmJU76pt9SHRoRjZ7JDXUzvTCaw7kUSaYo0Yygyquju01zJvWq/ElaClcvwmRqu1
	 01yVyT0i1bGmw==
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1368C3F08F
	for <op-tee@lists.trustedfirmware.org>; Mon, 11 Aug 2025 09:58:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=qCAmMoZN;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cloPwjYwUF1OXBF0qOLvigaWwO6bsSvgFleD8EzfiQ0hSeRrFErsVzwZui+ot6aBDdgvtjUslpQAsWcGClEaOoLVz2DlAdY1WNkLgqE1jEnkycg924whZRVTQo2yS3VHHu9YeAlAYILHMxr+OvH69K9lLlu4X5//xhF04VTv1Xqb+kVxCi88rCKxpLTdRqAGD+1REyPFTFxPDd85Rurnf4DaG/Wjx+UR7OvrrbktGnne7xEqS7+yEYo8ryx8WbhZVCLoFG2WqJOdWtriJu9899cl1sTrgGIVoqCsaLmueTur4H3BSiZw7pJLxG2ABTNwWFiJuA95C1H3in2E1YVezQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwTg9nVIb1C/xfG3A3wpkRzya1EcS95rUdY+EYKKQP8=;
 b=t7VHYiqqkLkGHZvtmY//YAqSUj8/tYJN4u//+7PBVGx+NuXJ5Gs6ABqsYNhyG27cgxyfMGOGgZUncqbdFwvvnnn/0TepXzZj5BMfcHPeX0DtwIyQ7lk9pEF39nee+a3D/e3M53EGg90mQEdDrIHQDrssmDp/3BFzpfPooiBoHgbGpftEuENuVc3EojkM3n4L02I29zo0MPg2jk0OLqc9cmYUQ8bmpsA6erduYjglN4bc4vCsM+Nf+8S17qgppSMZcuS3ig/7NXT6aSffu5wdSNBGz+wbShWaDZre1Gb/ErFu05yNHGyb5DPdbzSnv53EQMeHPUVcMo/9mmz3j1yJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwTg9nVIb1C/xfG3A3wpkRzya1EcS95rUdY+EYKKQP8=;
 b=qCAmMoZN3zJnTnp924SsBAuUaGn7mwLDmbNphZRkT4e0bwJ9qDypk1l6apLl65k5ASGgFmho2cT2ZDFINbnBRZcydEAoYRBLBx05PENnfFbTU/uDtKevDbtnyT9sei9bizeOUUQeVfj4thBL8VUCwuKp0wPX9s/EdlCc8MWV40KvzK/I3cnlF+GljNKqa2/USHmsAvZbrWqVJpZKFS0+RDj/it6G6Az3UehfqcSaowSPbIXm6oY7j79xemmLY+ONoQfoHrQVPrDI/bJ4WbkPtI9TyHUSC0SM1ZUM7E1ez9ujz4s5C8G6DjxqHKx8lEM2bWaR34ETzcIly4yWHK6Hog==
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 11 Aug
 2025 09:57:55 +0000
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a]) by SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a%3]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 09:57:54 +0000
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Thread-Topic: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Thread-Index: AQHcBs/od8WYF4SHx06Prusko333frRc94UAgABHQNM=
Date: Mon, 11 Aug 2025 09:57:54 +0000
Message-ID: 
 <SJ2PR12MB8689638595F93CC5CC23C94EB828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
References: 
 <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJmChHa_BxNO74cB@sumit-X1>
In-Reply-To: <aJmChHa_BxNO74cB@sumit-X1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8689:EE_|SJ5PPFF6E64BC2C:EE_
x-ms-office365-filtering-correlation-id: d3d7372e-1ae4-4a6e-90da-08ddd8bd8acb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?UfgkqVMGI08A4eN2el8k2rQ+Bjvn9Qg9EVKcwWj6YoYasqzeEY6jozg2C2?=
 =?iso-8859-1?Q?Ii3JxjQU+v5u8oKtzMVC5nS7rXp0u8jNLWKhuOqt+WKqlOrUPL9gwlo8C4?=
 =?iso-8859-1?Q?mazKfoTyd22oaPidHYkZIG2sC/SL1UCiBCj4vOWv0V3iuUCYTPpZodPj3g?=
 =?iso-8859-1?Q?xklCYXrlZlfSfRBCCIsO2jBwYntlEwDAOvQ8oTN2ym8iq+4pdFntwsVSrn?=
 =?iso-8859-1?Q?4Ob+GSmslnXWCAmCE1j7UHpgCb5PvzlRlvYfbMuo/xx9dentrZG9zj59fE?=
 =?iso-8859-1?Q?XkRQ1fCKNdCheSOu+xkxuAsYTLXpYfHIhM3tjjP1rGqBkUAVqmk8yuNcod?=
 =?iso-8859-1?Q?/TqBDiS2SDqClE94PqHeT4hCoIVk3W8QFOnXPS8rfIldZK6/Dr/0Tb6Kny?=
 =?iso-8859-1?Q?vPmF/58jYzH632RqiVVqoRAyhKz5iBJFIYELJBIuCUsPKSXctTToJ/GXbl?=
 =?iso-8859-1?Q?ZUMdJ6IeI1RXbry7jYyUHL0XDMuI5LQZ7h2hcXnKtzf+EOiiclB++Zt3cT?=
 =?iso-8859-1?Q?hOPpjUVkWmo5W0To5TFBGF/SIkO+tjgvS25FGICG+Q+ZavSphXhPTpb4Q6?=
 =?iso-8859-1?Q?4Ca4TAtk7taYWAYtrPL0Dt45/5/73saAsE3wdaOUalyx3WNQtSvJ9qGpPZ?=
 =?iso-8859-1?Q?0u0y6Bw0iyOSVadAc55crsdG6i0LBx/Iv4WnV7glzOwO6uC4Z0eeglrCHg?=
 =?iso-8859-1?Q?M+nSxke65npU4Tpol3xJUAbPPn7mdO2KMc5t2aRA43KUksODob4QUlL0ry?=
 =?iso-8859-1?Q?iRQVtU84jkniABXN08xqxYPK48WEkK/bBa2UGLEnHXzf5GhXxR4BRabV8X?=
 =?iso-8859-1?Q?Y9xoMeEugu7JUsT5rveAbM4la8nzFdDjqBd+nImAUyFHkc0MpMXSTFW8l4?=
 =?iso-8859-1?Q?ydtlIyLt2+6F4UJMVkKkYJBAiy0aSzLRHBIKeT12uz328NC/6YfY5uh+mm?=
 =?iso-8859-1?Q?JpVFhBrnhh/zAVWv7su4Jks6Xh+v70G3qrBvawyt+bSgVqDhN0WFigl3Oj?=
 =?iso-8859-1?Q?CIbDRsFK7794AO/MWVxQNxTcEPGTA8D80uhIth492m/R5LQyF+02YqqHnf?=
 =?iso-8859-1?Q?YKQARVZja1W+tGK6yVFrkcciyGPTtaQZJvA4TjnK2nAFnq3JleHfI84K6h?=
 =?iso-8859-1?Q?wx3/s1CXv6ZNUYxnmeYuoVo4gE12E8lqqOtvFKXd53HrJVekFCSc/LhdNV?=
 =?iso-8859-1?Q?a4WKxVfzGSktloE2ZPe4r/A2Otvd/aWGbaJaPlrS6NVq+DHDNiE5QWdKIa?=
 =?iso-8859-1?Q?SctOFF3fFdllvob08RIHWYg18e61CoR4CfO6rx8rHmTdBynPghn79Ad0z1?=
 =?iso-8859-1?Q?7kikMh+VgR9daUqE1m3oHk3o/fcf753uQL/RgLC8fK26y3DwYlb+cPkehb?=
 =?iso-8859-1?Q?/SyVHUunA6TMXoO2nWbvroDnFGVePiX3E6sd6jEK+l4VdM5z5M7LkdCkBt?=
 =?iso-8859-1?Q?ICnX4kaUS62yQceLkJtuEVgM4tRloFu/gJZVSZf9zg1I93b2+iuJF3kT8R?=
 =?iso-8859-1?Q?E2bp1t3ojtzmRF6xlyU9VmMW+e5Haso4NOvr4CdV9TXA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8689.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ilJtH6/Z2rkfvpyypMatDRHX6rjQoqUrIU8ZNjY4tGJPPPLjlKzROAjip1?=
 =?iso-8859-1?Q?yJHVoajARCeJZCw2DiIdy3OjP+OGgn26CO/1nWylb9q9AQCy5YVbI+cqg4?=
 =?iso-8859-1?Q?k7yyj7BAK9Gjx4XW47LNQtFqlgpYM25Hw+mzeBnhXOExlDjciClYrXahCP?=
 =?iso-8859-1?Q?wwnPS/BZ0dohNILJojaCxjn4sUfIA6S8KO2nbvOgaDeWrSbQmsv0UyC0qJ?=
 =?iso-8859-1?Q?pwl4s5M0wqWAxqVT0fGXPI/FcbvBI4755ZXH587Jm4ZlZxOyw/vt3K+9lZ?=
 =?iso-8859-1?Q?TA7DyKWa2vFlbXGY8eZ3CQdwnOA4yCMJi5UXWXlNtK3WCC/T3WAqZj3tPP?=
 =?iso-8859-1?Q?odauhS6roSO3udhsdHcHR/Y7kWPz+qRLaK2MY2w0Y3REiNp42mfp3RzDBN?=
 =?iso-8859-1?Q?R5pzonoFJNncKt3bfdpV6u1/Ft1t3hmGLT74wIjZwToX0mEuA54XgoiKNV?=
 =?iso-8859-1?Q?caIoUAAui3O0ixlZYPn9TKX2HJrN/NGXLdftbXHC4ffk3R5fB5Dl2LWcgg?=
 =?iso-8859-1?Q?etVptoXuovC0fKiGt1k+kisM0TGmQxn/otbLfS8n0jTUMPzzcnbaIX0a/K?=
 =?iso-8859-1?Q?l28wf2zr+IeG2ThqSvZlF/phoJ2eLVVKHxHFF5FjsWYByMG9ErmI32gvb2?=
 =?iso-8859-1?Q?3bZfhbW5ByJAlrV+TpMbDDLL2Un8Ej+tEfZmI31HJKgPYDiDoFq4YY+lnD?=
 =?iso-8859-1?Q?9UAq/xGCw4HqffYo4sOr8o9evRruI8mpagrKJj2PiUw7CiWoMtFEC/rwcK?=
 =?iso-8859-1?Q?ZlMeYQXuu8kHQgHm4hWwyhhsRfpf6geeyqhDejo5jv21ogGham4O8uAY7S?=
 =?iso-8859-1?Q?Ql3bPakoACl21EO8ea2RDtGqKk0APYO+XrfMFy7WoRgN97/xFxR8Z/gmaG?=
 =?iso-8859-1?Q?pm6J/GADzePypGrhoH7M/AFfTtI9ORfbJCf/L6sqgAxN4afF1/hlqsE7xM?=
 =?iso-8859-1?Q?BYelFlyGo0cZhG5TcNt/4d0UAVptkKb3mY1x/zayjx69tIZlf/fXEAYkbf?=
 =?iso-8859-1?Q?ZO9c4rW04FLenaJeZ83SJkltBKtCkJGZEm7ER8i/nBTWYH/FncZ0FGWcm4?=
 =?iso-8859-1?Q?VAap6SDb8YvdqTxTlZU6JeDsEIWOJddcqxNyW5GjhGsoZbSvEsT8mPpLlw?=
 =?iso-8859-1?Q?otGeMjBxo21eNPbPMADGvd+OjKuk73ntbO4E+UaxvwsEdSDaHizXeYAQEK?=
 =?iso-8859-1?Q?0TPUsN4nCHJ3zl9jyca36b0R+80p7AMqt+KVOtPOJmpuNZm15t+OYLVjq5?=
 =?iso-8859-1?Q?cFWqdJzGq/mPxLkvvQKQLoVPkWZOPY3f0eCnetmp3q8Aj0l7098Ib4w0YI?=
 =?iso-8859-1?Q?1XY/jdiFzD0GWAeRiAz4m3LgQ504yA3xgdVO1Mrj+WwWz7uzhfgZDtYrIs?=
 =?iso-8859-1?Q?t6IgfvU7fi2+bikVawTkgGszMd/+49/zN1pMfqdXWwycStQr7V+3i+JWs+?=
 =?iso-8859-1?Q?d5eZ1++V9AuNDk6qBBN/JW9JAoPLR94LWPnsmnYBEvFgi38dEkRxPUMlv+?=
 =?iso-8859-1?Q?BrEmR79d5VF8+TByuTyJuzPUBWP4KT1OEWoYmw/LLevdb+C3V6QsgrZuQY?=
 =?iso-8859-1?Q?PXZ5jmhIcmTQk4NZpHb8uhHdCXdELw93j/rKfy6Sgcuz4V+FJyB9eTfrN/?=
 =?iso-8859-1?Q?1D9hlp1+SZAzM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8689.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d7372e-1ae4-4a6e-90da-08ddd8bd8acb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 09:57:54.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJMe/GOZXz0Edw7e6az5+0Iuh2AJdzvdXP/2gxLPLwp5sgp+OAsP5FTOuJmZLyFJOoiK3NqUWJ1rziC+lwGeDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF6E64BC2C
X-Rspamd-Queue-Id: 1368C3F08F
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCVD_IN_DNSWL_NONE(0.00)[40.107.100.83:from];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.100.83:from];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: NRKFYUQUZPKFPEMMIATH3RJTSKVKAQDY
X-Message-ID-Hash: NRKFYUQUZPKFPEMMIATH3RJTSKVKAQDY
X-MailFrom: sungbaey@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZMEH7RZVAWOZT6V3MSPK7G7GMBD5UGDE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sungbae Yoo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sungbae Yoo <sungbaey@nvidia.com>

On Mon, Aug 11, 2025 at 11:11:24AM +0530, Sumit Garg via OP-TEE wrote:=0A=
> On Wed, Aug 06, 2025 at 12:47:35PM +0000, Sungbae Yoo wrote:=0A=
>=0A=
> Add some commit description.=0A=
=0A=
Will add the commit description like this :=0A=
=0A=
Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()=0A=
because compatbile is a typo of compatible.=0A=
=0A=
>=0A=
> > Fix: commit 4615e5a34b95 ("optee: add FF-A support")=0A=
>=0A=
> Correct fixes tag, should be instead:=0A=
>=0A=
> Fixes: 4615e5a34b95 ("optee: add FF-A support")=0A=
=0A=
Thank you for correcting this!=0A=
=0A=
>=0A=
> -Sumit=0A=
>=0A=
> > Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>=0A=
> >=0A=
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c=
=0A=
> > index f9ef7d94cebd..a963eed70c1d 100644=0A=
> > --- a/drivers/tee/optee/ffa_abi.c=0A=
> > +++ b/drivers/tee/optee/ffa_abi.c=0A=
> > @@ -657,7 +657,7 @@ static int optee_ffa_do_call_with_arg(struct tee_co=
ntext *ctx,=0A=
> >   * with a matching configuration.=0A=
> >   */=0A=
> >=0A=
> > -static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,=0A=
> > +static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,=0A=
> >                                         const struct ffa_ops *ops)=0A=
> >  {=0A=
> >         const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;=0A=
> > @@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_d=
ev)=0A=
> >         ffa_ops =3D ffa_dev->ops;=0A=
> >         notif_ops =3D ffa_ops->notifier_ops;=0A=
> >=0A=
> > -       if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))=0A=
> > +       if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))=0A=
> >                 return -EINVAL;=0A=
> >=0A=
> >         if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,=0A=
> > --=0A=
> > 2.34.1=0A=
