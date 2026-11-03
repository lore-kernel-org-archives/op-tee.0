Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1D1606D80E
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KS/gEZeJ
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 16BDC45466
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 17:03:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KS/gEZeJ;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013000.outbound.protection.outlook.com [40.107.159.0])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 560CD44E15
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Nov 2026 17:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zy8gGN67gMRpNgANHCZ+daC5NQHQsYCrHIXUQtn0IT33JoinOrldkTXgRpj4tPOeltu87tzAce/G+lhSxGfu9fKcTi0M73aDNYxzuuHxepQTvsF+JtSkkOq06gmqORboHtNc+4TEAZ2YDEd8y9H/MFZT0YbMs9Z8vQ92wQ88n0y4Tu9acNhrfmf180f3RZo/swPXW+/hzL0b3uMJQTTFwXJ3IkhypkAtuKr6ry4MNzHGIdC334A8EaYqU4J/pfaPd8mR8fHKgMz0ifIjis+HbRVo1drQI9HfN/pkJM4YEK8OiTfxntoFNjEfAtQ+HUsyZNN1tLoxGqcTf6fBn0Y/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/ZKNd7s9afKeJajdeeAJsDX4w2EmwcC4aq/Qx9tt8g=;
 b=G6BDBJ2W8wMNmxHOYuy6sUJvm67sFX33SFphsPlcPgd53apfsGDOoIFIWB/Y3qYVN4Y5cprZIZmYw3Dp8+MzwjU/0kh3/9ydPHW8Ma9e9Igags5m5OqCLed8gXqxUca/EVjdsEXY506nO14iTlHrVBaZvcfB6J7AHEs97rag6hJCUozh0pU2xFrG/wNjanOpOVzrpONjOf5YBYvg55OxI9HaLDOOmjbe35wemSm+MQXwTG3fY+G6U2lA1Sb7q8n9qQTqvmePWXnWZIxhOXyOdqEGfSul/+2qdalfiwm2GUxmEyV55zO752U6VtxR6bIPgd8erIdAvSLQaoOFyax8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/ZKNd7s9afKeJajdeeAJsDX4w2EmwcC4aq/Qx9tt8g=;
 b=KS/gEZeJUVDbDWsMvj+iGUxhgmb0UUP1mU98Se63g7SscbqxoAAmWUr80u7ly+rh+vqjchTHoyCh+pXY3V7D45XCkWdBewCo7ikZyOoxyVXqHuGcBibydEhcl1Z/Kuy3R35HPxVfItFrf12Jea+dd6GGdd9noXXEdQEaMM9kbm5t1rY69KeF//FDUCXhzPSuiBqKmGOx6KIdYd/Xy5w7l8lFunKQUytvXZZUNoxYqEhONbIg9iLM752dUxyLFaDyhDvb3215uD/qTQr1/UfAK4Giu+ooWQVpfiBQdYM2FopcZ0euqk4NDsATCrzyvDcyGzCZiPQRAd3JY1oFghRboA==
