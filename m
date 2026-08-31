Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E995AC624A4
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 15:48:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 14CD145363
	for <op-tee@archiver.kernel.org>; Mon, 31 Aug 2026 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1788191298;
	bh=YuKf4TfuLSdGcJuTuRIIpFh/EgM5srvGQvIHuE7PH7w=;
	h=To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=KbTKlSzJVITf42dKD45/MLRCPz/Hlq6MnOMxJKgPlJS7J0jSog5FBrUYr1hr/qiH4
	 6PY1pphyV4zMl63CkJVVNPPKojX0CyB7oxJ+owSYhUS/7SvsteQLAzK+uuLuHU2jiu
	 UZQ9lbh0sz7MPVxthFBvg6/exFWQQd/5CsRPPZrt6q8SkSjaXESXl3abJrf/9eSu5m
	 ITttWzSG4c97z3g2MA3bB6qNb+FVo8PTRd4/0bqCEUB/Sg18liszjtbTm2/7oOlSFn
	 U2QbE5T9i7YbGk/UVsSpT5q/9VgW9ziy3nsRY+Msc6bA0bNd93W8dx0XDlXQEQT9PC
	 a2dZMTTYTZL0g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 267E844DCE
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mU3lnRsN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OQFAw+oU;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VETQKr3296595
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=QHh/nIGzCoRgzWrKEq4S+OEYLKw4ImM5Urz
	S+/gfDoQ=; b=mU3lnRsNSYlMYCEIiPZ3eu+N7BYcecUPtZgG4kBAeXFPD30iZ96
	9RfRKS9iOaqgtBkcYcnacwRFBO9kvL7+wR6/KA5l5IyQF0Dqb/oyV0yKt8S515Yb
	Hj+uhvT2Y8N9it8VbFGFLFgJorRoq+jbvqquAb6MNUHnLzX3Xwn4zZ51HsfRHenK
	5Hu/bsd7C9bPdnn62stacyujdVphdHpdzKdngy9Jp9G8K8fgbEMmxLQNI37nYljz
	FXq1s6F1EaswEFr0PbQwnrQWaThoKPiXK0pdp29+8OFoKMlcx3g/npHAqlATRX9S
	kxBrgbTV0eyG3vyU9zo7o9w6O4DqGCD82Jw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6ayhqgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 15:48:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930edb4362dso490527285a.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 31 Aug 2026 08:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788191290; x=1788796090; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QHh/nIGzCoRgzWrKEq4S+OEYLKw4ImM5UrzS+/gfDoQ=;
        b=OQFAw+oUt76IebGcBP73R20o/Grvg4erdpyxdYZXHUYjsK2sKjUlxT5Zzd/SKF5ZWW
         MITfx6zSkx6Q+hR61uukLX/N1l1YxD0l0bXVKdiqUKDEgG3+kq8Unnk5tKbeIh3/j8gx
         tHlJtb44mRVvW4pHew0i4TJoqz40mqd3WR8WMKPpk2Tunic/qYaDYfDAzU+YJ/2GxatS
         cEoipgsxv+38eukRw/x9ub9DWm76Liw3MnkyBzMKh9sOTjC14d0lNppwzbN5BLDzEzHU
         JjGVgZ5xkXn4x9GXiQO6rcat/IF86i5vhuTVqANUC/RmEEPg9Nx59KAG2rMOsdsiztyV
         2jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788191290; x=1788796090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QHh/nIGzCoRgzWrKEq4S+OEYLKw4ImM5UrzS+/gfDoQ=;
        b=MQ0GQeAXYAT8Boq/lEinddg17GwHnEJhJTOl485SUJ4xsvEcCD38/sUFuSpNFpd0dc
         JrD2V/5GyzkpsNzDvUuRJbniFAIzWXRAEAjxj52Yfp94d0wtcR/hqguLX30zARQvrOVD
         dwdj9cPYP5qQprmipyp+WUoOOCG+cg6wFFyXw/PJKF2oKQzFDfOFVxS4lGw8lbN0h8x8
         pz4S/MGhIfGu3yhlrr6Mqx3iKda6OyZbm8/4f+VeUprqLDGi9ODMOzhDmezLsrPZ9Cct
         NyvrqvAwx/mi3DtpngKQu7fNWpHp43Z0HaxLKwjc7WBactxwZShGM9CB/CY91cRahojn
         FTUg==
