Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEFCC88E5C
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 08:34:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 00FD7450A2
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789547678;
	bh=E0XqkUESiN1hlEBTC+r5MA1JM5vILVmKxSWQU9kfer0=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=HLvPh8kNoa1hoIc36CvS1iCij4cRicQM2I/++xBgMBrY17V/vX9I14JDm6aJuk0KG
	 DevS1gJHWY4AUVwIidldaOa9SwzwFuAw/EcNrhzLv2S9SzINnC39LpK9Uw1fgFnXXM
	 WzGdd+2+NDI5+Hz6K/9XrPwWwFaSYFBceWccYSJjDPG+YGit0YjdfbRAk6siihBcn+
	 8KmKhbi5ImR7ueyfzz+PuTgruVA7XRIeDw7oHbFoip/tGQK45wky0zJPhc6LnKFWBL
	 8FEIyfrunAVnsgIkNVcV1fQ/Eih/nGf0j1WUgD7nXtpbMvxnapgK22CF2G/CGTyzU+
	 ZKudAoyk4ar/g==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0214E44438
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 08:34:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CQ3FXUNS;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BlcaaFBm;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G69eOD1163471
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 08:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E0XqkUESiN1hlEBTC+r5MA1JM5vILVmKxSWQU9kfer0=; b=CQ3FXUNStXk3tAGJ
	IEmrCn0FNgUKMCV6fCW1I/mJcErQZOUiKeDOJjjjoV88mBUoS/zqj4zJ4mBrsUMh
	k95/J4WdG+f8ISMCX1BDhlGmE00A9i2tqLPT9oLppgSzcZEDtAqSvOrWZylf+kGb
	PCB4jaX8QY3hFOcKlKIoNSuTx/6Le65gkVcYmMYE9jV5fy2JRKqPXBUslKo2+RQG
	ejmCqDqF9ssBz8UzRV7sIDUtsOyjnDUZpDOo24Lv3y7zDO7d9pNU7LVzn+uIZSBZ
	Lw6cpY+COKzJnPr8Ye133XYzSXqW00S/d2Cqnng9vQEcSRgZy2SGRlrd9U4VHVk7
	xhTwbQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq9n63nn0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 08:34:29 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-6711c640f79so1727101d50.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 01:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789547664; cv=none;
        d=google.com; s=arc-20260327;
        b=QTPCTF1TvtOgChy6i+oEconZd7ew/u/rkfEWjlCvvOkoxdGqS5c9vgAToAAvQlbydF
         svCb8cCqzY/8ZwH38e2zkXDAFfYVDQGMYpXC6NGIaK619O8PmUSIpSv0eEOq4YxNrgPl
         FLnsaZtxix8KLP6OUTH/jKOPXLqJHd0+trNLSGOmccH65LYKTy/z+9nZEUxeVMWs18lq
         7JS0slvTRZBKh3woAA0pAcMulMDrOVlc2IpHsb0d/cszxTtBNkhsKjiOkWZ/DHLHk5Nd
         h8GaHmELrMGLynUI5Bum36OYhDWA68r+xG+rl7j4TwygrZLtm1kSMvBwqVeLIo44Rz83
         eH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E0XqkUESiN1hlEBTC+r5MA1JM5vILVmKxSWQU9kfer0=;
        fh=PNc5ndpiny5NK3oEjiyGU8YH7uPE14jrCJfk/se8/gY=;
        b=kAv1+ZEk3xtm3jOHC9d2ejiOfX3WPHAjMXGIsWqgnXqs3RZ59Zd65SeHDI1GpMLgUY
         eSJVk9jgFVqOB+0ll0YKpt7x7PEFniCNl7uIQvfabRlLU+8MswRLmU34G9lcJeY/IYHt
         QU7EVwaZ4ARegCbrqofF6NRAbAUBQ2SU3Aud/RBBd4x6RA1asgKPTVMto3p1flhubaYZ
         FUL5yyHseHIi0/FY4/5sEqScYhaVP6HnwZGOdmrOk8UtmhF865r4vtq46yl3Vnv6Fqsv
         dfgx/aQ0KJBRcVFIk2a/CTWqwNrFMH2G+PkPaFA49N5d3kR3mN7Ixv1jf2S2XCbuSRws
         8Bpw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789547664; x=1790152464; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E0XqkUESiN1hlEBTC+r5MA1JM5vILVmKxSWQU9kfer0=;
        b=BlcaaFBmBKsObrBDhZpxIbU0Msxa2aWM7fqLNtpUN7Ptk9uoVDvhm4aV9OYf7MDNel
         ST9WG9PdD1hExUMScpS9jfmyLtoIFlssFDGYS+aX04sYuwmw/5dsKwWUszS+ZGJZvor5
         l91ZA8NBwtx+T8WAtCO3VjCzMBwpqi2g3iYaA8rz5znyOR/xwwFCOLW7poTTo/e+TaRR
         +iHbDwc9D3bVeX8FuH9uHNbrfcLqZ+MmmmVEnK3qhRQzsYse1MrFg3MqqVKXyMROX/U1
         8BzA9VQqFeKk4PaTYfeh/2DjaJoddEQFlADbvTq41wujswNluG1S3M5KT3grrR0agEu/
         tHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789547664; x=1790152464;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E0XqkUESiN1hlEBTC+r5MA1JM5vILVmKxSWQU9kfer0=;
        b=EwmTHmOhfJo9PUtYeH7WuJ5idFDYO+RFg4iZCqIOEAjdALpBiWlIQRYxkC/E3nliHx
         YAV+D/o0wrmlZDRY3UtKSjUmfoLSC/pjsFWB/tJLRFFWfvcT/E7aAn536QlG6EqTtwHo
         NUrarNoGx8jS4/tas69BGqgIUGFJotqL/FLHeOjBtbS5wvyQpYF2ZdM6mUTk/HSk+2c2
         2ejXgNHR5JsS6GqHmWSH2VR7br0bx+0XmTSGlz77UbJBQtrFGKqzbV5sJFsQnVdaaH9B
         n+8C/RM7BIWrr286m4tvSkfOeDU4ZgOhDWLuiwP7Zdpc8Oim3xifvPYKzRyAG2K9zD+G
         dkOw==
