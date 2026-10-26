Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E89606A31A
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.trustedfirmware.org header.i=@lists.trustedfirmware.org header.a=rsa-sha256 header.s=2024 header.b=0WxlxIUT;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oP2bypCd;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RmY+tsik
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C6B024528A
	for <op-tee@archiver.kernel.org>; Mon, 26 Oct 2026 03:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792984555;
	bh=fQ5ME7zsofh/MTjAyNzwL0ss0fhQ6EES/cdp8UbPSwk=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0WxlxIUT8OXqsoYT/SC595YbFPQIqBoDV2Sy/mo/ttzeFZ1xeJlaVIZDibO/Iv8Hy
	 RFxhJ9wwTlxxUuSE7PF29W3xFQB1g9MF2hi1ApygIKROoX1ApPJXpLyiYBgF03J7/I
	 EmfpOnWI/8hUEJueeucNHpvsMZKLoS4k/6rlXQ4nhUtjdi/KPGuFKqcVMDSSKPeMk1
	 +8FURy4A/WLsuNyrtDwU5EQfWtR79piKNhKxYVXx3N3yyM1//OcTByPgT9yn7W2cn7
	 k5a9puEkVjnqmBohEHdbPBw5qvqzvWcroeHP036O/0FG/rqxDKhXS68hDFEZcqeinj
	 IAY6FHoJHHt2Q==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7D44144848
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:15:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oP2bypCd;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RmY+tsik;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2Ktek3015715
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zL+HOVtTShiOnA5Z9yjUoWL/r26J7UkWfw3YA85MUM4=; b=oP2bypCdgol5qbs2
	Pn99cR5yhRkfLXEFPRsSqAKL9FslBbFCXY3Ce8qw6XV7Qmy16we60zdfAnGDs6N4
	8MwEawhfPs11Azut97fSpHyyQQuwQf80ZkYs8rOct2RcbKqsQ1cgMl2cdvpcZ3zV
	qLix9NpdRU3ilJbd0vqwi4oz2icmCJORfJg8J+5BngXeBjR0pCamHJ1QeEIFtUNu
	mLWEqnyLc7r0+3mCqfqDCl6aSTeo2OoBwI/VMiR88uQpSbbDCNHf/Bzaj4w3cqUL
	i4UJ2WmMjvwCZhuh+EeOGf2zBjebPx6Bz1XUnhQNI3tDeRzP9m8t0YnU6z/vCXM2
	0a1SiA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hhshprm26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 26 Oct 2026 03:15:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd67d4bbdffso1995977a12.3
        for <op-tee@lists.trustedfirmware.org>; Sun, 25 Oct 2026 20:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792984534; x=1793589334; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zL+HOVtTShiOnA5Z9yjUoWL/r26J7UkWfw3YA85MUM4=;
        b=RmY+tsikpavKRuaznbDkSctiYiCFkZV9JEcdnIAW/y8NgD4pNnbOC9ob+8jQbAKNWs
         ZAVRSDSOIdZIBtmG/RI/5FLkDUJ4+2c6917+w4PuJ+IOqyA/nKIdgVPiydUV28JRf4ZN
         6aEFWFNuaRaVKsQKrVfUCT4PeOxoqUriKDqB+C17m9OwARydvRb4I32zAEQMx7IV3NKC
         zAoYSdTOys2/xbcJ9kRld+R20Iiqm5RFwzjJSKDt0vdalIfvaz/aX8/e9g/Ip7H95qqk
         846HPtIRi/8PBO5aMjzshTYWtDVWub0kIBGeFmtA9rB8NSt0HhbXCJJV5J0LxaSAwj+V
         O+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792984534; x=1793589334;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zL+HOVtTShiOnA5Z9yjUoWL/r26J7UkWfw3YA85MUM4=;
        b=WqcV3vZV11Aa9EdjhUj9JptAoYAVpabWVf9ymMAd5ZkgqtIgDBY5AKA+o5/e2sVgaD
         6wYjrvK3aGPUokFmBrZY6pY0xP4M/OU/8w9tFEYUTxMBOj+S0wVyXRyDOvizFbSRBmV+
         yKYOozuTORwu0SMaHKsIxAUKvZtdFbkm1EucxDfnTgTRxZ7hxuNbtSYh7jIaB1rBOTIV
         +gkyKg13Vkycp9BezIQ5/FTtkYl6ru8g/pg0wRv8KK8WsnWtEuLbSlUD3C9Q9A+PmfPJ
         y77ZWA4D2F/dq+imbjadzr2ud8euM2dGTRbrt5cjLA4C/eHd4ufR/y70lX/Hxkatgjs3
         RVhg==
