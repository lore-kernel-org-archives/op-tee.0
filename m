Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2D5CA600B
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 06:52:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 434894539D
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 06:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791442321;
	bh=jRRakiQzbxB2M2wtTcRutA41AXUApRzuFEaJcKBl1ds=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=yQbgX6Vq4Y0e70HsDxEsI5+UUwdpnYphLWopSfzn/ffz1h7vRbIPCa+QefJHoyRlw
	 5k8QOMAGaJBR8Zi171hTSY1z4ml5lkMisJRAB+0qORfBB3vIRLFDgzZdylrl8nXhCz
	 JocywDXCeRrXaLBXSx1JuHLYZ72yFR1rn0682fYPHRNZOt3LPwb5ls35XJHT1kYGCn
	 hcd0I8eT+3+3MKnl6fDmqdFm9TC+eIUQ2ycBZSeOJj5/lu6x3tg2yGhSwzKd8vxm9y
	 cTB7G01H4yR2/AN2/z9yu0e2pcPdS6bl0LLcxQe3YrSdWvDIewW7ZMej0XKGhtSSDb
	 f4urzs4jQ1xmQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B1B6344E81
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 06:51:53 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hiG+lgSQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aqV48kgQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6984BUEN928483
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 06:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gE1AM6RH/00M3kKji0VqgiEfLBMfl2yFwGbt+ZdOkog=; b=hiG+lgSQw89SYxy5
	kewaEdtiGpvalWXmZYBSE1f1IqZt9Ezd68ft48rtRdzqBsFoyaTBMFOoTJ8comcK
	Rc/1hsyrXJBrgQ2AiWlaxkaYjfD6+kf2LU6e+5L43ZQCUfHBhZJRJc95MJ8c4kWI
	IYBgWFWMlK0IBmE5pu3+g6GhWlNa6Qwi1jT9HGBYyho13pQweKQj7cTekqAIr6WY
	liEjvQmn4SvM3uiiIe2IRBpW8uzZFFSVrP+F5TD+VbmkIgyKaON3yDPt7cYq7TOJ
	N7qIz+dvRusP95EeEsS7OQjTuuRBx8XZRsX647wh7oG/w8RPAju0WtURTD33RNUn
	7NSQbw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2sj6q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 06:51:52 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-86e8abd7136so62529217b3.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 23:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791442311; cv=none;
        d=google.com; s=arc-20260327;
        b=IlGXb57VH5PMuqQ84OGktW8oLIhP4Af6rXXAfY8orOrWZVikdgdaT5xQLBmCn3ncTN
         p5w4IAxdSYKIbA+6StCDTOLb6euYpSSSKU+EcAVdVa5923VQ5wNpYJyER5+mxpG3pDUR
         cTVnmtn/ZU9bukLQjY+sjQ1fFmdluHud3GOyZXtgne09FzPNkyLWIW6zmy08EsegcrIe
         pKOfwC3O8EtNVbNND/i+CqE1RkEURUXnQX/5XteR5SSCYi0nSdMGLu4Z4VXKFT/MzLOj
         GFHxjMqK/OMtaKNey6HxVCjl99cVR/ziFiBYNCMDfLyZvKGXizUQmA0S9lCnA28sWihQ
         4NiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gE1AM6RH/00M3kKji0VqgiEfLBMfl2yFwGbt+ZdOkog=;
        fh=t/VCAvoIWpRlWI3tzeFXmEeINFasj5BdYpiLgBJG6O0=;
        b=CekZe8JVdvBy5XSVfrBiw7fTed0PcVizwx1B2eP+/BTnR44d+pEzTVEl0FkY1R8c1B
         zk1qtkPf5gLXxHd2bW81UnlA+YxH/o2muF2UkgCmyF+kaMiVTGBvZJoi3wkclRAYur5f
         j4JFibCi2Lw041g3uLBW8jyLr0ZHRsR6HDeqCiQGBH5DLnk5m0eOXSaNOfmfbZ43YPqI
         rR8HQ/QF/rlL+jcsOrjPzIRexSQ6yDCFQFVmg+DLxaYywJqz13hrY1c5WxIvjDC0OH4/
         0lkprgH/ASfzdT/kH1xZoqUtacolkA1PXvh5qLpgE6y6U5KpoNytK4sAuJy4YoF4g1Pv
         faLQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791442311; x=1792047111; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gE1AM6RH/00M3kKji0VqgiEfLBMfl2yFwGbt+ZdOkog=;
        b=aqV48kgQzlepp5Cowl+zkSC8tuNTgB0PPQpxfHOS6ZlmYIm3xGd9X253drniJe/T1L
         rGyslFoPeLIrGUTUFzNKh+uSiFfJFEz3Aqwh6VstJ12B+ZUqs3hX2VTc98hbgc2Rpojg
         0GC/htJjNoO1yuTrWpQ2t2hfCf0zZKEbcePT3uMLtFG1CTWfZoc/8cM140msPE0+/FSh
         D2xU2OP9twRm1q+7XSfeDxwju7eM3vasyPBv+WDe5R3zcRvo57sy6oxNYE8xAtuQfKfA
         /c8rnB2U8XNyPoo8jyCBheq09/oED4zy4NjQJa9umUd8aMlFORQLeHdgM9UR3CJkTAZ5
         pcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442311; x=1792047111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gE1AM6RH/00M3kKji0VqgiEfLBMfl2yFwGbt+ZdOkog=;
        b=1dclpyUyRP0KTiLO87zbAjuIVIFFYDNfsQlKFcGoz4qEqaWCQhN38bE0Dhmn/BtYAg
         xA0GPCXiCDFSL8X5WG9/JCUaoJMhxz6QD15AVOtnx9Z2edZCcl+NjE6teseMKstaU/+4
         aNxs4nwPn90odvJvmmRfRmZKgcSFIajatsQ0TReCZ3i+ojUgpjbfyE6oY3/RA2/Qz4hi
         nw9PC+Y5wApUHRJ0gMdptEYX8GYpBErFCaDHIDu7N1uxpVc0BmXmeJNHgCc4Y54WDPbg
         I1XPNbYFQ6uRWrPts76LBPDzdV530wrhp2hKURFD2jUHq7yosnz0wwpFYGpRIqqkQ2kb
         S8iQ==
