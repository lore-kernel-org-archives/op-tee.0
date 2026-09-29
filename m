Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8C3CA5FAD
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:18:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E6B6D451C6
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790651906;
	bh=rARwHkFKjjbvU4trPhh8WewFiGLZGn3L4375nqv/M2U=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=TNEtStIzj2d2TYe0Ct6hJxGkFxpa3D2y0T9o+LTPWr8gIQQKE1TUDZ/UEyg3mozpy
	 m/IOVsRJOmtFP7mI24Iql/hUDS/UzEl35i02IclfYRiJ7sxXWHaHXrvIMvs6n7r7m8
	 S80JXhJuMaRftX9j2ciPAlxiJS2nJQxGLMcKbTq2hg/Mqiknna0BEUGjoWDA6IJVle
	 sBtyuZYgrQ4WXq0cflaHtRtkEjqDK8sh+xNb8XVh3wVt8xv03ZevB0HbYAH2zysgH0
	 amYAk8wfJWmGAeAglzAI5XpemU2AmvQbas/hco8rISrrBaqcpwI6DkC3FUf9djdsCJ
	 kWnkhPXVX1ZGg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 26910451B6
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:48 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UsgkN6yF;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Sl5uKPVv;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0jOQi3619462
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gtcvnUkmVqQAt+w19mrphwNYznnIA8lvytR0upTmt8I=; b=UsgkN6yFojUiuOd3
	DOCjn11uCmmzBbcO9ysR/mgKI240zYFG/7WDi4NudPTl+zLm0W676rPem4wQyFbA
	CZoevaxAvaayMeObkQo2Nc/7GAVlhgbzbF8mHjUyYjk6f9lmw4y7S65DzuYWOf7/
	M9mf+hmfUfW2ELT0p5QW92QCTcUrjnFzs0PcrOwIF8VlwD8+s+2Vb3f0QvzLJQUC
	tYZL/VAqzI4qTP71OkGlDdRBlvRZZROaxDCEk5QcJVeXbivFbuXlfIOmuC9hYbiJ
	uqA6+jWLAKP/ZOyoodAQKU1fSSUNFNE8GjVaEy6uw9KSK/4PuEK+JQzNtjhvgfNZ
	1bzOxg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynb6ky0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:47 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso2356461c88.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790651866; x=1791256666; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtcvnUkmVqQAt+w19mrphwNYznnIA8lvytR0upTmt8I=;
        b=Sl5uKPVvNU1gLCZPXWzBE9FpFv5FtsLtLsZ81dIT7V0sq3lqVohCbTYBiLRj+s2lAn
         DB/TRbvdqRqrJFXSv0E8UVjevu6ge2YblVtrRunwSWjw5JSBJcYE0lmUE+m0fBmLfNqU
         L0wcKhIjQPKct9Sc6X0xn6uCuTdqZrr9yBIXCh7//xi635A9HMu02zsmy/OFxVz/NWfo
         o7C77pl2/uPBAeME1C1x7q83KZSt45/4zMTeNS6WgNPG4KTKIyV4LbV6ZSAXHG+u0r8M
         l1d7xvktT22piJku1M2oqb2lFyAoLU3kvjVZMTM3ywP805gqn+Ce/xzx5PwjDXKl712o
         Ah/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651866; x=1791256666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtcvnUkmVqQAt+w19mrphwNYznnIA8lvytR0upTmt8I=;
        b=npoc7YfrhHZRG6tKnFf/LYuWpLuKdocArlePaM+D//gnYBoZ6PHfXk20JOvczR8NvX
         LavkEoyyD2AIRbqlIW+h+/QDJOEN9/3G/SN45O9FCcY2ovjD8bkdLBWE4kZ+AwVNAz6D
         pUj4rouNbb9VKVBla97QTg710Nl0jKWK54V9Ft7BdEjiKyhQ+KsF2uZ3/tI255kNJUBz
         XjghRUQ/lPbQ3w6AtHbIZsjb58YGlAts5EYawjk2b+kMmZQTgJ19Qs6AEhwqjhB9uxCn
         51vppPrCVbBsf8OAlhXPvuJEVBXoJfl+hKs7fGYTmFuUeqkWCe96GGYuOE4w4O9eoXhF
         5z0w==
