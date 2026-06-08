Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA8ECD8C92
	for <op-tee@archiver.kernel.org>; Mon,  8 Jun 2026 13:17:09 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id C99A3444B0
	for <op-tee@archiver.kernel.org>; Mon,  8 Jun 2026 13:17:08 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VN2TZUpw;
	dkim-atps=neutral
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id BBDC243725
	for <op-tee@lists.trustedfirmware.org>; Mon,  8 Jun 2026 13:17:01 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43ccdc20e67so1911796fac.1
        for <op-tee@lists.trustedfirmware.org>; Mon, 08 Jun 2026 06:17:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780924621; cv=none;
        d=google.com; s=arc-20240605;
        b=S5nEj+WVcC6rXVPxvSEX7fERedIXRP7WYpliR2I7fg+wQCataCEziMqf4n4KdK6/Mt
         fKWAj8/gxiSebkEeN4yyBnTbbXHd+L0AZy7ZYTI27IvwoVrGrR+W6XpnRDUXsbRFRhd3
         gO/pQyjL5W7IK/V+Z/hqN/HtYHlP4cQTFb6p/s24wm5YQOex1rvKGoBrcKoECZ0c13sf
         OVnKDzSNkt1I0QXw8yyRUNWKI8+TXVR0jRc6HR7ypUL3NuuF1Dmt/J2bRNNwPBVphDdK
         94nnRmn9E0uV/7xZFMQhwn2uXNdOMjtLJ9GCyG2k4OD1Y/zNqfDRgGDlAQVvgNG6RWMK
         0uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AfDmQD3XkqnhyOK6L1IuRTH5e227SPMKiBMcBej6ec8=;
        fh=WyN1UbQQ6DAkZnIHSqT3TEQO+rLDHryS5JPp9R1ccww=;
        b=dRcvUdKV15Oh9LpPbEZJD9S1NiWY0eQBIQwj+uQSSaU1auh7re5khaoDu0Mc+FqIXa
         yMm7kH1z0SEm851kdeQXdrFPfREjhSSxmxz2VV/k7ybUn15Hqf+NyohesWodECeE2u+e
         +kdSI0SgHegikpQb5tXMA9575eiRjJZxTw/YsvbYCpMQN0OEVRyzx7hvuzA4Wrt8qmII
         JZCPXVJmcYxB+Zq0F6OefG2AMfPhhizpAZnEnGMaw/blwMCDM2hxOjJC9zpEi/qYhwUV
         qjxxEabJaELrOxj0Rl12zvSAd/3hR91JWad35Jt91x2qSsM33FtV+UxXAkd5rC/cfIA2
         dKtg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780924621; x=1781529421; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfDmQD3XkqnhyOK6L1IuRTH5e227SPMKiBMcBej6ec8=;
        b=VN2TZUpwS9Og2tk+Asp888MSmXXaKPDHy9jxYchIuPT+F14XCX7wg16XGX+IqriM5d
         LcePdKWye5fUHg8DFPIv2xXCbMFQehhhxm7x0GorxuPFkLjxhqq9+5TNihmLlX4Oo5os
         E/RtDme11CmF/rPiZnmxwfh+VfozAJhYk1ahBUwsyFoE33dcwKSyB6Tb4FLvKPY+/Ns7
         y5N2l4VUp/+LzXZAXeNtLS4yKI09f9v+zjAxAesOkPdfFl2BEzS4DJUiUAeOlYCYOlDr
         NYjtf/Bn33h5QsWQXttDawe84DZ5ZUh00lWuom9ZQ4GffJ8ayQoFRQQv8+urJDbx3Hr2
         /03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924621; x=1781529421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AfDmQD3XkqnhyOK6L1IuRTH5e227SPMKiBMcBej6ec8=;
        b=PkwUzcoMwmnu/F9SC/vzWdsZBXUS4AckAEBoiL9RVtqM9H2/VDMaxiXDCDtVSYlE0q
         PuID3JPiuiSxh3RrVneCng/GHplSVVA2MmrFNCU22n9cK7ZFPvxw+ZP17fzAGAlSiLUn
         YVNCpQscakPuqnTNJM9rILWyi+7O1rv7k45c9gWj5o/2Ikl6q62w/01aP9GlS0xbaFXb
         OA9b6AOgIomJvGzzxzo5h6mPQVzZO9E8pGSkF34gXUnWHl3nRPfSth902t1HNGo342gu
         G03okSoHMi/+wWuVkDIA2bRW1vv03Sm6WwJAv9CY2du210N4iHdvBAuHrR7WaqF2ULAf
         3Kqg==
