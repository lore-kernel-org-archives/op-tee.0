Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4DDC5DF89
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 15:06:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1A1A5452A8
	for <op-tee@archiver.kernel.org>; Fri, 21 Aug 2026 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1787324818;
	bh=YCH1yylulf8EbgQrB2WZCIRrwVIgjivx9cOy+yUc6pQ=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=RtfuF1zeEdXoM96Isp2xkMhd23ewSYKfhLxXPF05DP1AEhWrPDikm18Egziw+cMig
	 XqslTlADGLtFsElopAbocRQlZeVTeFh6QO/3BQRhY6ADpfAqkIIplOvtpTj0VXk2Kf
	 +TtHuPcRwrbnxks+w9RP+K5+Wl4JN4LYYcNfl91ZR4bXxKuv5NV9B4bCMF6XC8Iv+4
	 Z4Gpz34gU8Sg/8puUWOyMzxnuo3gqcYm4QE4Pbns0WOb0T/sko7V3ssyY1riWo/3TB
	 KB/qKgCyAHqhXEbgy7Km0fX7VqPLFyQslO9LtOdwUoLSvUFeEY6CaVUOPdIXqNLSnz
	 YXCBOZR3A3SUQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 956E9452A6
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sdybhw0F;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tz94oewv;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCoXpW2466879
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WqcCf+Dhdx6
	Y50GJtvfwTO5MqJahdd7ZlfJbqzun1ro=; b=Sdybhw0FTGysGHJgAe0wLK1rFvT
	ZYEZNi2NjQ838nO5Ijx2og9/KhbkPqMjewzCeNGEekymYJkBgF7b4F9GBVOsG5WH
	zuX6dD6xAfxgDrknavd7YEDD3ACVzPMVd48uoi1pyLkNO0A0IBpP6ZGjoaffrV3K
	TxH/qs0TVzq29gbSkhXM3dbGvPlYr+NTaLupFySY8Taj2Fd/bcybRxd10OSkqC2/
	GI/MfhzqDU9EVqxoNorp9JJFCAkolia4m9HTWyNCv+bt0RzFKPnwh2qMcxTcQFIb
	B6yBxN0xzJA2lQvBmZyX90n21jcgqJMX5PhqWB3W8IilwJrALlUboj0s8NA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gddj6gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 15:06:23 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8e934385db1so14570906d6.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 21 Aug 2026 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787324783; x=1787929583; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqcCf+Dhdx6Y50GJtvfwTO5MqJahdd7ZlfJbqzun1ro=;
        b=Tz94oewvnPATL+Hrase3oYmppACt8F6a7uIJvu6+io9QM9Rd8k3O18yvYkPcTnmZ++
         GB4T3nAJTzrd9fIV6pQicswEXebwIViJBCd2WjriDhOdiE4Qc+2Jmrv2Bgw9++FJJMUb
         npYDB6wzmPTKFKGxHfKV9CqxXB/no8CoqBpz4XqNsu1H5NiCLOUKAzz8679IAiY5Ns7d
         qseSrdZhUc5+3LaAaprGib1iNpecVWBGo+f1UuHUNK6CM7K3wgu9ylQXpr96PivJ1St7
         fX1xvHQQR7Muw6b8FC/eeBfefyU9EZsEab4rd6laHGCyCsgS98DlCbhMMuPGPUak4/4z
         4QzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787324783; x=1787929583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqcCf+Dhdx6Y50GJtvfwTO5MqJahdd7ZlfJbqzun1ro=;
        b=Fsm+YU37Vvkhw00tkEGeKoHduOEyvzCWZO+yIAMWPJx6EkVqLzBN94zz7AjkW/Gjuo
         +T/EzTFABHmwLdn+4/41Y2RD/dMt7/T3vKSFZwqk9W6dxiHKDSjBV0iQ6RmOWvj1Gk98
         k1k/WgJ/BauhZ89Ig08yMMpZnYkS2BmHwsH2fkwuulI2+qsStsY/iX88B/2KHrBIbfIc
         +oQc1VlQ0b3AQARRZzBhy1IBg2rEaapw7CGAy3oek5szBlxCJl5m0qditCxi24nlNTKj
         6iv4NXcFSKfM/mwbYvQNPFKRuyg9DJUdjImvnpmFpbMjdpQttk20kwMahZ657gXRj9q8
         sSGg==
X-Forwarded-Encrypted: i=1; AHgh+Rpy6kwtbULGFYrZySSBUsJzdeVSEcjY3CLiy+p8duOvKyPSM9+1VV6RNJh4t8PjnQ3rHvLOx3U=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzcH4C0g1GexKwVZPBT4C+bU73SOn7KuBEAYZouLfKGiYi3P2xO
	0CRg7TmNjQai4f/hTu6uHjxqDwBZdI4MSukzH9dj0/J/uE6dr8jWMeiCXYa86FO+D8pZmHMzzHz
	n09Hqw/qnlK0Xx+LdlZLfcaF7BtiHjGMDPsU81o1dhjdYkyr0++XzmfNhn+iQ/6SMLx6QqaMV
