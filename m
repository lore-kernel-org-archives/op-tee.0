Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC105E81BD3
	for <op-tee@archiver.kernel.org>; Mon,  9 Feb 2026 14:58:49 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 16C384372F
	for <op-tee@archiver.kernel.org>; Mon,  9 Feb 2026 14:58:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=e8n3QSMS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=e8n3QSMS;
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A6B4A431F6
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Feb 2026 14:58:29 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DyqJeIeVoWpTeGqeKpt8lHBgCyvP3GsEoXkO9xnywLPJeO7z9DA9dSiXog+Mp8D/0rBaSfzft6b/XOfyDs29C+t/6uWslrfBy9OewbJVg+IYEQCZ7V6ZJeqybkaiBINP+3EhS9Afu2X8z7/zjRH6OG3GNsTFRx/kgzjr3nxECi8XL474tM4462L0SUkB1T8b1kRdex9nYSXzWBwQVQD3AnOoNCcoD3z7oLx+2RDQR3TbN+wgiwfqKYYayQaHu1MZz638hpTL2ZxiJvPi1SFRF8i4YDVfmfjRGMANZ58HiZGfLQKoJRHYRvr0OLoYCodzQgiMq/u/wrSgeuIuXmEW5w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p62NWxaP15ArTAVxuwBNEOlhSx0kh4+T5bSgy5YJ0sA=;
 b=Sb6Wu9HAukGplW7WOisuZV8fXDHDdIcBYDgzAYnUWyo71A58CWgFNSweU92kxna1Jd3v6GJ3rBgAx0HmqLx5h3U801ta2S0CHKOiffvPTFV7ABWPiv7UDHQe1vr4PGKrEJjGd9cZYv5csozdbfJMdogodPVJkGAPj4e43sEj6msYNS9IjbSHyNfO5bKPFyMB+AoFYAbRfxB3xQ3mJjaJVBRU+MyoyjacuhkjRPqUNRsWJ9w/3KsE4lG+0SYiq7CJNnIkaNYvUCLMVcdpU7/0v+vjR69w1cvD1iA4YVlNZ7sR6CnUgjL5Sbguz7/8STTmDnCyd297ohy32AkYNvOsNw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p62NWxaP15ArTAVxuwBNEOlhSx0kh4+T5bSgy5YJ0sA=;
 b=e8n3QSMSQbyD7jwLE/AeigfUAafQUDChe67y16XU16oQdXTvUYQEwh0BH3QpuBRlDByjiAhwdwQFMzvdJBT70xv5h+eFLh/JdIZRPPzYYXyvQFyOuAhp4IFec7c2DOCF8128CLP1J7nWSlDAE5wPnYgi7gLbc0+UJHyJD4+hfLk=
