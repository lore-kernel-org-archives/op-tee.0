Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783D7CA5FB3
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:03:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 98BAE44A49
	for <op-tee@archiver.kernel.org>; Thu,  1 Oct 2026 11:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790852610;
	bh=rCkHgUNzH5D5IlD/fepvc6TL+xU2CyAfDB+iAEDgnQc=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=oqE521FIrG7zBJ6DfOaxSCn3FDgW05Zk1V4/agqLBGYq1e4VDmpAyYAoF2Ic5cBFq
	 TfvJu5qsvE9Ejuf7CqHEq4n9I0/JlQM4WsSVNgBjj7EYuu8aqZdMYxF4GWQ2PiLwOf
	 vLfwfcfLqfQnszWggOEUDYDEpOArjFj82DqFqSY/Ql+eOEXCLMAHE4zUVPzAQE+gzA
	 Y8MHgUzrXPim3aMMt/uFffN/ncNoPwYh+kZwQiWjAz+S83aFsyCeaFVBJ07mbJRZ7A
	 ZbpdNdASWS4yIXVtfsSPQK0XHY4b2/VYapYy9A8tdurhZtNjrw1T6KZuhP0dUR9T0R
	 p1ELf/TtCuoQA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4436844A49
	for <op-tee@lists.trustedfirmware.org>; Thu,  1 Oct 2026 11:03:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gIquDs/S;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Aa7q8Y78;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6916xPt42806285
	for <op-tee@lists.trustedfirmware.org>; Thu, 1 Oct 2026 11:03:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QRdRmNwwFb4C3q3OKptwmD
	oUiwXrWNwUfk5/d9yGdI4=; b=gIquDs/S1b8XApmIW/3KT4fJpQvaZZIj+y2rrh
	oZwXhZfU90rbkDIfx4FonZblBaX1RpbEQqrwcm7f+a8nyOB3ksVcI9BFmvV2Ot69
	fQRyX7RbbbP37jSAfdnDpXlv9uJiOMeTwdE++oDChLQGhebfVyX9r/kTa2mX5oSQ
	uPLczGQ8eU/EbJmrAHCLLeO1SRbSz296Fc4gx1l0WyX8SAUT7viwh7LjHANS9Ry+
	Puj5zg9t4Lmr8ZZ/Walwdta2p1M+RnW4ufSGoHrqIMbYAOGeaH4/3Z3zdEmU9Zxt
	EMRGUGIIgY79abLgRxdk+K504AwoF747A6oCyeOFR9V05GXQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1hvkha1q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 11:03:04 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso5539430a91.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 01 Oct 2026 04:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790852580; x=1791457380; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QRdRmNwwFb4C3q3OKptwmDoUiwXrWNwUfk5/d9yGdI4=;
        b=Aa7q8Y783kS/0RvGaPsFeH89Z4vQLMupTc0pOrubBgavlN63FrtZmbO1iHkU+osbx5
         p160OKKf9vU2CtYH7P36Php09V+f2Lrf+AgS3UcPah9ccMsRwWoB38sIuikJ91M/Df1V
         KbNoYr1KBWZxm8Uh3RAEW5zyXQN2+RgdHrCopLJVGMqBVSrwgQ6glOSmdWwebHy0r9Fy
         DugWDWWnsXdkybR/DJwcZjCP3eJCmfPaIfrlrls7TuTe/eWeCj9PI2/mT3GqiVxs3MDI
         8fc3f10J4Jm3a9TtOBhxnDgHWGs6CN4V5r9qVUZ0umvnAYr+HxvgK/ruc6kbXWjq4+sg
         VrXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852580; x=1791457380;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QRdRmNwwFb4C3q3OKptwmDoUiwXrWNwUfk5/d9yGdI4=;
        b=kRWgwsy0yxH7qVt5Y9E5qoadaF9CDBIIvEM4dQn2UMfAC1XRFoXhHkWDUMYqazHA9o
         snn8j6IWqfm0Fz2xYpIoR5Avh+bk9ZexX9Mgl8WW4vz/Aq3fJV7KFFea02GD/ZXa7jMM
         Jgryx/g0ff1zKHKcBQ1EFFvfLLm1soAYEFZ+iZ200zli8rtb25xc3xtZ5un8BG21jURM
         74j2xZPPX0wrz4XthTr1p0TWK1Z4REpsJWtkrpS/Ypdlvq94Ru3/paWwX9YAPIYQzsk+
         8oZxRvdUFbl+nM2NA0Q/Oub/0ET3CPomMmLAkxOHKP35J14W9mhjOy9AZtL4h3cYJgwq
         oaKg==
