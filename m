Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8BFCA6017
	for <op-tee@archiver.kernel.org>; Sat, 10 Oct 2026 03:20:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3C8DF41BD5
	for <op-tee@archiver.kernel.org>; Sat, 10 Oct 2026 03:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791602417;
	bh=m+S2Wb/GQM3li+G+nRy2TZL7nsUJI1fXaS5AK1540i4=;
	h=Date:Subject:To:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=jHhs3A4BCxORC9Tf0mu1qClq0MekQ+OhzbFNLZD1VXK481gzZ6s9q6dkWEQ/I8z1E
	 9t2pNhADhV/hTMIDZNrWh76BnxbBSKU/wm5sjUoII+VCmxZm24hky3CL0sPLz1Txs3
	 Re8ZRBzu1g455wzqtNuoa8Kx4NOIQgCcWl1YrzLMSJ30T9UaQACUpaDmy0HnyOh5+1
	 ONhY6kz0uh571pltxoYjflP3d04jbk2lRD8RsPkw7RvyG4dFhWfjFy949BN2hL1tVT
	 xDo5UTIGLDRcNnVFsKRtm0Wt4W3T4RA0QiP6z+yX3DzOFjiLWJgMshISstxDY72vbY
	 6zx8CAUWH8gZA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AFDF13F5DD
	for <op-tee@lists.trustedfirmware.org>; Sat, 10 Oct 2026 03:19:57 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h4R2ry/b;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iokYCyRQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69A2f7RV2587186
	for <op-tee@lists.trustedfirmware.org>; Sat, 10 Oct 2026 03:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=l2zlln3P8lcieIEn3wRf+R
	ryqjGxD9/bf43zUbyP1Zs=; b=h4R2ry/bLzd8jXCsFZ8KF0trrNuQjNvTJJrnGw
	Z0nw5LFGzOgTU/aB+5C10TnYXHR8ZiTkYaI5IkZI2A04pwTOZl6sns/xXI2NQW9r
	j/5bx27q0uJwLBKqTO7I6vsPXYUasaGzIRYYpaEOgY9Knm18bzuFd4Jxd7o6flAg
	/kbj7ynh7O5q2vMre3Ccu+RtoBk//eWwPxS6oo7uzx1jvMORq2lA0eAgi0W1LfeC
	rK1t1WNhzKQMvzsriOI9LNwdjjvQM9PwjRAoeZNN3adELMkQUhgBUd3hHGRVO8WT
	SH8/26+T2CMhbo48VdmTFqP95cgc1Zy5AVxORWKHXN/yBcjQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h74tbhm6b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 10 Oct 2026 03:19:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34ef0362d95so842974eec.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 20:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791602395; x=1792207195; darn=lists.trustedfirmware.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l2zlln3P8lcieIEn3wRf+RryqjGxD9/bf43zUbyP1Zs=;
        b=iokYCyRQW8BfbcuSFpMQAKFCZ9pkuVB5Wb26X3Vf1tTyXo18o2BBU3TQ7cOMwF2u51
         dM3EUBpkJ1AMoLXxyrfi44XePH9zRzBuFDmlHktrDJHqEUEhUQyBClNnL8YhQO1H6jaQ
         7mBwYFN1FF4gBQuSUS0Bzj3i0SRgReLxAaD8gNy4uFhgurVg0i+HNtgnxZBq0aR6TO/O
         1EGhn7iGVkFwI18N6k12YPbkvghfRkxc0BW88lt3ekFMAlGvr5HZY5vIX3gUE09YuZq1
         +Oo+6uQlqKAyGZV9qC9iiMclv6MiIR+TtdDEzeHjYkgvJei1CiwJnZVlNwyBNN7DCRCo
         lcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602395; x=1792207195;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=l2zlln3P8lcieIEn3wRf+RryqjGxD9/bf43zUbyP1Zs=;
        b=oM0WJwjIeVlc5hpT2as3DMvEo5+d0rV2xIaqlxrPa7/g3a5TN1rKrcrVqau+3ZP/LM
         SaM8kcQug7EyLwt+cJMx4ldBH+yOmy8MXNnvR5GLY6FzvnXmSCymg2t0vOw2sn/X2i6y
         l12Y75QPm0Vub/cNCT04Sqgo2n5Ih/SGT/5kEDgNHWJcfFGiC5ZrjewIXqiKYu0Z4jrC
         yoAiPcrrCADT5R1blwN1qJI/35FXvuqJKfK0Ee27fGGhI7Goz+cG1QyLuZAV+fuqoOpl
         3tA/Hgvu05A2V3JWL7xDw1SWi9hOADmja96IRH39jZbBUZozOlIecgQCktKWLiI0UjuI
         tlhw==
X-Forwarded-Encrypted: i=1; AKwUvBy8JjulvuiF1ldpBwUSVOc9g08cwlc317wMfqd/VskTH/nFVHrNRJKRl3F1ywlpm7FPCKM2QSk=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYID3KKn26qquT9cfPekOOM97OYDKbdS7B6tm3u57B5rXc0kNT1x
	oienhJnsY1j5YBFxyd2qKts5XqEHhbSvMIn3yYQP9OavdhiB38hLL9YV+Lw3yAexuTqnofHg3Ww
	ADYdpHG8I+78W9EtH54LFV0IOieDFlDuaQIcLCdqrUN8SV2XkIhkfelSJAOGDRpUfIbARNFE=
