From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 0/4] Introduce TEE based Trusted Keys support
Date: Tue, 08 Dec 2020 17:21:53 +0530
Message-ID: 
 <CAFA6WYOxkAUxg05kKXAcu2F2YD97MXNSggYgL+uSG7wrBVKoMQ@mail.gmail.com>
In-Reply-To: <20201204051642.GA154469@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6880356511184169731=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6880356511184169731==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Apologies for the delay in my response as I was busy with other high
priority work.

On Fri, 4 Dec 2020 at 10:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Fri, Nov 06, 2020 at 04:52:52PM +0200, Jarkko Sakkinen wrote:
> > On Fri, Nov 06, 2020 at 03:02:41PM +0530, Sumit Garg wrote:
> > > On Thu, 5 Nov 2020 at 10:37, Jarkko Sakkinen <jarkko@kernel.org> wrot=
e:
> > > >
> > > > On Tue, Nov 03, 2020 at 09:31:42PM +0530, Sumit Garg wrote:
> > > > > Add support for TEE based trusted keys where TEE provides the funct=
ionality
> > > > > to seal and unseal trusted keys using hardware unique key. Also, th=
is is
> > > > > an alternative in case platform doesn't possess a TPM device.
> > > > >
> > > > > This patch-set has been tested with OP-TEE based early TA which is =
already
> > > > > merged in upstream [1].
> > > >
> > > > Is the new RPI400 computer a platform that can be used for testing
> > > > patch sets like this? I've been looking for a while something ARM64
> > > > based with similar convenience as Intel NUC's, and on the surface
> > > > this new RPI product looks great for kernel testing purposes.
> > >
> > > Here [1] is the list of supported versions of Raspberry Pi in OP-TEE.
> > > The easiest approach would be to pick up a supported version or else
> > > do an OP-TEE port for an unsupported one (which should involve minimal
> > > effort).
> > >
> > > [1] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#w=
hat-versions-of-raspberry-pi-will-work
> > >
> > > -Sumit
> >
> > If porting is doable, then I'll just order RPI 400, and test with QEMU
> > up until either I port OP-TEE myself or someone else does it.
> >
> > For seldom ARM testing, RPI 400 is really convenient device with its
> > boxed form factor.
>
> I'm now a proud owner of Raspberry Pi 400 home computer :-)
>
> I also found instructions on how to boot a custom OS from a USB stick:
>
> https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/ms=
d.md
>
> Also, my favorite build system BuildRoot has bunch of of the shelf
> configs:
>
> =E2=9E=9C  buildroot-sgx (master) =E2=9C=94 ls -1 configs | grep raspberry
> raspberrypi0_defconfig
> raspberrypi0w_defconfig
> raspberrypi2_defconfig
> raspberrypi3_64_defconfig
> raspberrypi3_defconfig
> raspberrypi3_qt5we_defconfig
> raspberrypi4_64_defconfig
> raspberrypi4_defconfig
> raspberrypi_defconfig
>
> I.e. I'm capable of compiling kernel and user space and boot it up
> with it.
>
> Further, I can select this compilation option:
>
> BR2_TARGET_OPTEE_OS:                                                       =
                                                                             =
          =E2=94=82
>                                                                            =
                                                                             =
             =E2=94=82
>    OP-TEE OS provides the secure world boot image and the trust            =
                                                                             =
             =E2=94=82
>    application development kit of the OP-TEE project. OP-TEE OS            =
                                                                             =
             =E2=94=82
>    also provides generic trusted application one can embedded              =
                                                                             =
             =E2=94=82
>    into its system.                                                        =
                                                                             =
             =E2=94=82
>                                                                            =
                                                                             =
             =E2=94=82
>    http://github.com/OP-TEE/optee_os
>
> Is that what I want? If I put this all together and apply your patches,
> should the expectation be that I can use trusted keys?
>

Firstly you need to do an OP-TEE port for RPI 400 (refer here [1] for
guidelines). And then in order to boot up OP-TEE on RPI 400, you can
refer to Raspberry Pi 3 build instructions [2].

[1] https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.ht=
ml
[2] https://optee.readthedocs.io/en/latest/building/devices/rpi3.html#build-i=
nstructions

> Please note that I had a few remarks about your patches (minor but need
> to be fixed), but this version is already solid enough for testing.
>

Sure, I will incorporate your remarks and Randy's documentation
comments in the next version.

-Sumit

> /Jarkko

--===============6880356511184169731==--

