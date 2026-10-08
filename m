Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1979BCA600B
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 06:15:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3C7F5451E7
	for <op-tee@archiver.kernel.org>; Thu,  8 Oct 2026 06:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1791440139;
	bh=e3MUK5mLoJWucj7GyFl4ivsM4yVN/NwLBo+kC/yeKZM=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=UZ3BkmvWmjrADpY7OPLqDm6gDkomVYqSilObhzW+x4YHCz58AqNk9TKrgd/HVBiRo
	 63Iwduc3uECMVOOfuBvpudEqC4MuJ+IhAt/0g0XNYbmuysENV29XE36DMiGw4zMyJV
	 k7SgT2kCXUA8jtMU222ophfex1pH8v8RxpPByd29Hz6OLpzdtOidWqLptFYFfW5yRU
	 Duz1MxSEkZ1AGb5lEJbvG50CS8ltD0c9RVtuCxYmJlYqK+P6/UJZAzi65X2VLJePEj
	 gVDntgjEuOn8J1/4ZCpcY6SqDH4H1FQ1pxxbWB0i1Vgzu3tjUzYUcmnAVTXUx37NLb
	 pmX+bcEQTwO5Q==
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B089544B0E
	for <op-tee@lists.trustedfirmware.org>; Thu,  8 Oct 2026 06:15:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=INS536GR;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hLQpS3kr;
	dkim-atps=neutral
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6984BbXZ2775005
	for <op-tee@lists.trustedfirmware.org>; Thu, 8 Oct 2026 06:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xQPAWZepEqBkyCXjjaXrcNi/jWE54i2O+AUc1+MHBYY=; b=INS536GRqXgAyLEv
	LXBkqnEE6CLJX5tPvxB/ATYuK87GnsHHOm42VV/lFWu1MectcBvxMG7qlQx+uq/r
	Rgrx8MJJdy3yZkb9LuEgUPblFU28n+BpMQiFObFIG0NWNb80v8wfUW18Uh5sCPl7
	PEt3rQBll2kWsCuqyIXQHBn/jrqFqxGuQliMfhQkgUQlf2lkcMg4UKAPZUOQjJB1
	WAKJLI83F7Ko7gHA2OwwSO82iQU/F/kWQF4XZlXhwrPY1pRaTHj5osCgOqHInTgq
	iao0ZXO1hn+3l6Cj04JvpJOfjH/Voq05l+C1UJEav7/NHP7J0rbedfyfFJzF1xUc
	nuNerA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe69dw1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 08 Oct 2026 06:15:30 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-67692931213so7634754d50.0
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Oct 2026 23:15:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791440129; cv=none;
        d=google.com; s=arc-20260327;
        b=MQwQ51gXFNunSEWmS352l8uZHWmPVA/n++xw+b0Lm3FJ84NH0DFkyb7t1IBDon7QbU
         1eQh7cRDvo1CSjnMRjo/zkYOn/9m6F+bIXvvt5cct4qk1PKST3jtO6lPrZE3fdJxRwct
         vM4EIKnPGK/JBlYRNWme4hfOwI8JKvZtqOa46DxakwvTS7k0EIrdwcHqQozlmE3a4fbe
         sf0j10mxUUTeGqSCb0GhVKWLMNmzjjsgbPsfys3szFJdzqgLQGXOmA/19SyFvcqYOjhb
         ZDx/Wy9fkO/PAf9dX86kE4XVyMYHa2KrOR1u0HBFAK2TLCCKIM6/Q2H+cJvYhqU1sxKz
         VRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xQPAWZepEqBkyCXjjaXrcNi/jWE54i2O+AUc1+MHBYY=;
        fh=lWH6LP0+um8tBKCal0+rqpX3zoj3rXCzzYDMPl2o4qs=;
        b=T5iqnxF7eKh/5DL4hsnvIWwlswXVZwsMgjM4/W3lcZpnHusr9/tTJFTNhXAN+GAblB
         +LPbgc1u+OJoC6HAsSpplrxSUug1z2GHHlG00RjtuH77LNsd9IDBhoqHNfiv3YN+OjqN
         tE63stV3+2CSCLPFmwdPnX+0BKedAI8bXEBENbRYyPTKVPBSZ8uO2ykgA3CCkoUGuuFi
         5ydJGyTMbEEsOb8jjqDXSWtFzpKXpwVelmVJ2PGan3MX6h2G0OVmF8AZGX6klF/aPBgV
         4hjb4itCMr7YtfV2rNeddoq121opMZIehW3Kp8nsEq9wYHQTWsHvKClDIE00BZ1fc6lL
         qsHw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791440129; x=1792044929; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xQPAWZepEqBkyCXjjaXrcNi/jWE54i2O+AUc1+MHBYY=;
        b=hLQpS3kr35LYu2PqbziNGs/S8SmFJX9/2JZuFtt/zycAdSPdgqqufZn5V9R6Obu9iy
         qoe+QFuwSgBF3upvxNVwOINI0v8Ms+pKlnQy8kSe/SAqxaZsrcVtFhJ//bxO5CYDjPJe
         cikbhTY/9ARzuHLLsWdtyVWiXS8qfjNh1RY7aExJE5K3TlOkpd+YjRtuEyT1E5Vl+faz
         xhmpvscb65AqQaEiCASlar08GoarO9dTVq3cKBzgkKBAzyQR/WzUsNms+HcwOcQ7m1Pr
         toeRC+gNDXM6W0//+nPxbV3DmLWdMGmv6QwMPlZdFc5yiiBUAlnxfr6ppYtlly8pvLkA
         +hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791440129; x=1792044929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xQPAWZepEqBkyCXjjaXrcNi/jWE54i2O+AUc1+MHBYY=;
        b=TN2br3SAKQTuSwNRLiHxIGKyAG+0WxZ51T+GEgnrV19OwxFhcpZRUJeMNABXfDuQ4R
         I6BNaLtko5QJremimnKbSrxZx29LnyizrCKT7W3PTdBIDkGex1pE6GvmVheBWyqVKZa4
         jlsLZoG91pFIiPuzz8/IFCjVmBBU3yZ6OEGZACRmyVMKhM+PNWgTBaO72/voOtLfqeQe
         D0Qn7NLqLkF7TE+rQIAkEDPQA5YDSLJGFx/4FPyCydUEVTNJV1aF1aYemtAJpGDteS2B
         FLi74oTgz6cbt0xs6uB5x7VZvoE1T6xuDijxwNBjB1YsyhAsho83aCfdTpDZgp+n6CHc
         Jkcw==
