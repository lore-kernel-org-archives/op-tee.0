Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E45CA6007
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 08:11:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A03D244E81
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 08:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791447111;
	bh=D7UiphtT6EBwO/k/ikf2NWjb/RYMvUOnxloV2AvhWw0=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=06Wn0maS3ssSV42VPDD/d5hg9r96IifEKUUFfNCJbMa6+c6O8C0AVc+ASTdO7a0Tz
	 TDHhxERqtkS7aVmxissgzShQU3ViJ5FImyo0GlWhMbMlijGVLQmz5ZtE/C0AysPS+c
	 Hkh2GH06wshDSrYYhrenMemD+LL4M2lKZxMj+pY3qbeEHaWb5pap2XA2dWhX2j0vnv
	 LcSFU3TtTpQh1QIgGX5bhm3tAyvO73W0cFe/o3sry7P6azn8BFGp/b6QaamMcx7L54
	 DmwQFLsQz9999JCSfUoFh3wxwY2qX1XerwnWZ/IBT7A1DAIN3dmt357Jc8WpRSwN/+
	 w5icE4SXBsMCA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A313C44E81
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 08:11:43 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lvENMn6W;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y0d1TNQM;
	dkim-atps=neutral
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987KaXa730846
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 08:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JItcqZCTTZ5Tr3DrlkTjE4P6dQhLoTOAQJPbjV6HDlQ=; b=lvENMn6WoMDZJeJH
	01RdZR9gO8z+f/cXd2he/jnQUB2R8Xqeb3nw4iaPPwOttG3a26yJqZCpdD3uhOsG
	9dv454H28YeDbtIDbJNw6vmfZe4Pp5/SWvOyXQv2DddRCN/p72q60CHRngiL0nm0
	HB7i3KeAdrgd16ZFXWONK4Hegqyx/Y7hBTujduBGtoQ+dcdHkZDg1pfJ5EOtEV2W
	4j/FDmq0kxszm3QUrral1g168QvpxlWcIOeqN0QaNOVDJnoEii9Q+ZI7XqOIN/XR
	xK8GVS0+tg/72OYeqfInTymZIClV2yHOpJiJyt5ruO+0LNj3iymWfDmUjuakz/3j
	Scwa8g==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe31tku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 08:11:42 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-676956fd276so6953709d50.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 01:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791447101; cv=none;
        d=google.com; s=arc-20260327;
        b=hPHIO6iIMco7j49dxc28a1QwA+Vs+z/XDnmzLDtQP+sqkD/3YVi5DQUd7AI3+QdgkV
         5RaexNhkrw8n60Jw7iTBk53/lXO6GJ636aJ/qRnjtJ/DEmyARnk4GRd6JWK5RZCzMlQC
         R+8pw8UmuZVwsyVShd5JVjEhL226jqglIdjKpCiri4Kzk9wWzv2AHxt8t318oSUPhXiD
         n+9NEOlaY8hMRRe+uRSng2pFdre2aDNx5Tw2OOKsupB5QP11Ejym2O0REuTBorv1Jj3U
         c5N0/U5/NDxcUVDY3l08Tt2WQSID5Nv9Vs7SZfS0yzRyt+/05DJh5pbWuVlY+Cy/+vwt
         gE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JItcqZCTTZ5Tr3DrlkTjE4P6dQhLoTOAQJPbjV6HDlQ=;
        fh=gKUS0l5fSCpD1LygHHLikXOp3PCXrQfJv/BaXUDX2J0=;
        b=c+w+Lzyx9YSNazmzbHHo74/2gxaDyoxJ8CVPOPrwYwQST7JDoDWBrWLK6zRMZjL8yH
         Jb7hdIcMgPGEdHz6SlhCWu2Duu2OvmRflrll/zlMn1ft7WxpH49o1iBIJ1dRL9KYQyLg
         AUm5/vMGEyyisZcCztZYn1y/m79KEq2SxBCzmKWdB2nvJEmBjQqF+6sPm5LqwNGpS7nv
         Ndbnhgncy/wdTz/vd0kvImlhjAhlwt9cpq+oxWE49jBGEQaAtkfbWZaTQ13bs6WeRXE+
         gsQyfIOSp/pUi3//q9fCEhRxxN/CXgUUexotfxjICcGBLmiuvB4YjjHe1Pv79hXJe6ZS
         7o+Q==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791447101; x=1792051901; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JItcqZCTTZ5Tr3DrlkTjE4P6dQhLoTOAQJPbjV6HDlQ=;
        b=Y0d1TNQMfDHYBt8KbGIbAkJfryUBO9C5rwUutz8+7Uu2DmeBKdowgATV2jZgU3Q75G
         yik4Bn3Bjo55BSKxPzmopWpbn5+kVQ9s9yfq8Qu0KEt0hUFmiverpkKAGKIuNv++7r1E
         4RzLZylbTfK6HPOIcDm/+1rJBZCWOZhDXrokH9bwHvwbGEODcimuy6YPgpsZwutqRaGV
         CYt5NrlEUVwSnpg90rcKmSs+Xgt4u0YxKKgDJVY0GUx/BHyewttVXfCawW2x8PIF5xhT
         5FpfMKN6H+mQwCG/PZc6mAJV6t2gl6yf4+ugOjRtIWmkXaJ9aMcqAXdu4H5+J102J9an
         14qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791447101; x=1792051901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JItcqZCTTZ5Tr3DrlkTjE4P6dQhLoTOAQJPbjV6HDlQ=;
        b=bpM7PosQ66TEITeO70AdBTvDTnnuKVBuxwRQoIa0EqECsNa+vFW5ahcxCot0a/A3+/
         Eh1cvBjtbkr5v+TAMtK1RkqYq1Y43sh8eVSvbmAJQxGm9XrL0XUCGYHTL67Q9jL/leoR
         7GMSTZNXpUC/6Ru69PoezVuCtaUCCUsYA4/Izf9tiSy2ddyYkaebzgiAgYZnJYO760ia
         kY0Q6e+hTJQHLV5BEXM7nTc0gBJuE8/g8MTMcUMO1je3i7Rtm5dnecXpiSBkIDkvUrZP
         TDrbi7+ywz7iviwS7O+4hRNN3E/HGnXITWVVtujGRc28VEEVyVMB/FVX8f5R3EdEAM1r
         rLlQ==
