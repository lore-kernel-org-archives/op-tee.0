Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478ADC98304
	for <op-tee@archiver.kernel.org>; Wed, 23 Sep 2026 14:04:35 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7880B45219
	for <op-tee@archiver.kernel.org>; Wed, 23 Sep 2026 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1790172274;
	bh=Se0afsEPP0FXjj+86JanuVzxFWSwP38EfVdhRpBurXQ=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=YUclKkUAeaNGOu2q26V2BMB733IM7UQsnHKhmGzKUOSIjSA2Vk6jH3Ohj1Tcy/60I
	 w5FgVbypTAfhcuUpDwER+06xy0leB7ki+BtYnZiyEGTVvvUv6aHKNxH6NAjZrQSTcZ
	 y2rZXBh8xuN6p2N6oOsby2kl/Bt5wrpygCjuZkWIVkNfqIKealhWUknxzfAbi5QbrV
	 t9+LwYrTwopz0oRbYvnJnmUMq7qleh94OerEq4fHbIkMcMDEgx+di72crKNKwmvysB
	 0OZJ7Yhzp3nLgIV3oOwgXTj327xHXBYMFbwjdVMpQ49rIRfCBO0FQBJ47Xm24g+h11
	 r6NB6Qchxw08g==
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 25D244437F
	for <op-tee@lists.trustedfirmware.org>; Wed, 23 Sep 2026 14:04:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=czBYGUt7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OobB/gBQ;
	dkim-atps=neutral
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbVp93772094
	for <op-tee@lists.trustedfirmware.org>; Wed, 23 Sep 2026 14:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RUXKudTNYRkjkcRMUBw+hNaRYWoi0rr6zfNliaS2E8A=; b=czBYGUt7dorwavSp
	7cNodHIkXwFMSqaK9pA7wHknL1Bv8/XXACcONIh1HDZ0+A/7YqMvH5nLwYv2k1Oy
	BU5Qp/wXu4SH6G2Id0EaYPS9kt+joe9s8OdKayxV2+jE3iXgIGebgwGuI120jL2X
	uXkg37MC7Ks235TEvb0/pQU8fgoR/GjGfkmPZhBUGWe2TMArk5tVmg2wR5CRW0ZF
	vAl8SNwsZdGFNW7GKNV7w8/F0o1f+tX8SByeQ5UewijknLQ73uI4KmTd8ArR5P8F
	+7wlTSAaXFcJnFDZ8RH6hmkSE6k7Np6VdHf7lq6o2Ydbv0eHeSmoRvrAki0yriPN
	iRfMCA==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvdb60ry9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Wed, 23 Sep 2026 14:04:26 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-85da2b96c35so19046207b3.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 23 Sep 2026 07:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790172266; cv=none;
        d=google.com; s=arc-20260327;
        b=bc7P3comfg8iKb2u4ldU3ZtPyulITbmSc0DOkfQB5yh+ZsgFW1QxswXLuGpNaqbQl1
         1a+Xz8EuJLyYOwGgU7j4KVBITQyknU81IFRiPXEWctRZf1/44OoQ0xP8BSc688mbLzMk
         jj5sg54iyGMfHC6jaB/rUBtFdY3hKUDPxMQnZle2qfraLsJ3wP4faU5OsHXooVPrUjLe
         V9PTcvbzRCB8dYksrVsCegTY+paxIzF0e9up/9uFPwdElVGQ4NS0irhs0BiDW53eLHH7
         5Vpc1M+M1LtUkzzsdc9azmtXtqJachzHAClh0y/8qd9PXRyL31hBGzVfRU3q77xvy13z
         uWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RUXKudTNYRkjkcRMUBw+hNaRYWoi0rr6zfNliaS2E8A=;
        fh=VyZhHHQq+vfGz6jtJTyf5F1x1E8+uD7eRFFYJjNOcc4=;
        b=QWen+fUNcvTYn+my6yh72Y7feBh0+DY/w5C5q1aIJPa6m3uhIPhGuiwAhTZA9yWssu
         lNPWZKAx0WZaPhZdkVyGmnsb+t/o9GEp77YU0GPU6JyVOzTAgo8HmlIc4IMEJBkkoTD0
         KUMh5gkhLe0KgWcnNGB1PylAAhcNduQpf8yxVz1pV1IoemyP/67MtFUkAd/cqPn3N34E
         qDLE7xkaz4t9WCUGE0u7m5QRX6SQRt291ZnXQCeAPPttTS3GyxSl57NcoMi8Cc89SBuj
         2i9vhWme9JHgmxTucy0wsR0n4s/Df5vywN/VTpYGMlB97joA09+9bZmulR7bApgx5C6K
         +tuw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790172266; x=1790777066; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RUXKudTNYRkjkcRMUBw+hNaRYWoi0rr6zfNliaS2E8A=;
        b=OobB/gBQOs8HxKc0/dfiVeqyp562hRUCsi+0Q5cRtshlxlWjjYxJ6/9LODe6rvblHZ
         C5tXer1q0qVUYZ3usfv8xll3DKr8qKWU5AZALaHpK/4+sYfD4RHY+bOlv1t5imtxLsVY
         SvsFnfPQV7E2Y7Ep7PqqcF0qpihiuhPQafnTnhiXUbF+DKcOn7PgcRbEuIZ7Ola2B5gh
         6iFFVkxk+mIViFW/FwZecsWUnG6Eoxt0rCzQFNolUgHFzIqaJmcYaHbLo/CmClQ2P2VT
         89SUuDDBQOQ0gqrLIJtSOdz400c8H0IDMmumQ/aPQ64XXCAFMToVOWagqVlLcbzMcdKS
         X52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172266; x=1790777066;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUXKudTNYRkjkcRMUBw+hNaRYWoi0rr6zfNliaS2E8A=;
        b=WgJr0giRezkliVYmQtegsW17sapa7zywbO/VAKMpMe3HxDIzz4xpfYwlv3jSFXj2Gv
         rztTaMsg8PnS175IUmrvxcVE9udX+bsuUmbzlT+LYwNGow7CqRhVBcz82UwNfFfogChE
         d+WZwIMR7f4VWnD94++bln+F/E8arIm+S3+Rmx7ZlXShMA15TFl/UZVeLfI50WPDwEEX
         57My7Cnl1ZMN2eNNYyf2xw+YaF2cTaYodCYaxVzcEglhICDEAvvHBg0DATQ777RUkxEW
         r8UQqjq7xckVtC2857uWVe3JCC6PfVlAhFplAuUYIAEdxLGNnnGzWbqsha+qb+8O0Qsx
         nFCg==
