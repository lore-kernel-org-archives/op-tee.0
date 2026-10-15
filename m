Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EC3CC6B2F
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 06:39:08 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6837B452B4
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 06:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792046347;
	bh=Gjfl70hTFTGhBH/H4P2RMB0T59SFjyozJ0eYGyE+ryI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QEhXZ+5y4P+BawSZXZoLrZ/HsPZKjaDnPTiP0eua7H31exfI66Mp33qvrd33vkZtE
	 1p/7reScQbIt/0hY8VnN8dwrXOP5wDW7PV0nyvDztAd+6YCZri58koT5bIDqn/y4pn
	 VgEOEHyIfoGyPg/bHyz2pmU0KBD4u0xV8SzGmJ/k7oMJmNAqnmaAIlUDTMY2eiAMRY
	 CMDjrjt8T88inqIuYDyXrVBxrLs0A9ii0w59BiGiIGByVPU/KhBB3M++lSqpOBJdTq
	 znBqUdblQjUkYXsqyboAkIY6nBQnOEPjOPeF8ZjMNnbd0hIuQXsG/TcZjTCgsag5n7
	 4/P1uOoV1Q5Yw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 957564530B
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mQU9w7jh;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UM6FSApM;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ENJaU4500328
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sxi1dDHyen15wUUP13toiSG1kq/ZXdnSJUls7x1z7Xg=; b=mQU9w7jhNCYxUiRa
	Chnig8d2fNEr6JuYe5/wCpaX5gozpghSN3M5FhZgLiqVC3Vz/cvv9ddODfv+MSwJ
	XQDkfK4eISSr5TNN854A0WAIP9pBRcZO3S4Ey2I5of+7CvasYNL7YLclkGLolSFR
	WEOcHCJ0HbKTycbk2wHjSdXvOlv5R+dptw42riOI9ZGTiWOWG30IXXHn1bK/jvoA
	sJUAZca0v8aL4BAOTu2IzK1QjJXkZv8ta8/jAWscdffaTjOugf+23OXMgH2M69gP
	g7/wlqDGTQR7Kfd+XrN9cNxH6p2GET2uaGIgzqKbsn39OmpI5SA/Sqh0Z8OhjNd8
	uYHzMA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf3k8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 06:38:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab341816f6so4918079a91.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 14 Oct 2026 23:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792046302; x=1792651102; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sxi1dDHyen15wUUP13toiSG1kq/ZXdnSJUls7x1z7Xg=;
        b=UM6FSApMVeRQPItArmS0JslX26ONwLHZjb3if0xJdoyAGC63D+I9FBHDlZ39tv2+rm
         xAS7DVeHHxdG2T5q3xbTFMTjqMXX5EjgWA8IuVUt7JI3QKpTFvo8FpW+PQwn697kFfRi
         DZ9Kb40pJ/ftHfOE75viuKcZlGEW2Pgs5fNF7b16HGyyqFEw/21zS85LvmY3b3r8OZfZ
         uoFkDi1w/jax/lrga+tRTVAVC0D4QK3YoheUyUb3OPraOBq1UwjVLbyJ2Wqt751aUdHY
         DOH05MUtG1G0ZCdM75I3Zx9/WZu0FUpt8IVEaaPOCSW/mt6pbmqtPcKZ1rQj+ieGIepS
         NzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046302; x=1792651102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sxi1dDHyen15wUUP13toiSG1kq/ZXdnSJUls7x1z7Xg=;
        b=UtyqpwvvbBltmEivDw+HGdO5hOaT0hoHFDdP6vPZCTQ64fiQLOHOHZdwSACOKMVApP
         j8vvYMzjrS8Ma1YaBZBE49RJfjC3FNW3ShpDoDE2oqKqDS9XGPOAahCij0U0onJnoyEs
         07RmKPTunr/gLCUeMBeBcVcf0aUxBp4BXPNUFO8L5zK275HX+j7J5R0h+NKYCliWsU3W
         bwRhhNzFDfQhrR96qjxDkY1V+/O3BG/+Ltub0TG/aeb+FvFReK2liwMgKh1+mUBn/NDf
         +jCnuYDN9JMTKvgXLKqKmxU6/4n5t9PfufKVdz+1sBtOQ6QMwF+vgrgYth3GjRzNuX27
         oAdg==
X-Forwarded-Encrypted: i=1; AKwUvBzdHhoXm2N0suQDi4zKKVxxLiEwg6dlUFkR4LuKzEKj+mKq1deLgvQl9xFwH15Z+LYakmNi+dw=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYI7f3heclwPqEvs8sDfVD+elV2wyobtwjmeWc52Hy2U3X3coJFl
	mh7c/p5iGJM8D45zblibWWhB6OOHo62MUme7pSstxyXpZXAJKIMqhs8XQ0zf6/HMZ9eoqlAbxdu
	oWLS5icpD9F4Q+li+qIFg1uj0ktu16dmOurftmO4PF6JSWYc5LR98UzAZPMFgOCijDI86EEtBfQ
	Mahutg
