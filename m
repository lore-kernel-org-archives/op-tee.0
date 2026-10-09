Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793E9CA6019
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 13:54:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9B5AF45352
	for <op-tee@archiver.kernel.org>; Fri,  9 Oct 2026 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791554081;
	bh=xdUlWmFUprIdsNTdyfPx4FHMo9eSBbvRA+21qOUbaak=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=MZZavPVHhivQnASl+x90FGxEsMs6ClRvg+zGYVrZ3XyeP59EuioDP3Nfnd65LfIEm
	 0qDRujSzoCe2wsY/KfORZEV9qqLhom0IjIfHgNPfO7THpkm9j+1LXMEJUl0LY7sWVk
	 /t7sGjCtDsSFC27ZKPJUSEs6Tg6is3VmgfgthJ75itakVYcCD4OEbA1GusRtXaxCuH
	 Ab3WIfz6Ea38fE4eCwlEPxfC+rzJb+ubgUhIFVd5Vk41kOKam2dwbEehUoEg7wratg
	 qZSvlCadCmZr1ctG+kRVQ6y06FJcXLEr2yQwp1vf+LTo3k/dcXiMDUf2NoTUuPKus+
	 CkSQ9wyUx+EvA==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 644D7438BE
	for <op-tee@lists.trustedfirmware.org>; Fri,  9 Oct 2026 13:54:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KfhVLPxM;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eyxTUiEK;
	dkim-atps=neutral
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DkoIs1374579
	for <op-tee@lists.trustedfirmware.org>; Fri, 9 Oct 2026 13:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KvpmX/1Q3IU4m40umxn2XOTD9p41yiv+dwDT4rC7IA4=; b=KfhVLPxMrDc8IQnM
	lJMZGedco6PE8Is3R6J6SkEi3i0jX5WdJ0HpR3pYqvWdlIcFbvM7juTvpxIq+JRh
	87sdx6mj5f9ZwyzEdYyRbyaAq284RJBP9xxhv/xpqFjk0s7b8CcrW2Exkrm/c2hD
	19KmizLvsnSRIYIrW5GJiKGyuQRnKKVzCRjZaA9+xEyAZMsUGN8p7VHXnauI0TTy
	4XsvKZ4rq8Vep1rNHj/a/oF4s8iZWRsPejgnhpjuwK2E/l/C28bX/hHQ/T8dJFMh
	c6GtM0QUf0tkpdAPBDtjEx46kMB8bSJuxNKFzfQmFypfjZiXpGgXF42Z/6XWme8A
	WnEahA==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h71f281ru-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 13:54:32 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66ce3040ea9so6827485d50.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 09 Oct 2026 06:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554072; cv=none;
        d=google.com; s=arc-20260327;
        b=aOS8BiglXDKvXb0zfbwQP1K1WU7WLjBo9X3hu90H9EMC3ydr+ZIQbFvdta2tcE8ZyR
         tG/BJFjrYe9SWHIH8T7zsHXehFl7JQ4dgsPghbVhmbqzVyiHn0QE4UfAJZdooyQm2vLn
         wJ8ndbEiO7sinYkq1dtK1Ln0EKEOQ6I/EPuqVCic4hJi2O67tz0rAgyLAPietLOAM6MZ
         Ya0/UK73YNJHBL64cIL8/1koHn3+1NqQXFjo5yyeID5sMKSCDc485aF3ARQNGA6xU0sY
         M+YJJkJxWJ9h6gNSQ5abGfldQGiYko4qjKkGxxR1/ad9rrNLvlUpKGc/MJuNmUn0kINY
         sbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KvpmX/1Q3IU4m40umxn2XOTD9p41yiv+dwDT4rC7IA4=;
        fh=Rs6eQAgfOuB0tfoCZ51ARYbNuYGi5OVcTPqs0NXUWPI=;
        b=bQssQpxGPh/oUbk5qFGTpDzyB2h1VmLQqwBItu+nTyxXwByJ4dYnnAidGgL//uaJWZ
         pk7XrW2zNIYrNSE6CQfVmMUvKJgkZ8sdyEolvMuxOanV4Buzu8LFBVe9wgrrwUNSuQ8G
         LMIPPj3x9p+KGJLvveW8SMn7nzDj+iiz8n70aGVm00aDtrTxuXLCjc2V1m/AW+/AoTon
         qmQzp7W2tYVorwqxfCZxnuWoKEAovM0mXSa3YDZWZ1DOOXc2QB9klWLlrfw2Xmc46yV+
         0U5v7kbylir2wfYOyB0LKHKVU6R1UT9S66W3wy5sS7Z2aoXhIFpSuSQPCO3G46Vv8jAB
         PK6Q==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791554072; x=1792158872; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KvpmX/1Q3IU4m40umxn2XOTD9p41yiv+dwDT4rC7IA4=;
        b=eyxTUiEKHhTcof4KlSd6VMY1vC/czVgZJmHWC+V1Z4LRCfln/cOsW6V2wZ2ANORA6q
         L3qVtLqrXzUSGCW6gY14sAUTdxQ+caSggcap1/0MrdMPk7UtWZdquPJGC2w0mn3gzYID
         xMtuVYxawtKWldAuZk84X1sdr9mD6GuUfZBzDI7ehG8vy4C4DRdJsAiSFTZGKMefBwsE
         gnEDR8KBJnHRwcn4JLMXMzu0saaXwIlraZ/fUgXa6wYk8KzYgAZJnHb7keC7XLe0ucJ6
         bL95CbFaYtbLdmJ+NaX0+Bk8HIwBGHs7EdMYXFb6NcGb15KeWqdmozUROay0ignMB5qj
         agUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554072; x=1792158872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KvpmX/1Q3IU4m40umxn2XOTD9p41yiv+dwDT4rC7IA4=;
        b=DY/GZXSvTEQYBL3i6a4wOegg8Q4cB6TMs4VukCENBeo/ck7i/TsE0G80QMACP6n8Bb
         g8Tl7+lEy/lq0I41DEoMWdmX+IohX9PGTtetOBrclE5lo/xJ+7nYUYS1Tg0f2AixrJ0q
         7v70trTA6uLv9Dpm83suy8js/VqqRgbVeu1OafUZH3Bggxw9uYm6XBtvv5ui9/8lJRuw
         w4x83j8lcgRyLW41fJD+ryOBBUStwvh75hb1RoWSLzOgtAO3lomEnZWlgMX1ULnLWwPY
         okxNEiLyhggxH9xNaxqMj8pC7fli/kK/IpxlGtVkUNKlvAUOGBgHSrXenQqXJMxNmdy1
         2Fbw==
