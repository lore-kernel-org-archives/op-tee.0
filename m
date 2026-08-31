Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A96C624A4
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 15:48:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 44E1B44DCE
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 15:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788191326;
	bh=55VPGsducrFBA+UqitLk9xJS9IoxNdI2kJrTVgqF7JY=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=X3JWP6jEbS3Bg8Togjql+jlvxCSKDHxd/baz4orMd23wPufY2FboJGfkeITHdQQJG
	 38+L996sWNhmGS+4kWXlSnc5SLiuJV2A1gt92Sw4FXQGoxooqiGJysDEHa5irsxdL4
	 htJ6j4xBIw/SPpa6Wf5kExiKJ2wdNoA9lCSlou/x7l+Gv+W8t289WK0SoTCjpPteop
	 e/W9ukbEWEkYLB3JB2Txw694GwLDZlqYFbL7EvfIhuXDjUOkoEN18ascOXB7Ukh9wc
	 JydXgs4rD5uLTMjOwhTtG7VoqCxRG6tmDUOfZU38W1dTxv3dUi7ghMoGM7i+9oSdk1
	 X4zFE7oaqD9CA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4072D45363
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=flJICbHk;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CgXgWFJL;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETcWT3895782
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lRFPnoHcYDM
	nlTrKBHKWdtQ6nLD/+ObQpWW6OKlIDQU=; b=flJICbHk7WkcQ6BGwyu7cD9ptYz
	R2YruVwmtpnoyuv1muhvXN2aTa1zjJBxXofO/cldvl+Kp5yJ8jTnKKgeWLU9AXAq
	hX4iTrVNqgKb0M/t/L+VYbU5u+8uRdJqc7I2ZUwhuDx7x6VpHrVYvn033l9WQEaT
	nzhHcvE6O4pGHYe7fQFGEwHrazxZxGuGHfa3ism5SKyocR4sQ9GY5IBQ7TiuluDN
	GJ9Dh7cucT3dZhoT+vukmHzUuMTS5sg9+d/WgwgaZQM+tv3y4ckCSuh33H+nZ4gh
	TORJaLxeyef/Q+E+cAfw4JOZFlBINGTCwhCuXwlXePsSPigX4t256fC6xUQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6rb9jus-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:12 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93494cce712so625766885a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788191292; x=1788796092; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRFPnoHcYDMnlTrKBHKWdtQ6nLD/+ObQpWW6OKlIDQU=;
        b=CgXgWFJLTfbIrFoYgStgafn4joTSAPp0YQuqfMwvly1UUyna3DDC1CsQSzH1jG/P5K
         MOw/3Ir9JqBsEXxthem5kOtnePw4CYooIOJolbmPlPtBz2hZT9iBZjuycf9isrv5KJ7z
         dP0CjRF+wDYYRXhN7IYqTnEWc3aycQs2ERV5VJzlfXFTJAlyYH8pP0/yRbbeDn+fh2FK
         AUvuWiJ4D+1drs55cCL+EF9WD4ZqzPZRz7Ny7JgltgBZLEKcOFBA+/usekeCr/YMhobd
         KLTBfsZdgNjz+RpI663aD+sfGbcxhieHI1m9VIAgc+SdA5hH8sMcI/eWp2p2M0bJUDh8
         3FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191292; x=1788796092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lRFPnoHcYDMnlTrKBHKWdtQ6nLD/+ObQpWW6OKlIDQU=;
        b=rp6jQfny5x2xLIP3dxPFTChqMHyhYa4Bwl4DcA9thA/ZClkwWnvVQ9Htgs0byUKRdK
         NsWzq+WBFxZaLDlaJ5x4yj3RebN76kz1S9JUpUQ2FQm7LTnAbQuXLsAL5HobbK+NFyFs
         lNs6G55Lbd4bpJtcm9L487qdhDLg5wiE0ewy9SGBx/yNtDGQaJbwv4K+TcB+wtZ7tFJJ
         1LpOgCVwZHEVw81ExG5MPX9IgkWXClLMaPyNFWSQ2v0SmxoTFL9GRp8NWoGP+6yZmE/Z
         4Q0p5OjRfDz2xd/dMDqvenLgxyaIxTA4cVL91xJR3b45KJJdkBu62d4EtDaNo0pp2L8+
         Jc7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp+VxhKpR0hAa+P4uXnmIgo+oVx9gP4FQi5nir6vLjN+Ax9Q4i0Ll1WB6rvwcoC5QqtJrglOcg=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lMUN0UnGY8f4sDFs8E5eSS0E9Qgu4+ui9EasK7fwl/p5sTdlSo
	dO0Xhy2GoAQi1hRaFG3ZZHDvzBS40Xt9bP5hMvDuDBa4ywvEtwwz4vdimSlPI4TeuX8fBz973+6
	wsyuMzr5VvlrB6jiN4a7HlreBandd73a7M2JwuhQeUz1oMr9sKZrie7c1aTanMKxnpclJCbfQ
