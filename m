Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D37BD6E2AD
	for <op-tee@archiver.kernel.org>; Thu, 18 Dec 2025 16:29:43 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 783DD4FF56
	for <op-tee@archiver.kernel.org>; Thu, 18 Dec 2025 16:29:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MXmrzbfy;
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7F84943171
	for <op-tee@lists.trustedfirmware.org>; Thu, 18 Dec 2025 16:29:24 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-657509d761dso431378eaf.0
        for <op-tee@lists.trustedfirmware.org>; Thu, 18 Dec 2025 08:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766075364; x=1766680164; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMSbry1+P/RNP4K+kKiw/SAaU8hSKKePZ7aYLlJ/2Ro=;
        b=MXmrzbfy1auZ4vQpAeSZTQel2S+oRpiV1VMHz7vts/B8NeakMD8Fl3x4fiKzJdmcvr
         FFzYy0o9+w24kvLfeKxstrtqEmPZg2ZlBvndugkleny58WKe7PcE9ls0YU3lxDwUIL4B
         qSy9mtEHuYtq2ocmG8jgKjEfTYTFl9Pyt9XAgsmptkkIMeFkJdgJk125ZtwdN92RZ9IO
         YePuSVGr1Pg/U0qZWPt00TMJ0J6qjo3us5xn3wiIWPqcjU/8r0iIQsQ4AnH/z6vo9Bxj
         ZaL0N8w+mENTH6zmmtnjdRTvl9JPMsI8o1pSlBKlDxD7oF+WduJ/IeHFKAe1o0rpYKW7
         FuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766075364; x=1766680164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zMSbry1+P/RNP4K+kKiw/SAaU8hSKKePZ7aYLlJ/2Ro=;
        b=sJVqtcdau+MwrUvEG1R4LRZ0hnMZluHgQS6tDHUJtWY4WxKHJYBy91+qMRhAiWG42A
         oNXi2q8AxLj97lMxNH6UNp4nRcGBBhWxVnzLboTv/cBut7bP1XQfQf757OXnetYnXSXt
         BSlWk6zmxa+kulJXRIlDbxBUhh36eQR0LUj9sfh23Z+ukGz80BLznjQ0vk68Nqmdm5LW
         2kuxuk2KLYICeKL2HVuJDfTXsvD9VYJXngkqixfdBHoOguY+knuMLmAeNuYWu7QENNQj
         gxbnvw5QQS50sPctpdeUgZmJ40g+3BZLD7UQwoy9BelmkjKjCoXZABPiwaKEjjMrS7CT
         wVNw==
X-Forwarded-Encrypted: i=1; AJvYcCXe+AtHUdmaiN6h/pJ1EVUeeGEZTIJr4kqyDWiPeVFRZmII1KFcartBSQIQU5vLuMoiq5VMAV0=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywn+FNxc3DLDYQH31oRLZPUWyj1FJ093B24WHmPtprxvkNNRRYB
	1dzgdl3jb9tIk4g9g/afg7iVLYPEvqPwNOSGA1K3/nvTuA0PPy212hkVLKuGoGIVZlKWpMeLGsx
	VxP+eIpCLFI64KPBcqNBNbaWfuBpB6dt0c5+B3NRbkXZD
X-Gm-Gg: AY/fxX7YrE/SuzPQBo6JNtN9ZcgEY8pj/d1Ax+zz6XcplLGJESjnhtGr2gWRGLukMqy
	KSID/2XTKxLCsfacO9xitcnXqGBNWJ6hr6QJ4FTsJNUWzJfhSGiHZdHB9Yw0DIC6sjGEHqw/G2C
	1IBCFgx1vBlbMjL5U8DIPp0cLv02g8q0maoo5yFSlxTyOoF6srHfAep5W/jO71TRH3Jv34ju24f
	uWpWxVIpEz9lsDrGeZSBgOt4Tk1JXmjl/fuTWCOmZITFmqpgsaVo6OuWzHhQxkpmYaffnfD+XE4
	7MqSN1BIG+iT7PdwQGLY/NmETg==
X-Google-Smtp-Source: AGHT+IG4Ae8pfu7GZWy4M+xMepW+pZBXhOq0aMMfvpQMcwHosUK2iqdP0ZilC2IC9nPL0ue49M44wROrYBjFkfFnq4M=
X-Received: by 2002:a05:6820:6389:b0:657:4e49:83b7 with SMTP id
 006d021491bc7-65d0e9fe36fmr11432eaf.1.1766075363719; Thu, 18 Dec 2025
 08:29:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com> <20251218135332f323fa91@mail.local>
