From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Disable shm cache when booting the crash kernel
Date: Mon, 10 May 2021 09:31:51 +0200
Message-ID: 
 <CAHUa44F7AzRQ0ZUBtJV2Y39tk1mPGAbetn7i8-DVAsSFLbFgEg@mail.gmail.com>
In-Reply-To: <20210507131722.GI4967@sequoia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0858049341658811012=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0858049341658811012==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 7, 2021 at 3:17 PM Tyler Hicks <tyhicks@linux.microsoft.com> wr=
ote:
>
> On 2021-05-07 11:23:17, Jens Wiklander wrote:
> > On Fri, May 7, 2021 at 9:00 AM Allen Pais <apais@linux.microsoft.com> w=
rote:
> > >
> > >
> > >
> > > > On 07-May-2021, at 9:28 AM, Tyler Hicks <tyhicks@linux.microsoft.co=
m> wrote:
> > > >
> > > > The .shutdown hook is not called after a kernel crash when a kdump
> > > > kernel is pre-loaded. A kexec into the kdump kernel takes place as
> > > > quickly as possible without allowing drivers to clean up.
> > > >
> > > > That means that the OP-TEE shared memory cache, which was initialized=
 by
> > > > the kernel that crashed, is still in place when the kdump kernel is
> > > > booted. As the kdump kernel is shutdown, the .shutdown hook is called,
> > > > which calls optee_disable_shm_cache(), and OP-TEE's
> > > > OPTEE_SMC_DISABLE_SHM_CACHE API returns virtual addresses that are not
> > > > mapped for the kdump kernel since the cache was set up by the previous
> > > > kernel. Trying to dereference the tee_shm pointer or otherwise transl=
ate
> > > > the address results in a fault that cannot be handled:
> > > >
> > > > Unable to handle kernel paging request at virtual address ffff4317b9c=
09744
> > > > Mem abort info:
> > > >   ESR =3D 0x96000004
> > > >   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > > >   SET =3D 0, FnV =3D 0
> > > >   EA =3D 0, S1PTW =3D 0
> > > > Data abort info:
> > > >   ISV =3D 0, ISS =3D 0x00000004
> > > >   CM =3D 0, WnR =3D 0
> > > > swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000970b1e000
> > > > [ffff4317b9c09744] pgd=3D0000000000000000, p4d=3D0000000000000000
> > > > Internal error: Oops: 96000004 [#1] SMP
> > > > Modules linked in: bnxt_en pcie_iproc_platform pcie_iproc diagbe(O)
> > > > CPU: 4 PID: 1 Comm: systemd-shutdow Tainted: G           O      5.10.=
19.8 #1
> > > > Hardware name: Redacted (DT)
> > > > pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
> > > > pc : tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
> > > > lr : optee_disable_shm_cache (/usr/src/kernel/drivers/tee/optee/call.=
c:441)
> > > > sp : ffff80001005bb70
> > > > x29: ffff80001005bb70 x28: ffff608e74648e00
> > > > x27: ffff80001005bb98 x26: dead000000000100
> > > > x25: ffff80001005bbb8 x24: aaaaaaaaaaaaaaaa
> > > > x23: ffff608e74cf8818 x22: ffff608e738be600
> > > > x21: ffff80001005bbc8 x20: ffff608e738be638
> > > > x19: ffff4317b9c09700 x18: ffffffffffffffff
> > > > x17: 0000000000000041 x16: ffffba61b5171764
> > > > x15: 0000000000000004 x14: 0000000000000fff
> > > > x13: ffffba61b5c9dfc8 x12: 0000000000000003
> > > > x11: 0000000000000000 x10: 0000000000000000
> > > > x9 : ffffba61b5413824 x8 : 00000000ffff4317
> > > > x7 : 0000000000000000 x6 : 0000000000000000
> > > > x5 : 0000000000000000 x4 : 0000000000000000
> > > > x3 : 0000000000000000 x2 : ffff4317b9c09700
> > > > x1 : 00000000ffff4317 x0 : ffff4317b9c09700
> > > > Call trace:
> > > > tee_shm_free (/usr/src/kernel/drivers/tee/tee_shm.c:363)
> > > > optee_disable_shm_cache (/usr/src/kernel/drivers/tee/optee/call.c:441)
> > > > optee_shutdown (/usr/src/kernel/drivers/tee/optee/core.c:636)
> > > > platform_drv_shutdown (/usr/src/kernel/drivers/base/platform.c:800)
> > > > device_shutdown (/usr/src/kernel/include/linux/device.h:758 /usr/src/=
kernel/drivers/base/core.c:4078)
> > > > kernel_restart (/usr/src/kernel/kernel/reboot.c:221 /usr/src/kernel/k=
ernel/reboot.c:248)
> > > > __arm64_sys_reboot (/usr/src/kernel/kernel/reboot.c:349 /usr/src/kern=
el/kernel/reboot.c:312 /usr/src/kernel/kernel/reboot.c:312)
> > > > do_el0_svc (/usr/src/kernel/arch/arm64/kernel/syscall.c:56 /usr/src/k=
ernel/arch/arm64/kernel/syscall.c:158 /usr/src/kernel/arch/arm64/kernel/sysca=
ll.c:197)
> > > > el0_svc (/usr/src/kernel/arch/arm64/kernel/entry-common.c:368)
> > > > el0_sync_handler (/usr/src/kernel/arch/arm64/kernel/entry-common.c:42=
8)
> > > > el0_sync (/usr/src/kernel/arch/arm64/kernel/entry.S:671)
> > > > Code: aa0003f3 b5000060 12800003 14000002 (b9404663)
> > > >
> > > > When booting the kdump kernel, drain the shared memory cache while be=
ing
> > > > careful to not translate the addresses returned from
> > > > OPTEE_SMC_DISABLE_SHM_CACHE. Once the invalid cache objects are drain=
ed
> > > > and the cache is disabled, proceed with re-enabling the cache so that=
 we
> > > > aren't dealing with invalid addresses while shutting down the kdump
> > > > kernel.
> > > >
> > > > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > > ---
> > > >
> > > > This patch fixes a crash introduced by "optee: fix tee out of memory
> > > > failure seen during kexec reboot"[1]. However, I don't think that the
> > > > original two patch series[2] plus this patch is the full solution to
> > > > properly handling OP-TEE shared memory across kexec.
> > > >
> > > > While testing this fix, I did about 10 kexec reboots and then trigger=
ed
> > > > a kernel crash by writing 'c' to /proc/sysrq-trigger. The kdump kernel
> > > > became unresponsive during boot while steadily streaming the following
> > > > errors to the serial console:
> > > >
> > > > arm-smmu 64000000.mmu: Blocked unknown Stream ID 0x2000; boot with "a=
rm-smmu.disable_bypass=3D0" to allow, but this may have security implications
> > > > arm-smmu 64000000.mmu:     GFSR 0x00000002, GFSYNR0 0x00000002, GFSYN=
R1 0x00002000, GFSYNR2 0x00000000
> > > >
> > > > I suspect that this is related to the problems of OP-TEE shared memory
> > > > handling across kexec. My current hunch is that while we've disabled =
the
> > > > shared memory cache with this patch, we haven't unregistered all of t=
he
> > > > addresses that the previous kernel (which crashed) had registered with
> > > > OP-TEE and that perhaps OP-TEE OS is still trying to make use those
> > > > addresses?
>
> @Jens did you have any thoughts on what could be happening here with the
> arm-smmu errors? Do I need to try to unregister the cached shared memory
> addresses when booting the kdump kernel, rather than just disabling the
> caches?

No idea. There's no support for SMMU in upstream OP-TEE. Just
disabling the caches should be good enough. You could try to never
enable the cache so see if it makes any difference.

Cheers,
Jens

--===============0858049341658811012==--

