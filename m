Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF31CDB480
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 03:39:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E1B064FE9B
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 03:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1763091544;
	bh=UzdYxELmm0fm7erfuB0UTWHLqKKoidbNoonBnq8ggb0=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=ZtGvRuvDUVgytWyosMDmjwW7pRQcP7zX78rkxKasEcMv9bK5kxF2B1P7OFN35FViv
	 Y0CzfJz2r+aV+eMm5Unz2i3RMWlmE69QIhcdp05efXaaGbKeq3xLcjkvlXIJlBL5t1
	 EprceEqDMugrx+X5eU6rIx5rg9Qkkn9ysWLMsjHxQ4HwIVK2qRdaY7hgrYUjhjWG5z
	 ++Uk6d7O1VitC0jZRt5t4VMaIn4hRzsBhI5b0S2wRx8sLHpV2Geo9qXeaaMcpTNwwl
	 bangK2INjcZiYGslAmYnbyw5JAXlorXDDiCYll92BNYG3FRWsU5dWjjuSgxjPijiVm
	 oPzmH7bMt2HMQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2C2633F808
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 03:38:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hLjQtVA7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AB8iyQST;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADMbFDt1698664
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 03:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tFJvq1rRN1cvHD8aK1gK4T
	3ZkfSL8LrK55nyklIFhF8=; b=hLjQtVA7tg9QaVKMVkGX5lDbjapvfaLAWseh7T
	/G+b4dtNwVgW4bTuayMg6zdtd3qLY5HX94rayHCZyyIKUgyFjaRqMwkkQ0u14m/2
	zFfG2ZIdbNgG0cNITv5VNudmqMu8ixH+A2gOK+c2dIEi8dgL+bzXbW5SUeOLoFGB
	ItmEqy7S0Nr5Skj3MP23TN040tfWo7aDyRw99xC+hg6QEuNOIN6cKE/aZFvIo0g4
	tIVAH5VAurIbgnr/tdeQKLl4WVXz9b4HyQ/A8m7rIxeLAy9ePoLeTYnkPLOC7rV8
	ESEWqWOsM+yjv2YLgR0U5C5LZr5TDDlHWfPYr4HpfL+VecCA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9g0p5e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 03:38:50 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b969f3f5bb1so3526603a12.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 13 Nov 2025 19:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763091530; x=1763696330; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFJvq1rRN1cvHD8aK1gK4T3ZkfSL8LrK55nyklIFhF8=;
        b=AB8iyQSTrWx1ps3vSZHJeFvCTt8JuiU25T4kd2NEZj7B2To/jWLxjsIqhJJAuEHmrw
         XzWapAb8lhAj6Avi/oRze2LeUUn/zrtW9TdFKzt24sYys3AOYFfI3M51evWARruFcruA
         aLRNCf79k10NiG5Uv0oTpZFuP3yLKKfrz7MwOWkkaC22hcKzsGp9TzZuvt+hXXI33inY
         H/0IOQ9wXFEOIYguzfenWfK7kQoZTyIYMghnfiHXalDl2ImuEgD+6x3Ey2K81YqJCusp
         kPw5wg1E/qr8iiL4o1vIheXlvt9rtK/o0bqVXRUGL5y6dvNYIl4ggvZjtkYqQ5jabUTx
         OKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763091530; x=1763696330;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFJvq1rRN1cvHD8aK1gK4T3ZkfSL8LrK55nyklIFhF8=;
        b=qCbzB1RdunPfd27xpPgSdZh54XIRg6NcfKLN4xIZ+5ExFx4ROzRwFNZuPt6NuaUG/E
         hU/00Vz1l7efeXVHgW1EyGUPqCkH1Majim8FtmpgS8s6YeCUKJVk3Imv5Xjw3S3ZF+Xh
         8mUOyXgqYR3F+ZMX2pO99xS6yfc/exeND9OkWBohwyTXAH59o4ssWjQpm8DZ/48Poclv
         ed4qysYpOmak07yIyF1ZkE9EcdfqBKajr+xOsIXNKMTMQ3nfGe4uffcaLLiwVmmi+Dg1
         cZFnqGaM09uyaahG57CQj2DBgwB19zpUEgu3zuwO9lMqjqtod7t1rAWCtifNbtB4lS0S
         eBwA==
X-Forwarded-Encrypted: i=1; AJvYcCWBHpS5T5HVBeJnW7kzGn8lYoLaFNH6qaf3qnt+5gGMyYbQLZ9mb2G5EY66msUZvSZoPuumpYE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywro/Ph/SCgC5Vyg/+Tf/EAyAcKnkIPbLGl9UkG6eGnO9wSPgCk
	rrOVPkmFnc03nM2mHhRaKhF9qHSbpookWJpyVvHuykkM7cRrhwRSIXraoGv9IQirS7PDBoyYRUO
	4HQaj6SjOVbUhWn7RTIrFfJby+mNvuw9k03OkpDQ+U1vKThFVFbOmVns7qyR3Z8hpw5hHed8=
