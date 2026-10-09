Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BABCA6015
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 02:10:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2F3DF454F4
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 02:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791511850;
	bh=lYnJVV8Wa/TPXz1E2UaJS5GsnqXIu/Z87WsJW2I/vkE=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qKayBm8Kl/tvYuTDf4qcmcBlKEGOwdbLENh6McB3jR9nqF1e+lneLorSjn9dvfcmb
	 2FjTFWYXsOpUBjoUpIQSwOmridE8I8ovDuSBxTEQ15PVmYQa7Df4rRgGBDjrJvie0I
	 KpBhTLuSlVUmm99JczpZ2v8zhLnSTaIhNwzEHinTDAwkPdAJ9LbSvFiB2QkP/pPgwN
	 G0iQP76sCYS89PpTQadyG3kFaF2zVN/4AcyrM5d3i0UFQ/13v7ylaql0dUEJ4y+n7i
	 ZXQp/fAPB6hhRaIYj4O1rRd6C6V4+N6OfoQSxTCGld5Q2BuDouYV4l+0kGizxkx7lq
	 /I+PmVxbeiQ1g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4AB9444F98
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Oct 2026 02:10:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mwe42raZ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hbdEVYYe;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6990PxHA201763
	for <op-tee@lists.trustedfirmware.org>; Fri, 9 Oct 2026 02:10:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWIlfm4eRqEAbTkKamztvUovJLC4/3AeyGiGYlJYH/U=; b=Mwe42raZjspReLOA
	YMh7/+GuNC4lqAeb4vgQOxkG4cTnz/1be8to6aTmg+/+CZm71ExOsdlg80XYas+O
	caE1XLQH6NLPznAp147YmXXa/pV5SY2/Spb27hS9is38ra2jRYLQhbwJT0rpkoyL
	LGIZ5908GzwffY7MyV1bajleE7Mi/YU7k6Rnn7IZS7SKEbneMn60Uo84Aa4LD5mb
	Lnc/qat+rDjTRTNUQW3R/ITBZg+0J017CKK5ilVn7kJdg+EzxIrd5ya1rpxN9dGK
	SXqBtD6QKYQ0LfkXeFcrPmqQ4kZHi3DKRi0jbidZZpEw3tenKVv9186vJVzGIq78
	JXCypA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk9d1j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 02:10:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8883dcc671eso4415767b3a.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 19:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791511842; x=1792116642; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWIlfm4eRqEAbTkKamztvUovJLC4/3AeyGiGYlJYH/U=;
        b=hbdEVYYe6KnghDu5HxTcwAL/3HLWmIX0hImJk1nzH0Q3wB8yl3EriC8fDsNQEzsSWj
         /JCEIx5jUaOlEKUalK0a1GDJ4g+ZJ4mMcI3Her65PKlKmpgCdQ8nMI2ZETe45O4foK7g
         JPFYzvzRzk6EP1LQk30XxGnzoL7jvsmEGkhmgKB16DY563EJMI+t4pYP2UdQRSGN1t0s
         //XNsNXESrJgFE3iCLdYGHI3G5OQgIHm4gYXTDwLBMwn6Z9Z4pMwIxENw1vIyotJrKVC
         mZiBhmyqnLVoUi9tYf5gwh+5KPMOKY5Hj6xbPn2xhWMZ6GSRBR4jS3sCKGKzGWq+DvLP
         0Qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511842; x=1792116642;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWIlfm4eRqEAbTkKamztvUovJLC4/3AeyGiGYlJYH/U=;
        b=Ie7l8zUGQK+B9g4Wj173ob6KPF1x5dyuqdUGqcB/kcGM9aDvyyMhurLo1/cp31Zp7g
         xNpTLdF/PRP5F++jEoCVb5XMtylfovZRpivOD6PjMTqQFVaV4U4APcogdPf6m6S7Zv2O
         z9Bepj+E4/kOeLQxUBdsye0xyBR58E4HOo8+ejmauD2cGdWsoS0gRPxAbzvDa+NmjN5J
         W32UASTYmE2NgvvZH4udmsZQp2NT3d4a7fD62JEFZN4CYtG4UkaUR3HtxQydKMbGvXiV
         MUn3NdNhYate32GqvEHEtE+tf/x+OKlx6tj8fz6aBCIX2WcVhT/F6DPvFG5+C/BGkxS/
         fCLg==
