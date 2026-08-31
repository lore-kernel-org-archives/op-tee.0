Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9D9C624A4
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 15:49:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 886AC4531D
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788191353;
	bh=N4AdlAsQKxMJdowNshEikVOytfPVWy9gkAWSYoaqOCo=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=bLU+RFsgg403gKBMZJo7/ucqAPkgWKCGurQJd4kJmQG+W5xgFyyThRSXtglT4fCEL
	 R5xMDFtYxtepSVId4mus4ssQYlhZukI4zH34k5WhRSpeaEeM2Xxa26udLyrBKjvozq
	 NkXp7SmKgQe742RbZ7BwfuwrhObkAx38V/nkuZ1ry7St7dwSM8Zz8ldr5M0hfXD4jh
	 qPK8ymdzrGkwLRJydDzGmJ11rfU12dc3Rn74Pg86i+aZnIssJXrNhBW5J71aZwNQC/
	 lBek4uVlsWC1qN4X6tjIte3qOtzJu41R4vrR2w2/vBcULZLRwsq97NhllzJg9p4psK
	 QWRbDt6cfwX/Q==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E5ABF45363
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W4SojzgP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YyU9c9o3;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETQgx3703678
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=uCsZ3FqknJ4
	Cg45n8QFzBYP04ODkNeuhexPi+TmKkwI=; b=W4SojzgPN/KxEI1QZcFHTQkkI4o
	kLoj5HjsQJaaHcF3UIgrrD9Q4ffPLiMpDQhaPUysXeo4WG3lYzRrK8duXosf6bVI
	3J/dyf7+u3lQk9DsBsRMW/NsFCDEkH+LPAPzV9pxswBefkXKMO6s4Z/3mEAHQe22
	af/yySr829HOKhK8LxTk9o+MEyVJQs0TFpCpLqkeGC6OQ6GJcetfxXlWEo5/PA6J
	ew48ic9E2ydthS3my4Az4gyQQ/RzQA+dyFzVb1GnZTQb+661YeYrg7l4IYoChlxq
	J/uhTrqetGfAS8xukZeIR/SJcRdRQ7DU8f5HglS/Lon6t0X4+HQM1B/mNIg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6yasj2r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-933023a5980so751519685a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788191294; x=1788796094; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uCsZ3FqknJ4Cg45n8QFzBYP04ODkNeuhexPi+TmKkwI=;
        b=YyU9c9o3WS9JlJRd545B20KjehhggMvxst5iZBqmvoHLLWBO58zyxSdCnL+B6fWN7C
         KdJNLLqLMwpsOjDGhN+owTIT2k0u1ENveRfQGvYhrLs4Vi45kdIOkIl9PDRg+H8vxqk6
         7ozaEPVcBAnUE5ZWQLHFAmjq8dpouR6HBQq9LbDTN2WqbOnqjL/ajTKVvIGSGk/F4T+O
         XJulV/1/ZTXTfMRy2CsdyrxwGAzT5bbdj+OZjTQ/yreWdLybnswLRm06TvOjGMG+XucY
         Kmxx6sszkMsWONsTaVS43ZCZLVMPk1Ye4WDautDSiDFFlmuEuYJ8g3R0C3XZZSyajJNy
         hJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191294; x=1788796094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uCsZ3FqknJ4Cg45n8QFzBYP04ODkNeuhexPi+TmKkwI=;
        b=h5i2AChz5XS+k3+pQ4w5BF/TmEnzdUiUPUa4HXa79HtiiJxIoTLJ1VbSIUbl/K1ZDy
         aDnztXR93ENIxM3ssJ6iy31MU+XYilA/Q7RVXiXrNBQF32UjvclKo0ulSaS0jKmo6J30
         ntdE415eoM+8aOh/+93qtjjPFQNwP+YkfLmBVa4H6C/Zd8qYaGCN22YF595CpLUbrPcO
         EDomcsAWk6iMg0LUBHEWz1m2P9qYEqIVl7uJahbthkYlcLnkYbgzl+6BuiOvynqpVHBd
         By26i/EdUHzMF/ZjO1OsQRBp2LW+hI9AlbLCei30BQcTGCVmiPDWf+KMMU0kB9OuHYLi
         PIXw==
X-Forwarded-Encrypted: i=1; AHgh+RoCdT/By2hVCAtFGBvqD6Hf9UvmyMFSc4Yra0KAhdk229plBW8Vxkn6mCwq3E8/5ju68cFu7Y8=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++k4OADemuR6zAmdgTQ55ErFD09osQT1A0vxHIekRn+zQVXhwVvR
	GlE/wKSsO5Q/vEZ1805uCIc0g2GQx0C0pgswvMkkZw71wVCEC5OK7JjwFpTKkEs3GzaBnPjf28E
	uiskPocBB1y16ATd1bHmnT2sAXHE+RIROSfISoMxJTSiOuAzkxgJ65xSe7IkJVLdjDs0N5qmz
