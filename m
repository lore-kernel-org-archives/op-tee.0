Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7982CA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:28:53 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D7AB4454BC
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430133;
	bh=yiJw88o1NE33K/+V3e5PZxRTllIkYcC4XKkFJ47QaEY=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=hreZbj1z34Tr8PHwPzme8m96Y4owgM3PLsZAHOVwIWNEB4Kegta9CrW8afT7WOC6w
	 /sJQffnha9OLCqwU+h81j+UcU7YNphqlikCTAYkVAGOk4qI1MSmDhj1Q4kYLCnCx9D
	 k7lCeQlUmxtLpXRC7S9COFMJJqt0GuymbtOSCpRp1azTCJFE+0WLfrDuFYKWLqv17D
	 9GQag9mEyVETmD35DH7cR3Pjx+Goh8hhqOLbn5cQzCDmnWd0SCqU2YBjFZ6NuMvcud
	 hFrrXHyB7ZsR0kmirZ2GBRvz+ARY1hkPTpQDbDJBY8jtfJHX7jGFnJmjal6p1hDHmD
	 joAIrrRGZ57EQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1F79D44B0E
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fts2kROd;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UxG86n+R;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hvfT608354
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5gK0vuRBFrk8vBpkM5BWnX
	DfFggS1T8IA5KrEN635M0=; b=Fts2kROdMYAjKia4zIi+65KIR+xMwC/gZ2eHfi
	O9RJxWbpfJ9U8+9BCAXzJ1ga63zNX8sU2bMKEaax8gVFIaOHI48MAI0PXYvaRotg
	cmrnlMS9Mb4XWw5dRcdOoD5SyuISsSToYPoLpqWIIDeXNFRIWYvf8WP0QgbNDkLN
	1fxqS5a3Sxt5iSdxFuBmfwZT09qyDiNM2ZNTPeqqL853tRz4IOB1x66NWfuU0NUY
	Rqt7A2amwKCj2ITPgsi2IW/38kXz+g+egW+dyExpVlq/wBcVnpAk0BXpyxyVkku+
	LovvrEEN6jX2AezxcfK3WmFFXFV4tX+P6FUYgSTE8C9587sw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2rwp7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso9286741eec.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430122; x=1792034922; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5gK0vuRBFrk8vBpkM5BWnXDfFggS1T8IA5KrEN635M0=;
        b=UxG86n+REBAIG94wzQC4TKG6lMVDaRZw1AGU/euiUdMwC+4f9JCiV6O57oCbzUEohj
         wqro5GdP6TvKEIYJQFDBmik0Us5brqRXfkJX0r2SiKjNq5rGJI5ieQEGxqnZ4TZzh2GO
         SUWYVB/IAm0fqG7/gRJiYBn1zxcwG719H73MiTYDxWXGOkGKnuzOOMA0lw3gHOVkDwXj
         7nJIE+L9+zTGliCY9Pwx0viuBkM0sZy3MKm3GWIYphVdiT3/ktxJfnDJnsuBF367fNjc
         l+7FANQ+MNjpanYO0C2M60F81YTTco53QWjE+BRTMqLvmYuX/+iS5iHhrV3K594tBnlE
         9log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430122; x=1792034922;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5gK0vuRBFrk8vBpkM5BWnXDfFggS1T8IA5KrEN635M0=;
        b=1/LpXtDFW1NVAtAjEDuhuW2b5wBkIhT6ne3BgGNtmuFR53qaOuoUKXxLtVQ8TfQZsN
         SivvmeZz7lcRooqSFNHoaQRhujBmJMjr8AdA3zpyZXRG9IcaK1YDIIiZ7R+C3CKQSG/M
         ZxuA60M7MSgpZ4lI45qrnlF8qFt8yKxz6CURXiBHzs04Hz19ajq4Wjui13+USFujKYtH
         xHGALqqfTeBNfDBhGiek+z2MFDbpsIh2QaA47I3ejvMmshcR+++LqHced0svttcY/EyG
         nIvuf+SoJ2nBOWD7c8GHdOtWxKYb9j33gFhcCN/UV/qmMAc4hE6PRWKmxfevvD8ZVLzU
         7cEA==
X-Forwarded-Encrypted: i=1; AKwUvBy1K6hyHD5Zm5yzasl9dSP/urSMVksNq4oABaY6S8yfMfr/q2u0r4Yzr30FDnK2YVPwF3OcCLk=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKDzulTbNZYvmwTmLTbwnUyUMZn/5a/suP5EPrZW10jAS9++MGA
	QNXrtBKaS6o+OCjQgwlfllDva/gCQlncoR4tBMkEUif99sqrG0rgsrdfNdXF93eDNSEY3jMBQ59
	s/nJOT9rhM3vTWEutNr2+wMe+1v7/66URNZeMhoje/1Zz3OKd3dWHrh9Om84/KE9lXsCiDJM=
