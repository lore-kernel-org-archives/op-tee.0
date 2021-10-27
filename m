From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 2/6] dt-bindings: arm: optee: add interrupt property
Date: Wed, 27 Oct 2021 11:42:33 +0200
Message-ID: 
 <CAHUa44GQvN_8Y5jM+TPbnoPeHpz9hybr5i8YPeArGP9Sxk9Z=Q@mail.gmail.com>
In-Reply-To: <1635271409.203246.2939412.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0509858839716431987=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0509858839716431987==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 26, 2021 at 8:03 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 26 Oct 2021 10:31:34 +0200, Jens Wiklander wrote:
> > Adds an optional interrupt property to the optee binding.
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.examp=
le.dts:23.31-32 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/a=
rm/firmware/linaro,optee-tz.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1441: dt_binding_check] Error 2
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/1546320
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

Thanks, I'll fix that in the next version.

Cheers,
Jens

--===============0509858839716431987==--

