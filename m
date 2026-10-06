Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B2FCA5FED
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:36:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6D6694545C
	for <op-tee@archiver.kernel.org>; Tue,  6 Oct 2026 11:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791286574;
	bh=V6V67HDyVwvDLDt9fmB26sYcY1MHYbVDIRs6gvhxmoE=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=JhfV7hslElOtIrgs7cjVhHBtuMlJ1pj/IfmTaafxqJl/bMU/Kw5kHRFCLmAM89aTu
	 mccMKTkPDTvrdlsrBmdhN/9MDackHXF3N3fhG6FrQrJRLuY166cLB/RkJSevb2nQNk
	 Fb0sXW9o8Wbmbg0BeJcUFMGi11obbTx2P+T9cMtMK6RLsDhHanPh1C1YkG7CfgllFX
	 9rFHkDQRVHy+EgC80uVk7MaffEzX0YIWGFAdXfQnno0LKkLznDFA74jHsj6i/PEEdo
	 /wOr+kGYHTstyDSKC1DdhtwH4SGx+PIcaDgYE4cgm6e18ZqnDWqrcO1o3L7GwdRtUw
	 AarRg/KDArIYg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0643A45514
	for <op-tee@lists.trustedfirmware.org>; Tue,  6 Oct 2026 11:34:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YVt5RnDR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BkjMVAH3;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BPQbu718082
	for <op-tee@lists.trustedfirmware.org>; Tue, 6 Oct 2026 11:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M3m8lL1hF50/CqIcZMmwBNIsPVljpYvteygQ2Xz3F0M=; b=YVt5RnDRq2xGm1rD
	mbUHvUuqsFsBaI7j4nhg+FS8v7msootrv+mvIzhBylThHBgZ1+amTzLkyg66vOym
	U1C8aISc2FoB1MCT804QydLin4r8dNhkEF/XG5SipUpyvh66z2SreJnGCpZC9U2R
	w+ikdzhmStAnWESblGgv4ViuTdgYud7VfjglUNjYZdCQMRvLqyaxS10XlnFjH0bk
	wr8CMucQkjuftRLxWk4FHzbqAHKtRnR+NF7lCS2QoK4oz+hLA4uQVlgaM+lDtHG/
	oniFfwcJL2cZKvMDPbuUGHltZLHt3Qsd58HejzMpnOq5dhnVEDDgrIhZgnOR4Ly5
	+vmOIA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr3kbtr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 11:34:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-395543dc382so2800461a91.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 06 Oct 2026 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791286461; x=1791891261; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3m8lL1hF50/CqIcZMmwBNIsPVljpYvteygQ2Xz3F0M=;
        b=BkjMVAH33+LHI6xvTgWLjayN6f6aAfeLLXIqn9qIsyUwsVQtyb1M4iCuvArJ+dye0U
         b+dDlb59XFd4Qd/ZOKgtaGhiyeo3vvsDZD/Z5ho97TCbOX4QZ1Oyp/sivMZD4rcGA3j6
         aS2mmv3EKGCr5A60rwqw7vvI/qrwWml/6rumwpS0t0C2x3ZdxjasxRbqqVNSg5BwBkPK
         /xl2VTtEaW3HXOJ6oeqUS1RkfzXTt7lRrS1u8CTmO0udsfjt7hFJv3q8uJY13SQ62hcY
         pSWZSCey9aSsknawzBMARKoxZ+WnQmMQRXvA9flIiB604AcWks0LWR+fTpboMZKFFSyo
         2MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791286461; x=1791891261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M3m8lL1hF50/CqIcZMmwBNIsPVljpYvteygQ2Xz3F0M=;
        b=tLyH4zOhTcEr9BU3p1bYdlQ+jnXMy2fWA9PiST9F/Uqbn9JONJ0EqItMaS7zImErZo
         QlnfemCVqt4UE9OxLnpLO+6+vDiMxuyiP37kjfaZIlvSeWH0sLWUR6m2y+c8M7jT2lJ6
         su1EaECohAYHP27/vwx/AHzpaQJ41caUcRr8ZlB7Qg5F73qTInT16w0tslX7eirL5p9L
         E6aMCCltE392C61TWnY3k9fmn20cnvNN9sRHSKbBWFWL/0N1iEqCP4D7bour8v+kfXoI
         2WKrSN1jq0upK351rPkHXmzMaqMhuiadyMSbX3FwCKwu1Iuy5vn65iIJmbe0SeoESbM4
         wpMA==
