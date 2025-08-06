Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C00C87FD1
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:26:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 82F694FCDD
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:26:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IiX3W0qx;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IiX3W0qx;
	dkim-atps=neutral
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 22E7446600
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 Aug 2025 09:26:35 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EydmbJtzRoBq2h16LkseGkc9aNvMIADvK3zXKMixOJ4HwJHBlYVsfLseOCEHHd5ypl8A3mPnaPwjuhyXh/AAkJU7pJN0nd2IWS3proGklmphW8XSuW6uddFFzS+D2sj8A5KWwaGAtDknk5vOd2vq5LU50MV2QNdSs/82sbSrn55IA37GEoLMzR2GwOqxSh/e//gJgfCTPDNoIG8/ajJh/gNxNyfLjyY5pbNWRAbw+8Lf4FgRzMxO1IkgsD9UyqOB5D7oG1VZ6osh6PCd+hWJkHeRwEFz1eHxOp5E3RYdHmVKW3N0esrXxwykPbQBcjm5jNvK/+yba81a25c1InQL+Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WODm2EYr3u7n1UMf1pibh3z5qcyh3zoVLt38w8uMDE=;
 b=kkLIVSNfV5ASL8TUDSs9Jq1BGWJHEcMizBm7Di+2OVmt+CREynGKmkjFauJiQwiyN4zIKhx+BcS414Yt+0qAU3ZT9ZHs51W8H/Dni8RSBRCZaW1d8nfj0aWunxJ30NwB+6+sGyEpnvVMuOBh3ZCjxmh/TBR7hErVmAdWqSyJfJ1GKiAjR2DJsH6OqYRwxgXAN0DeV9h7FrNWJiCLdDoKZkHPS8hMfv/OmuuXMzsbYN/+pwTcl7sUupLP6m6ekeK/5svpqpRtZVj0gEe+youo2emdTDYCRevxVZoL34QGrhb6cRlMSpamVNjUWDy1VEuZgd0mIBNBTuQET2iqhDtXJQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WODm2EYr3u7n1UMf1pibh3z5qcyh3zoVLt38w8uMDE=;
 b=IiX3W0qx9/GNeffOvTbXIxnanNnYXiJnJrpiAtGk3mkgemPj9k+vUw/B0qVLWM9AbpDys9n1ibRKQfB3JyqEEDl1jj/5aMhRaI88DHTgjX6tJtJIV8mOAsjnZ5+j1Vwe64WyLO1aQz67iO2uzD73FfvZ+lPIQF9Ujzpev5kH73Y=
