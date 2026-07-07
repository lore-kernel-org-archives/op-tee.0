Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDA8C43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:12:10 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E7EC244EFF
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783404730;
	bh=JFXGqCGu2H92EhpiiWXQPFhlBhyUzeEGrMTelGV5S+U=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=TC9XHTikJhVzREKDD+ImubElHxx0JKmW9YBoCqsgBvEJFV7Z0p9Hwm+fMLYIa5sHU
	 KspN2ov28PQ9i4xhW4Lv00Q1/0AGdQfe0WRnsj3LzAw5Eqc6VmZrTYfUTAquaV+HFa
	 N51jAhoVZSw/tWgqgXJmwNoERpw29fA2nCf7Qrlf2l55f2LobHGaCIExz1OKLfGCQ9
	 xmuf6K68XlugVp0qRpNjagfH+c19EzOP/TDz9I8DcoBopS12VAilTEBfjrAnJDkSjk
	 M3S7yO4TNAf9gb/Yi25kddjaLg21iksl/W+bjVGbEVOJ6Ft5RM1Hg1CYugxCuyLghi
	 mmSFxpWxX0awQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3E92643815
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 06:12:02 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cB3CzkSC;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PPZdPBEr;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748uvg2688424
	for <op-tee@lists.trustedfirmware.org>; Tue, 7 Jul 2026 06:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HINMq122UHv1BM0ydfXCtB
	Iu1L4J+lad+rQZ2QvoAtI=; b=cB3CzkSC6FeLPR1/Mw+Z3rbhUBtZNG0XIUg3Xc
	HGzNUk4xCM/TPQQxCbaXjXnObCkBCPjWHrPo4Am0TcA+WxwI/zuYKBIL1Rwi2Bxu
	CUKD8jqHXADvvR1PIo1hgV6uH/YiJLB1LO0an28yf6DxfxJPVQ/QoOAuNJZX13EB
	N6ZyZ8wKXsClaU28AD+NvVt9gAdjuRjI8OjyLNE7ftDpKNUkNsX3FJXLtKmjDqiY
	fOu7bczap3xJZiJ492PWSWDYqND/g5I6QZbPNucml7NXNYed0GIQICAv9Q0vPa+V
	iHp++KGwbA/B+6bLzGVY9Zh+ROGP6Zst7ccans9YqLLvWv4A==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gvess-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 06:12:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8478ff5d801so7118825b3a.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 06 Jul 2026 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783404720; x=1784009520; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HINMq122UHv1BM0ydfXCtBIu1L4J+lad+rQZ2QvoAtI=;
        b=PPZdPBErO2558gumHnb6H1bCkolIvi8a6L4kh9M9pVE2jSUOgoczZDBB1M4gdRoWta
         4K1oEwopVKku0+02Os0Wmik1HUqEXvxOeDTKiNINtRsx8oaCf8uIYkMfwcAhuJDlxFyd
         KJkyec8UDg21u7VNZBvwGeRpdYAtlLdpYnmY4VLYJ2XVphD5EHZbAP/YeYS9xJlgBwgY
         /7jXrpwG+8uc1q3jeO/rl3JAk7+h5LdinR0fVfc/IaUF62pxfl4LGj77EuiqAPJPbJaO
         USp50OkZOXKShwZWTlNxA7EZQQ8RxgQ/pZEsOVrIvgPTx9Ac5uvSbpq0DdfE9yLzM4jp
         Oxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404720; x=1784009520;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HINMq122UHv1BM0ydfXCtBIu1L4J+lad+rQZ2QvoAtI=;
        b=UkWsF+jLc6Zcp3bJ/Vv93czASwEBWVR5vItTAuBgY97kOnqs/UjraiNAXUCkcXKlU4
         rMqkuDVbs6w1WDJdc4k40KgXIfFxktzbm91faFBWVUNDSRz12xvCPwkRTtCq1sJY3jIa
         tCfpSo25c5xA6gwi0kARYJ2+prxvvPmSn15L/lpOrTmMgGhrkUiDNA80z2iIqWG8WctS
         DdT0ztoOCMX+lP2KLeSEFnsZM70IfD47ae0Tb7HutLLQWP/s2WqQbvDTafEqQUBn8Ueg
         b1DHUIPupTgL90Jt0yr6nWZEL1qVdY+O2FafBAkJhX/tS3jgshryZ+f4LBzS7V3HKMQm
         FlOg==
X-Forwarded-Encrypted: i=1; AHgh+RqiIkLMTyajSXZYMCkwt3OyJArS/ptd36063Q9taYEQ51Y4YeCl/cZ84jwrdPv68XWDnJx4EzU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxrjAoO7G9bmNwHi9omlmFaxKIKwnTiajV0KIzwTHutsqKBJwsQ
	vX6STiOZT7F9qbwN6ZB1HdgKS8UkgsGRg9CSXjl5FxUb0VvaxTwPLLSoR6t4Ha2VkwUVD2Y8N0t
	MLcUbclEhCB92EWj67FSXkQ3cvuxipEAyl37O0wwWzcQy3sJpL7vmQhYUm/of9MGN1BJ3Mvoo
