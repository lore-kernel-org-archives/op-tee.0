From: Jakub Kicinski <kuba@kernel.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Mon, 23 Nov 2020 17:46:48 -0800
Message-ID: 
 <20201123174648.6a22575b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0173192636075307743=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0173192636075307743==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Nov 2020 17:32:51 -0800 Nick Desaulniers wrote:
> On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote: =20
> > > If none of the 140 patches here fix a real bug, and there is no change
> > > to machine code then it sounds to me like a W=3D2 kind of a warning. =20
> >
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=3Dg1mGry1fE5kvFFFrxzhPSM6qKAO8g=
xSp=3DKr_CQ(a)mail.gmail.com/ =20
>=20
> So looks like the bulk of these are:
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     break;
> }
>=20
> I have a patch that fixes those up for clang:
> https://reviews.llvm.org/D91895

=F0=9F=98=8D

--===============0173192636075307743==--

