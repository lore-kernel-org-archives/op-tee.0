Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1FEC87FCF
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 17:09:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 499034FB5F
	for <op-tee@archiver.kernel.org>; Mon,  4 Aug 2025 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754327390;
	bh=m64Y12PKFMny6ky2kjsJNwX6qD1FeRIUtG328RFaUb0=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=pdnAdcWAxSYPbSHFsRTbJ54RvDbMt2dPFXllx8rBSLy9aNbEFuaJjHdsm5S3h96Bf
	 rQT1ENu4ZOG689XlJAzgn5+z9kfKjYEzkAvfSC5wiSBS5+A0dYgoTe+I6Zw6pGEN58
	 89woMtfrXGTJbdzXR6tPK9NwWhLvO4Xt4XImGSnpjvddk32fVA0SGupyr0JAVZ8oIi
	 Y1KsTjZEKLZ4UOeVFxb9PUlGDTEvQRXCzhNFU8A9IYCSntL+mxpgGljZPkrZQEOoau
	 P8Ag27NEYy8QcxfKmHPbnTMJn63WpxvS2S+oCPqVSUTwiyPVz0QQYPa7TKz5fKJfMX
	 NDZR5iL3nu+Nw==
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 23F6542F64
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 Aug 2025 17:09:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.a=rsa-sha256 header.s=selector2 header.b=MyznRUZQ;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMv6kHTgJkgi2nI03igvTbY1onn/84hWsfhbZ+m98k53SiPVtKtktk76Bzn8I7zeX/7qi7p9Fs6Be6qAhBUcuNLem9rUbGB5H00h4LxBStxBDsf1qBbtp4vlsImecEbOltJBLU7PjjQ3yAhLepiaMcbpPolG2QYJUYV9ygEsK/LTaz1xXwTtbmpFkSRvqq9FJPtgd8lOkD2I83BfE2tOw7hw5PMRrMBdfu8N/dmLbLoloaUI79qkFBEmhOyKLbDMW2mMZ+cFOV6ig//1sL4/Whlgm++izWddjas0KA0mVKYHa0U+IDbIYXfhIDk8ZMRlKOoXEKWvjYAwZ1yPsQyWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6sYlpmvo+4Ka3PBvglDn94zrG+duLTzkL3pgsXfuf4=;
 b=MBnP8hTLyyb1qW8DMwyVWZiNwjj4vLdk693lcbj/sDmFct2W3pkn00j/IVHoCKeJdc3iZ5wzCAHOYHQ3A/Ve/vfzHYIoSkyXOyYEHHuoCTfa+woF5BlJZaBdUwn5OPdMxpHC7DraYQpm450e2slTcTuYrCHD4yYEcbHEu2O9F/R9gJHyHIFY3lJkOE1xs5YxV/+XXtJYj1Rrqm2Ceajn6AIqCXVrU5LXVUBtKKtTu5P9nHCDQq2gNYlktaZxiRmFouLCmeZSPSR77F19BOW6jePSSYZQHhKIFe44xucsQbj7DKhIGqedBjAootLSC6tC2dxvuG80AxOyz1TRHpC8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6sYlpmvo+4Ka3PBvglDn94zrG+duLTzkL3pgsXfuf4=;
 b=MyznRUZQY46p4Po6wxvMI8vg41YmmCwqWo/j4maAk1tOUMTXe1qskEP2YQ/p4GeO3Cy14HoWc01qJVpglb3If76v/MSVq0N0ZRDPvHhn31Uiasxamw34XgGoysLbh3GyMPXnPhpyoNCVCRYPodGeD/Jn9woqb9zF9kbWSh5bxl5UeVWhwM84f+FNVVa4kytNG4I3yM2njWDFdbLMIEAVZeXAIpqqrK0xWDAnO1qUyvhTUS7psCkf65aVwtNGam0AfsEfNbchKaiHKNm9oW1uvTHqi4QGWNm2OYgmg1b8zP5FWRoqP2AOpStrLsqt9A3x5cKskr1cgp9eatMe2nm7vg==
