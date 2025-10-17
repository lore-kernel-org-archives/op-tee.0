Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD457CCD19A
	for <op-tee@archiver.kernel.org>; Fri, 17 Oct 2025 10:04:54 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 04D5E4316A
	for <op-tee@archiver.kernel.org>; Fri, 17 Oct 2025 10:04:54 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eWHF9/cb;
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3DC2D41B6A
	for <op-tee@lists.trustedfirmware.org>; Fri, 17 Oct 2025 10:04:24 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65051376edbso416514eaf.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 17 Oct 2025 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760695463; x=1761300263; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frKVg3yqbGINKO4BpIzhnY7JXXxkWFKNQDEqsx233Ic=;
        b=eWHF9/cbT0pWk74xfEX8cOMmCv8i3reDMILtKjLAhUCNEo1VkCLzg+040nAJrJGYUW
         w9T54i2nMojIJwoi/PerAM+7xtg5JjQEQYxX1D4CqsSEiR51QCGxL4bUclem+//7yy/H
         q0InU1Su6C+SCRlPv3Hr+q0crJ7Q8mLYcC9NtFJrfNAm73tOFrHKsmzFAovxDNolKqm2
         7VeqjQOphUR+Q2IjznMNuCfWw0FRqvV7WBRW/ZasBmKqr25ZTtTkXVWHgliAC9z77ODV
         Q+QHel2vCSFTMfd9btj1949AI8HtbXZIGfF6teLI2+ZyV5zAFJYFMUoKbDE3CfgA38oI
         TDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760695463; x=1761300263;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frKVg3yqbGINKO4BpIzhnY7JXXxkWFKNQDEqsx233Ic=;
        b=H2VlBhebN/21RxC/G/P9ZnMefGbIIpa7AaSra5l/SwnxBYaWGnex5VJOfxrbg0wxyK
         qIl4P4mruQzf1+DiNgAc9tNqp3tWoZ4ZVQVlV7MD+7vwMMDxNjBrhSByySGoVYNJ1yjh
         j4sXrzJSQbTR1huu56dVKRoOnuqp9nXgI+F7zbhnVMBH8yMVTvtF1e/6BKeWT46ziU5q
         5+rfrbQHopAsrfbRDmSkkG9j61VIvh6rRxOHkPgUvfDwCgyE5wqgjqMpGv743FUT6taU
         rg/Azd1Wxz0tgGNsuONjrQPFXLjSWEdHRzBmU4TdSez54iUvOdP67XGZi6s30jefgSrd
         +a4w==
X-Gm-Message-State: AOJu0Ywrl3Mqqeu1t+eXkd07MDlPIeDoN2yxXfy0fFxsO4gdJeOIBJ3X
	Zrd0xo+dKz5vuiyzcGMR78sgleZhoZ9EAGnsCyj/1z3k3Y6IfuOfoY9PGdHdjsba6O0tR+Zd3/+
	lXrwwr/r5Pq9wQDeUsqAf+7DdA+kPWpJj3m/P2x/45Dj+uebY91c1Ldibxzr3
X-Gm-Gg: ASbGncvoPW7Ko0kD77lXeC6ob0XmQ/zaUCkewMFfsuqJhHLst5+xGXpTTZp5PttnKDC
	X4UxsNBcL7xYdlKpch3CeYtjmQNJdqojoW0odlDbzEXjugJgvivD8ms7AtpJ8OqA/T5pyDzEazp
	6rzR3VCZO8fnPO9cwYp+gcS+d5EogHMO8Gu2z/RmScs0nhL3Y6MZvGnZhdFonsg8Iw25nf/UxKL
	U8PSn+YRDYt80sV8jJ8HQ8J/oj23BU9FJtj7jcAsxJm9ZUZ/JBrZzUqI/G/9J3dcPFw8g==
X-Google-Smtp-Source: AGHT+IFv1RqVgPiagqHXC7G3qnWGKUxfS3LarYRMpcMApOtt6kEUnIDcUtQpOd14TVQp4TJCo+M9gQVGa49mPRcmlVI=
X-Received: by 2002:a05:6808:4f50:b0:441:8f74:e7f with SMTP id
 5614622812f47-443a3016e18mr1271162b6e.57.1760695463102; Fri, 17 Oct 2025
 03:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHUa44HNTP3YetCcifsKqcbpbA0XKpVkZ+a4BWucjUoY=ivZcA@mail.gmail.com>
In-Reply-To: <CAHUa44HNTP3YetCcifsKqcbpbA0XKpVkZ+a4BWucjUoY=ivZcA@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 17 Oct 2025 12:04:11 +0200
X-Gm-Features: AS18NWBcspX4KknlWKqFcR3lHRbuPLZDKoxvxa-M4iZsjLw3JhgNCD0h8i1SuIs
Message-ID: <CAHUa44GM6TqG30kRmTP0zcGtOb+yK+isVs_br2z2bHSrKopEyw@mail.gmail.com>
Subject: Re: Preparing for OP-TEE 4.8.0
To: OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3DC2D41B6A
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.09 / 15.00];
	BAYES_HAM(-2.99)[99.96%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.44:from];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.44:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: MATJ2UMK2ECU3DWPGQNFGI6T2M4OYOBD
X-Message-ID-Hash: MATJ2UMK2ECU3DWPGQNFGI6T2M4OYOBD
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MATJ2UMK2ECU3DWPGQNFGI6T2M4OYOBD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Oct 13, 2025 at 11:38=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> [BCC all OP-TEE maintainers]
>
> Hi OP-TEE maintainers & contributors,
>
> OP-TEE version 4.8.0 is now scheduled to be released on 2025-10-24. So,
> now is a good time to start testing the master branch on the various
> platforms and report/fix any bugs.
>
> The GitHub pull request for collecting Tested-by tags or any other
> comments is https://github.com/OP-TEE/optee_os/pull/7567.
>
> We will create the release candidate tag 4.8.0-rc1 this Friday,
> allowing for a one-week testing period before the planned release.
>
> You can find more information related to releases here:
> https://optee.readthedocs.io/en/latest/general/releases.html

I have now created the 4.8.0-rc1 tags in the various OP-TEE gits.
Please proceed with the testing.

Thanks,
Jens
