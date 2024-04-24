From: Jonathan Liu <net147@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: rk3399 issue: no DMA in Linux with mainline TF-A and U-Boot SPL
Date: Wed, 24 Apr 2024 17:52:23 +1000
Message-ID: 
 <CANwerB1VhRichsmiozR3zTu2nWi0SsGg6Td5c8RuUe9rxrjsrA@mail.gmail.com>
In-Reply-To: <80286c54-c617-d790-b7dc-efd4e52259eb@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7639992427443106981=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7639992427443106981==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Kever,

I also see this issue when switching between Rockchip ATF and Upstream ATF.

Versions:
Rockchip DDR Blob - rk3399_ddr_800MHz_v1.30.bin
Rockchip Miniloader - rk3399_miniloader_v1.30.bin
Rockchip ATF - rk3399_bl31_v1.36.elf
Upstream ATF - git://git.trustedfirmware.org/TF-A/trusted-firmware-a.git,
git tag v2.8.0, with RK3399_BAUDRATE changed from 115200 to 1500000 in
plat/rockchip/rk3399/rk3399_def.h
U-Boot - git://git.denx.de/u-boot.git, git tag v2022.01

Results:
Rockchip DDR Blob + Rockchip Miniloader + Rockchip ATF + U-Boot = DMA working
  dma-pl330 ff6d0000.dma-controller: Loaded driver for PL330 DMAC-241330
  dma-pl330 ff6d0000.dma-controller:       DBUFF-32x8bytes Num_Chans-6
Num_Peri-12 Num_Events-12
  dma-pl330 ff6e0000.dma-controller: Loaded driver for PL330 DMAC-241330
  dma-pl330 ff6e0000.dma-controller:       DBUFF-128x8bytes
Num_Chans-8 Num_Peri-20 Num_Events-16
Rockchip DDR Blob + Rockchip Miniloader + Upstream ATF + U-Boot = DMA
not working
  OF: amba_device_add() failed (-19) for /bus/dma-controller(a)ff6d0000
  OF: amba_device_add() failed (-19) for /bus/dma-controller(a)ff6e0000

I can't check the Rockchip ATF source code as it isn't available.
Any idea what is different between Rockchip ATF and Upstream ATF for
DMA to work properly?

Regards,
Jonathan

On Mon, 3 Apr 2023 at 18:38, Kever Yang <kever.yang@rock-chips.com> wrote:
>
> Hi Christoph,
>
>      The ARM PL330 DMA driver in kernel only relate to:
>
> - DTS kernel used, can be check in /proc/device-tree/
>
> - kernel driver which should mach the compatible name.
>
> This driver should has nothing to do with U-Boot SPL or TF-A, because we
> don't have any special setting for PL330 in loader stage.
>
>
> Thanks,
>
> - Kever
>
> On 2023/4/3 03:01, Christoph Fritz wrote:
> > Hello Kever,
> >
> >   on a rk3399, booting current U-Boot SPL with mainline TF-A leads to
> > missing DMA (and no sound) on Linux.
> >
> > However, when using rockchip its so called mini-loader
> > (rk3399_miniloader_v1.26.bin) and their BL31 (rk3399_bl31_v1.35.elf) to
> > boot, DMA works perfectly fine.
> >
> > Tested on a custom rk3399 board and on ROCK Pi4.
> >
> > Attached to this mail are two boot logs with some debug prints:
> >
> >   - good_amba_log.txt (DMA works)
> >   - no_amba_log.txt (no DMA device)
> >
> > The main difference I can spot between the two logs is that on Linux
> > (drivers/amba/bus.c) AMBA_CID (0xb105f00d) cannot be found. Instead,
> > only some CORESIGHT_CIDs (presumably for debugging) and four 0x00000000
> > CIDs are detected.
> >
> > As a result, the "PL330 DMAC-241330" driver does not load. My theory is
> > that DMA needs to be allowed somewhere in the undocumented syscon-
> > registers, similar to what U-Boot is already doing for eMMC in
> > arch_cpu_init() (arch/arm/mach-rockchip/rk3399/rk3399.c).
> >
> > Any ideas?
> >
> > Or maybe I'm just missing some configuration?
> >
> > Since multiple software projects are involved (TF-A, OP-TEE, U-Boot,
> > Linux), I Cc'ed a bit.
> >
> >   Thanks
> >    -- Christoph

--===============7639992427443106981==--