X-Forwarded-Encrypted: i=1; AKwUvBw3i8bzArhadi/3ojMJJmu+IzDa2PuEL/wB2GE7tcjRB+s5Dzjwi11fYbjg0QJh00w+OitvV9M=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIRGz3w7fNw+slfEJ8+6Iiql/IACEx3Q/5szNLIVGI133ovsFrr
	HmbtjYeTdqxCfQgNgcuNVDv/Cwy56/TAwX7/dj/FdVLrVSeYAmYY3vi+sckBRuuymM3i9Cn8sBu
	Lxw9cS+zx6OyUlc3pO18bNerke/2WXLAVHaDXOtBp9RbeqdHHbgYqw0Xbwqz6K/T/l3lTZGwq
X-Gm-Gg: AYBFou1TKRPIiFI495vSbDEErkNEAiB2TnLSedNIXum7ti2eW2vMgZ5OIa69Xncm6yR
	w5nAAqSTeRlbDJMW8lTo10/yM9AMQh3lVdtktW4hY2AfNR9+a6SzviYpu2SAkGfKmAQ89HSYcsP
	1OPjEZh3eqCjFs2zAkEqPWkYy2N0HP8sfffnSFROjSTlspazEZmIYMrm9Tb/4D4/pfJlN+kQVAj
	VBI9sIVTsmLSlujMdrfYp6jepvKK48CDA1JGA3ZRhaSzkx0IIsCcv7XF+jbOXoK9O8qtDQF4zh0
	boEK63vdzQ3AQDfE+9ySTAPyyUrhoN/Ci3HPca7DyRNsYcHR+KS5XuJCmyZapwmMP/IrOUfhgx6
	BppFF5066AbjIoDaaaIOLL8Ondg==
X-Received: by 2002:a17:90b:5101:b0:3a4:71b7:eb63 with SMTP id 98e67ed59e1d1-3a4d14ed8a4mr2545166a91.10.1790852580368;
        Thu, 01 Oct 2026 04:03:00 -0700 (PDT)
X-Received: by 2002:a17:90b:5101:b0:3a4:71b7:eb63 with SMTP id 98e67ed59e1d1-3a4d14ed8a4mr2545134a91.10.1790852579558;
        Thu, 01 Oct 2026 04:02:59 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f4371383sm4076810a91.2.2026.10.01.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:02:59 -0700 (PDT)
Subject: [PATCH v3 0/6] Add TEE based client driver for UEFI Secure
 Application
Date: Thu, 01 Oct 2026 16:32:32 +0530
Message-Id: <20261001-qcom_uefisecapp_migrate_qcomtee-v3-0-13df5c20c2e3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMk9vmoC/4XNTQqDMBAF4KtI1o0kMf511XuUIjEZNVCNJhpax
 Ls32k0XBTcDb3h8b0UOrAaHrtGKLHjttBlCSC4Rkp0YWsBahYwYYRnhpMCTNH21QKMdSDGOVa9
 bK2ao9v8MgGlSZKXiKRDKUVBGG7qvY+H+CLnTbjb2fQx6un+/dk7yU9tTTHCTpaWsVaoIlzfjX
 Dwt4hkKfRwO2ic8+2EZO2dZYOtCFI2sgTNK/7Dbtn0AovHekSwBAAA=
