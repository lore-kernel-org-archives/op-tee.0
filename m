Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF26C44507
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 21:44:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9CFFE450CB
	for <op-tee@archiver.kernel.org>; Wed, 15 Jul 2026 21:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784151849;
	bh=weDWNYsNhzeRZVUpohEom+lFTgbR2QAn7gYrniDBshk=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=19xPeRQYm+Eyxur8ryUR35isQvwiP4QgeMFrQ+sFFFe8bpMcQZXlRTusA3d3smyTq
	 4iYqrGPFXA6/11u9V/91iydkPmnbN1QumnQQgCitsQFnL4tBnv6hUt0CQ8zVT2Tq9v
	 76JTuuDP0ZBtCgW5b8HmGzJhO238G8A2cRuq8T9IIxLz/jzD4GGgcfOnfqZ2g5dN9j
	 PEmwlyMi9eFtmQa6QHqfGgqXxovIWDAxSsCYG5haXsRjzCcYk0okLIZrJ4pbVZUnXR
	 Y3VK6SXMb0zk+Fs21ZNIOHfAeH8L6AB04p6AEBtIWxQZ5ZoYDRd3UHSa4a2uAf+aP1
	 /bk8hSc7Z8NCw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6B88B44E87
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eE4jgWwI;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YIU5v7Ze;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FKPexD1715073
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XtgavnUQZV2
	QvtqzUdQVFLJ04q/RXp08/VIYqL3ZGIQ=; b=eE4jgWwIMZy+SpoT2GeGPBr+xsK
	N+QIRqSvkg2ICkfS1j/TDz60zhRV7LkAIvsc9/a6UMTzr8KaUV1B5SjYL3R/+if/
	R4bDXjKD7Rvqtc7Vey+FXNnHYjXUkokKd0aqYDk491gBifjWxxNCnWXCOVvBqjP8
	XaHpVilRIoKl4EqSkQP9HtEZ/oz/JrzgQtX7MpEjETdXFX8iQyiOY7u97Foo8nn4
	BjSs7welwRvbsq3pNd0Ft1WUaKuxG2bxxJrOwUIwct7UnPs6kbpek+etEX82Jvtt
	dU8bfPpQT3P46CvDpMLWwLP58D3/5AVMYkSAjTa/jQSBEiz4KyWPXxDiT/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe68wu9yw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 21:43:35 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so43185811cf.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 15 Jul 2026 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784151814; x=1784756614; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XtgavnUQZV2QvtqzUdQVFLJ04q/RXp08/VIYqL3ZGIQ=;
        b=YIU5v7Ze77+ORqErIWRhNNR8BpxuhXNUEVKea3jpB785gPT8xfnS9xOAK+3KQd3Y5A
         +uFir1m/4E/obwERaoidDUbM92eDR9QF9RigAFPLaimCsHNdEFXpVh5U4Uzs/40l6lwV
         MGcCRvdLWSziqwyijhyak13r9GBAifopRX/8jZecH+cOmvEXxPowOPDavW3FfobCF1uw
         Ls/+h/RDaJyBtqsNcBK6VZ6p+375P2ya5nYXyekGw1KHD7PgcvMSDFPzby6jrW488RkD
         8iROyrDS41vw7HBgMWODznVvUz5/vwrB2bcGHPmKTFtWLUGwhmXj6zzPTgXv16KFFL4i
         O9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784151814; x=1784756614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XtgavnUQZV2QvtqzUdQVFLJ04q/RXp08/VIYqL3ZGIQ=;
        b=TOofAvnFWwSpykcmwwzZXg9Xie342dE/JlkAWuoPNUcOrRFs1AmrTyvAxTLI37SDHq
         cT1p5Itto7t1jO3EtdElj4xRYznZCgSyqmDeWjs0zjzRJ++V6bzWIc87R8MFZgs8siTN
         kqjX1hbW9uHGh4UKkQ+b0PN73RuwCSpwZrybP40jTjknF+sKCMAWrWvKMfiAKQhhXzGf
         a2bBvPTk5fOCJ8TqZw2yIQOsNPxmfCxLEJt7/NcvS/z4dxRl9WRCRb/rG779aa6TkuTo
         F4Pb22O2wD6cKaRHMtc651GN8o3sHXtkR9EDRqc8+O5Jk8iHOWalSuYO6G5RnyV0qS/L
         89OA==
X-Forwarded-Encrypted: i=1; AHgh+Rok7q8Q/iNqU1oLCwcuNuZZiWT4salPWYXm3/ebBhRID62oTGMnNPWdBTCy7rwWQwicw/OmfXY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzeT+noF6AffMytAtLtMoIsvXQLor0Rj5t7Ll9dBI/82j2TPN2V
	D1AS+5OngBQLWaiWSp01K6JUKxh7pMsuScPUveocu6uJNLY2NnjkqjQw2WV5WexO7U3SUxRIE3a
	dG3eCIEgSwlMPmQVEJ/m/n3b+mN/9o6Dvqw5fP7sh/ZPqzXEiMM+gWJ7kSPAfYcTKRGokZg9h