X-Forwarded-Encrypted: i=1; AKwUvByKCHr3HpazFauwXTJkRPmaGElE6VAqd+x/9rtPVFRR+2Ue9WGFknSPqAqXjoqrYUSkwfCWTa0=@lists.trustedfirmware.org
X-Gm-Message-State: AFq9FYL1jB9YP3UU464Bl7WWHp5XHYXgk9Szm75yj0Zp4nqjM5b2Egxb
	OJzphXxWs2dSfIWKeBOopPqum4c9edObhyKr26If26ZAPTWA5Gp7pgugbRixPWyxSxfrhHXgkkN
	m3uXL3AGdEzevuRzpY9RXOPyC/Jo/kx2KbM/FmMXhn3/3L1P0CRFn/vJrY31V/p1zp5558mpvs9
	aNZJCk3y0kZ3G3ynCNynviJvg21RbOYE7uMbFCDzYBxQ/NCQU=
X-Gm-Gg: AYBFou21IjJUJvio6HnRDJSoM97aZethEnszbYryVOAEazaCDid0L6Ygp4IiAKz8Mtn
	O2aHc7r8t10n7BJ58wkG45nDAFmcuZmGWpdmpcTIfK8X5wn8pPY5769YslHhEcO7kkDTV2+SYe4
	RknKX8W3U63S7sPxmlgPBIuPLx+mRuQxxDLtPQlq8X2504UXDKvskAemE=
