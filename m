Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D63CA5FFF
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:40:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B25DA453E0
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247202;
	bh=abj1jjKzR2uaLnvVbZ1eDaH4O4J8gzuXFkGnxdWUm3U=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=AQs/8/u5eCLakIvfC9BeS1HtMOfM0+zFtoNIxM9kzJOXiLpgknnShCnqT7SCmggWp
	 cSl05VbyQMHEiCqandUSxJuyS359ovLyF8j9P46s8n7VBPpMycumA2ECYregJixc1M
	 UK6JBI1GPPCVyiakCfg+3jQGDAdEByTHTo5z4Z5WlUwrHCYXoncBEaPPei0ppJC/Yf
	 hAqKLtC1UElZJWF8Jjw2Ihqb3HciGjD2vKDfN9pUt0ArnxyMakkLh3o25qjoJiIzVc
	 kk79T92qLoCzObYYa4j/TRps81l5ImxtF588qBiyiAZL/yHRnvwTcXoSPJ9NVCHJMn
	 OXixW6oc9MH8w==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 48FA443E88
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:39:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OJk1AieW;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xf/NHE2Q;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KMxpZ3299796
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IsDRn63F1MTcQ80JVeDfNz
	DYjnKG8K9IOfHI2D6YUAs=; b=OJk1AieWEhmc3sW+TPPMYs1Dc47Ie4CEluAbH3
	cpGLNulRnef1HZLRSNwdA0b0C2XRV2huk+MfGIE4hMSvjxzY9eX2Skl2V/zV+UG6
	hWJ4I/CHoJ9su3sqC/tr92yWRibIPxzSdjZzO8Q969b+xKb9Bxf8wEJUBr8FXUFi
	ap7MzkK6kBLBXQARCwjenkf2FsYAEH6zNaSkEWQuKxAXR41w6M551pOMDLZYmotr
	vx+8YrbWjemI9jjmuIiK6bMoBmVQLttNXkXMovt9gS9J5NX8mEDKx1aQBkoO1BPQ
	nsQ6m41O1j2y1ZCx038TuQN1zEbtRzNlBmHyx41SflNBYnIg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg2ra4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:39:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso4647708eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247192; x=1791851992; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IsDRn63F1MTcQ80JVeDfNzDYjnKG8K9IOfHI2D6YUAs=;
        b=Xf/NHE2Qgyl+cnD+a4eZVuEs9SaZl28iV0YR+qbMrmFDh/eDpmcLSvHbuc8g1N2oVD
         i9oiVRHC4gRMQJ0IPKHgOEq0wSzV3RedNqHK/BvAlWANMTkPpDyMMHrdcUuaddF/gvY9
         XIIZLZ3rDCOIJAGnM/oEavpDLw210UQZe4LW+unavv8+BCOwRYkyMXjlBDSuXDg7RwK5
         Kj7ssBF1Do5+x0kFv0LFoHhfeIuUsZstODKMD5UklGNdWAEyf1i05TKg1Z8Ct5PdLiTf
         HTHRj03Bk1o9xnVMUqezKc1LiB8yB6fecnsN0GmzB0+oT57/29Iui60ejJOOri8Sb432
         oYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247192; x=1791851992;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IsDRn63F1MTcQ80JVeDfNzDYjnKG8K9IOfHI2D6YUAs=;
        b=IUQrezIUfVyh4j5Y6hOKmFkPxfFMkzZelClC02SQF+sQNgK0PcZf3mS0mdQpuNa/qa
         6prYuWfHRenpsf/n0gCLbUw1p8cpN8fIZzAzmadWRiirxa5qXnuGyaQffv0x5dyUGl0M
         ZMoLqDfcjBYLVvfI4Y/86kl2tVRhVp2l7d+duIREN/qjQD6aIcZrtFDBd72apep/jr/x
         yVlTaIyGTo6omUNo8Y1LA2ndDy0Hq+b33RYceiuDWjiEDdSGsCdBIpLW0C/XVEqQoBA2
         UhQ7upcqOSvTXLoqsT8lCibZqTSK5oOYcdVa5N1UiyU2Y6pG2nu25IoUfg8casc6q7gw
         1UlQ==
