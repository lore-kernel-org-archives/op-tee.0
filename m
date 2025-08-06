Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1719C87FCB
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:42:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 076994663F
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:42:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ds3PpYF/;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=Ds3PpYF/;
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013034.outbound.protection.outlook.com [52.101.83.34])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 608A842F33
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 Aug 2025 09:42:34 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pri395cVwccZ+szvyhX7DmTZI+tPIfzWNaFENd14+oPZ1eZDITCw0wKuz5dj9nTDV23/kUOyqcIuwTzxzf9BDp+FybIib7rDYzRnH4r/yfUFUOl9DFqduGVqbmzaCq3DJ6Jb/Slu/xpvtubMG3O5Q8YVY2iYz8h8mwxTwFnagyy0PUulaU+0xsMgbvtM103IWHXbva3U6anmGbwqUdwo4hA/awZ4S1q3zle7tRlMTsR/m2Bg/3DGl2eou7biz4nfCLBkql11jbITik655G20SPmUjHt5emsU+F9rYE+kWufnpwj1knlHehr7Tv04eUQFvNDcpEnNAh3x+FvQGonUKA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABpNKPfTPZ+qPniV7O9ogFX8J0XQPWVXn8p0D6EmfAY=;
 b=R6n98VaYqmh6gSMpgx2zXs5jmWrfMM34FjlpK6ox8EHwyk+ezfRZh624q9Ida86I74LCOuSaAP4+40kUVNJeJPDjDqRgp8zzS0bEyeZtABwBbyWsGEX0IjIIyrdrywGMIoEqslCM41HuJL90hQ5Mru+25WuwmQGnOZIJV8UwbWhQ6R468QQK2E+ns61C00WNVTcmAZTCRDs9p/Jz/Nb37IcP8ohYtjZTcIMT8OxEDuxZg+5WgdztQyppXUU419j1L9j/KZssaKunnFRH9109BegBF8Y2nj4Kncf8wcPmHMAgyKZ5/LREqcQsF8DgCBjydU7L4HHL8twdK32jZu9JqQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABpNKPfTPZ+qPniV7O9ogFX8J0XQPWVXn8p0D6EmfAY=;
 b=Ds3PpYF/36RHRqxByyiZyWbNkG6os+UiNV/iVIF/yP6E/i+L6PZfh3PR+eHx+g3RAyLxC0gibAmIZBdwhNQGDK0y18xyoFLofthKqw7AfHeGmxNtBiSrtCb73tdx/qCRZ9xqo6ZOUX9k3vDU/t4MvI7+kOEmJgoTsxGjpEJTKTk=
