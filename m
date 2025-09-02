Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C32CA1007
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 05:00:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4F29B4FD50
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 05:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756789254;
	bh=14ZTHl0WyMlTosvSsdQcfG20Corab0amwL7v8YXssQI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=E683fL0hslML7DZxMka4Y4t23OW2VPoy12saoy8loaawaOSmL2bS4GCHkbC09Ht/c
	 9r5WA81vi0xqOfOZejOu1r+KlHxfE5J3sEbFmaf59yNsZa0urFJPU+udQGxfwBOQAQ
	 UEVEGNLIEca0leiuFz71cw5CVA+xaZRWoSF1VgGn7IBZgSv9nMeRgjrBlqS/Z8bdQD
	 ClOTTaBKoHKqR6loXdwyuXRCZBpgzTFXQmzgbsJ8l+dX0ZZDlW+rzRQJdMUcYoI7Yq
	 WQLQ+65m1FZcoHn/itvW8Adf2yLCvHN1BZZD3j0Eq+WPRGysPBH4oAgnwJ223tFhgY
	 YIkyNfqXtPn1g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E76AB42E22
	for <op-tee@lists.trustedfirmware.org>; Tue,  2 Sep 2025 04:56:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YXg/LiFV;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SGGU030247
	for <op-tee@lists.trustedfirmware.org>; Tue, 2 Sep 2025 04:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=; b=YXg/LiFVAsACtXPJ
	+FHkmpIRGMsYlEsL0KYdLYbObGiQRj/cX6RuLEEzDDPlXk3kDAw/H4NGVYAL06QL
	8AqO0Yk3wWtFZqZTHpBr6SoVNaZBlL7NHOrDD8GsQEOtDVh9IC9Z8PopLkodv48C
	Nuz8FCGn8dKw4iQUK2nRC0xt/LzErQ28L/PAaeynvIVKiSREsFt8Hrs+iaMYEaUM
	ZUCPEYSy94EKx863nLQESFDzlyLhD8L2YO99/+oOMnHrKpGedGlT+d2E69ewvwcw
	emY0dj2eWKheYm3ynZsAZgLChtQCtV99W2fJBY7swROvrg50EIvNb1xY03x23nWT
	QPp/qg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy2b8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 02 Sep 2025 04:56:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248981c02cfso54469915ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 01 Sep 2025 21:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788982; x=1757393782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=;
        b=YiCJapFbtlu9RA0AZLMtuJAKhBM2XUft3LDOfAiYefgYva/h3WJu0CZ2PwTKu7ibwS
         Z7rI4VS5fvW6DLK6OlhmEJpf+LoceUnOfOmC18d3VZ5n+611kKSWJHutrFSDzLZzE4XO
         +z88Y5kOkMEh8TaIoXS2tXt9KVuOZ3UGblvUaC5A1bvj03vw4iqhZ4WSQO1kBc7Q2jCr
         HcJwaTWBoefXanmxbkSEKVgHg/oOWhPkeJPhrnCgCTm3PO2tlyhPGA2Muzx2ZV/bX9+E
         pjddFxLROdPPyudl37xPeZS7hc8XSAp9z8gg0YCnStd1ijlkpiuQE/sOxtZ9Q0b4ZxTD
         eSCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQeFNY9/xVDT7JM/hx86uOoWYqgjSq/2IyfUL5j8xnplNIzPoFRQoV53eNH6bpeemPWA1HDus=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz/YfPhH0Q98/a+NNxZKKJmD/ratjbW1gw0RzeeIIOLxTDgBorT
	KxQ7ZwAw7Xkfkh9W1irQkkI0xenZ++ntWdHBiJHDeEoZrCeLRDnHY7Gfliwi8ink+X7yZFehYeA
	FXF7Yq13ltXxw2GVwz5gOXPuOoDPKEup62K0RlapY7OSSRcM6VDaD4KCne2jw1GleM2gU9Ng=
X-Gm-Gg: ASbGncu34CylXDn/PYOtBcsMOjcU8V+srKhJlZw5I4L9C1K6tTlyItZvsTpoBpZ62Ot
	35kfo3TTswJy90hQMFzXDICHMouQi7m1LeZfmhn8txa8Si3dmZp1Q1o/s/OTUjt2dd9ufdPg3mS
	qzGtL2QS0dGqPqXKM6OLdMbpt+VuPqWotmTO1WQxQwFcpDBd8/lEg0kEAP7Caup+wzA+Y2ww0yR
	r+NZEUCrqF79AHVOGZvPmjAnj6m3/KtBAmRT5KgfVdrEYvgbO8aoreeFQiyDoDbja1vPSoU2ANN
	wnLm9rFfZEFY5Hx96hIXoReLkQrpqJN9SpH2RypossBM9bdaU9AJPnfJ/0Eo4rZKzfBaMY6Q4ap
	ia/ru9PaXHmWp25dOZn30jQs=
X-Received: by 2002:a17:902:ce8e:b0:24a:d582:fb9f with SMTP id d9443c01a7336-24ad582ff3amr71120375ad.34.1756788982039;
        Mon, 01 Sep 2025 21:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwKlUPTcvvuepjIGRNGAAh0Ajjaqx7aWVyJoqopok9+dG27RrtPW9DkeRIgzIE6PKFiGoxdQ==
X-Received: by 2002:a17:902:ce8e:b0:24a:d582:fb9f with SMTP id d9443c01a7336-24ad582ff3amr71120045ad.34.1756788981551;
        Mon, 01 Sep 2025 21:56:21 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:20 -0700 (PDT)
