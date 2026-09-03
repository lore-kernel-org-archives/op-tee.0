Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B036EC61DD3
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 17:58:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9D5DA4531D
	for <op-tee@archiver.kernel.org>; Thu,  3 Sep 2026 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788458301;
	bh=ivFP/CqzJy5BcJ7wk6VYBrwGQWwDogY4h0V5hmlgqLc=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=obhsUYcwsvu5j73erFzYOVBwyc4kt+OFBAU76KvU9ZitIJYMwi+3f2P8QVXis4VfP
	 UtVJIX0pHcsdzm2tAav7FCLdjn3HUu2+GoobKTtl9UKJdZZS0T2Ho37s2yD5+oSU5z
	 9uMeCasNlAltFI229Q4L2WO+6bqkc+x1oNYoZr/1UT6/5+/x3QIwP0P6RFKWu/CvjX
	 1HSLOQjiMxYRF5AblTJl/rCxdKp3N2s4ic5CFvaU2tpklR1dDD121t/XlWvlJNeUBp
	 JIHlZdNTIs6h8v9eJkdETvPnYo9bKtgm93ylGVDforHbr31ccBX8nzpglqlYAXAo5y
	 qaWZ5kjkE4DrA==
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AEE7444F76
	for <op-tee@lists.trustedfirmware.org>; Thu,  3 Sep 2026 17:58:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=i2YTd44x;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=pXZQ8qB0;
	dkim-atps=neutral
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 683G0iOM1342874;
	Thu, 3 Sep 2026 12:58:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=AmL4MP/ECjN6y
	afYgBXuVXAIA1vtIeDpjSVz2RBOGJ0=; b=i2YTd44x77+T93RN+l1aAJ0mBArKe
	qnNBmk4JFW/BUgtNdmcUPCTzBzfI5g1myHG7Jl63Ma4Fa3kKohWGeU+s1WQmn89E
	ls6/vQb4u75R8jDV9FM4v0lIHI9VnJ9bOG3n/SMzU4XsKcfcg9MCt1otw+EEsR3j
	OLXx/TKi6eMZ4P+vR0Mz61lHYVrwJj6II5FR9ukQuX4J6i7KBUpHTIQUFPsJv6OT
	9neMwg6m8D6II9eYqDV8/RbHCrg41Wxjw+eTSDh8Xwo86lZWEnAHT3f0N0RZNPrw
	+ZXbhmXjYaCBtzf8iwuTlMIwg7XmhV4jbnSTw5fpPWMk/gCXjefu1XBCA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gewt8p2dd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 12:58:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCMDTa5STWUUkqkKA8jLi3Kb4YYC28wIF/Y//cJTzkW0fdv7OQrKUHeWQMV9kuHDoeFLr5bv0dzkaIhung63DqxRVk/2guE1XaG13o6SFWW+QRIZDZRsQeCHvOeJz5+GdKQj2zO6Hgt6/5iPUqm3Dp/vKftyC5JPYU2WqPyYUgIDBGzoXdxhRVvdyP4mRvMy9oF2TGejZ6bo4rDaAl2FEYuhWmN00qqO4VZCzJvXg7zLMMBPZAVs1tq5S/fL2cxbM2JGiE7soO/JdII6BjEm+D7I0vsoaM/mSqTyOwH6P2sdJ0E/AUzd63l6E+UuUYWtaom7sTZKD6S2eIKs8eYpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmL4MP/ECjN6yafYgBXuVXAIA1vtIeDpjSVz2RBOGJ0=;
 b=NUgGmNRy+vGNeZhh3OhXKg957r3IE2cBRhmYs/pMsDw5AB9ASYlLTucKQry49J+JcrnvkEWi2cZ3N6nPjPcOzdm9mX8JNmJjNYdhHRjg7Do2u9bNgzgvqQs4tuJu25MIirQ0NhUVsdwTf0jCQKLNJoTa3Hu+MH4mbPgLHwchRsrCIl1FZ8w4Q7EkUIEskkWAlPR4iPFLfP/gIF82wUQ36WrJxfXy4kVcf6BoJ8Cc8ZJRjd0FpjELsYsjAuvLzruhRTxOEshfUI8waHVkZ2C8XljdlQ/N/j+mJKV6QPjvHbgfTgfMMe9aGLqWkOTy+jyb1gA82O9/sGpf+Vb9smtojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmL4MP/ECjN6yafYgBXuVXAIA1vtIeDpjSVz2RBOGJ0=;
 b=pXZQ8qB0F6T+3n1ZR8/wtvrQb3828tBA5eGqzm/6qc79OfyulSMVlxTDipgsLRD0ZTfIXUuN0UZ23G/EBO6H1XcyGR9bLlmegdDkakt6E+HJq67ZYWi7ztICtAsbFmQv4eNuz0nN5cxvHR4CJi2+lxn7hCEgV2MhUyj1bT1e7fg=
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by DM3PPF40B0653BC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 17:57:56 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::3f) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 17:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 17:57:55 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 12:57:31 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 12:57:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 12:57:31 -0500
Received: from ula0226330.dhcp.ti.com ([10.249.36.221])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 683HvVEc1984710;
	Thu, 3 Sep 2026 12:57:31 -0500
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg
	<sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tee: move tee_ioctl_shm_register_data to above IOCTL definition