X-Forwarded-Encrypted: i=1; AKwUvBx+YQHvK7Y/cQh79KwrC+702ZnHmWNmRuMrzVWdtaDhKXcbwbjE9CmeE27dfhxNrMECUmbH4Eg=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJRYEgLeC4Sc9QPUu194wQP65/wNun7923CaohHFZFsodeSBpVV
	ozk0BTvhv53TaeZNB0uD41L/5m6UYy1zvJlrIZNfuTdRGicPtGNn6/HdyLI4fTohG5ECnkO7pPe
	76bATH1GGaeuTvALXKnkoUvIuOU3ASLzU4apKr3UWLA28vF526IRCnEiu+LdYmkcIXLJ2IJw=
X-Gm-Gg: AYBFou0NLW9MCWh6MHP4fKZkxmnaBLmviUzDCnm8tXxiSFPQUFHGNuR+N0fW5NAr4HU
	iqSauV4E2ogIytzEoXaTOHNR0cCc3u1vWE5FaacNJr6hyk9Oi6MjOiaGAN71VnTn9k3Fg3B5cRr
	7GgATbprrrjiLhstQXkloJMj+xAGmQJ9Q3aPZ/5hDLwcjlgd3Qk1g/WPmaIHBBOCymDdPV8ZsGV
	8tInPWYnj3pjcGGH/f2SSXdEu8M1aaOQ9JS1dsABNT3cEhrTujNNHy2rtB8wYjNhdLxqcB0sgp3
	jvbTmZc4a4zgN4qzzRBQkBX3dwV6ItoZbn1h1ttWG62IdCv5klL2UI8/FeS+sR+fdCykiC/wF2S
	mqe3m+WakRPhYbU0yHz8ndT8nGuCU60jt
X-Received: by 2002:a05:6a00:1916:b0:878:3658:23dc with SMTP id d2e1a72fcca58-897c7cd75camr336132b3a.53.1791511841152;
        Thu, 08 Oct 2026 19:10:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:1916:b0:878:3658:23dc with SMTP id d2e1a72fcca58-897c7cd75camr336098b3a.53.1791511840588;
        Thu, 08 Oct 2026 19:10:40 -0700 (PDT)
