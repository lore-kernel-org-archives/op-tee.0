Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08128FF885E
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:43:28 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 5B4D544D5B
	for <op-tee@archiver.kernel.org>; Mon, 27 Apr 2026 13:43:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QqtxrbOK;
	dkim-atps=neutral
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0031943296
	for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 13:43:21 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d55b97f358so6770583a34.3
        for <op-tee@lists.trustedfirmware.org>; Mon, 27 Apr 2026 06:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777297400; cv=none;
        d=google.com; s=arc-20240605;
        b=EHcQwvFCoyOH/uXZCrPO4UqJz0py+x3ISeTIGRnBmxp4AMilU1zH+uJGvpOONPIXTZ
         CEdfS3Tmlf8A20ZQPntA/ucCibOHezGqFhweLcz54q/x0/QeAtCFF9hHOWrM5AHAMbjs
         tLpRVNyKthH6LjnfD37zGdA4QNYG/gR8v2DadJFzym46gFafEYS3xrbHVQ5bUTEVrxcW
         hLX9QzEmaZLvL8p8H7UmAjmH0M064w/xFoTuRyWnuCemJ+UkdF4psswATLvMyHA7uLox
         TqIKXOHR5UUoUyEczuiZQYQ9KDnPMy4twzKitljmN2UssJrsfaH/o7AYH3PV4ZOamJ/H
         T2Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7tX3hBko2wknlJz0Ljhs3EqRrS2SBd6VfW/G3hGWj/E=;
        fh=KWSxg2pMvp1P18lYFkxQE+K/5sw7R2qmcu0H0aXcBMw=;
        b=jUBtN/gMzsLuXxFOrWdCPdIAkXZL7TfLJslX+JqREACb0B1YIX3WrbSiFI2gU8o48q
         8RzZnOj0m7wHWQENz9S73XWn0VEhLKRc/Nnsz90Set7b0t3wv58nQOfSg1/ewKLb37n9
         CY/OC4pBcz02L2fWY7udXqf+j8Gkagbaw1wIC0hMYN6kjYSW4i0Ds0vbIyJWC9UWzkmF
         hQGKRaU6A/7UTL1LfSL7nvRFFmAuVofe370mVfclIIZdko+qCo+8OKymMpoiBE70koV2
         JHI9rBfbOCqJjwvm7ctx3nFSpCQHBH1PU9DuFxRJOxRoZ4VJ1pf3uj/S4QgYFOk9I8kq
         oHBQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777297400; x=1777902200; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tX3hBko2wknlJz0Ljhs3EqRrS2SBd6VfW/G3hGWj/E=;
        b=QqtxrbOKe7pBRzjAW+N4m3tzpsEhUzZFooIjsYDTb0lb6eNaJfVY7SR0gVJe3fuc1y
         3XTTIBXrDgygSQgD2/ja62okZXScYuD6db/GZOIudt26HmtM0ODVRrRyXT2j3StWKE5O
         i5p7i2In8dc5fjy8merafiua2zifg+r943n3KohGsbPKyI8tR1PBSrv8vWlYM8lLnUzg
         t+B1Vk23IuvBQ1PFNkhIdcV/DMAtTUddfNiStHeZc876Y3j2N3rzcvwT1VEXSso/7KA7
         I/23BE3VE7O2BQ7LeJ0ttk89Ns+L5WOSmWiycVPNBzE207kk7N2FGD9Ir6cH1i+mTmAc
         aekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777297400; x=1777902200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7tX3hBko2wknlJz0Ljhs3EqRrS2SBd6VfW/G3hGWj/E=;
        b=LtLy0B2PORPgvK9tBLgmpTnFUND4/RcNmAnZVqy/Pe8fkZgnOOGfC75181fMHSd+GW
         uJF1ULvtQRMp0d06FMX4tZAdbUo8iFXz5daPfQxrtQKsMaKb9KZn+793mCxKKaX/5Lo2
         Bs0KtZl7khZkYN5y2BsDyyHBLjHtbmzMDOILjsrR4xQDYhW+s5IlpQ2Oo46PAY9EssIA
         7iehVMwlcCARcAEuhwsUpL/i2vOd88GC7Jr6jHEwdU6bfYjV/si/0R+fkBFbjbAMYrXp
         mITLqclhKKe9P25uugj6E1y6kLSoRsMjMf34EcdWEy4nJGrP+90JeLsBaRhflL5d22Bk
         s0Yw==