Received: from AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24)
 by BR0PR04MB764495.eurprd04.prod.outlook.com (2603:10a6:2c8:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 17:03:36 +0000
Received: from AS8PR04MB7590.eurprd04.prod.outlook.com
 ([fe80::3470:a76d:78f7:317f]) by AS8PR04MB7590.eurprd04.prod.outlook.com
 ([fe80::3470:a76d:78f7:317f%7]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 17:03:35 +0000
From: "Marouene Boubakri (OSS)" <marouene.boubakri@oss.nxp.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, "Marouene Boubakri
 (OSS)" <marouene.boubakri@oss.nxp.com>
Subject: RE: [GIT PULL] OP-TEE update for v7.4
Thread-Topic: [GIT PULL] OP-TEE update for v7.4
Thread-Index: AQHdUn2hPGd8e8aJOEKC7gWJ7+s2drb7oDKAgAEG2ACAIALCgIAAG4IQ
Date: Tue, 3 Nov 2026 17:03:35 +0000
Message-ID: 
 <AS8PR04MB75909BDC3F24F08D5723ED43FC692@AS8PR04MB7590.eurprd04.prod.outlook.com>
References: <20261002145140.GA784348@rayden>
 <522a2d28-2ac9-4a56-8a61-477be3dfbbd9@app.fastmail.com>
 <CAGgiveUDQvqpJKo4XuboP_46t7DPSBT1jdaTafROvobk2V5mwQ@mail.gmail.com>
 <CAGgiveWadMfHBMu=vSeqwgoz8rcXXg4E9OrAKnkWPPFn07pimw@mail.gmail.com>
In-Reply-To: 
 <CAGgiveWadMfHBMu=vSeqwgoz8rcXXg4E9OrAKnkWPPFn07pimw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-11-03T17:02:44.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB7590:EE_|BR0PR04MB764495:EE_
x-ms-office365-filtering-correlation-id: 62b2f4a3-fbcb-425f-eaa0-08df39cc660c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|19092799006|38070700021|4143699003|11063799006|56012099006|261009223027099003|261022075727099003|261026121527099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 
 cBlFtA7YMLxjCjHmKhA0hYWHCYj0ydASANnRAjo2s5BG727LqwmADDm9B+7PwICmG0klgRq5nsD75dyoVlIo0wcJWZ3DthrM5YpsRhqBQ22QJy084KCJakrnUkYLMrXgrJFmgYaZE0nByCJO+6CNLU3NP9aKiC+H1Dqp8cB5xwiOFMHEOgQ6attnn66O38N1jvYc3JSV2XOd1vYgEDZuY2p6m9/cU8iNORZT8PiSRgSxb2pJNYNFyzJbJjCyAFY7iKp6xHVk5ezbZNHdH5Gn6seXUVsNILk21nHqxzLLYBn0QbzATTSOP0GltkfyoQrEhdgpze80KNP9uppnrvLeMbVaZCt+bO3hmjBKkjG9G19UE5UwhgBp9sfpaJ7fiXquvbQaq6406pfIUhR0FQAI6tnxLYKysW2sK026Gcsk1318KeEJmYkZGLZBTVeLKkn24Hkz10x6HZIdZxMtpq7kfjNiOwTLtlqpRQGKpNYsJpkHhpPyfT+wBIoQk603ZPLKwhYRxWO/CWI7+GasDkrDq11i2KucCe2Jn4l7U5arcKZYnAe8VzX6fPeJi46bVjbex59S/gyJKMxnv1bJ+aqeRLJMGMKqaeNn4oTpWVj1SdY31lw8FfW9ngvLO2zLq8O8+4YX8AleGE8B7WDIbU4m2bxX6k2Wy9kiL8t+I9dXOQDt5xDxzyoLIImLvk11a3FT
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cU8zR0pzeEMvZkJCRzY4RDg5T1BQeVV0bTR3T1ZTTTlmVTY2bCthSG9Nc1ln?=
 =?utf-8?B?SWdYNHE0NVhhc3lzUkduK1J5cEd3aXlJUFQ3N1FJeFJ1L2taZitiVW9oUTlk?=
 =?utf-8?B?VHp2bDFzbG1pZWVyM2ZuKzR4RjFRNStsekpHUitrVjN4WGNHdVl6cHdKdXNa?=
 =?utf-8?B?NWhpTkRmR0FSQ1c1WktENVRYM3pzalNCUVgvRXd6bWpwUktSSjMxOENtOW1E?=
 =?utf-8?B?MTYrM2NrUHRNK2lJUzJpMlN6MEg0eXI0VFk4TUNRUnpmYzNSREhiMDg4ZlYz?=
 =?utf-8?B?V2lKeHk2LzFncVJZSS9ZTElGRVJCQXUvQ0RxK2E3NE1SRk9yWHR3Rlo0aGtD?=
 =?utf-8?B?Y1l3a2M0Q3h2STFRU2p3R1ZDOWlTTFJ6ZGszSDZMbkthNUlhOU02QmQxblV0?=
 =?utf-8?B?RDFSSSt1UDltQURwbW1pdmxUNFQ4WVc3TFBvMXNnZmJaOUZUd0pOOVNrb3Zw?=
 =?utf-8?B?ZkRPOExPeVRPdWJNbGdqblRuSHRMcFpodFdLcXhNc1JsaGRFRE0xMU1BWnVk?=
 =?utf-8?B?aVYyb09QRDlrY0tHMzU3d3hMREZFSy92cXRKNEtvZmhicnVwS3hKcjlsM1Yx?=
 =?utf-8?B?SzNwZUt5anoycnV3L3NlMUFmZk9sUVVDNlV3eldSTnRoQi82MUppbVlVd3Yw?=
 =?utf-8?B?b1NpSmYwWVNzWFZyaW5qa0pmMld6WTdtREpvbWdpdTlZa3pqVVhjWkRBU0Yr?=
 =?utf-8?B?b2ZZcnpaR1VlS2xRWUZNRFhrQkRnWVptMjBjbFlkb1RwTnJMYmtCdlBvNHhC?=
 =?utf-8?B?ODQzWDMzWWhjNnJUMkhlcXByVEVTNm0xVUVtSmlQRUYyaGRCMnhkeXd2QTRN?=
 =?utf-8?B?U2xlZ1Q4aEEwdnJKaVRzTkVGQmlpMmorbkpYaVNqdWlDN09xR09xMDhnVUpz?=
 =?utf-8?B?MWplQ3pIYmVSMnU4N0tzaDBCcUtnWHdlVm9Wc0NlNEc3dkFVOXBMWUphMDAr?=
 =?utf-8?B?K3FuZ0diMDlsZnY4TUdCeEx4WHFzTTZIbW9aT1pIc2htOU4xRmlVcGlER0ZO?=
 =?utf-8?B?QnhTd0M5WlV0SDE3OENIY05XNkUzTVNVelJtYzFEdCtYTERWOXVwcEl4aFVu?=
 =?utf-8?B?Z1czbE05QXJSdW1DallVWnU5YjZZU3VHL0FWZkVtSjVFWjlKK01iLzVJRE13?=
 =?utf-8?B?YlJQUG40TGpMeGdPeEZQcDd2NE1nMWhLSXFueUtkVXh6aGM2anhzZlRyS1By?=
 =?utf-8?B?TFY0bW9lRm9DZS8zdTVkNWwvMUo5SzA1aEZPZitocU9YMlEzNVBldjVlU3Nz?=
 =?utf-8?B?eGFwTnpKUndCUlpzY296aTR0TzcvY1VCNWhNN05lY0dSTzYyVSt6MVYxV0hE?=
 =?utf-8?B?ZllUNzhJYUQwUWhzQ1BvODR3NzlNZnk0bEJDM3kyQUFPWkxrZE5OV0RodW84?=
 =?utf-8?B?WU4vZkdRNUprcnhJTzZvcm9rdHNCSmhIRldyVUZCYnFXckJvaFJzWW1xRTNs?=
 =?utf-8?B?ZkRaWDMxZHlNV3ZQMU1oNTJUVnRPbTkxby96MnVXLzhKMU9jRXp0LzBuSHhD?=
 =?utf-8?B?MWZmTVhQS1hpTEFVSEcvcjZqaTlhUThYVEUyMmtCS1ZYUTR6RHVHOHFPaHFF?=
 =?utf-8?B?NllrMWxlbXJIK1VudnJsRWRSQ3JoenZ6cTZIejVROTB1K0xSMGVzcnkvakZt?=
 =?utf-8?B?ek9yd1F4WHA4aTFjN3BDT0REOXk4eDZDd21JTWIzSnhjRHlqSU9yMStjNERN?=
 =?utf-8?B?dnBoaFFnL0JFcmlvV2UyT285b05FMWdkVEJEc3ZkdEp3dWM1ditwcnJlbnZY?=
 =?utf-8?B?ZkxnOFZxaUJRZzFQUjdjVGlLOWpsQ0czeEdvYXJyYXZwaERNaTA5dUFhYUd3?=
 =?utf-8?B?ems1MEx1RVVvRzd3dVB0NzFCRUY0OTllU1hOWlp5UXpZektUU2dFMmluQjFQ?=
 =?utf-8?B?dWRzUTZrbkIzRlRzdGh3cjhNZ3lMU2lOR2dLSjlLM0VPOXVjMjJ6NlNJWVVy?=
 =?utf-8?B?SEluZzducFhoazBpMEJLUDJaUCtNeUxsWXMzb3pFUnQ3bjE3L0pnSWQvL0M3?=
 =?utf-8?B?VkppNHdxUXNjRDExNmRGaUtmb0xLcHVTQmFNZFNmZkF1ZCtpTFdrVlU5b3lM?=
 =?utf-8?B?dUVyRUFZa1JERUFJTzZ1OXBmZkVDUllibUJNTEp1RTdIMWJvcW83QmNNM09F?=
 =?utf-8?B?Ym96WWFDMm5oVlF3QzFPYUwzdjFZcmhzSjFxYUcwRWkweWhCbzhsM2wzaGpy?=
 =?utf-8?B?cE5tK1RKRzNiN3p2QlBzQVhNQ1VDRVlaWHJJT0tSYWJhdThVSG9OcnIzNldF?=
 =?utf-8?B?Vlg0NTVIOUV6SXREdm5BRHg3QjF2d091T25RU1diMWtoNi9raXF1OCtzRXRk?=
 =?utf-8?B?b2RpVzRtaFpVcDVjVkNHaG11YllIRlNYZXRPSWZPSzJLTjZ1T0RuZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b2f4a3-fbcb-425f-eaa0-08df39cc660c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 17:03:35.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdvHu40gIn3ZbB6VGbOteI9shITzs+BKip1kkQECNp/KfDGgJ1EBeaNXeIxOpjSRlWW5gdO0BPXu9v4hVHGtI3qMU2j3JV3hsYPkGzTbppk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB764495
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.0:from];
	DWL_DNSWL_BLOCKED(0.00)[onmicrosoft.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.159.0:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:23d::24:received];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 560CD44E15
X-Spamd-Bar: ----
Message-ID-Hash: ICYJTDA2H7YOWQLJRXK3ANW7URHLKX4O
X-Message-ID-Hash: ICYJTDA2H7YOWQLJRXK3ANW7URHLKX4O
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm <arm@kernel.org>, "soc@kernel.org" <soc@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Arnd Bergmann <arnd@arndb.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2POXLACZR4ULYLDP5BEVS2E7SOQT5VXD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSmVucywNCg0KDQpOWFAgQ29uZmlkZW50aWFsDQpPbiBUdWUsIE5vdiAzLCAyMDI2IEplbnMg
V2lrbGFuZGVyIHdyb3RlOg0KPiBDYW4geW91IG1ha2UgYSB2NSBvZiAiW1BBVENIIHY0XSB0ZWU6
IG9wdGVlOiBidWlsZCB0aGUgQXJtLXNwZWNpZmljDQo+IGNvZGUgb25seSBvbiBBcm0iIGFkZHJl
c3NpbmcgQXJuZCdzIGNvbW1lbnRzLCBwbGVhc2U/IFRoYXQgaXMsIHJlcGxhY2luZw0KPiBJU19S
RUFDSEFCTEUoKSB3aXRoIElTX0VOQUJMRUQoKSBpbiB0aGUgcGF0Y2guIEFzIEFybmQgcG9pbnRz
IG91dCwgd2l0aA0KPiBPUFRFRSBkZXBlbmRpbmcgb24gQVJNX0ZGQV9UUkFOU1BPUlQgfHwgIUFS
TV9GRkFfVFJBTlNQT1JULCB0aGUgY29kZSBpcw0KPiBhbHdheXMgcmVhY2hhYmxlIGlmIGVuYWJs
ZWQuDQoNClN1cmUsIEkganVzdCBzZW50IHYgaGVyZSAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjYxMTAzMTcxNTA0LjkxMDY0Ni0xLW1hcm91ZW5lLmJvdWJha3JpQG9zcy5ueHAuY29t
L3doaWNoIHJlcGxhY2VzIElTX1JFQUNIQUJMRShDT05GSUdfQVJNX0ZGQV9UUkFOU1BPUlQpDQp3
aXRoIElTX0VOQUJMRUQoQ09ORklHX0FSTV9GRkFfVFJBTlNQT1JUKSBpbiBvcHRlZV9wcml2YXRl
LmgsIHNvIHRoZQ0KbGF5b3V0IG9mIHN0cnVjdCBvcHRlZSBubyBsb25nZXIgZGVwZW5kcyBvbiB3
aGV0aGVyIHRoZSBpbmNsdWRlciBpcw0KYnVpbHQtaW4gb3IgbW9kdWxhci4gVGhlIHJlc3Qgb2Yg
dGhlIHBhdGNoIGlzIHVuY2hhbmdlZCBmcm9tIHY0Lg0KDQpBcm5kLCB0aGFua3MgZm9yIGNhdGNo
aW5nIHRoaXMsIGFuZCBzb3JyeSBmb3IgdGhlIG5vaXNlLg0KDQpUaGFua3MsDQpNYXJvdWVuZQ0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVucyBXaWtsYW5kZXIgPGplbnMu
d2lrbGFuZGVyQG9zcy5xdWFsY29tbS5jb20+DQpTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAzLCAy
MDI2IDQ6MjQgUE0NClRvOiBNYXJvdWVuZSBCb3ViYWtyaSAoT1NTKSA8bWFyb3VlbmUuYm91YmFr
cmlAb3NzLm54cC5jb20+DQpDYzogYXJtIDxhcm1Aa2VybmVsLm9yZz47IHNvY0BrZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBvcC10ZWVAbGlzdHMudHJ1c3RlZGZpcm13
YXJlLm9yZzsgQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NClN1YmplY3Q6IFJlOiBbR0lU
IFBVTExdIE9QLVRFRSB1cGRhdGUgZm9yIHY3LjQNCg0KSGkgTWFyb3VlbmUsDQoNCkNhbiB5b3Ug
bWFrZSBhIHY1IG9mICJbUEFUQ0ggdjRdIHRlZTogb3B0ZWU6IGJ1aWxkIHRoZSBBcm0tc3BlY2lm
aWMgY29kZSBvbmx5IG9uIEFybSIgYWRkcmVzc2luZyBBcm5kJ3MgY29tbWVudHMsIHBsZWFzZT8g
VGhhdCBpcywgcmVwbGFjaW5nIElTX1JFQUNIQUJMRSgpIHdpdGggSVNfRU5BQkxFRCgpIGluIHRo
ZSBwYXRjaC4gQXMgQXJuZCBwb2ludHMgb3V0LCB3aXRoICBPUFRFRSBkZXBlbmRpbmcgb24gQVJN
X0ZGQV9UUkFOU1BPUlQgfHwgIUFSTV9GRkFfVFJBTlNQT1JULCB0aGUgY29kZSBpcyBhbHdheXMg
cmVhY2hhYmxlIGlmIGVuYWJsZWQuDQoNClRoYW5rcywNCkplbnMNCg0KT24gV2VkLCBPY3QgMTQs
IDIwMjYgYXQgODozNOKAr0FNIEplbnMgV2lrbGFuZGVyIDxqZW5zLndpa2xhbmRlckBvc3MucXVh
bGNvbW0uY29tPiB3cm90ZToNCj4NCj4gSGkgQXJuZCwNCj4NCj4gT24gVHVlLCBPY3QgMTMsIDIw
MjYgYXQgNDo1M+KAr1BNIEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+IHdyb3RlOg0KPiA+
DQo+ID4gT24gRnJpLCBPY3QgMiwgMjAyNiwgYXQgMTY6NTEsIEplbnMgV2lrbGFuZGVyIHdyb3Rl
Og0KPiA+ID4gZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGNjZDRiMjMzOThhY2FmMjEz
OWNmMDRmMWJhMGE2NjE1MGNiZjI2NjM6DQo+ID4gPg0KPiA+ID4gICB0ZWU6IG9wdGVlOiBidWls
ZCB0aGUgQXJtLXNwZWNpZmljIGNvZGUgb25seSBvbiBBcm0gKDIwMjYtMTAtMDINCj4gPiA+IDE2
OjI4OjQxICswMjAwKQ0KPiA+ID4NCj4gPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+IEJ1aWxkIHRoZSBPUC1U
RUUgZHJpdmVyJ3MgU01DIGFuZCBGRi1BIGNvZGUgb25seSB3aGVyZSBzdXBwb3J0ZWQNCj4gPiA+
DQo+ID4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gPiBNYXJvdWVuZSBCb3ViYWtyaSAoMSk6DQo+ID4gPiAgICAg
ICB0ZWU6IG9wdGVlOiBidWlsZCB0aGUgQXJtLXNwZWNpZmljIGNvZGUgb25seSBvbiBBcm0NCj4g
Pg0KPiA+IEkgaGFkIGEgbG9vayBhdCB0aGUgY29udGVudHMgYW5kIHNhdyB0aGF0IGl0IGtlZXBz
IHRoZQ0KPiA+IElTX1JFQUNIQUJMRSgpIGNoZWNrcyB0aGF0IGFyZSBub3RvcmlvdXNseSBlcnJv
ci1wcm9uZS4NCj4gPiBFLmcuIHRoaXMgcGFydCBqdXN0IGxvb2tzIGJyb2tlbjoNCj4gPg0KPiA+
IEBAIC0yNTcsOCArMjY2LDEyIEBAIHN0cnVjdCBvcHRlZSB7DQo+ID4gICAgICAgICBjb25zdCBz
dHJ1Y3Qgb3B0ZWVfb3BzICpvcHM7DQo+ID4gICAgICAgICBzdHJ1Y3QgdGVlX2NvbnRleHQgKmN0
eDsNCj4gPiAgICAgICAgIHVuaW9uIHsNCj4gPiArI2lmZGVmIENPTkZJR19IQVZFX0FSTV9TTUND
Qw0KPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3Qgb3B0ZWVfc21jIHNtYzsNCj4gPiArI2VuZGlm
DQo+ID4gKyNpZiBJU19SRUFDSEFCTEUoQ09ORklHX0FSTV9GRkFfVFJBTlNQT1JUKQ0KPiA+ICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgb3B0ZWVfZmZhIGZmYTsNCj4gPiArI2VuZGlmDQo+ID4gICAg
ICAgICB9Ow0KPiA+ICAgICAgICAgc3RydWN0IG9wdGVlX3NobV9hcmdfY2FjaGUgc2htX2FyZ19j
YWNoZTsNCj4gPiAgICAgICAgIHN0cnVjdCBvcHRlZV9jYWxsX3F1ZXVlIGNhbGxfcXVldWU7DQo+
ID4NCj4gPiBUaGUgcHJlc2VuY2Ugb2YgdGhlICdmZmEnIG1lbWJlciBpbiB0aGUgdW5pb24gaXMg
Y29uZGl0aW9uYWwgb24NCj4gPiB3aGV0aGVyIHRoZSBkcml2ZXIgdGhhdCBpbmNsdWRlcyB0aGUg
aGVhZGVyIGlzIGEgbG9hZGFibGUgbW9kdWxlIG9yDQo+ID4gYnVpbHQtaW4sIGFuZCB0aGlzIGNo
YW5nZXMgdGhlIGVudGlyZSBzdHJ1Y3R1cmUgbGF5b3V0IGlmIGJvdGggdHlwZXMNCj4gPiBvZiB1
c2VycyBhcmUgcHJlc2VudC4NCj4gPg0KPiA+IFRoZSBpbnRlbnRpb24gb2YgdGhlIHBhdGNoIGRv
ZXMgbWFrZSBhIGxvdCBvZiBzZW5zZSwgYnV0IGFzIGZhciBhcyBJDQo+ID4gY2FuIHRlbGwsIG9u
bHkgdGhlIEtjb25maWcgY2hhbmdlIGlzIGFjdHVhbGx5IHJlcXVpcmVkLCB3aGlsZSB0aGUNCj4g
PiBhZGRlZCBwcmVwcm9jZXNzb3IgY2hlY2tzIG9ubHkgbWFrZSBpdCBoYXJkZXIgdG8gcmVhZCBh
bmQgaXQgc2hvdWxkDQo+ID4gaGF2ZSBiZWVuIHN1ZmZpY2llbnQgdG8gY2hhbmdlIHRoZSBleGlz
dGluZyBJU19SRUFDSEFCTEUoKSB0bw0KPiA+IElTX0VOQUJMRUQoKSBmb3IgY29uc2lzdGVuY3ku
DQo+ID4NCj4gPiBTb3JyeSBJIGRpZCBub3Qgbm90aWNlIHRoaXMgb25lIGVhcmxpZXIgYXMgSSB3
YXMgdHJhdmVsbGluZywgYnV0IEkNCj4gPiB0aGluayBJIGNhbid0IHB1bGwgdGhpcyB2ZXJzaW9u
LCBwbGVhc2UgcmVzcGluLg0KPg0KPiBUaGFua3MgZm9yIGNhdGNoaW5nIHRoaXMuIFdlJ2xsIHJl
cGluLg0KPg0KPiBDaGVlcnMsDQo+IEplbnMNCg==
