Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13109C8303C
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 11:22:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 462F442EC2
	for <op-tee@archiver.kernel.org>; Mon,  7 Jul 2025 11:22:52 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=O0so0Jho;
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 30F2341AE6
	for <op-tee@lists.trustedfirmware.org>; Mon,  7 Jul 2025 11:22:31 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-611f48c6e30so1885754eaf.0
        for <op-tee@lists.trustedfirmware.org>; Mon, 07 Jul 2025 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751887350; x=1752492150; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBD6cWteD3zVqlVT5kPTDbHAwMFUvPNKcObEJcscu+0=;
        b=O0so0JhogWuW2k4D21DpOslcuW4Nva/ETDyswQI4osZ8EINnTPdQYosYGTS+T9/YWz
         UJvM8WyitciobkHotSApKa8N2+6R/1xF5LmbHEAZxuLFQJVA0tktEh3tqIfUJV1J1W75
         DYacfN0J1092X+IpXFkQyA1/juFmL5yLXuhsgwaOjNFkdf6cPohzdJ5fNMZXbRzuDE19
         8D5LrEVcoHrl2D9VSpj0IgEUG1Jg/8gTU0ZtEDxMajIBY2CZ0AfK9eVODQZvNFDnMClJ
         v68qXdB3awem5MC6X2pXwPtMW1s7TeNgFuibJhWCZ57uLlUGtMyovzmNjwnnWMU0HXwf
         vt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751887350; x=1752492150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBD6cWteD3zVqlVT5kPTDbHAwMFUvPNKcObEJcscu+0=;
        b=nvLLSX1E6WailR8WYuuogeS4lcIeCdBDckkShWmaG29NaF92/L2FjWqGOrrx5CwpT4
         8/9klhQmB5MehKPJzhaEIkyxU3EhoYHvT0MNpa7tFDEotYGDM41FSOZYc3VK0fjD7qft
         yESHzxAOMEBBI58wDjSkhqoraK59qXS3dKvfGed3+I1ORj7of/gAeBpLI5eOiMlXzE3u
         y93fSojz9zqB6TkppuuQKV8IZn6rBnTWVxFVUNijCdnc6O7EpGPC4TK44QoURiOvnWUI
         nRkz/Va9iGRlkRryyRDmSaFCC3TVJSwjAK8tJI1J8lUHXUzkjWqSUs1aKGbLPET+2BWB
         LNPw==
X-Gm-Message-State: AOJu0Yxo2U7QouuiIMURcCbDtvUTeTDKetklE7Q4hK0+TT6HdfEfITBF
	VDt+PwTbbvlBRZ4xG2WDd7AjNN11R3EhWHRxwLUvUbjD6tR+DtRVNPBlMQPCKMBq4PmVYkEM2vl
	w+JPwso/sGlAbWCE82k7zQp4OeOf76B0sQzeWsymyGa7/
X-Gm-Gg: ASbGnctVgNmo20Go5dfZnQrg+4inV/Cnc9IXPegP58zKiRUxRSbPyfHMmS4mK8IxFGw
	ReTkIAhVylFFyYd/Rwy461akEaEG3aEGbsRLLw50qEw6vfJKaH2AnSll3Lvvjlk+O3xt4GIjoE9
	Ti5qcJVzNb7HffnS5A9AZhXNx7/Ma/7Kc41jpZQcmKD0W/
X-Google-Smtp-Source: AGHT+IHsMAOIk4i24Gjic5VH4AZhVHLaKmE7ltbZOigNJvNVFlPl/fZ2O7z2kpsMU5mZJnC7vI21C3vgGoc59YiQgT8=
X-Received: by 2002:a05:6820:6ae5:b0:611:a799:c21e with SMTP id
 006d021491bc7-613a009248fmr5517918eaf.5.1751887350395; Mon, 07 Jul 2025
 04:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250610131600.2972232-1-jens.wiklander@linaro.org>
 <20250610131600.2972232-4-jens.wiklander@linaro.org> <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
