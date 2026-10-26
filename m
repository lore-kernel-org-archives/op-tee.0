Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A595606A31A
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=bc9qTkHm;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EWY+p4vH;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BzQtWedY
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7A6FB45273
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 03:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792986721;
	bh=bTGB9SAvm8NGroAPYNn+Lmo4b1+RCDpsgfSfteCDgoQ=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=bc9qTkHmJAtO9tfcJmAxu6Hj9xhdEe6bFszRm/GxX3T/8QeTQqm0gmrPpx4wlKw0Q
	 02pn2NDiHCXNE/Fy/E5Smcm09SJUWWuIJaN8z4LgcUZ+FQRxlTfEfSED64Bb2+aInC
	 NJ+p2vL9NrQLSwgSKHpyKFyDrFxrWvr9sAKxCVKsZyB9K4wF2Kju8vAq/DGiXsdNgG
	 Ee+gsTFEXe7m1ACUQkQgWvGfyC+ItRSai+fQpFv4pKeuGSgnTnFkVPVq3Fdq+fO/r2
	 dRHTqy/1uL30t4dsXiqmXZfk1gLAGjRmgqAA4iFa8SDewWTcWdOo4xjU9nJiasSwVA
	 uv9oiixQQCIfg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B5FE844E4A
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:51:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EWY+p4vH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BzQtWedY;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2KpfY2439914
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GgSu1Vcs5L81aLqtTFChBhvjr3xSWDWX+uLKUszi5yI=; b=EWY+p4vHW/8s6DnF
	Szf9bdY/we6MoAnb6h7AtmbcN2ElVkZc84r9t5xDNrYwKi6yDRC6TdhFEBOKYhkw
	zx3e4VbcdRHxCidhRGqYX1yNQqsWHy7aahWwLd565VGamtk2dA6ZDy0Pj0XpuVWA
	VgsZm1z6YGaRrVUasoueWLYzZA2QTxXtY/jyRg41OpixuuqP0nx9pyILQ1mImbSr
	6ikSQQNYHCpnUhujwQZsaO9kvtGjIHPwcDdE5nMntiJJI66+LaVxRyvfnPw9iNPo
	D+LyIHpxIi8QuWKpa7l0dRNF/seiFU2OM+Blx0y8Y0F11lbeFYhKaFqAc/kBLQyQ
	SDD8KQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6mrvn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:51:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ea381ce04fso27828925ad.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 25 Oct 2026 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792986700; x=1793591500; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgSu1Vcs5L81aLqtTFChBhvjr3xSWDWX+uLKUszi5yI=;
        b=BzQtWedYgnPEhzyqmFzwBgUPuGTtw0dFylJo0a0zn2AXCLDp3gwj46vPDz4iHG88hp
         56QcQsvvL0Y6zJG7TbiKrRi5A+g3Hq9jf/vpnEHTtvWTzROXnPiwaFy+0jAim6kPlCIv
         7AF7VP5J7bkhRRN7hIRVzSv1oG8ym4csgZO02OCJ5aWyzgzjGO3CYCPQpSUivaE6mKsR
         crxXO2K3pOH5cECHnfekjeZSn8OYJliS0fjAT9AysuYYuGK+YtXKE70i+RjsTdRXUFnJ
         tbquQjIewf2m2z+7aJVJz9l2K0i9m8Z/OwKzo/m8VBNB7PK+Q7StMlGXHqw2+7L1WdIN
         BsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792986700; x=1793591500;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GgSu1Vcs5L81aLqtTFChBhvjr3xSWDWX+uLKUszi5yI=;
        b=n+4JQxhdTSbHpDRaOcKRp397cwvwfD7plEG4CdkhLdbGcy8uUw8HtY4hPSOehYVgLh
         MKoGtqn9E137LH3+1TugZziYREy0SwyD2N0RV5dt1FlILk5YUBlwDRWL8mX+yeRE4bdE
         tZgEvp/O1aSxI6j1ZL2aYMO+LPVl2V5kXKllxXXGk/tVTw5oy/dtojjCGMYPh2NqZzg2
         OFkKL5momsyfQrfzWeDH11T//FVWMB77mur5ex4udp20hVyjaNLc5hEK0kIQaSuDcoZS
         zvuJRsYuVMt2Mi+o2l7lhTxyOaGhQzuyQUp1B+0HactysKB8EkGqB87fpDRbeqo4fN6C
         X/nA==
