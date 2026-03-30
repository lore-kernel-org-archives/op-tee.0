Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D75FF4939
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 04:07:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F0AB8444A2
	for <op-tee@archiver.kernel.org>; Mon, 30 Mar 2026 04:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1774843631;
	bh=TTewfMitzer4EXlVK61a1tU9BBx7K2UdYL/dezIS3+I=;
	h=To:Subject:Date:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mCPrPmf4yNxaXpyKqPoOxbqJjS0f1SK9t6wAB/mHQyxge30svXzwwa1Y+W8G1rg61
	 AmiHHxFo4vpNtdLhO+OXu+mFwdMG/WktAvj+zIoNOU983ngf6fjpLNE9zHKuZhA23R
	 EcCdGC4yCmG5CHI6zj2E2ru3ZKMSprKEV2ngMPfn6YrgXOJQoxCUD2JfuIsGzq6oxo
	 I1LJ/72Ort9CTftrmxMerqeqvB65t+UygMn02REPKgo6PYBwiAqa84dDD7repN3PpB
	 TP7G5FsEBT3EIfGSMvbmUKs3Pv65mxeunZJfjdEIihKNZ6V+OgeIZ1YPJ0kuOKWCSG
	 OBISEhlddWgaw==
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3BE844306B
	for <op-tee@lists.trustedfirmware.org>; Mon, 30 Mar 2026 04:07:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.a=rsa-sha256 header.s=dk header.b=U2984r7N;
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-mediateko365-onmicrosoft-com header.b=ESxIGn90;
	dkim-atps=neutral
X-UUID: e4108a9c2bed11f19a16598d5ca7f8ec-20260330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=TTewfMitzer4EXlVK61a1tU9BBx7K2UdYL/dezIS3+I=;
	b=U2984r7N6mherJHatLrTAJIb2fyuENnLxtSbyS6zgW4l3nAJ+NEjEgmQHBAwMvqD9SGwhju2LIHhmY8i9g6kYGwjJMUKLu6aNtRqlEgpzmgzMi3KPOHLfv+WtR4Xjt1retSovCzeiV2eQknS0GkV/rZ/r/RBEb17FBvJtcvnkM0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cb4abe9b-2139-48a7-85da-8ea30bc67bb1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:636e5a94-f8ef-4ca8-bea0-143568f9ca1d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e4108a9c2bed11f19a16598d5ca7f8ec-20260330
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shf.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1112474673; Mon, 30 Mar 2026 12:06:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 30 Mar 2026 12:06:54 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 30 Mar 2026 12:06:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9i5MnkIGuMY5+t0kJ86KfrxEQgFAZVyOMFL98JJ110ZHAlhFpfuvQ2Vorca1/2dJ56V+gzNESAUVYbLbNPdGGHEsgL4kJ543Q2NTGR0tkPkdJN5sveqVFK6dCuhBY6Igwny53UNzAR7yWE/uK6vkfHcwUJmD/6RZayDtxZB0h15SeHQRFYD3aUGA0Y8nuwd1PhhNvd8eXg4P60WWM90TR6G4QU78/q5/6v7nIi9KdbOZ3SHo4yFkVNiDGO0UX4SnwgSmIcP+8hFoVruRgnMLnJmWFtOslo/pb70Thj18M7c0HhNL6ISZzEYthHkg3R0rWIEHXJ0eZQbcsqFDEmT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTewfMitzer4EXlVK61a1tU9BBx7K2UdYL/dezIS3+I=;
 b=qvX2Y1OIjVhFGF58x3AdV6M7wHqHqrCWve1BoYwEvvJK2hgs/LgFiYnrj0lRVOZD68ArSMBGMaEO3Ios7UAxgOhuW0pKOZGASiubrg8z4nQoAC0U7IwgtXkWEAEZ7OIu8+QHwOn9RBRMY7POMDmed2YV/A8ujL4ol/a0tLBIdSalFtgeSbf9o7ijVOl5rz0r8YwEfVqo7aIvpp2S/Hykqr+dg2srWKW83BD7fUFWGm6wp6Ki8TGD5WdmOev+gpqIweaxpuIHUp2btzrUkGniU37EO9WzlaZZ4yTyhLiRnjIyprCoOnuCEzek9tUb7mY8oJZVgyoK2Nhj/6CBx2kcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTewfMitzer4EXlVK61a1tU9BBx7K2UdYL/dezIS3+I=;
 b=ESxIGn90YuK1bfL/maxXX4kU7zIghrVqgTNLS1wSMUTAsghPif5O3s/LjcodS9rgrliz+znibcdItqsAPSzDJPERBbMBI1KIHcYZuDjOAqL/1bk0gOjTyfTxd/yvBu3/0jpsWeYfBVBr7U8YYepHi2zoTWdz6wU0taNZ8hHEo/8=
