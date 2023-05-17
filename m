From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH] tee: add FOLL_LONGTERM for CMA case when alloc shm
Date: Wed, 17 May 2023 00:34:57 -0700
Message-ID: <ZGSDoVKKVqCkbaCB@infradead.org>
In-Reply-To: <20230517031856.19660-1-xiaoming.ding@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2539927500779747625=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2539927500779747625==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> +	u32 page_flag =3D FOLL_WRITE;
> =20
>  	if (!tee_device_get(teedev))
>  		return ERR_PTR(-EINVAL);
> @@ -255,9 +256,11 @@ register_shm_helper(struct tee_context *ctx, unsigned =
long addr,
>  		ret =3D ERR_PTR(-ENOMEM);
>  		goto err_free_shm;
>  	}
> -
> +#if IS_ENABLED(CONFIG_CMA)
> +	page_flag |=3D FOLL_LONGTERM;
> +#endif
>  	if (flags & TEE_SHM_USER_MAPPED)

If this mapping is long live it should always use FOLL_LONGTERM.

The ifdef does not make sense.

--===============2539927500779747625==--

