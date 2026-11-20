Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D760A2622
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LpDcy8/d;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q2Ie4UZ2
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E3F2F50356
	for <op-tee@archiver.kernel.org>; Fri, 20 Nov 2026 10:53:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LpDcy8/d;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q2Ie4UZ2;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0D1F4443F8
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:53:51 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKAjs241681939
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wdWa/4zUENK9UMGMyp2jZm
	Fl6x8KTgGcppwHxjuP6SA=; b=LpDcy8/dnZBg4E1IJ3a5ZH8uZRvErhbbJk3frv
	Fz8ZWFphPU1S4lnfl5aQajYf500e6q0HMVFUzDq51JsRTCsOG6Vln4htzzMFPek6
	wTTxZgvRjrWq425ODzcLxliBfeSug0Rj44HvgVPwsx6BqZjBSvCB0d+nVFkzT3pj
	WxeJnQ3AqOb05r238ZSuBunn93RZIAnikL6JqFelqj2oZXgSfTJ0/t+f2Zq/Iwpg
	yjM13LVCAqIPT4ZsOHwLHO9oVUiWlmkUzY1138ekDSNhBY7u/3tMHt72QktRydUL
	/rK2/wJ3fdyUkDZDIjYgcn4DAcD7TSZNqq51N0UfyGCYoqpw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2cd1t2cr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 10:53:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b3fd219d07so817460a91.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 20 Nov 2026 02:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795172030; x=1795776830; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wdWa/4zUENK9UMGMyp2jZmFl6x8KTgGcppwHxjuP6SA=;
        b=Q2Ie4UZ2V+2bTr66qmeLGl5ufkkoyXUcJX4KbWITOOvL+T1Yiqo4Fnm72eEVwjmY15
         IH7ErdwJjSuM4bf23dPW2pL0BPRxH53j5SyMYrGOv1oIvFUx088z/yA90poWr6kq7o5Z
         FOXe+WiFltHbaWaaKP/eVW3x+cdkg1Yiv8vl9Pc7x73lkMe1VMPyRYvqUnFiAs9ctmVJ
         Y4BsQfj2HkqcJVeQAaClEWdOXIz7ZmrT4Z8sIMGIC5+SNUpfjVEfgqiU1sVbi589w39x
         85q7Gr4f+pnB3ckS9oWsvY7S5t8WBDp1+RaI4fnR3aPDgRkPfxqPteR3OOW2EyUfeQQx
         0JdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795172030; x=1795776830;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wdWa/4zUENK9UMGMyp2jZmFl6x8KTgGcppwHxjuP6SA=;
        b=kFVf3lflUK7vq29W8pRGqGtYDv3du35UiuUzrdAUpCUB64qG/MxUqHNHEObcto+I6o
         KzKE4MJvZsZAgcn3GXjfMwZIXeE692wFx9jNnlP2YoLxOsnAg+z1bvK/Qr/2gOlzSO6W
         zpAntvZAC7Ajk3LWJwRtJ5SBI+MUZQ/caYkIgJZ9AtuHYNW1o/NDGgObJ/+PvSZgdQrF
         63kYeqcbmUGEP3zsST3/sQk2i1eTjHwwmwX1ecHegFLRXc2yevLxEbTKiSAG9lo03zJ/
         E4+RXoe345pnbEiOC7eBXwV0+gDqW2Hl+HyGq72uUcIbBX92eeoHRcqGMWHcqVkTy2bm
         kFSQ==
X-Forwarded-Encrypted: i=1; AL+hErFZKnZENF8DqE5HMPYBv+6sujhW72swtnQxQ4vtssIaqRTTBCjnUl5in+zdwpi3LPL9Yf7g1+s=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z98x9NRFrLNuQ41UHvrONZuUNfTtshY5w783B1bL8WI3IonlJY0
	VpvEfn3sp36g7gFG6D8fAs6fbxErTk8M7hmd97gkIW9aeNQw2pAHfBsi/VSem2NKDCwU7AfOnn6
	kckzb8flLPIDIShi4S7NS2OJWfPrMckL0JIaLpdIx2CgC2mDyNGwSGJeqR9l0Ki6tsSVh63jE
