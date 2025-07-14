Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742D9C83F17
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:51:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B3BB24FC96
	for <op-tee@archiver.kernel.org>; Mon, 14 Jul 2025 00:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1752454296;
	bh=6ti6WK3uD8rSgx1+MJL0OTBiXFAh+a7/YuzQpoRdCak=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gQn6xfQ9iqGgGBC1B+YPqMhueSS+lK/ce8LtAp4cyQJuvIAZ2meNAzTslgIsSv/6I
	 8ay4qLTnGNFWjWULfoAAUGZWgI4Zc2Lb5Kmju8vSHexG/DSKr7IvtVvFpKq3Hta6Kx
	 E6t9gH76vgHoxUpV4JA4QZAi/uELR2kPV2qm2T2vQov2yvC4xGvBp+B8uGFGyAtRyK
	 dE3XFPn9MLrlnsNeHekB/WWB+qRZ3mPgiX+bxeomCrCeMwY7VIOuIbQMHBH9u8R+Fs
	 hGBG/JUqzMc3FbyZN20hMCLDNMMHF6HOetxgpinzU54xFk2NE4Ve3/5WhoLx//Q7AQ
	 +aHRv4R5DOp2A==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B4348409FA
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kOO7aGet;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DLrc9K000609
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=; b=kOO7aGetcaOOn6EB
	Dd7pX87VNVIXtpo/51n/LvG/uFmmmpkLbdVj7S/Y9a9ZhTOK4ld2Bjnjrzl6IUzq
	GmCpxnf/jviR9foVmIJj2CtNvPOOiyv5I36XiuGm5UuuwNghtWV/3KXpP+2bL4I8
	9nMzl2y+YLlDGgywqnKV+fkahjtIaZFOEt5tE8KTNMXuR35hlsBSYQ5t/yo04DrM
	IO7f6N8xUHnQZwZNzJ0ENlYTVkvLYObRtZuZ81+ifVBVv8G145g05Sy6wgiMBU2A
	5KkPqJx7znQLXJUtYZkC+7yKhEB8Nve9jrd704GrpVTfECzhUI1WfjdrDR8ucZpj
	o0+8qQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ugvmtsq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Jul 2025 00:50:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so2937179a12.1
        for <op-tee@lists.trustedfirmware.org>; Sun, 13 Jul 2025 17:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454220; x=1753059020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jRajMmtFgaOC/UV0OjMPo2r2V0kfVealm1KPcyRc9Q0=;
        b=geOVWWcfUz4aqxOD8gSWV2nDV84oav0r0DaGXhORF12WIi3c93Ze/sHDfwEX8UD0JD
         9wfULkKofHU/DiXoqPLaqjQNb+xzF+h01DUPh97bcq+NncNc/zyiZntVyJmB61jBEzy8
         P+shbVhryt/YOEMbiA3KrKSH6qzZTF41lQ0R7Pw/QM5YpmqGlfTFNHumT6Aor4RA7u2y
         Z5cmfCJYWJMURyy4m+apvcO7KZvoHGllHcUFXNSazo00Kr+4fPfa44u2UQRgwiQEtsy4
         rWTsl3tfDZiumLG4SwdSz0aCuJbTEpdtMH6PH/mA67Dtei0AHS0fyCiOwlPgPh92SFJr
         rY+A==
X-Forwarded-Encrypted: i=1; AJvYcCW/FDvyMYpRHG7SJ3KPeURMOa0id+gNAjh1rBXLYH6tAoS6ePBFVv0sTwLM1AF8wCzH65G0xEE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yw4rBkCd3xqS653NksJNAASGcs8A56oYgL5UwI6+dYMQgb2Wcyk
	+eCCOWU73ucoSs+EfPGsN82/wTRy8nAFkTJj+Tf/4OrRzdmXK0hJsF/guEFTFIOgm6ugQArSmXj
	Dts+lL61CStshHxu+XFj1hOgiWsyt3pMvSihej7EwcHQa0LV/hKXur6jGQTSiMdI6GvcAviA=
