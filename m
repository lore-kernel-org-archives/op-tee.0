Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5352F103E160
	for <op-tee@archiver.kernel.org>; Wed, 18 Mar 2026 11:59:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8D29143AC6
	for <op-tee@archiver.kernel.org>; Wed, 18 Mar 2026 11:59:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=N2TTnePJ;
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E6E4C43A9C
	for <op-tee@lists.trustedfirmware.org>; Tue, 17 Mar 2026 18:19:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SB0O2dFwgxeOOlox6Dfsc+aqBrrVl2Xe6XQrKHgJzSpcbB8LYu5b4zVCpn8FqLYsb8GyvdRXmi9kxE1YSCCvzI4LQfojhw4uJ2hzUcP+S/E9WBS+sImORopwwkn+FB4ffM4jfrgF5h+62YtPJMLPzTmHCiFy3qqqF7gs/MODvlArg14D8H7BlXl/K8LwjMomVEwT6Abx6smYWAHkhhjAYo/eFn/5TPxvm4jCfCjc8Zf8srg93U0usnCsarnQ1hcXhwFNxym40FQctGM9690UQvv6mgVOGH0yZ3JOc42Ly2fxEvnw8SiWlC2qcpelugKIhOAhJq88V/iushyHDHTcAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPH/2TVb+G7IyWo6jXI6IP6WTqNJsSi4anEcn8iTP4I=;
 b=UqTEG7mtm6wQnAvE1rSsJaPDBj5xb19dyRi2tqgvCIuwE2Su/smp+0wrJ10XV0ypv8vMkNkm3/GAJe/QcpXotOyCZiJSNJ3hfy5LEahdC6tg/HrL1qGOo9qpKbnUnlgb3NzZRo8LT8j3i49SIcR35T8Eeik+W/bfsuAp/8lOnVsQ7ufZATZmWR591zpZcSsMFLbtvt8eurm4L0WddzNoLTN5BO9gmJ3R02rkmy3V1d49tN8PzDalBFYgNOeY70Pt9drgh++AXkNwaXJ8kAwZCfNKg3OXA50k445mvdTokP7xPQnH2QFzELQE2WPrV2LZB4zL4MTpMsem4jpJu46v6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPH/2TVb+G7IyWo6jXI6IP6WTqNJsSi4anEcn8iTP4I=;
 b=N2TTnePJEs034Sb+kjPzcVQrhvKvGDy0Yl02s+pCeTc+V+YrOTeNjwqcAotAAfumbYV0Pai9yH2u6BmzrGdRwfDllkvCd9VsBsxEoLihtRJwUzIkMLTnXlsVyj8c/yKu23llbBjQcPNL45lo5L3cuzkW9cCJVDX6E41ORgiWxRr0zFGq6J/6DR6G/zndqy9w4boUKRYS00fbNgqHJGZN0ubxHBQm5RrLdy8Hz/zZBrzim/sYK1XioCHCctEkm+nZYUStZ5MIf86lY/lO8FZF+64hIPLexdDU+ugb592oSIEB3Vy+Poc46dg/tFIFWtJa314tr3vydYUfQVQuqunrng==