X-Forwarded-Encrypted: i=1; AKwUvBwIxisFegPyoDoNcyHZwRsYZTd4ApeR7r61zOsDfqvBtbX4RIg1kQu9qu0qooUaWzdKL4Ahf74=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++n5XoOxkjGoXUROaaYnQWVV4Zm1JCR1r26EYKuWC7lSXBX9SqP3
	mzpxGGXn/bbXJQugCEud89sbNhJyFVu106IZUpelFeyaep46ZZBXCwiW2CIe0EV28IT4ErL8Kz2
	P+uhi/Et07x0Ururl/JEq4u/vED224Ju7Q+UN8azdttrUBjpG2H70/Y1ZYof5+Z7DVq05r+UC/v
	8oqYBKaTeSIHFPdqWwsp3/Dio+9fw5oqKxxsvSdgSnp3fH4wA=
X-Gm-Gg: AYBFou0XjjGx1JKdvWPSuIuVapdsjxv5AjEH6dQzefqiHKfk6RGVgA+NvefLP9N4wok
	eW4pCrtyZdorOCg28U1PpP4dziXBAIwcIw5MfxRkVsqHh/REQqQLcHS8UPy+jeGQG/qUJrxweTB
	TZuRwkHBgH0iEJZzeRJ5Bh1MB2V6Qo3pt4LCFXV183fUYW0VkkLL0qYxo=
X-Received: by 2002:a05:690c:e3cf:b0:86c:c7a8:2ebd with SMTP id 00721157ae682-8a45afa5e8fmr18610507b3.34.1790172265564;
        Wed, 23 Sep 2026 07:04:25 -0700 (PDT)
