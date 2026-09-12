Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1502EC79FB6
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:15:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 301D245480
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789208137;
	bh=3i/FrZXVmWI7Atm0YNsVJ226agJdLQqGFQnqYBQUV1U=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=gqAdq+sAC5sMLKaE65JI/JkKApkzL82f0sHnn1q5v8hDIND7B8voYGR6GKC9wkxz2
	 8mDAd/XBf+xlEEGLvxExvMUhGoQ3m1HS0d7mK/OAl9trPAXUOwq2ab/U4uE0Ru4ojS
	 ikZNeSLUJ6SPC4NmpHmTSbYUmQk1P440hpa9tSGYIbWw7jbp++LWvqtH56XrDlNmg2
	 JwW/DfBq+PO0MBBYV8Nup73aCdxAeIvxaiaa8tLI/fOHS1x4AzQisAuxMTD6jxMSQG
	 mB1SA/57qIjJXKx65T/fIRLTCRAdwLJSwfK/H93okjLi40P1PjlPdfmZP1YWL/zRSw
	 HrLuXJ6+Y/18g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AD1D5443EB
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hZNawyG1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bpUM6AKw;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C85I8P3019892
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=R5jHNQqpCxih0uhIATPS5R
	+CswhgM6mi1nkI0T2LCp8=; b=hZNawyG1cAWEXrtAytMyqklfS03eL509lBJneE
	b2VbFNBOd5m5zXDHkmAUqxntKNhlOVwtcx1/mOjxlsRg7zpPNlaHlN8G4bioqCva
	VWbNBG7R6+PnTjBdIj40swU6nbXPGIBGqNv+25uClJFoSFY+FDU6CLkqArHsUDKb
	PDmAOuT86uAAQkJVlLiWSoBY4dxCHcKrVxCAPQMFnIsLVIXvf+LVm6SLJVgiUwpJ
	6rtd9w3vJvA435vbapOsOzEz1p6FCcvCklRYok9IPml02JWekCwv/e+koo+3f8ns
	XcyFWa0RdyEeJ+e1iykMy/GHhUHrkjHRHXBiJ6+sD7CWd2Ew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgp85-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so2195226a91.1
        for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 03:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789208128; x=1789812928; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R5jHNQqpCxih0uhIATPS5R+CswhgM6mi1nkI0T2LCp8=;
        b=bpUM6AKwcyb0tTNmxJ1/QkJ61gKJHeScLx6QiKxiltdJqCWSCqVGW1RxGsr9usQdyp
         zg853Z4ffnbkIW3+V+E1CAWDOQTfcyTSq1e2QGWffNDWPn/gkFsIiHojLsZ8zwoiOMsH
         ofQ7u0a3EcUkUkXQwc9lm9tCINDf9PmaOaY/N8JHmUxGCPLMmErRxM1dsD0hVl7fyAcS
         lfAnQ2RV1192DYTmgjf69KT01DRvP7ACz/iC6ANUSIlg8doo9OYPH58twj8Cuzsi4Om5
         rqUQKcqEKSgoDyQyBi+eoZuh5WViS0ICS0bRpO6Ba8L2n0H4vN4bTw8l5LGMLQma7eic
         3jPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789208128; x=1789812928;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R5jHNQqpCxih0uhIATPS5R+CswhgM6mi1nkI0T2LCp8=;
        b=iv31U8I/cfAMoYi7OYzzHiOGNeo/kBgHFNh+JUejmqbNviw3wHpnxWmBQz3h7qQr4w
         ywaDrDA+kfBpiy6pmq1V3WtC4c6S7Kk0GEx/S4NC7vJCUQC2gBoy6++nL7eLP3nenBe6
         rViNtiADQRwsVJTDW4QYoyyuLQXrgC9Qnvy3BsRhDa/uVcuT4arNPZxv3lNwRRB1OFfV
         4EC1HzU6BNGleEM5nPr7mHPiHQgJ7uLjf2JTdrf42mdP6sSD+oxOxiwgeffjbM8AJPzF
         TSuP2g+8nrdJwgTuwDlPTd/HJ40X+UkJEMY35iQvvokd5jzjHrtx3A9/4xfEPv/zvq9q
         9iPg==