X-Forwarded-Encrypted: i=1; AKwUvByN+bWQo8UpqFuHYnzp1pSZFA9b01pMoJqxWG/VIYbL+HP0YuJ3UD2GFskGxlSmxTRgNTiwDws=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYL5IL/EPq+tagNVM6iWvLwKk2g3a8p9GCJmigf3S/Cn9XUJ3IZW
	HFoTi6JRO4QMUBy8NtXwdiC/h8ZdLnevAC8M8XB87YovfJFhIG4d4twx7pgNKrZGBBgJ3gtXwxW
	4piq1fRwBukG+Zf8HnIOOKyVFPICVVbaNukvDE9hpmMRfTYLKOPbJm5km/xlVahF5TH226I7h
X-Gm-Gg: AYBFou2p88lARperGqMt7hAhzLW1hROKY+jo/drpQrTD2YlZ9YeTSsRzTy+3GH/4Mw6
	OLOFOaTm+OgfzbeaWCa3V2jh/2e81m/i32M3ZWzrazp27QeRrHk59K3nH8CWiaxDeoxy+1ilz63
	U1eIOCMO8Rsyhwv112ERwJ19iWvDG6Ub+346ljGeXtSuGst1bK0wqDNodAxeF7DHli+op7fWvyq
	JwnthwSH8DorRu99wYrZ4oHS1mo3OY/LslEmBrkc9uoRWTnwSnt4SQ+ctJMWIL9rSExe72pnaaY
	dzfbSSXBZK+AwasMKE+0VCORCropiNmtgNAxIJqDwywUfebZZK06lkk5tRt/SIX5hB8JGk7ULqT
	I3xMsrBSoUymyHQCyUMiatty6
X-Received: by 2002:a17:90b:3b50:b0:3a1:6719:6892 with SMTP id 98e67ed59e1d1-3a87350ab25mr496944a91.11.1791286461226;
        Tue, 06 Oct 2026 04:34:21 -0700 (PDT)
X-Received: by 2002:a17:90b:3b50:b0:3a1:6719:6892 with SMTP id 98e67ed59e1d1-3a87350ab25mr496932a91.11.1791286460766;
        Tue, 06 Oct 2026 04:34:20 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a709a4e80bsm9330092a91.4.2026.10.06.04.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 04:34:20 -0700 (PDT)
Date: Tue, 06 Oct 2026 17:03:25 +0530
Subject: [PATCH v4 4/7] tee: Export uuidv5 generation for TEE backends
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-4-bf1c8e2a64ab@oss.qualcomm.com>
References: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
In-Reply-To: <20261006-qcom_uefisecapp_migrate_qcomtee-v4-0-bf1c8e2a64ab@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791286430; l=2896;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=V6V67HDyVwvDLDt9fmB26sYcY1MHYbVDIRs6gvhxmoE=;
 b=H+AL9sPBWZtubzOPpqMMxaz0a8SEPvsgTWpF9sb2XyuXMZ4q8jYMSuyYS08eK0e6/yne6nJnR
 Z+ljMz64mfRAA3RJrzkO8xT+ddXNZvjgF2NtEhj1lFKbvx7AoYmeXJn
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-ORIG-GUID: 0Uee10G3ZGfSxXZ_3gPN1uMN1In_baxt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX031R6UOmP4kp
 60Mczc/ej0KKpMM1Y05fIGvuf5edEdbfoKS04wc6TYgqe8Ompd1HHpnAcHKQ3l2qR8ojory8woI
 LoCsFboB89H0Qh57n7ekpgShpX+nj40=