X-Forwarded-Encrypted: i=1; AKwUvByvEC40qmTr07nO1ryIqHVO8AuAcABCk93hiyBOUzjajp3pm86K58adci8APTdz+BxI5Npmblw=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYKTgRarE1pI195ykSDY0Y7ZZcjD1ymldgnLSaYgloZ9RgOGvXoj
	O0b4MNf8XPiKCHOqSjKqTekEsTopLiNX5C1Qz9ASM7p2NG9kWuE4/OPNm7BFqEH+QfUlNjgL7pv
	6O2hKsm0qAddJhocqRX74zGPlJkRpEBUZrpsAdCEypd9aYpZ4BobXiYJUsaec1scWubURo+e8Ow
	A9kNBXotNib2Dnd6AThHRupmsmhkUJaiUhTsxMOf7mzTC0hWc=
X-Gm-Gg: AYBFou2m57KGUFZlbeZZ1mbuu7bnvso8CfS29xD8GmMaBjDNxTybBFC1loNL5UdnTpe
	nxRXjn+MTBw0gYaWJNNSJdsVirNGyeYRrMQ4UPj3WhR7K9KOEGrb3cZ81+wD7rIqisdBrgN2Dky
	9es59LE2rd6OtpUymQScfNsVN7wyDoapRQ0jHTV0m/ojttIYfUB52OkJk=
X-Received: by 2002:a05:690e:438d:b0:675:692d:efea with SMTP id 956f58d0204a3-6790a46d64fmr2007768d50.61.1791442311101;
        Wed, 07 Oct 2026 23:51:51 -0700 (PDT)
X-Received: by 2002:a05:690e:438d:b0:675:692d:efea with SMTP id
 956f58d0204a3-6790a46d64fmr2007748d50.61.1791442310437; Wed, 07 Oct 2026
 23:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
 <20261005-rpmi-tee-service-grp-dev-v2-2-72f222e23ec1@oss.qualcomm.com>