X-Forwarded-Encrypted: i=1; AKwUvBywAuRk5VhSQ5ILucljnmF351nXFdPy7g8aThSKuw7Yt7UkCwvk84wXqIaRnweb+rYHckmErAk=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYL5bObejdCykjoUT9xkqKYZztAYBXUCZ1/dRV+dLChOKqM+qu/S
	yJhDyVNUqjG7jYvEgWU+XSqHCIdGUAi/8Ma22KsFJDRsYx26Q8u+LR0KEtO3rV3zkCDOiFxjEZ5
	XGxTogxM8q1n4xAG43J+SU3Ci8TVMVJL2pJHNqzDw/6KTnYKVEUTqCjEDCNIqtLb5O1xZb67HTp
	+NV+nnGs1ME8QxKQ8Smf+Kd6acD2qRDqtbyAgbpNGbuzqKuX0=
X-Gm-Gg: AYBFou2xKyKA42HVTXVnn3NiXLchwzeZ6hraLBCwto55MTyS9etRQrumRoG9Z8wPWeq
	qYaHWYTfWw7612+TcVGXh/rXfYMakWk40BKI8DHQXfv2O+A8NjsLHe8W6h7QUemAGd8JFsmpmwV
	2gXMaQl/dMgn4mhpnXsxEsmMqd1gxz4gKxTncfwomzkgl8NG/PT4m+0FQ=
X-Received: by 2002:a05:690e:43d1:b0:677:d251:ccb2 with SMTP id 956f58d0204a3-6790a3ba2b6mr1617784d50.15.1791447101133;
        Thu, 08 Oct 2026 01:11:41 -0700 (PDT)
X-Received: by 2002:a05:690e:43d1:b0:677:d251:ccb2 with SMTP id
 956f58d0204a3-6790a3ba2b6mr1617763d50.15.1791447100494; Thu, 08 Oct 2026
 01:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
 <20261005-rpmi-tee-service-grp-dev-v2-6-72f222e23ec1@oss.qualcomm.com>
