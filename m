From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v3 0/5] Add FF-A support in OP-TEE driver
Date: Wed, 28 Jul 2021 08:40:54 +0200
Message-ID: 
 <CAHUa44EsbWX9QBQ5Y=E_pZa2qKnU5FibzjoGjgO98kq35psaLg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPZHuEoaxo=05qfbNQ_gamPuMA4+=2giC88DK=RkMLgOg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1944042467317234472=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1944042467317234472==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 27, 2021 at 8:13 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 26 Jul 2021 at 20:55, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi Sumit,
> >
> > On Mon, Jul 26, 2021 at 1:41 PM Sumit Garg <sumit.garg@linaro.org> wrot=
e:
> > >
> > > On Mon, 26 Jul 2021 at 16:25, Sudeep Holla <sudeep.holla@arm.com> wro=
te:
> > > >
> > > > On Mon, Jul 26, 2021 at 03:59:36PM +0530, Sumit Garg wrote:
> > > > > Hi Jens,
> > > > >
> > > > > On Thu, 22 Jul 2021 at 17:48, Jens Wiklander <jens.wiklander@lina=
ro.org> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > This adds supports for the OP-TEE driver to communicate with secu=
re world
> > > > > > using FF-A [1] as transport.
> > > > > >
> > > > > > There is one change to the TEE subsystem with "tee: add sec_world=
_id to
> > > > > > struct tee_shm" to add support for holding globally unique handle=
 assigned
> > > > > > by the FF-A. This is a field that I believe could useful for the =
AMDTEE
> > > > > > driver too.
> > > > > >
> > > > > > For communication the OP-TEE message protocol is still used, but =
with a new
> > > > > > type of memory reference, struct optee_msg_param_fmem, to carry t=
he
> > > > > > information needed by FF-A. The OP-TEE driver is refactored inter=
nally with
> > > > > > to sets of callbacks, one for the old SMC based communication and=
 another
> > > > > > set with FF-A as transport. The functions relating to the SMC bas=
ed ABI
> > > > > > are moved to smc_abi.c while the FF-A based ABI is added in a ffa=
_abi.c.
> > > > > >
> > > > > > There is also a difference in how the drivers are instantiated. W=
ith the
> > > > > > SMC based transport we have a platform driver, module_platform_dr=
iver(),
> > > > > > today which we're keeping as is for this configuration. In a FF-A=
 system we
> > > > > > have a FF-A driver, module_ffa_driver(), instead.
> > > > > >
> > > > > > The OP-TEE driver can be compiled for both targets at the same ti=
me and
> > > > > > it's up to runtime configuration (device tree or ACPI) to decide =
how it's
> > > > > > initialized. Note that it's only the old SMC based driver instanc=
e that
> > > > > > need device tree or ACPI to initialize. The FF-A based driver rel=
ies on the
> > > > > > FF-A bus instead.
> > > > > >
> > > > > > This can be tested QEMU
> > > > > > The repo for SPMC at S-EL1 retrieved by
> > > > > > repo init -u https://github.com/jenswi-linaro/manifest.git -m
> > > > > > qemu_v8.xml -b ffav4_spmc
> > > > > > repo sync
> > > > > > # Then checkout the branch optee_ffa_v3 from
> > > > > > # git://git.linaro.org/people/jens.wiklander/linux-tee.git
> > > > > > # in the linux directory
> > > > > >
> > > > > > To build do:
> > > > > > cd build
> > > > > > make toolchains
> > > > > > make all
> > > > > >
> > > > > > To boot:
> > > > > > make run-only
> > > > > >
> > > > > > Test with xtest, perhaps only with the command "xtest 1004" in ca=
se you're
> > > > > > not interested in too many tests.
> > > > >
> > > > > Thanks Jens for sharing instructions to test this feature. So I tri=
ed
> > > > > to reproduce using following repo versions:
> > > > >
> > > > > linux-tee, branch: optee_ffa_v3
> > > > > trusted-firmware-a, branch: ffav4_sel1_spmc
> > > > > build, branch: ffav4_spmc
> > > > >
> > > > > and rest of the repos synced to the latest version as per upstream
> > > > > qemu_v8.xml [1] but I don't see OP-TEE driver being probed during b=
oot
> > > > > [2]. Am I missing something?
> > > > >
> > > > > [1] https://github.com/OP-TEE/manifest/blob/master/qemu_v8.xml
> > > > > [2]
> > > > > Welcome to Buildroot, type root or test to login
> > > > > buildroot login: root
> > > > > # dmesg | grep optee
> > > > >
> > > >
> > > > Do you see ARM FF-A driver initialised successfully ?
> > > > You must see "ARM FF-A Version 1.0 found" or something similar based =
on
> > > > the actual version supported.
> > > >
> > > > If so, can you check if the partitions are correctly populated by
> > > > the driver using the discover API.
> > > >
> > > > $ grep "" /sys/bus/arm_ffa/devices/*/uuid
> > > >
> > > > If uuid reads zeros, then the devices are populated, just the matching
> > > > driver is not found(due to the workaround for v1.0 spec)
> > > >
> > >
> > > It turns out to be an issue with my build environment, I re-built from
> > > scratch and I could see OP-TEE being probed successfully:
> > >
> > > # dmesg | grep FF-A
> > > [    0.356382] ARM FF-A: Version 1.0 found
> > > #
> > > # cat /sys/bus/arm_ffa/devices/arm-ffa-8001/uuid
> > > 486178e0-e7f8-11e3-bc5e-0002a5d5c51b
> > > #
> > > # dmesg | grep optee
> > > [    4.991472] optee: revision 3.14 (49dbb9ef)
> > > [    5.010110] optee: initialized driver
> > > #
> >
> > That's good.
> >
> > > From xtest logs it looks like the pseudo TA interface isn't working for=
 me:
> > >
> > > * regression_1001 Core self tests
> > >  - 1001 -   skip test, pseudo TA not found
> > >   regression_1001 OK
> > >
> > > * regression_1002 PTA parameters
> > >  - 1002 -   skip test, pseudo TA not found
> > >   regression_1002 OK
> > >
> > > * regression_1003 Core internal read/write mutex
> > >  - 1003 -   skip test, pseudo TA not found
> > >   regression_1003 OK
> >
> > The test PTAs are disabled by default.
> >
>
> Ah, I missed the CFG_ENABLE_EMBEDDED_TESTS option in OP-TEE. BTW, I
> think it should be enabled for OP-TEE Qemu build as we mostly use it
> as a test platform.

That makes sense. Perhaps in the build git?

>
> > >
> > > Similarly, pseudo TAs acting as TEE bus devices doesn't work as well
> > > as I see following devices directory being empty:
> > >
> > > # ls /sys/bus/tee/devices/
> > > #
> > >
> > > As otherwise with OP-TEE SMC ABI, we should have at least the default
> > > pseudo TA [1] kernel device there.
> > >
> > > So is pseudo TA functional with this new FF-A interface?
> >
> > Yes, everything is supposed to work.
> >
>
> So yes, xtest and TEE kernel bus framework works for me as well with
> this new FF-A interface. FWIW:
>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>

Thanks for confirming.

Cheers,
Jens

--===============1944042467317234472==--

