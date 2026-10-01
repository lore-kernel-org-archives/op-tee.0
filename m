Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C951CA5FCB
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:05:03 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A0A0F45508
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790852702;
	bh=8J6mVwucr3YpUU1SbpeFpncvz94Oynf7QjRheGK7mDI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GdqrNA36e74aezjlEDshXSi/b+r/tFcpSLFqWCnoDw9e2ml4F3D/67nAT1uCy64PD
	 sn7OzonFNQfDpfCcT0Q+j+PGoKB2Nq/nb/peIjL5KGrwNwrKAX0s7YJ/cKOM7F7p7y
	 IItXA18wVF+MIUwsaC/dMSI7MrrRIuKIq/Jym/RM2UYxwHR2XzsfDQvb9HCfO76pVw
	 E24hBdQYTJ2pIGVfVG+9bEZjXSr54KBIWk5igeybFPKMrMHGx2CfhpsCsmtKSuYtxh
	 7Dhn6cUj3N6hZWvxARGjjZlNrZumSPmBig/PsRUiKbqJS61fYJMAS0rEsmU+THBlCy
	 px7IlfbOacYGA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9A211453C2
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 11:03:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L7NBUm5K;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J5T0Sc/L;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xkV0396164
	for <op-tee@lists.trustedfirmware.org>; Thu, 1 Oct 2026 11:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zTcg7huVH1+fhu8zKoiibUAUrz8ad4Hg5rZk58E3qB8=; b=L7NBUm5KmnxDR8PJ
	JBGu8ewhN2UqnFyAa7ATEXHj16gaHk/UJBTHsjnJ/uUVjb2zzSV9l++T0dFNpJOU
	ePFVcg9TpBgZ0BJQHpwz0WmDGntUQHrm4N9nBGgAezrGqeGLW7uAxfLv888lm2sK
	LSM0UwMM+HcJfC7sDO08o72n8mYT7/tOkXK+PhtVxjRJOszU9eXnfZHjW1wQ8b+e
	S0nmb6xZ5WPjBpu2LluSND1BquXhCrfLfCNFqa4KJmuP5xxrPsR6cq6ptJ89CtNJ
	zz41PCj67hnw+mAPiIFfzN3Y9C/PBVBTVnTOe/SEcd6/3+xW4DuUeH+TtU83pA+K
	PaljzQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5aken-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 11:03:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398dc3d8f0fso658450a91.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790852601; x=1791457401; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zTcg7huVH1+fhu8zKoiibUAUrz8ad4Hg5rZk58E3qB8=;
        b=J5T0Sc/L2wiQjn6blDpL4gHerNDw3rqCBuSxBFWVEXrVf1OGNXJemgeTwnLFQ+P5AY
         NgcOb8e+nYaNZPsl9ZDW31ZdPlrTjBzhd3YBRZNGyYvVqiIxd4hQkDjpNYvD9vipxyGY
         L8Ss3CfqjDHCyMoo8g07lhg7W4z66nxEeQcSBc5YVKGmGRdyrLGsN9bbVPoO/MyJvKBX
         JFzwnmq8YIftP/21mOeuU7+P/JKvwyyLuY78lV52dfvCyPlP+/CMM31gN/pv8yOWyWTF
         /d5DeUR5x92q6rct2Fmdzrv/cQcTg3L/WBcuTc766tkZMYnGf3u5XKVEZo2TSHYEsmY4
         6VSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852601; x=1791457401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zTcg7huVH1+fhu8zKoiibUAUrz8ad4Hg5rZk58E3qB8=;
        b=owO3dlX8QIzw7Y4LuOTxBU9cuKcxUv8O/7sey/EFhnedY0H1UyXfAuGfQa3JO6QQuG
         Omz/5E8we+6c6IO/ztlg6oljmORqK/KrnEGljwuqEYjpS1agIBAy6qlkrMHyG8U0I3FV
         QxAkNLGK2Bw0XtYs/v7zs+PYbk7lcnqjyHCH1SnpXp9wFMJjbvKc6pQmfASz668kfUM8
         CfuHBhonNuqFLKJuzefWjxFpWvKMq5ZHMhBBpqsw4GqvVIfsGDnGS8gI1vUweWFXXXiq
         kirBsRk1SgINpMEW2UmT2Y39FVNRjLMkXYPSUrkyTKnsv8d6nTdsUe2ipgA5hePCOt1B
         KvvQ==
X-Forwarded-Encrypted: i=1; AKwUvByADpJRL6xuIHd2ClZt9x8IgSsIU+zDVOtLlb05IRBOSSeBiKOv/Cc2LvzSAtmeX+Ph6nterqg=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYICJlCIZxXD8a6rsNcQBN/EAm7MZjQ7K8mKC0iC4J6vOqp8AII/
	gNx9hvI77C10SYQqK/vK5YCMWrPCHkmmzSL+notfig+5TOsFiCnuWUHC8YPVodkF67jZhPOrBJQ
	QbpFA0+kxilGo7f0GU0DWDCEJBOlOpCcd6TeeaWYted5/bQpoP0LSNbPIZ0M2r0ygoaBEQaDi
X-Gm-Gg: AYBFou32ILYggc+aiLa8NEd3euETXs9l/XGET4Dex0Jb+SbFINDZEw83hr5Bpeqa63S
	/vrLZZEosMYaLtljleZWPLEMQTK9XnSjd6YrldrgRNj2E7788NHzKeXzlT2cxkhpC77smHC8mPw
	7TJ3QquMQ4bh0GnI4xODgZp4mw1cH6fny88n76LZrlFXGXSZHiT8A0qFaJqOvthjid6KUarEceX
	w/JCNQyS/82CgwIrzhN3gkZbpel/AGb3GcTxZSZIW0ad/ldiWbOyssS07LqpAQo8QDw6IDXCSkQ
	TywncwjDyNJPCMgLmQ0DyWBQgOI+uacIdVCqqAGsgoUlFJFlYX2JVVBEY4/Q82n9C0FJePY6oVA
	ZacJHTdVNLgHGVNbeUFNgkC7Kdg==