In-Reply-To: <20261005-rpmi-tee-service-grp-dev-v2-6-72f222e23ec1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 10:11:29 +0200
X-Gm-Features: AclHuK_ulwLbOdiOwhVLyKYI0w-jUZto9bQrzFykzb9tv-znqnJpL93tMSNQoQQ
Message-ID: <CAGgiveUzBk0Na13cqPRnQw8y2XdQ9LLktFK5eaJLTMiQZJPc_w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 6/8] tee: optee: execute yielding RPMI calls
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfXwJSyHK174K5U
 fC5HOIq8lqmwV026u2TAtQH7dVEurcXOJYWLiTnFH/wnUEeBi1QPrbpvuQ+vQpZ1xHpcmbMKm2G
 u9V+9DTTqHlFyg4gwo8x0pQrAq1GepL7RNZ0WPv7SBzeyu4XH7fvounC4H/e7VjzOmtrYS6Sph+
 3du+p4a2lJkDmDyHN764PqlEXPNiJNXKYYuysi58GyvIVNflGiBrWL4pdUANckeJZ+Gy4k7pngZ
 GxoUWE7TxlhYfjMJSKxiQA4IuJxP/UdlTRcBynlcDRhStosHNLxUsTgQwZ6vyW8V2P/0ilrNK/e
 oHB2CqdB5InH2m5VYRHzJFYFOoTvaTTffF55kO2P3pCj+vrRTQCsH8BC+y2jYfBBG1BX5cV1FVA
 rfrPFFW32jkyaFqb3QCJ3gK4Ekl2Gb4b5w9rQOU0CxYqbadUxIIyyyJ5ie/ZR8MB2ijZNWpV30/
 JWpIbKbFaQo0fJXxwkw==
X-Proofpoint-ORIG-GUID: ClOQ8fMl0liPtJ5DJlsSxO8MxgWhKflD
X-Proofpoint-GUID: ClOQ8fMl0liPtJ5DJlsSxO8MxgWhKflD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX4KtAYT7uaQDY
 raC6ZzPC1ukQsy7Z2LdRUdVAVLu37xTyZUDUlMSpK3yRhX6541KzWSfquvm/9PRtOhyk8ylL01r
 fs6LGTnACcsV1Y+gq/drSu5y8nxdNXI=
X-Authority-Analysis: v=2.4 cv=KcdHIgYD c=1 sm=1 tr=0 ts=6ac7503e cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=ErwVIQJsGMf6Wn3gpasA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[dt];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A313C44E81
X-Spamd-Bar: -----
Message-ID-Hash: OKJYOJP44EROENK7AR3XK2HII335552Z
X-Message-ID-Hash: OKJYOJP44EROENK7AR3XK2HII335552Z
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OKJYOJP44EROENK7AR3XK2HII335552Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

