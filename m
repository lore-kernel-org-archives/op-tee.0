From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Date: Fri, 04 Dec 2020 07:16:42 +0200
Message-ID: <20201204051642.GA154469@kernel.org>
In-Reply-To: <20201106145252.GA10434@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2024852346379164069=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2024852346379164069==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2020 at 04:52:52PM +0200, Jarkko Sakkinen wrote:
> On Fri, Nov 06, 2020 at 03:02:41PM +0530, Sumit Garg wrote:
> > On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > > > Add support for TEE based trusted keys where TEE provides the functio=
nality
> > > > to seal and unseal trusted keys using hardware unique key. Also, this=
 is
> > > > an alternative in case platform doesn't possess a TPM device.
> > > >
> > > > This patch-set has been tested with OP-TEE based early TA which is al=
ready
> > > > merged in upstream [1].
> > >
> > > Is the new RPI400 computer a platform that can be used for testing
> > > patch sets like this? I've been looking for a while something ARM64
> > > based with similar convenience as Intel NUC's, and on the surface
> > > this new RPI product looks great for kernel testing purposes.
> >=20
> > Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
> > The easiest approach would be to pick up a supported version or else
> > do an OP-TEE port for an unsupported one (which should involve minimal
> > effort).
> >=20
> > [1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#wha=
t-versions-of-raspberry-pi-will-work
> >=20
> > -Sumit
>=20
> If porting is doable, then I'll just order RPI 400, and test with QEMU
> up until either I port OP-TEE myself or someone else does it.
>=20
> For seldom ARM testing, RPI 400 is really convenient device with its
> boxed form factor.

I'm now a proud owner of Raspberry Pi 400 home computer :-)

I also found instructions on how to boot a custom OS from a USB stick:

https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/msd.=
md

Also, my favorite build system BuildRoot has bunch of of the shelf
configs:

=E2=9E=9C  buildroot-sgx (master) =E2=9C=94 ls -1 configs | grep raspberry
raspberrypi0_defconfig
raspberrypi0w_defconfig
raspberrypi2_defconfig
raspberrypi3_64_defconfig
raspberrypi3_defconfig
raspberrypi3_qt5we_defconfig
raspberrypi4_64_defconfig
raspberrypi4_defconfig
raspberrypi_defconfig

I.e. I'm capable of compiling kernel and user space and boot it up
with it.

Further, I can select this compilation option:

BR2_TARGET_OPTEE_OS:                                                         =
                                                                             =
        =E2=94=82 =20
                                                                             =
                                                                             =
           =E2=94=82 =20
   OP-TEE OS provides the secure world boot image and the trust              =
                                                                             =
           =E2=94=82 =20
   application development kit of the OP-TEE project. OP-TEE OS              =
                                                                             =
           =E2=94=82 =20
   also provides generic trusted application one can embedded                =
                                                                             =
           =E2=94=82 =20
   into its system.                                                          =
                                                                             =
           =E2=94=82 =20
                                                                             =
                                                                             =
           =E2=94=82 =20
   http://github.com/OP-TEE/optee_os      =20

Is that what I want? If I put this all together and apply your patches,
should the expectation be that I can use trusted keys?

Please note that I had a few remarks about your patches (minor but need
to be fixed), but this version is already solid enough for testing.

/Jarkko

--===============2024852346379164069==--

