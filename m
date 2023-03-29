From: Bagas Sanjaya <bagasdotme@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v12] tee: optee: Add SMC for loading OP-TEE image
Date: Wed, 29 Mar 2023 09:09:43 +0000
Message-ID: <ZCQAUukSQlwXLRfP@debian.me>
In-Reply-To: <
 <20230327093538.v12.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7591434384485852783=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7591434384485852783==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2023 at 09:35:53AM -0700, Jeffrey Kardatzke wrote:
> Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> instruct it to load it as the BL32 payload. This works in conjunction
> with a feature added to Trusted Firmware for ARMv8 and above
> architectures that supports this.
>=20
> The main purpose of this change is to facilitate updating the OP-TEE
> component on devices via a rootfs change rather than having to do a
> firmware update. Further details are linked to in the Kconfig file.
>=20
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>=20
> Changes in v12:
> - Fixed checkpatch strict issues
>=20
> Changes in v11:
> - Fixed typo in tee.rst documentation
>=20
> Changes in v10:
> - Fixed tee.rst documentation formatting
>=20
> Changes in v9:
> - Add CPU hotplug callback to init on all cores at startup
>=20
> Changes in v8:
> - Renamed params and fixed alignment issue
>=20
> Changes in v7:
> - Added documentation to Documentation/staging/tee.rst
>=20
> Changes in v6:
> - Expanded Kconfig documentation
>=20
> Changes in v5:
> - Renamed config option
> - Added runtime warning when config is used
>=20
> Changes in v4:
> - Update commit message
> - Added more documentation
> - Renamed config option, added ARM64 dependency
>=20
> Changes in v3:
> - Removed state tracking for driver reload
> - Check UID of service to verify it needs image load
>=20
> Changes in v2:
> - Fixed compile issue when feature is disabled
> - Addressed minor comments
> - Added state tracking for driver reload
>=20
>  Documentation/staging/tee.rst |  41 ++++++++++
>  drivers/tee/optee/Kconfig     |  17 +++++
>  drivers/tee/optee/optee_msg.h |  12 +++
>  drivers/tee/optee/optee_smc.h |  24 ++++++
>  drivers/tee/optee/smc_abi.c   | 137 ++++++++++++++++++++++++++++++++++
>  5 files changed, 231 insertions(+)
>=20
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 498343c7ab08..b11e9053bc99 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -214,6 +214,47 @@ call is done from the thread assisting the interrupt h=
andler. This is a
>  building block for OP-TEE OS in secure world to implement the top half and
>  bottom half style of device drivers.
> =20
> +OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> +----------------------------------------
> +
> +The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load t=
he
> +BL32 OP-TEE image from the kernel after the kernel boots, rather than load=
ing
> +it from the firmware before the kernel boots. This also requires enabling =
the
> +corresponding option in Trusted Firmware for Arm. The documentation there
> +explains the security threat associated with enabling this as well as
> +mitigations at the firmware and platform level.
> +https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_mod=
el.html

For consistency to the rest of doc, the reference link should be put
separately in "References" section:

---- >8 ----
diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index b11e9053bc9934..97758855156aa6 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -220,10 +220,9 @@ OPTEE_INSECURE_LOAD_IMAGE Kconfig option
 The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load the
 BL32 OP-TEE image from the kernel after the kernel boots, rather than loading
 it from the firmware before the kernel boots. This also requires enabling the
-corresponding option in Trusted Firmware for Arm. The documentation there
-explains the security threat associated with enabling this as well as
-mitigations at the firmware and platform level.
-https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_model=
.html
+corresponding option in Trusted Firmware for Arm. The Trusted Firmare
+documentation [8] explains the security threat associated with enabling this=
 as
+well as mitigations at the firmware and platform level.
=20
 There are additional attack vectors/mitigations for the kernel that should be
 addressed when using this option.
@@ -350,3 +349,5 @@ References
 [6] include/linux/psp-tee.h
=20
 [7] drivers/tee/amdtee/amdtee_if.h
+
+[8] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_m=
odel.html

> +
> +There are additional attack vectors/mitigations for the kernel that should=
 be
