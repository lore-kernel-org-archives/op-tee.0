Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC41C87FCF
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 10:07:19 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A734445A1B
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755079638;
	bh=CRPKsVAhqXLyl5B9IWZbInaWZbGzzt5vGVn6BvQJQis=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=dSWfFA2LPkKVvj7BunebMPz6jCCq2FZGF7hAifrPJPQN/ObiSdSu+SRM4S7aFIViw
	 +sTLWqbFqb2PbakxGeNpBJIYo98jnv3cmxeJeASTeV+QBJp8zbXtT4qiKAARTp9z4w
	 0hCxvcPmb2NQJLA6+PzGR8TKSQ3QBGJ4enkEcS6sPtB5hmqoYR6khQoYAGv8Wp9Kul
	 wm81g6jNkjldLrGVab7Pq5KhzyZNbWlpqNgSfRPLi/nDeWcGpcmfPU8plcXmau5Lfs
	 VzwWqy8YbmTWRts6xQOonRaCaM+8CGpt6NPUGINtsydDeHCn7i6MIYpE2jbOm3FX6Z
	 OIpLeExuWf3rA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8CB8B42E10
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 10:07:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TPoeXl4I;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mIhn020458
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 10:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lo/uyCg8eI45CIAczel8wExuTSXtA1VT9FQTS1gDCiI=; b=TPoeXl4IjXVD2YQV
	7PgGj9r/3vk0QoRPKTnaIosHjf093O/ALUsVq61RqOpmDap4f+w999tmLJ9urEst
	Nl7bDUeKgmBth6OefCysUvALMPvErT66ikBQ3GRPjzM0c21pZfj6H7pUbnLkUlp2
	gzHM4yEy5pzomSygB2CLW5ggaKuY8TiOJmkAMhHp+jfz5z0el9m1cbsm+IaaDiWa
	Y1R8WWMZwz84bWml2GpnvdbBo3sb48jZU8MDTVBYu6AKnzDOtm5C48/hM/iXu/Oo
	sxNah/WcqjrvA5pbCeYWSOeMIYin4eFMs4IcVl3hkQQnrhkTGpE1/sHlh5WWjSMJ
	wFZHoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhx9h1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 10:07:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b06c7cf38eso3922511cf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 03:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079623; x=1755684423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo/uyCg8eI45CIAczel8wExuTSXtA1VT9FQTS1gDCiI=;
        b=NcCtJ5Sew/4QdtPsXk8e+hqXmKGnnK9e5OSTEZMjgaVxUJSJgIpj+Newr96VLBgzkj
         hdd21L2mvTh1gbRNZjfT+sQuVkjvZkIv2IoTh8u879+79wJbp4J/4PDEnaa8Ym2N7uTf
         ermYLkgrx3BM4m7h4M9zDYnOJ8wCtsaM6iXlPXgztu4fAb7Kj6AIpe9bbToXM1Kz44Ot
         9fvGqoN8UIGJ5iwomEHdXirNyZheBErzIVi8CNfJuA915KOX/USuonxvN/8OGgzi+tDJ
         Wq44jQeJg4TYO7BY9qf49azit8pMKLXkfvPs7WgRgFyGxWfvRDt3nw6o/jAN4y/ziWff
         QmNg==
X-Forwarded-Encrypted: i=1; AJvYcCUXR8OoJyayaMzEmqH0B7EfFt+V/OuunzQ0RlUYPmT7Qrk71xOVNrC5hc4tUXu0DczqIM1q+04=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx3GAmGLXJgsLqcNgc/Gilh6Zknz5d34vXg+mudgAU1wVa/slxR
	3pDHFEA9LDVuUhMeDVOzPVt0HecE93l6FiCoJcnsE6SNtD5mY3m1v9Uc1pKWdDe6RcJP+rMnSGM
	MyANwYY4tJDnIWAjt9d8AN4yHcSadMIlmuAe/M8tisd5TDS2jTZcoYaeNfQ+dyPA70P3yMB3n
X-Gm-Gg: ASbGnctepkvTQCM68UP+FNYNohBW8s1NQOqFyb4oip7b0kepaE4IaueqcO/fiqP1HxN
	+zIMzPE/sm7fdMso/HIfjJbb3dLg0mogKb8FjLW8jdhMTqOWKFAxKA/bnl9TNw5L6R21bjiX6mg
	YoStKfmgIJG+dcmGrnhHM2UAeOX9KKWAO93osQjDE3VeGza1ssSpGx3BQEFf7EB5HAC2p4DKNIr
	8s2xqzX/Yg8iT/72kipqbtsDAg2r6tK/dvdS1vgIVBISNwdrCsXa6EUbgslLwmo7i0+lfkqv/Jj
	/FwbzyVOjE995y0gQ7rIEJmhXYdgl4to4xYOb1vrsMcO+XhnlcAeF3MHSyGRjH0GQqPNNEj/SCx
	3iamtqQBpOmWCEZ+JYQ==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr13706811cf.4.1755079622768;
        Wed, 13 Aug 2025 03:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbEx/52bIrz3cKGljrcyVxad9pOt/IN1rRcYfZiJuhcUb6gPtWuoMusDjEvu/er5MYTpmlKg==
X-Received: by 2002:ac8:5dce:0:b0:4ab:609f:d7d1 with SMTP id d75a77b69052e-4b0fc6cbd31mr13706491cf.4.1755079622218;
        Wed, 13 Aug 2025 03:07:02 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3b6csm2371260366b.48.2025.08.13.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:07:01 -0700 (PDT)
Message-ID: <f10f1602-972a-491f-9c11-95e5e7bd80f8@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfX0ckwni546xBv
 8LW7NZHSsgHcJ5mYL4dhr3GQ23zlyDTvSQzHm5xW0hDjdkOdtNYNevzgski3wt7iOvWms3Ttrz8
 tlHfBr49y42Pk8iR8ffStsKeq08O8goU80Ppxz4cjQSS/Z4NQAdFOIfUfT0kmK5bm9a6vlthoJt
 FQBxT23J8pBhPkFHnBvUElDWrr9FeFBMtnuSDcEyIn/q/AIJLo/cMboz4t3rEMwE6l7rWADrCOL
 jDR02KB4hegUEAwoSr8R9InMWVfZ1AkYW+tV6OFVmSmq5ImuAlsVyJdLPFcgQcgs2Hikc5LuCs0
 V0tqbWuJdD0RRF2lhRcP6m5/hhlhlw0DmGNNRqtboVKMpUxws5iqkwsE79WoarRY0ZK5lc2tOvG
 Z8ENALAS
X-Proofpoint-GUID: v_n8c8dlxRawNPEGBL8pz3_sf6hWTElu
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689c63c7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=clTIM29CJtwRRT_IFxsA:9 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: v_n8c8dlxRawNPEGBL8pz3_sf6hWTElu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057
X-Rspamd-Queue-Id: 8CB8B42E10
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.30 / 15.00];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	BAYES_HAM(-0.30)[75.01%];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[78.88.45.245:received,205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: ZPRQ4FPI57ENHCVJTZBWIWYI74PKCKMD
X-Message-ID-Hash: ZPRQ4FPI57ENHCVJTZBWIWYI74PKCKMD
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZPRQ4FPI57ENHCVJTZBWIWYI74PKCKMD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Anyone with access to contiguous physical memory should be able to
> share memory with QTEE using shm_bridge.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

Hm, I thought the idea for the tzmem allocator was to abstract
these operations to prevent users from shooting themselves in
the foot, and this seems to be circumventing that..

Konrad
