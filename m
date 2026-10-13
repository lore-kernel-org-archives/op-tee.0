Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3301BCA9ED0
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:42:39 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8304C44FBD
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870158;
	bh=NaGwPKL5fWG1Gs/g9B+z4aHOl9q0GOpXbFWLfPNwPuM=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=3ovApKWQXr7f4i83UCrFJ7fkeqoeVWmJPT9mYUgYrAsIPI+fMa+kXDaEGh1B4p33w
	 w/mrvPM5o2CJG2q40/6IBjNJurv7YPRU9SdlFR+caoCC19cYyflSxUrYIgfm0vza0O
	 00xKMN6YnYOzf8QlzZBjTV46ERGC9zhP6E0iSf+PZKlKUhdV5Uk4bdIi7KoQhzlfoK
	 8iRfZey6CODlROVmkqjUpiTLRpY65pgcM0asX4QGemGINSv8BaZtQdbcYqGXrx6XPf
	 sHUCfTSB3O06J4Ih51QsJuZfF2oPNXtjQv3VZo+HGv/gkQlwVDJYbRx6kwYv9aTeL6
	 Sk1bVbrbTeiSw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id DD27545225
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Kgs1HNga;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fUEz7QdN;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D21D2D3054911
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QhAsvG4R/uLP8ngKuMfxJ7kEdHB3Lqf98dmrr1z6uUI=; b=Kgs1HNgatN5NAoOd
	+fcEa8Wo/UkPFSI64uG/I0ZGiYU6b735Q4Q4jqDYYNnXV8MVdkZkDpNl5jjvOEDx
	PzZQfE8mGiSTO/0CewjQCc+HRB8SgLOG9uxqr6y/LLUBCXILUMw0D6tEF/utug34
	x5yvaAwQl5NNx50OjpJ48o484CiCKI5/MLPciPDjrWJCRViYSiQeFu49onlNU9Yl
	ES2GwjLDMVrJmP+2k6GhXPlJtMxv7ZkdhoDs91l9Od+lNxg+5jYuAjrxb4ZrsjK0
	e96Vytjb+12fFHtCS1WFw76WTfu5TWbPO5puSBI7Xpyw6qPSjIBYSCQg8y2d8WfL
	UNWtYA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h93aetkj6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ab926c236aso1705750a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870109; x=1792474909; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QhAsvG4R/uLP8ngKuMfxJ7kEdHB3Lqf98dmrr1z6uUI=;
        b=fUEz7QdNvFte0uhU/DStdEc8NefDQ2rupAD7wDCqktZVQBP8oHnqLqCzz5yDVvZkOW
         2SKHrCiji0TGrlNTykmXaBwbjuCDZktBXH815Q+aENehZ/2kxnQFrK1IlxInLseaaWca
         F1nPpvaxkqGlBes1r03vHeD80X8kgREZ8oB2Zxok2tg1o9jcOHFCMeMeW2MFiEgV6uvA
         fwt6e+6mWnOVlaWjKDiNBJ+4IBdNexaeDAk6Xw61HD/nsRgBxvbUjYuDrLNRlhqVLPru
         2Tw6HjcmOZaLtBG/JxqORThcTqpm2g+I7kt4xwSUQDwQLEYR35yU3I6wTpmCkQaY0a9a
         WtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870109; x=1792474909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhAsvG4R/uLP8ngKuMfxJ7kEdHB3Lqf98dmrr1z6uUI=;
        b=eF6sPxpKU2sSEQ+7LodHiLXt7hCOAY7S6ZPUG/tlva/mhsnkU3bXr9R9xEsSRZ5iel
         XacvDXLOR7Au5L/3PPeZpDgIzr2pAMttUgzYvZ6lCJAPyxclXRKeV/SpRcKg04NefUB5
         yebx3kePY+7hW4NUI1DstL8JOxFgIES+U87aD1zOGAM0oRU7YUzGCad415lge6QK13ba
         1ERgycHkT6Wq9DvxlDO+FzBjU/sQeTQJVFOm8VDeau9Ah5Esl+ae9QOX1lOy/+QKYyPu
         T7MbKhfQlA/w6IrygMG82KIQZBuRlI85FRSW0j9txNls9CPuBLXPaCtzRWSNLuP9s5hx
         gg8Q==