Received: from AM0PR02CA0159.eurprd02.prod.outlook.com (2603:10a6:20b:28d::26)
 by DB4PR08MB9381.eurprd08.prod.outlook.com (2603:10a6:10:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 14:58:21 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::9b) by AM0PR02CA0159.outlook.office365.com
 (2603:10a6:20b:28d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 14:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.10
 via Frontend Transport; Mon, 9 Feb 2026 14:58:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJT0lFKdzgqxuYb5qb0QRCDCWAyCkuWdJJFz4PC5T1b32aWhb20x7cYXnvgqFpLi2FOCcEkRz27Gx0VzTOsPeC4WuQVNllnbnxqI28XFntMsUOiAxLeSt3B/fklXwlMaIFkH7b0Zz/4WFpGPJmHvOyoIZZRj591xzjvzyAfSgDOLKCzoPYp5VgfNBm1ylkqs5z5VRIAUyVecTAUvJArEw+ZjN2Vl2JqnzeErloBBkA14X3CCt4kXmMPNdqopYXcP+GXNWsQm2TKBmWyst+EDDv2j8fbocIR6RrjfNdLuI1xTKI8xIxZsfMGpgfgYHgg/Z5ygkMp+PraOmGjgiqkqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p62NWxaP15ArTAVxuwBNEOlhSx0kh4+T5bSgy5YJ0sA=;
 b=ohyThBqJZ37lzj8/f/hKuIose2tvx/2AK7XaNKiGWqd4M6JYFd8/zpwVuYeXVEkjXUlFl/tIpz++oSaJk7q/bHXgIRH8erE6kojnILOvO9pAGwB4giw22z+Y+2beIaHuGgMbbj/JKCgqw5HyS0tjYt4ik2iMciO2X+5CenOlyuv8+u1rur+JAEDlBLca5Ji6AgC8yiFAeTITY5C4MOiAHVZzq4tA5Fxn1ATA/GsaJ1EmyWMiKjgWrUPXnvyNKGLOmZZ0FTaHLfuqa1yV3f3wuqobVVqjeDLhE8loJKnO+9jzHQse/OvS8G2hZMNl6/eVH1Hy8rgx9tukho6toR55JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p62NWxaP15ArTAVxuwBNEOlhSx0kh4+T5bSgy5YJ0sA=;
 b=e8n3QSMSQbyD7jwLE/AeigfUAafQUDChe67y16XU16oQdXTvUYQEwh0BH3QpuBRlDByjiAhwdwQFMzvdJBT70xv5h+eFLh/JdIZRPPzYYXyvQFyOuAhp4IFec7c2DOCF8128CLP1J7nWSlDAE5wPnYgi7gLbc0+UJHyJD4+hfLk=
Received: from GV2PR08MB7955.eurprd08.prod.outlook.com (2603:10a6:150:7f::21)
 by AS8PR08MB9815.eurprd08.prod.outlook.com (2603:10a6:20b:614::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 14:57:18 +0000
Received: from GV2PR08MB7955.eurprd08.prod.outlook.com
 ([fe80::1c8d:72b6:159c:3ff7]) by GV2PR08MB7955.eurprd08.prod.outlook.com
 ([fe80::1c8d:72b6:159c:3ff7%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 14:57:17 +0000
From: Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Jens Wiklander
	<jens.wiklander@linaro.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "op-tee@lists.trustedfirmware.org"
	<op-tee@lists.trustedfirmware.org>
Subject: Re: OP-TEE: memory corruption in
 scmi_pin_control_list_associations_handler()
Thread-Topic: OP-TEE: memory corruption in
 scmi_pin_control_list_associations_handler()
Thread-Index: AQHckds8uQFd49LX4k21qkZC896iU7V6gFmX
Date: Mon, 9 Feb 2026 14:57:17 +0000
Message-ID: 
 <GV2PR08MB79551A173F9B2762E6860FD5EB65A@GV2PR08MB7955.eurprd08.prod.outlook.com>
References: <aXyVSfxbrff_GX8A@stanley.mountain>
In-Reply-To: <aXyVSfxbrff_GX8A@stanley.mountain>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	GV2PR08MB7955:EE_|AS8PR08MB9815:EE_|AM4PEPF00027A66:EE_|DB4PR08MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: 5534f833-3b1c-45cd-dabe-08de67ebaa99
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|8096899003|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info-Original: 
 =?us-ascii?Q?GALzuiPCCmAGdha2/R43sUwSOItOLDA0WWMJsaY4zXnDScR8MDL7uxdvODwY?=
 =?us-ascii?Q?4cpE4TQBnHRmmykDaZS+53VOVWPFBV3pXzeRF2ajCqaU9EB1JCuSeheTW6ZE?=
 =?us-ascii?Q?13Lv6AZlT9AswVBBEGIw0g1mt9BZErf4rDFJE0ukeuqBlCMF/14jeQgH8nS+?=
 =?us-ascii?Q?N/A40FWBFweV6twwzLWnj5JUAAi9CgIe4SrqVdyYydsq0l/XGOtTh9nuYTVs?=
 =?us-ascii?Q?jaXSjjrgz3xIR4NShMzA0p2mNr+K4pIvbs+gD+5fPQofPbl/Ieq/V4xv9rEI?=
 =?us-ascii?Q?l/YRYhtqwOOmBrqh3aO6iqVuJ/9qyw0liNwSP2oYiE3sdSDdYaZv2dBeKT2E?=
 =?us-ascii?Q?6WdqYMMeIxX0yl4n13a/k5pt2tsSAjpJ0FDiX6a4/PY6wV1ano6NMaKlDwrM?=
 =?us-ascii?Q?q0ILjp8itGKLx22lSGAdrdIm3QdYHXPjAlW6CElv2xSL9XgKOCgpEv6X2TlE?=
 =?us-ascii?Q?AmJPop3UgTcThWIAEPRINrTGWZqQtkTMqJ635PAfbjsVxHzijX7gefdpYpN7?=
 =?us-ascii?Q?6Qhyn65xIc3uhkUAQviiZ8e2R03QgmllU0EmQNdvFAYy0oKw6qQlh78KDh+4?=
 =?us-ascii?Q?30rLJ57rR1Dk7ZkUrLzi2kUxZBeN36ZNrUfhvnD9b6l/YE0HUCkhk6UFtFU3?=
 =?us-ascii?Q?2pgkeQo0OOYPbs7xXrpA+MowuaH6j626WxzMsTVClXFUWvS4K5p4+XF47rIJ?=
 =?us-ascii?Q?DpCpho0y9Shf/bpOvRiommVVSuBfz4tWzjtnyMIWP01ZMU2IdlTWfcZfhRaQ?=
 =?us-ascii?Q?u7AILJ1Tn7Zl0YQCTKBQdCmiggyLiYUiiPGCBj9UZ/Y6Fa1Tt+m4i19FUAHy?=
 =?us-ascii?Q?WOUfkh835h0NTVh+iwyBSGBYfzFim5VfGDcy1xAisegPovj1Lq9pXh18b+wr?=
 =?us-ascii?Q?J4+qnt1CITTxp8WlDCpawQ0OBI7fu5Ffh9nDEjzy9JwrL+6Fw1nlo06WXxAY?=
 =?us-ascii?Q?GQgbKGYpv9RszVsvtQMRUh+RJIvXZtnWB9YsAgXtqF1Q7dESr1U90cuiNAOi?=
 =?us-ascii?Q?wOOwZBs/5wrCCaZPjSRHLDmXx4yu+8iWxJ221Z4eboVlz2NGa0e0J+sJkJ4M?=
 =?us-ascii?Q?VBq5PKdAQT7jGDQjGPRTU9dy4BDDazUy7CMxwg++TlE6WN8wRQCykC0Ct0GK?=
 =?us-ascii?Q?teHEU1qy3m3zkWnx+gg72geUmzBiup9Xa1VsDOGXc7BoHoHkVQH132z0ekeU?=
 =?us-ascii?Q?qxqqf0rsF3FlKa65/oH6ONn6CeKdfgJRRPk1lfo0NtbngGwGkJckWVk5TZR1?=
 =?us-ascii?Q?YokxTE+g1+E31tPsY/awy7fqC5KHudsrw0IOHHVWvs2nYzyVE7Z13F3crWHc?=
 =?us-ascii?Q?Hq8+4ZMfFYceojg9zMRp+dH0uiG7xNzgyi25mj6MD/ejDnqob0803oojBp53?=
 =?us-ascii?Q?v89T5E3ID4yoOiZ8+MhMc3+QOqFJ8PD3tFAqXt4jJM4akzMFdASNDR/jRXdd?=
 =?us-ascii?Q?yle1J8sSYu3AN/j9eDmpODrpBo12Sn55AC1mFPPiT1YE/U1C4k7/F8ot3QIM?=
 =?us-ascii?Q?39gv4ETTqP7pgxXTaP77tnG9RQP9Xcx56tihvJXKqutgzV+b+9dcFN+ygJKn?=
 =?us-ascii?Q?wmLwOTtry240z1EuTrRM/OjCD2m6W2X4zqP+mx4C?=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB7955.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(8096899003)(13003099007)(7053199007);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9815
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	a5584d5c-c256-403c-cf59-08de67eb84c9
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|14060799003|36860700013|35042699022|82310400026|376014|13003099007|7053199007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZIXA1TVsYDN0ONX42Bs8SnU2xZF/3ijxhX30rFO1BlHIWmBkc6rM8+kKR56q?=
 =?us-ascii?Q?aEmNIgQdaOZ4F5zc7aMQ2PEKI7xjnku/MmElTnr1otNP0qHASV4qufckEDDS?=
 =?us-ascii?Q?zX0WUdKpEIZrXGc1AxzoTaUnwBG8iF0uVGMMqKw+cLdhvuokW2XPO3+oScPG?=
 =?us-ascii?Q?48x82Tumi+SAi2jS0MePdBbGPPCZYA+bys6772UL3xlrZTuNQOwKyOkJLR7U?=
 =?us-ascii?Q?XomBPew1k4brhzJv1KcTJZX0dTV1xVnCHMzkglvn/jsiz8kmBtbvwff6Xp2y?=
 =?us-ascii?Q?IY6iHIuNMpdpjSm71glgd0lJrykVJb6DtG3Baf7YB4aGms3YM5Erw4sZ0X2H?=
 =?us-ascii?Q?6byMbdDeqdJtC73bET2ZEA9i5W1Wz62pwP5tG5p6WxFoTtTIl0rV9GsDozc5?=
 =?us-ascii?Q?IwcqeHqA1oV+PyDmkIMnZg9vccEICzsU7M9nHo9a1B/vbnyjPkZzbHGRCwYS?=
 =?us-ascii?Q?sYX9RKfd5t4Y44glkD7gIlSWKBbyMOV+O8OcV0nJoPl9Anj2imTQA0ktxq6r?=
 =?us-ascii?Q?5zmSxfdt/tUWJS3Y797nVKcvkVkCjkr4UAMZHaP/8t/AWvn2LF6OoZzWlqNi?=
 =?us-ascii?Q?yy5YgMSZaY73Od02l9P+RY9sMp3rJgNZblTLmbT4aJR1zSKIxhWwM6IksExn?=
 =?us-ascii?Q?PrZnsJtTjXPaEiB3eGlSOj4nF3kPeceZsL5ecfP5A5CO8N/9JUW37fbgakUg?=
 =?us-ascii?Q?9+aYqtVezhWCs+sQfCH6eDioVAfSvggw4L0fadQ7A4C7GajDrk/I5im3jqS4?=
 =?us-ascii?Q?Jke6wlxfIiiMLzXvUR2mALN42Vws6vEWDA1Jw2JIbkK5rw6NBS2qPIdCJezB?=
 =?us-ascii?Q?HeDZgnYskn689E+hiP5d2jyDqcLA6ib6MeYB8tUOefSZVLPI1KsTC5LzhRuF?=
 =?us-ascii?Q?BWJRd/Rznw0dKDIzqRXE52URchdhzN8eMB6cYwfn2aoR4Yywi3Gd4obiuthQ?=
 =?us-ascii?Q?ArPtUjHPH2TdA7JLHUmSMLzYvcdEe6uJ9LlLXehsQZaB/XEagC/CZPEec7AH?=
 =?us-ascii?Q?JzmFZuAk/Msh+rRxujnyptugkFlTKmawlaHmQNX47L7qjsvU0Eua4ubqMdgh?=
 =?us-ascii?Q?72wnkj4sSk0HflPNtBndccZ9gNcmkOkSwCNR2hWlLYcd9+8KCnuCjMz0KMyP?=
 =?us-ascii?Q?wZO+l2EbaYUiA4v12NvFt5eVrbBVHMQD02ANzbcRcKQCp4fA57jyYyPmsnDQ?=
 =?us-ascii?Q?ObdoOlEWafdc22XQvTDAikeDFE5Z8p3ot6dwxcpkdDLk4E8clCTeeO3PZb1A?=
 =?us-ascii?Q?xCLXEXRAceZRBTIOcmz70V4BnK85UKmcECAUWEXrKxMDrBiJfiYGgIpgOfDy?=
 =?us-ascii?Q?7bdYbwhbhA/7yjWsJr56nph+4osHgezawVOpwsvO2iuSzZnBwOvin0hMDxaX?=
 =?us-ascii?Q?jOzmJPjcGIR5qMxiYsMPlKopanarkiqdX0BTvgpfdZ6e1m8yTXc7ofMJwBbG?=
 =?us-ascii?Q?hw8EUkmQxgYVUyoZBOQuNmjpeV9g0jDcgcaHAalFsf1r2tMaGPVnN3IDdp0I?=
 =?us-ascii?Q?S/Uo3H3B2SAu7vWpGWrfq/j+PO8HiMmklSLIV51dCm7Mo7dn+h5TM22m6wU8?=
 =?us-ascii?Q?bsi9GwmslLsR6SiBo4ovVbvU/W0GRhGEV9KfkBdklcY95AUHcpX007ASbme9?=
 =?us-ascii?Q?wD8EB/sIRnWu3PYXjRKXaZI=3D?=
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700013)(35042699022)(82310400026)(376014)(13003099007)(7053199007)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	3YGJqZtpMwBruNZT7URV2MuFX/VgRjY9efiQpATUBbosZnNuqIEpdurZ/wFxP/e4cL7ku9Dc0xQiFs4D2H4GHjz7xQPX18dXAzHbeiOXUHLoLof/gC4Sw8hwN97/f4KCqDlLxYG/GmJQvZAaCjSIbuctii+94mtbrXjgt0eSQWyzUYBrbIrInNyP5GDfsGo7D/z7/bUiMyYt8QA2PuP4VU+J5Gw1EFqc/nB+YnOvdfzhoxcngLLFWFhthv7P4mEiCUb60P0PWLOBI8KPFcv9OrPv5s7EVmqYFOn8I5FVAPYOKZ6HIEsryu0nWCd0OnuUSC0A2nHFYj5dtTBT1JGmbdZYsWoVrBbl2YfKe23XZJmjdKWpG88hZb9UUl9CXsjftvg7BCf+Ep52bgxHNnkqKcfHwD8OyWNcw8ruCsvqm2dfTngkIb6x3etVE5H6RJwF
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 14:58:20.9494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5534f833-3b1c-45cd-dabe-08de67ebaa99
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9381
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[arm.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.65.56:from];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.65.56:from];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A6B4A431F6
X-Spamd-Bar: ----
Message-ID-Hash: NZEMUMXGLVFYXB2UAYTUBREX47AN46LS
X-Message-ID-Hash: NZEMUMXGLVFYXB2UAYTUBREX47AN46LS
X-MailFrom: Khaled.AliAhmed@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: Mohamed Omar Asaker <Mohamed.OmarAsaker@arm.com>, James King <James.King@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KPX4VP4LMFHLS56XP7TA3HWDZ632IEK7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Dan,
Thank you for sharing the proposal. We are happy to accept this solution once it has been pushed to a public repository so we can review and track it properly.
One point to highlight as we move forward: we always ensure that separate buffers are used for input and output to avoid any potential side effects or data corruption. Thanks again for the contribution, and we look forward to reviewing the implementation.
Best regards,
Khaled Ali Ahmed


Sent from Outlook for Mac

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Friday, 30 January 2026 at 11:26
To: Jens Wiklander <jens.wiklander@linaro.org>, Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>, arm-scmi@vger.kernel.org <arm-scmi@vger.kernel.org>, op-tee@lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>
Subject: OP-TEE: memory corruption in scmi_pin_control_list_associations_handler()

When we do SCMI on OP-TEE, the in buffer and out buffer are the same buffer.
I added some debug code to confirm this:

diff --git a/module/msg_smt/src/mod_msg_smt.c b/module/msg_smt/src/mod_msg_smt.c
index 853fe66b8d27..1e92dcd49c29 100644
--- a/module/msg_smt/src/mod_msg_smt.c
+++ b/module/msg_smt/src/mod_msg_smt.c
@@ -175,6 +175,11 @@ static int smt_write_payload(fwk_id_t channel_id,
     if (!channel_ctx->locked)
         return FWK_E_ACCESS;

+    FWK_LOG_ERR("OUT=%p IN=%p %s",
+               channel_ctx->out->payload,
+               channel_ctx->in->payload,
+               (channel_ctx->out->payload == channel_ctx->in->payload) ? "equal" : "different");
+
     memcpy(((uint8_t*)channel_ctx->out->payload) + offset, payload, size);

     return FWK_SUCCESS;

And it's true:

[    0.000000] OUT=0x9c401004 IN=0x9c401004 equal

This normally isn't a problem because we read a few inputs at the
start of the function and then write out the result to the output at the
end.

But in the scmi_pin_control_list_associations_handler() it does a loop
where each iteration reads from parameters->index which is input and
writes to the output with scmi_pin_control_ctx.scmi_api->write_payload()
and that corrupts the input data.

Copying the input buffer to a the stack the issue for me, but I feel
like it is a hack.  It would be better to use separate buffers for
input and output.

I think this comes from:
https://github.com/OP-TEE/optee_os/blob/master/core/kernel/pseudo_ta.c#L93
I added a print statement to there as well:

diff --git a/core/kernel/pseudo_ta.c b/core/kernel/pseudo_ta.c
index 587faa41a770..426870fb934c 100644
--- a/core/kernel/pseudo_ta.c
+++ b/core/kernel/pseudo_ta.c
@@ -90,6 +90,7 @@ static TEE_Result copy_in_param(struct ts_session *s __maybe_unused,
                                va = NULL;
                        }

+                       EMSG("n=%lu va=%p", n, va);
                        tee_param[n].memref.buffer = va;
                        tee_param[n].memref.size = mem->size;
                        break;

E/TC:? 0 copy_in_param:93 n=1 va=0x9c401000
E/TC:? 0 copy_in_param:93 n=2 va=0x9c401000

Here is the patch to save "parameters" to a different buffer.

---
 .../scmi_pin_control/src/mod_scmi_pin_control.c   | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/module/scmi_pin_control/src/mod_scmi_pin_control.c b/module/scmi_pin_control/src/mod_scmi_pin_control.c
index a0b90dd2b73f..54e613b70f69 100644
--- a/module/scmi_pin_control/src/mod_scmi_pin_control.c
+++ b/module/scmi_pin_control/src/mod_scmi_pin_control.c
@@ -344,7 +344,7 @@ static int scmi_pin_control_list_associations_handler(
     fwk_id_t service_id,
     const uint32_t *payload)
 {
-    const struct scmi_pin_control_list_associations_a2p *parameters;
+    const struct scmi_pin_control_list_associations_a2p parameters;
     uint32_t payload_size;
     uint16_t identifiers_count;
     uint16_t total_number_of_associations;
@@ -362,8 +362,9 @@ static int scmi_pin_control_list_associations_handler(
     payload_size = (uint32_t)sizeof(return_values);

     parameters = (const struct scmi_pin_control_list_associations_a2p *)payload;
+    memcpy(&parameters, payload, sizeof(parameters));

-    status = map_identifier(parameters->identifier, &mapped_identifier);
+    status = map_identifier(parameters.identifier, &mapped_identifier);

     if (status != FWK_SUCCESS) {
         return_values.status = SCMI_NOT_FOUND;
@@ -371,7 +372,7 @@ static int scmi_pin_control_list_associations_handler(
     }

     status = scmi_pin_control_ctx.pinctrl_api->get_total_number_of_associations(
-        mapped_identifier, parameters->flags, &total_number_of_associations);
+        mapped_identifier, parameters.flags, &total_number_of_associations);
     if (status != FWK_SUCCESS) {
         return_values.status = SCMI_NOT_FOUND;
         goto exit;
@@ -388,11 +389,11 @@ static int scmi_pin_control_list_associations_handler(

     identifiers_count = (uint16_t)FWK_MIN(
         buffer_allowed_identifiers,
-        (uint16_t)(total_number_of_associations - parameters->index));
+        (uint16_t)(total_number_of_associations - parameters.index));

     return_values.flags = identifiers_count;
     return_values.flags |= SHIFT_LEFT_BY_POS(
-        (total_number_of_associations - parameters->index - identifiers_count),
+        (total_number_of_associations - parameters.index - identifiers_count),
         NUM_OF_REMAINING_ELEMENTS_POS);

     for (identifier_index = 0; identifier_index < identifiers_count;
@@ -401,8 +402,8 @@ static int scmi_pin_control_list_associations_handler(

         status = scmi_pin_control_ctx.pinctrl_api->get_list_associations(
             mapped_identifier,
-            parameters->flags,
-            (parameters->index + identifier_index),
+            parameters.flags,
+            (parameters.index + identifier_index),
             &object_id);
         if (status != FWK_SUCCESS) {
             return_values.status = SCMI_NOT_FOUND;
--
2.51.0