X-Received: by 2002:a05:690c:e3cf:b0:86c:c7a8:2ebd with SMTP id
 00721157ae682-8a45afa5e8fmr18609887b3.34.1790172264973; Wed, 23 Sep 2026
 07:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260922131735.524635-1-marouene.boubakri@oss.nxp.com>
In-Reply-To: <20260922131735.524635-1-marouene.boubakri@oss.nxp.com>
Date: Wed, 23 Sep 2026 16:04:13 +0200
X-Gm-Features: AclHuK8BjLW6J8lXasYZWu38EGIbC1BxDyDBkkPm0GiEF2_C5KVvAqvITCDgvlY
Message-ID: <CAGgiveXEa=EXed3fJ7+rEr5-8aEX--jF90PtkhXPoWJg0Hv8jQ@mail.gmail.com>
Subject: Re: [PATCH v3] tee: optee: build the Arm-specific code only on Arm
To: marouene.boubakri@oss.nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jPykxdkWBa2SlnIuktvRoItUtZA4Vvu3
X-Proofpoint-ORIG-GUID: jPykxdkWBa2SlnIuktvRoItUtZA4Vvu3
X-Authority-Analysis: v=2.4 cv=QeXzLcbv c=1 sm=1 tr=0 ts=6ab3dc6a cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=4M5lNuO9mvEfoSjbydwA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfXwwoRCgOlCYLd
 HlSZX9SPZGgMFJ8ebqnEZurHBPJfx8bI7CHJqX77deLZcrFQw+1UNXuEphArrGD3QYeTzuGll5P
 DPER6kokNw81aWVKVZjPWP7ubxpJmmM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1NiBTYWx0ZWRfX/okKOb+aXmRt
 jm/XOQmTNuYbsBKsiS29g/jx1Oq5vP5uS4QPqwrL0wU1/181ApX/gAPJavlwAjvtdveLhw8tmHB
 kmUK4UsYry3DyExXaFyBUFRQlYlvhz44PSJZajCnOYmhgnLfSFozxHzURd6yIkKHZCnzdBlD1QP
 Dbi+bmF+Qczw+EVqLv++tJgb4HzI3zDZYi2QJ/9nJiLsLwxIPgUVlzDHoWdmejwZiVtIhn8LAb5
 Qy7TzPqCpeQub6lzu75I27aail8Sbg4oTbHR/NngyRhIcLZxBkphTSrsIQCkqTxEQE9vWZFlxJW
 Evaa5RtYKGdiKOCCzQCJlga0zzpYhQLgA567rj2W6v7LFkmq8vQIxXuQioRxc19+MH7NPlDEStW
 VqZg2jjmuN0R6+tG0vYb8zvHh6DtHqYRLPOJmo+XqaLN6YvEtgUJ+5/z4fqAmvHjOB8O5FagFZi
 1l7kRXInJwmARTiIsgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.199:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 25D244437F
X-Spamd-Bar: -----
Message-ID-Hash: 6FJ27UIDS553S4L4OUARYFSTAYFCFIMS
X-Message-ID-Hash: 6FJ27UIDS553S4L4OUARYFSTAYFCFIMS
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: jenswi@kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, amirreza.zarrabi@oss.qualcomm.com, peter.lin@sifive.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/6FJ27UIDS553S4L4OUARYFSTAYFCFIMS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Jens Wiklander via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Jens Wiklander <jens.wiklander@oss.qualcomm.com>

Hi,