X-Forwarded-Encrypted: i=1; AKwUvByRUyoJmqelSBPWj74OqzE/JNpaXoAxz2/KXLK2TjX7fQgMxPj2h7G1hL723IjlIj5Vs76O0e8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIPLtOpRdEcNf67bTX1+LHmppPstWymynKgcOWbKaqTdjYGrqXJ
	Y5/M1jDLrguClVM+xamJyNs7ZCLLsvFCSH3CyUnQlGTO6bOrX5VWt96ZrfA9syxD4KM4zwEE/vL
	EQlhziswRWQaq8nba+iLs4oG99DfgBv/5Lwf1HWvV6tVUiV3Jip5lBiE+5pXOSOalt8j7yg0=
X-Gm-Gg: AYBFou0bXRkWV115nuikR4nuU9l7eGvE2DsR8uDZNPRLEyAG/ietGXV7YNzl1U230nU
	od3GIKs8YTTlGMa4lC+4tsaiEKc3O2504pd7BO0IMoaZOCVfO3X0o+qh0/ETGIdwXfV4/ieNNAf
	eEb6QMhhY9FDT/CV3rFtYdqQGAylKhQLwUefoFlsnt3EgA5vyVxeP+Yf8HM/O1hwNqRBgyQjXFl
	UmEw8+zlHGCX16vdXBseSOLG1Kkv+Pu7NTydS+qMT0mUF/PEdnGq6LrOhWABdIPC5oTn1Kchy7V
	rJcIdAcNLcx1uKqa8NBucqNL0zYmLVzxuIUJwK9a/JX+Arz0mDPzmw9+K+Q5ZTl3qX5KU6Fzqom
	jwm+MRMBebyX9dd64wM+E6Nls+HjUZqdS+sRGqUyYwX4GO9Klet2x8/1eyw==
X-Received: by 2002:a17:90b:5346:b0:3ab:1a24:56e3 with SMTP id 98e67ed59e1d1-3ab3ac9dea0mr8535584a91.25.1791870108379;
        Mon, 12 Oct 2026 22:41:48 -0700 (PDT)
X-Received: by 2002:a17:90b:5346:b0:3ab:1a24:56e3 with SMTP id 98e67ed59e1d1-3ab3ac9dea0mr8535570a91.25.1791870107775;
        Mon, 12 Oct 2026 22:41:47 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:41:47 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:28 -0700
Subject: [PATCH RFC v3 1/9] tee: optee: share the global shared-memory ID
 mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-1-975b574667e2@oss.qualcomm.com>
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
X-Proofpoint-GUID: -_4HIViLheF6gS0oMVeQYdiMKz7IhztN
X-Authority-Analysis: v=2.4 cv=JJuuIMKb c=1 sm=1 tr=0 ts=6acdc49e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Hmcm6iJ0OgSZlEai1VoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX8kEXnNNJki+D
 IuILrUD2m/1AMKGWBdPoHQNridQ222BJD0fRrvltJt1HeISsy+6HbmKx10n7avaQ5STvf3F4Lj9
 fCxJdGlXSZaCtyDpj0iay1cAryBWuq4=
X-Proofpoint-ORIG-GUID: -_4HIViLheF6gS0oMVeQYdiMKz7IhztN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX4FUpNZfHRS23
 7JHJcZlNp8hWzFFSdmR5Zy/vKZAKX0RCOAEU9tdftdkfpPrw2pPVvRyZk+L1J+QojhUznO6lB3I
 OsY3fTPO8JfZorSeR0Ee9edywV7Y8KSRC3ZBOJzzO8EHVoj0wk0nkhmaQFXJ5hTE9u4gqKp5rIq
 /i9KFBQaQS/ARt0Q9m5Z3Jxw6D6AvpePydGf9Yqj2S9KELErdG9YD1fUdF13O1kRpIa/9Bvs7cp
 rF3Pq7Rhk5VexBCtJ+ozIRk/2qTc1ONT0XInYTUCQdETrkVq/uXCK7EAf+I+UvsE1VLcGXH7jGV
 YBoSZAioPwwc8KfRsGaDhbjy5sHz959tPcNJNQapmkarWVUwgLZB0afVeQLiN7tXKGv3EnYUOwx
 82hmQfCsffGcG6UnSTQaQk7sn4JnnrbxJ4+hKcA/pSTj9CftUyqmoHie5k3TA68rSG9MIH9MxK0
 JZBWAu+Nb7QFsa9qwzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130022
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
	DNSWL_BLOCKED(0.00)[209.85.216.71:received];
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
X-Rspamd-Queue-Id: DD27545225
X-Spamd-Bar: -----
Message-ID-Hash: 647PW6KW7DNWT6FYGQSEX2QXD4NPHUUA
X-Message-ID-Hash: 647PW6KW7DNWT6FYGQSEX2QXD4NPHUUA
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/647PW6KW7DNWT6FYGQSEX2QXD4NPHUUA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

