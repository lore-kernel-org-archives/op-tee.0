Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D450606A6BA
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIDsYu9H;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKLDdoGF
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id CB27E454F7
	for <op-tee@archiver.kernel.org>; Tue, 24 Nov 2026 09:48:25 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cIDsYu9H;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WKLDdoGF;
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4C20044A40
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 09:48:20 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO5lpiP2848067
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 09:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PYXPyQn5i+rKtffQDXwKT7j2n2EdeKt2c28XS2Q64K4=; b=cIDsYu9HJ9HN1b8Y
	hZKFIAXF0MFNqUwmdTocHq+Ey3Q6CZqgudQwT38Ke70o8MIoJjDUGJIFLEF8E2iI
	5gWITQ0qqy7ZrBkVx5yBtwToDWUotcZoNYxD+NTF5QxVnjtbqrOyYbcYStTSVyEj
	wXWpzHVxcm2Jy5HlmHMTfcekbHRbG2dZ8jZGVdWOgLFvlGK68l6icq92vcMGDAnW
	D6/O/PiEDBKnSvcWEf/19M0CCiuate2SqM0rCldvk9/jknznjqOFzGKk7zAaQAqI
	BcgYLh/MgFujzJr4Z39PZ5NwNjjbEH7lNk6+gvApQFodyfPAZcoTq4yQcc9aOECh
	9HsAcw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rh8xu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 09:48:18 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67906c453b8so6337119d50.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 24 Nov 2026 01:48:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795513697; cv=none;
        d=google.com; s=arc-20260327;
        b=X6tO7HHL7sK4z5qu34OQiL9JGLQhVPC/K4W4cPfuS9rhBu4NLiTJNZ/JRwnPD8PCP3
         evQnXsLznWoEcaTQr3LQ8gmVCyKUhx6O4q0m1na+7c/ePsTIMD7h93t6G1YO4cpBI2dF
         5E38udlub6nEYoR7wYOFSCMHOslOAxDPD0iNY6kdoHDeleuFek1US3jFUzl5emlnFoQH
         dUcNDlJQlIHgWwO3xvyhy9fW2J2/9SE+wzIxv3WW0LwW72drmpvg9BJ8UcrXrXNdOKPT
         v6+eBrneLvaOSmi4KXFL4Mtm9D9r5MHN85bnuhapMmQdwCognOzzuYT7cHYROqDoTiX6
         uyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PYXPyQn5i+rKtffQDXwKT7j2n2EdeKt2c28XS2Q64K4=;
        fh=+q1oUsqADe6p18FUOwdcmh4whZgVuOvtm1HnNASqr6U=;
        b=Gcc9dXsYOGBB1DF+0AwkTCm37T2JDtdnKC+nIn8naLkhHFiC7VJrnrRjPCOozSP2J3
         Injq1LaaafSnLYuorYMsPvfRVeR7ulIPZU2CkLLM4zg20U5oBtUxRf08l+6FB4pfVHsC
         D832nUvLLdRm5IKoIBzVU3HxtNcmyeqeRbS8pNg58lBI1l1OySyP9WLnyF7FQ0VcQd41
         3QGYZXxB1kuZXx36szOQSAFQg7yeQxIgwCOgZaKCTdTCxHxTt9PA4TBOpase4tjIRwdD
         uyC1UXTfK8NhuZjjXRC96CjmfVZtcGqXErDd83Avgb/i+9tlBuBVNO+D1y/64KtddGbJ
         ouAw==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795513697; x=1796118497; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PYXPyQn5i+rKtffQDXwKT7j2n2EdeKt2c28XS2Q64K4=;
        b=WKLDdoGFPruOw5+ftMIxOMGPZy6zJ2s3NAf1vdGP+fU8SVjd2U6CsNeUKWdG8V3Tny
         sDaeDReLZuw/y24c7Vkt4Z2YcosoB9IA4QvKqD01ID+9hvH28XKpHfZAe4z/1q1ayJAy
         IX22m9mRPHsP8lMNNLPN250hRMG6VRegDubO/HYc4WDlQLRMtOjZy2Dy4td5XCuKrM7v
         vLjbtgPcck6ra923jXZNydfLdmpN+Am2vI7vFN3aj02fp/3L/rh2815TJn4eSSyhbOir
         B7pa54rjEmsdyemUes3SqYlctwZzQd6J4iu2vz73AFZ5DnRhRt6uwHBFw3Wg9/v+qcb6
         up+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513697; x=1796118497;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PYXPyQn5i+rKtffQDXwKT7j2n2EdeKt2c28XS2Q64K4=;
        b=VFE6j3BrkvY9w5G8U9nWNO4KoXK5rDC60BCkMCCfXuw7TDky8yiH7e+6y54pJlx1yu
         HYjxkbL26Wxh49Btq0HeGumhG/Ym8MqgOfIZWjN3E8fj4+pY0grFkpccv3TFzh+yQJ0X
         08f7/ya+kVwLekLNYmwQxGTZq2tBOmYB8MEzc3q543G4eQStxPAtsJ8vSPi+KPJvsijp
         ox3RngduplsmBGVP8xWfqj0SRJB117hUa4Vy+JGrwaXQA3RK9+2LwDFBvOJoCy61slIc
         wK4xF56z4ALc3Xq+q4Dr1YnrOUbCism/+Sk6VIcqOVa7h3ajpn9WFfxj5NtKl0RufvUn
         6CkQ==
