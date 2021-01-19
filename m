From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Tue, 19 Jan 2021 12:30:34 +0200
Message-ID: <YAa0ys4YJcZtKdfF@kernel.org>
In-Reply-To: <
 <CAFA6WYNyirit_AFhoE+XR9PHw=OjRgEdXDqz1uanj_SN2NXeMw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8154001934429811440=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8154001934429811440==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 15, 2021 at 11:32:31AM +0530, Sumit Garg wrote:
> On Thu, 14 Jan 2021 at 07:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Jan 13, 2021 at 04:47:00PM +0530, Sumit Garg wrote:
> > > Hi Jarkko,
> > >
> > > On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wro=
te:
> > > >
> > > > On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > > > > Add support for TEE based trusted keys where TEE provides the funct=
ionality
> > > > > to seal and unseal trusted keys using hardware unique key.
> > > > >
> > > > > Refer to Documentation/tee.txt for detailed information about TEE.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > >
> > > > I haven't yet got QEMU environment working with aarch64, this produces
> > > > just a blank screen:
> > > >
> > > > ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -sm=
p 1 -kernel output/images/Image -initrd output/images/rootfs.cpio -serial std=
io
> > > >
> > > > My BuildRoot fork for TPM and keyring testing is located over here:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmd=
d.git/
> > > >
> > > > The "ARM version" is at this point in aarch64 branch. Over time I will
> > > > define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be t=
hen
> > > > in the master branch.
> > > >
> > > > To create identical images you just need to
> > > >
> > > > $ make tpmdd_defconfig && make
> > > >
> > > > Can you check if you see anything obviously wrong? I'm eager to test =
this
> > > > patch set, and in bigger picture I really need to have ready to run
> > > > aarch64 environment available.
> > >
> > > I would rather suggest you to follow steps listed here [1] as to test
> > > this feature on Qemu aarch64 we need to build firmwares such as TF-A,
> > > OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
> > > system [2]. And then it would be easier to migrate them to your
> > > buildroot environment as well.
> > >
> > > [1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.=
html
> > > [2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#q=
emu-v8
> > >
> > > -Sumit
> >
> > Can you provide 'keyctl_change'? Otherwise, the steps are easy to follow.
> >
>=20
> $ cat keyctl_change
> diff --git a/common.mk b/common.mk
> index aeb7b41..663e528 100644
> --- a/common.mk
> +++ b/common.mk
> @@ -229,6 +229,7 @@ BR2_PACKAGE_OPTEE_TEST_SDK ?=3D $(OPTEE_OS_TA_DEV_KIT_D=
IR)
>  BR2_PACKAGE_OPTEE_TEST_SITE ?=3D $(OPTEE_TEST_PATH)
>  BR2_PACKAGE_STRACE ?=3D y
>  BR2_TARGET_GENERIC_GETTY_PORT ?=3D $(if
> $(CFG_NW_CONSOLE_UART),ttyAMA$(CFG_NW_CONSOLE_UART),ttyAMA0)
> +BR2_PACKAGE_KEYUTILS :=3D y
>=20
>  # All BR2_* variables from the makefile or the environment are appended to
>  # ../out-br/extra.conf. All values are quoted "..." except y and n.
> diff --git a/kconfigs/qemu.conf b/kconfigs/qemu.conf
> index 368c18a..832ab74 100644
> --- a/kconfigs/qemu.conf
> +++ b/kconfigs/qemu.conf
> @@ -20,3 +20,5 @@ CONFIG_9P_FS=3Dy
>  CONFIG_9P_FS_POSIX_ACL=3Dy
>  CONFIG_HW_RANDOM=3Dy
>  CONFIG_HW_RANDOM_VIRTIO=3Dy
> +CONFIG_TRUSTED_KEYS=3Dy
> +CONFIG_ENCRYPTED_KEYS=3Dy
>=20
> > After I've successfully tested 2/4, I'd suggest that you roll out one more
> > version and CC the documentation patch to Elaine and Mini, and clearly
> > remark in the commit message that TEE is a standard, with a link to the
> > specification.
> >
>=20
> Sure, I will roll out the next version after your testing.

Thanks, I'll try this at instant, and give my feedback.

/Jarkko

--===============8154001934429811440==--

