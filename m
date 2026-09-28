Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F363C9832F
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 09:34:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9670E4545D
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 09:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790588097;
	bh=aut5EtV7EHnIQnhVgpWGAgLGS+IWWJeo0UTmCPk4f+0=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qUq3/BC0VqrL7xjh5AJhk3TT07E+ngwgAd9ZS4HjGwh2PpiomoC0fw08csa6xVWAD
	 dlzM/Fz7kicQQlwYRpK0KwASmHT/ybtCV5ddI1Xy3Qv/xu1wCfsHFIBPwGTPbGG/lt
	 PUdTvI76LMPQYdmPZ4KITN0h92NOmWudXgTUmR5XjFQjkMHpyd8KlSUpyJA0ZlZx3r
	 MzmZYyOexOqM2gYmZcIaZPvdFZjWzghsn/IT9SHwhPXB1iwdabqT7wW6fNOepYF5rD
	 YbYfjA7f55MJvWMBEoZobbCgqOVzgdQQCUvKu/lpUV6xX2glE9ns+tvNJPWL+qM7hg
	 Kh+VCZ+/sN6yg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7C978444F8
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 09:34:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aLkXJMxX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gLzREzju;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S9M6QG1195673
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 09:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cslUYpSyi91GFkeEotZ13vFtrVwZDY/B9c/HltZgtHA=; b=aLkXJMxXbzCJ6p6Z
	R1DN0vMl5w3AtEV36Um+luOaXUFYzgfWR2zIKCa3WBtp/4Y/sUhP276G4AgiWvys
	3oJs/O/B/KifdYqa4l/M9QEYeYXCkIQaCBsb1f9xv+0qypcfzGc19gHVjZPGahbN
	4fDfnc6Tt8wFluYbpc488aKZpPtjvajURfCEg+wU0zkkOsVJZuhs+Zq8Hu8HqyXz
	M5wCl15K+5XlP6Zkv0rwloBDRvaP+B/N2lm09lneoGQPx5IeXfi3be6ARv9FLCvo
	etyxotJivn6ZbarEhG4T38eXD/9665rybEHWBs3+qBtVtnHp3n+SFv3C8zfOpPpA
	1BGorQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s0w65-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 09:34:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94f086fedso27921205ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790588088; x=1791192888; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cslUYpSyi91GFkeEotZ13vFtrVwZDY/B9c/HltZgtHA=;
        b=gLzREzjuOsykXY1lyuXWO+q+u65ygrFTc/vHPTTTEiBowpMIYt8k5aNOcIywaUBDHS
         rv3UcoMq89+N7Nacd8VriiFY+wTlC/qfDbz9xgk2mB2NL8+AeVhvv2hARwhFgcQ4Y2c6
         P5SYgbb4I0i95qr1qS289/KFEqW+uCD7cpbSLFCCg7OvSrJrdjy5s8sK72aPa4qSkGaK
         FKUfSVmQvdP4vI/WCXozZmD/KnnLhhuXM+2Q3a80En2dmG/VI4SJf73bZtmHROCzbjzb
         r2nQBDBTfVlk6fsmflkCHOoB+TdPJqeTs6/SKlWLZ+hHR1T2Sa308Vac4Z8JWs9Mktl/
         Eskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790588088; x=1791192888;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cslUYpSyi91GFkeEotZ13vFtrVwZDY/B9c/HltZgtHA=;
        b=2fTxr53FZm19vSojQXiI5wVOP4E4B5C3V1owVYzPNYB65S2ZMkVsDYuiXJqt4G+n8k
         l0gP3+/4kcf0Wvq4a5UXd+Cx31FIGIoj/f80nL3XT27NGkK+8tqXVkZ0TkK5vcG/Ie4Z
         RW9OyGG5mIfeChcQe0BJjE1I3gQ7JrIJJrADnSVmM/vgFZvwWx+N1xHjXL/cXvFBfp1u
         Ed+1bPYxG2itbGS7xI2VfyLPNxNtd8hJaVCDmABtxew0ZFMKVLcuwr4BTpCFVoeB/Gk7
         rIfytGF3ElyRoxRLkLns4ZrshW7cViFQhpTO7VIe2LruB9D/hZtpUCQpR93VhJeB94mO
         sq6g==
X-Forwarded-Encrypted: i=1; AKwUvBwhx7yfJRjNKV0es3anVeSKr8apntwoVAgtVnj1vkOBciN3qGPxzFgPsEjeD57wyqJLwqigyQ4=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYL9j3DSXwbCaTQnLSNtmNT4mzyouoDJX+/UkxneC7MCYjJbwx4x
	oRZ85PO0LGsEHgRKnWUAnv5D8kQn10jkIJSmRDk3oa46cPCfszAvNIBVp9dtc81RUDVlxdiWAhd
	tk+F9hUxvy+Nf08Z4aiW7RCbwXVAKgAFpsaNj3iRmWxM9MIqHt9XSLD3zfiqORXHZxWDMXH7E