X-Forwarded-Encrypted: i=1; AKwUvBzXuICCowVp3/SMeJjMiN9PBuc1CPuKM5vddbDts6j2HGQJBDwrMNdScHqFfN1iGQBalk/n+GE=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJyUdZHF86t3VhMxVpqGwaUeJ7qP86xOK2Z9G25XmaaWyeIeHsy
	cn/5WhYTL8SEUuYYhWzRJSRo7uwhzb+LZbREMZMYPAAJNRa2eSCLbIjx2wXlrNJM8s7PHIWBomR
	f2xFpeGeUxITQ1A8fhfb3DsCNYaoqfRtMiyedRFo2BZRq2WH63xWbVVPhiOnP8ZLlmJNLwvU=
X-Gm-Gg: AYBFou1JxgdWyn+VS2zohxtl9AeO8rsnFx1UGfOZn6va2cWlcoElkdBefrrUXGqyqeY
	TRwTyc99/7ezJXUIWD7yG4hEKuBl+BAuHM1RgJTj883FgJYM0I6eGkYokuiyaYOLHctDJZ9Zk3l
	Ww1aduMPuyWAnJMtcfnEUPPEFc7ZVh6bubU+i33ut/tQlTVlyZDCZ6UdlaDcmt8VNFCMmZiQNaE
	L+i3p/xIMR03O326bjTGtb3eEgPiF/SnJgawKZZsFhQMD3VNW2KCTaltKL2PH4jzBz/WWZxcvqi
	kL5VwdoYlKnBU+VQP8zXMz1FiKRbSlPlBGz/Shv/sbj7qTA/kKerw/KI2NuGPASEtsy7mo7P9He
	SLhy2tDpReRBEB+UohpELQ0m3fa48K8tG
X-Received: by 2002:a17:903:37c4:b0:2e9:484d:693 with SMTP id d9443c01a7336-2ea9c0c5881mr32450925ad.5.1792986699845;
        Sun, 25 Oct 2026 20:51:39 -0700 (PDT)
X-Received: by 2002:a17:903:37c4:b0:2e9:484d:693 with SMTP id d9443c01a7336-2ea9c0c5881mr32450725ad.5.1792986699230;
        Sun, 25 Oct 2026 20:51:39 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.119.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b121651sm11278175ad.18.2026.10.25.20.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 20:51:38 -0700 (PDT)
Message-ID: <b27834b1-4ed3-4eb1-a8e3-a1239f20ad43@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 14:51:33 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-5-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-5-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 0ZjRUX77CI48jusk0W-EfLr5pF-EReLU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxNSBTYWx0ZWRfX7mmgBgJfw9jw
 fy6uRxaC/mCC/mwQwq997ULlyfsUnNNDx+r/aqglP8dXHObIuytFhSYgv4wMB2AeJQT8iPP34AG
 T68enrNIljfqVm9u80eDcCbhEw6Qwiw=
