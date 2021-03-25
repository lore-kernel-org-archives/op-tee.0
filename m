From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH 3/6] optee: sync optee_msg.h and optee_rpc_cmd.h
Date: Thu, 25 Mar 2021 16:44:23 +0100
Message-ID: <20210325154426.3520148-4-jens.wiklander@linaro.org>
In-Reply-To: <20210325154426.3520148-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6713394212361454784=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6713394212361454784==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Updates to latest optee_msg.h and optee_rpc_cmd.h. There's no changes in
the ABI. Only some clarifications and a complete specification of RPC
requests where the latter is now in a separate file, optee_rpc_cmd.h.

Most of the RPC requests are not served by the OP-TEE driver instead
they are forwarded as opaque requests to tee-supplicant.

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/tee/optee/optee_msg.h     | 143 +------------
 drivers/tee/optee/optee_rpc_cmd.h | 333 ++++++++++++++++++++++++++++++
 drivers/tee/optee/rpc.c           |  32 +--
 3 files changed, 360 insertions(+), 148 deletions(-)
 create mode 100644 drivers/tee/optee/optee_rpc_cmd.h

diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
index 7b2d919da2ac..de96882f7b9b 100644
--- a/drivers/tee/optee/optee_msg.h
+++ b/drivers/tee/optee/optee_msg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
 /*
- * Copyright (c) 2015-2019, Linaro Limited
+ * Copyright (c) 2015-2021, Linaro Limited
  */
 #ifndef _OPTEE_MSG_H
 #define _OPTEE_MSG_H
@@ -11,12 +11,6 @@
 /*
  * This file defines the OP-TEE message protocol used to communicate
  * with an instance of OP-TEE running in secure world.
- *
- * This file is divided into three sections.
- * 1. Formatting of messages.
- * 2. Requests from normal world
- * 3. Requests from secure world, Remote Procedure Call (RPC), handled by
- *    tee-supplicant.
  */
