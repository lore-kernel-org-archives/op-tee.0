Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF4A606A323
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FLKxdx1a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FLKxdx1a
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7095F4534F
	for <op-tee@archiver.kernel.org>; Thu, 12 Nov 2026 13:53:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FLKxdx1a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=FLKxdx1a;
	dkim-atps=neutral
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AFF88451D4;
	Thu, 12 Nov 2026 13:53:37 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=v8J1+tjNxmko1teHhVHmk6CDuHFpUGibu7uElwrJeQDVLlOKDqkrSSZUNV2odYDzQztAjajAMZjPFVj+qcN0webyyjlkKUsoXR56OLDb3/70kX8j9x+BFJheohK/s4T1hREWgwxZlps9OeKq62Xh4rxNrVY134xGh071SwGNWpDoV+WOFQBWDN6ER0lYhR5wN2EqmHPGSqMh/rOIHmRnDWlYyHQ8d0+VD5Wr70TEOc1njz3T2Briqj3cdrs0JPZQOC7rpUWY6b4U7vpgxyQmhdSMBKyKljgNhJAcMsYl497veOtkCvQ59j0McarUQcAGiiVVQx/L2cJfM7VmKgPsGw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsjyY3SKwUedGOc1aZMWbbqt9vvStIjStOPy9G9arnM=;
 b=p7LeHpINFnd7e/F6CBIsiCZSDfxsYhAlKkOfLmyGbdG//To17lVKpy/VxOcfECUHKnwB6bTxUNsCJ3UKVI+MNP/KaDEsRd3QOLXXNwFf0OamuTNuunA0TNdBsoLCUjUMRkL/evx6WGvXure3pYcApUor8GClD4ySDIC2Q0+6ZP7jnXWY5Nr0YSJPN0tY7RNzcRHE8+e0MF0Q1Z4pmIuFQgo8C36ZElqSRN2aHtPCW1T08cS094RjC6iv9R4MfXXveVmtA/CEcars5zMHiNtM6kaOGMomWU9dfzB+wzebRkxxuRkCZWxEQSiEPpktxeOtMozlYHZWJ159S3K8UDa1pA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.trustedfirmware.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsjyY3SKwUedGOc1aZMWbbqt9vvStIjStOPy9G9arnM=;
 b=FLKxdx1a31hBJbEIEZWaD/ajDGdryx1Xe8YpfO9P+xV/k4rIwNM25XOCK2agvX0F1Y1NFgNEnY2xrbJ7bBdIvNtK6kAu0w0ksdNgsFiaU2pBK0HLh5fNiRn9vufFskMkME1uRXvrK5NihMmflmqoZPBTRMWF8vushLHnl/SLGzc=
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by GV2PR08MB11793.eurprd08.prod.outlook.com
 (2603:10a6:150:301::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 13:53:29 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::54) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 12 Nov 2026 13:53:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Thu, 12 Nov 2026 13:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRAd3/Q2chA7MqV2T1xkAjYbgJiqC6KpF2xCvsy7q+6n2CR59Kbuk8dm2d7/QvqRW4Mzw8OvonPzK9mAtZ4XDAoaqPRNaB+fMAEsV23LeW936/AB/U9HnsLG8rydluVtSldnCxtYfcst0jrbrLz5c99zNt4D5CX2h9m00m8gOrEDySUebNWYOsdoWVAthJ33mgc0wl9t6W7isk/7m+jfmd9zRblue3WzemNckSYPPpN/A02acNTpr8jN21VpASeqZ3m1j1WD25v+kvAzbO0BV2SyXRnd/quco3ixWpqaGwVgjqucVRziUSAgkbXvlD+jwUKrsCsvrGXEl5nAopFXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsjyY3SKwUedGOc1aZMWbbqt9vvStIjStOPy9G9arnM=;
 b=qBORUmiLOKrHXnJ/Kx3y3dvG5B1dXIRpmbtBXMs8d04Ci/EJV+3gRHsKpPzIq1uStVxRKiQfIDGu5ruyAMUT4TNc+xpjlvnJp9j4uH58gpzr7bsFlzCGBDTuKIcoNi6nQUweabeknnlBkJgodyW+0Aa/aw0+FbN2/8qfEg+M5QOLvvY8zrzXA7Occud3C76WhQ+D53VhvThWa+VpyCOFGI9Zcl23NDas3jvqq9HkHolYvt6vzgGND7p+qc3sndDPh/QgzXhQ1ml1m/EWcZ09CDk0EY3KA+OyNm9md27uMXo8M/Ma4BIi5FZIlCJTsACNM/HdCGRKs24BaHWrjBx+HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsjyY3SKwUedGOc1aZMWbbqt9vvStIjStOPy9G9arnM=;
 b=FLKxdx1a31hBJbEIEZWaD/ajDGdryx1Xe8YpfO9P+xV/k4rIwNM25XOCK2agvX0F1Y1NFgNEnY2xrbJ7bBdIvNtK6kAu0w0ksdNgsFiaU2pBK0HLh5fNiRn9vufFskMkME1uRXvrK5NihMmflmqoZPBTRMWF8vushLHnl/SLGzc=
