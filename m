Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2815CD6554E
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 11:32:02 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5FAEC4FF3E
	for <op-tee@archiver.kernel.org>; Wed, 17 Dec 2025 11:32:01 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=D51uTWN2;
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 09DE341B70
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 11:31:43 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so8861388a12.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 17 Dec 2025 03:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765971102; x=1766575902; darn=lists.trustedfirmware.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=78cTxJHCsv/xK1jDLwIG+9Oi3ISEiAwpLGtVD90ebCs=;
        b=D51uTWN2528c4bIUhJte/ZKxd0v+yEeUDJZsrHuaHS2KNC9jRdi3Dvck0AAjyQIF//
         Zyp0tMauegU80to/gTbXmMBQ9Yxoi6W3cbo9QOs5/hUxfTpGFJoG1c7v2wkDwR9MBt3s
         unvolAR2NnZmkuFa7bCTjsd1CACKKn8Mw+xmtQ6DpM+tPuCBy4gKusWa92fr5rAz9CX5
         Vwf4gSPtt0Y/Td9EOBmtOmlq5aZMpioeahpXXT7VaE7m+wcDbpljYcUED2GRVQgk9VRl
         rEK0utII4rxfQDbr6Q2EVnyMHvveYDID4bvkIQd6UxBkZlS1jd0lu2GeDL8Poj0Cp28u
         qflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765971102; x=1766575902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78cTxJHCsv/xK1jDLwIG+9Oi3ISEiAwpLGtVD90ebCs=;
        b=Dus23dfOMSPJ9z3cG2jde5yWDi3/JqR9w7Ii4ToCZO8UW8OSngQJlAJGBEexMS0yjo
         wug46FRfruCrYhu15JpleAWinQPOwv5qQqNx2ZJ+GYThhV6H7VZJJGEdQUYwbcTE+215
         RwLwKitlr7zXPUIHOs/mbdeinM+rnt4Wt0o9+aKlj4uM6q1LMTuUknh/JnHr+hLAHEEO
         xrUiDd2drRsoLrjB3AURU3isWFUSX+auFONwvROVaFm78dQ2y8oD89U2IPoj9L3tODam
         P3KvtBL7zH+BMr2b0dBYNISfjG/v1TAlYsqHCkcHbhppSKDvxaCk/B5ZDqiX/va66+UU
         dXJg==
X-Forwarded-Encrypted: i=1; AJvYcCVViiGcMDqdDTTLZ94s4gcp0w8mSgO75Wv93ULSKvW1UXU70U3NtjlKo3gzDMIMn6bQ8kKqYKc=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YzxYQ5Klhm/12RLHTYyTxB1SLlgmT1f/xdFwPw/PZ1NgolPrMuv
	Ry61mYCQzGol4mznRqi+tc6baEZrWW6leC/yRGtYq2YCmxOcEyMi1pBW0a4lfa5s9n8=
X-Gm-Gg: AY/fxX6UXs6FTYIEOb1ud1dk4kWtaD5QkIhxxpfsiRaboDjlBsmGL7D7nVAHEjkhuYY
	dpHzpR0FBNeh9jePoiJ8Z+Vv3d5LrB8sO+R/m4G3OJAY6Wsopau+YU2ekyY58hxadtfqp7yqtUc
	hC9jRimXtBGT563xeXAhhOgPCEs/mVtanLg+jkLz4EMLprIDftHPgZP+WL1DZkdt+mDLncIuowi
	irF+DHadEBSsE/Q3YVJmxbVtBp6/3f99R+IY/Fy8LB18LrFAj006U8VVPs//fix2s5CEIJCoEjj
	/O4hwu9iq+ClW7q45WYcbp0esZKrcgKBHSgyznR/h6Pty95mEu264vmyp+D2lUDPLJKt/P0C5xR
	TUtzoJv4LbgDsjPozg5P2Iw0TK7uSPCRwIBW3yFzRINxnOnTjdvsVkLB3iuPGk6FDtD1PSeohAa
	6uA8+BL2h+PsXHqfop
