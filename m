Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CE7CCF2D6
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:22:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 51BE34530B
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792401756;
	bh=sZfaHMM3n5qSlA534Y36U/L686G77F0urff/+V3Q0fA=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=AFeNjiZWPMzw8V3lyg7vy+YKijUenAlJ77LVMqvPCLFolXe3csXlsaTCtTKm6uo7n
	 NaEkCVNjsoL1EPMoZJ4hDuVy6D7cqUbQOGDeoRaa9teQDA2lGNvuFF6md23rhOThVr
	 LmROTyIGM0puHy/2G7EN++r6YVdOdcSiCgxOahoMDq2WHo9WawUH1/Ngfk98tcpew5
	 3qweAb9NbZLrWcH3FE4K41JfLIoGZN+Tkw6gY0Mr6vaVDE1sSYnPB4tXMUmQUZ34FQ
	 lZ1V9b4NSbTBnDMhZIjut+zSRdsMR01/rX6jFJv6sr29Ezda4iEcxIFv+DbrsBKe/y
	 dHKJzszRvnNEg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 15D9444A8C
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WN1XRgXR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZwadHrq7;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8P7kt1896620
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6Dvi7s/V+FGzGTPgCS3Pqm
	rFxqHvRCvEqGteKv+AEng=; b=WN1XRgXR+1Zrz1gF1B+0zHkKHb7cbWLXtdiXCy
	wQvR383uO5sTAdbmMHwL7fEzs9HWsaob1vmtsH36L/Ncjof4URqknsMyb5jqT22q
	zciX/HSpeiIi3S6lM9AQXJhfovcbcDzhNffa2cWs0PM5hYYDx0QyKm2jp3hiKFMO
	ey2ma+nTi7+vfd8TmvuyxwXEJsagsMum8ksOnSUy3ml9BLN9H5mFsNp0HMGTFu0N
	/cs4U5xXLqQ26uFcEEuZKfw7jJBL+ln29QUZ1GTXNcc+7ZvzBtbJ2P77fgK5Yxl9
	JiSMS/k8aRZU16IT6aFAn1ZKSQY80qHS9Vr4B7jb8yAScSxA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr95nh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:16 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35c3c370b17so4054305eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401735; x=1793006535; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6Dvi7s/V+FGzGTPgCS3PqmrFxqHvRCvEqGteKv+AEng=;
        b=ZwadHrq7mMazYbeMWIeZofZ0u+UZCl2ncRSXxeFkd8uj0OROmI5UV/j7xxxiO42Rja
         y9KXWYzITOHoBYRm2Nw/UOJUTZxGTjbb2df9GrZvBn8figTSCBC27EV99pKKYk3rJoS0
         k7AsRJ/LclIGljlLQQyMXKS7p+aBOYql+1iimsxoBXzDAoilr1pqTAED6BlJBhYvdHlI
         P9GOIOb2eADErMW2GYfQvHerLUB34Kqd/FuPqr+jfjBdMPIuCz3+K114lfVgA+j4GGRZ
         l5IxH3iyHnVHRziI1oqi9bu9sH4zA/I0xNGZ4IN29jlpRzqk0JNhcyfvSdiWOW/BwEsx
         xuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401735; x=1793006535;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Dvi7s/V+FGzGTPgCS3PqmrFxqHvRCvEqGteKv+AEng=;
        b=H+epSW7YHbpzJXOK/Vl7IX3i05I70lrdqtp4CHr6F9itkiVoMEorpy7sTbVbWepnnW
         RM9Bw1Pma0Bcr43yyHVeLmjv+VwdU0igwJMhBcQ2y2TYiaDt7istJymkNJdLEN/7fDwl
         lqUKtUqBxuQFAlSuS9HcJzyKPBzmejwuOGaVbR2HlpigRUchIEtaBK2Zi+SPIvvBIgvh
         ijI4tjy+ZEF0l9bJIuOKwGiCEP9wIfzjQsefDAdqspNIsGpGaJSKCwYy2D9y5ql0DLBh
         vi2i9Jx/QqCPaIfWyb9s6XUo2s2kSX0gX4ojUPhT3QghFaRWqtCFFtlCwuUOGNBVDcKu
         bhBw==
X-Forwarded-Encrypted: i=1; AKwUvBwssZQLxraevY4PFbaAh7i7Op1e5NcPJNqRUnvoG5ye3rL3t8fn0t6vQJuKpfbNAQJEGjLoJMA=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYId7xsoiTUA17l2cHeehlwMi3wNIbYz90EZE5IVyfoHXr61p0M+
	OMFUW6HfwgZAC1KGb1kk4CFnesBa0qjp8pTE8CWhetkCfDdbw0iiBs6XWyu8gQISx4KKtNfO4Vl
	9EdbLXFLdMtfLjD/QmkrxFklmIMFbUIbV2dOPq13nlPBBfwRTb+psM57w7s1zDdjmJn/WE39+
