Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCDEC61DD3
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 12:18:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A25845375
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 12:18:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=dvAv+rKC;
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021128.outbound.protection.outlook.com [40.107.130.128])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 19735443CF
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 10:58:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwARrN5iP7YcAb+zWRgDGdf3efxY4z8Qw8mZrsutUOkhrJHpryM73rukJLLi9cxoG+xrNhWQlzl9Vlp0drHyu46ulOxpKyjW88ran6Bo4Z6c6srpA6Mcswr+Yh+t0oqbohF/CKiXxQ9n92y2pErvn061fQ4LiEgrN8Lv6W6cPPwRIj/XkM/0JpmZGXtZh5GoiwjZJ1yeoVn3asgkrgM7F6WRf7Eimiv7SoigpZQ13IC4jMhCFKfhCxm+jr44sYW+7e+ULNIkR9YPQU3mCovfTuNMUZBTQU1twydm+qdhFGIxUJKmyFZ8TDHxbhHqwxbf97JiFO06kLDcCqi5uSk95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrvtOnMxk9WsqSuDpa380avo0js21JbLDHh24j8U1qg=;
 b=oITMyOvbehfjG4m5fDCW19aYE3qt5jqvcqE0ip51GjDPZ6/R91qINoHtDC6ct+SwHONKSTRAwGK1vTAP3q0609S89MxBLSEZnGz+TPiY5Vu2rhN1MITafpUaRDeHp4WnG6Zqc7MxEABMbtNdSTki1N5EM/UmXl6lcDRfFU8Z/8qJ3Mrs0N7IlWtV4baI4vof3KTPThr1TbTsC3CIJI+SL2dN9AzyxL6x4HFZWVouZ61DkQ9QCBfVAT3gTTao/vcFI/KaKejk4/N+DpBMUwpp37HfF9PL54EIvMkIBQ6EujROGuutWtA8hmZMmrrdZN6FrYq5j1iYdUw945kGqJXJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrvtOnMxk9WsqSuDpa380avo0js21JbLDHh24j8U1qg=;
 b=dvAv+rKC4+EL1CwRaZPbZ+gs2aGWNipMW2aextLHYq0CNSsKbADXLhQ6+yZJ0yjIfaQQQ/oq0mSOU83YuDAx9BB2VYrQmQOuOOYNi2N0yXYcVVsH5VKcFm2p057AF3DTV8XOc5Rc83KT5xcXxMzzEcz4Dd/Z2DGorYInBHrEXDk=
