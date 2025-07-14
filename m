Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F44EC83F17
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:56:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C349B45A36
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454561;
	bh=LngZWuqGTcAyjaZms8R/hflUlpdupIY3ruEN7UGo2Ds=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3+MZrQbZEGSOfFBcASL26LmjFT5v16IX/tqw9ZtvlifnkUJmLjN/NUGOqS4Q4Zu/V
	 7GZT4sYieiiG9NxkexOrZIOsB+rsyQA0M3XBjtUTAW1X0GXtBKXOro3FPTsF+oQpmp
	 3DRYknn+hQXjhfPa0GYite9PicUm26NbQFlAVOTFFBpuL7GSCYXZ0fgclD6M0ovBcj
	 qagOHhrvMACxnrdQZGKEQ6j6oBESm/r3aFFJB5n/gcXAtz+nHlp1imz4j9boOTwAD+
	 u29aj1T04Y6Sf7VFbXfV0s2bLN/y5KZ8GNyaqGIY2tHY4MSY2lXLKl5XTS9lbQsKC5
	 m8OCUWdWtkH3g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1321E409FA
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ABKvJtLD;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLTRis031729
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K5ZMFVD63Ff3BL9GgM0LUadXZ5oipT6BmREzK1uu+zI=; b=ABKvJtLDl5/6w8cX
	ZfFcm+Eb23kIrjVXIhXiZpVDHxkbYKOC+9aoYxWS3yAxjEykcB/bFqEOlmOlWdxJ
	eOGFu6Fa8sJjTmC5v4Ckqlshfsgf1XCToY3/03ohWJCz+DZh8nABuLwIMvxTTsPv
	RC0gFv1S5V8PjP/WxmNZG27rGGNHdz7+JQ/gCpdHbSVx/nD5I0G9IDxmf9NBns7g
	+nngRz7SN5F64kiokwpIsihh4qHPLXx3OVMQFNzEmEbRfWh7Exs/LRQH73os8x4V
	XaJmQRKH1YqucJgsVS1PreDPPP2a5ASWyTyO/mx6D4nBgc80CEefrTwS4ImFEw0o
	d7nl7g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhat7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2369261224bso43013825ad.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454232; x=1753059032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5ZMFVD63Ff3BL9GgM0LUadXZ5oipT6BmREzK1uu+zI=;
        b=mJ0zJThzBDMrWY4laCqen5N8r0zq4bDozh0/EirebaAcutD6ggiaXwHfdKVHh5Auxa
         40Y1ubMhVqMmlN2m3ZUXBG9sGNFdUqQr1lzdxcK/F020ELS6Li25yqDkmYMwv2ohF6Bh
         2ZViTscqMI4+/wQWGViIxBNsWbJ5ahjwiQPxpg2HWnSHgwPOe2kV6qn7h3Gz3b/VLa9s
         N5sawweZ1i6Lx9x58UYtf3PHtmu+nOw4tqIYC75c7SoHLDJVmV3x1OYsGwBDAI23dOXx
         bXY8y6cPXpYP8zhReRgkNznu3FCNvaMP1iPbh+HVY0ioq+T3yapd7klf0AkB4WhTZ0HX
         atcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUROODLtrkHkroR1y+k1hwXPU5X1KidT6p9k+2qVykB3PZoyJYCyGeLg+RD2m9r3F7Wtk2FoCI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzI5z/xrMEDB5qYTZRBGedu6PpEk88rvAOZp8s9N10EUi+xVGI0
	9CsrKB2uoTCiMndoOJWYLIY9vMxPcq9t/r9RoCYt8iU1q7m4qESpij32q/0Ssr46aZl/VXy+W2Q
	JLRYspHzMPAdAjLx7H/pj4pcbkV/ux3pgwF3B6ZySEqen+gwFLXiSIQkaghgAmqzhlItPWPU=
