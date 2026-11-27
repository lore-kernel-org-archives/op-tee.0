Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB11606A31F
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M5tKHBIJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KCyc6co7
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A67FC5035D
	for <op-tee@archiver.kernel.org>; Fri, 27 Nov 2026 10:48:09 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M5tKHBIJ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KCyc6co7;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 22D0844A3B
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 10:48:05 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GSr71197194
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 10:48:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=JyLQG9rBTqQArwS4viwQVVgmtdrQukXBgj35Nu+6H5o=; b=M5
	tKHBIJ8nWRAJzDPhmHVzYuCtdlzvZw9LMVfCWXJuH+7nLvkau74NMoD5KpiRpm7O
	+C9nRYoKdBzK/T12Jp2hpAqdo+ErX66u+Z+IdG1xZlSdayg98QL3mbNWk49s+ccw
	c8At/XSk5tVvTE07NIplu17lo1GPOAcVzoxyPVNn72smrzOSJtoJxU50r++tvMw1
	uP5ILmYa4uBltmFXezN5FroarsLj4HIpp3mI03Qsq0ZUyEKI47oIKoOWwbHd0r7e
	/Zif9Hfy9wHZ/6xv1XV5WhI7H+ScbE91GpsuuU+BfS9lo/kldJyJkwX9gOw3llwN
	xnCW2gcYWocS9s1G77UA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756k8vt6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 10:48:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-949b0d322fbso1096189785a.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 27 Nov 2026 02:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795776484; x=1796381284; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyLQG9rBTqQArwS4viwQVVgmtdrQukXBgj35Nu+6H5o=;
        b=KCyc6co7zlnegrH3IRAEzpvLw3thxMMGmniQCVmrvhw2vBSKxuxGGCjyMxB5Gy+uXX
         mTky5hKIZsIgqP8r4cWiNrp9ET11P51lBrYDMkDw9HTJcqP1hoKYf/f7kZME3YsImtS/
         VOPBJ3tlp4E4k7BNBc6uW4U/YfCzN/hBxTeRFRnTI35KeIqeaxZhKOu3WsBDAVERy9UM
         qglZPR0rkjWsp5ldpIEgeMiTAUcYaMbCwonSrNhhCMsL3y9jlUzIyRVCF91+11tkQ6af
         792QOJvEk0UXa3c7tuFO87rFXmhSb+kOakFYKfgYnNktBWpPcY1hr3KAHDjlzXcFmUun
         zKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776484; x=1796381284;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyLQG9rBTqQArwS4viwQVVgmtdrQukXBgj35Nu+6H5o=;
        b=pKcIIKwiXW108bxJ/RgyIzByJ5vPYaLHimuCMYeiaplaBJ9jut3lh4BfrTqYil9iFr
         W4KouWiPdElY77ZnaqvYGsMiP3Y7z+2YTnm2fQ3JqIGRCMSykm+NWrEYbLYHLvwILC42
         iIm8KkzMSjK1/Zdhmd8yjO8D92wKEuSWhuTveSCGk+dm5bkLpxqsqH1T3+uZojsSr/Pm
         0if8K3+d8FDwz1lQDV9+Rp+7PGkwd5VW9Vs69oMNlOmHg48WFjjWZ9kHpy2E8EmUjmB8
         HA+6ITtCfyKvTFlA0GUi+WJwXbeMu+KPADlH0m3Nk+FRbpIxSrwUyMp+OBso01Eb08Z0
         onHg==
X-Forwarded-Encrypted: i=1; AL+hErFZ2WK/TI7WwFeeHla38KCmSLvGKeMUiT9yamDkP2mq5ee1rvS1cwou1B7xmH+ZSZ9qIPikB1E=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z9BCZAlFG2lXyC/FYKHzS/V9gvbXDD2wovyFyDkXJ8uYbOkEObM
	jcZ3aYf+zy0/SF/MDbyi8oVYq2JQYVt1BW2mGkhgPwT7uZloAjJf3QgmaPRx8gEFHqIPk79uOYK
	oyFwXkZuqmyAygMYyGSK1Ghx1tkJTo8+bFfzKDWEFHxMFZMp0l8NqFSPDYRVKLp5NJQxZIGrHWx
	c38mlEgas=
