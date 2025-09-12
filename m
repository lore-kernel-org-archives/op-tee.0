Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2903FCA101F
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:08:22 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 43BEF4FE01
	for <op-tee@archiver.kernel.org>; Fri, 12 Sep 2025 04:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1757650101;
	bh=0HhsRZ/MRNfDt+mX8LDpWYNFl8+vkFvdCi/l8QceASE=;
	h=Subject:Date:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=j5yXAll1Eml5Xb8VcKGpCgD23N2Erfc7yfH6e6MC7D4V893Q9dRsH5SBgSN4VtRYH
	 /I0ofLZq2BjZNSX+J8DT7+vOiPLG15cKhRAMVo41Mux2cJ1ZIW41ssmmIWNOAG3NC+
	 dz1auMHXnuapE2PuV1laREa65c+5axgMV2bj/USvF7sjJgDKkYJqbUz0I2ApciT7YG
	 iYXO8xZkqsjGLMNEMgeoGj7OPP1HZz/4tXykSZMtnULqwWtprLOs0Wm4AcGnwJwFko
	 ogtgQ1+BpHxgO7g5ZFeD0+Y9qe+vNoTuWQ4gaP042HGd0dte6tOTuFekQCfnfoBZW6
	 OebPCaq1Ql4LQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id EA72142F28
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:47 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gnoDXoCg;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIw9xv016116
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lMtGh05qKJ9RMGij60FaCi
	9FX+RPfgsm3LOkqyZ3z+A=; b=gnoDXoCg3aTJRiZdulMvtS0kveUM2te7MWoYjT
	N1R0XSpUNG2VW4P4nbhqQMo4d2HRogwhXskSGv3wyVfvkt8m9k1Sj0nANZy1S45f
	6GdgwUvTT24m4juit8IQT87MXmm7tzgWFEUsIKRzqd+Wyx2S+zGN73ZOKWZ4j1SS
	n16Ss/2UWdTiJLlMBeekqSFfvLKof0PZwVAdvVvtWkusnlqBvJGI5AyBtKFiH4fK
	CbAr5K3PevgAhWGMVwZ3EVxTLnmJpwrRjZjWrRuYU338vxLjFadDlTo65agObSb8
	xjYsCiKbuky9HNZ+f1UPH57Wh9zIRBgAP739deBUZtzUFybQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491t386jvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 12 Sep 2025 04:07:46 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724688833bso1388053b3a.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 11 Sep 2025 21:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650066; x=1758254866;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMtGh05qKJ9RMGij60FaCi9FX+RPfgsm3LOkqyZ3z+A=;
        b=tzfNnRqkHTiC5g7CJlGzcSBLgXCOEK91+efUiSBjk5NRCRhcfD2f19CjpxIaAuVAvn
         kBWT7Fbfgd+mjsWDoBv/pd0DS9epVMQqG0MjsCGk2+Si6RbNhUYsNBPUQH7Xk6+VRnds
         Zvu8MbjHznXENdX69N/ERVlxbOBok7t6xhYV6JnmiXiKSMJg56oRGr067W0rf5ocnjg5
         TA+7fHIBbyyvUYdCiqCneLbF/ipSDTTHtblb/HH/JKHR07xjRGs0Tw+ooucSvsiuE7/H
         dUDXIR5OnQZApwZTZ6KQbCKNNg60A35gToKj//ZxrNTrQykJWYhJgq99gO50uDBuzzwq
         9wJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeGYKUsyA1COoUWrq+nWLqgaoUNS3A+F7XARNEuS2lSpDYEg6fQ3udNM+ehfGFfwyO1LLaSOo=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzsI7XQmiTOr7KqqDY0fAtiZZ0bfRrTX/DYlV70y7nejgy78cGi
	1FIn6v3ukjA7IAMaQUYSiEiCg2Jw71N2vK6On4fTU6W96pEnf1k9Ky6LrOTN4sqaMB2ukKeXctd
	NcKCxV6HJbyJslbUPLpr+bYM1Eg4RhMnQJYTKr2jYFVo3FKtbHMChjIN8P6HjK44ALs88KUo=
