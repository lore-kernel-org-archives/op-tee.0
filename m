Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04896CC6B3A
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:41:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 486FE4533E
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792064493;
	bh=lPjdyCOkF7hhGTqyY2tvrzWLFaMe+jldrt2xpg8xHg8=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=vfwG/FCw3yWvi0M6BEV+6rdPwgz7iExFBCkXHvNHjBqTW1w3yx81rsYjx148FR0gX
	 +8gYm51dRHoKGQaLlOdJHz94sVKVMAHZm7WjXcrRPrZKNPF3PAcmbHO/tI3pEqkEKZ
	 EY/WJZvuFW2ouwZE7GStYbfdkQyjzggwLJVUDHp28xvI5GdYJ/2O4POKzwQKnmZk/C
	 BEeQNz3lrCwHEPnEQKVo6GX6Crjg+vsQzDs73KMkcQmLM19CmnkS9KIjPYDSv0ps6f
	 vz7y3zgga6GJFWV+FuCqMyf7pe7lQZglx6pw2hPmRlk6i6t2PFzva7w//u/pyF+/PK
	 00BfCgZJ5PpHg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3AA304530B
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kh+KNqVs;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SDAxTKiv;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69FAPilK4100281
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tVhYXxbl/sJISLD/HLgal9KIlsatQYaS7bV5YpSMSB0=; b=kh+KNqVsscZxNerH
	pagiHZDVer/gHn5W4A7QNRAot3HfBtJ38a6HPWRgcd//1L2o0u3/AQTBuRPB6Yx+
	zuCVcp2Alu2TUkpW8xfN7qdaqCw24SKsoRz+UGe7Zipmr0mRe39WoXS/GBsv1cgW
	Ng8ozAVG+ZFuVxkpc+2faaRBBs/an0++dVqxiYNCnUm9giKsB3eC4xTlLBe4X/B1
	bB6NPeuN2PSUzk10hRXwpaptSbfyjjWZ91GdbpnGqMcz7UvCyWqmVAw29TgW5IFO
	HPWMLxY2lf8HgzB7rsQLWj21wERz+uAOjE91wLwFMCNutvyeseuX+RCMkj+s+rtw
	L7ax9A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2r88vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:01 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-351788121cfso11078024eec.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064401; x=1792669201; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tVhYXxbl/sJISLD/HLgal9KIlsatQYaS7bV5YpSMSB0=;
        b=SDAxTKiv2RknolarlqrR9NqZKXm2+/YEfoTV4h4qKS4XgQgW+6HXgl618+xL9sbe60
         wglCtTtQHJ5ZFVAhod5cqgpYWtJIMj04t0FNCgp8OlznWWLG2tHpA11enuz6uRzc9dbg
         Ph5mb9Ga/v3KZ3yMptGFzVyomkY3SBx7Fo5oavW2DDDyp8WTWGweHOJ3kmihhAKqFr/a
         U83YeeGmh7PP5I/m9RfCDw5g2ds/HQSBiK4tsjXPqg1RgubkpwyIB0h4z16REssrH5U1
         lWzGaI6Hj8HRBEXTtN9pp0uFlJKGU4BVLYC3o96UeFUVAXZ5YOzNq/egBHz3aNj4jcu8
         e9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064401; x=1792669201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tVhYXxbl/sJISLD/HLgal9KIlsatQYaS7bV5YpSMSB0=;
        b=NDJqDWQvSLWhGqi4KIrLkxA2r0UigTMZ/DeD1Z0iP2NBNgN/BkBEzwFlj443//B73u
         s78xBgfkrlG3CJl9vler9BQn1ZrkIBNUVH+yd055ZC1sHfENDSicdFi+xkiorbHExDnT
         5jAHavkBVscVE6MxvQWkcQK3A5RHW+cVdvlU3a4kl4197CYplXcSnjnR8tuGodgAxLGl
         WGhbfe+q4+Bl/IWPGxEebTBZPC0hPHFGXoorV4zWdV6Alk/BoCQ5ArST3Zbn8k8fENb0
         betJOQUs/M7GnOFEIOosi8k4vzUZ+duf7lDYTmZqDgaKlDfg/6TYYx+Ef4bp03t2lIvf
         Yolw==
