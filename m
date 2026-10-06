Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5442CA5FF0
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:44:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2D822445AC
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247444;
	bh=Y9kjvXncYREFAgUwoBtFPotlKXtYHvixiI47ICifGeI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=B0qOjdi9g2wq/aNS8fMNBvykQDSx7nuYCO69GBzZuJ6gKABeuBr1vAlt64P28zRN1
	 fA554tVQxo/vZkCdiT2D/2p1SbmRQOOv53/qnXR10iWQWMdBwgE+U2C0XecwiDE0ub
	 DPTLxW0uMQxckaKTQvZ/Z0WzybiUzYep91vp76n3oiliUMaHK++f+6EaDTJpQKPOuL
	 QjCszwlQPDHOxutkp8vGW8yULnoZdUqM1j+y38Xf77Xj/ZDsEG5fqRLNyT1+6HYEjM
	 1TC8V40JsTrWqcvZAv+ELz2UPgxJrfuNcNOcPkPH8xb1skvc23Pbf++OykKAdQwsoy
	 FDOwvytcmElJA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 43A2345507
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:40:05 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WJBHUgB0;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FvZba9Kj;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KMbMF2796857
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IMtzZeKCMAa+ITg30dZJWQsG6U23gbt3P7bYwJipKpI=; b=WJBHUgB0X3/JGa2J
	bTCFQ/W0ALtJnWq+kuZTmRbg41C6dw160r5JxyfoG5vtdAKFDMajG5UUKQUKSPJb
	+dc5DjZZ/zSIzNRomCYaQs7UKP374pWPbSRJ0gJm4rRsKxY1a03qtQPwj8QUND6g
	ot2lBIIIJF+f4TFnswk6DwZ3StMhrYWMBGo2zYPcg+P5B6JGo3TSwOIw8dAGmdy4
	OXrKebuIr8yDnEtn9ZBpEY7LUwGwFQN+kv8Urk4z3bkETiDmz0go90XEnhlPsQXq
	aPDNk9xElb+rY4y+G4aR0cDJEmwbyCVhceZDZ4QJoRgznVHXoLeWXzXi1jfzRFbT
	rknFog==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr098cm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:40:04 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30f1b904861so2787314eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247204; x=1791852004; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IMtzZeKCMAa+ITg30dZJWQsG6U23gbt3P7bYwJipKpI=;
        b=FvZba9KjPFurkX906oik97W4UhyDJPKWphTVP/iHgz/TJsuQ0Zha1xQWITnbsn3qjX
         4XXOCXiJdXK/Rwby7Kva66O7h8znz1mhahj/smK739kfvvwTCJjkhQ3e4Yvjk3yokUE8
         nHbRkKyi8fHy6cY33PCmXMpFK4Cn/GHji3OEMx+iIaKnUr5oPuokC4wiFUFDj7rJ+1hl
         JkFYkzqr81mkROQGl4nyf83vw5yQjI8hUOfaMlmzwtLmHzZerx6cR0anHWycWNIEtPZ9
         txZJiqNPF7+67rnOvryKbwn0HdkBLjDDF6zDRml3N+SjhqzUjqEZfw7XwOiRH1KjlNvH
         2aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247204; x=1791852004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMtzZeKCMAa+ITg30dZJWQsG6U23gbt3P7bYwJipKpI=;
        b=NvRxytEY65VY3DlQFlHEDnN8atqQLnl6c5cQJ02gulfB5B6/dRGH+5b+W+cGpk0bWk
         I5jW0yF8u6jCAx9kJLJKDMNdeIz5gJPToQmnHgeIHoWmYbs4dxdYvgjIgldk9sfH/h8S
         aKz9NaY45FrmD0TQ/9DH9H9pEXGy3kq2BanqxyldHrysDO6ZeXl8kXFiMSMNnjjSOQJH
         le6QWLxXWlIYRdN1sHMOhLmbznkiYGJ4WXdJb+ipPCqTObmyAj5K2a0LYxsRuGbWkfsb
         F2tIe6ZXTujISAZH6M91j4giZnQNAGZeYwVHC1/3D+7UL0RIS/VTbfxftusvuCFlkmNG
         mJtg==
