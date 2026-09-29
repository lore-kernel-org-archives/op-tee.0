Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA76CA5FAB
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:22:25 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1674D451C6
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790652145;
	bh=JwtpegHcj7NCF7jfmE75XHrbUMVQR4/Y0It5Xr1iAYs=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wQoao4dIbxyLpB/JptwSYu1FjDu8Jbpmq7JsQQ9vt9mZg4ThnfsDWk9wtUOb03Vy0
	 FdNRjPAkTaNqTZjeRdVWCtFtyPZX0ZmY9MR0vNeyILGi6bP8NWVHBSZg2ISAHqT+RU
	 HpBxDOIhH6ppPpGdG2C+2e1UT/f4RTLqconrI1J5wq9S+MBVvcB7uEhD9U/2NCGz1S
	 OWJCN2GSAibigT2ZbbBv85aPhyMK8NrVjWJEhrIEHaH8cmK8fMad3T4luMljSuvLDn
	 ZjIsWQ9Iat2ZEHpDaC3v4Tw4M2117XzmOYmfnCc0C0ggRR3l1S6jhBRuN9FNtzIlnr
	 HYd15yJBOGahQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AB553454F9
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:59 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HEnjZkFE;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ne0569Zt;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0iZ6J4179718
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A6MXJCAA+hGYKXd4gdTi2Koltv+FMGR2V0l7go7NMGA=; b=HEnjZkFEZS/uOW+h
	iKZU00ZxeZQDH8dJcVpnvxyuVoCKczWz8/uhspZgv0vF6mVNhVGAh/jukBCW5QQw
	tMRhKYwOdryblv79eAEB1YDWp/XiEe8M8yGP1/TwuTxyvVU3FBU83BmACy2jx1yi
	AlVxw9ViIJ5z887RSqooGIEZ2lgVaxoZ2KcTJPJnR30MC6GrJZDVcOgmKobPqzJ4
	SxmH8wQIrAcMgIs3NS9KsG071lFZeDFWjkxZvdnlRLoUGKZvBBQJ6Rkja9f/rIUq
	+fFo7yqVCpgiWfkXnMJeNsQoDMi67TESzoilhcMjYfcvUGntISdOGRA4FJ8/JAXX
	qoBJjg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmu9c5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:58 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1383723dfddso2356785c88.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 20:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790651878; x=1791256678; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A6MXJCAA+hGYKXd4gdTi2Koltv+FMGR2V0l7go7NMGA=;
        b=Ne0569ZtWLrcN+hAh1DTDLJjQaNYz2kUshP/NUoQWn816/OIam/K1EMxzlRw52Nbzt
         v7Socp6YNsAgf+sjnBlha3Yl21AtFRWQ9CyZxwBunbosbptBiXhgpsF7iNEcRIt1XIwB
         0zfGRQVgSHhhX+efmDnRSDpslnGLg0dCE24rw8z1S6BfxEFHbP+h06W9MLOFxZj/rH6W
         jC/oJ4pNeCxo+n3/c/wCiDzUjmhTZOU2sEzjs0S3YFYcWdYq4J1VNArb/e4ntA9XPCHe
         6mTDvQoIirI0woKRr9saEkAt93gzzeG6gK0cPXqNi1nJkZW2cw7T90cKsTlH5lC0vhOc
         6Kng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651878; x=1791256678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A6MXJCAA+hGYKXd4gdTi2Koltv+FMGR2V0l7go7NMGA=;
        b=hR9fTEU3XyZySMpZ3BVrdKZP7NAsytWbx7P1cjXw/TCtAvhq1yVAPFSG2s7eEdEMvZ
         Wy4Bw1O+waK9nUK8nSn70pLGBZKL9/lG/pybb64V9XMimdmGvN0m5DwwJ9c01Vdy7Gxu
         b6YAqeplsFTaeZXT5KZSNN1l+nAkX6c+aN2mwT8h24FNu4DlKbNuVPOcAmrAYr5XoLAz
         gkhjnPmy+gRjy4gu/QAYXgx7pFIBx+ocLbAvI6yoGweCz0+5vo7l/fCqCbPuolAzcyuY
         ylP/x+O/7tr72HXOvuRb0iRNaCtSLCyfgdQ9iNpNrhGICoXZCOPwuRPM6gz6ovgOWj76
         +fNw==
