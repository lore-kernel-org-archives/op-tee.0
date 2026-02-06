Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35027EB28F4
	for <op-tee@archiver.kernel.org>; Fri,  6 Feb 2026 08:54:45 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 69B0143711
	for <op-tee@archiver.kernel.org>; Fri,  6 Feb 2026 08:54:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lNchLmpt;
	dkim-atps=neutral
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 33EDD41B41
	for <op-tee@lists.trustedfirmware.org>; Fri,  6 Feb 2026 08:54:25 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45f194e9a98so623684b6e.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 06 Feb 2026 00:54:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770368064; cv=none;
        d=google.com; s=arc-20240605;
        b=A+8sDPHQ6A6ncLHTAihkm18H6EpHIpqU+7eEIdungIsGvFTG18U/TWxWlfdKrI3caS
         xhWN8o0eu7VrF3G4TyHwO7wp69vIvTKl2dg39EUKvlcXBmMq6vZ43LSTLfL86WKkJld0
         +Zl6G9t/ffqRxdPol3aKJtWBRcSD3TvwBjvTfVIpj+p7erqOmo5MDa1UwJ+d0qsiqhSr
         aIjrf3ZneFWm91aMlEAuyt4Zz9UYHGFfEpoxGo5OQt5zsxkbRh2G2wCNQjy85H2RasY4
         yABagiRYxEuXSxlDvJrcXizkRlCLbq6Vj8d3/GOAei/bj9pLdCUNCQiMBYfUUhYffWrT
         hNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9DJtIDUEGNrEq8AlmzBB0bLgfpDOb+/qA8Qqcio5/DA=;
        fh=ypw36V1AfZjIMAPHreJQZJEjRhMuDoEqYnot/4eNvF4=;
        b=Z8DTSGuOadEMtPah6x8M16LgfCU7linZ7PS2kCMaQGk5CNLbmXS1SousWtlvFpCQbU
         gHm8XxAfe5/COlHn+HBzMSrbWdrBtx9kQrvWkQSarWoIPXDa5X4r1R/3g4xpOhEV9hXA
         DGGBiO/oCDiguY9xIl60o+x+dB5TqCbHSUgcue7HLuo+qydq53k6wDs7zdUhUzZmGqsI
         X6xD9S5gYKRaxiZq7XurWOHGSFZvOnSZj2gtUHVebL4COO25eWYkMaZB2OYJffPHGqv5
         utROsx8YygRZVDuvz0mljRNvPaDLVgCYA/mxDXzPcDX+mHCl6N5A1XHjVXkWSp7kRMfq
         e/6w==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770368064; x=1770972864; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DJtIDUEGNrEq8AlmzBB0bLgfpDOb+/qA8Qqcio5/DA=;
        b=lNchLmpt/jfjJUy4upbEkuhgZIUNqgE8bFWoPS8olb9ljm7k34gR55nwbpcSjBR3oM
         ZqjnIzkH3Hi4L804Dn86+tXMUT9n2t9IZ00JJMLQ4YKm1n/KxZl55g8RgCUosh10EFSA
         rKWVSSaFVbGP7A5OP/GtebKPV3Gliis6iq2wRazLTYnfm/bv1LvMLgpHFsOKbJqUeaGa
         7Eo20fazZdTDLsM7XvTbe0QLVjOLup8PbwDV9O0sGDmpbE+4Hkhuq3d711B4YwlNCOgs
         QoAobW1xMBnx2VxSOJcYWdkmWv4s+Ji5R9uswtnA7w6+dUrjNsRwND448wX2O09qy1Oh
         7WDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770368064; x=1770972864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9DJtIDUEGNrEq8AlmzBB0bLgfpDOb+/qA8Qqcio5/DA=;
        b=D31OJkb7GNbG2xU5o3XZC9Uvi3ZdMviLJNOT71vYn8qRgr8KTLDDjHOp4CbGkfj+qy
         UT2q0RQkfakZ2XfFko8+QUR2WDmR6PW1uPWo/ZGIloHBR56YvXu+rJ0o+yPxhR3sfQXA
         X1JT9i8aTR/5zrEe/KqRtIWO1AOuEdiOp20y+kS/Jjy2V9eThxYgWUPlpCC5eTIOXtkf
         2pjJwQaSJAHykqSsnRDTrAdINHjr6bi/wV2ExgfKvvHctToUszQeMdj/r4cCnn0TH3qY
         szCby2hY+sJegoJfRu0LjJ3V95LjS8YqRoqII5HW/93wGhsLzSbZi0TxHeWTyOL1Pc8y
         H/yA==
X-Forwarded-Encrypted: i=1; AJvYcCXeE115kKCfar0dkHCbGsA4smHNu5BHI+wcmqef/m/P41vLqWusG4f5CWjmNvFqLMBl+cB28tU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyF330LXxZsj0HuVPVuz1GBkNVQFmRNSCRCTN6rK0q/ESKrYOtV
	HSqjLaIoKocePd8rRAVW9WN4uNRg6RYbM29bs6dBajihq29CxLb0n92WmcDP/jZW0Hc4e8imRZW
	W4+9Z26iGnrXYFoso1zikixQMoSwbmyZg1F/UGY+ASL3j
