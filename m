Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F943606A32E
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UxnJvaXE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=az5yI5iz
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id BF1BD454A7
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 12:57:22 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UxnJvaXE;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=az5yI5iz;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 25A824539D
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 12:57:04 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tFTl082965
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 12:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=; b=UxnJvaXELaUEgiuu
	ks9r5kdERBsPO9yfyr9ebaZiQJplcqUiXUkl29RnjuG1yp2Go09xrsKYQJ/vghmT
	Xf8gueYHQ8k2uMS1CAKebDWvKFbzDjkGAcnTcgETbt3QAxKQFe3g2w2QRDi3U4C5
	mTlNGqTAqSpGpWHctZEyNwqV380/7fk/k/bhhqFtQ+J+7gqYoj4DfUkkfD+tTwGs
	ciR5KvagIwFL32tzML+a6YJ/XQRCA/YNHEgqPemOw0ToppgITrehySGdGeuQAhsS
	il96VeapyMWoBSkl2T17q6gjwOURjHLgTWBcN4+9u/Qf8SrWx2dp7GiMacY/AI0g
	fDpdAA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p0v8d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 12:57:03 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-67c041acd09so1192505d50.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 04:57:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793883423; cv=none;
        d=google.com; s=arc-20260327;
        b=YpXBOKBUie7jEuyMwqNLCwteypuvV+SZmgiGW75SNLNYxYRt6kXpFOD2TfgpmQsl1M
         fyBIxq3ekb+jAF9EqrBxnHnhHd/GXSzryI1n1+nsDeuewk+8lmuzJYSO0xLG2GHf30Rd
         JWLCkuTdrilX1IkgqcFOf1sPkJpsDU/j7J5q1/PBOEWZuusI4qQPEnvd0km82ZjFegeF
         Dp/IaJkJ+4JTF5vTmaBQaDE80SVDmWhPNdITd9e7JlBgXYpsiapKlcw3zf0rle2sOSZK
         TkomqFcLsgw8YFAuV7s2cYvsJqa0CXqqY0/PJeroZVOCmjfs9rOGHEGCJMv8rApZKWFR
         30aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=;
        fh=5sk3AzSrUvWoMNMYOgpDK/9s5BldhTv2ixT4h4HA8a4=;
        b=VABZHUgkCYdzkLp4V/svRj8M6ICyOIcRclBwIjYh/YbWA4Fgt9RK1g5dfgurDdAUGi
         UswKHxZUwVUMlx7Nd+FCU8uk91/IYDzxVZuLxGHz02zFZdF3lbYvx66v0ecyXGBpNsie
         b5IUTxjcjfVUK1zxQfwrQyz2hwbV3DZvsguskWJRycRqctBOxchwLoMp5LGOCzJeJo4b
         TEOrHwVqgKHo492X2lWX029fKfjJTrNeFw9NAKzUSl4BSw1epxX/q611xficrEAI5pl0
         3MDibUfbG7XkO6nn+7Z/NRTHBXKaI1lwDJxrPTK3cjgDVWrwNjtyZls0u+EFyMlRgV7G
         V20w==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793883423; x=1794488223; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=;
        b=az5yI5iz7t4EPU7ChwBCNmsAqJSeTjqcq/aZhlWH4Spk+VxIq5DFP3fwbqsw2QMXPn
         VC0msNxYVL6J2u/zybWqiZAqVCTKyX4VTHHO8uDY1hSCeSPVCuvwbF2NEeqRy+eJx2o/
         nQ3w1yDUg5x3yEP68/PpBG/w1gqNM1VmTjCfcrj404LQ/h7+y8FVBNpXV3xGy1f7Qlm4
         1neGKFiKMpXc75Rp4U78QlHYl4y42HQBbpxxuta8BRkgLMiuJTAnRraBr1w6bODFXJ/b
         Ntsv4mpbQUuSZHcq3h0XUvhPWblb5VrWuMrM7/mK7yd2CGg0Uc1r8Dhufxn6Oa/jlDla
         jq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883423; x=1794488223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6V0/Yb5a1QvRIJN2J2+vcq7KJWj1JHis9ukDzSy/NiU=;
        b=MsdOuoutHCdzrpgiBuyRm1U/IWGGFuu0PdJrjQttmjUxOW63Y8K+2+t5PMiCyaQANw
         x5QadPftm+OnQTMCqqOEnOqqLn4ZeJorqMh+iQ+SyjkN3IUA/rj7CoAo3CzbLOkQpCLq
         bmtcC0XHnWBrcIXn8tSqN/hvFbe3/r4YRbosTbih/8OXEqvseKUZ48km0M21AH23jWWe
         HV/mO+s6YkDBTDSnmvmLRyqUBDAq0cSTtst5Qu1rrAIgDwRzTgU18iKk2hHfhymR6iMB
         ClbuWP/oEwd5Xz9EYsrAqfpRDWi4JlJwmF57dlo/hM5RtZZewyawgGx+TuWJ3F7Tje/n
         sl4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxWyonh5G1IA6Zjuxn3ZM9gHz2meewtk/41+y7LpNdmlxFJVM3I/vTv5bzu1BGSnIJrxzD5be8=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+CNL/BZhG5KBvy583KYAldHp1hUzM7kpZQ9WbWlhaZA012epTw
	gWQGfRdnSa5uSFSX6aVoWPqHizaFkoZB492y2JOwcLi2OTbKNmg3kl71/I8kUuVkXVvBzTC+Sxq
	uQVsMg/6TP8VwE5opgK+RQTkq/oPYONfLtNlgo+iYz7KHY1cegY//8DHDSBdxjoZbI4gSUAKJoe
	8ZWdr/ej5VfQa8cInOLq1ORySERZm6LNKJjAVQnhv3JFCDrfk=
