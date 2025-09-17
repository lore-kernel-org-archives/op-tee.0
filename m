Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36ACCA0EE8
	for <op-tee@archiver.kernel.org>; Wed, 17 Sep 2025 10:08:30 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 14FCD4317B
	for <op-tee@archiver.kernel.org>; Wed, 17 Sep 2025 10:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1758103710;
	bh=Bcn3M9ufeWdB6ECZblSKboL0UMBmOT8+MspjWui9bMo=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=Pe0oKhsyU+o4gbzLsbPRBzBC39J3kHW9pB28FIRVwUWJmiGuI/kJjxv/xPrDD1wT4
	 3KQhg6ENLO6pwNTkdxTKE4TdYkbbZuoMHaiUeTHrsJftdX9sgc/NF6S0uj7UrVSmyo
	 BeosIonU0ecHWVfbjQvnUtqJPhwVX8Whpzbc8a4tJCuJcOMAMVmO7VbPtYP3bXJacX
	 JOvTdIkgGpjaWRGeVL2mNYe3W/M6NyeXu4KkkUKB8lbAX0l+pPjJ08PZN/qyBg7u4A
	 oLgpVIHRSl2yHQCxVYA2be35/xFo+4DZFzS89AyPXNhBzypJwNdKw1hBm7/VhP3Id+
	 C2xAGTiV7XyVQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 3EB4441828
	for <op-tee@lists.trustedfirmware.org>; Wed, 17 Sep 2025 10:08:13 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ovJNpLtF;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91DBB44070;
	Wed, 17 Sep 2025 10:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A77C4CEF0;
	Wed, 17 Sep 2025 10:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758103692;
	bh=2UJitnxHH4ITOpk1XyAJb3VMT4TKF/dbAik6uHRq8es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ovJNpLtF4n+pjUrxXR2L10rGFPRCmARWfvMI5X0a6r826Alh0O8fuD+srvriol0UJ
	 WRBUf4EkEfFTrELGrXFX5sOBpC70dg/IHX8C+xkPaLS2NeALteU18AXXHIR/F3Lh9T
	 t9VYsSo8iUaZ92OEKuWj6qB07Nw5tzRs+ngR811nvwcnMdtIXpLQXPmdfPT0Stjzfr
	 beS98qwrhSs5V0mE6ZEtlz7+wVPlHEoTpxbSAedZuh1E6wH0ivx6ow3ZRWlVA5L1qO
	 yAscsMSqjmQzgIW4ZU0TI1xZkdnpFxwghGyYMcoXwP86PGucRtK+RmNFotqwywcMNt
	 itYVQE6CpBFHQ==
Date: Wed, 17 Sep 2025 15:38:04 +0530
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v19 4/6] dt-bindings: remoteproc: Add compatibility for
 TEE support
Message-ID: <aMqIhFdIqp5auH22@sumit-X1>
References: <20250625094028.758016-1-arnaud.pouliquen@foss.st.com>
 <20250625094028.758016-5-arnaud.pouliquen@foss.st.com>
 <aMkqifHSdlCs4VjA@sumit-X1>
 <62bdb238-7440-451b-84ef-79f846b10ba0@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <62bdb238-7440-451b-84ef-79f846b10ba0@foss.st.com>
X-Rspamd-Queue-Id: 3EB4441828
X-Spamd-Bar: -
X-Spamd-Result: default: False [-2.00 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Action: no action
X-Rspamd-Server: lists.trustedfirmware.org
Message-ID-Hash: 2MBFOHSDFIAQ2R5RAPFNHIJRDPCUNDFO
X-Message-ID-Hash: 2MBFOHSDFIAQ2R5RAPFNHIJRDPCUNDFO
X-MailFrom: sumit.garg@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/2MBFOHSDFIAQ2R5RAPFNHIJRDPCUNDFO/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Sumit Garg via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Sumit Garg <sumit.garg@kernel.org>

On Tue, Sep 16, 2025 at 03:26:47PM +0200, Arnaud POULIQUEN wrote:
> Hello Sumit,
>=20
> On 9/16/25 11:14, Sumit Garg wrote:
> > Hi Arnaud,
> >=20
> > First of all apologies for such a late review comment as previously I
> > wasn't CCed or involved in the review of this patch-set. In case any of
> > my following comments have been discussed in the past then feel free to
> > point me at relevant discussions.
>=20
> No worries, there are too many versions of this series to follow all the
> past discussions. I sometimes have difficulty remembering all the
> discussions myself :)
>=20
> >=20
> > On Wed, Jun 25, 2025 at 11:40:26AM +0200, Arnaud Pouliquen wrote:
> > > The "st,stm32mp1-m4-tee" compatible is utilized in a system configura=
tion
> > > where the Cortex-M4 firmware is loaded by the Trusted Execution Envir=
onment
> > > (TEE).
> > Having a DT based compatible for a TEE service to me just feels like it
> > is redundant here. I can see you have also used a TEE bus based device
> > too but that is not being properly used. I know subsystems like
> > remoteproc, SCMI and others heavily rely on DT to hardcode properties of
> > system firmware which are rather better to be discovered dynamically.
> >=20
> > So I have an open question for you and the remoteproc subsystem
> > maintainers being:
> >=20
> > Is it feasible to rather leverage the benefits of a fully discoverable
> > TEE bus rather than relying on platform bus/ DT to hardcode firmware
> > properties?
>=20
> The discoverable TEE bus does not works if the remoteproc is probed
> before the OP-TEE bus, in such case=A0 no possibility to know if the TEE
> TA is not yet available or not available at all.
> This point is mentioned in a comment in rproc_tee_register().

