Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A99FF8868
	for <op-tee@archiver.kernel.org>; Tue, 28 Apr 2026 09:21:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9F753443F6
	for <op-tee@archiver.kernel.org>; Tue, 28 Apr 2026 09:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777368088;
	bh=IcJ41p1S3Zzjw+o3gA1Mi9zZTLqegfsjHjcr7r1iJcw=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jCcoV6aK5/mE7yJKklnVTSckLBD0I4wfuj5qzd34i6dv8uVur9alQlLGRXVBGKYBE
	 rib8MYNaKK/n6C5t/Ez+Z9VYsYpThGGDNpCIaLyFbfv8tJeOIOhLtAoViCZYXHXhCZ
	 FZ4nneOkkFkMUdu4ijD1wVAcv7U0FnoxrFARGITzYLpmZkQUfVwKMv9JCW42R2waKe
	 SGR4OhDCqakepT26E9YtVr1cw+i8kvWRg93mdhS7GOAYkiimjTZ7Suc2J1hBb0PM7n
	 NqYcJF2Pb2yUlK/YlFQet0aHQBwO4rC93j4xbsApZupKs53E7ywwFEiwNPDPGG7SRS
	 WCPb7bK2MM18A==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 84A7043190
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 09:21:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J1rHlRNe;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=emNJ7EOd;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S7uuCX3968092
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 09:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uVa5aELi8oMy5IN5qMbJc9fv
	wjHh1VOUvgLucaocG9g=; b=J1rHlRNedvYMBPu+kQJFq8obDoBh6bHtsfLGahz2
	hlQdCu+A6u3y7mjNloWouF+t4ISvCbX70e/l5X26Ljg2HnbVteXVnmUdaj70LAwr
	Se5keSzn6OCCgB6kTKCD9qIvIHkO03HYe3XZFCyixRkDWuJsXVxeHgm9aT3NtzNN
	F9k59gi5dAEG//R2LTnCsJS+rxYudLoQgLQRrtgEkNzmE0fUyzlJ5d87WPw51qs8
	LHONOWUKvpSi3Cz+8TPT5HHrXEt22Nh/a6Bdr4yu4IjaazJ6ONe5swPbm4d13sx+
	RvQnHLtGk9d4RZtOgaZOHHVy6uWmbgG2RvD9ITkBdunESQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0gb3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 09:21:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d890580e1so156242851cf.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777368081; x=1777972881; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uVa5aELi8oMy5IN5qMbJc9fvwjHh1VOUvgLucaocG9g=;
        b=emNJ7EOd9oMqkCa08M3cMr2qk69f1B2FZuM+TWbdX/g77hAaOM02Y7JUevk6GtjYnh
         61Q2pwtCRX7mtTVpBf7N3zR+8aheXksW4EwcmexA2G/ALYWVm4pPAss+6wWcm6tDNWtO
         277NGhYhNeyzi4GB7HQkVY/ik2IfDTr+C5yAHD9gFi543PsaiEqiFzPTQ1FKEbS6O0ng
         M3UKCFkhteV0DdewGY1hOyCN8PFqz5BTmlMXKdxq/wEVKb6DUhlxES+lyOf3yb7AtYp0
         KWl4CsBiUJ4LwHwpsQ20Qc4/W24yYRemc5VtC8llr/wumaRTKPlsMb034twZdOr+hE0e
         O3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368081; x=1777972881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVa5aELi8oMy5IN5qMbJc9fvwjHh1VOUvgLucaocG9g=;
        b=WUvfO8Z02StOie+GAsJZSZqCqyoO18undOGkGMQe7zLrr0cK1Dr4VWXReAP6t1RnxQ
         THsmq7e2Q18hbL9lhwWfVphKiZkpOXsVyqTkUY/3fVddvDsyHBeDPTiTBJV5QWyLrwra
         mVWGEz/MbNL7u4lOCrGU/Ej81O/Ygimsjp7GCQJfhYHkbnaZ4WNELd6+XPXledGKI8lb
         wJcP9GKrmovGXFzkyehCf0DSI+xxtbT49BnZd1um/luDlvKtCOQ6a0Ko0DHvVTVdXS0W
         vwxOzxWGS45w7UJmq4ATgRZFSWYODXUVtoO9bcvuDjGx+h9rn2N2KyJFE1gXsECM2vWm
         8X6g==
