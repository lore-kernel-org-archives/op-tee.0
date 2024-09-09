From: Ulf Hansson <ulf.hansson@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH next] optee: Fix a NULL vs IS_ERR() check
Date: Mon, 09 Sep 2024 12:24:29 +0200
Message-ID: 
 <CAPDyKFoe+_m8VLWFdB_jgv915WcyLbjkFJq_Regb1qXwQaVchQ@mail.gmail.com>
In-Reply-To: <
 <CAHUa44H4XHOxn_=TxTUM=S6oqUNL6-kVVU2=jFPZyobzmtbQPg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4933660012703686599=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4933660012703686599==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sept 2024 at 16:09, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Thu, Sep 5, 2024 at 3:17=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
> >
> > The tee_shm_get_va() function never returns NULL, it returns error
> > pointers.  Update the check to match.
> >
> > Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/tee/optee/rpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index a4b49fd1d46d..ebbbd42b0e3e 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -332,7 +332,7 @@ static void handle_rpc_func_rpmb_probe_next(struct te=
e_context *ctx,
> >         }
> >         buf =3D tee_shm_get_va(params[1].u.memref.shm,
> >                              params[1].u.memref.shm_offs);
> > -       if (!buf) {
> > +       if (IS_ERR(buf)) {
> >                 arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> >                 return;
> >         }
> > --
> > 2.45.2
> >
>
> Good catch.
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> Ulf, this is a fix for a patch in your next tree so if you could pick
> up this patch, please.
>
> Thanks,
> Jens

Patch applied to the next branch to my mmc tree, thanks!

Kind regards
Uffe

--===============4933660012703686599==--

