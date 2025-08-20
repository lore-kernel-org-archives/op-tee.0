Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3482CA0EED
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:41:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1E0994FD1B
	for <op-tee@archiver.kernel.org>; Wed, 20 Aug 2025 23:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1755733282;
	bh=l+gCAkpYYZQ9/QpAMnLhH344j4oKiv1+YukXPatT5xc=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=zY4mp6sGG+kiTqAZGT1d1RnXRd8zwhceYnue4fhKRZ1gwXWWGU59GDm2YbWu+o+e6
	 8elQO8B0dNPXw+6fBXn8NnbJNSnftpo6D0cJC7bXgU2ySfNyz5rhrNnKIzsyuXvPFb
	 WzfCqnYUCm0hJuYGHyRA42hkzioZEY4sU+ekaYlsWxeiTExWqWoXalmixW/E802imx
	 t6UMf2F/ZczmXTwMJ69FelbBl4go4q6RjxOs5r3SIpvQ77V4xTzLyF+bDcvaG+RIOr
	 jj3lN7ofPxtyod7kGSVo7Oi7WX5tqXTrn2GvyoPXL0FPyqdCtX7Coh+iX3kB+LBwyN
	 HMu6WeaEstZhQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AED9343078
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ty7lxVAK;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFCuWM021480
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kA2t4DUz1VB5leIiGtQRvZZgbMfKTdedtPP/wTAuryY=; b=Ty7lxVAKC/0+zkbe
	ggPEiRsT55PXPmotdcLSuiCfxWrsrxx7vTovDUCXtIj3EdnLgGavCzz9jZETX5OG
	3bxg5ZZjnqEpgUTlBL1M7VIU13DuLA0V11ip8mKfmQgHNo+wl3vozM4gRsF9JBXF
	iGiQarlQxtUBQR/cf+cTg9Bt0GJzlavCIGblYz6BzQYvM8ex+XMl8qbgxn5ovSxj
	XL+cqVgpR/VHuxf8fgNXbMTnfZS3lmHY0EJkWTLD40FVMsf2HCc0qWMlPlgErLS1
	8V527I4AJlbY51SrE8zDsNuYnk/NOxBYcKWJg5+1gCRhTKgYHQsoG8DRm2psKCl4
	2eLaZQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdh7kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 23:39:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2ebafe0aso407189b3a.3
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 Aug 2025 16:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733148; x=1756337948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kA2t4DUz1VB5leIiGtQRvZZgbMfKTdedtPP/wTAuryY=;
        b=pZUGenQeFejJWia2+ODKxBA6p4NKk6jPylLFbTmlPfzozwlJeYnB04SXxy3Oscyu6o
         QWSiI8LOKXmtAOwatk+144fqX+Gt/Ec6FUAYZOCEunkiiDHx+qeatOLwmWeOnx+hp2q4
         gSAT5iL4PJLrzFhdwSTP/8pnzjbJDw95bp7WEuk2rHGlT+XO6qJKrLpY69v/c2sciATK
         crdlxDmLgI/L30rzxTrAJAYbgFUojpTzu+X3VMATZWUiIPPrZ3auD5ILvscEoY8m+RWv
         l9dUDYm4PLMU6P58pRS5gIUB7sCX0bgWeNDdP2GCtqD55D7kSMMj7eUgaFwH4Xy11F3A
         ZWWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTB8PCRU/oO8XJ+izHeZ3kK1H/l0RbYorBrmD9OQjQJCY35y1T2pdUZMu9m6ob0qSwqQCMlX0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywq3b0MRSOqCZDfs6/MKW9qG2edj0kVrdXdm61xresTZ+kmtuBM
	gFE/Qc6h1ndBMvtUKIqb/9EtWNfze0G+4Q/URR3Ux0ZXNZY+I+PRGPwCJjtoDVdh5E6gkuzyxxR
	qm59QbjDqQUuSCAZyr+17V6GUPv2PoamxlAs31Ddgvu1KtBeQZ3qb/fDmU3sQVyobSur8wAU=
