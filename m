Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB97C43458
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 08:06:14 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7746D45047
	for <op-tee@archiver.kernel.org>; Fri, 10 Jul 2026 08:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1783670773;
	bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=s7IOAp3yIylyUDp0YKm8Qy7OaTzK9M3/YvwUEjRYtLTmrClXl0EkGC5rmfrNA+TxT
	 WOCrwSBzQerFXPF1mwlqw0AC9UK/6oaWfOsbhiCFi7KoD4CgGW94d412Ers48pkI3G
	 GTL3vk8VqC0IGCj4aeBpX9fxTqZYj6iZeKJ0cra2tSiKBJkxFUhkguQIxbEHcGrMCT
	 4dvrIu1w16JZ9NR2Ibuh2QI7XSdiZIw1ow8k10P3n59hXBrwOFTEeeaO3v3c0jTb8a
	 WiZHjWcoNESuA6PEg42KurRPORE0mnhVeKgZ30apo8vBVgPhB0rlh3TCqg2SR4Xcmk
	 cixQEMxzdAToQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8635E44B0C
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 08:06:06 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YeKF3eBY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ifbv+OOf;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dSsW4156484
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 08:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=; b=YeKF3eBY7YssdI5B
	/CNfbsjB3WeZZD+/j0hsm7M+BolNZGpNt8sFiZ1fxzS07wNM0fQsrgxCw5ozLsqP
	4nV0wSnGGjCvNTew1rYYpYpei9CkONTrO4qUP19uW6IF0ga0jOStVAigRgefukaE
	hmZGqAcJuwMQnRm2B4wwuNE3bPZfloEvISlHxEyVjQ8xUjvRkJd2MWf5nunb6432
	Q/FWQpqMKbVkHZkoHqmkv/fA0kw1GYQpZQxBd87vi7V8+yvDS3pBoX6h8uLCPjsv
	2CTY8BfzoycHKevmZLFdL5p17fa9U846DR28eHJNfu/dbJyesvdnHP9zFR3x4TGt
	nsdMbw==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8ja8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 08:06:04 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7f5b54da461so11147327b3.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 10 Jul 2026 01:06:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783670764; cv=none;
        d=google.com; s=arc-20260327;
        b=d3n5xGPT7wzfleVT0cIGmLgSwlgDV/uOMOnMBs/Z/w86J9jGy7WDOm4uaeaHQ7tsS+
         iNVwQVYROcbvxKxOiekgxSpAoK3szm9KjvE7vSyUCYCEIhV0M4a7oYnoatq2jsjTpjtW
         b4OIWc4t9BqSSp9KOgMusAjlSDo6wZQh0Cdt8td3qAwtEQf3Tshdc0xOtRuwKujuMvMF
         qgAqI5KhgTF12KjrxJ3L4HqE/vg11+GwStWVIe9wSpVfu/eJEEzbZeshxZoAQJVg2dWv
         lzz64Uwpj3NeuwwVeiwrMhUQRs10kSIVHIla+9SzUFX6uEKhpPuMiA3Ymqh354yRiJTO
         bsYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
        fh=iqrcIojIlr9MPuTOm2HMqthp2y3TvkApuhcphYtICqc=;
        b=GqoUn9tmjTTHO18ZOwMGtE/cEGapPBRG9i74pSJr8V49EzUiaLCOrb3zGHuAGVqjYI
         kcjgi+rlRMcJI0HbAhVc/F8xPGea+vGHLFqRa3BxH6Jf3O758qtvJjAtycIk9+ONYa3s
         uVt0FFI1eMyEPl5uKk845MSj8h/eBIo/eQlmdaNZeqML/5VKE+AxLtKAehlQ+X16ncDm
         5/X4RXesAXp8XVkBfZGUekmeSFTk+mEn1imrnv/d/LfAVVnX0IdVMRsDYiB0XiI3pCoR
         yH6UTmNnAYvoQhufp7BiVIGAkryRkRlzFoo7p41omaAsnrB0SDAOH0dgPFeVbHB6BNLB
         Xw5w==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783670764; x=1784275564; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
        b=Ifbv+OOfyWLgqs8TMrmVWCP9g9O6aahX6ewMxLZSL+J4ie46YS0AtfBW9GA8S4lW+V
         CRs0rs2hd0hgqp9DIkvVHbpXOtgpoqmhzTrpwJo9POjCywqb6LkokQal3p/dnjfXpvgd
         SRxBYsl1uUyBKgKFOjYvRGtqMgtEpT7fKeErb2jcL3SVeQLpdDswp8UGY2SPTbtB6AfT
         8tNdPp2a4qcW0aHm1mcbVpHMBY9DY07DE7pH+G/HZlXBLWzQAEhwsqdnHsOZ6zMbxZN/
         XVMxLeGwphVHo+kx2Zq0YvWjAMco7ELN9j3h0j0RX7nIUkHQWfTm3T0i0eKLXxXUii/F
         TQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783670764; x=1784275564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rYdv04oG7QSSqQZeIDnFcGqjfR8SCbXpzGryBIgOyyw=;
        b=NzhmOQWq3tWjGUjGQh71WtrS1Cp/2c7fN6sZR5T3zHcdk7xXAZletYPmCT64xs/rzc
         JR1QxBqjetpCVP573mGdDtCfXlsFkgvoPokoRlJDHnb6Fx9LPm/i1uGEtBS0+RJYCODP
         ys0tFKbc6OIuef7jrdSE2p1uherfC5nOepoEcgaFfjlf9ynEfEhsthovotJypiYGY7Zm
         mCj/gSqmYQv7a7A/Aq2rv1Vb2sl2aIAXvfma7Q9caBoiZfIh2ijkx3HVt9Wm6RhA5YDU
         fxQgZH/n3lWdbOV8NJgI9s430wA/2e+GU77sb666rBHaNg81klmNO9B7tZn2RfjNvDSP
         FNQA==
