Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C784CC6B39
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 75443452B4
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 06:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792046318;
	bh=M0bO5pV7rOWhaoU6+z7kLmEATwugnVvfR+Tk3mM83CU=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=kJA9MvYE+/dYbtb6hXqDNqJzNHoot8CNBRbXX3DbMTgiy6jKKNv7RfjDEqhd3fKgp
	 dmCHs612Z+aVAgUb8HWQbfE8cvxtB9bVq+9FNruqy3YfEAs9vEb7i1VtKO5w/4aZcc
	 Rsx5Xi52vZM7WktHpAF2/+c7qCYIOb6uDG0GkGIYVMERe/0gsjGae8+otw98kG8PLf
	 ceoexcuf3cy5fHj5dnndNuG27uKFSLX7hCSugXJBNqnXGsfD6wFYUZVvUhToXSkt/1
	 iCZkmsfLFKXx/kJ2KgW8/RsxXSCavRM0c/KjE8HXsYud0VNr4oix3LzbKO7NxVRlSs
	 8gG2enlCGwryQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B27D744A25
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=giRqNbQJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PWNuGYpA;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F3xUf31641221
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1gwU0tcX13myESEjxMHLTQ
	2r/QSifosTvZ0kTue5VFs=; b=giRqNbQJYawxS/9sjUldbIgXPHx5WjkeK2pjT9
	EKxIer3TV65dvlPftDAG9DzN8PxjrUWphhzBbPzmJewRC1vCWI4RyNXfC/iwC/4B
	x0UoLVdoxw4K3XZDL0TFTLdPt1Jmsixn23tNNEqZLlceS3LdiU5P4IAS71ZJhlkh
	zV5VuW8b3BWePQdthn7RnOXLsJ5nAPDMVHqkxXoE/s9Vn49xViuMvOAvAWhK7il/
	XzdxEqF1qI4dZ/KStJqIaw+45m+EuQmReGFAeVQccB2xPgfRZTibz3gDL1+WsRyt
	gDif+omN/9CFuZJLqTugqCavNFySaE7L2Ymi3rfx0vLOkNqw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhgjab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so4415597a91.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 14 Oct 2026 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792046297; x=1792651097; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1gwU0tcX13myESEjxMHLTQ2r/QSifosTvZ0kTue5VFs=;
        b=PWNuGYpA23w0CpTBKE4+pw9GAd1iqLpKYMbnygaJ2J0pCoSz+HrrOhnXc16qc7d+9u
         InfxzVa7wRiW+uxW7+HjGMjE+6EnWDqduOsc7KFoTS9GtBdpPyFUXKRWuI99LBJu/24t
         NFvCeyKvaSpJpYLhAK0QeYJGb5U29kwP42yJjB+FrJwADr2ap/68Gja869gYDTct9Zvw
         40nTrdjzJRj0U3UFVv50YbHqGHIKibN8Cufz/q4uktiDLUwRzT/saQ02xfC7jkNqiUQB
         ENd4mmwbeVThTaerbTHWGWSZKvPyRv+hz5xRfW1wRa0ATAdowChnAioGcYZeVZsk7i3u
         MQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046297; x=1792651097;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1gwU0tcX13myESEjxMHLTQ2r/QSifosTvZ0kTue5VFs=;
        b=USAOE3UUAiTKW2i5yxoULfJmttSzRIPK8ZqKIVl60ixgDDqF7U00X9WknE6gUGJKbt
         owm8zmGaIktVw6f1F91VuMTyAzuxhZgM9GpqaeATydUbMldtzSNngtrE1Ln7Gmo/UyJy
         5xZhhIU9pyv0E1+zAyyIGqIicRwZF6zJNtKbaU5D45YzLzKw3EzT/NB4AmY6eXIyjSd1
         0SWESvNiEIsBFRwcb/U+eX1t+7IyxjHojyio7ZIpNFJBrbLRyfHQAqsp2p2IbDej+WMc
         jLQx1vS5O/9XjxVeDRqH2OeYWtPpslXT1xE+Jk9eRJzTF9yy2FJn6nItHqetZB2e+Ank
         XmDA==
X-Forwarded-Encrypted: i=1; AKwUvBzHdjx15IECtpzQkutZzygSZ1RCmf1CESCZpvSxSqx3iEyj3e5CyrDmtXkiG6ZQNx/whS0vJx4=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKuuTCA5OWtSkt583B05r5fG/0CuyHZf7CDvA7HJqIjZ5QK7AZp
	1kvLZCTTzTwPdfkIAUYFn8CM6aSawOzxwFtGlXGGuOiBrsbqosfx6mJFrMSU157lS1JkyUivMKi
	rQWb0cUdYv7DtJQ4owrjLXndfMZ/tR7t4/Fn9HJ9EAUNqM2RhwuDUd6FLs8ler+d08IWGj+S0
X-Gm-Gg: AYBFou1TNMXWhgwU5Oo8qmu2WTe3PazJ8r7lLn8WYrw38FqAUgVAk9W2TDOuRPndWKa
	YITO+OHMwFbalEt0No+UxGY6tXKzmoALKBvYVKxjWLDjFHt/Tti/aF6FfRoXU2s0N6Y92F1hUee
	PadMd+nbtALf4M50TdQEWHsDRjlS/1q5Lmjh5KM0Sgl4nEUd/5e6bNT1gxFVDJre8/6Ms23Ll30
	Vg+V24VaTnV7sjDJpNny4a/GRnL7nK1TImbyq/v44AF/7FJgLZtExKNhJfWaKhmMPvu/vNQOZ5Z
	35PeN3XoXJOxF8/Up7Eboi2LeLQEYpqehHgRDz+1yMMK27sdPFKt3Bf/W/vI1pIdlqfjSIZFU4H
	p8MUhHG5rCxNnSrLAQVl5ooP1DsAeq45U
