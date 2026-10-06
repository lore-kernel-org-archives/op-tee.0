Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D7ACA5FF0
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:42:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 458BC45426
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247325;
	bh=m/Jg1IBzk1GaLMkEQ8ygyVkVct/4HGDOSskLv6CeLfk=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=mVuGOTVVz/m5Z3iyO3LT2fDUoNTG1bvMJBbwQiMsHnwOh8BxCbVQvDIllvbFy4nz9
	 HoLkmj0rvarEyw6QIsT0UdW2XMl0EfFNlR0jbYcpkiIQ/48+2bJZswia/Fo/bHKN6A
	 OwE6Paxf4LsWjcbDhErR13/dYpYFZfKg+Hrya3b8Z5brn/17iq+GZOY1/V/KYcMB7h
	 oOD0MEmyBIECLwum692PDssBsqSEEq1qH302VhiF7FneWbQUEFJX4pzfGFaGpo3tiT
	 cQTELY0nF2xwFjA678ixTEWIhZKPPATAti2TZ1a2VMh88HVE0Lto7gl8oNgbhaGtml
	 GbYfCBT+5ntXA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 33C1545506
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:40:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M9Dd5gz/;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MG0ARZPH;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KN7ET3300945
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dovwb3uTuq5K59dqdz0kPhDC1qlUCkJ6dzdznEz/4J4=; b=M9Dd5gz/Nnd/BJS8
	eGnnCEQo5vqfju8HJkoU1j2kCVHwJc39UFE0Q861MvD6H/2OFRKVnDv827tH/5xh
	0bDA2y6zGz9ra0EyfcEuHc9RD492AUh5ENZ2rklBjBsIE3Zlbs+dZ2JJlBRV8b+n
	DtQgcMvBUZPwu8JBIBaD4BDddBzeK9Q107tIkZEkrhYHWZttbcuw2NSkZTltfV1+
	Y9NqoTQR6IfzZV4syo5ZIx91NhhN83n97FP7lvT0iHANX0oEIMS5o15yFkDrrD4r
	W46aznv//895zEe/3Q1bJPof8e+nvtMeinXAQhmYY/p6pkaEHclyVlOlyzXCq232
	SYGWJQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg2rat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:39:59 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so5850270eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247199; x=1791851999; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dovwb3uTuq5K59dqdz0kPhDC1qlUCkJ6dzdznEz/4J4=;
        b=MG0ARZPH0KnIg6OZi8B2nU1p4ahokSd/GPUPAw4jcKDvqTieo96WEq24Va3UfJNuN/
         bg9AEn2kIUNlG/Eo1HIRLDJnoeOXXI7oY8WzzkxLSG2TCPvUmTXAalK1WVfJltgFkHnH
         TsCzrSlxPU25Q39HTAsbFtwRtEadTUOHO1Z2qjn81g1u7bTHH3F3s7CIR3r0b0PBDhJH
         9Xoyk7mjjNAoSXrZjKFG2R4J2x7AdJl67N4mhBF/wbIMmWygLpKIa2eSoySlu+odoAgo
         sa41+fcbyu+nqJUQp2DGOHd7a53bQcbhPgiYgJiyF87j8rfcBTbGbPqdweC9LxuunnHN
         ViTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247199; x=1791851999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dovwb3uTuq5K59dqdz0kPhDC1qlUCkJ6dzdznEz/4J4=;
        b=EWTC8mkA3zvfHZ0lrsXmGI1iW4hCX5oLAhWq8R74TdiXs0tsibK7FEIry0p3wHElRU
         XDpGbxt92l9Ed7PC+/X6hGTBNAFGyiRre2W1gPQ7o71Df+JmS+he/y8uMhbTU3p4CyZk
         LFEGUmRMJB233+H82Xo/ztrWEU+VFETZzCeu2awO3hMi65myC9+Gzs2WXqQk1JdocMRG
         feKzAr1ykieVk89a9GzPxkE2MXEYAAS7XyTTuJJSCx0VfaEdnLm2qYRV0YNUfV/BDXYW
         IyDbaporeGUqZtIXIAJIAyjYSW7J5SjXQF9sDpO3WSmpNmhtag/abjSeUOyp8f78tlVH
         c1Ew==
X-Forwarded-Encrypted: i=1; AKwUvBwlilE9ktIu9ZBNIhDBGaihk/Vz1rdeOnkCxGjuIfd8+dhaYh/4A1JUdzkB+GwTcvJmwrOkPiw=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKHfY5gIlWTqiviXL5ms/eXkfypHibBYjeEKnQsUmLJOSjBZPTT
	GbbybudiLWXbQl/Ri1e3I7b9y087ZBIk6VUTr1KxhDtmA2fALrPX50/bm6osB63pH9VBiQ4XOEa
	x5+0j14dW9OIfyHXyLTNfBI0wLd3N5WgaIqXXjFDu1HwfkWhyQrfpcuDBBkEf/uUJdkAT5Yc=
