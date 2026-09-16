Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3553EC88E5C
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 09:03:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 45B5445495
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 09:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789549390;
	bh=8UFeeybC4bmuxiusNOrf9sVTHbKx9+PFb0qkWwY8hmM=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jte1PitfE8i09D2XnlmHE9guQy6NRytpJHqiOndjh6intnmDo3xuP37xi5U6qM4gV
	 DPi4u5wJ91VpzsnipN8XiFf/mPIv8Plh6Efttdy+64hoMGPbIQi8yFfMJDfKF2fsqf
	 kBiZcYmmguzK2nCeKGI8SlQigp+D76An508WP14Nj6HDUHYLdvCKqoZADsZcjnx5wR
	 ylZvtPKsiDJasvHMKGtrZxlyZtnTfT1y7bVNHGWJfOKvDsy6DYU6KXkx3aTFVMkpc8
	 5IHOZxrGLIzvNos5wPMWfPdLI4ym8O9l1glsB3Pw3oyg8lUAGi/s0fuCYat/nBxwsU
	 TZwmaFQ4NUD5Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4BD874501C
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 09:03:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jkbt/Ib3;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QzzI3B3i;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G932vu1587167
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 09:03:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r3NqAKzdAq254vliErom2NOcRQ+52lRi7cu+PTb9OTg=; b=jkbt/Ib3oZlFP/qY
	vx+fBsJvf/urm6HHBVNHJEfqN+K+1JycMarvEp7bms6ylGjyamQbsxxNuq8dEjQW
	8aCJo6pmz0ThQb0ww59Iu+Mt++3LWirm27pFMU4c/9zi/Stlz+FHxXw/qLaw5TZS
	YMulhlCOH6ZKCujjdwzPW+YdWgFwMjyYTi+MQGYguwylPkYQ+G1X6bFPtG0+wBCd
	/aPh7oS5HERU2ICluTxLftnoFtiaD1YCL1oRzVyKAsV6SryFHcOYkBEZ7ngnstpY
	g3VVCmBTxjoPKuVci6udACnFTxZsq/Ieupa3DZEmwSnYSnpruBwOSruUfiWYQnBq
	EVp1aw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqagekcy2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 09:03:02 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6c2549d0cbaso7548899eaf.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 02:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789549376; x=1790154176; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3NqAKzdAq254vliErom2NOcRQ+52lRi7cu+PTb9OTg=;
        b=QzzI3B3is8LDg/Z3CNuaXZ2ImOVc7+xeSGvR3FBk1pfuJeBDIPZUBLy4fvVH8PDsEC
         k9yVtjgmwER9ZcAxxTDYPFAy2H2HDFuKaRHMGxwceDeFMtD8hLrx/gC4aCiaLQ/5Rz1r
         GrxK3m1amePFhkiuQedDyZU6qQimFpRiAxWSSuj1QNclgDxFKr0SumXFx05oOADUJDKG
         VllnpagAdcXehFhuE+8bPVa6aWYSNhwa9gRk5aL1svePfFW9tgD7uJT4xuKTZUpbvkMx
         3jBGJZ9t/QALP3oay/A9gzguNnpMYhyZfqa4cB1tsA3doLUMo04dIHoNGzpXGibZxwWB
         Imsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789549376; x=1790154176;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r3NqAKzdAq254vliErom2NOcRQ+52lRi7cu+PTb9OTg=;
        b=vPOgNpyZCDyT1FckpOA+7oAiG4C6JaacV/vRPchaznGMGricQ10UAuDj4N6WRc2Xfi
         R3/zYCmckHmOVT0kg16nSenRavDbDV+EzvsqRnphZLA/8B2junT/RyeSLeUafe1TOh4q
         KY6LuvuMKqln8mY/8H5dZpeajma8/+YEVCQRDNuftGLorBF0dohlXg+VxcobTDN+hZt3
         vPJiUFhwg9EqbKwUvB3+xfhJiCMn8pMGaArP3Yhr+TYUd9Eusx3WGjrlmeF0ZYpLSTil
         d5eyMX8891BfkMXc3g7Ao+UIhv8dBaLjvcIBkIckXst6nFV4tf6QxycPmcL6XJjjKElk
         EzlA==
X-Forwarded-Encrypted: i=1; AKwUvBx/RAoeVpyipO6ed3gIAcezI5Od/vRAdz5nJuAGDeVmmJ9JMlQEy6NGWHESicJtrIS1alH8x0E=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nnOVSqX6ZtzsFj69+s1ydCPrv/nfWPyUIMsSI3tfU3q/dTYzyt
	5HIP8LI9kxACKUP7meFLA9WaDWTUzoz3slHJ7diqGoF8K14WnDdMbvZIaym0PW1X4UppnavIhTb
	dIPC7X+t3KnvPyIbKh8MQluBrBM62DY6B3PbXe2moqvtvyUUifnJcPJXFKkF8a+t9TYS8M5Sk
