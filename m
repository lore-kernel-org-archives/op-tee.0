Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF02606A32C
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DR40gq4a;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T9OLt4h8
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7CE2D4549F
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:15:51 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DR40gq4a;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T9OLt4h8;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7740343A89
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:15:31 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tTIA433415
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 11:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Hp4bEKqWI7wfj4K2NfEGdT
	JMkHoCy6UXWibnNsaxA0s=; b=DR40gq4aq1didjccr8zA4hpt3m+yuTB2q1n7h0
	t1bguggAI7uAKf7xhVqtbnoKt/GEfNoD2ovHcYeek/9T1mC5e0ZKHsvYpNzBSXu2
	PyEJA1TcSsJpzxIvH+Pif9aYiFBcdRyfHOcwz0yTyHUtD9HqBAY8FVcZc+stJa1h
	dQrLimTv+aNnEPCDi1V02zsqMhjnWEqSAOEW/FotaI+tIMoNwQjgoDQBXEVZaUT1
	D4YYTL/ghOCczofrCq94LwtFEVS+oJ1cl5EvRm6QFBfomdWiGYYAH3gESfWErDQk
	t5s80p34HqELHc2uGIIaEEiXo8Id9QRwsGMkH2fnsAiKI51A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrmcd95yf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 11:15:30 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3662e7a9299so6122444eec.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 03:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877330; x=1794482130; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Hp4bEKqWI7wfj4K2NfEGdTJMkHoCy6UXWibnNsaxA0s=;
        b=T9OLt4h8RIHhh3Cst2XNn4VWPRWG/ArLHxBxNi5ZK9t9xmKASsF91LWDa0QaliEE2b
         ePNEo0x+MJ5cF80F+Y9Yvvy6iYraVe/BQ6OpIBxJIX+vn7HLr6Mr4NesGiFKXgfHxFib
         UryuHFwReiKKvEHWcT9htPJnIH57xy+erKUrUyANUF8pi1oviC2VjYRHegae68IDW0YZ
         H6X785BjcrhBWwgNX6YDj1982qMuGFN9Gw8fTrYoOGqVEfVuuqqidD2NKuJZnxNvWDew
         NU7v91BG3LjWuyJWeiL0nuP+2PMGdmxeHWa3z8VOy7RN09bjZ0j184ahrl5OryfEcZ36
         Lv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877330; x=1794482130;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hp4bEKqWI7wfj4K2NfEGdTJMkHoCy6UXWibnNsaxA0s=;
        b=KM5qjDuzfMU8oVVi5VN7RnYNQW+0qdLCPZFh2oq55fXjy929Ouk89hCsLrT4kjFWRb
         0MKepZ+sqvy+prmPxgNA+3AT7dzFACMItFpt4y8ApD+UqD5tRhloU6Di82+o1Tt0oDXR
         8W+WH6hDbMjjhV7G2Dp1R5jCJ6qvgcOEFiwDb+wu+nMI5XdNAioVYI42G/pxwPGJyjbM
         7wlObE8gtnGGLFlG2W9zicLTFTgMbo8+ftNPN/rXdHH/jLM0KxPszuiuaYvFEcsGeXwF
         3RhA9HviR/lue53oKQkwfLO6sSUjemDrlZSQepN2redoZACnPahAqDk4/bwKEwMDcINr
         kVJA==
X-Forwarded-Encrypted: i=1; AKwUvByRZT1O9zI9OP6PQLr1wAOqFOq2t4R/oXQ4BqMpaKv1wZje/2dnHD8oMQE+PKdqdNRawDvfANY=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8bcj5/mnv7jldW/dlw0l4xtXx8r+2F5rMG/tEb7xul9w3D7AEq
	dd8TussXD+fwWUsIfsm1whlA9UJbz37arTD1McOOnEzmTkWSOzOZzXFniu+TbrJGYkDJM35rrUl
	WBUD6d2gLnsIgPzi3gHW2Uy9t3hebtHinfhZ6DZciHQ5kByK97w5fxcSOJnlF23XkrBjOt6Tm
