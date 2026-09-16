Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F789C88E77
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 11:16:31 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 2A7F34549F
	for <op-tee@archiver.kernel.org>; Wed, 16 Sep 2026 11:16:31 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=pBXpcnpr;
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id D91C844438
	for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 10:12:30 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso5608695e9.2
        for <op-tee@lists.trustedfirmware.org>; Wed, 16 Sep 2026 03:12:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789553550; cv=none;
        d=google.com; s=arc-20260327;
        b=Sa+OCWb5DWOTmhzKPtOcRRcvcm2nojuDve/2skjI5b+JulAq5AeLBgL0hlGpI3BXzl
         XwtCP+Wj6qVEtE/mjOQGPyT+HKOj92DmyNTR6k14hwtTCmFkZnslpSSDpMbcrfaDL5Is
         DwuzWDgBpd3fCaJgQerYzhgL0BuO3NcK+M0ASVsm6IIFmKzVKDQLqD8BIvwt3qXQVBwy
         6MnrpV2uztErkfIeClFWijmvIE5xnmIzQvXmTp9aYB7d+1X4sc50bzf7CkBOAGK4uNON
         Gwf/sp1A/h+1WX5XpKcr3ILpSdlHS9LQWXEeQ4VLriZqySo3BiVc0s7T8yDTFK4UqIhD
         06HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VMvnu6Q+bhTIDoi1lbqTiSXnAgA138OR2uRiPsRsuJs=;
        fh=xBuBLLu0xRyb5uz0cBwnKEtv02Ar9H4rkUuZftjAeis=;
        b=qsjrQy1lwcp6cbD54L9rubDXFTq5g8ZLtqcbkgcHDgpga/ZRyC7gSZGfUsxquT673F
         9i+aKkkxVkqqLofYolKjxyEyESkh0QDhRFsuC13yRXrgsfqsuMVDd5c4QIQLiEM3G9EN
         w9g2TO0hn5B6xiXGYMskf/AW+i3aKRL6xbEKn22X3T4yGeRHkDHZaDYMhhZ/5nlUC/o9
         Gsd8nluyUugMSlVhaUvDOq+sXZvHL429d0ZboTzq9rw61pnNXNz2sgV9AxcWsNLylGsV
         uoNqOqWpfQOF3b8Z113z0t90YKsPsx18F8HlQtvvFvrodRuIdMkbCLkMLnk1n/xRcuqn
         +J6A==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789553550; x=1790158350; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VMvnu6Q+bhTIDoi1lbqTiSXnAgA138OR2uRiPsRsuJs=;
        b=pBXpcnprE9Y5ABSP6eBd65wl3ChEOBCNbYzZp45wDdefUUdiI+rbjh3AkJBqWPsT+M
         Bavq9aS/O3pff6uYsofuQ91zAOfdB8Yonq1nI68clGfQw+9S6/7NUsJox1Ed2XeTFgF0
         XY8b+Fz0zBmbwo6MamwK4thmc+XXDWegxqUIWJruPU+J3JP965QEiY/JvdnWoXAW34qY
         5UqofUcQJeW3YpnX8E397a5bfA62wYz7uJY8Z5P89j7ETlLRG2mJglyI8Ci8xJBKPFvI
         I6Qx7VFoO+noCFZgiY1IV/RYI3wv/WXQvM4TbpBfvL8zurXtGNXj08RB5fqjG1CuD64p
         cauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789553550; x=1790158350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VMvnu6Q+bhTIDoi1lbqTiSXnAgA138OR2uRiPsRsuJs=;
        b=xtp2UrwQZB8XKbr4osAhlSamMRfIBqZq7icllm9PP9i+4lQxVCwocJ/F/xvv6gl/A0
         4vBNM6JdYjyjBribox7n1K1ysXaf9YJO+hntisEDvyHL+d3kXLd11NMUEp4vYPSOwGlw
         tvexZrUnCAyZBNZXE2htq4+d2V2J2NlJFbR9Tjg++5Vu/48HcibcKLGEIxQVzCZUDrBf
         3aGO2qR/eVwCsdLfOxcreNFzPe5RqWCGkUCrnhLLBIgOoh+kYNf4bW+NnB8wIrJCmiAQ
         /VnOIAnAdASh16xcgGb0keFf6QqizOmTSGHJmXFMFJK3zd2n62kHrSZ0ueKCT2P+V427
         7vUw==
X-Forwarded-Encrypted: i=1; AKwUvBxTM9IItGISoKNwJrhS5vcfJRdBiihB6lJqaiIxhVQFDcEI5zOvYoGyXSUAo7wiWr5FLPLE7Z4=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++kit9Xf4c+t2Cx6vMPmgGV0AW0ORtgAA56cyQjEsVGmeN6xfNGw
	MnxbgF5xjosG27ksAHOYjciYzzRqdDbl+j7JGIScM3UzZu8sKn0oJpisgOG7x5yktKYBfkHZOb1
	Zz0os4zGn9jwsWpMIRuywEDblKeUxHiWx/jRWY52O9g==
