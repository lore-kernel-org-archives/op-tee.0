Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC305D65C78
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 16:09:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 300044315E
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 16:09:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Jt/YGBD7;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3B3E040AC5
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 16:09:33 +0000 (UTC)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHFaedf093090;
	Wed, 17 Dec 2025 16:39:59 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013068.outbound.protection.outlook.com [52.101.72.68])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3xb70h18-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 16:39:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td3Y79SHaYSkvVEFoVQfQXPoHBFRNO7rM8ThYGD0H+muk6DPxqHnWUplqHFT+PDbPQKBmv18ngiWWXs7z3SPz2+aoTrrI5uX+rKJm/f031Q/ObrHuBm593oxycv/4EgRELZraW0Y+z3OFcF6VEyRkJtqNzbG7xmYsQxXc/MgCebDRAVQwCRqO2uUs0sq8FF46T31KDdZ+ZJjCp73pIjLqlH0WHE5xKFeShDjJMBYbk0T2uRE2OZPQS3+xKeH9nUsxuKVSN9dhkBPKXTdDHetEPgRfAT3LiNkxNIBlHv2lUn4YmAljfmBz1Juf2uFLfLVrG/6ZQijQLsBXx1nHnpf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4duBz+9fl3aeITzuFd0Rp3rbm8v1uMeBlDWmaM23ag=;
 b=fHlIrMQf2maM6LImvIrvpEcJ6Fh2+KNKliwMomUxpdJJ3g+rlN028v/jrAl39thKWZF9L6lXb9OEVFz8pCFyOIYIml/hsmiU78gniDcK15TjAsjUT57oLWrUzqxBdma2TmIt5A7z4Y8QmVV40Fbzkek7ZR30IIl0dTIZPkFc/Whnb2xWM+H3sy1ACo7Kg2g6VcSFgg++MPS4F7beJvktVFg+s4bo8BIUnvZ4hWnd1AKdPZDpWt6hbaJpURBM91pnoFGoNbBbuE666JCqnZ7ZeDwJ2PbyDHuh8naXD40qGUiL/92IGSOQ3F+oUMryVuQKJb1u3KsRJqBbtBhABPKeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4duBz+9fl3aeITzuFd0Rp3rbm8v1uMeBlDWmaM23ag=;
 b=Jt/YGBD7e37w/yEDYaXDidv2oE7U4H1B7aA8JRFyH4E1yrYB9fYjyEbXBa5Licnjc+lcu2uNHZ4yPqsbueUSKOJ19WmiWI0TKwxCk9Nc/mDjbbI7lAYnXjE7amjqtSqZZrGe75QoMpvnb8Rw0MMps8Oh48XXO2EhSOAGhRQksRcVATJPq5NYSWtAPONW9XSRcgs9Voe0wXtV/eX6Yqnygu/N/4m5A0cJRr4tjWyHiTL533BBwvsjWBpnX//PEPjlBb2ptOCBrlNxqOVSZpJmrH6hPu/P5uZUxU4FbrGXGQVRyBtlx894HRvguqU9xhiTZkyRlODNeGJWBCNyOyWq/A==
