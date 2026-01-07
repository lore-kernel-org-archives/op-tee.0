Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294CBCDC198
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 09:38:51 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 4FABE4FF7F
	for <op-tee@archiver.kernel.org>; Wed,  7 Jan 2026 09:38:50 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kAkCEAUq;
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 21ECB4FF25
	for <op-tee@lists.trustedfirmware.org>; Wed,  7 Jan 2026 09:38:31 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-65ecd7fcf36so1002601eaf.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 07 Jan 2026 01:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767778710; x=1768383510; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzcLdE5lW6KjrMioL4MVcYHG8ltNGC1zHqzO2YGzVIs=;
        b=kAkCEAUqVx6+dQEf2JPbBpwzUOUdSP2bM5+uV0Ie+66MzoUkhNy7tmKwJw8AZ7+YtW
         ab4UE2PNFOTw+cY8T1zg1j8BiiEYDmKyALkPUEvkaOOJwZeXjoZh7zbCRSHc7vfDCa7Y
         8e+6hNzCz/qMztF/fJ5XBi11WfcFdABtGgmUWQ1mzmxD0zrNofew6UdT8fFUvpalaR+l
         JzIF7jfIhMjsb/uQZDle4ELBCzvbJW6YoCD3ghYxo1nlPVLIR+2LdqBRpVMQs/S33Vt0
         n0k+T/aYMdLn4mfqjWspEfnmTPvv8Q5u4H3b8Lx1NjzRiyqyWsMzxCPaK6P/gjeyH2Wi
         k+BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767778710; x=1768383510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzcLdE5lW6KjrMioL4MVcYHG8ltNGC1zHqzO2YGzVIs=;
        b=NJjomvWQI2bu3dxpu5a4UNfSJcXy/OYIpBh0Ki7qg0XC5knq1UrUYMnyXxf6+/QrkH
         5V+hHsNHPyqw4yNvlX9ZTizmFv7vIRsTobu414Ug/YI8ZVTPyRZYootUJB9dN5scb4FY
         hY32J8rKg/1ce2+w84pHpZBqpYAW9JWdhLy72nwMX+fLCGi2ftPJbOecmIDM++WS4Dzh
         jq2O8e+3rw9wDThx3+WjA0IAsWKcoyoqe3jmt/Wym0ap6lZaoDcbXs5CAEXY/2IsvSU3
         +z0Va8Cdpy2GxUblmDXNw0hjz6i2XfmkO064mtRMWMxdWW6Wjvw7n7YJJ9Q58mpxE6uJ
         Vuhw==
X-Forwarded-Encrypted: i=1; AJvYcCVma4igRyz7BO7AMRpUH+Q/N40lrOEhZX6qX2Qc9LF5zX+y8nP7EZfJfgLS1oKJDWyADpkB8dI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyBpqtlOTqOssmoSQPhPRue0yyJ/XIIPMSxTlZIrGX5EifxHCVv
	yHP1Ssao5i8WPo7a5dANwhSPh7locgcsnCz7uYfCrmS+l8/Ohwy2VyXpDHIsA1xOzwuUWQuX/HN
	ViHHuipv0PskOUczPgPIc8PF5Iq5KwHgsdMikyMbwcNhl
X-Gm-Gg: AY/fxX7TJziFoqJyPEW4sFzO6PpQJ9lVybtG6YNzXb//+72WC5xw+MJjc+pZTThFaOL
	gHT1UtMYfEd2cDAoqPL6EfSVlEQkTpF4wD3/kVZwlMk23aPYBx6t+sGGYPXUrXDw2ew4S6AhFnR
	QmRK2Wlhk/PSkYyspykz8pIgriwafqSbfzMdpXJ2O2Lk4C5gB0PqNaZc3RklJnr+poTqbD3VbfW
	tewUk00kDoJuxEeHWS3jACk7LAEaWcnhs3/O//CODmkVoIMAsjmHi/6iMbaioOmfLRdYf7ZoV0K
	PTld8BByCdAGFALEKpExCWuH9Q==
