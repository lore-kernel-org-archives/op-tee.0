Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75423C83F20
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:55:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C535442F36
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454525;
	bh=4sISDrGhRvzrnVyaxYAEMv5e7n4PAkRIO/PLmW7kiE8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AxtJN/ZbGcC6kjIoHQV5RlkUUsz2swmsNgwfmz801C/qeA3ZDqO7dK2vD/xLSznD2
	 uHzOSjjIZ1b9yyyI5UkAHUPH8p2qruTDxoJkSabrwzZMjj6Y4NW7n+VWm0Wtz3iviM
	 sWnLbfp+LqkL78n4CLWk3JExkugHEE9vmXPsIbvKalcbTOdJL7UdPo9VJ9IULDlnwk
	 92lbDa/vnCQ0PkKWAaqvzT6StPlSFsF2HDIIMgsPbMwxmBawkMNcoQPZUGq9WOqo2f
	 qWnf90ROSj8iN5yU5aS6jASrZ6mEKyXES+UY+NCVMY1GX3qql8hb/WG687ww9n1Bc5
	 oEinNsImcB+eA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 07FE44FC8F
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HNJdeMb9;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNmLrg014055
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LtCsRmh8jzrf56uQEtvaGnF/ZyolBNlXVAA72gSdinI=; b=HNJdeMb9smyVNK3d
	hqdELrLLMjefMpu5GvCEEyP5jEGz1Ad/YoSo2c+pF0CJz38Ln3Ed1rbWEXY5BrL0
	vFey9++CqUZoSXnM9SHVtvRfqp5PjjhaDIaM0HctjIZc0LQLNrDeuUjkbJ3i9Fb2
	U8HKdHQ4aCiJHWkZdOQcLv7CEFTDThX51y4PyknoMHrQV58M4pk68ErOLQtxpxno
	Q6s2ODXPMHWxxkBIgDBuCm842HflStjf5LYNTH/Ym1fRsCwH1JahJGjCIEGjrTpY
	hucKwDwk9suN2iG7tDZUDu9/6MPDFouL4mZMRxTwL27L5ChtNkrM5bU9hifoIVau
	ezrdEw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugfhat7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2349498f00eso41523125ad.0
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454230; x=1753059030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LtCsRmh8jzrf56uQEtvaGnF/ZyolBNlXVAA72gSdinI=;
        b=v0zF3D60fxT4TtvbblooYDxU2JfMX0Qh6JnebmmMtVJq/M/Mx2mVt2jj3Ca1goyUWj
         I8n8lTQaq3ekvqprBYOvh84XiPB97xzi6Oyf38O1ZKi2GoO+SmIuq/MJ1c+n8Xk4kwEd
         RcMQ7WGyYIaCoCOMVC/uLARwbIh4XUqhL8zj3EiCUQ82+lV5JE4Sp1lkRbdvRTAuWIeH
         01JdiyiLhNutzWqQ56gkfOFTmYMCP5l1Y8kP2lvYQrBJjp6PqMltxRq3dKR4vADbcG/Y
         0NZu3rSggSOnI98FE31Czib8pfBSkSHj9kQtPwX6aK+jyB/n4n7M5Obi67LAUEQOx6tp
         E0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHJobpt61JbhZWQsXcCpm/izDZPvpDea4d19c+HVS3bAVfl763E/8LYByLMVBzOMCdFANfaNQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwqTnFSoBxHZu1wOZ/1kT6odaY2lwNIwf4UZP7DtKZagLmIegEI
	YH7swS0vQNi9Ytx6/FtkG51k2ROlpgp5Xb5VejsTFg/Y7Gg5vNqfx9PtbjmU3BCrwLCKOFEns0G
	LX/j08BTmDl7rf03jzFrmhYYt08pApvTTVAXasLWAbggzl2G9gbTq7kMvWzmWQiEIB6J9yXE=
X-Gm-Gg: ASbGncuKbpSWzAavDPgF54qzfazi5fR/9VAgjJYwlQX8p9VP4q24C5UQ4ytSTzdCHUF
	Pk0tP5tzXAhK86P/e6LIRpikQn2Y5U9dnXPrf6EntTA8pJZuqDfPsn1O9+YW1JWR2bEzCd/0Wk2
	XLaQ2SfDU7sHFJtlQ8Eg/mi1NOy/kGVRQu4p5qC0GdCBUYQMej7X/vba+yRb9uF6ehJaEmjvbRa
	B7PIZb2f+Ga8evuyVdIgOpBrBIp9yzDog5pE/0KnaAyn5IofRZi37ZygsHAMcYPlSSEMB5TTqHp
	+RG0d9ip1TfnWjwJf34XMLM49YpMrBAU7M0W1vn5OWAuBbSMq2pNepBOUafi2YKNw4owr3sW5id
	V3KGt6rTmrDUxJkoJdwCTdH8=