X-Google-Smtp-Source: AGHT+IECaoncq7E095S5qUjiDN4y1Wig2YzLiFsI7DSFbXV/lmDd5O1PhEt9xKUtf8eQ85yCs5CppQ==
X-Received: by 2002:a05:6402:34cd:b0:64b:430e:ecdc with SMTP id 4fb4d7f45d1cf-64b430ef443mr1276653a12.5.1765971101875;
        Wed, 17 Dec 2025 03:31:41 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-64b3f4f57acsm2182781a12.11.2025.12.17.03.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:31:41 -0800 (PST)
Date: Wed, 17 Dec 2025 12:31:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH v2 02/17] tee: Add probe, remove and shutdown bus
 callbacks to tee_client_driver
Message-ID: <vp4exzgqj6req46c5n722njtehxdmxzbalqgpl4up4sqknk4pi@zcex6okxvesj>
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
 <667477a172a4296ee060508a5778be7b0d2ca375.1765791463.git.u.kleine-koenig@baylibre.com>
 <aUJv33t293HnUMiU@sumit-xelite>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="elvq6uuzn364ydf5"
Content-Disposition: inline
In-Reply-To: <aUJv33t293HnUMiU@sumit-xelite>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	FORGED_SENDER(0.30)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.208.50:from];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,ukleinek@baylibre.com];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.208.50:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 09DE341B70
X-Spamd-Bar: ----
Message-ID-Hash: YAHVEOCVI3U75I7TEGIR32SJCC44KSQE
X-Message-ID-Hash: YAHVEOCVI3U75I7TEGIR32SJCC44KSQE
X-MailFrom: ukleinek@baylibre.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/YAHVEOCVI3U75I7TEGIR32SJCC44KSQE/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>


--elvq6uuzn364ydf5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 02/17] tee: Add probe, remove and shutdown bus
 callbacks to tee_client_driver
MIME-Version: 1.0

Hello Sumit,

On Wed, Dec 17, 2025 at 02:24:55PM +0530, Sumit Garg wrote:
> On Mon, Dec 15, 2025 at 03:16:32PM +0100, Uwe Kleine-K=F6nig wrote:
> > +static void tee_client_device_shutdown(struct device *dev)
> > +{
> > +	struct tee_client_device *tcdev =3D to_tee_client_device(dev);
> > +	struct tee_client_driver *drv =3D to_tee_client_driver(dev->driver);
> > +
> > +	if (dev->driver && drv->shutdown)
>=20
> Is check for dev->driver really needed here? I think we only reach this
> stage if a driver is associated to the device. Also, it has been
> dereferenced above too.

Yes, this is needed. See device_shutdown() which calls the bus shutdown
method also for unbound drivers.

And no it has not been dereferenced above, to_tee_client_driver() is
just a subtraction from the literal value, this doesn't count as
dereference.

> Apart from this, rest looks fine to me. Feel free to add:
>=20
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Thanks
Uwe

--elvq6uuzn364ydf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlClJoACgkQj4D7WH0S
/k5Phwf+OWVItzpcIh3xQPAxdMWO3jG7BN1ccAJxoK35aGpB9Mk2NHydZNk382vs
5iGMyDQqb3/IUyEkMrWYuwes7KRhgy3NK9FL3LpANUs2opm2LAcRvHX2YKEbRtH/
lZR+2lVdmxG0W36Ljk3TxKr2YTBOzoJ3g6Q1J32G4tiIKqpXce7aTNbzprfiiMox
cU6xdPstwXJuYVl/Ghmo0xk0YHJFidIkeo+BytqrhSSLzWQvmIpxNA1tJnc4klc7
6nEeiFAFD3HqcOVBEs+KJ+FuuQsgaLYyMtOk+Pp2WkmxXAFrqeXwVtl6HDg1C52N
TbyAUIIDcd97n4bMw062yampoc5b+A==
=DKlb
-----END PGP SIGNATURE-----

--elvq6uuzn364ydf5--