X-Gm-Gg: AYBFou3+LBf5jxhZb3r5JoQTNPha1HHRP7XsKCCxSGPY76mCTp6zsusGPAJ1eVmlsUK
	jB/2j1DcJReUMyaxHoxY+LdrLm+iFl7RvrKHDhfMF/4fIkr44zwZhK/z4Q+85DAteAteeUKwZh/
	k9n1ubFBKi8fk5Vdds4xapKRVVNyoWlh+XjrayObnR/YhqwbHG6/M43ooPOxa46Z8mOjPEL8WCq
	C4u56MQGK0lkMLlBkl2h/aQHoeBjERblYMG7CP/EV5QV9nrhoB2MYuCvSuBuoFwAAU1DgCb6S4B
	CBLFL4CiQySkaVVayMpwb31N0Czgm/nCHNbTLNDF39yRUuhld127EGJGhjIpKm/aqfPxWcdiFFo
	4PzoMvN9kL+r+ngRUse6XTDzrWJJtusxxWAm0WxETMaTM4UjcMrA/W/KGwA==
X-Received: by 2002:a05:693c:8810:20b0:351:27f0:e411 with SMTP id 5a478bee46e88-35127f0e81emr6947160eec.20.1791247198251;
        Mon, 05 Oct 2026 17:39:58 -0700 (PDT)
X-Received: by 2002:a05:693c:8810:20b0:351:27f0:e411 with SMTP id 5a478bee46e88-35127f0e81emr6947118eec.20.1791247197525;
        Mon, 05 Oct 2026 17:39:57 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:39:57 -0700 (PDT)
Date: Mon, 05 Oct 2026 17:39:48 -0700
Subject: [PATCH RFC v2 4/8] tee: optee: add RPMI dynamic shared-memory pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-4-72f222e23ec1@oss.qualcomm.com>
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
In-Reply-To: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: RjqopqoAPE4OxkvRlpuZartwVl61Jx2D
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac4435f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=hYfsqUzT0y0sb8bvQO0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX5bnGbYj0cBL4
 mqLYwWWQksZRtab+mqIpHjZbEb7OX03DRRMGDmk+dQ7ZVRERZMkm4CVdV0eHCdmcpai5KWHpmF1
 8EqwO+NgagoDrxCH7N6v5/PWkpV1pUI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX+/fVsvOLbfBW
 r6UeTXJGJXXg5nc64eMqAwXal7g/5FErZNCQrQM/cPt/VJDvPNpBoWPU5fb32tmwjZGFjIP7ELb
 vHML8Rupu2eLMHslWMe4TMmmBVknU4Tz8rmQi/tQWVLqmITmZqMlVozJejsk9+Z1/Jve77ZOyGd
 6WfwQM4IhJjbgNtBUoGIASw8KQhiTk7aWfx3blKSXlCBnHN4gC3fVPy0GRHJVDrABNuEaSXOjUs
 Bbg4ZgJso+5PJCgBngUhToZPHaYsqqBxkSaGJMG8Y6LWqZV4Vt82q3ASCzhHVLH26jzqUoomMHd
 2/okiDf4y4g8rqGaxpCT0FodMHRlt+U2a1vQIku/418uNi7i/w0ZKW6MjJv5abSn06TWaUD4T0e
 YG8M0uhPFrejPgMoiNaldSHqbKGizUoiAyy2YxQis73ozq3maXJi6uUleSEZrdMxzwSFkMprH5D
 OLNSsCs4UUEDhmdEI6A==
X-Proofpoint-GUID: RjqopqoAPE4OxkvRlpuZartwVl61Jx2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[dt];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DNSWL_BLOCKED(0.00)[74.125.82.199:received];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 33C1545506
X-Spamd-Bar: -----
Message-ID-Hash: EFNQMYZDZPE5AIAMDVP6TTZ736VPI4K7
X-Message-ID-Hash: EFNQMYZDZPE5AIAMDVP6TTZ736VPI4K7
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EFNQMYZDZPE5AIAMDVP6TTZ736VPI4K7/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add a page-based dynamic shared-memory pool for the RPMI backend using
the common TEE allocation and free helpers.

Register allocated pages as RPMI parcels so OP-TEE can access them.
Unregister the parcels before freeing their backing pages.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/rpmi_abi.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index e7fc853cfb15..c29b7ac4552a 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -282,6 +282,42 @@ static int optee_rpmi_shm_unregister_supp(struct tee_context *ctx,
 	return ret;
 }
 
+static int optee_rpmi_pool_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
+				 size_t size, size_t align)
+{
+	return tee_dyn_shm_alloc_helper(shm, size, align,
+					optee_rpmi_shm_register);
+}
+
+static void optee_rpmi_pool_free(struct tee_shm_pool *pool, struct tee_shm *shm)
+{
+	tee_dyn_shm_free_helper(shm, optee_rpmi_shm_unregister);
+}
+
+static void optee_rpmi_pool_destroy(struct tee_shm_pool *pool)
+{
+	kfree(pool);
+}
+
+static const struct tee_shm_pool_ops optee_rpmi_pool_ops = {
+	.alloc = optee_rpmi_pool_alloc,
+	.free = optee_rpmi_pool_free,
+	.destroy_pool = optee_rpmi_pool_destroy,
+};
+
+static struct tee_shm_pool *optee_rpmi_shm_pool_alloc(void)
+{
+	struct tee_shm_pool *pool;
+
+	pool = kzalloc_obj(*pool);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->ops = &optee_rpmi_pool_ops;
+
+	return pool;
+}
+
 /* Convert a memory reference to an OP-TEE RPMI parcel reference. */
 static int to_msg_param_rpmi_mem(struct optee_msg_param *mp,
 				 const struct tee_param *p)

-- 
2.34.1

