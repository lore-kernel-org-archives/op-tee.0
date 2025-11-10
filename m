Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92897CCFA13
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 21:29:44 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B09CB50039
	for <op-tee@archiver.kernel.org>; Mon, 10 Nov 2025 21:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1762810183;
	bh=g+y6MSy72euGXPhtDEt4v9F2/OTUfa2+S7jFbeHaTz0=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=eK5H25eeLeCPzV0BER5uRZUPc1Pf4Q6clnGk9cdK0cLG5F/0Y3f52De9SXWP8JSi5
	 9o3u/VOK8YGhaOAKlUByUr9j4YwhLKy3BrDksxeXtLiWBspMjVh2OIe1JljDg6WXUR
	 j3Apbl+BM5PnEZRVeCN1ghCvEyWmQfJN3YNEliRU70GVdlJe4LDXu0sKh6nPDBgbgR
	 2aVfzvNDlkBuxHsH36Q18cy1i6A4nRXbSdhWJ1VyQgdNtAye8J2UmwrZV060ha0Py+
	 diQjyzbQHoSC/e31YjwjXVh1KcZYRRpNMtFEep6k18Sa9kw7lxZqEF0IhDe5wgHxGB
	 kOhWHBSNZ2cYw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F26EE4FEB9
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 21:29:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GmZY1rUD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DfeYBQT6;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AAJxtDj3271012
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 21:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zjm8QOGOt6wRLYUzXj/zuV
	GSGpLuzn17DWxZW+DBPow=; b=GmZY1rUDXKZpodDpaa53tQVEKjvCp++ltB4StH
	KFPq4Yh8+6H/qMsDU+UMJzAep1WV13Fcs2+lbQbjZuSglypbxLGAYnx6WF4Lc8Xa
	clyRCE249k6cyq1dm7IIx6IU8KLGL24q7TYIS3ktDtZxgdG2qBfLfX4K1m2dDjf/
	PiYOkycWnhQtenTI3kLsMqP2Ltfk5XP4SehEzjqYY3nHUDk6ADBGJ7Ka7RQ7eZ94
	XpGcFxCECbeCnz9/t+ZdGs29TCQa8rN5D4iw3cg+78Au2QfPeW7MCKu9C9/yw2Mo
	imQMnZEcTHiYubEZACm8Fwn9AQ3Npdg1dwODKljeiAJWFliA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafspvq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 21:29:29 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2956f09f382so1502135ad.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 10 Nov 2025 13:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762810169; x=1763414969; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zjm8QOGOt6wRLYUzXj/zuVGSGpLuzn17DWxZW+DBPow=;
        b=DfeYBQT6aaoQNxzJFV3HZuINsNTAC50BG9//u6Iat6k3Bjh+HZjHxSXymPK1dwQNXN
         o1iOmC4VX0ykITGH+Doae+iSHR6eGmT6DWOKIceKEjolqjLkThLsIQl8lfBWwVZFfuYU
         L5Bs5lENhwaT5ogx+mQyGj0Lx6Yf3SoOW2nZ6qOXz0UQnFUp8EavxM6E2FyCCwkl1CFm
         iebrgqSEY2FnpYqsHfhtkZH5dn2rUdF+3LjxddJGqL825Wt0D34PVCJsfKTpJcTpE85v
         bZBW7tdHz+apKCL3+Hc2Q8yXtK5gVYP6k3J5mWbCxng/mwi6+gCMa4EFo7vEwtCMMzy6
         tJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810169; x=1763414969;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zjm8QOGOt6wRLYUzXj/zuVGSGpLuzn17DWxZW+DBPow=;
        b=JqGLFIKJh/9SGLdmN0KuMHWCTTTqiaZAJGYmbuEVQCJ9lDyhydzLMBXfOOPFCB4StJ
         oh9hiYOjkBe6mlbGbBOULignGh3zSoV6OR3siiLzZMKNWCLGzAz9KpE9Crn3BOT1oox7
         y9B8RozR3ACkj7fZLxBeyop9yZJlSWfueEAWzF8Wqmq7lvQ1DNeuuTIHQ/nXkYIZmBnQ
         wBhHL5xzVFKLRKXISq3wAx+l+/fbMucBth1dupg+pkaApLh2rXazED6gnRwB/uQwDvy8
         QWSNAeuwP5feI8muzdZwba1a8lzuqcVsyzw/Nbe/5Aj73JjwWOR7pB1iw6benTIAlVAS
         HIxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrLG3Xf4xSlPk5J7aSLI32PPoPm0mRWaystcfnMeBtZas8VeKAcfwD/c/ZI1/twz1i+SJBO7g=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yyfx4K9nSXqDQKv0h+mB0GKlFsCoLPDsxzxWlKhk/yngCR5JR09
	JuTfwNRm+2/BTUrIph5hYEBPHYn/f2Tw2V0senFo2bPcWtD8SVxXYU7WkboxuDyiuzA7R7BTft+
	tRYtQksp3DMAvJIXkaRvC7BahFs9BDCR8jnqoEBmE8OGm79cKxvD8vrkxNaNt1nnPNF744yI=
