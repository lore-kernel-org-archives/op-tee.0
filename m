Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5141BC982DE
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 08:10:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5C83A45470
	for <op-tee@archiver.kernel.org>; Mon, 21 Sep 2026 08:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789978218;
	bh=rKlnqLXl8V6UXo3u9TSsBqyAGh4ks3QBlOSYRYGHoJY=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=oDunljbZvQQ4VImwhy/Cb8SGIdCfFqZm/or/CbNrAv4dzruoGqFbrryleAao8dGs9
	 gf2Ea5G0BwxKEEUNXOmv3dFj0mi6Vuy2xEsF0L+ug3DWHpUF0GumEedfxm+apK+AvY
	 yxwkCMjcqaWHdfxN4EPz6Oc4PuRmzbuM9SjckP96hDluYqLWe6xKPPaLhgDvqZ81SE
	 ezFOAl7VQQwrgVVeVPha8J0lQoFANNeXkhC64Ixt+Fs7/jBxSGZX+y6PqfzpFJcqo0
	 MfXv9YiP2jmA7xwRQRp9kIGNn9LQdNJlaFpr60npT5wXMsQaAKiFbwOJ+Yl4KX+yhw
	 fIm7YFRoEo1YA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1CA5043B56
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 08:10:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lMrqFDRe;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Qqdw1S6a;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L79j1B4143023
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 08:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FQXQavybAGc4BtAZ7JoSR+X9Eu5eNUZkOTjr9bp+nWU=; b=lMrqFDReR8779C9D
	AQKv4bvaeZ4mPeMg8aKkm5C31aRWydJhwn8j4C+3oGdFGiLhxEoLIZ+tXqmRPO9e
	eDfIx6jaEt+7vj0fGCamyd2qfTLX8v1XOYDvpomzp5LLpJEdxw/DKi4a70Pn4laI
	dZu/JgalzJ1NqzVnYnImlIaOWX69bt2p/vJbDCZePk7VHgUakFUcNNyWJbMMUhpa
	IngfVMM807+LT1t7mHntTR105mkzcP7ae+uGQEhX8ZiuXKF5OCGB/gWr+Lqo+fcV
	f18dcMTN8K1Kk90U5qaOePRpQS+7hLwh4uZ2t6d9fou1WAUZpGpwDANOGI7ZUtO2
	B+l/FQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq87xx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 08:10:10 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cec4226c70so34419435ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 21 Sep 2026 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789978210; x=1790583010; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQXQavybAGc4BtAZ7JoSR+X9Eu5eNUZkOTjr9bp+nWU=;
        b=Qqdw1S6a3kY0aQhXDZVpxfvh4JlWn0TSlxBjxHpxgnGGvpzC8uvR6GR8iZlh3U534T
         yZvgNv/bMsQK8qVKVNsa75hsCzcmbO7Cq4u9/d0KT1XA6vy57HxLPU03/kaSvmx7nlI1
         WllcQ/ydObCDsf2Go4Go1Ae3oZqpd/6XH5Z95RCsZVCDZGd0zfYn/K73X0wD4Mz2eZII
         JnEx8BeSSQTiiPRrifF4oiGy+y7F5czSof8vF0mHEVAYqwGYfPw7k+F7Z6D07t/l8ZXS
         H29OPEQSlijDGbR3ZiGpahi4U7AwOXVjSnMyh/ZUkTWKXHKkpCXn7uBS4Q+SfjwZUCZt
         uVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978210; x=1790583010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQXQavybAGc4BtAZ7JoSR+X9Eu5eNUZkOTjr9bp+nWU=;
        b=mGXxsH4JB8+9eIIhtjfdqiLX4H75KhARd9xKRhx2tVQSTptKnrLP/D/BqF1lC4hPnK
         7yot1PVWRbXkacm1UWJDLPxjUiZVhhNpGc/XITaHne+7yyeV1EyoQsafXuF7G9JopK1h
         4N59cCA42RoRNdcJMLcGUZefpMZ/SmDQosSd7ywueH+kefhG2XJdtSFmp0OIDam8J+V1
         SnfkBSP50pOrOCQWOgjbGBWmx4eydek2vsVv1YjyD/1Hn9nWFhgzdxTmLzDE7uzpSZic
         LKxLf3OOkHDxTucTqJx+XU3LqX+MjZwxWzfddacI6TzqhdUJBNpYvVsBCAJd6Fk8uzeV
         0ZZw==
X-Forwarded-Encrypted: i=1; AKwUvBwaNJwzZLQpadkpW8aTUtxkK+K3FxKAjlGkowEHNVron6HYxnvTeWFF4Few6L995J096XhpfdQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mofr2WlNYy0jXpPQj2Q8gfMudjswxk/pPy0DJd1GkPXJya16mi
	wyfPgwjCCpv6maT628sLVn05Sn/4UXWX+DMh1coFzPY33/AxXzO6uMaVj1Al0ZOVZdeo3rb21oS
	OpVX+rK9IXdXX7H6Yx9Q+R2CiHIpv1DdnOTqVR+mULpD17kyUJMpGUkvvCKxWSCAdKOKIDieH
