Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CACA5FFD
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:30:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E74644552C
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430226;
	bh=dnckaR0v71Tx8067GfmIzLeziZO+82RiCABdwVnTd0U=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=0U4Ya9NSmp/R3yiLAPJvU764Q0cBzZ72Sin5tqV/mPBRfxI9xpJ86uM0pYsSwFInD
	 MqHb/9iir+5JewwcG58pKohWcj7F805elkz/h2APQp3rvILGLVfkiWo/N8NJ7KIhTC
	 DL6jYvkpXrDjYH2JkWG8ym5Phlg0vXN9IaTu5R7zHybscETbauDhzFuiZLTUftjfPr
	 jcnGIMH+HX3Cb67HqJ3bxkAr4FSXk5suEp1QN7Zj4vw6w+ynGGqTmqPUNvgKtVzPqG
	 WtMhozUQR5Qu043OZyllHRln0bL9RjV2eibREtNNDJcp+PpgtEliHV9t9Zx3NgW7xN
	 ugiXNFrT/uZdA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B0C684546A
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OfiZ+NAN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MZH7j8YK;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hLhQ607428
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3LlMYlWp2TcEmoujTF0c+B3OZcUutnCnpZb9I2TwtLU=; b=OfiZ+NANuOKh9WeD
	I3/zjfKcmSx1bArA9JF5tF0CapDuohhOzwM8GMBUPChXeCidQMlxo9SETKuGll3e
	JOG8TU3QCGmDSIlhT97CiMcZSXzhL/qRFNCHlFAWWWgolBuHSHJtVdIWr9aLDyie
	UocvmYJ7Be9Z2FcOWBA2QiEB4INfo9APrMq9Tev+iS+Gf+y5rKLemX6zbnzP0Lmp
	zY/IXRzPzp6xhJrJzdbpKubThvQ4G8XrNuzfTSEKTtmcGZfyYE9fe9q9XuDPbmdr
	5yae59b6jT0ZXFEF2M3xKVFk+1MMbkLleTfSrhFS1gypICSgFdbSnCZ/8KBJe1JS
	NFsWkw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2rwpg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3510a481ae9so9279740eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430126; x=1792034926; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LlMYlWp2TcEmoujTF0c+B3OZcUutnCnpZb9I2TwtLU=;
        b=MZH7j8YKi7X2E3isErIx5M4UWfUuWC423pFqwGBk3rIOh5rpQBDauCFZH9ExcBVaDG
         6ZLzB1iMSBS4ZXgqbg2Wiw79N3jHQrLHu07kH8MMRnb+KudHQmAqUaZVOiGMWdjLLuGC
         P4eWF1sM8QOlbxKwdvo32IxEUSrCHADSbDEhrWTwIX/RxDdhjIk5uHIVYZYkPA8zkv4l
         10wSGrsCyalbVY+5mITIYe4JSHl3QEpApqjADLZ2BYXtL5D6S6/VH3xjSIdMchRdBfr0
         yd9hzv34JMjpH5hGkV4Kltfeb0jngUsMrx649POHUhvmJNaUYYKxBA+SagO2NIyiKqbg
         fJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430126; x=1792034926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3LlMYlWp2TcEmoujTF0c+B3OZcUutnCnpZb9I2TwtLU=;
        b=Dd5u+Ce3qYmAgplENuv+aVYTAbdOEbsbu+534z3Up/9HFXla4u+RcsTawPVrQ+WgcS
         42mu5mTbnptsg6wl2JL3v30y+CfaWO74wydHD6cWmBC3K9HCbOnRTSo2im3Oem18C/3z
         DPAboHCiVh6dkwLQO6ix6yxKY8oTcsSjEsH0Q4bO0Huf+k9lJoT8hHIqN+oM3bPW+imM
         XMLxiFDKAE0fL052MpOsZPeN+AWRNZMMq0RQ4g1nqiKMNxG2O9b7zB2/mlBJzQB3jx3t
         +nK2/rnD+zW0GcC2qxxWMF9mSBlh4E535vWgXUGxLEJ6UWmMnHokY+v+cPLP4Yr2n24Q
         lx7g==
