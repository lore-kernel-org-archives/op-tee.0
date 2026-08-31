Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AC7C61DE2
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 09:43:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6000E45032
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 09:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788169410;
	bh=Uz8K52ckdSGPXQ7DIRli6aJZfuZvAmohNlhPwXu3mR8=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=Ck7rjoHXNhiA5PBbnfcVXV5E9rtG4z/s911kVwgbAu72y1dJxx5ZuguJj+f9krsBr
	 sdh2J7G+kzHI3zFV4ZRK9M/m20uBKzRYIv2efPbIVnSlweQ5lGPjDeHKlX3XauJZGW
	 yKJ5NC/yXka7lIIV+Q/fkYAPNDNRzrI6nKWnEJ9iqaWDyw1jpLn0FRYALuTwa1963F
	 QzviBbJK/Yo9eRLlI02ylKsodf58mnS3H2BRf313H2i4syqJAlcrrFp0aLjzeW1c82
	 rqllPDZ07CYjdPM90y5IhZ1kCpnbC/dYJ+tnGaoAwg9HUVjECzKG0iEcIjzNGo8yvD
	 6mrKakPdrJpSw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C3E7144F0F
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 09:43:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jCNrJKHq;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d8mSUkKp;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xaEg2924389
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 09:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R8skzQrcTOFob5OgyU8esN
	NdOJgcF5QRwXdZN6hrzvQ=; b=jCNrJKHqSFy/sVcK+6sqY1TgMZwmOnm/8N3x7e
	LF0D5eWUi5Ca3eRaTQN2bSdKPpaA0J6FD+0LXK3FMMHqchLXP9deRKWjvMdGwRJ0
	OcVlXeYFyH+mqJj558h0Fk58vLC49/P5kpMRn3qOOxZRrmQkN3+ksQA2Gx+kTFiZ
	PwIQmcBiz1FkrXoWsSN/1qWvFlAYVTWww/biv6geJzucRyuMJKmK5wja9m+RV0Cs
	eUExGzQDmOBxkpAw0SxqKs2wFJvvoNY/7zyz4snyLpBTLb+BVs15tXPfVAVhEsww
	dGO4ScAej5p1cU4guswFJqimMwlz5/DWbj9GZNw2QrhBA3YA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv7wa1um-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 09:43:23 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso5155212a12.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788169402; x=1788774202; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R8skzQrcTOFob5OgyU8esNNdOJgcF5QRwXdZN6hrzvQ=;
        b=d8mSUkKpNUnPX/hemzp+kYzFEMnwRuIKtg5H2RaUVDKa349XfQeeCad3npN8hgartY
         RwDEKO0ZS69IHBDGmwyKCtp2u2R5w5k/sGctql4+k6kUBW8ayZGYOxjL0xMVKOzuLgfQ
         gvQWFGdaWiWWV5cixgGUg12409KAgeRjcwpEEFqeNHIh5YfdLQRVCP57k4RSy2f5hFYe
         6a75v+8GoS+HkmkowejEMwFfLTOI36j5JXLlrYQt+1Qwgd4OoKAMdro1PwDCV4xT7E9Y
         4YicqV4So+w3/pHOghkn3xnfHFZzTQi2qC61DnG+iClBAIMJ7Xqo6WbifRYoMhBAmDLq
         PoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169402; x=1788774202;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R8skzQrcTOFob5OgyU8esNNdOJgcF5QRwXdZN6hrzvQ=;
        b=KU29fCPr7d7gTFfiuX2xaw5ShCRWTjXK4JSNU0ftcObcthnLtO95s8w6HG2FVnpVwG
         l4y3BkwoouGzJJ92Y8ZTAldetVjmrjO5FplbVGyoJkIsYE0ZLRjWUG1kDP+djlR1cagv
         gyKClCX4g3FlclAiXCdBM0ucs88/aPUzXt9QudkncrRIYrnDITmbCAmIIxFV2sjNDjko
         X3cz/ynmr6czBkiRgaMDyUg337HC6QhVDODxc55Zt5bvAHXXyW2JS6MngkwQw3vRkaaQ
         UBsXkeBRUNXGzt72T2Bqbj5Bwubq5CJPZNR7rQyhjnAXbfEUlwV0B78tHxbCe9MN5eFJ
         NLYQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSyzuEhh+XKJ1dGQ2iASRK94ITClCgd6/2LTUV5Kzl6v47GaGiAwIHIyWQIzsnSKCM3Hy7VNI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nsDZp9gIiRvufwFpTsHoQJR5JP33lnPEPkNcXs2iYrC2srDJX1
	PNWzM8ly5tatIiTUTV0WmHKZUqE43vxB3t3mpGb/1UNCv7cfQK+Zl89NESbfnpo9EbPFKgsBphj
	N67doAXvYYEEIxdX6IL7xuDs6Xe5McfD73SObaTllMubjKvWGqq7SXabY9uaDntj7NJDcUATq
