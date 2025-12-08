Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBE0D2CE17
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 02:09:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0354E500A6
	for <op-tee@archiver.kernel.org>; Mon,  8 Dec 2025 02:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765159778;
	bh=3fQ45fmypJKdFU8biOryTsvkA909IucpLjx1Z3EEHfI=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=1++kQjBGLkyoI7lpLwIzL3Vefzi0wl90/mMRxbUWnk7MkmpxIVgLWsIE2gxWMJnd/
	 0MUoMZ1MN6dRJYAXsHhZsBnr98ldKmRQ2Txl3tGNDE35legB5Daog3dCghf+1D47Jc
	 77Csmvd7I+4ipXGY3GpWXMYw2DTG+HBmgG7Bd0s1iqpiW7D6OnsnRtNJfpzknDjfit
	 G5AKcmzM83Lz8PfMn7TJAa4fVMzNsIiRhGfi0eYFioMDY3/dNWGylo2MURDWCKHiGX
	 OULkHpMKNJ73hs5CxSw+pWuJoriH2jGlVPGU0MeqilSqgSEhvF+HFBfbMlDP3qocK6
	 EA5+SNnnidz/g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A00E445451
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Dec 2025 02:08:56 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QcqgUXfj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OsYklcYe;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7LthV92982660
	for <op-tee@lists.trustedfirmware.org>; Mon, 8 Dec 2025 02:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JnwPDCrT/t7
	P0+FTnGBdHYeTzPc9699SERxfezOi6Ec=; b=QcqgUXfjmorckqpM9MOAqwcCtjJ
	sZ9XZeAPz8+NBOGG9Ioa4Otg3wtp/AF+bS8hYWqLO0ag5qQP6EeWezojhZhwsN2y
	cpuE8tWJRcIV96IwKQ6iHHtIN7Xv1T+Ms2koXqsHipHP4tNRA1qTwexs/IymFO5z
	qWAV3TM6nXmn/j2PBzkJYAZ740Svjw9CIGhfSkKYDI9zTyuT9BmMtRkHH/013axQ
	ZePRiWARUcu2wuUoZibLz6FPQiLlqfHBfdzzaPqrzHpJhvV+FhDIo4lhYgezUJ9x
	1hugHd1dgV6dTzns+7A5dMKDSUWgjGwYe784hKf6g3K2VnasKwIsHdKXBzQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avd8e37t7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 02:08:55 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34943d156e4so10761124a91.3
        for <op-tee@lists.trustedfirmware.org>; Sun, 07 Dec 2025 18:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765159735; x=1765764535; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnwPDCrT/t7P0+FTnGBdHYeTzPc9699SERxfezOi6Ec=;
        b=OsYklcYeo2OTkG55TTpfKQIgAG2xUOx78I+SzSzi92gkjF0EO4lp/5Q3GEYhTFPPVD
         4ax72Mo0TsahaC3X7evOFtatmrLg/0s1o9Vc3OHl8aOO3W97oSYjOuBpLoHWHxo50Vlk
         mbTGuBiC67iYSw1cLWr1a1F6OTRVuIbGMfOnQMD4PiRtVdPTRiCHRcNjh0eNeGl9g7nJ
         xYUQ0CwBguczDSc2h2rovKfwxToE0HK54R5o6V7OoLURPWG4LTIkaziTi/ieTihvMA84
         vO0C1EtZh+lLDFmn+Yh4XkxaUgaPwdlITfZvCa11/c7WwzWm5l2+g4vKKTa3DXBs1sr1
         ZC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159735; x=1765764535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JnwPDCrT/t7P0+FTnGBdHYeTzPc9699SERxfezOi6Ec=;
        b=mmqteo55leGIUAGlNAmrg8ZFG9G9Lx9Om3MyPSRrWV8fXJrMXOpcBhcQrrhWVJmXTa
         KORhDZ3h3N/Xpmt+7hicMlig510sm1S/EcOrUP15HM4W2Wk4meGuEctvLq4ZRwWDozr7
         02VI9A87Z4YBl5zF8WTZvOpu3jkEmrkvipiWF0xacLnFRlb4mbs1i9/oaDXQdMN8bR7A
         O/2sFYmbkKv+9ilUXriBke6yu5ixzuHxewmrymIIYEPL5EqPLTnWj2eMo6RG/ezMasUG
         FAGr215i5KlUSNGfY1nwBOatbn/PkzvC01jss61a9T+ktkLF1NhojtP9txvvgUBFtUrE
         A21w==
