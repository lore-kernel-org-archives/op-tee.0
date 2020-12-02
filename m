From: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
To: op-tee@lists.trustedfirmware.org
Subject: RE: [PATCH] optee: extend normal memory check to also write-through
Date: Wed, 02 Dec 2020 10:56:43 +0000
Message-ID: <AM6PR06MB4691D4988AC57DD24424D40CA6F30@AM6PR06MB4691.eurprd06.prod.outlook.com>
In-Reply-To: <
 <CAHUa44GLP0JZPnX9Z1b6rNkzMttBWRvOo7QLuySmAmqCQFvpdg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1418995751303611519=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1418995751303611519==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Jens,

> -----Original Message-----
> From: Jens Wiklander <jens.wiklander@linaro.org>
> Sent: Wednesday, December 2, 2020 11:44 AM
> To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
> Cc: op-tee(a)lists.trustedfirmware.org; Linux Kernel Mailing List <linux-
> kernel(a)vger.kernel.org>; stable(a)vger.kernel.org
> Subject: Re: [PATCH] optee: extend normal memory check to also write-through
>=20
>=20
> On Wed, Dec 2, 2020 at 10:41 AM ZHIZHIKIN Andrey <andrey.zhizhikin@leica-
> geosystems.com> wrote:
> >
> > Hello Jens,
> >
> > > -----Original Message-----
> > > From: Jens Wiklander <jens.wiklander@linaro.org>
> > > Sent: Wednesday, December 2, 2020 9:07 AM
> > > To: ZHIZHIKIN Andrey <andrey.zhizhikin@leica-geosystems.com>
> > > Cc: op-tee(a)lists.trustedfirmware.org; Linux Kernel Mailing List
> > > <linux- kernel@vger.kernel.org>; stable(a)vger.kernel.org
> > > Subject: Re: [PATCH] optee: extend normal memory check to also
> > > write-through
> > >
> > > This email is not from Hexagon=E2=80=99s Office 365 instance. Please be
> > > careful while clicking links, opening attachments, or replying to this =
email.
> > >
> > >
> > > Hi Andrey,
> > >
> > > On Wed, Dec 2, 2020 at 8:11 AM Andrey Zhizhikin
> > > <andrey.zhizhikin@leica- geosystems.com> wrote:
> > > >
> > > > ARMv7 Architecture Reference Manual [1] section A3.5.5 details
> > > > Normal memory type, together with cacheability attributes that
> > > > could be applied to memory regions defined as "Normal memory".
> > > >
> > > > Section B2.1.2 of the Architecture Reference Manual [1] also
> > > > provides details regarding the Memory attributes that could be
> > > > assigned to particular memory regions, which includes the
> > > > descrption of cacheability attributes and cache allocation hints.
> > > >
> > > > Memory type and cacheability attributes forms 2 separate
> > > > definitions, where cacheability attributes defines a mechanism of
> > > > coherency control rather than the type of memory itself.
> > > >
> > > > In other words: Normal memory type can be configured with several
> > > > combination of cacheability attributes, namely:
> > > > - Write-Through (WT)
> > > > - Write-Back (WB) followed by cache allocation hint:
> > > >   - Write-Allocate
> > > >   - No Write-Allocate (also known as Read-Allocate)
> > > >
> > > > Those types are mapped in the kernel to corresponding macros:
> > > > - Write-Through: L_PTE_MT_WRITETHROUGH
> > > > - Write-Back Write-Allocate: L_PTE_MT_WRITEALLOC
> > > > - Write-Back Read-Allocate: L_PTE_MT_WRITEBACK
> > > >
> > > > Current implementation of the op-tee driver takes in account only
> > > > 2 last memory region types, while performing a check if the memory
> > > > block is allocated as "Normal memory", leaving Write-Through
> > > > allocations to be not considered.
> > > >
> > > > Extend verification mechanism to include also Normal memory
> > > > regios, which are designated with Write-Through cacheability attribut=
es.
> > >
> > > Are you trying to fix a real error with this or are you just trying
> > > to cover all cases? I suspect the latter since you'd likely have
> > > coherency problems with OP-TEE in Secure world if you used Write-Through
> instead.
> >
> > Yes, this aims to provide consistency in detection which memory blocks
> > can be identified as Normal memory in ARMv7 architecture.
>=20
> I think you're missing the purpose of this internal function. It's there to=
 check that
