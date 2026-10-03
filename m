Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BD5CA5FEC
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:46:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7A51B452FB
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791038802;
	bh=2XBTFN/ZW2XUHbigsiwRo3I5RiyJZNdRNr4QzxwJPOI=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=HkHI2X6KqeEL2sQD4MNW/u4wlKWaewOLTmEj6OE8Z885fMdcOvyWND+h4XhW1u4tw
	 ttyRtSLCP0wlLlc7cIa59bvMKLFS8vKIJqBetDIBSes5dM8FXbfhSzQIKzlzc5/SNk
	 hG3gWzQ8FmNE4eYPaXynUSmWcb7izn24QGNSQi2Tmomqazz15GpbNvtgdU0cnIotiS
	 BhWWoVnRiZSHauTYhxjoUhT/p+1JvftI7VRMFV3MgtSSRaP7HvEFQFa9A/mWmWFYMx
	 gbVe+yQX0hJLL3y4K5DVW5uJHmEwZBg+n7hEQ4VmF24FF6kLSdIAWLf8+JQldOAoUl
	 5mujtwdr2d5eg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AA75E445AC
	for <op-tee@lists.trustedfirmware.org>; Sat,  3 Oct 2026 14:46:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OfiQFcWL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g/iFcLMn;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693E5ju81372953
	for <op-tee@lists.trustedfirmware.org>; Sat, 3 Oct 2026 14:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=VjaXgIsxT1sF1UV+SMF8/q7IXyRGZSgNOM68gfsjAhY=; b=Of
	iQFcWLnRsurql/zV0MuZ2BPSKaG0LKMvqdDDOtLtTV8HKjQruwHBiJH3YtzxX7hH
	eiYTOM/m9GQ7BzKNwHVhxmksfUn6zbSImpSiRQzB4WRKM/0COAIEbYFgPL1UxZN2
	NLxHRZvicZ17Ohe/GekohiEWIroo3p1PxPSZF8Zh2Rev38k0yeQ+LMuyvKzweT/m
	vaqnHjgAcwmjutxyLVEOVGUe1q2RIJLGQxlYusjowQ/Mj1mt6w/vLIdyx/QUYJgy
	k8a6qUo5LWTiQzmymvkfxHojapeMBWk43CulN9BxgyZRI9KINQATqlhDu9moPKR9
	BR7QXHrZhJ7XOcnOOBxQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sr6974t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 14:46:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934956beec8so107033685a.0
        for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791038792; x=1791643592; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjaXgIsxT1sF1UV+SMF8/q7IXyRGZSgNOM68gfsjAhY=;
        b=g/iFcLMnBgw5jy7cOiHpOgV7EK4/wsCkiGc6JdiEoS380ObAHd6mgnQLpQyKMuDdNV
         FRe/L3KRpe12uIY7b6gvG9Vyfc+pupP/jGSvx4Q6Aq3pHH3FNOaodxxFZODPdM8Dl6aX
         mznT++KdWyK8sDev8vYCLHPncbS+jo/X3uWX2J9z6lX9im/Z7aHHwhPA0pr9P9SXudjF
         TzWs2hPjlu06/BRZtIp2AY56LSPLPX9iGcMAIjfL7uTHDLtAADtkoECzDZRHdVEJ+Cg9
         ignKNgWA1b3SJz8ZL+N4y2rLFeC2eDVPA6u5HWc3ICUPlnz/h61ffwjtZxPVVG9BwGya
         LTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791038792; x=1791643592;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjaXgIsxT1sF1UV+SMF8/q7IXyRGZSgNOM68gfsjAhY=;
        b=lpqW1poOpLDYXJuTN/Ua7ydbLROORLl8bfGcr69aQN3GNdSoWd63O9Gn5nwwZ5nmXC
         oGIf4qhmrb9YC4uJiAG735caUAy5lZBPTsBKUPRD1wqke8vOd+uOc1d5MDy/iPSR9ydd
         IAeiHWoJ3xBZs/grp4BhP1uMIgSvgcRtFQ+h9E2vxGrjYjPj7eSjrYIZc2kjcXuaVjbP
         kveOWbCVXsAqDC2PXVpHXFfEiSm8pvLHXru6RMsDGRt6e7IdsSDTjqrc2TfIMMg7FPLl
         l25I1DQNDCKTLx/YnG2fetQLa2BJ5EthgNZbTnkhRUsqxvYGqivLGvoyZshsfzY+7G0+
         eBnA==
X-Forwarded-Encrypted: i=1; AKwUvBwPWlv572R0HBxpZx1+L05RlNZZjqHhO032z2SbBG0uucM2idpz/9i6uyzWi8mZw11SSdW1eA8=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mWteTkHWbvmrcFQgmzOpp9bFKeq3fGusc6juQniXoqzsKnVMkm
	XhSYjlhOLV5AS8p7t4wXYbYnzlPH0frYdMxXUREZbm110/30RxT1BVQTMuwjenz0bw80lXL7DHO
	HviD5cBViajonwWNBYLZduHh56lhC+/Vl4IbrieqUKqDD3U+iyU3ZDZfE32hKS/o3z8FXwSbu
