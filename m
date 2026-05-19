Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76708CD4F3C
	for <op-tee@archiver.kernel.org>; Tue, 19 May 2026 15:29:40 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 9BD1144E1C
	for <op-tee@archiver.kernel.org>; Tue, 19 May 2026 15:29:39 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=JlWn7a5N;
	dkim-atps=neutral
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 4E83B436FF
	for <op-tee@lists.trustedfirmware.org>; Tue, 19 May 2026 15:29:33 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-69d4c0e43acso424601eaf.1
        for <op-tee@lists.trustedfirmware.org>; Tue, 19 May 2026 08:29:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779204573; cv=none;
        d=google.com; s=arc-20240605;
        b=GZi6ChnkQ6ccfkGJV+eeZu8ibqMs5zOqmmA7WDK3X/KAJzIrwv3P8aum6UektYjW0B
         /paWRuLUpNCwg4L5z0Fj/y2+fi2kMQMLTINKMMOs5inr/NdqZuqN2h/I2fI/qPZtJxbA
         BH2qqyy+sOh02Nj9VEYQkcCyHoM6aylXdoejpDiEvH/TzQd1to1+1dIpRrDDJ2Ar96/V
         PisVircyYCBACsOWjM1/fRflHibhbG4s1ZUh3JO/feslxY4HI8/b1ak2aoyZYjOQ5fXK
         emd2+DWMfOGIwot1KEzAHUAtUZ2AVTHHMd7igczQGXDeaG8OqZttEu+dY1p8YaSmDAW/
         rqtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hzk+506nnD6Q/ZmH9dB2cRiPuVtFEDS38+Vsmjjcdd4=;
        fh=5CfEEhSafjTGz5nbW0OLJU4aKoqf9Hl9dCymaeKT+YE=;
        b=Cmvw414Yq2tanEaZNgiCnXlkNSvnGk3qoLlRbeAnhB3/hbsZGnnaGMDe1H+Pua8zA0
         T2VeAdGs46jUbzlVaw4HOUfl5tZWq0WM9hZ0JJmDtDUxmLnoJx7yIaco5G3j5uARLKaB
         +ZHF+5c7W85mWdu+2eDCSU9zvkxOc7jQuHga67AwpNfEtkiLCGV4foZ4AIDMzLFvq1Tv
         hXa4i0NdGzqb4NjBMwW85MXdoXWDnjsx5YIeYDtbxygaLXS+iHgJemXX608vtF18gt4J
         ln4047NeHtaNejyCK7371yN+3/08hBZ5Zw3UkXITAOP3bRDW/sv06CX91L4k7NMB2kYN
         BFog==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779204573; x=1779809373; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hzk+506nnD6Q/ZmH9dB2cRiPuVtFEDS38+Vsmjjcdd4=;
        b=JlWn7a5NlT0yMAf2FVvo113X/R+CS4ZK9mmF1XlQwC8nS0JBHCd674MKoEtJTUl/H7
         Ce/xdxekug8A/J2ECsUSAjfHjzwr8F8hJl7nQtlKemMEVP6dOq+8wK+ZItD9hfnlnilF
         kAC1Zau1aXvUZvm75RZt2rVPV8OcLf+nTOQ+1k6NOaI7LX8/fgoQgkLiZ8kArG+xjaZc
         oe3cErizbdb36dBUOy/9bfHXxbXXf/qNXBKLpcnbYmVmE66JZs7XVVwALnXsbEjvBbWP
         CCjCq9HbOFQhq4eJSoXVG574n87UIAaupXiwGFRISiqGCL7NkKH/wwGKNHimTYMj/y1Z
         umUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204573; x=1779809373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hzk+506nnD6Q/ZmH9dB2cRiPuVtFEDS38+Vsmjjcdd4=;
        b=MckZ608OVv4EY5rusigPfIlg6w3TE/eV9OK3QLVLCc+VIb/nmItyHTS5xTwNzOSHpL
         dW1u2mooskcxwby/HNfPWsQ/Df/DnpYVCb40qdZ70AH5elae5wT3ZqVJ+7Mvk0ifKT0N
         sw22YMsBAgA2LSa+ksEjKlY2bjhJyu/H14x4m2I9CYFb8ATdDzx6ywUSilckcG/YqmnC
         ETZm3nGI7LpkQ16jt1ArEDwjc26JYKn5GPBBcJdxCKXmqSSV+A2mUEGwaMKBnPRtE4kG
         93egjXiOaBUUfOZQxFlTrR+X7H0gKEb3IFShyGnQbxlxJ8aVDjKpbFLbJGDq07kA++zm
         dcYA==
