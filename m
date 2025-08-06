Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899F8C87FD1
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:03:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BF88242F33
	for <op-tee@archiver.kernel.org>; Wed,  6 Aug 2025 09:03:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=meFPlATO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=meFPlATO;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D4D3A42F33
	for <op-tee@lists.trustedfirmware.org>; Wed,  6 Aug 2025 09:03:13 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=juwNoZkoNnYtmv5saTFAH6aq2uc6Fig2OidbrRm7OOh42P2IRhG1fEda0YOe4NZ0rqugbx4na9mTKChl41chDNaijIIuxTqJoSCstrFEdMvs+yk+Us8pA7GW498EO3BbhV1uFhQAPdSXIgM3bOxprSOcRlJRAm395db9sDjBoAgzYcDq6Bidv4gbwy2UInr5T45p4JXAyxFQsqrFHi7GWWQr70pP8/PREdT6PKb6SO/JJoPACdJ3a8nl474pGe7j1SYmJsHgNPvBDOtaN74fVA4JLs/hL5NchcMGK0FwFqc6+xkxWuHv2+/YHYwaocyRbrDHkK1eWK2gvZmkB2GKeg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8KX3BTbFOI4+E5mocK5yf44DpoNBNNJh/McsaP6wZ8=;
 b=vp+SygSXvElwmV3n89gEoi13JYTuU9TreAfl3NPrEhLl0QeJcYH6mc3NuG8GR/84yPLfh5Rm11pkPYmtPNGba4lD3z05IpIvkJGbqb6qrLY5UXUte8WZk9alIwSoHWzMftnoUAcJMizFoYDGSYh4v1M+gKz4IMFmFTN3LoLW0hIhJj/avd8sedOAtQp72GLOgXyvkL21IVChsTHqPo0002Hs4V2AY1oOZgvoxTd2hptMexq/Ns0UsgNjgIEjL7O91esayvbLjs0PRkh1de48w17pITVoih5HXd6ZNZ3wkqg6ljSgJjAqsl9sOGeqqsMQcc4rvvNh0iNYmScZVwt4ng==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.trustedfirmware.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8KX3BTbFOI4+E5mocK5yf44DpoNBNNJh/McsaP6wZ8=;
 b=meFPlATOi/ipN9ejH3n/CZmiBA5lSigJ8ePu46tHW3KwEPpAWE+jd+MGfJ6PS3wcD7btI/hJdsKgSEl6QBXB8S03+uL+mV7O8BtDgfmIWuv9LiRsfTdiuvqxf0jk+eZKCFLWYufOatGePUScErgDa2cN5CzIqmYdTEpeg4uJAlo=
