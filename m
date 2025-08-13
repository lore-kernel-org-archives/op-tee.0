Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F484CA0EE0
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 10:01:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8CEF245B26
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 10:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755079269;
	bh=cBywqYQ571JjXH/CFVXtPZFVBnz+yE4lfUMvOMd0qMo=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gAVTG51Q6LbRSc2TkBphewacs9gH3Y5FO8ikyzUPLiU7O6h2Oy7ONI/Vk95tihRMu
	 nVSetPsOjjw/OlWr4mCtRALv1D/RvO1C+afB1KCnLGUhbuMACV7sCyQPtlCPV6aYi2
	 6set5SfsQKRsJepHuEwxBllBnYiRtZ4VD0cOJ6GaYEP0T8XXPmhY5Rtxru80pIkDAC
	 dePRQsYImLvvZSgGc0LlYhy9qhP/HFIzY5yd8Uo1T7jdErOXZVNs6w42hk9q68zpvA
	 CtHnERgqmX6JQtAFdO3E+N3UoAytYNu5WQ9V2dubET4OXkAWkm22tc3e50QqJNX1wL
	 kdcSbUblNgtTw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9A9C942EBB
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 10:00:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N9CaoIbL;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D6mHhx029839
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 10:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wiBWcdk24yow8RF3k9D1Z3F3r9BgHRGCWV7I+lbiN7E=; b=N9CaoIbLvjII5iGW
	91H0wJPvVuZVgOQHfDedopcJWkBiXmu0ICOQy8BWlNAMtuIFn76O9zsijrMcXWaR
	nGy1Lc3PT43fWeQIRxtPT/wUiLltdupUp3wNKpr4D6+EAXiXh4Y8inhd+D0CROS+
	QvyvLgiKqlvKBtRTXqbV1cO5t0dB9S9+v8yPwFXbTTPA6MgYB2fzMCuUCJvhmITS
	jVdz6J9Z8oSnKORIzJeeMhKraWxKcjqxlBdua9wfi2YinhduTNdaOnw1ZsZxFm7E
	EXQIckRprZ49SAJVNw7MUW0hmGfMqL2vtakcjWUxi7WJVzJI3YEFLDrBS1JssXgF
	zzOp1A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3gbbb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 10:00:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b08f6edcedso18596211cf.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 03:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079251; x=1755684051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiBWcdk24yow8RF3k9D1Z3F3r9BgHRGCWV7I+lbiN7E=;
        b=HiOlrArp6768VugM8H8CBB5rzoncrNjMu7RcvgzkUYcTmrJ6J75GbhqJu808F+7br4
         0jqQHq3EPCiiC65r0DZMLAeVf0EstaTfZUhEV9Czq+NPG6un4K9lKxU08kSiFzedcVRi
         7C+w6lrC+j4oM+oWw3MjXrrZ2a7wMR7smp3Dz1cdadFqO5HpPu8ZSgTnDmhphzy8hBI2
         m09p5lZ2w4t1zmzNfDO98GNGAW9ltlcpXvVRrYBKrw2SuEjGHKqahPRB9am9AnbPwgqg
         AcUZTovrkJxdJCfyr7n2RQIza4QgZ+WpeMzcUQJ93hftZ45pN3Am9AY6SvLl5Urn3PmO
         EW/w==
X-Forwarded-Encrypted: i=1; AJvYcCXw07Vp1+kJbST20Ro49kA+ORStntJcCQxdv/dR32bZQEE5svLogPH9oWclDZ2fqTkp2DjSgUg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxsbQZGkkMqLBVZnUT9qEOY8Bf+Q0F9DU4TMpNMlf99di/vZKKV
	rExwJxlM2+bDlL5jUWib7z2AelGlTzFg25pzLUShayLm/cNJbF0Q0T5Fw+ev+yVj8c+4K0393et
	7tkvoygo8leFikjqTLHPubukL82jSP6wEuOB0STMRhwLpnUiPVJEGl8NmNLPsEBRVmg0MOFPZ
