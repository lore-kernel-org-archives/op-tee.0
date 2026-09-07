Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFC6C79F89
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:47:46 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 72EBA4542C
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788774465;
	bh=6SspYc/M1jCPep/6JTqdwpr6N1VKzLwAITB+4WnMG5w=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LuENPZd+Z73+u5/QzfZIXL750JesH9MgyFtsfBrjYrn3VVUEQGhAOlRULNW0bYrS+
	 /IQPBTm9GzBYuZikbPv5OqJuUt827fLeAv5u+z+J51fwpOpnazfD1HS+EMAbP3ApMx
	 FWo43kgeYGMevogtPq1oYQwM8YM3LTYs6nk3RCzsDfDCD8P3P42/TRtlKtbzNLcdHK
	 HZdHbIt88JlThqKskvQWGyOnurcs5oJz3Wn3s37ymZFVxEWZMMoT8/cblO18DiZwsv
	 9d0c7ev8fIqHOa3qJk/j4g+YwPWBZidveOmnbaAIT9ycSDDt2SqSStrUpcN/9O78+M
	 jqecceJn0SRAQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0D39544462
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 09:47:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Gj+S71mA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bqA/oROW;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879bWua057353
	for <op-tee@lists.trustedfirmware.org>; Mon, 7 Sep 2026 09:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NSadxso+8kCU0Paycvkt2KDREp12le3ozz3U7BFkz2U=; b=Gj+S71mAQ69L2o/N
	ZE/ViHnpWzSoj5C+vJFAzglZBg6pRF23n1mPCVVbvTVfPazGvza413Irt38EUZg2
	5SF4plzNgNmKK44eE2SA+zQ0T498d90bHtNQUtpPcZmi52TzQJdLMGE5SSKowxTC
	6EK7VKPDFK96WDcgU8WwqfJ1NHBU+pK1gc6g+OR1RTr+PiI36tUac25r6jyumV/B
	FhVhz+n0vC/gHIfjh7rb098MB73VTjeY3Wj5dc2/OuxRzvK5opyTqXmRZwJffiFN
	oQyH4VdQDkdp5PFSmP63BMTwwrOyznMaPIuqgqTrjt2p2X2EPtfxuufuoE0wbwX2
	OLR6Lw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtdqg5th-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 09:47:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6f80c76e6so66119675ad.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788774457; x=1789379257; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSadxso+8kCU0Paycvkt2KDREp12le3ozz3U7BFkz2U=;
        b=bqA/oROWmHdRkHsBl5Znq+07u7fHyvgbS3Vrj6FprHsNEM+H8dQxA7Uj/r6sNRGOzS
         VNaqGfrba2dPo3lHC9D8Mqt65N8/2TOa/oKDCIvpqmmnw/o9WWpW/u3SgJ2AV9csVU7y
         BAxHcDwbfyps/JWQxMZeNjPCJAikh9N+0sNZnftm4VCLisB5YwNa4930UGIC9hxcwfj5
         +HvuWT1jOY3R+8OhA144HGzV0+Ey6D+1ipYyd/rBxMjPLTrm3wkZlwVtwPAQlNXkh3AF
         yp/Ur/Pj1piEk7iAJ7pgKYtDhKm73SEyqJ1n/KDlXoBQkglBrHz0AdUUbFcpbllALBgQ
         5kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774457; x=1789379257;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSadxso+8kCU0Paycvkt2KDREp12le3ozz3U7BFkz2U=;
        b=f92GrDsmll2PBAc6GlAEHrG9eyzs962E9/fy9uLHkpfrYYozG5XVFPqsBgl8xAA6Xw
         VNC78yatFJtZPoyfJOvOst1vwGx1KY/znlE9D/H4pBvuhjDok4+fW8yUcLmAhUKu/18p
         SBl5CgoMfvWYW0cfL1n0fbNl8/4KTYCXMjN4a8b/p9/M2CQgn4BkP5MjJZq7sZ+g42EV
         E3peM09Ikvy+adBQErJA0DXsYKowTIFmPhDgmFfOOgq9u/LqoRY3htJP00UYD+9Wlh+j
         IZa3+SxnAQiOkGjKhXEWDsS58zAqlwkcDTMr3SRL0+pv/q/+7cC2WQdZyaQIhkvPBry2
         J6Eg==
X-Forwarded-Encrypted: i=1; AKwUvBxVGhOOGPrw7k3kVvmslVzUZ1DkPJUpY/IsZ0N7VplTnWkPsLg7ZSo07f8zP65eApKMk5i+OXk=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kxJC0J4Mn8xtl5AxmaB2qZzBsGCONDR39gx7S34xNhTnbTydQ9
	DFY/Nowz/8t6k46YkSYs3Sqz7bkK0JqWN+ZuKmP4K0FLNdWkLEiNUKyWFPblzIBsQOxgg5GUpyf
	D0pqqrzuuShufMFA+l49RzY1m7LTCr18HlbtjuQZKrSLpysj05im28SWPHM8Ni6qbl96JSnNz
