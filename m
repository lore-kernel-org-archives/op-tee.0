Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2BACC6B03
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:44:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0ED1045225
	for <op-tee@archiver.kernel.org>; Tue, 13 Oct 2026 05:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791870246;
	bh=FHcu4WoFZaE8/uyERBTYvjMUmeofac2MOuBgF2LD2zE=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jK8+zhkvzgbSHq77mkI3J6QiY17aO5yH3mOpdWiB4QSywCkBtZzOt/5dSDT1FYspH
	 +xaqnKCa4J3h99cce4hXh/2mpO7Ilc+YxzMVu4xR98ugaXJuaFiSEe7UwXZPeI5gib
	 5z7ZEpz1Z+TFD0/uuKTPBTm1C15aA0BX/pwRZXhsM7UZEKCLsv6mv20cCcfaOmaBXF
	 QPCiXZ4CMLaj1ymAevPA9yWQUFGZiCV4RGAoAoj6/OiTPKc26lMjSYnL5GiUJIowbS
	 9ycmV9m47h2baA6ZpGx1Z8CG9QVnUKV66i3TDyJyWcxkcZIHGuRN6Z2rRLlGhr4plp
	 k/AVZDoRAXUzw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 14C0945225
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DVWwE8b8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VmBap1sE;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D469Fm173800
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h7YZRIa+NRNY0y0wXCVE1k0DjUJFm0HRtljake6wepM=; b=DVWwE8b8Rx8t2r6m
	11Lj1DzUuo6jymUVXc6PIdpnQdj9fueuGkZIYwnFRZ6xNKzSdu23aGqkasjmAO9k
	FMzoR1LZ2gMN1WRbYhNNJAEIf4wqzAqt2yUlRmrZHhaHaudgz6dxkSMjU3lc968d
	kl0qPY0sKlmq3EiISNXv9i8nw6UOx1uSSa8uExfCtsDc9L1/z7wq7S19+TDEqDT5
	8A6+/tN5Jd75GBI94OF2EblFYQvUKYlcDKuV9LWFHRUYkNQXss1u8uapdlLVBd3D
	nJSgShcXcyjnn8ptc9glyDOnx0PznPmlnhvvIL952zwqJAI8GXqK4AKgZM8NPkZK
	f3pI4Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9daqr9un-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 13 Oct 2026 05:41:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3a7fa5e0442so3849960a91.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 12 Oct 2026 22:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791870115; x=1792474915; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h7YZRIa+NRNY0y0wXCVE1k0DjUJFm0HRtljake6wepM=;
        b=VmBap1sEln6fEz6HZm7wWoaCAe1CU0FqungImN1BXER8bBwSjKIYA/sq4iwVTSvdqs
         rC6xcR6aGCIe/GRtr2aEWxaqcPilI3fNCUJ8xUSij3ZaSKcMXnw7Fuf5oQ+qNM6j0aLK
         Y0MrJqeSVzQ1iPPZHQPyx+fcwY/JjfotpDvXLeegFlHN8bPf2MCHYv+byVbtBGG6+Q7t
         Q3t/0Mt3GWFlJlBoAHrkWl/JJsV1Z2nrmPFe8aQHIXFQ6G5ZHg//YdEt03JtOtljQB1r
         VAF4SFxRCHjN/eNKa3bZ7CCjCmQA7qIepL/3+fXMAO9/ZDxE4QDc7SI52gmY4SyaUP/2
         PNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791870115; x=1792474915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h7YZRIa+NRNY0y0wXCVE1k0DjUJFm0HRtljake6wepM=;
        b=lyWrRa1pyPP6GECHX2baZZ4zY9EsRw/Hhk7BBAeHGRnbLovui9Tw7A+mfeJ5zXxHso
         6P5EOgA+43VYJ3q7DeUol0C1jPUI9Cnlg0OrnwoZ9oaCIeUOfHqk5gQaWksPslZYg6X9
         j6eJpK5diTL1DzIt79mcfUt6FRqmZCXwHidFUMRMrak93g0acAeD3PVdmxS5Kp4IWNs9
         dXmJatmUbmERe3Oylaod6emsUIK9dDH49P29lE8V+36FSwm5H+U7ilD8yX3xTarSNWvu
         t0c/zdRdrzLb/US65EtNn3uovbISLw4gCmNDMQozgETAjRIywG3CCxQo5ggZX++PMuur
         DynQ==
