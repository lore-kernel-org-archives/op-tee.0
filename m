Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175D0C61DC2
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 07:04:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5E9B244E0C
	for <op-tee@archiver.kernel.org>; Thu, 27 Aug 2026 07:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787814268;
	bh=3WR3nJZ71sntdLGkiurbZ/vhLxzov9K3d+86+CuSQ7k=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Pg4dm6jsiXmExOc4nyTzx5kfJyozvLrPcUs0HoruVEkWml0/Mp5wih0v5alIwmuaP
	 YmaSJYYZU3qju2lWAipyIi0KHHMB2jEnL+Gjg+H92j6nCZwO2XbNr8X4iBGLXJSJmS
	 UclA2ywVYIkbvzxvb9kgQnpYZZghyddKauyEdOeCVvxYfejhRv043pEKnAZsfvgpLc
	 99xPLUm4jKEOrLqFYaR5nIqMsWWjiWZNFQUtSY94cJWq8++S8/Z7YihrQwvyA10uNH
	 vW+/4T2daoshp9GyewXXuBFbI6bPk+sZzyoZdo0Qx0m7pQc1c6xAEpiT+6XBSGvVz/
	 IUpQ3uIHoG82w==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5BA2444F0B
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VgL3jLqa;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lx3V9X6D;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6RQ6x3835785
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=tBTWWbwGu6f
	yxrPIIks9EpvxG4mNZM9tcUk9IzPtvZY=; b=VgL3jLqaiB2zxikTaCZnSAINTmX
	2LhtLDhcPq/DiHIqg0Vs6kWOg7RmDnQohs9R04jD6xWnCvZsvjx7tfacCgUJoCTk
	JivOjF5fqPTlgF+9QVJX4vnSDFVujl+UEcEAYZwu+mL4SllTaW45GZXqofUWYM1/
	Gl18PgSnn9al8LXIKMQdXWZ3oG3hNWmX/QYecyc5M0X6Cj2wKmHT5M/xEnhG+SD1
	319c3ZONLFx8u7nZtB/ULa0jmWeng+b63WKEgWqjzkL2RNEYFGsl0MA8u3DVNAxg
	I+flijSzYGX/wuLO59rMzsdNc9FFZ42dnZSjSxUU7z9i79aMBM3GLpstPGQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbudh3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 07:03:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d28f8737eso33026931cf.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 27 Aug 2026 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787814234; x=1788419034; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBTWWbwGu6fyxrPIIks9EpvxG4mNZM9tcUk9IzPtvZY=;
        b=Lx3V9X6DD6vIEv7K1x16pOye6MowN1x5JxkNvPemJf8nAlCWhqqEaelC+Xt6RWo9vC
         CpfWuxa5Q2ESzSyL8a2klOLcxUB9dXLiQOsOGCe91gaSX+QYhxjRc+JpAHCI5anekGmL
         i71yw8FQn3REM2vYap4fwVM0zaFZ4Scdmocy5pWATlyag2wHgbDpHm21PadjvsOgMpS3
         +4fVIYYVrjpVOrw2s1+ZsUIJ+UCRzm3dCwdRGHGBmK+Evvhg3guvvRNvkj6OvK/Y7ync
         Ym8Tc/3crUoSSU3c+eqtpgvk3VeZFKWW0v+9miTp9zMAhMHQStIEEWTX+mHNk+GtYf8H
         ZP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787814234; x=1788419034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBTWWbwGu6fyxrPIIks9EpvxG4mNZM9tcUk9IzPtvZY=;
        b=Vcp+INEWqTz9e09Vh4xx5TBld8Y+0f8OJwvOCWcBQchwMx0jhDzH0gR0hM6oE5ngFM
         O7VCX8OM03GxQbEUs61HAd3t5KbzFajfrwRkPtExozXL21GWWfF3i8gxmnZyNfoQ+3qp
         mvdR5aLTnMZ8stxhCMKBlDRe0vgStzbsP6+pA7o9Xr2bgiF0Xr90pE/TdQgwJPTNEjX+
         VwM/7ALSGfxYJnmP9enyjhj9BtYrGOrUekwyZoT35QB90uJX9rXYK5KA26MyIh3gAzYA
         Gl5DuWVpCI3KliGOwp2TbnstYr11YK8JBIb00ESauVMlilx0DXHbOedd6JY9q4r3hXSz
         qVNQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRu7XtZ8OirgmWR2bJLo5d6AeqWf6IxbY4uq2j5rCHj4jaq0gTjmaKGcXNNtVW6kEcztW6qkw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kjw3PIrdjIu5VMJxjOT5sjgzYUj2/4HhV4F53F4bIIu3RfLPUV
	iZViBAbH/K7I8gAfjo1G5qlxYzS6x5635lWx8VqoEN8wkS5l/iT7K5//ShLfGhW0BsZPLp6oRqs
	8s5dZEjSsS+1dnMgzKcAzSEwQp8EYb37w3BHUYb8E76oTOCW8AyEeodfhB1r/m/FVnRAejl9J
