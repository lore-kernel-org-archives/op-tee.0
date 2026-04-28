Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E80FF8864
	for <op-tee@archiver.kernel.org>; Tue, 28 Apr 2026 01:02:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 453C34423C
	for <op-tee@archiver.kernel.org>; Tue, 28 Apr 2026 01:02:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=iFy8vRgu;
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id CC5D643190
	for <op-tee@lists.trustedfirmware.org>; Tue, 28 Apr 2026 01:02:30 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8a151012558so117720286d6.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 18:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777338150; cv=none;
        d=google.com; s=arc-20240605;
        b=A6DWbcm16nh+fLi935AFeuRUoTw+K9GsWuzcJmzeCIQHCwjeBjTqHtPlhdCXhiiS9z
         kLAgt7DCw1L/lbu0/+V59HeLXxkVg9t2J+63SucXMYjQpeBQEpK6fsOJSpccJ/510l1z
         6IVWxtIkDJ+LVKqezVb9ZFbycIIDfQJszfULlE6Oj1i8BzxQ3vOqcJWCIhDCSQGCZfK2
         aHoJc5FE/LnOo6jX3NWKo5PvXeWpaZy/REPQWRiFuFNhBecSFhIL4zoPq8tYCLKZb4cu
         cMa341CNs0DK2or8KjgWxd2OCVykgDBu74UFoujlY4ro9uVsRwYaZ2ZIe+U+uDtKXoUY
         uiFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZo+eAvwBTQuAkfm75w09R8hg7C0JhGSnFfmEY8odLM=;
        fh=RjJCkOqJJnztwboVE/I/qE5jGCP7sAvNWkwpJBQEVLU=;
        b=Lk7+ZZ7Zq5DiA1Pcdp2zjTSQEnWzmiWq0jz0pBJN5p8x0sc/i0ISE1SYOyDh3xjwLm
         7BeVPlYHNaxjMgB6FEHvZfWvm1u/REDsnsxb/rtq9G0YvkfHjSGt/jfc3xbDYmjQl5pG
         dCURYZUzwq7inNi9y98kITNgyIg0ojCCsPT6fgCA9H1RzfzEyNRX8kSNalQ3eVbTtmGH
         sw/flRJJ47lTgf1PX6kuaWXSTXNoVsVRajOV0ipqhdVim4xl9XlZRW4kuEiPB5ZdilPY
         7zmrBxUPrw497bITSmBEOMcUYoiG6OUxkE0+yGW1kfCYFm2mbtuXdNykFwTaxiKY68O8
         V8vg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777338150; x=1777942950; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZo+eAvwBTQuAkfm75w09R8hg7C0JhGSnFfmEY8odLM=;
        b=iFy8vRguUWMisvLGtUru5N+VGcyHgfqBRv2fuhuLqiZ4IBUTyMnemx/EyNWSY+Kijk
         XnOYYiJaSFuz1QNRoncKtPQdJJ9Tf7le4hcvTr/RrHZ69PVjDpS0v+S9hKvKOqV0uNa0
         95g1Kl7/C1T0gvzr1IIkzovcrAF1G8uvawjgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338150; x=1777942950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZo+eAvwBTQuAkfm75w09R8hg7C0JhGSnFfmEY8odLM=;
        b=EIFZFWYs51cfnsITX+AfigSle92MLwNhpXX/8gdNV09tzhR+W79rja45UWc9QpNQUm
         FtFA5+CDE94/01vRE5hMthRCOvJL1FWbRrLKWPXhQSefm/1Eia30CZORf8Lo1/lTdmPZ
         hmx3S/gNj3mkOwiLrqEClqXtCRSNI47gAmN4rD6Udh5yI/g7ZtWlCJxLeXXnzSyFfPjs
         vUqZoP5gb7JasQvc5FI/m3+35HCoaQ2pRs5My2YjKcXMXyjQkrtaUZVmxlR+XjyM2ieu
         FQgHC/9o60MIW46mxJMc/iFrlO1vXxS9X9CWfQ53RN/HYgevlPWC89HXjqyM9NgMm5+c
         r4VA==
