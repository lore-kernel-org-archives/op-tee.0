Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40503606A329
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDPxA2rc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DlhY6CW5
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8E6C6454A3
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:25:18 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDPxA2rc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DlhY6CW5;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9755045493
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 15:25:00 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQXZT1657353
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 15:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	is5cGT3wh2YUPL9Dg0SD2uO00B3vUYDKCi9fHxqZYh8=; b=EDPxA2rcw+gUfMOt
	5QBe2mpOHgSS9mr9OBH/hAnKqN8Znoxeoh85giv3EUds/mO0iMk4kh9Il2aHnTKN
	tG7J60Z1Yb/nfacF111+NjTuhNHJ+UEzsYm6Up0oXSFQt2Qz98zO0JXalZbAneKa
	PiaSejvAPPSyIpqYco4LtzEql0SdF8vl2n3Uj1La8RCSdfYe+er33yTHK20MYQjV
	thIpZtSC8K57/WHb9/JEDeI78xFIFVoU879oqpeo64rCYM/A2pjxMaxGrrFdgoH5
	MR5rrOwUOCC7NyWWu+Vt4ZZNk/4pv+OkV13gKzSJlas4st2h8mw/4RlR+oNQJXEX
	i2ZKzQ==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9f9ef3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 15:24:59 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67bfdfb2641so2758564d50.2
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 07:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892299; cv=none;
        d=google.com; s=arc-20260327;
        b=dKe7vQkbUSnjUemOoYo2BbdcmQaRADMES4wa9YS/0Pt/7WPA2LG4TcIdChrXDhDyUN
         M1tFG42knE+UAbHWzuevih9IhgXREqZk2OYamcEZkl1L0/qqhMDEKpAL6cxCOmCI4qkm
         gxh9o1OZsGvjcIx0cPEfZCYeUSaGuHQYr/9tQGcey3MVBwzJas7cdx3JHidSnWXNWu++
         /axRPQtRL8DWEIpWmXTru3TzoN9hYVJQfJEdFLR/Xo0k6Ic+GK0vlTxcp3FCkpE1bg62
         hHWZUgit3cKegSBxoKgUCfiwzDODB/zoXMURpjGA7q2zwrIrdMauxWHRnAxJNl9onFSR
         uImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=is5cGT3wh2YUPL9Dg0SD2uO00B3vUYDKCi9fHxqZYh8=;
        fh=nA/a0ahPeAgOJi8HYUAfpXrhs4li7wA3yKWOJarr5DE=;
        b=ABaWjPiDy1b5zapWIwAFrx60i8p2MGVxcc/w8QYl+iijGT0RMhTnf/VfxZqpOB9/kI
         DWRWmRjEAPoiN4DgNmwAZ/PpeKYtS3kqn7MVGEPlD1+WAHeGpWYYheNfnnYRwczsJrjg
         tuxVNhovx4F/cHv5Nbsc6H5sBEPZNNZNj35/PGoyp8JNWE4BJLIX5+71vvONQoNvyiqX
         H7vQPlAQMzHYgUiHSaYm0s94L8j0PqkkAoZ++wynMbx4D/ppkkARjDfKOdwVPe2enKKo
         adJBu4BgrQ7iSiuYwd2wC0SII/jc6Ji2s4GPlfr+qriBjZSXDpiEI5gWBC2L+gdSMDWv
         3KsA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793892299; x=1794497099; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=is5cGT3wh2YUPL9Dg0SD2uO00B3vUYDKCi9fHxqZYh8=;
        b=DlhY6CW5Itkj2wtfXeeokmotsUrgL4Ffm2xO3Od8b1GE0B/JIBsCirUESFi9gWbX6Z
         Y5BCD1rqnCn5MjYB80S2ffGYc1Q/LIAXQhUHM2CwuVwgkjxYgjzHn0Xh63QA3DBf7bjo
         Fwpu4Sb0LTIjgjGyMO8Y72zkrzABsdK+8jIQtYO5uBbypFoGpwVnvLjShTqRyARvUjg3
         ++Fy8EjO9QdSRieWrbwdsjvSziX6PXCMQJ1xKuMmNor7rVKvLOwbxqeT383NAVc7FAQx
         eZuyVq4CP/0JocczyoejAQibGsPLl1CZjVJcOSVGflSQKQYKUCf4J9+PoC6PT5mJb6n8
         a4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892299; x=1794497099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=is5cGT3wh2YUPL9Dg0SD2uO00B3vUYDKCi9fHxqZYh8=;
        b=EC2HZGOGudTXM97RCzqnj/jcfof1vCtZefZq+D/477/7pTinD5ezzTL3KEVh4cAGk8
         QHu48wSySByGvqTuKTu3jIAtDb6dAGYKXVBv4pQxLxu4m194ziMa1Fi/uyi92EF2H+Wd
         djD0olpzzBX14+RoQibb8RoowRpopCfvF0BsuWOJ2lTwpGlwTgO4z6G7Uzc5Pkpup7xC
         iKUCnE/ebWi5km8LY5Wulp/KWmXaBCIfgXfaorMsUCIVp3m7vBwqiKoW4gIZf+mjm3wO
         ptbpic9bq/vhFQClDVSOYWoPAWL4NK9UlHoL8v7sr7PGwlasNWArST/2mk6wXPOvQ46G
         jvPQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0dqboLYJoXC7wT+6U6MjY2VpE6riysFcBuND74CNdeqIvnLQn+ECUuOGy+83E9uZ2J18KBIg=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+2YR2bFHamGyp2A3pV6ZhaWYjrjbvxaLxeqyYSDpOonydpafIF
	V1g6ybqoB8j/iRPT7o1ndp89OCCFl8tbgFgDyp63V1j/daQmZUsIPpxNmZ2OzSt1fDSqJsZz0dE
	eoLB/Gb5Ubvx/rC2VBqYMhnEcI6wkSv6v+2IbizeDf+0Wgypa/NcjdoIJjWUQ77WKRGhPdXbJrX
	k/7HtbpJou1YMgXrQ/Qw215E/erkwFDaQrNx3n3F3G3opHf43xUmbQhcoydg==
