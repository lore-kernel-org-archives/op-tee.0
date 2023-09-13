From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH -next] tee: Remove unused declarations
Date: Wed, 13 Sep 2023 10:39:28 +0200
Message-ID: 
 <CAHUa44Gfz8OBm6WEROeKt00O-vj6FtM5f5GXVRHXxF1Vs+i5mQ@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYPsaJdGT9kS4ygHNRYDpX8bRaY__EwZWuCF-x-DgWUDhQ@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5841443944522955639=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5841443944522955639==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 12:11=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Thu, 10 Aug 2023 at 20:19, Yue Haibing <yuehaibing@huawei.com> wrote:
> >
> > Commit 4fb0a5eb364d ("tee: add OP-TEE driver") declared but never impleme=
nted
> > optee_supp_read()/optee_supp_write().
> > Commit 967c9cca2cc5 ("tee: generic TEE subsystem") never implemented tee_=
shm_init().
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > ---
> >  drivers/tee/optee/optee_private.h | 2 --
> >  drivers/tee/tee_private.h         | 2 --
> >  2 files changed, 4 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_=
private.h
> > index 72685ee0d53f..6bb5cae09688 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -238,8 +238,6 @@ int optee_notif_send(struct optee *optee, u_int key);
> >  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_pa=
rams,
> >                         struct tee_param *param);
> >
> > -int optee_supp_read(struct tee_context *ctx, void __user *buf, size_t le=
n);
> > -int optee_supp_write(struct tee_context *ctx, void __user *buf, size_t l=
en);
> >  void optee_supp_init(struct optee_supp *supp);
> >  void optee_supp_uninit(struct optee_supp *supp);
> >  void optee_supp_release(struct optee_supp *supp);
> > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > index 409cadcc1cff..754e11dcb240 100644
> > --- a/drivers/tee/tee_private.h
> > +++ b/drivers/tee/tee_private.h
> > @@ -47,8 +47,6 @@ struct tee_device {
> >         struct tee_shm_pool *pool;
> >  };
> >
> > -int tee_shm_init(void);
> > -
> >  int tee_shm_get_fd(struct tee_shm *shm);
> >
> >  bool tee_device_get(struct tee_device *teedev);
> > --
> > 2.34.1
> >

--===============5841443944522955639==--