X-Received: by 2002:a17:90a:d44d:b0:3aa:f4af:1e17 with SMTP id 98e67ed59e1d1-3ab3a9d6d17mr13213367a91.39.1792046296586;
        Wed, 14 Oct 2026 23:38:16 -0700 (PDT)
X-Received: by 2002:a17:90a:d44d:b0:3aa:f4af:1e17 with SMTP id 98e67ed59e1d1-3ab3a9d6d17mr13213353a91.39.1792046296059;
        Wed, 14 Oct 2026 23:38:16 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm2844429a91.0.2026.10.14.23.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:38:15 -0700 (PDT)
Subject: [PATCH v3 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Thu, 15 Oct 2026 12:07:45 +0530
Message-Id: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALt00GoC/3WQwW7DIAyGXyXiPCowBEhOfY9pqkhwWqalSYBEm
 6q++wid1MO2C9Iv7O+zfSMRg8dI2upGAm4++umag3ipSH+x1zNS73ImwEAxIzhN83ha+mk8ueA
 3DNQB7zUw1KIDkrvmgIP/LMTXt0eOa/eOfdoxPxUBlzWr0qPsaWqr4pHM0OJYMytib+f5NPpzs
 AmLOyFSLoxqnKyRcdlucgd3NiLN36NPbeUkb5wyALV2hotB9Z22YFBCJ2rH0A3SOiYM2Ye8+Ji
 m8FWusPEy078Lb5wyqgauBqsakIM9TjEeltV+7OpDfgpygyemYfo3BjJGc6s6rmtw1vyBud/v3
 57Rln+hAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfXyn/Nhw9IrTCL
 Lq4ickubrFADlpGXr8pF2sVP62lNFgtBLME70gqvDpRCLj5M3fEjie7gj29PMaMgTR103R6IzPG
 9tUyypkAFCv5VD+0fC4PfrIl6kBjMM7zWNltTlFis0wxHwtVkUoNMQuV4gn/VmXc17YCiK0tm2t
 +/XWXhDHaIZyYmmTqKEsGpW70UfW+W56hNgfDZwOp96rqypmXC+27ATl2Ub9TAER6fm+Ew7E2Th
 BGlx34DU8ZhkLalYTkqKdhEkyijnb4tWXfxjjjpsahpnvWYs5aDRC69ptAd54bPOtQUDqO7c6Y9
 sftGAIu2NSo5nc66nvY93EsXBb7MFcOEibcoxOASb/2SJ1fEPnNrRYo0G555tYdc2WSNCByEUjE
 yhOHByQAFE0xZ3XW9nv0cNJ9GuJJX3C+lmOdXP+2AdAaEoypT+mtsXTO/ge44JOCMhHJyoVvEIO
 nSqk6i6VDkRQfrYkYoA==
X-Proofpoint-GUID: 0hQuvtJT4oC6LH82D1e6-Sz0atXIyp6k
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad074d9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=xG2GeFPYwsRGK1jMldgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX2KprRd2HtqWI
 qnbe9aFoAd65B6sh6z95pD2FGEVYTdGbCbZ7bb7bUOObvAu26IKqCwfq5gSEe2lnYYm5kT3c9IE
 XZoJ4EkRCtOt0Jk6TinzIZPcVWEYfRU=
X-Proofpoint-ORIG-GUID: 0hQuvtJT4oC6LH82D1e6-Sz0atXIyp6k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B27D744A25
X-Spamd-Bar: ------
Message-ID-Hash: CTZLFUNOI4NVAF4IEDAAS5S76KCH54WT
X-Message-ID-Hash: CTZLFUNOI4NVAF4IEDAAS5S76KCH54WT
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CTZLFUNOI4NVAF4IEDAAS5S76KCH54WT/>
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

This patch series functionally depends on below(first 5 changes specially)
for qtee service discovery.
- https://lore.kernel.org/lkml/20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v3:
- Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
- Update return values of functions and drop certain error prints.
- Define locality_arg as default value.
- Add Jarrko's tag on all but drop from 2/3 as significant changes done.
- Link to v2: https://patch.msgid.link/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com

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

 MAINTAINERS                       |   6 +
 drivers/char/tpm/Kconfig          |   9 +
 drivers/char/tpm/Makefile         |   1 +
 drivers/char/tpm/tpm_qcom.c       | 413 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 6 files changed, 434 insertions(+), 1 deletion(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v4
prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: aef7dba7d7662f87cb06bbf5cabca93304843f02
prerequisite-patch-id: bbdd5327c15aeaa99ce9b74bab324a98f084ed48
prerequisite-patch-id: 6263a8a3b40df5cce7fbe4b119f4b9d67a4c06b4
prerequisite-patch-id: 0c1a650a54014eb20f7ab9ec20038b49e42680e1
prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda

Best regards,
--  
Kuldeep Singh <kuldsing@qti.qualcomm.com>