The FF-A backend maintains a hash table translating secure-world memory
handles to TEE shared-memory objects. This bookkeeping does not depend
on FF-A and is also needed by the RPMI backend.

Move the mapping and its locking into common helpers and convert the
FF-A backend to use them.

This prepares the OP-TEE driver for RPMI transport support on RISC-V.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile         |   1 +
 drivers/tee/optee/ffa_abi.c        | 133 +++++++----------------------------
 drivers/tee/optee/optee_private.h  |  30 ++++++--
 drivers/tee/optee/shm_handle_map.c | 138 +++++++++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 114 deletions(-)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 183cdde1ac04..ec2efc27ef05 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -7,6 +7,7 @@ optee-objs += rpc.o
 optee-objs += protmem.o
 optee-objs += supp.o
 optee-objs += device.o
+optee-objs += shm_handle_map.o
 optee-$(CONFIG_HAVE_ARM_SMCCC) += smc_abi.o
 optee-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_abi.o
 
diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 702da7d98fbc..5a926353c653 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -22,100 +22,15 @@
  * This file implement the FF-A ABI used when communicating with secure world
  * OP-TEE OS via FF-A.
  * This file is divided into the following sections:
- * 1. Maintain a hash table for lookup of a global FF-A memory handle
- * 2. Convert between struct tee_param and struct optee_msg_param
- * 3. Low level support functions to register shared memory in secure world
- * 4. Dynamic shared memory pool based on alloc_pages()
- * 5. Do a normal scheduled call into secure world
- * 6. Driver initialization.
+ * 1. Convert between struct tee_param and struct optee_msg_param
+ * 2. Low level support functions to register shared memory in secure world
+ * 3. Dynamic shared memory pool based on alloc_pages()
+ * 4. Do a normal scheduled call into secure world
+ * 5. Driver initialization.
  */
 
 /*
- * 1. Maintain a hash table for lookup of a global FF-A memory handle
- *
- * FF-A assigns a global memory handle for each piece shared memory.
- * This handle is then used when communicating with secure world.
- *
- * Main functions are optee_shm_add_ffa_handle() and optee_shm_rem_ffa_handle()
- */
-struct shm_rhash {
-	struct tee_shm *shm;
-	u64 global_id;
-	struct rhash_head linkage;
-};
-
-static void rh_free_fn(void *ptr, void *arg)
-{
-	kfree(ptr);
-}
-
-static const struct rhashtable_params shm_rhash_params = {
-	.head_offset = offsetof(struct shm_rhash, linkage),
-	.key_len     = sizeof(u64),
-	.key_offset  = offsetof(struct shm_rhash, global_id),
-	.automatic_shrinking = true,
-};
-
-static struct tee_shm *optee_shm_from_ffa_handle(struct optee *optee,
-						 u64 global_id)
-{
-	struct tee_shm *shm = NULL;
-	struct shm_rhash *r;
-
-	mutex_lock(&optee->ffa.mutex);
-	r = rhashtable_lookup_fast(&optee->ffa.global_ids, &global_id,
-				   shm_rhash_params);
-	if (r)
-		shm = r->shm;
-	mutex_unlock(&optee->ffa.mutex);
-
-	return shm;
-}
-
-static int optee_shm_add_ffa_handle(struct optee *optee, struct tee_shm *shm,
-				    u64 global_id)
-{
-	struct shm_rhash *r;
-	int rc;
-
-	r = kmalloc_obj(*r);
-	if (!r)
-		return -ENOMEM;
-	r->shm = shm;
-	r->global_id = global_id;
-
-	mutex_lock(&optee->ffa.mutex);
-	rc = rhashtable_lookup_insert_fast(&optee->ffa.global_ids, &r->linkage,
-					   shm_rhash_params);
-	mutex_unlock(&optee->ffa.mutex);
-
-	if (rc)
-		kfree(r);
-
-	return rc;
-}
-
-static int optee_shm_rem_ffa_handle(struct optee *optee, u64 global_id)
-{
-	struct shm_rhash *r;
-	int rc = -ENOENT;
-
-	mutex_lock(&optee->ffa.mutex);
-	r = rhashtable_lookup_fast(&optee->ffa.global_ids, &global_id,
-				   shm_rhash_params);
-	if (r)
-		rc = rhashtable_remove_fast(&optee->ffa.global_ids,
-					    &r->linkage, shm_rhash_params);
-	mutex_unlock(&optee->ffa.mutex);
-
-	if (!rc)
-		kfree(r);
-
-	return rc;
-}
-
-/*
- * 2. Convert between struct tee_param and struct optee_msg_param
+ * 1. Convert between struct tee_param and struct optee_msg_param
  *
  * optee_ffa_from_msg_param() and optee_ffa_to_msg_param() are the main
  * functions.
@@ -133,7 +48,8 @@ static void from_msg_param_ffa_mem(struct optee *optee, struct tee_param *p,
 	p->u.memref.size = mp->u.fmem.size;
 
 	if (mp->u.fmem.global_id != OPTEE_MSG_FMEM_INVALID_GLOBAL_ID)
-		shm = optee_shm_from_ffa_handle(optee, mp->u.fmem.global_id);
+		shm = optee_shm_handle_map_lookup(&optee->ffa.shm_map,
+						  mp->u.fmem.global_id);
 	p->u.memref.shm = shm;
 
 	if (shm) {
@@ -262,7 +178,7 @@ static int optee_ffa_to_msg_param(struct optee *optee,
 }
 
 /*
- * 3. Low level support functions to register shared memory in secure world
+ * 2. Low level support functions to register shared memory in secure world
  *
  * Functions to register and unregister shared memory both for normal
  * clients and for tee-supplicant.
@@ -313,7 +229,7 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
 	if (rc)
 		return rc;
 
-	rc = optee_shm_add_ffa_handle(optee, shm, args.g_handle);
+	rc = optee_shm_handle_map_add(&optee->ffa.shm_map, shm, args.g_handle);
 	if (rc) {
 		mem_ops->memory_reclaim(args.g_handle, 0);
 		return rc;
@@ -339,7 +255,7 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
 	};
 	int rc;
 
-	optee_shm_rem_ffa_handle(optee, global_handle);
+	optee_shm_handle_map_remove(&optee->ffa.shm_map, global_handle);
 	shm->sec_world_id = 0;
 
 	rc = msg_ops->sync_send_receive(ffa_dev, &data);
@@ -367,7 +283,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 	 * this ID.
 	 */
 