X-Gm-Gg: AfdE7cmEyc3U/UliKwDj9glzj6R33LphAFLK13/1tRRj+ypCYHJjAferSd9BYlnSvUJ
	zcVFJiPYRBe9oxKWB7t+B2174hOE+Iwppt64HCflUP4mn1mPDxHG8VXHD/Pw6ZXVc3gFRPJCykD
	LIvwcQMKx0pPI6JGz3Qji/j4AHdV580ZBD7DHOEQ/zSDyV45HgdWAhBMNi2SY76/c0XZ+ryXzhW
	wrHfphLuelXIuTIXthKGAYxADb3wXZtw4AFZoZ3G8lpy5nYmaNCjYm+yFkM5vYUCnWCM6/cXC0A
	wlShMeFv8yFRbzc41VEy8KMELZqm6Z7U6+3XUlMiLgKi+51+EBHIvDERZ7mQ7E+ik/v/JsiNI0F
	3QbdMsICuQenGRFqPG1wcd3CCkH6tEC+6O42I26vzCrP1yIDMVD0=
X-Received: by 2002:a05:622a:5c0b:b0:51c:7d0:7ed7 with SMTP id d75a77b69052e-51cbf24a901mr199687301cf.39.1784151814200;
        Wed, 15 Jul 2026 14:43:34 -0700 (PDT)
X-Received: by 2002:a05:622a:5c0b:b0:51c:7d0:7ed7 with SMTP id d75a77b69052e-51cbf24a901mr199687101cf.39.1784151813809;
        Wed, 15 Jul 2026 14:43:33 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541eb7372sm14200775e9.13.2026.07.15.14.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:43:32 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        beanhuo@micron.com, can.guo@oss.qualcomm.com
Subject: [PATCH 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
Date: Wed, 15 Jul 2026 23:39:15 +0200
Message-ID: <20260715214327.1933560-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715214327.1933560-1-jorge.ramirez@oss.qualcomm.com>
References: <20260715214327.1933560-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DPqi0-5fO3IMmrdAqm9dPloYyC3FpMHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDIxNyBTYWx0ZWRfX3zrfCAMdPnkx
 oLCmqkm3HqaCJ4fftWvVKzhXX2f0Qs+6jZLwn9FuCfOgKrzfMLpCcnbnMQAX7gZIO1FJ7iGmdDx
 8XW+nepY/NqTl1vIfxx6cUjxOPVaWStqd4b/xW8k6wTBd/QoXwKzZvg5oNdDXhhwhTRfWl2kyeo
 ZX4HHNdY/jFr5POtsgjvlOjMr7Tvq7xWkgaUXipB/cqwX7IBfusF1vO522PLZmWIvJtuaYaOqul
 fis/frnClrnEDsHMYNQ+TeS9PqqVcEzzHIDEv86QE2E3w5XKhNYOmc1bwSabo4wzPnYoOBnzU3d
 z+uCm7qf6RHUKEsam6jMQ+Vl1bQoYd3xPA/tnXvwpGl9xuveXkGIuqpipCLax6haiLZfd/oSI6F
 TRR0TX0WRMMkZx9WFD8ywRRfpnArFGIOk6ANobiW4FUcAUR1QywXMB686Hlsb+T3Z1PLyKGLP3I
 VfZWz77CNgEaaOx1q5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDIxNyBTYWx0ZWRfX1Y9FDFwjA1Nc
 QC3lZ+GFSydCfmNUQbCfnrvSNd2vwAgyA81G1s9Z6aqPcvdyxgOMjJXBIxVnJv+/a7ANHq4xnKG
 83CnChJxTnNfAj8je4Lr3g5KgENpUlM=
X-Authority-Analysis: v=2.4 cv=LbgMLDfi c=1 sm=1 tr=0 ts=6a57ff07 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=w0io_FmA1e-6CLxyNa8A:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: DPqi0-5fO3IMmrdAqm9dPloYyC3FpMHh
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
X-Rspamd-Queue-Id: 6B88B44E87
X-Spamd-Bar: -
Message-ID-Hash: YD7Q4YTDHMRBVWUIPSHDUK4TDWFEST3U
X-Message-ID-Hash: YD7Q4YTDHMRBVWUIPSHDUK4TDWFEST3U
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YD7Q4YTDHMRBVWUIPSHDUK4TDWFEST3U/>
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
 drivers/ufs/core/ufs-rpmb.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index ffad049872b9..adbec80cf381 100644
--- a/drivers/ufs/core/ufs-rpmb.c
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -40,6 +40,25 @@ struct ufs_rpmb_dev {
 static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, void *buffer, size_t len, bool send)
 {
 	struct scsi_device *sdev = hba->ufs_rpmb_wlun;
+	struct scsi_sense_hdr sshdr;
+	/* Retry the power-on UNIT ATTENTION (ASC 0x29); the SCSI core does not. */
+	struct scsi_failure failure_defs[] = {
+		{
+			.sense = UNIT_ATTENTION,
+			.asc = SCMD_FAILURE_ASC_ANY,
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
+		.sshdr = &sshdr,
+		.failures = &failures,
+	};
 	u8 cdb[12] = { };
 
 	cdb[0] = send ? SECURITY_PROTOCOL_OUT : SECURITY_PROTOCOL_IN;
@@ -48,7 +67,8 @@ static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, void *buffer, size_t le
 	put_unaligned_be32(len, &cdb[6]);
 
 	return scsi_execute_cmd(sdev, cdb, send ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
-				buffer, len, /*timeout=*/30 * HZ, 0, NULL);
+				buffer, len, /*timeout=*/30 * HZ, /*retries=*/0,
+				&exec_args);
 }
 
 /* UFS RPMB route frames implementation */
-- 
2.54.0

