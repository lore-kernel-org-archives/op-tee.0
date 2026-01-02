Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D43FA3755
	for <op-tee@archiver.kernel.org>; Fri,  2 Jan 2026 22:17:58 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id DE2774FEE2
	for <op-tee@archiver.kernel.org>; Fri,  2 Jan 2026 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1767392278;
	bh=/64Co2q0kgEgA6DPpVmvrLqtt4+bKlfMdoKNXVNCcsQ=;
	h=References:In-Reply-To:Date:Subject:To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=qCJn0elj6y4f09ti5vAZ6V+XZSnCYtPz9fJWtLB73tmklZkNr8BMni4ipU2OAsOu8
	 3QiTa1QXayihgndbXQSV6x9qXuMNolGwoxRTLD5Tr4mW7UooZLqq9S/dU8yyuoszIL
	 biPBNklj+qJsH4DIj5gvM6QC07GBQmapF8y4gmI4uulIrIMlyiyA2hLeFkgkp5u+jY
	 3y6r9hVMzfmyMGbLPES3J0r+n4ETNdXVg815gmNa7GyxCZOATx0fbXUJ9kG7fUENrB
	 kg8yFXZRcinW/XmRRUUvimetOiAKMpCvYVr0m1d7K2N7+XyXBJzB5o6tF0uXRsEPnI
	 Lu+Un/gSnsVtQ==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id C8F26418F9
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Jan 2026 22:17:40 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ge2fF73i;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 263C760144
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Jan 2026 22:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3364C19421
	for <op-tee@lists.trustedfirmware.org>; Fri,  2 Jan 2026 22:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767392259;
	bh=/64Co2q0kgEgA6DPpVmvrLqtt4+bKlfMdoKNXVNCcsQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ge2fF73iJ8fd9je/5EvWRvXS4+eNAXKRDPzkWl71vlZSnTL/QfKna/aIUVBrNzqh5
	 mDsdGxhIVjOAF5DgyQXjyPdkWInWTLYyR9nBQBjvEYKXdK4AlCDsxA4DRs7FKwJd55
	 qbNGH1+8COzIcaBwqUZtXwBOXEyk4P7MwVgy80b4xpW7IdeVJUU16yVWcdTMFVs1VE
	 a/shbiUuWL8wYX6p4iaLWpnQh2+AczJFAcfhA1YoN3SzJA9UdLIX7SN1jvxiC3iOfj
	 7D4GSVWzrtB2v8A78o2IxK2poTFA4PCSHN/pB4Gh1eYAhTxFCE8mUEEVm572e5YK5f
	 d5bdHvqxa8TAA==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7355f6ef12so2381460166b.3
        for <op-tee@lists.trustedfirmware.org>; Fri, 02 Jan 2026 14:17:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIvA3OQiVL540EBJQnspTOS+K4Wf2MkfxBQaKZGozeJspZ/OZXylFlTBq3r7XjqqUQ329yrxs=@lists.trustedfirmware.org
X-Gm-Message-State: AOJu0Yxs5AUTLinjcjAXAxTLbpqfq6m5v9q39fva0+HdvimrIRH6ATN8
	1tJEmYuWZdp+YdHamUDeBwXj89LNmC0bS1pIJx3clLZH1UuZfLHJE5uBgLGl3qUTO+kkA9Urmq9
	VGNUOW36ogPxRRLT7fLOtQqzS7f3uJw==
X-Google-Smtp-Source: AGHT+IGcdjYMdq8WHlapJ12+Pohp79IeQ6Qp00t62ofYPur0Xu5Cyh0Zdwx3rcPrWR7fro3HFhzV7izpL+ysUdN6FT8=
X-Received: by 2002:a17:907:da17:b0:b83:3770:a0e4 with SMTP id
 a640c23a62f3a-b833770a15emr2280910966b.34.1767392258434; Fri, 02 Jan 2026
 14:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20251217153917.3998544-1-arnaud.pouliquen@foss.st.com>
 <20251217153917.3998544-2-arnaud.pouliquen@foss.st.com> <20251229232530.GA2753472-robh@kernel.org>
 <aVOzHWmlJ-eneS-2@sumit-xelite>
In-Reply-To: <aVOzHWmlJ-eneS-2@sumit-xelite>
Date: Fri, 2 Jan 2026 16:17:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
X-Gm-Features: AQt7F2qSpJIFr1cZ7Ak2PMJj_kJpZOMaYqr6WPt7b6SXNB2GqwyfYzNGk02nLo4
Message-ID: <CAL_Jsq+_S8UY7s7WQg9jXuBXCYMBWVCy=kVDMdkKTx6RctqQJA@mail.gmail.com>
Subject: Re: [PATCH v20 1/6] dt-bindings: firmware: Add TEE remoteproc service binding
To: Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.49 / 15.00];
	BAYES_HAM(-2.99)[99.95%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: C8F26418F9
X-Spamd-Bar: --
Message-ID-Hash: MJ4D6SDNZUKOKTASQU466L6AISNVYEPI
X-Message-ID-Hash: MJ4D6SDNZUKOKTASQU466L6AISNVYEPI
X-MailFrom: robh@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/MJ4D6SDNZUKOKTASQU466L6AISNVYEPI/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Rob Herring via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Rob Herring <robh@kernel.org>

On Tue, Dec 30, 2025 at 5:10=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Mon, Dec 29, 2025 at 05:25:30PM -0600, Rob Herring wrote:
> > On Wed, Dec 17, 2025 at 04:39:12PM +0100, Arnaud Pouliquen wrote:
> > > Add a device tree binding for the TEE-based remote processor control
> > > service implemented as an OP-TEE Trusted Application identified by
> > > UUID 80a4c275-0a47-4905-8285-1486a9771a08.
> > >
> > > The TEE service node is a child of the "linaro,optee-tz" firmware nod=
e and
> > > acts as a container for remoteproc devices that are controlled via TE=
E.
> >
> > Is this generic for any remoteproc device or just ST's remoteproc. Look=
s
> > like the latter to me.
>
> That's true, the DT description of the remoteproc subnode is very
> specific to the vendor which in this case is ST.
>
> >
> > > In addition, the "linaro,optee-tz" binding is updated to specify the
> > > '#address-cells' and '#size-cells' values used for child TEE service
> > > nodes.
> >
> > I'm pretty sure I already rejected per service/app child nodes for
> > OP-TEE when its binding was submitted.
>
> That was the reason to have discoverable TEE bus in first place and I
> have been motivating people to dynamically discover firmware properties
> rather than hardcoding in the DT.
>
> > If we do need something in DT
> > to define some resources, then can't we have some sort of
> > standard/common communications channel? I don't care to see some sort o=
f
> > free-for-all where we have every vendor doing their own thing. OP-TEE
> > needs to standarize this.
>
> I suppose this requires a wider scope work as you can see the DT resource
> dependence from here [1]. By standardize communication channel, do you
> mean to say if adding an alternative backend to fwnode for TEE in
> parallel to DT, ACPI or swnode is the way to go for discovering fw
> properties?

No, not at all.

> Or do you have any other suggestion here?

What I mean is why doesn't the TEE define the communication channel
(mailbox+shmem and notification interrupt) rather than each TEE app?

More generally, is having TEE apps depending on random DT resources
really a box we want to open? Is the next thing going to be a TEE
clock/reset/gpio/power provider? Where do we draw the line?

Rob