X-Gm-Gg: AYBFou1+a1jLQ2HZcplBE2unbXw3+4oY/z8bVrV+wJhTL6+L1teFvEOHt4akaZwR+mo
	I+w85UjbFSPBkSFGmd/Pe2wh1CZ8DO63owAGSJ3meCfhc4Ul8BEwXNFskPewXerjlihMoGzsw3+
	zoVx3KtSVUz75pW4rISmiUHtGWcmRa6U4aBYLiaopGgbZCcsi/b5Mpn7ORZoEG5Fd0M94ZsxKA+
	toWI+nJRfHyLM0OBQDN0VXoT5248eAq6oD9KXRAI8h7t2uXH0+H1I6cg4A972eV61C5LfY7RvQC
	rFF8Jm/5a2snbMAl14In7BeHKiXyAR8584jwiMkFyMzpxPo97dv2YqzJ/IZUUxUN61mvAb2XrVM
	Du0woL+phzHo10NeKCfnGyJPjO11CPw==
X-Received: by 2002:a17:903:26c8:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2ddc0ffe9ffmr83871325ad.64.1789978210202;
        Mon, 21 Sep 2026 01:10:10 -0700 (PDT)
X-Received: by 2002:a17:903:26c8:b0:2dd:c0ff:e72e with SMTP id d9443c01a7336-2ddc0ffe9ffmr83871165ad.64.1789978209832;
        Mon, 21 Sep 2026 01:10:09 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3313d96esm17124286eec.12.2026.09.21.01.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:10:09 -0700 (PDT)
Message-ID: <a8047ec0-742f-47f8-b5bf-cb1b32f06bd9@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 13:40:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
To: Jarkko Sakkinen <jarkko@kernel.org>, Jens Wiklander <jenswi@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <20260907-tpm_qcom_driver-v2-1-71a6b1752da8@oss.qualcomm.com>
 <aqyX3lJ1eNBmzbSP@kernel.org>
Content-Language: en-US
In-Reply-To: <aqyX3lJ1eNBmzbSP@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Tk9E-5ZhdYDmbG-bJq4O-3XN9H1x4Y4p
X-Proofpoint-ORIG-GUID: Tk9E-5ZhdYDmbG-bJq4O-3XN9H1x4Y4p
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab0e662 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=kq3ZzjkpYTjXZhaqunoA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExNiBTYWx0ZWRfXyBgHas0QRkvu
 wNjxP5CcGulBj2KwxmDCo6ta5kFv0ZV2ziDSnnrOrT5F/CsrdK7XXa3qYe1sADZ4xCpGkojSxJ+
 CM5oXD9cMqxbMD5o8DVHOCxL7Zs3LrukGI2dOBeJ3p4xYtPIn1JakpDw/WnKLxVbYPwQYYQ0Evu
 8NNi75LmqKyVGEYbfdn7SQ/TTchPJyzf07R7+XNxdUMJY+hChyUWeoXlY9NeMSpbRV5BMGJPcmA
 Qz5np0nwn3s6mrFyeKtsPK2v14ova1xeh3duWdkkNuQiy64eomBFBM8wMhE1LEwfgIMr/wyoO55
 lCwofjqd6xo7I5+gjdkstlOD8FeyeYH3nnctDq8FiCRl+4uiKn5VN1Yt9SdGqk8AQxVzoypcigI
 fYF9WwrN/0tuAyBVVMCom5xNNHpPGNjBwjefrA/PkqUxdwBtkgiCJbh7YpwfSRsp94XYpuyasDy
 amWyhSPHw8NOtTvK2uQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExNiBTYWx0ZWRfX35qTzf88vbMw
 c966iK6m0PbpjLYR3DbBk09ohuJE+nag/FxqcVOFGnS7MBcbS8GfOea0Unucopcp2932Fimd2MD
 9/7wBNQr2s91uXF7y/BQ0GIwb7IBBhM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.37 / 15.00];
	BAYES_HAM(-2.37)[97.11%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1CA5043B56
X-Spamd-Bar: -----
Message-ID-Hash: 3DLIVXJNLYQHNJIKWVZXRYA2TEIQ4JQL
X-Message-ID-Hash: 3DLIVXJNLYQHNJIKWVZXRYA2TEIQ4JQL
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3DLIVXJNLYQHNJIKWVZXRYA2TEIQ4JQL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 18-09-2026 07:16, Jarkko Sakkinen wrote:
> On Mon, Sep 07, 2026 at 02:58:41PM +0530, Kuldeep Singh wrote:
>> Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
>> is enumerated as a TEE-bus device, allowing a client driver to bind to
>> it via its generated UUID.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
[...]

> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Thanks Jarkko for the review.
Can TEE maintainers(Amirreza/Jens?) also review this change?

-- 
Regards
Kuldeep

