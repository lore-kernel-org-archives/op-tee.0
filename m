Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F3DC87FD3
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 12:48:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6D24F45A9F
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 12:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754484483;
	bh=w8qSFScPLlw8BmNtenX2t5acQWgbdX7tIwIpeDaxuEs=;
	h=To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=G020VkEDWfN/6ZzIQkUTmBGxjB+4ZD19ILWlM80V0AqpXkAkO0CBNGN1ROMP730KW
	 tmn4iY2cqdMlniaTcYmaH2Si27XASoJfmdLC8qLJX0b3a/VsR0xxgm6Fy/mjA2z2ey
	 a7UTGUdlXONMOR++mIMJp7b1JDG22KsuJYqAFhSqbgTjAMVHoDwiXTwmg/ZOS1Gc1g
	 mGZY6R5EP1UMmBn1kFdPucCQfqYwPzoObAF66pTOudExzNt2KUqL/hLlj1+90xLC0V
	 ezpVm38mEj3HlvtnQL6Ajsfd6zgD49sHeURhg2g6lKWAh/XmFtBlr8x6Z+EpNYr0MM
	 1AdFcO1CFnuJA==
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3421F42F12
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 Aug 2025 12:47:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=h26gTNmR;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8WHP1+Zzg3kExqla39PsD4nJmvUqc9Rf1V459Z51U1ClmvrBViLxdPYlVRUV2geuhZIr2fw/kK3qFKPD9SAEHuiYQLgNjYfJZkkHR1kCg4I1c2BAEXCENGCJjjDKO+UVSB1j69370nWPBJSFEZmFyDwZnulzD+S6kijGFcVPEzcKAetuyfnlhOTd+20tOujTKpD+lTqFT5HdseU2kQUMvAX3Nktbj47/QcZnEJUykzCxgwBeP6ghuuv2YKhjFtDBFQ8/+cZYclGSWAgCAEZK3eTKazMZZX3hXDYXg9bHDm8CEbdCRi+TZNWb96PZju4uh5NpTjVjFR1+LgHrDCmuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ7vXon/9WJB/VoBPPyTp09ajzNu0N5iUolUs9wQAmw=;
 b=AWwSFKa6uMrtrOgV5n2OzwjDAtnovvt9fzJcbtIkaBvRkTBqGhGJznVFbVAkah6RjQ7ulwRBTTHc2jaSX90UkPOuSMksyO1TltyU8o2bh2KD8pxZ7rZGAx8GtBmQK29AvC9Wb/5OTCoy0G3D0j5WhJ8xwdwiHWa6SGwCcsrPWz1xfiiATcRO7BfhW9UTB15Wdx7PIGnaXefFnwrj6JC7us3HfURkx0YT3WTy0vPCTYStf50u0WiBRm5iAAD98ZL7cpgxbnFk//NzcL20+e0wBirAh6cP1vZRrxIHPTeSMocTZGbcKoRO48uaLFUP9F6Q2tc0IOB4CVmAI1yDiYXwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ7vXon/9WJB/VoBPPyTp09ajzNu0N5iUolUs9wQAmw=;
 b=h26gTNmRpKYFfqVIQgk/0oYRAFvCAHFyeEfGAS0FbkJEWplYIZKzEJV7Doi1DlE6wc9aW76iS5JmebmNFneZ4APEV4kR0CwDYU8yyDwM6e/pmyHAz8TpEA7DGYz16qK+tH5xZ2+hNRQ5mHOqKnrIWWE7BfefIbrOMUlTVDTXQEGcePyTjlFOC6GxjVbAJGWiYEP8Fk4gkQB1/gNXVYBHWLcY01X53NiDkZJK9VSSHfEhH57pHhw0ehKArsAm2YKRqdhnu8ocSpbeNY62+Vo/DjJ3tQzp6X4p4/k6MUF3j7wsyIwAdJcOkLVoRg6sHLPq9vLvTLv06X4VxCTZChUV9w==
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 12:47:36 +0000
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a]) by SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a%3]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 12:47:35 +0000
To: Jens Wiklander <jens.wiklander@linaro.org>, Sumit Garg
	<sumit.garg@kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] tee: optee: ffa: fix a typo of "optee_ffa_api_is_compatible"
Thread-Topic: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Thread-Index: AQHcBs/od8WYF4SHx06Prusko333fg==
Date: Wed, 6 Aug 2025 12:47:35 +0000
Message-ID: 
 <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8689:EE_|SA3PR12MB8764:EE_
