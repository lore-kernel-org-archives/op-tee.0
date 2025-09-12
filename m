Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D3ECAC582
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:10:20 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0E5454FE25
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757650220;
	bh=PlNtUBn1m92e6j1roGLFXzYvk2/0ghYLEgBgH8NcnDA=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QhZFY8lCzwfUw2LwtJjhZMEEwD5E4t8KG/Ml9Qbe2PhWfz1rA5/jiVO6p0GZfQ+0i
	 pmRGRcgUMRHRYJnA1/VKWxoVzo2lLf1TWmJslxkbewdwzCE31MHme9/vOFhYfNF2EE
	 xhTAf4O+x/k4D5qYXZ2xfruLB8gS+7UJhBMH+4+mG0P4Znm0JB4RRfHViV/m5xXRC/
	 XyfUidPSvixdo1WA8XVTe8tnG6U8pdhsx3eBoue24F/4cTgAzDUrt6x3DedKA9A9c9
	 thH+vs0UphtZMK+epwnmO6W+n3N3bzzxWF6Ie460nT9qdrTyfnH8X6jp0kYLGD9POt
	 zrtuAuNkV8riw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 52F324FDE3
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TqMrXJvD;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHM3SQ002496
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=; b=TqMrXJvDnndTHE8V
	cdwpRbB7NMB0Uza1PdVqtA1sHoldiQ07zAcyYHo3s7661dkj8pj1MPfX+eDE79oj
	tsvYh/G0xeJJnhUxmHuCLO4hzWvP8BgITilhMfSL5Q/23TfwqWXKjZngNcSnYsCH
	azw2ZMTjSeDkWvbef0COzDWFwVFYpBTPumj5KpxRetgAGkBGsu+Fsgh1pNp6BwLZ
	yo8jLYDSOMR5VSMPnQnKDWhhd64PgQIdlduHN6P1KyBgdR9jv7XBH012MgKg/X+w
	90f6jtIBkn+JwuF/KEs8/JbZ/NefXQvm1XNbs2I4wCPYfM6akRUAZW1TRIZJ4zZw
	szBOpA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8t7fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ce3e62946so21153585ad.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 21:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650071; x=1758254871;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=;
        b=TuY/J3KaA440Y8SMGFZC4ON9kLtiCscWuAc60KuT9SoohsYpxrBP+cDWMA7MGc052M
         04bK7V7XmdWipgHOd9bWTzGTTJmzy0J6ibeXbay+RMTQoXKyMc7/KPLODMraBUwVnmuL
         zXCnVmv2wpO3bnFRpjIS8waZMpBTmpVcZ3dWzhCxUeMA9WGJeqYvBk+hwkNNM3CYQzGA
         w7onHWrbftJKViwnJFXLAce80hFaDVEAZ6GF72A/TFx0qBv1h4pLaaWHEf3oqtGXIFa6
         p61DPgFN4e077P/7aLh8l6b/RWKkyWv51lLWzaClWblM5ZDujclZOyPt0CBG3JDUKeJ3
         Fneg==
X-Forwarded-Encrypted: i=1; AJvYcCWXS9EvN0jrf3EIjiPnwTqnwhg2okkIRCtdl8WguZMnfTq3hoQCRHFRTYpc9SpjJf9lXjnYY74=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxc8/eUakr6sLAox9DVZbbh7oreN3o9OwIgs62mmpFGW+rmKaIe
	/keaMPLur0oDHlqUvDWjOojRszNCDm2T24Zh1w8SxYXKj3hWVSyU3AqblbYqgT4ll44LwSVtGst
	+dke929Dd/yKtSbKtrIKF3uwnwp6LmdcHfBmBeXZCaKKwnP56f04/azp7xk9pXwVrXU9dHq4=
X-Gm-Gg: ASbGncuCXwZdIsBmKQk5cpAI1llVWi/+gapdb9RMyuUd8q1KeSuIYnZP3+QgzdwSGVB
	WIplsmn86M3yZpHh3VvL0mwomqtSWLgBwPvLymAhFmjUkGdNCWQ6tPx7RQLGzDDd3LLjZHPGJtT
	FCxSEGstpNNITjCUWke5PpgWvAou0auR1KhyTLHhqTnXb7spY1ttwkEUMkCl4o+h+j8TaKN/A/B
	nS2GNFtWG8y8yJhjMo8hW2zU+KglkpEJQ7dGou5f8GK3zJC253fQkUFNslt50vXEY180v+g4+c6
	t/vdjEIOz3HPzGn+fraN/k14kwV0elF2K8KyRzMJDFwQrc0CYfDs/qfeFy2B48lJ/a8oEU0tx6G
	g2Btf1zAX2+SKzTgNRBmbE8w=
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr17317655ad.14.1757650071306;
        Thu, 11 Sep 2025 21:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoqJc1O/uAlEAxgaKcABrHUnAHQ+NKSR7AY913bzR8AUunHyu+K06+VfdNdepa7qcmVz579A==
X-Received: by 2002:a17:903:2ecf:b0:24f:5447:2197 with SMTP id d9443c01a7336-25d2587d2c9mr17317345ad.14.1757650070858;
        Thu, 11 Sep 2025 21:07:50 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:50 -0700 (PDT)
Date: Thu, 11 Sep 2025 21:07:42 -0700
Subject: [PATCH v12 03/11] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-3-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX82hCnhbrDLl4
 X4MK+Ork4ijaKY2PlExpxWDbUf2ErnZ4HAkTGPVRLkgQNqrzrY6mgSSgmT/IpZxsk6PCbk70VGi
 IL/1iEWT0jQP35q/AD4dEjcswo+cgU1T7LEj34AbIxbD939s8O4TqFMcPHsD/ukbP5iiY5KW2MK
 a7eUzx0QyCRQmM72LfjUJTXtHe1e9psg8/7NhAKi2EUAnVzEvZ2p9TTKGLaDU7yfXS5gpPGAdMe
 7nqoR3ENCkHxNL7NEFhot157x24QztwzlyGMKMUkOO88QaooefDTdonzbib5L2s1TL9qeW4cCaw
 A3u/FHpXslRwknbVjS5SqncmZM4OxThDNGyOCt6bqtMA4sTwSYr2I27d0jdAZfZiZpO6m/cdB0q
 rPiOhhKZ
X-Proofpoint-ORIG-GUID: xSsWGT1wMAKO9DxeP6tygwfcCIqHu9Sm
X-Proofpoint-GUID: xSsWGT1wMAKO9DxeP6tygwfcCIqHu9Sm
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c39c98 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031
X-Rspamd-Queue-Id: 52F324FDE3
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: KKHEADB4UWA575TQ3YGOKPDQ4FTP6S6T
X-Message-ID-Hash: KKHEADB4UWA575TQ3YGOKPDQ4FTP6S6T
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KKHEADB4UWA575TQ3YGOKPDQ4FTP6S6T/>
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
index 807317d7b3c5..9fa042d80622 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -926,7 +926,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

