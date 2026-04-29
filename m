Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F41FF8867
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 14:36:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8E22643AD6
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 14:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777473382;
	bh=S6wX+gTzPAvcCMKGMzHVKpxGRSVZp3HgiObGvUJwvgg=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=YvmppxfjcscHYRu6DLYgZBuWShDlR3Xh8JXb/jRYRvLZbKpiM0VZzeruj1wgXPFsV
	 zSWO0mFYoyd14muXyNKYnqxh7lKtQUU6FTXr5B//bawb7lOy8Jpq0ktxJmaFaA50lJ
	 gt6czmteHAr54aHc297ln3iPLtJruaqj44dODqMFmFNmIdkQUAi9oQoyeKF7Zta1rA
	 pLQ+WJ/ySIpj9op3Xm5uFOTyJWviIqSzbY3JW81FsaXwITnc1lh7da71xl/kW8gU3O
	 6EOONkYaYUhIfljmFeTAhkOA4MuSLvryV9f0BK8xFOByA/a6lVuy7s/fHqWOaKYj8W
	 /qmqNRTbQkeqQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C359B44462
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 14:04:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UzklY3pE;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKfSVKa7;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8prOe2094135
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 14:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5geFPuppNEw0Na2cpguNPJGL
	4nGh1NRsp1YB6ryaOE8=; b=UzklY3pEYefS+bOkeBxtQUZQD+IPj7gXWaOzbRS4
	WSH7uI1wuHaUtu4VHRYIMvEaC8Ce0Evo+1qCEfaXCuS5ZjOepwbErwHPT64k34un
	SbcLc4hz3Yyoroyb3gjlgim9TtWDtoikFNBW9OgPOx+e2y7su/Kq1/tXmPTWiAYZ
	LKsObFeI2pSfqRgSI6in7sI2towKK+tr48YfWNyZERAuT1Y+/k7VL9nPYI2Rm+MG
	rnEcZGfao2k8+8039tDSPeRRbTv/tEPjbLqp4NrDRL4nlwgeOh464GwL7tyN7NnV
	qY55lUizS1cK2Jl9wXKawsarLCHU2ioQmRBhk/Lcn91pGA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3skfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 14:04:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c797efdaa9cso6477474a12.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 07:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471497; x=1778076297; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
        b=WKfSVKa7VFJEbgW6nzjW8bqkPDFdJaXR0+FA/1E1eann6orIpb3DIyqY7w2uEmOvCo
         Z5uzgI1Ykb9g9wejzU6ex9pgqaljGQSO44y+R9RRX+wr6afhpPf26mOSYRz/zGldhZfo
         aj+rKIzCFR5O5S1AkpNzzm5ALkf1e/RByAgj9gpANBPR3RLPBxoFBi5iR1QXcZanBoJN
         jbWQWuEmfNlcaPt7VEE4kR0UNAI8W5WfKkVjF3GQepwylTFjGFvLS9ciduywPLXbLG0T
         UVYfvV7lzqpkD388+GXaUOFV8kBr8E4AFfO8eFRdruJ8v0GbF36yDK/X/y89AYuqgxOA
         Saww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471497; x=1778076297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5geFPuppNEw0Na2cpguNPJGL4nGh1NRsp1YB6ryaOE8=;
        b=a7wBHmP6+qA4G0+3lNU5iGYgNVw2RDMXBBteOzZPUBrnV7AiF8ms6cs22JaHsvRyFF
         +pwWLP00FDEGeX3N/r1+2YU4VJg4MiadNUJLrkT4ZiDsjfTdHXHM6l9WT37tfmCPw30O
         KWY/jxeomKeOtC02dca/6dsb7heMVwGLAfQngi2wSY3d4X7f8tYIZuR490n3Wo+WKISl
         qPwL2rKcRpSY7l7tS2amg+QNB4eZBefLSqm2zUb757Vx3Q6IuEI+CCni4BfcWMolMYuN
         qkH16OKTVxJGTD8U7urwIOExE33dFKS1yqD2hIfJFJWbc2HT6ORrysQHAiHgYSWcooMp
         OnkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lMS8aZqPt+MV3OrqcsmGh4KgnybM+dUgI2o4TSIUShb3BIiwOmHfXO/VXvP34Qq4NJc1kPco=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzvgYzBGD/JAgW8i/2eAMSOzgQr/6t6+u6YB/WOKr2Uohgtrp2m
	bLM/79NGmTEfnvgDsytV/DmDMeWSY/gd+hH6XeVh7qpn91OAMjlvIIKIs+uGJgBtmOD5u+5KJe8
	4KvAtS1YZwSNR1u5f/7QrzKUnvmlSEyS52GvFN+M/zpaO9NtXqcJ0p1nDLxxalsGyWTZk4mvc
