Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772E4CD5BAC
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:40:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 96FF944DA2
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779374451;
	bh=TOGa4Zz567M86408CcVlKEAOc4HYKDfC0/Zr179gYy0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=P0m5vkXbYWNC6w1gUUhD1cBFz+I7OkDh1yE0Y888Ke1kyG4mT93OniEMhC3oecTXJ
	 6ODwgv+eM6G93p+wMWg220H5Sb47BpP9De9XF22BLiLr+c3ckorIQlEGff8criCPBm
	 vX+QGG7j8DCjoSHDhnum21LLhnKPjavuIwVpQnku7B2FwddgAYzaE5FxGsIT9NXGcY
	 RIhOPhQFD0ocpwPbAuLw9qu4CUkXDLVMro0a2v7ziBbO7/05QN/mqNBhDeBDF/ZivR
	 ze981PFZx2uCaTa4Y3FqYWCW+/6lDPE78wk003fbBIsbmyIdSY3bGCNCpgwB0ywcen
	 8MoW4PltK4dLQ==
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2648F43824
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 14:40:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=selector1 header.b=hZc9xUuA;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ii4ykBB5G9A6kyMz5U2N1aXHY1PtJXKjZjaTM0D4SuzqYo+K5+3mrI62fogis0/iMBbHvdMbGUyOVqHNQQpkAjTAMpKFOkK0KCVyg0WS0vnC/v1TVXv19VQyNWYFMY9cDJqCNNy3JwLUS9bxS0YKN1NphUK5hMFwJCGLNcraceB8CYvCXwvUksoYW0FeyJV9bF07tLXZnL7mKaXV6WJp/6P4IfabzUrv79v8adgL75K2bTCgQ7HrUV0Zbpq16n/wfMeWKlWBkCNwVNVa8X6cOStom5vTaHWy2J6XyB1TQbqjUmS1pJ8APbOXwDI3udQ2Tr1O3oyuYjqu6jYTln7WnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlfqV3T78QCHUWQoLQG2jLHS/PfQDvsT68XOLgwySIw=;
 b=GFsIWTkz+aBWp3I8RqRAshHQw3gt+mz2COCJXLQYUB1TtftvC2Bknl7YjHn8c7PZigaVywcYylPDGVh3Jdw1cpyrYF/PWy653rUPo/OQEdtMox+iKC3TnGkzjUFpFJpw6/4EDCt5D+vrSvKQWvBsec75KmLIr3AQZL9+lDVKCsXzMiwdL8HAI3MpaxO1wBehjopumgum+sy1u+wXSbJyOJqtvI2kxQGY75uRrS4DOso8MOyNIvfjKq8oaQJqsRmRtv0EcZquC0BymCp3CKJw+96/90z3ZkNC/LIbF7q8gZJiLSUV6joJM9VLRmreT4IgOibigoMeFS8jj+kyaJ2iEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.trustedfirmware.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlfqV3T78QCHUWQoLQG2jLHS/PfQDvsT68XOLgwySIw=;
 b=hZc9xUuAlWZRF/mZAN022GzG+soz2C3u8gMkt8rvzcDiybr7ky/95vcYUd5lZ5Z2l/mMzdqKMyreBISOa93GR9UsNriSNCrgTnMpSOIsWKD+GqBFlFTLeD/6d9G8T9ndmgjjNLnGDejhSmzNOk5vwSqYUsy5b1EGLFj2XXqLmSI=
