From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: client UUID: Skip REE kernel login method as well
Date: Thu, 08 Oct 2020 07:53:57 +0200
Message-ID: 
 <CAHUa44FPG3kx3DBr-cZKttwH0_L-1=bTGoz6y7Mjj6WS3VKBdw@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYOg53-UVLM22oD9Mj5kqmsOnsr55abrSviscYnfXGP7rg@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1327455829579275468=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1327455829579275468==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sumit,

On Wed, Oct 7, 2020 at 11:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Thu, 17 Sep 2020 at 19:10, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Since the addition of session's client UUID generation via commit [1],
> > login via REE kernel method was disallowed. So fix that via passing
> > nill UUID in case of TEE_IOCTL_LOGIN_REE_KERNEL method as well.
> >
> > Fixes: e33bcbab16d1 ("tee: add support for session's client UUID generati=
on") [1]
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tee/tee_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
>
> Would you like to pick up this fix?

Thanks for the reminder.
This looks good to me. I'll pick up this unless someone objects.
Vesa, does this look good to you too?

Cheers,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 64637e0..2f6199e 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -200,7 +200,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 co=
nnection_method,
> >         int name_len;
> >         int rc;
> >
> > -       if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC) {
> > +       if (connection_method =3D=3D TEE_IOCTL_LOGIN_PUBLIC ||
> > +           connection_method =3D=3D TEE_IOCTL_LOGIN_REE_KERNEL) {
> >                 /* Nil UUID to be passed to TEE environment */
> >                 uuid_copy(uuid, &uuid_null);
> >                 return 0;
> > --
> > 2.7.4
> >

--===============1327455829579275468==--

