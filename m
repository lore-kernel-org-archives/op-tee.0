Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD2C61DD3
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 09:43:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1816545398
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788169439;
	bh=ds5EeuA+CTb0BPfIbXKAJvl2PTFGAC/Z73CJ6Krns8A=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=S44u9nZ5hqV43ODUNKgpalFzd8+TUKLcBF20ONt0U4wA9Ce1xzdSgtuJs4Q0YoYD5
	 X29tY3+m10auT+fR9shif/39JuZZm3ixqn3V+1ce/eJ8a3K+Iys1RlHDs69JmBvfm8
	 BFCLnDg3ZCvvzRqt/4llCkRd0+JvFx+TesOaVvDAjNl5Wk9NoUP7PodrlzASZdH0IE
	 5ZqUE9VJeyouI4et9DcIrH0AG3h957xQLsPMROwcqHnqHvLFwSMHBGFCbEOeB8xAPr
	 HslgBiXP5w+kb+LzIOWlZeKa9oG9FXz6KeunBPKexRCK178Ke6g3Wd8729ch/Wi0/t
	 LDj03yAMr8Pwg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 11A5344FF4
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 09:43:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UoGZKsyS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N2GzeC0I;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xHR44081405
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 09:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/yFEAg71NUKByt/pUVT5zmDN6HUPvw1ZY6tWiIuwibA=; b=UoGZKsySMbVNLdum
	V6PYvVRh13yxz5Wly+/Fw7rvsESURf0ZjbA02xJFVC3zvmJpHMzNPAF3NHP/fdb3
	PdI7sP9/aIv8eEifvrG0oQthe6I3yeCWPQSa4INnG/ZkML1xIVPBLWcrApJKKMyN
	ffrJ+g9+g0W9uTJ4j3XhfTwk3VZF09Ydlwaq98tMypVh47svmgg/9gOtcMWl4CwK
	rzqjRdOBvD8R8abmp3aMyauA9bbVUl/yPqzPYPVkMxI9TpEJEgjXT2z7iw3dgXq4
	zZaByDVpPusLrQpI4p9T9e6ZIFTpNLcWee40dT+bxVFNEiYXlrzSKeKIgdQ7fhkU
	o+AQ/A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gcv8h219q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 09:43:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dbf293831so1741375a91.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788169406; x=1788774206; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yFEAg71NUKByt/pUVT5zmDN6HUPvw1ZY6tWiIuwibA=;
        b=N2GzeC0IapZ93Sr/wmts/Tsk1SjTDqy9iGM90q0G00MzWab0LXBnjnfkKLmwPAEyL6
         kMoEhKx0jY8vi7FTgqg2xS7cLYQOeZ0KXCVZ5wgxlVpQfRoV57rMgLdbm7KG06An9fZ/
         7S9rzImEFAUIhC+1MF7gVUaEbbhMHh2pbpQGN3medH8QCt6FL8sVRb5oNKhqx5Z33MOA
         1hER3BBZVP4V1mwFLgldz8jYNwQbH7q8jyXfOBmOngnTFsnKB8iTO44IirTPKHN+JoSZ
         O6hfGLonb4CCyE2BBKfdHH4Papky4cDUbI+XM8ObyYdz4z9GVbguY842fnsZKseFCwO0
         zXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788169406; x=1788774206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yFEAg71NUKByt/pUVT5zmDN6HUPvw1ZY6tWiIuwibA=;
        b=pSXWasYGTmXwmwyOCB7o5BB6DQicyrLDsLkkmnznvw1UfVkOYfZpYlZZRR+xFsk9ep
         W4aD3XdOlXb7bMHnKmLTgJsnGMTkB8A/BNs6IZqVV8165lqHmbmS+w2kok2O3szcUnF3
         otQwOCNeLaTAAMoklMnCDcm5aVDN5tNqO4nXJ1KHe7E5hGH79cpAghsfqTLXLhfXUGFf
         mwHo8PC8pRX3HiVGX4kBox+s4qTK3Jqi4NtjsJvW0Q4zI8BiHV0Mhy1rrl8blsGmbjz+
         1czccw/TK8pEwokxjXQTBJ7ybNFOrmKkF/lpYNw0fr7fg7l7s3KvU2B3EbrDwx3ttDQd
         oeBg==
X-Forwarded-Encrypted: i=1; AKwUvBwQEZ0VgQfKpLR9f6TmgZQ0FkcjGkyYR1TgWpzydQ9qLXqhIWogeyspD0FBQySlwFQcm+z0p30=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kizeV0DnwQsL3Z+2eF356BSb/0OlJk9APXPUdvpbPuhkptagKt
	o+BvMxpUL/Je9f2VY3vMRGn7tL7k5AY5rdP5ZO4Ktb/iMdFBGHLnZTt8xaPd9NRyYs3vAUb2+oc
	bSCnwsTuVPSfEzDpmZiVzxpUHoPgccHpHYllts8diJLN8BP4513QombD1E4fqmpLdhhi3d98OPv
	XmHX2P