X-Forwarded-Encrypted: i=1; AKwUvByc//kSQ+7UOh+p6d8ZV6X3wGwA1+XRHrnShBxU02Ierj9aBetuBlRV8VnY4TeOyNx6SSBbjaI=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++ldNuD4DMcLCwdSzP4zYHmOSNxJCoYdEn/JCHCOXmyH2VJdDpHs
	5d0DwZphP5zIYJOBDE22L77H23Nfz1ELYINhjMkcHK+L3UbRg7bvR11enHiC1G9bX1RjPbc29wJ
	bbf25NtU0MSfmQmu/j6R16BLFobrtmTDdvlH1F8SVLv1IS1zT7kzLUE90xO6RahHoeYR1hcQ=
X-Gm-Gg: AYBFou3ykc7WDrdtFpNHC4WqDeK/bnZVDgJyq8YCsUwBmGQRICDx4Aep7vHGowwxsJJ
	fRm+cfznBK6Km4y8xFXWTQlGo/ijy/kKvqjQ8YvfrpdVqZAreKVCqg7pQOn0n3FeCLnz2XMEZZB
	PANYeX24vFClcNq6jYsO07Dr4fihGtlwyOOL+oqCSv4P4ttcs9KPAamK2BJOPGgHmZvX4+QpCDO
	SwKYTPXkVdlrjckDaWz9QrwOLvmEr12oEjLG1KpAM59HS7YIO81Bh6J9p52s9aGLM3nDbbsIa8U
	eTSCOhUFILA8Hkhkao+otI9fvrauLJ/aDGJ3hXcvgd6SmuBeydx4tJGJBVBIopeXBQD8YPMPpuW
	ilv4s/66zMTY13OPoMkZugzpwFZIj4Luixj+bMBZPWXINkZ1tw9Wb5Qeo0w==
X-Received: by 2002:a05:7300:6ca1:b0:351:4d2d:af26 with SMTP id 5a478bee46e88-3515d86f0aemr7081116eec.2.1791430125603;
        Wed, 07 Oct 2026 20:28:45 -0700 (PDT)
X-Received: by 2002:a05:7300:6ca1:b0:351:4d2d:af26 with SMTP id 5a478bee46e88-3515d86f0aemr7081071eec.2.1791430125002;
        Wed, 07 Oct 2026 20:28:45 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:44 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:09 -0700
Subject: [PATCH RFC v2 03/10] firmware: add RPMI TEE bus support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-3-45939a13d223@oss.qualcomm.com>
References: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
In-Reply-To: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX3AS3HS1W7t8s
 fwkoL/iC5c40w0bqxGE+1dY/Gb7kB8NOiSQSO4WbZv40jUmCIL4o6wmZdBdPqTNDdMKH7JwEGbI
 pap+0vYHO0iRVWTyAMII6Sg0vTCFjT4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXwbVmo8bwvojN
 6KM7+gguy3+6teoAUhCb8NfMUIJcDsm31AZpI4SQDbpy82QRNVT6Q4PymQFPo5e6iHg9M5jmvND
 c8ORu0TLXtk/+R2DJal+FCSaZwZJ5i+9l8c5kTATxonwjKVWYOLD444q9XA1NUPLbopxb/UDT/Z
 VsvZSQMrPs3GMWhzNUSVR/Bnr5ioHp7dP4LIuNu3PLYwfLW1K8q2isqyS5asHpcL0r0jHWEjztG
 G783W0UzOTovrpQM9rrFP2hE1Mk6/+5AVzHQtcVjNm6kW9Yifi034iwGmXcP/QGA+A8txXYsyva
 3fOV3pkD4R3p+cr06iqFWIW4vJv+ARCAzFwM2MJIXm24FcjokJEovOBdRcbINxoOskUzuUZJK3J
 0MytcXP336LBWdbKDdhV1H9JNB0Q74/39Mc+iesnVXEzG6MThHfBhnE3AgaTZztGXDmRKuSYgzJ
 WtbsapcPq2+LyQs7fNA==
X-Proofpoint-ORIG-GUID: fmMWSdD-f9-uBWWpZVebnoXkfCmHL1NV
X-Proofpoint-GUID: fmMWSdD-f9-uBWWpZVebnoXkfCmHL1NV
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac70dee cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=IHj7fnvydjjLQZ3tJQkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
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
	BAYES_HAM(-3.00)[100.00%];
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
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B0C684546A
X-Spamd-Bar: ---
Message-ID-Hash: KCQFFIUMNCC7OAK35V5TLFA6TZSIG6BV
X-Message-ID-Hash: KCQFFIUMNCC7OAK35V5TLFA6TZSIG6BV
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KCQFFIUMNCC7OAK35V5TLFA6TZSIG6BV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