X-Gm-Gg: AYBFou391lC7cxh5Vw+CYQKO4ZfJiNZwuc9UiTMx8WHUaCMdWIZOc3LBHcB8xWBy9NI
	0uUSWB+CwfZa29oN3YAPq7brU00NPP8F9iY1m5OhmSBD7oNZUeBRe0YOTA5UtJ1ltGhZfFeE0DD
	Ih2YUiwpjXf7v7lfFwHSS8PWIE1XKeE7r6Xla/Jbp4BZjnHMmqv+IretaBrPX4u0YwMP7/Wnmp/
	whFX7WV69VvqguZT7g6qBRZLB0+lrGkl2rs8euL
X-Received: by 2002:a05:690e:12c2:b0:67b:f465:bbf7 with SMTP id 956f58d0204a3-67bf465c018mr3069096d50.47.1793892298970;
        Thu, 05 Nov 2026 07:24:58 -0800 (PST)
X-Received: by 2002:a05:690e:12c2:b0:67b:f465:bbf7 with SMTP id
 956f58d0204a3-67bf465c018mr3069086d50.47.1793892298247; Thu, 05 Nov 2026
 07:24:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260831105824.3141687-1-shukai.ni@kuleuven.be>
 <20260831105824.3141687-2-shukai.ni@kuleuven.be> <CAGgiveUQ9_uZLL=KgGtV0PNiBRbHhRVMqKxWwE3jww2asW98VA@mail.gmail.com>
 <auxzjSfifbLjPasI@sumit-xelite>
