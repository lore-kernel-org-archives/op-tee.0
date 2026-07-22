Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA3C44512
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:01:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 37028451A9
	for <op-tee@archiver.kernel.org>; Wed, 22 Jul 2026 07:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784703691;
	bh=UutwisPxLmXUS8raj8VcKR5HsTjTxGdmVUYtVk2b150=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XPZzuneHfw2EDdB5ES8WRvE0fZqM6jmBG12/7u6LZe1b0yPiSZ3FdDAKxUhczZMM5
	 6FteSAzT8/Wb7A7fZAOY72IJ3gPFX1wYs2jYPfF6TSfwJzYviEtWu9qiNWNXdVLlzG
	 t/kX+LxYrYjiv8Ylo/QV7BznljKTMZo2pm2LMIWMAvO+TxqiV/czjuLpn272m58MLb
	 k1spp3PRV5i/5KSHK65xw1HQ6qYQ8Xu3TF/exNYTFMAuyhu4Nz0d3JK0XEBrHXXWsy
	 mzEq87q9SMypHDHajUK8PS/o2kAYnr/HbIEAXl5ZCbMnuekPlK3n0VxwXiqim07FkC
	 GCUrYUYOEl/og==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C5A41450DE
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nUbNWyQu;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FB9T8rE1;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M6foSI200347
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DN7n/bdfkW6wuLU+Ox37xcY8Be/ZEVNLsXfifpOhL+0=; b=nUbNWyQumK/DBmof
	ASV/5Cgecfp7vw6pRDIrtK0EYgydzKrCfa0aRoZF+9toVz4+GSPKwov0nLunkk8i
	/XTTrfT2uz9/qogFAy11SXiDSmmp8b5e8zhJXvGhFrxDPCL6JB8hlSw08bfKi3vJ
	jLiaf4iAFe82/RU0aQ4pWZxhctj3hgY8mxPp5QDvp9NZbrVq0y32j5ORByL2Ph18
	8uaQNy/5KllxXFiFkeL9J2pR4lFFowwcE32Kympw/QztfusgTZmkwPwNQqAoyUXw
	k2o7DwWbkLqW0VcwSIAv+a/c/HBTDcb8s//vIcsIV1LbJfgOcqoa7nqbIMJ9vQnt
	eGdrhw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt02hd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 22 Jul 2026 06:59:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccafc5e82cso118077015ad.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 21 Jul 2026 23:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784703596; x=1785308396; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DN7n/bdfkW6wuLU+Ox37xcY8Be/ZEVNLsXfifpOhL+0=;
        b=FB9T8rE1ACbXzzPZc2Qlb2O4QSMxAtRYX1Af7g/KqX9B/JVebXe1+UYoctvJ3pIZox
         MTrYXD1lHnMt1R0UTQ8/Fq4NdaJLVFHQWVWw/mxCNLXJls77ax4K8xFbNKeDqoCH4nRY
         /OKydQMJvZ0PE9u39Pz2yjfjChiRSKCgW9vkmH0f43QJtqafeteuPsQdwmoy5rq8GeIk
         rd80BGF4v63Vvyck+lpCSBQfgmKxYbM7MjxIkTscs52fr+5QWfcXfln2nRU1UAQK0fzi
         e0wvS7sbHhlrhUI3q9qB2kkq6G3PfI1afHIAxig2O8Qx2REEokjF95cnvGTUo60V40Ya
         raiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784703596; x=1785308396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DN7n/bdfkW6wuLU+Ox37xcY8Be/ZEVNLsXfifpOhL+0=;
        b=XwYLHJ75OjzmchR8tv0C8ptHg+WxSIVZTuWLfGrEhILjU7EX5x0UBj4B7VF1vxguD6
         ddIIYvEqmhm3bkQTgI2WT+S1V9RiFp+2qXAQMgCmSE2rovP8L71Quq6zl9ymldjpexRj
         daEQlqzB2OkqMIzVmnKV5RTdyrnD1u8TQnV03OMH1ZjlDFGXm0n+MdGTMyAcxBQWuJ08
         7ew/BWQxESOckQY5qAFpPbAm1yTGYPn7PgtqptDugEh7sO0fdTIyDhPw63/AepqlHw3u
         Tbjslq3a50RgdmiFIIfNqUjf+lcuwehInGieWszr0INSxbkcW4Lwwk1nU+KrhkEif4dj
         6nnw==