Received: from PH8P220CA0057.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::17)
 by DS7PR10MB5200.namprd10.prod.outlook.com (2603:10b6:5:3a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 14:40:39 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:2d9:cafe::76) by PH8P220CA0057.outlook.office365.com
 (2603:10b6:510:2d9::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 14:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.0 via Frontend Transport; Thu, 21 May 2026 14:40:39 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 09:40:38 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 09:40:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 21 May 2026 09:40:38 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64LEec1w3759122;
	Thu, 21 May 2026 09:40:38 -0500
Message-ID: <1d77eb52-cde1-461e-a529-a430f9cd8505@ti.com>
Date: Thu, 21 May 2026 09:40:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dma_heap and protected memory
To: Jens Wiklander <jens.wiklander@linaro.org>, Amirreza Zarrabi
	<amirreza.zarrabi@oss.qualcomm.com>
References: <75d61a22-7c36-434a-a9f2-80533090e072@oss.qualcomm.com>
 <CAHUa44EG8b74NgdHW=QhKBtKd7e0_xWqQTkZA9tZxEOHenY_AQ@mail.gmail.com>
 <cd6caaef-032e-4679-88b3-2f242c28b00f@oss.qualcomm.com>
 <CAHUa44EepbbkhnxkkqfUXWoPROeM85Ziw6NYhzjRtFXD+C0iuQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44EepbbkhnxkkqfUXWoPROeM85Ziw6NYhzjRtFXD+C0iuQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|DS7PR10MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 38af1e33-6f8d-4389-4aef-08deb746ed66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|6133799003|5023799004|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	vQeRBn9OkdaSth+6k2ixOQd2/z9H9msYSBkp3Fcr2wlNA8p9Psy+B6ixgvUKVCaPo8x3W2FCMOeNtvBtVL1CpAzgk6NyNZdVn7GVtMCvmzuhEiPxlQsNjFJJgux4BqFQ08CLCeB2hXnj9z+GW8FTH3nE+QPVSv41i0OQm0P9JCf+f8FGMzFflUcbwMhqYcDyNkjDDt9SYWbIpaeV4y9BQfPyaxqIN/jLneWUNszSBW8F96t2xjNA1eiQw6tTzD5vbTr/jLVX4qWTNyEQ45+nsJ7ofchXrZkxKfCxV6Y3ky3E7rtfqi6p/Y+xfw3hiP3tm1Pv7dPVmeS+X5vis4P+HY8+v9omLcyLHhpoiadBw+gBK/e+3uZaabUP5sxUM6TUGW7xqgrd1TI6/37slRCeKQEgdKBBJkUTGGv1Wnq0P4CPrfaEsZHJYEI+kgUBNTF7VpQ3Z1jbNMHyUOKvZd5ZOZ9ggf/Yj0l5E7qZ/n0i/IToZ3eY44AUdJQo91dtwbd1wevunjKNNW7k6jGGq0JHTvq7zns3cCsjLLGDGko3tcEvgbO5yd/uZXYuz5w67FkWsQ0rUOStC1XNxESH3QpRb9rHRAAxMiOndVpNAqJnoGs29SdhAk/T6adwif9UvOU2IWzl1zpDpF/qQ0yrbv0K8X7yctXI2KPh/MNhGrDapzT7bn02Xe7EFkSz71ktPWAqgQvKYl54fQNLosNJ1jJ2IszioNJ9NeDIxpjAYFu6pu8=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(5023799004)(4143699003)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ol+Jen2gbIAk1mizXFaai4U8h3rhVsRVo9HMW77Ya9Nhdue89iBY9dcNONV1Xr9sMwgu6AaS9ixpei5xrCjjR6THCLYPn5yUOrRm7xH6IvT/vKVTwmTXGnlq8YW42Kb4ZjyzeItkpet/0zsVI/JWqTBC5/k+RRYODkxP1BWRBNeH/uO4naVvTmO1oqmPvC7nxlnqnNHxOG2dkAFpu201wKgzZ1T1WHTiynGdjmtk0g+jzmFaMkGwqWCjVt2YzmhdKk1GTthvGJc/QnCXjMIPs3bAZkFa698KxaDHKS8+smGe0SHtqeOIUYUM2GyTcggBNccd8INF0tIz7L8Xc+/N0GhTb5mcVZTHp7nmclmf/oSzdDk6V9n8gzEiUTgePtZ44athqyiOVrs+0d32V3VrzqZKjbiu4BcK0AxjG5DXVGmJ1bbO0bGPbk5otVG/8m+h
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:40:39.0275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38af1e33-6f8d-4389-4aef-08deb746ed66
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:microsoft.com:reject}];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.43.71:from];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.43.71:from];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2648F43824
X-Spamd-Bar: --
Message-ID-Hash: 37D6JHZH3L72WNZCUYIKNYWQGZDDK567
X-Message-ID-Hash: 37D6JHZH3L72WNZCUYIKNYWQGZDDK567
X-MailFrom: afd@ti.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/37D6JHZH3L72WNZCUYIKNYWQGZDDK567/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Andrew Davis via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Andrew Davis <afd@ti.com>