X-Gm-Gg: ASbGncvzMULwmraynkgSYFle7PRKwz8CWp4+magrunzKh1XsbwhS6gHAfegSbBVCbar
	jruMVi2CPSIYS2WGHtKii442SXEkXRmUgv8rLR/SgdzKBq4kaC2QHhml0VFQHqBkc8TEjfhCjGJ
	fi+A5mTK/x/NG5+dlQdSygmfXkL2hlf1h6/dYSv+q0r6qHCt0X7N4sv4Bz81F/xgbGwmh3hUZfi
	/PKdBzdOY7nkr23bCZ4N9LJabGcMNVlWrDQ5noEYQSGKiFZ8NzAiEQbyoJkmiKZXnL/p78/+WU8
	hkMEXdHBl6DJJ1UJUKn85YlAnEurQwOT2cIJXIJdeNknfi8Bv4cVfqw+aeNCDo2z3gGzRTxM7wQ
	cR16kkQfnzBtEBma/wiPhDPI=
X-Received: by 2002:a05:6a20:9150:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-2433082520fmr432519637.12.1755733147742;
        Wed, 20 Aug 2025 16:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6rff5A8cwSZC9TAcPXV7NBevAv/40cK3tC90Bkit2HX0eTDDc/WBQOUnwFnPZxiBFVC56AQ==
X-Received: by 2002:a05:6a20:9150:b0:239:c7c:8de8 with SMTP id adf61e73a8af0-2433082520fmr432479637.12.1755733147246;
        Wed, 20 Aug 2025 16:39:07 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:06 -0700 (PDT)
Date: Wed, 20 Aug 2025 16:38:50 -0700
Subject: [PATCH v8 03/11] tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-3-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a65c9c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=COk6AnOGAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CeBX38uJA8qs-X-5EtZpFtAHZTPp1EQ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX+bUtuh1iAqwi
 tYKKpo7j2QItTvU//jjPEHfzXPcdUsN04C8qS7vMomCIoXpcu/6Q9qSu4yKGHLTDY19NXDR3vv5
 Zpk9e8ItqdNRHokJ7QSg8HIZWquaSmD5QCpfcTiJs57dVafGjw7ru6ubpU2bI5+l3WhythcKRpl
 D+R6iTuR6d5SIJ44gRirYk9NV6325h9HrmoAFjtNdjFqiJx9jwKirriBrS5imTHM5luLKkzyN3b
 xtfezckTWMSkp1Di8ykcIiJe4CYeaIBKjRy1wZSBI9KX9JSj/8sK9Orl2TqIpkccwTDZgyGzaF9
 KFoy+Be/H18v6tKBPWc1lEBritbOIDDcib6W+k3YhlwW/H6/20wjPP+dKmVM89nnQuKhwTgUA4r
 ZDIKQWCphd0jqjlOCRWd2YQ+WQslwA==
X-Proofpoint-ORIG-GUID: CeBX38uJA8qs-X-5EtZpFtAHZTPp1EQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135
X-Rspamd-Queue-Id: AED9343078
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: O24EEYMY7BRPOQFSTOE4GQNTBGZGZR5E
X-Message-ID-Hash: O24EEYMY7BRPOQFSTOE4GQNTBGZGZR5E
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/O24EEYMY7BRPOQFSTOE4GQNTBGZGZR5E/>
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
index 0b4c65dc14cc..ec0094291c69 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -350,6 +350,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
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
@@ -418,6 +429,11 @@ static int params_to_user(struct tee_ioctl_param __user *uparams,
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
@@ -618,6 +634,13 @@ static int params_to_supp(struct tee_context *ctx,
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
@@ -720,6 +743,16 @@ static int params_from_supp(struct tee_param *params, size_t num_params,
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
index a54c203000ed..bec9a918b950 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -82,6 +82,11 @@ struct tee_param_memref {
 	struct tee_shm *shm;
 };
 
+struct tee_param_ubuf {
+	void __user *uaddr;
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

