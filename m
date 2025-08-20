Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FAFCA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 13:09:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C620C4624D
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755695341;
	bh=kaWNvbM1BrjvAOswn21CNKoxRYpX82hwBgq5nmkOWrM=;
	h=To:Subject:Date:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=dA4S0yY9hYbMIPLgqSlJWkrQ4RTN0UXwrQ19ErMWi+dZjaFVDMQbIpwfYchlVugWA
	 W92OubIEOikk8JlDFWi7wEwDlmZCWluDupmR7Ek0aCKsJvACErw5pA3LdLgU/AFGDb
	 2KVFTQ5l8fgSGE808M8n3xzvvtJF501d9bZPCTrWhHZjMus5NT0Jl5El9PhS48OtVa
	 5avdlGtwHFCbFq2w45BmI+d1twFaSHgDzubne42n0TJoc4tRmHsAFu4vcJuuUZC0A+
	 FzwyG+IItNwMBM9ZvdnmBO2FzJksvS3LN1Tmnmzh/niByNxBIsnUi+oqRINd67+yr4
	 fNsUiWQtrSDFw==
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 33D7F42DE0
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 13:08:45 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.a=rsa-sha256 header.s=selector2 header.b=ggvTnxvJ;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=To9tAHrkzqiCPHlYKbfL114FwhW4UDOwd0XfqWBTnFsgHgfk0m6YCTe+kokG+HpU4/0xgm7XwP3aa4PsadpzXmO9N/puvX11Gu3kXqGb8qg4JO25qum2MXMQhDGll9QOB5fLqH5aqfdsxsOdtgRFmnB49GN9fv9FsI4Z904cdtJQ1w1AXgs25W2A9DINLaAeZAXTDd1lURigisnHVObbmyRfM8sClazDJfCiZixSDz2Y2CExli0MkftqSEUPoAOu62ruEyPYep2NgPSWIQhFq+Mc8umQKbSk8Kf/M6hN1Fuyr7/FGQBPdDFoArF7uMoyL6C2IQCTRh4r+8Pb5CSHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=084/UWrxvIyKT2Skwqteu9a389GrkdENxJx6oRIOJ0Q=;
 b=rS8Hz05zwyhYPUxUPikJ2Eg6+YVD3wl7gyQC2Su2EE/FUXFmxvUU3nfRb1kV1OoOwXtsaLmKyP9RkSQlw1n+LECjD6Zg9Wp6Z80aACmN+OI73uXGwzjAd82cq3nW8XgxUHrzwwypyhvjEStBDTzMsqF81FxWSAKHRc5k8UKu7RaLFzZKe6we8DgXYB8AqYN1oUOjI3xtCGi1LtWgl2/TqTHAqUZiHO/ussTQ5RyHQIimuRaQFlhf/xk1NqDlkFknAIzFiTiWdcw2SY8bqSXR6wx/Ly2xuKXLUqUGVvsp/3Lphy/o+9mELkdqUD6mrQaSAl4KjXyvNce5LFA8m29qOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=084/UWrxvIyKT2Skwqteu9a389GrkdENxJx6oRIOJ0Q=;
 b=ggvTnxvJyrTAO9u3ZXbXMM/Ss0nnHJP9PAg+JiThVEi0H9irAjXuSSNljIZCpO7QIJsjqdmdpyelxo115QXNDnVuFvUV60W9/qQOIS91YEZ5WP/QAKAKQJLQRMZWQBD8kFeUJ2MMP1p6mzO6wrvko6LrvRpj7+U8UdJemev+ayODu8/fs4I6y3LKAeM6rzhKZhfzqbbY1uMUD3S/GX4sKHpy5UAkfNp0uo4HlKxUk9D/aX4IYE5pr4xYL4EwrQIYQ+z6Gs+OJH6ZUV2+49kAmPNO6u+eEFBd4AtubiD2HZ6b3xUbPfnoYKyCVMIC9x5jGG6127wWnKR5ygLlCy05cw==
