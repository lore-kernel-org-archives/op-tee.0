Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47251C83F07
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 13:38:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 7D7B845AAA
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 13:38:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XAYVU96v;
	dkim-atps=neutral
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 6EB0940B61
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Jul 2025 13:38:05 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6120049f09fso1815132eaf.2
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Jul 2025 06:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751895485; x=1752500285; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPtEo+284Dik3ngmlwaHHrU4cBbgVxQpmRaZKXUJ5Jo=;
        b=XAYVU96vK6LJXoCqHli0KRaLRYwQPR8Wbzb34ykRENmszfF1CqOVx8p854NDzc7zhK
         A8LiMiwsuSjNcyHcy2fUaKmR057w/FOBsta3EptfOQSGll3TccUP3cicKAc4Z93RWRg0
         /Pxo7eBW841NRidWHQrsD2Adfw0bHSMesedbn2G8Ury8vw7ZS64oKthIUJHM6a5AIwXd
         3m3t+oTTGyvTJrwyLDfLgCD6XNWMXNfbGfcMHsW/MJHY2/EqVU8kJLJcp0uH+4aen4GJ
         toVO4SsfVwZ0SaJxtx0/aoR0Z6XSlLlcs2Cwlvpr7wtuo+gyMK7CNfUZ7lCUC0lCSULT
         S/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751895485; x=1752500285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPtEo+284Dik3ngmlwaHHrU4cBbgVxQpmRaZKXUJ5Jo=;
        b=UEYflZQ2/ayt7IQW4ntncX4euNQ0qr1za9fu5+vKm3jPgcyeq2HSo+p3vC+BnAF78s
         +hWboAuVH7rPDaIeIhNmgbvGNj/d+q9jCkAYWe4VJuT8UeEpru7U8yao6NOIk2i+MxH2
         1AC4nEvkX4Jjip9Rzarwkt4DcgliZ15INFm471eD3ZMlMceULtcV1395ZoXPH64XqNEX
         ZBc6dM3o4F5ztFDxazsXYQnTn75JN53c/NrkkCOhnQFYr5bthqwuig37LxhvZ/KbLjBZ
         6c5J0W59XtLt8cTqQ6AS4VqWB3CgrqUo+EtvVaSC9sLKH0w4HSJvXboZryw/O8f9xW9R
         WnUg==
X-Forwarded-Encrypted: i=1; AJvYcCUl+0pCJAWd6u/gKJZpyWWb3Hl1FytCnldhdTHUrAsOB98WTJXgsPHPUajot3WkwvmlyUaR7JE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yzbkb45WAR5oO6GkRlIbLxXLnBTEXhYqAdvPdbbUPDTHi62N5wN
	IK5i9SanF6BmVZTEoJpSXU278IdP9q5vEXwvdgGpKUE/sfxjtfB9bUokoCNkRqyMhTisYSXH/IC
	xlh68QYSWfE8ci7jYDKATn/Ai0zVnWpBbHsb57e7LDhT4
X-Gm-Gg: ASbGncuH+CsNeb+0Wf2JcSBrtIlmi+xI/1qLeTngijtJmXC/omsIC+nXqxuSfUapdlu
	PoTNPxbbujVrtPZLm93decZ5cqjz3ApEWGp5J9sYt9sMnskunl30FSbJM0v5c1BlOhiuZ6WWXCP
	NIcjqeg4PVWAVNJ1KmdEP2zutwiM+/ZZ6NVnwkuXOnWAyL
X-Google-Smtp-Source: AGHT+IEZ3yGtE2FU/0QWUjraPLFFt+Z1/vBLFwkNdtWliU4sU2mLbMGkNn3Aw1OyF4v+P+g/k20BlqBdrqjrRIoeNb8=
X-Received: by 2002:a05:6820:6acf:b0:611:e00a:598d with SMTP id
 006d021491bc7-61392c2c5a8mr8978260eaf.8.1751895484701; Mon, 07 Jul 2025
 06:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org> <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
 <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com> <aGu_bgKuSDJUKUoP@sumit-X1>