X-Forwarded-Encrypted: i=1; AL+hErGhiOlQLxL0Z9wtidwQ+wHvo0C04pAfxdn0Fr6l9Xx5WdY0EkywGEpZdDXfRYMvq9oCqeQjKK0=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z8fHLdOMNdtUhFRRVpsdAhYG24BWN/i5Xo/by5R5oQCyTMl3iiL
	DWm8p/rovAywGuXDeVeNAhksDbUS+kH1xO+djCyFTBe9HVC4wnU4ZvWtv9b2I5FUgmn8jiH6k2q
	fteG+WjUsMY9EGf9nXVy+p7kzbbIzHRZ5InEab6Q/rYg1PautKmak4/48+zsG5uwfBo1TJBT35g
	aqS2BzZqzFVlYHpp0d3ZTH3ESJR2OfPlTaMwdkAQbEI5DJU9Y=
X-Gm-Gg: AZFdTZcpD8B/Skb1bPzWFydfmCH93/pnYAg2wSHanN7/hVvzam78ZOr6STlS3E+jvEK
	oVzFPRHy1pZDcCPupCubkdnq3ECf+3GYwl9lSh96ljfAYTgYEAx2KjxauUPnBwyLmtQcC0hZ23u
	uqpmdoJ+s5mzQ9GMOP0TU8XbmL33vmIwzyCVmrSUwSKtCcfLXbKhb6t7NWSALqTLp8IO/o5ULk5
	qm8lwugww8kqHFcCEPcfeg/NUJn5DjkR1XJwk+7
X-Received: by 2002:a05:690e:c8e:b0:66c:e21d:9ab7 with SMTP id 956f58d0204a3-67dec41ebe8mr5944859d50.12.1795513697449;
        Tue, 24 Nov 2026 01:48:17 -0800 (PST)
X-Received: by 2002:a05:690e:c8e:b0:66c:e21d:9ab7 with SMTP id
 956f58d0204a3-67dec41ebe8mr5944846d50.12.1795513696773; Tue, 24 Nov 2026
 01:48:16 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261025192555.210257-1-christian.koever-draxl@student.uibk.ac.at>
In-Reply-To: <20261025192555.210257-1-christian.koever-draxl@student.uibk.ac.at>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 10:48:06 +0100
X-Gm-Features: Aa3M54rCeSWPLabRKxpMyY7xQTHa_5h3mdus28HWlTKKE_dLD7QlkdvZ8TUkSI0
Message-ID: <CAGgiveVtFW=t15nosGVtQ79Gr5jiWTAP3U9Wc5LCfV3Rr=fehQ@mail.gmail.com>
Subject: Re: [RFC PATCH] tee: optee: allow forcing the reserved shared memory pool
To: christian.koever-draxl@student.uibk.ac.at
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=BKkmP1QG c=1 sm=1 tr=0 ts=6b055d62 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=HrFImSkvvj_0lBCYv5gA:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAzNyBTYWx0ZWRfX0kwlGfgLzDuh
 4TLEOveRwNbX4QJQheIBMjM0m82nFH6xa8c8JyW3XKryaWQyPj1Gb1gzu1eM/gRLsDlvs4r4yTE
 TCMCV++z6I9kFrwcBY5rBmBeh2Gg478=
X-Proofpoint-GUID: uxbKdWu9ZbEEpKFtUmPvp17JEJ_6p-G6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAzNyBTYWx0ZWRfXzf1LhSDNGF7F
 wu2q3FPcUWPp9pGOuQgBSuBic5ACwneE6QGV2KX5dZAzoa7crmRPP+097kG+je2NhZcBa+M85Wq
 PiQ3hIj2sm3PMQhZWHj3w06QlYOP34EMQwwodOqD2XESIlHVAHo32nR8+8ax9RUoe1AOyvoNfkK
 tSwZEu/7PXDFDyXWbFcR6TvLGAmjamWqgjNiVOMKRaqbQiQ+f7HCvFrbYclqrEsWKKPhSmbsUb6
 g5/fAFveAhDMp613702jJTsFdYPC3V6H7CYwD0pZLX5hDiuB7NDhNZktcgV1gOMvxdmtMLM+rsu
 5jIvvyAEpEp595ls6rUwrTqA4ljIeoFXC/meK+ti3hqvJJ4plHaRn5nkp/arBlPAMvAqEe/Znwf
 dDi7s5kxNhYX3Ob82a0cZvLd10aShFszcjwUbT06zuh5/1AgRnTKjQXgGS1RvIF91H1gbeL7vGJ
 1hD/OQmI/oxoQAEufjg==