-	optee_shm_rem_ffa_handle(optee, global_handle);
+	optee_shm_handle_map_remove(&optee->ffa.shm_map, global_handle);
 	mem_ops = optee->ffa.ffa_dev->ops->mem_ops;
 	rc = mem_ops->memory_reclaim(global_handle, 0);
 	if (rc)
@@ -379,7 +295,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
 }
 
 /*
- * 4. Dynamic shared memory pool based on alloc_pages()
+ * 3. Dynamic shared memory pool based on alloc_pages()
  *
  * Implements an OP-TEE specific shared memory pool.
  * The main function is optee_ffa_shm_pool_alloc_pages().
@@ -428,7 +344,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
 }
 
 /*
- * 5. Do a normal scheduled call into secure world
+ * 4. Do a normal scheduled call into secure world
  *
  * The function optee_ffa_do_call_with_arg() performs a normal scheduled
  * call into secure world. During this call may normal world request help
@@ -488,7 +404,8 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee_context *ctx,
 	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
 		goto err_bad_param;
 
-	shm = optee_shm_from_ffa_handle(optee, arg->params[0].u.value.b);
+	shm = optee_shm_handle_map_lookup(&optee->ffa.shm_map,
+					  arg->params[0].u.value.b);
 	if (!shm)
 		goto err_bad_param;
 	switch (arg->params[0].u.value.a) {
@@ -736,7 +653,8 @@ static int optee_ffa_lend_protmem(struct optee *optee, struct tee_shm *protmem,
 	if (rc)
 		goto err_reclaim;
 
-	rc = optee_shm_add_ffa_handle(optee, protmem, args.g_handle);
+	rc = optee_shm_handle_map_add(&optee->ffa.shm_map, protmem,
+				      args.g_handle);
 	if (rc)
 		goto err_unreg;
 
@@ -770,7 +688,7 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
 	};
 	int rc;
 
-	optee_shm_rem_ffa_handle(optee, global_handle);
+	optee_shm_handle_map_remove(&optee->ffa.shm_map, global_handle);
 	protmem->sec_world_id = 0;
 
 	rc = msg_ops->sync_send_receive(ffa_dev, &data);
@@ -785,9 +703,9 @@ static int optee_ffa_reclaim_protmem(struct optee *optee,
 }
 
 /*
- * 6. Driver initialization
+ * 5. Driver initialization
  *
- * During driver inititialization is the OP-TEE Secure Partition is probed
+ * During driver initialization is the OP-TEE Secure Partition is probed
  * to find out which features it supports so the driver can be initialized
  * with a matching configuration.
  */