RPMI TEE endpoints can provide multiple services identified by UUID.
Add a service bus so consumer drivers can bind to these services
without depending on the underlying mailbox transport.

Introduce device and driver registration interfaces with UUID-based
matching. Represent each endpoint and service UUID pair as a device
with a unique name.

Expose the endpoint ID, service UUID and modalias through sysfs, and
provide modalias uevents for consumer modules with matching aliases.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/Kconfig                 |   2 +
 drivers/firmware/Makefile                |   1 +
 drivers/firmware/riscv_rpmi_tee/Kconfig  |   8 ++
 drivers/firmware/riscv_rpmi_tee/Makefile |   5 +
 drivers/firmware/riscv_rpmi_tee/bus.c    | 202 +++++++++++++++++++++++++++++++
 include/linux/rpmi_tee.h                 |  83 +++++++++++++
 6 files changed, 301 insertions(+)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index c183d98c1e8f..46297332288f 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -6,6 +6,8 @@
 
 menu "Firmware Drivers"
 
+source "drivers/firmware/riscv_rpmi_tee/Kconfig"
+
 source "drivers/firmware/arm_scmi/Kconfig"
 
 config ARM_SCPI_PROTOCOL
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index a855d3696173..772fe024baab 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_TURRIS_MOX_RWTM)	+= turris-mox-rwtm.o
 
 obj-y				+= arm_ffa/
 obj-y				+= arm_scmi/
+obj-y				+= riscv_rpmi_tee/
 obj-y				+= broadcom/
 obj-y				+= cirrus/
 obj-y				+= meson/
