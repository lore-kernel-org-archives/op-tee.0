From: Rob Herring <robh@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v3 5/7] dt-bindings: remoteproc: Add compatibility for TEE support
Date: Thu, 22 Feb 2024 12:24:30 -0600
Message-ID: <170862626977.3652711.10744856298270939089.robh@kernel.org>
In-Reply-To: <20240214172127.1022199-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0487324726449661572=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0487324726449661572==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On Wed, 14 Feb 2024 18:21:25 +0100, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
> (TEE).
> For instance, this compatible is used in both the Linux and OP-TEE
> device-tree:
> - In OP-TEE, a node is defined in the device tree with the
>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>   the firmware.
> - On Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> V1 to V2 updates
> - update "st,stm32mp1-m4" compatible description to generalize
> - remove the 'reset-names' requirement in one conditional branch, as the
>   property is already part of the condition test.
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 51 ++++++++++++++++---
>  1 file changed, 43 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


--===============0487324726449661572==--

