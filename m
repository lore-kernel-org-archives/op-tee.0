From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH 2/4] dt-bindings: remoteproc: add compatibility for TEE support
Date: Wed, 17 Jan 2024 07:45:12 +0000
Message-ID: <b4f21821-fbfc-42cc-8bfb-ee8d650b46e1@foss.st.com>
In-Reply-To: <20240116192145.GA265232-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7920016445584958333=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7920016445584958333==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 1/16/24 20:21, Rob Herring wrote:
> On Mon, Jan 15, 2024 at 02:52:47PM +0100, Arnaud Pouliquen wrote:
>> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
>> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
>> (TEE).
>> This compatible is used in both the Linux and OP-TEE device-tree.
>> - In OP-TEE, a node is defined in the device tree with the
>>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>>   the firmware.
>> - On Linux, when the compatibility is set, the Cortex-M resets should not
>>   be declared in the device tree.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 53 +++++++++++++++----
>>  1 file changed, 44 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.y=
aml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> index 370af61d8f28..9fdfa30eff20 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> @@ -16,7 +16,12 @@ maintainers:
>> =20
>>  properties:
>>    compatible:
>> -    const: st,stm32mp1-m4
>> +    enum:
>> +      - st,stm32mp1-m4
>> +      - st,stm32mp1-m4-tee
>> +    description:
>> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by Li=
nux
>=20
> What if other OSs want to manage the M4?

Right, for instance this compatibles are also used by U-boot. I will change
 "by Linux"  by "by non secure context"


>=20
>> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management b=
y secure context
>> =20
>>    reg:
>>      description:
>> @@ -142,21 +147,41 @@ properties:
>>  required:
>>    - compatible
>>    - reg
>> -  - resets
>> =20
>>  allOf:
>>    - if:
>>        properties:
>> -        reset-names:
>> -          not:
>> -            contains:
>> -              const: hold_boot
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp1-m4
>> +    then:
>> +      if:
>> +        properties:
>> +          reset-names:
>> +            not:
>> +              contains:
>> +                const: hold_boot
>> +      then:
>> +        required:
>> +          - st,syscfg-holdboot
>> +          - resets
>> +      else:
>> +        properties:
>> +          st,syscfg-holdboot: false
>> +        required:
>> +          - reset-names
>=20
> Looks like a new required property.

I just realize that it does not make sense. We execute this
only if "reset-names" contains "hold_boot".
I will remove it

Thanks!
Arnaud

>=20
>> +          - resets
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: st,stm32mp1-m4-tee
>>      then:
>> -      required:
>> -        - st,syscfg-holdboot
>> -    else:
>>        properties:
>>          st,syscfg-holdboot: false
>> +        reset-names: false
>> +        resets: false
>> =20
>>  additionalProperties: false
>> =20
>> @@ -188,5 +213,15 @@ examples:
>>        st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
>>        st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
>>      };
>> +  - |
>> +    #include <dt-bindings/reset/stm32mp1-resets.h>
>> +    m4(a)10000000 {
>> +      compatible =3D "st,stm32mp1-m4-tee";
>> +      reg =3D <0x10000000 0x40000>,
>> +            <0x30000000 0x40000>,
>> +            <0x38000000 0x10000>;
>> +      st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
>> +      st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
>> +    };
>> =20
>>  ...
>> --=20
>> 2.25.1
>>

--===============7920016445584958333==--