X-Gm-Gg: AYBFou2zd4P0rHUn71tDIyxN6jMdddUvTziDHiLjrvuMRdNH359Uncqg2a4tE2iMS71
	XN8zsbT8sRKQ4yhkkd0l8bUUA6ve9zKZ/xoQfgChw3ZRI/oWsKLfAidS2h3joiFRITyfSUkVQmH
	+o3XwVXFgI2truWiPMjJuoDLq+2r3U+pMVM85I6bAx80CUohCkc/8bXQFntapikdFDg7rRbt4mW
	Kb1ZJXrD2T67jexMdwfH9Nu1I6ZkjGHakMQzb4ycBguo0eW4Dx1L8sRMGiC3+T+K1o3oTFWIUYn
	uJ52drRYAkcFwtZ/VVvx4d4BSJuRHo0P6Mm2sDMQTsTO1wi9Cmd/hLiXIFlxaE5Do3zE7TsB86V
	YUKwgrBcf+Y3RLdrCZr/sphmS2NS+1QE=
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr37063426a91.11.1788774457555;
        Mon, 07 Sep 2026 02:47:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3a50:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-39b26101576mr37063367a91.11.1788774457148;
        Mon, 07 Sep 2026 02:47:37 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435ec2bsm23169442c88.3.2026.09.07.02.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 02:47:36 -0700 (PDT)
Message-ID: <591315ce-37d0-40e4-8bfb-55206578f0f4@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 15:17:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add TPM support via Qualcomm TEE TPM TA
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwNyBTYWx0ZWRfX3sI1STWgTX+X
 UFQhwKSE9uVsULNHts4xx8l5CRI/smDNO8c+JchReCcfOhyNgeLdtwLivnLvowLY7/CQDpUl8gM
 YlvKNaRQXvvC436v1ls6naXJIrtGj/ig9o5OCif8cA4qm6w6JmdOpMSJPQnUl/mdSXelq/wIaM0
 ZvMutafPJ5iLJuqlamNDgF09jnIX+3Sb91JdUnxNTMFYdoijg92/SczteyYYkgJz2ooljwm8Ryn
 eGls7pMBDh10r9C70QS9w7tCYXHi/n2L9zwyFrUu5ns8PokcGrT31fkwXjQLiZSY7LUxt9OTi8F
 h4EQG3/Udni1jI7hDMrAus0Fcg9jltpLMIejejJm4FNZ220liWmh5+uXjIwZmW7Pgk3eB+t3EIw
 21eZlt3T2Lk4NcPTS1E49FSFKNRmBUo2FeMMELLhGAm4ZVdXvj9JZOGxXUfUMSBXZ/lPqd1BTaI
 w743Lgcv5HBd7U82lTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwNyBTYWx0ZWRfX3QwbL4uSzBCV
 TsRPFwX2gjs/CyAi9CubCdcoQkI/NIAcXD1Jd5qk5OWEi3O0zsoC6ThjEORQg5RnG33+QUTHOkt
 TUjzns3JwTRytO2mGRvhfUY4i/PsKkw=
X-Proofpoint-ORIG-GUID: Q82wCOWxA2QnJx5QPrD10gZPCFXLlZuo
X-Authority-Analysis: v=2.4 cv=U6aiy+ru c=1 sm=1 tr=0 ts=6a9e883a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QTb_0JKWY7oM6lVZCfEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Q82wCOWxA2QnJx5QPrD10gZPCFXLlZuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070107
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.98%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.214.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0D39544462
X-Spamd-Bar: ----
Message-ID-Hash: INAVQ4QWBHGAVBGAUOAFZ62PK5JYPM4G
X-Message-ID-Hash: INAVQ4QWBHGAVBGAUOAFZ62PK5JYPM4G
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/INAVQ4QWBHGAVBGAUOAFZ62PK5JYPM4G/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 31-08-2026 15:12, Kuldeep Singh wrote:
> Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
> a non-secure SPI channel from the kernel. Arm's Base Boot Security
> Requirements (BBSR) v1.4 require that access to go through TrustZone
> instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
> fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
> Execution Environment (QTEE), which talks to the dTPM (or implements an
> fTPM) on the kernel's behalf.
> 
> This series adds a kernel driver for that TA, built on the QCOMTEE
> object-IPC transport (drivers/tee/qcomtee/) already used to reach other
> QTEE services.
> 
> This patch series functionally depends on below(patch 5/6 specifically)
> for qtee service discovery.
> - https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
> 
> Tested on Glymur-crd target with tpm2-tools utility.
> 
> Validations:
> - Get capabilities
> - Random number generator
> - RSA key creation, encryption and decryption.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Sent v2 for this series.
https://lore.kernel.org/linux-arm-msm/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com/
Regards
Kuldeep

