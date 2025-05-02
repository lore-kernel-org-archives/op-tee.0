From: Robin Murphy <robin.murphy@arm.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v8 06/14] tee: implement protected DMA-heap
Date: Fri, 02 May 2025 14:59:40 +0100
Message-ID: <6a33e85f-6b60-4260-993d-974dd29cf8e6@arm.com>
In-Reply-To: <20250502100049.1746335-7-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0807146175890684598=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============0807146175890684598==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On 02/05/2025 10:59 am, Jens Wiklander wrote:
> Implement DMA heap for protected DMA-buf allocation in the TEE
> subsystem.
> 
> Restricted memory refers to memory buffers behind a hardware enforced
> firewall. It is not accessible to the kernel during normal circumstances
> but rather only accessible to certain hardware IPs or CPUs executing in
> higher or differently privileged mode than the kernel itself. This
> interface allows to allocate and manage such protected memory buffers
> via interaction with a TEE implementation.
> 
> The protected memory is allocated for a specific use-case, like Secure
> Video Playback, Trusted UI, or Secure Video Recording where certain
> hardware devices can access the memory.
> 
> The DMA-heaps are enabled explicitly by the TEE backend driver. The TEE
> backend drivers needs to implement protected memory pool to manage the
> protected memory.

[...]> +static struct sg_table *
> +tee_heap_map_dma_buf(struct dma_buf_attachment *attachment,
> +		     enum dma_data_direction direction)
> +{
> +	struct tee_heap_attachment *a = attachment->priv;
> +	int ret;
> +
> +	ret = dma_map_sgtable(attachment->dev, &a->table, direction,
> +			      DMA_ATTR_SKIP_CPU_SYNC);

If the memory is inaccessible to the kernel, what does this DMA mapping 
even mean? What happens when it tries to perform cache maintenance or 
bounce-buffering on inaccessible memory (which presumably doesn't even 
have a VA if it's not usable as normal kernel memory)?

If we're simply housekeeping the TEE's resources on its behalf, and 
giving it back some token to tell it which resource to go do its thing 
with, then that's really not "DMA" as far as the kernel is concerned.

[...]
> +static int protmem_pool_op_static_alloc(struct tee_protmem_pool *pool,
> +					struct sg_table *sgt, size_t size,
> +					size_t *offs)
> +{
> +	struct tee_protmem_static_pool *stp = to_protmem_static_pool(pool);
> +	phys_addr_t pa;
> +	int ret;
> +
> +	pa = gen_pool_alloc(stp->gen_pool, size);
> +	if (!pa)
> +		return -ENOMEM;
> +
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	if (ret) {
> +		gen_pool_free(stp->gen_pool, pa, size);
> +		return ret;
> +	}
> +
> +	sg_set_page(sgt->sgl, phys_to_page(pa), size, 0);

Where does "pa" come from here (i.e. what's the provenance of the 
initial "paddr" passed to tee_protmem_static_pool_alloc())? In general 
we can't call {phys,pfn}_to_page() an arbitrary addresses without 
checking pfn_valid() first. A bogus address might even crash 
__pfn_to_page() itself under CONFIG_SPARSEMEM.

Thanks,
Robin.

> +	*offs = pa - stp->pa_base;
> +
> +	return 0;
> +}

--===============0807146175890684598==--

