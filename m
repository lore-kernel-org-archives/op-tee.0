Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88357C5DF89
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 15:06:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BBDA6452FB
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 15:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787324788;
	bh=o9PmtGNo0qNXdPm0HGpn7DO2Zfl3uf/bbHX4J5/hCjA=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=0Uf6cQ4B4Cz1iA4DyTdo1FKMqtivtJ6TnWrgLp4az6yAgiZlbld2JnFd4oqAhFYgW
	 yqF97bI1TBXA7WDN5Kwd1w7aHjII3zZfRILf6CbOEQgLkNuYAXEXaKeSwrn1oP17QJ
	 OQ4QVl3h9bPmU402YBe9EWXFUjn1ypcQq8kh7EnjHTpgg3w1zQhH+LG8t096YtUEsS
	 a48Oao2i8fC3MdSFtdubSORrQ7Q6bvt1mG2etZhP/pn74EeAFXV5+AQ64Iz2ZXFoIP
	 RFBlqilXZ+dTlQYljAphrRbMGSfJ8MucosWG9HxhoOAJ5UA+Yui6CnoOV/kTxrv+x7
	 zo8vlNPGp4Dxg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3CF76443F9
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YuKsds6F;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GfRDuImW;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCoawe3489863
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oFgHmRTuTjnvlChpCBQ5L6XCxlZ9swlsOSY
	SEBybm+o=; b=YuKsds6FFQiGGZ6z5J9KXm7pW+Kx8G0dIBP/3SFrwfiKndRGfTI
	VRwcGZNp4Px/vsSnrCwZgZGSmwcroPyEXR9P5Dzrbh30CIEy+kBCsdcw7H4RJY//
	AtFr6Sy1y6/TXOoP/psiV6qCFYXJkF1trouc9lf1o0Vay8WsaL8dcD3L02xUJMSE
	B5vn7ZwqkcK3q733KscKt7tIGSiMtPu+AWef5PCsNW4dl1wdyd5z/jWQ5EQ1ctXw
	OVSeHBzqRxTL82IZEc6lYD+1u6ayDeq8cNgUlIqnffSV88EVOBovwgbNu2oQ+z2a
	Bnde0HKNeTi1d7unr+HIbM209RvD8yDXtfQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fg9ta61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-91931144870so131478585a.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 08:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787324780; x=1787929580; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFgHmRTuTjnvlChpCBQ5L6XCxlZ9swlsOSYSEBybm+o=;
        b=GfRDuImWQmvVPpq240ciZD7dlTyO3KdNOygaEUY+Q4LwuBBNc9MuZLlVUiuGg9J/mO
         siBItNOh2zMMfPPB7zSk/9Iw0EMpx03Ci0HPofG3X0cLZaeARg7QxR8AMzxpipHBLDzM
         mB7e6uGBh+UsjYIQVl18QuB/A7nnF1RU/dZGdk23W4zGdM8xAZ7sixSEUkWGaRuzG/WN
         dSTJTBzc5xJnNYMN9NhJ1rl5axAhjmO/4j7ZMRl7PUKZvrdHS/tWkGKzxvQ7gC5yi1OK
         zhs0x8Y7AM/QPX3q2H03RJuRn3clfayEZxvs8QBJ0QkgzjhzD/093jxX2yu+iQLhoa6E
         Jd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324780; x=1787929580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFgHmRTuTjnvlChpCBQ5L6XCxlZ9swlsOSYSEBybm+o=;
        b=St5sHHe+MyJBu8BtO4chdyV/SOpOVvNJijMozK+vbLW3jmzy9bWXSFnnBVZJ8s0jQk
         /xbtkO9kNENTIuunJMYMiH3eLq8ZJUzuwNUcZklvuObUaMfb80IkqX+8IrNaM10gKLOe
         fxl8Sq3Yn+1Gchm+F7/weEuJdlErmfyiQyoRFu5D3WIRQgtV6nQXQALNbs/bOJmNw2+Y
         2e6oHOHrxNea4WssXSll1MlnaRTIs7o8MxHN1nIivjmJwWdy7MUW1cZe8OD/1dpYIEli
         EaHFPYpITVyHwyqc8RrnUVe4tGPbG6FxUmkEzm3Dp3OC39uvC8pQ+xYmHpSjoOh+JhJk
         BnqA==
X-Forwarded-Encrypted: i=1; AHgh+Roe6FdVeZgtbkziMeAKyV5vbu5x8fFPrjhzikMKtmMfvzn7yiYcXakDQ2TBpFoGDYJb/9h2tC8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw2r6ZoTWVt8pzKNLWYj+Wo1Rme73wgqPY0++43h8DEq2o7m5MA
	c/QE+2iO7wAZDDBPuSLWtw2p7o1e95jMfdEYilRdTxmx9QcULu+0g9CQ1+RedQ08e0tZ7vQ7x7x
	65IZHRhRfTnmU0HBgKn4MjH4yV1RjVvztwuoVZtaWooq//FKmsWC0UTjnMGFo6ROqSNwovinZ
