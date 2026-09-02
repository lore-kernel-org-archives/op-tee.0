Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B13C624D0
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 98AB6452C7
	for <op-tee@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788341248;
	bh=4RrWg3YRAeHPQUzHKjgVo28GNnYT956K15imGLTP8yk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QPa2cOfGaT25LfLFwMSXg1WX+ypA3LVkPJRNtxJDlw1mDIE+1HXifvnKlSPZeWthb
	 TCEPvHLJK5DdlNGU/Cvvu5vkELDSh0wJQ1HFmx+oarYV+QRd0D5hkUio/yyV0LpfGo
	 v1jaQXt481q52nlFcYI7S5q7MXmhOwDPnnn5MVI0vvH46X/Q+eVxyqZLfu3sDvhEhh
	 eJG8Dir1RMUZjtog3KlFV9N+C6fo3575uMxOfLcKqIsegjj6GOPuav6Jm1TjzB4xhx
	 F79kl0c9Pm+oa++ERQ4k6ig4emp6QxHK1415D4BbmFEYjXyECP9bDIaAj81hLu30if
	 rOok9Hy+zchhw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 633324425E
	for <op-tee@lists.trustedfirmware.org>; Wed,  2 Sep 2026 09:27:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CVF1nDol;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CjFoWk4w;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829N1iG590058
	for <op-tee@lists.trustedfirmware.org>; Wed, 2 Sep 2026 09:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gNLzMLJZKI7OImu+XuzOnLBC17S6dnkYMkkwnpIHzgw=; b=CVF1nDol+hpZwsFS
	MOgvCBfb1EwOK0kpu/Z3JNm/mxhLAgh54XhaeCGkXwlxAj2rRKgmNudMadzRAUB6
	6VIahtjrGJKoReOrZVYXLEGFRr340+g4JsWIFwWZl2yCIersIw0MU7Bnw//mavuL
	OoTVWoM5YAztEdwdxd0tLDEnFQIeZ/iIuIuyGb3gMKKvSXd43IpYyfj5PZ2a24Vt
	PyLbKWBXkxzhRWd6YLdV0QtDLb/OhlYfmF0+BJplbFO+QH6WDUNfJ51h3pEwYY5U
	UyToNEgTyeLhWpkb0DJIjqLj5adDzsiqMKWdNWSDFmnc9pGRy0KLjsp4mSavnPiK
	41ffjQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpbpfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 09:27:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so982900a91.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 02 Sep 2026 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788341239; x=1788946039; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gNLzMLJZKI7OImu+XuzOnLBC17S6dnkYMkkwnpIHzgw=;
        b=CjFoWk4wUvM0RqmhjKvOEFsnzwGCrmwVxfr/O7wLqGz5Xu4a335danTIo1SygM1TkW
         pZ3jkKQEgGjHVU7eBTLSo3qRfnqqqVCXT/n7UIdK+3Xp5vdqJUxX8xXXWyBw/Os7hO3t
         CPidyYvDqcsMCurwYYpqzQVQ/NZgRt9b0GjxqSXArPCSBKUK139HuSKVwXUl7yVgSlFA
         AaTu+LSjklFIIcsr0Bk7GB1aDDENUw7zNSxlixhn367ZP+wvXOFenrb4InrLdoaYYZdN
         sCak81TXwITMHsVz5fqWRbJme4PmxN+AdaUvYGnxlbQM4zKX3SEfPkasZ/Nd6sK3TbyT
         IGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341239; x=1788946039;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gNLzMLJZKI7OImu+XuzOnLBC17S6dnkYMkkwnpIHzgw=;
        b=LmY26pqhqUC3lX0kjf7Q3U+Xq/BMB6t8kCwnC+h4R/kO9MPNj1zzk2HVDU7BSld7/4
         34240ICqh/gmE5Ppk4DQ7fh3p6Rw6U/plc9R/TAAT6oAaDE/kTejezXKDYnB7GUJK95e
         F3sK0hCYl7/PI1oMKfwVfXQ1PPT15lxxljmS6NbtyF8FKbglH3Mavkfu5uwL+h4u6hx7
         x7pa+wSTGADr/J9rKx3IkmFcIk+LED+RvqBtyFHcuL8Es32lN15rrDwChqJKiC0bP9Mc
         Y2Q6U5XzlO3etAMM1crMiLqdzKP+wI3Ve2Ct/Q9tEwgXTpUD0sJ56lnNKIf2dCwG6ASp
         88pg==
