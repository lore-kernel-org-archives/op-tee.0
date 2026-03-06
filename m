Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3082CFCB618
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 15:49:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7585D4389E
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772812172;
	bh=HltvsgB/V32MMRgrH+wmQKGVLrI+i/tqgjQTY4Hm9Xk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Mvx7iXv2jGjOaQ7AeMuhHXbUftr68bQirfseWuuo2JacyrQAw5OcJxPu8G31bp32Y
	 5KOliGaViQ8E3QUS32p4CbdknMs2dvD4UAuNGhR/IrnEpiHk2IR4TN+NZF16Z04TA5
	 xxRqFoPHQ9I59lycu2Oxi57mopyk+VVBXlaqFDdj4gjFjLS403bEAzoiHfZ6qZ1su4
	 GVxp24S4TyAdaSGLomWQlqYt6NHH5NKhSx8G78YPlRESdMrwKaAtjeR+Ah8xYtMLCk
	 q05gH20k/quTEqfodBInKUFBOwJTmyB5Na68TrnghcmMcqmtKcV3DtSGhLkLZTqiCY
	 2B+8EGuolwPVQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 52FBF431C3
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 15:49:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cEnu/OnA;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ni49URdk;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626FT7BK1953692
	for <op-tee@lists.trustedfirmware.org>; Fri, 6 Mar 2026 15:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=; b=cEnu/OnAC1cBRLNl
	4oQ9YSwsZrvBAX9vdKjIs9IzdOxhYHFFQ0EAkTpagLjsb1DfxR5yMosUQ3mz5pDo
	S0lStsQEKOV0jFVu6gcYfnTboyaow+s2cJOaGYaQfpvaYF+RmDLZPh/Ec3Q4HHzL
	Z4ms2RHS4O9mHg1ZDJsSdiKGKAVEjPMiGp0rVjpjmHAvTmzI7XmKLHrZcEGy0R4O
	1Pn0H6H086qujpi/XmdmZdKzDTWEaQZJn0ctv0+8fOqWxpWuTHXaPT4sSIpbZi5c
	jEt096fLWsPp3uPV3vFuKCWSlMp0pyiUXcI3mQVepsO1b163WXom9joVA8/cXTl/
	cA1vHw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqv9ah6hq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 15:49:11 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1275c6fc58aso17579837c88.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Mar 2026 07:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772812151; x=1773416951; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=;
        b=Ni49URdkJTVYjJBsO2uRmH688r5yIOaiHKUQhOS6Y3Pby0Iy+b1FhuB+BtCqdReDj6
         HaLP9wHP8/KxPv6uD2UpOUEsT5c8gJlHddq4gtUjhvnuL+OPMAmmr9QpxA4xZMhekBbu
         sEogOqowwwwM2qrhooROLJzsCsVA8lffv1dfvaKgsAb/Ir/V89d3ypwFI+kNDzRiRaih
         2q0QsOcCjAmLTPWziDhGV2nbe6W107JV3P+fqbS6CsMYRFJpK/SOFiQnrIGxK0LdKM77
         16sXgIBStK8vSP3tNmPO3x11Yi3uDLDYfa9vxf9WBfsA0ji2o85JLTIf07rL+VwEfsCl
         o6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812151; x=1773416951;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/756cthtUIgOJKo1UJZNjKGTLA8f8YYmW1bpSBDIWY=;
        b=tXgfsGPXuja0Kfu3+NI9XHkIXziaFXAu+rDEXcd+PZpVTF4JOVwIe2A5GsRyWqKIXB
         YwpaHeTReyNwlekp4QhxneOJWqkace/lhOr4hNcuEe66FjqybHNaKXs7z5Fl/E9wVUVR
         QgbkoH3x5A+MJUS9xL2HB8Uk8aK/WoJe0T+nmsWZWgweiTtpQOrROySsYc4X7RxPJtc2
         bYClZF02eEPprLcp+SuURnwQd6C+uGss1G8IeQq0t6JNtIRxB638swiDSZ68kKnlhq9u
         SM+n4/cCuw4jwPtUJ1O90EDJ3AHr6W1u/x+XwgiIuTph4lKvTZQsbhrqK1v35mOsmk9L
         Mu7w==
X-Forwarded-Encrypted: i=1; AJvYcCWyjNaOaFvZ5e5EImMS+svxc97YH8QELuw1iLj1ZCrz6QvQ+dezuMd5MIUivskggveKQTvOs1U=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyZ21qbQA6hdn69bMp0wUiRtILKajZFY5YBKcrV2wQEN7fXYakd
	OiVwYnCPNn/Zawob/gmaj11Asq2LJx3AEZPFdT2W3nIM7/DNCTzNx0oIHwFIkwX+NikUiNs+I3k
	mB0Rp/t/y7sAiwGS2t/jJxWaEhcMFrbHBX12S/79sxx42B/hgG2jEhxh6VIFMiVmoSLOw9fG9
