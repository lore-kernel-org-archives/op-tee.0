Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA939FCB61B
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 309C4438A5
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772811633;
	bh=Bt9Qa0S7HuAqxfWE+5XT2Me1HGCFa+NbCGCJteZtnfs=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ZeqxIRcLjpyFCNrrpCipjS8ssR2EuhTJzT2bgX6lj51Hj2XGJApHnnsxIwwufxRW/
	 b1ab0VO/Stj+i+B0HyvFr3KQS8U+D5WbWOuq2QrWInCDe1L24KdqV59cWck4YhoTgr
	 4W10HIWPL/MIkrdrlkEa7csHfJlVbs6rbrdhZHXtcKV02vElDZmW/eM2258ppqMEOX
	 V8YRWfL1aPAic+qxjmDnmDdaAaSjTDqn9y3lrpaHrvjHqiPSHYjtgGWSyEEFZnCr9T
	 v0jkMsi/E4o4Ebj3adz+AwqvAS0zzhtqTTxAG5VbY7sa8ih9uBdtKppc5SAttfpMoH
	 Fjt36DeFZBkKg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6B3B3431C3
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 15:40:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W3mV1Ri4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BYAx1AwM;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FTOOv1687713
	for <op-tee@lists.trustedfirmware.org>; Fri, 6 Mar 2026 15:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wpH7c7MyE5oMPFius9rdgPXUx1Fgj3bT2b7iRgr/UYQ=; b=W3mV1Ri4C0Kr+8NY
	z48jIL/Lo5XCeSg8j7D2tMGiz+BixeS5WwAv+77z6Xtmt3pR8njgOFeAZk6HFWcR
	Oe0ZKlLov/jk7pnvYIKXwyH7MfJKbX0HuZ2GueDvAeOb6k9QaQmPqWmOKdAR59pn
	xQjhDSAc5fiGNCDUU7FsPAQh5WM+mj27lJKEClXszb72kWsUAoqrv4mtMbX+Efv/
	m17Hp96OLfYiwK9tX1eSetYWiKUrZXXbobABTIeAuNZmIx4touC45LQCSaHPVUyp
	yRgXXe4KghrLLTAyBzGs+Hpwb/FHWFSoJ1U6gIwIWeqQFSbJtg7+w8atgfY78i8S
	x/xrPg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqx14gruq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 15:40:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdd327d970so4373484eec.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772811609; x=1773416409; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpH7c7MyE5oMPFius9rdgPXUx1Fgj3bT2b7iRgr/UYQ=;
        b=BYAx1AwMuqqyv/DBAXjwGSm6E9d7kx2qipB2gcUZHHErtUkz4iAfu6XRlDqCFK/Z9L
         1yHPyEG/PKUQVWZj3Dh+zfhjnlFIN1al9pp9Hg3Vqt2gHYRlUVIvSpyTdPO9qZZbEzSB
         IQyZFVVe02Ep1dD0QSyrHn8wQe9DYF4Z+vs2O8X9j5WpLMLY2y2wv0ud4EAySuVey1es
         i9cdp7guW7Ta9fAFHZwJ8aeFJwcauNcBdaE45Ri1gTMDc2S5Lb3BqcHISpCqR1NDm7Px
         woGmdPunfRkD8qm8ZN9qfHtG14BlZ2FzfhWJtXWCxE+ANQCDpgdULDr9L2vtAArdJnrq
         divQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772811609; x=1773416409;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpH7c7MyE5oMPFius9rdgPXUx1Fgj3bT2b7iRgr/UYQ=;
        b=qlUlXaPJsJNbCQeh+MtrLPVwdmmM+f5G1aEGFk3TaxhIeWEjWfBW1sqcXK4JcEBEXW
         ec5w7ToqGGBYXyqEKIV/nD875tkLDn5V22yb8ULXjb8aLlvFLZYUlydUB0GeSL4fli43
         4fe7PcnNPc5npCLatwM+G8inesR/F+X1oaVFnot+ktoJ+YkAv1MOqtDNsrIwLsJPXsDT
         U1RTo6GoXcCGbye1OJns/p4cLAGW/yKSWkGACY1Lanf93oY5INfRQKc9bRlMC9/HiPXk
         m5tTb4Zlwn/nCFCfDFI3h3vUMKF4FwL+BJ5ntOmkMxd+eB1fvNa93vXKzlaz6MJuNc77
         u4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVe3Z3WH5F7L3dBSnKcRiUKTYnwIuSravNBWJMoCwAj+uKrNsm0MstAdLdQuetWcqkIUNUfAg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxzjhP4L/YTZVS1FhTHpXkKYjPMYLRU8rPWNpjwQg/wd9wxEzl0
	TeDYiZH9A0FEXlBzT8A2De88D1QFim1U5KzYcC1MkwDiZJfo4+tOFMzkGvs9HMRHGYIOiCL6oCb
	z/ktLishteEV6QaSo74I3D4/dtjNL2PkbMhZQ5BT2ofObs2S5OWplBPaYuO3zvrNVePO6RyZh
