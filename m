Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9DACA9ED0
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:46:29 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A864145225
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870388;
	bh=aG56Ac7h2Y592xOGL3Jf8xm7MfpbHewHHYn6gR8JJJs=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=SJppVo5q8zHp+WSTG4rXbag3uw3cWZ3GAbif2ttiQlIIGZdQALhS3WFkQ/3B0LwZe
	 k1j+fDXZQbbqG9ZeFI8fRapUz4413Ez4E/2MvuaVk2MPAgbq8tT1A0t4Us/3G8fAOd
	 UQXlIWF+y0e1nZ/zfZIxKBybwSEMa2lI/5kfVlWHQybrNkUcoBCVX611yaF0hymdVi
	 SjYakU9/sfluK97LMTqGoSRSd5Ugto5j8j0oPFui81qMZF23SJYEfaS+k/kVATlz+O
	 TBrVlf/04TB/XYdY2CdlhinWmMYnWisV44AOVbILp0MpUf9clCzSHhdVpwp1L9Gfms
	 LUeCzgN/vZ/Pg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3AE3A4528A
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=i443NBo2;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Iew94yPW;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D3xKdP3476152
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EuzD4n98XFQr8qVxMc+ujFNUBJUiJ93/Y53lGr/WPlg=; b=i443NBo2gZptrYak
	t0haq4df02oH/e2IQ5VglKIZOwLdUWmL33Hwa1PCkX5fJOIRThLN+LdzjNJ8iqfV
	ZK79fnjWNkW7UCxwHlXw+gcC5KPpzf475hi83ipMT63fd84YcKPGsgJTJRTCUD1T
	z9GxM/e2zdh4p7+HgR9PxVkHWzJ6sPiG0TYTrzlEnUv9r0TNzn4hwSGJWd4PF+do
	At7g0Y1pMIV+YFFaVqSKMvYAIk+86bdfkBzw4P+fW+0cKU4Ay7XOCZX7FM1JCArj
	5nNURyRYpItAqa7fBAN+oASy9el8qL9r0qRRjwXXGQX8HSLIeOvXz852rO83W6CP
	XpiiBw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9d7j8ayb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:42:07 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a4a0017549so4183808a91.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870126; x=1792474926; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuzD4n98XFQr8qVxMc+ujFNUBJUiJ93/Y53lGr/WPlg=;
        b=Iew94yPWdY6vepR7HVZddu9+CBKFfb5VktlqdW8SkrEQ7+6CcKYrfoOBubisEZRAz9
         XGTKtMQzJ/o211vrqjLMxqR+kYYa1Q9Jb7HSCGBvsfSAdFNez0edmcVPMYKGYbAcw6tq
         51saTxHQaaT/hQQX6AAXoQjp7/2m4EU4v/I5W4BoKs5cFRTr1VTTUbq7PJpB+FhfvPXG
         942uesn1LwT/07BAxzJeIjiw/hfsuuD8uc5+qxbabZM+VS5JBxPtqRZSFvenHwQQ7hv+
         hlpCEb9eXVleLQ5FuGpi5g6gN+2T/eTlKfHxXu1DsrILnyHoXIpcggL2RrB0h76o5XOI
         NXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870126; x=1792474926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuzD4n98XFQr8qVxMc+ujFNUBJUiJ93/Y53lGr/WPlg=;
        b=dFRJIf11FHqWcdD6Ta93emC46IB+tP52xf2huNMCNEQjZk5Lyzp5EvE/dgPtHCN+Mn
         QSMvIUqpCBPHqVqS3jmEJ28jdUa1vhK1HYOj/WuaV0y8devkZt+txJhsOqrNY7BsUWyH
         ZgZjEOnxj1PpOiWrS6RPFv/xkaw7VP9LFkiOO0ttP5u15BtUabISQwZXeHtJuC03Q6mE
         NTSIT2IMr9PNt2x4EzUsB3y3nHWY1dZF7MXBJFYrALtQ5nD4CVOwMNR97qzO6Qq3veA9
         7Gy7yPYdkvNTWOQhy2nUn2pTqHRWTk6KC2M3vUY/B+RtgJyCnXphjhmIisf6ZcmVgJXQ
         ea7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxjJfoWZCkaybVuhdSJE3c5mS1U8eS+Hy26mKX/9gQD/s+xA8AIqcDDFLIh51NawQCtT+X7xbE=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJkF2z6R23bcvetqZTnwn0roFArdc3+tI0G3xlp8SbzYFbKyQmW
	Wh7pv/M2nGTWm/H73dLS5fKiPdTwz4LgrfKEUVi3UY9wAZSghaiOJb36AM504655JFfCzmdGlBL
	yLWiVtAa10g0eS00efbpdZH14q4hBUeSC8aScfsdj+9dSpGqhUgY73Nh9nFR5bdlLNrrKMJ4=
