Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C71ED3B7EA
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 06:15:06 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 48EF15000D
	for <op-tee@archiver.kernel.org>; Tue,  9 Dec 2025 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1765260905;
	bh=Ra1kkxPZGUg1nj/Qm95DTcqtCdno7uolEtbYS9mhA6U=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=PK1MJTazWiKVTEoE4L13znio4RD6YlsOBZd0u4ETYhll96+8hT3l3O5oS2yN26W2z
	 p6AItmlnKb224Og2e5so+K3/Gi1oCCn9gZ1nFqLoSbwN+WRly13YfRXr9C3NcXtSIx
	 9JiFAUA4GnxE3FIxUYHg73Vb0FKS+lLARnHRoIVpvpgigAZn8QrmGeVsrZJtLj3LR0
	 F0quEYpZlAN5PG2/bz20G1YYJmGFCwFuWU3kAhXsjuMY6CYYViMBb8pwzK+XkKwyXt
	 gvpukrGgc9RQkcw/2NYUZ03GAuWP8KguPpTN0H4NqGlInHMhhSx1V09xWOq8lKiTyW
	 5HSNB6GVfM1mA==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8E2A54FFA0
	for <op-tee@lists.trustedfirmware.org>; Tue,  9 Dec 2025 06:14:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mQkQ0nuQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XZch9RvH;
	dkim-atps=neutral
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B8NXCxM2429298
	for <op-tee@lists.trustedfirmware.org>; Tue, 9 Dec 2025 06:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=UkwMu2h+JDrof30oT5fIBjOd
	uif3Xp33tej386FLTY4=; b=mQkQ0nuQXk6y86ctsyW8kO3fwsBcHn2DySs2cZ9e
	XRgSILFoqLudLgsvwJsNQKUN8sjCH30vzZWNR6VzXfVFG42e4mwBQSWF/7QP6GsR
	TPT1BQ8wj58fdXmeaxP86I5XIQyEBkZR+XxsgJMyweRYmuyzmWX5AIigf5MEe2mS
	23xcBz3UZBNpnlF/tPu57EdUkvWOoGekCUnz+FXfhvKmWwfpoLsTzSCSDQMk7ldV
	CB/7YxwlZobISAQxE1K1XJF7/u9H1KjC/sLz3KKQw5i9ldqA0uEtxlh4YOM4pT6y
	2gLKHiEpMjlWtdGMuLmDUbH9y4/D4Fd8f078YVPJnKA5Bg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ax2rf1x5u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 09 Dec 2025 06:14:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34a1bca4c23so3145598a91.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Dec 2025 22:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765260891; x=1765865691; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UkwMu2h+JDrof30oT5fIBjOduif3Xp33tej386FLTY4=;
        b=XZch9RvHbAjMMRaTlMKzYUry/AA3btNX+4Hl6y/IJgebDW463FY5Erg31qBBhAZswi
         GlPQSsd5T+pZJVLNdYy4gy7fqAzZ+OjZ0qtIVT0NZxJAqYwhJopSQOUnWfuZaIjMmhKK
         4Ozuu+RSATp+nqaFUKyALNGSBAhNtlJrG7EXSmI7TKaLqXtG5/31Abl07TyW6HplooZL
         wEnAw9oIkSzOfieEdVdYHXjfPkblZwNdiVKi068lpueh4e4UbbOp7bsBo/PI55V1IdIA
         3M93gutgfU+6iTDxU2MH+WAhj+wUO82MpLGu8L35poXNLWXxyXrB9IKjv48JVadHeY4S
         7ypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765260891; x=1765865691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkwMu2h+JDrof30oT5fIBjOduif3Xp33tej386FLTY4=;
        b=RUieQLgz4v6Cgc1yXQkM/6ZuYkLjoqqTmCFQ0qeyrqe4P8SP5Tiu0GrAigfDgBsaTQ
         5rLtevMANX5iqffkyXPcQU3qu8pg9brPt9dUSQXs/so7k9HvCtdXdrGdACHyLtks0GPw
         xH0VaM5XB3PotbHy4/VFjv1DuOjn1n5hSMEcm6gyM9xkcGuTtbZMflTvwXb+3AkGXv4a
         xiPLsvJO5gl4W3E2bbs1x3em0RW7GicP734uAx7nobJyTFA8KEdwUnulqHDeLsVTdxz3
         sVmWFZhEoc4eCx35RWZl9vUm1wxwLVVXzn52U8M/jiphBFKBLaLa3+g4w9aZlg89k/MF
         0X9g==
X-Forwarded-Encrypted: i=1; AJvYcCXXjxpTZpycdH8klwToyjclpyo9CDMNhs97ROL/1Z3wLKYuvrnqPymv9zzSg/b89AnAZA6gtVM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxWxyJwE6YbJQcQNDMfWuepRuTS2SwMYWBlpC+KQ/jT8ejr/scA
	0I/7yBgKyaFEKxu3fnh44CE5Aff2aYweVqeXUKjS9+2yQX/ZNTR2daZi2AMxyht1TBuA3tk8AR/
	LJgmp8xTCjK9MJoVwWpT5OvTuvqDPcd+qOufuIGIWUgLXibg2nJzSgnFqePPboxlhXq+WnbuaqV
	q74janCIQ8L4BRVLQTN4CPC5MEBM4DFUZhbLYrzu+gGS30aWA=
