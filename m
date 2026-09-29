Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF10CA5FAB
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:21:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2BC6B454BB
	for <op-tee@archiver.kernel.org>; Tue, 29 Sep 2026 03:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790652116;
	bh=ylXzUuTIz4l9YRe/EquAV7rS8KwuDXeJiQfbzvSBq/c=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=jEJSsiLKzyL834QIQSXcWNDiBE6wpCydDqtKEx0yYVnzkZjrA07SE5yGVDsTlfbZ+
	 beqRbipEb7gp6JdMKdOUjQOPp+q7DhWez9EsTfAW0M5nDn3lJ9akEyYOlqtLFOZjnN
	 iWHIK4rtBeSF1ZXTwTbYXtEdPHBGOEj2fHgf1U66kQRrnXnpdev/g9EwNXyrIduJS0
	 n9nsdLaZtJQIN9oqIpVzyckswrg4wIHuUNWApmfiyArHND/PzwJ4cHnsBYH5CxnGnR
	 vxaUQPvteyhR0o5rO0+U4viiu4AvT0ntBrqfBRaG1LuNdKiFzcJ5e0/dmV7ujrx7Lh
	 gcElHwPUWKKEw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7338C454FF
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sn/nVrmS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kt9zZ1IC;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68T0ibSs4180024
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9ov8W6fE9gqAZsQlIuIktm/LEGd+4kh4Ula1IscwgI=; b=Sn/nVrmSAs/z35+b
	i52DBtVuzdBRekqSzu2e++XRcRt4n246q4TZ5tP2rSTkJL2T15PNxb4LNpzwgePl
	sZaS2i69xNG/uYeBAmsIVofoGMK51wRi4kHGxs/ZSjBXyM8ErgEeDduwHICQ9ofW
	PUDPU8miEzus2tOLgNsWvdGCigN6h1t+BlCnt2EKY9dns2+PX8dO/ARsuidEkAn5
	icIM0pdkearuVJ67tYifd/NlvBAxgdolZNaTuGAm7c/PxDcLzbjlg+w18Yz60yyX
	w3QIcVdRyoGq8H5EKJMv3inlpTVeJ8sooMjM2Wdz6fk9DOLdvaoaIT5BfvbGifSg
	AxS//A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyxmu9c5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 29 Sep 2026 03:17:56 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-34344599f01so1604229eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 28 Sep 2026 20:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790651876; x=1791256676; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f9ov8W6fE9gqAZsQlIuIktm/LEGd+4kh4Ula1IscwgI=;
        b=kt9zZ1ICclBkP5YRAXHgGuQaNJv8SUg7KaR/QioU5ywxvLiXv4yW0ydcVwIIW8Pg6Y
         0G+g1duNKIZdt3vxzwERbbo1xw16F0LIbgL+JvYMU6lPmPwQmzI7GqhyYZVBn3QboiMK
         oP145aWJDjHOs8ULGs5QJNJL+echPsE30DtlxSqWHTxu6CPZtgsBQUoRVrU6+YgrLMF2
         S+dCRMQAeJC8mzvtH/U7AAuiuuZq5AaNTFZZ48EosQ719R5CGDjlVseB7VF3sJEY5nwt
         X67a0FAwaLKIaJRI6xQQB4H/Eq5f7tumURqc2rBA7mVJvAixpJjtWbQsJJjIKd6xu8uG
         enwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651876; x=1791256676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9ov8W6fE9gqAZsQlIuIktm/LEGd+4kh4Ula1IscwgI=;
        b=pk1MpyZclHwx1n5R8ZeuKeZf4ZwOqSAU6cTRPl+3IuY62z2y5Ar5ZHMC/HObf14ZSJ
         4ABSk1XWTVvBQa2aHqyoWCgPjJpxd16QhEF0Y94GdYw1v74VHJdlg483y7hNdWbytF9K
         bHdYRCzwLNFMJAHOvagfzGNMiRdLIT8qAzUcW2ha6lf6Qs52xhcWmsc5YcWwFcZmMFpj
         A97KqAID7MUhGpSs8DSeW3wPYimswepvz5zv4C8Ie+K1VNAYjf4P+CQyxnR5RtvawTUM
         SjeUhS2FIem82OAasamx2+bYS5QBIMKK32eBIw+juIzfaw89mUsTBdB2PZIE1r03i4Av
         dzfA==
