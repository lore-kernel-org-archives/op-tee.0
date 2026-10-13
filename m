Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3EBCC6B09
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:42:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E843C4529D
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870130;
	bh=GmyzzdSR34wcKZ7wk84YNudIPZ2Gqjk5ieu6wm2qqMw=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=cQXg3Phv6aDp5bjGrlHRlrZXssOq6sFAYIw6kMV5j1/cfL8H2myH18izez9Sg3Sbj
	 SosQ+feLQBD7ZSvO5t+iBj5z2B7EdKontkN38H2PgBomecLmPdLrbPgGRJoMhDH4uR
	 Og3qKJEzP4CnQ7I15mM9XbpDcXxyiE0YsC02pxXwsvY4HSw5HcaGzu05E252XsC/2a
	 YNEm0KIUblbsawNxMZqPvKJvM+0UFyh8DsP/BoWq/mFUoERMFpXtJx9d6qE/TG+DdT
	 ppW/ASLLPULP2cywSuwARZZ4HVaIE50++N2nhKi0eoaotk6yCacXtyQ4CtyKeX5D6f
	 KqVW96YANak6A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E390144FBD
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gqdYoTgZ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BEFBAjij;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D20e4X922856
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=fywdYSI+QwC3MxSFOMdWKg
	lnBFD0ZX+8NEQ03S4/7tA=; b=gqdYoTgZGf5IjK5iUfVOUexRw3UKrGN6us/1gm
	IUlMQFYerLX4BtF5n2YMb0M+BsEwQClp+WuY4ZdGO7R0Y5IP3RVhp40sLp9TaZhz
	LAjwZFPF6d3iXQQo+5QJhXP3EjSm0hfTOeqkB3Ehj4ShFIg9l90tastmJb2XH5rv
	6IUfqXw2aMg3i1BdCF6pVYT5M0hLNFU1QAizwO5B9ZSTx5muoM9yBDXnQEn4+dN3
	Sa8+oQQLZatkaJ8cj6SWUBSIImg4JPKhb7z7wLIbuXBNlF8s5rVuJD2De/rNrvJl
	RXvh+t7XP+1cZXsmbOvDaK0AV+StZe6FcD2CrAM8dJQzmO7A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1s8v2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a8af172664so2042122a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870107; x=1792474907; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fywdYSI+QwC3MxSFOMdWKglnBFD0ZX+8NEQ03S4/7tA=;
        b=BEFBAjijWww0FVXpEo5ip37OxCz7T1VqkJ5jOuSOVAA/6Iwm2rQtnVttlquApH6ki7
         aFU+zf/oc/gkiWJir6zawS3PWaY+e2C6rmiK2KTTRZZyYUovrCkNqQnEx6gvojVQUb1z
         s5zuHgjTRIQIjh2JXbqIfz6tNodL5+EiHM+XBDKfZqM3O75JylBJT8GJpFtMuNbBzNxr
         WJhmryVnltXSGuvdBc0XxfScnMGrJoSes3R8chc3ABZO1O0mm21katGcEAcGMnGJ5kdC
         UStspQb6X0HlEBn78+gQQb69U3sbNzbGx7luUGJ/4WH1I7+O2dnubXjLvGjEhkUgErb3
         6lYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870107; x=1792474907;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fywdYSI+QwC3MxSFOMdWKglnBFD0ZX+8NEQ03S4/7tA=;
        b=WVy2iXUk7Z1pwihErFU7BSTcJFhw1CuTqGeWECwL0dU4jGRrLWdvfXXuQ88k1WOT2P
         eTNE6tJgZxb/skiBBijqBIyoylDBmvazEZnxNi6YR1GHSf5miNlmLuuAlL86VY83Liex
         777VM76HOeQn/wGKxFT1WEwt/D34Ho8JliaLe0JiCvKzCLkAit7wSCAeJPKaKU+TV+rd
         Oj5qdkvQd1HFXc+C9gBb+SzTpFnE70H5ZKxBGk7ZztkQlCtxbbwezblIXcie4QjQl/JX
         shsVKrKW10hvmyud1Mh8SqiqQkRJlUqVIuKCVnI55bdF/rbpxY8hX9+2qVf95SuhwbXh
         iQJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNQymnfhnroViZhUBbEAr9u4LiRUMAin/SYDKV5XZAD/OHarIZZqeQfrGzJ6KyytkwCphBko0=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJFhaMNrrWWDPvHhMGmMF/TNxYvwuHPsN07ncddmioOjgU8DWaW
	M2nSdbKh3/JaUWsFpPjwiodZuvDF0gVwEZNQpuZdvIiNjY2vCY+GMAwKB6dMGJoPnQDw2Og2S8C
	LJui1KA5crwONuPfQYtgb0BsM3fQmNU7d7jnL29xRaIs0oZGlky13bjrsQ7UY5+JCXDl/OSM=
