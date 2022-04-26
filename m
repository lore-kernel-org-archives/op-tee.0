From: Jens Wiklander <jens.wiklander@linaro.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 1/2] tee: remove tee_shm_va2pa() and tee_shm_pa2va()
Date: Tue, 26 Apr 2022 10:20:56 +0200
Message-ID: 
 <CAHUa44HMbsthyH1FN-Ug3ArGCApWtWT=H4D1qKk-PTKRsyJPBw@mail.gmail.com>
In-Reply-To: <20220425141617.23925-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3875278546421146737=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3875278546421146737==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 25, 2022 at 4:16 PM Andrew Davis <afd@ti.com> wrote:
>
> We should not need to index into SHMs based on absolute VA/PA.
> These functions are not used and this kind of usage should not be
> encouraged anyway. Remove these functions.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_shm.c   | 50 -----------------------------------------
>  include/linux/tee_drv.h | 18 ---------------
>  2 files changed, 68 deletions(-)

Looks good to me, I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index f31e29e8f1cac..b0c6d553d3a70 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -414,56 +414,6 @@ void tee_shm_free(struct tee_shm *shm)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_free);
>
> -/**
> - * tee_shm_va2pa() - Get physical address of a virtual address
> - * @shm:       Shared memory handle
> - * @va:                Virtual address to tranlsate
> - * @pa:                Returned physical address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
> -{
> -       if (!shm->kaddr)
> -               return -EINVAL;
> -       /* Check that we're in the range of the shm */
> -       if ((char *)va < (char *)shm->kaddr)
> -               return -EINVAL;
> -       if ((char *)va >=3D ((char *)shm->kaddr + shm->size))
> -               return -EINVAL;
> -
> -       return tee_shm_get_pa(
> -                       shm, (unsigned long)va - (unsigned long)shm->kaddr,=
 pa);
> -}
> -EXPORT_SYMBOL_GPL(tee_shm_va2pa);
> -
> -/**
> - * tee_shm_pa2va() - Get virtual address of a physical address
> - * @shm:       Shared memory handle
> - * @pa:                Physical address to tranlsate
> - * @va:                Returned virtual address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
> -{
> -       if (!shm->kaddr)
> -               return -EINVAL;
> -       /* Check that we're in the range of the shm */
> -       if (pa < shm->paddr)
> -               return -EINVAL;
> -       if (pa >=3D (shm->paddr + shm->size))
> -               return -EINVAL;
> -
> -       if (va) {
> -               void *v =3D tee_shm_get_va(shm, pa - shm->paddr);
> -
> -               if (IS_ERR(v))
> -                       return PTR_ERR(v);
> -               *va =3D v;
> -       }
> -       return 0;
> -}
> -EXPORT_SYMBOL_GPL(tee_shm_pa2va);
> -
>  /**
>   * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
>   * @shm:       Shared memory handle
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 911cad324acc7..17eb1c5205d34 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -298,24 +298,6 @@ void tee_shm_free(struct tee_shm *shm);
>   */
>  void tee_shm_put(struct tee_shm *shm);
>
> -/**
> - * tee_shm_va2pa() - Get physical address of a virtual address
> - * @shm:       Shared memory handle
> - * @va:                Virtual address to tranlsate
> - * @pa:                Returned physical address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa);
> -
> -/**
> - * tee_shm_pa2va() - Get virtual address of a physical address
> - * @shm:       Shared memory handle
> - * @pa:                Physical address to tranlsate
> - * @va:                Returned virtual address
> - * @returns 0 on success and < 0 on failure
> - */
> -int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va);
> -
>  /**
>   * tee_shm_get_va() - Get virtual address of a shared memory plus an offset
>   * @shm:       Shared memory handle
> --
> 2.17.1
>

--===============3875278546421146737==--