X-Gm-Gg: AfdE7cn47RHcEsF9dti22Dvwn6fBlsjp/oQ77siMMcK7mxhuATbSsO0uAkqguwPMdgj
	LXvrUeh31aU1TIHNznp0keeIuaEe0wIP3rAGTXTh49YcVZJousfKqOvTapoGysvf4n+ZF86k+x9
	dVamXqGtMIQ4E1sBjaQH/mn/dbOQ5uhXmmv14Oo8gRz8ohTizeZfl3DlCZlWN56OTh6UYOAD6Gf
	DlLtUikoFgOc4LW1ypeDofNWtALu4ajFWbILrcBNBo4FcyAPVNqd7V/oKQlTqb7rPKtsEBje8Vc
	HYLu8yR6njATLfEBTBGrcjPPL9ynSiR76M2y7rwMZMViWGOOgi7ddZwyFHjynt6ilGkpQ6vIxp7
	85aCgDinUqsitCnomyjGmZz9z1aUKAg9X+zXM
X-Received: by 2002:aa7:888f:0:b0:845:d2e3:263d with SMTP id d2e1a72fcca58-84826e23a4cmr3586100b3a.55.1783404719976;
        Mon, 06 Jul 2026 23:11:59 -0700 (PDT)
X-Received: by 2002:aa7:888f:0:b0:845:d2e3:263d with SMTP id d2e1a72fcca58-84826e23a4cmr3586073b3a.55.1783404719452;
        Mon, 06 Jul 2026 23:11:59 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm3299321b3a.8.2026.07.06.23.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:11:59 -0700 (PDT)
Subject: [PATCH 0/6] Add TEE based client driver for UEFI Secure
 Application
Date: Tue, 07 Jul 2026 11:41:26 +0530
Message-Id: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI6YTGoC/x2NQQqEMBAEvyJzNpBoFPUrIiHEVuegxkRlQfz7Z
 vdYTdH1UERgROqyhwJujrxvCVSekVvsNkPwmJgKWdRSy0Ycbl/NhYkjnPXerDwHe8L89hMQqmz
 qdtQVpNKUXnxI7udf6If3/QL3yLdGcQAAAA==
X-Change-ID: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783404715; l=5039;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=JFXGqCGu2H92EhpiiWXQPFhlBhyUzeEGrMTelGV5S+U=;
 b=dVY42OrgfUJyFWtbinXJzW2iuRrRIcONitvA1Il7l21EQnP9ev/NCpeiFZ6MREvVXrIFc6om/
 CuZK8NGA7gVDiq2k20hJaE188RBI801eAQdLnpq/dIAWqqE12rbcbSS
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: tUcmowNKpJA0uQwEzbcHro9r9lblkBBe
X-Proofpoint-ORIG-GUID: tUcmowNKpJA0uQwEzbcHro9r9lblkBBe
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c98b0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EPKcpx9xAAAA:20 a=EUspDBNiAAAA:8 a=nyFiw0sUOsifHlYUkUwA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=ZT_8zCgGubuJgGonBfBE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX33K+cTwgr7B/
 FyPuL0c5UpRVFvlGKIvt0K0pg4vTFdWafTUBMJxgdQnfY0GIppZb1PHq8SUW46v5vKd6bqpaYXJ
 Xc4IAAkLHdv/5XTrmGbdOpo7Zx/tu9+DT+1VcQibfch3nHmht3t1i2F0cM12XGqIMFV60YW97QL
 bakwtMt3XjB/z7sxOB8ySD66olNzwgOYDT/9To7lenbiOwQZCEL+0n3DfrwORfjyEB65XE057Vu
 kNXDstFFQLnli0LO1L367FbzsMwxMkUR7aG8r1dzIsghbxBL9fTKmd31OipVeEbxgVQNidTYMhp
 cMIMU5uxVhgoXOS35GO+KWkaoogaz1PfxWS49LWqUkSK5/N0PYhbLXrIZiKm9hU5aVhxytYoW8p
 md8LJu/ff9I1spq5Z/FsVWa1YJXfUBotboovA7shx6ivvBgayJmV85vn7Pb+lCRx2k486fFgVL8
 38bDr2CxMORCFKg+Rkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX8+LKffkGx09p
 6ufZa4BUl+1G25b2/V6WQkeLZ11Feu13wuNL/UpknJzSdC0QmYXtH9YIulL75/H/aBSgzjGzNhF
 mSY+mNdxxNdXGHoAoGTJMyReigcM8Ic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	REDIRECTOR_URL(0.00)[shorturl.at];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3E92643815