X-Gm-Gg: AYBFou2JvLjBeozWth12NW9g5zZFelGJfKnS5Vm+Y+utTBI1hqmaFYIXWEJhHlittVm
	/69o6rmnRsmnH/nCuba5WXsnnABtvtghlUpDc8HsxQlycBwncY9Z9MG5P59HtvUccIo/4LhLKVF
	FmSW3pRL7jhIRXV7HsdytHSWqy8N+wgFd46SkzXJU7gZThEwG+kKPHaxuxFNf3YMgOgYVQN4nRc
	Bs6MnpGdxm4SWDcQiNntotsWWwYx6ENHpcxlPlBzy2W9MYYUYN2kpBANXV9Wa5rMkmh3npDWfRH
	bOj+1sqg/jFnswOB7nZxeM7XioSJNHeiHmxlWEtB8tEKny98HhPHOMPaJauxqNA1dIz0EoCgd2q
	rqXHs1q0t6n0C76+uN8s4OgHirqsnU/6lqvGn8BMZ7EpVVBDGTqt5ZPbp+A==
X-Received: by 2002:a17:90b:28ce:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3ab3a79df67mr9708193a91.29.1791870106689;
        Mon, 12 Oct 2026 22:41:46 -0700 (PDT)
X-Received: by 2002:a17:90b:28ce:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3ab3a79df67mr9708173a91.29.1791870106161;
        Mon, 12 Oct 2026 22:41:46 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:41:44 -0700 (PDT)
Subject: [PATCH RFC v3 0/9] tee: optee: add RPMI backend support on RISC-V
Date: Mon, 12 Oct 2026 22:41:27 -0700
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-0-975b574667e2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIfEzWoC/4XNwQrCMAwG4FeRns1oUzadJ0HwAbyKh9mmW8Gts
 51FGXt3Sw+eRC+BP+H/MrNA3lJgu9XMPEUbrBtSkOsVU10ztARWp8yQY8VrgeDH3sJEBKkYrSJ
 o/QiaIlxREZpKEteGpfroydhnps/sdDywS1p2NkzOv/K7KPLpvxwFcBBaaFkqbLZlvXchFPdHc
 1Ou74s0sh3x4wnOyx8eJm+DBhEJJSnxxVuW5Q12Ove/HAEAAA==
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdc49b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CKDX5oWuAds2uq8u-J8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: wc7oUlVcoYprbkBbebHoQXy56q9iOE24
X-Proofpoint-ORIG-GUID: wc7oUlVcoYprbkBbebHoQXy56q9iOE24
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX7n5SQc6E9UGR
 pp1uuKIj2jKtNKu90HoQJGH0c+rOdzG/Zn2TGcpo9PotAVh+7aqbCQXVg1THPk7t1Q7koWUxk2J
 SGQLuYFZlfOB75yDBkGy1qCo/8J/Q1s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX7svs1hUdNUpF
 JV9vqRmg0/Ih2BA7NX6+PjFUB3xBhO8QBlORST2ybTTL0xowgymkwatatgzx2KJSTqpc4xpX+6q
 fZu5PVVTk+wtQEOZ+qrT+Sl7Nzwbao5ApS4N8Cy4LujwM3L+RMQ/UMwWEvvjqEQ0Rrs7pr9mYoZ
 0ma2Lbqm62OJNwrwlgeDgru4ZthAYtn43TZewSBoGTtyf9Qmfd4YScel5zim9FCSrQRuSKwVlYy
 XYVJOfGozfKh702YNbDGr++wCXgy+BVwxqqfSmDUJv/6yR0zJzasoYR0Vo2v/bm2xHx/CzORtUy
 qyKpHRBPZZuUR5OkOt+D4HhWGPIL6IlRvDQR8l0wYrPcxi70C/3FHsF9tgau/WtX5QNT2WnofcE
 Ui4ApGjl9yfoEFk30O0RMigFSLU6idvvTGELofOgf0k1KP5B6tFBzwTq8hnSjWTiM9gHexlWxtW
 6hr/monP8mVI+NhPMww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E390144FBD
