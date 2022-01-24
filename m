From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] optee: add error checks in optee_ffa_do_call_with_arg()
Date: Mon, 24 Jan 2022 12:54:56 +0100
Message-ID: 
 <CAHUa44Gtwwx4+8QS9UiVGp+2FnZuPjFnZaZ+_Tt8VJnq308gQA@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYO=9Rw7R+QEgunjtdM=63L1AzYxx26452=+uj7SuPiE7Q@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0439941303787935178=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0439941303787935178==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 20, 2022 at 12:18 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 20 Jan 2022 at 13:12, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > Adds error checking in optee_ffa_do_call_with_arg() for correctness.
> >
> > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index 20a1b1a3d965..0775759a29c0 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_con=
text *ctx,
> >                 .data2 =3D (u32)(shm->sec_world_id >> 32),
> >                 .data3 =3D shm->offset,
> >         };
> > -       struct optee_msg_arg *arg =3D tee_shm_get_va(shm, 0);
> > -       unsigned int rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_par=
ams);
> > -       struct optee_msg_arg *rpc_arg =3D tee_shm_get_va(shm, rpc_arg_off=
s);
> > +       struct optee_msg_arg *arg;
> > +       unsigned int rpc_arg_offs;
> > +       struct optee_msg_arg *rpc_arg;
> > +
> > +       arg =3D tee_shm_get_va(shm, 0);
> > +       if (IS_ERR(arg))
> > +               return PTR_ERR(arg);
> > +
> > +       rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> > +       rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
> > +       if (IS_ERR(rpc_arg))
> > +               return PTR_ERR(rpc_arg);
> >
> >         return optee_ffa_yielding_call(ctx, &data, rpc_arg);
> >  }
> > --
> > 2.31.1
> >

--===============0439941303787935178==--

