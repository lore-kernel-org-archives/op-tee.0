Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D31C71136
	for <op-tee@archiver.kernel.org>; Thu, 12 Jun 2025 10:14:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A660743091
	for <op-tee@archiver.kernel.org>; Thu, 12 Jun 2025 10:14:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NdUO5VEz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NdUO5VEz;
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 96E3540B62
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Jun 2025 10:13:39 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CSDMcZSbon1cLKAwLZJpuXcJCe1X+528wRoVqNBE57NHaMYClrU0xrqi1/zqZSiumlbHBudmSKk+Y4peHNbtwplIbs3K4v4upkzbNAhjy4bkAiPFLX0qAm6TvnrYkEcYyoCaBba8MunK36sV5WJDGR1brHIyac3iC6qcYZPRovWv49hfUAP+uAw3sNyvMcLedOhcCPemK6yHge3Vu3uqTK7G3LhHdagxXgbSrb3CAKv3aQbb7mHTuo2s6S6JiTh/dhSQ6ymIi8Mjzz3Aiqwz8WC/siLH6fATAKyPNnlwFRFg1aYu3R4oK6s30/Piyk0qmQM3z1VDGhYTBOjtmAUSWg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHqpcO1Q+8Jh4lBnuIXUF4CReVx4dLhljbZSC68Fw7k=;
 b=a/rMr44e2oDN/Dkb9IWRqeBKp8V2uak9CB6yJm2e4nxa0KzAn2yxS0AFgm990xKCOkXAjY+6x3ZD2MYHBcH7AJ1b5KTjp79Izt9m3HOe/KPGDdv8gW7tw86BTkGpWaJDngZ112/0Ufp7iflXj7U/TE/OoqxwmDT2tir1mhmAGm2icvtEtfEV/GTiOnKbNRILZDTs7LhZLONBuc4MnG0AY1XxFGo3olKEZ3gLzzEEztgb3wkJvIOXUDe53RE4EN6dTB1jDALIu/8DhXy/OnA9ugLLkvCxMitluCjqD7Dh86hjAFWdW/YvyjkYIj545Go+yw61MCRkfsMVan2+n3AZ0w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHqpcO1Q+8Jh4lBnuIXUF4CReVx4dLhljbZSC68Fw7k=;
 b=NdUO5VEzWflqmGy552XbwwQVFj1xE26b0JEP8+34BD4zaMBAwvrwc89dIEfZX7cBlApdA40bWWe/VEkMqVabAqrDXLE7GDddoRa8H44SoQYhczWit8Ua6wAzYiLrqcvEjn0p9mHQWVulALTPFPtIv72BKGvYzFLP8+hzhRUPr4Y=