X-Forwarded-Encrypted: i=1; AHgh+RoXxsV/8EHFlPA1p7hwkOxrtBg2fHuw44sukBt2eDmhYgjpaKserLoJOAVk5QF7gB62EekGXHA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxlpTMfJRvOl5KXztVl//b/ZZwidokm7YZ9veCxsAdB+32A17EI
	UUsAWerUOjChGoFQwJZ3vuTyA/j+qlOy1J2F3hG+1LpLlQi3QqQBsH6VsP0CO/hKa1nRYZjwKo4
	E+/poH2FBXUl8Z8Xj4KfgfUexafT0YaOSLAZm60kBKQCc9hTLY+EehwwCjsBUwEXAhsVVNORp
X-Gm-Gg: AR+sD12QfzV9S+CgEOJxZp+76Y9Q490qEsxx7Xg3S/UfRTJ+loZ9yBNkqHevQW2s0El
	Z7LK7YASW1EqnhiEDHUqpOvABRnyfjP0jIP91jmNqu15nfub4QP2TZ9HEV6QZuL2p2JfiW0NDc9
	DCp8Lm8WKaLN5C27/ERKWmHtvoXZuzZdElKWuUAU0GB1f6TEePQmJObCL6MdL+RfNPc/1X8xrqG
	urCnP/9H0GDs+PEjL7KYYY7oUh8VyRH+uRikSCctnMZw2yFoCgNh/s/Gr1J1uVQPHXhNyRMJw9t
	DYAcW7QzIyszpiaZ16G1KnjxwbvPrfc1FK91p9g3L4J7/EvUvKw5KFIuQH75O173Tgn3dBrDbWJ
	DN3nOdIoHo45GlyV4hz4NB0cUUw==
X-Received: by 2002:a17:902:d48a:b0:2ca:b8fd:f31 with SMTP id d9443c01a7336-2cf34889935mr241887115ad.15.1784703595872;
        Tue, 21 Jul 2026 23:59:55 -0700 (PDT)
X-Received: by 2002:a17:902:d48a:b0:2ca:b8fd:f31 with SMTP id d9443c01a7336-2cf34889935mr241886725ad.15.1784703595269;
        Tue, 21 Jul 2026 23:59:55 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efd88f7sm9428935ad.22.2026.07.21.23.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 23:59:54 -0700 (PDT)
