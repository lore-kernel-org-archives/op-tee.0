From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH] tee: optee: fix build error caused by recent optee
 tracepoints feature
Date: Thu, 25 Mar 2021 12:06:01 +0800
Message-ID: <20210325120601.71584253@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2765011193186075207=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2765011193186075207==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

If build kernel without "O=3Ddir", below error will be seen:

In file included from drivers/tee/optee/optee_trace.h:67,
                 from drivers/tee/optee/call.c:18:
./include/trace/define_trace.h:95:42: fatal error: ./optee_trace.h: No such f=
ile or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^
compilation terminated.

Fix it by adding below line to Makefile:
CFLAGS_call.o :=3D -I$(src)

Tested with and without "O=3Ddir", both can build successfully.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tee/optee/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
index 56263ae3b1d7..3aa33ea9e6a6 100644
--- a/drivers/tee/optee/Makefile
+++ b/drivers/tee/optee/Makefile
@@ -6,3 +6,6 @@ optee-objs +=3D rpc.o
 optee-objs +=3D supp.o
 optee-objs +=3D shm_pool.o
 optee-objs +=3D device.o
+
+# for tracing framework to find optee_trace.h
+CFLAGS_call.o :=3D -I$(src)
--=20
2.31.0


--===============2765011193186075207==--