X-Gm-Gg: AR+sD12Cyn+Z+xtikMkty0n23/nj1kLzBTI/Pjqt+aGXMLc2tWBTC7BtHp2EufmkEmm
	NuZHGO/SKk0G0zclxI7hxLeGQMt+CMv3PNZRnN1xi183rAN52Xj7MRMOcgtgOovwMSQTv3hl+ug
	m1OlbCfWB/r+FDlQJUSHnWg63BrJ+ecUYitlxNROJ3VESekto9SIOQD74GUCU3klKl4wUE0w2rf
	HecatCThBOMKsbDg8kL0BXKwQ7CEdmJ2zjgZ18f1yApd1qEj9w4e0kHaf9ShppDJdZIf6dHG9qV
	SVh4tTTxcpBEwTp3c/qidmGuRLZ0UREZES0F/4w72YhP5u32otwyMnBLRwCEd10apvNY6IybQzG
	XaVPMHVseHGUiWUvDegzp6s6WqKa/1PgM+Zw+pdTz8AD2ZJqMRfU=
X-Received: by 2002:a05:620a:4398:b0:936:e196:894b with SMTP id af79cd13be357-93739559d73mr603750385a.31.1787324779623;
        Fri, 21 Aug 2026 08:06:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4398:b0:936:e196:894b with SMTP id af79cd13be357-93739559d73mr603740485a.31.1787324779132;
        Fri, 21 Aug 2026 08:06:19 -0700 (PDT)
Received: from trex (137.red-79-144-199.dynamicip.rima-tde.net. [79.144.199.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8050sm17960936f8f.19.2026.08.21.08.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:06:17 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, beanhuo@micron.com,
        beanhuo@iokpp.de, can.guo@oss.qualcomm.com
Subject: [PATCH v3 0/2] ufs: rpmb: make RPMB usable with OP-TEE key derivation
Date: Fri, 21 Aug 2026 17:06:06 +0200
Message-ID: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX6ePnC0SaDwu1
 3eDWgUopVb9wK9SxO9C4WIdjzRwPPBQyMeKm0w3iZtVGIP7MlhwDZz458QOMt/z7buOhfOAB4NU
 j0pl4U2PRGlupkR9erX2O6NPahhHQ1abC7oNP19meBrP7ZT1SbodMeBL+LyAG69nxJhUBep1439
 mT/zbXHt3h6FE1Cweac/lNOOHP/XUxg7MVcn/gjO4Gf50rM2eUBfNoWCOaHZ+6h17Ubr5FesUof
 t8ra5U+sqqFpTVfqcHGWwaKAwqagJo2IJf0H5OosMkyo9X/4CD2EjSbgF9vRZVqr8TyM2kw4BoN
 lNgZA7ayNthkIJ4gVVEZ3A1zS1TUFeMTQN8dlNNHsQHkzG+XqRY7B+H5FuviKhSAh6uPDAIJnwm
 L531ok2cSZFdCufuO7CaTj7G+BqOiYf9mI1hwzsbIv2iFuyeEmKfKzkSXqrzT7rwyfvvFVBcPcR
 f42V3y0E9ESBmtU5jKw==
X-Proofpoint-ORIG-GUID: l3iKtCUmFxfj7aWY7pnMHCD4uPYb7ynd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfXzagtQhDkmpfR
 ysu+2c1F7QUuomqFGikMrAHW3ExSTYqJjVVsB0kpBuVLW/Fa0tWtMl06uXyN0mZ68GQ6QJ9z0qX
 u0AChO4sd+4QhDyqADtyQlCh25q33ck=
X-Authority-Analysis: v=2.4 cv=Av/eGu9P c=1 sm=1 tr=0 ts=6a88696c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=qBhfTSQT0jQfJ5OHMlDVQg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=_EMmJvYMAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=wgeUl87hhcvhY68aDoIA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=emCv1hD2LFd8cNRmW21v:22
X-Proofpoint-GUID: l3iKtCUmFxfj7aWY7pnMHCD4uPYb7ynd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.09 / 15.00];
	BAYES_HAM(-2.99)[99.97%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.199:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3CF76443F9
X-Spamd-Bar: -
Message-ID-Hash: RZL4L4OSJ4ZVONPZJZHD3NEG6XUN5YV4
X-Message-ID-Hash: RZL4L4OSJ4ZVONPZJZHD3NEG6XUN5YV4
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RZL4L4OSJ4ZVONPZJZHD3NEG6XUN5YV4/>
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

