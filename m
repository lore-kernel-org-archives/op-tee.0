Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE36C83F03
	for <op-tee@archiver.kernel.org>; Wed,  9 Jul 2025 07:24:37 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id B0AAB4543E
	for <op-tee@archiver.kernel.org>; Wed,  9 Jul 2025 07:24:36 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x97E27R4;
	dkim-atps=neutral
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id E095D41AA4
	for <op-tee@lists.trustedfirmware.org>; Wed,  9 Jul 2025 07:24:12 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-40b54ee16ddso3246891b6e.1
        for <op-tee@lists.trustedfirmware.org>; Wed, 09 Jul 2025 00:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752045852; x=1752650652; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG3lxc+QnWzhuwqAa/ZfhTMmcMLMhJzw3wQW5Eo5GuU=;
        b=x97E27R4TKYiBhfrPaEET4rQEjX0/5rn7+HGiE65rkoa8xHEhv5VfLpps8ix27K3sy
         edZdSMHWwvFATyTLwrYqDqppo2f6iP3X303+Rvj2swfSSLQWcmS+1cse/OM6FC8t0iO+
         jOgbSdDvip55hwu/Ho6UlHzIslrCmvvbkp7hHIf415AbmTzrLzZI3fCvF+fTRlwcKI0Y
         lPxh/M+euuCNXz/Hmo+UJBJkl0sHHaVo+yfinNs9P9Xkr/P1jC4yhBbvYXpMZwJ5eRid
         44FEkPe6aDomiZ9euLcQ6JheHoErw2YuIjBhYBaty+bH+HeQm3a4B2H5dfpoMz1xq4iB
         CtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752045852; x=1752650652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG3lxc+QnWzhuwqAa/ZfhTMmcMLMhJzw3wQW5Eo5GuU=;
        b=GDt+jekqO5dpw5qEWbcyxsvHuUoE01PiJc7a35D4AQBVmZxUaTUEGgL4peJw8Wv996
         92xvqSeKw82srodi1B1+6WwhFdexqVZYvls1lElMQGC22fGUoR6j2mgLhTyEEJdEJqDt
         B9cMkBZ/vID2RlqS/MHBDSzS9AQyMiX28KDzIZxmVMB9umdO9es99QIToFkXnJCnmJJT
         CxkYo+mwM2qvapRSb6TD+D2Z8V8FF6cRx9sOMgsTQ7F7sAP6jq94klWZMVtGLxY0twBN
         U8xx+MCKP1Qpd/MFIEI44f307Ivah7KPPhKVjjdHbC1hPsv/3t0lJ6o2zCECDrXR6CF8
         4HEw==
X-Gm-Message-State: AOJu0YxSJB0H81gshzcBg/s6wA2K2Pd/tqKewpBz2L/LLd5mDzrSmUsg
	UlkDprNMIl+9pCjhDy9fx7dtqzXhHe8KSbHUkFVvkt29AeUSazoJDpW+ppfiWjizPH5muNA0LIX
	aotfDc+ACO6UDHj7Co5sa8hfyxPIlBg2I6QOVgj7stg8/
X-Gm-Gg: ASbGnctIzDuEIw7unrugua41YzoHdJ84HghA/0jez0swUHBIGLYLz27KVy7HJgHpgQ4
	grjLS2Zbqvi8rVeck4qAu6PT0b6sYo/ifuK45byrCACmtOww5+g81p/wCtLMIkVJu3gVODH22fh
	PCtsgRU0ULrJOH0tWat57PsRJJzUIh1sep/CFBgzzHI2yN
X-Google-Smtp-Source: AGHT+IGB5w25Pl7NBSk6ze7tK6Y58U3LlRLCsUFSE9tqqLvXtQw9c7YNAm+5JxRG4hvAqwTKjWESfj85jmqWBtcJqsY=
X-Received: by 2002:a05:6808:1b25:b0:406:7af5:30f2 with SMTP id
 5614622812f47-412bd4baa90mr819680b6e.34.1752045851929; Wed, 09 Jul 2025
 00:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org> <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
 <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com>
 <99b4bc49-ce87-4340-a1ec-fd74499f5c73@oss.qualcomm.com> <73a7e179-7378-46a7-b1d2-62b760697666@oss.qualcomm.com>
