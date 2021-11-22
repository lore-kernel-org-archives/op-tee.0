From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Fwd: Embedded DT (CFG_EMBED_DT) with dynamic shared memory
 (CFG_CORE_DYN_SHM) in optee-os
Date: Mon, 22 Nov 2021 17:17:16 +0100
Message-ID: 
 <CAN5uoS9H3c3f6mqAALaBBUsz+1KfwcerZ9T-dCuw1Sa98hwWQA@mail.gmail.com>
In-Reply-To: <
 <CAA-cTWZDnM4GEXf71MtC+_z=MBOpMaENTKvOD5v+kN6DfeziBQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7436739319867699277=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7436739319867699277==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello John,

> From: John Linn <linnj@xilinx.com>
> Date: Thu, Nov 18, 2021 at 10:24 PM
> Subject: Embedded DT (CFG_EMBED_DT) with dynamic shared memory (CFG_CORE_DY=
N_SHM) in optee-os
> To: op-teeATlists.trustedfirmware.org <op-teeATlists.trustedfirmware.org>
>
>
> It appears that dynamic shared memory does not work with an embedded DT, bu=
t I'm likely missing something. I have it working fine with an external DT.
>
> There is a bit of interaction in kernel/boot.c with the two configuration o=
ptions and my testing is not seeing it work with 3.14 and master looks the sa=
me viewing it.
>
> get_external_fdt() is called which does not work with the embedded DT it ap=
pears to me.

Indeed the current implementation gets the main memory size from the
external non-secure DTB.
This memory is mainly REE memory and can tbe used  as shared memory.

It looks reasonable to get the same info from the embedded DTB instead
but the point to discuss, IMO, is whether the memory nodes of OP-TEE
secure DT relate to OP-TEE "secure memory" or to system-wide (possibly
non-secure) memory. In the former case, that information could not be
used to define the "non-secure shareable address ranges".
Feel free to create a P-R in optee_os for that purpose (something like
try with embedded_dt() then fallback to external=C3=A8_dt()),

Regards,
Etienne


>
> Any hints or advice?
>
> Thanks
> John

--===============7436739319867699277==--

