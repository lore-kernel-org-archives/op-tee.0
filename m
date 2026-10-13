Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A564CC6B03
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:43:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 58F7645273
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870216;
	bh=eLOAxMM+hZwlNFVyptMKZg8I2MSmLEZ+2LGQRG5OS5A=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MMMnMXX2KlJ4SbegCjfDonmSSGmGhpguZFmoUj5p0AI1qFUY+WJ85OunlEptzIzqv
	 DNfLDO4jlGxjuGerXq8l1Yzo+1W1usxQLAcKnM9O9BFQec1ElTlwSxTNYjBJNeiZui
	 aTBRGIYrEzitt+xqwP5yoxFSMUq/EvfxwlDi8rU7zjMy0EoJsmq5pL+969Nj3gVnFS
	 cRCDBfoNZ8zqEml2plkGKT4/1ZDSAHaKxcZfkPHfiI1jy9k69ysNvzYTMAhcM5+vLD
	 eeAy7FUEhI4b/nGBEZAw6Pks+9KhoPYJjP1HpFwUJdPgCRVvHrwbi+sCMO4IJp6DXx
	 MpSnRG8ZzYlTA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0B6AA45278
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TJ7+nHzN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZHGFRU6D;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D21H9F409292
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ypuDZSakPalBX7M4x+LFJr9Z+MgpyzNsrKt1TNFFTZ8=; b=TJ7+nHzN42EAS1or
	gzAMXvBNTrwpNYzBkPt/S/D/gXxqPGlSEWDF8zFaCAU/YIZldv6yXSBoscE7w1aP
	u2ZLmR+lZSagyuMaxhEDzHfJyrzsJHQ6GTzVzqlri1qLt9imnmbR7XZ6EQlQnJ9J
	66LTK2C+KbV3HvvcL+2VIDT+nweaIhuY0yIbX5WuamFQ19K6Imr66lCmhQRZUc9V
	ajEy0NhHFfE89puJyCzzn7TohyqJ30n6kA5GD1kyRqJUPhBFuN8GADM+3p7SLSD1
	7VEEWJLofA59tScCVquCvCJAlJADEqJMkEIyqQSpGNXVIXnLD/uYq3wk7J2bjnht
	4t89oQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8wffmbs2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab1e771632so3105476a91.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870113; x=1792474913; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ypuDZSakPalBX7M4x+LFJr9Z+MgpyzNsrKt1TNFFTZ8=;
        b=ZHGFRU6DTWCI+snzNisu7XfQBKUTTAZItZUHSLR9oSKKklCKYgR+Gn774OnZuvw0mN
         eURC8j43QPjuy9NDgFX9/cr2qfqU8QEsxq6CyWw+DgfaFQqtgxWeOeBUjb8YEUwJZhrg
         5jmCe8U1WO424+0bgmAPg2eX+SprkrO/PCVBsPKQVPdhUPzFZWMlp/qsT+A8DbTzyrPD
         FrLbasDjC1QkpxylcgIrp0tzl2P3TUIDWl8A/GVwWW+ZNr2O93lEpGoogZtWeekc+LHA
         ngiX9hQC7DwNPS1UPM0913QZaaAUU1k6fE3bim9wI1qJ9r/u75KuRXP83ybXgTF0wcQx
         jIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870113; x=1792474913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ypuDZSakPalBX7M4x+LFJr9Z+MgpyzNsrKt1TNFFTZ8=;
        b=Kbc6z0C+MUZmv2v480HTgfEoCvAASPWkb95VBBHCdRjFq26g3Aq6YM9DzKSQFVJADy
         XnLbksMMVfJLhgZEb840444esnTsA4zt4ILD0LgNi0g5mrVmUol6aR9V8FwZqC/qnOR3
         RRPFtJegwxJ4o/o1N8laBakEz94ootaTN1lLAHIFIF4faPqf9p3da85xms5w0w7rUi+t
         FGz4hRQyEib6T2N5zYvO6xqyZuwwLx0tuC3q2eV3xxKukr2XOOBMN3Cw5uCcVXvsQBiT
         5P5x3zANg6rRLmSjkHBavfRMfAbvqGIhVh6NofIauINUbw3vOhYFljhbP1QKKqW5IFJc
         i11Q==
