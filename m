Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82572CCA462
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 10:13:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 99AFD4505C
	for <op-tee@archiver.kernel.org>; Fri, 16 Oct 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792145591;
	bh=vCOnydFBleVY04Xa5tyb5PBjYyo8nVoY1zJIA7yxdBI=;
	h=Date:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=FqdEkjUTxy413zITQscHK8eF4dCxwc7JP91sRLigbxQc/EkKs9fhFk/9Lt+jUE+m1
	 1CH8BBE9nd+hdI5DTM+SwHuu0IpR0OMyTZ/0io65Tc/tLifae5ICjmzSQ0R52FQjUE
	 Oa4+UG+ErY655g5JrR4tB7ij41PyVL4leKiKm2c0M/JOzmCyD9Hsw3NO7ZFRE20UVL
	 8ss7/bbFicgrGyJvFP2dm+9+M7uSlpQTgSSnwajd5UvvPExKcqx9DDCe/HNInPMbpw
	 7cAjl/OqcjyU37sKYtYrugZzq+ucOymJjKvkGEcv52VNAmG7XT4q6H/vAtAlrSWymO
	 EouE3zA4/QlQA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8BA9E4505C
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 10:12:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KnYuYS4k;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DxeYaF7x;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAAS32403079
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 10:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oigbKCK2cN3f+OfxOoo+Ej
	gGvHbpeNmvbjqXkRAqvyY=; b=KnYuYS4kMvUl8a9+reXFYL/2UXKorfFE0OV2q4
	UGRnL7nJizRigsm2nwAdYazFv2Laxrbzjxm7b1AXK8yu24dfcyjX7Jf6nYYCIpnM
	aBr8FoT+5al4imkTg9ru2n+lyvCEy/ZWBHzC31nAaS1hm0ZZISSuSVTDIm/61q8U
	H8j+Nxr7jp08n6smMYfX/axO+Sp+9TyoOFknUB+XRevB+yqSNl4jd4hVmCFc7K2F
	kefBCWeas+lFFrFt40hMm+XOWIwCoqVYRQRhvQ7lzcRLmlINzDiq1rBqZmMDMx1l
	/zZRfRT4b+2tLtOp3fp8FsbBxgVTw342uZjUfW4oWMzH27cg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m3xjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 10:12:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93dd3c3badbso526146085a.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Oct 2026 03:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792145560; x=1792750360; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oigbKCK2cN3f+OfxOoo+EjgGvHbpeNmvbjqXkRAqvyY=;
        b=DxeYaF7xVum5wCNAZDhgU5RN5M+Ch/R+/awI6DHMlEAyfjqj03vvb4vGEIBk4RtISq
         w0DbKlFXkNQmVjDJEvjEL0pQh779MZ9yDWmaddicS8Pj4DJMSyP3oxzq7c+EgB+uOYii
         2IPV22kEv6nVYuNq7PaNVZrxiLszKRj7VxGHXqd+/6MEhSwoPkg6DcBHBrbYalHgXj+1
         D/5d91AUbNfiSXi/YEAuD9RasB4yys4r1+J3q6pmOt88F4pkFt4KwjDM6sfRP9v9p4fG
         vG/3KvVVjBzB2kg6V144aHNREGByhGi5GZKfInJ4sGp4/f4vkzih1kYTh7RMAXrc3fVv
         moQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792145560; x=1792750360;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oigbKCK2cN3f+OfxOoo+EjgGvHbpeNmvbjqXkRAqvyY=;
        b=tgidEhO5wABBena1cFf3Ix7XLui/rIj5HuGbA8T6TlEK21wcyfn0maXLHuryLtfk2a
         uNiUTonAB19ylz1cYGVCiFlVbwGOZs1FJF6xMQkiLxi/XUlIAmYzmdOeyxIuovCaoCs9
         JVuzhpitiiyhA8jI1KTlDOT9CA66n3q9zkYVWCz2svQfwyVHcn3PK4ptAU9J+e9rJx7I
         DqLLLB01imo5mAeEYGdwCdDr09T9nUtD4o3buu0HmoJGyPrl/cEF8UnASDPRFLw6Hpha
         7P625viUtBcvwE00xPRHrrHvFyu1cW1zlWGhw4rVoLGGtdO+rgABq3/2jUx4i3K73ewc
         MRPQ==
X-Gm-Message-State: AFq9FYKAW/5l94yT8qFZyI5yRXvdt+58idt6yL2vXSOj/LC6YLQLsGCr
	sFVcspFqVysmxNRi5RQoDEi+228DUqP2ATfqr0yMt3MxczPoxxYGnGoS0JtY5ge97nzA4h8fxx0
	LUJFnGKuMJTWcpE198JwAtZe8zb1SSO0Op1WPxNfA2HsYQmYRiYwdGzUJFQaStHHUlI0r4c1Ssn
	lzAICNUyW5gg==
X-Gm-Gg: AYBFou3xuO8Io3jCFJBT3bWMv1SC5ndFgUaz3eOhoewemy+W1kq/rGcvw1WJ8vjgA2C
	lk1GQ9LTuIM1Px9grBVSlz05fg6rlrfyVczDJsH5NydOZ0d0P29pTh+f2YcAcsa0SKwJChL7VGi
	HYSIrxsttL+49gYFiWqNCom3+SuBm6oQjdSuGVL6yX58V3YQ2PqDlsGEUf2695WqBRkpSr2BLgC
	gWd6i9sTnhHWkoQtg4kucDJck0foOSUihIYi3nX2Ckl1LU0Mz3RdudGePnVG1OWISYu0ii3/R03
	URxZAGsdaJDqKFMiCnIVumI5hrqpNaAsAyep4E/UIY6QjybsJx9UYJ/H1FiLaPLkWlqzp3Xbf1y
	gwG1togzN5WuoOaldOkIT8ucnNsu56X8xj1vOSaEojIaWMg==
