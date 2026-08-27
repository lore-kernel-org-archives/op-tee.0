Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9A9C61DC2
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 07:04:01 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BB73944F68
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 07:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787814240;
	bh=YU+dpOx506Gyv3qnb05But5K7iNWhb4zHsEv2N0EA9A=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=WRoqa1LIc40v1E3k3tJvpQ02tCAvl9wIvPsHeBMsElAJRoEMhw765VGZvY7rTHCYz
	 L7rPB9oUzGBULlKt1n8nuiCOXcPGJssx94nkpF+2JofnV+ubl6ibr4D8weLlFntJ97
	 qqJGhb2UgVkXKD+za3JOjuLD1ExrtUHO0O2DAt8fbbRINgfLq273dvQnAk0dwGyyNM
	 tYiyCLxD/z4Tw2cKfWhWtFfhq28Sol7QHdBL0ihXnRB5zR2f5rx7nf6jxFoMFctQ95
	 EGpX7mBoMBMxSQFACDzZXnA1mdWZUHPOzR8NUAzQbsOrc5+pFtHBJwJYR/2mmbpAN+
	 SBvSyIgs1KF6g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7528444D4E
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mNdlHq7j;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YIY+3so7;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RJar2620304
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9GHTnyyGYsUI5zmnXqS8PIIxqLj0GNfc1Ae
	++1SY2R0=; b=mNdlHq7japmunS0CjVaRdcv0SSvbfZ+oqyufL/COpsNChuX5usS
	d7MRscPXlwiEFRtVUgNjGFrzzdli3bvw+pETX7CgLVvRMyjkk72IzVC4pMLn4ech
	co6/tO32WUDjp9n9MIdiO0lPArD7fRPG927dWrZcg22LKODaepIVrd9OZYksxweB
	uw5XHO3+IWJ0hq3IuMGiI6IEjwnyCfSvCTjDkQtW3CSzq1spcsB9H5+1GgsFftfl
	WtuzAj1DxU9sqpfcWredb4K4WbS1e8jzvDQhv5FbjwYE2GSXt93BVK3lNjbaUiJa
	5KMqWz76ojcUIGML249ZU2rKJWG4zpuWSfw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03u3q61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d30035dso12981061cf.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787814231; x=1788419031; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9GHTnyyGYsUI5zmnXqS8PIIxqLj0GNfc1Ae++1SY2R0=;
        b=YIY+3so7XjAQeqAu+0490g040198qcnR2bXtR1YNpbGSjDqfnbD+XoEmrf7EvfeIbH
         9J2J2BvyvljTN8/fpAuqE6QNtATH1b/H2KgdPRI0yGpkES4sT947b3CZQBgZJyz2T3vj
         1BFUwQJH82vC+sGaEnxP9eJpLPTcZFG9CbECXSnb6u/n7h/0k93mHbFfFbWQXM9+zOlC
         Hs9Eh+gjDQPprTocfVy+PhtM7igBroD+h1lU9NanOkaI+VYv5qFBFu+38DAL6LhLX1hN
         Mw3kDk/vseD0zpgVq5zRLk6yVbLxP+9eKvvcL/7i5wSS5HZuCyzmoxPhLEPUgFWnt+uQ
         JSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814231; x=1788419031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9GHTnyyGYsUI5zmnXqS8PIIxqLj0GNfc1Ae++1SY2R0=;
        b=Sq9fVXbzovZL4XkYhyZv0LJ8Arj99GI6mqDppd62kIomO+QgLACrv2tIuFaBRpmFp8
         z7JJ8PAMLU4b28FoAeQOBdnYAMMT1gfdzcO5qqV8L6EuTcgcDqu3mE0LcxPMQ07L8WlH
         ENVW1OJ5gTo9+G1AhL8rsX/kWth8pOy1ZiqzPBaU78BfpyZZ3QWNjHsP2yGzpXpTojHU
         fjdGiSVb7ZrPf1h4Vqio2z+hbdd2kA162g+NOpLHqJojQ0U+i4C+Yt45tP6Uip5EOJgC
         y8bB7aDhpZJNk6RQUvzKvIFG/6ydPW91PsW9NwevvxB8V3NAvELymtqWGTOKf0To6rOC
         8P9A==
