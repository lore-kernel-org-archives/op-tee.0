Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58853F01826
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 10:52:11 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A2273438A8
	for <op-tee@archiver.kernel.org>; Fri,  6 Mar 2026 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1772794330;
	bh=VulyuWgkoLsxmBOeLgDF0beLPvgQfeLav/LDt2v0t0Q=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=hD5+wPhXrlI0r+w4jwguWOTHkzTl5P3Em+t9M6pGUm7Lm+f3EjDa/Etfu2zbIEtLB
	 4xZt2s+AhcvHUmLG9rbyOkI2cqR85Bvc1Y5dC0N6u10YN9erfiP+FdGqSGQMn2gBSF
	 TLC1w1bsCHj5/n9EE1RAAaT35oy9l88tFbIlaImHpfpcZZzGC2A3aYbbtLkbRdUQfC
	 NhErDzi/DuTEjPw6bW2R+G6hOShbjS68KM8NjCj5AaMzpKFTHhxz//zgBBpRvJnHHX
	 CmjwlUwU7lj9LNE0bnRg2/rR2U89qLDEAFcBhClDpMUekKKE0s35UagqhpnfVenLza
	 atxWb3ElNz5XQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B0EBF43754
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Mar 2026 10:51:19 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VmU6y7g3;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 32FE060018;
	Fri,  6 Mar 2026 10:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135E5C4CEF7;
	Fri,  6 Mar 2026 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772794278;
	bh=VulyuWgkoLsxmBOeLgDF0beLPvgQfeLav/LDt2v0t0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmU6y7g3advHug/qS723M6eJUsviyh5bVasatx5p50xDjCT09nokXcIYQQVxdk1Uh
	 IXHFoRAZ59QQXpUwxq3xBJleExhVzhTADDdniH854fSHsDs+QLroSQIXW/DPSNUro1
	 wjyv1NYmQjKE5TvnNe+/D4WwZ4VWDBXjfb1gJgEGU5osdEl+JI/AhmXy90VvD0NDNp
	 7TpYWuYuzT+yNafUWwPc2FLPUUP/842c2BBVecR6Vgt0fq9xo6pgCcqzsOpXcvcH6Y
	 rvzXVI0axUarB6ZPzjzBQuF2nqh/QuMGf5yNXBZBHPAk5+8Y5HjQwumg7DBTN8jMDO
	 l1dKtb0+CMd9g==
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH 01/14] arm64: dts: qcom: kodiak: Add EL2 overlay
Date: Fri,  6 Mar 2026 16:20:14 +0530
Message-ID: <20260306105027.290375-2-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306105027.290375-1-sumit.garg@kernel.org>
References: <20260306105027.290375-1-sumit.garg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.98 / 15.00];
	BAYES_HAM(-2.98)[99.91%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[172.105.4.254:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B0EBF43754
X-Spamd-Bar: -
Message-ID-Hash: SZJOVYI3YGVFWKL4FBOW27TAP54NPV3T
X-Message-ID-Hash: SZJOVYI3YGVFWKL4FBOW27TAP54NPV3T
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SZJOVYI3YGVFWKL4FBOW27TAP54NPV3T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

All the existing variants Kodiak boards are using Gunyah hypervisor
which means that, so far, Linux-based OS could only boot in EL1 on those
devices.  However, it is possible for us to boot Linux at EL2 on these
devices [1].

When running under Gunyah, the remote processor firmware IOMMU
streams are controlled by Gunyah. However, without Gunyah, the IOMMU is
managed by the consumer of this DeviceTree. Therefore, describe the
firmware streams for each remote processor.

Add a EL2-specific DT overlay and apply it to Kodiak IOT variant
devices to create -el2.dtb for each of them alongside "normal" dtb.

[1]
https://docs.qualcomm.com/bundle/publicresource/topics/80-70020-4/boot-developer-touchpoints.html#uefi

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
[SG: watchdog fixup]
Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile        |  2 ++
 arch/arm64/boot/dts/qcom/kodiak-el2.dtso | 35 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index f80b5d9cf1e8..09a7f943190e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -139,6 +139,8 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-radxa-dragon-q6a.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
+qcs6490-rb3gen2-el2-dtbs := qcs6490-rb3gen2.dtb kodiak-el2.dtbo
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2-el2.dtb
 
 qcs6490-rb3gen2-vision-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-vision-mezzanine.dtbo
 qcs6490-rb3gen2-industrial-mezzanine-dtbs := qcs6490-rb3gen2.dtb qcs6490-rb3gen2-industrial-mezzanine.dtbo
diff --git a/arch/arm64/boot/dts/qcom/kodiak-el2.dtso b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
new file mode 100644
index 000000000000..0b3a69a0d765
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/kodiak-el2.dtso
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Kodiak specific modifications required to boot in EL2.
+ */
+
+
+/dts-v1/;
+/plugin/;
+
+&gpu_zap_shader {
+	status = "disabled";
+};
+
+&remoteproc_adsp {
+	iommus = <&apps_smmu 0x1800 0x0>;
+};
+
+&remoteproc_cdsp {
+	iommus = <&apps_smmu 0x11a0 0x0400>;
+};
+
+&remoteproc_wpss {
+	iommus = <&apps_smmu 0x1c03 0x1>,
+		 <&apps_smmu 0x1c83 0x1>;
+};
+
+&venus {
+	status = "disabled";
+};
+
+&watchdog {
+	status = "okay";
+};
-- 
2.51.0

