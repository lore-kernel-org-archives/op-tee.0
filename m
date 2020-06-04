From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v2] Documentation: tee: Document TEE kernel interface
Date: Thu, 04 Jun 2020 12:05:27 +0300
Message-ID: 
 <CAD8XO3bw5zofRynNWUW61nb8Y=2sVMqXE0zWKFQYCHr5CQTNYg@mail.gmail.com>
In-Reply-To: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7578604850971187437=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7578604850971187437==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Looks good for me.

Reviewed-by: Maxim Uvarov <maxim.uvarov@linaro.org>

On Thu, 4 Jun 2020 at 10:00, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Update documentation with TEE bus infrastructure which provides an
> interface for kernel client drivers to communicate with corresponding
> Trusted Application.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> Changes in v2:
> - Add TEE client driver example snippet.
>
>  Documentation/tee.txt | 68 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/Documentation/tee.txt b/Documentation/tee.txt
> index c8fad81..350dd40 100644
> --- a/Documentation/tee.txt
> +++ b/Documentation/tee.txt
> @@ -53,6 +53,66 @@ clients, forward them to the TEE and send back the resul=
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
> +TEE client driver example
> +-------------------------
> +
> +Suppose a TEE client driver needs to communicate with a Trusted Application
> +having UUID: ``ac6a4085-0e82-4c33-bf98-8eb8e118b6c2``, so driver registrat=
ion
> +snippet would look like::
> +
> +       static const struct tee_client_device_id client_id_table[] =3D {
> +               {UUID_INIT(0xac6a4085, 0x0e82, 0x4c33,
> +                          0xbf, 0x98, 0x8e, 0xb8, 0xe1, 0x18, 0xb6, 0xc2)},
> +               {}
> +       };
> +
> +       MODULE_DEVICE_TABLE(tee, client_id_table);
> +
> +       static struct tee_client_driver client_driver =3D {
> +               .id_table       =3D client_id_table,
> +               .driver         =3D {
> +                       .name           =3D DRIVER_NAME,
> +                       .bus            =3D &tee_bus_type,
> +                       .probe          =3D client_probe,
> +                       .remove         =3D client_remove,
> +               },
> +       };
> +
> +       static int __init client_init(void)
> +       {
> +               return driver_register(&client_driver.driver);
> +       }
> +
> +       static void __exit client_exit(void)
> +       {
> +               driver_unregister(&client_driver.driver);
> +       }
> +
> +       module_init(client_init);
> +       module_exit(client_exit);
> +
>  OP-TEE driver
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> @@ -112,6 +172,14 @@ kernel are handled by the kernel driver. Other RPC mes=
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

--===============7578604850971187437==--