X-Gm-Gg: AYBFou0sGlQUkZoOTP+417PQJsAj95rQDM/1XWI7fdoX7O4NrWSNWE0Ls4VJ2tOboS5
	G2SlpVszS3rU1vlibj3FQc60BFWYpsdcfczCdBpRt+s7ZFKOPpSZhT3T/pGEZwAD3uwSezZmexC
	VlAFOoyUPPKHE9I7fDApPTh7ft5PydWFq5caBGw6e+twE2NqrrxynTtoo1Sq3yLcq+RG0+EKNWj
	aj7Kn8+GsPbA7gL6KhYTd+f2C+NP1LXA0Z+wYpgHSbxedoVzMtp5GQ77z3cABaA+1+QV5t41ux+
	M5j+HTSHax71gFkzjhyocC+lhOizfjgx7vMOmbf3Dw/b0aTmyzQUvh44nSLzvEyBXT0px7yZN2K
	31iHCOzicNaMbTjjLK7XgwuwFZgbjB5n2uqUbWjfslVNKWcflgJrgFBwtnw==
X-Received: by 2002:a17:90b:3d92:b0:3a8:5cab:ff5 with SMTP id 98e67ed59e1d1-3ab3ab1fa22mr10874800a91.43.1791870126268;
        Mon, 12 Oct 2026 22:42:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3d92:b0:3a8:5cab:ff5 with SMTP id 98e67ed59e1d1-3ab3ab1fa22mr10874775a91.43.1791870125744;
        Mon, 12 Oct 2026 22:42:05 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:42:05 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:36 -0700
Subject: [PATCH RFC v3 9/9] tee: optee: support RPMI asynchronous
 notification doorbells
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-9-975b574667e2@oss.qualcomm.com>
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
X-Proofpoint-GUID: Dt2kugQkAsybWALu70E1LvtiDVMwapWu
X-Proofpoint-ORIG-GUID: Dt2kugQkAsybWALu70E1LvtiDVMwapWu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfXyM8hVBsFACW+
 S6hIkKLrfW4EvliBhtAVOKFix+Ef7fu6VsRTZoe27rQwkWln/ajGUtfrGkrIrWn0u8w95sb6M6q
 6MvszHwZelv4QpKO9BJytJe5xfDFUS4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX1cnXyOiH4S6I
 KO1osYV9PhSdTuGgwFIfCAyUHcv1hey3bsXg69XRsCrxv1vcklx1IJRehO5DjqCf9uKWUMFAiY2
 SVUe3Jb/NqZo//QEkV4bYEU9OesSIKrMAn4sOBnyvmso4fVcwsEyeKyNQgrrbOBc1ZyWympYADj
 yST0JvOxUNAK48Sune166CS/KyP8ImycqYx6RJX+GnscIk6v6gXvIpnPIK9eR3NJvfdDGN4+PR5
 SqD4PSYRrp1vdy0DLpiepoc1BjN4T5K6bI6O17/uLnEZKB4nPdal2r1QD2LroL3ZvkPbzg3r944
 KPBmeCbsRPLNOKNLa1i9koFhaAQ/WyF4W0XxgOADRKxp1GEglwjdovcUYyu53NmidlrRUzdCl7p
 /dTpalG2c9/CiJYIj25hGj/XLlNFnQchE+u/yv7+E29zT76bzneM1wPWJZT2HHAm8leDpdkDD0J
 NSHl0kXjWyY1h5BZILQ==
X-Authority-Analysis: v=2.4 cv=PMGaavqC c=1 sm=1 tr=0 ts=6acdc4af cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130022
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.20 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,209.85.216.69:received];
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
X-Rspamd-Queue-Id: 3AE3A4528A
X-Spamd-Bar: -----
Message-ID-Hash: 3R6P3CEY4MNTFIQUW4TJB2TFAY5SPZDP
X-Message-ID-Hash: 3R6P3CEY4MNTFIQUW4TJB2TFAY5SPZDP
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3R6P3CEY4MNTFIQUW4TJB2TFAY5SPZDP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

OP-TEE uses asynchronous notifications to request bottom-half
processing in normal world without waiting for a client call.

Allocate a TEE-to-REE RPMI signal and pass its ID to OP-TEE when
enabling asynchronous notifications. Queue bottom-half processing on
a private workqueue.

Initialize notification delivery before publishing the TEE devices.
Allow probe to continue if setup fails, keeping synchronous RPC
notifications available.

