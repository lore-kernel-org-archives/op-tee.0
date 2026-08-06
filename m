Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885A0C56208
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 13:12:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A4530451CD
	for <op-tee@archiver.kernel.org>; Thu,  6 Aug 2026 13:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1786021964;
	bh=Zui6f0OLXqvJHEggmRTRDQbmSnFCEiav4mk5LerssQA=;
	h=Date:To:Subject:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From:Reply-To:From;
	b=AuDkgbMDhHrBHuTKRVoEHOTLp08y6e+W3nS3M1QSG9CwaW8y4E8dPAweKksWbrU/S
	 UWQ6bGswL5dqBYA/WNcCJfAoPJeIYBIoyVCWqsviYwBdLzb4Rui/xyiim5fAWBOHOl
	 dz2/kodaL2EfSFmh1PgQcWKiig/QnYHo8f6vN2qCzO6EfeCZEG9ZPGLSjq426C0c9V
	 WlTRpq5w3sq8HLfozzhUa0CuSb55uLE91b6YR+PXoVIgtD8UlJUnZt7OFuPKJNRp0S
	 0sobYiGw5W2VGykdKINYjFkw6W2h1zWIFPWs2XEy0iFhOOtYC3L6GgU4vNalA3+ziW
	 nEnNzCul9JDHQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1342C44E07
	for <op-tee@lists.trustedfirmware.org>; Thu,  6 Aug 2026 13:12:38 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hadogE9r;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AYxdcBw3;
	dkim-atps=neutral
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6769nel81578756
	for <op-tee@lists.trustedfirmware.org>; Thu, 6 Aug 2026 13:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=V1r0LtpTW3eeCBGnazGPaqNBduaWUCSFU9Jast34XZ4=; b=ha
	dogE9rKDcIYzxVUUQhU6ouWHowhFp/Pivondrew2AIgFuTVp0TQe2XLthSzyzgnW
	0dh5/Q++jskasTgJuKO+eutuOFX/8bdsGTXZ+2utRFDukNMOi5zZz99rG/Go1Q6o
	exlU9camNOW8ArCKQRc1aS88zM8hSS/QadT1G/u/+wpcC1hPDnA+M8AsF3JoZra3
	qWrlPVPDBqR2kfuiabPI2qD+ZFrHQBh9cde8EabmdY92pc1AHIDj0tPFbdNZKJJf
	bufVTeCYlR2J7cY3y6KKrTA60nIcAMfO1wHr6CQVwPLpqzpv36CaPgINONWUfJrz
	qliG0tnwg6oBC6MlqiPQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvju8japg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 06 Aug 2026 13:12:37 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0199faafso24894551cf.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 06 Aug 2026 06:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786021957; x=1786626757; darn=lists.trustedfirmware.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1r0LtpTW3eeCBGnazGPaqNBduaWUCSFU9Jast34XZ4=;
        b=AYxdcBw34cT4BwJRAKzCEwzPCSZP0+FrSApMNocufVMh7jAi8++VUeV+1hsr+bqqld
         Tc1x4MBmuM1D3bpZHwKjHIEV6ECRVqr0qA9ezKVM5ZkkKUe3Ngz/CBDp/RFXcoR34Tzc
         tMGvPueYK3ESfyimflWKWpP//Q2ZctK3PaAc/nCJHmUpbmbrSpntMLHJapjh1shUJvuZ
         U7rbfMBbqK73Hk6sDp1dA80fsniaJX8gqSEn53iDM7GfpEXDIegOGnYB8hE0XzAgsx13
         br7//zqa1t7nf/CjgBsDOilOfhxiJfzUhIHnRhow33V+cdsLSEBVaWokjGxv8KNEgXii
         moCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786021957; x=1786626757;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1r0LtpTW3eeCBGnazGPaqNBduaWUCSFU9Jast34XZ4=;
        b=jbJY6d7+iWlX2cWh8KH38+IoH/FJJTiKOujTIi1yTsjZ/BWium1oORziNN45xB6vU3
         9ggcIBFDLj65pkwG50tWqsuJOX5uydYmP1JS9AGZWJoaQh1r554ZAxVpieIIonFGLe0i
         fvvUbuZ+hCR3ZZxyn8sqz9wKiphTFsdbn0sjXfngsXhko0Ys9RSaJ0OKfynBMI/5Lgis
         R2mJXTILm6KhtLNWMNHnBckxanI5Zo5zCuVU6LRB7gGLyYAgq/9oTbTVCTdFl/4uHL0t
         hDFXfcZSNDBTFHQ7EPG5fLA0N/FF5UYGN82jhj2/LMXsd7nwlHAK3IfylpG2GPy3MMwb
         5HjQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAiCOJlGMZ2BSLIeyB+Efxh7l8EjxGdSwHzAt/bJpMIJExH0HZw7e6Hv4FQR7UZCtK3gxlLkc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyTiEc0zBwbbVk2I8ZXHTgrDU9XorkyV3j2/AI+A4TWDVkik2jo
	+45wQu223J5BR1JznP0UMWBKudivFuxtgY+xyxQ9hQ7jO3dPguAuUxpBfEQE0jRszePgE3TlJ8v
	LMc+vU4ULSlxIpfcuLj+tifWN6k7WDkjg6BnGBF4fE/XpWbOYCd4Cc6jR6W2dG3aU1jsCw19B4/
	oH6O3V
