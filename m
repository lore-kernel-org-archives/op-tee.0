From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Mon, 13 Dec 2021 14:34:13 +0530
Message-ID: 
 <CAFA6WYPfjGqY6GJqLmrhU7CBjBTEYZzuCptHLJe2aEGUM_kOBA@mail.gmail.com>
In-Reply-To: <2c9f2f34-9dab-4f1b-bc10-48212fb70335@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6624342952419773273=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6624342952419773273==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Dec 2021 at 14:25, wangxiaolei <xiaolei.wang@windriver.com> wrot=
e:
>
>
> On 12/10/21 5:38 PM, Sumit Garg wrote:
> > [Please note: This e-mail is from an EXTERNAL e-mail address]
> >
> > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> w=
rote:
> >> +CC Jens, Etienne
> >>
> >> On 12/10/21 06:00, Sumit Garg wrote:
> >>> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.c=
om> wrote:
> >>>> -----Original Message-----
> >>>> From: Sumit Garg <sumit.garg@linaro.org>
> >>>> Sent: Thursday, December 9, 2021 7:41 PM
> >>>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
> >>>> Cc: jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org; l=
inux-kernel(a)vger.kernel.org
> >>>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in=
 optee_handle_rpc()
> >>>>
> >>>> [Please note: This e-mail is from an EXTERNAL e-mail address]
> >>>>
> >>>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.co=
m> wrote:
> >>>>> We observed the following kmemleak report:
> >>>>> unreferenced object 0xffff000007904500 (size 128):
> >>>>>    comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
> >>>>>    hex dump (first 32 bytes):
> >>>>>      00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
> >>>>>      60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
> >>>>>    backtrace:
> >>>>>      [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
> >>>>>      [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
> >>>>>      [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
> >>>>>      [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
> >>>>>      [<00000000c35884da>] optee_open_session+0x128/0x1ec
> >>>>>      [<000000001748f2ff>] tee_client_open_session+0x28/0x40
> >>>>>      [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
> >>>>>      [<000000003df18bf1>] optee_probe+0x674/0x6cc
> >>>>>      [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
> >>>>>      [<000000000c51ce7d>] really_probe+0xe4/0x4d0
> >>>>>      [<000000002f04c865>] driver_probe_device+0x58/0xc0
> >>>>>      [<00000000b485397d>] device_driver_attach+0xc0/0xd0
> >>>>>      [<00000000c835f0df>] __driver_attach+0x84/0x124
> >>>>>      [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
> >>>>>      [<000000001735e8a8>] driver_attach+0x24/0x30
> >>>>>      [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
> >>>>>
> >>>>> This is not a memory leak because we pass the share memory pointer to
> >>>>> secure world and would get it from secure world before releasing it.
> >>>>> How about if it's actually a memory leak caused by the secure world?
> >>>>> An example being secure world just allocates kernel memory via OPTEE_=
SMC_RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
> >>>>> IMO, we need to cross-check optee-os if it's responsible for leaking =
kernel memory.
> >>>> Hi sumit,
> >>>>
> >>>> You mean we need to check whether there is a real memleak,
> >>>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FU=
NC_ALLOC and until the end, there is no free
> >>>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory le=
ak, wo need to judge whether it is caused by secure os?
> >>> Yes. AFAICT, optee-os should allocate shared memory to communicate
> >>> with tee-supplicant. So once the communication is done, the underlying
> >>> shared memory should be freed. I can't think of any scenario where
> >>> optee-os should keep hold-off shared memory indefinitely.
> >> I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
> >> the config file [1] and the commit which introduced this config [2].
> > Okay, I see the reasoning. So during the OP-TEE driver's lifetime, the
> > RPC shared memory remains allocated. I guess that is done primarily
> > for performance reasons.
> >
> > But still it doesn't feel appropriate that we term all RPC shm
> > allocations as not leaking memory as we might miss obvious ones.
> >
> > Xiaolei,
> >
> > Can you once test with CFG_PREALLOC_RPC_CACHE=3Dn while compiling
> > optee-os and see if the observed memory leak disappears or not?
> >
> > -Sumit
>
> Hi sumit
>
>
> The version I am using has not increased the CFG_PREALLOC_RPC_CACHE
>
> switch, I checked out to the latest version, but because of the need for
>
> additional patches for the imx8 platform, I still have no way to test the
>
> CFG_PREALLOC_RPC_CACHE=3Dn situation
>

Can you just try to backport this [1] patch to your imx8 optee-os tree and te=
st?

[1] https://github.com/OP-TEE/optee_os/commit/8887663248ad

-Sumit

>
> thanks
>
> xiaolei
>
> >
> >> [1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
> >> [2] https://github.com/OP-TEE/optee_os/commit/8887663248ad
> >>
> >> --
> >> Jerome

--===============6624342952419773273==--

