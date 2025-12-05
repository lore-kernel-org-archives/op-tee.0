Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08691D2F7EF
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 13:45:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0C12A5008A
	for <op-tee@archiver.kernel.org>; Fri,  5 Dec 2025 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764942350;
	bh=fYojG21ZXjLnAhwu7pVKcdJouZ2PoTNcNbYnDn+04E0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=dkOudWSqaWotYqOMnr1OfaDk09IYzUzPbLp8HNwMc+xcxqkamI+SbbawjIA2TlqcQ
	 y5pSnSUJ6r6c3BZplr5FdsSYLaXz5kJUdslk9TdYfHFuxnX5Fjiv/aCbeGJFHGgK/2
	 FkEwGvRQgJzWGOSAp/qGcUBZWMovc+7RoSOVLHJ572pvZOmSXElCvNzv9/gc4GQjKD
	 z3oZxpSQmnhy7c4wbHr20sTz4t4fTr4MgvPnicF4wFZN/GsrzUtiYXUi6OkTWY9Gqj
	 YI3kilT0dlgcctIwMzDlmGN25+exMvntnodiIrlcl9ky9AgAjUani2foKbthVpuPpJ
	 Gd4kaXQtJIsyA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 16B9C4496A
	for <op-tee@lists.trustedfirmware.org>; Fri,  5 Dec 2025 13:45:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W2RWH2A+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=O2g+CLvW;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B5CqYUT232280
	for <op-tee@lists.trustedfirmware.org>; Fri, 5 Dec 2025 13:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3sl8Rjg+GpX/yS2Dz6T16538XX/lIJ0ynq5UJxUVvk8=; b=W2RWH2A+SBkAWlZQ
	7nYMJwmcmBg1D2pVENp8s6uIp+oHboyEu0Xoe3JxDUwmq2+xxwtzGwB14ZdKMeFl
	uLKzDsh+vO0Iyo+gt/nmE2RItg3XnpDyanwziDWzW/AJH+3Rz7ryvbO/E7Pwrw/K
	gwtqAYPzrCuyI9AYHHOrhWnw72LIsjiDLDrAc8NpUM7zAnbDMWHLLB0BgYy4zPt5
	VSl/2AUpm+YSac9fycLbJkEMfabCEH4poh2cL9AUca40sWRA5ZdocjfhfyCOvVTg
	l7JTxbnmdWCOwH9+3Xj5UlT7ZFk7YyAci/6CcS1VBJhJhn5ewLy/ESOzW4JfVpl9
	lGUOjA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4auys7g3r8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 13:45:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2982b47ce35so31017355ad.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 05 Dec 2025 05:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764942337; x=1765547137; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3sl8Rjg+GpX/yS2Dz6T16538XX/lIJ0ynq5UJxUVvk8=;
        b=O2g+CLvWxOrpaSVf8KouD5ZDIM30ijJXFvZYWgq4WJ24O61vi9BIr5pgKXGgj71MuR
         WHwNcALPimpvgs/Y3LthAND5y5KAOtAKj1/0jSfCBQoavvjYnkbxT3q75M2ResNzB4bm
         sw0sAUeF7XlcrZ68zvqM40bKPgT+dJ7Yv4SA9g/Slr+hhv8e6nGso7cbvVrdStR9Fdad
         cmCPCxdWom0Z4kMS1Sv63UaH12PlzdgTv9gapWlDJGE2ZYJs7HbrKKFIrws0yNAsiE8D
         DIzEHSeGmFYJ2PwQsr4gZY87OHAHutB0jT8AOiW6yP9umCeuJuVLTMV+g9zTs8EWWnTr
         RghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764942337; x=1765547137;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3sl8Rjg+GpX/yS2Dz6T16538XX/lIJ0ynq5UJxUVvk8=;
        b=P2HLOVUJ/9xvi1Vly2L1Vj3VOgH2rXBWsSIKyiMtpQKvOwW+YHvsEH3nHuzZzZg7nf
         Bm6zc8k0e45YBEmlrYqknOy6hoRrf9azykZM4RkX8Ql+tihHOl/r6xHnZh0EVcI+Q1YD
         WxYMvLQk1oX4kEIXaZ+GImSOZPxNhaZ0OlGACjoh0/tejvCly/BvW7o8BhAooZ3e6mG6
         upK+8FolLFeaGxAmVXqbmyfTdvdvkhTkcQyVUWlvgXBa1XnF0N/Hcx4YTfJxXum3rvb+
         j/Cuc0F6yrJPzLPdtwF2UA3HoO2cQqFg03kaMvgHThvIYHPmIYz8QtGnw1qDxe4ABGma
         7Blg==
