Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3523A108B8E6
	for <op-tee@archiver.kernel.org>; Fri, 20 Mar 2026 09:58:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6185043AD4
	for <op-tee@archiver.kernel.org>; Fri, 20 Mar 2026 09:58:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=OejwxGQZ;
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013006.outbound.protection.outlook.com [52.101.72.6])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DD10643AC2
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Mar 2026 09:58:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvdlmVWEnaDd/9uU/geVulVuM/BkRHd6Cn6zC39LpymsIc/Wl85ZWGmac/05kzHp6bJWoaWzOHWwwVgOJ6nJH/YRCAtFUXRXpk4iunKRpbLW014nCVmmLjhfshNojW3OpacXUbutNjBLNd2ERaxO4b5hfOv86Q9OwlO4+pSMFRZUA06cuejPn3ztQCFSfjzJxJpBU2IWjQ1uRBQBnJcfFn52e4z5iLCUD2mIKtyuxgOdw26vfuhkNswSo3Zaig3OhXAsFKGccXegMVZwaMryE2tTJHLUvlo0VfIeaCr4sJYUrAfddBRQk7myN2nqAF/lwc/g8ZpZQwi46y8YHxW1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6f8KIaTB3VIRYAauVWqQbIbdfBj7xAZYF8Z0O/Xw64=;
 b=eXGETTRkzsvYwESPO4b0ZpWRAM7HF/hWtbQL6TyN9W9F9Uj+WQJ9o1sBA+0AayAOJcAnNaOBddqC8867flbR+BC/MUVhH1g3YLwwbi5frw+sdVGL1+3ftbUusYHcE1okhNayQYA/mmSbPGbEVgeLyCQl9rtKtfdly1bWErA285Dw3IMsSrLaGN/ZhaqFvixjQCRRQacCHzsieun10KFG8qaRRabDlvzOdEKtk9GuczPQdwSZnspvTwcv+pT0wGk6WxmrmJ3alpBKze89R5bEaFEMPgvOR9Mm1hUDSzharFrb4ucaumhVIbGpO7gKOfL2pULgt/qUwlqoeHgdcd1eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6f8KIaTB3VIRYAauVWqQbIbdfBj7xAZYF8Z0O/Xw64=;
 b=OejwxGQZ+qviuiCYiUl21BkcgI5Wfi23UZJwgDTepjWJL0g7rYXkqGS3ykR48hst2nLArU+Tujt7ii6RDPFtWBkdnKivC9WK77EiAxWNav0AwYgs5a3HbDIYfQNZvuuDCXLzbdc+uv0DUDUtYk4dEd9bV79raORmKHEPrKOfELmAmpHu06RY7ke54eoOrAa73k5FMAqoMt4FmPwi6eYpPCoiYN0lurY7SXKGlGnrYPkML7wUa3RnXXuHII8UBzoNsqDOBzfGVzULd2E14ptikQYbzKxhViOLQtGiwTV+DSudvKcM7Pr5pNe2GW0ngFbdSQOUNPGfXaxwJVwi/Ib6Pg==
Received: from DU2PR04CA0022.eurprd04.prod.outlook.com (2603:10a6:10:3b::27)
 by PAWPR10MB7675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Fri, 20 Mar
 2026 09:58:19 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:3b:cafe::c5) by DU2PR04CA0022.outlook.office365.com
 (2603:10a6:10:3b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 09:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 09:58:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 11:00:55 +0100
Received: from [10.48.87.127] (10.48.87.127) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Fri, 20 Mar
 2026 10:58:17 +0100
Message-ID: <df0a0d1c-5cc2-4ec6-99d3-30b8f9ac593a@foss.st.com>
Date: Fri, 20 Mar 2026 10:58:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 2/6] dt-bindings: remoteproc: Add STM32 TEE-controlled
 rproc binding
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
 <20260317180329.1207625-3-arnaud.pouliquen@foss.st.com>
 <20260319-glistening-ultramarine-ibis-1eb3d6@quoll>
 <420953af-6a12-4277-8c31-062db01f78cc@foss.st.com>
 <0068d43a-e875-4f4e-aff6-3e8330e66c82@kernel.org>