X-Forwarded-Encrypted: i=1; AJvYcCXXlU6Xby18o7HdJDeE8jeprx8oGYDw3p7rW2KdqxkyI5Uugar/D+PF6+Rd4lDgaIBlrPmexL0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyFrnpnFPGckBmEGNGCvGZvHP64v4FNW6snmqieh1rpJ4741e5E
	q67a6HcXUT465AEppw1/d3mrDdKuOXpA0kHx5dp/1PMcyf4Ae/EJK+dh76nNvmhDGBv7tqM3k4z
	lphqSoK07HvxNZT3BvPXQnKX5dG7aonkqPV3vIdtPB2KMy7/g/VEwmJae/gIidTVp0Q/Ooi4r
X-Gm-Gg: ASbGnctdwNYumJNSEuTmsaflri+f1aeSw6yt7x2iy/m5OlwKrucKMEY7otgyU7QD4q5
	M/k9L8DGJS8n4KItMwKyw1r4X1hprOT7iCFhSGapoiAvx76CYkib9RGlhVmxRvj0Pm+5rKpAW1p
	ek3ctIPAG9/aB6ydpET6IYDE6yAWfky70DqrZ+ZbFOfqd+nxc3oLkw2mCHbDRM4w/G2i6e0C+Qh
	e5vSB9969DNsJXDHy2wU/jSUvo3z35oCqzsTTaIn34JZ6yimKiC7cLu0p0LT6k8zvYKokfynYx9
	qrkjfmCTGyH/Hhtzir3Xt+As46hdTNDCkA0C2G/Qe2cxHFWgI7UOsm794hPtWjqrlVb3/65pYBz
	vtQyxp/sYdb53vYxPTObnRR3Vgr3hWeIJ2VQjIzmZX8mLH3SZcwNwSAQG
X-Received: by 2002:a17:90b:384f:b0:340:c070:82d7 with SMTP id 98e67ed59e1d1-349a2656062mr5302174a91.35.1765159734852;
        Sun, 07 Dec 2025 18:08:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED9iRqsVBHLEYuDWFhUVgjURXDkSKM7Kyq84RHO7nGLsTcALh6RIiWHvizgEjW2lez0PP4dA==
X-Received: by 2002:a17:90b:384f:b0:340:c070:82d7 with SMTP id 98e67ed59e1d1-349a2656062mr5302155a91.35.1765159734354;
        Sun, 07 Dec 2025 18:08:54 -0800 (PST)