=20
 /***************************************************************************=
**
@@ -54,14 +48,14 @@
  * Every entry in buffer should point to a 4k page beginning (12 least
  * significant bits must be equal to zero).
  *
- * 12 least significant bints of optee_msg_param.u.tmem.buf_ptr should hold =
page
- * offset of the user buffer.
+ * 12 least significant bits of optee_msg_param.u.tmem.buf_ptr should hold
+ * page offset of user buffer.
  *
  * So, entries should be placed like members of this structure:
  *
  * struct page_data {
- *   uint64_t pages_array[OPTEE_MSG_NONCONTIG_PAGE_SIZE/sizeof(uint64_t) - 1=
];
- *   uint64_t next_page_data;
+ *   u64 pages_array[OPTEE_MSG_NONCONTIG_PAGE_SIZE/sizeof(u64) - 1];
+ *   u64 next_page_data;
  * };
  *
  * Structure is designed to exactly fit into the page size
@@ -150,7 +144,7 @@ struct optee_msg_param_value {
  * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used=
 in
  * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value,
  * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @tmem and
- * OPTEE_MSG_ATTR_TYPE_RMEM_* indicates @rmem,
+ * OPTEE_MSG_ATTR_TYPE_RMEM_* indicates @rmem.
  * OPTEE_MSG_ATTR_TYPE_NONE indicates that none of the members are used.
  */
 struct optee_msg_param {
@@ -176,17 +170,9 @@ struct optee_msg_param {
  * @params: the parameters supplied to the OS Command
  *
  * All normal calls to Trusted OS uses this struct. If cmd requires further
- * information than what these field holds it can be passed as a parameter
+ * information than what these fields hold it can be passed as a parameter
  * tagged as meta (setting the OPTEE_MSG_ATTR_META bit in corresponding
- * attrs field). All parameters tagged as meta has to come first.
- *
- * Temp memref parameters can be fragmented if supported by the Trusted OS
- * (when optee_smc.h is bearer of this protocol this is indicated with
- * OPTEE_SMC_SEC_CAP_UNREGISTERED_SHM). If a logical memref parameter is
- * fragmented then has all but the last fragment the
- * OPTEE_MSG_ATTR_FRAGMENT bit set in attrs. Even if a memref is fragmented
- * it will still be presented as a single logical memref to the Trusted
- * Application.
+ * attrs field). All parameters tagged as meta have to come first.
  */
 struct optee_msg_arg {
 	u32 cmd;
@@ -199,7 +185,7 @@ struct optee_msg_arg {
 	u32 num_params;
=20
 	/* num_params tells the actual number of element in params */
-	struct optee_msg_param params[0];
+	struct optee_msg_param params[];
 };
=20
 /**
@@ -290,13 +276,10 @@ struct optee_msg_arg {
  * OPTEE_MSG_CMD_REGISTER_SHM registers a shared memory reference. The
  * information is passed as:
  * [in] param[0].attr			OPTEE_MSG_ATTR_TYPE_TMEM_INPUT
- *					[| OPTEE_MSG_ATTR_FRAGMENT]
+ *					[| OPTEE_MSG_ATTR_NONCONTIG]
  * [in] param[0].u.tmem.buf_ptr		physical address (of first fragment)
  * [in] param[0].u.tmem.size		size (of first fragment)
  * [in] param[0].u.tmem.shm_ref		holds shared memory reference
- * ...
- * The shared memory can optionally be fragmented, temp memrefs can follow
- * each other with all but the last with the OPTEE_MSG_ATTR_FRAGMENT bit set.
  *
  * OPTEE_MSG_CMD_UNREGISTER_SHM unregisteres a previously registered shared
  * memory reference. The information is passed as:
@@ -313,112 +296,6 @@ struct optee_msg_arg {
 #define OPTEE_MSG_CMD_UNREGISTER_SHM	5
 #define OPTEE_MSG_FUNCID_CALL_WITH_ARG	0x0004
=20
-/***************************************************************************=
**
- * Part 3 - Requests from secure world, RPC
- ***************************************************************************=
**/
-
-/*
- * All RPC is done with a struct optee_msg_arg as bearer of information,
- * struct optee_msg_arg::arg holds values defined by OPTEE_MSG_RPC_CMD_* bel=
ow
- *
- * RPC communication with tee-supplicant is reversed compared to normal
- * client communication desribed above. The supplicant receives requests
- * and sends responses.
- */
-
-/*
- * Load a TA into memory, defined in tee-supplicant
- */
-#define OPTEE_MSG_RPC_CMD_LOAD_TA	0
-
-/*
- * Reserved
- */
-#define OPTEE_MSG_RPC_CMD_RPMB		1
-
-/*
- * File system access, defined in tee-supplicant
- */
-#define OPTEE_MSG_RPC_CMD_FS		2
-
-/*
- * Get time
- *
- * Returns number of seconds and nano seconds since the Epoch,
- * 1970-01-01 00:00:00 +0000 (UTC).
- *
- * [out] param[0].u.value.a	Number of seconds
- * [out] param[0].u.value.b	Number of nano seconds.
- */
-#define OPTEE_MSG_RPC_CMD_GET_TIME	3
-
-/*
- * Wait queue primitive, helper for secure world to implement a wait queue.
- *
- * If secure world need to wait for a secure world mutex it issues a sleep
- * request instead of spinning in secure world. Conversely is a wakeup
- * request issued when a secure world mutex with a thread waiting thread is
- * unlocked.
- *
- * Waiting on a key
- * [in] param[0].u.value.a OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP
- * [in] param[0].u.value.b wait key
- *
- * Waking up a key
- * [in] param[0].u.value.a OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP
- * [in] param[0].u.value.b wakeup key
- */
-#define OPTEE_MSG_RPC_CMD_WAIT_QUEUE	4
-#define OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP	0
-#define OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP	1
-
-/*
- * Suspend execution
- *
- * [in] param[0].value	.a number of milliseconds to suspend
- */
-#define OPTEE_MSG_RPC_CMD_SUSPEND	5
-
-/*
- * Allocate a piece of shared memory
- *
- * Shared memory can optionally be fragmented, to support that additional
- * spare param entries are allocated to make room for eventual fragments.
- * The spare param entries has .attr =3D OPTEE_MSG_ATTR_TYPE_NONE when
- * unused. All returned temp memrefs except the last should have the
- * OPTEE_MSG_ATTR_FRAGMENT bit set in the attr field.
- *
- * [in]  param[0].u.value.a		type of memory one of
- *					OPTEE_MSG_RPC_SHM_TYPE_* below
- * [in]  param[0].u.value.b		requested size
- * [in]  param[0].u.value.c		required alignment
- *
- * [out] param[0].u.tmem.buf_ptr	physical address (of first fragment)
- * [out] param[0].u.tmem.size		size (of first fragment)
- * [out] param[0].u.tmem.shm_ref	shared memory reference
- * ...
- * [out] param[n].u.tmem.buf_ptr	physical address
- * [out] param[n].u.tmem.size		size
- * [out] param[n].u.tmem.shm_ref	shared memory reference (same value
- *					as in param[n-1].u.tmem.shm_ref)
- */
-#define OPTEE_MSG_RPC_CMD_SHM_ALLOC	6
-/* Memory that can be shared with a non-secure user space application */
-#define OPTEE_MSG_RPC_SHM_TYPE_APPL	0
-/* Memory only shared with non-secure kernel */
-#define OPTEE_MSG_RPC_SHM_TYPE_KERNEL	1
-
-/*
- * Free shared memory previously allocated with OPTEE_MSG_RPC_CMD_SHM_ALLOC
- *
- * [in]  param[0].u.value.a		type of memory one of
- *					OPTEE_MSG_RPC_SHM_TYPE_* above
- * [in]  param[0].u.value.b		value of shared memory reference
- *					returned in param[0].u.tmem.shm_ref
- *					above
- */
-#define OPTEE_MSG_RPC_CMD_SHM_FREE	7
-
 /*
  * Access a device on an i2c bus
  *
diff --git a/drivers/tee/optee/optee_rpc_cmd.h b/drivers/tee/optee/optee_rpc_=
cmd.h
new file mode 100644
index 000000000000..712aa32513d7
--- /dev/null
+++ b/drivers/tee/optee/optee_rpc_cmd.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2016-2018, Linaro Limited
+ */
+
+#ifndef __OPTEE_RPC_CMD_H
+#define __OPTEE_RPC_CMD_H
+
+/*
+ * All RPC is done with a struct optee_msg_arg as bearer of information,
+ * struct optee_msg_arg::arg holds values defined by OPTEE_RPC_CMD_* below.
+ * Only the commands handled by the kernel driver are defined here.
+ *
+ * RPC communication with tee-supplicant is reversed compared to normal
+ * client communication described above. The supplicant receives requests
+ * and sends responses.
+ */
+
+/*
+ * Load a TA into memory
+ *
+ * Since the size of the TA isn't known in advance the size of the TA is
+ * can be queried with a NULL buffer.
+ *
+ * [in]     value[0].a-b    UUID
+ * [out]    memref[1]	    Buffer with TA
+ */
+#define OPTEE_RPC_CMD_LOAD_TA		0
+
+/*
+ * Replay Protected Memory Block access
+ *
+ * [in]     memref[0]	    Frames to device
+ * [out]    memref[1]	    Frames from device
+ */
+#define OPTEE_RPC_CMD_RPMB		1
+
+/*
+ * File system access, see definition of protocol below
+ */
+#define OPTEE_RPC_CMD_FS		2
+
+/*
+ * Get time
+ *
+ * Returns number of seconds and nano seconds since the Epoch,
+ * 1970-01-01 00:00:00 +0000 (UTC).
+ *
+ * [out]    value[0].a	    Number of seconds
+ * [out]    value[0].b	    Number of nano seconds.
+ */
+#define OPTEE_RPC_CMD_GET_TIME		3
+
+/*
+ * Wait queue primitive, helper for secure world to implement a wait queue.
+ *
+ * If secure world needs to wait for a secure world mutex it issues a sleep
+ * request instead of spinning in secure world. Conversely is a wakeup
+ * request issued when a secure world mutex with a thread waiting thread is
+ * unlocked.
+ *
+ * Waiting on a key
+ * [in]    value[0].a	    OPTEE_RPC_WAIT_QUEUE_SLEEP
+ * [in]    value[0].b	    Wait key
+ *
+ * Waking up a key
+ * [in]    value[0].a	    OPTEE_RPC_WAIT_QUEUE_WAKEUP
+ * [in]    value[0].b	    Wakeup key
+ */
+#define OPTEE_RPC_CMD_WAIT_QUEUE	4
+#define OPTEE_RPC_WAIT_QUEUE_SLEEP	0
+#define OPTEE_RPC_WAIT_QUEUE_WAKEUP	1
+
+/*
+ * Suspend execution
+ *
+ * [in]    value[0].a	Number of milliseconds to suspend
+ */
+#define OPTEE_RPC_CMD_SUSPEND		5
+
+/*
+ * Allocate a piece of shared memory
+ *
+ * [in]    value[0].a	    Type of memory one of
+ *			    OPTEE_RPC_SHM_TYPE_* below
+ * [in]    value[0].b	    Requested size
+ * [in]    value[0].c	    Required alignment
+ * [out]   memref[0]	    Buffer
+ */
+#define OPTEE_RPC_CMD_SHM_ALLOC		6
+/* Memory that can be shared with a non-secure user space application */
+#define OPTEE_RPC_SHM_TYPE_APPL		0
+/* Memory only shared with non-secure kernel */
+#define OPTEE_RPC_SHM_TYPE_KERNEL	1
+/*
+ * Memory shared with non-secure kernel and exported to a non-secure user
+ * space application
+ */
+#define OPTEE_RPC_SHM_TYPE_GLOBAL	2
+
+/*
+ * Free shared memory previously allocated with OPTEE_RPC_CMD_SHM_ALLOC
+ *
+ * [in]     value[0].a	    Type of memory one of
+ *			    OPTEE_RPC_SHM_TYPE_* above
+ * [in]     value[0].b	    Value of shared memory reference or cookie
+ */
+#define OPTEE_RPC_CMD_SHM_FREE		7
+
+/* Was OPTEE_RPC_CMD_SQL_FS, which isn't supported any longer */
+#define OPTEE_RPC_CMD_SQL_FS_RESERVED	8
+
+/*
+ * Send TA profiling information to normal world
+ *
+ * [in/out] value[0].a	    File identifier. Must be set to 0 on
+ *			    first call. A value >=3D 1 will be
+ *			    returned on success. Re-use this value
+ *			    to append data to the same file.
+ * [in]     memref[1]	    TA UUID
+ * [in]     memref[2]	    Profile data
+ */
+#define OPTEE_RPC_CMD_GPROF		9
+
+/*
+ * Socket command, see definition of protocol below
+ */
+#define OPTEE_RPC_CMD_SOCKET		10
+
+/*
+ * Send TA function graph data to normal world
+ *
+ * [in/out] value[0].a	    File identifier. Must be set to 0 on
+ *			    first call. A value >=3D 1 will be
+ *			    returned on success. Re-use this value
+ *			    to append data to the same file.
+ * [in]     memref[1]	    TA UUID
+ * [in]     memref[2]	    function graph data
+ */
+#define OPTEE_RPC_CMD_FTRACE		11
+
+/*
+ * Register timestamp buffer in the linux kernel optee driver
+ *
+ * [in]     value[0].a	    Subcommand (register buffer, unregister buffer)
+ *			    OPTEE_RPC_CMD_BENCH_REG_* below
+ * [in]     value[0].b	    Physical address of timestamp buffer
+ * [in]     value[0].c	    Size of buffer
+ */
+#define OPTEE_RPC_CMD_BENCH_REG_NEW	0
+#define OPTEE_RPC_CMD_BENCH_REG_DEL	1
+#define OPTEE_RPC_CMD_BENCH_REG		20
+
+/*
+ * Definition of protocol for command OPTEE_RPC_CMD_FS
+ */
+
+/*
+ * Open a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_OPEN
+ * [in]     memref[1]	    A string holding the file name
+ * [out]    value[2].a	    File descriptor of open file
+ */
+#define OPTEE_RPC_FS_OPEN		0
+
+/*
+ * Create a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_CREATE
+ * [in]     memref[1]	    A string holding the file name
+ * [out]    value[2].a	    File descriptor of open file
+ */
+#define OPTEE_RPC_FS_CREATE		1
+
+/*
+ * Close a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_CLOSE
+ * [in]     value[0].b	    File descriptor of open file.
+ */
+#define OPTEE_RPC_FS_CLOSE		2
+
+/*
+ * Read from a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_READ
+ * [in]     value[0].b	    File descriptor of open file
+ * [in]     value[0].c	    Offset into file
+ * [out]    memref[1]	    Buffer to hold returned data
+ */
+#define OPTEE_RPC_FS_READ		3
+
+/*
+ * Write to a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_WRITE
+ * [in]     value[0].b	    File descriptor of open file
+ * [in]     value[0].c	    Offset into file
+ * [in]     memref[1]	    Buffer holding data to be written
+ */
+#define OPTEE_RPC_FS_WRITE		4
+
+/*
+ * Truncate a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_TRUNCATE
+ * [in]     value[0].b	    File descriptor of open file
+ * [in]     value[0].c	    Length of file.
+ */
+#define OPTEE_RPC_FS_TRUNCATE		5
+
+/*
+ * Remove a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_REMOVE
+ * [in]     memref[1]	    A string holding the file name
+ */
+#define OPTEE_RPC_FS_REMOVE		6
+
+/*
+ * Rename a file
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_RENAME
+ * [in]     value[0].b	    True if existing target should be removed
+ * [in]     memref[1]	    A string holding the old file name
+ * [in]     memref[2]	    A string holding the new file name
+ */
+#define OPTEE_RPC_FS_RENAME		7
+
+/*
+ * Opens a directory for file listing
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_OPENDIR
+ * [in]     memref[1]	    A string holding the name of the directory
+ * [out]    value[2].a	    Handle to open directory
+ */
+#define OPTEE_RPC_FS_OPENDIR		8
+
+/*
+ * Closes a directory handle
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_CLOSEDIR
+ * [in]     value[0].b	    Handle to open directory
+ */
+#define OPTEE_RPC_FS_CLOSEDIR		9
+
+/*
+ * Read next file name of directory
+ *
+ *
+ * [in]     value[0].a	    OPTEE_RPC_FS_READDIR
+ * [in]     value[0].b	    Handle to open directory
+ * [out]    memref[1]	    A string holding the file name
+ */
+#define OPTEE_RPC_FS_READDIR		10
+
+/* End of definition of protocol for command OPTEE_RPC_CMD_FS */
+
+/*
+ * Definition of protocol for command OPTEE_RPC_CMD_SOCKET
+ */
+
+#define OPTEE_RPC_SOCKET_TIMEOUT_NONBLOCKING	0
+#define OPTEE_RPC_SOCKET_TIMEOUT_BLOCKING	0xffffffff
+
+/*
+ * Open socket
+ *
+ * [in]     value[0].a	    OPTEE_RPC_SOCKET_OPEN
+ * [in]     value[0].b	    TA instance id
+ * [in]     value[1].a	    Server port number
+ * [in]     value[1].b	    Protocol, TEE_ISOCKET_PROTOCOLID_*
+ * [in]     value[1].c	    Ip version TEE_IP_VERSION_* from tee_ipsocket.h
+ * [in]     memref[2]	    Server address
+ * [out]    value[3].a	    Socket handle (32-bit)
+ */
+#define OPTEE_RPC_SOCKET_OPEN	0
+
+/*
+ * Close socket
+ *
+ * [in]     value[0].a	    OPTEE_RPC_SOCKET_CLOSE
+ * [in]     value[0].b	    TA instance id
+ * [in]     value[0].c	    Socket handle
+ */
+#define OPTEE_RPC_SOCKET_CLOSE	1
+
+/*
+ * Close all sockets
+ *
+ * [in]     value[0].a	    OPTEE_RPC_SOCKET_CLOSE_ALL
+ * [in]     value[0].b	    TA instance id
+ */
+#define OPTEE_RPC_SOCKET_CLOSE_ALL 2
+
+/*
+ * Send data on socket
+ *
+ * [in]     value[0].a	    OPTEE_RPC_SOCKET_SEND
+ * [in]     value[0].b	    TA instance id
+ * [in]     value[0].c	    Socket handle
+ * [in]     memref[1]	    Buffer to transmit
+ * [in]     value[2].a	    Timeout ms or OPTEE_RPC_SOCKET_TIMEOUT_*
+ * [out]    value[2].b	    Number of transmitted bytes
+ */
+#define OPTEE_RPC_SOCKET_SEND	3
+
+/*
+ * Receive data on socket
+ *
+ * [in]     value[0].a	    OPTEE_RPC_SOCKET_RECV
+ * [in]     value[0].b	    TA instance id
+ * [in]     value[0].c	    Socket handle
+ * [out]    memref[1]	    Buffer to receive
+ * [in]     value[2].a	    Timeout ms or OPTEE_RPC_SOCKET_TIMEOUT_*
+ */
+#define OPTEE_RPC_SOCKET_RECV	4
+
+/*
+ * Perform IOCTL on socket
+ *
+ * [in]     value[0].a	    OPTEE_RPC_SOCKET_IOCTL
+ * [in]     value[0].b	    TA instance id
+ * [in]     value[0].c	    Socket handle
+ * [in/out] memref[1]	    Buffer
+ * [in]     value[2].a	    Ioctl command
+ */
+#define OPTEE_RPC_SOCKET_IOCTL	5
+
+/* End of definition of protocol for command OPTEE_RPC_CMD_SOCKET */
+
+#endif /*__OPTEE_RPC_CMD_H*/
diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 1e3614e4798f..a3a1aa59f639 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -10,7 +10,9 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include "optee_msg.h"
 #include "optee_private.h"
+#include "optee_rpc_cmd.h"
 #include "optee_smc.h"
=20
 struct wq_entry {
@@ -194,10 +196,10 @@ static void handle_rpc_func_cmd_wq(struct optee *optee,
 		goto bad;
=20
 	switch (arg->params[0].u.value.a) {
-	case OPTEE_MSG_RPC_WAIT_QUEUE_SLEEP:
+	case OPTEE_RPC_WAIT_QUEUE_SLEEP:
 		wq_sleep(&optee->wait_queue, arg->params[0].u.value.b);
 		break;
-	case OPTEE_MSG_RPC_WAIT_QUEUE_WAKEUP:
+	case OPTEE_RPC_WAIT_QUEUE_WAKEUP:
 		wq_wakeup(&optee->wait_queue, arg->params[0].u.value.b);
 		break;
 	default:
@@ -267,11 +269,11 @@ static struct tee_shm *cmd_alloc_suppl(struct tee_conte=
xt *ctx, size_t sz)
 	struct tee_shm *shm;
=20
 	param.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
-	param.u.value.a =3D OPTEE_MSG_RPC_SHM_TYPE_APPL;
+	param.u.value.a =3D OPTEE_RPC_SHM_TYPE_APPL;
 	param.u.value.b =3D sz;
 	param.u.value.c =3D 0;
=20
-	ret =3D optee_supp_thrd_req(ctx, OPTEE_MSG_RPC_CMD_SHM_ALLOC, 1, &param);
+	ret =3D optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_ALLOC, 1, &param);
 	if (ret)
 		return ERR_PTR(-ENOMEM);
=20
@@ -308,10 +310,10 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_co=
ntext *ctx,
=20
 	sz =3D arg->params[0].u.value.b;
 	switch (arg->params[0].u.value.a) {
-	case OPTEE_MSG_RPC_SHM_TYPE_APPL:
+	case OPTEE_RPC_SHM_TYPE_APPL:
 		shm =3D cmd_alloc_suppl(ctx, sz);
 		break;
-	case OPTEE_MSG_RPC_SHM_TYPE_KERNEL:
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
 		shm =3D tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED);
 		break;
 	default:
@@ -383,7 +385,7 @@ static void cmd_free_suppl(struct tee_context *ctx, struc=
t tee_shm *shm)
 	struct tee_param param;
=20
 	param.attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT;
-	param.u.value.a =3D OPTEE_MSG_RPC_SHM_TYPE_APPL;
+	param.u.value.a =3D OPTEE_RPC_SHM_TYPE_APPL;
 	param.u.value.b =3D tee_shm_get_id(shm);
 	param.u.value.c =3D 0;
=20
@@ -400,7 +402,7 @@ static void cmd_free_suppl(struct tee_context *ctx, struc=
t tee_shm *shm)
 	 */
 	tee_shm_put(shm);
=20
-	optee_supp_thrd_req(ctx, OPTEE_MSG_RPC_CMD_SHM_FREE, 1, &param);
+	optee_supp_thrd_req(ctx, OPTEE_RPC_CMD_SHM_FREE, 1, &param);
 }
=20
 static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
@@ -418,10 +420,10 @@ static void handle_rpc_func_cmd_shm_free(struct tee_con=
text *ctx,
=20
 	shm =3D (struct tee_shm *)(unsigned long)arg->params[0].u.value.b;
 	switch (arg->params[0].u.value.a) {
-	case OPTEE_MSG_RPC_SHM_TYPE_APPL:
+	case OPTEE_RPC_SHM_TYPE_APPL:
 		cmd_free_suppl(ctx, shm);
 		break;
-	case OPTEE_MSG_RPC_SHM_TYPE_KERNEL:
+	case OPTEE_RPC_SHM_TYPE_KERNEL:
 		tee_shm_free(shm);
 		break;
 	default:
@@ -458,20 +460,20 @@ static void handle_rpc_func_cmd(struct tee_context *ctx=
, struct optee *optee,
 	}
=20
 	switch (arg->cmd) {
-	case OPTEE_MSG_RPC_CMD_GET_TIME:
+	case OPTEE_RPC_CMD_GET_TIME:
 		handle_rpc_func_cmd_get_time(arg);
 		break;
-	case OPTEE_MSG_RPC_CMD_WAIT_QUEUE:
+	case OPTEE_RPC_CMD_WAIT_QUEUE:
 		handle_rpc_func_cmd_wq(optee, arg);
 		break;
-	case OPTEE_MSG_RPC_CMD_SUSPEND:
+	case OPTEE_RPC_CMD_SUSPEND:
 		handle_rpc_func_cmd_wait(arg);
 		break;
-	case OPTEE_MSG_RPC_CMD_SHM_ALLOC:
+	case OPTEE_RPC_CMD_SHM_ALLOC:
 		free_pages_list(call_ctx);
 		handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
 		break;
-	case OPTEE_MSG_RPC_CMD_SHM_FREE:
+	case OPTEE_RPC_CMD_SHM_FREE:
 		handle_rpc_func_cmd_shm_free(ctx, arg);
 		break;
 	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
--=20
2.25.1


--===============6713394212361454784==--