X-Gm-Gg: AYBFou3+0iYa/2BniLjdDI2PmQ3xgmzRawzqVcUSMTNPD4tVBKOJIrVU7PKUdoRptyD
	IURMHNcCL3ODVpsDDwa/wSbMNy7SGQ7nVIFVNaZy+yBwWASV4YEJ8VH02wjJC/ILhvc+c57/6gO
	GhwuyJ7XIy5rRQZPNhyTXaLQgslijskeFJ3frl4EU1edrMuiTc7baze+fdnQgg5ATzi5FFY3kvg
	qmIpN/H98vaghBNJJ9zfH0ETRrkBr4Tlsrkgr65pVtk6r2mGWsOIDh0nq3mMdxwv/0YIEijp2cj
	7fxbZ6tl7YdZEnrVa6CG16V+H8l9eSnP7HEXXb509gdgaTDvkuU7MSeA28+gaYW3oEr8DGKJEuc
	c3qG4nsuXJjIfP3MwtuQ+hoNXYUbNPP0nkcENe991o2FEEw==
X-Received: by 2002:a05:620a:404e:b0:93b:d7a3:45d4 with SMTP id af79cd13be357-93e510c3e52mr529042385a.61.1791038792234;
        Sat, 03 Oct 2026 07:46:32 -0700 (PDT)
X-Received: by 2002:a05:620a:404e:b0:93b:d7a3:45d4 with SMTP id af79cd13be357-93e510c3e52mr529037585a.61.1791038791630;
        Sat, 03 Oct 2026 07:46:31 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd0568esm206959266b.13.2026.10.03.07.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:46:30 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:46:29 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE fix for v7.3
Message-ID: <20261003144629.GA929824@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA1OCBTYWx0ZWRfX5jgTm4cAssZj
 WeWgGrf9AX906y36FadrJOJcCpwX5AUOSf7Kd1Q9DAwJbQI50ed6389zWAAYPArJjsz6MjZD1xb
 k72s0zAzKJF97pYQIZGGmPcTK4lEH+0=
X-Authority-Analysis: v=2.4 cv=NaBzRGD4 c=1 sm=1 tr=0 ts=6ac11549 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=eEE4H-7Ojt4y9GLAZT0A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: gthBfFeKtkCHMQYjFTEuH0pC4NDqdabF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA1OCBTYWx0ZWRfX44gaYmG8DufL
 meUKGSbWYLd/l2dY4ee1Xj1gSI7fLLP5LjHiSyK1UbRHUT+LLHY86Dx4UBQzxBIyVOmXpeLHftq
 1SDUMLLa5PLBM+Q/NNOt/q2+cEGkDbX9ilHefW7I4TvdMEOCrbBnedJflErrXVmQVj5QfaGI1dU
 BeSzlpnzBpBqFFKL2jmnRaYkIAR2cOK9e5BinumlHu999LOjVy3hP456YbuLOBY6sUI+kpjq2nO
 cHJVZJUbwfDgy8b3wgQlLd2Yf54saZ4jDbOPl37O7Erq3QKUqQ/scnTh63wiWshJkn/rHwaaKaS
 Gm4F29q+E2wQ6CkY18cOUVFSgsvOUn0OVLapHrXVpdfodjpv5z6FsRBfykURgbJPZjnGTb7zuud
 quA2kB/pC30NiaJzz/6n8uBu+Ea8/IWrCmQgF15LvnDvnSDWQhANdatpODNFAx+VhzIpq03BsNh
 8QwISmKl44uQ+kQ+Kdw==
X-Proofpoint-ORIG-GUID: gthBfFeKtkCHMQYjFTEuH0pC4NDqdabF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_02,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030058
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AA75E445AC
X-Spamd-Bar: -----
Message-ID-Hash: 2RD5WCD4L6AKZRNZ7ZM3U2QLNECFANDI
X-Message-ID-Hash: 2RD5WCD4L6AKZRNZ7ZM3U2QLNECFANDI
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2RD5WCD4L6AKZRNZ7ZM3U2QLNECFANDI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hello soc maintainers,

Please pull this small fix for the TEE subsystem. I've only had the patch
in linux-next for a day, but it has passed my local smoke tests.

Thanks,
Jens

The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-fix-for-v7.3

for you to fetch changes up to b7f925fd5226deb953c8dcdc9677d3fcc2717c00:

  tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper() (2026-10-02 13:58:48 +0200)

----------------------------------------------------------------
Reject zero-sized allocations in tee_dyn_shm_alloc_helper()

----------------------------------------------------------------
Georgiy Osokin (1):
      tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()

 drivers/tee/tee_shm.c | 4 ++++
 1 file changed, 4 insertions(+)