In-Reply-To: <b1a71f06-901e-47fb-9e27-9d401d26f7fc@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 7 Jul 2025 13:22:19 +0200
X-Gm-Features: Ac12FXzVqeFo4lsjW73yP3fEmrIu90xmfGjQsV1RDuAqpGfIpTpXEYSj_1WMMv0
Message-ID: <CAHUa44FV_maNF1Xx0hnqGT3=DnM3zEnLj6CLcz7pZvxEPmiGJw@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] tee: implement protected DMA-heap
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 30F2341AE6
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.54:from];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RBL_SENDERSCORE_REPUT_8(0.00)[209.85.161.54:from];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.54:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[linaro.org:+]
Message-ID-Hash: FFYUZMYRNOFX26R3NS7E35E7DOX4EJXC
X-Message-ID-Hash: FFYUZMYRNOFX26R3NS7E35E7DOX4EJXC
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/FFYUZMYRNOFX26R3NS7E35E7DOX4EJXC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Mon, Jul 7, 2025 at 4:22=E2=80=AFAM Amirreza Zarrabi via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi Jens,
>
> On 6/10/2025 11:13 PM, Jens Wiklander wrote:
> > Implement DMA heap for protected DMA-buf allocation in the TEE
> > subsystem.
> >
> > Protected memory refers to memory buffers behind a hardware enforced
> > firewall. It is not accessible to the kernel during normal circumstance=
s
> > but rather only accessible to certain hardware IPs or CPUs executing in
> > higher or differently privileged mode than the kernel itself. This
> > interface allows to allocate and manage such protected memory buffers
> > via interaction with a TEE implementation.
> >
> > The protected memory is allocated for a specific use-case, like Secure
> > Video Playback, Trusted UI, or Secure Video Recording where certain
> > hardware devices can access the memory.
> >
> > The DMA-heaps are enabled explicitly by the TEE backend driver. The TEE
> > backend drivers needs to implement protected memory pool to manage the
> > protected memory.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/Kconfig       |   5 +
> >  drivers/tee/Makefile      |   1 +
> >  drivers/tee/tee_heap.c    | 472 ++++++++++++++++++++++++++++++++++++++
> >  drivers/tee/tee_private.h |   6 +
> >  include/linux/tee_core.h  |  65 ++++++
> >  5 files changed, 549 insertions(+)
> >  create mode 100644 drivers/tee/tee_heap.c
> >
[snip]
>
> I'm having a bit of trouble understanding the rationale behind
> supporting tee_device_unregister_all_dma_heaps(). Considering that
> the heap remains accessible from userspace, wouldn't this lead
> to undefined behavior? For example, what happens if a user is
> in the middle of a tee_dma_heap_alloc() -- specifically before
> tee_device_get() -- while the backend calls tee_device_unregister_all_dma=
_heaps()?

That can't happen since tee_device_unregister() has been called
before, guaranteeing that no further calls to tee_device_get() can
succeed.

>
> I understand that you want to use teedev refcount to protect against
> the TEE driver unbinding if there is a buffer allocated. But what about
> the heap device?
>
> Additionally, what if the user decides to unbind the TEE backend driver?
> Would the dma_heap device still persist without any alloc function?

Yes, the device would still be there, but alloc would return -EINVAL
until a new heap has been registered.
But I think you're on to something, we should perhaps increase the TEE
module refcount when calling dma_heap_add(). Do you agree?

>
> In the case of qcomtee, my original idea was to have two separate
> drivers loaded alongside each other. This setup would allow the
> TEE backend driver to support unbinding, while the protected memory
> backend could remain loaded. This separation is particularly useful
> for FFA, or scenarios where the protected buffer does not need to be
> transfered to TEE.
>
> Or
>
> A reference to teedev could be obtained when the heap is registered,
> rather than for each buffer allocation. In other words, once the heap
> is registered, the backend must remain active and cannot be unloaded.
>
> Or
>
> Find a way to have something like dma_heap_rm()?

That would be helpful, but I'd prefer to keep it out of the scope of
the patchset if possible.

Thanks,
Jens

>
> Please let me know if I mis-understood something? or missing something :)
>
> Regards,
> Amir
>
> > +void tee_device_unregister_all_dma_heaps(struct tee_device *teedev)
> > +{
> > +     struct tee_protmem_pool *pool;
> > +     struct tee_dma_heap *h;
> > +     u_long i;
> > +
> > +     xa_for_each(&tee_dma_heap, i, h) {
> > +             if (h) {
> > +                     pool =3D NULL;
> > +                     mutex_lock(&h->mu);
> > +                     if (h->teedev =3D=3D teedev) {
> > +                             pool =3D h->pool;
> > +                             h->teedev =3D NULL;
> > +                             h->pool =3D NULL;
> > +                     }
> > +                     mutex_unlock(&h->mu);
> > +                     if (pool)
> > +                             pool->ops->destroy_pool(pool);
> > +             }
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(tee_device_unregister_all_dma_heaps);
