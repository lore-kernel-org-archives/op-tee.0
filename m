From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 2/6] dt-bindings: arm: optee: add interrupt property
Date: Tue, 26 Oct 2021 13:03:29 -0500
Message-ID: <1635271409.203246.2939412.nullmailer@robh.at.kernel.org>
In-Reply-To: <20211026083138.1818705-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6678393489908447187=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6678393489908447187==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Oct 2021 10:31:34 +0200, Jens Wiklander wrote:
> Adds an optional interrupt property to the optee binding.
>=20
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20

My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.example=
.dts:23.31-32 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/arm=
/firmware/linaro,optee-tz.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1546320

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


--===============6678393489908447187==--

