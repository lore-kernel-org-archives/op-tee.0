Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D14C55ABF
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 13:21:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B9B9A45180
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1786022485;
	bh=TcpSN/phFU4+1IiEyeqX1D8vXg8oDvAhr7ckxaNC6Ws=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=amXRDdZ5Ar/X5TiKy+ZO0EI2GZNQQZnNOqveYsKeygFdD6o6m2MjzqSl6v+LLlVW4
	 4qLjINHfrtha/1R+BeV6hiufwSxwcP9Lik8EWo7pNQWVqgG0bH/RbpoGDA2SSOs0Sm
	 ikWZL0XPnOgcPj5R4eks8gRdwZqiblo0/Gn8KsYkFzdCNt8sEZfGM7mzeGtX0WmAVu
	 ipjbZDkgG0O1tOQhuEywDD6Ay1clX+POcqlcQk3Izokqc1D0F3M8v+ZNbD788/xds+
	 H92gTMq9BdhPe8rSyj0r9XsUvtR675byPO91pMsFd3So/o9RGgfI1/7bLMsEmlpHoo
	 GAnZJ+vfcmhLw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 23B3E44E07
	for <op-tee@lists.trustedfirmware.org>; Thu,  6 Aug 2026 13:21:20 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T7+e2XPp;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GMTewlJa;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nfAD865629
	for <op-tee@lists.trustedfirmware.org>; Thu, 6 Aug 2026 13:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PPSac8z4zvvOslaoh9M70w
	g675Jov8kOialTXHEgSxU=; b=T7+e2XPpben0wmsot9mtnftuofDIknP6PJX9Zd
	XEncXSKKq0Najtk8VJFkbnGHD4A6knNY4e4DKOt8ko6hKggVx9r3cAdT9SnVnsqq
	kCAer740k3D3vtqxXGIEaFJ5m2cd+NPEHRN2pi+lHPgQHxBcI2gjHG+NV5LVRimd
	YDHAgL4Gluc83hcoiUIWc1Dz3yBoyNQv+yFJTJn3thzqrR4/zdgnkxUaG+rRFw1J
	2O2h7fbSAREPtcofI85uKbjjNMUlAasM43fZVRWD2TiTnWITGJd4Gync4VKh67Gu
	Dstlz8Du41BLjQW6vi3K8u5k1AOYSE4OMERjItTfF7adMmWQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f5cfpn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 06 Aug 2026 13:21:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ce3c7cb2eso32743751cf.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 06 Aug 2026 06:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786022478; x=1786627278; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PPSac8z4zvvOslaoh9M70wg675Jov8kOialTXHEgSxU=;
        b=GMTewlJabNaCwep9odCjqhMGkIJU4Uc4xPNq0SAKMvByh7sNdKLXMSTDT/3tZGdKcE
         qUWPitIP6IyV8uD8l4rB/LuqzN8Gb4wIgb6Qc0RofHOiOIQxNrIFCY43wuCjIqPJYQVT
         HBPOAfa632bOYumiI3u+30yIAawlm9B3mObKIK6HIof4DmXdtxLj9wwa3ZPzhgxdCNZc
         9j3gw/sED/YsDDQLpdzLnkhFXGb/zPkHZQYEl2tbVgoNmTrauBNx1qDGxoNxjLx4WQUo
         RLYwuV0nSPWeewHTHsBOuhj1equSLjIDKH+hsv94XXrjQvX0vde/Mf6mNMiAMQymCFTs
         nIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022478; x=1786627278;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PPSac8z4zvvOslaoh9M70wg675Jov8kOialTXHEgSxU=;
        b=QxFybGqJf3OaMiVYFun0qsxokKdyug4rypM0XlJK3w5dI2rtWRN3yWlILhPqXe4X2W
         PropTD9/i4d+nR3kYnqpODJpx1iqoMIpLoORpsN9VN//LhCHnQHNzd/kmFL7j1+YS1zc
         GSjkqdFVt7QsKbnLfTU3aX9WhRWTCCnI+SAvT2cIGXAKHdjdvIsG8SjGMTvUCYbgl8Vk
         j0sg+FnoFDjacYieLD4L+lBrbEcuAYSXjfODW70DPmpWtRsl+ZAMlZwR0jgLiNtqt6Xd
         iOIIKPjMiGkt7K3ebmG2zXKb1f86jSRtO21HvjBKggTBNJHRxzH/dhJcPgoCRoiCRfSB
         NrzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqrFQw9ShU3f4coXsWWlB6wPqAZT2nAqtD/jM86iNEjk0bvg7VqkXplfA4UqTs2HQGNgioXIfc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywnpo0dge016xLLpMEa+U8ZGgzYtcVJLfQ5Sng+pblCAZRVIYZP
	55tIczIBSapJGoRn33taW1WguFRgKf5QpcfuLrj4ciOMDE8/3Qsac3VpGxSkC94gSpPrBur8ThV
	a4O5MUbtdslYxnaD6FUKwsZ93owSzJWIcrtJtpaXDpERTo2k3gbcMzlytC1FM5iKduFiG++j8
