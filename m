Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37528606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IUvGUcgS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYeAfbpT
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9095143A89
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:16:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IUvGUcgS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RYeAfbpT;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BCEA84549A
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:15:41 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tAsk3684321
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 11:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QqTCl2uH9Ug0oujw89YxgMGvAEAk9LlD6OF8wpx+dV8=; b=IUvGUcgSdaufGKx7
	OaoqgSMnSU19wHd1z/O815kwcvjQxnsVIjHTA34GpO64dFHHiVy3TyaMWnbaKJly
	Qkbb7ytKqC3GCxiJojF44MR2kEtTpN8oIhQjxvUcpToUo52/jJm3fRDQ46atjSIs
	27YS2eWQmFXsjmVd8t2ZcUm8iBisRmo4hWyoggqpZA8iTh93NSKkWBk29aNYNGzV
	nK+55bDXlOstDN8pzaRwjNnhBXWBpaz2irj/z9YbK5C1cLO1eXIvyUDuzrHtFQtx
	fkg9QoWGyeqajlZWyz9uVaryyAXOLB5PJiC655J1R734RTSQEajMe/EqjyFjU4av
	ORgKqw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43hqns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 11:15:40 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso2089830eec.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 03:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877340; x=1794482140; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QqTCl2uH9Ug0oujw89YxgMGvAEAk9LlD6OF8wpx+dV8=;
        b=RYeAfbpTZOFTLXw4Ab//vm3uh6C5YdOBcNR7/6+o6xyk2/N/Yj29C4+YUPhsfTOO6b
         GqInUrOhlbDEURmXcNvLXMg0KD7BGTVgDvVstQa+0EScYgvnvyk8NYCsfSw/Vp1sh6K/
         Wr460NK4FNyabH9Eh90CTh1K7GUM71z49SUERaynmqqVv/VypfK7JY//RRm8inKDOzwm
         P8jzzK+QUMoytjM14VsKrIfdwpxwrDrLsKnbOePVP/TnKZs/EBcAKHJK1Xf1t+VqIYKA
         /TCyM8cYgz5hkURhfOOKMdxPK/rXvF/gVzS1LycuQvQVY6IIGzGb8Rr1+DGrFUJghDdC
         APww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877340; x=1794482140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqTCl2uH9Ug0oujw89YxgMGvAEAk9LlD6OF8wpx+dV8=;
        b=1YtffBNQpmI1UkR7xO9YeHs2wqV5elssPgxE9dR2E+K0E+WoiPyzh3a3OtVjLB7FM7
         3vvdEOeUYCgXLWg4IDEKTCFwuru0b2rpYEHBjWMyDxcQAtOV8P5taMGc0xTEzLCp0Kyp
         zLE4KRX14rUUw3OtD/zwFk1S7qiNAvwETKrnYK5pJWZRwIAoGxxEwgPQ7iQosBo6irmm
         ZqdbujrsXO7mq3K6JdWH9OoM8zUSzrwQZ7ArdNMVCiiQH53OU66Gnw4sIxCwfXP9MpDG
         mbnBIDr+n/DtwDimPk+144LbWZDcLs/Arde5N5wb7rbZ/WciH+L5ydbZghaQflgBGv+4
         tQsA==
X-Forwarded-Encrypted: i=1; AKwUvBzD0EKIfzeDN/JZx+iu6YFgdaPvEHjLeaeXsjE2iVGOkA7HgAML2PIaTlava4Q2xXn5hzBhoyQ=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8CmCJqFnPZhxyISsu7GHOLhziinwi7q4usB2QSRpx31qEYavzJ
	jugrX+C+9q8u1FKNVlSL5Je4bUW3LFITuubFSYgKHkVD3ueEiOS/00HK69hW+XcRf/MGoU3AZtH
	d1qxrm+2+4EJ/Jiful8if2881pvf+8G0OdQg2n+rNUqp6MxpNfZaFyVVS0w0lXOSrKl68wsfg
X-Gm-Gg: AYBFou2rIlipy+tI6zqtdKkmRyNuP8/0zq8G0BP/Zqf5crl5tBovd8fPX1ARn4umbyO
	HI+ptbBFhfzXCZJRj4PXcoLUnM5bAHecBse4LMcl1+FuRQ+CMJlIGzOcpmJcTJnSKLklQagedN0
	kMqR7UamvHFmbhFObHu9BOikv74F0gPLIn9jpwEzY+LWuPnzSZ3B6EqgzyUoKa6ylrLPnABKB+L
	jJLpJYhc/VOY//z0SA7vTZlJvI8cG3MqZP74CVuoR5YLD2JE6lhHX4AzR+AiC7qwZDc81z3Jbll
	HcY6yMJn+RXtXrmB/nBYs/JKB4jLanO0rzNX/jGTx4UnaZUArydJTM73yimKLxefVLb1KCeH5XM
	YKBLqkV3AJOtDh57/DQjMP03E4npfJq1SM6LRFuqIEp1gqBSvQvrDA4cTLduBoqt0CR66GKGSuA
	==
X-Received: by 2002:a05:693c:895b:20b0:36a:1bac:6bf4 with SMTP id 5a478bee46e88-36a42389038mr27598584eec.18.1793877339561;
        Thu, 05 Nov 2026 03:15:39 -0800 (PST)
