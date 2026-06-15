Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAC1CD98DA
	for <op-tee@archiver.kernel.org>; Mon, 15 Jun 2026 07:20:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EEB7B44EFC
	for <op-tee@archiver.kernel.org>; Mon, 15 Jun 2026 07:20:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=D20dTUqP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=D20dTUqP;
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1C1094326B;
	Mon, 15 Jun 2026 07:20:25 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vnBHsmQxWZNoKsfqB01W3UgHf7TRTYVlNdiqcac/ONsrMzHikZfNanma9Xx//fGOKPlo0Da5T8ZLjHhIVRd32z9k6gQ/yZbR/MURsdKlH3OShegN8TaFMrBtame9dQNNf85tMF0Wsz7k7994/Soi/drmxntBISA8akW2ShrEBY2y79nQIwrelbV/rt9M3Id044uDAmzVW1DaFKUMgIvH/q8i/oVfdjyfm3PRkHrUBCX43ruW99Pbagj5MuVUAccKqZqgUWKn7IsAPdGcv2sGtTk92PypIoIFyuMNLBX5X4VunSu5QDhRUuFfw0apJevHK+PvuS6b7R5+cBoj4egfMg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVJeHEf+kBko5k6MSzZYv6qRoQ3DPJ8ZsPmVOWwzrmY=;
 b=M/+tLLDSEqiu+eT9xC+llmiqBaCIz8JGTmWWv0ISCm0Iok1x7cBNaU82KK1NqzsFvuHDemjqe0LGbRp7bnY6RkqJ6TwQcPN9oxAhsPbzqdZMCjPLjDjqGxfsJQn2HWzkOl/sS7zwtM0OC+liEnVbHPDsSy4Y/y5XSYDrFl7+EFj2AN9u0YXsC+04ukpBXi9gBqnuD1YVkRr6q7LBtfAWVz5i32DHGmczmyPPWWUWQaKfo4vr5jsn4hFTsyzj9B29LONWYryndnjNvch57FEbbsH0i1fg8FotUtE7XvT2XHgkRPVVHgPFyZY9jj0C49nnVw0dvi+JJeXfmqK6L7sx+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.trustedfirmware.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVJeHEf+kBko5k6MSzZYv6qRoQ3DPJ8ZsPmVOWwzrmY=;
 b=D20dTUqPiuH18O6rPTha+4t8QWlJLrRds8LM6aFVlZOIpHOj3RMcaj4GsNj1gVLRWP/HQnUeSdhuWpH730Oe4zco3pFWSjF97RpWPNqV5gWuyMVF6s/GRExzoLiixxYXzHvJS7Gvhxl0WU/2BfNJSUaCcLzEEhpR+GfVLP0cdws=
