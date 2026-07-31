Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B22C5516D
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 08:39:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 829CB44F7B
	for <op-tee@archiver.kernel.org>; Fri, 31 Jul 2026 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1785487176;
	bh=0nzV3Au5hKldE1LyXy81nTzzO98zLS+bllEvCWCXyh0=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=QSX8aH0LLvq9+WcMkB4JpYxImi1yxPPmivnhjfBGjbDTegptq7TccSpH8sLysdIAx
	 oAHnMF2x/+2tla9cZ8uwrvRIGYTKJhKpCVLmkBXbP/XZUtjTN+GLvKfoQgyjjhnNVx
	 wAujxhcAn8JviA7TSz1AaVgWw4m3wmTaleMxc5XoUQKaENuqGZZFQhmdvx7dwifgY4
	 NhtBZg2/u1x53pjAIEv2y/AU49xlEllSkaM1LVWnHJkrUrrkeqAAv88lXgac5BofMw
	 PUvxVjPqp4XqYs0p+BjrWg6lG2/2fif2AVO+ZhPAb2l8werYuXCAJOVkX3LA2oX9SR
	 v3k+k/iKQIJQQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C7E1743F04
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 08:39:29 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y0426o5D;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WGDIS+CI;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8ZjWx3675548
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 08:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=; b=Y0426o5DtAmpV+CI
	pa9mC3woijvQAOSlCbxssCTGjzH/9SyPVjH1jOdc4ONy7HX2LtjtlCQZV+pBSORq
	BMyq/waKEb9hCO9u1nC+yzqk5caF6dVBfg39rEORc4E3d2GR1iJnWThRE1Ynue09
	5ebW5LPfCkp+baXesyO7CTvBAVuI4r+HRlj7S+l8tX42yRy3/qGBaS4hm4xnJapX
	zj+ZUOXWxFNFl6VWRYa89+uKWtPxfiYch5T65AY3hoQSRou9jxqZBw2oLajdiXPX
	nSwn4106VfDFAUzryNFM3GOgDiJR12oimHPrSoryWJ3NgQCOkmKERuam0pOUatkh
	GEvotA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frrb780dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 08:39:28 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-81e6fce9ed7so16881687b3.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 31 Jul 2026 01:39:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785487167; cv=none;
        d=google.com; s=arc-20260327;
        b=CZzcOmi845n1JCsQzXdGt4LV0CpnYjsDgzPYXq2InwGsHbl6V3CfKx1SOh82xwDVkG
         DeDeMiCsXhiwTXKby04DUG9ZzIaDHgdKwtaXhP/GIpPop1jD/nL3ozEqP8J/rju8v2h5
         ZDh9XNWSPb9te3icXH4wOOTNoP5VbGStcJy0vwk2XAW5QZj3dj9qnTUCiECyq0xPXc9V
         ScRHjQaYeGA/axA6+j/N6pQ2bEokO/7Nm3GipN9oSeqTIYalYSQA/RA1oDGJuPRm4DP7
         IqapHJP/bexTFjxSKqJdQFMpL7pG1PcdIFXheYCzM0CGfzOUvOjmizVyTpvmpHFUHmsv
         L8dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
        fh=+yMMqQgkVbdJiqjVzu3pG+/mFlol3hMnV3Njf0V8hpU=;
        b=U/37sMqODvEFLbtB9ltnaZijpqdw63mYb/EL3LMS+n1+yYWNg97w2kwQcwYCaAG//T
         Gw8aGkQ5OIFu7qORYHdJbMjhnXOM/T44XvAJIO7TZRy+Q7kaL4RMzuvPvXSbz37sPdD8
         COcfZJadMElqxkRepXTUfYZBj7lsSDd6Td4W8Pj8W9B2Q4Nw/grEdRwIdO7zGjrQCw8r
         ak81YJdQHdc2OBfPmCuDUZsxR8gJfcsTMys93rvBR6Q47i9OboMDBErkJqxQ7p4rMz/Y
         YxArD6Yj4JbEe3fOgdoib7wkP/IBojlSy4cHuVxxhJ6YTrr1WJ36ivM4tnoEdTwb+o7g
         Szsg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785487167; x=1786091967; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
        b=WGDIS+CIuptL7p48ToS63qk5XztDqNSx7ugCb0pJbokrRqIxRLaRKH9nICaqiKjx4Q
         vEpATWzbChTI1DyuzN5gSgXQWqVwJO1sgrAQ/UTJTrmhlDT1q1AIToVxaTnBcRk4FM3s
         81QoIjsxU2YCYu1irxAcMzLJWoph2xPWZdr7pXVNrDWN84S4+33Xxt6ha70RWhW5NXEX
         jbGcgHgpxnbEFdGCeqx+cm+hl3NL8gA9mxJz/8alatjfTodyNiMmvixYvMfPppHC3ya8
         PoIcKD5xADoTRsLxgfJRIYU5hN8eK2dQQua6+6QYycRt78M0dhhluRG2HayTUZSnn9+K
         qmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785487167; x=1786091967;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0aS3a1IldF5Hbms4X/oaN6dyR7C27AUylN470557Iek=;
        b=cRH8nMVXgQEuGOGEPDTeSvxB1r/eI3JzQGqk5+BtXFXbtaG1bpFEaN0kloW2coVZiX
         0/0EOf5C3pn9JyTwVv2cBHK+13gP2axXTOOucCbisoEY/bUq+r6JZJPzzmbk3k/s5AUy
         rXyFBnei1U3Q1wz10JMCYtNEA9esCsT6RsNl2nzjnDsq0ZeppEsWkLW24QHg8ACq2QD4
         V+nbO4bl2cltq3ldFv6GQIMU50T1RCjvhjdDTuk5ZPKH7Difb+tx0Kq17bo44IGVYZDx
         THa5aODt/afZrMvhWdEPodYMdXYTQGLMYPbbEqF04TlwuAos2LmXNkV3TOColsiYro8a
         xJ2w==