X-Received: by 2002:a05:693c:895b:20b0:36a:1bac:6bf4 with SMTP id 5a478bee46e88-36a42389038mr27598543eec.18.1793877338996;
        Thu, 05 Nov 2026 03:15:38 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm14002125eec.18.2026.11.05.03.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:15:38 -0800 (PST)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:44:50 +0530
Subject: [PATCH v6 2/7] tee: Add kernel client object invoke helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-2-c7d68ce05c51@oss.qualcomm.com>
References: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877323; l=2712;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=MG/KeRt6DZYq7khoQnrWW6xa7jbn7FpCPMYbKhjz/hY=;
 b=uzXMOdWZhtoGqZHfDr8sER8R6AuhYYRfExYO3XIXFPnLcCYx+puN5AFg+qYlRxzmzpwiRI/JV
 7gIMoiDC+9OCWBewbhT9DX4RDxbMTam+1/+u7gDunqktIuZByjcMQZs
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: E3AeG-Ya1k98Iu_59yAJRnvCj8zHChgi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX/+0eZVYxmcD2
 un39Oz2YQGmH3JnrHljL61KsWVDOsmSBoK33eL1NxboeaGItPcudQNfy1lxnWFcs4duHFT0euK5
 8DEQ5/hJBzOI+oa7SyJS4Am8xP5L/Ul3uFqcLorLmF7tdmo2+O1knyUX/CJr191NYbDH8PrUlKK
 IotJ+f/xs7l5DvSwTL+fBVa2NIyJWNBmHgHPlOHA4uetjjdgMTPQbphosSTAmTZgTl3X3DqJkcB
 3ty55mTzdXn/pqGrVveLNyU6dX0gK9y9yMHiKYwRF0MKF0EZPmwy58eafuOkDpZwPxzMZpkMjPR
 QS04BkYeumwhcXKqFes0BM/cKenu2OvPPy+9R27P8N4ALlBwqV40kGoKLIaIG6+330EgK7GPzFf
 ahQJsR6dux062/8EUBkiUhxWhy6OKO1k9fFVhn4PeH6Gj2qj9Eu5OdUvPd1QK3KXsak/iRy9grd
 pMdfu6hQirwits6/I5g==
X-Proofpoint-GUID: E3AeG-Ya1k98Iu_59yAJRnvCj8zHChgi
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec655c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kr-ihz5DC76VLKRVsLUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX3AqfDywf46Gj
 vpaUwIGVGQGDUegM2rvqfmbIGasPkUX5qnT5c41xnMMJCHN9bhGzXTDv2yi3KBTxP2jljLrzylb
 sfEU4ZcPmaoXS3evKH1c1nKRMfmlfVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BCEA84549A
X-Spamd-Bar: ----
Message-ID-Hash: J5TKTVL2FZ2DH4RBFRJ45G7TQKEEGMPM
X-Message-ID-Hash: J5TKTVL2FZ2DH4RBFRJ45G7TQKEEGMPM
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J5TKTVL2FZ2DH4RBFRJ45G7TQKEEGMPM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Kernel clients can open a TEE context and invoke regular TA commands
through tee_client_invoke_func(). However, there is currently no
equivalent helper for invoking TEE objects.

Add tee_client_object_invoke_func() as a kernel client API for issuing
object invocation requests. The helper checks that the backend provides
object_invoke_func() before forwarding the request by setting the origin
as TEE_OBJECT_INVOKE_KERNEL. This allows TEE backends to support
privileged object-based calls from the kernel-space.

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c  | 12 ++++++++++++
 include/linux/tee_drv.h | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 30901390149c..a03a3d645dd1 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1404,6 +1404,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+int tee_client_object_invoke_func(struct tee_context *ctx,
+				  struct tee_ioctl_object_invoke_arg *arg,
+				  struct tee_param *param)
+{
+	if (!ctx->teedev->desc->ops->object_invoke_func)
+		return -EINVAL;
+
+	return ctx->teedev->desc->ops->object_invoke_func(ctx, arg, param,
+							  TEE_OBJECT_INVOKE_KERNEL);
+}
+EXPORT_SYMBOL_GPL(tee_client_object_invoke_func);
+
 int tee_client_cancel_req(struct tee_context *ctx,
 			  struct tee_ioctl_cancel_arg *arg)
 {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index f3c5e106d853..369c87ad0205 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -283,6 +283,19 @@ int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
 
+/**
+ * tee_client_object_invoke_func() - Invoke a TEE object from kernel space
+ * @ctx:    TEE Context
+ * @arg:    Invoke arguments, see description of
+ *          struct tee_ioctl_object_invoke_arg
+ * @param:  Parameters for the object invocation
+ *
+ * Return: On success, returns 0; on failure, returns < 0.
+ */
+int tee_client_object_invoke_func(struct tee_context *ctx,
+				  struct tee_ioctl_object_invoke_arg *arg,
+				  struct tee_param *param);
+
 /**
  * tee_client_cancel_req() - Request cancellation of the previous open-session
  * or invoke-command operations in a Trusted Application

-- 
2.34.1

