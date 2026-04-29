Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2934FF8867
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 13:33:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F3D9243AD6
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777469588;
	bh=MgBynsG615Gay9WuPdHInOpVB6+mXWxzVoohqxlsbEU=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=LhKjS+2ZCmZOVhopVfH2ThCJWJ6/kl6m9tAIHXldtgHBwQbM3snZQFb2AAIJTnD5a
	 hl0RIMrJPLWSQyJ5FuH4QJEKwbQXAXPRheP7OemrWj5DK5W/rwGSyRPzKPuQWN7ZH5
	 NgfMBsEd8zW6k+XPrOkqab6MeJUJLJt7SCDZ0OS2j2bHBH8D96ehWS0bSiuhay+vWq
	 DEvlWPDysZ5jLz9DapUDyZ4bZ04z1pDCHYi/4cILoJv4dL8NFqjDrjmrDTdiPhz9nR
	 sJPKmaAmat7SzkftAK//N2/plrOQP3gpBW8e01gTOxrnac4EDICDpKxMg5+W3HG8Q5
	 xOJbTjiyLnT6Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EB61643AD6
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:25:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DQYPFip/;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YxczKhvM;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8qEN93066947
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tESQm7/a22Cxh8QWHH7UiC0w
	dXJ6q1GIcYXgrhUKjnI=; b=DQYPFip/26hMD9exGNiQGhlON3S2bUV+8JfEYY9J
	Zx8ygITz/GtbM469Eq0PdgOS2noAWfj2Sra+9IJKYoatpUNmxT2vk/EsA/zewz2f
	THlpaOd9s5w5FK9gJadkUJhwBybrPpVTrPDBCChPn7ppTjgtxcjVg7F8obba83nV
	77cLKYPNgxlpc8k8OudwNa5NpdrfDgrI5yeoXlvjSJLCFfJIU7YcMa5bLJmoW2Sg
	ia/16AVPOY++1fIkbEzclcTHiZgEntPqkZ4Rh5OYP7CsqWjZ1Jx7GfTpA57LYOOx
	LUXrkAuHeqmYafFkaYwgBfiYgxjLHaEybXL/AE//v8vRBA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sxanqk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 13:25:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2e6ee9444so8300925ad.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777469129; x=1778073929; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tESQm7/a22Cxh8QWHH7UiC0wdXJ6q1GIcYXgrhUKjnI=;
        b=YxczKhvMRGdmypXspqPKDdwv9WLtGy5ys6hN9NDPVtyvTqJV7+q0XRHiWwf/kVK4rs
         jp8pF6Jt9Qg2hUOXv5cSMn2qn+a/QQYM0YqqNYCaCxVN1qe+YAmMwuGwp2ueLuJFyc3k
         +yD3lZiVbnIl1yh2OJiLdRfe44KgWVGnA27vASjAiV1SXxoJRPts/E0tJFMfK/tC3bfO
         JoSHfI+DCGRdHmLU/rWXWhXd0Yir8NghM7rweaDjorq30TscU3aYOxnnanv3RdcVXR88
         zFWy3naQxjZo5DdRHsq4UEydo9Z4Ly3vw7okK6dCZhVvT9YZ9CZg9+nNiPYfZzYlCAED
         AgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469129; x=1778073929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tESQm7/a22Cxh8QWHH7UiC0wdXJ6q1GIcYXgrhUKjnI=;
        b=nEB6hvANmdIwK33ipxpSMMB2bWNVI1uluToS8UE+xHU9ZZbfGjNIVDDWku3PZ18Gt5
         2ubXk6ZOsw2MK+pJLHIFsymApM5A1fysbuAihx9kbqXdkGrQnZlH8gcPx9PMV8IXPV6b
         pSLKY/WDXAAhubZ8L1Q7svHWcr17CgeoPCupFZndEjwld29EHvbVTWadQR+fNqM6WbYM
         h/hmGPexdYVdtAL1GWr5RmJh9b4ZqLsORzUWJbwd+vdpdrsEad6kNbLCKWbMRauxOKBw
         yRMS3OpJVAiHbjdKwYWv7cMCg+NYJuOe43yjEg5egIkvQAXJBQfF+8X2ypvbHbo8Wxz/
         WnoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DgTGCwa0LWRT30Tl1iaXmczCbttxwqnH07K9IP4H32vD0LRfvwIgHSDzADHWFQYyyQ9gus5g=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw5l83Y2Dc3YhFsn7jx5QwGa+0+RDRM2bHtOetCl50Ags/BW/Sq
	eSMeCBV45s+an+wWd29JkYH/Uv6g1L8gYti2jshU/BPcxtpcZKcbyzIYjHlR5SBfKZk0PgPYh6u
	HM32XtwLy0v29SyCKWIRsCYKYsVwDAGA7b0ueRa9GkqS+6Vk/eXpTAPUGR0Ohm0Xu5ko7Nx/p
