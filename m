Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CB2CD6E7B
	for <op-tee@archiver.kernel.org>; Fri,  5 Jun 2026 08:32:16 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 277C84448E
	for <op-tee@archiver.kernel.org>; Fri,  5 Jun 2026 08:32:16 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=d8DLOFU1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=d8DLOFU1;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E3BB444441;
	Fri,  5 Jun 2026 08:31:50 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=o3ZIiPGhieQ1PBbiaMNSiygpkP5a37Bihv6eFO024+VWFUpjeej8fbSjkqXCJ4wwXEI/OCv/5gP5g8kLDsjDCR9MdvGYFbcXwZ5zhhg5zxVN8rfGrDKJXjdHx/TdpHT2YDuPM4qG6IamR9Sk5x570mg7u9OL47xVzRG2PvvEh08vaypXv+cfchUfBdnty5Ala/V5is7NPI75changzuNTUH5TBKF+EKRBApK8h4wSZKxL4hjtfxY1wp8atFNPwFw/6j86og7w4Mp9iICKMINGKZK0Xe04fQmE5xWuBr73K3RIpV2ScnpSYBTpN/qfdf5LZaH9Q0A74u5lVEsQjCopg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izywdsixDFN43XEZgUf+7FAgEf0MeAxzuUpgBi2qe/M=;
 b=HbMIpEK3avpMvuMz+9Vf8z6AF858MXIGPobQwnUSxY9/x92mq47yoGqE4BxTa33J9ytQH7zcZk+xjc5SH185JR83Q+vF78h2kLxxh3uZSfJDuxNnYlGC9au6xvHnMsWBUOzg+9cmDvVaNaYvWtv1+tQZJZDqgIftVNpGpi0IiynQzZStxwsJICYXZ7dcf5r+GlYHIKP/MzY4Ccy/nIcZqI16nAr/o7AwX07fBsOwZ79HWC+p4uerYIG6JxCBigverPARH14fwDcEHwE/klPc1YkJCsyf2YM54h4MW4afzi2yqSFEqhbs3SUGIFXQnfBNnB6F6rMaRNieRBLL6GCfUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.trustedfirmware.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izywdsixDFN43XEZgUf+7FAgEf0MeAxzuUpgBi2qe/M=;
 b=d8DLOFU1xC9dc9yayzmMY1ZP7HWfdt0nYUkUl+9IlanPDKCQWbQjthOeiA930SSeHSDa3yDq0f2Y3iN1bNJsvNLMn7+sfTF2m/1RlWY+ZtBUCuUFAs4Mdni7ACrygfDHvYryDKau23N3TD083SXseCdlscNGmY9Z7De1eoHy084=