In-Reply-To: <20251218135332f323fa91@mail.local>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 18 Dec 2025 17:29:11 +0100
X-Gm-Features: AQt7F2pA2I_HJOEbadmjsOrYtjrxD8lxVlzGBd-sNqyaYCgybyYAHq_YVDlH-Pg
Message-ID: <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.42:from];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[42];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,lwn.net,kernel.org,selenic.com,gondor.apana.org.au,bootlin.com,gmail.com,foss.st.com,oss.qualcomm.com,linaro.org,siemens.com,arm.com,wanadoo.fr,broadcom.com,hansenpartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,ziepe.ca];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.42:from];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7F84943171
X-Spamd-Bar: --
Message-ID-Hash: KJLLCE7G3DA66OITKTZDL6NFK4LHSPH6
X-Message-ID-Hash: KJLLCE7G3DA66OITKTZDL6NFK4LHSPH6
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "
 Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/KJLLCE7G3DA66OITKTZDL6NFK4LHSPH6/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Dec 18, 2025 at 2:53=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 18/12/2025 08:21:27+0100, Jens Wiklander wrote:
> > Hi,
> >
> > On Mon, Dec 15, 2025 at 3:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@baylibre.com> wrote:
> > >
> > > Hello,
> > >
> > > the objective of this series is to make tee driver stop using callbac=
ks
> > > in struct device_driver. These were superseded by bus methods in 2006
> > > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> > > methods.")) but nobody cared to convert all subsystems accordingly.
> > >
> > > Here the tee drivers are converted. The first commit is somewhat
> > > unrelated, but simplifies the conversion (and the drivers). It
> > > introduces driver registration helpers that care about setting the bu=
s
> > > and owner. (The latter is missing in all drivers, so by using these
> > > helpers the drivers become more correct.)
> > >
> > > v1 of this series is available at
> > > https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@bayl=
ibre.com
> > >
> > > Changes since v1:
> > >
> > >  - rebase to v6.19-rc1 (no conflicts)
> > >  - add tags received so far
> > >  - fix whitespace issues pointed out by Sumit Garg
> > >  - fix shutdown callback to shutdown and not remove
> > >
> > > As already noted in v1's cover letter, this series should go in durin=
g a
> > > single merge window as there are runtime warnings when the series is
> > > only applied partially. Sumit Garg suggested to apply the whole serie=
s
> > > via Jens Wiklander's tree.
> > > If this is done the dependencies in this series are honored, in case =
the
> > > plan changes: Patches #4 - #17 depend on the first two.
> > >
> > > Note this series is only build tested.
> > >
> > > Uwe Kleine-K=C3=B6nig (17):
> > >   tee: Add some helpers to reduce boilerplate for tee client drivers
> > >   tee: Add probe, remove and shutdown bus callbacks to tee_client_dri=
ver
> > >   tee: Adapt documentation to cover recent additions
> > >   hwrng: optee - Make use of module_tee_client_driver()
> > >   hwrng: optee - Make use of tee bus methods
> > >   rtc: optee: Migrate to use tee specific driver registration functio=
n
> > >   rtc: optee: Make use of tee bus methods
> > >   efi: stmm: Make use of module_tee_client_driver()
> > >   efi: stmm: Make use of tee bus methods
> > >   firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> > >   firmware: arm_scmi: Make use of tee bus methods
> > >   firmware: tee_bnxt: Make use of module_tee_client_driver()
> > >   firmware: tee_bnxt: Make use of tee bus methods
> > >   KEYS: trusted: Migrate to use tee specific driver registration
> > >     function
> > >   KEYS: trusted: Make use of tee bus methods
> > >   tpm/tpm_ftpm_tee: Make use of tee specific driver registration
> > >   tpm/tpm_ftpm_tee: Make use of tee bus methods
> > >
> > >  Documentation/driver-api/tee.rst             | 18 +----
> > >  drivers/char/hw_random/optee-rng.c           | 26 ++----
> > >  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
> > >  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
> > >  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
> > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
> > >  drivers/rtc/rtc-optee.c                      | 27 ++-----
> > >  drivers/tee/tee_core.c                       | 84 ++++++++++++++++++=
++
> > >  include/linux/tee_drv.h                      | 12 +++
> > >  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
> > >  10 files changed, 164 insertions(+), 138 deletions(-)
> > >
> > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > --
> > > 2.47.3
> > >
> >
> > Thank you for the nice cleanup, Uwe.
> >
> > I've applied patch 1-3 to the branch tee_bus_callback_for_6.20 in my
> > tree at https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-te=
e.git/
> >
> > The branch is based on v6.19-rc1, and I'll try to keep it stable for
> > others to depend on, if needed. Let's see if we can agree on taking
> > the remaining patches via that branch.
>
> 6 and 7 can go through your branch.

Good, I've added them to my branch now.

Thanks,
Jens
