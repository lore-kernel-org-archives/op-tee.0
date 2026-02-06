Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20022EE2080
	for <op-tee@archiver.kernel.org>; Fri,  6 Feb 2026 10:10:55 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 506FA43711
	for <op-tee@archiver.kernel.org>; Fri,  6 Feb 2026 10:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1770372654;
	bh=+raMpszw+VfiU8LwlzdNKHxES59Mccz7j6Z7SxfXCao=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=gdzO9C44GqgF4mf57m00/uUR1uFImoLBaGZwI78JjBO8bnXLQdOCTiQ0Sw8Nf5zNx
	 uhkPC92BbCys5KYV06gEgx0+i78OYKrj84s53I9tprbA35V0lC33gJ3AFPd2uLzfo5
	 QLuAN/FxdIJPagaCI6UOxlVqflmLVnePYjHuQXyPioWTrG2wiu1vWFccFUWiTU8oI5
	 yNdD32G6YDuz+M91hj70oyl3P+idsoYxIfYqC6fqqNSTf4WHC1EckfZb/NDI0+NiC6
	 Ys7lqHtJJgslh9fg5vDEZhXHC1MfSt6GInk7eYWgLVBrVcU9r3bI+/tiRN3wn+iG7n
	 r+lLscxIZARvQ==
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id B74C4436F3
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Feb 2026 10:10:34 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=forissier.org header.i=@forissier.org header.a=rsa-sha256 header.s=google header.b=ebHrC5qN;
	dkim-atps=neutral
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a8fba3f769so8841495ad.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Feb 2026 02:10:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770372634; cv=none;
        d=google.com; s=arc-20240605;
        b=QOFnWz+Yy208OwT5W9V2IVPdrnPT4oiqn7hSeG9mzq5474lRsYSEtY2bPYOYzrS78J
         oHDlnfURtMIuBnUoIO5CeLVIevs3JMJ6s9pNmFyo0cHtJUe5ZXCpyzL7xrqknWauJIOv
         twkZoF11v00y+8e63RerErhmdjPHB0/vyLEgF3tFg89urdAmBdS3NpgPhfQKeENA17x7
         BUxTyZmUhBHRhPM9L9qrFT/o8vthYC8exdg8NXgsAsJmXfBEP3ZN2cboKdCtpPvpPNgK
         VQR5RRxMSEH9N8f2fDzed31/h82ilDKpd2UsD9vvW+3pZgPkAuRESzIDZaxOP62MjncC
         IpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCPgnb7KEPXry1O1IYURNqjbLQ+f0InuIl7jk/xq6CU=;
        fh=1LCg1W+GZVpQpRe/L6bASElmx74GS7+Gupy+BZQmDps=;
        b=CwbJab7cDg8E6d+W1Z9FemyGfa2eVsQvxG8K5wN+2qor+9BEmNE7ehJs4iFSosBmYk
         8HPAwyXH7ObYh6khlsvqBYY0I+VVj9NJzvpe35sDS4m1B+Jvtgdm3cY4OuVBfiWWIVpu
         LUYH3DfkULc+4Jhta2A+HYy+lmNhN71l59/b6qoGpNBNFCPTIJpwLCFIrrkQ258o6Sj2
         wlfxYAdEu86xdO47qAq3AcCdTTx3DgvVqBxBa8HEJ5e7/2wGWh2bxt0hYrpKHsI6nr+i
         03vCh1SLZSaslIDhUpL0HariO0KC4AXZgoA1j+jJtYJQ/fbQhe9qOMN9+6qjLULUPfkg
         /tZQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier.org; s=google; t=1770372634; x=1770977434; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCPgnb7KEPXry1O1IYURNqjbLQ+f0InuIl7jk/xq6CU=;
        b=ebHrC5qNwDcnHycrMUj1ByBYx+8OMVo1059xeHZCqk4BW7ywMVhLJrKZvv4ZoOSnrm
         OAeNninZ/8490KzaPfoFjtWnzmSTLeW8EYqTu7ztenDoJAVKenEamrOMtMwmjfYsSe0d
         AFyTO9X3TbwAQisJPF91YceQUpH06fbpTSGqr+YdwoSnWFbweQ2AzC75Rj2R5x/Ftn9V
         US832ETcQf5udOmvHlHpvcwMJ68sr7T5IsT81cHAQaS9Za/YvR5LB6gu9ftPeWF4xWO8
         ZUocqnWQEKt29K2l2xCn8HWGX3Tahl/Fo7VW1XHQ5g8VCYaKsAc96sCDuJlGLHsQQURR
         gAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770372634; x=1770977434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zCPgnb7KEPXry1O1IYURNqjbLQ+f0InuIl7jk/xq6CU=;
        b=SMHvU8+0YgKtpDQO4Jyd+vSPyEhok554auDNVJzZSsKSDRCsB6QNqw4KkttXVap7bm
         RCPfd/eGP2uog3xIOkggsJ0oyp+itu1CWjLlEDWG4KYuQYtXA1YhtGQGHE+JrhU/VOvE
         +rnCV3Weo7DRHs2rFL02KciYi/tsXi97wgY3M0rrIDFvirwqTlGxy2f7/pl9IDZMCtdj
         lbyhS1VXYY1WCxooUbDY7G0ND/YGacd8QUvNGTmXNykYLiS96/vLXhg2F/+j6vM3EH0q
         sYLSVbbKMmKeakUEbV3SMiQbh6AVxoJBvUx/0VcY1SS2IRCi1OAgkhmOZTPpMsyXqbMq
         RT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxgIcjswmY7l/D9nrRAaG3//5nkxJehirpY1vBCMYp/8jsRQ7S61pJNfNrHFfKMwpBXAgC+pI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yx1nAkII539wqDDvFFGB6Tpxry0oaXKYeKQwYiZmTAFQRCW+Vdw
	cXDsWm72y1oCs6SG8qHdC4dz0CpjmjLv7GeykOxgTZ1tyINv+XB0+Ft9qcKIKUWDOSGXtTIhPYL
	gMRglRhLXJWEU4lwqg6OelN6cEutPicoNso6u/J+yoA==
