Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09283CA5FF0
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:41:05 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3A7F445503
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247264;
	bh=UKYF1Og4Vz+WxeHfwBfZQ6vSg+Kni5tFAwmpFfkJuwg=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=I2W9a6a2v6JGnjziQf8luubckQMQ16ExfFBCD4Z3i13fjTPXak/zoGPfT5ca6N8TV
	 wJAQKKACuS3S43j7Or1ypxoPxGPhgmsK5A0U1XHuLAlABtbf0zo/isl7d0BmukGbCZ
	 mi2nnbt0HEhVHcttnYtbROzM5EtU2/DxI924/iL3UraIU06df3A+tCqGKV3FvB22M4
	 cF/xrPDAcVR7TODPL8ReeFb8pGljGLyl/SUhIEbjfym8n5O1PtwzzZprGdq5HeATNW
	 QmInbi6zolwceDoEeh630WFRRVyFm8ecMnImrLc7D6B+oDLJHhIJdz4dXKQ6cNdnwD
	 gzfqG38EsqAzg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2DF99453E0
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:39:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XnRzPLbz;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KhTNOq6i;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KMtQp3432250
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UT6/LgbQ84gg7JdNvYtWI1MKaXQPn5nkwRzW24Ft4bU=; b=XnRzPLbzYGAyhNNK
	8oJ0BI6FD4zhJ8TwZSW6CtkUFgha5OAuVxKPfVuCqEjnbLPUx3OXde9cTMZjrsDc
	ygPfxkmj5ZlNO1Ts0DeJn3c8nskgY/IDD76SupzCWtwwJ9fyAmxL+y8U1hvgxjnw
	RQ59SYlXSo5y2PudbD+x+JLYIBtldHCB2Mu2TNR9bMnOHerev3YXOLE8jgQyjPex
	lfC/xkPhsev1nlQWyjr28WEbQDzkxKI4eKLL94rW2gax3pUjAAfJveDLt46PyCag
	409P26zseDmFMfKI7r8QAJFSSmYORxR4ze89zOJo+9iScLmPEeAFToFxTxa9uCZm
	AJFrQA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvty16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:39:57 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-34ef0362d95so4364856eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247196; x=1791851996; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UT6/LgbQ84gg7JdNvYtWI1MKaXQPn5nkwRzW24Ft4bU=;
        b=KhTNOq6i0MswTN04xSP4ubSk/wsGXdz79fqaABL+V8Te+3SHUBxEE9WZZuX0jF/Qir
         MfU9E4WMmtrJhZ3DeatZPSEoJatv8d73/F2OKfjC2XkkJuZQsWZbAifvQ58/OyEgOw1B
         3WR5Ivy0/Y+wHJj8Ed+vz6ZK/8muM7yHYCwuI67dmOK+MFqSO6GDV52i2rj5JqTHvwDl
         WGkmPq92x7PKrVXr6cU1TYI5ACdGIC3bl1IswO2cvHiWMMzoJKh3er25nD/RU+4nqk/G
         vnmJAm/ZnS/LwBzz/txCBaG423HK5IoointQjMX1dcIcZqOWjQ1uewxtP5gE/AARVStr
         tQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247196; x=1791851996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UT6/LgbQ84gg7JdNvYtWI1MKaXQPn5nkwRzW24Ft4bU=;
        b=RulXvzzzkxikdX10r8lFRK0RexJDCVgKBuQvBNqtad3YkSkarBYyd0IIlRzNJMvQ5M
         AKalknv2mCb9iDOB6i1lMsJ6ceb0R1M6d34pgBA74zm++gWyMgPzlLMQ6oiqRjMxYOOt
         +44neKQeMCCiCklKWkU7y2jnd5FfQKb/jodJOLRfyZiJSa7oqmFk1IXE4iY4mVMTtTQg
         3zbqMmozPp6YF355g8f+lbpdJq2yOwAgkVNApILOqkgkpTdUyfUWr13YtDqqjyOUkgsX
         4ZoEJqDJt54YbAwrRnmwICo9KVTl/pbDZBOjUbO8UL9RES94XP4K0XEHvIYqrXm6LEuK
         7NEw==
