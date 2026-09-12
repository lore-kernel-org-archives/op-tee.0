Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C617BC79FB6
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:16:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 24578452B7
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789208194;
	bh=nbmyEVTc4+Ww2tjJ+SxB0dnh0CfPx4aQRKXHop6+iNc=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=f2jufUH5avTnI5OWtIROZDkC7YulEVJZkBm3EaADrKAcpde2d3/ASrKSlfNG8pDFJ
	 atUzLVLBuXptcORraqhXrb7UHXtqYQo9nitZlxjBsf9JSWIAnCBAmHXSm+6OZ8+CMT
	 VNlrLWsY1K21h4UXp9hS+zu6B79LBXAEJi31nDj0hKLUGsrMnfObt/CV0Y3O2xSfe2
	 gvp0WSWlfGVEOMDVFVLWJCuzuc0u3HJtsC92UqKv3oGQPCtveK4F5ynlFDwnO3n0gK
	 3aK68ZjgZMCqaWh0Hu43e3lML1LCwPDP4EG416DjPE5ScbqPXhwNzLvRX+w6cquMee
	 D/F0CxsZ4gnWA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CB4CA443EB
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IKhV9cEw;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EvZMiPBV;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C85Bdr2833070
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zIuGB8S7sRqJtqaXIx6R8EAbbBn7m6GmghtV+o0/jPY=; b=IKhV9cEworVEOEwW
	gk6s/AjMqe1VEHdXDf6OW1iibkSxE39kSVan21oa2dvnbSCWnDHoIjrQ2diJxQmY
	YxfYT9yfzY6U1+a1grvJUlkzeWwZnosPxX0ZE3OXoZXOfNTyBrvl4ZqLW5Y3Z/h0
	ggOEKIPlLrs2YU2oGI0YSBvre/dgljMoYrgeDJ60MHeN8pun6EP8vvXA65/a6z72
	rVrsmCe963u+12MIiYuQY3RSPDsIrakxpNh6jN+rfpMynrU5paHAavftKC24lJ74
	mnlPtLyAdqvKVO6/EV0/XjcgW+F6b3rLapZ2viLj5AiLF8JJxN5sOGsGOWrVohf+
	JDl3Aw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgpyc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd188e16a2so21117705ad.2
        for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789208132; x=1789812932; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zIuGB8S7sRqJtqaXIx6R8EAbbBn7m6GmghtV+o0/jPY=;
        b=EvZMiPBVnqjdixeE4bxske8uosh9mBShO50iqVgA//3HFoeiQp8V0o9kQ+WzpWUlX3
         BZwRiy9pSiM9s7xegi/VmJuM6Z7qa2bHCjqWgIkipEfO8NdaFuODJwsi689lOAfVw3HW
         5bQg1VzYSP27wl+o3blRYQnx43HhmK1wtCD9hdzBH33g3vwmhltU8sI8HaijkO9Uqgse
         /XfHzrTJOsB6whUcH5DQ7AC3Nr8Qn5UO6BPsMtVpRLs9ubzpi6wwG8luXMWj+QlHQ/uc
         5xk/Tp1E8V9GTnkG4XcyvRq5Da4OOhTlru80/gQQjCa4u3nqTe2Kpy+RnWF/4Yiug9w5
         0lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789208132; x=1789812932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zIuGB8S7sRqJtqaXIx6R8EAbbBn7m6GmghtV+o0/jPY=;
        b=lbxtD+DUZHD/LA04Lsmb5iFz65HapaFrnw1k9JNn0yVkJ9XUoaqtS6CASqernJwHg6
         VgtSfPeIl0cmZVQSd0Vl9t6GgDhwQeH+zxySJ0RDFtOnYEqSsWPcL+2sjGn/9YYkBIRB
         hPe2WY2vQyhigH3TOsqjCBD0ttrGu1/pO55VT7iyEv2YUlElgsJMxYLccRWb2PMHNVhV
         eTlL44aAB+L5qhpEyjIK3CBO2tMuUmY+uCLngwqHCcdTGt5r4KiGHJYXlmQZtl6tZte9
         SKnAKcp7iwIC1COhMyfCH0bLnJXGpdkNwRw9QRoeptyzdl+hFJORdr0YygJrDPgHTKyQ
         a8TQ==
X-Forwarded-Encrypted: i=1; AKwUvBy4qZ8ZVmsPyzpGCX4n7bHRdrz5/SdZIGAu7BsB2oqebIWivYXHVEWhqLCYQXEmwAsQReowVF0=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lPMvyE3mTrGgqAyhlk4rG46JUeeYaNjcJxc0f7m/B+z4StmrGL
	+7dD2ZN/pR30X1M4JWZquv2h4Yv0nvhVVgepWKa29lXs/zbAqIVUwVaRBa9P2D/foo8LV+Lq8Pt
	6gZTe1JTkfrZrHBacIXzguGK3vH0NzPCsIRue7an+V6fzujOKMRjsgpju+JQigxwEkWiBXNw8GJ
	q8CQFurg==
X-Gm-Gg: AYBFou05GCjh+4zGNz5VgfcNqfpFT8Ad0IaIQQR4LJ2fhB55nWBhjEwynAfrIxpPn7V
	pLFFPYZEEk70lpESBZI+jQxy2gCUny4un0j687LvBaTn57Hodue4gGJsDQubQCVgEh+a8wcespF
	0BA7qZ21+vKbWNh2UhvFmgTZWZD67ob2aZ0JyyiOFrQaBjxzHDvzXfjyLaroiKYz6ha/uUfM0Si
	QK5sUK7pXbEosYu3WEIjNfdn9tqqB6uSyISwrMDDrAwoS0LYn1PNI73Io9+5h09vFSSVx9fXRDP
	9iFYpYyR5v+g3HNkC3dga288nyV4UK+zdbITPnNHTZySaOEWYQ1k+k22zdRZOf0cLDVxjr6sqX1
	nI3NlPVc5y4svC4rqhGvJ6qqduqH41ZVVHpu08yuLDBYZG2LFlFa8ctSyaoA=
