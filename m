From: John Linn <linnj@xilinx.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: Embedded DT (CFG_EMBED_DT) with dynamic shared memory
 (CFG_CORE_DYN_SHM) in optee-os
Date: Mon, 29 Nov 2021 14:22:30 +0000
Message-ID: <DM8PR02MB81539F3A9381A439C3FAAEC5D8669@DM8PR02MB8153.namprd02.prod.outlook.com>
In-Reply-To: <
 <CAN5uoS9H3c3f6mqAALaBBUsz+1KfwcerZ9T-dCuw1Sa98hwWQA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0793006235564281629=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0793006235564281629==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Etienne,

I can add a P-R in optee_os.

Based on my quick testing it appears to be a simple one line change unless I'=
ve overlooked something.

Thanks
John

core/arch/arm/kernel/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/core/arch/arm/kernel/boot.c b/core/arch/arm/kernel/boot.c
index 09c1b811..58bf50cd 100644
--- a/core/arch/arm/kernel/boot.c
+++ b/core/arch/arm/kernel/boot.c
@@ -1132,7 +1132,7 @@ static void discover_nsec_memory(void)
 	const struct core_mmu_phys_mem *mem_begin =3D NULL;
 	const struct core_mmu_phys_mem *mem_end =3D NULL;
 	size_t nelems;
-	void *fdt =3D get_external_dt();
+	void *fdt =3D get_dt();
=20
 	if (fdt) {
 		mem =3D get_nsec_memory(fdt, &nelems);
--=20
2.17.1

-----Original Message-----
From: Etienne Carriere <etienne.carriere@linaro.org>=20
Sent: Monday, November 22, 2021 10:17 AM
To: John Linn <linnj@xilinx.com>; op-tee(a)lists.trustedfirmware.org
Subject: Fwd: Embedded DT (CFG_EMBED_DT) with dynamic shared memory (CFG_CORE=
_DYN_SHM) in optee-os

Hello John,

> From: John Linn <linnj@xilinx.com>
> Date: Thu, Nov 18, 2021 at 10:24 PM
> Subject: Embedded DT (CFG_EMBED_DT) with dynamic shared memory=20
> (CFG_CORE_DYN_SHM) in optee-os
> To: op-teeATlists.trustedfirmware.org=20
> <op-teeATlists.trustedfirmware.org>
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

Indeed the current implementation gets the main memory size from the external=
 non-secure DTB.
This memory is mainly REE memory and can tbe used  as shared memory.

It looks reasonable to get the same info from the embedded DTB instead but th=
e point to discuss, IMO, is whether the memory nodes of OP-TEE secure DT rela=
te to OP-TEE "secure memory" or to system-wide (possibly
non-secure) memory. In the former case, that information could not be used to=
 define the "non-secure shareable address ranges".
Feel free to create a P-R in optee_os for that purpose (something like try wi=
th embedded_dt() then fallback to external=C3=A8_dt()),

Regards,
Etienne


>
> Any hints or advice?
>
> Thanks
> John

--===============0793006235564281629==--

