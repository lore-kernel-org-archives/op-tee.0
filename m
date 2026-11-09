Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD3606A325
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 16:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhGcte0Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dQHvKG1T
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 73105454DB
	for <op-tee@archiver.kernel.org>; Mon,  9 Nov 2026 16:12:17 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HhGcte0Q;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dQHvKG1T;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 770B745273
	for <op-tee@lists.trustedfirmware.org>; Mon,  9 Nov 2026 16:11:58 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DF2ls1323227
	for <op-tee@lists.trustedfirmware.org>; Mon, 9 Nov 2026 16:11:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=; b=HhGcte0Qp7wY23ZN
	C0FSBCegN49thP6q7OSLdjtStxTFqCRYbpOfLt0nQecHaIkpWgy78q/+Ve8bx2OM
	AQTdrftOxVcYB4lPy3P+mzV32tcFxjJhM3XzRBKRnjoqYbjDTu+anV1zmsmxOH91
	yOq6cAWzquayj/TTFptm0THnz7ez0qJ/6tmbXGL1Z755XeHISDy8VeDN1Lj12KrU
	gYjnsfzlsuwB+BZt+h10YWFPh0Xf19aJOSnRWgHmzzynL+LpuR/NbHPYuwrdz0N3
	lZto0ang6UhDA3Nt0iR9Da3ROc3rw9VucmvHyRTcqXD16k8n1+yNuWU2xZJwQWTW
	ntpUZg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hue0qrtug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Mon, 09 Nov 2026 16:11:57 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b3030bd581so13550717b3.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 09 Nov 2026 08:11:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794240716; cv=none;
        d=google.com; s=arc-20260327;
        b=PxoOXoT8zzk58AMpnU3LK9pV0t7jTgEkrQclRM99dfRbEQJ3MWbrvY0xeKGv/Brvbr
         kCwkDWzWfDPLJjiweQKW401JWKPeD+eb1NlfDYu+eD859H4x5/YPEdyBk9r7XpW5DdvM
         LjSTqIWpP9nrc8NN/TAPSRT20i0eErHLFhMukb2nYvFSy0Wh9ZypzPFEqQ1C3UFr8dz0
         Zru81cCs6MNgBsA2uAMEAVLTCSUGq9iP3zOkeIcdyk1CBjMmWq/9jwLk7aDoG4f10VQc
         jNi8DZH2LeUa9DNyvTLOWBNBCNUXwWj61PJvVGmJjEvGVzst+5KWGiPcOvUKRi5A1bde
         Z/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=;
        fh=HSb7BHZVUIm6MwccyHNVtNdtUb3in4w3B9fDwaxb6sA=;
        b=h4TnimH6yryyeiUpK3YV9ksQn7Amxo+rZpiDYv2UlnUVeU3iB1JnTTZdR1IqIRCNck
         zOBneNj5R0GpFCfBg3kNHuYSmc/wGEt8fZAyKi5SGuwH7xWphjYW/RikZKIXQR7iqyIM
         /BDYWvfOOdv/0frgIQxu/lNDUUwklgBVE6/hm6F9fLRZXdCrdrllJ2mCYUs5XWlyUAng
         PM+k2hSHMYCpLhT+vA+LF+Dr52UrNL4Z7w1nnlytYl8Xh7owG81ag1b84xSKB6cwjKxP
         EINKsyzUBeWL+p9tUBNH2bbWR+sOc8PPAnKDBv4BlgoDhDh5TJkwReSamsG6/l09ESNm
         ekDA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794240716; x=1794845516; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=;
        b=dQHvKG1TP2X176S0YgvUQAhS9/DPUdAlUPOlMpy+Wf5XeicFH5JYokSRl3/Ns995KV
         yVaabRCqGowFP/t95E449arjuX4diPiapwpKcqoh+ZYzxKjwzVb93aRAZAD6SnyGsde7
         0eK8TlXGrrTBLrWqR4kNcdG0i0rq6E61GqWLPf5rlL5PjJOY4WKmUpo74Rqb9KzOwER9
         czAvq8hEC6qOdGpvHZL5NzNswiDoO3vbiTyKPXUUeDUzCNTyLVjzr9KalWRMEOD/BFnQ
         aihPfXyCuxe151NO2AkVwSdRT/xMDTj7BhBTJsfpmSVhHPWUUcR2xgojk0zJ1wO/FN9x
         WnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794240716; x=1794845516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s55H9DSMdJyN+6U3pMx20ccRfM/FfrmdAeX1so7Mbts=;
        b=OsmyiP8lvD7KwlfbtV7solWTmNpWKuk16S6H2jyU8AmDmRZeXfFdlGSPA2oTra9njk
         tmXXVcgn0mZS1mqf4vJ7aPGYyTgLTXdR7T0Pkf22/hfzmZjSBtX/Tb8Ztn7A2vIrk6JY
         C6eVZUc6BVExjK4AHhA+HnYnuLqNk2SlTwnYWyrJAOoHRlQ8pCV0t8N3OKQEFz39K1IW
         2tgGUaYaYEOh4sAo3UgO5OYaoClnrCG1qfk1OYZlEzWxdIJbURuuA10Q33AzSHDIPLB/
         wJ8uPbBqCZIRUNpFUEcX2PDvzhYqQKxfC/HOT3NkKaULVKbaaDV35YfLKqQ8CP58nQDI
         DutA==
