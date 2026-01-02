Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABBEE9410B
	for <op-tee@archiver.kernel.org>; Fri,  2 Jan 2026 08:52:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6B3CB4FF25
	for <op-tee@archiver.kernel.org>; Fri,  2 Jan 2026 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767343944;
	bh=DrIuceuWYgnYleZoVWvAA7Catx3jlhqNUQOJ7A+d+co=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=WCp05AisbvEWaQ30nfPEX8vMzMXCE6gqxFxGJpKuygakI7lUpQNRp+4oSECihLbq0
	 02B37V7Nixa1vBbAYXDc0bI/MAjq6dwParrOR7OYYbi0d+eX5iIjm8u6U+9O8QTtoh
	 R29ZD8rj3bJkY7DMj35bOi5oT+y9wfMrIhZZ6v0yy49FX1VEcT2y60f5RBlpd97isw
	 SoQC8DuViTBY2gmTM+w3wl4Mzk1Z/ZNrFqw+2j4Y4jYFGtJYjoEgl2K5LwOWE6E6p6
	 BZpzJEtVUnIzaUMOH4ZRcO70hhCkoV+/Ouywb0ksZoWbRtaW+cRH8ubvKEZHlsH+B8
	 sMfIGamiSSnqQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5280E4186C
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Jan 2026 08:52:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fcpkUn/W;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LFKs0xFh;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60288kQf653595
	for <op-tee@lists.trustedfirmware.org>; Fri, 2 Jan 2026 08:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dck1FMH5+529OQZs4upRhnI08b0XarE74F/QtaaToY8=; b=fcpkUn/WOOviTj8X
	hV6IHFdWfup3NuYa6G/ES6qJ8YVIPJP18uVjCzfzMaf0kuR6mZS9KrSoks0qDl/q
	6A1f7GVeohIFuUPSI7skCS72BU7RK1W/EwO/pBKE7ni9Hlk5nDgPkV9JOZX66Npn
	DwvtMnrM8wkh+U8LrI59MRVRbk9HlUymLqzmMe9r22F0U0l9xAzzWCp5OWQBLP6p
	NIb3TfrMi8osSM/9t5fUGadJ9+8wDljConpsqtCg7N+d6XAqDPSFtCtDrmE3Mgq2
	Jv1DJeHDu+v/jy1kJmwQVYD2C1hBEM48KrTgu+mWAP+oaFCtkq3eliX0Yc/IsJDF
	sIcVNg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bd8532x38-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 02 Jan 2026 08:52:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f4822f77so320962595ad.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Jan 2026 00:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767343923; x=1767948723; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dck1FMH5+529OQZs4upRhnI08b0XarE74F/QtaaToY8=;
        b=LFKs0xFhBt5vnzz8j0jyKwdFJXred/m3dEuLCOsScLRc10HtR84ZUYHrcP8JY/edjZ
         bXGs/hMZSoHl1D/EFxg9XsO0NxLS0yfqA14gopBdWi9s88ZHxhcz2K4XSBQ5YA/yVPIs
         IV3VC65niHAbRpq1KvVHcKXwGnSNuNaSWk2xPoJrIB9lgpnEoJxwiBPNCdCtMo0ZtPmY
         ag2jIr8oMu9ZD9nQX9FKOjnv/UpceaaV/4IingsesQc6dmiqWyIzjZK5cNKbwfnr8jFR
         htz8dYzfoj8kRyno+UqusfWTssGv41uEhxuiCI4oeGRlnqZVmKkeIFAaXMrWCnxWx6hm
         6MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767343923; x=1767948723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dck1FMH5+529OQZs4upRhnI08b0XarE74F/QtaaToY8=;
        b=uQZYolPni2LPNyrR9IhEGiDQRJN/fbp5LImIZ3FbfBEFkn+qlK22KLvQqQi/1Qk7nN
         d+ovyfySrR+xXURcILOAT9ZtfwRW9Rfb5iYiFh+4EdOzhyo6CHrJs/rPdxOqvBv0K5lB
         L7QqsRhZNQzXQTgZP0tPc9udprrCJxSJ5vGiDmzuhHkGEgYYgVeiKgek5cdU45z1vqeq
         xsFFs3JgRGom+8x9pJffCCQjtwLP5vz3lE4EEilReq0j2C3JocL0nwkDugRDUiBR8If0
         cjemnVL62MDxzb/x4Kk5m8f8wss4X46brcd9FX3Cg+qGe0boF99g4fxApTaVwYe3tDDP
         YWqw==
