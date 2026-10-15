Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EB8CC6B3A
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:40:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 259F4451C7
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792064407;
	bh=JXzL7S9bNiMOsigVQwbFH3I5AHLAWMPHnh2F+ewfMiY=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=G36Dc57VV/vhkXxfhD9uRxmbzbJhqL7A+eVu/LKfonBVXrghz6u+IHAAoZArpFsLN
	 CfnWeISGmytFdPSsWeRpgJdM87hiU24cvw51dL+Hl46erkG+ylzFzDSsTqHL1so4Tp
	 EQzw4yHE2VBPPr06Fk16bNSJJ4x5kdptkaBGgQw7lZKOAQ2HyQkTZoNc6Gi0MmVSpN
	 77pw1iocZL4eFgKgHCjLRGYIq/0DByPwIwINkRrqdXprvOnNc1mF5H1IiFVfXnt4nJ
	 fKzL+D8abtm+RPXyGYk6xChdcHTJW8MS6zOYPW2O9AmSnhDKXkswRAk69/vb+j/4b4
	 tkDsYVl2M8w/g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BA7CE451C7
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nqs4EIgD;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FcdIvyLV;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jVDK2416893
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Zw5Irjniue1tO+zMu7+ovK
	viI3GOBmVus1nvVQ43SCE=; b=Nqs4EIgD9dXpaS7kQKyTCyPPT8x6s9Wf1n7msw
	2miGkLJfkO0rqATvgwemXTg7bZJcvNPggC0HM5ZSyz5laXzR17vKBm9vBn8TLjCO
	vN0xRcqnNfHeLAYUdepknML9jaBu+Zkm0lmBMKk4sGgSIdUsJK7wYamlfxbV0BUC
	p6EIY9MixA374YMronDFtU0q98nhCbP1UinOfT47SWfXiVxHVaK3qlOJMimRCEmc
	JcezPZqvFtJSCPiMZvAjm8Z/Ef8fPBIlY6sjQOnSSUwFqOS3yNICp8dpzBXcChiT
	kJ26z8T+FsEm8/qaIf0femnEfzSryNJMHUeBXTc7kxUZK/UQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhhvrp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:39:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so14610028eec.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064386; x=1792669186; darn=lists.trustedfirmware.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zw5Irjniue1tO+zMu7+ovKviI3GOBmVus1nvVQ43SCE=;
        b=FcdIvyLVD/3c5/I8+XrlpAHg1+EnVHyX4ULMwfC/JNoEEyOQTNr+OiodtN7wKzQCKX
         QSzZAZwFqnBMt84lpRmOLgPdBZ5TpjdyC1EDklUe8USsjto/g3tUa/J5IY7ssH/U9h5S
         GK9LfKwFjkYtTHhV4AUZYMY6k13XnqhS2zFLryXJpYERr4vADxWN5rUrjXaED6x9PHip
         /KC/2iAPR4wte2mFfbCnpi6X1lJp6OE6jz1Q5JkAwkdnIRJizTc96P9MOCRZtlyK066B
         NMVgpj3LElKef7eYHjEIcDmgsaGVOPz6aAxYWyATP/SvnQx6GVPcYtPDcZeqLS4wUnnz
         r+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064386; x=1792669186;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zw5Irjniue1tO+zMu7+ovKviI3GOBmVus1nvVQ43SCE=;
        b=GKgX0Jb+nLs0mtWT3NVEqncaiTFlg1rLYcOX9oimEHuIyLZK/5MUHxUMzf9v5mC6ys
         vfZPi/jEW1eiLLUyowATXlq9LoCcSbZNkzHmh6O+2JOmXlG6VVd2ALc8tbD4x+uQxlIs
         N38SPbcYadmo6XFqOKm/5hAoGj6+0yTibTxh70fyXe14OcVIJ6No2CQ07S34vCNY1/zs
         4tOOYcAT/FypPdgdiJS4Kc+l6ln6IzGXBKCTk6bTT+3aZ8TI06V8XNM0C7W3too6KbKj
         HrXFS3vaJmOJOn9PeCyQ2+qrM7hZSr6LyFmQ19PxTr3LuCjErAtw7kjmmf3xwpY7DvQB
         /ReQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKXaSkM+PZ7cICRtGxN0d9+dC/JlkJeWGz6Ee2WKioj1EHNdqrGVQ3m4mYFS2zwaCl0JMUR8M=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYI0HbtrHcwZ1XWwlPMwzAOeiR+4TXMm+Ck6owOcqCNPHEqd1SCl
	BwJFx9kh7X+r99ZGb2lPgDRCVCcFw98jnjToccTeZPGRhWzN0nFrDU73D4+U/mal6c059qMpLYn
	MfXBlLpoDJbB4ytG2kTz5kLa4tZFbe3el3M2Gjng3PndO3E5bXgOpVh6iaGrZjJPThYz7J7jR
X-Gm-Gg: AYBFou2F66OlQq+Ivkru/ITqqESc5Kex40HMcYb4V9N8vtCbmCpCGamiYCo7LzKeYv0
	KE79mABqCuLbrhixMZ4IoBIVGwttQj7ot3kmeNnVSCngo+qXzQ469jCqgYiZH3cxvHwZTz8gIgW
	nzormnqzsuf2U7LBcuYboeUMkOuyEoFIekT8lj+WauMjukG7y+3ECgTwZR61BBY22Vai4lQd/Zz
	7OVvghsJmt4w5pHlVEqmC+GfRBWbs/3UEzYbtSmgcvjrvvaZqv3RwyYV/gGzmehjg/rSDNOd2le
	c5J+peLyBIw5Gvbb2pbIBnnza9YM/lYigMOC1yStdk8K1Dv6z/L/JGfrI0j9PS0bkx2F/lw/ZbK
	qhMRfAzcdQCOYI10g/WECYEpQbw==