Received: from AS9PR06CA0399.eurprd06.prod.outlook.com (2603:10a6:20b:461::12)
 by VI1PR10MB8304.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:39:55 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:461:cafe::25) by AS9PR06CA0399.outlook.office365.com
 (2603:10a6:20b:461::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Wed,
 17 Dec 2025 15:39:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:39:55 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:40:39 +0100
Received: from localhost (10.48.87.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:39:54 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v20 4/6] remoteproc: Introduce optional release_fw operation
Date: Wed, 17 Dec 2025 16:39:15 +0100
Message-ID: <20251217153917.3998544-5-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70F:EE_|VI1PR10MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 653456cf-ce35-49d0-8baf-08de3d8286df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sIEj+ha2n6H70s+1QTQWNtw/P9jK294V7xsotHh+1NXSZ0+Bb6qCJFiEJCJJ?=
 =?us-ascii?Q?M+99XaKEqGWZc8UUl4EpEUZMA5eo7Sfgo2Vhp9FgfSHA4s5BD7o4l1tbPGFs?=
 =?us-ascii?Q?9PjKuXl5vUbjE7myCJ/2ZIuZSUfc2BIyqf9tBwCTikL6QMMYajk0WKzeAKKF?=
 =?us-ascii?Q?RFYyAJ300W1OcRp/raXKD8AgraWroQwtX/KLII7cOEvVH6qfO/1D7RxmJMJc?=
 =?us-ascii?Q?WMMEdNj5eB0DFJKzw3QJlaql+/47+mhJm+ZieKY+9xBDXKLhMFtOApMhPqwY?=
 =?us-ascii?Q?8awbMp4RHy6KQguEkenOiyaS0Lvdook1xTS+6sS0mNfkrwCyNDdcCaVz4wVM?=
 =?us-ascii?Q?txPsJjAQufeHErFfkZcQaeFaY0beg5g4nz4vKGdXf8R6GzNFnggzWM9dldjl?=
 =?us-ascii?Q?H4cBtcUEGBpN48FQbISMqiza01G9SXCv1vaCXTTF8KWxS+oW3VMSD4ll3JGx?=
 =?us-ascii?Q?Bpn7PwQ4e/REuuCBSeo4Heur8TwsQQVsfdWo2LBenoJmXCZfdy82ABMsFtZI?=
 =?us-ascii?Q?lZzHOQry1Bfl/9fKxAPQx9S/t+RDlGZoxKNxRtCGrpOyy1E15w1P2hJ2s1Ap?=
 =?us-ascii?Q?qUV4pWp0gCjn/P5N3S+1QluOfJWasRXmEuSAlWPordj6TaYWD2N4enq5dKdT?=
 =?us-ascii?Q?RWv1mPNjz/VxuwvsxUw5zCB/HzKs0wKdnG4KO0PPY+YZRWd4IuL1ggqH+5JV?=
 =?us-ascii?Q?Z1iA2N9HrpKt9870x0634A2jOPmb9HZOlHGlXyeAdHf6v0Upc3ablK9Jbx4Z?=
 =?us-ascii?Q?pu8IEu4y6dV6q7B/uks9e54NH1pntKR1CfkJJ5bWPFm22B9cMXSKqk8E+4D7?=
 =?us-ascii?Q?4qTLspd2d3G3gqHHaqYhyURNWploV9ZYBWlxMwK2eZnlE8j9HuUWQG2cDJba?=
 =?us-ascii?Q?3lKyhIGEyMLiuWZrX/dL55ocq6kiV5osYwgWhCmG81mcnGibth9hRbOfUl/P?=
 =?us-ascii?Q?fNXWSHotc4g+/V/8b290d5Uh2vwqFjrKfP3fL/yzpBqV/7o9I9ehkS7xyxjt?=
 =?us-ascii?Q?8+KAxe79j6zAnqtqLytuZa3IZ5vkg4J7b/XiQfhX3FF0vC7QtXdVCORaAn1s?=
 =?us-ascii?Q?c+Uo0Y0k6ulZzj6M9kJN3OX0XKrQMFt7Y3X2F3TZWsrZ/uxnewQ4TmPo3Hui?=
 =?us-ascii?Q?8T33gByiPTVaCA397muoQcoMvxRzb3/Y0/imxrIP5KhZJuD8Q23Xapg02b6q?=
 =?us-ascii?Q?HJ2ufQ6YdvwmzO9hyXretbaOYCNbtyKz3wMwXpt2SGKRKgkzex5vMPXuIYfY?=
 =?us-ascii?Q?AiShPgmv9HLyB0yshW1G1QS2DvfYmKgyGZGSQtrYzicA0o+YejQ3wtRlktX7?=
 =?us-ascii?Q?h8eeW7S76xVMgYv8ZyrXnKWGiQNRPy6hohE0w5J++Iv/lbK3cQaKyXGary0I?=
 =?us-ascii?Q?SFBpVmn0WxGVKGRTZMbqRO6cl+chREsyz8g0VyZ6V6vUPl/iVeS+PbBEr0DS?=
 =?us-ascii?Q?x93gXVcYuTjggJKiOU/1JAJka6qbfoCfbLUpmc1A04zjO/OyreKB3Gf22kJm?=
 =?us-ascii?Q?m5qNa8dRiqzazo/z3bnM2bcGa14KPco36Rzn0RsEqZFz3kTIYKh906Sm6f8p?=
 =?us-ascii?Q?OhrWqTcFKH77rjBJ3no=3D?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:39:55.0240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 653456cf-ce35-49d0-8baf-08de3d8286df
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8304
X-Proofpoint-GUID: aROYN-EiOB8_f2f6sYXJZdDMd0-oiKbr
X-Proofpoint-ORIG-GUID: aROYN-EiOB8_f2f6sYXJZdDMd0-oiKbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyMyBTYWx0ZWRfX71GIaLBgk8Zu
 u8etNk2ry+I5sdFd7pPnlv6mDbeBHy5x60rUBGOYI4DoyFtKB9wAnVhlknuixhVh3lg+tfKpaZo
 wVMxYOUoaaYGmkGWhnWIuo70kVDW4cNNT3guDLXREtnhawdzQOTUYOURjwJ/+w6BVnW1luIzZ9q
 Sy2Vlio43sGYHD1Ad7LP3fqhAEh6n6CJMivHrBFD8X9qJAbWRpm3rhRJvh/D76xLGc7iwowPqOq
 H1KO3HOZ8ATQ+a+T2QlwSWoOOrif+boCReaS1lb7cgcw9+AJphmAaaP9WWc1/D0+cMyP97FuiGj
 zeofg7F1wvvAJ8a5y3ItWZcOsL/Gj5zRvDhVtUQyTM3iTiua8T8B4we8zH+kR0W29FdNpq3zyCa
 imDSphgqf3fs3wf+eE23C+HDQBZXyQ==
X-Authority-Analysis: v=2.4 cv=NZfrFmD4 c=1 sm=1 tr=0 ts=6942cecf cx=c_pps
 a=KOiI8WV4eRqHkUZxW/2pzg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=wP3pNCr1ah4A:10
 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=8b9GpE9nAAAA:8 a=Y25hYARbUHOvULiDmFIA:9 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2512170123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:185.132.182.106];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	RCVD_IN_DNSWL_LOW(-0.10)[185.132.182.106:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:52129, ipnet:185.132.182.0/24, country:US];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[164.130.1.60:received];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[52.101.72.68:server fail,164.130.1.60:server fail,185.132.182.106:server fail,2603:10a6:20b:461:cafe::25:server fail,2603:10a6:20b:461::12:server fail];
	FORGED_SENDER_VERP_SRS(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3B3E040AC5
X-Spamd-Bar: --
Message-ID-Hash: HG2XFRKB23N5MOC66VLHWBMXUV2NBMFK
X-Message-ID-Hash: HG2XFRKB23N5MOC66VLHWBMXUV2NBMFK
X-MailFrom: prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HG2XFRKB23N5MOC66VLHWBMXUV2NBMFK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

The release_fw operation allows releasing remote processor resources
configured during rproc_parse_fw() and rproc_load_segments().
For example, it can release carveouts mapped during these operations.

This operation is invoked in the following cases:
 - When an error occurs during remote processor boot.
 - When an error occurs during remote processor recovery start.
 - After stopping the remote processor.

This operation is required for the remoteproc_tee implementation following
a stop or upon encountering an error. Since the remoteproc image is loaded
during resource table parsing, multiple failure scenarios may occur prior
to remote processor startup, including issues with resource handling and
carveout allocation.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

---

Version 19 updates:
- Rewrite rproc_ops::release_fw documentation
- Improve commit message

Version 17 updates:
- Removed the rproc:load_fw() ops introduced in previous version.
- Removed duplicate calls to rproc_release_fw in rproc_fw_boot and rproc_boot.
---
 drivers/remoteproc/remoteproc_core.c     | 6 ++++++
 drivers/remoteproc/remoteproc_internal.h | 6 ++++++
 include/linux/remoteproc.h               | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index f7c96dbed189..1a3d646c99ab 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1857,6 +1857,8 @@ static int rproc_boot_recovery(struct rproc *rproc)
 
 	/* boot the remote processor up again */
 	ret = rproc_start(rproc, firmware_p);
+	if (ret)
+		rproc_release_fw(rproc);
 
 	release_firmware(firmware_p);
 
@@ -1998,6 +2000,8 @@ int rproc_boot(struct rproc *rproc)
 		}
 
 		ret = rproc_fw_boot(rproc, firmware_p);