X-Forwarded-Encrypted: i=1; AHgh+RobD3eSiBdd9BmAxxWofFnkbbHZWiwZ03x+a+0HjD4O3z3RD5xijcPJ3gMFRUCEUz62uJKtp1k=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxPvbso1KD+vYQ71jyvKdBy5IipYYmaH33pdYqXFnXWRVhb9UuV
	2zN3z9uAOLWwzhmtg/1EWmgfNNNKudUhF9Luh6XOQ+/3AiGvLREkFic9r6/RRLNfEw68MDhMd9z
	LskdXeysGtqBk/6lDUoFf4pDHtu/ACmnO1yO7b0/FJJxmjO2Tei7SwpoCKFy+26t4FkfzSFGPyW
	Yz90sRoEy/Zoit9TTLAKfeYEe3xDQ/NhA18KrLtvY0Hklcz1M=
X-Gm-Gg: AfdE7clAQNVzU3ECyJRWw8y05/zHjRtCkrpMTgJentqaMCdHHxci0gzDaCe33ttG4Vm
	PZbFPUJmK14y6/DSX1WyoN5q+F4herI0V1FCvMauRBDEx1fufTag0nO8AHQOjXC3Gs7uRQKUL9k
	fXu0da4Ty/agGSula34h6Pk6HW2OaRW9WPRQ8eQmwoMKZ5Z/IhSrxmdP3KyQr/1/fA0w==
X-Received: by 2002:a05:690c:7:b0:81d:5b4c:f8ba with SMTP id 00721157ae682-81dc11f3df5mr81106737b3.61.1783670763738;
        Fri, 10 Jul 2026 01:06:03 -0700 (PDT)
