Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0FFC87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:08:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2EDEB4FBAD
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 23:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755126503;
	bh=Ce5heoJ2zEkYU2NNsnXYQXyHIExIkO8k26ouIQ9aIto=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ZbUX630TmTS+fvy44thB+i7VRw4TfF25KlutV3vXYJCgxbYs+D9YQaNVgRGgvRm+v
	 6hz9qkIbthbELQwWHkvkPVzBrwz7pGe7ND4YicfzN5NOfZUE7vjk2DILq+Hs3kHJ5K
	 VX8I7l/jrNlfKmYvGJYzp90xQXQ8aX41ZcRRfUUtDvCS4gVXgl6K9OKN8y9x1hzFT/
	 Y2lUbw96hc4pnIZHPMdZN2RAEOcw+R5D8x9b527rJuto48ER8fhFWwpPTA/evg9hbM
	 Aqy9NyN5lUpGiFaZXvD/kleHJkWsPhUjdNejzR3AG3733rwr2Y31KRrw2fOJaCEiUi
	 oof/u0N0zliaA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1394B42E7A
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U8zOzJHE;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMBPit027100
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rcBAK8eEeC3gYozyTRH3zfy0KnL/G+SterUWthRRl60=; b=U8zOzJHEoKmIQoET
	t4wcKyCFI4yA7ChPpRqtIZQQBQYhyHrWSjqOlZWfYSpUyY5Whw7jdUvGQ4uwLXz5
	m6tZJLWSeSkAZNn0z3M6uztHqlpsjd/4NqB8zlSEz65n3qqfkYMPMset8EKCxqOK
	4iOUP5Vu1pT75vbH8gxV1pP4tJhOfyYzY65iJ+XX5JbsXtXIuXwqyAKx77lfnqoN
	6mNNV3auWxk7Qx+aESf/UqpEybNFf83IBGLkWIknnFkCaAK6787ixCAXyPDPfB4l
	QdQZnybKpgRUJUJDa123Glpx5gwFmI/fNh1vPNXdpRBH+Yo3orQ6+VnyQROj/uPX
	ceGGyQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjsc06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 23:08:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323266c83f6so400722a91.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 16:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755126487; x=1755731287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcBAK8eEeC3gYozyTRH3zfy0KnL/G+SterUWthRRl60=;
        b=p9IUHATYwfpKFSgbQtKWgGeTjSwIjALewvMzVgyoQvB8gASAXJ7UXuO31l0/SkisQ2
         gnHqxtV19KzA00fVVCW5g2xuOBwvWja4NzGHK1wQqy3ZLHzRTJZb2QOCBW25Jj31RvDS
         VM84oKzfgW2ygF1qYNebk853A1R7tiDWsqMyhq/w0qwAXxI9SeoHh0bk4S27EJbuccJ0
         O1PQPL1iJvvhBRA0+BkXOAEmMAoUlx+JDPJvTKyy+T+hvqOWy1Al5666IN6E/MB1xTPP
         vIRt2gRyB7IIvViiw9zY8BHYwxZfzsM/wd63p/orMPXN60pGHe1XfMyhHe1sVxulZMs4
         BZmA==
X-Forwarded-Encrypted: i=1; AJvYcCUOnBv6qat70jTF/q1s1NLl7AaeyhShBWfMBOBH7uqpdJRjzoHNy9fPdIWVhOVPZZEgIjwFC58=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw8xU1j/P45STFhSQHaU7XQTKhVG/Oc47fq2NYwLhPdUmKCz7Mq
	sAra9ReaQlGnKAMGHoW/waapbso0B1m0qGuRo5ZZrI2GshWYlokOlkoxEKGHnVAYDtFRgfw4kRg
	+h4ZxWqZHSmG7Plbg4sU3syIoRHyoDEQGOBx/7YH6FwfTCdPBrSHBpSHVeV5CmhMZHpKoJzE=
X-Gm-Gg: ASbGncuPTVlYOgOConBiBKgfcxxhET9JnAt2d5ejt1iZaJ9BOiFCSkwNcG63ezOW91r
	RCFdKPPKc6NfrcKFykLkV3jxxZLGl21q3tCZHgyChk29pmnJoAn1I3oHSFD5ELTLESagDHw//VL
	I2hufLHxMOCdMONeLJnd/xCwiCEKn3QDim0dWhiZcCzRpcovj311d2BagDEXCSx5/b7PRDKk1yL
	pEj6xslWybGBgdyfR6rQGb6aacDwI0FByhwBhDpa1TpuAt8/EP4zhobVhy0/34AuEHdxTWArAhi
	ZAQXOW7cxXZ1qAMfpvVi8pNSkB4vThPH8rBoO3vmw6WRi2yr7GHmeCeIGh8luv5piUA17yHw9OO
	AgG+4TBI2MIsmKMxKYdxtUtgxaYzuWb9cRAzTLw==