X-Forwarded-Encrypted: i=1; AHgh+Rpbu9LGJ1nCRYmBn6eXmwNIJKhtXjRy4TD6xsDFG/iZQpBTFMt/LZ3W65a9/eEovnjRLqVxQMg=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwV+q2yU4ExkGc6ASviRscYLSMX3UUSAZwF/w3qEm1bP9VVG3gj
	VZZcFRtRkKVbZLbsd0WEYMqHoAvN8b4oOaQO8/NPOstYin2vv/dHisDvWfY4ZUIVzLc8PIgjGR1
	DHCUwzDrS2IqJUwjqE+hYzbRvuil6Y1YQ3kT3FhdbLgq3EUBEDjxgfSU7vdNVCZEl+82TE6XGkJ
	H06XzMyZ/3KKE+lGHHGEsXmLbTmoeKWEz7cW2aN/1BuMgdpaE=
X-Gm-Gg: AR+sD11UV7Y4FjuiXVhKeuV2P6W7JJRoQ2X4UX3sFQL8mIrLQYdtKUT/48eafam1FF2
	Ve/upewv68AjFBldSVxZF+b8YRn30fRJLsj+Anpzy708zcpr2RMhYxnBFvYRIpaApIVwIPTWlPb
	b6QHzb1IWnuaIOYqunZP00I2A+AEDB+HKDgvKkQIoaubJcFnAwAAJB4pQz
X-Received: by 2002:a05:690c:7305:b0:81f:650c:98ce with SMTP id 00721157ae682-81fcba86c09mr6967497b3.31.1785487167411;
        Fri, 31 Jul 2026 01:39:27 -0700 (PDT)
X-Received: by 2002:a05:690c:7305:b0:81f:650c:98ce with SMTP id
 00721157ae682-81fcba86c09mr6967197b3.31.1785487167009; Fri, 31 Jul 2026
 01:39:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260702115835.167602-1-sumit.garg@kernel.org>
 <20260702115835.167602-10-sumit.garg@kernel.org> <alJpc3nFX9D7_8i1@baldur> <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
In-Reply-To: <CAGptzHP8EQyvx3tn-ZVWZPN6TwFec-ADvAuxEQhwQBE00Sg=Kw@mail.gmail.com>
Date: Fri, 31 Jul 2026 14:09:16 +0530
X-Gm-Features: AUfX_myayjkpJROHbmEgd6_YM-8VOlEVu55qy_zXpmBuYnmJ9VMnESXGGquBttM
Message-ID: <CAGptzHORxaftDtf9K5pCLORK0kpdfP4RGRSE9iNkm0Bf+ZqmGA@mail.gmail.com>
Subject: Re: [PATCH v9 09/14] media: qcom: Switch to generic PAS TZ APIs
To: bod@kernel.org, mchehab@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=I7hVgtgg c=1 sm=1 tr=0 ts=6a6c5f40 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=SwCItUvQPH3YegUC7JoA:9 a=QEXdDO2ut3YA:10 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfXwoEeTbzjNMib
 qzydsxBrUv0DXd8IFxHMAFm7HKcMZoowQ4h2mk4IX5W14ju9IF0z9eZmIriW5uFBLdd0d1K5yqB
 cAGCCLq2mku8YqZkCxSzNhrB+vBEPjrz8ENfROW6zFvtl85Rfa1/QCAGzxcLNaoWfX6jN1CRP6I
 qXjBlHWPnwoFO2H9PKNjuCgMDXZKJgPR5Br5N/1HM7W+55pYK/XilC11toxSxxnSWbKH09ghQih
 eZMj1nAn+idBeYDl+kcL+plXBiHYNjqf4iO8/tRMzAdGC7WMrUjhT0ndu9SYbpvvQG7ZL8y4FAg
 bWtpP5xVoB1ApR5pej5BgB/eZC9hz6eHOviT41NBW0WKWY3NfYiD04Px6aLvoIR1C/UY8Qgx+b4
 +VBPXiKiYhA/RI7aMM+MvQMrH/InS3SwsAe2idrysOe0ZVw3/9PVCmD4vI983/Np2H5oR/92ZEw
 PMa8BG8EXRqcxaXB4mw==
