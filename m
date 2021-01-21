From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Thu, 21 Jan 2021 02:01:46 +0200
Message-ID: <YAjEaq+ZWD/eHU/x@kernel.org>
In-Reply-To: <
 <CAFA6WYP5G6NfGk96ePOC+2kpD6B+4hz9nywyUM9Nh=dJDYMiuA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2873421436093865273=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2873421436093865273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 12:53:28PM +0530, Sumit Garg wrote:
> On Wed, 20 Jan 2021 at 07:01, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Jan 19, 2021 at 12:30:42PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrote:
> > > > On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel.org> w=
rote:
> > > > >
> > > > > On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
> > > > > > Hi Jarkko,
> > > > > >
> > > > > > On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > > > > > > > Add support for TEE based trusted keys where TEE provides the=
 functionality
> > > > > > > > to seal and unseal trusted keys using hardware unique key.
> > > > > > > >
> > > > > > > > Refer to Documentation/tee.txt for detailed information about=
 TEE.
> > > > > > > >
> > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > >
> > > > > > > I haven't yet got QEMU environment working with aarch64, this p=
roduces
> > > > > > > just a blank screen:
> > > > > > >
> > > > > > > ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a=
53 -smp 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -seri=
al stdio
> > > > > > >
> > > > > > > My BuildRoot fork for TPM and keyring testing is located over h=
ere:
> > > > > > >
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroo=
t-tpmdd.git/
> > > > > > >
> > > > > > > The "ARM version" is at this point in aarch64 branch. Over time=
 I will
> > > > > > > define tpmdd-x86_64 and tpmdd-aarch64 boards and everything wil=
l be then
> > > > > > > in the master branch.
> > > > > > >
> > > > > > > To create identical images you just need to
> > > > > > >
> > > > > > > $ make tpmdd_defconfig && make
> > > > > > >
> > > > > > > Can you check if you see anything obviously wrong? I'm eager to=
 test this
> > > > > > > patch set, and in bigger picture I really need to have ready to=
 run
> > > > > > > aarch64 environment available.
> > > > > >
> > > > > > I would rather suggest you to follow steps listed here [1] as to =
test
> > > > > > this feature on Qemu aarch64 we need to build firmwares such as T=
F-A,
> > > > > > OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
> > > > > > system [2]. And then it would be easier to migrate them to your
> > > > > > buildroot environment as well.
> > > > > >
> > > > > > [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/0=
00027.html
> > > > > > [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.=
html#qemu-v8
> > > > > >
> > > > > > -Sumit
> > > > >
> > > > > Can you provide 'keyctl_change'? Otherwise, the steps are easy to f=
ollow.
> > > > >
> > > >
> > > > $ cat keyctl_change
> > > > diff --git a/common.mk b/common.mk
> > > > index aeb7b41..663e528 100644
> > > > --- a/common.mk
> > > > +++ b/common.mk
> > > > @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?=3D $(OPTEE_OS_TA_DEV=
_KIT_DIR)
> > > >  BR2_PACKAGE_OPTEE_TEST_SITE ?=3D $(OPTEE_TEST_PATH)
> > > >  BR2_PACKAGE_STRACE ?=3D y
> > > >  BR2_TARGET_GENERIC_GETTY_PORT ?=3D $(if
> > > > $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
> > > > +BR2_PACKAGE_KEYUTILS :=3D y
> > > >
> > > >  # All BR2_* variables from the makefile or the environment are appen=
ded to
> > > >  # ../out-br/extra.conf. All values are quoted "..." except y and n.
> > > > diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> > > > index 368c18a..832ab74 100644
> > > > --- a/kconfigs/qemu.conf
> > > > +++ b/kconfigs/qemu.conf
> > > > @@ -20,3 +20,5 @@ CONFIG_9P_FS=3Dy
> > > >  CONFIG_9P_FS_POSIX_ACL=3Dy
> > > >  CONFIG_HW_RANDOM=3Dy
> > > >  CONFIG_HW_RANDOM_VIRTIO=3Dy
> > > > +CONFIG_TRUSTED_KEYS=3Dy
> > > > +CONFIG_ENCRYPTED_KEYS=3Dy
> > > >
> > > > > After I've successfully tested 2/4, I'd suggest that you roll out o=
ne more
> > > > > version and CC the documentation patch to Elaine and Mini, and clea=
rly
> > > > > remark in the commit message that TEE is a standard, with a link to=
 the
> > > > > specification.
> > > > >
> > > >
> > > > Sure, I will roll out the next version after your testing.
> > >
> > > Thanks, I'll try this at instant, and give my feedback.
> >
> > I bump into this:
> >
> > $ make run-only
> > ln -sf /home/jarkko/devel/tpm/optee/build/../out-br/images/rootfs.cpio.gz=
 /home/jarkko/devel/tpm/optee/build/../out/bin/
> > ln: failed to create symbolic link '/home/jarkko/devel/tpm/optee/build/..=
/out/bin/': No such file or directory
> > make: *** [Makefile:194: run-only] Error 1
> >
>=20
> Could you check if the following directory tree is built after
> executing the below command?
>=20
> $ make -j`nproc`
> CFG_IN_TREE_EARLY_TAS=3Dtrusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c
>=20
> $ tree out/bin/
> out/bin/
> =E2=94=9C=E2=94=80=E2=94=80 bl1.bin -> /home/sumit/build/optee/build/../tru=
sted-firmware-a/build/qemu/release/bl1.bin
> =E2=94=9C=E2=94=80=E2=94=80 bl2.bin -> /home/sumit/build/optee/build/../tru=
sted-firmware-a/build/qemu/release/bl2.bin
> =E2=94=9C=E2=94=80=E2=94=80 bl31.bin ->
> /home/sumit/build/optee/build/../trusted-firmware-a/build/qemu/release/bl31=
.bin
> =E2=94=9C=E2=94=80=E2=94=80 bl32.bin ->
> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-header_v2.bin
> =E2=94=9C=E2=94=80=E2=94=80 bl32_extra1.bin ->
> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pager_v2.bin
> =E2=94=9C=E2=94=80=E2=94=80 bl32_extra2.bin ->
> /home/sumit/build/optee/build/../optee_os/out/arm/core/tee-pageable_v2.bin
> =E2=94=9C=E2=94=80=E2=94=80 bl33.bin ->
> /home/sumit/build/optee/build/../edk2/Build/ArmVirtQemuKernel-AARCH64/RELEA=
SE_GCC49/FV/QEMU_EFI.fd
> =E2=94=9C=E2=94=80=E2=94=80 Image -> /home/sumit/build/optee/build/../linux=
/arch/arm64/boot/Image
> =E2=94=94=E2=94=80=E2=94=80 rootfs.cpio.gz ->
> /home/sumit/build/optee/build/../out-br/images/rootfs.cpio.gz
>=20
> 0 directories, 9 files
>=20
> -Sumit

I actually spotted a build error that was unnoticed last time:

make[2]: Entering directory '/home/jarkko/devel/tpm/optee/edk2/BaseTools/Test=
s'
/bin/sh: 1: python: not found

I'd prefer not to install Python2. It has been EOL over a year.

/Jarkko

--===============2873421436093865273==--