X-Forwarded-Encrypted: i=1; AFNElJ8uhb0U+HY7hTEsFCg+U/F/trQVr1wXHF9ZqIru16OzUBCrCdQEq+FWOASXYXaUjhybh4mJcZ4=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YyGY+19qRSW2gj5p1mLMAbap+zRCdVTsOS4EbuB4N7IVhNsC7cC
	dD4LxpeKhzV6TDtfl+Lm7EkRwbnNXSdLB3Oa9P0SnEr3r+Uc4yYKpmb4dMZJqROf2KP96waiWev
	xpHaIVseSRQJI+0JjwguGwZetJ4qVLvhDDjZxDX7q/kJ/
X-Gm-Gg: Acq92OGTt/HXoL8bXDucAc0iqTNC2cvxwfeQyre87hdXYA84KYUPHTX0aiVWSYczqZK
	ig4wz6UP00SflIpgNpjV+3yEzwzae+QJ2Bk5cSan8JOx98DpqaoWiOyaM3hzIGavs4+HDPworwv
	MpG1kEFsmyv8ISF1Dimyn9ShfBDJkUlwZP5WNSQkaXJcPci0fRYCFUUtgthIeKFFDGaAv85wX8w
	2LQcJgfidz43M+YHuOyi9AukVAglLnmzeL+Q++1DKjtP8Ra473q0xRbWTrZCbB3jb7Gg4gis1F1
	3YN50oTyXPp0a5xTl//5CcpWj0BGDH+YluxNU6LuOtSC+wjP
X-Received: by 2002:a05:687c:2346:20b0:441:b0ff:132a with SMTP id
 586e51a60fabf-441b0ff148fmr1273772fac.18.1780924620975; Mon, 08 Jun 2026
 06:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260526151934.3783707-1-smostafa@google.com> <20260526151934.3783707-2-smostafa@google.com>
 <aiK6lgW5YFWSMTxf@google.com>
In-Reply-To: <aiK6lgW5YFWSMTxf@google.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 8 Jun 2026 15:16:49 +0200
X-Gm-Features: AVVi8CfBberieRGRzkn_uKkTDDGnJq3OimnjM0eDLOzbP178qkP9W2-4m7NvonA
Message-ID: <CAHUa44FO02DKqqNeFuRfx8bQjwcNRfPMF2=8MdjMUFp6vYUpNw@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] optee: ffa: Add NULL check in optee_ffa_lend_protmem
To: Sebastian Ene <sebastianene@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RWL_MAILSPIKE_POSSIBLE(0.00)[209.85.160.44:from];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.44:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: BBDC243725
X-Spamd-Bar: ----
Message-ID-Hash: OLMC2TQB4QYE6KN6MU2AX3A4EMEWB6W3
X-Message-ID-Hash: OLMC2TQB4QYE6KN6MU2AX3A4EMEWB6W3
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Mostafa Saleh <smostafa@google.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/OLMC2TQB4QYE6KN6MU2AX3A4EMEWB6W3/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Fri, Jun 5, 2026 at 2:01=E2=80=AFPM Sebastian Ene <sebastianene@google.c=
om> wrote:
>
> On Tue, May 26, 2026 at 03:19:29PM +0000, Mostafa Saleh wrote:
> > Sashiko (locally) reports a possible null dereference under memory
> > pressure due to the lack of validation of the allocated pointer.
> >
> > Fix that by adding the missing check.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index b4372fa268d0..633715b98625 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -698,6 +698,9 @@ static int optee_ffa_lend_protmem(struct optee *opt=
ee, struct tee_shm *protmem,
> >       int rc;
> >
> >       mem_attr =3D kzalloc_objs(*mem_attr, ma_count);
> > +     if (!mem_attr)
> > +             return -ENOMEM;
> > +
> >       for (n =3D 0; n < ma_count; n++) {
> >               mem_attr[n].receiver =3D mem_attrs[n] & U16_MAX;
> >               mem_attr[n].attrs =3D mem_attrs[n] >> 16;
> > --
> > 2.54.0.746.g67dd491aae-goog
> >
>
> Thanks for fixing this and for including my other patches in the series
> Reviewed-by: Sebastian Ene <sebastianene@google.com>

Please add a Fixes: tag. This patch is independent of the others in
the patch set, so if you send it alone with the Fixes: tag I'll pick
it up.

Cheers,
Jens
