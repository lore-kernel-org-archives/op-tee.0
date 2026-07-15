Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36E9C44501
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 21:44:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 32CCE44F62
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784151877;
	bh=Cm4K6aQ9ZencuOBmb0xy9mNwsQdxcUIENIj4qEuugS4=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=rmtC+YLSLZn/zeILVH+fjQCYztuglS3A8GIPlb8zgMuJ6tqN8udvPX27a6gNs95jy
	 gLmLHAXlr6qBPSypkwqMCrkndv5EutfFSScqQOSDJcsxgNFxSUP5Jtpn5e/3OB5OEt
	 Iif/OM2uFQXKQkqLYzMYgXOrMq6kbziJwgQl2qfKk65+GFpAZnw5T2rIzYx4IZR5nB
	 jo4b0L/ESdA4Kei5iIcPlCZeqi6uMCfdDpKhpTpQ4ynckuE7ybSIr3iS6KCrwftewH
	 1vW0+BWNfddPLG41ljvzZwkZrXyJKud5hJxKFSWmTra2QNi5Dc2N4gVTp+tfkgJkOl
	 ggDlm1oILuehA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 04FF544EDF
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=olsEgkq4;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HRCIoR64;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPjEZ1715283
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TQbg8chsvAP
	bq/1Q3wQohaUWLuiSfKaiHqBS/qBy66o=; b=olsEgkq4pNu3FHZMKxNUaLF36eV
	bahSBKfCTFdips/fsIGOfl1Qu557YoIxNyRenKQrVpPKwrQ8T0pa64vELI0LF+Dl
	vi40jXuop9tRJ4YLYhtM3l04A8++8ztl1EaoWabeEFpO8+e4SZu8nqvYnYcSX6/N
	8QANEP9FXgCZ+8mSfB5hiQqrv5a3s+6J2BERU+Dsepu9JpF2WhCnRWUhRmEcn+L+
	4Rnjp7urul0BirNIRemIFSQ1+5UMZGTRGOH4oatzXzCGqzzNxh2IkN2uphiXl2z7
	ZQvpsR7AIg7qffylzV2qrv3y7Bt/RmO5ZJNXwKoAm2cCstbgFncztCZoXMg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe68wua03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e62e3459fso896262985a.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784151817; x=1784756617; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQbg8chsvAPbq/1Q3wQohaUWLuiSfKaiHqBS/qBy66o=;
        b=HRCIoR64vEKGadnCoT4LtXkcEzoxQt9nXqzebGx2LL7UtAGp7PZLuM0+N+x6U9q/w+
         cTajR6Y9ydLa1EgCzsdnZagBUjBqXEC25LqBfKPkkg7PejdnrxDFtidi+6KgG4VbvQJb
         3F/jnfw/wg13HU3NWuSCyfzsCwbKW/ne0shSU2u7ef2cfBuya04OpNr3yk4EtOlC6Q1v
         q9phx+5gPIYyRaC7pYv+AF/7sgADeTZYJbOo/azjpXaxJQYtVBzncCR4f38+4yiCQwg1
         uBzUwSPyw5+rnyVS2w9kjh8HWxXnH7muALL+/Ft44BO57AbNdrMlYGPvdcY1CTCdd6s2
         7Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151817; x=1784756617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TQbg8chsvAPbq/1Q3wQohaUWLuiSfKaiHqBS/qBy66o=;
        b=F52KmJqNuatcJad5N0CkVfMhpMzG6gOCA2ceDiwh7BLsy/ADW2v2mkv5pOsqafrzf5
         YH7DxErvkXNgIHYKTM3fSNW+EA+/DTAk01sydDhVa5hcwW4VU2d8gyrFKEWzk7lI4//D
         paAUQmvTOq2npYE3HzicAI/UCI2cDfCDRo2GUfaZrugOdBxzGp1BFTAb4hlHyYa8y9Jk
         K7RSZ5pFgpkxJYkRSKIiUmKFD2hLjL13K+B3vj2zOB9cKXKusWUoc0U/e3uBBiWKF9sQ
         HbnLcy0CHaffTPQyEULat0ByR/JbdIansxMma+DAuGc/quHt7Qy9e8GJfzmJnrPbaB6M
         emvg==
