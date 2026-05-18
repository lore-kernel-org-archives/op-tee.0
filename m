Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12571CD4F3C
	for <op-tee@archiver.kernel.org>; Mon, 18 May 2026 07:29:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 499014447B
	for <op-tee@archiver.kernel.org>; Mon, 18 May 2026 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779089367;
	bh=rkHaZ1nlPXUbrziTJRIW5UaZLcD62A5hjX45NOsZBUI=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=qjnPnVIs5UoPmPc1VVEW9syXdqWSfy/NithzLveD7ES83r4HEJdxHdpVW7g3konET
	 LV4YXHT/6gTbrjo/j6Qug+Lqyul+CYmrDquDqZBY0VwcV426CXcTJXFwK4Bi/R5RQv
	 BxZa+4F9FFJwWcGDY81Zc8FVt8B78m59nOaqvjBFt8B8cwpC7SxQkROGnNtP+qL+KV
	 IhRUEPUQOgLEgp/Hjo85Iq4aRpewR1IY881LqHHLYofdISK03xz7W6tCl7DCzTfweD
	 B46neEjA1z8Oa9w3kThL7EYC3zRZBx/I8duGDmFGptSpuiOt3ZAwQtSuxmosycnqzq
	 qtRSZgGL69xkg==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0E0C243EF8
	for <op-tee@lists.trustedfirmware.org>; Mon, 18 May 2026 07:29:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nDvPedQF;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 77C8043B89;
	Mon, 18 May 2026 07:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E1AC2BCB7;
	Mon, 18 May 2026 07:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779089359;
	bh=rkHaZ1nlPXUbrziTJRIW5UaZLcD62A5hjX45NOsZBUI=;
	h=From:To:Cc:Subject:Date:From;
	b=nDvPedQFVsvlm5cLenIf9jhoFIEatRT92Jw8Ag/YETDDkHZOPF5jgRW/Yu7gfX9J0
	 kc61jiqw16fasOrMB7pZv7ST+oUFtZrcAokT/k7CsIvWh23g+Od9ac70zOQbAcOym0
	 +fyC+njjcc+arFDdhyTua/uRrRNbwBRvXFt8exugt1FeybU0/Ba9DoWVGqV1n71BfU
	 ZR78v0kgnH0mW1QeVH2VFqjLXVQebuI5ncHPTOV+eqkM3Q/YOUMPiZho24NUljkAOv
	 6qg2o5RjQnSLj4TABNPbJyXklsdZ19HXC4gacy4wzupvd4C866/gUcNjGx0QtTyCpQ
	 pzj9kClTJgemw==
To: andersson@kernel.org
Subject: [PATCH v6 00/16] firmware: qcom: Add OP-TEE PAS service support
Date: Mon, 18 May 2026 12:58:40 +0530
Message-ID: <20260518072856.22790-1-sumit.garg@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.infradead.org,kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0E0C243EF8
X-Spamd-Bar: -
Message-ID-Hash: TJDT4TMJ4EJQR76M3PBC7SDSZZN5F7TM
X-Message-ID-Hash: TJDT4TMJ4EJQR76M3PBC7SDSZZN5F7TM
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.
 viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TJDT4TMJ4EJQR76M3PBC7SDSZZN5F7TM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

From: Sumit Garg <sumit.garg@oss.qualcomm.com>

Qcom platforms has the legacy of using non-standard SCM calls
splintered over the various kernel drivers. These SCM calls aren't
compliant with the standard SMC calling conventions which is a
prerequisite to enable migration to the FF-A specifications from Arm.

OP-TEE as an alternative trusted OS to Qualcomm TEE (QTEE) can't
support these non-standard SCM calls. And even for newer architectures
using S-EL2 with Hafnium support, QTEE won't be able to support SCM
calls either with FF-A requirements coming in. And with both OP-TEE
and QTEE drivers well integrated in the TEE subsystem, it makes further
sense to reuse the TEE bus client drivers infrastructure.

The added benefit of TEE bus infrastructure is that there is support
for discoverable/enumerable services. With that client drivers don't
have to manually invoke a special SCM call to know the service status.

So enable the generic Peripheral Authentication Service (PAS) provided
by the firmware. It acts as the common layer with different TZ
backends plugged in whether it's an SCM implementation or a proper
TEE bus based PAS service implementation.

The TEE PAS service ABI is designed to be extensible with additional API
as PTA_QCOM_PAS_CAPABILITIES. This allows to accommodate any future
extensions of the PAS service needed while still maintaining backwards
compatibility.

Currently OP-TEE support is being added to provide the backend PAS
service implementation which can be found as part of this PR [1].
This implementation has been tested on Kodiak/RB3Gen2 board with lemans
EVK board being the next target. In addition to that WIN/IPQ targets
planning to use OP-TEE will use this service too. Surely the backwards
compatibility is maintained and tested for SCM backend.