X-Forwarded-Encrypted: i=1; AKwUvBzxrz9adjb+TRR03lLUrmBMtNjONrDUvayTCLeXTe5zEDAIpvtL2WgaitVC0WT7jqzMXwX3ia4=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYI/JCLGr4RciuZymg2e1W57vdihvbO1X+lrC3maXmRvsZUaXSJz
	BPn39axAczz5k6Vs7yN3yoXHMNW3wZ5Siwa+5+djWyNdupZ9EanzT4r1piTWcaJMlTKRUsEuHWQ
	1vfadzg4f3tYqyMadf073FodFgk3Utbzb7ZhNBHlVppImJpQmPCXGyNMJwWo3bY/mgAWQp2we6f
	/0E3niUuWETi2fD/axaxCIjmCDNRMWfYi9vIW52g0a1uw7MpkHHTQ0nGW2lw==
X-Gm-Gg: AYBFou00L0c9MAc1mpAV0DlOFPUSlrQRE4C6IEjjxIHFLvQFsQrq2yZaelW1gYGbKQc
	OEc5osCHWSgNQZZMn/Ct6tgLDeABLphN/prl9fCIajaHwgWoZIAE+7dxZJ05k6L3k+jLQeaJXcv
	ANpta3X85pmENu9DklV4OpOgp/LXBaJNoV4R9q8Xq8hKgwjUheJAG8OIg=
X-Received: by 2002:a53:d015:0:b0:677:b9d8:a475 with SMTP id 956f58d0204a3-6793633bd6emr535590d50.147.1791554071718;
        Fri, 09 Oct 2026 06:54:31 -0700 (PDT)
X-Received: by 2002:a53:d015:0:b0:677:b9d8:a475 with SMTP id
 956f58d0204a3-6793633bd6emr535575d50.147.1791554071017; Fri, 09 Oct 2026
 06:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
 <20261005-rpmi-tee-service-grp-dev-v2-2-72f222e23ec1@oss.qualcomm.com>
 <CAGgiveUB4ETEbcfCvagfj6q__jsfPmJoeT_w0xA-9NOZpGNwfQ@mail.gmail.com> <630aac65-bf8a-4334-8187-0e7eb0e25217@oss.qualcomm.com>