X-Forwarded-Encrypted: i=1; AHgh+RpH+Ngit845jYraPNBGCUZ0Ig6sSajPvkhq2t9zQX5AT5/foQbX6yND0dLjr55eVbGR7z7QLug=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++m0UTX8ec2I+tD1JvCt+P6fj+1x9gZnaFQIhKptJl/BJs5+cAoW
	qluAX1++eCbkHpFbYWmjOvGPjWhul+Uee9zIBJhghMPNjSvuHlP0WwOchdLtoMPluQJf6obYIQ5
	N3l313RpWC60LSScVmYs0k41IGoax0SmO7PNCHp6TC0Ye33ZdF0XEIZ7W2EHr6aQWn8g4QN3D
X-Gm-Gg: AR+sD1052idt/A3h6ECL/BgTA662onO2mm3mjbCM4mbNd7v3dOfR5OpMbeXypEVvGbp
	StcXjIrcmddrSaiFBB8dFMzFi6Bp2L6jPymymOJ7jEXGGmFJSVKmaXyM0bCBGb/mA8k78NZ/u+K
	5pmZyTnlIMSi7g+bi8JXLMKB3DocyUDYQX9iNO8m9uTA2etmIxiesrDS9tZz26mVuMKqgZHWwCP
	GM+Hx6JoGt/eyheRYI3K8z5GXHmZs3dM1KR2jdVEVA8d3KrJretLIoFpqDcgSBOvLzDJA8im+Hg
	wjeFML6izNFQEUp7kddESKBZtw1CEN0S3kGUxG/QEc8xMoRo1ubDpkHi0eQn9w4XKW+47HkD/Ua
	H7uRyKimOFUbzFk4S01qrQaDefTZnkWLoD+jbZhATRWYGiQPg/w==
X-Received: by 2002:a05:622a:6106:b0:528:3b9d:2c7a with SMTP id d75a77b69052e-52e4234d653mr131401431cf.21.1787814230837;
        Thu, 27 Aug 2026 00:03:50 -0700 (PDT)
X-Received: by 2002:a05:622a:6106:b0:528:3b9d:2c7a with SMTP id d75a77b69052e-52e4234d653mr131400901cf.21.1787814230265;
        Thu, 27 Aug 2026 00:03:50 -0700 (PDT)
