Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1599FCA5FDD
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:18:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4003C454C8
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 14:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791037115;
	bh=1eedhvqEoDar26cNo8xuHHgN8H0ummeN8BgfjAAH7RQ=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=Fqw0M8HO5bqJuW2AJIbqlr6Z6EhFVPIpjx9QIR/k0lElPZJKqrss5KyceME8pFBbw
	 Tnpvov/s4dAbAtYk3CrP/Z0+QrGtgeo0wMBCNo5HiWin3WKpXJr2pU2qYu7noeErdZ
	 9dLDrpQrPkWRRtYySk7oo6G5aSoe3rjWZrlRW6u/hdOqYnnI9PgqtKWMpdcY2Ft0M+
	 vF+yZLi9OKzSP+tHp9t1ImRGGKGF6vvSCPmtIoqtqBkB39vEUcknOXqkJD5IOcKMtd
	 ImA6YGwMalZX90TBdjJckmVnCLwlJprtLItCE0KUK4W+GcOsVfEvIhEdE9UuzcXTmm
	 R7w87Cz9XmzzQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A9D2844F01
	for <op-tee@lists.trustedfirmware.org>; Sat,  3 Oct 2026 14:18:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f1zuT6RP;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X2I/0vub;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693E5oSU1373096
	for <op-tee@lists.trustedfirmware.org>; Sat, 3 Oct 2026 14:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=KpLq6T5CbATDXOe3S9he3OBDjINXVpPEk4u//5by3IA=; b=f1
	zuT6RPpHDQJTsLLNaezZEgZAg6NNzu9DOXrxWSUeAGkNZ7rpAv5GxSKthakUhnSo
	dmfVV2ldK/6PZoIfu2HczusHypT8zG+IpnWAMwHpXSsZwZkunZxtJquyOjiEgkWg
	kQOD/wFmg05yBrnVIk388C5ZHEX64YEQnkmhf558XF458dX6CLuhbsEbiwd0exrr
	Fekjxpc69dHlN31pHC+7bLve94NueU9idNkl88nO16o5dpVyoGSXVoDvsXMHrebK
	Ltw9WpCCbkubsTZinyRGv+p4SOxSYQy8IPMlomkGaUxSojtKQOCCwPKJ5VMHKTud
	rg1KSVjJO+GYpZWvM+NQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sr695g5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 14:18:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93caf7856ffso17116385a.3
        for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 07:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791037106; x=1791641906; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpLq6T5CbATDXOe3S9he3OBDjINXVpPEk4u//5by3IA=;
        b=X2I/0vubwkFETePRelkg2KktLNfWAjx682PB4fVOFTaqVthkCq6XXgrKKICi1c+x6G
         /XRjMWPiZpUjPU9haGKxpzk58XehxVwWrWZDERwsKvn+fVvr9vz8mxZ/WOKOBXKyNwYT
         YDxw4jDafTLSQZAKT7nM/Yu9LM0gknfYOLx3nBYpq7exmK4FYWDRoWZ4Kio4Ye6d2bh3
         nvw01L1yINACx96Ijqedj4mtAplabrhufbHBA0cpUORq816GMQHUI38MHcLExZVtZfln
         z7WsBnFfNyfkXHBNlKgvwsgQ/WWEkECHHCXwDRCWc6ZSteoPcvE6/hfiAhelu+SbFYPH
         VcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791037106; x=1791641906;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KpLq6T5CbATDXOe3S9he3OBDjINXVpPEk4u//5by3IA=;
        b=CJzyV3i4Lip+dQtMosJeoEJNoPbOifn5mm7opF/xXqp9tjVUVo8lmQ1fOnz8ymwrRj
         blKm3WAXFacFfG4MKcwIy9VlTQ3RENv1+wL7B+QpqX6dt4+5wMxR0q7aj+AFNKA7uFoN
         7lS8L2q8vf6Q7++bxPtmILuVdJA8FlAGJT01S/P8DFB5iJM0Rms5c5Uwm/bn8wD1IYK7
         WX67xn4tJ9f0nxbl66Zzpf92g6QDOgY/YamhQBbxf7CFaaYm+vkuVxctxDGkD9PUJQ22
         MG6ORz6MuFSP4K7HH/xZkqMInOkOqjRgzIQzko/I8PlAGpDZi0uP6aSGz+83YHUTHYts
         DNOQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUHFgTgUcfv7JFVsrdlwhbYVSBr62WjLW3nDU88Q21jcoIkJc25lvfhMpvdZDOmi1QUPhKAxc=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++nvZIWs7QpQtcH3vxUTNBp0j9YWjvkxgm776OMx//lwY5r1mGz2
	t9alPjBhomZI+9JgGUk5XW9OC7XGFEx7mFFrOHJOq48yMcQRRu7nhf4kzRPWIvUGpjmOOpV6Acp
	z/Z77D00wZVJvMk8MxUUVpipcpZQ7oXgDh7cAmBUYZsWQxnq4A5N8loXStguFPZvJn6WdWpRO
