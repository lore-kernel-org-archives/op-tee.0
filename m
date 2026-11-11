Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3497C606A31C
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PRDf6E0f
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 74BB14550B
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 18:33:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PRDf6E0f;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 245A344EC4;
	Wed, 11 Nov 2026 18:32:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDt3VA+H+e6qDzT3H9ZGQ0GkM6+JlRzYlWtNYTc1EjgZnzZY/MfUOLxJ0kw7kY/TA62hFD6UW+gpMFhmUutKetGEpY5jrjk7LW5wj7+cqLhKfgr3zZO1ESc/Z8xshAksFMwWh50dEZ9YwJCrCMDkb695IxuVApOnDpVpbZFsTqM08/EZyw062IuE5d9YueP6hN+tdOuWRT3ktfNFgK0JHce/h1a4i/kj03PiDnif2qic/a4LtSy750A3vhPZAzacj/C7ViHX048juep2FFfJ4SF8tK3ur/nl+iDFgEGz6ttZJ5xxNvgBUe+VfFFKnF8Ran0FlAFYf9YU172Z4B6K9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TngGIfUByX6Z8P5MiPzDcq9v7v2/gn/JEVNVtpE98+g=;
 b=d753CHsm6eDAT1D4rV8TJ/qQMmNd3qdlz/8t9FFp3GghnV1yqvhP2gmAWKR/o309oIoc5RL8+idZKOGqQGlK6LwrfweZPYUKJQ4hvgOW++lvtO7pScY2gtvGD5epQWf5ZKddpNJLBgYYrtfn/WD4AY4pSPunhbIgcTQCvkPnDWmJJETqaHj9BRbUVN0xJcDq1QuKebxdR0EfOfvxTVf8X5U/yNAXbR24F/KoNB2fc+Ue4r74E/BP8NJ0agaeioWN59QwRXY5SJw2g4zBSXhYDYhsDmchQw2BSaWvviej+sR3EopOJbULCmNlFyYZS4xMzmqOseoKtqJXvjTd9NxnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TngGIfUByX6Z8P5MiPzDcq9v7v2/gn/JEVNVtpE98+g=;
 b=PRDf6E0fPTOjvSnn5tOJEc/zMxYfZfNG49diEOboSqxNqShU7QhW/1VI8ka81O2Jj+/T4AJwpnZYMGxta3Vav8Gx7BhKFn393O4K3flGgA7CoVY0ncrr2Qld1MlusOtt9VYznvqAIbCv/L4oxAw1SqOW+NU3PWdEldFRCy0weQY=