X-Gm-Gg: ASbGncsUUZnNnOyZyOX4YXh9Wh2d24uXxWFrf3tDZ7lqTt6rgZ3P1SjsVSYUlftARAl
	dgdhxhiHviEFaJDoFBPMDvmGduVvafdLF4zweQVIUtRf5JR7rjCFwvHQ/M5Si4TmyJaK7qU+g/g
	tzgqidFRNO46NRBkzL8zjuP/oZ2/RDE8IbxhGb65ZS5WioD7UGK6QEivqcOSDofGTrcUqqqGK1d
	jiH4A5Qv+v4f2Wk/+Gz0r9IUCsA30njwHfyAlaaKsp2NrWPc+wE929O5c/vQuKItrCE/lbHPpAJ
	3VWDFmKbchgBoD26e4CuOXTo5eYQvHTD+czo6lB8AsLN3XU8yt2i01PwDXSBxGekCkCg1+AfQv+
	UR9EZBreQtOoYyFrbzB2EyYxox0uPyD9R51SHyNVME4B04xIQDbHR6xPmY6192UnoZGk6
X-Received: by 2002:a05:693c:2a09:b0:2a4:3593:c7d1 with SMTP id 5a478bee46e88-2a4abadfd9bmr420853eec.17.1763091529477;
        Thu, 13 Nov 2025 19:38:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBih7Mht4+enNunC0YOwy9e/fKbrdtOHYPaIbEUPGCInd8JEQjQFhYdCZ+tdObyIg/hJHBCw==
X-Received: by 2002:a05:693c:2a09:b0:2a4:3593:c7d1 with SMTP id 5a478bee46e88-2a4abadfd9bmr420846eec.17.1763091528757;
        Thu, 13 Nov 2025 19:38:48 -0800 (PST)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885eesm4788886c88.1.2025.11.13.19.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 19:38:48 -0800 (PST)
Date: Thu, 13 Nov 2025 19:38:42 -0800
Subject: [PATCH v2] tee: qcomtee: initialize result before use in release
 worker
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-qcom-tee-fix-warning-v2-1-915a460e7d21@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEKkFmkC/4WN0Q6CMAxFf4X02RI2RMEn/8PwsLACTWSTDVFD9
 u9WfsCXJqf39nSDSIEpwiXbINDKkb0T0IcMutG4gZCtMOhCV0qpAufOT7gQYc9vfJng2A1Y2qq
 256PR2tYgp49AEu/aWys8clx8+OxfVvXb/hGuChXa5qT7punLurJXH2M+P81d2lMuA9qU0hdZA
 Kt8vwAAAA==
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: pXw51BYvz4BDk5or0Q545lsI0XW8PpGi
X-Proofpoint-ORIG-GUID: pXw51BYvz4BDk5or0Q545lsI0XW8PpGi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDAyNyBTYWx0ZWRfX8oIAUUtj3sq/
 MoFdr+FgtZftJTzGm+kBzfbz4ACPmCjPrfHvX8OVKo4MvfnZea5iMHse91GQetsVRTV6LXNtTB+
 ZbowOVsm/ZopvYAawGNCnSSkZJh3qO7OIU43avePGhPeTT9TUaNZRPOKEP4g6l2G+pBjKsPZVoh
 feBF/jp968tGIGTEpx0Lu4U5a/G23Zyk/+ujlKZE8G14JWPvg1TMXNjbSlF1kPHJhuyUYMjn20l
 Bv3ImkG1LcYI4jKkSmIkVJQgRDkYq+qsnsWYrQDHSvJT7I4t0mgVJdS11Efvjt5Bgq3/45vFQIR
 KGvg6iZG6P4szTb02h4cyjan2Yb+jRck7OmVGcUjYobHPzeqVZs3Y2Y0DjY1mMRhl92VVw69ieQ
 iBL1fFuv2vCPZoF97+CsSnzrF6jAtQ==
X-Authority-Analysis: v=2.4 cv=IM8PywvG c=1 sm=1 tr=0 ts=6916a44a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=u3OCN9FIZgIKTxxdmMwA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140027
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C2633F808
X-Spamd-Result: default: False [-4.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.198:received];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[205.220.180.131:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: EXMJLTKXMKGMYIKFWEN4GY3IXYEBAYAJ
X-Message-ID-Hash: EXMJLTKXMKGMYIKFWEN4GY3IXYEBAYAJ
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EXMJLTKXMKGMYIKFWEN4GY3IXYEBAYAJ/>
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
Changes in v2:
- Update subject to tee: qcomtee:.
- Link to v1: https://lore.kernel.org/r/20251110-qcom-tee-fix-warning-v1-1-d962f99f385d@oss.qualcomm.com
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