X-Gm-Gg: ATEYQzzh/ifX1pzxrpNaXZrzbB9dd1h5ncUZUV36AHbH6dbZKPGUcajD7jIBKl85a8z
	HK3MILdxnrf21XpgFM3OT5Yc4M+yn8oj5Go7DWIu2mmr6F/13A4tV3UYb005uwvIIs1pgYa0fjF
	1XsdQ7ykooDDlfQZxuo2qpLQwxrXvpJmA7KlRAA73qCpjA9sOk1u1UcReu3EmfpFrRtJ7VYMvKc
	lNmqLoCF9rDtAcrloCx9wb1EAJw6K35Jia90eOnWtbb+NhnYEWcgMZQjRv03Db4vTfT2LTxt24w
	2aBsyGLKZdGfRMDbOIDZCFtr2qqi/xZN4X6VMmNbB+KS3vXH/zRW04gupreiZO2NlfZpLm8q/U5
	lZI6bUXH3MeG8UniB7rhF9LG77pOmydDYYY0buuG6vaC56md6eNvlbkamPHQdfcOvCA3dtsBRgR
	M3ncm1XDvXGdqnVA==
X-Received: by 2002:a05:7300:ec07:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2be4e56f9f9mr928813eec.1.1772811609172;
        Fri, 06 Mar 2026 07:40:09 -0800 (PST)
X-Received: by 2002:a05:7300:ec07:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2be4e56f9f9mr928768eec.1.1772811608557;
        Fri, 06 Mar 2026 07:40:08 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94833bsm1356612eec.18.2026.03.06.07.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:40:08 -0800 (PST)
Message-ID: <9741588f-e6a1-4749-970b-3ed814399a32@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 07:40:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-media@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org
References: <20260306105027.290375-1-sumit.garg@kernel.org>
 <20260306105027.290375-3-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260306105027.290375-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NiBTYWx0ZWRfX/E3YD5jsgEhc
 sx3ktLB7grz8j+/EZ8CF4zo4eC7wXSr04iyuhanjGm9/1D8YBqxDkk6Zw4/agO03/bNE7VUsLQh
 2HgqtYCZP3FEhXbslBQowoIqTYiFW6nMbDxNryUykDOfDc4CYAXqDANWcXC+fpdLYEruiv2Rdtn
 59s/B1Z+KdyIZ00QLc4ucJaEn11+S/HX8EsbJ2UbEVRaLmfT5apqJ96wUQsdPBC888q2FHiKVfH
 guCKNKsy1IFOtN9xnjpFGrCIXAZI5gOQjhJlHn3jOke/CqNbRNQrqpMbv5swOMmbjRrZZFX7cwi
 Qib2DGOyA+PSOQ0nWiHfqj+nTNAwXUm5/r4v4rjD73yhO0DMi4O7CCF6a2Lrars825/WrSpUWLo
 eT6ao5IdYCnJTloMz0DqaRT5yw7Cjd01l5f1TSNfvK89zBwfWxQoTRCPSoThuVBPazSMITHY4b9
 76PMkHzAj2sa3Ul28eg==
