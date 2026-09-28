Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A47C9833E
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 08:53:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7B87C453D3
	for <op-tee@archiver.kernel.org>; Mon, 28 Sep 2026 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790585637;
	bh=F7U42UvQzWZFhuElxJY3mKvQI8WKyTugGwUqiN91t+Y=;
	h=Date:Subject:To:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QbR3kBzkoUnOW6nxFq2PuwDvPMwhtOsnkmz781f+plKJB9mdS3PtsjMhK2rLw4FSk
	 AEQ8IDHnKxuYVqciUTyqwTVbmYnSwM6NMZqPVFNdlgTkO36bQpWpOdIko320Wdy0Ix
	 0b5nNzZHtYhicWsyFxbmT/LwoWlMOEzXTQLXZ3fgZS4dHjRmHyOE+agBOZ8+S+xLe+
	 zRK6zuJLdsTMlq+PY1l5C9JGrEc1JAmep4l1yIOq08r7XndnMuwpubtV/Fn+CO/D48
	 yaSUm15jpxQwcPcWc8Grq2guTIHvNKRb5hSraae3ZQef2cL8uN1JAJZYTBRFFx2CCU
	 hIUmItu8cS4lQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E987B43EF5
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 08:53:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ewoIFBj1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UMscDy86;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S7xN91136937
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 08:53:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dFzPDIqo25LVzunszNk3v3FTUxTHzronweZdB6wdjOo=; b=ewoIFBj1T5TXjqnn
	lkx8AbSPk2gGJhe5irTuJE7BHvPLHJbrlbJrQx/1IJ4dLHfZS9ND1OMqtRSM2bkE
	yVakiWGp9QphCsCSlLlSJgJg7ws7uvAced/Ps59Pz6QgxzmANUf+EZtlXXSgzvk+
	qQqNQkYqH80seIpdknJJj3rv5tpGgFoiSbDrf2V/06Vww4vRFZK0QL0jB9FMH9lY
	4ibwuKTTWALmzvf1GE9M3Svga/k4UAeyil7sQzX+oWUGnhlhHYmZ2XYFRbAquQJ1
	GMZUvfp005hEoDnBpMVYou2KfG2J953g3dGWMyQ8YWpoUq8PAGCtgbVQlFWYELgq
	Jw+gyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyebq1b2b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 08:53:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39e3c10ac70so4088798a91.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790585629; x=1791190429; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFzPDIqo25LVzunszNk3v3FTUxTHzronweZdB6wdjOo=;
        b=UMscDy86d3+X3Jlt6QYweYSWuUfS6uRX0+bU+NR5nB4V0UFrlneOuJIpudbSLIvg9Q
         oKR/NfxhJLbgYwtcZwQ+wwdjekbjhCdlQJ2DBTdc+20uW5mlIsWE/80epixUEVQIbs4H
         EvzVqVHqcUntvSQhF3pm2hTrGyUKBnplbjOFhjVY/HdTkEZQzlmWGT4PjCY8QgdDxyVH
         WeGoDg9jQpNPDUPk4xUGsLQ8lpOhM2XroRbEgpLgH8xY16ARH3HSm/QoGC8wdvaIAWtD
         vnOfCzcIf4H88tE3eMkzboXpJugsYhCj1EZReMFpI8p//AMt8v6ZcBg13kPg9k1R9WNy
         gxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790585629; x=1791190429;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFzPDIqo25LVzunszNk3v3FTUxTHzronweZdB6wdjOo=;
        b=UXDFVHWE16kZtdksjVeE6uMyCp9DVcCyim7yYcgdKOw1JKGMqbROh6H25/43Aq5oy9
         tRKcjFUNjOL1Bm/KifERrfx4wQk9kpJQ69KJmDNDEGdEE11fpCXWOzwYjdIzC46gDLIB
         Qhvma5JB6RKiGP53jWZQfNyX4yG92qD8NFX8bcxtmXqzzn9BOwfkcHF/oKn7FpZz6r1Q
         dJk2eDmgB6iiL+kVG6ip/1swLBF709mUiJ5XJzQZmVRI5ySF5WIwm2Y+u5/HBntx8vdP
         uiTk12oWSA6kBF2UqB35o6d6WHPSOjhdForC+h52J4Cj1VbP2pPzSLhcRtYDlOUyXfK0
         RfjA==
