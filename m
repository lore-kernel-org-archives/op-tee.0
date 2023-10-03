From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/1] tee: amdtee: fix use-after-free vulnerability in
 amdtee_close_session
Date: Tue, 03 Oct 2023 19:18:27 +0200
Message-ID: 
 <CAHUa44HLnuuv2k+rVsMecHwDPFYD8yViVKn++fnqT99UEG0_Ow@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYN9xHUmxrJJM_o1P-gcfYS=UrBQXEO7w4Nt9g=xErbxrQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1613227250888598384=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1613227250888598384==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 3, 2023 at 7:14=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> w=
rote:
>
> On Fri, 29 Sept 2023 at 12:30, Rijo Thomas <Rijo-john.Thomas@amd.com> wro=
te:
> >
> > There is a potential race condition in amdtee_close_session that may
> > cause use-after-free in amdtee_open_session. For instance, if a session
> > has refcount =3D=3D 1, and one thread tries to free this session via:
> >
> >     kref_put(&sess->refcount, destroy_session);
> >
> > the reference count will get decremented, and the next step would be to
> > call destroy_session(). However, if in another thread,
> > amdtee_open_session() is called before destroy_session() has completed
> > execution, alloc_session() may return 'sess' that will be freed up
> > later in destroy_session() leading to use-after-free in
> > amdtee_open_session.
> >
> > To fix this issue, treat decrement of sess->refcount and removal of
> > 'sess' from session list in destroy_session() as a critical section, so
> > that it is executed atomically.
> >
> > Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> > Cc: stable(a)vger.kernel.org
> > Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> > ---
> > v2:
> > * Introduced kref_put_mutex() as suggested by Sumit Garg.
> >
> >  drivers/tee/amdtee/core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>


I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> > index 372d64756ed6..3c15f6a9e91c 100644
> > --- a/drivers/tee/amdtee/core.c
> > +++ b/drivers/tee/amdtee/core.c
> > @@ -217,12 +217,12 @@ static int copy_ta_binary(struct tee_context *ctx, =
void *ptr, void **ta,
> >         return rc;
> >  }
> >
> > +/* mutex must be held by caller */
> >  static void destroy_session(struct kref *ref)
> >  {
> >         struct amdtee_session *sess =3D container_of(ref, struct amdtee_s=
ession,
> >                                                    refcount);
> >
> > -       mutex_lock(&session_list_mutex);
> >         list_del(&sess->list_node);
> >         mutex_unlock(&session_list_mutex);
> >         kfree(sess);
> > @@ -272,7 +272,8 @@ int amdtee_open_session(struct tee_context *ctx,
> >         if (arg->ret !=3D TEEC_SUCCESS) {
> >                 pr_err("open_session failed %d\n", arg->ret);
> >                 handle_unload_ta(ta_handle);
> > -               kref_put(&sess->refcount, destroy_session);
> > +               kref_put_mutex(&sess->refcount, destroy_session,
> > +                              &session_list_mutex);
> >                 goto out;
> >         }
> >
> > @@ -290,7 +291,8 @@ int amdtee_open_session(struct tee_context *ctx,
> >                 pr_err("reached maximum session count %d\n", TEE_NUM_SESS=
IONS);
> >                 handle_close_session(ta_handle, session_info);
> >                 handle_unload_ta(ta_handle);
> > -               kref_put(&sess->refcount, destroy_session);
> > +               kref_put_mutex(&sess->refcount, destroy_session,
> > +                              &session_list_mutex);
> >                 rc =3D -ENOMEM;
> >                 goto out;
> >         }
> > @@ -331,7 +333,7 @@ int amdtee_close_session(struct tee_context *ctx, u32=
 session)
> >         handle_close_session(ta_handle, session_info);
> >         handle_unload_ta(ta_handle);
> >
> > -       kref_put(&sess->refcount, destroy_session);
> > +       kref_put_mutex(&sess->refcount, destroy_session, &session_list_mu=
tex);
> >
> >         return 0;
> >  }
> > --
> > 2.25.1
> >

--===============1613227250888598384==--

