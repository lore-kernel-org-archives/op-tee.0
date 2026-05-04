Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FD3FF885A
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 09:20:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 976394437F
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777886433;
	bh=oQ9eG6ob+yWY+piBXjP6NuGOsypMkng4SMTY/pziYx0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=N8+YXOAUcxAy6n+0Z9/O4YbSFPJLq6qITRtY2ldFUADuXqXA7rboVgt2LquL06OeK
	 yqhI8Ah9Zon3nSf1gEeu5uAxmOGmmMuKxRuyXAw5e1sp/DbGIkPuY1WCdvLMJrbe+S
	 76MdjbyTZYzyl6nlEebPzQGely9vgT9v3ia/xQ1YJL26Z33C+kM5ZXclNrScgyXmrn
	 3TUXo5dtF3MgRO/4LvjBRQzcz6LSpWM+dQRxDJe8wqOkcFSljXrvIOVaMhII3KlqYs
	 Ushpshkjqae7vJ4ekvMNauzbypqatuDWqsYokPLMCHKkOpJZBuThPaumXGdeewGjQH
	 LhMy0NszJw9Tg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8E949432AC
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 09:20:26 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DP0rHUCc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NdJNoNwM;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fIAl3817644
	for <op-tee@lists.trustedfirmware.org>; Mon, 4 May 2026 09:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xacEJq2Zps3FgavLd4lLbebjwrUmMkWW1Dnv6tEkWBA=; b=DP0rHUCcKYKrOTU6
	4+YLLRO47dTK0k95xf1aJjr/zEC1BeU1ZmwbVwTfk2Ye9TPn12j56h1pFtCLQAC4
	KhYDjPtN01UugvozyOjlVSyzEjIoYB66OLruaOmkbrdsR/a9Vhg6Hi2FJsXBmucu
	yDxrMsQbSShgrYKrMJJeQ4yyShtgpm3+qErJTb2VGDsfat2kLJkr6Z+Z4OUiUPN2
	vqKlDgQNzX0Elz9mtysDKTIQ37s/uUxNiXnIutHnNZxaKu5x8xAVTDGN4r3tpeb0
	QZqvOgpCO2l4LK6eoDpj4XlHxYa3zhG6bviZdFoj+kWClXiGFA/uAZT9PvhmihHE
	XA/PQw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9bvn2a5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 09:20:25 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f74bcfb86so4520630b3a.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 02:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777886425; x=1778491225; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xacEJq2Zps3FgavLd4lLbebjwrUmMkWW1Dnv6tEkWBA=;
        b=NdJNoNwMqBeC7d4t/C5VhWmRB3nXkReNjnuB7HZN4aIF2fe8nWQjlbC+q1TVsPTkry
         P42NeMh68qimzmvg4DWlij2fi1NIgImXLS0Z9wKs/I/vMhs+sORVD4N91W8Ciu3Zi5P5
         9Tu+4Elp4sl/xh2kR64/WYqnx7mfrcuMuEEGjUAEXTPoQSlYjIwhDaFV+qe/2fqoi/pZ
         1VcrkzP/zKI/amrCVxThNjP8gBePDVKWuI84uEUim5LkzL0GeKHtDo+ibhsHd+UwbDWC
         sgjLbJB38wSPkcHjrf3AsnFvjRDSYZgr/AgVwiujt2Jf49/fJA1qTiaURvAsVHF6BlDX
         u/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886425; x=1778491225;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xacEJq2Zps3FgavLd4lLbebjwrUmMkWW1Dnv6tEkWBA=;
        b=njwzsoMfHM3VCR9HrY98psl2HS8PyLbWMRcxN3QzLlpRgBgS7j7q5snqG6onudI4MD
         /RLDLDCktOzrj9hIHboks/G5QbchVbxuxkbJMj752GcAzAICvtg0LbHtLtDLbEhAEGvz
         CBZEwE1NyxjAxKXnEbtV9RWVnbMTVYeFWM+pf5ho5tWZ5cN0siR2LwuPUjfITEBte4p3
         iENZAPZNbssrMLNX53KWrqhabX8XXMy27o8DiYTc0q8DgeI+ICtSRzsKQ28A6nPSCYWr
         MRmd64bUQWkTMQ+8WamS9WbUfSLc1jg+WYCKnYoj+L6uuNkumfy37BLtDm+JD9irTpMs
         gAhA==
X-Forwarded-Encrypted: i=1; AFNElJ+1g3XmVPqTLRvW1MBAWEjdD5ru6KYRxN9ufSsVQPqO9M2YLVpOlQo9F1AFTDwtTucKDBq7yqw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyLmnf3D4c15Y/5kOYqsGnS+AippoeubCgJGiNldpvbvA1lpX1w
	dUCNW1WVs0E+Zyqu55fUsX6uOHASKxI2c3vBbS2rSfwQpCc3BqQ8eVmZNUJMx9PqcG7eoVnimwt
	HIjs9tvFwmaog2oAL9/7l8GWL7gzN0+ZLe0HjCDt/WrHEn5PBDZaUEB0F4aX7c3LPOHCK4uJM