X-Forwarded-Encrypted: i=1; AKwUvBwH2c8utQA0OCP/KfAZ2guVqs3oazrAfE0zpLFyhJoweCn74THkzYu7uDBDztxWeJyZYyDpcCg=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYJ92A7VOSpiiEBSEz2CNK9g+Tx1+RnpFAs3at4e/Ta27egz3LGQ
	uMkSQ3+iYVR2N8Q8uJOD8XIqcBcWu8MwFHRAPEAwUi7+2uYCltyoF7gVd0w/0gjhOxvVTgpJFYc
	PBoeEgHROQ4SIpN5s8XxMi1UM1zMOTiCZQCZgND/PraOrL441feKpHtJ3RvexDsLmiiHBr4Y=
X-Gm-Gg: AYBFou3+EhX9rT2mBfFNlFGbgjNd6lqR8nm4vaAepXt1I4jvbsDvRaTa8IeFmLgiiZx
	34/+pZ6btRCZeHP6LUq/eRvml3r2cn9WWPbfZBE8CySDXVG6u0bSzQRw21kJIJP0LeYvSCKiZho
	Asaw0GSVVhKxY1DfDfc/X0C5Zuv6+cmz1ew31vuoMQVVZQY2lcJeVJUYoeyvCJSgc39kULjpK0o
	Q5I3hsc8G7TYDEzj4sckNRR6J0DGO8vMuXYmvk4FlKHajKo3XgJp8v0nIFvU7gHkliHkrfy4AWj
	I6qRPVYha97A8qstT/DmPqPtyY9dbKBi3e2o3FKrZcmKB5rSGUkN1hNLSsoqbxlQ5XvNmGCoxI+
	SMSZC5NKDeyCa9CfxxtTjQe1g55xRfuZ790ohWO2jxcvcYEalmZfIKq/oyQ==
X-Received: by 2002:a17:90a:d006:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-3ab3a90e57amr8356618a91.12.1791870114640;
        Mon, 12 Oct 2026 22:41:54 -0700 (PDT)
X-Received: by 2002:a17:90a:d006:b0:39e:53a:c8d4 with SMTP id 98e67ed59e1d1-3ab3a90e57amr8356597a91.12.1791870114075;
        Mon, 12 Oct 2026 22:41:54 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38f4863esm22926361a91.11.2026.10.12.22.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:41:53 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:41:31 -0700
Subject: [PATCH RFC v3 4/9] tee: optee: add RPMI shared-memory and
 parameter support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpmi-tee-service-grp-dev-v3-4-975b574667e2@oss.qualcomm.com>
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
X-Proofpoint-GUID: 9ZG10Aj6EYHWxfM6B6ndP3za_PZJsWNo
X-Authority-Analysis: v=2.4 cv=FZuiV5+6 c=1 sm=1 tr=0 ts=6acdc4a3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=bl3zVpOXNXRnPWSUSmgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX0CtLGX10s+JU
 noBqRYs6nJPdHtSorrP+dMpugqnMgKYVMq6/HpEMlJYcTtz1n+jwe7hDD5g4x1pC9XY1TIt8jRk
 8CTz52bXnhwYRhmFGR2Hn/9p19kLT6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMiBTYWx0ZWRfX5hvXZuwIyPL/
 qE93QohoSaeFNTGHti1I7S4SILDO1a/UrEfqVtrezjUyfPlXOttFSxnmvpzCWSQOtpZOTj9AhqS
 Gf9JE4aXsta3wmEYAYJ9k76fXzNZJBHbF18BV72bfXVIFqw57ufsFhGla02x+C6QdkQxQmDUAXX
 3EZIGNNbJGourX0pLw/R9GA0XdRkiY3Z0Sb8wWyerka4dG9VWGzkaVguGuYqDXIqFHMZFxgDR5r
 Kzs61ce7ll5TgP+XVMFPwmTRiREXL0pWWWq4xVkChFDQnXC1cSIT+PP+msvmtJ2+7pozSV8LkyL
 QPdps/qcjy7yX8RUjQ2Q1DHA4P1Ki4DOkLrdQ27LM7Bdyi8ViZLJ+BXJTPuNecQ6Y3WyfeGOMO7
 IMKdcjUmPH7Fvk8I+XHeufiGD/r2/ytQKVI+eU5GFUkb4uXpqv+a4bYUq4ksMhvMoozXPB3pS3h
 lLmF/1Pq6y/eR1xFpOQ==