X-Forwarded-Encrypted: i=1; AL+hErEDzIOcFlhsmdi2wCzXgT9XMZ5XZGxDIei3JbBcxsD5pAx4o055HQCsoPMY2IKfpX4Hrt/wI54=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+yrwMfD6rafMkfY9Wn9TPJg+MytDJRY4h6wWNHAwZbsv+OnvjD
	vBnSMdDNBCcC1+nZyvBYbYgVX8rJSJCHmTatF95dirL/JE9IQ5Zfbfz45ekXN7ub11vFkXxpQYi
	7xiaEG1UgB7coCsDR2s1FvTt7Mv8Y6OJLqflnh3fodla7EErY6ynTDOupOXr1AJlqK0qqeJMCQM
	klXoJ+76rlSjew7XsRo9IRMgs3AkYUnYYVwflSsTay/1y/e28=
X-Gm-Gg: AYBFou1rOPWFEqkqn9GbeK8kM/NVzcgL2ULLgbi1FCF5U7bHRwFaBZ7/7Fm7WqG60rs
	7IOpw6VeL6X+jfi4UFuBgHod8TtWB8dyknDk8UK5s6kbDUuJsohv2qwPDNY7Oi+r/P1SphN5gyF
	QmET6FljZf9kYuyfWkrqZSlKiQ36QZLrXcifomthztikyVUn8xPRwJTqmowT9g033JmN3+nTSqz
	mZi4zegXNP9qEwiBULFEqsv7WtEQwkK11lPCD7y
X-Received: by 2002:a05:690c:e650:20b0:8b3:2eb4:1423 with SMTP id 00721157ae682-8b36cac2f01mr16022157b3.25.1794240716161;
        Mon, 09 Nov 2026 08:11:56 -0800 (PST)
X-Received: by 2002:a05:690c:e650:20b0:8b3:2eb4:1423 with SMTP id
 00721157ae682-8b36cac2f01mr16022077b3.25.1794240715815; Mon, 09 Nov 2026
 08:11:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260806060727.191-1-getshell@seu.edu.cn> <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>
 <avFnybu7UDEdva94@sumit-xelite>
In-Reply-To: <avFnybu7UDEdva94@sumit-xelite>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:11:45 +0100
X-Gm-Features: AclHuK950jimtjNEPKF71997ib44N0__-ACIHjqESr_H4Xz7V2A2clS6kzX4824
Message-ID: <CAGgiveW_WuG9E7ZGuEEbr-bW8haUPmw+h_5PDxzPauBH+z=mBg@mail.gmail.com>
Subject: Re: [PATCH] tee: avoid accessing dma-buf shared memory after put
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NCBTYWx0ZWRfX7DxGoVY77TQB
 D3M0FECas56B2onqW7OncqUoimW3nX6Af9tUU8bunKd6WwBmff97JWrBYb/xAx8j9BWqYhSs80/
 ly1XshW1/pGrB6/W8mP2+6oAc7zDxymdhoTR9Ts7up0vA5zSMhXfqPJy0AwF00HGVBSi2ymhPiW
 kD87dmSxjTiZXNzC/aVLKKS34AH3w9JSTZ/Tu+NAwnTVj03PV1da+zBGWoRfzT/PE5jLmaw9LiT
 93C0a4nFc13Q7QHddvyviAAiFhHrHCt+aceOUuqDZZhWr+g/aUx4BpJPWzPI+366CKvlTzucrCb
 WIfKBo0EpgOqXDsAM/ybsvo3cxim0R0AF/LYCKw/DqhKddQEWyb+IMF1oSPkdmoW+ZHfdMBxv/A
 pQcIZF0fs5ZX1Mnq1Gdge/DA0idlG1o/fIzu3r2I2YP2gz93iOXj25TLlrW1f4oukhGzgM/MTqr
 HMyWxborXlE1H5u5hcw==