Received: from DB8PR08MB5372.eurprd08.prod.outlook.com (2603:10a6:10:f9::17)
 by AS2PR08MB10155.eurprd08.prod.outlook.com (2603:10a6:20b:62d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 18:32:52 +0000
Received: from DB8PR08MB5372.eurprd08.prod.outlook.com
 ([fe80::cde5:9663:bacb:4af]) by DB8PR08MB5372.eurprd08.prod.outlook.com
 ([fe80::cde5:9663:bacb:4af%4]) with mapi id 15.21.0592.012; Wed, 11 Nov 2026
 18:32:52 +0000
From: Arm PSIRT <psirt@arm.com>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
	Anton Komlev via Tf-m-security <tf-m-security@lists.trustedfirmware.org>, shj
 via TF-A-security <tf-a-security@lists.trustedfirmware.org>, Dan Handley via
 Mbed-tls-security <mbed-tls-security@lists.trustedfirmware.org>, Arm PSIRT
	<psirt@arm.com>
Subject: Open Bug Bounty Reports
Thread-Topic: Open Bug Bounty Reports
Thread-Index: AQHdcgXw0bEcaRIAYku9qHc9oeg9Bg==
Date: Wed, 11 Nov 2026 18:32:52 +0000
Message-ID: 
 <DB8PR08MB537207711BA5C7066997B7B2A7712@DB8PR08MB5372.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR08MB5372:EE_|AS2PR08MB10155:EE_
x-ms-office365-filtering-correlation-id: 9bdccb6b-b7de-4769-5a3f-08df402231ef
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|261028144727099003|38070700021|10067099003|11063799006|56012099006|261026140227099003|261022105027099003|18002099003|8096899003;
x-microsoft-antispam-message-info: 
 VRIlw8oE6cmmvWA8bwAho3SnQzdojHTxe+a+SfCY4NCnZWuIvpLRhQ617V+ts94kgMGKbUIcDo39isbCe37ZAFcGpURQ4kDfwQe7fHq0XSHZaGUW1ovPH0WIT+nBga3G0I4ekD1HsA3UMBNm7IFr82bQlDCTMDBia/QWqw19DYPgKJ5JEM8WmKalWi3B5bTe9kNDYTaLh5SdyS0zx8rv/Vtmj9IUCN0L/CMexpfquK7k5gbhrXpW7iAlSWsMmXGb9E4RTALWnxxpNtxOd9somxI8ymZdBGycS+dMEgxDLebS6gvwhY+M3vwsPRojcY/nM8b0aHUIlSaqurMJJahiLO4t/1znnTfIgMj7Qy7k8Pqz8JZFmbYgT53ZhzxLBBddDzg2CR5wUll2sRzhJIeTGeXmob9A9NsfybK5wisNvzZ3CL7SMeMuw4ALnDkf6opxCzbaKXRBFLMbqat3ciLg7a+s6eoWUdHyuPd3wQ2CVIaI8rS+ubli0gt7aHapRm0233b+AvOMqpTA49qvBYCWP8z427zhIHNjnFZBACcd0q+grSyl6q09TKG43acBxKsvgiQ42mFCMOIVf/N0+m+ORqmsA8v0PzdlTCCM5zaAOGDuNFcj150exPFZxPQivGO1LSdNeOwtUQ/yLInn4yUpGMoCRoqlFC3wQKYL3bdD56o5HarPNVqd9gtWk2Wr6/m8xCZALYTZnduOWe6ZTrnUSLeyWeq2j1h4AazFyDUveos=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5372.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261028144727099003)(38070700021)(10067099003)(11063799006)(56012099006)(261026140227099003)(261022105027099003)(18002099003)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?0CwtMy7Y10YQ5Z1apMixqZbnEcWlomHHFkt/6QOFEqDhgECv2Ah3ROe4?=
 =?Windows-1252?Q?+obuoiJXUJPSS+qqadeWr+zDPSeX5wLdmawiXj+XrDlIhCih6+kYiAjB?=
 =?Windows-1252?Q?CuNZNtmspe3Ezr3FVvu54k1nbO+kajGMsz6rkOJt+RVSO/iFoE/u63Z9?=
 =?Windows-1252?Q?lIr/fA9DhtViK5r6ZsVJYRz4fgXxQHFacjz0GgycGcXZsCwgaHcFHnKW?=
 =?Windows-1252?Q?ZkAsep6KwtE3mlERkRIOcSI5r1uUKqk07f2RVLmmayTQEU8+T9sezuzV?=
 =?Windows-1252?Q?XgLtNW5+0ALbWhNmgyJK3Hhbe+vbkb8HP17ujGGYcADRk23fiXEHaOBW?=
 =?Windows-1252?Q?hD7O8ZersqgO4S/dz9pwMdT/mijf/tPrLK0iI0r6GhRg7ZXMPMT1wtX0?=
 =?Windows-1252?Q?MP7V9w6lwBLuybMWh7GjZgm9kgFbtEIPTv3AU8Mz/MnS99R+eQOBg8Q3?=
 =?Windows-1252?Q?ITTK8EZkbjNqD0VZfaj0pFAD7/frouiz444GZaJM3GKSD5ZgwmPYNOVg?=
 =?Windows-1252?Q?yIBWn94+N2qfqlaRbpJD2lEbMx13qbRNX3cJ+Ff2VPaMAR2BCg5rdh6L?=
 =?Windows-1252?Q?b4zc76DVIU5f+OehPRXamPUXkb0SLABlf+8NLr/2JFov9GR8oIQ+B51b?=
 =?Windows-1252?Q?PnJlosuBnB0teHXFxOkl/+QVIpUF9zFow3f+Hn4jdRwPPiExk2JoxStS?=
 =?Windows-1252?Q?CqhoOZu1YidedkVdCSNNBt602+V/xziSQ6Up2SxfCIfG2kuwzoqmLfpI?=
 =?Windows-1252?Q?0fE7vHnOzFgXRuJ+r83vDwtvWzTg2zRw3GZ/wyB1cdrCfcB6S9NwMotQ?=
 =?Windows-1252?Q?duxwtJ95bUTWccN9kWuKq9uIqqzB9iUNeGUIHjDZEfMg5HLk/FlIKXtE?=
 =?Windows-1252?Q?AdXz4c6KtT6qmxaFDGrreH+CQQjo3goIH5uBicmBWdvqREEHm2h7Sav3?=
 =?Windows-1252?Q?EjwW29LrmsmMxyULW0uQxHkzGmpV5DFz2wndg0esbTGUlFzVHdF63+iK?=
 =?Windows-1252?Q?u3+jKGk73uwWqjC46oBepmwm9PB3nYHlknq0XbvLVC/bb2wcP4Z5Hefw?=
 =?Windows-1252?Q?6UlBh3flpYP4GVrL6xvV2oYiG/1WJNVHf8BfDfjp312+GYeDKHKjOThh?=
 =?Windows-1252?Q?igb534/+78UTk5CypekHubQOvS6bZgXYDU4rDgd1a5B9n/I6Vu7VYBYY?=
 =?Windows-1252?Q?9gdjCQJiU6iWZup7e97EbDM1l/p2jN5u5GE2gQUJhPqGdoiF+LI5qAic?=
 =?Windows-1252?Q?oZlC7x2mx8goMP/OZkb9iN6pOjZOn9KkE403KO3HDzka6ct7T0guuIKx?=
 =?Windows-1252?Q?nSa4b81hB5AnD+GN+2bI4iis/KBrf17PUNCcNlyGdH74QVbP/5KEpCrp?=
 =?Windows-1252?Q?t7NxEnLIw79xV5ACvgTkBcLQTtYP18nDlUN2/ViTttzXDq5tiUFG4Bun?=
 =?Windows-1252?Q?MUsEKqqJDcPDMS6Ip8UjepBtSm/KZNirkvPKYC9EbzrxIrP+5kvPOavh?=
 =?Windows-1252?Q?mPX4BGaKMaXweV0TwEqzuifcCPDSRWAx+nXczF4xvmZsMRMY1/Dqn024?=
 =?Windows-1252?Q?mwr/Gp92rLz3bSRox/rQK1oXouA3KTTgC4J6NybL+rQ37KUVo11aLIXd?=
 =?Windows-1252?Q?A+JFl7aFLLcu2fXfaA8VotmZI44EtdouWCiMFWo5kbVVF+3kmF/+3Q5c?=
 =?Windows-1252?Q?IsuVp+ycv1LmdePSwFn6ne+XBZ3qGDIu9mM/o+hoIdnzNe0HbrWKeFXu?=
 =?Windows-1252?Q?UfCFZcMUnFPgj4IHdWpgtwtPKFekbCjUzAZrF4puWCZXnWLZxlJ3AKM6?=
 =?Windows-1252?Q?LP3fTwuN77rjbrDDDtoofNSLfcTKLr/L4DyuvtY17a40Tv+1xhy633vR?=
 =?Windows-1252?Q?etzjmRpalRoEvA=3D=3D?=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5372.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdccb6b-b7de-4769-5a3f-08df402231ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 18:32:52.0526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pxpscOwcDHHOEZffDWM3SdmNVrtl2d7MiSYMuJ5H2ATnP+yurD/8LnartYgNUhn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10155
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 15.00];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	BAYES_HAM(-0.01)[49.71%];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.159.37:from];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.37:from];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 245A344EC4
X-Spamd-Bar: ---
Message-ID-Hash: THHWES6PSRZX65NVG6JQMQDT6HDIHUAR
X-Message-ID-Hash: THHWES6PSRZX65NVG6JQMQDT6HDIHUAR
X-MailFrom: psirt@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="Windows-1252"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HFVHKHFTWM7GINU7BIW32I4OZSTCFS3L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