X-Proofpoint-ORIG-GUID: uxbKdWu9ZbEEpKFtUmPvp17JEJ_6p-G6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.168.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.168.131:from];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:26211, ipnet:205.220.168.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.trustedfirmware.org,vger.kernel.org,outlook.de];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4C20044A40
X-Spamd-Bar: -------
Message-ID-Hash: WH4BJ5QN7DZFVG6SKOKKEBSG54572IYO
X-Message-ID-Hash: WH4BJ5QN7DZFVG6SKOKKEBSG54572IYO
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: jenswi@kernel.org, sumit.garg@kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, =?UTF-8?B?Q2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhs?= <ckoever@outlook.de>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/WH4BJ5QN7DZFVG6SKOKKEBSG54572IYO/>
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

On Sun, Oct 25, 2026 at 8:26=E2=80=AFPM
<christian.koever-draxl@student.uibk.ac.at> wrote:
>
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>
> The X98Q's vendor BL32 runs OP-TEE 3.8 and reports sec_caps 0x5, that is
> HAVE_RESERVED_SHM | DYNAMIC_SHM, with neither UNREGISTERED_SHM nor
> RPC_ARG.
>
> For that combination optee_probe() picks the dynamic pool and sets
> OPTEE_SHM_ARG_ALLOC_PRIV, so every message argument is an unregistered
> private page passed to secure world by physical address via
> OPTEE_SMC_CALL_WITH_ARG. This OP-TEE will not accept that: every call
> comes back OPTEE_SMC_RETURN_EBADADDR (4), which optee_open_session()
> converts into TEEC_ERROR_COMMUNICATION / TEEC_ORIGIN_COMMS. The result
> is that no session can be opened at all - not to the Amlogic firmware
> loading PTA the video decoder needs, and not to any built-in PTA either.
>
> Registering memory works fine, and HAVE_RESERVED_SHM is set, so the
> existing static pool path is usable. Add optee.no_dyn_shm to select it.
> With the reserved pool the device enumeration PTA opens cleanly and the
> system PTA answers with its own ACCESS_DENIED, so the ABI is healthy.
>
> The driver arguably should not use unregistered arguments unless secure
> world advertised UNREGISTERED_SHM; a parameter keeps the change local
> until that is confirmed upstream.
>
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de=
>
> ---
> Tool use (Documentation/process/generated-content.rst):
> This work was done with the help of an AI coding assistant, Claude
> (Anthropic), used through Claude Code over many sessions. It did a large
> part of the hands-on work: it read the vendor kernel and the firmware
> interfaces, probed registers on the board, drafted the code and the
> changelogs, and ran the builds, checkpatch, dt_binding_check and the
> tests on the hardware. I directed the work, reviewed every change and
> the final patches, and take responsibility for them. There is no single
> prompt to quote; the sessions were of the form "find out why X fails on
> this board, fix it, test it on the box".
>
> Tested on an Amediatech X98Q TV box (Amlogic S905W2, S4 family, 2 GiB),
> vendor U-Boot and BL31/OP-TEE, Linux 7.3 plus this work.
>
>  drivers/tee/optee/smc_abi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 51624443359b..1824aead78a6 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -34,6 +34,11 @@
>  #define CREATE_TRACE_POINTS
>  #include "optee_trace.h"
>
> +static bool optee_no_dyn_shm;
> +module_param_named(no_dyn_shm, optee_no_dyn_shm, bool, 0444);
> +MODULE_PARM_DESC(no_dyn_shm,
> +                "Ignore the secure world's dynamic shared memory capabil=
ity and use the reserved pool instead");
> +
>  /*
>   * This file implement the SMC ABI used when communicating with secure w=
orld
>   * OP-TEE OS via raw SMCs.
> @@ -1770,7 +1775,7 @@ static int optee_probe(struct platform_device *pdev=
)
>         /*
>          * Try to use dynamic shared memory if possible
>          */
> -       if (sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) {
> +       if ((sec_caps & OPTEE_SMC_SEC_CAP_DYNAMIC_SHM) && !optee_no_dyn_s=
hm) {
>                 /*
>                  * If we have OPTEE_SMC_SEC_CAP_RPC_ARG we can ask
>                  * optee_get_msg_arg() to pre-register (by having
>
> base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614

This appears to be a broken downstream implementation of that
interface. Could the downstream OP-TEE implementation be fixed instead
of adding an upstream Linux parameter to work around it?

Cheers,
Jens
