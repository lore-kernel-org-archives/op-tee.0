From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 3/3] Documentation: tee: Add TS-TEE driver
Date: Wed, 14 Feb 2024 17:56:41 +0100
Message-ID: <40BCD479-90FC-4B32-AA97-A7B39CA8A3FC@arm.com>
In-Reply-To: <bbb40718-9bfa-4431-a3b0-c09d068fd6cc@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6948963798324637332=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6948963798324637332==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On 13 Feb 2024, at 22:44, Randy Dunlap wrote:

> Hi--
>
> On 2/13/24 06:52, Balint Dobszay wrote:
>> Add documentation for the Trusted Services TEE driver.
>>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>>  Documentation/tee/index.rst  |  1 +
>>  Documentation/tee/ts-tee.rst | 70 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 71 insertions(+)
>>  create mode 100644 Documentation/tee/ts-tee.rst
>>
>
>> diff --git a/Documentation/tee/ts-tee.rst b/Documentation/tee/ts-tee.rst
>> new file mode 100644
>> index 000000000000..e121ebbbfab7
>> --- /dev/null
>> +++ b/Documentation/tee/ts-tee.rst
>> @@ -0,0 +1,70 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +TS-TEE (Trusted Services project)
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +This driver provides access to secure services implemented by Trusted Ser=
vices.
>> +
>> +Trusted Services [1] is a TrustedFirmware.org project that provides a fra=
mework
>> +for developing and deploying device Root of Trust services in FF-A [2] S-=
EL0
>> +Secure Partitions. The project hosts the reference implementation of the =
Arm
>> +Platform Security Architecture [3] for Arm A-profile devices.
>> +
>> +The FF-A Secure Partitions (SP) are accessible through the FF-A driver [4=
] which
>> +provides the low level communication for this driver. On top of that the =
Trusted
>> +Services RPC protocol is used [5]. To use the driver from user space a re=
ference
>> +implementation is provided at [6], which is part of the Trusted Services =
client
>> +library called libts [7].
>> +
>
> Fix run-on sentences:
>
>> +All Trusted Services (TS) SPs have the same FF-A UUID, it identifies the =
TS RPC
>
>                                                     UUID. It
> or
>                                                     UUIT; it
>
>> +protocol. A TS SP can host one or more services (e.g. PSA Crypto, PSA ITS=
, etc).
>> +A service is identified by its service UUID, the same type of service can=
not be
>
>                                           UUID;
>
>> +present twice in the same SP. During SP boot each service in the SP is as=
signed
>> +an "interface ID", this is just a short ID to simplify message addressing.
>
>       "interface ID." This
>
>> +
>> +The generic TEE design is to share memory at once with the TEE implementa=
tion,
>> +which can then be reused to communicate with multiple TAs. However, in ca=
se of
>
> "TA" is not defined.
>
>> +FF-A, memory sharing works on an endpoint level, i.e. memory is shared wi=
th a
>> +specific SP. User space has to be able to separately share memory with ea=
ch SP
>> +based on its endpoint ID, therefore a separate TEE device is registered f=
or each
>
>                          ID; therefore
>
>> +discovered TS SP. Opening the SP corresponds to opening the TEE device and
>> +creating a TEE context. A TS SP hosts one or more services, opening a ser=
vice
>
>                                                      services. Opening

Thanks for the comments, I'll address them in the next version.

Regards,
Balint

--===============6948963798324637332==--