On Tue, Sep 22, 2026 at 3:03=E2=80=AFPM <marouene.boubakri@oss.nxp.com> wro=
te:
>
> From: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
>
> The OP-TEE driver reaches OP-TEE through the SMC ABI or the FF-A ABI,
> both specific to Arm, yet builds both unconditionally together with the
> SMC Calling Convention definitions they rely on: ffa_abi.c is always
> compiled and only its registration is conditioned on
> IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT), and optee_private.h includes
> <linux/arm-smccc.h> and defines the SMC and FF-A specific types for
> every file of the driver. This is fine as long as the driver depends on
> HAVE_ARM_SMCCC, but it keeps the driver from being built for an
> architecture without SMCCC, such as RISC-V.
>
> Build smc_abi.c only when HAVE_ARM_SMCCC is set and ffa_abi.c only when
> the FF-A transport is reachable, and provide stubs for their
> registration otherwise, so that it fails with -EOPNOTSUPP as the FF-A
> ABI already does when the FF-A transport is not reachable. Keep the
> SMCCC header, the SMC invoke function type, the SMC and FF-A specific
> structures and the SMC RPC register parameters in optee_private.h under
> the same conditions, and drop the unused <linux/arm-smccc.h> include
> from notif.c.
>
> The FF-A parts are keyed on IS_REACHABLE() rather than IS_ENABLED() to
> preserve the behaviour of a built-in driver with a modular FF-A
> transport: kbuild does not link the optee-m objects into a built-in
> optee.o, so ffa_abi.c is left out exactly when the transport is not
> reachable and the stubs are used instead. The IS_REACHABLE() checks in
> optee_ffa_abi_register() and optee_ffa_abi_unregister() are always true
> once ffa_abi.c is only compiled in that case, so drop them.
>
> No functional change: OPTEE still depends on HAVE_ARM_SMCCC, and
> ffa_abi.c is still built whenever the FF-A ABI can be registered.
>
> Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
> ---
> Changes in v3:
> - Dropped the RPMI ABI placeholder and the RISC-V enablement patches,
>   this is now a single patch (Jens).
> - Key the FF-A parts of optee_private.h on IS_REACHABLE() instead of
>   IS_ENABLED(): with OPTEE=3Dy and ARM_FFA_TRANSPORT=3Dm kbuild drops
>   ffa_abi.o from the built-in optee.o while optee_ffa_abi_register()
>   was still declared, which does not link.
> - Drop the now always true IS_REACHABLE() checks in
>   optee_ffa_abi_register() and optee_ffa_abi_unregister().
> - Describe the current FF-A conditional compilation accurately in the
>   commit message.
> - Posted as a new thread with a proper subject prefix.
> v2: https://lore.kernel.org/op-tee/20260915020235.507302-2-marouene.bouba=
kri@oss.nxp.com/
>
> Changes in v2:
> - No code change, the testing section of the cover letter was completed.
> v1: https://lore.kernel.org/op-tee/20260914175435.118303-2-marouene.bouba=
kri@oss.nxp.com/
>  drivers/tee/optee/Makefile        |  4 ++--
>  drivers/tee/optee/ffa_abi.c       |  8 ++-----
>  drivers/tee/optee/notif.c         |  1 -
>  drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++-
>  4 files changed, 42 insertions(+), 10 deletions(-)

Looks good, but I think that while we're at it, we should add
--- a/drivers/tee/optee/Kconfig
+++ b/drivers/tee/optee/Kconfig
@@ -5,6 +5,7 @@ config OPTEE
        depends on HAVE_ARM_SMCCC
        depends on MMU
        depends on RPMB || !RPMB
+       depends on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT
        help
          This implements the OP-TEE Trusted Execution Environment (TEE)
          driver.

to make the optee driver a module if the FF-A transport is a module.

Cheers,
Jens