X-Gm-Gg: AR+sD10zPB3cFKRB2LeNiOU5aJqJIrICrw8If3Sdv4euOgDuBM6nAy1DaOUDPoQIyTJ
	6wIT6Go6Rya08PIgd8X+4UP1L4nL08hI/xdQDXfIN9Jh+OdqwM39DziEA8yhdkRBfUkmE/WbPke
	u7lP/Itp1HEpQsY11/RBI0T8Tbd8V1sLxY1DEv6OLSh4m59Cs+im/WeacH5Hhykq9j4Qux+vWjV
	v7BYNLYRiOhhWJfqlKsv0vvZ58kV4GxvAJvtvj/+V8Z3FpmToiePaUVGPou16EepMiiI2DlKgE6
	+ffwXgmS7AM29oGCWtgQP9CTNHqEonKXuNkvApO8FgS065ffWralAafmTW0mpWepJ1KY/MlObcc
	5UJazc8MnZRCxtjB5SSFHU2/Jn+WbQeMnFMFK6WyarAIqzg==
X-Received: by 2002:a05:622a:a10:b0:51c:a9a:b0ed with SMTP id d75a77b69052e-52d0b191dccmr16339391cf.26.1786022477695;
        Thu, 06 Aug 2026 06:21:17 -0700 (PDT)
X-Received: by 2002:a05:622a:a10:b0:51c:a9a:b0ed with SMTP id d75a77b69052e-52d0b191dccmr16338761cf.26.1786022477294;
        Thu, 06 Aug 2026 06:21:17 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c203645c087sm244027266b.58.2026.08.06.06.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:21:16 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:21:14 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] QCOMTEE update for v7.3
Message-ID: <20260806132114.GB673420@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: BBue8Vnm7PJjpspgarlXne_qYaNVLB4W
X-Proofpoint-ORIG-GUID: BBue8Vnm7PJjpspgarlXne_qYaNVLB4W
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwNSBTYWx0ZWRfX397fRboza68o
 fqzn7qqOnYdK+C4TrwGlMzDBoYa6DTErqImUVU8L2cFM0NgBq0QA/AG+sTJUPi+D6QvXF6uQ5Yv
 rEZNgxobUeJS1CzJYw5sl+/SiWC2waA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwNSBTYWx0ZWRfX0+52q749QLnj
 +uTE1eERip8sWb6XipPpsiRcqHfTwbg+jK6rRb8tztuz80pSyMYJ/u/M3SCPIQv+jkyXYnSvfN4
 QTxGtdRFImq7skCv5w65OpGIiiK9KQdHaQgCgFjijfgzLe6SznkLsSACtKg6gkLLYHXujLG+mPC
 pHexf1cLtPwDEvOVugjcIY/NGSxaR0ptrJNAYHovOAOtqQgG0aLAbjAN3dviDwm3ff9zDFwC/kD
 xq+UIBs+e3ByfCeBSeO1kjF7IxzErXVzkoDQePPX7xyomYZV0JGDDekbOqKHALP1gQDhu1sT2jD
 qyIWpSIH1vb5VSHeoX76MTktPCuhJpWJTwj3F8KVZEcjJtKWMXcle2TClNC8leyAK40Xs552f+C
 ZasuQD8ENtLBB0tZJU7tDPvSSXxtiGxDNgGa23PvF2QQh1o2DWRdlnocrkpiLiQApFrq9bofTIz
 mcv9vnW11rTpSCK4iCw==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a748a4e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=Oq0JbnJb5wmJE1LcQasA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060105
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
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.200:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
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
X-Rspamd-Queue-Id: 23B3E44E07
X-Spamd-Bar: -----
Message-ID-Hash: R25V3ZJLNG4XC2BVSIAKWXUDK5HJNMHB
X-Message-ID-Hash: R25V3ZJLNG4XC2BVSIAKWXUDK5HJNMHB
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/R25V3ZJLNG4XC2BVSIAKWXUDK5HJNMHB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

SGVsbG8gc29jIG1haW50YWluZXJzLA0KDQpQbGVhc2UgcHVsbCB0aGlzIHNtYWxsIHVwZGF0ZSBm
b3IgdGhlIFFDT01URUUgZHJpdmVyLg0KDQpUaGFua3MsDQpKZW5zDQoNCg0KVGhlIGZvbGxvd2lu
ZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBkYzU5ZTRmZWE5ZDgzZjAzYmFkNmJkZGYzZmEyZTUyNDkx
Nzc3NDgyOg0KDQogIExpbnV4IDcuMi1yYzEgKDIwMjYtMDYtMjggMTI6MDE6MzEgLTA3MDApDQoN
CmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogIGdpdDovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9qZW5zd2kvbGludXgtdGVlLmdpdCB0
YWdzL3Fjb210ZWUtZm9yLXY3LjMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIGQ5
MmY4N2YzZTdjNzlmNThjYzZkNmVkYWQ0YmYxYzk2Zjc5NWFhN2I6DQoNCiAgdGVlOiBxY29tdGVl
OiBEcm9wIHVudXNlZCBhc3NpZ25tZW50IG9mIHBsYXRmb3JtX2RldmljZV9pZCBkcml2ZXIgZGF0
YSAoMjAyNi0wNi0yOSAwNzo1MzoyNiArMDIwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KRHJvcCB1bnVzZWQgYXNz
aWdubWVudCBvZiBwbGF0Zm9ybV9kZXZpY2VfaWQgZHJpdmVyIGRhdGENCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVXdl
IEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1YikgKDEpOg0KICAgICAgdGVlOiBxY29tdGVl
OiBEcm9wIHVudXNlZCBhc3NpZ25tZW50IG9mIHBsYXRmb3JtX2RldmljZV9pZCBkcml2ZXIgZGF0
YQ0KDQogZHJpdmVycy90ZWUvcWNvbXRlZS9jYWxsLmMgfCA3ICsrKysrKy0NCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo=
