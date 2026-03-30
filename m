Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB24710D14A0
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 11:16:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DAE8A443CC
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 11:16:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IFutKBgW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=IFutKBgW;
	dkim-atps=neutral
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8053643AAF
	for <op-tee@lists.trustedfirmware.org>; Mon, 30 Mar 2026 11:15:55 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=YAQi2Z+MTEcUs8fKav/V6nlae56uJkY+ZlBBYQUyBlW4G/EL5KhoRBuFpc9rCVU/chTtLEXwGCs77FHuYGjyfb0zQzPqKK2Qm+qsVV/uRx7TQpUU9JNJppZinrAosPnfYXB9zzgZUwaJOkha9uIMbFmSlw7Kqoq2QxvyMQvpuEL+/SZkqqtUYmCmbCaaCzjdMP+c/hq3Uf90X6S6h8BPB8u4HTFurveD3VEOry5B6rNHjJNj3htiH8Y4SaczN7VobL5N4l2DezoPNqis039fyKSATsqF+vlEZXyY7mWUvUHDwP0N+6ssBh2cKRCzzVjhuxpR4PG2GIRG9AIT8DrKTA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPPr/uqsolQ5cmo/QsthNWiPWDPvlWwXteLfXduCOB4=;
 b=IzuMplzXxO7Cqnsl9ehIBcNFiZ7eWtqcnlnM/BS+mRXEGyN9/EWWHxYIuNSpmTVC++NAVRFxJgGrx9AzN52cxXhQ2SOdGGXHUDLEMQWRu9+VyvISHwtbwCnZxUragaMcV8bhCtIVYNNfWb84cNsYTnDamwJ5f1kiFjLO1v4WOGCXEInjJBg2YR7nzmbGINiRujPO+iXWRPnQUL1Xf/kWd6xzuS0MN9/sYlaDL+Y21zSYGHelubprDQBNOYBAvu78nZYXoqhcOGyT5Qk8M1NJGXXdtGQX3YX7RfnHOUj0o1SsO84LE2IDsmXnTNsDI3gBHuCnaIRdAoNu5ZzgEf3W3w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPPr/uqsolQ5cmo/QsthNWiPWDPvlWwXteLfXduCOB4=;
 b=IFutKBgWSFHeayauHzvT9QtapVzt50hk1gIsBfsLJBfOIqhseb0xweLFAjxQS00n8LGnc0IdzRbnb2PCdjab63q886jLFzcH8xsTQF3f7655YZ35Mi/qYHlgbOtRM025Dxa875RhpDnxZUx2Y3NWz5EzASn+A2YgLq+BtrehCUo=
