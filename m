Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4945AD5E14C
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 13:18:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 742FA4FEDA
	for <op-tee@archiver.kernel.org>; Tue, 16 Dec 2025 13:18:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Wlc4TJCc;
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 9BB0B43079
	for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 13:17:50 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c7660192b0so3272925a34.0
        for <op-tee@lists.trustedfirmware.org>; Tue, 16 Dec 2025 05:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765891070; x=1766495870; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5Nc5kSjeLOYF1kQP3EhPUJ3irJVYIWAj/CpkVkXlqs=;
        b=Wlc4TJCc+h8D/NjaM9Rg+Mvs6xGvsO0h2iKloh6Tkw1ucTPqx7QU+Baju8Az5Uqr8J
         T4z+EMLRc4VjU8JdapWUTqNIwdXdE1zBErnp8zhya3MY4ZRW4RgPUDYwU+SXFACsMN7e
         A3e6nraa71kL3b1e9KeU/xb1sq/1qJ1Kg6zQFl1ZGBEfqKAiOfdPA7X8foiQnb6Lp2QE
         rZ5t2Kqcnv5yf7oRfxHO1bpuTSL3LSI4iWgheK14fOoTOMr50HKuaNMC2pH2L/y1i5T3
         mnyyKGC01h0lyHmskTV6wlD3oR2D9yrMwvtbvSBd2lt3i/1cA9jZjLEd1YxEh6swrK6X
         PkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891070; x=1766495870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M5Nc5kSjeLOYF1kQP3EhPUJ3irJVYIWAj/CpkVkXlqs=;
        b=Ga+bDvSyNrVCXA21hi9G8r/Dv6wVCLTYSFEvqGA8U4ltyLZBgv7WsIIJy88y457R+P
         P/UtkoqoEDS0fMnVQnu1LQbFMYyosW53CDgXOcLtwFu5zJWYtkbd6kX7R0YMuyWix2aw
         Jt9vK7Ok0VQhMx65+lCFKrpSl6FCTAmMjw2Vd2T5U4MlLmc6MVZ6cf7KyObMbWkSfgWO
         WjrgTLZQcjKK78iSfCJsQ5iudU+8k+pMfai+qHSPc3Tz5q1Zp4TTWFWIlIjvwdmIvvKr
         RdFrPp3zMdP3Jqzw4NpZZP+zlNIikvnvGspjaQu2c9w9A7mc/NWqTJ0phsCtVUNxRSZh
         3o+A==
X-Forwarded-Encrypted: i=1; AJvYcCUGUQby4oiN89eTa0TBQMnnb8lPQUQg7eaGGR6ICFovgtJHlXpdd1X2aWYnOt2ykRGj9eiM31E=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywv5W3zY4amk7LE+a+dFT8+bKK5tX7tkZFEJD/zrqktyzkdgZbE
	7Muc5WbO0F3suTUjoaF4Ktl1ENY2DF7df5kRSYmXW7l2aqmOpH2hdQdKcHHNJX0X8ywjRmsF485
	DFvEDH5QbNjXXnCQjo7iisRF4NsxE/EX6pW0THDim+H3e
X-Gm-Gg: AY/fxX7EI3CJklykOwau96x5jWb3iiPwAUVCmrdH6i3e3wEh6hTb5jpwpPnCCJY2eSO
	cBIl4m/7U/cn5FvOQsa7FmRa7/halkx7cyEwJJDSDA3+V9g06OxjL3BPmmiNYQdSsCVRyjF3oz9
	bDe0h0a+vgc+fa1qwBI7D9VOx9c48gALpcf5qv0+PdfHN2bKIOpQjYSM2TKUL2nthsleXtKzFQY
	B9bDx4JiNXfR5NZbW4sdV6QB2DDdXMwrejOg2qc0ZSgqcTNbLj9o4i8aaneeEsSX0zI7yL1hxLK
	zAfs9gXnkdo3KBhYBEI6ZKB2fiafUc6kjFgl
X-Google-Smtp-Source: AGHT+IH8VEaZzqh5zZTcB8vKsSC66JepkEuL2a9J2zyEGbF3ADaE18eZgFTcRxc8CGjXDE5KvbwfgmqDaqUUUAD3soA=
X-Received: by 2002:a05:6820:2214:b0:659:9a49:8fbe with SMTP id
 006d021491bc7-65b452848f3mr6608510eaf.55.1765891069683; Tue, 16 Dec 2025
 05:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20251204101730.1036671-1-arnd@kernel.org> <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com> <aTbCqyOuprPOyU4X@sumit-X1>
 <2c0d09b7-0d8c-4bf2-a1bd-1dc4b58cd0a8@oss.qualcomm.com> <3aacf997-3a21-4e4b-b6bd-c55c36fb4c74@oss.qualcomm.com>
 <CAHUa44GO-D1YcQ_36pe-vQ83fB9rcOkny+M7a=CThAxWb6TLTQ@mail.gmail.com> <ba8554b7-499b-4fb8-b792-471d83cf3893@oss.qualcomm.com>