X-Forwarded-Encrypted: i=1; AKwUvBw5+hf+DvrjO8e8C2IPHwZPaKg5V4PzXiOOOKYGU2puAqwDPnQpkzaxCxsKH65WtbM/xbLzIMg=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++n6hQAcQoffZNSU/Wk2JfAZL/DNX+9ngPmdyN7H97bPnn3G90DG
	19tAy3mtL4zV61F/dvdDpg8Se3uDYTgiWdGuMyD3u+0+Ht85xkdaZFwArfgdw2UHpvlmsu5ySur
	uDR4ouUOFnnYs9PwkdWPS0ibzduGY6uNk6+escYetNiQUVzzPRlxLym3ZDFm90FTeKJ/l9zRrye
	5lIF730eFvDcvHjBr0AL6FIYUfcKgNiKk1Nr9wxprXgKgW6yo=
X-Gm-Gg: AYBFou1AI30mqLelMJ6LXcMg7dM6K0hatWL/776fbzjxo+eSRZkJ0ttuvfxMOpF7nMj
	0I2uP3WMm3mrxXngBJA4qMVQvM/JC9My05MEZVQIiHb7PyIlWtgxTXY2cj3ZAXP9YyemnpbZFOt
	CCH0BllZ0ZMSJNY21NUFxQf03Ae6J5JqxH2EScldPH6/yNI/kFN2bCwUY=
X-Received: by 2002:a05:690e:d0b:b0:671:4b50:d72 with SMTP id 956f58d0204a3-67154f5116emr1586696d50.7.1789547663912;
        Wed, 16 Sep 2026 01:34:23 -0700 (PDT)
X-Received: by 2002:a05:690e:d0b:b0:671:4b50:d72 with SMTP id
 956f58d0204a3-67154f5116emr1586688d50.7.1789547663523; Wed, 16 Sep 2026
 01:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260903175730.1909952-1-afd@ti.com> <aqJ0yCHd03ZLsSMT@sumit-xelite>
