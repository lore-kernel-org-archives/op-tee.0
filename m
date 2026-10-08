Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A514CA5FFD
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:30:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B357F453CD
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 03:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791430257;
	bh=KK656IR0L/qDoa9cvBPbElzGR6ihtiMSgVhGCtT9uo4=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=DUBw68hzxCV5cQXXsw4QDyA40Xk5V2xf0t8Hx/Jjd8PCgI97vZpEypNP/SelMBeUO
	 caLEd+J0WI5jngVVoTlek/xYonMPSx3BKjR/siRg6CusfUFoyQAy7zqyrCpe+ojstw
	 wVZ6gR5L2rwJ+7aElUzzVuIZoi5aEaaFRFyGk0N+089coqNmuK0Kg6+LWEeqcANLlS
	 ngqEb/caaw4VqKjJRFlTcMgBHSJg5O1U2O8cvz1F6saZmUPQz/8062MvwM5TOMgp8M
	 upsivkdqmrUKiG2MVeaX4W4SvE6Tr3Mbe/wC/TC8xV9Aj9jSw8u+bvyyRrnvFt9OBs
	 MBGp7wruh0jaQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2063B4552B
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 03:28:49 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FZUPGItB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KfUtPgID;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6981hnEn608080
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 03:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZMbjzTGadlfykU/nTDUxL8dMYc8O8fFEzaAJY3fPRwI=; b=FZUPGItBETjdAzRL
	B5pYQ0wdEFStWX658zzZwawaBvk8UQqPRLzn1gdXOjsQH+Y6RpJxIhfx+RXHVq1S
	Q8ujP9tKCD29Y8tfRQ7XwoeDMimSkOxCFvbWDg+KXralawm13fxaeCxcNNHSw9k7
	/Z6LCq8fKQ8j4lFpSIuWBiqS5YkX4KH1bgvPDfB/R46dF5oyICNfUwFv4LT9s00U
	SWpcuQ4WJGRkkvp3Jsg/GXA+7qoYWD7sHuz1GCHfSvmoJQddbQ2XejRgc9d+cBQJ
	HtCHi+RpC1dlf1QcSwoy0HvQQpIs4xnDcqfa2HiooqNTqSNY1JAe4CJ9rBBFrEeY
	yTWnog==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2rwpp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 03:28:47 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30f1b904861so6338976eec.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 20:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791430127; x=1792034927; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMbjzTGadlfykU/nTDUxL8dMYc8O8fFEzaAJY3fPRwI=;
        b=KfUtPgID01Ss2pNeLSJqDhD2wNYd1j5qOYMHIgQYppEvHDA5v7dBU3y65TpY2MxLOq
         17lbpxhTGddYugqP9br5UsOpPH2ZMK8QmjRJZNlkozbBc+WwX7FoTlpeSoiYbASfBnP3
         lqxc96e08Qh4H55fUXi1TsPbEGTEWJ0xm1DWXjxllH32rdNzH+rnAMSD/oeziJnAx5SU
         1Tasi65dd8tlee+K4OCb+0CAHNFiVTMS7DyELpnA0q8Wm6gXJCK+1u9xMJyxy2XB3rr6
         8prYe6wLLqVEvmFr4I2Kzs3uW35O9xrCzxcsoFMSVNKKaJaz5uIUB0I4sDUfv1yuAi+g
         2zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791430127; x=1792034927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMbjzTGadlfykU/nTDUxL8dMYc8O8fFEzaAJY3fPRwI=;
        b=yDk8qGHFfeI47gSsh/RqrMyPh2eiAMxHGUBcYffzSJzFIhj1fqIoY0Y6gd4FJhWJGU
         3eovVe5xK1SPwmodoasTDP7E2qp1Xx1BMpfV6lQugVh5TLKHBCFPSZO8z5ZWPBwIorKl
         hrX7uX8iOAJUojD0F2PWb2YPs4hhxosD3/04+3CPBGpazuapXZxZNBujkOqA+nvzWP5m
         8qV8Ei+y7LTPYdbHMkM3y2njPnSdg08NFqvmZzpZwWfzczcFUFj3J3JRGmL3hmMW4Drz
         CfHPVlMTfkDR6jXsMEwRa5HFw5i5xTLMUSRhlNB1qrZd1SWkGZ/VNd2pZUeIAXOCHxFK
         cYRA==
X-Forwarded-Encrypted: i=1; AKwUvBwDzCC6TauRMNYBuU48YvV8cIOVo+6475jkVlIDVac+CVo5NmlHqg4HwhMPBo87uJnPqzqqPwU=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKt1K5K/7W4FHDWUbENDTqNc+bZHKyvODNYWDhNqyNhaGzONXXu
	dDCPzVKpszfe5ED3u88N2b5eP6Rj2T27Ay+FTtnN5LK/JQ8d6Ej3hbSkkVruzdXHaI16QJ1DQzF
	T+34tTntnV2SAkDT9QJs6hhf8/ZvHC4gU3TfJB1qP3y4Po6IprW9OyStX7L2t+eriM6DmML4=