diff --git a/drivers/firmware/riscv_rpmi_tee/Kconfig b/drivers/firmware/riscv_rpmi_tee/Kconfig
new file mode 100644
index 000000000000..b0396183b87d
--- /dev/null
+++ b/drivers/firmware/riscv_rpmi_tee/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config RISCV_RPMI_TEE_TRANSPORT
+	tristate "RISC-V RPMI TEE service group transport"
+	depends on RISCV && OF && RISCV_SBI_MPXY_MBOX
+	help
+	  Say Y or M here to enable the transport for services provided by the
+	  RISC-V RPMI TEE service group.
diff --git a/drivers/firmware/riscv_rpmi_tee/Makefile b/drivers/firmware/riscv_rpmi_tee/Makefile
new file mode 100644
index 000000000000..d80ab5bc9dc4
--- /dev/null
+++ b/drivers/firmware/riscv_rpmi_tee/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+rpmi-tee-bus-y = bus.o
+rpmi-tee-core-objs := $(rpmi-tee-bus-y)
+obj-$(CONFIG_RISCV_RPMI_TEE_TRANSPORT) = rpmi-tee-core.o
diff --git a/drivers/firmware/riscv_rpmi_tee/bus.c b/drivers/firmware/riscv_rpmi_tee/bus.c
new file mode 100644
index 000000000000..1393adda0d3a
--- /dev/null
+++ b/drivers/firmware/riscv_rpmi_tee/bus.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RISC-V RPMI TEE bus
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rpmi_tee.h>
+#include <linux/slab.h>
+
+#define RPMI_TEE_UEVENT_MODALIAS_FMT	"rpmi_tee:%pUb"
+
+static DEFINE_IDA(rpmi_tee_bus_id);
+
+static int rpmi_tee_device_match(struct device *dev,
+				 const struct device_driver *drv)
+{
+	const struct rpmi_tee_device_id *id_table;
+	struct rpmi_tee_device *rdev = to_rpmi_tee_dev(dev);
+
+	id_table = to_rpmi_tee_drv(drv)->id_table;
+	if (!id_table)
+		return 0;
+
+	while (!uuid_is_null(&id_table->uuid)) {
+		if (uuid_equal(&rdev->uuid, &id_table->uuid))
+			return 1;
+		id_table++;
+	}
+
+	return 0;
+}
+
+static int rpmi_tee_device_probe(struct device *dev)
+{
+	struct rpmi_tee_driver *rdrv = to_rpmi_tee_drv(dev->driver);
+
+	return rdrv->probe(to_rpmi_tee_dev(dev));
+}
+
+static void rpmi_tee_device_remove(struct device *dev)
+{
+	struct rpmi_tee_driver *rdrv = to_rpmi_tee_drv(dev->driver);
+
+	if (rdrv->remove)
+		rdrv->remove(to_rpmi_tee_dev(dev));
+}
+
+static int rpmi_tee_device_uevent(const struct device *dev,
+				  struct kobj_uevent_env *env)
+{
+	const struct rpmi_tee_device *rdev = to_rpmi_tee_dev(dev);
+
+	return add_uevent_var(env, "MODALIAS=" RPMI_TEE_UEVENT_MODALIAS_FMT,
+			      &rdev->uuid);
+}
+
+static ssize_t endpoint_id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct rpmi_tee_device *rdev = to_rpmi_tee_dev(dev);
+
+	return sysfs_emit(buf, "0x%x\n", rdev->endpoint_id);
+}
+static DEVICE_ATTR_RO(endpoint_id);
+
+static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct rpmi_tee_device *rdev = to_rpmi_tee_dev(dev);
+
+	return sysfs_emit(buf, "%pUb\n", &rdev->uuid);
+}
+static DEVICE_ATTR_RO(uuid);
+
+static ssize_t modalias_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct rpmi_tee_device *rdev = to_rpmi_tee_dev(dev);
+
+	return sysfs_emit(buf, RPMI_TEE_UEVENT_MODALIAS_FMT, &rdev->uuid);
+}
+static DEVICE_ATTR_RO(modalias);
+
+static struct attribute *rpmi_tee_device_attrs[] = {
+	&dev_attr_endpoint_id.attr,
+	&dev_attr_uuid.attr,
+	&dev_attr_modalias.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(rpmi_tee_device);
+
+const struct bus_type rpmi_tee_bus_type = {
+	.name		= "rpmi_tee",
+	.match		= rpmi_tee_device_match,
+	.probe		= rpmi_tee_device_probe,
+	.remove		= rpmi_tee_device_remove,
+	.uevent		= rpmi_tee_device_uevent,
+	.dev_groups	= rpmi_tee_device_groups,
+};
+EXPORT_SYMBOL_GPL(rpmi_tee_bus_type);
+
+int rpmi_tee_driver_register(struct rpmi_tee_driver *driver,
+			     struct module *owner, const char *mod_name)
+{
+	if (!driver->probe || !driver->id_table)
+		return -EINVAL;
+
+	driver->driver.bus = &rpmi_tee_bus_type;
+	driver->driver.name = driver->name;
+	driver->driver.owner = owner;
+	driver->driver.mod_name = mod_name;
+
+	return driver_register(&driver->driver);
+}
+EXPORT_SYMBOL_GPL(rpmi_tee_driver_register);
+
+void rpmi_tee_driver_unregister(struct rpmi_tee_driver *driver)
+{
+	driver_unregister(&driver->driver);
+}
+EXPORT_SYMBOL_GPL(rpmi_tee_driver_unregister);
+
+static void rpmi_tee_device_release(struct device *dev)
+{
+	struct rpmi_tee_device *rdev = to_rpmi_tee_dev(dev);
+
+	ida_free(&rpmi_tee_bus_id, rdev->id);
+	kfree(rdev);
+}
+
+struct rpmi_tee_device *
+rpmi_tee_device_register(const uuid_t *uuid, u32 endpoint_id,
+			 const struct rpmi_tee_ops *ops, struct device *parent)
+{
+	struct rpmi_tee_device *rdev;
+	int id;
+	int ret;
+
+	if (!uuid || !ops)
+		return ERR_PTR(-EINVAL);
+
+	id = ida_alloc_min(&rpmi_tee_bus_id, 1, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	rdev = kzalloc_obj(*rdev, GFP_KERNEL);
+	if (!rdev) {
+		ida_free(&rpmi_tee_bus_id, id);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rdev->dev.parent = parent;
+	rdev->dev.bus = &rpmi_tee_bus_type;
+	rdev->dev.release = rpmi_tee_device_release;
+	dev_set_name(&rdev->dev, "rpmi-tee-%d", id);
+
+	rdev->id = id;
+	rdev->endpoint_id = endpoint_id;
+	rdev->ops = ops;
+	uuid_copy(&rdev->uuid, uuid);
+
+	ret = device_register(&rdev->dev);
+	if (ret) {
+		put_device(&rdev->dev);
+		return ERR_PTR(ret);
+	}
+
+	return rdev;
+}
+EXPORT_SYMBOL_GPL(rpmi_tee_device_register);
+
+void rpmi_tee_device_unregister(struct rpmi_tee_device *rdev)
+{
+	if (rdev)
+		device_unregister(&rdev->dev);
+}
+EXPORT_SYMBOL_GPL(rpmi_tee_device_unregister);
+
+static int __init rpmi_tee_bus_init(void)
+{
+	return bus_register(&rpmi_tee_bus_type);
+}
+
+subsys_initcall(rpmi_tee_bus_init);
+
+static void __exit rpmi_tee_bus_exit(void)
+{
+	bus_unregister(&rpmi_tee_bus_type);
+	ida_destroy(&rpmi_tee_bus_id);
+}
+
+module_exit(rpmi_tee_bus_exit);
+
+MODULE_DESCRIPTION("RISC-V RPMI TEE bus");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/rpmi_tee.h b/include/linux/rpmi_tee.h
new file mode 100644
index 000000000000..c499f0427833
--- /dev/null
+++ b/include/linux/rpmi_tee.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * RISC-V RPMI TEE transport interface
+ */
+
+#ifndef _LINUX_RPMI_TEE_H
+#define _LINUX_RPMI_TEE_H
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+struct rpmi_tee_ops;
+
+struct rpmi_tee_device {
+	struct device dev;
+	u32 id;
+	u32 endpoint_id;	/* RPMI endpoint identifier of the TEE. */
+	uuid_t uuid;		/* UUID identifying the TEE service. */
+	const struct rpmi_tee_ops *ops;
+};
+
+#define to_rpmi_tee_dev(d) container_of(d, struct rpmi_tee_device, dev)
+
+struct rpmi_tee_device_id {
+	uuid_t uuid;
+};
+
+struct rpmi_tee_driver {
+	const char *name;
+	int (*probe)(struct rpmi_tee_device *rdev);
+	void (*remove)(struct rpmi_tee_device *rdev);
+	/* NULL-UUID-terminated list of supported service UUIDs. */
+	const struct rpmi_tee_device_id *id_table;
+	struct device_driver driver;
+};
+
+#define to_rpmi_tee_drv(d) \
+	container_of_const(d, struct rpmi_tee_driver, driver)
+
+extern const struct bus_type rpmi_tee_bus_type;
+
+#if IS_REACHABLE(CONFIG_RISCV_RPMI_TEE_TRANSPORT)
+struct rpmi_tee_device *
+rpmi_tee_device_register(const uuid_t *uuid, u32 endpoint_id,
+			 const struct rpmi_tee_ops *ops, struct device *parent);
+void rpmi_tee_device_unregister(struct rpmi_tee_device *rdev);
+int rpmi_tee_driver_register(struct rpmi_tee_driver *driver,
+			     struct module *owner, const char *mod_name);
+void rpmi_tee_driver_unregister(struct rpmi_tee_driver *driver);
+#else
+static inline struct rpmi_tee_device *
+rpmi_tee_device_register(const uuid_t *uuid, u32 endpoint_id,
+			 const struct rpmi_tee_ops *ops, struct device *parent)
+{
+	return NULL;
+}
+
+static inline void rpmi_tee_device_unregister(struct rpmi_tee_device *rdev)
+{
+}
+
+static inline int rpmi_tee_driver_register(struct rpmi_tee_driver *driver,
+					   struct module *owner,
+					   const char *mod_name)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void rpmi_tee_driver_unregister(struct rpmi_tee_driver *driver)
+{
+}
+#endif
+
+#define rpmi_tee_register(driver) \
+	rpmi_tee_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
+#define rpmi_tee_unregister(driver) \
+	rpmi_tee_driver_unregister(driver)
+
+#endif /* _LINUX_RPMI_TEE_H */

-- 
2.34.1