In-Reply-To: <20261005-rpmi-tee-service-grp-dev-v2-2-72f222e23ec1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 08:51:39 +0200
X-Gm-Features: AclHuK_BXfrbJuQ243m10CSA8iWapOM_LML7mBAzAL1LKQNptC5Dz8ZbLgglxz8
Message-ID: <CAGgiveUB4ETEbcfCvagfj6q__jsfPmJoeT_w0xA-9NOZpGNwfQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/8] tee: optee: define the RPMI control and
 parcel-reference ABI
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNyBTYWx0ZWRfX8wa5IHob5DG2
 9yfDT4ZcjYCJRnTgl3Yqq/YIEwyYKHvx7b57bjAb+7VXgwjY8mYT1TgL0zoonaTgS+KLMQVv4Hv
 lk49GlwxxMlz6QssMNo9jEkIccHG530=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNyBTYWx0ZWRfX+qiKHU6BxJEP
 fMEqKEJ1jXeVGFZOfkRH+zEjP75aerFEWUcZ/HdToMxhQ/rwP5vcEBI7mGNptWHsRm4Ph9d+vsk
 enAYba76qsn7f1Z754fedJuWWcDZQzf92nyteNzEXHU5dm1PzkEm2zZ3V8hOyvYIF40zzEP/6Uq
 e2tbur4QeU5ilKYMbXmWYkMug8z5CKaHF/9OKoBpVK/Ogpb6OU3CbziCQF8qmckzT0zilbhLztH
 bD0f1ju4d3Wcv2awjJvwJ5MrWkuTrNMXXJgOE+ANuCWW6PUwDhSbGQWPr+7SyUIciri+SP23pA8
 8CKNblTMtYSOL6mIWRKx+f+i6YlVJ1dXR+CAOLtJ4ZmSsmAjgCFSiZj2WMLM2JjL9qT1dWq6Q2G
 eB15M9yt8yRIEYGTphqidIjb2bR9dXMQINVitTvaqCxH7cNgYrEbuTF+ldnl/hjfokvfvhRf3Ff
 ScbiMn692uIHEdSSr9A==