X-Forwarded-Encrypted: i=1; AKwUvBzKCDLXoJqMmN2ttuqCaY8sqPVR2YHdYciyWvTs3Viwzwye5gZg2HHQ15dhC4FDBUsSfX8SiN8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLSyttDhD9jQKklHh+jb1Y29+2S7VxFDoFXW0px6fsmM5IgTJVn
	ku6+Z3pwql49I82w2g5lFSORDy0R2mb7mIQLiXC1OSM9FcpaUwOZJfRZlhrdE8kpCa1wFJ7mX9Z
	38fG9Hw/zG4tJlpZ7c3BRofnlqO4QHS60X/OVj0Ody9as0tpykv9YKQhyfIt+EuIc1VR03z0=
X-Gm-Gg: AYBFou2wx4EbwuXlOnm32vcclQ5xdTosFuyBqV3Lrot3HxflLawYBZ2uluJUwKIPxhb
	mj/ngMzJUteTRJIN9iB9c0rhbxPMPKeWRfYyxlNkKSVYwthS7yK+lBgm0ucXVzda7HSCIgP4v5/
	mNzULSqZVI6qAATa2VyNwchs7w2a6CrbW6Ymw1vz/+DMfFccOX2lCnWq85BaBG88GWOQBRDidP0
	vZ5zTvDKfkYxhZZeZBQTVycFaIylFJUlIcP7vZ5t3vais5jWIf4Ssrn6hm1oq+0K2wWYQlmTY7O
	QCDEqwJax6WalnNGXlol0tyWgtB4VojmwJ5/e8JWesjavI2Y/pwm+gh2QNCdK8ZbKQyXia4MyrK
	2Qjaja7MLDZqretfpBKiaGVk9MKlVT7qcaqfXYelM4Bve6atonZSX4dfVjQ==
X-Received: by 2002:a05:7300:c7c9:b0:351:27c9:14de with SMTP id 5a478bee46e88-35127c915c2mr6639617eec.24.1791247196277;
        Mon, 05 Oct 2026 17:39:56 -0700 (PDT)
X-Received: by 2002:a05:7300:c7c9:b0:351:27c9:14de with SMTP id 5a478bee46e88-35127c915c2mr6639579eec.24.1791247195384;
        Mon, 05 Oct 2026 17:39:55 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:39:54 -0700 (PDT)
Date: Mon, 05 Oct 2026 17:39:46 -0700
Subject: [PATCH RFC v2 2/8] tee: optee: define the RPMI control and
 parcel-reference ABI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-2-72f222e23ec1@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac4435d cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=G3s93uPkn6CA8LbIO-UA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: AorAyJaSRaMmOmrL_YKjkGeW-xTN5o_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX20pjn5f9WJPJ
 ZL2MHOGkVlMm6+AzThbauEIzrhZpxCWb7fRWzewFSE8mo2iMrppI6zLEP1RjwJlbj4c0DZ9EYE/
 Lzsts6hmZaaIPUIXJEoSM/szitGlSEaFKBXzj+nfsmPdhdY3eFU4F1H9SN3iAlN6LlPMrf/yps8
 rDycaKf+HZN3T98DOwlsTqxzIQJBYm4sG1emuzT8KV+88Q39clfi3PP8Iykho4E7MM8ZOLrbCeq
 XzoCjm/wzVtKGxl6iBUJRgCYtJN5Y8d/aIC/v79gSRab+L+9dGoPuFBWSnIJ3exn9kQici+wrFp
 vfhVtGCw2s6a9RyKjyzIGB55AvAoBOg5abJEhZQ4qcq7Hf085rsZtTB11FDw2tY1cGMR/To2Azv
 Dp/GfDdKX4hbxFdxtDcUmBhvXB+IgCDBfgoN8Jv0GT+9ROIzsuibPxECj3NbjUNQhr0CA4XQ2JJ
 lEUPMBxn0G4gnvvgOdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX2VdbCT/AHCXF
 y77HYUENCjj3q0p8c0on+K+CeTQT+pQLDAmYt5uXndGfEq1LTAmBLETNs3wAo3XFFfQBQWEnihs
 A7ygMqFaJ/dV7VeinkRLplnK33L0jFc=
X-Proofpoint-ORIG-GUID: AorAyJaSRaMmOmrL_YKjkGeW-xTN5o_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060001
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
X-Rspamd-Queue-Id: 2DF99453E0
X-Spamd-Bar: -----
Message-ID-Hash: 2XJHXIAZZQIJQQHQBVCPJCWPE63Q2OYA
X-Message-ID-Hash: 2XJHXIAZZQIJQQHQBVCPJCWPE63Q2OYA
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2XJHXIAZZQIJQQHQBVCPJCWPE63Q2OYA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Define the OP-TEE service protocol carried by RPMI TEE_CALL payloads.
Add operations for version and capability queries, shared-memory
unregistration, asynchronous notification enablement, and yielding-call
start and resume. Use fixed-width little-endian control fields and RPMI
error codes for control responses.

