From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH] Documentation: tee: Document TEE kernel interface
Date: Wed, 03 Jun 2020 17:34:51 +0300
Message-ID: 
 <CAD8XO3Z-JvCYxqbbeGRmjc-KskpykrcfWEGKH9eO6mvG7zHc6Q@mail.gmail.com>
In-Reply-To: <1591183888-11101-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3932553025855575387=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3932553025855575387==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Sumit,

if this doc is for driver developers it might be useful to add some
code examples how to register drivers on tee bus.

Best regards,
Maxim.

On Wed, 3 Jun 2020 at 14:31, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Update documentation with TEE bus infrastructure which provides an
> interface for kernel client drivers to communicate with corresponding
> Trusted Application.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  Documentation/tee.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/tee.txt b/Documentation/tee.txt
> index c8fad81..428d3b5 100644
> --- a/Documentation/tee.txt
> +++ b/Documentation/tee.txt
> @@ -53,6 +53,28 @@ clients, forward them to the TEE and send back the resul=
ts. In the case of
>  supplicants the communication goes in the other direction, the TEE sends
>  requests to the supplicant which then sends back the result.
>
> +The TEE kernel interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Kernel provides a TEE bus infrastructure where a Trusted Application is
> +represented as a device identified via Universally Unique Identifier (UUID=
) and
> +client drivers register a table of supported device UUIDs.
> +
> +TEE bus infrastructure registers following APIs:
> +-  match(): iterates over the client driver UUID table to find a correspon=
ding
> +   match for device UUID. If a match is found, then this particular device=
 is
> +   probed via corresponding probe API registered by the client driver. This
> +   process happens whenever a device or a client driver is registered with=
 TEE
> +   bus.
> +-  uevent(): notifies user-space (udev) whenever a new device is registere=
d on
> +   TEE bus for auto-loading of modularized client drivers.
> +
> +TEE bus device enumeration is specific to underlying TEE implementation, s=
o it
> +is left open for TEE drivers to provide corresponding implementation.
> +
> +Then TEE client driver can talk to a matched Trusted Application using APIs
> +listed in include/linux/tee_drv.h.
> +
>  OP-TEE driver
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -112,6 +134,14 @@ kernel are handled by the kernel driver. Other RPC mes=
sages will be forwarded to
>  tee-supplicant without further involvement of the driver, except switching
>  shared memory buffer representation.
>
> +OP-TEE device enumeration
> +-------------------------
> +
> +OP-TEE provides a pseudo Trusted Application: drivers/tee/optee/device.c in
> +order to support device enumeration. In other words, OP-TEE driver invokes=
 this
> +application to retrieve a list of Trusted Applications which can be regist=
ered
> +as devices on the TEE bus.
> +
>  AMD-TEE driver
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> --
> 2.7.4
>

--===============3932553025855575387==--

