Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C58BC43458
	for <op-tee@archiver.kernel.org>; Mon, 13 Jul 2026 10:27:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8B8C245044
	for <op-tee@archiver.kernel.org>; Mon, 13 Jul 2026 10:27:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=UoU5Yu9U;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3D1F944D93
	for <op-tee@lists.trustedfirmware.org>; Mon, 13 Jul 2026 10:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BkByWQ6PhORb6AevE0RH8MrTcIgQSAo8bzcgmp8AfYW0M4gGoiuWV1QfAxhJpGsq2pAwOBcSLBz56mfGlQCrgwxGCESSrXKiRSBGfrvkgP+LmWAO7ro6MTtOBXCLV3KtTLv4iTyvqh8RhXY5+p4HIt+GXTOueu2oCLxe98jadt3hicIDtxnKcvSuZYnjvAAw9uo0/iFUV+vvWQKP6O68dJlYosujQiOcxLEQ+qTo2cjG2txm1CoiKrTw/wPWUSn6pnhjUpmEe3yFG/N1k0Sr0+dTiEL2fS3aK4jNeaYhBYuFlD5QWIqQQDSz6Q2QYm1RrOIK/FjJIoe00kX4TzDWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de6lJyhJo/TUMuVRObhAZUsDFpOSU+cw9LU4WaHzKrY=;
 b=xaR2E9zSZdgE2OiBvQ2R2ceCVgMDBcXw868V3yTvTFCl7rnTKckNziFgSYURCpMzZnjMxtg5wTe954MMDDONvONVdL7J5eG6rtDpPq6w5uUjksGXFS4zGTNB7eo22EjX3JVZg7jfNmk4vd2Fau01WGbVB4wLPVsLNxLchvm9kVQYY0/zXiOu2Bj0zmqU0gDeg7/JfVNZxbU5YY5u90MuA1QkAs7zr5O1FjS+G6UIwrMOggy9p7DVDDM1RwGZzLrV73XbJHjjwdgx0cIsF6vv18TfRKMQiUiCfP6Aus2c2F3/12hipKDCqBqrSTv6MEXfufMO7bt/W9gThbfuPZbYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=de6lJyhJo/TUMuVRObhAZUsDFpOSU+cw9LU4WaHzKrY=;
 b=UoU5Yu9U/lZbxutZxLFB5zCLQVkGQkmxRx729KdXi1jW5N3P6vgk4ewTNhgO9FHKbxjkIkiDAc4r0f9ACG4hXsKzPil4upjB7DwXodh7Ip6sBYEfdGUU1a2UwoJ8hK2bFXvQt4Zy/JO+5PlHpfYCfYgcKVK13dKHD0TEX+2WvzM=