X-Gm-Gg: AYBFou3Frl+qbnN5ebSJSjNg9j7PhKTCEvY6GGvztMQqcpY6a4gXx0KB1C2SLVZkpJM
	pjvkKkXPEGkNut7dulJNx4+ayFmcdDLaFVQdUKp8KG5N4pKSsvMnHec8YSrZ1K6oZ1BeTgba7+D
	AZdsuTavnvFipqYMb3kgg7sQK2k7Ans0x/EBH2rFyzrOINb2Wp30YnXMbOhiE65lMogFYdEpkzM
	lGXexuMzbxRDgJYSWE/isa59QltN9HKd7N4yD3N0Wsq8JuMK9nyzKDQm+naoWseszlkoC+z4nTP
	8STfu+ekZeer72bZKgsST1Fl1C3isMo0LfTRb4CfpwqH42k8hjg+XbRXNtreaoJmL8qTwu7uj9H
	SOgWW75VLXVM9MnSTFDnzAbkzoYnYFCk=
X-Received: by 2002:a05:6820:81d7:b0:6c0:e39e:c22d with SMTP id 006d021491bc7-6c7d48ef8ffmr1847062eaf.53.1789549376049;
        Wed, 16 Sep 2026 02:02:56 -0700 (PDT)
X-Received: by 2002:a05:6820:81d7:b0:6c0:e39e:c22d with SMTP id 006d021491bc7-6c7d48ef8ffmr1847014eaf.53.1789549375491;
        Wed, 16 Sep 2026 02:02:55 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1e38sm6413732eec.16.2026.09.16.02.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 02:02:54 -0700 (PDT)
Message-ID: <2e5278bc-5f11-43f3-8e9e-b70786a697b0@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 14:32:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX2Bvjlq75cGIc
 jHFDjP55NiI6TIgHz4JVWAlJpHdw0Cbm+NfBKinblr84Rv6JX2CyWA0CPI3vLjo8VnRslFh7KGE
 lIHkpuFFbTI2rOBern/fki/ti7smdWY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNiBTYWx0ZWRfX299+h1GATMiL
 YX3U2GTcSlSFeHwgqUHf5U9dTb4qUH8TA6U6aGc1MGW3yHE+7aiixbXthUGNJzRudSANw4aTxG7
 7Df/1v05hZEoxnF/uebGOjPk/hFoFxlEU1yudVBrYGFkOsq8GhuFIIJeVa5//Pbvo7IsvG+orGa
 o/H9EBB4VVgbtVMVuL6SlW75HsRK0AN8vfsM7EuZNtNij5Qsh6S4rNzKOn5eNsx9rcTijouGW9i
 oHH9P0OX/K7H/X4g4r4IbDHYi/FyWvGXMmuptpv+dd0z3YUGhNlZxVwrZyo2fStyERT4cx97Bzs
 Txaqf97c+lQ/rsqB4P6L5wCu1L4o6I8YnnLnhBw9eMt84NeRNucNGg4LoS46wpyxL5knUj7MKDe
 qJ/duUnUkmyc+u1Mhq1F56NX9EJD6/4S63xfTe+7Vk/rn6qTGLcArxODPgKYBVHFqOKpDeMkyzD
 5EGaJdss3cV9HgdH21Q==
X-Proofpoint-GUID: 46x6iKs9w-fe9vJHpPsZqouJxhMtxEHe
X-Proofpoint-ORIG-GUID: 46x6iKs9w-fe9vJHpPsZqouJxhMtxEHe
X-Authority-Analysis: v=2.4 cv=PcZqFShd c=1 sm=1 tr=0 ts=6aaa5b46 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=QTb_0JKWY7oM6lVZCfEA:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160116
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4BD874501C
X-Spamd-Bar: ------
Message-ID-Hash: 5OCJLRDQKB5WXGZUQV3B5JW7QR2DKEWP
X-Message-ID-Hash: 5OCJLRDQKB5WXGZUQV3B5JW7QR2DKEWP
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5OCJLRDQKB5WXGZUQV3B5JW7QR2DKEWP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 07-09-2026 14:58, Kuldeep Singh wrote:
> Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
> a non-secure SPI channel from the kernel. Arm's Base Boot Security
> Requirements (BBSR) v1.4 require that access to go through TrustZone
> instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
> fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
> Execution Environment (QTEE), which talks to the dTPM (or implements an
> fTPM) on the kernel's behalf.
> 
> This series adds a kernel driver for that TA, built on the QCOMTEE
> object-IPC transport (drivers/tee/qcomtee/) already used to reach other
> QTEE services.
> 
> This patch series functionally depends on below(patch 5/6 specifically)
> for qtee service discovery.
> - https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/
> 
> Tested on Glymur-crd target with tpm2-tools utility.
> 
> Validations:
> - Get capabilities
> - Random number generator
> - RSA key creation, encryption and decryption.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Hi Jarkko,
Kindly let me know for any review comments/feedback so that we can align
and shape next revision if needed.

Many thanks!

-- 
Regards
Kuldeep

