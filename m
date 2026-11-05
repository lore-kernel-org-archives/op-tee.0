Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FAC606A31B
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FnpEQ9Vv;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxN6rziV
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 0E81643A89
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 11:17:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FnpEQ9Vv;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bxN6rziV;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7779C454A4
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 11:15:52 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tcRf1028283
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 11:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OSyGglNviyFpT8Uu9xEAndODqt4knqWiiFpaao097o8=; b=FnpEQ9Vv5tE+BsDM
	PD+fLZrLVW6lU+6/bxawyMYuHXIrlSTNeGObYmYQbDYrSBIJjODovM1KnaV/97rj
	Se9ZDDNvvoOHyAmpq/YWT2zE0EezYfq8Wj6n+jFTUMXWInBFsK5yKgXfZzh88KgT
	kB4dd48oAFfQE/0zJCd3ttPbK4LXvIGySh7CiKzDHyHfPt1rqJ+h01Q5RlomVqNW
	6AJrfmwvoMxWyPYOqkxdYZA5K2RBA5UsfQ3V/7vDqvRLaxcXiQP7qUemEF7iu4GT
	nfYuApiVwJmeyXUJywY9GqafagoQC8sOLt+/DrTzPDd1YbLDaATP4LzI0aLHNkgO
	1YhNIA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaq9eq2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 11:15:51 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36d69ab3c2bso1770847eec.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 03:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793877351; x=1794482151; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OSyGglNviyFpT8Uu9xEAndODqt4knqWiiFpaao097o8=;
        b=bxN6rziVNWm1nRmClKGS4x6VHhsOHk2o+tAksjIJyq0jiTmvi7aCsBU34tE379DGTm
         00sv2AUzxsr1TfwbtMXmj0jJFdoseVbLbx177U2V4CYqqg0TjIwA/M46JzODlysj/76v
         tx2380XcTgaJTqyDjwZrgTbX0/TM+FWT+53ZNpB9HHOnXTgYgzSbnppTzTQutnY+XPFo
         CAwGRiHwYrEY1G2y/XPic8FT/O4Y8FnfAxKAyncAasPqPy+uxya8v6Z6QG0cKQsz9gFP
         hiZvj+7Gj+9S/9gjPzmRQlK1lmecv52NcpD5KCH4kPOjkvbiK1iCWB0HQFME+GqNsTQE
         JAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877351; x=1794482151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OSyGglNviyFpT8Uu9xEAndODqt4knqWiiFpaao097o8=;
        b=T7F+IaDRkQaXCSPNF0kYycdKmEfS5+mn9sCmO7YMqdhICdN5aJqVm1rPua6l6AToDu
         hELsU0p+P/NQsEr20XHVHSYlvkDgVmd9pTDcNzf65a+mVAIw/OJz58WD9y3zvWwqg3H5
         sh6aBtUuc8IVi4/zB+HA60F7V/KcHGinHprneg76vTHlcqjAoyjF/h+tlae5vFyhawpB
         th9mE78zH+wZK+SddM2ETGtFBLmF2hzsLSLRpn0RGtcvhy8k+E1y7dEi4NEU2lBN0odI
         QZz6KPIceH9PookzHIESVebrJoiYFUBLkCUZN1hjWYvNk4RjZZLnXUTzQ4JhcaQzuqLJ
         Sf9g==
X-Forwarded-Encrypted: i=1; AKwUvBwXrIUTJPli2fNoSvKjbGmSKZ8lgnpJS4LMm7x1xCW/RoMo/aiG3kM4etl1D3O8q22w/+mKIXs=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/0uHt9uezO/TyP/NRTTLomdtXZgYfpc1Fj4MVrwIRniBZE1iqe
	kJPDivhvWmiw0bLkcmheefUMWP8mYRAF0qvfJxFn0BVfSYbHZV3W+zaOrRAHnJ7bHzLYDY58CLZ
	11Dim2Q1g4Vm41vXQ6nw1Up00bP+KT1qMg0fZtgVXOMQq2TR+lhhVyUTiEA8EH6gHzyj9AHXd
X-Gm-Gg: AYBFou1iq2nDHzUZXjvxUgrHeX0AMU5bWpcEt6SIWgb9a0wYzYLklzP7PRnqyqNyZKp
	Cu7K34gnqE1FO5kSQ1bL6peMrll2ZxH5MufZd9RniJTElOQx+VFg/I0oM8+2KV2w06m1Uqft9bJ
	64inULjEFRnAv3W3RwvDSBYY2mnS+BEY+8b+Iq6e0/BfpZWinGRN7LcrN04uvA2hFSTIRfK+pwi
	yC9YhaW8ChIDcxhIQQTdmN2fYdKLRA1lal44MsHXXuK1nhm+62WRXlprLFyx1AyLKUKjVTABhjH
	LDy09A8sgsMiue9gFQyPrdkhBagc5Gpt79V4nBqoydGuPWf4u5eaZvCUFw9q5yLwZAsbzhsxCFm
	P2nbmtU0unbcrfoDm4oqs7xvP+bUa9kREt6dObsH/ZDgoW/VNFjasIyX79jRmARS3Kg5chzxNbA
	==