Received: from GV1PR08MB11247.eurprd08.prod.outlook.com
 (2603:10a6:150:283::18) by DBBPR08MB10603.eurprd08.prod.outlook.com
 (2603:10a6:10:52b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:27:38 +0000
Received: from GV1PR08MB11247.eurprd08.prod.outlook.com
 ([fe80::6b0f:c757:71c3:e3eb]) by GV1PR08MB11247.eurprd08.prod.outlook.com
 ([fe80::6b0f:c757:71c3:e3eb%5]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 10:27:37 +0000
From: Arm PSIRT <psirt@arm.com>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Re: OP-TEE Bug Bounty
Thread-Topic: OP-TEE Bug Bounty
Thread-Index: AQHdEqRgYFVwMvwEeE6+YNLhWbfOI7ZrOq/a
Date: Mon, 13 Jul 2026 10:27:37 +0000
Message-ID: 
 <GV1PR08MB11247DD9A3602B9965BE5331FA7FA2@GV1PR08MB11247.eurprd08.prod.outlook.com>
References: 
 <GV1PR08MB1124778452503DE280982F12EA7FE2@GV1PR08MB11247.eurprd08.prod.outlook.com>
 <GV1PR08MB1124771F2CEA6DC92717B7AC8A7FA2@GV1PR08MB11247.eurprd08.prod.outlook.com>
In-Reply-To: 
 <GV1PR08MB1124771F2CEA6DC92717B7AC8A7FA2@GV1PR08MB11247.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR08MB11247:EE_|DBBPR08MB10603:EE_
x-ms-office365-filtering-correlation-id: 32ab5ed2-a245-4972-efbf-08dee0c95c82
nodisclaimer: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|22082099003|18002099003|8096899003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info: 
 zKN2av9KEni7UhLkrL5C4sNCCEYYqfUd0I90AF/uppoeATN7BLDBbdgj6aYWq5uYMINss049mNMUTQAPXGEs+ETCpLE1ULjUr/oR8Kwywju3NFjt5RpnTZUPazhSC5LWVWOFu1PK61AnvZyPCcsN4D6jNPHmu03RuL2ULJcwxLIHrb45DMiHDWhYKkr+fHJ7FoaWJpo/rro0uSniEBSaWAYR4q3atKpxlJk+R0UDFmAX/myLeaWLmiJGvF7p6UeLvgXZtDIqYw0JKsWuydrd+GkBejN4HvbLJdaFKFnAqXe1ZwqjTXlAFKs3iy/MvVPCVkvLIEaOf9sAy3bGvhN1o7sr1qI044Tb0ZrEKzsKUYDj3beFoCkyf7a02Iv7cjC3KNYjZ+xLpahyPaIg2UIqH8KU7Eybt8BQ621MlXqp735ZZKvPKhys5iTmo/ASlex9qSPZllzoRYLaK728HFUHXObp+38RtI49H6+bv2eX59/8ax3P1AJPUyUFcVynX5oDerTdRLHdLxJAc6QpGggep3ZI2enRNijg870g1f0dfxy4OKULWib3cYTJRsycXriq5H91iPwNCNRoUVihxMSTL7iM+8ogI3wMv1HVxEUxBr67zACbteW3Gaj7uX//O5Eet88pv5YGrd3t4xC1ubyB2v66DwJQ55Gk5vufsjF3RwM8RxVDiK1+4QhdXMoVKqbCapouVL18J7FQdtbWECdZ/315DQKX8SIFE3aZLqmlREo=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB11247.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(22082099003)(18002099003)(8096899003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?51GeYG3mr9YtvCVfv3RUOuHRoIzGHGFKRifmCGET2GoX9TNnuWAcIWT6?=
 =?Windows-1252?Q?YcvJzBDMpmy+D7Ko+UQcStiLeTbTkOXxQT6RLQ8d4fKoNblxAIjUKY3D?=
 =?Windows-1252?Q?ynBo2Ket4ijq4N1aAoQcG7TlKhvUDrc+loxFjmAYVoNy2XBvZL2pDiHJ?=
 =?Windows-1252?Q?TljXK8Xz4UXzD5MSLLuTEmUfbkPWK/XxW7/f2CtLepIylpPYNVcVtj4e?=
 =?Windows-1252?Q?/94Vun8dMMjnnWNnvwPOr51LqxYiUbj9EYqdizzn6ts5ULKS5t6lsYUg?=
 =?Windows-1252?Q?4KyN+MC0CjXU94ToGt1DCoYqOwHMR6BVsdvGlLQFrJCQMzZzhM+jhkYJ?=
 =?Windows-1252?Q?03APVsL2LVidPk1YZPG2PEe/lJYKrFMXhbQz9b/UiGnP7mgYYvjRtCBW?=
 =?Windows-1252?Q?ZW9go+29s6txi45ezDjKn+tu1np6HNa6bPaN+8hWG0/XoclgqvRemw1G?=
 =?Windows-1252?Q?JC5rPGLbgJ9qd8aQBpuksZC+LKECws7HkiSc/zAua5xLMqgDI5UmxlAw?=
 =?Windows-1252?Q?GiR1XvKEFGVMV0rZnc/hW+2ltENXj4XY/eMW5wbpqTShUThrG4kNuqWn?=
 =?Windows-1252?Q?6y22CjlfkO2JgOmYSFnuy0+eiWWLkaQ6XpThk4sFKwlxpTTodsAoyWAS?=
 =?Windows-1252?Q?n0qMsuuwVNhYathzmblqXUeKtwKLVKxK1gZ6vrr8e1aJIMkWDEJ3FX8C?=
 =?Windows-1252?Q?4I36Jh8V899OK6TFwYXSqywfj3TC5py7nlIJ3NYI+5qjkmqAFaFBty/i?=
 =?Windows-1252?Q?6AXSq9zXx72a616rvyBi9+AprutaghchLNBhTkRtTYVP+j99UK6fv3iq?=
 =?Windows-1252?Q?g8cGSY+0131viv5ULppw+ia7SyE50MTVYI06gbwvKrfDUbs8sB6V1d13?=
 =?Windows-1252?Q?Bx2PFWUuLOhXV3f31lbHykwbJYKblv5ehB9+5oMOZxSfMwVZyFTE94cY?=
 =?Windows-1252?Q?NoB1GSoU/EOQU3HjH26MEjC+jKJbKmVfBxJUZKayIuOUvESAwhNQYeix?=
 =?Windows-1252?Q?U1/IqPX/dihjlWfO92mrrG8cQdS2bbDGMitG3khyAv4bYgipWavRQ4XI?=
 =?Windows-1252?Q?bTYYQu4k0/nuf9w05Df3CDcsYPOubePuXxEeXicOQ2yvsWMLwqtTHmv0?=
 =?Windows-1252?Q?glUueK1Q8fWF0q4qshC3a+YZJsHk5EyRlwJTYxIkg1kETlYddBsPbhhm?=
 =?Windows-1252?Q?BjX+2mWX4Fa3QkxBvJwB0nndNCdz+35Ba6R/dBE4PY8V40KONMRwHqRT?=
 =?Windows-1252?Q?U5cIXe0NWHVVrUhNF1mBsD2o3TlOh4zTdG23q3LJMHIY9RCHfL2aAERf?=
 =?Windows-1252?Q?IslnIZgCKo5NerhGQmIW3oKl2kCA/iVMakZvfXGeLWkca+tIMgLIsfEW?=
 =?Windows-1252?Q?KCOqpuUPnE2hY89NyBZf2JmSElV2Et1he7sIGM4Gseof6KwBflBagbs5?=
 =?Windows-1252?Q?HgGJW1IhEBIXVHta4dGdHdws34CfwYqZIfITqYqhnYYcgUhzy0I2uZLW?=
 =?Windows-1252?Q?prIIMlbjeKoy5LZvBYf4eHcPbOQ6wU9Y0XMMwU1m+j8gsN5SgHt1NPH5?=
 =?Windows-1252?Q?d9xFW9TjHmYMdYYGf5636VM1S2Za5qn9yR3n12D2LGadfLXnjM1AaHOV?=
 =?Windows-1252?Q?gW9AwMkFovqH90cqEcWrkNxQcIlgXlpPndjSGB5wOFSAcMNWHNkaRwe1?=
 =?Windows-1252?Q?036mfDfldWxN0a/LOPa349sCTrHc3zTrEWBxFswXCFcJAHdLhLFWAjPr?=
 =?Windows-1252?Q?mDphRPX+7Vms5/YBp7V1TtAOFnNufgrhA25Iuc0bI5RmFBbcfeNdY/jk?=
 =?Windows-1252?Q?v1x4dsfMIfRZw9gjUoresedxgSQjTaMWNpKyllr2cP9C/YvXV8MSEsCS?=
 =?Windows-1252?Q?HnqUgHv143Kkcg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB11247.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ab5ed2-a245-4972-efbf-08dee0c95c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 10:27:37.7333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H15Ab1DtoPdZhJeAPYxIcn1jR3Ahbb8VqsBcnhLsYwqpnMlCRfEU8DBmBCwIevsI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10603
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.36:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,kernel.org,st.com];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.72.36:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3D1F944D93
X-Spamd-Bar: ----
Message-ID-Hash: UT6WAH5MYDSF62HU5WSMB6OLVZSALG6W
X-Message-ID-Hash: UT6WAH5MYDSF62HU5WSMB6OLVZSALG6W
X-MailFrom: psirt@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="Windows-1252"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "joakim.bech@gmail.com" <joakim.bech@gmail.com>, Arm PSIRT <psirt@arm.com>, Evelyne Donnaes <Evelyne.Donnaes@arm.com>, Jerome Forissier <Jerome.Forissier@arm.com>, "jenswi@kernel.org" <jenswi@kernel.org>, "etienne.carriere@st.com" <etienne.carriere@st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2APAA3VOTPARA66VVYLFFZRTF3MT3T7J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi op-tee team,

As part of the Arm bug bounty, we=92ve recently sent a few messages to op-t=
ee-security. Unfortunately we haven=92t had any responses since Jens left L=
inaro.

Please could we ask who remains on this list so that we can reach out to th=
em directly?

Many thanks,

Arm PSIRT
