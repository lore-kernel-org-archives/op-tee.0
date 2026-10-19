Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D012CCF2D6
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:04 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 26A4345058
	for <op-tee@archiver.kernel.org>; Mon, 19 Oct 2026 09:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1792401784;
	bh=vYqwUH50+liD1PmBF9/X9YCEu7jl4gq4F7J7KhijndQ=;
	h=Date:Subject:References:In-Reply-To:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=12f8x4bV5NITsn+Pbt3KFqQkErHmfdQFCPALxET6iiaSy+sm4kGSvEq3eBbascr60
	 HyZUhdEVvF74nzX9+xwXevMcb0g/DLk3a65q10l3BKygvPGEP9BdSSixBUvc6aakoA
	 FBnfFWtwQc8F7+fRbovzsxQhD0g5NXzEZNtuY+78siiMhrcXddNQWHhg/spL8Bo5vf
	 Sr/1B2BzRZBma8dIwB0OyRrZeLVUeO+Xm1PGVant99OFG2boyjM84SuCl3Ts3bjUEN
	 vFI9GlarWxzGMn5c5NEbl+v7LATNY+lrlLTJ8iSkzhG2QwEJ3pquQ4XvEqb1kbEbiq
	 xwDWSGK53hitw==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3CDA44528B
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:21 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kipViJoV;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aCTqkXoZ;
	dkim-atps=neutral
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8PAme1896752
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DA8hRxQNCcV+MK/4Ku6+FpMKSJpiHNgidK9cjVvcI9g=; b=kipViJoVFRHbN7mn
	fpPvCb/q4MdK2JDt1cKrrfh0N4wSagRlRr4E6ZdEqgO6MdKI5Gp7lYtBnC4W2zMc
	axi+k3OOFqvlPg3M27XuBbb3rAkEZpcScxu6FijrQOeQaNOdguYbDDPbnlXDsUMI
	TEiBFOgBNu11/FQSJKRsaZqe1WyQ25jBDtv6fHto85tEom1ZOarSjOqf9DuD6NWy
	c/0V37S20ctBVRjcLDlxddQ2THFxjPp0yvOVbKbfQe69oYZ4INy7yprbrpdo0wy7
	/c8Wa5NG8VceVvSYhJeOObCC1YmL8QL0zaPMcrz1ahpTiu/hmKwnCzhdzAbfLoX8
	8psR1w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr95nx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 09:22:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso3844592eec.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 19 Oct 2026 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792401740; x=1793006540; darn=lists.trustedfirmware.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DA8hRxQNCcV+MK/4Ku6+FpMKSJpiHNgidK9cjVvcI9g=;
        b=aCTqkXoZuHVrRg2TblzTImrKu3Og/Ou25Srwq9+CmDihvVoNME9PLa7cjj0/QUFZHG
         DaxEkpE30AvG6qp1v7YHeOMR5ZGiXX24Nw7+jtCYWiQWKdFDR+gCAYpgFyW9QDLoSCls
         ACwN8kT44uHPt9Z1elO7qIs+exUTMjBDMTwi6+zdnW/g2aSIS6mr9BgfguYZm1FXXVBv
         8O13a6dPYzuguE6of+4mVsP9XTDEthxiVKmWvNlljUA/CmJzCwi4Dr2vkN/7wNKVNq3r
         Lpd0gTSyiaqXEOorNdTKD93qzQUW0ZIiKViDlSNmhlv+qGhunmrHtEduZgpYBq3zqxAS
         r6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792401740; x=1793006540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DA8hRxQNCcV+MK/4Ku6+FpMKSJpiHNgidK9cjVvcI9g=;
        b=aqnzz8q+Pwx/mTIPqTgUouEj8sqR5WiFW2yiJNIpBdJuX5tpstB2kL1Ns6aYt/+tO6
         4dnyVL0wLqEJ6EuGTlEGiJ8SucS9r6TaIS8Lj4MDInCQMuhs/WEByBpbJ7J4LJInIWSm
         utVDs5VpSIn0A0AjU0GIDU4N7F3LyxviR3pwj2+3+ASz2092ND6xuBdgcLubsQGKfj6X
         pG7/qnD6yRzkwDUs6zQ9ku+VxQL7Xc1D9FngMycBxJreKEhaaxTMo7Db0axhqf08cewd
         iLvnjlJ3uwDXG33uxEEpHZiyzDhz90jlzD5jAmc4r8mHGyqw/Xwhfj/VXiBy0oi1HWV5
         qLIA==
X-Forwarded-Encrypted: i=1; AKwUvBwcPoPphUEEI0o0H4H7f4M1bqWh7UFZOvoptmfK6EfxPdtKjxEpvb8P3YkSO0ytVcO3us4js0I=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYLAFEApsoPMF4yZ5z1GfOmDUdMyigJgdbFNFY4DBXHVlNTVlxZi
	J2BM9DWAGbM1JtHriq0JjCKXuei4F+ytkTRJeqy8qcoB7brjNFe6cA4I6PWjui4luNGKM6/9yLN
	ruEPJUef1px/p2wgXD70p1M/ZQo/GFIJadyxb87s5eTiUZZJZypLYip/SgwQTOJnZWFlOcXlJ
