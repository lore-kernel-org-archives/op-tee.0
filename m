Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A34C61DC2
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 07:04:57 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C4EDE44F0B
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 07:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787814296;
	bh=y1ZnMdD2QuOEZND6UGhj4zLO8yEjmatUPzsNEo1nN6U=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=IXB/55IXa+/8ijB1HxZpHvcw9fYRdzU599bhW5NHrC3lOhFAna2SOb2HrbI0B6V4Q
	 C2TxTUbVeHDms9Z54JcYJ0Qt8ACEo/bM5aTC3WPEwaD0IE8jeh2TIo4YFrgjib1Qci
	 pKnXmPWrOu5+HKvo9HPbRGYyou39zfNNzieCeCPYsJOEtQHe31AEgb6xZ9k1eNiTYj
	 1fJ5h23tkFXc/iVGVldYk1/EirrML5UI5Qg/IBYkKpBLAFtJCEZvLpXy+2OysUz/G+
	 6JktOy4Y3vXsJtiOZrnyUPdA/tOGhr8ESzABt0zgQs3QncF/1oOs1axQL48B4cNY2G
	 1sGToDsQOXWWg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E162E4536C
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jHum/W2u;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hTq4TN3S;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R81w3257829
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3lcTDATJyX4
	U7tMBzNdZ6G2/MK8hjPYhCbHwcSgogLM=; b=jHum/W2umYi/wMGEu34O73xjt18
	gyqM6qs34sPZILogv6NPb/hjQ9wPpDguvUChZVJhg0UzTL12LMoEXB9eawpwBC0B
	meHuGHPfwj2YZsScsgwqNBx9EOse+EAZ8F8QBSiKYOZ30vejJwieSH7u7+hIuSkm
	2dKSkRQ1dPevTAR4oVQxFuWeCda/p7J6WDQkmjVZNlsxeZk/DxhfEmbd7y6mNdjH
	pp1j2VuZlIRKQ6OW8Y9vVgmHDEwbIjZ6Jvria/t3HMspBzJL0wXAlLq4OzxPJggI
	QfChEYWrmkxtCpVijgzE7FYaI8bTnGwTy4rMYfIx0WUa3UiMFIJryxlkHxQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4ecaes8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:57 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52827090cc5so7733441cf.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787814237; x=1788419037; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3lcTDATJyX4U7tMBzNdZ6G2/MK8hjPYhCbHwcSgogLM=;
        b=hTq4TN3StVBkX8nHlfRVFpdESUIon6FBLEdpLwAujDMy0cWQzKXXrBqDWFlGb/QkR2
         O6t/5dFlN6r3rGNo0UaReT4o6LydOl0AoOmht/LlLUdc3cWD9cEU3MCPXHHW3Va74i2q
         b/vNhrBWa8deAxgfca34gJfFGsR9IWmn+vguIVxiOsk8cqYphFjEPvzcmd+G60n3PMJb
         Ea0ls37dtFWjr/xT9QTnUUWEbAswv3uir/s6EtNrO/iJ13epOzWNWXqUcfu7O+jsWpmd
         koSzcHRfhw+3uZUth7H8H3lD/uNY0RkPVQ3ofs+0VzVkBJJ5HDEx+pwAUnzQ1VyhM0C4
         UU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814237; x=1788419037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3lcTDATJyX4U7tMBzNdZ6G2/MK8hjPYhCbHwcSgogLM=;
        b=K+IwG/Tw8+3iT+XwrIdXhjtu5For3as85Gv11LB2mL/XUjWkQ2NfPAu6+wKLFWwIA3
         GezVGrNZmiLg0u5UoDuhdc0MOyw2Rys9C79Xf2I4Rk3vkurLJ5GK/LJxsMRBajBWQ+dc
         kfzXI9rCC7tfoin1126z4Ont/nPq4E1HfHJxviSULzjlqBHM7z1P8H4htogTPYqJWYxK
         BYO3cUexnSXWFFIe8bI2Mw1d6QlyHNzRxt5rES3YE3EjHK/bEChK/wKD2QjK+wHzz4Fe
         mOSW0UwVZwSA/xjkyhV0UTK+9STJMroezvS0wWpjgoHtKHoT+RNqUFJg4MhrYAhgPrNq
         qU1g==