X-Forwarded-Encrypted: i=1; AFNElJ+1mSYlCsMJkPW9it0zlpATTRXQOti7HwlaRcDZm4RW17fgEsEMVx4DObLsCjo1mhCRYPexpcc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzrR7kcBbr2jm1NuE2dLRPCpXpj3vNw18Xl2tBRfJyWCUtD83KE
	EBNaFIn7UEDYMmzIKM/b0GGYTZScksnI2TjsBZpslB97fXur5Y56xvHtOszkqDR94xOzbhXmaMo
	4qiFocuLfrh8vCxDHHLk21NxhhMdB2ETPNa0hyY/6Ddb/aXme92C9DGQ2zgbGC555CSG+Khly
X-Gm-Gg: AeBDiet5/VSBWjx+oG9apDLH124k0ZK40ARxHJIu8a3YcptS545gfmNdjFGHUMq3wvD
	vyHTxvNBoe9lQHhJQ2lELobZERNywDDITzgbIOn5L0z+65zBdoWHkVDuzEdVKIUWwVt2lCjWRHz
	4j0V35UkJ1+Gqd40EE3XupoDT/02lILRbk+VIQUdCQDTdH0Hi/AoLEkwfIukuP+gRfIiOJPQLsy
	NUyz9yRKW9je6vGx15PLo/9A0+z/hiGlgHLx0Lie7JhaLVHH1Gn2hyMjQ8Z/o/hn/GgHukKgDyO
	BrASG1yg2+HM5Ubd6UXcjqfSCpsUwCTOl8ebo4C1GqKHDZ4Djrwsm6aC1AIEbHGj29nsYpExwXf
	lo6gf8OUqdzOCgZZEinC2+/j/81YJFxAS/xk3OJhzzmJEt2EKzxIaIMTRgwKjD5dz7ePg5brClr
	YdBFePHJSSwD7k9ndhsgOonnvhWTeE11lu9jdmdR1w7L0QIA==
X-Received: by 2002:ac8:57cd:0:b0:50f:c117:1c52 with SMTP id d75a77b69052e-5100e0f6951mr26863511cf.4.1777368081349;
        Tue, 28 Apr 2026 02:21:21 -0700 (PDT)
X-Received: by 2002:ac8:57cd:0:b0:50f:c117:1c52 with SMTP id d75a77b69052e-5100e0f6951mr26863341cf.4.1777368080872;
        Tue, 28 Apr 2026 02:21:20 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a7462d5821sm470542e87.33.2026.04.28.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:21:19 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:21:16 +0300
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH v11 08/11] tee: add Qualcomm TEE driver
Message-ID: <ljfhoo5o45m3t5fsqypg75c46qohvszd5azcqxyjdcr5unx7ob@vcgip4yzkmmn>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
 <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-8-520e867b3d74@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-8-520e867b3d74@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f07c11 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=yhmqyPtzb8d5NndqWuMA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rCYptqGAXi5cwLBLcSbsqwOv3e3UGp0E
X-Proofpoint-ORIG-GUID: rCYptqGAXi5cwLBLcSbsqwOv3e3UGp0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA4MiBTYWx0ZWRfXx9n5vfAYkoUU
 8X5vpFBSVrjYCl7m/M3LnoUDwqQFH9YVCRaItwGG99TVe9VjSKFYN2SN4NplL17ZuNNKzMoNhM2
 Htoosi0rgDsQO9LLaFFSQnhiNLYgio6YCN0fQKIOb9qa0ib0B4nd5LQ5t0todnJm2p0IARX9zzG
 wi1Fo02L/bpJYlLe1vjPsPQ3/mUMBpC/ij5kHFIdCXFixnWzLbKduTZLqjJcot/cRMTR8s7XF5d
 tWAShlBRxTmlMW3gxqcd0g8yQKOD7+fisambGXx3Mece629G/dvOoL3a980e0TYSMJDRckhTs4g
 VptBdk2Hnqy+sJo9zRLM+DEFIlBwG1UsZZNaWheFOARTd72/6n2ezCsEPGG8TmVh4PMWMAMsJRZ
 DCQaCMR/RamvvGEbWiPnUIbePhGr+ibLlMAD0ynXcoKV1KX+xugMCHM4GF5FcuQ2sTLFyphj93/
 BuRV0ukTJTPhPSqeglg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 84A7043190
