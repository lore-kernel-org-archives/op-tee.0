From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] optee: add error checks in optee_ffa_do_call_with_arg()
Date: Thu, 20 Jan 2022 08:16:40 +0100
Message-ID: 
 <CAHUa44EYeRy-xzmCvp5g276s4CT+wGBPR_cGDDBtjuzeeERSfw@mail.gmail.com>
In-Reply-To: <bf3c1583f8d7466a96bab8feb462bb36@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6317494370818875624=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============6317494370818875624==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2022 at 3:18 PM David Laight <David.Laight@aculab.com> wrot=
e:
>
> From: Jens Wiklander
> > Sent: 19 January 2022 08:08
> >
> > Adds error checking in optee_ffa_do_call_with_arg() for correctness.
> >
> > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > index d8c8683863aa..d88bd2e41572 100644
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_con=
text *ctx,
> >               .data2 =3D (u32)(shm->sec_world_id >> 32),
> >               .data3 =3D shm->offset,
> >       };
> > -     struct optee_msg_arg *arg =3D tee_shm_get_va(shm, 0);
> > -     unsigned int rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_param=
s);
> > -     struct optee_msg_arg *rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
> > +     struct optee_msg_arg *arg;
> > +     unsigned int rpc_arg_offs;
> > +     struct optee_msg_arg *rpc_arg;
> > +
> > +     arg =3D tee_shm_get_va(shm, 0);
> > +     if (IS_ERR(arg))
> > +             return PTR_ERR(arg);
> > +
> > +     rpc_arg_offs =3D OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> > +     rpc_arg =3D tee_shm_get_va(shm, rpc_arg_offs);
> > +     if (IS_ERR(arg))
> > +             return PTR_ERR(arg);
>
> What's this duplicate test for?

Oh, that's a copy & paste error, I should have tested rpc_arg here.
I'll fix it in the V2.

Thanks,
Jens

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
> Registration No: 1397386 (Wales)
>

--===============6317494370818875624==--

