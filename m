Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FE4CAC58D
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:43:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C3C7E4FDE9
	for <op-tee@archiver.kernel.org>; Thu, 11 Sep 2025 03:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757562235;
	bh=PlNtUBn1m92e6j1roGLFXzYvk2/0ghYLEgBgH8NcnDA=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=SWMvPBRBBeunAUbdbZRY+QoOxdMG8cySkWZImYXv80hw/jIPyIEdkFipurZ6AjpRa
	 qVhq2HJLgz9KEuSzQMNgPRjgZOigi+w2Q8gQ53t/W1fvRV30gBv1bq7pal8jm6jU+r
	 4WMpyTnzcUtHQj4IAMVrwierGVSLrZxuxmGAnFX/mOpHcSU28pVHGwpRom1lt6+yhC
	 u6woQ/PyxK2KXq2lT4Kz06YyQWlXwUxPMZXG+X4Bf1AZ8rV5FTxf+C9lLO+lyfmEEy
	 /eyHe7K3Szqh7TIySh/dd01N+V4ryrc8kuRgnqXWPHztIXAZQmslRZsyT0YSJvaWaP
	 BGZHsMd7cFeUw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CC2804FC27
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O88QfUT9;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IVUi005414
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=; b=O88QfUT9GmAis5Ps
	Rd3Etve6sOMnGsOB1PoKeD8JHjerLUfP2tnBbArzZBPIyEuWUNXDvA90enzHZYIM
	jMDje6iPstBEmlMOQI0rDe8TGPMgSQ66X/hLrnByK0zob7QCeJHlUHP9PVPKnzPa
	RcC3Kvr248vdGcBYGqIDecQvOTyole3a9jungNRYUt4VFw+5F8QTQ82+JovIV5pY
	Q35cY677ctHy0L3+qubkkYTiZmCVZGMj9qJzY3hk0rLj6eOLDtL7r96VEgfcCR7M
	NMOtOdB5Fw0DLtcxbWyCJXKdIZuppx/BaG4rEIlxKmTIeUcbY8MEURsYwd/HohAH
	F8hwkg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491vc2a630-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 03:41:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24ced7cfa07so3043425ad.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 10 Sep 2025 20:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757562089; x=1758166889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cy7zuNmWldsjxlDI+hNSLQe922ofh0kNWkW6uU0Hx8=;
        b=TIsdYFoO27QPppuyK6ozQbrS5gERuwWQXKRhBlvsH5Fs6kxXVwl9tdtOG40AF4OmpZ
         PeGG1DOA7uCcWFspYLaaKPkBCM2zVNGIqk6jtoo/BsVonwnyrRTE77tdy/+l+ztiubWO
         WmjlDF9i5nlsNATSwJ+sZ72M5MpydJfrrmdS09BFepBE4aD76YgdoyKrtWjL6LliQNZV
         KroFMmIgVPc5ssd77gq2BgDx3mudO8vyBSQhwr9OAvmmJ3xlOmmC2dt3Ieni9+GOVdtW
         y9+UO+peZ2L/p6h1wdqNjai93TgP7dxFeUforBu1GZw7ifa6b+I9gCrzRJsD7YJVJlmi
         Bs9g==
X-Forwarded-Encrypted: i=1; AJvYcCVq03y9CPY9jZgjfohBBANO2gDPv4nEVogcPQ8k14liDvpmkxXSqCCuDN0SKlFgeZFNWagVWQY=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyqn8VAI5eFMaC7baSeMzpoZAaR8rCrrC774i2D6VTW3E2OBiqp
	T0tD9kbtrjYwfE28IoE9F5hdhN13kbHP4LRIzU0v8bt4EjHCUpWmP+bQQD+M33Hwth4FohC3Ip9
	lfD/BeosHkvxwRxyg58V1ScNWyZIBv3kE/wC5Nkk2O+vMXohhhBwQ2MzrHVxEzf/vsEw4zQM=
X-Gm-Gg: ASbGnctb7nf8bHPSX2ICDRn/Es8Vq8YpcSjxg6jbyAsVhWLxpSBVSgQFwDKRiHLTZf0
	qV0wVojBG4Ebimm6eClQ/ED1P/LJektSEAXXvfitrj4Cu1mo6+TisFAEwRoKhg9iD65iN22wnTw
	T6hWrQ0zw9wAGdzOSWek5fSC05qB5XhjrR7o/Gz4h1idcPwnjtlss/8RQq5XpHsTqL98eze1l1G
	S9vw1eF2edElJQHy2n8CU3JxuKqHYKhUS0OmjeYNzbQ0Q0BxWsT/V58NC9aPHmD2zGV/Zombsv4
	vzASy2J1JyKW3rRFNAQV7o3G5s1jH6trPY+gL0IexPcpZiXN4qesjTCae7Dl/wrgN+8zyNM1thn
	CIdkvV5CBDKCOUlBEnQTnsuM=
X-Received: by 2002:a17:903:2b04:b0:24e:13f6:22d with SMTP id d9443c01a7336-251722929d4mr290434725ad.36.1757562088997;
        Wed, 10 Sep 2025 20:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKhpZZ7QQ2u4bajGkkm1KKWLUYyswJaL/iiPppE3MndRE8NjcBrWi4HRB5LTZP40i4NipFKg==
X-Received: by 2002:a17:903:2b04:b0:24e:13f6:22d with SMTP id d9443c01a7336-251722929d4mr290434315ad.36.1757562088589;
        Wed, 10 Sep 2025 20:41:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b304f76sm2962275ad.130.2025.09.10.20.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 20:41:27 -0700 (PDT)
Date: Wed, 10 Sep 2025 20:41:16 -0700
Subject: [PATCH v11 03/11] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-3-520e867b3d74@oss.qualcomm.com>
References: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
In-Reply-To: <20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=FN4bx/os c=1 sm=1 tr=0 ts=68c244ea cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: cJNHlPwwhmsZOTorlVRWur0IJ1ubRiNh
X-Proofpoint-GUID: cJNHlPwwhmsZOTorlVRWur0IJ1ubRiNh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5NCBTYWx0ZWRfXxl3HNwB2YdBs
 Gxxi2VxJWJq4JiQaaxhEymtOqdIQSQ1wY9D/rehQKeas91lyaNBU38sNSRSe2tmLruWW9neRZzM
 8tqtI3z+xw1JGxcncXL1R+bdC6/zYK2AIGDuwOsIUCNuf+3vc0wFXOxrbOYJ8tFPEhD643BHW8o
 Kx6WlaVq501mqaz6zXHefrm6uBO8VCLu9G5pAEZE6b0nAvy+f13mCBQNNrG/TomLqyZf0tJ5P4q
 pwMd2AFeEAexQ11tkJjpaU7o2oMrpeilGezbo5aLSscjLgiND1rSX5m6Vh/zSsuZAAgW+B0eliu
 N/mnrhfaDiFuMXVuolnURu72OEb0SJP8HBIyahyJ8z1Y71Shnpkzwl2PjQuSwLugzGMw2TNU/rX
 oOzsQ2dd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080094
X-Rspamd-Queue-Id: CC2804FC27
X-Spamd-Bar: ------
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: IIUDPGGICRRYZH3DCKG2IVVMV4XSGAQ3
X-Message-ID-Hash: IIUDPGGICRRYZH3DCKG2IVVMV4XSGAQ3
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IIUDPGGICRRYZH3DCKG2IVVMV4XSGAQ3/>
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

