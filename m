From: Lars Persson <larper@axis.com>
To: op-tee@lists.trustedfirmware.org
Subject: drivers/tee double-free of page when optee_shm_register fails
Date: Fri, 10 Dec 2021 15:53:15 +0100
Message-ID: <8a66d68a-16e0-20a7-98d5-3c8623a0d8c4@axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8726338642269333135=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8726338642269333135==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi

Me and Patrik have been tracing a kernel memory corruption bug that is 
triggered when op-tee runs out of resources and returns an error from 
the OPTEE_MSG_CMD_REGISTER_SHM call. This is yet another fall-out from 
Patrik's fuzzing of the TEE subsystem.

The symptoms would look like this when page debugging is enabled:
BUG: Bad page state in process optee_example_h  pfn:46bb0
page:(ptrval) refcount:-1 mapcount:0 mapping:00000000 index:0x0 pfn:0x46bb0
flags: 0x0(zone=0)

Our reproducer runs a loop with the TEE_IOC_SHM_ALLOC until memory runs 
out at the optee-os end (dynamic SHM enabled). The error is 100% 
reproducible with such a loop.

We have traced this down to what seems to be a miss in the memory 
ownership contract during the call to OPTEE_MSG_CMD_REGISTER_SHM.

When pool_op_alloc() detects that optee_shm_register() has failed, it 
will free the allocated page at the very end of the function. 
Unfortunately that page has already been freed because OP-TEE has sent a 
OPTEE_RPC_CMD_SHM_FREE for this shm object before returning from 
OPTEE_MSG_CMD_REGISTER_SHM. This is my conclusion based on prints added 
to the code.

I cannot write a patch for this because I am at a loss of who actually 
is supposed to trigger the free of the pages in this situation. Is there 
an API spec that makes this clear ?

BR,
  Lars

--===============8726338642269333135==--