X-Forwarded-Encrypted: i=1; AKwUvBzo5mhCSOUb8q8gOwGbXVhr9Qak4r5JAye5NRpN3d8Cf5IC+hC+zUjx2pVKzCPJKpy8pAdzG1o=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKdRRnUKumbaNpfoXMEOLk6pzmXLRgsaaapgck0AvkgeCs3Xt09
	eBeCRmqnOP1RksXnSnX6CInYmcwhWx+H5dA5DN9SWh3lVNvix06E5/xO5Q7rggCnPFMGQ0bdeik
	fEXvlIewCCBJd4/CogK9u9e3gVBssPPJM+/Y/o1BC6oATkEf6TijdzPUARi5WgDX04Vy5v7k=
X-Gm-Gg: AYBFou3Gvf7+qh5/KIfnwDmuXjVHgi9M1fhvHnbhLgx6GCQ1uhFsdWEhRj0EU3NLIxO
	2H6k1jrSjtvhge4meIau66jRGE24gcsmlfMvINdawHV42PEQXeagfkHiXeNkiCHrP0QCRfrTrbs
	yAy+YZx1Ia/EO4N9EEDMuPS46JdH50HVsRQwPSzAUsRktcGAw5VH7MVbSVbA9nFxBGutg6zSdL0
	DlANhBdDnmpCkW2zvXJasTpeOg8QrNpbxmftiOxrRVySaJkICHqruAu0vCSL7NDwUueFHIhXT/o
	TIAcJi7Knmdh24THLK3oqFHEYCLxSlVnNcfyxtwGyaUqp/dgHhAprM5AoyP8WHj33X2rPdKq4PY
	v9vnYqlLBsY9DuSPiio8gaMYkjFDMtkpexrPDGP97Oc/8ALY2GwvjdTFhKg==
X-Received: by 2002:a17:90b:3c0f:b0:3ab:b764:8256 with SMTP id 98e67ed59e1d1-3abb7649df1mr4161367a91.17.1791870112933;
        Mon, 12 Oct 2026 22:41:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0f:b0:3ab:b764:8256 with SMTP id 98e67ed59e1d1-3abb7649df1mr4161339a91.17.1791870112091;
        Mon, 12 Oct 2026 22:41:52 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:41:51 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:30 -0700
Subject: [PATCH RFC v3 3/9] tee: optee: define the RPMI control and
 parcel-reference ABI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-3-975b574667e2@oss.qualcomm.com>
References: <20261012-rpmi-tee-service-grp-dev-v3-0-975b574667e2@oss.qualcomm.com>
In-Reply-To: <20261012-rpmi-tee-service-grp-dev-v3-0-975b574667e2@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX15CLbSUFbra1
 KwhB6Az0wOxpce74MIgip+fmjrEgHt/oTd0OcwVkaLPqN73oyuTkhnkbHwcoazsXZO7WNqiodOP
 skbNrJgoNM/1XCXEemBiH1Lx7npwqB7Rl7no0e6WOfzg1O32YJNDmoAzfZxo9/JgKcmuJFlOUyJ
 DuUilgUKZi34zsiAz0bOWwol8mf1qSGshbYMp8U3gADmEolT4rukyPk/38U0vSfGndKAxLguCye
 w38gGsEZFYQG4nhN0WKj9E4ApBygGzBoaH/+rMeRKiE2zoVaTxgqJev+cokPJOpqClqCtVDSjB5
 NEIYBJvoqce6eWceCzjjh++gtOhfhIDuocGQlR6KGzwYBk1pAITDMkxpHSlwSHEMr5jPbvt1rJJ
 iO32OGFSSQ5RYZw90eYZTwbHhf0LQyuBgBugv1Q84VLfZmlSr2/W4iK267XkOLilyFjf/T1woI0
 q0MKoku9YT//Ase7juw==
X-Proofpoint-GUID: fHUi6jVJgW77jSyxsDkL4f4gTs58PDTz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfXwW+ICsfAXFVe
 Lbm7kKnEMgu/itpzgvsBymqPI6pCqaxewfnF7KeuwNJVLEvRCpOhtZcQom9d6t7gyWus1LsbSH8
 vewpBWm38awFvc2AHhJKcd9T0NON8ws=