X-Gm-Gg: AYBFou0RA6cpSyHZAugH2QpiBUrfWFmepHd6MKB67FVEYnJQJuepzg+ws2H9xmFPm18
	+/I57yUiGKEHo0iyoZL8tZlTJ0T/cvjYvVXBO+v7huFoFTXFZRIfMJs6GDyb9AMBaIOeNmkmQU8
	msajGjHwYkl+D20QBcQWXz6oEt6rI4G9CJLjyBoKGh0Mz68ppznSDblhOpGdRCVXPGKw1p3VVRH
	5Yhgjw62oLHJp/IuZJRwm9uwoL3PEmpjgcjzI0MdvI0YNv6nTq9TJ9AOF0R0gxIjHFiG7KGeXRc
	b1TTSqNMQDrkqPxF6JF9Nx1kNcMQOdBl1o1mwosWbdpEIarRbHY+HZhVdRlxzvCwPoXDXFfgKPn
	awoAYHT2xATqDuRFd6AJe8iNyjhy+ZcvynWHfcCaCn91LbzIY6+COAsz78UUZJv0AL/05gsAhpb
	8=
X-Received: by 2002:a05:600c:1986:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-49ea528e2f5mr24120835e9.0.1789553548884; Wed, 16 Sep 2026
 03:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
 <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
In-Reply-To: <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 16 Sep 2026 15:42:16 +0530
X-Gm-Features: AcwNN1XhJcdypVFFKePBGQrRcccPnauqo1pQsJ8HQwZetdLhE4E6-eyGGrD9-yI
Message-ID: <CAAhSdy3Or_uDWuQniUGguc9AwL8smF6XHhJ0kizFOJKJ0N+9OA@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] dt-bindings: tee: add RISC-V RPMI TEE transport
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.80 / 15.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[google.com:s=arc-20260327:i=1];
	R_DKIM_ALLOW(-0.20)[brainfault.org:s=google];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:15169, ipnet:74.125.225.0/24, country:US];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.225.140:from];
	R_SPF_NA(0.00)[no SPF record];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.225.140:from];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	PREVIOUSLY_DELIVERED(0.00)[op-tee@lists.trustedfirmware.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[brainfault.org];
	DKIM_TRACE(0.00)[brainfault.org:+]
X-Rspamd-Server: lists.trustedfirmware.org
X-Rspamd-Queue-Id: D91C844438
X-Spamd-Bar: --
X-MailFrom: anup@brainfault.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: JTMMJUOUB3UAFL4KAJ2QYTSQ2DJ6VU3Z
X-Message-ID-Hash: JTMMJUOUB3UAFL4KAJ2QYTSQ2DJ6VU3Z
X-Mailman-Approved-At: Wed, 16 Sep 2026 11:16:25 +0000
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/JTMMJUOUB3UAFL4KAJ2QYTSQ2DJ6VU3Z/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Sat, Sep 12, 2026 at 3:45=E2=80=AFPM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Add a device-tree binding for the OP-TEE RISC-V transport using the RPMI
> TEE service group over SBI MPXY.
>
> Describe one mailbox channel per hart and an optional interrupt used as
> the availability doorbell for asynchronous notifications.
>
> Add the binding to the existing OP-TEE MAINTAINERS entry.
>
> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> ---
>  .../bindings/tee/riscv,rpmi-mpxy-tee.yaml          | 65 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 66 insertions(+)
>
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
> +  The RISC-V Platform Management Interface (RPMI) [1] defines a messagin=
g
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

I am not sure why you need separate MPXY channel per hart. The MPXY shared
memory is already per-hart whereas the MPXY channel will be doman specific
for TEE.

Also, for this binding refererring to only mailbox channel is
sufficient. The underlying
mechanism to send RPMI messages is abstracted away by the mailbox controlle=
r
driver.

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

This must be "riscv,rpmi-tee" based on above comments.

> +        mboxes =3D <&mpxy_mbox 0x10 0x0>, <&mpxy_mbox 0x11 0x0>;

Like mentioned above, only one mailbox channel is sufficient.

> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 207a6e2db70c..7d0e550085b2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20577,6 +20577,7 @@ M:      Jens Wiklander <jenswi@kernel.org>
>  L:     op-tee@lists.trustedfirmware.org (moderated for non-subscribers)
>  S:     Maintained
>  F:     Documentation/ABI/testing/sysfs-bus-optee-devices
> +F:     Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
>  F:     drivers/tee/optee/
>
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>
> --
> 2.34.1
>

Regards,
Anup