X-Google-Smtp-Source: AGHT+IHSj3fyWcR8PeI71mFrFGfZpz1gtYlT37IzGcQAYuwipaKr7ifaf9acDpnsMoegGnuUM/krqm4/4tHZyu+YBdY=
X-Received: by 2002:a05:6820:f02e:b0:659:9a49:8ff0 with SMTP id
 006d021491bc7-65f54ef5252mr794898eaf.29.1767778710402; Wed, 07 Jan 2026
 01:38:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
 <20251218135332f323fa91@mail.local> <CAHUa44GpW5aO26GDyL9RZub9vVYvVcJ7etwO0yXBN_mUi0W4AA@mail.gmail.com>
 <CAHUa44HqRbCJTXsrTCm0G5iwtkQtq+Si=yOspCjpAn-N2uVSVg@mail.gmail.com> <aV0Qx5BOso5co3tm@bogus>
In-Reply-To: <aV0Qx5BOso5co3tm@bogus>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 7 Jan 2026 10:38:19 +0100
X-Gm-Features: AQt7F2rcNsjXN7djR70fxjzIrnv1VtdzPp10juTq1vFrm5vuVSwDuqGbqR3kJLk
Message-ID: <CAHUa44FhRO0AO3nDXSoZ7O_9T3EFB47D34zRooCTd6fhXFzxXw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
To: Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.60 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.47:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bootlin.com,baylibre.com,lwn.net,kernel.org,selenic.com,gondor.apana.org.au,gmail.com,foss.st.com,oss.qualcomm.com,linaro.org,siemens.com,wanadoo.fr,broadcom.com,hansenpartnership.com,linux.ibm.com,redhat.com,paul-moore.com,namei.org,hallyn.com,gmx.de,lists.trustedfirmware.org,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org,arm.com,ziepe.ca];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.47:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 21ECB4FF25
X-Spamd-Bar: --
Message-ID-Hash: GYXTQHVXLFUG4BG43WNFSMNAS3VFJZ6J
X-Message-ID-Hash: GYXTQHVXLFUG4BG43WNFSMNAS3VFJZ6J
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>, James Morris <jmorris
 @namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, linux-mips@vger.kernel.org, netdev@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/GYXTQHVXLFUG4BG43WNFSMNAS3VFJZ6J/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Tue, Jan 6, 2026 at 2:40=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Mon, Jan 05, 2026 at 10:16:09AM +0100, Jens Wiklander wrote:
> > Hi,
> >
> > On Thu, Dec 18, 2025 at 5:29=E2=80=AFPM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > On Thu, Dec 18, 2025 at 2:53=E2=80=AFPM Alexandre Belloni
> > > <alexandre.belloni@bootlin.com> wrote:
> > > >
> > > > On 18/12/2025 08:21:27+0100, Jens Wiklander wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, Dec 15, 2025 at 3:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig
> > > > > <u.kleine-koenig@baylibre.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > the objective of this series is to make tee driver stop using c=
allbacks
> > > > > > in struct device_driver. These were superseded by bus methods i=
n 2006
> > > > > > (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shut=
down
> > > > > > methods.")) but nobody cared to convert all subsystems accordin=
gly.
> > > > > >
> > > > > > Here the tee drivers are converted. The first commit is somewha=
t
> > > > > > unrelated, but simplifies the conversion (and the drivers). It
> > > > > > introduces driver registration helpers that care about setting =
the bus
> > > > > > and owner. (The latter is missing in all drivers, so by using t=
hese
> > > > > > helpers the drivers become more correct.)
> > > > > >
> > > > > > v1 of this series is available at
> > > > > > https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koeni=
g@baylibre.com
> > > > > >
> > > > > > Changes since v1:
> > > > > >
> > > > > >  - rebase to v6.19-rc1 (no conflicts)
> > > > > >  - add tags received so far
> > > > > >  - fix whitespace issues pointed out by Sumit Garg
> > > > > >  - fix shutdown callback to shutdown and not remove
> > > > > >
> > > > > > As already noted in v1's cover letter, this series should go in=
 during a
> > > > > > single merge window as there are runtime warnings when the seri=
es is
> > > > > > only applied partially. Sumit Garg suggested to apply the whole=
 series
> > > > > > via Jens Wiklander's tree.
> > > > > > If this is done the dependencies in this series are honored, in=
 case the
> > > > > > plan changes: Patches #4 - #17 depend on the first two.
> > > > > >
> > > > > > Note this series is only build tested.
> > > > > >
> > > > > > Uwe Kleine-K=C3=B6nig (17):
> > > > > >   tee: Add some helpers to reduce boilerplate for tee client dr=
ivers
> > > > > >   tee: Add probe, remove and shutdown bus callbacks to tee_clie=
nt_driver
> > > > > >   tee: Adapt documentation to cover recent additions
> > > > > >   hwrng: optee - Make use of module_tee_client_driver()
> > > > > >   hwrng: optee - Make use of tee bus methods
> > > > > >   rtc: optee: Migrate to use tee specific driver registration f=
unction
> > > > > >   rtc: optee: Make use of tee bus methods
> > > > > >   efi: stmm: Make use of module_tee_client_driver()
> > > > > >   efi: stmm: Make use of tee bus methods
> > > > > >   firmware: arm_scmi: optee: Make use of module_tee_client_driv=
er()
> > > > > >   firmware: arm_scmi: Make use of tee bus methods
> > > > > >   firmware: tee_bnxt: Make use of module_tee_client_driver()
> > > > > >   firmware: tee_bnxt: Make use of tee bus methods
> > > > > >   KEYS: trusted: Migrate to use tee specific driver registratio=
n
> > > > > >     function
> > > > > >   KEYS: trusted: Make use of tee bus methods
> > > > > >   tpm/tpm_ftpm_tee: Make use of tee specific driver registratio=
n
> > > > > >   tpm/tpm_ftpm_tee: Make use of tee bus methods
> > > > > >
> > > > > >  Documentation/driver-api/tee.rst             | 18 +----
> > > > > >  drivers/char/hw_random/optee-rng.c           | 26 ++----
> > > > > >  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
> > > > > >  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
> > > > > >  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
> > > > > >  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
> > > > > >  drivers/rtc/rtc-optee.c                      | 27 ++-----
> > > > > >  drivers/tee/tee_core.c                       | 84 ++++++++++++=
++++++++
> > > > > >  include/linux/tee_drv.h                      | 12 +++
> > > > > >  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
> > > > > >  10 files changed, 164 insertions(+), 138 deletions(-)
> > > > > >
> > > > > > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > > > > > --
> > > > > > 2.47.3
> > > > > >
> > > > >
> > > > > Thank you for the nice cleanup, Uwe.
> > > > >
> > > > > I've applied patch 1-3 to the branch tee_bus_callback_for_6.20 in=
 my
> > > > > tree at https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/li=
nux-tee.git/
> > > > >
> > > > > The branch is based on v6.19-rc1, and I'll try to keep it stable =
for
> > > > > others to depend on, if needed. Let's see if we can agree on taki=
ng
> > > > > the remaining patches via that branch.
> > > >
> > > > 6 and 7 can go through your branch.
> > >
> > > Good, I've added them to my branch now.
> >
> > This entire patch set should go in during a single merge window. I
> > will not send any pull request until I'm sure all patches will be
> > merged.
> >
> > So far (if I'm not mistaken), only the patches I've already added to
> > next have appeared next. I can take the rest of the patches, too, but
> > I need OK for the following:
> >
>
> [...]
>
> >
> > Sudeep, you seem happy with the following patches
> > - firmware: arm_scmi: optee: Make use of module_tee_client_driver()
> > - firmware: arm_scmi: Make use of tee bus methods
> > OK if I take them via my tree, or would you rather take them yourself?
> >
>
> I am happy if you want to take all of them in one go. I think I have
> already acked it. Please shout if you need anything else from me, happy t=
o
> help in anyway to make it easier to handle this change set.

Thanks, I've applied all the patches in the series now, since it
otherwise causes warnings during boot.

/Jens