X-Gm-Gg: AZFdTZf4jzJ6cOJZrLJGYxuscepptApsZYlG2sTNdUL3V/ggIAIeoBMvhlz9AmjF19h
	f+QnLKW89713VW/bCU2Mx6oj5IMCRvJZ7/hrcD6GKI9+leWb+KTcyn24vtD0z82F2tkvwI0fgEX
	iqVyh+TWpjjX74UvRNPRQ1NpdaEBF3/VGYZzCAN3XPmwpgwRkL8IHsEAh71OnoHypQb39iMBo1A
	mtOcNv4GWdV5ybj1SpT6czd3uBU+ZzgAqaegFNNt1ebQmU/0yWdwikZA1EJy9AUtYFTGD5A1VLB
	B3s68rS+ugBdzatbp1Rml7k7jq/m2Hlk174mHlAyGBLHCukbp/cczX5GdU6+lgi83XtF4EoYYxW
	6NF9DhunmSWO4X+CUFk9qzprc3W3M1hxpSivQkevPIN1WQThq3CPADPpguz0qFiw73uG20oedU+
	gaTZPkqjY=
X-Received: by 2002:a17:90b:4ccb:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b41c7b67femr2593221a91.3.1795172030050;
        Fri, 20 Nov 2026 02:53:50 -0800 (PST)
X-Received: by 2002:a17:90b:4ccb:b0:3b0:9183:23ef with SMTP id 98e67ed59e1d1-3b41c7b67femr2593193a91.3.1795172029410;
        Fri, 20 Nov 2026 02:53:49 -0800 (PST)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41d22888esm1559604a91.3.2026.11.20.02.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:53:48 -0800 (PST)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v5 0/3] Add TPM support via Qualcomm TEE TPM TA
Date: Fri, 20 Nov 2026 16:23:31 +0530
Message-Id: <20261120-tpm_qcom_driver-v5-0-3d9321ace107@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK0mAGsC/3XQS2rDMBAG4KsYr6ug98Or3KOUIFujVKWObUk2L
 SF3r+yUppBkIxg0+v4ZnesEMUCqm+pcR1hCCsOpFOKlqrt3ezoCCq7UNcVUYs0IymN/mLqhP7g
 YFojIUdIpikGxltbl1RjBh69NfH271mluP6DLK/PbEWGaS1S+tt2SmmrL4VijLWMuVoLOjuOhD
 8doM2zZGQARpqVxXAAmvFnkCrc2ASrXfchNZV1nnfIcJGO085456RSRwnMiNNfGeGG0YLxeh3w
 PKQ/xe/uFhWwzPV14IQgj6Yn0VhrKvd0PKe2m2X6u0btybORCb4zB6p6hhVHEypYoQZ3VTxj2x
 xBMxD3DCkO56jQITAWG/ZTDA4b/Z8w9w9eltDat0Zi3Vj2Y5nK5/ACeshUdLwIAAA==
X-Change-ID: 20260831-tpm_qcom_driver-d21c720e73b2
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=Dt/Da2/+ c=1 sm=1 tr=0 ts=6b0026be cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=9jRdOu3wAAAA:8
 a=b45o4kL6AAAA:8 a=xG2GeFPYwsRGK1jMldgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22 a=ZE6KLimJVUuLrTuGpvhn:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-GUID: pelnFeDD5Q8fUX7B526EjXzhZ9osDNQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX9eFkjm0UKpzy
 voPLj2EjDy4mwmctsu3J7GF3BQKQQIjXZPBE8S/+9R87zsv9CYzo1FQCamjh1nAq9vNTbbOVjXp
 dc6RtDzktxscrF0Zyu7RJZf9ZmDOBfhKQsTRJXimAgQui/DaMXgj54zMHvTxHc8YVLmVfWceV86
 V5pTHN7LvSTIefFdTRA+ZVWVNisoixy4huING4rqC4WBQJzmsOe7hzB0uaWWwn5lb+lZewLtd3s
 YcQBjV03XpMMs9QSXcbHni2HzCv6E+AZI8maVVs8FpNb388NPLvc1f5hBOnv5PJ0l8h48RnBXCi
 YgmfPi3kagZ+MUaCtsiJsXnpSeA4GtM+fvXUngF+LftcETehFHjud41+psXmoCl1QYEUbzYX19W
 Qf9yXFXYypz0PRG4bla43PXPwIxysCRmz8+6lkF56bVq71kY/Up965YzJtI7LkFHFiDWdm41gx5
 sZISboAuMQpi2+qERtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0MyBTYWx0ZWRfX6Tdlqt48yW6M
 8ioAq7frv0IPFuMeXwVnxDG2dic/6iur+grvnKaYovcJOvJc2V7wDdaZJD3l4vg0PNLQCb+U3zy
 cjbWy3l/PhsoigS5Nm1ezNX1kduIWgg=
