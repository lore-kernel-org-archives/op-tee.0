Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5C5C61DE2
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 12:18:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AA29045398
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 12:18:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=kuleuven.be header.i=@kuleuven.be header.a=rsa-sha256 header.s=selector1 header.b=dXb5bzcA;
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021107.outbound.protection.outlook.com [40.107.130.107])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B76DA443CF
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 10:58:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNcFyJIh6ygG+EZoYgMk/9E0i3GrnUroCNx2z9I7amD0EOVMRcwCKxlS3VgttxSplw8ptrx/yqd8MbX9LkGyIAQy4mKGjyrgW9g2/IsF2xoObPjoqmPGFuPImzDLML2QAqHaK0bCLubH435AX6l0Ic4rvEK7Q34ikNRPsvgCsx0UOXMSjb8Vjb7x6Pei+B8zpEm3En6w9sIiYYKrizTuW57a/xyQAmc4S+kCo/Ip73fez6Dk2Gk5qwjbEY1Aff2L59RVPy6FM2sgv54FHgnBJVsMikzy3YlTlP9kO0PJTxYklzBaNcUmXspFdukFGaUWJDC2FJKKMXE3qKvZaZLsUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lT6BAwzYGwA69T2ZmBN2ER9af9+trg9XjTDJlClKpWY=;
 b=dgiINgD9vnF6Isu0rjJCXvXx8tbpxLm39fWepfYACRafEy7xGtk4isuGWBwszvZlZ5la/UIvTYkxzVEPSUBC5XF4JFofKxiFXHLvG2C8yArU7aG+QIhsbG7rcjv8XeeQWAd7rLFhZgytwsuAsWqPJ++XVhl5ikVyURH3a+exkk6hXArDEb5u8q5VHPBgfNO8rotLsUKrNQaRHnDNO+25RWb4/hx0pjSM8NDstJYGaw52btdsbL0GTl0c4LA2GQvwdsTH6w1A2aUkJ7jPTbP+Q6yJznvpJRxLTAyHmj9psC7ZZYzRCz0e+fi37pVyPTnNUdYz1CDs2ttRNbqur/7NCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kuleuven.be; dmarc=pass action=none header.from=kuleuven.be;
 dkim=pass header.d=kuleuven.be; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuleuven.be;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lT6BAwzYGwA69T2ZmBN2ER9af9+trg9XjTDJlClKpWY=;
 b=dXb5bzcAzUOGv6jgtyhQffftNlFvo3rkKfLD5rcZBb7NksDbe9pQeCgmubwx8b2Xj1WjIx2kU31DYk39sjcqh0sim1l4uulEG1zvqB4XjUXGnX26LtynqLsj0fo5hJTlRJCZTmjpANctD1o/P8MiKF981KqcciX03GirdcAGFbg=
