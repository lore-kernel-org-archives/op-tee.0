Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E394CA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:33:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CAFEA454BC
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430407;
	bh=yK8tXZ4W2qFOIHjQKJc/I82o5d2kxSmh4bqvJiWnd0Q=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=a9ua2m5bO18DXg5RT1Lbv+y1D4d8zKj050/ASAKZ7Y6gY5PqNARidJgeahpw0TdwJ
	 dnVh31NV1h4wuaSDytfi/YoWwI7+6G+Wd7IuSOAUhba8PdGmmJtT+G8nFwM/CkPMFP
	 HIG1/gcmSWn0ebWNOGlaxQFjqoI24EbfM8bqN/13kE8nZ58GMxD5vqJMw38EGz/2Md
	 dZGW/OrU43O+AocUYc4g3xwrPsBGyVnjS6WvED02GneHFKh97+Ed4fwhX87Ux+7Lmf
	 onVCB1rWtY5bcaZj1+rZuwGL0Ot7MZOqFm6Zhg0mrRwAVo2MMQmarcz2OxvDNsNm4o
	 KXKlK0Enpfyeg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 301514552B
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e0uQRsbM;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kc3zsNuW;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hSQI1431003
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mApVFjc9rhNzsGXcLCP/umDupri6qQf4ON6W11wUO6o=; b=e0uQRsbMNM1GTMkf
	mqDIqtYpWvndDndgkwyOQJb48yWJ5yfhAIKztKOzBu//TC5mk4Nf8YhbOr2XcB/Z
	4Na0nbpmTzS9oqQElhyPIPqSgD96t8j4sp35cixqBIaBVDOkxLsPUAXcZ9wwKG2h
	QwCMxr5pKbxDuo1QNJhx9hTlLvhvwopCLrufxvEtWROhKcOFkM9bZq2ElM/aQ0As
	WgLE9t8dv6s7AKoljuV/3Uy/RAbrKbAbxH2Ek/XZL+c3E7VzxWIlbdsa77665shL
	UekeiVvudhEmytOrsk9B+Gcyahmn448KhnEWDA3izRTgIbUY9tgKhRtNGqn49UkI
	m2AKGQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2s1a3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:55 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34ef0362d95so8988571eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430134; x=1792034934; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mApVFjc9rhNzsGXcLCP/umDupri6qQf4ON6W11wUO6o=;
        b=kc3zsNuW5sC4YcykZ3rLrw42lnK+kLbPETxzM70ZpFLKR55DmimlcZDTSOque3NLmR
         0aXZ/nN8oJ+HOqghqJUgUINQtmV9TgKsJHSyvpnozcphkKUWudkL8HwIXL7/EcJDds8K
         2pYSN77PMZrvd48XldS2dKZqpK55oQ5hMkec/edNMKox+k/CveVQVcw0ijRZAuHAe6xx
         8myoyYZMJi7MjiYiVorfXfSZ/rQoWyr+GcLZPqe1/xkQCHkUvmIT/EsGykQZnqDOcGmA
         sLPK4y3L6UpdW599/CsiHSGdtycZscZbPct1/VUzRxZxJ/XIP2jB9sRjx8SDy0S1ScOJ
         f0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430134; x=1792034934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mApVFjc9rhNzsGXcLCP/umDupri6qQf4ON6W11wUO6o=;
        b=oZaqqBNjlysqn6wItKOa2uP3p/gPPwSkQEt7LVFa7yk9KmXOpQAu2FkyVVHgLV3jRr
         hr13PyuAVk/HqrS5foT019i7VCENFEZFNQcoH/80w3CGywt4BG8WJXQEBXs1W2gntLre
         WnL7nPLG99ffi1vIJV9e7Ex44osrUaN/rXMqARBZgVw+71xb+2clbet1bbFFYRqWQpRQ
         dLdm+ZK5E/OmrqsrobY479bAGZXB/TiPtQ9Sa697XwRQCx0BSu2GrExZJCWG9Uqem1gJ
         +iLLITcvgrI3mJE12/y8hjWKfQBzIbBizInPecsxeeooudotSUBaf5V1AuzH6NYD7vGD
         ypLA==
X-Forwarded-Encrypted: i=1; AKwUvBxrV7NR9N4CeERNJ/vTKmHOyOo3JEzFX+FNDNbO1WwrA8xJhPydTOrM4W79pz2ghEk15DkbdvU=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++ldFvXN8P8h1Aak87DXj4ezwyGlWjexP/OJSWuoRuOXPbZZV3VP
	f+T5YH8eDZZlk62tijkSKsegoLno+UtJteXgvzF5qkB3Q9pDWCjEyBuPFWty/g+m/1GbESIM1bv
	UBrwipLv2b3aXlIObCk0i6UULfTj9YvAu9dAGIOZLS8CYougjB6YLEpc6qO7bChc+B5ma9inlnb
	CG5OE=
