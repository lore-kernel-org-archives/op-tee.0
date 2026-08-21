Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAEA4C5DF94
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 15:07:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2541043932
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 15:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787324846;
	bh=sD00N96MX+cXHCKZfKm2MT7C5Z/K0H47C57CyGtLjlw=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=wj3eq0/SenSuX8vaV7rAYx2TyiOXxWHneWj99nE5tk9GP51kP5CpBrxIKARQ1+so1
	 uUw8yaaPPdmyAhCEMgL29RNx25kGewiWjasthKA1gr2536QPxixy+S4s0Sjg0r0JMf
	 wI+cdJLI4zqh43sN7BwquXBNljdIuD9Gj/qGXQDYEK1966TTAL4S/2HL+DGxFCIz7n
	 n4p6buItIVQz5QBBVaR2Dyr2qk6138lPegPS4qRCMGE4RBmKXAtEj98C8oluDlf6kN
	 eQrcJEFLS1toMVwG6THS6/uKY3pelFvXu2QvHtJDm/xMH/K7eqUIqqXYVw/B+OhR7u
	 akFO05yya1SQQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 68BA2452A6
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CIrC1CMc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TO0g/KeJ;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCokUH2257264
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qlvi7ccrXBz
	fPu4z9BFos2jADP8tokNi9C60HKQzio4=; b=CIrC1CMc3jeaHUd9t/G3DfGylmr
	tahsY9iebdfKUBsDE+3VJy+xcZUg1MCnh6mLgWyI/JW0YuYTFvDVEveIRpzvzvjF
	2UxDoTCVF7iUOGmBC1QioqeJXe7C1/M1tZP7Tplknq0WvgPfmRRGIicIr/4XzEG7
	wDDDr7cs0Ux8SxbmTeKbOeZjRfX3I0Rj6AO/KmHq0giic0JK+HWm+QxM6D6eZWCt
	gPG2z3UcwA7iBxzHjPKqyx6NdSxLEwdW0iPksC36svZkWqdqlZQ0c9waZRfslHOM
	B/eyjssyTgE38GTRzfpm6/PQI3756alBquWGjV+RyoVNX6cKT+sOkFx794Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ecbaj3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52cd0374265so19849951cf.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787324786; x=1787929586; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlvi7ccrXBzfPu4z9BFos2jADP8tokNi9C60HKQzio4=;
        b=TO0g/KeJLpc+JMyQuGIo6jtNEg9xK1AKhiFTAY93GazrlKg4bZ3cr9o+YlflTWxbE3
         l+AaS8TQpT7SMpORxLgXn5uTRc2oKX97+TyXKG69OjUW+UEvEx+PfvbPARkyecX8Q/hW
         O5MfyYsXPssJ43OHoFflp/88rlCunFPUv6nJgSWbXSq7Sjk7CUYlRQznvZTNB3jf0Unl
         VhGBwGjvVKWeMLcUbFet+ffP/de9+t15TL37gs6zY5kouaAcg4jvKvs7bsXSl3zgr7de
         6+jXAmO/m59qbbK2A2mvDXHj8atejT0N8H99qa1vzGyvNZaTWbM6WHUyw8wD8jNNWrAS
         PeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324786; x=1787929586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qlvi7ccrXBzfPu4z9BFos2jADP8tokNi9C60HKQzio4=;
        b=P9fiizoDTzBSgk+4xCBB56JIbQ3kdg0u2kdvXxLUtBeJkSXXTOfLDv2K3aqKZBroG+
         ev4smjqFKZ85WnNAxL0ksiNd6Dmc5d60TnKOiSXT39IjzjaT6zDAOMxWou3EzifeSXQ8
         NB09lcOYFOdLzcu02jy4lbKwkoZBhzGEmZibWvLNkp3g2oizW9cJinJbc+sZnNlB2IuU
         Yv1lzM+04M/r1NaGGwjS34muKpLHn+jimma2xppIaLdRe3d4lAtmFxClV4ftn4/Ie+AV
         Gx5R8XF20zr22kzHGMJ4dT5niKLyWKKWhRBcq1Y2W2z7lASvqerKBinTf59huxfHdISD
         AxRA==
X-Forwarded-Encrypted: i=1; AHgh+Rqmudb3I127O8nojDmwVNVldN6lkQQNaCCLqMkr485psVI6N9FGnbkwzBEc7PdUTy4+IenhOkM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwoEVUMyN9QcybcrEGybaJTad1kW7EUNCWhXevx3hDfSwe1cjSn
	wX6ie5GGx04ctMWeXKkZF04xF9paV2TwgKnNmVjgejGXWIt9OrlpdlkItA37MuhIDMlCXQbYT3U
	5x876aJDtxW4Jz4JM4IRSEnfJnrkFgV8GW7r69zPtpJpuDuCZEjjfkQ/JSk6+frS528lH32mj
