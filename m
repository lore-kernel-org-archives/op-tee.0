Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637BBC98321
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 11:13:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 70DCE454DB
	for <op-tee@archiver.kernel.org>; Fri, 25 Sep 2026 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790334819;
	bh=Us7bYtKIA2T9GP/Ra7R4ANSp1JBGo3IAW76i4zyp8/4=;
	h=Date:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=NclbDd0UBWzbC61/ycnHjp5gpf07p94PZMGi6d3gkgye3p5JdAP0/33Hntag6TZHP
	 r5csVMfcBXQSqmyNkg4fjFE0lS9pS8b+MXkhqBST++Y5mYsbwnCBFc1TiNCCDtNw/I
	 td0cOagyt8DPdqrsICuMKkliJRwH10EqHfvmlntNI1/DPEZzkwttSGy8yiRS446sG7
	 ZuwlYsVTABDMeCGUH406VJDfHvDcTrIKYOYNecwP7RZL9sYnvXW5XsX76rTy+lahxH
	 Vtd+wYL7nMWYhCOaIw8IaPVHqSceR5xPOw9+LDEZVriYxZDrQstt+rt/XZqKxREFLc
	 53RapjhCSe/dw==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5345D44445
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 11:13:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X6VHxVVd;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OwJvY53M;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4YduH2911789
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 11:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Us7bYtKIA2T9GP/Ra7R4ANSp1JBGo3IAW76i4zyp8/4=; b=X6
	VHxVVdhBjq7X9t8VorrIRDT1wc1VkPOo27bD/0qqJK5yg34IWUMFgXMdsOkym6yo
	VWrw1dLVJkGxyejouWxB9UWokYwwi2dkaYo2u+isq8J0dso6W87c4cSsVV0W+Y4M
	O0mjaAto7TO39anG3tdtmB6fT+++2cEvVtG+fpw76ARwa59KXe4SB3gTcDphgMcj
	s7G/+N0elBXQWlbhi6eDYThhSt/i3wMSXzjFBREyzewS6Nfr25jdMOeKmxGuN0oE
	7YrZ2Z9GlGgl0qRFeMBBcWxFLZhwbgp+f8y93ZolFhfGyES6UxyV+fdxJmaquBSe
	CYKG/Hs9xvoWskZtzgmA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwhm518pk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 11:13:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9390a2c895bso215057685a.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 25 Sep 2026 04:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790334807; x=1790939607; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Us7bYtKIA2T9GP/Ra7R4ANSp1JBGo3IAW76i4zyp8/4=;
        b=OwJvY53MRfO3PY/7aG0zGT4tX8F2phpyhsRiYVEqh23yXwQi5xqC01Yn2qhcpNtHEu
         DEjjWNsxGFB/OFNugDa1n/FWb5AnK21NPYwfsL9FT8RK7MVT5guAydS/mJ5CIAe2DqHC
         X5/wt0RWLB+1xaRLFrMUBG3923b5xIA8v9nFumjAmGN7RTGmsaeTShD7XywOWY+8aSGl
         yI+LXGPSO7bo2cPUWUn0od6WXksaG+310UZzkxiDr+AcaTFLKv0qpbRoKdR6U+2RTEFt
         pDsPT4MRUFvLePou4YeMyu8o2kUmv49tc6bXC4XfnurhOIf0mEWPLMRAhv86oKJsK3lk
         PPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790334807; x=1790939607;
        h=content-disposition:content-type:mime-version:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Us7bYtKIA2T9GP/Ra7R4ANSp1JBGo3IAW76i4zyp8/4=;
        b=pogAPRcTHutOhGJ9bnCNg7qAO1YYykOsvU6DzAMPAY6SV2MUPaK05KEn/N6yRBOk52
         KmBrTu+JofPD/pEoCSgO/gvrAmAmxEjhFft2gM2lklfDwDtgTCTvYahs73f4zSKKQTkk
         ZROGyc/bjdNxUHRz2w/WjoYNktgQS1rsIHUlERpmACvXBcwsdMuB34yLx5v9Iouf5KNQ
         sMFPC7qi/oRnedvRu6/Ty8lMlg43mw8Lq7G9ktK+Nmuid/8SfFZNwWsI8ID/S0onpsaK
         jcobzehE38rucCPiLBbcwOkeHbWSbRBFSWNgGn3VL+0MY2k6tM2qrUN38/VLnXWr9lTK
         8/iw==
X-Gm-Message-State: AFuF++lu12j+Rs+GtE3J9NFhUCatVo5jZce5B1IvnqTbVqCW3h5nW8gJ
	A9OKvo7v9fuUe7TjxGkEWnFhx2hKTXtHMt2uL4ga+3co60IDx8gpmQeoh0sTL+nRMvK/Vu+B4PW
	k6unjj07DG7UvPrkrQhKNBJ8geXsY7XaO8K+C48fYt6AkShGQzb173zn+1o/AGCgCjkPqbPCNJk
	MZRJ8ixhiUnChd
