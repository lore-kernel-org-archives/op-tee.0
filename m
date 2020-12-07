From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure memory allocation
Date: Mon, 07 Dec 2020 20:21:10 +0100
Message-ID: <cc94a2214d53a6d88c0a7a35644ddd8af6f12fd5.camel@pengutronix.de>
In-Reply-To: <=?utf-8?q?=3C010001763e1abf65-e8293384-52d6-414c-ae15-e153b2c96?=
 =?utf-8?q?773-000000=40email=2Eamazonses=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3806475079147957565=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3806475079147957565==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-12-07 at 16:48 +0000, Robert Deli=C3=ABn via OP-TEE wrote:
> Hi,
>=20
> Again, thank you very much for your prompt answer.
>=20
> > Looks good, the tee_mm functions handle resource allocation typically
> > virtual or physical memory. It doesn't touch the memory itself. The
> > code above looks OK. Yep, the memory will be physically contiguous
> > since the entire TA RAM range (represented here by tee_mm_sec_ddr) is
> > mapped with physically contiguous memory.
>=20
> The code 'works' beautifully. That is; The FB addresses it produces seem pl=
ausible:
> D/TC:0 0 imx_lcdif_init:334 fb[0] @0x88e00000 (pa 0x8e100000)
> D/TC:0 0 imx_lcdif_init:334 fb[1] @0x88e96000 (pa 0x8e196000)
> Even accessing the buffer using the corresponding virtual addresses produce=
s no Abort faults.
>=20
> Unfortunately, it doesn't produce an image on the LCD either. However, if I=
 (illegally) re-use part of shared memory as a frame buffer, I _do_ get an im=
age.
> Details from conf.mk:
> CFG_DRAM_BASE =3D 0x80000000
> CFG_DDR_SIZE =3D 0x10000000
> CFG_SHMEM_SIZE =3D 0x00200000
> CFG_SHMEM_START =3D ($(CFG_DRAM_BASE) + $(CFG_DDR_SIZE) - $(CFG_SHMEM_SIZE))
>=20
> Details from code:
> fb_pa =3D 0x90000000 - FB_SIZE;
> fb_va =3D (void *fb_pa, MEM_AREA_NSEC_SHM);
>=20
> We are starting to suspect that the LCD peripheral is denied access to the =
frame buffer by the TZ controller, and this specific peripheral's bus master =
doesn't seem to have corresponding Supervisor mode bits in the HP0 or SA regi=
ster.
>=20
> Now I do know that this problem is beyond the scope of this mailing list, b=
ut if anybody on this list knows more about this, I'd be more than happy to h=
ear about it!
>=20

Hm, since the LCDIF CSL register is lumped together with the PXP, you
could try setting the SA bit for the PXP peripheral.

Regards,
Rouven Czerwinski


--===============3806475079147957565==--

