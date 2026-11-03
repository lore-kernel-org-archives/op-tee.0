Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A3606A328
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pqj1t6SN;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QLufdMfw
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D530C4545C
	for <op-tee@archiver.kernel.org>; Tue,  3 Nov 2026 17:59:28 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Pqj1t6SN;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QLufdMfw;
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1A86345398
	for <op-tee@lists.trustedfirmware.org>; Tue,  3 Nov 2026 17:59:11 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3HPTIc3161489
	for <op-tee@lists.trustedfirmware.org>; Tue, 3 Nov 2026 17:59:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mWiqVESok8K3e9rRJ3g5fJGIMlnrH+fRsBAgdT4QzNQ=; b=Pqj1t6SNvt9mXeCb
	hNVopmbn9MiawHBmT2+h8CuwFfJ7Rhzss4hq0VOkFh5Lg+ssvczhD+M5RkNLLvQA
	EsOKJ3GPuAJuqm2uFam95CXwY+RgZ0MYSguXwq5e/xSkKzjJkvZc6YjhAr2jpaSv
	oH0cn1hoi8ikq2/oXwzCgk3lqTWYDTu7LNnDN66Q6yaEytKX1AEv3pLlIR3PJ1we
	w9CYirNzC5faq9nbYB/EJKt7JR+1VhJgC3iCjjs0gFQJVLj6z98EZ0r1zsoBvsz+
	1SNJyZjWM5eLiSh15j2tPTKPp2oaWsbFoRrqvumbfeM7QZQQJret7o11ZceFVj2u
	HLFoDg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bh2k9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 17:59:10 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8b0e878f574so17519627b3.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 03 Nov 2026 09:59:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728750; cv=none;
        d=google.com; s=arc-20260327;
        b=pMKWTbc6eDkaz3Dogyr0XzC6h1eXHLtdq+UzFhZ8qjTwIlHHHBlUPk0779SkgJwOWS
         IcC/0XGS8VqK8D39plP2PqBBJw9xceILfsZOphLzBt/zpOlF8hcL2FpbkHLLAN4PWvIB
         Jr5lCwF7eefPgr8hENdrFXwyVIZTzTabTDqp7H5QWcVYEf0y6U+fTbTaTv8gXefYC/OG
         i1yvltfcrnId/O75K4ejha3oPG3oz+rz4bBFEeUQRId9+QZkjxAAooI9LIqkWO+HFjuv
         N6Vk5ytnhWXT2pGTZ61gqIb9mMiChiBobbY+cz8UQAvNTnIitIHurWZJnlQ2n42SCkqJ
         9/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mWiqVESok8K3e9rRJ3g5fJGIMlnrH+fRsBAgdT4QzNQ=;
        fh=EAIcRwh4IdA1BXEksFBv5FvcCivWqW5BHwTeo/Qq17Q=;
        b=bVNh2W6tVK3EVxa/jNTYliAGI2/YGyaoEXMUaKG0AfB/p8XnPwEyNNsKVb6oISeiQX
         2i9ZoXWFAgjVNQzH398/yimnvYSlXiTOlnz+pvvZBs0XEt78aYtTyLl45VA1FFs/O04z
         BTagJO3xm0JgSUby3EkaHyKTZ5feE7Qh96P+Mk/QgEKfGEIcVycElIyFjBIM7KDHySal
         okf5khVmiwvs8lKcMCEC33jHtV4ySJfox7lNdnLQs7VWP3MqZThq9hQBLRrstlZkbwWX
         JgUZ5rV9WcnBzAW+gBa3ZWgEojrYsCaBvwJAYCNq8hwQ8Rc7fC+WecrNvgcM95Ufe59z
         yKwA==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793728750; x=1794333550; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mWiqVESok8K3e9rRJ3g5fJGIMlnrH+fRsBAgdT4QzNQ=;
        b=QLufdMfwg8l/Yss/TVY9IYzqc7eZ1uE5qKvFj9YBLj7fwicS+I4PDRCXoO2TeRm2Yz
         KUicOTwCNUFCoooj9zmPiXkGog+nKCmcDjL3aIcwVawLr8yiX+AInDxQrKOJ4ADevLbq
         lFofT604dhjvSGCmVSMgWzMG9qwWGQYfV+s2S3TvD4x3qoIdEQV88I0/FRsBmmfXZPT0
         Ekk7ZL4e74nGvbBoCE86Xj17DZ5pPm4qMvf4WwzOhLppuMTgU/QTf9E55P40SZEFSKPJ
         Z/u1bxcKnR7ViLeNkbkRCqYfEd3lsBMDbB24EJGwRPdMsbYoBbogS4avjGBQkOWz5DnL
         4AYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728750; x=1794333550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWiqVESok8K3e9rRJ3g5fJGIMlnrH+fRsBAgdT4QzNQ=;
        b=2A2wZ09YKd0Y+CCNX/J9xS2CiyneWFaRaSsJMliu0IOBsm0sVfZqBb7SqPea4vE9Iz
         UKf6CDcduDf97Nv3N8sIqqBwDM43fa+dIcVctjYYIFKvJDR3bdjtF8aax984Xow1XZsL
         W/jy1eMAwHtSei9a0uQgG+cql4fniubywYuno8B+hY1rrdIse10qN3Dlr//ajvsg9/Q9
         JSab6apudwxq6OvCMeIaFXGBcZY9tojWsxEeE7luE1iZRGbbk0ZeDSMBijC2olwDnjzV
         6uKzuF94Mxauz5d+29ah1Lm6gFg0HkHER8ypz6u/+VcdlEC9jB90H/UFXtRPdP3T7n9I
         7Jtg==