X-Received: by 2002:a17:90a:fc50:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a4f32b4c7bmr1262660a91.38.1790852600905;
        Thu, 01 Oct 2026 04:03:20 -0700 (PDT)
X-Received: by 2002:a17:90a:fc50:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3a4f32b4c7bmr1262626a91.38.1790852600087;
        Thu, 01 Oct 2026 04:03:20 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4371383sm4076810a91.2.2026.10.01.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:03:19 -0700 (PDT)
Date: Thu, 01 Oct 2026 16:32:36 +0530
Subject: [PATCH v3 4/6] tee: Export uuidv5 generation for TEE backends
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-4-13df5c20c2e3@oss.qualcomm.com>
References: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
In-Reply-To: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852574; l=2841;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=8J6mVwucr3YpUU1SbpeFpncvz94Oynf7QjRheGK7mDI=;
 b=ROdYUAbJD1wJSJyZmFU9DL5SMEUA/+HlaGN+bEc9GIWcfX6VpQDEk7sOs6Y2pijlQOiG/5F2q
 dpQvkf+vg6UCynX3Wnobq0FQVw36LVbb+Kk0eSuXy3lrA0QOte44C75
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX0qmXAdVaAUmg
 qsea5AJ6VejCevAtFBs9MIlDgEwi54g1S7vYGUlo4vYoMmYxsRghrm0i0SjlU/SSP1svSeJ3h/0
 ALr3X5BeeTgJdUMuSgX+sbzd4hCtiZaa5YJVAf972lw5EJXISgRh+DcWPEmWCZSkkR7Pg/+R1CD
 CZpMonB1bGdeE11Dq/RMk0Gc6phY621l5uN1llw5XKfZwdBPcu9Wn5NnrwghRcu7b7RCg2dfdfn
 5XwFIQHXqRUECkOADrXWIEKvA2Tb57ZQIfHC1jVAjSvsCsANcwJ24TlIkl+LDTNdSYUZuo6XlW2
 +UduiQwjbvl+MkL259NxZqmXNXACMkoRQ9iiUBoQQgCrelKE36sI97NEUXJGI0mB6G3ggSY+iye
 QWrkH23jO1DeqBN6VRW2vdviij8BndPSDAw411EFQcgtLI+oO6gQJw4wjtAAFUkf4p35ONj1MaK
 jajX+flCGkzWTJYwzFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX+qTSngypykKI
 gZ4Rttr/LVPu4+qkKS9qD8gIKo7wj1snYJsTkxUeNo+GlAjUjPkpKdIpbt2MoO/xGojWLFWvKU/
 C1qH+UaUhj4kovlcIAdqGXbaK26z7z8=
X-Proofpoint-ORIG-GUID: DwlEkj_Y4nG2E6V60FK-sPQsA3DKJQcO
X-Proofpoint-GUID: DwlEkj_Y4nG2E6V60FK-sPQsA3DKJQcO
X-Authority-Analysis: v=2.4 cv=NrJE4MdJ c=1 sm=1 tr=0 ts=6abe3dfa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_y_UpZ8dDEjReVSEE2UA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.216.69:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9A211453C2
X-Spamd-Bar: ------
Message-ID-Hash: BTPCB643KWPNK36WJG27SVVAFZZGMXZE
X-Message-ID-Hash: BTPCB643KWPNK36WJG27SVVAFZZGMXZE
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BTPCB643KWPNK36WJG27SVVAFZZGMXZE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Export the uuidv5() function defined in the TEE core to all TEE backends.
This enables the TEE backend drivers to generate a UUID for identifying
and registering their secure services on the TEE bus.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   |  9 +++++----
 include/linux/tee_core.h | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a03a3d645dd1..2cfd302d1393 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -135,7 +135,7 @@ static int tee_release(struct inode *inode, struct file *filp)
 }
 
 /**
- * uuid_v5() - Calculate UUIDv5
+ * tee_generate_uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
  * @ns: Name space ID for UUIDv5 function
  * @name: Name for UUIDv5 function
@@ -146,8 +146,8 @@ static int tee_release(struct inode *inode, struct file *filp)
  * This implements section (for SHA-1):
  * 4.3.  Algorithm for Creating a Name-Based UUID
  */
-static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
-		    size_t size)
+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+			  size_t size)
 {
 	unsigned char hash[SHA1_DIGEST_SIZE];
 	struct sha1_ctx ctx;
@@ -163,6 +163,7 @@ static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
 	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
 	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
 }
+EXPORT_SYMBOL_GPL(tee_generate_uuid_v5);
 
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
@@ -228,7 +229,7 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 		goto out_free_name;
 	}
 
-	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	tee_generate_uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
 out_free_name:
 	kfree(name);
 
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index bcb5418d6fdc..a3f4f88b8423 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -272,6 +272,21 @@ void tee_device_set_dev_groups(struct tee_device *teedev,
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
 
+/**
+ * tee_generate_uuid_v5() - Calculate UUIDv5
+ * @uuid: Resulting UUID
+ * @ns: Name space ID for UUIDv5 function
+ * @name: Name for UUIDv5 function
+ * @size: Size of name
+ *
+ * UUIDv5 is specific in RFC 4122.
+ *
+ * This implements section (for SHA-1):
+ * 4.3.  Algorithm for Creating a Name-Based UUID
+ */
+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+			  size_t size);
+
 /**
  * struct tee_shm_pool - shared memory pool
  * @ops:		operations

-- 
2.34.1