Received: from DB8PR04CA0018.eurprd04.prod.outlook.com (2603:10a6:10:110::28)
 by AS2PR08MB9295.eurprd08.prod.outlook.com (2603:10a6:20b:599::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 09:42:30 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:110:cafe::63) by DB8PR04CA0018.outlook.office365.com
 (2603:10a6:10:110::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 09:42:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Wed, 6 Aug 2025 09:42:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbx/CKGf1BlSnqOUdX4AcmT6w3apwFn1g/le3stBIUq3sx3wte0Q60vA9JA7SYvtxxGlXOztAu70qfATt535L/eUlrhy7rnxwyxpLrNy+kfCwfxEhKIpWw/VqR/rMUltbA9Dc+JtuvJXvuuks5wd152GFDZNFo+vUqKjAWh78Q83P8abbNp7vdKMM+pOju7XGJaPduzR3oe9T1vOMEovkSVhKt1+1JgDXqKJ2A9Sgtzbe/MAjnkbfnG5f78qDKoeLjIiyqbpAtrW0r4+TPYhPS521pLjEP5iuJZ+Tv/Cfzt1w9rAtfYWUqJW8ttcMQFV0JGX+ki+JTlQ7bdFj64fWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABpNKPfTPZ+qPniV7O9ogFX8J0XQPWVXn8p0D6EmfAY=;
 b=L2XFq1zynaK1sYuda8dqFOv1NciqTYpWuOmYrIwd/ZsGog9SBBBvDMQ6W9OsEs8uK9GX9x6iwsGxYT/Gl/2BZHfUplYC0Dt/TqftuhWSEhkdQVNWyUE+j5Z6/RhTniKNahged8lpkOM2c6DDbq+HDfW7ugQ4gQAzl5LwqnX26zTErtBZ3Kl1181LAN03RcgoHO4zs3Pic6WHhO2IuEu6aRttFWEtpAyGViCDfaRGRsWFNOZbrFV4H3eUpo1CxAgb+BI2GId51Qax9NzhO6Z+wPhUe8MIkMHlozttIknXaXsuGhADkbS5BCwDk4l3e+oLOvnAfoWQJ5c3Aw23f5vpGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABpNKPfTPZ+qPniV7O9ogFX8J0XQPWVXn8p0D6EmfAY=;
 b=Ds3PpYF/36RHRqxByyiZyWbNkG6os+UiNV/iVIF/yP6E/i+L6PZfh3PR+eHx+g3RAyLxC0gibAmIZBdwhNQGDK0y18xyoFLofthKqw7AfHeGmxNtBiSrtCb73tdx/qCRZ9xqo6ZOUX9k3vDU/t4MvI7+kOEmJgoTsxGjpEJTKTk=
Received: from AS8PR08MB9838.eurprd08.prod.outlook.com (2603:10a6:20b:615::16)
 by AS8PR08MB8245.eurprd08.prod.outlook.com (2603:10a6:20b:50b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 09:41:58 +0000
Received: from AS8PR08MB9838.eurprd08.prod.outlook.com
 ([fe80::490a:c008:ad81:71cd]) by AS8PR08MB9838.eurprd08.prod.outlook.com
 ([fe80::490a:c008:ad81:71cd%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:41:58 +0000
From: Yogesh Deshpande <Yogesh.Deshpande@arm.com>
To: Jerome Forissier <jerome.forissier@linaro.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: RE: Question on OPTEE Support on Raspberry
Thread-Topic: Question on OPTEE Support on Raspberry
Thread-Index: AQHcBrL3ahsJWWNnfEeV4EAtJlKBsrRVWmbggAAERaA=
Date: Wed, 6 Aug 2025 09:41:58 +0000
Message-ID: 
 <AS8PR08MB98386743EB8157559E060DBD8E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
References: 
 <AS8PR08MB98385F38DD41E1F66DE067298E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
 <128045b6-c952-4069-9fea-8aa6d37e2132@linaro.org>
 <AS8PR08MB9838B047646F7F5C71DA37DD8E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
In-Reply-To: 
 <AS8PR08MB9838B047646F7F5C71DA37DD8E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AS8PR08MB9838:EE_|AS8PR08MB8245:EE_|DB1PEPF000509F7:EE_|AS2PR08MB9295:EE_
X-MS-Office365-Filtering-Correlation-Id: a025fe73-5fd5-4699-36c5-08ddd4cd8fcd
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?K1Z5NlhDWHNSaEo3V2pJQTE2dmEyWnp2NEFjb2JRZDYvUTZOc3AyQ3pXbGYz?=
 =?utf-8?B?RHp5S09hTmxZbWJqSGpCZlhyTFgvaUwxQjZldjZrM0VKRFJtamkwUTMwY0Rx?=
 =?utf-8?B?MWVhUy9Ra0VmbjJieks0cVpHdjZXMFE0eEQ5OTYzZ01zcnZyY0RlZkFrUDVS?=
 =?utf-8?B?Zkt3VG45YjNPUEdzTjFRRmpqTUJOVFU2MkVpNG1KUDVoN216NFZHUzhaaGs2?=
 =?utf-8?B?TTZXTlZ3M2RRNDJIWk1UUWZ1TXlSclFhVEcrbkloOE93T1hqbWpiQXVNS0dM?=
 =?utf-8?B?QmdzNVlla0ZQTE9MY2lGSVhESmh1M2FLLy9RdjhQc0tnTFFsZ2JtdHFLVnFS?=
 =?utf-8?B?SXF3MTR4M3BCQXU4SExCc2UxYjdHYloyYmlzUnRJb0o2c1dPSU1BUi81OWtE?=
 =?utf-8?B?cURNWnlxamErMGttbTVLTy9rTG1JaG00d3FDM3d2cTFNNUNHWVBBU0FsaWIx?=
 =?utf-8?B?a2tVdElRN2ZCS1ZXREdGNXlsR05HNFprYVBLRlVqaEtVclZ2M3lmR0t1KzdL?=
 =?utf-8?B?N3lxMGpaZ2R3SHdpQTRtQUF5SFhmb1pEK3gzMmF3dTYrbFFUQ1FuU2pQL0lB?=
 =?utf-8?B?S3U1d3hBKzFBRnVtZm5ndUVLYzhZd1E2YWVHRmkvUmt1ZXk0bXdGd0JLT25U?=
 =?utf-8?B?eGV5b0FLZUsyMU5sejRKU2xvdXVYQUpyZ1dvaUtZL3k2cEZlTk85K0s2Q1ZH?=
 =?utf-8?B?T1BCdGhvMEVBLzlxdk92RjNveU85WGRWbXhFVzNhbW9kT1Q4NjF6UHJiTzlE?=
 =?utf-8?B?RFFoUzMxbzZ3QzZyckZIMmgrOFBJVm54Slp6VUsyblNMdGNtL3NNS1ZCOUF2?=
 =?utf-8?B?SEt5OXpkNXFtRFNtYnRYUTZXTnFkdzNybWJFZ3U5NC9CaXZGUXN4cU8rYTR4?=
 =?utf-8?B?bG56NmxROTdrTVFrQ2J2VUhCbklqZzdJZTM3T2RqcndSdmovN1VtOUtwdmxa?=
 =?utf-8?B?bk5iMGJsQmZ4YWo2VmVMMVZvWkpqQkxWRlpGdHlhUU5pTUtWa0xHZ1pSS1Rn?=
 =?utf-8?B?UE9FY3dMMFo4TzhSRHpuTy8vTW5SV3BVcGVzdXZTZ09UZVhSeUhHUWFMZklK?=
 =?utf-8?B?M29iVEw2MHN2ZVNOK0FUQ3pMS2lUUVZIQjlGVG5TWTFGQnlManpWa1M1WDJN?=
 =?utf-8?B?S3JmL3pJcHcybUhtVUVUeDlJeXBWZkFlSWlmZndFSlQvMTlQSjVVQWd2cTgw?=
 =?utf-8?B?S0hudDZlVWQwSHdlOGdNQ1VPSkRNVFZ0Y2dvZmp4QXZVc3U3VWhkcHdkb09w?=
 =?utf-8?B?TXVhUzlGUHptYzR3bjI0WmdnN3VySEl4d2lmK1Vmb3Y3K01ndzA4b1E1R3l3?=
 =?utf-8?B?Mk5MZy9zNnUvYm9KTHd5NjVLNGFkR3BNYnJ4NDgvREk5VjkydHlTTEJkK09K?=
 =?utf-8?B?RTNFeHozcmVLNHFmc2NJZWVrc2lFL1pRWU1qQ1cySW9Kd3p2eTZ6aVA3UXNm?=
 =?utf-8?B?bFZ3UHJBM2RWWnQvd1hpYTE1T3pQeUhvbzN4aHpTUitzTzZGYnBoK3I5VUV0?=
 =?utf-8?B?cjVscFFRTTlzTlFNODBnNk5BUlE2NkZhVXc1RHQrTVYvWDVxS2xJVUhJWTZC?=
 =?utf-8?B?N204ZjNFUUF1RTFBQlRNblRJWVpkVytGTVM2MUN5VXEyT0NaWGxzRVNpMHIw?=
 =?utf-8?B?aDFBUlN6cVN2cGNwMXlDQndYMTMvYXVWZmZRYmtkeUpIQllTOGVIbXVONjFU?=
 =?utf-8?B?K0psY1J3US9XclpEaFNYRlF6aWZFaEk4eW5TS2cvYWtIankybk5QS2FkM0tx?=
 =?utf-8?B?VmVhZ0tzakpoQ3FVT09NVm5yWWo2bmVXZG1uejhNVHo5MVQyR3AyZjdSdjhh?=
 =?utf-8?B?c2dpcDNCSzJseUFEOWw1bkJVSkFXQW5FbWpsOHBTU05YSnZubzIxTllnRkRY?=
 =?utf-8?B?bkhhcnpnN0RiM05HMXJoMTQ2dVJreklwUkl0OU5QS1k4L2xrSmlYSWdIVXI3?=
 =?utf-8?B?VmVWM3V6TnBIMmowWElQMlJyVXRENDM5VXAxYmErei9jaGVVbkFGUFQ2MlJ2?=
 =?utf-8?B?MmUyZ3ZHNmdRPT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9838.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8245
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	02580fbe-af77-45a4-8c4c-08ddd4cd7caf
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|35042699022|30052699003|14060799003|1800799024|36860700013|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a29TdFlwakNIZVpNNkNsKy9PSkVmWWFLbU9kbytYekM5dFhvVmcvMitqV1Vo?=
 =?utf-8?B?eE1mS3AvandYQVJlZGVpU29DSTJKSkRhQ0pzK2Q4ckQ5YXQ4eS81N2RGV2Jh?=
 =?utf-8?B?MjlhTHpGTVhHWHJZekJmdVFiVit6eGpqSEc2Yko3UXZlM0QzaDhWQ05iSTcy?=
 =?utf-8?B?U0xGTDR0ZU83dG1iQml2NmQ5bmJ6V2Rza0hnNGRiOUxVbSt1dUFia2dQYmFt?=
 =?utf-8?B?aktUUE1DbzBrNndUZHVyM1haZFVkVURsanQrZ3dsMWlLQUZqNEdXeGhIbVg2?=
 =?utf-8?B?MjBUSWVVQzR1MTlIL2hLc1djSUNVMlJOUzI2aEFnbzM0SU5sN053SU5vOTRz?=
 =?utf-8?B?MTJkZzJQZGZwOXNsb2d4eWFoc2FGSXcvaU8xaFVITW9sUnRDNDAyT2NLcy9Q?=
 =?utf-8?B?aHJLeHE1b2RYeWdnNENoTUhWMUEzZHgwYTgrYXd3cFRpWngwclhkNmdnby9Y?=
 =?utf-8?B?Z1hyc2RpeFRkWGFTdjlYc2tlZXdqSGZuMDVsVkE0djVxTXBxZGE5WnRqQTln?=
 =?utf-8?B?YW1tUHdxRFVYSmkwczYzN2JHN2xxdy9HYU5Nd3dJTTBIaW9oZWs4QUd2NStj?=
 =?utf-8?B?UFRMTkdSYjQ4bGtMTEdkaDhLTUVXYWtxVFcrbWVUK0FtaFZEbG12UldxQmpC?=
 =?utf-8?B?K09HNUNCY3JPb1NHZGxodVIrTzMvY1NKWmNLSVRGVGNJZEVvZjJ2MzBiVmdQ?=
 =?utf-8?B?eS91Q0pvbUczaUU5bkR5Z1pRYkVMdlNJNSsyalpqUDlUMWp4V2p2YnI1SzNZ?=
 =?utf-8?B?UHI3STJnVVFQbERaTGtiR3J4dGtmM2pjdWVRbUt6SlFtNGxyUXJxcXR6UE51?=
 =?utf-8?B?L3ExSGpEanlDNVBwckNBUFpMelZ4cjRVdDYvR0V2ZTRTREtTUlE1QWxJOVhD?=
 =?utf-8?B?V3M1WG5ZbGc3VXBNMXB5RFBZNlM2RnJDTXBBT3FPUTU0ZFdoR0NkZHJWYW1x?=
 =?utf-8?B?ZzdOeHpYcE1pSEJYVEM2Q095dUZyNWVmdkRuWEJZY0dEb2ZFcnBWMnBHSy84?=
 =?utf-8?B?enp0YVVqU01aVEpWQkdnM1N6S0lSeGJwM1c5RkhPaUZKQjYvVlB0YkVwZWc3?=
 =?utf-8?B?S3h5d2xwakwzWkRyZHJ3UklMbkpNeURZRE5JaGFRdzFPNEZpdVlWYTRCNVdq?=
 =?utf-8?B?RlZmd3ZxeXNidkw5dzlRMXduTHBGYnRBeW8wUXZvMFNrWkEyOGJLZHlsTUVv?=
 =?utf-8?B?Zm02Ri95M05xMEhKZmVvdHFRdlBXOVFZRGYxaTFGdWxuVjFMK05ralA1c0xM?=
 =?utf-8?B?MkdxN0ZJY0hqZVdiWVhsZ3d4UUYrY0xWTWpDb0srUUtsam5HRHVGOFIzdmRP?=
 =?utf-8?B?eVA1MXhGOFcxMDV1NUF3anVCM1BPUGpYSE5wb0tXanFuTTJiSTRNaE15TmRP?=
 =?utf-8?B?UHJGWEVKbmIrb0x0TjQ2LytWUEd2SDVva0NzT2l4Y0dIazZxMUROd0NDVkVY?=
 =?utf-8?B?b040M2J5dEQ3UUg4VUs0amdSZXV2L09lQVYwdGpnZzdITXpTbjk4SVY3Zlhh?=
 =?utf-8?B?ZFpyQmM0eG92L3o0K3BldmxOdHlvelRhcSs4NFhjL1ozMVRpd2VPMFYrLzJB?=
 =?utf-8?B?R1ovQ2cxdnJDeEVSaGhZdkllMVJvUzZyc0N1NnBaVE9MYWJDM1NkWkhoWEhP?=
 =?utf-8?B?UnpSbjNsNUFldG1WaTlPcFhvVEV5N3J3ZjZMU1F6WHZnKzhheWhNbXBFVkJm?=
 =?utf-8?B?eC9LZWc4TjUwZTRhVlV5Tm5MS2M3cnR4Y0JIZUZLMENzWVUrZkxkZ0cxc2hN?=
 =?utf-8?B?MHBBcDBRQkp6V3c4dG5sNHNmaCtLdVcwMUx3V05KYnB1OGZqSFREeWVTTkN5?=
 =?utf-8?B?dnEvaHNoT2N1QllBbTEvZ1JiVWFaWndCcjZwOVorNVl1Sy8rTmJTUnJVeTVo?=
 =?utf-8?B?V2dMc3IwaFRrTmptcU4zQUFWZFB3dk5ZVG43Uzc4bHE5WVlqLzFsZ05mTm92?=
 =?utf-8?B?NmxNb2lWVmZCcTBRWkpUcDBDcGIvUi84cHhXYzBHWm5WMGZtVVFWWVowMnJN?=
 =?utf-8?B?STd1MjRYVk9zdTlURmlOOVFFL2FRSjhFTnlOSkUweUdQMHJaL0pnQ1RqNzlk?=
 =?utf-8?Q?RzrMRE?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(30052699003)(14060799003)(1800799024)(36860700013)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:42:30.1966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a025fe73-5fd5-4699-36c5-08ddd4cd8fcd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9295
X-Rspamd-Queue-Id: 608A842F33
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.83.34:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:10:110:cafe::63:received,2603:10a6:10:110::28:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[arm.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.83.34:from];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 22QGWTQVKXRIE7F5F42HWVSUOP2LMCS4
X-Message-ID-Hash: 22QGWTQVKXRIE7F5F42HWVSUOP2LMCS4
X-MailFrom: Yogesh.Deshpande@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TEMW7MK2NMK7OYKQRP6X4CH546GJPQXX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhhbmsgeW91LCBKZXJvbWUsIGZvciB5b3VyIGhlbHAsIGluIHJlLW9wZW5pbmcgdGhlIFBSLg0K
DQpQbGVhc2UgbGV0IG1lIGtub3csIGlmIHlvdS95b3VyIHRlYW0gbmVlZCBhbnkgc3VwcG9ydCBv
biBhbnkgZGVwZW5kZW50IGNvbXBvbmVudCAobGlrZSBURi1BKSB3aGVyZSBmaXhlcyBtaWdodCBi
ZSBuZWVkZWQ/DQoNCkluIHRoYXQgY2FzZSwgd2UgY2FuIGJyaW5nIGluIHJpZ2h0IHBlb3BsZSB0
byBnZXQgdGhpcyBvdmVyIHRoZSBsaW5lLg0KDQpUaGFua3MgYWdhaW4uDQoNClJlZ2FyZHMsDQpZ
b2dlc2gNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFlvZ2VzaCBEZXNocGFu
ZGUgDQpTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA2LCAyMDI1IDEwOjI2IEFNDQpUbzogSmVyb21l
IEZvcmlzc2llciA8amVyb21lLmZvcmlzc2llckBsaW5hcm8ub3JnPjsgb3AtdGVlQGxpc3RzLnRy
dXN0ZWRmaXJtd2FyZS5vcmcNClN1YmplY3Q6IFJFOiBRdWVzdGlvbiBvbiBPUFRFRSBTdXBwb3J0
IG9uIFJhc3BiZXJyeQ0KDQpUaGFuayB5b3UgSmVyb21lIGZvciBhIHF1aWNrIHJlc3BvbnNlLg0K
DQpTZWVtcyB0aGlzIFBSIHdhcyBjbG9zZWQgYXMgYmVlbiBtYXJrZWQgc3RhbGUuDQoNCkFueSBj
aGFuY2UgcmUtb3BlbmluZyBpdCBhbmQgd29ya2luZyBvbiBpdCA/DQoNCkkgYW0gaGFwcHkgdG8g
c3RhdGUgdGhlIHJlYXNvbiBmb3IgdGhpcyByZXF1ZXN0IQ0KDQpSZWdhcmRzLA0KWW9nZXNoDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBKZXJvbWUgRm9yaXNzaWVyIDxqZXJv
bWUuZm9yaXNzaWVyQGxpbmFyby5vcmc+DQpTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCA2LCAyMDI1
IDEwOjE4IEFNDQpUbzogWW9nZXNoIERlc2hwYW5kZSA8WW9nZXNoLkRlc2hwYW5kZUBhcm0uY29t
Pjsgb3AtdGVlQGxpc3RzLnRydXN0ZWRmaXJtd2FyZS5vcmcNClN1YmplY3Q6IFJlOiBRdWVzdGlv
biBvbiBPUFRFRSBTdXBwb3J0IG9uIFJhc3BiZXJyeQ0KDQpIaSBZb2dlc2gsDQoNCk9uIDgvNi8y
NSAxMTowMiwgWW9nZXNoIERlc2hwYW5kZSB3cm90ZToNCj4gSGksDQo+IA0KPiBJIGp1c3Qgd2Fu
dGVkIHRvIGtub3csIGhhcyBhbnlvbmUgcG9ydGVkIE9QVEVFIG9uIFJhc3BiZXJyeSBQaSA1ID8N
Cj4gDQo+IElzIHRoZXJlIGFuIGVudmlyb25tZW50IHdoZXJlIG9uZSBjYW4gcnVuIE9QVEVFIHdp
dGggYSBUcnVzdGVkIEFwcCBvbiANCj4gYSBQaSA1IEhhcmR3YXJlID8NCg0KVGhlIG9ubHkgZWZm
b3J0IEkga25vdyBvZiBpcyBodHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29wdGVlX29zL3B1bGwv
Njg1NC4NClBlcmhhcHMgdGhhdCBQUiBjb3VsZCBiZSByZXZpdmVkPw0KDQpSZWdhcmRzLA0KLS0N
Ckplcm9tZQ0KDQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cuDQo+IA0KPiBSZWdhcmRzLA0KPiBZ
b2dlc2ggRGVzaHBhbmRlDQo+IFByaW5jaXBhbCBFbmdpbmVlciwNCj4gQVRHIEFybSwgQ2FtYnJp
ZGdlDQo+IA0K
