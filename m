Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE747CFD376
	for <op-tee@archiver.kernel.org>; Tue,  2 Dec 2025 09:37:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DB48C5007B
	for <op-tee@archiver.kernel.org>; Tue,  2 Dec 2025 09:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1764668264;
	bh=oESxKx1RpmIZ6LCbhSz860yg570UydSth6PJf3k8w58=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=tpFVAS96z4NnpjrsA4GEQ0a1sN9rRXuu+sGD04tr3ISKjec23z65w/9LhdyHdDlIz
	 KmiEQVMivGZxqW3+B6Ws4eBEAczcN6qV9R58FqXRAdMsaf+QV4djnUcyQ7PvxGHXoU
	 45PkXxjUgbraH0uDsWuw4gpKsSQKLTmsevZlNhbM0ESN8eQSsk7AVDGPLRaPLOgbo5
	 3X9QGGVQGrdGcgUNwC5LiuBvZKVvhEHn0XA80XR7b0/nZbPPjnDh+GIYK1J9GpdPMh
	 zeOEkyCwmHZETQ6W8SeYmQ8y94DXETeVmcpWd6fpgmxDEiaffmAt35ayfEkSRSe4zJ
	 G6pLHT0CZ3QFw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AFDF74300F
	for <op-tee@lists.trustedfirmware.org>; Tue,  2 Dec 2025 09:37:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=myMmf6Gx;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jz8rsrBo;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2673ha2821203
	for <op-tee@lists.trustedfirmware.org>; Tue, 2 Dec 2025 09:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Npr2KansqL+mF8z3wwuH37
	m0dnF+ct0oFxh/WdUGe5c=; b=myMmf6GxNABTsT5btDd7jQkAI/y4q58FEMXJa+
	mtqD1g/JmLQvX0+u0+I6rKdr8N+SdUAjSmHH4b0DeWiG9Hth/uD6mdLtGglO4hgC
	pIENvVgVSZcPZBnBa3x+NZsfHyBmGWLK1K4+X4OYE13/+gs/8i3oHTQ/EbSK5lWI
	ljUlaaokKQpfWrXazEzEyUpXabK++X9Mby4LDtzK1cV60wn/mOFkuEAq6/O/BXdE
	6Iq2EKUKWidoey6BmkCaA1mx6RFoCgg/+An3DBhf9kWKmb4tNe2UPixGPpj4G7mW
	/RtRW4TTkU1Mp6Y5Dadv9Vw/zWpGn9tNsIEcL/MQz7d1O1XQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4astjggn2m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 02 Dec 2025 09:37:34 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2956f09f382so31588405ad.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 02 Dec 2025 01:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764668253; x=1765273053; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Npr2KansqL+mF8z3wwuH37m0dnF+ct0oFxh/WdUGe5c=;
        b=Jz8rsrBom7QI172z0Ymc1Wi50w/uMV2Tu8+MRRptws0OUF6NrGAW+u9QW+LLDwIjMA
         fUEdim/u0vK6CLeCp89j9BToajw0mD9KyNKUHMvXuGFKHberB9QJ890TG4aSwNepO2hG
         THbmChfkb+oy8c4fe9Eru8qRgvIyPqGBoTZAJPiXzWkj2WpB7QqSdV28inKIiKAK3H1d
         DjBvibI/sIluf5rOzbq7RHJpwMxISJx2eBiS6F9wr5TT7EOTFCDmLUw6RrqeYnDhVQNU
         nFV4UHYMWDIO3H/0N8iMc84mcYXipcLzm+eQ4CseS4NUQCYJ4xynuEKYBbtWOKgOlqoJ
         Ag8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668253; x=1765273053;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npr2KansqL+mF8z3wwuH37m0dnF+ct0oFxh/WdUGe5c=;
        b=NsRFyKvco/Vo9UU1NnrbygmsEOB3+oBzjW+4pBanvp9TxFTQonykd4frZnFDhuWE4X
         ovN5IctUQxEwomPLWZcfKEip/xLZwJmgBLhJqbq/n6xrhIbFZSWVmNgopViOCu58D9rK
         7qPQOrxAuzbIrs41bOYGZNoXnPHqeDUBF0AjQzrUtgD8v667H18ty00F9hxvvemF/i0E
         1mzAyQN3igSr0fd+U0y2TrG9LLQGsH1h628wyyFioc7bVfDO+UT6Y6zVnUpI61sNEtES
         KeUEeLxIkrgNckYQhezQCnl51O66OE5wdQnMxX3BD1B/gNyadJb9g6kXchws6U6H5NN6
         kqEA==
X-Forwarded-Encrypted: i=1; AJvYcCV3x6S+3by2LnCGRsZvV4+gROJiE5t+FyNFLr5DTGCcUziJzL14KNYqzKobyU9NHDBPkgAfMtQ=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzH/leTK59CvomDwP3w7+BBkKbR0s8yKP4Qwh7KUpr9zAPq0IkN
	i3EZCPOp7KYzQttic8ZxpwYiuQ/B+V0V9rXq9WJvr8KRgpMbCdxIXkV+KrvvVUn8dUTELZWKaqv
	ZysQywQNbTME2B9ru3n89dt4UlIT9nzTqr7KwcbxAsD0qD2z1w3VWdV2D2PinZs58Ox266LvN