X-Received: by 2002:a17:90b:580e:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-32329ae3857mr664172a91.13.1755126487051;
        Wed, 13 Aug 2025 16:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAb97Pa0qtCkny2T4Bm3SgwY7hxlZeUaAqrAvqEuROtklAwf8KwhQzp8LvQNNm/xytIym38g==
X-Received: by 2002:a17:90b:580e:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-32329ae3857mr664147a91.13.1755126486585;
        Wed, 13 Aug 2025 16:08:06 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422babfbbdsm28366124a12.35.2025.08.13.16.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 16:08:06 -0700 (PDT)
Message-ID: <7aa7035f-d2c4-4c00-bc46-2e98d4c2641f@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 09:07:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
 <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
 <d81abdef-18fa-496d-8493-e8f336c43800@oss.qualcomm.com>
 <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d74404ec-44ad-412f-98ef-eed288ecf1bf@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX07/zE9kFw1M/
 +Iy0qN4snymbd+1kNU2IpU/gnXAaG/rW+WYSKm0SMT81S01yuKCSiJw8dA5BNM4gGrjAlQhICRf
 rlp05HHEjrxm15atnmRD4Ikrn6J3YxvIQt+p5Y+Q1Gt09634m59ZSlASYdtKfElXD0DroCclX6V
 4NRBCstn45MW+h+Sk/80LSy7VqiGoRChQhikg9S0GwwHUZ6TPX+U/ZXZgk9w+28m9EZAzZzQQ0e
 w07RV2V5cmV22iiAma97QiiNdJllv2PsfzEICy6aGOcj6YICDblfsd4wFyHwMWbAasJC11cZRYi
 ntjsuU4bJIRRYzjc1GDaA6G8p3gzv4A4lmteB4ElYT9riAvshJSVo0Lz5IqBl/uahNvnPbMOFIN
 pFfrJ5uN