X-Gm-Gg: ASbGncsX2rX2ovQXjeTxDVjKs71FDF+sJmjrN9Wa3mFd40KxqGBHTnLMj7DuFRdHHZz
	g5ZKFflIO63R3L4UMVLagcVPdafCrerk//Ihfk7k5h5s+LhnrL0tznjFRDTUc4LlJZovDknOrab
	Cke9TIByveaQ+lx9U4K9+WuMp/Q6Q2Jlo+q4fHjJLw0s2jXDm9Kt9qceTxOVnaMJBIxioKOMcT2
	HsLtqDYPXYS1NVUd1N0gpPMMDdh+dqE9q7/QPhKSTxFO7gXRxbFAjuvXPPU9gJjW6MbiMjCImYF
	GdChLaIV1f/6/KTmKtmOMeoAyJdafTY31SYSA/nDCYvwwZvjdo2JApNkKXR81MTvT3VVj6klKAV
	dAh/cuG+WZl8KBnZZOi88HEc=
X-Received: by 2002:a05:6a21:e098:b0:250:c76d:1ce0 with SMTP id adf61e73a8af0-2602a49b135mr2014144637.2.1757650065712;
        Thu, 11 Sep 2025 21:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHED6b2yEWj0HUiHcEYzx0EDh2oxq8EUmGsufAd40Bs7RxF5FGvmNzJz31G0vflQ7gl7CjKVw==
X-Received: by 2002:a05:6a21:e098:b0:250:c76d:1ce0 with SMTP id adf61e73a8af0-2602a49b135mr2014093637.2.1757650065144;
        Thu, 11 Sep 2025 21:07:45 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:07:44 -0700 (PDT)