X-Authority-Analysis: v=2.4 cv=DZuCOftW c=1 sm=1 tr=0 ts=6af1f0cd cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=y-31G8drY-iPl3fTMagA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: rAATe1Qi9PMzCW3PEe49UNFxA6J_fSh3
X-Proofpoint-ORIG-GUID: rAATe1Qi9PMzCW3PEe49UNFxA6J_fSh3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NCBTYWx0ZWRfX/llxrFRJtE52
 YCib005aHJSckWctKPWvLDUojvaIkHksJMJXj9sz1SyYiAYGHx884NZ0E2BWuRUvJAS1tTqU1wG
 jtwOPjKYZRqG0ITKrVGOjdNxdeO+BKk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090064
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 770B745273
X-Spamd-Bar: -------
Message-ID-Hash: XBDB4R3NDTTQ7FETBXC3OA5YVGUMGJSW
X-Message-ID-Hash: XBDB4R3NDTTQ7FETBXC3OA5YVGUMGJSW
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Hongyan Xu <getshell@seu.edu.cn>, Jens Wiklander <jenswi@kernel.org>, Olivier Masse <olivier.masse@nxp.com>, Etienne Carriere <etienne.carriere@foss.st.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XBDB4R3NDTTQ7FETBXC3OA5YVGUMGJSW/>
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

On Mon, Nov 9, 2026 at 7:27=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Thu, 05 Nov 2026 at 13:56:51 +0100, Jens Wiklander wrote:
> >Hi,
> >
> >On Thu, Aug 6, 2026 at 8:07=E2=80=AFAM Hongyan Xu <getshell@seu.edu.cn> =
wrote:
> >>
> >> param_from_user_memref() obtains a temporary reference to the dma-buf
> >> tee_shm wrapper by ID. If closing the shared-memory file descriptor ra=
ces
> >> with the ioctl, this temporary reference can be the wrapper's last one=
.
> >> tee_shm_put() then frees the enclosing tee_shm_dmabuf_ref, but the fun=
ction
> >> still reads ref->parent_shm and ref->offset afterwards.
> >>
> >> Save the parent pointer and offset before dropping the wrapper referen=
ce.
> >> The additional parent reference keeps the parent shared memory alive f=
or
> >> the parameter list as before.
> >>
> >> Fixes: 146bf4e75eca ("tee: new ioctl to a register tee_shm from a dmab=
uf file descriptor")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> >> ---
> >>  drivers/tee/tee_core.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> >> index 1aac50c7c1de..489c39d5b35f 100644
> >> --- a/drivers/tee/tee_core.c
> >> +++ b/drivers/tee/tee_core.c
> >> @@ -397,6 +397,7 @@ static int param_from_user_memref(struct tee_conte=
xt *ctx,
> >>                 }
> >>
> >>                 if (shm->flags & TEE_SHM_DMA_BUF) {
> >> +                       struct tee_shm *parent_shm;
> >>                         struct tee_shm_dmabuf_ref *ref;
> >>
> >>                         ref =3D container_of(shm, struct tee_shm_dmabu=
f_ref, shm);
> >> @@ -409,10 +410,11 @@ static int param_from_user_memref(struct tee_con=
text *ctx,
> >>                                  * list instead of the shm we got with
> >>                                  * tee_shm_get_from_id() above.
> >>                                  */
> >> -                               refcount_inc(&ref->parent_shm->refcoun=
t);
> >> -                               tee_shm_put(shm);
> >> -                               shm =3D ref->parent_shm;
> >> +                               parent_shm =3D ref->parent_shm;
> >>                                 offs =3D ref->offset;
> >> +                               refcount_inc(&parent_shm->refcount);
> >> +                               tee_shm_put(shm);
> >> +                               shm =3D parent_shm;
> >>                         }
> >>                 }
> >>         } else if (ctx->cap_memref_null) {
> >> --
> >> 2.50.1.windows.1
> >>
> >
> >Looks good. Sumit, do you agree?
> >
>
> Sounds reasonable to me, FWIW:
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Good. I'm picking this up.

Cheers,
Jens