X-Gm-Gg: AYBFou1mbsAUTpBScTyfY2hBjdnGnCdev6w0dGYs1VG7+LKBqnAizb+tAXFm5jD1rl4
	y/Cdfsf5IMoSo7tmoiztN937uEY1TvyaS/leCRcyHAqZIOeYtc6725VVmh4BfU6Ksi2q00f9XEN
	1wuSu+zCzSDEZx+lQtFdJtr6pnmqpgT8z39DtmzQZWYkjIr51bEk+O/Jrb5bjo5DHEu15gHsco0
	isMfVnjh382YDmUrgqgOP9a6iLbQ8N5YSmAwsq0tevZyCzn4Wn8xH8F/v56qojFBaI2qSTcxqQY
	KhyiaauUYlc3uWsCjVk2CAKYSZ2RaTq5PzWUc+B8UjlqkMu8mcRZqthLhbuSe9Z2gCXehPeQnIN
	62lqmXqvIferEPu/2YHLfy1C+b+81bAgA
X-Received: by 2002:a05:7301:430b:b0:359:2433:2717 with SMTP id 5a478bee46e88-361a136ac68mr10441998eec.20.1792401739732;
        Mon, 19 Oct 2026 02:22:19 -0700 (PDT)
X-Received: by 2002:a05:7301:430b:b0:359:2433:2717 with SMTP id 5a478bee46e88-361a136ac68mr10441965eec.20.1792401739127;
        Mon, 19 Oct 2026 02:22:19 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm56225094eec.24.2026.10.19.02.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:22:18 -0700 (PDT)
Date: Mon, 19 Oct 2026 14:51:46 +0530
Subject: [PATCH v4 1/3] tee: qcomtee: Register qcom.tz.tpm service for
 discovery
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-tpm_qcom_driver-v4-1-6889b9804ba7@oss.qualcomm.com>
References: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
In-Reply-To: <20261019-tpm_qcom_driver-v4-0-6889b9804ba7@oss.qualcomm.com>
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX1+NMSGyV6duQ
 wJH6zU0eAAmlA0BqiOWW/2+zbxomWDdQtRHwMnPviJehD6UPFoFQfDY2ir/fxw3/F1BvtJZrfnr
 Zn7yC03FWpukCJQba0NBVuzKZXdIzg1cI9FThxsNYB/oEuK/AMXmhoWSmzavYmcIXwgSbuzTzVa
 vGHV6+SfpAr91zrVKTxknXevKOK/IsAfLyOPut+rWt8nVFccMjjo9g/Uiu2Vix7sgaHUo+EDc/p
 kgYaF/bWw6BaCUs2cRliPvxBQsgTUZKi6C6EY5ue33kVsFVKE1L3UeH6fwIf2qwiXtlqVtqNWJZ
 eJjw6OihMAggMvp0+eK/GhGvbJdRuw8V1CQwfStDyuXRbdNBEvMU9GHGtq4/ZHBEOwul0Q1OYE6
 Fw2rCeT0CcSkT34kAJMGh0AkjOU8IuW82pcI4xZskYpe3GjBFzK7+OC2Rt5tIV7xb2Vvxxrgf3F
 o/UAzdcWcDQxLSgPE2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNyBTYWx0ZWRfX/f3f/GTTkkIl
 79DAnjyak2RCHvXtjolikD1gfSjOZ5xU4eabYbEcLedmzUAK+BLFcNFLOzd53CDogoKBehJH4Hx
 qj80PTii6i90QgrGWv1aj65YLnXN5vo=
X-Proofpoint-GUID: ShnSW5xsxUYJF9yZ8tTpkHzm__PapbLA
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad5e14c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cMdrFq0U01fV1n6vpx4A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: ShnSW5xsxUYJF9yZ8tTpkHzm__PapbLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.00 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmx.de,ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3CDA44528B
X-Spamd-Bar: ------
Message-ID-Hash: 36FEAZM7IEZWVYDU2MPCT4TF2NHQNB7U
X-Message-ID-Hash: 36FEAZM7IEZWVYDU2MPCT4TF2NHQNB7U
X-MailFrom: kuldeep.singh@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/36FEAZM7IEZWVYDU2MPCT4TF2NHQNB7U/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Kuldeep Singh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Add "qcom.tz.tpm" (QCOMTEE_TPM_UID) to qtee_services[] so the TPM TA
is enumerated as a TEE-bus device, allowing a client driver to bind to
it via its generated UUID.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/tee/qcomtee/call.c        | 4 +++-
 drivers/tee/qcomtee/qcomtee_msg.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
index 47d8a4f9a159..1b887da83341 100644
--- a/drivers/tee/qcomtee/call.c
+++ b/drivers/tee/qcomtee/call.c
@@ -747,7 +747,9 @@ static const uuid_t qtee_service_uuid_ns = UUID_INIT(0xe1b48857, 0x6154, 0x49f9,
 
 static const struct qtee_service qtee_services[] = {
 	{ "qcom.tz.uefisecapp",
-	   QCOMTEE_UEFI_SEC_UID }
+	   QCOMTEE_UEFI_SEC_UID },
+	{ "qcom.tz.tpm",
+	   QCOMTEE_TPM_UID }
 };
 
 static void qtee_release_service(struct device *dev)
diff --git a/drivers/tee/qcomtee/qcomtee_msg.h b/drivers/tee/qcomtee/qcomtee_msg.h
index 9278a361dc70..9fff9dc5fffb 100644
--- a/drivers/tee/qcomtee/qcomtee_msg.h
+++ b/drivers/tee/qcomtee/qcomtee_msg.h
@@ -106,6 +106,8 @@ union qcomtee_msg_arg {
 #define QTEE_VERSION_GET_PATCH(x) ((x) >> 0 & 0xfffU)
 
 #define QCOMTEE_UEFI_SEC_UID            413
+#define QCOMTEE_TPM_UID			81
+
 /* Response types as returned from qcomtee_object_invoke_ctx_invoke(). */
 
 /* The message contains a callback request. */

-- 
2.34.1