x-ms-office365-filtering-correlation-id: 88b320cd-d5dd-48d3-8b31-08ddd4e76b02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?/R5fEdF4qVYOvmh7tAG5A03SKZw8KfqhWXyesNc2RsbJxg0Z2e7qaBAEg1?=
 =?iso-8859-1?Q?+syzUXM9qi8rzYyCiUggs1Dap+XKoz6NKELWdXL9mn48ILvOOSHKXHNmpl?=
 =?iso-8859-1?Q?xzfracVDYIvLHba27aPs/TupAYr8843P69lnEA90no8hcaWcTZNHfl4ugG?=
 =?iso-8859-1?Q?WRJ1mM6NMK+XNrb9finOircEQLbVmO+D95A5+jJzYPIkg82L726sVTnQ9z?=
 =?iso-8859-1?Q?DS7X+VKReNY1piod4+yFpOeqQCDWka8vDr0WDgDFHG7DNbbrTcjxnyydgE?=
 =?iso-8859-1?Q?NS7bx83tcT35nw/YP8h8rxoAPWb+coc796vOGWDAvoWnipCjTx/68zMnwV?=
 =?iso-8859-1?Q?dPRKYpAnL5Jbkc40WvspWxiu0bjBz4SDKBCnwtw4gHlFC6WReMSElHk5rs?=
 =?iso-8859-1?Q?eyPBl2HG82xxPnPrpwDYh06UYfnWqcQHdtBLDHSkbvtzif3oMrFrTRKS3K?=
 =?iso-8859-1?Q?5cRj8p9lvq1mt7f96UejuFZBqHYpe8yssHkHu6JiyqrQjzHfBGdvR1AQ9y?=
 =?iso-8859-1?Q?WebosAEp4EdIT+h1CWHfW+7ZVKEkJw6eZqnGOCgH5UrhUDraN1aRs40wGv?=
 =?iso-8859-1?Q?QeTtbQdmOrlJpKCH/o+MMBZHKsuIC7rCin12YFRJxzZE3lwz54/Esm3nMf?=
 =?iso-8859-1?Q?eSjsC3LaMG2zmw57DQyybMgZ5YEZNVzn5SMh9r36jZcypRGaf7W9Bhxpuq?=
 =?iso-8859-1?Q?rC+dBKKkfcGn1ra2wfL6Mpq5S5NPlaN8qiOPXFcq3E/5cMI4QAIiuFvkM8?=
 =?iso-8859-1?Q?lL8/Z6IJjlwqZCA4WDwmZzfHrkrMIEEkB0jvohT+5mTD9fB4Fx2X0jpxC+?=
 =?iso-8859-1?Q?YugGMalDo+lpZ4qZUVsGzhvDJE4hZ5glHTwU/4Kg+XOFMSjLP1KAY6fJAj?=
 =?iso-8859-1?Q?33EQBrgK1x1NhXBxTpo4TpbF2CaMdXuTH3IbxjN3SdWKDMk+sEaGTkgcv5?=
 =?iso-8859-1?Q?6mGZ5bWNXW7P3Mjy/1+fjZNodQfLIy6Vy7s7IifpWfANduDUJYNn/8J77s?=
 =?iso-8859-1?Q?tocXdVBKvKOqQ0ssMaeB9MbEv6syKaayOdKM8Qz5t2Bmr+f4TQqQtRc9Z0?=
 =?iso-8859-1?Q?2fDpG34aKAwCEiOZPQFJ5cIsCfUcW40IkVT+cp+Tect52E9VSoLvnhL/lh?=
 =?iso-8859-1?Q?CpKTH+x5adiZwrKUn6HVacJ6osyvvva9JShTFaYuGyq6sx6h5onPu/Wp3F?=
 =?iso-8859-1?Q?G2VlkSEOJXIidpUFc4kSTNLBBh2G2kFP+8ROnKyZbAwwessuxtewBiFCjT?=
 =?iso-8859-1?Q?6l4RLy8boBI4LKHE7cc935xePK1Ty+O/P72CdoVcoSPWhBWL++gm57ay0L?=
 =?iso-8859-1?Q?VNodapmMILvjAwtGYvXCSZ4kqdKJCw8M/U3biz8aY8PCU+6Pb/BsplPWuK?=
 =?iso-8859-1?Q?o7exTPet5aQHPVq6jFGKM0F+6UuNOnW14YErwoHkZAYyalqY4gFuVgrrEd?=
 =?iso-8859-1?Q?BJhX7Uz2RsyhN2bt9cE+d9H9SfBU1nHVZWUnLQKGTRhtIfU6uSVWQs9Wdf?=
 =?iso-8859-1?Q?L2JmZWePtlpmGJSsIxNG08YxkaXZdO89AaApp1h10rNA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8689.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?AzRt6DtacJwJ7qN3FJ34h1ReVnnyvKDiAIaa2mNnVUlYOpeixq5YTVQnfl?=
 =?iso-8859-1?Q?UlJ1LExhteAf3e504Gz+IR7QuujJ3oHaWzYxDaKVua6z7LxW8lVmhEIerw?=
 =?iso-8859-1?Q?+u9Ru+keeyep5qtDofo72L5N66UmdT57yVlfq2ghf5XgyhfJhib38JC+hN?=
 =?iso-8859-1?Q?ENeFDcLHs3z2TMcztQHCsa0YTfkqF2ygac17dYC56E313GF3LQo1CyZxPp?=
 =?iso-8859-1?Q?bGwbCzKM9M3vymY0V+yVaxjKCJejAi0LEYEctgBxGvClh6KbVQe0LtPe8x?=
 =?iso-8859-1?Q?qbk76CFUGzsHf4/sdJGi65L9Nnq6lnKvVOePyvnNugYdeJLoYr00+I3jbj?=
 =?iso-8859-1?Q?IwRfJCPEqu71/a/0z/engSGUFA07c7Pulpe8iPhElJXg1sTYs5E0KbRNUg?=
 =?iso-8859-1?Q?kd7thoaYNFolGqg+JVQ+M9aqNC1iSasjbzssLq+MJueJMDlgd64CqQHVYy?=
 =?iso-8859-1?Q?AeQ2eS4Xq3o002FVUEhDh7nSnSoAP5sUPmUeI18AALtZ0qTJqzGIN6qwDm?=
 =?iso-8859-1?Q?bhyTAfu2IQuZZKV5OZ4BMP4AD0d0RlwvUXdY1IohAjc8xPMwwBNtW3KBMS?=
 =?iso-8859-1?Q?07YwE20zieTpFr5Sgm/ey/yaeSJJHjqdUAWgGHnbuEG1MFwoDE4TGRNg4d?=
 =?iso-8859-1?Q?mBI3gZviDTebsE+iHAv5IXa3ov2qNbZO7ffkg59MC3iCW1Y0UjqDzPmSIS?=
 =?iso-8859-1?Q?uTJ7939NQlO0Cdhw88AjBit8XkxcTSjQcTYzx9MNWDcAxurVHmN2IPnK8j?=
 =?iso-8859-1?Q?x2TCt1mXaZ1In987hlQxM+ln39ppCriCZWM7ss1rbjFP/V2v6HxxkKYM2k?=
 =?iso-8859-1?Q?1fLJIRZKtkaKR2q31y/ZQKcSbZEsVM80nGiLT0OAAfJeReunl/9NUdlmsN?=
 =?iso-8859-1?Q?2ePZHP+vnuemyyoW5YU5EIbDJRFcE4fFM5xrmiFJsFyP2KJadn85O4YXA2?=
 =?iso-8859-1?Q?CK0eLVq+rQVXggDcEDfYwrMZp4a1rBX0Ra/uraRp5jjkUJ+74mZBJ1f2ZO?=
 =?iso-8859-1?Q?j0/99h3G2oGSZDpCdOqXUaf3zI1iUG4dt+21z8iRh5i53NfLsyxHz/hl/5?=
 =?iso-8859-1?Q?stGHpbNU4/6M1l4QhIK9KdvviE7KocIWCQwPfSfvuK+ioY3s8Fu50hufGN?=
 =?iso-8859-1?Q?WhgFah7yUbnxHobKCUCKiiqRb9XWc19uDAqA6HxzVkg2JK9u+35htEConD?=
 =?iso-8859-1?Q?FwGX5THy22yw/NXZJRP30LJxYyzCQMuh4sYFcjJvVIBkzOoFpsk2q4LTSc?=
 =?iso-8859-1?Q?ouAPsea3cDSaneOLFNJv4px5N0OH8peo3I97TCrHe2DdoWleerUcFroPFU?=
 =?iso-8859-1?Q?E0RBgBXymdnRLywGusKyke97j9zRwnstzrmtP4AYj0kANjTaN3v6JQbiId?=
 =?iso-8859-1?Q?krmKYalORx6lxRUD0e+CAGwNWhqIFmXfpShtH56e5zUNagM+mnyr6ijOMl?=
 =?iso-8859-1?Q?qDCYGZFSsR0fzZTCfOnWVvlt67UEvo46D+DVIhEH9XJOADpkHc8td/y8Sd?=
 =?iso-8859-1?Q?zHZQ0zshNA8MLqHADfv1k4DTQbTBsWmCjo3i9BuG3mv2mqTUukjX7UfLJ1?=
 =?iso-8859-1?Q?H48nvAoylRxrb3tlVzQy6/Zt3bfKw0NFv6S8F9rnVqC8LPO9QWqG7Xu5nj?=
 =?iso-8859-1?Q?744j4SwtaeWt4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8689.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b320cd-d5dd-48d3-8b31-08ddd4e76b02
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 12:47:35.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5D3W6xnV/ZwYLp79zmC0bZ9zB4maX19hLnOVBkEcfF5uic8sKbMvyAGQReD9QkBB/wy/6pQIu1AebJP8FMuDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764
X-Rspamd-Queue-Id: 3421F42F12
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[Nvidia.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.243.46:from];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.243.46:from];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 4MKEKGO6PPKKO7QWO7VL4DFFBUCVNBAW
X-Message-ID-Hash: 4MKEKGO6PPKKO7QWO7VL4DFFBUCVNBAW
X-MailFrom: sungbaey@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KMACXX5ROESXRLWGHWLJXCJRQ4GZLQS4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sungbae Yoo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sungbae Yoo <sungbaey@nvidia.com>

Fix: commit 4615e5a34b95 ("optee: add FF-A support")=0A=
Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>=0A=
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
