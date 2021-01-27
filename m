From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Wed, 27 Jan 2021 19:14:48 +0200
Message-ID: <51c01b2b7843d36f4373f75f6c87ad135dd82799.camel@kernel.org>
In-Reply-To: <
 <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0901685167167749523=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0901685167167749523==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-25 at 14:47 +0530, Sumit Garg wrote:
> Hi Jarkko,
>=20
> On Fri, 22 Jan 2021 at 23:42, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > On Thu, Jan 21, 2021 at 05:23:45PM +0100, Jerome Forissier wrote:
> > >=20
> > >=20
> > > On 1/21/21 4:24 PM, Jarkko Sakkinen wrote:
> > > > On Thu, Jan 21, 2021 at 05:07:42PM +0200, Jarkko Sakkinen wrote:
> > > > > On Thu, Jan 21, 2021 at 09:44:07AM +0100, Jerome Forissier wrote:
> > > > > >=20
> > > > > >=20
> > > > > > On 1/21/21 1:02 AM, Jarkko Sakkinen via OP-TEE wrote:
> > > > > > > On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote:
> > > > > > > > On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kerne=
l.org> wrote:
> > > > > > > > >=20
> > > > > > > > > On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen w=
rote:
> > > > > > > > > > On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrot=
e:
> > > > > > > > > > > On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko(a=
)kernel.org> wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg =
wrote:
> > > > > > > > > > > > > Hi Jarkko,
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jark=
ko@kernel.org> wrote:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit G=
arg wrote:
> > > > > > > > > > > > > > > Add support for TEE based trusted keys where TE=
E provides the functionality
> > > > > > > > > > > > > > > to seal and unseal trusted keys using hardware =
unique key.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Refer to Documentation/tee.txt for detailed inf=
ormation about TEE.
> > > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.=
org>
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > I haven't yet got QEMU environment working with a=
arch64, this produces
> > > > > > > > > > > > > > just a blank screen:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > ./output/host/usr/bin/qemu-system-aarch64 -M virt=
 -cpu cortex-a53 -smp 1 -kernel output/images/Image -initrd output/images/roo=
tfs.cpio -serial stdio
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > My BuildRoot fork for TPM and keyring testing is =
located over here:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/j=
arkko/buildroot-tpmdd.git/
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > The "ARM version" is at this point in aarch64 bra=
nch. Over time I will
> > > > > > > > > > > > > > define tpmdd-x86_64 and tpmdd-aarch64 boards and =
everything will be then
> > > > > > > > > > > > > > in the master branch.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > To create identical images you just need to
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > $ make tpmdd_defconfig && make
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Can you check if you see anything obviously wrong=
? I'm eager to test this
> > > > > > > > > > > > > > patch set, and in bigger picture I really need to=
 have ready to run
> > > > > > > > > > > > > > aarch64 environment available.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > I would rather suggest you to follow steps listed h=
ere [1] as to test
> > > > > > > > > > > > > this feature on Qemu aarch64 we need to build firmw=
ares such as TF-A,
> > > > > > > > > > > > > OP-TEE, UEFI etc. which are all integrated into OP-=
TEE Qemu build
> > > > > > > > > > > > > system [2]. And then it would be easier to migrate =
them to your
> > > > > > > > > > > > > buildroot environment as well.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > [1] https://lists.trustedfirmware.org/pipermail/op-=
tee/2020-May/000027.html
> > > > > > > > > > > > > [2] https://optee.readthedocs.io/en/latest/building=
/devices/qemu.html#qemu-v8
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > -Sumit
> > > > > > > > > > > >=20
> > > > > > > > > > > > Can you provide 'keyctl_change'? Otherwise, the steps=
 are easy to follow.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > $ cat keyctl_change