X-Received: by 2002:a05:690c:7:b0:81d:5b4c:f8ba with SMTP id
 00721157ae682-81dc11f3df5mr81106587b3.61.1783670763343; Fri, 10 Jul 2026
 01:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de> <CAC_iWj+xDErhPeKGtsLK=nvPB7P8cQE3g9XCkaWf-d_j85FxCQ@mail.gmail.com>
 <20260710073147.XJAJbIwc@linutronix.de> <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
In-Reply-To: <CAC_iWjLO3CAAFXE3s15Xcy3pWFK3ge5sWYmHHRBtcccKM2e1hw@mail.gmail.com>
Date: Fri, 10 Jul 2026 10:05:52 +0200
X-Gm-Features: AUfX_mwICOJc44DowSC3LE5i066PLHBu7IpKzk3cTcYCH17D6Iz-aAH1CV8bv30
Message-ID: <CAGgiveXyOGFY=gyn3ok0p7wtjP_1oY6Q9Jqa6fCYXrwRoNQ=tg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: K0ogp0YpKQIqmveuU_egDNFa4kMRdK1J
X-Proofpoint-ORIG-GUID: K0ogp0YpKQIqmveuU_egDNFa4kMRdK1J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NyBTYWx0ZWRfX0KN9b9mjgZCw
 qFKmaOvj/lEExvClawN9U2KDjjDRqqBrzAhFWWDBQt6Eme2PAixtqbyrJHHX1TQYB58L6eu2fQU
 ctuXnJiGyuIbuWCNk0u9+s/6iHYP/QI=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a50a7ec cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=UXIAUNObAAAA:8 a=7CQSdrXTAAAA:8
 a=KKAkSRfTAAAA:8 a=bCoxK1dQaO2rIu0SeVsA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22 a=a1s67YnXd6TbAZZNj1wK:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NyBTYWx0ZWRfX6FEP6rTYLEy5
 MylIJm4lzFlk6je3QoIeUsZsqMYgf4SQkA0FoTuvN8DrHuVYdSzIDWOAnIirlXC9xCYW3+nmZcl
 1T2Co5KogYTYct4F2HpoOgzHyYd0i+VYpJp3Udng9ScnJNQRJLXJhqpX86Y0JvQ7By8/l1sfTDh
 2FPnyWZqSq1Zyjo2NHsTLmgnscNjy8fVe4hqoJMy600xPPNXgwJ+r/0A1jtyuAWogJj5PynCpZz
 N5tC/aQA7cvdZGoE/S+HXcoCRBBlzwlOBciORDU8c2hOMJjkBttznZ8arNYGh+U02CgNS6OGkHC
 d7/UkoXQaLtZlW7PCH1wbhlyDd7Xljz3ngKuxHeoMXpCX5w0LN2p/ozIiRnfQR3633PJa0rCy+w
 nD8JqGw9EO5iuHgEUKssKaD0FqQxobYwsZU7KtnPDh5XbgZKIQantor2C9nDRfnMZqc8yqgjxFS
 yWvVUsVjVCEakqyFvlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8635E44B0C
