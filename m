From: Dan Carpenter <dan.carpenter@oracle.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Date: Tue, 01 Dec 2020 17:08:49 +0300
Message-ID: <20201201140849.GH2767@kadam>
In-Reply-To: <
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3351683399050253062=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3351683399050253062==
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

This should not generate a warning.

>=20
> I have a patch that fixes those up for clang:
> https://reviews.llvm.org/D91895
>=20
> There's 3 other cases that don't quite match between GCC and Clang I
> observe in the kernel:
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     goto y;
> }
> y:;

This should generate a warning.

>=20
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     return;
> }

Warn for this.


>=20
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     ;
> }

Don't warn for this.

If adding a break statement changes the flow of the code then warn about
potentially missing break statements, but if it doesn't change anything
then don't warn about it.

regards,
dan carpenter

--===============3351683399050253062==--

