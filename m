Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F672C624A4
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 18:14:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B21FB45336
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788459241;
	bh=OMCRE9hVBNe6fJ12VLLHamU5kHxdiOEmcupS/dKooUU=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=I2ELe/XjzBvvUiHoOd1Ye5Xx2zYD69Pnq52uosZA4VhXtObbtyLKwYVpzSx5by3ip
	 dCJ2Yf4kqC/ARa7QP6LNevU53Si+l7JiJpEufYzIZYOXBJDrdaOh2zYPVfeO8kmrnx
	 GcQFaTNCr1wFkv8G0WVblUqbzuf9rBvVNs3Kaf8J/OvDdxWXjPTsCqSvg3l/iNRPoz
	 1pye8KWayRRdbQ/FEMTOS4b2vTmv1WRHCx2eql9WD2AZ3YMzk+O3N37ddz2gyT3yb5
	 u75BEwsBGmigml07mgfKZWS9cbmLBHz//9TuklOxDKsT5K/QISjvsseGo2kRR7PC4D
	 Pbx2JNjPS/gBw==
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4FD5944F76
	for <op-tee@lists.trustedfirmware.org>; Thu,  3 Sep 2026 18:13:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=JNlJpwCO;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=hdBkNiau;
	dkim-atps=neutral
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 683G0kTH1342932;
	Thu, 3 Sep 2026 13:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=JU8Av/8wuZBRJ
	cI/382R7k/nWkHKH9N7rBy6Qv6nwa4=; b=JNlJpwCOKbB2IOAk5oJcnwXyaF5sV
	SlJK8GTf0p05UcC1GxZExkPhyFTXAhJKujJLGU4mN8KGzv9esUHYWKsxf2GBelgq
	bFraJ4gEAipjUeuwnaB6+HM7vjxQbKPVAbzDNbgBckQfIlj5hHEQHAiBrx0ZC5Ab
	dnMwxvJ0ojjbmlIcOwNX9ORMBJvpSxK18MSS3d8PkiWnJzL2w2yVAlOttpGb0oxO
	ddpokTpV0yhxkC0+5HLCb2zs6wnZonAR5uVUfRbxBb3R91pgXCTSZJ2C5++YAbck
	7LLdGQNLen+9xcOH2Y6WICyGe6kww2iohCb/rJPiX9NcctS0B0NXmT+rQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gewt8p6bv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 13:13:51 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMxVZ7Cn5icQJWFVoFj8wuzTuJmlzyl7Q1gK8VgneBgtVQFtDJCLjpbXt1EgW416sphBljd5THpFdLmrB+ygiXpCJ5u76p1E6APYCsJPfeRN+/jHaC1Y9nr5ElJyMvv6rDUj5KpodULyGtk1WvYnJxJAD8pUvcSlFtkTfQFFvjfZlKvyEUyk5B4OQunyD9jqs7zOilH8JD9I9A5hmIw17uiN7f+KlcNX2UlsmS78Z+iEiBRYpQe8+RIUC/78R6YQ7yXFDLFOIgbG90pbEKpLf8mHy8hbAQW9/UsA2OiIqLsxtbVcQgQ8lAHMbMjUzvIEmHy2ERmt3Fc8PVFjcV8kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JU8Av/8wuZBRJcI/382R7k/nWkHKH9N7rBy6Qv6nwa4=;
 b=ebTJPW7gXayII40chQdjvGsjI0LvjTdlvIevW8/u6VcphvWwyjCkQypuLx8630gxVhXGCMKvNflrLJVL14MDG1acardn4h5f4hMoJgjCBPgCECtSbNaVa546MUfRSHJUk3Sc6Pup2bnfwWlNA1Qythk9EEYUCfMnakinrr9TuEIIMZDUMfnZV+mKBE3s8fyfqkXMPR1nwAMJO+XrCNZVyjrZvOmqo3UgkNRlaeRdaERIB1J/zmmmA9tt0+LvlyBQp/IkLZ0+Snn93Jn/Qz6fru4ccqZJj5Nnh6V/japOoNoJukVooE5/Q1KQZH3YZNz4KHNatAcLnXyRE53uYq0SqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JU8Av/8wuZBRJcI/382R7k/nWkHKH9N7rBy6Qv6nwa4=;
 b=hdBkNiau8kJ7OIdCX0pPrOB8qfhGgNy5Dg2Rgl+QTEyyF3rkva8C4loUC5ueyuwC5DNXmzmfibIZCdIoyLxOZFE+AdGHg5a371l9I54syz0P7GXFI16icep0qfWqSiuayDAxzIivjd0liJUHRxzPnYUWEagUox7FWgQToBN5MiA=
