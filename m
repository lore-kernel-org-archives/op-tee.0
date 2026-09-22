Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAABFC982FA
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 13:07:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F201D4537E
	for <op-tee@archiver.kernel.org>; Tue, 22 Sep 2026 13:07:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=A6d128R1;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013026.outbound.protection.outlook.com [52.101.72.26])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1130644F8E
	for <op-tee@lists.trustedfirmware.org>; Tue, 22 Sep 2026 13:06:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVKjL1Vy+r57LEEDEZnAFe5fzUPe7hUYixt5m5RPYg6UkZajLnFzBBLZ981KjqAE2uwHO7VvE0oZwxdLyA1tDuXs39q6diCLjoRDDlEwffseujSltbEqv+n5FdK2CLMFFpKzLDTnz3rXkP8EvM78YdzyA+BA2xU40o47XAVcAbhpQW1RQW+apMCPdkmply8oenD0UcVwooEwiXIquDJwCZJ9qGlL/VGtNSfeEHdSq0s8FJo14ydA18xKhbr/x/U1zfgqE8CAcd5Amrc5vCXO3jtQpIdF0xNul1Xa2ZwJOAVvf270KxiMpWpfRANqy7xvs3lcfukozDS55QiXbSA5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRDfd1NltHveOjMIyCeV7gjVQNSrywNHweiQDyH1qkE=;
 b=SQmjFNTbfTBsHKTOMXcravI4mj7747DJmPgx0MSGtzpOyIY/LNnc/O7f7Fqa2fXOBICYdiEGZOMqQn3dbJ8y5XiWoQvhRlkZX8W/jadIl39ek1ggcOU5whCITl9vMbOw3mpEnIuEUkxTa9G2KTGwKjp6ez40Vy/uWY6Lk916uDOBh9+m2J6WySno0K77Zoa09YNH86ON6glxIhcuqYbk0pm8L9F4YvNJJ5vjlyRHWrv9jLM2bwiiJou1dwiH75dfENdbxJf0+0jFvr6KlYcmLOpD12bC++St0lDkY4LR3vPHImpcCJ2CItDzRU7H2yCOYnFAvWLJk1uzJ1pJcGTAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRDfd1NltHveOjMIyCeV7gjVQNSrywNHweiQDyH1qkE=;
 b=A6d128R10SZ4brYVGW13iLIOtnDEQhaS3bnjnVRf5dJnO15ADyS0XpuA/fJv0hYuQLqJG5Rmgi8m24h4VDbxpKuAF9aVvW1IKewNLBCjrPHcyUtIUHpY0aYjEunLI3iuRNXaJXuqe5g/uRER0KH72zdPYEh4yZdTvSsyZouTR1ennA1Rw/byORlWSfwOjF+zPUCAMrKBd6EsFa/6GG5c1FJ+Ul8YTWKQHiW/LrxpMKOdyI7aUVmunQw6AD2MOUB8EmzXEOje5T2fMb/wolA29+B5mX5TnZXIZpAPvQPVx251Q5kee+sqQ6BK/QQl8zYqamu5xidu4Sru6VmGPwNlAg==
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB12039.eurprd04.prod.outlook.com (2603:10a6:150:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Tue, 22 Sep
 2026 13:06:53 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::37dd:8aa6:c6a5:c832]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::37dd:8aa6:c6a5:c832%3]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 13:06:53 +0000
From: "Marouene Boubakri (OSS)" <marouene.boubakri@oss.nxp.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>, "Marouene Boubakri
 (OSS)" <marouene.boubakri@oss.nxp.com>
Subject: RE: [PATCH v2] tee: optee: prepare the driver for RISC-V
Thread-Topic: [PATCH v2] tee: optee: prepare the driver for RISC-V
Thread-Index: AQHdRLRWR7fBlakHOkaR75DDojX3X7baRV+AgABXIfA=
Date: Tue, 22 Sep 2026 13:06:53 +0000
Message-ID: 
 <AM9PR04MB7586305DAFAF4DDD556DE276FC832@AM9PR04MB7586.eurprd04.prod.outlook.com>