X-Forwarded-Encrypted: i=1; AKwUvBxBI36kj3hu1Ho/5ur0Ek+okfZ+hk4n+VhFeN0oEjAFtKRytGoiMRUyVAQwDBDfwnvjo+fkt7U=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYL3BEooVzWkC6NaJQrRs7zLjDre9EynrBo3/sxREWjyEvG1jzv9
	tpvd2aXb72QwZ6Au7s57w1lon0JmVFUOB0jwfALCleM5b4q69+Uw1TiRgVAX34eTXHGdDsRMx5I
	hb1oGIslt/qxchy2aoy5mjS3V15EdpUJ+4Pb1jR+pZ5FSYY4iSr/fS4FXxsTAIP7O9+Bx9lbS
X-Gm-Gg: AYBFou3Az8c2tH5me2mrAe6coSgwUBFEMBsHyWYOn8t/1iF2f3wJCOyZKntyTG7RUEz
	NdyGGtbMkku9wXATV9+rr4J26J0Rg/vQ3+Q/YIuCfH1DN8cU546GYtbhfrwpCijpGd4mEsrjZ3n
	7f+etixLK8+inEyKznq9X5Kf8eQ7yQvgviOo/6grlwc/daCZfWWugvxSD7Jwhyl+gznHMNoBz6B
	+bJcJh9veGIHcJwvzqa9ePtxBCTe7XcP+g3wHk2m/l7DtFNcSwSQBn8dAJ6XUaJAfvtMmgDI/PQ
	KsfTXC0JcVytk5n8h0OzO73QVHcK6pK8uGnwplajoWxDYQ4LN5Stl1kiljjvgtUF+knLN/DpnLC
	wu/4PLcCtXblOme39O0mLqBeKbr2UwA==
X-Received: by 2002:a17:90b:52cd:b0:39e:6c69:9b8b with SMTP id 98e67ed59e1d1-3a099231f90mr9701499a91.48.1790585628794;
        Mon, 28 Sep 2026 01:53:48 -0700 (PDT)
X-Received: by 2002:a17:90b:52cd:b0:39e:6c69:9b8b with SMTP id 98e67ed59e1d1-3a099231f90mr9701484a91.48.1790585628348;
        Mon, 28 Sep 2026 01:53:48 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b898cabesm20093428a91.0.2026.09.28.01.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 01:53:47 -0700 (PDT)
Message-ID: <e550cf6a-f21d-44a5-abcc-a14ed290268c@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 14:23:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
To: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SMFtyx4n_7_KHEDJjkw3qVt_mQpBYkVi
X-Proofpoint-GUID: SMFtyx4n_7_KHEDJjkw3qVt_mQpBYkVi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX9V3I8H/z34yE
 aAY51LKlwZxnrH0pBpTt1QQi2jpLk2IT42pLGDeKFjBeN1/PAXzrQRpeIor0OJOWhl/gB2CshpQ
 AXlu5gCC0soisUk+QsK5y1TQSoY+Pi4=