Add a parcel memory-reference layout to the common message parameter
union. Identify shared memory by its parcel ID and nonce, with a 64-bit
byte offset and size, without changing the message parameter size.
Encode NULL references with a zero parcel ID and nonce, leaving parcel
ID zero usable with a nonzero nonce.

Document the wire layouts and ownership rules for matching Linux and
OP-TEE implementations.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/optee_msg.h  |  38 +++++--
 drivers/tee/optee/optee_rpmi.h | 234 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 264 insertions(+), 8 deletions(-)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 6c3043f8da33..028f8cd95fdd 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -31,6 +31,9 @@
 #define OPTEE_MSG_ATTR_TYPE_FMEM_INPUT		OPTEE_MSG_ATTR_TYPE_RMEM_INPUT
 #define OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT		OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT
 #define OPTEE_MSG_ATTR_TYPE_FMEM_INOUT		OPTEE_MSG_ATTR_TYPE_RMEM_INOUT
+#define OPTEE_MSG_ATTR_TYPE_PMEM_INPUT		OPTEE_MSG_ATTR_TYPE_RMEM_INPUT
+#define OPTEE_MSG_ATTR_TYPE_PMEM_OUTPUT		OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT
+#define OPTEE_MSG_ATTR_TYPE_PMEM_INOUT		OPTEE_MSG_ATTR_TYPE_RMEM_INOUT
 #define OPTEE_MSG_ATTR_TYPE_TMEM_INPUT		0x9
 #define OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT		0xa
 #define OPTEE_MSG_ATTR_TYPE_TMEM_INOUT		0xb
@@ -149,6 +152,23 @@ struct optee_msg_param_fmem {
 	u64 global_id;
 };
 