X-Gm-Gg: AR+sD10sM2/ID1t+dtEEOXOpGOGqgO2rXzgbHR6WjKbtHX0KNqB2oRL5LjZFrf4GVbm
	kGfB8yjeHhJL5/CN1SQInQ/npDvlEAYkzNHVGfmrtUedhQLrOEi97e2rJKJkd9NMJCz2FJeKh+n
	y7M7QLktMlJW5p9OsQHTH2rJZymHCjU158l0dwe9QrTAi1NVMox53yb5GVprPsxdWiEHdA/jXvZ
	6Ed8G5j0lyGuraBUfGs3m7wojVG6Z1KAX5XV+mxNJGqXUcXHwgZ7blN2YdA4DSLSZu7vo+gBeJ0
	eWENkUYw380zWkNPpktJ2NRbCmz43AqBiRXfsU4a9iL1ljVjdJ8ol7/Y5QHAutMzuwbW9oZKQqo
	5HlDiiDHNtb2l5K3gwW7mNqM4fPSY5NHyrPNhHJmNBEJrO8dQTw==
X-Received: by 2002:a05:622a:408c:b0:52e:3a51:6fd2 with SMTP id d75a77b69052e-52e424270c9mr153497171cf.31.1787814234054;
        Thu, 27 Aug 2026 00:03:54 -0700 (PDT)
X-Received: by 2002:a05:622a:408c:b0:52e:3a51:6fd2 with SMTP id d75a77b69052e-52e424270c9mr153496551cf.31.1787814233583;
        Thu, 27 Aug 2026 00:03:53 -0700 (PDT)