X-Gm-Gg: AR+sD11rbN+gEs+N8+eN3lAlUhQu6xh2fTqPcBg/+Ny2SFs3LZC1KQR0GssgmfDFebV
	r5qR/tmA4z1dMTLlDRkoMYMmZLL56/V15SJThtdVf0BJ2ghvZEZucEaf6yT2/IXP+6/LriW3idc
	AYIYpnLeJEAyGiwoX4GShAmE008ADzNITbp3YBrgk3rS1ozO6UiHoFVyi5Wjxsmr/Eozop2LddS
	hU1nO2MLMzu7xlec+sbP0EXSzG02bsdr2EMshOOmNuZfCmcmxlx0aF35rgi7SwDXrKMLexAraGt
	DilZrCQA5RO3h6E/IqN+dGu2UxsdC56GlEpuEb/7OJdRFAnXsa95hHA7w+akWZyGswgY2lTL7+S
	FPfRp8Xy7XC/LkNuFkvhM7j7lqaOMz0vF5LeYY962abeI0A==
X-Received: by 2002:a05:622a:2b0b:b0:51b:eb07:28bf with SMTP id d75a77b69052e-52ce6109688mr169714271cf.22.1786021956836;
        Thu, 06 Aug 2026 06:12:36 -0700 (PDT)
X-Received: by 2002:a05:622a:2b0b:b0:51b:eb07:28bf with SMTP id d75a77b69052e-52ce6109688mr169713171cf.22.1786021956221;
        Thu, 06 Aug 2026 06:12:36 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a196af02b9sm806417a12.30.2026.08.06.06.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 06:12:34 -0700 (PDT)
Date: Thu, 6 Aug 2026 15:12:32 +0200
To: arm@kernel.org, soc@kernel.org
Subject: [GIT PULL] OP-TEE fix for v7.2
Message-ID: <20260806131232.GA673420@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Proofpoint-GUID: rlDT0m201goziM3EXsdTjHHaxE2G9DhP
X-Proofpoint-ORIG-GUID: rlDT0m201goziM3EXsdTjHHaxE2G9DhP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwNCBTYWx0ZWRfXwAtOOTwZqucV
 EworUTv7SJ7e5T73JZwT0jpi8fF+Y4tiz4tb0nxIBbTtXGGixMLMWNA7VFLemhG1O+FstKEBPYU
 Z1b1jlCyNqt+qfMlr3jiplAAQO+taKC1pOgUKCwPlkDbswdoWr2ON93NuZjou9qA4VN3t6J8g6T
 Tk1r0hU5NtkmEOznDVR+bA/rxX9EeED42ftINqY5YJPCxpnrtUn6wggVVa2LDgNrJ8q/tluTJQa
 K/Z/GznJNoSUZSlwZ1eyD/xXqbIOKEIytTaS4IKJM0SQHv1+dCpIN1lwEP5Tn949YYzvZzc5uQM
 DUMQM+spHOhvxliH+/yc/6VntTzV5kUDzOSDctcyl8IVd7JEKFRgWnOQT7JuS89N8+sh1/X5L7x
 Q1NwMaFpNjC3tpiMJKhtd/fBOYtP3HlIv7xgqb5P2fdXH334wzUbNY8jwAdibr4GVarsneYBsyp
 a+JflFm5Wnf01TcLhdA==
X-Authority-Analysis: v=2.4 cv=K5cS2SWI c=1 sm=1 tr=0 ts=6a748845 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dMv3lA6PLLkT9/uWe4YCGw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=Oq0JbnJb5wmJE1LcQasA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwNCBTYWx0ZWRfXxN+7ynh8uYZb
 VVZLpYQOpnMMMB1UfDZFgd7V7DxaWPIG3jgq92rtucQW852F75faCbVmgdLfQ0J1dGmXaU8lxfi
 bG0uvlVqwNP7RN5rKqJJr9YFzWTsxR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060104
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
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
X-Rspamd-Queue-Id: 1342C44E07
X-Spamd-Bar: -----
Message-ID-Hash: 5YWMF5YVMGDB36POUCAB3ZUP3ULMCDH2
X-Message-ID-Hash: 5YWMF5YVMGDB36POUCAB3ZUP3ULMCDH2
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5YWMF5YVMGDB36POUCAB3ZUP3ULMCDH2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hello soc maintainers,

Please pull this small OP-TEE fix for the OP-TEE drivers.

Thanks,
Jens

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git tags/optee-fix-for-v7.2

for you to fetch changes up to 650c88738ae8976f46ba71b24dd8aa311adc6fde:

  optee: ffa: Add NULL check in optee_ffa_lend_protmem (2026-06-29 08:04:45 +0200)

----------------------------------------------------------------
Add NULL check in optee_ffa_lend_protmem()

----------------------------------------------------------------
Mostafa Saleh (1):
      optee: ffa: Add NULL check in optee_ffa_lend_protmem

 drivers/tee/optee/ffa_abi.c | 3 +++
 1 file changed, 3 insertions(+)
