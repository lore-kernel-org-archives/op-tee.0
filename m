Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BC7CA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 08:21:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A123A454FC
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 08:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791447668;
	bh=f0QzkL7iQswY0wlcgPH9TLEqtFMDOW+G71b2GJY8Sj8=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=ydHcS4QOkcVJG8Wrohys3QeYJkVfb909eY0ZkZKBoxkkG7rjW3eaJHIACg83Nr4G4
	 EMvZSXsIyQ8UV+M7wzVV5QV3fTqBn3ndKXIrRWU65zQyC7UllgJRDChjsCq1BwMaQo
	 vOPY00wEm1axkiiFqw9F0Sl2zZj1ER19ADT0N1hmc9EIkvOdATpRfyHtDTvlP4Yi0d
	 xPc9ca0XGEPIcuUGSWKYel+4SsRn9gb8niETMRAJMHgDsV8tIiu0EY3OUIH8ssd+oV
	 QX7LAy18QDm5u99Nk46KmieQup3UG/HUlovLhcZ+gZRHgbS0gaZkiFgzKcd4XLSf4C
	 /DdX7KAA+cOIQ==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 5309A44E81
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 08:21:00 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z3Xks1Tr;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bMZVjSDo;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987Kcjx2686686
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 08:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zIB4cQl0exFGRFC8UdOd4HdHw0g8TKxWx5FsF8wd+Pc=; b=Z3Xks1TrD2dT/8/N
	RDEZSZpeaD/IwUNbfh4XNQ3ep+4y7TMI9VW8Lr7i20Rp5WLtt3T8mnz1/nq5T//F
	t37QKS6VJP76Rn9h0VYVfBWXg0zCwbsNQbLYWiWTqwMP3f5J43Znt/KbbeXXttzV
	D6X0kGqiVGukjbYFPqR8xtr4YMwNgF07/Szuf623dKnWrHzOfbix09uNGEv238TQ
	1pb9Uz+uqj6OPHpR1lob0L524GaUuIsjO1NFr3O9BtYJY4oqHJMCnhf28of3YUUL
	bjBPcfHhU8Md+V3gZyKFmQCAW3D8hjXmIF9HVCaNglLjMJRn3mvg9EocfijPj0yY
	UEQSCg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe41wt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 08:20:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc5f70c8dso566546785a.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 01:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791447659; cv=none;
        d=google.com; s=arc-20260327;
        b=VXCo0ji3DrrEPpuqHJclfdVtaRVVWyWWrR2itSpsoqpZq9QFoE5pMMCJxX92y6j9H1
         tMOI3alf4801tpNBRGKlW3yMypFNAv/oLCDQahhIk3bBN7ydo+Q5XbHqQ4FX2eA2DYce
         wXLCHnxNoJFCtzbyebbIoCUKPM91gSVLRjg8BNIo8+QUJiDpy/eZxcU6Yh93iVd/AhR6
         Iw2u9NQv2S4+M57B/Q7CINRKXb6EV1a0XuwyxoGdvVS1nM49c5g/YrTsxAf078L92i4y
         Q8zMmIyiCf+GWQ8G7WIuf/scAHd6M5sdjXvmoIcKV7R2+EZJfsJLOfyo/WY0WgLh6jut
         15LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zIB4cQl0exFGRFC8UdOd4HdHw0g8TKxWx5FsF8wd+Pc=;
        fh=rIujuVmw3T6Dt418T/nscEXLOxX1o6hkWBTqhndBV/8=;
        b=QDsCMOfXzwiS0/rGHcTBx1s/rXzoERbcPL3FFSVty8kdXQVzWhiYy5WnzLxFGrMN0D
         0sMHxZkTTah6i1ppZVxYNLaRBFP3riK+TmnOwmHPJ9b1Vn367hIGYMn8hHIuIzIUnwHT
         qYzONRbjtfc/+J06ZdApWUvtWA5daCvb2JHXcUV12YDf5VM00WvX/fbDh4lOIFFqANql
         2roZJYsWqifg8o1rVEE/o7Yjnr4G7+NFP9A7YJA253WVuvmLk1PxQQo5/Wz19N3MhhR0
         CNqSOVfCefObpNCgiAW3y9wx6RgLnDXIYPbJXA4x25Yp+jEXmFeiqJYqTdbVVqRunypP
         XQ8A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791447659; x=1792052459; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zIB4cQl0exFGRFC8UdOd4HdHw0g8TKxWx5FsF8wd+Pc=;
        b=bMZVjSDog/O5gE4K8+JUEykONOZEeMEHmXsxyGO7GVw/+NIEBipu1U3RhCE4XlGAtF
         wNt1fdHiqlQ9R1H5HBfYVtiX7VB5J+QwvNSKeNAcuzQSAGrE5nM9+SOoA4ne1QeVs0/U
         1eLFhKLzm0OTpgZCY5VObwTOXUTkTU4h5ufMAKF45xWs0sizWyp650wWKHGcyPC0zK8w
         ba1Su6w31+3EBHbSyQPc372CccKG8ONpNUcQVxPCLglFlUdUrnDa4yCPJ5k4M1q/C6ie
         JmSelLdvVxvYsYsgfRoM+tnnlPU6KNXSehQlrDtabbw8ytLhJ2qn8hhQDXTmtmjsQLEu
         mtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791447659; x=1792052459;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zIB4cQl0exFGRFC8UdOd4HdHw0g8TKxWx5FsF8wd+Pc=;
        b=SUTMRYrBg1t8ymWHkdn7oO5ybVrCz8waL/xyiedQKTzGud+Jfe7Ph+zrgKGmV2e5Cb
         Mifr+vH6mbKz/N30XwBau8uT0971Orn6MWSeevy4mdAhhV1LGv3Ju4laMCqhBl/OEtSf
         +qPF+6EsuHmjB+LCT/TBVD0YO9gLnLuCd7aWNSJSUMWDGhGuC1YvQoaJRu2D68+uCozv
         F9ADR8iQh6TxMq0ljnGyJRRoYpoooJ671IQEzEayhg3UyVmSXXk9JwZ9XYZGAm7S9GYm
         o+3dbhgrn6wEtrQyAaVvqWg2Up3mjcehpNURt+wKU5GN5ZWuE0En33bm4RomRrQNYLIT
         B3Lg==