> the memory is mapped in a way compatible with what OP-TEE is using in Secure
> world.

OK, now it's clear! Then it is more a matter of is_normal_memory() function n=
ame, which
is mis-leading. I was under impression that this function (at least from its =
name) is
verifying that the memory block is considered as Normal memory in terms of AR=
Mv7
architecture, but it is rather a check if the memory block is *usable* for th=
e OP-TEE
purposes.

If that is the case - you can drop this patch altogether, but I believe that =
the function
name should be changed to reflect the actual purpose to avoid future confusio=
ns.

Does that sound reasonable?

>=20
> >
> > WT coherency control and (especially) observability behavior is
> > described in section A3.5.5 of the
> > ARMv7 RefMan, where it is stated that write operations performed on WT
> > memory locations are guaranteed to be visible to all observers inside and
> outside of cache level.
> >
> > As the Write-Through (WT) provides a better coherency control, it does
> > make sense to include it into the verification performed by
> > is_normal_memory() in order to provide a possibility for future
> > implementations to mitigate issues and select appropriate cache allocation
> attributes for memory blocks used.
> >
> > > Correct me if I'm wrong, but "Write-Back Write-Allocate" and "Write-Back
> Read-Allocate"
> > > are both compatible with each other as the "Allocate" part is just a hi=
nt.
> >
> > Correct, "Allocate" just designates the cache allocation hint.
> > "Write-Back Read-Allocate" should actually be read as "Write-Back no
> > Write-Allocate", with " Write-Allocate" being a hint. But since this
> > is controlled by a TEX[0] - this hint is handled separately by
> L_PTE_MT_WRITEBACK and L_PTE_MT_WRITEALLOC macros.
>=20
> B3.11.3 in the spec requires cache maintenance when changing from Write-Back
> to Write-Through and vice versa, and we can't do that in this design.

Correct. My expectation here would be that the cache allocation policy change=
 should
be accompanies by explicit cache maintenance operation *before* it is submitt=
ed to
the driver, but that might not be how it is designed.

>=20
> Cheers,
> Jens
>=20
> >
> > >
> > > Cheers,
> > > Jens
> > >
> > > >
> > > > Link: [1]:
> > > > https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> > > > deve
> > > >
> > >
> loper.arm.com%2Fdocumentation%2Fddi0406%2Fcd&amp;data=3D04%7C01%7C%7
> > > Ca40
> > > >
> > >
> ffd35912f4fe3d97308d896993b87%7C1b16ab3eb8f64fe39f3e2db7fe549f6a%7C0
> > > %
> > > 7
> > > >
> > >
> C1%7C637424932169074654%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> > > MDAiLC
> > > >
> > >
> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3Dc0jK2g
> > > T
> > > m
> > > > qrAyo0%2Ffr07t%2Fg5NbPdm4dh7Rl7alNWlaQc%3D&amp;reserved=3D0
> > > > Fixes: 853735e40424 ("optee: add writeback to valid memory type")
> > > > Cc: stable(a)vger.kernel.org
> > > > Signed-off-by: Andrey Zhizhikin
> > > > <andrey.zhizhikin@leica-geosystems.com>
> > > > ---
> > > >  drivers/tee/optee/call.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > > > index
> > > > c981757ba0d4..8da27d02a2d6 100644
> > > > --- a/drivers/tee/optee/call.c
> > > > +++ b/drivers/tee/optee/call.c
> > > > @@ -535,7 +535,8 @@ static bool is_normal_memory(pgprot_t p)  {
> > > > #if
> > > > defined(CONFIG_ARM)
> > > >         return (((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D
> > > > L_PTE_MT_WRITEALLOC)
> > > ||
> > > > -               ((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D L_PTE_MT_WRIT=
EBACK));
> > > > +               ((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D L_PTE_MT_WRIT=
EBACK)
> ||
> > > > +               ((pgprot_val(p) & L_PTE_MT_MASK) =3D=3D
> > > > + L_PTE_MT_WRITETHROUGH));
> > > >  #elif defined(CONFIG_ARM64)
> > > >         return (pgprot_val(p) & PTE_ATTRINDX_MASK) =3D=3D
> > > > PTE_ATTRINDX(MT_NORMAL);  #else
> > > > --
> > > > 2.17.1
> > > >
> >
> > Regards,
> > Andrey

Regards,
Andrey

--===============1418995751303611519==--

