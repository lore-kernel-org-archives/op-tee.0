Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBAAC71136
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 23:48:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 74F7F45AAA
	for <op-tee@archiver.kernel.org>; Wed, 11 Jun 2025 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1749685693;
	bh=L0ehKEOv3bNjAeyQ8Vkkp4xNOYV4hkVTkfnaDIVoaig=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=cBZo8YFLcBvuHKOZncLFQji4ranwPL+IGc1NAKojv0Salc2QvKNnnvzG3HfWrR+Be
	 aZF1FKfRm/0vtSYogrcITA2TUX3yBPcrWMXi2DV0ZUJAnm0G7ItWXDnlFvQiUjV/IP
	 2BVWt5N1Gzw4RR3M94LnUTgEjKby4AQ0Brx4WCIxm+CSbeP13xMcKxaQ/ysi2cT/Ij
	 2Y1qtgemQfEUuxK4Mmog2DPduR1RTyhY4uMD7l9yAEF2RjI9LvJCIyPYJFjPvI6ApC
	 HWB4yoipkYWr3VltQekGBAf7U/lkIjZny/vhlHZoyouXiQAWgx3k0wU4hKqRj70BhT
	 9b1yZPuZ/IdGg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 71A7841AE5
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 23:45:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Uk92e2Re;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BIwL0U027914
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 23:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kL/Liu/GqjPKUC4NnGw8PIVD+TNpkbMa+VGstZWsdgM=; b=Uk92e2ReIMb6itzQ
	XyMYOmDFaHlbqT8QN2wh6CaJU1Ifca/48IbFjhYf0+tLT2k/ooeR962mAS9uSgn6
	DBV5FAp6c3B42an+/WXAF9p+uIsKm1+2v4BNG7WjwiMjdyvCyrVp9uyysSO6g/xf
	HczRBQrYHaWmK9pVwNKXeKHOKCF9hCS6vi+dtdQl+FLmpy5vNSgx9HWNsklA1AJP
	XxdFs/vJVAzCr701hqw4eR3RE0cIBgJnA24yZhpF+f4cUgjGKHvQ8nGElozBvV6O
	BLZ+YX0+TxXymijBPxCu7AITs8GciqOOUAq/+qdgxb2jKmiEgMkK/IY2U9wf8+5Y
	XB2lBA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ccvejts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 23:45:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311ef4fb5eeso240979a91.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Jun 2025 16:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749685520; x=1750290320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kL/Liu/GqjPKUC4NnGw8PIVD+TNpkbMa+VGstZWsdgM=;
        b=I2RNoiHVZpEoKmAU+oJ22TbaSyiRPWaK4RAPSkdw67vi1FCp2F+Ooi3aj1SmswzgYs
         CZ4htDKBeKg18ZTo1SR8Q5KPgIPXD+NOw2tKdUtwwJU3GfWYZawI6hHxiZGjKJTLhd1x
         FVya9EbvjZYQcjAR/CWH6Y7Dt9IarjQGNjVRyfmOFearYI1K3KecUAeItQIAjKaD1I4i
         m34SDOHOyppSd/dlo3zs4hny9cPcaljSwaUakgMq+ZG68YmZkAHAAINFfnHjNwiMQmgz
         iv8BRQjOk9l8T3ol48VptkA+xbs9I7Dnz/cff2Z9kOF45eSv1Da/PQDscf/zwKIjztNw
         hiIw==
X-Forwarded-Encrypted: i=1; AJvYcCWqz4ubKBleqRAKzOqBcOcZMktvcKeabp1OdvmpOrqPS5bmPs3Xja43Gq1vNIKZ6MavwuBGxWQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxH+HAtz9hQ3wVwXKbz12bkuaik/LPPA8TvVtVU9p1VKNZJH0w5
	mdOMlslsatEazVUD1nXLPCo6Zr0M139+nS49kf88AQKtMBJJi+IleZlwLA2+ZgZa14bq9ZVCeZS
	Vtdwx4dCEJCxmZ+M4XGPIfUOefQ9ipF2a9FEwG6FkA5UPGFmKJuhRvwjkSYMOi8MmlYjsqH0=
