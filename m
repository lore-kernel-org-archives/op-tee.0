Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F14CAC5B8
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 07:54:59 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 076E141B9D
	for <op-tee@archiver.kernel.org>; Thu,  2 Oct 2025 07:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1759391699;
	bh=WSAv+LklGTDBmAJg9JWePc59MIDbYN30xXPqFRoxrGA=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=C2S5XqrhRJPqSmJ5PkMTJum7HsMXcH/xK4AwC0q/Fwq41pum73HmwpT2lys0KKgTi
	 JderGogZQJdOdwmA6WU7U33e+Ud7Crb9Q3hhUOxSikEH+tNIQPJVxSIbu5bg4BNlc3
	 AdKC8retstXTXyvYHllEzPJY5RYp/Luo58P+SweenGsUu/3dvYyJr7r2V+rr5UYcIm
	 pYCIpC0MqSCBRx7ySMrHMkH2K+4kjE93TYnRZ3oeo8k/GDRrqAPGUv+TQoizHHaTSy
	 kBzkB2VBGFd7B7HXpDybCtjyg1oRwyVmGVaSk4IRY4SvmsZD5dgR/WjCJXiiEol2BT
	 GKsdNIpoYGLEw==
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 22EDB4187E
	for <op-tee@lists.trustedfirmware.org>; Thu,  2 Oct 2025 07:54:44 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SmUTP5N6;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759391683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f5NgAjs0FgUvOjNKCgOViw/s6WyhuboPXgN8L2oduk0=;
	b=SmUTP5N6n2tC2XO2a5xgoxLAO/X78ISI4HrcL0iGg3wVcJ3KGtpk3A3cjR/IJfgSZgj+m5
	u0ROPESKRQ/Mfee6vYODGlojPB+PVJy7bhmQE/HVwxf+xM3uGpZK0FaWC5LJ3z71NyQxAk
	vYlGWk3e7cNRH2RAOMUbQW1kLJzCuGw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-XYR-s09sOxa1xJvBBCouCw-1; Thu, 02 Oct 2025 03:54:42 -0400
X-MC-Unique: XYR-s09sOxa1xJvBBCouCw-1
X-Mimecast-MFC-AGG-ID: XYR-s09sOxa1xJvBBCouCw_1759391681
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42558f501adso338079f8f.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 02 Oct 2025 00:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759391681; x=1759996481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5NgAjs0FgUvOjNKCgOViw/s6WyhuboPXgN8L2oduk0=;
        b=NUwY+U3O0Cyms4eTZiLOE22q3o5QGDB0oCxy1hyohbhcBfeQGP9/ZfuNLYBL+/khOu
         Wfs4/ciMF3V7/eKW1GH91iG1b2B/ms4nUJz6aP+pGzgkX3XWUHRjaktwu8D3l6b0ywbn
         83ALlhW0Ns8huPoETo0MATZLIPzExg7i4xzkmwMDhP82dblAoRmYDSUuhd17M4FzyGOw
         Zm9BVXKSvq2g2DS7krVA3hhVYfkoLQfI+znOAsne85pGEj1POQyj18HA89OiRU2aK0GC
         MrOGAQUq6zpD8iqU64nD4vwd59A28yia7DBhYH1Hi246j8L0+IROLY3gZMtua2fXn4v0
         ktZA==
X-Forwarded-Encrypted: i=1; AJvYcCVAeJiij5JuHn0WvkWkIhDlTShpyhTm8LymI2WXMT+fuC24XqoI2FChpU4A8QYVXC5QfF5i5iM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzxAopBSToomybpQz64AUuq/7d8a14tDhhcbafqhtGOtfePaB6J
	paCP9b6GK3K5cXxzykX6fHjCY8JrGcrKbT02QR3J3IdOVwzQy/P1ZxFTg0wNl8X+IsHkytBx+jh
	PXJP/ZInBAqgtWWFPsxynKbx4Pfz9+Lx+1scGsP6nipiHtbP+YNf9HCYR0l6Rjr9wnE5OiaM=
X-Gm-Gg: ASbGnctPJvwoWmvqseoUK8wexxmPpXrhLut74qn6tLMfqzghGDjSRTVJCv1Wy4rdKS3
	h33W9r4OSRBun+NMjWYVcPQMosPpUu6QzHNe1DEFmtpgY7gyiXZU6cG/EiwtmGimR8byKDeiLHK
	iZaPg4TiMk4p0fv9RaDvIUFzOqPA6fF18lfcwrO3Lom0C/vYsMX/ggeBq22pkOwlKSeIGvbK+Oa
	leb8V3wnh0YD3x6CGmJ01WIfxvIL9HKLoUf9x4E9nxrDzefy0AcI65HddaHgFGuqLrVdQ6Q/Pex
	12I53WNPtFDtXtKerfyU/Q==