X-Gm-Gg: AZuq6aKBh5djTqTQWLknmIMQV3p7HaPWEU1c+wbF1REdnWX+CR9rB2TjoKTNbxeS0mN
	++VX05lsEduS+69P1toPOWIAgwRrnRZPjUlbPm34Bnn9Pc7skG7XkpVEpzl3Ylj8dMMW3MwRaKS
	7KE9ToEGutS67hFFC9Q7h2hls4PGlkoJNqPFtIlvPVwYGDO/oqGBAUJOkQxtFR6HF3V9Te/RmSs
	ha0pYv+fYVELUyu028GFfIa35lOtKgfkKKOF0DSi9AOegrjjEVplYOxMwWzOFi9pmYqkKrCOjBW
	9hKEDbo7+71T9UeqTJc3Y67HH+QVu3GbySpt
X-Received: by 2002:a05:6808:1b07:b0:45f:bcc:8e05 with SMTP id
 5614622812f47-462fca5d17cmr1173039b6e.30.1770368064303; Fri, 06 Feb 2026
 00:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20260128-fix-use-after-free-v3-1-b0786670d927@oss.qualcomm.com>
 <CAHUa44E4Htg9zEMY9XtkMsPRJq+13mq6kSd8RUznHTRvXVXKVQ@mail.gmail.com>
 <55546b03-cbe6-40dd-b794-b2e81efde33a@oss.qualcomm.com> <CAHUa44FfowG=GpgLcq=sp_TqRArJtf0_V-tsJY11HH+FEA6u+w@mail.gmail.com>
 <4c9e4f5f-e0f3-42aa-852f-064f4024af26@oss.qualcomm.com> <CAHUa44EhaztJ+5piu0c-HQbqZFX47uLPJ+VDRp=Bp6BMeeARAQ@mail.gmail.com>
 <b8086bfb-f240-4115-9ab0-18509775932a@oss.qualcomm.com>
In-Reply-To: <b8086bfb-f240-4115-9ab0-18509775932a@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 6 Feb 2026 09:54:12 +0100
X-Gm-Features: AZwV_QgdxhDE0N5aO3VLshGqQtUq6DLJKHqdZXnXy_iVActddXjXNWnDBO0uofw
Message-ID: <CAHUa44GhTy=TWAuG7JY_6jjWG-uCGnLyZRn1JhGWgaWt28cH7w@mail.gmail.com>
Subject: Re: [PATCH v3] tee: optee: prevent use-after-free when the client
 exits before the supplicant
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.182:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.182:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 33EDD41B41
X-Spamd-Bar: ----
Message-ID-Hash: 5GIZWPVKCAQLF2FXDTY62X7GZNWY244C
X-Message-ID-Hash: 5GIZWPVKCAQLF2FXDTY62X7GZNWY244C
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Michael Wu <michael@allwinnertech.com>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/5GIZWPVKCAQLF2FXDTY62X7GZNWY244C/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Thu, Feb 5, 2026 at 3:13=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> On 2/4/2026 6:46 PM, Jens Wiklander wrote:
> > Hi Amir,
> >
> > On Tue, Feb 3, 2026 at 11:56=E2=80=AFPM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Hi Jens,
> >>
> >> On 2/3/2026 5:59 PM, Jens Wiklander wrote:
> >>> Hi,
> >>>
> >>> On Tue, Feb 3, 2026 at 3:09=E2=80=AFAM Amirreza Zarrabi
> >>> <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>>>
> >>>> Hi Jens,
> >>>>
> >>>> On 2/2/2026 10:36 PM, Jens Wiklander wrote:
> >>>>> Hi Amir,
> >>>>>
> >>>>> On Thu, Jan 29, 2026 at 4:22=E2=80=AFAM Amirreza Zarrabi
> >>>>> <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>>>>>
> >>>>>> Commit 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop") made =
the
> >>>>>> client wait as killable so it can be interrupted during shutdown o=
r
> >>>>>> after a supplicant crash. This changes the original lifetime expec=
tations:
> >>>>>> the client task can now terminate while the supplicant is still pr=
ocessing
> >>>>>> its request.
> >>>>>>
> >>>>>> If the client exits first it removes the request from its queue an=
d
> >>>>>> kfree()s it, while the request ID remains in supp->idr. A subseque=
nt
> >>>>>> lookup on the supplicant path then dereferences freed memory, lead=
ing to
> >>>>>> a use-after-free.
> >>>>>>
> >>>>>> Serialise access to the request with supp->mutex:
> >>>>>>
> >>>>>>   * Hold supp->mutex in optee_supp_recv() and optee_supp_send() wh=
ile
> >>>>>>     looking up and touching the request.
> >>>>>>   * Let optee_supp_thrd_req() notice that the client has terminate=
d and
> >>>>>>     signal optee_supp_send() accordingly.
> >>>>>>
> >>>>>> With these changes the request cannot be freed while the supplican=
t still
> >>>>>> has a reference, eliminating the race.
> >>>>>>
> >>>>>> Fixes: 70b0d6b0a199 ("tee: optee: Fix supplicant wait loop")
> >>>>>> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com=
>
> >>>>>> ---
> >>>>>> Changes in v3:
> >>>>>> - Introduce processed flag instead of -1 for req->id.
> >>>>>> - Update optee_supp_release() as reported by Michael Wu.
> >>>>>> - Use mutex instead of guard.
> >>>>>> - Link to v2: https://lore.kernel.org/r/20250617-fix-use-after-fre=
e-v2-1-1fbfafec5917@oss.qualcomm.com
> >>>>>>
> >>>>>> Changes in v2:
> >>>>>> - Replace the static variable with a sentinel value.
> >>>>>> - Fix the issue with returning the popped request to the supplican=
t.
> >>>>>> - Link to v1: https://lore.kernel.org/r/20250605-fix-use-after-fre=
e-v1-1-a70d23bff248@oss.qualcomm.com
> >>>>>> ---
> >>>>>>  drivers/tee/optee/supp.c | 122 +++++++++++++++++++++++++++++++++-=
-------------
> >>>>>>  1 file changed, 86 insertions(+), 36 deletions(-)
> >>>>>
[snip]