X-Forwarded-Encrypted: i=1; AKwUvByyuhyuDNRQ4ssvu9F+tfFc+VNPjqSUbPSHIzSxxREbOXtxvlcJy4pEO++zW5CkskKXRVtbOWY=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJkTcTMa8IE8Hd+a2vQkc7NnyM3umMRFA6Ul3LSXiTY5c51+MRa
	MxEGV4YQYWqy8dlV2c8KCL+H5KXgNuPVmoOK8FKHnNylMNo/a5r0r1UxU2ZjAPzF5KPIj3txhMW
	aU4N2ebA53OQQOPz58Bc2u/86Qxq/7eGQ9z9OYdmU0YijfvEKL71ZcyEN1rRLkStBl0uX4C8=
X-Gm-Gg: AYBFou2BVgPjWj1HMYiY049sxJ6RVkJlylXC9cFuh/PwQs83LdR0ns11YMbE4J6ObCC
	abk149TZXvK7E6fdzwgFp/b1NvhQIQS2oy/VFBRKDfZP5z4yuIJR3BDuibgFotp+Dwe9VlquZH+
	jZnUbovuIwuw6luywfAhapYg+oXFFLvU8hqtMQIAj24Ljg7NaDA/9+uH85KoXqtncxERaFNt+Bn
	boP46Siob1bJV4vU8IugzBXCUdhvFv0TckanRnxzZp5bZac3RA11yCxJVcTsy+carya+iuF6u1x
	+U4VOqiplh9vY0pUVC3dXGzVS2Mcrq6eOher0zS2yllKbJWc6ihLDMZLWea1ysTgcJvuvTWEJ6A
	4D3EzUoJEyVV5uo6NOpOWAdk9hT0xnjY5+oolYjQdlN5vIPiF2NhPsbMQ3A==
X-Received: by 2002:a05:7300:4628:b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-35105291bd8mr13290857eec.4.1791247192375;
        Mon, 05 Oct 2026 17:39:52 -0700 (PDT)
X-Received: by 2002:a05:7300:4628:b0:34c:d1f2:b552 with SMTP id 5a478bee46e88-35105291bd8mr13290821eec.4.1791247191741;
        Mon, 05 Oct 2026 17:39:51 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:39:51 -0700 (PDT)
Subject: [PATCH RFC v2 0/8] tee: optee: add RPMI backend support on RISC-V
Date: Mon, 05 Oct 2026 17:39:44 -0700
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFBDxGoC/4WNwQqDMBBEf0X23JVkRak9FQr9gF6LB5usulCNT
 WxoEf+9wR/oZeDNMDMrBPbCAU7ZCp6jBHFTAjpkYIZ26hnFJgZSVKlaE/p5FFyYMRWjGMbez2g
 54oMMU1cVrGwHqT577uSzT9/hdr1Ak8xBwuL8d7+Leo/+L0eNCrXVtigNtceyPrsQ8te7fRo3j
 nkSaLZt+wE/f/jqzAAAAA==
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: MWIOG3Z2sc3favu2TuCW7zxxHRYvK0ul
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac44359 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pTLlcG3b_zTeakJ_RZwA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX/FuQnZGkGkWv
 kH8LT6+BzqxoCXswirP8UwNHkFMjpukBujPUPfruYZjwWMe2MPNLRuYrMBFF2+7stzhkE8+IXIz
 7MYulEsEbBd0mkBv1OKqpvB8ls8Nvmw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX8GR+7GzRr+yg
 o3NBWs4bQg53h1lCkqFVhNzDENUQe8L+Z60qaxDaZ4x2iN+PXeBoYdHKq/hRwY1Zob3QgJh1Ay9
 gVb4eLE3wgTe5Jyaasr6FNslM/JbUuvvKFNoISuVQBQ3h4ha15fAxd/dHp7CNYKD8X/CQlxJu2o
 f+vP/wobnmiVhQlW7/UZTjYNBRQGw/tUH5jORrc8IPBQXhW4r2UOwiJS5Tj5g2mYp4S0HrCpEk5
 nI8589v0My9ltut7qgswLquIygRrlyRhSa8v9Q0019AXuM6TFIKKMtVaCsLuFkSFmE7od5S6WF7
 4pbw16h5Eqn2fPsE0JDjExe1ABc1LON3jIvSALUe/Jp27/mhYDc7HegcCHixAEuZleRRgh8VvWp
 HuFOYwEkAWANw/U3tMX0hCg2V/2CzVjSVx4VgUkc06JuRhc9kfkShaPUGZJp9YRZRvF2fHQJnjt
 ASBzvBuROqnNLsYO62A==