Date: Thu, 3 Sep 2026 12:57:30 -0500
Message-ID: <20260903175730.1909952-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DM3PPF40B0653BC:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be9fbde-1023-4cdb-1bad-08df09e4e201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Kfnj2eBmoqMNdzsTA8CkdPCjnA/pNqtC4/OGsuydR5gHIeiPpsx3l/j7kUAV3byK9tYC4kjK3PJIjzF7vk44HvQJ2Xlo/wm2iM3y63ftg8tbuJGRexWGwDQyr+uBnICWLKoau76CJPczKajUf6+jhQcWDUZm/UnnM64+VQiui1SJnPCWO2aPawLOMP9TVVK4kspuQ53BtBM3iNn7jU0X8LaD+Fm9twxvTRHm5ta4RveZIHOiRqyuSGsGlc3kEqRA3rz+bpcu6Olh34v1dEOjxu5TeEQMQtpiw6vL11Ts/07nd/+dR5bk9P55v0UplxtJWurdf38JUo1PMaRNHlWUY7nJ6lRTECpZZko2lMeQRXVOOsiXxs5BBBgnWfBUyzTOxbmqC6TVZzz01fkAxZKb6o5WxtK4frcNwQyNQiNIUNrzvri8Owo1CKt+RSWlRCX4R/Q9GSnFgx1g40ajqbd7Qt55BMo3J5NYtz0zYTtaKkOD8RWXYgolsk9HedQmsyF97SPPx0/3W0/bkIFwzcxDH1xppdYkcpgmBDdp1+vDZydRjiyP7H2JL+0cnEn/5V6sY8bwLY1fsL7D4KMBlFp4uXvOgy9/1iIN292yQpWnn5MD6HOVgROpv6ge4LOXQOwtsotxPSKP+7TTbZhgniVw6jv9GDGM817RVwA3YGIPXW5Hc+Txzy1dL4YaYxbtxSmVArpEmcRUbvXOEspvd/HzMQ==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	3zXPu9c/zbOdzo+YyWoedyQnQBHyJNkOlXvStZLoHFOERUwjiA07z1+IR6J7qhVEqPzAwnbzYu+DJ5rBqNk547Swl4IlQ7onmXjL0mAkpC9b4jzYOUY074xohAYUo2i6QVl949kKCLNNGTA0dlF3+TNnA/BisJs30ONnyDhOZ2fnSeEz2E/kwHWsazSeFRfzIxOLkdWa3QVWKi50St1WLrdSOwmFcTw3Qp/aM1Q4EpYKeyfFZVwj6RWP2ScCwKsmU5uZPBNszKNfyiySIDHJjaQ3IdHIZn6uv3u52w988vQgIIV3pvvaYFVfId+mNQ+OaHY4SRqVF5vT/48D47f7Ax+FaAeYyQSNsqb7M6bqIw5XIrhX+NU+oRl+f1N1sauOWttiqevvmGxE4/4w1Zx3dsgmbL1vk8NyLT8u4csH+WgfJNVkT74Qzba/j1OCW+ik
X-Exchange-RoutingPolicyChecked: 
	0Bisk40dvWWvA6zpjyackZrOx6r0c9krmAbcx/b03xzHmcOrrQhEcR3hxHwfGCkhMY+nzaqDsBtJ85+dfQozUNe9vexOedg6MXybApouGbMAUIOs/FxHEnAP2P9uDYwSqNnv8v+/QpxVFKEaCiwhZSS5czKACT1DqTrY2k38EWFusgqrTeok/R5KM3pScf1PUJUHPPbjrec32YS5Yk1jb3fDb5FdsoQ7ztz92y1ygCG2y35Yo5eSnfJjZzncTNnLfTTzVhbJAOXb1rgazkoYsYQGlkQMh0rKWPGmjgqTY7FJSVJ00VwtA8vN1YOKJb8AQtTJpVOhJRl7+la7aYo06w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 17:57:55.7525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be9fbde-1023-4cdb-1bad-08df09e4e201
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF40B0653BC
X-Authority-Analysis: v=2.4 cv=de+wG3Xe c=1 sm=1 tr=0 ts=6a99b533 cx=c_pps
 a=zZ5onIKbzmoLkk/LR1Usmw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=yf5ehZLxDqhilrAfVTIA:9
