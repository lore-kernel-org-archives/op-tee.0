From: Jerome Forissier <jerome@forissier.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Fri, 10 Dec 2021 09:10:53 +0100
Message-ID: <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org>
In-Reply-To: <
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5410456746330627885=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5410456746330627885==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

+CC Jens, Etienne

On 12/10/21 06:00, Sumit Garg wrote:
> On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> =
wrote:
>>
>> -----Original Message-----
>> From: Sumit Garg <sumit.garg@linaro.org>
>> Sent: Thursday, December 9, 2021 7:41 PM
>> To: Wang, Xiaolei <Xiaolei.Wang@windriver.com>
>> Cc: jens.wiklander(a)linaro.org; op-tee(a)lists.trustedfirmware.org; linux=
-kernel(a)vger.kernel.org
>> Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in opt=
ee_handle_rpc()
>>
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang <xiaolei.wang@windriver.com> w=
rote:
>>>
>>> We observed the following kmemleak report:
>>> unreferenced object 0xffff000007904500 (size 128):
>>>   comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>>>   hex dump (first 32 bytes):
>>>     00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>>>     60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>>>   backtrace:
>>>     [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>>>     [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>>>     [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>>>     [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>>>     [<00000000c35884da>] optee_open_session+0x128/0x1ec
>>>     [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>>>     [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>>>     [<000000003df18bf1>] optee_probe+0x674/0x6cc
>>>     [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>>>     [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>>>     [<000000002f04c865>] driver_probe_device+0x58/0xc0
>>>     [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>>>     [<00000000c835f0df>] __driver_attach+0x84/0x124
>>>     [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>>>     [<000000001735e8a8>] driver_attach+0x24/0x30
>>>     [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>>>
>>> This is not a memory leak because we pass the share memory pointer to
>>> secure world and would get it from secure world before releasing it.
>>
>>> How about if it's actually a memory leak caused by the secure world?
>>> An example being secure world just allocates kernel memory via OPTEE_SMC_=
RPC_FUNC_ALLOC and doesn't free it via OPTEE_SMC_RPC_FUNC_FREE.
>>
>>> IMO, we need to cross-check optee-os if it's responsible for leaking kern=
el memory.
>>
>> Hi sumit,
>>
>> You mean we need to check whether there is a real memleak,
>> If being secure world just allocate kernel memory via OPTEE_SMC_PRC_FUNC_A=
LLOC and until the end, there is no free
>> It via OPTEE_SMC_PRC_FUNC_FREE, then we should judge it as a memory leak, =
wo need to judge whether it is caused by secure os?
>=20
> Yes. AFAICT, optee-os should allocate shared memory to communicate
> with tee-supplicant. So once the communication is done, the underlying
> shared memory should be freed. I can't think of any scenario where
> optee-os should keep hold-off shared memory indefinitely.

I believe it can happen when OP-TEE's CFG_PREALLOC_RPC_CACHE is y. See
the config file [1] and the commit which introduced this config [2].

[1] https://github.com/OP-TEE/optee_os/blob/3.15.0/mk/config.mk#L709
[2] https://github.com/OP-TEE/optee_os/commit/8887663248ad

--=20
Jerome

--===============5410456746330627885==--

