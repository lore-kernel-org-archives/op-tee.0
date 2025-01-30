From: Patryk <pbiel7@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Registering dynamic shared memory
Date: Thu, 30 Jan 2025 15:48:17 +0100
Message-ID: 
 <CA+DkFDanFi914CnhYSkZU=8DnEXU8s3HNmH_6ogqSghBnH8_Aw@mail.gmail.com>
In-Reply-To: <
 <CAHUa44GYsCoJBEk8PBRZePx-m8V+nowoWOLSdXs9v1j8cYuKHg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5819244326521053739=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5819244326521053739==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,
Thanks for the response.

czw., 30 sty 2025 o 15:38 Jens Wiklander <jens.wiklander@linaro.org> napisa=
=C5=82(a):
>
> Hi Patryk,
>
> On Thu, Jan 30, 2025 at 8:33=E2=80=AFAM Patryk <pbiel7@gmail.com> wrote:
> >
> > Hi,
> > I have some problems configuring dynamic shared memory on my platform,
> > and thought that perhaps somebody could give me a hint.
> > My SoC (LS1028A, board: LS1028A-RDB), according to reference manual
> > has two DRAM regions:
> > - DRAM region 0 : start address: 0x80000000, size: 0x80000000
> > - DRAM region 2:  start address: 0x2080000000, size: 0x1F80000000
> >
> > I tried two approaches:
> > 1) In optee-os, in a part of code that handles my SoC I added a call
> > to register DDR only for the first region:
> > register_addr(0x80000000, 2G - some size for TZ DRAM) (similarly like
> > in case of other SoCs)
> >
> > However when the system boots up, the optee driver logs the following
> > information:
> > [ 5.703831] optee: dynamic shared memory is enabled
> > E/TC:0 0 std_entry_with_parg:234 Bad arg address 0x208100e000
> > It seems that there is some problem with an address that the driver wants=
 to use
> >
> > 2) Apart from registering first region I also added a call that
> > registers the second region so I ended up with two calls:
> > register_addr(0x80000000, 2G - some size for TZ DRAM)
> > register_ddr(0x2080000000, 0x1F80000000);
> >
> > Now the problem is different since the platform no longer boots, due
> > to the panic with the following output:
> > D/TC:0 0 discover_nsec_memory:1117 No non-secure memory found in external=
 DT
> > D/TC:0 0 carve_out_phys_mem:362 No need to carve out 0xfc000000 size 0x3e=
00000
> > D/TC:0 0 carve_out_phys_mem:362 No need to carve out 0xffe00000 size 0x20=
0000
> > E/TC:0 0 Panic at
> > /usr/src/debug/optee-os-qoriq/4.2.0+git/core/mm/core_mmu.c:490
> > <core_mmu_set_discovered_nsec_ddr>
> >
> > I'm wondering, what am I missing?
> > Do I need to register both regions? If so, why does the optee panic
> > when the second region gets registered?
> >
> > I would be grateful for some ideas.
>
> I think the panic() is a result of core_mmu_check_max_pa() returning false.
>
> In the end it boils down to how many bits a physical address can hold
> according to core_mmu_arm64_get_pa_width(). You can compile with
> CFG_AUTO_MAX_PA_BITS=3Dy for automatic discovery of how many bits are
> supported by the hardware or you can set CFG_CORE_ARM64_PA_BITS to at
> least 40 or what you prefer as max.
>
> Cheers,
> Jens

I just figured it out about an hour ago but wanted to test it
thoroughly before making an update on my question on ML.
Thanks for pointing me to CFG_AUTO_MAX_PA_BITS, didn't know about it,
and sorry for disturbing you guys.

Best regards
Patryk

--===============5819244326521053739==--