X-Forwarded-Encrypted: i=1; AKwUvBwNoAOdYn9yZ0i6x0L4r326vAtHkLb+Mvn5Xg6AWSI90T5DqcagGlpp4YXN3fOjEeTV1dsIGuM=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++l6w5+I80TKZclrxhsCPuKX4tIJhmCLrZf5wenFPxQtF3HiX2U8
	77133p6WyfR/xXqrhjrvgi3abpvEn205ieCGt/6iHqr0w2SLyeRIbfSdGBEdcB2UVcQKggdfKbe
	kPy3xLOOOVBhQa85AczIbKbSvPPRqvlJiVWFtK8gbSCprldzcHuNSTYONWl3HF0qdXIjGbRk=
X-Gm-Gg: AYBFou0UxzWgoeIdIN45f+HjCxXDhJt8fEnvG8X5d65Ah0t3e2c0C2OtaY+wOE41O/u
	ng6VUHsNCB/6JIRxA1xFD4AqXOxBtt55AtXXfMG5N+YfXUh2cZ3sNxCMLT7FhTucC19BxcMxrG/
	9uHpc3mdqSUBypkzu9V/h7BJgATHsyek8DnZQuvn2siUv1OD15+IHOEz6StLgLDFSzz1a2CQz1b
	0mB8LCot39oJ3OwFIZegRS8ajycdrwofV+5bz9bQ5zpE9HJkMrdPc4zluMeVm9C6hY0FumCadSG
	VCjKppEf5Y4uWWHeTc3PKG6NXv1JQqSUFow1F6EQfX39KJ72oXtVYoHGYpPPVO3zfs6GHPI8Euy
	fC/Aent7ScSHFxJMg46/7OMS/3beQ+fPAZ7SQu7NNp/IW937uemjnbEMOYwo=
X-Received: by 2002:a05:7022:5f01:b0:14a:85b6:55a2 with SMTP id a92af1059eb24-14a85c59a20mr3632119c88.15.1790651877204;
        Mon, 28 Sep 2026 20:17:57 -0700 (PDT)
X-Received: by 2002:a05:7022:5f01:b0:14a:85b6:55a2 with SMTP id a92af1059eb24-14a85c59a20mr3632071c88.15.1790651876365;
        Mon, 28 Sep 2026 20:17:56 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm24789368c88.11.2026.09.28.20.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:17:55 -0700 (PDT)
Date: Mon, 28 Sep 2026 20:17:00 -0700
Subject: [PATCH RFC 09/10] firmware: riscv: rpmi-tee: add memory parcel
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-riscv-rpmi-tee-abi-v1-9-04908b81d885@oss.qualcomm.com>
References: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
In-Reply-To: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX8iHYn+/VkWLo
 NYrvY5Km0WbBWkCElzH5HmA5N5MHxDpsHcIq7rGnv4O4zPUVlA09GRM84szIqxX3LiSBDXJHDY0
 wkqvjZr5a4EiCgKbZWxuUC6u2sQsV961uyu9uKgQmu9OhjOzvklb4aB1FaELPHpd6hTryynQ46u
 StQUlZHlGxskYd5hVUGLvwdL5+Pddu4F9r9LFjT1c/pbqodwLJ2ta7gBJcMPzJ/R53K8NrtK86R
 FsfrEYFxfa5uQCB1NapH52SL1RvPs5xVpLSq/fpzUIopbM3Mj9N4Lj1NJzEM4aXrpMQ4x+DAEYO
 U0Vg+D4GB43lZvvoOZGtbpNSuZyq8knaTLoc1uP/0JxbCqSZSPeDOMH/BunIQf9vXNFbywuSK5F
 //9o5hn19Y9jKXSSF5V38czbt1J/DM6IcOQAxVl8LVg86agkt2Dwy6dMibRcrjHHaV9JgR1dADT
 bWudy1pgU4nRpmKj35w==
X-Proofpoint-GUID: UYgjU-cPKmDG8sHm1-vMpxhA9LhG9zv0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX0ggg7Vd651iy
 ZQHLrkjUahtiaYf4/4F5YmcPgRisGgloHhjAWwVZqdmqJIXU8vNNzA024yA5B+X7pCIVnza44J2
 f3sGVUNu6DQnRLnHFdbo/zq/H8WwsE0=
