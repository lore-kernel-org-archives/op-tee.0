Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED35ACC6B34
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:42:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 29251452FB
	for <op-tee@archiver.kernel.org>; Thu, 15 Oct 2026 11:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792064522;
	bh=0Kc794OPno2pW9+u85wr/YtBS+yp4Ljn3phxmGe7iJQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=GpML2fz/Hd4l+4XSjoUrpNWdwzisNmp828nPlKkLrCdf3sODCuxWJGhA4N/oSO7+e
	 aSn7YvDk63opcn17ugF1C9TyiXapYDGXVHM5mmNCEDEHpQvp0VL5aQPEiovmKX3a6y
	 KcU7PnWwkcebcyGfJtTruiJBfUSeQIq9iNAFZyh6VWmVLfo5m7nqJTIXdh/Ks0/G06
	 jXkO7uc03QdNYGfwOH3fNCr9lABA6Er+P4Kk0dZGDppemndym0K23qpKN2W3QM8A7B
	 4RthKj1QK/IOpo1LfB3h8LgFFThJFOkN6QSP/dfQyeSx082xts7lvhvHPLoiRBHt4b
	 IzTY0EPdhd0rA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 19DB74527E
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fg2eELCJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SJDAQu91;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jHjH4077452
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K3H9YKHNrLlGtzYAMdj326MBl/MGfz8aeOp/tdjelI0=; b=fg2eELCJIw4NVXvl
	kIkQc2x+GAOzfRjwzY/zAWWnXKVdcCiob1Wx8LQhJUx/DPDJALiBi4VOSAiDj3fS
	lXv19llaUGFdyELiDrubMQazALFAPR5sNJC/wILbB5gq0k5RJVt8ViDAi3Q+Qmw0
	jknIdjpHm81vpnfTP7ptaQzjyvSl/bWewOC67tRqivpkhocwBlByIvNgGOuWYXhI
	wYH2BBX16vRrS4vGAAkpZluNvSNsUwv6E9jt466Al9m55LLx6lWZ+c9Hdv+vkIJ+
	xsCyfuoFcSSd3kM8q2QxPvJZ8TqDlAKSBxqC/dUQHVocxnSF4uqugIqHgjeDg4kt
	a7gI4g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc0ggc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 11:40:07 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-35fb6be0f9fso765738eec.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 15 Oct 2026 04:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792064407; x=1792669207; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K3H9YKHNrLlGtzYAMdj326MBl/MGfz8aeOp/tdjelI0=;
        b=SJDAQu91Du50SiT/bD5BMaAm25OzlHjVnUXXzNmJgmNw52tRfUUpURyCiB3aDbm5yt
         BX0EEeRtG+R52lDpdZay2gF+VeV20rSgBdXdpDbkD9IKilywj1E28FtmCE+E/gaV8itS
         wzRbpAL7MYj6IPz7C96jtjxrIBiastUR9sfP8K/ijzotnwvRlFxRQSfGHg+/1iN6rExZ
         el3QRU/LXKQuc+pecua8Q9j4U7hXqsD2jcHWDKR95HHVIRR6kUbjX8cjcOCVwnB7gi2H
         3KodKTJY/HKlCMyVe8OIKplvKeDXNu7z7jexQiBSnzjqG4OosEIK2Iuy+JTzHE2OX570
         zNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792064407; x=1792669207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K3H9YKHNrLlGtzYAMdj326MBl/MGfz8aeOp/tdjelI0=;
        b=abFAKuWYt071on9OG57oKEtYeudOlcT9DUXcbvt5DEr3thFS9h++uV/soOxCx+iylJ
         RC0JsCk1exwrNEAKeY5af+mPy8G2y7mSornhpSysf3sp9VR5xarih0GKaW4TrCaXXTGa
         D0vU3xoDU9HXJ4Oq8IhjgR38V07UUMU/rki23D2C8eaXPBuydZlSUYOgujsN2NMIDWmx
         CRR3kST3/Hr2jVGx+WZ46EzZFV7isqeeEpPLBtDZzwCM9JKnIAvIxe3/0b0vY5cfh0SZ
         2xyCHjb5qquQgqLUGGbKtvoh362YFIjRd5bALn4P3zwQK29Qb9WnQVyk7MttJCBiZrTn
         ZYLg==
X-Forwarded-Encrypted: i=1; AKwUvBwyJi+Il4PLARoBze2ag1NELVm9TirGvHDqXy9Uvgfu+Y+Wyh2VpFckiQbJD4Wu/08O3jYbLzc=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYI+kAnR/tdS0g7aY4P1Lay8qyeLcYUQx3UFOZAUB4Kff7mVEgWs
	h//D/AO9P6KQjPxUVH27R6cHx7Hr7AJ1xcaiF2tpIhDwytTaNjstc6JzJEe1h9mkVzpDNsOpfV5
	p+wKjk080DHFUuCjd7vkEnN+6GH55+fWGLAB0SCyz+fSQSo+biZ/SsOKASuPQo0v9PxZK1Zwk
