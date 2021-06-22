From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 3/7] dt-bindings: arm: optee: add interrupt property
Date: Tue, 22 Jun 2021 10:41:45 +0200
Message-ID: 
 <CAHUa44ELTefa32oa3Zq+gFG+G1hfjMyMY9sf_fDPFmphf9-APw@mail.gmail.com>
In-Reply-To: <20210616160557.GB3472903@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4945337677963661689=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4945337677963661689==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 6:06 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 16, 2021 at 12:36:45PM +0200, Jens Wiklander wrote:
> > Adds an optional interrupt property to the optee binding.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-=
tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > index c931b030057f..3efbe11b637d 100644
> > --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> > @@ -24,6 +24,9 @@ properties:
> >              for the reference implementation maintained by Linaro.
> >            const: linaro,optee-tz
> >
> > +  interrupts:
> > +    maxItems: 1
> > +
> >    method:
> >      description: The method of calling the OP-TEE Trusted OS.
> >      $ref: /schemas/types.yaml#/definitions/string-array
> > @@ -37,6 +40,10 @@ properties:
> >            in drivers/tee/optee/optee_smc.h
> >          const: hvc
> >
> > +required:
> > +  - compatible
> > +  - method
> > +
>
> This should go in the first patch.

OK, that will be covered when I rebase the next patch set on what's
now be78329717e4 ("dt-bindings: arm: firmware: Convert linaro,optee-tz
to json schema") in linux-next.

Thanks,
Jens

>
> >  additionalProperties: false
> >
> >  examples:
> > @@ -45,5 +52,6 @@ examples:
> >        optee {
> >          compatible =3D "linaro,optee-tz";
> >          method =3D "smc";
> > +        interrupts =3D <0 187 4>;
> >        };
> >      };
> > --
> > 2.31.1

--===============4945337677963661689==--

