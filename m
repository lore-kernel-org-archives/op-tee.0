From: Jeffrey Kardatzke <jkardatzke@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v12] tee: optee: Add SMC for loading OP-TEE image
Date: Fri, 31 Mar 2023 11:35:35 -0700
Message-ID: 
 <CA+ddPcN3=H3xZnSJXKRXjDHY9CpT6aWWkFfTH9Ofxtv8WZwX6Q@mail.gmail.com>
In-Reply-To: <ZCQAUukSQlwXLRfP@debian.me>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5149387409037030352=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5149387409037030352==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Thanks, new patch uploaded with these formatting changes done.


On Wed, Mar 29, 2023 at 2:09=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> On Mon, Mar 27, 2023 at 09:35:53AM -0700, Jeffrey Kardatzke wrote:
> > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > instruct it to load it as the BL32 payload. This works in conjunction
> > with a feature added to Trusted Firmware for ARMv8 and above
> > architectures that supports this.
> >
> > The main purpose of this change is to facilitate updating the OP-TEE
> > component on devices via a rootfs change rather than having to do a
> > firmware update. Further details are linked to in the Kconfig file.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > ---
> >
> > Changes in v12:
> > - Fixed checkpatch strict issues
> >
> > Changes in v11:
> > - Fixed typo in tee.rst documentation
> >
> > Changes in v10:
> > - Fixed tee.rst documentation formatting
> >
> > Changes in v9:
> > - Add CPU hotplug callback to init on all cores at startup
> >
> > Changes in v8:
> > - Renamed params and fixed alignment issue
> >
> > Changes in v7:
> > - Added documentation to Documentation/staging/tee.rst
> >
> > Changes in v6:
> > - Expanded Kconfig documentation
> >
> > Changes in v5:
> > - Renamed config option
> > - Added runtime warning when config is used
> >
> > Changes in v4:
> > - Update commit message
> > - Added more documentation
> > - Renamed config option, added ARM64 dependency
> >
> > Changes in v3:
> > - Removed state tracking for driver reload
> > - Check UID of service to verify it needs image load
> >
> > Changes in v2:
> > - Fixed compile issue when feature is disabled
> > - Addressed minor comments
> > - Added state tracking for driver reload
> >
> >  Documentation/staging/tee.rst |  41 ++++++++++
> >  drivers/tee/optee/Kconfig     |  17 +++++
> >  drivers/tee/optee/optee_msg.h |  12 +++
> >  drivers/tee/optee/optee_smc.h |  24 ++++++
> >  drivers/tee/optee/smc_abi.c   | 137 ++++++++++++++++++++++++++++++++++
> >  5 files changed, 231 insertions(+)
> >
> > diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> > index 498343c7ab08..b11e9053bc99 100644
> > --- a/Documentation/staging/tee.rst
> > +++ b/Documentation/staging/tee.rst
> > @@ -214,6 +214,47 @@ call is done from the thread assisting the interrupt=
 handler. This is a
> >  building block for OP-TEE OS in secure world to implement the top half a=
nd
> >  bottom half style of device drivers.
> >
> > +OPTEE_INSECURE_LOAD_IMAGE Kconfig option
> > +----------------------------------------
> > +
> > +The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load=
 the
> > +BL32 OP-TEE image from the kernel after the kernel boots, rather than lo=
ading
> > +it from the firmware before the kernel boots. This also requires enablin=
g the
> > +corresponding option in Trusted Firmware for Arm. The documentation there
> > +explains the security threat associated with enabling this as well as
> > +mitigations at the firmware and platform level.
> > +https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_m=
odel.html
>
> For consistency to the rest of doc, the reference link should be put
> separately in "References" section:
>
> ---- >8 ----
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index b11e9053bc9934..97758855156aa6 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -220,10 +220,9 @@ OPTEE_INSECURE_LOAD_IMAGE Kconfig option
>  The OPTEE_INSECURE_LOAD_IMAGE Kconfig option enables the ability to load t=
he
>  BL32 OP-TEE image from the kernel after the kernel boots, rather than load=
ing
>  it from the firmware before the kernel boots. This also requires enabling =
the
> -corresponding option in Trusted Firmware for Arm. The documentation there
> -explains the security threat associated with enabling this as well as
> -mitigations at the firmware and platform level.
> -https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat_mod=
el.html
> +corresponding option in Trusted Firmware for Arm. The Trusted Firmare
> +documentation [8] explains the security threat associated with enabling th=
is as
> +well as mitigations at the firmware and platform level.
>
>  There are additional attack vectors/mitigations for the kernel that should=
 be
>  addressed when using this option.
> @@ -350,3 +349,5 @@ References
>  [6] include/linux/psp-tee.h
>
>  [7] drivers/tee/amdtee/amdtee_if.h
> +
> +[8] https://trustedfirmware-a.readthedocs.io/en/latest/threat_model/threat=
_model.html
>
> > +
> > +There are additional attack vectors/mitigations for the kernel that shou=
ld be
> > +addressed when using this option.
> > +
> > +1. Boot chain security.
> > +   Attack vector: Replace the OP-TEE OS image in the rootfs to gain cont=
rol of
> > +   the system.
> > +   Mitigation: There must be boot chain security that verifies the kerne=
l and
> > +   rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> > +   modifying it in the rootfs.
> > +2. Alternate boot modes.
> > +   Attack vector: Using an alternate boot mode (i.e. recovery mode), the=
 OP-TEE
