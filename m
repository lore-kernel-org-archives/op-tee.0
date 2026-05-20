Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AA4CD4F54
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 11:18:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3D50943836
	for <op-tee@archiver.kernel.org>; Wed, 20 May 2026 11:18:30 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IK73J03x;
	dkim-atps=neutral
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id A75F043836
	for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 11:18:23 +0000 (UTC)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6948fb494a0so2633539eaf.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 20 May 2026 04:18:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779275903; cv=none;
        d=google.com; s=arc-20240605;
        b=B3UR7zGXYJ/RV+C1rWB66Hi+07i7f0ru/SeHA4/oj73OljCn2Wxl+nG1GGgsFs08FL
         ZlpU4PySD4T8N/D5AoWMElu8fbkgsoOgn8zDLJR0X3KjpygOYVbh2YxKd7Ncg61gfTHy
         a7c0MqY7bW1ja3fR+CHqzs/OP9Ikgx3aZw+ZEriF8wmy52vKvmiMYBmIH1lPDEXHSZ4N
         LzEbLc3u3gxZlPYQBxXNWv86a4U48b/8FROxBnfCeRzsDYKB1KTJdw/9YOGfGpcdjZjE
         AtO7oNRunzsv9j9YpSR3bp9NeTlVv9CaXFw6en+4Z64xsBRSX3bVjutLUPijz7zC/8Ly
         fKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tU6vSMA33DxkO0Dt9QufKYmhp/EFnkJVMaNeE8Q/2A4=;
        fh=QzpchVl+v3wGm763oRa5Ea/rw7UZfmZ24fHICQQhdmI=;
        b=cObJtlTSvZ4ea2dEJ8TCcZWW/qCcXKPko1xBLwEbPKAN/dgnX0eY/k/s4+H4A5TW3d
         keOqQlfNuMesSfeSu4wfgA9qeV+wKGDBI3Hy6aSQzCoEB3s/F3ENJx1RY8LTk2fnSeJG
         x/UmoAWGZs9yDqRy2rPGakjGzVMcntZLiibJn0fjrA2cy6SswKEOMnMtbYu26HWB2I8c
         evdeNxsa0MNLQt2jkYHK+njLdxbUZBW1tX9ssa8h5q3ROKEEzcLU9lBOKdQ2FTIkphI6
         dkLgltWbAiDtFys36vJwUl+Ai8LQCIWwhvb7Cfp5dbEyvQoxJw93ENx0pMrA86SjN5/F
         5sJQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779275903; x=1779880703; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU6vSMA33DxkO0Dt9QufKYmhp/EFnkJVMaNeE8Q/2A4=;
        b=IK73J03xDg6v9YtyEzIk3//CrLC3oYNnbkA2A3LSo2KcefhybLLj3Gblkcc7s1qA/2
         aKGCZcrQWt+CLo1ZMtNAcQI52t8Ebhz4K8Wqqbp9Jo+OhZ0gp0Jy1Kewc41UpobxeR49
         7dqnd+xFwX8UTmpzmLcv3UbjVs/hzOGKNoyTfNxZkc3VoJT+LTWpj5zbeywugtzb1O7n
         zmGXua5YMB1um8qau+WpbZqoC0nIrqXvY0ygZ9J8TYdOYE4cYnhXX4wuCyY+6bsgo5yd
         L9P8HT92LX+Hn8fxmXEidmszDMQ7D8qggT4clMtFv6cdUTpgVUafz9P3MF87GN8/XFpm
         aSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779275903; x=1779880703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tU6vSMA33DxkO0Dt9QufKYmhp/EFnkJVMaNeE8Q/2A4=;
        b=FkqjhGizno3iRmFgBqZf80Fp6isZKNL0kaE/CSNARwlt8ErJbA7cAJqKwrTiKranIm
         AOtrnFg7kMx4sQw2N6lMK0+Fb0A3ncd+oGZDK34WfIEqkOUAU7UVxtSJ3HZR8WS9i4oi
         G6wAMNrZKuzHRKtOMJPV/lcqN13qgaTA2oF1rStePEGVxkFlA8dX87fqBr+0We4KsjT+
         vul+kmGIDYII4mRD+7BqSd8yHVOMacPRkt0k+NTITQNuA0sJoXY23VlZo7iDXI9C8yWX
         3adXck+a8TvLj0I6ymSOibKUVJpCVYuT+wrtoPiNh2YV67DQPmbzcRQk1J6saZ96+0sD
         aPAg==
X-Forwarded-Encrypted: i=1; AFNElJ8lCkMCfBN4iFdtldHM2+viGJ1DuDw2r5ZYWasj3Sm4uOJmHrGBSjweMFLYcCAxhCrvuJCQ4D4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxf/5PlXPK7DM5OUrODbeNMhZt/T1sFTIY/g7fenX6SJjn/xbU4
	IOm2FS5Ak8AamBkI0uwqCnVmsXFPHzFVmyu8Nksi7LOldMZLJO6RN8OKe4qAup4uYaPC786CmbI
	ybO20m7/6hpmpomws2tAxYBH7FH4MN+LpYGi3DkP8GngN
X-Gm-Gg: Acq92OHWtRP2VezTtaf/Z3uYKePCkimoezdEyVLWZDH2w6Jft4npz9q+QQeepnoNKdk
	h15mbg/domanBnDGNUwhzUWLlYO8/m+d3lVNcXuW/7N365y3APZ8ZeraA2c76ZhJpFw9fGOgPCv
	25Jju/842UT9LQDLw+fxAFDO+iP17pq6hjXqVd0fauOfMVk2DBgYn5pFoIN99GNTR3V+TC12epm
	thCZ8UbXRu7SbjC3NnRTt4SDxsuTmbt4UrH/uSu9GhlQ+WCpjFXhMdoaMIWLPOJtu1AvFq4l3G/
	b0g6X2szO6DPBFAypWKH4TZknjnvzDF6SL/DcQ==
