Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F558606A32C
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=erN7RJQY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RzbpZ5cg
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5C5BF4549E
	for <op-tee@archiver.kernel.org>; Thu,  5 Nov 2026 15:28:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=erN7RJQY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RzbpZ5cg;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6CE1F43A89
	for <op-tee@lists.trustedfirmware.org>; Thu,  5 Nov 2026 15:28:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQV521657306
	for <op-tee@lists.trustedfirmware.org>; Thu, 5 Nov 2026 15:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3Jpc3SZnRBCGFVTrfa/OmpovyQbm7JH9w6IeqIWcWtE=; b=erN7RJQYI30JCmNw
	9Fl6qoz02sF069X1xe6XsfuVz4oD9WJ9GXDu9NPfm4LmrJFqKCa2Xbr467Ag4EG1
	EqA2aE9m9F/OUXqV2Xa2TsJc2D5NQjBWnBFrX73Ew3vmKrT2QWQ9HoS9PHKxCy/j
	CE2sR2fR2cE5HFWGsWzFFg2bhGOoCvSmgk1GJ3QhbA2YyQRO/zrBHjywndpsqlOQ
	gANEbxGT0c7fwDpQch0+Jc0PoP6nFly4TGr0JFaRhSzEZWhDT1p18OldDpCLvhH9
	f1sQWaHgDSoAkbc2jwGPMpAT2nrj1CttILQFRnmT93JJf7SolyiKwPZh8/N6fxNa
	j7Nisw==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9f9eut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 15:28:04 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-679a3664e1fso3220660d50.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 05 Nov 2026 07:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892484; cv=none;
        d=google.com; s=arc-20260327;
        b=f2AwxD6TmcFEfv+Ws6GdOC8UdyNve6GYocoj4JSal25rmkbYOrSHF3SgD3DxAIqsYt
         3F+GF9vzVYq3MX91onuy1j3C6NFXwZoVGMnLSZZW3JnWQ8VjazRAU0ofL9d/zNBKcu3D
         Mymw8EOne1tTwzW6Hs25qa6eMWkPaiZqDOJI3hadb3Eg6MHWwr8KyhRGfEhxMPmWLAfx
         FGAoGro+OcnY73+xG4GVGLx3HL5j1FLzCg4sUHNdmlBIJ8NM+gMTQBujMcO5ihtsUG9X
         5dThu/c01w7tF4ZzecehBxUfymBxcrkVsyUf9ZFnaPtVJqkDLZq5x1jn+t83yo4e142j
         DJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Jpc3SZnRBCGFVTrfa/OmpovyQbm7JH9w6IeqIWcWtE=;
        fh=zmpg94HhNY9FqNyu07v9eb1x3KbcrrE6g0mSTWdeIAM=;
        b=Ygy5p+kLK03xcNvs2S/WCQZ91gHzU8uF5I+eKF8UBCV4p3eqlTacnYBQ+K82MDZVlE
         E/9qkzRfYFqcydeP6LZU5guYBjpPLByYjVBnj7ZNh99cnLZUSgmkF0ahY0t18d31fDCy
         4655jo/aiLH3eCvQGu4mdQRO9DFYvC2TZg9PGMisAkI838LC85JkDlkM4I9v+jGxXxHP
         ggsQH7MUOzn7s8ofZwK5Nbc2f4YWe5tiHJTncs8QCy0oTINaNOXZrml+UdYn43AYNfjw
         WYj5rFC1UzqDHcjSyorp0zsje+lLaOdc7s2l9LDT8HJBzwmyGa5vlSoFYZpIFoX9CrPf
         08dw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793892484; x=1794497284; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Jpc3SZnRBCGFVTrfa/OmpovyQbm7JH9w6IeqIWcWtE=;
        b=RzbpZ5cgCD+DQ45EA/ihcn+WrZIgeOoVihAQn7HOI0UuQ8TgDEiqoiDpjWlxV3II4o
         9/NLuNPOd6p2dDFf8xgaksmQJ0LAeQjfg5B0a69Pvw80ZCKy/gZJ3Ld8jIA2MT4AG1Te
         LQqgBU3LU0ZhN1+3gIhkSXlJwsaCpXwlsPUeX5oeuM91fVqKjQPQByIaHQ/c7TdDevkl
         Uu+nRZfH6MjDSPLF2+WAkLTFkzDCBXPg5ORY4Rxvu6NrCzNZtt3JxVngFwS6ErgCUXCc
         Oro75KaSiMsFQlV0pg+2olXow4P5CtLg3Z5QMTKwoQflqeBBGYKMJotdXZAM192UVhWz
         a+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892484; x=1794497284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Jpc3SZnRBCGFVTrfa/OmpovyQbm7JH9w6IeqIWcWtE=;
        b=Ql0Vmpi1Ayuut43PHK16mGT0LP51/5vHBRLRj6d3rBcITdcLuGEXeBteWSBtK72mFF
         FltwCzsA2ZJRHFZYw9edF5W14B05sQscRn9uTCCJNbylTfXlCDR0NUzCTdKj5iwI1UaY
         zgSBTA0nvCw+dTZwUzJXmUc9Sc8mphxemjbzeTdcUcVr52MGqWChC6R9Mobmh28X11Ip
         g0IzEpqS/9eRK66wHToZm/TynOSZpgnGPgcACWV8Yxpe2/6IBHyHoHjXjRf8P1tuVUzS
         8Ehas5Tryg5JhjbNM9A90OHMNhsci7fo1pvj9KQWqkPtZHXrz7MZX07igLRmo7meCqpF
         0poQ==