X-Proofpoint-ORIG-GUID: 7lYq-xqbnhsfowXoMFELCUu8iFbj0Vdg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE1NyBTYWx0ZWRfXxSuR7dEO/WCO
 h21+WGqnrW9TsjGG8KldDfYLM4QJEl9WgVYaI3rzYUJ5nU8Sz4Qn20s91u+G7bSWvjDX5OxSR50
 IvM12GvR1tWryF360YXb7EHBo0OnfD8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE1NyBTYWx0ZWRfXx0ey2KB2HPhy
 xCMhEt5o/+8WpdtNv3e7/5ZgHFodb74TZxxcTTVo0Rmwaw5RGaHQz9v+fju6grtCADPOCVMjmG/
 V8pgGR+28+RqHnKBseLlZeidIKw2AYsHxmWH8yYDQHeOic3OACOjhWeb/LoT0ecg8c5ksYSh4x+
 rf+GxxNUzjCUm0806gripuntx85UEe/DruACcpYP3gQh7ubKzrss9xkMDegwGJL8rfORDIvYg20
 UnaN2jQARi4JUhcA658jGRcDfAqjKXvnNfOx9fZKN622Z7STf2lxe3PD2n9neLX8c+835cmp4ZS
 WAtjH3bHbn2PLlaoC6ktTnZSTenEah5D5ZEEoQDqsJ/v31c12ZUfzov0L1w1qeRxtlsHYEkQa7N
 J/htvvvedjNpanYdynezrt4jg74ktXzw7/T7cK5ltkoo7CXwooIBVCJlApCbzd7x6J4i+6GDw7d
 FUqMDfGLnvDTNaHJwiQ==
X-Proofpoint-GUID: 7lYq-xqbnhsfowXoMFELCUu8iFbj0Vdg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030157
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:148.163.150.75];
	R_DKIM_ALLOW(-0.20)[ti.com:s=proofpoint-05-2026,ti.com:s=selector1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:148.163.148.0/22, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.43.41:received];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ti.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[148.163.150.75:from];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AEE7444F76
X-Spamd-Bar: ---
Message-ID-Hash: EPW35JLI3CR44LLEDOMU7Z5BQKLNI7CX
X-Message-ID-Hash: EPW35JLI3CR44LLEDOMU7Z5BQKLNI7CX
X-MailFrom: afd@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Andrew Davis <afd@ti.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EPW35JLI3CR44LLEDOMU7Z5BQKLNI7CX/>
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

