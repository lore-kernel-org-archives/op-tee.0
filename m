Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F0DCA6019
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 14:43:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 91E784528A
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 14:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791557019;
	bh=5U7XqM0iYXBdDlJihKxhkWeps6uHFjeVxdyfKfJZthQ=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Tb7D/nNrTjnxquYak9aUYsDJw0Tl1knceldRPllkP8CO1Fmmg/z5UVilnsNwioTB5
	 L1YBprRRXlwH9tZWHcrDa/745DVSON57VWBSJjSZYIA4dO5vz4cpkU+9XowPKwaSSZ
	 XqwQHGY2+2Rs7X8P9UXGx6jsHb1cUJc60q0L3501beNd7gf5whaKiI9n8x+5wY5ZiM
	 LE4OYcxo45TIeY4KxHKDFhmzINR13t9CJ7hRmuHsyRZZR8qH0xml2nqhMMZpjl0ck1
	 5o7MYJe5ZsGCqzsLTcjdYqeIDF386Y89i9oEW7nyp4gJVlyg0bZx+WjNl9RJf8WSN/
	 r3qqUx9pk8AAQ==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 40051438BE
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Oct 2026 14:43:32 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OucXmOv8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CVeqYZLo;
	dkim-atps=neutral
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DKYqF1061078
	for <op-tee@lists.trustedfirmware.org>; Fri, 9 Oct 2026 14:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MFR2AOl4yda5AptAjwSQat1eKBRcF12cEmBSADWeyns=; b=OucXmOv8QLOr2EQt
	RI+eChZ5BICG4gv1ayGqO7u8MoiGZTMrZgMQ6JYdSwkUl+pkidf1YD2NGfYKhgNX
	egvb1RRlmAIGyoc2U9vUnXrOlYrRy2wHBtSi3zdo2rJ2RzzOFQyeee8EFAeUgss0
	tOe0vjrletI0qD7TPDccY4BfYYsorOtfdC524/xN919n3Iy6FpyQ3JXbscviIiEN
	lk0QtWtE575fJRD8XtywnfK0SUxxgqG78GtP2cv3vBHQx6YLfLtA5rFoQXkljXVX
	CLNZ1C1i3qJSthYN6CXIMd4IbbB3pCNrwpbfo2GceUEPA84JEvxMKUvxsD7s5awB
	bfR5Qw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk41pc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 14:43:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-535851217d9so60574741cf.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 07:43:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791557010; cv=none;
        d=google.com; s=arc-20260327;
        b=a4bNfaonNJY6XcciObL1TDGCX2MWlKavemj3IFiM3IHwzujyMfOWAqcdBRFisv6r8e
         AThh0TdxAZ2uGxtl9ASTrrFCFoGyaHzQaGa+rHoLftAxt6bTDDZrokD7VNV0xP52LC8J
         ZVjnuWqe7LlFitMSxOZTjw1/kkjtqB5KknfnIPJevPiTrDa42spv0dPgHwqHPig9O3w6
         Tj0QzmsngzsKYggcZhGkeFuzmtif//gGPZxyvkf5kpmRgziTX8xtyadtnM/FomMI0Frq
         pZ02h/scu0g9gIbiJ8ote3AXQUdKsU6Jq9iQM7wVyVYTc2u+akXASWo4FqXxrcc15V3g
         6Njw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MFR2AOl4yda5AptAjwSQat1eKBRcF12cEmBSADWeyns=;
        fh=Uxwiyvru/YfgHeDfJaXou2HoJM0Ae4q7Fc2KqS83ZaQ=;
        b=Xig5jC6BUCpahUfTmPirYk1HIn2E/wVX/gWVtA/MMPxYoZSyrSIhQiZpk9pbsXa6Go
         TaJE58PAH3Ge+4zdZEgDmR5GpZ4VlcQW9PuTqxFHcB4IjZzIGkx4jtY/pe6JICYkzilR
         61gl4p9HKA5gcwyidi5WXRVnEpgJUzXNHCDdvnJeBJ6L86rUzJYNSE272zi0JBpVf7oj
         a5i3Bs2O/UKLd6qA4rh2dKCSCMFE2gzC81AmXr0k5Dc9K9UXaC1yfGAhGeVbECLUECzN
         SxeqQwm45nP4gVrFcG/e0nDCgoGmlvNDJgp87m/9L5JxGboikrnYt/iY29tlpAHbr+Vl
         VV2A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791557010; x=1792161810; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MFR2AOl4yda5AptAjwSQat1eKBRcF12cEmBSADWeyns=;
        b=CVeqYZLollJknc4i+rNTvUF808S5qTXopigwtWgGH95yHG1D29Fm88HcNg1H7K4fAX
         /BgaScguBESeBZZKFIYseX+YxklGDfUD89lmdBiP58/YDXn9kW3e1CHnfMYxT5ZxMOTY
         YlzkoWifTTkKibGXAMG8cRLlflX/OTe3s3YaJUAe8JP9J48FcDQT4yfbzBBvsUIP544L
         qQfgr/Tly9XSJnemfcYUnLglNulBpoHyCoK1WeMhMY3T1tXrkzsFdg3HmfgMcpKFmnAg
         1HvtxAJczqmc39C1J+klRjo3n2DkaYEjw8ov73OQHU/zptblOxl4aFlwSuww899AcgAf
         fMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557010; x=1792161810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MFR2AOl4yda5AptAjwSQat1eKBRcF12cEmBSADWeyns=;
        b=qjZaxbM+WsUVSAk4LKR1PwvyeMyz7VQV3/Qe5GdOVsLhswmqBs8jFHLvqGSV8yZvMT
         CabDfRiic7Q/e/W4cEYfFUuEhxXgpCb4Ju7lW+Fpk8QCy1ZLeHJ8msY75tOBUEPliW/0
         IFIT8nZ2MTGewwTG/kYYpDrEPKZ8KUywNnpgpDAnARhkc2dB6NM02xiUB9WIYpjw4tmR
         eL1JSTMP224D5criJz3+bXC0bxE1nOozWhiyumcZacOtUXHqhPis93LgEF/iBKKlREPT
         MtxTfQWXlixs0XyaICOOln907tniDlSfBMaI8R94CWX3H0LdM2RsJTODhxMogXBpB/hy
         NrWA==