X-Forwarded-Encrypted: i=1; AKwUvByGRUOdDxcDkDI+3s3cRYMVNDRwotGaCWCZpN0YG3JjtIc4F5tKe4AhcL8mbAjyLVY9jm86inM=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mLHC8N/VNCi5oXCgKFY2YAGxdaMwT1Dfu/68+pd233Ggo/rTX7
	NbOuOOvGKzf7c7mRjUEDs64GisLYeVHLhKOQqUREysJH/Ck4J2vahtIhT/zWaCwlQehC/ZSQksP
	c0JIssppLTesj7djkrPFgKdGwSnuHLGThWNf58MF7XgK9OEpSfIBpoAi6YyVV8BtwqASaF1skuL
	eVC7rbGyPAV6IUrc3Zoo18tfGWHpjoMFCNH4/itszcBpjhXxs=
X-Gm-Gg: AYBFou2miZrIu4jN0Z5Vq3oAgjVIwPUL+L0hXIAK3KW7EuE47dG1AFoaq0E6h0pps8l
	X1P0WMJstAqD/pPffOkrUVoxhhuZwjoWjJnKqHEHo8jYRS1xDMylREnilKpN9a7bpaGjip56QtY
	tqC5oWB8uBSZlSBM8krj5O9LxxubVpG+uUrb0ztxt9tDsZt7XYy2B5xPg=
X-Received: by 2002:a05:620a:2707:b0:93b:e9db:1bab with SMTP id af79cd13be357-93e9b7ec3damr815937685a.56.1791447658758;
        Thu, 08 Oct 2026 01:20:58 -0700 (PDT)
X-Received: by 2002:a05:620a:2707:b0:93b:e9db:1bab with SMTP id
 af79cd13be357-93e9b7ec3damr815933385a.56.1791447657991; Thu, 08 Oct 2026
 01:20:57 -0700 (PDT)
