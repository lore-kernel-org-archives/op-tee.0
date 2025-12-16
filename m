Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29142D5CC89
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 09:20:36 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 6488C4FEDF
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 09:20:35 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XPQU+po0;
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id AF9BA4FE8D
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 09:20:15 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78f89501423so3693377b3.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 01:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765876815; x=1766481615; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdbkGAZvcEXm5SWEKUVClkLJFjPHLzhKuSzzyVtMACI=;
        b=XPQU+po0QQSomNBGoaooN0x/5/JGGNtnRFGMEHQtpARJIQUasKxqfGnaFKnNt+OHqn
         eWrDCIkTOeaMUYh6ICJOIZJXtrkrxf+UR5OQeffUJJrf0YpmtpotxApC7FOdIutsfjqB
         PobzOItAJT4K4cafd+g+NC3PpibBSsQULHG385wRoyyU3teVYQ3kdvmuxZor/d1LhKVj
         okV773RTKHxgup2O39oXGc7xFnk33O34oF8rTun+jQGHCIXLHB264WY9BXn6rWTAZDHy
         /lFjfc0om3DEM2/vJu0+RRqTnP3Zrfoxqo77L6NvohWoDLzPlN26BzEs4fCyXV7AjynI
         h5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765876815; x=1766481615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vdbkGAZvcEXm5SWEKUVClkLJFjPHLzhKuSzzyVtMACI=;
        b=L56ULzPTZxoBaZPiFfiX/8AmCYnWIOl4EL3aCa+bd+oNDTXfj/4iLSb004eVsYrC6+
         D1BL2AXbRhxcxI/uMgf8ZHFuwv6jZtcbEllwtqkHRYayBJ41y3UgcCZST7MUlgV+cyVM
         CQolqQWn/bHRuoK9kAP9ANqyDZaUWF1yt+Uq2SGLarhf8w3jGWMEuRl0YNGJFlktkvas
         0D+R2mMzy2w37Y03rzAqbNTKHXdCgVxNNDOKV5VwZcBHiLNpb7HAyBRNy5pNQMTnNVxX
         x321Z+e4BseVsoK8OsfKbTTqfsqIEbXixLCgPk4fMThlXyoX+FH1C2bySEktlIFU8vkw
         QO8g==
X-Forwarded-Encrypted: i=1; AJvYcCWuTzgRCVBJlsr6Saga8cNqSzkKBWHyNxIcuqSbKoIobAbx5zh9p78DI6U7ECLA6tSN136Oo4c=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyvMmrnWQMD001H87H3/+swxDG0ZdA6lVlYl6t65pF87bF3Pffe
	OfzyhLHeJropTpjpRAbzTBN4th4+gdhf44uLln5jz3vFYxM3t7RNiFiY6dM69Xyw6N/Fd1Qub9Q
	Ozc8qBBXqc32sWd4N9AzFtGsBLcCiqSRxF0XWXOcbX0OY
X-Gm-Gg: AY/fxX6Vf0GimBAz+oWJNN86goZtF3f1lL8L2jUOLf5W+LDPyWJT3FqPo06J/DwMCwC
	aPRux/YwbMEgOEnddtoWoE8/8+cY+/bGwaE4lHl2iMXX/jVVYXpu/Awn+gwW55FdBAwZIBIfptY
	RQwZ9+tvpdt80SuHzc4GeiDI931tliDQQk4/rtZiVFSxPfarXTlpZUobisunMY2Ptl+G76mPyOf
	czIm7PMUUTpmFQlW37aUTJIH7xTG85fBsr8JFzAeH/MqFop9/+YJU0xrHURqlxPEnYPpFwAfq8r
	+qorM7x/6WN5A9tpNwEsDyb+B9/NOmpo6tF4swnTcHohK7+8VobKMFaJBYYB6RwyL92fZNx27wO
	ozWAJ6iw2KHF7f8/vbHzyiRDwDVxwKhFoFPPlEhXyrRNC2jN3BUa3SVXD9myeETIWcLiVOw2twN
	eAx5y9TdadoOLK5K+YZHRTzpQshuO5O3oYv/Ca6x38cBzSa6JBpRzIAHzkUWJU2C8/t9T6zNPsC
	EatfTq/f1NSLJlONR3rcOo/UVIzI98oWmHWUOe7mB88woiBLhmCB1LwOY/0cI1JVX4lg23r8D79
	/oVdojCtv3y56W9hqFpRtPgH7CA7zGXd
