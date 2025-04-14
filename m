From: Stauffer Thomas MTANA <Thomas.Stauffer@mt.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Kernel crash when interrupting user space application accessing PKCS11 TA
Date: Mon, 14 Apr 2025 11:38:01 +0000
Message-ID: <GVXPR03MB10460DBDD8B3203B8EFC809748AB32@GVXPR03MB10460.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6062255538836009953=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6062255538836009953==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Platform: Toradex Verdin iMX8MP
OP-TEE OS & Client: 4.5
Linux Kernel: Mainline 6.6.80
OP-TEE OS Build Options: OPTEE_OS_OPTIONS=3DARCH=3Darm PLATFORM=3Dimx PLATFOR=
M_FLAVOR=3Dmx8mpevk CFG_CRYPTO_DRIVER=3Dy CFG_NXP_CAAM=3Dy CFG_NXP_CAAM_RNG_D=
RV=3Dy CFG_RPMB_FS_DEV_ID=3D2 CFG_REE_FS=3Dy CFG_RPMB_FS=3Dn CFG_RPMB_TESTKEY=
=3Dn CFG_RPMB_WRITE_KEY=3Dn CFG_REE_FS_TA=3Dn CFG_SECSTOR_TA=3Dn CFG_TEE_CORE=
_LOG_LEVEL=3D4 CFG_TEE_TA_LOG_LEVEL=3D4 CFG_CORE_DUMP_OOM=3Dy CFG_UART_BASE=
=3D0x30880000 CFG_DDR_SIZE=3D0x100000000 CFG_TZDRAM_START=3D0x56000000 CFG_TZ=
DRAM_SIZE=3D0x01c00000 CFG_SHMEM_SIZE=3D0x00400000 CFG_EARLY_TA=3Dy
OPTEE_OS_OPTIONS_EARLYTA=3DEARLY_TA_PATHS=3D"$(PWD)/optee_os/out/arm-plat-imx=
/ta/pkcs11/fd02c9da-306c-48c7-a49c-bbd827ae86ee.stripped.elf"

I've quite a few cases where the Linux kernel crashes. One case is the follow=
ing example

export MODULE=3Dlibckteec.so.0
while true ; do pkcs11-tool --module $MODULE --init-token --label "$TOKEN" --=
so-pin "$SOPIN" ; pkcs11-tool --module $MODULE --init-pin --so-pin "$SOPIN" -=
-pin "$PIN" ; done

Normally this runs fine. I tested this up to 40 hours without any issue.

The moment I press Ctrl+C the linux kernel often crashes (ca. 20% chance). Th=
is can be reproduced easily (in less than 1 minute).

It looks like always syscall_storage_obj_open is part of the execution path, =
often followed by a panic (which I assume is ok, if the underlining process d=
ies)

I believe the OPTEE RAM and SHM are correctly passed to the kernel

[    0.000000] OF: reserved mem: 0x0000000056000000..0x0000000057bfffff (2867=
2 KiB) nomap non-reusable optee_core(a)56000000
[    0.000000] OF: reserved mem: 0x0000000057c00000..0x0000000057ffffff (4096=
 KiB) nomap non-reusable optee_shm(a)57c00000

The kernel/OP-TEE logs are added below.

Is this an issue anyone knows?


