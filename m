From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 13:22:51 +0530
Message-ID: 
 <CAFA6WYO+AvnbuAdWyBAQ8HkLaOno7PXdsPb9SubxrGNvAm4UnQ@mail.gmail.com>
In-Reply-To: <ZGSDoVKKVqCkbaCB@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0510598666725612315=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0510598666725612315==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2023 at 13:04, Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     u32 page_flag =3D FOLL_WRITE;
> >
> >       if (!tee_device_get(teedev))
> >               return ERR_PTR(-EINVAL);
> > @@ -255,9 +256,11 @@ register_shm_helper(struct tee_context *ctx, unsigne=
d long addr,
> >               ret =3D ERR_PTR(-ENOMEM);
> >               goto err_free_shm;
> >       }
> > -
> > +#if IS_ENABLED(CONFIG_CMA)
> > +     page_flag |=3D FOLL_LONGTERM;
> > +#endif
> >       if (flags & TEE_SHM_USER_MAPPED)
>
> If this mapping is long live it should always use FOLL_LONGTERM.

It depends on the userspace application needs. However, I think it
should be safe to use FOLL_LONGTERM by default to serve cases like
secure media playback.

>
> The ifdef does not make sense.

Agree.

-Sumit

--===============0510598666725612315==--