X-Forwarded-Encrypted: i=1; AJvYcCWglNcpPh2D7NZCINwEC6xoLBvgIQQYw4OWK0sU2GW6xDMJ6H8hmcyJAJYgIjkbBWnT+I5GPHI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyS+nRBDRyT1jI78OxBB6mGwFzrf0LdDiNVMmSlXfgSymFcRVvg
	ibQrnFueednXWXwzG4IZgAlo3RhGrlsWTmHkcEVFAhyVl55Rc37nBAHCv/JxLPh1ReKGZRyyjnW
	p+4LriqaFVqzWWfjJWgrzq0mIN8NYm4uhBIlCBeA3jxc0vy2LPSGU9BmRnwmQ4ipWdCYsNABU
X-Gm-Gg: AY/fxX6ReBBkWxDXr/UAqSG9HdHt7kQXDec9RDOJm9heS+a5GWE2dlxTv0vgv/swhVw
	+0dm4GOi/cWum9i1FqF28O20mdRTyQpZB9YLf3JtDkklfHfvmSP3+QhpbraidImSFxnow/pye2z
	cpvtjzbbJUwHGOVWW1Alpxtn3PYfX+YLDT2/YIO7YRmGLdg4XDUrDuWRR49bF/yheQee/mgtrpH
	EDV4SMeRQOVwGaTqzpFK9E5RdLUf1+OZPYF5BOF+ijxqjmrrRw+z2ohlFTG9CD2VQncpMmQpDbf
	0k0Xn6tPoo5I+3VagkrtFu2tAFKyUBELEYcvorORZ+7kn6VhzctKYzJruexbD3AGhe0OVWQrT8i
	/IlD8izUne7Cmxj10UB3NZ4VCYHamC3OJKN5Owgc=
X-Received: by 2002:a17:903:2345:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a2f220cebfmr410902625ad.3.1767343923343;
        Fri, 02 Jan 2026 00:52:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLcFnsdxPHUvpNPGubhk1FmkA837mfXTLkteNRhMhQ3K+KRE9udt9ClOHUIOhvMwftHA+Y9g==
X-Received: by 2002:a17:903:2345:b0:2a0:d629:9035 with SMTP id d9443c01a7336-2a2f220cebfmr410902485ad.3.1767343922783;
        Fri, 02 Jan 2026 00:52:02 -0800 (PST)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66829sm374713935ad.10.2026.01.02.00.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 00:52:02 -0800 (PST)
Message-ID: <5a064c67-2c15-4ab9-ad34-a56a2e0ec150@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 14:21:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Bjorn Andersson <andersson@kernel.org>
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
 <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
 <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
 <05581cbd-dfcc-41ac-9020-b1590b8ed7a8@oss.qualcomm.com>
 <aTtvHYDOny33yeOD@sumit-X1>
 <0a4368bf-40a2-42bb-b538-6e64c11598e3@oss.qualcomm.com>
 <cr5ryvw2zblk44zxb3cbwqglhqs5gq4iy6gcfjrofdal5khvsr@g6txeiqgoneu>