Received: from DB9PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:10:1db::27)
 by PAVPR08MB9401.eurprd08.prod.outlook.com (2603:10a6:102:302::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:20:18 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::43) by DB9PR06CA0022.outlook.office365.com
 (2603:10a6:10:1db::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 07:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.7
 via Frontend Transport; Mon, 15 Jun 2026 07:20:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oClaG7/AsGYb/JxP7MSk1p9XTf6FAecT9LTFdiialERnz/M8ls5HrclJ57QVuSq8UC1xsGSTm51QVxEhkSL/WvPD0efElBP2/y5wx4pUHUlmKwGhFgEyM2kubud9RVOCNN72DUBmubI+YJ1BS+oL65mVT05ZXFznY8E4jsSOsOBeiN264qsY4rD/AU6imNPJYTfDnABXyAwqkMEfbX81rHnk5BGz1IqFm9J/klT7FYp4GF7/CnMRPUYuVPTFKsbPqAe7x3TYq2d49iRrblXd2xOHGzh7X9iPZx6yCyCbYDbXL4KWyxcY4256O/j1CyQq1dDhU7CG0B8hwwx8Dx0/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVJeHEf+kBko5k6MSzZYv6qRoQ3DPJ8ZsPmVOWwzrmY=;
 b=n8HlnojDLakdbqurXctSzUsKZv+Z2jEimWapol2kP4Ev7lhTonPwqo4txtlOmY7Gt7rEi8fvRX+d24dzKp3VdRm2JKI5Skv4ZBoO0KmH+zu472IJqBwHqOk4tJbWmQtcF5OjmOQwRCXVaog/jL13NJ8oYCTyvvlD0tWVZfAToVddV7B5xa6H6y63voUxWaSm4/U6M+H/jkbHukcrkyYOKQWYnxIAiryCwVxxp+2g3GYvyZ3Lq2LxYaAQ3ElKnESmvVOKRc7lItVOyLCu/oPv/5ninB8m/nqvCjOg5yZiEKCOwQ9rcdpicQUxDvfob8X6KOI7JWlsODWpHj19AZ4yBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVJeHEf+kBko5k6MSzZYv6qRoQ3DPJ8ZsPmVOWwzrmY=;
 b=D20dTUqPiuH18O6rPTha+4t8QWlJLrRds8LM6aFVlZOIpHOj3RMcaj4GsNj1gVLRWP/HQnUeSdhuWpH730Oe4zco3pFWSjF97RpWPNqV5gWuyMVF6s/GRExzoLiixxYXzHvJS7Gvhxl0WU/2BfNJSUaCcLzEEhpR+GfVLP0cdws=
Received: from DU5PR08MB10494.eurprd08.prod.outlook.com (2603:10a6:10:516::5)
 by PAWPR08MB9098.eurprd08.prod.outlook.com (2603:10a6:102:342::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 07:19:14 +0000
Received: from DU5PR08MB10494.eurprd08.prod.outlook.com
 ([fe80::a69e:3bea:f840:d426]) by DU5PR08MB10494.eurprd08.prod.outlook.com
 ([fe80::a69e:3bea:f840:d426%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 07:19:14 +0000
From: Sandrine Bailleux <Sandrine.Afsa@arm.com>
To: "hafnium@lists.trustedfirmware.org" <hafnium@lists.trustedfirmware.org>,
	"mbed-tls@lists.trustedfirmware.org" <mbed-tls@lists.trustedfirmware.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Saheer
 Babu via TF-A <tf-a@lists.trustedfirmware.org>,
	"tf-m@lists.trustedfirmware.org" <tf-m@lists.trustedfirmware.org>,
	"tf-rmm@lists.trustedfirmware.org" <tf-rmm@lists.trustedfirmware.org>,
	"trusted-services@lists.trustedfirmware.org"
	<trusted-services@lists.trustedfirmware.org>
Subject: Re: Proposal to unify tf.org vulnerability referencing in NVD
Thread-Topic: Proposal to unify tf.org vulnerability referencing in NVD
Thread-Index: AQHc9MFo5TOl7ZjlJEyJI2r9wIAi5LY/RBde
Date: Mon, 15 Jun 2026 07:19:14 +0000
Message-ID: 
 <DU5PR08MB1049432D162A4E6D01073C196F8E62@DU5PR08MB10494.eurprd08.prod.outlook.com>
References: 
 <DU5PR08MB1049431A7D1A37F662E6677DFF8112@DU5PR08MB10494.eurprd08.prod.outlook.com>
In-Reply-To: 
 <DU5PR08MB1049431A7D1A37F662E6677DFF8112@DU5PR08MB10494.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	DU5PR08MB10494:EE_|PAWPR08MB9098:EE_|DU2PEPF00028D06:EE_|PAVPR08MB9401:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e29dc61-4003-447b-9450-08decaae8de7
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|56012099006|11063799006|22082099003|18002099003|3613699012|8096899003|38070700021|13003099007;
X-Microsoft-Antispam-Message-Info-Original: 
 9fLZs7J3G2XyT5089IQI4F+lDj04AIHdGaP50pEP3FeX4GCKSRrYa8zbj3fTh0n+3lx3VD8ocfMpwa3whOWrxPzcdCHaNHB351xKF/rt95TUuT2Hr9PVt9yZlJvEVMxpTcC1Q5QgYbxZ+oGbp2ztr93JlrM+1exVFopW8vu5vTclFXuGuVB9n+0xhG+xpUVUiFzgftzKu3U6CDk+sHupGByYNsc7CaGvQDoq/l1WNnIAQqJziyHePyuQBf9AUbqpWw80KXakGS0YPt7aduATLJRy48uJmMU7UfJCJ7tFKMSNKvO4ENuUMT1821ZX89sEV7OOueQosl1LaLXsRDgxeHCcEPET1iXu5tSPlHghmKQvFvTT2MxeUqmvhVqE/wvxO4nSySD5W9ZeRou2LtDwcDAiZqilSxPUlHECQU4dn4cI0NhzsoZxg8C/40MjxBg/raXiZ83X0V0W235SifSDDZZ/aklPG3hIj0gcvUjc1oYOs/xd4iSBhF8UsANd1zAcLBn8YYuEFGBBzWWV85eg/4yZqZ8XhktqIWF7hdK198sdJmoZGr3PUs1T4hfe/DSkKreSM9vv0Jhol0MSze36Eoy+zCA3TeRr1N6lxopDO3fjphggdvRSxSrwYv7l9PGPwWWFsrKQZpcafsgs+gZzHl5EsWWKWGT3y8V+7L+PABbEMRcBNtpIINeecn1TYFlEXtwDBSoH2G8FKNTJrIUpCuGcgVnGfoOTAShVmZ1qzQY=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU5PR08MB10494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(56012099006)(11063799006)(22082099003)(18002099003)(3613699012)(8096899003)(38070700021)(13003099007);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 LKR/Hpb7rOj1SOI613mW3kBAsoX14MwZdLQzyhP5pymE4EIcCQXMPyS7bDr5lUTL3NWWjil1/PEUpR3YCb2/pq5FUjH0/qwotwcoeb+QT6mESgONfF+OrYSU1JezWvkmfKda+HNSKMC9mWltTHGpRtMLD25ulQqYpDhW0PZAczu/8qlJYlUD6ajlVzfc0y2sgJwtx5Ejk8fEMK8Mi0UgVOCWJFGuzxbp5f6tzmgBZ/JSM2isX5dIR++X6II2+mwncGMy2e3zcv2lqZEj6pbXg/v3IAh40iQbzhYdnIHXDIzJZoo8pnh3VlGlYw6q8J3MQM0wbHlUYZOpYvBCd0Kv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9098
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	24bcb127-0c36-48a3-76ad-08decaae67b7
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|23010399003|14060799003|36860700016|376014|8096899003|13003099007|18002099003|22082099003|11063799006|56012099006|3613699012;
X-Microsoft-Antispam-Message-Info: 
	xp/T4GOlas6qmVomJhoH62E7NYK2uEAu5S8UFBQvFytgBlrGzhXl/oNFmF+pkWRh5WeN06yuimjwpG5VhUCLWxy8igYRd6H4aBnmobQ5lvmbRD5OpqzCcBU1EmACPkoTYX1okjMJVVuu2ngD9jSkdplF/HvIJYiVTePDbNAREPGZ/cZCf3N2skYbN4DHsnZ6hSL+bVJpya8zz7UsLz1F4xoPVp0tL5VGbY/zPTNwTOSwJbYWikcGImM/GRKc9V4ejnoBBR/sMUMbGCsSoZPLmmttZsYymtaSqr5OW+yGpLadzTPL0mbV8bsuBPBEGzgm9OFFwAEa/wx99tB/jZzzqtk2HSpZFQuYbRYdtr95keyE+e7jRVaHEM7j+neaGIXKmvZCJr+39CAQ1+hQ4BbFMEQVLnUaLv7CKigK6ud41A4i2r92FebfmzNrtTVpWyMqDJ2Yj4QlHM/NTzx42tI6s3D7PX52t5fMYFVmfrvb2inHnEpcXzfx7f/cHMOgcNGuHJZH8nkt8COLRGXyAFcr+IeGsHpSaxThg2cMKV7r/R9vLxpHIigiSbsmvVpv3wUjREoFCwWdFafStPnZDT+2ywCxJ+qGZ+UbHYIkWlMR1wgHrSxS1qLi7b1Pd19yHcOr8HrjHjPTlXt+KBU/PRKDC1h8Xup0QTmOFEkEnS007/464UMZ4hnMCxG07HDqG/aPpMdD1RNhJHNovS72+4ELqXxn4GqR7Hu9l6XY655QN3c=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(23010399003)(14060799003)(36860700016)(376014)(8096899003)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	dZalhmUn6EbIC2ALRAKexDJvrmCCGragnmVa8sGS+9XbYoUgFaAYqk87WB5Cp1OeWNDBt0yizZjlQm1hJydNwTSiROISpIb+CuvKBKm+AhEs1Ye6TP+B5o+KTBWDpdjRjltRJn0VTUx8J0iWOS3VU86jDG0i+BTmZx81XFm4eACWl41DUYh4PeDYTgu4gzVPSltqRuNKIiJ+uf0fjDN/IK7gw3j+uZHTElmGrojGlukWBinwlGlbWzJxD7+8VdlhZAzQVC6QO6ujNcHnbAtmp0IWRviHU5kILFUWUQ/dhpk3H/qwgBQnk/pVmE8Vz+yUkHuMj64UYAQCjLZagUWhNYs6nByneOLhzF8DJ0lsjusA6BUdvlLw+v9eKSlICqp6jKSvn/pxs4jw+ltiwrNbGjgbV44XWvKooGvKhuI6XlWOxpj6z86uGci/zAAS0vuJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 07:20:18.5944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e29dc61-4003-447b-9450-08decaae8de7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9401
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.98 / 15.00];
	BAYES_HAM(-2.98)[99.91%];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.83.42:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[52.101.83.42:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1C1094326B
X-Spamd-Bar: -----
Message-ID-Hash: OMUGVRJSTJC4Y2DYREUKWVWACFYUWG46
X-Message-ID-Hash: OMUGVRJSTJC4Y2DYREUKWVWACFYUWG46
X-MailFrom: Sandrine.Afsa@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FFHGPCZZG3EOGMBMNNWGHXL76KZK4Q6I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi everyone,

Following up on my email from 10 days ago, and as I didn't hear any concerns, the proposal is now live. All vulnerabilities indexed in NIST Vulnerability Database for tf.org projects (TF-A, TF-M, Mbed TLS, OP-TEE) now appear under the vendor name 'trustedfirmware'. The following filter shows them all:
https://nvd.nist.gov/vuln/search#/nvd/home?offset=0&rowCount=200&cpeFilterMode=applicability&cpeName=cpe:2.3:*:trustedfirmware:*:*:*:*:*:*:*:*:*&resultType=records

The aim is to simplify establishing the Software Bill Of Materials (SBOM) for a product, by providing a clearer and more consistent view of vulnerabilities in software deployed on those products.

Best regards,
Sandrine


________________________________
From: Sandrine Bailleux <Sandrine.Afsa@arm.com>
Sent: 05 June 2026 10:30
To: hafnium@lists.trustedfirmware.org <hafnium@lists.trustedfirmware.org>; mbed-tls@lists.trustedfirmware.org <mbed-tls@lists.trustedfirmware.org>; op-tee@lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>; Saheer Babu via TF-A <tf-a@lists.trustedfirmware.org>; tf-m@lists.trustedfirmware.org <tf-m@lists.trustedfirmware.org>; tf-rmm@lists.trustedfirmware.org <tf-rmm@lists.trustedfirmware.org>; trusted-services@lists.trustedfirmware.org <trusted-services@lists.trustedfirmware.org>
Subject: Proposal to unify tf.org vulnerability referencing in NVD

Hi everyone,

I am sending this email to all tf.org project mailing lists to ensure all maintainers are aware and on board regarding this matter. If you have any concerns or questions, please reply on tf.org Discord #general channel, where I'll create a thread, as I think it will be much easier than dealing with cross-mailing lists emails.

Background

When a security vulnerability is discovered in one of the trustedfirmware.org projects, it is common to request a "Common Vulnerabilities and Exposures" (CVE) number. This number uniquely references the issue, which can then be searched in the vulnerability databases. One of these databases is NIST's "National Vulnerability Database" (NVD): https://nvd.nist.gov<https://nvd.nist.gov/vuln/detail/CVE-2023-51712>

Entering a specific CVE number in NVD search engine will allow you to easily find the details of a specific issue, for example:
https://nvd.nist.gov/vuln/detail/CVE-2023-51712

However, sometimes one is not looking for a specific CVE number but rather wants to list all known vulnerabilities affecting a particular project. For this, one can use the Common Platform Enumerations (CPE) search engine:
https://nvd.nist.gov/products/cpe/search

CPE is a structured naming scheme that includes information like the vendor name, the project name, the version / tag, and so on.
See https://nvd.nist.gov/products/cpe for more details.

So for example, https://nvd.nist.gov/vuln/detail/CVE-2023-51712 referenced above has the following CPE:
cpe:2.3:o:arm:trusted_firmware-m:*:*:*:*:*:*:*:*

This basically means

  *
CPE version 2.3 is in use
  *
'o is the type of project, in this case it stands for Operating Systems (which is probably the closest match for low-level code like TF-M)
  *
'arm' is the vendor (that is wrong, see below)
  *
'trusted_firmware-m' is the project name,

Problem statement

It appears that CPEs used in NVD to reference vulnerabilities in tf.org projects differ a lot across projects. For some projects, there's even multiple of them. Sometimes the vendor is "arm", sometimes it's "linaro", or something else.

Some of the TF-A and MbedTLS maintainers have initiated discussions with NVD to get this simplified and unified, but it would make sense to align other tf.org projects as well.

Proposal

CPE naming rules are that the vendor name should the parent organization of the project. Thus the proposal would be for all tf.org projects to use "trustedfirmware" as the vendor name in their CPE.

For example:
cpe:2.3:o:trustedfirmware:trusted_firmware-m:*:*:*:*:*:*:*:*
cpe:2.3:a:trustedfirmware:mbed_tls:*:*:*:*:*:*:*:*

We're only proposing to change the vendor name here ; each project is then free to choose how they want the project name or the type of software project they want to encode there.

Thanks for reading,
Best regards,
Sandrine Afsa