X-Forwarded-Encrypted: i=1; AKwUvBygPkMYPvxrpOp7jCASlaQg6ORUxleg7Z7wUR+IeuYiq4YJoyWzdEXKiFbqCAUispqEvNB7oPU=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLC2atWfDLE1uUmC2F/wwMq8T0/cl66WJzwZkIfkjP7cTWvp6DO
	jiKZp3qXL70ZVJwhKYiTKzQppuynmseCHInmDLxkS8URrAPxwXZ+/KvPTRUYLlOezY94DSyb1dl
	lJmwkcVU6yzNMJDvU3cHMuQSoDpB9+5JKwn9AzxBMBwtk8amcPepl7h/PoXWqljfcfVHsKW7s
X-Gm-Gg: AYBFou0B9tQxD3UyBIPFN5wYqB22IrvnfAusKCJoLc2dghK9ODl5GZSzDKw8gMMD9+X
	hzJisO1wVTo/hHVZ6ouXu3+rWO8jjkhKp4yfcxsVZja/mQZy3NSFOfUh20DzzyHX5h7EEL6slB8
	jJAoZEpRvrt0V1CRtV1fk+sMDUypJpLm028eB9Dvrry+h59Rg3nUhJpUDdsNK1ZWnNyjtuRIAwj
	djYoTVZJbwEq1HyZvbbth3aLFegVf0a+55v/xgzoiFve0RW8yLrbn14cT8o6LBIIfgClLatoRIA
	Kuk4v5a6ovhH9MbskJkvg3Dz6q2TsA3HBTSu+oIF75HPNz0EZa8LCfyKy0wvOcVknfuB2MYJ/KD
	TvxItsQ3LwKjEU5K/xe86YUMMmw==
X-Received: by 2002:a05:7301:305:b0:35c:4800:4da with SMTP id 5a478bee46e88-35c48000c80mr12251149eec.41.1792064401046;
        Thu, 15 Oct 2026 04:40:01 -0700 (PDT)
X-Received: by 2002:a05:7301:305:b0:35c:4800:4da with SMTP id 5a478bee46e88-35c48000c80mr12251112eec.41.1792064400386;
        Thu, 15 Oct 2026 04:40:00 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm48144891eec.11.2026.10.15.04.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:40:00 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:09:37 +0530
Subject: [PATCH v5 3/7] tee: qcomtee: Allow object invokes from kernel
 clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-3-1460691b35d3@oss.qualcomm.com>
References: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
In-Reply-To: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-0-1460691b35d3@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792064379; l=7565;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=29af5q9fQmVOjaxOvDgc+bJw1fOgZLvO5f4FLcvore0=;
 b=il0JYQstaGf8x0tJ2BtrCgUT2IgG4+AE+2L4jT4Bci7G/TVoSzB7boTd7j/KwA+jESTcoajt/
 R0HXHW7+Ae3D7uojwKc8OFqDBqECIb/PUaMPROIDh5E3C+r6YdRJEI1
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX+oe2wDE38N1q
 nPAHoeM27Gf6S2GpIhwxEkbutgCyrho91DGT5DOmO+/psjtvyP/lKFEhspfTRVj3BUnrn24AawB
 GxuCGwx89fRyqdZiSDwfyb1fVKPjRDQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX0tLUqtkAzbsy
 eSLsut654oFovcbalLqyXvlhYtcdcCJ7EEpcAXQxgie1TkHSBAU/ZWVOIF8WqOvendSkuDAqYRH
 1EQT8H/CcP0Yh8nrtYybCFoN4F0xMdLDvxBmb4CW2CilVC7BeS8uc4X+Rml6FGXjbsKnGI8/v7/
 chMteya1jQQphdYoRy3V+TFfHKH5UAi1qZPpT9wqWJG3ARKw83MNgtbsJwZyvTL4PWf4H+xq5D4
 SZAw/c+/k/R8RUf6VX122Chff77cGdxKzG0AtTXJDQzDt5l75THR/KqF9L9/Hf1C8KD2uoY0FCc
 h214CHyKKFscC3pFhbznyoNbjElfe2OlNcAV9OyfJzChFxeeY6+ZiwkpYQXgE0/ryQRVXMV/y46
 rb1E0Su5dx7REnvBzj9f8gDc+6ciDD06NN4ezV205ZTA1N+sTIHieUgneVHebx7MO+SxuBE1UsG
 +0nZ57PjfEn4GwYW8jA==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad0bb91 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2fm1Try5a8I-Yd-RT8kA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: UqfJSLVOm253QdEnpcXTRL2I4ityIWTP
