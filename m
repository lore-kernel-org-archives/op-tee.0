Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF17BFF885E
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 11:41:24 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DC3F344481
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 11:41:23 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XjdLpTyf;
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4846141B62
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 11:41:17 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b941762394aso1370146166b.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 04:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777290076; cv=none;
        d=google.com; s=arc-20240605;
        b=CDXrhrDLZTQVbaQbjeaf02xAJae/OwbgEbZUDOR1jpooo3iOFdnpEPOnkqFYHkGaeO
         lRtXE/q7wwcsHPLWF+T31LpEiHGxJ2DFZNPkjxzScBAgSGlnwfQNSQw8sId71IpWOT+U
         ZV/u5G+qoTsllmBNkZ84a+kcjkFicW1axjvd+65AcNGjcf98Vyu9wUY1u1bF14WtRzvs
         opnIR0L0P4V6c1PYwW2d24ow9VomhNNhSx5HFSYvsIjYLfG3TY/ZGGOXUKh8RXBFQADh
         xQSJAVYQ4I+4L1UNsbQm+qk7LSUJt9GmtQtBng4dJi1Qv4+GC4h8YHEZRDuxXol3GzsG
         kaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iY9GQ6SW6t/ZOmcGSE+LWGIlAvhxbOuQam/uuJbvUYk=;
        fh=We2IdVC2+Ni7mn1xZ6Wq8HvVsb8Gpuoh38z9TL3lhHM=;
        b=dlW5Wc38PhmoDF3H6JT5GURmqLrb+jBfUIexQqqdcxupherCPjBfz32/y2MYUQejCy
         44V3racSOnakVisnNmqk+sIcga3+z2gFt7XN01a43z99u9l2jVtgbnUaUNfShG1ZpBQA
         uMco+kR6vr6NRf6oWAWQP3ZVZ5PP0fR16l2mQO6QghkfxzFhYtge28TqbWYsKNZGLPSz
         Z0rrDG4xm5cmTDQCAx7McJ7g6Q5eXv14QF1XZ+zdgCrwZcSFH1YMUuD4KCuFoxREJCpi
         gMc6/ys9/plgSDf6lem7kpwVNz/TW2Yg8CKLCa8FlLOO00kr3RopdrOR0U4s8vpNCwXb
         cv5A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777290076; x=1777894876; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY9GQ6SW6t/ZOmcGSE+LWGIlAvhxbOuQam/uuJbvUYk=;
        b=XjdLpTyfIxvZz+VJPNL5nFTLlQ/clewC3wWOMYW9W3cYda/4z3cQPsuvu0KQr7PBsb
         9doYiX/MEYOo1qyrw6Eux2S4H9KIbBTl67cQtcl/ZJTGKbzUA2icrYWGYql0ONYVHmUf
         B97ZSCyjXZSL8/MDODz1RaxqriohiOlzL1qnrhi6yzsAsQqpgaIp7LOzY7DzvmltvYEv
         q8YKzmLWP8juwh/cT+rdm9SOeSrE+KX7u5MiSx0PWQ76cZOZ8ruLCXe37ysRZ/f70p6A
         f4b3s5Zck+sOM1Z5qQmF9+YUUw2yFvLC3OYiv7aR/49t902XQulzEOECNNMa+uBUjxjO
         JkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290076; x=1777894876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iY9GQ6SW6t/ZOmcGSE+LWGIlAvhxbOuQam/uuJbvUYk=;
        b=WrMjt2DF9c0uHT4xOs7vMgFHdvsAbh2YDQPYDFv0W2sfMLyut7kuzRwih3xSDTYtiz
         9F+XiTcCeUmA2iRr9CT9MEFp6mClStyCtKCe9ee8NSJZBef3LNHRbcGKDQnqFuy8XDk0
         A0ipnyfjoXy+CPpPvRHmEA6m/B04jp0D9wUgc52eAyuSk6P8KY/KJ6W4dcevrGDtZzyz
         trqS1LGvImKU9MJHJ9xVNvEPACjLEYT/DpKBJXPBoAFWBBiB+A5wIsZ0HKcP42BokLSS
         dFZMBPCkwX4JBIXvruLfFWnCSLOlDpFi75D0aoToafMMcOBYYMrw/o3d0Ly0W1DIkyn8
         o2aA==
