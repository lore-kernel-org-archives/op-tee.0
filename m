Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8792DD65C73
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 15:40:27 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B51BF4FF33
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 15:40:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=JP5c52y3;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0954F41B70
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 15:40:07 +0000 (UTC)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BHFUGmo499675;
	Wed, 17 Dec 2025 16:39:56 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4b3de1m1mf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 16:39:56 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXe+eStgSpdtbHcTMlHHQKkCYcWGjbQHVYKkM4ZTnx+2Y+orm939NuTD29wHzXqQL4iXiQS4xFSveOZtXTHPU48yIs3gm5p7QGCMy9KN2ksop7ujGhRCgNaxUib1KQxaMct+P1QdR9NgGzOULV5GQE22FmTp3J2H8z/qtufxpY1kyiD8yZvhNFDCDwOeGkwiGyrUefzE0RkDoB9Mbx0ipGVgQAYLfScVY1vrHpNzjbaik4edeSxhq6bz+vRJQOp2MzYTC67+tLZy40OJkrxLe1ojIs6LC8Zik4bg5JYZJg+bOWC20xZ+0ddiyzcIPlEfyzKbx5YDGPt/jFAJZS4RJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvU0TwiJItTMqYadl8AqJJTIeGCTej1jA0kpxBiUUCI=;
 b=vrt/EFT7qDsAyfZefyzaiXxpnmf7S7GVQdxKAd4sfSxAZflsuZAtKzZmlthyDaI7Lom9Bv3f3oXJSClSrSe2U6OzBv9qrgBB/2SX8kPD5Qa4noLuQPbzJTuLslofDtbiU4wzAl0UrW0at3uLWvjAHV3DsPg96fDJFB4y6aMmkvZfAuLpyJNUeOhqA221ppfH3eLJqpuX2zGg1FEpeehLj5XA6GiKp1AGdaoy/xaiE2uK2WPRmqza0B9SbMn/eXUf+jwlBkMJOFqtUS0vdfxY31ozcqRDoZ3iQ9MJSlhy58lrEE3XXFkWzKtELzXT+By5/U/NvXQV8LxnJrOaAohl2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvU0TwiJItTMqYadl8AqJJTIeGCTej1jA0kpxBiUUCI=;
 b=JP5c52y3zq51jHZHLWLMv9C6YL+O10+X7dtU2ClGVB7oLTDkYYU4qAf3jJZEJ34zhofFIatRTl7vfXUlY1iiGyYO+T2QIGZDmIBBk5gmLmrsQVYMIM8ntLOJSXlVpZxG7Xwu/Y/M7vdpYec0TTkKejZQkjqUNUGCBf0nVomak9I69qfRWBYEXKrToEUsHi8JFZUReyj5IQbeQ9BeQVCHQvuE5D1+YAa2z/RqpJOWbgl687FUQiY/zZFhCCrLpdUdIMBuQSX4unaeZjgYduKPutbATr+QseDZ7OIpjQF55jzjmsNYoTSVrkvRLLhTrk3l4sTZSgUIZO9gmszWeMUioQ==
Received: from AS9PR06CA0461.eurprd06.prod.outlook.com (2603:10a6:20b:49a::12)
 by AS8PR10MB7231.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:619::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 15:39:54 +0000