X-Proofpoint-ORIG-GUID: mCTJxevFCkaRA3gqhAsp00KOO2GUvhKN
X-Proofpoint-GUID: mCTJxevFCkaRA3gqhAsp00KOO2GUvhKN
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac73d88 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=y1CmhHYXhqqenl_sZrYA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080027
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[dt];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[209.85.128.199:received,205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B1B6344E81
X-Spamd-Bar: -----
Message-ID-Hash: RUM4SKMQH5RG4QYSSG2F5S3BXNTFI6AE
X-Message-ID-Hash: RUM4SKMQH5RG4QYSSG2F5S3BXNTFI6AE
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RUM4SKMQH5RG4QYSSG2F5S3BXNTFI6AE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Amir,

On Tue, Oct 6, 2026 at 2:40=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Define the OP-TEE service protocol carried by RPMI TEE_CALL payloads.
> Add operations for version and capability queries, shared-memory
> unregistration, asynchronous notification enablement, and yielding-call
> start and resume. Use fixed-width little-endian control fields and RPMI
> error codes for control responses.
>
> Add a parcel memory-reference layout to the common message parameter
> union. Identify shared memory by its parcel ID and nonce, with a 64-bit
> byte offset and size, without changing the message parameter size.
> Encode NULL references with a zero parcel ID and nonce, leaving parcel
> ID zero usable with a nonzero nonce.
>
> Document the wire layouts and ownership rules for matching Linux and
> OP-TEE implementations.
>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/optee/optee_msg.h  |  38 +++++--
>  drivers/tee/optee/optee_rpmi.h | 234 +++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 264 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.=
h
> index 6c3043f8da33..028f8cd95fdd 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -31,6 +31,9 @@
>  #define OPTEE_MSG_ATTR_TYPE_FMEM_INPUT         OPTEE_MSG_ATTR_TYPE_RMEM_=
INPUT
>  #define OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT                OPTEE_MSG_ATTR_TY=
PE_RMEM_OUTPUT
>  #define OPTEE_MSG_ATTR_TYPE_FMEM_INOUT         OPTEE_MSG_ATTR_TYPE_RMEM_=
INOUT
> +#define OPTEE_MSG_ATTR_TYPE_PMEM_INPUT         OPTEE_MSG_ATTR_TYPE_RMEM_=
INPUT
> +#define OPTEE_MSG_ATTR_TYPE_PMEM_OUTPUT                OPTEE_MSG_ATTR_TY=
PE_RMEM_OUTPUT
> +#define OPTEE_MSG_ATTR_TYPE_PMEM_INOUT         OPTEE_MSG_ATTR_TYPE_RMEM_=
INOUT
>  #define OPTEE_MSG_ATTR_TYPE_TMEM_INPUT         0x9
>  #define OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT                0xa
>  #define OPTEE_MSG_ATTR_TYPE_TMEM_INOUT         0xb
> @@ -149,6 +152,23 @@ struct optee_msg_param_fmem {
>         u64 global_id;
>  };
>
> +/**
> + * struct optee_msg_param_pmem - RPMI parcel memory reference
> + * @offs: full-width byte offset from the parcel's first byte
> + * @size: logical reference size, or required size for a short-buffer re=
sponse
> + * @parcel_id: firmware-assigned parcel identifier
> + * @nonce: nonzero REE nonce supplied when sharing the parcel
> + *
> + * A zero parcel ID and nonce encode a NULL reference. Its offset must b=
e zero;
> + * its size is preserved. Parcel ID zero remains valid with a nonzero no=
nce.
> + */
> +struct optee_msg_param_pmem {

Without an internal offset like in struct optee_msg_param_fmem, an
explicit register SHM call into OP-TEE is needed before it can be
used. You'd still need the TEE_MEMORY_PARCEL_CREATE, but we can save
one round-trip into the secure world.

> +       u64 offs;
> +       u64 size;
> +       u32 parcel_id;
> +       u32 nonce;

I wonder if parcel_id and nonce wouldn't be better combined into a
single field. They need to be separate when preparing arguments for
the TEE_MEMORY_* calls. Everywhere else, it's only an opaque memory
handle, and one handle is easier to keep track of than two.

> +};
> +
>  /**
>   * struct optee_msg_param_value - opaque value parameter
>   * @a: first opaque value
> @@ -166,18 +186,19 @@ struct optee_msg_param_value {
>  /**
>   * struct optee_msg_param - parameter used together with struct optee_ms=
g_arg
>   * @attr:      attributes
> - * @tmem:      parameter by temporary memory reference
> - * @rmem:      parameter by registered memory reference
> - * @fmem:      parameter by FF-A registered memory reference
> - * @value:     parameter by opaque value
> - * @octets:    parameter by octet string
> + * @u.tmem:    parameter by temporary memory reference
> + * @u.rmem:    parameter by registered memory reference
> + * @u.fmem:    parameter by FF-A registered memory reference
> + * @u.pmem:    parameter by RPMI parcel memory reference
> + * @u.value:   parameter by opaque value
> + * @u.octets:  parameter by octet string
>   * @u:         union holding OP-TEE msg parameter
>   *
>   * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is =
used in
>   * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value or octets,
> - * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @tmem and
> - * OPTEE_MSG_ATTR_TYPE_RMEM_* or the alias PTEE_MSG_ATTR_TYPE_FMEM_* ind=
icates
> - * @rmem or @fmem depending on the conduit.
> + * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @u.tmem. OPTEE_MSG_ATTR_TYPE_RME=
M_*
> + * and its FMEM/PMEM aliases indicate @u.rmem, @u.fmem or @u.pmem depend=
ing
> + * on the conduit.
>   * OPTEE_MSG_ATTR_TYPE_NONE indicates that none of the members are used.
>   */
>  struct optee_msg_param {
> @@ -186,6 +207,7 @@ struct optee_msg_param {
>                 struct optee_msg_param_tmem tmem;
>                 struct optee_msg_param_rmem rmem;
>                 struct optee_msg_param_fmem fmem;
> +               struct optee_msg_param_pmem pmem;
>                 struct optee_msg_param_value value;
>                 u8 octets[24];
>         } u;
> diff --git a/drivers/tee/optee/optee_rpmi.h b/drivers/tee/optee/optee_rpm=
i.h
> new file mode 100644
> index 000000000000..252216aad09b
> --- /dev/null
> +++ b/drivers/tee/optee/optee_rpmi.h
> @@ -0,0 +1,234 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +#ifndef OPTEE_RPMI_H
> +#define OPTEE_RPMI_H
> +
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +#include <linux/uuid.h>
> +
> +/*
> + * OP-TEE service ABI over RPMI TEE_CALL.
> + *
> + * Requests and responses are carried in the TEE_CALL service payload.
> + * Control fields are little-endian. Response status fields contain sign=
ed
> + * RPMI error codes, distinct from the outer TEE_CALL status and the GP
> + * command result in optee_msg_arg.ret.
> + */
> +#define OPTEE_RPMI_SERVICE_UUID \
> +       UUID_INIT(0x486178e0, 0xe7f8, 0x11e3, \
> +                 0xbc, 0x5e, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b)
> +
> +#define OPTEE_RPMI_VERSION_MAJOR               1
> +#define OPTEE_RPMI_VERSION_MINOR               0
> +
> +/**
> + * struct optee_rpmi_probe_req - request without operation-specific argu=
ments
> + * @op: GET_API_VERSION, GET_OS_VERSION or EXCHANGE_CAPABILITIES
> + */
> +struct optee_rpmi_probe_req {
> +       __le32 op;
> +} __packed;
> +
> +/**
> + * struct optee_rpmi_status_resp - response carrying only an RPMI status
> + * @status: signed RPMI error code
> + */
> +struct optee_rpmi_status_resp {
> +       __le32 status;
> +} __packed;
> +
> +/*
> + * Return the service API version.
> + *
> + * Request:  struct optee_rpmi_probe_req
> + * Response: struct optee_rpmi_api_resp
> + */
> +#define OPTEE_RPMI_GET_API_VERSION     0
> +
> +/**
> + * struct optee_rpmi_api_resp - GET_API_VERSION response
> + * @status: signed RPMI error code
> + * @major: incompatible protocol revision
> + * @minor: compatible protocol revision
> + */
> +struct optee_rpmi_api_resp {
> +       __le32 status;
> +       __le32 major;
> +       __le32 minor;
> +} __packed;

Why do these communication structs have to be packed? With careful
design of the layout, padding, alignment, etc, it shouldn't be an
issue.

> +
> +/*
> + * Return the trusted OS revision, not the service API revision.
> + *
> + * Request:  struct optee_rpmi_probe_req
> + * Response: struct optee_rpmi_os_resp
> + */
> +#define OPTEE_RPMI_GET_OS_VERSION      1
> +
> +/**
> + * struct optee_rpmi_os_resp - GET_OS_VERSION response
> + * @status: signed RPMI error code
> + * @major: trusted OS major revision
> + * @minor: trusted OS minor revision
> + * @reserved: must be zero
> + * @build_id: trusted OS build identifier, zero if unspecified
> + */
> +struct optee_rpmi_os_resp {
> +       __le32 status;
> +       __le32 major;
> +       __le32 minor;
> +       __le32 reserved;
> +       __le64 build_id;
> +} __packed;
> +
> +/*
> + * Query secure-world capabilities and limits.
> + *
> + * Request:  struct optee_rpmi_probe_req
> + * Response: struct optee_rpmi_caps_resp
> + */
> +#define OPTEE_RPMI_EXCHANGE_CAPABILITIES       2
> +
> +/**
> + * struct optee_rpmi_caps_resp - EXCHANGE_CAPABILITIES response
> + * @status: signed RPMI error code
> + * @secure_caps: reserved for future optional features; zero in version =
1
> + * @rpc_param_count: nonzero parameter capacity of each RPC argument buf=
fer
> + * @notification_count: nonzero logical key count, including synchronous=
 keys
> + *                     Keys range from zero through notification_count -=
 1.
> + *
> + * Version 1 defines no capability bits. Unknown bits are ignored by Lin=
ux
> + * for compatibility with future extensions.

Note that we expect the ABI version to stay at 1.0 for a foreseeable
future. Extensions to the ABI are primarily negotiated using
capabilities.

Cheers,
Jens

> + */
> +struct optee_rpmi_caps_resp {
> +       __le32 status;
> +       __le32 secure_caps;
> +       __le32 rpc_param_count;
> +       __le32 notification_count;
> +} __packed;
> +
> +/*
> + * Unregister a shared parcel from OP-TEE.
> + *
> + * Request:  struct optee_rpmi_unregister_req
> + * Response: struct optee_rpmi_status_resp
> + */
> +#define OPTEE_RPMI_UNREGISTER_SHM      3
> +
> +/**
> + * struct optee_rpmi_unregister_req - retire a shared parcel in OP-TEE
> + * @op: OPTEE_RPMI_UNREGISTER_SHM
> + * @parcel_id: parcel to retire; zero is valid with a nonzero nonce
> + * @nonce: nonzero nonce associated with the parcel
> + *
> + * Success means OP-TEE stopped using the mapping and released its recei=
ver
> + * interest.
> + */
> +struct optee_rpmi_unregister_req {
> +       __le32 op;
> +       __le32 parcel_id;
> +       __le32 nonce;
> +} __packed;
> +
> +/*
> + * Enable asynchronous notification delivery.
> + *
> + * Request:  struct optee_rpmi_enable_notif_req
> + * Response: struct optee_rpmi_status_resp
> + */
> +#define OPTEE_RPMI_ENABLE_ASYNC_NOTIF  4
> +
> +/**
> + * struct optee_rpmi_enable_notif_req - bind an incoming RPMI doorbell
> + * @op: OPTEE_RPMI_ENABLE_ASYNC_NOTIF
> + * @signal_id: allocated TEE-to-REE signal, not a logical notification k=
ey
> + *
> + * Success activates delivery and raises the doorbell for pending work.
> + * Raising the signal requests OPTEE_MSG_CMD_DO_BOTTOM_HALF.
> + * OPTEE_MSG_CMD_STOP_ASYNC_NOTIF stops future doorbell generation, but =
does
> + * not drain already-raised signals or release the signal ID.
> + */
> +struct optee_rpmi_enable_notif_req {
> +       __le32 op;
> +       __le32 signal_id;
> +} __packed;
> +
> +/*
> + * Start a yielding command using shared command and RPC arguments.
> + *
> + * Request:  struct optee_rpmi_call_req
> + * Response: struct optee_rpmi_call_resp
> + */
> +#define OPTEE_RPMI_YIELDING_CALL_WITH_ARG              5
> +
> +#define OPTEE_RPMI_YIELDING_CALL_RETURN_DONE           0
> +#define OPTEE_RPMI_YIELDING_CALL_RETURN_RPC_CMD                1
> +#define OPTEE_RPMI_YIELDING_CALL_RETURN_INTERRUPT      2
> +
> +/**
> + * struct optee_rpmi_call_req - start a yielding command
> + * @op: OPTEE_RPMI_YIELDING_CALL_WITH_ARG
> + * @parcel_id: argument parcel identity
> + * @nonce: nonce associated with the parcel
> + * @flags: zero in version 1
> + * @arg_offset: command argument byte offset from the parcel's first byt=
e
> + * @rpc_offset: RPC argument byte offset from the parcel's first byte
> + * @arg_size: command argument extent in bytes
> + * @rpc_size: RPC argument capacity in bytes
> + *
> + * Firmware validates ownership, RW access, alignment and disjoint range=
s.
> + * RPMI_ERR_BUSY rejects an initial request without acquiring call owner=
ship.
> + */
> +struct optee_rpmi_call_req {
> +       __le32 op;
> +       __le32 parcel_id;
> +       __le32 nonce;
> +       __le32 flags;
> +       __le64 arg_offset;
> +       __le64 rpc_offset;
> +       __le32 arg_size;
> +       __le32 rpc_size;
> +} __packed;
> +
> +/**
> + * struct optee_rpmi_call_resp - yielding command response
> + * @status: signed RPMI error code, distinct from the command's GP resul=
t
> + * @result: OPTEE_RPMI_YIELDING_CALL_RETURN_* value when status is succe=
ss
> + * @resume_token: zero for DONE, nonzero opaque token for a suspended co=
mmand
> + *
> + * DONE releases all access to the call's argument and RPC ranges. RPC_C=
MD
> + * requests RPC command handling; INTERRUPT requests resumption without =
an
> + * RPC command. Tokens belong to one accepted call, service and caller.
> + */
> +struct optee_rpmi_call_resp {
> +       __le32 status;
> +       __le32 result;
> +       __le64 resume_token;
> +} __packed;
> +
> +/*
> + * Resume a suspended yielding command.
> + *
> + * Request:  struct optee_rpmi_resume_req
> + * Response: struct optee_rpmi_call_resp
> + */
> +#define OPTEE_RPMI_YIELDING_CALL_RESUME        6
> +
> +/**
> + * struct optee_rpmi_resume_req - resume a suspended command
> + * @op: OPTEE_RPMI_YIELDING_CALL_RESUME
> + * @reserved: must be zero
> + * @resume_token: token from the preceding response for this call
> + *
> + * Resume must not return RPMI_ERR_BUSY.
> + */
> +struct optee_rpmi_resume_req {
> +       __le32 op;
> +       __le32 reserved;
> +       __le64 resume_token;
> +} __packed;
> +
> +#endif /* OPTEE_RPMI_H */
>
> --
> 2.34.1
>
