Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13349C43458
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:35:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 415BF45084
	for <op-tee@archiver.kernel.org>; Thu,  2 Jul 2026 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1782995709;
	bh=WSd0pp4dLViWUrVNvqX/zEMET0G6qSs6EPp7Yqwc1hU=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0xr70HCE52iP8AO7MLzGygTrbsLRtPXJq146+uiEqwJ+rt8ZZv/8I3dU7sX38t+wS
	 95cyZSzAP+ByvE+d4q9QhGyquTHgrOtsYlHha/q3jGZzSbC8gcApHD0Qs3v+cH98l+
	 xDdyHEDUBp57sJibhKmeg9Fa8h70/p8ZCoVdC4QWBAI8MokKIKSC2g06xK00gdVmtv
	 +RecUDPOmXAMNfmLNZCNae/1M5C8CH769rYfzyVFeyyqftSA8x945OsJ1B4bF94HLr
	 CQFFrWdwpAC5s0P5Gj0Rr1nRgMhDr/Bqt2pWaeT0gewHemHXUs6bz4S5+igbgyuU4G
	 3nSSt5m0IkPZQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6A60244E4C
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Jul 2026 12:35:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PfvBRkZj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gll2uWLP;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662C3dac389762
	for <op-tee@lists.trustedfirmware.org>; Thu, 2 Jul 2026 12:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=; b=PfvBRkZjmzECsBBG
	l/C6ulvrOWW4bO5T1i668/9LoIoIo2Ot+p7CPfZm512Yi2E36QZsz7lY8yGaehna
	LRfeXadKYb+gb6eYOF8BiIUQJ0KAdwl9pBVviZn8WLgczw+4oNwnpFa8J34gtGqi
	3vGn3Vf9jKgZ1GgmG9fyB7AeynvUjvAslZT8Nc1Jdd435VXma6rl3XHXShg4aGn5
	WkgGtwXY9nJRza2Pd6UHqASdWQ9JU6zt0cJqiccbZm6zVd8EjPuoGOfivPfBUfvM
	K+TSJEBYu+SKlIEfYHEpZUKipLVSiQXbKLND9kl0mBASZneU1Ai4Ivq4SxZVPhVu
	wV16OQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnp84mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 12:35:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8ef4a54f86fso3799106d6.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Jul 2026 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782995701; x=1783600501; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=;
        b=gll2uWLPbGz9f2G2gBGWHSppPO0yxsahnLOsoWOyzEwheNHTTStPacJX4hs177L1Uf
         RlZcW1M8EhWaLy2wdAuyecTiWr61heTWVDdvtyr7iP48NPxbI+yNAE1dGs0S0VyqgliE
         R33EXQ86oYq55AuDKj757wKuva4nKlYDdNbjUn/9LMXYPf9vsPAp/verY4cFNpqB9KPD
         LcvzwiBrIfpBcamCfp0xQIN5p5VFUeLZAfJBE+tVtkUaKNGhN3pp9VIsS10EGzvflVLd
         F3K8xEWZ+lumk3qcV/M3ZN2iIkjh0LU5EafQaF3aqkksvo+InnpH9aiUminSXSE2jkoL
         Incw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995701; x=1783600501;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GIcgPlp2LTkuppvChFPzfoagnWyTaW8m32kqi9i9VwE=;
        b=OIf9JA/PXaiPNt43WjyLFBKDO0CZIHaMFvsjhjmMtOJU4L+X+LPQvwuvyuy61T4XFx
         mnulFdAhzRkQ1R4HHaXISy0z9Uve3g4gLTgKBxNsCk7d5L2T3XZDc2aKxVZveCiDy92U
         fskTjDAe8D4RnHup9LOCBZN/eXL5f0XvHIWx2e0m4cpHhPiWGFQ+t0Ts/cKKFXlN60BC
         q9RP0YBF6ihqqWkSzY2ExTe88vUkwg2tQLLwEancTX2v0y1k7FROl/f/8pd3aKmM+7Eh
         FNkDieyml0F9IzQrut8rkPyB0rNWzvmO1jEVreE3s7uKmr8LtuU94sk+rvsyW4z0YvA3
         r9Fw==
X-Forwarded-Encrypted: i=1; AHgh+RqTFbPgMO4fsYRQ380k8SNcwmTvOs/T23Rp3/zIVKhqJCBpxWg20HQqDpkBkx1/48PW1CdyaSY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yznj+rYTnhcHQ5oUHmiqiAoB7FeRsv7cGj2y+tnd5m8Kva9ckX8
	9zLWRXvbR72rxGehPQBD/z91Y8j9+f+EsKrrm+OA6zMWR3x1m9L7Vqi+Qq1C89Po7FWUT7GYSvR
	AJdViSoqOIVgrQiTCdaf9H2RL95b7I0Wy/sEejtT/ZvgosprncUV+GutSnsv1pk51UrSzNBT2