In-Reply-To: <630aac65-bf8a-4334-8187-0e7eb0e25217@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 15:54:20 +0200
X-Gm-Features: AclHuK9fYnXbSdIG_QneNDrOHxWZzqswhBgQC4kZW9p0xYrZTiG8kyqxYxfRAtY
Message-ID: <CAGgiveXzQKdLKX3W3N5PDV+t8FW6yMvDTK1rN=rn59zQ0TgC+w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/8] tee: optee: define the RPMI control and
 parcel-reference ABI
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1NSBTYWx0ZWRfXxtXceXpJ5pK+
 azI0Rqv5BW/6MV7+/ub+08aNj4Rzuaq8NvNYft5EvCKpN+xsyRFHpJt8nqNPCa8uzvCfVun2sAd
 PtX9/WkTxTxRiewKQF0gh+tcHqHjMGw=
X-Authority-Analysis: v=2.4 cv=NLBAaE6g c=1 sm=1 tr=0 ts=6ac8f218 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=wjuEhBAy9pTyS6C4czwA:9
 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-ORIG-GUID: XW-IHMur9MLO_h2y2it9zRtUV1ayIgs5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1NSBTYWx0ZWRfX58NR1gSDovHK
 cvkpjWaiO40xC48rDfZbDLJiCO4M6XFTD8QLWcodlUcCoqfpnszWuXTQlEXJ/yQXIcLt1BIQwyF
 pViex9oGovg0FmcaNcqN1gNq+4z6BIUpGP/Yk4ja3eaBZCWLZYpe+SFCu/YCWSOr1dJ00lSDzx/
 5SFGfR0TlcS3irK8Ul6bq8ZyLXP4JukysBibiapJKvoOozPtd72BC4EDYv2Mn1Gqms5Kk1Qu902
 Fic9DnatHg7g2Job/wA0q0Dwx6DukFxY2g8Hr3V2NvbAGkU0qa9Ct5LHeV+6noZuNQPqk2PyMU/
 QTI9tX+Uw4E/PVZyNKxjmBCxR58pvFKYG72p1vlSrlzqNzvY1mYiunHrCsAkwEvx2Z/qksVjlFn
 Wfg4NZzE47yu+fba80KGdIUvhOfhLChXLkXk+aqDu3sGg6SozqLX7QgBndzWtQB5kiNqgaSNvTg
 dW8QFelFmOHaT1xGI0w==
X-Proofpoint-GUID: XW-IHMur9MLO_h2y2it9zRtUV1ayIgs5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.70:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 644D7438BE
X-Spamd-Bar: ---
Message-ID-Hash: A3HODVQ4XPP2TL6VDPH3Y3P73BZLHMR3
X-Message-ID-Hash: A3HODVQ4XPP2TL6VDPH3Y3P73BZLHMR3
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/A3HODVQ4XPP2TL6VDPH3Y3P73BZLHMR3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Amir,

