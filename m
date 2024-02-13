From: Randy Dunlap <rdunlap@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 3/3] Documentation: tee: Add TS-TEE driver
Date: Tue, 13 Feb 2024 13:44:45 -0800
Message-ID: <bbb40718-9bfa-4431-a3b0-c09d068fd6cc@infradead.org>
In-Reply-To: <20240213145239.379875-4-balint.dobszay@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4291177602963545938=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4291177602963545938==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi--

On 2/13/24 06:52, Balint Dobszay wrote:
> Add documentation for the Trusted Services TEE driver.
>=20
> Signed-off-by: Balint Dobszay <balint.dobszay@arm.com>
> ---
>  Documentation/tee/index.rst  |  1 +
>  Documentation/tee/ts-tee.rst | 70 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/tee/ts-tee.rst
>=20

> diff --git a/Documentation/tee/ts-tee.rst b/Documentation/tee/ts-tee.rst
> new file mode 100644
> index 000000000000..e121ebbbfab7
> --- /dev/null
> +++ b/Documentation/tee/ts-tee.rst
> @@ -0,0 +1,70 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +TS-TEE (Trusted Services project)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This driver provides access to secure services implemented by Trusted Serv=
ices.
> +
> +Trusted Services [1] is a TrustedFirmware.org project that provides a fram=
ework
> +for developing and deploying device Root of Trust services in FF-A [2] S-E=
L0
> +Secure Partitions. The project hosts the reference implementation of the A=
rm
> +Platform Security Architecture [3] for Arm A-profile devices.
> +
> +The FF-A Secure Partitions (SP) are accessible through the FF-A driver [4]=
 which
> +provides the low level communication for this driver. On top of that the T=
rusted
> +Services RPC protocol is used [5]. To use the driver from user space a ref=
erence
> +implementation is provided at [6], which is part of the Trusted Services c=
lient
> +library called libts [7].
> +

Fix run-on sentences:

> +All Trusted Services (TS) SPs have the same FF-A UUID, it identifies the T=
S RPC

                                                    UUID. It
or
                                                    UUIT; it

> +protocol. A TS SP can host one or more services (e.g. PSA Crypto, PSA ITS,=
 etc).
> +A service is identified by its service UUID, the same type of service cann=
ot be

                                          UUID;

> +present twice in the same SP. During SP boot each service in the SP is ass=
igned
> +an "interface ID", this is just a short ID to simplify message addressing.

      "interface ID." This

> +
> +The generic TEE design is to share memory at once with the TEE implementat=
ion,
> +which can then be reused to communicate with multiple TAs. However, in cas=
e of

"TA" is not defined.

> +FF-A, memory sharing works on an endpoint level, i.e. memory is shared wit=
h a
> +specific SP. User space has to be able to separately share memory with eac=
h SP
> +based on its endpoint ID, therefore a separate TEE device is registered fo=
r each

                         ID; therefore

> +discovered TS SP. Opening the SP corresponds to opening the TEE device and
> +creating a TEE context. A TS SP hosts one or more services, opening a serv=
ice

                                                     services. Opening

> +corresponds to opening a session in the given tee_context.
> +
> +Overview of a system with Trusted Services components::
> +
> +   User space                  Kernel space                   Secure world
> +   ~~~~~~~~~~                  ~~~~~~~~~~~~                   ~~~~~~~~~~~~
> +   +--------+                                               +-------------+
> +   | Client |                                               | Trusted     |
> +   +--------+                                               | Services SP |
> +      /\                                                    +-------------+
> +      ||                                                          /\
> +      ||                                                          ||
> +      ||                                                          ||
> +      \/                                                          \/
> +   +-------+                +----------+--------+           +-------------+
> +   | libts |                |  TEE     | TS-TEE |           |  FF-A SPMC  |
> +   |       |                |  subsys  | driver |           |   + SPMD    |
> +   +-------+----------------+----+-----+--------+-----------+-------------+
> +   |      Generic TEE API        |     |  FF-A  |     TS RPC protocol     |
> +   |      IOCTL (TEE_IOC_*)      |     | driver |        over FF-A        |
> +   +-----------------------------+     +--------+-------------------------+
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +[1] https://www.trustedfirmware.org/projects/trusted-services/
> +
> +[2] https://developer.arm.com/documentation/den0077/
> +
> +[3] https://www.arm.com/architecture/security-features/platform-security
> +
> +[4] drivers/firmware/arm_ffa/
> +
> +[5] https://trusted-services.readthedocs.io/en/v1.0.0/developer/service-ac=
cess-protocols.html#abi
> +
> +[6] https://git.trustedfirmware.org/TS/trusted-services.git/tree/component=
s/rpc/ts_rpc/caller/linux/ts_rpc_caller_linux.c?h=3Dv1.0.0
> +
> +[7] https://git.trustedfirmware.org/TS/trusted-services.git/tree/deploymen=
ts/libts/arm-linux/CMakeLists.txt?h=3Dv1.0.0

--=20
#Randy

--===============4291177602963545938==--

