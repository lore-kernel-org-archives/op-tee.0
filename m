From: Etienne Carriere <etienne.carriere@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v6 1/4] tee: optee: system call property
Date: Thu, 11 May 2023 09:20:35 +0200
Message-ID: 
 <CAN5uoS_0pF=-9=gznYUOU9oWPKz8HkRb=6gTAumMv=Vey8qb0g@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPL9MadOp1DYcMWcjD34wnwD+bRVtBmHS+hR=976HsopA@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0739204107858697579=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0739204107858697579==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 May 2023 at 08:03, Sumit Garg <sumit.garg@linaro.org> wrote:
> (snip)
> > > >
> > > >  int optee_invoke_func(struct tee_context *ctx, struct tee_ioctl_invo=
ke_arg *arg,
> > > > @@ -408,12 +412,15 @@ int optee_invoke_func(struct tee_context *ctx, =
struct tee_ioctl_invoke_arg *arg,
> > > >         struct optee_msg_arg *msg_arg;
> > > >         struct optee_session *sess;
> > > >         struct tee_shm *shm;
> > > > +       bool system_thread;
> > > >         u_int offs;
> > > >         int rc;
> > > >
> > > >         /* Check that the session is valid */
> > > >         mutex_lock(&ctxdata->mutex);
> > > >         sess =3D find_session(ctxdata, arg->session);
> > > > +       if (sess)
> > >
> > > This check is redundant if we move the assignment below...
> >
> > Here we change the sesssion attribute while the mutex is locked, in
> > case some equivalent call with that session is issued.
> > Below we return to caller once mutex is unlocked.
> > I think it is the safer behavior. What do you think?
>
> Aren't we only reading session attribute in order to capture value in
> a local variable: system_thread? I don't think that it would require a
> mutex.

optee_system_session() sets session::use_sys_thread with mutex locked
hence I think we should get the attribute with the mutex locked.
See "[PATCH v6 3/4] tee: optee: support tracking system threads".

Etienne

>
> -Sumit
>
> >
> > Best regards,
> > Etienne
> >
> > >
> > > > +               system_thread =3D sess->use_sys_thread;
> > > >         mutex_unlock(&ctxdata->mutex);
> > > >         if (!sess)
> > > >                 return -EINVAL;
> > >
> > > ...here as:
> > >            system_thread =3D sess->use_sys_thread;
> > > (snip)

--===============0739204107858697579==--