X-Gm-Gg: AZuq6aIowfaii4NxEia/P42UySIjxyGWqvEn9IDkLyxEhQXuQf9CYaE8xKZpeF+QNyf
	4RNSYAG2WpGYnsXwV2AIl7o2tq2z8SwM+OhsipkA6pQsRijgb0PLiJQO+tZDaqEFVMglR2B1Pgf
	VPTlg+VS8eFEN183xsoNdUK2ngWpOdAgbcrgx0cXXEdHdgnohTDqvVXfxJuWdZAcc0Pr4gXjiAD
	dbczoHlidKeoYiCvuhboZI/kg+w6LpXk6IJHO06fzPtm1KAAaeKTMrD8uqQ2iqu9E7J9aTl1RsO
	fyyji5Y=
X-Received: by 2002:a17:902:e809:b0:2a0:d34f:aff3 with SMTP id
 d9443c01a7336-2a95164c0eemr25673595ad.18.1770372633718; Fri, 06 Feb 2026
 02:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
 <CAHUa44E4Htg9zEMY9XtkMsPRJq+13mq6kSd8RUznHTRvXVXKVQ@mail.gmail.com>
 <55546b03-cbe6-40dd-b794-b2e81efde33a@oss.qualcomm.com> <CAHUa44FfowG=GpgLcq=sp_TqRArJtf0_V-tsJY11HH+FEA6u+w@mail.gmail.com>
 <4c9e4f5f-e0f3-42aa-852f-064f4024af26@oss.qualcomm.com> <CAHUa44EhaztJ+5piu0c-HQbqZFX47uLPJ+VDRp=Bp6BMeeARAQ@mail.gmail.com>
 <b8086bfb-f240-4115-9ab0-18509775932a@oss.qualcomm.com> <CAHUa44GhTy=TWAuG7JY_6jjWG-uCGnLyZRn1JhGWgaWt28cH7w@mail.gmail.com>
