Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6009C44501
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 08:38:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F2AC5450A6
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784191119;
	bh=NCMb0CAxTVCcPUPM3ObrHiyfUVdP5M/LsUrX5gE5HoU=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=xiD8O+bsLsYYIKj7SqJfG4TroKfCjKXd/PG2WbdZV+SdQtFJnyuDhLHPzKopjCdYj
	 8x+qt1aSncN2tikfD0D645dhwtamGOsz6BYT1axIFDhMbO2xLhpuXEOjCcBdwLZkGW
	 dgvxqH3eDWTyTBkKpmANCz1PNHQAIeGBEclY5yxpdP9Jl7wHbr6+azh8PpaybZmOG4
	 BXfQ6iu3lnVjGh1dmmyNRXe3WDJU8xjUqCdceO83W/hQsIjnYik2QvsBF0M/mjpMqA
	 4npj1lLrof42eJYmzBDg4SXjLBZ6yfQQAw+MjDG4RTi6B7GbVJbnNPDBIVhOPwjgiW
	 MaNqXk7TOgXxA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3310C450D1
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hlHEw8Ei;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DdIX4XKo;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7Dkm91734165
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Vuwauky0S7U
	MDJ8ZgbId8W1CiyJ3qKKODKvrCHME6gg=; b=hlHEw8EiO6Te84IfBJxuj5IYC6F
	3pS+lBJMkXDizUjRZZu/bjN3NRtdVIB6Cqx0+sUn67tISa4gyLrExoy5MgOFeRJU
	PJ6u5hMQfLDrCe/JMFrKuRx+CB3IPY/MuaqJkOdUH79fjCE2QD5MeWjwVbF1E3L0
	01kRgNTPa+2KTVMzC3xvYy5ihDNuW4gJNpsC6Zwru6C7wIVZeVPE/YJ0Htws660/
	GWmzlfUQm9AiUb2QrL1hpvgI1E87wzx5F4HVOg18/T8myfn5LSd01Qshev1bnZq6
	Mhk0WuLyQv8pzB+vz1HEGksXVO3vu6ogSSTc2X8TMCVnPDJI7bPYmOtyZdg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed063e7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:41 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e538afe65so733457985a.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 01:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784191061; x=1784795861; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vuwauky0S7UMDJ8ZgbId8W1CiyJ3qKKODKvrCHME6gg=;
        b=DdIX4XKoaC7HpKE0YeDE66z2073YYWz1NfSQVaidmFGlnXJlca9UieGSzknO+cHt3Z
         wmMS1rhlKkWk+7E8PZkxbTUu5hyq8S5Ees4641FLw9cEXYKzdUZ/kOle9SOPgTQcn1K1
         k0HY7xw3p62gCp2oBhE4sX6o37KKjDB67FsitduJJ4UrM/NlWVKT7ed17c54o5t1yMuF
         7xo+JBDicrM1Zcfk9zi6/cg32Yhlx9xr5iR7gsLt74EbA38kYifoZJJTw3TPdTOqg1uH
         HnO1aAw389/2e6pY6OemYpK9qMToQIb9LUgiHXYK5U9/dCAjPCLpHEEuUPbEr/7iBVpo
         Bu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784191061; x=1784795861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vuwauky0S7UMDJ8ZgbId8W1CiyJ3qKKODKvrCHME6gg=;
        b=CnX37HcFfA1tWoN00JOpdt3DHH+5QskadbRpSn0erTnImU9cflRiq6QncVYo+8dsii
         5L1fw6/i04lvY6E097JT/vwypU1L8WmcKsErbwF5gImxHlkJ//aggppP3INz5zBBl6re
         5NlhUtwKeuSiMBp+Me/osMHh+ojjALBZxFjhj4U3T4bFFGGQMOOedQNcmWoa5tbz9dKk
         57ut6cbQAsGMQI0HuvoXOzKqYsXzAEdZgK2smRxRAc/DbRXA3KO0UdGFqRNwMquoEafo
         14Z87UeB+EBTMQ/TYZumdVqmyIVoA7xCX2+hXnq/SAib1uReGjjWVjuz+zhc/BXu0c6A
         GI6Q==
X-Forwarded-Encrypted: i=1; AHgh+RoA7IEhw+lDBQqe2Ao7rsBZdKPz2uXDkiDx1+omCU8TEcoXPwaC5Fd893fDGpYSs0gCHxVNxf8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyfDkVwcQ431qV+Zux7Jv4T6tyHWttG0KFuxyzkHQh5U10fDqzE
	675kOilZrWGX0mfrP75uV9646e2pihb7if+cBx1swcirgRNsaSNdb+URlQRdcew+SOO0pjFNtjR
	eH8pOpbOiT/OWZdi1SLax+8Cqnn2XCaJXtn1RPs5AGnvTrwZrWqZhRb1UwVUO/bmVfDN1J+CA
