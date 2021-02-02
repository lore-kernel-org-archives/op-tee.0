From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: sync OP-TEE headers
Date: Tue, 02 Feb 2021 10:17:41 +0530
Message-ID: 
 <CAFA6WYNVWeTcHL=DpcAz7MkLBz2YRcU4K796H1bCC+yzY6mvtw@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C010001774e62035b-a15faf51-b1a7-419d-8171-c00abd27e?=
 =?utf-8?q?c0b-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5241939408274869329=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5241939408274869329==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Jan 2021 at 19:13, Jens Wiklander via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Pulls in updates in the internal headers from OP-TEE OS [1]. A few
> defines has been shortened, hence the changes in rpc.c. Defines not used
> by the driver in tee_rpc_cmd.h has been filtered out.
>
> Note that this does not change the ABI.
>
> Link: [1] https://github.com/OP-TEE/optee_os
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/optee_msg.h     | 154 ++----------------------------
>  drivers/tee/optee/optee_rpc_cmd.h | 103 ++++++++++++++++++++
>  drivers/tee/optee/optee_smc.h     |  70 +++++++++-----
>  drivers/tee/optee/rpc.c           |  39 ++++----
>  4 files changed, 178 insertions(+), 188 deletions(-)
>  create mode 100644 drivers/tee/optee/optee_rpc_cmd.h
>

