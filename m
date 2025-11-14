Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E30DCE7A8B
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 08:50:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 621B54FF91
	for <op-tee@archiver.kernel.org>; Fri, 14 Nov 2025 08:50:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jB7CYFMq;
	dkim-atps=neutral
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9EB564312B
	for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 08:50:25 +0000 (UTC)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3c96de7fe7eso1145915fac.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 14 Nov 2025 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763110225; x=1763715025; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CusVqL2ntwZsk8KprD0ABpMXTld3zKY0G34uzzG8h8Q=;
        b=jB7CYFMq4sEeHc7sr2zI4dTzFNUsZDKTK/DoxGYnur9qSo1LNZ1NCa9U0WBbbMRO3i
         u/6hOfvOhjpZHRfqrYXWpML4WPFGpUre4fMamWF+0qIhDIQI4wPyFe+AB2dhXrqiKSmk
         bnsWIFkIrmA7nBtiphXBRO47wIP4Nnu3BtABI90RxdAT5H6gek3cyVTRVmbD5WdEIIVC
         tnjfhjJFqOIz97qw3GAAF0mhp7f3xy/vLU3zoeyNJ+nEt99f6sQ83pfHvxQ6HbTLaIDm
         Hk9Qq9yy/axc6FAkr/ks8Qt3pXYISTyNSm6OdzgS1P9aVVfehwsxeLd9Szc6W9XdalTv
         i/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763110225; x=1763715025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CusVqL2ntwZsk8KprD0ABpMXTld3zKY0G34uzzG8h8Q=;
        b=iguwXtd+T7vpXZ9h18l++uTChmxYZf6k3YtVjIlYSB/wTz2Yu+mKJDCXMTmy8f0N5T
         UtgLiz1njjaEQqlhXhKNhjWYJhsZLBmV5b/LDYSFWycLPIsyKx4p20SLaIJCFMLUUp8f
         A3w93Pba4mbchdtzcOdlkvUo8fm6iatPCjhTbb2Wdw3pIOUWpXsFoccEQFFB+hmMXxEd
         U6oFN8Wr5m0t8PEgBzRQE3J/0/09xfkXMEVlTaAlF0MzRwFMlzKBSaeYyVJYbGeizg+o
         FvrbOPn0UB9IpOiOAeMbFAjKwZjNk7ajFGkl5OvSMMCR6rvpzmX1an+eIk1hRx+vBSXb
         g3rg==
X-Forwarded-Encrypted: i=1; AJvYcCWEGXZ9GikiGjnYZUrQXSkab1kek9b1tqNku3u2r3Q3HFp/SA7nTnvx4WyA1C9cxscd59Pc3PA=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzSzq+htNguoqwOPdnsPnElYWIc8AtL5kq6ZzRKbC+2YZl9pZwc
	ux7KNblhPUiDGj4lHSA2YrFJ77/1SKj2/B60rlQ1W82j3G6aWWUZ08IQfP8Fez7vpiJT6/1q75+
	1T63hF15JRlzCWRmKlfZu3XU9AIenRZdIUOdxaEsBG9DI
X-Gm-Gg: ASbGncsExNCZk9dWQdA4ixnS87hptOdiCk4xFrAvmxRQLVeQxyCtyMScTQ/wvggm1Oq
	fQ4Um+w61TxMzx6w0zTjRGzwVoJQf5bAloLhigUo0qh5z0Ht4gm0hKrzEuZOrcU/miiXnaOkw7S
	n8eWT23ksdqCKAs30btjrbcGsJNah1F6uCiuH9pzuV9VLYts1Y3IC1MMMMckhlOOov/ffkcqTpG
	T7V8mxUQXxqI2Uxs8x41mo87JbYBfcAaWrhKXa3nP5tUosvvOfYUelm4xAua2+FYxXmxdlVB8AL
	B5zX
X-Google-Smtp-Source: AGHT+IF1A1pWHFYkRwg3X51lkNTOBIl+wQ8n3kMIRR/2Y8vGWmB6jerdRYhHhX6GfE0v08cbQgMc8VxU+REj9kPZerM=
X-Received: by 2002:a05:6808:6f8b:b0:450:3cf2:3c67 with SMTP id
 5614622812f47-450973c1b43mr1217012b6e.17.1763110224866; Fri, 14 Nov 2025
 00:50:24 -0800 (PST)
MIME-Version: 1.0
References: <20251111-aheev-uninitialized-free-attr-tee-v3-1-57905b913359@gmail.com>
 <aRQ9DQ1Ncf4Iep4o@sumit-X1>
In-Reply-To: <aRQ9DQ1Ncf4Iep4o@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 14 Nov 2025 09:50:13 +0100
X-Gm-Features: AWmQ_bk8z8uY8FQvLbLxKFhMh2Cuc82wVlGR0MiBwZAeRVTZdMtWoIw6TFAW0SI
Message-ID: <CAHUa44GzZtLPMRH6yEHP7e6TLfLbOfEdRpjVy=E4CZ9sRCCbUg@mail.gmail.com>
Subject: Re: [PATCH v3] tee: qcomtee: fix uninitialized pointers with free attribute
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Bar: ----
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9EB564312B
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.46:from];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oss.qualcomm.com,vger.kernel.org,lists.trustedfirmware.org,linaro.org];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.160.46:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: 4YW3YIKMLTH2WK7LPUA7WGMKNT3ORBPY
X-Message-ID-Hash: 4YW3YIKMLTH2WK7LPUA7WGMKNT3ORBPY
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Ally Heev <allyheev@gmail.com>, Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4YW3YIKMLTH2WK7LPUA7WGMKNT3ORBPY/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Wed, Nov 12, 2025 at 8:53=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Tue, Nov 11, 2025 at 01:26:42PM +0530, Ally Heev wrote:
> > Uninitialized pointers with `__free` attribute can cause undefined
> > behavior as the memory assigned randomly to the pointer is freed
> > automatically when the pointer goes out of scope.
> >
> > qcomtee doesn't have any bugs related to this as of now, but
> > it is better to initialize and assign pointers with `__free`
> > attribute in one statement to ensure proper scope-based cleanup
> >
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> > Signed-off-by: Ally Heev <allyheev@gmail.com>
> > ---
> > Changes in v3:
> > - fixed commit message and description
> > - Link to v2: https://lore.kernel.org/r/20251110-aheev-uninitialized-fr=
ee-attr-tee-v2-1-023ffba9ea0f@gmail.com
> >
> > Changes in v2:
> > - initializing variables to NULL at the declaration
> > - Link to v1: https://lore.kernel.org/r/20251105-aheev-uninitialized-fr=
ee-attr-tee-v1-1-2e1ee8483bc5@gmail.com
> > ---
> >  drivers/tee/qcomtee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens


>
> -Sumit
>
> >
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index ac134452cc9cfd384c28d41547545f2c5748d86c..65f9140d4e1f8909d072004=
fd24730543e320d74 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -645,7 +645,7 @@ static void qcomtee_get_version(struct tee_device *=
teedev,
> >  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32=
 id,
> >                                         u32 *version)
> >  {
> > -     struct qcomtee_object_invoke_ctx *oic __free(kfree);
> > +     struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D NULL;
> >       struct qcomtee_object *client_env, *service;
> >       struct qcomtee_arg u[3] =3D { 0 };
> >       int result;
> >
> > ---
> > base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> > change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
> >
> > Best regards,
> > --
> > Ally Heev <allyheev@gmail.com>
> >