X-Proofpoint-GUID: 0ZjRUX77CI48jusk0W-EfLr5pF-EReLU
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adece4c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=pnHLkUe0LhHGSDu6DPowAg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=I3J3X--Ozs3p5lJzdqUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxNSBTYWx0ZWRfXwIK1nxCNeqgq
 SgeI5Nu44q5L1Anbh19eOQehyXbndYAU5vVjXREXnNrogLz7rI525QsSS81+5choYwDxXSVUjDO
 KgAVxmtvbH0HsIgU6fQk0dm3bJhruG7Pg+LHTYVURPwVT/V9GVG8bI115o5ctyhYR2Ydnp/4iiO
 EGWjZ2PxftZuiw7DN0V0Ce7gtnQazGWPJ87RFgS2V9KrZKs7tjPuLb/jAVtTzhdeqzNnJeuKW/h
 ygwnFb7Ux/F3Yh5GfLp/omhUKgIwDs61ktG+BrnYygqgs3O1AgDHvzPMr5CXAiIyu7UJ2c1pB7l
 iZVqbg6IA0lM6XFuT5WuWxSB1eIJEziSNdUWM79m7oS3rvviooRIa7xbPEKnlnsTQE8+1iN5tWc
 hvmjsG1njjg5dQnWhO17TgLhOk61y+uTj5db2Xtg6VLOHizLc5CafKSKyEuXUW0u9NE3Kc5LEjd
 HKXFush+F0TjhG3pGIQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260015
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B5FE844E4A
X-Spamd-Bar: ------
Message-ID-Hash: HVUAEM6YHBS66WCBBUXQUC3EYU44V6PV
X-Message-ID-Hash: HVUAEM6YHBS66WCBBUXQUC3EYU44V6PV
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HVUAEM6YHBS66WCBBUXQUC3EYU44V6PV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Harshal,

