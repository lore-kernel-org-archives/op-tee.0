Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467BE606A324
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxjct9mH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iFTv7PzJ
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 97A2444E76
	for <op-tee@archiver.kernel.org>; Wed, 11 Nov 2026 14:57:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Yxjct9mH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iFTv7PzJ;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4859D44E76
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 14:57:35 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABEHdKQ2501538
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 14:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/40jYrLAj6axvoSSA2in7aHxwy4Fp9/+iv1azORyUxc=; b=Yxjct9mH/uBDFpsW
	5lVZNAVbaSVTAAKCPuor/FOsWPX7t9k/A5CXTYka2RCr1DRvNcUyvRief2MFfdeq
	23Yju/jkNnZiHiQ1yn8gKAX1TRvmvHAJyW5I4sOkgftY4FcQkqMWkNmRG8vMyTlQ
	sUlMm0VeMNJKnGUdZTMFTOiy88G6xvlMx6tcYLN+D/wXmm8kF42ltsmzwGfAKqjQ
	WbgxmiyzV2LCJYJqrpl82j1CRBBd4XfpunQUrPI61aGQxdhRmf652r6o2hO5tCtt
	W/RepYf7o09qxLsa/Aj/quS6nX+6VFXcW+SUflhEDZIAeq4EdQc3ix+bKnLGyOE4
	5Rvy8w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvksm9q8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 14:57:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-375f0fd31f4so2070554eec.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 11 Nov 2026 06:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794409053; x=1795013853; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/40jYrLAj6axvoSSA2in7aHxwy4Fp9/+iv1azORyUxc=;
        b=iFTv7PzJVVg8MMub4i5eKEazV97NugDWx7cUJ97JnkrGV5/w4NZXsbd1eSH6s7FzNH
         pcEUurFmYdPvFeAccj9I8sqG04FOF4NtK0wmUEWJwHfJkJ9qhi09ei9EcQjC784sw/5s
         A3x4v6glwABAYFU2lLqWZx6eZO0H+rhUmR5cFpnFbGTiJMBS65Y4fjbie3IHwhs16aQ9
         RvXX+/FVlqxhwkhiIYIDLoZzpfE08otNRv/F2JXqxsvTY8zZCUBnu/wtYU71U798PfnD
         GQjSDynv6B7CmbYBpSfNKWHGWCf3jT+MHYwohZHVE07vONS188p6DvF8DwXfrFEaN0xP
         FkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409053; x=1795013853;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :from:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/40jYrLAj6axvoSSA2in7aHxwy4Fp9/+iv1azORyUxc=;
        b=UTs0ywA8HzjhcqbnB+9O/9yoxhhft+3MEFKk3YXqaIxXDiOuhuoIeIGAJ6LtQFz0AO
         HiRdLWxUnSLDbSVtz36f7igUYQVp5kPb0dJHMzVIJ2nMpx5Gak0DiY2G0L1UwLefSrG7
         zmJAG3Q7SWBdM1cq+B8hG7mgHHIw/n68kbWGUbewCX+EB2rRmJHBSNz/Cd8z7evhx8jo
         88v5Kawb3h3DiJ7bIw/EDRtsyq5n+qa5cqk6fKV+m/nYSZzZwn0zOX5LhAHphjWIEh6r
         LVz9Nx0IpX+fhnBcDYorsiyZ/ktq+5Vj9iBrwq9Pk2zrqeDqhVoHpp7R4J0PXXXibVii
         irdg==
X-Forwarded-Encrypted: i=1; AL+hErFRh/MjM9PfHF35DQ1UoyUetSJycWnmHdnTS2iIW7dycRyNluC/GpF1OPSGp7UMlcLUYzeGuws=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8Lz/IDWA49STeerUWv0C7zXVhzT9dQMZp8n73+0DENYAC5MgPo
	Ep6HP2pJvGHOUQ7CA3KeGY5gHQkpq64rUPgYjtNBG3FY468A5HZ5k+EmzjI3iyWVV7nmry58lVL
	B2flQspETz6oEwpOTpU0xST2Nsp46yrTrL8DhKovlS5szmFv5j4WRjhGyZBQE4o1EPaeZQHWC