X-Gm-Gg: AYBFou3VHdBGKLTMx5N6rjPv13uNgyQtNx8zdOW0OA4lWiE0f9pqLfSRGWzmmCDAxot
	AnWXx2B7PAgk72c8Jl1m7Qy3oY/odGkrjjnVfa5nwuvktCu9wELG6tA4l0RHzalHq8jFBExq1sB
	sQbKe4Et6RatoJFkdpfTdeRNYs+1DJVTX6GHLzGw0vs5LWDI6FkZikahiYUHOXwB+2EFW3IJHyG
	0PChEV+kC+ltFEPNKnZFuELIl7TvNvykOy+RTfD
X-Received: by 2002:a05:690e:a44:b0:67c:709:9d51 with SMTP id 956f58d0204a3-67c0709a0dfmr825269d50.83.1793883422941;
        Thu, 05 Nov 2026 04:57:02 -0800 (PST)
X-Received: by 2002:a05:690e:a44:b0:67c:709:9d51 with SMTP id
 956f58d0204a3-67c0709a0dfmr825261d50.83.1793883422546; Thu, 05 Nov 2026
 04:57:02 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260806060727.191-1-getshell@seu.edu.cn>
In-Reply-To: <20260806060727.191-1-getshell@seu.edu.cn>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 13:56:51 +0100
X-Gm-Features: AclHuK8fnhCuqb1T0fFS_ASfWZzvsgNNY_vGXPh2_piEpskxhsQ1ds10NH8uPJY
Message-ID: <CAGgiveVEiVqxVO-B0kxW9uCb43g2ocs1bgEZLWpVq=+AERaevA@mail.gmail.com>
Subject: Re: [PATCH] tee: avoid accessing dma-buf shared memory after put
To: Hongyan Xu <getshell@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aec7d1f cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=X7xKr11vWj73--6tdDcA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX1qSzRh8lhGt5
 bFtoBqgiLOD+yk9JBy4z194X+Ohkphb0vrn82I9pC/g3TAv7wlcG5IUKjJbzHTCYnNN2HrgplF7
 GYhXFyVjySlncLWbmf4lhvFoGzjB9OElGAYgMgt9SuyRNSZIxVmq58AAOYhoxAsi4rBAZRRY3q8
 EXErPakECLXNU0nrOQ+XBr7kCFtPoixSgRrse0nyqFw2ICnJhhlyXHrm04tDVI9R+SxR/iIpHPb
 L4gGl8FDFgGoByvU7+ycrMbGL/s0ungTSUh++bX8s+cyTy0wneUbO9LgdWwcFlPIHlkuYCSYLPH
 T3u+KjIVhkBZRuCP3zCypqdWkZw8uvCndlGBMHNF+xP+SuULdvyF9YY4oBKPRNWYObrlevf665m
 0QT+I/Q9UAl+XeoBslSaj0jAsrI9i1S3PXFnO3ufl6/OB0NsfE5eeYbFKQEPXPlriujsidSiQ2T
 cnsayAamI5eXX2HoQsA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX9WMPAwAGI/p2
 mZdfMwwxYsu77fs34upSomNIzL3HUjop+Cy63aaQ+vfcVHQl7qiwYnbDa6h3rveIzPzOXnG/qKh
 yE7eD+LVV28X5kHg4KQOQHkn41bbh/o=