Content-Language: en-US
From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
In-Reply-To: <0068d43a-e875-4f4e-aff6-3e8330e66c82@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.48.87.127]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|PAWPR10MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e1aca9-5303-4ff9-0678-08de866736bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|82310400026|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	I18KFJ5HdPw/cywMGwjEGNSVvK4KVIdI8ZF0dObBibscNKDIU+4ZkqFXC7mNUaweJeByGIvligXv52ZAnKq9B6cy1RFhVp4zw5SQ3VnHZwcJaqLJJV0audhJZOukAOYoVZ17kT8QQSJKebL2tCdLjts1bf7W7NtiBaEq77BsLyaTdSwbW530ZXvrNvAvVxN9mUkwV727mKBS7RtWIYfiNYCvZ9Z5Uld+nlVIEyImI5uNFHX0jDAmdtWv+tVf+EFoZ3syZr+4sASNaksMxMtK2SIH/hbzm1ScjRPxvlmoJHzhs1ysu4apcAWK18IYyE8ikL0pBCpI6hOd8WpOOtM09Yt+NYPpQO1oiEjE7ImHxiTIQQC7ekxy6e64nqY2F+FIPonTanOt3ovrtwyg1J1dcnuWb+b3K0hZEP4n0AlDsrZr1L9QTcRV5oIyNBK/EzwvzzpT6H4aTkdwLUEmuBknCVB213IRTH8vSZTvkLyIj7GAPiWKVvFGkAUEJtKHEylz7IxT3cYiUkjJ651WreGjUJgw+GVVotSeAyk92O+EmJ/WiO0nKsB47pz2ioKLfjkZTfpTBhDH3M3vZ4VUQuWuDRGtLNcKgYO6+Dwf+r1LyMigQ2WnTuH3PgxGODdBGJWE6/c7XTZzE0q1OoyKtTeBvdKdqI9awXopmeD6hYqox0F21dR9rIvA3zcMEZaPXPTgLtSbM/sR3L6ABsa4UsiD3BDPn/CKpH6QHyaVfPFrGHQ=
X-Forefront-Antispam-Report: 
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(82310400026)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	zDaOSdoe0ff4mUTHRLkP8ZrsqSFwHCaspMRFRUGHdoN0Br9uP3RYqwNVThx9gqXO+gPHxXxhZhfncR0en29ElzJ578HHzbEoxQOKyvZY0KKFxypYIBDjuMs6SDPl/VIpQTGrkUreEmhUT1LGBhJqsm5x+vDrnLX9jpdud+BlP209NrdfcxAsBAR8BT603Ybnzv/NX0vqRUZ5xivMDMHxVpiOb784yoNtaJ96mR/WEfe4RPaLhojc99Fl5zf3KVbdzEeERFaCk+aL8LgFUbkhjGjWuQmub6XbhexrxuxmxRWX0nZ0BNvPqEcJNFqYLgzTKsQlvMqO9ksxM3Ctc9MyhIxJ2ScqO5aUGo+PoZTU6m2wPY3f1b7oYje3qmYfAkXx8Ms0lSB9PiGfiQ7jwEH7CfS5HfNEWLNenlt/Wdb2wR/GBXW4RpCfLRQBUa6TalGe
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 09:58:19.0181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e1aca9-5303-4ff9-0678-08de866736bc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7675
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:52.100.0.0/15];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_TRACE(0.00)[foss.st.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:8075, ipnet:52.96.0.0/12, country:US];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[52.101.72.6:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2603:10a6:10:3b::27:received];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[52.101.72.6:from]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: DD10643AC2
X-Spamd-Bar: ---
Message-ID-Hash: K2WWLHO2YYJQAF6AQ2ZW5G2V2OKUM5XM
X-Message-ID-Hash: K2WWLHO2YYJQAF6AQ2ZW5G2V2OKUM5XM
X-MailFrom: arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/K2WWLHO2YYJQAF6AQ2ZW5G2V2OKUM5XM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

