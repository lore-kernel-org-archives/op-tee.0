Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4482DC9832F
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 08:58:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6CF8845402
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 08:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790585903;
	bh=QY9krCsZm6JJhT6YW/RXyceh1fMJYUFOEPnOJbOAvls=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Rb9zuDvDVMCIlwwo4F1QD+GO7GIaWNMMRlRh0d5tNp4x5usdI5sWCr7ZU4ZEiZtQX
	 N9qiMmxlPZC0TuHWAASFLLS1BlCwoaIe6b8Y+eCgtpPcbA9XKQpUCRDAcbOBfuHM1I
	 soW9WQ+1gMMKZWtlLKU8EAqkLF4JBDgek4WmifhWyZNq/NziaNXzCZE+BUbHEhegHd
	 g540qQnIesAbBwJIShUBd9m7Mt5yPEc6w6nJ1JCtnZS0eXP9zn1qjLZKciEpq7f+Ws
	 Qc2srhSncvHj+jbPhf9pu4AqoDo/1uhgUO6oScKMcsWiQCuioODhk8RorbTTsoWWE7
	 Vgv2kYRuP5tew==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 45940444F8
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 08:58:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZdZsHRNw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NeoykECX;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S7xrmM1029763
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 08:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xaXj4PjqLEDQu2RCV2Zkjhys5ijdfJNEie7gMliYE+Q=; b=ZdZsHRNw9uXfAL5w
	BozeSD6/zbQlWxZsLW0vku1sEm9hDelF0RNCJyN3KJ6ONYtgvwOOvfzl9wSplsZ8
	veLGugP65+M6rfmhti6yLfDuNItWwE/TQ/X3v8QL1wtt0J7JNTryAtK4CCJFngrJ
	8jEg1LRNAdwgPlJ2vREghhmhsZPvMcmbxdTnujMwp8E87R975UiUbGvUgjOvb/IX
	ah3zo1TqXcPwBgDCtZQ+Tfgz92+OLISWqLMifNby/LN70b2x31p1n2p4zuPhGSjI
	92jUKi+GZK3xxINo8FXsUU2gmSF0WmL/ODDb+7iUqd2yxsOkdhCu6gER8q7ihen+
	SuBw/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjkxgmer-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 08:58:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7baeea793so143413a12.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790585895; x=1791190695; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xaXj4PjqLEDQu2RCV2Zkjhys5ijdfJNEie7gMliYE+Q=;
        b=NeoykECXi+LfERi3a5tb9T7DlbpS/a+AanWQu0Rdo7H6BI8iKnGTZSkaEGM+vqD6IU
         C4asnCDl37AWTLz6b9izrM6+CWSoF40oTAF+S0tuKIpIomVf8ZIyH80wMoycnMZFnh+o
         FkckAF86D6Umv8qPxuwitpwnS1M9/igPUcGqRxlL2WJknVNyW9wr43xqi8q2fkvp+wBs
         94uZk/Osl0g80ZhLnRsiCE54EH4G3QxWSI808LbSqVPfbUleJreZ1+XKlgCzBWrx5b9j
         L2qvho8ZlG5PDpf0qJ0Q6OdCVsiK3oS06eCJKmxNXZHMUuht5GUgOqrMjwQdGki+gBfR
         wdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585895; x=1791190695;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xaXj4PjqLEDQu2RCV2Zkjhys5ijdfJNEie7gMliYE+Q=;
        b=nR5H3N7/PmC+nGASVGUB6hHq28+xZcqNiU1znfUj7/7baIc0iZi4ei+wIfFT76i6Cn
         H1WxMDdobMQYoDXntl1JECEh/rWw6yW98tP6GXYSKxukWOoqVvp7eFcWKqT/q1H+c7m1
         koI5Q0lMHcOWUgdP597PXov5a06olrQbf8PSHWtmzi8xGID4zKPWQTxzy0+1SQDKuM01
         GBkGmvyTa/0UHMKcE0uRYacuyu543Zatr7sU1u7pwY3Osi2QAWbxD2KeXffmLfnYGDDy
         qqL3eP7W1XrrCH9cGba5mrVIe/LrDFels1r3lM/Ulkn3oWHh91mDyCnfMfqFknhGxMgi
         tr6w==
