Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C5AC83F1D
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:52:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 75FA84FB3E
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454370;
	bh=yjYoGAD9MyX4aHdTmPfeHHWvzzmNNK3os0Di5d6Z2VQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=OAN7yZvvScTn7z33vvd2o4Qi7UR2n7lAUHe3Jd0ZNyr2CZPvMV1ttpwCzW8ApcQ7h
	 9H0SjHLV09xU4TX9HTSvGsvKq6Cij4vl0ZaHLlH3Wss5Fm/u1YO/H/MZE+gAVgh1C6
	 7U+nhQ2M08qpicOoWIWPwfTkPpAt+rJOrD6+n4KeA14wVgJsUhkRme1TubyPUqdYrZ
	 Z5/8DFKVdFsYnbg3SP5tZADLhHEuap4+mMh9NgE4WQy83QqgBf8B5z8eHAgLIqeDce
	 WWOvgHbH2CQu3dW2FcQkywZ86liQjc7lhRcs8QydTGmZgZ/nTsR1HtQAUJ1DRavWRE
	 EWty8fInkQdLw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0F4BF45A1C
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:24 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PJs0HsEt;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMxWnD031462
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ct2fCjbgJR4REN2qV7vOkpthMxmpDjsm7VxJohO9sZ0=; b=PJs0HsEtgFHbJ3/s
	1Gn9ZT1UzOQjj8RO7IiM20BHTgn/ySGtOPjNW8uGY5zAQGQEY6Pvldv32IoPHh2U
	Js+7k40jxZFRcVEs4KJvzTFBh/EUiOuxVyLS4wsgGZKsCtYrB5fopLoS3GcpNBEh
	soQpDKZEhBolnEXk43dD3JWrt4Nc42Tv3FEXzytBUHJ0FEr0XyIV6BDB9Aw72THk
	0Br4pVCqOQlczXE5jdySd/IpdFWuudp8995zBgJsGgpCX82CxFCAkzOgzVb/WAC3
	rV3f8vnPJM0SojOH7Oia9IQvy07dmwoYcRvf8X0IXi18kO3odQf4HdBlZasHjbfH
	Omx6iQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47uh0aasjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:24 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b2c37558eccso3248138a12.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454223; x=1753059023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct2fCjbgJR4REN2qV7vOkpthMxmpDjsm7VxJohO9sZ0=;
        b=tk7PppHTpjmpUkfOzWrpokR3cytbSvpNEeek1RSYwhMqQwRRj6QFJRmlqWUSE1eOgn
         i9ulmuHru3JxDza3Z2IbXCbh76HhYuO/zfMiqaKButycyDxflgNBX3srh3f8icsQDQ9I
         zwluHHbe0ZAOTe7MLhGIca/+Q31DglToGhTSmN5Ysw3SpDdaZaPk/dVF0f8OE7Z8Fghz
         Bw/qam72+q/M3cVoliNG0cY5k19UikKgSOivRYHKRDEjDvzswEcbvqcGL81y1wX/s6+b
         lZsVb6m/cz3eFxVYoDZWyl39+vOdvNFlszyxXs6+cDpW+gHYXUIgtznqu/+sPfPClO78
         wHbg==
X-Forwarded-Encrypted: i=1; AJvYcCVqHyO32az+xJi15NoW8OEKHfKBWb2+s4yvoa82K1CwFwpoI54cC7Z6tiZc6kmEOeVMSAplJ4g=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyMP/0VsnJhEnH6IuHUv4hPY14crAwB4vtM3o1vN9gy56ukJwAr
	7L3kbVPjjzmLPsRJ27VINldNy4i08vS+tf4JCxWoinBhU3Je+ttrixGFWQ38HWwVWXc+kQOAhyK
	Xq5xc7PONZpKyCTY5ona9LNGiTs8xh1+HpPM655yo/DunKaAt+So+MezugU3xM4BKhXhpGCc=
X-Gm-Gg: ASbGncufTakSVDAEJVao5WrniptAomA9dbD1k4CLmCMvlmOcOLR8KD85sbP6MesTdXG
	HtqiLIu6qez3oHRErRo1AYEhR72wOB/YVtkn1OyQAY/Z9bUot4UIIO6Kvwv2JCIZdEdLR65BjKC
	QxVkJ/muGZsaFF1NeACCE2jonQui9EXWpCqIPqUPsSOghAVUkxwXA+2nA9FkWx3suQZqK/whb7y
	zMa5u/dzWWcXbMpnd33boVNNqC6cAwmFgOunh9jZ4Oj2cJqNW9iFQiP2RzpAwtF25MRiXpeRWER
	WZoIvhtxQqmo9+cG1JnB73LyVTHqYYsYatwrar9h/7wtGjRh3TzSatEbpVy2KafCE3edb1SVvoM
	lzCfIO4VLcATr2DzxkzyUqPs=
X-Received: by 2002:a17:903:32cd:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23dede7d57cmr157639585ad.33.1752454223098;
        Sun, 13 Jul 2025 17:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRvCzZx5+d3JANtyF1yGNZHHvelXYTT1n9iuGKmxng2HkXNTyORmuj/a9u8CgR2vAWn3cpxg==
X-Received: by 2002:a17:903:32cd:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23dede7d57cmr157639265ad.33.1752454222644;
        Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:22 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:15 -0700
