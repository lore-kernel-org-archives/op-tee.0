Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36C0CAC582
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:12:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3ABDA4FDB1
	for <op-tee@archiver.kernel.org>; Wed, 10 Sep 2025 00:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757463144;
	bh=14ZTHl0WyMlTosvSsdQcfG20Corab0amwL7v8YXssQI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=i/zdhQAO06GGJJMUpi3AS9EpBdTLCSDzHWYXdFvWG8N2xWq5OO/XDDCfwW4qmVqW9
	 /NhLmjjUVY9do79uTfECZBa8Rx1RSX70fiKtcy+mjg9BobxvrzvOlXnwaw1SgPYhYj
	 hGl3wP+2LSQ+F2nnJMk+8nHf8/zVTqY9wqnOhC3cpVMwmJZCEnLVj9HPhfiafN9g9z
	 gqmelBaFObWobLzrTUEKm4SdxGDl3A0vvPHy6DOjAioKuWSugxQmxh5fWGsmL0rRnv
	 +nASNavEsnnDf61RfZG54iFO46hcd55+EalStEgt8342Uk4g4S9WJp3tVDYzIzO0Aa
	 aKsqsimUpelRA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 063FD430CE
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QeYwalUE;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Hxrc3024975
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=; b=QeYwalUE9RS+dIeq
	zVZqu+TYV+H2TDSg3eaaY817tAMoGXTM8pWJPQh0KTeaw/Kzg7widV4Y7aU0XwVB
	CKW/vng6q9gPW8bs0i5wqWJv4iapO5uT0LfQD48HNx6h/uNc5ltYy6LmvKSMVkp3
	m+ePDUjnZvq/DFgXFJ/6QVUNF1dwrc/D5EDV3gfjcu768fEr2pYzyrzXmUx1RYjM
	RXOQSd1grQ9qGWpg+xrWgWYzPgNA19s829QodY20JXARHOoA0B4ftzYW8ucZ6Pc7
	3bo6rpD84O/FUglj4Y3Fzj0li04QKjYkGkBWfVkeVOcYUYG9c2i20IoQK0Nsxe2L
	PZjjBg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490by9223m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 00:11:19 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so6197709a91.2
        for <op-tee@lists.trustedfirmware.org>; Tue, 09 Sep 2025 17:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463078; x=1758067878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=;
        b=fIpDuSQ3Yn0IBg6NGxYY5+KlBLgFAFGdBbABSKiT6xRlz6ygO+UtXfTwyQG7tM6CDr
         p6ho/P3Yuw6h1a/r+tte43Gcn0wt4s3iqLD4KC+m8oERPDYnM+xeX2BFc1lyfyVS8QxN
         KB5m9tBhnjcuVofnRtvsG5/Oh8ryot8tIDZLfsB33KkgxpL/PmvMlJoZLIVoI0ieQ35s
         ocXa5UAV2Ovi5ekAbIGtK8qMYCVXTaQvY0tTVhzn0wQi77tnDvJa/4p5g8k0p82xSUeM
         2ufMOtw3OpFn+Ct1CMCnzRtnS3Nvj89/JNepf8QgriCxXHh0TQb2xEvp3JNHqQkBHM3k
         5/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWm+tOp5OI9JVczJOgFZMgzZphLiB4m5Z1jV/CHhnODdJjo3bT74P5CJIxHpQFmLTNW36xwQg0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwB5yN1TrJvPwHoY6PyZqoKAKNzwZmXU8WhF9tNHq9KxxrMZ/DO
	dTm6g7bT0Lyc6+pjMKat6tNEu4tCitaCnjDcjnpm4xDmKHLR9Hx8rGLnZDfd5ordMdGcBh03Dl0
	uyxp4GIDGmV9+1JEmFmsRw1tkz6okMnrGPj3chbIh9hkwuBenYkHqw5aE5WnVtYpoEU7Xr4s=
X-Gm-Gg: ASbGncv7B9SiIjp0I8Nuk1T2ljBnr4UUOAgoUn+AFaAdo/qO0O0GKapiPdLwyZpQMI7
	nkvnO3XJEnzL5quspLL3b2HVLfoIMpHiIWG5DhyAF/46tV2qvERuShV2HArMfnp0LQlsGELG10l
	1WpLwpF8Nm5BrMn5RnpRfxAnyz3Y0U11FwNEbr1k1k46Ei18NibyxcI/WDI97uXzFR3ep9oD2dO
	iXMVrgZQ1N/OocA8cjBvK497eiqAF3c1GxR+ERY4Al4jH5YSkVf45JbZLW9qb1G16hhFI2VdMei
	G4jvBi9nRDpM1ChSOzU1GVP4CdEQFzLwK6uVwyQR7imnPF7OLbQAPimqhJuUFInVWJDir1T/jFh
	DS7VSY6frUJki9Ztl2XdXWlE=
X-Received: by 2002:a17:90b:278d:b0:328:acc:da37 with SMTP id 98e67ed59e1d1-32d43f04ffamr16696079a91.5.1757463077942;
        Tue, 09 Sep 2025 17:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIXpd0nyV+5W6CDzwhd16gTLrOkaPXC+72FYq1kyJ0evnvLYFejafDZfWoW96NTJmQ+vsCsQ==
X-Received: by 2002:a17:90b:278d:b0:328:acc:da37 with SMTP id 98e67ed59e1d1-32d43f04ffamr16696027a91.5.1757463077356;
        Tue, 09 Sep 2025 17:11:17 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:16 -0700 (PDT)
Date: Tue, 09 Sep 2025 17:11:03 -0700
Subject: [PATCH v10 01/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-1-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Yv8PR5YX c=1 sm=1 tr=0 ts=68c0c227 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: o9CeKuKIbuUcmKAMy1gpTS8BPthmsjA-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxOCBTYWx0ZWRfX1IhWiLyq6NZc
 t4ccc0M/osHWo9olQnqB3Ug/ZvBM5MxzRNY4xCMzFuJbF37jzUUZXNdLyZS9HYHvIOOOL+TBdSh
 Ttlu0ME6cPYWxSvUI3lJXjRGAKXY9i4G6h31TT8XUkAgAgv6q7kBgHuMxOQ7Urok8GJjHVksnTW
 i4FQ/iy6NmLDiF7hZhsGCX2R8ViQCcgPKdtoSpgitiSRik5JySkL7RmyzM1Wry0U0/762ZRVjDj
 Z+ds22xfpPxQZBwO4e+K9VL0G3mcMIDuxb9qqgV5I5I+E9RsuWzkvBj/mA3Ahvxww8MFxWCFwQI
 8OFTUasQQJZf2Lk7rBTNva2J1oamCI12Wwv7vIDa00Rsd65UsqhTD2UixFuO5h8gKIcMPSmhw5S
 tZ4D4HD+
X-Proofpoint-ORIG-GUID: o9CeKuKIbuUcmKAMy1gpTS8BPthmsjA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060018
X-Rspamd-Queue-Id: 063FD430CE
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: U2UKBBE3TW6DUUFH73L6UXQDBCY72RCM
X-Message-ID-Hash: U2UKBBE3TW6DUUFH73L6UXQDBCY72RCM
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U2UKBBE3TW6DUUFH73L6UXQDBCY72RCM/>
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