X-Gm-Gg: AYBFou2ic71oj7CcMrx7H/sQhXwqO1M5cJgTLj0Ql5ellqQOa38GcV2ZNW8IBgZV+Gp
	2dwMVwZnLgd5eZIL/H41H8Kj5gdejX52ke7ZxYGw4ZCiKco9LQBMV6k9oAQCeuR8L9WB0pNuTC6
	6FDofezzG4nDZDTqBPpoZYn4nbNOUcUaf3Q/ZnBmpaZG0tvoTNVwMR/QdFD3XoVhBaRAmy6VhvR
	Xi0A/MJ2qFM8nJbAj10d7EgBC1/X7vdFR1vXmceX+k7gklhfx+v+A2zD0GbIkTvX0LP9mGfwniU
	yXthEO48TcRQAGu4yyspJR7QKtKoQ9r6syNj45Hsq9FK0AoZhFkbMBBCHl6yeLz0811RcVnefnV
	72JlYhLxSzIwwl7SgoNWqx3HgolFD2h5PQw==
X-Received: by 2002:a17:90b:1f86:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-396d0ff5bb9mr42028746a91.14.1788169406080;
        Mon, 31 Aug 2026 02:43:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1f86:b0:396:4cbf:45a2 with SMTP id 98e67ed59e1d1-396d0ff5bb9mr42028688a91.14.1788169405737;
        Mon, 31 Aug 2026 02:43:25 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0bf8a13sm40782983c88.0.2026.08.31.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:43:25 -0700 (PDT)
Date: Mon, 31 Aug 2026 15:13:00 +0530
Subject: [PATCH 1/2] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-tpm_qcom_driver-v1-1-6f16fa6924fa@oss.qualcomm.com>
References: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
In-Reply-To: <20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=DY0nbPtW c=1 sm=1 tr=0 ts=6a954cbe cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfXzon2ZC4d8EmI
 +56Zd5499iqo09CslOJEBehUTW39e0jZQl8RMZLWf8Hf7LqgTPBVToFDudNt7YmoKHExyH1hK8D
 M2MTzYDH9eBhnh2o1ns7Gv6OyEnVXIWiZK3ROWVZGEPfEb02u/EPQzgjjQe9+gz0tf1xE/G/ndo
 1D/AubgC4AIutcABHoC26I5OYBBoooNlSh685T8cLOzlQ4drNHOdIPgnEExsxm6rMMsOHGs7fFT
 oSQ0kkXZjDn3J6nYouhgGFCFvFrQNvxr0npbTIn2Zb2rECC8scoM1LC1/MCOMFbF0ubl0BoblrY
 DGXa/JsNZ47LiQ0m2+Gm6rHv++CptU46agD8qY/CzZwUNisXDtODlTl0/lIyA/ZidUoVD93XJ1+
 1/3ooDOeW06psgj04BeYweiKUzi4vS6+2t9TMHUG1A1oFrTta1rlMCyHQnsvzD/PvhVb4/2IomV
 sooCH9tZ9mw5GJovmuQ==
X-Proofpoint-ORIG-GUID: YhwuftQ9DsGyXUQRxxfSpJ3M9pdAeli8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA4MyBTYWx0ZWRfX80BQY1mzsD8T
 xA+gc3yHRO4dda9fZT462hAN65/6s2dfTODz1t2uCIqFdRh4fnxeQieBayztz9CfYaVOKnnnUY9
 TVRSCy3I3Rd9w9sN/edco6IgkggqFfA=
X-Proofpoint-GUID: YhwuftQ9DsGyXUQRxxfSpJ3M9pdAeli8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1011 priorityscore=1501 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 11A5344FF4
X-Spamd-Bar: ------
Message-ID-Hash: 2J6O4QLDL6OK7GQQGF4UYLZADK3U75EV
X-Message-ID-Hash: 2J6O4QLDL6OK7GQQGF4UYLZADK3U75EV
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2J6O4QLDL6OK7GQQGF4UYLZADK3U75EV/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
is enumerated as a TEE-bus device, allowing a client driver to bind to
it via its generated UUID.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c        | 4 +++-
 drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 4212572ff54b..aca4e8c6e37b 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -753,7 +753,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
 
 static const struct qtee_service qtee_services[] = {
 	{ "qcom.tz.uefisecapp",
-	   QCOMTEE_UEFI_SEC_UID }
+	   QCOMTEE_UEFI_SEC_UID },
+	{ "qcom.tz.tpm",
+	   QCOMTEE_TPM_UID }
 };
 
 static void qtee_release_service(struct device *dev)
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index ecaf8db67d45..888611b801c8 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -106,6 +106,8 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
 #define QCOMTEE_UEFI_SEC_UID            413
+#define QCOMTEE_TPM_UID			489
+
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */

-- 
2.34.1