X-Authority-Analysis: v=2.4 cv=EqRHPicA c=1 sm=1 tr=0 ts=6aba2b1d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=tyUXrCcEVTDm3v3Bg6kA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzNSBTYWx0ZWRfX8Hp8Y/SqhgZw
 R4Z5FboYmg4R9RFNbb6YSTShX7P9CQzr+nzy2AwpSUttglpJQYQLoYqq6aDkbMLqzi72LN3m64W
 L+2RHu1Rhah2qm9EAV4x8W5723L5P16/Hhs8mocY9kCT7li687mL5zucw7oEW8tlUV/OjFQYyn4
 TSVLpxOuq/n0ntqI9DWPXXwaaI701yYsvlDAphb8lpkf5sGm94+ANBQIjQlKksBVX35rCbsFiGW
 AHrTX7TbtDkSmb8xVNxRNYIkgSlm74IcDM2oZWy4g4W7AZUumkEn1dVZlaQDHMuVzKV8YEQJTWN
 LTVG3/EA4UMyMfqZrjptJI/uxTDj0FRgcLzmtVAd7in4/MYRwYHq7lBF5vLPPyaPHCNH4NSc/g1
 iRFVNnQBOPb65V7iJZkvoBSftzYyrZo5gQjW3lMRzt+DKkgSZ3IDzdWuAdOLQWMcCJMyxy3lifU
 OPRULXPc7cx0iOTWYlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280035
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.08 / 15.00];
	BAYES_HAM(-2.98)[99.90%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E987B43EF5
X-Spamd-Bar: ----
Message-ID-Hash: R35AL4FDPDDGPHUOPXVP7APP3BKQVMDP
X-Message-ID-Hash: R35AL4FDPDDGPHUOPXVP7APP3BKQVMDP
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R35AL4FDPDDGPHUOPXVP7APP3BKQVMDP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

On 22-07-2026 12:29, Harshal Dev wrote:
> On Qualcomm SoC based platforms, UEFI stores EFI variables within the
> Replay Protected Memory Block (RPMB) which is only accessible by the
> Qualcomm Trusted Execution Environment (QTEE).
> 
> For Qualcomm platforms without emulated RPMB support, specifically
> platforms where RPMB is not located within SPI-NOR storage and instead
> located on UFS/EMMC storage, non-volatile EFI variables can only be set via
> a callback request from the UEFI Secure Application to the RPMB service
> running in user-space (within the QTEE supplicant [1]).
> 
> Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
> QSEECOM based uefisecapp) does not support callback requests. And on
> certain Qualcomm platforms such as the RB3Gen2, attempts to access the
> QSEECOM interface fail due to lack of support within Qualcomm TEE.
> On these platforms, a TEE based uefisecapp client driver is required to:
> 1. Access cached & volatile EFI variables stored in uefisecapp's memory.
> 2. Ensure persistence of non-volatile EFI variables via writes through
> the RPMB service hosted in the QTEE supplicant.
> 
> This series introduces such a uefisecapp TEE client driver for the
> aforementioned Qualcomm platforms which installs efi-var operations _if_
> the QCOMTEE driver registers support for an object-IPC based uefisecapp
> service on the TEE bus during its probe. Only new QTEE firmware versions
> available at [2] provide this support.
> 
> Thus, QCOMTEE now maintains a static list of always-available object-IPC
> based secure services exposed by QTEE. These services are implemented either
> within the QTEE kernel or within a pre-loaded Trusted Application (TA)
> usually loaded by the bootloader. The uefisecapp TA is an example of a
> preloaded TA loaded by UEFI. A static list is required since QTEE does not
> yet expose any way to dynamically query and enumerate the services exposed by
> it.
> 
> To facilitate object-IPC interactions from the kernel-space, this
> series also introduces a tee_client_object_invoke_func() to allow
> invocation of TEE objects similar to the existing tee_client_invoke_func()
> API exported by the TEE subsystem which allows invocation of TEE functions.
> Some suporting changes are also introduced to track and handle operations
> for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
> driver.
> 
> Finally and as previously mentioned, access to the object-IPC based uefisecapp
> service is restricted on older QTEE firmware versions. A new QTEE firmware
> release must be picked up from QArtifactory [2] for all upstream supported
> Qualcomm SoCs to enable access to uefisecapp service via the TEE client
> driver.
> 
> Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

+Jarkko too.

Hi Dmitry, Amirreza and Jens,
Can we have alignment on patches 1-5 of this series?
Please note, 1-5 are needed for tpm_qcom series[1] merger and since tpm
series is reviewed so checking if we can proceed with 1-5 atleast and
keep patch 6/6 discussion separate?

[1]
https://lore.kernel.org/lkml/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com/

-- 
Regards
Kuldeep