X-Gm-Gg: AYBFou2kWDJdEKGCJ1mLjksvV1qxcKzgjSl15DjSANoQNHmclOjoGVnPfCSTMJnh+qx
	Zr9z7QNpxIWJr+bi1vm7LD0uvWzlzw5rL1J/UgmPlIBovSMqW3tjKvh33gykcoc5ALtm40rhCi1
	znWogptO9grm93nTYquOCP80WFYwUJViDFtW/wHbpQPTTYdXIc0PaBxXOaeRqaqdIEpbRwpYYpP
	NwfUq9WH2B/sicyWqr4s9Pl6aMNzxt/R2OXh6qPAbjH1IWjE9w/BAnWA3B4Mdcg4IGLsdMvMXW6
	l9j7ZfJEoziKyESkpYUXApzdU1TgE/n4HaYpWfn1aIAJoGEFs940eKx559tocPoK6K96Q6hHAZJ
	o4l6C/T3xK63tMwQo5joNruzgECuhXWCyO4QyRVB8Y70HQLlNMXmG17P1zuTLlhsce11p0VHC4w
	==
X-Received: by 2002:a05:7301:152f:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-36a42397b34mr21695928eec.20.1793877329346;
        Thu, 05 Nov 2026 03:15:29 -0800 (PST)
X-Received: by 2002:a05:7301:152f:b0:36a:12c1:3adb with SMTP id 5a478bee46e88-36a42397b34mr21695871eec.20.1793877328460;
        Thu, 05 Nov 2026 03:15:28 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm14002125eec.18.2026.11.05.03.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:15:28 -0800 (PST)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Subject: [PATCH v6 0/7] Add TEE based client driver for UEFI Secure
 Application
Date: Thu, 05 Nov 2026 16:44:48 +0530
Message-Id: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAChl7GoC/4XOy2rDMBAF0F8JWtdhRq/YXfU/SjF6jBNBHTuSY
 1qC/71SCsWLGm8G7jCcuQ+WKAZK7PXwYJHmkMJwzUG/HJi7mOuZquBzZhy4Bgl1dXND396pC4m
 cGce2D+doJmrLfiKqUNS68VIRoGRZGWO+/Xp+eP/I+RLSNMTv58MZy/bXPsFp156xgqrTqnHWK
 w/SvQ0pHW9385kP+mMerLyY+YrlfJ/lmbW1qTtnSXLEDVb8sQiA+6zILArfKcfBcRIbrFyzep+
 VpW2HriZutDR2g1UrFtU+q0pbqUE3aIXy/7VdluUHyK4zNjECAAA=
X-Change-ID: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877323; l=9136;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=I5Uz1t72Eoq83ZK5mZFHZEMRcQv4j80APEPi/qe5Dfc=;
 b=OGpEuivX6ZudS+gx7nYHMwN9Rb1rJFT6RBGR5ah0+fJ0BUnFyAeF2tc1gJKFCfKFViHDhq/JM
 CHfjS3m7Ns/Ayoqi+4RIWIPB+Aqex/O6atqRBid5FkEM+pr9fnnZKzs
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=EOGTQFZC c=1 sm=1 tr=0 ts=6aec6552 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=NEAV23lmAAAA:8 a=EPKcpx9xAAAA:20 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=VctfPk_oDqlEa1PX-fEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=d3PnA9EDa4IxuAV0gXij:22 a=ZT_8zCgGubuJgGonBfBE:22
X-Proofpoint-GUID: wPLfX0mp8kOVonpqc94S15439AF5sebS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX+XI04aJm9mwF
 JWr8Bs7vMno0UgId258kzVWga22NpQUAJwwF5kBLp+OqIXpmGysc8OL3BNeKbPmFjbvUBTC7mYA
 Js3JohvFToo5+LxISrBV0rju/Y6U/KM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX8VuBpPIcn/+l
 88yTYRZZA+FcdCrUlJ2zJqPltA1atlu+8VkYRQHqL4MnLhPghmYQtCSFXRY88zYG1R3pgXJdnWb
 rMyGGMCYxql2sxAP8MJjBgyuXLckKxaaV5b8g3JmB3qZh+uja7KjC8VIhryDC2vxCIoHtTW9URh
 oFxtqbgrsxo7Oi7bAIEQ02++rzLMsnJ7gWzU2346IwnzLfkS8JKZ6Iu/wQCnGuFmwqnvBktuMwt
 FpF1Sv0vokhRjovh/s4/tVpGz6VcyhrNJl8VtFrC4zB4OGQRreZervZ7r+YY6IdfIXU3IZLFWq+
 52Fo+pPkatfnmVF3umRHJNK2oCp4JBZSkLIDGv47k2njLJya15oOrEaxUcuCzKEAm8W7QQL4iGJ
 JY3LlFze12XRFIZFtZR18EF7dbkg0pGhML9Vpw2XJFt7EwA6Ae+YAsVHAIuElOEJl+/cDaSwJEf
 721EJwlb2Y3/05ryrJg==
