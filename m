Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B62CA5FB3
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:05:33 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id F1A67453C2
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790852733;
	bh=M2C1CF0+disfT8oQMkP7WKHBlsGzbjF2RKL9u49pDr0=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=snUlSC/2y1acnb4RPCiaCyIiItKLiSLSffb+bkGMlyDkRWVcGEH7jE7vCv+DANZ5e
	 1CG4s0gg82AJTMWTb5k0lUATx1wYYuy/PNc/47nRPsL1sppk6nASdDxw8RwgZTZj5l
	 v8qB8DB0ugyHFkS95MfiC7IVfm0KmnfTFkeNRaid6lwB7Qrva/p7fu2yK27+40faIX
	 3PQMB8v1dywve1WOS+ah7YTFxdGqKKQqGQscsltbo+YkEQaCwHON4SW3c5Z8MPQfCB
	 C6JBIs68uEVYrIURShXR8+kDgQErb20BHOKnT92mVTbimL+hYMkx5wc+D8Tb9fwkIz
	 0n7OYbt698MrQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8276E453C2
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 11:03:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O6lp05z5;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ru3bUINL;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xLuf1932307
	for <op-tee@lists.trustedfirmware.org>; Thu, 1 Oct 2026 11:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eGc+1XZasCjJJ34Ux+DA3you0KI4TDtPXI3qursqlJQ=; b=O6lp05z5w8IcUKkz
	LsXpM80vH4UKYt3XRX+EQsJF0sGYUyGRXK/aZ1hAxqGdN35fmAI5ZquL3bz+m7AO
	K5JUQef4ywYjYbA8Og/3h+MbE3hIqh+3Nx8PFaYukJ0RonJCrRXtceClFgxFaaAU
	BlukKCvmlpD/uJb95gOrfqEp448AVYUCd7yDgyiOaWBH+ec23OFmTwAJBc+fglFD
	2+xkStPltPLGsbHyXTCenpdlskMlkfW2js0qvx8iTsbs8Au6jidbgarBpQ1EPuow
	Gi3vXSHQ5OnUaKb5IPSTSLRgxWKjUstHsDcbg9YM3SQaNpEDrP0ilathehEUVanG
	Fb/AEA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5akyh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 11:03:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398dcfabbf8so14461296a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790852596; x=1791457396; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGc+1XZasCjJJ34Ux+DA3you0KI4TDtPXI3qursqlJQ=;
        b=Ru3bUINL/CedTA43NlipQxbxPGx7PPr/EWue7aGoMUYgVsfC6MyoKODozJYz+n3wp+
         Uck3dB2TU+dT86TQAfyA88N0CQRcgl9ZA7D9K9JwxLGUEp20j9r5c0uGBdmHRzsU45lz
         FbkOgn3T9jz5U0Bxm2m7TZymKQMwuyV7tfsFcJkxq0vnZ04HAaxRSseLSnGkWZHvQlWa
         YDjyF+cKZPZF7UJZEeCmjJ/ZZIDo0c4U1kVtJlagsq1mRJwZyNjxyj0FPjasq+XPZj2k
         kcDsf5uQyccxmqCmuyHdUb081o9x8q/M2w9E2/MdC9MSwdMfsd3e/z28XnuXAYUqNzg+
         Q/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852596; x=1791457396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGc+1XZasCjJJ34Ux+DA3you0KI4TDtPXI3qursqlJQ=;
        b=vvSMxEodl9rbLOQ9Da4YATr6bADFqC3X37v0RRpl5t1fGiKdJI2vns1y3xQQdG0qGA
         5Y+mRfjax5b52Mj3o35sCVvCg2gRHcnMykK942ukUpamOsnyQyMBhVgKB2RbDeXp2RDt
         utic6nE+FLcHLWEcJDfkouy6vLCnrpCtkR/00bAwwPsz0YxhhS2aBQgGSyc20RpqiWJ8
         fjbsgG+sp9SUaRGRol85nbNO/lcq8e9HTx8+yy2jhjbWU+6tTTA3d298tyfVCFnJOIOk
         Vzrymzy+PmkwbUm61tL2eIdkheNsGvlQu9AAJITcOfHiOXuGddJa1AZp84cuDjz2o3zD
         1/jg==