X-Proofpoint-ORIG-GUID: UYgjU-cPKmDG8sHm1-vMpxhA9LhG9zv0
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb2de6 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ZqXtgL2Ob53jORvibrgA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[74.125.82.71:received,129.46.96.20:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AB553454F9
X-Spamd-Bar: ----
Message-ID-Hash: MN7EYTBU6JFE7SIOXCWWLRNO37SP4Q3Z
X-Message-ID-Hash: MN7EYTBU6JFE7SIOXCWWLRNO37SP4Q3Z
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MN7EYTBU6JFE7SIOXCWWLRNO37SP4Q3Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Implement lend, share, and reclaim of RPMI memory parcels for public
memory endpoints. Convert scatterlists into RPMI page blocks and
transparently split large parcels across multiple requests when they
do not fit a single mailbox message, subject to the per-endpoint
multisegment limit reported by firmware.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/driver.c | 497 +++++++++++++++++++++++++++++++
 include/linux/rpmi_tee.h                 |  58 ++++
 2 files changed, 555 insertions(+)

diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index 7b06c1f96ba8..0004f54c7d89 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -14,6 +14,7 @@
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/rpmi_tee.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
@@ -38,6 +39,25 @@
 #define RPMI_TEE_SYSTEM_WHOLE		0
 #define RPMI_TEE_SYSTEM_SELF		3
 
+/* Memory service IDs. */
+#define RPMI_TEE_SRV_MEMORY_PARCEL_CREATE	0x09
+#define RPMI_TEE_SRV_MEMORY_PARCEL_RECLAIM	0x0c
+#define RPMI_TEE_SRV_MEMORY_SEGMENT_SEND	0x0d
+
+/* TEE_CALL memory-access flags and block format. */
+#define RPMI_TEE_ACCESS_READ			BIT(29)
+#define RPMI_TEE_ACCESS_WRITE			BIT(30)
+#define RPMI_TEE_ACCESS_EXEC			BIT(31)
+
+#define RPMI_TEE_MEM_PAGE_SHIFT			12
+#define RPMI_TEE_MEM_PAGE_SIZE			BIT(RPMI_TEE_MEM_PAGE_SHIFT)
+#define RPMI_TEE_BLOCK_MAX_PAGES		4096
+
+/* TEE_MEMORY_PARCEL_CREATE flags. */
+#define RPMI_TEE_PARCEL_MULTI_SEGMENT	BIT(31)
+
+/* TEE_MEMORY_SEGMENT_SEND flags. */
+#define RPMI_TEE_SEGMENT_LAST		BIT(31)
 /**
  * struct rpmi_tee_probe_features_req - TEE_PROBE_FEATURES request
  * @feature_id: TEE feature identifier to query.
@@ -110,12 +130,116 @@ struct rpmi_tee_call_resp {
 	u8 service_data[];
 } __packed;
 
+/**
+ * struct rpmi_tee_parcel_create_req - MEMORY_PARCEL_CREATE request prefix
+ * @creator_id: Endpoint identifier creating the parcel.
+ * @creator_access: Creator's residual access permissions.
+ * @receiver_count: Number of receiver endpoint and access pairs in @data.
+ * @flags: Parcel creation flags.
+ * @nonce: Caller-provided parcel nonce.
+ * @block_count: Total number of memory blocks in the parcel.
+ * @label: Caller-provided parcel label.
+ * @data: Receiver endpoint IDs, receiver access values, then memory blocks.
+ */
+struct rpmi_tee_parcel_create_req {
+	__le32 creator_id;
+	__le32 creator_access;
+	__le32 receiver_count;
+	__le32 flags;
+	__le32 nonce;
+	__le32 block_count;
+	u8 label[16];
+	u8 data[];
+} __packed;
+
+#define RPMI_TEE_PARCEL_CREATE_SIZE \
+	(sizeof(struct rpmi_tee_parcel_create_req))
+/* Size of one RECEIVER_ID[] and ACCESS[] entry pair. */
+#define RPMI_TEE_PARCEL_CREATE_RECEIVER_INFO_SIZE	(2 * sizeof(__le32))
+/* Size of one BLOCK_HIGH[] and BLOCK_LOW[] entry pair. */
+#define RPMI_TEE_PARCEL_CREATE_BLOCK_SIZE		(2 * sizeof(__le32))
+
+/* Store one receiver in adjacent RECEIVER_ID[] and ACCESS[] arrays at @data. */
+static inline void rpmi_tee_put_receiver(u8 *data, u32 count, u32 index,
+					 u32 id, u32 access)
+{
+	put_unaligned_le32(id, data + index * sizeof(__le32));
+	put_unaligned_le32(access, data + (count + index) * sizeof(__le32));
+}
+
+/* Store one block in adjacent BLOCK_HIGH[] and BLOCK_LOW[] arrays at @data. */
+static inline void rpmi_tee_put_block(u8 *data, u32 count, u32 index,
+				      u32 high, u32 low)
+{
+	put_unaligned_le32(high, data + index * sizeof(__le32));
+	put_unaligned_le32(low, data + (count + index) * sizeof(__le32));
+}
+
+/**
+ * struct rpmi_tee_parcel_create_resp - MEMORY_PARCEL_CREATE response
+ * @status: RPMI completion status.
+ * @parcel_id: Identifier assigned to the new parcel.
+ */
+struct rpmi_tee_parcel_create_resp {
+	__le32 status;
+	__le32 parcel_id;
+} __packed;
+
+/**
+ * struct rpmi_tee_segment_send_req - MEMORY_SEGMENT_SEND request prefix
+ * @parcel_id: Identifier of the partially created parcel.
+ * @flags: Segment flags.
+ * @block_count: Number of memory blocks in @data.
+ * @data: Memory block address and size pairs.
+ */
+struct rpmi_tee_segment_send_req {
+	__le32 parcel_id;
+	__le32 flags;
+	__le32 block_count;
+	u8 data[];
+} __packed;
+
+#define RPMI_TEE_SEGMENT_SEND_SIZE \
+	(sizeof(struct rpmi_tee_segment_send_req))
+/* Size of one BLOCK_HIGH[] and BLOCK_LOW[] entry pair. */
+#define RPMI_TEE_SEGMENT_SEND_BLOCK_SIZE	(2 * sizeof(__le32))
+
+/**
+ * struct rpmi_tee_parcel_reclaim_req - MEMORY_PARCEL_RECLAIM request
+ * @parcel_id: Identifier of the parcel to reclaim.
+ */
+struct rpmi_tee_parcel_reclaim_req {
+	__le32 parcel_id;
+} __packed;
+
+/**
+ * struct rpmi_tee_parcel_reclaim_resp - MEMORY_PARCEL_RECLAIM response
+ * @status: RPMI completion status.
+ * @flags: Reclaim result flags.
+ */
+struct rpmi_tee_parcel_reclaim_resp {
+	__le32 status;
+	__le32 flags;
+} __packed;
+
+struct rpmi_tee_notif_state {
+	u32 feature;
+};
+
 struct rpmi_tee_mbox {
 	struct mbox_client client;
 	struct mbox_chan *chan;
 	u32 max_msg_data_size;
 };
 
+struct rpmi_tee_mem_state {
+	struct mutex lock;
+	u32 multisegment_max;
+	u32 multisegment_active;
+	bool lend_ok;
+	bool share_ok;
+};
+
 struct rpmi_tee_child {
 	struct list_head node;
 	struct rpmi_tee_device *rdev;
@@ -126,6 +250,21 @@ struct rpmi_tee_transport {
 	struct rpmi_tee_mbox mbox;
 	u32 self_id;
 	struct list_head devices;
+	struct rpmi_tee_mem_state mem;
+	struct rpmi_tee_notif_state notif;
+};
+
+struct rpmi_tee_block_iter {
+	struct scatterlist *sg;
+	phys_addr_t address;
+	size_t length;
+};
+
+struct rpmi_tee_parcel_xfer {
+	struct rpmi_tee_block_iter iter;
+	u32 parcel_id;
+	u32 block_count;
+	u32 next_block;
 };
 
 /* __rpmi_tee_send() - Send an RPMI TEE service request. */
@@ -489,12 +628,369 @@ static int rpmi_tee_op_call(struct rpmi_tee_device *rdev, const void *req,
 	return 0;
 }
 
+/* MEMORY_PARCEL_RECLAIM. */
+static int rpmi_tee_memory_reclaim(struct rpmi_tee_transport *priv,
+				   u32 parcel_id)
+{
+	struct rpmi_tee_parcel_reclaim_req req = {
+		.parcel_id = cpu_to_le32(parcel_id),
+	};
+	struct rpmi_tee_parcel_reclaim_resp resp;
+	size_t resp_len = sizeof(resp);
+	int ret;
+
+	ret = rpmi_tee_send(priv, RPMI_TEE_SRV_MEMORY_PARCEL_RECLAIM, &req,
+			    sizeof(req), &resp, &resp_len);
+	if (ret)
+		return ret;
+
+	if (resp_len != sizeof(resp))
+		return -EPROTO;
+
+	return 0;
+}
+
+static int rpmi_tee_op_memory_reclaim(struct rpmi_tee_device *rdev,
+				       u32 parcel_id)
+{
+	return rpmi_tee_memory_reclaim(rpmi_tee_device_to_transport(rdev),
+				       parcel_id);
+}
+
+/**
+ * rpmi_tee_count_blocks_sg - Count RPMI memory blocks in an SG list
+ * @sg: First SG entry describing the memory to share or lend.
+ * @count_out: Returns the number of RPMI memory blocks.
+ *
+ * Validates that every entry represents one or more whole 4 KiB pages. An
+ * RPMI memory block represents at most @RPMI_TEE_BLOCK_MAX_PAGES pages.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int rpmi_tee_count_blocks_sg(struct scatterlist *sg, u32 *count_out)
+{
+	struct scatterlist *entry;
+	u32 count = 0;
+
+	if (!sg)
+		return -EINVAL;
+
+	for (entry = sg; entry; entry = sg_next(entry)) {
+		phys_addr_t address = sg_phys(entry);
+		size_t blocks;
+
+		if (!entry->length ||
+		    !IS_ALIGNED(address, RPMI_TEE_MEM_PAGE_SIZE) ||
+		    !IS_ALIGNED(entry->length, RPMI_TEE_MEM_PAGE_SIZE))
+			return -EINVAL;
+
+		/* One RPMI block describes at most 4096 pages. */
+		blocks = DIV_ROUND_UP(entry->length >> RPMI_TEE_MEM_PAGE_SHIFT,
+				      RPMI_TEE_BLOCK_MAX_PAGES);
+		if (blocks > U32_MAX - count)
+			return -EOVERFLOW;
+
+		count += blocks;
+	}
+
+	*count_out = count;
+
+	return 0;
+}
+
+static void rpmi_tee_block_iter_init(struct rpmi_tee_block_iter *iter,
+				     struct scatterlist *sg)
+{
+	iter->sg = sg;
+	iter->address = 0;
+	iter->length = 0;
+}
+
+/* Encode the next RPMI memory block from an SG iterator. */
+static bool rpmi_tee_block_iter_next(struct rpmi_tee_block_iter *iter,
+				     u32 *high, u32 *low)
+{
+	u32 pages;
+
+	if (!iter->length) {
+		if (!iter->sg)
+			return false;
+		/* Next SG. */
+		iter->address = sg_phys(iter->sg);
+		iter->length = iter->sg->length;
+		iter->sg = sg_next(iter->sg);
+	}
+
+	/* RPMI memory block represents at most @RPMI_TEE_BLOCK_MAX_PAGES pages. */
+	pages = min_t(size_t, iter->length >> RPMI_TEE_MEM_PAGE_SHIFT,
+		      RPMI_TEE_BLOCK_MAX_PAGES);
+
+	*high = upper_32_bits(iter->address >> RPMI_TEE_MEM_PAGE_SHIFT);
+	*low = lower_32_bits(iter->address >> RPMI_TEE_MEM_PAGE_SHIFT) << 12 |
+		(pages - 1);
+
+	iter->address += (phys_addr_t)pages << RPMI_TEE_MEM_PAGE_SHIFT;
+	iter->length -= (size_t)pages << RPMI_TEE_MEM_PAGE_SHIFT;
+
+	return true;
+}
+
+static int rpmi_tee_fill_blocks(struct rpmi_tee_block_iter *iter, u8 *data,
+				u32 count)
+{
+	u32 high, low, i;
+
+	for (i = 0; i < count; i++) {
+		if (!rpmi_tee_block_iter_next(iter, &high, &low))
+			return -EINVAL;
+
+		rpmi_tee_put_block(data, count, i, high, low);
+	}
+
+	return 0;
+}
+
+/* Convert memory access flags RPMI_TEE_MEM_ACCESS_* to RPMI_TEE_ACCESS_*. */
+static u32 rpmi_tee_access(u32 mem_access)
+{
+	u32 tee_access = 0;
+
+	if (mem_access & RPMI_TEE_MEM_ACCESS_READ)
+		tee_access |= RPMI_TEE_ACCESS_READ;
+	if (mem_access & RPMI_TEE_MEM_ACCESS_WRITE)
+		tee_access |= RPMI_TEE_ACCESS_WRITE;
+	if (mem_access & RPMI_TEE_MEM_ACCESS_EXEC)
+		tee_access |= RPMI_TEE_ACCESS_EXEC;
+
+	return tee_access;
+}
+
+static int rpmi_tee_reserve_segment_slot(struct rpmi_tee_transport *priv)
+{
+	int ret = 0;
+
+	guard(mutex)(&priv->mem.lock);
+	if (priv->mem.multisegment_active == priv->mem.multisegment_max)
+		ret = -EBUSY;
+	else
+		priv->mem.multisegment_active++;
+
+	return ret;
+}
+
+static void rpmi_tee_release_segment_slot(struct rpmi_tee_transport *priv)
+{
+	guard(mutex)(&priv->mem.lock);
+	priv->mem.multisegment_active--;
+}
+
+/* Send the remaining blocks of a segmented memory parcel. */
+static int rpmi_tee_parcel_send_segments(struct rpmi_tee_transport *priv,
+					 struct rpmi_tee_parcel_xfer *xfer)
+{
+	while (xfer->next_block < xfer->block_count) {
+		size_t req_len;
+		u32 count;
+		int ret;
+
+		count = min_t(u32, xfer->block_count - xfer->next_block,
+			      (priv->mbox.max_msg_data_size -
+				RPMI_TEE_SEGMENT_SEND_SIZE) /
+				RPMI_TEE_SEGMENT_SEND_BLOCK_SIZE);
+		if (!count)
+			return -EMSGSIZE;
+
+		req_len = RPMI_TEE_SEGMENT_SEND_SIZE +
+			RPMI_TEE_SEGMENT_SEND_BLOCK_SIZE * count;
+
+		struct rpmi_tee_segment_send_req *req __free(kfree) =
+			kzalloc(req_len, GFP_KERNEL);
+		if (!req)
+			return -ENOMEM;
+
+		/* INIT request. */
+		req->parcel_id = cpu_to_le32(xfer->parcel_id);
+		req->flags = cpu_to_le32(xfer->next_block + count ==
+					 xfer->block_count ?
+					 RPMI_TEE_SEGMENT_LAST : 0);
+		req->block_count = cpu_to_le32(count);
+		ret = rpmi_tee_fill_blocks(&xfer->iter, req->data, count);
+		if (ret)
+			return ret;
+
+		ret = rpmi_tee_send(priv, RPMI_TEE_SRV_MEMORY_SEGMENT_SEND,
+				    req, req_len, NULL, NULL);
+		if (ret)
+			return ret;
+
+		xfer->next_block += count;
+	}
+
+	return 0;
+}
+
+/* Create a memory parcel after the caller has validated its operation. */
+static int rpmi_tee_parcel_create(struct rpmi_tee_transport *priv,
+				    struct rpmi_tee_mem_args *args)
+{
+	struct rpmi_tee_parcel_create_resp resp;
+	struct rpmi_tee_parcel_xfer xfer;
+	size_t blk_off, req_len, resp_len;
+	bool segmented;
+	int ret;
+	u32 i;
+
+	ret = rpmi_tee_count_blocks_sg(args->sg, &xfer.block_count);
+	if (ret)
+		return ret;
+
+	/* BLOCK_HIGH[] follows the request header and receiver arrays. */
+	blk_off = RPMI_TEE_PARCEL_CREATE_SIZE + args->receiver_count *
+		RPMI_TEE_PARCEL_CREATE_RECEIVER_INFO_SIZE;
+
+	/* Limit the initial request to the parcel's actual block count. */
+	xfer.next_block = min((priv->mbox.max_msg_data_size - blk_off) /
+			      RPMI_TEE_PARCEL_CREATE_BLOCK_SIZE,
+			      xfer.block_count);
+
+	segmented = xfer.next_block < xfer.block_count;
+	if (segmented) {
+		if (!priv->mem.multisegment_max)
+			return -EOPNOTSUPP;
+		/* Reserve a slot against the firmware's advertised limit. */
+		ret = rpmi_tee_reserve_segment_slot(priv);
+		if (ret)
+			return ret;
+	}
+
+	req_len = blk_off + RPMI_TEE_PARCEL_CREATE_BLOCK_SIZE * xfer.next_block;
+
+	struct rpmi_tee_parcel_create_req *req __free(kfree) =
+		kzalloc(req_len, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto out_release_slot;
+	}
+
+	rpmi_tee_block_iter_init(&xfer.iter, args->sg);
+
+	/* INIT request. */
+	req->creator_id = cpu_to_le32(priv->self_id);
+	req->creator_access = cpu_to_le32(rpmi_tee_access(args->creator_access));
+	req->receiver_count = cpu_to_le32(args->receiver_count);
+	req->flags = cpu_to_le32(segmented ? RPMI_TEE_PARCEL_MULTI_SEGMENT : 0);
+	req->nonce = cpu_to_le32(args->nonce);
+	req->block_count = cpu_to_le32(xfer.block_count);
+	memcpy(req->label, args->label, sizeof(req->label));
+
+	for (i = 0; i < args->receiver_count; i++) {
+		u32 tee_access = rpmi_tee_access(args->receivers[i].access);
+		/* Store RECEIVER_ID[i] and ACCESS[i]. */
+		rpmi_tee_put_receiver(req->data, args->receiver_count, i,
+				      args->receivers[i].endpoint_id,
+				      tee_access);
+	}
+
+	ret = rpmi_tee_fill_blocks(&xfer.iter,
+				   req->data + 8 * args->receiver_count,
+				   xfer.next_block);
+	if (ret)
+		goto out_release_slot;
+
+	resp_len = sizeof(resp);
+	ret = rpmi_tee_send(priv, RPMI_TEE_SRV_MEMORY_PARCEL_CREATE,
+			    req, req_len, &resp, &resp_len);
+	if (ret)
+		goto out_release_slot;
+	if (resp_len != sizeof(resp))
+		return -EPROTO;
+
+	xfer.parcel_id = get_unaligned_le32(&resp.parcel_id);
+	/* Send remaining blocks as segments. */
+	ret = rpmi_tee_parcel_send_segments(priv, &xfer);
+	if (ret) {
+		/* On error, retain the slot as firmware may still hold it. */
+		if (rpmi_tee_memory_reclaim(priv, xfer.parcel_id)) {
+			dev_warn(priv->dev, "failed to abort parcel %#x\n",
+				 xfer.parcel_id);
+
+			return ret;
+		}
+	} else {
+		args->parcel_id = xfer.parcel_id;
+	}
+
+out_release_slot:
+	if (segmented)
+		rpmi_tee_release_segment_slot(priv);
+
+	return ret;
+}
+
+/* MEMORY_PARCEL_CREATE. */
+static int rpmi_tee_op_parcel_create(struct rpmi_tee_device *rdev,
+				     struct rpmi_tee_mem_args *args, bool lend)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	u32 i;
+
+	if (!args || !args->receivers || !args->receiver_count)
+		return -EINVAL;
+
+	/* LEND relinquishes creator access, whereas SHARE retains it. */
+	if (lend ? args->creator_access : !args->creator_access)
+		return -EINVAL;
+
+	if (args->creator_access & ~RPMI_TEE_MEM_ACCESS_MASK)
+		return -EINVAL;
+	for (i = 0; i < args->receiver_count; i++) {
+		if (args->receivers[i].access & ~RPMI_TEE_MEM_ACCESS_MASK)
+			return -EINVAL;
+	}
+
+	if (lend ? !priv->mem.lend_ok : !priv->mem.share_ok)
+		return -EOPNOTSUPP;
+
+	/* A parcel must contain at least one BLOCK_HIGH/BLOCK_LOW pair. */
+	if (priv->mbox.max_msg_data_size < RPMI_TEE_PARCEL_CREATE_SIZE +
+	    RPMI_TEE_PARCEL_CREATE_BLOCK_SIZE)
+		return -EMSGSIZE;
+
+	/* Check if receiver's info fit after reserving room for one block. */
+	if (args->receiver_count >
+	    (priv->mbox.max_msg_data_size - RPMI_TEE_PARCEL_CREATE_SIZE -
+	     RPMI_TEE_PARCEL_CREATE_BLOCK_SIZE) /
+	    RPMI_TEE_PARCEL_CREATE_RECEIVER_INFO_SIZE)
+		return -EMSGSIZE;
+
+	return rpmi_tee_parcel_create(priv, args);
+}
+
+static int rpmi_tee_op_memory_lend(struct rpmi_tee_device *rdev,
+				   struct rpmi_tee_mem_args *args)
+{
+	return rpmi_tee_op_parcel_create(rdev, args, true);
+}
+
+static int rpmi_tee_op_memory_share(struct rpmi_tee_device *rdev,
+				    struct rpmi_tee_mem_args *args)
+{
+	return rpmi_tee_op_parcel_create(rdev, args, false);
+}
+
 static const struct rpmi_tee_msg_ops rpmi_tee_msg_ops = {
 	.call = rpmi_tee_op_call,
 };
 
