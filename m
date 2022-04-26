From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 2/2] tee: remove flags TEE_IOCTL_SHM_MAPPED and
 TEE_IOCTL_SHM_DMA_BUF
Date: Tue, 26 Apr 2022 10:21:53 +0200
Message-ID: 
 <CAHUa44H34Wh-Hpw9LzSS3KsKYethLMo_ih+9BafWCvW_TDU=3Q@mail.gmail.com>
In-Reply-To: <
 <CAFA6WYN7GG6ZgxQ=AMinZ91f7QDh+aEPhL-Obx1s=zqReViAew@mail.gmail.com>>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3288069368320373485=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3288069368320373485==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 4:18 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Mon, 25 Apr 2022 at 19:46, Andrew Davis <afd@ti.com> wrote:
> >
> > These look to be leftover from an early edition of this driver. Userspace
> > does not need this information. Checking all users of this that I have
> > access to I have verified no one is using them.
> >
> > They leak internal use flags out to userspace. Even more they are not
> > correct anymore after a45ea4efa358. Lets drop these flags before
> > someone does try to use them for something and they become ABI.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
> >
> > Changes from v1:
> >  - Removed flags return from tee_ioctl_shm_alloc()
> >
>
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
>
> -Sumit
>
> >  drivers/tee/tee_core.c   | 2 --
> >  include/uapi/linux/tee.h | 4 ----
> >  2 files changed, 6 deletions(-)


Looks good to me, I'm picking up this.

Thanks,
Jens

> >
> > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > index 8aa1a4836b92f..af0f7c603fa46 100644
> > --- a/drivers/tee/tee_core.c
> > +++ b/drivers/tee/tee_core.c
> > @@ -302,7 +302,6 @@ static int tee_ioctl_shm_alloc(struct tee_context *ct=
x,
> >                 return PTR_ERR(shm);
> >
> >         data.id =3D shm->id;
> > -       data.flags =3D shm->flags;
> >         data.size =3D shm->size;
> >
> >         if (copy_to_user(udata, &data, sizeof(data)))
> > @@ -339,7 +338,6 @@ tee_ioctl_shm_register(struct tee_context *ctx,
> >                 return PTR_ERR(shm);
> >
> >         data.id =3D shm->id;
> > -       data.flags =3D shm->flags;
> >         data.length =3D shm->size;
> >
> >         if (copy_to_user(udata, &data, sizeof(data)))
> > diff --git a/include/uapi/linux/tee.h b/include/uapi/linux/tee.h
> > index 25a6c534beb1b..23e57164693c4 100644
> > --- a/include/uapi/linux/tee.h
> > +++ b/include/uapi/linux/tee.h
> > @@ -42,10 +42,6 @@
> >  #define TEE_IOC_MAGIC  0xa4
> >  #define TEE_IOC_BASE   0
> >
> > -/* Flags relating to shared memory */
> > -#define TEE_IOCTL_SHM_MAPPED   0x1     /* memory mapped in normal world =
*/
> > -#define TEE_IOCTL_SHM_DMA_BUF  0x2     /* dma-buf handle on shared memor=
y */
> > -
> >  #define TEE_MAX_ARG_SIZE       1024
> >
> >  #define TEE_GEN_CAP_GP         (1 << 0)/* GlobalPlatform compliant TEE */
> > --
> > 2.17.1
> >

--===============3288069368320373485==--