X-Forwarded-Encrypted: i=1; AKwUvBzLXjWC7L6hlTxcRfO9o79F2cSa+Pi94/14Sr/6htqceAMwhgFBc1/T/D+YyMOlMOtaM15iYJw=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++km33D1cpoJbMFzWAhE5O8tc65bFkbECig0UJNzmRKJVY9SDsVU
	haniMoFNBLJVQcY0pxPU9E2ouveEAcO8ykGDIm19JLtOukrzxGqh/eBDa5pHW6w7PmBuYAR29mi
	MrsEqJhAjvd156PkYd90wWi+Wmzjaoj8kQvkS8BgQaIIrh3mEYd9lFNkyZNiwPoaA5Kugz38=
X-Gm-Gg: AYBFou3sq5vL8ZxwMjaZvlalVwqn2uOKSqRkZ4HqpkGb0DMa/c8+0dm0gZp+VcfLhrc
	GuzU/bM3iwQM4F5lCRVYP3CZTK4fT0wYoiwfeG89zbvD8NhV3lubmTSLbQ2PJ1G1MBNiSkjCRDR
	Nxib5wQpp/JFH1LYUILYWK7AoadYb2BsEHjwkxzgs7QSm7mo/VnoJ3bNQ4EBbOlPls+5Cxqqpk7
	L2N0RAUDW1oA0kR83QkQhWffcF0e/Oo0l7IKW1cANz7h+uq+NOsX+onYqVBpflRmffrZ+PZodvN
	inIzaDFmxeB0Sw94sJH82Je/ugye0aeyMVLQiFfpEYPiwZDkUn9INvmwnwd1P9LT2nFQkwDbQC9
	iWLUe6BDZrCoVTH2QEN9ti0tnqgFVwgEA/P8YRj0naho6Z6UoTzRtFFgcWtA=
X-Received: by 2002:a05:701b:428e:20b0:143:298e:913d with SMTP id a92af1059eb24-146d096d371mr12208807c88.47.1790651866222;
        Mon, 28 Sep 2026 20:17:46 -0700 (PDT)
X-Received: by 2002:a05:701b:428e:20b0:143:298e:913d with SMTP id a92af1059eb24-146d096d371mr12208779c88.47.1790651865636;
        Mon, 28 Sep 2026 20:17:45 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm24789368c88.11.2026.09.28.20.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:17:45 -0700 (PDT)
Date: Mon, 28 Sep 2026 20:16:52 -0700
Subject: [PATCH RFC 01/10] mailbox: add direct synchronous send support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-riscv-rpmi-tee-abi-v1-1-04908b81d885@oss.qualcomm.com>
References: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
In-Reply-To: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX4lGCACpnhmwM
 IRUaGJjWGrFVILL7wWt+CSC1uJZt1TxE4TeLZFZDY+kJboXJKXC61q1TALzYcqdqnLuK7yytVGe
 ZSoKm4mA2AW19kMv1P65MkoHbWBcD7W/Dxpj+81zfOppJ2k/nYv+vhsAyrOeEgxn/+Tq4vxjble
 dn0LWx6/Oxira9C/4BudgO8dM0MJD+Hs6crBKCoPNVjLbHvTHTkDzx6cuzIFkcb5GrjGuNZWN/p
 z5qKf1VcYyOfr2m6xI242f+whK9i8cJOIdHPIvHYOOmIydZqv7SKC8tDlkO1WjiCbBYhBK9iEpX
 f8EXVjKY9vca0mexp/Ez2yaQoH1ogfa0sFYjD7eS5iUovvhH4F2KZUPJMDZGLuGnzy2JPuXcqhc
 WX4U+p27ZTftDZbFSDtsDji4H9fCyJXonaLmYRB93UYlLAiKxRrJ7pXXSAlaENNEhVeW3eFbkZM
 byIc1ItCqEjUowr3cSg==
X-Authority-Analysis: v=2.4 cv=K+e3jCWI c=1 sm=1 tr=0 ts=6abb2ddb cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=F4dQRpG-GgUDkkGoPlYA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX/zP3hBdqK60L
 BhJXPKxtpVkswqatdDU7IV4YNazUNlcoCqCawGJo9hznuishWCgU4E3xM9bCLhp28VKosl6MyzD
 /vFjs/Kgk1w3d5TlCl96KZ2kYZ84Q6A=
X-Proofpoint-ORIG-GUID: QGytO4TWnYSic8ORmSZIK2XA9xPUVboU
X-Proofpoint-GUID: QGytO4TWnYSic8ORmSZIK2XA9xPUVboU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.69:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 26910451B6
X-Spamd-Bar: ----
Message-ID-Hash: LNNH4E4ONQZ5D625SWQS6V4DRAQ5DWXG
X-Message-ID-Hash: LNNH4E4ONQZ5D625SWQS6V4DRAQ5DWXG
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LNNH4E4ONQZ5D625SWQS6V4DRAQ5DWXG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Some mailbox controllers can complete a transaction entirely within
the calling context, without going through the queued TX state
machine or a TX-done interrupt. Add a synchronous send path so their
clients can request one and wait for the result directly.

