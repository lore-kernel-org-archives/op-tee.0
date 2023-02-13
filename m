From: Olivier Deprez <Olivier.Deprez@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Dynamic Shared Memory
Date: Mon, 13 Feb 2023 12:07:04 +0000
Message-ID: <VE1PR08MB4976DA117F7DEED9876B320A9BDD9@VE1PR08MB4976.eurprd08.prod.outlook.com>
In-Reply-To: <Y+obQMuOoo67vU4U@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8932302647867339024=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8932302647867339024==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Yes, noticed the same as Jens with the qemu setup where this optee example te=
st passes.

Can you share the commit hashes used for Hafnium/OP-TEE?
Is Hafnium running from high addresses (e.g. >34G like you mentioned before)?
Is it possible to share the Hafnium boot log (or an extract of it)?
What is the start address and size of the OP-TEE secure partition declared in=
 the SPMC manifest?
Is this page @ 0x8a8474000 reported in the S2 PF, located in a region marked =
non secure in the TZC400?

Aso I'm surprised by the log
E/LD: region 6: va 0x40020000 pa 0x8a1262340 size 0x002000 flags rw-- (param)
E/LD: region 7: va 0x40022000 pa 0x8a84749f0 size 0x001000 flags rw-- (param)
All other regions report 4K aligned PA but those ones (that may be ok, but I'=
m not versed enough into OP-TEE code base to say).

Regards,
Olivier.



________________________________
From: Jens Wiklander <jens.wiklander@linaro.org>
Sent: 13 February 2023 12:13
To: =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=B9=E5=A4=9C) <meijianqiang.mjq@aliba=
ba-inc.com>
Cc: hafnium <hafnium@lists.trustedfirmware.org>; Olivier Deprez <Olivier.De=
prez@arm.com>; op-tee <op-tee@lists.trustedfirmware.org>; =E8=B5=B5=E5=93=
=B2(=E4=B8=BA=E5=93=B2) <weizhe.zz@alibaba-inc.com>
Subject: Re: Dynamic Shared Memory

Hi Yuye,