X-Gm-Gg: AYBFou0pEvJAmutnFxom01KdFIG8A81ZF/jWoKeLAdh8z4957OFCQyiK7lae8bQsnfq
	bkwFIejZi9rTmmmud+ddz+MDK0apnEBtLEM/BHKKklXMetw0D/KB9pzpN/o/N6ogJiF8S0V1vmo
	4/1s5mbwAoHRC1057CtD6gAtwODRe/PipgQ8IMlOyJpUiPBpepXdmayLBrhC47NbXXU7HAEekGG
	08T4IiITNLAThpVGLbUrhaFv7XmXpUgjsdG0oY8cSgecVDk0hVxihZ+QgTbAmyZhmQ3eIrV3u7l
	VJXcuN0d3VjXrFKMemqrvbgjW1CKO+Tk+jJZHI7YR7TrfFh7oZ9brG6LoBDmWtct1SjNb3B+RjL
	NEmqJaU43Xt9g5JBwOIF5U+xaWtQsept/
X-Received: by 2002:a05:693c:6311:b0:360:73dc:1e13 with SMTP id 5a478bee46e88-361a196004cmr11484959eec.17.1792401735215;
        Mon, 19 Oct 2026 02:22:15 -0700 (PDT)
X-Received: by 2002:a05:693c:6311:b0:360:73dc:1e13 with SMTP id 5a478bee46e88-361a196004cmr11484921eec.17.1792401734445;
        Mon, 19 Oct 2026 02:22:14 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:13 -0700 (PDT)
Subject: [PATCH v4 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Mon, 19 Oct 2026 14:51:45 +0530
Message-Id: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACvh1WoC/3XQUWvDIBAH8K9SfJ5FL0ZNn/o9yijGnK1jaRI1Y
 aP0u8/YscJKX4TD8/e/80oiBo+R7DZXEnDx0Q+XXIi3DbFnczkh9V2uCTCQTFecprE/Tnboj13
 wCwbaAbcKGKqqBZJfjQGd/yri4f1ex7n9QJtW5rcj4DTnqHRveyTtNiVHME1LxpytiNaM47H3p
 2ASluyESHmlZdOJGhkXu6Ve4dZEpPm69ylD6FplOHfcGNFBZ0HXDkFqZq0BsG3jFDgpyDrk2cc
 0hO/yCwsvM71ceOGUUem4dEY2IJzZDzFup9l8rtHbfBRygQfTMPXMQGYUN7LlqobO6BdM9cdwx
 utnpsoMCGU11gxqhvsp+X/M7Xb7AeMikvPoAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfXyL2VyTru2gm4
 FhE4opemhDDP742HG6TKUzms+5ZJx5Xa0ACu06emjSPST5VdAKVradkLIGdMcHbu5Neo1mrHMAC
 5C2Ku7Uy6QbELe4wskbK1kQTolxtOa5VOg0SnOD7Ts2I05mBA6LuBsabjuyNxo4RjVgW9p4faeJ
 6YHZnHqSKcWsa+IjJvrU/sJZwBbkcGz2NrsUDOo9TcWDypJTA6CLGqTMuSUnrMNex+WxNwKDzv4
 z88ZGJbqxVop10hSud5npgAOfwII3ZYHUl8L0v/IMBtiUuLMa6lLfBE/u9oQTP6u9y7IJYe0XD2
 Ikm51aWXrX7PVr1ii/ty+0qUnrYF/TyXeHxSeRJAAA6y/qB4HeaaAWsT7gaBCDxmgI1UfM6hfO1
 knzNi2DIMWXdHb3UnYzTMQlnJu4IPdguxzcF7ggHZaKjVtYUk2Zzn5KFfyOPrTiBMGHGk9NIfQN
 cRSpEHPxkkrJNubi9Pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX5X67hPtaTbwI
 JMh1wIwBN2n0ycgpwOYgpnz7gQMpsPYVfEyw8c0KryIMKJSiYH1w+jIxh2RRkNr8eeopYYZBXvZ
 UXuYdIbQCYmRfApANNg70Z7iQKih284=
X-Proofpoint-GUID: Yyekz3H4roSTcIemQpsi92SHqcy9cqKP
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5e148 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=xG2GeFPYwsRGK1jMldgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-ORIG-GUID: Yyekz3H4roSTcIemQpsi92SHqcy9cqKP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 15D9444A8C
X-Spamd-Bar: -----
Message-ID-Hash: 6XZGCA6S4AFHG5NSUJJUPNQHNZXAPBLW
X-Message-ID-Hash: 6XZGCA6S4AFHG5NSUJJUPNQHNZXAPBLW
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6XZGCA6S4AFHG5NSUJJUPNQHNZXAPBLW/>
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
- https://lore.kernel.org/lkml/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v4:
- Add new line before goto label(Jarkko).
- Link to v3: https://patch.msgid.link/20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com

Changes in v3:
- Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
- Update return values of functions and drop certain error prints.
- Define locality_arg as default value.
- Add Jarkko's tag on all but drop from 2/3 as significant changes done.
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
 drivers/char/tpm/tpm_qcom.c       | 414 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 6 files changed, 435 insertions(+), 1 deletion(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v5
prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
prerequisite-patch-id: 8777bfa2ef8344715bf972d049acb0a6ef49b136
prerequisite-patch-id: 1c7f946e770a1cbc1599f9571282c9265a6af9cd
prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

