From: Robert Deliën <robert@delien.nl>
To: op-tee@lists.trustedfirmware.org
Subject: Secure memory allocation
Date: Wed, 02 Dec 2020 11:45:03 +0000
Message-ID: <AM0PR08MB3459016D272A63D2281035C4C5F30@AM0PR08MB3459.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1154206083767543370=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1154206083767543370==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

We are using op-tee 3.10 in our i.MX6UL-based product and we are running into=
 a small problem we hope you can help us out with. Apologies for the large ma=
il; It's mostly pictures.

The nature of our product requires us to protect access to the display conten=
ts. To achieve this, we have added a display driver to op-tee and have alloca=
ted the frame buffers in op-tee too.

We are conforming to the memory-map as layed out in .../core/arch/arm/include=
/mm/generic_ram_layout.h:

TEE RAM layout without CFG_WITH_PAGER

+----------------------------------+ <-- CFG_TZDRAM_START
| TEE core secure RAM (TEE_RAM)    |
+----------------------------------+
| Trusted Application RAM (TA_RAM) |
+----------------------------------+
| SDP test memory (optional)       |
+----------------------------------+ <-- CFG_TZDRAM_START + CFG_TZDRAM_SIZE

+----------------------------------+ <-- CFG_SHMEM_START
| Non-secure static SHM            |
+----------------------------------+ <-- CFG_SHMEM_START + CFG_SHMEM_SIZE

With this memory map in mind, we came up with the following solution:

+----------------------------------+ <-- CFG_DRAM_BASE
|                                  |
| Non-secure memory                |
|                                  |
+----------------------------------+ <-- CFG_TZDRAM_START
| TEE core secure RAM (TEE_RAM)    |
+----------------------------------+
| Trusted Application RAM (TA_RAM) |
+----------------------------------+ <-- CFG_POS_SEC_FB0_START
| Secure frame buffer 0            |
+----------------------------------+ <-- CFG_POS_SEC_FB1_START
| Secure frame buffer 1            |
+----------------------------------+ <-- CFG_SHMEM_START (=3D=3D CFG_TZDRAM_S=
TART + CFG_TZDRAM_SIZE)
| Non-secure static SHM            |
+----------------------------------+ <-- Top of DDR (CFG_SHMEM_START + CFG_SH=
MEM_SIZE)
CFG_DDR_SIZE          =3D 0x10000000
CFG_SHMEM_SIZE        =3D 0x00200000
CFG_SHMEM_START       =3D ($(CFG_DRAM_BASE) + $(CFG_DDR_SIZE) - $(CFG_SHMEM_S=
IZE))
CFG_SEC_FB_SIZE       =3D 0x00096000
CFG_POS_SEC_FB1_START =3D ($(CFG_SHMEM_START) - $(CFG_SEC_FB_SIZE))
CFG_POS_SEC_FB0_START =3D ($(CFG_POS_SEC_FB1_START) - $(CFG_SEC_FB_SIZE))
CFG_TZDRAM_START      =3D ($(CFG_DRAM_BASE) + 0x0e000000)
CFG_TZDRAM_SIZE       =3D ($(CFG_SHMEM_START) - $(CFG_TZDRAM_START))

This solution keeps the frame buffers within the region CFG_TZDRAM_START:CFG_=
TZDRAM_SIZE, but when booting the system, we notice an overlap between TA_RAM=
 and both frame buffer areas:

D/TC:0   dump_mmap_table:732 type TA_RAM       va 0x88c00000..0x8a8fffff pa 0=
x8e100000..0x8fdfffff size 0x01d00000 (pgdir)
...
D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8ded4000..0x8df69fff pa 0=
x8fd6a000..0x8fdfffff size 0x00096000 (smallpg)
D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8df6a000..0x8dffffff pa 0=
x8fcd4000..0x8fd69fff size 0x00096000 (smallpg)

Without fully comprehending how memory is allocated, we fear that this situat=
ion will allow TA's to be loaded into these frame buffer areas.
To mitigate this, we came up with this alternative:

