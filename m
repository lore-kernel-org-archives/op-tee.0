Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B17BCA5FAB
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:22:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6A79145221
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790652175;
	bh=AEdRkqJ5q2ViQ0onb9O+3QztfYgoGLIoo6CbMjrN97g=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=x27HYxQTwJT0n2MTcw1JDLBu8MNHhNwCNhjknX6J9m6HhX4hW0yOOs0F62quXq30n
	 pHtEBmBtU7szb7IDcSVOt6rYxZSJiu8Ooo1fLJF7I1T2dtKSbf4OCyRAVwcjcKvYd+
	 /m5bNrHn/I15UlxgroPDpJpS9SK+limcD8rL5vh4ocNc8R+nJwJlY802HsAkcP+hks
	 9Z0gUQd7uf+Usq8X0ejCgQc8W0NJO1S5UDrpAqEQ7B+a4jWTrpdJrT6DwDZ2K3DVzD
	 Z5IOhmuN3fi71KnZYIf/aAiNnO3JV9tszMmPRWOvuRyTMG+D946XaLk9CeD7HRKoqb
	 /jdeRToMeiDoA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C1B6E45508
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:18:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dty/HuyM;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GoJai2RH;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0jhva3211728
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UCahWMfr9Ztw0U9lvhxrZnbAatXAyLFYFzoNiR4W8/g=; b=dty/HuyMRDB+G3wq
	iGJA15QSFOyEJgt+gXLJ4z1rdyV3tOzvbOD7tAta2xtEfNTm4W8CwcvPx29rHR7K
	itOJTUV1FXjPaV9WBfjBpiD6Ptv8ruIyISPZ++A2LTeYBQQOP544kaVGAza8LoG1
	Q09pGhTdfq3JhDfAYDm8BhcYxNq4hm3k91SyoOD33gD6Sdd6Wp56Zhpvz94TusMq
	TaTwrSiLFDi1Ey5DyLseVh06uY8O4rKH8l+eZVwiy9Xr+5YN29XELdP6QhNnCU0e
	Qo0WbJfjkC0q9IjkcPeCumkNS9z+R34Lmvo9VKxpqoZWmCo46QhGCKe/dr2skG/E
	IVcaMw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h00s4rvv6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:59 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34316295d86so6075995eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 20:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790651879; x=1791256679; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UCahWMfr9Ztw0U9lvhxrZnbAatXAyLFYFzoNiR4W8/g=;
        b=GoJai2RHSKvupIeefWmWQFlEMfTSKfXhvBrTgiwAs0bxxUeE/X6F5wcmCxxrDApbjd
         frhPM1qFz2dcvjTGhxhEfAm9obUEGb4JONBBg+QR8uY4GrfaBxs1XQijsHnkEYt0+sgs
         54AcA1nV0ZX81PRCR9J+8167WWKfq9WnK0QvEQTkglT0wPY7OPTXp7pIgUxbcMaJ86bZ
         /5IA4OcSCEpsSsjsV4uCO7JqvNCYRD+O/lalxDWFrj0qvrCwIR9hJFmQeDCYEqccbjK8
         nJxE+0ZWUeN74SXsv9QNrRQVI8DJECHYTllC9HmsdlNQ6RsxSr54FgtuHEfwp+O3DmcM
         H4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651879; x=1791256679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCahWMfr9Ztw0U9lvhxrZnbAatXAyLFYFzoNiR4W8/g=;
        b=KLQRMlPg35JUKItpX3wg0i8FfzzNQQ05SFldO0Qzo96gST6E7whsoYPOHBLHTckI/g
         dQUg0/RyB8NbUzdbjr1Ltf5EERbQKmy0E29gjAT6vYzWmrSW4OSXJHuy1hMW9pn/VYhz
         vUnpf7QBJYmSpHj01ZB7SVxAHx0iizYdM3ogjYv47tH1v/plNP/S8TG98wgqm8g4JxRp
         D9Gpio33JEg5UNdvm5jwkBGPhB6Ap7X29BEYagt9jofp+MkjqVpSbLWxnC4I+95dTaSC
         8ljNKhOvFp4LB4xlBuCHiTH2HnQsNEPRkAugDPwPVpKJU5nf+OJbFb/lhp0+eBTXYW0Y
         1Dkg==
X-Forwarded-Encrypted: i=1; AKwUvBwdOrVlerUEKgFx/gd1jg1dr7uLQWT909370qLv+cR20f0XgOECb6P378sEV15zMJZhWg9VXUE=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kvUPvMYVbQWP9iZ7cgmWIOJfjbJ5nBazf41Vq6aPWGISCyPPp7
	cOp65Ny95ZWXI9kKhfqdyTzNZfvVLTt8zPJcdf4/oo9nwEdSFD01HSeT2tkn6HVv0VezEsy1DiR
	DKzElbV1s6EPZGlw/qAbbKqCuwkLTyhy0SG1LdeFUh6nD0ylrHRaitMRuckhJNVLnGw2W2OY=
