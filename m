From: Volodymyr Babchuk <vlad.babchuk@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee: regression with kernel v5.14 (virtualization)
Date: Tue, 28 Sep 2021 16:15:27 +0300
Message-ID: 
 <CAOcqxo339CS63i5sMdweqx3MO7ME9TxFPJe-p-ESWME=vSzLwg@mail.gmail.com>
In-Reply-To: <a0e1c245-8209-a173-18c4-d21433bf46bf@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2577810360949611174=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2577810360949611174==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jerome,

On Tue, 28 Sept 2021 at 16:08, Jerome Forissier <jerome@forissier.org> wrot=
e:
>
> Hi,
>
> I met an issue when testing OP-TEE with the latest released kernel
> (v5.14). The kernel won't boot when virtualization is enabled. More
> precisely, the boot hangs as the optee driver is probed. The last line
> on the console is:
>
> [xxx] optee: probing for conduit method.
>
> The issue can easily be reproduced in the QEMU OP-TEE environment as
> documented in [1]:
>
> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> $ repo sync -j10
> $ cd linux
> $ git fetch github --unshallow
> $ git checkout v5.14
> $ cd ../build
> $ make -j2 toolchains
> $ make -j10 XEN_BOOT=3Dy run
>
> [Note, if you switch between XEN_BOOT=3Dy and the default build, you need
> to "make arm-tf-clean"]
>
> git bisect points at commit b5c10dd04b74 ("optee: Clear stale cache
> entries during initialization") and reverting this commit on top of
> v5.14 does resolve the issue.
>
> Any idea what's wrong?

Yes, there was a small mistake in the mediator. My colleague already
pushed the patch. It is at staging now:

http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D1c3ed9c908732d19660=
fbe83580674d585464d4c

And will be backported to Xen 4.13+


--=20
WBR Volodymyr Babchuk aka lorc [+380976646013]
mailto: vlad.babchuk(a)gmail.com

--===============2577810360949611174==--