X-Gm-Gg: AYBFou1DdimW+7tgMuXfuW3ix+tsY5n76SidjnY2gtg3DYu1Qg1dMwjAw0EZHCakKE0
	x1nCOONQaxEge1jReOz8b195hNI6zjvH72XCJgjftQZYhDB+cQ9EzCGxzl5oyaxUXUFkZHMiqfD
	VKHXrZBhKl5aSjI2BuqehiE3gKBof/uE0aCqa1QQQOwGJS355jxfV4lRzvxxrdlh1I9xdlqwXM4
	CNj9LD3L7Fh3Wb3Elrxxxc6o/vjZMVi6WDYCMtqf2fzhwFMIPYAboeNsS+N2hBRLfT+zBGa+YP5
	XSzLbMqBEk5DaHN1kyW1YHYXWV5kfnpD4IYx09Gj7eH/Q6jzIMgMlepdghZu4V16W/BvZptQ668
	bv6hQvf4U9Xeuk/f45gtmpb8n+oCFWcj3JTDLqGKDaZkZ1JvFHs3GrKQB6Yk=
X-Received: by 2002:a05:693c:8110:b0:33c:16f1:2e11 with SMTP id 5a478bee46e88-3537df596f9mr5090023eec.7.1791602395415;
        Fri, 09 Oct 2026 20:19:55 -0700 (PDT)
X-Received: by 2002:a05:693c:8110:b0:33c:16f1:2e11 with SMTP id 5a478bee46e88-3537df596f9mr5090003eec.7.1791602394879;
        Fri, 09 Oct 2026 20:19:54 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353814b556esm10127579eec.18.2026.10.09.20.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 20:19:54 -0700 (PDT)
Date: Fri, 09 Oct 2026 20:19:48 -0700
Subject: [PATCH] tee: optee: allocate a bitmap for all valid notification
 keys
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-fix-tee-max-keys-v1-1-1462d96bf438@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANOuyWoC/x2MSwqAMBDFriKzdqAW6+8q4sLqUwfxQyuiiHe3u
 AwkecjDCTxV0UMOp3jZ1gBJHFE3tesIlj4waaWzRKmSB7n4AHhpL55xezZq0L0tcpvCUMh2h+D
 8y7p53w/LrAnQYgAAAA==
To: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=RcEFmFtv c=1 sm=1 tr=0 ts=6ac9aedc cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hYfsqUzT0y0sb8bvQO0A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDAxMiBTYWx0ZWRfXx0/R2gATUtuk
 4R7VmGZtkezxPpLRQ8lhyHFW+Lpi8oEEt2taVRfj/7vxllU5NHDAkTzcBCrK2MupTnxwXuys74W
 iCrLY0tKhxVBU3m3q4sKuMDRDfno+fa1kegOtXyID8KB+g7kr/wyWR2tYNUhdNVpsOx+DPT3XNZ
 aCGKaH1Woig82gYs4JaeaZSYV4xoXMhzbi+5RllJzQWB/lWDW4lf6fqwA0/smJMRqQqaOm6UzNv
 pJYKaVruSmSar6KdfFtUsBqw0kif8OnNLVaqgJGJg3xe6FpHOGMFvjg9wioGfzKtXZVXzxFEWln
 zWGKp45JYSQY5L569jhXfpR5/8UZONOUys7Z2ahxjyDaUQWYGx9FafDcF48vG4OBbGQRO0Klfe9
 hzOpT9kEBJjkJiFIVU53MzOXtpgjcjZW+dDmx/U3PG0VpzNRyp8GZD1RYvZpwrnCpnvpXqMD/Eo
 cJKRc2IiyBLj56hNpNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDAxMiBTYWx0ZWRfX+vNCYX8ooszL
 ZNV2ykIAldd0k637Px7H4TBkpa78SDIxkw9+12zy2Xu1VSOWOxfmBArkLvg5T4gpLj5q29X8P6R
 nLMcp+w4B/IPxsKSxM6NXOIPMNmGVCY=
X-Proofpoint-GUID: dKEzR3VpFJ-YuB6za0yoADtcanDjPPFv
X-Proofpoint-ORIG-GUID: dKEzR3VpFJ-YuB6za0yoADtcanDjPPFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100012
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	RCVD_DKIM_ARC_DNSWL_MED(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_MED(-0.20)[129.46.96.20:received];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_TLS_LAST(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.82.198:received];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AFDF13F5DD
X-Spamd-Bar: ------
Message-ID-Hash: 2WBZRTGYCHV5M77L4M2XENU34RSUBHUS
X-Message-ID-Hash: 2WBZRTGYCHV5M77L4M2XENU34RSUBHUS
X-MailFrom: amirreza.zarrabi@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2WBZRTGYCHV5M77L4M2XENU34RSUBHUS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Amirreza Zarrabi via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Notification keys are checked against an inclusive maximum, but
optee_notif_init() passes that maximum to bitmap_zalloc() as the number of
bits. The bitmap is therefore one bit short. When the maximum key is a
multiple of BITS_PER_LONG, accessing that key reads or writes beyond the
allocated bitmap. Word rounding masks the problem.

Allocate max_key + 1 bits so that the highest valid key has storage.

Fixes: 787c80cc7b22 ("optee: separate notification functions")
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/optee/notif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
index 68014222d7be..2bf5ce397233 100644
--- a/drivers/tee/optee/notif.c
+++ b/drivers/tee/optee/notif.c
@@ -114,7 +114,7 @@ int optee_notif_init(struct optee *optee, u_int max_key)
 {
 	spin_lock_init(&optee->notif.lock);
 	INIT_LIST_HEAD(&optee->notif.db);
-	optee->notif.bitmap = bitmap_zalloc(max_key, GFP_KERNEL);
+	optee->notif.bitmap = bitmap_zalloc(max_key + 1, GFP_KERNEL);
 	if (!optee->notif.bitmap)
 		return -ENOMEM;
 

---
base-commit: becb95e45ef0dda9ffb35156d909d3da7a2789c3
change-id: 20261009-fix-tee-max-keys-50f2db87b4e5

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

