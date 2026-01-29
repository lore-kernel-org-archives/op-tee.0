Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030B6D6B084
	for <op-tee@archiver.kernel.org>; Thu, 29 Jan 2026 16:05:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 338EC436FD
	for <op-tee@archiver.kernel.org>; Thu, 29 Jan 2026 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1769702754;
	bh=yVdibtwtGBdtM6zRoTTns3ysNbJg04ECgBNHy8kebSA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=2D1ON91wqYeQOQ35rhXwFjoTjqzl0sUX54h1swsrPHQZgKmugYrEFFAvtILcgo6wj
	 8j8mpF2oZRNHvFOWYXzBdEOA0yzax4VwOnhaiOwKOVSRl6lpuO1QMnYrx8MqbEgWI+
	 0vxwJZeFB/aY5wGFcXPEFVQcKRdON1Fju1tzij2qmD1d9FFBOF43IbUU2iQpkaIoW8
	 zKuMtv5zYkk98pxw+0bLLijm5fl1kL2FpVfbJuZF9aABgaeQ9dTzKNSmnAGEj7g0uF
	 YAN3wQo2rOKV3JOw0M87F4jvinfPl/ksCk37FIrrB4wBzqtLirABcXM9uRL2WMcjDG
	 +pSTrNGZ0U07A==
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B343A432A4
	for <op-tee@lists.trustedfirmware.org>; Thu, 29 Jan 2026 16:05:33 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mNSQY84L;
	dkim-atps=neutral
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 820DB1A2B01;
	Thu, 29 Jan 2026 16:05:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FCDF60746;
	Thu, 29 Jan 2026 16:05:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C84C6119A8095;
	Thu, 29 Jan 2026 17:05:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769702731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Lc6wWk4IgTT559wWGEQNQjCDMW6utgy5FoBxVvSG2KM=;
	b=mNSQY84LQ52ZnscGD18IByJvZJQQIacVebk2t/plG/whMwn+83Zl1E9OvoWX2V2RxCfoxS
	J7FKlupj1VB7e6rJFirr6RfK/Oy8A6bsRNzcw474UsjN/FbndmiovBhMgwm4YRKoBwKFmx
	3ZeTXY3A03ZQLaJOCIiO8R9mHEDa7oyn4WPEqgrGwV6YrglWUK6/soN5WeE49FI13rIEZA
	q4eMBtWPKykfEWe2ps7aGWr4/JW4mG1Uq3VhlwwNdXdiVcqnGgeBHoWH5R9jClm0TjLX7V
	OKWIWCnc7iGZ2Eb/+sESPRrxzaJ8ZnvdKXHvmTHen/Ais5igGxDQBGU8jw1rrw==
Date: Thu, 29 Jan 2026 17:05:27 +0100
To: rouven.czerwinski@linaro.org
Subject: Re: [PATCH 3/3] rtc: optee: simplify OP-TEE context match
Message-ID: <202601291605277bc279f4@mail.local>
References: <20260126-optee-simplify-context-match-v1-0-d4104e526cb6@linaro.org>
 <20260126-optee-simplify-context-match-v1-3-d4104e526cb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-optee-simplify-context-match-v1-3-d4104e526cb6@linaro.org>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:185.246.84.56];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:21409, ipnet:185.246.84.0/22, country:FR];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DNSWL_BLOCKED(0.00)[185.246.84.56:from];
	DKIM_TRACE(0.00)[bootlin.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B343A432A4
X-Spamd-Bar: ---
Message-ID-Hash: 7I7ZYCQS3FUTJCLFNO2M2U4U47C4E3VU
X-Message-ID-Hash: 7I7ZYCQS3FUTJCLFNO2M2U4U47C4E3VU
X-MailFrom: alexandre.belloni@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/7I7ZYCQS3FUTJCLFNO2M2U4U47C4E3VU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Alexandre Belloni via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Alexandre Belloni <alexandre.belloni@bootlin.com>

On 26/01/2026 11:11:26+0100, Rouven Czerwinski via B4 Relay wrote:
> From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> 
> Simplify the TEE implementor ID match by returning the boolean
> expression directly instead of going through an if/else.
> 
> Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> ---
>  drivers/rtc/rtc-optee.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
> index 184c6d142801..2f18be3de684 100644
> --- a/drivers/rtc/rtc-optee.c
> +++ b/drivers/rtc/rtc-optee.c
> @@ -541,10 +541,7 @@ static int optee_rtc_read_info(struct device *dev, struct rtc_device *rtc,
>  
>  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
>  {
> -	if (ver->impl_id == TEE_IMPL_ID_OPTEE)
> -		return 1;
> -	else
> -		return 0;
> +	return (ver->impl_id == TEE_IMPL_ID_OPTEE);

I guess the correct way to do this would be:

return !!(ver->impl_id == TEE_IMPL_ID_OPTEE);

But is this change actually generating better code?

Before:

static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
{
        if (ver->impl_id == TEE_IMPL_ID_OPTEE)
       0:       e5900000        ldr     r0, [r0]
                return 1;
        else
                return 0;
}
       4:       e2400001        sub     r0, r0, #1
       8:       e16f0f10        clz     r0, r0
       c:       e1a002a0        lsr     r0, r0, #5
      10:       e12fff1e        bx      lr

After:

static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
{
        return !!(ver->impl_id == TEE_IMPL_ID_OPTEE);
       0:       e5900000        ldr     r0, [r0]
}
       4:       e2400001        sub     r0, r0, #1
       8:       e16f0f10        clz     r0, r0
       c:       e1a002a0        lsr     r0, r0, #5
      10:       e12fff1e        bx      lr

I'm in favor of keeping the current version.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
