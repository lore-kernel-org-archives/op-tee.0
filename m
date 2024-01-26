From: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 2/4] dt-bindings: remoteproc: Add compatibility for TEE support
Date: Fri, 26 Jan 2024 13:59:12 +0000
Message-ID: <6e45d577-ab03-457e-ada6-1b75735d42ed@foss.st.com>
In-Reply-To: <75429209-8f30-4880-8f92-ecb3cf90ae33@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7613082198912323051=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7613082198912323051==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof,

On 1/26/24 12:03, Krzysztof Kozlowski wrote:
> On 18/01/2024 11:04, Arnaud Pouliquen wrote:
>> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
>> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
>> (TEE).
>> For instance, this compatible is used in both the Linux and OP-TEE
>> device-tree:
>> - In OP-TEE, a node is defined in the device tree with the
>>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>>   the firmware.
>> - On Linux, when the compatibility is set, the Cortex-M resets should not
>>   be declared in the device tree.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
>> ---
>> V1 to V2 updates
>> - update "st,stm32mp1-m4" compatible description to generalize
>> - remove the 'reset-names' requirement in one conditional branch, as the
>>   property is already part of the condition test.
>> ---
>>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 52 +++++++++++++++----
>>  1 file changed, 43 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.y=
aml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
>> index 370af61d8f28..6af821b15736 100644
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

Yes the point is valid, I asked myself the question.

I proposed a compatibility solution for one main reason. On the STM32MP15, if
the firmware is loaded by Linux, no driver is probed in OP-TEE. But if the
firmware is authenticated and loaded by OP-TEE, a Op-TEE driver is probed to
manage memory access rights.

The drawback of a property is that we would need to probe the OP-TEE driver f=
or
the STM32MP1 platform even if it is not used, just to check this property.

Thanks,
Arnaud

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
>=20
> Best regards,
> Krzysztof
>=20

--===============7613082198912323051==--

