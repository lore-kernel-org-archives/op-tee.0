Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8445CA0EDC
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:43:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0B4C7430FA
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755733425;
	bh=14ZTHl0WyMlTosvSsdQcfG20Corab0amwL7v8YXssQI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=pJEO2Pp1BSO7d9HDQURORMy9zwTv/b8fWLn6JrXEW7KjafdK+JvPNX254oORmQkIO
	 ozA1rSY0VRCJssbhCOOZcWJKTvZ3nPU9KEn9QkwX4kXUm2vgSn9QGAalRRxvq9sVEM
	 bs8yff0LhM78DzpF4yZQL7zEbRY9R1uUgpVzSzYDNIidp7BKh8V0+uJq9Q+sCX7S8P
	 Cc4Id2mKo5JIQ9+uSHebliDumG85osXMFmp3dvItNbJDzRUCQMZwe7G5koazS/GZVo
	 ILYPsJpZW3oUtz1i7zJnNnzp9cHfeJMuK+wTwC4nmETRvdUt5YkIxN2ULA6IM1x1v7
	 g/62/OPyQe1jA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C8B314FD11
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GcQwFpmQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KK7XHA007306
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=; b=GcQwFpmQUh+ANFj9
	i6RkIhJ+aaaYEb+jAR6fb78iuDMpROs+vUQIgpCvwGm7BX0pPYSJLGmwxIbxiLWa
	nDwxqVU+MQmWYUknqHrTq5+azZxufD8AIive8+q/pTVb/Ce1/NFDRMU7By7CRMtw
	7T1Q3BDWLbUyBnGYxQriuAwSvZc56KM1EMwt1Y0iFuduBuBdTYOGL+yo4iz6vW7u
	GVdMmj8jw0AXTANtYy3K8pBSFghTZXHbff+K/t5h9vchIoRqGdKXL+lh2ISgliZ0
	D8h3NOQ2n+zt6fxI5dlbyYA2FE5wB9o56glgAWQSx4hHjSh3wpQsEapSjuimrRGo
	5PGSsA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293a9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b474b68cff7so274311a12.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 16:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733154; x=1756337954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vF0nyR92c18PkYaLWTQ1li9PHbNqzQgJEZPcJkVcA+o=;
        b=bpMlaTbYV4s84oGYHjJdAb83iDVjffrzVquhHakwhn/hZi4WfRiO1g7ISKttdYTebG
         FDQ+e5LdOy2DHO5c+PNmYV5QzVlIe5WETX3U+j+kTJarVZxzZ8tDDA9of5F2/pedpBH1
         KilQHrD+pjyzc5VdmS8QNM0Wpo3MvRV+QS/DDpD8VtcY6laRLjRJy5J9cZTnHo1DY51q
         Fc8sGVDOPfUspglh64b3h6xSsVNyQxbvws/ouB+oQErZslhU4AsdVt8UG3MNc0jrwfvP
         PwfPFtkrRKXq+Z1jafSlYLFOVWdQNxRuVNJ5WrN6ztUBuIczJvPPZ4YCtmhrTS2qOro7
         HTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8tjO3avSmEdO/kLJLP9PnH0jhaQEqnYyax/QI2FQBHkwT1iioYDT60kxcbX8MpqTH0R/Qwfw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyz2HwqdUnaETCUt/8L764j1A2qci3RxsMEV9TKxjDOyt4YRN9V
	EAf5WgLJRzWXd3e8kMGx+w5KbC317jApq0yeBtaM3D86Me633N+N9RWbnAaUoieVkO3g9ebnqiT
	voOp7xBoStRrvotMsu4nE5/toZf835+gE7YvdVS9XXYoXet14+4ExYtqZNje6VQ7wC+q0TlA=
X-Gm-Gg: ASbGncuu/aAExVf1iSW+BqNtbPP/kKw2OwMsonIdeDPj6EWwd3DkgALA4KBko6TfO3F
	aygwTfqAjzEr0VgymSmsX+1BMRP/BjA9YvEbfnl3PMwgR84VwCGRJ+yeitc/a+ZI23RLHKZf3Sp
	Rv46YMYxXJHzGolvWNTv+L+cebmcejbEZmP43Z947HaJhMtLEEkZ0ugfG+6r+pa3nbEFUurUBF3
	rFAn4vbijkT1O5bOUMLpsgarRHcbECS066dITTdCsQtIrEhyepdBVDBGzYucunbkLsYA8qcG+vB
	SLkyBXyGKmA3NofCyEVgHGpRuxZGsq7V5ok9quN5OdRxv5l6MwIWJsRM3Vwtbt1jaLulsuLApuy
	A9DR0KatQAxnpp45+Z+WOh/w=
X-Received: by 2002:a05:6a20:7d9f:b0:243:78a:82b9 with SMTP id adf61e73a8af0-24330abb5ccmr362747637.51.1755733153924;
        Wed, 20 Aug 2025 16:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFO5ag3pP9Jmy1XnNqoDJrAVQY6JrjsksFuA5qgnNEDHF9eaBUcb+mKI+G+v8N1kvMmPm7Hg==
X-Received: by 2002:a05:6a20:7d9f:b0:243:78a:82b9 with SMTP id adf61e73a8af0-24330abb5ccmr362716637.51.1755733153451;
        Wed, 20 Aug 2025 16:39:13 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:12 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:38:54 -0700
Subject: [PATCH v8 07/11] firmware: qcom: tzmem: export shm_bridge
 create/delete
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-7-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Aui3HO9P c=1 sm=1 tr=0 ts=68a65ca3 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=sWKEhP36mHoA:10 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5numxkeOl0lsm_bA3l4A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vW4M8NNQSvODZERJ_dS_j46Xx3oQxb1t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX5hFRUFK0S5Vi
 cZMtaxe71nwbE2vhMptk/7V2k80bXEqNRFQeXVdj7JdXXxl2zZZuVEu/HnQIBArfeJR9YEQQ50U
 cqP2WIQ7yU4syyqFHug4h+krBI9F95BEh0jLFYHMN/ze92X2g7FMo6zOr9ptNWJ2oG/FAa6NP0d
 Hkl/uLvHO1qqwF3JLxZa3eCwO96axCDUFVx7fugtSpgIfNrHtXjJgHc7cHoY9lNQnNOWaJmM+QG
 tUcCkUoukxMX4dm8VaCHIQYkvJ7gH6WqpEju7IP4CSXT4ORseKOx8KyAmeGFgbW2qjpa2N6p2rM
 +Dig57VJdh2lkHHHk/QIFhSJ5CFLEyuLXEWpJ3rTxY9NCHIxrGqK4Nu1GFnzcXuyELWotOGuVzU
 8Y5N8CvxFvecMnAK6LPRZ7FEmop2jw==
X-Proofpoint-GUID: vW4M8NNQSvODZERJ_dS_j46Xx3oQxb1t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508200013
X-Rspamd-Queue-Id: C8B314FD11
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.20)[205.220.180.131:from,129.46.96.20:received];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 6S3ZTV4PZYLJ65L57ZWN3JF5KNA4ZAMI
X-Message-ID-Hash: 6S3ZTV4PZYLJ65L57ZWN3JF5KNA4ZAMI
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6S3ZTV4PZYLJ65L57ZWN3JF5KNA4ZAMI/>
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