X-Gm-Gg: AYBFou2ILDudMQwaro24jiSj8SLJM4xpW8mqMO5MoiH6LEb/iH2QiXorBZsuPCrFY8U
	XY3e3J4L9zwklRikZjSBj/zRKkTUsWSWE1XDEi70cJC5EKof3l0IoSSK4Q4mMJfcHilQi7Q3s19
	s0dWvWBLR4ACLHgDnNdK2in5njwxIuLwPbgRyK6ksVkxvMeyNR6ylblnMHFSmwItKZu0IO2eKCf
	pKQAtdMeQmppuBC7WlGX3e9uhLo9UBBAza9av0iuz8wjKiqhZkr7B7hremaSFJ7zz86xmIWjGAb
	JtwcrlDrQJo75mkGUkWRATPxYLhxI5tBhboKpo4rhW4GUZxP29BK77cm85XGBXhnmWVhhMoxH/a
	p+gLkKLEjVhQXqunEeupPWQlF/N2inDZkVn6if4nCv1p+i8XEPNnhpumYJA==
X-Received: by 2002:a05:7301:700f:b0:350:869:d106 with SMTP id 5a478bee46e88-3515de5a743mr4808203eec.34.1791430121641;
        Wed, 07 Oct 2026 20:28:41 -0700 (PDT)
X-Received: by 2002:a05:7301:700f:b0:350:869:d106 with SMTP id 5a478bee46e88-3515de5a743mr4808156eec.34.1791430121023;
        Wed, 07 Oct 2026 20:28:41 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:40 -0700 (PDT)
Subject: [PATCH RFC v2 00/10] firmware: riscv: add RPMI TEE service group
 transport
Date: Wed, 07 Oct 2026 20:27:06 -0700
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIsNx2oC/32NwQrCMBBEf0X27JY0rSXxJAh+gFfpIW1Xu2Cbm
 q1BKf13Qz/Ay8CbYWYWEApMAsfdAoEiC/sxgd7voO3d+CDkLjFopStltcHA0kYM08A4E6FrGCt
 VkHVFUxbWQipOge782UZvcL2coU5mzzL78N2OYr5F/zZjjgpVaZVpTN4Zczh5kez1ds/WD0OWB
 Op1XX9lLf7dwAAAAA==
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX8vIQ/2/ZCg3N
 JF9o0TeHVUx2x49XkzRUOZtpNLEc/B6FiXciJKZ3tR/fpwATON6S8aCSdFf+eHbqaWTk4EYRVVA
 B57hfK+AD609fkdP8Xyi9SuPF9Hesds=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXzgKkVl8UP3zx
 LDtrt4Yp/Ml9n434Mit0ly2EtBAJUAU06Y/rs9AONW3ZBlPkzQ4WZxgAtEdIZQ9/PyWMEFKQLT6
 OlHE7X6Q7CkLZtbhga/tKogV35a9liraZOPu2ZDsftuLB+wA3F5Sj3kWCc0XqVv40wRkO9O1LvQ
 WelRGKMepdTGWt83mJkGEZplhZEmkCiyDxeWglsubEG4O9bZ8GRxG4hxhw1lFTwz6B5MIaBh/2r
 bJi2sEj/3/X0jBLGg/JDGeFk2wbrdnA5K2sazAeSVNbh4fd19Y/wuO/hcGm8mtmZGLFj97rQtfn
 SwV9LB5OFcwlPBFoMb9KVnsUnC3o1HlhEBOiK2TsADW5CTrujRYS3/Oq4YqIp9leoZ5ufV+licn
 VmLe+Dud5QiJUa2pqVBeQUA3YlQqAiWFijTN2YJ7hIS4QSFi/DRG19S2tmI98vSPgkeYUNe/hMU
 e94u+AHhJoQdjsdTBCQ==
X-Proofpoint-ORIG-GUID: EnJus0K0AWkgva2PYRsHomxiYjrrgv0K
X-Proofpoint-GUID: EnJus0K0AWkgva2PYRsHomxiYjrrgv0K
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac70dea cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=V1jnuoLLAAAA:20 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=hZ86olN1w1Q2TqJtmf8A:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org,oss.nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1F79D44B0E
X-Spamd-Bar: ---
Message-ID-Hash: 457YGHR2HIF7YDNOAE4TEKYTOLPXLBSF
X-Message-ID-Hash: 457YGHR2HIF7YDNOAE4TEKYTOLPXLBSF
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/457YGHR2HIF7YDNOAE4TEKYTOLPXLBSF/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

This RFC series adds the RISC-V RPMI TEE service group transport [1],
which provides RISC-V systems a mechanism for Linux to communicate
with TEE endpoints. Linux and a TEE act as endpoints of the RPMI TEE
service group, while the RPMI framework in machine-mode firmware
mediates communication between them over an SBI MPXY [2] mailbox
channel.