+		if (ret)
+			rproc_release_fw(rproc);
 
 		release_firmware(firmware_p);
 	}
@@ -2067,6 +2071,8 @@ int rproc_shutdown(struct rproc *rproc)
 
 	rproc_disable_iommu(rproc);
 
+	rproc_release_fw(rproc);
+
 	/* Free the copy of the resource table */
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 0cd09e67ac14..c7fb908f8652 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -221,4 +221,10 @@ bool rproc_u64_fit_in_size_t(u64 val)
 	return (val <= (size_t) -1);
 }
 
+static inline void rproc_release_fw(struct rproc *rproc)
+{
+	if (rproc->ops->release_fw)
+		rproc->ops->release_fw(rproc);
+}
+
 #endif /* REMOTEPROC_INTERNAL_H */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 8fd0d7f63c8e..a2bb51a113b1 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -381,6 +381,10 @@ enum rsc_handling_status {
  * @panic:	optional callback to react to system panic, core will delay
  *		panic at least the returned number of milliseconds
  * @coredump:	  collect firmware dump after the subsystem is shutdown
+ * @release_fw:	Optional function to release resources allocated during
+ *		parse_fw() or load() operations. This function is called after
+ *		stopping the remote processor or in case of an error during the
+ *		boot or recovery sequence.
  */
 struct rproc_ops {
 	int (*prepare)(struct rproc *rproc);
@@ -403,6 +407,7 @@ struct rproc_ops {
 	u64 (*get_boot_addr)(struct rproc *rproc, const struct firmware *fw);
 	unsigned long (*panic)(struct rproc *rproc);
 	void (*coredump)(struct rproc *rproc);
+	void (*release_fw)(struct rproc *rproc);
 };
 
 /**
-- 
2.43.0