X-Gm-Gg: ASbGncuhZqIIWoM/VtMoC5766s3dGmVK+rMD5stmUT7r5iFDi7n3dQiDmxiibwEq6z5
	sn7N2FL6OHqNVHdmITfd9mOdDXr+KdVgiROSK56m0cKJm/onRFWkkTdmORP8b/UDT37ufDabSa/
	uG6PJQqk2uVONQ9loFwS8CmHaBLTyNDGCdghDjACvXK9kx3bSAOBzvwWkBh6gY+12s3AYPyGx7v
	2iOY39J
X-Received: by 2002:a17:90b:3f0e:b0:341:88c9:aefb with SMTP id 98e67ed59e1d1-349a24eaa24mr6765554a91.5.1765260890860;
        Mon, 08 Dec 2025 22:14:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9QHsibl2WQxyNQsrDJcMm9aaAoNPvWH8Um/bBO0MU37tAWZvReqyGm3xg4Dh+RpvOmcRw/jPjTE3OZUk6BMo=
X-Received: by 2002:a17:90b:3f0e:b0:341:88c9:aefb with SMTP id
 98e67ed59e1d1-349a24eaa24mr6765542a91.5.1765260890254; Mon, 08 Dec 2025
 22:14:50 -0800 (PST)
MIME-Version: 1.0
References: <20251208-qcom_qcomtee_defconfig-v3-1-b50dcf8ab45e@oss.qualcomm.com>
 <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
In-Reply-To: <309e0391-58a3-466b-a113-ab864188f6fe@kernel.org>
Date: Tue, 9 Dec 2025 08:14:38 +0200
X-Gm-Features: AQt7F2rNz1DR9kXHfOdQeO8rgxj4CqlCKSbtX9ALadbBSiE_Ifiam6qIPJ7EDPw
Message-ID: <CAO9ioeVL2bJenpb_Wqb_iDiNOkxej64qHXyy1ramRWY8voE+Wg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable QCOMTEE on Qualcomm SM8650+
To: Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Authority-Analysis: v=2.4 cv=ee0wvrEH c=1 sm=1 tr=0 ts=6937be5c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=H55rNi7blMSzm76TLE4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: CdQa8kUqsr3xm1OREhYxbJrXr0Yrmopy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA0NSBTYWx0ZWRfXwnAU2vwSyRB2
 EC3tuz1cDZnjNH84xPFntNOvZ1p1p195XBNAXM77zBt1ZXrKcnogcn11+Ui2vNt7Jd2e4K9UVmR
 C6hWKFWmXKzuKwiKle40vjLqxBvNPNC5srVR6At2Ka0psGfR1gTOEg1hRYEGONpzPu5dRPZlxSd
 Fx7x7T4rWAbJZENDNBg5L2oENEA6iIM0p85TxrpJ/tQtuWMSbG7zzYKlcOH6rVsxnQ75xx+WRbv
 07wL9GzSOoy9yfQ4AOzytiF4q7SCixo7IVfctzvecarp/C9tIwUtfBjUhUiVwsHXk1VFcuDWH0H
 rfuRygzim2/cEQhepruNaYp52lH+5KcUh4cymAGep1OEvdkixFm5c714of4sg6R4Qu2RTREq+sA
 FqPjneqtBmI+7YctC9kWScGJFhz3XQ==
X-Proofpoint-ORIG-GUID: CdQa8kUqsr3xm1OREhYxbJrXr0Yrmopy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090045
X-Spamd-Bar: --
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8E2A54FFA0
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.216.72:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
Message-ID-Hash: NJSVJXDPNSAXUBF3NVIYIMM3LCIB64DK
X-Message-ID-Hash: NJSVJXDPNSAXUBF3NVIYIMM3LCIB64DK
X-MailFrom: dmitry.baryshkov@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Harshal Dev <harshal.dev@oss.qualcomm.com>, Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Konrad Dybcio <konradybcio@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NJSVJXDPNSAXUBF3NVIYIMM3LCIB64DK/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Dmitry Baryshkov via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

On Tue, 9 Dec 2025 at 07:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/12/2025 13:18, Harshal Dev wrote:
> > Enable QCOMTEE driver on Qualcomm SM8650+ SoCs to facilitate communication
> > with the Qualcomm Trusted Execution Environment (QTEE).
> > (No enablement required in DTS files since QCOMTEE device is dynamically
> > registered by the QCOM_SCM firmware driver)
> >
> > Signed-off-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
> > ---
> > Changes in v3:
> > - Updated the commit message to reflect the supported Qualcomm platforms.
> > - Link to v2: https://lore.kernel.org/r/20251205-qcom_qcomtee_defconfig-v2-1-c92560b0346e@qti.qualcomm.com
> >
>
> I gave you the exact example to follow. Maybe it is not that important
> for others, so I will not object, but OTOH it is important for me, thus
> I will not give reviewed by. I damn asked VERY CLEARLY:
>
> "Just mention which UPSTREAM boards (which you called Qualcomm
> platforms) use this driver."

+1 Here. Defconfig changes mention devices, not SoC families.

>
> Usage of something on SoC is not a proof that it actually is used by
> upstream platforms and we absolutely do not care at all about downstream
> users. I spent way too much time on this and even very specific
> instructions were not working, so I don't know how else I can help.
>
> Best regards,
> Krzysztof



-- 
With best wishes
Dmitry
