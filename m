From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Mon, 11 Jan 2021 18:35:03 +0200
Message-ID: <X/x+N0fgrzIZTeNi@kernel.org>
In-Reply-To: <1604419306-26105-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0113152825057547094=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0113152825057547094==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 09:31:44PM +0530, Sumit Garg wrote:
> Add support for TEE based trusted keys where TEE provides the functionality
> to seal and unseal trusted keys using hardware unique key.
>=20
> Refer to Documentation/tee.txt for detailed information about TEE.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

I haven't yet got QEMU environment working with aarch64, this produces
just a blank screen:

./output/host/usr/bin/qemu-system-aarch64 -M virt -cpu cortex-a53 -smp 1 -ker=
nel output/images/Image -initrd output/images/rootfs.cpio -serial stdio

My BuildRoot fork for TPM and keyring testing is located over here:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/buildroot-tpmdd.git/

The "ARM version" is at this point in aarch64 branch. Over time I will
define tpmdd-x86_64 and tpmdd-aarch64 boards and everything will be then
in the master branch.

To create identical images you just need to

$ make tpmdd_defconfig && make

Can you check if you see anything obviously wrong? I'm eager to test this
patch set, and in bigger picture I really need to have ready to run
aarch64 environment available.

/Jarkko

--===============0113152825057547094==--