X-Gm-Gg: AYBFou3dhkB1ar7fGpbUUElmKPrRqmlPoWDJ7ruHs/+CSEDkUk4ntHJIjcYseNG3kfc
	Vvyay5lS/R3cy0kKDBVDZp0Mp9CAsIahdgqXeMHvxeG8oFOjdObWe/qOi9N7p526BtdECu8JG7+
	oS+RKg2tOOjq54b81e9yQutLsUt1pNSr/CXb0+eNpWzHM1FkXBvLNguq0OYaWWhB7WN58InaNDo
	mWPlj5vdK6OGq/LO4FbIgCblQd1ARZxjzr+h1OPNITK6pnilgHYs9LkP8UOWAnF5ZwGwZhBOj7t
	Ncbbzz0ZtLPLBvo6vu8H7psfK7o2p02ui01ziL1y9rLHOrmBbfJNjB9af6QOjzv2XV6XVVxKy5l
	HCzDIF4s2dtCHTHdMuJu5TUJIWi7fdCv56l/yFLmO+J7wnfz41NG+FUMIoPA=
X-Received: by 2002:a05:701b:418e:20b0:147:9ad0:cf25 with SMTP id a92af1059eb24-1479ad0d354mr10488501c88.46.1790651878436;
        Mon, 28 Sep 2026 20:17:58 -0700 (PDT)
X-Received: by 2002:a05:701b:418e:20b0:147:9ad0:cf25 with SMTP id a92af1059eb24-1479ad0d354mr10488468c88.46.1790651877725;
        Mon, 28 Sep 2026 20:17:57 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm24789368c88.11.2026.09.28.20.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:17:57 -0700 (PDT)
Date: Mon, 28 Sep 2026 20:17:01 -0700
Subject: [PATCH RFC 10/10] firmware: riscv: rpmi-tee: add signal bus
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-riscv-rpmi-tee-abi-v1-10-04908b81d885@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX1idVrVgu2ftI
 DWImVgg/wIFG/OjQnIarreTx6sJ/YuA9leD8tiQA4N983XD21eWJ6aqEWQj6aHPBx5OTafT7BGc
 Lv/ZdXhCERaXPT5issF1tPi4DpGJE2c=
X-Authority-Analysis: v=2.4 cv=ALbfqNVA c=1 sm=1 tr=0 ts=6abb2de7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wM0P6sExNPXVFaQqqxQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX7oTnhBgmrqJ7
 yXA2JsblV8vaK0GSn+e9EmL2stgEsUlD97YstpsWStKfC8qrAsVdrNDbpXjHJzsELbD71LLNuoX
 G6vMQ5LAfo5Dj/J4VEc8JadQwywHYQwveIZjvU73e3y+YcsUO0rA4zudN84W5lK9htPQLW4NUy5
 lOIDOG4kaeDbvEMECuXmFEu6ZyKfZdCczje43ssQOCGUiyLojT2Fj+Q5sx3X/OMxX5omD6ibRUZ
 icrrppRdpV5gbKFC+OxyAEFHysb+TgLJJ1jXkNhopuws0y6st/9FPQrZn/mtc3pi7DJpp9PyHG7
 NjCD4NoaVoBLN42kpPdwlCwdEhuTNkm9ajTZoUz/AKUnvmSs4wf3cFz9VqmehfLICtskWTQX4xl
 Lj/fwfCTKN+ILoRaArRZC7Fo5g7mC/ENhz55KKoXKns5C/vrbOqaG0Jz5xfacJmaFBJw2fZYcyz
 sISpjOrcugnXgjURyMA==
X-Proofpoint-GUID: 5diOD46N8Y9t6XiCkEkaxM0Lhvq2o-qU
X-Proofpoint-ORIG-GUID: 5diOD46N8Y9t6XiCkEkaxM0Lhvq2o-qU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
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
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C1B6E45508
X-Spamd-Bar: ----
Message-ID-Hash: BLZREU4NWXFEV3PS2TLEURDDORONWBTW
X-Message-ID-Hash: BLZREU4NWXFEV3PS2TLEURDDORONWBTW
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BLZREU4NWXFEV3PS2TLEURDDORONWBTW/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add support for RPMI TEE signal buses, letting service devices
exchange asynchronous notifications with their TEE endpoint in both
directions. Clients can request and relinquish specific incoming
notifications, and raise outgoing ones.

Expose this through a new rpmi_tee_notifier_ops, and tear it down
cleanly on removal before the service devices themselves are
unregistered.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/driver.c | 631 +++++++++++++++++++++++++++++++
 include/linux/rpmi_tee.h                 |  24 ++
 2 files changed, 655 insertions(+)

diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index 0004f54c7d89..cc0a42d471e3 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -8,15 +8,21 @@
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/cleanup.h>
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/rpmi_tee.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 #include "sysinfo.h"
 
