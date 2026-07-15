Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D66C44501
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 21:43:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CBD9C44F68
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 21:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784151822;
	bh=ydesc48nFZN4QYKxkYYCcJd6lszzjzByE6lV+3I5Mfs=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=mWw4yJCbN0us1pduGDfSrLWy7ttY1rBbNdVp+H+qJIci2CGX+HjfNOPbteeqsga9r
	 nRkhygIBaEUH9QfkDOljgDWzkfETWVd+g6Kou+aT47fw0oab9wvT9+Hhmn1p+4KWkw
	 E3XLJ1iFHOvAhWjS/Mfgxsbr6v4ZhQ7GcJMR4ImFGXRn/mNyWr1spBP5HlyxdCT1Hd
	 xZFTUy7bN5o9paSHQE5r2n2XTg8XDNrS+ouDFgZQ1dynDSyeainpyDxxPRQrVmHdeK
	 SYZlxrk0jRajYXVjJvg+uIeYJTxNhGL/6J++3D/XECiV8td/ahTRsACLJn+kOroiNU
	 F6RCWdQtjU/LA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2ACB944E87
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cQRUIiDj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aONGeZes;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPgoR477279
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kqzd4g9UykK7dMt3kOtTRxoaEwoOgQlKy8d
	2xlJaY6Q=; b=cQRUIiDjPr0f+/aBODRJ7Mbe/mu7SCg7WktgfrWXl2WAl9K8r9p
	aCqBNWBbfOH+dKcXQl2C9dA1EEkWInsPh+ihNSJ9QhsmZ7eHyPp/LDu0xmg4FxR7
	I7ZpCj4278Bbf1SeR1Pke01d659VVAhe0q4ls6gqRiXQuxZowUNQc9SbF7RfF+bG
	72lWdXhXr7etNihawUOlLbdzxPgGO0m5jMyI20IzL+LoeLguC/Q7FAkTR0zH8RAa
	N2XNKAQ3wR0N6oHT7FmYcpExS0OfW3TPE1b+0brqKhc81QhpdWjAnRfmvc5SrLo5
	QjlsPOiihCe5aMPykKpIEDk/1/Roii1ay0A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feehv8vc4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso30419361cf.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 14:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784151813; x=1784756613; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kqzd4g9UykK7dMt3kOtTRxoaEwoOgQlKy8d2xlJaY6Q=;
        b=aONGeZesvvurwpbLrTOSKgDAqxKnTyRQRpV+b9FuPTbkXiuYy3vfN0E05w7kU4eqrK
         UdJ4HnTcV39PCOG8iacT1f8lSQeHAKxM3aDj2CczMj/IB8yZH5Xl5vcnoV+2/WElI/F7
         xk6FVu7yE2tXeWXualVmUfYE5Ag6Pplwf7xFxnyjawjQprKVptyRaCK6WDR6k/W6b3gs
         HSsWVyYjWRq0a5nLx4G/uvaU28rq6iEoMUYb5TqnY+TZuWEwvfHnmlAYJlDGv3EK4Ssy
         aDyNSEFJXbI7djgvZXfqbCu0ncACahpV0QvHyI7djiIVHOyqeTONlDCpeHVz8FOahFKB
         HeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151813; x=1784756613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kqzd4g9UykK7dMt3kOtTRxoaEwoOgQlKy8d2xlJaY6Q=;
        b=CC7F6MaFKbRdkjcpmrZGJ/h8TC/4r6Rc+M5/1oNVOkoWuBi0q8QM8AVDHeBG2v9r2R
         xCA4kQxcrlJJFiqMTKzu37pcoxDcB88Wvdjh8uL/SQUU7PQFgbHs++sto5MPtEQ6ciP+
         PzDDM3QzSHATUoizYO6uuTlbzqoFEb6eUBk25+yK/iDwRuA1kIVcVCAfIgiXPQBGMOeY
         VTTuDsluvpq+n72lWCrHcFcolS8MWAz+aB4rdHn/D6A0HWg1pZaOfA/IyQSqBNQJrVVV
         x3DWDxLZOv/H9rg9mZu+IzA10BGR4mHZ796gFMTobnirD2+2r22QUMPv5F/soEBmPc1Y
         iYQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrShag68r4LOeMsVfzDa/BNc4ZP1YWPjAd5FlcF4tU/k+dat6iVvLNS0ioyJBubMcaufUikqrQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YymQQziA/G0VY98/1mHZb2jP9h6BgO7LKqI4kDvuPEkp8IVyWD/
	PhHHcmE2fSEEm83QFM9XBKZiZSSAwhHAPSDZXJ5wyVqUldFuzmG6VjG9MduEOENIA86aPyEIwpn
	pju2zGmNh7gPUVenVhGmtkOC6hoxvCyndPGX9/Pnwp1tKWX8sToUciA/QF58eZirB0blH6YC+
