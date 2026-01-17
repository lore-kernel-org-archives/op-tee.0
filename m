Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555FDC9832A
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 14:10:56 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9C7CA434B8
	for <op-tee@archiver.kernel.org>; Sat, 17 Jan 2026 14:10:55 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=On5+Vokr;
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3E2BF432AC
	for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 14:10:37 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee4338e01so11921805e9.2
        for <op-tee@lists.trustedfirmware.org>; Sat, 17 Jan 2026 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768659036; x=1769263836; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiKlHj+3mIbgnx+R2A3g/i2Ls37g5s26/ZzzGkqA/rc=;
        b=On5+VokrGpii09+TRXJYB2cUAM3AUAYw/R6e5jHNPFEIbuKirpVNsjFDQShGAj9LtH
         O7Mw0Ze2iKnc+Eeq58A5d3Z6L4mZ6t2fM0IVhkZyI+NJkqYWUr+qCIvfvoGHNcf355tw
         sySs96/u8/l4ohh/7T9DEdqM9exZCStLnvZjyyr1cIfgCSQBH+kbK0tQK7899zPrVRTH
         jQlt1A55gXnfiUNNfEzCBuQnfj0q6PwRuQPtodu7DHCgsjpxBfIC+Hj+tJU4PNJh+SDK
         iKX9PGX5Nr3KJ8LJXEaRHdHeWWrrrfm+1w2kCjmRZm3bV7DYsJ3cycm1P8hFNsbXjPEl
         5pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768659036; x=1769263836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UiKlHj+3mIbgnx+R2A3g/i2Ls37g5s26/ZzzGkqA/rc=;
        b=Mrifp/rQgD0WIfksBaI3IHSFpwURLDm2M0bUIkXO+37VeIhEJ6TSU+Kg611hMCX/r1
         Inxo3AnXnoUdluKBY7B9h30QH1ut4tvSk7ohql+34aLmbUw2TAEAjPMPJNuiJHmdfcfz
         zIVb7+1oTXYl6dHWmt1bHyIjF4r1TfmPUJwsWoebNTgC0pU0yJCBMr5DcAbAHCYzp78Y
         b1f4zt8XNqSg1vXkBKLwPfjEy5PwErDl79x8/iEscZxtKO/8aLbzXOC3YwlLl/fHVbnK
         hlObrmJZ7zkV2dywh5tEQbKV12xRtQ0KOHxsD2Hw22aWIg4Ic7vvI7WxYvIQgbQI+GkF
         3dIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxEasENYwQbxvXCgN9udRZg0ZN2xiMlvfSFDtmgCcf0YuiICfD0gFNPuaXKiQQcOGXZK1H5pI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyttHIHXcz/uPlclr7DUSApSJmzF0+WgUa0/JZ2cS8I4T0oiJW7
	ix5Q82Eu1cjfihEwKlFclo7XXhrC39meEatoJpXCHvnhQgfv4qJ4Iyac
X-Gm-Gg: AY/fxX4oKI/2U6S7HyxZoXarW5LsE8W2IX5oB9gtv7SmdK81FHHleEZsALrrTd57Kn3
	2mazG/KHkLj3BpL+psn1jAXHHC7ZKNiyuFKoWnp/7czbrIlpvWdJT6ICYrgUt0o14vqzzWBl7Go
	K+AmntT6jnvCu1tbj6NB3vTwp72njEXYu939Jtvgpmr/GQA2J6lpX3MF9f+9xUM5TwZNa+IDKOq
	Lj05/C9SpWw/7Lhvst0MKoy3vY/ji2ryxLMmkeMOQ53Cn+V2q2K6E+wnqRplVDhB7gKJP75DbOk
	qU3MBxZ+fXMiXCGECimq+UdzSmOZGK1DxqCUKUS9en8Qt+AqWdoNWO4kspQ74HNVFQNfYnMUvjJ
	yOtYR3dQ37D3P9f4NixjKYAT4Jgevmn4HtcYLQZwe9YZEjadp83nlst+ZCU42A1ZakyoUBPuXmv
	cyGflRLqMTnjsZqpuC3dVENE6rrNS2hOPbmp5kTQfkrOVB8nIq6uCH
X-Received: by 2002:a05:600c:6489:b0:459:db7b:988e with SMTP id 5b1f17b1804b1-4801eac331bmr68009345e9.13.1768659035967;
        Sat, 17 Jan 2026 06:10:35 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fd458aesm42726695e9.2.2026.01.17.06.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 06:10:35 -0800 (PST)
Date: Sat, 17 Jan 2026 14:10:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Colin Ian King <coking@nvidia.com>
Subject: Re: [PATCH][next] optee: make read-only array attr static const
Message-ID: <20260117141031.1514faf2@pumpkin>
In-Reply-To: <20260109154442.421248-1-coking@nvidia.com>
References: <20260109154442.421248-1-coking@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.53:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.128.53:from];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 3E2BF432AC
X-Spamd-Bar: ---
Message-ID-Hash: B57WE5H5LKJ7BUYL7V367R54W7YGAAVZ
X-Message-ID-Hash: B57WE5H5LKJ7BUYL7V367R54W7YGAAVZ
X-MailFrom: david.laight.linux@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/B57WE5H5LKJ7BUYL7V367R54W7YGAAVZ/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri,  9 Jan 2026 15:44:42 +0000
Colin Ian King <coking@nvidia.com> wrote:

> Don't populate the read-only array attr on the stack at run
> time, instead make it static const.

For a 4 byte array initialising on stack is likely to generate faster code.
In particular it avoid a very likely data-cache miss for the rodata.
The on-stack array access might even shorter code than accessing a global
array on some architectures.
The compiler might, of course, decide to unroll the loop and not instantiate
the array at all (in either case).
Indeed, just unrolling the loop as:
	if (params[0].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT) goto bad;
	if (params[1].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT) goto bad;
	if (params[2].attr != TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT) goto bad;
	if (params[3].attr != TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT) goto bad;
is likely to be pretty near optimal.
(Collecting the bytes and doing a single 32bit compare may be better.)

Of course this won't be a massively hot path - so the code choice won't
make a measurable difference.

	David


> 
> Signed-off-by: Colin Ian King <coking@nvidia.com>
> ---
>  drivers/tee/optee/rpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 97fc5b14db0c..1758eb7e6e8b 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -43,7 +43,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  	struct i2c_msg msg = { };
>  	size_t i;
>  	int ret = -EOPNOTSUPP;
> -	u8 attr[] = {
> +	static const u8 attr[] = {
>  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>  		TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT,
>  		TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,