X-Gm-Gg: AeBDieuJPaWk9IfbTnsPZHZ+urCq/8iFelZiM8SD6ausn42wnE1k2YZ1Fq9eFaLVHnW
	3cCeTDNiGXHO1t862rGrF6Sxmm6aN3gESviq9ZVzrl/8IxqirU4kc///SVTBlWVC4nhLdhb4a2d
	1Ji4imPrmaITYzzWuEaR3M59ti9Gm3rC+CUsj8E/+WIV0k803XLE+M0vBbfhWeeLF+LAU6/Ju9h
	S2IqR3xvxHIFnms8M2ewGBaYCqLr//v2dw37nCE/RqW47vYKyEF5dp1U7HpYzKLOmH543+zwONu
	UgbuukGagJOsimCwYBTuPYnsoVvZkfeZutNRKuvxL+zmOe1CQP8AlSUn2Mp8XTbbPiH2dlebq2N
	U4taFQrfJ7w9XjwOuEFqvoL2TJp3DTTZOyAhn18lgNAmxSBt34XMPGgtTJ7s=
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id adf61e73a8af0-3a39c2722a6mr9041389637.28.1777471496925;
        Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:33a1:b0:3a0:cc67:396 with SMTP id adf61e73a8af0-3a39c2722a6mr9041274637.28.1777471496127;
        Wed, 29 Apr 2026 07:04:56 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd6506af1sm2270618a12.25.2026.04.29.07.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:04:55 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:34:40 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 14/15] firmware: qcom_scm: Remove SCM PAS wrappers
Message-ID: <20260429140440.ov7x75bikyvs7w5y@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
 <20260427095603.1157963-15-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-15-sumit.garg@kernel.org>
X-Proofpoint-GUID: ellYE-zJhUmKLYs5ky5nGasX6i82hfAM
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f2100a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=n1VOVlC_Xzu4QXtT9DgA:9 a=CjuIK1q_8ugA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: ellYE-zJhUmKLYs5ky5nGasX6i82hfAM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfXzAysTe2iejDH
 dCyt79X9DeMbtjLyro2/75LQBA/aayFaHqQND/NFMsxNS9aNd7ML0Y+iARozqLBxD0Si3tTbb3J
 yjCHcs2XscmjVO2z5DwFmqk3t8JF7EpbI9WkgRViKfCQ30mE5i39XBejGSYwUwwUJCPic3sIiHf
 rkPR2WX2qhoXF2RKndEv4lXCMLNzAOGqfjk8IIIc581Rc6MwZGhv4mjvvoC2yflpAmlaLzurf10
 8rJGRjM7NDzD+blCOURDDUoEQj8Et3Sa5mP6pZgZlOOkR+NUhWYkJeG5OSP7THnTOEu8HunthYz
 jIL0gRguS3OayN9UaEKkh/aM1iC1AOt6skUiJew/ZkV9cq4eM0hRyTM3rDDx6r1sRg6szZOxZ7u
 7xnDerJFrRgjE/1FRFVrLAXGMEPPG/xwJeAuLM/jiEp9Fma8wymViS1IOF6zYYsfSaVq+cPwSk0
 X+L1u7IBY2n0b0bUvRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290142
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.59 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C359B44462
X-Spamd-Bar: ----
Message-ID-Hash: RO6OZ6QFFLI5I2T4CRRCICRTHHYJ4ZOS
X-Message-ID-Hash: RO6OZ6QFFLI5I2T4CRRCICRTHHYJ4ZOS
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RO6OZ6QFFLI5I2T4CRRCICRTHHYJ4ZOS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:26:02PM +0530, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Now since all the Qcom SCM client drivers have been migrated over to
> generic PAS TZ service, let's drop the exported SCM PAS wrappers.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>


-- 
-Mukesh Ojha
