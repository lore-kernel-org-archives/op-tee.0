Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8956DD5CC8F
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 09:21:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B2D074FE8E
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 09:21:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lTDemtPP;
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8D5874FE8D
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 09:21:29 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78c686aa4f9so16527517b3.3
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 01:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765876889; x=1766481689; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGYedUjMSAQqTTCfPBzG7GGpp5/HnFYa13zWq/TfU5g=;
        b=lTDemtPPZrvP4JnS3Kc52ANL4ZJVhlFGzEsMV2nZP2PkBj2ob4jPhbhXeZAw4A2V1b
         tWyt4LkwsCCQKmOp/uLTRo7ojR1uI9PNe61BhTmAAUC1xQPw3D5BTH1LJccIdvPUerwv
         PuiazL8BHaGdlXbxlZnh9HkSz0cV3/dmugA2SQx6PxJl/a6qWjAmjdCax8z3bZfdayj7
         mSDn1RI8UVmAOYdY3DMVhJsW+NxfrKcBA624t8f/outT2JaSSFu8PB5JLHkKrgU4bQNm
         zG5XyXY/OAu9HOBYzv3a+xBKrQQ1v5GHFkxNsJ3tjlc3cLFpQdu1jVt9JsRwq1KCye4P
         0HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765876889; x=1766481689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGYedUjMSAQqTTCfPBzG7GGpp5/HnFYa13zWq/TfU5g=;
        b=uxc4qLZf6i8Q7sAk8JcBSfEi3QP2D8zAzQ1Wh4YT7pXQ+vVF3t0FWF7kMlHVOiiek7
         gVI8fe/StSoZzT+dkVH6Xn4W2i9RszUldZSgp5ftUCpTq6GgsG9VPUgoSPFC/cZ5F12S
         z3vO0+/RyEGUcuLUnshLfo564XtutB2zSFUASMbMwSbmRhOoVtCDD4mrpYU/dxHAWR4q
         J8MzQhlxmQQ7iSeowjSav0yP7Rdd6aNoF8x8vGIH6QgiQnYpX0Y2lA1tyTEGqCxuj5C7
         lwLwe0w6k/vvvF+JRSeDwDA88g7b/BdD9L/kv35V45jeo6TJjfmcrvBIlidXYmP8Qs+A
         44tw==
X-Forwarded-Encrypted: i=1; AJvYcCV0QR9HvO597Q84VbNF/Hzesw4OMiGtkkWnwiPYHhLMY9N+3ZGuB8llvGBTWBmbvWgRYSZf/dU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywb5szrR5Fqx9ZODNqhvQYlGtqyGbB3HFkyIv9CUPcTWHJvXES3
	DqrPQWiGQN4EM2te0HEtxG7JNSxWB6o59VtsaCV11za1qcqhVX0B4nlixFEzEmjTmFxeg8I0Duy
	MsAaolrxsP5YOdDqM+kx27hDJ+QAOxgU+QlLA9qXQFQx3
X-Gm-Gg: AY/fxX5/h3++CzF9pYKgnROMNw+xj8JBZcKyv6gr82f7z1ICsWkp2mXRzEmK3uyoJ6x
	Xqw18Sf5l/DvQGunli5qOcWLRqPyiORNU+pOsQaBm/mgwOd6Q38/yLSISKcjFY5b7MJJxW2+XhR
	+MdQGLkpiukUjjprS0flUFJOSi1NyhUn6nJ7V/SJ01ff//g+xLBXTs0+6qx3TvKsHkwRoCbtYuJ
	zfxC9o5TS/PTD1cSiD/UTmaic2fw2Hcq6dvo9P5VMaY2gGCbpEpkS5Q9ik/ahdKEtBXzkmVreL3
	SRAuIgkCkzRAai9ZXlXjQ5TY81DIKLmpWr+E6kL6EPGXgjDXgOX7wgYiZcyQ7TIIacVbndSLFcE
	BB1EFlVOJGfDeacI8iCBx1/iyYnonddlszSeU68bRl+0LWHv1JTiV//SuO3Jjsbl0JXOaHE6sJU
	vofXoOK7uG6icUfmpm1YaMF7rdayJI+S/ojpcnr9mrsQQFCDwFRzHavXwGTzalKSumUcvOgMvX4
	bO1gQoilUrc5zlxHmP9z9dNvlg9qJvPBDjlGgVVJAHAwX7nqCIpB2SgsSqo6QI2xJDGfC8Cl79f
	A2gmwXDA2dPq3wBFw1Rj151vnX3L3sSV
