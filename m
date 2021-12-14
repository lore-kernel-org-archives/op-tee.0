From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: drivers/tee double-free of page when optee_shm_register fails
Date: Tue, 14 Dec 2021 13:11:20 +0530
Message-ID: 
 <CAFA6WYNNTr0O60ggowzqpJVso5cySO=peBTBTzVm9MzZy8b4ww@mail.gmail.com>
In-Reply-To: <8a66d68a-16e0-20a7-98d5-3c8623a0d8c4@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5466225882118778184=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5466225882118778184==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Lars,

On Fri, 10 Dec 2021 at 20:23, Lars Persson <larper@axis.com> wrote:
>
> Hi
>
> Me and Patrik have been tracing a kernel memory corruption bug that is
> triggered when op-tee runs out of resources and returns an error from
> the OPTEE_MSG_CMD_REGISTER_SHM call. This is yet another fall-out from
> Patrik's fuzzing of the TEE subsystem.
>
> The symptoms would look like this when page debugging is enabled:
> BUG: Bad page state in process optee_example_h  pfn:46bb0
> page:(ptrval) refcount:-1 mapcount:0 mapping:00000000 index:0x0 pfn:0x46bb0
> flags: 0x0(zone=0)
>
> Our reproducer runs a loop with the TEE_IOC_SHM_ALLOC until memory runs
> out at the optee-os end (dynamic SHM enabled). The error is 100%
> reproducible with such a loop.

Can you share a simple reproducer test application (CA and TA)?

>
> We have traced this down to what seems to be a miss in the memory
> ownership contract during the call to OPTEE_MSG_CMD_REGISTER_SHM.
>
> When pool_op_alloc() detects that optee_shm_register() has failed, it
> will free the allocated page at the very end of the function.
> Unfortunately that page has already been freed because OP-TEE has sent a
> OPTEE_RPC_CMD_SHM_FREE for this shm object before returning from
> OPTEE_MSG_CMD_REGISTER_SHM. This is my conclusion based on prints added
> to the code.

I can't see any RPC free command from OP-TEE in case the
OPTEE_MSG_CMD_REGISTER_SHM fails. Have you compared kernel addresses
for SHM during OPTEE_MSG_CMD_REGISTER_SHM and OPTEE_RPC_CMD_SHM_FREE?

>
> I cannot write a patch for this because I am at a loss of who actually
> is supposed to trigger the free of the pages in this situation. Is there
> an API spec that makes this clear ?

It should only be the pool_op_alloc() API in case
OPTEE_MSG_CMD_REGISTER_SHM fails.

-Sumit

>
> BR,
>   Lars

--===============5466225882118778184==--

