Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F5C606A324
	for <op-tee@archiver.kernel.org>; Tue, 27 Oct 2026 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dNk+1EAY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AgxNn/HZ
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2FC46452AC
	for <op-tee@archiver.kernel.org>; Tue, 27 Oct 2026 12:05:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dNk+1EAY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AgxNn/HZ;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C7A254505C
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 Oct 2026 12:05:16 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAeC6L3026388
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 Oct 2026 12:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/nGrw5+P3Y0pEQR3QfmVNANaa580jD8MzWmdSsoabTc=; b=dNk+1EAYHKu1SkT5
	NZaJqZrSsebaw/pG8/B8UGFtpN04c7sFTDsnVYp8VJeNtOAFONCavKky3Jw49gyZ
	HgiALa8r0pqhmWwL45lfha85g7MsIGCUCbSFjxZeCp+Bf/N+nnBY8TAy7eKl60om
	TA7lSbQt5wScaYf01w6pRO4jth1T1b+/rBPyGUwBzErUIhoFQVzjHViiLdJ6hNLN
	xE9B83B8TojrqLhC50iJvii9sJ3v3bd9NnasTdvctEL3eR+GyIlEi6rtyex92rs5
	fmjhwM082dn9r20UfvaQEvC4yKiaGn4M2aF8JO4Pl7UOhLMkw/6q+JtnLxw5zI5I
	YCr/GQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjh91abjc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 27 Oct 2026 12:05:15 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3aca98f01c1so3948192a91.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 27 Oct 2026 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793102715; x=1793707515; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nGrw5+P3Y0pEQR3QfmVNANaa580jD8MzWmdSsoabTc=;
        b=AgxNn/HZnO9WUpWDqjxD6QAelu8q7qhxqcGXaPrQrUaJdda0fphc4ULLR+EkK7D0dD
         1IHP3Q8jgYrCfSQ++O+v2dEUUG2NxZFU4ydj+e0HkYhmgPNHHY780k5A7XSJt+bCEUz7
         G+wmaHdfw9vF83gq3xNmG96X95EhKn3ubo+X6gsBp3XjNu4agpjTfWKtFtDWppzP5jxU
         L1qn18AEWSZ+KL6wHEN0O4WE+RT1UBbDPWdeEi8qgCRBiMA/+ySR4mwaOjyR7WTkDp8W
         FrrhAkdFdQddo3n9lAZldsdj7MN03vMXllOkP91vhy2NMgN1zrcRhDUiG37NMKazVcVF
         dkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793102715; x=1793707515;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/nGrw5+P3Y0pEQR3QfmVNANaa580jD8MzWmdSsoabTc=;
        b=0s1x8436n3oygudqHKCuGzy8DDYmMuDBGTsrRxP7DZJs8BWxf73iCYZ4tJVtbRz8aC
         Gk39GMpImc4IsUBA1q11mf6+y1tIlZZd/QPLGwokjcjnMp+R7QhHUpq1RHP9LmV6bcxb
         KoySlhyOhqQUnlMBnkoTmVqXi9LLqB6qEZaVxtMgUZA9IY5UjkBsrox7OF23o0Mdclzg
         HPFuG+1CKWJkAl9meBoWIJ1SLQeQk316x8sqPmRY8EYr63Lv5poviYU6TOvNTaJnijfD
         V70K4Ci/vhvtf0Rx0oIw1KkFa2dA8BKm1cf4IF+hkR/TPMWdEXkSSeOvJKaIpH0cXy0J
         NLGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwDSTa0TjEjUdyB0uN5So1AveqqyMOoQ95MGSuMZAYXRCBFT5a3790KDBOUMy4cAH+EM6V5+c=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJmPxv99Xqtp/81OPWAnq5oiaaGEK4sqixvvRFMbiGcYCgp9StG
	Nl1mzDcwOYEqFwHJfoeP3xMY3IdTPr7ftu2jhVcifX4DbLxpA4AKBA/kNMPM2YbI3Nwqb77s4ZS
	2/KKpbS8RdaVhwMhXJFlgW8gID8pPPrUQ5A7g1gFDrnqj9l0bs66ONB7gVob+qZHHlhCLtS4K
X-Gm-Gg: AYBFou0+j0HNVW+p/VccK0WVWqzEN2EbfIOHQNUe8iStXNpz09YrvkyzSEY4kBGuhPY
	vN9nr3/bvVrtjuGJ6KqqBZp96U6sdG6JtWxsN4ek4TELXKdGXOZkf2jxBCxA/q6Ur/2THC+lt7W
	d7CDYGpBdJFAkeAxiUqCRA/6SHox74GlXNMaVDL8uRaDwvpKEoT4K9kOZz9MF1cisSNNflmVgFc
	+XjAmEcm4ncHFhkpzw9GnTYZsBms8xTGo1RUyGAm96QbOyzrltQshYXGb95762bcOPU4IAWHjjj
	BcJmdrwwg6cNGDoPT3eA7oQLzoMyzYgeHoMAsuE2OpRLZ3J61VmXpu/oK3dKy/xxO18gFCh/0jf
	0LEWOFBt+WFlyLJc/4Gh/hoz8JIP1eXE=
