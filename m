Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5623C88E70
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 12:42:50 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E055B4506A
	for <op-tee@archiver.kernel.org>; Mon, 14 Sep 2026 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789389770;
	bh=kKUjFxTDzaIvfCLVxP1OmjKiQRgwNhTIUBFn6PNx22w=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=gcmElpwxp/GNko6GAwNMGJnxcfNTSXBX4O41qfA287px3p/l9B21rnsc5R7WASFBM
	 grq0gXDytVgDLXMXPdPtTr/vbPykaz7sQkv7Ubfln7Q2B03oZVv/YdZ0WBE6lSCvJ0
	 abTn59HVgnspTosa/RESp7pT8iEp9h7gNECeKswt71ch2tCNF6OZcbx1WJrpadF0d+
	 yq/HqC9jpNn2DsCYQlDPZHjt554Kpn00lNnR9dNRwTTATfxr/iUoboOK6bw21SxO1N
	 33x0TZsb/XKFwNxE5R7RHKp6ImcHarG11JSJekv0EPQNiYP4wcG0MSp/pMjkdFQfMi
	 ttnjaj46+gtlA==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 76D29434BE
	for <op-tee@lists.trustedfirmware.org>; Mon, 14 Sep 2026 12:42:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NDdhQ8OG;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789389760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gS0PasUdCVmtQZHlDSGBeMxyLgFshGbkXoV5dyvEzpg=;
	b=NDdhQ8OGBhs8bjyyKbFwHdUKZeLryp0M/WnCSxrSDb8ZoOJfKwkwQdXk9aBVsnW0LrVTE6
	0AJjEY35NTV/qtPM4NtTyaoAAWfuP5aothpVx+Z7Nv0AjWsfc4DXAwx66Es5JaM8Gwkd3w
	Vq7PmWwbLvPWdIbT2mt8EBbTG4KFnsc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-21-ROAKiUATP9Sm4zdp5Rer-Q-1; Mon,
 14 Sep 2026 08:42:36 -0400
X-MC-Unique: ROAKiUATP9Sm4zdp5Rer-Q-1
X-Mimecast-MFC-AGG-ID: ROAKiUATP9Sm4zdp5Rer-Q_1789389751
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F119A180A9F5;
	Mon, 14 Sep 2026 12:42:28 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B83C341D;
	Mon, 14 Sep 2026 12:42:13 +0000 (UTC)
Subject: [PATCH 0/3] firmware: qcom: scm: pass struct qcom_scm through the
 API
Date: Mon, 14 Sep 2026 14:41:53 +0200
Message-Id: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bsE0tPpKdBBdaw+VKEQQ/j3pO
 DAzLxTKTAVm8UKmmwtfZ4O+E+B3d26EHBqDksrISY5Y/IGhiZ7QJUajB+ets1FbCy1KmSI//3B
 Za/0AntZYi2AAAAA=
