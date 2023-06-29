From: haiyuan.ghy@alibaba-inc.com
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: optee_benchmark found optee_os function vm_set_ctx() spent much time
Date: Thu, 29 Jun 2023 06:54:35 +0000
Message-ID: <168802167505.1165.2643708547473763456@lists.trustedfirmware.org>
In-Reply-To: <
 <CAHUa44F6iqE19fVwD=kgi3B=gktHg3oGk5NR2wnaA-k0EA_A7g@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3439219363483476701=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3439219363483476701==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens
    I tried CFG_CORE_PREALLOC_EL0_TBLS =3D y, along with removing tlbi_all() =
and icache_inv_all() in core_mmu_set_user_map(), within "#ifdef ARM64 ... #en=
dif" macros.
    Using this optee_os version, I tested the same 10K times InvokeCommand, w=
ith 3 test rounds.

   1st test round, average time of 10K InvokeCommand is 13 us.
   2nd test round, average time is 14 us.
   3rd round, testing CA hanged then my server reboot :(   Following are Pani=
c logs in UART console:

E/TC:019 000 Core data-abort at address 0x4009c000 (write permission fault)
E/TC:019 000  esr 0x9600004f  ttbr0 0x20008940db000   ttbr1 0x00000000   cidr=
 0x0
E/TC:019 000  cpu #19          cpsr 0x42000004
E/TC:019 000  x0  000000004009c000 x1  00000008a0018148
E/TC:019 000  x2  00000000000005cc x3  000000004009c000
E/TC:019 000  x4  00000008a0018168 x5  000000004009c5c0
E/TC:019 000  x6  0000000000000000 x7  00000000000005c0
E/TC:019 000  x8  0000000894aab9b8 x9  000000000585e451
E/TC:019 000  x10 00000000bc273022 x11 00000008900645c8
E/TC:019 000  x12 00000000c3d70b77 x13 00000000d0798a3e
E/TC:019 000  x14 0000000000000000 x15 4604d0c2c6d35ee5
E/TC:019 000  x16 000000089001629c x17 0000000000000000
E/TC:019 000  x18 0000000000000000 x19 000000089409ff10
E/TC:019 000  x20 00000000000005cc x21 00000008a0018148
E/TC:019 000  x22 000000004009c000 x23 00000000000005cc
E/TC:019 000  x24 00000000000165cc x25 0000000000016714
E/TC:019 000  x26 0000000000016000 x27 0000000000000000
E/TC:019 000  x28 0000000000000000 x29 0000000894aabb20
E/TC:019 000  x30 000000089001ae4c elr 0000000890007928
E/TC:019 000  sp_el0 0000000894aabb20
E/TC:019 000 TEE load address @ 0x890004000
E/TC:019 000 Call stack:
E/TC:019 000  0x890007928
E/TC:019 000  0x890015a0c
E/TC:019 000  0x89000e82c
E/TC:019 000  0x890009fa8
E/TC:019 000  0x890008d38
E/TC:019 000 Panic 'unhandled pageable abort' at core/arch/arm/kernel/abort.c=
:572 <abort_handler>
E/TC:019 000 TEE load address @ 0x890004000
E/TC:019 000 Call stack:
E/TC:019 000  0x89000c254
E/TC:019 000  0x8900165ec
E/TC:019 000  0x89000ba70
E/TC:019 000  0x890008e68

I guess removing tlbi_all() and icache_inv_all() can save 17-13=3D4us, but in=
duces problems.

--===============3439219363483476701==--

