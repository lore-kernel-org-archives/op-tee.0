Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E3ACA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:32:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7FB8F4552A
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430378;
	bh=Td+UxKacrFC0CZmTXeZ4XbWj5/Incz7fIlROqT0fVhU=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AJEtu7hOyNDS/LafZm11ksB0j7hNqVeyqo7b1K0RLMarh5BrxSCWPHs2f4kmQ8QWJ
	 Tx4mZKkt7oeeB/8fDgZk6qsM8XyXkYhQIcQTWfCHAEHu/m+dZvxN3mI4YHf+Gs0Xk6
	 h/7A06jbhA/YMwD8GWQOP57MmVOO85t4gdurt4bCAxEYyATAoxs06FmoVo9kbKwhW2
	 iZqIIF7z8OdKRJbHcPlO/qdAaUW+bIpl/HQj0gI+WI+Kc4q0dpi5yAb/kOGPQJ55jG
	 8LrxubmBACo4LSKz5juF7kJP6uWRS7N1tteCiwrmqQwr//8df/l6SS4d9nzcL36MVQ
	 iJnHWypUW4p1A==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4A36444FC6
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dlpvT/FP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEUcfJyt;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hfxf1114569
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xq/6RviwiI4D0pjh/SnP69MfRLFyAZXinygQJ5DPCiM=; b=dlpvT/FPhwBMYClT
	me9U1IesnRgGVsIhg5RFrAO8VKHUqcWYCiiTNS4Upu1GAV0fRaVgNOQ7mfLNU4pB
	DByNovRMDawf7NMBCfimvAtUQQ2wi9CRMbynGpmVkBLKcZnF7yH+9rO7p5gpsDBR
	sll1nK9IXarW2kqwN7vpWxnnrT1dQ13xpij/YVHmSSeqKgD/MGYSHFK/EPQZ82rf
	3AVfQd4R6xV3NqnAvbzz58TQkE3rZIPMZUEHz7gsWvo09wZ1dkAJrmHwvEHYKdyh
	BCkI4peFPd1xsR2uTU3H4AYpYXmGHKkpQ/JRgX+FfGxsrVUPekDRBxIaNxUR9w5B
	twasSw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3h0ye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-341eff9e381so7853754eec.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430133; x=1792034933; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xq/6RviwiI4D0pjh/SnP69MfRLFyAZXinygQJ5DPCiM=;
        b=iEUcfJytzGzZm/u5/PsJ1G1Q0foNlLahazzfvT+EaCRt/9Pl++OqXL3r59dcZFycIW
         MPfWQFBpHUK8IsVAZ6AkJBfQiJKIn1/G3HXCHH8Dmliaj12ktCeReRhyLkxvij3cInJA
         TYk8zjLaOAlAa0ukgHxre7zJv2RTffQk8asZKUDwTuZh7jd8CbOczJz5HAXkWc3n6CSY
         Bu4hw3OMJAyR5xYvqOJxyD2JdjtiGIMzJsHzlapLSPEyIQM4VgDz6+FFl5e+Mvf0qyPG
         Ab5bccLD1hiOjLEfU7fjnI+mmYCnucXQhJw1tAVHnz+JdsMU1i8wM8ooSZBNdm3ZqNZH
         on8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430133; x=1792034933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xq/6RviwiI4D0pjh/SnP69MfRLFyAZXinygQJ5DPCiM=;
        b=Yg73ex4+RCBnNF3Y86F/G544EIcguGHcDyTJyFNZNnwJn1BLWgq0Fs5p8C1oTjqXmn
         Dva6JqHJ6HEvbvUPCITdRQ0yepnvrqXuCS0/MZUMlzkPuHZ6TUS34QbaD0Ak9acNQGoE
         YFlerJDsYZk5ulAEduFx8qTemNaaaX1jcIvHUAyosMywdNAs3I+ckrm6ICCXq6ir6T48
         4ATlY6l5FNa0PCXHQbwGrMCXGbsTSAq2TaX/bT15kjMrdHAu/sADAldn5dzerDyzxUC2
         bq6wM4yNMCEFDkIiVeIJN8CxwiB0x3qoSr7g4qrWEfPfv32Sp4ixahWC6QxwFoAMOcEX
         hDEA==
X-Forwarded-Encrypted: i=1; AKwUvBxBqcywrD6iiPtLWB2yqbhPKUPIEIOCgUwJkacnzDeQ4sT8SCCVnIgEe0JnDesaDcMJY8Wfj2U=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++l6hZaic/WurH20ZKQ+FSfDLylPmhH2B22SehqCOI/kTZrDBIst
	AeD29jCesxAfGqhJdSR1PXQn6h83hDMzAH0Y7MUDs850gpVn6mhwve3ZlfEmCEgI8nq/CTT3zHd
	9lJzN3tvEx4JhQhgswXCJ53SQGv2JtvNFp95bP8qSWjlleOMuH+r4mWVtew/V2JZfpgs4M1g=
