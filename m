From: Rijo Thomas <Rijo-john.Thomas@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2 1/2] tee: amdtee: use page_alloc_exact() for memory allocations
Date: Wed, 04 Oct 2023 16:29:41 +0530
Message-ID: <0ad21a06-7a64-7d71-16f6-0bded64b6921@amd.com>
In-Reply-To: <=?utf-8?q?=3Cfe6fd7781d77ea32064e5b861f33150b28768278=2E1693340?=
 =?utf-8?q?098=2Egit=2EDevaraj=2ERangasamy=40amd=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3817219570842134048=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3817219570842134048==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 8/30/2023 1:49 AM, Devaraj Rangasamy wrote:
> Use page_alloc_exact() to get buffers, instead of
> get_free_pages(), so as to avoid wastage of memory.
> Currently get_free_pages() is allocating at next order,
> while page_alloc_exact() will free the unused pages.
>=20
> Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> ---
>  v2:
>  * Replaced __get_free_pages() with alloc_pages_exact().
>=20

Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

>  drivers/tee/amdtee/shm_pool.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> index f0303126f199..156e8a6f631f 100644
> --- a/drivers/tee/amdtee/shm_pool.c
> +++ b/drivers/tee/amdtee/shm_pool.c
> @@ -4,6 +4,7 @@
>   */
> =20
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/tee_drv.h>
>  #include <linux/psp.h>
>  #include "amdtee_private.h"
> @@ -11,26 +12,23 @@
>  static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>  			 size_t size, size_t align)
>  {
> -	unsigned int order =3D get_order(size);
> -	unsigned long va;
> +	void *va;
>  	int rc;
> =20
> -	/*
> -	 * Ignore alignment since this is already going to be page aligned
> -	 * and there's no need for any larger alignment.
> -	 */
> -	va =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	size =3D PAGE_ALIGN(size);
> +
> +	va =3D alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
>  	if (!va)
>  		return -ENOMEM;
> =20
>  	shm->kaddr =3D (void *)va;
>  	shm->paddr =3D __psp_pa((void *)va);
> -	shm->size =3D PAGE_SIZE << order;
> +	shm->size =3D size;
> =20
>  	/* Map the allocated memory in to TEE */
>  	rc =3D amdtee_map_shmem(shm);
>  	if (rc) {
> -		free_pages(va, order);
> +		free_pages_exact(va, size);
>  		shm->kaddr =3D NULL;
>  		return rc;
>  	}
> @@ -42,7 +40,7 @@ static void pool_op_free(struct tee_shm_pool *pool, struc=
t tee_shm *shm)
>  {
>  	/* Unmap the shared memory from TEE */
>  	amdtee_unmap_shmem(shm);
> -	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +	free_pages_exact(shm->kaddr, shm->size);
>  	shm->kaddr =3D NULL;
>  }
> =20

--===============3817219570842134048==--

