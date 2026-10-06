Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5615ECA5FF0
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:43:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9419445418
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 00:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791247414;
	bh=4gI8pCC/QYw3pih3UzEY6Nk9/MefRoIuZOHyQI+sQUI=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=I4C9RUipfRTgtxY+R7NH6tZtbEGfVfWtMU7EPVLSifhPoiObeC//CtDuoTwme7m4m
	 p6sExFnAq9TTzOT5+DCpm+eL6wFc2Lcv8YIP0ScsAhmx4/QZ1igZGrPXljrUfGp9+M
	 XPXzREObFnPt45YI9hsQENYjuXcbIoNaLVk3KmtHRBM8zjXvVogehGyT7Pt2HC4ZUA
	 Jmbm48NkhpsmcjrQa0Ub9BuW3YzBkOJo/1+B53z2O4njwWeGtRO3TvFAZKeQFTalTC
	 FHGBw7CpajVFol3TotlH5l/4LN0yYrKGqK+BtQdsVsDho9sYO7+LopkDhPfaGvMZSS
	 3iIEsnZoCjeUg==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4847D45503
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 00:40:04 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jJaM0I6i;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CdgPxD2s;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695KN7EV3300945
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 00:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nYO611i2VDr+kpZXQlZA+U1VxdGQ4Y6EM0WXQx58/xQ=; b=jJaM0I6iy22zHwru
	6dYhQZ4xQaUGH9A5Zw+jbKcGw3GdCCA22DWXJWlidc8mh2F+Zpp4fME09bmGAgxI
	S82e8ui9EwCteReQVTzS0CQgfR6Xn1f7mt7jFPK368CGeARTOB0BU4D4oUuOWa6C
	9HY889csfukN3NhiZEsJ41A5Vmm4OtsQoXD8c2KQneRmbc1jMfxNg0FFxxCxGjoH
	Wn32rm0ExKlF38eP6n8tNvsevP2w8K+DJxtGRHkvuaWvYod+iAXV6j1D0x2Ka/AF
	3YPue0XCxmsjtoUbNn7vJKLeaQAqC6cW8yi45rHTEaaVsuORm+TR0RJ8WmVoquGb
	GQawZA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4bhg2rbg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 00:40:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3512ff5e032so1431778eec.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Oct 2026 17:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791247203; x=1791852003; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYO611i2VDr+kpZXQlZA+U1VxdGQ4Y6EM0WXQx58/xQ=;
        b=CdgPxD2sjUhbC7R20/TjQEE21POwUFuVd5Em3Vx3ZgWwyujNtxtNK41IAjbTjkSRfv
         cqwh0n4tsFRBZStBkH9I0+j8hTNPwsNeaztNSeFjSw/zkCSkthFoho3n6Kbd7i8f5LRT
         6jwfaDvl3UKbk3MvxipsKL9V2lxkKmm6Lhx8kIRMRdhFpiWa4gol9aQSaMbYKVwepjrk
         uiCIGfiXQNFr/gepgTp6CPWHUgTClJCuyphWiGrm1KHnf18vdOnufgmCWkwbFDO1t2yR
         DaZEdQkS6f9KhA11UFt5Y/M4wRfVY19/Jr819OQpf1T4EC1N/1Luelzrl6cbG/CQ0/Ts
         xLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791247203; x=1791852003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYO611i2VDr+kpZXQlZA+U1VxdGQ4Y6EM0WXQx58/xQ=;
        b=24uHsGV1ryOSaXwJnaIsUAmbCjbfq59t85tox2tYSEP6IHb7zX2/22bXb3Bp/vgBkR
         mWc7HsiFgZgBdRNzVgBEdybE9dgjdsvc5loHT2YVibKcPXJZwPGqMmRvv5EcE23PasVI
         I25feJmc1Srsps04TUyiWNZZ6QTRFMVHrqnjarGLRW97FXN2qJOHqaaGjVG0iATXLabO
         m36ZFvWcZqGPCo+5cBUwOSUmOIHD8SG0ZgQQ7zDDkpySoHIGCbl0M/uIuBwgR8QFMC4M
         bK+rD3kj1rnktKap8PYQM6/PkJshbgwphUVTRZxOpCCEERukA47EIaJcijnH0kDEyGS6
         I3WA==