@@ -39,6 +45,12 @@
 #define RPMI_TEE_SYSTEM_WHOLE		0
 #define RPMI_TEE_SYSTEM_SELF		3
 
+/* Signal service IDs. */
+#define RPMI_TEE_SRV_SIGNAL_BUS_SETUP		0x05
+#define RPMI_TEE_SRV_SIGNAL_BUS_TEARDOWN	0x06
+#define RPMI_TEE_SRV_SIGNAL_RAISE		0x07
+#define RPMI_TEE_SRV_SIGNAL_RETRIEVE		0x08
+
 /* Memory service IDs. */
 #define RPMI_TEE_SRV_MEMORY_PARCEL_CREATE	0x09
 #define RPMI_TEE_SRV_MEMORY_PARCEL_RECLAIM	0x0c
@@ -58,6 +70,15 @@
 
 /* TEE_MEMORY_SEGMENT_SEND flags. */
 #define RPMI_TEE_SEGMENT_LAST		BIT(31)
+
+/* TEE_SIGNAL_BUS_SETUP feature value and TEE_SIGNAL_RETRIEVE flags. */
+#define RPMI_TEE_SIGNAL_MODE_MASK	GENMASK(1, 0)
+#define RPMI_TEE_SIGNAL_WIDTH_MASK	GENMASK(11, 2)
+#define RPMI_TEE_SIGNAL_INDEX_MASK	GENMASK(31, 12)
+
+#define RPMI_TEE_SIGNAL_MODE_SYSTEM_MSI	1
+#define RPMI_TEE_SIGNAL_MORE_AVAILABLE	BIT(31)
+
 /**
  * struct rpmi_tee_probe_features_req - TEE_PROBE_FEATURES request
  * @feature_id: TEE feature identifier to query.
@@ -222,8 +243,110 @@ struct rpmi_tee_parcel_reclaim_resp {
 	__le32 flags;
 } __packed;
 
+/**
+ * struct rpmi_tee_signal_bus_setup_req - SIGNAL_BUS_SETUP request
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @bus_width: Total number of signal IDs in the bus.
+ * @sender_signals: Number of signal IDs reserved for the endpoint sender.
+ */
+struct rpmi_tee_signal_bus_setup_req {
+	__le32 target_id;
+	__le32 bus_width;
+	__le32 sender_signals;
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_bus_teardown_req - SIGNAL_BUS_TEARDOWN request
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ */
+struct rpmi_tee_signal_bus_teardown_req {
+	__le32 target_id;
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_raise_req - SIGNAL_RAISE request prefix
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @signal_count: Number of signal IDs in @signals.
+ * @signals: Signal IDs to raise.
+ */
+struct rpmi_tee_signal_raise_req {
+	__le32 target_id;
+	__le32 signal_count;
+	__le32 signals[];
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_raise_one_req - Single-signal SIGNAL_RAISE request
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @signal_count: Must be one.
+ * @signal: Signal ID to raise.
+ */
+struct rpmi_tee_signal_raise_one_req {
+	__le32 target_id;
+	__le32 signal_count;
+	__le32 signal;
+} __packed;
+
+/**
+ * struct rpmi_tee_signal_retrieve_resp - SIGNAL_RETRIEVE response prefix
+ * @status: RPMI completion status.
+ * @flags: Response flags.
+ * @target_id: TEE endpoint identifier that owns the signal bus.
+ * @signal_count: Number of signal IDs in @signals.
+ * @signals: Retrieved signal IDs.
+ */
+struct rpmi_tee_signal_retrieve_resp {
+	__le32 status;
+	__le32 flags;
+	__le32 target_id;
+	__le32 signal_count;
+	__le32 signals[];
+} __packed;
+
+enum rpmi_tee_signal_state {
+	RPMI_TEE_SIGNAL_ACTIVE,
+	RPMI_TEE_SIGNAL_RELEASING,
+};
+
+struct rpmi_tee_signal_reservation {
+	struct rpmi_tee_device *rdev;
+	rpmi_tee_notifier_cb cb;
+	void *cb_data;
+	enum rpmi_tee_signal_state state;
+};
+
+struct rpmi_tee_signal_bus {
+	struct list_head node;	/* Link in the notification signal-bus list. */
+	struct mutex lock;	/* Serializes reservation state and lifetime. */
+	struct xarray reservations;
+	u32 endpoint_id;
+	u32 width;
+	u32 tee_to_ree_count;
+};
+
+/**
+ * struct rpmi_tee_notif_state - Signal notification state
+ * @buses: List of signal buses established for TEE endpoints.
+ * @work: Retrieves and dispatches pending TEE-to-REE signals.
+ * @wq: Workqueue used for @work.
+ * @ops_lock: Serializes public notification operations with signal-bus
+ *	    teardown. It prevents new operations after @shutting_down is set and
+ *	    serializes rpmi_tee_op_notify_relinquish() with the empty
+ *	    SIGNAL_RETRIEVE release barrier.
+ * @feature: SIGNAL feature value reported by the transport.
+ * @irq: Linux IRQ assigned to the signal notification interrupt.
+ * @irq_requested: Whether @irq has been requested.
+ * @shutting_down: Prevents public notification operations during teardown.
+ */
 struct rpmi_tee_notif_state {
+	struct list_head buses;
+	struct work_struct work;
+	struct workqueue_struct *wq;
+	struct mutex ops_lock;
 	u32 feature;
+	int irq;
+	bool irq_requested;
+	bool shutting_down;
 };
 
 struct rpmi_tee_mbox {
@@ -245,6 +368,15 @@ struct rpmi_tee_child {
 	struct rpmi_tee_device *rdev;
 };
 
+/**
+ * struct rpmi_tee_transport - State for one RPMI TEE transport instance
+ * @dev: Parent platform device.
+ * @mbox: RPMI mailbox transport state.
+ * @self_id: Local REE physical endpoint identifier.
+ * @devices: List of registered TEE service devices.
+ * @mem: Memory parcel operation state.
+ * @notif: Signal notification state.
+ */
 struct rpmi_tee_transport {
 	struct device *dev;
 	struct rpmi_tee_mbox mbox;
@@ -978,6 +1110,275 @@ static int rpmi_tee_op_memory_share(struct rpmi_tee_device *rdev,
 	return rpmi_tee_op_parcel_create(rdev, args, false);
 }
 
+static struct rpmi_tee_signal_bus *
+__rpmi_tee_find_signal_bus(struct rpmi_tee_transport *priv, u32 endpoint_id)
+{
+	struct rpmi_tee_signal_bus *bus;
+
+	list_for_each_entry(bus, &priv->notif.buses, node) {
+		if (bus->endpoint_id == endpoint_id)
+			return bus;
+	}
+
+	return NULL;
+}
+
+static struct rpmi_tee_signal_bus *
+rpmi_tee_find_signal_bus(struct rpmi_tee_transport *priv, u32 endpoint_id)
+{
+	lockdep_assert_held(&priv->notif.ops_lock);
+	/* Do not access signal buses after notification shutdown starts. */
+	if (priv->notif.shutting_down)
+		return NULL;
+
+	return __rpmi_tee_find_signal_bus(priv, endpoint_id);
+}
+
+/* Invoke an active signal callback without holding the bus lock. */
+static int rpmi_tee_dispatch_signal(struct rpmi_tee_signal_bus *bus,
+				    u32 signal)
+{
+	struct rpmi_tee_signal_reservation *resv;
+	rpmi_tee_notifier_cb cb = NULL;
+	struct rpmi_tee_device *rdev = NULL;
+	void *cb_data = NULL;
+
+	if (signal >= bus->tee_to_ree_count)
+		return -EPROTO;
+
+	scoped_guard(mutex, &bus->lock) {
+		resv = xa_load(&bus->reservations, signal);
+		if (resv && resv->state == RPMI_TEE_SIGNAL_ACTIVE) {
+			cb = resv->cb;
+			cb_data = resv->cb_data;
+			rdev = resv->rdev;
+		}
+	}
+
+	if (cb)
+		cb(rdev, signal, cb_data);
+
+	return 0;
+}
+
+/* Release signal IDs that have passed the empty-retrieval barrier. */
+static void rpmi_tee_signal_bus_drop_releasing(struct rpmi_tee_signal_bus *bus)
+{
+	struct rpmi_tee_signal_reservation *resv;
+	unsigned long index;
+
+	guard(mutex)(&bus->lock);
+	xa_for_each(&bus->reservations, index, resv) {
+		if (resv->state != RPMI_TEE_SIGNAL_RELEASING)
+			continue;
+
+		xa_erase(&bus->reservations, index);
+		kfree(resv);
+	}
+}
+
+/**
+ * rpmi_tee_retrieve_signals() - Drain pending TEE-to-REE signals
+ * @priv: RPMI TEE transport
+ *
+ * Retrieve and dispatch signals until the firmware reports no pending data.
+ * Return relinquished signal IDs to their buses only after that empty
+ * retrieval.
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+static int rpmi_tee_retrieve_signals(struct rpmi_tee_transport *priv)
+{
+	size_t resp_len = priv->mbox.max_msg_data_size;
+	u32 flags, endpoint_id, signal_count, i;
+	struct rpmi_tee_signal_bus *bus;
+	s32 status;
+	int ret;
+
+	struct rpmi_tee_signal_retrieve_resp *resp __free(kfree) =
+		kzalloc(resp_len, GFP_KERNEL);
+	if (!resp)
+		return -ENOMEM;
+
+	for (;;) {
+		scoped_guard(mutex, &priv->notif.ops_lock) {
+			resp_len = priv->mbox.max_msg_data_size;
+			ret = __rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_RETRIEVE,
+					      NULL, 0, resp, &resp_len, &status);
+			/*
+			 * A signal may be raised after a clear MORE_AVAILABLE
+			 * response and before relinquish. Reusing the ID could
+			 * deliver it to the wrong client.
+			 * Reuse relinquished IDs only after an empty retrieve.
+			 */
+			if (!ret && status == RPMI_ERR_NO_DATA) {
+				struct rpmi_tee_signal_bus *bus;
+
+				list_for_each_entry(bus, &priv->notif.buses, node)
+					rpmi_tee_signal_bus_drop_releasing(bus);
+			}
+		}
+
+		if (ret)
+			return ret;
+		/* The firmware has no more pending signals. */
+		if (status == RPMI_ERR_NO_DATA)
+			return 0;
+		if (status)
+			return rpmi_to_linux_error(status);
+		if (resp_len < sizeof(*resp))
+			return -EPROTO;
+
+		flags = get_unaligned_le32(&resp->flags);
+		endpoint_id = get_unaligned_le32(&resp->target_id);
+		signal_count = get_unaligned_le32(&resp->signal_count);
+
+		/* Validate the response flags and its variable-length signal array. */
+		if ((flags & ~RPMI_TEE_SIGNAL_MORE_AVAILABLE) || !signal_count ||
+		    signal_count != (resp_len - sizeof(*resp)) / sizeof(__le32))
+			return -EPROTO;
+
+		bus = __rpmi_tee_find_signal_bus(priv, endpoint_id);
+		if (!bus || signal_count > bus->tee_to_ree_count)
+			return -EPROTO;
+
+		for (i = 0; i < signal_count; i++) {
+			u32 signal = get_unaligned_le32(&resp->signals[i]);
+
+			ret = rpmi_tee_dispatch_signal(bus, signal);
+			if (ret)
+				return ret;
+		}
+	}
+}
+
+static void rpmi_tee_notif_work(struct work_struct *work)
+{
+	struct rpmi_tee_notif_state *notif =
+		container_of(work, struct rpmi_tee_notif_state, work);
+	struct rpmi_tee_transport *priv =
+		container_of(notif, struct rpmi_tee_transport, notif);
+	int ret;
+
+	ret = rpmi_tee_retrieve_signals(priv);
+	if (ret)
+		dev_warn(priv->dev, "failed to retrieve signals: %d\n", ret);
+}
+
+static irqreturn_t rpmi_tee_notif_irq_handler(int irq, void *data)
+{
+	struct rpmi_tee_transport *priv = data;
+
+	queue_work(priv->notif.wq, &priv->notif.work);
+	return IRQ_HANDLED;
+}
+
+/* Reserve a TEE-to-REE signal for a notification consumer. */
+static int rpmi_tee_op_notify_request(struct rpmi_tee_device *rdev,
+				      rpmi_tee_notifier_cb cb, void *cb_data,
+				      u32 *signal)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	struct rpmi_tee_signal_bus *bus;
+	u32 id;
+
+	if (!cb || !signal)
+		return -EINVAL;
+
+	guard(mutex)(&priv->notif.ops_lock);
+	bus = rpmi_tee_find_signal_bus(priv, rdev->endpoint_id);
+	if (!bus)
+		return -EOPNOTSUPP;
+
+	struct rpmi_tee_signal_reservation *resv __free(kfree) =
+		kzalloc_obj(*resv, GFP_KERNEL);
+	if (!resv)
+		return -ENOMEM;
+
+	resv->rdev = rdev;
+	resv->cb = cb;
+	resv->cb_data = cb_data;
+	scoped_guard(mutex, &bus->lock) {
+		int ret;
+
+		ret = xa_alloc(&bus->reservations, &id, resv,
+			       XA_LIMIT(0, bus->tee_to_ree_count - 1),
+			       GFP_KERNEL);
+		if (ret)
+			return ret == -EBUSY ? -ENOSPC : ret;
+	}
+
+	*signal = id;
+	/* xa_alloc owns resv. */
+	retain_and_null_ptr(resv);
+
+	return 0;
+}
+
+/* Relinquish a previously reserved TEE-to-REE signal. */
+static int rpmi_tee_op_notify_relinquish(struct rpmi_tee_device *rdev,
+					 u32 signal)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	struct rpmi_tee_signal_bus *bus;
+
+	guard(mutex)(&priv->notif.ops_lock);
+	bus = rpmi_tee_find_signal_bus(priv, rdev->endpoint_id);
+	if (!bus)
+		return -EOPNOTSUPP;
+
+	if (signal >= bus->tee_to_ree_count)
+		return -EINVAL;
+
+	scoped_guard(mutex, &bus->lock) {
+		struct rpmi_tee_signal_reservation *resv;
+
+		resv = xa_load(&bus->reservations, signal);
+		if (!resv)
+			return -ENOENT;
+		/* Release only if @signal belongs to @rdev. */
+		if (resv->rdev != rdev)
+			return -EPERM;
+		if (resv->state == RPMI_TEE_SIGNAL_RELEASING)
+			return -EALREADY;
+
+		resv->state = RPMI_TEE_SIGNAL_RELEASING;
+	}
+
+	queue_work(priv->notif.wq, &priv->notif.work);
+
+	return 0;
+}
+
+/* Raise an REE-to-TEE signal. */
+static int rpmi_tee_op_signal_raise(struct rpmi_tee_device *rdev, u32 signal)
+{
+	struct rpmi_tee_transport *priv = rpmi_tee_device_to_transport(rdev);
+	struct rpmi_tee_signal_raise_one_req req = {
+		.target_id = cpu_to_le32(rdev->endpoint_id),
+		.signal_count = cpu_to_le32(1),
+		.signal = cpu_to_le32(signal),
+	};
+	struct rpmi_tee_signal_bus *bus;
+
+	guard(mutex)(&priv->notif.ops_lock);
+	bus = rpmi_tee_find_signal_bus(priv, rdev->endpoint_id);
+	if (!bus)
+		return -EOPNOTSUPP;
+
+	if (signal < bus->tee_to_ree_count || signal >= bus->width)
+		return -EINVAL;
+
+	return rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_RAISE, &req,
+			     sizeof(req), NULL, NULL);
+}
+
+static const struct rpmi_tee_notifier_ops rpmi_tee_notifier_ops = {
+	.notify_request = rpmi_tee_op_notify_request,
+	.notify_relinquish = rpmi_tee_op_notify_relinquish,
+	.signal_raise = rpmi_tee_op_signal_raise,
+};
+
 static const struct rpmi_tee_msg_ops rpmi_tee_msg_ops = {
 	.call = rpmi_tee_op_call,
 };