X-Authority-Analysis: v=2.4 cv=PNWaavqC c=1 sm=1 tr=0 ts=6ac4dcbd cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=_y_UpZ8dDEjReVSEE2UA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NSBTYWx0ZWRfX7kZYrk3mhYPA
 VDlCIxboJSocl+539nH18RYdmH+B9rrwimMd3mtKTpL/JxHKmSvmR6I+HomEX6d4OGaEomxdx21
 Q3cHUZ4RpbJpYV/D2DBo3iU396YAJM1S0ODb512dA1Pk9Vc+Gmgs3nTiIm4GDJJgt+Jc4449zLj
 +ER7RRgmSXTrAryzPgd++NiG0zGqL7fK5HLg9JW7nZK72JdwadfuzJx1EOjMse+2EC+NZCE3fNB
 SjYrO6YiFQLtgJ9NI9o293t3PnrOQrY00w+hog2mFiIyG3oddDpFg/dDe4UPN6+yJzX3u1vKjqg
 IXce7Fjm/2jclXz6znMFxBv+o9qbxWVtKA9yv1sPBfAILlM2TtZU9ZNODP2HSG8SC5H41pzaG5Z
 p9u0PPyEunNps2tTzxNu85C7bE4iOYJCS/vaza2DzNUpyaSEYUnx3Qa2eOVYv3uwj1k/l3Y5UUT
 wmDiu+5tTDieUCzsX0w==
X-Proofpoint-GUID: 0Uee10G3ZGfSxXZ_3gPN1uMN1In_baxt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060045
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.69:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0643A45514
X-Spamd-Bar: ------
Message-ID-Hash: MU7IAOHFR7JDMB6GS2RVI7F2GMU4VJEA
X-Message-ID-Hash: MU7IAOHFR7JDMB6GS2RVI7F2GMU4VJEA
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MU7IAOHFR7JDMB6GS2RVI7F2GMU4VJEA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Harshal Dev via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Harshal Dev <harshal.dev@oss.qualcomm.com>

Export the uuidv5() function defined in the TEE core to all TEE backends.
This enables the TEE backend drivers to generate a UUID for identifying
and registering their secure services on the TEE bus.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   |  9 +++++----
 include/linux/tee_core.h | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a03a3d645dd1..2cfd302d1393 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -135,7 +135,7 @@ static int tee_release(struct inode *inode, struct file *filp)
 }
 
 /**
- * uuid_v5() - Calculate UUIDv5
+ * tee_generate_uuid_v5() - Calculate UUIDv5
  * @uuid: Resulting UUID
  * @ns: Name space ID for UUIDv5 function
  * @name: Name for UUIDv5 function
@@ -146,8 +146,8 @@ static int tee_release(struct inode *inode, struct file *filp)
  * This implements section (for SHA-1):
  * 4.3.  Algorithm for Creating a Name-Based UUID
  */
-static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
-		    size_t size)
+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+			  size_t size)
 {
 	unsigned char hash[SHA1_DIGEST_SIZE];
 	struct sha1_ctx ctx;
@@ -163,6 +163,7 @@ static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
 	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
 	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
 }
+EXPORT_SYMBOL_GPL(tee_generate_uuid_v5);
 
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
@@ -228,7 +229,7 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 		goto out_free_name;
 	}
 
-	uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
+	tee_generate_uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
 out_free_name:
 	kfree(name);
 
diff --git a/include/linux/tee_core.h b/include/linux/tee_core.h
index bcb5418d6fdc..a3f4f88b8423 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -272,6 +272,21 @@ void tee_device_set_dev_groups(struct tee_device *teedev,
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN]);
 
+/**
+ * tee_generate_uuid_v5() - Calculate UUIDv5
+ * @uuid: Resulting UUID
+ * @ns: Name space ID for UUIDv5 function
+ * @name: Name for UUIDv5 function
+ * @size: Size of name
+ *
+ * UUIDv5 is specific in RFC 4122.
+ *
+ * This implements section (for SHA-1):
+ * 4.3.  Algorithm for Creating a Name-Based UUID
+ */
+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+			  size_t size);
+
 /**
  * struct tee_shm_pool - shared memory pool
  * @ops:		operations

-- 
2.34.1