In-Reply-To: <auxzjSfifbLjPasI@sumit-xelite>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:24:46 +0100
X-Gm-Features: AclHuK-Ch4fx156Y_JLzK0BM9AiP5Ql_lVFBL18Mz8xcqk3vrZIIPyvXUC_ouqM
Message-ID: <CAGgiveVazq-ysbd1yyED2nKFXQ2QgaA9AHw89hFoZvbisi8VEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: fix page count in register_shm_helper() error path
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX2rs3Ob1rB1G2
 Ydu9T1hf5d3mOpZtSyL07sDVD7sfIMB92zWQPQNhpnV0lQjwb6VVSPP44dU138MuioKhzLM22Dj
 X0xZU2gFM9b1xQAG2+lBds2zHZFzL06zW+jCJPeQdHLcexq0DxPMTWV+IzXTpJCmT5quc6IeA2V
 Y5hsJkXW9Uv7FVKqxvhIs3v3p+/VFafRlWmPplMI+i6KvA63CiJKMku9U5+nImrZmDIrTaY9qxO
 reDgbpzOPnbtlH8thkkLRY2847LYPY0togugYFxWqOWsDx7FPclRFevrHIHbxKGm0f+RQQ3LGHf
 Bpr2dK/muw7da8CdaTS2ZDqjkUcRPKhkgLZ/wiH20J3qNtdc8CKzfNX8FZSPBMoNcj+w5t1ju+F
 SAcdJ/D8GWB03dL8WDVxfbsTQTWdRVsKu1dLHqGziGCqljSG9LC/iFfmk7dOVLB8sPd3arz1CiF
 DTEkg/SwSjirMkt963Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfXwDuXUUL8G6me
 DiHzv0dFu1sbFiPH/zU2Z9HuZboB6D5AgNUVuKitfs2lGCkp7pss09Y7vbh8uk5y0O/DrIoWvEW
 mB5znAvqTN1Sh20Bm9AquExyPMfo6GE=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aec9fcb cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=mw5mVQRo2VRv8ALKo9MA:9 a=QEXdDO2ut3YA:10 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-ORIG-GUID: YoyjJbwypqAAAbYl79_af-fCKgzF7eqx
X-Proofpoint-GUID: YoyjJbwypqAAAbYl79_af-fCKgzF7eqx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from,74.125.224.71:received];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9755045493
X-Spamd-Bar: ----
Message-ID-Hash: NV46ARL5N7CSUOTJ6FO62DF6AB33NE6I
X-Message-ID-Hash: NV46ARL5N7CSUOTJ6FO62DF6AB33NE6I
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Shukai Ni <shukai.ni@kuleuven.be>, Jens Wiklander <jenswi@kernel.org>, Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NV46ARL5N7CSUOTJ6FO62DF6AB33NE6I/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 1:16=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Tue, 03 Nov 2026 at 19:11:06 +0100, Jens Wiklander wrote:
> >Hi,
> >
> >On Mon, Aug 31, 2026 at 12:58=E2=80=AFPM Shukai Ni <shukai.ni@kuleuven.b=
e> wrote:
> >>
> >> iov_iter_extract_pages() returns the number of bytes extracted and set=
s off
> >> to the offset into the first page. For the iterator, the number of pag=
es
> >> pinned is therefore DIV_ROUND_UP(len + off, PAGE_SIZE).
> >>
> >> The partial-extraction error path instead records len / PAGE_SIZE. For=
 an
> >> unaligned buffer this can undercount by one, causing unpin_user_pages(=
) to
> >> leave a page pinned.
> >>
> >> Fixes: d5cf5b37064b ("tee: fix register_shm_helper()")
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> >> Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
> >> Signed-off-by: Shukai Ni <shukai.ni@kuleuven.be>
> >> ---
> >>  drivers/tee/tee_shm.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> >> index 6742b35..fa446e4 100644
> >> --- a/drivers/tee/tee_shm.c
> >> +++ b/drivers/tee/tee_shm.c
> >> @@ -454,7 +454,7 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >>                  * If we only got a few pages, update to release the
> >>                  * correct amount below.
> >>                  */
> >> -               shm->num_pages =3D len / PAGE_SIZE;
> >> +               shm->num_pages =3D DIV_ROUND_UP(len + off, PAGE_SIZE);
> >>                 ret =3D ERR_PTR(-ENOMEM);
> >>                 goto err_put_shm_pages;
> >>         }
> >> --
> >> 2.55.0
> >>
> >
> >Looks good. Sumit, do you agree?
>
> Sounds like a reasonable fix to me, feel free to add:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking this up.

Cheers,
Jens
