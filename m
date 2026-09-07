Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125BDC79F89
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:29:17 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1CD8A45078
	for <op-tee@archiver.kernel.org>; Mon,  7 Sep 2026 09:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788773357;
	bh=/641rSFJqk+A2coyP6IDIBjMXKeOeOTWdP93+c2wrZ0=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=HeMAmT80CBtuSJmQEEsKt6ptYueQxpWj0L1UUD7PXrc/yWFgkSjbMj74QcYsSvCiA
	 K3ASwsKIBpkcFOYcwONMgcT4VB1CfNEIP8qPwt11jS7oVeulEssFQc9LFKCzEcaafN
	 O/9cUp4/CUA6US3Ar56eMfGkQ7Tyy7YyDr7q+x7VINEt6tkImtuDHC+jxz8BvvYiNs
	 q/X2Y8sI4TsnpVEoH/nZMR8QPxY0H+cMdq16fDxD67X2+HT1/nMEhPV6Id+nrLGn98
	 WHvDzw/wblOlnjC88GMPl4ljL0ygOTrwGs0WEO+6/HJPkSMHNjngwrV8v1UEW8epY0
	 ZoPRyL4WrxiRQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 825C54370D
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Sep 2026 09:29:10 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mO5KZGKu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HFpFL44b;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777X402724151
	for <op-tee@lists.trustedfirmware.org>; Mon, 7 Sep 2026 09:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=N+eqVYkWN7iBc+S8+D+lXg
	SWPZNjoTpe9sgjlidsNzI=; b=mO5KZGKu4bI3zscoPDDBbtjQBVNeNV4edRELmb
	LNDSRNUC+9H2x/PQbRAGl+40PqGYwovB1dcdac7oSrq4EASUCdWVz18TFJ7L9x6r
	+qN4LPTOTkEuPQUEKWOfyzoDPD0/yBn8MzFDMUbXtOVPfgYPZxeUGTtHlyWAntf6
	4AF/kMI1YPSDIwVL205+0jOaVK5IIwjvDYxcZbev0L1KIK6/+q9rjJo645OCDUJp
	ZN/TcN3o5k11I5KaeByvMAxPnwTDpiJctJtGRD2GljWqzXSBErYorTachRj+cnQQ
	q02Kwp/e3DmBXKwFkyqDZauZjsew6koIpdh7dbQvfw0Skc5Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfxkt0ja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 09:29:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39b6416441eso1826324a91.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Sep 2026 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788773349; x=1789378149; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N+eqVYkWN7iBc+S8+D+lXgSWPZNjoTpe9sgjlidsNzI=;
        b=HFpFL44bmk2/Y4UgAAd2SWJIB/iwJ29Yo6sUHeka2siXrZUlaw9AMmVUWU2QBqbCx8
         h7r2iUq6VVSUw7YSPs4stxudgp6Uxixiw4v1v9OdxSbduVrh6r5x7gW9NSI32vbUrxMZ
         vIVIXdpL9rP38ARBeB6Wkfi+QYhLYkL1NSCu3/VULfG6U0/GCOX2E6e+YURrjkDHzOee
         BR/Hh7oftctA0UeLWWubTawMY9io2oTsZIZgV2cvAtUmoOWMmZnFLp5koi3RRPgnNsEN
         F+f2b3E9HmOmrEogspSacGfWilcKylGhn7axTY4JFx5BhlGV3GeWScEDAqtv7GGlQ5KN
         C3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773349; x=1789378149;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N+eqVYkWN7iBc+S8+D+lXgSWPZNjoTpe9sgjlidsNzI=;
        b=FWKlmEA+0+luaVNLcS43wPhKRyJTGIaI1uQVEz9TVsKvcwQfdKAtB3XV78u52WFQ+K
         /76QghnAtOS77Yy+1I8UV7oYg74/uS7LmugZjj56VPTVBX2RHatY4yjq7xS/Gj16pBKp
         jpa8IvAvyas7Nr2Eh+jSquTxsjKIDsJqJG7Xne8M1DmejYKd//Nddi+rzyiSjQdH2zng
         1Li9tIi/W6fe6S931AGHgOkW0cfCSEeaLiv7SNpndCACeRU6tJddVR8yjkOJPY5axKzI
         WHBrAq4wzbISXZ3mY5cG4yPn0SRB/j/ynuTjgXQhIg68pThw/qkQNXw784UxaXpBYwZn
         MkXw==