In-Reply-To: <aGu_bgKuSDJUKUoP@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 7 Jul 2025 15:37:52 +0200
X-Gm-Features: Ac12FXykqyF9TyRtbnayj5wiwMr1vGNBNa7XguVZcQTGIeozHv4fR-XtyeR_SVE
Message-ID: <CAHUa44EAbRuGRk7HvmHaCTGBnFE1JCfSLAdFtJ8FWOaiDt4uHQ@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 6EB0940B61
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.50:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[209.85.161.50:from];
	DNSWL_BLOCKED(0.00)[209.85.161.50:from];
	ARC_NA(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: XZ3LIA3U3EVHAFQWAHZY5HGONQBNODFT
X-Message-ID-Hash: XZ3LIA3U3EVHAFQWAHZY5HGONQBNODFT
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XZ3LIA3U3EVHAFQWAHZY5HGONQBNODFT/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Mon, Jul 7, 2025 at 2:37=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org> w=
rote:
>
> On Mon, Jul 07, 2025 at 01:22:19PM +0200, Jens Wiklander wrote:
> > Hi Amir,
> >
> > On Mon, Jul 7, 2025 at 4:22=E2=80=AFAM Amirreza Zarrabi via OP-TEE
> > <op-tee@lists.trustedfirmware.org> wrote:
> > >
> > > Hi Jens,
> > >
> > > On 6/10/2025 11:13 PM, Jens Wiklander wrote:
> > > > Implement DMA heap for protected DMA-buf allocation in the TEE
> > > > subsystem.
> > > >
> > > > Protected memory refers to memory buffers behind a hardware enforce=
d
> > > > firewall. It is not accessible to the kernel during normal circumst=
ances
> > > > but rather only accessible to certain hardware IPs or CPUs executin=
g in
> > > > higher or differently privileged mode than the kernel itself. This
> > > > interface allows to allocate and manage such protected memory buffe=
rs
> > > > via interaction with a TEE implementation.
> > > >
> > > > The protected memory is allocated for a specific use-case, like Sec=
ure
> > > > Video Playback, Trusted UI, or Secure Video Recording where certain
> > > > hardware devices can access the memory.
> > > >
> > > > The DMA-heaps are enabled explicitly by the TEE backend driver. The=
 TEE
> > > > backend drivers needs to implement protected memory pool to manage =
the
> > > > protected memory.
> > > >
> > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > ---
> > > >  drivers/tee/Kconfig       |   5 +
> > > >  drivers/tee/Makefile      |   1 +
> > > >  drivers/tee/tee_heap.c    | 472 ++++++++++++++++++++++++++++++++++=
++++
> > > >  drivers/tee/tee_private.h |   6 +
> > > >  include/linux/tee_core.h  |  65 ++++++
> > > >  5 files changed, 549 insertions(+)
> > > >  create mode 100644 drivers/tee/tee_heap.c
> > > >
> > [snip]
> > >
> > > I'm having a bit of trouble understanding the rationale behind
> > > supporting tee_device_unregister_all_dma_heaps(). Considering that
> > > the heap remains accessible from userspace, wouldn't this lead
> > > to undefined behavior? For example, what happens if a user is
> > > in the middle of a tee_dma_heap_alloc() -- specifically before
> > > tee_device_get() -- while the backend calls tee_device_unregister_all=
_dma_heaps()?
> >
> > That can't happen since tee_device_unregister() has been called
> > before, guaranteeing that no further calls to tee_device_get() can
> > succeed.
> >
> > >
> > > I understand that you want to use teedev refcount to protect against
> > > the TEE driver unbinding if there is a buffer allocated. But what abo=
ut
> > > the heap device?
> > >
> > > Additionally, what if the user decides to unbind the TEE backend driv=
er?
> > > Would the dma_heap device still persist without any alloc function?
> >
> > Yes, the device would still be there, but alloc would return -EINVAL
> > until a new heap has been registered.
> > But I think you're on to something, we should perhaps increase the TEE
> > module refcount when calling dma_heap_add(). Do you agree?
>
> But that won't allow to cleanly un-bind/bind OP-TEE module. It looks
> like we rather need to enforce the OP-TEE driver to be built-in in case
> it is the provider of DMA heaps.

Yes, it will. The allocation function is tee_dma_heap_alloc() in the TEE SS=
.

Cheers,
Jens

>
> >
> > >
> > > In the case of qcomtee, my original idea was to have two separate
> > > drivers loaded alongside each other. This setup would allow the
> > > TEE backend driver to support unbinding, while the protected memory
> > > backend could remain loaded. This separation is particularly useful
> > > for FFA, or scenarios where the protected buffer does not need to be
> > > transfered to TEE.
> > >
> > > Or
> > >
> > > A reference to teedev could be obtained when the heap is registered,
> > > rather than for each buffer allocation. In other words, once the heap
> > > is registered, the backend must remain active and cannot be unloaded.
> > >
> > > Or
> > >
> > > Find a way to have something like dma_heap_rm()?
> >
> > That would be helpful, but I'd prefer to keep it out of the scope of
> > the patchset if possible.
>
> Yeah lets keep that for next feature patch-set.
>
> -Sumit
>
> >
> > Thanks,
> > Jens
> >
> > >
> > > Please let me know if I mis-understood something? or missing somethin=
g :)
> > >
> > > Regards,
> > > Amir
> > >
> > > > +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev=
)
> > > > +{
> > > > +     struct tee_protmem_pool *pool;
> > > > +     struct tee_dma_heap *h;
> > > > +     u_long i;
> > > > +
> > > > +     xa_for_each(&tee_dma_heap, i, h) {
> > > > +             if (h) {
> > > > +                     pool =3D NULL;
> > > > +                     mutex_lock(&h->mu);
> > > > +                     if (h->teedev =3D=3D teedev) {
> > > > +                             pool =3D h->pool;
> > > > +                             h->teedev =3D NULL;
> > > > +                             h->pool =3D NULL;
> > > > +                     }
> > > > +                     mutex_unlock(&h->mu);
> > > > +                     if (pool)
> > > > +                             pool->ops->destroy_pool(pool);
> > > > +             }
> > > > +     }
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