Received: from SJ0PR03CA0243.namprd03.prod.outlook.com (2603:10b6:a03:3a0::8)
 by PH7PR10MB6652.namprd10.prod.outlook.com (2603:10b6:510:20b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 18:13:48 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::80) by SJ0PR03CA0243.outlook.office365.com
 (2603:10b6:a03:3a0::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 18:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 18:13:44 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 13:12:52 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 13:12:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 13:12:52 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.221])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 683ICpTk3036564;
	Thu, 3 Sep 2026 13:12:52 -0500
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] tee: move tee_ioctl_shm_register_data to above IOCTL definition
Date: Thu, 3 Sep 2026 13:12:51 -0500
Message-ID: <20260903181251.1912165-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH7PR10MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: fafca3d0-83a5-48a8-50a5-08df09e71781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ZeGI0f8zxAH81mfef2/d3ix9ktZyAht7j3KGISXfKJbvsztcbgpXbBDbM06ByCRuqSuEPoIq0H5sfWGGxWsN9oHDe4l87AjWvhPnsUTmCnIaAt4IctYBRns7A8DWxz7L6x0nUEdYV/JZ4C5qT6+IkYQMjttPIH72ZGBrJnYyEBglpwR2KcpUXvRfeJvl1gfH8Jd/dkMShzd5z3v2eaeGHOiMdtVDIe45t7ey+a6rI6o319zft9nJUYY78PqsZ/IHkGu++q5f8/AFOLrxf1ZiVgant3VGRdlUXP1UmgvDkbVsD2MWDfjsCHQUcGtLFvypL2LWMby9IFtx+3nQTJiNojXitsoV67EQSsxxQxd67Ilxd67tGHKXPDr9Y0fAGKldwBJiDLD26mL6qHEJjFvQRnWgn/+9N4iLKbv4uHra7CtpUiD2bkoPIOzByE2Y7WgcYHRIIEGtouyTUvlhiYtvFuOA9zqTNJC4Fbg3BxJKOHbGqul1IJ2UieERcbWntl+Et1gZGMzbLYFt70jmb8vYccEqsGwmoLlEwd1d3T9SFjwSnGJraWg27mha+IixEQiZzlnmIR4hNanIKLWoPdOiRvhkSaqjk24/G3yN0pjwsEGFILiNFg3LDdNUDb8ymG1X9TOmgpg44GZtHOrmxRFe/gfZ9DhpckEDyHjelIMuJBnJAfsDCE+vtxXt871d0ICRmw7Aq41UtBuVE955/Kfhzw==
X-Forefront-Antispam-Report: 
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	wnf+EcOy9tcErBAH4IDzByhFObE7y6LrBw5DXSwL0nB38srJcJBpEO7rVt351eKhhsldXov4OvQLDL7vM1/ZyinijmhScNZLEFVPN3pK/ECx/gBxP2/AyA0rmOq1BjeP7oeJsGNPs/rvGAXgPYBGqIyU9Kig5xLhgpwXyBPoetp9bie3llb6s2Jt++yyLjiEuXQrCgkRn3F3zyF+4nqZiFVlwsbjGFOfuzfNrOgq+wrVIUq01y4wqmlcg7c2Gvkofo/dmLJjWRso6jOAx54oTMS8pm99vZeMZkgkOxp0Xt+fsYpHsuC1FrDo3BPXf6h29da0Y/Nt4UJVoVrGpilRarB+XXUqeazMEhBFDVHC8INkTNbEhBeECUaFod+S4JHoeK3EHWlHjHovfKEjLqEtaGFkPLnKxmgd4+FnE/MqNdL3h4OgFuU5shPKiCkGL5jG
X-Exchange-RoutingPolicyChecked: 
	fU3Kc4jl5WTofK3JG5fy6x6IN6jw+6E49iKaju2M3byi5Fb0BLwHPWV+4m9nOQwsLc8fzq+pPvJm2BLjXMDPqHbbOEl3Uh9nYNn+JfWktpaAUIbZmVjptbp0t0FC1xBq4zpJINJd9+ZChmHLg9nJcwHNY11v089Yq9afKf3wXZ4pXznLh8CPmGR4wfzBRFa+TBENT3EztojNGg9RFq/uyRc8jVCB2Dd/Khc9tOCnUj4CvjkSTRQd0OXcDaFAuMQ3az/Gsm3lLayK4tiLiR5J1v7hT9lRUa+xX1FbjAa9zeBsJJcADJrawl0NxWuRX4s9CFTxzLeonqBWGOeApeRG5g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:13:44.5077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafca3d0-83a5-48a8-50a5-08df09e71781
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6652
X-Authority-Analysis: v=2.4 cv=de+wG3Xe c=1 sm=1 tr=0 ts=6a99b8df cx=c_pps
 a=OViojaO3c1oaidwcGWKC2A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=yf5ehZLxDqhilrAfVTIA:9