On Mon, Feb 13, 2023 at 02:24:10PM +0800, =E6=A2=85=E5=BB=BA=E5=BC=BA(=E7=A6=
=B9=E5=A4=9C) wrote:
> Hi, expert
> Regarding the use of optee dynamic shared memory,
> we have encountered some problems that cannot be solved recently.
> Debug log is as follows:
> REE OS kenrel->TEE SPMC (FFA_MEM_SHARE)
> WARNING: SPM(5): 0x84000073 0x50 0x50 0x0 0x0 0x0 0x0 0x0
> VERBOSE: hafnium ffa_handler func:0x84000073
> VERBOSE: hafnium allow for one memory region to be shared to the TEE.
> VERBOSE: ffa_memory_send
> VERBOSE: share_states->memory_region->sender:0x0
> VERBOSE: share_states->memory_region->attributes:0x2f
> VERBOSE: share_states->share_func:0x84000073
> VERBOSE: share_states->fragment_count:0x1
> VERBOSE: share_states->sending_complete:0x1
> VERBOSE: hanfium fragment_count:1
> VERBOSE: hanfium fragment_constituent_counts[i]:1
> VERBOSE: hanfium max pa_range bits:0x30
> VERBOSE: hanfium pa_begin:0x8a8474000, pa_end:0x8a8475000
> VERBOSE: hanfium fragment_count:1
> VERBOSE: hanfium fragment_constituent_counts[i]:1
> VERBOSE: hanfium max pa_range bits:0x30
> VERBOSE: hanfium pa_begin:0x8a8474000, pa_end:0x8a8475000
> VERBOSE: Marked sending complete.
> Current share states:
> SHARE 0x0 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, send=
er's original mode: 0x7
> SHARE 0x1 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 0 retrieved, send=
er's original mode: 0x7
> SHARE 0x2 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, send=
er's original mode: 0x7
> WARNING: SPM(5): 0x84000061 0x0 0x1 0x0 0x0 0x0 0x0 0x0
> ......
> REE OS kenrel->TEE SP (OPTEE_FFA_YEILDING_CALL_WITH_ARG(cookie))
> WARNING: SPM(5): 0x8400006f 0x8001 0x0 0x80000000 0x0 0x0 0x0 0x0
> VERBOSE: hafnium ffa_handler func:0x8400006f
> D/TC:005 0 mobj_ffa_get_by_cookie:382 cookie 0 resurrecting
> E/TC:005 0 mobj_ffa_get_by_cookie:385 Populating mobj from rx buffer, cooki=
e 0x1
> TEE SPMC->TEE SPMC (FFA_MEM_RETRIEVE_REQ(cookie))
> VERBOSE: hafnium ffa_handler func:0x84000074
> Current share states:
> SHARE 0x0 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, send=
er's original mode: 0x7
> SHARE 0x1 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 0 retrieved, send=
er's original mode: 0x7
> SHARE 0x2 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, send=
er's original mode: 0x7
> SHARE 0x3 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 0 retrieved, send=
er's original mode: 0x7
> VERBOSE: hanfium fragment_count:1
> VERBOSE: hanfium fragment_constituent_counts[i]:1
> VERBOSE: hanfium max pa_range bits:0x30
> VERBOSE: hanfium pa_begin:0x8a8474000, pa_end:0x8a8475000
> VERBOSE: hanfium fragment_count:1
> VERBOSE: hanfium fragment_constituent_counts[i]:1
> VERBOSE: hanfium max pa_range bits:0x30
> VERBOSE: hanfium pa_begin:0x8a8474000, pa_end:0x8a8475000
> Current share states:
> SHARE 0x0 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, send=
er's original mode: 0x7
> SHARE 0x1 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, send=
er's original mode: 0x7
> SHARE 0x2 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 1 retrieved, send=
er's original mode: 0x7
> SHARE 0x3 (from VM 0x0, attributes 0x2f, flags 0x8, tag 0, to 1 recipients =
[VM 0x8001: 0x6 (offset 48)]): fully sent with 1 fragments, 0 retrieved, send=
er's original mode: 0x7
> VERBOSE: hafnium ffa_handler func:0x84000065
> ......
> ERROR LOG
> I/TA: read_raw_object enter
> I/TA: obj_id_sz:0x8
> I/TA: obj_id in tee va:0x40086348
> I/TA: obj_id in ree va:0x400229f0
> I/TA: TEE_MemMove:323 TEE_MemMove enter
> WARNING: Stage-2 page fault: pc=3D0x4007a3ce, vmid=3D0x8001, vcpu=3D5, vadd=
r=3D0x400229f0, ipaddr=3D0x8a84749f0, mode=3D0x81 0x63
> NOTICE: Injecting Data Abort exception into VM 0x8001.
> D/TC:005 0 abort_handler:550 [abort] abort in User mode (TA will panic)
> E/TC:??? 0
> E/TC:??? 0 User mode data-abort at address 0x400229f0 (translation fault)
> E/TC:??? 0 esr 0x94020007 ttbr0 0x20000f03180a0 ttbr1 0x00000000 cidr 0x0
> E/TC:??? 0 cpu #5 <https://github.com/OP-TEE/optee_os/pull/5 > cpsr 0x00000=
130
> E/TC:??? 0 x0 0000000040086348 x1 0000000040086349
> E/TC:??? 0 x2 00000000400229f0 x3 0000000040086348
> E/TC:??? 0 x4 000000004007e088 x5 0000000000000000
> E/TC:??? 0 x6 0000000000000000 x7 000000004001fe60
> E/TC:??? 0 x8 0000000000000000 x9 0000000000000000
> E/TC:??? 0 x10 0000000000000000 x11 0000000000000000
> E/TC:??? 0 x12 0000000000000000 x13 000000004001fe60
> E/TC:??? 0 x14 00000000400695ad x15 0000000000000000
> E/TC:??? 0 x16 00000000f0240370 x17 0000000000000000
> E/TC:??? 0 x18 0000000000000000 x19 0000000000000000
> E/TC:??? 0 x20 0000000000000000 x21 0000000000000000
> E/TC:??? 0 x22 0000000000000000 x23 0000000000000000
> E/TC:??? 0 x24 0000000000000000 x25 0000000000000000
> E/TC:??? 0 x26 0000000000000000 x27 0000000000000000
> E/TC:??? 0 x28 0000000000000000 x29 0000000000000000
> E/TC:??? 0 x30 0000000000000000 elr 000000004007a3ce
> E/TC:??? 0 sp_el0 000000004001ff80
> E/LD: Status of TA f4e750bb-1437-4fbf-8785-8d3580c34994
> E/LD: arch: arm
> E/LD: region 0: va 0x40006000 pa 0xf0404000 size 0x002000 flags rw-s (ldelf)
> E/LD: region 1: va 0x40008000 pa 0xf0406000 size 0x011000 flags r-xs (ldelf)
> E/LD: region 2: va 0x40019000 pa 0xf0417000 size 0x001000 flags rw-s (ldelf)
> E/LD: region 3: va 0x4001a000 pa 0xf0418000 size 0x004000 flags rw-s (ldelf)
> E/LD: region 4: va 0x4001e000 pa 0xf041c000 size 0x001000 flags r--s
> E/LD: region 5: va 0x4001f000 pa 0xf0440000 size 0x001000 flags rw-s (stack)
> E/LD: region 6: va 0x40020000 pa 0x8a1262340 size 0x002000 flags rw-- (para=
m)
> E/LD: region 7: va 0x40022000 pa 0x8a84749f0 size 0x001000 flags rw-- (para=
m)
> E/LD: region 8: va 0x40067000 pa 0x00001000 size 0x017000 flags r-xs [0]
> E/LD: region 9: va 0x4007e000 pa 0x00018000 size 0x00c000 flags rw-s [0]
> E/LD: [0] f4e750bb-1437-4fbf-8785-8d3580c34994 @ 0x40067000
> ERROR CODE
> "optee_examples/secure_storage/ta/secure_storage_ta.c"
> static TEE_Result read_raw_object(uint32_t param_types, TEE_Param params[4]=
) { const uint32_t exp_param_types =3D TEE_PARAM_TYPES(TEE_PARAM_TYPE_MEMREF_=
INPUT, TEE_PARAM_TYPE_MEMREF_OUTPUT, TEE_PARAM_TYPE_NONE, TEE_PARAM_TYPE_NONE=
); char *obj_id; size_t obj_id_sz; IMSG("read_raw_object enter\n"); \/* * Saf=
ely get the invocation parameters *\/ if (param_types !=3D exp_param_types) r=
eturn TEE_ERROR_BAD_PARAMETERS; obj_id_sz =3D params[0].memref.size; obj_id =
=3D TEE_Malloc(obj_id_sz, 0); IMSG("obj_id_sz:%#x\n",obj_id_sz); IMSG("obj_id=
 in tee va:%p\n",obj_id); IMSG("obj_id in ree va:%p\n",params[0].memref.buffe=
r); if (!obj_id) return TEE_ERROR_OUT_OF_MEMORY; TEE_MemMove(obj_id, params[0=
].memref.buffer, obj_id_sz); //<-- ERROR OCCURED TEE_Free(obj_id); return TEE=
_SUCCESS; }
> It seems that OP-TEE tries to use an IPA which isn't mapped by Hafnium.
> Can anyone figure out what the problem is and give some debugging direction=
s? Thanks!

I have recently updated my setup on QEMU with Hafnium and OP-TEE. I just
tested optee_example_secure_storage on that and it works for me.
Perhaps you can compare what you're using with that? My setup is
duplicated with:
repo init -u https://github.com/jenswi-linaro/manifest.git -m qemu_v8.xml \
        -b qemu_sel2
repo sync -j8
cd build
make -j8 toolchains
make -j8 all
make run-only

Cheers,
Jens

--===============8932302647867339024==--