Received: from BR0PR08MB296250.eurprd08.prod.outlook.com
 (2603:10a6:2c8:44::17) by GV1PR08MB8355.eurprd08.prod.outlook.com
 (2603:10a6:150:a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 13:52:52 +0000
Received: from BR0PR08MB296250.eurprd08.prod.outlook.com
 ([fe80::aa91:b69a:5a96:2d28]) by BR0PR08MB296250.eurprd08.prod.outlook.com
 ([fe80::aa91:b69a:5a96:2d28%4]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 13:52:52 +0000
From: Janos Follath <Janos.Follath@arm.com>
To: Arm PSIRT <psirt@arm.com>
Subject: Re: Open Bug Bounty Reports
Thread-Topic: Open Bug Bounty Reports
Thread-Index: AQHdcgXw0bEcaRIAYku9qHc9oeg9BrcqdQr7
Date: Thu, 12 Nov 2026 13:52:52 +0000
Message-ID: 
 <BR0PR08MB296250B8F16CB6533401FFCDB4E8702@BR0PR08MB296250.eurprd08.prod.outlook.com>
References: 
 <DB8PR08MB537207711BA5C7066997B7B2A7712@DB8PR08MB5372.eurprd08.prod.outlook.com>
In-Reply-To: 
 <DB8PR08MB537207711BA5C7066997B7B2A7712@DB8PR08MB5372.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	BR0PR08MB296250:EE_|GV1PR08MB8355:EE_|DB1PEPF000509E9:EE_|GV2PR08MB11793:EE_
X-MS-Office365-Filtering-Correlation-Id: b05caab6-ba2a-4643-d489-08df40c45522
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info-Original: 
 rmKgrCwHLyVJ8OlDFpELa2Abfi5Yc5ByCOFEqLIWpRXsNhAx7P7XlxBJLKoOMYpxqOw352yCRdn2EKloLoD3CVq1EmtZZPv240udJzIDYk6B68+0945xXpRF/pCOat0uSsNYQNO4SSuxq8opIeDEQu5A21OAGSN43uYqZVFAOCjSNJnUEM24uEA0KnegGaoMgoHbhfmnDlTk1vJ8eYPLPGr7KzZ8uPGdOdw0oD9eiqCojkKTBRIV2w5HktKfAsRjViJabt2y8oN8mzjFzeW5H9nsCjo+VROqdAdGHLe6QUyaoLdroKAcngOZecI5aan8GpjKgNcTwQKuXai5pZSd+TsRtInyJMlHsHy7HCmu2UbBn9+8S8CRhGVwnIjA5yu7iCrBOpe7cllswJl6voaPdmlzFee5KJFZkWUWHSkV6ntoncWQfUim8SZUVG8O2oryE/yYNwNj6OWwYL26oSRjseFFDXZ6awIthg4BLf2t6xzoBcO5dYbrzYaKACvXDh6ZgXIBmSIeHMcckLFBLu+43fyUMJzq5VulVIiWhZrhxL4rx8GOj5Sy8BkY7jwrRr1gk2x434fmBIFF9dAz0DsHiWORj+fYCwsHQH9IZBTenDKZe5ZGeJhw/bAiSd1ahsevNwTDOS8tb29o94upnYkXZ8OvH3fb4XefrK24+3OYTUZEYB6i3Cfms+3zjmo54T84eGMvbl2Ed2sNfF9Z9lJQ7S/rBDIOa5Ed/5OjEmLWx10=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BR0PR08MB296250.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003)(8096899003);DIR:OUT;SFP:1101;
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 Xz7yrQleJQBKmZrTvP3LPblxA7/4rJyS/d9Wa2q62JVWWlvvvgY0KklJu7nws22pgmHpAHexFf1qYRDLzLcVi0tgudR6UXqpJSuClxzhwDL2tIieYeoGRn5aJeKMCX/kBXG0xamR/1nxSDy4bwrO25ClLqHe+NbfEhdpenF+C8iW31CZXfVlTxU3bKQQxxPsiqZM01wLN6+pnOLJDDdRZfY5LA9YgsC9IDmkvGeWe9vf9fSKJLadrvO7rJOREyoGH+9zeMc/x7Q+2N/N0mbj6Qvkak14t7Tm0N/QNOjkP/eBMW4yNM0pIO169vgqBydSEookD2lLUO+et2fpYAK7Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8355
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	33fdcc02-9368-439a-b4ea-08df40c43f24
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|14060799003|1800799024|35042699022|376014|36860700016|23010399003|82310400026|11063799006|56012099006|261022105027099003|261026140227099003|261026121527099003|261028144727099003|261009223027099003|18002099003|22082099003|10067099003|8096899003;
X-Microsoft-Antispam-Message-Info: 
	MoyPcpKOqYQEvPvJHzQIRVVkQM8sXwS5tn2wO6syqJBp6swsrCNhIwAfDDFvdhcso81DJ/2BNT0mqIMdNH6MvSibDClkT9638h82qEyd74CJiqMjSTwYmhkTmanGAAi5f1qSN0FmYgHQNYK6SbCGm8Huz3/NO7pq0tbPyD+bGtV9oLGoMTjWjD5k4Q7S6LEwHsY1bbUMtKbyAsOwZ+9ZQwfF7LpzAxs12Nr2XUyM6fPRpLB96cN1Ang2FuYicSGuJMJ8GBWgBHzvv2JFdVe2eJEThOEZ+5YzA/kvd/AZtzTr/mhIQzYU8+nnb/J12Htwwwn7H1wHc9hxu7LjMmQimubmG3kodpxhl7td9GJVwuNN4Aa3CUycTQqOGcP0Uv6gbHC5hJMp45cfeqp8Mn9To9jqvYKQ+m5ohxODnsWYP4LfUnNtHsa9lJ1+w3HJmQ5/H0u4PQU5Kc4nWIRg688kO6iIAYHuisZO8V7lAI9xGGwxUjJVs1mzyvQsyf/o+Pfxbb84SQfTMFmI9JiCghkvfMJ6KgGRHVsOS+dOhjpXTF016JGjofH9NVDcDQTZikKdg+gdoOIPJ36IQeKMxp6K7PGinS0DOPqIO9xuo3C/nhvOzwU8LkHn2dnzP6WIVDahUeOS9m5KzYg86sKlH/wWLI0TvmTPcJWiA+smSUB7TI8LxPkWRelC14bXiRd1vVOmx6Mg1b6doz6XoGGoCTKScA==
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(35042699022)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(10067099003)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	/R7+7LvoIlz+B1C4wgHi1FIiQOhq8iSA4IepHsv+ZlSM7xBE0p2tqRJq/YPIqBJx+V3h242bli9J/82hGz+ouPBtqLhuTyrRdNQrdYdLALi+H3r8ahB7GlvCtk85FA+sIsWXos2nfeeJZd5gwNApcf7Z4t6wJMQwZP1jgKsRzwtCWEQEwLA06Ts6GN1fvalHKQ3WWjzJkrOtj0fCaZzDel91AR6MrTiKNe3RBKTA9jtgZKapw4hoSTcvcQQhErURkx2mtpF2b4Kh5e2THPBRUYx44YJ6zYSKI6A0CQsnvN4UXLAwyMu291c84G/KPBmV9yFnFADOwNOrt2P+rADiwTWYmcfdhwPkQkk5upL25ofcfwv97drD9N4cQfMH7oAGq7dbMvFvDvPb1pUi+rDHFdenqxk8VnV32Qwms/b4dMVdrn1p8NgwMVrcuZWIgwP+
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:53:29.4838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b05caab6-ba2a-4643-d489-08df40c45522
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11793
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.70.8:from];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.70.8:from];
	DWL_DNSWL_BLOCKED(0.00)[arm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AFF88451D4
X-Spamd-Bar: -----
Message-ID-Hash: OF44HIQB7DZEJGCPWVXH2KJPNDDDLKWS
X-Message-ID-Hash: OF44HIQB7DZEJGCPWVXH2KJPNDDDLKWS
X-MailFrom: Janos.Follath@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="Windows-1252"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: Dan Handley via Mbed-tls-security <mbed-tls-security@lists.trustedfirmware.org>, Anton Komlev via Tf-m-security <tf-m-security@lists.trustedfirmware.org>, shj via TF-A-security <tf-a-security@lists.trustedfirmware.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EI5GNXVKIAQ72TRZZ6A4QLSKCZMSGZF5/>
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



Hi,

We have received only 1 (ARM-B8OBIBVL) out of the 8 TF-PSA-Crypto reports l=
isted. We can=92t see them in the archive or caught by any of the filters.

Could you please confirm the time, date and recipient of the corresponding =
emails so that we can report this issue to the service provider?

Many thanks,
Janos


From: Arm PSIRT via Mbed-tls-security <mbed-tls-security@lists.trustedfirmw=
are.org>
Date: Wednesday, 11 November 2026 at 18:33
To: op-tee@lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>; An=
ton Komlev via Tf-m-security <tf-m-security@lists.trustedfirmware.org>; shj=
 via TF-A-security <tf-a-security@lists.trustedfirmware.org>; Dan Handley v=
ia Mbed-tls-security <mbed-tls-security@lists.trustedfirmware.org>; Arm PSI=
RT <psirt@arm.com>
Subject: [TF Security]Open Bug Bounty Reports

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