> > > > > > > > > > > diff --git a/common.mk b/common.mk
> > > > > > > > > > > index aeb7b41..663e528 100644
> > > > > > > > > > > --- a/common.mk
> > > > > > > > > > > +++ b/common.mk
> > > > > > > > > > > @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?=3D $(O=
PTEE_OS_TA_DEV_KIT_DIR)
> > > > > > > > > > > =C2=A0BR2_PACKAGE_OPTEE_TEST_SITE ?=3D $(OPTEE_TEST_PAT=
H)
> > > > > > > > > > > =C2=A0BR2_PACKAGE_STRACE ?=3D y
> > > > > > > > > > > =C2=A0BR2_TARGET_GENERIC_GETTY_PORT ?=3D $(if
> > > > > > > > > > > $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),tty=
AMA0)
> > > > > > > > > > > +BR2_PACKAGE_KEYUTILS :=3D y
> > > > > > > > > > >=20
> > > > > > > > > > > =C2=A0# All BR2_* variables from the makefile or the en=
vironment are appended to
> > > > > > > > > > > =C2=A0# ../out-br/extra.conf. All values are quoted "..=
." except y and n.
> > > > > > > > > > > diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> > > > > > > > > > > index 368c18a..832ab74 100644
> > > > > > > > > > > --- a/kconfigs/qemu.conf
> > > > > > > > > > > +++ b/kconfigs/qemu.conf
> > > > > > > > > > > @@ -20,3 +20,5 @@ CONFIG_9P_FS=3Dy
> > > > > > > > > > > =C2=A0CONFIG_9P_FS_POSIX_ACL=3Dy
> > > > > > > > > > > =C2=A0CONFIG_HW_RANDOM=3Dy
> > > > > > > > > > > =C2=A0CONFIG_HW_RANDOM_VIRTIO=3Dy
> > > > > > > > > > > +CONFIG_TRUSTED_KEYS=3Dy
> > > > > > > > > > > +CONFIG_ENCRYPTED_KEYS=3Dy
> > > > > > > > > > >=20
> > > > > > > > > > > > After I've successfully tested 2/4, I'd suggest that =
you roll out one more
> > > > > > > > > > > > version and CC the documentation patch to Elaine and =
Mini, and clearly
> > > > > > > > > > > > remark in the commit message that TEE is a standard, =
with a link to the
> > > > > > > > > > > > specification.
> > > > > > > > > > > >=20
> > > > > > > > > > >=20
> > > > > > > > > > > Sure, I will roll out the next version after your testi=
ng.
> > > > > > > > > >=20
> > > > > > > > > > Thanks, I'll try this at instant, and give my feedback.
> > > > > > > > >=20
> > > > > > > > > I bump into this:
> > > > > > > > >=20
> > > > > > > > > $ make run-only
> > > > > > > > > ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/images/=
rootfs.cpio.gz /home/jarkko/devel/tpm/optee/build/../out/bin/
> > > > > > > > > ln: failed to create symbolic link '/home/jarkko/devel/tpm/=
optee/build/../out/bin/': No such file or directory
> > > > > > > > > make: *** [Makefile:194: run-only] Error 1
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Could you check if the following directory tree is built after
> > > > > > > > executing the below command?
> > > > > > > >=20
> > > > > > > > $ make -j`nproc`
> > > > > > > > CFG_IN_TREE_EARLY_TAS=3Dtrusted_keys/f04a0fe7-1f5d-4b9b-abf7-=
619b85b4ce8c
> > > > > > > >=20
> > > > > > > > $ tree out/bin/
> > > > > > > > out/bin/
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl1.bin -> /home/sumit/build/opte=
e/build/../trusted-firmware-a/build/qemu/release/bl1.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl2.bin -> /home/sumit/build/opte=
e/build/../trusted-firmware-a/build/qemu/release/bl2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl31.bin ->
> > > > > > > > /home/sumit/build/optee/build/../trusted-firmware-a/build/qem=
u/release/bl31.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl32.bin ->
> > > > > > > > /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-he=
ader_v2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl32_extra1.bin ->
> > > > > > > > /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pa=
ger_v2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl32_extra2.bin ->
> > > > > > > > /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pa=
geable_v2.bin
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 bl33.bin ->
> > > > > > > > /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKernel=
-AARCH64/RELEASE_GCC49/FV/QEMU_EFI.fd
> > > > > > > > =E2=94=9C=E2=94=80=E2=94=80 Image -> /home/sumit/build/optee/=
build/../linux/arch/arm64/boot/Image
> > > > > > > > =E2=94=94=E2=94=80=E2=94=80 rootfs.cpio.gz ->
> > > > > > > > /home/sumit/build/optee/build/../out-br/images/rootfs.cpio.gz
> > > > > > > >=20
> > > > > > > > 0 directories, 9 files
> > > > > > > >=20
> > > > > > > > -Sumit
> > > > > > >=20
> > > > > > > I actually spotted a build error that was unnoticed last time:
> > > > > > >=20
> > > > > > > make[2]: Entering directory '/home/jarkko/devel/tpm/optee/edk2/=
BaseTools/Tests'
> > > > > > > /bin/sh: 1: python: not found
> > > > > > >=20
> > > > > > > I'd prefer not to install Python2. It has been EOL over a year.
> > > > > >=20
> > > > > > AFAIK, everything should build fine with Python3. On my Ubuntu 20=
.04
> > > > > > machine, this is accomplished by installing package "python-is-py=
thon3"
> > > > > > (after uninstalling "python-is-python2" if need be).
> > > > > >=20
> > > > > > $ ls -l /usr/bin/python
> > > > > > lrwxrwxrwx 1 root root 7 Apr 15=C2=A0 2020 /usr/bin/python -> pyt=
hon3
> > > > >=20
> > > > > Right, just found about this in unrelated context :-) [*]
> > > > >=20
> > > > > Hope this will work out...
> > > > >=20
> > > > > [*] https://github.com/surge-synthesizer/surge/pull/3655
> > > >=20
> > > > Now I get
> > > >=20
> > > > Traceback (most recent call last):
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/Run=
Tests.py", line 36, in <module>
> > > > =C2=A0=C2=A0=C2=A0 allTests =3D GetAllTestsSuite()
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/Run=
Tests.py", line 33, in GetAllTestsSuite
> > > > =C2=A0=C2=A0=C2=A0 return unittest.TestSuite([GetCTestSuite(), GetPyt=
honTestSuite()])
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/Run=
Tests.py", line 25, in GetCTestSuite
> > > > =C2=A0=C2=A0=C2=A0 import CToolsTests
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/CTo=
olsTests.py", line 22, in <module>
> > > > =C2=A0=C2=A0=C2=A0 import TianoCompress
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/Tia=
noCompress.py", line 69, in <module>
> > > > =C2=A0=C2=A0=C2=A0 TheTestSuite =3D TestTools.MakeTheTestSuite(locals=
())
> > > > =C2=A0 File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/Tes=
tTools.py", line 43, in MakeTheTestSuite
> > > > =C2=A0=C2=A0=C2=A0 for name, item in localItems.iteritems():
> > > > AttributeError: 'dict' object has no attribute 'iteritems'
> > >=20
> > > Right. Same here after removing all traces of Python2 from my system :-/
> > >=20
> > > A couple of fixes are needed:
> > > 1. EDK2 needs to be upgraded to tag or later [1]
> > > 2. The PYTHON3_ENABLE environment variable needs to be set to TRUE [2]
> > >=20
> > > [1] https://github.com/OP-TEE/manifest/pull/177
> > > [2] https://github.com/OP-TEE/build/pull/450
> >=20
> > BTW, Is to *really* impossible to test this with plain BuildRoot.=C2=A0 I=
t's
> > obvious that this forks BR internally.
> >=20
> > I mean even if I get this working once, this will feels like a clumsy way
> > to test Aarch64 regularly. I use BuildRoot extensively for x86 testing. A=
nd
> > it would be nice to be able to start doing regular ARM testing.
>=20
> The main reason to guide you towards the OP-TEE build system is that
> you will be able to build all the firmwares (TF-A, OP-TEE, edk2 etc.)
> from source. If you don't need to rebuild those then I have prepared a
> flash firmware binary blob for your testing (attached flash.bin). So
> Qemu cmdline will look like:
>=20
> $ qemu-system-aarch64 -nographic -s -machine virt,secure=3Don -cpu
> cortex-a57 -kernel out/bin/Image -no-acpi -append
> 'console=3DttyAMA0,38400 keep_bootcon root=3D/dev/vda2' -initrd
> out/bin/rootfs.cpio.gz -smp 2 -m 1024 -bios flash.bin -d unimp
>=20
> Here you can use "Image" and "rootfs.cpio.gz" from your plain BR builds.
>=20
> Give it a try and let me know if this works for you.
>=20
> >=20
> > The mainline BuildRoot does have bunch of BR2_PACKAGE_OPTEE_* included.
> > Are they all broken?
>=20
> These aren't broken but they are used to package OP-TEE user-space
> components into rootfs but they aren't required to test Trusted Keys
> as it uses kernel interface to OP-TEE instead.
>=20
> -Sumit
>=20
> >=20
> > Here's a reference where I got with that endeavour:
> >=20
> > https://lore.kernel.org/linux-integrity/X%2Fx+N0fgrzIZTeNi(a)kernel.org/
> >=20
> > /Jarkko


--===============0901685167167749523==--

