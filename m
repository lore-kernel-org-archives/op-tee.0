From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure memory allocation
Date: Wed, 02 Dec 2020 15:57:17 +0100
Message-ID: 
 <CAHUa44HfYrQR1ErvjrsoGAp7bZL_vAsTN4Qh5_r9r+CoHgoWig@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3C010001762353367b-5e3a4ee5-11ff-45b6-b61e-ce7174353?=
 =?utf-8?q?1ae-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3987840667152949615=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3987840667152949615==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Robert,

Some answers below.

On Wed, Dec 2, 2020 at 1:00 PM Robert Deli=C3=ABn via OP-TEE
<op-tee@lists.trustedfirmware.org> wrote:
>
> Hi,
>
> We are using op-tee 3.10 in our i.MX6UL-based product and we are running in=
to a small problem we hope you can help us out with. Apologies for the large =
mail; It's mostly pictures.
>
> The nature of our product requires us to protect access to the display cont=
ents. To achieve this, we have added a display driver to op-tee and have allo=
cated the frame buffers in op-tee too.
>
> We are conforming to the memory-map as layed out in .../core/arch/arm/inclu=
de/mm/generic_ram_layout.h:
>
> TEE RAM layout without CFG_WITH_PAGER
>
> +----------------------------------+ <-- CFG_TZDRAM_START
> | TEE core secure RAM (TEE_RAM)    |
> +----------------------------------+
> | Trusted Application RAM (TA_RAM) |
> +----------------------------------+
> | SDP test memory (optional)       |
> +----------------------------------+ <-- CFG_TZDRAM_START + CFG_TZDRAM_SIZE
>
> +----------------------------------+ <-- CFG_SHMEM_START
> | Non-secure static SHM            |
> +----------------------------------+ <-- CFG_SHMEM_START + CFG_SHMEM_SIZE
>
> With this memory map in mind, we came up with the following solution:
>
> +----------------------------------+ <-- CFG_DRAM_BASE
> |                                  |
> | Non-secure memory                |
> |                                  |
> +----------------------------------+ <-- CFG_TZDRAM_START
> | TEE core secure RAM (TEE_RAM)    |
> +----------------------------------+
> | Trusted Application RAM (TA_RAM) |
> +----------------------------------+ <-- CFG_POS_SEC_FB0_START
> | Secure frame buffer 0            |
> +----------------------------------+ <-- CFG_POS_SEC_FB1_START
> | Secure frame buffer 1            |
> +----------------------------------+ <-- CFG_SHMEM_START (=3D=3D CFG_TZDRAM=
_START + CFG_TZDRAM_SIZE)
> | Non-secure static SHM            |
> +----------------------------------+ <-- Top of DDR (CFG_SHMEM_START + CFG_=
SHMEM_SIZE)
> CFG_DDR_SIZE          =3D 0x10000000
> CFG_SHMEM_SIZE        =3D 0x00200000
> CFG_SHMEM_START       =3D ($(CFG_DRAM_BASE) + $(CFG_DDR_SIZE) - $(CFG_SHMEM=
_SIZE))
> CFG_SEC_FB_SIZE       =3D 0x00096000
> CFG_POS_SEC_FB1_START =3D ($(CFG_SHMEM_START) - $(CFG_SEC_FB_SIZE))
> CFG_POS_SEC_FB0_START =3D ($(CFG_POS_SEC_FB1_START) - $(CFG_SEC_FB_SIZE))
> CFG_TZDRAM_START      =3D ($(CFG_DRAM_BASE) + 0x0e000000)
> CFG_TZDRAM_SIZE       =3D ($(CFG_SHMEM_START) - $(CFG_TZDRAM_START))
>
> This solution keeps the frame buffers within the region CFG_TZDRAM_START:CF=
G_TZDRAM_SIZE, but when booting the system, we notice an overlap between TA_R=
AM and both frame buffer areas:
>
> D/TC:0   dump_mmap_table:732 type TA_RAM       va 0x88c00000..0x8a8fffff pa=
 0x8e100000..0x8fdfffff size 0x01d00000 (pgdir)
> ...
> D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8ded4000..0x8df69fff pa=
 0x8fd6a000..0x8fdfffff size 0x00096000 (smallpg)
> D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8df6a000..0x8dffffff pa=
 0x8fcd4000..0x8fd69fff size 0x00096000 (smallpg)