X-Proofpoint-ORIG-GUID: JrK_zBnUQFhhCrBALoSGqwfDzJg1caTG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE1OSBTYWx0ZWRfXwYthctPN/JDG
 Q/1t9r2RMaxJbh7OUyyRmfofh/3ysy42Rb7edknAnzvShHwZqCzZdCaRFh+oVRDolKSRSf42ToJ
 FttpdcSVD6zCUX56+67avd8JoUD3aWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE1OSBTYWx0ZWRfXzPMVfYXlIfwq
 ax53vauloKbT8bkBSxrncqnJo4UtxBxw9Wr6HGHk1zL+YNClWzi+cawk52kDEp4+zalcSBIFkBe
 uQ8+wwvkpmjPUNXiPipPCXIGIv1uOO422M8YwUZXInT27hYXW+NC40WdXkSc86ntrE1yyBIKJET
 8LLGjpW+vbzBPkjkL4yBH43vUlVYLUfhGRt5dgz87hgN0fHV772D/tFb7/nJD0fMKfQUGNqRr4e
 8oVd3l9SAjQpUBfcLxGjKvvsBoqbGQBPL49v72X6T8LILQvyHIQQhkX+NToykkwLQdUUCJVoPvk
 GuJN3DA1d5/rygTWb4tKQpkhFoJfQlrB7Zq5iOEpiSDowFOxbIK5Db/mQJn3WxHjCbU+CfGxY4h
 P9cttx5mGqJWlq6yspjN54w5+tZxbAP/69RYuzoswjLzeAXabzMM+Y/roewdYb+4Ho9KqvvWzv4
 IfKkD5uf41PWbybf39w==
X-Proofpoint-GUID: JrK_zBnUQFhhCrBALoSGqwfDzJg1caTG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030159
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:148.163.150.75];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:148.163.148.0/22, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.53.7:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10b6:a03:3a0:cafe::80:received];
	RCVD_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4FD5944F76