X-Gm-Gg: AfdE7ckVa9/iKG2iXy9hhJygC4fV3HTi9xDbPs3uYNI8XUtz3t4vGjq+dfXhI7ijmsX
	qAgovmsmT1BOXM4+8qV0jl0geAJE5XmC/oVlz/kieV6GKD9v0QLUdupssSA5rId+YTX1/FSfqmY
	wKgoRkgbE83lrGxGIa1jS911zrfdBeYau/iox7HbVqW6XaZkQ50SWKui/qT6vQ5YGZyU/Eu0phJ
	h2D4sIJ1vyRXWTZ6YZrT8VxLeYLxVpAiKn95wC4ZJf0g9+ZFIKP0HLaenuTu3Q24hSOXpdGKAvg
	SYMkOd9GR2Bpzymp/xgjKr1N+R+pSkw36yM6yWeXfKRleKWtyx6WU3P7pAhFjy5dmeBNiZzKYYj
	zbGzldja+wV/7cKKzGotiEs92KIa8S65wW0OIED/PlCgi3GLR9Dg=
X-Received: by 2002:a05:622a:5a12:b0:51a:8c99:1f14 with SMTP id d75a77b69052e-51cbf27f4femr186098771cf.67.1784151812388;
        Wed, 15 Jul 2026 14:43:32 -0700 (PDT)
X-Received: by 2002:a05:622a:5a12:b0:51a:8c99:1f14 with SMTP id d75a77b69052e-51cbf27f4femr186098411cf.67.1784151811951;
        Wed, 15 Jul 2026 14:43:31 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb7372sm14200775e9.13.2026.07.15.14.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:43:31 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        beanhuo@micron.com, can.guo@oss.qualcomm.com
Subject: ufs: rpmb: make RPMB usable with OP-TEE key derivation
Date: Wed, 15 Jul 2026 23:39:14 +0200
Message-ID: <20260715214327.1933560-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZpDd7d7G c=1 sm=1 tr=0 ts=6a57ff05 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EIJ3WXMgmfCyFXXGMWUA:9
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIxNyBTYWx0ZWRfX+6XlZkbQtkYw
 tc8zzbetQL8uEveC7dt+k5j9vF7eJqa7Y31Q1AINcHG162ZOAn5n+DvLa2lqM4yz7d/zLSvpE5/
 8nGCC8M1rWFizUinKNYqztwsRm9ULytTpGT8v2QMth/6NL7wTYDmjXIK2qGcH2tHrup8d7z1WOM
 ffEORMptnYRGQGdceBzfjzrzklIre+Y67zNQ5vQlCls0WJVMHwy6R87rGxR+O0I1cTpJ0xZo4fD
 BGzVxS0V3iHWWXblY0wI8A3tu2A/hm5tN7Jx34vCaGFb/QnSUzIQvg4H/kVhd12BzzMkSAT2moN
 KpyhOXVSlcZScwY36EMY+Opz7eFGuFZ/dh+5kHrcoQIM6XTWqKAzcWzKwhCHgCvopiohnuy/NWh
 mhLTLJx8ZMjVSjAUllK9S6DuS72ca42SNj2965K2OKIGPxfWA0087PkaRIyAf5E0sMr2wusmDI8
 tkb28Q6PrMQA+N8CjlA==
X-Proofpoint-GUID: 9Tp4sDw6RLo5k8UgRHPLmGmkNqvWliHN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIxNyBTYWx0ZWRfX1kh81MI11NSl
 3H1c4bYf7MjpP1KWucoG+oqcf8Y2CiIijjugNvXv3mLc2+pTkdrbeBvLPiEANwr2oziDCKXi/ov
 M5263PVQBmBpGoQ2h6UEckMJ4tBTQ7A=
X-Proofpoint-ORIG-GUID: 9Tp4sDw6RLo5k8UgRHPLmGmkNqvWliHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.83 / 15.00];
	BAYES_HAM(-2.73)[98.84%];
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.198:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2ACB944E87
X-Spamd-Bar: /
Message-ID-Hash: X7NVCINPD7IC7DV2FAEW22YT4TTGFQEA
X-Message-ID-Hash: X7NVCINPD7IC7DV2FAEW22YT4TTGFQEA
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/X7NVCINPD7IC7DV2FAEW22YT4TTGFQEA/>
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
(requires minimal OP-TEE changes).

Jorge Ramirez-Ortiz (2):
  ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
  ufs: rpmb: use a fixed-length RPMB dev_id

 drivers/ufs/Kconfig         |  1 +
 drivers/ufs/core/ufs-rpmb.c | 41 ++++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)