Received: from AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13)
 by VI0PR08MB11552.eurprd08.prod.outlook.com (2603:10a6:800:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 10:58:43 +0000
Received: from AS8PR08MB8996.eurprd08.prod.outlook.com
 ([fe80::ee9d:8228:404b:262c]) by AS8PR08MB8996.eurprd08.prod.outlook.com
 ([fe80::ee9d:8228:404b:262c%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 10:58:43 +0000
From: Shukai Ni <shukai.ni@kuleuven.be>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH 1/1] tee: fix page count in register_shm_helper() error path
Date: Mon, 31 Aug 2026 12:58:24 +0200
Message-ID: <20260831105824.3141687-2-shukai.ni@kuleuven.be>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831105824.3141687-1-shukai.ni@kuleuven.be>
References: <20260831105824.3141687-1-shukai.ni@kuleuven.be>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::15) To AS8PR08MB8996.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB8996:EE_|VI0PR08MB11552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dac0c2f-eb0b-4d31-533b-08df074ed280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|23010399003|376014|1800799024|786006|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	TYBoZmSGsaGLIttU5hgj1EFCng3DAl/pkYjhG51AUCz+hDX+09hv+bjO12og/1fB0f84ghkBtm91I5WAEPv/wR8xyCFmP/halu1WMR5A5riIKeIQPPayn7do5WjGYxgPdJcLtcJt1X/w/vXI0HwGleR74oP2D8Uzsqg9CrjtZKANg8/AxfwH8mFbpohSLy5eoFEJ6dB11QKbyzu0OJdKfyoyPxdBuaUd++BJJVIqiRVdsnYiYmbT3mOY2DZPf6sM/FZ+9R2JHg4tyMryHMgFVpICgXs8Vlsactsnht7SKgsv2b1PldjbMkW36BkIXeR6OzV36okx07JhVtRblnHcTM8QCOByJ+YY5tbLB52kKDvz3ibxplI0192wVYzXekXDy80+be4x2FYTeWqVqNcBLa31Rfam2zc72RJ+u83ew9ZmnUjXZoz6G7TjMsp9ygIImBPa/w7+Q3Bf2K6CUzv3fZMxqPEDtdbRemTmA4CaUDDMeUEBIKyE/VXqibKhJpZAmv/cvQatymi5TnBZZ5DKfM30SDjW6ekvZv6J+hN+3lb+o6LH1169QMB6n8XLIC68lDZBCU366JEZOcBq4ujb8tpVYJN1I06sH/1LV6+pGyk0n27os9qpS+H2A/QxLQnMiGOiI4Q7DsXgU7wBxSVQWUkBnS3ZvTnDoFQ2ROBOqEI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB8996.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(786006)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XmzLCRVGeSpCda0y7QNUFsKgf6F/qnSBfvmIEh3cPV5g4HMsmKKjJDymWMQR?=
 =?us-ascii?Q?/26AYlN0dmB7VK4fcWrmPrL3Xc1mIq+ozDdi1xoFwSUvlstwrnlpeK4rHYsm?=
 =?us-ascii?Q?ilG9LtCiJMOD2P+Vrrxc8fC6LI+Ms+2qex0risjuX6oDBLWO5We8qCDMgH27?=
 =?us-ascii?Q?AkmqDv6R0b+i4n0GK559HbJcjBI59MJRk4MXaIf5PKypZYyK5MKR7ynt6h7l?=
 =?us-ascii?Q?YR9ntiodMsFFlP8DAGTwKCXOjOW5PA/N/o96xb6vut4ufDD+cIOm1P6+qudq?=
 =?us-ascii?Q?vMLhhG+/pClktyh4xJl8euY60FDeF+l+Enaq3CscIUj2CqQshKtmHqJPmmpf?=
 =?us-ascii?Q?4q1MhWHtSxo8ulAIDhMTG2x+LH8aEr4V4uzlVrMMUAQp3PW+631FlWdVbbdV?=
 =?us-ascii?Q?ot7BdVvElMePa4l9pmctZ0INit/kXfY598qh4AlldFuT0rngSfdABYB+0WlI?=
 =?us-ascii?Q?sQ7sOU3JdGNN1dOKCfxHrIC0VNDpuG/GBNzxpPMtqFnTCKtA5rHJ35fsZCPE?=
 =?us-ascii?Q?oKoQJL3wRuLeYMLRdShJYLSUVYT/jltyBbMbSrR5aVEBXlgkXz9DwzOxtHah?=
 =?us-ascii?Q?IPeadBzACAgJoPsbk5geW6yCe9n1x0Tka9DR6C0IRcLyDiYYU/671qobRERu?=
 =?us-ascii?Q?Ek2Bx6jS0ObBHgBxfL4oqa72NabXQ6mwYhccNpqcNw9HgDmWuuUFajj/q+Ms?=
 =?us-ascii?Q?H8FgaPikU8fA2HsHQFE6Hmi2cqS4vHfFSHvwNziazD7sVwV8rK3cgD2xQDG2?=
 =?us-ascii?Q?5JRFrEH/qLTAqNqYuMaha8a7yQMGCk19VvsBOzYGiGYkJG/uQbwacSQSr6wF?=
 =?us-ascii?Q?ULqty0tQc/bJ1ccO8MPujJ4bZ+5SZvqUMJU52myMMJoy0HwXYhhIh7UJcTAu?=
 =?us-ascii?Q?bF5Y644MvfFLnYlLr6Vy12LTA9GR1nczII97yxtpFSUrR8nxeh/4j18z9scL?=
 =?us-ascii?Q?8Zt64FEhJUnQ9pmOGAaEILOo9fVR/lO0i2tty4ZQHVlsnoj4bGLO+leuCpVt?=
 =?us-ascii?Q?x2HTqakILVScIoWmpqialEKEqSdSTD30Y6ospLyf2NcI+wKVq5bzjVXrhaQ7?=
 =?us-ascii?Q?duJ6D0G7YSlkBiiHlQ/T996QiTpA98eve5yyNSa8vaShliKD+nBqckYZ70Cl?=
 =?us-ascii?Q?2iXtYAOPbOOEAe8GP3Y7OrNOzHmjWH1Q2EEy7TY8ljx/kaSxhnbpli/qExPf?=
 =?us-ascii?Q?I1jcGCQJyNQL4/PkuPjubDAG0s0hqTMlpF6FyCozpRi2TmHJKIETD38kkLDQ?=
 =?us-ascii?Q?YSzE1wIXKkJm+7ioH2XuIJGT5kJ8dmt6ba2QWAxYdgxz0oAp5Bx6qaXmfwZw?=
 =?us-ascii?Q?csyriQQhE65SNFK93qo47h5kJ8kUnAACVYr2Z5yEmkYaG2KaWOiR1GGvA1uN?=
 =?us-ascii?Q?xduXukg0Pgd8o0YWzibb95ajQom59+TU+CJImWiIML6XMoBPmdT9hs4iiBUb?=
 =?us-ascii?Q?+fC1RuS1cpOMdjEG5lILXrkFWM/iWVA0BNBTXjJf+ee8krF1AbU2TmClXwWl?=
 =?us-ascii?Q?ym2CcqXg45YfHCoCa1oAreGEPCbtPop9faEW6Ztj6K0d9JpC56CZi0T0kmK9?=
 =?us-ascii?Q?onFsd0TwqvtSxI2wsUCU1J0LBVRHWUzkvM+3JIiz5+CadTTLxKHhFVS4FoQ6?=
 =?us-ascii?Q?xd2FiVyIRFyxGIwDTR2kr1Q3/Wt+Unh/t3RpU2cBxk+UTCPIX3u9o5mXN/r2?=
 =?us-ascii?Q?DfUxCQN3HkgoRrzUrlmXEd0ODyy5XpU7v/dvBhBX1GrGig2m71CCTqwlTnaw?=
 =?us-ascii?Q?FRvgfxAWMnfCw/wQPbOpUHrXx1OPFG2fS4RwAxCSyo7JvrI3vPyu?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dac0c2f-eb0b-4d31-533b-08df074ed280
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB8996.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:58:43.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1WN7+/PwL2UyNXCdLdeo4lakFZhrHf84Wg5QoZOE4zG/gxSvL+bKn7WQb5pVlK9k4EgVIhGorX0pIn9nuvt9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11552
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[kuleuven.be:dkim];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16:c];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=selector1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.130.128:from];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.130.128:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:5b1::13:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kuleuven.be:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 19735443CF
X-Spamd-Bar: ----
X-MailFrom: shukai.ni@kuleuven.be
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: MSRLUYAIVETICOTLNZXQIM363KXAVRDS
X-Message-ID-Hash: MSRLUYAIVETICOTLNZXQIM363KXAVRDS
X-Mailman-Approved-At: Mon, 31 Aug 2026 12:18:11 +0000
CC: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>, Shukai Ni <shukai.ni@kuleuven.be>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MSRLUYAIVETICOTLNZXQIM363KXAVRDS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

iov_iter_extract_pages() returns the number of bytes extracted and sets off
to the offset into the first page. For the iterator, the number of pages
pinned is therefore DIV_ROUND_UP(len + off, PAGE_SIZE).

The partial-extraction error path instead records len / PAGE_SIZE. For an
unaligned buffer this can undercount by one, causing unpin_user_pages() to
leave a page pinned.

Fixes: d5cf5b37064b ("tee: fix register_shm_helper()")
Cc: stable@vger.kernel.org
Co-developed-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Shukai Ni <shukai.ni@kuleuven.be>
---
 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 6742b35..fa446e4 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -454,7 +454,7 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 		 * If we only got a few pages, update to release the
 		 * correct amount below.
 		 */
-		shm->num_pages = len / PAGE_SIZE;
+		shm->num_pages = DIV_ROUND_UP(len + off, PAGE_SIZE);
 		ret = ERR_PTR(-ENOMEM);
 		goto err_put_shm_pages;
 	}
-- 
2.55.0

