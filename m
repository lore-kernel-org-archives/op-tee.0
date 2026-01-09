Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889BDD26D67
	for <op-tee@archiver.kernel.org>; Fri,  9 Jan 2026 15:45:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D18754FFC8
	for <op-tee@archiver.kernel.org>; Fri,  9 Jan 2026 15:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767973509;
	bh=Tg04a5LlBb8s41g8JJbJdyXF/P5lwtLwMQLoCGgU/+s=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=rrcnbzQ7Z3IgP/oB4GLBVEsovR3Bs0tA9EVShaOuASy5ZsssPTHU2Meod+Ka+GN/g
	 sId0T6D+5YwFQI0NJBp7CNRAQtTt0JctypPKbmDqNaQVoyuyk4CEHB6kDiP4RyW2gB
	 m1Btd4LPS7BO/hH1Ol8A+yjlqVLO6PPTK9Z4QZmwSkPHQjDSXz13TjxnNNB67JYrDS
	 VrEWiOXn8L7DGTSNnMxzu2reyDJQUlf0yt5Pzco0JLbLM7xbIh63o1Y/gWig8BXGTa
	 bqVQEOiylF5JSS7w/I5jzuNGR+Cgs1sCWxaW67V0hL7oXxzvvk3kKuArlkCP+FV58N
	 5kSVIGnFdlY3w==
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 45D5B4FB6C
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Jan 2026 15:44:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Dnmi9EDN;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtRflDac79NFKRCgxuRdOC9zg232IkC2zlMNxKgpy9un+PX3viya2wbALKtCPtWMLd41Mg9IWRfpy2Mo4YUnLBRhQfLehpax24j6PKUcj5tzryroWaBUMF6At0PaVRZPm5JZLfwicIJfsnRX8NDfCSN5HkcLPw0O6y4ZHUyQJLD6z7ppgWEu1dnWW60rxOplXGirLtlya78xUJfxofnCKhEJPWg0tF3K6Vl8VGBEuENcPiNDpWH6FNFP4sFtMZCevy7L90CL3G4lFWHaeUdU1hr0ShZn2Cf4+NDjfQ+tbdr+6ZuHHSJg8dyhY5f36+UaYnmVkaCr/yo359VkXNtYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMfUqqPvx3tKTEq70CqAgq+kSrtJzIIA9oFUdOuxyBI=;
 b=wkEo9E6GkhEovAC6ZBJSW0OQhPSahadl6SiGT7JfyU4y16y48iyQLjEtuUUYvwTNrmVhR9LYUVhrY0K/Wp7U6UcOOqaCKbiFPFYIz9BIrFMJ9CD4iP9yYhiRHzi8vAPkfBnDDwcJxCA6C6G3D6nlRwlYp5pbBJI7f3UjNUKizJGJGbjHatuS7Sn+aywJC0HDq/hAERw8DQhOhMB5lNcyzUWqjxs8sbfKde26Wmy0RmyVsOyPM4QoZ40Osn7NTh/oeWfu9ZGPmxhbtFLQk2clEL/tCEEm9iCkm6GDXA7WLO28/qT/xpGbl1muRkzE1fcQ9wSAQFwo+bB6xYjuLQOcew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMfUqqPvx3tKTEq70CqAgq+kSrtJzIIA9oFUdOuxyBI=;
 b=Dnmi9EDNYAMWfbvFn0HNfLlEFF6FHMpTpvX7yz5eD96L4nkCdMq9E5NjOqmrHlbfodhksur7q/oOQQy0mO+j2q1ACotYwhm+JCzhtUTmUMn+BFz7tllbgU0dsL63g+fImQ6j7xMFuc0yj2qsogIGrHCRcSLLqs/JFStBk7en6FVuLGM3KiFKmllvAvLwJhLZ5uvGzH58bsMO+oFWfa5l3nmvn4KKlf+gtuFEjShsYbnxw8ykN69piRPvh1B2MumWBH5/3Lq9wNXW9QlAPJ3DgWmMdehlcB0Qq9JNczesidhu42Q9118a7+z49foUCFUgh+ytdZlyuhSSjp+DsWq8Tg==