Received: from DU2PR04CA0226.eurprd04.prod.outlook.com (2603:10a6:10:2b1::21)
 by VI0PR08MB10991.eurprd08.prod.outlook.com (2603:10a6:800:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Thu, 12 Jun
 2025 10:13:34 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::72) by DU2PR04CA0226.outlook.office365.com
 (2603:10a6:10:2b1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Thu,
 12 Jun 2025 10:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15 via
 Frontend Transport; Thu, 12 Jun 2025 10:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFlw1DyGpD0NYCO91UWJhhz2ZqoQz7+J5gdAElKFVmeU1DghOE0Ex2GJNFbaxzeFJxJBRA/AvyfK0A79PeiLqIDuj+NOeGTsTpbML8EO8LWyBryAB589Z4kHKsScpY5mc/eZsCdJ7UPq59og8PBzMVxk+dubynweVNcywQ8Gsrr+7fGr0Kr2wshamFbxvTnsfmaCyHPg3sgW7R0+t+zcV8QQjcrp58u75OrySJmb+yB7uUl1DNM8ZETangTZGRJyBh5Q94WrocN82QLRvAxOFRpDaMdnLmQ5guPt0XLot9PSmcrW/bPsn/GjDNZ7zzKCOmGmMEzXPvjEv4a9S/MucQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHqpcO1Q+8Jh4lBnuIXUF4CReVx4dLhljbZSC68Fw7k=;
 b=LxijA6wP4KhGeTPBCiie4lQDsKgPvhykInv04gj0d/4/1QZqnSv5utwBWPR0EKcKHm8UTeVVRvO5q5u2xvIpJ51knfEWn1bQJizkByvNBY4f7UcRdH43pC2EAOiqQNuuKB+rSB0I+9YssyRrKq/6noT1FhMm5qSqPLN7lwgzYrRaCqMvFpOAcREhPsulcfKvNccZQZrfeuwuNEM0TYI3WiJ48vQbTGI9SzoACkHyUlhOTgPYTc/xq3XuBmB9/ScMu6qi5DOxijak4GlTYOFKvs1ltSeT7LU8SVOzyIF3Ri+IYjjGShl2Jqs5x21EvMePH8d50yWk8jZ6h3rmWIPF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHqpcO1Q+8Jh4lBnuIXUF4CReVx4dLhljbZSC68Fw7k=;
 b=NdUO5VEzWflqmGy552XbwwQVFj1xE26b0JEP8+34BD4zaMBAwvrwc89dIEfZX7cBlApdA40bWWe/VEkMqVabAqrDXLE7GDddoRa8H44SoQYhczWit8Ua6wAzYiLrqcvEjn0p9mHQWVulALTPFPtIv72BKGvYzFLP8+hzhRUPr4Y=
Received: from VI1PR08MB10217.eurprd08.prod.outlook.com (2603:10a6:800:1bc::9)
 by AS8PR08MB9430.eurprd08.prod.outlook.com (2603:10a6:20b:5ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 10:13:00 +0000
Received: from VI1PR08MB10217.eurprd08.prod.outlook.com
 ([fe80::fc12:614:8138:64ca]) by VI1PR08MB10217.eurprd08.prod.outlook.com
 ([fe80::fc12:614:8138:64ca%2]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 10:13:00 +0000
From: Manish Pandey2 <Manish.Pandey2@arm.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: Firmware Handoff for DT Overlay created by OP-TEE?
Thread-Topic: Firmware Handoff for DT Overlay created by OP-TEE?
Thread-Index: AQHb2vwC9bCJB3BWBEiCB2zqbQSWPbP/RKM+
Date: Thu, 12 Jun 2025 10:13:00 +0000
Message-ID: 
 <VI1PR08MB1021788AAFA0E6A859BA3C18CC074A@VI1PR08MB10217.eurprd08.prod.outlook.com>
References: <89ad64f2-fbda-48a3-9a27-5eaff5be9292@pengutronix.de>
In-Reply-To: <89ad64f2-fbda-48a3-9a27-5eaff5be9292@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	VI1PR08MB10217:EE_|AS8PR08MB9430:EE_|DU6PEPF00009523:EE_|VI0PR08MB10991:EE_
X-MS-Office365-Filtering-Correlation-Id: b40d10b9-c81f-41f0-d53b-08dda999c9af
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|13003099007|8096899003|7053199007;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?LiLRmaqa76+fERJPZEQr0sDF8bpHHN3VWHKTyO159Xvch5CV8redPa2YlPe0?=
 =?us-ascii?Q?j/kGnL2P4xzvYl798qn+sy31jOthrWYAcL3/bMKCFvkfnh4VX1lstgJxsrsa?=
 =?us-ascii?Q?K4n8wDWpoMOTyKRQkPQ2kJcxRJS9f3CXa18gMR0wNROM7eNnlUf7U8pzM3ms?=
 =?us-ascii?Q?B1uIKFA5YykieafRJ7SVwS0lOLjJDk/vHEqTDPFOSKcTjnGABPMMHui4GOmb?=
 =?us-ascii?Q?J6yDG5Flwl9DsoPoXvy4SrNZdieVpYR6DaZJhDzSeUcKe45yQKdy5qC5ykLT?=
 =?us-ascii?Q?iCIL063IDuBkFrOQxESROgAXnvAY4BDppzvZmogteWlMBUr7SBjVJ9D5CDRD?=
 =?us-ascii?Q?j8H3qcsVdRCh+e8PNHZPxXlQKM0dcuNK6fJoO6+LJDzagQknsmdMWTyayLCC?=
 =?us-ascii?Q?3HP1jqCUjwewpVBsBWgVW3cdlZCwv39R4JSyqUYRYQJ6YbzlUY7xqWj3iZdE?=
 =?us-ascii?Q?luMGqfVSxBu7sqeR+UhbjttMGiVi1+OTIBo30K/RvmiRQ8WSfqRlNDBQ2k/+?=
 =?us-ascii?Q?HNBrJLhGuxly6Vy4Orf/mHbr2CdFUf1b+1ja2KWGuvfvTQ5icWCpZSokvNWI?=
 =?us-ascii?Q?Ra4IAP9iiWCR2hQ6jGs9z95cUSyJJ6LctZm1LGPGcCzY3Ljd4z+pZ0eMrUQ6?=
 =?us-ascii?Q?bePfSQTxSTZAO569MLsuVFHRRcbgKPP8e2kGimXVOHg/c6v8Uw8zypCIMlOD?=
 =?us-ascii?Q?CU81fLLX+uMQARR5wa6lxDFE4EETSCvh1YZ3StjQP9Ph+3eTkrzrloRXJ0je?=
 =?us-ascii?Q?tCk9r7nhz56GQsHGGBmfkgH7RBMdP1RTh601lOEp1h9RlLLhIlx5czpxZWxU?=
 =?us-ascii?Q?bSofd8XZaV5yh1ChEzosc5J0ud2L0V8/Rnod0Z9Zd5ksS+Ayj/ClRs3gSoUl?=
 =?us-ascii?Q?0iyrFDSatNDNeG2BsJjfDdL05NmG9/yW72hSGvfKnKGuED/HDSicyeESE1ls?=
 =?us-ascii?Q?Dx8KRF7lUrvvV+l2oJ2pkB3YZhhJOr49zUvlVQxP7hw7hgUx/YOVFqleR1qz?=
 =?us-ascii?Q?7ljU3FINlglBhiGRJYTlopgudg9A8NyVWqof1fkFZ7rD1DZlCIWrZHd7nVE2?=
 =?us-ascii?Q?w3clRgpWQNmk1xc8hZTJ1Jgr7VLfQBzgkAMIu87RCHFvQvEyXthGDqXLQLdi?=
 =?us-ascii?Q?6yGmvnbd50fKzeGRvw4uBwAeMgGztRGAOrNY6HctzcCUqa9Vq6ZQQw3MfS4H?=
 =?us-ascii?Q?UjMJow2j+FMowcss7yEz+EmSi8A345BeR8eiDHeZbzw/R25TpfVc4nUqRGcz?=
 =?us-ascii?Q?IJZvYkd5zJZ/PHlGBntbW5/63oqZWEGFrL9yFgFnTbV8fN94KFkez4G/3Zkq?=
 =?us-ascii?Q?WfFNoM6dvEHRQjUs7OitlO7oTvU9DB7stQHqWo+93F4+m81lluskGAgkA8Sh?=
 =?us-ascii?Q?3NryXdvy+gzIUNBW9tloV41vdYckO2I0nA0i45fJUvFuClwLYUbWzS90skPv?=
 =?us-ascii?Q?ZIA9FACensI=3D?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB10217.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(13003099007)(8096899003)(7053199007);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9430
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	50b323fb-9004-4547-4c25-08dda999b609
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|14060799003|82310400026|376014|35042699022|13003099007|7053199007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?iso-8859-1?Q?rCAum7cfjt96RkfK36amKzYJ8OPRrOqUvVB8OVR9GmtxQ+CuLX5+1Ld8qh?=
 =?iso-8859-1?Q?OGac8s8EqbD5laKz9KHrLhyWCyxnVHv87+m/DbZ7Bf28R6Dozt8kADEXP3?=
 =?iso-8859-1?Q?Tnsz8/RCoR5URKGYg+A42Grmq03xrAYfzhiwTRgz9G2NK6K0367prOf0CR?=
 =?iso-8859-1?Q?OJxf60u0rrgrKXRUSqcPkBpIApVlg10r31NPGWb1OejDqSYxizRMsYC08n?=
 =?iso-8859-1?Q?f6NSj6a6pKt8tHNQiwfcs3T+DaQ4YvjZ4AOU4xUSRzfU1xu1Syt6aGJq/D?=
 =?iso-8859-1?Q?lHeloEOU6trmx3UexwkZcfx7Zo5vHVbsv76zA0itnJ9ALJ4BTWyyVqn8uj?=
 =?iso-8859-1?Q?+711uHWEWfVearbCuiWt+bCL013ZTDYr+dBWiri6TYkKGVPsjHtCY7yPsZ?=
 =?iso-8859-1?Q?AlU0kOw3ARqyvszrbrRW6xrY2RPqW3RRAE4YMYbuUdBXAmlaD7xvelUU1y?=
 =?iso-8859-1?Q?3FLu4UJMTTNttM5qkbR3zvRPDU0iCCVyUfkHKIUr9YDQUI+FkeSC3g/dIz?=
 =?iso-8859-1?Q?Qe8R9DaQmRBl0JN8vy9lUerfQev2nSeon8u341e1zEcjulT74+TJIb/wNb?=
 =?iso-8859-1?Q?92n0HFY/5F5EcUrTxtqHFsYd94bmkJqFe0CiUGeUWc8s0gczyYxv59ZTiy?=
 =?iso-8859-1?Q?oyR7hTG6cppoDo2BrcBYP50GN5JUNivjOupSpN2HdAUcXE0D4rqb5t5jGL?=
 =?iso-8859-1?Q?AaW6bPm7XLZLBNHk6x3NKpz642qMNkrvGQdFgvf3waKB4zA1GSGfF/tVag?=
 =?iso-8859-1?Q?dsWxJFR56rnpPjO3smStQvvpIgihKejdlq1PLivuSak9A01ALzjFVh147N?=
 =?iso-8859-1?Q?h1YBqECHrRXvRmybU2CHDjbXqx854jxw/VVMs6+N/epXg40nZhC8snMDgh?=
 =?iso-8859-1?Q?L2BFx0jEFxdwqG8/Gv6gxdcRkWDLdos/Ec8ex4zDawEGzWHiqeJ2p7sdaW?=
 =?iso-8859-1?Q?GMv+TGGMpnYWGmq721HBDr67Qe5ncCZmzcmqh7spDN3DA9wtgkQwXWK8sz?=
 =?iso-8859-1?Q?yVA2rooRMbxNYVt1Ufyp2yycl9mX9Fhy8PPxUdhFws40RFUk5bwqYw8EVP?=
 =?iso-8859-1?Q?+oBCi+Bgaa0S7IJaYr84tK+5VFhydsSqYfSdXoEip+JrirLaOfKdbqiqJG?=
 =?iso-8859-1?Q?l6MqhcfPMy93pUzaO6s2I67wVmk23rH942Vkjn8cv3aDmXqbRNgxugzyu8?=
 =?iso-8859-1?Q?HS+IZmEx4KjbDcALVS9YGZZbxHgytSlSLK4GpKqsIvgLMioJ9wkFhgR08Y?=
 =?iso-8859-1?Q?Y/pCUWrnBwMbWhVt5wlGtcw7CsxA/jueDDowkVsyrQUPFBV8GiwdjKnPvf?=
 =?iso-8859-1?Q?EiEMtA43oMI9MCyWCzumIyeSrb13W8z0Jk50RXFpE2Fajc7b7whzmGn08S?=
 =?iso-8859-1?Q?XqFiCqXqsPaT3ZF73oSd8JBSsVJ79jcnUXhnSbK8ZU4vqzYL9Cz0LLzwlk?=
 =?iso-8859-1?Q?cEJPxVEcZwSjpim3ECAppb0x6di4lfdYeV6B8M0uoV3DGykYM0rcM49oUM?=
 =?iso-8859-1?Q?p9QcEqcwyzO75YdJTvdPyMMJyW9h63OUiwzekLdrPQMQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(14060799003)(82310400026)(376014)(35042699022)(13003099007)(7053199007)(8096899003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 10:13:33.4231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40d10b9-c81f-41f0-d53b-08dda999c9af
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10991
X-Spamd-Bar: --------
X-Spamd-Result: default: False [-9.00 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.98%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.66.0:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.66.0:from];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 96E3540B62
Message-ID-Hash: P2BDTWOYZHHHVFQFGE5S4VYFP5XAYBJE
X-Message-ID-Hash: P2BDTWOYZHHHVFQFGE5S4VYFP5XAYBJE
X-MailFrom: Manish.Pandey2@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, BAREBOX <barebox@lists.infradead.org>, "rouven.czerwinski@linaro.org" <rouven.czerwinski@linaro.org>, Michael Tretter <m.tretter@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Raymond Mao <raymond.mao@linaro.org>, Dan Handley <Dan.Handley@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jose Marinho <Jose.Marinho@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q5SADJP7MQPZV3774M4622APUYQ7YCCB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Thanks Ahmad for reaching out!

There is a PR [1] on the Firmware Handoff specification that is still under=
 discussion. Could you take a look and see if it could accommodate your use=
 case?

To confirm my understanding, would the desired flow be something like:

  1.
BL31 passes a read-only DT to OP-TEE via the Transfer List (TL)
  2.
OP-TEE consumes the DT, adds memory reservations via a DTO, and appends thi=
s DTO to the TL
  3.
BL31 then forwards the updated TL to BL33

Does that match what you had in mind?

[1]: https://github.com/FirmwareHandoff/firmware_handoff/pull/74

________________________________
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Sent: 11 June 2025 19:09
To: Manish Pandey2 <Manish.Pandey2@arm.com>
Cc: op-tee@lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>; BA=
REBOX <barebox@lists.infradead.org>; rouven.czerwinski@linaro.org <rouven.c=
zerwinski@linaro.org>; Michael Tretter <m.tretter@pengutronix.de>; kernel@p=
engutronix.de <kernel@pengutronix.de>
Subject: Firmware Handoff for DT Overlay created by OP-TEE?

Hello Manish,

In your recent talk[1] at LinaroConnect about the Firmware Handoff
specification, you were asking about what other use cases it could
address for OP-TEE.

We ran into a possible use case that we would like to share:

BL2 can pass a DT to OP-TEE, which it would use to discover memory and
to fix up with memory reservations covering the memory it carves out for
itself.

OP-TEE also supports passing along the reservations as a device tree
overlay. AFAICS, there is no way currently to have both: A DT for OP-TEE
to probe hardware from and a way to pass the normal world a device tree
overlay in return.

I think this could be neatly addressed with Firmware Handoff and would
be a motivation for us to implement support in barebox BL2/BL33 to take
advantage of this. The current way is suboptimal as we would prefer the
DT passed to OP-TEE to be read-only. This avoids either having to copy
it or to pad it sufficiently in anticipation of it growing with the
addition of the new nodes.

[1]: https://www.youtube.com/watch?v=3DRxU798h8aiE

Cheers,
Ahmad

--
Pengutronix e.K.                  |                             |
Steuerwalder Str. 21              | http://www.pengutronix.de/  |
31137 Hildesheim, Germany         | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686  | Fax:   +49-5121-206917-5555 |

