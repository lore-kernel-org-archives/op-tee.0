From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: Embedded DT (CFG_EMBED_DT) with dynamic shared memory
 (CFG_CORE_DYN_SHM) in optee-os
Date: Tue, 30 Nov 2021 08:30:21 +0100
Message-ID: 
 <CAN5uoS9FTXHmFH8-LZvrAnVXrnf+1MOT0z=qh=o5SFGTfHVipA@mail.gmail.com>
In-Reply-To: <=?utf-8?q?=3CDM8PR02MB81539F3A9381A439C3FAAEC5D8669=40DM8PR02MB?=
 =?utf-8?q?8153=2Enamprd02=2Eprod=2Eoutlook=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8363447261627435269=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8363447261627435269==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello John,


On Mon, 29 Nov 2021 at 15:22, John Linn <linnj@xilinx.com> wrote:
>
> Hi Etienne,
>
> I can add a P-R in optee_os.

Yes please, do so. A P-R is the best place to get feedback from OP-TEE
community.

>
> Based on my quick testing it appears to be a simple one line change unless =
I've overlooked something.

I have few comments on the change that I think should be discussed
with maintainers.
With that change, memory nodes are can be read from the embedded DTB.
The memory node(s) are expected to define system memory. In the scope
of the OP-TEE core DTB, do they relate to OP-TEE (secure) memory or to
both secure and non-somemory. In that case, how should core
differentiate memory assigned to OP-TEE (secure + possibly
reserved-shm) and memory assigned to REE (non-secure)?


Regards,
Etienne

>
> Thanks
> John
>
> core/arch/arm/kernel/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/core/arch/arm/kernel/boot.c b/core/arch/arm/kernel/boot.c
> index 09c1b811..58bf50cd 100644
> --- a/core/arch/arm/kernel/boot.c
> +++ b/core/arch/arm/kernel/boot.c
> @@ -1132,7 +1132,7 @@ static void discover_nsec_memory(void)
>         const struct core_mmu_phys_mem *mem_begin =3D NULL;
>         const struct core_mmu_phys_mem *mem_end =3D NULL;
>         size_t nelems;
> -       void *fdt =3D get_external_dt();
> +       void *fdt =3D get_dt();
>
>         if (fdt) {
>                 mem =3D get_nsec_memory(fdt, &nelems);
> --
> 2.17.1
>
> -----Original Message-----
> From: Etienne Carriere <etienne.carriere@linaro.org>
> Sent: Monday, November 22, 2021 10:17 AM
> To: John Linn <linnj@xilinx.com>; op-tee(a)lists.trustedfirmware.org
> Subject: Fwd: Embedded DT (CFG_EMBED_DT) with dynamic shared memory (CFG_CO=
RE_DYN_SHM) in optee-os
>
> Hello John,
>
> > From: John Linn <linnj@xilinx.com>
> > Date: Thu, Nov 18, 2021 at 10:24 PM
> > Subject: Embedded DT (CFG_EMBED_DT) with dynamic shared memory
> > (CFG_CORE_DYN_SHM) in optee-os
> > To: op-teeATlists.trustedfirmware.org
> > <op-teeATlists.trustedfirmware.org>
> >
> >
> > It appears that dynamic shared memory does not work with an embedded DT, =
but I'm likely missing something. I have it working fine with an external DT.
> >
> > There is a bit of interaction in kernel/boot.c with the two configuration=
 options and my testing is not seeing it work with 3.14 and master looks the =
same viewing it.
> >
> > get_external_fdt() is called which does not work with the embedded DT it =
appears to me.
>
> Indeed the current implementation gets the main memory size from the extern=
al non-secure DTB.
> This memory is mainly REE memory and can tbe used  as shared memory.
>
> It looks reasonable to get the same info from the embedded DTB instead but =
the point to discuss, IMO, is whether the memory nodes of OP-TEE secure DT re=
late to OP-TEE "secure memory" or to system-wide (possibly
> non-secure) memory. In the former case, that information could not be used =
to define the "non-secure shareable address ranges".
> Feel free to create a P-R in optee_os for that purpose (something like try =
with embedded_dt() then fallback to external=C3=A8_dt()),
>
> Regards,
> Etienne
>
>
> >
> > Any hints or advice?
> >
> > Thanks
> > John

--===============8363447261627435269==--