Received: from DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) by
 SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 15:44:46 +0000
Received: from DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::e6e0:ccda:fd50:c52a]) by DS0PR12MB8294.namprd12.prod.outlook.com
 ([fe80::e6e0:ccda:fd50:c52a%3]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 15:44:45 +0000
To: Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH][next] optee: make read-only array attr static const
Date: Fri,  9 Jan 2026 15:44:42 +0000
Message-ID: <20260109154442.421248-1-coking@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0626.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::11) To DS0PR12MB8294.namprd12.prod.outlook.com
 (2603:10b6:8:f4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8294:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c17f4c-eb1e-4b47-ac97-08de4f96036e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8GMdscA/Vx/bKnjpbRjNwD5zgYGaFaFjEpeHff/ycPhC+/8EZiZzbtqF2Mxl?=
 =?us-ascii?Q?tmlDxsExxaQF/1R80FznLcr/uwFDzMW5KDsQzzyPHOQ1t7E7uCBRZ/Rv18Rb?=
 =?us-ascii?Q?0SqLqlSqKnLDqBLGZw68lph6PEuE+iGpQtIY9RuwXo2ypIRB+/lGiwj9QUke?=
 =?us-ascii?Q?l2/mEVzw7xd6pB8knzZPhMg3ldUwUijFnm+jgmnLZMFj+nb2lG0Q9XX/rQ/0?=
 =?us-ascii?Q?R9Db8SuWe5gktEifmbpDJWJFAV0yaEu4BseHtkzLGqrJIE3oM9hUKj0VxpgF?=
 =?us-ascii?Q?p7iG/L/rd6teJNPvaMB3ed0T/YtB/UGOlD40ktmFRNXcZqnZLT49PwXzz6Y7?=
 =?us-ascii?Q?mzFuKn3OLGABzw70L0Ad12zOCwrS9ByUuzd0U9uvxTVDrBDrJGJT1s7mrpAX?=
 =?us-ascii?Q?3s7N7mGYtydjivZyTIvzH3rOUDgPI98zShXfKWpPgBxKSaaEhF1tvQXEx+7S?=
 =?us-ascii?Q?mJPqW68jXAC0NGH9u08v5rE0X0f5s61pyu70syiNvRP3/uZqM1Jv3Y4cEsNi?=
 =?us-ascii?Q?fluEwbpKJEo6iUU+zc2moeas6t/rTLx61MV7QRB4dy1qtpFd/Hvcm1yzlaKI?=
 =?us-ascii?Q?tit4sRP7sIKesaOzO09Dsg1j5Nd0Cg97RXWdAUxQU654wZt8A6yVFXBSzdVm?=
 =?us-ascii?Q?RZMjecw9SZVJRSyz4jT2uVBODolLFETNIoajXnLOOdnJJjEFF3Urvqfb/oKk?=
 =?us-ascii?Q?TsA5ehaFfSCB80HdB4fJank/0303Djd6s54kmfzOvTSgvVzIEyb3Tm0+yH88?=
 =?us-ascii?Q?XSsdDUQObfknbSzVmlkIzuRDxOg+9YWIst5fJtixYz92BnsnPPS5Ydk6mLR3?=
 =?us-ascii?Q?QsflAgZGlxUnV+NQfWg2sBhxaFX5Mb5yT122x+E8lzNzuJeN4Xa48tDblc0X?=
 =?us-ascii?Q?lktixvFFaM/+XPGETyoX/dA5Ir3clis/RXDU063cUjURmQgWc1R1ViCecBhf?=
 =?us-ascii?Q?bdbo53ySVfXHon6aX9+haLyTTaA5iO/MAMOsYzvg4XsUx67hZhbbeEhJYOt7?=
 =?us-ascii?Q?fYiMX1ckwk4F3KuyWZKIY6GLFnzBSnIzymj0EYp1gFclcwu7r2j5RcPx80iM?=
 =?us-ascii?Q?t8W3gylILToe5uECchzGFjyjhnQ1uhro03RBftGmsx6dQVhBT7f9z9P5AvZF?=
 =?us-ascii?Q?+WJIu99uegNnTMY/9kd9gM+SLgU1tuISSC6YO2nAQ9tM2cpJpC8+9vZGthsv?=
 =?us-ascii?Q?pmAh1Xtm/HJhSbTrIO568G34iTE1F7RP+3CwugDLsRwAI4GapO5bAXUwhrM9?=
 =?us-ascii?Q?s1Q2a8Sxy+SaTas2Vjo9QFFYbcMTxdLmc3TBmSszSLaK5B2SHQwhJTPqzYPL?=
 =?us-ascii?Q?2wGwppRw3Qan+UzFPk/nb7jE6KxnScPyvx+pDxIYIn0SmdOOYLVkXsGFKVWn?=
 =?us-ascii?Q?FDGZXolZl45gyfaa3DagqPNLz/GT+bu+cf0lFEMxpX7u951oqfcFOry5YGLg?=
 =?us-ascii?Q?pzS7Nf2OCVO4rzkQNoekRS/g3lCPYzz+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8294.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HkRESqFnYL4QZJ2z8cOebyQjUsUVsX1oksspMlYU0tzO+urAUPOaW1YgmJqw?=
 =?us-ascii?Q?7tXMjP0uYrU7ofoNjTFQCsCyfiSAP0Z3GRgapGWagJoVWM+M+dZAR6hKf/96?=
 =?us-ascii?Q?CPaly2FnEeKqL8ivD1rEEg1iDkFXXm6zRQvAl5uGWBbE8AD6i+Z4YqregCp1?=
 =?us-ascii?Q?m3fS6XIRolzwHVIp7eUWJn3+4x81Hyw4ZXck1/R7Vr2i9cgphx2aqgkEQzsz?=
 =?us-ascii?Q?W4iLqmZsN7wPF7cBHfb5nVxy8s2TSYwJiWG8riZ1je3ewy8GPeGnItkb8XPJ?=
 =?us-ascii?Q?yIsnIdbwewputTS2hmyr7fXGnYHEv6S0ZbiRa2gTD9uwtm6aFgyfXd3Igw3z?=
 =?us-ascii?Q?543lCjcTm+5QfEHx/yXqT+OXov04uwv2JojhxN1FEn7LHAVUdK+0vQFBUEzY?=
 =?us-ascii?Q?VEvFn60DfY+CTUfVqj9WnG8OZVLbl5MpXygvHQs0J4O/qIcQQeLigeA/lTOP?=
 =?us-ascii?Q?REaUK9JZKebRGjFYOvtp2IDM0U0SocgiYdpAR6SzC9DBwMuUeX2HVL65tYSS?=
 =?us-ascii?Q?POMmdpx/Upr/b0vOKX/f8xihy5cK3kjtxPDU58MX/LG9UbP/f5gHtrHN46Cb?=
 =?us-ascii?Q?fxEkcTunKTKn/65dOQIkC0hThWK8JWdwkYhj14ivxzED+CHIW55xpJ/i6oTR?=
 =?us-ascii?Q?GeUcRsnCg4Sm42q3qaGYbpqsHBWfGenxDmfZDk57/vWjofD7N7OHoU31HCk7?=
 =?us-ascii?Q?u9dmf5QOrES7fSsF0tlMRsI8tIOafvodsmM1dd8rlXxt96zuqmBIlsz6n9s2?=
 =?us-ascii?Q?Wk3hss6HF2FoW5xdfqAmF/JQGKzjIlbWdxnoxqT8nsZHKR+1PuVlroNTxvcC?=
 =?us-ascii?Q?PLUyInvJ469+dkrxR/7gY3xEneGYGscHgzBWQUnr58G3RuYrWNbsJZ6znoDn?=
 =?us-ascii?Q?WFE8NkoiOSCVd3UF3OshXWvhnr8a6KAFko9xa82DUzcoIZWYGWcfcL1A8mNt?=
 =?us-ascii?Q?VTXojy9H661QeAeWRigIdLrfQL6PCo4+NsiYaanqzkOioSU5ck00rv66P6Vh?=
 =?us-ascii?Q?RYI7jGs+uIihZ+R1Sl1i0JqWSLe40uhQ8i9y4rysUxF13rzOK77jcC+N0rv9?=
 =?us-ascii?Q?v3DQfqzLcX4VG7ccd5UcGHldAWcqNje6jqhpbRh47HlGOW4ejXwWpPbmaSen?=
 =?us-ascii?Q?pD/KtYMHoJj7V7tFwNPz1bIUNg3F8O8qOi0pm8Zg2kvzj3jPDj42OfQaNe2i?=
 =?us-ascii?Q?sznVUbGVSOdidERKU9hDPR6BzKFtlmxfhNT6C7NKjuhsApE/1CIE2fWBnqMo?=
 =?us-ascii?Q?4qjMP3gYK7lWiAtVbMz8KLQFzt8buf9sJUNIlDf7x5BEez83z3bfeqKxzw88?=
 =?us-ascii?Q?qUp2c0ODInaf+bm8Ql6DZeioJt5HjMg7igRzP91cac2BmhG6UUUDJZXFC++5?=
 =?us-ascii?Q?CklzFm04Mu7ieLN91WOPqu6awVOB2t+0kkHq2NuwRyLhjgm979DlbmYlotEa?=
 =?us-ascii?Q?ynPkqfuNsVVut3FYKCeWg9UDpW7V9c5OGlxQsedmZv/djlF3PK1yBArbXqr6?=
 =?us-ascii?Q?yxTN2Y93wFlFtFQIAxTzrY/D/5GXzcMuWqEQovmRiw4HxwSemPZXXMqE6JKN?=
 =?us-ascii?Q?blzjJlPw+MbIEZF3hg9X33fnch+/+IUt7SpUAeiirxnjEKXQqOygzEY1l85L?=
 =?us-ascii?Q?T7UEFICmAfb6OKQ9Gcr9eZ/bgHWg4R9mP/WgSZIepVSQSmtzSjcYje7f93zX?=
 =?us-ascii?Q?2UqGndZawQPXi1iudqGXhYyDNoaiAmZxMwNGKuYgr44yc9Q+hR8+Jk6nnB71?=
 =?us-ascii?Q?rCKa6t5ZXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c17f4c-eb1e-4b47-ac97-08de4f96036e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:44:45.6791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WMuLwESuqr1/RAmGQWu9ePle85FilWyUAyM8bYXV6I9zCUUkFAJ3GtNkTPIIfizXUV18FhJlZhB8thKbMgGa2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[Nvidia.com:dkim];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.193.57:from];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.193.57:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 45D5B4FB6C
X-Spamd-Bar: -----
Message-ID-Hash: A24RSSNDGALHG2NHMPCGEW6UUL36BSEZ
X-Message-ID-Hash: A24RSSNDGALHG2NHMPCGEW6UUL36BSEZ
X-MailFrom: coking@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/A24RSSNDGALHG2NHMPCGEW6UUL36BSEZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Colin Ian King via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Colin Ian King <coking@nvidia.com>

Don't populate the read-only array attr on the stack at run
time, instead make it static const.

Signed-off-by: Colin Ian King <coking@nvidia.com>
---
 drivers/tee/optee/rpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 97fc5b14db0c..1758eb7e6e8b 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -43,7 +43,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
 	struct i2c_msg msg = { };
 	size_t i;
 	int ret = -EOPNOTSUPP;
-	u8 attr[] = {
+	static const u8 attr[] = {
 		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
 		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
 		TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
-- 
2.51.0