X-Forwarded-Encrypted: i=1; AKwUvBzENI8EmpzBcPs76LDtXIrWrUKayctOBPU2tj+kOK19RUvyNF9fbTqPzr/Voiq3sPD03xysGVs=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLoDHrRh0ht79VAAuilyzvIL6/czRDvydQxmFNqn6FeYzJ3ZmVY
	UkyYpzm72g0901CZ3gXjOzpG74x0KJaX8m2wDGWkXkgEI1t00S0ClU7bc1R8CWJuVZdRusIDuHR
	aMxjB/VjWc/GDAsxFUjgdBIad/9BXN1eHP21iDermHYRh/Hrs90nAKHQVQjCxCSB0GkFjvO4=
X-Gm-Gg: AYBFou20ySdPrgdxvJX0aq6Urgnuxeh7adBDRYI1rEplN23wFsgJOrqOqAg/d5D5OSt
	WJ6O519R31cAq96nzMVRDDGdZ4FbywmUJxG1Jmi5JZeQCmRY7b9mvKwqfgE0P/uQit+rz+dqh75
	riqWmuuj+AEFWnWSPiz5daDDbnuz3qwZv6rsRNIjo0nPQsAchJq7LXSFasnhKCR+jBEQ1HeE0P7
	qcOS5xEdIEl12KmE3YnHPQufn4KFmKu2783Jru82wHM17xa1l8riztR/9Z0IyUqQfeL1bzc0EwB
	NKsaN84g+0uolL8JDWY8lXfIgnnaTbHaahP5x897tJG2KBv9Jzf5+t+ndHgSq3hSV3QPH+BAgjj
	vcaNT3jbaDlA1Wk09z4bgBL2nkp/zFtty
X-Received: by 2002:a17:903:244b:b0:2e9:7719:40f0 with SMTP id d9443c01a7336-2ea9c6205fcmr48433995ad.19.1792984534293;
        Sun, 25 Oct 2026 20:15:34 -0700 (PDT)
X-Received: by 2002:a17:903:244b:b0:2e9:7719:40f0 with SMTP id d9443c01a7336-2ea9c6205fcmr48433635ad.19.1792984533645;
        Sun, 25 Oct 2026 20:15:33 -0700 (PDT)