References: <20260914175435.118303-4-marouene.boubakri@oss.nxp.com>
 <20260915020235.507302-1-marouene.boubakri@oss.nxp.com>
 <CAGgiveUEFL+UWzydBGxVveadffpO3BWbKjQ1UbJ_dOPgLu2m4A@mail.gmail.com>
In-Reply-To: 
 <CAGgiveUEFL+UWzydBGxVveadffpO3BWbKjQ1UbJ_dOPgLu2m4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-22T13:04:52.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|GVXPR04MB12039:EE_
x-ms-office365-filtering-correlation-id: 176c2b81-104c-484d-69ea-08df18aa5f4f
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|38070700021|56012099006|3023799007|6133799003|10067099003|5023799004|4143699003|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: 
 hjDHrEr6O2fjzhSvWZ8oHB7DzCvFL83gpn6KvxhunbEyqT2M7xiEqQC5gFuRG+90XsxtM+238RXE+oYeCEKtN3nk77tKbotRJICESq1n0rFuwz9tmETl0pvLNyrlDd4pQEcTznugrQTDLSMIJSISb5xCU/fmMti1T9EI4mwQ7N/hcQgwGJf4XL64K2CMmaiPAIx1cUkhoJAn9KhbgKE8JZXcgNajSDuhaZaVIKWBnJbeOwDQJesYA4r6dNFIL9tLSsdbm/XpVjSwerw3hhKXuRyfuyw14JT7dFAL+Q28xZgtgR3aC51XR0hwg6fk9YfHKScFV5OarAKevtytxAkxEo3caqIUOG614/9owq7onRH8Zqkujg3jvPpMx1E8L5RVQ3xieaKagBc4TsXJQgO0b6dgHuYC47P/eQDckYMWmpzSLJuwu8oZlFlwD/ljX/cW+0FXdMY+RZK4iVzVcQFY1KIFvfCdn4g3nvxQPxsPZEvHC3dzg3s9EJwvsWl2w0HaLgEO6F3WpqDyn+Rf94H5KRZNBqqzY9/h6rFsclI/P9qSdq3c4f3NN+bTN/0ogNSkLZac1VI5BnM9eSnnCK2G+Fesa/6bso3Fs3CdYkrXqL5d7tMt7rooJkcb4ILdwoh/ClHLP+xO+mqq+KnX2i++3HxSBwdom/mPKYFcgUnFCGBQkLRtF3NHm2X9Ac2hy+4P
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(38070700021)(56012099006)(3023799007)(6133799003)(10067099003)(5023799004)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?enJxU1JvaGtheVRQUXFRL3BWZHgwcEh3VTkxWlQvSGsyQWJueFNFWWpCelor?=
 =?utf-8?B?UEtyU0RhZytrd2tkbXlIRVAxcDJZcFV6TzhwblJZeGJCUnlSTFoyeWhDVnNx?=
 =?utf-8?B?ajFLVUNqT3l6R0plZ3poNGFGSUgvWGJXYnZVWTQxSldUN21KYzlaT2hIaS8z?=
 =?utf-8?B?TUxKUk5lZTZFK2ZPOG90WGFVbEIzd3djZ2tFMXk1K1ZWRG1welRXdHhzWG1G?=
 =?utf-8?B?NVhwMlF0bURxRTZBSEZGcDQrZnNrMGgvVUZjMU9saU9yWVROdmN1QUFtajR2?=
 =?utf-8?B?ODhnQ3B0SVNtSllDTTF5WnhacnhKNEJGTmJaeTM5d1JYTnVXL1NvTUQ2L2R6?=
 =?utf-8?B?ZHFxSDNiTE42MisrWXZPQVNKWG9TUVVNK1NJUVRhdzVOSEtnZlJ5ejM3Qis0?=
 =?utf-8?B?MTR1T1RkS0QxSTFacHYzOFowSXU3bWVTZncwTkMzaDJkQitnaTZHMFlOQ3Nu?=
 =?utf-8?B?T2VHTGRyWXhkUys1VGhqQjN3b0dPUzF1a0hPY01xVlpVd1IzaVJ5MGRFL2Z2?=
 =?utf-8?B?bGtXVllpVkZndVVZaGQzeE5kT0xqREEzSEc3V0Iya2ZrakwreFJ5OUh2M1Bo?=
 =?utf-8?B?Sjg0WXpUUEFtcUtkWCt5bDdGdHMvZy9hRm0vYTVOdXlvdW51MVgyblNUUlpV?=
 =?utf-8?B?TUZETGJyc1ZyZmNBQzN4RzA2V3ZoL2xxNmZnU0dNcXloK21PanpjcTJYSHJL?=
 =?utf-8?B?MmFOUnVONmZrUXhLNlZxWWpPQ2o4THFmOXpvZ2Ryb3VsQ01HMHV4TzZySllP?=
 =?utf-8?B?Unhmak85R0lNbG1NZ2w0aSt6VWFkbS9yS254bWkxd0NvMEc4SytUby9IblJS?=
 =?utf-8?B?ZTR6OFN3MjRSd01JeW9qWmMrNkEyTlV1Y3krZlBOWnZZV0lKV2pXUmVmNHdu?=
 =?utf-8?B?WmRHZEo2NmFFOHRISzZZdmV0ejB1Si94Y2NXQnhqSU0rU1VBMU9oRUFPTEN2?=
 =?utf-8?B?TFF1c08zSkdOMXdhb013YkxmMTI0cUFObHFybEhoWU85M1BVUStMenZ1L3lV?=
 =?utf-8?B?MnlQMFN3MFBndm5lN3J4eFJDY0hXRGxBaS9qN3hCWGUwTWJ1NUFXMit3Wlh6?=
 =?utf-8?B?ODZRZDVUYUE1bE02bDJ5d3h4aXAwUnQ0cEUzWElqa1F3L2xIeCtuLzJaOVZx?=
 =?utf-8?B?YURxd2s3NFN4TVM5ZGhWVGNTZXg1d0k5bW5CcXF2R2pFTHlPbWNmejAwL2ZI?=
 =?utf-8?B?MVVSSEs1cDNMWHNvL0hEdm5MREEzbW05ZHpaVHVRZGhhL29WTkFRbXFaUkVC?=
 =?utf-8?B?TnBRV3JDcXhMTDZ4eFBtTVJEVjY2eWZEdEJvYmxGblJoV2M3dUh0bHgxbm9j?=
 =?utf-8?B?Q3A2eGpSUGdubEsybkJ6ck5qRWp0NWhRVXV2c2I3QlZWbElVYlBXT2xKSlVZ?=
 =?utf-8?B?YkZWNjdLc2Y3ejd6aWtUWW9tSFRkQWQ5Q0VGNCtIVlJsdU1lQ3VWcXNhN08r?=
 =?utf-8?B?Mm1rVFh2RzNNR3FtaGU4aDBvbTI0eEhCTkFMM3U2M2FmSURiNFZlazJrcVVR?=
 =?utf-8?B?VVAwY2dCZ0d2N21Sd0FLTndWT283OXd0RlBBRFdrWVdrTDdxemQxekU4ZlVO?=
 =?utf-8?B?Skx1UnFjYmNEKytsei9IUEJ2NjZ0S0RDaXNXNldFNUt3QzU1VzJNYzdRZzRR?=
 =?utf-8?B?d0tZMVd2UWpXWHNLV3dNRGFhTy9HZmIwblNMRzdWY3UzK0MrZzE3R3d1K0FN?=
 =?utf-8?B?NUxpWUg2elRTMWhIUklFZnFrVnZjYnAvak1BVU1JTUt4TndQUVF4QUxvdE92?=
 =?utf-8?B?U0ZoNVlWcmZOT09FNGlPdGJ5MmR3ZUFLSGNORVZBYlBORjhkcStRck5ESklo?=
 =?utf-8?B?Sm9DK0V0emg0TjZHOGZtc1ltYldXRVBCZXdRVHZpbTM5cDVydDBnLzd2VW5k?=
 =?utf-8?B?YTNESGEwbXlkYlJ5Y0RpRE5SK1RWa1lMcWs2SDZ0STFrSE05Q25zM0NHNTZ5?=
 =?utf-8?B?TmJYK1JmNzZvUXk5SUI0a2lYQnRBa3doa29Xa1dDdWt4V29kdUxVQTZDSndP?=
 =?utf-8?B?ZkRPK0R3T1ZQMXl6VVRuVnRxUFJXdHgzakI1cEpBaVdxMXBVRXNUM3lkL3hU?=
 =?utf-8?B?WmZxeFhDQ25CQk1xVkZpRmJhUTVybmh3YUVHNk0wMEpkd0lMTFNHWURha2pa?=
 =?utf-8?B?T3J0aXdWWCtHUk5rUlk5bHJHdkZLSUxoTnA5NFZZTmRIaVlQaHlyOVlzakN1?=
 =?utf-8?B?QUhMN216cUNBQmF1UGUzQ1ExSjFOYkRuNU1NVjM3bjErM1gxK29lSXNBV0dv?=
 =?utf-8?B?S3hYU2xhbXNBTGxKcDQrYTlvaGRkTmlwQ0dESUlMUE50Q3VDQUc4VXJ5bndq?=
 =?utf-8?B?Sk53QWY4WWtDOEROOExUUWw0REM5NnptM01CL3g5d0daY1ZWd2wvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176c2b81-104c-484d-69ea-08df18aa5f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 13:06:53.2391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLb+x3/4P3EI/iji38mwOByLIw1J5CYFf04A/dooc+TTDlB9BSYhshEeLP0FFsppWR9CYNtFlVkLXNpuWYRVRJy/MynwrqllB3AtKDwAG7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12039
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.90 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.26:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:2d5::17:received,52.101.72.26:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1130644F8E
X-Spamd-Bar: ----
Message-ID-Hash: 665GUOVYSSI7UJOFW6KHJUCH4SWFRQNC
X-Message-ID-Hash: 665GUOVYSSI7UJOFW6KHJUCH4SWFRQNC
X-MailFrom: marouene.boubakri@oss.nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Peter Lin <peter.lin@sifive.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IHLPX2N33CKOZZGC3ADBXYVOQ3FHTD6N/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

