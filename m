From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 0/5] Add FF-A support in OP-TEE driver
Date: Mon, 19 Jul 2021 14:36:43 +0200
Message-ID: 
 <CAHUa44FzJ0wZjThGcQ0AjujSSnQj-5TPPCvco1fR6uPeScUgOA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPpJWRJbca_MSziEXZRRK5eK8NiU68zBeBxh4Fvn+NCvA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8763171489949596258=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8763171489949596258==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Wed, Jul 14, 2021 at 1:09 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> This patch-set skipped my inbox as I was not on the CC list. So while
> reading through ML archives, I found it.

Thanks, I'll include you in the next version.

>
> On Thu, 27 May 2021 at 13:45, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Hi all,
> >
> > This adds supports for the OP-TEE driver to communicate with secure world
> > using FF-A [1] as transport.
> >
> > These patches are based on the FF-A v7 patch set by Sudeep Holla [2] [3].
> >
>
> I could see the FF-A driver support merged upstream. Is this patch-set
> directly applicable on the upstream kernel? If yes, can you also share
> steps to test it on Qemu?

It's very likely this will work with the upstream kernel. My test
setup when posting this patchset was:

The repo for SPMC at S-EL1 retrieved by
repo init -u https://github.com/jenswi-linaro/manifest.git -m
qemu_v8.xml -b ffav4_spmc
repo sync

- optee_os, optee_client and optee_test tracking upstream/master
- TF-A rebased on v2.5 with a smallish patch to enable SPMD support for QEMU =
v8
- Linux kernel based on 5.13-rc2 with a previous version of the FF-A
patchset, it should be easy enough to rebase this on v5.14-rc1.

To build do:
cd build
make toolchains
make all

To boot:
make run-only

Test as usual with xtest.

>
> > There is one change to the TEE subsystem with "tee: add sec_world_id to
> > struct tee_shm" to add support for holding globally unique handle assigned
> > by the FF-A. This is a field that I believe could useful for the AMDTEE
> > driver too.
> >
> > For communication the OP-TEE message protocol is still used, but with a n=
ew
> > type of memory reference, struct optee_msg_param_fmem, to carry the
> > information needed by FF-A. The OP-TEE driver is refactored internally wi=
th
> > to sets of callbacks, one for the old SMC based communication and another
> > set with FF-A as transport.
>
> Since now we have two ABIs towards secure world:
> - OP-TEE ABI
> - FF-A ABI
>
> I think it would be better to have ABI specific APIs separated from
> core.c to have a clear view of abstraction. How about new file names
> as:
> - optee_{msg/abi}.c
> - ffa_{msg/abi}.c
>

I'll try something along this in the V3 which I intend to post quite soon.

> >
> > There is also a difference in how the drivers are instantiated. With the
> > SMC based transport we have a platform driver, module_platform_driver(),
> > today which we're keeping as is for this configuration. In a FF-A system =
we
> > have a FF-A driver, module_ffa_driver(), instead.
> >
> > The OP-TEE driver can be compiled for both targets at the same time and
> > it's up to runtime configuration (device tree or ACPI) to decide how it's
> > initialized.
>
> Can you elaborate on different device tree or ACPI configuration?
> AFAIR, FF-A utilizes bus enumeration to scan OP-TEE UUID.

This is a part that has changed in the FF-A framework since this
patchset was posted. With this upstream kernel it doesn't need a
device tree or ACPI.

Cheers,
Jens

>
> -Sumit
>
> >
> > Thanks,
> > Jens
> >
> > [1] https://developer.arm.com/documentation/den0077/latest
> > [2] https://lore.kernel.org/linux-arm-kernel/20210521151033.181846-1-sude=
ep.holla(a)arm.com/
> > [3] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git =
v5.13/ffa
> >
> > v1->v2:
> > - Rebased to the FF-A v7 patch
> > - Fixed a couple of reports from kernel test robot <lkp@intel.com>
> >
> > Jens Wiklander (5):
> >   tee: add sec_world_id to struct tee_shm
> >   optee: simplify optee_release()
> >   optee: refactor driver with internal callbacks
> >   optee: add a FF-A memory pool
> >   optee: add FF-A support
> >
> >  drivers/tee/optee/call.c          | 325 +++++++++++---
> >  drivers/tee/optee/core.c          | 689 ++++++++++++++++++++++++++----
> >  drivers/tee/optee/optee_ffa.h     | 153 +++++++
> >  drivers/tee/optee/optee_msg.h     |  27 +-
> >  drivers/tee/optee/optee_private.h |  88 +++-
> >  drivers/tee/optee/rpc.c           | 137 +++++-
> >  drivers/tee/optee/shm_pool.c      |  65 ++-
> >  drivers/tee/optee/shm_pool.h      |   1 +
> >  include/linux/tee_drv.h           |   7 +-
> >  9 files changed, 1326 insertions(+), 166 deletions(-)
> >  create mode 100644 drivers/tee/optee/optee_ffa.h
> >
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel(a)lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8763171489949596258==--

