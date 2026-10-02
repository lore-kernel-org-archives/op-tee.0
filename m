Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3615FCA5FDD
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 12:41:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5396D4544C
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790944911;
	bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Ncqhg8b4I321khOBBG4bk0H3TgjhCGZsgOSRWBaQqEh2EIuFMrbrRVWoi52dd6zG2
	 o4RjmfxiRc4D6aSOGx054ndzWi3nqYBO03oMtYrLwKYU5z2WAzl1mX24snLGNxwzb0
	 t7z4109qrKLV00043I+esQy6f4ti6WAOO/NmMXtXJDS7Z5Ih/DqepK23wdzNaVViK8
	 VrlFrHX2LRlQP/QnprvhPeGOKU8I51jtDB5UPcHudl/YB9fVHQXZm692Cqu2p9Wr5o
	 u5sQy0tpaWDymp03WGjUjjk7awhKBEC2oCNMn7I0mwDvnKOnEFF5yyh8Sv1AjuUxNi
	 glrqb1VSfqX9A==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C6EC144E81
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 12:41:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O3mYYKpX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z/rf+f1T;
	dkim-atps=neutral
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6929nXb91433583
	for <op-tee@lists.trustedfirmware.org>; Fri, 2 Oct 2026 12:41:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=; b=O3mYYKpXAsxABBqg
	U5I9dO9TF1exTEE6OcmhZO4qCL4JuCSlZR2Vq1f+xixjOvNlSWt3FJe2Mk/z4lw4
	ICGBunk3IUplElpmqCustFs8VuuJl6zWFMnn/CCGf9NuAk+U4NP+nOFEPextLLWF
	XNEJ+1YMVt+k/WU7svtTTZ4WUa1J8flu9MTt+kwR9HpitjFWvlVEnMxRMtFBbEZo
	i6ol4F1qpArcWZ8Wb06n238+s8bTSlM2lGXdh1CWmdXjFOF6XUFRjPp+IrwaiLGP
	c8+jhStmkQAwxnCLJyvHcgI4noZ1JLSLXAlpy9ltVsRLj3114cMfANYuXEkjTJ4b
	uHedGA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h20sh27v1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 12:41:43 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-677afa56a1cso739045d50.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 05:41:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790944903; cv=none;
        d=google.com; s=arc-20260327;
        b=pZXJ/n3cKH5Axrqfv21ed4pOiRTaq1kcPvSQynsfFTZ1RHXh6mENSAhtF07l1ZCh3d
         7zGHfT8C6rEqIl2IW60rVLswrKO7av3zYoVltXmb4ayC3igcYmKqsCKhoeKHRNkW41O3
         3Jf1na9toukCI0AL3lmNrkYhcgVHKn67aAlnZ0OuI7IxWLB0VwlE2Tr+7OQrboGTlkkX
         VnymUDnNIU+lEloLUcQEaHNXjgyNS/dxdobWUDTvXfXCFbr75vyhsEDFLJxQLRMbkXLg
         gKWDuVkdexFjs9tAVqo4tIz5g0qj1lMJjnUkiDFf1qXN4DOanQbVVzIbhcvM1HSJCRUp
         WEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
        fh=xOxVVr+Ts+DcKPdmEWJ1kM5ZVDOa94wMXoeSHnoh5xc=;
        b=bUDhQc6/j8LWWz8uqtNigaeawbyA4bm2Xjjt6ljifOZNpah0d/QIFEh54m4yEcHEVM
         5rX0u55D8WiK9UcHm1lExEGCTVrbCaO5yxS8Jjdz+57L3bTEFJE6UNCSGwfOkpW+Ptps
         e6r0LTuF6FembBQCqaYXECSWC/LRkCJA/t+4It3X8r3DBNMGjPPul6qWs+kMH/bpxobu
         BnhYY1MUWOEj88CwWpTGHD4N8Tfr4xJu4g9oZx8xt57mqpN1loKE8p0qP68C2wYptfKs
         W3a1ILsev5lUsKIADOdroA/ojfErBCcdqg0IK1iNG1ivieTZFZCFY6c5RO9chdnWXLEx
         q/MA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790944903; x=1791549703; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
        b=Z/rf+f1T5qPk+Sfna9xsTOjLJAYlIcnTMaG6XZuwVsWODITphPJw/nBP1dlqkXY4p+
         hQZBItYVzLrkH3dShQNlw/+lR6i3iFrdQ2twYaU5BPJGioi39Y2Nokj97XVdMomOcX4+
         EUjq9h7dHDJB3IjUNGeQXqFbxnHxBwSJDbbfd5iZeeAcZYl5xP9RvDmhcEMmL0fdhMUS
         4EOBgLhnurLN98Je1Ux0SDEPhplU3cR9vO+XOT/MHYDwgDsnFwX3u0T7cZ5pnry4rrwn
         XV0Zabgc8IKPG5JgLqppeRbkcTHVJybXreN8LRuEJAKX612yYVa5awAnvg9PlddfAS37
         Zfjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790944903; x=1791549703;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dRZaT0v2TmBZvF8WsGQdtfCeSyKpr6m0eRP3xCHKJKA=;
        b=iB45vEC3MSKMCNoYn9h0B9xVl//CfMKMEPdSqeGFvsxxiF1g4Pk8cZNOBIb142j8dS
         KTT6yqlqRsQ/Y/BPnlAwjwf1RnVw3teBC0NfwifWmJ/JdrsfGmq9ZW9UVzpAxwYlTdqY
         +PRYoFin2HjikJEVBw+/9rOdfqAS4dwLl2o0Mqepz3zDbS+/LY2crim4ny17k6Xhl+mO
         oo9WTUJmzrloPD8rGYTh7TI9aPYiqq1HbveuFuS9lb7qAxfrrP33eDstSXWcl8UVCv6D
         nnQ5xGsCXPhjuLK/azi2SKgAlND18ms3MIEQ0c9zL6i37lDagjo26ToOlzM0292No65W
         V4XQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxkYJ5AphkmNan43wjSOEHDHm2/C6dnozwWXZPoqor7cxjMnkgzV5LrjwIU8zloBLbQQDTqeg=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKMH1ujyOEGwXhZgJ9fCeOZ5bJomPakYbyBtxZZWEjVCidORzrV
	Qmj5cG88fmYdjBThQfoV8un7/Tnpqgm+OTJ4oqm0sOBYaCkWTKKQJulxaFDcFdwja7o+1wIEg55
	XBf7ba08S6Q7tBz+KwdbJPlhYokDscLzogZ1F3sxCNr+VYOJIRB7z3l49TjHzYrTcKJGN3pd675
	/pkZ/+jzhY/ce5BttAf5M6nSzbkL7gLcDzDRqQG12TaZhZhgQ=