X-Gm-Gg: AYBFou1RlJk3Vm1UcDxZeAUrcbk0xH0gBwrBcsjEpaD6VZO/flXsg0lF09w3yJfAI48
	gvWonesGegyAGBv118wgdL5rnEaPoOSa371fWvZeDlprEVYmI+e/+fofnMrfBwwq+m7TUvMV2gH
	fcNYhzz10zoL4/czA1i4e9xpbvRJfgjzJb3RpLxUTwfyGnqlircMwqbJyMpEEFry0VohG6PKLly
	VCZFKGG5pSMGEfS268Pet5KO/DnJDpn3F7sjAYrbnXXlgw4iZeSTVgHQRjgKy9vjtxGLZjrhx4+
	XdlVt3/wJ4OP9PahX0wRrZ5rmD1Yn7v+/xOowCP2neFRUmOJoYxVy2Hm7OmEK4/MDeIYy+N2Z6J
	jpJkcMMSs1v0uI6ALM2K34b89J507Ne1hqlmxhvciwc359GRwQoGEazIXSA7O04zgyASR3juQ2j
	0/gGc=
X-Received: by 2002:a05:693c:87c1:20b0:36c:c483:7077 with SMTP id 5a478bee46e88-377abbd9353mr220898eec.14.1794409051654;
        Wed, 11 Nov 2026 06:57:31 -0800 (PST)
X-Received: by 2002:a05:693c:87c1:20b0:36c:c483:7077 with SMTP id 5a478bee46e88-377abbd9353mr220869eec.14.1794409050978;
        Wed, 11 Nov 2026 06:57:30 -0800 (PST)
