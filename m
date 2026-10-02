Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA861CA5FDD
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 19:04:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id E58E9454D0
	for <op-tee@archiver.kernel.org>; Fri,  2 Oct 2026 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790967898;
	bh=mT43A2Tep9JswOhUqQb+y69D97vYcWJMtoenh+x1GIY=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=tEiLZmj/6Hh8wJsV98P/P/0A8Yvpq4lT2hEcsXKV3iFT/CHy3c/+/k2ywA4HFl7Lv
	 e8VNHzpBfh327cvgqDYYOFpsCMxa98Re+yzPk1B0R3DbHZvzBbkJhVsmcO0kpQyZSg
	 axGFrLXSSUl84sYDjROZ70IoHlpN2M3Zov0P/KU3T+UHHAYhe3Mgj2aoKUTwKC2PCB
	 7po0F7CTVdhgwsPYBliCwyhpMFM4mtS59db0SWx3TqJBpCOc86K2szi62GUQWEkkuy
	 oxvj3EoJ8UrQki5U9isZVbNpqHrXsHbRmx6fdM7UIiKDtlYZqpU0QBr79saPHhWYTf
	 /oaB9k/9p2AOA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id F12F044E81
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Oct 2026 19:04:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bTxsLJeZ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XPpBRdg4;
	dkim-atps=neutral
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692H61Y43057724
	for <op-tee@lists.trustedfirmware.org>; Fri, 2 Oct 2026 19:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mT43A2Tep9JswOhUqQb+y69D97vYcWJMtoenh+x1GIY=; b=bTxsLJeZGv8eC+/W
	jGA1wA2LoI/JmrTbLM536RXE+y9QgKp1AtNmvSi8alWpMM0WO3WQdhD+UBFj1+DT
	/RxikB/3S5Y94r6TipNrWjqZFW4sMBrtoAW1016kgpgUzeBJEzlHat6fVzICKwEh
	3Irqq/GBabVLZfpp4e1yw4LXIdAz4/xLr6pOXCf1TPysqI5D+ljcifXzJg9G+RjZ
	UjC2X4HVudMY4nY8cjrJqZqQIvKTDEXULnK6QIb1QMkKawTi6FDvWvw4mWhf5xR3
	C3h5raqv8SJFm83ctyfDS9zuwkVM2jPmsX001PAdB0pq8Na/g9BGmZFS/OTR/pZc
	9Pe6ng==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp2ygy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 19:04:49 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6768601940bso490053d50.1
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Oct 2026 12:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790967889; cv=none;
        d=google.com; s=arc-20260327;
        b=NW4GqNmLNqTM7PKUAso8/hVvX8qMY3k9q3WTNwK78uzChzcPJxA0RAJ7p5q6+awEmd
         3qGj+a7WVDDxwfyu7aTBxob7w7GLww/uftFYmiMcTtKsmvdhdPPQWXP/DEhHarQBBT08
         I4Wlnk2seGxlLGSr2ORwmTbhfjscjo+AXCCOqhwLLjgrFjqqSm/nO4JXpZabqQaexdSi
         ROqTo9orzNjR+TNwrxDBABf3Es9a2E7l+hJWd8rETVxYpz518VyXZPRIw+22Ai+D+Mh5
         wwbfmQ9J7TgEuwf/LiYMYkEvwfqqmmViF3GVnqZWRPjQ+ENEujaLW1gt14L47FB5sgIG
         GlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mT43A2Tep9JswOhUqQb+y69D97vYcWJMtoenh+x1GIY=;
        fh=h6mSF8BZrPUxaaYcO1XmLwMPu8gOxh6QqmMTACrDRM8=;
        b=VRmC4PwAA+sXVMKFVexISpRKua/bJeCJYLfk591FpHq3YmkJ7Ogbk7Qih9MvH+5+6h
         S4ABkn10xAtSDEpNiLgq5TEvri+lQ2e2xkE43V7VgUf/VNsYTuC1/o5RSV47d5eJyZp8
         V7h8FjfBKJRaO/C3gfOo7/VHDMJmVvXchXZly+xf+tPpxGa+igqkGluuyir8KWVHHpSj
         JYo+FsqY440/f0/0gw/nqrYSUq57crHDfLmcCmyLppo3Rex37l8GfOGQckrzycG2h0br
         gGCI7XOoxvTmxOzLOoApKX7SSZ4K52R5uXotjyajHkhZZoNGz4SuLUsmaJ+cbTltawnm
         sMxw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790967889; x=1791572689; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mT43A2Tep9JswOhUqQb+y69D97vYcWJMtoenh+x1GIY=;
        b=XPpBRdg43h0EeFkB+dnZisd0l0t088BR7NNaVf+G0VrASUd2E1lyaPxSW/EIczGica
         2lDm7Ys57iGBfJmjibCUC0HU6aWlfYxnBzoHEz9hX082V35BohNCBYiE0fZM03xSDiDr
         TfIFvg4z7AcHrJgo5fNtNrXx8ircz3lOxTHO5Mzz+JZPX/0YtFNa/0V1uIjI1Iv9mBgx
         ey2tj0tCLTtgHEVtgo3YKkMca/rPJRJ6F+jUKyAgtfGvVw8sl/0+s1S9JQD9sf00dgii
         +sVmfA9i09AgbvnW28b/icfV5mOU2xp/I9Q8W7IzTtjdipakqB5IswVLfVAWQFoBDLjK
         qgnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967889; x=1791572689;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mT43A2Tep9JswOhUqQb+y69D97vYcWJMtoenh+x1GIY=;
        b=pQd5FM/jTuyT4kpRrsdBkH7bLqpOLDow8tYlVOvCdVK/ODhwXjmjcRY+zQVhSD9Uf2
         9ZU6zfrmbfw3a/y6oStcCiRk6wlJKx2PjgT9Q4SmQtT083Js/vySxDx23jdj33Lla6oZ
         L3wsHT2f+RK6b/beu3GL6k5RtDWXPhLODDS/iPVzTg9GLtKE2br2DfgUxOVk4wXjT7Ew
         yqq2cHAMiKxsHU4sBDTa5rfBZ0vNfEkOckGTQyP4U1mY8oUkxMNzPC/BZ1B/o7sZw7g7
         0yfHU0VEr431bJNgWb4FC13rUCbdgx42IK93fW5+Kk27tUqSSyZ5M/5p8sLt+GcW0PUb
         5fYg==
