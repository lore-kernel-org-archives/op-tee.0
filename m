From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Mon, 13 Dec 2021 14:28:01 +0530
Message-ID: 
 <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>
In-Reply-To: <20211210154915.hjbgrnvtitmwluhz@maple.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8366935620306754095=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8366935620306754095==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> w=
rote:
> > >
> > > +CC Jens, Etienne
> > >
> > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver=
.com> wrote:
> > > >>
> > > >> -----Original Message-----
> > > >> From: Sumit Garg <sumit.garg@linaro.org>
> > > >> Sent: Thursday, December 9, 2021 7:41 PM
> > > >> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> > > >> Cc: jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org;=
 linux-kernel(a)vger.kernel.org
> > > >> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report =
in optee_handle_rpc()
> > > >>
> > > >> [Please note: This e-mail is from an EXTERNAL e-mail address]
> > > >>
> > > >> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.=
com> wrote:
> > > >>>
> > > >>> We observed the following kmemleak report:
> > > >>> unreferenced object 0xffff000007904500 (size 128):
> > > >>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> > > >>>   hex dump (first 32 bytes):
> > > >>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.....=
..
> > > >>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `.............=
..
> > > >>>   backtrace:
> > > >>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> > > >>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> > > >>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> > > >>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> > > >>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
> > > >>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> > > >>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> > > >>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
> > > >>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> > > >>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> > > >>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
> > > >>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> > > >>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
> > > >>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> > > >>>     [<000000001735e8a8>] driver_attach+0x24/0x30
> > > >>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> > > >>>
> > > >>> This is not a memory leak because we pass the share memory pointer =
to
> > > >>> secure world and would get it from secure world before releasing it.
> > > >>
> > > >>> How about if it's actually a memory leak caused by the secure world?
> > > >>> An example being secure world just allocates kernel memory via OPTE=
E_SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> > > >>
> > > >>> IMO, we need to cross-check optee-os if it's responsible for leakin=
g kernel memory.
> > > >>
> > > >> Hi sumit,
> > > >>
> > > >> You mean we need to check whether there is a real memleak,
> > > >> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_=
FUNC_ALLOC and until the end, there is no free
> > > >> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory =
leak, wo need to judge whether it is caused by secure os?
> > > >
> > > > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > > > with tee-supplicant. So once the communication is done, the underlying
> > > > shared memory should be freed. I can't think of any scenario where
> > > > optee-os should keep hold-off shared memory indefinitely.
> > >
> > > I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> > > the config file [1] and the commit which introduced this config [2].
> >
> > Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> > RPC shared memory remains allocated. I guess that is done primarily
> > for performance reasons.
> >
> > But still it doesn't feel appropriate that we term all RPC shm
> > allocations as not leaking memory as we might miss obvious ones.
>
> IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> possible point before *ownership* of the SHM block is passed from kernel
> to OP-TEE.

I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
rather a way for OP-TEE to access kernel's memory in order to pass
info or execute further RPC commands.

>
> Sure, after we change ownership it could still be leaked... but it can
> no longer be leaked by the kernel because the kernel no longer owns it!
> More importantly, it makes no sense to run the kernel memory detector on the
> buffer because it simply can't work.
>
> After the RPC completes, doesn't it become impossible for kmemleak to
> scan to see if the pointer is lost[1]?

Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
of any scenario where an OP-TEE thread should hold off kernel's memory
pointers for more than 5 seconds before being passed onto kernel for
further RPC commands or RPC free action. So the kmemleak should be
able to detect if a pointer is lost.

/*
 * Kmemleak configuration and common defines.
 */
<snip>
#define MSECS_MIN_AGE           5000    /* minimum object age for reporting */
<snip>

> kmemleak is essentially a tracing
> garbage collector and needs to be able to scan all memory that could
> hold a pointer to leakable memory. After the RPC completes the
> only copy of the pointer will be stored in a memory region that the
> kernel is prohibited from reading. How could kmemleak possibly give you
> a useful answer in this circumstance?
>

There is another aspect of kmemleak being the minimum age of an object
to be reported as a memory leak as described above. Also, this case
resembles where a pointer is stored on the CPU stack (see struct
optee_rpc_param param =3D { };).

In most of the scenarios apart from special prealloc shm cache case,
the flow should be as follows:

1) Alloc kernel memory via RPC
2) OP-TEE passes references to kernel memory for RPC action commands
3) Free kernel memory via RPC

kmemleak should be useful in case the 3rd step is skipped due to
incorrect behaviour of a particular OP-TEE thread. And I can't think
of any appropriate way in OP-TEE OS to detect this type of kernel
memory leak caused by one of its threads.

-Sumit

> In other words if there's nothing kmemleak could do to fix this
> situation then marking the memory as kmemleak_not_leak() seems entirely
> appropriate (although it should be prefaced with a big comment
> explaining the change of ownerhship and why kmemleak cannot work).
>
>
> Daniel.
>
>
> [1] Everything I've said here hinges on this being true... so if I've
>     made a mistake about where OP-TEE stores this pointer then most of
>     the rest of this post is junk ;-)

--===============8366935620306754095==--