@@ -991,8 +909,7 @@ static void optee_ffa_remove(struct ffa_device *ffa_dev)
 	}
 	optee_remove_common(optee);
 
-	mutex_destroy(&optee->ffa.mutex);
-	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+	optee_shm_handle_map_uninit(&optee->ffa.shm_map);
 
 	kfree(optee);
 }
@@ -1137,10 +1054,9 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 
 	optee_set_dev_group(optee);
 
-	rc = rhashtable_init(&optee->ffa.global_ids, &shm_rhash_params);
+	rc = optee_shm_handle_map_init(&optee->ffa.shm_map);
 	if (rc)
 		goto err_unreg_supp_teedev;
-	mutex_init(&optee->ffa.mutex);
 	optee_cq_init(&optee->call_queue, 0);
 	optee_supp_init(&optee->supp);
 	optee_shm_arg_cache_init(optee, arg_cache_flags);
@@ -1193,12 +1109,11 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
 err_close_ctx:
 	teedev_close_context(ctx);
 err_rhashtable_free:
-	rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
+	optee_shm_handle_map_uninit(&optee->ffa.shm_map);
 	rpmb_dev_put(optee->rpmb_dev);
 	mutex_destroy(&optee->rpmb_dev_mutex);
 	optee_supp_uninit(&optee->supp);
 	mutex_destroy(&optee->call_queue.mutex);
-	mutex_destroy(&optee->ffa.mutex);
 err_unreg_supp_teedev:
 	tee_device_unregister(optee->supp_teedev);
 err_unreg_teedev:
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 02d6f79df407..92428945ee33 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -157,6 +157,29 @@ struct optee_smc {
 };
 #endif
 
+/**
+ * struct optee_shm_handle_map - Shared-memory lookup by secure-world identity
+ * @mutex: Serializes lookup, insertion and removal
+ * @rht: Maps opaque 64-bit identities to shared-memory objects
+ *
+ * Owners keep SHM objects alive while their registrations are in use.
+ * Never hold @mutex across transport calls, RPC or thread-availability waits.
+ */
+struct optee_shm_handle_map {
+	/* Protects lookup, insertion and removal. */
+	struct mutex mutex;
+	struct rhashtable rht;
+};
+
+int optee_shm_handle_map_init(struct optee_shm_handle_map *map);
+void optee_shm_handle_map_uninit(struct optee_shm_handle_map *map);
+int optee_shm_handle_map_add(struct optee_shm_handle_map *map,
+			     struct tee_shm *shm, u64 global_id);
+int optee_shm_handle_map_remove(struct optee_shm_handle_map *map,
+				u64 global_id);
+struct tee_shm *
+optee_shm_handle_map_lookup(struct optee_shm_handle_map *map, u64 global_id);
+
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
 /**
  * struct optee_ffa -  FFA communication struct
@@ -164,17 +187,14 @@ struct optee_smc {
  *			OP-TEE in secure world
  * @bottom_half_value:	notification ID used for bottom half signalling or
  *			U32_MAX if unused
- * @mutex:		serializes access to @global_ids
- * @global_ids:		FF-A shared memory global handle translation
+ * @shm_map:		FF-A shared memory global handle translation
  * @notif_wq:		workqueue for FF-A asynchronous notification
  * @notif_work:		work for FF-A asynchronous notification
  */
 struct optee_ffa {
 	struct ffa_device *ffa_dev;
 	u32 bottom_half_value;
-	/* Serializes access to @global_ids */
-	struct mutex mutex;
-	struct rhashtable global_ids;
+	struct optee_shm_handle_map shm_map;
 	struct workqueue_struct *notif_wq;
 	struct work_struct notif_work;
 };
