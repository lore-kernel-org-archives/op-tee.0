From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 1/2] dt-bindings: optee driver interrupt can be a
 per-cpu interrupt
Date: Thu, 30 Mar 2023 11:23:00 +0200
Message-ID: <20230330092300.GB990388@rayden>
In-Reply-To: <
 <CAFA6WYP09nmgXafdqZnpBfoe_rHTDCDy+BV8d8jjC-V9mCADSQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8085530011883816080=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8085530011883816080==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 08:26:22PM +0530, Sumit Garg wrote:
> On Wed, 22 Mar 2023 at 18:52, Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Explicit in optee firmware device tree bindings that the interrupt
> > used by optee driver for async notification can be a peripheral
> > interrupt or a per-cpu interrupt.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> > No change since v5
> >
>=20
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>=20
> -Sumit
>=20
> > No change since v4
> >
> > Changes since v3:
> > - Patch added in this v4 to address review comments.
> > ---
> >  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml      | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-=
tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > index d4dc0749f9fd..5d033570b57b 100644
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -28,7 +28,8 @@ properties:
> >      maxItems: 1
> >      description: |
> >        This interrupt which is used to signal an event by the secure world
> > -      software is expected to be edge-triggered.
> > +      software is expected to be either a per-cpu interrupt or an
> > +      edge-triggered peripheral interrupt.
> >
> >    method:
> >      enum: [smc, hvc]
> > --
> > 2.25.1
> >

--===============8085530011883816080==--