Received: from AM2PEPF0001C70D.eurprd05.prod.outlook.com
 (2603:10a6:20b:49a:cafe::a) by AS9PR06CA0461.outlook.office365.com
 (2603:10a6:20b:49a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 15:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF0001C70D.mail.protection.outlook.com (10.167.16.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 15:39:53 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:40:37 +0100
Received: from localhost (10.48.87.127) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 16:39:52 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v20 1/6] dt-bindings: firmware: Add TEE remoteproc service binding
Date: Wed, 17 Dec 2025 16:39:12 +0100
Message-ID: <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70D:EE_|AS8PR10MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3c8c8a-2055-4b37-20f1-08de3d828609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?T5/G8WbgQekMePmqYcASZCBl343XH+nb89ba5MXYHlLpFQde/ba63HXZIxPE?=
 =?us-ascii?Q?49M64NK4xNBtxioAgmrhADKwFMt1OZXbohvku0zGph5wKU74pF8SLBZHXV38?=
 =?us-ascii?Q?ZIOuLVWFjvmF6FLZCEBpK7RuLgLiw+hTmHSmVsX3bJZeFL9keA7a/rtUl2DB?=
 =?us-ascii?Q?eRhgiehayHbCKAnNTuhmHIsx0/95d2dV5CdYnWPFGyM7Tp87FyXqfj6NG93E?=
 =?us-ascii?Q?hl6gBhob5ilgj2Li4JmJZrwx/pRhcsEceh8hlMYnKdqbCmLBiLtfi67Yv/SV?=
 =?us-ascii?Q?KUrbkIxtkwv2hv8u9O/poxG9Q1nNDo5wWo5RCxFo471dB15HCjMlZ8xyYirR?=
 =?us-ascii?Q?yGOlfyUlr1RL2WTChlswIQsvSCQZZf8oJXMn4YaKmr/e00HhitPTWZWqLRRk?=
 =?us-ascii?Q?8uEnzsz+3tvE+zlltJIxkNSqlSOp4T/MRUXy7tPr4Euw9vU3CleGISgBm4Fw?=
 =?us-ascii?Q?QCuW0PCjfurfehP5ntWvdAX5GhFbmOTviROow1/fSKPYqh7wqyN4jfZq/oSQ?=
 =?us-ascii?Q?fpfERySJQ2/H+4W1byPq3G3qD8Q9nQ9BaotMgwzAxE8+T+EyDXr6kYsy6/eH?=
 =?us-ascii?Q?+4NBtvxnmwT6LK/GM1qKI2kMo+S92AzzisddP7QecS5HiRv/OUBXGeVc3LBP?=
 =?us-ascii?Q?fGjmRJcbMLoySzEP1+QYWdzMzy0t5iiRQ4+qVyn8Q6oLcIET41VpviiNvTEY?=
 =?us-ascii?Q?ioQR+9vX/Y0SAHIYCRbl58GnZon49kDJQLETre5EbW7rnqx/HoYk0uglUUd2?=
 =?us-ascii?Q?1cEVWl+I7Nby1MF9y6AHku3bdp+SKSvevuesNwuy6WS8wKcIOyMYyUd4xYXz?=
 =?us-ascii?Q?Ttt3nJya4H67egNBL/+NcqdKfAZmaqLcFDHF+11NbimriQmGKM9ZYedk1Yq8?=
 =?us-ascii?Q?FxwQCT0yUrAKSbo+BBxTafjAnw41LwLaELcT0vdIIkaZ+q+uglFbxFnMmnVI?=
 =?us-ascii?Q?TNklr3TtG+E6/G9GSsk3JlQo36qOv75mE254WVgeaRUU3DGwwDYPya0MLgg0?=
 =?us-ascii?Q?yB7MQu/jRixPCllT+qbZtdAJ++BWIiEjVRFzn2VuoxSl8JEZwH78P0Q41QPZ?=
 =?us-ascii?Q?nJZlIX3RhqIsZVSg1dquIcMoUM5XIX0bhLcwC9MuPiaTZbu5XfrY+zGILt/x?=
 =?us-ascii?Q?MicQtSMMV4VWtwFMlOrFVhJ8e3SWYK8DNwYOM3n0QEXjEZ4KFX1ucUeBkU6r?=
 =?us-ascii?Q?yR4jmMHNOvpSqPq0AfS2SBZE2oZg4Xj2YK3jQeR2M8/KDG7wDqJMh7ofIhzW?=
 =?us-ascii?Q?gQe15qegynNmrlGJ9dcaajmCP9CscEKptn9W9apLwOLvHxbaz8knvJ7kXOqa?=
 =?us-ascii?Q?3dr0VnDjifadFXxfleBU4M9E29lfGsWZxTb2UQAeHkwAt0gYE5bTbGwwIvR8?=
 =?us-ascii?Q?wt51z5DPDJkyBKjgWuTrcBOHUeNKOuRkksL2rhpLCFdt2EljRGDgIA86vLD3?=
 =?us-ascii?Q?m26C0XPnWO5qojrcpR9oAknyzUiVWMmw7plqGt9XgtDokrqjz4oJrF8xF/n2?=
 =?us-ascii?Q?cVb7YANAb1+yozg=3D?=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:39:53.6146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3c8c8a-2055-4b37-20f1-08de3d828609
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM2PEPF0001C70D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7231
X-Authority-Analysis: v=2.4 cv=JeOxbEKV c=1 sm=1 tr=0 ts=6942cecc cx=c_pps
 a=Ye+NqXUjxnSxkpZHLj4hLw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FOPVHIcnkjUA:10 a=wP3pNCr1ah4A:10
 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gEfo2CItAAAA:8 a=8b9GpE9nAAAA:8 a=MdngEct1hBrlLFZYPjYA:9
 a=sptkURWiP4Gy88Gu7hUp:22 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: 1wJA3yjZtpCkFf2bmh_YLNTEovVwyZPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDEyMyBTYWx0ZWRfX8UEa8sAi0bvH
 ci2MaOLoLt5y2a+8/n7QM3kwPfwTEq3sys7VTv1gg0d5+qtEfqKlHUB6gzCZ0VyhFD+dOO6f2qm
 NJVSaAdPJXWSt1sREq2pblBTGg7Qu2MMZGHhfjmu0w4L7vNTG3cXJoqZbPiZ5+dDN44BQGa9bC6
 dxYIixG0jJCwrY7YJRbGB9qzDPNVNF/ZhClHhMfBK6QIctf+IqO2Ej2IW6z3lp1h33wHMaKG0/N
 JBBdhTDt4A8h+7iontCHNn8OCJbaQzFN1HvWruUoIMeUA8x2yBpQxSokpM6mqMp+ozqImba/pb2
 eNt6APlioWXNyxEeYACXFGnXASONi7plsVWYfVuFv/TCk+jgrYMuf0ciXUmQdauRKpvFNA3pZOe
 g5YhAfpcgVwT4qLrZYtNjOsMt/E4zw==
X-Proofpoint-ORIG-GUID: 1wJA3yjZtpCkFf2bmh_YLNTEovVwyZPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512170123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.97 / 15.00];
	BAYES_HAM(-2.87)[99.45%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:91.207.212.93:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	RCVD_IN_DNSWL_LOW(-0.10)[91.207.212.93:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[foss.st.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:52129, ipnet:91.207.212.0/23, country:US];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:49a::12:received,2603:10a6:20b:49a:cafe::a:received];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	ALIAS_RESOLVED(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[91.207.212.93:server fail,164.130.1.60:server fail,2603:10a6:20b:49a:cafe::a:server fail,2603:10a6:20b:49a::12:server fail,52.101.66.38:server fail];
	FORGED_SENDER_VERP_SRS(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0954F41B70
X-Spamd-Bar: -
Message-ID-Hash: MLILVOW2FTHIC7IKD2G2BRFJU25QPTTV
X-Message-ID-Hash: MLILVOW2FTHIC7IKD2G2BRFJU25QPTTV
X-MailFrom: prvs=4446e2e4b6=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MLILVOW2FTHIC7IKD2G2BRFJU25QPTTV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Add a device tree binding for the TEE-based remote processor control
service implemented as an OP-TEE Trusted Application identified by
UUID 80a4c275-0a47-4905-8285-1486a9771a08.

The TEE service node is a child of the "linaro,optee-tz" firmware node and
acts as a container for remoteproc devices that are controlled via TEE.

In addition, the "linaro,optee-tz" binding is updated to specify the
'#address-cells' and '#size-cells' values used for child TEE service
nodes.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
 .../arm/firmware/linaro,optee-tz.yaml         |  6 +++
 .../bindings/remoteproc/remoteproc-tee.yaml   | 47 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml

diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
index 5d033570b57b..ab69eecba9ad 100644
--- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
+++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
@@ -41,6 +41,12 @@ properties:
       HVC #0, register assignments
       register assignments are specified in drivers/tee/optee/optee_smc.h
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
 required:
   - compatible
   - method
diff --git a/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml b/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
new file mode 100644
index 000000000000..083ecf1f38cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/remoteproc-tee.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/remoteproc-tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TEE Remote Processor Control Service (UUID 80a4c275-0a47-4905-8285-1486a9771a08)
+
+maintainers:
+  - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
+
+description: |
+  Node describing a TEE-based remote processor control service implemented as
+  a Trusted Application identified by UUID 80a4c275-0a47-4905-8285-1486a9771a08.
+
+  It is a child of the OP-TEE firmware node ("linaro,optee-tz") and acts as a
+  container for child remoteproc devices (for example, the STM32MP15 M4 core
+  described by "st,stm32mp1-tee").
+
+properties:
+  compatible:
+    const: rproc-service-80a4c275-0a47-4905-8285-1486a9771a08
+
+  reg:
+    description: |
+      Logical identifier of the TEE remoteproc service instance.
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^[a-zA-Z0-9,._-]+@[0-9a-fA-F]+$":
+    type: object
+
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+...
-- 
2.43.0