Received: from [192.168.1.86] ([206.83.119.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b120095sm10620575ad.16.2026.10.25.20.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 20:15:33 -0700 (PDT)
Message-ID: <952816ce-3e37-4628-8308-4208b4359549@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 14:15:26 +1100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] tee: qcomtee: Allow object invokes from kernel
 clients
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
 <20261015-qcom_uefisecapp_migrate_qcomtee-v5-3-1460691b35d3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-3-1460691b35d3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDAxMiBTYWx0ZWRfX4baiQJu7IuDa
 eqpX1WInIULTz6hGqV36XmP10YLsp2fuqGfQWXftK4IRXk7Zqdcsf7/Xe+K48AmBc0zA/C/I9Pr
 5hwDzN7TzdAjUT2syoeVSN8J+p9WAgk=
X-Proofpoint-GUID: 9EbnrQLPfJ-Quo4qblRK-TWrKxKcl3eV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDAxMiBTYWx0ZWRfX9Av0Rn+pVLoo
 CH5LeTQR56FHWWdUr0iUVI9Wfav6bXpFK2QPBcwoGoPa8juMTAPEb7DXKLYS2YbM3H7uXgzJmeR
 ux9sivOzjN/YXeF+vz0uchHwb5YRiP1OS0BRrSS3l3a2cWaGznl1Cce7ka5oPkGZLPjbX5bGugs
 QDwNQZ8+pJ+y1qEswYRWAD0UoExdShXedKPyn7AGC6lf9I1aMQkw+lHc2d9gTACh2PjjDq3dQ8y
 mLcYZSqVGXIb73P0Q1QLkKj3TrvdDhkSvqg8OWy7rG7hcRq9tUHq0bbJ9KS3FBIU/YM/lK1mP7K
 L0PSk4HqOavjf++7N2R08Jm3XvAfdICmGAcykG8Nv5moPJaF6UdriTpMPj+g9mWuBRFUvNc51oa
 8GTYhxXrtOHvLsRuHUy+CaNzbmvnrwKgVQfMhOzhuSGYdN+bwimdH7YFb0hHiLPDOBDbqp6qbx6
 wmNx+GHw47pQoP74XIw==
X-Authority-Analysis: v=2.4 cv=HZWB3SE8 c=1 sm=1 tr=0 ts=6adec5d7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=pnHLkUe0LhHGSDu6DPowAg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=bMymjuXEMpCr_xxdz14A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 9EbnrQLPfJ-Quo4qblRK-TWrKxKcl3eV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7D44144848
X-Spamd-Bar: ----
Message-ID-Hash: FOAUD2NVHOBIHISB6OCMCSSQ66V6OIZJ
X-Message-ID-Hash: FOAUD2NVHOBIHISB6OCMCSSQ66V6OIZJ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FOAUD2NVHOBIHISB6OCMCSSQ66V6OIZJ/>
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
> From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> 
> QCOMTEE currently treats UBUF parameters as userspace addresses and
> applies userspace restrictions when invoking the root object. This is
> not suitable for object invocation requests issued by kernel clients.
> 
> Use the kernel_ctx flag to distinguish kernel client requests from
> userspace requests. For kernel contexts, do not mark UBUF parameters as
> user addresses, and allow permitted root-object operations to proceed
> without applying the userspace-only checks.
> 
> This allows in-kernel users of tee_client_object_invoke_func() to issue
> object invocation requests through the qcomtee backend.
> 
> Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Same here.

- Amir

> ---
>  drivers/tee/qcomtee/call.c           | 38 ++++++++++++++++++++++++------------
>  drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
>  include/linux/tee_drv.h              |  5 ++++-
>  3 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index 3de54af45719..c97afaa1b4aa 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -193,7 +193,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
>   * @u: QTEE arguments.
>   * @params: TEE parameters.
>   * @num_params: number of elements in the parameter array.
> - * @ctx: context in which the conversion should happen.
> + * @oic: context to use for the current invocation.
>   *
>   * It assumes @u has at least @num_params + 1 entries and has been initialized
>   * with %QCOMTEE_ARG_TYPE_INV as &struct qcomtee_arg.type.
> @@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
>   */
>  static int qcomtee_params_to_args(struct qcomtee_arg *u,
>  				  struct tee_param *params, int num_params,
> -				  struct tee_context *ctx)
> +				  struct qcomtee_object_invoke_ctx *oic)
>  {
>  	int i;
>  
> @@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>  		switch (params[i].attr) {
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
> -			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
> -			u[i].b.uaddr = params[i].u.ubuf.uaddr;
> +			if (oic->kernel_ctx) {
> +				u[i].flags = 0;
> +				u[i].b.addr = params[i].u.ubuf.addr;
> +			} else {
> +				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
> +				u[i].b.uaddr = params[i].u.ubuf.uaddr;
> +			}
> +
>  			u[i].b.size = params[i].u.ubuf.size;
>  
>  			if (params[i].attr ==
> @@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>  			break;
>  		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
>  			u[i].type = QCOMTEE_ARG_TYPE_IO;
> -			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
> +			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
>  				goto out_failed;
>  
>  			break;
> @@ -260,7 +266,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>   * @params: TEE parameters.
>   * @u: QTEE arguments.
>   * @num_params: number of elements in the parameter array.
> - * @ctx: context in which the conversion should happen.
> + * @oic: context to use for the current invocation.
>   *
>   * @u should have already been initialized by qcomtee_params_to_args().
>   * This also represents the end of a QTEE invocation that started with
> @@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
>   */
>  static int qcomtee_params_from_args(struct tee_param *params,
>  				    struct qcomtee_arg *u, int num_params,
> -				    struct tee_context *ctx)
> +				    struct qcomtee_object_invoke_ctx *oic)
>  {
>  	int i, np;
>  
> @@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
>  			break;
>  		case QCOMTEE_ARG_TYPE_OO:
>  			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
> -			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
> +			if (qcomtee_objref_from_arg(&params[np], &u[np],
> +						    oic->ctx))
>  				goto out_failed;
>  
>  			break;
> @@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
>  	/* Undo qcomtee_objref_from_arg(). */
>  	for (i = 0; i < np; i++) {
>  		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
> -			qcomtee_context_del_qtee_object(&params[i], ctx);
> +			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
>  	}
>  
>  	/* Release any IO and OO objects not processed. */
> @@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
>  }
>  
>  /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
> -static int qcomtee_root_object_check(u32 op, struct tee_param *params,
> +static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
> +				     u32 op, struct tee_param *params,
>  				     int num_params)
>  {
>  	/* Some privileged operations recognized by QTEE. */
> @@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
>  	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
>  		return -EINVAL;
>  
> +	if (oic->kernel_ctx)
> +		return 0;
> +
>  	/*
>  	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
>  	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
> @@ -430,7 +441,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  	/* Get an object to invoke. */
>  	if (arg->id == TEE_OBJREF_NULL) {
>  		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
> -		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
> +		if (qcomtee_root_object_check(oic, arg->op, params,
> +					      arg->num_params))
>  			return -EINVAL;
>  
>  		object = ROOT_QCOMTEE_OBJECT;
> @@ -438,7 +450,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  		return -EINVAL;
>  	}
>  
> -	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
> +	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
>  	if (ret)
>  		goto out;
>  
> @@ -456,7 +468,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
>  
>  	if (!result) {
>  		/* Assume service is UNAVAIL if unable to process the result. */
> -		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
> +		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
>  			result = QCOMTEE_MSG_ERROR_UNAVAIL;
>  	} else {
>  		/*
> diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
> index 5f40617361fc..a241ab657318 100644
> --- a/drivers/tee/qcomtee/qcomtee_object.h
> +++ b/drivers/tee/qcomtee/qcomtee_object.h
> @@ -113,8 +113,9 @@ struct qcomtee_buffer {
>   * @b: address and size if the type of argument is a buffer.
>   * @o: object instance if the type of argument is an object.
>   *
> - * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
> - * states that &qcomtee_arg.b contains a userspace address in uaddr.
> + * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
> + * that &qcomtee_arg.b contains a userspace address in uaddr.
> + * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
>   */
>  struct qcomtee_arg {
>  	enum qcomtee_arg_type type;
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 369c87ad0205..367208210a32 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -83,7 +83,10 @@ struct tee_param_memref {
>  };
>  
>  struct tee_param_ubuf {
> -	void __user *uaddr;
> +	union {
> +		void *addr;
> +		void __user *uaddr;
> +	};
>  	size_t size;
>  };
>  
> 

