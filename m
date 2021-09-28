From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: optee: regression with kernel v5.14 (virtualization)
Date: Tue, 28 Sep 2021 15:35:31 +0200
Message-ID: <cbcae077-3ebe-42b0-cbfe-cf5491f9ee0e@forissier.org>
In-Reply-To: <
 <CAOcqxo339CS63i5sMdweqx3MO7ME9TxFPJe-p-ESWME=vSzLwg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4204048054688799725=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4204048054688799725==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 9/28/21 3:15 PM, Volodymyr Babchuk wrote:
> Hi Jerome,
>=20
> On Tue, 28 Sept 2021 at 16:08, Jerome Forissier <jerome@forissier.org> wr=
ote:
>>
>> Hi,
>>
>> I met an issue when testing OP-TEE with the latest released kernel
>> (v5.14). The kernel won't boot when virtualization is enabled. More
>> precisely, the boot hangs as the optee driver is probed. The last line
>> on the console is:
>>
>> [xxx] optee: probing for conduit method.
>>
>> The issue can easily be reproduced in the QEMU OP-TEE environment as
>> documented in [1]:
>>
>> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
>> $ repo sync -j10
>> $ cd linux
>> $ git fetch github --unshallow
>> $ git checkout v5.14
>> $ cd ../build
>> $ make -j2 toolchains
>> $ make -j10 XEN_BOOT=3Dy run
>>
>> [Note, if you switch between XEN_BOOT=3Dy and the default build, you need
>> to "make arm-tf-clean"]
>>
>> git bisect points at commit b5c10dd04b74 ("optee: Clear stale cache
>> entries during initialization") and reverting this commit on top of
>> v5.14 does resolve the issue.
>>
>> Any idea what's wrong?
>=20
> Yes, there was a small mistake in the mediator. My colleague already
> pushed the patch. It is at staging now:
>=20
> http://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D1c3ed9c908732d196=
60fbe83580674d585464d4c
>=20
> And will be backported to Xen 4.13+

Awesome :) Thanks Vlad!

--=20
Jerome

--===============4204048054688799725==--