On Fri, Oct 9, 2026 at 12:03=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> On 10/8/2026 5:51 PM, Jens Wiklander wrote:
> > Hi Amir,
> >
> > On Tue, Oct 6, 2026 at 2:40=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Define the OP-TEE service protocol carried by RPMI TEE_CALL payloads.
> >> Add operations for version and capability queries, shared-memory
> >> unregistration, asynchronous notification enablement, and yielding-cal=
l
> >> start and resume. Use fixed-width little-endian control fields and RPM=
I
> >> error codes for control responses.
> >>
> >> Add a parcel memory-reference layout to the common message parameter
> >> union. Identify shared memory by its parcel ID and nonce, with a 64-bi=
t
> >> byte offset and size, without changing the message parameter size.
> >> Encode NULL references with a zero parcel ID and nonce, leaving parcel
> >> ID zero usable with a nonzero nonce.
> >>
> >> Document the wire layouts and ownership rules for matching Linux and
> >> OP-TEE implementations.
> >>
> >> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >> ---
> >>  drivers/tee/optee/optee_msg.h  |  38 +++++--
> >>  drivers/tee/optee/optee_rpmi.h | 234 ++++++++++++++++++++++++++++++++=
+++++++++
> >>  2 files changed, 264 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_m=
sg.h
> >> index 6c3043f8da33..028f8cd95fdd 100644
> >> --- a/drivers/tee/optee/optee_msg.h
> >> +++ b/drivers/tee/optee/optee_msg.h
> >> @@ -31,6 +31,9 @@
> >>  #define OPTEE_MSG_ATTR_TYPE_FMEM_INPUT         OPTEE_MSG_ATTR_TYPE_RM=
EM_INPUT
> >>  #define OPTEE_MSG_ATTR_TYPE_FMEM_OUTPUT                OPTEE_MSG_ATTR=
_TYPE_RMEM_OUTPUT
> >>  #define OPTEE_MSG_ATTR_TYPE_FMEM_INOUT         OPTEE_MSG_ATTR_TYPE_RM=
EM_INOUT
> >> +#define OPTEE_MSG_ATTR_TYPE_PMEM_INPUT         OPTEE_MSG_ATTR_TYPE_RM=
EM_INPUT
> >> +#define OPTEE_MSG_ATTR_TYPE_PMEM_OUTPUT                OPTEE_MSG_ATTR=
_TYPE_RMEM_OUTPUT
> >> +#define OPTEE_MSG_ATTR_TYPE_PMEM_INOUT         OPTEE_MSG_ATTR_TYPE_RM=
EM_INOUT
> >>  #define OPTEE_MSG_ATTR_TYPE_TMEM_INPUT         0x9
> >>  #define OPTEE_MSG_ATTR_TYPE_TMEM_OUTPUT                0xa
> >>  #define OPTEE_MSG_ATTR_TYPE_TMEM_INOUT         0xb
> >> @@ -149,6 +152,23 @@ struct optee_msg_param_fmem {
> >>         u64 global_id;
> >>  };
> >>
> >> +/**
> >> + * struct optee_msg_param_pmem - RPMI parcel memory reference
> >> + * @offs: full-width byte offset from the parcel's first byte
> >> + * @size: logical reference size, or required size for a short-buffer=
 response
> >> + * @parcel_id: firmware-assigned parcel identifier
> >> + * @nonce: nonzero REE nonce supplied when sharing the parcel
> >> + *
> >> + * A zero parcel ID and nonce encode a NULL reference. Its offset mus=
t be zero;
> >> + * its size is preserved. Parcel ID zero remains valid with a nonzero=
 nonce.
> >> + */
> >> +struct optee_msg_param_pmem {
> >
> > Without an internal offset like in struct optee_msg_param_fmem, an
> > explicit register SHM call into OP-TEE is needed before it can be
> > used. You'd still need the TEE_MEMORY_PARCEL_CREATE, but we can save
> > one round-trip into the secure world.
> >
>
> The original intenation was to use parcel-relative offsets, with the
> secure-side memory object covers the entire parcel. OP-TEE can retrieve i=
t
> lazily and apply the supplied offset directly, so this design does not re=
quire
> an explicit SHM registration call or an additional round trip.
>
> Since we are implementing the RPMI parcel memory-object cache independent=
ly of
> FF-A's cache in OP-TEE, this seems simpler: it avoids a separate
> initial-offset property, preserves a full-width offset reference, while
> keeping OP-TEE ignorant from the SHM concept which is a Linux side concep=
t.
>
> That said, I can separate the offsets to matching FF-A's memory-object
> model. But I am not sure what we achive?

I think it's needed, but I don't mind being proven wrong. :-)

IIRC, this stems from TEE_IOC_SHM_REGISTER. In hindsight, I regret
that offset. We should have kept it in userspace, but that's too late
now.

>
> >> +       u64 offs;
> >> +       u64 size;
> >> +       u32 parcel_id;
> >> +       u32 nonce;
> >
> > I wonder if parcel_id and nonce wouldn't be better combined into a
> > single field. They need to be separate when preparing arguments for
> > the TEE_MEMORY_* calls. Everywhere else, it's only an opaque memory
> > handle, and one handle is easier to keep track of than two.
>
> I thought about that before. This would push the conversion to the
> firmware boundary. I was not sure if it is acceptable. I'll do that :).

Sounds good to me.