X-Gm-Gg: AYBFou2RIGqM3Fk6qNjvItKmALnA0RTmGUyvMWdEeJYvvDzg+M9GGQF9Rb8oc9UYin5
	siQm70c+tRY9BYli5Cp79qtaBYxrMW0CzEi8SyD3Q4nJP087S8dGne/Z1ELG5IyRI1ogl85rBnq
	NcS7MIve/yq2jppMwuAdw/KpvU5qlH0ua2fnyPxbRhyN0FhIjftTvoOfzDS8LwNv9D7TVdv+GVK
	BDVbBAxVXKfI1s9HxnULSNGOW9O3XW2Vix/fUqI/4fQFnIQ07HfrgL0jZJHghAn+uzFwB/AAvEa
	8tXgFX+hdVDmObzHcM5yFFh7J1GOUbjHKVD2xFTHA7VSGECOkeQlu0t2GCH2F7mWK6rnB4e/EAB
	0nA2eIaT0VjZIuaZUZceKMurf6GOoCmSkcuGEvyxyQeV0g+oJ0RE6mIFc0w==
X-Received: by 2002:a05:7300:7314:b0:34d:96cb:d75e with SMTP id 5a478bee46e88-3515de9ff53mr7510589eec.27.1791430132472;
        Wed, 07 Oct 2026 20:28:52 -0700 (PDT)
X-Received: by 2002:a05:7300:7314:b0:34d:96cb:d75e with SMTP id 5a478bee46e88-3515de9ff53mr7510526eec.27.1791430131842;
        Wed, 07 Oct 2026 20:28:51 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:51 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:14 -0700
Subject: [PATCH RFC v2 08/10] firmware: riscv: rpmi-tee: cache TEE
 capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-8-45939a13d223@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfXwFvEqwq2D4MB
 mTT/JtZ7ORLzLXEyhcvOvgJkOaQr1IVzvdzFhaJ9CfIFyPq4OfJV3dQ/OgjhoR2cvfA2BxQyE8s
 KtaHgLmUdntsy4vDNp5mQfXipx/4OVs=
X-Proofpoint-ORIG-GUID: YXjCcKdTC5Vh69YH_MprPTuwK3mZSr1w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX+EhPTdUlPtQ4
 cOaKAA7Y26890mpor/vMBxHw6niLHnwhz+7GmYZhRZp7uXX+NmTWxlTf4LPmGBU6TBTIgGwZZbx
 vbC0R4PF9UYEGeJlBfXQQzsBMpr1HWYAKcWput4fxD9Ipdk2u0ggatFSGpx0Uxy8uNuLGRlc/Mf
 4IJVWwApEpzd7fXcqZDtA2JBNNddxJw+NayeNvqKtcdFf9nuAKU5w91zKLm7IvOdjoRlOPO3igr
 kZQSybTHWnhHeW0g+/9dvOMmr65HAG5zk1Y5NkVs57XR0TumIVTQf2r4XornxOa/rix07xia4UP
 l3guj3LInoxXbkN4tHYqAojOHgfZShD6Tk8ZXSB+vELmeSMVCZDvclTZPSXhX1qpKhsfntjCAzO
 0KJJejzFxLn5S87XiuTYDdvmbSlDdqpA56svHjzHWICaa2q+T0ugzH9WH9lERSEoGwqGpGWiJv8
 3x5nBNqRZpwf6SLqOgA==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac70df5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0-kq_-QLXk4bkpNlR94A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: YXjCcKdTC5Vh69YH_MprPTuwK3mZSr1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
X-Rspamd-Queue-Id: 4A36444FC6
X-Spamd-Bar: ---
Message-ID-Hash: RLWL65NJZUQP76CXGZBFMHO2ZFLJCVGY
X-Message-ID-Hash: RLWL65NJZUQP76CXGZBFMHO2ZFLJCVGY
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RLWL65NJZUQP76CXGZBFMHO2ZFLJCVGY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Query firmware capabilities during transport initialization and cache
support for memory lending, sharing, segmented parcels and signal buses.

Distinguish REE-accessible memory operations from those restricted to
TEE-to-TEE use so Linux only enables operations available to it.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/driver.c           | 73 ++++++++++++++++++++++
 drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h | 15 +++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index a683f7d28c25..b43a09f5e853 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -18,6 +18,33 @@
 
 #include "rpmi_tee_private.h"
 