Received: from CWLP265CA0315.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:57::15)
 by AS4PR08MB8191.eurprd08.prod.outlook.com (2603:10a6:20b:58e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:15:52 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:401:57:cafe::a5) by CWLP265CA0315.outlook.office365.com
 (2603:10a6:401:57::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 11:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.0
 via Frontend Transport; Mon, 30 Mar 2026 11:15:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmFcDNjla4+xC5a4s4bg5AtqsnB9e0tqFdY+btYZ6bJr7xHF532gb9ngVcPpuTIVOt+F0dtJZdEPCpskQGXTGry6MXTuIHzfbvh5R83Jl+zzIwvcRl2p8xsYsdx6YrSg6IdUJ/p9rNQnabT16W3/OM/03Gm/NvF6pOMJ++N8OHldpBIzeZkEdSrTE1l7s2sedxg5ERuOIZceHxDa2RVwjCWUbCdbJiiAFIwWCkoTgaNA2iaKeH4V+uAto9a0ucdGm7PQ6VskhbPgory9q0NL4RGo6ieT9b6djTMin0nMbmNwh+v7jKJfklDWSeM91F1jUm3FHdVYrgjgyN3pt7j0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPPr/uqsolQ5cmo/QsthNWiPWDPvlWwXteLfXduCOB4=;
 b=GKKn2j2ugCSyQrkT94wT3XQQBGjngGd+BctMX30GwIQXd4TyEZCVWXqW3/lw7WnPctLNyoVnEbwDFWILyjZIkGRruuMKEAknglDoFd9d3VF1XeijHJmNTTECL2im3On2Ym2a9jdYjVoMCyGtaxZbX/yA5WGGeffwgqwSXtIjyCwNNz9UPMnsWeu2/N/mk0GhgVnlM4+11v202BX0abFVaWG6TS1GKOPEGtq5M0FspLWlut6iZBmdNcWgAJCirMOCE8RHr2P3qeVLxnLIJheek26XTJEcek5UZXsqQuMLEY9Qpav2Qrvfm0DQ6BxiFRmiaCeRBtwSVMbE8X4RZ09KEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPPr/uqsolQ5cmo/QsthNWiPWDPvlWwXteLfXduCOB4=;
 b=IFutKBgWSFHeayauHzvT9QtapVzt50hk1gIsBfsLJBfOIqhseb0xweLFAjxQS00n8LGnc0IdzRbnb2PCdjab63q886jLFzcH8xsTQF3f7655YZ35Mi/qYHlgbOtRM025Dxa875RhpDnxZUx2Y3NWz5EzASn+A2YgLq+BtrehCUo=
Received: from GV2PR08MB7955.eurprd08.prod.outlook.com (2603:10a6:150:7f::21)
 by PAWPR08MB11194.eurprd08.prod.outlook.com (2603:10a6:102:468::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:14:48 +0000
Received: from GV2PR08MB7955.eurprd08.prod.outlook.com
 ([fe80::1c8d:72b6:159c:3ff7]) by GV2PR08MB7955.eurprd08.prod.outlook.com
 ([fe80::1c8d:72b6:159c:3ff7%4]) with mapi id 15.20.9745.025; Mon, 30 Mar 2026
 11:14:48 +0000
From: Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: OP-TEE: memory corruption in
 scmi_pin_control_list_associations_handler()
Thread-Topic: OP-TEE: memory corruption in
 scmi_pin_control_list_associations_handler()
Thread-Index: AQHckds8uQFd49LX4k21qkZC896iU7V6gFmXgEMw2YCACZbs0A==
Date: Mon, 30 Mar 2026 11:14:48 +0000
Message-ID: 
 <GV2PR08MB79556C7FAAFC9458CDD8C240EB52A@GV2PR08MB7955.eurprd08.prod.outlook.com>
References: <aXyVSfxbrff_GX8A@stanley.mountain>
 <GV2PR08MB79551A173F9B2762E6860FD5EB65A@GV2PR08MB7955.eurprd08.prod.outlook.com>
 <acJO-etj8Xu7Nssb@stanley.mountain>
In-Reply-To: <acJO-etj8Xu7Nssb@stanley.mountain>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	GV2PR08MB7955:EE_|PAWPR08MB11194:EE_|AM4PEPF00025F9B:EE_|AS4PR08MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: acf1b949-7cac-4eb4-7de7-08de8e4db3ee
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|13003099007|38070700021|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: 
 fQyTiAewywUl1li/qgr6bVmwyPM3qVJjK0ZjNyq9orBs+bV0W6gobQY2fdc5kvtfIsTKtGZdUKeaF0pP+MoBif/uzWAXS285BVZ+WjcnkuNlTNGLzkA7mw6qUX9qiC+i+WIJ7RM/t5FxYvtEK3iyfpbM5xdTOsXS03hF3/zhj/zSbKgO3hURnZJ1ecwg2IGvIAei9inb9lElCPvGANy9KGwyfNdXIE7cZVT7vWUrstZQQQHneUy6RBwcWGVbVY50f1Lhe25gu3dxLlGy2opg3/engXGHPrCRnl3/hfuuV3l1lSCYaFAjvFq8Vu7vn4facW8POunM0NM1O28bupFc6gNbjgsq+KJNOhFTj02ZpAtzSc4IOKGSRf7QSfNzlwunLeSGvI+YyIjDtu+jbwdinpVdnlQh8GdptIxYi+Am3zd0oV5/g9ZaEtcoD829wtwKMBLPJdKMEaAY2blTQJSJ6EDO5wzvg/ipcVzapDXXhAFEz66d6H6Uc7iWXYopnWMJt3wIVA7Icqlm1XvWfq1uXyvbPlzuXORDYk/+ku1h8lgHsPpk9YyQiYZPXu5TChe1qTcKsVylF9g5ZgfivQvzUd1x2BrRnYufkJzeJ0yHcNovA86BxIPoYKk1szlUT+akYYFvsIBFUWgTWWrRMyaozmiwJ59pPmQizE0HShm+rixXx2v2RFtLwAFn5I4A0TBLb1fJ6nq9fiyP97PVpMzvXYMWe8Byd/8c7EqjWX2uCNLGltehw3cciKw9tt/6XR0ECxSeJsRKvP6wtOJgqsz3OCFIbWrWH4rIFmCEgl+aXpQ=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB7955.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(13003099007)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 iqzcPYE1v6B2N/NqBMUm8MtTHLhWGV0EjXRmGMaiTeei7xAgvVUmU6dytf5n6aeiMnyCvargZsR4RRUaBc+uO7/2oiX6WfCTP2B4T38qfBl7tVbSC9VJHn5CwMTK8m1T32mDSNW60CW+ASupN7R5um/ORI8Jp5YkeClNP+/6uoQBfUWnKXLlds6EsnLbU7O9qGQJZMIaX5cFJXzwOUeg75yChpvE3aSUdPJdbVuAA1cjxi8E6vuU04ybFXUMj2uhaKmbetN2TAadfeUdbXXD6rFbG0sLuPfoAJnC9+XIIf8+33Gff4vKKEAuMrPPVDyfK0/2VgbJ47EHUkaFNqlvgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11194
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	279097e7-f835-407b-f99c-08de8e4d8e3e
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|14060799003|35042699022|1800799024|82310400026|13003099007|56012099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: 
	dhIrfoXnlciKhUgWbV4UDOyeStrYl5TvzsYHyFa84s2cFE1JoIq1hTYyEmbrJPewrcefzxbNMd1TWp/Q0TMa6bHzGLhkf/uMMcZ3s3tvP6cTkArApMJ3XSHVfLYEu431vSZ/r2TPCAWvJDoyU7LUA7LS8HquZDHgBpIguolfhtpDYOTakBi6gRi3LBxei44Mrp6ci88+gvQrez8cT9bO9f2tZpy4qzcUkFkn7SOrsusE2M2BkUvAeitSVXeDDPpviOji8Kk6cobZBJA1yXx3c5Gw35AiMZ+t+3DLZY6F/y1K7RdK+H4ilR6sIRNxqW60Uiiyi44szF0X2pyFLcey0vYIDqalDQhUSQKjk8nhDpZOzrHlUUIRBCdIJieMXL1ws04BgDA8MtcO16KEdSbnF87GLraagCcVrRn3oWlUneMCWYhKex+WIDgG9KsEDw4Qq7KAzYHhPeuapeV80SpEp5Qy6xGuIkDLO+4+RMFdTbxntJDzQSO7xqs8vJilPxLK92/YDXaVm4levd7etVKJI2TODFHgmvTxY4NTfDYhDcpyUpWpX18RwcC227/yFaChcHjWCiVeYhHCs/reKcQKLHMucNCyEoJFWgwXdUVCH58fCVg22RbuMd3wt7c5KtclAGYoE32oIBUZj3wpYGKVyfXKN325a0tGhaSG1l2ZBR2J8YXliLxnDyl1V4G7zgLu+xb+Cy6kE3Jfl6hKFAHJrw4UHgv3h8tF+j5xJ4GpLRmK3kmu51i5hBBRdapS1w2YlsqNEtMJWGk5Rw1rn1RKmA==
X-Forefront-Antispam-Report: 
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(14060799003)(35042699022)(1800799024)(82310400026)(13003099007)(56012099003)(22082099003)(18002099003)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jmmIPNsVDkqdOgD5Ph+wSwItKCSInz2jWNR7IirXvyLmitZyVONsY92JJhYttNR/c/n9dmnP15h6sZPLXgQGi/pMr4g9UMNqy2hUnbM8nbbDgDGiU7W+da0sZkS9O/Q81vdPqAR1fA/EVaJaltLz7UXwG5td6+6xOIdwjtfns4V36cwPmqxYAhC3f/gKrfEzOwXnEf5b8iBlH47bsi9KO5sPG9XWQI1BNJN2FOa0odaP4SON3ExclMv/BD9dnxQPlURKrgaxxPtFUxQvdvoBueyVSyQI8cd6gPeGDiImNvmEEpBEPx4yV/9FVHXteehNmB4Gq9JCXi1w99x3NuTPpxpYw8CDNnAUM0o80bTrAlWB6qbl9jV8hXIWJyp/GZwTyQhljX6pY2Q+Y6Kicj3mqf8x0SITZcsSqtmkZjCWI4Hb07SFiV2lbELT0oC5T4Mm
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:15:51.4625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf1b949-7cac-4eb4-7de7-08de8e4db3ee
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8191
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.35 / 15.00];
	BAYES_HAM(-2.85)[99.33%];
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
	RCVD_IN_DNSWL_NONE(0.00)[52.101.65.17:from];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2603:10a6:401:57:cafe::a5:received,2603:10a6:401:57::15:received,2603:10a6:150:7f::21:received];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.65.17:from];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[arm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8053643AAF
X-Spamd-Bar: ----
Message-ID-Hash: V6HDMX3OTC5MSZJXEPDUHTPXEGFZCOS5
X-Message-ID-Hash: V6HDMX3OTC5MSZJXEPDUHTPXEGFZCOS5
X-MailFrom: Khaled.AliAhmed@arm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, Mohamed Omar Asaker <Mohamed.OmarAsaker@arm.com>, James King <James.King@arm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/P4HYWXNS2UX2VC7IV4E4MQMF636SH6OI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Dan,
I take a look for the changed you pushed it seems good, but can you please open a MR to enable us to review it.

Best regards,
Khaled


Sent from Outlook for Mac

From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Tuesday, 24 March 2026 at 08:44
To: Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, arm-scmi@vger.kernel.org <arm-scmi@vger.kernel.org>, op-tee@lists.trustedfirmware.org <op-tee@lists.trustedfirmware.org>, Mohamed Omar Asaker <Mohamed.OmarAsaker@arm.com>, James King <James.King@arm.com>
Subject: Re: OP-TEE: memory corruption in scmi_pin_control_list_associations_handler()

On Mon, Feb 09, 2026 at 02:57:17PM +0000, Khaled Ali Ahmed wrote:
> Hi Dan,
> Thank you for sharing the proposal. We are happy to accept this solution once
> it has been pushed to a public repository so we can review and track it
> properly.

Thanks Khaled,

I've pushed this to:
https://github.com/error27/SCP-firmware.git optee-fix

I had a mistake in my original patch that I sent because I accidentally
sent the wrong version which still had parameters as const so it didn't
compile...  :/  Fixed now in the commit on github.

regards,
dan carpenter