Received: from AS8PR03MB7189.eurprd03.prod.outlook.com (2603:10a6:20b:2ea::17)
 by GV2PR03MB10121.eurprd03.prod.outlook.com (2603:10a6:150:db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Mon, 4 Aug
 2025 17:09:24 +0000
Received: from AS8PR03MB7189.eurprd03.prod.outlook.com
 ([fe80::de4e:172f:6d97:2083]) by AS8PR03MB7189.eurprd03.prod.outlook.com
 ([fe80::de4e:172f:6d97:2083%6]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 17:09:23 +0000
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: rcu_preempt detected stalls on CPUs/tasks
Thread-Topic: rcu_preempt detected stalls on CPUs/tasks
Thread-Index: AQHcBS4K3oYzgDiSm0e8XPckcFJ7qQ==
Date: Mon, 4 Aug 2025 17:09:23 +0000
Message-ID: 
 <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=True;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2025-08-04T17:09:23.579Z;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB7189:EE_|GV2PR03MB10121:EE_
x-ms-office365-filtering-correlation-id: f8608d77-d8db-4eea-ba9c-08ddd379a912
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?4+3pVR/n1MYFfqMecS6INAEhQ6AFA9Qo7QM7Wp2XTCKgUyj0/3rjrmxYOH?=
 =?iso-8859-1?Q?iJQdh7MLOAFPTOrUOxMnOBZNxKpvHBFSxIstpFUKSUnvJIs3BKLQlnsFAJ?=
 =?iso-8859-1?Q?LVPTnCvmAPAFKbXLKReVb7ju2KLKfBC3A7RmPgE9SJk2AC+TeQCJv4yxKq?=
 =?iso-8859-1?Q?02/y4nQtMJhXOCKZPQhQOqjF4jcRDrOfn5a1KfsFxxSsPPETgsJvILw0qK?=
 =?iso-8859-1?Q?5I/f2nQ/mY25o77aM+qsZmsgUNMPp77CTp64VWJ6TqsrxIReFbYB3yUSox?=
 =?iso-8859-1?Q?QlH3WqCfy+kpxGrvDQb9UzxrAzSp5pkofv40U1ArT227y4nRFd1Ihbzpms?=
 =?iso-8859-1?Q?Sv00oJAgytvZJeoskMrpXvEeY09XGg9NxJHYhxD1MKFdeK7U4KnY3rL4V/?=
 =?iso-8859-1?Q?KGdU0qUght7kHepcoRNLNjqJ/KqkjsG0UuPfRJKpD+3DbVTbHYSeeOn60w?=
 =?iso-8859-1?Q?VxEgNeMgpx5al3Nh+dxFJ14MYDNRybWVYY/9TMJMVRrxMcnJ4gOQINcjlx?=
 =?iso-8859-1?Q?Wb3GUQbGyokjNpzrNMWKeA5BdqDi1Ga5dR+eDK3hB2rcDH/MDTLPJ75JkT?=
 =?iso-8859-1?Q?PhpzrYD0rGjCgSIDPjqhUd0gHZwJ57s6aAdtCAzTLDOWS/uZZZHIll3O2Y?=
 =?iso-8859-1?Q?uMRnFlrOVPRXBctZmuo+PK1FlikTRfB21NDTZZn8NrhyI8e9zkg7G6pOjm?=
 =?iso-8859-1?Q?I9rOy+cjLWmVm2ZQG4xZ1MXOmjzfxqzbvvmjRL+4VVz8xiC0YYX1lLeNDQ?=
 =?iso-8859-1?Q?Odn7x4OfL/7sPGstk4CHcHv08/gQJndn1dzLHZj4iFIs5qDalooVTzAIzS?=
 =?iso-8859-1?Q?vAYM91KPvKe8MHVK5VJEtsMijvGgU3NuSgoQ1ZepMb+eQ5hicxya4OlZ4+?=
 =?iso-8859-1?Q?u5mYDSzVVVlutshafg6xnUtTFP5nxkC2xdDTR9WsjHj4FQ4ITe68B87A/A?=
 =?iso-8859-1?Q?PdEvJu2RBAGnGfHUijgcvj1soCc3itIgEC+LiXOB/cD5o79uYULTZuqZdY?=
 =?iso-8859-1?Q?46AwWZaez30fO+GKVtfb7PrNymRT08Nc+BlfCA4s1WDxKeSRoFsuB5tx0e?=
 =?iso-8859-1?Q?Nu+aJpGP2ehABnOojLuumMJaBuhLftnP1xKhrXcdDMAZNjYKu/tf6h/wwk?=
 =?iso-8859-1?Q?aBXE1VDMg71OC6mTui/UF/tyzu+q0tq+f06YJIHdu2KY7YdgGf2jW/5QGR?=
 =?iso-8859-1?Q?1D0moONeG+bttuZ82Xsrsmc60vmHS1hoogtyEhKxmVZwpn6mfK4x8abJmc?=
 =?iso-8859-1?Q?jfYIDGuLmmpnVslna39Lpc87rlCAhSWKwcuxoeBh8GVwn1VB8eN0tReXLB?=
 =?iso-8859-1?Q?occ4uEpvcjt79d0eixqo+HrgHFSpIymbcNBx2v7vInsRJwmRb2CW551aWr?=
 =?iso-8859-1?Q?H+JfOVJ4gAIPd9VhIB6VfoY5WcVsJt8+ADh3BCxY8vAQPL4YWJ/WqOtil6?=
 =?iso-8859-1?Q?Btx2qrY+TsdGz8VXNRKsW+pwbJcDt3E1W8S3DXlK/ZMNuCrKocmrC3jAK8?=
 =?iso-8859-1?Q?whXTW/y/cd3V1Fod0sIwYvr3OVkuHMIHw9AYTzl0Z+2Q=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7189.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?q5t+2s7FSL7nFKbnlTZtRJ3xjNPjldUsG2hU/0X84dxP2/Fz1vOps8bClx?=
 =?iso-8859-1?Q?sU6jvh7Y83a2NmZlt2wUAsyAKfd16enqab3T7hS4zTV35NJ5kkNbVPvzgS?=
 =?iso-8859-1?Q?4fLu71zFnTb3cDa8UW8LrF79bGdQpldez1UOVScJ5qo+KslZgaIU5rdIhC?=
 =?iso-8859-1?Q?/IPuTbErxt9CsVWAHxJIF2cRargSsEvWLEbKVModPwG8SS5EuvOIW5COr8?=
 =?iso-8859-1?Q?0Toz5OUlil9hoosiMn3jqIVq/UlMEVfHsbis5oLM2XBzZ36b+LPi9jQSop?=
 =?iso-8859-1?Q?3+YzQcLi/1yuCzQc8y4HuM0WPCXYm49OyzCc29S0q/Y2WP99w3pyut1wSD?=
 =?iso-8859-1?Q?GOact/M2yVw4oxsPU6c3c6GWR8mNLzSXeLKMy1UCNY0T8NyIbyG1JhZ0Cl?=
 =?iso-8859-1?Q?iQ5DKaMokhalI5OSETcjlI8v60iJpUjyaWs/JiknQXFJuzL6J1La0VKt30?=
 =?iso-8859-1?Q?M+FtOFzJL9xTBkcuoWJ5WDDDo/Qv6VCfFNg/SkyJ5oP/Xvn+Ij6JiS88yN?=
 =?iso-8859-1?Q?1wVDCKOKLcao9gR4EBgpDm35B6ulGaIMevUpkOUDS44jW8Y1OJq+0rGxU9?=
 =?iso-8859-1?Q?RmXZY0jEHqo2LVyOfRqVtLw9kZ1Ug1dnnbATK6TJFCY5jl/798ID2Gh6zU?=
 =?iso-8859-1?Q?3RvGi+b8u+y09CK1ihis1oIuJOMhro7fDqP7ga6mNqrmww48dEj9cRwlys?=
 =?iso-8859-1?Q?pjxymFqWLBCbD5qsxQ/vMJdL90xRTqzV85yUqWBMYJUqL27yhXeBUYR33k?=
 =?iso-8859-1?Q?H0aU61puySnJ+UxT9ArZoOqBq6WBNtmS+pSvFt+boC7hK03SOQADByYz1M?=
 =?iso-8859-1?Q?FWpLocKuuqPvEjWYZ1XnyhC5wzryNzqn5gQQ4TkbR4Y8pra2v2SwAOIsET?=
 =?iso-8859-1?Q?c3e1Fjb28jbSII4tyFJI+EUeVhtBLDChnz1Va8BvfuNpZMT/Qu51y6U3Gd?=
 =?iso-8859-1?Q?JYPUTcmgBV3TrwAHo4UJRclpAxZcfgaVQoQLu352R8fhxgSx8hDDozSiAn?=
 =?iso-8859-1?Q?TMrn6j8IQN1TYhWRwGJOTs5vjCGll98DTkyXIGqog31hOUrKXPvwNwrGSv?=
 =?iso-8859-1?Q?x4A3i2l+9zlP8CUtASkoIong7QFpYEJwAKptE3L8eKw9qCtxf2LNSUIdLq?=
 =?iso-8859-1?Q?vh10QKjX+SdwzjTj2r8HdVExVpXXPz1mAYULCi2tj+QKnjhfIsjTb6ygdf?=
 =?iso-8859-1?Q?2+a+00iwxZWV+IudcBj5uUbvdtn+uzLmuWbn4Qd6gntthfIdcQjuyKfLt1?=
 =?iso-8859-1?Q?m2QO+eyvo4L6tQvyTKIji/s0p18oV+KcP6DAk5E7xQDC5JX1VJnq+FD1kr?=
 =?iso-8859-1?Q?rTe8PryejGum3KUOsEkY+tzvNhvMFU+Y8ephcKZzVT01EUh3eKEs/4Tpgx?=
 =?iso-8859-1?Q?3qC1Lpounc0U4d2JmyvTLdr4mhAvrzDOKGwU4QRQdJHjjvOyC3tLL74QlH?=
 =?iso-8859-1?Q?gRZgDLa7zkTuMJ6JWNttjl1faFA2RedkE/UlkCCeVqDgpncJJlE1G2KLKJ?=
 =?iso-8859-1?Q?Ylowd8qQ7IICnZlgqb0wJ6sJIHqQApgrV6NnOK9z4Q7Ci2uiD0KDrx9N9U?=
 =?iso-8859-1?Q?lCa2eNXhMCyvlovCHSRIZB5S/ZSflxUcFWFMekL/QJw6nBVslc4lXxxC/H?=
 =?iso-8859-1?Q?1CN0GL8WGBICDiGHNHKPBuL5Xxis18Jo+j?=
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8608d77-d8db-4eea-ba9c-08ddd379a912
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 17:09:23.7342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjHUupJG1tthkq13UIb0/5bBdLpupgq04QcgcfZOqkZB4WLZltss58ipY3MccfB/oYSq98/ryO1CaqXlQp47XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB10121
X-Rspamd-Queue-Id: 23F6542F64
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.84 / 15.00];
	BAYES_HAM(-2.84)[99.32%];
	DWL_DNSWL_MED(-2.00)[mt.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mt.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[mt.com:s=selector2];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.84.47:from];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.84.47:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[mt.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: MSAYYK7HTXSJB2S2RSWWF2OR52XFZPZY
X-Message-ID-Hash: MSAYYK7HTXSJB2S2RSWWF2OR52XFZPZY
X-MailFrom: Thomas.Stauffer@mt.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: Ferreira Joao MTANA <Joao.Ferreira@mt.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZCFL5XI23F3T3WXF6JV7NNH4R32LT24N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Stauffer Thomas MTANA via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>

Hi,

I'm running OP-TEE 4.5 with PKCS11TA and ATF lts-v2.12.4 on an iMX8MP. When=
 I create new rsa 4096 bit keypair with OP-TEE, I often get

rcu_preempt detected stalls on CPUs/tasks

from Linux 6.6.90 (mainline)

Also PID 0 is sometimes blocked for more than 30 seconds. When I create a R=
T task with even higher priority, this process is also blocked up to 2 seco=
nds. For a test I disabled saving/restoring the NS timer register in ATF (a=
rm-trusted-firmware/lib/el3_runtime/aarch64/context_mgmt.c), this seems to =
get completely rid of the problem. Neither creating nor signing leads to an=
y issue anymore. This hack may lead to other problems I do not fully unders=
tand yet. I "believe" that at least since ARMv8, the CPU have their own tim=
ers for secure/non-secure world, but I would assume that ATF implements thi=
s correctly already.

Maybe I'm completely wrong here (assuming that it cannot be I'm the first p=
erson having this issue on this platform). Hint in any direction would be h=
elpful.

Regards

Thomas