MIME-Version: 1.0
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
 <20261005-rpmi-tee-service-grp-dev-v2-7-72f222e23ec1@oss.qualcomm.com>
In-Reply-To: <20261005-rpmi-tee-service-grp-dev-v2-7-72f222e23ec1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 10:20:45 +0200
X-Gm-Features: AclHuK8VszX8MM8O8iN0SFhYNBrpC6tFcWm59t5pLqXff-TCJYx0we4frgkakhg
Message-ID: <CAGgiveU+8d-MmPL4n_ADimkrthsE1sU4QHJoBeh==sxLZmdrFw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 7/8] tee: optee: bind RPMI services and negotiate
 backend capabilities
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: XtnaIicSiQ43YQlLZhwqq2MfUIDHH75X
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac7526b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=G3rC2xmL4Tt6fuppFqwA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMyBTYWx0ZWRfX54C0KHhIxawc
 Uc2HcFqHbZmv0JTU0GG6BqFtiwdETGTYjlE9KLZUJl16IVwZsgago7/ZA/SiVM9BAnzedkSKGpL
 /BiVm068ZQNzT1uZRj5koNO4pAooIFs=
X-Proofpoint-ORIG-GUID: XtnaIicSiQ43YQlLZhwqq2MfUIDHH75X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMyBTYWx0ZWRfXzkE+yTjVUd/G
 +pmAcVM3VCyfbXU248iGO/e6a5CpbELOh8VYoIa6Cvo9vUX7I27HJlesnlFcCY1ezfIhFc3ZdV/
 mVDhAeZ8FalmJ2e7lb0iZhfxgsbshfodPCTBhUiVBqSpFj7QGWI1G5hR4tZq+enVRMZG774DotP
 6HZc2qFBpsqlPDSi9fyTFFHU6xIQiQGXc5cvPMbjmQtagILr55E0+V/8z3hBmnx9sJQTkxMp0lq
 V4CEl511aP1X+jBdIqZlHnn2DtZ8653bSwUA4IIxYZmweP/GEsd6kC5WBiOwZmV5G+SeYTiLZeD
 uLKh8WaLbhT5ksZsG8EkchjpRogquUzlbXDV18OJurG9d1pQw/6mvIohj7jYGXNxU7eNIo0iWGk
 0zKJUrv4zmvNDNBTqtckeDBKrGtct0hcChnGB0AIua/inH6Fb1I46IQw7DKJRltJYO7eM3XZKnl
 IytIw7pM63u2X5ZLQ4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080033
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.222.198:received];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 5309A44E81
X-Spamd-Bar: -----
Message-ID-Hash: WDL32WS47XSV3WTXLB6NZBV2NBMK6FCD
X-Message-ID-Hash: WDL32WS47XSV3WTXLB6NZBV2NBMK6FCD
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WDL32WS47XSV3WTXLB6NZBV2NBMK6FCD/>
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
> Register an RPMI service driver matching the OP-TEE service UUID and
> integrate it with OP-TEE module initialization and removal.
>
> Check the service API version, query the trusted OS revision, and
> obtain the RPC parameter and logical notification counts. Initialize
> shared-memory tracking, the call queue, supplicant state and internal
> context before publishing the client and supplicant TEE devices.
>
> Connect the RPMI backend to the common OP-TEE operations and enumerate
> trusted application devices. Enable in-kernel RPMB routing when the
> RPMB subsystem is reachable.
>
> Add removal and probe failure cleanup for the backend resources.
>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/optee/core.c          |  10 +-
>  drivers/tee/optee/optee_private.h |  21 ++-
>  drivers/tee/optee/rpmi_abi.c      | 286 ++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 312 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index a52c1f498b99..8a44a25ebc66 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -220,6 +220,7 @@ void optee_remove_common(struct optee *optee)
>
>  static int smc_abi_rc;
>  static int ffa_abi_rc;
> +static int rpmi_abi_rc;
>  static bool intf_is_regged;
>
>  static int __init optee_core_init(void)
> @@ -245,14 +246,15 @@ static int __init optee_core_init(void)
>
>         smc_abi_rc =3D optee_smc_abi_register();
>         ffa_abi_rc =3D optee_ffa_abi_register();
> +       rpmi_abi_rc =3D optee_rpmi_abi_register();
>
> -       /* If both failed there's no point with this module */
> -       if (smc_abi_rc && ffa_abi_rc) {
> +       /* Keep the module if any supported transport registered successf=
ully. */
> +       if (smc_abi_rc && ffa_abi_rc && rpmi_abi_rc) {
>                 if (IS_REACHABLE(CONFIG_RPMB)) {
>                         rpmb_interface_unregister(&rpmb_class_intf);
>                         intf_is_regged =3D false;
>                 }
> -               return smc_abi_rc;
> +               return -EOPNOTSUPP;
>         }
>
>         return 0;
> @@ -270,6 +272,8 @@ static void __exit optee_core_exit(void)
>                 optee_smc_abi_unregister();
>         if (!ffa_abi_rc)
>                 optee_ffa_abi_unregister();
> +       if (!rpmi_abi_rc)
> +               optee_rpmi_abi_unregister();
>  }
>  module_exit(optee_core_exit);
>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index 2422caf3c883..07c27e322a71 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -188,6 +188,8 @@ struct rpmi_tee_device;
>   * @rdev: owning RPMI service device
>   * @shm_rht_lock: protects parcel lookup, insertion, removal and publica=
tion
>   * @shm_rht: lookup by the host-endian parcel ID and nonce pair
> + * @sec_caps: negotiated optional OPTEE_RPMI_CAP_* features
> + * @notification_count: negotiated nonzero number of logical notificatio=
n keys
>   *
>   * Callers keep their tee_shm alive while using its registration. Lookup
>   * returns a raw pointer; the mutex does not protect its lifetime after
> @@ -199,6 +201,8 @@ struct optee_rpmi {
>         /* Protects parcel lookup, insertion, removal and publication. */
>         struct mutex shm_rht_lock;
>         struct rhashtable shm_rht;
> +       u32 sec_caps;
> +       u32 notification_count;

Why are these two needed?

>  };
>  #endif
>
> @@ -211,8 +215,8 @@ struct optee;
>   * @os_build_id:       OP-TEE OS build identifier (0 if unspecified)
>   *
>   * Values come from OPTEE_SMC_CALL_GET_OS_REVISION (SMC ABI) or
> - * OPTEE_FFA_GET_OS_VERSION (FF-A ABI); this is the trusted OS revision,=
 not an