X-Forwarded-Encrypted: i=1; AKwUvBxqyAaT/8ZaB4FhK+y1MGGTIEYNvxtb/zlGvkaXmPSDxyz+vCADclhSw5JspVdeQOSAD46l22U=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++k4183fuZQEEHld12bDmECK7bpJX+RZPVYnPopfjVzIPf2vESvf
	J8LQ5hFSGr4Hr+KtPJybaF0C2Iuu/YoOwZ8kTmRk2z/HlirYyMDJsNrwQGODI0FCr6baKzmfbTj
	Tn7fsSF0SQ9xqoYAIDWFLdC3CL5zoltpTNkETwyGyYwRG3iGfu/AJyacGbdPcH2yea8kn1JY=
X-Gm-Gg: AYBFou1H7tMLCQykTfqj4y/DrUs9xswnrl8wPoazR9HNstSs568bPL1CKSZ88oFIKuf
	K8Lo8iipw3WIuPthzFcE+G1j2/0ZnDmIpBSzH8F4IkBFjqi1HLl9eh4rDDueXpbh+w4iW3t0U2z
	JMXyRKTzdRE5Zt8MlHy5uctuX2zoPveS7t7qe8iagNBTj2lPbgP2Yy1GyObmhCApHAcixZj5g8Q
	a8oiTJkIHOW5jhD+ABGNFYJH9lUXJb3Uyuo6YvBaK0DgoDSJbMLow8nzPuzQS0N7TSDGHgdu9fD
	JhCqdDhbkZ0byqx8AdsLCRIt9ILxR70RtKzc4+3p8urV+GUpRGDtAJ17tuglMblulIUTCfpSllL
	6WAT+x+3LcierCUolObWU7WyW9IBswRMYdsd180xD0uSW0dyqF9DUMT9O/xQ=
X-Received: by 2002:a05:7022:28d:10b0:149:8354:ba29 with SMTP id a92af1059eb24-1498354f52bmr5383830c88.8.1790651875708;
        Mon, 28 Sep 2026 20:17:55 -0700 (PDT)
X-Received: by 2002:a05:7022:28d:10b0:149:8354:ba29 with SMTP id a92af1059eb24-1498354f52bmr5383798c88.8.1790651875144;
        Mon, 28 Sep 2026 20:17:55 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145ad4028a9sm24789368c88.11.2026.09.28.20.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 20:17:53 -0700 (PDT)
Date: Mon, 28 Sep 2026 20:16:59 -0700
Subject: [PATCH RFC 08/10] firmware: riscv: rpmi-tee: cache TEE
 capabilities
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-riscv-rpmi-tee-abi-v1-8-04908b81d885@oss.qualcomm.com>
References: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
In-Reply-To: <20260928-riscv-rpmi-tee-abi-v1-0-04908b81d885@oss.qualcomm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>,
        Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amirreza Zarrabi <amrzar@gmail.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX8p6T+QVbESKQ
 LPMXYWsGInA2yF4X245Kuh+JxvqoDGl+6f1I+xp6zchtt27diqaQ1yTvyvCmd0BmxZva0kpyMem
 mcZBwTicIoYcD7pDAidGVqKUTDv9xKTdLOdlBLp6Bud/mmFFVpe7byts4bgSNasIQAWT7KfRvwY
 YgOJssSCq1s2MlB5nd0MxXDYyMaEeIfigaJfiAzgKbSNSXc1O/U78J8toZpkucMCboNy97KE6EB
 J54COGdBR5YKOhvHqASZ+urTliJiP2YqhWuPrXfaI2V4QtXjeBEtBbaj6I4QpZcROJmeFbKoapb
 jv3q9pK0f/YJAiDVc6ejnRrFYtYRx2ORi6ywTip5hPBfRDgAo3xDrBXLotSHcwYgyEylfIyR2w1
 SjA7g9XJkuuN85eeqfIhjArHYzwhIjol9r7I7yKZ5/mTO2CHz+qMrwCFXzS5zLM5kJjEaLInzAj
 BN4mNlBU7FAo0i9sPyw==