X-Forwarded-Encrypted: i=1; AKwUvBzfUyJaPgR0hL2T2h9KvADCU2X1p+oLax5sCYKPw/yQhPCm3d2+GylkSohg1JyTgotn3NIfPSE=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJPWtlHt5/adMf0OKwOWNqR3D3EO30DSZOrbjmsH+nPBjnjDE5w
	DucCXllSsSYqmXc1p0FCglRwrgjz5+D+8ilXmvVgQDWVaLHb4fSj9nYXQkqMepkivqHGJyjt0/9
	fE9zKExjKX6ImOTJ85MtJa8DwySFfzJp6b7BXfUV/CW+LfHpfRJwD/L9dbhlir3FW21nDISA=
X-Gm-Gg: AYBFou3JB5PigLmPhDSqTFAcalLA03VGS3EN/OOsY9fUxydkCIZGI1OKVdbxieROnHP
	bk4GcXezuQaD5CPOhaxxjIB9B38k1mPY1L11fbEv0Q1wPyAeh/pJKYKaSHCGF0EvI7gSrutuxsL
	EPf0hTTUQ/7WmS8er5hY2LKWk2MCVg6pf6JcMz8abUXzjyJfn6ebSWkE6PSrlvGFwGSapwyoOoW
	EKWXN+tx++9RcapD76qoStzFRalb/9anuoKKiVy4u0rty31btDVEzP6kGSB2fpo/6TwI5EyFwFm
	nzvIllkBs0hTXBecaFQzHMGzS5XVJM7klXzq7055HnIzDmFzbURSXPNkOFq8r2LC/DzWKGVtVMq
	imyiqpI/fiohpRunTZSkyHxe6+j/lo4XK
X-Received: by 2002:a17:90b:2250:b0:39d:f247:bb3 with SMTP id 98e67ed59e1d1-3a098b4b334mr10136988a91.21.1790585895460;
        Mon, 28 Sep 2026 01:58:15 -0700 (PDT)
X-Received: by 2002:a17:90b:2250:b0:39d:f247:bb3 with SMTP id 98e67ed59e1d1-3a098b4b334mr10136980a91.21.1790585894976;
        Mon, 28 Sep 2026 01:58:14 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.14.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0cd1c4ec9sm15313374a91.16.2026.09.28.01.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 01:58:14 -0700 (PDT)
Message-ID: <c0e3afc3-899f-44fe-b865-a32892e00cc1@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:58:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
 <aqyX3lJ1eNBmzbSP@kernel.org>
 <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
 <CAGgiveUA665UFwoojYBOB_rvCh=3NBug-B8xEBBVNPC=0jTCQg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAGgiveUA665UFwoojYBOB_rvCh=3NBug-B8xEBBVNPC=0jTCQg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: RQfyZ7_ohA0jotvHvTg3GlwmPXKPOO89
X-Proofpoint-ORIG-GUID: RQfyZ7_ohA0jotvHvTg3GlwmPXKPOO89
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX+aLCJjmbcrzx
 E6NBS5qNdz4LBtghwIF+PjBL+5j7UQdG5BwKj+kolhwxelJrjDpUFGCdO4ZQE85VXR8mMkNHYdJ
 qj4SGWtMA+6vVfr3/tC7F48wRZhS/Ec=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX844gsa95iX+E
 8OAaf29KGe3hnsnQUStv/3czSEBHbkEeK46TWmS0wf0ev5yxWBcGXtiHEqfEZBNWk746VVFlg2m
 goeOEZs5Oa2RXeP82sEblHkGu8DJ2DtQwy/G3n4+fNvDsHahKxN56RKsMvBW9lM/isw/ZxzxqpC
 g6I1FBCnCdIyZf60zZ0a20tE/6wOBBXKqyxUc5T2bwoCM4NOdPqSjfkZLjTmEidlrjx6GE/bmwO
 4YgUOI2GOmvLLaOApNUyOgKlx++is9GJDHJf9Iqz4SDXupd1Q8ymOka/xHLxhHHwxiSj0QYlikA
 wH2I2DcnVlF59zQWft2zQkOHGOeurLSrV1RHKJNPMN3Ix/nzPM5kAoIenV+sKSzFw4adMCdF2Kx
 3eXto4n0k1XD+ojP3PYKYcyyPWTMBNisONZREtAC8hxRFWih8THm7QdNHuO0TWHPj5zzO7P1YpI
 uMWvgMWvdxzSE2tZTcA==