X-Proofpoint-ORIG-GUID: wPLfX0mp8kOVonpqc94S15439AF5sebS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REDIRECTOR_URL(0.00)[shorturl.at];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7740343A89
X-Spamd-Bar: ----
Message-ID-Hash: U2UIOAQSBXGYISP4BEYKFDEGA3OHNFDH
X-Message-ID-Hash: U2UIOAQSBXGYISP4BEYKFDEGA3OHNFDH
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/U2UIOAQSBXGYISP4BEYKFDEGA3OHNFDH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Qualcomm SoC based platforms, UEFI stores EFI variables within the
Replay Protected Memory Block (RPMB) located within either the UFS,
eMMC or SPI-NOR storage. The RPMB key which is one-time programmed into
the storage controller to allow authentication of the RPMB frames is
generated by and only available to the Qualcomm Trusted Execution
Environment (QTEE). Thus, only QTEE can prepare the RPMB frames which
will be accepted by the storage controller.

The legacy QSEECOM protocol used for communicating with the QTEE is
deprecated and replaced with the use-case agnostic SMCInvoke protocol
starting with the Qualcomm SM8x50 series. On platforms where the QSEECOM
protocol still works (the QSEECOM driver probes) the driver does not
support a listener interface with QTEE to enable writing of non-volatile
EFI variables (via listener requests to Linux from QTEE) to the RPMB
for UFS and eMMC storage. (Qualcomm Compute platforms with SPI-NOR storage
are an exception to this and work with QSEECOM, see the NOTE below)

Therefore on such platforms, a TEE client driver (which communicates with
QTEE via the SMCInvoke protocol implemented by the QCOMTEE driver
registered with the TEE subsystem) must be used to update such EFI variables
through the RPMB service hosted in the QTEE supplicant user-space daemon
[1] which forwards RPMB packets to the RPMB device.

This series introduces such a uefisecapp TEE client driver for the
aforementioned Qualcomm platforms which installs efi-var operations _if_
the QCOMTEE driver registers support for an object-IPC based uefisecapp
service on the TEE bus during its probe. Only new QTEE firmware versions
available at [2] provide access to the uefisecapp service via the SMCInvoke
protocol.

Thus, QCOMTEE now maintains a static list of always-available object-IPC
based secure services exposed by QTEE. These services are implemented either
within the QTEE kernel or within a pre-loaded Trusted Application (TA)
usually loaded by the bootloader. The uefisecapp TA is an example of a
preloaded TA loaded by UEFI. A static list is required since QTEE does not
yet expose any way to dynamically query and enumerate the services exposed
by it.

To facilitate object-IPC interactions from the kernel-space, this
series also introduces a tee_client_object_invoke_func() to allow
invocation of TEE objects similar to the existing tee_client_invoke_func()
API exported by the TEE subsystem which allows invocation of TEE functions.
Some suporting changes are also introduced to track and handle operations
for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
driver.

Finally and as previously mentioned, access to the object-IPC based uefisecapp
service is restricted on older QTEE firmware versions. A new QTEE firmware
release must be picked up from QArtifactory [2] for all upstream supported
Qualcomm SoCs to enable access to uefisecapp service via the TEE client
driver.

This patch series has been validated on Kodiak RB3Gen2 platform with UFS
storage by attempting to read/write EFI variables via the efivar tool [3]
after mounting the efivarfs filesystem. See [4] for an example.