Note that kernel PAS service support while running in EL2 is at parity
among OP-TEE vs QTEE. Especially the media (venus/iris) support depends
on proper IOMMU support being worked out on the PAS client end.

Patch summary:
- Patch #1: adds Kodiak EL2 overlay since boot stack with TF-A/OP-TEE
  only allow UEFI and Linux to boot in EL2.
- Patch #2: adds generic PAS service.
- Patch #3: migrates SCM backend to generic PAS service.
- Patch #4: adds TEE/OP-TEE backend for generic PAS service.
- Patch #5-#14: migrates all client drivers to generic PAS service.
- Patch #15: drops legacy PAS SCM exported APIs.

The patch-set is based on v7.1-rc4 tag and can be found in git tree here
[2].

Merge strategy:

It is expected due to APIs dependency, the entire patch-set to go via
the Qcom tree. All other subsystem maintainers, it will be great if I
can get acks for the corresponding subsystem patches.

[1] https://github.com/OP-TEE/optee_os/pull/7721 (already merged)
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v6

---
Changes in v6:
- Rebased to v7.1-rc4 tag.
- Patch #14: fixed ret error print.
- Add Kconfig descriptions for PAS symbols such that they are visible
  in menuconfig to update.

Changes in v5:
- Incorporated misc. comments from Mukesh.
- Split up patch #11 into 2 to add an independent commit for passing
  proper PAS ID to set_remote_state API.
- Picked up tags.

Changes in v4:
- Incorporate misc. comments on patch #4.
- Picked up an ack for patch #10.
- Clarify in cover letter about state of media support.

Changes in v3:
- Incorporated some style and misc. comments for patch #2, #3 and #4.
- Add QCOM_PAS Kconfig dependency for various subsystems.
- Switch from pseudo TA to proper TA invoke commands.

Changes in v2:
- Fixed kernel doc warnings.
- Polish commit message and comments for patch #2.
- Pass proper PAS ID in set_remote_state API for media firmware drivers.
- Added Maintainer entry and dropped MODULE_AUTHOR.

Mukesh Ojha (1):
  arm64: dts: qcom: kodiak: Add EL2 overlay

Sumit Garg (15):
  firmware: qcom: Add a generic PAS service
  firmware: qcom_scm: Migrate to generic PAS service
  firmware: qcom: Add a PAS TEE service
  remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
  remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
  soc: qcom: mdtloader: Switch to generic PAS TZ APIs
  remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
  remoteproc: qcom: Select QCOM_PAS generic service
  drm/msm: Switch to generic PAS TZ APIs
  media: qcom: Switch to generic PAS TZ APIs
  media: qcom: Pass proper PAS ID to set_remote_state API
  net: ipa: Switch to generic PAS TZ APIs
  wifi: ath12k: Switch to generic PAS TZ APIs
  firmware: qcom_scm: Remove SCM PAS wrappers
  MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service

 MAINTAINERS                                   |   9 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 arch/arm64/boot/dts/qcom/kodiak-el2.dtso      |  35 ++
 drivers/firmware/qcom/Kconfig                 |  21 +-
 drivers/firmware/qcom/Makefile                |   2 +
 drivers/firmware/qcom/qcom_pas.c              | 291 +++++++++++
 drivers/firmware/qcom/qcom_pas.h              |  50 ++
 drivers/firmware/qcom/qcom_pas_tee.c          | 476 ++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c              | 302 ++++-------
 drivers/gpu/drm/msm/Kconfig                   |   1 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
 drivers/media/platform/qcom/iris/Kconfig      |  25 +-
 .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
 drivers/media/platform/qcom/venus/Kconfig     |   1 +
 drivers/media/platform/qcom/venus/firmware.c  |  11 +-
 drivers/net/ipa/Kconfig                       |   2 +-
 drivers/net/ipa/ipa_main.c                    |  13 +-
 drivers/net/wireless/ath/ath12k/Kconfig       |   2 +-
 drivers/net/wireless/ath/ath12k/ahb.c         |  10 +-
 drivers/remoteproc/Kconfig                    |   4 +-
 drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
 drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
 drivers/remoteproc/qcom_wcnss.c               |  12 +-
 drivers/soc/qcom/mdt_loader.c                 |  12 +-
 include/linux/firmware/qcom/qcom_pas.h        |  43 ++
 include/linux/firmware/qcom/qcom_scm.h        |  29 --
 include/linux/soc/qcom/mdt_loader.h           |   6 +-
 28 files changed, 1119 insertions(+), 320 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
 create mode 100644 drivers/firmware/qcom/qcom_pas.c
 create mode 100644 drivers/firmware/qcom/qcom_pas.h
 create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
 create mode 100644 include/linux/firmware/qcom/qcom_pas.h

-- 
2.51.0

