From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Wed, 13 Jan 2021 16:47:00 +0530
Message-ID: 
 <CAFA6WYOUvWAZtYfR4q8beZFkX-CtdxqwJaRQM+GHNMDfQiEWOA@mail.gmail.com>
In-Reply-To: <X/x+N0fgrzIZTeNi@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0677214610191926942=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0677214610191926942==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

On Mon, 11 Jan 2021 at 22:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionali=
ty
> > to seal and unseal trusted keys using hardware unique key.
> >
> > Refer to Documentation/tee.txt for detailed information about TEE.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> I haven't yet got QEMU environment working with aarch64, this produces
> just a blank screen:
>
> ./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -k=
ernel output/images/Image -initrd output/images/rootfs.cpio -serial stdio
>
> My BuildRoot fork for TPM and keyring testing is located over here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/
>
> The "ARM version" is at this point in aarch64 branch. Over time I will
> define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
> in the master branch.
>
> To create identical images you just need to
>
> $ make tpmdd_defconfig && make
>
> Can you check if you see anything obviously wrong? I'm eager to test this
> patch set, and in bigger picture I really need to have ready to run
> aarch64 environment available.

I would rather suggest you to follow steps listed here [1] as to test
this feature on Qemu aarch64 we need to build firmwares such as TF-A,
OP-TEE, UEFI etc. which are all integrated into OP-TEE Qemu build
system [2]. And then it would be easier to migrate them to your
buildroot environment as well.

[1] https://lists.trustedfirmware.org/pipermail/op-tee/2020-May/000027.html
[2] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8

-Sumit

>
> /Jarkko

--===============0677214610191926942==--