X-Forwarded-Encrypted: i=1; AFNElJ9EGRcXef3Qg0kK3IbSy+3STW3BXXHtGgrMu7lP4igFAP8O8B0ni13DZ/Je9+39NA0GAdKy7IM=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0YwkACbnGu0ziRl2zfr4FgrQLX3jE60vJyn9q/Tv+OPhxUIrSvsU
	NO3NM/Dh8vSsEldCDCRew/PKgV/z3z/FH/Btjfz4IJIKhmBadIDJns+hxyuYosaRC8KPkEWYmhk
	srxW7Ox6SkddSDFfnQ7J9ukxKbLmZpsZDQFgmEy+pSzeJ
X-Gm-Gg: AeBDieunprCCqWTBSdS54hMG7JvzKVgrGfEBdM4i4gfFEDcROA3TMgU7bZTXT61I1MR
	dFiZfBJxsQHpZgWWa/PsirOM+DTX0eOP7G2ucwj8eF0HsAWJXQHCtaek4Tj/pnnqIaqcl7TAAkf
	RTmz2uErANg8E6ZGQOz6Fuxo4cYOzRTJPAtHU2ZtTIJJozifleFjzxMMgPM7gfDv50/6nIgX49U
	7OLt+CtzvuGCjGi1Sw1fj8XiLq30E/fZFLRUtPZ5vLh25TbHCCe2K/0QP7qytDNBwqi27JqVWus
	W53EU7MwGlr6VRQVxEFtwc2SYLZo0JPEs4nFX4JOpeW/waIT
X-Received: by 2002:a05:6820:2904:b0:694:8ad6:245f with SMTP id
 006d021491bc7-6948ad62cb8mr18203797eaf.43.1777297400295; Mon, 27 Apr 2026
 06:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <6dce58425a88ec3883c7ebf42d7ef367d68b6911.1774597729.git.Rijo-john.Thomas@amd.com>
 <d5b6d46d-4f35-4c85-ab09-99ab5aa9f8f0@amd.com>
In-Reply-To: <d5b6d46d-4f35-4c85-ab09-99ab5aa9f8f0@amd.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 27 Apr 2026 15:43:08 +0200
X-Gm-Features: AVHnY4J2PiG3wLCzdc2Ifp-v_sUK5yS7Hb0SFbdAov-Nb4UU2YWY1KFaS2asezo
Message-ID: <CAHUa44EKNSRY+94Y-HzjCcdVX9c4N_FQ5fDpk_2_U3ZKjwAmHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] tee: amdtee: store buffer ID in tee_shm->sec_world_id
To: "Rangasamy, Devaraj" <Devaraj.Rangasamy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.59 / 15.00];
	BAYES_HAM(-2.99)[99.94%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.210.48:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	DWL_DNSWL_BLOCKED(0.00)[linaro.org:dkim];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.210.48:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0031943296
X-Spamd-Bar: ---
Message-ID-Hash: SR2ZB2CK2LBAZVJ4RC5R3UUTKE54TZBC
X-Message-ID-Hash: SR2ZB2CK2LBAZVJ4RC5R3UUTKE54TZBC
X-MailFrom: jens.wiklander@linaro.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Rijo Thomas <Rijo-john.Thomas@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, Rajib Mahapatra <rajib.mahapatra@amd.com>
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/SR2ZB2CK2LBAZVJ4RC5R3UUTKE54TZBC/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

Hi,

On Wed, Apr 22, 2026 at 7:16=E2=80=AFAM Rangasamy, Devaraj
<Devaraj.Rangasamy@amd.com> wrote:
>
> On 27-03-2026 14:56, Rijo Thomas wrote:
> > Drop struct amdtee_shm_data and the per-context shm_list. In
> > handle_map_shmem() save the returned buf_id in shm->sec_world_id
> > instead of allocating a list node. Use shm->sec_world_id (with
> > get_buffer_id() removed) in amdtee_unmap_shmem() and in call.c when
> > building memref params. Remove shm_list and shm_mutex from
> > amdtee_context_data.
> >
> > Aligns amdtee with other TEE drivers (optee, tstee, qcomtee) that use
> > tee_shm->sec_world_id for the secure-world handle.
> >
> > Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>
> Looks good.
>
> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>

I'm picking up this.

Cheers,
Jens