X-Forwarded-Encrypted: i=1; AJvYcCWgrfZi2j/zhwcu2XQt9sMygQ/0dP8lnICFcetUSTtRshJbNu/Ib0fjCxpGJP7yCNzJsRPbtl4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzKMoZok8jtKXuT3u0eHpG4y09IAMIhjy44m01nHZKmelI+yTyZ
	dbc3PLBDTgWknQxb9vY1/73dUf7DVjVL0y/HhG9dymafkjSpc8aogfTkc83mp4DsgV+U3Dob8Ml
	2Uo5DsLjZrOv6U2eZP5ybBAFb6USPwstdJJMzKw3/L//ZfqprUrw2/bWNCwNf5w5tlAZWpn3c
X-Gm-Gg: ASbGncsB1AgTSytOH1xn7fm3boxeE6X5lueT/uAwYSbOku+Ax2EHEivF099drq/ZzqR
	qEVHZqr65rSPKGMdYgfOxzZkRO9hDZc3HKTNfPpX5w/JR9fhDo7f+RU8Q5W+EcU+aNtBxF26GO8
	D0T6SIQyEDGEoPbPbwnELzPcmkhn7a5U++bwnebb+QEXdoXIkwlOFb77v7g3+OlKUnFIuoLezX5
	AY3a0Tc4l+Jymb/dB35GimmOafnkO/zwrNciW6BtSZgC8FkjBjYGBZlMTlNztXcEsIC5nkF5kl0
	d+27ACTB3O+o8SeYQwyLO7X0ulD3FbWiKJppabTxyH2QMf2p6MdZpposWRdZkAgGHWCUhd02fiR
	0g/wEmC/1G9EWueB9miQPIKLfoKTg9ZY=
X-Received: by 2002:a17:902:fc87:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-29d682f2fd2mr118719985ad.18.1764942337135;
        Fri, 05 Dec 2025 05:45:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQItCN2pv1meTC+2kJm5EbTCziAT3dxjYamZYJ6XTWaTUtpDBXJSNwvI2VARxGJQ3jjTIVAg==
X-Received: by 2002:a17:902:fc87:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-29d682f2fd2mr118719575ad.18.1764942336600;
        Fri, 05 Dec 2025 05:45:36 -0800 (PST)
