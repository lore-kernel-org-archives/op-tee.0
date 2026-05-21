Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF533CD5BA4
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 10:44:18 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 25D12443C4
	for <op-tee@archiver.kernel.org>; Thu, 21 May 2026 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1779360258;
	bh=NQ3Nusm6YkbFPT1vR/R2GlJCmX9emImzU3s5lu4qsk4=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Tmnm4WfYUR+nOwiviJ62nMLPaCt7QT9gNOnQUU7yYt7wvOkHxDuLrdKfJqmnTkZzv
	 VaS3sULrxjgwpSq2UUIA/sz6PFC3gq6Gmz2J7+TA3w7SrQzmIu+DiZ3/wP1Gcm9Qby
	 iET9/+8Nfa1LXCOUOi0r863Z4YtOfZM7K76ogFhkJZRzFDbVXZ21ZVdAppcRvCwhl8
	 MYWFp19iknWpSIDtSGIvPFul4TG7hNOvCzjfXMlLfz2/Zgh5SBXKvDXEyg4x5qbOqW
	 o+cH88RPKi1gkvwE/7a5TgILy9eiJmakwM7ej4wp8GOeGSg2RipJekeOIDiVR9fFBw
	 bD/ecHb+SegLA==
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 0D9FE44394
	for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 10:44:11 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=JAye3QGG;
	dkim-atps=neutral
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d864c23bdso5621cf.1
        for <op-tee@lists.trustedfirmware.org>; Thu, 21 May 2026 03:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779360250; cv=none;
        d=google.com; s=arc-20240605;
        b=JKU3so962vCA2Nn8M93C0+ja5RK2TSxB6dZt7K0lJbg64kFoL0d0bwsFTjkQkNNppV
         FQCr2uXLoj1w0BlwhO+6FO03YciqFUbBrWX35UlKlu8vVxpTPawrhGkEmKUnkviiDAlb
         FlEBvq5110qmYxLUJUHDy8lWVIAQo7QjEEhUFxWt7TNA3fCiuxZGqfAQ7f1o6mrCFm6x
         Ag6tvI8KVWammqIRC+7tJx006oMtKwPMUzL7/iMWko4hKJRH6B/dfxXIrZcrZzjo8SwB
         4DjIJNNJhsLK5UCvDsLj7GlT3DCPmPA8zVzsHKclJyrp/BJV1BvFvWWQqgKU/AEF0S36
         hdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01uiUNMkWOnOyoQp4EjW7o/7679tfblvQE/eVZhbN1U=;
        fh=lg/S8uxeBYrJlTVT8ZKKe3Bmk+B0pLKbESfumLumTAc=;
        b=Iy9Vh8Ah+hjRMniuoMrRn5KfGx14JVFCf14yRWXaMSQXD+pw/ghSgQToUAHux2m1ef
         UwwDVEi9sF7YZ8WBYgiR2FHQ4rsjqEyE8uKvm5p5dW+PpvUKuW9u+7d1/CDOLRJqzZ1u
         b4GPvYwxM7PT2CIksbDkg0cWxofL/M0Q9iCEOpwgbksM9JozRQY5uSCWGMdnQw9PgEOC
         aInZZDI5GSMepsTEh/hcTN0n0nB2erpbd3sOsWJdmcDW4nAGFGPgOQ3jGZf0pJZvzDGh
         X64HJilVtuHt/mPZbBCRRmjaFvZ0Y5GFe2bwDrbkxqjOWVCeE4HH5SF6tDWgn6CRpgRE
         WRvQ==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779360250; x=1779965050; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01uiUNMkWOnOyoQp4EjW7o/7679tfblvQE/eVZhbN1U=;
        b=JAye3QGG00u+YGcWgAAGQ8sspUxMHoDVQWWMYG++RymJLloEn7hmzgYin2VEjR5CB5
         5i0sBuinbWsCrXs0bMZIjp9fXLtghW0pVRkBwEYyszr3etVHMj5sClwG6NQ5ziQc/kku
         W8PQrRVEQw1pqcyyhpA6pDBtJrrURdJ3kYbGXJg70bT4VhPbxLUd59/CMdNVvwWVLviJ
         ZRufRk3E0J/n8cppg5olpT+nQvMqKAosY2V7c5CU2b3ltIY+lNQnsdniBEmeywpwUqHQ
         8MbB4cUGTn3mVmpdDJ0zv7VdNMFD63mLftZ8t0viMs0LCo28h3oX/uFRGPmJjUk+92fB
         YIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779360250; x=1779965050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=01uiUNMkWOnOyoQp4EjW7o/7679tfblvQE/eVZhbN1U=;
        b=IFi3pWGh4qroynUdF7XiG1QD7c8OSocObzgf70g+0RX0W6N4o57N0PKRMbCnF6k5vZ
         35xAb4ycIGIhGJ6YfBuwpFIFSaXOtHj0Cxgm98h43uspRRKi/3AfZVxOsLZV65FZgYPw
         R3mYZ5REBYZwMI7HXpBsfUEhcfy0GvFmnGJVcyznhZ5EZbmUH03nFLDzKAG8733eWULt
         NEcs7N72vslQyDW2kWZGphCNb0U+L1yXGwaslAcilNKSD/2ZVKw14TKByaVYhWJ57gQ4
         dzYHSbAEs0+i/uvK9JHVB2NbzRvAbch1IFmdeW7401HTeOHorRqlWw10/EsnKqpXCukV
         4sww==