X-Authority-Analysis: v=2.4 cv=ZcWIpcVA c=1 sm=1 tr=0 ts=6acdc4a2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=G3s93uPkn6CA8LbIO-UA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: fHUi6jVJgW77jSyxsDkL4f4gTs58PDTz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[209.85.216.69:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0B6AA45278
X-Spamd-Bar: -----
Message-ID-Hash: JSTV7Q6QAJTGHZSHAZNG7II7F7SVYWTD
X-Message-ID-Hash: JSTV7Q6QAJTGHZSHAZNG7II7F7SVYWTD
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JSTV7Q6QAJTGHZSHAZNG7II7F7SVYWTD/>
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
start and resume. Use fixed-width little-endian control fields and TEE
result codes for control responses.

Add a parcel memory-reference layout with a full-width 64-bit offset
to the common message parameter union. Encode the RPMI parcel ID and
nonce as an opaque 64-bit global ID. A zero nonce denotes NULL, leaving
parcel ID zero usable with a nonzero nonce.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/optee_msg.h  |  23 +++-
 drivers/tee/optee/optee_rpmi.h | 263 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 283 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 6c3043f8da33..dc331cb0dace 100644
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
@@ -149,6 +152,18 @@ struct optee_msg_param_fmem {
 	u64 global_id;
 };
 
+/**
+ * struct optee_msg_param_pmem - RPMI parcel memory reference
+ * @offs: Byte offset from the start of the shared parcel
+ * @size: Reference size, or required size for a short-buffer response
+ * @global_id: Parcel ID in bits 31:0 and nonce in bits 63:32
+ */
+struct optee_msg_param_pmem {
+	u64 offs;
+	u64 size;
+	u64 global_id;
+};
+
 /**
  * struct optee_msg_param_value - opaque value parameter
  * @a: first opaque value
@@ -169,15 +184,16 @@ struct optee_msg_param_value {
  * @tmem:	parameter by temporary memory reference
  * @rmem:	parameter by registered memory reference
  * @fmem:	parameter by FF-A registered memory reference
+ * @pmem:	parameter by RPMI parcel memory reference
  * @value:	parameter by opaque value
  * @octets:	parameter by octet string
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
@@ -186,6 +202,7 @@ struct optee_msg_param {
 		struct optee_msg_param_tmem tmem;
 		struct optee_msg_param_rmem rmem;
 		struct optee_msg_param_fmem fmem;
+		struct optee_msg_param_pmem pmem;
 		struct optee_msg_param_value value;
 		u8 octets[24];
 	} u;
diff --git a/drivers/tee/optee/optee_rpmi.h b/drivers/tee/optee/optee_rpmi.h
new file mode 100644
index 000000000000..d4cf2d927a7f
--- /dev/null
+++ b/drivers/tee/optee/optee_rpmi.h
@@ -0,0 +1,263 @@
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
+#include <linux/wordpart.h>
+
+/*
+ * OP-TEE service ABI over RPMI TEE_CALL.
+ *
+ * Requests and responses are carried in the TEE_CALL service payload.
+ * Control fields are little-endian. Response status fields contain unsigned
+ * 32-bit TEE result codes: TEE_SUCCESS or TEE_ERROR_*. These are distinct
+ * from the outer TEE_CALL status, which uses signed RPMI error codes, and
+ * the GP command result in optee_msg_arg.ret.
+ *
+ * Memory references use a global_id combining the parcel ID and nonce.
+ * A zero nonce denotes NULL regardless of the parcel ID. A NULL reference
+ * must specify a zero buffer offset; its requested size is preserved.
+ */
+
+#define OPTEE_RPMI_SERVICE_UUID \
+	UUID_INIT(0x486178e0, 0xe7f8, 0x11e3, \
+		  0xbc, 0x5e, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b)
+
+#define OPTEE_RPMI_VERSION_MAJOR		1
+#define OPTEE_RPMI_VERSION_MINOR		0
+
+/**
+ * optee_rpmi_global_id() - encode an opaque parcel memory identity
+ * @parcel_id: firmware-assigned parcel identifier
+ * @nonce: REE nonce supplied when sharing the parcel
+ *
+ * Return: A 64-bit identity for memory parcel.
+ */
+static inline u64 optee_rpmi_global_id(u32 parcel_id, u32 nonce)
+{
+	return ((u64)nonce << 32) | parcel_id;
+}
+
+/* Extract the firmware-assigned parcel ID from a memory identity. */
+static inline u32 optee_rpmi_parcel_id(u64 global_id)
+{
+	return lower_32_bits(global_id);
+}
+
+/* Extract the nonce; zero denotes a NULL memory reference. */
+static inline u32 optee_rpmi_nonce(u64 global_id)
+{
+	return upper_32_bits(global_id);
+}
+
+/**
+ * struct optee_rpmi_probe_req - request without operation-specific arguments
+ * @op: GET_API_VERSION, GET_OS_VERSION or EXCHANGE_CAPABILITIES
+ */
+struct optee_rpmi_probe_req {
+	__le32 op;
+};
+
+/**
+ * struct optee_rpmi_status_resp - response carrying only a TEE result
+ * @status: TEE result code; TEE_SUCCESS on success
+ */
+struct optee_rpmi_status_resp {
+	__le32 status;
+};
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
+ * @status: TEE result code; TEE_SUCCESS on success
+ * @major: incompatible protocol revision
+ * @minor: compatible protocol revision
+ */
+struct optee_rpmi_api_resp {
+	__le32 status;
+	__le32 major;
+	__le32 minor;
+};
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
+ * @status: TEE result code; TEE_SUCCESS on success
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
+};
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
+ * @status: TEE result code; TEE_SUCCESS on success
+ * @secure_caps: reserved for future optional features; zero in version 1
+ * @rpc_param_count: nonzero parameter capacity of each RPC argument buffer
+ * @max_notification_key: inclusive maximum logical key, including synchronous
+ *			  keys; zero selects the default maximum of 255
+ *
+ * Version 1 defines no capability bits. Unknown bits are ignored by Linux
+ * for compatibility with future extensions.
+ */
+struct optee_rpmi_caps_resp {
+	__le32 status;
+	__le32 secure_caps;
+	__le32 rpc_param_count;
+	__le32 max_notification_key;
+};
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
+ * @reserved: must be zero
+ * @global_id: identity of the parcel to retire; nonce must be nonzero
+ *
+ * Success means OP-TEE stopped using the mapping and released its receiver
+ * interest.
+ */
+struct optee_rpmi_unregister_req {
+	__le32 op;
+	__le32 reserved;
+	__le64 global_id;
+};
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
+};
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
+ * @flags: zero in version 1
+ * @global_id: argument parcel identity; nonce must be nonzero
+ * @arg_offset: command argument byte offset from the parcel's first byte
+ * @rpc_offset: RPC argument byte offset from the parcel's first byte
+ * @arg_size: command argument extent in bytes
+ * @rpc_size: RPC argument capacity in bytes
+ *
+ * Firmware validates ownership, RW access, alignment and disjoint ranges.
+ * TEE_ERROR_BUSY rejects an initial request without acquiring call ownership.
+ */
+struct optee_rpmi_call_req {
+	__le32 op;
+	__le32 flags;
+	__le64 global_id;
+	__le64 arg_offset;
+	__le64 rpc_offset;
+	__le32 arg_size;
+	__le32 rpc_size;
+};
+
+/**
+ * struct optee_rpmi_call_resp - yielding command response
+ * @status: TEE result code, distinct from the command's GP result
+ * @result: OPTEE_RPMI_YIELDING_CALL_RETURN_* value when status is success
+ * @resume_token: opaque token for a suspended command; ignored for DONE
+ *
+ * DONE releases all access to the call's argument and RPC ranges. RPC_CMD
+ * requests RPC command handling; INTERRUPT requests resumption without an
+ * RPC command. Tokens belong to one accepted call, service and caller.
+ */
+struct optee_rpmi_call_resp {
+	__le32 status;
+	__le32 result;
+	__le32 resume_token;
+};
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
+ * @resume_token: opaque token copied unchanged from the preceding response
+ *
+ * Resume must not return TEE_ERROR_BUSY.
+ */
+struct optee_rpmi_resume_req {
+	__le32 op;
+	__le32 reserved;
+	__le32 resume_token;
+};
+
+#endif /* OPTEE_RPMI_H */

-- 
2.34.1

