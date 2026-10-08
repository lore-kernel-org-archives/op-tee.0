Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ED8CA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:29:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id EA80A45047
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430195;
	bh=rARwHkFKjjbvU4trPhh8WewFiGLZGn3L4375nqv/M2U=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=BaFw6ANf82wJq5gXHLDOPpQJ8mzJa2inj6CkgboSmW8NyNsS5fmVO07qYFRBA6eA0
	 /tv9e4BVofVHH8MlJCUKqa0GzvQfMOE7X3+rlvh8MzHrmi5b4FuJvTFWVHX/8HNj2x
	 xd/D7FOWKY1uVo+sNpFk0jYYjM/oxySnHgAMIlpR9lHHdOBZrQw0jawCO4wbRfp4AP
	 RdwCTOEEsmZ5uaDPRA0/HFxjQjjwU05hXPFEaDybUTP9A0RBWXQNN0xXSL2mr7LUnE
	 htwFi2+nKmVJ4wCkPfQcDrV76DP8dfiJhjKZYXINJNrbmBD2wn8DRQbptW+5M3Zj6M
	 aUo/h0idAwPEg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 940D74530B
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXGVAFPR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Mx1MKqGt;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hiZp1950569
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gtcvnUkmVqQAt+w19mrphwNYznnIA8lvytR0upTmt8I=; b=cXGVAFPRnZDuaPt3
	K5OIuEuDZ+SFAt0mwwMToxWRUp7QQaBy6lZG/a6Fn8DwWvV/e8gafyFrljbR7pjG
	x2f84njQBKSSLHMjOZZSOtso6vIHBXGbZVxsTvIHEw4HtagDfeJYaw4sh0ZLoeXD
	vu5Y2unNTjTRPIiWSCLw8+BEcZVs2QnQ2kv2Aeh3yDNrhY5ixFRqWETkmvqWTFPJ
	KChjVKrnGGbyCT19olAzOqBCjuGDLN/+oEdEImSkjSKa6CIhmjKxPfbD62B+bdFf
	cShCQOzzrNolxgyp7mbXytNB9z+NPwF3FwwehU5Wp/+HsEAi++gGAQ0VI+lilCcr
	MFE4yQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe40wwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:45 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33713e5e6daso5790638eec.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430124; x=1792034924; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtcvnUkmVqQAt+w19mrphwNYznnIA8lvytR0upTmt8I=;
        b=Mx1MKqGtEPc+cv69p1fGcyqxTlyhSBlVRfMuaZbq57cQzDSCKeoodTVQ9gAHE3WzI8
         J0ppfQDNzdIOEgU1B1wCtdPHOUXOY2XxvWD0yEEOaUAmbuy3/U0gpwVjaT/BIV6cOWJf
         0y4LpU5qGaiSraBb0F/Ucu58BPjAvrP1Yb3YNVynMhPolJKYM601fJUtBRa1G8e9+Sy/
         cqfDtim32kliOs5UtV7MZpZBlP0qPelB1hS6BHRSf/mf1mSBsB4AS0qipbbaTLtq6on4
         x2jnOjaq29ph1fhoZ/ETBpTcQaQ/N/CugP5ooCuA3pk/9SnARZFqvSIxziz+3ep2t1sg
         LZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430124; x=1792034924;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtcvnUkmVqQAt+w19mrphwNYznnIA8lvytR0upTmt8I=;
        b=QtBen65xvKTmOZoBAvHqy//ZmcTzkQTUTse5q4KNjYDhT2y9fiYByBKV6aVRomisX3
         JCAQtzO2TgQE2IdxPUPtttcS+Md6iqk3Tnn3PsdAIdVJVkRffizm0MH4ge6RkPj7SpmB
         PnqFDjvfxmy2Q05E0NzqxJN7QvHVZ+TvLzWklO8oUmgZZPp1EOhsaVRAbnJqxHZyDFzA
         XwhF7zxArgR/TpGx+BrhxNsh9ctop33w1wIeRcsmpcA8fMRYIecgpna9OaKDVMZUUYuB
         9JomOZI61RK+6K+7YsyJ2gCGbErPb9SyhK+iMg7zaQCNjIZ8p/3JUOqEhbuUlMEAhflu
         ZiVw==