X-Received: by 2002:a05:6820:829:b0:67e:2ff7:2a6e with SMTP id
 006d021491bc7-69c942faa5dmr16243290eaf.18.1779275903021; Wed, 20 May 2026
 04:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <75d61a22-7c36-434a-a9f2-80533090e072@oss.qualcomm.com>
 <CAHUa44EG8b74NgdHW=QhKBtKd7e0_xWqQTkZA9tZxEOHenY_AQ@mail.gmail.com> <cd6caaef-032e-4679-88b3-2f242c28b00f@oss.qualcomm.com>
In-Reply-To: <cd6caaef-032e-4679-88b3-2f242c28b00f@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 20 May 2026 13:18:10 +0200
X-Gm-Features: AVHnY4K33bhKh481IW8jH7p2nD6YwfhkCWpwiX-WeV2kDsQz3yLhmTHOmvdd_94
Message-ID: <CAHUa44EepbbkhnxkkqfUXWoPROeM85Ziw6NYhzjRtFXD+C0iuQ@mail.gmail.com>
Subject: Re: dma_heap and protected memory
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.54:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.54:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: A75F043836
X-Spamd-Bar: -----
Message-ID-Hash: QYRWF2E7L4VIR26J5GOG7Y7DPIBLMQZC
X-Message-ID-Hash: QYRWF2E7L4VIR26J5GOG7Y7DPIBLMQZC
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/QYRWF2E7L4VIR26J5GOG7Y7DPIBLMQZC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Wed, May 20, 2026 at 9:10=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> On 5/20/2026 1:29 AM, Jens Wiklander wrote:
> > Hi Amir,
> >
> > On Fri, May 15, 2026 at 5:10=E2=80=AFAM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Hi Jens,
> >>
> >> Recently protected heap support has been added for the TEE subsystem.
> >> This allows dma-heaps to be managed by the TEE subsystem itself.
> >>
> >> For standard, non-protected heaps such as the system heap or CMA heap,
> >> I am trying to understand the expected usage model. One possible worka=
round
> >> appears to be to mmap the dma-buf fd in userspace, then register the
> >> resulting userspace VA with the TEE subsystem to obtain a TEE shared-m=
emory
> >> object, for example:
> >>
> >> fd =3D dma_heap_alloc(...);
> >> va =3D mmap(fd, ...);
> >>
> >> shm_fd =3D tee_shm_register(va, size);
> >> tee_invoke(shm_fd);
> >>
> >> close(shm_fd);
> >> munmap(va, size);
> >> close(fd);
> >>
> >> This seems reasonable when the lifetime of the registered shared memor=
y
> >> is limited to a single invocation or callback. However, I am concerned=
 about
> >> cases (multiple exits in qcomtee) where the TEE side needs to retain a=
ccess
> >> to the memory after the ioctl/invocation returns.
> >>
> >> In that case, registering only the userspace VA does not appear
> >> to keep the underlying dma-buf object alive. The TEE core pins the pag=
es,
> >> but it does not hold a dma-buf reference or attachment. If userspace l=
ater
> >> closes the dma-buf fd and unmaps the VA, the dma-buf exporter may cons=
ider
> >> the buffer released, while the TEE side may still have the memory regi=
stered.
> >
> > That's surprising. Are the pages returned to the heap also? If so,
> > there's an issue.
> >
>
> Yes, that is my understanding. For dma-heaps, after the final dma-buf
> reference is released, the exporter is free to return the backing pages t=
o
> the heap.

This should be a generic problem. Surely there must be something to
stop the exporter from returning the pages.

>
> >>
> >> Is there a recommended way to use standard heaps, such as the system o=
r
> >> CMA dma-buf heaps, when the sharing lifetime is longer than a single T=
EE call?
> >
> > No, I think you're pioneering this.
> >
>
> ;-).
>
> >>
> >> Would it make sense to extend tee_shm_register_fd() so that it can han=
dle
> >> dma-buf fds from regular dma-heaps as well, not only dma-bufs managed =
by
> >> the TEE subsystem? That would allow the TEE core or backend driver to =
keep
> >> the dma-buf reference for the lifetime of the TEE shared-memory object=
.
> >
> > It seems like a workaround, since I assume that the purpose is to
> > share memory between the user space process and the TEE. I think this
> > might be a last resort or something.
> >
>
> Yes, I agree.
>
> The specific case I am looking at is qcomtee without an FF-A backend. In
> that configuration, qcomtee currently requires physically contiguous shar=
ed
> memory, so registering anonymous userspace memory is not very practical.

Agreed.

>
> Today the qcomtee shared-memory pool is implemented on top of
> tee_dyn_shm_alloc_helper(), which allocates memory from the normal page
> allocator. This makes larger allocations subject to the usual high-order
> allocation / MAX_ORDER limitations.
>
> One option would be to move, or extend, the qcomtee shared-memory pool to=
 use
> a cma backed allocation path. That would address the default allocation c=
ase
> through TEE_IOC_SHM_ALLOC (without restriction).

CMA maintainers might have a view on that.

>
> However, I am wondering whether it is better to also allow userspace to c=
hoose
> the source of the memory, for example when the memory must come from a sp=
ecific
> carveout or from a cma dma-heap selected by the client.
>
> If you feel it is not a correct direction, I totally understand consideri=
ng
> it is workaround for a limitation.

It has an advantage by moving the problem to user-space. I can't say
for sure what I think of it before I've seen the needed changes.
tee_ioctl_shm_register_fd() or one of the helper functions will need
some updates to handle generic DMA-bufs from elsewhere.

Cheers,
Jens
