From: Christoph Fritz <chf.fritz@googlemail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: rk3399 issue: no DMA in Linux with mainline TF-A and U-Boot SPL
Date: Wed, 24 Apr 2024 11:42:43 +0200
Message-ID: <204ca121667e15aa4574d02beb3ff06855d5f31d.camel@googlemail.com>
In-Reply-To: <
 <CANwerB1VhRichsmiozR3zTu2nWi0SsGg6Td5c8RuUe9rxrjsrA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2420012153252857863=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2420012153252857863==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Jonathan and Kevar,

> I also see this issue when switching between Rockchip ATF and Upstream ATF.
>=20
> Versions:
> Rockchip DDR Blob - rk3399_ddr_800MHz_v1.30.bin
> Rockchip Miniloader - rk3399_miniloader_v1.30.bin
> Rockchip ATF - rk3399_bl31_v1.36.elf
> Upstream ATF - git://git.trustedfirmware.org/TF-A/trusted-firmware-a.git,
> git tag v2.8.0, with RK3399_BAUDRATE changed from 115200 to 1500000 in
> plat/rockchip/rk3399/rk3399_def.h
> U-Boot - git://git.denx.de/u-boot.git, git tag v2022.01
>=20
> Results:
> Rockchip DDR Blob + Rockchip Miniloader + Rockchip ATF + U-Boot =3D DMA wor=
king
>   dma-pl330 ff6d0000.dma-controller: Loaded driver for PL330 DMAC-241330
>   dma-pl330 ff6d0000.dma-controller:       DBUFF-32x8bytes Num_Chans-6
> Num_Peri-12 Num_Events-12
>   dma-pl330 ff6e0000.dma-controller: Loaded driver for PL330 DMAC-241330
>   dma-pl330 ff6e0000.dma-controller:       DBUFF-128x8bytes
> Num_Chans-8 Num_Peri-20 Num_Events-16
> Rockchip DDR Blob + Rockchip Miniloader + Upstream ATF + U-Boot =3D DMA
> not working
>   OF: amba_device_add() failed (-19) for /bus/dma-controller(a)ff6d0000
>   OF: amba_device_add() failed (-19) for /bus/dma-controller(a)ff6e0000
>=20
> I can't check the Rockchip ATF source code as it isn't available.
> Any idea what is different between Rockchip ATF and Upstream ATF for
> DMA to work properly?

@Kevar: It would be really great if you could have a look into it.

I am still having this issue.

Thanks
  -- Christoph


--===============2420012153252857863==--