X-Proofpoint-GUID: MWIOG3Z2sc3favu2TuCW7zxxHRYvK0ul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 48FA443E88
X-Spamd-Bar: -----
Message-ID-Hash: OQTFIM5BDAAA6GAS3DRGUOBBAXBX2QXT
X-Message-ID-Hash: OQTFIM5BDAAA6GAS3DRGUOBBAXBX2QXT
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OQTFIM5BDAAA6GAS3DRGUOBBAXBX2QXT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

This series adds an RPMI backend to the OP-TEE driver for RISC-V.
It builds on the separately posted RPMI TEE transport series [1],
which provides service discovery, synchronous calls, memory parcels
and asynchronous signals.

This revision is effectively a full rewrite of the original RFC.
The generic RPMI transport has been separated from the OP-TEE backend,
and the backend has been reworked around the service bus and a new
OP-TEE control ABI.

Unlike v1, the OP-TEE backend no longer manages SBI MPXY mailbox
channels or implements RPMI TEE service-group operations directly.
It binds to the OP-TEE service UUID on the RPMI TEE bus and uses the
transport's public operations. No additional OP-TEE device-tree node
is required.

The backend reuses the common OP-TEE session, shared-memory, argument
cache, call queue and RPC infrastructure. Shared memory is represented
by RPMI parcel IDs and nonces. Yielding calls pass command and RPC
buffer ranges within a parcel and resume suspended execution using
an opaque token returned by OP-TEE.

The OP-TEE control ABI uses fixed-width little-endian messages carried
in TEE_CALL payloads rather than reproducing FF-A's register-based
message layout. Asynchronous notifications use an allocated TEE-to-REE
signal as a bottom-half doorbell, while ordinary logical notifications
continue through the common RPC path.

Matching OP-TEE OS support for this ABI has not yet been implemented.
This remains an RFC for review of the backend integration and the
Linux-to-OP-TEE protocol.

[1] RPMI TEE transport dependency:
https://lore.kernel.org/op-tee/20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com/

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
Changes in v2:
- Effectively rewrite the backend around the separately posted RPMI
  TEE transport and a new OP-TEE control ABI.
- Remove backend-owned per-hart mailbox channels and the OP-TEE-specific
  device-tree binding.
- Replace the register-like control payload with fixed-width messages,
  explicit command/RPC buffer ranges and opaque resume tokens.
- Add a parcel-reference parameter layout carrying the parcel ID,
  nonce, and 64-bit offset and size without changing parameter size.
- Make argument-offset support part of the baseline ABI and retain
  the common shared argument cache.
- Use a transport-allocated signal for asynchronous bottom-half
  notifications.
- Link to v1: https://lore.kernel.org/r/20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com

---
Amirreza Zarrabi (8):
      tee: optee: allow RPMI transport builds on RISC-V
      tee: optee: define the RPMI control and parcel-reference ABI
      tee: optee: add RPMI shared-memory and parameter support
      tee: optee: add RPMI dynamic shared-memory pool
      tee: optee: add RPMI RPC handling
      tee: optee: execute yielding RPMI calls
      tee: optee: bind RPMI services and negotiate backend capabilities
      tee: optee: support RPMI asynchronous notification doorbells

 drivers/tee/Kconfig               |    3 +-
 drivers/tee/optee/Kconfig         |    3 +-
 drivers/tee/optee/Makefile        |    1 +
 drivers/tee/optee/call.c          |    2 +
 drivers/tee/optee/core.c          |   10 +-
 drivers/tee/optee/optee_msg.h     |   38 +-
 drivers/tee/optee/optee_private.h |   54 +-
 drivers/tee/optee/optee_rpmi.h    |  234 ++++++++
 drivers/tee/optee/rpmi_abi.c      | 1059 +++++++++++++++++++++++++++++++++++++
 9 files changed, 1389 insertions(+), 15 deletions(-)
---
base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
change-id: 20260912-rpmi-tee-service-grp-dev-b2ce2f63e0df

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