X-Forwarded-Encrypted: i=1; AKwUvBwWXskmMsKLCvNZhIsETDoN0yOxxcm239/IuzqBoTCgpQuDKqU+tmk7ZMaxNmysim6HjPUHwOM=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z+xhTmlOt8j/nCYtmljWPhfbJpvzoEtY9GIvD/MkQjZNpA1vvEy
	3R+SmchpSSiiKJeQ3JwjGA54Nw8pEM2DZTMqdTHii9EsXGw9hww6OVdUL/4nqJlxWQu39QRL+9G
	uXzL9RpYoeH51bcgOay9EzrER1gPuFNF/hQrDMqDhUpyeDGl2Ge7STxyE2QPNWcoT8Mb2DFhnHj
	We80y/ME6K7pNaEkBvyzI3Zprt5msO11Xvj/BFxG1Eh6kutsU=
X-Gm-Gg: AYBFou0xIs2WYjGBHd7siKU9bLHUMUwQT3fIwfObdRkI7Au9u1dowV0kH5A46hG7Atn
	DAr1QoPPh91U6fFDyfKCOIBHGiOMBgLK3CNCHsgEUiD4spNab4fVDD8rT0DVwj1hH8HxD3uqpxn
	prtJQYinnFTy3Hja5zqDjyyIGCtg3sSDRslKa6d9V9eakLkBp/2zmBcSVRzitN49+UqX/FoHQdQ
	IZm8j5uJ8INgtuTxUBBXQ0lId+94/mt0ryrRyG0
X-Received: by 2002:a05:690e:12ca:b0:67b:f91c:10ac with SMTP id 956f58d0204a3-67bf91c25ebmr2670867d50.38.1793892483940;
        Thu, 05 Nov 2026 07:28:03 -0800 (PST)
X-Received: by 2002:a05:690e:12ca:b0:67b:f91c:10ac with SMTP id
 956f58d0204a3-67bf91c25ebmr2670835d50.38.1793892483108; Thu, 05 Nov 2026
 07:28:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103171504.910646-1-marouene.boubakri@oss.nxp.com>
In-Reply-To: <20261103171504.910646-1-marouene.boubakri@oss.nxp.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 16:27:51 +0100
X-Gm-Features: AclHuK-V6NedIsLJGXklLwOUQ4WpAnW5H1oe6zWfRV0ROVyeYZzKMtvDZEcttHo
Message-ID: <CAGgiveV2+Vc_b7s0OF5naUNXzDzEtiTUgtoAz1B9zCFOJS6oFw@mail.gmail.com>
Subject: Re: [PATCH v5] tee: optee: build the Arm-specific code only on Arm
To: marouene.boubakri@oss.nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX6d+W0nzwoH3A
 FqrqL2ugyTSHJ24JEmtRF+qrGRGSavW8zPSml+UsyQa5xL3SZrPY2k79xAskv80RzlfEFOHjnTC
 synDMrVWLq5DU/WMxAshQS1A83cDimlvdFNcW3sKBpcZvxhzxSAZCasZQ9q5Ou4oo11l912oo7V
 fC9SxF7in6Q404v+2zmrtMztyIij5L7D19sLA0kiBNIksLCH0EipjW1onILAtvGG5ToKoGxciiL
 3M8dl537/ocmK0EdzHEqVtbkJD/GXe8d6elxkGzvzQ4Xr4G/cFICmYHz24bga86/vL4Z3D4LC5M
 j/uLVpq2I9pKSHp4zhmHg+GvoRo819sY9v3sWCP0Cxjx2VLseZSjfryTe+rHV4DUSIWWQrmx65V
 sHiHABw7LAfsVcFNS74aHc1jH13nn9iZy2L/fMd+SC0WwsLUc5opwb1eoLLx5ucEGedZc0bXK4B
 U+GM9iLcAkKDTaIxZPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2MSBTYWx0ZWRfX6+mdULSlP9Bl
 kokfu6crqixgWhzSwkafHncMq7n4iwwlEBsWkJn0Ymq8vlBuLtWIkPhs8fwuEPY5EXev0NzoFs+
 aNXfxaN0N1qo4LddPmpRm8vMIlkf2w4=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aeca084 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=8AirrxEcAAAA:8
 a=QSRX11TqfzdV6SOrKsoA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: zboFUu7gKAXa9wHvSzuk7fknjACz-Rbg
