Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9E57CA9ED0
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:44:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0BA0F45225
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870274;
	bh=7Q5nRa43hWpowrs3WTtfQQ8c7SPGddet586Xp5YmbBI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=h5yOKJPDXzi8YMQ8U4tWhp+JaKE0ROMA5TBnVUZwyI65tHOSDA4unXiOKqTkFTeyI
	 X6PrQ8XkEgtrDdLS1EzFMIoAnb7Uc6Hxmy4STADmD/GZNC8elSKuI/FaZ8c0EelbbT
	 +9CaWD+b4D6U3X24cdyuw1QR5x7ulTNkRS1SYo39gD+lCnCdn+0jzSgi1dFStnYmEe
	 cd3r6L51WS/zvAwZtv++/EiTDCfIQWljiyoPW0SOmGGbSMZ1sbkSlWmNyf/nzJL0iI
	 Lf/beeLKJcg+8noG6P0j+5aedDjN9UuP6jkOLdHpWiyJsdBc3jWMGG7ssJ6L1Id+Mk
	 d8nJqCAXu+mYg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 989F845232
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:58 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N64wzUaJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AAtWFww7;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D20fHL922859
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	P9/Es066BKyO9sRu6bY124oGmsHpSkt+MyzxTSuoHdw=; b=N64wzUaJQPWl7GrO
	o2Y+P28Hfkq5qTYerT+VjMf7hTj/co8gaqJdwraY6hVP4uhIpmeZ0FvGjum454FL
	6KlFVbTIIJxsDXtPHoeqjV9idCktviSbAY+2E2CCWzcpS9xcwZ+4CKjs0DoUVwy3
	Y0k2wYRtTK6Euzg+zwosQ2VBUJDGLtFra15XIOYxh3MQr+KtwY0P/XW01vfK7ofV
	/km00MnWOkcftyL70IeeC9zSsCrl1aWKHeGU72j+vPpGJzL8UkJeqwAGN5cz5NJR
	u7a7h9KPul7kOSqyMm9JoJI5czruSxvt66Qh5W1ukGuLRAxNQM4YFcplME6y2gfI
	rfK2og==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1s8w0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:57 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc42a07d04aso1744243a12.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870117; x=1792474917; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9/Es066BKyO9sRu6bY124oGmsHpSkt+MyzxTSuoHdw=;
        b=AAtWFww7dmAV5re5tTGD918umhddd95EGBrHOqZ8mHNndOY1rvU7cBT0wbbH+lDOU0
         5JFW/Mc3eh5+2k9cDrCTcuG8VW7+mv0CE9+YoC5+l4+GCTH8ToRQXlzrPoKNyf3nmrHu
         bOfgjqpzR7mc5fgwmCAtliu0y8QpKBuUqelnAf3lY1L8YBpq/RWsH7QZvhx2rTE9hfx3
         DBJ1jp5fZLoMdc2QyMlpAA0ZRKtvDpEYdqLv0Y15dtTBIVmaKu8AOSMXqm/D1YBnw1CR
         eZp3Td6CgTj/fqh406bfHXdKNAxIdBHGlIgJFrtbNxvxqaVAxBDAHIfeV7kWNQp85pc4
         wHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870117; x=1792474917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P9/Es066BKyO9sRu6bY124oGmsHpSkt+MyzxTSuoHdw=;
        b=O8RTjTe2NwFz9BP+cmAQyC6mIFJbYlAdQkSH2oo+WIxDWVdguFYFM5y0dHTvBtJcnf
         kcqW+8KTVhUzovW3BMzW0m0sqTTtnUuE29Q3UCByn3mtFlEN0Gtm5px4aMclMt/vZ0Rk
         /HpQvxUoD5Wv0MocNknsMC7zKr5m0lTwoAYDzfjK5j1xSh5k06my92Qdw3qAeaunEu17
         fdDtxFL03E6Ka2NqhXbIiruN9fwmpHGHsUWP1L/rmhf8KvoSQSTIcHlBz4EGfh7Mfzr3
         3d67AYbAbYY//bPVwHSirj7qb+L+2WTxD0OskqrdiSqkm2YcQyNG1NfYcgNjPa/+p3CM
         yYPg==
