From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: add invoke_fn tracepoints
Date: Tue, 09 Feb 2021 19:02:15 +0800
Message-ID: <20210209190215.337b3d0f@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1751848747940578770=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1751848747940578770==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Add tracepoints to retrieve information about the invoke_fn. This would
help to measure how many invoke_fn are triggered and how long it takes
to complete one invoke_fn call.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tee/optee/call.c        |  4 ++
 drivers/tee/optee/optee_trace.h | 65 +++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 drivers/tee/optee/optee_trace.h

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 780d7c4fd756..9dbab10e7ac3 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -12,6 +12,8 @@
 #include <linux/tee_drv.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#define CREATE_TRACE_POINTS
+#include "optee_trace.h"
 #include "optee_private.h"
 #include "optee_smc.h"
=20
@@ -138,9 +140,11 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys=
_addr_t parg)
 	while (true) {
 		struct arm_smccc_res res;
=20
+		trace_optee_invoke_fn_begin(&param);
 		optee->invoke_fn(param.a0, param.a1, param.a2, param.a3,
 				 param.a4, param.a5, param.a6, param.a7,
 				 &res);
+		trace_optee_invoke_fn_end(&param, &res);
=20
 		if (res.a0 =3D=3D OPTEE_SMC_RETURN_ETHREAD_LIMIT) {
 			/*
diff --git a/drivers/tee/optee/optee_trace.h b/drivers/tee/optee/optee_trace.h
new file mode 100644
index 000000000000..f209df7004c2
--- /dev/null
+++ b/drivers/tee/optee/optee_trace.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * optee trace points
+ *
+ * Copyright (C) 2021 Synaptics Incorporated
+ * Author: Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM optee
+
+#if !defined(_TRACE_OPTEE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_OPTEE_H
+
+#include <linux/arm-smccc.h>
+#include <linux/tracepoint.h>
+#include "optee_private.h"
+
+TRACE_EVENT(optee_invoke_fn_begin,
+	TP_PROTO(struct optee_rpc_param *param),
+	TP_ARGS(param),
+
+	TP_STRUCT__entry(
+		__field(void *, param)
+		__array(u32, args, 8)
+	),
+
+	TP_fast_assign(
+		__entry->param =3D param;
+		memcpy(__entry->args, param, sizeof(__entry->args));
+	),
+
+	TP_printk("param=3D%p (%x, %x, %x, %x, %x, %x, %x, %x)", __entry->param,
+		  __entry->args[0], __entry->args[1], __entry->args[2],
+		  __entry->args[3], __entry->args[4], __entry->args[5],
+		  __entry->args[6], __entry->args[7])
+);
+
+TRACE_EVENT(optee_invoke_fn_end,
+	TP_PROTO(struct optee_rpc_param *param, struct arm_smccc_res *res),
+	TP_ARGS(param, res),
+
+	TP_STRUCT__entry(
+		__field(void *, param)
+		__array(unsigned long, rets, 4)
+	),
+
+	TP_fast_assign(
+		__entry->param =3D param;
+		memcpy(__entry->rets, res, sizeof(__entry->rets));
+	),
+
+	TP_printk("param=3D%p ret (%lx, %lx, %lx, %lx)", __entry->param,
+		  __entry->rets[0], __entry->rets[1], __entry->rets[2],
+		  __entry->rets[3])
+);
+#endif /* _TRACE_OPTEE_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE optee_trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--=20
2.30.0


--===============1751848747940578770==--