X-Gm-Gg: AYBFou173VNZxDLRkcOZYD6gODSXhFoacjR8at9ebQRf28newsVdPeNbllbT3CeLbgu
	DM1wk+zfaFyTgyDBBJHF1Dojryerf/Eb+Yx7YKK14eXpIj0OHwzlWqrEAmLep3XMpu6F65A4+pi
	M/4BOgNZsUdwDZcG0dHsKHA0OCZpJVHxgj5oYad8OGZOrSOtxOee6IwUt5I/EPjHsRHkr95Ezwd
	IaLmpZVj/IqiXqKqDOOa8WLt3Dfl1PmqD5+aC0VKu4ZWCecEC5BYhGE+dp+OtPB/AJdwjhpDxyt
	9s3GEgb7WUtpFs2mgdwaoFaRE+rRnbfZiOTKPuJEzCbFpfHIk3kI5ROs03AvEr7vPX7Ap2yqJnI
	2vZLwxIy2EoZ7iRr5ZazCXTl5QzNklziPjQ==
X-Received: by 2002:a17:90b:5443:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-396d100313fmr38943819a91.16.1788169401982;
        Mon, 31 Aug 2026 02:43:21 -0700 (PDT)
X-Received: by 2002:a17:90b:5443:b0:396:4cbf:45bc with SMTP id 98e67ed59e1d1-396d100313fmr38943775a91.16.1788169401471;
        Mon, 31 Aug 2026 02:43:21 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm40782983c88.0.2026.08.31.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:43:21 -0700 (PDT)
Subject: [PATCH 0/2] Add TPM support via Qualcomm TEE TPM TA
Date: Mon, 31 Aug 2026 15:12:59 +0530
Message-Id: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKRMlWoC/0WN26rCMBREf6Xk+QR2Lra1vyJScplqDlRrkhZB/
 HdjFHzaLPbMrAdLiAGJDc2DRWwhheulgPhrmDubywk8+MJMkmypV4LnZR5v7jqPPoYNkXspXCc
 JnbKSldYSMYV7XTwcP5xW+w+X3zPfRMRtLar8if1MQ1M9mnpeHWvZSnBmWcY5nKLJqO4McKH6d
 u/1DiT0sFW1NQm8vOeQh2ZSaJUi303Q0krSZqKdkd66treq24OMF+Ww4/P5AksywzAGAQAA
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=E9f9Y6dl c=1 sm=1 tr=0 ts=6a954cbb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EAapQlX8VUJyPtJC71QA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX5HmBx1j8/fQD
 Bou7cREDmVuvsdn1XmZYl1+BBDwID5lc3IDETJ/XEQcet+3QS8DE++y7Ov0/oLcXVdiJMsJuJfu
 dlz0co1t+ZpUi0AFAM6zZ3zvO5ipe5w=
X-Proofpoint-ORIG-GUID: oI33Y27EUmKCpI5qMYOMMYRKYL0wng30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX5NxKt6Bo2eUY
 JcbcnKLQ9a9WSS7BAhy5xjZMkV9/oqNOODF/jZv3wo+5UkWO+HSMbUlZn/Ju8GSr1oe+NpwRFjB
 rAdFWy6O3eNkSoaSNMZEDpmd+B4imQWRDgbpd3TK2fhw5Tmu7BwAaMOxv2OYCuYChLc9bsgsTvx
 9RguconAzVHwI22THJ/+yQfSEzlsPSzNIO0UoGwfgCejzCxBT9HGGluJOCGBJzHzX4Vn7U2pTIC
 MYNdbUFdSXLGzgqubqJHiGEFxkSX8ynN23bAGcowrKCqsuUdGtZznh9VbS2N+LLVCOneQwXEfl+
 abCm0JfeeLxHNog8gkoeGvq4CfGW1Xp1ieDqeJDkKsTphqIUhrIRZX+pDPLI2xIwGKqqbq5fJRb
 29uSekMOsr9bmOep7+E5ML5L1HGGV0vBArQ6elEhzAe9TuDJ/U9+Q2qvtvV5+eVbMf4AxpwQ4hv
 /SCiO8dcTZBBgsPeVDQ==
X-Proofpoint-GUID: oI33Y27EUmKCpI5qMYOMMYRKYL0wng30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310083
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.197:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C3E7144F0F
X-Spamd-Bar: -----
Message-ID-Hash: SXOZEUVY6OSGEMHBYDRGWUYVHVFZQ3MY
X-Message-ID-Hash: SXOZEUVY6OSGEMHBYDRGWUYVHVFZQ3MY
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SXOZEUVY6OSGEMHBYDRGWUYVHVFZQ3MY/>
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
Kuldeep Singh (2):
      tee: qcomtee: Register qcom.tz.tpm service for discovery
      firmware: tpm: Introduce tpm-qcom driver

 MAINTAINERS                       |   7 +
 drivers/char/tpm/Kconfig          |   9 +
 drivers/char/tpm/Makefile         |   1 +
 drivers/char/tpm/tpm_qcom.c       | 371 ++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_qcom.h       |  82 +++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 7 files changed, 475 insertions(+), 1 deletion(-)
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