X-Forwarded-Encrypted: i=1; AKwUvBxmdswknKp692qWAUbgALzjQU2jMZtvbpH7nLOSEbCKKCr7e6ut+nakIKLuFbdf1UERxSQ6lz4=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJqQE7SL1FqO9pYm3dnC+aG9Q0FvK2lPELkOq2EnYsSYuFpckz5
	nKbknC+PUKgjIiXhoGBIx56caGQZkWtLtOvRFsa4k9KVquzM2xzlnI/U3mO3bV+gRboo02tMsmc
	pCiMeIGrn4g7slG0XaS4AMK78oZpbad3nmMsMOxqk/wXoiogxZSAtMfXRFL0vL4SSSybHvG/0
X-Gm-Gg: AYBFou0bV/4MQ4Nga3IbT3oSvdFuGsHAPQqMOpeYBskc/zTau7fSS1yU5hAHXCvlzJE
	fnm/SIKtTaCCPTiFmCOskV9AgoFzgXGH7PXJlOHp7JvE0mdzhInNwPmPMY0hRXuxTivewEvjBR8
	tvBMZy0IA1oagfMnEwiAfpJU7VB9QPOzXVtk0wXF9DOx6HYRRRtF4HIZWHF9lgszRmZbJ605yRI
	ZHHQ2wVwXJsbrNGWPS9+YU2ol8KNq+dhDFe1VVqhEPBpJPKAb2tOrKxbCpJr0F/vSyPJjU+d8+q
	DR/qJ7Lgww8tz1icDnQ+hvYdwJazV9hBifDWrgYkPxiYsLaq56kGCa7a8sG+FxZrzEksP/n8JFU
	HkrEwuSYaGmHKYbidDBWeqnsu6Q==
X-Received: by 2002:a17:90b:3ec2:b0:39e:6a82:afda with SMTP id 98e67ed59e1d1-3a4d18c4d6cmr3773167a91.44.1790852595806;
        Thu, 01 Oct 2026 04:03:15 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec2:b0:39e:6a82:afda with SMTP id 98e67ed59e1d1-3a4d18c4d6cmr3773132a91.44.1790852595245;
        Thu, 01 Oct 2026 04:03:15 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4371383sm4076810a91.2.2026.10.01.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:03:14 -0700 (PDT)
Date: Thu, 01 Oct 2026 16:32:35 +0530
Subject: [PATCH v3 3/6] tee: qcomtee: Allow object invokes from kernel
 clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-3-13df5c20c2e3@oss.qualcomm.com>
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852574; l=6515;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=w6GlevsecVkTd9o5VILCSzOwYDJJ6mD69ARARU8J8LY=;
 b=5Q6KzNKCEBMgcaTCdI1uKIZlLpsNN4r9ptX5GcrbC7riQ7bC5CkPnDy2YJMtBURZhvKIKxZcf
 Z5r7FY4GX4ICDYzMPX+ZmGIKt4k5ulkAaoWTGZ/oY8XOYWtlKHFbn3G
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: 6Tjk_48I1b6A4m9Eik1rCbfmwBTfvYvg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfXy/UNMvctTbcN
 MiJUi15OD/ERgsig+NmHnxJzrLynAGe9iAHkHLSDkzMj56dJDZ+ADUr1IvDK6Id+L/sx4AP9c18
 qjOiWAboQ223pz/23DComgJZMabQQdE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX12PV2MC7nOyK
 MispvOdCJrfwcTUp5XdPUceDXUAmjfMKaCsbjDFCdgzXW3pXiCiZ8hnLomOm2pK04dfrzsjNrx7
 JpkiEZHBDlpPaaMVyUofWnq1E3a78hZxVhQuDrorX5JLj63JTWUWV3L53xFAM9uU+2gjEuEkYus
 YH4dvcsW+OIoJqRx+4w7A2maK9fcUyVvUYfu0xuGFRLLMK4OjtPZ/ulcLL8dmcNqN9/16b+XP9U
 ZOyFML5DVGrBkqmUhKjiAm5lLANw95hii8LeCdWJbHUgXZ2VcOSdSRr8dHrBS6i4ex7yx9yZwMK
 NI3AlodvPhnvEn0DsGtqcqFtYJ5LYAB6ZbihKnqyEOhus0HMB6ZBpYXJ6YV+wI9cTn5laSbL/AP
 eRI0q6jQjAwKvUmYEiF1/4fDB1aldzZFgscmhSzfj/kV7ryPczx14vIxzhfnZg3TREUCh3cd+rq
 aYmP6YEOmbkpWTfx4Eg==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe3dfb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=XyePUiwmHbEyLJ1dZiEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 6Tjk_48I1b6A4m9Eik1rCbfmwBTfvYvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.70:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8276E453C2