>
> >
> >> +};
> >> +
> >>  /**
> >>   * struct optee_msg_param_value - opaque value parameter
> >>   * @a: first opaque value
> >> @@ -166,18 +186,19 @@ struct optee_msg_param_value {
> >>  /**
> >>   * struct optee_msg_param - parameter used together with struct optee=
_msg_arg
> >>   * @attr:      attributes
> >> - * @tmem:      parameter by temporary memory reference
> >> - * @rmem:      parameter by registered memory reference
> >> - * @fmem:      parameter by FF-A registered memory reference
> >> - * @value:     parameter by opaque value
> >> - * @octets:    parameter by octet string
> >> + * @u.tmem:    parameter by temporary memory reference
> >> + * @u.rmem:    parameter by registered memory reference
> >> + * @u.fmem:    parameter by FF-A registered memory reference
> >> + * @u.pmem:    parameter by RPMI parcel memory reference
> >> + * @u.value:   parameter by opaque value
> >> + * @u.octets:  parameter by octet string
> >>   * @u:         union holding OP-TEE msg parameter
> >>   *
> >>   * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value =
is used in
> >>   * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value or octets,
> >> - * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @tmem and
> >> - * OPTEE_MSG_ATTR_TYPE_RMEM_* or the alias PTEE_MSG_ATTR_TYPE_FMEM_* =
indicates
> >> - * @rmem or @fmem depending on the conduit.
> >> + * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @u.tmem. OPTEE_MSG_ATTR_TYPE_=
RMEM_*
> >> + * and its FMEM/PMEM aliases indicate @u.rmem, @u.fmem or @u.pmem dep=
ending
> >> + * on the conduit.
> >>   * OPTEE_MSG_ATTR_TYPE_NONE indicates that none of the members are us=
ed.
> >>   */
> >>  struct optee_msg_param {
> >> @@ -186,6 +207,7 @@ struct optee_msg_param {
> >>                 struct optee_msg_param_tmem tmem;
> >>                 struct optee_msg_param_rmem rmem;
> >>                 struct optee_msg_param_fmem fmem;
> >> +               struct optee_msg_param_pmem pmem;
> >>                 struct optee_msg_param_value value;
> >>                 u8 octets[24];
> >>         } u;
> >> diff --git a/drivers/tee/optee/optee_rpmi.h b/drivers/tee/optee/optee_=
rpmi.h
> >> new file mode 100644
> >> index 000000000000..252216aad09b
> >> --- /dev/null
> >> +++ b/drivers/tee/optee/optee_rpmi.h
> >> @@ -0,0 +1,234 @@
> >> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> >> +/*
> >> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >> + */
> >> +#ifndef OPTEE_RPMI_H
> >> +#define OPTEE_RPMI_H
> >> +
> >> +#include <linux/bitops.h>
> >> +#include <linux/types.h>
> >> +#include <linux/uuid.h>
> >> +
> >> +/*
> >> + * OP-TEE service ABI over RPMI TEE_CALL.
> >> + *
> >> + * Requests and responses are carried in the TEE_CALL service payload=
.
> >> + * Control fields are little-endian. Response status fields contain s=
igned
> >> + * RPMI error codes, distinct from the outer TEE_CALL status and the =
GP
> >> + * command result in optee_msg_arg.ret.
> >> + */
> >> +#define OPTEE_RPMI_SERVICE_UUID \
> >> +       UUID_INIT(0x486178e0, 0xe7f8, 0x11e3, \
> >> +                 0xbc, 0x5e, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b)
> >> +
> >> +#define OPTEE_RPMI_VERSION_MAJOR               1
> >> +#define OPTEE_RPMI_VERSION_MINOR               0
> >> +
> >> +/**
> >> + * struct optee_rpmi_probe_req - request without operation-specific a=
rguments
> >> + * @op: GET_API_VERSION, GET_OS_VERSION or EXCHANGE_CAPABILITIES
> >> + */
> >> +struct optee_rpmi_probe_req {
> >> +       __le32 op;
> >> +} __packed;
> >> +
> >> +/**
> >> + * struct optee_rpmi_status_resp - response carrying only an RPMI sta=
tus
> >> + * @status: signed RPMI error code
> >> + */
> >> +struct optee_rpmi_status_resp {
> >> +       __le32 status;
> >> +} __packed;
> >> +
> >> +/*
> >> + * Return the service API version.
> >> + *
> >> + * Request:  struct optee_rpmi_probe_req
> >> + * Response: struct optee_rpmi_api_resp
> >> + */
> >> +#define OPTEE_RPMI_GET_API_VERSION     0
> >> +
> >> +/**
> >> + * struct optee_rpmi_api_resp - GET_API_VERSION response
> >> + * @status: signed RPMI error code
> >> + * @major: incompatible protocol revision
> >> + * @minor: compatible protocol revision
> >> + */
> >> +struct optee_rpmi_api_resp {
> >> +       __le32 status;
> >> +       __le32 major;
> >> +       __le32 minor;
> >> +} __packed;
> >
> > Why do these communication structs have to be packed? With careful
> > design of the layout, padding, alignment, etc, it shouldn't be an
> > issue.
>
> Agreed. The structures already have naturally aligned fields and
> explicit reserved fields where needed, so `__packed` is unnecessary for
> their current layouts. I'll remove it and keep the wire layout explicitly
> defined, retaining unaligned access helpers where transport-buffer alignm=
ent
> is not guaranteed.

Good.

Cheers,
Jens