X-Forwarded-Encrypted: i=1; AKwUvByGaeISh9iVHWc2IMNK5Q5lYzuSgumFXdDgZoYBTQh75uNcIeX9ODQnFRmthcf/MMKB4iE0Xqg=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mQalW+xsSVqt3ZuJ4KUzqSSXYwzopETuOZt+uW5MpogBnq8Fos
	blfHN51ITi+maxS9IaMCZzAYTgeIxxHYy+VhMEpXgavXINruMabemZGdKYvHO6Mhu4M5wkvMv34
	1EtrrjDq1T1Ara9PO6num1nrLNOjfAaEX0+zuJezhMjWZ1BHEu5pOIHLWb7sf/2itgYWHFnAy
X-Gm-Gg: AYBFou1DNI5bcfCIyJtjB3aV4dHe65l35Y2UpN7HYV28bf9l/of225xVhiqzg9qoluw
	MP5w2y/uoAyMoGTZAjJJoxUUdwcGGJ0nHmfc4UItDbDwahahcXdNefLWQWFtlrU1gC8NKIXVm8w
	edAmCAionarHzm/4uhR50sAfrv3SRagRUU1qTexqnuPLjKINhlNzrBnXkLRVM64pY+0Gu5uOoD4
	hFUOCJIo6vKDmykORIBqbjWKB3nR2DWQ3BraFVdWvsZWPZ9FXhWgcmfgIhJJ3gDaxsc4qC5O5DD
	HlI7pk64m72/7uoIowCRVwn1YWWEiVqqEbx45t7HLqy295NHqq2YeJ2CQRizWwx0DvjZXONFtYB
	YjhEYP6e0mAZHe5aym1zsYpVfoDN19iphVQ==
X-Received: by 2002:a17:90a:e7cb:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39b2624a3famr31843224a91.17.1788773348799;
        Mon, 07 Sep 2026 02:29:08 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cb:b0:398:9bd4:d12 with SMTP id 98e67ed59e1d1-39b2624a3famr31843165a91.17.1788773348325;
        Mon, 07 Sep 2026 02:29:08 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338778fb926sm1627830eec.31.2026.09.07.02.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:29:07 -0700 (PDT)