@@ -991,6 +1392,7 @@ static const struct rpmi_tee_mem_ops rpmi_tee_mem_ops = {
 static const struct rpmi_tee_ops rpmi_tee_ops = {
 	.msg_ops = &rpmi_tee_msg_ops,
 	.mem_ops = &rpmi_tee_mem_ops,
+	.notifier_ops = &rpmi_tee_notifier_ops,
 };
 
 static void rpmi_tee_unregister_devices(struct rpmi_tee_transport *priv)
@@ -1004,6 +1406,212 @@ static void rpmi_tee_unregister_devices(struct rpmi_tee_transport *priv)
 	}
 }
 
+static void rpmi_tee_signal_bus_destroy_resvs(struct rpmi_tee_signal_bus *bus)
+{
+	struct rpmi_tee_signal_reservation *resv;
+	unsigned long index;
+
+	xa_for_each(&bus->reservations, index, resv) {
+		xa_erase(&bus->reservations, index);
+		kfree(resv);
+	}
+
+	xa_destroy(&bus->reservations);
+}
+
+static void rpmi_tee_teardown_signal_buses(struct rpmi_tee_transport *priv)
+{
+	struct rpmi_tee_signal_bus *bus, *tmp;
+
+	list_for_each_entry_safe(bus, tmp, &priv->notif.buses, node) {
+		struct rpmi_tee_signal_bus_teardown_req req = {
+			.target_id = cpu_to_le32(bus->endpoint_id),
+		};
+		int ret;
+
+		ret = rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_BUS_TEARDOWN, &req,
+				    sizeof(req), NULL, NULL);
+		if (ret)
+			dev_warn(priv->dev, "failed to tear down signal bus for %#x: %d\n",
+				 bus->endpoint_id, ret);
+
+		rpmi_tee_signal_bus_destroy_resvs(bus);
+		list_del(&bus->node);
+		kfree(bus);
+	}
+}
+
+static void rpmi_tee_quiesce_notifications(struct rpmi_tee_transport *priv)
+{
+	/* Initiate a notification shutdown. */
+	scoped_guard(mutex, &priv->notif.ops_lock)
+		priv->notif.shutting_down = true;
+
+	if (priv->notif.irq_requested) {
+		free_irq(priv->notif.irq, priv);
+		priv->notif.irq_requested = false;
+	}
+
+	if (priv->notif.wq) {
+		destroy_workqueue(priv->notif.wq);
+		priv->notif.wq = NULL;
+	}
+
+	/* shutting_down stops public access and the workqueue has drained. */
+	rpmi_tee_teardown_signal_buses(priv);
+
+	if (priv->notif.irq) {
+		irq_dispose_mapping(priv->notif.irq);
+		priv->notif.irq = 0;
+	}
+}
+
+/* Set up an RPMI signal bus for one @endpoint_id TEE endpoint. */
+static int __rpmi_tee_setup_signal_bus(struct rpmi_tee_transport *priv,
+				       u32 endpoint_id)
+{
+	struct rpmi_tee_signal_bus_setup_req req;
+	u32 max_width, width, tee_to_ree_count;
+	struct rpmi_tee_signal_bus *bus;
+
+	/* Avoid duplicate signal bus for endpoint. */
+	if (__rpmi_tee_find_signal_bus(priv, endpoint_id))
+		return 0;
+
+	if (priv->mbox.max_msg_data_size <
+	    sizeof(struct rpmi_tee_signal_retrieve_resp))
+		return -EMSGSIZE;
+
+	max_width = FIELD_GET(RPMI_TEE_SIGNAL_WIDTH_MASK,
+			      priv->notif.feature);
+	width = min(max_width,
+		    2 * ((priv->mbox.max_msg_data_size -
+			  sizeof(struct rpmi_tee_signal_retrieve_resp)) /
+			 sizeof(__le32)) + 1);
+	if (width < 2)
+		return -EMSGSIZE;
+
+	/* Use half available signals for TEE-to-REE range. */
+	tee_to_ree_count = width / 2;
+
+	req.target_id = cpu_to_le32(endpoint_id);
+	req.bus_width = cpu_to_le32(width);
+	req.sender_signals = cpu_to_le32(tee_to_ree_count);
+	if (rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_BUS_SETUP, &req,
+			  sizeof(req), NULL, NULL))
+		return -EOPNOTSUPP;
+
+	bus = kzalloc_obj(*bus, GFP_KERNEL);
+	if (!bus) {
+		struct rpmi_tee_signal_bus_teardown_req treq = {
+			.target_id = cpu_to_le32(endpoint_id),
+		};
+
+		rpmi_tee_send(priv, RPMI_TEE_SRV_SIGNAL_BUS_TEARDOWN, &treq,
+			      sizeof(treq), NULL, NULL);
+
+		return -ENOMEM;
+	}
+
+	mutex_init(&bus->lock);
+	xa_init_flags(&bus->reservations, XA_FLAGS_ALLOC);
+	bus->endpoint_id = endpoint_id;
+	bus->width = width;
+	bus->tee_to_ree_count = tee_to_ree_count;
+	list_add_tail(&bus->node, &priv->notif.buses);
+
+	return 0;
+}
+
+static int rpmi_tee_map_signal_irq(struct rpmi_tee_transport *priv)
+{
+	struct device_node *np;
+	struct of_phandle_args oirq = {};
+	u32 mode, index;
+	int irq;
+
+	mode = FIELD_GET(RPMI_TEE_SIGNAL_MODE_MASK, priv->notif.feature);
+	if (mode != RPMI_TEE_SIGNAL_MODE_SYSTEM_MSI)
+		return 0;
+
+	np = of_find_compatible_node(NULL, NULL, "riscv,rpmi-system-msi");
+	if (!np)
+		return 0;
+	if (!irq_find_host(np)) {
+		of_node_put(np);
+		return -EPROBE_DEFER;
+	}
+
+	index = FIELD_GET(RPMI_TEE_SIGNAL_INDEX_MASK, priv->notif.feature);
+	oirq.np = np;
+	oirq.args_count = 1;
+	oirq.args[0] = index;
+	irq = irq_create_of_mapping(&oirq);
+
+	of_node_put(np);
+
+	return irq;
+}
+
+/**
+ * rpmi_tee_setup_signal_bus() - Set up signal notification delivery
+ * @priv: RPMI TEE transport
+ * @endpoints: TEE endpoints that may own signal buses
+ * @endpoint_count: Number of entries in @endpoints
+ *
+ * Map the signal interrupt, then set up a bus for each endpoint. Endpoint
+ * setup failures are nonfatal, allowing notifications for the remaining
+ * endpoints. Register the interrupt handler only when at least one bus is
+ * available.
+ *
+ * Return: 0 on completion, or -EPROBE_DEFER when the System MSI IRQ domain
+ * is not ready.
+ */
+static int
+rpmi_tee_setup_signal_bus(struct rpmi_tee_transport *priv,
+			  const struct rpmi_tee_sysinfo_endpoint_info *endpoints,
+			  size_t endpoint_count)
+{
+	size_t i;
+	int ret;
+
+	priv->notif.irq = rpmi_tee_map_signal_irq(priv);
+	if (priv->notif.irq < 0)
+		return priv->notif.irq;
+	if (!priv->notif.irq)
+		return 0;
+
+	for (i = 0; i < endpoint_count; i++) {
+		ret = __rpmi_tee_setup_signal_bus(priv,
+						  endpoints[i].endpoint_id);
+		if (ret)
+			dev_warn(priv->dev, "failed to set up signal bus for %#x: %d\n",
+				 endpoints[i].endpoint_id, ret);
+	}
+
+	if (list_empty(&priv->notif.buses))
+		goto out_failed;
+
+	ret = request_irq(priv->notif.irq, rpmi_tee_notif_irq_handler, 0,
+			  dev_name(priv->dev), priv);
+	if (ret) {
+		dev_warn(priv->dev, "failed to request signal IRQ: %d\n", ret);
+		rpmi_tee_teardown_signal_buses(priv);
+		goto out_failed;
+	}
+
+	priv->notif.irq_requested = true;
+
+	return 0;
+
+out_failed:
+	/* Failures are nonfatal; only disable notification. */
+	irq_dispose_mapping(priv->notif.irq);
+	priv->notif.irq = 0;
+
+	return 0;
+}
+
 static struct rpmi_tee_device *
 rpmi_tee_find_device(struct rpmi_tee_transport *priv, const uuid_t *uuid,
 		     u32 endpoint_id)