+#define RPMI_TEE_FEATURE_MEMORY_LEND		1
+#define RPMI_TEE_FEATURE_MEMORY_SHARE		2
+#define RPMI_TEE_FEATURE_SIGNAL_BUS		3
+#define RPMI_TEE_FEATURE_MULTISEGMENT_OPS	4
+
+#define RPMI_TEE_MEMORY_FEATURE_UNSUPPORTED		0
+#define RPMI_TEE_MEMORY_FEATURE_TEE_ONLY		1
+#define RPMI_TEE_MEMORY_FEATURE_FULLY_SUPPORTED	2
+
+/**
+ * struct rpmi_tee_probe_features_req - TEE_PROBE_FEATURES request
+ * @feature_id: TEE feature identifier to query.
+ */
+struct rpmi_tee_probe_features_req {
+	__le32 feature_id;
+} __packed;
+
+/**
+ * struct rpmi_tee_probe_features_resp - TEE_PROBE_FEATURES response
+ * @status: RPMI completion status.
+ * @value: Feature-specific value.
+ */
+struct rpmi_tee_probe_features_resp {
+	__le32 status;
+	__le32 value;
+} __packed;
+
 /**
  * struct rpmi_tee_call_req - TEE_CALL request prefix
  * @sender_id: Calling REE endpoint identifier.
@@ -186,6 +213,29 @@ static int rpmi_tee_check_transport(struct rpmi_tee_transport *priv)
 
 /* RPMI TEE SERVICE GRP API. */
 
+/* TEE_PROBE_FEATURES. */
+static int rpmi_tee_probe_features(struct rpmi_tee_transport *priv,
+				   u32 feature_id, u32 *value)
+{
+	struct rpmi_tee_probe_features_req req = {
+		.feature_id = cpu_to_le32(feature_id),
+	};
+	struct rpmi_tee_probe_features_resp resp;
+	size_t resp_len = sizeof(resp);
+	int ret;
+
+	ret = rpmi_tee_send(priv, RPMI_TEE_SRV_PROBE_FEATURES, &req,
+			    sizeof(req), &resp, &resp_len);
+	if (ret)
+		return ret;
+	if (resp_len != sizeof(resp))
+		return -EPROTO;
+
+	*value = get_unaligned_le32(&resp.value);
+
+	return 0;
+}
+
 /* Return the transport that owns @rdev. */
 static struct rpmi_tee_transport *
 rpmi_tee_device_to_transport(struct rpmi_tee_device *rdev)
@@ -371,6 +421,7 @@ static int rpmi_tee_setup_endpoints(struct rpmi_tee_transport *priv)
 static int rpmi_tee_transport_probe(struct platform_device *pdev)
 {
 	struct rpmi_tee_transport *priv;
+	u32 value;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -394,6 +445,28 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 		goto out_failed;
 	}
 
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_MEMORY_LEND,
+				      &value);
+	if (ret)
+		goto out_failed;
+	priv->mem.lend_ok = value == RPMI_TEE_MEMORY_FEATURE_FULLY_SUPPORTED;
+
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_MEMORY_SHARE,
+				      &value);
+	if (ret)
+		goto out_failed;
+	priv->mem.share_ok = value == RPMI_TEE_MEMORY_FEATURE_FULLY_SUPPORTED;
+
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_MULTISEGMENT_OPS,
+				      &priv->mem.multisegment_max);
+	if (ret)
+		goto out_failed;
+
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_SIGNAL_BUS,
+				      &priv->notif.feature);
+	if (ret)
+		goto out_failed;
+
 	ret = rpmi_tee_setup_endpoints(priv);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret,
diff --git a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
index 07e6b9913cb7..0c3cfa0f14ec 100644
--- a/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
+++ b/drivers/firmware/riscv_rpmi_tee/rpmi_tee_private.h
@@ -14,17 +14,28 @@
 /* TEE service group and the services used by this module. */
 #define RPMI_SRVGRP_TEE		0x10
 
+#define RPMI_TEE_SRV_PROBE_FEATURES	0x02
 #define RPMI_TEE_SRV_PROBE_SYSTEM	0x03
 #define RPMI_TEE_SRV_PROBE_DOMAIN	0x04
 #define RPMI_TEE_SRV_PROBE_ENDPOINT	0x05
 #define RPMI_TEE_SRV_CALL		0x18
 
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
+	u32 multisegment_max;
+	bool lend_ok;
+	bool share_ok;
+};
+
 /**
  * struct rpmi_tee_transport - State for one RPMI TEE transport instance
  * @dev: Parent platform device.
@@ -33,6 +44,8 @@ struct rpmi_tee_mbox {
  * @max_call_resp_size: Maximum TEE_CALL response payload size in bytes.
  * @self_id: Local REE physical endpoint identifier.
  * @devices: List of registered TEE service devices.
+ * @mem: Memory parcel operation state.
+ * @notif: Signal notification state.
  */
 struct rpmi_tee_transport {
 	struct device *dev;
@@ -41,6 +54,8 @@ struct rpmi_tee_transport {
 	size_t max_call_resp_size;
 	u32 self_id;
 	struct list_head devices;
+	struct rpmi_tee_mem_state mem;
+	struct rpmi_tee_notif_state notif;
 };
 
 /* Report local transport errors separately from the returned RPMI status. */

-- 
2.34.1