Subject: [PATCH v12 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Thu, 11 Sep 2025 21:07:39 -0700
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIycw2gC/5XTzW7DIAwA4FeZch6VbX5Mdup7TDsQAi3Tmqyl7
 TZVffeRSlMqbZHYBWEEnxHGlyaHQwq5eXq4NIdwTjmNQwmQHh8av3XDJojUl4WGgBSWQez9uBP
 HEMQpp2Fzm+UsPtJxO56OYhd2YuxehTTkjZEKNHFTrPdDiOnzluj5pcTblI/j4euW94zT6n8zn
 FGAiBooRMAAaNb7U/Jp8KtyvJlynOnHLbvqXSoutRyc76GXKv525exK4lpXFpej0gwsyVK/HnN
 e7U/urRzfzbiacUW2FlcFNw6VNAqc8d0Crmdck6nFdcFLcYIkwg66dgE3M84oa3Ez3bzl2HGv0
 EuzgPOMW6yuJRfcB3bomJUFuYDbO5ygFrdTQcEYYyGitG4Bb2e8BazF24I7cpFksanXCzjCvd5
 W9w5Mnxw6ZKt1iBKXeLzjsfplcOpNTRCs4U72rP7gr9frN/ylrLZ+BAAA
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: WMrOCK-XVDZmNTpnUh-_1yLoEmigiIJu
X-Proofpoint-GUID: WMrOCK-XVDZmNTpnUh-_1yLoEmigiIJu
X-Authority-Analysis: v=2.4 cv=NdLm13D4 c=1 sm=1 tr=0 ts=68c39c92 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=JQp9LH6sAdamtf7EJi4A:9
 a=rgUg2CG13K0mU3JE:21 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA2NiBTYWx0ZWRfX+B70gba6G9aT
 PIn/+pA6nhIBMEJL4vRxQbfULNbF/sLt3l8Rq44Wc3bQAyGSpjOmuoE9ac2WgUrBvt8ZkMmtbeS
 15kZIRooagm+bHWcgTm3a8ghQcH8krYTCLmS4XYygCHS96wamGa0bVyMVeNyQzpjNIU/NP50XKY
 2+zUC+Ha9ydBmQSl2S6V5rSxZGPNfSNeC+xFPcKjrxh1Mh3FWiMFgdNIjVVRltNqLUJ+nJOKDga
 PSaQB7WI5yuFqn3Cb5dcvfJkOA82NIFUcTgvymzGR6PNK24xse6blAYSNTJBcIFrGvuhBBk2V17
 GrR4C3huefXzN37zQhwodkHrE8Aze7fqTwGZE9++Ht1ETBpKofsBn0N8oftQANVBe2oEUrcCQ5l
 M6L6aZ8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080066
X-Rspamd-Queue-Id: EA72142F28
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received,205.220.168.131:from,209.85.210.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 37NZQJSFPGTIT5DFXQXD5KOWJH7CABEH
X-Message-ID-Hash: 37NZQJSFPGTIT5DFXQXD5KOWJH7CABEH
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>, Kuldeep Singh <quic_kuldsing@quicinc.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/37NZQJSFPGTIT5DFXQXD5KOWJH7CABEH/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

This patch series introduces a Trusted Execution Environment (TEE)
driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
and services to run securely. It uses an object-based interface, where
each service is an object with sets of operations. Clients can invoke
these operations on objects, which can generate results, including other
objects. For example, an object can load a TA and return another object
that represents the loaded TA, allowing access to its services.

Kernel and userspace services are also available to QTEE through a
similar approach. QTEE makes callback requests that are converted into
object invocations. These objects can represent services within the
kernel or userspace process.

Note: This patch series focuses on QTEE objects and userspace services.

Linux already provides a TEE subsystem, which is described in [1]. The
tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
can be used by userspace to talk to a TEE backend driver. We extend the
Linux TEE subsystem to understand object parameters and an ioctl call so
client can invoke objects in QTEE:

  - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
  - TEE_IOC_OBJECT_INVOKE

The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
used for invoking services in the userspace process by QTEE.

The TEE backend driver uses the QTEE Transport Message to communicate
with QTEE. Interactions through the object INVOKE interface are
translated into QTEE messages. Likewise, object invocations from QTEE
for userspace objects are converted into SEND/RECV ioctl calls to
supplicants.

The details of QTEE Transport Message to communicate with QTEE is
available in [PATCH 12/12] Documentation: tee: Add Qualcomm TEE driver.

You can run basic tests with following steps:
git clone https://github.com/quic/quic-teec.git
cd quic-teec
mkdir build
cmake .. -DCMAKE_TOOLCHAIN_FILE=CMakeToolchain.txt -DBUILD_UNITTEST=ON

https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
needed to build the above.

More comprehensive tests are availabe at
https://github.com/qualcomm/minkipc.

root@qcom-armv8a:~# qtee_supplicant &
root@qcom-armv8a:~# qtee_supplicant: process entry PPID = 378
Total listener services to start = 4
Opening CRequestTABuffer_open
Path /data/
register_service ::Opening CRegisterTABufCBO_UID
Calling TAbufCBO Register
QTEE_SUPPLICANT RUNNING
 
root@qcom-armv8a:~# smcinvoke_client -c /data 1
Run callback obj test...
Load /data/tzecotestapp.mbn, size 52192, buf 0x1e44ba0.
System Time: 2024-02-27 17:26:31
PASSED - Callback tests with Buffer inputs.
PASSED - Callback tests with Remote and Callback object inputs.
PASSED - Callback tests with Memory Object inputs.
TEST PASSED!
root@qcom-armv8a:~#
root@qcom-armv8a:~# smcinvoke_client -m /data 1
Run memory obj test...
Load /data/tzecotestapp.mbn, size 52192, buf 0x26cafba0.
System Time: 2024-02-27 17:26:39
PASSED - Single Memory Object access Test.
PASSED - Two Memory Object access Test.
TEST PASSED!

This series has been tested for QTEE object invocations, including
loading a TA, requesting services from the TA, memory sharing, and
handling callback requests to a supplicant.

Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk

[1] https://www.kernel.org/doc/Documentation/tee.txt

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Changes in v12:
- Fixed kernel bot warnings.
- Link to v11:
  https://lore.kernel.org/r/20250910-qcom-tee-using-tee-ss-without-mem-obj-v11-0-520e867b3d74@oss.qualcomm.com

Changes in v11:
- Rebased on next.
- Link to v10:
  https://lore.kernel.org/r/20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com

Changes in v10:
- Remove all loggings in qcom_scm_qtee_init().
- Reorder patches.
- Link to v9:
  https://lore.kernel.org/r/20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com

Changes in v9:
- Remove unnecessary logging in qcom_scm_probe().
- Replace the platform_device_alloc()/add() sequence with
  platform_device_register_data().
- Fixed sparse warning.
- Fixed documentation typo.
- Link to v8:
  https://lore.kernel.org/r/20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com

Changes in v8:
- Check if arguments to qcom_scm_qtee_invoke_smc() and
  qcom_scm_qtee_callback_response() are NULL.
- Add CPU_BIG_ENDIAN as a dependency to Kconfig.
- Fixed kernel bot errors.
- Link to v7:
  https://lore.kernel.org/r/20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com

Changes in v7:
- Updated copyrights.
- Updated Acked-by: tags.
- Fixed kernel bot errors.
- Link to v6:
  https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com

Changes in v6:
- Relocate QTEE version into the driver's main service structure.
- Simplfies qcomtee_objref_to_arg() and qcomtee_objref_from_arg().
- Enhanced the return logic of qcomtee_object_do_invoke_internal().
- Improve comments and remove redundant checks.
- Improve helpers in qcomtee_msh.h to use GENMASK() and FIELD_GET().
- updated Tested-by:, Acked-by:, and Reviewed-by: tags
- Link to v5:
  https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com

Changes in v5:
- Remove references to kernel services and public APIs.
- Support auto detection for failing devices (e.g., RB1, RB4).
- Add helpers for obtaining client environment and service objects.
- Query the QTEE version and print it.
- Move remaining static variables, including the object table, to struct
  qcomtee.
- Update TEE_MAX_ARG_SIZE to 4096.
- Add a dependancy to QCOM_TZMEM_MODE_SHMBRIDGE in Kconfig
- Reorganize code by removing release.c and qcom_scm.c.
- Add more error messages and improve comments.
- updated Tested-by:, Acked-by:, and Reviewed-by: tags
- Link to v4: https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com

Changes in v4:
- Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
- Rename object to id in struct tee_ioctl_object_invoke_arg.
- Replace spinlock with mutex for qtee_objects_idr.
- Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
- More code cleanup following the comments.
- Cleanup documentations.
- Update MAINTAINERS file.
- Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com

Changes in v3:
- Export shm_bridge create/delete APIs.
- Enable support for QTEE memory objects.
- Update the memory management code to use the TEE subsystem for all
  allocations using the pool.
- Move all driver states into the driver's main service struct.
- Add more documentations.
- Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com

Changes in v2:
- Clean up commit messages and comments.
- Use better names such as ubuf instead of membuf or QCOMTEE prefix
  instead of QCOM_TEE, or names that are more consistent with other
  TEE-backend drivers such as qcomtee_context_data instead of
  qcom_tee_context.
- Drop the DTS patch and instantiate the device from the scm driver.
- Use a single structure for all driver's internal states.
- Drop srcu primitives and use the existing mutex for synchronization
  between the supplicant and QTEE.
- Directly use tee_context to track the lifetime of qcomtee_context_data.
- Add close_context() to be called when the user closes the tee_context.
- Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com

Changes in v1:
- It is a complete rewrite to utilize the TEE subsystem.
- Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com

---
Amirreza Zarrabi (11):
      firmware: qcom: tzmem: export shm_bridge create/delete
      firmware: qcom: scm: add support for object invocation
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      tee: increase TEE_MAX_ARG_SIZE to 4096
      tee: add Qualcomm TEE driver
      tee: qcom: add primordial object
      tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
      Documentation: tee: Add Qualcomm TEE driver

 Documentation/tee/index.rst              |   1 +
 Documentation/tee/qtee.rst               |  96 ++++
 MAINTAINERS                              |   7 +
 drivers/firmware/qcom/qcom_scm.c         | 119 ++++
 drivers/firmware/qcom/qcom_scm.h         |   7 +
 drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
 drivers/tee/Kconfig                      |   1 +
 drivers/tee/Makefile                     |   1 +
 drivers/tee/qcomtee/Kconfig              |  12 +
 drivers/tee/qcomtee/Makefile             |   9 +
 drivers/tee/qcomtee/async.c              | 182 ++++++
 drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++++
 drivers/tee/qcomtee/core.c               | 915 +++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
 drivers/tee/qcomtee/primordial_obj.c     | 113 ++++
 drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
 drivers/tee/qcomtee/qcomtee_msg.h        | 304 ++++++++++
 drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
 drivers/tee/qcomtee/shm.c                | 150 +++++
 drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
 drivers/tee/tee_core.c                   | 127 ++++-
 drivers/tee/tee_private.h                |   6 -
 include/linux/firmware/qcom/qcom_scm.h   |   6 +
 include/linux/firmware/qcom/qcom_tzmem.h |  15 +
 include/linux/tee_core.h                 |  54 +-
 include/linux/tee_drv.h                  |  12 +
 include/uapi/linux/tee.h                 |  56 +-
 27 files changed, 4410 insertions(+), 28 deletions(-)
---
base-commit: 8b8aefa5a5c7d4a65883e5653cf12f94c0b68dbf
change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