X-Spamd-Bar: -----
Message-ID-Hash: I7NRCLW3QATOAVDFOJT2WRP3BVSWRGPK
X-Message-ID-Hash: I7NRCLW3QATOAVDFOJT2WRP3BVSWRGPK
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Apurupa Pattapu <quic_apurupa@quicinc.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I7NRCLW3QATOAVDFOJT2WRP3BVSWRGPK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Wed, Sep 10, 2025 at 08:41:21PM -0700, Amirreza Zarrabi wrote:
> Introduce qcomtee_object, which represents an object in both QTEE and
> the kernel. QTEE clients can invoke an instance of qcomtee_object to
> access QTEE services. If this invocation produces a new object in QTEE,
> an instance of qcomtee_object will be returned.
> 
> Similarly, QTEE can request services from by issuing a callback
> request, which invokes an instance of qcomtee_object.
> 
> Implement initial support for exporting qcomtee_object to userspace
> and QTEE, enabling the invocation of objects hosted in QTEE and userspace
> through the TEE subsystem.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  MAINTAINERS                          |   6 +
>  drivers/tee/Kconfig                  |   1 +
>  drivers/tee/Makefile                 |   1 +
>  drivers/tee/qcomtee/Kconfig          |  12 +
>  drivers/tee/qcomtee/Makefile         |   7 +
>  drivers/tee/qcomtee/async.c          | 182 +++++++
>  drivers/tee/qcomtee/call.c           | 813 +++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/core.c           | 906 +++++++++++++++++++++++++++++++++++
>  drivers/tee/qcomtee/qcomtee.h        | 143 ++++++
>  drivers/tee/qcomtee/qcomtee_msg.h    | 304 ++++++++++++
>  drivers/tee/qcomtee/qcomtee_object.h | 316 ++++++++++++
>  drivers/tee/qcomtee/shm.c            | 153 ++++++
>  drivers/tee/qcomtee/user_obj.c       | 692 ++++++++++++++++++++++++++
>  include/uapi/linux/tee.h             |   1 +
>  14 files changed, 3537 insertions(+)
> 
> +
> +static int
> +qcomtee_object_invoke_ctx_invoke(struct qcomtee_object_invoke_ctx *oic,
> +				 int *result, u64 *res_type)
> +{
> +	phys_addr_t out_msg_paddr;
> +	phys_addr_t in_msg_paddr;
> +	int ret;
> +	u64 res;
> +
> +	tee_shm_get_pa(oic->out_shm, 0, &out_msg_paddr);
> +	tee_shm_get_pa(oic->in_shm, 0, &in_msg_paddr);
> +	if (!(oic->flags & QCOMTEE_OIC_FLAG_BUSY))
> +		ret = qcom_scm_qtee_invoke_smc(in_msg_paddr, oic->in_msg.size,
> +					       out_msg_paddr, oic->out_msg.size,
> +					       &res, res_type);
> +	else
> +		ret = qcom_scm_qtee_callback_response(out_msg_paddr,
> +						      oic->out_msg.size,
> +						      &res, res_type);
> +
> +	if (ret)
> +		pr_err("QTEE returned with %d.\n", ret);
> +	else
> +		*result = (int)res;

After enablign QCOMTEE driver, I observe the following error during the
bootup on RB3 Gen2:

[    4.720777] qcomtee: QTEE returned with -22.
[    4.725251] qcomtee: QTEE version 0.0.0


> +
> +	return ret;
> +}
> +

-- 
With best wishes
Dmitry