The series is layered as follows:

 - Two mailbox patches add a direct synchronous send mode
   (mbox_send_message_sync()) and its implementation for RPMI MPXY
   channels, needed because RPMI TEE requests must complete
   synchronously in the calling context.

 - The RPMI TEE bus registers one device per discovered TEE endpoint
   and service UUID pair, following the device-per-service model,
   so individual service drivers can bind independently.

 - The RPMI TEE transport core binds to the mailbox channel and
   validates the RPMI and TEE service-group versions before any
   discovery or service traffic is attempted.

 - Discovery uses PROBE_SYSTEM, PROBE_DOMAIN and PROBE_ENDPOINT to
   obtain the local endpoint identity and enumerate physical TEE
   endpoints and their services.

 - Memory parcel operations (lend, share, reclaim) let a consumer
   driver share memory with a TEE endpoint. Linux creates a parcel and
   the parcel identifier is then used by the consumer's own protocol to
   refer to that memory.

 - Signal buses let a consumer driver exchange asynchronous
   notifications with its TEE endpoint in both directions.

This series only establishes the transport, bus, and discovery layer.
An OP-TEE backend using these interfaces has been posted as a separate
series [3].

Feedback on the overall architecture, the bus/device model, and the
memory-parcel and signal-bus abstractions is especially welcome at
this stage in this RFC series.

[1] https://github.com/riscv-non-isa/riscv-rpmi/commits/main/src/srvgrp-tee.adoc
[2] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
[3] https://lore.kernel.org/op-tee/20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
Changes in v2:
- Fix memory-block address encoding to preserve the full physical address.
- Report the blocks included in the initial segmented CREATE request,
  rather than the total parcel block count.
- Correct the CREATE block-count documentation and remove an unused
  include.
- Stop signal retrieval during shutdown so continuously arriving signals
  cannot prevent the notification workqueue from draining.
- Drain notification callbacks before unregistering child devices, including
  on partial registration failure. Keep the mailbox and signal buses
  available until client removal completes.
- Allocate signal-bus state before firmware setup and use automatic
  cleanup on setup failure.
- Skip disabled System-MSI nodes when locating the notification IRQ
  controller.
- Add rpmi_tee_info_ops.msg_limits_get() to expose maximum TEE_CALL
  request and response payload sizes, excluding transport headers.
- Cache TEE_CALL payload limits during transport initialization and reuse
  them for capability reporting and call bounds checking.
- Include missing <linux/idr.h> for the RPMI TEE bus's IDA APIs.
- Replace SYSINFO descriptor-table discovery with PROBE_SYSTEM,
  PROBE_DOMAIN and PROBE_ENDPOINT, and update service and feature
  identifiers to match the revised RPMI TEE specification.
- Move discovery into discovery.c and shared internal declarations into
  rpmi_tee_private.h.
- Store discovered endpoints and their service UUIDs in per-endpoint list
  entries, avoiding array reallocations.
- Link to v1: https://lore.kernel.org/r/20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com

---
Amirreza Zarrabi (10):
      mailbox: add direct synchronous send support
      mailbox: mpxy: add direct synchronous send
      firmware: add RPMI TEE bus support
      dt-bindings: firmware: add RISC-V RPMI TEE transport
      firmware: add RPMI TEE transport core
      firmware: riscv: rpmi-tee: discover TEE endpoints
      firmware: riscv: rpmi-tee: register TEE services and support calls
      firmware: riscv: rpmi-tee: cache TEE capabilities
      firmware: riscv: rpmi-tee: add memory parcel operations
      firmware: riscv: rpmi-tee: add signal bus support

 .../bindings/firmware/riscv,rpmi-tee.yaml          |   35 +
 drivers/firmware/Kconfig                           |    2 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/riscv_rpmi_tee/Kconfig            |    8 +
 drivers/firmware/riscv_rpmi_tee/Makefile           |    8 +
 drivers/firmware/riscv_rpmi_tee/bus.c              |  202 +++
 drivers/firmware/riscv_rpmi_tee/discovery.c        |  383 +++++
 drivers/firmware/riscv_rpmi_tee/driver.c           | 1583 ++++++++++++++++++++
 drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h |  128 ++
 drivers/mailbox/mailbox.c                          |   72 +-
 drivers/mailbox/riscv-sbi-mpxy-mbox.c              |  196 ++-
 include/linux/mailbox/riscv-rpmi-message.h         |   13 +
 include/linux/mailbox_client.h                     |    3 +
 include/linux/mailbox_controller.h                 |   10 +
 include/linux/rpmi_tee.h                           |  200 +++
 15 files changed, 2772 insertions(+), 72 deletions(-)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260928-riscv-rpmi-tee-abi-603e9a3b4399

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

