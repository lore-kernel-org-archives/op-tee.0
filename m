Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E870C4450A
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 08:38:12 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 867354500E
	for <op-tee@archiver.kernel.org>; Thu, 16 Jul 2026 08:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1784191091;
	bh=YCH1yylulf8EbgQrB2WZCIRrwVIgjivx9cOy+yUc6pQ=;
	h=To:Subject:Date:In-Reply-To:References:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=iDpG66IuEE8RTmiqOU+M8Dn5xj1lowlv9yWG8XoqM+Y/bk2DRghr1/ExqQj8GKftb
	 L9V6lB18nF0b8Aa7dyp3IVa2VEgK9TWvg3YJl+dgXnKSsKNBWU5mxwfZt26eYZWEvu
	 qeXdxZ/pf1mYWwqHeS9JVQ/m9IdyWbDMOylIajvdPFZbWCE0rCGuBXqcADevv0iykI
	 4zqqqMbXlMyqebBUtKB5apLFVYYPxZ6mu008OzuUo72Yt2dhqVnISSWXqxbfJeujG7
	 NB8rflpCCxw0er82nkeUUakH4J1KKMohVkgGtLComxJlAmnkr3JvmRraYYQTILjcks
	 zod2+brmfsrLA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0257A44DA9
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mFs3axel;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a1Qf/xem;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7XO0T2175836
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=WqcCf+Dhdx6
	Y50GJtvfwTO5MqJahdd7ZlfJbqzun1ro=; b=mFs3axelzO9r0n365nnN37XvtQq
	N78hfiyC8tHfroaPs6sX9bJqLCJwPThrLHpLrKBKParEuiaFs/DS22cj9eF+WaQx
	xWxynwBdAkt5+Dv/Legd2vWpO1EcGYyGbmwIrmAMrAubpGqGvCtFmO1ESzpntW99
	BY6sKDiKlVLO6lD7XGZK+0RcAL2mpV+cBecAyLT7zgkt+909Kvk4l7b/bhuipKxF
	l/TGwlViEEZIbet7MSJr5JA3AfQHAt/fajqFb+dn+gNR/md2nO3gIcyznuhQjllS
	uldc9/6Yzp/6ZewQmP23MjqcEK3y+QTCzbqULjcRF1tUCnUTRkpR/oiazGA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu1087fq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 08:37:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c07f25de2so39399281cf.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 16 Jul 2026 01:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784191058; x=1784795858; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqcCf+Dhdx6Y50GJtvfwTO5MqJahdd7ZlfJbqzun1ro=;
        b=a1Qf/xem3h3Ptf+K3V6OtlC4YsHiRcjVvHlVkxK3hDKTbj1djpAZAWIA1/pmkksJQ3
         fyz3iGbaOVqjjTCAZ0anMvPRC3it03VZtAMABL20WMWcb+AUCjeObJcwF1bHFy2cqm1n
         88WxLc5EYDUWe6O4gxrstL7CYLVkDOzgUHKP87nUSfVQIbFf3aLOv7IpD8kgLVNeUwsU
         IjcQQVSlRnMaXuGUslhnTeNon0W7mi4GpLx+7eV+d1k2jmkaQz5ioDck+0oW7NJRyahr
         7TwsHnPTIT9Tt408tghqp8v64qZy0cVHJVTg8y+MCEeSHNVUzhYZECP4p33Urlh5GiLQ
         GZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784191058; x=1784795858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WqcCf+Dhdx6Y50GJtvfwTO5MqJahdd7ZlfJbqzun1ro=;
        b=YoOK14Ez1haf+vPO9k/7aTSnU7sq70yzFXjoMimkxEe34s7f9VWy3iBCv6VD28Bp+0
         hSEM6kjn3wNQf0yZeNO8LBKFuI7yP0Pk1vU0SkAb9IRe4odsJITDKzoFpoVTZLRNkG0A
         r3d8zpq6ZzR5v5anFkFyZ66uuESdXVcF3ToxaUtUZ3jBJWoS9okRd0nS49A0W5KGdx3G
         ch00dltNlFdlff1HpOB3cHfLlAAYLXnRj3Cqty+OwmcYECc2PEysN93Aruh9XG1oz3uF
         GYDmQpAEB24UaMToH+/MXaWLuSFkdqytCxplX21BEiqUaDIJPYEereAzfqHvpdEQ+3XJ
         p7iw==
