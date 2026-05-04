Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E621FF885A
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 09:22:48 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A4B2C44DE5
	for <op-tee@archiver.kernel.org>; Mon,  4 May 2026 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777886568;
	bh=0MgFvCSDTuHg4QDgFxl4BQsxVp8Ywh+kfF5DDfLCKJ4=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0jXG7nM06f+XendHtoob+WsA8W/iRrUeXRDwaUm3GZFNCy4DiJ+nyfdvggXvFyecp
	 5aHLmgT53IPZ15PFk5Ebj716Bq6RvxZDayONkpX8nU6RSh9sUMct5DechuMc7gxvgn
	 ZAnGt6rwImX+kk+Hid5MNL1TPuqbQYmY/1o+NXl0PBEk0FnJ5ZxP/nauSWVNXKKoeO
	 dJ5ZxEG30rQynbggMVD8fph9fRAnVv+VRxEP7zMJuUzIROtzDHK89CpmsRGmiOALvc
	 0Mm+BwDzrv4Ymt34xzo/bktigfTYbxhiTCu1wtr8NlTSfpZoq6jtDI0J1Jd/b4xVeJ
	 FLBnvUvLkPhcQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A26E843E69
	for <op-tee@lists.trustedfirmware.org>; Mon,  4 May 2026 09:22:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jT8UcqmQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i852DfmH;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fIET3824025
	for <op-tee@lists.trustedfirmware.org>; Mon, 4 May 2026 09:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=; b=jT8UcqmQQ7n8kYzv
	d916VXBnBVQAm78wuEtAHyF33nuIfU7O9muUTVQLHdQqRCsxCnXUQgbmZ0fXA0qg
	VmH+gx1lXTg64WQaDkXccTDHvTbf9NCeimH7F3QvzoHpBClvIZjBqcRFZDiaKgiv
	5qcakwNqNRUSy/wv2UxnUomasVoiBjozKqMsvBe0/7eJysYubnJaFJGtT+FNI9ux
	OgE/dxTSRubj28Ew83LknbElbkH3kqwyMivwUvQUpW/TCMdouKIirLws0rS6Mw3M
	Qt8JuiFnIajoHlvcRdHSE5t+L63sURsDNn0q2ML7g9KvopCF3sLVwS/98cB8bEpv
	u27RAA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dw9g3n42s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 09:22:40 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso2010993b3a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 04 May 2026 02:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777886560; x=1778491360; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=;
        b=i852DfmH03njwwRbqXICivrPVTH63V/LAivuzEK5SkdnOPQnqNLErl5PZ7TeZkUMsB
         AEWlPpwhYqFcJ9nQ/J72FKoisf3Y4bKAESCjkMbqn3GDyoSHFa2rLhQq+vF4cJyNbRVg
         G7QpWB+K4LsqjFw5t00f72US7Qz98Pr7/Li4eIqhG6dRREzjJfrN1q7UAULpuoDvAKGW
         C9fmYAe5iexqt4P7KVamUuO4vQKB2T+mgZT4htwJv6NFL/McFSDPOgjWpgH99fCrbenj
         uM6pTapWzQiJSwotTdsepmYpQ/Y6O6N+qi+2Y4SM7qGnrEgyo04qZzs1x2J7wzqtv1xs
         lhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886560; x=1778491360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+gQ2IYd21NQFildd15TvBHWeYnVzvUERn8F2hMpH7o=;
        b=kNDQiPLV4r0f/sCtM8mNKTYFKvQbExBA04zyjdyR7kUMfbtuzmarxLpLTsyes0dZfO
         A6eH6b0CsuDapUElVL7HzNTL7TeiBVG55P9i9aGw4M98yhYg3Oe3bZm2a19HEPp4QBTs
         744fNb1mfzQAc3hMtXIHLXm6VDJAtFcN6/HtmApEUXdxMjL5oDbb0+4ZeNf2WgdB5QoN
         eX+XryFM5GpBB9/cJA3SzQ93cjSvEIIVExQX2H7iB2vrMy0Sx4+bUecgaf8gho2XeykH
         ZsTVdBMoTqAF9L89mareuRVNRX7T8XPrGS/yXituShNS0u1TdlMFGlP6nJtRM6mbf4I6
         gjbg==
X-Forwarded-Encrypted: i=1; AFNElJ//m5EBtC+DVYi6nQddulJNscVKeXdn79LAi12InREM9v4Id2HXv31Fgs2idmykdp4cIGW4j1o=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy2SqSymelwij+9SG1Dz2XPhv9t7aL4QOhbFhzzeoyk/lwsgRkq
	M5ydyjwUBls4f/N389TsTMupwQV30xDfpwcez9Ph5cwTpmbBqwtGgfsuyfG6ZBDefwNr4B3MXVC
	ExEQD5qH3VEQSroHGRN//oUNy6SbPs3OQNMOkydgyC2bgLbamTnzfUZEzsPYcMC51ap5iNNu7