@@ -1041,6 +1649,7 @@ rpmi_tee_register_devices(struct rpmi_tee_transport *priv,
 			ret = -ENOMEM;
 			goto err_unregister;
 		}
+
 		child->rdev = rpmi_tee_device_register(&service->uuid,
 						       service->endpoint_id,
 						       &rpmi_tee_ops,
@@ -1074,8 +1683,16 @@ static int rpmi_tee_setup_endpoints(struct rpmi_tee_transport *priv)
 	if (ret)
 		return ret;
 
+	ret = rpmi_tee_setup_signal_bus(priv, system.eps, system.ep_count);
+	if (ret)
+		goto out_failed;
+
 	ret = rpmi_tee_register_devices(priv, system.services,
 					system.service_count);
+	if (ret)
+		rpmi_tee_quiesce_notifications(priv);
+
+out_failed:
 	kfree(system.services);
 	kfree(system.eps);
 
@@ -1095,7 +1712,11 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 	INIT_LIST_HEAD(&priv->devices);
+	INIT_LIST_HEAD(&priv->notif.buses);
 	mutex_init(&priv->mem.lock);
+	mutex_init(&priv->notif.ops_lock);
+	INIT_WORK(&priv->notif.work, rpmi_tee_notif_work);
+
 	priv->mbox.client.dev = &pdev->dev;
 	priv->mbox.client.tx_sync = true;
 	priv->mbox.chan = mbox_request_channel(&priv->mbox.client, 0);
@@ -1103,6 +1724,7 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->mbox.chan),
 				     "failed to request mailbox channel\n");
 