X-Gm-Gg: AYBFou2fYi9/VmLZjl3d/8pxuKWlqmuYjzfJNFxdxd/XnPowkHwMAffQWerrwVDuUL/
	EDeKlbS9kYhpX3mcOlxAfSjVvUoZEZLNgjmzVCYwZYTdj2Z5DXtvmuc8PdqGQ3J3f9TfbAjgIUT
	Iz/Rtvj5yF82SdQaaeL/y0+sD5jNk8FEg8Lr9x7Nsm+vs9UJ5joz91+A5MnopkNZ0q5uVxdVd3C
	+5H8OjNmsmLQ7YBUAaGi+fK7EJFhx4wKst7BkX5+WvuoUMTTik2j35ymaqLJqDfLCINqY0nzxmh
	qB8qXfrJdJwKcXhRQuCmx5hpg+mhCbZEgTU2V3w36HlXZuXsAis7PWnomMdGHJ9N6AfcU6K9gO9
	5FA4aYTDCyOQ2nvtvild6lD/C3pKoXxZchFsYfe91TLC8DDikNhvjDZi0Kw==
X-Received: by 2002:a05:693c:4143:20b0:343:8d77:1d97 with SMTP id 5a478bee46e88-3515de5db65mr5691051eec.39.1791430133821;
        Wed, 07 Oct 2026 20:28:53 -0700 (PDT)
X-Received: by 2002:a05:693c:4143:20b0:343:8d77:1d97 with SMTP id 5a478bee46e88-3515de5db65mr5691012eec.39.1791430133132;
        Wed, 07 Oct 2026 20:28:53 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:52 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:15 -0700
Subject: [PATCH RFC v2 09/10] firmware: riscv: rpmi-tee: add memory parcel
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-9-45939a13d223@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=AbMkjHXG c=1 sm=1 tr=0 ts=6ac70df7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=ZqXtgL2Ob53jORvibrgA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: HWn4YjZpttu0-I9OEd_m2N3ds4fRFAWp
X-Proofpoint-ORIG-GUID: HWn4YjZpttu0-I9OEd_m2N3ds4fRFAWp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXyzRM17YXSetW
 nz3/vbw6yU/SEivP4tUNFMIWDQ78mxG+82QMi4oPYiRg3sK39/B5lirp1oRlfXnRnWu5QhfSQlt
 afluIE00hykEHK6qzgE7iNEjYZfhjNE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX8xZXQRaiw4c1
 As7JeQj74rlzMYhd0IKGocDhxvOfzkfxVbKH1CGoIcA8KdSz8eSGWhBiR4PBaJINI5tW+qclRqH
 WvtQ2TQMFUbFrd6arGiol8FnRih/nO1usUHxyGDLY2jW1oQPEXUndq2SVGrxZ38qr3Yu++NjSjR
 uMBVT6nXqzurknVZe4lhfUEYj25/RqNAJsv83jP4UxKAPPIZxuA4LWP+5n63PIuKJnxKapue0Xl
 uG3uxSVPBzdpkPwC9ehEsBAYBhnJInBPyMfTxHKikBvVUdlVvnglLtOTpNYfoJ1o1XgHt+9030T
 LSE1rOgUJk9+AHsvESR3EZDzQCYLLnBFuDYYCURgVrOrA6ChENbJJtk7jumDuw7P2KUVlm3xQr0
 C7jltKLLEi4Dwr5wwyYO2rBV3oy8PlgxhOESNJadwa40O4g+Gj2/7tf9GFdzL9rYCU4lnqhJ2KX
 7rnK9qo7jKvF0We3jKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org,oss.nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
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
X-Rspamd-Queue-Id: 301514552B
X-Spamd-Bar: ---
Message-ID-Hash: RFDGFOMNDWSGTUOWPM7LVYHEHLHKBGEZ
X-Message-ID-Hash: RFDGFOMNDWSGTUOWPM7LVYHEHLHKBGEZ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RFDGFOMNDWSGTUOWPM7LVYHEHLHKBGEZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add memory lending, sharing and reclamation through RPMI memory parcels
so service drivers can exchange memory with TEE endpoints.

Support segmented parcels when memory descriptions exceed the mailbox
payload limit, respecting the firmware's limit on concurrent segmented
operations.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/driver.c           | 477 +++++++++++++++++++++
 drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h |   6 +
 include/linux/rpmi_tee.h                           |  58 +++
 3 files changed, 541 insertions(+)

diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index b43a09f5e853..690561ed949d 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/rpmi_tee.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
 
