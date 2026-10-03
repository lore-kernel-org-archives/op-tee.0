Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789B9CA5FEC
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:26 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8FE2B4538D
	for <op-tee@archiver.kernel.org>; Sat,  3 Oct 2026 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791034885;
	bh=UOA6JD8sCi8WMj2yDPrF0LvtP6kjcvibA/xPsZyH688=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=p5YGMAYERMT6cPHg44VtTWpCINezKjnFE79atiCNdfQJovyyBEeRjbXMcOGmpzmKc
	 Jd9JaW4MQDQRNRD2tV19wYC/KQZcUGhXMsJKOFX9Ad4lTRmXNmN9RczYv/ZpxicQKN
	 i8lNyGgxuw1EZqeX2fYe0QAg80bnILSsCvCbxs31we/Cr3GssoavJKWmZuZhprhGTl
	 mHuLTkIYkzPO6oCb7/+ninMmr3q9RP99Ns8bWz7jAsktU3wn8sDK/Fnme4+X38zHJy
	 iP9CaUXbgVNXWuuzCBtGWWUNCq8SYSca5qwlA9W48LHCdtTUoQ2BHz63q89o0upDUE
	 kZenWOgMGCZwg==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 2E50744F09
	for <op-tee@lists.trustedfirmware.org>; Sat,  3 Oct 2026 13:41:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SXQSXwFg;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bgQMGD9n;
	dkim-atps=neutral
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 693Au4oH109863
	for <op-tee@lists.trustedfirmware.org>; Sat, 3 Oct 2026 13:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cWZG9J8ZvfCaQmhFeJRAO4+EQ2nyl7qNd4JtnATWve4=; b=SXQSXwFgVMRrid/a
	BwdF9HLD0FqOzaPrHW5GXEP8CG3zGsggqxda+3R3aU4tFxcohCYJes64m1P/uwcn
	Ay8N1QDUj3DfEuSRhEe76Nnne52A7tDlVYzG7DDzcleN2EkIl1GqbFbE3P/+O7c4
	NB7UwAa0bvd/mYa5zAPq4JOyxeU+/9HQWKSgKd90a2wDLJ8wSThC28frj+ng6nUK
	abQXfWSZ8dcz5OTFrMwQMd0vK+CfG6FqPaNFiGlaWHBf/67vEomz2ySHCwR0x2yh
	QXI4qYhkTM2HcM5I0+egCQz0JJzSjy7NKOL86AeC23YCAM8mrQ/PadRHu3UbnZwH
	f9XxIQ==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sx30xk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 13:41:16 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8200c815489so3998617b3.2
        for <op-tee@lists.trustedfirmware.org>; Sat, 03 Oct 2026 06:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034876; cv=none;
        d=google.com; s=arc-20260327;
        b=HHS4w7aKTFZZ50xIny/9C4x9k67RSp+rdhofGJUWZRO0EdF2swXJFZvf2M4g6K06fq
         D679odykgAU3StdjBqcugLBC3SrEsxrMoI7vuHyKlbP3er9BUnDTjrmcFwBO8p30WE/w
         wVI4dudfXsDqpT9skMBJWZaLPojWI0edYTeduilRQKSXgBbX/oNfLGILWtPYYfUiI6XT
         nG35KuiFU2lSKvUVpvhtSXVpimi1DRomN/Cjz2sAidYgjDXnO6A+ExebQYEhwYcWPuhL
         3uEFhaArzdZaECSjyDE97L2fwHesc00b43Un2QlZekood3ATlWwRfP1agEGbQtM+JNUZ
         +YQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWZG9J8ZvfCaQmhFeJRAO4+EQ2nyl7qNd4JtnATWve4=;
        fh=TbuHmAOp0ijEJXy1oCVGu6CmUruxDxmK7bIle77oJOI=;
        b=DEilkdi37gQefUTxKge4R/9IuEfTcgkfl5EGwxHyN5MuJ1MHs6VJhp8910OB/AOsC2
         5PxLPn4/WOCTztzfsmYTtxQDjoyAWCvW7V3VlHiyrBZX6hQpGjb0B/daeeZazvTNBa7U
         xWv0Uuum1tK7+ezfRrbuiEN2YZlZMtH0E9cNsXeUConYUEp/oeu6mVnM2QlfYJ0L25kc
         CHRhztTHXEL4KUoXi9UC4eK5DqaEbk3fKnDVbN0mHsjuGZUcXow71eTwctGcPYZV/1k3
         FaR/ErG+I5TvOSEFkh1yA/t5Y8So4+XOJGOuMSNFIHm7wCHHV6r0PA+Y/TK7kN7W0J4J
         +esQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791034876; x=1791639676; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cWZG9J8ZvfCaQmhFeJRAO4+EQ2nyl7qNd4JtnATWve4=;
        b=bgQMGD9neKSJysITDjtinU2j1JpVQoEzIVmrAIxYFHaXai7YZY6VOXl7yutIxSW/QJ
         UvNkrenKSo7q6SA9I818VsUrQYZ8RQIZdkfJ6BCc3oZFyNnz+2daRtVcBS7AgDulXmEU
         YqwU8BuPtSKg+FkeQdcixoSRXyUgVoJ569xGGDfl/H5NHuF+zKX2p0dAWffXV16vI4gF
         Nirxz/koaHvfTQEy8bEsjPHjmTnC9uyrQ8VRe8qZ0351I83dxCI6dHrYA60cyrjAKbmX
         +/+jQMGNNh3kh3vqJvVR3vPCzh9qHuTH8owqiDOLvI4Bpkq9vdmAb7sTU3y2g2WXPSM/
         4nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791034876; x=1791639676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWZG9J8ZvfCaQmhFeJRAO4+EQ2nyl7qNd4JtnATWve4=;
        b=NEajVxzGcUdmu+8XeU8EeS6fAaQCdAGnaI6k1i/LU5PkxJsM8ZafrY1IPjN/LjmD5D
         zD5jpeSOrquVuVC4zpC1Fv26C9N3J9iD0heIf2TDe3iZrBU7NUdti7VyTRis9z/o37JD
         LxsVwQz7YPZJN9gQxq5ouVMEFgWejjh9APq9eDNWUwTPAduzNR3g685TdVTXeAhPgNWX
         fnIpcfWgQwbPypayQ//IiBqzPww2/sRa2poSNe8qrMmh8vKG0sjpYTGEAY9bCrlG3HpE
         eBdZ44F1eAVsCXSvqprj3Ir7bJGEHCuDqqwzaHkHB3l+qc5f3OEb7Nqk4tu18XHa7zw7
         Ulbw==