X-Forwarded-Encrypted: i=1; AHgh+RrbOFIcdNuURgudOGiPjpDN7iPgNglP6E41weaO40a8cEOOttvnfxmL/mXLpMXU0iGGuw7o6Sw=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz+npESRQ3IU9trHvxMfBIJEmopB5eHZBS4rfS8FAkE18Ec8a29
	bdzoJyxaRzp2nrptDyzJjPFvi84Im5mO819RC0SJ5bwQYCPgmYVagsfo9Q297XFQWK9iz7a5t+9
	YrHyqCX8vv2ihS7tk/vFVFYIjfxBGLRTSkCNPzOEqvBgIUk8gdgPnrk4lbA919DfDDDU0rCec
X-Gm-Gg: AfdE7cnarVeILhnuFOLmZIaTtTzrRgKT33tIghsksqh687N06gO4cZjx9EjxLrFzDty
	HpxLaP8B9Er/BMGGA1cUYRmwQgflj+it07vtWg9wD9fV0lRKz4kM9o7V1mwQ89RmIiBh2R++dL6
	sCM1riSf56YvZ3sdioQAun1zYkw8xPwEo3ANLmDuGjLlwjL5jcDhiBvwOZOgob+5eFcyBfZvkd/
	RUzYj7/PdrUtqdGAw7gds0ZxAn+tTVtKEBpHZ1SpxYT4yOHBgX/j0oqtyWorxz9hrmc3hcH++0A
	afRPG/u8IZ1tvVN3wN8B5xSCIfS2rZ8PxAI4T0PMveOrPIHbFwk35H8a9oDvQnrjsDnVkqD1zLD
	lPczJsw05S6VlUBRhyL5XUNYu6LDFE9WlUfxO6t7oQsoebwc4RtU=
X-Received: by 2002:a05:622a:259a:b0:51b:f40b:2fb5 with SMTP id d75a77b69052e-51e4ede808bmr52745051cf.17.1784151816653;
        Wed, 15 Jul 2026 14:43:36 -0700 (PDT)
X-Received: by 2002:a05:622a:259a:b0:51b:f40b:2fb5 with SMTP id d75a77b69052e-51e4ede808bmr52744181cf.17.1784151815527;
        Wed, 15 Jul 2026 14:43:35 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb7372sm14200775e9.13.2026.07.15.14.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:43:34 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        beanhuo@micron.com, can.guo@oss.qualcomm.com
Subject: [PATCH 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
Date: Wed, 15 Jul 2026 23:39:16 +0200
Message-ID: <20260715214327.1933560-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715214327.1933560-1-jorge.ramirez@oss.qualcomm.com>
References: <20260715214327.1933560-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yhoGjrd7THLFxIlnD8JKJgp0J79GoMVi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIxNyBTYWx0ZWRfX8IKwy7DENhFv
 hVTLjaO1ucAp29cwNMXwQrtsoJ90rKafxb2h2bci/KG2Jj5M6GFANjiMOee18QT2hchSnVghbKF
 1zcj7+mQuV8Lsfmf7qpGjwQkMkgY4CPN1S3ZSD+p0sXtykfgLY8v29/vLgwrUVpmvVWgPGVEkiC
 Z69NKrByUGyWg2Gmd/eTOM+GVgLYJsEl5fZpHFAFRojD+JSRqrPWuQ/AudIac2EU8i4QF/QzgO9
 fGjod+JSajpcshNiHjwyxTT9YZojq23YsGshp1Ly1maRkOll3prCb1Rw2riB0kfthZLzCxsTuJV
 w0wh4f4DPMDcwpRwu7/O/gPSpYX0ZjN5CNm3ytGOLu95npzr5djz6IDfk0etcJNuWmnKkLQJZRu
 y/9nc4qH4U/v9h3F0AGyNGAlGH24BjPmkq5NJARk/NjRX8IA9FWOjePPRPUfmlEVjWFWjmlp8ob
 C4zl+u3+ggmyLqcXTgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIxNyBTYWx0ZWRfX+DtjOirGYT10
 l3SNZAO75cZe1oZ2gGpRqcV1Nex7YxIeW9plABZStNZpKnG9Qi7nBQFZZh888tw4xBzRCgS+YOS
 GHMze7WDcvFxe5HBsgCdT82FUBobJsY=
X-Authority-Analysis: v=2.4 cv=LbgMLDfi c=1 sm=1 tr=0 ts=6a57ff09 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=h40Y9pVjyjmjd-OtGDwA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: yhoGjrd7THLFxIlnD8JKJgp0J79GoMVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-0.999];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 04FF544EDF
X-Spamd-Bar: -
Message-ID-Hash: WQUKJMA7IIRHXTD7CDFLWGMD6P32ANXB
X-Message-ID-Hash: WQUKJMA7IIRHXTD7CDFLWGMD6P32ANXB
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WQUKJMA7IIRHXTD7CDFLWGMD6P32ANXB/>
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
is the eMMC CID, a fixed 16-byte value, and it derives the key on that
assumption.