X-Proofpoint-GUID: WCfVWUPiqIjFj82QQUqD8TEkiNPJ1Ofd
X-Proofpoint-ORIG-GUID: WCfVWUPiqIjFj82QQUqD8TEkiNPJ1Ofd
X-Authority-Analysis: v=2.4 cv=e/MLiKp/ c=1 sm=1 tr=0 ts=69aaf55a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=40pWYZonmZhD7659SdoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.199:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6B3B3431C3
X-Spamd-Bar: ----
Message-ID-Hash: ZAEZAR52BANXVN6XROZTW6CVZKHCCCY3
X-Message-ID-Hash: ZAEZAR52BANXVN6XROZTW6CVZKHCCCY3
X-MailFrom: jeff.johnson@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZAEZAR52BANXVN6XROZTW6CVZKHCCCY3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jeff Johnson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

On 3/6/2026 2:50 AM, Sumit Garg wrote:
>  drivers/firmware/qcom/Kconfig          |   8 +
>  drivers/firmware/qcom/Makefile         |   1 +
>  drivers/firmware/qcom/qcom_pas.c       | 295 +++++++++++++++++++++++++

kernel-doc is throwing some warnings in this file which I've listed below.
kernel-doc is also throwing warnings in some of the other files touched by
this series, but since those are presumably preexisting I didn't bother to
mention them. Just want to avoid adding new warnings.

>  drivers/firmware/qcom/qcom_pas.h       |  53 +++++
>  include/linux/firmware/qcom/qcom_pas.h |  41 ++++
>  5 files changed, 398 insertions(+)
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
...
> +/**
> + * qcom_pas_mem_setup() - Prepare the memory related to a given peripheral
> + *			  for firmware loading
> + * @pas_id:	peripheral authentication service id
> + * @addr:	start address of memory area to prepare
> + * @size:	size of the memory area to prepare
> + *
> + * Returns 0 on success.

kernel-doc complains:
Warning: drivers/firmware/qcom/qcom_pas.c:103 No description found for return
value of 'qcom_pas_mem_setup'

should use the kernel-doc Return: tag

 * Return: 0 on success

(Returns: is also accepted although not documented)

> + */
...
> +/**
> + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware
> + *				   and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return 0 on success.

hmmm, kernel-doc didn't complain about this one so the script must accept
'Return' without the ":" (but not 'Returns' without the ":").

Suggest changing to Return: to be conformant with the actual documentation:
<https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#function-documentation>

> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}
> +EXPORT_SYMBOL_GPL(qcom_pas_auth_and_reset);
...
> +/**
> + * qcom_pas_set_remote_state() - Set the remote processor state
> + * @state:	peripheral state
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns 0 on success.

Warning: drivers/firmware/qcom/qcom_pas.c:217 No description found for return
value of 'qcom_pas_set_remote_state'

> + */
...
> +/**
> + * qcom_pas_shutdown() - Shut down the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns 0 on success.

Warning: drivers/firmware/qcom/qcom_pas.c:232 No description found for return
value of 'qcom_pas_shutdown'

> + */
...
> +/**
> + * qcom_pas_supported() - Check if the peripheral authentication service is
> + *			  available for the given peripheral
> + * @pas_id:	peripheral authentication service id
> + *
> + * Returns true if PAS is supported for this peripheral, otherwise false.

Warning: drivers/firmware/qcom/qcom_pas.c:248 No description found for return
value of 'qcom_pas_supported'

> + */
...
> +/**
> + * qcom_pas_is_available() - Check for PAS service
> + *
> + * Returns true on success.

Warning: drivers/firmware/qcom/qcom_pas.c:262 No description found for return
value of 'qcom_pas_is_available'

> + */