Received: from quoll (fs98a57d9d.tkyc007.ap.nuro.jp. [152.165.125.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34986460717sm6481676a91.5.2025.12.07.18.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:08:54 -0800 (PST)
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tee: qcomtee: mem: Fix confusing cleanup.h syntax
Date: Mon,  8 Dec 2025 03:08:46 +0100
Message-ID: <20251208020844.5310-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20251208020844.5310-4-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=3fQ45fmypJKdFU8biOryTsvkA909IucpLjx1Z3EEHfI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpNjMtFhKJjHKCTwIDozXaeQyapbxESQyhkRz6T
 m+lQwTxOKyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaTYzLQAKCRDBN2bmhouD
 1+JyD/0UQqlFKSWruRYTspyk3mFj6IDAALcGtVjZlDHP5qfmXRqyVabypuNzXDIC6CAb9DAqhIM
 UZWBvj5yIn05b1dEbJGNS1McsvMyAtC8op/3gVOsI8EdkBKB7f6MobM22G63f+bo5G1fMosS7hX
 5fHB2vqHhGrY761NKm0rpqDtOYRwEQLP7BvQoKhQzA+8ew3L8K1N/0x/7U85dV8ayVmX2UYUKkA
 7RjYqCuMDEir+5LVVzpzWaMBaZbQ98WWPn5YNOIzrIBxayV0WiNjxnB9LJYilGeKVA+n0ggcTEv
 iuKaFfY7MNU5auQnFbWbhjGCqX6kbp9VwnPcwcnABswA75jCBCBc6HolmGnq5UCJ6IvBaPOKGgQ
 w1IWP5PXG2HF+G2Ej8mAOHzL0Evim7NQ1Tm2G6oWmetFawffgT1K/4ckPei0HXOfr+qMlYxHIpX
 PzMAeLAStcH+cbgl3dzV16QWCup0akw1Cgg++DI/LAGtW6DTNLYyx6UmOBnVGDvjp6K68OCDOYe
 Zbyw1s09jB/EayJQPWLvGK3PoL9vt/97GjfcAo1X6vbZ3Ew31OHWXY5rcdYQ4X0476p+69G/TRz
 PvPoKjd+cBZoiLTmQwhgF15OXqXFtL3+ZJEOZjh1HXrqbD+kusqmoISd56VWwkOolZSWMFhB8cm gdj1F+FuHvD3pRw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA4MDAxNiBTYWx0ZWRfX89A5Je9nH5CF
 m+N+U2DpMQTaqrNgbssdtn7mk8w3P2cfWWMQ8nogn9pIvTps47CnW7+10oWmIWKD3pEwVoMDIPn
 PhSuOOKjkold34+bw4VMJW+UeJHutRFrYNDHlbetxTNVz6LwHJeAAke8jCQuN68YBE9+aC0X8ka
 KxxMNTzQljgkPTLN2QDNaijq9HA/AoYSn1sebUlgS9VB5C/bNvAphaDqvEAyaStIoc27N5BxEyC
 yiNX4K0Tw7Jym6yOHUBFf+1YwlXZglk1SPxsD07IED2Fsl57AOIsF+IWKkhN2pGE4uHeEexDlK0
 DfjF4BAn0BZdGZGvZC7HD5vmzLmo+eSqBAKv1OcSbIoW26Jb2Rx+Lv1AzHYqB3H6yxZ7DyMR3Sm
 RFJZ+7huwmROftPlel9YFCdBe+CHoA==
X-Authority-Analysis: v=2.4 cv=BqaQAIX5 c=1 sm=1 tr=0 ts=69363337 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=vTE1kzb4AqIx7XBf0Bkr0A==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=NV4WgquvA0qvyq2tMeMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 3kLX0gbb-ydPZB1r7Qo-fBEGKQ5B-O0-
X-Proofpoint-ORIG-GUID: 3kLX0gbb-ydPZB1r7Qo-fBEGKQ5B-O0-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512080016
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A00E445451
X-Spamd-Result: default: False [-4.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[209.85.216.69:received,205.220.168.131:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: 4I52CXZT6XTPA36YO5HZHKYXB5TXYASD
X-Message-ID-Hash: 4I52CXZT6XTPA36YO5HZHKYXB5TXYASD
X-MailFrom: krzysztof.kozlowski@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4I52CXZT6XTPA36YO5HZHKYXB5TXYASD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Initializing automatic __free variables to NULL without need (e.g.
branches with different allocations), followed by actual allocation is
in contrary to explicit coding rules guiding cleanup.h:

"Given that the "__free(...) = NULL" pattern for variables defined at
the top of the function poses this potential interdependency problem the
recommendation is to always define and assign variables in one statement
and not group variable definitions at the top of the function when
__free() is used."

Code does not have a bug, but is less readable and uses discouraged
coding practice, so fix that by moving declaration to the place of
assignment.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/tee/qcomtee/mem_obj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/qcomtee/mem_obj.c b/drivers/tee/qcomtee/mem_obj.c
index 228a3e30a31b..a16f8fc39b8d 100644
--- a/drivers/tee/qcomtee/mem_obj.c
+++ b/drivers/tee/qcomtee/mem_obj.c
@@ -88,11 +88,11 @@ int qcomtee_memobj_param_to_object(struct qcomtee_object **object,
 				   struct tee_param *param,
 				   struct tee_context *ctx)
 {
-	struct qcomtee_mem_object *mem_object __free(kfree) = NULL;
 	struct tee_shm *shm;
 	int err;
 
-	mem_object = kzalloc(sizeof(*mem_object), GFP_KERNEL);
+	struct qcomtee_mem_object *mem_object __free(kfree) = kzalloc(sizeof(*mem_object),
+								      GFP_KERNEL);
 	if (!mem_object)
 		return -ENOMEM;
 
-- 
2.51.0