X-Gm-Gg: ASbGncsFPWnQ0tXMtJrc8h9aLFhuCYSgMZWug8khsvzdDl43DrEKqb2TUD1r6gUbDJZ
	PuoRUH5/2qNYuqJ33Wig7KTuXiHMgzla5LH358yY0/hd26Yq3P3JK5MxwGz9dqAk6+HR+wdifao
	4VNgTzXbbgtAE6vGBVCs0AEtGVHOQW+Vhp4bEjoTr9HgMDEog7C2S3i+mJfrf7snJCREYLAak6w
	5GqKKptQjs0MKTB3/wnv1OcVC5O93J487pCEecQJgur9ueql3/0U7jA3/vCnPQQeRZmn4oCRh1o
	lwjD4f9t+/RWCQDWp971RYzoMhJOHKa4CxWLqpSrKdIZopO5Vh2X+vsy0dDDyB2bTqxZsM1p0Bj
	DgFUb6UL6jKdHVHcSaHka
X-Received: by 2002:a17:90b:1d49:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-313bfd7ab92mr1604723a91.1.1749685520260;
        Wed, 11 Jun 2025 16:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAMR6wEIIwnne3OpDAIO64Df49wCTs/N/zWmX8iRNFkPwGVeKGubpgXpgrWv1YmWUP5MvRNQ==
X-Received: by 2002:a17:90b:1d49:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-313bfd7ab92mr1604694a91.1.1749685519759;
        Wed, 11 Jun 2025 16:45:19 -0700 (PDT)