In-Reply-To: <ba8554b7-499b-4fb8-b792-471d83cf3893@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 16 Dec 2025 14:17:37 +0100
X-Gm-Features: AQt7F2rzrn2reenZ61zHb0RF-mtpsW8kdfOWWvyd1ydaz_86tS9Y4U3dPNZzna4
Message-ID: <CAHUa44GaKGhDuNcMqn0c0UgK-CV3bHoUE_Q_X-0ZY+jNEs9ZcQ@mail.gmail.com>
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.44:from];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.44:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 9BB0B43079
X-Spamd-Bar: ----
Message-ID-Hash: NF3H23KBZ4ZFR5UL4GLWXAELWPFCYYGD
X-Message-ID-Hash: NF3H23KBZ4ZFR5UL4GLWXAELWPFCYYGD
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/NF3H23KBZ4ZFR5UL4GLWXAELWPFCYYGD/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Tue, Dec 16, 2025 at 11:56=E2=80=AFAM Harshal Dev
<harshal.dev@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> On 12/16/2025 1:18 PM, Jens Wiklander wrote:
> > Hi,
> >
> > On Tue, Dec 9, 2025 at 4:54=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/8/2025 11:54 PM, Harshal Dev wrote:
> >>>
> >>>
> >>> On 12/8/2025 5:50 PM, Sumit Garg via OP-TEE wrote:
> >>>> On Mon, Dec 08, 2025 at 04:24:17PM +1100, Amirreza Zarrabi wrote:
> >>>>> Hi,
> >>>>>
> >>>>> On 12/5/2025 12:27 AM, Jens Wiklander wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> On Thu, Dec 4, 2025 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@kernel=
.org> wrote:
> >>>>>>>
> >>>>>>> From: Arnd Bergmann <arnd@arndb.de>
> >>>>>>>
> >>>>>>> The tee_ioctl_object_invoke_arg structure has padding on some
> >>>>>>> architectures but not on x86-32 and a few others:
> >>>>>>>
> >>>>>>> include/linux/tee.h:474:32: error: padding struct to align 'param=
s' [-Werror=3Dpadded]
> >>>>>>>
> >>>>>>> I expect that all current users of this are on architectures that=
 do
> >>>>>>> have implicit padding here (arm64, arm, x86, riscv), so make the =
padding
> >>>>>>> explicit in order to avoid surprises if this later gets used else=
where.
> >>>>>>>
> >>>>>>> Fixes: d5b8b0fa1775 ("tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF")
> >>>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >>>>>>> ---
> >>>>>>> The new interface showed up in 6.18, but I only came across this =
after
> >>>>>>> that was released. Changing it now is technically an ABI change o=
n
> >>>>>>> architectures with unusual padding rules, so please consider care=
fully
> >>>>>>> whether we want to do it this way or not.
> >>>>>>>
> >>>>>>> Working around the ABI differences without an ABI change is possi=
ble,
> >>>>>>> but adds a lot of complexity for compat handling.
> >>>>>>
> >>>>>> This is currently only used by the recently introduced qcomtee bac=
kend
> >>>>>> driver. So it's only used on a few arm64 Qualcomm platforms right =
now.
> >>>>>>
> >>>>>> I think we should take this patch, but let's hear what others thin=
k.
> >>>>
> >>>> Yeah since it's not an ABI issue on arm64 platforms where QTEE runs,=
 so:
> >>>>
> >>>> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> >>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Jens
> >>>>>>
> >>>>>
> >>>>> I agree. We should take this patch. As noted, there are not many
> >>>>> clients relying on it yet, so updating the userspace should
> >>>>> be straightforward.
> >>>>
> >>>> You should rather test without any userspace library update to test =
it's
> >>>> not an ABI issue. Just for correctness sake, you can update the libr=
ary
> >>>> too.
> >>>>
> >>>
> >>> I'll take the time to test it at some point this week both with and w=
ithout updating
> >>> the library ABI.
> >>>
> >>
> >> Summit, that was the plan from the beginning, that's why I did not add=
 "Reviewed-by:"
> >> in the first place. Thanks Harshal for volunteering.
> >
> > Are we good with this patch now?
> >
>
> Yes, this is good from our side.
>
> Tested-by: Harshal Dev <harshal.dev@oss.qualcomm.com>

Good, thank you, Harshal.

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Arnd, what do you prefer, taking this directly or should I send it in
a pull request?

Cheers,
Jens