X-Proofpoint-GUID: zboFUu7gKAXa9wHvSzuk7fknjACz-Rbg
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
	BAYES_HAM(-3.00)[100.00%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	MIME_GOOD(-0.10)[text/plain];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[205.220.180.131:from,74.125.224.69:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6CE1F43A89
X-Spamd-Bar: -----
Message-ID-Hash: JXUN35MSW54B534G25NWW6RRYNVYAXPB
X-Message-ID-Hash: JXUN35MSW54B534G25NWW6RRYNVYAXPB
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: jenswi@kernel.org, sumit.garg@kernel.org, arnd@arndb.de, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, amirreza.zarrabi@oss.qualcomm.com, peter.lin@sifive.com
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JXUN35MSW54B534G25NWW6RRYNVYAXPB/>
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

On Tue, Nov 3, 2026 at 6:01=E2=80=AFPM <marouene.boubakri@oss.nxp.com> wrot=
e:
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
> the FF-A transport is enabled, and provide stubs for their registration
> otherwise, so that it fails with -EOPNOTSUPP as the FF-A ABI already
> does when the FF-A transport is not reachable. Keep the SMCCC header,
> the SMC invoke function type, the SMC and FF-A specific structures and
> the SMC RPC register parameters in optee_private.h under the same
> conditions, and drop the unused <linux/arm-smccc.h> include from
> notif.c.
>
> Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT, as it
> already does for RPMB, so that the driver is limited to a module when
> the FF-A transport is one, rather than built in without FF-A support.
> ffa_abi.c is thus built exactly when the FF-A transport is enabled,
> and the FF-A transport is then always reachable from the driver: key
> the FF-A parts of optee_private.h on IS_ENABLED(), so that the layout
> of struct optee does not depend on whether the including code is built
> in or modular, and drop the now always true IS_REACHABLE() checks in
> optee_ffa_abi_register() and optee_ffa_abi_unregister().
>
> OPTEE still depends on HAVE_ARM_SMCCC, so smc_abi.c is still always
> built. The only visible change is that OPTEE=3Dy can no longer be
> combined with ARM_FFA_TRANSPORT=3Dm: such a configuration now resolves to
> OPTEE=3Dm, with the FF-A ABI available.
>
> Signed-off-by: Marouene Boubakri <marouene.boubakri@oss.nxp.com>
> ---
> Changes in v5:
> - Replace IS_REACHABLE(CONFIG_ARM_FFA_TRANSPORT) with
>   IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT) in optee_private.h: with OPTEE
>   depending on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT the FF-A
>   transport is always reachable when enabled, and IS_REACHABLE() made
>   the presence of the 'ffa' member of struct optee depend on whether
>   the includer is built in or modular (Arnd, Jens).
> - Update the commit message accordingly.
> v4: https://lore.kernel.org/all/20260924105145.532787-1-marouene.boubakri=
@oss.nxp.com/
>
> Changes in v4:
> - Make OPTEE depend on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT so that
>   the driver is limited to =3Dm when the FF-A transport is =3Dm (Jens).
> - Update the commit message accordingly.
> v3: https://lore.kernel.org/all/20260922131735.524635-1-marouene.boubakri=
@oss.nxp.com/
>
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
>  drivers/tee/optee/Kconfig         |  1 +
>  drivers/tee/optee/Makefile        |  4 ++--
>  drivers/tee/optee/ffa_abi.c       |  8 ++-----
>  drivers/tee/optee/notif.c         |  1 -
>  drivers/tee/optee/optee_private.h | 39 ++++++++++++++++++++++++++++++-
>  5 files changed, 43 insertions(+), 10 deletions(-)

Looks good. I'm picking this up.

Cheers,
Jens

>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index 50d2051..891dac6 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -5,6 +5,7 @@ config OPTEE
>         depends on HAVE_ARM_SMCCC
>         depends on MMU
>         depends on RPMB || !RPMB
> +       depends on ARM_FFA_TRANSPORT || !ARM_FFA_TRANSPORT
>         help
>           This implements the OP-TEE Trusted Execution Environment (TEE)
>           driver.
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
> +#if IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)
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
> +#if IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)
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
> +#if IS_ENABLED(CONFIG_ARM_FFA_TRANSPORT)
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