X-Gm-Gg: AYBFou2DM2S7RHDzb3H0pVEKi2LUSrYVdzTRv8Jn1LVLTD1abcizn1ZFG7/dw5UPFo9
	S7volS72AMkaet+sL0jzYyCVTKdBuitQtS3TATIZ83PecQKKvmQfNyXopX3udLv9UvrU1S3JYad
	NGK364S9AOqTpw8lu9itVeYYQ6p0s2ugMp6pgXCdYb0HRlzpCloj/r/8E=
X-Received: by 2002:a53:ac94:0:b0:677:b096:dc85 with SMTP id 956f58d0204a3-677b096e313mr536122d50.2.1790944902468;
        Fri, 02 Oct 2026 05:41:42 -0700 (PDT)
X-Received: by 2002:a53:ac94:0:b0:677:b096:dc85 with SMTP id
 956f58d0204a3-677b096e313mr536113d50.2.1790944901914; Fri, 02 Oct 2026
 05:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260928143113.1700001-1-g.osokin@auroraos.dev> <ar5ZrHihBjaFKf5U@sumit-xelite>
In-Reply-To: <ar5ZrHihBjaFKf5U@sumit-xelite>
Date: Fri, 2 Oct 2026 14:41:31 +0200
X-Gm-Features: AclHuK-7c1iGj-ldS6d2v44_ZjTFL0eWnqOG7BeC3ANxyOwSZZphCREJwfZPF3o
Message-ID: <CAGgiveU894kL9YiLse+JMJgX0Ck7W_6ZQ8hfX=6KU7wFAr=WAw@mail.gmail.com>
Subject: Re: [PATCH] tee: shm: reject zero-sized allocations in tee_dyn_shm_alloc_helper()
To: Georgiy Osokin <g.osokin@auroraos.dev>, Jens Wiklander <jenswi@kernel.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfXy3YgxuqExecM
 RItVnCyOHtsR+LJJoaSwyjUZDuUiby7126jmCIxOG3EScRSYwIkQeP3LGpRc68Gnh5JW04owkC0
 HKzZm28x+/jOmjRsZn+Z9xMImlGiXzI=