Received: from AS9PR05CA0161.eurprd05.prod.outlook.com (2603:10a6:20b:496::9)
 by PAVPR08MB8895.eurprd08.prod.outlook.com (2603:10a6:102:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 09:26:32 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:496:cafe::31) by AS9PR05CA0161.outlook.office365.com
 (2603:10a6:20b:496::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 09:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Wed, 6 Aug 2025 09:26:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twXAE2UmCJ/hn9TaGKzT9iNF8Hq0T+MJF2Yfhp6x87DV30kJhZ45ELtdCpb/rz5P7LB1b97mNfGLWW/DTDFD+WOvBAYSRpTzdYeFk/LBOYAJbjo6l6n2gUYGk26U5QJwd3kLmQ+RCC83wp8xKnQ6yXBr5TlOQfQU/pk/xTl5fIkSXYfYWuOtgpSoOIsye3KjV0dE8xLAHVLMiPvxk2X2EKHP0rc/xHAyMqjZNTod1rQUK/9GlGXGEM64F66uPhs18QQz93vOAbWWi5peIwcS3ckSsQfJBj4rmvgcqzxz+faD2tidvafvE0jJjgQOxP5+7nhW7/q8YolVMc2XbfvNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WODm2EYr3u7n1UMf1pibh3z5qcyh3zoVLt38w8uMDE=;
 b=LE37CvmwAd00GiPyuevcOD8ijrnW1aF4eKhqf2Nf3ZQQxLDVnF3J4Akb3tvMM2FviPJ5ROO4T/xqQRyX6dpw/fKjggA3GiZooGcx2JC6/FoVYq2tarwUPUjneZ+7nu3lEzNRYIdqmZWdfM95U8RzajMls7/My6fvV2AVq7F9iBKADKcechhwD6t3zGapxkO7SiBCUpeEcDv91mkzb4I+qBT4peJr6j2xLvTIJ0VGV0aCt4E9euFp5Lxft0RCUBKubmL81vaLVutZiKvSd0ow/zNDXmWOYZedN0s4/VOvlfBiNY2fF0VB39J3frPLhWW0pX5UfnkwXe4tX62uYLVSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WODm2EYr3u7n1UMf1pibh3z5qcyh3zoVLt38w8uMDE=;
 b=IiX3W0qx9/GNeffOvTbXIxnanNnYXiJnJrpiAtGk3mkgemPj9k+vUw/B0qVLWM9AbpDys9n1ibRKQfB3JyqEEDl1jj/5aMhRaI88DHTgjX6tJtJIV8mOAsjnZ5+j1Vwe64WyLO1aQz67iO2uzD73FfvZ+lPIQF9Ujzpev5kH73Y=
Received: from AS8PR08MB9838.eurprd08.prod.outlook.com (2603:10a6:20b:615::16)
 by DU0PR08MB8323.eurprd08.prod.outlook.com (2603:10a6:10:40c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Wed, 6 Aug
 2025 09:25:57 +0000
Received: from AS8PR08MB9838.eurprd08.prod.outlook.com
 ([fe80::490a:c008:ad81:71cd]) by AS8PR08MB9838.eurprd08.prod.outlook.com
 ([fe80::490a:c008:ad81:71cd%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:25:56 +0000
From: Yogesh Deshpande <Yogesh.Deshpande@arm.com>
To: Jerome Forissier <jerome.forissier@linaro.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: RE: Question on OPTEE Support on Raspberry
Thread-Topic: Question on OPTEE Support on Raspberry
Thread-Index: AQHcBrL3ahsJWWNnfEeV4EAtJlKBsrRVWmbg
Date: Wed, 6 Aug 2025 09:25:56 +0000
Message-ID: 
 <AS8PR08MB9838B047646F7F5C71DA37DD8E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
References: 
 <AS8PR08MB98385F38DD41E1F66DE067298E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
 <128045b6-c952-4069-9fea-8aa6d37e2132@linaro.org>
In-Reply-To: <128045b6-c952-4069-9fea-8aa6d37e2132@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AS8PR08MB9838:EE_|DU0PR08MB8323:EE_|AMS0EPF00000194:EE_|PAVPR08MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 461c6a73-d301-4b70-54db-08ddd4cb5490
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?utf-8?B?NUFNeDVFYkJmNGdka0pEZWt1SFk4OXBYVVNVcGRCZ2dHbk9NQk40dmVBUW5n?=
 =?utf-8?B?bXQwNmdMT1dmZ21ReUhyWmZHVWdDalRsbzUwbWdWNyt4NENGVUNxSVExUkc3?=
 =?utf-8?B?d1U1U2hNRUo4L294c28wMUs4dHQ4L0RXYUNKMm05NURJNHFqcGFnSVFZdjlZ?=
 =?utf-8?B?RnhaU2s3S3dRcTJpUXF3bUtSL2J4R0hGaVZhYi9TZGw0YVJqbmthZUV5eElj?=
 =?utf-8?B?M292U3BsR1RHNmNsUm56MnFVU2pJZkVrYjBWZytnanViOFlGZThjNzRKMkpY?=
 =?utf-8?B?V2R3QU52L2VpZUlNL0hpSnB3RC9oZCtBdlM4bTRCc3kveFptWVp3aXJoM3B0?=
 =?utf-8?B?MWp4Q0o3U0dBcGVsK1NvZ3hjN00zeFl4WXVvSG05N2xpc2xic0tiWkdQSWFT?=
 =?utf-8?B?cnVHSlFTZ29JT2E2OCsxS0hZbmZhM2o2K1BPZmhsQ2ZXa3F0eGtXVE9jTzlo?=
 =?utf-8?B?R2dzRURXUi9hRW9aRWlveEk2RkFlcmxFZ1phM1JRR0JGQ3BMajFlWHVwU0h3?=
 =?utf-8?B?clRvNnVKVWhQUmJ5QTAwNVRYZTZYN21keXZiVmFyVVZxZG1iUXN5WXc0SmRi?=
 =?utf-8?B?d0hISGE0WHk3U0p2ZG1Zak1qc0JGL2djbXJwZk82K0ludkxydmlvT3dyaGxU?=
 =?utf-8?B?YTJYc21zR0U1d1lZbkEvVFplYXh6QlhvYW5hWllJZy9JU3loM1lrWlpUOWZI?=
 =?utf-8?B?Sy9sUm1FMDcwZ20yRUVSMW4yNWUrdURsYUV5Z2lmbVQwMHlZdG1KMWZoZXp5?=
 =?utf-8?B?WVJCa0J3MDU1TmFNQnh2ekV5bnlNZU9Zc2JyVzhBZ0ZnZXlNeURYdFIxM20w?=
 =?utf-8?B?bUlDbGZOTDhidExBVjh6MWxCTWJpSUNmOXJnZUlnKzUydjUrYlpZOHc5d2Fz?=
 =?utf-8?B?Y2dRcXVkNmZOcmFwYnQvRStpaXcwbUR6TlovcXNEYkZXOExKV0h4STBscEla?=
 =?utf-8?B?MlRhNGQzQWZPdkplV2ZYeGJKazJ0WW51Yi9IQVNiVEMrN0RwVGl3TVkxM3hi?=
 =?utf-8?B?S1JQKzVXYjJTN0Fid1FUOTNML1FxekgwOVRkS3hoR1U1OHNUZDExck11US90?=
 =?utf-8?B?WmxHamFtSC9SNXBFazVER1RlbktUdmZ6VTFCeE9OVmJEYUs4VE4vR1lVUmZu?=
 =?utf-8?B?ZjE1VGZFNmk2YW9xY1d3ODYwbnR3Nzk0b2k5NWs5cTFTYmZjQnNSS3hDRUM5?=
 =?utf-8?B?bHEraytnQWVUNUROdDR3Z1REYnpVdmx6cnZidTJqbExVdXZYYStkanRwNnY2?=
 =?utf-8?B?K0U2YkEzeHZsQ0pMNTNYTmtPVGl4YWtkZTM3ZXhodXhoWmdKTGpqdjhPc1Rx?=
 =?utf-8?B?SUpLYkkvUjNIV3A2T29KS3BXbVljVDN2Yk5nVnRVQ2RPWHB1azFWQXQvdGNl?=
 =?utf-8?B?K0ZhM1hlMGNGcWQ4YkxrVmNwQVh6YXk5U2VZQ2JZRGNlNm9jNmZqRWxIT2ZZ?=
 =?utf-8?B?NGZWeWpUZWVQVk1odUw3T0VuWjZYVytxUURvYStNUGxpM1AvVzI1K0pWMkxF?=
 =?utf-8?B?cTZLOFNpOWs3bDhJMEd5dUp6TEVQa1BIdFBadm9FcG9FaG5Zc1l6cFB4TTd4?=
 =?utf-8?B?WWNyOU50Qmx3Nks5dmRqVWxZSFIzOVlBVnFqb095WWY4bFozY2d5WkFSdy9U?=
 =?utf-8?B?U0F4ZFl6d1VRNG9VaGxnSG9FaFk5RFFNL1BNSERVSHg5bjhSZVNoR2J1QnJx?=
 =?utf-8?B?bHhncm9lcHNaS01sL1pKU1htOVBKUlRtNHVodFFnZTdJZzMrbU0xbUtvbHZK?=
 =?utf-8?B?bG1OdCt4NE9FWFR2RzNrWkkwZEgyMDgzTHBRZnV2YThFakE4ZDJjYXNrcklm?=
 =?utf-8?B?cWZJN1dxcTJ4MWQ2SVZvVGlkbFYwMUJ1WStsN0xyTXJwVHlYTDVva2ZHUTh3?=
 =?utf-8?B?OWlCaTBhZEVQbS81S0R0VTNpS1JxTkNVb1N5UTh1MmtiTXBudlBXbTlseFBU?=
 =?utf-8?B?b0xiRUoyNysvcHU2Z2poZnc0REJsMWxwOUJkei9OVEdvc2FTWlExWnpJc0Mw?=
 =?utf-8?B?OTM3NldZZEN3PT0=?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9838.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8323
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	d16dd49b-1700-4ae1-226e-08ddd4cb3f7e
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|14060799003|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U0dNbzluanlTdjQ5cjVWMFRGWWF5aytRQStWRmIycVE3N2FvcUZqaEIvUkVM?=
 =?utf-8?B?NUVRdkE3Wk9ud2F1UTM3bXM2TmNycWI0TnN4SXhrTks3cTJqWnNyUEpucW4x?=
 =?utf-8?B?Yi9kNFQxZlpjZjZoN0xuZzVnaWZWVEZnZGZsZEprNnhtVEFMWUwraSt6QmNp?=
 =?utf-8?B?MHZYL2FRREUxcmVDc3dmZHdxOFlKVWd3MFpWRUxKNzZzeVpZRXMrRHhnWVQx?=
 =?utf-8?B?R1V5dFB2bVI4LzMxMm9pRld6V3ZSZmN6cUk2T2ZXMkwxQUs4cjBZbHNIUDdu?=
 =?utf-8?B?Q3NMRWdOWlNveTBzVW9MazZCMVVURzhwUnovNlZXVGkreEhpdWVBWWlvck9q?=
 =?utf-8?B?MmpCUzdqdmJ6cFF2N1BKNDN1V0orU2Rmb29DY09QellhbnEwTnNNajgyRldH?=
 =?utf-8?B?bnNIM0phRmNPSC8wRlB0bUN6SlRWb2VxaVoveHUrRVZXckRrSlV4V0hUZzVU?=
 =?utf-8?B?V2h1UjI2M2VndVdvM0FnTWRCbi8rNEZPcTNVRXJpdkFUSkZ6N0RjVHRtOE1O?=
 =?utf-8?B?Q2ZVT283Vnc1QUF4L2ljdWU4SVM2QTdxc2lhWHpib2NOc3VmQ1FOOElFM3k2?=
 =?utf-8?B?UVFnVERqcjFiamxOMDlUc2VtTEZRTXB2ZG1yNFNSRW9QbGlYazZwN3NiQ3hP?=
 =?utf-8?B?K3UxK2lJcU9FaGgzaFd4ejdFV01rdTNPeUxwc1NkaUMvdGxLSGYzUEtDYVlw?=
 =?utf-8?B?Tm1GUzdkSVNrRko1TUV6WlBLMlY3K3NtbExycGV3MzYvQmY2cXRVYlVLeUxt?=
 =?utf-8?B?VTdoSmNvcmFybS83MHpYcHdzT2ljcUozc092NHJkSXdWT1FJMDBXbjhLS2xs?=
 =?utf-8?B?RXZYVlJXZ1pNRkRrNkhNZVVBcnhjcnBmajJxS1QyQkZjNTAzMVR0emdaNTZl?=
 =?utf-8?B?RzBVV3FXWW4va3IweEtDYmFxcEpqdFV0U2dhSXRHaUg4ZXlaTEVySnJpWXRa?=
 =?utf-8?B?OUhrZG05N2RtQytZb2EzOXhjYkppZW9XSzh0SFVLRWViOWQxRENJRE1FUURk?=
 =?utf-8?B?MWI0MnhXT1F2M1g1Mk1mZjdIYVBMKzB0UStXa0xVdzViakZKaklBd1h4Sm9E?=
 =?utf-8?B?THp2aFVtZDJWL2QrR1lmYmlzQTd4bnBxSThXWitkS25Ca1NrTWhBRTNFZStk?=
 =?utf-8?B?ZmlsNWxna3Y4VUdpb3Q5cnpwbERHbWFpVkxuYXppb2puN1ZMRHVaNlhwa3F6?=
 =?utf-8?B?ZFppTWtqb2V1cm5KS2EvVGZzMEkrNWIxK3QzK3JHckpXdTdHM0JXYmo0MkFh?=
 =?utf-8?B?c21QT2hIakd2MHovVTVNQUEvaVRwWlhObDlLME9GOWQzS25VOVNxTE1BblVO?=
 =?utf-8?B?K2RJWGhSSmVYbXV4cTRoUkpmTzBsU210SkI3c0pZaG81eE0wdmNWL3dUZkRR?=
 =?utf-8?B?a3BJMUJheWloc3kvNEo3VWIzMlM5Q2s0RGtYWFJiekw2djlmZ1U5clAxSDRR?=
 =?utf-8?B?RXpXT3RLeUtoQmxDVEVPaWtzUGFvMG9BcmJ4NzNCa0gzaEx5TVllUDFCWnhD?=
 =?utf-8?B?Z0pMTDNaSEtBTk1ZYWdhZUZrckM1ZERlZjd1RmRnZnQ1UjVlbFB3ckx6Z2FX?=
 =?utf-8?B?cVZjMUozbEVDbmlqMVUvUmw2WERYTXVCdDBWNU0wQTN0aUJUYmtUZEpCdHlz?=
 =?utf-8?B?b2xGSjJqS1NFNmd6RlZ0ditEaXVaWDBHQ3BpVnpLYlloeURmTmdiOTBLT0U0?=
 =?utf-8?B?azVocHFjdE1CL09OZHpyNUVCQ0t6QTZpRXFnN0ZEdnQ4SzBlNkNjeC9uZDlE?=
 =?utf-8?B?SnhWNXBDWlIxZFROL2ZyRGN3VmJLcWtJM0ZNN1BhdVpIV2lqMUZqdGRYank4?=
 =?utf-8?B?dXBqR3UyUExMcnpVVTN6cEoxNENQYnhJQW1GT1IxeE1WZ2NYdUNsU1RNTXJu?=
 =?utf-8?B?Vy9tTDNaSGJLY1d2eXdKNEpMdzR3a2llOTlQbDFxU01NMnlCU1dPZ2FDV2ZL?=
 =?utf-8?B?dGxwQnNBdFp4aTZvai9QV0xiQXR5WFdIWm9nMmRDbEh5MGtrL1FpNW9VMGty?=
 =?utf-8?B?cmFBZWVwNmNhc2FPeWhKMGgwSWhRd1JqRHQybHZydmQzRWVKcHArOWF1RDA2?=
 =?utf-8?Q?19VNOG?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(14060799003)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:26:31.8233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 461c6a73-d301-4b70-54db-08ddd4cb5490
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8895
X-Rspamd-Queue-Id: 22E7446600
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.89 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.84.16:from];
	DWL_DNSWL_BLOCKED(0.00)[arm.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.84.16:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:496::9:received,2603:10a6:20b:496:cafe::31:received];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: HVVEQV5JDVLMGVFOCIEGJMFYS7W2XM26
X-Message-ID-Hash: HVVEQV5JDVLMGVFOCIEGJMFYS7W2XM26
X-MailFrom: Yogesh.Deshpande@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JYVZOO57MH32OEQY3GCP4QBMY6AZAVJM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

VGhhbmsgeW91IEplcm9tZSBmb3IgYSBxdWljayByZXNwb25zZS4NCg0KU2VlbXMgdGhpcyBQUiB3
YXMgY2xvc2VkIGFzIGJlZW4gbWFya2VkIHN0YWxlLg0KDQpBbnkgY2hhbmNlIHJlLW9wZW5pbmcg
aXQgYW5kIHdvcmtpbmcgb24gaXQgPw0KDQpJIGFtIGhhcHB5IHRvIHN0YXRlIHRoZSByZWFzb24g
Zm9yIHRoaXMgcmVxdWVzdCENCg0KUmVnYXJkcywNCllvZ2VzaA0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogSmVyb21lIEZvcmlzc2llciA8amVyb21lLmZvcmlzc2llckBsaW5h
cm8ub3JnPiANClNlbnQ6IFdlZG5lc2RheSwgQXVndXN0IDYsIDIwMjUgMTA6MTggQU0NClRvOiBZ
b2dlc2ggRGVzaHBhbmRlIDxZb2dlc2guRGVzaHBhbmRlQGFybS5jb20+OyBvcC10ZWVAbGlzdHMu
dHJ1c3RlZGZpcm13YXJlLm9yZw0KU3ViamVjdDogUmU6IFF1ZXN0aW9uIG9uIE9QVEVFIFN1cHBv
cnQgb24gUmFzcGJlcnJ5DQoNCkhpIFlvZ2VzaCwNCg0KT24gOC82LzI1IDExOjAyLCBZb2dlc2gg
RGVzaHBhbmRlIHdyb3RlOg0KPiBIaSwNCj4gDQo+IEkganVzdCB3YW50ZWQgdG8ga25vdywgaGFz
IGFueW9uZSBwb3J0ZWQgT1BURUUgb24gUmFzcGJlcnJ5IFBpIDUgPw0KPiANCj4gSXMgdGhlcmUg
YW4gZW52aXJvbm1lbnQgd2hlcmUgb25lIGNhbiBydW4gT1BURUUgd2l0aCBhIFRydXN0ZWQgQXBw
IG9uIA0KPiBhIFBpIDUgSGFyZHdhcmUgPw0KDQpUaGUgb25seSBlZmZvcnQgSSBrbm93IG9mIGlz
IGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1URUUvb3B0ZWVfb3MvcHVsbC82ODU0Lg0KUGVyaGFwcyB0
aGF0IFBSIGNvdWxkIGJlIHJldml2ZWQ/DQoNClJlZ2FyZHMsDQotLQ0KSmVyb21lDQoNCj4gDQo+
IFBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IFJlZ2FyZHMsDQo+IFlvZ2VzaCBEZXNocGFuZGUN
Cj4gUHJpbmNpcGFsIEVuZ2luZWVyLA0KPiBBVEcgQXJtLCBDYW1icmlkZ2UNCj4gDQo=