X-Forwarded-Encrypted: i=1; AKwUvBz9CvlxvFcOg6R0ICMITRUp7ytnIK4hQzP0UZh2hNktJVc+hMvDCNJHtW1uvsIw1ztcNKJVtv0=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++k41I1Up5g8yH6v3TiYEbp5ty8wBFKcNAPMyqES6PrpTPbqNoG2
	wehHGJUheHpLbWNx56uVHOE82WbZluigoDke3pAo3JKBm/wZ6W7bUvlFeC3JM6CH3X5cAxTyyCK
	1aT0oZJX7tsiCNTx3m/qwwVviHiy2aajR4TI3odINeH9TxCe/X6pVgEpv8HKq4db2yOEWBnbK
X-Gm-Gg: AYBFou0eO9vVwKhKfuSu4osK6xG3Zqt83N2gohHbXKN3n4d5usFjJSMUUykRxoYVNVP
	6/yrCK4Ct6uvgFYrWLWE7cHNI4USksP0QpTyYvc6YxCwxLK9oqezwJXBrmM1C6w6GtsBVPPZ//W
	qCVNsSjMFWd3weYEuZ3OWYrE6uC36lBNxCIwEPoi2Zxvn2uG2Yt8p3VWr/Wt2QKDoywqFyFTgGE
	QyiSSigALnEjVY6i0P41hcfpad468tEkg1XCjrDOgGoTpPhlM52UADMNytPufnxBazwOz1lpEaI
	PZxqzTcP7Xw22xOZZ79rA97Q/mW+2VGCcvMPTXAszJU9/+wDbHcVrXwNE8noIozuN2hOtY9JGwA
	iIk1036HYDIrRlyQoXcFURu3M8BYJeZU=
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr5659447a91.19.1788341239440;
        Wed, 02 Sep 2026 02:27:19 -0700 (PDT)
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr5659371a91.19.1788341239018;
        Wed, 02 Sep 2026 02:27:19 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430e9eb4dasm8445304c88.2.2026.09.02.02.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 02:27:18 -0700 (PDT)
Message-ID: <54de34e2-cbe1-4464-b186-3ba242ffe3fd@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 14:57:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
 <20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97ebf8 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=3Mugy72lF2TQ84n-Z4MA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: QPGhrohNsjrEGMKsbuiSyXSDNc_dS4kc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX7LAxEP0h6USa
 meAyKZPzzPh+mxg6kgQjmOjPujmBOotzyLfCd5v/LlbGdwrQ+hvt9pL7fOO2pkGtLRcxZWAf6ug
 R8doSZF2lJnNoybtzFCO8TWzmHKSLzQ=
X-Proofpoint-ORIG-GUID: QPGhrohNsjrEGMKsbuiSyXSDNc_dS4kc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MiBTYWx0ZWRfX6DnsLbDKkNIB
 BG9RNcPASxozKRtMq2Ki4WC76nHtbbCOXsYeY9FTATVDtB2QdmANvjlhYr3lotWJTjpgE7R/eoB
 ysvyIeqVFGC3Nr2/cvxw4PiiH2vuk/qjexs5AqdAuYli2QasFfP37v9jqNiQQwKS8I4OkHX+QW7
 ucCvRJLcLsEet7zzALnu2lHivVrec/vdWXGtO9bI/D4n8n9JLZN9AAwFWdjL/pgoTAQhK6f25uQ
 Ra3C9BnwHtCXsEoqDQTAD0ClPxWs1tfMLUpEtxtBZKuptLIg0iFqJnno6LHGFQTKQkKvDeDme2f
 KzV5flHz3VAiXW/CvcBeLaVwlnQqdx5E1CbAnmLcSD6szSQht0NZ3wnLg9lWrSEbSLaaOZhmAOE
 QdcOgtbf3r2BgEDsfqnmNaf2jyr0ApUwnLHKkVYuOuTxQ0YV76Upq/aqTMvjMuY1Br7HwVreMi8
 5RHh6sg1GoTsvxyeaJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 633324425E
X-Spamd-Bar: -----
Message-ID-Hash: F3HSICRWQREYBXE72TEIQ3GNYWYMLLAH
X-Message-ID-Hash: F3HSICRWQREYBXE72TEIQ3GNYWYMLLAH
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F3HSICRWQREYBXE72TEIQ3GNYWYMLLAH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index ecaf8db67d45..888611b801c8 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -106,6 +106,8 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
>  #define QCOMTEE_UEFI_SEC_UID            413
> +#define QCOMTEE_TPM_UID			489
There's discussion ongoing in QTEE side on keeping idl with uid 81 and
not a new idl(uid 489).

I'll update if needed in my next patch.

-- 
Regards
Kuldeep

