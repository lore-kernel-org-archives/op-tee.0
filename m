Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CA4C88E72
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 19:19:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 19F6345221
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789672774;
	bh=Qfv+ISci+j0iSjxFd5/eHpVt1CP2Ff5iUjNsR9Gqswk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=EumKoACcyjNziZN2fHfHfdqswSHZwl3GRP2lVGQf6gdBgYZC0D4KZy8my6RzUvzd6
	 Y1uHGZeAVn3tGeGqVXHzwEY4kkci0qcJbl8y6v+VUfqmMx21hdPm+7Pw/aaYmRmL/d
	 SSpLsDxkM+JHVzO5otkQ9jPwA+nUgPA0MLP2byXMGof9+529bg1Q/tIcu8Hb3ylUZa
	 3vKZKKfWtpmKT7jrm5pZMKxDimp+kK/ygGIYwFqShymXaVESF3cLjPtzg9BouH7sur
	 GxBeZpDKptJT3tYZda6NjVmDH6uNgYb/335vdFSfMNlR7fuDgXM3LVCal0ft4mAofY
	 CAIzH3NHrGNzA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0FD49443EB
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 19:19:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gg1dBU/U;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PVi6NvG7;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHhpEx1683043
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 19:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QuxVL5v35fCI4IDOIYjgw6aBb4lWvxLcOgjhSBm3cvQ=; b=Gg1dBU/UgIrQlyOk
	RB7mM6wl7+MRMoiyeZHFRhxqOHR4lVd3MH993bH4jjs5sP1iBLaO/H4lFbl6++WK
	JROglw1qFdhG597l18dJ1sKBwkIqLCRyvtuhk50AacgjuG9yT+0VRjYF8TwKFii8
	3Ty5qgOpRnDyUgQbwAm9t1m8lYoJESsFSWBZP85LM2fYfvJ9Ymxni31qlH/Y0nsQ
	qaUgDazSh1ioO1KNct6Vk0Fl2Sl7Z2eXsVq28OPr6yozaAgpszIpxGhgryw1TTZ8
	TQy17VblJH69UrKVeHrvVpcmIGjcvnr949TsF2f538kj0zEoveAG4I4YhYBjcSml
	voNgmw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grmv5ge7y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 19:19:25 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso67802a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789672765; x=1790277565; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QuxVL5v35fCI4IDOIYjgw6aBb4lWvxLcOgjhSBm3cvQ=;
        b=PVi6NvG7u5TLNUtrFnfjmtY9sPmKXFnHtUlUhZmUnEbqHcL1tZJSNAJT71YjuWd+b4
         KFjYp8WwOxkK3jcNpewq9McuijJkwRuPbjP8LjrIRJav/yyWsSql6jKnTx2ggbjcwMtK
         cKKpJPgNOJ9/1ZzSlg3JATXNNtx9+4IyrI/gfnEYvMboJ2XsPFe7NLx8sYnk4eTmWIGl
         E2BeKYR4uyyitJsKW63aADC5M4FO18HWvQ/hLjFERbViV7a/c4yEoH0E1Rj1UrtiO9Lv
         eN+qojaBIeiBvTP6gUsC6LdJd4VTp5KlDkxdB2+SsE3NXpzHUTMvQl250n0M6b6xLTuf
         T71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672765; x=1790277565;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QuxVL5v35fCI4IDOIYjgw6aBb4lWvxLcOgjhSBm3cvQ=;
        b=nNMkum0DMWc6lsdTOqX20vFi0XSHTrcvL4XJJYLnF4Jsfq1v2bwA7MT3BhWoJHts5y
         SS9LKAfqKPRxurIxpD+Oit1p7GeUQhirOE3w4HJC3Pm1ADs5METwG3OO5VLnJgs4TEmN
         yN7n2o/BZC1gcmBngIOVtfbbMijL+te8/52kpzPMFTvbLgpv/F7MVXMsx+yiWwWA3prj
         AiMCdZwie30c/WU7oXLQiZPeOvYnc1TCtzX01GZG+UnvNwYOz6yXhyq+c8/9f8vzg+pX
         a3Sh3OzOM0RlprZ/TEXzB2CVwSpEp4CvXRD1AfQkRHXIbu1hHsSr2onH2U7G0NXujom3
         UE2w==