X-Received: by 2002:a05:690e:dc6:b0:673:1df3:86b2 with SMTP id 956f58d0204a3-6790a355225mr2466163d50.66.1791440129075;
        Wed, 07 Oct 2026 23:15:29 -0700 (PDT)
X-Received: by 2002:a05:690e:dc6:b0:673:1df3:86b2 with SMTP id
 956f58d0204a3-6790a355225mr2466145d50.66.1791440128574; Wed, 07 Oct 2026
 23:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
In-Reply-To: <20261005-rpmi-tee-service-grp-dev-v2-0-72f222e23ec1@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 08:15:15 +0200
X-Gm-Features: AclHuK82G-aF0C4QrmEtOvpam9RmR-zAfqfbN8QwUZKZhMnDhKts1Wbg9cYmunk
Message-ID: <CAGgiveXJXXaRNyfq6Gxk4moOHqM-vBuptugn5bHK5x9EeeGSQA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/8] tee: optee: add RPMI backend support on RISC-V
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 7Z0rMr3cPF0U5t1dG7zVDzZMhzc2Z8xA
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac73502 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=etr3aXc5xdJg75Mw1ecA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-GUID: 7Z0rMr3cPF0U5t1dG7zVDzZMhzc2Z8xA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfXxBC+wiQoju31
 oP8h+xgJmxUHLbN57K401mQrfgXTSFYKPDgGxkUMiFW2W0PKrKzcupQyv/pGg6bkXNG+XDrirnz
 yLUB/Kz5VgyNtC0o+EavswCOSz115kG9uwROUrkEe7RpGUGxS9akI/wTdgb0LEyeAMfntFgjvZC
 PTpjeyAcf+8J/JQzCTomstDLG2dPaAU9CqLOE/DzfU2hwgyM2XWD32QmHklcE4CnXUAb1TW936k
 1VHGe4aqFEeOsafyt+0XAEOCFbTcdIu72exINkjtSihAu7uk9tWDHeq7EJbbBsfmiEqlKwwSsen
 YSZlxU/QSM0b33gR6tH6wXLwQsfV2JJehMDvf9yBqydhBMJJDtYZipqX8uA1QhrxefHMgvo3DJl
 ksXxpwfHqO3wpf+pzWF5D7QifvdiKEXnFGv/TwDIT+G8zB60/NYjb1PhGBXJekNT/MdVarpT4j/
 z0skDX3z6ku5UCRUFHw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNCBTYWx0ZWRfXxV6VDR6xsMgO
 +kGFXchNdHnGwgXnk0xSw3F5Xk1g10J2lGlF6iaOkOcD5eq7HE2ZHuKOUYS3U6Sl6+L/59jC2a5
 ci+N090vcnFkBO8xOc3WHYRcKTVF57o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080024
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
	RCVD_IN_DNSWL_NONE(0.00)[74.125.224.69:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B089544B0E
X-Spamd-Bar: ---
Message-ID-Hash: 34GH34DHLF7GHMLHIETPFDAB32ONMHHR
X-Message-ID-Hash: 34GH34DHLF7GHMLHIETPFDAB32ONMHHR
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marouene Boubakri <marouene.boubakri@oss.nxp.com>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/34GH34DHLF7GHMLHIETPFDAB32ONMHHR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi Amir,

On Tue, Oct 6, 2026 at 2:39=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> This series adds an RPMI backend to the OP-TEE driver for RISC-V.
> It builds on the separately posted RPMI TEE transport series [1],
> which provides service discovery, synchronous calls, memory parcels
> and asynchronous signals.
>
> This revision is effectively a full rewrite of the original RFC.
> The generic RPMI transport has been separated from the OP-TEE backend,
> and the backend has been reworked around the service bus and a new
> OP-TEE control ABI.
>
> Unlike v1, the OP-TEE backend no longer manages SBI MPXY mailbox
> channels or implements RPMI TEE service-group operations directly.
> It binds to the OP-TEE service UUID on the RPMI TEE bus and uses the
> transport's public operations. No additional OP-TEE device-tree node
> is required.
>
> The backend reuses the common OP-TEE session, shared-memory, argument
> cache, call queue and RPC infrastructure. Shared memory is represented
> by RPMI parcel IDs and nonces. Yielding calls pass command and RPC
> buffer ranges within a parcel and resume suspended execution using
> an opaque token returned by OP-TEE.
>
> The OP-TEE control ABI uses fixed-width little-endian messages carried
> in TEE_CALL payloads rather than reproducing FF-A's register-based
> message layout. Asynchronous notifications use an allocated TEE-to-REE
> signal as a bottom-half doorbell, while ordinary logical notifications
> continue through the common RPC path.
>
> Matching OP-TEE OS support for this ABI has not yet been implemented.
> This remains an RFC for review of the backend integration and the
> Linux-to-OP-TEE protocol.
>
> [1] RPMI TEE transport dependency:
> https://lore.kernel.org/op-tee/20260928-riscv-rpmi-tee-abi-v1-0-04908b81d=
885@oss.qualcomm.com/
>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
> Changes in v2:
> - Effectively rewrite the backend around the separately posted RPMI
>   TEE transport and a new OP-TEE control ABI.
> - Remove backend-owned per-hart mailbox channels and the OP-TEE-specific
>   device-tree binding.
> - Replace the register-like control payload with fixed-width messages,
>   explicit command/RPC buffer ranges and opaque resume tokens.
> - Add a parcel-reference parameter layout carrying the parcel ID,
>   nonce, and 64-bit offset and size without changing parameter size.
> - Make argument-offset support part of the baseline ABI and retain
>   the common shared argument cache.
> - Use a transport-allocated signal for asynchronous bottom-half
>   notifications.
> - Link to v1: https://lore.kernel.org/r/20260912-rpmi-tee-service-grp-dev=
-v1-0-1d1d35c2a859@oss.qualcomm.com
>
> ---
> Amirreza Zarrabi (8):
>       tee: optee: allow RPMI transport builds on RISC-V
>       tee: optee: define the RPMI control and parcel-reference ABI
>       tee: optee: add RPMI shared-memory and parameter support
>       tee: optee: add RPMI dynamic shared-memory pool
>       tee: optee: add RPMI RPC handling
>       tee: optee: execute yielding RPMI calls
>       tee: optee: bind RPMI services and negotiate backend capabilities
>       tee: optee: support RPMI asynchronous notification doorbells
>
>  drivers/tee/Kconfig               |    3 +-
>  drivers/tee/optee/Kconfig         |    3 +-
>  drivers/tee/optee/Makefile        |    1 +
>  drivers/tee/optee/call.c          |    2 +
>  drivers/tee/optee/core.c          |   10 +-
>  drivers/tee/optee/optee_msg.h     |   38 +-
>  drivers/tee/optee/optee_private.h |   54 +-
>  drivers/tee/optee/optee_rpmi.h    |  234 ++++++++
>  drivers/tee/optee/rpmi_abi.c      | 1059 +++++++++++++++++++++++++++++++=
++++++
>  9 files changed, 1389 insertions(+), 15 deletions(-)

The rpmi changes in the optee driver harmonize quite well with the
rest of the driver, but there are two things I'd like fixed:
- avoid <linux/cleanup.h> macros. They are distracting.
- use rc for the trivial int ERRNO values.

I would be great with a QEMU-based end-to-end prototype to demonstrate
that the ABI works.

More comments to come in the individual patches.

Cheers,
Jens