X-Spamd-Bar: -----
Message-ID-Hash: YQIPFG65UB6ZHZAGZPUHYXST4GO44JIQ
X-Message-ID-Hash: YQIPFG65UB6ZHZAGZPUHYXST4GO44JIQ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YQIPFG65UB6ZHZAGZPUHYXST4GO44JIQ/>
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

Matching OP-TEE OS support has been implemented locally. OpenSBI
integration and end-to-end validation remain pending. This remains an
RFC for review of the backend integration and Linux-to-OP-TEE protocol.

This series depends on:

- The RPMI TEE transport series [1].
- The OP-TEE notification bitmap fix, which allocates space for the
  inclusive maximum notification key [2].

[1] https://lore.kernel.org/op-tee/20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com/
[2] https://lore.kernel.org/op-tee/20261009-fix-tee-max-keys-v1-1-1462d96bf438@oss.qualcomm.com/

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
Changes in v3:
- Use GlobalPlatform TEE result codes for OP-TEE control responses,
  keeping them separate from RPMI transport errors.
- Combine the parcel ID and nonce into a single 64-bit global_id.
- Make resume tokens opaque 32-bit values and track initial versus
  resumed calls separately.
- Remove unnecessary __packed annotations from the OP-TEE ABI structures.
- Share the global-ID-to-SHM mapping implementation between the FF-A
  and RPMI backends.
- Replace the fixed SHM nonce with a per-instance IDA allocator; reuse
  nonces after successful reclamation.
- Report the maximum notification key instead of a notification count,
  and use the negotiated maximum during initialization.
- Consume capability-exchange results during probe.
- Remove cleanup macros and use explicit resource-management paths.
- Use rc consistently for Linux error returns.
- Replace unnecessary unaligned accesses with endian conversions for
  naturally aligned ABI fields.
- Link to v2: https://lore.kernel.org/r/20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com

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
Amirreza Zarrabi (9):
      tee: optee: share the global shared-memory ID mapping
      tee: optee: allow RPMI transport builds on RISC-V
      tee: optee: define the RPMI control and parcel-reference ABI
      tee: optee: add RPMI shared-memory and parameter support
      tee: optee: add RPMI dynamic shared-memory pool
      tee: optee: add RPMI RPC handling
      tee: optee: execute yielding RPMI calls
      tee: optee: bind RPMI services and negotiate backend capabilities
      tee: optee: support RPMI asynchronous notification doorbells

 drivers/tee/Kconfig                |   3 +-
 drivers/tee/optee/Kconfig          |   3 +-
 drivers/tee/optee/Makefile         |   2 +
 drivers/tee/optee/call.c           |   2 +
 drivers/tee/optee/core.c           |  10 +-
 drivers/tee/optee/ffa_abi.c        | 133 +----
 drivers/tee/optee/optee_msg.h      |  23 +-
 drivers/tee/optee/optee_private.h  |  73 ++-
 drivers/tee/optee/optee_rpmi.h     | 263 ++++++++++
 drivers/tee/optee/rpmi_abi.c       | 972 +++++++++++++++++++++++++++++++++++++
 drivers/tee/optee/shm_handle_map.c | 138 ++++++
 11 files changed, 1498 insertions(+), 124 deletions(-)
---
base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
change-id: 20260912-rpmi-tee-service-grp-dev-b2ce2f63e0df

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

