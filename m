Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C239CA5FAB
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:17:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 420BA44A29
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790651875;
	bh=WvpTP90DbRRSwQLoKPRdIvLjNlN38SFo6MKNJ+fijVQ=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=FwxRsMXrFMnV2Caf1fccPUn9uEGpba4yU7CUGD4V2R2i2BJ4vZ120mUmz/4Nmy7/I
	 /u+giXpecW/zw62stxfZCcV3EIZtP4K9sSLRd6zIScpxo7c2bAouP+XQSIOwhkZJ4I
	 8wderkLdosL0lLMhAEWnJa9HZkd3Gm9INqJosRRn324JtriaHQ4eeNn8mgRP8O0HWy
	 dgDmPAWC97qHlCeCH2wbqbRXF8deIQFeU2EQ747hHwhvBNAkLw3cGaizXECQr3YrlC
	 Am1/kfVU0URXXjZ5TkyrklUNN/HjZ1I/s3GoPqPvKyrt+Xqjmg4dnxWZBK/OxnvjI6
	 LOlKRehj2haOg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5578844A29
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pThb0bHf;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3ufjmDn;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0ixxF1695495
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5V+tcV8r7h/bBAiPAxg49R
	LDye23rkCQxQjoFzn0eAY=; b=pThb0bHf0CNLv7kdyhTwajN94O2reA4BP1EvsW
	wZwUocvlVT4ncCLqlYHdnYGofD7urzJlmpuLHXzb35c2kr8ybt3w2JK9WF0Ig0XP
	ap4ZyRxAVm4KND0rIOsLCxZ21YYs12sdp1zj/36OB7NMYfoAwlCa+yIYiITB8d9e
	cb/bSV6zyb7GAEYPaFvDQqidpdhSRYGM4/jEKZXybNVoydywL+f18pWXO91n7jUf
	6i5pAjJu8ayPt8Vrht/wsDrTr5e8qGJGxtgLl3lE4M0zKO92MYIq7TfsTigbazIw
	5/Tm4tbxGcKOxp0FpCt7Y001FFMnqZrSflyQG/aQ+8gmi2Vg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mn8gcd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:45 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14318be7d79so165615c88.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 20:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790651865; x=1791256665; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5V+tcV8r7h/bBAiPAxg49RLDye23rkCQxQjoFzn0eAY=;
        b=F3ufjmDnu0s+XUEQ1GpMd5I8JIaKQIsYj2gZKJPA5Svj9akSPLd4FCf1ZDjviRSsno
         UVno9gYhyX+IsCk2cLGfmeIrEUh0XGKg7rrWAH9Nev/tiAoB4HWGRu7A2P63fwxZ+7Vk
         C9hKo10yPYT/e075AdXn45yzx27iKQ3plO/5qqMnx11B2+/30nVCpzO0iY23OFv2Mlbw
         XFAeYFULo10fy93AvdUuwHPBzKdJFcqLag7FxZJnkmMj5Ta4MniudMsKwwDE9oFzKTi/
         Qf2BGBOf3Mip3Rt9L38NXlVkncmFi2jGu85+hZVieVrlztDwS3IDD7wxXhMIE9seBbsb
         P89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651865; x=1791256665;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5V+tcV8r7h/bBAiPAxg49RLDye23rkCQxQjoFzn0eAY=;
        b=Xh0XafpZfDd6xMMZpTGEFJnmceqI/jCVhyUY4q9GphAcMstjII87/rz/qKhOXtQp0/
         phGbRh/3vyHz+3tnZbazKpQDS+Uledgip7m8Q7mVmyuNOg+xS53+2LcKKmSyHOZdwu+a
         oEJYt/YDlIrktRQz0xHm6fr10jApq8sdC3b19iBlbR/cZAJfI7ybRPN3m9Tu9ShuN6wa
         IK+Ff39wrZWuOqrvLi1gD50zHhePj4neRTwD8sexz7csdQNEL8GRnKpig6HVbE0XQNrP
         U2O2Saz5u+GU+3Wb2JPqJaa2w+xdxRWHGnIzA9cREjF7tuxfiRJ1uLdoB/np6tuPcNCF
         PHXA==