X-Proofpoint-ORIG-GUID: UqfJSLVOm253QdEnpcXTRL2I4ityIWTP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.197:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3AA304530B
X-Spamd-Bar: ------
Message-ID-Hash: UYAVAXYTHUBOPLLFFOWJXCHEOE6JGYPE
X-Message-ID-Hash: UYAVAXYTHUBOPLLFFOWJXCHEOE6JGYPE
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UYAVAXYTHUBOPLLFFOWJXCHEOE6JGYPE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

QCOMTEE currently treats UBUF parameters as userspace addresses and
applies userspace restrictions when invoking the root object. This is
not suitable for object invocation requests issued by kernel clients.

Use the kernel_ctx flag to distinguish kernel client requests from
userspace requests. For kernel contexts, do not mark UBUF parameters as
user addresses, and allow permitted root-object operations to proceed
without applying the userspace-only checks.

This allows in-kernel users of tee_client_object_invoke_func() to issue
object invocation requests through the qcomtee backend.

Co-developed-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c           | 38 ++++++++++++++++++++++++------------
 drivers/tee/qcomtee/qcomtee_object.h |  5 +++--
 include/linux/tee_drv.h              |  5 ++++-
 3 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 3de54af45719..c97afaa1b4aa 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -193,7 +193,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
  * @u: QTEE arguments.
  * @params: TEE parameters.
  * @num_params: number of elements in the parameter array.
- * @ctx: context in which the conversion should happen.
+ * @oic: context to use for the current invocation.
  *
  * It assumes @u has at least @num_params + 1 entries and has been initialized
  * with %QCOMTEE_ARG_TYPE_INV as &struct qcomtee_arg.type.