Received: from [192.168.1.86] ([65.181.12.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c43ad3ccsm277492b3a.47.2026.10.08.19.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 19:10:40 -0700 (PDT)
Message-ID: <ff027be4-b473-4deb-a55c-52454129630c@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 13:10:33 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] tee: qcomtee: Add support for registering QTEE
 services on TEE bus
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
 <20261006-qcom_uefisecapp_migrate_qcomtee-v4-5-bf1c8e2a64ab@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-5-bf1c8e2a64ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7KKYWCW5HT3GCKr-sv4IQT0gGMZe7sl6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAwOCBTYWx0ZWRfX151sf/eSZXj1
 T7uJxjr2py7xOQ9A/EF7JQxoWe9OzCogP8uc2QEdVU69c8BmUacHccPioZJMuF6F+ncrAhKwwIt
 8BRmlKebt/+uBeNaFRxsV8SbN7uih40=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac84d22 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=9v5PfQ1E2GNzj2RibJmqVw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=I3J3X--Ozs3p5lJzdqUA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAwOCBTYWx0ZWRfXyc+7s00YTfzF
 jBHgm7r/E9LFJX03f0hfOjUm72tcep5nZmK1xdz5f0X/vCDS6YbJNvHoITTtNQC1KAUylUgMS41
 7fVvVYrZxhxuj5En37rbaW9QKC0WUv6EicWfeCgguT9CtWBKs+1E+Sxew3aN1Lig1fewjITcGLs
 Ejxep9PrAPl3JZyp733n07MM5QsaM8wEO2c5Rbi9TKHyqbaJY0SZZDBoZpR+YzyLhC9+kIA+Qyx
 bVCGYXgnw1svjEdmh2D/Pkgme12b0XRKy2Ks10hf5dF0xqcyNjaoN/IU3JghGBwtOlIT3kqaOEF
 5TDw4TQhCiXO4mB22CnNUvkMGjm4MB23UGrU4deZrxCa2WdZPThOJ1oIvQMKFxuI59IuzcfntCX
 UwCtXabJFr8xQ6pFnnTI/Oy01mCZib9eKVYLdq/uQ+2fR0NXwx35AFMJPwjOuCTNvcXayMopQjB
 adDb140SIbDRWJWAUwQ==
X-Proofpoint-ORIG-GUID: 7KKYWCW5HT3GCKr-sv4IQT0gGMZe7sl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_01,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090008
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.210.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4AB9444F98
X-Spamd-Bar: ----
Message-ID-Hash: WQXPNJBJUXMIMEBJ6C6T6QPG5N2ZDQEC
X-Message-ID-Hash: WQXPNJBJUXMIMEBJ6C6T6QPG5N2ZDQEC
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WQXPNJBJUXMIMEBJ6C6T6QPG5N2ZDQEC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>



On 10/6/2026 10:33 PM, Harshal Dev wrote:
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
>  drivers/tee/qcomtee/call.c           | 161 ++++++++++++++++++++++++++++++++++-
>  drivers/tee/qcomtee/core.c           |   9 +-
>  drivers/tee/qcomtee/qcomtee.h        |  12 +++
>  drivers/tee/qcomtee/qcomtee_msg.h    |   1 +
>  drivers/tee/qcomtee/qcomtee_object.h |   3 +-
>  5 files changed, 179 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index c97afaa1b4aa..3061bcbd15ab 100644
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
> @@ -698,6 +702,156 @@ static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 id,
>  	qcomtee_object_put(client_env);
>  }
>  
> +/**
> + * is_qcomtee_service_available() - Check if the QTEE service identified by the UID
> + * is available
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
> + * TEE client device
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
> + * qtee_register_services() - Enumerate all the secure services exposed by QTEE
> + * from the static 'qtee_services' list and register them on the TEE bus as
> + * TEE client devices.
> + *
> + * Not all versions of QTEE support a given service. Hence, we try to
> + * enumerate as many services from the 'qtee_services' list as possible.
> + * Not being able to enumerate a service shouldn't cause the driver probe
> + * to fail since none of the services in the list are mandatory for
> + * establishing communication with QTEE.
> + * @ctx: TEE context.

The doc is a bit unusal. There should be a short description, arguments and the details.
you details are above the argument.

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
> @@ -779,6 +933,8 @@ static int qcomtee_probe(struct platform_device *pdev)
>  		QTEE_VERSION_GET_MINOR(qcomtee->qtee_version),
>  		QTEE_VERSION_GET_PATCH(qcomtee->qtee_version));
>  
> +	qtee_register_services(qcomtee->ctx);
> +
>  	return 0;
>  
>  err_dest_wq:
> @@ -808,6 +964,7 @@ static void qcomtee_remove(struct platform_device *pdev)
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
> index f39bf63fd1c2..66d305a46c0a 100644
> --- a/drivers/tee/qcomtee/qcomtee.h
> +++ b/drivers/tee/qcomtee/qcomtee.h
> @@ -17,6 +17,8 @@
>  #define QCOMTEE_OBJREF_FLAG_USER	BIT(1)
>  #define QCOMTEE_OBJREF_FLAG_MEM		BIT(2)
>  
> +#define QTEE_UUID_NS_NAME_SIZE	        128
> +

This macro seems unused, in the whole series. Drop it.

>  /**
>   * struct qcomtee - Main service struct.
>   * @teedev: client device.
> @@ -39,6 +41,16 @@ struct qcomtee {
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
> index d3740099fae0..901ba3565a73 100644
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