X-Gm-Gg: AYBFou2YBwu/HXI5UMVZAN53TMF0lV8Dy2dZBp3mvyZXit2Lk0254c9LC3dAMmvk4aE
	clLxawcD0AiHkkQxupUGSy0smJmTf3l7h2/ucVMFkW0GmhU4MmVpDXOxB7NDY/IG0Fs02P4awra
	BCaRTjBdaKuBxyyA50GdFA0JFC5GsnxOUdF+7UJ/Gxhf3UjaYqF8fTpXfJVHy/HKlWrENU7DjsJ
	VXrDRvavcexisXVmd5bHDQDtEJhjRbQedZ7+nyVPVS0WpoYouEk6hzW83aIASAxB65BXUvRKB/H
	8hYME8CLdc852NWywDyHEQy9aFcw7jIpgrEa8KreO0+3TMw5s18KSavfIJmu8y5q+rJeHBR7xvi
	0bcDlqqpAMzDT0gx1Ebj143sEMnF2vg==
X-Received: by 2002:a17:90b:2649:b0:3a0:b223:683e with SMTP id 98e67ed59e1d1-3a0b2236bfbmr8129129a91.48.1790588088379;
        Mon, 28 Sep 2026 02:34:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2649:b0:3a0:b223:683e with SMTP id 98e67ed59e1d1-3a0b2236bfbmr8129114a91.48.1790588087871;
        Mon, 28 Sep 2026 02:34:47 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm19867799a91.6.2026.09.28.02.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:34:47 -0700 (PDT)
Message-ID: <bb9b3980-141e-4ad7-ac18-6ea7b9002dfa@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 15:04:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Jarkko Sakkinen <jarkko@kernel.org>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
 <aqyZtHynb2nuQT-P@kernel.org>
 <d555ee76-3999-4ed0-be6a-ca07354af6d4@oss.qualcomm.com>
 <araJKqHdeXstD7nR@kernel.org>
Content-Language: en-US
In-Reply-To: <araJKqHdeXstD7nR@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX8QqvZ+a5px0C
 uzLfjpd+X8Ihrd1/mwbZ+jzovDBN6kP0jTbvGlLRmjMMnOPS3Xl2suqWxbPywTz+lIWZoJedm5G
 Xkx01XRBqYOeI1ok5Oq2hAhqISbe3BxtnfFRQ8dim9N8JPO/GvRlwVve8JZO54i14JgG5slUoal
 obCHtCs83G21PUjeX47qnnnxSLFjuVopuQnUaA9a8AMFFNq0nzNE54PAhyTY/5luqpu4CA3tjmn
 O+rWFIiW5D/2hlrIGTM7ImQ3wqQi2MrkzLsRNRV+uVL1eTSW16+65OHV0eIi9fpC0pMOLz0sNx0
 4MaEO5x7wdOZzY6t/YczkvADowo65Xh2H6SWffKz8y9/RaSnpPZ9OB1EKUKGwQEsevkfZw9WktO
 kx2jfNxwG5py+CKms1wITxxe3nucWNDXlmUfXofT2m6i3jB4ZMWbvr3nPTonSztMX0YzWrdSn8p
 ZY87DCy5N1gmb+DQj/A==
X-Proofpoint-ORIG-GUID: 71ZcgT5phJ5jl3_bkZabuAZAjfRkBbhg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfXwd+CeWZ2y3VL
 KelJ4uAKI8taYkbwcwjTdhwFG5h7we7veRa4UpMUoef1OxVsoJHS1bezGmqXTrndWlAvCnq4M/w
 4++QQduJl0dtzBZ01IIoNs9YWO26GlU=
X-Proofpoint-GUID: 71ZcgT5phJ5jl3_bkZabuAZAjfRkBbhg
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba34b9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bi0NzNZZtduFk6DORyMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca,vger.kernel.org,lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7C978444F8
X-Spamd-Bar: ------
Message-ID-Hash: BW2BQ2XO5VRDVUVTHLQ3ZLM356WXMIJG
X-Message-ID-Hash: BW2BQ2XO5VRDVUVTHLQ3ZLM356WXMIJG
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BW2BQ2XO5VRDVUVTHLQ3ZLM356WXMIJG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 25-09-2026 20:16, Jarkko Sakkinen wrote:
> On Mon, Sep 21, 2026 at 02:06:43PM +0530, Kuldeep Singh wrote:
>>> Causes merge conflicts with my tree when applied with git am (actually
>>> b4 shazam).
>>
>> Jarkko, this series was sent based on tag next-20260828 after applying
>> prerequisite series[1]. Some minor Makefile/MAINTAINERS conflict was
>> observed IIRC.
>>
>> Kindly note for merge strategy, prerequisite series[1] will be merged
>> via TEE tree and current series need patch 1-5(not patch6) only as
>> prerequisite.
>>
>> To merge TPM series, it's better to pick from your tree and TEE
>> maintainer can ACK patch 1/2 for seamless integration?
> 
> So I'm just having trouble following so: what is the best option
> for you? What do you want me to do? Which route you prefer?
I took latest linux-next (based on tag next-20260925) and tried b4
shazam and observed minor merge conflict in patch 6/6 of dependent
series[1] in drivers/firmware/qcom/Makefile.
Makefile conflict was easy to do as seems recently qcom-pas framework[2]
merged which updated the Makefile.

Also, I don't think we can merge tpm series once dependent series[1]
patch 1-5 merges. I initiated thread to atleast conclude 1-5 so that tpm
series can be picked completely from your tree.

[1]
https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/firmware/qcom/Makefile#n12

-- 
Regards
Kuldeep

