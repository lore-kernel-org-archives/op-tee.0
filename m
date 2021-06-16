From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 2/7] dt-bindings: arm: Convert optee binding to json-schema
Date: Wed, 16 Jun 2021 10:05:14 -0600
Message-ID: <20210616160514.GA3472903@robh.at.kernel.org>
In-Reply-To: <20210616103649.2662395-3-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4163528793467290155=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4163528793467290155==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 12:36:44PM +0200, Jens Wiklander wrote:
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

Other than the indentation,

Reviewed-by: Rob Herring <robh@kernel.org>=20

--===============4163528793467290155==--

