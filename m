Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54E8CCA471
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 12:27:07 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 39B5F41B41
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 12:27:07 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RO45CVyI;
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8D48C3F65F
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Oct 2025 11:15:13 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so4305831a12.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Oct 2025 04:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759490112; x=1760094912; darn=lists.trustedfirmware.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWB1l3GhtvvQRLGif85/yxZOUyZcqzxNH5HwDVS5Pe4=;
        b=RO45CVyIvr+zoT0346h5dAJRJZK224t7VXPuBVvbhNaxrlsQzHVAls7YpzOguXQ488
         9NwKKOgLuX7ncMtoIThJj0kulfsA5LfvlHJmaAaV1Zw/BPXc9dLgYHPz0Z5YhUTESy1H
         lihYorVFm11nZkmElLdFKQzy381eMynyuoPfzRPKm8LPvfOtpn4P2Lu3ICyFtHi6E1kz
         BoHCaVc1V8CDiwUG4bEjrS2v9zEvw6SmfIQYfpxDZJ04dHC4MNxlfWQlCUy9pi7R8Ybu
         MKfQNI9aFesEnikEfqCrV4ef1vlbcr7Y6UynuubTUaFUQSqM1DT3zgXNKUoKc2Ukn4+y
         hNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759490112; x=1760094912;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWB1l3GhtvvQRLGif85/yxZOUyZcqzxNH5HwDVS5Pe4=;
        b=ioP1cD2b07UsavalkFBSoIkM7Lc432svG0Yw6WhgTAjRMF40gMKbPpdu5l1Xg4+uyc
         KJsrTWfNcnrva2jeJSVyOGVvlv/r+Nyov+6M8RQg/nI3QXTC3nyCRYnTYvMm2oVuQAVM
         3v6fBaj8NGf88jgYtMVDPe6ioYPttfLWqtXxRfdq5g/pjlHEyLNbfk4Mcj01M1yU3F0O
         VAqkIOoflM/2AzhaZRsPpDZUofzOOOLFHMIQOoSTSH2YQNFNbDSrV+E8xGEDVdQClNdA
         QV4MGcmyZMnO9QCkJOL1SFlRAB91/OLkPa4DOHITcdaUxlg1inPDiF0xrYpS6EBJzoOv
         Idsg==
X-Forwarded-Encrypted: i=1; AJvYcCUmL4M19FjWmorASzAGC3kpFqWG1JKrZR1LOzVnazINnIq/pzXaAg8kvtZVjeLZBgLWokXkEZE=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yz6Dmu9Htaqr7UChSZJYdqTMRaab3PifXxS4bRXkg57OkJ6RZZm
	AS+YjGQCSPAf1YPAmixhd7DzVdMEp3idf+YMFitduD/kmGKvcsBHiZ4ZAQRUPAwdrRd+8S6lgWS
	456sVKD9NBt9SdAvIAV+BKKPSYEfjcqQ=
X-Gm-Gg: ASbGnctb5NwhFTxjFRcULJxqcjwcSg33nTAATNADoRkH+0VNGq7o0JDF0BQb9JJk2y4
	vWYvAsEES3ZZlPSI3FTY2t8+EPZO/dbUwci0tYKG2qZeXqENWxxDVN/fZwHNvxUSgTQ1WC3y7mp
	u/ql6aqBNnpwk98bvNTe0PbcrChxyZemdYm8vvISOW5oIwauyPgv7trBqT4vGKmSqrtbE1qFOLG
	SOkEr6JDwN8IVA/Atnmza+7s6g7R1llU0jptQucERF+2VdlUzFdNI46PIDcWRiHsgtffEwd41TM
	zXtXbgF3GHdv1j8wuAy5CrcsDU1/go0yHnxQezOArTVKNF683Q==
X-Google-Smtp-Source: AGHT+IFjm21eDqpyMA/7zNk9WQu/hgKPJE76JATEXSYRRHQ+tCbniUTffgJ2HnQM9/+vdQgii5IRucrKIDdjAPB0LwU=
X-Received: by 2002:a05:6402:1ec8:b0:636:6489:4db6 with SMTP id
 4fb4d7f45d1cf-639346c8026mr2597965a12.4.1759490112151; Fri, 03 Oct 2025
 04:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251003104236.1813979-1-pbrobinson@gmail.com> <f31278b3-9f60-43c7-bfc4-027b24a49854@oss.qualcomm.com>
In-Reply-To: <f31278b3-9f60-43c7-bfc4-027b24a49854@oss.qualcomm.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 3 Oct 2025 12:15:01 +0100
X-Gm-Features: AS18NWAWW07gb3Yiz8QMMgh85gWD8hWUFJkX_gW4j2OOJmpv4f_RDk7Q93ixEtk
Message-ID: <CALeDE9Np+WBpr1rfx1w4L0oivZF_hk+Mzp2dZFPs5oa4c-BKJA@mail.gmail.com>
Subject: Re: [PATCH] tee: qcom: depend on ARCH_QCOM
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8D48C3F65F
X-Spamd-Bar: ---
X-Spamd-Result: default: False [-4.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVFROM(0.00)[gmail.com];
	DWL_DNSWL_NONE(0.00)[gmail.com:dkim];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.49:from];
	DNSWL_BLOCKED(0.00)[209.85.208.49:from];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
X-MailFrom: pbrobinson@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: 3DFHPUUBGNEAYFX3GO7IUZMDPN4ONNSC
X-Message-ID-Hash: 3DFHPUUBGNEAYFX3GO7IUZMDPN4ONNSC
X-Mailman-Approved-At: Fri, 03 Oct 2025 12:26:20 +0000
CC: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/3DFHPUUBGNEAYFX3GO7IUZMDPN4ONNSC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, 3 Oct 2025 at 12:00, Kathiravan Thirumoorthy
<kathiravan.thirumoorthy@oss.qualcomm.com> wrote:
>
>
> On 10/3/2025 4:12 PM, Peter Robinson wrote:
> > Add a dependency on ARCH_QCOM, and compile test, as the driver
> > depnds on QCom specific Trusted Applications (TAs) and it's
> > only, currently at least, supported on QCom hardware.
>
>
> Thanks, but this is already taken care.
> https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.git/commit/?h=next&id=3b63efa21bc6acc1a0fadd1dd0f0e1988a4c0177

Awesome, thanks, a quick search and I failed to find it when looking.

> >
> > Fixes: d6e290837e50f ("tee: add Qualcomm TEE driver")
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >   drivers/tee/qcomtee/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tee/qcomtee/Kconfig b/drivers/tee/qcomtee/Kconfig
> > index 927686abceb15..9f19dee08db49 100644
> > --- a/drivers/tee/qcomtee/Kconfig
> > +++ b/drivers/tee/qcomtee/Kconfig
> > @@ -2,6 +2,7 @@
> >   # Qualcomm Trusted Execution Environment Configuration
> >   config QCOMTEE
> >       tristate "Qualcomm TEE Support"
> > +     depends on ARCH_QCOM || COMPILE_TEST
> >       depends on !CPU_BIG_ENDIAN
> >       select QCOM_SCM
> >       select QCOM_TZMEM_MODE_SHMBRIDGE
