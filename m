Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815E4C43458
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:13:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D1E0A44E34
	for <op-tee@archiver.kernel.org>; Tue,  7 Jul 2026 06:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783404835;
	bh=EfGautIJzT+FUsw/yhzLv9bbZyARVX6CtMelQUoL2G4=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=uEYPXckvAhPQrq4ztZFTp4EZGQRWiZcvDTdhbeY/yS4iZ6c1sdyZI0lJFSg4f9mXd
	 YgFIjYOrbYmTQEw5NVMfnc3SD3Jkr483bMpq1gEIZkbCwjfrzkDGKWcebPry2+uFu/
	 0xBamnx+x/hzxzdkK6tXvnL48seEEBong2ZPAjMwbdjvEq3fQ/Rvubc3tKGWIqnSWc
	 gjATsu1cPc7k6o26MdgLtb1pywkcYoNuhND9CIg0deFprhT4MhAUF1UrrUsPJtvkWb
	 1vKD2E4YhZeioHCJs3DCabL6oL5xq9VQah8bqjWaKoC7eV41O63Re9JzTmHr2d6sYs
	 qd9ST5RRBN1zw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 50717450C3
	for <op-tee@lists.trustedfirmware.org>; Tue,  7 Jul 2026 06:12:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cpp+n5WE;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DUmaCEBX;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66749R0I2631828
	for <op-tee@lists.trustedfirmware.org>; Tue, 7 Jul 2026 06:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FfnuyctgLY2Nqkn5CYZ26xnKmCeJR/ZgpKG/zqeI4AU=; b=Cpp+n5WEE7q7AijQ
	lsDMIsc7oeanuwEl5zVxo4ACIzjfnpzccOFikix9tWTjct1KhrZZbI+ZUrSFen2c
	ddDLP9enMJjtd6GOT/vk8yB0ABxAa/kdPsAiVayedwApEkDuBmDBIV0H/HsUPm7U
	20N82tnQui+gjSdJzCY0P7NJ72/BtK5HbU++yzcmJ/q4v938Z+ow4Reg2+m+Ifwp
	aS/o8NfI+oHDnVb7yHX2vz3Y6jiIag87x0qH2HuZjkiEteaY5k+jc6cJqHhbddSk
	U7dW4m5Sl28xxQF2ctOEazSRYUKvU0ri+FDt9n+K/PL2Gtdh7MLlZ1ImQqfjVMG+
	Vd9bRw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h54tac-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 07 Jul 2026 06:12:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84240683a82so382147b3a.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 06 Jul 2026 23:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783404737; x=1784009537; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfnuyctgLY2Nqkn5CYZ26xnKmCeJR/ZgpKG/zqeI4AU=;
        b=DUmaCEBXgvkC1ZN6I+fHR3guKJrqv1Cy8N8hdrtv++FRZ1axrfuh6ycmiQZiSjES4q
         hzC88hxX8rrR9Dbcdp0e79PcrHJDeaFq0zH7yw/U5UyFiBsOYQpHOD2OjCd9UZ4WUxXI
         vfmSaIiB6j2cf7ud7vgIwUVdGLhRzIcQqKpPm6SXujVgsgZ0RQYrkotvhmxCq0MfQH7M
         SYgiqeHXA3MvscSpkqAgF4aSx+lG7l7nrxv1SP35oX6QlB2DP47lHbN31D+SWuBi9hXp
         x+nr6BaXTWN67VmhIK4s967Y1SgFs0hZmzLPRt7ut46tFDJ82u8IgUL46deEerGWhQi5
         md7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783404737; x=1784009537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FfnuyctgLY2Nqkn5CYZ26xnKmCeJR/ZgpKG/zqeI4AU=;
        b=egOpVIXiNAPt5Gpxi6syRxehY7gWv2esDrnG4pOdH022H4ukGCEkc235m9n3v+IqK3
         EHZAIpc6ILAjxTWhbk2t5knCgEUp9QLKES5r8RUz8WaNmk5jYWi/xnfUTbWnbb61iWOe
         4cwaFSiwhmcEd/DfKYLQePFekAMUiFWboBHXcUfHni67/jII09imtt+B6XN7MBYi0tow
         wQ8GBiNY00KAjpNrQw9szLwl7Mc0Z2xH0VsGMew0QJEF7LGPpkSgoeWJdVz6c/akYSKu
         BQymUw6gU+OKiGTUUepnTT4tIFS6WuYEgTFCMU0SzHe+UCG+sAsoaJs2iioTKQ0d4Q97
         9GNA==
X-Forwarded-Encrypted: i=1; AHgh+Rrhxe94oLLRC23fNZwFY+0H6z2Ap5hn2jG9HBOpfUxTOUcFuaXa1FLgCpssBm3CzkI9vYqlES8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwrCaL3yk59OvNgY7eQH2SA2uZarVEyEUkRB/Ze2gwTDFaU7lhd
	WErKlWWIfNcX2+KSAV0PnjaEWtk/pSvLzX7zl0LJ9Zmfd1118It6B72CL8E2HZEWEeCh3St/RsA
	gaUc5kvDguxsZmq4TO0JFJsnPdXQ8XqFRTw2n32uXdfy/3YHHSoZB7mUQ4SqBlVh3ENnlslTC
