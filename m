Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCACCAC5B0
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 14:12:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 056AE42F77
	for <op-tee@archiver.kernel.org>; Fri,  3 Oct 2025 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1759500748;
	bh=fGLQZPdCvtcHc2MkDN2DGhBQlUE98zkGacuiPRbjY3o=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=XJxgaH84REqV0MiVPQGDklQATw2tDAAsUNV7rvyQAB7OmNvMU2yEXfzJEOybca3fM
	 AMFOR+76iM5SIW+3d7MCiD4rRnyvJeNZR9LTf/+D/vRog9d+ZRYCxGVZhxlhhsr/bJ
	 VPvOh5bCsXj/1tM53e21pqU4ESZQuexku8p4EABg5kU+qdVUB0F+2OR0gwHlxVU64X
	 CvO1RJmsD2LYSBCInB1QmBlqXj893ECzojJhAdavnfuPti9OWgf/Uq2KrGe/77GfAy
	 k+dYRgO0M8MIM4Jle8lt5ljqQgEzh3Ql6sDKlKllrO97FbKGjDRiElbBCvdjPvjxr+
	 d1TQYBbIaWAGQ==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 8293541835
	for <op-tee@lists.trustedfirmware.org>; Fri,  3 Oct 2025 14:12:12 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F9VKuaiZ;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DIh0ta/ySV31IDAsjscXZdxDAf93kz39y+kPAUa/I64=;
	b=F9VKuaiZMLgsRzzouEJOmneQq1QmQi3uBRskKIMBuihqgDIOuLbgfO2EzlpD1VblKIOSl/
	gCVIKx1l0KxaifZF63QvV6fzXaH87J6W0nOnLnUmCthQXUFN8+/whtFCAUs/Zu4MbEPGaN
	UKXMmUKgaUfqBEHApWi/riqNXf3RnSY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-5rA4uBvgOcypRakxeG1r0Q-1; Fri, 03 Oct 2025 10:12:10 -0400
X-MC-Unique: 5rA4uBvgOcypRakxeG1r0Q-1
X-Mimecast-MFC-AGG-ID: 5rA4uBvgOcypRakxeG1r0Q_1759500729
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so15906535e9.2
        for <op-tee@lists.trustedfirmware.org>; Fri, 03 Oct 2025 07:12:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759500729; x=1760105529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIh0ta/ySV31IDAsjscXZdxDAf93kz39y+kPAUa/I64=;
        b=IRuMtyjNx2fORjo6NOH1H0i0/XvSG3bsYPr40XyLFTiVOOM4WuWjo2Y79qJSDloh5m
         SloeRZ560GFhWdMjN2UZJBdZML8N++6/HKmmGxPSqtUoTDv4+9/yDxzWqWqsUgQKIlzh
         MVPYUds7pCn9XOc1TSbW5CBrBfNZMyyN0xSD/FDzF8LhBszEPoT/9RaXffmyTLxVOYmz
         W5nXMDvdhpJIJIHzszt25v2bWpgSuWrabEaHcLtuqoJxMg2Q5ENmxIYK3ihYuusMQUAt
         QYXqCVf17YQf251n3swF2D4BjmrS/Ok9XVgVy2I8b94xPiN0RkzIStvjmrsReIoqbt2t
         dGiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE/Z526zT5RnksgFzrQ4OVFAdln6jzTNdhm8EAIz1RP5KMMW9HCJ6TezLtpfZhGq4pXLfxMiU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzHIDAxl899Coct+8G0PloYZgBM9Kmm/jhM3ev9xcutDrNVZExl
	U4DGVp3iyNbbCAWNpAPqMPNPoZuvzpe85BOAC8sv1bBDL30A9g+4DEsUX4WO1oSTOXqwNpupGJ+
	fRZcvKWjo/hwwJuZDttq5+ILC6mfFWEPDjUB42sz6DdBIZVCArGiLCHIB60r0zNR7wnpW+pw=
X-Gm-Gg: ASbGncuHLpu56rLynpb4xS54ACbawzPvRwcMmDdlTtJtxPeYWIVE2jCFqfvWrqBKUH+
	oTSTT8v6jO+/qYWK99MtHRYxs0eUjDT/UEY3+kOk/EURcHfYjnHnreUJK0nDFF5t8797rkzv9Nt
	YS+c4Csoqy5YkVXliNQe7O0612GvMjshmpvTne7xle7KqP0TY4O00m1nTVCFPf76NmDv+8Ea5Av
	Y3FzUtgP6BdNJJhG8bewNyvm2lXics/1Njst7+/FJ42wcTBFp9TMgcyZiX6rJI4pbf0j7RfiW1D
	MWGOQEkMGmd7wfNTO4Psag==
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-46e71109f78mr19836935e9.13.1759500729017;
        Fri, 03 Oct 2025 07:12:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvZE78Vlry2HWGKctUpuvV3NYdSpp6VF7NSq0LXvMOwPsaZRtbqFATFnYhybF+GpisNk1RcA==
