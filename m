Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2AFFED2CC
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 06:28:41 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1339A43951
	for <op-tee@archiver.kernel.org>; Thu, 12 Mar 2026 06:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773296921;
	bh=gzjC3+HXwJYqJxbOxEjt7FRKLUrp3Sx8tGFp6KAYFyg=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=w6+veMkQ/vzQxZWEk1hTSlvQO0CKCEYmCkp/sAY9q3X0X5omtIaUhaHEE3SMjj5b8
	 /FIobtyts5JG6cqq5hInaK55tl3loNnxQcXwt9DYWX/Ch5vJTdKB/LESsq3F9QTDS1
	 GE3vANbTzBQFt8pbkh7Qz7Zp5hnjUAfOWLo+WOuuhp/c0f4HnMaAX6ZqFxXPueh7oW
	 OHPcKc0sMg5hrGxarVXBv5J29ssSJF6ysWhikD6yVpdR+db7aJBcDQwbzg0Wexaxqz
	 HqCStAzL2e8o8lcXQLOJaWQbwrQf4omggiP8V5i+pMSiPpeULNGSTtatsu1XiC2FXG
	 jf4LXqrTGfg5w==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9BA82430AD
	for <op-tee@lists.trustedfirmware.org>; Thu, 12 Mar 2026 06:28:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QuYTGHhY;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ACA78423BC;
	Thu, 12 Mar 2026 06:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE6EC4CEF7;
	Thu, 12 Mar 2026 06:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773296899;
	bh=gzjC3+HXwJYqJxbOxEjt7FRKLUrp3Sx8tGFp6KAYFyg=;
	h=From:To:Cc:Subject:Date:From;
	b=QuYTGHhYc3mF+ToCAl/YU2nORRURoLpgtIWhZaoxhM9y1isdCNmVBphhYPKYNcuCk
	 MtSSCCihQdGnGVMfvEn6kNvFKgTgVtObil4m74Q2ATvVYQHU2kjnnspGpcIEkpnwgq
	 4fYorrbf2rUfw6Wvp2D0iSKZuOFC58bp9u5HN/QCxrfcv1Lj4rwCGAf5H7eTll2Adc
	 tJf3fzcducdbwGNeo1ZUnd/rg4EQazr/N4lq9hamfA/UswJt1YNqDY3F/IdNZj1DH3
	 /6CnguYXyYLZF+Owj+hK+SWQ5GagYjg2kwcxAA8QjvFIp6Jl10AF4LgbKxEjkdu1bD
	 S1kunhkCWRTdQ==
To: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org
Subject: [PATCH v2 00/15] firmware: qcom: Add OP-TEE PAS service support
Date: Thu, 12 Mar 2026 11:57:41 +0530
Message-ID: <20260312062756.694390-1-sumit.garg@kernel.org>
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
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9BA82430AD
X-Spamd-Bar: -
Message-ID-Hash: LMBSYOCRIW64DU2WD6CJUBR5GMDCSTZ6
X-Message-ID-Hash: LMBSYOCRIW64DU2WD6CJUBR5GMDCSTZ6
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com, bod@kernel.org, mchehab@kernel.org, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vignesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualco
 mm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/LMBSYOCRIW64DU2WD6CJUBR5GMDCSTZ6/>
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
with S-EL2 and Hafnium support, QTEE won't be able to support SCM
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

Patch summary:
- Patch #1: adds Kodiak EL2 overlay since boot stack with TF-A/OP-TEE
  only allow UEFI and Linux to boot in EL2.
- Patch #2: adds generic PAS service.
- Patch #3: migrates SCM backend to generic PAS service.
- Patch #4: adds TEE/OP-TEE backend for generic PAS service.
- Patch #5-#13: migrates all client drivers to generic PAS service.
- Patch #14: drops legacy PAS SCM exported APIs.

The patch-set is based on v7.0-rc2 tag and can be found in git tree here
[2].

Merge strategy:

It is expected due to APIs dependency, the entire patch-set to go via
the Qcom tree. All other subsystem maintainers, it will be great if I
can get acks for the corresponding subsystem patches.

[1] https://github.com/OP-TEE/optee_os/pull/7721
[2] https://git.kernel.org/pub/scm/linux/kernel/git/sumit.garg/linux.git/log/?h=qcom-pas-v1

---
Changes in v2:
- Fixed kernel doc warnings.
- Polish commit message and comments for patch #2.
- Pass proper PAS ID in set_remote_state API for media firmware drivers.
- Added Maintainer entry and dropped MODULE_AUTHOR.
- Picked up ack from Jeff.

Mukesh Ojha (1):
  arm64: dts: qcom: kodiak: Add EL2 overlay

Sumit Garg (14):
  firmware: qcom: Add a generic PAS service
  firmware: qcom_scm: Migrate to generic PAS service
  firmware: qcom: Add a PAS TEE service
  remoteproc: qcom_q6v5_pas: Switch over to generic PAS TZ APIs
  remoteproc: qcom_q6v5_mss: Switch to generic PAS TZ APIs
  soc: qcom: mdtloader: Switch to generic PAS TZ APIs
  remoteproc: qcom_wcnss: Switch to generic PAS TZ APIs
  remoteproc: qcom: Select QCOM_PAS_TEE service backend
  drm/msm: Switch to generic PAS TZ APIs
  media: qcom: Switch to generic PAS TZ APIs
  net: ipa: Switch to generic PAS TZ APIs
  wifi: ath12k: Switch to generic PAS TZ APIs
  firmware: qcom_scm: Remove SCM PAS wrappers
  MAINTAINERS: Add maintainer entry for Qualcomm PAS TZ service

 MAINTAINERS                                   |   9 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 arch/arm64/boot/dts/qcom/kodiak-el2.dtso      |  35 ++
 drivers/firmware/qcom/Kconfig                 |  18 +
 drivers/firmware/qcom/Makefile                |   2 +
 drivers/firmware/qcom/qcom_pas.c              | 298 +++++++++++
 drivers/firmware/qcom/qcom_pas.h              |  53 ++
 drivers/firmware/qcom/qcom_pas_tee.c          | 477 ++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c              | 304 ++++-------
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  11 +-
 .../media/platform/qcom/iris/iris_firmware.c  |   9 +-
 drivers/media/platform/qcom/venus/firmware.c  |  11 +-
 drivers/net/ipa/ipa_main.c                    |  13 +-
 drivers/net/wireless/ath/ath12k/ahb.c         |   8 +-
 drivers/remoteproc/Kconfig                    |   1 +
 drivers/remoteproc/qcom_q6v5_mss.c            |   5 +-
 drivers/remoteproc/qcom_q6v5_pas.c            |  51 +-
 drivers/remoteproc/qcom_wcnss.c               |  12 +-
 drivers/soc/qcom/mdt_loader.c                 |  12 +-
 include/linux/firmware/qcom/qcom_pas.h        |  41 ++
 include/linux/firmware/qcom/qcom_scm.h        |  29 --
 include/linux/soc/qcom/mdt_loader.h           |   6 +-
 23 files changed, 1108 insertions(+), 303 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/kodiak-el2.dtso
 create mode 100644 drivers/firmware/qcom/qcom_pas.c
 create mode 100644 drivers/firmware/qcom/qcom_pas.h
 create mode 100644 drivers/firmware/qcom/qcom_pas_tee.c
 create mode 100644 include/linux/firmware/qcom/qcom_pas.h

-- 
2.51.0