X-Gm-Gg: AR+sD10Gp3gew+PJbi5y8P/XpRWblFcLW1R5cNfw7zM8tYWHxsFzehaVZZKAgF9P6xE
	jDZYzALM2rakX9mevyUQpn6II+Gz3BTwpTOq1Any6O5eg68RTj/smjc6klvFZWKjcKM9GeCSY0J
	E7GfWId2Ip6RMr5jdryztlLKFZKU0jBf8OwCnhCsLCjvxJMZ/BrcsrsBg3cL6u5LiYz3qB9xfpi
	1LLyKzvZqCPgDzRmPQi8+WlzhP+5O1cTONBekyyDh+XDwkhDBhvF0cvjE8kDJqGiqRUBRpdwVmL
	CeqQ1bOD84bhPGw3xPJpxyvfpHH5uqHaZugqe9CifvsnN0oBsBL2sBelk9Y2cB5aqelWsn7uiYe
	nWRm9F6RLpoCdGm/yhhfDmEs0AX8IKGMGPvffN4AcAj6oca8=
X-Received: by 2002:a05:620a:29cc:b0:930:f1db:b9e7 with SMTP id af79cd13be357-93913966079mr2783350785a.38.1788191293368;
        Mon, 31 Aug 2026 08:48:13 -0700 (PDT)
X-Received: by 2002:a05:620a:29cc:b0:930:f1db:b9e7 with SMTP id af79cd13be357-93913966079mr2783341085a.38.1788191292756;
        Mon, 31 Aug 2026 08:48:12 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b456sm1558315e9.2.2026.08.31.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:48:11 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, stanleyjhu@google.com, beanhuo@micron.com,
        beanhuo@iokpp.de, James.Bottomley@hansenpartnership.com,
        martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, can.guo@oss.qualcomm.com,
        sumit.garg@oss.qualcomm.com, jenswi@kernel.org
Subject: [PATCH v5 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
Date: Mon, 31 Aug 2026 17:48:01 +0200
Message-ID: <20260831154804.719528-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
References: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX3av7rpQiosZX
 C+LDu7ZfS9wNw7v8akqB/YQKd/Xj+t5VfaeO51O067vFaBPgHy6V8PdEMm9/u+9theyIZ5VBLF9
 7ktU5goNnAZam6RjNLivCPnEIruSzIA=
X-Authority-Analysis: v=2.4 cv=CpaPtH4D c=1 sm=1 tr=0 ts=6a95a23e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=PY6Zn8H8AAAA:8 a=1XWaLZrsAAAA:8 a=ArVhE-LcdHC59WzGYIMA:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=ySS05r0LPNlNiX1MMvNp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX0F0MiuUDSZw3
 4QL8KA4S1YIZDyPOk3dEDrmSzDhsxryaWP8wM1cdGIFAl0F0wpMNKQkwwNCsxCIBt83uTMC+sBd
 kSCITmnXvxBWtBQCkjtB1L3IHREAANXvrHflnz9LfL7+tKaPzF7twy+JKy7sOjFeieAvOEIZ5ZQ
 BWWYj8y7rhiyVS9+6cytd/3hQc69mpMp1cmomeyoFlD20WztkTH0vpNTi6u5JW+r99orNARurBs
 vom4TdCHc/GjXN1uODHDDQEH08liIwdP088129y5PsIuUcLHRgBohtlEIb5VxmUkAiZaPGSdQwt
 FXYh1XT+1YugxNtSZ9KzBO1iFcqzj2+bHGF0cR9dxt3yvv+f3vFyTDMV3PqrXO/BB8F4WmH3iX1
 tbgqn5BQv8iK2NcRPpeNM0iRKDzUfcMA6g4a3cBW+2Ql2DN3n8LTJgL8NHrBZPI1QKOaYtaL1b7
 dPVF2opbJ+4ih1eYROg==
X-Proofpoint-ORIG-GUID: e__c-B4oeh5sEUN0O2FKx4URAFHzM3mM
X-Proofpoint-GUID: e__c-B4oeh5sEUN0O2FKx4URAFHzM3mM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.197:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DNSWL_BLOCKED(0.00)[81.38.139.250:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E5ABF45363
X-Spamd-Bar: ---
Message-ID-Hash: Q34ECEUEJFVAW2BUCRV3EMFASBZST7AL
X-Message-ID-Hash: Q34ECEUEJFVAW2BUCRV3EMFASBZST7AL
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/Q34ECEUEJFVAW2BUCRV3EMFASBZST7AL/>
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
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
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