In-Reply-To: <73a7e179-7378-46a7-b1d2-62b760697666@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 9 Jul 2025 09:24:00 +0200
X-Gm-Features: Ac12FXxkgAcpoFkqaCwBdNVix3zRDQmLqZtdYucK85Nlk1U-zsgFLowH9RWmwBg
Message-ID: <CAHUa44H2szNH4hzRHbeGDQYf7SGj63-2zKjVy7GCXiDS8OvN0w@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: E095D41AA4
X-Spamd-Bar: --
X-Spamd-Result: default: False [-2.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	RBL_SENDERSCORE_REPUT_7(0.50)[209.85.167.171:from];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linaro.org,none];
	R_SPF_ALLOW(0.00)[+ip4:209.85.128.0/17];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.167.171:from];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.167.171:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	R_DKIM_ALLOW(0.00)[linaro.org:s=google];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: RKAE3W3CO66JQFIFFDK7ZN3AIPDAC2I3
X-Message-ID-Hash: RKAE3W3CO66JQFIFFDK7ZN3AIPDAC2I3
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RKAE3W3CO66JQFIFFDK7ZN3AIPDAC2I3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Wed, Jul 9, 2025 at 6:46=E2=80=AFAM Amirreza Zarrabi via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi Jens,
>
> Sorry for multiple replies.
>
> On 7/9/2025 10:40 AM, Amirreza Zarrabi via OP-TEE wrote:
> > Hi Jens,
> >
> > On 7/7/2025 9:22 PM, Jens Wiklander wrote:
> >> Hi Amir,
> >>
> >> On Mon, Jul 7, 2025 at 4:22=E2=80=AFAM Amirreza Zarrabi via OP-TEE
> >> <op-tee@lists.trustedfirmware.org> wrote:
> >>>
> >>> Hi Jens,
> >>>
> >>> On 6/10/2025 11:13 PM, Jens Wiklander wrote:
> >>>> Implement DMA heap for protected DMA-buf allocation in the TEE
> >>>> subsystem.
> >>>>
> >>>> Protected memory refers to memory buffers behind a hardware enforced
> >>>> firewall. It is not accessible to the kernel during normal circumsta=
nces
> >>>> but rather only accessible to certain hardware IPs or CPUs executing=
 in