X-Forwarded-Encrypted: i=1; AKwUvBxlWMHvqq9Vt71ZAfBVlyW0NT4s9nY0jMYFcSV74yemt536KfLo9zLS9HSconygpucZV5kVvJg=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++komOhqaECJyFuDGBEjlL73K5B/Bm4R2k7nNRrj9eSkRWZQq8ZK
	kIPyX1pkQeGCOTamKxjXJxu77fvPH7tJdXkg9HynxZLKx+AEFpjXwA4ll9wRucQkvFVjt4pY6zt
	9hH49ewGczQnMb9fUnnofmbtpE+BoSAQPlz2foxuhSyGnrWzwq0L1E+g7nMFH37IEfP2WvOw=
X-Gm-Gg: AYBFou2Y4adUlXqGL3bxz6JgEOZTT5f51GdCINIOAxif/Ne86ZJoV4flJTaJgMOg51b
	BWSTyIOT9tlwAL4eislEB+h1ILPvKcjKAu0woMwChChHSzyAmzQYOyd/gXaREYJLJW/F3C0OmmW
	U3PBHzRLVhCLaBfZkem7P2+NK6GdeLekWf5OflGmqzM7c+l76z1uRzXdKI+zyz33IzSuBpxhUbT
	cIQoFTM/tFn1iVmSgyR0qWdVEboGS3MViWLm5ogwyLuXuBSqFqeJtN+6RRW+hJn3YCtKk732A2R
	52Tl8cKTSN00mfW3Oq9c/lCnC9ecgrCYw2JwqgOFQPkEBUSmulyagTWbz1bhZ4qKhqhKXMnNgcH
	tk9t6CdAOqDPBH06A33/yVmZYtW34T+y7jVXOHctJ4G72xxn5ts9mPJI0Hw==
X-Received: by 2002:a05:7022:505:b0:145:5c7:7185 with SMTP id a92af1059eb24-15d2e03f9c0mr2108988c88.5.1791247202280;
        Mon, 05 Oct 2026 17:40:02 -0700 (PDT)
X-Received: by 2002:a05:7022:505:b0:145:5c7:7185 with SMTP id a92af1059eb24-15d2e03f9c0mr2108917c88.5.1791247201401;
        Mon, 05 Oct 2026 17:40:01 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35146ac078fsm2108874eec.22.2026.10.05.17.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 17:40:00 -0700 (PDT)
Date: Mon, 05 Oct 2026 17:39:51 -0700
Subject: [PATCH RFC v2 7/8] tee: optee: bind RPMI services and negotiate
 backend capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-rpmi-tee-service-grp-dev-v2-7-72f222e23ec1@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: DiBCgsWKrKs0ZYw9SaVtPz70kJvtJ2eW
X-Authority-Analysis: v=2.4 cv=GMGdgeNK c=1 sm=1 tr=0 ts=6ac44363 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=G3s93uPkn6CA8LbIO-UA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX01L+yLEp0+Qp
 7juJPGD5uOFMbS0lrnJugm7T64oedS5yvCMo6LyKcDeKMCkiKCFVLueoapnU+SwC2zpd+aolTJj
 mvjbzvkXK4tQjnNEEMpkI4ESAM/N1aU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDAwMSBTYWx0ZWRfX1iG9Z4itrD2w
 egWm+zAaKZCbDpwOGBn+qEuZhuDhuEKe8MXvsbWZ4vUIvhhk3I0tb/4UMrtdCcLIel7vxKSzSfx
 GQ9SUAmUoLgMc+FT92ib6DHauag9RteCDjxTU3l30tdoCttPmgDKpfDFNdkGCM3gvH85fSZoOtH
 Lt8Z7Vg7m5++AXPiXIALsJ5C6BSg0ECWTSqrulgIL5AlNR10hEyIp/A2Na26Xm0btO8wWzPhsS9
 btbMnEq2trwmnFGhsYWjHhMIGf9nSa2/6LdVdgt4JOuyDghusXxdnUxjoa/6CuiNNBtXWcsi5Hg
 oQpqDNPKRt8etzUS2yFJ/z571OrAp1U3nSbxUoGqrLotwvkgLq8PH1zup+Y2pAdRljl3nOBz4O8
 14o7YU3s3vCKIpQtKYFT3ie777bo1juMQEMRXnuHqGOBI+EnydM80X1nlr/Z/kOEQkTh6jUCtHr
 p2i6Xl0NFsKHru9uelg==