X-Forwarded-Encrypted: i=1; AFNElJ+06bCwvDWNGNL+heQoUVIrBNi3bgWx7E1Me/rkQ/1cICgfvEI39rdcpEThBXnsmDt/N24bhEI=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yy0XNlCS0uoPHtmpB9K+BseofI++5DOZCZkn4YC9sbcSTlNu7mP
	MDSvOQx8D2x1BTU1ZNYai0oypcOUxKKK+5OnkNPu9h634x4qo2R1IjYAqxczFvNT23hbe6sjKiL
	jnUC7zVKF8RUUvvt635aG9Wot5b9Ol5MOQy6CCr0g
X-Gm-Gg: AeBDieuYdeP7YtZT974gDmwlAZHnvQUaItJNlxZ3viCwfBigsCr0Y8tMN2HtWQuiqIV
	Y1IIaMHB2zKwHvbGsXfFSLq04pJCuWaVrZ3UcKZBQ13AhOY31lQfFcc/EEPRnhtb9+zlOJigd7W
	sFZ1ayGOXlegjyEh11MYw9t9DX8UxyJVNgESuHTqHkTFKZe7Gtj4NvZpFN/2B1b9aHXIv8fu+nu
	Ec71Xz8Q8NpxfYTzbP7MDEWUeCv/UMQxaCJW7PaEfGMvIVrU2Tt3gm9SGjMF+ObIvs5ZFDUnw36
	ktdSHbOb3km93OGhpdpCcXjcd9tjixJUj4+GcepP8R6CJElU
X-Received: by 2002:a0c:e002:0:b0:8a2:d93c:993a with SMTP id
 6a1803df08f44-8b3e2fbd381mr16677516d6.3.1777338150217; Mon, 27 Apr 2026
 18:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260416221819.3600289-1-hiroh@google.com> <aeYcIpw6lyUnmIsN@sumit-xelite>
 <CAHUa44Fe_L5CVKnsxi4HswH2D9bCA3u14ESb6LoKqcOSrfs3Cw@mail.gmail.com>
In-Reply-To: <CAHUa44Fe_L5CVKnsxi4HswH2D9bCA3u14ESb6LoKqcOSrfs3Cw@mail.gmail.com>
From: Hirokazu Honda <hiroh@chromium.org>
Date: Mon, 27 Apr 2026 18:02:18 -0700
X-Gm-Features: AVHnY4KO7VEDCFhVjtZEwNYPlDbbn50W0DVUa_JtbOCGKYvFQugIdoD6Uc_zOSo
Message-ID: <CAO5uPHN7hcUq0fQeH82nBHX4LFCOEaD929awpeMufhPcJ=h-VA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Allow MT_NORMAL_TAGGED shared memory
To: Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.219.52:from];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.219.52:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: CC5D643190
X-Spamd-Bar: ----
Message-ID-Hash: RQMDYFX2223T5YRT6MZMB4I3PSA7KBYR
X-Message-ID-Hash: RQMDYFX2223T5YRT6MZMB4I3PSA7KBYR
X-MailFrom: hiroh@chromium.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Sumit Garg <sumit.garg@kernel.org>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/RQMDYFX2223T5YRT6MZMB4I3PSA7KBYR/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Thanks Sumit and Jens for reviewing!

On Mon, Apr 27, 2026 at 6:42=E2=80=AFAM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Mon, Apr 20, 2026 at 2:29=E2=80=AFPM Sumit Garg <sumit.garg@kernel.org=
> wrote:
> >
> > On Thu, Apr 16, 2026 at 03:18:19PM -0700, Hirokazu Honda wrote:
> > > From: Hirokazu Honda <hiroh@chromium.org>
> > >
> > > On ARM64, shared memory can have MT_NORMAL_TAGGED attribute when usin=
g
> > > the Memory Tagging Extension (MTE). The OP-TEE driver needs to
> > > recognize this as normal memory to allow sharing such buffers with th=
e
> > > Secure World.
> > >
> > > Signed-off-by: Hirokazu Honda <hiroh@chromium.org>
> > > ---
> > >  drivers/tee/optee/call.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
>
> Looks good. I'm picking up this.
>
> Cheers,
> Jens