X-Forwarded-Encrypted: i=1; AKwUvBxABki707Za3UMMo5jQRA3g5iAvSa4MPBfxDDMlmTfKDslU2im84f/9hL8/5wGqlzBCEHW+iUA=@lists.trustedfirmware.org
X-Gm-Message-State: APuU4Z/mkDeFkgSIAabsFA5ks3wJa54TRmRM3KBl2gzO52laj+8eLobi
	0mEOMoSJsRqchDurYfInjbFOcSf//u5jtByycnVQtIL+Fm+/9nRFMUYH/80liYBa6LtduVJveCm
	WMamtl35Qh4a6d+1RD2AnPMp8vjgouAWMqSPn2/SgTAXH0Kj23RYUkJ1mnkDXBnMY2c3lZTivN5
	TBxlwu2mg/VFUxScxe77oQ+yFKmxgjZLDTk2cPDpxT/yRb5yk=
X-Gm-Gg: AYBFou2JgFru3P19whrOwJotGIlPL70UYHeq4pwQy7yJUIzX8bxZv7a47JKLWXRKx/O
	erdY0ioKCWe34rTHGw7Dgq5Q2oAaQ+Fsd3SpcBQ9xFfT0qZ5xg/hxMFuHFrMHAIrzCCsKtK7oZx
	CirRJ9oHcPTC44656evttTMLdlETBD8M6xPYWsNoJOlXCn9ba+KpJ4AlebAHiy4gXhQIgEwRq04
	iG6cK5vYucKhuiUO2cVU01GauVrx2hjqsqqI1lq
X-Received: by 2002:a05:690e:1381:b0:679:a5fc:2f35 with SMTP id 956f58d0204a3-67a8d3dab47mr11993841d50.19.1793728749794;
        Tue, 03 Nov 2026 09:59:09 -0800 (PST)
X-Received: by 2002:a05:690e:1381:b0:679:a5fc:2f35 with SMTP id
 956f58d0204a3-67a8d3dab47mr11993818d50.19.1793728749355; Tue, 03 Nov 2026
 09:59:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260730062219.2836938-1-sammiee5311@gmail.com>
In-Reply-To: <20260730062219.2836938-1-sammiee5311@gmail.com>
From: Jens Wiklander <jens.wiklander@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 18:58:58 +0100
X-Gm-Features: AclHuK_eyUJ4LVzmPr0ntwvbkf_nZEw5d7HFVp4LeIbjHcyHf9f2l13O5bkRG6I
Message-ID: <CAGgiveUc+TkGyGDxuuCLpHO=i22-4fn1CqjqnnmWLdWWYOZfPA@mail.gmail.com>
Subject: Re: [PATCH] tee: qcomtee: user: check the parameter count from the supplicant
To: HyeongJun An <sammiee5311@gmail.com>,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3MSBTYWx0ZWRfXwFVA+Q23kI6q
 UcO4oBg1ROfBvvueWvx/sgM4khdu2X5c1ss8mPstpwXaYaH2PIIY7Pt8QiHfnQx49HYWPKeURm+
 6wLCGg0hOp1wNqeAQYvDNOaV1I3yKtg=
