From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [op-tee] [PATCH v4 2/4] KEYS: trusted: Introduce TEE based Trusted Keys
Date: Thu, 14 May 2020 12:57:35 +0530
Message-ID: 
 <CAFA6WYPr1iL-uJgSRu_61uv=2DhuEdDVdQLDuyPEOOK2jEgvyg@mail.gmail.com>
In-Reply-To: <ef2093f96eae7e9e6785f2c0ad00604d8adfd3be.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2868736390984819415=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2868736390984819415==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2020 at 05:58, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, 2020-05-06 at 15:10 +0530, Sumit Garg wrote:
> > Add support for TEE based trusted keys where TEE provides the functionali=
ty
> > to seal and unseal trusted keys using hardware unique key.
> >
> > Refer to Documentation/tee.txt for detailed information about TEE.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> The implementation looks solid but how or who could possibly test this?
>
> I do posses (personally, not from employer) bunch of ARM boards but my
> TZ knowledge is somewhat limited (e.g. how can I get something running
> in TZ).
>

Although, it should be fairly easy to test this implementation on an
ARM board which supports OP-TEE. But since you are new to ARM
TrustZone world, I would suggest you get used to OP-TEE on Qemu based
setup. You could find pretty good documentation for this here [1] but
for simplicity let me document steps here to test this trusted keys
feature from scratch:

# Install prerequisites as mentioned here [2]

# Get the source code
$ mkdir -p <optee-project>
$ cd <optee-project>
$ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
$ repo sync -j4 --no-clone-bundle

# Get the toolchain
$ cd <optee-project>/build
$ make -j2 toolchains

# As trusted keys work is based on latest tpmdd/master, so we can
change Linux base as follows:
$ cd <optee-project>/linux
$ git remote add tpmdd git://git.infradead.org/users/jjs/linux-tpmdd.git
$ git pull tpmdd
$ git checkout -b tpmdd-master remotes/tpmdd/master
# Cherry-pick and apply TEE features patch-set from this PR[3]
# Apply this Linux trusted keys patch-set.

# Now move on to build the source code
$ cd <optee-project>/build
# Apply attached "keyctl_change" patch
$ patch -p1 < keyctl_change
$ make -j`nproc`
CFG_IN_TREE_EARLY_TAS=3Dtrusted_keys/f04a0fe7-1f5d-4b9b-abf7-619b85b4ce8c

# Run QEMU setup
$ make run-only
# Type "c" on QEMU console to continue boot

# Now there should be two virtual consoles up, one for OP-TEE and
other for Linux
# On Linux console, you can play with "keyctl" utility to have trusted
and encrypted keys based on TEE.

Do let me know in case you are stuck while following the above steps.

[1] https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8
[2] https://optee.readthedocs.io/en/latest/building/prerequisites.html#prereq=
uisites
[3] https://lkml.org/lkml/2020/5/4/1062

-Sumit

> /Jarkko
>

--===============2868736390984819415==--