> >>>> higher or differently privileged mode than the kernel itself. This
> >>>> interface allows to allocate and manage such protected memory buffer=
s
> >>>> via interaction with a TEE implementation.
> >>>>
> >>>> The protected memory is allocated for a specific use-case, like Secu=
re
> >>>> Video Playback, Trusted UI, or Secure Video Recording where certain
> >>>> hardware devices can access the memory.
> >>>>
> >>>> The DMA-heaps are enabled explicitly by the TEE backend driver. The =
TEE
> >>>> backend drivers needs to implement protected memory pool to manage t=
he
> >>>> protected memory.
> >>>>
> >>>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >>>> ---
> >>>>  drivers/tee/Kconfig       |   5 +
> >>>>  drivers/tee/Makefile      |   1 +
> >>>>  drivers/tee/tee_heap.c    | 472 +++++++++++++++++++++++++++++++++++=
+++
> >>>>  drivers/tee/tee_private.h |   6 +
> >>>>  include/linux/tee_core.h  |  65 ++++++
> >>>>  5 files changed, 549 insertions(+)
> >>>>  create mode 100644 drivers/tee/tee_heap.c
> >>>>
> >> [snip]
> >>>
> >>> I'm having a bit of trouble understanding the rationale behind
> >>> supporting tee_device_unregister_all_dma_heaps(). Considering that
> >>> the heap remains accessible from userspace, wouldn't this lead
> >>> to undefined behavior? For example, what happens if a user is
> >>> in the middle of a tee_dma_heap_alloc() -- specifically before
> >>> tee_device_get() -- while the backend calls tee_device_unregister_all=
_dma_heaps()?
> >>
> >> That can't happen since tee_device_unregister() has been called
> >> before, guaranteeing that no further calls to tee_device_get() can
> >> succeed.
> >>
> >
> > The issue lies with tee_device_unregister(). After it returns,
> > teedev is released (I don't see get_device() anywhere), yet the dma hea=
p
> > is still holding a reference to it. I believe it could cause null deref=
.
> >
>
> After reviewing it again, you're right -- I didn=E2=80=99t notice that te=
edev
> is being read from h->teedev. However, since h->teedev could be null,
> we should still check for null before calling tee_device_get().

Yes, you're right.

>
> >>>
> >>> I understand that you want to use teedev refcount to protect against
> >>> the TEE driver unbinding if there is a buffer allocated. But what abo=
ut
> >>> the heap device?
> >>>
> >>> Additionally, what if the user decides to unbind the TEE backend driv=
er?
> >>> Would the dma_heap device still persist without any alloc function?
> >>
> >> Yes, the device would still be there, but alloc would return -EINVAL
> >> until a new heap has been registered.
> >
> > That=E2=80=99s only valid if the back-end is built-in. What happens if =
it=E2=80=99s
> > a module and gets removed? In that case, the alloc function isn=E2=80=
=99t present
> > to return -EINVAL. Perhaps using module_get() for each dma heap could
> > be a workaround for now?
> >
>
> This point remains valid: if we're using the dma heap, we should either
> use module_get() or make the driver built-in.

Correct, I prefer module_get() since we can then keep it as a module.

>
> Regards,
> Amir
>
> >> But I think you're on to something, we should perhaps increase the TEE
> >> module refcount when calling dma_heap_add(). Do you agree?
> >>
> >
> > Since the lifetime of the dma heaps affects teedev, it seems more
> > appropriate to maintain a reference count per dma heap and release it
> > during unregister. This also addresses the first issue.

OK, I'll try to propose something in the next version of the patchset.

Cheers,
Jens

> >
> > Regards,
> > Amir
> >
> >>>
> >>> In the case of qcomtee, my original idea was to have two separate
> >>> drivers loaded alongside each other. This setup would allow the
> >>> TEE backend driver to support unbinding, while the protected memory
> >>> backend could remain loaded. This separation is particularly useful
> >>> for FFA, or scenarios where the protected buffer does not need to be
> >>> transfered to TEE.
> >>>
> >>> Or
> >>>
> >>> A reference to teedev could be obtained when the heap is registered,
> >>> rather than for each buffer allocation. In other words, once the heap
> >>> is registered, the backend must remain active and cannot be unloaded.
> >>>
> >>> Or
> >>>
> >>> Find a way to have something like dma_heap_rm()?
> >>
> >> That would be helpful, but I'd prefer to keep it out of the scope of
> >> the patchset if possible.
> >>
> >> Thanks,
> >> Jens
> >>
> >>>
> >>> Please let me know if I mis-understood something? or missing somethin=
g :)
> >>>
> >>> Regards,
> >>> Amir
> >>>
> >>>> +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev)
> >>>> +{
> >>>> +     struct tee_protmem_pool *pool;
> >>>> +     struct tee_dma_heap *h;
> >>>> +     u_long i;
> >>>> +
> >>>> +     xa_for_each(&tee_dma_heap, i, h) {
> >>>> +             if (h) {
> >>>> +                     pool =3D NULL;
> >>>> +                     mutex_lock(&h->mu);
> >>>> +                     if (h->teedev =3D=3D teedev) {
> >>>> +                             pool =3D h->pool;
> >>>> +                             h->teedev =3D NULL;
> >>>> +                             h->pool =3D NULL;
> >>>> +                     }
> >>>> +                     mutex_unlock(&h->mu);
> >>>> +                     if (pool)
> >>>> +                             pool->ops->destroy_pool(pool);
> >>>> +             }
> >>>> +     }
> >>>> +}
> >>>> +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
> >
>