Received: from CWLP123CA0262.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::9)
 by PAVPR08MB9481.eurprd08.prod.outlook.com (2603:10a6:102:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 08:31:46 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:400:1d5:cafe::ab) by CWLP123CA0262.outlook.office365.com
 (2603:10a6:400:1d5::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 08:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 08:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7K1F5YSM0MN7tt8/S7hF1gzf8HOlMv5/K1V0CgwaaBkmDMHTM36jEVo1cuOb+H9QKWfHo6dS5ji3lZm7mNCKGZFQEmz9+XppZHXDm+xVcNZ5CUrfN6qMBGmSa8V/npK9Dg8ZXI7GaGA+GHRu8Isz8XdfWGa843H/CTx7ZAnTYip37mf2JDqKbI3F5G7F0YWW/YQRH9yZyGP0vw1lUm4dM+U4LHDMHw23KJVfPjKEPJI5IIC7nO9wGKS7M6eXxNKIhhbfmtPh89nPwDBBTHWRq6ASy4GXveS2VxDmOhs85QZ542FL6XzotF7tYky9F3p3I2eXalCyh7kz7FXcuISgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izywdsixDFN43XEZgUf+7FAgEf0MeAxzuUpgBi2qe/M=;
 b=kyXR+D0gU9GVeYda6pRqMpNjNAQp8QuPgmwoxKeQDv5xkb1kRH5zNFMUiVl90u3dsmmkuVP8y0Rto3WTNPqj1F0PozDDmpTlT7aR3pyYbi9nRa2Uo6wp/DqC0HvNuLDx5NfxqB7iqAW9XHDgBG+pQGPkFd4WtBPBXWEN5zQYjGmfouBLzJ2oBtnobTPSoe1yugby6OzUXkOs7fROgfoEz5raK2URFN13zlAwQOJcTqIwvrVxiiVIy1rH5NDx1PupaNI3J8WE3OWWkhJZKkNTt9NgvwkezREDMIVe5t8E501Yksjw1egl+IGDM/leRhCTqxT4mXSYYhUIXkAgdKIFGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izywdsixDFN43XEZgUf+7FAgEf0MeAxzuUpgBi2qe/M=;
 b=d8DLOFU1xC9dc9yayzmMY1ZP7HWfdt0nYUkUl+9IlanPDKCQWbQjthOeiA930SSeHSDa3yDq0f2Y3iN1bNJsvNLMn7+sfTF2m/1RlWY+ZtBUCuUFAs4Mdni7ACrygfDHvYryDKau23N3TD083SXseCdlscNGmY9Z7De1eoHy084=
Received: from DU5PR08MB10494.eurprd08.prod.outlook.com (2603:10a6:10:516::5)
 by PAWPR08MB11485.eurprd08.prod.outlook.com (2603:10a6:102:50f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 08:30:43 +0000
Received: from DU5PR08MB10494.eurprd08.prod.outlook.com
 ([fe80::a69e:3bea:f840:d426]) by DU5PR08MB10494.eurprd08.prod.outlook.com
 ([fe80::a69e:3bea:f840:d426%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:30:43 +0000
From: Sandrine Bailleux <Sandrine.Afsa@arm.com>
To: "hafnium@lists.trustedfirmware.org" <hafnium@lists.trustedfirmware.org>,
	"mbed-tls@lists.trustedfirmware.org" <mbed-tls@lists.trustedfirmware.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Saheer
 Babu via TF-A <tf-a@lists.trustedfirmware.org>,
	"tf-m@lists.trustedfirmware.org" <tf-m@lists.trustedfirmware.org>,
	"tf-rmm@lists.trustedfirmware.org" <tf-rmm@lists.trustedfirmware.org>,
	"trusted-services@lists.trustedfirmware.org"
	<trusted-services@lists.trustedfirmware.org>
Subject: Proposal to unify tf.org vulnerability referencing in NVD
Thread-Topic: Proposal to unify tf.org vulnerability referencing in NVD
Thread-Index: AQHc9MFo5TOl7ZjlJEyJI2r9wIAi5A==
Date: Fri, 5 Jun 2026 08:30:43 +0000
Message-ID: 
 <DU5PR08MB1049431A7D1A37F662E6677DFF8112@DU5PR08MB10494.eurprd08.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	DU5PR08MB10494:EE_|PAWPR08MB11485:EE_|AMS0EPF0000019C:EE_|PAVPR08MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: d1732e61-24f7-405a-6305-08dec2dce194
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|18002099003|13003099007|11063799006|56012099006|3613699012|8096899003|38070700021;
X-Microsoft-Antispam-Message-Info-Original: 
 WC9kXLyCvWAI5T9iDUBQc1Z6im6UIwm6VC2OvnoqQIEaWKRP3yt4CFmTHOYvUIEr6eB06/cPYnu8njXoJKd5gjAkCFzHT3J37k+q0SH5BxCi6ggvcw9wtKSkn6CO4as7mf6OOjcbSKkcVU0Onfe9nfWMIBlmWRvOW7y+xU3+Iwd8AK2b8TB3jMtGjH4anIuPO65rijdkz7zRDV3u6xcyllVNxP8q1r7g3M1qviutBkF6NKcm0aRXXE2EluBoCEV5icuzuJxYPJgGysDyFDcP1xQUlGrBVOZH6WMHNhTDmiGOn5BcmH1enBNkAOfMf2/d+48tWGa3POJerDdWQuBiRZ34FgfHnMQAddX5cITesMn8f9jK7JeIbZZGoFhtaXqTNV5Vi3422iPOLPMfxAzMnHnO2HFpMx29lKnGbgHAKYyeS/BeAJ8xMCrkbwWo7jaOl1RQmSYBwIp5PBz3NsWZknLaMOwSNaVCh2syYbOFGm74tORjca2aOegf4E7zfaojR9hobI2ENlyST7cYIz73n5fZcOjqFgXHeuDh3VvKxPWRwMWLNDJia3BFt4tSTLj8fA1dAmspj2Vf42Mxou+CylZl4CZKMkHqWINWQM5MZGJbZ7L8O35Fhc7W+KQv8ZGuEDfH5SWEdGKve4kHUMKidmIGB2Lkauog4atypwGxjFkQ1vr56vBNNBB7zBwNYoHmT0/WZcTUx6n1Z/nHZCWmx5Mj5LSqg/CK5WJKcqeY4oE=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU5PR08MB10494.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(18002099003)(13003099007)(11063799006)(56012099006)(3613699012)(8096899003)(38070700021);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 XNzgEoCwR0v52aAvDdvc2qL0ff0C8+8lZY7zJaoC/g01IBqNesRs4mnoalwEcE+3woq0NVzxNZPvj7msHFeckSq0THuhjxqdNtNwUCr0qekJI22k50yJD2ASQLIhm0IvbmXWOyZ9kGeTu8wkF5Kyxrg6cfSydSh8a+HFpPgXjMVmCTbPfgvrJaXPyiyaKhcITbBUNu/7EsPPy8xis9ph+HD/QjF0zp342kQOL5C5Uq9Zm/1iXgdfUoyASqwOJxDOygHTctLbsJjr45woUPnjAD7R7EPM/dCsGV2WrCPusskmuH4ewkFk/8N4XiXRyMOnMbHGBbcgF3wbOPMpa39zmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11485
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	1e99c9ab-3c26-4f40-4fa2-08dec2dcbbfc
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|35042699022|1800799024|36860700016|14060799003|376014|82310400026|8096899003|18002099003|3613699012|13003099007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	aT7Dg7MG2Fe6sDlVoSW0kXEDBS6vsIfotwnkkoZIWEF0+OWLXggfI5SZhOpqsMEYcK9YPo4Q5WCio5IEOdFMHC919JbXpixneYneWT4o+m8ylwUVMDRP/fYv4p8g9uxhlzLb6sksrhq35ZBOWjkKhT2MBIX+9uWYx67xNp6pqDeke6Y6og89cc2q1LGJtZvcmLHQGtoi2wiFpoxjZ0kORsQv4hib4HyDevcOGLK9rrhIdvC6ftS7O88jwEmHUzgWz/1dGXuYq+33XJP2DpQHD4z0peVI9yoEvqxM+2HWDuScZZlAj8hT8QLj3SZNN1TyspcIoen+MCdZiYu0KHrr/iNiVUUHOYpiUGIg9aKosGXmdfmY2zhvdyVrWrPsNNnH9dkYfTDsvLTuci/gQEKCscaaliiTV23ZplXsp0RhVfnyOBjMRpRdkuNgOW0iLrLW8xy9Sc6/bkY0Tf1gB6ZBp16OFMlhIZKU4aYvo4ZCiuZKw7cvdS2ppNFhmGHiCeGgD4AGV2Wb1CvwkQIqJwhNsUZAOc7lRFYm1m+3KGt6vnrJydNq9VeUWU/NPZh51WLxgHshFPJnLuRoWFMBuiPjWsVPLCCqzgHpLfRCRfhygsrY2EDi+S5YychfFnuNiNPXcTNe9jRtKuQvxs9vN1YI66tf413sEFzdTCXjoBE5PENYZrW1QYM0lPh9lJU5Yra9BeZMBB9P8c1WjIWdR+BYN2qSKSZECeZiR+gafHrof/M=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700016)(14060799003)(376014)(82310400026)(8096899003)(18002099003)(3613699012)(13003099007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+xBp3PixWx86kfhUBBV6VYWEQyauL7uywC1Bwi2QR/7As2la9dS95DyFNQcesChQ6qU7YCgo2jEkcV7t4LpGyDBHS3ztTaEUkeisq4xJu5Zp34FSiNMrdF7+BIiY/MouHV4oetF4ANd6Y5g0giKjfWKRDstfrwmXbrb5U1nHLR4RDtJrjf+0fdzAb0b6jLU6ATPYBhGsnto8vaellYkTYa0fdnze0U38Q77FxNxmLIYNTvQRyKOaEXXbEORUQpomxh2BxE3DnENCAxDnmBBvMZyRcUxGBYZedQzyyAy3CSDZFl25N/b5Xsw6ISPlYQTqdQSkjQy50X2mmEyISNIr8mdw+wsUYUT9w1QfpjGTCZmYi1Az6HyxymWlP2niAtNOZuP0Jagokzm2WTZCqXQojW37I8bbdzD76Q8LY6Ey/DSeD/wjXHVmLk/B/VVCbsfk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:31:46.5358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1732e61-24f7-405a-6305-08dec2dce194
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9481
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.81 / 15.00];
	BAYES_HAM(-2.81)[99.17%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.36:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.72.36:from];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E3BB444441
X-Spamd-Bar: -----
Message-ID-Hash: U7XIRUNPH6GOZMKDGPB54DT5L5NO6DDX
X-Message-ID-Hash: U7XIRUNPH6GOZMKDGPB54DT5L5NO6DDX
X-MailFrom: Sandrine.Afsa@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VIE5PRXX3KUBHI7WKW7QDCBBYN66MDSE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi everyone,

I am sending this email to all tf.org project mailing lists to ensure all m=
aintainers are aware and on board regarding this matter. If you have any co=
ncerns or questions, please reply on tf.org Discord #general channel, where=
 I'll create a thread, as I think it will be much easier than dealing with =
cross-mailing lists emails.

Background

When a security vulnerability is discovered in one of the trustedfirmware.o=
rg projects, it is common to request a "Common Vulnerabilities and Exposure=
s" (CVE) number. This number uniquely references the issue, which can then =
be searched in the vulnerability databases. One of these databases is NIST'=
s "National Vulnerability Database" (NVD): https://nvd.nist.gov<https://nvd=
.nist.gov/vuln/detail/CVE-2023-51712>

Entering a specific CVE number in NVD search engine will allow you to easil=
y find the details of a specific issue, for example:
https://nvd.nist.gov/vuln/detail/CVE-2023-51712

However, sometimes one is not looking for a specific CVE number but rather =
wants to list all known vulnerabilities affecting a particular project. For=
 this, one can use the Common Platform Enumerations (CPE) search engine:
https://nvd.nist.gov/products/cpe/search

CPE is a structured naming scheme that includes information like the vendor=
 name, the project name, the version / tag, and so on.
See https://nvd.nist.gov/products/cpe for more details.

So for example, https://nvd.nist.gov/vuln/detail/CVE-2023-51712 referenced =
above has the following CPE:
cpe:2.3:o:arm:trusted_firmware-m:*:*:*:*:*:*:*:*

This basically means

  *
CPE version 2.3 is in use
  *
'o is the type of project, in this case it stands for Operating Systems (wh=
ich is probably the closest match for low-level code like TF-M)
  *
'arm' is the vendor (that is wrong, see below)
  *
'trusted_firmware-m' is the project name,

Problem statement

It appears that CPEs used in NVD to reference vulnerabilities in tf.org pro=
jects differ a lot across projects. For some projects, there's even multipl=
e of them. Sometimes the vendor is "arm", sometimes it's "linaro", or somet=
hing else.

Some of the TF-A and MbedTLS maintainers have initiated discussions with NV=
D to get this simplified and unified, but it would make sense to align othe=
r tf.org projects as well.

Proposal

CPE naming rules are that the vendor name should the parent organization of=
 the project. Thus the proposal would be for all tf.org projects to use "tr=
ustedfirmware" as the vendor name in their CPE.

For example:
cpe:2.3:o:trustedfirmware:trusted_firmware-m:*:*:*:*:*:*:*:*
cpe:2.3:a:trustedfirmware:mbed_tls:*:*:*:*:*:*:*:*

We're only proposing to change the vendor name here ; each project is then =
free to choose how they want the project name or the type of software proje=
ct they want to encode there.

Thanks for reading,
Best regards,
Sandrine Afsa