X-Forwarded-Encrypted: i=1; AKwUvBwaQ4Mz0q+X2X3kncNzPNbrHSQq+5qgqAG1+DJj+9QYLocES0g7Ux13f9KuEvUVhXIKS+fVKv8=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYIkw4GRp4a4P60SBNkJJMaOrvfdriJj8Nx0bapWNfdEH2nAVKlh
	lSV4l87CaTVa+U6gDG2DlWRX7EVmMKoi/L12WsZOpyoaq2rCyhLLul31jopXNxzpL1fUsJZORMP
	uUJCfxEM/jP39RVPy0fg6nGs+jg+2sflt7KicpNZ89nBKqsfub+Gr311FJvdhg7/thrBL81sGw/
	YfX4jwJpcbxoobc+K+tbc5JiRpEztak7Fg4Iri3/drssU65yg=
X-Gm-Gg: AYBFou3KbUDCUr/NeiZLuNnaNuS5s3j6SjHtMony86chjlxIyjVo/wLVIGS49sOHbhr
	yEJbkfVogVYbWxz7KpyTs7U705CqtyQs7yY9U5iIkQa0bDV+TID/xUFiAqxsMOiv2oydDxhsTyx
	j+O9oZYbQWHwldl7jhAiHQx7/o7bOENulq3nzdwfMwn0UatMbAi2FvIJE=
X-Received: by 2002:a05:690e:d5b:b0:677:b670:bbf with SMTP id 956f58d0204a3-677b67014bcmr767077d50.48.1790967888728;
        Fri, 02 Oct 2026 12:04:48 -0700 (PDT)