@@ -202,7 +202,7 @@ int qcomtee_objref_from_arg(struct tee_param *param, struct qcomtee_arg *arg,
  */
 static int qcomtee_params_to_args(struct qcomtee_arg *u,
 				  struct tee_param *params, int num_params,
-				  struct tee_context *ctx)
+				  struct qcomtee_object_invoke_ctx *oic)
 {
 	int i;
 
@@ -210,8 +210,14 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 		switch (params[i].attr) {
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT:
 		case TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_OUTPUT:
-			u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
-			u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			if (oic->kernel_ctx) {
+				u[i].flags = 0;
+				u[i].b.addr = params[i].u.ubuf.addr;
+			} else {
+				u[i].flags = QCOMTEE_ARG_FLAGS_UADDR;
+				u[i].b.uaddr = params[i].u.ubuf.uaddr;
+			}
+
 			u[i].b.size = params[i].u.ubuf.size;
 
 			if (params[i].attr ==
@@ -223,7 +229,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
 			break;
 		case TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_INPUT:
 			u[i].type = QCOMTEE_ARG_TYPE_IO;
-			if (qcomtee_objref_to_arg(&u[i], &params[i], ctx))
+			if (qcomtee_objref_to_arg(&u[i], &params[i], oic->ctx))
 				goto out_failed;
 
 			break;
@@ -260,7 +266,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
  * @params: TEE parameters.
  * @u: QTEE arguments.
  * @num_params: number of elements in the parameter array.
- * @ctx: context in which the conversion should happen.
+ * @oic: context to use for the current invocation.
  *
  * @u should have already been initialized by qcomtee_params_to_args().
  * This also represents the end of a QTEE invocation that started with
@@ -270,7 +276,7 @@ static int qcomtee_params_to_args(struct qcomtee_arg *u,
  */
 static int qcomtee_params_from_args(struct tee_param *params,
 				    struct qcomtee_arg *u, int num_params,
-				    struct tee_context *ctx)
+				    struct qcomtee_object_invoke_ctx *oic)
 {
 	int i, np;
 
@@ -288,7 +294,8 @@ static int qcomtee_params_from_args(struct tee_param *params,
 			break;
 		case QCOMTEE_ARG_TYPE_OO:
 			/* TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT */
-			if (qcomtee_objref_from_arg(&params[np], &u[np], ctx))
+			if (qcomtee_objref_from_arg(&params[np], &u[np],
+						    oic->ctx))
 				goto out_failed;
 
 			break;
@@ -304,7 +311,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
 	/* Undo qcomtee_objref_from_arg(). */
 	for (i = 0; i < np; i++) {
 		if (params[i].attr == TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_OUTPUT)
-			qcomtee_context_del_qtee_object(&params[i], ctx);
+			qcomtee_context_del_qtee_object(&params[i], oic->ctx);
 	}
 
 	/* Release any IO and OO objects not processed. */
@@ -357,7 +364,8 @@ static int qcomtee_params_check(struct tee_param *params, int num_params)
 }
 
 /* Check if an operation on ROOT_QCOMTEE_OBJECT from userspace is permitted. */
-static int qcomtee_root_object_check(u32 op, struct tee_param *params,
+static int qcomtee_root_object_check(struct qcomtee_object_invoke_ctx *oic,
+				     u32 op, struct tee_param *params,
 				     int num_params)
 {
 	/* Some privileged operations recognized by QTEE. */
@@ -366,6 +374,9 @@ static int qcomtee_root_object_check(u32 op, struct tee_param *params,
 	    op == QCOMTEE_ROOT_OP_ADCI_SHUTDOWN)
 		return -EINVAL;
 
+	if (oic->kernel_ctx)
+		return 0;
+
 	/*
 	 * QCOMTEE_ROOT_OP_REG_WITH_CREDENTIALS is to register with QTEE
 	 * by passing a credential object as input OBJREF. TEE_OBJREF_NULL as a
@@ -430,7 +441,8 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 	/* Get an object to invoke. */
 	if (arg->id == TEE_OBJREF_NULL) {
 		/* Use ROOT if TEE_OBJREF_NULL is invoked. */
-		if (qcomtee_root_object_check(arg->op, params, arg->num_params))
+		if (qcomtee_root_object_check(oic, arg->op, params,
+					      arg->num_params))
 			return -EINVAL;
 
 		object = ROOT_QCOMTEE_OBJECT;
@@ -438,7 +450,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 		return -EINVAL;
 	}
 
-	ret = qcomtee_params_to_args(u, params, arg->num_params, ctx);
+	ret = qcomtee_params_to_args(u, params, arg->num_params, oic);
 	if (ret)
 		goto out;
 
@@ -456,7 +468,7 @@ static int qcomtee_object_invoke(struct tee_context *ctx,
 
 	if (!result) {
 		/* Assume service is UNAVAIL if unable to process the result. */
-		if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
+		if (qcomtee_params_from_args(params, u, arg->num_params, oic))
 			result = QCOMTEE_MSG_ERROR_UNAVAIL;
 	} else {
 		/*
diff --git a/drivers/tee/qcomtee/qcomtee_object.h b/drivers/tee/qcomtee/qcomtee_object.h
index 5f40617361fc..a241ab657318 100644
--- a/drivers/tee/qcomtee/qcomtee_object.h
+++ b/drivers/tee/qcomtee/qcomtee_object.h
@@ -113,8 +113,9 @@ struct qcomtee_buffer {
  * @b: address and size if the type of argument is a buffer.
  * @o: object instance if the type of argument is an object.
  *
- * &qcomtee_arg.flags only accepts %QCOMTEE_ARG_FLAGS_UADDR for now, which
- * states that &qcomtee_arg.b contains a userspace address in uaddr.
+ * If %QCOMTEE_ARG_FLAGS_UADDR is set in &qcomtee_arg.flags then it implies
+ * that &qcomtee_arg.b contains a userspace address in uaddr.
+ * Otherwise, &qcomtee_arg.b contains a kernel address in addr.
  */
 struct qcomtee_arg {
 	enum qcomtee_arg_type type;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 369c87ad0205..367208210a32 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -83,7 +83,10 @@ struct tee_param_memref {
 };
 
 struct tee_param_ubuf {
-	void __user *uaddr;
+	union {
+		void *addr;
+		void __user *uaddr;
+	};
 	size_t size;
 };
 

-- 
2.34.1