X-Google-Smtp-Source: AGHT+IEctBGbOPb8tWUDebvS3L7V3SseQeGkk4xalk8WHK1PQ+/ej2AUM8IRRWIxM80NV5FFMSeI1zTaZrQqMMcHcdA=
X-Received: by 2002:a05:690e:d0b:b0:644:60d9:8660 with SMTP id
 956f58d0204a3-6447a5a7193mr11828178d50.44.1765876815167; Tue, 16 Dec 2025
 01:20:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com> <b70ad65c88a82cf56c93cf17cf326213f8273e37.1765791463.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <b70ad65c88a82cf56c93cf17cf326213f8273e37.1765791463.git.u.kleine-koenig@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Dec 2025 11:19:39 +0200
X-Gm-Features: AQt7F2rnkMoQPLRnnlXil8zyHYfAadd5PzbCSjslnX3-94C0khuY7zIbQk2gds8
Message-ID: <CAC_iWj+TevKq7TzPQ4_eEhu0rJJ03PV=ASf7SwTszp-mJY6Vzw@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] efi: stmm: Make use of tee bus methods
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.171:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	BLOCKLISTDE_FAIL(0.00)[209.85.128.171:server fail];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.trustedfirmware.org,lists.infradead.org];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.128.171:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: AF9BA4FE8D
X-Spamd-Bar: --
Message-ID-Hash: EXAUZHKNEHUSQPUISWI27UCCVMNWIHAX
X-Message-ID-Hash: EXAUZHKNEHUSQPUISWI27UCCVMNWIHAX
X-MailFrom: ilias.apalodimas@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EXAUZHKNEHUSQPUISWI27UCCVMNWIHAX/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, 15 Dec 2025 at 16:17, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> The tee bus got dedicated callbacks for probe and remove.
> Make use of these. This fixes a runtime warning about the driver needing
> to be converted to the bus methods.
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/=
efi/stmm/tee_stmm_efi.c
> index 5903811858b6..7b04dd649629 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -520,8 +520,9 @@ static void tee_stmm_restore_efivars_generic_ops(void=
)
>         efivars_generic_ops_register();
>  }
>
> -static int tee_stmm_efi_probe(struct device *dev)
> +static int tee_stmm_efi_probe(struct tee_client_device *tee_dev)
>  {
> +       struct device *dev =3D &tee_dev->dev;
>         struct tee_ioctl_open_session_arg sess_arg;
>         efi_status_t ret;
>         int rc;
> @@ -571,21 +572,19 @@ static int tee_stmm_efi_probe(struct device *dev)
>         return 0;
>  }
>
> -static int tee_stmm_efi_remove(struct device *dev)
> +static void tee_stmm_efi_remove(struct tee_client_device *dev)
>  {
>         tee_stmm_restore_efivars_generic_ops();
> -
> -       return 0;
>  }
>
>  MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
>
>  static struct tee_client_driver tee_stmm_efi_driver =3D {
>         .id_table       =3D tee_stmm_efi_id_table,
> +       .probe          =3D tee_stmm_efi_probe,
> +       .remove         =3D tee_stmm_efi_remove,
>         .driver         =3D {
>                 .name           =3D "tee-stmm-efi",
> -               .probe          =3D tee_stmm_efi_probe,
> -               .remove         =3D tee_stmm_efi_remove,
>         },
>  };
>
> --
> 2.47.3
>
