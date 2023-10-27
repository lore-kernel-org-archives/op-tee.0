From: Christoph Hellwig <hch@infradead.org>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/3] crypto: ccp - Add function to allocate and free
 memory using DMA APIs
Date: Thu, 26 Oct 2023 22:24:05 -0700
Message-ID: <ZTtJdU5a/P4kg/Ss@infradead.org>
In-Reply-To: <20231025065700.1556152-2-JESHWANTHKUMAR.NK@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2324704288092080325=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2324704288092080325==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Wed, Oct 25, 2023 at 12:26:58PM +0530, jeshwank wrote:
> +	tee_buf->vaddr = dma_alloc_coherent(psp->dev, size, &tee_buf->dma, gfp);
> +	if (!tee_buf->vaddr || !tee_buf->dma) {
> +		kfree(tee_buf);
> +		return NULL;
> +	}
> +
> +	tee_buf->size = size;
> +
> +	/* Check whether IOMMU is present. If present, translate IOVA
> +	 * to physical address, else the dma handle is the physical
> +	 * address.
> +	 */
> +	dom = iommu_get_domain_for_dev(psp->dev);
> +	if (dom)
> +		tee_buf->paddr = iommu_iova_to_phys(dom, tee_buf->dma);
> +	else

No, you can't mix the DMA API and iommu API.  You need to stick to one
or the other.


--===============2324704288092080325==--