SGkgSmVucywNCg0KDQpOWFAgQ29uZmlkZW50aWFsDQpPbiBUdWUsIFNlcCAyMiwgMjAyNiBhdCA5
OjUzIEFNIEplbnMgV2lrbGFuZGVyIDwuLi4+IHdyb3RlOg0KPiBJIGRvbid0IHRoaW5rIHdlIG5l
ZWQgYW55IGVtcHR5IHNoZWxscy4gSSdkIHJhdGhlciB3YWl0IHVudGlsIHdlIGhhdmUgc29tZXRo
aW5nLg0KPiBTbyBwbGVhc2UgZHJvcCBwYXRjaGVzIDIgYW5kIDMuDQoNCkRyb3BwZWQuIHYzIGlz
IHBhdGNoIDEgYWxvbmUsIHBvc3RlZCBhcyBhIG5ldyB0aHJlYWQ6DQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvMjAyNjA5MjIxMzE3MzUuNTI0NjM1LTEtbWFyb3VlbmUuYm91YmFrcmlAb3Nz
Lm54cC5jb20vDQoNClRoZSBSSVNDLVYgZW5hYmxlbWVudCB3aWxsIGNvbWUgd2l0aCB0aGUgdHJh
bnNwb3J0IGl0c2VsZi4NCg0KPiBTaW5jZSB0aGlzIGlzIGEgVjIsIEknbSBtaXNzaW5nIHdoYXQg
aGFzIGNoYW5nZWQgZnJvbSB0aGUgVjEuIFRoZQ0KPiBwYXRjaCBzdWJqZWN0IHByZWZpeCBpcyBh
bHNvIGluY29ycmVjdCAodGhlIFYxIHdhcyBjb3JyZWN0KSBhbmQNCj4gY29uZnVzZXMgdGhlIGI0
IHRvb2wuIFdoZW4geW91IHBvc3QgYSBuZXcgdmVyc2lvbiBvZiBhIHBhdGNoIHNldCwNCj4gcGxl
YXNlIGRvbid0IGFkZCBhbiBleHBsaWNpdCBJbi1SZXBseS1UbyBoZWFkZXIgaW4gdGhlIGNvdmVy
IGxldHRlciB0bw0KPiB0aGUgcHJldmlvdXMgcGF0Y2ggc2V0DQoNCnYyIGhhZCBubyBjb2RlIGNo
YW5nZSwgaXQgb25seSByZXBsYWNlZCB0aGUgdGVzdGluZyBwbGFjZWhvbGRlciBsZWZ0IGluDQp0
aGUgdjEgY292ZXIgbGV0dGVyLiBUaGUgY2hhbmdlbG9nIGlzIGJlbG93IHRoZSAtLS0gbGluZSBp
biB2My4NCg0KdjMgYWxzbyBmaXhlcyBhIGxpbmsgZmFpbHVyZSBpbiBwYXRjaCAxIHdpdGggT1BU
RUU9eSBhbmQNCkFSTV9GRkFfVFJBTlNQT1JUPW06IGtidWlsZCBsZWF2ZXMgdGhlIG9wdGVlLW0g
b2JqZWN0cyBvdXQgb2YgYSBidWlsdC1pbg0Kb3B0ZWUubywgd2hpbGUgb3B0ZWVfcHJpdmF0ZS5o
IHN0aWxsIGRlY2xhcmVkIG9wdGVlX2ZmYV9hYmlfcmVnaXN0ZXIoKQ0KdW5kZXIgSVNfRU5BQkxF
RCgpLiBUaGUgRkYtQSBwYXJ0cyBhcmUgbm93IGtleWVkIG9uIElTX1JFQUNIQUJMRSgpLA0Kd2hp
Y2gga2VlcHMgdGhlIGN1cnJlbnQgZmFsbGJhY2sgdG8gbm8gRkYtQSBpbiB0aGF0IGNvbmZpZ3Vy
YXRpb24sIGFuZA0KdGhlIHRoZW4gcmVkdW5kYW50IElTX1JFQUNIQUJMRSgpIGNoZWNrcyBpbiBm
ZmFfYWJpLmMgYXJlIGRyb3BwZWQuDQoNClBsZWFzZSByZXZpZXcgdjMgaW5zdGVhZCBvZiB2Mi4N
Cg0KVGhhbmtzLA0KTWFyb3VlbmUNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogSmVucyBXaWtsYW5kZXIgPGplbnMud2lrbGFuZGVyQG9zcy5xdWFsY29tbS5jb20+DQpTZW50
OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMjYgOTo1MyBBTQ0KVG86IE1hcm91ZW5lIEJvdWJh
a3JpIChPU1MpIDxtYXJvdWVuZS5ib3ViYWtyaUBvc3MubnhwLmNvbT4NCkNjOiBKZW5zIFdpa2xh
bmRlciA8amVuc3dpQGtlcm5lbC5vcmc+OyBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGtlcm5lbC5v
cmc+OyBQYXVsIFdhbG1zbGV5IDxwandAa2VybmVsLm9yZz47IFBhbG1lciBEYWJiZWx0IDxwYWxt
ZXJAZGFiYmVsdC5jb20+OyBBbGJlcnQgT3UgPGFvdUBlZWNzLmJlcmtlbGV5LmVkdT47IEFsZXhh
bmRyZSBHaGl0aSA8YWxleEBnaGl0aS5mcj47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IG9wLXRlZUBsaXN0cy50cnVzdGVkZmlybXdhcmUub3JnOyBsaW51eC1yaXNjdkBsaXN0cy5pbmZy
YWRlYWQub3JnOyBBbWlycmV6YSBaYXJyYWJpIDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29t
bS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSB0ZWU6IG9wdGVlOiBwcmVwYXJlIHRoZSBk
cml2ZXIgZm9yIFJJU0MtVg0KDQpbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGplbnMu
d2lrbGFuZGVyQG9zcy5xdWFsY29tbS5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBh
dCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KDQpIaSwN
Cg0KT24gVHVlLCBTZXAgMTUsIDIwMjYgYXQgMzo0OOKAr0FNIDxtYXJvdWVuZS5ib3ViYWtyaUBv
c3MubnhwLmNvbT4gd3JvdGU6DQo+DQo+IEZyb206IE1hcm91ZW5lIEJvdWJha3JpIDxtYXJvdWVu
ZS5ib3ViYWtyaUBvc3MubnhwLmNvbT4NCj4NCj4gVGhlIE9QLVRFRSBkcml2ZXIgcmVhY2hlcyBP
UC1URUUgdGhyb3VnaCB0aGUgU01DIEFCSSBvciB0aGUgRkYtQSBBQkksDQo+IGJvdGggc3BlY2lm
aWMgdG8gQXJtLCBhbmQgdGhlIFRFRSBzdWJzeXN0ZW0gYW5kIHRoZSBPUC1URUUgZHJpdmVyDQo+
IGRlcGVuZCBvbiBIQVZFX0FSTV9TTUNDQy4gT24gUklTQy1WIHRoZXJlIGlzIG5vIFNNQyBpbnN0
cnVjdGlvbjoNCj4gT1AtVEVFIHJ1bnMgaW4gYSBkb21haW4gaXNvbGF0ZWQgYnkgdGhlIE0tbW9k
ZSBmaXJtd2FyZSBhbmQgaXMgcmVhY2hlZA0KPiB0aHJvdWdoIHRoZSBSSVNDLVYgUGxhdGZvcm0g
TWFuYWdlbWVudCBJbnRlcmZhY2UgKFJQTUkpLCBjYXJyaWVkIG9uIGFuDQo+IFNCSSBNZXNzYWdl
IFByb3h5IChNUFhZKSBjaGFubmVsLCBmb3Igd2hpY2ggTGludXggYWxyZWFkeSBoYXMgYQ0KPiBt
YWlsYm94IGRyaXZlci4NCj4NCj4gVGhpcyBzZXJpZXMgb25seSBwdXRzIHRoZSBidWlsZCBwbHVt
YmluZyBpbiBwbGFjZSBmb3IgYSB0aGlyZCBBQkkgbmV4dA0KPiB0byB0aGUgU01DIGFuZCBGRi1B
IG9uZXM6DQo+DQo+IC0gcGF0Y2ggMSBidWlsZHMgdGhlIEFybS1zcGVjaWZpYyBjb2RlIG9mIHRo
ZSBkcml2ZXIgb25seSBvbiBBcm06DQo+ICAgc21jX2FiaS5jIHdoZW4gSEFWRV9BUk1fU01DQ0Mg
aXMgc2V0IGFuZCBmZmFfYWJpLmMgd2hlbg0KPiAgIEFSTV9GRkFfVFJBTlNQT1JUIGlzIGVuYWJs
ZWQsIHdpdGggc3R1YnMgZm9yIHRoZWlyIHJlZ2lzdHJhdGlvbg0KPiAgIG90aGVyd2lzZS4gVGhl
IFNNQ0NDIGhlYWRlciwgdGhlIFNNQyBhbmQgRkYtQSBzcGVjaWZpYyB0eXBlcyBhbmQgdGhlDQo+
ICAgU01DIFJQQyByZWdpc3RlciBwYXJhbWV0ZXJzIGluIG9wdGVlX3ByaXZhdGUuaCBhcmUga2Vw
dCB1bmRlciB0aGUNCj4gICBzYW1lIGNvbmRpdGlvbnMsIHNvIHRoYXQgbm90aGluZyBBcm0tc3Bl
Y2lmaWMgaXMgbGVmdCBpbiB0aGUgY29tbW9uDQo+ICAgcGFydCBvZiB0aGUgZHJpdmVyOw0KDQpU
aGlzIG1ha2VzIHNlbnNlLiBUaGFua3MgZm9yIHRoZSBjbGVhbnVwLiBJJ20gcmV2aWV3aW5nIHRo
ZSBwYXRjaC4NCg0KPg0KPiAtIHBhdGNoIDIgYWRkcyBhbiBSUE1JIEFCSSBwbGFjZWhvbGRlcjog
YW4gT1BURUVfUlBNSV9BQkkgb3B0aW9uIGJ1aWx0DQo+ICAgd2hlbiB0aGUgTVBYWSBtYWlsYm94
IGRyaXZlciBpcyBlbmFibGVkLCBycG1pX2FiaS5jIGFuZCBpdHMNCj4gICByZWdpc3RyYXRpb24g
ZnJvbSB0aGUgZHJpdmVyIGNvcmUuIFRoZSB0cmFuc3BvcnQgaXMgbm90IGltcGxlbWVudGVkLA0K
PiAgIHNvIHRoZSByZWdpc3RyYXRpb24gZmFpbHMgd2l0aCAtRU9QTk9UU1VQUDsNCj4NCj4gLSBw
YXRjaCAzIGxldHMgdGhlIFRFRSBzdWJzeXN0ZW0gYW5kIHRoZSBPUC1URUUgZHJpdmVyIGJlIGVu
YWJsZWQgb24NCj4gICBSSVNDLVYsIGFuZCB0ZWFjaGVzIHRoZSBtZW1vcnkgdHlwZSBjaGVjayBv
ZiB0aGUgZHJpdmVyIGFib3V0IHRoZQ0KPiAgIFJJU0MtViBwYWdlIGF0dHJpYnV0ZXMsIHdpdGhv
dXQgd2hpY2ggdGhlIGRyaXZlciBkb2VzIG5vdCBidWlsZA0KPiAgIHRoZXJlLiBJdCBpcyBrZXB0
IHNlcGFyYXRlIGFzIGl0IGNoYW5nZXMgdGhlIGRlcGVuZGVuY2llcyBvZiB0aGUNCj4gICBzdWJz
eXN0ZW0td2lkZSBURUUgbWVudS4NCg0KSSBkb24ndCB0aGluayB3ZSBuZWVkIGFueSBlbXB0eSBz
aGVsbHMuIEknZCByYXRoZXIgd2FpdCB1bnRpbCB3ZSBoYXZlIHNvbWV0aGluZy4NClNvIHBsZWFz
ZSBkcm9wIHBhdGNoZXMgMiBhbmQgMy4NCg0KPg0KPiBUaGVyZSBpcyBubyBmdW5jdGlvbmFsIGNo
YW5nZS4gT24gQXJtLCBPUFRFRSBzdGlsbCBkZXBlbmRzIG9uDQo+IEhBVkVfQVJNX1NNQ0NDIGFu
ZCB0aGUgU01DIGFuZCBGRi1BIEFCSXMgYXJlIGJ1aWx0IHdoZW5ldmVyIHRoZXkgY2FuDQo+IGJl
IHJlZ2lzdGVyZWQuIE9uIFJJU0MtViB0aGUgZHJpdmVyIGJ1aWxkcyB3aXRob3V0IGFueSBBcm0t
c3BlY2lmaWMNCj4gY29kZSBidXQgbm8gQUJJIHJlZ2lzdGVycywgc28gaXQgZG9lcyBub3QgbG9h
ZC4gVGhlIFJQTUkgdHJhbnNwb3J0DQo+IHdpbGwgYmUgaW1wbGVtZW50ZWQgb24gdG9wIG9mIHRo
aXMgaW4gYSBzZXBhcmF0ZSBzZXJpZXMuDQo+DQo+IFRlc3Rpbmc6IFRlc3RlZCB3aXRoIHRoZSBj
b25maWd1cmF0aW9ucyBiZWxvdywgcmlzY3Y2NCBhbmQgYXJtNjQsDQo+IGJ1aWx0LWluIGFuZCBh
cyBtb2R1bGVzLCBhbmQgVz0xIGF0IGV2ZXJ5IHN0ZXAgb2YgdGhlIHNlcmllcy4NCj4NCj4gICAt
IHJpc2N2NjQsIG1pbmltYWwgY29uZmlnICsgQ09ORklHX1RFRT15IENPTkZJR19PUFRFRT15DQo+
ICAgLSByaXNjdjY0LCBtaW5pbWFsIGNvbmZpZyArIENPTkZJR19URUU9bSBDT05GSUdfT1BURUU9
bQ0KPiAgIC0gYXJtNjQsIG1pbmltYWwgY29uZmlnICsgQ09ORklHX09QVEVFPXkgQ09ORklHX0FS
TV9GRkFfVFJBTlNQT1JUPXkNCj4gICAtIGFybTY0LCBtaW5pbWFsIGNvbmZpZyArIENPTkZJR19P
UFRFRT15IENPTkZJR19BUk1fRkZBX1RSQU5TUE9SVD1tDQo+ICAgLSBhcm02NCwgbWluaW1hbCBj
b25maWcgKyBDT05GSUdfT1BURUU9eSBDT05GSUdfQVJNX0ZGQV9UUkFOU1BPUlQ9bg0KDQpTaW5j
ZSB0aGlzIGlzIGEgVjIsIEknbSBtaXNzaW5nIHdoYXQgaGFzIGNoYW5nZWQgZnJvbSB0aGUgVjEu
IFRoZSBwYXRjaCBzdWJqZWN0IHByZWZpeCBpcyBhbHNvIGluY29ycmVjdCAodGhlIFYxIHdhcyBj
b3JyZWN0KSBhbmQgY29uZnVzZXMgdGhlIGI0IHRvb2wuIFdoZW4geW91IHBvc3QgYSBuZXcgdmVy
c2lvbiBvZiBhIHBhdGNoIHNldCwgcGxlYXNlIGRvbid0IGFkZCBhbiBleHBsaWNpdCBJbi1SZXBs
eS1UbyBoZWFkZXIgaW4gdGhlIGNvdmVyIGxldHRlciB0byB0aGUgcHJldmlvdXMgcGF0Y2ggc2V0
IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvdjQuMTkvcHJvY2Vzcy9zdWJtaXR0aW5n
LXBhdGNoZXMuaHRtbCNleHBsaWNpdC1pbi1yZXBseS10by1oZWFkZXJzDQoNCkNoZWVycywNCkpl
bnMNCg0KPg0KPiBNYXJvdWVuZSBCb3ViYWtyaSAoMyk6DQo+ICAgdGVlOiBvcHRlZTogYnVpbGQg
dGhlIEFybS1zcGVjaWZpYyBjb2RlIG9ubHkgb24gQXJtDQo+ICAgdGVlOiBvcHRlZTogYWRkIGFu
IFJQTUkgQUJJIHBsYWNlaG9sZGVyDQo+ICAgdGVlOiBvcHRlZTogYWxsb3cgZW5hYmxpbmcgdGhl
IGRyaXZlciBvbiBSSVNDLVYNCj4NCj4gIGRyaXZlcnMvdGVlL0tjb25maWcgICAgICAgICAgICAg
ICB8ICAyICstDQo+ICBkcml2ZXJzL3RlZS9vcHRlZS9LY29uZmlnICAgICAgICAgfCAxMCArKysr
Ky0NCj4gIGRyaXZlcnMvdGVlL29wdGVlL01ha2VmaWxlICAgICAgICB8ICA1ICstLQ0KPiAgZHJp
dmVycy90ZWUvb3B0ZWUvY2FsbC5jICAgICAgICAgIHwgIDggKysrKysNCj4gIGRyaXZlcnMvdGVl
L29wdGVlL2NvcmUuYyAgICAgICAgICB8ICA4ICsrKy0tDQo+ICBkcml2ZXJzL3RlZS9vcHRlZS9u
b3RpZi5jICAgICAgICAgfCAgMSAtDQo+ICBkcml2ZXJzL3RlZS9vcHRlZS9vcHRlZV9wcml2YXRl
LmggfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ICBkcml2ZXJzL3RlZS9v
cHRlZS9ycG1pX2FiaS5jICAgICAgfCAyMyArKysrKysrKysrKysrKw0KPiAgOCBmaWxlcyBjaGFu
Z2VkLCAxMDEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+IDEw
MDY0NCBkcml2ZXJzL3RlZS9vcHRlZS9ycG1pX2FiaS5jDQo+DQo+IC0tDQo+IDIuMzQuMQ0KPg0K