> +addressed when using this option.
> +
> +1. Boot chain security.
> +   Attack vector: Replace the OP-TEE OS image in the rootfs to gain contro=
l of
> +   the system.
> +   Mitigation: There must be boot chain security that verifies the kernel =
and
> +   rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> +   modifying it in the rootfs.
> +2. Alternate boot modes.
> +   Attack vector: Using an alternate boot mode (i.e. recovery mode), the O=
P-TEE
> +   driver isn't loaded, leaving the SMC hole open.
> +   Mitigation: If there are alternate methods of booting the device, such =
as a
> +   recovery mode, it should be ensured that the same mitigations are appli=
ed in
> +   that mode.
> +3. Attacks prior to SMC invocation.
> +   Attack vector: Code that is executed prior to issuing the SMC call to l=
oad
> +   OP-TEE can be exploited to then load an alternate OS image.
> +   Mitigation: The OP-TEE driver must be loaded before any potential attack
> +   vectors are opened up. This should include mounting of any modifiable
> +   filesystems, opening of network ports or communicating with external de=
vices
> +   (e.g. USB).
> +4. Blocking SMC call to load OP-TEE.
> +   Attack vector: Prevent the driver from being probed, so the SMC call to=
 load
> +   OP-TEE isn't executed when desired, leaving it open to being executed l=
ater
> +   and loading a modified OS.
> +   Mitigation: It is recommended to build the OP-TEE driver as an included
> +   driver rather than a module to prevent exploits that may cause the modu=
le to
> +   not be loaded.
> +

I think attack vectors and mitigations can be sub bullets:

---- >8 ----
diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
index 97758855156aa6..b17eb9772230db 100644
--- a/Documentation/staging/tee.rst
+++ b/Documentation/staging/tee.rst
@@ -228,31 +228,41 @@ There are additional attack vectors/mitigations for the=
 kernel that should be
 addressed when using this option.
=20
 1. Boot chain security.
-   Attack vector: Replace the OP-TEE OS image in the rootfs to gain control =
of
-   the system.
-   Mitigation: There must be boot chain security that verifies the kernel and
-   rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
-   modifying it in the rootfs.
+
+   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain contro=
l of
+     the system.
+
+   * Mitigation: There must be boot chain security that verifies the kernel =
and
+     rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
+     modifying it in the rootfs.
 2. Alternate boot modes.
-   Attack vector: Using an alternate boot mode (i.e. recovery mode), the OP-=
TEE
-   driver isn't loaded, leaving the SMC hole open.
-   Mitigation: If there are alternate methods of booting the device, such as=
 a
-   recovery mode, it should be ensured that the same mitigations are applied=
 in
-   that mode.
+
+   * Attack vector: Using an alternate boot mode (i.e. recovery mode), the
+     OP-TEE driver isn't loaded, leaving the SMC hole open.
+
+   * Mitigation: If there are alternate methods of booting the device, such =
as
+     a recovery mode, it should be ensured that the same mitigations are
+     applied in that mode.
+
 3. Attacks prior to SMC invocation.
-   Attack vector: Code that is executed prior to issuing the SMC call to load
-   OP-TEE can be exploited to then load an alternate OS image.
-   Mitigation: The OP-TEE driver must be loaded before any potential attack
-   vectors are opened up. This should include mounting of any modifiable
-   filesystems, opening of network ports or communicating with external devi=
ces
-   (e.g. USB).
+
+   * Attack vector: Code that is executed prior to issuing the SMC call to l=
oad
+     OP-TEE can be exploited to then load an alternate OS image.
+
+   * Mitigation: The OP-TEE driver must be loaded before any potential attack
+     vectors are opened up. This should include mounting of any modifiable
+     filesystems, opening of network ports or communicating with external
+     devices (e.g. USB).
+
 4. Blocking SMC call to load OP-TEE.
-   Attack vector: Prevent the driver from being probed, so the SMC call to l=
oad
-   OP-TEE isn't executed when desired, leaving it open to being executed lat=
er
-   and loading a modified OS.
-   Mitigation: It is recommended to build the OP-TEE driver as an included
-   driver rather than a module to prevent exploits that may cause the module=
 to
-   not be loaded.
+
+   * Attack vector: Prevent the driver from being probed, so the SMC call to
+     load OP-TEE isn't executed when desired, leaving it open to being execu=
ted
+     later and loading a modified OS.
+
+   * Mitigation: It is recommended to build the OP-TEE driver as builtin
+     driver rather than as a module to prevent exploits that may cause the
+     module to not be loaded.
=20
 AMD-TEE driver
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Or due to tabular nature of additional attacks list above, reST tables
should fit.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--===============7591434384485852783==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllLQUIwV0lRU1NZUTZDeTdveUZO
Q0hyVUgydVlsSlZWRk9vd1VDWkNRQVRnQUtDUkQydVlsSlZWRk8KbzQxYUFRQ0FzMnRhdEF0U2hB
WERGSjNLK0c1VkUvbWdvSWcwUWpCWC9NQVpGeTdmZ0FEL2NsK3NGcGhXR3pzTwpZb2tOR1JkRjV5
aUFUVXo0RngrRWdJdmFxN09IcWd3PQo9SWxReAotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============7591434384485852783==--

