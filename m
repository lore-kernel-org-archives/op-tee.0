Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE46FF8867
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 07:00:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CEA69443AF
	for <op-tee@archiver.kernel.org>; Wed, 29 Apr 2026 07:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1777446035;
	bh=1o8QqlAow6PmoPIT9dbQVNVo33WTouwEyxLpj5AEVfE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=1yjft60IAVDYt5UFL0Um6IDoO5osIvIn/feX0bTPaLnaxCdvpJx+nYbFunKYBNRxH
	 QZSeGbE5gkiwn5MtK+r1iviP50hDY5oEY9PlZGs4PUb3QohNcmIBfcqB1JNa9Iz0Ac
	 Rn7WoTEPY1HDyfYEEIhHl5qALcabC0/jDwrzgx1Mr5CBIvDUiOKfdzdgXQj7xGWKDm
	 UZVvMk8uNAFxrfhzPdW24D60KvTcHcxAjtvgj5Tgn6jPBy+YBSUg+arjE6s5qnNRxU
	 jm0aBIgsV36FGS6z/1hTty6irhsa+kri608atx2aXEGTKPJoJhkDu9tShRyvOjb2yL
	 T9v+p5CdgKmzQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E232A4440A
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:59:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g438JSka;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gOy3qUMa;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T5q9pr3347488
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rpnLGvqaOGowhqbh0BhtKXXR
	xHvBmmvOGqR1wADwXo8=; b=g438JSkanjOpVQqT4BPx3R6bpd1VJbbmWFD6dKOd
	jFfFB+w7o2BFIQkM8DUi3dk+eLi2MmG2yFu2mvJoaVjZRpuKpKC8SOHGN1T4k6HZ
	eH9ZrtpUlQslZMlhYlYVUFi72Xrodhf1bXWVnE64mFiuiPhsLVRgk76DPLSLdQOe
	3wpSPbqj+929j7SchNlWiT/Mvmx2f3w9te7+sxffPyvR3SZ4QpMR9dvdKxnbHoHd
	r/5cgF5H5psWIcz6rpRnrZ7KiVHDlYy0AVG7IKRCWWDzx4ABdZYlug/nS7Nc/tDD
	/Al6A+BepM0Qxu+178Yh7cY8Ecg/Vm71wutdCwmhxrioxQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du2m4t278-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 29 Apr 2026 06:59:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2e06219cbso146125285ad.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 23:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777445983; x=1778050783; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpnLGvqaOGowhqbh0BhtKXXRxHvBmmvOGqR1wADwXo8=;
        b=gOy3qUMajT2diz9BGMh0AL/ONR4MJr2lZKvUHGGF9P/PfHOTXb1VG/4JMz/t7RWEDi
         93HNBLdxMzaFitwW3BL9l5yPHI2EECMqrr3jUGG5fuVwVvcomPcZJ9z4oTVoujMErCdk
         YJBhwoQvwLr+UGQ/jcAnxoUY4uCik2GaFOIVvMdzzvc/iwoHP7FriP+TBESGRfvVVIin
         VDSQr6ez8o+3aBwoOvolJ7Zz3AJtM3TUgZXHoF1sbCT2hOLowltLb8DpoLlkfWlGqdi8
         o/5fvFwrxCx+2GmIn8YAIkJCpoWq/v7PFpX0NhpyD0LeOBkjPFx4g/tZDF4exa9XF140
         hVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777445983; x=1778050783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpnLGvqaOGowhqbh0BhtKXXRxHvBmmvOGqR1wADwXo8=;
        b=C3bdngw6ty3nVAfNpDxC/o183BJZjTTjTDw9iFZWQOU1C476AL7Dmh424a2KQZTiAt
         +3k30fnNWo6ZTqYUaJdre5SuZmkz978vsQ08d8YpN+Ccg4v2wHH3sJ8x7XI4Il/a/BA6
         dRpzRpcFE9nkCSjsaYIYZKJV4V9OJfwfxhz0NDohOJVk5aBZsCZuCr14OGH1UUNf3YBy
         8jfsABEYDyhCI5nkwSSD9HKq8LJhuJT4iCf4rJ0UlLsRgiAxrogMnUzPUG//TgJgS/RU
         mo2gP4vPUZoUWTKIORJR9iiJPy6RTVoO58eVsnPnErMCtkDahUeBpM6wD86zPnZDV09z
         BlAA==
X-Forwarded-Encrypted: i=1; AFNElJ/77qqT6EuR5AOhSAEHgkUSMrCF+ccMZ/ONF7rApgQT119b8ZOTTzmygD3Fup6z1vhxm0omAQk=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzq17ZL2pJ4X1qZ+xF9b1C9DF0QoSKXhsUc9SLS8XeRX28kAfX/
	+31xQ/e0c+UmXFh+bR/4cup/0K6ymOglL97suQEB4wQJhq1n175iDLdPSmXZVDz/Yw9U8xfpZOs
	aUY+QNtU/4q57KWRRpSZnqboBuzeGCkLnOPL12eziepyE796y090EDYWvm4REOxOUiMrsHTC2
X-Gm-Gg: AeBDieu6afoCRrjTGUBaggKxJgMUgVCTreDeW/URNOj3LMwKelceZDeGI9GoHQG+9gS
	2XYlalksXwY/QdddFzlGglkwxIeLNFGa6ccNWYBBQwvoAu63DF3wN004ED0PlzkD96AR7hbH8po
	DiqiJhjqF1x7gHO4p11ItO3UN1t81jQQtCRIxwUBv97HswywRXwXlV12UaxFsRbVJg0NzPI2hYQ
	C4s1643DTneQCyWLbMRr/da1An4lRKUf5sQBbeeftopc7ztB2/Fh0utZL72VHywQrA3/tdYCC8c
	Y+lP4goEWfpI7yAUlUQZJekhUMR/6MgAiXunCyMOr9VImsDN1a23hTDwoQ9VqxkKt0KlOMOrKRR
	DnTwrP+kGJ5fh88ZdHrLrrzIMuht3vXgqHCRb0ogU3bawpU4hm6pItQRShoE=
X-Received: by 2002:a17:903:984:b0:2b2:ec31:25b0 with SMTP id d9443c01a7336-2b98741da0dmr24709035ad.29.1777445983168;
        Tue, 28 Apr 2026 23:59:43 -0700 (PDT)
X-Received: by 2002:a17:903:984:b0:2b2:ec31:25b0 with SMTP id d9443c01a7336-2b98741da0dmr24708625ad.29.1777445982436;
        Tue, 28 Apr 2026 23:59:42 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988971938sm11669805ad.71.2026.04.28.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 23:59:42 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:29:26 +0530
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v4 00/15] firmware: qcom: Add OP-TEE PAS service support
Message-ID: <20260429065926.5iliebd3d2j6bong@hu-mojha-hyd.qualcomm.com>
References: <20260427095603.1157963-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427095603.1157963-1-sumit.garg@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NyBTYWx0ZWRfX/7R1ybZQsTv/
 AsCu2pKsc6matAlbj36SBUBzInD2dZAyZYbj8Jw2Ho3lsHOlwD+7ZhXYIMOrH0amA+56M+2v6nX
 oXdHyMLFrX9x7x+aKCaVCR7KESfdAlQCsXCUD22O424aC3xmHYVlVF+/A0EHtzdH2URKgBPcvdS
 K4Al+CNCh4ejdFxS83mvDvZfWoyxLKx287zzYqtzlBxANYkczKYXL1/H550iBFH6mu2KMCsL8dx
 082WUWP+Y0WT+1BlnL8UcyqhNhb/kM9IR0/aR09pWMURhrGPB56lEukLYrBvtESKj5O0nE3Q4vU
 8s/4qps0RtXOU1BeRFCKQ81bmlQzUyzbATrG+zBnNno7/QWIWe8WV7LtcNxeVb8WcOi7OdUxZjp
 lb/mYKxSHDXtpc1YwsL9gwC5TmSewymtRCmfLTz1MA28jgrBWlRscA9pd+X/8w06aVzlrULDTBo
 DRLAemEbOHqYtWX1wFg==