X-Proofpoint-ORIG-GUID: pelnFeDD5Q8fUX7B526EjXzhZ9osDNQ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0D1F4443F8
X-Spamd-Bar: ----
Message-ID-Hash: GQDDQPHASNSR2KOYESW52XHLESUGBRIB
X-Message-ID-Hash: GQDDQPHASNSR2KOYESW52XHLESUGBRIB
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GQDDQPHASNSR2KOYESW52XHLESUGBRIB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Qualcomm platforms with a discrete TPM (dTPM) talked to it directly over
a non-secure SPI channel from the kernel. Arm's Base Boot Security
Requirements (BBSR) v1.4 require that access to go through TrustZone
instead, so on affected Qualcomm platforms the TPM 2.0 instance is now
fronted by a Trusted Application (TA) running inside Qualcomm's Trusted
Execution Environment (QTEE), which talks to the dTPM (or implements an
fTPM) on the kernel's behalf.

This series adds a kernel driver for that TA, built on the QCOMTEE
object-IPC transport (drivers/tee/qcomtee/) already used to reach other
QTEE services.

This patch series functionally depends on below(first 5 changes specially)
for qtee service discovery.
- https://lore.kernel.org/lkml/20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com/

Tested on Glymur-crd target with tpm2-tools utility.

Validations:
- Get capabilities
- Random number generator
- RSA key creation, encryption and decryption.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v5:
- Rebase on next-20261119.
- Fix qcom_send_command resp_len computation(Amir)
- Use dev_err_probe in _probe and return appropriate failures.
- Propagate dtpm transfer/end error to callers.
- Fix drv_data after tpmm_chip_alloc call.
- Link to v4: https://patch.msgid.link/20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com

Changes in v4:
- Add new line before goto label(Jarkko).
- Link to v3: https://patch.msgid.link/20261015-tpm_qcom_driver-v3-0-247c8e50250e@qti.qualcomm.com

Changes in v3:
- Merge tpm_qcom.h into tpm_qcom.c(Amir comments)
- Update return values of functions and drop certain error prints.
- Define locality_arg as default value.
- Add Jarkko's tag on all but drop from 2/3 as significant changes done.
- Link to v2: https://patch.msgid.link/20260907-tpm_qcom_driver-v2-0-71a6b1752da8@oss.qualcomm.com

Changes in v2:
- Use QCOMTEE_TPM_UID as 81 for service discovery in patch 1.
- Use FIELD_GET, zero initialised array and log improvement (Konrad)
- Improve commit title and other fixes (Jarkko)
- Split MAINTAINERS entry as separate patch.
- Link to v1: https://patch.msgid.link/20260831-tpm_qcom_driver-v1-0-6f16fa6924fa@oss.qualcomm.com

To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
To: Jens Wiklander <jenswi@kernel.org>
To: Sumit Garg <sumit.garg@kernel.org>
To: Peter Huewe <peterhuewe@gmx.de>
To: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: op-tee@lists.trustedfirmware.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org

---
Kuldeep Singh (3):
      tee: qcomtee: Register qcom.tz.tpm service for discovery
      tpm: Introduce Qualcomm TPM driver
      MAINTAINERS: Add Qualcomm TPM driver entry

 MAINTAINERS                       |   6 +
 drivers/char/tpm/Kconfig          |   9 +
 drivers/char/tpm/Makefile         |   1 +
 drivers/char/tpm/tpm_qcom.c       | 410 ++++++++++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c        |   4 +-
 drivers/tee/qcomtee/qcomtee_msg.h |   2 +
 6 files changed, 431 insertions(+), 1 deletion(-)
---
base-commit: adcad7f4e6332cff3d6d7165f41584899f598534
change-id: 20260831-tpm_qcom_driver-d21c720e73b2
prerequisite-change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014:v6
prerequisite-patch-id: faf4520d818abf0d7533f71d9c8b9a8aade34626
prerequisite-patch-id: b487dfe2fbc076f4815dc6c73b9e68b0b78c961f
prerequisite-patch-id: 9f2c4ee37ba173bdc860f253d44974379f2cf125
prerequisite-patch-id: e86905ac6289821db30fd9a17f73e276e0a88363
prerequisite-patch-id: 09a86ee4de34e0c9cd2e4664c54a6473d7998299
prerequisite-patch-id: a940a0624f1e130d1fe5213952965aa469bf9547
prerequisite-patch-id: 7be993abea2ca36057d9352381a5890f50996dda

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