X-Forwarded-Encrypted: i=1; AKwUvBz7JGxD7Zwz/2iqIPaUvXUBVyujNhrOlulBzT7O96zdIpLEsYK3YaJbFMX43enzEeYyRsOXtWI=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKp+YSd9j2eO/HuAw4kJ+QPWjIjOPpoWyZfiuo4o19T/XDPZajg
	bO+hab2kzo6Xkwybp+bKBvqFy+yQMFMtmdYLaGR2kAW7KL/DrzjUSWYj0AOfE+Onutd2dqpmsGw
	CI/s1FGbr761yiyr5VFaZ3bi8jvCsLaXIlseJXvHweUsxLnDeeHXAKsISUgko7c4I1S3cni6X1j
	9ymRPpuyF4NAPFlBnFA7xgmhs09WQWEygJBkO3AADWvgn43jw=
X-Gm-Gg: AYBFou22Po2/Zcm7QqO6vVTx3c6iWGZhE522qasbPZA9GMSJCAuCl5VvW5jMkkgfV5F
	yQtgRJVsk5wbS7ze/MywhzPdKnKYbwmj+mlpuGx4Wjn3pq6LVlrOBIlNDklnKld2X9STrd7blMN
	FuZW86smd608AHAEcDSshJb1LtnKMNxHcxyHy13jg6v/opwADEOfQ+VhI=
X-Received: by 2002:a05:690c:c501:b0:8ae:9448:14e6 with SMTP id 00721157ae682-8ae94481b68mr11315717b3.54.1791034875818;
        Sat, 03 Oct 2026 06:41:15 -0700 (PDT)
X-Received: by 2002:a05:690c:c501:b0:8ae:9448:14e6 with SMTP id
 00721157ae682-8ae94481b68mr11315617b3.54.1791034875233; Sat, 03 Oct 2026
 06:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20261002142443.GA778834@rayden> <84c1dc64-6380-42e6-a501-9be86666e5e7@app.fastmail.com>
 <CAGgiveXqFFi+nq0834+hwBBnwJssh16aayZBgh0toYCVN+OMmA@mail.gmail.com> <67bbda51-d1b6-45ad-b798-d8c0e53bd23b@app.fastmail.com>