Received: from trex (137.red-79-144-199.dynamicip.rima-tde.net. [79.144.199.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b0d263dd5sm28306585e9.1.2026.08.27.00.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:03:49 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, beanhuo@iokpp.de,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        beanhuo@micron.com, can.guo@oss.qualcomm.com,
        sumit.garg@oss.qualcomm.com, jenswi@kernel.org
Subject: [PATCH v4 0/2] ufs: rpmb: make RPMB usable with OP-TEE key derivation
Date: Thu, 27 Aug 2026 09:03:34 +0200
Message-ID: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfX6uVjFZT8HHr+
 hSdl4BIViu4y3hhMB3MqDNnQgCBIk+oFi/crVoqu69cXay5jlHwluz4BhNnZxkNcFftiuVsYN9P
 wLYu7LtGv3za6t7GBI/MyCS5oiA4tGrN0CTXttrlRxXMcNmka3zRrsU9syMRfrGvHaye47jBqq3
 wa+YrhaR2qekPAXrlShH11qAL9TXm7ZZ54pJpZtyoLgRnTBlMFcBAXMJ573gNbyS5j4ww1lun75
 roWEDwsZG5kt1/d6BOuAY/sedTVuM0Jti/5vaKHZ9175BEnDFKY0ohpMAp7LR1RZONIFSP3Y/vX
 F9p4gqMzc+424pvDQ1D5HzGS4WB8f3BLi1AHOrqMwCfvX/o1RqVW5EOWsJWCDvmg6ygYTSSYkYT
 DoFXzaLyvFu6LP7VzFsi/sbuBg2cy4I0vEHhKklatrLUpk8SOwG3YTAI73dZtdeNbjs1sFE9YcW
 1kjhJulpljQSGyRUTQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfXxNxQg0RTg3mX
 Joev22KiCe5JoFxeV7YQTp4+TsaIKjUbog9OrbN2yeHMTzuKsqZfCUCx4AmdAe9OOgZc6y6WUVQ
 wbjRPlO1W1A/v8LGnK+e3WA3AemIPyo=
X-Proofpoint-ORIG-GUID: tD0-url5hSgo3oZdQr3m8FD0VN3OUcYX
X-Authority-Analysis: v=2.4 cv=RcqgzVtv c=1 sm=1 tr=0 ts=6a8fe158 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qBhfTSQT0jQfJ5OHMlDVQg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=_EMmJvYMAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=wgeUl87hhcvhY68aDoIA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=kacYvNCVWA4VmyqE58fU:22
 a=emCv1hD2LFd8cNRmW21v:22
X-Proofpoint-GUID: tD0-url5hSgo3oZdQr3m8FD0VN3OUcYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.09 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7528444D4E
X-Spamd-Bar: ---
Message-ID-Hash: BBXWO2LOXUMF2XYBYWGYY2OOGQXQLWZK
X-Message-ID-Hash: BBXWO2LOXUMF2XYBYWGYY2OOGQXQLWZK
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BBXWO2LOXUMF2XYBYWGYY2OOGQXQLWZK/>
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
     blake2b, keeping the key stable and unique per region while matching
     the eMMC CID layout OP-TEE relies on. The hash algorithm and input
     string are thus part of the key-derivation ABI and must stay stable.

With both patches, UFS RPMB is functional from the first access after a
cold boot and derives keys through the existing eMMC-style OP-TEE flow,
(requires minimal OP-TEE changes pending on the CID proposal done here).

Tested on IQ-9075 with Open Firmware [1], pending OP-TEE changes
[1]https://ldts.github.io/qcom-buildroot

Dependencies:

U-boot:
https://lore.kernel.org/u-boot/20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com/T/#mc423eb4dcf8a15849077029e4f7c1913bb7d8873

OP-TEE:
https://github.com/OP-TEE/optee_os/pull/7881

v4:
  * ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN: open-code
    the power-on ASC 0x29 (with a naming comment) as the rest of the SCSI
    tree does, instead of a UFS_RPMB_ASC_POWER_ON define; add a
    UFS_RPMB_UA_RETRIES define for the retry count; reworded the commit
    message.
  * ufs: rpmb: use a fixed-length RPMB dev_id: reworded the commit
    message; no functional change.

v3:
  * ufs: rpmb: use a fixed-length RPMB dev_id: hash into a stack buffer
    instead of a kzalloc'd one; rpmb_dev_register() copies dev_id, so the
    heap allocation and its cleanup were unnecessary.

v2:
  * ufs: rpmb: replace blake2s with blake2b so that the same support
    can be added to u-boot (CRYPTO_LIB_BLAKE2B)
  * added links to U-boot and OP-TEE changes.

v1:
  * ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN:
     - fix using uses SCMD_FAILURE_ASC_ANY to retry any Unit Attention
     - fix unused variable
  * ufs: rpmb: use a fixed-length RPMB dev_id
     - fix selecting a non-existent Kconfig symbol

Jorge Ramirez-Ortiz (2):
  ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
  ufs: rpmb: use a fixed-length RPMB dev_id

 drivers/ufs/Kconfig         |  1 +
 drivers/ufs/core/ufs-rpmb.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.54.0

