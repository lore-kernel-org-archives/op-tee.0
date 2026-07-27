Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABEAC531D0
	for <op-tee@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3FB8144EE7
	for <op-tee@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=nDW2RZQw;
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013069.outbound.protection.outlook.com [40.107.159.69])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3895543AC8
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Jul 2026 07:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dL6j7pcMUDlT8j0MW+aO73o8orgZ/Wge91HLQD0B7tK+W1CR9YBX6bDoz2pREym2405qyxF1LpAi9OCjS8XTJiutM2G+1X0slZvhrgVK3AZZO+APaF/q1tjdHd+rT+31R/iHwIBfBHjOn6uYSh0OTp4tYAnP/F8OFTAiA/nTGF9yocctkTHSBJyTwpYssfkS8YUcKyTOxnERcZRmvJG9dsR9Msxibvtyro/RmHExNsQ5EA8ypM/MezF2IWQu99DhMYlFvsQpIjxt7vd9rTQ+25l84SK1YjTdIvrPubvfK4xYUtPPFGZOCaPawHEKrC4eAH43xNVvg8iUWubvEyb8VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JfS7hXqiqjp2IM6qXitAVvMiKvOuI+iZBUBwciveG7U=;
 b=lVDxKWB7EGLWK7Em0x/tUT1fqNEpBu29SZHWzqM6BxIlQHMNFriEJTK+RYnBBx40Ra9rn7ykdFLrp0hgxWIp56WeJv3vMjnG20OCFFPBNn2PUvoqFIK/cVKqNcsJQ4l2gKNugdXFr2he5P2mnqlf3zvDYdD/t+z1M6vd3EPmXX8FMsyxGaXeRAywGJeb+kDPrJCGULgNIWsLuIsPpSHs6IuA2uvfU3tgyP0DO80eVCGzGhazSfqsTNLKo59Sd2lIGBUZuNg6ELLAfaLvpS9Rom9AzoeZIE2R1owisaMi73UFa4yC4WIFzgCdJd5qiELtogyX2pMFTdcf0wjsjYPgQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.trustedfirmware.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JfS7hXqiqjp2IM6qXitAVvMiKvOuI+iZBUBwciveG7U=;
 b=nDW2RZQwOUMaPByEix6cjY2F2xB2z+vgUqLx5AhNvdH33MRfw7AZ0bd2ZuB7e3iPFJdirBt6OXMJr/2uHYghSDITtxQ8eKfN117LRJImTCHFMHNzqZ133Es1u+KE6D0Zy50J+CGVFfEoafnCFl3GJCFg8R8Irr/v+iOa7rZCrBBbERdZqZXWrnZ2EMO9SOxs0zfkvQxsCo9t7NU5nZGT+qBGExEq7UBAX6xHYaj/kYWXN7BTPlgy45W44gs6gLcdXn6gzIblaanAA9TbF73rT52zfut1VXvSrwACb5pSABrAga4VuH4OWwUJBia9VcgSEKgej1oHPo7F6y9BKksA4A==
