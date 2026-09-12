Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCAAC88E53
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:17:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C667A451C9
	for <op-tee@archiver.kernel.org>; Sat, 12 Sep 2026 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789208221;
	bh=sARL4dPYRxMvYgVNSvQfNt3Ga3Sr9irnvb13sM7/k0g=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=akvHnWoHx5vKOye7eu5B0LU5M4zg9H54foUIsi+sjsj/bQXjMACLXYRGqiXCb905X
	 5+2Z4jzuYJOzZiwJM/c5XhQRMxbqLG1OZ+h5wr2n6/WT1k0HB7P2mfyw06NXVrK2fc
	 lUmlsslVRQRdenqdZefQodQGjsY/VhHFlXrc10ENwJriEe25CqI6ULSq5mS9ejDz37
	 P5Eat+PV3ix9MJGADyvyUbXjAQ4MVFWjwOa0Bo6EvgUObb2+ZqBRS62xRhje4sX//f
	 RhN5ztxwb9XzhNNfCxzgEM0UFVYdg2uK80Zp6mEkuuiBCmoKAbAys8DCimQmkmRn0I
	 kkP1ZC00v8gtg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E08314543E
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KfP1Qt8y;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHOKwpr9;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C84x1s2832758
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d6UoxbSLyrBSPbqba+6zSoUWkcciKGuJ9cbgG2XM+Ss=; b=KfP1Qt8yIKzZyFz+
	d1Gx7hXLTWBKY2E4o8uOqYzhoqMlAxWBgNzY12p3HrEoyJ8rhUYj1nZH823cwkV9
	pYgMQZECdOt5Vxp4rb0+IUaQA2gYMQKo5WiNIkjx670hQcl6W2tMXFl0upTHeKML
	OOMMNRGbrnoFrYdLKh5AcS7QjbgFybXgOpO40JsP0o16HrBwcSzEwIbT3WhZlhIy
	oy3OXBFwSaRlPCwidNUnH4KGyiyLpD+Qf1kDM3yTgTUh0mqIafqhK7IfKwICfZGP
	lM57Gxz7dUMODdXa3BuqHai2roUCW+YDuTGuYJgfjOPRDZIbB0WJ+R1ejO0Und2Y
	QKdhuQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dgpy8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 10:15:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39dc5d85a9cso100633a91.2
        for <op-tee@lists.trustedfirmware.org>; Sat, 12 Sep 2026 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789208132; x=1789812932; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d6UoxbSLyrBSPbqba+6zSoUWkcciKGuJ9cbgG2XM+Ss=;
        b=kHOKwpr9g8A0Pn8O0qh44PvmfaUaDZMPYDhL7PYEXSUHC0anpmb1NI/6+gpcm4FVv2
         hNcR1UMGcUfH5diGHpQQ0ZdUKtLNWNxh86+ZgGNjTAzqnsjyCF3uquPj7VviW1H33z+O
         SWdS+e5oGXIPZ0wisHkOpR5DpZdNKSPn38t+wRuz1rNqpEYXSecDL75cQ7FiBKx6z8Vk
         vYZ7IkNJPdcYh2GbBYPhSSP/lmArt0n9/0po+HoKJNbczO3q/CkFLy3MSO9ODK8HL6ha
         kSyP0xSeTqQKBlSkiw1TzXqygmqNSsihh8k2vKPHAryhQnuRevrveIp+sAMucq20bb9c
         Rbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789208132; x=1789812932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6UoxbSLyrBSPbqba+6zSoUWkcciKGuJ9cbgG2XM+Ss=;
        b=PBs1a2mDOYVslkEjMiF/I6DD53OoF4cg+1+F5+2Mcq+FYDNPkbO5sz2CJzWUk9dRAC
         DAITyFmsAai6pZu+XPK33IxtwE56bbiAnDvnlKom326TxcvTaCHymgTTJKlTljr6Kr8o
         aga5AmGsRsIDQtLe/WAwa0yiidAr8kW56hsZCFGo4CpF5yDyCsXcdNtJB3XW9rocjZJq
         sRL5JAhLQ/0OVdIEuHhCMHBAuVvxcDWh4oH2SaUC+Sc3Pcs8UVujsqS7/YNVx7yjEpT0
         xvaU8UM2rvh99NMgD+q5bqttGRe49Fe5f2IouQloafUfSfqdgJBB0Qe0cyg6lhXG8puY
         e3uQ==
X-Forwarded-Encrypted: i=1; AKwUvBwV6+mjy8nUutmB+U+q5nWhuqEvGtxSqiVa4zX+fhuxx7i9uivahcQo+du+zBkPElNo7arnVMo=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++lGcD67nMLGzM3DjD3h77ZAWw7OGcxvVf9VXSMJKoRHAj9cR1gm
	b4TIW3WW7+aFhRQuFdTW+BwLvFzcVNI+eEMh2GqN+fOHKEdHIWGqtI4MacObkI9BcKJEPElHqu5
	rJoXpC2K+WKAXs6soG5JtnKn4bWH4PbgpdSt6WJKyUaR4dlex+NzN+bY4sJx393HUL0c0tyY=
X-Gm-Gg: AYBFou20/aF4sk6t3kYKjtOdiCYk6WglM8CzbnYnBLkvbzzdpy20awBoWvsrsRAifZa
	eeoUI67pRFDlmz/X0iBFul3izKZryIpyiVVQLhikx32CEJy8MpqL2mEd6GSwD1mwvyJnJ1aioIV
	9wiJ/nVDftlfxVqex5Wu4Ez3uwPS4UxAZQy+bl36UY7/iLydFXiRdZQJqe+LM/5zuwRmsDUz3SB
	tmwiiQ8fd+q5GOogmUbXDpJY5TvqSQfdrroX4HUvj7dUwQiEmp8R2PEua7PdvXzCFZAjcYDywTu
	ILndTQ2LAvjGy05kVvvGTsd3UpxrDmSsXCCpRSgNi20W27jx5LcB9d+up7/+rZckAXzr+zur6AD
	jWj6F2lEf0uVODwC5OJ8WRV++RDIz1fOPcZ6i0v3yhjm4dRCm2Ob6Y/f67J8=
X-Received: by 2002:a17:90b:5745:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39d9bd685e6mr14334876a91.10.1789208130949;
        Sat, 12 Sep 2026 03:15:30 -0700 (PDT)
X-Received: by 2002:a17:90b:5745:b0:398:c292:ac80 with SMTP id 98e67ed59e1d1-39d9bd685e6mr14334765a91.10.1789208130120;
        Sat, 12 Sep 2026 03:15:30 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33baf0ea9a1sm10340085eec.8.2026.09.12.03.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 03:15:29 -0700 (PDT)
Date: Sat, 12 Sep 2026 03:15:13 -0700
Subject: [PATCH RFC 2/5] optee: riscv: add shared memory and scheduled
 calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-rpmi-tee-service-grp-dev-v1-2-1d1d35c2a859@oss.qualcomm.com>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
In-Reply-To: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfX7R76ZjupXJFY
 ydgohN9+DwztrJE428wVxzsnoHwkT8XiizpdbfoAB8IMvpcR0/moA6UjJ/2lWZ48bGnaSzkZJzv
 DRdcHjANkao6a2z+vnnnDG0/q59U42Hvn/Mua+LYYuexa8uUdIt3kC0rgvBGKXQbLS5fXjJogD2
 kya7lU+/w3OzE77oHoxN/l5HiXUZR2KHafupvzCHQ4Hdyujmtco4xOigoM56+YrJnp320sZtIwO
 TbzWDrMlU+nwW2Z3PeMBxq0lmGZ7ERUvjOS7vPkQKZ+lDCHiFnNRpE9OIJks7B0l8nnea8d5stF
 uXbsogE2Ug9AsEVjHma/rPhvPs+ofm/t3CLFnk8B2mbME1evZCgVnyHiRtGfINNW1eSbOy60NxI
 qGH0/1yiWiB5wa3JEWnu1uVWUBvyCd2Tzn9fr9CUuy0EhTapInJiVydudYPakMVBojKHHNUT4ks
 1rn7SymNjpHbXOr37qw==