X-Spamd-Bar: ---
Message-ID-Hash: 7CSH6W2OYFXSWHQZBDLKS23MWA5QFECI
X-Message-ID-Hash: 7CSH6W2OYFXSWHQZBDLKS23MWA5QFECI
X-MailFrom: afd@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Andrew Davis <afd@ti.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7CSH6W2OYFXSWHQZBDLKS23MWA5QFECI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Andrew Davis via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Andrew Davis <afd@ti.com>

Most of the struct definitions for a given IOCTL definition immediately
preceded that definition. The struct tee_ioctl_shm_register_data is an
exception as it is placed above the TEE_IOC_SHM_REGISTER_FD definition,
not the TEE_IOC_SHM_REGISTER one it is to be used with. Move it down
to match the others.

This is a non-functional change for consistency and to help prevent
someone from accidentally using the wrong struct with the wrong IOCTL
based on the struct's location.

Fix a couple small spelling issues while here.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Resending using folks updated emails :)

 include/uapi/linux/tee.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index 5203977ed35d1..76815b0f4b665 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -384,24 +384,6 @@ struct tee_iocl_supp_send_arg {
 #define TEE_IOC_SUPPL_SEND	_IOR(TEE_IOC_MAGIC, TEE_IOC_BASE + 7, \
 				     struct tee_ioctl_buf_data)
 
-/**
- * struct tee_ioctl_shm_register_data - Shared memory register argument
- * @addr:      [in] Start address of shared memory to register
- * @length:    [in/out] Length of shared memory to register
- * @flags:     [in/out] Flags to/from registration.
- * @id:                [out] Identifier of the shared memory
- *
- * The flags field should currently be zero as input. Updated by the call
- * with actual flags as defined by TEE_IOCTL_SHM_* above.
- * This structure is used as argument for TEE_IOC_SHM_REGISTER below.
- */
-struct tee_ioctl_shm_register_data {
-	__u64 addr;
-	__u64 length;
-	__u32 flags;
-	__s32 id;
-};
-
 /**
  * struct tee_ioctl_shm_register_fd_data - Shared memory registering argument
  * @fd:		[in] File descriptor identifying dmabuf reference
@@ -426,13 +408,31 @@ struct tee_ioctl_shm_register_fd_data {
  * Returns a file descriptor on success or < 0 on failure
  *
  * The returned file descriptor refers to the shared memory object in the
- * kernel. The supplied file deccriptor can be closed if it's not needed
+ * kernel. The supplied file descriptor can be closed if it's not needed
  * for other purposes. The shared memory is freed when the descriptor is
  * closed.
  */
 #define TEE_IOC_SHM_REGISTER_FD	_IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 8, \
 				     struct tee_ioctl_shm_register_fd_data)
 
+/**
+ * struct tee_ioctl_shm_register_data - Shared memory register argument
+ * @addr:      [in] Start address of shared memory to register
+ * @length:    [in/out] Length of shared memory to register
+ * @flags:     [in/out] Flags to/from registration.
+ * @id:                [out] Identifier of the shared memory
+ *
+ * The flags field should currently be zero as input. Updated by the call
+ * with actual flags as defined by TEE_IOCTL_SHM_* above.
+ * This structure is used as argument for TEE_IOC_SHM_REGISTER below.
+ */
+struct tee_ioctl_shm_register_data {
+	__u64 addr;
+	__u64 length;
+	__u32 flags;
+	__s32 id;
+};
+
 /**
  * TEE_IOC_SHM_REGISTER - Register shared memory argument
  *
@@ -440,7 +440,7 @@ struct tee_ioctl_shm_register_fd_data {
  *
  * Returns a file descriptor on success or < 0 on failure
  *
- * The shared memory is unregisterred when the descriptor is closed.
+ * The shared memory is unregistered when the descriptor is closed.
  */
 #define TEE_IOC_SHM_REGISTER   _IOWR(TEE_IOC_MAGIC, TEE_IOC_BASE + 9, \
 				     struct tee_ioctl_shm_register_data)
-- 
2.39.2