>
> Without fully comprehending how memory is allocated, we fear that this situ=
ation will allow TA's to be loaded into these frame buffer areas.
> To mitigate this, we came up with this alternative:
>
> +----------------------------------+ <-- CFG_DRAM_BASE
> |                                  |
> | Non-secure memory                |
> |                                  |
> +----------------------------------+ <-- CFG_TZDRAM_START
> | TEE core secure RAM (TEE_RAM)    |
> +----------------------------------+
> | Trusted Application RAM (TA_RAM) |
> +----------------------------------+ <-- CFG_POS_SEC_FB0_START (=3D=3D CFG_=
TZDRAM_START + CFG_TZDRAM_SIZE)
> | Secure frame buffer 0            |
> +----------------------------------+ <-- CFG_POS_SEC_FB1_START
> | Secure frame buffer 1            |
> +----------------------------------+ <-- CFG_SHMEM_START
> | Non-secure static SHM            |
> +----------------------------------+ <-- Top of DDR (CFG_SHMEM_START + CFG_=
SHMEM_SIZE)
> CFG_DDR_SIZE          =3D 0x10000000
> CFG_SHMEM_SIZE        =3D 0x00200000
> CFG_SHMEM_START       =3D ($(CFG_DRAM_BASE) + $(CFG_DDR_SIZE) - $(CFG_SHMEM=
_SIZE))
> CFG_SEC_FB_SIZE       =3D 0x00096000
> CFG_POS_SEC_FB1_START =3D ($(CFG_SHMEM_START) - $(CFG_SEC_FB_SIZE))
> CFG_POS_SEC_FB0_START =3D ($(CFG_POS_SEC_FB1_START) - $(CFG_SEC_FB_SIZE))
> CFG_TZDRAM_START      =3D ($(CFG_DRAM_BASE) + 0x0e000000)
> CFG_TZDRAM_SIZE       =3D ($(CFG_POS_SEC_FB0_START) - $(CFG_TZDRAM_START))
>
> This solution puts the frame buffers outside the region CFG_TZDRAM_START:CF=
G_TZDRAM_SIZE so they no longer overlap with TA_RAM. However, when booting th=
e system, op-tee panics:
>
> D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8c2d4000..0x8c369fff pa=
 0x8fd6a000..0x8fdfffff size 0x00096000 (smallpg)
> D/TC:0   dump_mmap_table:732 type RAM_SEC      va 0x8c36a000..0x8c3fffff pa=
 0x8fcd4000..0x8fd69fff size 0x00096000 (smallpg)
> ...
> D/TC:0   dump_mmap_table:732 type TA_RAM       va 0x8c400000..0x8dfd3fff pa=
 0x8e100000..0x8fcd3fff size 0x01bd4000 (smallpg)
> ...
> E/TC:0 0 check_phys_mem_is_outside:332 Non-sec mem (0x8fcd4000:0x12c000) ov=
erlaps map (type 12 0x8fd6a000:0x96000)
> E/TC:0 0 Panic at core/arch/arm/mm/core_mmu.c:336 <check_phys_mem_is_outsid=
e>
> E/TC:0 0 TEE load address @ 0x8e000000
> E/TC:0 0 Call stack:
> E/TC:0 0  0x8e005621
> E/TC:0 0  0x8e01d397
> E/TC:0 0  0x8e005aaf
> E/TC:0 0  0x8e004da7
> E/TC:0 0  0x8e000174
>
> In this situation, the memory area intended for the frame buffers (0x8fd6a0=
00:0x96000) is now implicitly regarded as non-secure RAM, regardless of us re=
gistering it as MEM_AREA_RAM_SEC in main.c:
>
> register_phys_mem(MEM_AREA_RAM_SEC, CFG_POS_SEC_FB0_START, CFG_SEC_FB_SIZE);
> register_phys_mem(MEM_AREA_RAM_SEC, CFG_POS_SEC_FB1_START, CFG_SEC_FB_SIZE);
>
> Could you please confirm (or deny) that our first solution is the proper wa=
y to allocate these secure frame buffers and that they will not be overwritte=
n by the process of loading TAs?

It looks like something went wrong in the first solution. The failure
in the last solution is because OP-TEE thinks that you've accidentally
tried to configure non-secure memory as secure memory.

> If this is not the proper way, could you give us some pointers on how to do=
 this? We do not feel comfortable allocating such large areas on the heap bec=
ause of good taste and because we're not sure yet whether or not there are ad=
ditional alignment requirement for these frame buffers. Perhaps something sim=
ilar to the Linux slab-allocator is available?

I think the easiest is to allocate memory from the pool used for TAs with:
mm =3D tee_mm_alloc(&tee_mm_sec_ddr, size);
Until this mm is freed no one else will use the memory it represents.
Returned memory is page aligned (based on CORE_MMU_USER_CODE_SHIFT).

This depends on paging being disabled, which it seems it is for the
IMX platforms.
If paging would have been enabled this memory might have been less
secure than what you require, depending on how the platform is
configured.

Cheers,
Jens

--===============3987840667152949615==--