X-Gm-Gg: AeBDietwYkqxbuB062cjEgjj3qh8sHV9wuzgFGynZsVDu2gMpSe/8qfCf1je3EGFCX+
	lEBby4g/JOJtRfo37GusHvC2Ml8rObU8hmt7rJ3SW4HQmngIbfbMJuZnd3edxEI5qTg41WTSaon
	3JQw/FjEjOvAjgDQx2O7JEHxrVmDUuECsmBl+vb4qyLNTHf6DcVuqao5HKUfF/Brc4+ZYEfBp1t
	u9WzB5zdM2MS8TEMMe2miNl751I+myT8cghickDB1GZYLUa7zZaPwJ6CxE4ZUMq1gaNJCstONWU
	3Sq3RIlcJjYBJ7jeAfjl38Nqebhqnx28r57xdBDSaJSBrr3IHfA6airW1Aeo77W046Vo8v1b8A0
	3hWzW3DLAK89rAszgv1iOLx2rfFh16LAQ+ied2Di2+eSGHt+43nob+OXZB1w=
X-Received: by 2002:a17:902:ef06:b0:2b9:6cde:c345 with SMTP id d9443c01a7336-2b98823923cmr28866775ad.18.1777469128644;
        Wed, 29 Apr 2026 06:25:28 -0700 (PDT)
X-Received: by 2002:a17:902:ef06:b0:2b9:6cde:c345 with SMTP id d9443c01a7336-2b98823923cmr28866375ad.18.1777469128039;
        Wed, 29 Apr 2026 06:25:28 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98893f4e7sm24343015ad.39.2026.04.29.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 06:25:27 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:55:12 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 05/15] remoteproc: qcom_q6v5_pas: Switch over to
 generic PAS TZ APIs
Message-ID: <20260429132512.aki4vqkhpil7awc3@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-6-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-6-sumit.garg@kernel.org>
X-Proofpoint-GUID: PFCrJVMljW_XE4JEO77MoFjdvvRfXTV5
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f206ca cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=OiisSXWjcB2wRZQgg0QA:9 a=CjuIK1q_8ugA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDEzNiBTYWx0ZWRfX/REDJhkRFBMk
 8QtbHW8dfGg+brca/jLnaVrBOTjg6F8BmmHidVONSG5YsTy+MEmTYmD3PTNhzTg/G4CibQVTBfK
 vk4QFrIoUCIuHz5warXi4D6xz62H8XNA0c0wReqklOeBRkRL7t+t61hpbcCvkFIbKN9f0xV+3+m
 Lx0W2MjME8tsN3Ey2f91K5NT1AkjJd7SaOC9tTL5rjyYHgTtvk4sVpA2fVrQpjHwMP9OT0jYM9P
 9FUNz4bUqVeViNv40l44BpZmHtNz6UiTojnvNiiza8M3zoAlhTy/YOZYT0WBy/DBOhdZH7dm9oR
 3axmoL/RAkzynd9q+l4awoB3A7SRvhddbEOjT97nx0dy7Q4uSKKxwY1lCddZ3qgT9mPJqcXh2xz
 gFAi+UgySc/wDePA610k57/lssL22GXS6HKA8aWQjLHSggCiM2ULHDXISblcVV5eK11IyNAgyOR
 rkzws5PIo6HwSNkW6PQ==