The reason here is that you are mixing platform and TEE bus for remoteproc
driver. For probe, you rely on platform bus and then try to migrate to
TEE bus via rproc_tee_register() is the problem here. Instead you should
rather probe remoteproc device on TEE bus from the beginning.

>=20
> Then, it is not only a firmware property in our case. Depending on the
> compatible string, we manage the hardware differently. The same compatibl=
es
> are used in both OP-TEE and Linux. Based on the compatible, we can assign
> memories, clocks, and resets to either the secure or non-secure context.
> This approach is implemented on the STM32MP15 and STM32MP2x platforms.

You should have rather used the DT property "secure-status" [1] to say
the remoteproc device is being managed by OP-TEE instead of Linux. Then
the Linux driver will solely rely on TEE bus to have OP-TEE mediated
remoteproc device.

[1] https://github.com/devicetree-org/dt-schema/blob/4b28bc79fdc552f3e0b870=
ef1362bb711925f4f3/dtschema/schemas/dt-core.yaml#L52

>=20
> More details are available in the ST WIKI:
> https://wiki.st.com/stm32mpu/wiki/OP-TEE_remoteproc_framework_overview#De=
vice_tree_configuration
> https://wiki.st.com/stm32mpu/wiki/Linux_remoteproc_framework_overview#Dev=
ice_tree_configuration
>=20
> >=20
> > > For instance, this compatible is used in both the Linux and OP-TEE de=
vice
> > > trees:
> > > - In OP-TEE, a node is defined in the device tree with the
> > >    "st,stm32mp1-m4-tee" compatible to support signed remoteproc firmw=
are.
> > >    Based on DT properties, the OP-TEE remoteproc framework is initiat=
ed to
> > >    expose a trusted application service to authenticate and load the =
remote
> > >    processor firmware provided by the Linux remoteproc framework, as =
well
> > >    as to start and stop the remote processor.
> > > - In Linux, when the compatibility is set, the Cortex-M resets should=
 not
> > >    be declared in the device tree. In such a configuration, the reset=
 is
> > >    managed by the OP-TEE remoteproc driver and is no longer accessibl=
e from
> > >    the Linux kernel.
> > >=20
> > > Associated with this new compatible, add the "st,proc-id" property to
> > > identify the remote processor. This ID is used to define a unique ID,
> > > common between Linux, U-Boot, and OP-TEE, to identify a coprocessor.
> > This "st,proc-id" is just one such property which can rather be directly
> > probed from the TEE/OP-TEE service rather than hardcoding it in DT here.
> Do you mean a topology discovery mechanism through the TEE remoteproc
> service?
>=20
> For the STM32MP15, it could work since we have only one remote processor.
> However, this is not the case for the STM32MP25, which embeds both a
> Cortex-M33 and a Cortex-M0.

I rather mean here whichever properties you can currently dicovering via
DT can rather be discovered by invoke command taking property name as input
and value as output.

>=20
> Could you please elaborate on how you see the support of multiple remote
> processors without using an hardcoded identifier?

By multiple remote processors, do you mean there can be multiple
combinations of which remote processor gets managed via OP-TEE or not?

>=20
> > I think the same will apply to other properties as well.
> Could you details the other properties you have in mind?

I think the memory regions including the resource table can also be
probed directly from the TEE service too. Is there any other DT property
you rely upon when remoteproc is managed via OP-TEE?

-Sumit