+static const struct rpmi_tee_mem_ops rpmi_tee_mem_ops = {
+	.memory_lend = rpmi_tee_op_memory_lend,
+	.memory_share = rpmi_tee_op_memory_share,
+	.memory_reclaim = rpmi_tee_op_memory_reclaim,
+};
+
 static const struct rpmi_tee_ops rpmi_tee_ops = {
 	.msg_ops = &rpmi_tee_msg_ops,
+	.mem_ops = &rpmi_tee_mem_ops,
 };
 
 static void rpmi_tee_unregister_devices(struct rpmi_tee_transport *priv)
@@ -599,6 +1095,7 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 	INIT_LIST_HEAD(&priv->devices);
+	mutex_init(&priv->mem.lock);
 	priv->mbox.client.dev = &pdev->dev;
 	priv->mbox.client.tx_sync = true;
 	priv->mbox.chan = mbox_request_channel(&priv->mbox.client, 0);
diff --git a/include/linux/rpmi_tee.h b/include/linux/rpmi_tee.h
index 57c1843537da..c2dd99293481 100644
--- a/include/linux/rpmi_tee.h
+++ b/include/linux/rpmi_tee.h
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/scatterlist.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 
@@ -46,9 +47,66 @@ struct rpmi_tee_msg_ops {
 		    size_t req_len, void *resp, size_t *resp_len);
 };
 