X-Gm-Gg: AR+sD11rbV/eMpUclDHblw+8aFz2PwBM6C3lERMiktXGnKDd8XqJ/YSS6cwGz/1nr6T
	cBagHKdoQ5kBs1pRxOMnztBOQGnZrFze9EM6mwjv7NGDJbzBLRhJvvj5ABeja5db/GF2DMI1CUc
	qQ2E+Z3ZJ/cJuPNcJg1nW3y1YVXi0T2kqC8CA7E0lCARgHMak6akRtDvGTprtlj+FUsgd2aKNab
	Ymb0zdVEGfWYURZOkryYqUIAP5AzNVYwYBQLZMf3XT4u/ZcfojPl7x/GMeIVT8H2A8fkfN7BM7n
	oJy5qzocHxgvQQE20lmJnJsspSE+1+NE6VdC/mUa1XJMOYZ4pQFonCXXBl3vgFcYimY6ykHTnr0
	TweR/ipBo7dPcZrRAmyFofPyvI+PbqFe+cM99VaIm0d8wIhflAW8=
X-Received: by 2002:a05:620a:6f02:b0:931:4b6:a9e6 with SMTP id af79cd13be357-937396f3282mr631535285a.47.1787324782329;
        Fri, 21 Aug 2026 08:06:22 -0700 (PDT)
X-Received: by 2002:a05:620a:6f02:b0:931:4b6:a9e6 with SMTP id af79cd13be357-937396f3282mr631521885a.47.1787324781737;
        Fri, 21 Aug 2026 08:06:21 -0700 (PDT)
Received: from trex (137.red-79-144-199.dynamicip.rima-tde.net. [79.144.199.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b8050sm17960936f8f.19.2026.08.21.08.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 08:06:20 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, James.Bottomley@HansenPartnership.com,
        martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, beanhuo@micron.com,
        beanhuo@iokpp.de, can.guo@oss.qualcomm.com
Subject: [PATCH v3 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
Date: Fri, 21 Aug 2026 17:06:07 +0200
Message-ID: <20260821150612.3944782-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
References: <20260821150612.3944782-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX62upGTkml+Pu
 UADvcYcRgt5ePMHR/sFxyDeoQacRf1vuI0XuhyU7B1QrA+xxpclwp7yT7PB+yRHx1vQMRnqvdln
 DL4bbgzujMNllXGyPf1HbiU8uaRMCAk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDExNyBTYWx0ZWRfX5XGXGL0edpCA
 Yr8cDpsTjhwvOdJo3NnHm/hE9CLMNfLRg/ykErf8s7v1T1gsLvrBPN7vMau2VzBh8slKM0khWJ6
 G1RrpyXk4UIh24vRo0jQLqQvCYqrC2PW/gRZETNY6zBQaLoVbLKbeFMRpsoPuvrFnAAvJ53WqcN
 K2xbso/p3KD1cu46N0PG0tE7X5tcdNSkbylHC3qDTnPWGdQSkp0CyzZ1Z04bikkx4MfMZJ6/jqx
 o7LNNUefgtdtMmUbNJFUQzFpOAVqgGe/eZ9K4qxW9ZWi8H3LB8TlynKPMNjvCKWfQjxsY3XxEAt
 SKU0kYI+Zlzv7Q8LMX+e5MFEwFLlfsdKIjgEyz0UG5Wx4DX5Unk8kVWo0C92Gfpuiei8xlb7YXW
 q4sewdCpdEZSqtYYFj8H4TBaOiGze8J7aqZEZYcMAPX78vYF9090hk2qTXNLZVYwSsfr2d2uNcZ
 SzexdDBm9ViOb6L+viw==
X-Authority-Analysis: v=2.4 cv=ApHeGu9P c=1 sm=1 tr=0 ts=6a88696f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=qBhfTSQT0jQfJ5OHMlDVQg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=w0io_FmA1e-6CLxyNa8A:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 4sZR8YQoGgSBk5zxIofTt2Czov_pwKyX
X-Proofpoint-ORIG-GUID: 4sZR8YQoGgSBk5zxIofTt2Czov_pwKyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210117
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.219.72:received];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 956E9452A6
X-Spamd-Bar: -
Message-ID-Hash: UKSNADARQ5FEDFGFVYGCAA3FUARSYHF3
X-Message-ID-Hash: UKSNADARQ5FEDFGFVYGCAA3FUARSYHF3
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UKSNADARQ5FEDFGFVYGCAA3FUARSYHF3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez-Ortiz via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

After a power cycle, the first command sent to a UFS logical unit
completes with CHECK CONDITION and a power-on UNIT ATTENTION (ASC
0x29). The SCSI core reports this to the caller instead of retrying
it. For the RPMB well-known LU, that first command is the first RPMB
frame sent after boot, so the frame fails. RPMB has no earlier,
guaranteed access that could clear the condition beforehand, so this
breaks RPMB on every cold boot.

Ask the SCSI core to retry the power-on UNIT ATTENTION on the RPMB WLUN
so that RPMB works from the very first access after a power cycle.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/core/ufs-rpmb.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index ffad049872b9..d0c7ea7a36f4 100644
--- a/drivers/ufs/core/ufs-rpmb.c
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -40,6 +40,23 @@ struct ufs_rpmb_dev {
 static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, void *buffer, size_t len, bool send)
 {
 	struct scsi_device *sdev = hba->ufs_rpmb_wlun;
+	/* Retry the power-on UNIT ATTENTION (ASC 0x29); the SCSI core does not. */
+	struct scsi_failure failure_defs[] = {
+		{
+			.sense = UNIT_ATTENTION,
+			.asc = 0x29,
+			.ascq = SCMD_FAILURE_ASCQ_ANY,
+			.allowed = 3,
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