X-Proofpoint-GUID: 8tijAV-e7Wtr27W-lXEoAsOKxNyKuwaW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfX1iH8PQ3MQmtT
 4SA5ce7z7ZXYvBNL1fN4+y+gvaqvygRxOZbGf7i1j9XYkL5JAlE+Gq/NrD+rV2kgrkUS2dqk8Ge
 TPYb21YO9bxDSkQ6nn+S2/in6xDCySw=
X-Proofpoint-ORIG-GUID: 8tijAV-e7Wtr27W-lXEoAsOKxNyKuwaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,oss.qualcomm.com,poorly.run,linux.dev,gmail.com,somainline.org,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,qti.qualcomm.com,lists.trustedfirmware.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCPT_COUNT_TWELVE(0.00)[49];
	DNSWL_BLOCKED(0.00)[209.85.128.200:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt,netdev];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C7E1743F04
X-Spamd-Bar: ---
Message-ID-Hash: EWYU3OKZXUNPLNTEWNVVTNVHE6KZIX53
X-Message-ID-Hash: EWYU3OKZXUNPLNTEWNVVTNVHE6KZIX53
X-MailFrom: sumit.garg@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, konradybcio@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-media@vger.kernel.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, linux-remoteproc@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com, sean@poorly.run, akhilpo@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev, jesszhan0024@gmail.com, marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch, vikash.garodia@oss.qualcomm.com, elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jjohnson@kernel.org, mathieu.poirier@linaro.org, trilokkumar.soni@oss.qualcomm.com, mukesh.ojha@oss.qualcomm.com, pavan.kondeti@oss.qualcomm.com, jorge.ramirez@oss.qualcomm.com, tonyh@qti.qualcomm.com, vig
 nesh.viswanathan@oss.qualcomm.com, srinivas.kandagatla@oss.qualcomm.com, amirreza.zarrabi@oss.qualcomm.com, jenswi@kernel.org, op-tee@lists.trustedfirmware.org, apurupa@qti.qualcomm.com, skare@qti.qualcomm.com, linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EWYU3OKZXUNPLNTEWNVVTNVHE6KZIX53/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@oss.qualcomm.com>

On Tue, Jul 21, 2026 at 3:53=E2=80=AFPM Sumit Garg <sumit.garg@oss.qualcomm=
.com> wrote:
>
> Hi Bryan, Mauro,
>
> On Sat, Jul 11, 2026 at 9:36=E2=80=AFPM Bjorn Andersson <andersson@kernel=
.org> wrote:
> >
> > On Thu, Jul 02, 2026 at 05:28:25PM +0530, Sumit Garg wrote:
> > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >
> > > Switch qcom media client drivers over to generic PAS TZ APIs. Generic=
 PAS
> > > TZ service allows to support multiple TZ implementation backends like=
 QTEE
> > > based SCM PAS service, OP-TEE based PAS service and any further futur=
e TZ
> > > backend service.
> > >
> >
> > Please find an immutable branch with the dependencies for this patch at=
:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git 202607=
02115835.167602-2-sumit.garg@kernel.org
> >
> > Alternatively, if you think there will be no conflicting patches in the
> > time leading up to next merge window provide an Ack and I can pick this
> > through the qcom tree.
>
> Just a gentle reminder for this patch to be picked up as only the Qcom
> media client is left in the next branch for migration to the generic
> PAS layer.
>
> If there aren't any conflicts then please allow Bjorn to pick this
> patch since the cleanup patch dropping the old SCM APIs is blocked on
> this.
>

Gentle reminder again for ack on this patch. We don't want to keep the
legacy SCM APIs just for the media subsystem in v7.3 release.

Can we consider it as a silent ack for Bjorn to pick this patch? This
patch doesn't make any functional changes but it's just about renaming
APIs.

-Sumit

>
> >
> > Thanks,
> > Bjorn
> >
> > > Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > > Tested-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com> # Lemans
> > > Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > ---