X-Gm-Message-State: AOJu0Yxyz2parYdUum6m52J6qWSE8AzuDYm5NTdpWVcU19bGPM40iPkC
	yMfKItz68f4Zou5dJhSHvNDGDwFLXm7zu9pzTIIwsuI7WWTfG/l3OArGwRsN7C8cLu18gn2jZ5N
	wGsZKrKu6g44IeeGA6KZq7Gn64gKV1jgzcDArsx2K
X-Gm-Gg: Acq92OFZ8vSE/9LVPElazlmqw13ki372aCh7s6QHw0Qn8V233Ik5AuR7ZQ4FpufDebF
	jJeQJXo9L8U1DFmfiJXViPwTGxb7ZYbsdcKTx/t2NW0GLPr/ff3ki5oa9EsUUFoTNnL88PaPRcE
	2fZQqjqW5S1iNohDJOOrLBKXvJbmzBgbebMtcgo/LcOxf0is2BTCz5p52fQX54t5HIOsc3LOLul
	Ob7OUb7rbs35VASQWK4TJQbsFc7idGVyaJvU5/3mPHV1XfBnPbvoenlfEenILb76pQP8M5FCmtc
	2FnPAMFQM3DOMJMrR5b1zge3KpoYaZj+a6pE5FO3SSxMfgP4xhH3
X-Received: by 2002:a05:622a:1909:b0:516:4f62:85ee with SMTP id
 d75a77b69052e-516c54daacemr7650001cf.19.1779360249995; Thu, 21 May 2026
 03:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260520204948.2440882-1-smostafa@google.com> <20260520204948.2440882-5-smostafa@google.com>
 <86ldddw4ht.wl-maz@kernel.org> <ag7eq3bfBOxfaZ59@google.com>
In-Reply-To: <ag7eq3bfBOxfaZ59@google.com>
Date: Thu, 21 May 2026 11:43:58 +0100
X-Gm-Features: AVHnY4LZQTvaETc0PFZc4ErDn0OiwyQemmgBHI89H_ICLndAOva3c3G1YM9luGk
Message-ID: <CAFgf54qpNVvzSiV89g12-4jWeacm=06LMjCooeU1Mt+3sqWDLQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] KVM: arm64: Fix bounds checking in do_ffa_mem_reclaim()
To: Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.10 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	ARC_ALLOW(-1.00)[google.com:s=arc-20240605:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:209.85.128.0/17];
	MIME_GOOD(-0.10)[text/plain];
	RWL_MAILSPIKE_GOOD(-0.10)[209.85.160.182:from];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:15169, ipnet:209.85.128.0/17, country:US];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_ONE(0.00)[1];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_IN_DNSWL_NONE(0.00)[209.85.160.182:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	DWL_DNSWL_NONE(0.00)[google.com:dkim];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 0D9FE44394
X-Spamd-Bar: -----
Message-ID-Hash: IEEIOIU32XZIJXOLAQ4DA62Q44PBI6QG
X-Message-ID-Hash: IEEIOIU32XZIJXOLAQ4DA62Q44PBI6QG
X-MailFrom: smostafa@google.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, sumit.garg@kernel.org, sebastianene@google.com, vdonnefort@google.com, sudeep.holla@kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/IEEIOIU32XZIJXOLAQ4DA62Q44PBI6QG/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Mostafa Saleh via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Mostafa Saleh <smostafa@google.com>

On Thu, May 21, 2026 at 11:30=E2=80=AFAM Mostafa Saleh <smostafa@google.com=
> wrote:
>
> Hi Marc,
>
> On Thu, May 21, 2026 at 09:28:46AM +0100, Marc Zyngier wrote:
> > On Wed, 20 May 2026 21:49:47 +0100,
> > Mostafa Saleh <smostafa@google.com> wrote:
> > >
> > > Sashiko (locally) reports out of bound write possiblity if SPMD
> > > returns an invalid data.
> > >
> > > While SPMD is considered trusted, pKVM does some basic checks,
> > > for offset to be less than or equal len.
> > >
> > > However, that is incorrect as even if the offset is smaller than
> > > len pKVM can still access out of bound memory in the next
> > > ffa_host_unshare_ranges().
> > >
> > > Split this check into 2:
> > > 1- Check that the fixed portion of the descriptor fits.
> > > 2- After getting reg, check the variable array size addr_range_cnt
> > >    fits.
> > >
> > > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > > ---
> > >  arch/arm64/kvm/hyp/nvhe/ffa.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/=
ffa.c
> > > index 1af722771178..e6aa2bfa63b1 100644
> > > --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> > > @@ -607,7 +607,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_1=
_2_regs *res,
> > >      * check that we end up with something that doesn't look _complet=
ely_
> > >      * bogus.
> > >      */
> > > -   if (WARN_ON(offset > len ||
> > > +   if (WARN_ON(offset + CONSTITUENTS_OFFSET(0) > len ||
> > >                 fraglen > KVM_FFA_MBOX_NR_PAGES * PAGE_SIZE)) {
> >
> > Do you really want to keep this a WARN_ON(), given that this results
> > in a panic in most pKVM configurations?
>
> Which kind of configuration will that check fail on?
> Does that mean at the moment pKVM does out-of-bound access for
> the header?
>
I might have misunderstood the point. I thought you meant the new
change would cause a panic on most configurations, or were you
suggesting just removing the WARN_ON?
I can do that, I just updated the current faulty check and left the
WARN_ON as is.

Thanks,
Mostafa

> Thanks,
> Mostafa
>
> >
> > Thanks,
> >
> >       M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
