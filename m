Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401D606A320
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FQDus7hz;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSm5An/L
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6DA9E5032C
	for <op-tee@archiver.kernel.org>; Thu, 19 Nov 2026 01:26:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FQDus7hz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CSm5An/L;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E7FCD43A65
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 01:26:21 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ1AtfI1444502
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 01:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EuvcXYCLEDhBXkV/gZ9Tv3es2XAWMz1+RvXTNS35cPs=; b=FQDus7hzHmJYdFA9
	ugqq7Bi1lDsehwZXb3jn7XoAhsKuArd+GLHrt0ijPUXRfw3eKexI3wScbJCSWwR3
	vv4DjQtk3EozzVOrMZsj+WV8L6ve/fJ0NzUVU+iVhFBusgV0XWVpBoq4uKCmZzhr
	g/VvKdZGYzNOXHcW9GOk79mFm17T2ekf12K1pdySgwbpDmeIW5IdUDMgwF1ZIvNi
	y4YNrlrQ7z8PNeWhzZy6OrMBuMBSiq4pTupkIHF7C8/JgtNO3gZiaMObw7chX9O9
	iU2BOrZOzJfRe2Fuq7GaTzkGLeMAlFcmfrqkuDWJDlhPRBaoR0F3SiLm0b1GTIGV
	Vw3Ihw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1e5qtfut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Nov 2026 01:26:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cddf34086c8so1006682a12.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 18 Nov 2026 17:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795051580; x=1795656380; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuvcXYCLEDhBXkV/gZ9Tv3es2XAWMz1+RvXTNS35cPs=;
        b=CSm5An/Ltzfw1KVRLwymEQwnfQ1i2KRRM+cDq3+bT22STm7jJiGI838unD6EtrxZyG
         8sTiLRYElX3tvrjDpIny2S1bR72hVtzpLFwRHOITw+wJQTy5OSSH5hBkYM3NmJO9aMd3
         jlgsyOHjoJ9sVIkTUdM1/BdtEwV7zvms7uhOVv/eowYaWv+4Hg587ne6zEbviRTXCzlm
         YnRr5lnI52jatpKtSZEyEIuKdB5bFp0aVdECI9SpEob60nH2WtdaPYNS6tOteqWhmsY+
         /HOqrd41Ruj7cy3CBVN6/baE64nBEBrs+2muR1/UcoiBvci0LcDDUIqpDx75OgwfQOVt
         628A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795051580; x=1795656380;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuvcXYCLEDhBXkV/gZ9Tv3es2XAWMz1+RvXTNS35cPs=;
        b=dDcOxoBr362LWa4VS6kYDXwai9pAzhGG1s05f/2Csl7Iuus4PdYjlOzTtIqtcG5aZE
         hvGFNKPh92s0Bzht5sOF6wKoKk5wVj8kefrKCTvHA2IlbGSIjJ69HopY4P7Eo9O1A2EZ
         5W79mW5iLx1bMWDxAVzuYzyj5eKs0sQbZN19JhIDI8LiVdtU9xzJz6gsQ81DcGkKhsRG
         bLvL9/afle0QY78dAqL4yFR+JQlthwzBFBNCY22HJgB+qcV7FvBVktINYniS3Mt/QhQm
         q5cdPz8ZNvAyfRvNZnDPH0tjzJWEHEK86FPn+XYubJRuE1plSrHC79CWriJ87t5HfIs1
         Jwmw==
X-Forwarded-Encrypted: i=1; AL+hErHFS++QpDu0+XskJvLHxZEoqlC355QrtR+9KNW27o8RkZ7F/fSGXStTKQuy0axLKtzm/fbLXY0=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/pFg9SuYzL4LLwe+t9P2n+k2/C4wifK2NYjqfd+tsw9xYutHfr
	7L5ffUjLxHLL0dhlIX9XyqgfK3Lfw4YUpYzSviEf8O4oa0MJzZI+A3afd8WEJPN6C0IQK2aZeTP
	PXYzWHB7caMh53v9rIZgv6uZftWjiULpmL3XXXvu/RRvZKrPkgYFp0C8xIds5XeEDXV2g13E=
X-Gm-Gg: AZFdTZcKx6nn+1l5xN0lAE+S6SyA8OgdcO3Gcc4CFhnCQXn6V3XONaI6UGtsLAClKVA
	zZKX5h5lhHSEY02pjUYX/k8Kkpl2hqyyOqMGQroGBQNwjSfhWZcryP1M8OHpS/0fZN0F/t5vI8X
	WNvWjyrK6EHnKRT/zoLxtYoQdhjb8rLTCR/NB4plXctSY2MpWXsJRIYwazmgYlo9iC/6WBItWuR
	/Z5BkD+Fhvl1e6bVB5A1Kzn5z+/g3rPTZuIzU/itCm1PiUgHjHbbRi2g1FB/qjNhRE+Mq85R5IM
	ALyqSB+3/1bp9HH9DsQuqzCVT/Y++0xfFeO3UICyy3G9124Z7ukuYO7uKDkH5IsAOcHBREK/X9G
	FzJXy6hTGXwaexNWdWpCE9wBJFl5LWwhEzj/WN7a+gzqiyPwyY8ficIrYNyx7wSo2avbB9uxP7y
	4FK0V6