X-Proofpoint-GUID: DiBCgsWKrKs0ZYw9SaVtPz70kJvtJ2eW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060001
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
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4847D45503
X-Spamd-Bar: -----
Message-ID-Hash: CBE3QKNBUWOQNMBVXWPWHNPNV6DXLV5U
X-Message-ID-Hash: CBE3QKNBUWOQNMBVXWPWHNPNV6DXLV5U
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CBE3QKNBUWOQNMBVXWPWHNPNV6DXLV5U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Register an RPMI service driver matching the OP-TEE service UUID and
integrate it with OP-TEE module initialization and removal.

Check the service API version, query the trusted OS revision, and
obtain the RPC parameter and logical notification counts. Initialize
shared-memory tracking, the call queue, supplicant state and internal
context before publishing the client and supplicant TEE devices.

Connect the RPMI backend to the common OP-TEE operations and enumerate
trusted application devices. Enable in-kernel RPMB routing when the
RPMB subsystem is reachable.

Add removal and probe failure cleanup for the backend resources.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/core.c          |  10 +-
 drivers/tee/optee/optee_private.h |  21 ++-
 drivers/tee/optee/rpmi_abi.c      | 286 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index a52c1f498b99..8a44a25ebc66 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -220,6 +220,7 @@ void optee_remove_common(struct optee *optee)
 
 static int smc_abi_rc;
 static int ffa_abi_rc;
+static int rpmi_abi_rc;
 static bool intf_is_regged;
 
 static int __init optee_core_init(void)
@@ -245,14 +246,15 @@ static int __init optee_core_init(void)
 
 	smc_abi_rc = optee_smc_abi_register();
 	ffa_abi_rc = optee_ffa_abi_register();
+	rpmi_abi_rc = optee_rpmi_abi_register();
 
-	/* If both failed there's no point with this module */
-	if (smc_abi_rc && ffa_abi_rc) {
+	/* Keep the module if any supported transport registered successfully. */
+	if (smc_abi_rc && ffa_abi_rc && rpmi_abi_rc) {
 		if (IS_REACHABLE(CONFIG_RPMB)) {
 			rpmb_interface_unregister(&rpmb_class_intf);
 			intf_is_regged = false;
 		}
-		return smc_abi_rc;
+		return -EOPNOTSUPP;
 	}
 
 	return 0;
@@ -270,6 +272,8 @@ static void __exit optee_core_exit(void)
 		optee_smc_abi_unregister();
 	if (!ffa_abi_rc)
 		optee_ffa_abi_unregister();
+	if (!rpmi_abi_rc)
+		optee_rpmi_abi_unregister();
 }
 module_exit(optee_core_exit);
 
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index 2422caf3c883..07c27e322a71 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -188,6 +188,8 @@ struct rpmi_tee_device;
  * @rdev: owning RPMI service device
  * @shm_rht_lock: protects parcel lookup, insertion, removal and publication
  * @shm_rht: lookup by the host-endian parcel ID and nonce pair
+ * @sec_caps: negotiated optional OPTEE_RPMI_CAP_* features
+ * @notification_count: negotiated nonzero number of logical notification keys
  *
  * Callers keep their tee_shm alive while using its registration. Lookup
  * returns a raw pointer; the mutex does not protect its lifetime after
@@ -199,6 +201,8 @@ struct optee_rpmi {
 	/* Protects parcel lookup, insertion, removal and publication. */
 	struct mutex shm_rht_lock;
 	struct rhashtable shm_rht;
+	u32 sec_caps;
+	u32 notification_count;
 };
 #endif
 