X-Proofpoint-ORIG-GUID: PFCrJVMljW_XE4JEO77MoFjdvvRfXTV5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: EB61643AD6
X-Spamd-Bar: --
Message-ID-Hash: B53VQEEZSBOXRWGY6HTYNY2X7YYCWBW6
X-Message-ID-Hash: B53VQEEZSBOXRWGY6HTYNY2X7YYCWBW6
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B53VQEEZSBOXRWGY6HTYNY2X7YYCWBW6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:25:53PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch qcom_q6v5_pas client driver over to generic PAS TZ APIs. Generic PAS
> TZ service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 51 +++++++++++++++---------------
>  1 file changed, 26 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index da27d1d3c9da..847249c28c1b 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -20,6 +20,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/firmware/qcom/qcom_pas.h>
>  #include <linux/firmware/qcom/qcom_scm.h>

Can you check do we really need this header ?

>  #include <linux/regulator/consumer.h>
>  #include <linux/remoteproc.h>
> @@ -118,8 +119,8 @@ struct qcom_pas {
>  	struct qcom_rproc_ssr ssr_subdev;
>  	struct qcom_sysmon *sysmon;
>  
> -	struct qcom_scm_pas_context *pas_ctx;
> -	struct qcom_scm_pas_context *dtb_pas_ctx;
> +	struct qcom_pas_context *pas_ctx;
> +	struct qcom_pas_context *dtb_pas_ctx;
>  };
>  
>  static void qcom_pas_segment_dump(struct rproc *rproc,
> @@ -196,7 +197,7 @@ static int qcom_pas_shutdown_poll_decrypt(struct qcom_pas *pas)
>  
>  	do {
>  		msleep(QCOM_PAS_DECRYPT_SHUTDOWN_DELAY_MS);
> -		ret = qcom_scm_pas_shutdown(pas->pas_id);
> +		ret = qcom_pas_shutdown(pas->pas_id);
>  	} while (ret == -EINVAL && --retry_num);
>  
>  	return ret;
> @@ -212,9 +213,9 @@ static int qcom_pas_unprepare(struct rproc *rproc)
>  	 * auth_and_reset() was successful, but in other cases clean it up
>  	 * here.
>  	 */
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  	return 0;
>  }
> @@ -228,9 +229,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
>  	pas->firmware = fw;
>  
>  	if (pas->lite_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_pas_id);
> +		qcom_pas_shutdown(pas->lite_pas_id);
>  	if (pas->lite_dtb_pas_id)
> -		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
> +		qcom_pas_shutdown(pas->lite_dtb_pas_id);
>  
>  	if (pas->dtb_pas_id) {
>  		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
> @@ -250,7 +251,7 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
>  	return 0;
>  
>  release_dtb_metadata:
> -	qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +	qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  	release_firmware(pas->dtb_firmware);
>  
>  	return ret;
> @@ -310,7 +311,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  		if (ret)
>  			goto disable_px_supply;
>  
> -		ret = qcom_scm_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
> +		ret = qcom_pas_prepare_and_auth_reset(pas->dtb_pas_ctx);
>  		if (ret) {
>  			dev_err(pas->dev,
>  				"failed to authenticate dtb image and release reset\n");
> @@ -329,7 +330,7 @@ static int qcom_pas_start(struct rproc *rproc)
>  	if (ret)
>  		goto release_pas_metadata;
>  
> -	ret = qcom_scm_pas_prepare_and_auth_reset(pas->pas_ctx);
> +	ret = qcom_pas_prepare_and_auth_reset(pas->pas_ctx);
>  	if (ret) {
>  		dev_err(pas->dev,
>  			"failed to authenticate image and release reset\n");
> @@ -339,13 +340,13 @@ static int qcom_pas_start(struct rproc *rproc)
>  	ret = qcom_q6v5_wait_for_start(&pas->q6v5, msecs_to_jiffies(5000));
>  	if (ret == -ETIMEDOUT) {
>  		dev_err(pas->dev, "start timed out\n");
> -		qcom_scm_pas_shutdown(pas->pas_id);
> +		qcom_pas_shutdown(pas->pas_id);
>  		goto unmap_carveout;
>  	}
>  
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  	/* firmware is used to pass reference from qcom_pas_start(), drop it now */
>  	pas->firmware = NULL;
> @@ -355,9 +356,9 @@ static int qcom_pas_start(struct rproc *rproc)
>  unmap_carveout:
>  	qcom_pas_unmap_carveout(rproc, pas->mem_phys, pas->mem_size);
>  release_pas_metadata:
> -	qcom_scm_pas_metadata_release(pas->pas_ctx);
> +	qcom_pas_metadata_release(pas->pas_ctx);
>  	if (pas->dtb_pas_id)
> -		qcom_scm_pas_metadata_release(pas->dtb_pas_ctx);
> +		qcom_pas_metadata_release(pas->dtb_pas_ctx);
>  
>  unmap_dtb_carveout:
>  	if (pas->dtb_pas_id)
> @@ -406,7 +407,7 @@ static int qcom_pas_stop(struct rproc *rproc)
>  	if (ret == -ETIMEDOUT)
>  		dev_err(pas->dev, "timed out on wait\n");
>  
> -	ret = qcom_scm_pas_shutdown(pas->pas_id);
> +	ret = qcom_pas_shutdown(pas->pas_id);
>  	if (ret && pas->decrypt_shutdown)
>  		ret = qcom_pas_shutdown_poll_decrypt(pas);
>  
> @@ -414,7 +415,7 @@ static int qcom_pas_stop(struct rproc *rproc)
>  		dev_err(pas->dev, "failed to shutdown: %d\n", ret);
>  
>  	if (pas->dtb_pas_id) {
> -		ret = qcom_scm_pas_shutdown(pas->dtb_pas_id);
> +		ret = qcom_pas_shutdown(pas->dtb_pas_id);
>  		if (ret)
>  			dev_err(pas->dev, "failed to shutdown dtb: %d\n", ret);
>  
> @@ -484,11 +485,11 @@ static int qcom_pas_parse_firmware(struct rproc *rproc, const struct firmware *f
>  	 *
>  	 * Here, we call rproc_elf_load_rsc_table() to check firmware binary has resources
>  	 * or not and if it is not having then we pass NULL and zero as input resource
> -	 * table pointer and size respectively to the argument of qcom_scm_pas_get_rsc_table()
> +	 * table pointer and size respectively to the argument of qcom_pas_get_rsc_table()
>  	 * and this is even true for Qualcomm remote processor who does follow remoteproc
>  	 * framework.
>  	 */
> -	output_rt = qcom_scm_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
> +	output_rt = qcom_pas_get_rsc_table(pas->pas_ctx, table, table_sz, &output_rt_size);
>  	ret = IS_ERR(output_rt) ? PTR_ERR(output_rt) : 0;
>  	if (ret) {
>  		dev_err(pas->dev, "Error in getting resource table: %d\n", ret);
> @@ -746,7 +747,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	if (!qcom_scm_is_available())
> +	if (!qcom_pas_is_available())
>  		return -EPROBE_DEFER;
>  
>  	fw_name = desc->firmware_name;
> @@ -838,16 +839,16 @@ static int qcom_pas_probe(struct platform_device *pdev)
>  
>  	qcom_add_ssr_subdev(rproc, &pas->ssr_subdev, desc->ssr_name);
>  
> -	pas->pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->pas_id,
> -						       pas->mem_phys, pas->mem_size);
> +	pas->pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->pas_id,
> +						   pas->mem_phys, pas->mem_size);
>  	if (IS_ERR(pas->pas_ctx)) {
>  		ret = PTR_ERR(pas->pas_ctx);
>  		goto remove_ssr_sysmon;
>  	}
>  
> -	pas->dtb_pas_ctx = devm_qcom_scm_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> -							   pas->dtb_mem_phys,
> -							   pas->dtb_mem_size);
> +	pas->dtb_pas_ctx = devm_qcom_pas_context_alloc(pas->dev, pas->dtb_pas_id,
> +						       pas->dtb_mem_phys,
> +						       pas->dtb_mem_size);
>  	if (IS_ERR(pas->dtb_pas_ctx)) {
>  		ret = PTR_ERR(pas->dtb_pas_ctx);
>  		goto remove_ssr_sysmon;
> -- 
> 2.51.0
> 

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
-- 
-Mukesh Ojha
