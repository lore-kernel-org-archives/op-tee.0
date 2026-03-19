Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C041075274
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 08:07:52 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 3C65A43ACB
	for <op-tee@archiver.kernel.org>; Thu, 19 Mar 2026 08:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1773907672;
	bh=/eggGJc8w0dVMpTXWMeYMFm/znwA+edXs/5l6qyW4PE=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=W2SYaxXVPXgKgPuMFRq6doXsDuVqsOGxNntGrx2o5u+Ab5v0GdNvSYX2pzCWcCxat
	 6tPNx76QEn39PpU1fd43Bt4mO9gIrbHVuYgbIwVNJtUX0xyMXvNYqpOD2TlTwSr1V7
	 5uxRmNQOqrUF6nQnLB+2k1f5nKsBA3GfPPh2koMpma5/COZ1b0t/oeC9VMwuiKvD51
	 2KzwFtewITJ9QYNZSnGTuVA0XjkAzbT5drGm4Ad/iy+CqfFd0+XN89A5cAzJsW2qWq
	 TaLMC9T6p31zOvUsOI/FYdSFQ1vsuKnjJ4YFVsmTsX27Ppx3O5rSllIIWnuA3HTiaO
	 ZwglztltXi8gw==
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 7848143AC7
	for <op-tee@lists.trustedfirmware.org>; Thu, 19 Mar 2026 08:07:27 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Yqv2xAS9;
	dkim-atps=neutral
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 26D82600AD;
	Thu, 19 Mar 2026 08:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77302C19424;
	Thu, 19 Mar 2026 08:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773907646;
	bh=/eggGJc8w0dVMpTXWMeYMFm/znwA+edXs/5l6qyW4PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yqv2xAS9fjzDIa7+qFMFWEC3da1aX7vqYq3Nm7gvhUEnG0sIodlyG5dShrFBWRyZb
	 kcCgtrw/+Zsppc5EMEN2Pz2HFIfNmMbs0Rid6utUuSOgXEZfT2tty4+Q5480DeMcAO
	 cJZRPVTeSRVKHUyK5HdiJqua0tr12r0BGKFnU50su6MR+YRH78Za65A4Veqh57N1Sw
	 9dXnkVUTpeeHxIeY9p2gsfWrrV9YSYEgogVN6D1+cXz5vZeib1RfsN5b+31oUMWllR
	 wFRreAhlODAlh7IyNtSGCNaPekZgTtIVMjq1OMW9nzXYuu8yQRRP4GTeimdBVrpadm
	 1aRZZYmhSNzsQ==
Date: Thu, 19 Mar 2026 09:07:24 +0100
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH v21 0/6] Introduction of a remoteproc tee to load signed
 firmware
Message-ID: <20260319-fiery-onyx-serval-aceb17@quoll>
References: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260317180329.1207625-1-arnaud.pouliquen@foss.st.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.00 / 15.00];
	BAYES_HAM(-2.50)[97.72%];
	URL_BACKSLASH_PATH(2.00)[0.0.0.0];
	SUSPICIOUS_RECIPS(1.50)[];
	URL_NUMERIC_IP(1.50)[0.0.0.0];
	DWL_DNSWL_LOW(-1.00)[kernel.org:dkim];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.4.254:c];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.0.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 7848143AC7
X-Spamd-Bar: +
Message-ID-Hash: W77LU4BUFAI2MX3JDCWYAVT6G67KJ7IB
X-Message-ID-Hash: W77LU4BUFAI2MX3JDCWYAVT6G67KJ7IB
X-MailFrom: krzk@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/W77LU4BUFAI2MX3JDCWYAVT6G67KJ7IB/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Krzysztof Kozlowski via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>

On Tue, Mar 17, 2026 at 07:03:21PM +0100, Arnaud Pouliquen wrote:
>=20
> Main updates from version V20[4]:
> --------------------------------
> To address Rob=E2=80=99s concern on v20concerning resource declaration un=
der the
> tee node, the device tree is now structured as follows,replacing the
> child-parent hierarchy with a phandle:
>=20
>     firmware {
>         tee_rproc: optee-rproc {
>             compatible =3D "80a4c275-0a47-4905-8285-1486a9771a08";
>         };
>     };
>=20

And what is the parent here?

>     m4: m4@0 {

What sort of bus do you have here (IOW, what does this 0 mean?)

>       compatible =3D "st,stm32mp1-m4-tee";
>       reg =3D <0 0>;
>=20
>       mboxes =3D <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
>       mbox-names =3D "vq0", "vq1", "shutdown";
>=20
>       memory-region =3D <&vdev0vring0>, <&m_ipc_shm>, <&mcuram2>,
>                       <&vdev0vring1>, <&vdev0buffer>, <&retram>;
>=20
>       interrupt-parent =3D <&exti>;
>       interrupts =3D <68 1>;
>=20
>       rproc-tee-phandle =3D <&tee_rproc 0>;
>       st,auto-boot;
>       wakeup-source;
>=20
>       status =3D "okay";
>     };

Best regards,
Krzysztof