In-Reply-To: <aqJ0yCHd03ZLsSMT@sumit-xelite>
Date: Wed, 16 Sep 2026 10:34:12 +0200
X-Gm-Features: AcwNN1UYhdhLkRJRl0-6L6I-0s392VyUVtYk5_XpwRYYKG_lQZfM1sxUpE9LJ04
Message-ID: <CAGgiveVZurBzh++FrDvoxe4Cq2OBZD=r7A3k_i7_atCyVjzsXQ@mail.gmail.com>
Subject: Re: [PATCH] tee: move tee_ioctl_shm_register_data to above IOCTL definition
To: Sumit Garg <sumit.garg@kernel.org>, Andrew Davis <afd@ti.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BdVNQbt2 c=1 sm=1 tr=0 ts=6aaa5495 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=b45o4kL6AAAA:8 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8
 a=pYuakFrei0FEQ6tmCC8A:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=dhdsR-PFWuPJUldTnwXm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExMSBTYWx0ZWRfX7WqT5SnktM5z
 oZnoiyp+efaPOA7fzKEUwFlcFobDOc/gqlmIMsYvOe1zVndQS1iL2yISepYBfjcWcYB2aMraUY/
 QpMQoLwHK5JLGFQ8EhdaMxbXAyNv1wYOeukX8Q6EU1BGmGs4aIZo74yxqm26NJgqDsTOh5eUiH1
 8ERZOaW4ZR3b5CCWC/HnCEkrXMCiKBCPuAZvFsORqui9sVceaLzbslaCaHH0VwpV7hqTM7OpQWs
 HT9yOSKskiIOcolPunCXW7N9+EUqGY1we4ktB3r7zeBv+fn/xD4mwT3eXm7sPcAdzcvWjWXnxBn
 Sog5Z4jA/rzFiX8sp+9w0Tz705nZl1NO5YEEFyPW4THMFPLla6obNQn9QHFe+JuNKxk4qQsuJWG
 y9mHRUXh6Psar0k8v0DSDclYScjjGCCcLIGCgStZgHye5kqjCEekYbBfICL+xNd3etnlfMmVzaN
 ow0Ib734N1vl3DJcWQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExMSBTYWx0ZWRfX88j+e4MgTxIw
 ibx+nQ3C9hJuEcdd0BPU9dipocluJaFvSdbNrNudlTZD20HEU0W7qDP5kKklqNJ9n3G9JRWax+o
 Oozc8+AHmNnX6ldrnf2OsLe9UNZujmA=
X-Proofpoint-GUID: J74xuOeB-h9D2PaNzoOhB0QjUt1YNqtj
X-Proofpoint-ORIG-GUID: J74xuOeB-h9D2PaNzoOhB0QjUt1YNqtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0214E44438
X-Spamd-Bar: -------
Message-ID-Hash: NL2OKK5BFMG3RW3QEE5FKYELNVNCUCJR
X-Message-ID-Hash: NL2OKK5BFMG3RW3QEE5FKYELNVNCUCJR
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NL2OKK5BFMG3RW3QEE5FKYELNVNCUCJR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

On Fri, Sep 11, 2026 at 9:40=E2=80=AFAM Sumit Garg via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> On Thu, 03 Sep 2026 at 12:57:30 -0500, Andrew Davis via OP-TEE wrote:
> >Most of the struct definitions for a given IOCTL definition immediately
> >preceded that definition. The struct tee_ioctl_shm_register_data is an
> >exception as it is placed above the TEE_IOC_SHM_REGISTER_FD definition,
> >not the TEE_IOC_SHM_REGISTER one it is to be used with. Move it down
> >to match the others.
> >
> >This is a non-functional change for consistency and to help prevent
> >someone from accidentally using the wrong struct with the wrong IOCTL
> >based on the struct's location.
> >
> >Fix a couple small spelling issues while here.
> >
> >Signed-off-by: Andrew Davis <afd@ti.com>
> >---
> > include/uapi/linux/tee.h | 40 ++++++++++++++++++++--------------------
> > 1 file changed, 20 insertions(+), 20 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking this up.

Thanks,
Jens
