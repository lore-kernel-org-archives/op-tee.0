Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF85AC2A072
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 09:16:42 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 16CC04FF2E
	for <op-tee@archiver.kernel.org>; Mon,  5 Jan 2026 09:16:42 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=PMm9xxvp;
	dkim-atps=neutral
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 10C9841B30
	for <op-tee@lists.trustedfirmware.org>; Mon,  5 Jan 2026 09:16:22 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3eae4e590a4so7202260fac.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 05 Jan 2026 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767604581; x=1768209381; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS4Pieemzy4r1o+XZyR7jxfKf1/JCiqumXmtg6ZAf0Y=;
        b=PMm9xxvp0lx8m5dxuXIrMVUqQbwiRlxijFK1D4z7fXpxhKBhM1gng9scYnwyj9EUPd
         LTE6JCI15jJzSGKdxdXt8HOuCDbXKlrZ3RAyLcn4RTPGyBCOyv3PBzZxadGZnR9Mw36O
         E9n6hFP8sAHsWr+WkeXhGTb6KRnrODlMbsTT/0KPLSSctcXOCwZP/fl21TJEi28ii6Y/
         zfTaoeSLQKcmt3d9vK1BZdsNYvmnfZoXP1BRHzNWI2DA4zCNjVhjJxGNXK0sf0wVs+Vd
         4CZ5LzkIGnoM4bfP8IQa25LcgbQh2CaODs+nqvGld8eBvEbSFIjcDHiQIjTVqmTtWA5/
         YcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767604581; x=1768209381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xS4Pieemzy4r1o+XZyR7jxfKf1/JCiqumXmtg6ZAf0Y=;
        b=F+ptynYkysrTDwFWhm4akAOlzUtwQhbOnZWip+iyTlSfpj1kvrULkA6gX0UG9UhDx7
         Vdbs6gKLbX/s6i90k9VDZ1LGDmA5GZZHyr8xUObQgPgBqXiYbBDjKKbCeXM8j0mjgjl4
         hOjq5IUiTnsOgi03V8Zhyy42DsqsOCu03cO95M3TyGLCO3B7DrtGzkLGKqxtp171I4Fy
         wEReBr76V99Pf1i5rTgusCkpIPVLP1xwWPdhAE1rlGLvCuQaLrVVb14cQnmEggAIlgbp
         nQVcgbC3tvOuYaKKzhghM+/3LWDiBpbcR0pkH9VEvT8C9kAh3pq8g1OFgAyVPbQHPYHI
         ZvDA==
X-Forwarded-Encrypted: i=1; AJvYcCWRonYQmN0pJ2SKm2GeETzF2L5NEvZrYmzfG6zNcbO9jiWqjmFiIS2INldH1vHlO2jO1/CIWGU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YxZf0nkFjFKbyWodPHdCbQCVS68pc9/J2zSY3ppzpGBEmJUo+i2
	mVQuTk3OQwu+IOIp85zqnF9/02jGzzfwf+yo4I3hUkyFc4u2AeBLC3CdyRGW8Vk7GaOKzUTdeHU
	XtqfCX/ku8NMWN4WikzV7MF5lwt4ejfBTNn8pS/+WNTXV
X-Gm-Gg: AY/fxX4wBvWnuCkDFRpTDrCdpV0zxWwURCtkSgEezf4YvjUhJ9c2s6oit/sPw7Fs6DL
	5GucBy9tjqhjdNmzKBcAYkIXU6Z55u2h+aQUS4uirwoU7KflAa+tfCcxjjeYTA77sFXD/gDEeoC
	IpQ/5RcmeGI2VkFjl9FNlW67WjjPpWPq+BkfiuD7x54DgbuiY/SnVmVJy9xeYMzZyjARWpS/f5n
	r3nt7SMLq30T4RxJ3rHrVSdTqngfruPewgdb1f0NHFTSc0IoeZU8gu3BnoADHnooRIn4IFjzV7N
	IpUxViNk2WSSpIh60F2jwn5bDg==
X-Google-Smtp-Source: AGHT+IHdtu3uK1YvLPvRXmBmsYletnr+Fy6yEnWw7FcQJMBZUAFsUyE2L/0PG3GpU/2KGeBY95bkFD0S8glmAzrpFaU=
X-Received: by 2002:a05:6820:2289:b0:65c:f9c1:cba0 with SMTP id
 006d021491bc7-65d0ea16a88mr23376881eaf.37.1767604581140; Mon, 05 Jan 2026
 01:16:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
 <20251218135332f323fa91@mail.local> <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
In-Reply-To: <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 5 Jan 2026 10:16:09 +0100
X-Gm-Features: AQt7F2q8lTcIoa5xBnvz2Mkjx2axWX5OMGPJpQNfFM5WoFI2KGlEdVoT6sJvPQg
Message-ID: <CAHUa44HqRbCJTXsrTCm0G5iwtkQtq+Si=yOspCjpAn-N2uVSVg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.42:from];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,lwn.net,kernel.org,selenic.com,gondor.apana.org.au,bootlin.com,gmail.com,foss.st.com,oss.qualcomm.com,linaro.org,siemens.com,arm.com,wanadoo.fr,broadcom.com,hansenpartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,ziepe.ca];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.160.42:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 10C9841B30
X-Spamd-Bar: --
Message-ID-Hash: TW4GXA4MKLMP4CU5QUNGIXQONYMZXCWO
X-Message-ID-Hash: TW4GXA4MKLMP4CU5QUNGIXQONYMZXCWO
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "
 Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/TW4GXA4MKLMP4CU5QUNGIXQONYMZXCWO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Thu, Dec 18, 2025 at 5:29=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> On Thu, Dec 18, 2025 at 2:53=E2=80=AFPM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 18/12/2025 08:21:27+0100, Jens Wiklander wrote:
> > > Hi,
> > >
> > > On Mon, Dec 15, 2025 at 3:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > <u.kleine-koenig@baylibre.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > the objective of this series is to make tee driver stop using callb=
acks
> > > > in struct device_driver. These were superseded by bus methods in 20=
06
> > > > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> > > > methods.")) but nobody cared to convert all subsystems accordingly.
> > > >
> > > > Here the tee drivers are converted. The first commit is somewhat
> > > > unrelated, but simplifies the conversion (and the drivers). It
> > > > introduces driver registration helpers that care about setting the =
bus
> > > > and owner. (The latter is missing in all drivers, so by using these
> > > > helpers the drivers become more correct.)
> > > >
> > > > v1 of this series is available at
> > > > https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@ba=
ylibre.com
> > > >
> > > > Changes since v1:
> > > >
> > > >  - rebase to v6.19-rc1 (no conflicts)
> > > >  - add tags received so far
> > > >  - fix whitespace issues pointed out by Sumit Garg
> > > >  - fix shutdown callback to shutdown and not remove
> > > >
> > > > As already noted in v1's cover letter, this series should go in dur=
ing a
> > > > single merge window as there are runtime warnings when the series i=
s
> > > > only applied partially. Sumit Garg suggested to apply the whole ser=
ies
> > > > via Jens Wiklander's tree.
> > > > If this is done the dependencies in this series are honored, in cas=
e the
> > > > plan changes: Patches #4 - #17 depend on the first two.
> > > >
> > > > Note this series is only build tested.
> > > >
> > > > Uwe Kleine-K=C3=B6nig (17):
> > > >   tee: Add some helpers to reduce boilerplate for tee client driver=
s
> > > >   tee: Add probe, remove and shutdown bus callbacks to tee_client_d=
river
> > > >   tee: Adapt documentation to cover recent additions
> > > >   hwrng: optee - Make use of module_tee_client_driver()
> > > >   hwrng: optee - Make use of tee bus methods
> > > >   rtc: optee: Migrate to use tee specific driver registration funct=
ion
> > > >   rtc: optee: Make use of tee bus methods
> > > >   efi: stmm: Make use of module_tee_client_driver()
> > > >   efi: stmm: Make use of tee bus methods
> > > >   firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> > > >   firmware: arm_scmi: Make use of tee bus methods
> > > >   firmware: tee_bnxt: Make use of module_tee_client_driver()
> > > >   firmware: tee_bnxt: Make use of tee bus methods
> > > >   KEYS: trusted: Migrate to use tee specific driver registration
> > > >     function
> > > >   KEYS: trusted: Make use of tee bus methods
> > > >   tpm/tpm_ftpm_tee: Make use of tee specific driver registration
> > > >   tpm/tpm_ftpm_tee: Make use of tee bus methods
> > > >
> > > >  Documentation/driver-api/tee.rst             | 18 +----
> > > >  drivers/char/hw_random/optee-rng.c           | 26 ++----
> > > >  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
> > > >  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
> > > >  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
> > > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
> > > >  drivers/rtc/rtc-optee.c                      | 27 ++-----
> > > >  drivers/tee/tee_core.c                       | 84 ++++++++++++++++=
++++
> > > >  include/linux/tee_drv.h                      | 12 +++
> > > >  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
> > > >  10 files changed, 164 insertions(+), 138 deletions(-)
> > > >
> > > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > > --
> > > > 2.47.3
> > > >
> > >
> > > Thank you for the nice cleanup, Uwe.
> > >
> > > I've applied patch 1-3 to the branch tee_bus_callback_for_6.20 in my
> > > tree at https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-=
tee.git/
> > >
> > > The branch is based on v6.19-rc1, and I'll try to keep it stable for
> > > others to depend on, if needed. Let's see if we can agree on taking
> > > the remaining patches via that branch.
> >
> > 6 and 7 can go through your branch.
>
> Good, I've added them to my branch now.

This entire patch set should go in during a single merge window. I
will not send any pull request until I'm sure all patches will be
merged.

So far (if I'm not mistaken), only the patches I've already added to
next have appeared next. I can take the rest of the patches, too, but
I need OK for the following:

Jarkko, you seem happy with the following patches
- KEYS: trusted: Migrate to use tee specific driver registration function
- KEYS: trusted: Make use of tee bus methods
- tpm/tpm_ftpm_tee: Make use of tee specific driver registration
- tpm/tpm_ftpm_tee: Make use of tee bus methods
OK if I take them via my tree, or would you rather take them yourself?

Herbert, you seem happy with the following patches
- hwrng: optee - Make use of module_tee_client_driver()
- hwrng: optee - Make use of tee bus methods
OK if I take them via my tree, or would you rather take them yourself?

Sudeep, you seem happy with the following patches
- firmware: arm_scmi: optee: Make use of module_tee_client_driver()
- firmware: arm_scmi: Make use of tee bus methods
OK if I take them via my tree, or would you rather take them yourself?

Michael, Pavan, are you OK with the following patches
- firmware: tee_bnxt: Make use of module_tee_client_driver()
- firmware: tee_bnxt: Make use of tee bus methods
OK if I take them via my tree, or would you rather take them yourself?

Thanks,
Jens
