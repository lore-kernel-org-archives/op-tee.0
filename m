Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E386CA0FFE
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 04:57:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6CDE54FD68
	for <op-tee@archiver.kernel.org>; Tue,  2 Sep 2025 04:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1756789039;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=FPaErxnNd0PjzNLnwkT5wypxlGcv8aDjLcqf/n8wDXF16BngSUaKN0FD2wMPSrYH6
	 neMdqwvsxDPhJsMYyFeg1tCLNFesnZ75pvUmvla7GK9a3tFkpkRjwIHi2qMRdSLbxS
	 dkfY6hZNoAjFbOHV68uhN5T2lyvvXG8I4+Redr+XK5D6lrOnmrCGpuQQZm6+I0aEh9
	 8uNibvC8lhdwxyL3bmhuGP+/jaQFlYU42LiO20wDGkFNRPhZWQeZEfYBTJboQjW8J9
	 vQXYiKvA59NM6rv5UokkKej40J5vgwgjbTsuiGOJUWs0u5VPkvB//zWlwKYppqweS8
	 nr7gFAWWREGvQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A979A42D0E
	for <op-tee@lists.trustedfirmware.org>; Tue,  2 Sep 2025 04:56:14 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QqOKYmKe;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6fe025232
	for <op-tee@lists.trustedfirmware.org>; Tue, 2 Sep 2025 04:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=QqOKYmKe0XQ+cJer
	S7yxq/GR/a8nz2SpXqpPS7AHVNwRYITkRQoGmkfvB/adUqPOkFq+yQCKXN/giXly
	8ExalnQXrlVApG7T/ZJ+3YQl9jeCmpe0EEx4pUZkjk9uAIexpTBlq2IW05Ld27GU
	7GEHAfKwBSnzfaOd0hofr9x7tam5xHVceVvAaEBO/aDzXc/QxR7qkLjQkYCrv1cu
	wd6xto8mmM1dLy9UV9y+ZNpS7meuP5zX2gKpulzdYyXWAsz4UQLPl+f+bFRIiJtF
	QnVcOIAXlZwX5QpuYE+a04Od7X/cexzX/sN94rYVgs+HNDv4IB7+bauLgSw1OnIv
	+Htl1Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxjsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 02 Sep 2025 04:56:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24a9de13b7eso26547145ad.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 01 Sep 2025 21:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788973; x=1757393773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=xITtp9G8xQz51dxezMzSm6zJ9JVEg014O+nF8mlypPBhDrXMIHevFaupPmeH4F98ax
         j2lx9D8dQCl8hLvls5W5bWSx98ZxsovdEXdiZhgVut5xeUISRUEmYynDLWSoXacWmE7a
         TRTwOl1fy239SfrAQSDDWpKWBOYvnTAdJxX0Euz0FQu/wMNIBLcYCrgtAWvRhnOFLB9S
         ggqiXdw1W3vKKsa+gR4HpzNqCrd0+R7TCTQIdUlBaVNn5q9kQ1eObQgXBjiyAsvZV4/p
         /+nLbPGlfk12+YxFL/qEhQtzNYJKcRsJ33dlHCOpfqSIa5pqQR4fiA6xqBDRsd0m1Hkp
         6Mug==
X-Forwarded-Encrypted: i=1; AJvYcCXiPZHshTKDra+WLMICie8KTQRYGSrSKpOaGUmW7SnaZyhTuI/2+QHx+aqC7nLLZiT4DVEaQGU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx4V7KtlrzMprFdJU6xq4N8lPPY0bxRkdSBgcu1rwD+qQYtgVmb
	S92wbavoo1YKCioFpjQyJdCYhNSp2TxIEquEc40jYe9c0UhYtp6fE6dg/bOB+DC/++Mw7KdmyvF
	Oo3pUke6G92vROcpEBkR1HzIPIcTcU/1ByvoMUqKox9BsfKv+f9MCKa0VrY7XqFtY+WFR3pc=
X-Gm-Gg: ASbGncvZ86Z3iXeGkwhGCxGx5JPOne6s9tCVFhhqnenCR7wNJ1TxDUNbGkovNqBwFmF
	EJLOfiY1oIXn6ZI61TYxl2WI32YBEtG5dag+U+7DYFz9pNiGwIk7D5MtbmWqZfhVdBL67FA74Dv
	zND3peojUr0GDAtnNWbao3tRj2zViu0ZXyqpcApT/oISClrX0mkqkOnh/bWns4Wk+mnwd/eqO7J
	IKQLhyWls9RBGLeBe6kC8giAHM2SMRUYHmAxF9BQkDOeP8heclYwaizf6Dzy64dl0ZRGNJ8xr3B
	xfsIaCbrZRJDnAl68TGN5G5yl6MOPsx2hZO10Vd2Xfy9gsooAzp+AhlOpyJEEiN0P28z2L3MqcM
	E/7CYeanM2j98KHhazHCrHmg=
X-Received: by 2002:a17:903:384b:b0:245:f7f3:6760 with SMTP id d9443c01a7336-24944b20cbdmr121474785ad.55.1756788972838;
        Mon, 01 Sep 2025 21:56:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvJn27s/WB6VKXSdt4GGDpr0OsZic3u0pMEKyv76QDPWFnyOWUl96Fri/gUJz77+TBs2FX6w==
X-Received: by 2002:a17:903:384b:b0:245:f7f3:6760 with SMTP id d9443c01a7336-24944b20cbdmr121474415ad.55.1756788972346;
        Mon, 01 Sep 2025 21:56:12 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:11 -0700 (PDT)
Date: Mon, 01 Sep 2025 21:55:48 -0700
Subject: [PATCH v9 01/11] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-1-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXwSfUVGaJxyUE
 IfDr9ZuO3k++k7WbXEgGAajZ2U2Pyw1jTlN7UxvROA4xfR9H4VKQwxFkgAnxRObNysmxL8c8EEU
 IMOs0h9P/WBqjrkIP8WRAR3+gq1+5OLdf0Bbex9q2fBLr/kv2+zvcculGQuUIXVKuz93pOiTI6T
 JI6Rt6O2yI60c9FSZgi9WwM8YJZ/E0/OLGDFq0CriJsl82mm66a6cLBvdQFSRPSMXWtP39Ssg6B
 MjRKsbhSADHa386UHaaiMcGBafsXIWlwrWRBKdIHHXjF2SzHgebdHbOWbVtVoEo8Vz+9CzC/vez
 8E6T/tfPSsdzVri3zd+n4vQa3HtnfI/rseRHyJ0tHfEeh37+7ST+cetI4JVVPOvTE8XIIQkXIEB
 oZzUR1gU
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b678ee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 9InIu9Fz0kQkSOyr30ucPIB27FQgphbe
X-Proofpoint-GUID: 9InIu9Fz0kQkSOyr30ucPIB27FQgphbe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
X-Rspamd-Queue-Id: A979A42D0E
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_LOW(-1.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.20)[129.46.96.20:received,205.220.180.131:from];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 5O4V2SN6KQNSADAYPOHCRDORXEOZGUM2
X-Message-ID-Hash: 5O4V2SN6KQNSADAYPOHCRDORXEOZGUM2
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5O4V2SN6KQNSADAYPOHCRDORXEOZGUM2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index dcd40c26a538..33091aa21be0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -852,7 +852,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

