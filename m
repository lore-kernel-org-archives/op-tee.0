From: "Rob Herring (Arm)" <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v6 3/5] dt-bindings: remoteproc: Add compatibility for TEE support
Date: Fri, 07 Jun 2024 10:46:22 -0600
Message-ID: <171777877866.3290379.8347507744430863687.robh@kernel.org>
In-Reply-To: <20240607093326.369090-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6304549952051923277=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6304549952051923277==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On Fri, 07 Jun 2024 11:33:24 +0200, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted Execution Environment
> (TEE).
>=20
> For instance, this compatible is used in both the Linux and OP-TEE device
> trees:
> - In OP-TEE, a node is defined in the device tree with the
>   "st,stm32mp1-m4-tee" compatible to support signed remoteproc firmware.
>   Based on DT properties, the OP-TEE remoteproc framework is initiated to
>   expose a trusted application service to authenticate and load the remote
>   processor firmware provided by the Linux remoteproc framework, as well
>   as to start and stop the remote processor.
> - In Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree. In such a configuration, the reset is
>   managed by the OP-TEE remoteproc driver and is no longer accessible from
>   the Linux kernel.
>=20
> Associated with this new compatible, add the "st,proc-id" property to
> identify the remote processor. This ID is used to define a unique ID,
> common between Linux, U-Boot, and OP-TEE, to identify a coprocessor.
> This ID will be used in requests to the OP-TEE remoteproc Trusted
> Application to specify the remote processor.
>=20
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> update vs previous version
> - merge [PATCH v5 4/7] remoteproc: core introduce rproc_set_rsc_table_on_st=
art function
>   as new "st,proc-id" is associated to "st,stm32mp1-m4-tee" compatible
> - update commit message
> - remove Reviewed-by: Rob Herring <robh@kernel.org> as patch is updated
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 58 ++++++++++++++++---
>  1 file changed, 50 insertions(+), 8 deletions(-)
>=20

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


--===============6304549952051923277==--