X-Forwarded-Encrypted: i=1; AKwUvBw7BREqR/vwZMWsFtwXUx0VxIc1VvuUBYZjS7kFvrUJziZUhCKhIWKqdsDegWbqopOFVQn/7HQ=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++ngfb3a2Y+LCMnaos2BjsA6r1778Bpg8lNUftp3LP70LOeUgyje
	vK7JWPGK+1NepKtM2vE+FDnv4jwfh1quuTyc5Czhv/ozPdQZ53xZ430cS8OOHSab9wUGO4Y2xHi
	6jEAVOJVvI/yT0zI9i6f2xeBSwrhaT8DTsHqKvISa7tjGjmxvNGFQfMZVWRpEQDYDLHFxL+8K+8
	pAVcnnKU5gV0MtenRUieGqyLDl97FQaghkqbZd/3ErxqNrKkM=
X-Gm-Gg: AYBFou0mFDkn1+27lRzigV6DrRFfj9UvkIIZmYFZYHQPnNGEON2DKM9KHGpK181fnG6
	W0boRj7tnJreviJp3iIqLAaCVtl3jvB5BWLNUPKMVzpdTJjFK8B6LJOPaAOtkFATm+pXUdAXzTN
	k0YDunrOiHFbP65IWlO54f/7qPSPQECa0cTjQOz5qYhXrSkv8oebu7rpE=
X-Received: by 2002:a05:622a:2517:b0:533:73b3:ab37 with SMTP id d75a77b69052e-5359facd277mr32613921cf.21.1791557008933;
        Fri, 09 Oct 2026 07:43:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2517:b0:533:73b3:ab37 with SMTP id
 d75a77b69052e-5359facd277mr32613541cf.21.1791557008361; Fri, 09 Oct 2026
 07:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
 <20261005-rpmi-tee-service-grp-dev-v2-7-72f222e23ec1@oss.qualcomm.com>
 <CAGgiveU+8d-MmPL4n_ADimkrthsE1sU4QHJoBeh==sxLZmdrFw@mail.gmail.com> <f9e91a7d-1628-4746-b2e7-03c7b1be11cc@oss.qualcomm.com>
In-Reply-To: <f9e91a7d-1628-4746-b2e7-03c7b1be11cc@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 16:43:17 +0200
X-Gm-Features: AclHuK-iwpXhKCW1lDKHLFQjYfiUaQQVp7wnVNfe_r5bhgAvlRHOCGBGjBCgB9Y
Message-ID: <CAGgiveU0DcUYW-EF-hneNqeQOkk9OTwcvzhgUvFB4JJOGSiwkg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 7/8] tee: optee: bind RPMI services and negotiate
 backend capabilities
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac8fd92 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=9OYd7h5rvP6jySxxyU8A:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: lzyIZoAvpdmbvav6RHJNcD-WxHuCMUcI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfX6aPOJ7eoAsea
 dn+IdiK5WVmMe1PfzEiq1pnxwBPw18XM1gqiztpYKzd7IpAKKYMQfMXtAJ0kyZSz5T/b8EGnQS8
 p1xdriqa0OwpTijt9h6lswYgN9SaKPw=
