Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641C3D4A613
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 08:44:47 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id A927E43295
	for <op-tee@archiver.kernel.org>; Fri, 16 Jan 2026 08:44:46 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=O4xIlOeH;
	dkim-atps=neutral
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0F3E843295
	for <op-tee@lists.trustedfirmware.org>; Fri, 16 Jan 2026 08:44:26 +0000 (UTC)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4042cd2a336so1158543fac.0
        for <op-tee@lists.trustedfirmware.org>; Fri, 16 Jan 2026 00:44:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768553065; cv=none;
        d=google.com; s=arc-20240605;
        b=UGA3DW7ILf1GyT5GSeJYctW5fk0oZ9MNKIwPTclIIuXIweYVSBLv/6pBDSsidPP/cO
         rbGNIdQfcq/J+alinWZfS599a+o00M0py/6B0Ba8PhgNXaCe5mGMb7z8YIp22Pzsz07T
         9Jg9co1ZCg23biDQUifcPO6KkuRdGsMOrybXeHOK3bKTQz+gjGh6eQppVXhXZCOUWode
         oakiIRUtqiwjY31fKtIB6kYvI7ZpuFd8F/Xb5JZJb/AbOsLPL8UKnjSTL0pW1x/YN43l
         SEuHETds8+IXm2mpGV6WyaAko4fJFKAXudhzW9tRgHm6nOQ/Yk8QXAXOOy6l4Bgs7jRA
         fgtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=liCV6kd2tqW62GA4YQ3LIjhazgx54jh9SubL9alEtyI=;
        fh=G9mV/jtmdbLuho/WJouPPq+GmcD617ljLqzCcXaNax0=;
        b=Mg/sPej4yM0EcrD82WoAkgQGFFRFqi2yxk4ounqDfQCIOl4WyMbmOsWJgeQqoqelpF
         azmS8RzglJ8m5LQ8nedxyFwXauwUEIlXg/msFDG7HW2l6mFO0NXTlnoPwLtO3u/5bN4Z
         HWm8DK/iljvWjRvNYTqJGpxIjhjsadXfD+hOFZbY2UWfgx1lumLW9dJDEqJKW4N4oBn5
         +vv4tUaUTFj31BVj/uQeuJ6CCD72tgnoV+dqy3BrT9tT1b61FAqCyCRdvbzpiLm2ndGj
         mN9F70fie3mtWIIAk04D8GA/NlePZt6xmi6+dK+qxW4APr11efaDPVHkN4MpJ1YdhBIF
         iTKg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768553065; x=1769157865; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liCV6kd2tqW62GA4YQ3LIjhazgx54jh9SubL9alEtyI=;
        b=O4xIlOeHpwjNBpThmVKWoS9T91cz5JKd2UovxcXs7no4Fs3VhN7yT8ONe7eR5yI8lo
         KQnE+3imSGIw+/oXqs6Euy8Pyo3XFJfLAm7ZozoWJiqvu8IOlfc11zbD7Pb2OzQbjjl0
         0+1AvYOPLArTWH2KKj6zP6/XOpQrrtyJy9XJx8p6FFODpl9MsBAHJ0qRfp4mBHSbO/G+
         ZQQMyvmLg7RHz7+u3H2bmi8pZviFzuQPaMxlQa6rxpHMzmkQrLS0xeGl80aJqP0LBqlT
         y/oG2SI3yw+hnlA3hzqPcoBE/P1OCAmh6D2zxnFOHDP9/uX0Rylc9XlCJQKBk38VXQ47
         OlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768553065; x=1769157865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=liCV6kd2tqW62GA4YQ3LIjhazgx54jh9SubL9alEtyI=;
        b=Iex/o2Nkqh8ygnZlCQeoLychVFZ5RIK428mJRqhThZgXuaHfM1TbroRyLGgfhxRR6Y
         EXlI3xXj+eynHl/2WV0tD8sT19gvMJBHjt9jrWCvRL2BAlgOzq3K+sUFqlUWtiHJRSim
         /ifzsvSptOsbG9SSH6onRubY/ihwuJ8YSxStbqUrR0QihGw7/N5dRqKSTzTBHYCJSG/X
         48I5Bl+ndur+6tH9lrdeX0lpjK4949YwAoCcXRylUmLk3Bh07Dh1A4orEjGfBLQn3SJD
         kk7qz/q8rjH5VGxawdjh+EbeG1a4VqqTtInHtQ4NXoqh8Dyom1grWKbxPGByqyVgjcDR
         MnFw==