X-Forwarded-Encrypted: i=1; AKwUvBxC6cxxZXPeKMWDJEQCRMJnfGlnx+MM1aQo4+0MqbhLS17GFhoSHPzA4PjqZu9DUxOZ5cCW2rs=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lpVtO6ura4ji6lo7ar4y21IP4wz5NwoCb3vo3HONkX/le32uV3
	2sZnjXypHudDaT1vwufFfH342aMPhgVD1Z4QRuWP9GtSvmGHLDJHtFb/nJ9LBxiHvrkK8duRivZ
	LA9dPUWecHHpKizEyM+jxP0s96NthIM9xLtOMz4ZH16kTI1zMX5veb0gqwioIKt3n6WnCA+E=
X-Gm-Gg: AYBFou10yDDQgGB7aN1JcVJO+5hcxREWPkXA4z732jN2PxXHw8p7+osOlD38f6IxK5t
	ZqVgf81gJSvQI8thhAdv4qC76G9iBIKm9G9R5BWnry3oP8Yg0508ifLLDar2tFNKQYL3wDHaNJW
	i4weDNdY4XVcdY0ht37V1WMOGpFXqQjlVL6YCqxsZAoQEQV88e5334LzVYYRv7Wy3YWsBq9xcyk
	o37cVpXQyx9ko+o5V4VsRlneQkGcppsCx7KGwam20Mud1krxgVNdWshYaNiOHW4+IDFu5ThlJxp
	TsINp6JlYu5gBt2lHfmPXFivKWC7oskDp8kU154hcTqWNXXF7wClal2etAkBnerBdQTk/FfhenO
	jJoi+MfrhGe+eU18uGw6Xzr90gRQIWoaX
X-Received: by 2002:a17:90b:4484:b0:39d:f97c:bb2f with SMTP id 98e67ed59e1d1-39e54b66cf5mr429895a91.3.1789672764595;
        Thu, 17 Sep 2026 12:19:24 -0700 (PDT)
X-Received: by 2002:a17:90b:4484:b0:39d:f97c:bb2f with SMTP id 98e67ed59e1d1-39e54b66cf5mr429836a91.3.1789672764046;
        Thu, 17 Sep 2026 12:19:24 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.114.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e5547a04dsm40272a91.3.2026.09.17.12.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 12:19:22 -0700 (PDT)
Message-ID: <4da526fc-f763-4f8b-8b33-362177aec889@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 05:19:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/5] dt-bindings: tee: add RISC-V RPMI TEE transport
To: Anup Patel <anup@brainfault.org>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
 <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
 <CAAhSdy3Or_uDWuQniUGguc9AwL8smF6XHhJ0kizFOJKJ0N+9OA@mail.gmail.com>
 <d7ba3e45-84fa-409d-bd43-23caa05587de@oss.qualcomm.com>
 <CAAhSdy1F1rASWA2Xht_LQF6ixBu1oQDBtdkW2YTiqVDqLczPsg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAAhSdy1F1rASWA2Xht_LQF6ixBu1oQDBtdkW2YTiqVDqLczPsg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3NyBTYWx0ZWRfXzS4cioIt8Tw4
 U1PtIkWDbgcnTWPmvOH3/C2UtSKz5sdh3mxdDb1fkizPztq7dvh0wpAqMErki7JKYa+CW9lDNgw
 NP9GbRvBx/kxiMXH5vB0jih6+Z+zTt2stz4xE1iMxMS7dXetMLMS2efqBqIWSWJjZkSdnCF5m4r
 K4XutO1YSMFW/bQaBX3flCRPAowzJE54H30MBcv+chPpA6vjZSpar9JxB36+ttllebK1n7hSlUV
 bl8DRChUvPxcxYp2+Qx+bAGKPaxhOCOVGq3LWV2pZGPCIF50wcHEsv7rJ7/X+C8deq8WG78o8oW
 9pZwi/94++E+eMDhkhy1KRJhLFOtGecq658CZJSfiTsG5hBdyP1lqpeAA0up3VzKgpHLuzSzcmH
 ccWJswCS8tkDcL+7FGxx/zLs/R9pI1sqtLy3gHAiFTkmg+oglc69G1NZ06kmx0W9u1ZJa4PzifJ
 vaKSwxB6gZUjVooT43g==