Received: from trex (137.red-79-144-199.dynamicip.rima-tde.net. [79.144.199.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b0d263dd5sm28306585e9.1.2026.08.27.00.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 00:03:51 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, beanhuo@iokpp.de,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        beanhuo@micron.com, can.guo@oss.qualcomm.com,
        sumit.garg@oss.qualcomm.com, jenswi@kernel.org
Subject: [PATCH v4 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
Date: Thu, 27 Aug 2026 09:03:35 +0200
Message-ID: <20260827070345.2853821-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com>
References: <20260827070345.2853821-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pGp5YPVMD5SZW9klFjQTI3zAtGbX1kyE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfXzJ3V6NpdMsJG
 SCGo7/m9cRyYEmLJoW6Kwh+niubdEhKOQbc4mBNBuj1ufK96VlmOMOuB1uvrMVN/hsMsTliRQK0
 WLbOdR+TCiOYqJ8K7hn2I2l/53/MhMc=
X-Proofpoint-GUID: pGp5YPVMD5SZW9klFjQTI3zAtGbX1kyE
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8fe15b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=qBhfTSQT0jQfJ5OHMlDVQg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=w0io_FmA1e-6CLxyNa8A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA1NiBTYWx0ZWRfX987qEBa2kcgj
 G+5PjgSc4a/iDEPs35HGDsWQS5QFy6c1KymscRLbzrp7A2dxJgrhzH8NmgvQ8x/d5gG7xQf4INB
 NcbBzw0F6G8HWgs1jTNa1oZK1XZ36njTdD5oLTwSJc9puq2zmZu3r5HTWwj+0Agg6RyMZRU8ZYO
 Z20KAIBkacM2DKFDwQZltxgAPtqcGb+MCU9U6l/Sy1IPHyRaQIq9q3B0kGurJBs7kbOG09O6Y01
 F/THE9yw6ts/EKRybV4PRZ9WD0/FRlA5Xd7yce9lX20EpC6pVoYsHHftkIx7rrahMU8dwf0y1HS
 XESmbXT7uD7Fs9Rd/C15GUbrdJQ4CJZd0pnAC3H02YurzZgBLwQ6y8734Q9lozuxVcvflfD2tCJ
 3NQ6PhmF2D5lLcmowknhiGlIOeHH0B+/wYlEWskZCx7plLlUcwGv24ftXUcUuzMLgkrYVg8cMui
 NhD0qeWlgH0Oi5ObbZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5BA2444F0B
X-Spamd-Bar: ---
Message-ID-Hash: 73WQQR7AGZODHPNLK7KIXWFNICQA6424
X-Message-ID-Hash: 73WQQR7AGZODHPNLK7KIXWFNICQA6424
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/73WQQR7AGZODHPNLK7KIXWFNICQA6424/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez-Ortiz via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

After a power cycle, the first command sent to any UFS logical unit
completes with CHECK CONDITION reporting a power-on UNIT ATTENTION.
The SCSI core surfaces this condition to the caller rather than
retrying it.

For the RPMB well-known LU the first command after boot is the first
RPMB frame, and RPMB has no earlier, guaranteed access that could clear
the condition beforehand. The power-on UNIT ATTENTION therefore reaches
RPMB and fails that first frame, breaking RPMB on every cold boot.

The RPMB WLUN needs the power-on UNIT ATTENTION to be retried so that
RPMB works from the very first access after a power cycle.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/core/ufs-rpmb.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index ffad049872b9..79e6cd2b20a0 100644
--- a/drivers/ufs/core/ufs-rpmb.c
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -21,6 +21,7 @@
 #include <linux/unaligned.h>
 #include "ufshcd-priv.h"
 
+#define UFS_RPMB_UA_RETRIES		3	/* Retries for the power-on UNIT ATTENTION */
 #define UFS_RPMB_SEC_PROTOCOL		0xEC	/* JEDEC UFS application */
 #define UFS_RPMB_SEC_PROTOCOL_ID	0x01	/* JEDEC UFS RPMB protocol ID, CDB byte3 */
 
@@ -40,6 +41,22 @@ struct ufs_rpmb_dev {
 static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, void *buffer, size_t len, bool send)
 {
 	struct scsi_device *sdev = hba->ufs_rpmb_wlun;
+	struct scsi_failure failure_defs[] = {
+		{
+			.sense = UNIT_ATTENTION,
+			.asc = 0x29,	/* power on, reset, or bus device reset occurred */
+			.ascq = SCMD_FAILURE_ASCQ_ANY,
+			.allowed = UFS_RPMB_UA_RETRIES,
+			.result = SAM_STAT_CHECK_CONDITION,
+		},
+		{}
+	};
+	struct scsi_failures failures = {
+		.failure_definitions = failure_defs,
+	};
+	const struct scsi_exec_args exec_args = {
+		.failures = &failures,
+	};
 	u8 cdb[12] = { };
 
 	cdb[0] = send ? SECURITY_PROTOCOL_OUT : SECURITY_PROTOCOL_IN;
@@ -48,7 +65,8 @@ static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, void *buffer, size_t le
 	put_unaligned_be32(len, &cdb[6]);
 
 	return scsi_execute_cmd(sdev, cdb, send ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
-				buffer, len, /*timeout=*/30 * HZ, 0, NULL);
+				buffer, len, /*timeout=*/30 * HZ, /*retries=*/0,
+				&exec_args);
 }
 
 /* UFS RPMB route frames implementation */
-- 
2.54.0