X-Gm-Gg: AYBFou2HmQwqSRvTJaG1i+3MvGLQx8VuxmtcO2rzLzT5jXii9vHetmOFDM+8AmenJt1
	ch/fOAZCE5dKwQCI9wxJrunneDhfSyUopUks0yUNphLel6tNNCblGvwwIzS9m9WBW34CHSMTHK6
	K5U7cnV2VhLWWiy2JYpq6yqdvSRJr7JaIe1srMcu8BODoMM0oXklssX0KfSGBRpO6q1hnCTRz2P
	oKhfUyvjXK0uBVXLgJgYud3o6TIV5Ej1L6k+dLj80s2+FkRdE7NKvyxZCsO1kCpq25Z+yztMcv2
	6cLirIVMeGgaVr1fDveq7mnkuqer3FGWjzl1JYkzpsHN4ueRLP4y6sdUCXPdCKFNeSeegduUC1K
	J2o4d2yf/npYi6du7WJDaJQnaIofx6Er/GSFe3iQ5bJJJUw==
X-Received: by 2002:a05:620a:4494:b0:93b:c350:a31e with SMTP id af79cd13be357-93c43e0e7a6mr365135085a.38.1790334806962;
        Fri, 25 Sep 2026 04:13:26 -0700 (PDT)
X-Received: by 2002:a05:620a:4494:b0:93b:c350:a31e with SMTP id af79cd13be357-93c43e0e7a6mr365129885a.38.1790334806511;
        Fri, 25 Sep 2026 04:13:26 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae7587edesm100238966b.34.2026.09.25.04.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 04:13:25 -0700 (PDT)
Date: Fri, 25 Sep 2026 13:13:21 +0200
To: op-tee@lists.trustedfirmware.org
Subject: Preparing for OP-TEE 4.11.0
Message-ID: <20260925111321.GA3247540@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-GUID: 0uDv6SVwVX0FRk_nGURs7U_FHaTd0f0Q
X-Authority-Analysis: v=2.4 cv=QYnzLcbv c=1 sm=1 tr=0 ts=6ab65758 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=UXIAUNObAAAA:8 a=KQNfZ-Pf6hwAyzCrX54A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfXx8FUtNXg0gDx
 WdhSScfv6c2PMtXMjoiNG0JuX6zUFJr/BQMGve261LIQh4wwiL4NkSzZ/lMMKb+/IXqucyLqn0S
 cJrUZ/3ikVOGnm6S1phJ5Ec61DkopgGPj2SBRvRTV3yM2ax+sQJvgMzV8SR0uoMda0lZ/a+71Aj
 NwZROCikFUCZNW/pM7ENIKwaZzmj3SuEE4KmCh8MMpW0FZ9dO069ZhA/6P6Jak228YLLv/ysFGy
 YM3VtzlqpFBTidFAfMUMmpWidBo+4mbwpH6UnRM645x2mvjqiWqyph8fF5LKsNTTcgU+/QuKCpU
 8Bm7svze/jR/tFkIJstQIhaGvBdUNZ6OAFj9t0rvOij2jlaYXFSVd7JqeyJbU/wsuwdMahTRPWe
 Cxs/jPKE1vWoi+I3vJaniIZzOppvxA4LFXJx4IYLMVqeLe1tXdPMPk7KrAodyqVn4XPZJuzbBrm
 LB6d1JZinhBeTmqJXNA==
X-Proofpoint-ORIG-GUID: 0uDv6SVwVX0FRk_nGURs7U_FHaTd0f0Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfX7RFYQ7aXBik7
 sTU/1XUkCmQZQMTK2/S5sfZnXJvrZOGMl+7l6qMzBX4gPC1ICFrSlSKkr5C65RhjTWT14nqmczD
 guSCGPYXUIa+UObqHVNb3xdwRhOuTyA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.45 / 15.00];
	BAYES_HAM(-2.95)[99.78%];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5345D44445
X-Spamd-Bar: ---
Message-ID-Hash: AOMBQTX5IZANV36LNVRF74WSB6VRIKPA
X-Message-ID-Hash: AOMBQTX5IZANV36LNVRF74WSB6VRIKPA
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/AOMBQTX5IZANV36LNVRF74WSB6VRIKPA/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

[BCC all OP-TEE maintainers]

Hi OP-TEE maintainers & contributors,

OP-TEE version 4.11.0 is now scheduled for release on 2026-10-16. So,
now is a good time to start testing the master branch across various
platforms and report or fix any bugs.

The GitHub pull request for collecting Tested-by tags or any other
comments is https://github.com/OP-TEE/optee_os/pull/8054.

We will create the release candidate tag 4.11.0-rc1 next Friday, October 2.

You can find more information related to releases here:
https://optee.readthedocs.io/en/latest/general/releases.html

Thanks,
Jens