Received: from [192.168.29.10] ([49.37.154.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060c4b6sm17298659eec.15.2026.11.11.06.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 06:57:29 -0800 (PST)
Message-ID: <197d7d58-9791-483f-9a7f-40747f44d1ee@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 20:27:22 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] tee: optee: Register TEE devices on the platform
 bus
To: Eric Biggers <ebiggers@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Selvam Sathappan Periakaruppan <selvam.periakaruppan@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>
References: <20261111-ice-migrate-tee-svc-v2-0-29d19f6c92ab@oss.qualcomm.com>
 <20261111-ice-migrate-tee-svc-v2-4-29d19f6c92ab@oss.qualcomm.com>
Content-Language: en-US
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Organization: Qualcomm
In-Reply-To: <20261111-ice-migrate-tee-svc-v2-4-29d19f6c92ab@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6aa-vpGUEFPhAjjIhCat1fhH7PhZyBWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1OSBTYWx0ZWRfX0PqwFsx5ZeER
 8kajOz4FC1xIJR8XD9vCIN6QrUV0/b3rWT7DzrX9AmYy6gN7fw6Uqv+En82ghhQxJQYKl+RST9R
 rRFaaFHjxR0utWHTdeMXRY0nR0887vKdb1MB/QHsbGvdre0YnEaJD+sqsBCMyU0mQnWCr+ZaQLB
 kM6PsWl8Gh6Nlf7p1JJRYh+CmFewd9uBjMIurXatoWYcxiok4cXvQywEMekTvNe7rS4Tqzg6+01
 cpesqoBlq/nUGo6O2BYvqqjCKrJjNO3sSRINA1EI0t+lXT+YG342g7ak8whe8B8QWyI4lmW6tmG
 UPfeVt0ucP8ftvup07FmEFZiVdJt0eDzU7FEBs1ZIhwmh1PepUFRfarp5tH/Qe9WkPI4uGXCZui
 DY76GPM23YW1/zYMqJ1T5agoFfzKv4HF5qech9l8WCpq7QE26ztAiC5G58R8GKLSIJD4lsW1XAp
 ecVQrsSc3DOzvUgYcIA==
X-Proofpoint-ORIG-GUID: 6aa-vpGUEFPhAjjIhCat1fhH7PhZyBWc
X-Authority-Analysis: v=2.4 cv=O9isLx9W c=1 sm=1 tr=0 ts=6af4825d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=KJEteu+P7FD/DYblE0u4eA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=b45o4kL6AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=cVz09F1fK_0Ztju5R3sA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1OSBTYWx0ZWRfX71y5x7+Yrp5E
 TtyT4yTCKkx/eNuFXmJiGEj3IMpY6CynCjvnQes2vd7y1MlgXJcPowZ/Bewk2ZnpnrRoQpr4+18
 Tf0liYYW7HJxToVA2ZanYPjqLo2D5Uo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110059
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	HAS_ORG_HEADER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4859D44E76
X-Spamd-Bar: ------
Message-ID-Hash: YYQXB3P2PABQ2JZKL2GRAGNFXGQVGLF2
X-Message-ID-Hash: YYQXB3P2PABQ2JZKL2GRAGNFXGQVGLF2
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YYQXB3P2PABQ2JZKL2GRAGNFXGQVGLF2/>
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

+ op-tee@lists.trustedfirmware.org, Jens Wiklander <jens.wiklander@oss.qualcomm.com>

On 11-11-2026 07:47 pm, Harshal Dev wrote:
> The Qualcomm Inline Crypto Engine (ICE) driver is an independent platform
> driver which polls on availability of a TEE interface (SCM driver) before
> checking if the ICE secure service is supported by QTEE by querying the
> qcom_scm_ice_available() API.
> 
> The TEE subsystem currently does not provide any way to notify regarding
> the availability of a TEE interface, i.e. whether QCOMTEE or OPTEE have
> probed. And so when migrating to the TEE subsystem via an ICE TEE client
> driver, ICE needs to defer probe until the OPTEE ICE Pseudo TA becomes
> available on the TEE bus. This means that for OPTEE builds without the
> ICE PTA, the ICE driver would indefintely defer probe and the dependent
> UFS/SDHC storage driver will fail to come online.
> 
> Add support for optionally registering the back-end TEE devices which
> represent a particular TEE (say OPTEE) on the platform bus via the
> tee_platform_device_register() API. This allows drivers which poll on
> TEE secure interface availability to be notified even if the TEE service
> itself is not supported.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> ---
>  MAINTAINERS                                |  1 +
>  drivers/firmware/qcom/qcom_ice_tee.c       | 41 ++++++++++++++++++++++++++++++
>  drivers/soc/qcom/Kconfig                   |  1 +
>  drivers/soc/qcom/ice.c                     |  9 ++++++-
>  drivers/tee/optee/ffa_abi.c                |  8 ++++++
>  drivers/tee/optee/smc_abi.c                |  8 ++++++
>  drivers/tee/tee_core.c                     | 21 +++++++++++++++
>  include/linux/firmware/qcom/qcom_ice_tee.h | 10 ++++++++
>  include/linux/tee_core.h                   |  9 +++++++
>  9 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1132e456488b..06dba76996b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23013,6 +23013,7 @@ L:	linux-arm-msm@vger.kernel.org
>  L:	linux-crypto@vger.kernel.org
>  S:	Maintained
>  F:	drivers/firmware/qcom/qcom_ice_tee.c
> +F:	include/linux/firmware/qcom/qcom_ice_tee.h
>  
>  QUALCOMM INTERCONNECT BWMON DRIVER
>  M:	Krzysztof Kozlowski <krzk@kernel.org>
> diff --git a/drivers/firmware/qcom/qcom_ice_tee.c b/drivers/firmware/qcom/qcom_ice_tee.c
> index 694aa05847f0..39f7094439d9 100644
> --- a/drivers/firmware/qcom/qcom_ice_tee.c
> +++ b/drivers/firmware/qcom/qcom_ice_tee.c
> @@ -5,6 +5,7 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/tee_drv.h>
>  #include <linux/uuid.h>
> @@ -22,6 +23,9 @@
>  
>  #define TEE_NUM_PARAMS				4
>  
> +/* This represents the back-end OPTEE device */
> +static struct device *__teedev;
> +
>  struct qcom_ice_tee_private {
>  	struct device *dev;
>  	struct tee_context *ctx;
> @@ -281,6 +285,18 @@ static int qcom_ice_tee_import_key(struct device *dev,
>  					     lt_key, lt_key_size);
>  }
>  
> +bool qcom_ice_tee_is_available(void)
> +{
> +	/*
> +	 * Paired with smp_load_acquire() in qcom_ice_plat_probe().
> +	 *
> +	 * This marks the availability of the OPTEE interface informing the
> +	 * polling ICE driver that the platform supports a TEE.
> +	 */
> +	return !!smp_load_acquire(&__teedev);
> +}
> +EXPORT_SYMBOL_GPL(qcom_ice_tee_is_available);
> +
>  static bool qcom_ice_tee_has_wrapped_key_support(struct device *dev)
>  {
>  	struct qcom_ice_tee_private *data = dev_get_drvdata(dev);
> @@ -398,5 +414,30 @@ static struct tee_client_driver qcom_ice_tee_driver = {
>  
>  module_tee_client_driver(qcom_ice_tee_driver);
>  
> +static int qcom_ice_plat_probe(struct platform_device *pdev)
> +{
> +	/* Paired with smp_load_acquire() in qcom_ice_tee_is_available() */
> +	smp_store_release(&__teedev, &pdev->dev);
> +	return 0;
> +}
> +
> +static const struct platform_device_id qcom_ice_plat_id_table[] = {
> +	{
> +		.name = "optee",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, qcom_ice_plat_id_table);
> +
> +static struct platform_driver qcom_ice_plat_driver = {
> +	.probe = qcom_ice_plat_probe,
> +	.id_table = qcom_ice_plat_id_table,
> +	.driver = {
> +		.name = "qcom-ice-plat",
> +	},
> +};
> +
> +module_platform_driver(qcom_ice_plat_driver);
> +
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Qualcomm ICE TEE driver");
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 535c8619197b..8dc75c252f52 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -296,6 +296,7 @@ endif
>  config QCOM_INLINE_CRYPTO_ENGINE
>  	tristate
>  	select QCOM_SCM
> +	select QCOM_ICE_TEE
>  
>  config QCOM_KRYO_L2_ACCESSORS
>  	bool
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index 452896b1858f..4844621b7497 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -18,6 +18,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/xarray.h>
>  
> +#include <linux/firmware/qcom/qcom_ice_tee.h>
>  #include <linux/firmware/qcom/qcom_scm.h>
>  
>  #include <soc/qcom/ice.h>
> @@ -132,7 +133,13 @@ static bool qcom_ice_tz_ops_registered(void)
>  
>  static bool qcom_ice_tz_is_available(void)
>  {
> -	return qcom_scm_is_available();
> +	/*
> +	 * Both back-ends should be available before we check for
> +	 * qcom_ice_tz_ops_registered(), otherwise we could pre-maturely
> +	 * assume that TZ does not provide any ICE secure interface.
> +	 */
> +	return (qcom_scm_is_available() & qcom_ice_tee_is_available());
> +
>  }
>  
>  static int qcom_ice_tz_invalidate_key(u32 index)
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 702da7d98fbc..2c0065f3d9e4 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -1177,6 +1177,14 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>  	if (rc)
>  		goto err_unregister_devices;
>  
> +	/*
> +	 * Device should only be visible on the platform bus once the
> +	 * child devices have already been enumerated on the TEE bus.
> +	 */
> +	rc = tee_platform_device_register(optee->teedev, "optee");
> +	if (rc)
> +		goto err_unregister_devices;
> +
>  	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
>  	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
>  	blocking_notifier_chain_register(&optee_rpmb_intf_added,
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 51624443359b..85ee76173982 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1920,6 +1920,14 @@ static int optee_probe(struct platform_device *pdev)
>  	if (rc)
>  		goto err_disable_shm_cache;
>  
> +	/*
> +	 * Device should only be visible on the platform bus once the
> +	 * child devices have already been enumerated on the TEE bus.
> +	 */
> +	rc = tee_platform_device_register(optee->teedev, "optee");
> +	if (rc)
> +		goto err_disable_shm_cache;
> +
>  	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
>  	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
>  	blocking_notifier_chain_register(&optee_rpmb_intf_added,
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 1aac50c7c1de..0d3c266b29c7 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -10,6 +10,7 @@
>  #include <linux/fs.h>
>  #include <linux/idr.h>
>  #include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/overflow.h>
>  #include <linux/slab.h>
>  #include <linux/tee_core.h>
> @@ -1225,6 +1226,26 @@ int tee_device_register(struct tee_device *teedev)
>  }
>  EXPORT_SYMBOL_GPL(tee_device_register);
>  
> +static void plat_tee_free(void *data)
> +{
> +	struct platform_device *plat_dev = data;
> +
> +	platform_device_unregister(plat_dev);
> +}
> +
> +int tee_platform_device_register(struct tee_device *teedev, const char *teename)
> +{
> +	struct platform_device *plat_dev;
> +
> +	plat_dev = platform_device_register_data(&teedev->dev, teename,
> +						 PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(plat_dev))
> +		return PTR_ERR(plat_dev);
> +
> +	devm_add_action_or_reset(&teedev->dev, plat_tee_free, plat_dev);
> +	return 0;
> +}
> +
>  void tee_device_put(struct tee_device *teedev)
>  {
>  	mutex_lock(&teedev->mutex);
> diff --git a/include/linux/firmware/qcom/qcom_ice_tee.h b/include/linux/firmware/qcom/qcom_ice_tee.h
> new file mode 100644
> index 000000000000..a5906c5d4e39
> --- /dev/null
> +++ b/include/linux/firmware/qcom/qcom_ice_tee.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#ifndef __QCOM_ICE_TEE
> +#define __QCOM_ICE_TEE
> +
> +bool qcom_ice_tee_is_available(void);
> +
> +#endif /* __QCOM_ICE_TEE */
> diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
> index f993d5118edd..d5310b404c1e 100644
> --- a/include/linux/tee_core.h
> +++ b/include/linux/tee_core.h
> @@ -205,6 +205,15 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
>   */
>  int tee_device_register(struct tee_device *teedev);
>  
> +/**
> + * tee_platform_device_register() - Registers a TEE platform device
> + * @teedev:	Device to register
> + * @teename:	Name of the TEE the device represents
> + *
> + * @returns: < 0 on failure
> + */
> +int tee_platform_device_register(struct tee_device *teedev, const char *teename);
> +
>  /**
>   * tee_device_unregister() - Removes a TEE device
>   * @teedev:	Device to unregister
> 