X-Gm-Gg: AeBDiesKhIQtP4DPkZIhoHTSwlIhkXtRsIHHTBzrAnVJOLWSanGtkcg9Bxb8JG6tHA0
	URtuTrRriY2XdZLMH3ppNgHcuPjczSlz0eOIgnMNrVbbEVsX4G1oja9heB6BtT/lMN3p7juzPwi
	x9d3a8btRS6FVUOCJ2L33QQ/sAECNq2Ya0/d7cFgcLj20pWaV/dToMpzHmADHyy63xovn3Opvw/
	GsEFydnozegaHe2TlC1uXHmJGF3W9gZXY+sSzxRq1r5qdX+ErErOluqaFerE8LlCJ1C/VzPtHvZ
	HYuKlHSfSTt6a4tF+k1zRVcQI2NRTPz5irmelv0naV+fEXvZKS+rxM3f0LGUeOihPB8daopdSZb
	JbkacDnwdlhZohLsGeJ7Xfv3RS366q4iQP+E+LfgKdEKfcXblsvvOJNWuxfyF6w==
X-Received: by 2002:a05:6a00:3c8b:b0:82f:5dc3:b376 with SMTP id d2e1a72fcca58-8352d1fef20mr8936697b3a.25.1777886559715;
        Mon, 04 May 2026 02:22:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8b:b0:82f:5dc3:b376 with SMTP id d2e1a72fcca58-8352d1fef20mr8936668b3a.25.1777886559217;
        Mon, 04 May 2026 02:22:39 -0700 (PDT)
Received: from [10.217.223.121] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83775b1eadesm3030462b3a.56.2026.05.04.02.22.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 02:22:38 -0700 (PDT)
Message-ID: <ba8c170a-eae7-418a-aacf-92b394c401b0@oss.qualcomm.com>
Date: Mon, 4 May 2026 14:52:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] firmware: qcom_scm: Migrate to generic PAS
 service
To: Sumit Garg <sumit.garg@kernel.org>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-4-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260427095603.1157963-4-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA5OSBTYWx0ZWRfXxM5nvnYmOt1L
 TIhWjuQkZllJbLqofSd9IG119sRH50RfLI0lhtL5+iuuOl9zoO46TqHNZd6JjLjcQwLjyrsctsq
 53+9Wp17cAMMOH3UfgbvgrV++JJAfdOF6aSQJIbUYcVt6wRozVkTy7xkOLJSqF4Xkkp8AAHWP0Q
 VrauSxAvl+WDJWZwuX8hd1sGVeeKt0T3irkghmbXaZycqs/oWdigVHd6KH2ZU0El0YZ7pqAJo2G
 W3AGs01PBNfaVIOlDr8W9RQyinUF6qZdLyruxQLu9IBK8jO+APDjWhQhFgt5EmHo+IrjFqUcabx
 yRjhCDJ3KBkEStPrjsyZ1VlKC1XM+phh/99nmBPGOOL0LPdLUOXC8Q+/hOWIx3IcxG3fWDEeFnF
 tdD6NvmU4TWK+6kTRONnm65aZIeEFd7LjzSZtfRmbqNTypINEXcd9+H74qLrFYqbSVMaecmGl99
 9LSE7fSeDtcTP7Av8vg==
X-Proofpoint-GUID: A_fmDL3hAmtCaQaw5R-SnVbzGorgQ_2P
X-Authority-Analysis: v=2.4 cv=Ge4nWwXL c=1 sm=1 tr=0 ts=69f86560 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=58GAH2X6W2vqmnVK_tYA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: A_fmDL3hAmtCaQaw5R-SnVbzGorgQ_2P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.46 / 15.00];
	BAYES_HAM(-2.96)[99.82%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A26E843E69
X-Spamd-Bar: ----
Message-ID-Hash: 77ZOCLI2EH73QPW6YSBS3BAMNRNZHHXZ
X-Message-ID-Hash: 77ZOCLI2EH73QPW6YSBS3BAMNRNZHHXZ
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm
 .com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Bjorn Andersson <andersson@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/77ZOCLI2EH73QPW6YSBS3BAMNRNZHHXZ/>
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
> With the availability of generic PAS service, let's add SCM calls as
> a backend to keep supporting legacy QTEE interfaces. The exported
> qcom_scm* wrappers will get dropped once all the client drivers get
> migrated as part of future patches.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Regards,
Harshal