X-Gm-Gg: AR+sD13cvWEYx8bZyb24zG3jSpUADTG5AjnbK7DiRCFqlSXzRiPXPx3ufgSylsiGc02
	HWDkH+G3IV58fJL2E6hacy+EbZpoKR1NQujh45FWrLitv9atQvNSptQymGQ4C7Yo9e7FbCIgfb1
	bZzNfaAcsh7GFlr7cFIiIbx6caVbnygFaVfiredxf1z3EsjDSlC2kdfTWep0ZIgSBOQ0QfCc3w5
	rwocIPTlHz+hL3ElK3xawUGkYsN1Uk/1JrT8pGWWfzj7DVlCDYdanMe/ThEpqTkI/MZy5EdkndV
	l9JrOudjS8LCCBZF3yepCAAjPZxq2h+6Llj+ad/9mRORQa5yvymluY2WJ05UVvKNbQZQkP/VdxD
	G+Cbiymq+rUDt2PPC8fQAWUUjxJIDcxCyo40CHPAUfaoQ0gY=
X-Received: by 2002:a05:620a:199d:b0:939:48ab:3632 with SMTP id af79cd13be357-93948ab36f2mr239122585a.10.1788191291682;
        Mon, 31 Aug 2026 08:48:11 -0700 (PDT)
X-Received: by 2002:a05:620a:199d:b0:939:48ab:3632 with SMTP id af79cd13be357-93948ab36f2mr239110885a.10.1788191290565;
        Mon, 31 Aug 2026 08:48:10 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b456sm1558315e9.2.2026.08.31.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:48:09 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, stanleyjhu@google.com, beanhuo@micron.com,
        beanhuo@iokpp.de, James.Bottomley@hansenpartnership.com,
        martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, can.guo@oss.qualcomm.com,
        sumit.garg@oss.qualcomm.com, jenswi@kernel.org
Subject: [PATCH v5 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
Date: Mon, 31 Aug 2026 17:48:00 +0200
Message-ID: <20260831154804.719528-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
References: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rMg4xxRVp6vYo1XwS7sVkxsNFQ9alee1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX0OtPjaQ5hf9O
 sKgWsT3nrhsmrjO984e5xSIGvED7N6yRqXqPQTrZpb22j+zEWMCrw1hhN5LhOu55+FCX5eLRmhi
 fSnTYX9rQIz54EVfa+1EIXYjoTBanZnRFghYrkNKNBAs09TIvDWQ+HQjRNkJqgDrCkwtRK5Nmyz
 Sy1EMSS37KQjXisTelwhWQBERAF42DtQOb6sHzUUha1AJjQ6GcyXPmdTU8QChPUXoSQtAuyeVl4
 1y08Q137uqHetRitHe3AbANPrMMYJ9/htMUDi9Z6LPgsbD2ihw6PeGcdi7rY5Nx0n6DNMD3JfjN
 qt9I9yJUyZ7Jyx5cIeJ+o2wwVQskecAIg8EqiV0SjfnGhL4RIrmOucFVh7B9vB2xh0FtGYgol6C
 foE3jMTdvQghmwoOyb2PkcZHuwuxmoQca14t528/dHbOpTC69Kg2GLqEnVqUsv/DfR6HJrQjeix
 ewj0CrnBTbvZsZ1QWvA==
X-Proofpoint-GUID: rMg4xxRVp6vYo1XwS7sVkxsNFQ9alee1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX1loZl44FofT6
 7XsmelgkNMbfsZig7/2xgYqc6mOX2frHmv+4dIiKZkmq5wY+AAu4Z3NhI2vu+GlSU2q8P26fidh
 I8yWOePj56CsyReqtr5LR64wHA8sZyI=
X-Authority-Analysis: v=2.4 cv=d/fFDxjE c=1 sm=1 tr=0 ts=6a95a23c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PY6Zn8H8AAAA:8 a=1XWaLZrsAAAA:8 a=w0io_FmA1e-6CLxyNa8A:9
 a=NFOGd7dJGGMPyQGDc5-O:22 a=ySS05r0LPNlNiX1MMvNp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
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
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.222.198:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DNSWL_BLOCKED(0.00)[81.38.139.250:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4072D45363
X-Spamd-Bar: ---
Message-ID-Hash: GSQPKAJGZKIGPKBHWUR6D3JMO66KDTE5
X-Message-ID-Hash: GSQPKAJGZKIGPKBHWUR6D3JMO66KDTE5
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GSQPKAJGZKIGPKBHWUR6D3JMO66KDTE5/>
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
Reviewed-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Stanley Jhu <stanleyjhu@google.com>
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

