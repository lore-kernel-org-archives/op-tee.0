Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC97D2CE17
	for <op-tee@archiver.kernel.org>; Wed, 10 Dec 2025 03:44:15 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 1C368500C2
	for <op-tee@archiver.kernel.org>; Wed, 10 Dec 2025 03:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765338255;
	bh=MUx+1/jvGt46HWcGbZPNyZpdgzI+pGWH3BoaqeDq7Mc=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=AYKl9RvIYQEMItOP8AUCgL8Yk5AbhDf5cUcJ3dxqQh9CbfBdC4knwXFDF5dOIi9Vb
	 WLJhbiznbA/m+3JVB1XZYeowVcIDR+3+YNQidUdsea877UgBMYh6zyIu1ItpioegD9
	 Lp5vPIw0cKV3hsweMt9hreNTF31P2O9D5AtKhKlsUa4b75CnoC4jiJ4dAz2mQCaLJ7
	 jKtfA334KWSreB4bzNwbauUa7wMsAZV/YcGBNmpkg/dcMZ4WghkxW7catqAVoDEAbB
	 c2/OBGIHXQNFTBbMbbexFNPc9VTxOFJEZ3+qKG4ZKC0Ef7wA04rLfpcPLV1JBe7MhR
	 As49VUKEqxBrQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F158C46188
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 03:44:03 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H0pbfoMb;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JwXWEA6k;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BA3LVvY1391427
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 03:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MUx+1/jvGt46HWcGbZPNyZpdgzI+pGWH3BoaqeDq7Mc=; b=H0pbfoMbL4eQDxUl
	ZedbP4n4NoSImkTzKi+1/s23MlCy+0AUmEeqOxAXwsLXHw8mUa0xH+sVIqzYZzNA
	TWg+dOXq740C+QZ0KFUtXC1FGNQA46SbXEsF6d6vJY7QpFoLJoXDQXbLi9ADf4Rg
	YytZO/GOCVprsPyze17mZS3XjpAeWeY1+VSJVYuJExDf9ECbeohkBKmaqARTMfP5
	MR487SL4nHoMgJh+Lbm1aKDfNCPye9nTApKEdYI1nvBYcsH0RG0YUsT5IqO0uaWL
	clb2wwohy1+QieOD98kNFty93Ef32CNmQLMHMUoO7fKvaZ9XbqZVBoHoN23W8818
	GkDZ/w==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axpx1a3wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 10 Dec 2025 03:44:02 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78c69577f43so7818587b3.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 09 Dec 2025 19:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765338242; x=1765943042; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUx+1/jvGt46HWcGbZPNyZpdgzI+pGWH3BoaqeDq7Mc=;
        b=JwXWEA6kXQVC/qmmW2wr+lWpH5jfcYGpycFudVHo/3YaLp5hXBO8WyLTksd9EybZmE
         XE1VqKzNzVONudzK/NYQDCUJZdH2/Wc8+6hmAGhfMOvAYpyDu+rhXVU3z5P3szEYoXIR
         R1YhJLXH5cNqSfJdstYq7eqNUFZsbPcwTjRBg1J9gNty/jZJmQKepL+sdu5S3ZQr6l8T
         FonaekYjYz8P3xvqwtiiyNEDJrMFUndcbYw2FfbeI5KMwPBNIZkkN+fC1wsXdrwqZ7JL
         Tyyl1Bl2vchjLyRdQ1cDqhXJj8mr8/TdIHMMyg9Y0uvRATKDrpvY8eKIcdKKoPH13jCU
         6v4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765338242; x=1765943042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MUx+1/jvGt46HWcGbZPNyZpdgzI+pGWH3BoaqeDq7Mc=;
        b=CbLAz8m59zoUbkQ2pHSHhxXM+se53MMimo2LhilvOTJVXQfG2Dxf5BQekn94wK2nrj
         pwXwVlp8vDVArqkiWeJTz75B10QshEFmJO7kZMDfqztbO2QJBzAihHCRzn/zOfE6cM4+
         +xyFssMhsUz58xk+bdZSLYR2+YyrqPVO4vLeMNLQSY7NoizjwEEGzvQilzK/e2/RniYB
         ehLcxrVixsbkUvkeT2bfA2FDLQHHXjqwnS+IExVyWnWCWXtDEBnuiK9PHNneXByvOA/s
         km14gZkOk3+Jq4C454LcwO3uRfLXNpC5JFMEOvlekE6fTb47zUvVd+jJXvDcix288DF2
         Fh6g==
X-Forwarded-Encrypted: i=1; AJvYcCX+O6WOWLsOBvFdisKJ4APzw9cRaUXRp7frrPP0qi5+PHkP1CW22urtlZBZpMvLtuWPztXTiCg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YytD0gzkWEVxhLWLBayWy5ph4E1BMygdDXxcWrWND1O/1hKoadF
	/mkUR8gvfYyGx3WUXffoq+N83Wm+XR9kqcJqQt6A9NoAVzuzUjepuBo8vdfEJ57iXlIQpQq1IYK
	ptbxO44kSAoRaXwEuKzby0niFB5cUrDmqFq/nRNVAxQ+630RcD8lU8RntVHHGct4yLtheEl7s5m
	y5OEX/h9x0pNeLkSZz+LpEYuz6sBDgpgO+YwIMcRijCAuAVqM=