X-Received: by 2002:a05:690e:d5b:b0:677:b670:bbf with SMTP id
 956f58d0204a3-677b67014bcmr767065d50.48.1790967888310; Fri, 02 Oct 2026
 12:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261002142443.GA778834@rayden> <84c1dc64-6380-42e6-a501-9be86666e5e7@app.fastmail.com>
In-Reply-To: <84c1dc64-6380-42e6-a501-9be86666e5e7@app.fastmail.com>
Date: Fri, 2 Oct 2026 21:04:36 +0200
X-Gm-Features: AclHuK8Hx-gmjoKfPEPErlrdzXMv7J_iPm_txYB5iricgBj9wbiOQUFrLBcfNdY
Message-ID: <CAGgiveXqFFi+nq0834+hwBBnwJssh16aayZBgh0toYCVN+OMmA@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE fixes for v7.3
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac00051 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=ghIncmqAs50lZ5yoykoA:9 a=QEXdDO2ut3YA:10
 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-GUID: Y4azzFd8pRNN7nOTtShGt1wHS1ImeJkT
X-Proofpoint-ORIG-GUID: Y4azzFd8pRNN7nOTtShGt1wHS1ImeJkT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA3NiBTYWx0ZWRfX6czuwfRXTrko
 yLgKF+uFlfo56g2psP5389yaxJFj676CvkaJiKYpEDMsm88mzpTbvgxNnT//+LEiW1pJ1FEq9cv
 ry3Evze2UF3v9yId+KHBSbMLYttqLm4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA3NiBTYWx0ZWRfX2Wej/2q10clS
 RBk8lbuRpLKX8qNsUQrLoq8CGBd1OngVzaLpT6cFcHbnG7WCCTlQhsorPTijnISEa2YTcw48RnO
 ILRxvp518/fvTRs9gUqCiUnVGFoH2+aPIYq/hDIJ9JnHa5mzQo+pjPSxO8oMXc28ji3XQ2azOeD
 FQLxYggr5IGiAvRTvaQttZ9GMi1HaLkQUm6yzZzeKm+XSuycX4VOneq3zWpHdZjmEY+sTLalLxq
 q8yWURttm1x7I7GzbCYqMGpqHJAG6IZfdtM/Y1V2qQ/FVrAt2WOZuNQ3EgGFq20kEGscKOvtPST
 vSovbBNlTfItIhfcW4nolpwmQeSGiUzLXpUzMpJNvCk73zJ4vp00r9WHGLSXf1CM2Xq4ysGX+an
 vNvgSRNOdJsZ1N6OKMBm2GBYl8jBC3zFkSDV4SrMYBndQrKxSdxkZJHBBSMKCsNVb4PXQxsidmB
 60Q5kq1XnYusZ72trdw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_05,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.70:received];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: F12F044E81
X-Spamd-Bar: -----
Message-ID-Hash: 6J2S2MVRK2EQIRCYY6YPPYQFM2URQ377
X-Message-ID-Hash: 6J2S2MVRK2EQIRCYY6YPPYQFM2URQ377
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm <arm@kernel.org>, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6J2S2MVRK2EQIRCYY6YPPYQFM2URQ377/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Arnd,

On Fri, Oct 2, 2026 at 4:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Oct 2, 2026, at 16:24, Jens Wiklander wrote:
> > Hello soc maintainers,
> >
> > Please pull these fixes for the OP-TEE driver in the TEE subsystem.
> >
>
> Hi Jens,
>
> I noticed that the contents of this branch are not in Linux-next.
> Is this intentional?

I made a small last-minute change in the commit message for "optee:
register TEE devices only once fully initialized". That's why it may
seem new.

"tee: optee: ffa: support shared memory offsets on large-page kernels"
is brand new.

I thought it was better to send them sooner than to sit on them. Both
are added to my next branch, so I assume they will show on the next
update.

Please let me know if you want me to keep them on linux-next for a
minimum number of days before sending the pull request.

Thanks,
Jens