X-Spamd-Bar: ----
Message-ID-Hash: 7SO3N3VJQSLZUMYJG7BDUVXJ2CUS3QDD
X-Message-ID-Hash: 7SO3N3VJQSLZUMYJG7BDUVXJ2CUS3QDD
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "jenswi@kernel.org" <jenswi@kernel.org>, linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7SO3N3VJQSLZUMYJG7BDUVXJ2CUS3QDD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Fri, Jul 10, 2026 at 9:53=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 10 Jul 2026 at 10:31, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-07-10 09:29:55 [+0300], Ilias Apalodimas wrote:
> > > Hi Sebastian!
> > Hi Ilias,
> >
> > > > +++ b/Documentation/core-api/real-time/hardware.rst
> > > > @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.
> > >
> > > [...]
> > >
> > > > +
> > > > +OP-TEE (ARM)
> > > > +~~~~~~~~~~~~
> > >
> > > That's RISC-V as well nowadays
> >
> > I did not find much here. Their architecture isn't the same as on ARM i=
s
> > it? But the overall concept is the same, right?
>
> I haven't checked the IRQ vectors on risc-v, but I assume they have a
> similar logic since that's an OP-TEE design decision not a per
> architecture one.
>
> >
> > > > +
> > > > +OP=E2=80=91TEE uses a global serialization mechanism (the "big loc=
k"), ensuring that on
> > > > +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91w=
orld code at a time.
> > > > +
> > > > +Execution flows from the normal world (Linux) into the secure worl=
d (OP=E2=80=91TEE)
> > > > +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot=
 disable or mask each
> > > > +other=E2=80=99s interrupts because both run at EL1 in different se=
curity states.
> > >
> > > That's not always true. It depends on a combination of OP-TEE and TF-=
A
> > > configs iirc.
> > > The most common though is that IRQs and FIQs are directly delivered t=
o
> > > S-EL1, in which case OP-TEE can mask IRQs.
> > > There's also a difference between GICv2 and GICv3 in the way
> > > interrupts are delivered.
> >
> > You are saying that OP-TEE can mask Linux' interrupts or if OP-TEE
> > instructs TF-A to do so (via config)?
>
> OP-TEE can mask Linux IRQs

You can find more about interrupts in OP-TEE here
https://optee.readthedocs.io/en/latest/architecture/core.html#interrupt-han=
dling

>
> >
> > > > +
> > > > +Architecturally, the secure monitor can mask or reroute normal=E2=
=80=91world interrupts
> > > > +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=
=E2=80=91A implementation, it
> > > > +does not do this for the duration of secure calls. Normal=E2=80=91=
world interrupts
> > > > +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=
=E2=80=91TEE via EL3 and
> > > > +return control to Linux.
> > >
> > > The 'sane' case is indeed where IRQs are delivered to OP-TEE which
> > > exits back to Linux immediately.
> > >
> > > > +
> > > > +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC rou=
tes a device's
> > > > +interrupt as secure. Such a secure FIQ will preempt Linux immediat=
ely, trap
> > > > +into EL3, and transfer control to OP=E2=80=91TEE's secure interrup=
t handler. Linux
> > > > +cannot mask or preempt this. Secure FIQ handlers must therefore be=
 extremely
> > > > +short to avoid introducing noticeable latency.
> > >
> > > There are also 'fast SMCs', which run with IRQs disabled for their
> > > entire duration.
> >
> > can their be distinguished somehow from normal SMC invocations or is
> > just a consequence that the secure monitor does not enable interrupts
> > during transition for some of the "functions"?
>
> They can be identified. There's a function identifier defined in the
> SMC calling conventions doc [0].
> Bit 31 is always 1 for fast calls and 0 for yielding.

This is a calling convention and is not controlled by hardware. There
are exceptions for the FF-A SMCs, for instance.

Cheers,
Jens

>
> >
> > > > +
> > > > +The transition from normal world -> secure monitor -> OP=E2=80=91T=
EE and back introduces
> > > > +additional latency due to world switching and context save/ restor=
e. This
> > > > +overhead is typically a few microseconds and usually remains in th=
e noise
> > > > +floor.
> > >
> > > That's correct.
> > >
> > > > +
> > > > +If the secure monitor masks normal=E2=80=91world interrupts during=
 OP=E2=80=91TEE invocations,
> > > > +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers=
, then OP=E2=80=91TEE can introduce
> > > > +measurable latency spikes.
> > > > --
> > > > 2.53.0
> > > >
> > >
> > > Overall I think this is worth documenting, but infortunately there's =
a
> > > wider range of configs and corner cases we have to describe.
> >
> > Okay.
>
> [0] https://developer.arm.com/documentation/den0028/h/?lang=3Den
>
> Cheers
> /Ilias
> >
> > > Cheers
> > > /Ilias
> >
> > Sebastian