Received: from CWLP123CA0203.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19c::13)
 by AM0PR10MB9671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:740::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 18:03:49 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:400:19c:cafe::a4) by CWLP123CA0203.outlook.office365.com
 (2603:10a6:400:19c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 18:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 18:03:49 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:06:23 +0100
Received: from localhost (10.252.21.194) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 17 Mar
 2026 19:03:48 +0100
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Jens Wiklander <jens.wiklander@linaro.org>,
	"Rob Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: [PATCH v21 0/6] Introduction of a remoteproc tee to load signed firmware
Date: Tue, 17 Mar 2026 19:03:21 +0100
Message-ID: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.252.21.194]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|AM0PR10MB9671:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c458646-b2f9-4613-9d33-08de844f8a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|7416014|376014|30052699003|36860700016|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	DwW/YRRPQ6FlZNiRps0OklgE0CmOaaUHGOwM+wUemRwgubg3K7aZ7VKxAzsPx2hE/afyFD1OvEDFji331dbPZTTF4usowRPSQt1bVLd4oc3YlRs3zfq7rt5b8VLwWwm6IHnp8QIbdra4ifa4D1EmJylAhT6QZ6D2nvlGzYtx/lsnwJoUBscuztrUmQzjwiO4UtbB7JpMbSQ5Mwe/1GNwjHwyX2IQfzO+4kPSW6dgwmaTwZX3mjtb00GKZghWOmfzKbAkecsxuiolYo5IDp+/iRP3c5E7EGvmcqp04dZECA7E22rRQxu0APvZ5YI7iUXqp5PmA/CaY6+bAlP9VvOi7y30eSOwFrzDG7+jGwg+yv1RuN3Uz6Jv56hkoEvir57+kIABJN8/jF4cni1DR8LVqcDLYwJo5pL7KMPP3nmthCVzCeugxswfeLX+RU/JGLR6X1JYn0JW6lY0URSBNEEYG5AEgmvlAQk1H89st2EAAa+uXrGx4L9EJHfqtugLE0LM5MOz9mEtEHaT8OP4+guFzd9dR8SGsG4sPg31AG/i8d9d/7V63TAmPXpon5Pspjynt7n06bEZTjTgi4baMmCk9Uj5dekATC11CZTJwkQFBnC7GFZo/jVGSaRL+Z+BytUl08S0SsBvu8CSjc97e6tBq26OhPfv5RUhAW7hQvS8h8Wiqtf0+amiCVBtUS57twjslPi45Y4Tgn40JqHkJb6lzehlCBmzqbe7rhI+iEjj6Bs=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(30052699003)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	hjeuJk8782NBkRBaNxKZQwBtvN7hoHqM9hc/3umZNKCASGkZqv5dgdhAZzuDa81caVgnxiQ0dUNyBSXm3vnrHCOzBKjNRcYMlpbrQbIF/54c97rVZzTEA+aJiJeMHHbHDrGKAMY9I2IiR5TKA3BWxayNA5NC8q32CG64KgJOoDqaah39yasTZ5nUDIMnUJsNPrnX+kr7+6gW6vt+Xd2b2CcMZoBA15bi+kJirSEMnmYvN40nW7r0ODzPm3NR8NYREGv0jPfJjeJdrSiFwVt9OfMTY84kNgQZR4B0A8qAUnLZAtBo8oLZPjkpVPN+ufM/ENepHHRzRVT6L7EsYjxKMRL6Yqs6M+AZ6hq8D9hm/fR3gUajFA3lUQvluZLX7A8d9sHSsPmYn6AspLKatgVQv6XpHRB7QBwAs68tJ8o8kXNyMAL4c2ASmWmFIeQTur+b
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:03:49.1437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c458646-b2f9-4613-9d33-08de844f8a64
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB9671
X-Rspamd-Action: add header
X-Spamd-Result: default: False [4.50 / 15.00];
	URL_BACKSLASH_PATH(4.00)[0.0.0.0];
	URL_NUMERIC_IP(3.00)[0.0.0.0];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[foss.st.com:+];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.130.24:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DNSWL_BLOCKED(0.00)[40.107.130.24:from];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E6E4C43A9C
X-Spamd-Bar: ++++
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Hits: header-match-op-tee.lists.trustedfirmware.org-0
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
Message-ID-Hash: WAVDXNYNYS6UY23Y7A3PUBA6OTMMIKSH
X-Message-ID-Hash: WAVDXNYNYS6UY23Y7A3PUBA6OTMMIKSH
X-Mailman-Approved-At: Wed, 18 Mar 2026 11:58:53 +0000
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WAVDXNYNYS6UY23Y7A3PUBA6OTMMIKSH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
X-Spam: Yes