X-Gm-Gg: ATEYQzx/0hfG6xEq2J6G6UcbAM5CxdOPm6Koj5D9BiW0lmEQpDBFewqw/+WYY32Ulqv
	056ivzCGJAyVN0rwVQoiJseq60HFtmBQkakiXFRhhrylyEvI0C7whSmhbcw0OsEkeOaRHck4OpY
	N4ScVSkjuDQkalN5m2+coQTejgdnKspLv35D3p01k/uoRm1nF/eWnrvS/JCodGaSh3DTP0SXopC
	zBJC4cPoTREWnOQ1p9QQ7ftXvUvkKiJ0wtMHm/pBgHNbXlen2dbWAsmfdlSRsq594g995tG8+ug
	RYeWKyJGK4v8pXGwlofRbKQ7iKESb7ekcsG2qcB9PlDfmVmutQsC2TqW2BuWQlkN7yZl+tFyXwZ
	h4bMB6+hnfbqR0kNWpUv2JmR/FN1d9fZWLWnqU4xQFybCcD5ZDcm9gvbKFRgeAYXitLo22O8+wd
	Eks2ZRW0mqvEXp/w==
X-Received: by 2002:a05:7022:6898:b0:11b:e21e:5653 with SMTP id a92af1059eb24-128c2e0c967mr1056287c88.19.1772812150847;
        Fri, 06 Mar 2026 07:49:10 -0800 (PST)
X-Received: by 2002:a05:7022:6898:b0:11b:e21e:5653 with SMTP id a92af1059eb24-128c2e0c967mr1056220c88.19.1772812150163;
        Fri, 06 Mar 2026 07:49:10 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f58d24sm1497977c88.12.2026.03.06.07.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:49:09 -0800 (PST)
Message-ID: <00a7e65d-aad3-4029-af51-ff0870e65595@oss.qualcomm.com>
Date: Fri, 6 Mar 2026 07:49:07 -0800
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
X-Proofpoint-GUID: srSGoiAB_USlf9YA_ZA-0YGWO1oahE5A
X-Proofpoint-ORIG-GUID: srSGoiAB_USlf9YA_ZA-0YGWO1oahE5A
X-Authority-Analysis: v=2.4 cv=G4wR0tk5 c=1 sm=1 tr=0 ts=69aaf777 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=PJDN-9afRshu8rMoDvAA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0NiBTYWx0ZWRfXwOYOgcyC1g+p
 39Q53PBzKcAfi94HBsFN5P1GPHftdwijSs5dhFExWy2bBDAT3eBZ1NtogavH3J5/S2jhD5QF+VR
 ghalnpaAWKJ5rlNvjcifpMw8DHDSZ7lAWgyZEr9X/xDuFyu4JLbUk0OnUrt56QIdUNIRimoy+C2
 n+qH9MGg+JEtoO8tO2aykXqJjd9skfnZyC5aQr3teRiydXuw0fpTp0SBehnhs6qCm2J7LsGlYor
 dcZs3jnLBS+26p52KVIFlogQY7p4bl27K9E2Gl85QtpYkNTiyvfH0/gyHuW8st417ZatQUc6Pwe
 EXWebfPg4G4tfx5J/+3D0BY2avEuAA4S+dWKg6ky+Y2ahs/cWTWUjzhveogmLQlnF9bYrwn6FmN
 mgVXm94WTgjbzXzVWJ45WGVV4Ea8Lp2yXlwJVE05H79bDiNmqM7CVmkO7/jPtizqb0SlRGTGCR7
 KcLGOpDlwp275oVVkaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.70:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 52FBF431C3
X-Spamd-Bar: ----
Message-ID-Hash: RWY2MPY5AYTUEGM63DN5RXJF7TKDZ6M2
X-Message-ID-Hash: RWY2MPY5AYTUEGM63DN5RXJF7TKDZ6M2
X-MailFrom: jeff.johnson@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RWY2MPY5AYTUEGM63DN5RXJF7TKDZ6M2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jeff Johnson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

On 3/6/2026 2:50 AM, Sumit Garg wrote:

I missed one k-doc warning...

> +/**
> + * qcom_scm_pas_auth_and_reset() - Authenticate the given peripheral firmware

s/scm_//

Warning: drivers/firmware/qcom/qcom_pas.c:173 expecting prototype for
qcom_scm_pas_auth_and_reset(). Prototype was for qcom_pas_auth_and_reset() instead

> + *				   and reset the remote processor
> + * @pas_id:	peripheral authentication service id
> + *
> + * Return 0 on success.
> + */
> +int qcom_pas_auth_and_reset(u32 pas_id)
> +{
> +	if (ops_ptr)
> +		return ops_ptr->auth_and_reset(ops_ptr->dev, pas_id);
> +
> +	return -ENODEV;
> +}