X-Gm-Gg: ASbGncu226yK5ptP7Hx6Ib5K6QfHPbkZSjdpiW7gRiI8kf0woGw9PdcCkHAdCjm/seb
	FU2vGLyEtpToAJ+Yn6aQb4Jao9s555j6aw+JKvbkxdIpBkFDeLB+UlWdrh/72VzDdbnq3LvdQW+
	Qw4gJApJ2RhspBxReUv7lU2QJoQG+j+n7VyPb8/vPjEcpL4ftL/AOW9bb+XPaDLsTclzDxsMw7n
	Xkvj2vygzP2BjInPFQYMTw8WHK1aJBvUibLookrknp1USVYPoxJOnYYf8QxmjU/rcF46pGjti0H
	s4968OO3uYiGeMmgB4mS8uhKRt1ueb3aBUI8LJreZV/8ANEMHZsQQDx3tNiJgAbHXJ4EwdbAZhX
	jBO8PCeO9gCCaZ56jRQ==
X-Received: by 2002:ac8:7f06:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b0fc6c46d3mr13966911cf.4.1755079251130;
        Wed, 13 Aug 2025 03:00:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmTrD4ySjMqSbwhalzXJcsozDXyEzKvaYMIjrNiNP0RSpO0suJx9JL31ZtBXBXWoPTlWVUaw==
X-Received: by 2002:ac8:7f06:0:b0:472:2122:5a37 with SMTP id d75a77b69052e-4b0fc6c46d3mr13966501cf.4.1755079250541;
        Wed, 13 Aug 2025 03:00:50 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3375sm2366142566b.41.2025.08.13.03.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 03:00:50 -0700 (PDT)
Message-ID: <3ec0a8d0-7900-45bd-b0d3-90ee8ca7730c@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 12:00:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/11] qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
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
 <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-10-ce7a1a774803@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=689c6254 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=WNCivIMphfMWkbBb3CYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX3pi/jwVDskwp
 tHGqLLHESHjztHC8fGR+sNoc8/3cIPxLMuX7ntmN5p/PLdEMLCZaCvAcU4lYc6ZCV0GfPqLPGhb
 Bf1xM0iYXces83gM0tC3ARTT6NCvvnGnXZsYo5L4q+FTI8bJRTPb4vA6gamXy9vWPISkvdSofDd
 WgqdDufoTgl6XYp3eqlenqQbfGhRTVXn9lb0YpwcGj16eer08C+JH4GHDaim3C1Cp+HCH5vfmqT
 sHmkKo7alxn3yka+c2XmM8AkIsgp0AGEdWkfO/6TZKeZHg2FwnkD6gkru/2BoJB8GzaPjrPRAhl
 Az6922htMz76Y5aTDpPvRw6pAUEdfiDqCtqaSdW+GveE7kShKepz3TNU5mIO5TJCZOSb+Y/U0p7
 EeGBPAm6
X-Proofpoint-GUID: sraYbtqMwUmxsVEx_bnyrrU_J_mIQtff
X-Proofpoint-ORIG-GUID: sraYbtqMwUmxsVEx_bnyrrU_J_mIQtff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031
X-Rspamd-Queue-Id: 9A9C942EBB
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-3.41 / 15.00];
	BAYES_HAM(-2.31)[96.76%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[78.88.45.245:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: WBUQFPKV5A7VHXX7WPK3CYW6OT5AJVL3
X-Message-ID-Hash: WBUQFPKV5A7VHXX7WPK3CYW6OT5AJVL3
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WBUQFPKV5A7VHXX7WPK3CYW6OT5AJVL3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 8/13/25 2:35 AM, Amirreza Zarrabi wrote:
> Enable userspace to allocate shared memory with QTEE. Since
> QTEE handles shared memory as object, a wrapper is implemented
> to represent tee_shm as an object. The shared memory identifier,
> obtained through TEE_IOC_SHM_ALLOC, is transferred to the driver using
> TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT/OUTPUT.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Tested-by: Harshal Dev <quic_hdev@quicinc.com>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---

[...]

> +/* Mapping information format as expected by QTEE. */
> +struct qcomtee_mapping_info {
> +	u64 paddr;
> +	u64 len;
> +	u32 perms;
> +} __packed;

Please use types with explicit endianness, e.g. __le32. I'm assuming
TZ will always be little-endian, regardless of the host OS

Konrad