X-Gm-Gg: AfdE7cnjsrMfl5glXL0NYv0iJuVYqkc+oQmTyAw6gBMlzsFp5mTobHc4AZaSourcDzT
	mv6KUJ9Cxkf++yCPEM/iuyNfIuvtKkOMjqEpzPDJKEefpvHe9isYpzhGQ9Y2/27pd/1KvRN700W
	bqbHF/m9Y9WvnaobC6ShmfcE0r4JT2tOsFBE0lYHsRGvXjC12yjckOHsbzGP+zw8eBZGwrIPE5x
	MRYO3re6srHuZE7ngHoQMuHKEm60t2ToV1RZl9mcRdPXB1Xko0GyO68PyZyPBIl26PhZhgmYT+w
	zAkqjNt2wVUXQudm4uW3aDVfq2/PeD/ZZ09eMS0MDZuFmUbMFmLXorvtVzv6CBRDS8TPz10ZtGZ
	v/Bf8+Xq9ejKUZdNY7h0jLx8ItjvRmEC1+GTF
X-Received: by 2002:a05:6a00:aa82:b0:847:8791:f54f with SMTP id d2e1a72fcca58-8482f533703mr1165906b3a.29.1783404736700;
        Mon, 06 Jul 2026 23:12:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa82:b0:847:8791:f54f with SMTP id d2e1a72fcca58-8482f533703mr1165876b3a.29.1783404736151;
        Mon, 06 Jul 2026 23:12:16 -0700 (PDT)
Received: from hu-hdev-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8480da8bab0sm3299321b3a.8.2026.07.06.23.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 23:12:15 -0700 (PDT)
Date: Tue, 07 Jul 2026 11:41:30 +0530
Subject: [PATCH 4/6] tee: Export uuidv5 generation for TEE clients
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-4-f659cbd5d04c@oss.qualcomm.com>
References: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
In-Reply-To: <20260707-qcom_uefisecapp_migrate_qcomtee-v1-0-f659cbd5d04c@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783404715; l=2841;
 i=harshal.dev@oss.qualcomm.com; s=20251124; h=from:subject:message-id;
 bh=EfGautIJzT+FUsw/yhzLv9bbZyARVX6CtMelQUoL2G4=;
 b=PAw3EDVOOI2OCVEVYzRbl6L3ZuNWff3L3fJ0cAsU43Ep4i6n3ph0JorJ1G1zWS7Zf+gM/XdRH
 CyhtGsu/djEAA8S/ZMHG0VoY7eTivzh7mMXfGkw26iJBhhqsw4Haey2
X-Developer-Key: i=harshal.dev@oss.qualcomm.com; a=ed25519;
 pk=SHJ8K4SglF5t7KmfMKXl6Mby40WczSeLs4Qus7yFO7c=
X-Proofpoint-GUID: 7sE4YUbWmLF3vLI25YSxfZljkGwhVemC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX0z1t3/tdHrv6
 +BC6tMQmcMRkAyzRHTmr+dS3Po6L7j7WVZK2nLAvjvK0RpsVSPypvT2ZdvehDpnbyUZFxGEnHBG
 UFKi+bWngXTdurZH5t1n/DkuBMiTVL4=
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a4c98c1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_y_UpZ8dDEjReVSEE2UA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX0M86KOV030tl
 LUPEjRdIKO4EvVSVj7Pq6z3+bZmCuStb6foOXML130Pta3WfbfEPaHZBGe3GP/fxmi2SGfUQe2/
 J2UK6wHrOzhGzSgALUsUXoZyQUkB1eNYxgBrZdU9EtRlr7WnX4IANOzjeHzHbunst0xq4EvXbxT
 HLf8wjL7Gbm2JUXPwa8fhbej7sSWN/jCjso8Zw5//imvS00GTRtFrX9BBHTx6N4J5oY5ramgK9o
 m55YXljeAgkyCtXs8wLqWPrEdkYasSNM4IzUZaWZsskBSaJIVoOgufMuI9u7fmFgFVMjlrtb4dS
 VhS+bhS3b/I6Ukcyxeim/iw4eSfzP2WFBMnsubcjg0NDlzZRaHKyLu/aAHxnuln/2MzO0MWgB6k
 0jY/ktLSoWEd/qShNpQNtmxLfnRMPD2/QoAIZYbMi7Op1IXmoNuFDOcHf2+t+SrA4To/kdyarhi
 PxABXHKcA2Z4+LqTBVQ==
X-Proofpoint-ORIG-GUID: 7sE4YUbWmLF3vLI25YSxfZljkGwhVemC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.200:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 50717450C3
X-Spamd-Bar: ------
Message-ID-Hash: CB2E4W476GF7PMSNPWJOKXL5L2S45HPQ
X-Message-ID-Hash: CB2E4W476GF7PMSNPWJOKXL5L2S45HPQ
X-MailFrom: harshal.dev@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Basant Kumar <basantk@qti.qualcomm.com>, Apurupa Pattapu <apurupa@qti.qualcomm.com>, Arun Kumar Neelakantam <aneelaka@qti.qualcomm.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Harshal Dev <harshal.dev@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CB2E4W476GF7PMSNPWJOKXL5L2S45HPQ/>
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

Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
---
 drivers/tee/tee_core.c   |  9 +++++----
 include/linux/tee_core.h | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0783802fd010..61dd99bbf5f6 100644
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
index f993d5118edd..13807e795880 100644
--- a/include/linux/tee_core.h
+++ b/include/linux/tee_core.h
@@ -266,6 +266,21 @@ void tee_device_set_dev_groups(struct tee_device *teedev,
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