Date: Wed, 22 Jul 2026 12:29:15 +0530
Subject: [PATCH v2 4/6] tee: Export uuidv5 generation for TEE backends
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-4-b8a8fcbe4211@oss.qualcomm.com>
References: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
In-Reply-To: <20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784703569; l=2841;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=UutwisPxLmXUS8raj8VcKR5HsTjTxGdmVUYtVk2b150=;
 b=e3840ElqGSsbHCB/vLaMQ0i5nkwNtX7qIXk4AQ5l3SYykOH+T0ZsgFDH5wsLcBe09Pbg1b0lV
 ojALYmxiZ/7DcaLepple6Z8D1EJcn3Wc9nlMRylWSvsb0nWaz2EIMLn
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: etx71Fw6RhP00JcSkIN8pWbjMCq6DxR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MiBTYWx0ZWRfX+cLQSTjVnqZV
 7ixXh8H3Z3mtULzr2RevcC/IG8khiAFoFrc1dtfCtI8teGQTZdN/2ScmMb0POOFdQolBUGDJTgV
 sPdXWWWLmsEEP8Yeyf0yjZDfaBXhQMFA+Gkcpg5kvyUmke0DP7xcBp7GI1HLJj8CBKPtwz0abwC
 zoyAnJgOY7qcuUFfUvIi276h4yHwgWQYdVPaPKUv6/P/5YAVcECGelSP6oi/He4naiqmOW3WY4v
 L26shO4Wu4/WHlOWzcqtIMc2eoYRgW2qTq9BKmP5ySVocgWGYVl1FI2RPeZX9vycy6DzE3Ut31D
 hJnpX0KIRJ1yFrT+CcsdDAWXsvoEWx5lGzYhTR1zqQeK9tR7kNqc5pKkAGTM20gxrSjerm0cIFK
 TqViXsnVZY8Jwgj6TBLNvKvxqBKZ8+rey/wmn2oxrLPSTGBuKAPAvEgeYYi4I2bS+rceuGxUE6x
 +lhakDulTFWmk+qodvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MiBTYWx0ZWRfX3IFJZ3oxYcWF
 jhkwPP1dXWmwZ79eBTQ3fXLL7PhtWg/68Rlt6Y428vb1FhPDwtOEqLZeaiJQyVv03kSISqIlHVq
 VfJSTurI+ykJFDzAkNxEbuk5hsJUaKA=
X-Proofpoint-GUID: etx71Fw6RhP00JcSkIN8pWbjMCq6DxR1
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a606a6c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_y_UpZ8dDEjReVSEE2UA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C5A41450DE
X-Spamd-Bar: ------
Message-ID-Hash: TLDO2JPWBZ5DCFAMY3EF4UI47TGXGGWD
X-Message-ID-Hash: TLDO2JPWBZ5DCFAMY3EF4UI47TGXGGWD
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TLDO2JPWBZ5DCFAMY3EF4UI47TGXGGWD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Export the uuidv5() function defined in the TEE core to all TEE backends.
This enables the TEE backend drivers to generate a UUID for identifying
and registering their secure services on the TEE bus.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   |  9 +++++----
 include/linux/tee_core.h | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index bb418490f3af..df88727b3680 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -135,7 +135,7 @@ static int tee_release(struct inode *inode, struct file *filp)
 }
 
 /**
- * uuid_v5() - Calculate UUIDv5
+ * tee_generate_uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
  * @ns: Name space ID for UUIDv5 function
  * @name: Name for UUIDv5 function
@@ -146,8 +146,8 @@ static int tee_release(struct inode *inode, struct file *filp)
  * This implements section (for SHA-1):
  * 4.3.  Algorithm for Creating a Name-Based UUID
  */
-static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
-		    size_t size)
+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+			  size_t size)
 {
 	unsigned char hash[SHA1_DIGEST_SIZE];
 	struct sha1_ctx ctx;
@@ -163,6 +163,7 @@ static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
 	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
 	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
 }
+EXPORT_SYMBOL_GPL(tee_generate_uuid_v5);
 
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
@@ -228,7 +229,7 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 		goto out_free_name;
 	}
 
-	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	tee_generate_uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
 out_free_name:
 	kfree(name);
 
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index bcb5418d6fdc..a3f4f88b8423 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -272,6 +272,21 @@ void tee_device_set_dev_groups(struct tee_device *teedev,
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
 
+/**
+ * tee_generate_uuid_v5() - Calculate UUIDv5
+ * @uuid: Resulting UUID
+ * @ns: Name space ID for UUIDv5 function
+ * @name: Name for UUIDv5 function
+ * @size: Size of name
+ *
+ * UUIDv5 is specific in RFC 4122.
+ *
+ * This implements section (for SHA-1):
+ * 4.3.  Algorithm for Creating a Name-Based UUID
+ */
+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+			  size_t size);
+
 /**
  * struct tee_shm_pool - shared memory pool
  * @ops:		operations

-- 
2.34.1