Received: from AS8PR08MB8996.eurprd08.prod.outlook.com (2603:10a6:20b:5b1::13)
 by VI0PR08MB11552.eurprd08.prod.outlook.com (2603:10a6:800:2fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 10:58:32 +0000
Received: from AS8PR08MB8996.eurprd08.prod.outlook.com
 ([fe80::ee9d:8228:404b:262c]) by AS8PR08MB8996.eurprd08.prod.outlook.com
 ([fe80::ee9d:8228:404b:262c%6]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 10:58:32 +0000
From: Shukai Ni <shukai.ni@kuleuven.be>
To: Jens Wiklander <jenswi@kernel.org>
Subject: [PATCH 0/1] tee: fix page pin leak in register_shm_helper()
Date: Mon, 31 Aug 2026 12:58:23 +0200
Message-ID: <20260831105824.3141687-1-shukai.ni@kuleuven.be>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::15) To AS8PR08MB8996.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB8996:EE_|VI0PR08MB11552:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bc33f8-2e6e-4b70-d3d9-08df074ecc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|10070799003|366016|23010399003|376014|1800799024|786006|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	5bumIbqy4OpPfbjjOVIle+pNdhXIzbKogyGYVCktXidxZhGd/YOwqmmhAl486Wqp5O6CWvp/JKGLipITMs74JPbfEUaTtXZapvRbHTTVjNuY9xDAKGAFyoij6Fdzve4u9ssOwomhlEWAD5EvXthDmtY9Kic3w3ep93cbbRTkxjnkkR4XtyC9oc6Sm4/z0ZxIfKfP0r8/tGUOCX2JNv3vFFXpHlp9lA9BOaaoLKCwuIc5gHmMYcFAPFRP+5ljiCCzEQzB9vxdXsJJ+2GXXgs2bCBcRvHRNjEJ8SRwRVktcGM71VPrVpSIiT1Tq4eUxEIfXWeHBjgqW7owtlrvtt4/sJZ5OO1iXGC5hPY/dkx8zOI5wls7t3x5OLOcUmuk0hwD8i53vArAuJBkvV4QY1E/4miHJ7H2JaQRmlD5gtSb5xEz9XsX5FsOa/Uzy+DAk8e9e3Qw/Z9F+5Ui3GYvjhkVbZZRrs+YG6PhbtMODdGnfwbZGj5HvK9pOatRW6ZUU6BHnMm1s0E51za3u7t1/SG1JIiIjGRccpYPMaj9tzH8dxdYxWbNFChTc2DZeXipcx4t06UYEcqgY7xk4b/I02rBI7smLqrbfe0yVN738FYXmN/6qRL9ljbR/2R26Ka79C3/S5gfZtX5X9LVp61Kvh9zNY/hQpzYUOZKGJImT+O9F44=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB8996.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(1800799024)(786006)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VDDTcBpGbstdpUmqXEKrgR2XNgNKGhSUR+W4K+73vcVGn8aTglmZGNNrrhAw?=
 =?us-ascii?Q?1anoK+PXBlIIy6lNex3EVNkWeNqcYKTwINZpcxSIWIXWUYSiRagwEdLcF5HI?=
 =?us-ascii?Q?TkOz0VvydR90AJH0Tsp/1UVOqfXvzSubNYNTENBAreC3FUJFinQwkDo3Clfq?=
 =?us-ascii?Q?kmnlslddjs5xwfCeK2TxbcSkbUTJ5G2pv55vPqSmuE+NN6ZQMwyRJPWiEIG3?=
 =?us-ascii?Q?udvHeM1UnqVXAPqKlqRkKsZfa6Ln6DIbriVXKolQ/k2CTAkY5bKPjKuKQgSA?=
 =?us-ascii?Q?49pytsR4KbEFL1V5VJCWHtzhMzZUdrcZPz+aoBs1kzpnDXZlJyMYPDKCU3Dt?=
 =?us-ascii?Q?aadPLcv6PR05NahquyHOGytxPDT3hY+W6ZVYgBLEJqv4DoKHCbkh7c0+qKrU?=
 =?us-ascii?Q?F96o4dumBNbke3HFqqyhZ10I5e1waxFYlUuDdHRvRFH9f0NKme+1KNOO6hqs?=
 =?us-ascii?Q?T64xAKCFBvCA4VU4mTJNOO7klwX6KQyRZosaKjQctMnXl0KnhSt+tRuMuDN5?=
 =?us-ascii?Q?7SYb2DOOh3YsYS+9beC2oIB338bfcghwsoCIL2Cc6Ba0r407PDwzQSPSeMzC?=
 =?us-ascii?Q?6LbfnLvYUlqckQWBVLn9U9xja0IsgwZc+tHShd6ES27oBg0nL1uGGtdBYsEx?=
 =?us-ascii?Q?0WygwduX3tswjfG3UzVmO169vB90n/eQPglMZTOhPkIE/JywuubT5HQpbzPk?=
 =?us-ascii?Q?yGbLvV+1r/xDsn85cZQocDk4S6O6W0+pWtx/ACnLaeXMTYL+c/Yc0NrOSLyK?=
 =?us-ascii?Q?aoZKiAvo5GTjxHUVO/qTaJDAaY6fDMOuCKvWU4V6eQ7UhRF2jLxkklfLZnzl?=
 =?us-ascii?Q?ljT8hHtnERtY8NpsbvT2tpCGu9O5Wt27V9aD0aIeNWmokHQ67grwMbXwi6rp?=
 =?us-ascii?Q?wxyMtfWPzlIO0h/7yOPerPHCRyiymARx8ogmdPpKGllLiIg9rIWa6MTFJR4c?=
 =?us-ascii?Q?lygJtSdhsEAv/fbnD6S76XTpRYVWi+/JDZzchrUzKpyDb8LYzpWaxC6barH3?=
 =?us-ascii?Q?PvXzVYwEmLBWyqZphqtyEgUFnxgsadQH4XZJzHuX8kN6KH4fpoQ6t26/pyb5?=
 =?us-ascii?Q?2ccJFIqmYatetToNtH+1MYel6qvrJimBEQ/vgPfVxlpnVLXlY+wTi3SDGqde?=
 =?us-ascii?Q?r6W+GFN936f/Rf6bRQlpF/3WoXKsb/hWpu2vNAStiCXFBttgrXimBYC7UDc1?=
 =?us-ascii?Q?yYmv+/t1grwymOsrDqe9P8GwlH4TV4dLSBm7fc1cVR6T0XD0yHt+o/PNH1Pc?=
 =?us-ascii?Q?eVn3BGf69+pUNzyoc/W+hNQ/dHgQk1If/fPrYQgvvAgpOinEI6ByI8/JD93V?=
 =?us-ascii?Q?Ve9aAFa3o65PvoYmETq0FERlK7n0I2wUI8SSTFG2NGdZGI5XWU3eDhSK66HQ?=
 =?us-ascii?Q?c09Co6DBoxrdAS+Ne7W9FWzLpG6KE/SLJ0mLYcheH5scqxWl5AsNS8vIJht/?=
 =?us-ascii?Q?BypaYzhNFitdckwONSCrLxiVS9vOSOwgDCiwgtFBcM3/uL5Vis8kq0Nzg1jt?=
 =?us-ascii?Q?UyAo3/0GXOM8sgQ4NTsuOOK1ymNV9L2YaEwq864QUThhLhHnoI3h6Z/zZdXs?=
 =?us-ascii?Q?/28mmltGQj7yUF5QJOPecEKoyB+9PcYVXfXPEtGcy1n9n/mUZm2lZskgWzTw?=
 =?us-ascii?Q?d9lN03pmflRvQnXUIzXiWKH7FQ4Bfx/J7SH8DHY5KV7TWkEBwXTw/CoBbkHa?=
 =?us-ascii?Q?qhgseYeoQac2pHZLGz7Oru5zzP9jipbbN3Yb4yS62miFq/Ltj4n4QsESBj08?=
 =?us-ascii?Q?yq8Ag6JGY3UJPBdd8+Xzlqe0l63YBwKAgRroFgz89OyRTz+4yZjy?=
X-OriginatorOrg: kuleuven.be
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bc33f8-2e6e-4b70-d3d9-08df074ecc37
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB8996.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 10:58:32.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3973589b-9e40-4eb5-800e-b0b6383d1621
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKfqIJOz1dKDmNRzgH+rpOM+JEMqM3GESa8iOTo6nBkZimvdEnUKfpUHaRaWBZ0BA0d8kVs1/u3bRx5d4dzXiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11552
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[kuleuven.be:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kuleuven.be,none];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	R_DKIM_ALLOW(-0.20)[kuleuven.be:s=selector1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.130.107:from];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.130.107:from];
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
X-Rspamd-Queue-Id: B76DA443CF
X-Spamd-Bar: ----
X-MailFrom: shukai.ni@kuleuven.be
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: S2ARSGZ7YDL4NRJYCSVHUEQWCXVTWXX5
X-Message-ID-Hash: S2ARSGZ7YDL4NRJYCSVHUEQWCXVTWXX5
X-Mailman-Approved-At: Mon, 31 Aug 2026 12:18:11 +0000
CC: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>, Shukai Ni <shukai.ni@kuleuven.be>, Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/S2ARSGZ7YDL4NRJYCSVHUEQWCXVTWXX5/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Jens,

This one-patch series fixes a page-pin leak in register_shm_helper() after
iov_iter_extract_pages() partially extracts an unaligned user buffer. The
cleanup path undercounts the pinned pages by one and loses the final pin
when it frees the page array.

The issue was reproduced on an x86_64 7.0.0-29-generic kernel with 4 KiB
pages. On the unpatched kernel, each failing registration increased
nr_foll_pin_acquired - nr_foll_pin_released by one.

The faulty code is also present in current mainline, linux-next, the TEE
maintainer's next branch, and the supported 7.2.y, 7.1.y, 6.18.y, and
6.12.y branches.

Regards,
Shukai

Shukai Ni (1):
  tee: fix page count in register_shm_helper() error path

 drivers/tee/tee_shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0