Received: from [192.168.29.116] ([49.37.148.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99fa59sm50494375ad.58.2025.12.05.05.45.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 05:45:35 -0800 (PST)
X-Google-Original-From: Harshal Dev <hdev@oss.qualcomm.com>
Message-ID: <45b5f14b-3746-4b05-a4b4-dc9f88e89e52@oss.qualcomm.com>
Date: Fri, 5 Dec 2025 19:15:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
References: <20251204101730.1036671-1-arnd@kernel.org>
 <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA5OCBTYWx0ZWRfXzpY8AzOGHgt0
 cTgUcxpuKOJfdsuc4R94tiDDr6l+bdo+LJesVgCO3LnORDuRA28cViAksLg1BNU92w9LnTrIYCX
 kEgJq8W0bFulXi9JbI3mIRcedUl7lc9C9Tx+cGP/cpmcUqiwsHnUDHx/bOp5HIQ4oQ9wAGx+/bd
 AeD3JT3KMTqzYn25zjIIZ5EmbMP929flpWUMRBMEky6D5OjMnPBB9PChn1moaNpLiEx1nSCHa7U
 AT6GSNEfAAYytl6FHDK11eXwUzeQmTlDqUnx4Mg4Sq4HA+U7CRBXlSiSXVnbZMtGHAS+sFhzvQs
 Uv+EQIs8jUc/YncBFM9fr4EbHgBViWKhWC3MpXg6s7euzhFiSKFxfKGDMmzVjJyUf2H6xc4kyIh
 0XSTo4Qdq7AhyK5IM+uCTOEjLuiVIA==
X-Proofpoint-ORIG-GUID: lildQRr4YYYoUWEBkCx50I9qnCevNa61
X-Proofpoint-GUID: lildQRr4YYYoUWEBkCx50I9qnCevNa61
X-Authority-Analysis: v=2.4 cv=GtVPO01C c=1 sm=1 tr=0 ts=6932e201 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=v+kbWGyw1T97G6+vs1uYIQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-jCBhvvmAAAA:20 a=VwQbUJbxAAAA:8
 a=xFIYUFTxM1JpX5VCbgAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050098
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 16B9C4496A
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: 3HJY2L3Z7X6FCU57B2477CSLZWQNAMMF
X-Message-ID-Hash: 3HJY2L3Z7X6FCU57B2477CSLZWQNAMMF
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Sumit Garg <sumit.garg@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3HJY2L3Z7X6FCU57B2477CSLZWQNAMMF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

SGksDQoNCk9uIDEyLzQvMjAyNSA2OjU3IFBNLCBKZW5zIFdpa2xhbmRlciB3cm90ZToNCj4gSGks
DQo+IA0KPiBPbiBUaHUsIERlYyA0LCAyMDI1IGF0IDExOjE34oCvQU0gQXJuZCBCZXJnbWFubiA8
YXJuZEBrZXJuZWwub3JnPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPg0KPj4NCj4+IFRoZSB0ZWVfaW9jdGxfb2JqZWN0X2ludm9rZV9hcmcgc3RydWN0
dXJlIGhhcyBwYWRkaW5nIG9uIHNvbWUNCj4+IGFyY2hpdGVjdHVyZXMgYnV0IG5vdCBvbiB4ODYt
MzIgYW5kIGEgZmV3IG90aGVyczoNCj4+DQo+PiBpbmNsdWRlL2xpbnV4L3RlZS5oOjQ3NDozMjog
ZXJyb3I6IHBhZGRpbmcgc3RydWN0IHRvIGFsaWduICdwYXJhbXMnIFstV2Vycm9yPXBhZGRlZF0N
Cj4+DQo+PiBJIGV4cGVjdCB0aGF0IGFsbCBjdXJyZW50IHVzZXJzIG9mIHRoaXMgYXJlIG9uIGFy
Y2hpdGVjdHVyZXMgdGhhdCBkbw0KPj4gaGF2ZSBpbXBsaWNpdCBwYWRkaW5nIGhlcmUgKGFybTY0
LCBhcm0sIHg4NiwgcmlzY3YpLCBzbyBtYWtlIHRoZSBwYWRkaW5nDQo+PiBleHBsaWNpdCBpbiBv
cmRlciB0byBhdm9pZCBzdXJwcmlzZXMgaWYgdGhpcyBsYXRlciBnZXRzIHVzZWQgZWxzZXdoZXJl
Lg0KPj4NCj4+IEZpeGVzOiBkNWI4YjBmYTE3NzUgKCJ0ZWU6IGFkZCBURUVfSU9DVExfUEFSQU1f
QVRUUl9UWVBFX09CSlJFRiIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPg0KPj4gLS0tDQo+PiBUaGUgbmV3IGludGVyZmFjZSBzaG93ZWQgdXAgaW4gNi4x
OCwgYnV0IEkgb25seSBjYW1lIGFjcm9zcyB0aGlzIGFmdGVyDQo+PiB0aGF0IHdhcyByZWxlYXNl
ZC4gQ2hhbmdpbmcgaXQgbm93IGlzIHRlY2huaWNhbGx5IGFuIEFCSSBjaGFuZ2Ugb24NCj4+IGFy
Y2hpdGVjdHVyZXMgd2l0aCB1bnVzdWFsIHBhZGRpbmcgcnVsZXMsIHNvIHBsZWFzZSBjb25zaWRl
ciBjYXJlZnVsbHkNCj4+IHdoZXRoZXIgd2Ugd2FudCB0byBkbyBpdCB0aGlzIHdheSBvciBub3Qu
DQo+Pg0KPj4gV29ya2luZyBhcm91bmQgdGhlIEFCSSBkaWZmZXJlbmNlcyB3aXRob3V0IGFuIEFC
SSBjaGFuZ2UgaXMgcG9zc2libGUsDQo+PiBidXQgYWRkcyBhIGxvdCBvZiBjb21wbGV4aXR5IGZv
ciBjb21wYXQgaGFuZGxpbmcuDQo+IA0KPiBUaGlzIGlzIGN1cnJlbnRseSBvbmx5IHVzZWQgYnkg
dGhlIHJlY2VudGx5IGludHJvZHVjZWQgcWNvbXRlZSBiYWNrZW5kDQo+IGRyaXZlci4gU28gaXQn
cyBvbmx5IHVzZWQgb24gYSBmZXcgYXJtNjQgUXVhbGNvbW0gcGxhdGZvcm1zIHJpZ2h0IG5vdy4N
Cj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIHRha2UgdGhpcyBwYXRjaCwgYnV0IGxldCdzIGhlYXIg
d2hhdCBvdGhlcnMgdGhpbmsuDQo+IA0KPiBUaGFua3MsDQo+IEplbnMNCj4gDQpUaGUgb25seSB1
c2VyLXNwYWNlIGNsaWVudCB3aGljaCBpcyBjdXJyZW50bHkgdXNpbmcgdGhpcyBBQkkgKGFzIHBl
ciBvdXIga25vd2xlZGdlKQ0KaXMgdGhlIGxpYnFjb210ZWUgbGlicmFyeTogaHR0cHM6Ly9naXRo
dWIuY29tL3F1aWMvcXVpYy10ZWVjL2Jsb2IvbWFpbi9saWJxY29tdGVlL3NyYy9saW51eC90ZWUu
aCNMNDMyDQoNCklmIEkgdW5kZXJzdGFuZCBBcm5kJ3MgY29uY2VybiBjb3JyZWN0bHksIGlmIGEg
Y29tcGlsZXIgdXNlZCB0byBidWlsZCB0aGUgdXNlci1zcGFjZQ0KY2xpZW50IHNraXBzIHRoZSBw
YWRkaW5nIGZvciB0ZWVfaW9jdGxfb2JqZWN0X2ludm9rZV9hcmcsIGl0IGNvdWxkIGxlYWQgdG8g
aXNzdWVzLg0KDQpMZXQncyB3YWl0IGZvciBBbWlyJ3MgdmlldyBoZXJlIGFzIHdlbGwsIGhvd2V2
ZXIgSSBkbyB0aGluayB0aGUgZXhwbGljaXQgcGFkZGluZyB3b3VsZA0KYmVuZWZpdCBoZXJlLg0K
DQpSZWdhcmRzLA0KSGFyc2hhbA0KDQo+PiAtLS0NCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvdGVl
LmggfCAxICsNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3RlZS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Rl
ZS5oDQo+PiBpbmRleCBjYWI1Y2FkY2E4ZWYuLjUyMDM5NzdlZDM1ZCAxMDA2NDQNCj4+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC90ZWUuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3Rl
ZS5oDQo+PiBAQCAtNDcwLDYgKzQ3MCw3IEBAIHN0cnVjdCB0ZWVfaW9jdGxfb2JqZWN0X2ludm9r
ZV9hcmcgew0KPj4gICAgICAgICBfX3UzMiBvcDsNCj4+ICAgICAgICAgX191MzIgcmV0Ow0KPj4g
ICAgICAgICBfX3UzMiBudW1fcGFyYW1zOw0KPj4gKyAgICAgICBfX3UzMiA6MzI7DQo+PiAgICAg
ICAgIC8qIG51bV9wYXJhbXMgdGVsbHMgdGhlIGFjdHVhbCBudW1iZXIgb2YgZWxlbWVudCBpbiBw
YXJhbXMgKi8NCj4+ICAgICAgICAgc3RydWN0IHRlZV9pb2N0bF9wYXJhbSBwYXJhbXNbXTsNCj4+
ICB9Ow0KPj4gLS0NCj4+IDIuMzkuNQ0KPj4NCg0K