NOTE: Since Compute platforms do not have a firmware running on their SPI-NOR
storage controller which must be programmed with a RPMB key, QTEE has a
SPI-NOR driver which holds the key, and so the QSEECOM driver can be used
for updating EFI variables on these platforms because QTEE never makes a
listener request to Linux (QTEE doesn't need the Linux SPI-NOR driver).
Such platforms are outlined in the following static list [5].

Merge Strategy:

This patch series could either be taken from the OP-TEE tree or the
QCOM soc tree. I would prefer it to be picked by the OP-TEE tree since
all except the uefisecapp TEE client driver patch in this series make
changes relevant to the TEE subsystem. It would be great if the QCOM soc
tree maintainers can Ack the uefisecapp driver patch.

[1] https://github.com/qualcomm/minkipc
[2] https://shorturl.at/zQU07
[3] https://github.com/rhboot/efivar
[4] https://docs.qualcomm.com/doc/80-70020-27/topic/manage_uefi_environment_variables_using_efivar_tool.html
[5] https://elixir.bootlin.com/linux/v7.3-rc5/source/drivers/firmware/qcom/qcom_scm.c#L2302

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
Changes in v6:
- Fixed un-initialized *result in qcomtee_object_get_service().
- Introduced .set_variable_nonblocking() callback stub to ensure client
  is aware nonblocking variant is not implemented.
- Collected Tested-by tags from Kuldeep for Glymur-crd device.
- Link to v5: https://lore.kernel.org/r/20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com

Changes in v5:
- Fixed comment in qcomtee_object.h to drop '+'.
- Removed duplicate function doc for tee_generate_uuid_v5() in .c file.
- Fixed qtee_register_services() doc.
- Dropped unused QTEE_UUID_NS_NAME_SIZE macro.
- Optimized qcomtee_uefi_query_variable_info() to drop redundant stack variables.
- Migrated to block comment format everywhere in qcom_tee_uefisecapp.c.
- Drop comments which highlight obvious stuff in qcomtee_uefisecapp_probe().
- Collected Reviewed-by tags from Amir.
- Link to v4: https://lore.kernel.org/r/20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com

Changes in v4:
- Fixed kernel test robot warnings with gcc v16.1.0 [-Wvla-larger-than].
- Update parameter docs for qcomtee_object_invoke() and param_to/from_args().
- Split the defconfig change enabling the UefiSecApp TEE driver into a separate
  commit.
- Use pr_debug() instead of pr_err() when QTEE says it does not implement a
  service being enumerated.
- Re-name qtee_enumerate_service*() functions to qtee_register_service*().
- Collected Reviewed/Acked-by tags from Sumit.
- Link to v3: https://lore.kernel.org/r/20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com

Changes in v3:
- Updated the cover letter and commit messages to highlight the following:
  1. Only QTEE has the ability to prepare RPMB frames since it generates and
     holds the RPMB key.
  2. The QSEECOM protocol is deprecated on new platforms and so this series
     migrates the uefisecapp to SMCInvoke which is a use-case agnostic, transport
     focused and easier to maintain protocol.
- Use single if statement to update both flags and addr/uaddr.
- Remove redundant use of new error variable in qcomtee_get_qtee_feature_list().
- Minor fixes such as concise error prints and use of better error codes.
- Fix a double free in qtee_enumerate_service().
- Re-org the qcomtee_enumerate_services() function to re-use the same oic and
  client_env object.
- Remove depends on !QCOM_QSEECOM_UEFISECAPP from Kconfig since both drivers
  can co-exist even on platforms that support both QSEECOM and SMCInvoke protocols.
- Update the Kconfig description to better help the user understand when to enable
  the TEE based uefisecapp driver.
- Removed qcom_tee_uefisecapp.h file and inline the header in qcom_tee_uefisecapp.c
- Rebased patch series onto the latest linux next tag: next-20260930.
- Link to v2: https://lore.kernel.org/r/20260722-qcom_uefisecapp_migrate_qcomtee-v2-0-b8a8fcbe4211@oss.qualcomm.com

Changes in v2:
- Drop using MSB of the object_id to distingush kernel and user object invoke contexts.
- Introduce enum tee_object_invoke_origin to check the context of object invocation.
- Link to v1: https://lore.kernel.org/r/20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com

---
Amirreza Zarrabi (2):
      tee: Add kernel client object invoke helper
      tee: qcomtee: Allow object invokes from kernel clients

Harshal Dev (5):
      tee: qcomtee: Track the object invocation context
      tee: Export uuidv5 generation for TEE backends
      tee: qcomtee: Add support for registering QTEE services on TEE bus
      firmware: qcom: Add support for TEE based EFI-var client driver
      arm64: defconfig: Enable UefiSecApp TEE client driver for Qualcomm SoCs

 MAINTAINERS                                 |   6 +
 arch/arm64/configs/defconfig                |   1 +
 drivers/firmware/qcom/Kconfig               |  31 ++
 drivers/firmware/qcom/Makefile              |   1 +
 drivers/firmware/qcom/qcom_tee_uefisecapp.c | 654 ++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c                  | 210 ++++++++-
 drivers/tee/qcomtee/core.c                  |  10 +-
 drivers/tee/qcomtee/qcomtee.h               |  10 +
 drivers/tee/qcomtee/qcomtee_msg.h           |   1 +
 drivers/tee/qcomtee/qcomtee_object.h        |  16 +-
 drivers/tee/tee_core.c                      |  34 +-
 include/linux/tee_core.h                    |  23 +-
 include/linux/tee_drv.h                     |  18 +-
 13 files changed, 970 insertions(+), 45 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