X-Received: by 2002:a17:90b:52cd:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39dbc699006mr4249283a91.14.1789208131975;
        Sat, 12 Sep 2026 03:15:31 -0700 (PDT)
X-Received: by 2002:a17:90b:52cd:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-39dbc699006mr4249221a91.14.1789208131506;
        Sat, 12 Sep 2026 03:15:31 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm10340085eec.8.2026.09.12.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:15:30 -0700 (PDT)
Date: Sat, 12 Sep 2026 03:15:14 -0700
Subject: [PATCH RFC 3/5] optee: riscv: enable persistent shared argument
 cache
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-rpmi-tee-service-grp-dev-v1-3-1d1d35c2a859@oss.qualcomm.com>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
In-Reply-To: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfX9fB8ENXmvjEM
 NXHptoEiHLeE1EsMZybRarF4aaYYsw1PWgFigfFqv7jpA7cdv9cXM8WyKgXBHebQkhLQvwevSqn
 AAMFpAi5HDN7bon0mHY9QEZ0Githw890yHEnqo3hfM6YhUB/4ebJxFrVIP1l2+9rIUsw1Y2z+U7
 hA9c5pYdH4XfsN8WQIXbjSweWeCzsraRFPONvJ54GBmAmNIZxdqOKx8LaGqTOu6Cs2X5OHa87K4
 KdfCcuh1dGefQhskqR3vCWpYNXiVR6InI3PoF8jbBm6BnahPkV1ZtCBP7SdcuxBiiNYWAwFlOIx
 higrpMBz+oTZZLW7+OlTwjwW4o82XCnfufc9D+35NDnANoRFzGazwYjhHXO404zb039bFdr0nAi
 l01XgqnxVt6n7AnpqIFnsBxYh+pu2H76W9RdRK9pR6bAlDvzbG/aD8jHlctIp7cH2EJnR5D64aQ
 y6DKhNPrjYUcEORFSKA==
X-Proofpoint-ORIG-GUID: S3zxqvChRAWYXpBuQ_hAJcuytUKILQM-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfX21KvTVhqUOZx
 6sm8+4Zf5HHFtatfGDSF771YXjdtrKrnitgWTtK1TcOEx2MPpO0FVL+OahiVHEOyMKJDAvc02Gn
 GDyne7zdqrSmgqji2MkbGvfW4HywXfA=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa52644 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=hYfsqUzT0y0sb8bvQO0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: S3zxqvChRAWYXpBuQ_hAJcuytUKILQM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	URIBL_BLOCKED(0.00)[oss.qualcomm.com:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.197:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CB4CA443EB
X-Spamd-Bar: -----
Message-ID-Hash: SXBIRCW2NHG7PVP3LE47EK4CGYZFVNAA
X-Message-ID-Hash: SXBIRCW2NHG7PVP3LE47EK4CGYZFVNAA
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SXBIRCW2NHG7PVP3LE47EK4CGYZFVNAA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Use the OP-TEE shared argument cache when secure world advertises
OPTEE_ABI_SEC_CAP_ARG_OFFSET.

In this mode the argument structure can reside at an offset within an
already registered parcel-backed shared-memory buffer, allowing the same
buffer to be reused across calls instead of creating and reclaiming a
parcel for each call.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/optee_riscv.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/optee_riscv.c b/drivers/tee/optee/optee_riscv.c
index 36115326486d..72c9eb85f4fe 100644
--- a/drivers/tee/optee/optee_riscv.c
+++ b/drivers/tee/optee/optee_riscv.c
@@ -1149,6 +1149,7 @@ static int optee_riscv_probe(struct platform_device *pdev)
 	struct tee_device *teedev;
 	struct tee_context *ctx;
 	struct mbox_client *client;
+	u32 arg_cache_flags = 0;
 	struct optee *optee;
 	u32 sec_caps;
 	unsigned int nr_cpus;
@@ -1219,6 +1220,15 @@ static int optee_riscv_probe(struct platform_device *pdev)
 		goto err_free_channels;
 	}
 
+	/*
+	 * If OP-TEE can read the argument struct from an offset into a shared
+	 * memory buffer, cache and reuse one buffer across calls instead of
+	 * creating a fresh parcel per call. This is the persistent pool that
+	 * matches the FF-A OPTEE_FFA_SEC_CAP_ARG_OFFSET path.
+	 */
+	if (sec_caps & OPTEE_ABI_SEC_CAP_ARG_OFFSET)
+		arg_cache_flags |= OPTEE_SHM_ARG_SHARED;
+
 	pool = optee_riscv_shm_pool_alloc_pages();
 	if (IS_ERR(pool)) {
 		rc = PTR_ERR(pool);
@@ -1266,7 +1276,7 @@ static int optee_riscv_probe(struct platform_device *pdev)
 	atomic_set(&optee->riscv.next_nonce, 0);
 	optee_cq_init(&optee->call_queue, 0);
 	optee_supp_init(&optee->supp);
-	optee_shm_arg_cache_init(optee, 0);
+	optee_shm_arg_cache_init(optee, arg_cache_flags);
 	mutex_init(&optee->rpmb_dev_mutex);
 	platform_set_drvdata(pdev, optee);
 

-- 
2.34.1