X-Gm-Gg: ASbGnctNVsO7vMzu0W6tMsakmjFTMn7TZ5w28yaoBms/aPDQG52s5qSH+/wwxBdrWVk
	ov8u31bljM4Wq9B5aplh7tY8Ls3l8GmFizXuAEm5HLLKpGvtOpez2J5IYLqSOZuSJtaazrQoBxC
	7eLI/OzeraY63OuyKzd6GG6ZrfIVMxvqZIdC5oCHA30aNtxR6OIvKz/UN25D076PngHhyq+Ppt5
	oy1QkWlXApt/3xg81zkfOwTXEJ4+5dQAuQYNrDxkijPyDz25j6aU3m/urs61jlqKQqpirvzsp0S
	F08mz5RBLNE4HScVom8M+9RI18gvPlznHiugxgpHroLlRlRi6QW9M4YQaAUsm3yqU1qNwJtEQz2
	DFqAIasXHD6K6GcwggYCzvoE=
X-Received: by 2002:a17:902:ecc5:b0:229:1619:ab58 with SMTP id d9443c01a7336-23dee0d9ac3mr181151835ad.43.1752454219740;
        Sun, 13 Jul 2025 17:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/mJiuun06sM2rMzoQb2znJePjSbapMiG5DW5Qq5P5rJEhFEAxnwJjdWQYDnBpyFcOi0O4OQ==
X-Received: by 2002:a17:902:ecc5:b0:229:1619:ab58 with SMTP id d9443c01a7336-23dee0d9ac3mr181151455ad.43.1752454219307;
        Sun, 13 Jul 2025 17:50:19 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:18 -0700 (PDT)
Date: Sun, 13 Jul 2025 17:49:13 -0700
Subject: [PATCH v6 01/12] tee: allow a driver to allocate a tee_device
 without a pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-1-697fb7d41c36@oss.qualcomm.com>
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
X-Proofpoint-GUID: DzTLyy28o3XuO5KiLLIpaChKEUf6y1xZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX8qF5I0A8l3Jp
 p9bT6OKOkdQmSAdp+NYOgDQocFxKkqwcblbJgR6z6OQMSJPgQhHCrA7gOktRw6rjNdjEO6Wtqze
 9vc62k1o7Z65bG7wk5NPENx3uEayhlT0uV2aUb+VNv3sqozH/DS2Wxx18ybsf6ltFXDGC69cHzH
 Eu3ifkcPZMRhT797h69adrIzu0/FqWPh2aWW/OC/kmzGQEe+plb7hoRmJYB+Ueg2OiGYRqf4aEG
 6HyjVbg0su/2ptU1XeAt5JyanW83y53I0wQcs5sXCv+c+oGaYDwpVaRy8pezWAE9QSPSUOb+kPT
 R0m5SfJF10wI27aqlxlmv0l1bV9kJU1dh5Qx+mmrOIDQPm3ddcwv5VbOH9nGjQetzcDSRCMN9SG
 5bEHSidiH9Qp6bjofx6ik5PFqja6Z9X50KnXVVQHdNB21oejLzpEaS8VA68P6ssdS2kq9+zZ
X-Proofpoint-ORIG-GUID: DzTLyy28o3XuO5KiLLIpaChKEUf6y1xZ
X-Authority-Analysis: v=2.4 cv=C4fpyRP+ c=1 sm=1 tr=0 ts=6874544c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507140002
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B4348409FA
X-Spamd-Bar: -------
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	RBL_SENDERSCORE_REPUT_9(-1.00)[205.220.168.131:from];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
Message-ID-Hash: G6JTKJGOFKVI4CI66VGS5SUEFMLBU3XX
X-Message-ID-Hash: G6JTKJGOFKVI4CI66VGS5SUEFMLBU3XX
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/G6JTKJGOFKVI4CI66VGS5SUEFMLBU3XX/>
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
index acc7998758ad..133447f25065 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -889,7 +889,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1