+	/* Validate the RPMI mailbox transport. */
 	ret = rpmi_tee_check_transport(priv);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret,
@@ -1141,6 +1763,12 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_failed;
 
+	priv->notif.wq = alloc_workqueue("rpmi_tee_notif", WQ_UNBOUND, 0);
+	if (!priv->notif.wq) {
+		ret = -ENOMEM;
+		goto out_failed;
+	}
+
 	ret = rpmi_tee_setup_endpoints(priv);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret,
@@ -1151,6 +1779,8 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 	return 0;
 
 out_failed:
+	if (priv->notif.wq)
+		destroy_workqueue(priv->notif.wq);
 	mbox_free_channel(priv->mbox.chan);
 
 	return ret;
@@ -1160,6 +1790,7 @@ static void rpmi_tee_transport_remove(struct platform_device *pdev)
 {
 	struct rpmi_tee_transport *priv = platform_get_drvdata(pdev);
 
+	rpmi_tee_quiesce_notifications(priv);
 	rpmi_tee_unregister_devices(priv);
 	mbox_free_channel(priv->mbox.chan);
 }
diff --git a/include/linux/rpmi_tee.h b/include/linux/rpmi_tee.h
index c2dd99293481..5f4a0b19b0e1 100644
--- a/include/linux/rpmi_tee.h
+++ b/include/linux/rpmi_tee.h
@@ -103,10 +103,34 @@ struct rpmi_tee_mem_ops {
 	int (*memory_reclaim)(struct rpmi_tee_device *rdev, u32 parcel_id);
 };
 
