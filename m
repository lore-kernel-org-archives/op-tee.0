Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CE3C4451C
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 06:59:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D97C8450DF
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 06:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784703584;
	bh=mJwLaHl0XbdPBY/iqlDmGPtITkUtXbqkAghaBDWPdHE=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=Ndrrwlz+k6+dK5S0tNRosHd5p8eellTDRxMljVd7gx3Q9vDF901sB37HL56kGB123
	 aZBueW6NuEkKsSdFKqeB8p6pW8De9Y9l989FfTPIC5siGslXvt4iUYzW1jQfxNOFWh
	 HDF0gy1i5t+MZP7HsMHWABDRanxD0zyVIjIVB9wpxudm21tVtbJUH4BIwqCt90zD4/
	 /Y4lm+9OfqsuOLNgSwmU4HmrunpP7eiPVMaO364Ky7uVxpevlgt8YuCI/bWRsY59g1
	 lgEEtSTBvXyo6HA/X5zECM+3HdaS2KSLEHCjJtDFHMLNgchXrB4Xi4OSF36fyjItYd
	 OveaEl5oytRDQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 15AE643AAA
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U+eSAJel;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cnLFsZV3;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M547G34046130
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KsbDzSYZT8reWZ8gT9o8dl
	pli9OoH32CDxAIlbVUcPs=; b=U+eSAJelUroELrxWtgTgDJ33G7gwfw75p02iJ9
	zSP2eLdTVPkm2DCH6lMdOcz45qb6ds7jJa8Y/uP/zKGnW4ekLpCS3MSsiZNcy+3u
	QgicV1tKWXFRiV1WZvSz8sk5YraYgQF5QAD8upVsYAR/HXpxlFxwq8KmcM7u5Soy
	4+zR1Qfmm5kkid4980Vq/6kN8OXX/H2nyN8nPNq97LDpUXRNe7og+aTL1Eq6LuIg
	TcKB3XTyqsJnsxq1JJK46FEkVHcdhIqCPrF+2uInKMb1DVPKluYOGW5bMcwExiQJ
	QBMa4YfS/IbNeY5m8NgtbWiwrbYcw+WZX29gqFl/cGSRoKFA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6dar37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc77a6943eso216292635ad.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784703575; x=1785308375; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KsbDzSYZT8reWZ8gT9o8dlpli9OoH32CDxAIlbVUcPs=;
        b=cnLFsZV3LbBvUaRhV5WLLa0iAM0/QIq807dLsoLqbkPeijgmAqFofUBI+V4EQL50kD
         O33cMCC+ZVkocbpfimuAXUw4uvK+QWHj9j4qUooJ/uz60iZuCSpU277vophBOndcP+mm
         Mwl/5TLN9F/BoiomLKlBvO/TDKbPfB6OQ4xqLq/j9ifpd4OI7TWM3qaNwbEjfjW14GrP
         xlFI87BMQ7WDhkmpVC44aO58CwkBfoViNbiqRNLiTiG4f367td2OJm3P53PT0Ioy2GoL
         4dVZvDsC58Tw9l/n4nxjTv8Wg7mbPtKrfttpWH+99bHLriUgMUb0xRCjz9jXKXUPz0Cl
         lYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703575; x=1785308375;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KsbDzSYZT8reWZ8gT9o8dlpli9OoH32CDxAIlbVUcPs=;
        b=GzyNmy2bQph4wDeQoPMhoKgzg4m8npCbSBSPaxcuBWuE7VyZfBdE+As2Zb7utz1BCI
         O4jveBjy8+EiIXdkUyO/5ML8ilDTvYbx/+V0Q1lBJZAcuZ0mqJ05UHZDHn/BOiiBenGR
         OXUTWjH4ix7t2XvUZmB9SU5kzRiUbZGWKpWUOWm9RYxUqO8l8eyvsdwuYwJ1RqQvr8CI
         CFrmAkJ6Hbq3azW/wbFPMJ4S3vyBMahfDHu0CVoPp+8UvUQqxoP2qTsXcV8AKPCb6Ojz
         OkQF02XOucloLra2Jp5rclj5z7lLArD55+01t4ikIz42xWiKixZU3Uoh3LhslfoyCODG
         YVFA==
X-Forwarded-Encrypted: i=1; AHgh+RqCz+SxfLDWr7y5RSaYo2joiMUNKRhm7mReEhwlX+7Qr5OlbzB5wxYb672V1tE9E0tz2uWm2vI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyQYtuG4+lXJq7iEJ58J6mw3yapXZUUR8eTLturk5t9YWk8G1hc
	9lw56z1mnDFHD2HU39yo00kVHnaQA3dBrYkj/JBENQPfmLBgElPwclYjUMX8RnMPOyx5pkGOJsZ
	ok16fcMJsOiTkckrMHZ7Lhlu/scAGHBxN5HN4yV6WJCOIPaRP512ybrSCit4szWeebtbDDzL1