X-Change-ID: 20260908-scm-device-api-634ac7a7f377
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <jjohnson@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Brian Norris <briannorris@chromium.org>,
 Govind Singh <govinds@codeaurora.org>,
 Niklas Cassel <niklas.cassel@linaro.org>, Kalle Valo <kvalo@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789389733; l=4126;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=kKUjFxTDzaIvfCLVxP1OmjKiQRgwNhTIUBFn6PNx22w=;
 b=ptN78nZt4fGWWnpdDZyVENIgI04y8a4PWpV9Q7ESU1lJXI6I5/2224GMHxqfT8NR3RqXorNth
 jHJX4SMRZ0tCfmG8DtbgRZpcTf2pE4dns304nz4VWJerDfTGzhcT+6A
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1jJOCrtw1QC56DrqzARSlk2vxTQG8dbRETDUIBukS4w_1789389751
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[redhat.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[us-smtp-delivery-124.mimecast.com:helo,us-smtp-delivery-124.mimecast.com:rdns];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,armlinux.org.uk,arm.com,gmail.com,oss.qualcomm.com,poorly.run,linux.dev,somainline.org,ffwll.ch,8bytes.org,rendec.net,arndb.de,linuxfoundation.org,linaro.org,intel.com,chromium.org,codeaurora.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	DNSWL_BLOCKED(0.00)[170.10.129.124:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[60];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[170.10.129.124:from];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 76D29434BE
X-Spamd-Bar: ----
Message-ID-Hash: VCG2QYKHQUSDTXTTBMFTA7QHEHRAO6RN
X-Message-ID-Hash: VCG2QYKHQUSDTXTTBMFTA7QHEHRAO6RN
X-MailFrom: aesteve@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, linux-gpio@vger.kernel.org, linux-remoteproc@vger.kernel.org, op-tee@lists.trustedfirmware.org, Maxime Ripard <mripard@kernel.org>, Albert Esteve <aesteve@redhat.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VCG2QYKHQUSDTXTTBMFTA7QHEHRAO6RN/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Albert Esteve via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Albert Esteve <aesteve@redhat.com>

The SCM driver still funnels every call through a process-wide
__scm singleton.

This series threads struct qcom_scm through the driver and the
exported API, then drops the global.

Series summary
--------------
Patch 1: Internal helpers take the instance. Callbacks that only
have a struct device or reset_controller_dev recover it
with drvdata / container_of. Exported signatures stay
unchanged so this patch is bisectable on its own.

Patch 2: Exported calls take struct qcom_scm * as the first
argument. The type stays opaque in qcom_scm.h.

    Children of the SCM device (qseecom, tzmem, qcomtee)
    use dev_get_drvdata() on the parent. Other consumers
    call qcom_scm_get(), which finds the bound platform
    device and returns NULL until probe has marked the
    instance ready. Callers that need SCM return
    -EPROBE_DEFER; callers that only use it for an optional
    path (rmtfs VMIDs, fastrpc vmids, PAS region assign,
    Venus CP, HDMI HDCP, Adreno fuse poke) skip the lookup
    or tolerate NULL. qcom_pas_* is unchanged: PAS has a
    TEE backend, so those ops keep struct device * and the
    SCM backend uses drvdata.

Patch 3: Drop __scm. Readiness is scm->available with the same
release/acquire pairing as today. Module-parameter
stores reuse qcom_scm_get(); shutdown uses
platform_get_drvdata().

No intended change in SCM calling convention or wait-queue
behaviour.

Testing
-------

Booted to a shell on Qualcomm SA8775P Ride4 with current series.
qcom_scm bound as firmware:qcom_scm; probe logged SMC ARM 64 and
the tz-ffi reserved-memory assignment. Consumers were not exercised.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
Albert Esteve (3):
      firmware: qcom: scm: pass qcom_scm to internal helpers
      firmware: qcom: scm: pass qcom_scm through the exported API
      firmware: qcom: scm: drop the __scm global

 arch/arm/mach-qcom/platsmp.c                     |   3 +-
 drivers/cpuidle/cpuidle-qcom-spm.c               |  28 +-
 drivers/firmware/qcom/qcom_qseecom.c             |   3 +-
 drivers/firmware/qcom/qcom_scm-smc.c             |   2 +-
 drivers/firmware/qcom/qcom_scm.c                 | 518 +++++++++++++----------
 drivers/firmware/qcom/qcom_scm.h                 |   2 +-
 drivers/firmware/qcom/qcom_tzmem.c               |   6 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c            |   6 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c          |   8 +-
 drivers/gpu/drm/msm/hdmi/hdmi_hdcp.c             |   6 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom-debug.c |   9 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c       |   8 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h       |   3 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c          |  18 +-
 drivers/irqchip/qcom-pdc.c                       |   6 +-
 drivers/media/platform/qcom/venus/firmware.c     |  10 +-
 drivers/misc/fastrpc.c                           |  31 +-
 drivers/net/wireless/ath/ath10k/qmi.c            |  12 +-
 drivers/net/wireless/ath/ath10k/qmi.h            |   3 +
 drivers/nvmem/sec-qfprom.c                       |   6 +-
 drivers/pinctrl/qcom/pinctrl-msm.c               |  11 +-
 drivers/remoteproc/qcom_q6v5_mss.c               |   6 +-
 drivers/remoteproc/qcom_q6v5_pas.c               |  12 +-
 drivers/soc/qcom/ice.c                           |  23 +-
 drivers/soc/qcom/ocmem.c                         |  22 +-
 drivers/soc/qcom/rmtfs_mem.c                     |   8 +-
 drivers/tee/qcomtee/call.c                       |   7 +
 drivers/tee/qcomtee/core.c                       |   6 +-
 drivers/tee/qcomtee/qcomtee.h                    |   2 +
 drivers/thermal/qcom/lmh.c                       |  22 +-
 include/linux/firmware/qcom/qcom_qseecom.h       |   5 +-
 include/linux/firmware/qcom/qcom_scm.h           | 117 ++---
 32 files changed, 566 insertions(+), 363 deletions(-)
---
base-commit: bc35965f6940a9bf834d54187b6088b8eb09206d
change-id: 20260908-scm-device-api-634ac7a7f377

Best regards,
-- 
Albert Esteve <aesteve@redhat.com>