X-Spamd-Bar: ------
Message-ID-Hash: CVBWPIVI6P37RIJQIO7UU6MER7JIEREN
X-Message-ID-Hash: CVBWPIVI6P37RIJQIO7UU6MER7JIEREN
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CVBWPIVI6P37RIJQIO7UU6MER7JIEREN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

QCOMTEE currently treats UBUF parameters as userspace addresses and
applies userspace restrictions when invoking the root object. This is
not suitable for object invocation requests issued by kernel clients.

Use the kernel_ctx flag to distinguish kernel client requests from
userspace requests. For kernel contexts, do not mark UBUF parameters as
user addresses, and allow permitted root-object operations to proceed
without applying the userspace-only checks.

This allows in-kernel users of tee_client_object_invoke_func() to issue
object invocation requests through the qcomtee backend.

Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 34 +++++++++++++++++++++++-----------
 drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
 include/linux/tee_drv.h              |  5 ++++-
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index a0f2992c0611..b361d9c04de0 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
  */
 static int qcomtee_params_to_args(struct qcomtee_arg *u,
 				  struct tee_param *params, int num_params,
-				  struct tee_context *ctx)
+				  struct qcomtee_object_invoke_ctx *oic)
 {
 	int i;
 
@@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 		switch (params[i].attr) {
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
-			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
-			u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			if (oic->kernel_ctx) {
+				u[i].flags = 0;
+				u[i].b.addr = params[i].u.ubuf.addr;
+			} else {
+				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
+				u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			}
+
 			u[i].b.size = params[i].u.ubuf.size;
 
 			if (params[i].attr ==
@@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
 			u[i].type = QCOMTEE_ARG_TYPE_IO;
-			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
+			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
 				goto out_failed;
 
 			break;
@@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
  */
 static int qcomtee_params_from_args(struct tee_param *params,
 				    struct qcomtee_arg *u, int num_params,
-				    struct tee_context *ctx)
+				    struct qcomtee_object_invoke_ctx *oic)
 {
 	int i, np;
 
@@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
 			break;
 		case QCOMTEE_ARG_TYPE_OO:
 			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
-			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
+			if (qcomtee_objref_from_arg(&params[np], &u[np],
+						    oic->ctx))
 				goto out_failed;
 
 			break;
@@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
 	/* Undo qcomtee_objref_from_arg(). */
 	for (i = 0; i < np; i++) {
 		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
-			qcomtee_context_del_qtee_object(&params[i], ctx);
+			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
 	}
 
 	/* Release any IO and OO objects not processed. */
@@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
 }
 
 /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
-static int qcomtee_root_object_check(u32 op, struct tee_param *params,
+static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
+				     u32 op, struct tee_param *params,
 				     int num_params)
 {
 	/* Some privileged operations recognized by QTEE. */
@@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
 	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
 		return -EINVAL;
 
+	if (oic->kernel_ctx)
+		return 0;
+
 	/*
 	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
 	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
@@ -429,7 +440,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 	/* Get an object to invoke. */
 	if (arg->id == TEE_OBJREF_NULL) {
 		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
-		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
+		if (qcomtee_root_object_check(oic, arg->op, params,
+					      arg->num_params))
 			return -EINVAL;
 
 		object = ROOT_QCOMTEE_OBJECT;
@@ -437,7 +449,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 		return -EINVAL;
 	}
 
-	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
+	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
 	if (ret)
 		goto out;
 
@@ -455,7 +467,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	if (!result) {
 		/* Assume service is UNAVAIL if unable to process the result. */
-		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
+		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
 			result = QCOMTEE_MSG_ERROR_UNAVAIL;
 	} else {
 		/*
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 5f40617361fc..d3740099fae0 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -113,8 +113,9 @@ struct qcomtee_buffer {
  * @b: address and size if the type of argument is a buffer.
  * @o: object instance if the type of argument is an object.
  *
- * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
- * states that &qcomtee_arg.b contains a userspace address in uaddr.
++ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
++ * that &qcomtee_arg.b contains a userspace address in uaddr.
++ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
  */
 struct qcomtee_arg {
 	enum qcomtee_arg_type type;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 369c87ad0205..367208210a32 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -83,7 +83,10 @@ struct tee_param_memref {
 };
 
 struct tee_param_ubuf {
-	void __user *uaddr;
+	union {
+		void *addr;
+		void __user *uaddr;
+	};
 	size_t size;
 };
 

-- 
2.34.1