X-Forwarded-Encrypted: i=1; AHgh+RrmniuwuKjWp1SN/C/dRbDEN43qllh13v1OJdpXOxcj8oUZbwZYXgAKDYjZulOIBpbvcMw8Kaw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nH4+AxG/h0Xz4y1mdV5et2pf+3H70jVwoVLagQ5b9wkMNQ0AMq
	ysfah/e/VcX5Q6ABa30Js0WCZ+YP3dQ5Ru51KlUbukXw41j6+lzSAH2FANRN5W1UuTyzTnpHUys
	cd3XAuZVwnNR3wGieTrqGR6G3JTsIjSLqXEA22fhsiYJyimeY95qU3ObZ468+QPuP/CBHcp2U
X-Gm-Gg: AR+sD112vmJWbGtQc4yt0j0lhTq+3rF44Lrb4+1ENtRWL/KgpVugY+72bGMbAYC5s74
	TtUdgaN8MocCsiFfrH/Y0fcRyWgQ7IBj3zIWO9lasy4MQfeEgLK5C/H/vlIdvkzMrONwOT0aOsO
	dUEf6PeUPezO8WZV8Xy+CNO8k/NFPd5KW3T7a6YYoLDEd4juXSKlY5qe7PRQVlOC4BaZuJVHIEP
	8TDs4bdDWvsV2Jz/Jo3XWOHzRxFMjwiwCwx4wD0mTn8O7WKtSNtvQVx7SN9FRU8F7TFxttZfOpO
	FWfdduWnEy6/qN+nqle+exFmEiFCxstq4kjnRH+C6Qw8Ysm6e1Qdtb2XQ3PoEE7OeUWiFccYulS
	tRNlsTc9tPBF/EWvJsUIzaBvsX7KXjiHEctCnoHvVhL40A+yrcg==
X-Received: by 2002:a05:622a:4d85:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-52fa1a4aaa1mr51871981cf.3.1787814236776;
        Thu, 27 Aug 2026 00:03:56 -0700 (PDT)
X-Received: by 2002:a05:622a:4d85:b0:528:ce0:e9f8 with SMTP id d75a77b69052e-52fa1a4aaa1mr51871481cf.3.1787814236308;
        Thu, 27 Aug 2026 00:03:56 -0700 (PDT)