X-Spamd-Bar: -----
Message-ID-Hash: 2NU23NBN6GD54QZWG76IAO7LQFO6VG67
X-Message-ID-Hash: 2NU23NBN6GD54QZWG76IAO7LQFO6VG67
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2NU23NBN6GD54QZWG76IAO7LQFO6VG67/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

On Qualcomm SoC based platforms, UEFI stores EFI variables within the
Replay Protected Memory Block (RPMB) which is only accessible by the
Qualcomm Trusted Execution Environment (QTEE).

For Qualcomm platforms without emulated RPMB support, specifically
platforms where RPMB is not located within SPI-NOR storage and instead
located on UFS/EMMC storage, non-volatile EFI variables can only be set via
a callback request from the UEFI Secure Application to the RPMB service
running in user-space (within the QTEE supplicant [1]).

Unlike the QCOM-TEE driver, the QSEECOM driver (used by the current
QSEECOM based uefisecapp) does not support callback requests. And on
certain Qualcomm platforms such as the RB3Gen2, attempts to access the
QSEECOM interface fail due to lack of support within Qualcomm TEE.
On these platforms, a TEE based uefisecapp client driver is required to:
1. Access cached & volatile EFI variables stored in uefisecapp's memory.
2. Ensure persistence of non-volatile EFI variables via writes through
the RPMB service hosted in the QTEE supplicant.

This series introduces such a uefisecapp TEE client driver for the
aforementioned Qualcomm platforms which installs efi-var operations _if_
the QCOMTEE driver registers support for an object-IPC based uefisecapp
service on the TEE bus during its probe. Only new QTEE firmware versions
available at [2] provide this support.

Thus, QCOMTEE now maintains a static list of always-available object-IPC
based secure services exposed by QTEE. These services are implemented either
within the QTEE kernel or within a pre-loaded Trusted Application (TA)
usually loaded by the bootloader. The uefisecapp TA is an example of a
preloaded TA loaded by UEFI. A static list is required since QTEE does not
yet expose any way to dynamically query and enumerate the services exposed by
it.

To facilitate object-IPC interactions from the kernel-space, this
series also introduces a tee_client_object_invoke_func() to allow
invocation of TEE objects similar to the existing tee_client_invoke_func()
API exported by the TEE subsystem which allows invocation of TEE functions.
Some suporting changes are also introduced to track and handle operations
for TEE contexts opened from the kernel-space in the back-end QCOM-TEE
driver along with associated changes in user-space libqcomtee via Pull
Request [3].

Finally and as previously mentioned, access to the object-IPC based uefisecapp
service is restricted on older QTEE firmware versions. A new QTEE firmware
release must be picked up from QArtifactory [2] for all upstream supported
Qualcomm SoCs to enable access to uefisecapp service via the TEE client
driver.

This patch series has been validated on Kodiak RB3Gen2 platform with UFS
storage by attempting to read/write EFI variables via the efivar tool [4]
after mounting the efivarfs filesystem. See [5] for an example.

Merge Strategy:

This patch series could either be taken from the OP-TEE tree or the
QCOM soc tree. I would prefer it to be picked by the OP-TEE tree since
all except the uefisecapp TEE client driver patch in this series make
changes relevant to the TEE subsystem. It would be great if the QCOM soc
tree maintainers can Ack the uefisecapp driver patch.

[1] https://github.com/qualcomm/minkipc
[2] https://shorturl.at/zQU07
[3] https://github.com/quic/quic-teec/pull/27
[4] https://github.com/rhboot/efivar
[5] https://docs.qualcomm.com/doc/80-70020-27/topic/manage_uefi_environment_variables_using_efivar_tool.html

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
Amirreza Zarrabi (2):
      tee: Add kernel client object invoke helper
      tee: qcomtee: Allow object invokes from kernel clients

Harshal Dev (4):
      tee: qcomtee: Track the object invocation context
      tee: Export uuidv5 generation for TEE clients
      tee: qcomtee: Add support for registering QTEE services on TEE bus
      firmware: qcom: Add support for TEE based EFI-var client driver

 MAINTAINERS                                 |   7 +
 drivers/firmware/qcom/Kconfig               |  24 ++
 drivers/firmware/qcom/Makefile              |   1 +
 drivers/firmware/qcom/qcom_tee_uefisecapp.c | 525 ++++++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_tee_uefisecapp.h | 120 +++++++
 drivers/tee/qcomtee/call.c                  | 218 +++++++++++-
 drivers/tee/qcomtee/core.c                  |   9 +-
 drivers/tee/qcomtee/qcomtee.h               |  18 +
 drivers/tee/qcomtee/qcomtee_msg.h           |   1 +
 drivers/tee/qcomtee/qcomtee_object.h        |  16 +-
 drivers/tee/tee_core.c                      |  26 +-
 include/linux/tee_core.h                    |  15 +
 include/linux/tee_drv.h                     |  18 +-
 13 files changed, 968 insertions(+), 30 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