Received: from DU2PR04CA0245.eurprd04.prod.outlook.com (2603:10a6:10:28e::10)
 by DU4PR10MB8541.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 07:17:29 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::72) by DU2PR04CA0245.outlook.office365.com
 (2603:10a6:10:28e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 07:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 07:17:28 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 27 Jul
 2026 09:22:48 +0200
Received: from STKDAG1NODE2.st.com (10.75.128.133) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 27 Jul
 2026 09:17:28 +0200
Received: from STKDAG1NODE2.st.com ([::1]) by STKDAG1NODE2.st.com
 ([fe80::2b2d:bcdf:3851:be16%9]) with mapi id 15.02.2562.043; Mon, 27 Jul 2026
 09:17:28 +0200
From: Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
To: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
Subject: OP-TEE Contributions Forum, monthly meeting July 28
Thread-Topic: OP-TEE Contributions Forum, monthly meeting July 28
Thread-Index: AQHdHZaIh9Tbpu8flUKEllV1KNxFfg==
Date: Mon, 27 Jul 2026 07:17:27 +0000
Message-ID: <f440a6f5b3a94434b8b2db9aaa5cbdb8@foss.st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.86.128]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|DU4PR10MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: f90c7041-e558-42be-63c5-08deebaf1e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|13003099007|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	O9mOskTD8DMHWVYo1WJwozslYcl8dKXWEG+vMQTkq+aj4f2uIqJCANSb6t2x5Gs830iCK5qH8jTE4CAZReADHLoy2rIy00G0aFPhsPwdq7ROCSIJteOtKIwaCmGFT2eZAhLl/nXkFT3Yqd6MuLycCN/APRTvnCt4qHB5/KTpm1ZSMDiAairXvPrmf/Cq//Ulzh77GvSRPENdLxjemyEJfHri7SjG47+E0ZAtFtmBf4jmeE2wofiaPx65zLdQz6tBGSChrxUh3tBEVM5cYsmAnYyi8OnI5yDPeuh9KvnLi8eIn1auCRNmAAioOVxBdag3Jof4iGbG6CwI9+dK9Dj3Amj5MoJGkmED1uXKKZVUkn64my6uDDDrlqXN3Rkv+nzhcin3VGyerlTf7/SWHHO4UnylcUnHprUSOW9ksLydr1mq8gAh6+7E40qdepth5J3eZoo83mOpACeKMELWLlIgTKfANTjWAL7yV7oCBIexww6hCK61immLb/h2ys183vyQGCPSigE1DWeDeGf7CnHNN73D9+Av8ZSrL8ZOo7o8GKxUbdK2R6h7GVOXmiXu2jMP6YMf2XDGUyf9KNM3tLkib3oggoZEKjMDCa08oJm/4+Iy2x184gjWIh6gUClC0otmEWMHSlX2wd+tc4WZRxHmfQ==
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(13003099007)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ri4JsVSxaEOHUEv98BHp4mfOUiKyBQAKSgUlYL9aG8vB97QnOt8Rsl7AZsqyrtzaBqBvxfCIffc0UCRmBzUyqsBo5blnhiYqk3+1AGXRbZTWFPecGOZ/qPvwygmmV6TWQqiA0N9xLwapSIft8EMLcn3s8/QPI1pEYJoATZo9JKBE1mdJ1Zz9bxwA8/mh+qAOl+ih1mi5sSn2zYbOOWt7j3qjXM/lo5a2tdzIWmqMTgEIjzBEBRePLQQ6uACnHIbePigiuwUflMy6eGV8jHOhKo+mU6o0JnOU4mv/m1rg+QAdoE5Mis6q6lVKe6ve43j/klXSRHTMZRGOwXWnbKjnIQ6bqn7K9WWKQK+zaCG3aPQ/ap7JuWOgmo21GzUjNVrBCx9y0rBsPLBMWzcuY3PnyEOTM/FHnONyxRUcb3RB0JzkM52wj/rwGnlN+QT9IrpP
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 07:17:28.8139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f90c7041-e558-42be-63c5-08deebaf1e10
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8541
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.83 / 15.00];
	BAYES_HAM(-1.83)[93.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.159.69:from];
	MISSING_XM_UA(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.159.69:from];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	HAS_XOIP(0.00)[];
	DKIM_TRACE(0.00)[foss.st.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3895543AC8
X-Spamd-Bar: ---
Message-ID-Hash: UHTEMVPCUIO3DXGIJ5ZMN44PH2ASJVOO
X-Message-ID-Hash: UHTEMVPCUIO3DXGIJ5ZMN44PH2ASJVOO
X-MailFrom: etienne.carriere@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UHTEMVPCUIO3DXGIJ5ZMN44PH2ASJVOO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Dear all,

Tomorrow, Tuesday July 28th, 8am UTC, is the next OP-TEE Public Meeting.

For time and connection details, see the calendar at:
https://www.trustedfirmware.org/meetings=20


There are no specific topics to the agenda but feel free to join and raise =
any question or share any topic you want, or just attend in case some discu=
ssed topics may interest you.

Sorry for the short notice.

Regards,
Etienne Carriere