X-Forwarded-Encrypted: i=1; AKwUvBxZapUH37nLKpoIHiTv5u9gv1TddqQU3xN45mfjdSPxvThfPMUK3l2xUV6TTl7RhmBFw2o4waI=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLq8kQ1oWrpKn6Iahp2UMCUO7HRFswrjsydu2o5IwsTfIi2YuSx
	jbgpchYhusQS5/UNLruaTwvgVMx/9/JIQhh5b3griCsOJe8ig/euNPvHz0uCd8s60sb7N8IOKir
	iWFfiIhtFccaFjbVnZVxeHgtNcjYzOFEO553PQHZ0lsJc6wrrxP4G/Pl5PiMdF7I134b5+pI=
X-Gm-Gg: AYBFou1f0ef6mzlH9cpO4FI09liK5uIAmLD87jULi7sfp2A7NW4sHH4hoZaw34c0Rjp
	o4CvVOJ277Z90CB4eSYPfg7XXV/qsLVP37Rin5PG9R/Vz96GjeT1AqvdyvuKF6Ztcb9zMvhi4B2
	hQHkBzwu8hf2eLScITCxySMfhBzzQfkQSh0tEcAAWUq15mPSrNToEfLKELfuQFkJIt12ODPXQ5Q
	dBoU9/DS8mxUa34yxxb/XtgHJguZpfLxUGEJrigT4JDJAuVleojU101QnDTajRIVuoGbbXaCkPJ
	zrEU4ThJkyS5WvWg5YppzFNDd7zdoInHkwMYh5MYBGR2vtHq47xT69+GnkP/QYJEeL6AKkWWfiF
	Qp7DVZIXoeJ2CRWu/FJYzPdfWvM50710B3QghTRofxO5wcTsIju07+/FtxA==
X-Received: by 2002:a05:693c:8208:b0:34e:f948:d7da with SMTP id 5a478bee46e88-3515de4de02mr5309928eec.21.1791430123502;
        Wed, 07 Oct 2026 20:28:43 -0700 (PDT)
X-Received: by 2002:a05:693c:8208:b0:34e:f948:d7da with SMTP id 5a478bee46e88-3515de4de02mr5309843eec.21.1791430122071;
        Wed, 07 Oct 2026 20:28:42 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:41 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:07 -0700
Subject: [PATCH RFC v2 01/10] mailbox: add direct synchronous send support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-1-45939a13d223@oss.qualcomm.com>
References: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
In-Reply-To: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: qjMtYFhIUmz7AMdOVC2hdhWTOuyS3XKg
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac70ded cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=F4dQRpG-GgUDkkGoPlYA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX1Vdn41zrvblf
 37LNzXDOA802sZ1JK5eyKEVIEIYvevD6gDFgIlYCvP/yS3fk+j3dQ6vGcRjyRDr1f1XvPpAqnZR
 JI7mk2FkLUfJ+/dMsCOs1Xn0bFcHcio=
X-Proofpoint-ORIG-GUID: qjMtYFhIUmz7AMdOVC2hdhWTOuyS3XKg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX6cZsHR/a361K
 rTTa91dQTeaZujgITCJIyvLYUNjsjORCyIqrV5U4JWLE3ydIKrkg2DeohpKXO6jLVkCVk+YJ7yN
 RXuVeXffwzSuO9pC5n567Oa+OJYIASeqSXzK1EFYDSIfK8rqhfVGmQXbQhA6ZTMX46EdgWDgZpR
 6gnzqgptFyNwCuUPUgpWVgtz6ZhA4tBltOP973FD383q0/CvbnVAo0xGoH5Sui0hJSQfoC3dVE/
 81HeAwKLqE4jJJtmF9FiTSG6yzQFFPvdz4avT0uSi83Nu60pLMgqmCbK4ior9UHcGZmgvJfqKUI
 sXCOibxGWeBfy3JHadHH2R4/0TDvQSQn/aukjH9oV9InCAxL5rrpRphjO+7AJCVYNDRj0h9ogfF
 BiIGZ0JaS48JL12mdIRMYRkOPktyyfKFNSzdHZbVG043o0u1lZXZ6pT0b0FQljZ3C0YuQLnoDXh
 OVeamB739Z5KJPsNtfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org,oss.nxp.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[74.125.82.198:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 940D74530B
X-Spamd-Bar: ---
Message-ID-Hash: P63O572Z6V3DGJZ2UBJFU5WLXMR3NMSH
X-Message-ID-Hash: P63O572Z6V3DGJZ2UBJFU5WLXMR3NMSH
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/P63O572Z6V3DGJZ2UBJFU5WLXMR3NMSH/>
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

