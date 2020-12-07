From: Robert Deliën <robert@delien.nl>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Secure memory allocation
Date: Mon, 07 Dec 2020 16:48:17 +0000
Message-ID: <AM0PR08MB345917CF1EF8B0A4F15B4252C5CE0@AM0PR08MB3459.eurprd08.prod.outlook.com>
In-Reply-To: <
 <CAHUa44EBRxaC=93yTB6n-dHpWkY45sHqWivB_n93nkApsPfyCw@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6675159806607234134=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6675159806607234134==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Again, thank you very much for your prompt answer.

> Looks good, the tee_mm functions handle resource allocation typically
> virtual or physical memory. It doesn't touch the memory itself. The
> code above looks OK. Yep, the memory will be physically contiguous
> since the entire TA RAM range (represented here by tee_mm_sec_ddr) is
> mapped with physically contiguous memory.

The code 'works' beautifully. That is; The FB addresses it produces seem plau=
sible:
D/TC:0 0 imx_lcdif_init:334 fb[0] @0x88e00000 (pa 0x8e100000)
D/TC:0 0 imx_lcdif_init:334 fb[1] @0x88e96000 (pa 0x8e196000)
Even accessing the buffer using the corresponding virtual addresses produces =
no Abort faults.

Unfortunately, it doesn't produce an image on the LCD either. However, if I (=
illegally) re-use part of shared memory as a frame buffer, I _do_ get an imag=
e.
Details from conf.mk:
CFG_DRAM_BASE =3D 0x80000000
CFG_DDR_SIZE =3D 0x10000000
CFG_SHMEM_SIZE =3D 0x00200000
CFG_SHMEM_START =3D ($(CFG_DRAM_BASE) + $(CFG_DDR_SIZE) - $(CFG_SHMEM_SIZE))

Details from code:
fb_pa =3D 0x90000000 - FB_SIZE;
fb_va =3D (void *fb_pa, MEM_AREA_NSEC_SHM);

We are starting to suspect that the LCD peripheral is denied access to the fr=
ame buffer by the TZ controller, and this specific peripheral's bus master do=
esn't seem to have corresponding Supervisor mode bits in the HP0 or SA regist=
er.

Now I do know that this problem is beyond the scope of this mailing list, but=
 if anybody on this list knows more about this, I'd be more than happy to hea=
r about it!

With kind regards,

          Robert.

--===============6675159806607234134==--