X-Gm-Gg: AR+sD1118mx8hha9TjqB1U6jITFZ9wO2RuaE9R8uJhPGDcOHiRjHwmlvsMBrH534q8q
	LpTOcdjKb75kZ4VqmI5dk97k+TeESSYufiraMHzYzJUEddmUqjpzazV4tYTpyIFvdDeAMXyBwZS
	edf+CvVOT9RJa7w1GFugHSO1HGFU6qtY+sUZVGQWT6BNjYsOlXVF2YL/QnHIhczuUUbuSyBnKgr
	5d4FoJkjDtg9TOrv7N+pchqKnZZNQylOHlrerO++7zhN9Y/TNN+I/jRXa40q3otKe1ZCgeRyKai
	iWjECUd5laIFeuuhgNLkzOKqxL3p5uHf5OfUeYz1BEcJch/D1RadKpFkZ7rqbw/98lD0aTAP3vj
	nL4Qmrp6ZFcdIBmS2vJepWwrGBg==
X-Received: by 2002:a17:902:d590:b0:2ca:b89:7bcf with SMTP id d9443c01a7336-2cf3494b178mr230269965ad.22.1784703575011;
        Tue, 21 Jul 2026 23:59:35 -0700 (PDT)
X-Received: by 2002:a17:902:d590:b0:2ca:b89:7bcf with SMTP id d9443c01a7336-2cf3494b178mr230269785ad.22.1784703574520;
        Tue, 21 Jul 2026 23:59:34 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm9428935ad.22.2026.07.21.23.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:59:33 -0700 (PDT)
Subject: [PATCH v2 0/6] Add TEE based client driver for UEFI Secure
 Application
Date: Wed, 22 Jul 2026 12:29:11 +0530
Message-Id: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD9qYGoC/4WNWwqDMBREtyL5buTGxle/uo8ikiZXDVSjuSot4
 t4b7QL6M3CG4czGCL1FYrdoYx5XS9YNAZJLxHSnhha5NYFZAkkGEgo+adfXCzaWUKtxrHvbejV
 jffQzIhfXIiuNTBGEZMEy+rB9nw+PKnBnaXb+cx6u4mh/7hzyv+5VcOBNlpb6aVIDUt8dUTwt6
 hUGfRyCVfu+fwEARk6X1QAAAA==
X-Change-ID: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784703569; l=5231;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=mJwLaHl0XbdPBY/iqlDmGPtITkUtXbqkAghaBDWPdHE=;
 b=qUq1qoBHpI3+QPSh6KMqTSrLcV8U8ZAJea+9Y332ADeHbE0w82N+tQQW1LrkIblFQHRKSMdmB
 jHcP+GLvKCuCMiQVCVwnkywAWxzPFB/Nfi0JkIemtqR5TlZlyBaK0rZ
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX0JpspwVQrQ0S
 jyTUi3B1VfS7aUKezVwzSYdu7V8RzuCgp0oyT3BX0FhlFBwWJvLbOFfSmccuCsFQmnac1wyGg2n
 +Cdks9287YcqTR7lxJ9C6PtftemZtI4=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a606a58 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EPKcpx9xAAAA:20 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=BhHARkrmHK2z0SOGQHEA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=ZT_8zCgGubuJgGonBfBE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MyBTYWx0ZWRfX+p3KbI1cgyC3
 Y2fHUrmaTGkH0w7vXTLgk73dAVs8ed9SOWrWV9Yp88NGYQx9+lZjxg3AF//X/JH5T1d3MGaRQUR
 1AeuXkImr5uGo7tyWlE9Cho1cNBSIDVVJI4+zWhNfNvjrfC78xEXkLbMEipsxi/BsJLxcOnTvwD
 ms7kaX5jhvZcIy5o9jLggp74/0gncDbxbuWDfcDnm8wjrnzej+h4Mi79nHemWrfo4Zw8r3wMQ8q
 IarjbueOegymBzrCiODbKhHe+bbPzESOtEjeGK+TPkipL7fw86biEPB/X0Pbf5fdOwS3RVy2BYC
 Eo1nWgythsEX/IDi+b9PNQ3r3cbcSPmrSYgDngmJEO9r2Dez8pPzPHFVrWgRcYUiXDjAoLwieEn
 K4zbwi7IvLLcqGv6WD3inGCi7/FGENweXoyeqv8f9FvQ6h+8S1BV9l8JVj4LmWNpASyZYkQiqlu
 xNjIdthRpxRL2w3w+ew==