Controllers advertise support via the new send_data_sync() op and
clients opt in by setting tx_sync when requesting the channel.

Channels bound this way must not call mbox_chan_txdone() or
mbox_client_txdone(), and mbox_send_message() and mbox_flush() now
reject them, since only mbox_send_message_sync() is a valid
transmit path. The client remains responsible for serializing calls
to mbox_send_message_sync() against mbox_free_channel().

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/mailbox/mailbox.c          | 72 ++++++++++++++++++++++++++++++++++++--
 include/linux/mailbox_client.h     |  3 ++
 include/linux/mailbox_controller.h | 10 ++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index efacd24a085d..c640b19de608 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -166,6 +166,12 @@ EXPORT_SYMBOL_GPL(mbox_chan_received_data);
  */
 void mbox_chan_txdone(struct mbox_chan *chan, int r)
 {
+	if (unlikely(chan->txdone_method & MBOX_TXDONE_BY_RETURN)) {
+		dev_err(chan->mbox->dev,
+			"TX-done notification on direct synchronous channel\n");
+		return;
+	}
+
 	if (unlikely(!(chan->txdone_method & MBOX_TXDONE_BY_IRQ))) {
 		dev_err(chan->mbox->dev,
 		       "Controller can't run the TX ticker\n");
@@ -187,6 +193,12 @@ EXPORT_SYMBOL_GPL(mbox_chan_txdone);
  */
 void mbox_client_txdone(struct mbox_chan *chan, int r)
 {
+	if (unlikely(chan->txdone_method & MBOX_TXDONE_BY_RETURN)) {
+		dev_err(chan->mbox->dev,
+			"TX-done notification on direct synchronous channel\n");
+		return;
+	}
+
 	if (unlikely(!(chan->txdone_method & MBOX_TXDONE_BY_ACK))) {
 		dev_err(chan->mbox->dev, "Client can't run the TX ticker\n");
 		return;
@@ -278,6 +290,9 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 	if (!chan || !chan->cl || mssg == MBOX_NO_MSG)
 		return -EINVAL;
 
+	if (chan->txdone_method & MBOX_TXDONE_BY_RETURN)
+		return -EOPNOTSUPP;
+
 	t = add_to_rbuf(chan, mssg);
 	if (t < 0) {
 		dev_err(chan->mbox->dev, "Try increasing MBOX_TX_QUEUE_LEN\n");
@@ -308,6 +323,43 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 }
 EXPORT_SYMBOL_GPL(mbox_send_message);
 
+/**
+ * mbox_send_message_sync - Send data and wait for transaction completion
+ * @chan: Mailbox channel assigned to this client
+ * @mssg: Client specific message typecasted
+ *
+ * For a channel bound with tx_sync, ask the controller to transmit @mssg and
+ * only return on completion. This function may sleep and must not be called
+ * from atomic context. @mssg must remain valid until this function returns.
+ *
+ * The direct synchronous path does not queue @mssg, does not use active_req,
+ * and does not use a TX-done notification. The client must serialize this
+ * function against mbox_free_channel().
+ *
+ * Return: 0 on success or a negative error code.
+ */
+int mbox_send_message_sync(struct mbox_chan *chan, void *mssg)
+{
+	int ret;
+
+	if (!chan || !chan->cl || mssg == MBOX_NO_MSG)
+		return -EINVAL;
+
+	if (!(chan->txdone_method & MBOX_TXDONE_BY_RETURN))
+		return -EOPNOTSUPP;
+
+	if (chan->cl->tx_prepare)
+		chan->cl->tx_prepare(chan->cl, mssg);
+	/* Try to submit a message to the MBOX controller synchonously */
+	ret = chan->mbox->ops->send_data_sync(chan, mssg);
+
+	if (chan->cl->tx_done)
+		chan->cl->tx_done(chan->cl, mssg, ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mbox_send_message_sync);
+
 /**
  * mbox_flush - flush a mailbox channel
  * @chan: mailbox channel to flush
@@ -326,8 +378,11 @@ int mbox_flush(struct mbox_chan *chan, unsigned long timeout)
 {
 	int ret;
 
+	if (chan->txdone_method & MBOX_TXDONE_BY_RETURN)
+		return -EOPNOTSUPP;
+
 	if (!chan->mbox->ops->flush)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	ret = chan->mbox->ops->flush(chan, timeout);
 	if (ret < 0)
@@ -343,7 +398,9 @@ static void mbox_clean_and_put_channel(struct mbox_chan *chan)
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->cl = NULL;
 		chan->active_req = MBOX_NO_MSG;
-		if (chan->txdone_method == MBOX_TXDONE_BY_ACK)
+		if (chan->txdone_method & MBOX_TXDONE_BY_RETURN)
+			chan->txdone_method &= ~MBOX_TXDONE_BY_RETURN;
+		else if (chan->txdone_method == MBOX_TXDONE_BY_ACK)
 			chan->txdone_method = MBOX_TXDONE_BY_POLL;
 	}
 
@@ -355,6 +412,14 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	struct device *dev = cl->dev;
 	int ret;
 
+	if (cl->tx_sync) {
+		if (!chan->mbox->ops->send_data_sync)
+			return -EOPNOTSUPP;
+
+		if (cl->tx_block || cl->tx_tout || cl->knows_txdone)
+			return -EINVAL;
+	}
+
 	if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
 		dev_err(dev, "%s: mailbox not free\n", __func__);
 		return -EBUSY;
@@ -380,6 +445,9 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 		}
 	}
 
+	if (cl->tx_sync)
+		chan->txdone_method |= MBOX_TXDONE_BY_RETURN;
+
 	return 0;
 }
 
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index e5997120f45c..32b1d5ad3bfa 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -21,6 +21,7 @@ struct mbox_chan;
  * @knows_txdone:	If the client could run the TX state machine. Usually
  *			if the client receives some ACK packet for transmission.
  *			Unused if the controller already has TX_Done/RTR IRQ.
+ * @tx_sync:		Bind the channel for mbox_send_message_sync().
  * @rx_callback:	Atomic callback to provide client the data received
  * @tx_prepare: 	Atomic callback to ask client to prepare the payload
  *			before initiating the transmission if required.
@@ -31,6 +32,7 @@ struct mbox_client {
 	bool tx_block;
 	unsigned long tx_tout;
 	bool knows_txdone;
+	bool tx_sync;
 
 	void (*rx_callback)(struct mbox_client *cl, void *mssg);
 	void (*tx_prepare)(struct mbox_client *cl, void *mssg);
@@ -42,6 +44,7 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 					      const char *name);
 struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
 int mbox_send_message(struct mbox_chan *chan, void *mssg);
+int mbox_send_message_sync(struct mbox_chan *chan, void *mssg);
 int mbox_flush(struct mbox_chan *chan, unsigned long timeout);
 void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
 bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 26a238a6f941..c7dc098324ef 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -18,6 +18,7 @@ struct mbox_chan;
 #define MBOX_TXDONE_BY_IRQ	BIT(0) /* controller has remote RTR irq */
 #define MBOX_TXDONE_BY_POLL	BIT(1) /* controller can read status of last TX */
 #define MBOX_TXDONE_BY_ACK	BIT(2) /* S/W ACK received by Client ticks the TX */
+#define MBOX_TXDONE_BY_RETURN	BIT(3) /* TX completes by function return */
 
 /**
  * struct mbox_chan_ops - methods to control mailbox channels
@@ -28,6 +29,14 @@ struct mbox_chan;
  *		transmission of data is reported by the controller via
  *		mbox_chan_txdone (if it has some TX ACK irq). It must not
  *		sleep.
+ * @send_data_sync: The API asks the MBOX controller driver, in non-atomic
+ *		context, to transmit a message on the bus and wait for the
+ *		transaction to complete. It returns 0 if the transaction
+ *		completed successfully or a negative error code otherwise.
+ *		The controller must not call mbox_chan_txdone() or
+ *		mbox_client_txdone() for this operation. Concurrent calls for one
+ *		controller must support them, serialize them internally, or
+ *		return -EBUSY for a conflicting transaction.
  * @flush:	Called when a client requests transmissions to be blocking but
  *		the context doesn't allow sleeping. Typically the controller
  *		will implement a busy loop waiting for the data to flush out.
@@ -53,6 +62,7 @@ struct mbox_chan;
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
+	int (*send_data_sync)(struct mbox_chan *chan, void *data);
 	int (*flush)(struct mbox_chan *chan, unsigned long timeout);
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);

-- 
2.34.1