X-Forwarded-Encrypted: i=1; AKwUvBxhpWXbUlt7IviYwRDZYyoE+yrghFVpb8QI3FxvHzjAlUjnKU/oN1hkPnAmXKE0R/GtAKHmdBg=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mjUCTKKgIBf35HqZJ9BEOEmnag2xOvw6cZYaOlQ3CpsJFJesfu
	Oe/vzWYf2zt0y614BwSNOgRTfdLKLXWT0Ap4jKQdIXXz2AJshtJfMygBFs2WXcz9nBckHe0N24R
	6xURbju1OBnyGY79UIDEy2Ddisn7LKjtdjyzaLa4cVtC4Ip7h87KvtE6if27JCK19GsXtTaw=
X-Gm-Gg: AYBFou1gjf/TANGCu2Qy3YwQo16QoG5zaTccGOpfxMrfcC6KBw+TARJUmXj66m8xW+8
	svGAc6SjdNWewP9TOZq+60IMDaDNubr2bJzSsY0HgyDth5oGWu/nuk0zhxRJ1RMW9vDKI9lP0KG
	CNc1MpQbOcyOFG/M2/06X64PzO0DEzZZHkeGBxWKRAtg+KksS2i7tAvhxGiBIw3bAe9jG/Amp+4
	g0rRvIjWv4ghtqOXqWudRf2i/mDZk4g7b9EdoKhgIZKLfOcZmbwuGm0l5ybpX4qrGFsx0xo40Sh
	dbymnDEOHslcDUO74nHwEvZoyBg/n32NlIVZMPyvbCsdntDr4UZ1f9qPt8YuZoCwGfnUy19gRIt
	mpKrE2ZFGQGlGy2j6Fk4wZJ1UrUyN3kKJo4terfUMwAM5u/0fUXNFXa8uHcQ=
X-Received: by 2002:a05:701b:2212:b0:149:ef22:2fa2 with SMTP id a92af1059eb24-149ef223168mr4999992c88.8.1790651865149;
        Mon, 28 Sep 2026 20:17:45 -0700 (PDT)
X-Received: by 2002:a05:701b:2212:b0:149:ef22:2fa2 with SMTP id a92af1059eb24-149ef223168mr4999954c88.8.1790651864531;
        Mon, 28 Sep 2026 20:17:44 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm24789368c88.11.2026.09.28.20.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:17:44 -0700 (PDT)
Subject: [PATCH RFC 00/10] firmware: riscv: add RPMI TEE service group
 transport
Date: Mon, 28 Sep 2026 20:16:51 -0700
Message-Id: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-B4-Tracking: v=1; b=H4sIAKMtu2oC/x3MPQqAMAxA4atIZgO1FbGuggdwFYeqUTP4QypFE
 O9ucfyG9x7wJEwequQBocCejz0iSxMYV7cvhDxFg1a6UFaXKOzHgHJujBcRuoGxUIasM0NurIU
 YnkIz3/+0g7apoX/fDzEuc3xpAAAA
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=X9fHu2Te c=1 sm=1 tr=0 ts=6abb2dd9 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=SoDOECYcTc9ExgbA9_YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: nujDWKSLnp3TD1qT57YQ-LP5ghljuxGk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfXwQte2Pt1j8d6
 m7ejYPQMmh+tu0cRB1ELhsxgL+9HkEAEYH4neG/q32Mp/G1+wpz2jSleaW8KZynIeW3GsTaUkQW
 t9UMpGD4MRoml/gTNXQCYkPMkcMi++Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfXy4wHi7R7UO8f
 c2r3aWMg9u7x3BxQkfcW+tHe//nOPuvEX67KLRyC5T3d3jpsRh/95fiL4+DhGeDHQDcsKqCTDrw
 5fnktUdMyUFMMhf52CSk8opwtziHOi1ly9aM/Zwf8ZN6D+uvhtrczptiDmcCi75W8SRstoJIBLa
 VSsWprzaBLE5CgIVuUBKGeSOCYppoOjZPvTQyTH4MjiqE2U/1w7WWx3NZxMYcSElAk7DQdcXFNK
 q40NVkYgQd3C6jWmBB+qHp32Hq3Yiiv2HbS0xfcGp1A7TrpvaV+mrkicahMUS++YjCO34uvFsFo
 iRVsn2Is2m/bpVfA7l9AEXz3kJnwLlWJDigit6LUukQ9Wlpnh3YSzUSP/7ouujxnG88hkkG2g5o
 8otRZCMFJ02lUe1hz1q3C89WboeRUwJXgQ4kIQPyUkjO7d3lrCJbvAYE02r7+Vcr111mHwn2p3h
 o1mEj0HBdFPWuqhLoKA==
