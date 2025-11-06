Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32147CCFA03
	for <op-tee@archiver.kernel.org>; Thu,  6 Nov 2025 11:31:34 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 76B1E41B87
	for <op-tee@archiver.kernel.org>; Thu,  6 Nov 2025 11:31:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QKQmYH4e;
	dkim-atps=neutral
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CF786430BA
	for <op-tee@lists.trustedfirmware.org>; Thu,  6 Nov 2025 11:31:22 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-656bf426c81so465988eaf.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 06 Nov 2025 03:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762428682; x=1763033482; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGk+iMMQZ2vEJTeI4z0/vF9e1THhn3jOf857E98Hpp8=;
        b=QKQmYH4eLwwSv9tbPZ3kWyGSW6HAQXdXObYq6/3x6mtr5Du1cS/c+BFh5Uxu8IfMKb
         av3c7ExB3+j/1nGUquPlFHjtp1ByCnLfHu+pwJt+bC3FiaCKf3/gJWWDd2D71XRLEO5O
         7yVr4BLk0Fn+tSGlKr08cZ02GJyYKjUJRx+JsLBkh3gyJXNci7xBR+hNNkbP00VgOMrp
         SF7V+t/Bd5OOPW0qzCggsrj9tFQ08Dk4fMVp562kV2K2tLdTzB5kpySI+IG9QLYoJL3E
         /tPuduFM1AbA9zla264dS7y8W0yCTevOfnbEC05dZ5qZV0qp5rsNg0A9OXOayfk3EmZb
         FwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428682; x=1763033482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XGk+iMMQZ2vEJTeI4z0/vF9e1THhn3jOf857E98Hpp8=;
        b=CX5RULskjSg69IRar6cRlvxsrv8pdsLfsdRRTAwppzT3Ln9IB0zq6a+PxEuC1kU/wA
         4j5jTQYq+7SgIL2Iqcc07MUpe3EUMbf9VVfIarqJW8dwx8vDY5t1TR/kWVxhMZhbk6yU
         nJ/tAWXFe1QEK3JPvn2eWb5Ls3OkvPc92jybyCw9npvHNuVchqG/cLwrKhbdmbFbB2ti
         H6S+4zIEaA/1rNSYnrQHyosUs2R1GI1iw1J3VbpQBBdcmcPq+K6jY75gxNYq/1twMSFD
         dFSGIUef5yUwvKc6ND0Kr1FhsoQZy/l8OYUJS6b3HfkyH1WxPkO5GcqKX/GUZzvAiZBc
         Nt+A==
X-Gm-Message-State: AOJu0YzsYlkOafoXJ3op+1MQljlFKuNY/PClN/KU1ZwHmUKrS8RjSvQQ
	mq1WSLGgJ5iHrw0dympzkqyQyzdKDrXRNJhPmyPcLrpNNa5MCfk4Qax8xigBD8JXQ9ozfIzIRiG
	KqZU0zC0Pcld6injLai1r20pudC3+GYEjrHiGSnaBhNtE
X-Gm-Gg: ASbGnctMOYmbbAbtWItB+LLHkw2P3nr7LKIeNDf8WNA6KQa2VDlorvo7DG81tx9CUiq
	qwBbC9HO2E3o4daWJDtRvKBnW2JpR/GLZJUbFuNKU90jnUSOHqLqfu8D70D/A8uD1Cx2Hr+hdPy
	aeWrTWxQzoRIi5bukGJvTGEB1WIpkr2SDrGTB6ZCORar9fDFkFXqqw3om2578YPmPEYdNgAO9Kk
	KgZ3KZMNoAY5vt5nGgLf9PBBhUIHFxkysdEYaGzbX37crq07cL/vnFSJlq6jA==
X-Google-Smtp-Source: AGHT+IHkj4o/NOZHcWbw6giq3vF7bwqq0UNMoWmtnanbMAE/Exe7GRD/6wvB3w0v773txVFEKCGg/5jZY7nBpsA1L1k=
X-Received: by 2002:a05:6808:2448:b0:43f:5f02:2f30 with SMTP id
 5614622812f47-44fffbb8abbmr1722155b6e.4.1762428682039; Thu, 06 Nov 2025
 03:31:22 -0800 (PST)
MIME-Version: 1.0
References: <20251106102008.1310234-1-yangzhao@kylinos.cn>
In-Reply-To: <20251106102008.1310234-1-yangzhao@kylinos.cn>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 6 Nov 2025 12:31:10 +0100
X-Gm-Features: AWmQ_bnTe3Bqx-0i6NqDlTVTxcKF21ZI3fkaw2jHTg947odKhfSyeYi5j-a1WhM
Message-ID: <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
Subject: Re: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
To: yangzhao <yangzhao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CF786430BA
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.50:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.50:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: BJYZK7BXCDCZ4PLUSJHW66KFWQIID7YE
X-Message-ID-Hash: BJYZK7BXCDCZ4PLUSJHW66KFWQIID7YE
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/BJYZK7BXCDCZ4PLUSJHW66KFWQIID7YE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Nov 6, 2025 at 11:20=E2=80=AFAM yangzhao <yangzhao@kylinos.cn> wrot=
e:
>
> In tee_shm_put(), there is not only the NULL pointer dereference,
> but also the illegal pointer dereference.
>
> shutdown() --->
>     __optee_disable_shm_cache -->
>         shm =3D reg_pair_to_ptr(...);
>         tee_shm_free(shm); -->
>             tee_shm_put(shm); //crash: shm->ctx maybe NULL pointer or ill=
egal pointer
>
> Check whether the pointer is NULL and whether the pointer address is vali=
d.
>
> This issue occurs when rich world uses the 6.x version of the kernel and
> optee secure world uses a lower version (such as version 3.2), and it is
> highly likely to trigger a kernel panic when conducting hibernate tests.

It sounds like the root of the problem is in the TEE rather than in
the kernel. How about fixing the TEE to avoid supplying garbage
pointers?

>
> Fixes: e4a718a3a47e ("tee: fix NULL pointer dereference in tee_shm_put")
> Signed-off-by: yangzhao <yangzhao@kylinos.cn>
> ---
>  drivers/tee/tee_shm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 4a47de4bb2e5..de01d16409c1 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -722,7 +722,14 @@ void tee_shm_put(struct tee_shm *shm)
>         struct tee_device *teedev;
>         bool do_release =3D false;
>
> -       if (!shm || !shm->ctx || !shm->ctx->teedev)
> +       /* checking pointer */
> +       if (IS_ERR_OR_NULL(shm) || !virt_addr_valid(shm))

The IS_ERR_OR_NULL() check might make sense, but the virt_addr_valid()
does not. virt_addr_valid() might catch a few garbage pointers, but
the real problem is that someone is supplying garbage pointers.

> +               return;
> +
> +       if (IS_ERR_OR_NULL(shm->ctx) || !virt_addr_valid(shm->ctx))
> +               return;
> +
> +       if (IS_ERR_OR_NULL(shm->ctx->teedev) || !virt_addr_valid(shm->ctx=
->teedev))
>                 return;

shm->ctx or shm->ctx->teedev should never be an ERR pointer. The
virt_addr_valid() test doesn't make sense.

Cheers,
Jens

>
>         teedev =3D shm->ctx->teedev;
> --
> 2.25.1
>