X-Received: by 2002:a17:902:e550:b0:2ef:ddd6:7176 with SMTP id d9443c01a7336-2eff7574d13mr38070025ad.70.1795051579732;
        Wed, 18 Nov 2026 17:26:19 -0800 (PST)
X-Received: by 2002:a17:902:e550:b0:2ef:ddd6:7176 with SMTP id d9443c01a7336-2eff7574d13mr38069695ad.70.1795051579197;
        Wed, 18 Nov 2026 17:26:19 -0800 (PST)
Received: from [192.168.1.86] ([65.181.12.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6215032sm21140545ad.45.2026.11.18.17.26.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:26:18 -0800 (PST)
Message-ID: <4f2c1975-966c-4e7c-97df-854c37bb90df@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 12:26:12 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
 <20261105-qcom_uefisecapp_migrate_qcomtee-v6-5-c7d68ce05c51@oss.qualcomm.com>
Content-Language: en-US
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-5-c7d68ce05c51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TLD4QtNWsoge0ZNGairyt9hUio4BILcR
X-Authority-Analysis: v=2.4 cv=c5Q+0h9l c=1 sm=1 tr=0 ts=6afe503c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=BZS24S1BcHTaWDmu2ykUCg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=I3J3X--Ozs3p5lJzdqUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAwNSBTYWx0ZWRfX32tqoES8t21d
 hKGtpoDOJDMjnT7H7BR/tGS43bLfVRrRQzs8lFlFWLCxenKDEtP4SFLYiC2ydHxeC9T5BQKNJ/g
 c0L5td7YWZ1m/8qi0ncgw8vW5MpWlBo=
X-Proofpoint-GUID: TLD4QtNWsoge0ZNGairyt9hUio4BILcR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAwNSBTYWx0ZWRfX9slWQiDHZ960
 pL11mzZIbChh0Hc+dj9bq8Tg6rSr4wbwB6TPbOvGrvnPTgBrzEt3JPvro/KcFTz2Eh3q6JasHzj
 lXq/LzfOSP0f0btyzhqzwj1pvCAiZav6vyHsaGDrz/vxZT8xMhwb0Bd9LsNXFvYoY+kRspMV8Cp
 3V5YPdJDlO9bjGhWffFvy+2PR9UFxpf0L3lKSTQbeICDLU51VWESkgmyvdgl+Pc9yoTNfIVAm9G
 NOR+XJEEaegSaBsAFP9rpWFgEi4uxkUd0cMdcZ7os67jl1g/6FmhJfnaVOXSK4ONWF2QuCv/qmE
 Zpt+Kp7erQQINNCET4oolGc7Cnd6W2n8DRNZlLR+MM9S5bGHD923wMATiQyuOgf80rZIUdK26Fg
 t82ZPK9m98F3lFDxtdx3FHZ8AR31halFrszCVX4lUzUz6JyrvaplUQYmaXJRzglJ3uZ7aH0dLxP
 MU0Wymy3fSfS2PnSOeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190005
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.215.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E7FCD43A65
X-Spamd-Bar: ----
Message-ID-Hash: M5EMYZHH7R3ZHTADIDGCKNAL2CMBCO32
X-Message-ID-Hash: M5EMYZHH7R3ZHTADIDGCKNAL2CMBCO32
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/M5EMYZHH7R3ZHTADIDGCKNAL2CMBCO32/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Harshal,

On 11/5/2026 10:14 PM, Harshal Dev wrote:
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
> Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  drivers/tee/qcomtee/call.c           | 160 ++++++++++++++++++++++++++++++++++-
>  drivers/tee/qcomtee/core.c           |  10 ++-
>  drivers/tee/qcomtee/qcomtee.h        |  10 +++
>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>  5 files changed, 177 insertions(+), 7 deletions(-)
> 

Looks fine to me.

Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

- Amir


> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index c97afaa1b4aa..96badaf98795 100644
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
> +	int error;
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
> index 60fe3b5776e3..737d1d9ca18d 100644
> --- a/drivers/tee/qcomtee/core.c
> +++ b/drivers/tee/qcomtee/core.c
> @@ -898,19 +898,21 @@ qcomtee_object_get_client_env(struct qcomtee_object_invoke_ctx *oic)
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
> +	*result = 0;
>  
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