X-Gm-Gg: AeBDiet7QeiEQnC2kbG4zyqLVmfUUlPqabMhYZdG26CeMKNUiX5O8TtWor0izHwP4ZM
	h6zgYORD8tZrs0nR9qBwB1fwhmr1yOF6dWOccW1r2XlQMaCX43JtliaJJ5ynTwPENcGcJuevckX
	DOVK6nHM7/QFLcthNshszuyi0yBK3Ycf9xk7SjjYhYEM3HEaK7RwvfxPvkI2xiGFZI2ZvitPt1U
	9S7/HHU/Ws4R4DrJBeXPaIxSCLSQ9guNY2kAo6EEjogO79mQgf7QXgXYnaEK1nRQ2Mr0X25fkzr
	x8oiHmPcT0SLC5HbP1b7eFZE2coB34h/8owBwtNvEpzMBo/NgSIexibwSBxt8HijsAw8py8Hl8A
	ax4DpCsiG30RA9Hw9vLMMLOoyN28kR0FSDDTfb7csttqXgkrJA1Ow5qY9zsLd3Q==
X-Received: by 2002:aa7:9f07:0:b0:835:388c:9764 with SMTP id d2e1a72fcca58-835388ca073mr4931614b3a.37.1777886425032;
        Mon, 04 May 2026 02:20:25 -0700 (PDT)
X-Received: by 2002:aa7:9f07:0:b0:835:388c:9764 with SMTP id d2e1a72fcca58-835388ca073mr4931557b3a.37.1777886424440;
        Mon, 04 May 2026 02:20:24 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad0049sm12316337b3a.33.2026.05.04.02.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:20:24 -0700 (PDT)
Message-ID: <81d83991-df25-4fc4-8261-6793ea9dc438@oss.qualcomm.com>
Date: Mon, 4 May 2026 14:50:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] firmware: qcom: Add a generic PAS service
To: Sumit Garg <sumit.garg@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-3-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260427095603.1157963-3-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FaKoT5Uqi4LBdXMAaCYixdAuS4997omn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA5OSBTYWx0ZWRfX2b/DAbx+8BIF
 /9+m3qzX3uqh32YgSCW4f2e/gQtWseud6FyXsO5qyiXh5YfaOzBmt1cKVNk50dkNI+FnjeYlWvp
 rCzQSC4dpj0r2vd54tmgClA/l0vux4HQpgQlhZwj4p42J6jzj+R/y2OFI3Q7MSr0ZGpPiUgc5Gr
 e3h1mqjWfkJPP1waWiYpk/0dmQDF+zVMY9dESVAe78Gow/0M5JsHzgCdor+ENNqBkkQammIZNEm
 Xi2kyu5kkM2xKwgopuWtflkhxJ6X4sKqNKSrSe+xirwSWPhbBx2FQ/DTEbnKUNawLtt5haJns08
 AWOM+sSrHKvKAiqU8q8YXpQ59mPUxLfi/md+hckpiwM+dW/zhTPSxDu1+3251NgamjWhJm10572
 tQ/jFwPvGDCxfyTdnmtqLb1CQ1IwlI7izVDyIMn7sMiHPl3A/vFZ5T0aajdetKMj9LrwnilM4rS
 wsS3cSE4ZydwVuSk3Lw==
X-Authority-Analysis: v=2.4 cv=dqLrzVg4 c=1 sm=1 tr=0 ts=69f864d9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=DWWpLck2SfFL7czMIZ0A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: FaKoT5Uqi4LBdXMAaCYixdAuS4997omn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.44 / 15.00];
	BAYES_HAM(-2.84)[99.30%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCPT_COUNT_TWELVE(0.00)[49];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8E949432AC
X-Spamd-Bar: ----
Message-ID-Hash: FWMYAXCR6H3W2WCWVZXK2FM3K7NWEXXC
X-Message-ID-Hash: FWMYAXCR6H3W2WCWVZXK2FM3K7NWEXXC
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FWMYAXCR6H3W2WCWVZXK2FM3K7NWEXXC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>



On 4/27/2026 3:25 PM, Sumit Garg via OP-TEE wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Qcom platforms has the legacy of using non-standard SCM calls
> splintered over the various kernel drivers. These SCM calls aren't
> compliant with the standard SMC calling conventions which is a
> prerequisite to enable migration to the FF-A specifications from Arm.
> 
> OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
> support these non-standard SCM calls. And even for newer architectures
> using S-EL2 with Hafnium support, QTEE won't be able to support SCM
> calls either with FF-A requirements coming in. And with both OP-TEE
> and QTEE drivers well integrated in the TEE subsystem, it makes further
> sense to reuse the TEE bus client drivers infrastructure.
> 
> The added benefit of TEE bus infrastructure is that there is support
> for discoverable/enumerable services. With that client drivers don't
> have to manually invoke a special SCM call to know the service status.
> 
> So enable the generic Peripheral Authentication Service (PAS) provided
> by the firmware. It acts as the common layer with different TZ
> backends plugged in whether it's an SCM implementation or a proper
> TEE bus based PAS service implementation.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal

