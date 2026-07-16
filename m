Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD344C4450A
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 08:37:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E507C44F0B
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 08:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784191065;
	bh=DFUmG7barH67047rlslm7AUbisk/Fbm3Y0Olr4q+NdQ=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=BmyFdIdMizQltOzT8jeAkYu/VQ19mVJ3x+un/eCiMLqOghi2dItGExS7xnLdY+Dum
	 WQEpwnGX25kXE0Vs7841KhBgDBsfjUAnL8dTBYLpH3jRSDBMrGrOo7FuyTh6nHdW2/
	 6wqvwc7fdTTJ4CP2+9oio8ZkweV6cFUH5Uo9WlHCzZ34npMsdPrkcy76u5v4jhcxK4
	 KzUh4b/mu0Cjg+czBwfnMe/uBLQ8FF/hyymgpLkjUXYp8Ei3xz33I9DtvUAJMtjlJW
	 0Ksrvs6CUdMUhux6JPTN3dVAh1qEGjjQGZPxVVzScNAL0c05vmrKo7P+FcrPDZdl8L
	 Y9iAK0rFDRgYg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5869C44D55
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SLPmVk2L;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HeHbbrHg;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DUW31892191
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aSKnOaJDl8e+I17N0jewdcxP1Pjy4BPpkit
	SoVF0jVA=; b=SLPmVk2Lsc4coujiqO6sa0hT2S1yFA1OspJ6aypmFgErB/CfCvr
	M0cJtG8bnSe2G4EHHNhz406e8YBSxpGPvhKmfEgMXHm3kBD9MTHomtrkExQNEBLY
	LzJc5FB62msy0knD1vgp+YyWRkkUPANL/frzp3SVipnJUvamixPFCL7+OE6cg72h
	hEQL0vdOKZgshXl+FybhI1587OVUF2jdHLiimV9H4VaRALabubsOfHUE8LTdBpHd
	/96sUp/8GHDiXnpz6MfI7+vWvP4zDSmznidU2cEwXg/CsYMfIXTq0Y94OFy78UG4
	EmDzcsfn5AZ6AIatdgol5yp610V/W0sEy/g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecnybexq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:36 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1c7f135bso57839691cf.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784191056; x=1784795856; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSKnOaJDl8e+I17N0jewdcxP1Pjy4BPpkitSoVF0jVA=;
        b=HeHbbrHgyRIR8BMAftPDeAz2OywFMxhbDf/Gt6BkQLgVETART3RLzXW2HPAtc+xj5X
         CfvvfNcy8q8DRyWsbIyNok41Xdl7/afcd2ZlQ15ycgYWBk0QHe457bHUr5d+hph7jrAl
         PcGq98yyo/RCHi8eAk+0ngVtlK41UTIxAqXiFiD2rEat5mH39KUwRenQem3ddf3mRZJN
         0S020dKHboHnWyKxU6Aw9w/dmR8W+NQgqJd29xMSNxAFxob+r80fD9xpMPWI/n2LpC6N
         lklhDQw3tCMth9nrCe6mlSTQXSjhiG4eq7mAX9+U9Uq2B6Urzk+utz6p7D9CbMpJ8UUK
         ZWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784191056; x=1784795856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aSKnOaJDl8e+I17N0jewdcxP1Pjy4BPpkitSoVF0jVA=;
        b=dnL3LKr7EdpvN1e41tacugCzqCMK3wsv/ERrsrjdKIFLh4Ab3ch/+yXDWrUyvSu8iG
         S0h7z8u7hxdnRqTL1phbqszWeOo1BSnDUkXrWFzOWdc5qNiBK4p6lqIILFkp8dlnyaDZ
         2JXUl5MEFUmM6LA2y1x9nhdhdpp5UYgrC+3+TnsOH/A9LkUg9u4EqVB3Neh8eDF4mJsR
         wYJOaZofSzgjniiurPcxKfp7QkDDEQvGjvGPUk76zacN85FFWc9a1StkuEPo/aQokI0l
         IvG+ZB1R37e/+lBg3wW6BBjLxHPKCGTR6j0kFU4Q7jlL8QvV5YZhbf1u81kTfQb6Gard
         82BA==
X-Forwarded-Encrypted: i=1; AHgh+RqedAtSR9+4RNlt4ulRREenje/Gd7AjHEgT4kPbLlbf9/U5G34kIVq+I0VIpZ9t5A2WPNIqtVI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxE0jI66K1klqDCkflwxdDv1o8FB/qTHrPw3fs1ba0QjHjwJxQh
	0XTxc+VaBr5gzffU1n4YPzSOY3n/Myc43oVuQS+j+gxTTDqHW1rZTk3H+mv/2D6eAHgzVFDCFxa
	QmqqIUzQbA9aiBOj9vNFYQltUepm40YbvtBLLKSUDU7KU4ROH3lBxbmqUGM0tO6jOotbJExep
X-Gm-Gg: AfdE7cmFlpSkvccAFfaHE7S1UxObnAQ3ACTWqlwr0b9Kk8zyiZVQEaz49wOoxWyJ6hC
	262SdHPMj8dmMu0t28j7/2wRMbcNru47MP/qoWmQSu5Xj1CdtM4oKIKBLMLoi83GcOvxsCdWQdq
	nUgYUx863eaROPW8NlTjedQvAsxyLvrsWgrVaEzKDgB3nUUyeH61HHvNtSm9jGPfcLItXEXRcn2
	tkNFHXPV0uYBdf9uRhh/RcDX7SwF2vOfHKFiLi/cgAjnLFgQtatAqQXtaBWCfjvuynTxtAZpaAW
	tQoSBrEwPsc89r9+cN1oxi+CSONk3bktfLx5DF14vCIUWrMqlt8QQGSQ+nCBTxZSx0O+8IXd3LY
	hKijJyrhf65kJckoIH6b7WJ/j6hYADDuuxzWGBBobeFq8hZqUmeI=
X-Received: by 2002:ac8:5994:0:b0:51c:147d:9bec with SMTP id d75a77b69052e-51cbf0dff64mr201887551cf.6.1784191055839;
        Thu, 16 Jul 2026 01:37:35 -0700 (PDT)
X-Received: by 2002:ac8:5994:0:b0:51c:147d:9bec with SMTP id d75a77b69052e-51cbf0dff64mr201887321cf.6.1784191055428;
        Thu, 16 Jul 2026 01:37:35 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e94e7asm43614295e9.12.2026.07.16.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:37:34 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        beanhuo@micron.com, can.guo@oss.qualcomm.com
Subject: [PATCH v1 0/2] ufs: rpmb: make RPMB usable with OP-TEE key derivation
Date: Thu, 16 Jul 2026 10:37:18 +0200
Message-ID: <20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4NyBTYWx0ZWRfX2ZsxasOJvloS
 pksCgOlaU1fSUQ0bcE4hhOcFQkbbEICA0/Fqmi4JSkpB7N9k75iVMvjg4Em5JLvz79dJQxhMUXR
 rJbIZZNhLZzWJtm8bjnM+RuRotepaoY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4NyBTYWx0ZWRfX25wYmiHAOmka
 DTEwX7sPtoQXJO7rXHhRdOuxHmkWavdhBVD/D4jfTXPAZqo8NdN+173PPBMRyYwWTztu/RLsPh3
 sikMwstU2WfjQLdnGD9/DIHUIncNbPMxTDNVeA/xwmGfzim5gRvI8ZhL4DdyLmxEQ8ujJcZpGLY
 OTI1ydwngcm+6Ve5qZTJAIa5ap8kIuCgJ2AziEfHKfF2GX5HNfDGvnn1pgi7s8d7/5756ZL1O+K
 wHRKYu3Szki1HUFDvisQKk4GaqdnLL9sL6QrnyNqsdJLrlkrrD6o3OzDHOYCAdDNbodLm+NBksj
 6j9Cbjs5yuNyUJYubSaq/mFUNPKSw5BDEcTlquXd99yHr+ekjorsFCBHBZOWpmSpW+Zu7DiRSXg
 ErUgkYM4yBz3nKzitPtNbvtNrMMk+u1LszSLTVrRGhzNO2V61Pg2Q7RJcfoBpMNi8KF0fbZdBeE
 dhGRQ4mH8OnfURLuhEw==
X-Proofpoint-ORIG-GUID: Z8Exf3MENBPDWquzU91pncG5Z6cZN7fW
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a589850 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=_EMmJvYMAAAA:8
 a=EIJ3WXMgmfCyFXXGMWUA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=a_PwQJl-kcHnX1M80qC6:22 a=emCv1hD2LFd8cNRmW21v:22
X-Proofpoint-GUID: Z8Exf3MENBPDWquzU91pncG5Z6cZN7fW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.01 / 15.00];
	BAYES_HAM(-2.91)[99.61%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5869C44D55
X-Spamd-Bar: -
Message-ID-Hash: PJAWCUR7PT3X35Y6TOB4UQLPHQIHEVEE
X-Message-ID-Hash: PJAWCUR7PT3X35Y6TOB4UQLPHQIHEVEE
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PJAWCUR7PT3X35Y6TOB4UQLPHQIHEVEE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez-Ortiz via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

This series makes UFS RPMB work out of the box with an OP-TEE that
implements the standard eMMC RPMB key-derivation flow, without requiring
any fundamental changes on the OP-TEE side.

RPMB provides an authenticated, replay-protected storage area whose
security relies on a secret authentication key. In our setup that key is
never exposed to the kernel: OP-TEE derives it in the secure world from
its hardware-unique key and a device identifier (dev_id) that the RPMB
core hands down. OP-TEE's implementation targets eMMC, where dev_id is
the 16-byte eMMC CID, and both the fixed length and the raw-CID layout
are baked into its key derivation.

Two things stand in the way of reusing that same, unmodified OP-TEE flow
for UFS RPMB:

  1. On a cold boot the very first frame sent to the RPMB well-known LU
     comes back with a power-on UNIT ATTENTION (ASC 0x29), which the SCSI
     core reports rather than retries. RPMB has no earlier guaranteed
     access that could clear the condition first, so RPMB fails on every
     power cycle. Patch 1 asks the SCSI core to retry the power-on UNIT
     ATTENTION on the RPMB WLUN.

  2. The UFS RPMB id is "<device_id>-R<region>", which is variable length
     and longer than 16 bytes. Passing it verbatim would tie the derived
     key to a length OP-TEE does not expect and diverge from the fixed
     eMMC CID ABI. Patch 2 hashes it into a fixed 16-byte dev_id with
     blake2s, keeping the key stable and unique per region while matching
     the eMMC CID layout OP-TEE relies on. The hash algorithm and input
     string are thus part of the key-derivation ABI and must stay stable.

With both patches, UFS RPMB is functional from the first access after a
cold boot and derives keys through the existing eMMC-style OP-TEE flow,
(requires minimal OP-TEE changes pending on the CID proposal done here).

Tested on IQ-9075 with Open Firmware [1], pending OP-TEE changes
[1]https://ldts.github.io/qcom-buildroot

v1:
  * ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN:
     - fix using uses SCMD_FAILURE_ASC_ANY to retry any Unit Attention
     - fix unused variable
  * ufs: rpmb: use a fixed-length RPMB dev_id
     - fix selecting a non-existent Kconfig symbol

Jorge Ramirez-Ortiz (2):
  ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
  ufs: rpmb: use a fixed-length RPMB dev_id

 drivers/ufs/core/ufs-rpmb.c | 39 ++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

-- 
2.54.0

