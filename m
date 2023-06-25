From: 高海源(码源) <haiyuan.ghy@alibaba-inc.com>
To: op-tee@lists.trustedfirmware.org
Subject: optee_benchmark found optee_os function vm_set_ctx() spent much time
Date: Sun, 25 Jun 2023 12:46:40 +0800
Message-ID: <340d3dce-a2c5-4c0d-8e95-3e56d8b6eb16.haiyuan.ghy@alibaba-inc.com>
In-Reply-To: <
 <5471e77a-a3ce-44f2-b24b-9627507e37e8.haiyuan.ghy@alibaba-inc.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5497724619491630165=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5497724619491630165==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, experts:
 I am doing optee benchmark and performance optimization.
 I use optee_os/optee_client/optee_examples/optee_benchmark version 3.20.0
 I think the host API TEEC_InvokeCommand() is sensitive of delay, namely TEE =
framework like OpenEnclave called ECALL.
 So I remove all prints in hello_world_ta.c 's TA_InvokeCommandEntryPoint(), =
host test TEEC_InvokeCommand() 10k times to calculate average time cost.
 I tested on an ArmV9 data-center server, and I got average time is about 20 =
us.
 After using optee_benchmark tool, we found optee_os function user_ta_enter()=
 took most of time.
 Specially, user_ta_enter() calls ts_push_current_session() and ts_pop_curren=
t_session(), then calls vm_set_ctx() twice, which spend 7 us and 2 us respect=
ively, mostly of 20 us delay.
 I added logs to print some pointers, following is 'git diff' in update_curre=
nt_ctx()
diff --git a/core/kernel/ts_manager.c b/core/kernel/ts_manager.c
index b2794634..9a221138 100644
--- a/core/kernel/ts_manager.c
+++ b/core/kernel/ts_manager.c
@@ -26,6 +26,7 @@ static void update_current_ctx(struct thread_specific_data =
*tsd)
 ctx =3D s->ctx;
 }
+ EMSG("session %p tsd %p tsd->ctx %p ctx %p", s, tsd, tsd->ctx, ctx);
 if (tsd->ctx !=3D ctx)
 vm_set_ctx(ctx);
 /*
I found that many InvokeCommand repeat following pattern
E/TC:??? 000 user_ta_enter:155 =3D=3D=3D=3D=3D=3D session 0x8940b5d80 func 2 =
cmd 4, call ts_push_current_session
E/TC:??? 000 update_current_ctx:29 session 0x8940b5d80 tsd 0x89008dd38 tsd->c=
tx 0x0 ctx 0x8940b5d28
E/TC:??? 000 user_ta_enter:199 =3D=3D=3D=3D=3D=3D session 0x8940b5d80 func 2 =
cmd 4, call ts_pop_current_session
E/TC:??? 000 update_current_ctx:29 session 0x0 tsd 0x89008dd38 tsd->ctx 0x894=
0b5d28 ctx 0x0
I noticed many InvokeCommand use the same ctx pointer like 0x8940b5d28
My question is:=20
 Can many InvokeCommand avoid setting tsd->ctx to Non-NULL ctx, then setting =
tsd->ctx to NULL ctx, to remove the vm_set_ctx() cost of time ?
 Is there any optimization method, likely many InvokeCommand in the same sess=
ion reuse the same Non-NULL ctx, to reduce average delay of 10k times InvokeC=
ommand ?
Thanks.

--===============5497724619491630165==--

