Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF3FCA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:41:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A27054544C
	for <op-tee@archiver.kernel.org>; Wed, 13 Aug 2025 00:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755045667;
	bh=pKHQi5q0rF4Zjn7LuFjE5W8ncYtz1oBEEOgTdSaapz8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=z1nGQCU3CyrMVm6BOkechmiu8ZsbcUmUghQImSVWBICJgroqINVpBWzY7D/sqh64W
	 nH9S1oppkeh2zHXWrya2kGyQKb4tJKhHq4aD9G2HQ4QgwlYJv0HDZKQcJMFrzV2pqa
	 uzkEcImO8Gsr3wMzmS4A4/xNE3qpjLXuPv8qUOgmZroOyNT1B7duMGPTbZud0H8b3L
	 K+MGktym1bZ7mqkLEXJmn42Ux7w9x5Eh7dt8OWSTUwxpydA4N00Zu71neqX3gWNwWN
	 EPcle7BYSoiJGTgPgJQ0wBTqwfhZmsVi7Iweufs8VrfyFZl1p3atN11PHI/DrS9Joj
	 fguT4AOnJCZWw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 407054FC97
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KoP9mL0+;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJePxM025497
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b+IO/mYYyn556/HWuKEpMTj/0Tt68TcQ9XKAg4TOT0A=; b=KoP9mL0+5p9sVY5g
	DB+MjLf0Ot0KNG+qSe3KtuAJNplE80NHP1+TMqGVmsHUGck7syVisYXR8IH28s1H
	WiRuZXFRqr60rH9Npqn6JVrO/C7Hm1kl/XjrtCLkxMWZrM3jgOpxHReTp+/vKWHg
	RL8lFgwJYj/EIJ33JFiCfQaqb0n0qbErhvvhClbPcS1YoqcFqmq0pXP3mLWeHCT+
	x+UqLi0ReH3XZM8tHJolPV/d2kYu63MOPaY5rf/edyfRBNRA2VQJex+G9nY3NXvU
	pRHuj8GCoxixxiMAku5PnqQFto+IjLolHKzGQlJ4u4Juy2z6U5s6Efwac/XKHXzZ
	BmMMxg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dw9st45n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 13 Aug 2025 00:37:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-243013cd91bso11679995ad.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 12 Aug 2025 17:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045430; x=1755650230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+IO/mYYyn556/HWuKEpMTj/0Tt68TcQ9XKAg4TOT0A=;
        b=Rm7JbDC9PTUr5Ek8XTjOWkP8LQU2VEctqnYcz4slrkDZcnvztgc9wRbhbJT0t2CjQL
         Xns/L3o/acOk9OA/M/eBu4Axg5N9ofLp3rn7FcPLu+X2i3Y+TFxIOjfbi3xo5qDnkx2/
         hbs8GD0uG7C4oq67IGiTRV+K1uCWxfAj3rMV4/V8TnzJuMtVHmeIbGiwHgTykKzkdEJ9
         ZeMQ5vRLyPfqPpG+mW/8sV8U7FxXIe9Zzf32R3z4lFGTSty+ClpFSkmQxi0v2DwnFVLO
         /hbPEPVWjz3WXKwp51xGoZfIE7AaznM02D0kdiB/DD1CuOp9S61VIdMoWujIpBtNmP99
         ZyWg==
X-Forwarded-Encrypted: i=1; AJvYcCW2H8LBKe7t4r8F5/xMgaFLxGUKr6XHHDWp/D2KdsCkOU4/X/wAEOMnBAHmoBe1MJ2RzCd0epA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YywnNX1Ume9VAvZ3AbROPUpnQOXQbH+rQ3NeHZMlKI/MtYRnqT/
	+jP+nJtRFd6N/oDMtPh0693g0BEyMs9QDHqDvo7N7P4usTk1SN7KuwIQM++uBdvL3LQc2PUjRcN
	g7jcziFlsjcerge6Z5ID1fAzrwd85UHkud+dz3f6u82AIZNzk6nKyg3fys6NRNVSfOLD1UKA=
X-Gm-Gg: ASbGncv5lmITvr4zQ70sB1semC7dFAGCCpRnDhVxvOF3w9MgG0wSIoM/q3+EhnFJl2w
	j10XnuwFXRBFNODI1Ta0c6O4jLiQn9AG/g8wJdbeXPsCHUpsSZV8XQ/UiOLQjs3cH8Y5HIyXEOx
	XmM2sGtu2vX/mpj44b8dtGqxx2qvJsMnKIAds9ulnGTbvwS1yF+aAda6uMb+0DLvV8vGwVQdQX+
	EHGo2nj7ggxN2DjWXVXXxKujEzC0KUaDBsCB9yMisjv59d3aVpR3jtj4Kwd8vWfb4QgxSAW16XN
	Px8oJvAWvpV6l+ngGvYzSJKFJqFrVOibStZ4fdU+Yuc2W2DzanmDkSvPUvbhciaxAgootqsrISy
	g9G5lJgeI2yGww9nA+o9PEAM=
X-Received: by 2002:a17:902:db10:b0:242:86e4:3d86 with SMTP id d9443c01a7336-2430d10df6amr19174215ad.8.1755045430205;
        Tue, 12 Aug 2025 17:37:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXqDrIPqSDRuMX+/u3XPMvQEItZdm1JDG7Hzxm2pbqkxQe9lDrS+2GxflzEd97bkgHKl+fEQ==
X-Received: by 2002:a17:902:db10:b0:242:86e4:3d86 with SMTP id d9443c01a7336-2430d10df6amr19173735ad.8.1755045429681;
        Tue, 12 Aug 2025 17:37:09 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:37:09 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:35:36 -0700
Subject: [PATCH v7 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-7-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=J+Wq7BnS c=1 sm=1 tr=0 ts=689bde37 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 82dlXvesPqQ5ujWDsTdPstyUcP_5bqFb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAxNSBTYWx0ZWRfX82ThQZsTbpkl
 W6AZfkMtKKy/2wPTNtPyVOCXmd+KrpvJZyhZZjd5yjuUKkds7ydreRFckSLmjZZgyQTuzFgp6DH
 Zv2thuvotoALJrpATop48y2i+t0K7UVoLzEbo9OlLZiB2AasnptnXFv2nPj+E3XCtdIUn2CajN2
 at+JHOzFadDcUsRjKWkukcrNd+XG2gGpJwxslr6RMQmthAujYJVx2PpUACn1VJpPo/HqQymWpLU
 6ANL/l44pwj7DpWBEDqQLtMPkHB0k5wyw/NhrkZUnEfj8ZKY64ulERgyTZ0uZFtE3LAo/Q8K8Fj
 byPARRJ8Lesbq0DPFDbsFS8XUNzIsQfjUX9XANKZ0zre8AjYjEZo9HhSpYrzPSdjDFtTHlDLWCc
 RkzXZDmM
X-Proofpoint-GUID: 82dlXvesPqQ5ujWDsTdPstyUcP_5bqFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090015
X-Rspamd-Queue-Id: 407054FC97
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: CSCO7VTWUVH3BENK7JUUBXOEOJTSUZKQ
X-Message-ID-Hash: CSCO7VTWUVH3BENK7JUUBXOEOJTSUZKQ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CSCO7VTWUVH3BENK7JUUBXOEOJTSUZKQ/>
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