I/TA: PKCS11 session 1: login
D/TA:  TA_InvokeCommandEntryPoint:364 PKCS11_CMD_LOGIN rc 0/OK
D/TA:  TA_InvokeCommandEntryPoint:143 PKCS11_CMD_TOKEN_INFO p#0 4(a)0x8001800=
0, p#1 --- 0(a)0x0, p#2 out 160(a)0x80017000
D/TA:  TA_InvokeCommandEntryPoint:364 PKCS11_CMD_TOKEN_INFO rc 0/OK
D/TA:  TA_InvokeCommandEntryPoint:143 PKCS11_CMD_INIT_PIN p#0 38(a)0x80017000=
, p#1 --- 0(a)0x0, p#2 --- 0(a)0x0
I/TA: PKCS11 session 1: init PIN
F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_number_generate)
F/TC:? 0 trace_syscall:147 syscall #15 (syscall_cryp_state_alloc)
F/TC:? 0 trace_syscall:147 syscall #18 (syscall_hash_init)
F/TC:? 0 trace_syscall:147 syscall #19 (syscall_hash_update)
F/TC:? 0 trace_syscall:147 syscall #19 (syscall_hash_update)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #20 (syscall_hash_final)
F/TC:? 0 trace_syscall:147 syscall #18 (syscall_hash_init)
F/TC:? 0 trace_syscall:147 syscall #17 (syscall_cryp_state_free)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
E/TC:? 0 get_rpc_alloc_res:644 RPC allocation failed. Non-secure world result=
: ret=3D0xffff000c ret_origin=3D0x2
E/TA:  update_persistent_db:61 Failed to open token persistent db: 0xffff000c
F/TC:? 0 trace_syscall:147 syscall #2 (syscall_panic)
[  401.775062] Unable to handle kernel paging request at virtual address 0000=
000000001000
[  401.775077] Mem abort info:
[  401.775079]   ESR =3D 0x0000000096000044
[  401.775081]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  401.775085]   SET =3D 0, FnV =3D 0
[  401.775087]   EA =3D 0, S1PTW =3D 0
[  401.775089]   FSC =3D 0x04: level 0 translation fault
[  401.775092] Data abort info:
[  401.775094]   ISV =3D 0, ISS =3D 0x00000044, ISS2 =3D 0x00000000
[  401.775096]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[  401.775100]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  401.775103] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000139bfb000
[  401.775107] [0000000000001000] pgd=3D0000000000000000, p4d=3D0000000000000=
000
[  401.775115] Internal error: Oops: 0000000096000044 [#1] PREEMPT_RT SMP
[  401.775121] CPU: 0 PID: 1197 Comm: pkcs11-tool Not tainted 6.6.80-rt51 #23
[  401.775128] Hardware name: Toradex Verdin iMX8M Plus
[  401.775131] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
[  401.775136] pc : __arm_smccc_smc+0xc/0x30
[  401.775148] lr : optee_smccc_smc+0x20/0x34
[  401.775156] sp : ffff80008367bad0
[  401.775158] x29: ffff80008367bae0 x28: 0000000000000000 x27: 0000000000000=
000
[  401.775168] x26: ffff0000c14fa528 x25: 0000000032000003 x24: 0000000000000=
000
[  401.775177] x23: ffff0000c8331b40 x22: ffff80008367bba8 x21: 0000000000000=
000
[  401.775185] x20: ffff0000c14fa400 x19: 0000000000000000 x18: ffff800081dc1=
050
[  401.775192] x17: 0000000000000000 x16: 0000000000000000 x15: 0000ffffd1b39=
d28
[  401.775201] x14: 0000000000000259 x13: 0000000000000001 x12: 0000000000000=
002
[  401.775210] x11: 0000000000000001 x10: 0000000000000b60 x9 : ffff80008367b=
8b0
[  401.775217] x8 : ffff80008367bba8 x7 : 0000000000000000 x6 : 0000000000000=
000
[  401.775224] x5 : 0000000000000000 x4 : 0000000000001000 x3 : 0000000000000=
000
[  401.775233] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000ffff0=
004
[  401.775243] Call trace:
[  401.775245]  __arm_smccc_smc+0xc/0x30
[  401.775252]  optee_smc_do_call_with_arg+0x178/0x634
[  401.775258]  optee_invoke_func+0x124/0x1dc
[  401.775266]  tee_ioctl+0xf14/0x11d0
[  401.775271]  __arm64_sys_ioctl+0xc8/0xe8
[  401.775277]  invoke_syscall+0x4c/0x124
[  401.775283]  el0_svc_common.constprop.0+0x44/0xec
[  401.775290]  do_el0_svc+0x20/0x30
[  401.775298]  el0_svc+0x3c/0xd8
[  401.775305]  el0t_64_sync_handler+0x108/0x134
[  401.775311]  el0t_64_sync+0x198/0x19c
[  401.775319] Code: d53cd043 d503245f d4000003 f94003e4 (a9000480)
[  401.775324] ---[ end trace 0000000000000000 ]---
[  401.775328] Kernel panic - not syncing: Oops: Fatal exception
[  401.775331] SMP: stopping secondary CPUs
[  401.775338] Kernel Offset: disabled
[  401.775340] CPU features: 0x0,00000008,00020000,1000420b
[  401.775344] Memory Limit: none

F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 read_compressed:178 156 bytes
F/TC:? 0 read_compressed:178 1024 bytes
F/TC:? 0 read_compressed:178 128 bytes
F/TC:? 0 trace_syscall:147 syscall #6 (syscall_close_ta_session)
F/TC:? 0 trace_syscall:147 syscall #3 (syscall_get_property)
D/LD:  ldelf:176 ELF (fd02c9da-306c-48c7-a49c-bbd827ae86ee) at 0x8002a000
F/TC:? 0 trace_syscall:147 syscall #33 (syscall_cryp_random_number_generate)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #4 (syscall_get_property_name_to_index)
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
F/TC:? 0 plat_prng_add_jitter_entropy:68 0xC6
F/TC:? 0 trace_syscall:147 syscall #2 (syscall_panic)
E/TC:? 0
E/TC:? 0 TA panicked with code 0xffff000e
E/LD:  Status of TA fd02c9da-306c-48c7-a49c-bbd827ae86ee
E/LD:   arch: aarch64
E/LD:  region  0: va 0x80005000 pa 0x56112000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x80007000 pa 0x56114000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x8000f000 pa 0x5611c000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x80010000 pa 0x5611d000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0x80014000 pa 0x56121000 size 0x001000 flags r--s
E/LD:  region  5: va 0x80015000 pa 0x5619a000 size 0x002000 flags rw-s (stack)
E/LD:  region  6: va 0x8002a000 pa 0x56122000 size 0x063000 flags r-xs [0]
E/LD:  region  7: va 0x8008d000 pa 0x56185000 size 0x015000 flags rw-s [0]
E/LD:   [0] fd02c9da-306c-48c7-a49c-bbd827ae86ee @ 0x8002a000
E/LD:  Call stack:
E/LD:   0x800426e8
E/LD:   0x8002d1f0
E/LD:   0x8002e104
E/LD:   0x800332d8
E/LD:   0x80049264
E/LD:   0x8003e9ec
D/TC:? 0 user_ta_enter:195 tee_user_ta_enter: TA panicked with code 0xffff000e
D/TC:? 0 release_ta_ctx:670 Releasing panicked TA ctx
D/TC:? 0 tee_ta_close_session:460 csess 0x560f2120 id 1
D/TC:? 0 tee_ta_close_session:479 Destroy session
D/TC:? 0 destroy_context:318 Destroy TA ctx (0x560f20c0)
E/TC:? 0 tee_ta_open_session:745 Failed for TA fd02c9da-306c-48c7-a49c-bbd827=
ae86ee. Return error 0xffff3024
[  201.922583] Unable to handle kernel paging request at virtual address ffff=
8000812803f0
[  201.922600] Mem abort info:
[  201.922602]   ESR =3D 0x0000000096000047
[  201.922604]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  201.922608]   SET =3D 0, FnV =3D 0
[  201.922611]   EA =3D 0, S1PTW =3D 0
[  201.922613]   FSC =3D 0x07: level 3 translation fault
[  201.922616] Data abort info:
[  201.922618]   ISV =3D 0, ISS =3D 0x00000047, ISS2 =3D 0x00000000
[  201.922621]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
[  201.922624]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  201.922627] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000411ca000
[  201.922631] [ffff8000812803f0] pgd=3D100000013ffff003, p4d=3D100000013ffff=
003, pud=3D100000013fffe003, pmd=3D100000013fffa003, pte=3D0000000000000000
[  201.922646] Internal error: Oops: 0000000096000047 [#1] PREEMPT_RT SMP
[  201.922652] CPU: 0 PID: 1059 Comm: pkcs11-tool Not tainted 6.6.80-rt51 #23
[  201.922658] Hardware name: Toradex Verdin iMX8M Plus
[  201.922661] pstate: a00000c5 (NzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
[  201.922667] pc : queued_spin_lock_slowpath+0x22c/0x330
[  201.922680] lr : _raw_spin_lock_irqsave+0x80/0x98
[  201.922686] sp : ffff80008362b960
[  201.922688] x29: ffff80008362b960 x28: ffff0000029a8000 x27: 0000000000000=
000
[  201.922696] x26: ffff0000c0d9e128 x25: 0000000000000000 x24: 0000000000000=
000
[  201.922703] x23: ffff000008a48f00 x22: 00000000ffff000e x21: ffff0000c0d9e=
198
[  201.922710] x20: ffff0000c237c3f8 x19: 0000000000000000 x18: ffff8000829cf=
088
[  201.922720] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000=
040
[  201.922727] x14: 0000000000000004 x13: ffff0000c0d9e1d8 x12: 0000000000000=
000
[  201.922734] x11: ffff0000cb440b98 x10: ffff0000cb440b68 x9 : ffff800081447=
558
[  201.922741] x8 : 0000000000000000 x7 : ffff8000812803f0 x6 : 0000000000000=
000
[  201.922751] x5 : ffff0000ff76b3c0 x4 : 0000000000040000 x3 : ffff0000ff76b=
3c0
[  201.922758] x2 : ffff8000812803c0 x1 : ffff0000ff76b3c8 x0 : ffff0000c237c=
3f8
[  201.922766] Call trace:
[  201.922768]  queued_spin_lock_slowpath+0x22c/0x330
[  201.922775]  complete+0x28/0x9c
[  201.922783]  optee_supp_release+0x5c/0x12c
[  201.922790]  optee_release_supp+0x44/0x58
[  201.922795]  teedev_ctx_put.part.0+0x90/0xc8
[  201.922800]  teedev_ctx_put+0x20/0x30
[  201.922805]  tee_shm_put+0x110/0x188

D/TA:  TA_InvokeCommandEntryPoint:364 PKCS11_CMD_SLOT_INFO rc 0/OK
D/TA:  TA_InvokeCommandEntryPoint:143 PKCS11_CMD_OPEN_SESSION p#0 8(a)0x80018=
000, p#1 --- 0(a)0x0, p#2 out 4(a)0x80017000
D/TA:  entry_ck_open_session:681 Open PKCS11 session 1
D/TA:  TA_InvokeCommandEntryPoint:364 PKCS11_CMD_OPEN_SESSION rc 0/OK
D/TA:  TA_InvokeCommandEntryPoint:143 PKCS11_CMD_TOKEN_INFO p#0 4(a)0x8001800=
0, p#1 --- 0(a)0x0, p#2 out 160(a)0x80017000
D/TA:  TA_InvokeCommandEntryPoint:364 PKCS11_CMD_TOKEN_INFO rc 0/OK
D/TA:  TA_InvokeCommandEntryPoint:143 PKCS11_CMD_LOGIN p#0 42(a)0x80017000, p=
#1 --- 0(a)0x0, p#2 --- 0(a)0x0
F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
[   72.460688] Unable to handle kernel paging request at virtual address ffff=
0000c5270459
[   72.460703] Mem abort info:
[   72.460705]   ESR =3D 0x0000000096000021
[   72.460707]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   72.460711]   SET =3D 0, FnV =3D 0
[   72.460714]   EA =3D 0, S1PTW =3D 0
[   72.460716]   FSC =3D 0x21: alignment fault
[   72.460719] Data abort info:
[   72.460720]   ISV =3D 0, ISS =3D 0x00000021, ISS2 =3D 0x00000000
[   72.460723]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   72.460726]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   72.460729] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000411ca000
[   72.460734] [ffff0000c5270459] pgd=3D180000013fff8003, p4d=3D180000013fff8=
003, pud=3D180000013fa1b003, pmd=3D180000013f9f1003, pte=3D0068000105270707
[   72.460748] Internal error: Oops: 0000000096000021 [#1] PREEMPT_RT SMP
[   72.460755] CPU: 0 PID: 836 Comm: tee-supplicant Not tainted 6.6.80-rt51 #=
23
[   72.460760] Hardware name: Toradex Verdin iMX8M Plus
[   72.460763] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
[   72.460769] pc : tee_shm_get_fd+0x84/0xd8
[   72.460780] lr : tee_ioctl+0xb14/0x11d0
[   72.460785] sp : ffff800082fe3c50
[   72.460787] x29: ffff800082fe3c50 x28: ffff000001ba4ec0 x27: 0000000000000=
000
[   72.460795] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000=
000
[   72.460802] x23: 0000ffffc685f9a8 x22: 00000000c018a409 x21: 0000ffffc685f=
9a8
[   72.460812] x20: ffff0000c5270421 x19: ffff0000c5270421 x18: ffff8000820fd=
040
[   72.460819] x17: 0000000000000000 x16: ffff800080f92850 x15: ffff800082fe3=
d40
[   72.460827] x14: 0000000000000000 x13: 1fffe000186fa581 x12: ffff800082fe3=
b78
[   72.460834] x11: 0000000000000040 x10: ffff0000c1600420 x9 : ffff0000c1600=
3f8
[   72.460843] x8 : 0000000000001000 x7 : 0000aaab1a59c000 x6 : 0000ffffc685f=
9c0
[   72.460850] x5 : 0000ffffc685f9c0 x4 : ffff0000c5270459 x3 : 0000000100000=
000
[   72.460857] x2 : 0000000000000018 x1 : ffff800082fe3d58 x0 : ffff0000c5270=
459
[   72.460867] Call trace:
[   72.460870]  tee_shm_get_fd+0x84/0xd8
[   72.460878]  tee_ioctl+0xb14/0x11d0
[   72.460882]  __arm64_sys_ioctl+0xc8/0xe8
[   72.460889]  invoke_syscall+0x4c/0x124
[   72.460897]  el0_svc_common.constprop.0+0xcc/0xec
[   72.460905]  do_el0_svc+0x20/0x30
[   72.460911]  el0_svc+0x3c/0xd8
[   72.460918]  el0t_64_sync_handler+0x108/0x134
[   72.460924]  el0t_64_sync+0x198/0x19c
[   72.460935] Code: d50323bf d65f03c0 9100e264 f9800091 (885f7c81)

F/TC:? 0 trace_syscall:147 syscall #8 (syscall_check_access_rights)
F/TC:? 0 trace_syscall:147 syscall #41 (syscall_storage_obj_open)
F/TC:? 0 plat_prng_add_jitter_entropy:68 0xDB
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x49
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x68
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x14
F/TC:? 0 plat_prng_add_jitter_entropy:68 0xF0
F/TC:? 0 trace_syscall:147 syscall #51 (syscall_storage_obj_write)
F/TC:? 0 plat_prng_add_jitter_entropy:68 0xE2
F/TC:? 0 plat_prng_add_jitter_entropy:68 0x54
F/TC:? 0 trace_syscall:147 syscall #2 (syscall_panic)
E/TC:? 0
E/TC:? 0 TA panicked with code 0xffff000e
E/LD:  Status of TA fd02c9da-306c-48c7-a49c-bbd827ae86ee
E/LD:   arch: aarch64
E/LD:  region  0: va 0x80005000 pa 0x56112000 size 0x002000 flags rw-s (ldelf)
E/LD:  region  1: va 0x80007000 pa 0x56114000 size 0x008000 flags r-xs (ldelf)
E/LD:  region  2: va 0x8000f000 pa 0x5611c000 size 0x001000 flags rw-s (ldelf)
E/LD:  region  3: va 0x80010000 pa 0x5611d000 size 0x004000 flags rw-s (ldelf)
E/LD:  region  4: va 0x80014000 pa 0x56121000 size 0x001000 flags r--s
E/LD:  region  5: va 0x80015000 pa 0x5619a000 size 0x002000 flags rw-s (stack)
E/LD:  region  6: va 0x80017000 pa 0x541a2000 size 0x001000 flags rw-- (param)
E/LD:  region  7: va 0x8001c000 pa 0x56122000 size 0x063000 flags r-xs [0]
E/LD:  region  8: va 0x8007f000 pa 0x56185000 size 0x015000 flags rw-s [0]
E/LD:   [0] fd02c9da-306c-48c7-a49c-bbd827ae86ee @ 0x8001c000
E/LD:  Call stack:
E/LD:   0x80034ef4
E/LD:   0x8001f28c
E/LD:   0x80024eb0
E/LD:   0x8002694c
E/LD:   0x8001d27c
E/LD:   0x8003b3b4
E/LD:   0x800309ec
D/TC:? 0 user_ta_enter:195 tee_user_ta_enter: TA panicked with code 0xffff000e
D/TC:? 0 release_ta_ctx:670 Releasing panicked TA ctx
D/TC:? 0 tee_ta_invoke_command:798 Error: ffff3024 of 3
D/TC:? 0 tee_ta_close_session:460 csess 0x560f1150 id 1
D/TC:? 0 tee_ta_close_session:479 Destroy session
[  263.892611] Unable to handle kernel paging request at virtual address 50ff=
ff0000c4079d
[  263.892623] Mem abort info:
[  263.892624]   ESR =3D 0x0000000096000004
[  263.892627]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  263.892631]   SET =3D 0, FnV =3D 0
[  263.892633]   EA =3D 0, S1PTW =3D 0
[  263.892635]   FSC =3D 0x04: level 0 translation fault
[  263.892638] Data abort info:
[  263.892640]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[  263.892642]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  263.892645]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  263.892649] [50ffff0000c4079d] address between user and kernel address ran=
ges
[  263.892653] Internal error: Oops: 0000000096000004 [#1] PREEMPT_RT SMP
[  263.892659] CPU: 0 PID: 1 Comm: systemd Not tainted 6.6.80-rt51 #23
[  263.892664] Hardware name: Toradex Verdin iMX8M Plus
[  263.892667] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
[  263.892673] pc : ___slab_alloc+0x408/0x958
[  263.892685] lr : ___slab_alloc+0x90/0x958
[  263.892696] sp : ffff80008160b940
[  263.892698] x29: ffff80008160b940 x28: 0000000000000000 x27: ffff8000811b5=
838
[  263.892708] x26: 0000000000000000 x25: ffff8000802f7624 x24: fffffc0003101=
d80
[  263.892715] x23: 50ffff0000c4076d x22: ffff0000c0001600 x21: 0000000000000=
060
[  263.892722] x20: 00000000ffffffff x19: ffff0000ff76bcc0 x18: ffff8000815f5=
078
[  263.892732] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000=
000
[  263.892739] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000=
000
[  263.892745] x11: 0000000000000000 x10: fffffffffdab3428 x9 : 0000000000000=
000
[  263.892752] x8 : ffff0000c1fbbb40 x7 : 0000000000000000 x6 : ffff0000c00b0=
000
[  263.892764] x5 : 0000000000000060 x4 : ffff0000ff76bcf8 x3 : 0000000000000=
000
[  263.892771] x2 : 0000000000000000 x1 : 0000000000000030 x0 : 000000000042d=
800
[  263.892778] Call trace:
[  263.892781]  ___slab_alloc+0x408/0x958
[  263.892787]  __kmem_cache_alloc_node+0xd4/0x1fc
[  263.892795]  kmalloc_trace+0x24/0x34
[  263.892802]  kernfs_fop_open+0x2f0/0x390
[  263.892808]  do_dentry_open+0x16c/0x50c
[  263.892814]  vfs_open+0x30/0x40
[  263.892822]  path_openat+0xb2c/0xee0
[  263.892829]  do_filp_open+0xa4/0x15c
[  263.892836]  do_sys_openat2+0xc8/0xfc
[  263.892841]  __arm64_sys_openat+0x68/0xac
[  263.892847]  invoke_syscall+0x4c/0x124
[  263.892854]  el0_svc_common.constprop.0+0x44/0xec
[  263.892862]  do_el0_svc+0x20/0x30
[  263.892868]  el0_svc+0x3c/0xd8
[  263.892875]  el0t_64_sync_handler+0x108/0x134
[  263.892881]  el0t_64_sync+0x198/0x19c
[  263.892890] Code: f9000a60 a94573fb b9402ac1 f9400660 (f8616ae1)
[  263.892894] ---[ end trace 0000000000000000 ]---
[  263.892899] Kernel panic - not syncing: Oops: Fatal exception
[  263.892902] SMP: stopping secondary CPUs
[  263.896937] Kernel Offset: disabled
[  263.896939] CPU features: 0x0,00000008,00020000,1000420b
[  263.896944] Memory Limit: none

Without OP-TEE Debug Output

[  917.500140] Unable to handle kernel paging request at virtual address 0000=
0000fffffff7
[  917.500159] Mem abort info:
[  917.500161]   ESR =3D 0x0000000096000004
[  917.500164]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  917.500169]   SET =3D 0, FnV =3D 0
[  917.500173]   EA =3D 0, S1PTW =3D 0
[  917.500176]   FSC =3D 0x04: level 0 translation fault
[  917.500180] Data abort info:
[  917.500181]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[  917.500185]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  917.500189]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  917.500194] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000046120000
[  917.500199] [00000000fffffff7] pgd=3D0000000000000000, p4d=3D0000000000000=
000
[  917.500210] Internal error: Oops: 0000000096000004 [#1] PREEMPT_RT SMP
[  917.500218] CPU: 1 PID: 962 Comm: tee-supplicant Not tainted 6.6.80-rt51 #=
22
[  917.500225] Hardware name: Toradex Verdin iMX8M Plus
[  917.500229] pstate: 000000c5 (nzcv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
[  917.500236] pc : complete+0x5c/0x9c
[  917.500252] lr : complete+0x28/0x9c
[  917.500261] sp : ffff8000833e3bb0
[  917.500264] x29: ffff8000833e3bb0 x28: ffff000002855e80 x27: 0000000000000=
000
[  917.500274] x26: 0000000000000000 x25: 0000000000000000 x24: ffff000002856=
480
[  917.500284] x23: ffff0000c007aca0 x22: 00000000ffff000e x21: 0000000000000=
000
[  917.500293] x20: ffff0000c393a8d8 x19: 00000000ffffffff x18: ffff8000826f9=
090
[  917.500303] x17: 0000000000000100 x16: ffff800080f92850 x15: 0000000000000=
040
[  917.500313] x14: 0000000000000004 x13: ffff0000c0d625d8 x12: 0000000000000=
000
[  917.500322] x11: ffff000001d51700 x10: ffff000001d516d0 x9 : ffff0000c0d62=
5d8
[  917.500332] x8 : ffff000001d516f8 x7 : 0000000000000000 x6 : 0000000000000=
228
[  917.500341] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000=
001
[  917.500350] x2 : 0000000000000000 x1 : 0000000000000003 x0 : ffff0000c393a=
8e0
[  917.500362] Call trace:
[  917.500365]  complete+0x5c/0x9c
[  917.500373]  optee_supp_release+0x5c/0x12c
[  917.500383]  optee_release_supp+0x44/0x58
[  917.500390]  teedev_ctx_put.part.0+0x90/0xc8
[  917.500397]  teedev_ctx_put+0x20/0x30
[  917.500403]  tee_shm_put+0x110/0x188
[  917.500409]  tee_shm_fop_release+0x18/0x2c
[  917.500416]  __fput+0xc0/0x26c
[  917.500425]  ____fput+0x14/0x24
[  917.500433]  task_work_run+0x7c/0xdc
[  917.500440]  do_exit+0x2d8/0x8d8
[  917.500447]  do_group_exit+0x38/0x94
[  917.500455]  __wake_up_parent+0x0/0x38
[  917.500462]  invoke_syscall+0x4c/0x124
[  917.500471]  el0_svc_common.constprop.0+0x44/0xec

[  160.985670] Unable to handle kernel paging request at virtual address ffff=
0000c4a18039
[  160.985686] Mem abort info:
[  160.985688]   ESR =3D 0x0000000096000021
[  160.985690]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  160.985694]   SET =3D 0, FnV =3D 0
[  160.985696]   EA =3D 0, S1PTW =3D 0
[  160.985699]   FSC =3D 0x21: alignment fault
[  160.985701] Data abort info:
[  160.985703]   ISV =3D 0, ISS =3D 0x00000021, ISS2 =3D 0x00000000
[  160.985705]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[  160.985709]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[  160.985712] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000411ca000
[  160.985716] [ffff0000c4a18039] pgd=3D180000013fff8003, p4d=3D180000013fff8=
003, pud=3D180000013fa1b003, pmd=3D180000013f9f5003, pte=3D0068000104a18707
[  160.985730] Internal error: Oops: 0000000096000021 [#1] PREEMPT_RT SMP
[  160.985736] CPU: 1 PID: 2894 Comm: pkcs11-tool Not tainted 6.6.80-rt51 #22
[  160.985742] Hardware name: Toradex Verdin iMX8M Plus
[  160.985746] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D=
--)
[  160.985751] pc : tee_shm_put+0x144/0x188
[  160.985762] lr : tee_shm_put+0x34/0x188
[  160.985767] sp : ffff800083e63b30
[  160.985769] x29: ffff800083e63b30 x28: ffff0000145fb000 x27: ffff0000c4a18=
001
[  160.985777] x26: ffff0000c7455f58 x25: ffff0000145d0000 x24: ffff0000c09c4=
400
[  160.985786] x23: ffff0000c4a185a0 x22: ffff0000c0836800 x21: ffff0000c0836=
bd8
[  160.985794] x20: ffff0000c4a18039 x19: ffff0000c4a18001 x18: ffff8000837a5=
060
[  160.985801] x17: 0000000000000100 x16: ffff800080f92850 x15: 0000000000000=
000
[  160.985808] x14: 0000000000000000 x13: 0000000000000001 x12: 00000000000a1=
22e
[  160.985817] x11: ffff8000811b5000 x10: 00007fffffffffff x9 : 0001000000000=
000
[  160.985825] x8 : ffff800083e63b18 x7 : 0000000000000000 x6 : 0000000000000=
000
[  160.985832] x5 : ffff0000c09c4540 x4 : ffff0000c4a18039 x3 : 0000000000000=
000
[  160.985839] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000000000=
000
[  160.985849] Call trace:
[  160.985851]  tee_shm_put+0x144/0x188
[  160.985856]  tee_shm_free+0x14/0x24
[  160.985861]  optee_shm_register+0x1a4/0x1dc
[  160.985868]  register_shm_helper+0x1cc/0x29c
[  160.985874]  tee_shm_register_user_buf+0xb0/0x14c
[  160.985881]  tee_ioctl+0xc4/0x11d0
[  160.985886]  __arm64_sys_ioctl+0xc8/0xe8
[  160.985892]  invoke_syscall+0x4c/0x124
[  160.985899]  el0_svc_common.constprop.0+0x44/0xec
[  160.985906]  do_el0_svc+0x20/0x30
[  160.985913]  el0_svc+0x3c/0xd8
[  160.985921]  el0t_64_sync_handler+0x108/0x134
[  160.985927]  el0t_64_sync+0x198/0x19c
[  160.985935] Code: d65f03c0 9100e264 52800021 f9800091 (885f7c80)
[  160.985942] ---[ end trace 0000000000000000 ]---
[  160.985945] Kernel panic - not syncing: Oops: Fatal exception
[  160.985949] SMP: stopping secondary CPUs
[  160.985957] Kernel Offset: disabled
[  160.985959] CPU features: 0x0,00000008,00020000,1000420b
[  160.985963] Memory Limit: none


--===============6062255538836009953==--