On 10/15/2026 10:39 PM, Harshal Dev wrote:
> QTEE exposes certain secure services implemented either within the QTEE
> kernel or via pre-loaded Trusted Applications (TAs). Such always-available
> services can be readily accessed by TEE client drivers via QTEE's
> object-IPC protocol if the service is registered as a device on the TEE
> bus.
> 
> One such service is the EFI-variables service, implemented by the
> uefisecapp TA which enables kernel clients to access EFI variables at
> runtime.
> 
> Maintain a static list of such always-available secure services and add
> support for the QCOMTEE driver to register these services as devices on
> the TEE bus during probe.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
>  drivers/tee/qcomtee/core.c           |   9 +-
>  drivers/tee/qcomtee/qcomtee.h        |  10 +++
>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>  5 files changed, 176 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index c97afaa1b4aa..47d8a4f9a159 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -676,9 +676,13 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  
>  	/* Get ''FeatureVersions Service'' object. */
>  	service = qcomtee_object_get_service(oic, client_env,
> -					     QCOMTEE_FEATURE_VER_UID);
> -	if (service == NULL_QCOMTEE_OBJECT)
> +					     QCOMTEE_FEATURE_VER_UID,
> +					     &result);
> +	if (service == NULL_QCOMTEE_OBJECT) {
> +		if (result)
> +			pr_err("FeatureVersions Service unavailable (%d)\n", result);
>  		goto out_failed;
> +	}
>  
>  	/* IB: Feature to query. */
>  	u[0].b.addr = &id;
> @@ -698,6 +702,155 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  	qcomtee_object_put(client_env);
>  }
>  
> +/**
> + * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
> + * is available.
> + * @oic: context to use for the current invocation.
> + * @client_env: Client environment object.
> + * @service_name: Name of the QTEE service.
> + * @uid: 32-bit UID of the service.
> + *
> + * Returns true if the service exists and is available.
> + * Returns false if a service is not exposed by QTEE.
> + */
> +static bool is_qcomtee_service_available(struct qcomtee_object_invoke_ctx *oic,
> +					 struct qcomtee_object *client_env,
> +					 const char *service_name, u32 uid)
> +{
> +	struct qcomtee_object *service;
> +	int error = 0;
> +	bool ret = false;
> +
> +	/* Get service object corresponding to the uid. */
> +	service = qcomtee_object_get_service(oic, client_env, uid, &error);
> +	if (service != NULL_QCOMTEE_OBJECT) {
> +		qcomtee_object_put(service);
> +		ret = true;
> +	}
> +
> +	/* When we fail to get the service, QTEE provides the reason. */
> +	if (error)
> +		pr_debug("%s is unavailable (%d)\n", service_name, error);
> +
> +	return ret;
> +}
> +
> +/*
> + * QTEE Service UUID name space identifier
> + *
> + * A random UUID that is allocated as a name space identifier for forming UUID's
> + * representing secure services exposed by QTEE.
> + */
> +static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
> +						     0x93, 0x4e, 0xa2, 0xf2,
> +						     0x0a, 0xba, 0x98, 0x42);
> +
> +static const struct qtee_service qtee_services[] = {
> +	{ "qcom.tz.uefisecapp",
> +	   QCOMTEE_UEFI_SEC_UID }
> +};
> +
> +static void qtee_release_service(struct device *dev)
> +{
> +	struct tee_client_device *qtee_service = to_tee_client_device(dev);
> +
> +	kfree(qtee_service);
> +}
> +
> +/**
> + * qtee_register_service() - Register a given QTEE service on the TEE bus as a
> + * TEE client device.
> + * @oic: context to use for the current invocation.
> + * @client_env: Client environment object.
> + * @service_name: Name of the QTEE service to be enumerated.
> + * @uid: 32-bit UID used by QTEE to identify the service.
> + *
> + * Returns 0 on success and < 0 on failure.
> + */
> +static int qtee_register_service(struct qcomtee_object_invoke_ctx *oic,
> +				 struct qcomtee_object *client_env,
> +				 const char *service_name,
> +				 const u32 uid)
> +{
> +	struct tee_client_device *qtee_service;
> +	uuid_t service_uuid;
> +	int rc;
> +
> +	if (!is_qcomtee_service_available(oic, client_env, service_name, uid))
> +		return -EOPNOTSUPP;
> +
> +	tee_generate_uuid_v5(&service_uuid, &qtee_service_uuid_ns, service_name,
> +			     strlen(service_name));
> +
> +	qtee_service = kzalloc_obj(*qtee_service);
> +	if (!qtee_service)
> +		return -ENOMEM;
> +
> +	qtee_service->dev.bus = &tee_bus_type;
> +	qtee_service->dev.release = qtee_release_service;
> +	if (dev_set_name(&qtee_service->dev, "qtee-svc-%pUb", &service_uuid)) {
> +		kfree(qtee_service);
> +		return -ENOMEM;
> +	}
> +	uuid_copy(&qtee_service->id.uuid, &service_uuid);
> +
> +	rc = device_register(&qtee_service->dev);
> +	if (rc) {
> +		pr_err("QTEE service registration failed, err: %d\n", rc);
> +		put_device(&qtee_service->dev);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * qtee_register_services() - Register the secure services exposed by QTEE
> + * as mentioned in 'qtee_services' list.
> + * @ctx: TEE context.
> + *
> + * Not all versions of QTEE support a given service. Hence, we try to
> + * enumerate as many services from the 'qtee_services' list as possible.
> + * Not being able to enumerate a service shouldn't cause the driver probe
> + * to fail since none of the services in the list are mandatory for
> + * establishing communication with QTEE.
> + */
> +static void qtee_register_services(struct tee_context *ctx)
> +{
> +	u32 idx;
> +	struct qcomtee_object *client_env;
> +
> +	struct qcomtee_object_invoke_ctx *oic __free(kfree) =
> +		qcomtee_object_invoke_ctx_alloc(ctx, true);
> +	if (!oic)
> +		return;
> +
> +	client_env = qcomtee_object_get_client_env(oic);
> +	if (client_env == NULL_QCOMTEE_OBJECT)
> +		return;
> +
> +	for (idx = 0; idx < ARRAY_SIZE(qtee_services); idx++)
> +		qtee_register_service(oic, client_env,
> +				      qtee_services[idx].name,
> +				      qtee_services[idx].uid);
> +
> +	qcomtee_object_put(client_env);
> +}
> +
> +static int qtee_unregister_service(struct device *dev, void *data)
> +{
> +	if (!strncmp(dev_name(dev), "qtee-svc", strlen("qtee-svc")))
> +		device_unregister(dev);
> +
> +	return 0;
> +}
> +
> +static void qtee_unregister_services(void)
> +{
> +	bus_for_each_dev(&tee_bus_type, NULL, NULL,
> +			 qtee_unregister_service);
> +}
> +
>  static const struct tee_driver_ops qcomtee_ops = {
>  	.get_version = qcomtee_get_version,
>  	.open = qcomtee_open,
> @@ -779,6 +932,8 @@ static int qcomtee_probe(struct platform_device *pdev)
>  		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
>  		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
>  
> +	qtee_register_services(qcomtee->ctx);
> +
>  	return 0;
>  
>  err_dest_wq:
> @@ -808,6 +963,7 @@ static void qcomtee_remove(struct platform_device *pdev)
>  {
>  	struct qcomtee *qcomtee = platform_get_drvdata(pdev);
>  
> +	qtee_unregister_services();
>  	teedev_close_context(qcomtee->ctx);
>  	/* Wait for RELEASE operations to be processed for QTEE objects. */
>  	tee_device_unregister(qcomtee->teedev);
> diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> index 60fe3b5776e3..4a523a95bf0e 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -898,19 +898,20 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
>  
>  struct qcomtee_object *
>  qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
> -			   struct qcomtee_object *client_env, u32 uid)
> +			   struct qcomtee_object *client_env, u32 uid,
> +			   int *result)
>  {
>  	struct qcomtee_arg u[3] = { 0 };
> -	int ret, result;
> +	int ret;
>  

Please initialize *result, otherwise for instance, on mem allocation failure,
qcomtee_object_do_invoke returns with errno. The caller checks the return value + result
and may print garbage.

- Amir

>  	u[0].b.addr = &uid;
>  	u[0].b.size = sizeof(uid);
>  	u[0].type = QCOMTEE_ARG_TYPE_IB;
>  	u[1].type = QCOMTEE_ARG_TYPE_OO;
>  	ret = qcomtee_object_do_invoke(oic, client_env, QCOMTEE_CLIENT_ENV_OPEN,
> -				       u, &result);
> +				       u, result);
>  
> -	if (ret || result)
> +	if (ret || *result)
>  		return NULL_QCOMTEE_OBJECT;
>  
>  	return u[1].o;
> diff --git a/drivers/tee/qcomtee/qcomtee.h b/drivers/tee/qcomtee/qcomtee.h
> index f39bf63fd1c2..b1fe1d317150 100644
> --- a/drivers/tee/qcomtee/qcomtee.h
> +++ b/drivers/tee/qcomtee/qcomtee.h
> @@ -39,6 +39,16 @@ struct qcomtee {
>  	u32 qtee_version;
>  };
>  
> +/**
> + * struct qtee_service - A secure service exposed by QTEE identified by a 32-bit UID.
> + * @name: Name of the QTEE service.
> + * @uid: 32-bit UID used by QTEE to identify the service.
> + */
> +struct qtee_service {
> +	const char *name;
> +	const u32 uid;
> +};
> +
>  void qcomtee_fetch_async_reqs(struct qcomtee_object_invoke_ctx *oic);
>  struct qcomtee_object *qcomtee_idx_erase(struct qcomtee_object_invoke_ctx *oic,
>  					 u32 idx);
> diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
> index 5d7b21fdd368..9278a361dc70 100644
> --- a/drivers/tee/qcomtee/qcomtee_msg.h
> +++ b/drivers/tee/qcomtee/qcomtee_msg.h
> @@ -105,6 +105,7 @@ union qcomtee_msg_arg {
>  #define QTEE_VERSION_GET_MINOR(x) (((x) >> 12) & 0xffU)
>  #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
>  
> +#define QCOMTEE_UEFI_SEC_UID            413
>  /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
>  
>  /* The message contains a callback request. */
> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
> index a241ab657318..e2f2508aad8f 100644
> --- a/drivers/tee/qcomtee/qcomtee_object.h
> +++ b/drivers/tee/qcomtee/qcomtee_object.h
> @@ -317,6 +317,7 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic);
>  
>  struct qcomtee_object *
>  qcomtee_object_get_service(struct qcomtee_object_invoke_ctx *oic,
> -			   struct qcomtee_object *client_env, u32 uid);
> +			   struct qcomtee_object *client_env, u32 uid,
> +			   int *result);
>  
>  #endif /* QCOMTEE_OBJECT_H */
> 