+----------------------------------+ <-- CFG_DRAM_BASE
|                                  |
| Non-secure memory                |
|                                  |
+----------------------------------+ <-- CFG_TZDRAM_START
| TEE core secure RAM (TEE_RAM)    |
+----------------------------------+
| Trusted Application RAM (TA_RAM) |
+----------------------------------+ <-- CFG_POS_SEC_FB0_START (=3D=3D CFG_TZ=
DRAM_START + CFG_TZDRAM_SIZE)
| Secure frame buffer 0            |
+----------------------------------+ <-- CFG_POS_SEC_FB1_START
| Secure frame buffer 1            |
+----------------------------------+ <-- CFG_SHMEM_START
| Non-secure static SHM            |
+----------------------------------+ <-- Top of DDR (CFG_SHMEM_START + CFG_SH=
MEM_SIZE)
CFG_DDR_SIZE          =3D 0x10000000
CFG_SHMEM_SIZE        =3D 0x00200000
CFG_SHMEM_START       =3D ($(CFG_DRAM_BASE) + $(CFG_DDR_SIZE) - $(CFG_SHMEM_S=
IZE))
CFG_SEC_FB_SIZE       =3D 0x00096000
CFG_POS_SEC_FB1_START =3D ($(CFG_SHMEM_START) - $(CFG_SEC_FB_SIZE))
CFG_POS_SEC_FB0_START =3D ($(CFG_POS_SEC_FB1_START) - $(CFG_SEC_FB_SIZE))
CFG_TZDRAM_START      =3D ($(CFG_DRAM_BASE) + 0x0e000000)
CFG_TZDRAM_SIZE       =3D ($(CFG_POS_SEC_FB0_START) - $(CFG_TZDRAM_START))

This solution puts the frame buffers outside the region CFG_TZDRAM_START:CFG_=
TZDRAM_SIZE so they no longer overlap with TA_RAM. However, when booting the =
system, op-tee panics:

D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8c2d4000..0x8c369fff pa 0=
x8fd6a000..0x8fdfffff size 0x00096000 (smallpg)
D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8c36a000..0x8c3fffff pa 0=
x8fcd4000..0x8fd69fff size 0x00096000 (smallpg)
...
D/TC:0   dump_mmap_table:732 type TA_RAM       va 0x8c400000..0x8dfd3fff pa 0=
x8e100000..0x8fcd3fff size 0x01bd4000 (smallpg)
...
E/TC:0 0 check_phys_mem_is_outside:332 Non-sec mem (0x8fcd4000:0x12c000) over=
laps map (type 12 0x8fd6a000:0x96000)
E/TC:0 0 Panic@core/arch/arm/mm/core_mmu.c:336 <check_phys_mem_is_outside>
E/TC:0 0 TEE load address @ 0x8e000000
E/TC:0 0 Call stack:
E/TC:0 0  0x8e005621
E/TC:0 0  0x8e01d397
E/TC:0 0  0x8e005aaf
E/TC:0 0  0x8e004da7
E/TC:0 0  0x8e000174

In this situation, the memory area intended for the frame buffers (0x8fd6a000=
:0x96000) is now implicitly regarded as non-secure RAM, regardless of us regi=
stering it as MEM_AREA_RAM_SEC in main.c:

register_phys_mem(MEM_AREA_RAM_SEC, CFG_POS_SEC_FB0_START, CFG_SEC_FB_SIZE);
register_phys_mem(MEM_AREA_RAM_SEC, CFG_POS_SEC_FB1_START, CFG_SEC_FB_SIZE);

Could you please confirm (or deny) that our first solution is the proper way =
to allocate these secure frame buffers and that they will not be overwritten =
by the process of loading TAs? If this is not the proper way, could you give =
us some pointers on how to do this? We do not feel comfortable allocating suc=
h large areas on the heap because of good taste and because we're not sure ye=
t whether or not there are additional alignment requirement for these frame b=
uffers. Perhaps something similar to the Linux slab-allocator is available?

Thank you in advance for your help.

With kind regards,

        Robert Deli=C3=ABn.

--===============1154206083767543370==--