>
> diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> index ad7049c..183cdde 100644
> --- a/drivers/tee/optee/Makefile
> +++ b/drivers/tee/optee/Makefile
> @@ -7,8 +7,8 @@ optee-objs +=3D rpc.o
>  optee-objs +=3D protmem.o
>  optee-objs +=3D supp.o
>  optee-objs +=3D device.o
> -optee-objs +=3D smc_abi.o
> -optee-objs +=3D ffa_abi.o
> +optee-$(CONFIG_HAVE_ARM_SMCCC) +=3D smc_abi.o
> +optee-$(CONFIG_ARM_FFA_TRANSPORT) +=3D ffa_abi.o
>
>  # for tracing framework to find optee_trace.h
>  CFLAGS_smc_abi.o :=3D -I$(src)
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 633715b..08236d8 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -1212,14 +1212,10 @@ static struct ffa_driver optee_ffa_driver =3D {
>
>  int optee_ffa_abi_register(void)
>  {
> -       if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
> -               return ffa_register(&optee_ffa_driver);
> -       else
> -               return -EOPNOTSUPP;
> +       return ffa_register(&optee_ffa_driver);
>  }
>
>  void optee_ffa_abi_unregister(void)
>  {
> -       if (IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT))
> -               ffa_unregister(&optee_ffa_driver);
> +       ffa_unregister(&optee_ffa_driver);
>  }
> diff --git a/drivers/tee/optee/notif.c b/drivers/tee/optee/notif.c
> index 6e85f2f..6801422 100644
> --- a/drivers/tee/optee/notif.c
> +++ b/drivers/tee/optee/notif.c
> @@ -5,7 +5,6 @@
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> -#include <linux/arm-smccc.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> index aefe1e6..02d6f79 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -6,7 +6,6 @@
>  #ifndef OPTEE_PRIVATE_H
>  #define OPTEE_PRIVATE_H
>
> -#include <linux/arm-smccc.h>
>  #include <linux/notifier.h>
>  #include <linux/rhashtable.h>
>  #include <linux/rpmb.h>
> @@ -15,6 +14,10 @@
>  #include <linux/types.h>
>  #include "optee_msg.h"
>
> +#ifdef CONFIG_HAVE_ARM_SMCCC
> +#include <linux/arm-smccc.h>
> +#endif
> +
>  #define DRIVER_NAME "optee"
>
>  #define OPTEE_MAX_ARG_SIZE     1024
> @@ -42,10 +45,12 @@
>   */
>  #define OPTEE_DEFAULT_MAX_NOTIF_VALUE  255
>
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned lo=
ng,
>                                 unsigned long, unsigned long, unsigned lo=
ng,
>                                 unsigned long, unsigned long,
>                                 struct arm_smccc_res *);
> +#endif
>
>  /**
>   * struct optee_call_waiter - TEE entry may need to wait for a free TEE =
thread
> @@ -119,6 +124,7 @@ struct optee_supp {
>         struct completion reqs_c;
>  };
>
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  /**
>   * struct optee_pcpu - per cpu notif private struct passed to work funct=
ions
>   * @optee:     optee device reference
> @@ -149,7 +155,9 @@ struct optee_smc {
>         struct work_struct notif_pcpu_work;
>         unsigned int notif_cpuhp_state;
>  };
> +#endif
>
> +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>  /**
>   * struct optee_ffa -  FFA communication struct
>   * @ffa_dev:           FFA device, contains the destination id, the id o=
f
> @@ -170,6 +178,7 @@ struct optee_ffa {
>         struct workqueue_struct *notif_wq;
>         struct work_struct notif_work;
>  };
> +#endif
>
>  struct optee;
>
> @@ -257,8 +266,12 @@ struct optee {
>         const struct optee_ops *ops;
>         struct tee_context *ctx;
>         union {
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>                 struct optee_smc smc;
> +#endif
> +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>                 struct optee_ffa ffa;
> +#endif
>         };
>         struct optee_shm_arg_cache shm_arg_cache;
>         struct optee_call_queue call_queue;
> @@ -290,6 +303,7 @@ struct optee_context_data {
>         struct list_head sess_list;
>  };
>
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  struct optee_rpc_param {
>         u32     a0;
>         u32     a1;
> @@ -300,6 +314,7 @@ struct optee_rpc_param {
>         u32     a6;
>         u32     a7;
>  };
> +#endif
>
>  /* Holds context that is preserved during one STD call */
>  struct optee_call_ctx {
> @@ -422,9 +437,31 @@ static inline void reg_pair_from_64(u32 *reg0, u32 *=
reg1, u64 val)
>  }
>
>  /* Registration of the ABIs */
> +#ifdef CONFIG_HAVE_ARM_SMCCC
>  int optee_smc_abi_register(void);
>  void optee_smc_abi_unregister(void);
> +#else
> +static inline int optee_smc_abi_register(void)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void optee_smc_abi_unregister(void)
> +{
> +}
> +#endif
> +#if IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT)
>  int optee_ffa_abi_register(void);
>  void optee_ffa_abi_unregister(void);
> +#else
> +static inline int optee_ffa_abi_register(void)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void optee_ffa_abi_unregister(void)
> +{
> +}
> +#endif
>
>  #endif /*OPTEE_PRIVATE_H*/
>
> base-commit: 827751b699b79a6e569983359c02dce67f81b94c
> --
> 2.43.0
>