X-Forwarded-Encrypted: i=1; AKwUvBzkNmv3Jjyi7Je2tBFyYbsX9dZuDktdrdNuW9iWyUCXq7PwlmnVHPDaqADDW7F6Ql4IOjy0OFM=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++no8rDxmk79Q59goMRZIm7//+e8ykppQ1Lc3syfXWUHG7jS5LeH
	U2vmN+ssaXPw0ocZgifeXoBt25ecy+83gZH2YuaUXcrYQzKNYZD0fHy6NcZ5Dt9qccisO3qOr4/
	AjlQMQ+kSsBSEe9qPPPbRgkbsWbpv2Fw5d2SlFdKMsSboZveeYnnrMAydefygP/rdKwTYDLQ=
X-Gm-Gg: AYBFou1YE+l6bPt8/xTWy4HYT5+SVEB5dXwnGD6/+ZYv3otbdhjxrmxwywj0FEC3mdU
	eX+LhbRu5aqjpqinP48OniH1cTodbMLjk79Uf7gZcJ3SQXICYJfZjtAPBNZ8ECgcIqc+7nr8bG2
	Awme4l6B74IHrfidAZjfKJRoWLWGSy+8lmwoTsESil01tZs3JuNcd1Ik6F3DiqaD337F8MqdmBm
	UBpN364tUms1hZ3n8tRa1SyFtw4rNVHB7JYgxH4emJpmiRRYkBnQYouHoNI8gDVoOmzfSMtGvAk
	8Ffpr0y7HbfL9pyRHAoZK0Sfp3WFa/NBdH5z1jjZRizKB2DyM70IW+ko2SwftIuxxa+SBezdg1K
	GLkPrZq9OCfkCQZ2LYkT3dQergGeWIvBa4u9iZ3cwyYamfTSpQoLh+suFiA==
X-Received: by 2002:a05:7301:fc09:b0:34d:755b:d60b with SMTP id 5a478bee46e88-35111514891mr11504995eec.34.1791247203563;
        Mon, 05 Oct 2026 17:40:03 -0700 (PDT)
X-Received: by 2002:a05:7301:fc09:b0:34d:755b:d60b with SMTP id 5a478bee46e88-35111514891mr11504954eec.34.1791247202887;
        Mon, 05 Oct 2026 17:40:02 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:40:01 -0700 (PDT)
Date: Mon, 05 Oct 2026 17:39:52 -0700
Subject: [PATCH RFC v2 8/8] tee: optee: support RPMI asynchronous
 notification doorbells
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-8-72f222e23ec1@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX2G7Dxjr5u3Yq
 sMV4/YvLD2nym/1YzZeHn/1uF54RZApY+rlC2L6IRMJ/5j0V2GI9Qq6TY4nuBDXtmBy4ZADkxHh
 sSzOSMcDR09ClqvPXkiZtKTpqw2tSnQEj3L3yCyDJn8LPsqG/PiW6P7wf8gxXMh9CwBsoGjTgy8
 eO5XU+wGfLfXYv/LINK27kN+whyNbh110A7q5hRw2aTPVjDB0+mleeLTqhwZH+U2L3+O8YQcxSv
 GYUwrJEu2mvEcAhkPA7yj736/GdwWKJouzLLR9NMD1yJrwTuJ08VsvgPZOoAqP3SDqeCwJ2xew+
 5OfWI/ilanLeS6ysY3DJBH7mB/t/87/QAkhAJZjBnv04IftSWQydkWHofBjPZSD6pUxDbER2x/p
 Yx3BJ/ENW6646SG45xM+wewq53nD3G6U0GuUnCosXoJRruAcAq3G9C6NowR8tXj4xyjW4cTJewU
 LnmJnPuFhjD4a9CQoZA==
X-Proofpoint-GUID: RIAuDqF9WnOYuqZQ_j7BI79s0Xk_2603
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfXzuayw9+PtaOl
 3i7jnjkERghz4laXJQLeqS0dY93SFMSai2SYsBzxsXUe6P3wqpa/MwisJua1uzM3t+YI+v9w8yZ
 dQM4i+jkqWg6HftwjWczVUvXk3qxuTk=