X-Gm-Gg: AYBFou2HjpOV25HbKgsmhmxJMyB0G9YSkE6o6Li77TW8iQeWg8lrL08YCSYYDCUqsYN
	mGVDPHWZswi6HjxthMqlurhsD+v3+pfzeYG7ZhCwSOcxHuUvnQTGE0VcTejwgv7QC/QTWS9DNQs
	lu+nEud2zQMwTnAwkavtIINZiMVo082PSPvpL9nBo0LlMC0vxL6KezTHKw1yrLq+n+IkLO5Rqpc
	fwkuy8iRyTsrPUjKm5/7JKL7OwLZ6vuzwyjFE8jEhuKseA6VfPmGYEn1OJi94WSyDJwaTb2PXPJ
	7YFjeLes9knAw1VLymMP9Wd8hOJehO3P9GyVw+SF4plt5TLg/Pk1qdJRBqNJVWIpRRO1mZqHF7c
	RYefnhKcC0qjtOIgwN/1bpfm2I+FvfLcLfWUDrHxRx9O6tA==
X-Received: by 2002:a05:620a:a415:10b0:92e:7d53:8e8d with SMTP id af79cd13be357-93cf16dae99mr844770785a.27.1791037106368;
        Sat, 03 Oct 2026 07:18:26 -0700 (PDT)
X-Received: by 2002:a05:620a:a415:10b0:92e:7d53:8e8d with SMTP id af79cd13be357-93cf16dae99mr844766585a.27.1791037105971;
        Sat, 03 Oct 2026 07:18:25 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e59dfsm884481a12.8.2026.10.03.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:18:24 -0700 (PDT)
Date: Sat, 3 Oct 2026 16:18:22 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] TEE updates for v7.4
Message-ID: <20261003141822.GA927567@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA1NiBTYWx0ZWRfXwoI18ljHgghM
 QtYS5d3JiEGQM9WbmHnxpzuqIYmhf76CU5593YRO13QczsoG49Twea3eRLKSUR/J0I9jXpEpo5g
 3TLJf7LuJl50RvZL8KvNfPwvtt3XGwM=
X-Authority-Analysis: v=2.4 cv=NaBzRGD4 c=1 sm=1 tr=0 ts=6ac10eb3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=DiaXWS5xduwjvWiepNMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: GyfbjQKTpi8R_WMAZU457qCNElU6BSLk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA1NiBTYWx0ZWRfX6qm0fYwoSx3a
 ySbqFxeCeJjQdkqeDzzs6z7IFAc2rsP7rAjK+aH6JcBntIa43ynNwqMg5jA2nVw6jZfeAz4mR/6
 fvPqtpNLn6iVf/6DB2Vd7+J+Pq9Gi3xxXUl5EU+hT6cuCx2fFFoFYp7dw5FI6QWDwtKgwpgELK9
 g5kme29l9/o3RTOwYY6atqhU22EclQE3DAX2oF5fQO9ZBOqx3WYYPKQX5u6mf9OsMm5JdLR1VKe
 cbPeWoj7LAEl5yPKFXyoQoq8Fo3WRT7xAQarJ+7hE87+rZX3RPiheQ28OPgMl+WJBUepsMxqh3y
 rCDspqQzzZJZUIBWYxTpAUY2XqMR6Q+8LopZHV1FfjcojwZdcjnEJ/baz8ra1s2++Z/CSJ/nkbO
 bGgX0G4epge+1pfgZtDT1WaklZo5Ddff7Xc4HBZhTo8pwcaPXHFE4znElcvTfM0oMmWhRniVntH
 XsX296kpqh7i3VIENEg==
X-Proofpoint-ORIG-GUID: GyfbjQKTpi8R_WMAZU457qCNElU6BSLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_02,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from,79.136.84.34:received,209.85.222.198:received];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A9D2844F01
X-Spamd-Bar: -----
Message-ID-Hash: J3PQI4UOYULGY5GWC3HK6MG3DWISQ5XU
X-Message-ID-Hash: J3PQI4UOYULGY5GWC3HK6MG3DWISQ5XU
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/J3PQI4UOYULGY5GWC3HK6MG3DWISQ5XU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hello soc maintainers,

Please pull this small patch for the TEE subsystem.

Thanks,
Jens

The following changes since commit 8d3ae59288f1e7d58d76558a6ee96d533bc5019f:

  Linux 7.2 (2026-08-16 14:32:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/tee-for-v7.4

for you to fetch changes up to 6229fda9a88656ea7c727c3e2401080c5d3efbc6:

  tee: move tee_ioctl_shm_register_data to above IOCTL definition (2026-09-16 07:52:31 +0200)

----------------------------------------------------------------
Move tee_ioctl_shm_register_data to above IOCTL definition

----------------------------------------------------------------
Andrew Davis (1):
      tee: move tee_ioctl_shm_register_data to above IOCTL definition

 include/uapi/linux/tee.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)
