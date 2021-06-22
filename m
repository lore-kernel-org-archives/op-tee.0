From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 2/7] dt-bindings: arm: Convert optee binding to json-schema
Date: Tue, 22 Jun 2021 10:38:50 +0200
Message-ID: 
 <CAHUa44Gg6+1JWyfVg1Em=kgCVpHav5jXc48a7K8D+t7L8S1pDQ@mail.gmail.com>
In-Reply-To: <20210616160514.GA3472903@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4136172769855952254=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4136172769855952254==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 16, 2021 at 6:05 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 16, 2021 at 12:36:44PM +0200, Jens Wiklander wrote:
> > Converts the optee binding to use DT schema format.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ------------
> >  .../arm/firmware/linaro,optee-tz.yaml         | 49 +++++++++++++++++++
> >  2 files changed, 49 insertions(+), 31 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro=
,optee-tz.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro=
,optee-tz.yaml
>
> Other than the indentation,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks Rob. Nishanth reminded me of
https://lore.kernel.org/linux-arm-kernel/20210503191327.GA2217487(a)robh.at.k=
ernel.org/,
aka be78329717e4 ("dt-bindings: arm: firmware: Convert linaro,optee-tz
to json schema") in linux-next. I'll wait for that one to land
upstream instead.

Cheers,
Jens

--===============4136172769855952254==--