X-Gm-Gg: ASbGncvAGnKDoFjQzH6A3BZN0R9Y+Fy5n6NisbCNQjejevNyK8hDVqK99NFSHXYVFsL
	ow2UlAKuSKTqhlWOrUmrD7rnxeCrGsf3lW7VAt2xtRtNc4H7P/CXdGNs4sLET+Tuf5OmJwH7191
	HZk7K3AT7s8c9b8tdmeVPib3dKV6JakVij5DMf6sok/HoHDvjI+32DUQG6JSPrSv+SFLarBxsbA
	4MB/Z78b7kAe/cRjHeBg6nHZXwfJEpkxWoJGeiqfgLv/VZBrKUFr3Y9yCNZ1/azOkIA05883Fub
	llSW8ehOs4EU5kvX/GNnDBBLIqnRGTTAzgH4bzIcLQWPqWOmrS9CIMyJu7Ja3kYA9ro8OuDiobw
	afgqn10+r70uiChySXPLSeHovZTTte4bHJrU=
X-Received: by 2002:a17:902:d4d2:b0:297:f0c3:32e0 with SMTP id d9443c01a7336-29d5a4f383bmr26213415ad.12.1764668253218;
        Tue, 02 Dec 2025 01:37:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsIV4uh/fdd7yX6qZGva/N/nHFcJBN15ZRTgiW++ptNVaHfY84G6VLb8VC/t44SNeIbxgxIQ==
X-Received: by 2002:a17:902:d4d2:b0:297:f0c3:32e0 with SMTP id d9443c01a7336-29d5a4f383bmr26213115ad.12.1764668252709;
        Tue, 02 Dec 2025 01:37:32 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bcefaea48sm145369405ad.47.2025.12.02.01.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:37:32 -0800 (PST)
Date: Tue, 02 Dec 2025 15:07:23 +0530
Subject: [PATCH] arm64: defconfig: Enable QCOMTEE for Qualcomm SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-qcom_qcomtee_defconfig-v1-1-11bfe40a8ea4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFKzLmkC/x2M0QpAMBhGX0X/tZVflLyKJLZv/Bc2NknJuxs3p
 87FOTdFBEGkNrsp4JQo3iXhPCO9jG6GEpOcyqKsOUHt2q/DhwMYDKz2zsqsGqMLC8MV80Qp3gK
 sXP+465/nBTawPbpoAAAA
X-Change-ID: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764668249; l=850;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=oESxKx1RpmIZ6LCbhSz860yg570UydSth6PJf3k8w58=;
 b=zjql49o962LwoA5QYxqgk74mjr/aJPetLcDBGZg2sI5Hne6TnX8Uf//7bl1da+JW+/XyVD/CI
 /gGFLE6bru7BwS9KptoHRVLeKg/8Jor/mbb+tmgszyAqQKrsRmarmga
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: uJom1LVd4qQDYDqLEv_EPfoAY2NoYKy-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA3NiBTYWx0ZWRfX3+wOBetb3XTs
 +raCtTri/WcAv9P/+PpnxD4QRX5MITGWkLuCUcvW0uCsYeDeH2he1R4Jw69B1qs47jnK1cNz8nP
 NRfkmbK+utnakHBeUlv1tNqDVkAB1AzBRvH2I7yPYinTB+T9S+aYJH4Bm3wJlVNihi1tb5L6S6g
 D6jdPn2XL1BfFjyMEjAwzbHqqGNCvLJVp+mIVb9s9mUs1WWLtOkzZyoryiXe/vENaXsy9DMsq5q
 DSRTAMWzFz4aTbuhLPFz4d6YhzhQrHmRsrlN5zEb/Bb8A83M7UhOx6ATQQqqzUX80ZtInW244qa
 O777/uUKiKRqszk+yHrWDlA7+kiXq6FY5hvWOBqI7QGzq7YZjupfqmrjgN/PeqpCJDbAxA2KOVq
 4K49P4cIIo7odshNJNq3/cupFPvTRw==
X-Proofpoint-GUID: uJom1LVd4qQDYDqLEv_EPfoAY2NoYKy-
X-Authority-Analysis: v=2.4 cv=EbfFgfmC c=1 sm=1 tr=0 ts=692eb35e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=hNBrZjDF53sj-vqV-FwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512020076
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AFDF74300F
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,mx0b-0031df01.pphosted.com:helo,mx0b-0031df01.pphosted.com:rdns];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[202.46.23.25:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	BLOCKLISTDE_FAIL(0.00)[202.46.23.25:server fail];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.214.198:received]
Message-ID-Hash: UU6T3V5E5VUGP3DSTOMTLF23H2JWI4RX
X-Message-ID-Hash: UU6T3V5E5VUGP3DSTOMTLF23H2JWI4RX
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UU6T3V5E5VUGP3DSTOMTLF23H2JWI4RX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Enable config for the QCOMTEE driver to facilitate communication with the
Qualcomm Trusted Execution Environment (QTEE) on Qualcomm platforms.

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index cdb7d69e3b24..57b2b09d0479 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1789,6 +1789,7 @@ CONFIG_FPGA_MGR_ZYNQMP_FPGA=m
 CONFIG_FPGA_MGR_VERSAL_FPGA=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
+CONFIG_QCOMTEE=y
 CONFIG_MUX_GPIO=m
 CONFIG_MUX_MMIO=y
 CONFIG_SLIMBUS=m

---
base-commit: 47b7b5e32bb7264b51b89186043e1ada4090b558
change-id: 20251202-qcom_qcomtee_defconfig-8dc0fed1411b

Best regards,
-- 
Harshal Dev <harshal.dev@oss.qualcomm.com>