X-Gm-Gg: ASbGncu1Wgybta30BQgRxkU54FbEHNnGakxhURsSImw6iFacEUgE82fPzYCoAPYXmPB
	w6Jf2TXdq5t1e2RJtP2csJtcxC1w1OyeknWHWdmGJCf3XVKZ1X1Aio2BpaEsbpVHkeAZg4FDLDF
	Of/GZeC1S6w6PI2d1f0oyumIoWRE1VDKym6NXvrs/EMYPoddgbSUxy27qOupAn9aAWuuyVgy5VL
	9ortUJIw41FHqZVqVBVpLg0XLqtztBLU9dtW6iYpSXmxRDZ0IW3pKnB5hOStQxdR4puffNmgkEH
	rDP71UIbuhCmXtk2oSlnOalfggtWv8uZWeTeH62v6dFZHIWdxKPv5ktxSoXLy9qELC5RId9pbYn
	p3GWfhEeKg4nCM3fnhJjk9IAqnQuWa6vs3ICwzvSJ5BBMt0o1Js8j7vz0YQ==
X-Received: by 2002:a17:903:2286:b0:266:57f7:25f5 with SMTP id d9443c01a7336-298407daaacmr10730445ad.7.1762810169240;
        Mon, 10 Nov 2025 13:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIuV+1SxMchLbxTlgtjAKcFCy/+6NTWvSU6efADcUbKDtqkuQ+bij8jy109pZykyKrrcsPkg==
X-Received: by 2002:a17:903:2286:b0:266:57f7:25f5 with SMTP id d9443c01a7336-298407daaacmr10730325ad.7.1762810168681;
        Mon, 10 Nov 2025 13:29:28 -0800 (PST)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cb47dbsm156444415ad.96.2025.11.10.13.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:29:28 -0800 (PST)
Date: Mon, 10 Nov 2025 13:28:32 -0800
Subject: [PATCH] tee: qcom: initialize result before use in release worker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAP9YEmkC/x2MQQqAIBAAvyJ7biGtSPpKdBDdag9paVQQ/j3pO
 AwzLySKTAkG8UKkixMHX0BWAuxq/ELIrjCoWnVSyhoPGzY8iXDmB28TPfsFG9dp17dGKaehpHu
 kov/tOOX8ATQgbvZmAAAA
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: YWygP0eXCplV0YEi3EeD5r7P0ZJQlUqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE4MyBTYWx0ZWRfX/NKwAzmEadi3
 aJ8vgrcdyTV95BCC78tE6sI41xCscDrvaVdFaiyUS2S5vkbMoZqwxrAKd4ZPzepv1WYGqCsIPI2
 X4RVDOMvXNVNh7b5Wdtb5MHhqud5O2cT9GUXfluYFyTtksXo1USAIUkt78z+4uE77gpYJWXlQpb
 uqpzTNQFTLZq8dM0wISirBmj4OjxaUm3HJ7VyJLwo4G8hl163JU/rDoe7OfZG2bBek+vsaAqjun
 41ScnFTpmDaAygWTqSqjGvSyp22e2FEWV33klMjnrLixuQjEay4CqK91gavMr36zAhvDYSQnhGh
 sk/WzwR1sOHdCGroz0nnWoVnWKdgvb8pV72Erx1PVYBMFDSX2e4o/99LJLmcgvvaahhM1VuRZTO
 AczNqkg1eP8vDqVpYQ+7vcSvLGRGZg==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=69125939 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=hYfsqUzT0y0sb8bvQO0A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: YWygP0eXCplV0YEi3EeD5r7P0ZJQlUqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100183
X-Spamd-Bar: ------
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F26EE4FEB9
X-Spamd-Result: default: False [-6.70 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,209.85.214.199:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: 74UVUZJ2N3C5P65DZCYQRAQZ5MVCFLJG
X-Message-ID-Hash: 74UVUZJ2N3C5P65DZCYQRAQZ5MVCFLJG
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/74UVUZJ2N3C5P65DZCYQRAQZ5MVCFLJG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Initialize result to 0 so the error path doesn't read it
uninitialized when the invoke fails. Fixes a Smatch warning.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/op-tee/7c1e0de2-7d42-4c6b-92fe-0e4fe5d650b5@oss.qualcomm.com/
Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index b6715ada7700..ecd04403591c 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -82,7 +82,7 @@ static void qcomtee_do_release_qtee_object(struct work_struct *work)
 {
 	struct qcomtee_object *object;
 	struct qcomtee *qcomtee;
-	int ret, result;
+	int ret, result = 0;
 
 	/* RELEASE does not require any argument. */
 	struct qcomtee_arg args[] = { { .type = QCOMTEE_ARG_TYPE_INV } };

---
base-commit: ab40c92c74c6b0c611c89516794502b3a3173966
change-id: 20251110-qcom-tee-fix-warning-3d58d74a22d8

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