X-Proofpoint-GUID: F8iTLty3-n2XdLgPnLLLPuEyW9BWaxOG
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxMiBTYWx0ZWRfX7JTX9u+yMcN3
 75e8VRKpo982kf2o4S4R96jqnoCek8xzQqiO0ac0B7j79i9ho/tBfeWyRTIUFUtyFjxA1BRo44E
 h1AJ72737VFyRqx4XHHDCz2rpVtpvqU=
X-Proofpoint-ORIG-GUID: F8iTLty3-n2XdLgPnLLLPuEyW9BWaxOG
X-Authority-Analysis: v=2.4 cv=c70+0h9l c=1 sm=1 tr=0 ts=6abb2de4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ViJ-rRY3MSY-B2NivjAA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,summations.net,brainfault.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	DNSWL_BLOCKED(0.00)[129.46.96.20:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7338C454FF
X-Spamd-Bar: ----
Message-ID-Hash: QLG2SAKYNXF3UMHSHXVAK4Y544ZBLUQU
X-Message-ID-Hash: QLG2SAKYNXF3UMHSHXVAK4Y544ZBLUQU
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QLG2SAKYNXF3UMHSHXVAK4Y544ZBLUQU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Query TEE features during discovery and cache memory, multisegment,
and signal-bus capabilities in the transport.

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/firmware/riscv_rpmi_tee/driver.c | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/firmware/riscv_rpmi_tee/driver.c b/drivers/firmware/riscv_rpmi_tee/driver.c
index db3dbab53078..7b06c1f96ba8 100644
--- a/drivers/firmware/riscv_rpmi_tee/driver.c
+++ b/drivers/firmware/riscv_rpmi_tee/driver.c
@@ -25,8 +25,16 @@
 #define RPMI_TEE_SRV_PROBE_SYSTEM	0x03
 #define RPMI_TEE_SRV_CALL		0x13
 
+#define RPMI_TEE_FEATURE_MEMORY_LEND		2
+#define RPMI_TEE_FEATURE_MEMORY_SHARE		3
+#define RPMI_TEE_FEATURE_SIGNAL_BUS		4
+#define RPMI_TEE_FEATURE_MULTISEGMENT_OPS	5
 #define RPMI_TEE_FEATURE_SYSINFO_FORMAT	6
 
+#define RPMI_TEE_MEMORY_FEATURE_UNSUPPORTED		0
+#define RPMI_TEE_MEMORY_FEATURE_TEE_ONLY		1
+#define RPMI_TEE_MEMORY_FEATURE_FULLY_SUPPORTED	2
+
 #define RPMI_TEE_SYSTEM_WHOLE		0
 #define RPMI_TEE_SYSTEM_SELF		3
 
@@ -581,6 +589,7 @@ static int rpmi_tee_setup_endpoints(struct rpmi_tee_transport *priv)
 static int rpmi_tee_transport_probe(struct platform_device *pdev)
 {
 	struct rpmi_tee_transport *priv;
+	u32 value;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -604,6 +613,37 @@ static int rpmi_tee_transport_probe(struct platform_device *pdev)
 		goto out_failed;
 	}
 
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_SYSINFO_FORMAT,
+				      &value);
+	if (ret)
+		goto out_failed;
+	if (!(value & RPMI_TEE_SYSINFO_FORMAT_TABLE)) {
+		ret = -EOPNOTSUPP;
+		goto out_failed;
+	}
+
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_MEMORY_LEND,
+				      &value);
+	if (ret)
+		goto out_failed;
+	priv->mem.lend_ok = value == RPMI_TEE_MEMORY_FEATURE_FULLY_SUPPORTED;
+
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_MEMORY_SHARE,
+				      &value);
+	if (ret)
+		goto out_failed;
+	priv->mem.share_ok = value == RPMI_TEE_MEMORY_FEATURE_FULLY_SUPPORTED;
+
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_MULTISEGMENT_OPS,
+				      &priv->mem.multisegment_max);
+	if (ret)
+		goto out_failed;
+
+	ret = rpmi_tee_probe_features(priv, RPMI_TEE_FEATURE_SIGNAL_BUS,
+				      &priv->notif.feature);
+	if (ret)
+		goto out_failed;
+
 	ret = rpmi_tee_setup_endpoints(priv);
 	if (ret) {
 		dev_err_probe(&pdev->dev, ret,

-- 
2.34.1

