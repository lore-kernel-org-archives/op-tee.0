From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 2/7] dt-bindings: arm: Convert optee binding to json-schema
Date: Wed, 16 Jun 2021 10:03:05 -0600
Message-ID: <1623859385.179062.3471586.nullmailer@robh.at.kernel.org>
In-Reply-To: <20210616103649.2662395-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3980952407301722026=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3980952407301722026==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jun 2021 12:36:44 +0200, Jens Wiklander wrote:
> Converts the optee binding to use DT schema format.
>=20
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ------------
>  .../arm/firmware/linaro,optee-tz.yaml         | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,o=
ptee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,o=
ptee-tz.yaml
>=20

My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml:21:7: [=
warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
\ndoc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1492865

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.


--===============3980952407301722026==--