X-Authority-Analysis: v=2.4 cv=IpmL47/g c=1 sm=1 tr=0 ts=6abfa687 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=HH5vDtPzAAAA:8 a=EUspDBNiAAAA:8
 a=k6Az_GHFfqOohqVTO2QA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1MCBTYWx0ZWRfX+FtpkS2BkPRA
 C6KhZBC+1bk7BxWVDK7c9MIQxLHfsmOH/EED/mKzaEc4i+de/CLT1dHvM1u9crrDpi+nfKf/167
 divmrTjIBGi0nWzeO8Nxkai+ZksfXWYN8zxnblhGuHBCni1OxAfwjQzMp0hKY5Nv+aT+W6hDmg1
 v6003Ck1wLRsIePJb1sAB9iU5pjZ2QOOHMzfSXMBSAphSnq/4ehzcbicAq94RGmixNEwPWo0t6H
 jtXLr8AyAzORJb2LOmb11K56Nhlu828k5AALI3z8g3VGG2z0V5TirjJddbFmydbhFkcZyxKNOXc
 rRpb4bGBn9zG888bSnWHoxB1MydbbuiB+PEJJWNRFhtMVZOR6oiiiwj1s7Dd7jmXCHjlXbFFPGU
 NK1OY+XYg9XZC2oLV73aOssBeerU+7hmp7e1nk/QAQO1yWtRBkQuGDP4mh/GmmmwFYkGnU1d4wI
 CNYY/AcE4/Ulf14j1ew==
X-Proofpoint-GUID: G8EpDfveqsiNDIhOq6yQeHlsGctuKHlm
X-Proofpoint-ORIG-GUID: G8EpDfveqsiNDIhOq6yQeHlsGctuKHlm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_03,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020050
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C6EC144E81
X-Spamd-Bar: -------
Message-ID-Hash: N5MJDAUJHLXXXHLKE3IKOGICZBWRBKQJ
X-Message-ID-Hash: N5MJDAUJHLXXXHLKE3IKOGICZBWRBKQJ
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/N5MJDAUJHLXXXHLKE3IKOGICZBWRBKQJ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Thu, Oct 1, 2026 at 3:01=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Mon, 28 Sep 2026 at 17:31:13 +0300, Georgiy Osokin wrote:
> >tee_dyn_shm_alloc_helper() derives nr_pages from a caller-supplied size
> >and passes it to alloc_pages_exact() without checking it. For size =3D=
=3D 0
> >nr_pages is 0, and alloc_pages_exact(0) calls get_order(0), which is
> >documented as undefined and returns BITS_PER_LONG - PAGE_SHIFT. The page
> >allocator then trips its order > MAX_PAGE_ORDER warning and fails the
> >allocation; on a panic_on_warn kernel that ends the boot.
> >
> >This can be triggered by TEE_IOC_SHM_ALLOC with struct
> >tee_ioctl_shm_alloc_data where size is 0.
> >
> >Reject a zero page count, as register_shm_helper() already does for the
> >register path.
> >
> >Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
> >Cc: stable@vger.kernel.org
> >Cc: lvc-project@linuxtesting.org
> >Signed-off-by: Georgiy Osokin <g.osokin@auroraos.dev>
> >---
> > drivers/tee/tee_shm.c | 4 ++++
> > 1 file changed, 4 insertions(+)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good, I'm picking this up.

Thanks,
Jens