Received: from TYPPR03MB9423.apcprd03.prod.outlook.com (2603:1096:405:314::7)
 by TYZPR03MB7156.apcprd03.prod.outlook.com (2603:1096:400:33b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 04:06:51 +0000
Received: from TYPPR03MB9423.apcprd03.prod.outlook.com
 ([fe80::90f6:c8c9:ee6a:93fb]) by TYPPR03MB9423.apcprd03.prod.outlook.com
 ([fe80::90f6:c8c9:ee6a:93fb%5]) with mapi id 15.20.9745.024; Mon, 30 Mar 2026
 04:06:51 +0000
To: "sumit.garg@kernel.org" <sumit.garg@kernel.org>
Subject: Re: Possible race during OP-TEE kernel module device probing
Thread-Topic: Possible race during OP-TEE kernel module device probing
Thread-Index: AQHcvchEft/xaq387kayy5B6QDQksbXCJdiAgART3YA=
Date: Mon, 30 Mar 2026 04:06:51 +0000
Message-ID: <0c8f7f5d4736287c36df973c593b7706fd36220b.camel@mediatek.com>
References: <d9bb3b058dcd0425b18c77120dae225506b079e2.camel@mediatek.com>
	 <acZVg6GQQT17r0OG@sumit-xelite>
In-Reply-To: <acZVg6GQQT17r0OG@sumit-xelite>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR03MB9423:EE_|TYZPR03MB7156:EE_
x-ms-office365-filtering-correlation-id: 44325d88-e4cf-4b0a-c736-08de8e11c5bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: Nsj9UAh7Q/tg5Dnk2A9GvR3DKIYiJpGoYoYcs5OS8P+/HEtOSZumUzY9sZSt8/5msnxFlJfMRFWiVy8cAC6y1jXpWvzHOdXPPhgfmogVDRI5fks+zC1nU5PoI7oTZpyRWVCKrB/J3p6PkfkRa/JjWs/C85QC5O3PBit9rni6STHxzyp53pdf3pfydW9FAdrBGG1F48bswIHSyr9XmVcHtM5TfJheHaNganZdWYxtMSXsHZEZ2IqlYGTa8aqDpVvYcm1GO7O0eqzrOgGw2Iq3iqcU6IJe9cXSmaDGYdL/M5ma48gpNDuAVb9eewFCtGwzUL7ktivYkqt+ZxVJ4ClqkFXYBXOSw5wKy32NMLvN0Syl1/mE4WwH/n9SXqBFX/ZtjhvEc4+qnoNYDQ3i3d1ssO7Hl28xLxZwSEaT5zNfmXslzIOwrxABUTP2kdrMJ3LldU2i9gE9Ssrl4o2pUQCC5h3qCQZPqkvyWPJ98SuuSV+rAfZAyYaCLeVe1HhVOq8rH7ip3k2cJUtbv5cQQeJTc2GAQeW0kaMJXeGtjxblPP+ofkgsK7cd4HVf+ucUqhHNLcZzb7IfizpWOZeFJ3u1tF/8TmH+nxW+wsJEcl3+ejZuBQb6BbqdZNd+0mFZmT4mYKT7aQ5vy5kABHlBElkBLRtlFo49lD43zz6QwpbJSa1aXFUpgpBlznwcB6Tz0XNdVVPY9iHeXcAPejyGZ4nJ3uYaxptY82qpVcyv13syLawDyEH8n5q6wJea1Pl8ml4OjuxodlyPqtUMgyed0+k27M7XIY5Ng2p7zZZZo+qSjl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYPPR03MB9423.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGc0SjJMTHNCUGg3Y1VaQkt0T1lCWkFXZ1o4MXNvWWFJUThYcTBqMm9kNExo?=
 =?utf-8?B?SDRhcDZQMm1sWThJRFhtSkJPR3h1bWg5bEx3Y05YZHM1cGpsY3d5eHVUanRs?=
 =?utf-8?B?T1l4Nkc4NmRyV3BmTmpIMUhQR0dBeG5FOWVpYkl1QWFUcXlFR1REY1hVQlhv?=
 =?utf-8?B?cUxxdWhCZXY3MlR6S1NqWlVkV3k0eDJOKzhYUFh2ajdmbXI4akRicjlUVzIr?=
 =?utf-8?B?VFJzT3BGazJYZHFXT2M2Rk15d2ppSGw5V3NSR0p5bCtZQjduTmZHeGl6Z0Zm?=
 =?utf-8?B?aEZCVDhvcVRWdUROak8zaXpiaTNNTzRqaE5VOWhQWDlTVzJ2bGNJamNYNEl4?=
 =?utf-8?B?bG4wSFRsVE1lTXVGRTNDZ3ZBZG1OUFVnTEsyV05uaEovWVdXKzNXMVF3MnJD?=
 =?utf-8?B?a0JrTDdKOUtraCtvUHdDUHJLZlA5SUUzVVhwVmg5N09EcmhCY0pPaTc2Mlha?=
 =?utf-8?B?aEhGZWhlY2hzS3Uxcm92VFIrSFdpWkdXVUN0cHZCRHg0a2s4N0pwS0FoOCs4?=
 =?utf-8?B?b1ZIUWtiOVc2anVMV0FmN2JjcjdhcDRoZGwrd3RGL0l3dU4yL1lScUh3QUJK?=
 =?utf-8?B?OUU4WDlGN2w3dDRCYTViamk4UENmZmxGLzVNNUxTcGQ4Q2ovc2dhZm9yaVJU?=
 =?utf-8?B?MUZUSTJldTlFVkdTZmZtTW9FNUR4WnZ2b3owOTR5VUszY2xVNXhVWTZ1N3k0?=
 =?utf-8?B?cGR3eEtoN0srSGd4UFUzRG1kTDlaOS9HcmxZL0lNTW9QTm1CMFdQZ0hWR3pS?=
 =?utf-8?B?Mm9HS3lUZStQVW9uYlM4Qm16UENGUDFpalhTTFBCVllFNWwwQ3U0NWZXdkJm?=
 =?utf-8?B?RGczVzdORTF5RTNGR0V3V1gxbXBsVDV4RnUyeFVhY0htQzFrUFlLQ2JpMjc4?=
 =?utf-8?B?dFBFL0xhUmFyNk1tbEI1QXdvU0IyRW1vVXE2OGlpRWVoc0RiYktTUG5xc2lL?=
 =?utf-8?B?cWx1Uk0wSGl3b1NiQ2RzVGh5OEh4NFJIY0Y4MlFyUXJTZnZLZkNGSVZ1SGJ0?=
 =?utf-8?B?WjdCY2NpcTNEbXRSMmdDUEhiMmJwL0Y3Y29BZzRzQmJJbnB6aFIxaUlsYnlo?=
 =?utf-8?B?bjdrT2tNUDNiUFh5Y05TWXhmQWpnay93MzArMkZEYXRHbUNKaStLT2JaQlBz?=
 =?utf-8?B?Z3J3UHRaR0VpTU5kWTdWNDRPS203R1RHSlZ2RHVMT3NDWmM5Q3ZqTUhWTFNN?=
 =?utf-8?B?L1N0enp4bVZJdE9UeTc5S0Q1WllZWHFPMmVNTEIrNFlQR0dadFk2VVpNNXo1?=
 =?utf-8?B?Sk5SQ0lBdTdyemlLbFd2RHpGMm02M3ZoOUxmVzhGT09YZjF4ckQ1cDEwbXdO?=
 =?utf-8?B?ekJ6SldjMm5mY3dEUjI2Q2J0NkZRY1FPY3p1SlhNc3dEUS94bnZTQndqZVdR?=
 =?utf-8?B?dnovTnNiL0FmMkh6RDFSa084cGt0amJXYkhTNmE1UnNNWVh1L3FnWnZqR0NR?=
 =?utf-8?B?dTBqY1BIQXMxb2xDQy9QTzFOWHp1MHdVam9aajFRaVBWZUZvUkpac3NZUm9r?=
 =?utf-8?B?ejhKV3Q5Z3BaWjU3ZGJLVUx2STdkSXdnRFZleGVHUXg1dWRUek53OTg2MUZP?=
 =?utf-8?B?Wi9EUWdKM1lKdmFDOThNVlFLODNicEhoR1ZxRGN6NEo3UnljZkpJMnpEY0dQ?=
 =?utf-8?B?bHNLeFhvN1o0eklOK29QQ1FJUmZyMGV2WGQvd0VDSnBjTkUyellBMVNUaXJQ?=
 =?utf-8?B?R1BPRDhLQXFsM2lJNmJHek1sWFJBNys4V1dSK2l2bzNWSmxkK1dsM1dXbDdt?=
 =?utf-8?B?UHBjS0FJcmNqcjhrK0x5OHhhd0QwaU1RZ2MwUGlXdTN2cmlqYmQxQkNhVFh2?=
 =?utf-8?B?bDdmMXRybnRqR21BTVEveDZLVG1aSnUxSXp6TWgvK0cvcldwYnVOSHM2OUp2?=
 =?utf-8?B?UUNnbTdXTXZoRk9DT0xCRDB3QW1DNVk1RWF1a0J0NHZZdExwR0E2Q0s4Q1p6?=
 =?utf-8?B?cGkzT0VndVRBdDVLUnZBcFh5U0pVVzVHdXdJNVhGdzEvV0xCNnkyckowTG0y?=
 =?utf-8?B?Y0ViNjR2TWlhd2FzK0NpMDI3eDFEYUpDVzdRK1l1ajdVa29zb0F2ZVhtT1Vo?=
 =?utf-8?B?dEIrNmFHZTZ0d01uR0l5b0VnTVF6WTNZeFBZVXovVUhZMVlVaGZFY0txQ1BH?=
 =?utf-8?B?THBabmpIdnZVVlhnb0xTN3lyVUtXWmhSOUxobnE1eUJIUEFuajM3UzFCUytz?=
 =?utf-8?B?Qm9iOUhXNU9PL0gzOEZHcHkwYllVRWxzbnpWZ0ZWMU5Sa1diWm9XZUozYlhC?=
 =?utf-8?B?UG9tcDRSaGRvL3Y3aGNqSTh3YXBMcHBuV1JURk51bS9ZWXF4WGtjejV1WHFD?=
 =?utf-8?B?eTJUS0xCTkdpZDdKdE1oMjNoeDFUSE9iQ2o5Rm9rUHkvUjdlY2JlSkx6Vk52?=
 =?utf-8?Q?bD5/4s2MR9YM+5h8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05087A5DE24F29469ED7E4E1E4FD25B6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EkaOLmDDtoNJ5bkkh2I7PfDAUZlGgvQZvAFdZxSkEKsMvsuxIZJqt59bWTdQ2DGOT1CmwrwsVcZ07cOw2YvDg13xBXGZWe3rXL3iVnJi7QlJ+2uE8PoeQfD3iC0eQ4mYE37Blc5IB6PlkKtoDbfKP3tMPJ6LUPEe76VNTx31oxsYLu+0w49KA3rNbIfPUlTicCMSHI3uWUVIs3cDY0Na18GH9AoWkGTVUEt6QdeYuSWU0SKwyR+IWu2I6nGL17Mq3AJKkr9Qa9R3Fl9O63GN1kimjBgRLYJK1ZcnJZ0HSn9tf2X04T/SK2A8gKq0wdEjzLWziJE6vac6hIFsMSv9/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR03MB9423.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44325d88-e4cf-4b0a-c736-08de8e11c5bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 04:06:51.5695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B79obUqyJuon09ch0UonDVlshst+7uoIkDG6wQ8CdwisFNIOkMwbaEpIGGsPm3n3FKjBbrAYlHpiUBWQQpxDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7156
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.90 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[microsoft.com:s=arcselector10001:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk,mediateko365.onmicrosoft.com:s=selector2-mediateko365-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:210.61.82.184/32];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[210.61.82.184:from,2603:1096:405:314::7:received];
	ASN(0.00)[asn:3462, ipnet:210.61.0.0/16, country:TW];
	DWL_DNSWL_BLOCKED(0.00)[mediatek.com:dkim];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[mediatek.com:+,mediateko365.onmicrosoft.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3BE844306B
X-Spamd-Bar: ----
Message-ID-Hash: TNSX6LZY5QYDZNSUC2KXYIG2S32PF5OM
X-Message-ID-Hash: TNSX6LZY5QYDZNSUC2KXYIG2S32PF5OM
X-MailFrom: shf.chen@mediatek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TNSX6LZY5QYDZNSUC2KXYIG2S32PF5OM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: =?utf-8?b?U2hmIENoZW4gKOmZs+WwkeeUqykgdmlhIE9QLVRFRQ==?= <op-tee@lists.trustedfirmware.org>
Reply-To: =?utf-8?B?U2hmIENoZW4gKOmZs+WwkeeUqyk=?= <Shf.Chen@mediatek.com>

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDE1OjMxICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPiBP
biBGcmksIE1hciAyNywgMjAyNiBhdCAwOTowMToxNUFNICswMDAwLCBTaGYgQ2hlbiAo6Zmz5bCR
55SrKSB2aWEgT1AtVEVFIHdyb3RlOg0KPiA+IEhpLA0KPiA+IA0KPiA+IFdlIGZvdW5kIGEgcG9z
c2libGUgcmFjZSBjb25kaXRpb24gaXNzdWUgZHVyaW5nIE9QLVRFRSBrZXJuZWwgZHJpdmVyIHBy
b2JpbmcgdGhlIGRldmljZS4NCj4gPiBBIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBleGNlcHRp
b24gY2FuIGhhcHBlbiB3aGVuIGFub3RoZXIga2VybmVsIGRyaXZlciBvcGVuIE9QLVRFRSBjb250
ZXh0DQo+ID4gd2l0aCB0ZWVfY2xpZW50X29wZW5fY29udGV4dCgpIHRoZW4gZG8gYSBTTUMgY2Fs
bCB0byBPUC1URUUuDQo+ID4gQmVsb3cgaXMgdGhlIGV4Y2VwdGlvbjoNCj4gDQo+IEhvdyBpcyB5
b3VyIGtlcm5lbCBkcml2ZXIgYmVpbmcgcHJvYmVkPyBIYXZlIHlvdSByZWdpc3RlcmVkIGl0IGFz
IGENCj4gcHJvcGVyIFRFRSBidXMgZHJpdmVyPyBBbnkgY3VzdG9tIHdheXMgdG8gaW52b2tlIFRF
RSBrZXJuZWwgY2xpZW50IEFQSXMNCj4gYXJlIHN1cmVseSBzdXNjZXB0aWJsZSB0byByYWNlcyBs
aWtlIHRoZSBvbmUgeW91IG1lbnRpb25lZCBiZWxvdy4NCj4gDQo+IC1TdW1pdA0KDQpIaSwNCg0K
T3VyIGtlcm5lbCBkcml2ZXIgZG9lcyBub3QgcmVnaXN0ZXJlZCBhcyBhIFRFRSBidXMgZHJpdmVy
IGZvciBzb21lIHJlYXNvbnMsDQphbmQgd2UgbmVlZCB0byB1c2Ugb3RoZXIgQVBJIHRvIGVuc3Vy
ZSB0aGUgT1AtVEVFIGRyaXZlciBpcyBwcm9iZWQgdG8NCndvcmthcm91bmQgdGhpcyBpc3N1ZS4g
QnV0LMKgd2UgdGhpbmsgdGhpcyBpcyBlcnJvci1wcm9uZSBmb3IgbW9kdWxlIGRldmVsb3Blcg0K
dGhhdCBuZWVkIHRvIGNhbGwgdG8gT1AtVEVFLg0KDQpBbHRob3VnaCB0aGlzIGlzIG5vdCB0aGUg
Y2FzZSwgSSB0aGluayB0aGF0IGFmdGVyIGNhbGxpbmcgdGVlX2RldmljZV9yZWdpc3RlcigpLA0K
dGhlIG9wdGVlIGRldmljZSBpcyBzaG93biB1bmRlciBgL2Rldi9gIGZpbGVzeXN0ZW0uIFRoZXJl
IGlzIGEgdmVyeSBzbWFsbCBjaGFuY2UNCmZvciB1c2Vyc3BhY2UgcHJvZ3JhbSB0byB0cmlnZ2Vy
IHRoaXMgcmFjZSBjb25kaXRpb24sIGFuZCB0aGV5IGRvbid0IGhhdmUgY2x1ZSBvbg0Kd2hldGhl
ciB0aGUgZGV2aWNlIGlzIHByb3Blcmx5IGJlaW5nIHByb2JlZCB5ZXQuDQoNCkJlc3QgcmVnYXJk
cywNClNoYW8tRnUgQ2hlbg0KDQo+IA0KPiA+IA0KPiA+IFVuYWJsZSB0byBoYW5kbGUga2VybmVs
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAw
MDAwMA0KPiA+IE1lbSBhYm9ydCBpbmZvOg0KPiA+IMKgIEVTUiA9IDB4MDAwMDAwMDA5NjAwMDAw
NQ0KPiA+IMKgIEVDID0gMHgyNTogREFCVCAoY3VycmVudCBFTCksIElMID0gMzIgYml0cw0KPiA+
IMKgIFNFVCA9IDAsIEZuViA9IDANCj4gPiDCoCBFQSA9IDAsIFMxUFRXID0gMA0KPiA+IMKgIEZT
QyA9IDB4MDU6IGxldmVsIDEgdHJhbnNsYXRpb24gZmF1bHQNCj4gPiBEYXRhIGFib3J0IGluZm86
DQo+ID4gwqAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNSwgSVNTMiA9IDB4MDAwMDAwMDANCj4g
PiDCoCBDTSA9IDAsIFduUiA9IDAsIFRuRCA9IDAsIFRhZ0FjY2VzcyA9IDANCj4gPiDCoCBHQ1Mg
PSAwLCBPdmVybGF5ID0gMCwgRGlydHlCaXQgPSAwLCBYcyA9IDANCj4gPiB1c2VyIHBndGFibGU6
IDRrIHBhZ2VzLCAzOS1iaXQgVkFzLCBwZ2RwPTAwMDAwMDAxMDI2YmIwMDANCj4gPiBbMDAwMDAw
MDAwMDAwMDAwMF0gcGdkPTAwMDAwMDAwMDAwMDAwMDAsIHA0ZD0wMDAwMDAwMDAwMDAwMDAwLCBw
dWQ9MDAwMDAwMDAwMDAwMDAwMA0KPiA+IEludGVybmFsIGVycm9yOiBPb3BzOiAwMDAwMDAwMDk2
MDAwMDA1IFsjMV0gUFJFRU1QVCBTTVANCj4gPiBXb3JrcXVldWU6IGV2ZW50c191bmJvdW5kIGRl
ZmVycmVkX3Byb2JlX3dvcmtfZnVuYw0KPiA+IHBzdGF0ZTogMDM0MDAwMDUgKG56Y3YgZGFpZiAr
UEFOIC1VQU8gK1RDTyArRElUIC1TU0JTIEJUWVBFPS0tKQ0KPiA+IHBjIDogb3B0ZWVfY3Ffd2Fp
dF9pbml0KzB4NzgvMHgxMjQgW29wdGVlXQ0KPiA+IGxyIDogb3B0ZWVfY3Ffd2FpdF9pbml0KzB4
NjAvMHgxMjQgW29wdGVlXQ0KPiA+IHNwIDogZmZmZmZmYzA4MWZjYjdmMA0KPiA+IHgyOTogZmZm
ZmZmYzA4MWZjYjdmMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDAgeDI3OiAwMDAwMDAwMDAwMDAxMDAw
DQo+ID4geDI2OiBmZmZmZmY4MDgwZTQyYzYwIHgyNTogZmZmZmZmODA4NGQ0NjA0MCB4MjQ6IDAw
MDAwMDAwMDAwMDAwMDANCj4gPiB4MjM6IDAwMDAwMDAwMDAwMDAwMDAgeDIyOiBmZmZmZmZjMDgx
ZmNiOGMwIHgyMTogZmZmZmZmYzA4MWZjYjhhOA0KPiA+IHgyMDogMDAwMDAwMDAwMDAwMDAwMCB4
MTk6IGZmZmZmZjgwODI3NDE1NzAgeDE4OiBmZmZmZmZlNTcyZjhjYTAwDQo+ID4geDE3OiAwMDAw
MDAwMGZhMjg2NTBmIHgxNjogMDAwMDAwMDBmYTI4NjUwZiB4MTU6IGZmZmZmZjgwODRkNDcwMDAN
Cj4gPiB4MTQ6IDAwMDAwMDAwMDAwMDAwMDAgeDEzOiAwMDAwMDAwMDAwMDAwMDAwIHgxMjogMDAw
MDAwMDA4NGQ0NzAwMA0KPiA+IHgxMTogMDAwMDAwMDAwMDAwMDAwMCB4MTA6IDAwMDAwMDAwMzIw
MDAwMTIgeDkgOiAwNGQ0NjAwMDAwMDAwMDAxDQo+ID4geDggOiBmZmZmZmZjMDgxZmNiOGM4IHg3
IDogMDAwMDAwMDAwMDAwMDAwMCB4NiA6IDAwMDAwMDAwMDAwMDAwM2YNCj4gPiB4NSA6IGZmZmZm
ZjgzYzg2NjQ5ZTAgeDQgOiAwMDAwMDAwMDAwMDAwMDA4IHgzIDogMDAwMDAwMDAwMDAwMDAwMA0K
PiA+IHgyIDogZmZmZmZmODA4Mjc0MTVhMCB4MSA6IDAwMDAwMDAwMDAwMDAwMDAgeDAgOiBmZmZm
ZmZjMDgxZmNiOGMwDQo+ID4gQ2FsbCB0cmFjZToNCj4gPiDCoG9wdGVlX2NxX3dhaXRfaW5pdCsw
eDc4LzB4MTI0IFtvcHRlZSBmNmRiYzM1ZjhkOTZhY2JlMWYzYzMyOWQ3MjAxODE1MWQ3OTYyMDhk
XQ0KPiA+IMKgb3B0ZWVfc21jX2RvX2NhbGxfd2l0aF9hcmcrMHgxMmMvMHg5NWMgW29wdGVlIGY2
ZGJjMzVmOGQ5NmFjYmUxZjNjMzI5ZDcyMDE4MTUxZDc5NjIwOGRdDQo+ID4gwqBvcHRlZV9zaG1f
cmVnaXN0ZXIrMHgyODQvMHgzNjAgW29wdGVlIGY2ZGJjMzVmOGQ5NmFjYmUxZjNjMzI5ZDcyMDE4
MTUxZDc5NjIwOGRdDQo+ID4gwqByZWdpc3Rlcl9zaG1faGVscGVyKzB4MWE0LzB4MmY0IFt0ZWUg
Y2RkOGEwZDA3N2Q5ODRiZGExZjMxZjllODkwMzgzNmVkYmU0NjYwM10NCj4gPiDCoHRlZV9zaG1f
cmVnaXN0ZXJfa2VybmVsX2J1ZisweDYwLzB4OTAgW3RlZSBjZGQ4YTBkMDc3ZDk4NGJkYTFmMzFm
OWU4OTAzODM2ZWRiZTQ2NjAzXQ0KPiA+IMKgY21kcV9zZWNfYWxsb2NhdGVfd3NtKzB4NTgvMHhj
NCBbbXRrX2NtZHFfc2VjX21ib3ggYWM4MmRjOTU4ZTMyMjUyYTIxYzZjZTU1YmI4ODM5ZWJiMjg4
Mzg3YV0NCj4gPiDCoGNtZHFfc2VjX3Byb2JlKzB4ODAvMHg0YTAgW210a19jbWRxX3NlY19tYm94
IGFjODJkYzk1OGUzMjI1MmEyMWM2Y2U1NWJiODgzOWViYjI4ODM4N2FdDQo+ID4gDQo+ID4gV2Ug
Zm91bmQgdGhlIG9wdGVlLT5jYWxsX3F1ZXVlIGhhc24ndCBiZWVuIGluaXRpYWxpemVkIHdoZW4g
b3VyIGRyaXZlciBjYWxsZWQgT1AtVEVFLA0KPiA+IGFuZCBpdCBtaWdodCBoYXZlIHNvbWUgaXNz
dWVzIGFib3V0IHRoZSBkZXZpY2UgZGF0YSBzdHJ1Y3R1cmUgaW5pdGlhbGl6ZSBvcmRlciBpbg0K
PiA+IG9wdGVlX3Byb2JlKClbZHJpdmVycy90ZWUvb3B0ZWUvc21jX2FiaS5jXToNCj4gPiANCj4g
PiAtLS0NCj4gPiByYyA9IHRlZV9kZXZpY2VfcmVnaXN0ZXIob3B0ZWUtPnRlZWRldik7wqAgLy8g
PC0tLS0tIFRFRSBkZXZpY2UgcmVnaXN0ZXIgaGVyZQ0KPiA+IGlmIChyYykNCj4gPiDCoMKgwqAg
Z290byBlcnJfdW5yZWdfc3VwcF90ZWVkZXY7DQo+ID4gDQo+ID4gcmMgPSB0ZWVfZGV2aWNlX3Jl
Z2lzdGVyKG9wdGVlLT5zdXBwX3RlZWRldik7DQo+ID4gaWYgKHJjKQ0KPiA+IMKgwqDCoCBnb3Rv
IGVycl91bnJlZ19zdXBwX3RlZWRldjsNCj4gPiANCj4gPiBvcHRlZV9jcV9pbml0KCZvcHRlZS0+
Y2FsbF9xdWV1ZSwgdGhyZWFkX2NvdW50KTvCoCAvLyA8LS0tLS0gU29tZSBkYXRhIHN0cnVjdHVy
ZXMgYXJlIGluaXRpYWxpemVkIGFmdGVyd2FyZHMNCj4gPiBvcHRlZV9zdXBwX2luaXQoJm9wdGVl
LT5zdXBwKTsNCj4gPiBvcHRlZS0+c21jLm1lbXJlbWFwZWRfc2htID0gbWVtcmVtYXBlZF9zaG07
DQo+ID4gb3B0ZWUtPnBvb2wgPSBwb29sOw0KPiA+IG9wdGVlX3NobV9hcmdfY2FjaGVfaW5pdChv
cHRlZSwgYXJnX2NhY2hlX2ZsYWdzKTsNCj4gPiBtdXRleF9pbml0KCZvcHRlZS0+cnBtYl9kZXZf
bXV0ZXgpOw0KPiA+IC0tLQ0KPiA+IA0KPiA+IFdlIHdhbnQgdG8gYXNrIGlmIHRoZSBkYXRhIHN0
cnVjdHVyZSBpbml0aWFsaXphdGlvbiBzaG91bGQgYmUgZG9uZSBiZWZvcmUgdGhlIHRlZSBkZXZp
Y2UgcmVnaXN0cmF0aW9uPw0KPiA+IA0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBTaGFvLUZ1IENo
ZW4NCj4gPiANCj4gPiANCg0K
