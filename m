From: Kees Cook <keescook@chromium.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Tue, 24 Nov 2020 13:25:40 -0800
Message-ID: <202011241324.B3439A2@keescook>
In-Reply-To: <
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8829101996104832044=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8829101996104832044==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2020 at 05:32:51PM -0800, Nick Desaulniers wrote:
> On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > > If none of the 140 patches here fix a real bug, and there is no change
> > > to machine code then it sounds to me like a W=3D2 kind of a warning.
> >
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=3Dg1mGry1fE5kvFFFrxzhPSM6qKAO8g=
xSp=3DKr_CQ(a)mail.gmail.com/
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

I still think this isn't right -- it's a case statement that runs off
the end without an explicit flow control determination. I think Clang is
right to warn for these, and GCC should also warn.

--=20
Kees Cook

--===============8829101996104832044==--