X-Forwarded-Encrypted: i=1; AKwUvBx0wuy4/nwq9LcRoh5QmJOPGJKRqpMVMSkryOIAADj9mJ64zVf8a9JZv+xp1+u1lArxfadVrzA=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mFEYlejrtLQRwkhLpDA7r63LLXmfu1V4ITSUDrEEt6jRmqDEPV
	3zRrxyvmprbGhU9VIHZLoaTFb5hOaJ+etNWn698tO9Yr/S8HxWJ6s2heItExL2ZvlThdhtyfy+/
	tdy83M1K90Pm7DuRHk5e6C3vbvEk4Dt3OdN9WKKJlCVUkuk3FLpub9KQyre8FbEpQ9oyAFkk=
X-Gm-Gg: AYBFou2X9KyVe8Et5yVh065XYBRYd+eIKV7WpWvEoAnXNGkVh5XLWCnc8T3bwJL8hJp
	AW8yqSlHdD4cHNjluSE6SA5I6RnMY10MFatON8b1FISl7Uzc69r8s/RCn05FbAI7t/7776xSzfQ
	632Oz57Bx3THhhLaJ2z4Vc7r5bh/qdOGvNUmXTmh2lIg4kFjEMKU8eecyLoSZ37xEXb/fFrKOYo
	y737Jd8UG5PICAPuMj/Rv/tJPHovfcrHjsRpNG1Sr4RUmLc39PxQqGs15FluTC8k69H2Yw3D/pY
	XhSV56RpJIIZxq/Evl1LBZwdQOK8dIrrSvwgEKpYYhiAnKbE1WzU0RPtCKRNCUnsO7hYJzMvElG
	DHpT220l3XDrT5ZJcUdX3PN8w8kh2OL64pSwn4MKXB1otxHuI33/99HsZN90=
X-Received: by 2002:a17:90b:4b83:b0:396:b98b:a3c2 with SMTP id 98e67ed59e1d1-39d9bd67a22mr13716498a91.8.1789208127849;
        Sat, 12 Sep 2026 03:15:27 -0700 (PDT)
X-Received: by 2002:a17:90b:4b83:b0:396:b98b:a3c2 with SMTP id 98e67ed59e1d1-39d9bd67a22mr13716438a91.8.1789208127398;
        Sat, 12 Sep 2026 03:15:27 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm10340085eec.8.2026.09.12.03.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:15:26 -0700 (PDT)