X-Proofpoint-ORIG-GUID: 9ZG10Aj6EYHWxfM6B6ndP3za_PZJsWNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
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
X-Rspamd-Queue-Id: 14C0945225
X-Spamd-Bar: -----
Message-ID-Hash: O6YDNNSQIIIV42ARVQSNQVXTPC7NJT3W
X-Message-ID-Hash: O6YDNNSQIIIV42ARVQSNQVXTPC7NJT3W
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/O6YDNNSQIIIV42ARVQSNQVXTPC7NJT3W/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

OP-TEE commands and RPCs need shared memory that secure world can
identify through RPMI parcels.

Register normal-world pages as read-write parcels shared with the
OP-TEE endpoint. Track each parcel ID and nonce with the common
shared-memory map. Store the combined identity in tee_shm.sec_world_id
and allocate nonzero nonces to distinguish registered memory from NULL
references. Reuse nonces after successful parcel reclamation.

Add conversions between TEE parameters and parcel memory references.

On client memory unregistration, ask OP-TEE to release its mapping
before reclaiming the parcel. Supplicant memory has already been
released by OP-TEE through its SHM_FREE RPC and only needs reclaiming.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/Makefile        |   1 +
 drivers/tee/optee/optee_private.h |  19 +++
 drivers/tee/optee/rpmi_abi.c      | 319 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index ec2efc27ef05..4794c7c0ef91 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -10,6 +10,7 @@ optee-objs += device.o
 optee-objs += shm_handle_map.o
 optee-$(CONFIG_HAVE_ARM_SMCCC) += smc_abi.o
 optee-$(CONFIG_ARM_FFA_TRANSPORT) += ffa_abi.o
+optee-$(CONFIG_RISCV_RPMI_TEE_TRANSPORT) += rpmi_abi.o
 
 # for tracing framework to find optee_trace.h
 CFLAGS_smc_abi.o := -I$(src)
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 92428945ee33..efc1e37fe1bf 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -6,6 +6,7 @@
 #ifndef OPTEE_PRIVATE_H
 #define OPTEE_PRIVATE_H
 
+#include <linux/idr.h>
 #include <linux/notifier.h>
 #include <linux/rhashtable.h>
 #include <linux/rpmb.h>
@@ -200,6 +201,20 @@ struct optee_ffa {
 };
 #endif
 