X-Authority-Analysis: v=2.4 cv=QZfzLcbv c=1 sm=1 tr=0 ts=6aba2c28 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Pslwi5Fl4CR3OXkguhnOPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=aXdvgW5Kdip_ic-aS84A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280035
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.02 / 15.00];
	BAYES_HAM(-2.92)[99.66%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 45940444F8
X-Spamd-Bar: ----
Message-ID-Hash: J65CQVO6AD3GSQDE26PCFHSCK3C77Q7W
X-Message-ID-Hash: J65CQVO6AD3GSQDE26PCFHSCK3C77Q7W
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J65CQVO6AD3GSQDE26PCFHSCK3C77Q7W/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgSmVucywNCg0KT24gOS8yNS8yMDI2IDY6NTEgUE0sIEplbnMgV2lrbGFuZGVyIHdyb3RlOg0K
PiBIaSwNCj4gDQo+IE9uIE1vbiwgU2VwIDIxLCAyMDI2IGF0IDEwOjEw4oCvQU0gS3VsZGVlcCBT
aW5naA0KPiA8a3VsZGVlcC5zaW5naEBvc3MucXVhbGNvbW0uY29tPiB3cm90ZToNCj4+DQo+PiBP
biAxOC0wOS0yMDI2IDA3OjE2LCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+Pj4gT24gTW9uLCBT
ZXAgMDcsIDIwMjYgYXQgMDI6NTg6NDFQTSArMDUzMCwgS3VsZGVlcCBTaW5naCB3cm90ZToNCj4+
Pj4gQWRkICJxY29tLnR6LnRwbSIgKFFDT01URUVfVFBNX1VJRCkgdG8gcXRlZV9zZXJ2aWNlc1td
IHNvIHRoZSBUUE0gVEENCj4+Pj4gaXMgZW51bWVyYXRlZCBhcyBhIFRFRS1idXMgZGV2aWNlLCBh
bGxvd2luZyBhIGNsaWVudCBkcml2ZXIgdG8gYmluZCB0bw0KPj4+PiBpdCB2aWEgaXRzIGdlbmVy
YXRlZCBVVUlELg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBLdWxkZWVwIFNpbmdoIDxrdWxk
ZWVwLnNpbmdoQG9zcy5xdWFsY29tbS5jb20+DQo+PiBbLi4uXQ0KPj4NCj4+Pg0KPj4+IFJldmll
d2VkLWJ5OiBKYXJra28gU2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPj4gVGhhbmtzIEph
cmtrbyBmb3IgdGhlIHJldmlldy4NCj4+IENhbiBURUUgbWFpbnRhaW5lcnMoQW1pcnJlemEvSmVu
cz8pIGFsc28gcmV2aWV3IHRoaXMgY2hhbmdlPw0KPiANCj4gQW1pciwgcGxlYXNlIHJldmlldy4N
Cj4gDQoNClNvcnJ5IGZvciB0aGUgZGVsYXkuIEknbGwgZG8uDQoNClJlZ2FyZHMsDQpBbWlyDQoN
Cj4gQ2hlZXJzLA0KPiBKZW5zDQo+IA0KPj4NCj4+IC0tDQo+PiBSZWdhcmRzDQo+PiBLdWxkZWVw
DQo+Pg0KDQo=