> > +   driver isn't loaded, leaving the SMC hole open.
> > +   Mitigation: If there are alternate methods of booting the device, suc=
h as a
> > +   recovery mode, it should be ensured that the same mitigations are app=
lied in
> > +   that mode.
> > +3. Attacks prior to SMC invocation.
> > +   Attack vector: Code that is executed prior to issuing the SMC call to=
 load
> > +   OP-TEE can be exploited to then load an alternate OS image.
> > +   Mitigation: The OP-TEE driver must be loaded before any potential att=
ack
> > +   vectors are opened up. This should include mounting of any modifiable
> > +   filesystems, opening of network ports or communicating with external =
devices
> > +   (e.g. USB).
> > +4. Blocking SMC call to load OP-TEE.
> > +   Attack vector: Prevent the driver from being probed, so the SMC call =
to load
> > +   OP-TEE isn't executed when desired, leaving it open to being executed=
 later
> > +   and loading a modified OS.
> > +   Mitigation: It is recommended to build the OP-TEE driver as an includ=
ed
> > +   driver rather than a module to prevent exploits that may cause the mo=
dule to
> > +   not be loaded.
> > +
>
> I think attack vectors and mitigations can be sub bullets:
>
> ---- >8 ----
> diff --git a/Documentation/staging/tee.rst b/Documentation/staging/tee.rst
> index 97758855156aa6..b17eb9772230db 100644
> --- a/Documentation/staging/tee.rst
> +++ b/Documentation/staging/tee.rst
> @@ -228,31 +228,41 @@ There are additional attack vectors/mitigations for t=
he kernel that should be
>  addressed when using this option.
>
>  1. Boot chain security.
> -   Attack vector: Replace the OP-TEE OS image in the rootfs to gain contro=
l of
> -   the system.
> -   Mitigation: There must be boot chain security that verifies the kernel =
and
> -   rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> -   modifying it in the rootfs.
> +
> +   * Attack vector: Replace the OP-TEE OS image in the rootfs to gain cont=
rol of
> +     the system.
> +
> +   * Mitigation: There must be boot chain security that verifies the kerne=
l and
> +     rootfs, otherwise an attacker can modify the loaded OP-TEE binary by
> +     modifying it in the rootfs.
>  2. Alternate boot modes.
> -   Attack vector: Using an alternate boot mode (i.e. recovery mode), the O=
P-TEE
> -   driver isn't loaded, leaving the SMC hole open.
> -   Mitigation: If there are alternate methods of booting the device, such =
as a
> -   recovery mode, it should be ensured that the same mitigations are appli=
ed in
> -   that mode.
> +
> +   * Attack vector: Using an alternate boot mode (i.e. recovery mode), the
> +     OP-TEE driver isn't loaded, leaving the SMC hole open.
> +
> +   * Mitigation: If there are alternate methods of booting the device, suc=
h as
> +     a recovery mode, it should be ensured that the same mitigations are
> +     applied in that mode.
> +
>  3. Attacks prior to SMC invocation.
> -   Attack vector: Code that is executed prior to issuing the SMC call to l=
oad
> -   OP-TEE can be exploited to then load an alternate OS image.
> -   Mitigation: The OP-TEE driver must be loaded before any potential attack
> -   vectors are opened up. This should include mounting of any modifiable
> -   filesystems, opening of network ports or communicating with external de=
vices
> -   (e.g. USB).
> +
> +   * Attack vector: Code that is executed prior to issuing the SMC call to=
 load
> +     OP-TEE can be exploited to then load an alternate OS image.
> +
> +   * Mitigation: The OP-TEE driver must be loaded before any potential att=
ack
> +     vectors are opened up. This should include mounting of any modifiable
> +     filesystems, opening of network ports or communicating with external
> +     devices (e.g. USB).
> +
>  4. Blocking SMC call to load OP-TEE.
> -   Attack vector: Prevent the driver from being probed, so the SMC call to=
 load
> -   OP-TEE isn't executed when desired, leaving it open to being executed l=
ater
> -   and loading a modified OS.
> -   Mitigation: It is recommended to build the OP-TEE driver as an included
> -   driver rather than a module to prevent exploits that may cause the modu=
le to
> -   not be loaded.
> +
> +   * Attack vector: Prevent the driver from being probed, so the SMC call =
to
> +     load OP-TEE isn't executed when desired, leaving it open to being exe=
cuted
> +     later and loading a modified OS.
> +
> +   * Mitigation: It is recommended to build the OP-TEE driver as builtin
> +     driver rather than as a module to prevent exploits that may cause the
> +     module to not be loaded.
>
>  AMD-TEE driver
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Or due to tabular nature of additional attacks list above, reST tables
> should fit.
>
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara

--===============5149387409037030352==--

