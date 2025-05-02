From: Robin Murphy <robin.murphy@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v8 10/14] dma-contiguous: export dma_contiguous_default_area
Date: Fri, 02 May 2025 14:11:02 +0100
Message-ID: <43e85d6a-ef99-4d61-910e-1d62814fd9ed@arm.com>
In-Reply-To: <20250502100049.1746335-11-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0401666850676375647=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0401666850676375647==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 02/05/2025 10:59 am, Jens Wiklander wrote:
> Export the global variable dma_contiguous_default_area so
> dev_get_cma_area() can be called a module.

What dma_map_ops implementation is in a module? Without any other 
context, I can't help thinking this smells of something sketchy.

Thanks,
Robin.

> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: iommu(a)lists.linux.dev
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>   kernel/dma/contiguous.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 8df0dfaaca18..eb361794a9c5 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -53,6 +53,7 @@
>   #endif
>   
>   struct cma *dma_contiguous_default_area;
> +EXPORT_SYMBOL(dma_contiguous_default_area);
>   
>   /*
>    * Default global CMA area size can be defined in kernel's .config.

--===============0401666850676375647==--

