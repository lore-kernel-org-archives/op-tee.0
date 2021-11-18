From: John Linn <linnj@xilinx.com>
To: op-tee@lists.trustedfirmware.org
Subject: Embedded DT (CFG_EMBED_DT) with dynamic shared memory
 (CFG_CORE_DYN_SHM) in optee-os
Date: Thu, 18 Nov 2021 20:23:59 +0000
Message-ID: <DM8PR02MB8153B3285BF17628942612CED89B9@DM8PR02MB8153.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3175701081495964885=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3175701081495964885==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It appears that dynamic shared memory does not work with an embedded DT, but =
I'm likely missing something. I have it working fine with an external DT.

There is a bit of interaction in kernel/boot.c with the two configuration opt=
ions and my testing is not seeing it work with 3.14 and master looks the same=
 viewing it.

get_external_fdt() is called which does not work with the embedded DT it appe=
ars to me.

Any hints or advice?

Thanks
John

#ifdef CFG_CORE_DYN_SHM
static void discover_nsec_memory(void)
{
        struct core_mmu_phys_mem *mem;
        const struct core_mmu_phys_mem *mem_begin =3D NULL;
        const struct core_mmu_phys_mem *mem_end =3D NULL;
        size_t nelems;
        void *fdt =3D get_external_dt();

        if (fdt) {
                mem =3D get_nsec_memory(fdt, &nelems);
                if (mem) {
                        core_mmu_set_discovered_nsec_ddr(mem, nelems);
                        return;
                }

                DMSG("No non-secure memory found in FDT");
        }

        mem_begin =3D phys_ddr_overall_begin;
        mem_end =3D phys_ddr_overall_end;
        nelems =3D mem_end - mem_begin;
        if (nelems) {
                /*
                 * Platform cannot use both register_ddr() and the now
                 * deprecated register_dynamic_shm().
                 */
                assert(phys_ddr_overall_compat_begin =3D=3D
                       phys_ddr_overall_compat_end);
        } else {
                mem_begin =3D phys_ddr_overall_compat_begin;
                mem_end =3D phys_ddr_overall_compat_end;
                nelems =3D mem_end - mem_begin;
                if (!nelems)
                        return;
This email and any attachments are intended for the sole use of the named rec=
ipient(s) and contain(s) confidential information that may be proprietary, pr=
ivileged or copyrighted under applicable law. If you are not the intended rec=
ipient, do not read, copy, or forward this email message or any attachments. =
Delete this email message and any attachments immediately.

--===============3175701081495964885==--