In-Reply-To: <67bbda51-d1b6-45ad-b798-d8c0e53bd23b@app.fastmail.com>
Date: Sat, 3 Oct 2026 15:41:04 +0200
X-Gm-Features: AclHuK_AKvv4DXHOJsSyiGB7-fYwv4aODNPt5MiUCJ6CLVwy3uWPkbDG65f1pY8
Message-ID: <CAGgiveWMy4FL+5uCLYYWOx16qPr70dKvq4u1gVdoA0Vpjv6MbQ@mail.gmail.com>
Subject: Re: [GIT PULL] OP-TEE fixes for v7.3
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=JY0pPkKV c=1 sm=1 tr=0 ts=6ac105fc cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=oYlp4R8hcnwt0YeveLgA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-ORIG-GUID: sfa25oWOBUNaOqEWnQGocy0jSKrEfwkl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA1NCBTYWx0ZWRfX0noqhSTzOZ2i
 26EK2QU6x7SDCNsu0RcpIUAU3HfjbzbIqTjdm4oobUCfP+sCd+vIiMVWc3VSroT5FpMz+e3SPyH
 40+vi376MmTmioV/ieBeRjsmvYF+gwE=
X-Proofpoint-GUID: sfa25oWOBUNaOqEWnQGocy0jSKrEfwkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA1NCBTYWx0ZWRfX6+iXRr0ngzNl
 ddeAf57bGunT5o14OvEa07DLva7TeEBxkvJTe6Ge1EACTBgJCIec/ihuvDCbaUTuip6Fo69eo4K
 iuBtpTtUo1zOUot7mTxoXh6kBxXipn7lRNgSXZO/wNeeitzOPAG+dd3gt/z1mlWgSyzHpHuhcIe
 XBproSaWLx7Vp3/bztclM8AS+hUOEcRaXjSlq/UXBV/NKtZanYDnNud6ST0ATHO5ZYsbIAgJVr2
 9tnx4MlYGT3TEHhfoHkCO87msyr5IRgnt/gDWa8E6IM2D+5zqHZWuuP7IUWGXegIE4ovLP+o/rY
 XbYszdUPyRo+abuSq4/9tghGfYOrZnRrXWrJ/MESu5j/2IkiuYg53h2vdIim1S9macKMmZ/+Dl2
 4wm08HwYRiBr06VKIfHhsvkL/cwHUhkNwreaD2YpjIkrYvTehcPgs0YWw+ETJY4jG720joTzTmD
 ViZs/aInooIyqOL2InA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030054
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.197:received];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 2E50744F09
X-Spamd-Bar: -------
Message-ID-Hash: PJQDTV7YOZEFWLOCMZ3HSI726C7FCBGX
X-Message-ID-Hash: PJQDTV7YOZEFWLOCMZ3HSI726C7FCBGX
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: arm <arm@kernel.org>, soc@kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/PJQDTV7YOZEFWLOCMZ3HSI726C7FCBGX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

On Fri, Oct 2, 2026 at 11:17=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, Oct 2, 2026, at 21:04, Jens Wiklander wrote:
> > On Fri, Oct 2, 2026 at 4:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >>
> >> On Fri, Oct 2, 2026, at 16:24, Jens Wiklander wrote:
> >> > Hello soc maintainers,
> >> >
> >> > Please pull these fixes for the OP-TEE driver in the TEE subsystem.
> >>
> >> I noticed that the contents of this branch are not in Linux-next.
> >> Is this intentional?
> >
> > I made a small last-minute change in the commit message for "optee:
> > register TEE devices only once fully initialized". That's why it may
> > seem new.
> >
> > "tee: optee: ffa: support shared memory offsets on large-page kernels"
> > is brand new.
> >
> > I thought it was better to send them sooner than to sit on them. Both
> > are added to my next branch, so I assume they will show on the next
> > update.
> >
> > Please let me know if you want me to keep them on linux-next for a
> > minimum number of days before sending the pull request.
>
> Thanks for the explanation, that makes sense. You need to decide how
> confident you are in the contents before you send them, I was just
> worried that this had not seen any testing at all because it was
> inadvertently left out of linux-next.
>
> If you are ever not sure, just mention that in the pull request message.

Got it, thanks.

/Jens

>
>       Arnd