+#if IS_REACHABLE(CONFIG_RISCV_RPMI_TEE_TRANSPORT)
+/**
+ * struct optee_rpmi - RPMI transport-specific OP-TEE state
+ * @rdev: owning RPMI service device
+ * @shm_map: lookup by the host-endian parcel ID and nonce pair
+ * @nonce_ida: nonzero SHM nonces, reusable after successful parcel reclamation
+ */
+struct optee_rpmi {
+	struct rpmi_tee_device *rdev;
+	struct optee_shm_handle_map shm_map;
+	struct ida nonce_ida;
+};
+#endif
+
 struct optee;
 
 /**
@@ -260,6 +275,7 @@ struct optee_ops {
  * @ctx:			driver internal TEE context
  * @smc:			specific to SMC ABI
  * @ffa:			specific to FF-A ABI
+ * @rpmi:			specific to RPMI ABI
  * @shm_arg_cache:		shared memory cache argument
  * @call_queue:			queue of threads waiting to call @invoke_fn
  * @notif:			notification synchronization struct
@@ -291,6 +307,9 @@ struct optee {
 #endif
 #if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
 		struct optee_ffa ffa;
+#endif
+#if IS_REACHABLE(CONFIG_RISCV_RPMI_TEE_TRANSPORT)
+		struct optee_rpmi rpmi;
 #endif
 	};
 	struct optee_shm_arg_cache shm_arg_cache;
diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
new file mode 100644
index 000000000000..940676794280
--- /dev/null
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/overflow.h>
+#include <linux/rpmi_tee.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+#include "optee_private.h"
+#include "optee_rpmi.h"
+
+/* Keep transport errors separate from the control status in a response. */
+static int optee_rpmi_call_with_status(struct optee *optee,
+				       const void *req, size_t req_len,
+				       void *resp, size_t resp_size,
+				       u32 *status)
+{
+	struct rpmi_tee_device *rdev = optee->rpmi.rdev;
+	size_t received = resp_size;
+	int rc;
+
+	rc = rdev->ops->msg_ops->call(rdev, req, req_len, resp, &received);
+	if (rc)
+		return rc;
+
+	if (received != resp_size)
+		return -EPROTO;
+
+	*status = get_unaligned_le32(resp);
+
+	return 0;
+}
+
+/**
+ * optee_rpmi_call - Send a control request and check its TEE result
+ * @optee: OP-TEE instance.
+ * @req: Control request, including the operation number.
+ * @req_len: Request size in bytes.
+ * @resp: Response buffer, beginning with a little-endian TEE result.
+ * @resp_size: Exact expected response size, including the status field.
+ *
+ * Return: 0 on success, a transport error, -EPROTO for an unexpected response
+ * size, or -EIO for an unsuccessful control response.
+ */
+static int optee_rpmi_call(struct optee *optee, const void *req, size_t req_len,
+			   void *resp, size_t resp_size)
+{
+	u32 status;
+	int rc;
+
+	rc = optee_rpmi_call_with_status(optee, req, req_len, resp, resp_size,
+					 &status);
+	if (rc)
+		return rc;
+	else if (status != TEEC_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+static int optee_rpmi_shm_register(struct tee_context *ctx, struct tee_shm *shm,
+				   struct page **pages, size_t num_pages,
+				   unsigned long start)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct rpmi_tee_device *rdev = optee->rpmi.rdev;
+	struct rpmi_tee_mem_receiver receiver = {
+		.endpoint_id = rdev->endpoint_id,
+		.access = RPMI_TEE_MEM_ACCESS_READ | RPMI_TEE_MEM_ACCESS_WRITE,
+	};
+	struct rpmi_tee_mem_args args = {
+		.receivers = &receiver,
+		.receiver_count = 1,
+		.creator_access = RPMI_TEE_MEM_ACCESS_READ |
+				  RPMI_TEE_MEM_ACCESS_WRITE,
+	};
+	struct sg_table sgt;
+	u64 global_id;
+	int rc;
+
+	rc = optee_check_mem_type(start, num_pages);
+	if (rc)
+		return rc;
+
+	rc = sg_alloc_table_from_pages(&sgt, pages, num_pages, 0,
+				       num_pages * PAGE_SIZE, GFP_KERNEL);
+	if (rc)
+		return rc;
+
+	rc = ida_alloc_min(&optee->rpmi.nonce_ida, 1, GFP_KERNEL);
+	if (rc < 0) {
+		sg_free_table(&sgt);
+		return rc;
+	}
+
+	args.nonce = rc;
+	args.sg = sgt.sgl;
+	rc = rdev->ops->mem_ops->memory_share(rdev, &args);
+	sg_free_table(&sgt);
+	/* A failed exchange may leave a parcel using this nonce. */
+	if (rc)
+		return rc;
+
+	global_id = optee_rpmi_global_id(args.parcel_id, args.nonce);
+
+	rc = optee_shm_handle_map_add(&optee->rpmi.shm_map, shm, global_id);
+	if (rc) {
+		int rrc;
+
+		rrc = rdev->ops->mem_ops->memory_reclaim(rdev, args.parcel_id);
+		/* Keep the nonce if firmware may still hold the parcel. */
+		if (rrc)
+			dev_err(&rdev->dev, "reclaim parcel %#x failed: %d\n",
+				args.parcel_id, rrc);
+		else
+			ida_free(&optee->rpmi.nonce_ida, args.nonce);
+
+		return rc;
+	}
+
+	shm->sec_world_id = global_id;
+
+	return 0;
+}
+
+static int optee_rpmi_shm_unregister(struct tee_context *ctx,
+				     struct tee_shm *shm)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct rpmi_tee_device *rdev = optee->rpmi.rdev;
+	struct optee_rpmi_unregister_req req = {
+		.op = cpu_to_le32(OPTEE_RPMI_UNREGISTER_SHM),
+		.global_id = cpu_to_le64(shm->sec_world_id),
+	};
+	struct optee_rpmi_status_resp resp;
+	u32 parcel_id = optee_rpmi_parcel_id(shm->sec_world_id);
+	u32 nonce = optee_rpmi_nonce(shm->sec_world_id);
+	int rc;
+
+	optee_shm_handle_map_remove(&optee->rpmi.shm_map, shm->sec_world_id);
+	shm->sec_world_id = 0;
+
+	rc = optee_rpmi_call(optee, &req, sizeof(req), &resp, sizeof(resp));
+	if (rc)
+		dev_err(&rdev->dev, "unregister parcel %#x failed: %d\n",
+			parcel_id, rc);
+
+	rc = rdev->ops->mem_ops->memory_reclaim(rdev, parcel_id);
+	/* Keep the nonce if firmware may still hold the parcel. */
+	if (rc)
+		dev_err(&rdev->dev, "reclaim parcel %#x failed: %d\n",
+			parcel_id, rc);
+	else
+		ida_free(&optee->rpmi.nonce_ida, nonce);
+
+	return rc;
+}
+
+static int optee_rpmi_shm_unregister_supp(struct tee_context *ctx,
+					  struct tee_shm *shm)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct rpmi_tee_device *rdev = optee->rpmi.rdev;
+	u32 parcel_id = optee_rpmi_parcel_id(shm->sec_world_id);
+	u32 nonce = optee_rpmi_nonce(shm->sec_world_id);
+	int rc;
+
+	optee_shm_handle_map_remove(&optee->rpmi.shm_map, shm->sec_world_id);
+	shm->sec_world_id = 0;
+	/* OP-TEE has already retired the parcel through SHM_FREE RPC. */
+	rc = rdev->ops->mem_ops->memory_reclaim(rdev, parcel_id);
+	/* Keep the nonce if firmware may still hold the parcel. */
+	if (rc)
+		dev_err(&rdev->dev, "reclaim parcel %#x failed: %d\n",
+			parcel_id, rc);
+	else
+		ida_free(&optee->rpmi.nonce_ida, nonce);
+
+	return rc;
+}
+
+/* Convert a memory reference to an OP-TEE RPMI parcel reference. */
+static int to_msg_param_rpmi_mem(struct optee_msg_param *mp,
+				 const struct tee_param *p)
+{
+	struct tee_shm *shm = p->u.memref.shm;
+
+	mp->attr = OPTEE_MSG_ATTR_TYPE_PMEM_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+	memset(&mp->u, 0, sizeof(mp->u));
+	/* For !shm, a zero global_id encodes a NULL reference. */
+	if (shm) {
+		if (check_add_overflow((u64)shm->offset,
+				       (u64)p->u.memref.shm_offs,
+				       &mp->u.pmem.offs))
+			return -EINVAL;
+
+		mp->u.pmem.global_id = shm->sec_world_id;
+	}
+
+	mp->u.pmem.size = p->u.memref.size;
+
+	return 0;
+}
+
+static int optee_rpmi_to_msg_param(struct optee *optee,
+				   struct optee_msg_param *msg_params,
+				   size_t num_params,
+				   const struct tee_param *params)
+{
+	size_t n;
+
+	for (n = 0; n < num_params; n++) {
+		const struct tee_param *p = params + n;
+		struct optee_msg_param *mp = msg_params + n;
+
+		switch (p->attr) {
+		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
+			mp->attr = OPTEE_MSG_ATTR_TYPE_NONE;
+			memset(&mp->u, 0, sizeof(mp->u));
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT:
+			optee_to_msg_param_value(mp, p);
+			break;
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
+		case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
+			if (to_msg_param_rpmi_mem(mp, p))
+				return -EINVAL;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/* Convert an RPMI parcel reference to a memref; callers own SHM lifetime. */
+static int from_msg_param_rpmi_mem(struct optee *optee, struct tee_param *p,
+				   u32 attr, const struct optee_msg_param *mp)
+{
+	struct tee_shm *shm;
+	u64 offset;
+
+	p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT + attr -
+		  OPTEE_MSG_ATTR_TYPE_PMEM_INPUT;
+
+	if (mp->u.pmem.size > SIZE_MAX)
+		return -EOVERFLOW;
+	p->u.memref.size = mp->u.pmem.size;
+
+	if (!optee_rpmi_nonce(mp->u.pmem.global_id)) {
+		/* Return NULL shm. */
+		if (mp->u.pmem.offs)
+			return -EINVAL;
+		p->u.memref.shm = NULL;
+		p->u.memref.shm_offs = 0;
+		return 0;
+	}
+
+	shm = optee_shm_handle_map_lookup(&optee->rpmi.shm_map,
+					  mp->u.pmem.global_id);
+	if (!shm || mp->u.pmem.offs < shm->offset)
+		return -EINVAL;
+
+	offset = mp->u.pmem.offs - shm->offset;
+	if (offset > SIZE_MAX)
+		return -EOVERFLOW;
+
+	p->u.memref.shm = shm;
+	p->u.memref.shm_offs = offset;
+
+	return 0;
+}
+
+static int optee_rpmi_from_msg_param(struct optee *optee,
+				     struct tee_param *params,
+				     size_t num_params,
+				     const struct optee_msg_param *msg_params)
+{
+	size_t n;
+
+	for (n = 0; n < num_params; n++) {
+		const struct optee_msg_param *mp = msg_params + n;
+		struct tee_param *p = params + n;
+		u32 attr = mp->attr & OPTEE_MSG_ATTR_TYPE_MASK;
+		int rc;
+
+		switch (attr) {
+		case OPTEE_MSG_ATTR_TYPE_NONE:
+			p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
+			memset(&p->u, 0, sizeof(p->u));
+			break;
+		case OPTEE_MSG_ATTR_TYPE_VALUE_INPUT:
+		case OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT:
+		case OPTEE_MSG_ATTR_TYPE_VALUE_INOUT:
+			optee_from_msg_param_value(p, attr, mp);
+			break;
+		case OPTEE_MSG_ATTR_TYPE_PMEM_INPUT:
+		case OPTEE_MSG_ATTR_TYPE_PMEM_OUTPUT:
+		case OPTEE_MSG_ATTR_TYPE_PMEM_INOUT:
+			rc = from_msg_param_rpmi_mem(optee, p, attr, mp);
+			if (rc)
+				return rc;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}

-- 
2.34.1