> - * FF-A ABI version.
> + * OPTEE_FFA_GET_OS_VERSION (FF-A ABI) or OPTEE_RPMI_GET_OS_VERSION (RPM=
I ABI).
> + * This is the trusted OS revision, not a transport ABI version.
>   */
>  struct optee_revision {
>         u32 os_major;
> @@ -490,5 +494,18 @@ static inline void optee_ffa_abi_unregister(void)
>  }
>  #endif
>
> +#if IS_REACHABLE(CONFIG_RISCV_RPMI_TEE_TRANSPORT)
> +int optee_rpmi_abi_register(void);
> +void optee_rpmi_abi_unregister(void);
> +#else
> +static inline int optee_rpmi_abi_register(void)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void optee_rpmi_abi_unregister(void)
> +{
> +}
> +#endif
>
>  #endif /*OPTEE_PRIVATE_H*/
> diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
> index 6e76316794c1..db541f3de425 100644
> --- a/drivers/tee/optee/rpmi_abi.c
> +++ b/drivers/tee/optee/rpmi_abi.c
> @@ -684,3 +684,289 @@ static int optee_rpmi_do_call_with_arg(struct tee_c=
ontext *ctx,
>
>         return optee_rpmi_yielding_call(ctx, &req, rpc_arg, system_thread=
);
>  }
> +
> +/* Query and store the trusted OS revision. */
> +static int optee_rpmi_get_os_version(struct optee *optee)
> +{
> +       struct optee_rpmi_probe_req req =3D {
> +               .op =3D cpu_to_le32(OPTEE_RPMI_GET_OS_VERSION),
> +       };
> +       struct optee_rpmi_os_resp os;
> +       int ret;
> +
> +       ret =3D optee_rpmi_call(optee, &req, sizeof(req), &os, sizeof(os)=
);
> +       if (ret)
> +               return ret;
> +
> +       optee->revision.os_major =3D get_unaligned_le32(&os.major);
> +       optee->revision.os_minor =3D get_unaligned_le32(&os.minor);
> +       optee->revision.os_build_id =3D get_unaligned_le64(&os.build_id);
> +
> +       if (optee->revision.os_build_id)
> +               pr_info("revision %u.%u (%016llx)\n",
> +                       optee->revision.os_major, optee->revision.os_mino=
r,
> +                       optee->revision.os_build_id);
> +       else
> +               pr_info("revision %u.%u\n", optee->revision.os_major,
> +                       optee->revision.os_minor);
> +
> +       return 0;
> +}
> +
> +/* Query and store secure-world capabilities and buffer limits. */
> +static int optee_rpmi_exchange_caps(struct optee *optee)
> +{
> +       struct optee_rpmi_probe_req req =3D {
> +               .op =3D cpu_to_le32(OPTEE_RPMI_EXCHANGE_CAPABILITIES),
> +       };
> +       struct optee_rpmi_caps_resp caps;
> +       u32 rpc_count, sec_caps, notif_count;
> +       int ret;
> +
> +       ret =3D optee_rpmi_call(optee, &req, sizeof(req), &caps, sizeof(c=
aps));
> +       if (ret)
> +               return ret;
> +
> +       sec_caps =3D get_unaligned_le32(&caps.secure_caps);
> +       rpc_count =3D get_unaligned_le32(&caps.rpc_param_count);
> +       notif_count =3D get_unaligned_le32(&caps.notification_count);
> +       if (!notif_count || !rpc_count)
> +               return -EPROTO;
> +
> +       optee->rpc_param_count =3D rpc_count;
> +       optee->rpmi.sec_caps =3D sec_caps;
> +       optee->rpmi.notification_count =3D notif_count;
> +       optee->in_kernel_rpmb_routing =3D IS_REACHABLE(CONFIG_RPMB);

What if OP-TEE is built without RPMB support?

> +
> +       return 0;
> +}
> +
> +static int optee_rpmi_api_is_compatible(struct optee *optee)
> +{
> +       struct optee_rpmi_probe_req req =3D {
> +               .op =3D cpu_to_le32(OPTEE_RPMI_GET_API_VERSION),
> +       };
> +       struct optee_rpmi_api_resp api;
> +       int ret;
> +
> +       ret =3D optee_rpmi_call(optee, &req, sizeof(req), &api, sizeof(ap=
i));
> +       if (ret)
> +               return ret;
> +
> +       if (get_unaligned_le32(&api.major) !=3D OPTEE_RPMI_VERSION_MAJOR)
> +               return -EPROTONOSUPPORT;
> +
> +       /* Version 1.0 has no minimum minor revision beyond zero. */
> +       return 0;
> +}
> +
> +static void optee_rpmi_get_version(struct tee_device *teedev,
> +                                  struct tee_ioctl_version_data *vers)
> +{
> +       *vers =3D (struct tee_ioctl_version_data) {
> +               .impl_id =3D TEE_IMPL_ID_OPTEE,
> +               .gen_caps =3D TEE_GEN_CAP_GP | TEE_GEN_CAP_REG_MEM |
> +                           TEE_GEN_CAP_MEMREF_NULL,
> +       };
> +}
> +
> +static int optee_rpmi_open(struct tee_context *ctx)
> +{
> +       return optee_open(ctx, true);
> +}
> +
> +static const struct tee_driver_ops optee_rpmi_clnt_ops =3D {
> +       .get_version =3D optee_rpmi_get_version,
> +       .get_tee_revision =3D optee_get_revision,
> +       .open =3D optee_rpmi_open,
> +       .release =3D optee_release,
> +       .open_session =3D optee_open_session,
> +       .close_session =3D optee_close_session,
> +       .invoke_func =3D optee_invoke_func,
> +       .cancel_req =3D optee_cancel_req,
> +       .shm_register =3D optee_rpmi_shm_register,
> +       .shm_unregister =3D optee_rpmi_shm_unregister,
> +};
> +
> +static const struct tee_driver_ops optee_rpmi_supp_ops =3D {
> +       .get_version =3D optee_rpmi_get_version,
> +       .get_tee_revision =3D optee_get_revision,
> +       .open =3D optee_rpmi_open,
> +       .release =3D optee_release_supp,
> +       .supp_recv =3D optee_supp_recv,
> +       .supp_send =3D optee_supp_send,
> +       .shm_register =3D optee_rpmi_shm_register,
> +       .shm_unregister =3D optee_rpmi_shm_unregister_supp,
> +};
> +
> +static const struct tee_desc optee_rpmi_clnt_desc =3D {
> +       .name =3D DRIVER_NAME "-rpmi-clnt",
> +       .ops =3D &optee_rpmi_clnt_ops,
> +       .owner =3D THIS_MODULE,
> +};
> +
> +static const struct tee_desc optee_rpmi_supp_desc =3D {
> +       .name =3D DRIVER_NAME "-rpmi-supp",
> +       .ops =3D &optee_rpmi_supp_ops,
> +       .owner =3D THIS_MODULE,
> +       .flags =3D TEE_DESC_PRIVILEGED,
> +};
> +
> +static const struct optee_ops optee_rpmi_ops =3D {
> +       .do_call_with_arg =3D optee_rpmi_do_call_with_arg,
> +       .to_msg_param =3D optee_rpmi_to_msg_param,
> +       .from_msg_param =3D optee_rpmi_from_msg_param,
> +};
> +
> +/* Keep callback state and memory tables alive until all TEE users relea=
se. */
> +static void optee_rpmi_remove(struct rpmi_tee_device *rdev)
> +{
> +       struct optee *optee =3D dev_get_drvdata(&rdev->dev);
> +
> +       optee_remove_common(optee);
> +       optee_rpmi_shm_rht_uninit(optee);
> +       kfree(optee);
> +}
> +
> +static int optee_rpmi_probe(struct rpmi_tee_device *rdev)
> +{
> +       struct tee_device *teedev;
> +       struct tee_context *ctx;
> +       int ret;
> +
> +       struct optee *optee __free(kfree) =3D kzalloc_obj(*optee);

The cleanup macros should, if I understand it correctly, not be used
in functions using gotos for cleanup.

> +       if (!optee)
> +               return -ENOMEM;
> +
> +       optee->rpmi.rdev =3D rdev;
> +       optee->ops =3D &optee_rpmi_ops;
> +
> +       ret =3D optee_rpmi_api_is_compatible(optee);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D optee_rpmi_get_os_version(optee);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D optee_rpmi_exchange_caps(optee);
> +       if (ret)
> +               return ret;
> +
> +       optee->pool =3D optee_rpmi_shm_pool_alloc();

Perhaps it's just me, but it seems a bit odd to store an err pointer
in a struct like this.

> +       if (IS_ERR(optee->pool))
> +               return PTR_ERR(optee->pool);
> +
> +       ret =3D optee_rpmi_shm_rht_init(optee);
> +       if (ret)
> +               goto err_pool;
> +
> +       optee_cq_init(&optee->call_queue, 0);
> +       optee_supp_init(&optee->supp);
> +       optee_shm_arg_cache_init(optee, OPTEE_SHM_ARG_SHARED);
> +       mutex_init(&optee->rpmb_dev_mutex);
> +       INIT_WORK(&optee->rpmb_scan_bus_work, optee_bus_scan_rpmb);
> +       optee->rpmb_intf.notifier_call =3D optee_rpmb_intf_rdev;
> +       ret =3D optee_notif_init(optee, optee->rpmi.notification_count);
> +       if (ret)
> +               goto err_common;
> +
> +       /* Allocate all keys, then restrict the inclusive bound to the la=
st key. */
> +       optee->notif.max_key =3D optee->rpmi.notification_count - 1;

Why? Do you have any plans for that?

Cheers,
Jens

> +
> +       teedev =3D tee_device_alloc(&optee_rpmi_clnt_desc, &rdev->dev,
> +                                 optee->pool, optee);
> +       if (IS_ERR(teedev)) {
> +               ret =3D PTR_ERR(teedev);
> +               goto err_notif;
> +       }
> +       optee->teedev =3D teedev;
> +
> +       teedev =3D tee_device_alloc(&optee_rpmi_supp_desc, &rdev->dev,
> +                                 optee->pool, optee);
> +       if (IS_ERR(teedev)) {
> +               ret =3D PTR_ERR(teedev);
> +               goto err_devices;
> +       }
> +       optee->supp_teedev =3D teedev;
> +
> +       optee_set_dev_group(optee);
> +
> +       /* Internal RPC allocation must be ready before userspace can ent=
er. */
> +       ctx =3D teedev_open(optee->teedev);
> +       if (IS_ERR(ctx)) {
> +               ret =3D PTR_ERR(ctx);
> +               goto err_devices;
> +       }
> +
> +       optee->ctx =3D ctx;
> +       dev_set_drvdata(&rdev->dev, optee);
> +       if (optee->in_kernel_rpmb_routing)
> +               blocking_notifier_chain_register(&optee_rpmb_intf_added,
> +                                                &optee->rpmb_intf);
> +
> +       ret =3D tee_device_register(optee->teedev);
> +       if (ret)
> +               goto err_initialized;
> +
> +       ret =3D tee_device_register(optee->supp_teedev);
> +       if (ret)
> +               goto err_initialized;
> +
> +       ret =3D optee_enumerate_devices(PTA_CMD_GET_DEVICES);
> +       if (ret)
> +               goto err_initialized;
> +
> +       dev_info(&rdev->dev, "OP-TEE RPMI %u.%u initialized\n",
> +                optee->revision.os_major, optee->revision.os_minor);
> +       retain_and_null_ptr(optee);
> +
> +       return 0;
> +
> +err_initialized:
> +       /* The remove path owns and frees the published backend state. */
> +       retain_and_null_ptr(optee);
> +       optee_rpmi_remove(rdev);
> +
> +       return ret;
> +err_devices:
> +       tee_device_unregister(optee->supp_teedev);
> +       tee_device_unregister(optee->teedev);
> +       optee_shm_arg_cache_uninit(optee);
> +err_notif:
> +       optee_notif_uninit(optee);
> +err_common:
> +       optee_supp_uninit(&optee->supp);
> +       mutex_destroy(&optee->call_queue.mutex);
> +       rpmb_dev_put(optee->rpmb_dev);
> +       mutex_destroy(&optee->rpmb_dev_mutex);
> +       optee_rpmi_shm_rht_uninit(optee);
> +err_pool:
> +       tee_shm_pool_free(optee->pool);
> +
> +       return ret;
> +}
> +
> +static const struct rpmi_tee_device_id optee_rpmi_device_ids[] =3D {
> +       { OPTEE_RPMI_SERVICE_UUID },
> +       {}
> +};
> +
> +static struct rpmi_tee_driver optee_rpmi_driver =3D {
> +       .name =3D DRIVER_NAME "-rpmi",
> +       .probe =3D optee_rpmi_probe,
> +       .remove =3D optee_rpmi_remove,
> +       .id_table =3D optee_rpmi_device_ids,
> +};
> +
> +int optee_rpmi_abi_register(void)
> +{
> +       return rpmi_tee_register(&optee_rpmi_driver);
> +}
> +
> +void optee_rpmi_abi_unregister(void)
> +{
> +       rpmi_tee_unregister(&optee_rpmi_driver);
> +}
> +
> +MODULE_ALIAS("rpmi_tee:486178e0-e7f8-11e3-bc5e-0002a5d5c51b");
>
> --
> 2.34.1
>