X-Forwarded-Encrypted: i=1; AHgh+RrrqstPomAgiMH1xY5ra63YYjtlfMEIFCx2lgOetbIO3MQqmNh5FSXLuXrENuEBIVPBRbTe90o=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mGKgo9RfoNmuK9OWGTqgw/4sCZIaKEcbct3+Pgf/ESSAhbYx0m
	OaPqVmFu+8wDkhwCsBA2rYOwrFT3EzwZ8q9yVtd77NMMVoyV3XcMZ7zP0/yUKpGUXK1B45onIb1
	D0ZV2bgoOeQy0qxTow7aKYL0jxi+Nq5jt1NydWCK/XSqVItLJC5O+gTIKavbgWlp57L/knbPU
X-Gm-Gg: AR+sD110P6R+pFep64t3N2qUwqLC9jOUPeAl4ThZibZfCtRfGgGXZ2qZA0wN3x4JOJl
	fvW+XEkaXqkNEEBtaDjxut9hOZssGliqwz/pgna2FTQDP3PQVVPgAsmNzXENRwXqFmge6t9ynoT
	6VpfioYjIfttT2gNc5+8az8D3vuztvT+/ok0vmGtjMU5z0QOtVtTwf3fovYJwZyOBvvneIZHJdo
	mP6w8//5zLmQ3bUZS5drXCIzN3Var5TS4SGK689LF70Hg5Xwcczp32ZIY/vKbBqfZBICFnDMSwP
	uNnU0lv58CHSXhMg/q5ORRiD7+D5D/JiPDIthyDalW+3qAfJGf0FMxgYcGks0AFKQT0lndm705E
	d4sJ+VE0a4v8KjBzxoym3Fe8JcMooRM5v3WOuPP7/Zl9416A=
X-Received: by 2002:a05:620a:40cb:b0:936:cda7:554d with SMTP id af79cd13be357-93913798773mr3050738385a.14.1788191289503;
        Mon, 31 Aug 2026 08:48:09 -0700 (PDT)
X-Received: by 2002:a05:620a:40cb:b0:936:cda7:554d with SMTP id af79cd13be357-93913798773mr3050728285a.14.1788191288866;
        Mon, 31 Aug 2026 08:48:08 -0700 (PDT)