X-Gm-Gg: AR+sD11cBrHyTcvw9zbMPv2ql9LidO4icF8LtLtRl9KnMdtCZ22KIy4UkM23S5Q5Oqb
	GsuL7tCNJkxJGmK+aEjDuZ6V0YjMieax/SRPXSDGgdcI0ra+MLkEg+uRwVd3VfP9iAy8+vVV4SC
	TxntuW1pz8SAnQAVl/zSlkjB+DbJET5riMp+9mF6PYen539ffyX+ECS/X+oPfLNCXFuErewZ8k6
	x7ZvwBRs6XJu+SfZibpaui66P8eQNgeVmnc35rBX2YM4wXU6mCw62MxKXDcjvmwgQQ1mt0aSX3Z
	AY7LTk8GrEywNnPS6uGKBwnatNHb15S8ooOEoxBNkxmpeQ++OdAZGZnHfkWpzSc0oLu2nq3lM08
	6JXQ88CkOB9le8Cix0V+WkSVWIQfu+MHA5H30duwMzj9VQ/Wx4I0=
X-Received: by 2002:ac8:5a0a:0:b0:52d:8679:ba91 with SMTP id d75a77b69052e-52df5665d69mr63016051cf.8.1787324785615;
        Fri, 21 Aug 2026 08:06:25 -0700 (PDT)
X-Received: by 2002:ac8:5a0a:0:b0:52d:8679:ba91 with SMTP id d75a77b69052e-52df5665d69mr63015081cf.8.1787324785078;
        Fri, 21 Aug 2026 08:06:25 -0700 (PDT)
Received: from trex (137.red-79-144-199.dynamicip.rima-tde.net. [79.144.199.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8050sm17960936f8f.19.2026.08.21.08.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:06:22 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, beanhuo@micron.com,
        beanhuo@iokpp.de, can.guo@oss.qualcomm.com
Subject: [PATCH v3 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
Date: Fri, 21 Aug 2026 17:06:08 +0200
Message-ID: <20260821150612.3944782-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
References: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfXxjqBJ5OXY9m8
 bDIQ7doA8pMorojO5M3ykQOHNuHAqYd/5remilHdgaaszXBT7pSUpdcMQtsL2v0LL4qyaeXrYwH
 D2kw2xPHgXS2y0BndQOFPMG65IuFHFjcUqybbux6+K14bx1T2+Ys6tZnxc6cFjOMNuVeWMpb83E
 kBFTOwaqmkevTbv14tBL/7hKi9EDZ2ZtvfUsWv1PqznVfPwCnpXC1UgwdzYmdCKbwizLtPxi7sP
 pywnmdn+usGu08Pm2d74WhL+1A2uKoDAUesj4w3kn36mpDRSZymRlqNionKvFaxCoApkBrTHt54
 Ileq75Q3TsIuMUtpFMQy43Lj8K9fm1BIQ0V/VE+OHLLnN0Kbmz/xZZsgOdO/MqQNvi7RPF9sto7
 lnNubEXlyTkk4pJEaA64YgMHssJshVmJhTr92BznsrgGfvh3/WWv1An029gRp0LgSleTcK1s5dq
 9LCmVucjvvCa0STb2nw==
X-Authority-Analysis: v=2.4 cv=e/s2j6p/ c=1 sm=1 tr=0 ts=6a886972 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qBhfTSQT0jQfJ5OHMlDVQg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=OSdCpuDsIsRB4DqEP3sA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: -hvC1qZmVJgBKGUwNK8867OwpY6A9u0x
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX6/0yMOZ/8H5W
 uFF2ZmL7XbNUmUXkxTDXew/oTBVNnGp2CM5Hs+tQJVYXB/epC59FfF7ihAbEPlTUhjsoM0I4lR8
 Rcdzt2YjJzt0KCoAMLzHsmHJEok5oDw=
X-Proofpoint-ORIG-GUID: -hvC1qZmVJgBKGUwNK8867OwpY6A9u0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210117
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[205.220.180.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 68BA2452A6
X-Spamd-Bar: -
Message-ID-Hash: E3TWJFPQS3PBE2M6662LM2SHOMY57S7J
X-Message-ID-Hash: E3TWJFPQS3PBE2M6662LM2SHOMY57S7J
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/E3TWJFPQS3PBE2M6662LM2SHOMY57S7J/>
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

Hash the UFS id into a fixed 16-byte dev_id with blake2b instead. This
keeps the derived key stable and unique per region while matching the
eMMC CID layout OP-TEE relies on, so the key-derivation ABI stays
identical and no OP-TEE change is needed. blake2b is used because it is
already available in bootloaders such as U-Boot that must derive the
same dev_id, avoiding the need to add a blake2s implementation there.

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
index d0c7ea7a36f4..a1e169ad3096 100644
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