X-Proofpoint-GUID: iJgyGRGfUxMVEPuINkXRXcHZT-EOEGoq
X-Authority-Analysis: v=2.4 cv=MuFiLWae c=1 sm=1 tr=0 ts=69f1ac60 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IpgJVh4PXWExouJfQAQA:9
 a=CjuIK1q_8ugA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: iJgyGRGfUxMVEPuINkXRXcHZT-EOEGoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290067
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[202.46.23.25:received,205.220.180.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E232A4440A
X-Spamd-Bar: ----
Message-ID-Hash: TE662JWPEDA2VPXVG5ZUSFMFEKMYO7H2
X-Message-ID-Hash: TE662JWPEDA2VPXVG5ZUSFMFEKMYO7H2
X-MailFrom: mukesh.ojha@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanat
 han@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TE662JWPEDA2VPXVG5ZUSFMFEKMYO7H2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mukesh Ojha via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

On Mon, Apr 27, 2026 at 03:25:48PM +0530, Sumit Garg wrote:
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
> The TEE PAS service ABI is designed to be extensible with additional API
> as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
> extensions of the PAS service needed while still maintaining backwards
> compatibility.
> 
> Currently OP-TEE support is being added to provide the backend PAS
> service implementation which can be found as part of this PR [1].
> This implementation has been tested on Kodiak/RB3Gen2 board with lemans
> EVK board being the next target. In addition to that WIN/IPQ targets
> planning to use OP-TEE will use this service too. Surely the backwards
> compatibility is maintained and tested for SCM backend.
> 
> Note that kernel PAS service support while running in EL2 is at parity
> among OP-TEE vs QTEE. Especially the media (venus/iris) support depends
> on proper IOMMU support being worked out on the PAS client end.
> 
> Patch summary:
> - Patch #1: adds Kodiak EL2 overlay since boot stack with TF-A/OP-TEE
>   only allow UEFI and Linux to boot in EL2.
> - Patch #2: adds generic PAS service.
> - Patch #3: migrates SCM backend to generic PAS service.
> - Patch #4: adds TEE/OP-TEE backend for generic PAS service.
> - Patch #5-#13: migrates all client drivers to generic PAS service.
> - Patch #14: drops legacy PAS SCM exported APIs.


Gave it a try to test the series on Lemans with Gunyah as well as KVM
hypervisor and all the remote processor are coming up successfully.

Feel free to carry 

Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans

for the Series.


> The patch-set is based on v7.1-rc1 tag and can be found in git tree here
> [2].
> 
> Merge strategy:
> 
> It is expected due to APIs dependency, the entire patch-set to go via
> the Qcom tree. All other subsystem maintainers, it will be great if I
> can get acks for the corresponding subsystem patches.
> 
> [1] https://github.com/OP-TEE/optee_os/pull/7721
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v4
> 
> ---
> Changes in v4:
> - Incorporate misc. comments on patch #4.
> - Picked up an ack for patch #10.
> - Clarify in cover letter about state of media support.
> 
> Changes in v3:
> - Incorporated some style and misc. comments for patch #2, #3 and #4.
> - Add QCOM_PAS Kconfig dependency for various subsystems.
> - Switch from pseudo TA to proper TA invoke commands.
> 
> Changes in v2:
> - Fixed kernel doc warnings.
> - Polish commit message and comments for patch #2.
> - Pass proper PAS ID in set_remote_state API for media firmware drivers.
> - Added Maintainer entry and dropped MODULE_AUTHOR.
> 
> Mukesh Ojha (1):
>   arm64: dts: qcom: kodiak: Add EL2 overlay
> 
> Sumit Garg (14):
>   firmware: qcom: Add a generic PAS service
>   firmware: qcom_scm: Migrate to generic PAS service
>   firmware: qcom: Add a PAS TEE service
>   remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
>   remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
>   soc: qcom: mdtloader: Switch to generic PAS TZ APIs
>   remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
>   remoteproc: qcom: Select QCOM_PAS generic service
>   drm/msm: Switch to generic PAS TZ APIs
>   media: qcom: Switch to generic PAS TZ APIs
>   net: ipa: Switch to generic PAS TZ APIs
>   wifi: ath12k: Switch to generic PAS TZ APIs
>   firmware: qcom_scm: Remove SCM PAS wrappers
>   MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service
> 
>  MAINTAINERS                                   |   9 +
>  arch/arm64/boot/dts/qcom/Makefile             |   2 +
>  arch/arm64/boot/dts/qcom/kodiak-el2.dtso      |  35 ++
>  drivers/firmware/qcom/Kconfig                 |  19 +
>  drivers/firmware/qcom/Makefile                |   2 +
>  drivers/firmware/qcom/qcom_pas.c              | 288 +++++++++++
>  drivers/firmware/qcom/qcom_pas.h              |  50 ++
>  drivers/firmware/qcom/qcom_pas_tee.c          | 479 ++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.c              | 302 ++++-------
>  drivers/gpu/drm/msm/Kconfig                   |   1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
>  drivers/media/platform/qcom/iris/Kconfig      |  25 +-
>  .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
>  drivers/media/platform/qcom/venus/Kconfig     |   1 +
>  drivers/media/platform/qcom/venus/firmware.c  |  11 +-
>  drivers/net/ipa/Kconfig                       |   2 +-
>  drivers/net/ipa/ipa_main.c                    |  13 +-
>  drivers/net/wireless/ath/ath12k/Kconfig       |   2 +-
>  drivers/net/wireless/ath/ath12k/ahb.c         |   8 +-
>  drivers/remoteproc/Kconfig                    |   1 +
>  drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
>  drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
>  drivers/remoteproc/qcom_wcnss.c               |  12 +-
>  drivers/soc/qcom/mdt_loader.c                 |  12 +-
>  include/linux/firmware/qcom/qcom_pas.h        |  43 ++
>  include/linux/firmware/qcom/qcom_scm.h        |  29 --
>  include/linux/soc/qcom/mdt_loader.h           |   6 +-
>  28 files changed, 1115 insertions(+), 317 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
>  create mode 100644 drivers/firmware/qcom/qcom_pas.c
>  create mode 100644 drivers/firmware/qcom/qcom_pas.h
>  create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
>  create mode 100644 include/linux/firmware/qcom/qcom_pas.h
> 
> -- 
> 2.51.0
> 

-- 
-Mukesh Ojha