Date: Mon, 01 Sep 2025 21:55:54 -0700
Subject: [PATCH v9 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-7-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b678f7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: UKzrVPPFoowHxHoBWKldnRP3V-6T-Yyj
X-Proofpoint-ORIG-GUID: UKzrVPPFoowHxHoBWKldnRP3V-6T-Yyj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfXyCSntOyhD4t9
 4k2t9EmzF7Mp10QP8gMBUoQaXbDXQ0EwxkXw70Ei/9eTbEn9m0Rlt/JMXahCuEQnciVxIwCQ/S7
 JKixHFuFTAPHkV6hdvjQBVwSoQZcxkPYF9YTvQWizszxp5MLbvbBLyI13aNETpw4nip8BN/THqP
 KqfpdHjBbjn0tmflgidyKe1+X2GM1hdk98OAHktOAsk1DMw92FVnQJrKbrJ0PnOwiXy89Db9qN/
 FQ8+COdo8CUm/QAS9u3PSYeC8Wuy+dbzOAg2KQnArmYaDlsPFrqkkHgyFJUCL8c4yDo8kAst62s
 2+55s1aBqIAyIhvniNnSHrcFPIf9fTUqTgpr3bn9AeVwhUv0J/0Boty5shH9JQUWkJBXcg235gu
 OvcB54xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
X-Rspamd-Queue-Id: E76AB42E22
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.180.131:from];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: CVDQH5KYFM37I4HREBID755XZKGQQOUW
X-Message-ID-Hash: CVDQH5KYFM37I4HREBID755XZKGQQOUW
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CVDQH5KYFM37I4HREBID755XZKGQQOUW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Anyone with access to contiguous physical memory should be able to
share memory with QTEE using shm_bridge.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Reviewed-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_tzmem.c       | 63 ++++++++++++++++++++++++++------
 include/linux/firmware/qcom/qcom_tzmem.h | 15 ++++++++
 2 files changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 12e448669b8b..9f232e53115e 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -110,7 +110,19 @@ static int qcom_tzmem_init(void)
 	return 0;
 }
 
-static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+/**
+ * qcom_tzmem_shm_bridge_create() - Create a SHM bridge.
+ * @paddr: Physical address of the memory to share.
+ * @size: Size of the memory to share.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function creates a SHM bridge
+ * for the given memory region with QTEE. The handle returned by this function
+ * must be passed to qcom_tzmem_shm_bridge_delete() to free the SHM bridge.
+ *
+ * Return: On success, returns 0; on failure, returns < 0.
+ */
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle)
 {
 	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags;
 	int ret;
@@ -118,17 +130,49 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
 	if (!qcom_tzmem_using_shm_bridge)
 		return 0;
 
-	pfn_and_ns_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
-	ipfn_and_s_perm = (u64)area->paddr | QCOM_SCM_PERM_RW;
-	size_and_flags = area->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+	pfn_and_ns_perm = paddr | QCOM_SCM_PERM_RW;
+	ipfn_and_s_perm = paddr | QCOM_SCM_PERM_RW;
+	size_and_flags = size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+
+	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
+					 size_and_flags, QCOM_SCM_VMID_HLOS,
+					 handle);
+	if (ret) {
+		dev_err(qcom_tzmem_dev,
+			"SHM Bridge failed: ret %d paddr 0x%pa, size %zu\n",
+			ret, &paddr, size);
+
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_create);
+
+/**
+ * qcom_tzmem_shm_bridge_delete() - Delete a SHM bridge.
+ * @handle: Handle to the SHM bridge.
+ *
+ * On platforms that support SHM bridge, this function deletes the SHM bridge
+ * for the given memory region. The handle must be the same as the one
+ * returned by qcom_tzmem_shm_bridge_create().
+ */
+void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+	if (qcom_tzmem_using_shm_bridge)
+		qcom_scm_shm_bridge_delete(handle);
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_shm_bridge_delete);
+
+static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+{
+	int ret;
 
 	u64 *handle __free(kfree) = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
 
-	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
-					 size_and_flags, QCOM_SCM_VMID_HLOS,
-					 handle);
+	ret = qcom_tzmem_shm_bridge_create(area->paddr, area->size, handle);
 	if (ret)
 		return ret;
 
@@ -141,10 +185,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 {
 	u64 *handle = area->priv;
 
-	if (!qcom_tzmem_using_shm_bridge)
-		return;
-
-	qcom_scm_shm_bridge_delete(*handle);
+	qcom_tzmem_shm_bridge_delete(*handle);
 	kfree(handle);
 }
 
diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/firmware/qcom/qcom_tzmem.h
index b83b63a0c049..48ac0e5454c7 100644
--- a/include/linux/firmware/qcom/qcom_tzmem.h
+++ b/include/linux/firmware/qcom/qcom_tzmem.h
@@ -53,4 +53,19 @@ DEFINE_FREE(qcom_tzmem, void *, if (_T) qcom_tzmem_free(_T))
 
 phys_addr_t qcom_tzmem_to_phys(void *ptr);
 
+#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
+int qcom_tzmem_shm_bridge_create(phys_addr_t paddr, size_t size, u64 *handle);
+void qcom_tzmem_shm_bridge_delete(u64 handle);
+#else
+static inline int qcom_tzmem_shm_bridge_create(phys_addr_t paddr,
+					       size_t size, u64 *handle)
+{
+	return 0;
+}
+
+static inline void qcom_tzmem_shm_bridge_delete(u64 handle)
+{
+}
+#endif
+
 #endif /* __QCOM_TZMEM */

-- 
2.34.1