X-Forwarded-Encrypted: i=1; AFNElJ9xIqCVFKkEIS67r8Nf8HYT4snpxd859iCXEBjDWKrBe3ouC7GOJyThSG3hBHmORC9h2E9XGi8=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Ywy4LV2H8gq8PgVA1GO7odWHLdyrU9v4pggfAS/z3tpt8T+/LfH
	jiCxmqRPcZsKmwNtWtgtxJCXer2/Q+bb83vngpk5zPmvoxSmH2XT9VwrpBDxWJi7iy1kEsjaEQG
	MpIDMXikUNjIUPs1KHL71xOwMkilayYS7PhDPaRuOUPNn
X-Gm-Gg: AeBDievRnDqCSaZTDJ8uN9EzEwTQhXK5kyEhPtAapjY/JmmDfCLGy0k9Ipx6jcqpaIA
	4rG527XCpbHR+WulQfbx3614jWPgzaRHE0tbPum8v7mZUh8kfGmaRpRo5RnNq0sSN91fHrq3UAV
	scTDdKFPzlEkiT80+ADUl3PrQ/BpfW9CydsroPiGs5bjxXb4FzMJ2rRF3jKBtOceOhxbxjcPEK6
	DDq12dwAvq4iyutzTZLPwqEAgtB/NkEMQfQvTrXxuTBrC0zJIRYKw/Y/E4/sc6SaPdepu7auvy+
	8iDXtwroFkWL+qkTIzhs+Vk9mSBebM3dnofC8ZmCc7VeS/Xg
X-Received: by 2002:a17:907:c002:b0:ba8:e7d5:6a7a with SMTP id
 a640c23a62f3a-ba8e7e4ae93mr1628539066b.40.1777290076003; Mon, 27 Apr 2026
 04:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20251204101730.1036671-1-arnd@kernel.org> <CAHUa44H1Ejbbuzr1hF1HrT69JGgnvfkkDkh+9KvEvBT+eWBDhw@mail.gmail.com>
 <0b061075-ab71-4ac1-93ec-438ddaaec903@oss.qualcomm.com> <aTbCqyOuprPOyU4X@sumit-X1>
 <2c0d09b7-0d8c-4bf2-a1bd-1dc4b58cd0a8@oss.qualcomm.com> <3aacf997-3a21-4e4b-b6bd-c55c36fb4c74@oss.qualcomm.com>
 <CAHUa44GO-D1YcQ_36pe-vQ83fB9rcOkny+M7a=CThAxWb6TLTQ@mail.gmail.com>
 <ba8554b7-499b-4fb8-b792-471d83cf3893@oss.qualcomm.com> <CAHUa44GaKGhDuNcMqn0c0UgK-CV3bHoUE_Q_X-0ZY+jNEs9ZcQ@mail.gmail.com>