In-Reply-To: <CAHUa44GhTy=TWAuG7JY_6jjWG-uCGnLyZRn1JhGWgaWt28cH7w@mail.gmail.com>
Date: Fri, 6 Feb 2026 11:10:22 +0100
X-Gm-Features: AZwV_QgHFkxvM7-SfE4zulthjLCOgAI9_C7OQtk4WJKE5RyCOXruSJm_rkaAV_M
Message-ID: <CAA-cTWYKSiWRFipi6Ka7h9c99t-RAA1kVrwbjApZseErv3gFwg@mail.gmail.com>
Subject: Re: [PATCH v3] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.57 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[forissier.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[forissier.org:s=google];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.214.173:from];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.214.173:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[forissier.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: B74C4436F3
X-Spamd-Bar: ----
Message-ID-Hash: F27USETMX36LI2LESEVBAI753GCHHWJS
X-Message-ID-Hash: F27USETMX36LI2LESEVBAI753GCHHWJS
X-MailFrom: jerome@forissier.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Wu <michael@allwinnertech.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/F27USETMX36LI2LESEVBAI753GCHHWJS/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: =?utf-8?q?J=C3=A9r=C3=B4me_Forissier_via_OP-TEE?= <op-tee@lists.trustedfirmware.org>
Reply-To: =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome@forissier.org>

Hi,


On Fri, Feb 6, 2026 at 9:54=E2=80=AFAM Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
>
> Hi Amir,
>
> On Thu, Feb 5, 2026 at 3:13=E2=80=AFAM Amirreza Zarrabi
> <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >
> > Hi Jens,
> >
> > On 2/4/2026 6:46 PM, Jens Wiklander wrote:
> > > Hi Amir,
> > >
> > > On Tue, Feb 3, 2026 at 11:56=E2=80=AFPM Amirreza Zarrabi
> > > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> > >>
> > >> Hi Jens,
> > >>
> > >> On 2/3/2026 5:59 PM, Jens Wiklander wrote:
> > >>> Hi,
> > >>>
> > >>> On Tue, Feb 3, 2026 at 3:09=E2=80=AFAM Amirreza Zarrabi
> > >>> <amirreza.zarrabi@oss.qualcomm.com> wrote:
> > >>>>
> > >>>> Hi Jens,
> > >>>>
> > >>>> On 2/2/2026 10:36 PM, Jens Wiklander wrote:
> > >>>>> Hi Amir,
> > >>>>>
> > >>>>> On Thu, Jan 29, 2026 at 4:22=E2=80=AFAM Amirreza Zarrabi
> > >>>>> <amirreza.zarrabi@oss.qualcomm.com> wrote:
> > >>>>>>
> > >>>>>> Commit 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop") mad=
e the
> > >>>>>> client wait as killable so it can be interrupted during shutdown=
 or
> > >>>>>> after a supplicant crash. This changes the original lifetime exp=
ectations:
> > >>>>>> the client task can now terminate while the supplicant is still =
processing
> > >>>>>> its request.
> > >>>>>>
> > >>>>>> If the client exits first it removes the request from its queue =
and
> > >>>>>> kfree()s it, while the request ID remains in supp->idr. A subseq=
uent
> > >>>>>> lookup on the supplicant path then dereferences freed memory, le=
ading to
> > >>>>>> a use-after-free.
> > >>>>>>
> > >>>>>> Serialise access to the request with supp->mutex:
> > >>>>>>
> > >>>>>>   * Hold supp->mutex in optee_supp_recv() and optee_supp_send() =
while
> > >>>>>>     looking up and touching the request.
> > >>>>>>   * Let optee_supp_thrd_req() notice that the client has termina=
ted and
> > >>>>>>     signal optee_supp_send() accordingly.
> > >>>>>>
> > >>>>>> With these changes the request cannot be freed while the supplic=
ant still
> > >>>>>> has a reference, eliminating the race.
> > >>>>>>
> > >>>>>> Fixes: 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop")
> > >>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.c=
om>
> > >>>>>> ---
> > >>>>>> Changes in v3:
> > >>>>>> - Introduce processed flag instead of -1 for req->id.
> > >>>>>> - Update optee_supp_release() as reported by Michael Wu.
> > >>>>>> - Use mutex instead of guard.
> > >>>>>> - Link to v2: https://lore.kernel.org/r/20250617-fix-use-after-f=
ree-v2-1-1fbfafec5917@oss.qualcomm.com
> > >>>>>>
> > >>>>>> Changes in v2:
> > >>>>>> - Replace the static variable with a sentinel value.
> > >>>>>> - Fix the issue with returning the popped request to the supplic=
ant.
> > >>>>>> - Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-f=
ree-v1-1-a70d23bff248@oss.qualcomm.com
> > >>>>>> ---
> > >>>>>>  drivers/tee/optee/supp.c | 122 ++++++++++++++++++++++++++++++++=
+--------------
> > >>>>>>  1 file changed, 86 insertions(+), 36 deletions(-)
> > >>>>>
> [snip]
>
>
> > >>>>>> @@ -328,9 +378,8 @@ int optee_supp_send(struct tee_context *ctx,=
 u32 ret, u32 num_params,
> > >>>>>>
> > >>>>>>         mutex_lock(&supp->mutex);
> > >>>>>>         req =3D supp_pop_req(supp, num_params, param, &num_meta)=
;
> > >>>>>> -       mutex_unlock(&supp->mutex);
> > >>>>>> -
> > >>>>>>         if (IS_ERR(req)) {
> > >>>>>> +               mutex_unlock(&supp->mutex);
> > >>>>>
> > >>>>> We need a way to tell the difference between an id not found and =
an id
> > >>>>> removed because of a killed requester.
> > >>>>> How about storing NULL for revoked requests instead of an err-poi=
nter?
> > >>>>>
> > >>>>
> > >>>> Not sure I'm following correctly. Are you expecting supp_pop_req()
> > >>>> to return NULL instead of an err-pointer when a request has been r=
evoked?
> > >>>
> > >>> I was looking at it again, and storing an err-pointer as you do in
> > >>> this patch has the advantage that we can tell whether the ID has be=
en
> > >>> revoked or was never supplied. In the latter case, it suggests that
> > >>> the supplicant is doing something wrong and might as well restart i=
n
> > >>> an attempt to recover. So, please keep using an err-pointer as a
> > >>> placeholder, but we must be able to distinguish a revoked request f=
rom
> > >>> other errors to make sure that the supplicant doesn't restart due t=
o a
> > >>> revoked request.
> > >>>
> > >>
> > >> Understood. What if I switch the stored err-pointer to EBADF instead=
 of ENOENT
> > >> (which seems more natural), so it doesn't overlap with other supp_po=
p_req() error
> > >> codes and the supplicant can reliably detect it.
> > >
> > > Any error returned by TEE_IOC_SUPPL_SEND (or TEE_IOC_SUPPL_RECV) will
> > > cause the tee-supplicant to exit. Even if we update it to ignore
> > > certain codes, we must also consider the installed base. There's not
> > > much tee-supplicant could do with this error, except logging it. But =
I
> > > don't think that is very useful either. Unless the tee-supplicant doe=
s
> > > anything wrong or if the device isn't working any longer, we shouldn'=
t
> > > return an error.
> > >
> >
> > The direction of data flow in optee_supp_send is from the supplicant to=
 optee,
> > so the only way I can return meaningful information back to the supplic=
ant is
> > through the return value. I suppose I could simply ignore the revoked r=
equest
> > and return success, but it might be useful for the supplicant to know a=
bout it
> > in case it needs to roll back something.
> >
> > At this point I'm out of ideas :). Do you have any suggestions on how I=
 can
> > inform the supplicant about a revoked request in optee_supp_send while =
returning
> > success return value?
>
> This became a bit harder than I first thought. At this point, to fix
> the possible use-after-free, we have two options:
> 1. Returning an error code: tee-supplicant will exit
> 2. Returning OK: worst case, tee-supplicant can leak memory
>
> During reboot, neither case is a problem. During normal operation,
> it's annoying if tee-supplicant exists, but you still need some
> privileges to kill the client. If we return an error, it's enough to
> update tee-supplicant to handle that error case, and we're done. The
> advantage is no added code to the kernel.
>
> I think we should do what you suggested and return an error. This will
> not happen during normal operation. We'll fix tee-supplicant to handle
> the return error properly. tee-supplicant doesn't care about what
> error code it gets. If there's an error in TEE_IOC_SUPPL_SEND, it
> knows that no one will receive whatever was sent, and cleanup is
> needed.
>
> Sumit and Jerome, what do you think?

Sounds good.

Thanks,
--=20
Jerome

>
> Cheers,
> Jens