X-Forwarded-Encrypted: i=1; AKwUvByPxbXPbB+WFpW+9QvNDSsLIngh3BZID2ORjhOHTa+cQn3GXVqKQKKQ5LSU+npHnI6QBKJ3+hM=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLNgOkLun4yUS2szvMa2aWTfAiv+/19kzwAEYPsmLt/06HkIbpB
	RyH0pcIAcpjyFS8EHAJ1ahJwP9GIpp9QRoPSE1UEJabMsuTf48LL49Tt/pRvYrnIaKSaIlyniNr
	50IbzDBhotZnCJ+dzMzpLqInwL7+oIsVsI+vmCxFFoeU8R6JVGHXenQNgTVDmk72lFXOlXgc=
X-Gm-Gg: AYBFou1b2q9AcxqBnt3te/vEsbXvFqmnBjRMz0yXpGUXOCjEXkZWxSTgbTF8iMWb8aI
	e8rKNL+UgToTyp1ElUNVMCuh6s7seOTbtUNg5etXeSuGV2IcR1I4Qq+H7SFFPDvGh36TYLqFlJk
	pcENwBw7yscsWIGH9WmyZVNxgspHpqe63f9MhK9uMRV+m/4MSvgq65KateK92gb7g7NsyTvxy8i
	oL7qs+vlgd432hAH2xFHM+F9Fuu6EZ9hpqj2MxWfPsM9MnI9cFhmjwcswQximlYuxg7J3tHavH+
	KjAzzIe+DdITit64pHgUA6EPEob83oYYIw2vQtBCcmoFD5dD8TcPhzc5VBAS4AAypqqenGK8naI
	J2CtbVRX2HJE5sxfXXrrBHsZrPchGhgBFO7RMlm9Ow+AiJ1WhvTUOZx1gQQ==
X-Received: by 2002:a17:90b:3143:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3ab3ac95141mr10687428a91.56.1791870116726;
        Mon, 12 Oct 2026 22:41:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3143:b0:3aa:548f:eb77 with SMTP id 98e67ed59e1d1-3ab3ac95141mr10687396a91.56.1791870116192;
        Mon, 12 Oct 2026 22:41:56 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:41:54 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:32 -0700
Subject: [PATCH RFC v3 5/9] tee: optee: add RPMI dynamic shared-memory pool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-5-975b574667e2@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdc4a5 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=hYfsqUzT0y0sb8bvQO0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: K_0SfocRXJ-qqpvVXdjgwJbFxCzQ8i2C
X-Proofpoint-ORIG-GUID: K_0SfocRXJ-qqpvVXdjgwJbFxCzQ8i2C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX5offqdVFYpoX
 nm7oXpRPAdJOr8v3AzVwJ5mJfSDYUZJm9Hknrbp7C9rU2yo+5cgarBxEebuifMTHo3cmWANhMVK
 jgKu4BW2Z0pyc0KvAHOICw/m/QHRoiE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX7QsPu9s4nDZ0
 V4m/ygjondusk4d30LDFWn7glnSw5QPDLkSiia8X7lLUVyGgrXkE/ZGmR6nXnCSFCaDsgP9jjf/
 4gZAZwEQ+lk3CkGw95blCJtPLuK/xq1hDmTHZP0t7BVKrPgi/xMtDvjmGNtOwctmRx/1zQjWntQ
 /Ta0GN/l1l4AB9UmVZiBxK07Vrg0HgqO4XZSA7/XTQpV6B/ciuDyF38ivVgcp8GcZkkpIMkmHGS
 +OGrEJNPke39QX6zN5ODI5yK1wtQhwvpJ8eGUNGZNJh39fJGKv5xoU7Jkaop9nyINd4FBrlBVu0
 R4y2IZN3lkZ8UmF8WynzWZUGa6fb6M49j6p936pf5x2w3+toO/a2Yslw3xgBKG5TQt9iSvoWxio
 Vw0Df1LuxPs6nup2QKIPQFkEMUkbfjNfyBqCPmrBrIk4uZuul24TF1AabvAukBn4VwPLaDzlXzb
 v7YBdvGzsoqMW3PwXaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.215.200:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 989F845232
X-Spamd-Bar: -----
Message-ID-Hash: 2WIERUVF6V55JH5RJ2IBT4KDCQYJ2KLB
X-Message-ID-Hash: 2WIERUVF6V55JH5RJ2IBT4KDCQYJ2KLB
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2WIERUVF6V55JH5RJ2IBT4KDCQYJ2KLB/>
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
index 940676794280..bbb219ddab38 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -183,6 +183,42 @@ static int optee_rpmi_shm_unregister_supp(struct tee_context *ctx,
 	return rc;
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