Subject: [PATCH RFC 0/5] tee: optee: add RISC-V RPMI TEE transport
Date: Sat, 12 Sep 2026 03:15:11 -0700
Message-Id: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8mpWoC/x3MMQrDMAxG4asEzRE4KgTatZADdA0ZWvt3qiGpk
 YMpmNy9puMbvlcpwxSZbl0lQ9Gsn73F0Hfk3899BWtoTeJkdNdB2NKmfADcYFEPXi1xQOGXeEg
 cL3AhUuPJEPX7X8/0mO60nOcPQEwISG8AAAA=
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: uHb8LovFj3r9wGv9ms2106J9qyQkbR7y
X-Proofpoint-ORIG-GUID: uHb8LovFj3r9wGv9ms2106J9qyQkbR7y
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa52640 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=V1jnuoLLAAAA:20 a=EUspDBNiAAAA:8 a=MT4jQWGmPZThi4S9qkAA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfX+mQi10K3Nq4T
 AoaLkS+v2WLDRzpBQJIfL/U+4Fz+Ga0iP5Br4XmEqIxPLBF0lv1+6bWHucEmhBa01Mdjz0QV/wQ
 Ya+rtaOgKxh7JUzg+CEYBArHminjbyA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfX1iJ15A+10ExA
 G2ukM3Mj3O18luBQTn6vm0Dx3CXnIU6ND2xvMRbDyQcOU8jqZKQwTgtyqozISexspPawTTo1ESU
 FHBxFWpIaOqi+atH9hQd6oFRarpBHh3wkiT7ZFHGZpkYFT/C9YOGPpNtTkPZslUkD5ZuX2IWcN0
 hj/JQTN/T4jR2VPkQZ9g4eNLOlWgBtMd5B+mZku49+xutLIyjKokeBxgKUfMM/kW45yg3YXB44x
 PcEPebACKX+o/ByGomL+eE5p55hqGqBsHSVhv7RnmJhahK64H4p4+mkL1v5JjnNsfHEP5pX8YQn
 rCgKr7ylMtJCDp4CpE+iT7GYSLHVYetOMq5pjCVF/9FFTLPDqviyLeTmSB+pEsapuSSsFMexX5X
 OgZcaLdaDFvYDNU5WVjPwhQ1hMFLk/HUAi6gX4gF3DohI1KICfnNEyxxDiOGlbbHFOjuFkZ39Bb
 l/me84N5Cf2EDRQMHpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	URIBL_BLOCKED(0.00)[oss.qualcomm.com:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AD1D5443EB
X-Spamd-Bar: -----
Message-ID-Hash: BQRWUKVDMHIGKYLGHYP4E4H3CG5ZVAQJ
X-Message-ID-Hash: BQRWUKVDMHIGKYLGHYP4E4H3CG5ZVAQJ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BQRWUKVDMHIGKYLGHYP4E4H3CG5ZVAQJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

This RFC adds initial support for communicating with OP-TEE on RISC-V
using the RPMI TEE service group [1] over the SBI MPXY [2]
mailbox framework.

The intention is to provide a transport for RISC-V systems similar in
purpose to the FF-A transport currently used by OP-TEE on Arm systems.
Linux and OP-TEE act as endpoints of the RPMI TEE service group, while
the RPMI framework in machine-mode firmware mediates communication
between them.

The implementation closely follows the existing OP-TEE FF-A backend in
drivers/tee/optee/ffa_abi.c. Where possible, the same overall design and
lifetime rules are preserved, with FF-A operations mapped to equivalent
RPMI TEE services.

For shared memory, FF-A memory handles are replaced by RPMI memory parcel
identifiers. Linux creates an RPMI memory parcel for shared memory and
makes OP-TEE a receiver of that parcel. The parcel identifier is then
used in OP-TEE message parameters in a similar way to the FF-A global
memory handle.

RPMI TEE_CALL is used as the entry mechanism into OP-TEE, serving a role
similar to the FF-A direct-message path. The request and response contain
a small register-like payload carrying the OP-TEE call information and
state required to resume yielding calls. The existing OP-TEE call queue,
RPC handling and shared-memory infrastructure are reused as much as
possible.

The transport uses one SBI MPXY mailbox channel per hart. A TEE call is
issued using the channel corresponding to the CPU on which the call is
running. This preserves the execution model where entering OP-TEE on a
hart results in secure-world execution associated with that hart.

Shared memory is implemented using RPMI TEE memory parcels. The driver
maintains a mapping between parcel identifiers and struct tee_shm objects
and uses parcel create and reclaim operations to manage the lifetime of
memory shared with OP-TEE.

Asynchronous notifications are implemented using the RPMI TEE signal
bus. The RPMI TEE service group does not provide framework notification
events corresponding directly to the OP-TEE asynchronous notification
mechanism, so the signal bus is used to carry notification values from
OP-TEE to Linux.

This is an early RFC and the implementation is not complete. There may
still be functional bugs, incorrect assumptions, missing pieces, or
interfaces that need to change.

The series is being posted at this stage primarily to get feedback on the
overall architecture and on how the OP-TEE ABI is mapped onto the RPMI
TEE service group.

The implementation deliberately follows the FF-A backend and ffa_abi.c
closely. This allows the existing OP-TEE driver design to be reused and
keeps the RISC-V and FF-A transports as consistent as possible. Some of
these abstractions may need to be adjusted where the RPMI execution,
notification, or memory model differs from FF-A, while others may
eventually be shared between the transports.

[1] https://github.com/riscv-non-isa/riscv-rpmi/commits/main/src/srvgrp-tee.adoc
[2] https://github.com/riscv-non-isa/riscv-sbi-doc/releases

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
Amirreza Zarrabi (5):
      optee: riscv: add RPMI TEE service group transport
      optee: riscv: add shared memory and scheduled calls
      optee: riscv: enable persistent shared argument cache
      optee: riscv: add asynchronous notifications over the signal bus
      dt-bindings: tee: add RISC-V RPMI TEE transport

 .../bindings/tee/riscv,rpmi-mpxy-tee.yaml          |   65 +
 MAINTAINERS                                        |    1 +
 drivers/tee/optee/Makefile                         |    1 +
 drivers/tee/optee/core.c                           |    8 +-
 drivers/tee/optee/optee_private.h                  |   47 +
 drivers/tee/optee/optee_riscv.c                    | 1621 ++++++++++++++++++++
 drivers/tee/optee/optee_riscv.h                    |  334 ++++
 include/linux/mailbox/riscv-rpmi-message.h         |    1 +
 8 files changed, 2076 insertions(+), 2 deletions(-)
---
base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
change-id: 20260912-rpmi-tee-service-grp-dev-b2ce2f63e0df

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