X-Gm-Gg: AfdE7cmLW7ryrypEb+9iU8Jcl9IhfXMtc5OojxBVlWa8o/WFC0GTxTPlYtNEntgMoPW
	w9+RTjuaM8f7LtxmBFC+MFMj4AN8EMwaUtFDwCSQ4CbY+4ypakH54XMRE/sjZTvsplNpxRbdHQo
	p16ICNNl7iU2WyflVjEw06Tt79XXd05Xd9aUuf8XVjxDSlK6PMWlGjcpVnRX6kq+BjdyaLMtx/Y
	y6AT/a7sts8aMxTrOT2BnnpXtPQGQxHcgdgbH3e054VVX3afSPcVXDX4S0MdwKs3Emhhe9J5iHC
	++PeDvey2lq+bp/Xg03tRpt1vs//Im0zW6UVSr3FBg77Dv2pvkMvvNMxRWox9SWbq9mw9cVxHkM
	1RtqoCZVj1L2xj0Yl/lsJaT9FAVcdEW4bS9UzOj3BNi2B/8hU9yI=
X-Received: by 2002:a05:622a:4185:b0:517:8470:2d2d with SMTP id d75a77b69052e-51e4237cd58mr115608681cf.29.1784191060678;
        Thu, 16 Jul 2026 01:37:40 -0700 (PDT)
X-Received: by 2002:a05:622a:4185:b0:517:8470:2d2d with SMTP id d75a77b69052e-51e4237cd58mr115608401cf.29.1784191060259;
        Thu, 16 Jul 2026 01:37:40 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e94e7asm43614295e9.12.2026.07.16.01.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:37:39 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        beanhuo@micron.com, can.guo@oss.qualcomm.com
Subject: [PATCH v1 2/2] ufs: rpmb: use a fixed-length RPMB dev_id
Date: Thu, 16 Jul 2026 10:37:20 +0200
Message-ID: <20260716083728.2226422-3-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com>
References: <20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4NyBTYWx0ZWRfXxGkbPal6gFRe
 /BKVMxBDH8Sb9o1DzIWVBygG1tFYce/t0P7D+y3MRkES/7ruRIT/ww4aI/cNcTi4V5Bq/xV75iZ
 jet4lCmDtC151GWRYHAsQ1G2GG8g2wE=
X-Proofpoint-GUID: siPyZPtnR47ihHE2W4qTTBrCfiexgB50
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4NyBTYWx0ZWRfX/8aY7lW9Ah5h
 r5ALX4CA9+X+gd0hd8Q0YMW+9F5gUoFPTQIWZ+Q5kTus05KhzoeFOqLNJtzRnUarJazXi6tLz2u
 LgRSfRlwNtK08+zeNaf5Xqx34je7ZNOVf1IyQleCOs3soDDvSU6A/JkZx5qJvm25Ot4841XWkjH
 5Roc3YQsdHODMXjttT+fi5EazA8pSXXIWAuCNsScZ2K/cCzOO0I1tAqdj67nQ1fFz4Fvf3QllTi
 dg8N9wjUeFD26j6xoWlFpMj7HcPGWbG1ukJ0WkBObX4lFDGaLG07gzMA2+BXXPlftilsej1DAeW
 JQvw3oGHz3oYsrRz94zZSu+2OC2wO+mM2g/osnSEXLwHY/FYUkbTF3U1d4WCnENF+Vx0jsLRbUm
 PYy5MWNuK7lUBnGf3N8+lZ2sjW82ovmo8ORz6urkuiP9tXrhpbmofeZdi6aPL/Aavp+YVqBfuPL
 1KdTIPG4FoKLkAKLY9g==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a589855 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=OSdCpuDsIsRB4DqEP3sA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: siPyZPtnR47ihHE2W4qTTBrCfiexgB50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	DNSWL_BLOCKED(0.00)[209.85.222.198:received,205.220.168.131:from];
	RCPT_COUNT_TWELVE(0.00)[13];
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
X-Rspamd-Queue-Id: 3310C450D1
X-Spamd-Bar: /
Message-ID-Hash: HW6YAJRBZ7HAWYDAEGOP66XCMLPD2BN7
X-Message-ID-Hash: HW6YAJRBZ7HAWYDAEGOP66XCMLPD2BN7
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/HW6YAJRBZ7HAWYDAEGOP66XCMLPD2BN7/>
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

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/core/ufs-rpmb.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index d0c7ea7a36f4..b800871269bb 100644
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
 
@@ -154,6 +156,7 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 {
 	struct ufs_rpmb_dev *ufs_rpmb, *it, *tmp;
 	struct rpmb_dev *rdev;
+	char *dev_id = NULL;
 	char *cid = NULL;
 	int region;
 	u32 cap;
@@ -213,8 +216,17 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
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
@@ -228,6 +240,8 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 
 		kfree(cid);
 		cid = NULL;
+		kfree(dev_id);
+		dev_id = NULL;
 
 		ufs_rpmb->rdev = rdev;
 		ufs_rpmb->region_id = region;
@@ -240,6 +254,7 @@ int ufs_rpmb_probe(struct ufs_hba *hba)
 	return 0;
 err_out:
 	kfree(cid);
+	kfree(dev_id);
 	list_for_each_entry_safe(it, tmp, &hba->rpmbs, node) {
 		list_del(&it->node);
 		device_unregister(&it->dev);
-- 
2.54.0