X-Gm-Gg: ASbGnctbm1IOB6YJ3QjTOPw8Xwlxq/jCp/fhWWTz0Id+PRoVVN7dd4gmaLcYdhYPUYL
	qGbLkZCeNL1FxEb3uVaNouyf2NxHg0L9fHuiMWuUGIxNeFMH3DmI70c3B3Ng87/aAQ4f9XKh2TQ
	R311rw0YE3+UqjKawDAmcvv/Sh3uH6ilLSMVD0ggYNwzIP6w7+n2bAxUKurgQVKXIKHhPuxW6On
	amx7aqbLKjHgdSaVb92AX+wCMwDp3j+R5TaB0JTrR+4A/gp0kQQdHWY27rrnzCelFqNVSTn8WYd
	GRRvQaV9RQrgWKiPXIrtaCcMIMZRNq8rO3ndeM/hnNDC9SFj+vZwx5U6vGf8/gvRDyGsp8WaVIe
	WubbHLXgXGEkOlizGJzKs2d8=
X-Received: by 2002:a17:902:db0c:b0:234:bca7:2921 with SMTP id d9443c01a7336-23dee236124mr154227165ad.33.1752454231966;
        Sun, 13 Jul 2025 17:50:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpnypaVo17t4xCHlw6JEOmfm/XfLJ6d6mcw7BNhB61avFNU3lRTWBaNVX54usp3AIPAx45Lg==
X-Received: by 2002:a17:902:db0c:b0:234:bca7:2921 with SMTP id d9443c01a7336-23dee236124mr154226815ad.33.1752454231502;
        Sun, 13 Jul 2025 17:50:31 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:30 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:20 -0700
Subject: [PATCH v6 08/12] firmware: qcom: tzmem: export shm_bridge
 create/delete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-8-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: C4YGIkazuzaAkZwAp_1u6BSMeftyRCiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX4cR+gIZIc8fV
 B4OnQIL/gmcQ4sEPn2QrTUiJtXTq6YDTABbKgHfO+D2NRdw9VC6xJkRNHDU6SSX62/1Uu76seFU
 K9LJbqxiY8zs/4y7xRznQWv8+YdZe1zhAebW60yB/JflIrDB4nXhgH/T9EtMuzzFbMCYMgAeO8r
 hWgna4TETFw+5VI33mhj9skjBGRNbdeBQkjawea3n5/e4qjkosOyGCfgZ7MQbZhJaQtaUL7HVe9
 wU6iqwROsv24J97jeepdJ2Mp8Qpa9vY1GeHCQxV0vLu9tFI5m8btGQjVFcGPXgnj14kCnqRE6G7
 LwS0qxr0c23fqNbZG0d0iCJ2uJywJWzzcln32iv8TBCU6V/j3x0+PxdO9x8yCvJ2T74HsQSD1Sr
 7Bwv2db9qZ/1gL3KmNfu3aenlTLFVUk4+NMxwp76NhdE9NAp1olAxqgo3+29hdsTwFMSW+l4
X-Proofpoint-GUID: C4YGIkazuzaAkZwAp_1u6BSMeftyRCiA
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=68745459 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1321E409FA
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[205.220.168.131:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
Message-ID-Hash: MXZSU45NVBRCCQXJTEEOUVSDBRXAWATB
X-Message-ID-Hash: MXZSU45NVBRCCQXJTEEOUVSDBRXAWATB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MXZSU45NVBRCCQXJTEEOUVSDBRXAWATB/>
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
 drivers/firmware/qcom/qcom_tzmem.c       | 62 ++++++++++++++++++++++++++------
 include/linux/firmware/qcom/qcom_tzmem.h | 15 ++++++++
 2 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 4fe333fd2f07..f78404a8d9fe 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -108,7 +108,19 @@ static int qcom_tzmem_init(void)
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
@@ -116,17 +128,48 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
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
+		dev_err(qcom_tzmem_dev, "SHM Bridge failed: ret %d paddr 0x%llx, size%zu\n",
+			ret, paddr, size);
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
 
@@ -139,10 +182,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
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