X-Forwarded-Encrypted: i=1; AJvYcCVuixqvK+hc+iAwQu49god5g9HkmD9WPIuQXZgOT+sELAWFlXyduyGBNTOeNNhXB9K6LIxMugU=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxl3nTrEGIAfwUko8VouUAQcKaNyJCRow0JF5h5hesIb+OzRapU
	2aRZIrBs3SHzSVn2dGBF5PBtnlKIDPqoarOTKSVVC6X4tgSccFiW07cY+whOPTU6jHAbboSU0YL
	rN29YOBnIHvrAecHMk+zkUAqrhWtT+Xl7Ackgdh6RlsQP
X-Gm-Gg: AY/fxX5lMClXwNAf3w8judTTDISqjWVUaFsCmK/9xZOqZ5N3z6owbYO9YjvAQUh3tzT
	cfYKeMlSEgi6w0QvwdtgwvqJxrbnhMLQwat9mD3pA7AZh0ExCe/Fl0Ao4I6BQJdXFTiugFs8bMN
	ZAWJ9jJn4JwU9IwBiG0Cy5oxu4Rw7MHZwCxKM7QRbciEw7cjun12NmxIik2grS9Re4cBZaV4xlS
	h/WF0Odb9TLAOJm7CUT9bASz+gBT0QkC8dLaQFRLHPF9JFSoxu6nsuMU6FBfrMa53NIEza74Wg2
	iKPBe0hjSxnGvao07AyYbndTqg==
X-Received: by 2002:a05:6820:4dc7:b0:65f:5bc0:7b2f with SMTP id
 006d021491bc7-661179ce8c8mr1121321eaf.46.1768553065299; Fri, 16 Jan 2026
 00:44:25 -0800 (PST)
MIME-Version: 1.0
References: <f9c34212cb33775754b3a1f4231f181574c99aad.1768486765.git.geert+renesas@glider.be>
 <aWnICDluQBNU-8C7@sumit-xelite>
In-Reply-To: <aWnICDluQBNU-8C7@sumit-xelite>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 16 Jan 2026 09:44:13 +0100
X-Gm-Features: AZwV_QgrnSXzMDXr31t5zGW_h026gRKMfNech4wFK8Y5Ua6HBumAYdgGM1khe4Q
Message-ID: <CAHUa44EoDUqebvuz6ni5dKWWxpzO00QJomyQwZPoA-ntKWYHyQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Mark the OP-TEE mailing list moderated
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.50 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.48:from];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[renesas];
	NEURAL_HAM(-0.00)[-1.000];
	ALIAS_RESOLVED(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DNSWL_BLOCKED(0.00)[209.85.160.48:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0F3E843295
X-Spamd-Bar: ---
Message-ID-Hash: CZ6RZYSTR7T3QWYBLA7JRM6ICSCN7UO2
X-Message-ID-Hash: CZ6RZYSTR7T3QWYBLA7JRM6ICSCN7UO2
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/CZ6RZYSTR7T3QWYBLA7JRM6ICSCN7UO2/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Jan 16, 2026 at 6:09=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Jan 15, 2026 at 03:22:42PM +0100, Geert Uytterhoeven wrote:
> > After sending a patch to op-tee@lists.trustedfirmware.org, I got the
> > typical response for a moderated list:
> >
> >     Your mail to 'op-tee@lists.trustedfirmware.org' with the subject
> >
> >       [...]
> >
> >     Is being held until the list moderator can review it for approval.
> >
> >     The message is being held because:
> >
> >       The message is not from a list member
> >
> >     Either the message will get posted to the list, or you will receive
> >     notification of the moderator's decision.
> >
> > Mark this mailing list moderated in MAINTAINERS.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> > v2:
> >   - Add Reviewed-by.
> > ---
> >  MAINTAINERS | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 13e2f2fdc248ec65..9c988eb1cc86628f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19578,14 +19578,14 @@ F:  drivers/net/phy/ncn*
> >
> >  OP-TEE DRIVER
> >  M:   Jens Wiklander <jens.wiklander@linaro.org>
> > -L:   op-tee@lists.trustedfirmware.org
> > +L:   op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
> >  S:   Maintained
> >  F:   Documentation/ABI/testing/sysfs-bus-optee-devices
> >  F:   drivers/tee/optee/
> >
> >  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> >  M:   Sumit Garg <sumit.garg@kernel.org>
> > -L:   op-tee@lists.trustedfirmware.org
> > +L:   op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
> >  S:   Maintained
> >  F:   drivers/char/hw_random/optee-rng.c
> >
> > @@ -25693,7 +25693,7 @@ F:    include/media/i2c/tw9910.h
> >  TEE SUBSYSTEM
> >  M:   Jens Wiklander <jens.wiklander@linaro.org>
> >  R:   Sumit Garg <sumit.garg@kernel.org>
> > -L:   op-tee@lists.trustedfirmware.org
> > +L:   op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
> >  S:   Maintained
> >  F:   Documentation/ABI/testing/sysfs-class-tee
> >  F:   Documentation/driver-api/tee.rst
> > --
> > 2.43.0
> >