X-Received: by 2002:a05:600c:1986:b0:46e:4287:a85e with SMTP id 5b1f17b1804b1-46e71109f78mr19836735e9.13.1759500728555;
        Fri, 03 Oct 2025 07:12:08 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e7234f69bsm36548575e9.8.2025.10.03.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:12:08 -0700 (PDT)
Date: Fri, 3 Oct 2025 16:12:07 +0200
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v12 3/9] tee: implement protected DMA-heap
Message-ID: <20251003-majestic-indigo-emu-d9dbdd@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-4-jens.wiklander@linaro.org>
 <20251002-sceptical-goose-of-fame-7b33d6@houat>
 <CAHUa44H3nGgY9q68YRRp5A7Q6Ku3P_URuv+L7H8chYzLAKd8mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="uh2g5nrijwsim4uc"
Content-Disposition: inline
In-Reply-To: <CAHUa44H3nGgY9q68YRRp5A7Q6Ku3P_URuv+L7H8chYzLAKd8mQ@mail.gmail.com>
X-Rspamd-Queue-Id: 8293541835
X-Spamd-Bar: -----
X-Spamd-Result: default: False [-5.30 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[redhat.com:dkim];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	RWL_MAILSPIKE_VERYGOOD(-0.20)[170.10.133.124:from];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.133.0/24];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWELVE(0.00)[25];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[170.10.133.124:from];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:30031, ipnet:170.10.132.0/23, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.128.70:received]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 4DQRZXGJOQ756YPROTPOTVAHOAWJJOOI
X-Message-ID-Hash: 4DQRZXGJOQ756YPROTPOTVAHOAWJJOOI
X-MailFrom: mripard@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/4DQRZXGJOQ756YPROTPOTVAHOAWJJOOI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Maxime Ripard via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Maxime Ripard <mripard@redhat.com>


--uh2g5nrijwsim4uc
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v12 3/9] tee: implement protected DMA-heap
MIME-Version: 1.0

On Thu, Oct 02, 2025 at 02:57:25PM +0200, Jens Wiklander wrote:
> Hi,
>=20
> On Thu, Oct 2, 2025 at 9:54=E2=80=AFAM Maxime Ripard <mripard@redhat.com>=
 wrote:
> >
> > On Thu, Sep 11, 2025 at 03:49:44PM +0200, Jens Wiklander wrote:
> > > +static const char *heap_id_2_name(enum tee_dma_heap_id id)
> > > +{
> > > +     switch (id) {
> > > +     case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
> > > +             return "protected,secure-video";
> > > +     case TEE_DMA_HEAP_TRUSTED_UI:
> > > +             return "protected,trusted-ui";
> > > +     case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
> > > +             return "protected,secure-video-record";
> > > +     default:
> > > +             return NULL;
> > > +     }
> > > +}
> >
> > We've recently agreed on a naming guideline (even though it's not merge=
d yet)
> >
> > https://lore.kernel.org/r/20250728-dma-buf-heap-names-doc-v4-1-f73f71cf=
0dfd@kernel.org
>=20
> I wasn't aware of that (or had forgotten it), but during the revisions
> of this patch set, we changed to use "protected".

I think protected is fine and what is documented in that patch, right?

> > Secure and trusted should be defined I guess, because secure and
> > protected at least seem redundant to me.
>=20
> Depending on the use case, the protected buffer is only accessible to
> a specific set of devices. This is typically configured by the TEE
> firmware based on which heap we're using. To distinguish between the
> different heaps, I've simply added the name of the use case after the
> comma. So the name of the heap for the Trusted-UI use case is
> "protected,trusted-ui".

I guess my point is that, without any prior knowledge of how that heap
works, I have no idea what the "trusted-ui" use case actually is.

> What would a heap called "protected,ui" represent? Protected buffers
> for a UI use case? What kind of UI use case?

I agree with all those questions. They apply equally to trusted-ui and
secure-video though.

If you want to have a vendor-specific name, I guess that's fine. But you
should at the very least document what all these heaps are for and the
subtleties like the set of device that can access those buffers (or how
to figure out that list if it's somewhat dynamic).

Maxime

--uh2g5nrijwsim4uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN/ZtwAKCRAnX84Zoj2+
dk9GAYDf6fryp88Ahl12b+j+v2rumlMEN3n/cHougouDTADzYYFHD5FrzdVXoXCH
2w49Sa0BgPbuh4M8qU3Ly9kSPtLFD2tEJs/iA5V+MezAw2Egx8cvBUXOLP8pdylA
HFFK1Cqtug==
=PVWB
-----END PGP SIGNATURE-----

--uh2g5nrijwsim4uc--