X-Received: by 2002:a05:7301:fc86:b0:36e:c07a:426f with SMTP id 5a478bee46e88-36ec07a4913mr702724eec.39.1793877350489;
        Thu, 05 Nov 2026 03:15:50 -0800 (PST)
X-Received: by 2002:a05:7301:fc86:b0:36e:c07a:426f with SMTP id 5a478bee46e88-36ec07a4913mr702685eec.39.1793877349891;
        Thu, 05 Nov 2026 03:15:49 -0800 (PST)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36dd7ec8881sm14002125eec.18.2026.11.05.03.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:15:49 -0800 (PST)
From: Harshal Dev <harshal.dev@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 16:44:52 +0530
Subject: [PATCH v6 4/7] tee: Export uuidv5 generation for TEE backends
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-4-c7d68ce05c51@oss.qualcomm.com>
References: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
In-Reply-To: <20261105-qcom_uefisecapp_migrate_qcomtee-v6-0-c7d68ce05c51@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793877323; l=3003;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=Twey1zuZcAHPNfsDJ1UYaEgRECNx0M9KEAwGTgro9JY=;
 b=db++sqPUH/XyyGS7Ka53YiKQJPHZdjl8bosVBr48pSSEJgP7GfLEvetShpJRqRDT2g7wcFNqx
 /XdkqSkPuO2DvN3kMs4uHNGZ+n3fjQcQ208zNAV7WA6wJkuKtqsAyKV
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: aZqd8aSvJRuzCxNjjB9Z08aiJYku6fs0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfX6I67Sl25NWU/
 m1I47zFArPM6TzWZqT/J9WJEs9YPKkDrwPA3swj77bdFJeObwBpTpBd5+/u6t3CxtDVi9OLLclm
 +BKpHA10gsIiVU1PPFAsB9qoHfQfZ7k=
X-Proofpoint-ORIG-GUID: aZqd8aSvJRuzCxNjjB9Z08aiJYku6fs0
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aec6567 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=pmd68VmXx7mOn8wi7GwA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NCBTYWx0ZWRfXxl66staVYz43
 TiY5WCmkPcbATvwNiJ56Z11AuTqQnZR2ZMytnHZl3VYq8r8GwYL47bJHIDG3ICDbZw7blZ+huYH
 vTBkibycCMHHReFJ9SI9P71aBn0KkQxBqF04EDW/kjCvJg9XcWfSU6ElKjvzGkuZgMfCn978qvD
 6rEeKuZZvQFwnARubkz8Jk837zK/T6gwUbNdFXFw3VHCcBOmFY5LMZJhSmlbAoaNS78rAXw9gC6
 cvSyby3rt3wudcLrXWYLpUeTE7PZisGibYmKJ7E35RnVBzCzfuc7PCQ2Iy9M02B45258okmogqN
 /7lssLgJwoP13CFwWyGqPZ6D7r9Zj3tBsV+BA27AXEKVKX8tkPYnsNuC1HD46SZmrbWy8zNesQt
 1qEHk8bxK02IRgIu96HI9+37q9SJk8nL3lNnCjzFtweuVXHMxJuJaH6cY9hy9JhfsMcWS/UQ74W
 aNydL/KGQrCk5O/e3Xg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.82.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7779C454A4
X-Spamd-Bar: ----
Message-ID-Hash: ZOTQ6UTZ4E45JMR7VOUTVCLD2RZJNE4E
X-Message-ID-Hash: ZOTQ6UTZ4E45JMR7VOUTVCLD2RZJNE4E
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/ZOTQ6UTZ4E45JMR7VOUTVCLD2RZJNE4E/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Export the uuidv5() function defined in the TEE core to all TEE backends.
This enables the TEE backend drivers to generate a UUID for identifying
and registering their secure services on the TEE bus.

Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com> #on Glymur-crd
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   | 19 ++++---------------
 include/linux/tee_core.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a03a3d645dd1..2d678d414edb 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -134,20 +134,8 @@ static int tee_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-/**
- * uuid_v5() - Calculate UUIDv5
- * @uuid: Resulting UUID
- * @ns: Name space ID for UUIDv5 function
- * @name: Name for UUIDv5 function
- * @size: Size of name
- *
- * UUIDv5 is specific in RFC 4122.
- *
- * This implements section (for SHA-1):
- * 4.3.  Algorithm for Creating a Name-Based UUID
- */
-static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
-		    size_t size)
+void tee_generate_uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
+			  size_t size)
 {
 	unsigned char hash[SHA1_DIGEST_SIZE];
 	struct sha1_ctx ctx;
@@ -163,6 +151,7 @@ static void uuid_v5(uuid_t *uuid, const uuid_t *ns, const void *name,
 	uuid->b[6] = (hash[6] & 0x0F) | 0x50;
 	uuid->b[8] = (hash[8] & 0x3F) | 0x80;
 }
+EXPORT_SYMBOL_GPL(tee_generate_uuid_v5);
 
 int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
 				 const u8 connection_data[TEE_IOCTL_UUID_LEN])
@@ -228,7 +217,7 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
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

