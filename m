Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CDFC88E77
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 17:13:23 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id D52EA450A9
	for <op-tee@archiver.kernel.org>; Tue, 15 Sep 2026 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lists.trustedfirmware.org; s=2024; t=1789492402;
	bh=ivBonYODbbsrsacrHrcfoJQOLzw23nGRDwkGNZqoBo4=;
	h=Date:To:Subject:References:In-Reply-To:CC:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From:Reply-To:From;
	b=v0HyLXj+IRVRvUA3tz/sV03zyZiGOk1RIr4sVTwGcB+x+d/etvEbXIGXhrVY3gr7i
	 QyAPAItW27oP4iWGL0vNxwSAgQhm+vaY0f1Kh7fyIHmYH2iJS5Ul0ta/wTQscraH6V
	 CV4rP4a/z6GYm3utSf3d7Qgvqs64aOF3JR4S334y0oaKqdIvvI+x/V+4oGJeJNEgA8
	 XZn4IWEo4DghhwjHPX6XqSWjPGMgHN6p/NJ+hv+WLDBLc2VglutR1IfkspINsAFUsP
	 gRBm+OkbQoMkjyyJi+Rvt1HBk97j6YOxz3C69KM/JrtNlGt7Kn43soorIyHmyDd2FN
	 IcNYBLOodznrQ==
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 1F62E4388D
	for <op-tee@lists.trustedfirmware.org>; Tue, 15 Sep 2026 17:13:15 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKOnqNmU;
	dkim-atps=neutral
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 60C774012B;
	Tue, 15 Sep 2026 17:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260F81F000FF;
	Tue, 15 Sep 2026 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789492394;
	bh=YJR9aq2r86J30eW8lL/Fjsuscy+SjBA6fWgSJoTL8AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OKOnqNmUUVc6YU90Q7sW0mC92AKXaFVQvfauDuNsQ6qdMUDZisWKNfUtoDsHiI0+l
	 eG2M47wjWgh0mM8K0aq+F74Ai/vQr7mouMeTdalC7p05GQaq04qSL6tN1GAAfvHNO6
	 8XnESBkddlGTcnbFYHtzRCI7CyLZraBqgOkTJIqTEADOEnFmXtGm/hz2Ep0Mcn2JaH
	 7/nrnmaIgyMVLDAfcELr0qkTO+zM9viRTsL5Ob+t9kP+r+7d81fAK3zyXFUVwY9jBD
	 Ux3yvf6LWDMYREU4qwh3MWyOEnervXSkfvCxLrmflqPxR2ogTn3ZtsCBQJIIm/bo5+
	 d4VcEfPSn/jkg==
Date: Tue, 15 Sep 2026 18:13:09 +0100
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: Re: [PATCH RFC 5/5] dt-bindings: tee: add RISC-V RPMI TEE transport
Message-ID: <20260915-reappear-hatchback-f4c3697a1b4e@spud>
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
 <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rnRve9bgpYmX7ikw"
Content-Disposition: inline
In-Reply-To: <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.10 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	DWL_DNSWL_MED(-2.00)[kernel.org:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.252.31];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: 1F62E4388D
X-Spamd-Bar: ---------
Message-ID-Hash: EOPSBYZCZAR7X5BV537APXJVOY22PFUU
X-Message-ID-Hash: EOPSBYZCZAR7X5BV537APXJVOY22PFUU
X-MailFrom: conor@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; digests; suspicious-header
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/EOPSBYZCZAR7X5BV537APXJVOY22PFUU/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>
From: Conor Dooley via OP-TEE <op-tee@lists.trustedfirmware.org>
Reply-To: Conor Dooley <conor@kernel.org>

--rnRve9bgpYmX7ikw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 03:15:16AM -0700, Amirreza Zarrabi wrote:
> Add a device-tree binding for the OP-TEE RISC-V transport using the RPMI
> TEE service group over SBI MPXY.
>=20
> Describe one mailbox channel per hart and an optional interrupt used as
> the availability doorbell for asynchronous notifications.
>=20
> Add the binding to the existing OP-TEE MAINTAINERS entry.
>=20
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

The clock and (?reset?) bindings for mpxy stuff have both S and M mode
bindings. How come you only have the S mode one here?

Cheers,
Conor.

> ---
>  .../bindings/tee/riscv,rpmi-mpxy-tee.yaml          | 65 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 66 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.ya=
ml b/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
> new file mode 100644
> index 000000000000..8f6ff313fd42
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/tee/riscv,rpmi-mpxy-tee.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V RPMI TEE service group based message proxy
> +
> +maintainers:
> +  - Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> +
> +description: |
> +  The RISC-V Platform Management Interface (RPMI) [1] defines a messaging
> +  protocol which is modular and extensible. The supervisor software can
> +  send/receive RPMI messages via the SBI MPXY extension [2] or some dedi=
cated
> +  supervisor-mode RPMI transport.
> +
> +  The RPMI specification [1] defines a TEE service group which is the RI=
SC-V
> +  analog of Arm FF-A: OP-TEE and the rich execution environment (REE, i.=
e.
> +  Linux) are peer endpoints and the RPMI framework (machine mode firmwar=
e)
> +  mediates every message. Entering OP-TEE on a hart runs it on that hart=
 until
> +  it responds, so the SBI implementation provides one SBI MPXY channel p=
er
> +  hart; all of them are listed, in hart order, on a single node.
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  References
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> +
> +  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> +
> +properties:
> +  compatible:
> +    const: riscv,rpmi-mpxy-tee
> +
> +  mboxes:
> +    minItems: 1
> +    description:
> +      One SBI MPXY channel implementing the RPMI TEE service group per h=
art,
> +      listed in the same order as the CPU nodes.
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Availability doorbell raised by OP-TEE to signal asynchronous
> +      notifications over the RPMI TEE signal bus. Optional; when absent
> +      asynchronous notification is disabled.
> +
> +required:
> +  - compatible
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    tee {
> +        compatible =3D "riscv,rpmi-mpxy-tee";
> +        mboxes =3D <&mpxy_mbox 0x10 0x0>, <&mpxy_mbox 0x11 0x0>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 207a6e2db70c..7d0e550085b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20577,6 +20577,7 @@ M:	Jens Wiklander <jenswi@kernel.org>
>  L:	op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-optee-devices
> +F:	Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
>  F:	drivers/tee/optee/
> =20
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>=20
> --=20
> 2.34.1
>=20

--rnRve9bgpYmX7ikw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaql8pQAKCRB4tDGHoIJi
0smFAP0R3vKvUGlmEV4YG9wl6CzD59R3GC/ptm3Ws/6hAwvFEgD/SWG7NL0Hb75u
DRG3OBY7VmT02Og/lMQzuGAffMPf/QA=
=mJKu
-----END PGP SIGNATURE-----

--rnRve9bgpYmX7ikw--
