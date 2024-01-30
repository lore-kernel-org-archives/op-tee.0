From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add compatibility for TEE support
Date: Tue, 30 Jan 2024 11:21:56 -0600
Message-ID: <20240130172156.GA2008728-robh@kernel.org>
In-Reply-To: <75429209-8f30-4880-8f92-ecb3cf90ae33@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4239076851716081047=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4239076851716081047==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 12:03:25PM +0100, Krzysztof Kozlowski wrote:
> On 18/01/2024 11:04, Arnaud Pouliquen wrote:
> > The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> > where the Cortex-M4 firmware is loaded by the Trusted execution Environme=
nt
> > (TEE).
> > For instance, this compatible is used in both the Linux and OP-TEE
> > device-tree:
> > - In OP-TEE, a node is defined in the device tree with the
> >   st,stm32mp1-m4-tee to support signed remoteproc firmware.
> >   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
> >   the firmware.
> > - On Linux, when the compatibility is set, the Cortex-M resets should not
> >   be declared in the device tree.
> >=20
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> > ---
> > V1 to V2 updates
> > - update "st,stm32mp1-m4" compatible description to generalize
> > - remove the 'reset-names' requirement in one conditional branch, as the
> >   property is already part of the condition test.
> > ---
> >  .../bindings/remoteproc/st,stm32-rproc.yaml   | 52 +++++++++++++++----
> >  1 file changed, 43 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.=
yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> > index 370af61d8f28..6af821b15736 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> > @@ -16,7 +16,12 @@ maintainers:
> > =20
> >  properties:
> >    compatible:
> > -    const: st,stm32mp1-m4
> > +    enum:
> > +      - st,stm32mp1-m4
> > +      - st,stm32mp1-m4-tee
>=20
> The patch looks good to me, but I wonder about this choice of two
> compatibles.
>=20
> Basically this is the same hardware with the same interface, but two
> compatibles to differentiate a bit different firmware setup. We have
> already such cases for Qualcomm [1] [2] and new ones will be coming. [3]
>=20
> I wonder whether this should be rather the same compatible with
> additional property, e.g. "st,tee-control" or "remote-control".
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.7.1/source/Documentation/devicetree/bin=
dings/dma/qcom,bam-dma.yaml#L54
>=20
> [2]
> https://elixir.bootlin.com/linux/v6.7.1/source/Documentation/devicetree/bin=
dings/net/qcom,ipa.yaml#L129
> (that's a bit different)
>=20
> [3] https://lore.kernel.org/linux-devicetree/20240124103623.GJ4906(a)thinkp=
ad/
>=20
> @Rob,
> Any general guidance for this and Qualcomm?

I think we have cases using compatible already as well. Either way is=20
fine with me.

Rob

--===============4239076851716081047==--

