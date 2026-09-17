Return-Path: <op-tee-bounces+op-tee=archiver.kernel.org@lists.trustedfirmware.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.trustedfirmware.org (lists.trustedfirmware.org [18.214.241.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9C9C88E72
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 08:51:38 +0000 (UTC)
Received: from lists.trustedfirmware.org (localhost [127.0.0.1])
	by lists.trustedfirmware.org (Postfix) with ESMTP id 8999F45199
	for <op-tee@archiver.kernel.org>; Thu, 17 Sep 2026 08:51:37 +0000 (UTC)
Authentication-Results: lists.trustedfirmware.org;
	dkim=pass (2048-bit key; unprotected) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=Lft7f5gh;
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	by lists.trustedfirmware.org (Postfix) with ESMTPS id 18AB04493B
	for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 08:38:41 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so309394f8f.3
        for <op-tee@lists.trustedfirmware.org>; Thu, 17 Sep 2026 01:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789634320; cv=none;
        d=google.com; s=arc-20260327;
        b=FCOVrFHE6p5SbbGq8Who70ClIOuXomNwbRQWRxvd/5qigkXRVc86kS8r7f/LxweqB4
         Sh77ppEdbKQKJau8cZW1T+TL9rOOED6pl7PAeOD4UfiJWANIXOUsTs6o1PnJ3Hd6tnya
         0SFiSI7oiOTWS5+H1MP3FMboOeVBWha0J/Zg1Kce42pnc3zSCrixxNYe0/5/E1Mayf2z
         j973g1Cxi0UNOCjY4IYkZSdYlByFgmm6x4XMCvCpqqG8I84FxZsIXoeCg/RdWcwGLJVk
         p6SpCT0qVODmCeFVoOTUS0sdhMEjePvv2/eZCGMy348iJ1Zb9li4BS6QwMcvQl43hI65
         dXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+xZ8ugZNSOyGTueNHHUg4rhDx4Y6pOqaVeIryusIch4=;
        fh=zEjQw3VvgSoIfKr1UnAAqr3otQq2yqB6MABLROdVA/8=;
        b=FiT1iv42K3rBcJVwPl/Y0+Jegd9JYUEWwmoAgTp0zz2BAsRqIjVT8XFBkQ/n6anSwj
         Haj5LKKHY+oz7hBHmf9lL/9fF5SrB2ho2M2clZE1f4hAXs/E1et/vQLE+AgvSGOGnzg8
         /bGc/dvy2JU1o/yb8gYouNsd3JwWaCrjcEiahrkSPdtZT6L+Cy2lKQ7hS+Z+LxkigrQS
         20F4JhtO68i+Tfbzs0D6+eOQ4wIV5KBKw3lEYY0dsaGtiOzzlWqZLfJsEFql+aZNH0zy
         aaSdHuVAZXjStfA54IVqlH+eJpeUrsCucDFXggsLyiWWFGyH+I4J9GeZCwsYSxwvqyuY
         1Gtg==;
        darn=lists.trustedfirmware.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1789634320; x=1790239120; darn=lists.trustedfirmware.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+xZ8ugZNSOyGTueNHHUg4rhDx4Y6pOqaVeIryusIch4=;
        b=Lft7f5ghIvVTLMAJYv/PkOia8UTRi4WB2efFJb0TNg7nFhFEILriCuApSVs42tb2yv
         6dLjjMX/W5p9YsArgeTymNeX+GpQEe6CESX8z+FHvOCuuf2oJ3Uj87PMwrDFezv7O1zv
         FNKdKYqgM2Tv2A4wVx1ZCmhf+vj0I7dVHtsbOJ5Ey7VezncxxbHh+gchjvBsXY6e08pj
         mjiwC7OGSWkdKVlQvUaOwbDAZP0QlONzDBFqcmkomP49hq7bG5NeINWIjANaa18wh87k
         nsvVpmp0KhdXwCR6rcj846r1N/CiqRlsUuHhA+7aC3X97YkuepvviJkolI6Tg3GgETFj
         BTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634320; x=1790239120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+xZ8ugZNSOyGTueNHHUg4rhDx4Y6pOqaVeIryusIch4=;
        b=lcpfaI9vtmFHMbvtzd9c/c8Q0wnPZLdJaLD3KmEV4oiSP7PCPTQeiTpe3i0iwq+xyW
         ruMoq+ooQEmduk3l1xqCtuPAJab5hTbEeTGyxuZQHDuqJcB31ofa/5rZMehtr8+lPt0H
         CcfM6n75K6W+1DUm5rq/0H3dbHVYbTxLVxZwxE5/0qN+E65X8Et9slt/uD6wQT/4WLSn
         ibg+Oc06IAQ8rQVsDoDIv5fKR+D/xOjJHbnuCx1QSCYNoxobNVt7u+r+xreVSHJbt7mv
         mq2HpG/Hu4psA7uW2NgW0Xc67anAaMVpF1kCUlYlsvmYRIj80zGF06+O2yk5lik3Fldz
         Twkg==
X-Forwarded-Encrypted: i=1; AKwUvBxQckTsVdJzxhi8S4zy0j6+/z/NJt1myDm8s/fSbFqfOoROivXJyUeByw+xO0yHNOIfZARNKt0=@lists.trustedfirmware.org
X-Gm-Message-State: AFuF++mj5XTJnfWPTT9uexACjkWKE4zDjSENZG+HqFIJjJrxQZMKj6hy
	s5gXYzo9p6rYQIbHK7HJUwHnMih10UPjvNBqVnSCxAT7OYfdWHlVp0E1HD/RpIR7laHcbXIzFZb
	BcSde/HRhmpRcSlwb6zZE8RNOF5S9OBWLiu3DKydIZw==
X-Gm-Gg: AYBFou3ZW9gM1jHOcUQj/3QShJSb0mdZ+Ns1qA7iwXi85m4t1/E3LzMw9CAb8/BwOew
	8JXkd57JE+JvgEfpdKOZowd8ensqjyKZ8XevmQf+dNPXCGU19Ur6pfmphuxX9vZ6ZtVZ1V8+Oy0
	Ao1qlEJLQUkhJFygDs04ps2UTOEHa2SBHJGRp1rhKzCZEcOokAorCmt2JEGxOBPYsjmKbv6N/Vl
	nUlszsx1ByJ1h0oKjWzqUrfdwQpqwJgisIPSwtXA365UrEh3ZcgIO2JhZdHRVv2F4KhJvqu4izF
	MtSOaMBWMyUwhZ96FtqTlD37Bl1/LsFBqiQxhytRr/kuluWi+r6DWOlakz2Qc8GfjqJFlii7vNN
	p+ll0+TBHwr8h2i0kg2Q064c8EwyNk7pgWDOGD+GabQwRVOPIdO5fLoobyVzY6D+njtHh61eNnM
	ZI2rIOEDWU
X-Received: by 2002:a05:6000:654:b0:487:72f:fb42 with SMTP id
 ffacd0b85a97d-4870cf29d90mr13783311f8f.14.1789634319634; Thu, 17 Sep 2026
 01:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260912-rpmi-tee-service-grp-dev-v1-0-1d1d35c2a859@oss.qualcomm.com>
 <20260912-rpmi-tee-service-grp-dev-v1-5-1d1d35c2a859@oss.qualcomm.com>
 <CAAhSdy3Or_uDWuQniUGguc9AwL8smF6XHhJ0kizFOJKJ0N+9OA@mail.gmail.com> <d7ba3e45-84fa-409d-bd43-23caa05587de@oss.qualcomm.com>
In-Reply-To: <d7ba3e45-84fa-409d-bd43-23caa05587de@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Sep 2026 14:08:28 +0530
X-Gm-Features: AcwNN1Vcy0QtpmdJ_pk5OG_hAQ80ZZl7phHzkpnX5C7hVHyAhOEU3VXVGWfW1fk
Message-ID: <CAAhSdy1F1rASWA2Xht_LQF6ixBu1oQDBtdkW2YTiqVDqLczPsg@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] dt-bindings: tee: add RISC-V RPMI TEE transport
To: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.80 / 15.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RWL_MAILSPIKE_POSSIBLE(0.00)[74.125.225.76:from];
	R_SPF_NA(0.00)[no SPF record];
	RCVD_IN_DNSWL_NONE(0.00)[74.125.225.76:from];
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
X-Rspamd-Queue-Id: 18AB04493B
X-Spamd-Bar: --
X-MailFrom: anup@brainfault.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; header-match-op-tee.lists.trustedfirmware.org-0
Message-ID-Hash: XEHQS54AQQVGK3JBCRP4NPY5VSSTRTLM
X-Message-ID-Hash: XEHQS54AQQVGK3JBCRP4NPY5VSSTRTLM
X-Mailman-Approved-At: Thu, 17 Sep 2026 08:51:30 +0000
CC: Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rahul Pathak <rahul@summations.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
X-Mailman-Version: 3.3.5
Precedence: list
List-Id: <op-tee.lists.trustedfirmware.org>
Archived-At: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/message/XEHQS54AQQVGK3JBCRP4NPY5VSSTRTLM/>
List-Archive: <https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedfirmware.org/>
List-Help: <mailto:op-tee-request@lists.trustedfirmware.org?subject=help>
List-Owner: <mailto:op-tee-owner@lists.trustedfirmware.org>
List-Post: <mailto:op-tee@lists.trustedfirmware.org>
List-Subscribe: <mailto:op-tee-join@lists.trustedfirmware.org>
List-Unsubscribe: <mailto:op-tee-leave@lists.trustedfirmware.org>

On Thu, Sep 17, 2026 at 2:46=E2=80=AFAM Amirreza Zarrabi
<amirreza.zarrabi@oss.qualcomm.com> wrote:
>
> Hi Anup,
>
> On 9/16/2026 8:12 PM, Anup Patel wrote:
> > On Sat, Sep 12, 2026 at 3:45=E2=80=AFPM Amirreza Zarrabi
> > <amirreza.zarrabi@oss.qualcomm.com> wrote:
> >>
> >> Add a device-tree binding for the OP-TEE RISC-V transport using the RP=
MI
> >> TEE service group over SBI MPXY.
> >>
> >> Describe one mailbox channel per hart and an optional interrupt used a=
s
> >> the availability doorbell for asynchronous notifications.
> >>
> >> Add the binding to the existing OP-TEE MAINTAINERS entry.
> >>
> >> Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >> ---
> >>  .../bindings/tee/riscv,rpmi-mpxy-tee.yaml          | 65 +++++++++++++=
+++++++++
> >>  MAINTAINERS                                        |  1 +
> >>  2 files changed, 66 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee=
.yaml b/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
> >> new file mode 100644
> >> index 000000000000..8f6ff313fd42
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/tee/riscv,rpmi-mpxy-tee.yaml
> >> @@ -0,0 +1,65 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/tee/riscv,rpmi-mpxy-tee.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: RISC-V RPMI TEE service group based message proxy
> >> +
> >> +maintainers:
> >> +  - Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
> >> +
> >> +description: |
> >> +  The RISC-V Platform Management Interface (RPMI) [1] defines a messa=
ging
> >> +  protocol which is modular and extensible. The supervisor software c=
an
> >> +  send/receive RPMI messages via the SBI MPXY extension [2] or some d=
edicated
> >> +  supervisor-mode RPMI transport.
> >> +
> >> +  The RPMI specification [1] defines a TEE service group which is the=
 RISC-V
> >> +  analog of Arm FF-A: OP-TEE and the rich execution environment (REE,=
 i.e.
> >> +  Linux) are peer endpoints and the RPMI framework (machine mode firm=
ware)
> >> +  mediates every message. Entering OP-TEE on a hart runs it on that h=
art until
> >> +  it responds, so the SBI implementation provides one SBI MPXY channe=
l per
> >> +  hart; all of them are listed, in hart order, on a single node.
> >> +
> >> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +  References
> >> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> >> +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> >> +
> >> +  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> >> +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: riscv,rpmi-mpxy-tee
> >> +
> >> +  mboxes:
> >> +    minItems: 1
> >> +    description:
> >> +      One SBI MPXY channel implementing the RPMI TEE service group pe=
r hart,
> >> +      listed in the same order as the CPU nodes.
> >
> > I am not sure why you need separate MPXY channel per hart. The MPXY sha=
red
> > memory is already per-hart whereas the MPXY channel will be doman speci=
fic
> > for TEE.
>
> True. My reasoning was that TEE_CALL, as I understand it, is expected to =
execute on
> the same hart that issued it. Given that, the mailbox core holds the per-=
channel spinlock
> across the call to `send_data()`, while the underlying `sbi_ecall()` is s=
ynchronous
> and does not return until the TEE call completes.
>
> So, if two harts shared the same channel, a hart executing a long-running=
 TEE operation
> would hold that channel's lock for the duration of the call, and another =
hart
> trying to enqueue on the same channel would spin waiting for it.
>
> Using per-hart channels avoids that cross-hart contention. I agree that t=
his may
> not be the right layer in which to address the issue. I did not pull it t=
o the discussion in to this RFC.
> I'm happy to use single channel for now and follow up on it separately if=
 useful.

The per-channel spinlock serialization is not required for SBI MPXY based
mailbox channels because the underlying SBI implementation will take care
of the serialization where required.

In other words, we need to improve the Linux mailbox framework to allow
SBI MPXY mailbox controller tell Linux mailbox framework to not use
per-channel spinlock based serialization.

One possible approach to enhance Linux mailbox framework is show
below. May be include this (or some other approach) as a separate
patch in your series ?

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index efacd24a085d..437e7e2e6ad5 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -48,7 +48,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *mssg=
)
 static void msg_submit(struct mbox_chan *chan)
 {
  unsigned count, idx;
- void *data;
+ void *data =3D NULL;
  int err =3D -EBUSY;

  scoped_guard(spinlock_irqsave, &chan->lock) {
@@ -66,14 +66,22 @@ static void msg_submit(struct mbox_chan *chan)

  if (chan->cl->tx_prepare)
  chan->cl->tx_prepare(chan->cl, data);
- /* Try to submit a message to the MBOX controller */
- err =3D chan->mbox->ops->send_data(chan, data);
+
+ /* Try to submit a message to the MBOX controller in atomic context */
+ if (chan->mbox->ops->send_data)
+ err =3D chan->mbox->ops->send_data(chan, data);
+ else if (chan->mbox->ops->send_data_nonatomic)
+ err =3D 0;
  if (!err) {
  chan->active_req =3D data;
  chan->msg_count--;
  }
  }

+ /* Try to submit a message to the MBOX controller in non-atomic context *=
/
+ if (!err && chan->mbox->ops->send_data_nonatomic)
+ err =3D chan->mbox->ops->send_data_nonatomic(chan, data);
+
  if (!err && (chan->txdone_method & MBOX_TXDONE_BY_POLL)) {
  /* kick start the timer immediately to avoid delays */
  scoped_guard(spinlock_irqsave, &chan->mbox->poll_hrt_lock)
diff --git a/drivers/mailbox/riscv-sbi-mpxy-mbox.c
b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
index b02c17c2c64e..9afa10c72bd7 100644
--- a/drivers/mailbox/riscv-sbi-mpxy-mbox.c
+++ b/drivers/mailbox/riscv-sbi-mpxy-mbox.c
@@ -420,7 +420,7 @@ static void mpxy_mbox_shutdown(struct mbox_chan *chan)
 }

 static const struct mbox_chan_ops mpxy_mbox_ops =3D {
- .send_data =3D mpxy_mbox_send_data,
+ .send_data_nonatomic =3D mpxy_mbox_send_data,
  .peek_data =3D mpxy_mbox_peek_data,
  .startup =3D mpxy_mbox_startup,
  .shutdown =3D mpxy_mbox_shutdown,
diff --git a/include/linux/mailbox_controller.h
b/include/linux/mailbox_controller.h
index 26a238a6f941..4bc4798c4b1f 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -28,6 +28,10 @@ struct mbox_chan;
  * transmission of data is reported by the controller via
  * mbox_chan_txdone (if it has some TX ACK irq). It must not
  * sleep.
+ * @send_data_nonatomic: The API asks the MBOX controller driver, in non-a=
tomic
+ * context try to transmit a message on the bus. Returns 0 if
+ * data is accepted for transmission, negative error while rejecting
+ * if the remote not acccepted.
  * @flush: Called when a client requests transmissions to be blocking but
  * the context doesn't allow sleeping. Typically the controller
  * will implement a busy loop waiting for the data to flush out.
@@ -53,6 +57,7 @@ struct mbox_chan;
  */
 struct mbox_chan_ops {
  int (*send_data)(struct mbox_chan *chan, void *data);
+ int (*send_data_nonatomic)(struct mbox_chan *chan, void *data);
  int (*flush)(struct mbox_chan *chan, unsigned long timeout);
  int (*startup)(struct mbox_chan *chan);
  void (*shutdown)(struct mbox_chan *chan);

Regards,
Anup