In-Reply-To: <CAHUa44GaKGhDuNcMqn0c0UgK-CV3bHoUE_Q_X-0ZY+jNEs9ZcQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Apr 2026 13:41:01 +0200
X-Gm-Features: AVHnY4LqpVnmdMXbDD6cxcuJmHloWDSIDrfMnjtLJlqIAFhprhXXROKSuZO99EE
Message-ID: <CAHUa44GNiTeRoL_AUbge4DmCBVqpaeNEoqoWdTPrhiQDBjzOjw@mail.gmail.com>
Subject: Re: [PATCH] tee: fix tee_ioctl_object_invoke_arg padding
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.218.53:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[15];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.218.53:from];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4846141B62
X-Spamd-Bar: -----
Message-ID-Hash: OG3M3JABZLRH5HNEWEP6K5CGJA5D4UBR
X-Message-ID-Hash: OG3M3JABZLRH5HNEWEP6K5CGJA5D4UBR
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Sumit Garg <sumit.garg@oss.qualcomm.com>, Alexandre Ghiti <alex@ghiti.fr>, Etienne Carriere <etienne.carriere@foss.st.com>, Randy Dunlap <rdunlap@infradead.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OG3M3JABZLRH5HNEWEP6K5CGJA5D4UBR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Tue, Dec 16, 2025 at 2:17=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Tue, Dec 16, 2025 at 11:56=E2=80=AFAM Harshal Dev
> <harshal.dev@oss.qualcomm.com> wrote:
> >
> > Hi Jens,
> >
> > On 12/16/2025 1:18 PM, Jens Wiklander wrote:
> > > Hi,
> > >
> > > On Tue, Dec 9, 2025 at 4:54=E2=80=AFAM Amirreza Zarrabi
> > > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> > >>
> > >> Hi,
> > >>
> > >> On 12/8/2025 11:54 PM, Harshal Dev wrote:
> > >>>
> > >>>
> > >>> On 12/8/2025 5:50 PM, Sumit Garg via OP-TEE wrote:
> > >>>> On Mon, Dec 08, 2025 at 04:24:17PM +1100, Amirreza Zarrabi wrote:
> > >>>>> Hi,
> > >>>>>
> > >>>>> On 12/5/2025 12:27 AM, Jens Wiklander wrote:
> > >>>>>> Hi,
> > >>>>>>
> > >>>>>> On Thu, Dec 4, 2025 at 11:17=E2=80=AFAM Arnd Bergmann <arnd@kern=
el.org> wrote:
> > >>>>>>>
> > >>>>>>> From: Arnd Bergmann <arnd@arndb.de>
> > >>>>>>>
> > >>>>>>> The tee_ioctl_object_invoke_arg structure has padding on some
> > >>>>>>> architectures but not on x86-32 and a few others:
> > >>>>>>>
> > >>>>>>> include/linux/tee.h:474:32: error: padding struct to align 'par=
ams' [-Werror=3Dpadded]
> > >>>>>>>
> > >>>>>>> I expect that all current users of this are on architectures th=
at do
> > >>>>>>> have implicit padding here (arm64, arm, x86, riscv), so make th=
e padding
> > >>>>>>> explicit in order to avoid surprises if this later gets used el=
sewhere.
> > >>>>>>>
> > >>>>>>> Fixes: d5b8b0fa1775 ("tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF=
")
> > >>>>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >>>>>>> ---
> > >>>>>>> The new interface showed up in 6.18, but I only came across thi=
s after
> > >>>>>>> that was released. Changing it now is technically an ABI change=
 on
> > >>>>>>> architectures with unusual padding rules, so please consider ca=
refully
> > >>>>>>> whether we want to do it this way or not.
> > >>>>>>>
> > >>>>>>> Working around the ABI differences without an ABI change is pos=
sible,
> > >>>>>>> but adds a lot of complexity for compat handling.
> > >>>>>>
> > >>>>>> This is currently only used by the recently introduced qcomtee b=
ackend
> > >>>>>> driver. So it's only used on a few arm64 Qualcomm platforms righ=
t now.
> > >>>>>>
> > >>>>>> I think we should take this patch, but let's hear what others th=
ink.
> > >>>>
> > >>>> Yeah since it's not an ABI issue on arm64 platforms where QTEE run=
s, so:
> > >>>>
> > >>>> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > >>>>
> > >>>>>>
> > >>>>>> Thanks,
> > >>>>>> Jens
> > >>>>>>
> > >>>>>
> > >>>>> I agree. We should take this patch. As noted, there are not many
> > >>>>> clients relying on it yet, so updating the userspace should
> > >>>>> be straightforward.
> > >>>>
> > >>>> You should rather test without any userspace library update to tes=
t it's
> > >>>> not an ABI issue. Just for correctness sake, you can update the li=
brary
> > >>>> too.
> > >>>>
> > >>>
> > >>> I'll take the time to test it at some point this week both with and=
 without updating
> > >>> the library ABI.
> > >>>
> > >>
> > >> Summit, that was the plan from the beginning, that's why I did not a=
dd "Reviewed-by:"
> > >> in the first place. Thanks Harshal for volunteering.
> > >
> > > Are we good with this patch now?
> > >
> >
> > Yes, this is good from our side.
> >
> > Tested-by: Harshal Dev <harshal.dev@oss.qualcomm.com>
>
> Good, thank you, Harshal.
>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> Arnd, what do you prefer, taking this directly or should I send it in
> a pull request?

I forgot about this. I'm picking up this.

Cheers,
Jens