Received: from trex (137.red-79-144-199.dynamicip.rima-tde.net. [79.144.199.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b0d263dd5sm28306585e9.1.2026.08.27.00.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:03:54 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, beanhuo@iokpp.de,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        beanhuo@micron.com, can.guo@oss.qualcomm.com,
        sumit.garg@oss.qualcomm.com, jenswi@kernel.org
Subject: [PATCH v4 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
Date: Thu, 27 Aug 2026 09:03:36 +0200
Message-ID: <20260827070345.2853821-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com>
References: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KIBqylFo c=1 sm=1 tr=0 ts=6a8fe15d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=qBhfTSQT0jQfJ5OHMlDVQg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ArVhE-LcdHC59WzGYIMA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 2eRdwE2fccWFtxghcJRZ9HdBXf6DYPYN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfX5vvOgKM+zRMR
 Mcs5bRZyu17YRQltv9aqGpdUNCUadLCOGnb9rqyWxE5BVCmVA3vJJlapg6FxH1US0NrNN863Rsy
 oAo//f0jXQNeGsENzNP9PHIMwrODe5tP4N9wA20KcG34qK4Qd2dm/y+wCBwAivh0SDzvqmeVq6v
 lO9HLfjxd1LG+aHlGkm5nUqh68ODVYCq+dsRrBJ8KzrulFreN6ZLQCqYoikIenghmQDuG3eWtZs
 LlVrAO1W/hEzwarx5iC9Glw4l1avLKPjD9WDBTgGcKFefVZs5XD6CmfZ6bueZR30taJEd0p3VXh
 7i940B9wUK3KGEqSkbLOCRAsX2ulxa7v+71wMklQEFFwaidFO4Z/yXz9dahc7JA1HMO3S5sC4hb
 sco494eyJb2QZGb+rhQ0OmsaQsVuhJSSnO73HSJ0IUaRwVotCr7KCZEvTr9sFCFWT1tbzwJ2+Tb
 THePYUe9snYZ5gfk5oQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfX0mJfI7rzVr6r
 88+VRFAWHsRnKqsdUYYAmoJECm0uYqWWTbmPlkru1wCPO1x4OQ/VzEEdtXe2vT6rBd1klPo6gUA
 ldCpGYFpO/Zbfj3fjunuR3eHMMY8OPw=
X-Proofpoint-GUID: 2eRdwE2fccWFtxghcJRZ9HdBXf6DYPYN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E162E4536C
X-Spamd-Bar: ---
Message-ID-Hash: UET6SRKHDHQ7TJ4YL23XVJ65DEJFDKQR
X-Message-ID-Hash: UET6SRKHDHQ7TJ4YL23XVJ65DEJFDKQR
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UET6SRKHDHQ7TJ4YL23XVJ65DEJFDKQR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez-Ortiz via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

The RPMB authentication key is derived from the dev_id handed to the
RPMB subsystem. OP-TEE implements the eMMC RPMB flow, where the dev_id
is the eMMC CID: a fixed 16-byte value the key derivation depends on.

The UFS RPMB id is "<device_id>-R<region>", which is variable length
and longer than 16 bytes. Handing it to the RPMB subsystem as-is would
tie the derived key to a length OP-TEE does not expect and diverge from
the fixed-CID eMMC ABI, forcing OP-TEE to be taught about
variable-length UFS ids.

A fixed 16-byte dev_id is needed so the derived key stays stable and
unique per region while matching the eMMC CID layout OP-TEE relies on,
keeping the key-derivation ABI identical with no OP-TEE change. The
reduction to a fixed 16 bytes must also be reproducible by the
bootloaders (such as U-Boot) that derive the same dev_id.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig         | 1 +
 drivers/ufs/core/ufs-rpmb.c | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index f662e7ce71f1..b62c00e7ff06 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -7,6 +7,7 @@ menuconfig SCSI_UFSHCD
 	tristate "Universal Flash Storage Controller"
 	depends on SCSI && SCSI_DMA
 	depends on RPMB || !RPMB
+	select CRYPTO_LIB_BLAKE2B if RPMB
 	select PM_DEVFREQ
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select NLS
diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index 79e6cd2b20a0..cb3ac23fa01a 100644
--- a/drivers/ufs/core/ufs-rpmb.c
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -10,6 +10,7 @@
  *	Can Guo <can.guo@oss.qualcomm.com>
  */
 
+#include <crypto/blake2b.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -21,6 +22,7 @@
 #include <linux/unaligned.h>
 #include "ufshcd-priv.h"
 
+#define UFS_RPMB_ID_LEN			16	/* Match eMMC CID Length */
 #define UFS_RPMB_UA_RETRIES		3	/* Retries for the power-on UNIT ATTENTION */
 #define UFS_RPMB_SEC_PROTOCOL		0xEC	/* JEDEC UFS application */
 #define UFS_RPMB_SEC_PROTOCOL_ID	0x01	/* JEDEC UFS RPMB protocol ID, CDB byte3 */
@@ -153,6 +155,7 @@ static void ufs_rpmb_device_release(struct device *dev)
 int ufs_rpmb_probe(struct ufs_hba *hba)
 {
 	struct ufs_rpmb_dev *ufs_rpmb, *it, *tmp;
+	u8 dev_id[UFS_RPMB_ID_LEN];
 	struct rpmb_dev *rdev;
 	char *cid = NULL;
 	int region;
@@ -213,8 +216,10 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 			goto err_out;
 		}
 
-		descr.dev_id = cid;
-		descr.dev_id_len = strlen(cid);
+		blake2b(NULL, 0, cid, strlen(cid), dev_id, UFS_RPMB_ID_LEN);
+
+		descr.dev_id = dev_id;
+		descr.dev_id_len = UFS_RPMB_ID_LEN;
 		descr.capacity = cap;
 
 		/* Register RPMB device */
-- 
2.54.0