X-Gm-Gg: AY/fxX5MdYsF2w6mJKZws0ploaxoKly4FcgnwtcVFkijdKQy53MuoapjwWyTWWSqbsU
	1HO0Gr25Q2S3m3CK3QDLv3OHR1Ch5y4dqhm5zwAwdy66J9yITM1M/Jid/FNuFS1OCx7nn0nHCJi
	Ych7w5F/2a/SOntQzjVTq3XagtRSiav4QCMrAAizIXYPo66XXi5G+84oyYSvhUB4J7/FU=
X-Received: by 2002:a05:690c:886:b0:78c:2a2e:e9fa with SMTP id 00721157ae682-78c9dc427a9mr9136207b3.32.1765338241732;
        Tue, 09 Dec 2025 19:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGsigqvM0hbmZOMICDhIcgFilEkNd9IAybKWeWQBAFsWXzIsRpqe2lV4nscakJJdQKX6jLtObAfBy+ETq+KFc=
X-Received: by 2002:a05:690c:886:b0:78c:2a2e:e9fa with SMTP id
 00721157ae682-78c9dc427a9mr9136037b3.32.1765338241278; Tue, 09 Dec 2025
 19:44:01 -0800 (PST)
MIME-Version: 1.0
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org> <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
In-Reply-To: <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
Date: Tue, 9 Dec 2025 19:51:08 -0800
X-Gm-Features: AQt7F2owHmQUzl6-9rRkWs1LghxDAXu1OohTpfyX0l6ipi-kvz33wzq3SNbkRTE
Message-ID: <CADLxj5S9qup2joSDLdrrVPgtzVcf6BXkz7TDEcnSQqSWUk8dtg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: -t9i2jAQDtxLjiL4t3FPtlOld70fwZ9a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDAzMSBTYWx0ZWRfX5t+RUkKuLc8L
 eXSFn8hjmnGvELlJ0+0dWceenM0WDMGcR1x72mCT8eZ9GFUaCfIYYCKEG2/s4RfJ6Y8EwRH617B
 Oqy0fmlRVBrP+rU62O2TaW0dNyvjfRRMTZEM/QOGMyd8qGjVuItH5c5HaHVraDTACRJeKS41SSw
 K8vKZOwXwalsa0kj3P3gd9d/gO94eNk1iUaLe/8+n3yUKP/6p8ZFBAtbOtdJCkoj95Rf7xeKKHF
 jpqcYLuhiSW1HnK8bgKM9RAh1P1K0IRztVbL4pGWcV1H2RRoKYkVdC/xXas62xyQkex5ctUZvwZ
 ZwEOOgqlkMIeWO8aHIJvuTtTYzw570tDtbRNuxWJXTG1Pb7w/hYQorZhGKpieCyRjK8aYvdpn9y
 kNf0cvO5kFEOHEekqjFn3DrWZCirVg==
X-Proofpoint-GUID: -t9i2jAQDtxLjiL4t3FPtlOld70fwZ9a
X-Authority-Analysis: v=2.4 cv=Su6dKfO0 c=1 sm=1 tr=0 ts=6938ec82 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=kUgpcaQCSlcRN2eTmLkA:9 a=QEXdDO2ut3YA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100031
X-Spamd-Bar: --
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F158C46188
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.128.197:received,205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: EM3277SSPDTGFVLOGXGRGJA6QPVX2PGO
X-Message-ID-Hash: EM3277SSPDTGFVLOGXGRGJA6QPVX2PGO
X-MailFrom: bjorn.andersson@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzk@kernel.org>, Harshal Dev <harshal.dev@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EM3277SSPDTGFVLOGXGRGJA6QPVX2PGO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Bjorn Andersson via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

On Mon, Dec 8, 2025 at 10:14=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
> On Tue, 9 Dec 2025 at 07:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On 08/12/2025 13:18, Harshal Dev wrote:
> > > Enable QCOMTEE driver on Qualcomm SM8650+ SoCs to facilitate communic=
ation
> > > with the Qualcomm Trusted Execution Environment (QTEE).
> > > (No enablement required in DTS files since QCOMTEE device is dynamica=
lly
> > > registered by the QCOM_SCM firmware driver)
> > >
> > > Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> > > ---
> > > Changes in v3:
> > > - Updated the commit message to reflect the supported Qualcomm platfo=
rms.
> > > - Link to v2: https://lore.kernel.org/r/20251205-qcom_qcomtee_defconf=
ig-v2-1-c92560b0346e@qti.qualcomm.com
> > >
> >
> > I gave you the exact example to follow. Maybe it is not that important
> > for others, so I will not object, but OTOH it is important for me, thus
> > I will not give reviewed by. I damn asked VERY CLEARLY:
> >
> > "Just mention which UPSTREAM boards (which you called Qualcomm
> > platforms) use this driver."
>
> +1 Here. Defconfig changes mention devices, not SoC families.
>

I don't agree that you have to mention a specific board, if the
feature is used by all boards. But I think the commit message should
make _that_ clear.

On the contrary, the commit message says that we're enabling
CONFIG_QCOMTEE because it's used on "SM8560+". What does the plus
mean?
Also, the driver isn't enabled "on Qualcomm SM8650+", it's enabled in
the Am64 defconfig, i.e. it's enabled on all Arm64 boards - the
question that should be answered by the commit message is "why?".


PS. When you then run "git log arch/arm64/config/defconfig", the
information that enabling QCOMTEE doesn't require DeviceTree changes
is not useful.

Regards,
Bjorn

> >
> > Usage of something on SoC is not a proof that it actually is used by
> > upstream platforms and we absolutely do not care at all about downstrea=
m
> > users. I spent way too much time on this and even very specific
> > instructions were not working, so I don't know how else I can help.
> >
> > Best regards,
> > Krzysztof
>
>
>
> --
> With best wishes
> Dmitry
