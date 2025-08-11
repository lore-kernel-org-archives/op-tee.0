Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74298C87FDB
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id AB3E44FCC5
	for <op-tee@archiver.kernel.org>; Mon, 11 Aug 2025 10:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1754906443;
	bh=CGG4/LStlBzu2dJDOHxK2vgfiyGVVv1osWtJefo6e3U=;
	h=To:Subject:Date:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=CY5oeX4ouiK3rgChtI0xZ7RSBx7xDs8pVBdceanrkwGc3ZP54IrVNBDihHWorbT58
	 +62svKH1lGWoa67H0mA7qJZsx499uExPkUDUaeum/Rm8eWU9OVRrOJUfUd0wzOe3qI
	 P7DXFIKvOSA/6edGc8Qd5YJz4Hngv/fd8ocvCJ1lCip61IH8JMtNkNHp8um9+JsWPh
	 zZt1vyWrhk5yxEXqfWG44aCeNouuOXy7YQoV0HMIn5u9T+/Dx+yFmYi+QHvV3BaB2b
	 tpttCWupgrPUxtlmD4xeJ8KaCT6P7WDj5qQ2q+HOd9nTB2OgFkEVGwVb7CVWahOn7A
	 Njd/3mPjCtwjw==
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3F71F3F67A
	for <op-tee@lists.trustedfirmware.org>; Mon, 11 Aug 2025 10:00:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GgzRQN/3;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbYHLvw8fwawAXJu4H1YgBmSrTDtvXREV45Zbv+PtdqoEotJKMbNS3zOzCgS6Qk0BkaIMUVQo1ZJQsbOU2gq8FajcZLx6JAzdJ0fiGXVELiGOCW4KwjDgqzZNojZjKyrqiZO6Tqf4t0n7l/1Fk67n39TU+C93N2XLPUgI4qU4kXlQRWFRAUHRNo0XWqQE9qluCZZDI1rooBDxvqWzvIlZE3NL3FXmCw2/n6386Zi9qu69s837UwSIt5nNb36ONL1kbgnQ0Vqq79Gy12vySFHz2lvJDre1L7w8qHEq+fNGLakoWSi+8RAmd5KdebIJ3NXkBgF1jUIZfNhtZXeXGII5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lRXBuWTabxhxFXcRVKd4RtEJhamM+L4oNRxFKsX21A=;
 b=CxyjX/83FFSB7veMDGhht7Dgl2dbs1rdAAw1t7i7OrAjqp62YvIQlnGhcew7qh/+3ylQmFs2XaLmLci6bDJ5c7oGYke4S7SROe5gSdVBtb3n3W3QQmP35oP8Nkdqz33kNPBZR+2QKtWlBMxtsyJib1lkcy5tBqiKuIGGNHrurckUnO+3RbS/lOIjopuSUPKDT5QZL0C3rCvBNSYWxhB8C6MwKjagh2c9NBBND6Jb8//JUOqY4/6iLyK9joyIF46pXyz7MgIrkmDVPHYbRe+1FMTHngF4M5J1A9Jlyo5Lc3UCCFJAnBc6ULc1pgztdUNGqm6yPfDmEgHIcDrqHm7wPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lRXBuWTabxhxFXcRVKd4RtEJhamM+L4oNRxFKsX21A=;
 b=GgzRQN/3qceAnQdfo90nJryCvh7WN1AjxIlG+q55TOYvhgxCXkClCr9Oy654QNHQJXs9Coc/geo074Cc83w8WhWkNEuSDYAhYvM9KyYxrTKD5WfBHiZ84lxmFxKdZzQQDaW56yHxTGnse4qM9VfHlvxsUK6XXSTbQvONmydSGvsTop01zE9WgKCxl+zsb/hUevxp0DCzJNky/VUErE93OSUUXYLBeCf+KtbuHAL+80RL/9e8zZ3CZkHd+hgGdnaAwT6vVZcHgP96TblfbraQtiFeIutuVoeS8ZMaei1FisZstCcyHlwymz+kFKFLJ8M3Vie4BZZolef4f1kHWvO9ww==
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22)
 by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Mon, 11 Aug
 2025 10:00:17 +0000