X-Forwarded-Encrypted: i=1; AHgh+RrnOfF6aWv6Tp6qNsfP2IfYKywt8xq0PwmrumXWZgDId2wt3SvW16tblpY99gbWc7OysfLqME8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzrRcXfsUDdE49Od+9jyxiSYz6qlxqb9rkeqQOkW7icEswvIS1q
	6hA3z9C4Trbm6YoOrDHzVJWL7aW1UU1YVAG8WiIRdPyFKgHZ1p2VLTCajItSXtbWPQkbrIEJXP9
	8ZrgRT7jbHmPZ7OMzCKJq+RNTQOubb/FGzch54MYwVS/CFgw8wUq9ntB21d0sC0TJRyTrN9Fs
X-Gm-Gg: AfdE7cl1fFjCcWmN8qq6Ee7wmUJYmyAb6D3JlWdAfWvmvws+H+VzZgTmkacY/QW23xS
	Xqm58NvGzp4zK4qInlphukkGrIvKJVr6vRd9TxUsknw1ATm5wVVogDO9MJprzKaiTUlzqS0r81h
	To45hza33Ybny6Xon+5DvSqCqEWi85l5Vnj0/ms0CsNOB8j9GbYZjbyZ/j8mQETPbIJHhSlq+1/
	+TF8xT3cJagL3kTpGp56BmFoGDHdmeiregVp1g9xBirmhJZ2+6tsQV4CU972rzvLeuD8dWsuOCG
	LvWDlO0Pj3F2SWYkQ+/nRsUxk010hPL7vTLAi/XUvaj3PntADlWwFDF5wGpy9jEyB5MQYviSd4L
	dhFV5J0nxd13N0cFSAlZ9BA2lXFKg75R+eCCjHHDhz1N0xFgfASY=
X-Received: by 2002:a05:622a:994:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51cbf177b90mr203948541cf.6.1784191057892;
        Thu, 16 Jul 2026 01:37:37 -0700 (PDT)
