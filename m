From: Jarkko Sakkinen <jarkko@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Thu, 04 Feb 2021 02:05:46 +0200
Message-ID: <YBs6WsGifYudzzPB@kernel.org>
In-Reply-To: <
 <CAFA6WYPQ+LZyHKZJQb=3euTy8f8TO3HqCADojpZaHXgtzNj+fw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7927733715190481980=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7927733715190481980==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2021 at 02:47:38PM +0530, Sumit Garg wrote:
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

Sumit, I can try this again now :-) Thanks Yann for fixing the issue!

https://git.busybox.net/buildroot/commit/?id=3Db9e7adc152b5811b20724d8c05f0f2=
117254919c

/Jarkko

--===============7927733715190481980==--