+typedef void (*rpmi_tee_notifier_cb)(struct rpmi_tee_device *rdev,
+				     u32 signal, void *cb_data);
+
+/* RPMI TEE signal notification operations. */
+struct rpmi_tee_notifier_ops {
+	/**
+	 * @notify_request: Allocate a TEE-to-REE signal and associate it with
+	 *	@cb and @cb_data. The allocated signal is returned through @signal.
+	 */
+	int (*notify_request)(struct rpmi_tee_device *rdev,
+			      rpmi_tee_notifier_cb cb, void *cb_data, u32 *signal);
+	/**
+	 * @notify_relinquish: Stop dispatching a TEE-to-REE @signal previously
+	 *	allocated for @rdev. The release is asynchronous and a callback may
+	 *	relinquish its own signal.
+	 */
+	int (*notify_relinquish)(struct rpmi_tee_device *rdev, u32 signal);
+	/**
+	 * @signal_raise: Raise an REE-to-TEE @signal selected by the TEE service.
+	 */
+	int (*signal_raise)(struct rpmi_tee_device *rdev, u32 signal);
+};
+
 /* RPMI TEE transport operation groups. */
 struct rpmi_tee_ops {
 	const struct rpmi_tee_msg_ops *msg_ops;
 	const struct rpmi_tee_mem_ops *mem_ops;
+	const struct rpmi_tee_notifier_ops *notifier_ops;
 };
 
 extern const struct bus_type rpmi_tee_bus_type;

-- 
2.34.1