diff --git a/drivers/tee/optee/shm_handle_map.c b/drivers/tee/optee/shm_handle_map.c
new file mode 100644
index 000000000000..54324c9c3644
--- /dev/null
+++ b/drivers/tee/optee/shm_handle_map.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, 2023 Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include "optee_private.h"
+
+struct optee_shm_handle_map_entry {
+	struct tee_shm *shm;
+	u64 global_id;
+	struct rhash_head node;
+};
+
+static const struct rhashtable_params shm_handle_map_params = {
+	.head_offset = offsetof(struct optee_shm_handle_map_entry, node),
+	.key_offset = offsetof(struct optee_shm_handle_map_entry, global_id),
+	.key_len = sizeof(u64),
+	.automatic_shrinking = true,
+};
+
+static void shm_handle_map_free(void *ptr, void *arg)
+{
+	kfree(ptr);
+}
+
+/**
+ * optee_shm_handle_map_init() - Initialize a shared-memory identity map
+ * @map: Map to initialize
+ *
+ * Return: 0 on success or a negative error.
+ */
+int optee_shm_handle_map_init(struct optee_shm_handle_map *map)
+{
+	int rc;
+
+	mutex_init(&map->mutex);
+	rc = rhashtable_init(&map->rht, &shm_handle_map_params);
+	if (rc)
+		mutex_destroy(&map->mutex);
+
+	return rc;
+}
+
+/**
+ * optee_shm_handle_map_uninit() - Free a shared-memory identity map
+ * @map: Initialized map with no concurrent users
+ *
+ * Free tracking entries, not SHM objects or their secure-world registrations.
+ */
+void optee_shm_handle_map_uninit(struct optee_shm_handle_map *map)
+{
+	rhashtable_free_and_destroy(&map->rht, shm_handle_map_free, NULL);
+	mutex_destroy(&map->mutex);
+}
+
+/**
+ * optee_shm_handle_map_add() - Track a registered shared-memory object
+ * @map: Initialized map
+ * @shm: Shared-memory object kept alive by its owner
+ * @global_id: Opaque secure-world identity
+ *
+ * Return: 0 on success or a negative error.
+ */
+int optee_shm_handle_map_add(struct optee_shm_handle_map *map,
+			     struct tee_shm *shm, u64 global_id)
+{
+	struct optee_shm_handle_map_entry *entry;
+	int rc;
+
+	entry = kmalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->shm = shm;
+	entry->global_id = global_id;
+
+	mutex_lock(&map->mutex);
+	rc = rhashtable_lookup_insert_fast(&map->rht, &entry->node,
+					   shm_handle_map_params);
+	mutex_unlock(&map->mutex);
+	if (rc)
+		kfree(entry);
+
+	return rc;
+}
+
+/**
+ * optee_shm_handle_map_remove() - Remove a shared-memory tracking entry
+ * @map: Initialized map
+ * @global_id: Opaque secure-world identity
+ *
+ * Return: 0 on success, -ENOENT if absent, or a negative removal error.
+ */
+int optee_shm_handle_map_remove(struct optee_shm_handle_map *map, u64 global_id)
+{
+	struct optee_shm_handle_map_entry *entry;
+	int rc = -ENOENT;
+
+	mutex_lock(&map->mutex);
+	entry = rhashtable_lookup_fast(&map->rht, &global_id,
+				       shm_handle_map_params);
+	if (entry)
+		rc = rhashtable_remove_fast(&map->rht, &entry->node,
+					    shm_handle_map_params);
+	mutex_unlock(&map->mutex);
+	if (!rc)
+		kfree(entry);
+
+	return rc;
+}
+
+/**
+ * optee_shm_handle_map_lookup() - Look up a registered shared-memory object
+ * @map: Initialized map
+ * @global_id: Opaque secure-world identity
+ *
+ * The caller must keep the SHM object alive; no reference is acquired here.
+ *
+ * Return: The shared-memory object or NULL if the identity is absent.
+ */
+struct tee_shm *
+optee_shm_handle_map_lookup(struct optee_shm_handle_map *map, u64 global_id)
+{
+	struct optee_shm_handle_map_entry *entry;
+	struct tee_shm *shm = NULL;
+
+	mutex_lock(&map->mutex);
+	entry = rhashtable_lookup_fast(&map->rht, &global_id,
+				       shm_handle_map_params);
+	if (entry)
+		shm = entry->shm;
+	mutex_unlock(&map->mutex);
+
+	return shm;
+}

-- 
2.34.1