+/**
+ * struct optee_msg_param_pmem - RPMI parcel memory reference
+ * @offs: full-width byte offset from the parcel's first byte
+ * @size: logical reference size, or required size for a short-buffer response
+ * @parcel_id: firmware-assigned parcel identifier
+ * @nonce: nonzero REE nonce supplied when sharing the parcel
+ *
+ * A zero parcel ID and nonce encode a NULL reference. Its offset must be zero;
+ * its size is preserved. Parcel ID zero remains valid with a nonzero nonce.
+ */
+struct optee_msg_param_pmem {
+	u64 offs;
+	u64 size;
+	u32 parcel_id;
+	u32 nonce;
+};
+
 /**
  * struct optee_msg_param_value - opaque value parameter
  * @a: first opaque value
@@ -166,18 +186,19 @@ struct optee_msg_param_value {
 /**
  * struct optee_msg_param - parameter used together with struct optee_msg_arg
  * @attr:	attributes
- * @tmem:	parameter by temporary memory reference
- * @rmem:	parameter by registered memory reference
- * @fmem:	parameter by FF-A registered memory reference
- * @value:	parameter by opaque value
- * @octets:	parameter by octet string
+ * @u.tmem:	parameter by temporary memory reference
+ * @u.rmem:	parameter by registered memory reference
+ * @u.fmem:	parameter by FF-A registered memory reference
+ * @u.pmem:	parameter by RPMI parcel memory reference
+ * @u.value:	parameter by opaque value
+ * @u.octets:	parameter by octet string
  * @u:		union holding OP-TEE msg parameter
  *
  * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used in
  * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value or octets,
- * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @tmem and
- * OPTEE_MSG_ATTR_TYPE_RMEM_* or the alias PTEE_MSG_ATTR_TYPE_FMEM_* indicates
- * @rmem or @fmem depending on the conduit.
+ * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @u.tmem. OPTEE_MSG_ATTR_TYPE_RMEM_*
+ * and its FMEM/PMEM aliases indicate @u.rmem, @u.fmem or @u.pmem depending
+ * on the conduit.
  * OPTEE_MSG_ATTR_TYPE_NONE indicates that none of the members are used.
  */
 struct optee_msg_param {
@@ -186,6 +207,7 @@ struct optee_msg_param {
 		struct optee_msg_param_tmem tmem;
 		struct optee_msg_param_rmem rmem;
 		struct optee_msg_param_fmem fmem;
+		struct optee_msg_param_pmem pmem;
 		struct optee_msg_param_value value;
 		u8 octets[24];
 	} u;
diff --git a/drivers/tee/optee/optee_rpmi.h b/drivers/tee/optee/optee_rpmi.h
new file mode 100644
index 000000000000..252216aad09b
--- /dev/null
+++ b/drivers/tee/optee/optee_rpmi.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef OPTEE_RPMI_H
+#define OPTEE_RPMI_H
+
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+
+/*
+ * OP-TEE service ABI over RPMI TEE_CALL.
+ *
+ * Requests and responses are carried in the TEE_CALL service payload.
+ * Control fields are little-endian. Response status fields contain signed
+ * RPMI error codes, distinct from the outer TEE_CALL status and the GP
+ * command result in optee_msg_arg.ret.
+ */
+#define OPTEE_RPMI_SERVICE_UUID \
+	UUID_INIT(0x486178e0, 0xe7f8, 0x11e3, \
+		  0xbc, 0x5e, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b)
+
+#define OPTEE_RPMI_VERSION_MAJOR		1
+#define OPTEE_RPMI_VERSION_MINOR		0
+
+/**
+ * struct optee_rpmi_probe_req - request without operation-specific arguments
+ * @op: GET_API_VERSION, GET_OS_VERSION or EXCHANGE_CAPABILITIES
+ */
+struct optee_rpmi_probe_req {
+	__le32 op;
+} __packed;
+
+/**
+ * struct optee_rpmi_status_resp - response carrying only an RPMI status
+ * @status: signed RPMI error code
+ */
+struct optee_rpmi_status_resp {
+	__le32 status;
+} __packed;
+
+/*
+ * Return the service API version.
+ *
+ * Request:  struct optee_rpmi_probe_req
+ * Response: struct optee_rpmi_api_resp
+ */
+#define OPTEE_RPMI_GET_API_VERSION	0
+
+/**
+ * struct optee_rpmi_api_resp - GET_API_VERSION response
+ * @status: signed RPMI error code
+ * @major: incompatible protocol revision
+ * @minor: compatible protocol revision
+ */
+struct optee_rpmi_api_resp {
+	__le32 status;
+	__le32 major;
+	__le32 minor;
+} __packed;
+
+/*
+ * Return the trusted OS revision, not the service API revision.
+ *
+ * Request:  struct optee_rpmi_probe_req
+ * Response: struct optee_rpmi_os_resp
+ */
+#define OPTEE_RPMI_GET_OS_VERSION	1
+
+/**
+ * struct optee_rpmi_os_resp - GET_OS_VERSION response
+ * @status: signed RPMI error code
+ * @major: trusted OS major revision
+ * @minor: trusted OS minor revision
+ * @reserved: must be zero
+ * @build_id: trusted OS build identifier, zero if unspecified
+ */
+struct optee_rpmi_os_resp {
+	__le32 status;
+	__le32 major;
+	__le32 minor;
+	__le32 reserved;
+	__le64 build_id;
+} __packed;
+
+/*
+ * Query secure-world capabilities and limits.
+ *
+ * Request:  struct optee_rpmi_probe_req
+ * Response: struct optee_rpmi_caps_resp
+ */
+#define OPTEE_RPMI_EXCHANGE_CAPABILITIES	2
+
+/**
+ * struct optee_rpmi_caps_resp - EXCHANGE_CAPABILITIES response
+ * @status: signed RPMI error code
+ * @secure_caps: reserved for future optional features; zero in version 1
+ * @rpc_param_count: nonzero parameter capacity of each RPC argument buffer
+ * @notification_count: nonzero logical key count, including synchronous keys
+ *			Keys range from zero through notification_count - 1.
+ *
+ * Version 1 defines no capability bits. Unknown bits are ignored by Linux
+ * for compatibility with future extensions.
+ */
+struct optee_rpmi_caps_resp {
+	__le32 status;
+	__le32 secure_caps;
+	__le32 rpc_param_count;
+	__le32 notification_count;
+} __packed;
+
+/*
+ * Unregister a shared parcel from OP-TEE.
+ *
+ * Request:  struct optee_rpmi_unregister_req
+ * Response: struct optee_rpmi_status_resp
+ */
+#define OPTEE_RPMI_UNREGISTER_SHM	3
+
+/**
+ * struct optee_rpmi_unregister_req - retire a shared parcel in OP-TEE
+ * @op: OPTEE_RPMI_UNREGISTER_SHM
+ * @parcel_id: parcel to retire; zero is valid with a nonzero nonce
+ * @nonce: nonzero nonce associated with the parcel
+ *
+ * Success means OP-TEE stopped using the mapping and released its receiver
+ * interest.
+ */
+struct optee_rpmi_unregister_req {
+	__le32 op;
+	__le32 parcel_id;
+	__le32 nonce;
+} __packed;
+
+/*
+ * Enable asynchronous notification delivery.
+ *
+ * Request:  struct optee_rpmi_enable_notif_req
+ * Response: struct optee_rpmi_status_resp
+ */
+#define OPTEE_RPMI_ENABLE_ASYNC_NOTIF	4
+
+/**
+ * struct optee_rpmi_enable_notif_req - bind an incoming RPMI doorbell
+ * @op: OPTEE_RPMI_ENABLE_ASYNC_NOTIF
+ * @signal_id: allocated TEE-to-REE signal, not a logical notification key
+ *
+ * Success activates delivery and raises the doorbell for pending work.
+ * Raising the signal requests OPTEE_MSG_CMD_DO_BOTTOM_HALF.
+ * OPTEE_MSG_CMD_STOP_ASYNC_NOTIF stops future doorbell generation, but does
+ * not drain already-raised signals or release the signal ID.
+ */
+struct optee_rpmi_enable_notif_req {
+	__le32 op;
+	__le32 signal_id;
+} __packed;
+
+/*
+ * Start a yielding command using shared command and RPC arguments.
+ *
+ * Request:  struct optee_rpmi_call_req
+ * Response: struct optee_rpmi_call_resp
+ */
+#define OPTEE_RPMI_YIELDING_CALL_WITH_ARG		5
+
+#define OPTEE_RPMI_YIELDING_CALL_RETURN_DONE		0
+#define OPTEE_RPMI_YIELDING_CALL_RETURN_RPC_CMD		1
+#define OPTEE_RPMI_YIELDING_CALL_RETURN_INTERRUPT	2
+
+/**
+ * struct optee_rpmi_call_req - start a yielding command
+ * @op: OPTEE_RPMI_YIELDING_CALL_WITH_ARG
+ * @parcel_id: argument parcel identity
+ * @nonce: nonce associated with the parcel
+ * @flags: zero in version 1
+ * @arg_offset: command argument byte offset from the parcel's first byte
+ * @rpc_offset: RPC argument byte offset from the parcel's first byte
+ * @arg_size: command argument extent in bytes
+ * @rpc_size: RPC argument capacity in bytes
+ *
+ * Firmware validates ownership, RW access, alignment and disjoint ranges.
+ * RPMI_ERR_BUSY rejects an initial request without acquiring call ownership.
+ */
+struct optee_rpmi_call_req {
+	__le32 op;
+	__le32 parcel_id;
+	__le32 nonce;
+	__le32 flags;
+	__le64 arg_offset;
+	__le64 rpc_offset;
+	__le32 arg_size;
+	__le32 rpc_size;
+} __packed;
+
+/**
+ * struct optee_rpmi_call_resp - yielding command response
+ * @status: signed RPMI error code, distinct from the command's GP result
+ * @result: OPTEE_RPMI_YIELDING_CALL_RETURN_* value when status is success
+ * @resume_token: zero for DONE, nonzero opaque token for a suspended command
+ *
+ * DONE releases all access to the call's argument and RPC ranges. RPC_CMD
+ * requests RPC command handling; INTERRUPT requests resumption without an
+ * RPC command. Tokens belong to one accepted call, service and caller.
+ */
+struct optee_rpmi_call_resp {
+	__le32 status;
+	__le32 result;
+	__le64 resume_token;
+} __packed;
+
+/*
+ * Resume a suspended yielding command.
+ *
+ * Request:  struct optee_rpmi_resume_req
+ * Response: struct optee_rpmi_call_resp
+ */
+#define OPTEE_RPMI_YIELDING_CALL_RESUME	6
+
+/**
+ * struct optee_rpmi_resume_req - resume a suspended command
+ * @op: OPTEE_RPMI_YIELDING_CALL_RESUME
+ * @reserved: must be zero
+ * @resume_token: token from the preceding response for this call
+ *
+ * Resume must not return RPMI_ERR_BUSY.
+ */
+struct optee_rpmi_resume_req {
+	__le32 op;
+	__le32 reserved;
+	__le64 resume_token;
+} __packed;
+
+#endif /* OPTEE_RPMI_H */

-- 
2.34.1