X-Gm-Gg: AYBFou3hn9uNqpCizMzn0CP0dXVRSNtmaRx5xHB68IcbLC1uuH4Df9SzxejNKDsFYS3
	QhDW67bF/Z0wtDnqRaQI13SIx2AKBfgkrM03Orrpt6Nkk+RXGQuRgm/x2OacUTXCngbI6JZ3Dtv
	hQEeJM1RCDwm19X0mKs6S3K8Yv3ipKZtVUf7XGwWR/8r1bwojKZhjec0lDFNKhk8JB1k6misJ7l
	VDV44YCCI79AUPzSV7lVvvGQxjUIFw+XXdJ493nSXjvrGQQZBfYzH4NkXV5fCp6471RrqzbOjZ8
	wwm3xCu/zMyOG2OI4FSAuIYb0UDQ6OCADgfdkCgeKUhJRgb/LKptL/tI3u0ozTAuLaj3pHArorG
	NFR1wOwy/HBi6WZ4mYqxZD0qrTXmcpyfS
X-Received: by 2002:a17:90b:570e:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3ab3a90e564mr12340065a91.18.1792046301510;
        Wed, 14 Oct 2026 23:38:21 -0700 (PDT)
X-Received: by 2002:a17:90b:570e:b0:3a8:1a1a:7895 with SMTP id 98e67ed59e1d1-3ab3a90e564mr12340050a91.18.1792046301053;
        Wed, 14 Oct 2026 23:38:21 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac93ff4474sm2844429a91.0.2026.10.14.23.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:38:20 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:07:46 +0530
Subject: [PATCH v3 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tpm_qcom_driver-v3-1-247c8e50250e@qti.qualcomm.com>
References: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
In-Reply-To: <20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX4bxyq7IanDz8
 wpAGF/UKb1BV9a3dtYYuPe5nqSPTdsON4zGFSMnXedhUlsE+CQmS4OXbRpUrRWtElmXEu78ZTg1
 e+bVhL222YYVXnJM5YyD1rIqJN4lixAd52mdRP8uAoTlGjfpVCRVqG+e3iV2/ZVOcpFxM1ryIRQ
 0d9p+gHi/Ze+wYoVTlUxEuv6yqOPcevT2QuAtpSZ2I9ouCVIT3z62ketpit2I97lomuD5oVaMvY
 ZEyXf8kFXPbiEV1/Yya2W5E4VOrJVwtThZ9HfVM2KQCtmCbGpyNpZEX99ClRVqJIOUq3NCgJs8C
 6Rs/Y6vzjztFqwmN4uGlQQd20zk/9WEARegD8bjgQSW/Ga+0iAx9v7+ZqTkWc5orM74Wv3Tf4aw
 WoLYjg7CGjZxKZYafjqP9e7McxszFiru4Jc3OoC1UIG4nZbz2vUiYBsI4a+DTa/BSFr/Wp93DXA
 okHitPTuaIOitNbn+YQ==
X-Proofpoint-GUID: K5Y9mlyoXU2nY9FSNj0KDP03NVGFFCnc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAyNiBTYWx0ZWRfX+aVrePnnFlQD
 CSKowcDB7a7/PUW44gHOhSh+0X1Mp+QoGsyWmlpeMPlqvYTvreC1k0WEUA5UoDteK+qDaNe/Duy
 jx9hsht1xroU8+jtq4vnqC5jFVSwfzA=
X-Proofpoint-ORIG-GUID: K5Y9mlyoXU2nY9FSNj0KDP03NVGFFCnc
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad074de cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150026
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 957564530B
X-Spamd-Bar: ------
Message-ID-Hash: G54JTR325HH47XX5CGAUPUF4DFSRPBXY
X-Message-ID-Hash: G54JTR325HH47XX5CGAUPUF4DFSRPBXY
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G54JTR325HH47XX5CGAUPUF4DFSRPBXY/>
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c        | 4 +++-
 drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 3061bcbd15ab..d4d6f72eb71b 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -747,7 +747,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
 
 static const struct qtee_service qtee_services[] = {
 	{ "qcom.tz.uefisecapp",
-	   QCOMTEE_UEFI_SEC_UID }
+	   QCOMTEE_UEFI_SEC_UID },
+	{ "qcom.tz.tpm",
+	   QCOMTEE_TPM_UID }
 };
 
 static void qtee_release_service(struct device *dev)
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index 9278a361dc70..9fff9dc5fffb 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -106,6 +106,8 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
 #define QCOMTEE_UEFI_SEC_UID            413
+#define QCOMTEE_TPM_UID			81
+
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */

-- 
2.34.1