@@ -211,8 +215,8 @@ struct optee;
  * @os_build_id:	OP-TEE OS build identifier (0 if unspecified)
  *
  * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
- * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revision, not an
- * FF-A ABI version.
+ * OPTEE_FFA_GET_OS_VERSION (FF-A ABI) or OPTEE_RPMI_GET_OS_VERSION (RPMI ABI).
+ * This is the trusted OS revision, not a transport ABI version.
  */
 struct optee_revision {
 	u32 os_major;
@@ -490,5 +494,18 @@ static inline void optee_ffa_abi_unregister(void)
 }
 #endif
 
+#if IS_REACHABLE(CONFIG_RISCV_RPMI_TEE_TRANSPORT)
+int optee_rpmi_abi_register(void);
+void optee_rpmi_abi_unregister(void);
+#else
+static inline int optee_rpmi_abi_register(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void optee_rpmi_abi_unregister(void)
+{
+}
+#endif
 
 #endif /*OPTEE_PRIVATE_H*/
diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
index 6e76316794c1..db541f3de425 100644
--- a/drivers/tee/optee/rpmi_abi.c
+++ b/drivers/tee/optee/rpmi_abi.c
@@ -684,3 +684,289 @@ static int optee_rpmi_do_call_with_arg(struct tee_context *ctx,
 
 	return optee_rpmi_yielding_call(ctx, &req, rpc_arg, system_thread);
 }
+
+/* Query and store the trusted OS revision. */
+static int optee_rpmi_get_os_version(struct optee *optee)
+{
+	struct optee_rpmi_probe_req req = {
+		.op = cpu_to_le32(OPTEE_RPMI_GET_OS_VERSION),
+	};
+	struct optee_rpmi_os_resp os;
+	int ret;
+
+	ret = optee_rpmi_call(optee, &req, sizeof(req), &os, sizeof(os));
+	if (ret)
+		return ret;
+
+	optee->revision.os_major = get_unaligned_le32(&os.major);
+	optee->revision.os_minor = get_unaligned_le32(&os.minor);
+	optee->revision.os_build_id = get_unaligned_le64(&os.build_id);
+
+	if (optee->revision.os_build_id)
+		pr_info("revision %u.%u (%016llx)\n",
+			optee->revision.os_major, optee->revision.os_minor,
+			optee->revision.os_build_id);
+	else
+		pr_info("revision %u.%u\n", optee->revision.os_major,
+			optee->revision.os_minor);
+
+	return 0;
+}
+
+/* Query and store secure-world capabilities and buffer limits. */
+static int optee_rpmi_exchange_caps(struct optee *optee)
+{
+	struct optee_rpmi_probe_req req = {
+		.op = cpu_to_le32(OPTEE_RPMI_EXCHANGE_CAPABILITIES),
+	};
+	struct optee_rpmi_caps_resp caps;
+	u32 rpc_count, sec_caps, notif_count;
+	int ret;
+
+	ret = optee_rpmi_call(optee, &req, sizeof(req), &caps, sizeof(caps));
+	if (ret)
+		return ret;
+
+	sec_caps = get_unaligned_le32(&caps.secure_caps);
+	rpc_count = get_unaligned_le32(&caps.rpc_param_count);
+	notif_count = get_unaligned_le32(&caps.notification_count);
+	if (!notif_count || !rpc_count)
+		return -EPROTO;
+
+	optee->rpc_param_count = rpc_count;
+	optee->rpmi.sec_caps = sec_caps;
+	optee->rpmi.notification_count = notif_count;
+	optee->in_kernel_rpmb_routing = IS_REACHABLE(CONFIG_RPMB);
+
+	return 0;
+}
+
+static int optee_rpmi_api_is_compatible(struct optee *optee)
+{
+	struct optee_rpmi_probe_req req = {
+		.op = cpu_to_le32(OPTEE_RPMI_GET_API_VERSION),
+	};
+	struct optee_rpmi_api_resp api;
+	int ret;
+
+	ret = optee_rpmi_call(optee, &req, sizeof(req), &api, sizeof(api));
+	if (ret)
+		return ret;
+
+	if (get_unaligned_le32(&api.major) != OPTEE_RPMI_VERSION_MAJOR)
+		return -EPROTONOSUPPORT;
+
+	/* Version 1.0 has no minimum minor revision beyond zero. */
+	return 0;
+}
+
+static void optee_rpmi_get_version(struct tee_device *teedev,
+				   struct tee_ioctl_version_data *vers)
+{
+	*vers = (struct tee_ioctl_version_data) {
+		.impl_id = TEE_IMPL_ID_OPTEE,
+		.gen_caps = TEE_GEN_CAP_GP | TEE_GEN_CAP_REG_MEM |
+			    TEE_GEN_CAP_MEMREF_NULL,
+	};
+}
+
+static int optee_rpmi_open(struct tee_context *ctx)
+{
+	return optee_open(ctx, true);
+}
+
+static const struct tee_driver_ops optee_rpmi_clnt_ops = {
+	.get_version = optee_rpmi_get_version,
+	.get_tee_revision = optee_get_revision,
+	.open = optee_rpmi_open,
+	.release = optee_release,
+	.open_session = optee_open_session,
+	.close_session = optee_close_session,
+	.invoke_func = optee_invoke_func,
+	.cancel_req = optee_cancel_req,
+	.shm_register = optee_rpmi_shm_register,
+	.shm_unregister = optee_rpmi_shm_unregister,
+};
+
+static const struct tee_driver_ops optee_rpmi_supp_ops = {
+	.get_version = optee_rpmi_get_version,
+	.get_tee_revision = optee_get_revision,
+	.open = optee_rpmi_open,
+	.release = optee_release_supp,
+	.supp_recv = optee_supp_recv,
+	.supp_send = optee_supp_send,
+	.shm_register = optee_rpmi_shm_register,
+	.shm_unregister = optee_rpmi_shm_unregister_supp,
+};
+
+static const struct tee_desc optee_rpmi_clnt_desc = {
+	.name = DRIVER_NAME "-rpmi-clnt",
+	.ops = &optee_rpmi_clnt_ops,
+	.owner = THIS_MODULE,
+};
+
+static const struct tee_desc optee_rpmi_supp_desc = {
+	.name = DRIVER_NAME "-rpmi-supp",
+	.ops = &optee_rpmi_supp_ops,
+	.owner = THIS_MODULE,
+	.flags = TEE_DESC_PRIVILEGED,
+};
+
+static const struct optee_ops optee_rpmi_ops = {
+	.do_call_with_arg = optee_rpmi_do_call_with_arg,
+	.to_msg_param = optee_rpmi_to_msg_param,
+	.from_msg_param = optee_rpmi_from_msg_param,
+};
+
+/* Keep callback state and memory tables alive until all TEE users release. */
+static void optee_rpmi_remove(struct rpmi_tee_device *rdev)
+{
+	struct optee *optee = dev_get_drvdata(&rdev->dev);
+
+	optee_remove_common(optee);
+	optee_rpmi_shm_rht_uninit(optee);
+	kfree(optee);
+}
+
+static int optee_rpmi_probe(struct rpmi_tee_device *rdev)
+{
+	struct tee_device *teedev;
+	struct tee_context *ctx;
+	int ret;
+
+	struct optee *optee __free(kfree) = kzalloc_obj(*optee);
+	if (!optee)
+		return -ENOMEM;
+
+	optee->rpmi.rdev = rdev;
+	optee->ops = &optee_rpmi_ops;
+
+	ret = optee_rpmi_api_is_compatible(optee);
+	if (ret)
+		return ret;
+
+	ret = optee_rpmi_get_os_version(optee);
+	if (ret)
+		return ret;
+
+	ret = optee_rpmi_exchange_caps(optee);
+	if (ret)
+		return ret;
+
+	optee->pool = optee_rpmi_shm_pool_alloc();
+	if (IS_ERR(optee->pool))
+		return PTR_ERR(optee->pool);
+
+	ret = optee_rpmi_shm_rht_init(optee);
+	if (ret)
+		goto err_pool;
+
+	optee_cq_init(&optee->call_queue, 0);
+	optee_supp_init(&optee->supp);
+	optee_shm_arg_cache_init(optee, OPTEE_SHM_ARG_SHARED);
+	mutex_init(&optee->rpmb_dev_mutex);
+	INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
+	optee->rpmb_intf.notifier_call = optee_rpmb_intf_rdev;
+	ret = optee_notif_init(optee, optee->rpmi.notification_count);
+	if (ret)
+		goto err_common;
+
+	/* Allocate all keys, then restrict the inclusive bound to the last key. */
+	optee->notif.max_key = optee->rpmi.notification_count - 1;
+
+	teedev = tee_device_alloc(&optee_rpmi_clnt_desc, &rdev->dev,
+				  optee->pool, optee);
+	if (IS_ERR(teedev)) {
+		ret = PTR_ERR(teedev);
+		goto err_notif;
+	}
+	optee->teedev = teedev;
+
+	teedev = tee_device_alloc(&optee_rpmi_supp_desc, &rdev->dev,
+				  optee->pool, optee);
+	if (IS_ERR(teedev)) {
+		ret = PTR_ERR(teedev);
+		goto err_devices;
+	}
+	optee->supp_teedev = teedev;
+
+	optee_set_dev_group(optee);
+
+	/* Internal RPC allocation must be ready before userspace can enter. */
+	ctx = teedev_open(optee->teedev);
+	if (IS_ERR(ctx)) {
+		ret = PTR_ERR(ctx);
+		goto err_devices;
+	}
+
+	optee->ctx = ctx;
+	dev_set_drvdata(&rdev->dev, optee);
+	if (optee->in_kernel_rpmb_routing)
+		blocking_notifier_chain_register(&optee_rpmb_intf_added,
+						 &optee->rpmb_intf);
+
+	ret = tee_device_register(optee->teedev);
+	if (ret)
+		goto err_initialized;
+
+	ret = tee_device_register(optee->supp_teedev);
+	if (ret)
+		goto err_initialized;
+
+	ret = optee_enumerate_devices(PTA_CMD_GET_DEVICES);
+	if (ret)
+		goto err_initialized;
+
+	dev_info(&rdev->dev, "OP-TEE RPMI %u.%u initialized\n",
+		 optee->revision.os_major, optee->revision.os_minor);
+	retain_and_null_ptr(optee);
+
+	return 0;
+
+err_initialized:
+	/* The remove path owns and frees the published backend state. */
+	retain_and_null_ptr(optee);
+	optee_rpmi_remove(rdev);
+
+	return ret;
+err_devices:
+	tee_device_unregister(optee->supp_teedev);
+	tee_device_unregister(optee->teedev);
+	optee_shm_arg_cache_uninit(optee);
+err_notif:
+	optee_notif_uninit(optee);
+err_common:
+	optee_supp_uninit(&optee->supp);
+	mutex_destroy(&optee->call_queue.mutex);
+	rpmb_dev_put(optee->rpmb_dev);
+	mutex_destroy(&optee->rpmb_dev_mutex);
+	optee_rpmi_shm_rht_uninit(optee);
+err_pool:
+	tee_shm_pool_free(optee->pool);
+
+	return ret;
+}
+
+static const struct rpmi_tee_device_id optee_rpmi_device_ids[] = {
+	{ OPTEE_RPMI_SERVICE_UUID },
+	{}
+};
+
+static struct rpmi_tee_driver optee_rpmi_driver = {
+	.name = DRIVER_NAME "-rpmi",
+	.probe = optee_rpmi_probe,
+	.remove = optee_rpmi_remove,
+	.id_table = optee_rpmi_device_ids,
+};
+
+int optee_rpmi_abi_register(void)
+{
+	return rpmi_tee_register(&optee_rpmi_driver);
+}
+
+void optee_rpmi_abi_unregister(void)
+{
+	rpmi_tee_unregister(&optee_rpmi_driver);
+}
+
+MODULE_ALIAS("rpmi_tee:486178e0-e7f8-11e3-bc5e-0002a5d5c51b");

-- 
2.34.1