On cleanup, request that OP-TEE stop asynchronous notifications,
relinquish the signal and drain the bottom-half workqueue. Transport
relinquishment does not synchronize an already-selected callback.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/optee_private.h |  6 +++
 drivers/tee/optee/rpmi_abi.c      | 92 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index fcb291a43b7b..3bc65ffb6f99 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -207,11 +207,17 @@ struct optee_ffa {
  * @rdev: owning RPMI service device
  * @shm_map: lookup by the host-endian parcel ID and nonce pair
  * @nonce_ida: nonzero SHM nonces, reusable after successful parcel reclamation
+ * @signal: allocated TEE-to-REE doorbell, independent of logical keys
+ * @notif_wq: private bottom-half workqueue, NULL when inactive
+ * @notif_work: processes bottom halves requested by the RPMI signal
  */
 struct optee_rpmi {
 	struct rpmi_tee_device *rdev;
 	struct optee_shm_handle_map shm_map;
 	struct ida nonce_ida;
+	u32 signal;
+	struct workqueue_struct *notif_wq;
+	struct work_struct notif_work;
 };
 #endif
 
diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index 0ed2de96758e..6434767a2249 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -580,6 +580,92 @@ static int optee_rpmi_do_call_with_arg(struct tee_context *ctx,
 	return optee_rpmi_yielding_call(ctx, &req, rpc_arg, system_thread);
 }
 
+/* Yielding bottom halves run here, not in the transport retrieval worker. */
+static void optee_rpmi_notif_work(struct work_struct *work)
+{
+	struct optee_rpmi *rpmi = container_of(work, struct optee_rpmi,
+					    notif_work);
+	struct optee *optee = container_of(rpmi, struct optee, rpmi);
+
+	optee_do_bottom_half(optee->ctx);
+}
+
+static void optee_rpmi_notif_callback(struct rpmi_tee_device *rdev, u32 signal,
+				      void *cb_data)
+{
+	struct optee *optee = cb_data;
+
+	queue_work(optee->rpmi.notif_wq, &optee->rpmi.notif_work);
+}
+
+/* Relinquish is not a barrier for an already-selected transport callback. */
+static void optee_rpmi_async_notif_uninit(struct optee *optee)
+{
+	struct optee_rpmi *rpmi = &optee->rpmi;
+	struct rpmi_tee_device *rdev = rpmi->rdev;
+	int rc;
+
+	if (!rpmi->notif_wq)
+		return;
+
+	rc = optee_stop_async_notif(optee->ctx);
+	if (rc)
+		dev_warn(&rdev->dev, "stop notifications failed: %d\n", rc);
+
+	rc = rdev->ops->notifier_ops->notify_relinquish(rdev, rpmi->signal);
+	if (rc && rc != -EOPNOTSUPP)
+		dev_warn(&rdev->dev,
+			 "relinquish notification failed: %d\n", rc);
+
+	destroy_workqueue(rpmi->notif_wq);
+
+	rpmi->notif_wq = NULL;
+}
+
+/* Enable OP-TEE's bottom-half doorbell using the reserved RPMI signal. */
+static int optee_rpmi_enable_async_notif(struct optee *optee)
+{
+	struct optee_rpmi_enable_notif_req req = {
+		.op = cpu_to_le32(OPTEE_RPMI_ENABLE_ASYNC_NOTIF),
+		.signal_id = cpu_to_le32(optee->rpmi.signal),
+	};
+	struct optee_rpmi_status_resp resp;
+
+	return optee_rpmi_call(optee, &req, sizeof(req), &resp, sizeof(resp));
+}
+
+static int optee_rpmi_async_notif_init(struct optee *optee)
+{
+	struct optee_rpmi *rpmi = &optee->rpmi;
+	struct rpmi_tee_device *rdev = rpmi->rdev;
+	struct workqueue_struct *wq;
+	int rc;
+
+	INIT_WORK(&rpmi->notif_work, optee_rpmi_notif_work);
+	wq = alloc_workqueue("optee_rpmi_notif", WQ_UNBOUND, 1);
+	if (!wq)
+		return -ENOMEM;
+
+	rpmi->notif_wq = wq;
+
+	rc = rdev->ops->notifier_ops->notify_request(rdev,
+						     optee_rpmi_notif_callback,
+						     optee, &rpmi->signal);
+	if (rc) {
+		destroy_workqueue(rpmi->notif_wq);
+		/* Checked in optee_rpmi_async_notif_uninit(). */
+		rpmi->notif_wq = NULL;
+
+		return rc;
+	}
+
+	rc = optee_rpmi_enable_async_notif(optee);
+	if (rc)
+		optee_rpmi_async_notif_uninit(optee);
+
+	return rc;
+}
+
 /* Query and store the trusted OS revision. */
 static int optee_rpmi_get_os_version(struct optee *optee)
 {
@@ -720,6 +806,7 @@ static void optee_rpmi_remove(struct rpmi_tee_device *rdev)
 {
 	struct optee *optee = rpmi_tee_dev_get_drvdata(rdev);
 
+	optee_rpmi_async_notif_uninit(optee);
 	optee_remove_common(optee);
 	optee_shm_handle_map_uninit(&optee->rpmi.shm_map);
 	ida_destroy(&optee->rpmi.nonce_ida);
@@ -807,6 +894,11 @@ static int optee_rpmi_probe(struct rpmi_tee_device *rdev)
 
 	rpmi_tee_dev_set_drvdata(rdev, optee);
 
+	rc = optee_rpmi_async_notif_init(optee);
+	if (rc)
+		dev_warn(&rdev->dev, "async notifications unavailable: %d\n",
+			 rc);
+
 	if (optee->in_kernel_rpmb_routing)
 		blocking_notifier_chain_register(&optee_rpmb_intf_added,
 						 &optee->rpmb_intf);

-- 
2.34.1