On Tue, Oct 6, 2026 at 2:40=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> OP-TEE commands can span multiple exchanges with normal world. A call
> may yield to request an RPC service or allow interrupt processing
> before continuing execution in secure world.
>
> Add the RPMI yielding-call path used by the common OP-TEE session
> operations. Submit the command and RPC argument buffers as ranges
> within a shared memory parcel.
>
> Handle RPC requests while the call is suspended and resume execution
> using the token returned by OP-TEE until the command completes.
>
> Use the common OP-TEE call queue to wait when an initial request is
> rejected with RPMI_ERR_BUSY, allowing another active call to complete
> before retrying.
>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  drivers/tee/optee/rpmi_abi.c | 124 +++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 124 insertions(+)
>
> diff --git a/drivers/tee/optee/rpmi_abi.c b/drivers/tee/optee/rpmi_abi.c
> index 58d82678be98..6e76316794c1 100644
> --- a/drivers/tee/optee/rpmi_abi.c
> +++ b/drivers/tee/optee/rpmi_abi.c
> @@ -9,6 +9,7 @@
>  #include <linux/mailbox/riscv-rpmi-message.h>
>  #include <linux/overflow.h>
>  #include <linux/rpmi_tee.h>
> +#include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/unaligned.h>
>  #include "optee_private.h"
> @@ -560,3 +561,126 @@ static void optee_rpmi_handle_rpc_cmd(struct tee_co=
ntext *ctx,
>                 optee_rpc_cmd(ctx, optee, arg);
>         }
>  }
> +
> +/* Handle RPC command or interrupt returns from a yielding call. */
> +static void optee_rpmi_handle_rpc(struct tee_context *ctx, struct optee =
*optee,
> +                                 u32 result, struct optee_msg_arg *arg)
> +{
> +       switch (result) {
> +       case OPTEE_RPMI_YIELDING_CALL_RETURN_RPC_CMD:
> +               optee_rpmi_handle_rpc_cmd(ctx, optee, arg);
> +               break;
> +       case OPTEE_RPMI_YIELDING_CALL_RETURN_INTERRUPT:
> +               break;
> +       default:
> +               pr_warn("Unknown RPC func 0x%x\n", result);
> +               break;
> +       }
> +}
> +
> +/**
> + * optee_rpmi_yielding_call() - submit and resume a yielding RPMI comman=
d
> + * @ctx: calling context
> + * @req: initial command request
> + * @rpc_arg: shared RPC argument buffer
> + * @system_thread: caller requests TEE system thread support
> + *
> + * Only RPMI_ERR_BUSY rejection of the initial command permits retry.
> + *
> + * Return: zero on completion, or a negative error.
> + */
> +static int optee_rpmi_yielding_call(struct tee_context *ctx,
> +                                   const struct optee_rpmi_call_req *req=
,
> +                                   struct optee_msg_arg *rpc_arg,
> +                                   bool system_thread)
> +{
> +       struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> +       struct optee_rpmi_resume_req resume =3D {
> +               .op =3D cpu_to_le32(OPTEE_RPMI_YIELDING_CALL_RESUME),
> +               /* resume_token is nonzero after OP-TEE suspends the call=
. */
> +               .resume_token =3D 0,

I missed this when reviewing "tee: optee: define the RPMI control and
parcel-reference ABI". I'd prefer if the resume_token was a truly
opaque value, just as for the SMC and FF-A ABIs. Any reason why it's a
64-bit value instead of 32-bit, as is used for the other ABI?

> +       };
> +       struct optee_rpmi_call_resp resp;
> +       struct optee_call_waiter waiter;
> +       u32 result;
> +       s32 status;
> +       int ret;
> +
> +       optee_cq_wait_init(&optee->call_queue, &waiter, system_thread);
> +       while (true) {
> +               if (resume.resume_token)
> +                       ret =3D optee_rpmi_call_with_status(optee, &resum=
e,
> +                                                         sizeof(resume),=
 &resp,
> +                                                         sizeof(resp), &=
status);
> +               else
> +                       ret =3D optee_rpmi_call_with_status(optee, req, s=
izeof(*req),
> +                                                         &resp, sizeof(r=
esp),
> +                                                         &status);

Please fix the too-long lines above.

> +               if (ret)
> +                       goto done;
> +
> +               switch (status) {
> +               case RPMI_SUCCESS:

Any particular reason why we aren't using TEE error codes here?

> +                       break;
> +               case RPMI_ERR_BUSY:
> +                       if (!resume.resume_token) {
> +                               optee_cq_wait_for_completion(&optee->call=
_queue,
> +                                                            &waiter);
> +                               continue;
> +                       }
> +
> +                       fallthrough;
> +               default:
> +                       ret =3D rpmi_to_linux_error(status);
> +                       goto done;
> +               }
> +
> +               result =3D get_unaligned_le32(&resp.result);

Why not le32_to_cpu(resp.result)?

Cheers,
Jens

> +               if (result =3D=3D OPTEE_RPMI_YIELDING_CALL_RETURN_DONE)
> +                       goto done;
> +
> +               cond_resched();
> +               optee_rpmi_handle_rpc(ctx, optee, result, rpc_arg);
> +
> +               resume.resume_token =3D resp.resume_token;
> +       }
> +done:
> +       optee_cq_wait_final(&optee->call_queue, &waiter);
> +
> +       return ret;
> +}
> +
> +/* The caller supplies SHM with room for command and RPC args. */
> +static int optee_rpmi_do_call_with_arg(struct tee_context *ctx,
> +                                      struct tee_shm *shm, u_int offs,
> +                                      bool system_thread)
> +{
> +       struct optee *optee =3D tee_get_drvdata(ctx->teedev);
> +       struct optee_msg_arg *arg, *rpc_arg;
> +       struct optee_rpmi_call_req req;
> +       size_t arg_size, rpc_size, rpc_offset;
> +       u32 parcel_id, nonce;
> +
> +       arg =3D tee_shm_get_va(shm, offs);
> +       if (IS_ERR(arg))
> +               return PTR_ERR(arg);
> +
> +       arg_size =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> +       rpc_size =3D OPTEE_MSG_GET_ARG_SIZE(optee->rpc_param_count);
> +       rpc_offset =3D offs + arg_size;
> +       rpc_arg =3D tee_shm_get_va(shm, rpc_offset);
> +       if (IS_ERR(rpc_arg))
> +               return PTR_ERR(rpc_arg);
> +
> +       optee_rpmi_shm_get_identity(shm, &parcel_id, &nonce);
> +
> +       req.op =3D cpu_to_le32(OPTEE_RPMI_YIELDING_CALL_WITH_ARG);
> +       req.parcel_id =3D cpu_to_le32(parcel_id);
> +       req.nonce =3D cpu_to_le32(nonce);
> +       req.arg_offset =3D cpu_to_le64((u64)shm->offset + offs);
> +       req.rpc_offset =3D cpu_to_le64((u64)shm->offset + rpc_offset);
> +       req.arg_size =3D cpu_to_le32(arg_size);
> +       req.rpc_size =3D cpu_to_le32(rpc_size);
> +
> +       return optee_rpmi_yielding_call(ctx, &req, rpc_arg, system_thread=
);
> +}
>
> --
> 2.34.1
>