X-Proofpoint-ORIG-GUID: RIAuDqF9WnOYuqZQ_j7BI79s0Xk_2603
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac44364 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=nExbU_x0mLWtth5-Sj8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060001
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 43A2345507
X-Spamd-Bar: -----
Message-ID-Hash: 6NQBAOQTVRILXMZJFWWI7UCIQF3SCHIW
X-Message-ID-Hash: 6NQBAOQTVRILXMZJFWWI7UCIQF3SCHIW
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6NQBAOQTVRILXMZJFWWI7UCIQF3SCHIW/>
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
 drivers/tee/optee/rpmi_abi.c      | 87 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 07c27e322a71..e5c6381bb872 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -190,6 +190,9 @@ struct rpmi_tee_device;
  * @shm_rht: lookup by the host-endian parcel ID and nonce pair
  * @sec_caps: negotiated optional OPTEE_RPMI_CAP_* features
  * @notification_count: negotiated nonzero number of logical notification keys
+ * @signal: allocated TEE-to-REE doorbell, independent of logical keys
+ * @notif_wq: private bottom-half workqueue, NULL when notifications are inactive
+ * @notif_work: processes bottom halves requested by the RPMI signal
  *
  * Callers keep their tee_shm alive while using its registration. Lookup
  * returns a raw pointer; the mutex does not protect its lifetime after
@@ -203,6 +206,9 @@ struct optee_rpmi {
 	struct rhashtable shm_rht;
 	u32 sec_caps;
 	u32 notification_count;
+	u32 signal;
+	struct workqueue_struct *notif_wq;
+	struct work_struct notif_work;
 };
 #endif
 
diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index db541f3de425..ffe44d81e857 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -685,6 +685,88 @@ static int optee_rpmi_do_call_with_arg(struct tee_context *ctx,
 	return optee_rpmi_yielding_call(ctx, &req, rpc_arg, system_thread);
 }
 
+/* Yielding bottom halves run here, not in the transport retrieval worker. */
+static void optee_rpmi_notif_work(struct work_struct *work)
+{
+	struct optee_rpmi *rpmi = container_of(work, struct optee_rpmi, notif_work);
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
+	int ret;
+
+	if (!rpmi->notif_wq)
+		return;
+
+	ret = optee_stop_async_notif(optee->ctx);
+	if (ret)
+		dev_warn(&rdev->dev, "stop notifications failed: %d\n", ret);
+
+	ret = rdev->ops->notifier_ops->notify_relinquish(rdev, rpmi->signal);
+	if (ret && ret != -EOPNOTSUPP)
+		dev_warn(&rdev->dev,
+			 "relinquish notification failed: %d\n", ret);
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
+	int ret;
+
+	INIT_WORK(&rpmi->notif_work, optee_rpmi_notif_work);
+	rpmi->notif_wq = alloc_workqueue("optee_rpmi_notif", WQ_UNBOUND, 1);
+	if (!rpmi->notif_wq)
+		return -ENOMEM;
+
+	ret = rdev->ops->notifier_ops->notify_request(rdev,
+						      optee_rpmi_notif_callback,
+						      optee, &rpmi->signal);
+	if (ret) {
+		destroy_workqueue(rpmi->notif_wq);
+		/* Checked in optee_rpmi_async_notif_uninit(). */
+		rpmi->notif_wq = NULL;
+
+		return ret;
+	}
+
+	ret = optee_rpmi_enable_async_notif(optee);
+	if (ret)
+		optee_rpmi_async_notif_uninit(optee);
+
+	return ret;
+}
+
 /* Query and store the trusted OS revision. */
 static int optee_rpmi_get_os_version(struct optee *optee)
 {
@@ -823,6 +905,7 @@ static void optee_rpmi_remove(struct rpmi_tee_device *rdev)
 {
 	struct optee *optee = dev_get_drvdata(&rdev->dev);
 
+	optee_rpmi_async_notif_uninit(optee);
 	optee_remove_common(optee);
 	optee_rpmi_shm_rht_uninit(optee);
 	kfree(optee);
@@ -901,6 +984,10 @@ static int optee_rpmi_probe(struct rpmi_tee_device *rdev)
 
 	optee->ctx = ctx;
 	dev_set_drvdata(&rdev->dev, optee);
+	ret = optee_rpmi_async_notif_init(optee);
+	if (ret)
+		dev_warn(&rdev->dev, "async notifications unavailable: %d\n", ret);
+
 	if (optee->in_kernel_rpmb_routing)
 		blocking_notifier_chain_register(&optee_rpmb_intf_added,
 						 &optee->rpmb_intf);

-- 
2.34.1