X-Received: by 2002:a05:701b:231b:b0:14f:5549:c1ea with SMTP id a92af1059eb24-16a57a16d44mr27065301c88.1.1792064385204;
        Thu, 15 Oct 2026 04:39:45 -0700 (PDT)
X-Received: by 2002:a05:701b:231b:b0:14f:5549:c1ea with SMTP id a92af1059eb24-16a57a16d44mr27065251c88.1.1792064384378;
        Thu, 15 Oct 2026 04:39:44 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm48144891eec.11.2026.10.15.04.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:39:43 -0700 (PDT)
Subject: [PATCH v5 0/7] Add TEE based client driver for UEFI Secure
 Application
Date: Thu, 15 Oct 2026 17:09:34 +0530
Message-Id: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHa70GoC/4XOTWrDMBAF4KsEraugGf1E6ar3KMXI0igR1LEjO
 SYh+O6VUyhZNHgz8Ibhe3NnhXKiwt43d5ZpSiX1pxr024b5ozsdiKdQM0OBRihh+dn3XXOhmAp
 5NwxNlw7ZjdQs+5GIg7RmH5QmAYpVZcj19vpo+Pyq+ZjK2Ofbo3CCZftr78Ru1Z6ACx6N3vs26
 CCU/+hL2Z4v7rsedNs62FIx4ROLuM5iZVvrbPQtKQR4wco/FoSAdVZWFmSI2qPwSPIFq55Zs86
 q5dsI3hI6o1z7DzvP8w93PbQo2gEAAA==
X-Change-ID: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792064379; l=8747;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=JXzL7S9bNiMOsigVQwbFH3I5AHLAWMPHnh2F+ewfMiY=;
 b=bqT1gva7AEuKsno12gP+UO2e6w5sfXsK7kR+pxI5x/evkiBN7V6K+16ASsZKG+APtezz3KGsH
 69sfz09ynanBDb6Da1fsfhwNDIuAatXBe82IMUbBQwWzxVcCSyhCGkw
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX3/viAKE8llsh
 oiuP/2GKsthCALzNlhYXvbYk/sLoSzSQxdjGMVY1/yGR29lSHTMiPDwalPyOaDxat0UMzCJO+tM
 tRZbGr6kIeHlJUe+fKNREoEhKFhs5uUz1Q/TbX0x+r70Oe4K+s24emXUHHpWxf55th0AlsHxq11
 DUNMm6Oh7CkzyUZa8K8W7DVBb5kFn61G1EmQ0h3zpekxMK6jKSDR6MQYKbExDweNCC3eKgK+PUH
 YQ9lV8EiMDQbrV5SvIrkdrLZT/cviK3ITbCCEXj2q+cuKVtH6eeiRgJDmo/0UtgzBrbt1CP5Bql
 4TRDMWskeEQKu8Z1JOz7KNGgHu+xYjRrgZZy24LG5y77ZSdv7OSglA+yDtmJSom9J/6FCPA9AKu
 1Y1ixSdHYt1RBiWEzR/W7QaOhbHFoH08bZpmcfz9wJcOFR013CjGBGvHiIZnrXjgAdcBBdpNdTh
 eRsGhoWvNMp4aYcJbCA==
X-Proofpoint-GUID: ngdm6hiVrrRX9945cUDmh4BRNMAwCKcV
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad0bb82 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=EPKcpx9xAAAA:20 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8
 a=VwQbUJbxAAAA:8 a=VctfPk_oDqlEa1PX-fEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=d3PnA9EDa4IxuAV0gXij:22 a=ZT_8zCgGubuJgGonBfBE:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX2ZyDrEdoI11a
 qza1/JU7DZKFOvYmXr/SwOrf2SvynfmV8+dU1y/+r+fG4LnViqmWeuDyL8+eio4xSdJvqjD2oSf
 vtNq+X5ahPkbPfRBLIUvQXV+I+0rGDI=
X-Proofpoint-ORIG-GUID: ngdm6hiVrrRX9945cUDmh4BRNMAwCKcV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	REDIRECTOR_URL(0.00)[shorturl.at];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.82.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BA7CE451C7
X-Spamd-Bar: ------
Message-ID-Hash: 453M5MFEHICJBNM72XWNUEHJWEVP7I2F
X-Message-ID-Hash: 453M5MFEHICJBNM72XWNUEHJWEVP7I2F
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/453M5MFEHICJBNM72XWNUEHJWEVP7I2F/>
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
 drivers/firmware/qcom/qcom_tee_uefisecapp.c | 644 ++++++++++++++++++++++++++++
 drivers/tee/qcomtee/call.c                  | 210 ++++++++-
 drivers/tee/qcomtee/core.c                  |   9 +-
 drivers/tee/qcomtee/qcomtee.h               |  10 +
 drivers/tee/qcomtee/qcomtee_msg.h           |   1 +
 drivers/tee/qcomtee/qcomtee_object.h        |  16 +-
 drivers/tee/tee_core.c                      |  34 +-
 include/linux/tee_core.h                    |  23 +-
 include/linux/tee_drv.h                     |  18 +-
 13 files changed, 959 insertions(+), 45 deletions(-)
---
base-commit: 6c2cb8b8b843d216ab549b678a0d8831c43153e0
change-id: 20260408-qcom_uefisecapp_migrate_qcomtee-13869d45e014

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