X-Proofpoint-ORIG-GUID: nujDWKSLnp3TD1qT57YQ-LP5ghljuxGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5578844A29
X-Spamd-Bar: ----
Message-ID-Hash: AYNN7VQPP4XU2LSEKQK5I6TEQDAMIM3M
X-Message-ID-Hash: AYNN7VQPP4XU2LSEKQK5I6TEQDAMIM3M
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AYNN7VQPP4XU2LSEKQK5I6TEQDAMIM3M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

VGhpcyBSRkMgc2VyaWVzIGFkZHMgdGhlIFJJU0MtViBSUE1JIFRFRSBzZXJ2aWNlIGdyb3VwIHRy
YW5zcG9ydCBbMV0sDQp3aGljaCBwcm92aWRlcyBSSVNDLVYgc3lzdGVtcyBhIG1lY2hhbmlzbSBm
b3IgTGludXggdG8gY29tbXVuaWNhdGUNCndpdGggVEVFIGVuZHBvaW50cy4gTGludXggYW5kIGEg
VEVFIGFjdCBhcyBlbmRwb2ludHMgb2YgdGhlIFJQTUkgVEVFDQpzZXJ2aWNlIGdyb3VwLCB3aGls
ZSB0aGUgUlBNSSBmcmFtZXdvcmsgaW4gbWFjaGluZS1tb2RlIGZpcm13YXJlDQptZWRpYXRlcyBj
b21tdW5pY2F0aW9uIGJldHdlZW4gdGhlbSBvdmVyIGFuIFNCSSBNUFhZIFsyXSBtYWlsYm94DQpj
aGFubmVsLg0KDQpUaGUgc2VyaWVzIGlzIGxheWVyZWQgYXMgZm9sbG93czoNCg0KIC0gVHdvIG1h
aWxib3ggcGF0Y2hlcyBhZGQgYSBkaXJlY3Qgc3luY2hyb25vdXMgc2VuZCBtb2RlDQogICAobWJv
eF9zZW5kX21lc3NhZ2Vfc3luYygpKSBhbmQgaXRzIGltcGxlbWVudGF0aW9uIGZvciBSUE1JIE1Q
WFkNCiAgIGNoYW5uZWxzLCBuZWVkZWQgYmVjYXVzZSBSUE1JIFRFRSByZXF1ZXN0cyBtdXN0IGNv
bXBsZXRlDQogICBzeW5jaHJvbm91c2x5IGluIHRoZSBjYWxsaW5nIGNvbnRleHQuDQoNCiAtIFRo
ZSBSUE1JIFRFRSBidXMgcmVnaXN0ZXJzIG9uZSBkZXZpY2UgcGVyIGRpc2NvdmVyZWQgVEVFIGVu
ZHBvaW50DQogICBhbmQgc2VydmljZSBVVUlEIHBhaXIsIGZvbGxvd2luZyB0aGUgZGV2aWNlLXBl
ci1zZXJ2aWNlIG1vZGVsLA0KICAgc28gaW5kaXZpZHVhbCBzZXJ2aWNlIGRyaXZlcnMgY2FuIGJp
bmQgaW5kZXBlbmRlbnRseS4NCg0KIC0gVGhlIFJQTUkgVEVFIHRyYW5zcG9ydCBjb3JlIGJpbmRz
IHRvIHRoZSBtYWlsYm94IGNoYW5uZWwgYW5kDQogICB2YWxpZGF0ZXMgdGhlIFJQTUkgYW5kIFRF
RSBzZXJ2aWNlLWdyb3VwIHZlcnNpb25zIGJlZm9yZSBhbnkNCiAgIGRpc2NvdmVyeSBvciBzZXJ2
aWNlIHRyYWZmaWMgaXMgYXR0ZW1wdGVkLg0KDQogLSBTeXN0ZW0taW5mb3JtYXRpb24gcGFyc2lu
ZyBhbmQgZGlzY292ZXJ5IHdhbGsgdGhlIGZpcm13YXJlLXByb3ZpZGVkDQogICBkZXNjcmlwdG9y
IHRhYmxlcyB0byBmaW5kIHBoeXNpY2FsIFRFRSBlbmRwb2ludHMgYW5kIHRoZSBzZXJ2aWNlcw0K
ICAgdGhleSBleHBvc2UsIHJlZ2lzdGVyaW5nIGEgYnVzIGRldmljZSBmb3IgZWFjaC4NCg0KIC0g
TWVtb3J5IHBhcmNlbCBvcGVyYXRpb25zIChsZW5kLCBzaGFyZSwgcmVjbGFpbSkgbGV0IGEgY29u
c3VtZXINCiAgIGRyaXZlciBzaGFyZSBtZW1vcnkgd2l0aCBhIFRFRSBlbmRwb2ludC4gTGludXgg
Y3JlYXRlcyBhIHBhcmNlbCBhbmQNCiAgIHRoZSBwYXJjZWwgaWRlbnRpZmllciBpcyB0aGVuIHVz
ZWQgYnkgdGhlIGNvbnN1bWVyJ3Mgb3duIHByb3RvY29sIHRvDQogICByZWZlciB0byB0aGF0IG1l
bW9yeS4NCg0KIC0gU2lnbmFsIGJ1c2VzIGxldCBhIGNvbnN1bWVyIGRyaXZlciBleGNoYW5nZSBh
c3luY2hyb25vdXMNCiAgIG5vdGlmaWNhdGlvbnMgd2l0aCBpdHMgVEVFIGVuZHBvaW50IGluIGJv
dGggZGlyZWN0aW9ucy4NCg0KVGhpcyBzZXJpZXMgb25seSBlc3RhYmxpc2hlcyB0aGUgdHJhbnNw
b3J0LCBidXMsIGFuZCBkaXNjb3ZlcnkgbGF5ZXIuDQpBIGNvbnN1bWVyIGRyaXZlciAtIGFuIE9Q
LVRFRSBiYWNrZW5kIG1hcHBlZCBvbnRvIHRoZXNlIHNlcnZpY2VzLA0KYW5hbG9nb3VzIHRvIGRy
aXZlcnMvdGVlL29wdGVlL2ZmYV9hYmkuYyDigJQgaXMgaW50ZW5kZWQgdG8gZm9sbG93IGluIGEN
CmxhdGVyIHNlcmllcyBvbmNlIHRoaXMgdHJhbnNwb3J0IGlzIHJldmlld2VkLg0KDQpGZWVkYmFj
ayBvbiB0aGUgb3ZlcmFsbCBhcmNoaXRlY3R1cmUsIHRoZSBidXMvZGV2aWNlIG1vZGVsLCBhbmQg
dGhlDQptZW1vcnktcGFyY2VsIGFuZCBzaWduYWwtYnVzIGFic3RyYWN0aW9ucyBpcyBlc3BlY2lh
bGx5IHdlbGNvbWUgYXQNCnRoaXMgc3RhZ2UgaW4gdGhpcyBSRkMgc2VyaWVzLg0KDQpbMV0gaHR0
cHM6Ly9naXRodWIuY29tL3Jpc2N2LW5vbi1pc2EvcmlzY3YtcnBtaS9jb21taXRzL21haW4vc3Jj
L3NydmdycC10ZWUuYWRvYw0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi1ub24taXNhL3Jp
c2N2LXNiaS1kb2MvcmVsZWFzZXMNCg0KU2lnbmVkLW9mZi1ieTogQW1pcnJlemEgWmFycmFiaSA8
YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KLS0tDQpBbWlycmV6YSBaYXJyYWJp
ICgxMCk6DQogICAgICBtYWlsYm94OiBhZGQgZGlyZWN0IHN5bmNocm9ub3VzIHNlbmQgc3VwcG9y
dA0KICAgICAgbWFpbGJveDogbXB4eTogYWRkIGRpcmVjdCBzeW5jaHJvbm91cyBzZW5kDQogICAg
ICBmaXJtd2FyZTogYWRkIFJQTUkgVEVFIGJ1cyBzdXBwb3J0DQogICAgICBkdC1iaW5kaW5nczog
ZmlybXdhcmU6IGFkZCBSSVNDLVYgUlBNSSBURUUgdHJhbnNwb3J0DQogICAgICBmaXJtd2FyZTog
YWRkIFJQTUkgVEVFIHRyYW5zcG9ydCBjb3JlDQogICAgICBmaXJtd2FyZTogcmlzY3Y6IHJwbWkt
dGVlOiBwYXJzZSBzeXN0ZW0gaW5mb3JtYXRpb24gdGFibGVzDQogICAgICBmaXJtd2FyZTogcmlz
Y3Y6IHJwbWktdGVlOiBkaXNjb3ZlciBURUUgc2VydmljZXMNCiAgICAgIGZpcm13YXJlOiByaXNj
djogcnBtaS10ZWU6IGNhY2hlIFRFRSBjYXBhYmlsaXRpZXMNCiAgICAgIGZpcm13YXJlOiByaXNj
djogcnBtaS10ZWU6IGFkZCBtZW1vcnkgcGFyY2VsIG9wZXJhdGlvbnMNCiAgICAgIGZpcm13YXJl
OiByaXNjdjogcnBtaS10ZWU6IGFkZCBzaWduYWwgYnVzIHN1cHBvcnQNCg0KIC4uLi9iaW5kaW5n
cy9maXJtd2FyZS9yaXNjdixycG1pLXRlZS55YW1sICAgICAgICAgIHwgICAzNSArDQogZHJpdmVy
cy9maXJtd2FyZS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAyICsNCiBk
cml2ZXJzL2Zpcm13YXJlL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEg
Kw0KIGRyaXZlcnMvZmlybXdhcmUvcmlzY3ZfcnBtaV90ZWUvS2NvbmZpZyAgICAgICAgICAgIHwg
ICAgOCArDQogZHJpdmVycy9maXJtd2FyZS9yaXNjdl9ycG1pX3RlZS9NYWtlZmlsZSAgICAgICAg
ICAgfCAgICA4ICsNCiBkcml2ZXJzL2Zpcm13YXJlL3Jpc2N2X3JwbWlfdGVlL2J1cy5jICAgICAg
ICAgICAgICB8ICAyMDIgKysrDQogZHJpdmVycy9maXJtd2FyZS9yaXNjdl9ycG1pX3RlZS9kcml2
ZXIuYyAgICAgICAgICAgfCAxODE2ICsrKysrKysrKysrKysrKysrKysrDQogZHJpdmVycy9maXJt
d2FyZS9yaXNjdl9ycG1pX3RlZS9zeXNpbmZvLmMgICAgICAgICAgfCAgMzg1ICsrKysrDQogZHJp
dmVycy9maXJtd2FyZS9yaXNjdl9ycG1pX3RlZS9zeXNpbmZvLmggICAgICAgICAgfCAgMjQ0ICsr
Kw0KIGRyaXZlcnMvbWFpbGJveC9tYWlsYm94LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA3MiArLQ0KIGRyaXZlcnMvbWFpbGJveC9yaXNjdi1zYmktbXB4eS1tYm94LmMgICAgICAgICAg
ICAgIHwgIDE5NiArKy0NCiBpbmNsdWRlL2xpbnV4L21haWxib3gvcmlzY3YtcnBtaS1tZXNzYWdl
LmggICAgICAgICB8ICAgMTMgKw0KIGluY2x1ZGUvbGludXgvbWFpbGJveF9jbGllbnQuaCAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMyArDQogaW5jbHVkZS9saW51eC9tYWlsYm94X2NvbnRyb2xs
ZXIuaCAgICAgICAgICAgICAgICAgfCAgIDEwICsNCiBpbmNsdWRlL2xpbnV4L3JwbWlfdGVlLmgg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNzUgKysNCiAxNSBmaWxlcyBjaGFuZ2VkLCAz
MDk4IGluc2VydGlvbnMoKyksIDcyIGRlbGV0aW9ucygtKQ0KLS0tDQpiYXNlLWNvbW1pdDogNjM3
NWU2MWMwMWU5M2UzNWVlN2FjZDMzNmE2ODlhYzFmYWU0YjUwOQ0KY2hhbmdlLWlkOiAyMDI2MDky
OC1yaXNjdi1ycG1pLXRlZS1hYmktNjAzZTlhM2I0Mzk5DQoNCkJlc3QgcmVnYXJkcywNCi0tIA0K
QW1pcnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KDQo=
