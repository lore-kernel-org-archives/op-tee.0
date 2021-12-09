From: "Wang, Xiaolei" <xiaolei.wang@windriver.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in
 optee_handle_rpc()
Date: Thu, 09 Dec 2021 23:31:47 +0800
Message-ID: <51e8382c-4645-6977-f8f8-13c6d18d2fea@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4211864206331069779=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4211864206331069779==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----Original Message-----
From: Sumit Garg<sumit.garg@linaro.org> =20
Sent: Thursday, December 9, 2021 7:41 PM
To: Wang, Xiaolei<Xiaolei.Wang@windriver.com>
Cc:jens.wiklander(a)linaro.org;op-tee(a)lists.trustedfirmware.org;linux-kerne=
l(a)vger.kernel.org
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_=
handle_rpc()

[Please note: This e-mail is from an EXTERNAL e-mail address]

On Mon, 6 Dec 2021 at 17:35, Xiaolei Wang<xiaolei.wang@windriver.com>  wrot=
e:

> We observed the following kmemleak report:
> unreferenced object 0xffff000007904500 (size 128):
>    comm "swapper/0", pid 1, jiffies 4294892671 (age 44.036s)
>    hex dump (first 32 bytes):
>      00 47 90 07 00 00 ff ff 60 00 c0 ff 00 00 00 00  .G......`.......
>      60 00 80 13 00 80 ff ff a0 00 00 00 00 00 00 00  `...............
>    backtrace:
>      [<000000004c12b1c7>] kmem_cache_alloc+0x1ac/0x2f4
>      [<000000005d23eb4f>] tee_shm_alloc+0x78/0x230
>      [<00000000794dd22c>] optee_handle_rpc+0x60/0x6f0
>      [<00000000d9f7c52d>] optee_do_call_with_arg+0x17c/0x1dc
>      [<00000000c35884da>] optee_open_session+0x128/0x1ec
>      [<000000001748f2ff>] tee_client_open_session+0x28/0x40
>      [<00000000aecb5389>] optee_enumerate_devices+0x84/0x2a0
>      [<000000003df18bf1>] optee_probe+0x674/0x6cc
>      [<000000003a4a534a>] platform_drv_probe+0x54/0xb0
>      [<000000000c51ce7d>] really_probe+0xe4/0x4d0
>      [<000000002f04c865>] driver_probe_device+0x58/0xc0
>      [<00000000b485397d>] device_driver_attach+0xc0/0xd0
>      [<00000000c835f0df>] __driver_attach+0x84/0x124
>      [<000000008e5a429c>] bus_for_each_dev+0x70/0xc0
>      [<000000001735e8a8>] driver_attach+0x24/0x30
>      [<000000006d94b04f>] bus_add_driver+0x104/0x1ec
>
> This is not a memory leak because we pass the share memory pointer to
> secure world and would get it from secure world before releasing it.
>
> IMO, we need to cross-check optee-os if it's responsible for leaking kernel=
 memory.

Hi Sumit

You mean we need to check whether there is a real memory leak,

if being secure world just allocates kernel memory via=20
OPTEE_SMC_RPC_FUNC_ALLOC

and until the end, there is no free it via OPTEE_SMC_RPC_FUNC_FREE,

then we should judge it as a memory leak.


thanks

xiaolei


>
>
> -Sumit
>
>> Signed-off-by: Xiaolei Wang<xiaolei.wang@windriver.com>
>> ---
>>   drivers/tee/optee/smc_abi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> index 6196d7c3888f..cf2e3293567d 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -23,6 +23,7 @@
>>   #include "optee_private.h"
>>   #include "optee_smc.h"
>>   #include "optee_rpc_cmd.h"
>> +#include <linux/kmemleak.h>
>>   #define CREATE_TRACE_POINTS
>>   #include "optee_trace.h"
>>
>> @@ -783,6 +784,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>>                          param->a4 =3D 0;
>>                          param->a5 =3D 0;
>>                  }
>> +               kmemleak_not_leak(shm);
>>                  break;
>>          case OPTEE_SMC_RPC_FUNC_FREE:
>>                  shm =3D reg_pair_to_ptr(param->a1, param->a2);
>> --
>> 2.25.1
>>

--===============4211864206331069779==--