Please find below a list of the open reports that have been sent to TF Main=
tainers (there are 33 more that haven=92t been included below, which we wil=
l be sending through soon).

Please prioritise the older reports.

Many thanks,
Arm PSIRT

OP-TEE (43)

  *   ARM-K2GAZKXV =97 134 days
  *   ARM-XVJI6A9L =97 47 days
  *   ARM-CL37FF53 =97 47 days
  *   ARM-6GC09NIP =97 19 days
  *   ARM-H0QOJ55S =97 19 days
  *   ARM-HL91NXAR =97 19 days
  *   ARM-JVXC83L0 =97 19 days
  *   ARM-L97VBUSA =97 19 days
  *   ARM-M95676XL =97 19 days
  *   ARM-NFNXAZ59 =97 19 days
  *   ARM-V3J2G5YM =97 19 days
  *   ARM-L4097PQ7 =97 19 days
  *   ARM-O1308F0N =97 19 days
  *   ARM-Y9HOA880 =97 19 days
  *   ARM-YNL05C3U =97 19 days
  *   ARM-2L2VTRE0 =97 19 days
  *   ARM-ZQM30423 =97 19 days
  *   ARM-YFDD0R2J =97 12 days
  *   ARM-D84R555L =97 12 days
  *   ARM-6YGB44YS =97 12 days
  *   ARM-FU38E77Z =97 12 days
  *   ARM-49A8A3VD =97 12 days
  *   ARM-1H7UWNTY =97 11 days
  *   ARM-TS7FBS0T =97 11 days
  *   ARM-SR3LBPRK =97 11 days
  *   ARM-EQXRTM14 =97 11 days
  *   ARM-M59B5ZOW =97 11 days
  *   ARM-7YVP4CKA =97 11 days
  *   ARM-W9FEQ9PW =97 11 days
  *   ARM-5J9TXGW0 =97 11 days
  *   ARM-D1US9K3T =97 11 days
  *   ARM-BCT6YKAO =97 11 days
  *   ARM-B4RZ6KUG =97 11 days
  *   ARM-A3IY16LW =97 11 days
  *   ARM-U2UKCCB6 =97 11 days
  *   ARM-4O43FE4V =97 7 days
  *   ARM-62KPSKPV =97 7 days
  *   ARM-OF6OIOA6 =97 7 days
  *   ARM-P2DJR5JK =97 7 days
  *   ARM-ZJG80HQI =97 7 days
  *   ARM-IL6OZFJS =97 1 day
  *   ARM-4KR69J7Q =97 less than 1 day
  *   ARM-C7PKNW6O =97 less than 1 day