X-Change-ID: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790852574; l=7438;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=rCkHgUNzH5D5IlD/fepvc6TL+xU2CyAfDB+iAEDgnQc=;
 b=7nX9LIGWYk1iH32OLso01l16H7t7GogmKOIdd6tNot+33kEpBu9tLBU49IQquxLL8s/r+/Xkh
 gOF7SbpV+E1CZIY/BVatdb991kme4b9qlBIXCsyI27E2QnTe4po4T6w
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfXwuMAbs21lPfy
 abA6neRkp5aNqJL0o4FaP8kkM/tm2gVqMdN8cudQTnrE/oIcdNLWzcrK2P6cQrHAIsj8VHFnv3Y
 4/TGX7QRP3pbyoeCc8nQogk23r1Lsag=
X-Proofpoint-ORIG-GUID: U-lypeli7G2jPaFkRtuTM7cSr_AY8FV0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MyBTYWx0ZWRfX/LMLMNFlYwrv
 IdTLa5A/BzwH+xXcUkJSqgtj98xJLyGOmz37IwAFeLsd+eZMqI9ziuUj5OIX3FGm6sD3YElPG8r
 1RPf8IewNK3cM8vOQXdtrUdzWCRtTyf6ZKspUi4ZNdA0rvkv05BczBEGxMlfQDHvmbpYAK25LUx
 ML2yAQnEahQ1ohOSg+K1jhAdkF4WpGfu9YlmUL1JPQUc0DR4BESvBawiNU7ngvHBzsuXAimBGl2
 U4L4xOA15E1tbYlH2C6t0WfgoWql74lSUs+lSfQmIEx1bISMMbV8W6U06JWycrcOoYH/Mnki04R
 5bJfdj0b7WBElWO8xuklTFpZaF2w0q9iFsaCcS7OYorbwbZPGeZO3tR3Gzx7w4aevNGZd4KcU/v
 cYmB4smd6IuO6D8YUaujykBc3n874Oaxi00cgcsEoPT5NC+ZC/f/Uc0TMcAS+Fw01uEHo1OcMar
 NSzGnJl0AgY9dKb4Hdw==
X-Authority-Analysis: v=2.4 cv=IY8Symqa c=1 sm=1 tr=0 ts=6abe3de8 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=NEAV23lmAAAA:8 a=EPKcpx9xAAAA:20 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=_oFDGg79Q7pfAgulZHUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=d3PnA9EDa4IxuAV0gXij:22 a=ZT_8zCgGubuJgGonBfBE:22
X-Proofpoint-GUID: U-lypeli7G2jPaFkRtuTM7cSr_AY8FV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	REDIRECTOR_URL(0.00)[shorturl.at];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.71:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4436844A49
X-Spamd-Bar: ------
Message-ID-Hash: I3A4NE7QRDSB2MKUOJAB4UKC3ZPGM5TI
X-Message-ID-Hash: I3A4NE7QRDSB2MKUOJAB4UKC3ZPGM5TI
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/I3A4NE7QRDSB2MKUOJAB4UKC3ZPGM5TI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

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

Harshal Dev (4):
      tee: qcomtee: Track the object invocation context
      tee: Export uuidv5 generation for TEE backends
      tee: qcomtee: Add support for registering QTEE services on TEE bus
      firmware: qcom: Add support for TEE based EFI-var client driver

 MAINTAINERS                                 |   6 +
 arch/arm64/configs/defconfig                |   1 +
 drivers/firmware/qcom/Kconfig               |  31 ++
 drivers/firmware/qcom/Makefile              |   1 +
 drivers/firmware/qcom/qcom_tee_uefisecapp.c | 636 ++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c                  | 206 ++++++++-
 drivers/tee/qcomtee/core.c                  |   9 +-
 drivers/tee/qcomtee/qcomtee.h               |  12 +
 drivers/tee/qcomtee/qcomtee_msg.h           |   1 +
 drivers/tee/qcomtee/qcomtee_object.h        |  16 +-
 drivers/tee/tee_core.c                      |  24 +-
 include/linux/tee_core.h                    |  23 +-
 include/linux/tee_drv.h                     |  18 +-
 13 files changed, 952 insertions(+), 32 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