X-Forwarded-Encrypted: i=1; AFNElJ8vN2ow3eL+SCRNygVa0uA+EZ0HzgSN3azwVjt4Rw4RD9mEeohIqJPN4rjR4DUjdJGcx46ZxIM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxe6OjBH3zNR+biz3Sx1CCIL5tnAhkE80o+z2P/LxPJaJ4wM4XM
	j9N665ah3MzaD6OqZ2op0C+9enoDLX9EVWaBErk3quB/0ZAoLwKxcg6fJyu9IGf9dA5oIXVaIc6
	+y4416CMr1Y7x7QDwCjisFcQ9KA8zCBG5DyRKOvFbYHBy
X-Gm-Gg: Acq92OHMLydzVZNARQJsx8sETnKq1T6UAJy8esCrgIOlVRZCS5fn4HXgmtAXLxJZkze
	fdjZ2C1YaD0aXrupwel3/l2mUwr/blM3DpnaK6l9aMYFYgquGidvK8PERvx/UuQEOSTvq3N4vjz
	IhSuNa4ZDOSVtpOCJEeayGs2+cp0V/JqX4aWDw7wltl6Nrq9MHwDqffyTELrerGzABAFlGCIl7K
	CT4so2jCQ449pMTzh9KQ5UXXJqkxZLujzm3S26L66ong+xZ0EaexXyPUPAYAvreJYdGJCOBu+Me
	VRlr0vadDJS1iPbEBVIMgw6doQ1ZEogSlSUnRg==
X-Received: by 2002:a05:6820:809:b0:695:818c:e56c with SMTP id
 006d021491bc7-69c94295ac4mr12804195eaf.7.1779204572652; Tue, 19 May 2026
 08:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <75d61a22-7c36-434a-a9f2-80533090e072@oss.qualcomm.com>
In-Reply-To: <75d61a22-7c36-434a-a9f2-80533090e072@oss.qualcomm.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 19 May 2026 17:29:21 +0200
X-Gm-Features: AVHnY4LIz0JpXbhOdn7tNkNhIg1FU-Q9klfJ4KgTZ2kjcX3BSJEfk4cVDGX87_0
Message-ID: <CAHUa44EG8b74NgdHW=QhKBtKd7e0_xWqQTkZA9tZxEOHenY_AQ@mail.gmail.com>
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
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.161.44:from];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.161.44:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 4E83B436FF
X-Spamd-Bar: -----
Message-ID-Hash: VXMCQISWCDPD2BOKFJGRDPRVQQL6SQ4T
X-Message-ID-Hash: VXMCQISWCDPD2BOKFJGRDPRVQQL6SQ4T
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/VXMCQISWCDPD2BOKFJGRDPRVQQL6SQ4T/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi Amir,

On Fri, May 15, 2026 at 5:10=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Jens,
>
> Recently protected heap support has been added for the TEE subsystem.
> This allows dma-heaps to be managed by the TEE subsystem itself.
>
> For standard, non-protected heaps such as the system heap or CMA heap,
> I am trying to understand the expected usage model. One possible workarou=
nd
> appears to be to mmap the dma-buf fd in userspace, then register the
> resulting userspace VA with the TEE subsystem to obtain a TEE shared-memo=
ry
> object, for example:
>
> fd =3D dma_heap_alloc(...);
> va =3D mmap(fd, ...);
>
> shm_fd =3D tee_shm_register(va, size);
> tee_invoke(shm_fd);
>
> close(shm_fd);
> munmap(va, size);
> close(fd);
>
> This seems reasonable when the lifetime of the registered shared memory
> is limited to a single invocation or callback. However, I am concerned ab=
out
> cases (multiple exits in qcomtee) where the TEE side needs to retain acce=
ss
> to the memory after the ioctl/invocation returns.
>
> In that case, registering only the userspace VA does not appear
> to keep the underlying dma-buf object alive. The TEE core pins the pages,
> but it does not hold a dma-buf reference or attachment. If userspace late=
r
> closes the dma-buf fd and unmaps the VA, the dma-buf exporter may conside=
r
> the buffer released, while the TEE side may still have the memory registe=
red.

That's surprising. Are the pages returned to the heap also? If so,
there's an issue.

>
> Is there a recommended way to use standard heaps, such as the system or
> CMA dma-buf heaps, when the sharing lifetime is longer than a single TEE =
call?

No, I think you're pioneering this.

>
> Would it make sense to extend tee_shm_register_fd() so that it can handle
> dma-buf fds from regular dma-heaps as well, not only dma-bufs managed by
> the TEE subsystem? That would allow the TEE core or backend driver to kee=
p
> the dma-buf reference for the lifetime of the TEE shared-memory object.

It seems like a workaround, since I assume that the purpose is to
share memory between the user space process and the TEE. I think this
might be a last resort or something.

Cheers,
Jens