X-Received: by 2002:a17:902:e841:b0:237:e753:1808 with SMTP id d9443c01a7336-23de2feb28cmr210286175ad.20.1752454230190;
        Sun, 13 Jul 2025 17:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwgOuMB01t9d/8iPExWoQH54161e+s537wrXhm1aY46pxdDIukSkyHhGxM1PtdRNmE8e9+NQ==
X-Received: by 2002:a17:902:e841:b0:237:e753:1808 with SMTP id d9443c01a7336-23de2feb28cmr210285805ad.20.1752454229772;
        Sun, 13 Jul 2025 17:50:29 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:28 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:19 -0700
Subject: [PATCH v6 07/12] firmware: qcom: scm: remove unused arguments to
 the shm_brige
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-7-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: g8elhdhdckxuLslypuEOyZFlC1C0sjum
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX9gFAid229lzu
 yEmI7Q0HipGQrEn/CL2LCpyZB38KjgDPo9FLaFwxHY+77F/zjTREQQ2Cw3voRS626IVW2Tw2szR
 s8ed/AW82SS47wNs9jbn43JJj+dyNtkduXgx5PecxSoDSDztL7AyLW7uJYXQr9ngus+VECjfnF1
 /n4KvBsjC+ke/QYrRNe2s8wwVzn9rOAwFoQT+sH8Px4xppoCV91iqcNqIUhVAqQydboqgWpqjTm
 lURYfs25dIBqZdYci4XsrnprBLAUgBGZRODhTAvR48RufQZITnWkWkRR/1oy3Pf8xFKtWXZY7Et
 8Od/dYkr3/XkdPSmAVNxdjcQztAUd2NJR+RzBE2ZwxYLXCItkhm7wER5CaeO+Ugcd3uVb+VJCjl
 faJkG8N93nO2orJwMjHWN78Zke+h0cl2Aw6/dgJY1L0BnK8VUFt7EwWRouFlSe9D+wqRGKfN
X-Proofpoint-GUID: g8elhdhdckxuLslypuEOyZFlC1C0sjum
X-Authority-Analysis: v=2.4 cv=HYkUTjE8 c=1 sm=1 tr=0 ts=68745457 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=ViJ-rRY3MSY-B2NivjAA:9 a=QEXdDO2ut3YA:10
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
X-Rspamd-Queue-Id: 07FE44FC8F
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[205.220.168.131:from];
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
Message-ID-Hash: 7JVEORJSMMA4KGDK24O2PIOWJORPUYQT
X-Message-ID-Hash: 7JVEORJSMMA4KGDK24O2PIOWJORPUYQT
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7JVEORJSMMA4KGDK24O2PIOWJORPUYQT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

shm_bridge create/delete functions always use the scm device.
There is no need to pass it as an argument.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c       | 4 ++--
 drivers/firmware/qcom/qcom_tzmem.c     | 8 ++++----
 include/linux/firmware/qcom/qcom_scm.h | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index e3207a9d2de6..72223d7dc33d 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1631,7 +1631,7 @@ int qcom_scm_shm_bridge_enable(void)
 }
 EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
 
-int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
 			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
 			       u64 ns_vmids, u64 *handle)
 {
@@ -1659,7 +1659,7 @@ int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_create);
 
-int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle)
+int qcom_scm_shm_bridge_delete(u64 handle)
 {
 	struct qcom_scm_desc desc = {
 		.svc = QCOM_SCM_SVC_MP,
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 94196ad87105..4fe333fd2f07 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -124,9 +124,9 @@ static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
 	if (!handle)
 		return -ENOMEM;
 
-	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
-					 ipfn_and_s_perm, size_and_flags,
-					 QCOM_SCM_VMID_HLOS, handle);
+	ret = qcom_scm_shm_bridge_create(pfn_and_ns_perm, ipfn_and_s_perm,
+					 size_and_flags, QCOM_SCM_VMID_HLOS,
+					 handle);
 	if (ret)
 		return ret;
 
@@ -142,7 +142,7 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 	if (!qcom_tzmem_using_shm_bridge)
 		return;
 
-	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
+	qcom_scm_shm_bridge_delete(*handle);
 	kfree(handle);
 }
 
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index b3a7cc20e617..796de61c7e9e 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -149,10 +149,10 @@ bool qcom_scm_lmh_dcvsh_available(void);
 int qcom_scm_gpu_init_regs(u32 gpu_req);
 
 int qcom_scm_shm_bridge_enable(void);
-int qcom_scm_shm_bridge_create(struct device *dev, u64 pfn_and_ns_perm_flags,
+int qcom_scm_shm_bridge_create(u64 pfn_and_ns_perm_flags,
 			       u64 ipfn_and_s_perm_flags, u64 size_and_flags,
 			       u64 ns_vmids, u64 *handle);
-int qcom_scm_shm_bridge_delete(struct device *dev, u64 handle);
+int qcom_scm_shm_bridge_delete(u64 handle);
 
 #ifdef CONFIG_QCOM_QSEECOM
 

-- 
2.34.1