X-Received: by 2002:a17:90b:57e3:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3adeb0fc65emr8055393a91.52.1793102714684;
        Tue, 27 Oct 2026 05:05:14 -0700 (PDT)
X-Received: by 2002:a17:90b:57e3:b0:3ab:17b6:9a93 with SMTP id 98e67ed59e1d1-3adeb0fc65emr8055353a91.52.1793102714216;
        Tue, 27 Oct 2026 05:05:14 -0700 (PDT)
Received: from [10.204.101.238] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404746b3sm3697041a91.17.2026.10.27.05.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 05:05:13 -0700 (PDT)
Message-ID: <1c24fbfd-bc88-41d9-8632-76c5dad9f2c8@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 17:34:57 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] media: qcom: Pass proper PAS ID to set_remote_state
 API
To: Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, bod@kernel.org
References: <20261027-pas-id-media-v10-1-8a5312d3050e@oss.qualcomm.com>
Content-Language: en-US
From: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
In-Reply-To: <20261027-pas-id-media-v10-1-8a5312d3050e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LEwAhj-0XmhCnirxwELBZzBKzRChP14s
X-Proofpoint-GUID: LEwAhj-0XmhCnirxwELBZzBKzRChP14s
X-Authority-Analysis: v=2.4 cv=TuxzFzXh c=1 sm=1 tr=0 ts=6ae0937b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rTiepDLV5_WpOwre6ukA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX5rW2q7zBE3sQ
 KRmVIChEIO/KeanE8LO4EgQOaQzO0H9baqPaF4NSV+ZclpVCW+7AHZWRcE4YA6gU4Ws8LmoRhIR
 +d0N93VUHocod5Sfn8ZH73Bw0yVaZkrVgwO4kWuS0o2Ep5EuiI9OdrLwwkw88y54nHOZkleqBo7
 4XUPKBdoumwfHCs2r/dRxT8RAQ7Lw7OcKmR9hJ1CExeLdP/6Gjmpj97QqHHDvQOm5sU4KAleTlH
 oX/H3yGQG/xy6T6SfdbHuhx0AbztEw3v78RsIREgeo4xOSYIUkcrEWYQhvp5PxU/iRIzkwtTnbB
 JSt3/rZlDivxHWCk9WJw6hZ2q2/GFJLQ6cT/HfieYttTtOkNomSrtmlEwhOEh3Mq3oVXDYSt4UW
 BKEy5ivFPKOUjJIwr2CuSV3H7CHd9oB6TNJd1GLva9tT8+zegtQ0Q55shViatmStLu/GX2A6isZ
 0FBMDzc8jCDRpDFHRcQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA0OCBTYWx0ZWRfX+JJyOtaZKzCp
 m8oF1bUnW3MDF9u1BRzKfKeGKp8BGw9mmsuvYKtA+mpoJO00TaJgzF8cl/62ahf+E4FF2KOVrV8
 JCm+RbBZjQgk5cj9ejFHP9Z6mJE9z5I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270048
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCPT_COUNT_GT_50(0.00)[50];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C7A254505C
X-Spamd-Bar: ----
Message-ID-Hash: 537SM3ZEWELCQ6QRQOWMJPQVIK272LRR
X-Message-ID-Hash: 537SM3ZEWELCQ6QRQOWMJPQVIK272LRR
X-MailFrom: gourav.kumar@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcom
 m.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/537SM3ZEWELCQ6QRQOWMJPQVIK272LRR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/2026 5:32 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> As per testing the SCM backend just ignores it while OP-TEE makes
> use of it to for proper book keeping purpose.
> 
> Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
> Changes in v10:
> - Resent standalone, as all the earlier patches of the series are merged.
> - Link to v9: https://lore.kernel.org/all/20260702115835.167602-11-sumit.garg@kernel.org/
> ---
>  drivers/media/platform/qcom/iris/iris_firmware.c | 2 +-
>  drivers/media/platform/qcom/venus/firmware.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
> index 21f57d37da18..ed2bd0e83797 100644
> --- a/drivers/media/platform/qcom/iris/iris_firmware.c
> +++ b/drivers/media/platform/qcom/iris/iris_firmware.c
> @@ -262,5 +262,5 @@ int iris_fw_unload(struct iris_core *core)
>  
>  int iris_set_hw_state(struct iris_core *core, bool resume)
>  {
> -	return qcom_pas_set_remote_state(resume, 0);
> +	return qcom_pas_set_remote_state(resume, IRIS_PAS_ID);
>  }
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3a38ff985822..3c0727ea137d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -59,7 +59,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	int ret;
>  
>  	if (core->use_tz) {
> -		ret = qcom_pas_set_remote_state(resume, 0);
> +		ret = qcom_pas_set_remote_state(resume, VENUS_PAS_ID);
>  		if (resume && ret == -EINVAL)
>  			ret = 0;
>  		return ret;
> 
> ---
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> change-id: 20261027-pas-id-media-7cc70fc5716f
> 
> Best regards,

Reviewed-by: Gourav Kumar <gourav.kumar@oss.qualcomm.com>