Content-Language: en-US
In-Reply-To: <cr5ryvw2zblk44zxb3cbwqglhqs5gq4iy6gcfjrofdal5khvsr@g6txeiqgoneu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: oECJm7lLYYVSiZZGcCzRd7cOvN9AVMsD
X-Authority-Analysis: v=2.4 cv=fL80HJae c=1 sm=1 tr=0 ts=69578734 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8
 a=FZF5ihgMX_pi5EyomNgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: oECJm7lLYYVSiZZGcCzRd7cOvN9AVMsD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDA4MSBTYWx0ZWRfX+bPhbH35p+gE
 rjx/EeMgBz968B7gN6ByMqsRr6jFY6yfTYaNJEhJiK+KZ2sebEibUuJrEBt3Qg7uRzfuILyvfcA
 0cKoSVGU803R2ZV2W+MYlObrxl2FWDZgoPCot2FswO+4r1ftEROr/UKd8M3+91GZfrEk9uQ4pS4
 gtFjGWupRaKkPIYHI/IzuVdrHlVXpyBhrj4gDV2lRhllyiI/dZDI9gGwxw3/aHCxPkkmCbC8wyX
 SoMMxSMy9cD8s1vJtH4VllxDv0B1zI5boiQY4bcXBKFDtkV08cEhldxNfcjYy1bX8xDONeAVW1K
 1CvpSYSHl5Ud4DhE+xsBs9WvPQ+rbnUAuTXX3I5W6dEVGZTpfSFHJJr/dwnyJSmM1wuw//HRePN
 aSONEOSKpdq8PO0efMuGPM6w4XhWm8xkpF24uyJYw4+eZKOpUh8BGLpMkg31/GHbP1JMg5IpykV
 lRjsyWTGsT+H9xjeP4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-01_07,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020081
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	BLOCKLISTDE_FAIL(0.00)[209.85.214.197:server fail,205.220.168.131:server fail,202.46.22.19:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5280E4186C
X-Spamd-Bar: ----
Message-ID-Hash: AW4T2NOBL6HYU4SFTJQEGVFBDCIVNH3L
X-Message-ID-Hash: AW4T2NOBL6HYU4SFTJQEGVFBDCIVNH3L
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AW4T2NOBL6HYU4SFTJQEGVFBDCIVNH3L/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

SGkgQmpvcm4sDQoNCk9uIDEyLzIyLzIwMjUgMTA6MjYgUE0sIEJqb3JuIEFuZGVyc3NvbiB3cm90
ZToNCj4gT24gTW9uLCBEZWMgMTUsIDIwMjUgYXQgMDQ6NTA6MzlQTSArMDUzMCwgSGFyc2hhbCBE
ZXYgd3JvdGU6DQo+PiBIaSBhbGwsDQo+Pg0KPj4gT24gMTIvMTIvMjAyNSA2OjU1IEFNLCBTdW1p
dCBHYXJnIHdyb3RlOg0KPj4+IE9uIFdlZCwgRGVjIDEwLCAyMDI1IGF0IDAyOjM1OjE5UE0gKzA1
MzAsIEhhcnNoYWwgRGV2IHdyb3RlOg0KPj4+PiBIaSBCam9ybiwNCj4+Pj4NCj4+Pj4gT24gMTIv
MTAvMjAyNSA5OjIxIEFNLCBCam9ybiBBbmRlcnNzb24gd3JvdGU6DQo+Pj4+PiBPbiBNb24sIERl
YyA4LCAyMDI1IGF0IDEwOjE04oCvUE0gRG1pdHJ5IEJhcnlzaGtvdg0KPj4+Pj4gPGRtaXRyeS5i
YXJ5c2hrb3ZAb3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6DQo+Pj4+Pj4gT24gVHVlLCA5IERlYyAy
MDI1IGF0IDA3OjU4LCBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+IHdyb3Rl
Og0KPj4+Pj4+Pg0KPj4+Pj4+PiBPbiAwOC8xMi8yMDI1IDEzOjE4LCBIYXJzaGFsIERldiB3cm90
ZToNCj4+Pj4+Pj4+IEVuYWJsZSBRQ09NVEVFIGRyaXZlciBvbiBRdWFsY29tbSBTTTg2NTArIFNv
Q3MgdG8gZmFjaWxpdGF0ZSBjb21tdW5pY2F0aW9uDQo+Pj4+Pj4+PiB3aXRoIHRoZSBRdWFsY29t
bSBUcnVzdGVkIEV4ZWN1dGlvbiBFbnZpcm9ubWVudCAoUVRFRSkuDQo+Pj4+Pj4+PiAoTm8gZW5h
YmxlbWVudCByZXF1aXJlZCBpbiBEVFMgZmlsZXMgc2luY2UgUUNPTVRFRSBkZXZpY2UgaXMgZHlu
YW1pY2FsbHkNCj4+Pj4+Pj4+IHJlZ2lzdGVyZWQgYnkgdGhlIFFDT01fU0NNIGZpcm13YXJlIGRy
aXZlcikNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBIYXJzaGFsIERldiA8aGFy
c2hhbC5kZXZAb3NzLnF1YWxjb21tLmNvbT4NCj4+Pj4+Pj4+IC0tLQ0KPj4+Pj4+Pj4gQ2hhbmdl
cyBpbiB2MzoNCj4+Pj4+Pj4+IC0gVXBkYXRlZCB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gcmVmbGVj
dCB0aGUgc3VwcG9ydGVkIFF1YWxjb21tIHBsYXRmb3Jtcy4NCj4+Pj4+Pj4+IC0gTGluayB0byB2
MjogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MTIwNS1xY29tX3Fjb210ZWVfZGVmY29u
ZmlnLXYyLTEtYzkyNTYwYjAzNDZlQHF0aS5xdWFsY29tbS5jb20NCj4+Pj4+Pj4+DQo+Pj4+Pj4+
DQo+Pj4+Pj4+IEkgZ2F2ZSB5b3UgdGhlIGV4YWN0IGV4YW1wbGUgdG8gZm9sbG93LiBNYXliZSBp
dCBpcyBub3QgdGhhdCBpbXBvcnRhbnQNCj4+Pj4+Pj4gZm9yIG90aGVycywgc28gSSB3aWxsIG5v
dCBvYmplY3QsIGJ1dCBPVE9IIGl0IGlzIGltcG9ydGFudCBmb3IgbWUsIHRodXMNCj4+Pj4+Pj4g
SSB3aWxsIG5vdCBnaXZlIHJldmlld2VkIGJ5LiBJIGRhbW4gYXNrZWQgVkVSWSBDTEVBUkxZOg0K
Pj4+Pj4+Pg0KPj4+Pj4+PiAiSnVzdCBtZW50aW9uIHdoaWNoIFVQU1RSRUFNIGJvYXJkcyAod2hp
Y2ggeW91IGNhbGxlZCBRdWFsY29tbQ0KPj4+Pj4+PiBwbGF0Zm9ybXMpIHVzZSB0aGlzIGRyaXZl
ci4iDQo+Pj4+Pj4NCj4+Pj4+PiArMSBIZXJlLiBEZWZjb25maWcgY2hhbmdlcyBtZW50aW9uIGRl
dmljZXMsIG5vdCBTb0MgZmFtaWxpZXMuDQo+Pj4+Pj4NCj4+Pj4+DQo+Pj4+PiBJIGRvbid0IGFn
cmVlIHRoYXQgeW91IGhhdmUgdG8gbWVudGlvbiBhIHNwZWNpZmljIGJvYXJkLCBpZiB0aGUNCj4+
Pj4+IGZlYXR1cmUgaXMgdXNlZCBieSBhbGwgYm9hcmRzLiBCdXQgSSB0aGluayB0aGUgY29tbWl0
IG1lc3NhZ2Ugc2hvdWxkDQo+Pj4+PiBtYWtlIF90aGF0XyBjbGVhci4NCj4+Pj4+DQo+Pj4+DQo+
Pj4+IFRoYW5rcyBmb3IgdGhpcyBpbnB1dCBCam9ybi4gSSBnYXRoZXIgd2UgYXJlIG5vdyBhbGln
bmVkIHRoYXQgdGhlIGJvYXJkDQo+Pj4+IGluZm9ybWF0aW9uIGlzIG5vdCByZXF1aXJlZC4NCj4+
Pj4NCj4+Pj4gVGhlbiB0aGUgb3RoZXIgcGFydCB0byB0aGlzIGlzIGhvdyB0byBwcm92aWRlIGlu
Zm9ybWF0aW9uIG9uIHRoZSBwYXJ0aWN1bGFyDQo+Pj4+IFNvQ3MgdXNpbmcgdGhpcy4NCj4+Pj4N
Cj4+Pj4+IE9uIHRoZSBjb250cmFyeSwgdGhlIGNvbW1pdCBtZXNzYWdlIHNheXMgdGhhdCB3ZSdy
ZSBlbmFibGluZw0KPj4+Pj4gQ09ORklHX1FDT01URUUgYmVjYXVzZSBpdCdzIHVzZWQgb24gIlNN
ODU2MCsiLiBXaGF0IGRvZXMgdGhlIHBsdXMNCj4+Pj4+IG1lYW4/DQo+Pj4+DQo+Pj4+IEkgdG9v
ayByZWZlcmVuY2UgZnJvbSBzaW1pbGFyIGNvbW1pdHMgbWVyZ2VkIGVhcmxpZXIgd2hlcmUgdGhl
IHBsdXMgc2VlbWVkDQo+Pj4+IHRvIGluZGljYXRlIHRoYXQgYWxsIFF1YWxjb21tIFNvQ3MgZnJv
bSAnU004NjUwJyBvbi13YXJkcywgdGhhdCBpcywgU004NzUwLA0KPj4+PiBTTTg4NTAgYW5kIHNv
IG9uLiBJdCBmZWx0IHRoYXQgdGhlIHBsdXMgc2lnbiBpcyBzZWxmLWV4cGxhbmF0b3J5IHNpbmNl
IGl0DQo+Pj4+IGhhcyBiZWVuIHVzZWQgYWxyZWFkeS4gQnV0IHN1cmUsIG1heWJlIHdlIGNhbiBi
ZSBleHBsaWNpdCBmcm9tIG5vdyBvbiBhbmQgc2F5DQo+Pj4+IGZyb20gJ1F1YWxjb21tIFNNODY1
MCBvbndhcmRzJy4NCj4+Pj4NCj4+Pj4gY29tbWl0IGM1ZDAyYmJhYTIxN2IyNDU0YmExY2U3NTI4
MTEzYWEyZWNmMTRmM2MNCj4+Pj4NCj4+Pj4+IEFsc28sIHRoZSBkcml2ZXIgaXNuJ3QgZW5hYmxl
ZCAib24gUXVhbGNvbW0gU004NjUwKyIsIGl0J3MgZW5hYmxlZCBpbg0KPj4+Pj4gdGhlIEFtNjQg
ZGVmY29uZmlnLCBpLmUuIGl0J3MgZW5hYmxlZCBvbiBhbGwgQXJtNjQgYm9hcmRzIC0gdGhlDQo+
Pj4+PiBxdWVzdGlvbiB0aGF0IHNob3VsZCBiZSBhbnN3ZXJlZCBieSB0aGUgY29tbWl0IG1lc3Nh
Z2UgaXMgIndoeT8iLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gRXZlbiB0aG91Z2ggd2UgYXJlIGVuYWJs
aW5nIHRoaXMgdmlhIHRoZSBhcm02NCBkZWZjb25maWcsIGl0IGlzIG5vdCB0cnVlIHRoYXQNCj4+
Pj4gdGhlIGRyaXZlciBpcyBhcHBsaWNhYmxlIGZvciBhbGwgYXJtNjQgYm9hcmRzLiBUaGUgc2lt
cGxlIHJlYXNvbiBiZWluZyB0aGF0DQo+Pj4+IHRoZSBRVEVFIGZpcm13YXJlIE9TIHRoYXQgdGhl
IGRyaXZlciBjb21tdW5pY2F0ZXMgd2l0aCBydW5zIG9ubHkgb24gUXVhbGNvbW0NCj4+Pj4gU29D
cyB1c2luZyBhcm02NCBDUFVzIHdpdGggQVJNIFRydXN0Wm9uZSB0ZWNobm9sb2d5Lg0KPj4+Pg0K
Pj4+PiBUaGlzIGlzIHdoeSBJIHdvdWxkIHRyeSB0byBhdm9pZCBhIGNvbW1pdCBtZXNzYWdlIHdo
aWNoIGNsYWltcyB0aGUgdGhlIGRyaXZlcg0KPj4+PiBpcyBhcHBsaWNhYmxlIHRvIGFsbCBhcm02
NCBib2FyZHMuDQo+Pj4+DQo+Pj4+IEJhc2VkIG9uIGFsbCB0aGlzLCBJIGFtIHRoaW5raW5nIHBl
cmhhcHMgaXQgd291bGQgYmUgYmV0dGVyIHRvIHNheSB0aGF0IHRoZQ0KPj4+PiBwYXRjaCBlbmFi
bGVzIFFDT01URUUgZHJpdmVyIGZvciBRdWFsY29tbSBTb0NzIHdpdGggYXJtNjQgQ1BVcz8gV2Ug
Y291bGQgZHJvcA0KPj4+PiBtZW50aW9ucyBvZiBzcGVjaWZpYyBTTTh4NTAgbW9kZWxzIHdpdGgg
SERLL01UUCBib2FyZHMgc2luY2UgdGhlIGZlYXR1cmUgaXMNCj4+Pj4gYWdub3N0aWMgdG8gdGhv
c2U/DQo+Pj4NCj4+PiBBRkFJSywgdGhlIFFDT01URUUgZHJpdmVyIHdvcmtzIG9uIHRoZSBRY29t
IFNvQ3MgYmFzZWQgb24gYXJtNjQgd2hpY2ggc3VwcG9ydHMNCj4+PiB0aGUgU01DSW52b2tlIHBy
b3RvY29sLiBTbyB3ZSBzaG91bGQgYmUgZXhwbGljaXQgYWJvdXQgaXQuIFJlZ2FyZGluZw0KPj4+
IG1lbnRpb24gb2YgcmVmZXJlbmNlIHB1YmxpY2x5IGF2YWlsYWJsZSBib2FyZHMsIEkgY2FuIHNl
ZSBob3cgaXQgY2FuIGJlIHVzZWZ1bA0KPj4+IGZvciB0aGUgY29tbXVuaXR5IHRvIHRlc3QgUVRF
RSBiYXNlZCBhcHBzLiBJZiB5b3UgY2FuIG1lbnRpb24gc2F5DQo+Pj4gZXhhbXBsZSBSQjNHZW4y
IHN1cHBvcnRzIFFURUUgZHJpdmVyIGF0IGxlYXN0IHRoZW4gaXQgd2lsbCBiZSBoZWxwZnVsLg0K
Pj4+DQo+Pg0KPj4gQmFzZWQgb24gY29uc29saWRhdGVkIGZlZWRiYWNrIG9uIHRoaXMgdGhyZWFk
LCBJIGFtIHRoaW5raW5nIG9mIHRoZSBmb2xsb3dpbmcNCj4+IGNvbW1pdCBtZXNzYWdlLCBsZXQg
bWUga25vdyBpZiB0aGlzIGlzIGEgZ28gZnJvbSBldmVyeW9uZSdzIHBlcnNwZWN0aXZlOg0KPj4N
Cj4+ICINCj4+IGFybTY0OiBkZWZjb25maWc6IEVuYWJsZSBRQ09NVEVFIGZvciBRdWFsY29tbSBT
b0NzIHVzaW5nIGFybTY0IENQVXMNCj4+DQo+PiBFbmFibGUgUUNPTVRFRSBkcml2ZXIgYXMgYSBt
b2R1bGUgZm9yIFF1YWxjb21tIFNvQ3MgYmFzZWQgb24gYXJtNjQgQ1BVcyBhbmQNCj4+IHN1cHBv
cnRpbmcgdGhlIFNNQ0ludm9rZSBwcm90b2NvbCBmb3IgY29tbXVuaWNhdGlvbiB3aXRoIHRoZSBR
dWFsY29tbSBUcnVzdGVkDQo+PiBFeGVjdXRpb24gRW52aXJvbm1lbnQgKFFURUUpLg0KPj4NCj4+
IFRoZSBkcml2ZXIgaXMgdGVzdGVkIG9uIGEgUXVhbGNvbW0gUkIzR2VuMiBib2FyZCBieSBsb2Fk
aW5nIGFuZCBleGVjdXRpbmcgYQ0KPj4gVHJ1c3RlZCBBcHBsaWNhdGlvbiB2aWEgdGVzdHMgaG9z
dGVkIGF0IHd3dy5naXRodWIuY29tL3F1YWxjb21tL21pbmtpcGMuDQo+PiAiDQo+IA0KPiBJIGRv
bid0IHRoaW5rIHRoaXMgYW5zd2VycyBLcnp5c3p0b2YncyBxdWVzdGlvbiwgYW5kIGl0IGRvZXNu
J3QgYWRkcmVzcw0KPiBteSBjb25jZXJuLg0KPiANCj4gWW91J3JlIHNheWluZyB0aGF0IHlvdSdy
ZSBlbmFibGluZyB0aGUgZHJpdmVyIGZvciBRdWFsY29tbS1iYXNlZCBBcm02NA0KPiBTb0Mgd2hp
Y2ggc3VwcG9ydHMgU01DSW52b2tlLiBCdXQgYXMgSSBzYWlkLCB0aGF0J3Mgbm90IHdoYXQgeW91
J3JlDQo+IGRvaW5nOyB5b3UgYXJlIGVuYWJsaW5nIHRoZSBkcml2ZXIgZm9yIGFsbCBBcm02NCBi
b2FyZHMsIGZyb20gYWxsDQo+IHZlbmRvcnMsIHJlZ2FyZGxlc3Mgb2YgdGhlbSBoYXZpbmcgU01D
SW52b2tlIG9yIG5vdC4NCj4gDQo+IFRoZSBjb21taXQgbWVzc2FnZSBzaG91bGQgYmUgaW4gdGhl
IGZvcm0gb2Y6DQo+IA0KPiAiQWxsIFFURUUtYmFzZWQgUXVhbGNvbW0gdGFyZ2V0cywgc2luY2Ug
U00xMjM0LCBwcm92aWRlcyBhY2Nlc3MgdG8gdGhlDQo+IHNlY3VyZSB3b3JsZCB0aHJvdWdoIHRo
ZSBTTUNJbnZva2UgaW50ZXJmYWNlLCB3aGljaCBpcyBpbXBsZW1lbnRlZCBpbg0KPiB0aGUgcWNv
bXRlZSBkcml2ZXIuIEVuYWJsZSB0aGlzIGRyaXZlciBpbiBvcmRlciB0byAuLi4iDQo+IA0KDQpJ
IGFncmVlIHRoYXQgdGhlIGRlZmNvbmZpZyBjaGFuZ2UgZWZmZWN0aXZlbHkgZW5hYmxlcyB0aGUg
ZHJpdmVyIGZvciBhbGwgYXJtNjQNCmJvYXJkcywgbm90IGp1c3QgUXVhbGNvbW0gU29DIGJhc2Vk
IG9uZXMuIFRvIGNsYXJpZnkgdGhpcyBpbiB0aGUgY29tbWl0IG1lc3NhZ2UsDQpsZXQgbWUgZXhw
bGljaXRseSBzdGF0ZSB0aGUgZm9sbG93aW5nOg0KLSBXaHkgd2UgYXJlIGVuYWJsaW5nIGl0IGZv
ciBhbGwgYXJtNjQgYm9hcmRzLg0KLSBGcm9tIHdoaWNoIFF1YWxjb21tIFNvQyBvbndhcmRzIHRo
ZSBkcml2ZXIgaXMgYXBwbGljYWJsZSB0by4NCi0gV2hhdCBmdW5jdGlvbmFsaXR5IHRoZSBkcml2
ZXIgcHJvdmlkZXMuDQotIEhvdyBpdCdzIGZ1bmN0aW9uYWxpdHkgaGFzIGJlZW4gdGVzdGVkIGFu
ZCBvbiB3aGljaCBib2FyZC4NCg0KIg0KYXJtNjQ6IGRlZmNvbmZpZzogRW5hYmxlIFFDT01URUUg
bW9kdWxlIGZvciBRVEVFLWVuYWJsZWQgUXVhbGNvbW0gU29Dcw0KDQpBbGwgUXVhbGNvbW0gU29D
cyBzdGFydGluZyBmcm9tIFNNODY1MCBwcm92aWRlIGFjY2VzcyB0byB0aGUgUXVhbGNvbW0gVHJ1
c3RlZA0KRXhlY3V0aW9uIEVudmlyb25tZW50IChRVEVFKSB0aHJvdWdoIHRoZSBTTUNJbnZva2Ug
aW50ZXJmYWNlLCBpbXBsZW1lbnRlZCBieQ0KdGhlIFFDT01URUUgZHJpdmVyLiBRVEVFIHJ1bnMg
aW4gdGhlIFNlY3VyZSBXb3JsZCBkb21haW4gb24gQVJNNjQgQ1BVcyBhbmQNCmV4cG9zZXMgc2Vj
dXJlIHNlcnZpY2VzIHRvIExpbnV4IHJ1bm5pbmcgaW4gdGhlIE5vcm1hbCBXb3JsZCBkb21haW4u
DQoNClRoaXMgY2hhbmdlIGVuYWJsZXMgdGhlIFFDT01URUUgZHJpdmVyIGFzIGEgbW9kdWxlIHRv
IHN1cHBvcnQgY29tbXVuaWNhdGlvbg0Kd2l0aCBRVEVFLg0KDQpRQ09NVEVFIGhhcyBiZWVuIHRl
c3RlZCBvbiBhIFF1YWxjb21tIFJCM0dlbjIgYm9hcmQgYnkgbG9hZGluZyBhbmQgZXhlY3V0aW5n
DQphIFRydXN0ZWQgQXBwbGljYXRpb24gdmlhIHRlc3RzIGhvc3RlZCBhdCBnaXRodWIuY29tL3F1
YWxjb21tL21pbmtpcGMuDQoiDQoNClRoaXMgc2hvdWxkIG1ha2UgaXQgY2xlYXIgdG8gYWxsIGFy
bTY0IGJvYXJkIHZlbmRvcnMgdGhhdCB0aGlzIGNoYW5nZSwgYWx0aG91Z2gNCmJlaW5nIGRvbmUg
Zm9yIGFsbCBhcm02NCBib2FyZHMsIGlzIG9ubHkgYXBwbGljYWJsZSB0byB0aGUgb25lcyB3aXRo
IFF1YWxjb21tIFNvQw0KYW5kIFFURUUgc3VwcG9ydC4NCg0KVGhhbmsgeW91LA0KSGFyc2hhbA0K
DQo+IFJlZ2FyZHMsDQo+IEJqb3JuDQo+IA0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBIYXJzaGFsDQo+
Pg0KPj4+IC1TdW1pdA0KPj4+DQo+Pj4gWy4uLl0NCj4+DQoNCg==
