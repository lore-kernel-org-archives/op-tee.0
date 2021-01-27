From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Wed, 27 Jan 2021 19:19:34 +0200
Message-ID: <YBGgpj1OgLihwSd0@kernel.org>
In-Reply-To: <
 <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1081558159756966896=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1081558159756966896==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2021 at 02:47:38PM +0530, Sumit Garg wrote:
> Hi Jarkko,
>=20
> On Fri, 22 Jan 2021 at 23:42, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Thu, Jan 21, 2021 at 05:23:45PM +0100, Jerome Forissier wrote:
> > >
> > >
> > > On 1/21/21 4:24 PM, Jarkko Sakkinen wrote:
> > > > On Thu, Jan 21, 2021 at 05:07:42PM +0200, Jarkko Sakkinen wrote:
> > > >> On Thu, Jan 21, 2021 at 09:44:07AM +0100, Jerome Forissier wrote:
> > > >>>
> > > >>>
> > > >>> On 1/21/21 1:02 AM, Jarkko Sakkinen via OP-TEE wrote:
> > > >>>> On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote:
> > > >>>>> On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> > > >>>>>>
> > > >>>>>> On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen wrote:
> > > >>>>>>> On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrote:
> > > >>>>>>>> On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel=
.org> wrote:
> > > >>>>>>>>>
> > > >>>>>>>>> On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
> > > >>>>>>>>>> Hi Jarkko,
> > > >>>>>>>>>>
> > > >>>>>>>>>> On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kern=
el.org> wrote:
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > > >>>>>>>>>>>> Add support for TEE based trusted keys where TEE provides =
the functionality
> > > >>>>>>>>>>>> to seal and unseal trusted keys using hardware unique key.
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>> Refer to Documentation/tee.txt for detailed information ab=
out TEE.
> > > >>>>>>>>>>>>
> > > >>>>>>>>>>>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> I haven't yet got QEMU environment working with aarch64, th=
is produces
> > > >>>>>>>>>>> just a blank screen:
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cort=
ex-a53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -=
serial stdio
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> My BuildRoot fork for TPM and keyring testing is located ov=
er here:
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buil=
droot-tpmdd.git/
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> The "ARM version" is at this point in aarch64 branch. Over =
time I will
> > > >>>>>>>>>>> define tpmdd-x86_64 and tpmdd-aarch64 boards and everything=
 will be then
> > > >>>>>>>>>>> in the master branch.
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> To create identical images you just need to
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> $ make tpmdd_defconfig && make
> > > >>>>>>>>>>>
> > > >>>>>>>>>>> Can you check if you see anything obviously wrong? I'm eage=
r to test this
> > > >>>>>>>>>>> patch set, and in bigger picture I really need to have read=
y to run
> > > >>>>>>>>>>> aarch64 environment available.
> > > >>>>>>>>>>
> > > >>>>>>>>>> I would rather suggest you to follow steps listed here [1] a=
s to test
> > > >>>>>>>>>> this feature on Qemu aarch64 we need to build firmwares such=
 as TF-A,
