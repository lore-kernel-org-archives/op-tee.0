Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91472C7EE30
	for <op-tee@archiver.kernel.org>; Wed, 25 Jun 2025 09:42:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C30C245A1F
	for <op-tee@archiver.kernel.org>; Wed, 25 Jun 2025 09:42:41 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector1 header.b=TjYA1M/i;
	dkim-atps=neutral
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B39DE42FC8
	for <op-tee@lists.trustedfirmware.org>; Wed, 25 Jun 2025 09:42:17 +0000 (UTC)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P6TNdK008602;
	Wed, 25 Jun 2025 11:42:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=dWT/lq3ezUgwjJtZ7iXKMD
	5/gM55U+METxpHEphd3xI=; b=TjYA1M/i9kiwj0xW7K69CkB715jG9Tc1/NBvhN
	13rdzv3F59kAvAv7F57DPvkyhTUGm9i/ecoUFus0YFUhx0LDKiBdplSAYpzM6ejd
	DCdDg/I2D6GsUR0IHaSS7wvbk5MxFfLGxkHCD2EYQbS56TjMNZ5R8sKlfEvVNebc
	YX4leCmbCJeLrn2l+DpK4HKpHsD2By7MTdMVMvjZpR3XiRZiW1lT7XiIzMC7xry7
	NNdNzit9ccjjjrFo/VDHuVKsqwM+qaEfUrRLXSyh/Rg9qL/5cv+0uuZG3ro4NuUT
	nVfoTzVqpwGFnepelzieT4jaLh27s0DvdsNXBKy4HtGmX87w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47e6a6q3m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 11:42:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3968740047;
	Wed, 25 Jun 2025 11:40:57 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8270364326D;
	Wed, 25 Jun 2025 11:40:41 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 11:40:41 +0200
Received: from localhost (10.48.86.121) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 11:40:41 +0200
From: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>
Subject: [PATCH v19 0/6] Introduction of a remoteproc tee to load signed firmware
Date: Wed, 25 Jun 2025 11:40:22 +0200
Message-ID: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.86.121]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_02,2025-06-23_07,2025-03-28_01
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B39DE42FC8
X-Spamd-Bar: +
X-Spamd-Result: default: False [1.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	RBL_SENDERSCORE_REPUT_6(1.00)[185.132.182.106:from];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	DNSWL_BLOCKED(0.00)[185.132.182.106:from];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	R_DKIM_ALLOW(0.00)[foss.st.com:s=selector1];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnaud.pouliquen@foss.st.com,prvs=82719a3f78=arnaud.pouliquen@foss.st.com];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	HAS_XOIP(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DMARC_POLICY_ALLOW(0.00)[foss.st.com,none];
	TAGGED_RCPT(0.00)[dt];
	FORGED_SENDER_VERP_SRS(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[st.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:185.132.182.106:c];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:52129, ipnet:185.132.182.0/24, country:US];
	DKIM_TRACE(0.00)[foss.st.com:+];
	FROM_HAS_DN(0.00)[]
Message-ID-Hash: AQEYTPVMVUIVFQUN4DUK57YM2CZ6OG42
X-Message-ID-Hash: AQEYTPVMVUIVFQUN4DUK57YM2CZ6OG42
X-MailFrom: prvs=82719a3f78=arnaud.pouliquen@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AQEYTPVMVUIVFQUN4DUK57YM2CZ6OG42/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Main updates from version V18[2]:
- rework documentation for the release_fw ops 
- rework function documentation in remoteproc_tee.c
- replace spinlock by mutex and generalize usage in remoteproc_tee.c


Main updates from version V17[1]:
- Fix:  warning: EXPORT_SYMBOL() is used, but #include <linux/export.h>
  is missing

More details are available in each patch commit message.

[1] https://lore.kernel.org/linux-remoteproc/20250613091650.2337411-1-arnaud.pouliquen@foss.st.com/
[2] https://lore.kernel.org/linux-remoteproc/20250616075530.4106090-1-arnaud.pouliquen@foss.st.com/

Tested-on: commit 19272b37aa4f ("Linux 6.16-rc1")

Description of the feature:
--------------------------
This series proposes the implementation of a remoteproc tee driver to
communicate with a TEE trusted application responsible for authenticating
and loading the remoteproc firmware image in an Arm secure context.

1) Principle:

The remoteproc tee driver provides services to communicate with the OP-TEE
trusted application running on the Trusted Execution Context (TEE).
The trusted application in TEE manages the remote processor lifecycle:

- authenticating and loading firmware images,
- isolating and securing the remote processor memories,
- supporting multi-firmware (e.g., TF-M + Zephyr on a Cortex-M33),
- managing the start and stop of the firmware by the TEE.

2) Format of the signed image:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/src/remoteproc_core.c#L18-L57

3) OP-TEE trusted application API:

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/ta/remoteproc/include/ta_remoteproc.h

4) OP-TEE signature script

Refer to:
https://github.com/OP-TEE/optee_os/blob/master/scripts/sign_rproc_fw.py

Example of usage:
sign_rproc_fw.py --in <fw1.elf> --in <fw2.elf> --out <signed_fw.sign> --key ${OP-TEE_PATH}/keys/default.pem


5) Impact on User space Application

No sysfs impact. The user only needs to provide the signed firmware image
instead of the ELF image.


For more information about the implementation, a presentation is available here
(note that the format of the signed image has evolved between the presentation
and the integration in OP-TEE).

https://resources.linaro.org/en/resource/6c5bGvZwUAjX56fvxthxds

Arnaud Pouliquen (6):
  remoteproc: core: Introduce rproc_pa_to_va helper
  remoteproc: Add TEE support
  remoteproc: Introduce optional release_fw operation
  dt-bindings: remoteproc: Add compatibility for TEE support
  remoteproc: stm32: Create sub-functions to request shutdown and
    release
  remoteproc: stm32: Add support of an OP-TEE TA to load the firmware

 .../bindings/remoteproc/st,stm32-rproc.yaml   |  58 +-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/remoteproc_core.c          |  52 ++
 drivers/remoteproc/remoteproc_internal.h      |   6 +
 drivers/remoteproc/remoteproc_tee.c           | 708 ++++++++++++++++++
 drivers/remoteproc/stm32_rproc.c              | 139 +++-
 include/linux/remoteproc.h                    |   6 +
 include/linux/remoteproc_tee.h                |  87 +++
 9 files changed, 1023 insertions(+), 44 deletions(-)
 create mode 100644 drivers/remoteproc/remoteproc_tee.c
 create mode 100644 include/linux/remoteproc_tee.h


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
-- 
2.25.1