Received: from [192.168.0.74] (n1-41-240-65.bla22.nsw.optusnet.com.au. [1.41.240.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b499cbsm200694a91.26.2025.06.11.16.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 16:45:19 -0700 (PDT)
Message-ID: <8f9a7ca7-5098-40c6-94b2-490a857d7dae@oss.qualcomm.com>
Date: Thu, 12 Jun 2025 09:45:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
To: Andrew Davis <afd@ti.com>, Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com>
 <20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-3-024e3221b0b9@oss.qualcomm.com>
 <f686130b-009f-4feb-bae1-022938c85923@ti.com>
Content-Language: en-US
In-Reply-To: <f686130b-009f-4feb-bae1-022938c85923@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: kFy6e4kWAcxxkPpOAEAs5m7-eJnNzbAu
X-Authority-Analysis: v=2.4 cv=TsLmhCXh c=1 sm=1 tr=0 ts=684a1511 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=hi51d+lTLNy/RbqRqnOomQ==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=ri7p8OPjmTxfXj7m-Z0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kFy6e4kWAcxxkPpOAEAs5m7-eJnNzbAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDIwMCBTYWx0ZWRfX2FP97UaOyrfe
 95nJ9irYICipucox5TNxzpFDqHlbKOv/7QyODJ0DG9fR4ZrnSsjxpCFeIYgAzT7QpaEMHhIX8Ug
 LrAKqMHA1WFRx+oahM1WlznkxXZf+74TymFY9cZdHkL39rF1YlG9BVLefJEtkuW8Ml3jdb3L6us
 oF9eyZu1zHTyY6Gny5rVxmWQVV5a4P8qVavK8DuTu4MXj9Eznq0lEbF2D8jXjNxLQL2mvuMbCi0
 RpRiVsv2dYLzJRtQyuOS6I0GupjYH3Ri4NV1Y0lDB711xM0LUmstZcX4icRi9Z/uj0XZAidyAbn
 zx8KAfBCCPfFEPiO5aBj4jNdjOk9lcLRW/Gque9LUdPVg3lbCxLa73Sao3GQUyy4UCzkDWLPzIL
 XKadCRq/hbmGlloQtGsFtjbs5o/UynJ8Yp0h697ChL6tw7BIo6Mfl21LmhXcDT++yF/C3t3c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110200
X-Spamd-Bar: --------
X-Spamd-Result: default: False [-8.00 / 15.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 71A7841AE5
Message-ID-Hash: F4OF5QC4QQZPZATSUAJTXL7G7JYTJUQA
X-Message-ID-Hash: F4OF5QC4QQZPZATSUAJTXL7G7JYTJUQA
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F4OF5QC4QQZPZATSUAJTXL7G7JYTJUQA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

SGkgQW5kcmV3LA0KDQpPbiA2LzEyLzIwMjUgODo0MCBBTSwgQW5kcmV3IERhdmlzIHdyb3RlOg0K
PiBPbiA1LzI3LzI1IDE6NTYgQU0sIEFtaXJyZXphIFphcnJhYmkgd3JvdGU6DQo+PiBGb3IgZHJp
dmVycyB0aGF0IGNhbiB0cmFuc2ZlciBkYXRhIHRvIHRoZSBURUUgd2l0aG91dCB1c2luZyBzaGFy
ZWQNCj4+IG1lbW9yeSBmcm9tIGNsaWVudCwgaXQgaXMgbmVjZXNzYXJ5IHRvIHJlY2VpdmUgdGhl
IHVzZXIgYWRkcmVzcw0KPj4gZGlyZWN0bHksIGJ5cGFzc2luZyBhbnkgcHJvY2Vzc2luZyBieSB0
aGUgVEVFIHN1YnN5c3RlbS4gSW50cm9kdWNlDQo+PiBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBF
X1VCVUZfSU5QVVQvT1VUUFVUL0lOT1VUIHRvIHJlcHJlc2VudA0KPj4gdXNlcnNwYWNlIGJ1ZmZl
cnMuDQo+Pg0KPiANCj4gQ291bGQgeW91IGV4cGFuZCBvbiB0aGlzLCB3aGF0IGlzIHRoZSBpc3N1
ZSB3aXRoIG5vcm1hbCBNRU1SRUY/DQo+IA0KDQpRVEVFIHN1cHBvcnRzIHR3byB0eXBlcyBvZiBk
YXRhIHBhc3Npbmc6ICgxKSBtZW1vcnkgb2JqZWN0cyBhbmQgKDIpIGJ1ZmZlcnMuDQpBIG1lbW9y
eSBvYmplY3QgY2FuIGJlIGEgbm9ybWFsIHNoYXJlZCBtZW1vcnkgKHNobSkgaW5zdGFuY2UuIEhv
d2V2ZXIsIGENCmJ1ZmZlciBpcyBhbiBbb2Zmc2V0LCBzaXplXSBwYWlyIHJlZmVycmluZyB0byB0
aGUgdHJhbnNwb3J0IG1lbW9yeSBzaGFyZWQNCndpdGggUVRFRSAoZXN0YWJsaXNoZWQgYXQgdGhl
IGJlZ2luaW5nIG9mIHRoZSBpbnZvY2F0aW9uKS4NCg0KVGhlcmUgaXMgbm8gZGlyZWN0IHJlcHJl
c2VudGF0aW9uIG9mIFZBTFVFIGluIHRoZSBRVEVFIEFCSSwgc28gZXZlbiBiYXNpYw0KZGF0YSB0
eXBlcywgc3VjaCBhcyBpbnQsIG11c3QgYmUgcGFzc2VkIGFzIGEgYnVmZmVyIFtvZmZzZXQsIHNp
emVvZihpbnQpXS4NClZBTFVFIGNhbm5vdCBiZSB1c2VkIGJlY2F1c2UgaXQgb25seSByZXByZXNl
bnRzIGEgdTY0IGRhdGEgc2l6ZS4gV2hpbGUgTUVNUkVGDQppcyBhbiBvcHRpb24sIGl0IHJlcXVp
cmVzIGFkZGl0aW9uYWwgaW9jdGwgY2FsbHMgYW5kIG1lbW9yeSBjb3BpZXMuDQoNCkZvciBleGFt
cGxlLCBpZiB5b3UgbmVlZCB0byBzZW5kIHRocmVlIGludGVnZXJzIHRvIFFURUUsIHlvdSB3b3Vs
ZCByZXF1aXJlOg0KICAoMSkgVGhyZWUgaW9jdGwgY2FsbHMgdG8gYWxsb2NhdGUgdGhyZWUgc2hh
cmVkIG1lbW9yeSBwYWdlcy4NCiAgKDIpIFRocmVlIG1lbWNweSBvcGVyYXRpb25zIHRvIGNvcHkg
ZWFjaCBpbnRlZ2VyIGludG8gaXRzIHJlc3BlY3RpdmUgc2hhcmVkIG1lbW9yeS4NCiAgKDMpIFRo
cmVlIG1lbWNweSBvcGVyYXRpb25zIHRvIHRyYW5zZmVyIGRhdGEgZnJvbSBzaGFyZWQgbWVtb3J5
IHRvIHRoZQ0KICAgICAgdHJhbnNwb3J0IGJ1ZmZlciBzaGFyZWQgd2l0aCBRVEVFLg0KDQpZb3Ug
Y2FuIG9wdGltaXplIHRoaXMgc2xpZ2h0bHkgYnkgbWFraW5nIGEgc2luZ2xlIGlvY3RsIGNhbGwg
Zm9yIHNoYXJlZA0KbWVtb3J5IGFsbG9jYXRpb24uIEhvd2V2ZXIsIHRoZSBiYWNrZW5kIHN0aWxs
IG5lZWRzIHRvIGluc3BlY3QgdGhlIHNoYXJlZA0KbWVtb3J5LCBwYXJzZSBpdCwgYW5kIGV4dHJh
Y3QgdGhlIGRhdGEgYW5kIHNpemUgaW5mb3JtYXRpb24uDQoNCldpdGggVUJVRiB1c2VyIHBhc3Mg
dXNlciBhZGRyZXNzIGFuZCBzaXplLCBhbmQgdGhlciBpcyBvbmx5IG9uZSBjb3B5X2Zyb21fdXNl
DQppbiB0aGUgYmFja2VuZC4NCg0KUmVnYXJkcywNCkFtaXIgIA0KDQo+IEFuZHJldw0KPiANCj4+
IFJldmlld2VkLWJ5OiBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQG9zcy5xdWFsY29tbS5jb20+DQo+
PiBUZXN0ZWQtYnk6IE5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPg0K
Pj4gU2lnbmVkLW9mZi1ieTogQW1pcnJlemEgWmFycmFiaSA8YW1pcnJlemEuemFycmFiaUBvc3Mu
cXVhbGNvbW0uY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL3RlZS90ZWVfY29yZS5jwqDCoCB8
IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gwqAgaW5jbHVkZS9saW51
eC90ZWVfZHJ2LmjCoCB8wqAgNiArKysrKysNCj4+IMKgIGluY2x1ZGUvdWFwaS9saW51eC90ZWUu
aCB8IDIyICsrKysrKysrKysrKysrKystLS0tLS0NCj4+IMKgIDMgZmlsZXMgY2hhbmdlZCwgNTUg
aW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90ZWUvdGVlX2NvcmUuYyBiL2RyaXZlcnMvdGVlL3RlZV9jb3JlLmMNCj4+IGluZGV4IGI5ZWE1
YTg1Mjc4Yy4uNzRlNDBlZDgzZmE3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy90ZWUvdGVlX2Nv
cmUuYw0KPj4gKysrIGIvZHJpdmVycy90ZWUvdGVlX2NvcmUuYw0KPj4gQEAgLTM4Nyw2ICszODcs
MTcgQEAgc3RhdGljIGludCBwYXJhbXNfZnJvbV91c2VyKHN0cnVjdCB0ZWVfY29udGV4dCAqY3R4
LCBzdHJ1Y3QgdGVlX3BhcmFtICpwYXJhbXMsDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwYXJhbXNbbl0udS52YWx1ZS5iID0gaXAuYjsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBhcmFtc1tuXS51LnZhbHVlLmMgPSBpcC5jOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYnJlYWs7DQo+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRU
Ul9UWVBFX1VCVUZfSU5QVVQ6DQo+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBURUVfSU9DVExfUEFS
QU1fQVRUUl9UWVBFX1VCVUZfT1VUUFVUOg0KPj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgVEVFX0lP
Q1RMX1BBUkFNX0FUVFJfVFlQRV9VQlVGX0lOT1VUOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcGFyYW1zW25dLnUudWJ1Zi51YWRkciA9IHU2NF90b191c2VyX3B0cihpcC5hKTsNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhcmFtc1tuXS51LnVidWYuc2l6ZSA9IGlwLmI7DQo+PiAr
DQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWFjY2Vzc19vayhwYXJhbXNbbl0udS51
YnVmLnVhZGRyLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBhcmFtc1tuXS51LnVidWYuc2l6ZSkpDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJldHVybiAtRUZBVUxUOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YnJlYWs7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRUUl9U
WVBFX01FTVJFRl9JTlBVVDoNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFRFRV9JT0NUTF9Q
QVJBTV9BVFRSX1RZUEVfTUVNUkVGX09VVFBVVDoNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNl
IFRFRV9JT0NUTF9QQVJBTV9BVFRSX1RZUEVfTUVNUkVGX0lOT1VUOg0KPj4gQEAgLTQ1NSw2ICs0
NjYsMTEgQEAgc3RhdGljIGludCBwYXJhbXNfdG9fdXNlcihzdHJ1Y3QgdGVlX2lvY3RsX3BhcmFt
IF9fdXNlciAqdXBhcmFtcywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cHV0X3VzZXIocC0+dS52YWx1ZS5jLCAmdXAtPmMpKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCByZXR1cm4gLUVGQVVMVDsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJyZWFrOw0KPj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJf
VFlQRV9VQlVGX09VVFBVVDoNCj4+ICvCoMKgwqDCoMKgwqDCoCBjYXNlIFRFRV9JT0NUTF9QQVJB
TV9BVFRSX1RZUEVfVUJVRl9JTk9VVDoNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChw
dXRfdXNlcigodTY0KXAtPnUudWJ1Zi5zaXplLCAmdXAtPmIpKQ0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVGQVVMVDsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGJyZWFrOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FU
VFJfVFlQRV9NRU1SRUZfT1VUUFVUOg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgVEVFX0lP
Q1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZfSU5PVVQ6DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpZiAocHV0X3VzZXIoKHU2NClwLT51Lm1lbXJlZi5zaXplLCAmdXAtPmIpKQ0KPj4g
QEAgLTY1NSw2ICs2NzEsMTMgQEAgc3RhdGljIGludCBwYXJhbXNfdG9fc3VwcChzdHJ1Y3QgdGVl
X2NvbnRleHQgKmN0eCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlwLmIgPSBwLT51
LnZhbHVlLmI7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpcC5jID0gcC0+dS52YWx1
ZS5jOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+PiArwqDCoMKgwqDC
oMKgwqAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX1VCVUZfSU5QVVQ6DQo+PiArwqDC
oMKgwqDCoMKgwqAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX1VCVUZfT1VUUFVUOg0K
Pj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9VQlVGX0lO
T1VUOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXAuYSA9ICh1NjQpcC0+dS51YnVmLnVh
ZGRyOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXAuYiA9IHAtPnUudWJ1Zi5zaXplOw0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXAuYyA9IDA7DQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBicmVhazsNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBjYXNlIFRFRV9JT0NUTF9QQVJB
TV9BVFRSX1RZUEVfTUVNUkVGX0lOUFVUOg0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGNhc2UgVEVF
X0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZfT1VUUFVUOg0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZfSU5PVVQ6DQo+PiBAQCAt
NzU3LDYgKzc4MCwxNiBAQCBzdGF0aWMgaW50IHBhcmFtc19mcm9tX3N1cHAoc3RydWN0IHRlZV9w
YXJhbSAqcGFyYW1zLCBzaXplX3QgbnVtX3BhcmFtcywNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHAtPnUudmFsdWUuYiA9IGlwLmI7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBwLT51LnZhbHVlLmMgPSBpcC5jOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJl
YWs7DQo+PiArwqDCoMKgwqDCoMKgwqAgY2FzZSBURUVfSU9DVExfUEFSQU1fQVRUUl9UWVBFX1VC
VUZfT1VUUFVUOg0KPj4gK8KgwqDCoMKgwqDCoMKgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJf
VFlQRV9VQlVGX0lOT1VUOg0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcC0+dS51YnVmLnVh
ZGRyID0gdTY0X3RvX3VzZXJfcHRyKGlwLmEpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cC0+dS51YnVmLnNpemUgPSBpcC5iOw0KPj4gKw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFhY2Nlc3Nfb2socGFyYW1zW25dLnUudWJ1Zi51YWRkciwNCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwYXJhbXNbbl0udS51YnVmLnNpemUpKQ0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVGQVVMVDsNCj4+ICsN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPj4gwqDCoMKgwqDCoMKgwqDCoMKg
IGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZfT1VUUFVUOg0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGNhc2UgVEVFX0lPQ1RMX1BBUkFNX0FUVFJfVFlQRV9NRU1SRUZfSU5PVVQ6
DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvdGVlX2Rydi5oIGIvaW5jbHVkZS9saW51eC90ZWVfZHJ2LmgNCj4+IGluZGV4IGE1
NGMyMDMwMDBlZC4uNzhiYmYxMmYwMmYwIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC90
ZWVfZHJ2LmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdGVlX2Rydi5oDQo+PiBAQCAtODIsNiAr
ODIsMTEgQEAgc3RydWN0IHRlZV9wYXJhbV9tZW1yZWYgew0KPj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
dGVlX3NobSAqc2htOw0KPj4gwqAgfTsNCj4+IMKgICtzdHJ1Y3QgdGVlX3BhcmFtX3VidWYgew0K
Pj4gK8KgwqDCoCB2b2lkICogX191c2VyIHVhZGRyOw0KPj4gK8KgwqDCoCBzaXplX3Qgc2l6ZTsN
Cj4+ICt9Ow0KPj4gKw0KPj4gwqAgc3RydWN0IHRlZV9wYXJhbV92YWx1ZSB7DQo+PiDCoMKgwqDC
oMKgIHU2NCBhOw0KPj4gwqDCoMKgwqDCoCB1NjQgYjsNCj4+IEBAIC05Miw2ICs5Nyw3IEBAIHN0
cnVjdCB0ZWVfcGFyYW0gew0KPj4gwqDCoMKgwqDCoCB1NjQgYXR0cjsNCj4+IMKgwqDCoMKgwqAg
dW5pb24gew0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB0ZWVfcGFyYW1fbWVtcmVmIG1l
bXJlZjsNCj4+ICvCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGVlX3BhcmFtX3VidWYgdWJ1ZjsNCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGVlX3BhcmFtX3ZhbHVlIHZhbHVlOw0KPj4gwqDC
oMKgwqDCoCB9IHU7DQo+PiDCoCB9Ow0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC90ZWUuaCBiL2luY2x1ZGUvdWFwaS9saW51eC90ZWUuaA0KPj4gaW5kZXggZDA0MzBiZWU4Mjky
Li4zZTliMWVjNWRmZGUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdGVlLmgN
Cj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC90ZWUuaA0KPj4gQEAgLTE1MSw2ICsxNTEsMTMg
QEAgc3RydWN0IHRlZV9pb2N0bF9idWZfZGF0YSB7DQo+PiDCoCAjZGVmaW5lIFRFRV9JT0NUTF9Q
QVJBTV9BVFRSX1RZUEVfTUVNUkVGX09VVFBVVMKgwqDCoCA2DQo+PiDCoCAjZGVmaW5lIFRFRV9J
T0NUTF9QQVJBTV9BVFRSX1RZUEVfTUVNUkVGX0lOT1VUwqDCoMKgIDfCoMKgwqAgLyogaW5wdXQg
YW5kIG91dHB1dCAqLw0KPj4gwqAgKy8qDQo+PiArICogVGhlc2UgZGVmaW5lcyB1c2Vyc3BhY2Ug
YnVmZmVyIHBhcmFtZXRlcnMuDQo+PiArICovDQo+PiArI2RlZmluZSBURUVfSU9DVExfUEFSQU1f
QVRUUl9UWVBFX1VCVUZfSU5QVVTCoMKgwqAgOA0KPj4gKyNkZWZpbmUgVEVFX0lPQ1RMX1BBUkFN
X0FUVFJfVFlQRV9VQlVGX09VVFBVVMKgwqDCoCA5DQo+PiArI2RlZmluZSBURUVfSU9DVExfUEFS
QU1fQVRUUl9UWVBFX1VCVUZfSU5PVVTCoMKgwqAgMTDCoMKgwqAgLyogaW5wdXQgYW5kIG91dHB1
dCAqLw0KPj4gKw0KPj4gwqAgLyoNCj4+IMKgwqAgKiBNYXNrIGZvciB0aGUgdHlwZSBwYXJ0IG9m
IHRoZSBhdHRyaWJ1dGUsIGxlYXZlcyByb29tIGZvciBtb3JlIHR5cGVzDQo+PiDCoMKgICovDQo+
PiBAQCAtMTg2LDE0ICsxOTMsMTcgQEAgc3RydWN0IHRlZV9pb2N0bF9idWZfZGF0YSB7DQo+PiDC
oCAvKioNCj4+IMKgwqAgKiBzdHJ1Y3QgdGVlX2lvY3RsX3BhcmFtIC0gcGFyYW1ldGVyDQo+PiDC
oMKgICogQGF0dHI6IGF0dHJpYnV0ZXMNCj4+IC0gKiBAYTogaWYgYSBtZW1yZWYsIG9mZnNldCBp
bnRvIHRoZSBzaGFyZWQgbWVtb3J5IG9iamVjdCwgZWxzZSBhIHZhbHVlIHBhcmFtZXRlcg0KPj4g
LSAqIEBiOiBpZiBhIG1lbXJlZiwgc2l6ZSBvZiB0aGUgYnVmZmVyLCBlbHNlIGEgdmFsdWUgcGFy
YW1ldGVyDQo+PiArICogQGE6IGlmIGEgbWVtcmVmLCBvZmZzZXQgaW50byB0aGUgc2hhcmVkIG1l
bW9yeSBvYmplY3QsDQo+PiArICrCoMKgwqDCoCBlbHNlIGlmIGEgdWJ1ZiwgYWRkcmVzcyBvZiB0
aGUgdXNlciBidWZmZXIsDQo+PiArICrCoMKgwqDCoCBlbHNlIGEgdmFsdWUgcGFyYW1ldGVyDQo+
PiArICogQGI6IGlmIGEgbWVtcmVmIG9yIHVidWYsIHNpemUgb2YgdGhlIGJ1ZmZlciwgZWxzZSBh
IHZhbHVlIHBhcmFtZXRlcg0KPj4gwqDCoCAqIEBjOiBpZiBhIG1lbXJlZiwgc2hhcmVkIG1lbW9y
eSBpZGVudGlmaWVyLCBlbHNlIGEgdmFsdWUgcGFyYW1ldGVyDQo+PiDCoMKgICoNCj4+IC0gKiBA
YXR0ciAmIFRFRV9QQVJBTV9BVFRSX1RZUEVfTUFTSyBpbmRpY2F0ZXMgaWYgbWVtcmVmIG9yIHZh
bHVlIGlzIHVzZWQgaW4NCj4+IC0gKiB0aGUgdW5pb24uIFRFRV9QQVJBTV9BVFRSX1RZUEVfVkFM
VUVfKiBpbmRpY2F0ZXMgdmFsdWUgYW5kDQo+PiAtICogVEVFX1BBUkFNX0FUVFJfVFlQRV9NRU1S
RUZfKiBpbmRpY2F0ZXMgbWVtcmVmLiBURUVfUEFSQU1fQVRUUl9UWVBFX05PTkUNCj4+IC0gKiBp
bmRpY2F0ZXMgdGhhdCBub25lIG9mIHRoZSBtZW1iZXJzIGFyZSB1c2VkLg0KPj4gKyAqIEBhdHRy
ICYgVEVFX1BBUkFNX0FUVFJfVFlQRV9NQVNLIGluZGljYXRlcyBpZiBtZW1yZWYsIHVidWYsIG9y
IHZhbHVlIGlzDQo+PiArICogdXNlZCBpbiB0aGUgdW5pb24uIFRFRV9QQVJBTV9BVFRSX1RZUEVf
VkFMVUVfKiBpbmRpY2F0ZXMgdmFsdWUsDQo+PiArICogVEVFX1BBUkFNX0FUVFJfVFlQRV9NRU1S
RUZfKiBpbmRpY2F0ZXMgbWVtcmVmLCBhbmQgVEVFX1BBUkFNX0FUVFJfVFlQRV9VQlVGXyoNCj4+
ICsgKiBpbmRpY2F0ZXMgdWJ1Zi4gVEVFX1BBUkFNX0FUVFJfVFlQRV9OT05FIGluZGljYXRlcyB0
aGF0IG5vbmUgb2YgdGhlIG1lbWJlcnMNCj4+ICsgKiBhcmUgdXNlZC4NCj4+IMKgwqAgKg0KPj4g
wqDCoCAqIFNoYXJlZCBtZW1vcnkgaXMgYWxsb2NhdGVkIHdpdGggVEVFX0lPQ19TSE1fQUxMT0Mg
d2hpY2ggcmV0dXJucyBhbg0KPj4gwqDCoCAqIGlkZW50aWZpZXIgcmVwcmVzZW50aW5nIHRoZSBz
aGFyZWQgbWVtb3J5IG9iamVjdC4gQSBtZW1yZWYgY2FuIHJlZmVyZW5jZQ0KPj4NCg0K