> > > >>>>>>>>>> OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu =
build
> > > >>>>>>>>>> system [2]. And then it would be easier to migrate them to y=
our
> > > >>>>>>>>>> buildroot environment as well.
> > > >>>>>>>>>>
> > > >>>>>>>>>> [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-=
May/000027.html
> > > >>>>>>>>>> [2] https://optee.readthedocs.io/en/latest/building/devices/=
qemu.html#qemu-v8
> > > >>>>>>>>>>
> > > >>>>>>>>>> -Sumit
> > > >>>>>>>>>
> > > >>>>>>>>> Can you provide 'keyctl_change'? Otherwise, the steps are eas=
y to follow.
> > > >>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> $ cat keyctl_change
> > > >>>>>>>> diff --git a/common.mk b/common.mk
> > > >>>>>>>> index aeb7b41..663e528 100644
> > > >>>>>>>> --- a/common.mk
> > > >>>>>>>> +++ b/common.mk
> > > >>>>>>>> @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?=3D $(OPTEE_OS=
_TA_DEV_KIT_DIR)
> > > >>>>>>>>  BR2_PACKAGE_OPTEE_TEST_SITE ?=3D $(OPTEE_TEST_PATH)
> > > >>>>>>>>  BR2_PACKAGE_STRACE ?=3D y
> > > >>>>>>>>  BR2_TARGET_GENERIC_GETTY_PORT ?=3D $(if
> > > >>>>>>>> $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
> > > >>>>>>>> +BR2_PACKAGE_KEYUTILS :=3D y
> > > >>>>>>>>
> > > >>>>>>>>  # All BR2_* variables from the makefile or the environment ar=
e appended to
> > > >>>>>>>>  # ../out-br/extra.conf. All values are quoted "..." except y =
and n.
> > > >>>>>>>> diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> > > >>>>>>>> index 368c18a..832ab74 100644
> > > >>>>>>>> --- a/kconfigs/qemu.conf
> > > >>>>>>>> +++ b/kconfigs/qemu.conf
> > > >>>>>>>> @@ -20,3 +20,5 @@ CONFIG_9P_FS=3Dy
> > > >>>>>>>>  CONFIG_9P_FS_POSIX_ACL=3Dy
> > > >>>>>>>>  CONFIG_HW_RANDOM=3Dy
> > > >>>>>>>>  CONFIG_HW_RANDOM_VIRTIO=3Dy
> > > >>>>>>>> +CONFIG_TRUSTED_KEYS=3Dy
> > > >>>>>>>> +CONFIG_ENCRYPTED_KEYS=3Dy
> > > >>>>>>>>
> > > >>>>>>>>> After I've successfully tested 2/4, I'd suggest that you roll=
 out one more
> > > >>>>>>>>> version and CC the documentation patch to Elaine and Mini, an=
d clearly
> > > >>>>>>>>> remark in the commit message that TEE is a standard, with a l=
ink to the
> > > >>>>>>>>> specification.
> > > >>>>>>>>>
> > > >>>>>>>>
> > > >>>>>>>> Sure, I will roll out the next version after your testing.
> > > >>>>>>>
> > > >>>>>>> Thanks, I'll try this at instant, and give my feedback.
> > > >>>>>>
> > > >>>>>> I bump into this:
> > > >>>>>>
> > > >>>>>> $ make run-only
> > > >>>>>> ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/images/rootf=
s.cpio.gz /home/jarkko/devel/tpm/optee/build/../out/bin/
> > > >>>>>> ln: failed to create symbolic link '/home/jarkko/devel/tpm/optee=
/build/../out/bin/': No such file or directory
> > > >>>>>> make: *** [Makefile:194: run-only] Error 1
> > > >>>>>>
> > > >>>>>
> > > >>>>> Could you check if the following directory tree is built after
> > > >>>>> executing the below command?
> > > >>>>>
> > > >>>>> $ make -j`nproc`
> > > >>>>> CFG_IN_TREE_EARLY_TAS=3Dtrusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b=
85b4ce8c
> > > >>>>>
> > > >>>>> $ tree out/bin/
> > > >>>>> out/bin/
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl1.bin -> /home/sumit/build/optee/bu=
ild/../trusted-firmware-a/build/qemu/release/bl1.bin
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl2.bin -> /home/sumit/build/optee/bu=
ild/../trusted-firmware-a/build/qemu/release/bl2.bin
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl31.bin ->
> > > >>>>> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/re=
lease/bl31.bin
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl32.bin ->
> > > >>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-header=
_v2.bin
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl32_extra1.bin ->
> > > >>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pager_=
v2.bin
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl32_extra2.bin ->
> > > >>>>> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pageab=
le_v2.bin
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 bl33.bin ->
> > > >>>>> /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKernel-AAR=
CH64/RELEASE_GCC49/FV/QEMU_EFI.fd
> > > >>>>> =E2=94=9C=E2=94=80=E2=94=80 Image -> /home/sumit/build/optee/buil=
d/../linux/arch/arm64/boot/Image
> > > >>>>> =E2=94=94=E2=94=80=E2=94=80 rootfs.cpio.gz ->
> > > >>>>> /home/sumit/build/optee/build/../out-br/images/rootfs.cpio.gz
> > > >>>>>
> > > >>>>> 0 directories, 9 files
> > > >>>>>
> > > >>>>> -Sumit
> > > >>>>
> > > >>>> I actually spotted a build error that was unnoticed last time:
> > > >>>>
> > > >>>> make[2]: Entering directory '/home/jarkko/devel/tpm/optee/edk2/Bas=
eTools/Tests'
> > > >>>> /bin/sh: 1: python: not found
> > > >>>>
> > > >>>> I'd prefer not to install Python2. It has been EOL over a year.
> > > >>>
> > > >>> AFAIK, everything should build fine with Python3. On my Ubuntu 20.04
> > > >>> machine, this is accomplished by installing package "python-is-pyth=
on3"
> > > >>> (after uninstalling "python-is-python2" if need be).
> > > >>>
> > > >>> $ ls -l /usr/bin/python
> > > >>> lrwxrwxrwx 1 root root 7 Apr 15  2020 /usr/bin/python -> python3
> > > >>
> > > >> Right, just found about this in unrelated context :-) [*]
> > > >>
> > > >> Hope this will work out...
> > > >>
> > > >> [*] https://github.com/surge-synthesizer/surge/pull/3655
> > > >
> > > > Now I get
> > > >
> > > > Traceback (most recent call last):
> > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/RunTests=
.py", line 36, in <module>
> > > >     allTests =3D GetAllTestsSuite()
> > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/RunTests=
.py", line 33, in GetAllTestsSuite
> > > >     return unittest.TestSuite([GetCTestSuite(), GetPythonTestSuite()])
> > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/RunTests=
.py", line 25, in GetCTestSuite
> > > >     import CToolsTests
> > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/CToolsTe=
sts.py", line 22, in <module>
> > > >     import TianoCompress
> > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/TianoCom=
press.py", line 69, in <module>
> > > >     TheTestSuite =3D TestTools.MakeTheTestSuite(locals())
> > > >   File "/home/jarkko/Projects/tpm/optee/edk2/BaseTools/Tests/TestTool=
s.py", line 43, in MakeTheTestSuite
> > > >     for name, item in localItems.iteritems():
> > > > AttributeError: 'dict' object has no attribute 'iteritems'
> > >
> > > Right. Same here after removing all traces of Python2 from my system :-/
> > >
> > > A couple of fixes are needed:
> > > 1. EDK2 needs to be upgraded to tag or later [1]
> > > 2. The PYTHON3_ENABLE environment variable needs to be set to TRUE [2]
> > >
> > > [1] https://github.com/OP-TEE/manifest/pull/177
> > > [2] https://github.com/OP-TEE/build/pull/450
> >
> > BTW, Is to *really* impossible to test this with plain BuildRoot.  It's
> > obvious that this forks BR internally.
> >
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

Hi, sorry something happened with Evolution that I don't understand
and it just sent the message quoted without my response. Should
always stick to mutt.

There's a bug in BuildRoot that prevents me testing right now, when
you use LINUX_OVERRIDE_SRCDIR. BR developers are looking into that.

I'll test this once there's a resolution for that.

/Jarkko

--===============1081558159756966896==--

