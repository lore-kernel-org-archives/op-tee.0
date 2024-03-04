From: Balint Dobszay <balint.dobszay@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 3/3] Documentation: tee: Add TS-TEE driver
Date: Mon, 04 Mar 2024 10:05:50 +0100
Message-ID: <96D25150-1FBC-4DEA-A202-CA85E718FAA7@arm.com>
In-Reply-To: <
 <CAFA6WYP4WVv2H4_2PAn_BOUpYYbG1SDcWL0Gmd6c0ECiH62c_w@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3864599861659156655=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3864599861659156655==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 27 Feb 2024, at 8:14, Sumit Garg wrote:

> On Fri, 23 Feb 2024 at 15:23, Balint Dobszay <balint.dobszay@arm.com> wro=
te:
>>
>> Add documentation for the Trusted Services TEE driver.
>>
>> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
>> ---
>>  Documentation/tee/index.rst  |  1 +
>>  Documentation/tee/ts-tee.rst | 71 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 72 insertions(+)
>>  create mode 100644 Documentation/tee/ts-tee.rst
>>
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit

Thanks, I'll apply the tag in the next version.

Regards,
Balint

>> diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
>> index a23bd08847e5..4be6e69d7837 100644
>> --- a/Documentation/tee/index.rst
>> +++ b/Documentation/tee/index.rst
>> @@ -10,6 +10,7 @@ TEE Subsystem
>>     tee
>>     op-tee
>>     amd-tee
>> +   ts-tee
>>
>>  .. only::  subproject and html
>>
>> diff --git a/Documentation/tee/ts-tee.rst b/Documentation/tee/ts-tee.rst
>> new file mode 100644
>> index 000000000000..843e34422648
>> --- /dev/null
>> +++ b/Documentation/tee/ts-tee.rst
>> @@ -0,0 +1,71 @@
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
>> +All Trusted Services (TS) SPs have the same FF-A UUID; it identifies the =
TS RPC
>> +protocol. A TS SP can host one or more services (e.g. PSA Crypto, PSA ITS=
, etc).
>> +A service is identified by its service UUID; the same type of service can=
not be
>> +present twice in the same SP. During SP boot each service in the SP is as=
signed
>> +an "interface ID". This is just a short ID to simplify message addressing.
>> +
>> +The generic TEE design is to share memory at once with the Trusted OS, wh=
ich can
>> +then be reused to communicate with multiple applications running on the T=
rusted
>> +OS. However, in case of FF-A, memory sharing works on an endpoint level, =
i.e.
>> +memory is shared with a specific SP. User space has to be able to separat=
ely
>> +share memory with each SP based on its endpoint ID; therefore a separate =
TEE
>> +device is registered for each discovered TS SP. Opening the SP correspond=
s to
>> +opening the TEE device and creating a TEE context. A TS SP hosts one or m=
ore
>> +services. Opening a service corresponds to opening a session in the given
>> +tee_context.
>> +
>> +Overview of a system with Trusted Services components::
>> +
>> +   User space                  Kernel space                   Secure world
>> +   ~~~~~~~~~~                  ~~~~~~~~~~~~                   ~~~~~~~~~~~~
>> +   +--------+                                               +------------=
-+
>> +   | Client |                                               | Trusted    =
 |
>> +   +--------+                                               | Services SP=
 |
>> +      /\                                                    +------------=
-+
>> +      ||                                                          /\
>> +      ||                                                          ||
>> +      ||                                                          ||
>> +      \/                                                          \/
>> +   +-------+                +----------+--------+           +------------=
-+
>> +   | libts |                |  TEE     | TS-TEE |           |  FF-A SPMC =
 |
>> +   |       |                |  subsys  | driver |           |   + SPMD   =
 |
>> +   +-------+----------------+----+-----+--------+-----------+------------=
-+
>> +   |      Generic TEE API        |     |  FF-A  |     TS RPC protocol    =
 |
>> +   |      IOCTL (TEE_IOC_*)      |     | driver |        over FF-A       =
 |
>> +   +-----------------------------+     +--------+------------------------=
-+
>> +
>> +References
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +[1] https://www.trustedfirmware.org/projects/trusted-services/
>> +
>> +[2] https://developer.arm.com/documentation/den0077/
>> +
>> +[3] https://www.arm.com/architecture/security-features/platform-security
>> +
>> +[4] drivers/firmware/arm_ffa/
>> +
>> +[5] https://trusted-services.readthedocs.io/en/v1.0.0/developer/service-a=
ccess-protocols.html#abi
>> +
>> +[6] https://git.trustedfirmware.org/TS/trusted-services.git/tree/componen=
ts/rpc/ts_rpc/caller/linux/ts_rpc_caller_linux.c?h=3Dv1.0.0
>> +
>> +[7] https://git.trustedfirmware.org/TS/trusted-services.git/tree/deployme=
nts/libts/arm-linux/CMakeLists.txt?h=3Dv1.0.0
>> --
>> 2.34.1
>>

--===============3864599861659156655==--