X-Received: by 2002:a05:6000:4282:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-425577f4cb8mr4951728f8f.14.1759391680677;
        Thu, 02 Oct 2025 00:54:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKgb2wuYS24zodpwDlxRHEFq5J/MXUUrEeNEVo0zphJwnjV4MGibFNyYvpxnYvHco/UT9a7w==
X-Received: by 2002:a05:6000:4282:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-425577f4cb8mr4951692f8f.14.1759391680190;
        Thu, 02 Oct 2025 00:54:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm2484557f8f.26.2025.10.02.00.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 00:54:39 -0700 (PDT)
Date: Thu, 2 Oct 2025 09:54:39 +0200
To: Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH v12 3/9] tee: implement protected DMA-heap
Message-ID: <20251002-sceptical-goose-of-fame-7b33d6@houat>
References: <20250911135007.1275833-1-jens.wiklander@linaro.org>
 <20250911135007.1275833-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ucqtnbt2ioahlqrj"
Content-Disposition: inline
In-Reply-To: <20250911135007.1275833-4-jens.wiklander@linaro.org>
X-Rspamd-Queue-Id: 22EDB4187E
X-Spamd-Bar: ----
X-Spamd-Result: default: False [-4.41 / 15.00];
	BAYES_HAM(-2.21)[96.27%];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	DWL_DNSWL_LOW(-1.00)[redhat.com:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:170.10.129.0/24];
	RWL_MAILSPIKE_GOOD(-0.10)[170.10.129.124:from];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.221.69:received];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.linaro.org,lists.trustedfirmware.org,lists.infradead.org,nxp.com,gmail.com,mediatek.com,linaro.org,collabora.com,arm.com,google.com,amd.com,kernel.org,qti.qualcomm.com,ffwll.ch,fooishbar.org,oss.qualcomm.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:30031, ipnet:170.10.128.0/23, country:US];
	RCVD_IN_DNSWL_NONE(0.00)[170.10.129.124:from]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 64LZV32TEY2BU6ZLIDEURG3443CCJPWM
X-Message-ID-Hash: 64LZV32TEY2BU6ZLIDEURG3443CCJPWM
X-MailFrom: mripard@redhat.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, linux-arm-kernel@lists.infradead.org, Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, azarrabi@qti.qualcomm.com, Simona Vetter <simona.vetter@ffwll.ch>, Daniel Stone <daniel@fooishbar.org>, Rouven Czerwinski <rouven.czerwinski@linaro.org>, robin.murphy@arm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/64LZV32TEY2BU6ZLIDEURG3443CCJPWM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Maxime Ripard via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Maxime Ripard <mripard@redhat.com>


--ucqtnbt2ioahlqrj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v12 3/9] tee: implement protected DMA-heap
MIME-Version: 1.0

On Thu, Sep 11, 2025 at 03:49:44PM +0200, Jens Wiklander wrote:
> +static const char *heap_id_2_name(enum tee_dma_heap_id id)
> +{
> +	switch (id) {
> +	case TEE_DMA_HEAP_SECURE_VIDEO_PLAY:
> +		return "protected,secure-video";
> +	case TEE_DMA_HEAP_TRUSTED_UI:
> +		return "protected,trusted-ui";
> +	case TEE_DMA_HEAP_SECURE_VIDEO_RECORD:
> +		return "protected,secure-video-record";
> +	default:
> +		return NULL;
> +	}
> +}

We've recently agreed on a naming guideline (even though it's not merged yet)

https://lore.kernel.org/r/20250728-dma-buf-heap-names-doc-v4-1-f73f71cf0dfd@kernel.org

Secure and trusted should be defined I guess, because secure and
protected at least seem redundant to me.

Maxime

--ucqtnbt2ioahlqrj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaN4vvgAKCRAnX84Zoj2+
dh5DAYCtjelmpXHr50Khpzx9gOlMaEclQyCYsx0ccN3NkEfrV19Dn1EcsuWOsMM8
FnSLI0wBf20rXmWeBPjWcAcR1B39X7YSjO3A7FgWI4aIrvvEGff3VbIQIgq5c/ST
75QC6+0wWg==
=iJBu
-----END PGP SIGNATURE-----

--ucqtnbt2ioahlqrj--