X-Authority-Analysis: v=2.4 cv=Xs1vqlF9 c=1 sm=1 tr=0 ts=6aea20ee cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=YeeCoqeVfiiWHf5BpmsA:9
 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: 42P6iTepzWJWHK3jLTWLU5b0uUMnQ7eV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3MSBTYWx0ZWRfX47n3HrYvxPCD
 hDAxdb8tm5Dgr5SZXt3TBux7lqR8+SFg3CEYAh5LCBaVDVlAosBh4nSe2Mj4Q7VpM+W+lWAe9bO
 Cvt0e5CzcyGE44VNGTqoX1iAKqP2bN8N7tPSolmR11HxcdGtKqgY1RMakpzodxQWIsyARet6oZ/
 saGs8E++zByft3w0fQB6fnRjq0nGFd4RKuz1rZw+fVFgRsHvvUTR9wSCvcbu0Vegh1M938Ltb5w
 gCX/sCmICIuo2ZYxFMDoIIeaIV9jaCcmi1z9FUctU6R1lEuqyS2g/G+Ea+XRJ/vUnebFMNE2FNQ
 hXOY53lgle8sSkUpuf7NnQz0CPNdU+j0YsPHOzMkG1Z7OVza7hANyj7uImgBeji3v30Uu9+lwSW
 3wxpHOq+EJUm3Tog7jdipfJAlyR53jKyK69MV1cUhaqK21buJe9c3iUZsebRAEEzkL1F19eq23f
 /kWTaG5afUfGuJEHU3g==
X-Proofpoint-GUID: 42P6iTepzWJWHK3jLTWLU5b0uUMnQ7eV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[qualcomm.com:dkim];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oss.qualcomm.com,none];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:205.220.180.131];
	RCVD_IN_DNSWL_LOW(-0.10)[205.220.180.131:from];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:22843, ipnet:205.220.180.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.199:received];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1A86345398
X-Spamd-Bar: -------
Message-ID-Hash: UJXO7KR37ULLTJJYFOLUMO5GZWAA6ESP
X-Message-ID-Hash: UJXO7KR37ULLTJJYFOLUMO5GZWAA6ESP
X-MailFrom: jens.wiklander@oss.qualcomm.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/UJXO7KR37ULLTJJYFOLUMO5GZWAA6ESP/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, Aug 5, 2026 at 11:23=E2=80=AFAM HyeongJun An <sammiee5311@gmail.com=
> wrote:
>
> The qcomtee_cb_params_to_args() walks the argument array QTEE asked for a=
nd
> indexes the parameter array the supplicant supplied, but it never looks a=
t
> num_params. A supplicant that answers TEE_IOC_SUPPL_SEND with fewer
> parameters than the request needs makes that walk read past the end of th=
e
> allocation.
>
> To fix this, reject a response that is too short, the way ureq_select()
> already does for the receive direction.
>
> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
> ---
>  drivers/tee/qcomtee/user_obj.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/tee/qcomtee/user_obj.c b/drivers/tee/qcomtee/user_ob=
j.c
> index 10452fcc7ccb..2a594ae299da 100644
> --- a/drivers/tee/qcomtee/user_obj.c
> +++ b/drivers/tee/qcomtee/user_obj.c
> @@ -507,6 +507,10 @@ static int qcomtee_cb_params_to_args(struct qcomtee_=
arg *u,
>  {
>         int i;
>
> +       /* Supplicant can not send fewer parameters than requested. */
> +       if (num_params < qcomtee_args_len(u))
> +               return -EINVAL;
> +
>         qcomtee_arg_for_each(i, u) {
>                 switch (u[i].type) {
>                 case QCOMTEE_ARG_TYPE_IB:
> --
> 2.43.0
>

Looks good. Amir, do you agree?

Cheers,
Jens