Received: from trex (250.red-81-38-139.dynamicip.rima-tde.net. [81.38.139.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce0b456sm1558315e9.2.2026.08.31.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:48:07 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, stanleyjhu@google.com, beanhuo@micron.com,
        beanhuo@iokpp.de, James.Bottomley@hansenpartnership.com,
        martin.petersen@oracle.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, can.guo@oss.qualcomm.com,
        sumit.garg@oss.qualcomm.com, jenswi@kernel.org
Subject: [PATCH v5 0/2] ufs: rpmb: make RPMB usable with OP-TEE key derivation
Date: Mon, 31 Aug 2026 17:47:59 +0200
Message-ID: <20260831154804.719528-1-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX8c8XRzG4fzaa
 hw9alX2TpahidkIglPAtzpkYY67VaTyI/swAeVSoTZNtC7/tRN35/8yN7cCOHSU12NyT82jyrTy
 oLCRM7qzx2HLAI9LCzJrwL15d8PW5Cc=
X-Proofpoint-GUID: c_vKSYoxnTEo6Q29GSTfWdRe9k3wgnBJ
X-Authority-Analysis: v=2.4 cv=CYE4Irrl c=1 sm=1 tr=0 ts=6a95a23a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=N2KLPU99T7rsMuN2xAoQUA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=_EMmJvYMAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=NEAV23lmAAAA:8 a=wgeUl87hhcvhY68aDoIA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=PEH46H7Ffwr30OY-TuGO:22
 a=emCv1hD2LFd8cNRmW21v:22
X-Proofpoint-ORIG-GUID: c_vKSYoxnTEo6Q29GSTfWdRe9k3wgnBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzNSBTYWx0ZWRfX+y7HICN6x17P
 WNlaJx8BY7el8KIrDR4GJ4QOKQuIWKJpfSI72IaIyP3Pqq6x4Q6a2G2LpbWw1DkU5Wh2xlIZsnv
 A9GoJ3fK8bvUKSUNXD30mPxA4u5lhn4J0KpVqbpdYh771M/wZgGDKIM9uQYTwbXGRiRJerGUUTu
 FYNNPQBz1NhTC/32Luhg9gCuTtZe/Grawz+AsyGr5k8JWDqReywlz4LSR5s8DnhlcoQmMpgWfwk
 qgBAkF/b8XtWkCJxxPCAmDGavf9Y2KLJMycKbAi3UEwwI1xDy17sUZC6CesiHoeQe814bS789Wc
 yqow7bh0/K4ITiAEaq2uEeXYayIANmC/HplhTpQBRaxYi+ncegF8I/FfygnFYmXJkp5zia7u87g
 HaG8SZ0MJPPchO4wlAEiiKFqFZoWYXGim3TcKOMT4jaafsmsmTVRRpZMri/XEHQ4buoowIt5C53
 2KFSPDeP2L1UhJbj/Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310135
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[81.38.139.250:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 267E844DCE
X-Spamd-Bar: ---
Message-ID-Hash: TU2CFJOLDHPTHLFSBGLEUDJGDPOHHOOL
X-Message-ID-Hash: TU2CFJOLDHPTHLFSBGLEUDJGDPOHHOOL
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TU2CFJOLDHPTHLFSBGLEUDJGDPOHHOOL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez-Ortiz via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

This series makes UFS RPMB work out of the box with an OP-TEE that
implements the standard eMMC RPMB key-derivation flow, without requiring
any fundamental changes on the OP-TEE side.

RPMB provides an authenticated, replay-protected storage area whose
security relies on a secret authentication key. In our setup that key is
never exposed to the kernel: OP-TEE derives it in the secure world from
its hardware-unique key and a device identifier (dev_id) that the RPMB
core hands down. OP-TEE's implementation targets eMMC, where dev_id is
the 16-byte eMMC CID, and both the fixed length and the raw-CID layout
are baked into its key derivation.

Two things stand in the way of reusing that same, unmodified OP-TEE flow
for UFS RPMB:

  1. On a cold boot the very first frame sent to the RPMB well-known LU
     comes back with a power-on UNIT ATTENTION (ASC 0x29), which the SCSI
     core reports rather than retries. RPMB has no earlier guaranteed
     access that could clear the condition first, so RPMB fails on every
     power cycle. Patch 1 asks the SCSI core to retry the power-on UNIT
     ATTENTION on the RPMB WLUN.

  2. The UFS RPMB id is "<device_id>-R<region>", which is variable length
     and longer than 16 bytes. Passing it verbatim would tie the derived
     key to a length OP-TEE does not expect and diverge from the fixed
     eMMC CID ABI. Patch 2 hashes it into a fixed 16-byte dev_id with
     blake2b, keeping the key stable and unique per region while matching
     the eMMC CID layout OP-TEE relies on. The hash algorithm and input
     string are thus part of the key-derivation ABI and must stay stable.

With both patches, UFS RPMB is functional from the first access after a
cold boot and derives keys through the existing eMMC-style OP-TEE flow,
(requires minimal OP-TEE changes pending on the CID proposal done here).

Tested on IQ-9075 with Open Firmware [1], pending OP-TEE changes
[1]https://ldts.github.io/qcom-buildroot

Dependencies:

U-boot:
https://lore.kernel.org/u-boot/20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com/T/#mc423eb4dcf8a15849077029e4f7c1913bb7d8873

OP-TEE:
https://github.com/OP-TEE/optee_os/pull/7881

v5:
  * added Reviewed-by tags from Bean Huo and Stanley Jhu; no code change.

v4:
  * ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN: open-code
    the power-on ASC 0x29 (with a naming comment) as the rest of the SCSI
    tree does, instead of a UFS_RPMB_ASC_POWER_ON define; add a
    UFS_RPMB_UA_RETRIES define for the retry count; reworded the commit
    message.
  * ufs: rpmb: use a fixed-length RPMB dev_id: reworded the commit
    message; no functional change.

v3:
  * ufs: rpmb: use a fixed-length RPMB dev_id: hash into a stack buffer
    instead of a kzalloc'd one; rpmb_dev_register() copies dev_id, so the
    heap allocation and its cleanup were unnecessary.

v2:
  * ufs: rpmb: replace blake2s with blake2b so that the same support
    can be added to u-boot (CRYPTO_LIB_BLAKE2B)
  * added links to U-boot and OP-TEE changes.

v1:
  * ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN:
     - fix using uses SCMD_FAILURE_ASC_ANY to retry any Unit Attention
     - fix unused variable
  * ufs: rpmb: use a fixed-length RPMB dev_id
     - fix selecting a non-existent Kconfig symbol

Jorge Ramirez-Ortiz (2):
  ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
  ufs: rpmb: use a fixed-length RPMB dev_id

 drivers/ufs/Kconfig         |  1 +
 drivers/ufs/core/ufs-rpmb.c | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.54.0