X-Google-Smtp-Source: AGHT+IEAFokQb5D1JItH9s+uj3Sa3EAOeQhnCG2QizFVOaNkP6qUDXOVMm6HltsGpBU7JI8LFSpiz0VIaHoanmm6gBM=
X-Received: by 2002:a05:690c:688f:b0:78d:6c06:4a0f with SMTP id
 00721157ae682-78e6809a375mr112570247b3.0.1765876889065; Tue, 16 Dec 2025
 01:21:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com> <6a56ee61e485703d548e9e44d53b2920b4e43ca6.1765791463.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <6a56ee61e485703d548e9e44d53b2920b4e43ca6.1765791463.git.u.kleine-koenig@baylibre.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 16 Dec 2025 11:20:52 +0200
X-Gm-Features: AQt7F2rtv6sYjRJcPW49bnernszF66e86Q28fTD0Bfhuswf7pxXDfIzUWVoUNmU
Message-ID: <CAC_iWjLG7o96E=9W-cjJ=_622RFg-b9t6hQnMrSmgHS+ThaXyw@mail.gmail.com>
Subject: Re: [PATCH v2 08/17] efi: stmm: Make use of module_tee_client_driver()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.173:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	BLOCKLISTDE_FAIL(0.00)[209.85.128.173:server fail];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,gmail.com,foss.st.com,oss.qualcomm.com,siemens.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.trustedfirmware.org,lists.infradead.org];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.128.173:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 8D5874FE8D
X-Spamd-Bar: --
Message-ID-Hash: M6FXSUQIAAM2FOFCQP77S7WPS5OFQKBI
X-Message-ID-Hash: M6FXSUQIAAM2FOFCQP77S7WPS5OFQKBI
X-MailFrom: ilias.apalodimas@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Jan Kiszka <jan.kiszka@siemens.com>, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/M6FXSUQIAAM2FOFCQP77S7WPS5OFQKBI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, 15 Dec 2025 at 16:17, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Reduce boilerplate by using the newly introduced module_tee_client_driver=
().
> That takes care of assigning the driver's bus, so the explicit assigning
> in this driver can be dropped.
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  drivers/firmware/efi/stmm/tee_stmm_efi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/=
efi/stmm/tee_stmm_efi.c
> index 65c0fe1ba275..5903811858b6 100644
> --- a/drivers/firmware/efi/stmm/tee_stmm_efi.c
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c
> @@ -584,24 +584,12 @@ static struct tee_client_driver tee_stmm_efi_driver=
 =3D {
>         .id_table       =3D tee_stmm_efi_id_table,
>         .driver         =3D {
>                 .name           =3D "tee-stmm-efi",
> -               .bus            =3D &tee_bus_type,
>                 .probe          =3D tee_stmm_efi_probe,
>                 .remove         =3D tee_stmm_efi_remove,
>         },
>  };
>
> -static int __init tee_stmm_efi_mod_init(void)
> -{
> -       return driver_register(&tee_stmm_efi_driver.driver);
> -}
> -
> -static void __exit tee_stmm_efi_mod_exit(void)
> -{
> -       driver_unregister(&tee_stmm_efi_driver.driver);
> -}
> -
> -module_init(tee_stmm_efi_mod_init);
> -module_exit(tee_stmm_efi_mod_exit);
> +module_tee_client_driver(tee_stmm_efi_driver);
>
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> --
> 2.47.3
>