DQoNCk9uIDMvMTkvMjYgMTE6NDEsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIDE5
LzAzLzIwMjYgMTE6MzEsIEFybmF1ZCBQT1VMSVFVRU4gd3JvdGU6DQo+PiBIZWxsbyBLcnp5c3p0
b2YsDQo+Pg0KPj4NCj4+IE9uIDMvMTkvMjYgMDk6MDYsIEtyenlzenRvZiBLb3psb3dza2kgd3Jv
dGU6DQo+Pj4gT24gVHVlLCBNYXIgMTcsIDIwMjYgYXQgMDc6MDM6MjNQTSArMDEwMCwgQXJuYXVk
IFBvdWxpcXVlbiB3cm90ZToNCj4+Pj4gQWRkIGEgRGV2aWNlIFRyZWUgYmluZGluZyBmb3IgdGhl
IFNUTTMyIHJlbW90ZSBwcm9jZXNzb3IgY29udHJvbGxlZA0KPj4+PiB2aWEgYSBUcnVzdGVkIEFw
cGxpY2F0aW9uIHJ1bm5pbmcgaW4gT1AtVEVFLg0KPj4+PiBUaGlzIGJpbmRpbmcgZGVzY3JpYmVz
IHRoZSBpbnRlcmZhY2UgYW5kIHByb3BlcnRpZXMgcmVxdWlyZWQgZm9yIFNUTTMyTVANCj4+Pj4g
cmVtb3RlcHJvYyBpbnN0YW5jZXMgbWFuYWdlZCBieSB0aGUgVEVFIHJwcm9jIHNlcnZpY2UsIGlu
Y2x1ZGluZyBhDQo+Pj4+IGxpbmthZ2UgdG8gdGhlIFRFRSBiYWNrZW5kIHRocm91Z2ggdGhlIHBy
b3BlcnR5ICJycHJvYy10ZWUtcGhhbmRsZSIuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEFy
bmF1ZCBQb3VsaXF1ZW4gPGFybmF1ZC5wb3VsaXF1ZW5AZm9zcy5zdC5jb20+DQo+Pj4+IC0tLQ0K
Pj4+PiBWMjEgdXBkYXRlczoNCj4+Pj4gLSB0aGUgbTQgbm9kZSBpcyBubyBtb3JlIGRlY2xhcmVk
IGFzIGEgY2hpbGQgb2YgdGhlIG9wdGVlLXJwcm9jIG5vZGUNCj4+Pj4gLSAicnByb2MtdGVlLXBo
YW5kbGUiIHByb3BlcnR5IGlzIGludHJvZHVjZWQgdG8gcmVmZXJlbmNlIHRoZSBvcHRlZS1ycHJv
Yw0KPj4+PiAtLS0NCj4+Pj4gICAgLi4uL3JlbW90ZXByb2Mvc3Qsc3RtMzItcnByb2MtdGVlLnlh
bWwgICAgICAgIHwgMTA4ICsrKysrKysrKysrKysrKysrKw0KPj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMTA4IGluc2VydGlvbnMoKykNCj4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL3N0LHN0bTMyLXJwcm9jLXRlZS55
YW1sDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcmVtb3RlcHJvYy9zdCxzdG0zMi1ycHJvYy10ZWUueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL3N0LHN0bTMyLXJwcm9jLXRlZS55YW1sDQo+
Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uY2E0ZGQx
YzhlN2IwDQo+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2Mvc3Qsc3RtMzItcnByb2MtdGVlLnlhbWwNCj4+Pj4g
QEAgLTAsMCArMSwxMDggQEANCj4+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwt
Mi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4+Pj4gKyVZQU1MIDEuMg0KPj4+PiArLS0tDQo+Pj4+ICsk
aWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3JlbW90ZXByb2Mvc3Qsc3RtMzItcnBy
b2MtdGVlLnlhbWwjDQo+Pj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1z
Y2hlbWFzL2NvcmUueWFtbCMNCj4+Pj4gKw0KPj4+PiArdGl0bGU6IFNUTWljcm9lbGVjdHJvbmlj
cyBTVE0zMiByZW1vdGUgcHJvY2Vzc29yIGNvbnRyb2xsZWQgdmlhIFRFRQ0KPj4+PiArDQo+Pj4+
ICttYWludGFpbmVyczoNCj4+Pj4gKyAgLSBBcm5hdWQgUG91bGlxdWVuIDxhcm5hdWQucG91bGlx
dWVuQGZvc3Muc3QuY29tPg0KPj4+PiArDQo+Pj4+ICtkZXNjcmlwdGlvbjogfA0KPj4+PiArICBT
VE0zMk1QIHJlbW90ZSBwcm9jZXNzb3IgY29udHJvbGxlZCBieSBhIFRydXN0ZWQgQXBwbGljYXRp
b24NCj4+Pj4gKyAgcnVubmluZyBpbiBPUC1URUUuIFRoaXMgbm9kZSBpcyBhIGNoaWxkIG9mIHRo
ZSBURUUgcmVtb3RlcHJvYyBzZXJ2aWNlDQo+Pj4+ICsgIChVVUlEIDgwYTRjMjc1LTBhNDctNDkw
NS04Mjg1LTE0ODZhOTc3MWEwOCkgYW5kIGV4cG9zZXMgYSByZW1vdGVwcm9jDQo+Pj4+ICsgIGlu
c3RhbmNlIG1hbmFnZWQgYnkgdGhlIExpbnV4IHJlbW90ZXByb2MgY29yZSB2aWEgdGhlIFRFRSBy
cHJvYyBzZXJ2aWNlLg0KPj4+PiArDQo+Pj4+ICsgIEZpcm13YXJlIGxvYWRpbmcsIGF1dGhlbnRp
Y2F0aW9uIGFuZCByZW1vdGUgcHJvY2Vzc29yIHN0YXJ0L3N0b3AgYXJlIG1hbmFnZWQNCj4+Pj4g
KyAgYnkgdGhlIFRFRSBhcHBsaWNhdGlvbi4gVGhlIFNUTTMyLXNwZWNpZmljIGRyaXZlciBoYW5k
bGVzIHBsYXRmb3JtIHJlc291cmNlcw0KPj4+PiArICBzdWNoIGFzIHRoZSBtYWlsYm94ZXMgYW5k
IHJlc2VydmVkLW1lbW9yeS4NCj4+Pj4gKw0KPj4+PiArcHJvcGVydGllczoNCj4+Pj4gKyAgY29t
cGF0aWJsZToNCj4+Pj4gKyAgICBjb25zdDogc3Qsc3RtMzJtcDEtbTQtdGVlDQo+Pj4NCj4+PiBE
cm9wICJ0ZWUiLCBpdCBzdWdnZXN0cyB0aGF0IGNvbXBhdGlibGUgaXMgdGllZCB0byBpbXBsZW1l
bnRhdGlvbiBvZiBGVw0KPj4+IHlvdSBwdXQgdGhlcmUuDQo+Pg0KPj4gVGhlICJzdCxzdG0zMm1w
MS1tNCIgY29tcGF0aWJsZSBzdHJpbmcgYWxyZWFkeSBleGlzdHMgaW4NCj4gDQo+IFRoZW4gcHJv
YmFibHkgdGhpcyBiaW5kaW5nIG5lZWRzIGNoYW5nZXMsIGJlY2F1c2UgaW4gZ2VuZXJhbCB5b3Ug
c2hvdWxkDQo+IG5vdCBoYXZlIHR3byBjb21wYXRpYmxlcyBmb3IgdGhlIHNhbWUgaGFyZHdhcmUu
IE1heWJlIHRoYXQncyBzcGVjaWFsDQo+IGNhc2UsIGJ1dCB0aGVuIG5lZWRzIGV4cGxhbmF0aW9u
cyBpbiBjb21taXQgbXNnIHdoeSBpcyB0aGF0Lg0KPiANCj4+IGRyaXZlcnMvcmVtb3RlcHJvYy9z
dG0zMl9ycHJvYy5jLCBhbmQgInN0LHN0bTMybXAxLW00LXRlZSIgY29tcGF0aWJsZSBpcw0KPj4g
dXBzdHJlYW1lZCBpbiBPUC1URUUuDQo+IA0KPiBUaGF0IGlzIG5vdCBvdXIgcHJvYmxlbSBhbmQg
c3Ryb25nIG5vLWdvLiBPdGhlciBwcm9qZWN0cyBhcmUgc3VwcG9zZWQgdG8NCj4gcGFydGljaXBh
dGUgaW4gdXBzdHJlYW0gYmluZGluZ3MgcmV2aWV3IGFuZCB0YWtlIHRoZSBiaW5kaW5ncyBvbmNl
IHRoZXkNCj4gYXJlIHJldmlld2VkIGFuZCBhY2NlcHRlZCBoZXJlLiBJZiB0aGV5IHRha2Ugd2l0
aG91dCByZXZpZXcsIGl0J3MgdGhlaXINCj4gcHJvYmxlbS4NCj4gDQo+IEltYWdpbmUgdGhhdDog
c29tZSB3aGF0ZXZlciBwcm9qZWN0IHRha2VzIHdoYXRldmVyIGNyYXAgKG5vdCBzYXlpbmcNCj4g
T3B0ZWUgaXMgbGlrZSB0aGF0LCBqdXN0IGltYWdpbmUgZm9yIHNha2Ugb2YgZGlzY3Vzc2lvbikg
YW5kIHRoZW4geW91DQo+IHNlbmQgYmluZGluZ3MgdG8gdXBzdHJlYW0gYW5kIGNsYWltICJ0aGF0
IHByb2plY3QgdG9vayBpdCwgc28geW91IG11c3QNCj4gZG8gYXMgd2VsbCIuIEdyZWF0IGxvb3Bo
b2xlIHRvIHNxdWVlemUgcG9vciBzdHVmZiB0byB0aGUga2VybmVsLCBzbyBhbnkNCj4gc3VjaCBh
cmd1bWVudCBpcyBmb3IgbWUgYSB3YXJuaW5nIHNpZ24uDQo+IA0KPiANCj4+DQo+PiBOb3RpY2Ug
dGhhdCBJIGhhdmUgYWxzbyB0aGUgc3RtMzJtcDIgU29DIHRvIHVwc3RyZWFtIGV4cGVjdGluZyB0
byBoYXZlDQo+PiBzaW1pbGFyIGNvbXBhdGlibGU6DQo+PiAtIHN0LHN0bTMybXAxLW0zMw0KPj4g
LSBzdCxzdG0zMm1wMi1tMzMtdGVlDQo+Pg0KPj4gRGVwZW5kaW5nIG9uIHRoZSBjb21wYXRpYmxl
IHN0cmluZywgdGhlIGhhcmR3YXJlIGJlaGF2aW9yIGNoYW5nZXMuDQo+PiBXaXRoIHRoZSAieHh4
eC10ZWUiIGNvbXBhdGlibGUsIE9QLVRFRSBhbHNvIG1hbmFnZXMgdGhlIGlzb2xhdGlvbiBvZg0K
Pj4gcmVtb3RlIHByb2Nlc3NvciByZXNvdXJjZXMgKG1lbW9yeSwgY2xvY2sgcmVzZXQsIHBlcmlw
aGVyYWxzKS4NCj4+IFdpdGhvdXQgdGhlICJ4eHh4LXRlZSIgY29tcGF0aWJsZSwgT1AtVEVFIGhh
dmUgdG8gZW5zdXJlIHRoYXQgdGhlIExpbnV4DQo+PiBoYXMgdGhlIGdvb2QgYWNjZXNzIHJpZ2h0
IHRvIG1hbmFnZSB0aGUgcmVtb3RlIHByb2Nlc3Nvci4NCj4gDQo+IFN0aWxsIHRoZSBzYW1lIGRl
dmljZSwgbm8/DQo+IA0KPiBZb3UgY2FuIGhhdmUgYSBwcm9wZXJ0eSBkZWZpbmluZyBob3cgTGlu
dXggc2hvdWxkIGFjY2VzcyBzdWNoIGRldmljZSwNCj4gZS5nLiBiZWNhdXNlIEZXIGRvZXMgdGhp
cyBhbmQgdGhhdC4NCj4gDQo+Pg0KPj4gRm9yIGluc3RhbmNlIGlmIHN0LHN0bTMybXAxLW00LXRl
ZSBpcyBzZXQgaW5zdGVhZCBvZiBzdCxzdG0zMm1wMS1tNCwgb24NCj4+IGxpbnV4IHNpZGUNCj4+
IC0gb25seSBtZW1vcnkgcmVnaW9ucyB1c2VkIGZvciBJUEMgc2hvdWxkIGJlIGRlY2xhcmVkDQo+
PiAtIG1lbW9yeSByZWdpb25zIGNvbnRhaW5pbmcgdGhlIHJlbW90ZSBmaXJtd2FyZSBtdXN0IG5v
dCBiZSBkZWNsYXJlZCBhcw0KPj4gbm90IGFjY2Vzc2libGUgYnkgdGhlIExpbnV4ICggbWFuYWdl
ZCBieSBPUC1URUUpLg0KPj4gLSByZXNldHMgbXVzdCBub3QgYmUgZGVjbGFyZWQgKCBtYW5hZ2Vk
IGJ5IE9QLVRFRSkNCj4+DQo+PiBZb3UgcHJvYmFibHkgZG9uJ3QgcmVtZW1iZXIsIGFzIGl0IHdh
cyBhIGxvbmcgdGltZSBhZ28sIGJ1dCB3ZSBhbHJlYWR5DQo+PiBkaXNjdXNzZWQgdGhpcyBwb2lu
dCB3aXRoIFJvYlsxXS4NCj4+IFsxXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyNC8xLzE4LzEw
MA0KPj4NCj4+IERvIGl0IHN0aWxsIHJlYXNvbmFibGUgdG8geW91IGFuZCBSb2Igb3Igc2hvdWxk
IHdlIGZpbmQgYW4gYWx0ZXJuYXRpdmU/DQo+IA0KPiBHZXQgYWNrIGZyb20gUm9iIHRoZW4uDQoN
CkEgcHJldmlvdXMgYWNrbm93bGVkZ21lbnQgZnJvbSBSb2Igd2FzIGdpdmVuIGhlcmU6IA0KaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMjQvMi8yMi8xMjY0Lg0KDQpXaGF0IGZydXN0cmF0ZXMgbWUg
aXMgdGhhdCwgaWYgdGhlIGNvbXBhdGlibGUgdXNhZ2UgaXMgbm8gbG9uZ2VyIA0KYWNjZXB0ZWQs
IEkgaGF2ZSBsb3N0IHRpbWUgYmFzaW5nIGFsbCBteSBvdGhlciB2ZXJzaW9ucyBvbiB0aGlzIA0K
YXNzdW1wdGlvbi4gQnV0IHRoYXTigJlzIHBhcnQgb2YgdGhlIGdhbWUsIGFuZCB0aGlzIHNlcmll
cyBpcyBhbHJlYWR5IGEgDQpjb25jYXRlbmF0aW9uIG9mIHJlZGVzaWducyByZXN1bHRpbmcgaW4g
dmVyc2lvbiBWMjEuDQoNCk15IGV4cGVjdGF0aW9uIGlzIHNpbXBseSB0aGF0IHlvdSBhbmQgUm9i
IHByb3ZpZGUgbWUgd2l0aCBhIGNsZWFyIA0KZGlyZWN0aW9uIHRvIG1vdmUgZm9yd2FyZC4NCg0K
VGhlIGNvbXBhdGlibGUgc3RyaW5nIGlzIG9uZSB0b3BpYzsgSSBhbHNvIG5lZWQgYW4gYWNrbm93
bGVkZ21lbnQgb3IgDQpyZWplY3Rpb24gb2YgdGhlIGNvbmNlcHQgb2YgdXNpbmcgYSBwaGFuZGxl
IHRvIGxpbmsgdGhlIHJlbW90ZXByb2MgDQpkcml2ZXIgd2l0aCB0aGUgVEVFIHNlcnZpY2UuDQoN
ClRoYW5rcyBhbmQgcmVnYXJkcywNCkFybmF1ZA0KDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K