X-Proofpoint-ORIG-GUID: _f00QKZpT39YcxQi7WRf-XhiI5L6X2do
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE0NiBTYWx0ZWRfX70ATr2zlT3ss
 9QgoRRfwvZaTF+D/hd0rZoF7NlmCyn74UubZOkzAcrB1Q6j3xpD5jxPiM9anINvnPbHE+KSZPU3
 Y43UalVz7HI6WPwXzJApTyQ+XIzCQwA=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa52644 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xB-oHHMGf5EPZTKqN7QA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: _f00QKZpT39YcxQi7WRf-XhiI5L6X2do
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	URIBL_BLOCKED(0.00)[oss.qualcomm.com:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,mx0b-0031df01.pphosted.com:helo,mx0b-0031df01.pphosted.com:rdns];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TAGGED_RCPT(0.00)[dt];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E08314543E
X-Spamd-Bar: -----
Message-ID-Hash: TUD52YEZV5YBU4QQ6NCS5AVDPO5APGZL
X-Message-ID-Hash: TUD52YEZV5YBU4QQ6NCS5AVDPO5APGZL
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TUD52YEZV5YBU4QQ6NCS5AVDPO5APGZL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add the shared-memory and call support required by the RISC-V RPMI
transport.

Use RPMI memory parcels to share memory between Linux and OP-TEE and keep
a mapping between parcel identifiers and struct tee_shm. Pass the parcel
identifier and offset when referencing shared memory from OP-TEE message
parameters.

Implement scheduled calls using RPMI TEE_CALL, including yielding calls,
RPC handling and shared-memory allocation. Also add OP-TEE version and
capability negotiation and complete registration of the OP-TEE device.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/optee_private.h |    2 +
 drivers/tee/optee/optee_riscv.c   | 1198 ++++++++++++++++++++++++++++++++++---
 drivers/tee/optee/optee_riscv.h   |  135 ++++-
 3 files changed, 1257 insertions(+), 78 deletions(-)

diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 8d22d65e087b..cf878b8178f9 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -178,6 +178,7 @@ struct optee_ffa {
  * @dev:		device backing the RPMI TEE mailbox client
  * @nr_chan:		number of entries in @chan
  * @max_msg_data_size:	maximum RPMI message data size of the TEE channel
+ * @next_nonce:		monotonic nonce source for memory parcel creation
  * @mutex:		serializes access to @global_ids
  * @global_ids:		memory parcel id to tee_shm translation table
  *
@@ -191,6 +192,7 @@ struct optee_riscv {
 	struct device *dev;
 	unsigned int nr_chan;
 	u32 max_msg_data_size;
+	atomic_t next_nonce;
 	/* Serializes access to @global_ids */
 	struct mutex mutex;
 	struct rhashtable global_ids;
diff --git a/drivers/tee/optee/optee_riscv.c b/drivers/tee/optee/optee_riscv.c
index 0fe4edf92fc9..36115326486d 100644
--- a/drivers/tee/optee/optee_riscv.c
+++ b/drivers/tee/optee/optee_riscv.c
@@ -8,34 +8,46 @@
  * RPMI framework (OpenSBI), and shared memory follows the FF-A memory-donation
  * model through the RPMI memory parcel services.
  *
- * This file is divided into the following sections:
- * 1. Low level RPMI TEE service group transport over the SBI MPXY mailbox
- * 2. Feature discovery and notification handshake
- * 3. Driver initialization
+ * This file is structured exactly like ffa_abi.c:
+ * 1. Maintain a hash table for lookup of a memory parcel id
+ * 2. Convert between struct tee_param and struct optee_msg_param
+ * 3. Low level support functions to register shared memory in secure world
+ * 4. Dynamic shared memory pool based on alloc_pages()
+ * 5. Do a normal scheduled call into secure world
+ * 6. Driver initialization
  *
- * The remaining FF-A-equivalent sections (parcel id hash table, tee_param
- * marshalling, dynamic shared memory pool and the scheduled call into secure
- * world) are added on top of this transport layer.
+ * Every FF-A memory operation has a direct RPMI TEE service group analog:
+ *   FFA_MEM_SHARE     -> MEM_PARCEL_CREATE  (0x09), issued by the REE
+ *   FFA_MEM_RECLAIM   -> MEM_PARCEL_RECLAIM (0x0c), issued by the REE
+ *   direct message    -> TEE_CALL           (0x13), the call doorbell
+ * and the FF-A g_handle is replaced by a memory parcel id folded together
+ * with a caller-supplied nonce.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/rhashtable.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
+#include <linux/string.h>
 #include <linux/tee_core.h>
 #include <linux/types.h>
 
 #include "optee_private.h"
 #include "optee_riscv.h"
+#include "optee_rpc_cmd.h"
 
 /*
- * 1. Low level RPMI TEE service group transport over the SBI MPXY mailbox
+ * Low level RPMI TEE service group transport over the SBI MPXY mailbox.
  *
  * The RPMI TEE service group is reached through the SBI MPXY mailbox. Each
  * hart owns a dedicated MPXY channel so that a call issued on a given hart is
@@ -60,25 +72,43 @@ static int optee_riscv_send(struct optee *optee, struct rpmi_mbox_message *msg)
 }
 
 /*
- * 2. Feature discovery and notification handshake
+ * optee_riscv_tee_call() - issue a TEE_CALL (RPMI service 0x13)
+ * @optee:	main service struct
+ * @in:		the command words carried in SERVICE_DATA, the RISC-V analog
+ *		of struct ffa_send_direct_data's data0-data4 (w3-w7)
+ * @out:	the response words returned in SERVICE_RSP, the RISC-V analog
+ *		of the same data0-data4 set on the return path
  *
- * TEE_PROBE_FEATURES (0x02) reports which framework features are available;
- * TEE_ENABLE_NOTIFICATION (0x01) subscribes to TEE service group events. Both
- * are mandatory services (RPMI spec section 4.16), so probing them also
- * confirms that the framework speaks the TEE service group on this channel.
+ * TEE_CALL is the RISC-V analog of the FF-A direct message: it is the single
+ * doorbell used both for the blocking (fast) calls of section 6 and for the
+ * yielding call of section 5. The struct optee_msg_arg itself is never
+ * carried here, only its parcel handle and offset, exactly as FF-A carries
+ * only w4-w6.
+ *
+ * Returns 0 on success or <0 on failure.
  */
-
-static int optee_riscv_probe_feature(struct optee *optee, u32 feature_id,
-				     u32 *value)
+static int optee_riscv_tee_call(struct optee *optee,
+				const u64 in[RPMI_TEE_OPTEE_CALL_REGS],
+				u64 out[RPMI_TEE_OPTEE_RESP_REGS])
 {
-	struct rpmi_tee_probe_features_req tx = {
-		.feature_id = cpu_to_le32(feature_id),
+	static const u8 optee_uuid[RPMI_TEE_UUID_LEN] = RPMI_TEE_OPTEE_UUID;
+	struct rpmi_tee_call_req tx = {
+		.sender_id = cpu_to_le32(RPMI_TEE_ENDPOINT_REE),
+		.target_id = cpu_to_le32(RPMI_TEE_ENDPOINT_OPTEE),
+		.service_data_len =
+			cpu_to_le32(RPMI_TEE_OPTEE_CALL_REGS *
+				    sizeof(rpmi_xlen_t)),
 	};
-	struct rpmi_tee_probe_features_resp rx = { };
+	struct rpmi_tee_call_resp rx = { };
 	struct rpmi_mbox_message msg;
+	unsigned int i;
 	int ret;
 
-	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_PROBE_FEATURES,
+	memcpy(tx.service, optee_uuid, sizeof(tx.service));
+	for (i = 0; i < RPMI_TEE_OPTEE_CALL_REGS; i++)
+		tx.reg[i] = cpu_to_rpmi_xlen(in[i]);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_CALL,
 					  &tx, sizeof(tx), &rx, sizeof(rx));
 	ret = optee_riscv_send(optee, &msg);
 	if (ret)
@@ -86,61 +116,887 @@ static int optee_riscv_probe_feature(struct optee *optee, u32 feature_id,
 	if (rx.status)
 		return rpmi_to_linux_error(le32_to_cpu(rx.status));
 
-	if (value)
-		*value = le32_to_cpu(rx.value);
+	for (i = 0; i < RPMI_TEE_OPTEE_RESP_REGS; i++)
+		out[i] = rpmi_xlen_to_cpu(rx.reg[i]);
 
 	return 0;
 }
 
-static int optee_riscv_features(struct optee *optee)
+/*
+ * 1. Maintain a hash table for lookup of a memory parcel id
+ *
+ * The RPMI framework assigns a memory parcel id for each piece of shared
+ * memory. Together with a caller-supplied nonce it forms the wire identity
+ * used when communicating with secure world, playing the exact role of the
+ * FF-A global memory handle.
+ *
+ * Main functions are optee_shm_add_riscv_handle() and
+ * optee_shm_rem_riscv_handle().
+ */
+struct shm_rhash {
+	struct tee_shm *shm;
+	u64 global_id;
+	struct rhash_head linkage;
+};
+
+static void rh_free_fn(void *ptr, void *arg)
 {
-	u32 share = RPMI_TEE_MEMORY_SHARE_NONE;
+	kfree(ptr);
+}
+
+static const struct rhashtable_params shm_rhash_params = {
+	.head_offset = offsetof(struct shm_rhash, linkage),
+	.key_len     = sizeof(u64),
+	.key_offset  = offsetof(struct shm_rhash, global_id),
+	.automatic_shrinking = true,
+};
+
+static struct tee_shm *optee_shm_from_riscv_handle(struct optee *optee,
+						   u64 global_id)
+{
+	struct tee_shm *shm = NULL;
+	struct shm_rhash *r;
+
+	mutex_lock(&optee->riscv.mutex);
+	r = rhashtable_lookup_fast(&optee->riscv.global_ids, &global_id,
+				   shm_rhash_params);
+	if (r)
+		shm = r->shm;
+	mutex_unlock(&optee->riscv.mutex);
+
+	return shm;
+}
+
+static int optee_shm_add_riscv_handle(struct optee *optee, struct tee_shm *shm,
+				      u64 global_id)
+{
+	struct shm_rhash *r;
+	int rc;
+
+	r = kmalloc_obj(*r);
+	if (!r)
+		return -ENOMEM;
+	r->shm = shm;
+	r->global_id = global_id;
+
+	mutex_lock(&optee->riscv.mutex);
+	rc = rhashtable_lookup_insert_fast(&optee->riscv.global_ids,
+					   &r->linkage, shm_rhash_params);
+	mutex_unlock(&optee->riscv.mutex);
+
+	if (rc)
+		kfree(r);
+
+	return rc;
+}
+
+static int optee_shm_rem_riscv_handle(struct optee *optee, u64 global_id)
+{
+	struct shm_rhash *r;
+	int rc = -ENOENT;
+
+	mutex_lock(&optee->riscv.mutex);
+	r = rhashtable_lookup_fast(&optee->riscv.global_ids, &global_id,
+				   shm_rhash_params);
+	if (r)
+		rc = rhashtable_remove_fast(&optee->riscv.global_ids,
+					    &r->linkage, shm_rhash_params);
+	mutex_unlock(&optee->riscv.mutex);
+
+	if (!rc)
+		kfree(r);
+
+	return rc;
+}
+
+/*
+ * 2. Convert between struct tee_param and struct optee_msg_param
+ *
+ * optee_riscv_from_msg_param() and optee_riscv_to_msg_param() are the main
+ * functions. They are identical to their FF-A counterparts: the memref
+ * carries only the parcel handle (stored in fmem.global_id, the same slot
+ * FF-A uses for its g_handle), an offset and a size, never a page list.
+ */
+
+static void from_msg_param_riscv_mem(struct optee *optee, struct tee_param *p,
+				     u32 attr, const struct optee_msg_param *mp)
+{
+	struct tee_shm *shm = NULL;
+	u64 offs_high = 0;
+	u64 offs_low = 0;
+
+	p->attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT +
+		  attr - OPTEE_MSG_ATTR_TYPE_FMEM_INPUT;
+	p->u.memref.size = mp->u.fmem.size;
+
+	if (mp->u.fmem.global_id != OPTEE_MSG_FMEM_INVALID_GLOBAL_ID)
+		shm = optee_shm_from_riscv_handle(optee, mp->u.fmem.global_id);
+	p->u.memref.shm = shm;
+
+	if (shm) {
+		offs_low = mp->u.fmem.offs_low;
+		offs_high = mp->u.fmem.offs_high;
+	}
+	p->u.memref.shm_offs = offs_low | offs_high << 32;
+}
+
+/**
+ * optee_riscv_from_msg_param() - convert from OPTEE_MSG parameters to
+ *				  struct tee_param
+ * @optee:	main service struct
+ * @params:	subsystem internal parameter representation
+ * @num_params:	number of elements in the parameter arrays
+ * @msg_params:	OPTEE_MSG parameters
+ *
+ * Returns 0 on success or <0 on failure
+ */
+static int optee_riscv_from_msg_param(struct optee *optee,
+				      struct tee_param *params,
+				      size_t num_params,
+				      const struct optee_msg_param *msg_params)
+{
+	size_t n;
+
+	for (n = 0; n < num_params; n++) {
+		struct tee_param *p = params + n;
+		const struct optee_msg_param *mp = msg_params + n;
+		u32 attr = mp->attr & OPTEE_MSG_ATTR_TYPE_MASK;
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
+		case OPTEE_MSG_ATTR_TYPE_FMEM_INPUT:
+		case OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT:
+		case OPTEE_MSG_ATTR_TYPE_FMEM_INOUT:
+			from_msg_param_riscv_mem(optee, p, attr, mp);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int to_msg_param_riscv_mem(struct optee_msg_param *mp,
+				  const struct tee_param *p)
+{
+	struct tee_shm *shm = p->u.memref.shm;
+
+	mp->attr = OPTEE_MSG_ATTR_TYPE_FMEM_INPUT + p->attr -
+		   TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
+
+	if (shm) {
+		u64 shm_offs = p->u.memref.shm_offs;
+
+		mp->u.fmem.internal_offs = shm->offset;
+
+		mp->u.fmem.offs_low = shm_offs;
+		mp->u.fmem.offs_high = shm_offs >> 32;
+		/* Check that the entire offset could be stored. */
+		if (mp->u.fmem.offs_high != shm_offs >> 32)
+			return -EINVAL;
+
+		mp->u.fmem.global_id = shm->sec_world_id;
+	} else {
+		memset(&mp->u, 0, sizeof(mp->u));
+		mp->u.fmem.global_id = OPTEE_MSG_FMEM_INVALID_GLOBAL_ID;
+	}
+	mp->u.fmem.size = p->u.memref.size;
+
+	return 0;
+}
+
+/**
+ * optee_riscv_to_msg_param() - convert from struct tee_params to OPTEE_MSG
+ *				parameters
+ * @optee:	main service struct
+ * @msg_params:	OPTEE_MSG parameters
+ * @num_params:	number of elements in the parameter arrays
+ * @params:	subsystem internal parameter representation
+ *
+ * Returns 0 on success or <0 on failure
+ */
+static int optee_riscv_to_msg_param(struct optee *optee,
+				    struct optee_msg_param *msg_params,
+				    size_t num_params,
+				    const struct tee_param *params)
+{
+	size_t n;
+
+	for (n = 0; n < num_params; n++) {
+		const struct tee_param *p = params + n;
+		struct optee_msg_param *mp = msg_params + n;
+
+		switch (p->attr) {
+		case TEE_IOCTL_PARAM_ATTR_TYPE_NONE:
+			mp->attr = TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
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
+			if (to_msg_param_riscv_mem(mp, p))
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
+/*
+ * 3. Low level support functions to register shared memory in secure world
+ *
+ * Functions to register and unregister shared memory both for normal
+ * clients and for tee-supplicant. Registration creates an RPMI memory
+ * parcel (MEM_PARCEL_CREATE), which is the analog of FFA_MEM_SHARE;
+ * unregistration reclaims it (MEM_PARCEL_RECLAIM), the analog of
+ * FFA_MEM_RECLAIM, after a synchronous handshake with OP-TEE.
+ */
+
+/*
+ * Coalesce a page array into RPMI block-list entries (Table 198). Each entry
+ * spans a run of physically contiguous pages, up to RPMI_TEE_PARCEL_BLOCK_MAX_
+ * PAGES. When @block_high / @block_low are NULL only the entry count is
+ * computed, so the caller can size the request buffer first.
+ */
+static u32 optee_riscv_build_blocks(struct page **pages, size_t num_pages,
+				    __le32 *block_high, __le32 *block_low)
+{
+	u32 nblocks = 0;
+	size_t i = 0;
+
+	while (i < num_pages) {
+		u64 pfn = page_to_pfn(pages[i]);
+		u32 run = 1;
+
+		while (i + run < num_pages &&
+		       run < RPMI_TEE_PARCEL_BLOCK_MAX_PAGES &&
+		       page_to_pfn(pages[i + run]) == pfn + run)
+			run++;
+
+		if (block_high && block_low) {
+			block_high[nblocks] = rpmi_tee_block_high(pfn);
+			block_low[nblocks] = rpmi_tee_block_low(pfn, run);
+		}
+		nblocks++;
+		i += run;
+	}
+
+	return nblocks;
+}
+
+/*
+ * Issue MEM_PARCEL_CREATE (RPMI service 0x09) for @pages with the REE as the
+ * creator and OP-TEE as the sole read/write receiver. Returns the framework
+ * assigned parcel id (>= 0) or a negative errno.
+ */
+static int optee_riscv_parcel_create(struct optee *optee, struct page **pages,
+				     size_t num_pages, u32 nonce)
+{
+	struct rpmi_tee_mem_parcel_create_req *req;
+	struct rpmi_tee_mem_parcel_create_resp rx = { };
+	struct rpmi_mbox_message msg;
+	__le32 *block_high, *block_low;
+	size_t req_len;
+	u32 block_cnt;
+	__le32 *data;
 	int ret;
 
+	block_cnt = optee_riscv_build_blocks(pages, num_pages, NULL, NULL);
+
 	/*
-	 * Memory parcels carry normal-world shared memory to OP-TEE, so the
-	 * framework must support sharing memory between the REE and a TEE.
+	 * Layout of the trailing data[] array (Table 200): one receiver_id and
+	 * one access word (receiver_cnt == 1), then block_high[block_cnt] and
+	 * block_low[block_cnt].
 	 */
-	ret = optee_riscv_probe_feature(optee, RPMI_TEE_FEAT_MEMORY_SHARE,
-					&share);
-	if (ret) {
-		pr_err("Failed to probe MEMORY_SHARE feature: %d\n", ret);
+	req_len = struct_size(req, data, 2 + 2 * block_cnt);
+	if (optee->riscv.max_msg_data_size &&
+	    req_len > optee->riscv.max_msg_data_size)
+		return -E2BIG;
+
+	req = kzalloc(req_len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->creator_id = cpu_to_le32(RPMI_TEE_ENDPOINT_REE);
+	req->creator_access = cpu_to_le32(RPMI_TEE_PARCEL_ACCESS_R |
+					  RPMI_TEE_PARCEL_ACCESS_W);
+	req->receiver_cnt = cpu_to_le32(1);
+	req->flags = 0;
+	req->nonce = cpu_to_le32(nonce);
+	req->block_cnt = cpu_to_le32(block_cnt);
+
+	data = req->data;
+	data[0] = cpu_to_le32(RPMI_TEE_ENDPOINT_OPTEE);
+	data[1] = cpu_to_le32(RPMI_TEE_PARCEL_ACCESS_R |
+			      RPMI_TEE_PARCEL_ACCESS_W);
+	block_high = &data[2];
+	block_low = &data[2 + block_cnt];
+	optee_riscv_build_blocks(pages, num_pages, block_high, block_low);
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_MEM_PARCEL_CREATE,
+					  req, req_len, &rx, sizeof(rx));
+	ret = optee_riscv_send(optee, &msg);
+	kfree(req);
+	if (ret)
 		return ret;
-	}
-	if (share != RPMI_TEE_MEMORY_SHARE_FULL) {
-		pr_err("Framework cannot share memory between REE and TEE (%u)\n",
-		       share);
-		return -EOPNOTSUPP;
-	}
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
 
-	return 0;
+	return le32_to_cpu(rx.mem_parcel_id);
 }
 
-static int optee_riscv_enable_notif(struct optee *optee)
+/*
+ * Issue MEM_PARCEL_RECLAIM (RPMI service 0x0c). OpenSBI fails the reclaim
+ * while any receiver still holds the parcel, so this is only called after the
+ * OPTEE_ABI_UNREGISTER_SHM handshake below has confirmed OP-TEE released it.
+ */
+static int optee_riscv_parcel_reclaim(struct optee *optee, u32 parcel_id)
 {
-	struct rpmi_tee_probe_features_resp rx = { };
+	struct rpmi_tee_mem_parcel_reclaim_req tx = {
+		.mem_parcel_id = cpu_to_le32(parcel_id),
+	};
+	struct rpmi_tee_mem_parcel_reclaim_resp rx = { };
 	struct rpmi_mbox_message msg;
 	int ret;
 
-	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_ENABLE_NOTIFICATION,
-					  NULL, 0, &rx, sizeof(rx));
+	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_MEM_PARCEL_RECLAIM,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
 	ret = optee_riscv_send(optee, &msg);
 	if (ret)
 		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	return 0;
+}
+
+static int optee_riscv_shm_register(struct tee_context *ctx,
+				    struct tee_shm *shm, struct page **pages,
+				    size_t num_pages, unsigned long start)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	u64 global_id;
+	u32 nonce;
+	int rc;
+
+	rc = optee_check_mem_type(start, num_pages);
+	if (rc)
+		return rc;
 
 	/*
-	 * The TEE service group defines no notification events on this
-	 * platform, so RPMI_ERR_NOTSUPP is expected and not fatal.
+	 * MEM_PARCEL_CREATE returns only a parcel id; the nonce is
+	 * caller-supplied. Fold them into the FF-A style 64-bit handle:
+	 * parcel id in the low word, nonce in the high word.
 	 */
-	if (rx.status && le32_to_cpu(rx.status) != (u32)RPMI_ERR_NOTSUPP)
-		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+	nonce = (u32)atomic_inc_return(&optee->riscv.next_nonce);
+	rc = optee_riscv_parcel_create(optee, pages, num_pages, nonce);
+	if (rc < 0)
+		return rc;
+	global_id = (u32)rc | ((u64)nonce << 32);
+
+	rc = optee_shm_add_riscv_handle(optee, shm, global_id);
+	if (rc) {
+		optee_riscv_parcel_reclaim(optee, (u32)global_id);
+		return rc;
+	}
+
+	shm->sec_world_id = global_id;
 
 	return 0;
 }
 
+static int optee_riscv_shm_unregister(struct tee_context *ctx,
+				      struct tee_shm *shm)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	u64 global_id = shm->sec_world_id;
+	u64 in[RPMI_TEE_OPTEE_CALL_REGS] = {
+		OPTEE_ABI_UNREGISTER_SHM,
+		(u32)global_id,
+		global_id >> 32,
+		0,
+	};
+	u64 out[RPMI_TEE_OPTEE_RESP_REGS] = { };
+	int rc;
+
+	optee_shm_rem_riscv_handle(optee, global_id);
+	shm->sec_world_id = 0;
+
+	/*
+	 * Synchronous teardown handshake, the analog of the FF-A
+	 * OPTEE_FFA_UNREGISTER_SHM blocking call: OP-TEE releases the parcel on
+	 * its own TEE channel before we reclaim it. Only reclaim once OP-TEE
+	 * has acknowledged, so we never race the release.
+	 */
+	rc = optee_riscv_tee_call(optee, in, out);
+	if (rc)
+		pr_err("Unregister SHM id 0x%llx rc %d\n", global_id, rc);
+
+	rc = optee_riscv_parcel_reclaim(optee, (u32)global_id);
+	if (rc)
+		pr_err("parcel_reclaim: 0x%llx %d\n", global_id, rc);
+
+	return rc;
+}
+
+static int optee_riscv_shm_unregister_supp(struct tee_context *ctx,
+					   struct tee_shm *shm)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	u64 global_id = shm->sec_world_id;
+	int rc;
+
+	/*
+	 * We're skipping the OPTEE_ABI_UNREGISTER_SHM handshake since this is
+	 * OP-TEE freeing via RPC, so it has already retired this parcel.
+	 */
+	optee_shm_rem_riscv_handle(optee, global_id);
+	shm->sec_world_id = 0;
+
+	rc = optee_riscv_parcel_reclaim(optee, (u32)global_id);
+	if (rc)
+		pr_err("parcel_reclaim: 0x%llx %d\n", global_id, rc);
+
+	return rc;
+}
+
+/*
+ * 4. Dynamic shared memory pool based on alloc_pages()
+ *
+ * Implements an OP-TEE specific shared memory pool.
+ * The main function is optee_riscv_shm_pool_alloc_pages().
+ */
+
+static int pool_riscv_op_alloc(struct tee_shm_pool *pool,
+			       struct tee_shm *shm, size_t size, size_t align)
+{
+	return tee_dyn_shm_alloc_helper(shm, size, align,
+					optee_riscv_shm_register);
+}
+
+static void pool_riscv_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
+{
+	tee_dyn_shm_free_helper(shm, optee_riscv_shm_unregister);
+}
+
+static void pool_riscv_op_destroy_pool(struct tee_shm_pool *pool)
+{
+	kfree(pool);
+}
+
+static const struct tee_shm_pool_ops pool_riscv_ops = {
+	.alloc = pool_riscv_op_alloc,
+	.free = pool_riscv_op_free,
+	.destroy_pool = pool_riscv_op_destroy_pool,
+};
+
+/**
+ * optee_riscv_shm_pool_alloc_pages() - create page-based allocator pool
+ *
+ * This pool is used with OP-TEE over the RPMI TEE service group. In this case
+ * command buffers and such are allocated from kernel's own memory.
+ */
+static struct tee_shm_pool *optee_riscv_shm_pool_alloc_pages(void)
+{
+	struct tee_shm_pool *pool = kzalloc_obj(*pool);
+
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->ops = &pool_riscv_ops;
+
+	return pool;
+}
+
 /*
- * 3. Driver initialization
+ * 5. Do a normal scheduled call into secure world
  *
+ * The function optee_riscv_do_call_with_arg() performs a normal scheduled
+ * call into secure world. During this call secure world may request help
+ * from normal world using RPCs, Remote Procedure Calls. This includes
+ * delivery of non-secure interrupts to for instance allow rescheduling of
+ * the current task.
+ */
+
+static void handle_riscv_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
+						struct optee *optee,
+						struct optee_msg_arg *arg)
+{
+	struct tee_shm *shm;
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT) {
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	switch (arg->params[0].u.value.a) {
+	case OPTEE_RPC_SHM_TYPE_APPL:
+		shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
+		break;
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
+		shm = tee_shm_alloc_priv_buf(optee->ctx,
+					     arg->params[0].u.value.b);
+		break;
+	default:
+		arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+		return;
+	}
+
+	if (IS_ERR(shm)) {
+		arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
+		return;
+	}
+
+	arg->params[0] = (struct optee_msg_param){
+		.attr = OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT,
+		.u.fmem.size = tee_shm_get_size(shm),
+		.u.fmem.global_id = shm->sec_world_id,
+		.u.fmem.internal_offs = shm->offset,
+	};
+
+	arg->ret = TEEC_SUCCESS;
+}
+
+static void handle_riscv_rpc_func_cmd_shm_free(struct tee_context *ctx,
+					       struct optee *optee,
+					       struct optee_msg_arg *arg)
+{
+	struct tee_shm *shm;
+
+	if (arg->num_params != 1 ||
+	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_INPUT)
+		goto err_bad_param;
+
+	shm = optee_shm_from_riscv_handle(optee, arg->params[0].u.value.b);
+	if (!shm)
+		goto err_bad_param;
+	switch (arg->params[0].u.value.a) {
+	case OPTEE_RPC_SHM_TYPE_APPL:
+		optee_rpc_cmd_free_suppl(ctx, shm);
+		break;
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
+		tee_shm_free(shm);
+		break;
+	default:
+		goto err_bad_param;
+	}
+	arg->ret = TEEC_SUCCESS;
+	return;
+
+err_bad_param:
+	arg->ret = TEEC_ERROR_BAD_PARAMETERS;
+}
+
+static void handle_riscv_rpc_func_cmd(struct tee_context *ctx,
+				      struct optee *optee,
+				      struct optee_msg_arg *arg)
+{
+	arg->ret_origin = TEEC_ORIGIN_COMMS;
+	switch (arg->cmd) {
+	case OPTEE_RPC_CMD_SHM_ALLOC:
+		handle_riscv_rpc_func_cmd_shm_alloc(ctx, optee, arg);
+		break;
+	case OPTEE_RPC_CMD_SHM_FREE:
+		handle_riscv_rpc_func_cmd_shm_free(ctx, optee, arg);
+		break;
+	default:
+		optee_rpc_cmd(ctx, optee, arg);
+	}
+}
+
+static void optee_handle_riscv_rpc(struct tee_context *ctx,
+				   struct optee *optee, u32 cmd,
+				   struct optee_msg_arg *arg)
+{
+	switch (cmd) {
+	case OPTEE_ABI_YIELDING_CALL_RETURN_RPC_CMD:
+		handle_riscv_rpc_func_cmd(ctx, optee, arg);
+		break;
+	case OPTEE_ABI_YIELDING_CALL_RETURN_INTERRUPT:
+		/* Interrupt delivered by now */
+		break;
+	default:
+		pr_warn("Unknown RPC func 0x%x\n", cmd);
+		break;
+	}
+}
+
+static int optee_riscv_yielding_call(struct tee_context *ctx,
+				     u64 in[RPMI_TEE_OPTEE_CALL_REGS],
+				     struct optee_msg_arg *rpc_arg,
+				     bool system_thread)
+{
+	struct optee *optee = tee_get_drvdata(ctx->teedev);
+	struct optee_call_waiter w;
+	u64 out[RPMI_TEE_OPTEE_RESP_REGS] = { };
+	int rc;
+
+	/* Initialize waiter */
+	optee_cq_wait_init(&optee->call_queue, &w, system_thread);
+	while (true) {
+		rc = optee_riscv_tee_call(optee, in, out);
+		if (rc)
+			goto done;
+
+		switch ((int)out[0]) {
+		case TEEC_SUCCESS:
+			break;
+		case TEEC_ERROR_BUSY:
+			if (in[0] == OPTEE_ABI_YIELDING_CALL_RESUME) {
+				rc = -EIO;
+				goto done;
+			}
+
+			/*
+			 * Out of threads in secure world, wait for a thread
+			 * to become available.
+			 */
+			optee_cq_wait_for_completion(&optee->call_queue, &w);
+			continue;
+		default:
+			rc = -EIO;
+			goto done;
+		}
+
+		if (out[1] == OPTEE_ABI_YIELDING_CALL_RETURN_DONE)
+			goto done;
+
+		/*
+		 * OP-TEE has returned with an RPC request.
+		 *
+		 * Note that out[4] (returned in reg[4]) is already filled in
+		 * by optee_riscv_tee_call() returning above.
+		 */
+		cond_resched();
+		optee_handle_riscv_rpc(ctx, optee, out[1], rpc_arg);
+		in[0] = OPTEE_ABI_YIELDING_CALL_RESUME;
+		in[1] = 0;
+		in[2] = 0;
+		in[3] = 0;
+		in[4] = out[4];		/* resume info */
+	}
+done:
+	/*
+	 * We're done with our thread in secure world, if there are any
+	 * thread waiters wake up one.
+	 */
+	optee_cq_wait_final(&optee->call_queue, &w);
+
+	return rc;
+}
+
+/**
+ * optee_riscv_do_call_with_arg() - enter OP-TEE in secure world
+ * @ctx:	calling context
+ * @shm:	shared memory holding the message to pass to secure world
+ * @offs:	offset of the message in @shm
+ * @system_thread: true if caller requests TEE system thread support
+ *
+ * Does a TEE_CALL to OP-TEE in secure world and handles the resulting
+ * Remote Procedure Calls (RPC) from OP-TEE. The struct optee_msg_arg is
+ * passed by its parcel handle plus @offs, exactly as FF-A passes it by
+ * shared memory handle.
+ *
+ * Returns return code from OP-TEE, 0 is OK
+ */
+static int optee_riscv_do_call_with_arg(struct tee_context *ctx,
+					struct tee_shm *shm, u_int offs,
+					bool system_thread)
+{
+	u64 in[RPMI_TEE_OPTEE_CALL_REGS] = {
+		OPTEE_ABI_YIELDING_CALL_WITH_ARG,
+		(u32)shm->sec_world_id,
+		shm->sec_world_id >> 32,
+		offs,
+	};
+	struct optee_msg_arg *arg;
+	unsigned int rpc_arg_offs;
+	struct optee_msg_arg *rpc_arg;
+
+	/*
+	 * The shared memory object has to start on a page when passed as
+	 * an argument struct. This is also what the shm pool allocator
+	 * returns, but check this before calling secure world to catch
+	 * eventual errors early in case something changes.
+	 */
+	if (shm->offset)
+		return -EINVAL;
+
+	arg = tee_shm_get_va(shm, offs);
+	if (IS_ERR(arg))
+		return PTR_ERR(arg);
+
+	rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
+	rpc_arg = tee_shm_get_va(shm, offs + rpc_arg_offs);
+	if (IS_ERR(rpc_arg))
+		return PTR_ERR(rpc_arg);
+
+	return optee_riscv_yielding_call(ctx, in, rpc_arg, system_thread);
+}
+
+/*
+ * 6. Driver initialization
+ *
+ * During driver initialization the OP-TEE Trusted OS is probed over TEE_CALL
+ * to find out which features it supports so the driver can be initialized
+ * with a matching configuration. These blocking calls mirror the FF-A
+ * OPTEE_FFA_GET_API_VERSION / GET_OS_VERSION / EXCHANGE_CAPABILITIES probes.
+ */
+
+static bool optee_riscv_api_is_compatible(struct optee *optee)
+{
+	u64 in[RPMI_TEE_OPTEE_CALL_REGS] = { OPTEE_ABI_GET_API_VERSION };
+	u64 out[RPMI_TEE_OPTEE_RESP_REGS] = { };
+	int rc;
+
+	rc = optee_riscv_tee_call(optee, in, out);
+	if (rc) {
+		pr_err("Unexpected error %d\n", rc);
+		return false;
+	}
+	if (out[0] != OPTEE_ABI_VERSION_MAJOR ||
+	    out[1] < OPTEE_ABI_VERSION_MINOR) {
+		pr_err("Incompatible OP-TEE API version %llu.%llu\n",
+		       out[0], out[1]);
+		return false;
+	}
+
+	return true;
+}
+
+static bool optee_riscv_get_os_revision(struct optee *optee)
+{
+	u64 in[RPMI_TEE_OPTEE_CALL_REGS] = { OPTEE_ABI_GET_OS_VERSION };
+	u64 out[RPMI_TEE_OPTEE_RESP_REGS] = { };
+	int rc;
+
+	rc = optee_riscv_tee_call(optee, in, out);
+	if (rc) {
+		pr_err("Unexpected error %d\n", rc);
+		return false;
+	}
+
+	optee->revision.os_major = out[0];
+	optee->revision.os_minor = out[1];
+	optee->revision.os_build_id = out[2];
+
+	if (out[2])
+		pr_info("revision %llu.%llu (%08llx)\n", out[0], out[1],
+			out[2]);
+	else
+		pr_info("revision %llu.%llu\n", out[0], out[1]);
+
+	return true;
+}
+
+static bool optee_riscv_exchange_caps(struct optee *optee, u32 *sec_caps,
+				      unsigned int *rpc_param_count,
+				      unsigned int *max_notif_value)
+{
+	u64 in[RPMI_TEE_OPTEE_CALL_REGS] = { OPTEE_ABI_EXCHANGE_CAPABILITIES };
+	u64 out[RPMI_TEE_OPTEE_RESP_REGS] = { };
+	int rc;
+
+	rc = optee_riscv_tee_call(optee, in, out);
+	if (rc) {
+		pr_err("Unexpected error %d\n", rc);
+		return false;
+	}
+	if (out[0]) {
+		pr_err("Unexpected exchange error %llu\n", out[0]);
+		return false;
+	}
+
+	*rpc_param_count = (u8)out[1];
+	*sec_caps = out[2];
+	if (out[3])
+		*max_notif_value = out[3];
+	else
+		*max_notif_value = OPTEE_DEFAULT_MAX_NOTIF_VALUE;
+
+	return true;
+}
+
+static void optee_riscv_get_version(struct tee_device *teedev,
+				    struct tee_ioctl_version_data *vers)
+{
+	struct tee_ioctl_version_data v = {
+		.impl_id = TEE_IMPL_ID_OPTEE,
+		.impl_caps = TEE_OPTEE_CAP_TZ,
+		.gen_caps = TEE_GEN_CAP_GP | TEE_GEN_CAP_REG_MEM |
+			    TEE_GEN_CAP_MEMREF_NULL,
+	};
+
+	*vers = v;
+}
+
+static int optee_riscv_open(struct tee_context *ctx)
+{
+	return optee_open(ctx, true);
+}
+
+static const struct tee_driver_ops optee_riscv_clnt_ops = {
+	.get_version = optee_riscv_get_version,
+	.get_tee_revision = optee_get_revision,
+	.open = optee_riscv_open,
+	.release = optee_release,
+	.open_session = optee_open_session,
+	.close_session = optee_close_session,
+	.invoke_func = optee_invoke_func,
+	.cancel_req = optee_cancel_req,
+	.shm_register = optee_riscv_shm_register,
+	.shm_unregister = optee_riscv_shm_unregister,
+};
+
+static const struct tee_desc optee_riscv_clnt_desc = {
+	.name = DRIVER_NAME "-riscv-clnt",
+	.ops = &optee_riscv_clnt_ops,
+	.owner = THIS_MODULE,
+};
+
+static const struct tee_driver_ops optee_riscv_supp_ops = {
+	.get_version = optee_riscv_get_version,
+	.get_tee_revision = optee_get_revision,
+	.open = optee_riscv_open,
+	.release = optee_release_supp,
+	.supp_recv = optee_supp_recv,
+	.supp_send = optee_supp_send,
+	.shm_register = optee_riscv_shm_register, /* same as for clnt ops */
+	.shm_unregister = optee_riscv_shm_unregister_supp,
+};
+
+static const struct tee_desc optee_riscv_supp_desc = {
+	.name = DRIVER_NAME "-riscv-supp",
+	.ops = &optee_riscv_supp_ops,
+	.owner = THIS_MODULE,
+	.flags = TEE_DESC_PRIVILEGED,
+};
+
+static const struct optee_ops optee_riscv_ops = {
+	.do_call_with_arg = optee_riscv_do_call_with_arg,
+	.to_msg_param = optee_riscv_to_msg_param,
+	.from_msg_param = optee_riscv_from_msg_param,
+};
+
+/*
  * The RPMI TEE service group is described in the device tree by a single
  * node whose "mboxes" property lists one SBI MPXY channel per hart, in hart
  * order. The driver requests each list entry by index and validates the
@@ -186,15 +1042,117 @@ static void optee_riscv_free_channels(struct optee *optee)
 	}
 }
 
+/* Confirm the TEE service group and read its transport attributes. */
+static int optee_riscv_check_transport(struct optee *optee)
+{
+	struct device *dev = optee->riscv.dev;
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
+	ret = optee_riscv_send(optee, &msg);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get service group id\n");
+	if (msg.attr.value != RPMI_SRVGRP_TEE)
+		return dev_err_probe(dev, -ENODEV,
+				     "Not a TEE service group channel (0x%x)\n",
+				     msg.attr.value);
+
+	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE);
+	ret = optee_riscv_send(optee, &msg);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get max msg data size\n");
+	optee->riscv.max_msg_data_size = msg.attr.value;
+
+	return 0;
+}
+
+/*
+ * TEE_PROBE_FEATURES (0x02) reports which framework features are available;
+ * memory parcels carry normal-world shared memory to OP-TEE, so the framework
+ * must support sharing memory between the REE and a TEE.
+ */
+static int optee_riscv_probe_feature(struct optee *optee, u32 feature_id,
+				     u32 *value)
+{
+	struct rpmi_tee_probe_features_req tx = {
+		.feature_id = cpu_to_le32(feature_id),
+	};
+	struct rpmi_tee_probe_features_resp rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_PROBE_FEATURES,
+					  &tx, sizeof(tx), &rx, sizeof(rx));
+	ret = optee_riscv_send(optee, &msg);
+	if (ret)
+		return ret;
+	if (rx.status)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	if (value)
+		*value = le32_to_cpu(rx.value);
+
+	return 0;
+}
+
+static int optee_riscv_features(struct optee *optee)
+{
+	u32 share = RPMI_TEE_MEMORY_SHARE_NONE;
+	int ret;
+
+	ret = optee_riscv_probe_feature(optee, RPMI_TEE_FEAT_MEMORY_SHARE,
+					&share);
+	if (ret) {
+		pr_err("Failed to probe MEMORY_SHARE feature: %d\n", ret);
+		return ret;
+	}
+	if (share != RPMI_TEE_MEMORY_SHARE_FULL) {
+		pr_err("Framework cannot share memory between REE and TEE (%u)\n",
+		       share);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int optee_riscv_enable_notif(struct optee *optee)
+{
+	struct rpmi_tee_probe_features_resp rx = { };
+	struct rpmi_mbox_message msg;
+	int ret;
+
+	rpmi_mbox_init_send_with_response(&msg, RPMI_TEE_SRV_ENABLE_NOTIFICATION,
+					  NULL, 0, &rx, sizeof(rx));
+	ret = optee_riscv_send(optee, &msg);
+	if (ret)
+		return ret;
+
+	/*
+	 * The TEE service group defines no notification events on this
+	 * platform, so RPMI_ERR_NOTSUPP is expected and not fatal.
+	 */
+	if (rx.status && le32_to_cpu(rx.status) != (u32)RPMI_ERR_NOTSUPP)
+		return rpmi_to_linux_error(le32_to_cpu(rx.status));
+
+	return 0;
+}
+
 static int optee_riscv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct rpmi_mbox_message msg;
+	unsigned int rpc_param_count;
+	unsigned int max_notif_value;
+	struct tee_shm_pool *pool;
+	struct tee_device *teedev;
+	struct tee_context *ctx;
 	struct mbox_client *client;
 	struct optee *optee;
-	u32 servicegroup_id;
+	u32 sec_caps;
 	unsigned int nr_cpus;
-	int ret;
+	int rc;
 
 	nr_cpus = num_possible_cpus();
 	if (!nr_cpus)
@@ -206,7 +1164,7 @@ static int optee_riscv_probe(struct platform_device *pdev)
 
 	client = devm_kzalloc(dev, sizeof(*client), GFP_KERNEL);
 	if (!client) {
-		ret = -ENOMEM;
+		rc = -ENOMEM;
 		goto err_free_optee;
 	}
 	client->dev		= dev;
@@ -221,66 +1179,156 @@ static int optee_riscv_probe(struct platform_device *pdev)
 	optee->riscv.chan = kcalloc(nr_cpus, sizeof(*optee->riscv.chan),
 				    GFP_KERNEL);
 	if (!optee->riscv.chan) {
-		ret = -ENOMEM;
+		rc = -ENOMEM;
 		goto err_free_optee;
 	}
 
-	ret = optee_riscv_request_channels(optee);
-	if (ret)
+	rc = optee_riscv_request_channels(optee);
+	if (rc)
 		goto err_free_channels;
 
-	/* Confirm the channel really speaks the TEE service group. */
-	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_SERVICEGROUP_ID);
-	ret = optee_riscv_send(optee, &msg);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to get service group id\n");
+	rc = optee_riscv_check_transport(optee);
+	if (rc)
+		goto err_free_channels;
+
+	rc = optee_riscv_features(optee);
+	if (rc) {
+		dev_err_probe(dev, rc, "Missing required TEE features\n");
 		goto err_free_channels;
 	}
-	servicegroup_id = msg.attr.value;
-	if (servicegroup_id != RPMI_SRVGRP_TEE) {
-		ret = -ENODEV;
-		dev_err_probe(dev, ret, "Not a TEE service group channel (0x%x)\n",
-			      servicegroup_id);
+
+	rc = optee_riscv_enable_notif(optee);
+	if (rc) {
+		dev_err_probe(dev, rc, "Failed to enable notifications\n");
 		goto err_free_channels;
 	}
 
-	rpmi_mbox_init_get_attribute(&msg, RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE);
-	ret = optee_riscv_send(optee, &msg);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to get max msg data size\n");
+	if (!optee_riscv_api_is_compatible(optee)) {
+		rc = -EINVAL;
 		goto err_free_channels;
 	}
-	optee->riscv.max_msg_data_size = msg.attr.value;
 
-	ret = optee_riscv_features(optee);
-	if (ret) {
-		dev_err_probe(dev, ret, "Missing required TEE features\n");
+	if (!optee_riscv_get_os_revision(optee)) {
+		rc = -EINVAL;
 		goto err_free_channels;
 	}
 
-	ret = optee_riscv_enable_notif(optee);
-	if (ret) {
-		dev_err_probe(dev, ret, "Failed to enable notifications\n");
+	if (!optee_riscv_exchange_caps(optee, &sec_caps, &rpc_param_count,
+				       &max_notif_value)) {
+		rc = -EINVAL;
+		goto err_free_channels;
+	}
+
+	pool = optee_riscv_shm_pool_alloc_pages();
+	if (IS_ERR(pool)) {
+		rc = PTR_ERR(pool);
 		goto err_free_channels;
 	}
+	optee->pool = pool;
+
+	optee->ops = &optee_riscv_ops;
+	optee->rpc_param_count = rpc_param_count;
+
+	if (IS_REACHABLE(CONFIG_RPMB) &&
+	    (sec_caps & OPTEE_ABI_SEC_CAP_RPMB_PROBE))
+		optee->in_kernel_rpmb_routing = true;
+
+	teedev = tee_device_alloc(&optee_riscv_clnt_desc, NULL, optee->pool,
+				  optee);
+	if (IS_ERR(teedev)) {
+		rc = PTR_ERR(teedev);
+		goto err_free_shm_pool;
+	}
+	optee->teedev = teedev;
+
+	teedev = tee_device_alloc(&optee_riscv_supp_desc, NULL, optee->pool,
+				  optee);
+	if (IS_ERR(teedev)) {
+		rc = PTR_ERR(teedev);
+		goto err_unreg_teedev;
+	}
+	optee->supp_teedev = teedev;
 
+	optee_set_dev_group(optee);
+
+	rc = tee_device_register(optee->teedev);
+	if (rc)
+		goto err_unreg_supp_teedev;
+
+	rc = tee_device_register(optee->supp_teedev);
+	if (rc)
+		goto err_unreg_supp_teedev;
+
+	rc = rhashtable_init(&optee->riscv.global_ids, &shm_rhash_params);
+	if (rc)
+		goto err_unreg_supp_teedev;
+	mutex_init(&optee->riscv.mutex);
+	atomic_set(&optee->riscv.next_nonce, 0);
+	optee_cq_init(&optee->call_queue, 0);
+	optee_supp_init(&optee->supp);
+	optee_shm_arg_cache_init(optee, 0);
+	mutex_init(&optee->rpmb_dev_mutex);
 	platform_set_drvdata(pdev, optee);
+
+	ctx = teedev_open(optee->teedev);
+	if (IS_ERR(ctx)) {
+		rc = PTR_ERR(ctx);
+		goto err_rhashtable_free;
+	}
+	optee->ctx = ctx;
+
+	rc = optee_notif_init(optee, max_notif_value);
+	if (rc)
+		goto err_close_ctx;
+
+	rc = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
+	if (rc)
+		goto err_unregister_devices;
+
+	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
+	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
+	blocking_notifier_chain_register(&optee_rpmb_intf_added,
+					 &optee->rpmb_intf);
+
 	dev_info(dev, "initialized driver\n");
 
 	return 0;
 
+err_unregister_devices:
+	optee_unregister_devices();
+	optee_notif_uninit(optee);
+err_close_ctx:
+	teedev_close_context(ctx);
+err_rhashtable_free:
+	rhashtable_free_and_destroy(&optee->riscv.global_ids, rh_free_fn, NULL);
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
+	optee_supp_uninit(&optee->supp);
+	mutex_destroy(&optee->call_queue.mutex);
+	mutex_destroy(&optee->riscv.mutex);
+err_unreg_supp_teedev:
+	tee_device_unregister(optee->supp_teedev);
+err_unreg_teedev:
+	tee_device_unregister(optee->teedev);
+err_free_shm_pool:
+	tee_shm_pool_free(pool);
 err_free_channels:
 	optee_riscv_free_channels(optee);
 	kfree(optee->riscv.chan);
 err_free_optee:
 	kfree(optee);
-	return ret;
+	return rc;
 }
 
 static void optee_riscv_remove(struct platform_device *pdev)
 {
 	struct optee *optee = platform_get_drvdata(pdev);
 
+	optee_remove_common(optee);
+
+	mutex_destroy(&optee->riscv.mutex);
+	rhashtable_free_and_destroy(&optee->riscv.global_ids, rh_free_fn, NULL);
+
 	optee_riscv_free_channels(optee);
 	kfree(optee->riscv.chan);
 	kfree(optee);
diff --git a/drivers/tee/optee/optee_riscv.h b/drivers/tee/optee/optee_riscv.h
index d87298faa6a2..2cdbb1fb4eab 100644
--- a/drivers/tee/optee/optee_riscv.h
+++ b/drivers/tee/optee/optee_riscv.h
@@ -24,6 +24,7 @@
 #ifndef __OPTEE_RISCV_H
 #define __OPTEE_RISCV_H
 
+#include <linux/bits.h>
 #include <linux/mailbox/riscv-rpmi-message.h>
 #include <linux/types.h>
 
@@ -110,9 +111,13 @@ struct rpmi_tee_probe_features_resp {
 	{ 0x5b, 0xe1, 0xb1, 0xa0, 0x7e, 0x11, 0x4e, 0x7a,		\
 	  0x9b, 0x10, 0x00, 0x10, 0xc0, 0xff, 0xee, 0x00 }
 
-/* OP-TEE SMC-style call convention carried inside SERVICE_DATA. */
-#define RPMI_TEE_OPTEE_CALL_REGS	8	/* a0-a7 */
-#define RPMI_TEE_OPTEE_RESP_REGS	4	/* a0-a3 */
+/*
+ * OP-TEE FF-A direct message convention carried inside SERVICE_DATA:
+ * five command words each way, the RISC-V analog of the FF-A data0-data4
+ * (w3-w7) set of struct ffa_send_direct_data.
+ */
+#define RPMI_TEE_OPTEE_CALL_REGS	5
+#define RPMI_TEE_OPTEE_RESP_REGS	5
 
 #if __riscv_xlen == 64
 typedef __le64 rpmi_xlen_t;
@@ -138,4 +143,128 @@ struct rpmi_tee_call_resp {
 	rpmi_xlen_t reg[RPMI_TEE_OPTEE_RESP_REGS];
 } __packed;
 
+/*
+ * OP-TEE message ABI carried inside the TEE_CALL SERVICE_DATA words.
+ *
+ * This mirrors the FF-A message ABI in <optee_ffa.h>: OP-TEE and the REE are
+ * peer endpoints and the argument struct optee_msg_arg is passed by shared
+ * memory handle (a parcel id) plus an offset, never by a register block. The
+ * SERVICE_DATA registers carry a small command word set that is the RISC-V
+ * analog of the FF-A w3-w7 register usage:
+ *
+ *   reg[0]: command / service id  (OPTEE_ABI_YIELDING_CALL_* below)
+ *   reg[1]: shared memory handle, lower 32 bits (parcel id)
+ *   reg[2]: shared memory handle, upper 32 bits (parcel nonce)
+ *   reg[3]: offset into the shared memory to the struct optee_msg_arg
+ *   reg[4]: not used on this call, resume info on OPTEE_ABI_YIELDING_CALL_RESUME
+ *
+ * On return the SERVICE_RSP registers carry:
+ *   reg[0]: error code, 0 on success
+ *   reg[1]: return code (OPTEE_ABI_YIELDING_CALL_RETURN_* below)
+ *   reg[2..3]: not used
+ *   reg[4]: RPC resume info
+ *
+ * These MUST byte-match the secure world OP-TEE header.
+ */
+#define OPTEE_ABI_BLOCKING_CALL(id)	(id)
+#define OPTEE_ABI_YIELDING_CALL_BIT	31
+#define OPTEE_ABI_YIELDING_CALL(id)	((id) | BIT(OPTEE_ABI_YIELDING_CALL_BIT))
+
+/* Blocking (fast) calls, mirror of OPTEE_FFA_BLOCKING_CALL ids. */
+#define OPTEE_ABI_GET_API_VERSION	OPTEE_ABI_BLOCKING_CALL(0)
+#define OPTEE_ABI_GET_OS_VERSION	OPTEE_ABI_BLOCKING_CALL(1)
+#define OPTEE_ABI_EXCHANGE_CAPABILITIES	OPTEE_ABI_BLOCKING_CALL(2)
+#define OPTEE_ABI_UNREGISTER_SHM	OPTEE_ABI_BLOCKING_CALL(3)
+#define OPTEE_ABI_ENABLE_ASYNC_NOTIF	OPTEE_ABI_BLOCKING_CALL(5)
+
+/* OP-TEE ABI version, mirror of OPTEE_FFA_VERSION_*. */
+#define OPTEE_ABI_VERSION_MAJOR		1
+#define OPTEE_ABI_VERSION_MINOR		0
+
+/* Capabilities returned by EXCHANGE_CAPABILITIES (OPTEE_FFA_SEC_CAP_* analog). */
+#define OPTEE_ABI_SEC_CAP_ARG_OFFSET	BIT(0)
+#define OPTEE_ABI_SEC_CAP_ASYNC_NOTIF	BIT(1)
+#define OPTEE_ABI_SEC_CAP_RPMB_PROBE	BIT(2)
+
+#define OPTEE_ABI_MAX_ASYNC_NOTIF_VALUE	64
+
+/* Yielding calls, mirror of OPTEE_FFA_YIELDING_CALL_*. */
+#define OPTEE_ABI_YIELDING_CALL_WITH_ARG	OPTEE_ABI_YIELDING_CALL(0)
+#define OPTEE_ABI_YIELDING_CALL_RESUME		OPTEE_ABI_YIELDING_CALL(1)
+
+#define OPTEE_ABI_YIELDING_CALL_RETURN_DONE		0
+#define OPTEE_ABI_YIELDING_CALL_RETURN_RPC_CMD		1
+#define OPTEE_ABI_YIELDING_CALL_RETURN_INTERRUPT	2
+
+/*
+ * Memory parcel wire encodings (RPMI spec section 4.16, Tables 198-207).
+ *
+ * A memory parcel is the RISC-V analog of an FF-A memory-share handle: the REE
+ * creates a parcel describing its pages and OP-TEE accepts it lazily by parcel
+ * id. All fields are little-endian uint32 words; block-list addresses are
+ * expressed in units of 4kB pages.
+ */
+
+/* Memory access encoding (Table 199). */
+#define RPMI_TEE_PARCEL_ACCESS_R	BIT(29)
+#define RPMI_TEE_PARCEL_ACCESS_W	BIT(30)
+#define RPMI_TEE_PARCEL_ACCESS_X	BIT(31)
+
+/* MEM_PARCEL_CREATE flags (Table 200). */
+#define RPMI_TEE_PARCEL_CREATE_FLAG_MULTI_SEGMENT	BIT(31)
+#define RPMI_TEE_PARCEL_CREATE_FLAG_OWNER_XFER		BIT(30)
+
+/* Length of the parcel LABEL field (Table 200). */
+#define RPMI_TEE_PARCEL_LABEL_LEN	16
+
+/*
+ * A block list entry covers a run of physically contiguous 4kB pages
+ * (Table 198):
+ *   BLOCK_HIGH = page-frame number [51:20]
+ *   BLOCK_LOW  = (page-frame number [19:0] << 12) | (page count - 1)
+ * so a single block spans at most 4096 pages (16MB).
+ */
+#define RPMI_TEE_PARCEL_BLOCK_MAX_PAGES	4096
+
+static inline __le32 rpmi_tee_block_high(u64 pfn)
+{
+	return cpu_to_le32((u32)(pfn >> 20));
+}
+
+static inline __le32 rpmi_tee_block_low(u64 pfn, u32 npages)
+{
+	return cpu_to_le32(((u32)(pfn & 0xfffff) << 12) | (npages - 1));
+}
+
+/*
+ * MEM_PARCEL_CREATE request (Table 200): a fixed header followed by
+ * receiver_id[receiver_cnt], access[receiver_cnt], block_high[block_cnt] and
+ * block_low[block_cnt].
+ */
+struct rpmi_tee_mem_parcel_create_req {
+	__le32 creator_id;
+	__le32 creator_access;
+	__le32 receiver_cnt;
+	__le32 flags;
+	__le32 nonce;
+	__le32 block_cnt;
+	u8 label[RPMI_TEE_PARCEL_LABEL_LEN];
+	__le32 data[];
+};
+
+struct rpmi_tee_mem_parcel_create_resp {
+	__le32 status;
+	__le32 mem_parcel_id;
+};
+
+/* MEM_PARCEL_RECLAIM request (Table 206) / response (Table 207). */
+struct rpmi_tee_mem_parcel_reclaim_req {
+	__le32 mem_parcel_id;
+};
+
+struct rpmi_tee_mem_parcel_reclaim_resp {
+	__le32 status;
+	__le32 flags;
+};
+
 #endif /* __OPTEE_RISCV_H */

-- 
2.34.1