+/* Access permissions used by memory parcel operations. */
+#define RPMI_TEE_MEM_ACCESS_READ	BIT(0)
+#define RPMI_TEE_MEM_ACCESS_WRITE	BIT(1)
+#define RPMI_TEE_MEM_ACCESS_EXEC	BIT(2)
+#define RPMI_TEE_MEM_ACCESS_MASK	(RPMI_TEE_MEM_ACCESS_READ | \
+					 RPMI_TEE_MEM_ACCESS_WRITE | \
+					 RPMI_TEE_MEM_ACCESS_EXEC)
+
+/* One receiver's access rights for a memory parcel. */
+struct rpmi_tee_mem_receiver {
+	/* RPMI endpoint identifier of the receiver. */
+	u32 endpoint_id;
+	/* Bitwise OR of RPMI_TEE_MEM_ACCESS_* permissions. */
+	u32 access;
+};
+
+/* Arguments used to create a memory parcel. */
+struct rpmi_tee_mem_args {
+	/* Scatterlist describing whole, 4 KiB-aligned memory pages. */
+	struct scatterlist *sg;
+	/* Array of @receiver_count parcel receivers. */
+	const struct rpmi_tee_mem_receiver *receivers;
+	/* Number of entries in @receivers. */
+	u32 receiver_count;
+	/* Creator permissions retained by a SHARE operation. */
+	u32 creator_access;
+	/* Implementation-defined value carried in the parcel descriptor. */
+	u32 nonce;
+	/* Implementation-defined 16-byte parcel label. */
+	u8 label[16];
+	/* Returned firmware-assigned parcel identifier on success. */
+	u32 parcel_id;
+};
+
+/* RPMI TEE memory-parcel operations. */
+struct rpmi_tee_mem_ops {
+	/**
+	 * @memory_lend: Lend the pages described by @args to its receivers. The
+	 *	creator must not retain access, so @args->creator_access must be zero.
+	 */
+	int (*memory_lend)(struct rpmi_tee_device *rdev,
+			   struct rpmi_tee_mem_args *args);
+	/**
+	 * @memory_share: Share the pages described by @args with its receivers.
+	 *	The creator retains the nonzero permissions in
+	 *	@args->creator_access.
+	 */
+	int (*memory_share)(struct rpmi_tee_device *rdev,
+			    struct rpmi_tee_mem_args *args);
+	/**
+	 * @memory_reclaim: Reclaim the parcel identified by @parcel_id after all
+	 *	receivers have relinquished it.
+	 */
+	int (*memory_reclaim)(struct rpmi_tee_device *rdev, u32 parcel_id);
+};
+
 /* RPMI TEE transport operation groups. */
 struct rpmi_tee_ops {
 	const struct rpmi_tee_msg_ops *msg_ops;
+	const struct rpmi_tee_mem_ops *mem_ops;
 };
 
 extern const struct bus_type rpmi_tee_bus_type;

-- 
2.34.1