Received: from SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a]) by SJ2PR12MB8689.namprd12.prod.outlook.com
 ([fe80::3cb1:e344:6d7d:106a%3]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:00:17 +0000
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Thread-Topic: [PATCH] tee: optee: ffa: fix a typo of
 "optee_ffa_api_is_compatible"
Thread-Index: AQHcBs/od8WYF4SHx06Prusko333frRc94UAgABIFO0=
Date: Mon, 11 Aug 2025 10:00:17 +0000
Message-ID: 
 <SJ2PR12MB8689AE34D74E657EFC3055F7B828A@SJ2PR12MB8689.namprd12.prod.outlook.com>
References: 
 <SJ2PR12MB86897F31237163137445D7CAB82DA@SJ2PR12MB8689.namprd12.prod.outlook.com>
 <aJmChHa_BxNO74cB@sumit-X1>
In-Reply-To: <aJmChHa_BxNO74cB@sumit-X1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8689:EE_|SJ5PPFF6E64BC2C:EE_
x-ms-office365-filtering-correlation-id: 4f1df01c-c9f2-45aa-74e3-08ddd8bddfd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?r2lhUw1Pkg4ZIj6jQRJZ3HR+twO25rUimpVkdBxJF2w50e2rYOrlDqfTZu?=
 =?iso-8859-1?Q?Z0iY+aRsVo46Y1HKbQ9Z1EBLMZtdsFE/1lqeGzqPa8fa6m1wPnUjI+s6sU?=
 =?iso-8859-1?Q?QzFf2P0ia17RUD8na7kyGs8VaEXaD2d7hVEMWVUol276K6do5MgSBHMKEH?=
 =?iso-8859-1?Q?Wp+c2esGX0+EAC9OYDdwaC4xbCgD+oKQYtAbstUgqG2ZOR2p/IeYOwG1/8?=
 =?iso-8859-1?Q?k3ggQf2J8BXse5IupJfoDK6YqM95Eg6gKd7P8zD0slr4Pg9rBOGGAv2aCA?=
 =?iso-8859-1?Q?LP8igmMOUVJV6o6g235POxJ67JmSK9Wd6NX8y+iqiCZfa4I2R/jMZfm9hi?=
 =?iso-8859-1?Q?q0/sjZ7WzceEgOFcBQofvakhL8DliUm6q7Icw4WJcqGc+Egkxv0UHF0rEp?=
 =?iso-8859-1?Q?kJebvHro8i7YH+0GPknF9Lh4kpaDcu8ezIOvt5R895WTytSOxJRrZTwOEb?=
 =?iso-8859-1?Q?j/VRAPysKHYRJ4eO1yYnNYldrpWtiit42TuDL1MsaP+XcSmqDhDH/SobUY?=
 =?iso-8859-1?Q?xO4V0BdM/yvq1GRt7PY7Pi/19Rfkyn3yGsjQ6RCsz7JdlTZ5s9CKpj26nt?=
 =?iso-8859-1?Q?orsJWjbRahvP8O+w0kgjQVynCouSRZ/ghdyij4B3LwEwAhD43FA78ToZjV?=
 =?iso-8859-1?Q?WCOikjdf/rQFDNGLa4GJp9AbBNTBMd50Gd4VAm0JNnAjRlsfQUcHt+RzPP?=
 =?iso-8859-1?Q?/Ylwhc7MjLTSLfUojWgPEAMzrNTa9XQrwkkKBjqQYoIw8jLOadi2eb32SV?=
 =?iso-8859-1?Q?3BC9s6ZjrfREUc8oBXi/PowHSOdwJpOm9nz9A30PZcIcDq1Qy9vZOTvFbG?=
 =?iso-8859-1?Q?akOeQwnciai3fawiVWCEXLiRfU0YUuTslUTdTsU3+5GkdZSdaRbQUYxnfl?=
 =?iso-8859-1?Q?mPz/i/FfHgJqiBWq4UxgR9RC8JmNfqxrkAgzC5K0QTTa1qjOq+/LHU7jZn?=
 =?iso-8859-1?Q?hlDxkqOGgPOTrJiqC8NObtr2SgyWoaOYfOyLpnHiqjQ0z5saBsITNhB2EE?=
 =?iso-8859-1?Q?xFO+UtryNc1Kk0w9FJi6C/8dBy+Th+Nw5J/Nl9qo5u2TNSoWrUZob0ZlSb?=
 =?iso-8859-1?Q?JLQbc2eqdiDgtPy5d3B9NQBvufE4CIoYq4FjMWWktDmPQ7hJZfJOcEPtRa?=
 =?iso-8859-1?Q?lawYLNu0I1B/ugxY24RJG33XqprOOqlxvZzRifn/1xKAk2vwcK4Uaqi/bv?=
 =?iso-8859-1?Q?LVjSkED3enboGZO++zQ8Ziw4r8BCpZIpeN8NYDzH029cyOttFJ6GQpuU8i?=
 =?iso-8859-1?Q?dF6a+7eH2xRn3ch56WZpMxhaLj32T1phQ5ARRr7bkJncsHMFEkaJzhqLJQ?=
 =?iso-8859-1?Q?xC/Oq5HVEcdkswVOwtLqWVxSTE+oQAf1twxKI4uDEo8jCziqpy8RW8GFs8?=
 =?iso-8859-1?Q?30wyT9g1adVqKS7Qu1jF3loXOtI+XOlWbmT0+LD5PD/mAWrVwAsCJ2i4ye?=
 =?iso-8859-1?Q?doLowkukLj12RVy1LoI4BTBsPHMaly+nkyCSOvX24mpA2VoYgpy1zti7dj?=
 =?iso-8859-1?Q?uTzoPsJv7R5aO8nzPEngANACFCMvwtQ4QJ5NFEO/7WkQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8689.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?9F158vHB7epSJ9MsMUxFi9blm6Pylycw8Qr9PnmNkl0LNDqsDuRzq3JaFm?=
 =?iso-8859-1?Q?dV2MkZ11sZVad03fDIEl8Uva8wIrEV8hUo3JA7+QAUdFDjNGSfBjfQ9XFb?=
 =?iso-8859-1?Q?0NbiHmw3qmSKYW4/FsBknl7B2mHIQUQH4G8VDC1F3KGdIG96rnnCdAApTg?=
 =?iso-8859-1?Q?60ImPIskJc64PIeEIAWmRtiaztlea1SZAOE/MG1wJe6sfnkKbB5CtmxkhG?=
 =?iso-8859-1?Q?agad90jjYjJmLL4UHJW08rEtBLsVwaN8bbzizVbFNoAEaV/DGNHpQvcz+o?=
 =?iso-8859-1?Q?QP/CziVyth+YInXNzIK2npG1vei291KumCCurm9Ew+uh09Tg12JJW6HEQj?=
 =?iso-8859-1?Q?9xyw+9iauHZ7U8Pax+E2/tX9HTD7jyHWDHXV+4pt5nELrpvOAqzgqdd7kl?=
 =?iso-8859-1?Q?HQ2xtIn9pm8NUAQFPZfoR4KGVaYBIGFacCGC0VW98wUZX0dWDVhB5lm1m5?=
 =?iso-8859-1?Q?WfmHnC+T+mDi4LnpSHxOb9TFgAMIpKxjlBPyIxUu3nKuW+N8r8jM/BediU?=
 =?iso-8859-1?Q?YEkDobOGidfRpYExf+hO2hZKhXj1p8wc5YV0CioeRgFqjsILuoktZFaIoq?=
 =?iso-8859-1?Q?MfoBbEF0lykqk+othYtYLGegMqwzFVFmnU6Fx0VlhSUK8Hjl2/j9+r0Xrr?=
 =?iso-8859-1?Q?4qMNHZbwTO9po18OFOZ4phNsWkYfQRozn3KQhaSwH7bMUgcYzGhyzviN6r?=
 =?iso-8859-1?Q?x5WCVt+MufROSAu+bWDdyqVfYKxScYuMSohRWOwxxLQGvbYrMERJm5wxYB?=
 =?iso-8859-1?Q?ICvHYwfUE5o+Rtj2z58/nJMg2y/iHSP4YkUY6BPOlkpoYJqH0qMYSSvDgt?=
 =?iso-8859-1?Q?zL4ePJFesI2PIAPoeZQwBlUfa0y2ymZwgUMbNMDFFI+RW0jSx4eses/ZUH?=
 =?iso-8859-1?Q?P0aNP1emlLnuZ6D0UXud4p6WV4zjtw1o80QNuW6VVJIWyU3HLL2baO7eMR?=
 =?iso-8859-1?Q?M4oVUmVRNpIEu20E1gj77Q30lXfQajT/CLKnbtorxaWNJVPJklWkX10hbE?=
 =?iso-8859-1?Q?jVR1LsU+4LQC9Exhi192sgHZ1SrSNeqwjL86dJ3hzZh1eziuq79S8sFJNx?=
 =?iso-8859-1?Q?80XMguq+R77JGkOWl/P0SnFW5E29Sv0FHF4A3VhTGbzYg5den873kyMgrQ?=
 =?iso-8859-1?Q?iiZ47fWg6stozInobBjzJUA7t+Mh8md6sH+bWTy1R5xVivmQrQ0ZjVcyuo?=
 =?iso-8859-1?Q?PYThfn5fzj+fK2sNWzQ7PAAlWxgjaMr+8ST8TYOK2q7G2CZqVxhm0R7KBR?=
 =?iso-8859-1?Q?SmT211+qBMkjezExxCf7K6FBLUh649Nz9/7g4m4da9gonWkifO5iK+C1WV?=
 =?iso-8859-1?Q?t/8MwrisOWc0bIx9kENFm9lEvDCmgI32T83baRDMGGttSwmPmhUSJl7fQk?=
 =?iso-8859-1?Q?VV16+A+J+LI64ZzuAjmNv7CxcNHZrOPhtOZh/XmuiqcM3XlgFdvxjutmEN?=
 =?iso-8859-1?Q?PoC9FaRN433gxDQT5loNXTqoWp83TxL6Sz2ZKDWVIa0entVoaLCyIHqlAo?=
 =?iso-8859-1?Q?OXQJBcQu+OhShs3h73VM3RA8dmWU3hKE7mNrT23Gz2N4pbSdSvUQthHvU3?=
 =?iso-8859-1?Q?Cq7dYei3U9Sg6gOdvcQFT6m7vGcysobyfC7p8GFhveJRTL/GtNgEEbxNdl?=
 =?iso-8859-1?Q?Rsket85ZJAvdk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8689.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1df01c-c9f2-45aa-74e3-08ddd8bddfd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2025 10:00:17.1444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWGfsx9sNOwNT4etFeuAmFSSh6r7B2LgMwcJLf8o0KRkw8LVn/7XLi4vQq69oOMJGPm6xZ9YTeRvBYqxuA004A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF6E64BC2C
X-Rspamd-Queue-Id: 3F71F3F67A
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DWL_DNSWL_LOW(-1.00)[Nvidia.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[40.107.100.49:from];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.100.49:from];
	DKIM_TRACE(0.00)[Nvidia.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: KER5R5HAECTBLQ5E5B44YKIEE4URBPJV
X-Message-ID-Hash: KER5R5HAECTBLQ5E5B44YKIEE4URBPJV
X-MailFrom: sungbaey@nvidia.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/T4UPIM2BEWQ4UE6IZIMNMLHQ4YLD7KLM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sungbae Yoo via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sungbae Yoo <sungbaey@nvidia.com>

Fixes optee_ffa_api_is_compatbile() to optee_ffa_api_is_compatible()=0A=
because compatbile is a typo of compatible.=0A=
=0A=
Fixes: 4615e5a34b95 ("optee: add FF-A support")=0A=
=0A=
Signed-off-by: Sungbae Yoo <sungbaey@nvidia.com>=0A=
=0A=
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c=0A=
index f9ef7d94cebd..a963eed70c1d 100644=0A=
--- a/drivers/tee/optee/ffa_abi.c=0A=
+++ b/drivers/tee/optee/ffa_abi.c=0A=
@@ -657,7 +657,7 @@ static int optee_ffa_do_call_with_arg(struct tee_contex=
t *ctx,=0A=
  * with a matching configuration.=0A=
  */=0A=
=0A=
-static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,=0A=
+static bool optee_ffa_api_is_compatible(struct ffa_device *ffa_dev,=0A=
                    const struct ffa_ops *ops)=0A=
 {=0A=
    const struct ffa_msg_ops *msg_ops =3D ops->msg_ops;=0A=
@@ -908,7 +908,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)=
=0A=
    ffa_ops =3D ffa_dev->ops;=0A=
    notif_ops =3D ffa_ops->notifier_ops;=0A=
=0A=
-   if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))=0A=
+   if (!optee_ffa_api_is_compatible(ffa_dev, ffa_ops))=0A=
        return -EINVAL;=0A=
=0A=
    if (!optee_ffa_exchange_caps(ffa_dev, ffa_ops, &sec_caps,=0A=
--=0A=
2.34.1=