Received: from DUZPR01CA0237.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::20) by PA6PR08MB10705.eurprd08.prod.outlook.com
 (2603:10a6:102:3c6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 09:03:09 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::7c) by DUZPR01CA0237.outlook.office365.com
 (2603:10a6:10:4b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 09:03:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Wed, 6 Aug 2025 09:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLoSbRMr1Hs0fXX9t0b7N/4WwZNafh+gODX4QZCI1HO08Ifwa1tB5Tb+fFTkh8p4cfb76HPxgfKyJaSMkztL31DNkWt8Nxudx0t3EJXGZiV0KGwyILfr7XBYfUWpQbkVKwWmIYrgQcTRXPTo2FNXT0ffbpsu+nVYendPmUsxkKEFY+4gXjhq/NjMOdnaH73lSst0ySQm4lxcYmUw7IDaN7+DfMiRJip2bt3DTInmqdv72a0rk2uVj4HK/MnquX2dvXg72VeRJXHheeLqg+ac7YIAk4+uVGhh6QlT7Gjj7RJM5xAi5890Zw3W/LW0zUkJ1larulWzDpMxhhDU4Q2liA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8KX3BTbFOI4+E5mocK5yf44DpoNBNNJh/McsaP6wZ8=;
 b=iUQLyMGfy28o7FItqJzLt05tmvCL93IMNO3R579CK0kIMrBhZ41NWtKVn2MwIwn4LFxDE0w0XIHG5XpcMf0UnG8wSSDgYw0MSOz8K7c2+INGRZ+jcVPsrzecKBLh5Ut/fCAHA+uCSAA7ktXtj1S15ulaJIlzHTj6it7tcPwEaOGDC01ECPSK/m4yoyZv31KsuODjYqZMezIgamUx7ldyuWMec6/WrOwYcWigSKIhkzuGSCn4qA1AQx9CyiP+TPAen5JmAlLRm8mrb8vce//+ERbG4nAuM56x7PUqO5U3KCOJoueFn7mReBeIa9p/vCO68Hob2GVstTh1p07zowNFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8KX3BTbFOI4+E5mocK5yf44DpoNBNNJh/McsaP6wZ8=;
 b=meFPlATOi/ipN9ejH3n/CZmiBA5lSigJ8ePu46tHW3KwEPpAWE+jd+MGfJ6PS3wcD7btI/hJdsKgSEl6QBXB8S03+uL+mV7O8BtDgfmIWuv9LiRsfTdiuvqxf0jk+eZKCFLWYufOatGePUScErgDa2cN5CzIqmYdTEpeg4uJAlo=
Received: from AS8PR08MB9838.eurprd08.prod.outlook.com (2603:10a6:20b:615::16)
 by DB9PR08MB9921.eurprd08.prod.outlook.com (2603:10a6:10:3d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Wed, 6 Aug
 2025 09:02:35 +0000
Received: from AS8PR08MB9838.eurprd08.prod.outlook.com
 ([fe80::490a:c008:ad81:71cd]) by AS8PR08MB9838.eurprd08.prod.outlook.com
 ([fe80::490a:c008:ad81:71cd%6]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 09:02:35 +0000
From: Yogesh Deshpande <Yogesh.Deshpande@arm.com>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: Question on OPTEE Support on  Raspberry
Thread-Topic: Question on OPTEE Support on  Raspberry
Thread-Index: AdwGsIvIH/DNlz1hQ9qKJ5w7v9jeTw==
Date: Wed, 6 Aug 2025 09:02:34 +0000
Message-ID: 
 <AS8PR08MB98385F38DD41E1F66DE067298E2DA@AS8PR08MB9838.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AS8PR08MB9838:EE_|DB9PR08MB9921:EE_|DB5PEPF00014B8E:EE_|PA6PR08MB10705:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ee1766-330f-41c5-1a3c-08ddd4c80fe1
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?RYS2LVRCqtkgv8b79lL+1bea3OciPyEC2aP5vD7srkw75/VLSOAFBY6u+egD?=
 =?us-ascii?Q?cf2Y1joStyEF/C3PX5wCxGxDfL8/PrRJ16NBioLnTvYSqN04giqYS2UmCv2W?=
 =?us-ascii?Q?XfpBeHhLnFHQXwUtkb2fYLqfK/Q7rjWb6S8JIypNsGxvZWKP4XwaUJ3SA31Y?=
 =?us-ascii?Q?kiu8R3Ct30bedGNEg1DVSQy339Ujx66hAR7prBJHI/Tdk+pu00tz7rABI5B5?=
 =?us-ascii?Q?38/1SRxoW2J2pkbRE3oAMM8PpIyo+9adiMAt/Ix1X6SBCwUYmoUD4ddiSjc+?=
 =?us-ascii?Q?+Ggm/JGKEtUk6p84KyuATEvlPmKoqKOOFEUd/VB35+2y1Gh86Cd0qk7WIZyO?=
 =?us-ascii?Q?KJXPc7V3E4+pNAEssTbO9D9UHM63Mmz6Q7c7Xygz5x65yMZrCbAfFi9HTahv?=
 =?us-ascii?Q?F7+5gGAhPGlhmlqCtNa6JaQoj3G5i/KtmT4+Fb1LYHTHKBO3u2k9DVhNHnPC?=
 =?us-ascii?Q?LuwHvzzVMKy/g92iNSSf5BZu3XPj0f+xch9I8EDAXmgus9ZXf+5TBMwUPpz/?=
 =?us-ascii?Q?7DUv7aTRvZmcinzDOQEBF42tZ+vhz3ASpdzK4/6lRuSuALuD8zW3Ko5N3fCN?=
 =?us-ascii?Q?TVa/FJcVBdkBaAfJmJX/p/0OLkqL/k6I8t2xzHmoqzP2mAXSGAReDAiAPfuS?=
 =?us-ascii?Q?kc/aJquZfTuhnLoQUE9fRfXN4Ox1jevf7Lvj7p9dbzQSzh6vgTi3YYW7ITYQ?=
 =?us-ascii?Q?Mn6oQkHQ+ZJ2gOf0bGdPjguZBqfz78QNcoFcqaBSM8UDJFRi+PxgO6pApg/O?=
 =?us-ascii?Q?CU4NOL/79oSrIsslILHQkrAIsjjftrQVX0mDne0xBkSAx5dQF8jIJu5/eeS+?=
 =?us-ascii?Q?1lYjyzFWTuW/GLF85bUwa90kMYaM+38mjZar4BteP7zi0N1h8ov5PTqGJbm0?=
 =?us-ascii?Q?OMLaPAXftxIK87F1ORx9RWs6bPIu2t7Vy2WVoacCxGL/vAFfcj+0cpQx9dpo?=
 =?us-ascii?Q?OzsJoGi9fLGTChPRm4nILEA6xcMgvPFmuQqM0JZi/ShOWdmT3SjrsCuoSStf?=
 =?us-ascii?Q?qyZ+tWL940fctz7TKGwwnRUoYHl2wngqm5VeXwBpXENmwqexvDHGn2vRnpgp?=
 =?us-ascii?Q?LEMh2kQB0YFreXxn/Khsgo86VkQZXnPMGcmMtFHMsBNsnl9vKtXrSBC9vtj8?=
 =?us-ascii?Q?HcQ6AKHMHPO5DWh+WCcM4L3++T23m0tiS3/Ty2bMuIcbUOEu1BxSs+Sbp/62?=
 =?us-ascii?Q?56olW64LikXhZ9JtjnIRPaSzay4iHOSkCzqY2+Hf7JFfuHQG5vinqm8y7Vd3?=
 =?us-ascii?Q?S+n0oNZ+mwirbtJDeJxYEn24Ighw1Tr9zTTs5CSMVyolaXrW1Lfl319F8URF?=
 =?us-ascii?Q?Q2sq1GRJYPkHRRXkC/AeRFS9fzoTXxN5b/Z+gZrj7kDND/OCjuXRl1PRi63M?=
 =?us-ascii?Q?fJ4+jhzanp3ggJQgtabA1/JHntEuH5SN4Rl+bZnqd5o8LPz9aB66y0UzF7AP?=
 =?us-ascii?Q?7/Au4FeAISGvkEJWRk4aWOo+xUJJ4MPuSoYukQpAF0v/4NwM8z7Orw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB9838.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9921
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	578cb5fa-0a84-4211-35f2-08ddd4c7fc23
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|35042699022|14060799003|1800799024|82310400026|376014|36860700013|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?miKGypS9Hv75+BTiZVbKFHmvmnQ7i3GaQ+H2tV5vwclUiXbsHmoJ5vD3UypP?=
 =?us-ascii?Q?BAtzbAVuCNeQkrNAuvDQtOhzlyowuDgKmNP0omU04yxXNHirH0YdcLqdzPW2?=
 =?us-ascii?Q?u7RDRGBm10hUUn4G87klBxmCqa9njWdW2GyJLcIBPPYjxWJlIN1QUondy5cL?=
 =?us-ascii?Q?MgLyoyuiTZI8mAyTeYOxSOP8aFcsrrtoo9XjHhz1g/H/VQ+H1C0jTnYiJJWE?=
 =?us-ascii?Q?qnwVXhdZtRc25uTVzcY4DXf3n8Rst4d+nCDHWTq4cPB0QIxa0Z6oW1UbTxU2?=
 =?us-ascii?Q?c3vPqQ4E5PBuV3ioEYhHWm7YrQghmqQB66+SVR8jzuAyff8DOIU7fppbJKQM?=
 =?us-ascii?Q?p5tteR6xsiH3trTXi1kOPW1rn6gkMvHBM0TSP/PBCcaBY0byTlsfNfftUVXQ?=
 =?us-ascii?Q?krjav3bPNL+AdKB200dlYtWR6ar38IW+lSnjvF86wIeWDpPHB8gBCGuS5Rj/?=
 =?us-ascii?Q?7naprVxhdZ0+D6a3KZ5w4l6OntrwVHi/1O44nwI69thZdUjVX+4urnZ1XCBO?=
 =?us-ascii?Q?nLE1ITNB1ahoXzg/rbjcEye7KQsjQ5xUmEfSYi5NHipIqVvrryXrfYEYSbr2?=
 =?us-ascii?Q?p8I0zsmSmi1w/D8qkCIgrUMGG2JbFXqQXxVmIM1xiVmgtXXDGCijoujx2bVH?=
 =?us-ascii?Q?jqBgzqNldeqB/xsog9fiJV6DIo25ZZir6ev5i35Noj/alGhyZkEyDFkBxWqp?=
 =?us-ascii?Q?9C4170wi2o4sj71PP51WTjtwpGQYkvNyzCSaimuZWlV0h50Z4SmtQsd9tjoF?=
 =?us-ascii?Q?fAHRmx87tZBNjb0/5gmC+9IpjeGXobNEWruCLYJKHxhMEQLqdRavW5ZST5f9?=
 =?us-ascii?Q?uqZwqnBdkpTEdwHAZOO/R7oHkCARsjgGVtajxZ0C+R4hXnlyCWMcL7WOqP3h?=
 =?us-ascii?Q?NVY48Il1Rcvlei9ah/1Wd3DBPtT7QSyOPtJULInn7Ofeo4anGQ3PUQRtD7km?=
 =?us-ascii?Q?mvYCfeLxLeXfcT8YOxU3QMdWSxSksxgXX6kiBLQfx4LjqMyt9X8RwFe+zZ5+?=
 =?us-ascii?Q?IR4y+mUKj0onc6w0IfqW3gYPEK8pnGlBBtPG7zRzIqE59OCoQdsTONyYzLfd?=
 =?us-ascii?Q?yHTDAjqtnkvtpEx8To48CWc4OB4HbaL9DTX2yAN2sSPsV64hwA8v/Ybzw0yE?=
 =?us-ascii?Q?5Kpry7R9/5gRoziyF7v/kebj0Y3qf19c2sSqqHXvJiL7saLKHL4K1R+O825J?=
 =?us-ascii?Q?7R+2c7UIM8HVVPw7CtL2UVKsU4aO/pfvWswa9qetX4gawt5R1rGMp/hncTyD?=
 =?us-ascii?Q?qryaU3giPfH/Kto2j/RilIn/31g/KsZgMJQkbiBE8jyeTXwBAeADNpPW0fmI?=
 =?us-ascii?Q?fM8tzhFYp5oyhO3gOptgAJHFPXuGoVKyPVAOTjvQJazPClaSkBfVg6Wt+m9J?=
 =?us-ascii?Q?ZU95FYW54r8yu5C+98CA70Y23AOBGfsoacSvmDp2aQpeokJradlXOutb7NdG?=
 =?us-ascii?Q?tb67md/KxfhvKVGbYskJX8oNsJOShtzZIExB094SyGMt7TC862Ab69vdpy8C?=
 =?us-ascii?Q?EwyN7GR8yWAwRCB0gVg6rlt0PmFxxd/xA6mv?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(1800799024)(82310400026)(376014)(36860700013)(8096899003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 09:03:08.0944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ee1766-330f-41c5-1a3c-08ddd4c80fe1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10705
X-Rspamd-Queue-Id: D4D3A42F33
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.02 / 15.00];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	BAYES_HAM(-0.02)[53.19%];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.46:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 6O24FYU3FIHG7ZO62HZSSHD4K66OWFAJ
X-Message-ID-Hash: 6O24FYU3FIHG7ZO62HZSSHD4K66OWFAJ
X-MailFrom: Yogesh.Deshpande@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NQI3NFFEDCEUPZMC7PROCZX5S3NL6Z5Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

I just wanted to know, has anyone ported OPTEE on Raspberry Pi 5 ?

Is there an environment where one can run OPTEE with a Trusted App
on a Pi 5 Hardware ?

Please let me know.

Regards,
Yogesh Deshpande
Principal Engineer,
ATG Arm, Cambridge

