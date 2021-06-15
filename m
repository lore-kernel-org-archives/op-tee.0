From: Tyler Hicks <tyhicks@linux.microsoft.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v5 0/8] tee: Improve support for kexec and kdump
Date: Mon, 14 Jun 2021 23:34:50 -0500
Message-ID: <20210615043450.GX4910@sequoia>
In-Reply-To: <
 <CAFA6WYOwCRtdvow1xaT6zUZ+7pjBekT7s-v+anRsbMk56WZMAA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4643668257418544773=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4643668257418544773==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 2021-06-15 10:02:39, Sumit Garg wrote:
> Hi Tyler,
>=20
> On Tue, 15 Jun 2021 at 04:03, Tyler Hicks <tyhicks@linux.microsoft.com> w=
rote:
> >
> > v5:
> > - Picked up Reviewed-by's from Jens.
> > - Added 'Cc: stable(a)vger.kernel.org' to all commits as this is intended
> >   to be a bug fix series. I'm happy to sort out backports with the
> >   stable team.
> > - Got rid of the bool is_mapped parameter of optee_disable_shm_cache()
> >   by abstracting out the function with two wrappers. One
> >   (optee_disable_shm_cache()) for normal case where the shm cache is
> >   fully mapped and another (optee_disable_unmapped_shm_cache()) for the
> >   unusual case of the shm cache having potentially invalid entries.
> > - Replaced my previous 'tee: Support kernel shm registration without
> >   dma-buf' patch with a cleaner implementation ('tee: Correct
> >   inappropriate usage of TEE_SHM_DMA_BUF flag') from Sumit Garg.
> > v4: https://lore.kernel.org/lkml/20210610210913.536081-1-tyhicks(a)linux.=
microsoft.com/
> > v3: https://lore.kernel.org/lkml/20210609002326.210024-1-tyhicks(a)linux.=
microsoft.com/
> > v2: https://lore.kernel.org/lkml/20210225090610.242623-1-allen.lkml(a)gma=
il.com/
> > v1: https://lore.kernel.org/lkml/20210217092714.121297-1-allen.lkml(a)gma=
il.com/
> >
>=20
> This series looks good to me. Feel free to add:
>=20
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thank you for all of your help and patience as I learn about the TEE
subsystem and begin to scratch the surface of how OP-TEE works. :)

Tyler

>=20
> -Sumit
>=20
> > This series fixes several bugs uncovered while exercising the OP-TEE
> > (Open Portable Trusted Execution Environment), ftpm (firmware TPM), and
> > tee_bnxt_fw (Broadcom BNXT firmware manager) drivers with kexec and
> > kdump (emergency kexec) based workflows.
> >
> > The majority of the problems are caused by missing .shutdown hooks in
> > the drivers. The .shutdown hooks are used by the normal kexec code path
> > to let the drivers clean up prior to executing the target kernel. The
> > .remove hooks, which are already implemented in these drivers, are not
> > called as part of the kexec code path. This resulted in shared memory
> > regions, that were cached and/or registered with OP-TEE, not being
> > cleared/unregistered prior to kexec. The new kernel would then run into
> > problems when handling the previously cached virtual addresses or trying
> > to register newly allocated shared memory objects that overlapped with
> > the previously registered virtual addresses. The TEE didn't receive
> > notification that the old virtual addresses were no longer meaningful
> > and that a new kernel, with a new address space, would soon be running.
> >
> > However, implementing .shutdown hooks was not enough for supporting
> > kexec. There was an additional problem caused by the TEE driver's
> > reliance on the dma-buf subsystem for multi-page shared memory objects
> > that were registered with the TEE. Shared memory objects backed by a
> > dma-buf use a different mechanism for reference counting. When the final
> > reference is released, work is scheduled to be executed to unregister
> > the shared memory with the TEE but that work is only completed prior to
> > the current task returning the userspace. In the case of a kexec
> > operation, the current task that's calling the driver .shutdown hooks
> > never returns to userspace prior to the kexec operation so the shared
> > memory was never unregistered. This eventually caused problems from
> > overlapping shared memory regions that were registered with the TEE
> > after several kexec operations. The large 4M contiguous region
> > allocated by the tee_bnxt_fw driver reliably ran into this issue on the
> > fourth kexec on a system with 8G of RAM.
> >
> > The use of dma-buf makes sense for shared memory that's in use by
> > userspace but dma-buf's aren't needed for shared memory that will only
> > used by the driver. This series separates dma-buf backed shared memory
> > allocated by the kernel from multi-page shared memory that the kernel
> > simply needs registered with the TEE for private use.
> >
> > One other noteworthy change in this series is to completely refuse to
> > load the OP-TEE driver in the kdump kernel. This is needed because the
> > secure world may have had all of its threads in suspended state when the
> > regular kernel crashed. The kdump kernel would then hang during boot
> > because the OP-TEE driver's .probe function would attempt to use a
> > secure world thread when they're all in suspended state. Another problem
> > is that shared memory allocations could fail under the kdump kernel
> > because the previously registered were not unregistered (the .shutdown
> > hook is not called when kexec'ing into the kdump kernel).
> >
> > The first patch in the series fixes potential memory leaks that are not
> > directly related to kexec or kdump but were noticed during the
> > development of this series.
> >
> > Tyler
> >
> > Allen Pais (2):
> >   optee: fix tee out of memory failure seen during kexec reboot
> >   firmware: tee_bnxt: Release TEE shm, session, and context during kexec
> >
> > Jens Wiklander (1):
> >   tee: add tee_shm_alloc_kernel_buf()
> >
> > Sumit Garg (1):
> >   tee: Correct inappropriate usage of TEE_SHM_DMA_BUF flag
> >
> > Tyler Hicks (4):
> >   optee: Fix memory leak when failing to register shm pages
> >   optee: Refuse to load the driver under the kdump kernel
> >   optee: Clear stale cache entries during initialization
> >   tpm_ftpm_tee: Free and unregister TEE shared memory during kexec
> >
> >  drivers/char/tpm/tpm_ftpm_tee.c         |  8 ++---
> >  drivers/firmware/broadcom/tee_bnxt_fw.c | 14 ++++++--
> >  drivers/tee/optee/call.c                | 38 +++++++++++++++++++---
> >  drivers/tee/optee/core.c                | 43 ++++++++++++++++++++++++-
> >  drivers/tee/optee/optee_private.h       |  1 +
> >  drivers/tee/optee/rpc.c                 |  5 +--
> >  drivers/tee/optee/shm_pool.c            | 20 +++++++++---
> >  drivers/tee/tee_shm.c                   | 20 +++++++++++-
> >  include/linux/tee_drv.h                 |  2 ++
> >  9 files changed, 132 insertions(+), 19 deletions(-)
> >
> > --
> > 2.25.1
> >
>=20

--===============4643668257418544773==--

