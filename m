From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: Fix typo Unuspported -> Unsupported
Date: Wed, 15 Mar 2023 07:49:31 +0100
Message-ID: 
 <CAHUa44Hf1YysCX8ountu5ZZh+9aFeuwupNh8Kb1fMFpAnpLaXg@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPGF3Q=_U-rZGyyH=ouunwT=9nx7j+pueCVS5jLng4fxA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1813281390063829912=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1813281390063829912==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2023 at 6:39=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 22 Feb 2023 at 23:00, Jules Maselbas <jmaselbas@kalray.eu> wrote:
> >
> > Fix typo Unuspported -> Unsupported
> >
> > Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> > ---
> >  drivers/tee/optee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> > index 290b1bb0e9cd..df5fb5410b72 100644
> > --- a/drivers/tee/optee/call.c
> > +++ b/drivers/tee/optee/call.c
> > @@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
> >  #elif defined(CONFIG_ARM64)
> >         return (pgprot_val(p) & PTE_ATTRINDX_MASK) =3D=3D PTE_ATTRINDX(MT=
_NORMAL);
> >  #else
> > -#error "Unuspported architecture"
> > +#error "Unsupported architecture"
> >  #endif
> >  }
> >
> > --
> > 2.17.1
> >

--===============1813281390063829912==--