The UFS RPMB id built here is "<device_id>-R<region>", which is variable
length and longer than 16 bytes. Passing it verbatim would tie the
derived key to a length OP-TEE does not expect and diverge from the
fixed-CID eMMC ABI, requiring OP-TEE to be taught about variable-length
UFS ids.

Hash the UFS id into a fixed 16-byte dev_id with blake2s instead. This
keeps the derived key stable and unique per region while matching the
eMMC CID layout OP-TEE relies on, so the key-derivation ABI stays
identical and no OP-TEE change is needed.

Select CRYPTO_LIB_BLAKE2S when RPMB is enabled since ufs-rpmb.c now
depends on it.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/Kconfig         |  1 +
 drivers/ufs/core/ufs-rpmb.c | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index f662e7ce71f1..0a050565872d 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -7,6 +7,7 @@ menuconfig SCSI_UFSHCD
 	tristate "Universal Flash Storage Controller"
 	depends on SCSI && SCSI_DMA
 	depends on RPMB || !RPMB
+	select CRYPTO_LIB_BLAKE2S if RPMB
 	select PM_DEVFREQ
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select NLS
diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index adbec80cf381..a7595be0884c 100644
--- a/drivers/ufs/core/ufs-rpmb.c
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -10,6 +10,7 @@
  *	Can Guo <can.guo@oss.qualcomm.com>
  */
 
+#include <crypto/blake2s.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -21,6 +22,7 @@
 #include <linux/unaligned.h>
 #include "ufshcd-priv.h"
 
+#define UFS_RPMB_ID_LEN			16	/* Match eMMC CID Length */
 #define UFS_RPMB_SEC_PROTOCOL		0xEC	/* JEDEC UFS application */
 #define UFS_RPMB_SEC_PROTOCOL_ID	0x01	/* JEDEC UFS RPMB protocol ID, CDB byte3 */
 
@@ -156,6 +158,7 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 {
 	struct ufs_rpmb_dev *ufs_rpmb, *it, *tmp;
 	struct rpmb_dev *rdev;
+	char *dev_id = NULL;
 	char *cid = NULL;
 	int region;
 	u32 cap;
@@ -215,8 +218,17 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 			goto err_out;
 		}
 
-		descr.dev_id = cid;
-		descr.dev_id_len = strlen(cid);
+		dev_id = kzalloc(UFS_RPMB_ID_LEN, GFP_KERNEL);
+		if (!dev_id) {
+			device_unregister(&ufs_rpmb->dev);
+			ret = -ENOMEM;
+			goto err_out;
+		}
+
+		blake2s(NULL, 0, cid, strlen(cid), dev_id, UFS_RPMB_ID_LEN);
+
+		descr.dev_id = dev_id;
+		descr.dev_id_len = UFS_RPMB_ID_LEN;
 		descr.capacity = cap;
 
 		/* Register RPMB device */
@@ -230,6 +242,8 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 
 		kfree(cid);
 		cid = NULL;
+		kfree(dev_id);
+		dev_id = NULL;
 
 		ufs_rpmb->rdev = rdev;
 		ufs_rpmb->region_id = region;
@@ -242,6 +256,7 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 	return 0;
 err_out:
 	kfree(cid);
+	kfree(dev_id);
 	list_for_each_entry_safe(it, tmp, &hba->rpmbs, node) {
 		list_del(&it->node);
 		device_unregister(&it->dev);
-- 
2.54.0