Looks good to me apart from the minor nit below.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 7b2d919da2ac..7c4723b66668 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
>  /*
> - * Copyright (c) 2015-2019, Linaro Limited
> + * Copyright (c) 2015-2021, Linaro Limited
>   */
>  #ifndef _OPTEE_MSG_H
>  #define _OPTEE_MSG_H
> @@ -12,11 +12,9 @@
>   * This file defines the OP-TEE message protocol used to communicate
>   * with an instance of OP-TEE running in secure world.
>   *
> - * This file is divided into three sections.
> + * This file is divided into two sections.
>   * 1. Formatting of messages.
>   * 2. Requests from normal world
> - * 3. Requests from secure world, Remote Procedure Call (RPC), handled by
> - *    tee-supplicant.
>   */
>
>  /*************************************************************************=
****
> @@ -54,8 +52,8 @@
>   * Every entry in buffer should point to a 4k page beginning (12 least
>   * significant bits must be equal to zero).
>   *
> - * 12 least significant bints of optee_msg_param.u.tmem.buf_ptr should hol=
d page
> - * offset of the user buffer.
> + * 12 least significant bits of optee_msg_param.u.tmem.buf_ptr should hold
> + * page offset of user buffer.
>   *
>   * So, entries should be placed like members of this structure:
>   *
> @@ -176,17 +174,9 @@ struct optee_msg_param {
>   * @params: the parameters supplied to the OS Command
>   *
>   * All normal calls to Trusted OS uses this struct. If cmd requires further
> - * information than what these field holds it can be passed as a parameter
> + * information than what these fields hold it can be passed as a parameter
>   * tagged as meta (setting the OPTEE_MSG_ATTR_META bit in corresponding
> - * attrs field). All parameters tagged as meta has to come first.
> - *
> - * Temp memref parameters can be fragmented if supported by the Trusted OS
> - * (when optee_smc.h is bearer of this protocol this is indicated with
> - * OPTEE_SMC_SEC_CAP_UNREGISTERED_SHM). If a logical memref parameter is
> - * fragmented then has all but the last fragment the
> - * OPTEE_MSG_ATTR_FRAGMENT bit set in attrs. Even if a memref is fragmented
> - * it will still be presented as a single logical memref to the Trusted
> - * Application.
> + * attrs field). All parameters tagged as meta have to come first.
>   */
>  struct optee_msg_arg {
>         u32 cmd;
> @@ -290,13 +280,10 @@ struct optee_msg_arg {
>   * OPTEE_MSG_CMD_REGISTER_SHM registers a shared memory reference. The
>   * information is passed as:
>   * [in] param[0].attr                  OPTEE_MSG_ATTR_TYPE_TMEM_INPUT
> - *                                     [| OPTEE_MSG_ATTR_FRAGMENT]
> + *                                     [| OPTEE_MSG_ATTR_NONCONTIG]
>   * [in] param[0].u.tmem.buf_ptr                physical address (of first =
fragment)
>   * [in] param[0].u.tmem.size           size (of first fragment)
>   * [in] param[0].u.tmem.shm_ref                holds shared memory referen=
ce
> - * ...
> - * The shared memory can optionally be fragmented, temp memrefs can follow
> - * each other with all but the last with the OPTEE_MSG_ATTR_FRAGMENT bit s=
et.
>   *
>   * OPTEE_MSG_CMD_UNREGISTER_SHM unregisteres a previously registered shared

nit: since you are touching this file, s/unregisteres/unregisters/

-Sumit

>   * memory reference. The information is passed as:
> @@ -313,131 +300,4 @@ struct optee_msg_arg {
>  #define OPTEE_MSG_CMD_UNREGISTER_SHM   5
>  #define OPTEE_MSG_FUNCID_CALL_WITH_ARG 0x0004
>
> -/*************************************************************************=
****
> - * Part 3 - Requests from secure world, RPC
> - *************************************************************************=
****/
> -
> -/*
> - * All RPC is done with a struct optee_msg_arg as bearer of information,
> - * struct optee_msg_arg::arg holds values defined by OPTEE_MSG_RPC_CMD_* b=
elow
> - *
> - * RPC communication with tee-supplicant is reversed compared to normal
> - * client communication desribed above. The supplicant receives requests
> - * and sends responses.
> - */
> -
> -/*
> - * Load a TA into memory, defined in tee-supplicant
> - */
> -#define OPTEE_MSG_RPC_CMD_LOAD_TA      0
> -
> -/*
> - * Reserved
> - */
> -#define OPTEE_MSG_RPC_CMD_RPMB         1
> -
> -/*
> - * File system access, defined in tee-supplicant
> - */
> -#define OPTEE_MSG_RPC_CMD_FS           2
> -
> -/*
> - * Get time
> - *
> - * Returns number of seconds and nano seconds since the Epoch,
> - * 1970-01-01 00:00:00 +0000 (UTC).
> - *
> - * [out] param[0].u.value.a    Number of seconds
> - * [out] param[0].u.value.b    Number of nano seconds.
> - */
> -#define OPTEE_MSG_RPC_CMD_GET_TIME     3
> -
> -/*
> - * Wait queue primitive, helper for secure world to implement a wait queue.
> - *
> - * If secure world need to wait for a secure world mutex it issues a sleep
> - * request instead of spinning in secure world. Conversely is a wakeup
> - * request issued when a secure world mutex with a thread waiting thread is
> - * unlocked.
> - *
> - * Waiting on a key
> - * [in] param[0].u.value.a OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP
> - * [in] param[0].u.value.b wait key
> - *
> - * Waking up a key
> - * [in] param[0].u.value.a OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP
> - * [in] param[0].u.value.b wakeup key
> - */
> -#define OPTEE_MSG_RPC_CMD_WAIT_QUEUE   4
> -#define OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP 0
> -#define OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP        1
> -
> -/*
> - * Suspend execution
> - *
> - * [in] param[0].value .a number of milliseconds to suspend
> - */
> -#define OPTEE_MSG_RPC_CMD_SUSPEND      5
> -
> -/*
> - * Allocate a piece of shared memory
> - *
> - * Shared memory can optionally be fragmented, to support that additional
> - * spare param entries are allocated to make room for eventual fragments.
> - * The spare param entries has .attr =3D OPTEE_MSG_ATTR_TYPE_NONE when
> - * unused. All returned temp memrefs except the last should have the
> - * OPTEE_MSG_ATTR_FRAGMENT bit set in the attr field.
> - *
> - * [in]  param[0].u.value.a            type of memory one of
> - *                                     OPTEE_MSG_RPC_SHM_TYPE_* below
> - * [in]  param[0].u.value.b            requested size
> - * [in]  param[0].u.value.c            required alignment
> - *
> - * [out] param[0].u.tmem.buf_ptr       physical address (of first fragment)
> - * [out] param[0].u.tmem.size          size (of first fragment)
> - * [out] param[0].u.tmem.shm_ref       shared memory reference
> - * ...
> - * [out] param[n].u.tmem.buf_ptr       physical address
> - * [out] param[n].u.tmem.size          size
> - * [out] param[n].u.tmem.shm_ref       shared memory reference (same value
> - *                                     as in param[n-1].u.tmem.shm_ref)
> - */
> -#define OPTEE_MSG_RPC_CMD_SHM_ALLOC    6
> -/* Memory that can be shared with a non-secure user space application */
> -#define OPTEE_MSG_RPC_SHM_TYPE_APPL    0
> -/* Memory only shared with non-secure kernel */
> -#define OPTEE_MSG_RPC_SHM_TYPE_KERNEL  1
> -
> -/*
> - * Free shared memory previously allocated with OPTEE_MSG_RPC_CMD_SHM_ALLOC
> - *
> - * [in]  param[0].u.value.a            type of memory one of
> - *                                     OPTEE_MSG_RPC_SHM_TYPE_* above
> - * [in]  param[0].u.value.b            value of shared memory reference
> - *                                     returned in param[0].u.tmem.shm_ref
> - *                                     above
> - */
> -#define OPTEE_MSG_RPC_CMD_SHM_FREE     7
> -
> -/*
> - * Access a device on an i2c bus
> - *
> - * [in]  param[0].u.value.a            mode: RD(0), WR(1)
> - * [in]  param[0].u.value.b            i2c adapter
> - * [in]  param[0].u.value.c            i2c chip
> - *
> - * [in]  param[1].u.value.a            i2c control flags
> - *
> - * [in/out] memref[2]                  buffer to exchange the transfer data
> - *                                     with the secure world
> - *
> - * [out]  param[3].u.value.a           bytes transferred by the driver
> - */
> -#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> -/* I2C master transfer modes */
> -#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD 0
> -#define OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR 1
> -/* I2C master control flags */
> -#define OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT  BIT(0)
> -
>  #endif /* _OPTEE_MSG_H */
> diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rp=
c_cmd.h
> new file mode 100644
> index 000000000000..b8275140cef8
> --- /dev/null
> +++ b/drivers/tee/optee/optee_rpc_cmd.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: BSD-2-Clause */
> +/*
> + * Copyright (c) 2016-2021, Linaro Limited
> + */
> +
> +#ifndef __OPTEE_RPC_CMD_H
> +#define __OPTEE_RPC_CMD_H
> +
> +/*
> + * All RPC is done with a struct optee_msg_arg as bearer of information,
> + * struct optee_msg_arg::arg holds values defined by OPTEE_RPC_CMD_* below.
> + * Only the commands handled by the kernel driver are defined here.
> + *
> + * RPC communication with tee-supplicant is reversed compared to normal
> + * client communication described above. The supplicant receives requests
> + * and sends responses.
> + */
> +
> +/*
> + * Get time
> + *
> + * Returns number of seconds and nano seconds since the Epoch,
> + * 1970-01-01 00:00:00 +0000 (UTC).
> + *
> + * [out]    value[0].a     Number of seconds
> + * [out]    value[0].b     Number of nano seconds.
> + */
> +#define OPTEE_RPC_CMD_GET_TIME         3
> +
> +/*
> + * Wait queue primitive, helper for secure world to implement a wait queue.
> + *
> + * If secure world needs to wait for a secure world mutex it issues a sleep
> + * request instead of spinning in secure world. Conversely is a wakeup
> + * request issued when a secure world mutex with a thread waiting thread is
> + * unlocked.
> + *
> + * Waiting on a key
> + * [in]    value[0].a      OPTEE_RPC_WAIT_QUEUE_SLEEP
> + * [in]    value[0].b      Wait key
> + *
> + * Waking up a key
> + * [in]    value[0].a      OPTEE_RPC_WAIT_QUEUE_WAKEUP
> + * [in]    value[0].b      Wakeup key
> + */
> +#define OPTEE_RPC_CMD_WAIT_QUEUE       4
> +#define OPTEE_RPC_WAIT_QUEUE_SLEEP     0
> +#define OPTEE_RPC_WAIT_QUEUE_WAKEUP    1
> +
> +/*
> + * Suspend execution
> + *
> + * [in]    value[0].a  Number of milliseconds to suspend
> + */
> +#define OPTEE_RPC_CMD_SUSPEND          5
> +
> +/*
> + * Allocate a piece of shared memory
> + *
> + * [in]    value[0].a      Type of memory one of
> + *                         OPTEE_RPC_SHM_TYPE_* below
> + * [in]    value[0].b      Requested size
> + * [in]    value[0].c      Required alignment
> + * [out]   memref[0]       Buffer
> + */
> +#define OPTEE_RPC_CMD_SHM_ALLOC                6
> +/* Memory that can be shared with a non-secure user space application */
> +#define OPTEE_RPC_SHM_TYPE_APPL                0
> +/* Memory only shared with non-secure kernel */
> +#define OPTEE_RPC_SHM_TYPE_KERNEL      1
> +
> +/*
> + * Free shared memory previously allocated with OPTEE_RPC_CMD_SHM_ALLOC
> + *
> + * [in]     value[0].a     Type of memory one of
> + *                         OPTEE_RPC_SHM_TYPE_* above
> + * [in]     value[0].b     Value of shared memory reference or cookie
> + */
> +#define OPTEE_RPC_CMD_SHM_FREE         7
> +
> +/*
> + * Issue master requests (read and write operations) to an I2C chip.
> + *
> + * [in]     value[0].a     Transfer mode (OPTEE_RPC_I2C_TRANSFER_*)
> + * [in]     value[0].b     The I2C bus (a.k.a adapter).
> + *                             16 bit field.
> + * [in]     value[0].c     The I2C chip (a.k.a address).
> + *                             16 bit field (either 7 or 10 bit effective).
> + * [in]     value[1].a     The I2C master control flags (ie, 10 bit addres=
s).
> + *                             16 bit field.
> + * [in/out] memref[2]      Buffer used for data transfers.
> + * [out]    value[3].a     Number of bytes transferred by the REE.
> + */
> +#define OPTEE_RPC_CMD_I2C_TRANSFER     21
> +
> +/* I2C master transfer modes */
> +#define OPTEE_RPC_I2C_TRANSFER_RD      0
> +#define OPTEE_RPC_I2C_TRANSFER_WR      1
> +
> +/* I2C master control flags */
> +#define OPTEE_RPC_I2C_FLAGS_TEN_BIT    BIT(0)
> +
> +#endif /*__OPTEE_RPC_CMD_H*/
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 777ad54d4c2c..821e1c30c150 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
>  /*
> - * Copyright (c) 2015-2019, Linaro Limited
> + * Copyright (c) 2015-2021, Linaro Limited
>   */
>  #ifndef OPTEE_SMC_H
>  #define OPTEE_SMC_H
> @@ -39,10 +39,10 @@
>  /*
>   * Function specified by SMC Calling convention
>   *
> - * Return one of the following UIDs if using API specified in this file
> - * without further extentions:
> - * 65cb6b93-af0c-4617-8ed6-644a8d1140f8
> - * see also OPTEE_SMC_UID_* in optee_msg.h
> + * Return the following UID if using API specified in this file
> + * without further extensions:
> + * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> + * see also OPTEE_MSG_UID_* in optee_msg.h
>   */
>  #define OPTEE_SMC_FUNCID_CALLS_UID OPTEE_MSG_FUNCID_CALLS_UID
>  #define OPTEE_SMC_CALLS_UID \
> @@ -53,7 +53,7 @@
>  /*
>   * Function specified by SMC Calling convention
>   *
> - * Returns 2.0 if using API specified in this file without further extenti=
ons.
> + * Returns 2.0 if using API specified in this file without further extensi=
ons.
>   * see also OPTEE_MSG_REVISION_* in optee_msg.h
>   */
>  #define OPTEE_SMC_FUNCID_CALLS_REVISION OPTEE_MSG_FUNCID_CALLS_REVISION
> @@ -109,8 +109,8 @@ struct optee_smc_call_get_os_revision_result {
>   *
>   * Call register usage:
>   * a0  SMC Function ID, OPTEE_SMC*CALL_WITH_ARG
> - * a1  Upper 32bit of a 64bit physical pointer to a struct optee_msg_arg
> - * a2  Lower 32bit of a 64bit physical pointer to a struct optee_msg_arg
> + * a1  Upper 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
> + * a2  Lower 32 bits of a 64-bit physical pointer to a struct optee_msg_arg
>   * a3  Cache settings, not used if physical pointer is in a predefined sha=
red
>   *     memory area else per OPTEE_SMC_SHM_*
>   * a4-6        Not used
> @@ -214,8 +214,9 @@ struct optee_smc_get_shm_config_result {
>   * secure world accepts command buffers located in any parts of non-secure=
 RAM
>   */
>  #define OPTEE_SMC_SEC_CAP_DYNAMIC_SHM          BIT(2)
> -
> -/* Secure world supports Shared Memory with a NULL buffer reference */
> +/* Secure world is built with virtualization support */
> +#define OPTEE_SMC_SEC_CAP_VIRTUALIZATION       BIT(3)
> +/* Secure world supports Shared Memory with a NULL reference */
>  #define OPTEE_SMC_SEC_CAP_MEMREF_NULL          BIT(4)
>
>  #define OPTEE_SMC_FUNCID_EXCHANGE_CAPABILITIES 9
> @@ -245,8 +246,8 @@ struct optee_smc_exchange_capabilities_result {
>   *
>   * Normal return register usage:
>   * a0  OPTEE_SMC_RETURN_OK
> - * a1  Upper 32bit of a 64bit Shared memory cookie
> - * a2  Lower 32bit of a 64bit Shared memory cookie
> + * a1  Upper 32 bits of a 64-bit Shared memory cookie
> + * a2  Lower 32 bits of a 64-bit Shared memory cookie
>   * a3-7        Preserved
>   *
>   * Cache empty return register usage:
> @@ -293,6 +294,31 @@ struct optee_smc_disable_shm_cache_result {
>  #define OPTEE_SMC_ENABLE_SHM_CACHE \
>         OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_ENABLE_SHM_CACHE)
>
> +/*
> + * Query OP-TEE about number of supported threads
> + *
> + * Normal World OS or Hypervisor issues this call to find out how many
> + * threads OP-TEE supports. That is how many standard calls can be issued
> + * in parallel before OP-TEE will return OPTEE_SMC_RETURN_ETHREAD_LIMIT.
> + *
> + * Call requests usage:
> + * a0  SMC Function ID, OPTEE_SMC_GET_THREAD_COUNT
> + * a1-6 Not used
> + * a7  Hypervisor Client ID register
> + *
> + * Normal return register usage:
> + * a0  OPTEE_SMC_RETURN_OK
> + * a1  Number of threads
> + * a2-7 Preserved
> + *
> + * Error return:
> + * a0  OPTEE_SMC_RETURN_UNKNOWN_FUNCTION   Requested call is not implement=
ed
> + * a1-7        Preserved
> + */
> +#define OPTEE_SMC_FUNCID_GET_THREAD_COUNT      15
> +#define OPTEE_SMC_GET_THREAD_COUNT \
> +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_GET_THREAD_COUNT)
> +
>  /*
>   * Resume from RPC (for example after processing a foreign interrupt)
>   *
> @@ -341,16 +367,16 @@ struct optee_smc_disable_shm_cache_result {
>   *
>   * "Return" register usage:
>   * a0  SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
> - * a1  Upper 32bits of 64bit physical pointer to allocated
> + * a1  Upper 32 bits of 64-bit physical pointer to allocated
>   *     memory, (a1 =3D=3D 0 && a2 =3D=3D 0) if size was 0 or if memory can=
't
>   *     be allocated.
> - * a2  Lower 32bits of 64bit physical pointer to allocated
> + * a2  Lower 32 bits of 64-bit physical pointer to allocated
>   *     memory, (a1 =3D=3D 0 && a2 =3D=3D 0) if size was 0 or if memory can=
't
>   *     be allocated
>   * a3  Preserved
> - * a4  Upper 32bits of 64bit Shared memory cookie used when freeing
> + * a4  Upper 32 bits of 64-bit Shared memory cookie used when freeing
>   *     the memory or doing an RPC
> - * a5  Lower 32bits of 64bit Shared memory cookie used when freeing
> + * a5  Lower 32 bits of 64-bit Shared memory cookie used when freeing
>   *     the memory or doing an RPC
>   * a6-7        Preserved
>   */
> @@ -363,9 +389,9 @@ struct optee_smc_disable_shm_cache_result {
>   *
>   * "Call" register usage:
>   * a0  This value, OPTEE_SMC_RETURN_RPC_FREE
> - * a1  Upper 32bits of 64bit shared memory cookie belonging to this
> + * a1  Upper 32 bits of 64-bit shared memory cookie belonging to this
>   *     argument memory
> - * a2  Lower 32bits of 64bit shared memory cookie belonging to this
> + * a2  Lower 32 bits of 64-bit shared memory cookie belonging to this
>   *     argument memory
>   * a3-7        Resume information, must be preserved
>   *
> @@ -379,7 +405,7 @@ struct optee_smc_disable_shm_cache_result {
>         OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_FREE)
>
>  /*
> - * Deliver foreign interrupt to normal world.
> + * Deliver a foreign interrupt in normal world.
>   *
>   * "Call" register usage:
>   * a0  OPTEE_SMC_RETURN_RPC_FOREIGN_INTR
> @@ -389,7 +415,7 @@ struct optee_smc_disable_shm_cache_result {
>   * a0  SMC Function ID, OPTEE_SMC_CALL_RETURN_FROM_RPC.
>   * a1-7        Preserved
>   */
> -#define OPTEE_SMC_RPC_FUNC_FOREIGN_INTR                4
> +#define OPTEE_SMC_RPC_FUNC_FOREIGN_INTR        4
>  #define OPTEE_SMC_RETURN_RPC_FOREIGN_INTR \
>         OPTEE_SMC_RPC_VAL(OPTEE_SMC_RPC_FUNC_FOREIGN_INTR)
>
> @@ -405,10 +431,10 @@ struct optee_smc_disable_shm_cache_result {
>   *
>   * "Call" register usage:
>   * a0  OPTEE_SMC_RETURN_RPC_CMD
> - * a1  Upper 32bit of a 64bit Shared memory cookie holding a
> + * a1  Upper 32 bits of a 64-bit Shared memory cookie holding a
>   *     struct optee_msg_arg, must be preserved, only the data should
>   *     be updated
> - * a2  Lower 32bit of a 64bit Shared memory cookie holding a
> + * a2  Lower 32 bits of a 64-bit Shared memory cookie holding a
>   *     struct optee_msg_arg, must be preserved, only the data should
>   *     be updated
>   * a3-7        Resume information, must be preserved
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 1e3614e4798f..a0c30b664e53 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -12,6 +12,7 @@
>  #include <linux/tee_drv.h>
>  #include "optee_private.h"
>  #include "optee_smc.h"
> +#include "optee_rpc_cmd.h"
>
>  struct wq_entry {
>         struct list_head link;
> @@ -89,7 +90,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_c=
ontext *ctx,
>         if (!client.adapter)
>                 goto bad;
>
> -       if (params[1].u.value.a & OPTEE_MSG_RPC_CMD_I2C_FLAGS_TEN_BIT) {
> +       if (params[1].u.value.a & OPTEE_RPC_I2C_FLAGS_TEN_BIT) {
>                 if (!i2c_check_functionality(client.adapter,
>                                              I2C_FUNC_10BIT_ADDR)) {
>                         i2c_put_adapter(client.adapter);
> @@ -103,11 +104,11 @@ static void handle_rpc_func_cmd_i2c_transfer(struct t=
ee_context *ctx,
>         snprintf(client.name, I2C_NAME_SIZE, "i2c%d", client.adapter->nr);
>
>         switch (params[0].u.value.a) {
> -       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_RD:
> +       case OPTEE_RPC_I2C_TRANSFER_RD:
>                 ret =3D i2c_master_recv(&client, params[2].u.memref.shm->ka=
ddr,
>                                       params[2].u.memref.size);
>                 break;
> -       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER_WR:
> +       case OPTEE_RPC_I2C_TRANSFER_WR:
>                 ret =3D i2c_master_send(&client, params[2].u.memref.shm->ka=
ddr,
>                                       params[2].u.memref.size);
>                 break;
> @@ -194,10 +195,10 @@ static void handle_rpc_func_cmd_wq(struct optee *opte=
e,
>                 goto bad;
>
>         switch (arg->params[0].u.value.a) {
> -       case OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP:
> +       case OPTEE_RPC_WAIT_QUEUE_SLEEP:
>                 wq_sleep(&optee->wait_queue, arg->params[0].u.value.b);
>                 break;
> -       case OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP:
> +       case OPTEE_RPC_WAIT_QUEUE_WAKEUP:
>                 wq_wakeup(&optee->wait_queue, arg->params[0].u.value.b);
>                 break;
>         default:
> @@ -267,11 +268,11 @@ static struct tee_shm *cmd_alloc_suppl(struct tee_con=
text *ctx, size_t sz)
>         struct tee_shm *shm;
>
>         param.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
> -       param.u.value.a =3D OPTEE_MSG_RPC_SHM_TYPE_APPL;
> +       param.u.value.a =3D OPTEE_RPC_SHM_TYPE_APPL;
>         param.u.value.b =3D sz;
>         param.u.value.c =3D 0;
>
> -       ret =3D optee_supp_thrd_req(ctx, OPTEE_MSG_RPC_CMD_SHM_ALLOC, 1, &p=
aram);
> +       ret =3D optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_ALLOC, 1, &param=
);
>         if (ret)
>                 return ERR_PTR(-ENOMEM);
>
> @@ -308,10 +309,10 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_=
context *ctx,
>
>         sz =3D arg->params[0].u.value.b;
>         switch (arg->params[0].u.value.a) {
> -       case OPTEE_MSG_RPC_SHM_TYPE_APPL:
> +       case OPTEE_RPC_SHM_TYPE_APPL:
>                 shm =3D cmd_alloc_suppl(ctx, sz);
>                 break;
> -       case OPTEE_MSG_RPC_SHM_TYPE_KERNEL:
> +       case OPTEE_RPC_SHM_TYPE_KERNEL:
>                 shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED);
>                 break;
>         default:
> @@ -383,7 +384,7 @@ static void cmd_free_suppl(struct tee_context *ctx, str=
uct tee_shm *shm)
>         struct tee_param param;
>
>         param.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
> -       param.u.value.a =3D OPTEE_MSG_RPC_SHM_TYPE_APPL;
> +       param.u.value.a =3D OPTEE_RPC_SHM_TYPE_APPL;
>         param.u.value.b =3D tee_shm_get_id(shm);
>         param.u.value.c =3D 0;
>
> @@ -400,7 +401,7 @@ static void cmd_free_suppl(struct tee_context *ctx, str=
uct tee_shm *shm)
>          */
>         tee_shm_put(shm);
>
> -       optee_supp_thrd_req(ctx, OPTEE_MSG_RPC_CMD_SHM_FREE, 1, &param);
> +       optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
>  }
>
>  static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
> @@ -418,10 +419,10 @@ static void handle_rpc_func_cmd_shm_free(struct tee_c=
ontext *ctx,
>
>         shm =3D (struct tee_shm *)(unsigned long)arg->params[0].u.value.b;
>         switch (arg->params[0].u.value.a) {
> -       case OPTEE_MSG_RPC_SHM_TYPE_APPL:
> +       case OPTEE_RPC_SHM_TYPE_APPL:
>                 cmd_free_suppl(ctx, shm);
>                 break;
> -       case OPTEE_MSG_RPC_SHM_TYPE_KERNEL:
> +       case OPTEE_RPC_SHM_TYPE_KERNEL:
>                 tee_shm_free(shm);
>                 break;
>         default:
> @@ -458,23 +459,23 @@ static void handle_rpc_func_cmd(struct tee_context *c=
tx, struct optee *optee,
>         }
>
>         switch (arg->cmd) {
> -       case OPTEE_MSG_RPC_CMD_GET_TIME:
> +       case OPTEE_RPC_CMD_GET_TIME:
>                 handle_rpc_func_cmd_get_time(arg);
>                 break;
> -       case OPTEE_MSG_RPC_CMD_WAIT_QUEUE:
> +       case OPTEE_RPC_CMD_WAIT_QUEUE:
>                 handle_rpc_func_cmd_wq(optee, arg);
>                 break;
> -       case OPTEE_MSG_RPC_CMD_SUSPEND:
> +       case OPTEE_RPC_CMD_SUSPEND:
>                 handle_rpc_func_cmd_wait(arg);
>                 break;
> -       case OPTEE_MSG_RPC_CMD_SHM_ALLOC:
> +       case OPTEE_RPC_CMD_SHM_ALLOC:
>                 free_pages_list(call_ctx);
>                 handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
>                 break;
> -       case OPTEE_MSG_RPC_CMD_SHM_FREE:
> +       case OPTEE_RPC_CMD_SHM_FREE:
>                 handle_rpc_func_cmd_shm_free(ctx, arg);
>                 break;
> -       case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> +       case OPTEE_RPC_CMD_I2C_TRANSFER:
>                 handle_rpc_func_cmd_i2c_transfer(ctx, arg);
>                 break;
>         default:
> --
> 2.25.1
>

--===============5241939408274869329==--