X-Gm-Gg: AfdE7cl0VeT70Dhk7KLZ0Dy6ZAjIm4PeLizKcAhmVvjc2l887mRkQVesMPPxmECa2/S
	bAci5CcgYWOWf1b3wIN+qrsfrlkPJZVI28bd6a63ydPGKyGiIsikgGsg5xEYP6MbiKhp4vHt1SP
	J03Q7aFSgWWx8FYw0higO8DVRYKmop5H5M1WNElkrEQ1luZdxNJzH0zOjc6gZfXpEEVREWDEG5E
	eMRastzjDIaWCABzz10CCBJRK4FLH0YCIc2hSxWPPHeOMZYiA8ySCZDP5pj9lQXvVsuk5BSNx+k
	YHsxiS7oi5PhxlJnHZIRl2V7fZ+dxkZFPBU9v4SkrXjMuyV0SjIrapSEh2TyxWPrOyhPmGWTBkS
	9oS1LOV0v4jEjh6VdzT1DsyI1FgWuaPxWcpo=
X-Received: by 2002:a05:6214:428e:b0:8e9:f5de:d5fd with SMTP id 6a1803df08f44-8f3c8ff79abmr50486326d6.10.1782995700690;
        Thu, 02 Jul 2026 05:35:00 -0700 (PDT)
X-Received: by 2002:a05:6214:428e:b0:8e9:f5de:d5fd with SMTP id 6a1803df08f44-8f3c8ff79abmr50486116d6.10.1782995700253;
        Thu, 02 Jul 2026 05:35:00 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-698ad13426fsm895805a12.26.2026.07.02.05.34.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 05:34:58 -0700 (PDT)
Message-ID: <46ab1a2f-45b2-4580-afea-a55073fd29b6@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:34:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/14] wifi: ath12k: Switch to generic PAS TZ APIs
To: Sumit Garg <sumit.garg@kernel.org>, andersson@kernel.org,
        konradybcio@kernel.org
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Language: en-US
In-Reply-To: <20260702115835.167602-13-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfXwoymbAz2mlBL
 9+yUXj8Sv4mCZhGb8SodQ96fF5kNvfOHqP4PQWuYPlpiWZJyuzrpOH3Bj4ziQYoF5OJ3V3+YIR3
 QNiD4H+2GMW9iYj4mfGpYK4kWtiHxKk=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a465af5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=5GrnyDZj1TGYcITIosYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzMiBTYWx0ZWRfX6I5rUVOjTDPa
 yw+EZbwXhNeGzALGSNIsvCjLRG2hnajDdwZA9vn8QZy+6g51bi4ZnJO3Xmkik81mfNDAH/c2YAD
 ehPJtTIwktvBdsSBLKK0dumHLOnB1ICG+jvZnUQc0INAYrvpHMnjM+cdjDmgoMRU/YMS+aW4S/A
 bRUK8f5QGNjB/GK8uhN6iKqBL4GD4I+2DhEqUKyc7JVaBv1QFqMbpBdg00UWLXFSpOodlixg1sM
 nVSA4/PqePrmWjIUCbCrbt1zAKedc3i/ZmLX5yn1R5juDLPMCLt7aTRXXTNPAMNH6Gz/DCFl1Ji
 F3r4PY5R8NlP5WXmsd4muo6kfIzm+Pm8pJyfem/8B538I3624sfj0GtOMqKm10Y+6WdLjOmE8/H
 9Yk03FLAfDRB+87mCVZnjB4tqsHSmZJiv3+cVfma/5oCpOQpnj0SZUPKma+sgg+GJOw4W1WlImc
 tC8uysUaa0h7fRICbZw==
X-Proofpoint-ORIG-GUID: a-vylnqLWy-_ozzH-ISt5dW3fP1wGOC6
X-Proofpoint-GUID: a-vylnqLWy-_ozzH-ISt5dW3fP1wGOC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020132
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.46 / 15.00];
	BAYES_HAM(-2.96)[99.82%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.219.72:received,205.220.180.131:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6A60244E4C
X-Spamd-Bar: ----
Message-ID-Hash: L27ZZEZNOMPD2BCBM3MEFD5LEK7RWFSR
X-Message-ID-Hash: L27ZZEZNOMPD2BCBM3MEFD5LEK7RWFSR
X-MailFrom: konrad.dybcio@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualc
 omm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/L27ZZEZNOMPD2BCBM3MEFD5LEK7RWFSR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Konrad Dybcio via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

On 7/2/26 1:58 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Switch ath12k client driver over to generic PAS TZ APIs. Generic PAS TZ
> service allows to support multiple TZ implementation backends like QTEE
> based SCM PAS service, OP-TEE based PAS service and any further future TZ
> backend service.
> 
> Acked-by: Jeff Johnson <jjohnson@kernel.org>
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