> >>>>>> @@ -328,9 +378,8 @@ int optee_supp_send(struct tee_context *ctx, u=
32 ret, u32 num_params,
> >>>>>>
> >>>>>>         mutex_lock(&supp->mutex);
> >>>>>>         req =3D supp_pop_req(supp, num_params, param, &num_meta);
> >>>>>> -       mutex_unlock(&supp->mutex);
> >>>>>> -
> >>>>>>         if (IS_ERR(req)) {
> >>>>>> +               mutex_unlock(&supp->mutex);
> >>>>>
> >>>>> We need a way to tell the difference between an id not found and an=
 id
> >>>>> removed because of a killed requester.
> >>>>> How about storing NULL for revoked requests instead of an err-point=
er?
> >>>>>
> >>>>
> >>>> Not sure I'm following correctly. Are you expecting supp_pop_req()
> >>>> to return NULL instead of an err-pointer when a request has been rev=
oked?
> >>>
> >>> I was looking at it again, and storing an err-pointer as you do in
> >>> this patch has the advantage that we can tell whether the ID has been
> >>> revoked or was never supplied. In the latter case, it suggests that
> >>> the supplicant is doing something wrong and might as well restart in
> >>> an attempt to recover. So, please keep using an err-pointer as a
> >>> placeholder, but we must be able to distinguish a revoked request fro=
m
> >>> other errors to make sure that the supplicant doesn't restart due to =
a
> >>> revoked request.
> >>>
> >>
> >> Understood. What if I switch the stored err-pointer to EBADF instead o=
f ENOENT
> >> (which seems more natural), so it doesn't overlap with other supp_pop_=
req() error
> >> codes and the supplicant can reliably detect it.
> >
> > Any error returned by TEE_IOC_SUPPL_SEND (or TEE_IOC_SUPPL_RECV) will
> > cause the tee-supplicant to exit. Even if we update it to ignore
> > certain codes, we must also consider the installed base. There's not
> > much tee-supplicant could do with this error, except logging it. But I
> > don't think that is very useful either. Unless the tee-supplicant does
> > anything wrong or if the device isn't working any longer, we shouldn't
> > return an error.
> >
>
> The direction of data flow in optee_supp_send is from the supplicant to o=
ptee,
> so the only way I can return meaningful information back to the supplican=
t is
> through the return value. I suppose I could simply ignore the revoked req=
uest
> and return success, but it might be useful for the supplicant to know abo=
ut it
> in case it needs to roll back something.
>
> At this point I'm out of ideas :). Do you have any suggestions on how I c=
an
> inform the supplicant about a revoked request in optee_supp_send while re=
turning
> success return value?

This became a bit harder than I first thought. At this point, to fix
the possible use-after-free, we have two options:
1. Returning an error code: tee-supplicant will exit
2. Returning OK: worst case, tee-supplicant can leak memory

During reboot, neither case is a problem. During normal operation,
it's annoying if tee-supplicant exists, but you still need some
privileges to kill the client. If we return an error, it's enough to
update tee-supplicant to handle that error case, and we're done. The
advantage is no added code to the kernel.

I think we should do what you suggested and return an error. This will
not happen during normal operation. We'll fix tee-supplicant to handle
the return error properly. tee-supplicant doesn't care about what
error code it gets. If there's an error in TEE_IOC_SUPPL_SEND, it
knows that no one will receive whatever was sent, and cleanup is
needed.

Sumit and Jerome, what do you think?

Cheers,
Jens