X-Proofpoint-GUID: enJjnP_yfeBxl_vXKybOsjGXG3FwJGo8
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689d1ad8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=AwBIn8DhAZiLWRgty54A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: enJjnP_yfeBxl_vXKybOsjGXG3FwJGo8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074
X-Rspamd-Queue-Id: 1394B42E7A
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.85 / 15.00];
	BAYES_HAM(-2.75)[98.90%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[1.41.240.65:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: AFK7R7MXIZOTAWOE3LLZXZMKAUGL6FY7
X-Message-ID-Hash: AFK7R7MXIZOTAWOE3LLZXZMKAUGL6FY7
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AFK7R7MXIZOTAWOE3LLZXZMKAUGL6FY7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

DQoNCk9uIDgvMTQvMjAyNSA4OjQ5IEFNLCBLb25yYWQgRHliY2lvIHdyb3RlOg0KPiBPbiA4LzE0
LzI1IDEyOjI0IEFNLCBBbWlycmV6YSBaYXJyYWJpIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiA4LzEz
LzIwMjUgODowMCBQTSwgS29ucmFkIER5YmNpbyB3cm90ZToNCj4+PiBPbiA4LzEzLzI1IDI6MzUg
QU0sIEFtaXJyZXphIFphcnJhYmkgd3JvdGU6DQo+Pj4+IEVuYWJsZSB1c2Vyc3BhY2UgdG8gYWxs
b2NhdGUgc2hhcmVkIG1lbW9yeSB3aXRoIFFURUUuIFNpbmNlDQo+Pj4+IFFURUUgaGFuZGxlcyBz
aGFyZWQgbWVtb3J5IGFzIG9iamVjdCwgYSB3cmFwcGVyIGlzIGltcGxlbWVudGVkDQo+Pj4+IHRv
IHJlcHJlc2VudCB0ZWVfc2htIGFzIGFuIG9iamVjdC4gVGhlIHNoYXJlZCBtZW1vcnkgaWRlbnRp
ZmllciwNCj4+Pj4gb2J0YWluZWQgdGhyb3VnaCBURUVfSU9DX1NITV9BTExPQywgaXMgdHJhbnNm
ZXJyZWQgdG8gdGhlIGRyaXZlciB1c2luZw0KPj4+PiBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBF
X09CSlJFRl9JTlBVVC9PVVRQVVQuDQo+Pj4+DQo+Pj4+IFRlc3RlZC1ieTogTmVpbCBBcm1zdHJv
bmcgPG5laWwuYXJtc3Ryb25nQGxpbmFyby5vcmc+DQo+Pj4+IEFja2VkLWJ5OiBTdW1pdCBHYXJn
IDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQo+Pj4+IFRlc3RlZC1ieTogSGFyc2hhbCBE
ZXYgPHF1aWNfaGRldkBxdWljaW5jLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQW1pcnJlemEg
WmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3MucXVhbGNvbW0uY29tPg0KPj4+PiAtLS0NCj4+
Pg0KPj4+IFsuLi5dDQo+Pj4NCj4+Pj4gKy8qIE1hcHBpbmcgaW5mb3JtYXRpb24gZm9ybWF0IGFz
IGV4cGVjdGVkIGJ5IFFURUUuICovDQo+Pj4+ICtzdHJ1Y3QgcWNvbXRlZV9tYXBwaW5nX2luZm8g
ew0KPj4+PiArCXU2NCBwYWRkcjsNCj4+Pj4gKwl1NjQgbGVuOw0KPj4+PiArCXUzMiBwZXJtczsN
Cj4+Pj4gK30gX19wYWNrZWQ7DQo+Pj4NCj4+PiBQbGVhc2UgdXNlIHR5cGVzIHdpdGggZXhwbGlj
aXQgZW5kaWFubmVzcywgZS5nLiBfX2xlMzIuIEknbSBhc3N1bWluZw0KPj4+IFRaIHdpbGwgYWx3
YXlzIGJlIGxpdHRsZS1lbmRpYW4sIHJlZ2FyZGxlc3Mgb2YgdGhlIGhvc3QgT1MNCj4+Pg0KPj4N
Cj4+IEknbSBub3QgZW50aXJlbHkgc3VyZSBob3cgdGhpcyBwb2ludCBpcyByZWxldmFudC4gQXMg
SSB1bmRlcnN0YW5kIGl0LA0KPj4gdGhlIGNvcmUgdGhhdCBwb3B1bGF0ZXMgdGhpcyBzdHJ1Y3Qg
aXMgdGhlIHNhbWUgb25lIHRoYXQgYWNjZXNzZXMgaXQgaW4gVFouDQo+PiBZb3VyIGFyZ3VtZW50
IHdvdWxkIGFic29sdXRlbHkgbWFrZSBzZW5zZSBpZiB0aGUgaG9zdCBhbmQgVFogd2VyZSBvcGVy
YXRpbmcNCj4+IG9uIGRpZmZlcmVudCBjb3JlcyB3aXRoIGRpc3RpbmN0IGFyY2hpdGVjdHVyZXMg
LS0gc3VjaCBhcyBvbmUgYmVpbmcNCj4+IGxpdHRsZS1lbmRpYW4gYW5kIHRoZSBvdGhlciBiaWct
ZW5kaWFuLCB3aGljaCBpcyBub3QgdGhlIGNhc2UuDQo+IA0KPiBDT05GSUdfQ1BVX0JJR19FTkRJ
QU49eSBleGlzdHMgb24gYXJtNjQNCj4gDQo+IEtvbnJhZA0KDQpUaGF04oCZcyBub3Qgd2hhdCBJ
IG1lYW50LiBJIHVuZGVyc3RhbmQgd2UgaGF2ZSB0aGlzIGNvbmZpZyB2YWx1ZSwNCmJ1dCB0aGUg
YXJndW1lbnQgaXMgd2hldGhlciwgaW4gYW4gU01QIHN5c3RlbSwgd2UgZXhwZWN0IG9uZSBjb3Jl
IHRvDQpvcGVyYXRlIGluIGxpdHRsZS1lbmRpYW4gbW9kZSB3aGlsZSBhbm90aGVyIG9wZXJhdGVz
IGluIGJpZy1lbmRpYW4gbW9kZS4NCkkgZG8gbm90IGJlbGlldmUgdGhhdCBpcyB0aGUgY2FzZS4g
VGhlbiBpdCBiZWNvbWVzIGlycmVsZXZhbnQuDQoNCkFtaXINCg0K