X-Proofpoint-GUID: tkexNtDBaQOxHFjphfWHLN7AQRkzLE0F
X-Proofpoint-ORIG-GUID: tkexNtDBaQOxHFjphfWHLN7AQRkzLE0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220063
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REDIRECTOR_URL(0.00)[shorturl.at];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 15AE643AAA
X-Spamd-Bar: ------
Message-ID-Hash: EXPQ6FY2LK52RPIFUBZPNJFG77DWODCV
X-Message-ID-Hash: EXPQ6FY2LK52RPIFUBZPNJFG77DWODCV
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EXPQ6FY2LK52RPIFUBZPNJFG77DWODCV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

On Qualcomm SoC based platforms, UEFI stores EFI variables within the
Replay Protected Memory Block (RPMB) which is only accessible by the
Qualcomm Trusted Execution Environment (QTEE).

For Qualcomm platforms without emulated RPMB support, specifically
platforms where RPMB is not located within SPI-NOR storage and instead
located on UFS/EMMC storage, non-volatile EFI variables can only be set via
a callback request from the UEFI Secure Application to the RPMB service
running in user-space (within the QTEE supplicant [1]).

Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
QSEECOM based uefisecapp) does not support callback requests. And on
certain Qualcomm platforms such as the RB3Gen2, attempts to access the
QSEECOM interface fail due to lack of support within Qualcomm TEE.
On these platforms, a TEE based uefisecapp client driver is required to:
1. Access cached & volatile EFI variables stored in uefisecapp's memory.
2. Ensure persistence of non-volatile EFI variables via writes through
the RPMB service hosted in the QTEE supplicant.

This series introduces such a uefisecapp TEE client driver for the
aforementioned Qualcomm platforms which installs efi-var operations _if_
the QCOMTEE driver registers support for an object-IPC based uefisecapp
service on the TEE bus during its probe. Only new QTEE firmware versions
available at [2] provide this support.

Thus, QCOMTEE now maintains a static list of always-available object-IPC
based secure services exposed by QTEE. These services are implemented either
within the QTEE kernel or within a pre-loaded Trusted Application (TA)
usually loaded by the bootloader. The uefisecapp TA is an example of a
preloaded TA loaded by UEFI. A static list is required since QTEE does not
yet expose any way to dynamically query and enumerate the services exposed by
it.

To facilitate object-IPC interactions from the kernel-space, this
series also introduces a tee_client_object_invoke_func() to allow
invocation of TEE objects similar to the existing tee_client_invoke_func()
API exported by the TEE subsystem which allows invocation of TEE functions.
Some suporting changes are also introduced to track and handle operations
for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
driver.

Finally and as previously mentioned, access to the object-IPC based uefisecapp
service is restricted on older QTEE firmware versions. A new QTEE firmware
release must be picked up from QArtifactory [2] for all upstream supported
Qualcomm SoCs to enable access to uefisecapp service via the TEE client
driver.

This patch series has been validated on Kodiak RB3Gen2 platform with UFS
storage by attempting to read/write EFI variables via the efivar tool [3]
after mounting the efivarfs filesystem. See [4] for an example.

Merge Strategy:

This patch series could either be taken from the OP-TEE tree or the
QCOM soc tree. I would prefer it to be picked by the OP-TEE tree since
all except the uefisecapp TEE client driver patch in this series make
changes relevant to the TEE subsystem. It would be great if the QCOM soc
tree maintainers can Ack the uefisecapp driver patch.

[1] https://github.com/qualcomm/minkipc
[2] https://shorturl.at/zQU07
[3] https://github.com/rhboot/efivar
[4] https://docs.qualcomm.com/doc/80-70020-27/topic/manage_uefi_environment_variables_using_efivar_tool.html

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
Changes in v2:
- Drop using MSB of the object_id to distingush kernel and user object invoke contexts.
- Introduce enum tee_object_invoke_origin to check the context of object invocation.
- Link to v1: https://lore.kernel.org/r/20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com

---
Amirreza Zarrabi (2):
      tee: Add kernel client object invoke helper
      tee: qcomtee: Allow object invokes from kernel clients

Harshal Dev (4):
      tee: qcomtee: Track the object invocation context
      tee: Export uuidv5 generation for TEE backends
      tee: qcomtee: Add support for registering QTEE services on TEE bus
      firmware: qcom: Add support for TEE based EFI-var client driver

 MAINTAINERS                                 |   7 +
 drivers/firmware/qcom/Kconfig               |  24 ++
 drivers/firmware/qcom/Makefile              |   1 +
 drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++
 drivers/tee/qcomtee/call.c                  | 205 ++++++++++-
 drivers/tee/qcomtee/core.c                  |   9 +-
 drivers/tee/qcomtee/qcomtee.h               |  12 +
 drivers/tee/qcomtee/qcomtee_msg.h           |   1 +
 drivers/tee/qcomtee/qcomtee_object.h        |  16 +-
 drivers/tee/tee_core.c                      |  24 +-
 include/linux/tee_core.h                    |  23 +-
 include/linux/tee_drv.h                     |  18 +-
 13 files changed, 952 insertions(+), 33 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