Subject: [PATCH v2 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Mon, 07 Sep 2026 14:58:40 +0530
Message-Id: <20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMmDnmoC/3WQSW7DMAxFr2JoXQWaIg+r3KMIDA1UoqKObUkWW
 gS+e2WlQFfdkPgg+R/JJ4oQPEQ0NE8UIPvo50cR7K1B5q4eN8DeFo0YYZJ0nOK0TONq5mm0wWc
 I2DJqWkag5ZqhMrUEcP6rOr5fXzpu+gNMOmx+OwKsW0GlV9sfqYAPjiAdroyteEUwalnGyd+CS
 lDZCQBT3sneijMQKoZc0VpFwKU8+TQ0joPknNjWgWCaEaEcOStmtZGd5m0PRFlaEjqWvPuY5vB
 dv5Bp3enfgzPFBEtHpVOyZ8Kpyxzjad3U54E+lYCu+77/AOPQhoFaAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfX5nwyDC4DxYCS
 KxDiJO9wJjTOR6RdTuA8FadBU4RZQ7TEdhVTxtMECeBEAlszcMJhbXZPcKK9S/6s6ptz07oQR14
 tHIpyuK0PxKunKYDMiLpSGjV0XJgLg/NEAc86JEfbh2kNG31jeUzYJlm+oDifTra+S5IXHw+OgT
 C7IwqTilp9zoNWCpUZxQz77L5f6ooIJyvThAqUOrUak8AZ7nkRTfBPDPFAGIsSy5gmny42qUZmK
 eAiW3KBYLcSnbW5vHTf/1KJlIdfAoga+boU6zmx0E1VbpC2+WDIEiuDxK/lpVpyrCDtbNKzgstc
 xocBBkTynb+KZCNLRbJutFdvfOgR9eE/dCPDo6srgPKSfpcCjGAjTy6SO0GAxxUu3aZ4pcYlBWC
 +KC0n0Rt8A9nEurlfS9X7vaqfFfZf02V3pkeEtgZqzltKr9EmIobUF66q9oQ9RBt3EMO64UheEs
 x2IAscgtICDjivMkBpw==
X-Proofpoint-GUID: C2Y-rHjsoGWR8m0HQ_t6vs6ukM74SZPM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEwMyBTYWx0ZWRfXxm++Ch9l8YmV
 0el463SPD8sOc6vjqWEcisF4nsEqAZcph7c4S9esnwG2hHJxJH2YI2KXuwz0cLI3g0O1D+ISYeK
 sIuIrbFRpChDeHjlQ9Z67wD4toNs/x8=
X-Authority-Analysis: v=2.4 cv=daOwG3Xe c=1 sm=1 tr=0 ts=6a9e83e5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=-uCDDUUr1LpqqybkBuUA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-ORIG-GUID: C2Y-rHjsoGWR8m0HQ_t6vs6ukM74SZPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070103
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.216.69:received,205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 825C54370D
X-Spamd-Bar: ---
Message-ID-Hash: BGOGTHGQN47W46F6K533E22FT4D4ZTMP
X-Message-ID-Hash: BGOGTHGQN47W46F6K533E22FT4D4ZTMP
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BGOGTHGQN47W46F6K533E22FT4D4ZTMP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
a non-secure SPI channel from the kernel. Arm's Base Boot Security
Requirements (BBSR) v1.4 require that access to go through TrustZone
instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
Execution Environment (QTEE), which talks to the dTPM (or implements an
fTPM) on the kernel's behalf.

This series adds a kernel driver for that TA, built on the QCOMTEE
object-IPC transport (drivers/tee/qcomtee/) already used to reach other
QTEE services.

This patch series functionally depends on below(patch 5/6 specifically)
for qtee service discovery.
- https://lore.kernel.org/lkml/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v2:
- Use QCOMTEE_TPM_UID as 81 for service discovery in patch 1.
- Use FIELD_GET, zero initialised array and log improvement (Konrad)
- Improve commit title and other fixes (Jarkko)
- Split MAINTAINERS entry as separate patch.
- Link to v1: https://patch.msgid.link/20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com

To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>
To: Sumit Garg <sumit.garg@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: op-tee@lists.trustedfirmware.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org

---
Kuldeep Singh (3):
      tee: qcomtee: Register qcom.tz.tpm service for discovery
      tpm: Introduce Qualcomm TPM driver
      MAINTAINERS: Add Qualcomm TPM driver entry

 MAINTAINERS                       |   7 +
 drivers/char/tpm/Kconfig          |   9 +
 drivers/char/tpm/Makefile         |   1 +
 drivers/char/tpm/tpm_qcom.c       | 354 ++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_qcom.h       |  83 +++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 7 files changed, 459 insertions(+), 1 deletion(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v2
prerequisite-patch-id: 4dc81445c9baf36f420da8c2e2bed96e71b31a5b
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: c5df2b3696520a96f95b2d3535ed84cdc21cc315
prerequisite-patch-id: bbdd5327c15aeaa99ce9b74bab324a98f084ed48
prerequisite-patch-id: 07d9c4e9fe9fd61f60e3f35b30b9d81716f0734c
prerequisite-patch-id: 10ff88d87586f21f3cff3f72dbd21c27adbfbbcc

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