X-Gm-Gg: AYBFou0L8eLlD+yoT+wCDbLGirKx7sgultbwjC+ASKN/NYIg/c0w4LbBINoUugmHA67
	IQ3ooIk6+z4DdlN0voLjjMj3Ll0Ou/yyJJSjt7HfY75CZj+g70Un7qm7ABc35F85SHHC7EPfuMo
	DKUH9eiUlHIDCHRdqufB3V7CaQmO5WPg0uWRIb4Cjk0BFe7EdQkODkFMtNap+z+7jmr1VQX6hd1
	PmVOb3QYyogy44h8xWNjuynXbU57N5nsaa7+V5KX/wTq8sFy2n1A5X5+o9kAlqZV8/Hrk6Vu5kC
	/8D+vTF0yBcPilkoKOkMUw2tlw+C+If0VITHXQXgh5up714wSyVdvwstbHOrOBMCOtPiqzlBJ4t
	yWFmRlzj6SMnUqUB4LqwIiRlEtw==
X-Received: by 2002:a05:7300:ec8e:b0:351:1bdb:e3b7 with SMTP id 5a478bee46e88-3537e0792c4mr23860371eec.15.1792064406335;
        Thu, 15 Oct 2026 04:40:06 -0700 (PDT)
X-Received: by 2002:a05:7300:ec8e:b0:351:1bdb:e3b7 with SMTP id 5a478bee46e88-3537e0792c4mr23860337eec.15.1792064405790;
        Thu, 15 Oct 2026 04:40:05 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm48144891eec.11.2026.10.15.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 04:40:05 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:09:38 +0530
Subject: [PATCH v5 4/7] tee: Export uuidv5 generation for TEE backends
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-qcom_uefisecapp_migrate_qcomtee-v5-4-1460691b35d3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792064379; l=2929;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=0Kc794OPno2pW9+u85wr/YtBS+yp4Ljn3phxmGe7iJQ=;
 b=3Xsda148xCgAgWWIW/3X1xBDM3z+OpNOIoFgRq5osdaIUhrqScLhSvBdQJC++d5laCbZ0nkSe
 7qJqXqp9npCBbTo3odHlGA+lJHpDGnKqvo7y9QKWwx/zOrO9ZzM2z+S
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad0bb97 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pmd68VmXx7mOn8wi7GwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX2GwQHwMjGfrp
 CrC2S2M/69Nt50tpD3eEipf8/TodfomCNwMFepSK78dy1v4BWTDpG/CfAlhn3P6NK10s6Jh+Qw9
 FnvbtNkBk2utnIwGjeR88fywyjbv/t0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX7Ndg8R6b9oeN
 FDB9gv6VE0tLCNpZEtUq4N4Z2XnEYTtRvvwOS6kT871m/XHz9ij5rrySEYYrJfukw3YDQfyu92b
 UnOrwTjoZXVFS3KrwtkqE8IweOiG/rDTXrlh4ir2VNqZOYnVpmcK4dc+tkPsrHGUqEskG1o030d
 qpLDuQ8BtdMUP98R8jWEHmHXiAiaoUgueAJtFXC140oJUdTu6AaN029WQv8hUCOpS3HXGaBpTgI
 MQOJAtgEk/0LgmBsjFJ1criJw1qTBJaBQf9T0E0QDmxPkO9+gRylMuJfCXSc6A+T8A2FUOY1T4h
 J/9BwoxF5UwsLiCXBpbekR8C+VunAzyQIFluTLUQpCAnt3TzZjFx+nclYfcnly9vC+geQEswXj3
 65C484ET5cgXZkDh8XaVN//OF5rqm1jvGq0vwGt79ZL6OlA2ae5tCAk41AUHDEHSThVbqL4upyt
 bf5UTtPirKJcdUl+3rQ==
X-Proofpoint-ORIG-GUID: 4bJee5MQrqHH6QckTjNT1rvJFD9gA7aO
X-Proofpoint-GUID: 4bJee5MQrqHH6QckTjNT1rvJFD9gA7aO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[74.125.82.199:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 19DB74527E
X-Spamd-Bar: ------
Message-ID-Hash: BCWXH5DHWBKZMA4KWKG3LMGFLRDVBWVB
X-Message-ID-Hash: BCWXH5DHWBKZMA4KWKG3LMGFLRDVBWVB
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BCWXH5DHWBKZMA4KWKG3LMGFLRDVBWVB/>
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