TF-A (17)

  *   ARM-NXS0FH0A =97 82 days
  *   ARM-0A39M0XU =97 79 days
  *   ARM-1XPWVPIQ =97 19 days
  *   ARM-76NFRHRB =97 19 days
  *   ARM-8TSRO18Y =97 19 days
  *   ARM-CFICB13Z =97 19 days
  *   ARM-TM15TUCO =97 19 days
  *   ARM-MPU0LN45 =97 19 days
  *   ARM-M4KNCDQM =97 11 days
  *   ARM-LB6Y8PMY =97 11 days
  *   ARM-K7YC6YZ8 =97 11 days
  *   ARM-VJ6TLCJE =97 11 days
  *   ARM-UDXOHTI6 =97 11 days
  *   ARM-1RQ6N3JE =97 7 days
  *   ARM-CZV4NOJF =97 1 day
  *   ARM-80BONR7J =97 1 day
  *   ARM-Q0JHWIVP =97 less than 1 day

TF-M (5)

  *   ARM-UDXF1YSC =97 19 days
  *   ARM-6RLZDLRT =97 19 days
  *   ARM-H1B98MBS =97 11 days
  *   ARM-ED1XAV6E =97 11 days
  *   ARM-7SDTPTPC =97 11 days

TF-PSA-Crypto (8)

  *   ARM-B8OBIBVL =97 19 days
  *   ARM-CBO9VESE =97 1 day
  *   ARM-1BH2SNZR =97 1 day
  *   ARM-UN21H3A8 =97 less than 1 day
  *   ARM-J7A3E5LN =97 less than 1 day
  *   ARM-K85QENYH =97 less than 1 day
  *   ARM-PGMYAXKQ =97 less than 1 day
  *   ARM-I052ND4E =97 less than 1 day

MbedTLS (3)

  *   ARM-ETHG4U4A =97 11 days
  *   ARM-ZUY3KC7U =97 11 days
  *   ARM-EW8H1Q9O =97 1 day

