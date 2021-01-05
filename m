From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: [PATCH v2] tee: optee: replace might_sleep with cond_resched
Date: Tue, 05 Jan 2021 11:28:44 +0100
Message-ID: <20210105102843.11254-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7546829756810698590=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7546829756810698590==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

might_sleep() is a debugging aid and triggers rescheduling only for
certain kernel configurations. Replace with an explicit check and
reschedule to work for all kernel configurations. Fixes the following
trace:

  [  572.945146] rcu: INFO: rcu_sched self-detected stall on CPU
  [  572.949275] rcu:     0-....: (2099 ticks this GP) idle=3D572/1/0x4000000=
2 softirq=3D7412/7412 fqs=3D974
  [  572.957964]  (t=3D2100 jiffies g=3D10393 q=3D21)
  [  572.962054] NMI backtrace for cpu 0
  [  572.965540] CPU: 0 PID: 165 Comm: xtest Not tainted 5.8.7 #1
  [  572.971188] Hardware name: STM32 (Device Tree Support)
  [  572.976354] [<c011163c>] (unwind_backtrace) from [<c010b7f8>] (show_stac=
k+0x10/0x14)
  [  572.984080] [<c010b7f8>] (show_stack) from [<c0511e4c>] (dump_stack+0xc4=
/0xd8)
  [  572.991300] [<c0511e4c>] (dump_stack) from [<c0519abc>] (nmi_cpu_backtra=
ce+0x90/0xc4)
  [  572.999130] [<c0519abc>] (nmi_cpu_backtrace) from [<c0519bdc>] (nmi_trig=
ger_cpumask_backtrace+0xec/0x130)
  [  573.008706] [<c0519bdc>] (nmi_trigger_cpumask_backtrace) from [<c01a5184=
>] (rcu_dump_cpu_stacks+0xe8/0x110)
  [  573.018453] [<c01a5184>] (rcu_dump_cpu_stacks) from [<c01a4234>] (rcu_sc=
hed_clock_irq+0x7fc/0xa88)
  [  573.027416] [<c01a4234>] (rcu_sched_clock_irq) from [<c01acdd0>] (update=
_process_times+0x30/0x8c)
  [  573.036291] [<c01acdd0>] (update_process_times) from [<c01bfb90>] (tick_=
sched_timer+0x4c/0xa8)
  [  573.044905] [<c01bfb90>] (tick_sched_timer) from [<c01adcc8>] (__hrtimer=
_run_queues+0x174/0x358)
  [  573.053696] [<c01adcc8>] (__hrtimer_run_queues) from [<c01aea2c>] (hrtim=
er_interrupt+0x118/0x2bc)
  [  573.062573] [<c01aea2c>] (hrtimer_interrupt) from [<c09ad664>] (arch_tim=
er_handler_virt+0x28/0x30)
  [  573.071536] [<c09ad664>] (arch_timer_handler_virt) from [<c0190f50>] (ha=
ndle_percpu_devid_irq+0x8c/0x240)
  [  573.081109] [<c0190f50>] (handle_percpu_devid_irq) from [<c018ab8c>] (ge=
neric_handle_irq+0x34/0x44)
  [  573.090156] [<c018ab8c>] (generic_handle_irq) from [<c018b194>] (__handl=
e_domain_irq+0x5c/0xb0)
  [  573.098857] [<c018b194>] (__handle_domain_irq) from [<c052ac50>] (gic_ha=
ndle_irq+0x4c/0x90)
  [  573.107209] [<c052ac50>] (gic_handle_irq) from [<c0100b0c>] (__irq_svc+0=
x6c/0x90)
  [  573.114682] Exception stack(0xd90dfcf8 to 0xd90dfd40)
  [  573.119732] fce0:                                                       =
ffff0004 00000000
  [  573.127917] fd00: 00000000 00000000 00000000 00000000 00000000 00000000 =
d93493cc ffff0000
  [  573.136098] fd20: d2bc39c0 be926998 d90dfd58 d90dfd48 c09f3384 c01151f0 =
400d0013 ffffffff
  [  573.144281] [<c0100b0c>] (__irq_svc) from [<c01151f0>] (__arm_smccc_smc+=
0x10/0x20)
  [  573.151854] [<c01151f0>] (__arm_smccc_smc) from [<c09f3384>] (optee_smcc=
c_smc+0x3c/0x44)
  [  573.159948] [<c09f3384>] (optee_smccc_smc) from [<c09f4170>] (optee_do_c=
all_with_arg+0xb8/0x154)
  [  573.168735] [<c09f4170>] (optee_do_call_with_arg) from [<c09f4638>] (opt=
ee_invoke_func+0x110/0x190)
  [  573.177786] [<c09f4638>] (optee_invoke_func) from [<c09f1ebc>] (tee_ioct=
l+0x10b8/0x11c0)
  [  573.185879] [<c09f1ebc>] (tee_ioctl) from [<c029f62c>] (ksys_ioctl+0xe0/=
0xa4c)
  [  573.193101] [<c029f62c>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscal=
l+0x0/0x54)
  [  573.200750] Exception stack(0xd90dffa8 to 0xd90dfff0)
  [  573.205803] ffa0:                   be926bf4 be926a78 00000003 8010a403 =
be926908 004e3cf8
  [  573.213987] ffc0: be926bf4 be926a78 00000000 00000036 be926908 be926918 =
be9269b0 bffdf0f8
  [  573.222162] ffe0: b6d76fb0 be9268fc b6d66621 b6c7e0d8

seen on STM32 DK2 with CONFIG_PREEMPT_NONE.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
---
v2:
- Add tested-by from Sumit Garg
- Adjust commit message as agreed upon with Lucas Stach

 drivers/tee/optee/call.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index c981757ba0d4..f889bc97bed7 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -8,6 +8,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include <linux/tee_drv.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -148,7 +149,8 @@ u32 optee_do_call_with_arg(struct tee_context *ctx, phys_=
addr_t parg)
 			 */
 			optee_cq_wait_for_completion(&optee->call_queue, &w);
 		} else if (OPTEE_SMC_RETURN_IS_RPC(res.a0)) {
-			might_sleep();
+			if(need_resched())
+				cond_resched();
 			param.a0 =3D res.a0;
 			param.a1 =3D res.a1;
 			param.a2 =3D res.a2;
--=20
2.29.2


--===============7546829756810698590==--