X-Proofpoint-ORIG-GUID: lzyIZoAvpdmbvav6RHJNcD-WxHuCMUcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1OCBTYWx0ZWRfX6bzBZqI2Vdkt
 LO2pV75ZvTn4zfmaRcoJ6EUa5NXVvlrOTSM0n0b4N0iE+GGDziTl2G9txK9NH/BGx6T4FDeoH/Z
 poV9jeko0aFpjC6JnAis5UT69/afOeGXNC8AG4KNX9xT/Rq5SIsLq6i3Ct+XmrXol7ke6Ol129e
 kcZ2CqAhFPs4b51XJvm6aUmdw6ur4CuKrVUJH/tMiXW2KFguQdk9Gkqz8ErVO2Bb/yDzPX8RAXA
 i175KT4qLOsTUcHDuuPRioqlU6wQJkJ9fCzCDZVbnWiLUs+mY9iqCcROzTopjNYBueAfiSaMNgi
 TSHamYbStPKahnOBj7d7J1oPbDpqc8M71iUNNc6vUykGjJ+nQHfsHWNHxDIiztT7lYT/3JnpEYn
 d80xlB91hBazaQBFbN++tUE2+SjO5+1cXYQ40vqrkwlxn2VE4xkBrDnIofREiWKXhtWHzA8x5HG
 oBPnu1+5X5wNKdT8keA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090058
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	RCVD_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.197:received];
	DNSWL_BLOCKED(0.00)[205.220.168.131:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 40051438BE
X-Spamd-Bar: -----
Message-ID-Hash: C2GK4DLUSOICVSFBVY3HQUVIDXT6GNIL
X-Message-ID-Hash: C2GK4DLUSOICVSFBVY3HQUVIDXT6GNIL
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/C2GK4DLUSOICVSFBVY3HQUVIDXT6GNIL/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Amir,

On Fri, Oct 9, 2026 at 1:10=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi jens,
>
> On 10/8/2026 7:20 PM, Jens Wiklander wrote:
> > Hi Amir,
> >
> > On Tue, Oct 6, 2026 at 2:40=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Register an RPMI service driver matching the OP-TEE service UUID and
> >> integrate it with OP-TEE module initialization and removal.
> >>
> >> Check the service API version, query the trusted OS revision, and
> >> obtain the RPC parameter and logical notification counts. Initialize
> >> shared-memory tracking, the call queue, supplicant state and internal
> >> context before publishing the client and supplicant TEE devices.
> >>
> >> Connect the RPMI backend to the common OP-TEE operations and enumerate
> >> trusted application devices. Enable in-kernel RPMB routing when the
> >> RPMB subsystem is reachable.
> >>
> >> Add removal and probe failure cleanup for the backend resources.
> >>
> >> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >> ---
[snip]
> >> +
> >> +/* Query and store secure-world capabilities and buffer limits. */
> >> +static int optee_rpmi_exchange_caps(struct optee *optee)
> >> +{
> >> +       struct optee_rpmi_probe_req req =3D {
> >> +               .op =3D cpu_to_le32(OPTEE_RPMI_EXCHANGE_CAPABILITIES),
> >> +       };
> >> +       struct optee_rpmi_caps_resp caps;
> >> +       u32 rpc_count, sec_caps, notif_count;
> >> +       int ret;
> >> +
> >> +       ret =3D optee_rpmi_call(optee, &req, sizeof(req), &caps, sizeo=
f(caps));
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       sec_caps =3D get_unaligned_le32(&caps.secure_caps);
> >> +       rpc_count =3D get_unaligned_le32(&caps.rpc_param_count);
> >> +       notif_count =3D get_unaligned_le32(&caps.notification_count);
> >> +       if (!notif_count || !rpc_count)
> >> +               return -EPROTO;
> >> +
> >> +       optee->rpc_param_count =3D rpc_count;
> >> +       optee->rpmi.sec_caps =3D sec_caps;
> >> +       optee->rpmi.notification_count =3D notif_count;
> >> +       optee->in_kernel_rpmb_routing =3D IS_REACHABLE(CONFIG_RPMB);
> >
> > What if OP-TEE is built without RPMB support?
> >
>
> I discussed this with Sumit, and the intention was to make RPMB probing
> part of the baseline for the new ABI rather than negotiate it separately.
> I can enable the capability bit if it should remain optional.

You have a point. Let's keep it, but we may want to move the
assignment down into optee_rpmi_probe(), as the other probe functions
have it.

Cheers,
Jens