X-Authority-Analysis: v=2.4 cv=E+5YNqdl c=1 sm=1 tr=0 ts=6aac3d3d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Sf69FToG0YAVI/MxTdzZwA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=hNa552Fws9iX_tKzEZsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: n3MzgAKX-oLVcx9weKu8aj0UMqlxVNEK
X-Proofpoint-GUID: n3MzgAKX-oLVcx9weKu8aj0UMqlxVNEK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3NyBTYWx0ZWRfX6qOMZ2syoDk9
 051OFi51yFFyd9Eqy9AyRxoX6XVntyw6rmIU1UVWnsNkUDTJ90BJrKoTmRWADCy7VVqZw2Tb6R6
 0Av+kGQdBAeCfuHnHKOJLO9WeAC7bYw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170277
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
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0FD49443EB
X-Spamd-Bar: ----
Message-ID-Hash: PXQJG4HN77MK72T26TEQP44XPAOVTXF4
X-Message-ID-Hash: PXQJG4HN77MK72T26TEQP44XPAOVTXF4
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PXQJG4HN77MK72T26TEQP44XPAOVTXF4/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgQW51cCwNCg0KT24gOS8xNy8yMDI2IDY6MzggUE0sIEFudXAgUGF0ZWwgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDE3LCAyMDI2IGF0IDI6NDbigK9BTSBBbWlycmV6YSBaYXJyYWJpDQo+IDxhbWly
cmV6YS56YXJyYWJpQG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOg0KPj4NCj4+IEhpIEFudXAsDQo+
Pg0KPj4gT24gOS8xNi8yMDI2IDg6MTIgUE0sIEFudXAgUGF0ZWwgd3JvdGU6DQo+Pj4gT24gU2F0
LCBTZXAgMTIsIDIwMjYgYXQgMzo0NeKAr1BNIEFtaXJyZXphIFphcnJhYmkNCj4+PiA8YW1pcnJl
emEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCj4+Pj4NCj4+Pj4gQWRkIGEgZGV2
aWNlLXRyZWUgYmluZGluZyBmb3IgdGhlIE9QLVRFRSBSSVNDLVYgdHJhbnNwb3J0IHVzaW5nIHRo
ZSBSUE1JDQo+Pj4+IFRFRSBzZXJ2aWNlIGdyb3VwIG92ZXIgU0JJIE1QWFkuDQo+Pj4+DQo+Pj4+
IERlc2NyaWJlIG9uZSBtYWlsYm94IGNoYW5uZWwgcGVyIGhhcnQgYW5kIGFuIG9wdGlvbmFsIGlu
dGVycnVwdCB1c2VkIGFzDQo+Pj4+IHRoZSBhdmFpbGFiaWxpdHkgZG9vcmJlbGwgZm9yIGFzeW5j
aHJvbm91cyBub3RpZmljYXRpb25zLg0KPj4+Pg0KPj4+PiBBZGQgdGhlIGJpbmRpbmcgdG8gdGhl
IGV4aXN0aW5nIE9QLVRFRSBNQUlOVEFJTkVSUyBlbnRyeS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogQW1pcnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gIC4uLi9iaW5kaW5ncy90ZWUvcmlzY3YscnBtaS1tcHh5LXRlZS55
YW1sICAgICAgICAgIHwgNjUgKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+Pj4+ICAy
IGZpbGVzIGNoYW5nZWQsIDY2IGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90ZWUvcmlzY3YscnBtaS1tcHh5LXRl
ZS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RlZS9yaXNjdixycG1p
LW1weHktdGVlLnlhbWwNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4gaW5kZXggMDAw
MDAwMDAwMDAwLi44ZjZmZjMxM2ZkNDINCj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+PiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGVlL3Jpc2N2LHJwbWktbXB4eS10ZWUu
eWFtbA0KPj4+PiBAQCAtMCwwICsxLDY1IEBADQo+Pj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+Pj4gKyMgQ29weXJpZ2h0IChj
KSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJpZXMuDQo+
Pj4+ICslWUFNTCAxLjINCj4+Pj4gKy0tLQ0KPj4+PiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5v
cmcvc2NoZW1hcy90ZWUvcmlzY3YscnBtaS1tcHh5LXRlZS55YW1sIw0KPj4+PiArJHNjaGVtYTog
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+Pj4+ICsNCj4+
Pj4gK3RpdGxlOiBSSVNDLVYgUlBNSSBURUUgc2VydmljZSBncm91cCBiYXNlZCBtZXNzYWdlIHBy
b3h5DQo+Pj4+ICsNCj4+Pj4gK21haW50YWluZXJzOg0KPj4+PiArICAtIEFtaXJyZXphIFphcnJh
YmkgPGFtaXJyZXphLnphcnJhYmlAb3NzLnF1YWxjb21tLmNvbT4NCj4+Pj4gKw0KPj4+PiArZGVz
Y3JpcHRpb246IHwNCj4+Pj4gKyAgVGhlIFJJU0MtViBQbGF0Zm9ybSBNYW5hZ2VtZW50IEludGVy
ZmFjZSAoUlBNSSkgWzFdIGRlZmluZXMgYSBtZXNzYWdpbmcNCj4+Pj4gKyAgcHJvdG9jb2wgd2hp
Y2ggaXMgbW9kdWxhciBhbmQgZXh0ZW5zaWJsZS4gVGhlIHN1cGVydmlzb3Igc29mdHdhcmUgY2Fu
DQo+Pj4+ICsgIHNlbmQvcmVjZWl2ZSBSUE1JIG1lc3NhZ2VzIHZpYSB0aGUgU0JJIE1QWFkgZXh0
ZW5zaW9uIFsyXSBvciBzb21lIGRlZGljYXRlZA0KPj4+PiArICBzdXBlcnZpc29yLW1vZGUgUlBN
SSB0cmFuc3BvcnQuDQo+Pj4+ICsNCj4+Pj4gKyAgVGhlIFJQTUkgc3BlY2lmaWNhdGlvbiBbMV0g
ZGVmaW5lcyBhIFRFRSBzZXJ2aWNlIGdyb3VwIHdoaWNoIGlzIHRoZSBSSVNDLVYNCj4+Pj4gKyAg
YW5hbG9nIG9mIEFybSBGRi1BOiBPUC1URUUgYW5kIHRoZSByaWNoIGV4ZWN1dGlvbiBlbnZpcm9u
bWVudCAoUkVFLCBpLmUuDQo+Pj4+ICsgIExpbnV4KSBhcmUgcGVlciBlbmRwb2ludHMgYW5kIHRo
ZSBSUE1JIGZyYW1ld29yayAobWFjaGluZSBtb2RlIGZpcm13YXJlKQ0KPj4+PiArICBtZWRpYXRl
cyBldmVyeSBtZXNzYWdlLiBFbnRlcmluZyBPUC1URUUgb24gYSBoYXJ0IHJ1bnMgaXQgb24gdGhh
dCBoYXJ0IHVudGlsDQo+Pj4+ICsgIGl0IHJlc3BvbmRzLCBzbyB0aGUgU0JJIGltcGxlbWVudGF0
aW9uIHByb3ZpZGVzIG9uZSBTQkkgTVBYWSBjaGFubmVsIHBlcg0KPj4+PiArICBoYXJ0OyBhbGwg
b2YgdGhlbSBhcmUgbGlzdGVkLCBpbiBoYXJ0IG9yZGVyLCBvbiBhIHNpbmdsZSBub2RlLg0KPj4+
PiArDQo+Pj4+ICsgID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
Cj4+Pj4gKyAgUmVmZXJlbmNlcw0KPj4+PiArICA9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09DQo+Pj4+ICsNCj4+Pj4gKyAgWzFdIFJJU0MtViBQbGF0Zm9ybSBNYW5h
Z2VtZW50IEludGVyZmFjZSAoUlBNSSkgdjEuMCAob3IgaGlnaGVyKQ0KPj4+PiArICAgICAgaHR0
cHM6Ly9naXRodWIuY29tL3Jpc2N2LW5vbi1pc2EvcmlzY3YtcnBtaS9yZWxlYXNlcw0KPj4+PiAr
DQo+Pj4+ICsgIFsyXSBSSVNDLVYgU3VwZXJ2aXNvciBCaW5hcnkgSW50ZXJmYWNlIChTQkkpIHYz
LjAgKG9yIGhpZ2hlcikNCj4+Pj4gKyAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9yaXNjdi1ub24t
aXNhL3Jpc2N2LXNiaS1kb2MvcmVsZWFzZXMNCj4+Pj4gKw0KPj4+PiArcHJvcGVydGllczoNCj4+
Pj4gKyAgY29tcGF0aWJsZToNCj4+Pj4gKyAgICBjb25zdDogcmlzY3YscnBtaS1tcHh5LXRlZQ0K
Pj4+PiArDQo+Pj4+ICsgIG1ib3hlczoNCj4+Pj4gKyAgICBtaW5JdGVtczogMQ0KPj4+PiArICAg
IGRlc2NyaXB0aW9uOg0KPj4+PiArICAgICAgT25lIFNCSSBNUFhZIGNoYW5uZWwgaW1wbGVtZW50
aW5nIHRoZSBSUE1JIFRFRSBzZXJ2aWNlIGdyb3VwIHBlciBoYXJ0LA0KPj4+PiArICAgICAgbGlz
dGVkIGluIHRoZSBzYW1lIG9yZGVyIGFzIHRoZSBDUFUgbm9kZXMuDQo+Pj4NCj4+PiBJIGFtIG5v
dCBzdXJlIHdoeSB5b3UgbmVlZCBzZXBhcmF0ZSBNUFhZIGNoYW5uZWwgcGVyIGhhcnQuIFRoZSBN
UFhZIHNoYXJlZA0KPj4+IG1lbW9yeSBpcyBhbHJlYWR5IHBlci1oYXJ0IHdoZXJlYXMgdGhlIE1Q
WFkgY2hhbm5lbCB3aWxsIGJlIGRvbWFuIHNwZWNpZmljDQo+Pj4gZm9yIFRFRS4NCj4+DQo+PiBU
cnVlLiBNeSByZWFzb25pbmcgd2FzIHRoYXQgVEVFX0NBTEwsIGFzIEkgdW5kZXJzdGFuZCBpdCwg
aXMgZXhwZWN0ZWQgdG8gZXhlY3V0ZSBvbg0KPj4gdGhlIHNhbWUgaGFydCB0aGF0IGlzc3VlZCBp
dC4gR2l2ZW4gdGhhdCwgdGhlIG1haWxib3ggY29yZSBob2xkcyB0aGUgcGVyLWNoYW5uZWwgc3Bp
bmxvY2sNCj4+IGFjcm9zcyB0aGUgY2FsbCB0byBgc2VuZF9kYXRhKClgLCB3aGlsZSB0aGUgdW5k
ZXJseWluZyBgc2JpX2VjYWxsKClgIGlzIHN5bmNocm9ub3VzDQo+PiBhbmQgZG9lcyBub3QgcmV0
dXJuIHVudGlsIHRoZSBURUUgY2FsbCBjb21wbGV0ZXMuDQo+Pg0KPj4gU28sIGlmIHR3byBoYXJ0
cyBzaGFyZWQgdGhlIHNhbWUgY2hhbm5lbCwgYSBoYXJ0IGV4ZWN1dGluZyBhIGxvbmctcnVubmlu
ZyBURUUgb3BlcmF0aW9uDQo+PiB3b3VsZCBob2xkIHRoYXQgY2hhbm5lbCdzIGxvY2sgZm9yIHRo
ZSBkdXJhdGlvbiBvZiB0aGUgY2FsbCwgYW5kIGFub3RoZXIgaGFydA0KPj4gdHJ5aW5nIHRvIGVu
cXVldWUgb24gdGhlIHNhbWUgY2hhbm5lbCB3b3VsZCBzcGluIHdhaXRpbmcgZm9yIGl0Lg0KPj4N
Cj4+IFVzaW5nIHBlci1oYXJ0IGNoYW5uZWxzIGF2b2lkcyB0aGF0IGNyb3NzLWhhcnQgY29udGVu
dGlvbi4gSSBhZ3JlZSB0aGF0IHRoaXMgbWF5DQo+PiBub3QgYmUgdGhlIHJpZ2h0IGxheWVyIGlu
IHdoaWNoIHRvIGFkZHJlc3MgdGhlIGlzc3VlLiBJIGRpZCBub3QgcHVsbCBpdCB0byB0aGUgZGlz
Y3Vzc2lvbiBpbiB0byB0aGlzIFJGQy4NCj4+IEknbSBoYXBweSB0byB1c2Ugc2luZ2xlIGNoYW5u
ZWwgZm9yIG5vdyBhbmQgZm9sbG93IHVwIG9uIGl0IHNlcGFyYXRlbHkgaWYgdXNlZnVsLg0KPiAN
Cj4gVGhlIHBlci1jaGFubmVsIHNwaW5sb2NrIHNlcmlhbGl6YXRpb24gaXMgbm90IHJlcXVpcmVk
IGZvciBTQkkgTVBYWSBiYXNlZA0KPiBtYWlsYm94IGNoYW5uZWxzIGJlY2F1c2UgdGhlIHVuZGVy
bHlpbmcgU0JJIGltcGxlbWVudGF0aW9uIHdpbGwgdGFrZSBjYXJlDQo+IG9mIHRoZSBzZXJpYWxp
emF0aW9uIHdoZXJlIHJlcXVpcmVkLg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIHdlIG5lZWQgdG8g
aW1wcm92ZSB0aGUgTGludXggbWFpbGJveCBmcmFtZXdvcmsgdG8gYWxsb3cNCj4gU0JJIE1QWFkg
bWFpbGJveCBjb250cm9sbGVyIHRlbGwgTGludXggbWFpbGJveCBmcmFtZXdvcmsgdG8gbm90IHVz
ZQ0KPiBwZXItY2hhbm5lbCBzcGlubG9jayBiYXNlZCBzZXJpYWxpemF0aW9uLg0KPiANCj4gT25l
IHBvc3NpYmxlIGFwcHJvYWNoIHRvIGVuaGFuY2UgTGludXggbWFpbGJveCBmcmFtZXdvcmsgaXMg
c2hvdw0KPiBiZWxvdy4gTWF5IGJlIGluY2x1ZGUgdGhpcyAob3Igc29tZSBvdGhlciBhcHByb2Fj
aCkgYXMgYSBzZXBhcmF0ZQ0KPiBwYXRjaCBpbiB5b3VyIHNlcmllcyA/DQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tYWlsYm94L21haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tYWlsYm94
LmMNCj4gaW5kZXggZWZhY2QyNGEwODVkLi40MzdlN2UyZTZhZDUgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbWFpbGJveC9tYWlsYm94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L21haWxib3gu
Yw0KPiBAQCAtNDgsNyArNDgsNyBAQCBzdGF0aWMgaW50IGFkZF90b19yYnVmKHN0cnVjdCBtYm94
X2NoYW4gKmNoYW4sIHZvaWQgKm1zc2cpDQo+ICBzdGF0aWMgdm9pZCBtc2dfc3VibWl0KHN0cnVj
dCBtYm94X2NoYW4gKmNoYW4pDQo+ICB7DQo+ICAgdW5zaWduZWQgY291bnQsIGlkeDsNCj4gLSB2
b2lkICpkYXRhOw0KPiArIHZvaWQgKmRhdGEgPSBOVUxMOw0KPiAgIGludCBlcnIgPSAtRUJVU1k7
DQo+IA0KPiAgIHNjb3BlZF9ndWFyZChzcGlubG9ja19pcnFzYXZlLCAmY2hhbi0+bG9jaykgew0K
PiBAQCAtNjYsMTQgKzY2LDIyIEBAIHN0YXRpYyB2b2lkIG1zZ19zdWJtaXQoc3RydWN0IG1ib3hf
Y2hhbiAqY2hhbikNCj4gDQo+ICAgaWYgKGNoYW4tPmNsLT50eF9wcmVwYXJlKQ0KPiAgIGNoYW4t
PmNsLT50eF9wcmVwYXJlKGNoYW4tPmNsLCBkYXRhKTsNCj4gLSAvKiBUcnkgdG8gc3VibWl0IGEg
bWVzc2FnZSB0byB0aGUgTUJPWCBjb250cm9sbGVyICovDQo+IC0gZXJyID0gY2hhbi0+bWJveC0+
b3BzLT5zZW5kX2RhdGEoY2hhbiwgZGF0YSk7DQo+ICsNCj4gKyAvKiBUcnkgdG8gc3VibWl0IGEg
bWVzc2FnZSB0byB0aGUgTUJPWCBjb250cm9sbGVyIGluIGF0b21pYyBjb250ZXh0ICovDQo+ICsg
aWYgKGNoYW4tPm1ib3gtPm9wcy0+c2VuZF9kYXRhKQ0KPiArIGVyciA9IGNoYW4tPm1ib3gtPm9w
cy0+c2VuZF9kYXRhKGNoYW4sIGRhdGEpOw0KPiArIGVsc2UgaWYgKGNoYW4tPm1ib3gtPm9wcy0+
c2VuZF9kYXRhX25vbmF0b21pYykNCj4gKyBlcnIgPSAwOw0KPiAgIGlmICghZXJyKSB7DQo+ICAg
Y2hhbi0+YWN0aXZlX3JlcSA9IGRhdGE7DQo+ICAgY2hhbi0+bXNnX2NvdW50LS07DQo+ICAgfQ0K
PiAgIH0NCj4gDQo+ICsgLyogVHJ5IHRvIHN1Ym1pdCBhIG1lc3NhZ2UgdG8gdGhlIE1CT1ggY29u
dHJvbGxlciBpbiBub24tYXRvbWljIGNvbnRleHQgKi8NCj4gKyBpZiAoIWVyciAmJiBjaGFuLT5t
Ym94LT5vcHMtPnNlbmRfZGF0YV9ub25hdG9taWMpDQo+ICsgZXJyID0gY2hhbi0+bWJveC0+b3Bz
LT5zZW5kX2RhdGFfbm9uYXRvbWljKGNoYW4sIGRhdGEpOw0KPiArDQo+ICAgaWYgKCFlcnIgJiYg
KGNoYW4tPnR4ZG9uZV9tZXRob2QgJiBNQk9YX1RYRE9ORV9CWV9QT0xMKSkgew0KPiAgIC8qIGtp
Y2sgc3RhcnQgdGhlIHRpbWVyIGltbWVkaWF0ZWx5IHRvIGF2b2lkIGRlbGF5cyAqLw0KPiAgIHNj
b3BlZF9ndWFyZChzcGlubG9ja19pcnFzYXZlLCAmY2hhbi0+bWJveC0+cG9sbF9ocnRfbG9jaykN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9yaXNjdi1zYmktbXB4eS1tYm94LmMNCj4g
Yi9kcml2ZXJzL21haWxib3gvcmlzY3Ytc2JpLW1weHktbWJveC5jDQo+IGluZGV4IGIwMmMxN2My
YzY0ZS4uOWFmYTEwYzcyYmQ3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21haWxib3gvcmlzY3Yt
c2JpLW1weHktbWJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9yaXNjdi1zYmktbXB4eS1t
Ym94LmMNCj4gQEAgLTQyMCw3ICs0MjAsNyBAQCBzdGF0aWMgdm9pZCBtcHh5X21ib3hfc2h1dGRv
d24oc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gIH0NCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG1ib3hfY2hhbl9vcHMgbXB4eV9tYm94X29wcyA9IHsNCj4gLSAuc2VuZF9kYXRhID0gbXB4
eV9tYm94X3NlbmRfZGF0YSwNCj4gKyAuc2VuZF9kYXRhX25vbmF0b21pYyA9IG1weHlfbWJveF9z
ZW5kX2RhdGEsDQo+ICAgLnBlZWtfZGF0YSA9IG1weHlfbWJveF9wZWVrX2RhdGEsDQo+ICAgLnN0
YXJ0dXAgPSBtcHh5X21ib3hfc3RhcnR1cCwNCj4gICAuc2h1dGRvd24gPSBtcHh5X21ib3hfc2h1
dGRvd24sDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3hfY29udHJvbGxlci5o
DQo+IGIvaW5jbHVkZS9saW51eC9tYWlsYm94X2NvbnRyb2xsZXIuaA0KPiBpbmRleCAyNmEyMzhh
NmY5NDEuLjRiYzQ3OThjNGIxZiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94
X2NvbnRyb2xsZXIuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3hfY29udHJvbGxlci5o
DQo+IEBAIC0yOCw2ICsyOCwxMCBAQCBzdHJ1Y3QgbWJveF9jaGFuOw0KPiAgICogdHJhbnNtaXNz
aW9uIG9mIGRhdGEgaXMgcmVwb3J0ZWQgYnkgdGhlIGNvbnRyb2xsZXIgdmlhDQo+ICAgKiBtYm94
X2NoYW5fdHhkb25lIChpZiBpdCBoYXMgc29tZSBUWCBBQ0sgaXJxKS4gSXQgbXVzdCBub3QNCj4g
ICAqIHNsZWVwLg0KPiArICogQHNlbmRfZGF0YV9ub25hdG9taWM6IFRoZSBBUEkgYXNrcyB0aGUg
TUJPWCBjb250cm9sbGVyIGRyaXZlciwgaW4gbm9uLWF0b21pYw0KPiArICogY29udGV4dCB0cnkg
dG8gdHJhbnNtaXQgYSBtZXNzYWdlIG9uIHRoZSBidXMuIFJldHVybnMgMCBpZg0KPiArICogZGF0
YSBpcyBhY2NlcHRlZCBmb3IgdHJhbnNtaXNzaW9uLCBuZWdhdGl2ZSBlcnJvciB3aGlsZSByZWpl
Y3RpbmcNCj4gKyAqIGlmIHRoZSByZW1vdGUgbm90IGFjY2NlcHRlZC4NCj4gICAqIEBmbHVzaDog
Q2FsbGVkIHdoZW4gYSBjbGllbnQgcmVxdWVzdHMgdHJhbnNtaXNzaW9ucyB0byBiZSBibG9ja2lu
ZyBidXQNCj4gICAqIHRoZSBjb250ZXh0IGRvZXNuJ3QgYWxsb3cgc2xlZXBpbmcuIFR5cGljYWxs
eSB0aGUgY29udHJvbGxlcg0KPiAgICogd2lsbCBpbXBsZW1lbnQgYSBidXN5IGxvb3Agd2FpdGlu
ZyBmb3IgdGhlIGRhdGEgdG8gZmx1c2ggb3V0Lg0KPiBAQCAtNTMsNiArNTcsNyBAQCBzdHJ1Y3Qg
bWJveF9jaGFuOw0KPiAgICovDQo+ICBzdHJ1Y3QgbWJveF9jaGFuX29wcyB7DQo+ICAgaW50ICgq
c2VuZF9kYXRhKShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB2b2lkICpkYXRhKTsNCj4gKyBpbnQg
KCpzZW5kX2RhdGFfbm9uYXRvbWljKShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuLCB2b2lkICpkYXRh
KTsNCj4gICBpbnQgKCpmbHVzaCkoc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdW5zaWduZWQgbG9u
ZyB0aW1lb3V0KTsNCj4gICBpbnQgKCpzdGFydHVwKShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKTsN
Cj4gICB2b2lkICgqc2h1dGRvd24pKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pOw0KPiANCj4gUmVn
YXJkcywNCj4gQW51cA0KDQpZb3UgYXJlIHJpZ2h0LiBJJ2xsIGluY2x1ZGUgaXQgaW4gYSBzZXBh
cmF0ZSBwYXRjaCBpbiB0aGUgbmV4dCBzZXJpZXMuDQoNClRoYW5rcy4NCkFtaXINCg0KDQo=