Received: from AS8PR03MB7189.eurprd03.prod.outlook.com (2603:10a6:20b:2ea::17)
 by PA4PR03MB8200.eurprd03.prod.outlook.com (2603:10a6:102:26d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 13:08:41 +0000
Received: from AS8PR03MB7189.eurprd03.prod.outlook.com
 ([fe80::de4e:172f:6d97:2083]) by AS8PR03MB7189.eurprd03.prod.outlook.com
 ([fe80::de4e:172f:6d97:2083%6]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 13:08:41 +0000
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: rcu_preempt detected stalls on CPUs/tasks
Thread-Topic: rcu_preempt detected stalls on CPUs/tasks
Thread-Index: AQHcEdOMga2pyJbtz0eXumglywzbUw==
Date: Wed, 20 Aug 2025 13:08:41 +0000
Message-ID: 
 <AS8PR03MB7189020F4559D0F821C4502B8A33A@AS8PR03MB7189.eurprd03.prod.outlook.com>
References: 
 <AS8PR03MB7189EFD4DCB6E423F905AFC38A23A@AS8PR03MB7189.eurprd03.prod.outlook.com>
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
In-Reply-To: 
 <CAHUa44HRzwUdzjwAQbPNRM9wEt+zTJbwQW1xbvB6QzaK+TZacg@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=True;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2025-08-20T13:08:41.123Z;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB7189:EE_|PA4PR03MB8200:EE_
x-ms-office365-filtering-correlation-id: 5862e6fe-d281-44ce-ea46-08dddfeaaf64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?VzFdJJhFj8vGscTRINpxud0P4v/yYQpAair0XoGm5Pf5y60rQPq7UrmmWA?=
 =?iso-8859-1?Q?0XgJCHkBCft34EYaamVFFt7U5zgwCfySYNyYaV941scd5bWMqI71eo+DlA?=
 =?iso-8859-1?Q?02aE08i0dxVVnSIpxOiCMeKIu+fhwRws54jwz/FvGWnPqEX1g/QGyJ6SVv?=
 =?iso-8859-1?Q?NlRwhyb9f62lu14O2sIGwwPqNIvVaQ6xhmOxaI8c8CqsVIgEDM8GhMHUIZ?=
 =?iso-8859-1?Q?0CsjB/MvM0llSHWDdGlDSjYyungRs+vJJEe2k5ORXJzgNPgS01yqaNsQXd?=
 =?iso-8859-1?Q?Ns6+F2iKODRl0uI9HI23p2zyRxuEusjssabIonaKrT8s9tgWa4FonX74m5?=
 =?iso-8859-1?Q?tp8/HHv0CUoavOq4aF6nGpm+s3AHZDj1ZTh21yiI6HzPeINW+BFMvHoQba?=
 =?iso-8859-1?Q?W5hSUnOQ5ZAG7rHFdXwJ+yFSvLGDrD559/rgBE3kBo0yIilXdKTdRdNvM5?=
 =?iso-8859-1?Q?YTSIEChB2JahmbQaJdNaDrsR9z8gqqunWMMH8ActUJHf13BfcpE0U4pods?=
 =?iso-8859-1?Q?Thuz0J0/nYY8rAV8kg6MSsil8Xy5YGihytavkddTSiMlak8to5HQF802ZF?=
 =?iso-8859-1?Q?F8XPTkdSkHYd0aSpYciFW5xkcdB6CpM8qpa3mSsYvUdWWAjzkTbkN+TmyQ?=
 =?iso-8859-1?Q?N0IpGtRHxHM+Ar/WaKhhiyQ//tfCwOnHfttEq+JZ4BCzloeJj84nAdvHRy?=
 =?iso-8859-1?Q?Bkr4LP1rcTAzDFPn3Ahvcn7jQcPX0NCgF5lfV3DxNWd8tZIzJ1nZzLPjNL?=
 =?iso-8859-1?Q?bVYOpKZGniRx8Kkv0asxc//pN6qeCUKx8AVQqKVgb0xAFnvavsXrHYwJJW?=
 =?iso-8859-1?Q?+6A6m3XJWtPM/hlKuX0WaDbtJ9JKLVKgeZT/gJQrKHwVDMZyzGPGwIAKXS?=
 =?iso-8859-1?Q?PNkyKMjgchjBRf5oncNv+9wBbPyJtnEfHl2QIIrdAy2esOHtCo+JQAtUdR?=
 =?iso-8859-1?Q?5MJvYGDzHL3iTLhzyr+qRjXxTOm5StlyVnKTBi08ZI7LrG5/KIjW/dUBrO?=
 =?iso-8859-1?Q?pHnXckaFZ5i8SQ05qczCu2uHieJQpQBcwUDpoB9PENiS1IWtBFPTuOK+hF?=
 =?iso-8859-1?Q?2O6rKDyWMh+EkOBA7ApHylmyek2ufHDRna6a6+U0JYvtVHL2rPGfUkv5g4?=
 =?iso-8859-1?Q?6C4FCcd1kpgCX8/zRcdaZ2necfVYsX3f0wAEkX7Xcs320bHZii5K+J1nrr?=
 =?iso-8859-1?Q?C05JXcRlezoemAujZAWILVBMW8NbZSkPK7S+TbHkmN7E9ApnQHZ+iGR5ya?=
 =?iso-8859-1?Q?dl0gGINSnOCdM4OBudssiscrIdUKg3Fy0Kvk7+et1xwsVX1egl2iKmdCzC?=
 =?iso-8859-1?Q?BvAeWNyO1lN8Mg7DXZLY75ZojtytRLU7jZrtHNvuApO6DJBDWs3WfjlIy8?=
 =?iso-8859-1?Q?FSv+S54eTd0T9ecHuO7yVGGx7uJ+dhq+SZ06jyhEflhz6lWUWScIehW+sx?=
 =?iso-8859-1?Q?2IpA4a34QzYK6sJf+eJcUHuHjGd4CgYgD7laZlF0Jn8cJuhjZIgpCc4lrL?=
 =?iso-8859-1?Q?YlFIbO43eI+aKFg/Rri65tjUAK7/yQ7X34iJEr+wRxwQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7189.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?BWLMu2Rq6ffNkCNdhpP0sxFRCNLjqBwl0ppyuvbNzQYtPLFZ1d8ywOQN3h?=
 =?iso-8859-1?Q?K8tlZGe2arD5acZqw6YOcEvzvfq4mYTo1sQI7eZAVIwUZNHveSiIyyv7L4?=
 =?iso-8859-1?Q?qdhjNVSTyvv0x1mxk6yLd+dLxutWSNw+l1FJ8puc7OpKC/zhNI+eeULN5t?=
 =?iso-8859-1?Q?55kgRA3OT5sNKbEnPLevuuWVFINmOCpak3bCr0i5Wb74qQqexFEoN4AhoF?=
 =?iso-8859-1?Q?ib5iwT0lf0JPk0YnQyy1pfhkh/DB/wZ29tx/GQgoo4NyaMIHp1B8LVJXmA?=
 =?iso-8859-1?Q?lUek6udVkHYAuVBCKBN78c+tOwGCaYJNmjpBW53aCdbVvp8Gv6Sd8fa9V9?=
 =?iso-8859-1?Q?eSeVGSmD3LKnOsBWdk7RQROtS0T5W1kr9m+ml4a0u4x5QEOAVw+VqlHFI7?=
 =?iso-8859-1?Q?Vf4ZtI4sagAGPIa9ApNNnZnyQFb3H1iVM6Pgo8WOVF8AGM0RfbtHzT2hDP?=
 =?iso-8859-1?Q?W3wRYs+BXyY4eT/DeSnyjSTGjQ18EhwcTl0XKCMv5M0TULqAjnJebzfqk1?=
 =?iso-8859-1?Q?9fCooOwO9HJRjoJcOgZ4Ge5Y6uaXTWK5Ce/O9r7wDhwvAxIB4n2J0EluoY?=
 =?iso-8859-1?Q?Ra8VPHzh51eUT5ktgvwpDsXqp0EBFXDohhDZ9Uo9WBi7S2H4WqtCXmUeXV?=
 =?iso-8859-1?Q?vyMXJQt2vw5TkQtWDRV2+MFK/zw9ODwxd2K31IbUvsLUYrDGNBAotMKXNT?=
 =?iso-8859-1?Q?meyCyELNrM43A/PqRqiyEcxJRK+TEgV3SrniP9UivKqB72xtp/hZ1xE5C9?=
 =?iso-8859-1?Q?Q2gpVWmlwSRMVmnDVDbl2QTv0uUpr3iqsCEORy4B6GzI6t2Vnyba3woABD?=
 =?iso-8859-1?Q?/L7B9itke9YnhbcPGl7/2VLx1QJzvaIDaGMae5c6EoSufxn72WmC/nCH0O?=
 =?iso-8859-1?Q?eIdvuLk2eN/s9pWUJGffAnhSLHeSgDmRg2MByf9c3grYK2NcCsohy8w3HU?=
 =?iso-8859-1?Q?RAUOf8fRTiXLTuzxrWLY7jZ17pD8IBrKoN4uJXKhybBxkrCHybd+/uBFHA?=
 =?iso-8859-1?Q?J+WALBFGAtHr8e1jG4Fwyo4lazd0pIRUAeLfNuhwvvPHZmzKeJe50JbcmT?=
 =?iso-8859-1?Q?wZih40qeq4XV+AAEORSPoSGBtnfPMvSHZ7vsWibYpRKo0KOgaj1Rs0tgK1?=
 =?iso-8859-1?Q?hLMDZJpBRt7o4PRlW4OB1VksOjqwTUVaUVC7qQhWoCAyWvVAvvwjdRrm3E?=
 =?iso-8859-1?Q?aoD6rGjO/8Is5A/eCL8FinFOsPwq7KJtxp7O4RLvc0XhO4uVDauYBPoumI?=
 =?iso-8859-1?Q?gQfAkrs9Kn+ofsHgvo4GLhfo3saSbgtJ7UoGApflfbPWIokgZyONUAw9hq?=
 =?iso-8859-1?Q?qgwruI3LLuass7hv6Hv897L7y7UIQO/bv0HS7pZRmo4/Si6u5LtZwVAUHU?=
 =?iso-8859-1?Q?To1iXQ5TtnmL13jPiNrRCHLvRkfNKm823Cij0l/sTivlA0azsicIK1Exw4?=
 =?iso-8859-1?Q?ry5XfBuAAGAqOjlqYfDbl9iDU7OUNfSHIRCHwcMao0UgCRfiFKXRZsVr6m?=
 =?iso-8859-1?Q?icsQzkXO4+aHAA7PInwL1hBkybAiyJPhIZgcGTGMIqgcPw03kr9ys6+J9y?=
 =?iso-8859-1?Q?IHwnP/7r2nMD5EpfCIbQJVaaSrKybBazFrBIquRLjg6F2GVTJgHhz+DzFV?=
 =?iso-8859-1?Q?PceYYdCT+Di+fyigys72z1sbzAkohUN2IS?=
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5862e6fe-d281-44ce-ea46-08dddfeaaf64
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 13:08:41.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rYcJPBk0JgmPpzZEo4gZyj53JjKpxcZKH9XvpMDrbfLxBuf1BEAzTGeXLVdsYGixLhuyVr46XwXJLOmOtymNKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8200
X-Rspamd-Queue-Id: 33D7F42DE0
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.64 / 15.00];
	BAYES_HAM(-1.64)[92.75%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mt.com,reject];
	R_DKIM_ALLOW(-0.20)[mt.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[40.107.162.57:from];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:8075, ipnet:40.104.0.0/14, country:US];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[mt.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2603:10a6:20b:2ea::17:received,40.107.162.57:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[mt.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 2AGMUZODE6LZNCVUU2MDEWGEVSD7YRJP
X-Message-ID-Hash: 2AGMUZODE6LZNCVUU2MDEWGEVSD7YRJP
X-MailFrom: Thomas.Stauffer@mt.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Content-Filtered-By: Mailman/MimeDel 3.3.5
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HW4MMJPH2CFGPRIVORKGOV4RJPFJI6UF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Stauffer Thomas MTANA via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>

Hi Jens,

I analyzed this a little bit further since last time I wrote. Here what my =
"believe" at the moment is


  *
Linux uses the non secure timer in arch_timer (physical/virtual) -> this is=
 correct
  *
OP-TEE uses the secure timer (physical/virtual) -> this is correct
  *
ARM Trusted Firmware by default enables NS_TIMER_SWITCH=3D1 with opteed, th=
is IMHO unnecessarily stores/restores time registers, setting NS_TIMER_SWIT=
CH=3D0 seems to solve the issue, my personal tests and also xtest did not s=
how me any issue so far

All this with some uncertainty, I read through quite some code, but I could=
 have missed a case, where something may go wrong I did not see.

Latencies I tested with cycletest. With NS_TIMER_SWITCH=3D1 this skyrockets=
 (and explains all the other negative consequences) with NS_TIMER_SWITCH=3D=
0, everything is back to normal, even doing "heavy" operation like creating=
 4096 bit RSA keys with OP-TEE.

Thomas

