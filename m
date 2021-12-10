From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Fri, 10 Dec 2021 10:38:03 +0100
Message-ID: 
 <CAN5uoS9xv-kKpC4E6-muYdh59g8XPSDfbquk5=DbQ4GmiVk-PA@mail.gmail.com>
In-Reply-To: <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3469922606375089961=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3469922606375089961==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

On Fri, 10 Dec 2021 at 09:10, Jerome Forissier <jerome@forissier.org> wrote:
>
> +CC Jens, Etienne
>
> On 12/10/21 06:00, Sumit Garg wrote:
> > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com=
> wrote:
> >>
> >> -----Original Message-----
> >> From: Sumit Garg <sumit.garg@linaro.org>
> >> Sent: Thursday, December 9, 2021 7:41 PM
> >> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> >> Cc: jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org; lin=
ux-kernel(a)vger.kernel.org
> >> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in o=
ptee_handle_rpc()
> >>
> >> [Please note: This e-mail is from an EXTERNAL e-mail address]
> >>
> >> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com>=
 wrote:
> >>>
> >>> We observed the following kmemleak report:
> >>> unreferenced object 0xffff000007904500 (size 128):
> >>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> >>>   hex dump (first 32 bytes):
> >>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> >>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> >>>   backtrace:
> >>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> >>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> >>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> >>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> >>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
> >>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> >>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> >>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
> >>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> >>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> >>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
> >>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> >>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
> >>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> >>>     [<000000001735e8a8>] driver_attach+0x24/0x30
> >>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> >>>
> >>> This is not a memory leak because we pass the share memory pointer to
> >>> secure world and would get it from secure world before releasing it.
> >>
> >>> How about if it's actually a memory leak caused by the secure world?
> >>> An example being secure world just allocates kernel memory via OPTEE_SM=
C_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> >>
> >>> IMO, we need to cross-check optee-os if it's responsible for leaking ke=
rnel memory.
> >>
> >> Hi sumit,
> >>
> >> You mean we need to check whether there is a real memleak,
> >> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC=
_ALLOC and until the end, there is no free
> >> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak=
, wo need to judge whether it is caused by secure os?
> >
> > Yes. AFAICT, optee-os should allocate shared memory to communicate
> > with tee-supplicant. So once the communication is done, the underlying
> > shared memory should be freed. I can't think of any scenario where
> > optee-os should keep hold-off shared memory indefinitely.
>
> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> the config file [1] and the commit which introduced this config [2].
>
> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
>

It's been a while since OP-TEE caches some shm buffers to prevent
re-allocting them on and on.
OP-TEE does so for 1 shm buffer per "tee threads" OP-TEE has provisioned.
Each thread can cache a shm reference.
Note that used RPCs from optee to linux/u-boot/ree do not require such
message buffer (IMO).

The main issue is the shm buffer are allocated per optee thread
(thread context assigned to client invocation request when entreing
optee).
Therefore, if an optee thread caches a shm buffer, it makes the caller
tee session to have a shm reference with a refcount held, until Optee
thread releases its cached shm reference.

There are ugly side effects. Linux must disable the cache to release
all resources.
We recently saw some tee sessions may be left open because of such shm
refcount held.
It can lead to few misbehaviour of the TA service (restarting a
service, releasing a resource)

Config switch CFG_PREALLOC_RPC_CACHE was introduced [pr4896] to
disable the feature at boot time.
There are means to not use it, or to explicitly enable/disable it at
run time (already used optee smc services for that). Would maybe be a
better default config.
Note this discussion thread ending at his comment [issue1918]:

Comments are welcome. I may have missed something in the description
(or understanding :).

[pr4896] https://github.com/OP-TEE/optee_os/pull/4896
[issue1918] https://github.com/OP-TEE/optee_os/issues/1918#issuecomment-96874=
7738

Best regards,
etienne



> --
> Jerome

--===============3469922606375089961==--

