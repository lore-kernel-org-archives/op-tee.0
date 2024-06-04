From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [RESEND PATCH v5 3/7] dt-bindings: remoteproc: Add processor
 identifier property
Date: Tue, 04 Jun 2024 09:30:27 +0200
Message-ID: <994b6d3c-26f8-483b-8286-3780adb50b56@foss.st.com>
In-Reply-To: <20240603143553.GA391578-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2064689917945736771=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2064689917945736771==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Rob

On 6/3/24 16:35, Rob Herring wrote:
> On Tue, May 21, 2024 at 02:24:54PM +0200, Arnaud Pouliquen wrote:
>> Add the "st,proc-id" property allowing to identify the remote processor.
>> This ID is used to define an unique ID, common between Linux, U-boot and
>> OP-TEE to identify a coprocessor.
>> This ID will be used in request to OP-TEE remoteproc Trusted Application
>> to specify the remote processor.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>>  .../devicetree/bindings/remoteproc/st,stm32-rproc.yaml     | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.y=
aml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> index 36ea54016b76..409123cd4667 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> @@ -48,6 +48,10 @@ properties:
>>            - description: The offset of the hold boot setting register
>>            - description: The field mask of the hold boot
>> =20
>> +  st,proc-id:
>> +    description: remote processor identifier
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>>    st,syscfg-tz:
>>      deprecated: true
>>      description:
>> @@ -182,6 +186,8 @@ allOf:
>>          st,syscfg-holdboot: false
>>          reset-names: false
>>          resets: false
>> +      required:
>> +        - st,proc-id
>=20
> New required properties are an ABI break. If that is okay, explain why=20
> in the commit message.

This commit is the complement the patch 2/7. the require property is associat=
ed
to a new compatible. I created this commit as you already reviewed the 2/7

Perhaps It might be clearer if I merge the two.

Thanks,
Arnaud

>=20
>> =20
>>  additionalProperties: false
>> =20
>> @@ -220,6 +226,7 @@ examples:
>>        reg =3D <0x10000000 0x40000>,
>>              <0x30000000 0x40000>,
>>              <0x38000000 0x10000>;
>> +      st,proc-id =3D <0>;
>>        st,syscfg-rsc-tbl =3D <&tamp 0x144 0xFFFFFFFF>;
>>        st,syscfg-m4-state =3D <&tamp 0x148 0xFFFFFFFF>;
>>      };
>> --=20
>> 2.25.1
>>

--===============2064689917945736771==--