Subject: [PATCH v6 03/12] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-3-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX4Hv0fZuFffXH
 VcsdoM8uoJGmYIPi6rLq7Tdtzim1HSaiyQaEP4a/N4lWa1MXRezOzJ1p4pmusRnT2eyo3ww+KUY
 dYOLMauK2CfSgiZw26QyD1PLIG3zU6Sq/bCPb+ZNkfMqEaSRFh/ei9XV3h+hGhmK80HHQy99L78
 UXT/dNsHCVg/2ETMT4PyyM/2mKcxaCJkQCvtCXQipy+jhLN6uJ7yWo3ojYrvIpiwgdzYnLPAOIt
 x1TDvjpWTbq0cxGSJ36x+Nfshc/37GIcAzbAVhLrapawwLgvjUDvK1LmDsjCl3KnZ+WPlYHNa/s
 pl902okIWr6BVQ5l/d2oMz1PCJuuk4wyGxSjcs/rmLyEstiG6B0f3k4ejDhYNqvyOFX8QPg+9eN
 y8Ie0CP+kysJ3XsDUDoJjWk6AHckHD0dGPKbzNMBjVcH+ax6SKE7yEO94yTV4x0ox00gZVoe
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68745450 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 7Y7NMun2pNCMPpoqaHLw-wttmMEnLEmG
X-Proofpoint-GUID: 7Y7NMun2pNCMPpoqaHLw-wttmMEnLEmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0F4BF45A1C
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	RBL_SENDERSCORE_REPUT_9(-1.00)[205.220.168.131:from];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
Message-ID-Hash: XMWY7G2LBQV2JG3N56KMWTME3FLAX74W
X-Message-ID-Hash: XMWY7G2LBQV2JG3N56KMWTME3FLAX74W
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XMWY7G2LBQV2JG3N56KMWTME3FLAX74W/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

For drivers that can transfer data to the TEE without using shared
memory from client, it is necessary to receive the user address
directly, bypassing any processing by the TEE subsystem. Introduce
TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT/OUTPUT/INOUT to represent
userspace buffers.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Harshal Dev <quic_hdev@quicinc.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   | 33 +++++++++++++++++++++++++++++++++
 include/linux/tee_drv.h  |  6 ++++++
 include/uapi/linux/tee.h | 22 ++++++++++++++++------
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index b9ea5a85278c..74e40ed83fa7 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -387,6 +387,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 			params[n].u.value.b = ip.b;
 			params[n].u.value.c = ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			params[n].u.ubuf.uaddr = u64_to_user_ptr(ip.a);
+			params[n].u.ubuf.size = ip.b;
+
+			if (!access_ok(params[n].u.ubuf.uaddr,
+				       params[n].u.ubuf.size))
+				return -EFAULT;
+
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -455,6 +466,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
 			    put_user(p->u.value.c, &up->c))
 				return -EFAULT;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			if (put_user((u64)p->u.ubuf.size, &up->b))
+				return -EFAULT;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			if (put_user((u64)p->u.memref.size, &up->b))
@@ -655,6 +671,13 @@ static int params_to_supp(struct tee_context *ctx,
 			ip.b = p->u.value.b;
 			ip.c = p->u.value.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			ip.a = (u64)p->u.ubuf.uaddr;
+			ip.b = p->u.ubuf.size;
+			ip.c = 0;
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
@@ -757,6 +780,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
 			p->u.value.b = ip.b;
 			p->u.value.c = ip.c;
 			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT:
+			p->u.ubuf.uaddr = u64_to_user_ptr(ip.a);
+			p->u.ubuf.size = ip.b;
+
+			if (!access_ok(params[n].u.ubuf.uaddr,
+				       params[n].u.ubuf.size))
+				return -EFAULT;
+
+			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
 			/*
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index a54c203000ed..78bbf12f02f0 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -82,6 +82,11 @@ struct tee_param_memref {
 	struct tee_shm *shm;
 };
 
+struct tee_param_ubuf {
+	void * __user uaddr;
+	size_t size;
+};
+
 struct tee_param_value {
 	u64 a;
 	u64 b;
@@ -92,6 +97,7 @@ struct tee_param {
 	u64 attr;
 	union {
 		struct tee_param_memref memref;
+		struct tee_param_ubuf ubuf;
 		struct tee_param_value value;
 	} u;
 };
diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
index d0430bee8292..3e9b1ec5dfde 100644
--- a/include/uapi/linux/tee.h
+++ b/include/uapi/linux/tee.h
@@ -151,6 +151,13 @@ struct tee_ioctl_buf_data {
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT	6
 #define TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT	7	/* input and output */
 
+/*
+ * These defines userspace buffer parameters.
+ */
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT	8
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT	9
+#define TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INOUT	10	/* input and output */
+
 /*
  * Mask for the type part of the attribute, leaves room for more types
  */
@@ -186,14 +193,17 @@ struct tee_ioctl_buf_data {
 /**
  * struct tee_ioctl_param - parameter
  * @attr: attributes
- * @a: if a memref, offset into the shared memory object, else a value parameter
- * @b: if a memref, size of the buffer, else a value parameter
+ * @a: if a memref, offset into the shared memory object,
+ *     else if a ubuf, address of the user buffer,
+ *     else a value parameter
+ * @b: if a memref or ubuf, size of the buffer, else a value parameter
  * @c: if a memref, shared memory identifier, else a value parameter
  *
- * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref or value is used in
- * the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value and
- * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref. TEE_PARAM_ATTR_TYPE_NONE
- * indicates that none of the members are used.
+ * @attr & TEE_PARAM_ATTR_TYPE_MASK indicates if memref, ubuf, or value is
+ * used in the union. TEE_PARAM_ATTR_TYPE_VALUE_* indicates value,
+ * TEE_PARAM_ATTR_TYPE_MEMREF_* indicates memref, and TEE_PARAM_ATTR_TYPE_UBUF_*
+ * indicates ubuf. TEE_PARAM_ATTR_TYPE_NONE indicates that none of the members
+ * are used.
  *
  * Shared memory is allocated with TEE_IOC_SHM_ALLOC which returns an
  * identifier representing the shared memory object. A memref can reference

-- 
2.34.1