X-Gm-Gg: AYBFou2PFTbbmbrDOSLgw/BssNaec+1fiZLp4pvrnFgFoRH6Gx/Mmkme7zDQxizhNa/
	m3t2OkH8VSRFzb9ZmB+x/obRwWNNe5llpO4hpJ/ED4lK2HFHsodxXK8GPZiVaLxTZidnTA5karp
	21AQxqNUrJ0iPJR04t27ghVLPbzmqoKv2tXqypf8VbAtPkjWWkHMZyyKlmszLEVVKpEpAqhqcFA
	utkcbJGUPRF2XgcA7nnh5sc2kK0BvPBywYex8kLz8O6kRxUVy27yY+7xlUncunR2ON/GuRZYiXu
	z8dcqkXNCiIr8EoV5RoePxdqP1Lz0+8fp2seJEAwEyXyMTP8uzx32xtgfgYLD4OgkcbC1sJExQn
	NYcT3UzIFSYRjx9X+kfGo4t5L2sO+P/Y+A3pGTtn5RHGD8sy0PFKu4RN6VQ==
X-Received: by 2002:a05:693c:894d:20b0:34c:3ae5:c280 with SMTP id 5a478bee46e88-3515dd030edmr4864980eec.10.1791430127158;
        Wed, 07 Oct 2026 20:28:47 -0700 (PDT)
X-Received: by 2002:a05:693c:894d:20b0:34c:3ae5:c280 with SMTP id 5a478bee46e88-3515dd030edmr4864931eec.10.1791430126393;
        Wed, 07 Oct 2026 20:28:46 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35179d07566sm2168349eec.30.2026.10.07.20.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 20:28:45 -0700 (PDT)
Date: Wed, 07 Oct 2026 20:27:10 -0700
Subject: [PATCH RFC v2 04/10] dt-bindings: firmware: add RISC-V RPMI TEE
 transport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-riscv-rpmi-tee-abi-v2-4-45939a13d223@oss.qualcomm.com>
References: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
In-Reply-To: <20261007-riscv-rpmi-tee-abi-v2-0-45939a13d223@oss.qualcomm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Marouene Boubakri <marouene.boubakri@oss.nxp.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX2x9GuuwyuO80
 Ex5if5uGIiaMibqxvYoHUAFBzDjvbXoztgQ/T/F7gpLvrFmvXYXd8/HiOE61tCdogoAOx18CO5j
 +PFav23ac6kz9NV7HlAlwJ480ZpF5cw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAxMyBTYWx0ZWRfX+oz1IyzvgGBt
 6MFxipuH0c5f51gETMndIz5x0dKUCW1a1kjynxwqxmBRjGKQ2fE/kxThABpPPLtRXxCWaHdoNKJ
 bHiy10kdLf0oBoXT4a9lP72SNsPHf+upK1X22DWUBXG+7pEKw38dLflZSMV1B4HUMvH1fXn7jpz
 bya957mJTwvM6glm8q2a/B6m+SDk5VSG/lRY0gYX8xavpFlPSI3V+DLLysoWMQkkNZWiXgV+9EW
 DxAbVDS1d5hlMngk0U+Q2+7WVj8fL2/Zmdalzb+jkaqg/91DA8WQYbx86mzVbrOShkhG/L1fGdl
 w9ptlxdjMm6R5JSMXKD6cmuXOUf5ZPdlSKc+VtbL+FQHAOKuea5XsmUn3WNPMGZv0BRB9Rl64DZ
 pG+ctDRMai0TnRpuXYPmS3AHiwGBrkqgQExixhC5Urlw4C+vg6PrJqbxby/SaWKvyEymF8n65o8
 QsYU2eEZzU0ZjX7rrtQ==
X-Proofpoint-ORIG-GUID: k_MEFk99trwzWh1uAxU_jEupxM9bdyc_
X-Proofpoint-GUID: k_MEFk99trwzWh1uAxU_jEupxM9bdyc_
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac70df0 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=X9k_jdDNchH65YliorYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080013
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.29 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	SUSPICIOUS_RECIPS(1.50)[];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org,oss.nxp.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	NEURAL_HAM(-0.00)[-1.000];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2063B4552B
X-Spamd-Bar: ---
Message-ID-Hash: OI66PUC2KTTHH427EFHWX2MHDD7TZUZL
X-Message-ID-Hash: OI66PUC2KTTHH427EFHWX2MHDD7TZUZL
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OI66PUC2KTTHH427EFHWX2MHDD7TZUZL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Add a binding for the RPMI TEE service group carried over an SBI MPXY
mailbox channel. The transport uses this channel to discover TEE
endpoints and their services.

Require a single mailbox reference. Notification interrupt information
is obtained from firmware through TEE_PROBE_FEATURES rather than an
interrupt property in the TEE transport node.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 .../bindings/firmware/riscv,rpmi-tee.yaml          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/riscv,rpmi-tee.yaml b/Documentation/devicetree/bindings/firmware/riscv,rpmi-tee.yaml
new file mode 100644
index 000000000000..b7bbe8893e56
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/riscv,rpmi-tee.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/riscv,rpmi-tee.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI TEE service group transport
+
+maintainers:
+  - Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
+
+description: |
+  The RISC-V Platform Management Interface TEE service group is carried over
+  an SBI MPXY RPMI mailbox channel. The transport discovers TEE services and
+  creates child devices for their endpoint and UUID pairs.
+
+properties:
+  compatible:
+    const: riscv,rpmi-tee
+
+  mboxes:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    rpmi-tee {
+        compatible = "riscv,rpmi-tee";
+        mboxes = <&mpxy_mbox 0x3000 0x0>;
+    };

-- 
2.34.1