X-Gm-Gg: AZFdTZc3K7B8TjMssjM4L1TWGQ3trwnnz3rFJMlQJBIUWxB9YYq2fjRS0MqDxlSjoCu
	JXaqTxvxdsTCPTiTX7ZTAalOGbfTLUILrodXRY5eqGtFLIUeo6zpFvulpiIZbz9I10BPbsnCNKr
	E6h3e21+vGAU/r/jDEJPSmOROdYmWj14c8Pz/QS79r881yXqgs0ZAVB3VhCy+5j5irWIig6bVMS
	yOfcmxfBUhi6coWmxscN+DdAtQD0UwU4MGbsUBLrhF6mAj+Vsfe6D+VIgFPZ49psjgBIPYPtQLF
	MRt/x6Bv8DtTkGxs0W1Q7xyX/4qWVfcdg91ed0nWCs4t7YEY8K/sxuBLaAMsO+9gcIwVHsbsdeZ
	14Rz+X3ax+udozo6fsTzur1OMEmca2WsNxOoUClzuymzNxQoBIzVBji6CWQqyrWz9VCAHONFX1v
	KRkhZ2kJiK6yaj9RrhHR/oPtneYWPVZWBvjHIzkolUBc/0LHmyMHvmhmT1TJy7t6UA2P/O/yvbN
	pa7
X-Received: by 2002:a05:620a:4554:b0:93f:3565:813 with SMTP id af79cd13be357-949ba80f8a1mr3805080185a.9.1795776483827;
        Fri, 27 Nov 2026 02:48:03 -0800 (PST)
X-Received: by 2002:a05:620a:4554:b0:93f:3565:813 with SMTP id af79cd13be357-949ba80f8a1mr3805077685a.9.1795776483317;
        Fri, 27 Nov 2026 02:48:03 -0800 (PST)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fa8a4sm10777328a12.21.2026.11.27.02.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:48:01 -0800 (PST)
Date: Fri, 27 Nov 2026 11:47:59 +0100
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] QTEE fix for v7.4
Message-ID: <20261127104759.GA2747365@rayden>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MiBTYWx0ZWRfX7O2IMpcQgT/A
 tsZRl6F49ldw9BnMG1o95ITnoVGIvkxF0XK1fxJbr3hsZVGrnM9JQ2vE9vnykxZnClJKADw5u6t
 jsc9bhqyNkIK/z9+LyD0KdGVLnzFBMHPtrL/PzWchbMD44ZqB1FSlazsxa+U0bF6zTYJZGs5MC3
 xoHQ34+vaH7X+ICEmKpDWNzSYLUEoZHi5RNdVurx0ljHcXtZd8jYzVzjoguR3wTVB0F0FfsYxJ4
 RkCO5bP9vg1iXU2S58E0S4y58J6MB1Bh6DsRNanYAvGOodmobfi0cnE+h1/MFkOecaYTmjQFXHP
 K9UYFjIz/nOXS/lAGNFV5F3/g1LdqIs/R+UVLrCV/xRk2hVMd24qH4jlp9tdF9fwme03+HlTBTa
 DPReIJhLn/BcB2Ms3USFzprSa/rgnZ2IEja2Wam40RbPC5+P7tmtdHHGY7XLmYgumPvbU4zaK5o
 BiVh7Ac7gK5+KDg5aAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MiBTYWx0ZWRfX5n6eWAygPG1E
 4mRzjd29Lz7+6XQrGcyjBjDr6YaRfy3gOhaOfK6zz+DfwACvHQ/VNtDmXu2BciY0viHL4VQPAOw
 O4r26QF5Vj5rPTlqH6APPJab+NHDbCs=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b095fe4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=KyRjHmHKXXPnJxnbqygA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: h56lxAKUiLtEqd1CDTIX3ZAi-ICoeol_
X-Proofpoint-ORIG-GUID: h56lxAKUiLtEqd1CDTIX3ZAi-ICoeol_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270042
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	DNSWL_BLOCKED(0.00)[209.85.222.200:received];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 22D0844A3B
X-Spamd-Bar: -----
Message-ID-Hash: VPSXYTOFGNZJIRXHAEZVPJDWQ2Q7ZWVM
X-Message-ID-Hash: VPSXYTOFGNZJIRXHAEZVPJDWQ2Q7ZWVM
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VPSXYTOFGNZJIRXHAEZVPJDWQ2Q7ZWVM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello soc maintainers,

Please pull this small fix for the QTEE driver in the TEE subsystem.

Thanks,
Jens

The following changes since commit 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4:

  Linux 7.4-rc1 (2026-11-01 13:26:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/qtee-fix-for-v7.4

for you to fetch changes up to 5f1bad1c10cbd008a6b2042cc4cb486f6b2e29e2:

  tee: qcomtee: user: check the parameter count from the supplicant (2026-11-05 16:29:09 +0100)

----------------------------------------------------------------
qtee: Check the parameter count from the supplicant

----------------------------------------------------------------
HyeongJun An (1):
      tee: qcomtee: user: check the parameter count from the supplicant

 drivers/tee/qcomtee/user_obj.c | 4 ++++
 1 file changed, 4 insertions(+)