X-Proofpoint-ORIG-GUID: Ki0Y5bqYTmti4fDk0cL70HhjwuoFHGNN
X-Proofpoint-GUID: Ki0Y5bqYTmti4fDk0cL70HhjwuoFHGNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 25A824539D
X-Spamd-Bar: -----
Message-ID-Hash: VMY5PGIO2J6KU2INLD5MPOX3MF2ACX6I
X-Message-ID-Hash: VMY5PGIO2J6KU2INLD5MPOX3MF2ACX6I
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Olivier Masse <olivier.masse@nxp.com>, Etienne Carriere <etienne.carriere@foss.st.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VMY5PGIO2J6KU2INLD5MPOX3MF2ACX6I/>
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

Hi,

On Thu, Aug 6, 2026 at 8:07=E2=80=AFAM Hongyan Xu <getshell@seu.edu.cn> wro=
te:
>
> param_from_user_memref() obtains a temporary reference to the dma-buf
> tee_shm wrapper by ID. If closing the shared-memory file descriptor races
> with the ioctl, this temporary reference can be the wrapper's last one.
> tee_shm_put() then frees the enclosing tee_shm_dmabuf_ref, but the functi=
on
> still reads ref->parent_shm and ref->offset afterwards.
>
> Save the parent pointer and offset before dropping the wrapper reference.
> The additional parent reference keeps the parent shared memory alive for
> the parameter list as before.
>
> Fixes: 146bf4e75eca ("tee: new ioctl to a register tee_shm from a dmabuf =
file descriptor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/tee/tee_core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 1aac50c7c1de..489c39d5b35f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -397,6 +397,7 @@ static int param_from_user_memref(struct tee_context =
*ctx,
>                 }
>
>                 if (shm->flags & TEE_SHM_DMA_BUF) {
> +                       struct tee_shm *parent_shm;
>                         struct tee_shm_dmabuf_ref *ref;
>
>                         ref =3D container_of(shm, struct tee_shm_dmabuf_r=
ef, shm);
> @@ -409,10 +410,11 @@ static int param_from_user_memref(struct tee_contex=
t *ctx,
>                                  * list instead of the shm we got with
>                                  * tee_shm_get_from_id() above.
>                                  */
> -                               refcount_inc(&ref->parent_shm->refcount);
> -                               tee_shm_put(shm);
> -                               shm =3D ref->parent_shm;
> +                               parent_shm =3D ref->parent_shm;
>                                 offs =3D ref->offset;
> +                               refcount_inc(&parent_shm->refcount);
> +                               tee_shm_put(shm);
> +                               shm =3D parent_shm;
>                         }
>                 }
>         } else if (ctx->cap_memref_null) {
> --
> 2.50.1.windows.1
>

Looks good. Sumit, do you agree?

Cheers,
Jens