X-Received: by 2002:a05:622a:994:b0:51a:89db:95a4 with SMTP id d75a77b69052e-51cbf177b90mr203948441cf.6.1784191057426;
        Thu, 16 Jul 2026 01:37:37 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net. [79.144.196.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e94e7asm43614295e9.12.2026.07.16.01.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:37:36 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
        beanhuo@micron.com, can.guo@oss.qualcomm.com
Subject: [PATCH v1 1/2] ufs: rpmb: retry power-on UNIT ATTENTION on the RPMB WLUN
Date: Thu, 16 Jul 2026 10:37:19 +0200
Message-ID: <20260716083728.2226422-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com>
References: <20260716083728.2226422-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lKp7XPqTZbqSd1P59VWNl85Wz8l95uvb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4NyBTYWx0ZWRfX7sgw+F5jy/oW
 G/pOJYJAw7GdoY4sDDO0sO9akk2mea/+V27rq1cD3rNByrjt1QFwd2+f9nmOoLZb0qBq+WKnPsV
 kKgu0E0qHAUBTE/vlwKxMDiZ8+Tj2QUDTshPTyDw6KvTLZdxPw0jn0H+QUY/zy/3Ys45YaWEB1J
 YEL61quC6bjWvDUJhSSC3AR22iDi9OkDBpT0yJewl91ydIKVjXO3lJ9taSsTtpkfgLOYXXf1aMh
 Yz1gBm/or/b5Q36xPMUwaVnoVPzzWJqKwwmgSqMKPFrG6ukXKiN5LvSGmga5JJ0xwMj4x17ghCl
 epj7UDlcbRnHhlcTiPgpBF7jLP60Aicct0V8NweXSMKuZkPP1D/PCHmwAdSIZtKqQ1iUWjomL8J
 ioBLilnTcsiQ7Qs63i/wwfHMPpMWcYtu6mnszQ10UhijXo9scI+9E4F+vqokkqF2ZowbFFBpAe7
 AUR8TksLdp+AcfbbFfw==
X-Proofpoint-GUID: lKp7XPqTZbqSd1P59VWNl85Wz8l95uvb
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a589852 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=w0io_FmA1e-6CLxyNa8A:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4NyBTYWx0ZWRfX7i8w0PfnWFvx
 ShptTfWuIIIbTOOuQFxaQArxMIoZJmKAjC3/NZr07Vsi8396Rf1rIec+US3zjpzwxi0Z9ywHflb
 LmfCv5wnb0IazjkSlc+WZ6/FVqIi4Q4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	FROM_EQ_ENVFROM(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0257A44DA9
X-Spamd-Bar: -
Message-ID-Hash: MY3BWHFFVYUJXC3ATM5NZJTVHFOS3UO3
X-Message-ID-Hash: MY3BWHFFVYUJXC3ATM5NZJTVHFOS3UO3
X-MailFrom: jorge.ramirez@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, jenswi@kernel.org, sumit.garg@oss.qualcomm.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MY3BWHFFVYUJXC3ATM5NZJTVHFOS3UO3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jorge Ramirez-Ortiz via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

After a power cycle, the first command sent to a UFS logical unit
completes with CHECK CONDITION and a power-on UNIT ATTENTION (ASC
0x29). The SCSI core reports this to the caller instead of retrying
it. For the RPMB well-known LU, that first command is the first RPMB
frame sent after boot, so the frame fails. RPMB has no earlier,
guaranteed access that could clear the condition beforehand, so this
breaks RPMB on every cold boot.

Ask the SCSI core to retry the power-on UNIT ATTENTION on the RPMB WLUN
so that RPMB works from the very first access after a power cycle.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/core/ufs-rpmb.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-rpmb.c b/drivers/ufs/core/ufs-rpmb.c
index ffad049872b9..d0c7ea7a36f4 100644
--- a/drivers/ufs/core/ufs-rpmb.c
+++ b/drivers/ufs/core/ufs-rpmb.c
@@ -40,6 +40,23 @@ struct ufs_rpmb_dev {
 static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, void *buffer, size_t len, bool send)
 {
 	struct scsi_device *sdev = hba->ufs_rpmb_wlun;
+	/* Retry the power-on UNIT ATTENTION (ASC 0x29); the SCSI core does not. */
+	struct scsi_failure failure_defs[] = {
+		{
+			.sense = UNIT_ATTENTION,
+			.asc = 0x29,
+			.ascq = SCMD_FAILURE_ASCQ_ANY,
+			.allowed = 3,
+			.result = SAM_STAT_CHECK_CONDITION,
+		},
+		{}
+	};
+	struct scsi_failures failures = {
+		.failure_definitions = failure_defs,
+	};
+	const struct scsi_exec_args exec_args = {
+		.failures = &failures,
+	};
 	u8 cdb[12] = { };
 
 	cdb[0] = send ? SECURITY_PROTOCOL_OUT : SECURITY_PROTOCOL_IN;
@@ -48,7 +65,8 @@ static int ufs_sec_submit(struct ufs_hba *hba, u16 spsp, void *buffer, size_t le
 	put_unaligned_be32(len, &cdb[6]);
 
 	return scsi_execute_cmd(sdev, cdb, send ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN,
-				buffer, len, /*timeout=*/30 * HZ, 0, NULL);
+				buffer, len, /*timeout=*/30 * HZ, /*retries=*/0,
+				&exec_args);
 }
 
 /* UFS RPMB route frames implementation */
-- 
2.54.0