@@ -27,6 +28,20 @@
 #define RPMI_TEE_MEMORY_FEATURE_TEE_ONLY		1
 #define RPMI_TEE_MEMORY_FEATURE_FULLY_SUPPORTED	2
 
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
@@ -73,11 +88,116 @@ struct rpmi_tee_call_resp {
 	u8 service_data[];
 } __packed;
 
+/**
+ * struct rpmi_tee_parcel_create_req - MEMORY_PARCEL_CREATE request prefix
+ * @creator_id: Endpoint identifier creating the parcel.
+ * @creator_access: Creator's residual access permissions.
+ * @receiver_count: Number of receiver endpoint and access pairs in @data.
+ * @flags: Parcel creation flags.
+ * @nonce: Caller-provided parcel nonce.
+ * @block_count: Number of memory blocks included in this request.
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
 struct rpmi_tee_child {
 	struct list_head node;
 	struct rpmi_tee_device *rdev;
 };
 
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
+};
+
 /* rpmi_tee_send_with_status() - Send an RPMI TEE service request. */
 int rpmi_tee_send_with_status(struct rpmi_tee_transport *priv, u32 service_id,
 			      const void *req, size_t req_len, void *resp,
@@ -326,6 +446,355 @@ static int rpmi_tee_op_call(struct rpmi_tee_device *rdev, const void *req,
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
+	*high = upper_32_bits(iter->address);
+	*low = lower_32_bits(iter->address) | (pages - 1);
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
+				  struct rpmi_tee_mem_args *args)
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
+	req->block_count = cpu_to_le32(xfer.next_block);
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
 static const struct rpmi_tee_info_ops rpmi_tee_info_ops = {
 	.msg_limits_get = rpmi_tee_op_msg_limits_get,
 };
@@ -334,9 +803,16 @@ static const struct rpmi_tee_msg_ops rpmi_tee_msg_ops = {
 	.call = rpmi_tee_op_call,
 };
 
+static const struct rpmi_tee_mem_ops rpmi_tee_mem_ops = {
+	.memory_lend = rpmi_tee_op_memory_lend,
+	.memory_share = rpmi_tee_op_memory_share,
+	.memory_reclaim = rpmi_tee_op_memory_reclaim,
+};
+
 static const struct rpmi_tee_ops rpmi_tee_ops = {
 	.info_ops = &rpmi_tee_info_ops,
 	.msg_ops = &rpmi_tee_msg_ops,
+	.mem_ops = &rpmi_tee_mem_ops,
 };
 
 static void rpmi_tee_unregister_devices(struct rpmi_tee_transport *priv)
@@ -431,6 +907,7 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 	INIT_LIST_HEAD(&priv->devices);
+	mutex_init(&priv->mem.lock);
 	priv->mbox.client.dev = &pdev->dev;
 	priv->mbox.client.tx_sync = true;
 	priv->mbox.chan = mbox_request_channel(&priv->mbox.client, 0);
diff --git a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
index 0c3cfa0f14ec..4df47d52724a 100644
--- a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
+++ b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
@@ -8,6 +8,7 @@
 
 #include <linux/list.h>
 #include <linux/mailbox_client.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 
@@ -19,6 +20,9 @@
 #define RPMI_TEE_SRV_PROBE_DOMAIN	0x04
 #define RPMI_TEE_SRV_PROBE_ENDPOINT	0x05
 #define RPMI_TEE_SRV_CALL		0x18
+#define RPMI_TEE_SRV_MEMORY_PARCEL_CREATE	0x0e
+#define RPMI_TEE_SRV_MEMORY_PARCEL_RECLAIM	0x11
+#define RPMI_TEE_SRV_MEMORY_SEGMENT_SEND	0x12
 
 struct rpmi_tee_notif_state {
 	u32 feature;
@@ -31,7 +35,9 @@ struct rpmi_tee_mbox {
 };
 
 struct rpmi_tee_mem_state {
+	struct mutex lock;
 	u32 multisegment_max;
+	u32 multisegment_active;
 	bool lend_ok;
 	bool share_ok;
 };
diff --git a/include/linux/rpmi_tee.h b/include/linux/rpmi_tee.h
index a76055149996..10f6cae4a3a7 100644
--- a/include/linux/rpmi_tee.h
+++ b/include/linux/rpmi_tee.h
@@ -10,6 +10,7 @@
 
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/scatterlist.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
 
@@ -70,10 +71,67 @@ struct rpmi_tee_msg_ops {
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
 	const struct rpmi_tee_info_ops *info_ops;
 	const struct rpmi_tee_msg_ops *msg_ops;
+	const struct rpmi_tee_mem_ops *mem_ops;
 };
 
 extern const struct bus_type rpmi_tee_bus_type;

-- 
2.34.1

