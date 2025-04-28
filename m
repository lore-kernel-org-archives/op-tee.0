From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: optee: smc: remove unnecessary NULL check before
 release_firmware()
Date: Mon, 28 Apr 2025 07:36:43 +0200
Message-ID: 
 <CAHUa44EHpcn8g0Cg-nvg+DskvbD5PZzEg9b7N_Uj4VGF53NF2g@mail.gmail.com>
In-Reply-To: <aAnD4_WXl8gE2bGv@sumit-X1>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7886447849738561819=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============7886447849738561819==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:54=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Apr 10, 2025 at 03:56:35PM +0800, Chen Ni wrote:
> > release_firmware() checks for NULL pointers internally.
> > Remove unneeded NULL check for fmw here.
> >
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> > ---
> >  drivers/tee/optee/smc_abi.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index f0c3ac1103bb..26f8f7bbbe56 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -1551,8 +1551,7 @@ static int optee_load_fw(struct platform_device *pd=
ev,
> >                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> >       if (!rc)
> >               rc =3D res.a0;
> > -     if (fw)
> > -             release_firmware(fw);
> > +     release_firmware(fw);
> >       kfree(data_buf);
> >
> >       if (!rc) {
> > --
> > 2.25.1
> >

--===============7886447849738561819==--