T24gNS8yMC8yNiA2OjE4IEFNLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gSGkgQW1pciwNCj4g
DQo+IE9uIFdlZCwgTWF5IDIwLCAyMDI2IGF0IDk6MTDigK9BTSBBbWlycmV6YSBaYXJyYWJpDQo+
IDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPj4NCj4+IEhpIEpl
bnMsDQo+Pg0KPj4gT24gNS8yMC8yMDI2IDE6MjkgQU0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
Pj4+IEhpIEFtaXIsDQo+Pj4NCj4+PiBPbiBGcmksIE1heSAxNSwgMjAyNiBhdCA1OjEw4oCvQU0g
QW1pcnJlemEgWmFycmFiaQ0KPj4+IDxhbWlycmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+
IHdyb3RlOg0KPj4+Pg0KPj4+PiBIaSBKZW5zLA0KPj4+Pg0KPj4+PiBSZWNlbnRseSBwcm90ZWN0
ZWQgaGVhcCBzdXBwb3J0IGhhcyBiZWVuIGFkZGVkIGZvciB0aGUgVEVFIHN1YnN5c3RlbS4NCj4+
Pj4gVGhpcyBhbGxvd3MgZG1hLWhlYXBzIHRvIGJlIG1hbmFnZWQgYnkgdGhlIFRFRSBzdWJzeXN0
ZW0gaXRzZWxmLg0KPj4+Pg0KPj4+PiBGb3Igc3RhbmRhcmQsIG5vbi1wcm90ZWN0ZWQgaGVhcHMg
c3VjaCBhcyB0aGUgc3lzdGVtIGhlYXAgb3IgQ01BIGhlYXAsDQo+Pj4+IEkgYW0gdHJ5aW5nIHRv
IHVuZGVyc3RhbmQgdGhlIGV4cGVjdGVkIHVzYWdlIG1vZGVsLiBPbmUgcG9zc2libGUgd29ya2Fy
b3VuZA0KPj4+PiBhcHBlYXJzIHRvIGJlIHRvIG1tYXAgdGhlIGRtYS1idWYgZmQgaW4gdXNlcnNw
YWNlLCB0aGVuIHJlZ2lzdGVyIHRoZQ0KPj4+PiByZXN1bHRpbmcgdXNlcnNwYWNlIFZBIHdpdGgg
dGhlIFRFRSBzdWJzeXN0ZW0gdG8gb2J0YWluIGEgVEVFIHNoYXJlZC1tZW1vcnkNCj4+Pj4gb2Jq
ZWN0LCBmb3IgZXhhbXBsZToNCj4+Pj4NCj4+Pj4gZmQgPSBkbWFfaGVhcF9hbGxvYyguLi4pOw0K
Pj4+PiB2YSA9IG1tYXAoZmQsIC4uLik7DQo+Pj4+DQo+Pj4+IHNobV9mZCA9IHRlZV9zaG1fcmVn
aXN0ZXIodmEsIHNpemUpOw0KPj4+PiB0ZWVfaW52b2tlKHNobV9mZCk7DQo+Pj4+DQo+Pj4+IGNs
b3NlKHNobV9mZCk7DQo+Pj4+IG11bm1hcCh2YSwgc2l6ZSk7DQo+Pj4+IGNsb3NlKGZkKTsNCj4+
Pj4NCj4+Pj4gVGhpcyBzZWVtcyByZWFzb25hYmxlIHdoZW4gdGhlIGxpZmV0aW1lIG9mIHRoZSBy
ZWdpc3RlcmVkIHNoYXJlZCBtZW1vcnkNCj4+Pj4gaXMgbGltaXRlZCB0byBhIHNpbmdsZSBpbnZv
Y2F0aW9uIG9yIGNhbGxiYWNrLiBIb3dldmVyLCBJIGFtIGNvbmNlcm5lZCBhYm91dA0KPj4+PiBj
YXNlcyAobXVsdGlwbGUgZXhpdHMgaW4gcWNvbXRlZSkgd2hlcmUgdGhlIFRFRSBzaWRlIG5lZWRz
IHRvIHJldGFpbiBhY2Nlc3MNCj4+Pj4gdG8gdGhlIG1lbW9yeSBhZnRlciB0aGUgaW9jdGwvaW52
b2NhdGlvbiByZXR1cm5zLg0KPj4+Pg0KPj4+PiBJbiB0aGF0IGNhc2UsIHJlZ2lzdGVyaW5nIG9u
bHkgdGhlIHVzZXJzcGFjZSBWQSBkb2VzIG5vdCBhcHBlYXINCj4+Pj4gdG8ga2VlcCB0aGUgdW5k
ZXJseWluZyBkbWEtYnVmIG9iamVjdCBhbGl2ZS4gVGhlIFRFRSBjb3JlIHBpbnMgdGhlIHBhZ2Vz
LA0KPj4+PiBidXQgaXQgZG9lcyBub3QgaG9sZCBhIGRtYS1idWYgcmVmZXJlbmNlIG9yIGF0dGFj
aG1lbnQuIElmIHVzZXJzcGFjZSBsYXRlcg0KPj4+PiBjbG9zZXMgdGhlIGRtYS1idWYgZmQgYW5k
IHVubWFwcyB0aGUgVkEsIHRoZSBkbWEtYnVmIGV4cG9ydGVyIG1heSBjb25zaWRlcg0KPj4+PiB0
aGUgYnVmZmVyIHJlbGVhc2VkLCB3aGlsZSB0aGUgVEVFIHNpZGUgbWF5IHN0aWxsIGhhdmUgdGhl
IG1lbW9yeSByZWdpc3RlcmVkLg0KPj4+DQo+Pj4gVGhhdCdzIHN1cnByaXNpbmcuIEFyZSB0aGUg
cGFnZXMgcmV0dXJuZWQgdG8gdGhlIGhlYXAgYWxzbz8gSWYgc28sDQo+Pj4gdGhlcmUncyBhbiBp
c3N1ZS4NCj4+Pg0KPj4NCj4+IFllcywgdGhhdCBpcyBteSB1bmRlcnN0YW5kaW5nLiBGb3IgZG1h
LWhlYXBzLCBhZnRlciB0aGUgZmluYWwgZG1hLWJ1Zg0KPj4gcmVmZXJlbmNlIGlzIHJlbGVhc2Vk
LCB0aGUgZXhwb3J0ZXIgaXMgZnJlZSB0byByZXR1cm4gdGhlIGJhY2tpbmcgcGFnZXMgdG8NCj4+
IHRoZSBoZWFwLg0KPiANCj4gVGhpcyBzaG91bGQgYmUgYSBnZW5lcmljIHByb2JsZW0uIFN1cmVs
eSB0aGVyZSBtdXN0IGJlIHNvbWV0aGluZyB0bw0KPiBzdG9wIHRoZSBleHBvcnRlciBmcm9tIHJl
dHVybmluZyB0aGUgcGFnZXMuDQo+IA0KDQpUaGlzIGlzIGEgc3RhbmRhcmQgdXNlLWFmdGVyLWZy
ZWUgaXNzdWUuIFRoZSBhYm92ZSBzZXF1ZW5jZSB3b3VsZCBiZToNCmFsbG9jYXRlIGEgYnVmZmVy
IGZyb20gdGhlIEhlYXAsIG1tYXAgaXQgdG8gZ2V0IGEgVkEsIHNhdmUgdGhlIFZBIChlaXRoZXIN
CmxvY2FsbHkgb3IgZ2l2aW5nIGl0IHRvIHRoZSBURUUgZnJhbWV3b3JrKSwgdGhlbiB1bm1hcCBh
bmQgY2xvc2UgdGhlIGRtYS1idWYsDQpURUUgdHJpZXMgdG8gdXNlIHRoZSBWQS4gVGhpcyB3b3Vs
ZCBiZSBhbiBpc3N1ZSBubyBtYXR0ZXIgaG93IHlvdSBhbGxvY2F0ZWQNCnRoZSBtZW1vcnksIGRv
bid0IGZyZWUgbWVtb3J5IHN0aWxsIGJlaW5nIHVzZWQuDQoNCkJ1dCB0aGUgY29yZSBxdWVzdGlv
biBpczoNCg0KPiB3aGVyZSB0aGUgVEVFIHNpZGUgbmVlZHMgdG8gcmV0YWluIGFjY2VzcyB0byB0
aGUgbWVtb3J5IGFmdGVyIHRoZQ0KPiBpb2N0bC9pbnZvY2F0aW9uIHJldHVybnMuDQoNCkZvciB0
aGlzIGNhc2UsIGFyZSB5b3UgdGFsa2luZyBhYm91dCB3aGVuIHRoZSBURUUgbmVlZHMgdG8ga2Vl
cCBtZW1vcnkNCnBhc3Qgb25lIGludm9jYXRpb24gZm9yIGEgd2hvbGUgc2Vzc2lvbiBvciBmb3Ig
ZXZlbiBsb25nZXIgdGhhbiB0aGF0Pw0KKHN1Y2ggYXMgYSBzdXBwbGljYW50IGhlbHBlciBhbGxv
Y2F0aW5nIG1lbW9yeSBmb3IgYSBsb25nIHJ1bm5pbmcgVEVFL1RBDQpwcm9jZXNzKQ0KDQpGb3Ig
ZWl0aGVyIGNhc2UgdGhlIG93bmVyc2hpcCBvZiB0aGUgYnVmZmVyIG11c3QgcGFzcyB0byB0aGUg
VEVFIGZyb20NCnRoZSBhcHBsaWNhdGlvbiwgYW5kIHRoYXQgaXMgc29tZXRoaW5nIHdlIHdvdWxk
IG5lZWQgdGhlIGFiaWxpdHkgdG8NCnJlZ2lzdGVyIGdlbmVyaWMgRE1BLUJVRnMsIHNvIGFkZGlu
ZyB0aGlzIHN1cHBvcnQgZG9lcyBzZWVtIHZhbGlkLg0KDQo+Pg0KPj4+Pg0KPj4+PiBJcyB0aGVy
ZSBhIHJlY29tbWVuZGVkIHdheSB0byB1c2Ugc3RhbmRhcmQgaGVhcHMsIHN1Y2ggYXMgdGhlIHN5
c3RlbSBvcg0KPj4+PiBDTUEgZG1hLWJ1ZiBoZWFwcywgd2hlbiB0aGUgc2hhcmluZyBsaWZldGlt
ZSBpcyBsb25nZXIgdGhhbiBhIHNpbmdsZSBURUUgY2FsbD8NCj4+Pg0KPj4+IE5vLCBJIHRoaW5r
IHlvdSdyZSBwaW9uZWVyaW5nIHRoaXMuDQo+Pj4NCj4+DQo+PiA7LSkuDQo+Pg0KPj4+Pg0KPj4+
PiBXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGV4dGVuZCB0ZWVfc2htX3JlZ2lzdGVyX2ZkKCkgc28g
dGhhdCBpdCBjYW4gaGFuZGxlDQo+Pj4+IGRtYS1idWYgZmRzIGZyb20gcmVndWxhciBkbWEtaGVh
cHMgYXMgd2VsbCwgbm90IG9ubHkgZG1hLWJ1ZnMgbWFuYWdlZCBieQ0KPj4+PiB0aGUgVEVFIHN1
YnN5c3RlbT8gVGhhdCB3b3VsZCBhbGxvdyB0aGUgVEVFIGNvcmUgb3IgYmFja2VuZCBkcml2ZXIg
dG8ga2VlcA0KPj4+PiB0aGUgZG1hLWJ1ZiByZWZlcmVuY2UgZm9yIHRoZSBsaWZldGltZSBvZiB0
aGUgVEVFIHNoYXJlZC1tZW1vcnkgb2JqZWN0Lg0KPj4+DQo+Pj4gSXQgc2VlbXMgbGlrZSBhIHdv
cmthcm91bmQsIHNpbmNlIEkgYXNzdW1lIHRoYXQgdGhlIHB1cnBvc2UgaXMgdG8NCj4+PiBzaGFy
ZSBtZW1vcnkgYmV0d2VlbiB0aGUgdXNlciBzcGFjZSBwcm9jZXNzIGFuZCB0aGUgVEVFLiBJIHRo
aW5rIHRoaXMNCj4+PiBtaWdodCBiZSBhIGxhc3QgcmVzb3J0IG9yIHNvbWV0aGluZy4NCj4+Pg0K
Pj4NCj4+IFllcywgSSBhZ3JlZS4NCj4+DQo+PiBUaGUgc3BlY2lmaWMgY2FzZSBJIGFtIGxvb2tp
bmcgYXQgaXMgcWNvbXRlZSB3aXRob3V0IGFuIEZGLUEgYmFja2VuZC4gSW4NCj4+IHRoYXQgY29u
ZmlndXJhdGlvbiwgcWNvbXRlZSBjdXJyZW50bHkgcmVxdWlyZXMgcGh5c2ljYWxseSBjb250aWd1
b3VzIHNoYXJlZA0KPj4gbWVtb3J5LCBzbyByZWdpc3RlcmluZyBhbm9ueW1vdXMgdXNlcnNwYWNl
IG1lbW9yeSBpcyBub3QgdmVyeSBwcmFjdGljYWwuDQo+IA0KPiBBZ3JlZWQuDQo+IA0KPj4NCj4+
IFRvZGF5IHRoZSBxY29tdGVlIHNoYXJlZC1tZW1vcnkgcG9vbCBpcyBpbXBsZW1lbnRlZCBvbiB0
b3Agb2YNCj4+IHRlZV9keW5fc2htX2FsbG9jX2hlbHBlcigpLCB3aGljaCBhbGxvY2F0ZXMgbWVt
b3J5IGZyb20gdGhlIG5vcm1hbCBwYWdlDQo+PiBhbGxvY2F0b3IuIFRoaXMgbWFrZXMgbGFyZ2Vy
IGFsbG9jYXRpb25zIHN1YmplY3QgdG8gdGhlIHVzdWFsIGhpZ2gtb3JkZXINCj4+IGFsbG9jYXRp
b24gLyBNQVhfT1JERVIgbGltaXRhdGlvbnMuDQo+Pg0KPj4gT25lIG9wdGlvbiB3b3VsZCBiZSB0
byBtb3ZlLCBvciBleHRlbmQsIHRoZSBxY29tdGVlIHNoYXJlZC1tZW1vcnkgcG9vbCB0byB1c2UN
Cj4+IGEgY21hIGJhY2tlZCBhbGxvY2F0aW9uIHBhdGguIFRoYXQgd291bGQgYWRkcmVzcyB0aGUg
ZGVmYXVsdCBhbGxvY2F0aW9uIGNhc2UNCj4+IHRocm91Z2ggVEVFX0lPQ19TSE1fQUxMT0MgKHdp
dGhvdXQgcmVzdHJpY3Rpb24pLg0KPiANCj4gQ01BIG1haW50YWluZXJzIG1pZ2h0IGhhdmUgYSB2
aWV3IG9uIHRoYXQuDQo+IA0KPj4NCj4+IEhvd2V2ZXIsIEkgYW0gd29uZGVyaW5nIHdoZXRoZXIg
aXQgaXMgYmV0dGVyIHRvIGFsc28gYWxsb3cgdXNlcnNwYWNlIHRvIGNob29zZQ0KPj4gdGhlIHNv
dXJjZSBvZiB0aGUgbWVtb3J5LCBmb3IgZXhhbXBsZSB3aGVuIHRoZSBtZW1vcnkgbXVzdCBjb21l
IGZyb20gYSBzcGVjaWZpYw0KPj4gY2FydmVvdXQgb3IgZnJvbSBhIGNtYSBkbWEtaGVhcCBzZWxl
Y3RlZCBieSB0aGUgY2xpZW50Lg0KPj4NCj4+IElmIHlvdSBmZWVsIGl0IGlzIG5vdCBhIGNvcnJl
Y3QgZGlyZWN0aW9uLCBJIHRvdGFsbHkgdW5kZXJzdGFuZCBjb25zaWRlcmluZw0KPj4gaXQgaXMg
d29ya2Fyb3VuZCBmb3IgYSBsaW1pdGF0aW9uLg0KPiANCj4gSXQgaGFzIGFuIGFkdmFudGFnZSBi
eSBtb3ZpbmcgdGhlIHByb2JsZW0gdG8gdXNlci1zcGFjZS4gSSBjYW4ndCBzYXkNCj4gZm9yIHN1
cmUgd2hhdCBJIHRoaW5rIG9mIGl0IGJlZm9yZSBJJ3ZlIHNlZW4gdGhlIG5lZWRlZCBjaGFuZ2Vz
Lg0KPiB0ZWVfaW9jdGxfc2htX3JlZ2lzdGVyX2ZkKCkgb3Igb25lIG9mIHRoZSBoZWxwZXIgZnVu
Y3Rpb25zIHdpbGwgbmVlZA0KPiBzb21lIHVwZGF0ZXMgdG8gaGFuZGxlIGdlbmVyaWMgRE1BLWJ1
ZnMgZnJvbSBlbHNld2hlcmUuDQo+IA0KDQpHb2VzIGJhY2sgdG8gdGhlIG9yaWdpbmFsIGlzc3Vl
cyB0aGF0IGZvbGtzIGJyb3VnaHQgdXAgd2hlbiB1cHN0cmVhbWluZw0KdGhlICJzZWN1cmUiIEhl
YXBzLiBIb3cgZG8gd2Ugc2lnbmFsIHRvIHRoZSBURUUgdGhhdCBhIGJ1ZmZlciBpcyBzYWZlDQp0
byBjb25zdW1lIGFuZCB1c2UuIFdlIGNhbiBjaGVjayB0aGluZ3MgbGlrZSBpZiBpdCBpcyBjb250
aWd1b3VzIGVhc3kNCmVub3VnaCwgYnV0IGlzIGl0IGEgInNlY3VyZSIgYnVmZmVyLCBldGMuLiBu
b3cgd2UgZW5kIHVwIG5lZWRpbmcgdG8NCnRoaW5rIGFib3V0IGFsbCBraW5kcyBvZiBmbGFncyBh
bmQgc2lnbmFsbGluZy4gKGp1c3QgdGhpbmdzIHRvIHRoaW5rDQphYm91dCwgbm90IHRoYXQgYW55
IG9mIHRoaXMgaXMgYSB0cnVlIGJsb2NrZXIpLg0KDQpBbmRyZXcNCg0KPiBDaGVlcnMsDQo+IEpl
bnMNCg0K