DQpNYWluIHVwZGF0ZXMgZnJvbSB2ZXJzaW9uIFYyMFs0XToNCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQpUbyBhZGRyZXNzIFJvYuKAmXMgY29uY2VybiBvbiB2MjBjb25jZXJuaW5n
IHJlc291cmNlIGRlY2xhcmF0aW9uIHVuZGVyIHRoZQ0KdGVlIG5vZGUsIHRoZSBkZXZpY2UgdHJl
ZSBpcyBub3cgc3RydWN0dXJlZCBhcyBmb2xsb3dzLHJlcGxhY2luZyB0aGUNCmNoaWxkLXBhcmVu
dCBoaWVyYXJjaHkgd2l0aCBhIHBoYW5kbGU6DQoNCiAgICBmaXJtd2FyZSB7DQogICAgICAgIHRl
ZV9ycHJvYzogb3B0ZWUtcnByb2Mgew0KICAgICAgICAgICAgY29tcGF0aWJsZSA9ICI4MGE0YzI3
NS0wYTQ3LTQ5MDUtODI4NS0xNDg2YTk3NzFhMDgiOw0KICAgICAgICB9Ow0KICAgIH07DQoNCiAg
ICBtNDogbTRAMCB7DQogICAgICBjb21wYXRpYmxlID0gInN0LHN0bTMybXAxLW00LXRlZSI7DQog
ICAgICByZWcgPSA8MCAwPjsNCg0KICAgICAgbWJveGVzID0gPCZpcGNjIDA+LCA8JmlwY2MgMT4s
IDwmaXBjYyAyPjsNCiAgICAgIG1ib3gtbmFtZXMgPSAidnEwIiwgInZxMSIsICJzaHV0ZG93biI7
DQoNCiAgICAgIG1lbW9yeS1yZWdpb24gPSA8JnZkZXYwdnJpbmcwPiwgPCZtX2lwY19zaG0+LCA8
Jm1jdXJhbTI+LA0KICAgICAgICAgICAgICAgICAgICAgIDwmdmRldjB2cmluZzE+LCA8JnZkZXYw
YnVmZmVyPiwgPCZyZXRyYW0+Ow0KDQogICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZleHRpPjsN
CiAgICAgIGludGVycnVwdHMgPSA8NjggMT47DQoNCiAgICAgIHJwcm9jLXRlZS1waGFuZGxlID0g
PCZ0ZWVfcnByb2MgMD47DQogICAgICBzdCxhdXRvLWJvb3Q7DQogICAgICB3YWtldXAtc291cmNl
Ow0KDQogICAgICBzdGF0dXMgPSAib2theSI7DQogICAgfTsNCg0KQXMgYSBjb25zZXF1ZW5jZSwg
dGhpcyB2ZXJzaW9uOg0KLSBVcGRhdGVzIHRoZSBkZXZpY2UgdHJlZSBhbmQgYmluZGluZ3MgdG86
DQogIC0gQ2hhbmdlIHRoZSBjb21wYXRpYmxlIHByb3BlcnR5IGZyb20NCiAgICAicnByb2Mtc2Vy
dmljZS04MGE0YzI3NS0wYTQ3LTQ5MDUtODI4NS0xNDg2YTk3NzFhMDgiIHRvDQogICAgIjgwYTRj
Mjc1LTBhNDctNDkwNS04Mjg1LTE0ODZhOTc3MWEwOCIuDQogIC0gVXNlIHRoZSBycHJvYy10ZWUt
cGhhbmRsZSB0byBhdm9pZCB0aGUgcGFyZW50LWNoaWxkIGhpZXJhcmNoeS4NCi0gVXBkYXRlcyBz
dG0zMl9ycHJvY190ZWUuYyBhbmQgcmVtb3RlcHJvY190ZWUuYyB0byBhZGFwdCB0byB0aGUgbmV3
IGJpbmRpbmdzLg0KLSBVcGRhdGVzIHJlbW90ZXByb2NfdGVlLmMgdG8gY29tcHV0ZSB0aGUgZGV2
aWNlIHRyZWUgY29tcGF0aWJsZSBzdHJpbmcgZnJvbQ0KICB0aGUgVEVFIFVVSUQuDQoNCk1haW4g
dXBkYXRlcyBmcm9tIHZlcnNpb24gVjE5WzNdOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NClRoZSBkZXZpY2V0cmVlIGlzIG5vdyBzdHJ1Y3R1cmVkIGFzIGZvbGxvd3M6DQoNCglm
aXJtd2FyZSB7DQoJCW9wdGVlIHsNCgkJCWNvbXBhdGlibGUgPSAibGluYXJvLG9wdGVlLXR6IjsN
CgkJCW1ldGhvZCA9ICJzbWMiOw0KCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQoJCQkjc2l6ZS1j
ZWxscyA9IDwwPjsNCgkJCXJwcm9jLXNlcnZpY2VAMCB7DQoJCQkJY29tcGF0aWJsZSA9ICJycHJv
Yy1zZXJ2aWNlLTgwYTRjMjc1LTBhNDctNDkwNS04Mjg1LTE0ODZhOTc3MWEwOCI7DQoJCQkJcmVn
ID0gPDA+Ow0KCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KCQkJCSNzaXplLWNlbGxzID0gPDA+
Ow0KCQkJCXN0YXR1cyA9ICJva2F5IjsNCgkJCQltNDogbTRAMCB7DQoJCQkJCWNvbXBhdGlibGUg
PSAic3Qsc3RtMzJtcDE1LW00LXRlZSI7DQoJCQkJCXJlZyA9IDwwPjsNCgkJCQkJbWJveGVzID0g
PCZpcGNjIDA+LCA8JmlwY2MgMT4sIDwmaXBjYyAyPjsNCgkJCQkJbWJveC1uYW1lcyA9ICJ2cTAi
LCAidnExIiwgInNodXRkb3duIjsNCgkJCQkJbWVtb3J5LXJlZ2lvbiA9IDwmdmRldjB2cmluZzA+
LAk8Jm1faXBjX3NobT4sIDwmbWN1cmFtMj4sDQoJCQkJCQkJPCZ2ZGV2MHZyaW5nMT4sIDwmdmRl
djBidWZmZXI+LCA8JnJldHJhbT47DQoJCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JmV4dGk+Ow0K
CQkJCQlpbnRlcnJ1cHRzID0gPDY4IDE+Ow0KCQkJCQlzdGF0dXMgPSAib2theSI7DQoJCQkJfTsN
CgkJCX07DQoJCX07DQoJfTsNCg0KQXMgYSBjb25zZXF1ZW5jZSwgdGhpcyB2ZXJzaW9uOg0KDQot
IEludHJvZHVjZXMgYSBuZXcgc3RtMzJfcnByb2NfdGVlLmMgcmVtb3RlcHJvYyBkcml2ZXIuDQoN
CiAgSW5zdGVhZCBvZiBmdXJ0aGVyIGNvbXBsaWNhdGluZyB0aGUgZXhpc3Rpbmcgc3RtMzJfcnBy
b2MuYyBkcml2ZXIsIGENCiAgZGVkaWNhdGVkIFRFRS1iYXNlZCBkcml2ZXIgaXMgYWRkZWQuIEJv
dGggZHJpdmVycyBhcmUgaW50ZW5kZWQgdG8gYWxzbw0KICBzdXBwb3J0IHRoZSBTVE0zMk1QMngg
Q29ydGV4LU0zMyByZW1vdGUgcHJvY2Vzc29yIGluIGEgbmV4dCBzdGVwLg0KDQotIFJld29ya3Mg
dGhlIGJpbmRpbmdzOg0KICAtIERyb3AgdGhlIHN0LHN0bTMyLXJwcm9jLnlhbWwgdXBkYXRlcyB0
aGF0IHdlcmUgaW50cm9kdWNlZCBpbiBwcmV2aW91cw0KICAgIHJldmlzaW9ucy4NCiAgLSBBZGQg
cmVtb3RlcHJvYy10ZWUueWFtbCBmb3IgdGhlDQogICAgInJwcm9jLXNlcnZpY2UtODBhNGMyNzUt
MGE0Ny00OTA1LTgyODUtMTQ4NmE5NzcxYTA4IiBjb21wYXRpYmxlLg0KICAtIEFkZCBzdCxzdG0z
Mi1ycHJvYy10ZWUueWFtbCBmb3IgdGhlICJzdCxzdG0zMm1wMTUtbTQtdGVlIiBjb21wYXRpYmxl
Lg0KDQotIFJld29ya3MgdGhlIHByb2Jpbmcgc2VxdWVuY2U6DQoNCiAgVGhlIG00QDAgZGV2aWNl
IGlzIG5vdyBwcm9iZWQgYnkgdGhlIHJlbW90ZXByb2MtdGVlIGRyaXZlciwgd2hpY2ggaXRzZWxm
DQogIGlzIGluc3RhbnRpYXRlZCBieSB0aGUgVEVFIChPUC1URUUpIGJ1cy4NCg0KDQpNYWluIHVw
ZGF0ZXMgZnJvbSB2ZXJzaW9uIFYxOFsyXToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQotIHJld29yayBkb2N1bWVudGF0aW9uIGZvciB0aGUgcmVsZWFzZV9mdyBvcHMgDQotIHJl
d29yayBmdW5jdGlvbiBkb2N1bWVudGF0aW9uIGluIHJlbW90ZXByb2NfdGVlLmMNCi0gcmVwbGFj
ZSBzcGlubG9jayBieSBtdXRleCBhbmQgZ2VuZXJhbGl6ZSB1c2FnZSBpbiByZW1vdGVwcm9jX3Rl
ZS5jDQoNCg0KTWFpbiB1cGRhdGVzIGZyb20gdmVyc2lvbiBWMTdbMV06DQotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KLSBGaXg6ICB3YXJuaW5nOiBFWFBPUlRfU1lNQk9MKCkgaXMg
dXNlZCwgYnV0ICNpbmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCiAgaXMgbWlzc2luZw0KDQoNCk1v
cmUgZGV0YWlscyBhcmUgYXZhaWxhYmxlIGluIGVhY2ggcGF0Y2ggY29tbWl0IG1lc3NhZ2UuDQoN
ClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yZW1vdGVwcm9jLzIwMjUwNjEzMDkx
NjUwLjIzMzc0MTEtMS1hcm5hdWQucG91bGlxdWVuQGZvc3Muc3QuY29tLw0KWzJdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJlbW90ZXByb2MvMjAyNTA2MTYwNzU1MzAuNDEwNjA5MC0x
LWFybmF1ZC5wb3VsaXF1ZW5AZm9zcy5zdC5jb20vDQpbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtZGV2aWNldHJlZS8yMDI1MDYyNTA5NDAyOC43NTgwMTYtMS1hcm5hdWQucG91bGlx
dWVuQGZvc3Muc3QuY29tLw0KWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJlbW90
ZXByb2MvMjAyNTEyMTcxNTM5MTcuMzk5ODU0NC0xLWFybmF1ZC5wb3VsaXF1ZW5AZm9zcy5zdC5j
b20vDQoNCg0KVGVzdGVkLW9uOg0KLS0tLS0tLS0tDQpjb21taXQgMWYzMThiOTZjYzg0ICgiTGlu
dXggNy4wLXJjMyIpDQoNCkRlc2NyaXB0aW9uIG9mIHRoZSBmZWF0dXJlOg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NClRoaXMgc2VyaWVzIHByb3Bvc2VzIHRoZSBpbXBsZW1lbnRhdGlvbiBv
ZiBhIHJlbW90ZXByb2MgdGVlIGRyaXZlciB0bw0KY29tbXVuaWNhdGUgd2l0aCBhIFRFRSB0cnVz
dGVkIGFwcGxpY2F0aW9uIHJlc3BvbnNpYmxlIGZvciBhdXRoZW50aWNhdGluZw0KYW5kIGxvYWRp
bmcgdGhlIHJlbW90ZXByb2MgZmlybXdhcmUgaW1hZ2UgaW4gYW4gQXJtIHNlY3VyZSBjb250ZXh0
Lg0KDQoxKSBQcmluY2lwbGU6DQoNClRoZSByZW1vdGVwcm9jIHRlZSBkcml2ZXIgcHJvdmlkZXMg
c2VydmljZXMgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgT1AtVEVFDQp0cnVzdGVkIGFwcGxpY2F0
aW9uIHJ1bm5pbmcgb24gdGhlIFRydXN0ZWQgRXhlY3V0aW9uIENvbnRleHQgKFRFRSkuDQpUaGUg
dHJ1c3RlZCBhcHBsaWNhdGlvbiBpbiBURUUgbWFuYWdlcyB0aGUgcmVtb3RlIHByb2Nlc3NvciBs
aWZlY3ljbGU6DQoNCi0gYXV0aGVudGljYXRpbmcgYW5kIGxvYWRpbmcgZmlybXdhcmUgaW1hZ2Vz
LA0KLSBpc29sYXRpbmcgYW5kIHNlY3VyaW5nIHRoZSByZW1vdGUgcHJvY2Vzc29yIG1lbW9yaWVz
LA0KLSBzdXBwb3J0aW5nIG11bHRpLWZpcm13YXJlIChlLmcuLCBURi1NICsgWmVwaHlyIG9uIGEg
Q29ydGV4LU0zMyksDQotIG1hbmFnaW5nIHRoZSBzdGFydCBhbmQgc3RvcCBvZiB0aGUgZmlybXdh
cmUgYnkgdGhlIFRFRS4NCg0KMikgRm9ybWF0IG9mIHRoZSBzaWduZWQgaW1hZ2U6DQoNClJlZmVy
IHRvOg0KaHR0cHM6Ly9naXRodWIuY29tL09QLVRFRS9vcHRlZV9vcy9ibG9iL21hc3Rlci90YS9y
ZW1vdGVwcm9jL3NyYy9yZW1vdGVwcm9jX2NvcmUuYyNMMTgtTDU3DQoNCjMpIE9QLVRFRSB0cnVz
dGVkIGFwcGxpY2F0aW9uIEFQSToNCg0KUmVmZXIgdG86DQpodHRwczovL2dpdGh1Yi5jb20vT1At
VEVFL29wdGVlX29zL2Jsb2IvbWFzdGVyL3RhL3JlbW90ZXByb2MvaW5jbHVkZS90YV9yZW1vdGVw
cm9jLmgNCg0KNCkgT1AtVEVFIHNpZ25hdHVyZSBzY3JpcHQNCg0KUmVmZXIgdG86DQpodHRwczov
L2dpdGh1Yi5jb20vT1AtVEVFL29wdGVlX29zL2Jsb2IvbWFzdGVyL3NjcmlwdHMvc2lnbl9ycHJv
Y19mdy5weQ0KDQpFeGFtcGxlIG9mIHVzYWdlOg0Kc2lnbl9ycHJvY19mdy5weSAtLWluIDxmdzEu
ZWxmPiAtLWluIDxmdzIuZWxmPiAtLW91dCA8c2lnbmVkX2Z3LnNpZ24+IC0ta2V5ICR7T1AtVEVF
X1BBVEh9L2tleXMvZGVmYXVsdC5wZW0NCg0KDQo1KSBJbXBhY3Qgb24gVXNlciBzcGFjZSBBcHBs
aWNhdGlvbg0KDQpObyBzeXNmcyBpbXBhY3QuIFRoZSB1c2VyIG9ubHkgbmVlZHMgdG8gcHJvdmlk
ZSB0aGUgc2lnbmVkIGZpcm13YXJlIGltYWdlDQppbnN0ZWFkIG9mIHRoZSBFTEYgaW1hZ2UuDQoN
Cg0KRm9yIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGltcGxlbWVudGF0aW9uLCBhIHByZXNl
bnRhdGlvbiBpcyBhdmFpbGFibGUgaGVyZQ0KKG5vdGUgdGhhdCB0aGUgZm9ybWF0IG9mIHRoZSBz
aWduZWQgaW1hZ2UgaGFzIGV2b2x2ZWQgYmV0d2VlbiB0aGUgcHJlc2VudGF0aW9uDQphbmQgdGhl
IGludGVncmF0aW9uIGluIE9QLVRFRSkuDQoNCmh0dHBzOi8vcmVzb3VyY2VzLmxpbmFyby5vcmcv
ZW4vcmVzb3VyY2UvNmM1Ykd2WndVQWpYNTZmdnh0aHhkcw0KDQpBcm5hdWQgUG91bGlxdWVuICg2
KToNCiAgZHQtYmluZGluZ3M6IGZpcm13YXJlOiBBZGQgVEVFIHJlbW90ZXByb2Mgc2VydmljZSBi
aW5kaW5nDQogIGR0LWJpbmRpbmdzOiByZW1vdGVwcm9jOiBBZGQgU1RNMzIgVEVFLWNvbnRyb2xs
ZWQgcnByb2MgYmluZGluZw0KICByZW1vdGVwcm9jOiBjb3JlOiBJbnRyb2R1Y2UgcnByb2NfcGFf
dG9fdmEgaGVscGVyDQogIHJlbW90ZXByb2M6IEludHJvZHVjZSBvcHRpb25hbCByZWxlYXNlX2Z3
IG9wZXJhdGlvbg0KICByZW1vdGVwcm9jOiBBZGQgVEVFIHN1cHBvcnQNCiAgcmVtb3RlcHJvYzog
c3RtMzI6IEFkZCBURUUtY29udHJvbGxlZCBTVE0zMiBkcml2ZXINCg0KIC4uLi9iaW5kaW5ncy9y
ZW1vdGVwcm9jL3JlbW90ZXByb2MtdGVlLnlhbWwgICB8ICAzNiArDQogLi4uL3JlbW90ZXByb2Mv
c3Qsc3RtMzItcnByb2MtdGVlLnlhbWwgICAgICAgIHwgMTA4ICsrKw0KIGRyaXZlcnMvcmVtb3Rl
cHJvYy9LY29uZmlnICAgICAgICAgICAgICAgICAgICB8ICAxMCArDQogZHJpdmVycy9yZW1vdGVw
cm9jL01ha2VmaWxlICAgICAgICAgICAgICAgICAgIHwgICAzICstDQogZHJpdmVycy9yZW1vdGVw
cm9jL3JlbW90ZXByb2NfY29yZS5jICAgICAgICAgIHwgIDUyICsrDQogZHJpdmVycy9yZW1vdGVw
cm9jL3JlbW90ZXByb2NfaW50ZXJuYWwuaCAgICAgIHwgICA2ICsNCiBkcml2ZXJzL3JlbW90ZXBy
b2MvcmVtb3RlcHJvY190ZWUuYyAgICAgICAgICAgfCA4MTAgKysrKysrKysrKysrKysrKysrDQog
ZHJpdmVycy9yZW1vdGVwcm9jL3N0bTMyX3Jwcm9jX3RlZS5jICAgICAgICAgIHwgNTM3ICsrKysr
KysrKysrKw0KIGluY2x1ZGUvbGludXgvcmVtb3RlcHJvYy5oICAgICAgICAgICAgICAgICAgICB8
ICAgNiArDQogaW5jbHVkZS9saW51eC9yZW1vdGVwcm9jX3RlZS5oICAgICAgICAgICAgICAgIHwg
IDkxICsrDQogMTAgZmlsZXMgY2hhbmdlZCwgMTY1OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9yZW1vdGVwcm9jL3JlbW90ZXByb2MtdGVlLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2Mvc3Qsc3RtMzItcnByb2Mt
dGVlLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9yZW1vdGVwcm9jL3JlbW90ZXBy
b2NfdGVlLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9yZW1vdGVwcm9jL3N0bTMyX3Jw
cm9jX3RlZS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvcmVtb3RlcHJvY190
ZWUuaA0KDQoNCmJhc2UtY29tbWl0OiAxZjMxOGI5NmNjODRkN2MyYWI3OTJmY2MwYmZkNDJhN2Nh
ODkwNjgxDQotLSANCjIuNDMuMA0KDQo=