X-Received: by 2002:a05:620a:1a0e:b0:93f:24c5:f561 with SMTP id af79cd13be357-93f24c5f677mr29711685a.33.1792145560294;
        Fri, 16 Oct 2026 03:12:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0e:b0:93f:24c5:f561 with SMTP id af79cd13be357-93f24c5f677mr29704285a.33.1792145559654;
        Fri, 16 Oct 2026 03:12:39 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e3284e3sm58882866b.3.2026.10.16.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:12:38 -0700 (PDT)
Date: Fri, 16 Oct 2026 12:12:34 +0200
To: op-tee@lists.trustedfirmware.org
Subject: OP-TEE 4.11.0 has been released
Message-ID: <20261016101234.GA2199714@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad1f899 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=dChbvKt_AAAA:20 a=NEAV23lmAAAA:8 a=2NXTqBcqebq6YD25v6sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: ZhyERZmagFAiDd10yISNf3hge5s8rOHl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0MCBTYWx0ZWRfXwRFNgdTJeBxg
 BYjpICxdD88GiP6YzcYqWTG+AMmsqRXrcwP+Dxtnw83byueUUqOH6m6kafPSLVTNt8iJ57J5jY5
 eb51+o09Xr+UL409hDTYftNF8OLV2fY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0MCBTYWx0ZWRfX/4vRL2MmB0xk
 rDDTqcESqjyZw+ODCq2FV2h7BtIaZl0+LhgP0KcRZIJjW1gzLi6QNf57oAhQFpe2Ig8qnMhpdZa
 IHwFsftdtOhbqr9uz1GtSob9tr8eTG6qHiM/zjK6KykHmK5i7otgM2fOs1Il1Wkc2+v+0VhfoFM
 yeBcdlLIQgiZWoVNU4CGaTr81leREsT3odgLmRRlTJ3KLXU2wEtgN43UlZIhCR6VJHDQfF5GGVE
 4qLbdjw6nLs9Em7h6GeKXGMVH/LDo42Xmvqe0kaMLY8mN//IhFvdy3I+XPfWWV6sk+qjTQWCFgM
 1+H0N9ZJNkDuob4SYAktwCeG7ba/tH62KA4xwLXVH+OK4KaGJI0zF17v/Zp8TxiL/A5neZP2aFh
 84ioZOHILUupoYFZlLldoblKaM9qAgocPE9wuHIwLfd3MECKsSObk81W5PGfTTyWNghxaLE84Ju
 ntAW2w9Sd+ZM8YPpPag==
X-Proofpoint-GUID: ZhyERZmagFAiDd10yISNf3hge5s8rOHl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160040
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.49 / 15.00];
	BAYES_HAM(-2.99)[99.94%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.198:received];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8BA9E4505C
X-Spamd-Bar: ---
Message-ID-Hash: 2TFK3VHRSQME4YSIB5CY3GSHWLJ4EK7M
X-Message-ID-Hash: 2TFK3VHRSQME4YSIB5CY3GSHWLJ4EK7M
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2TFK3VHRSQME4YSIB5CY3GSHWLJ4EK7M/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

SGksDQoNCkknbSBwbGVhc2VkIHRvIGFubm91bmNlIHRoYXQgT1AtVEVFIHZlcnNpb24gNC4xMS4w
IGlzIG5vdyBhdmFpbGFibGUuDQoNClRoZSBsaXN0IG9mIGNoYW5nZXMgY2FuIGJlIGZvdW5kIGlu
IHRoZSBjaGFuZ2Vsb2cgWzFdLg0KDQpJdCBoYXMgYmVlbiBzaXggbW9udGhzIHNpbmNlIHRoZSBw
cmV2aW91cyByZWxlYXNlLCB3aGljaCBpcyBsb25nZXIgdGhhbg0KdXN1YWwuIFdlIG5vcm1hbGx5
IHJlbGVhc2UgZXZlcnkgdGhyZWUgbW9udGhzLCBhbmQgd2XigJlyZSBub3cgcmVzdW1pbmcNCm91
ciByZWd1bGFyIGNhZGVuY2UuDQoNCkEgYmlnIHRoYW5rIHlvdSB0byBldmVyeW9uZSB3aG8gcGFy
dGljaXBhdGVkIHdpdGggY29udHJpYnV0aW9ucyBhbmQNCmhlbHBpbmcgb3V0IHdpdGggdGVzdGlu
ZyB0aGUgcmVsZWFzZSBbMl0uDQoNClsxXSBodHRwczovL2dpdGh1Yi5jb20vT1AtVEVFL29wdGVl
X29zL2Jsb2IvNC4xMS4wL0NIQU5HRUxPRy5tZA0KWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9PUC1U
RUUvb3B0ZWVfb3MvY29tbWl0L2Y1NDE5MGYyMjYxMWRkNWFkNWQyMjU0NmZkNDIwOWFhMTAwZjU2
YmQNCg0KUmVnYXJkcywNCkplbnMNCg==
