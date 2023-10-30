From: "NK, JESHWANTHKUMAR" <jeshwanthkumar.nk@amd.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/3] crypto: ccp - Add function to allocate and free
 memory using DMA APIs
Date: Mon, 30 Oct 2023 11:35:57 +0530
Message-ID: <be7a774e-54d7-4ebf-8476-de137c47f020@amd.com>
In-Reply-To: <ZTtJdU5a/P4kg/Ss@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5047326750877414498=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============5047326750877414498==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Christoph,

On 27-Oct-23 10:54 AM, Christoph Hellwig wrote:
> On Wed, Oct 25, 2023 at 12:26:58PM +0530, jeshwank wrote:
>> +	tee_buf->vaddr = dma_alloc_coherent(psp->dev, size, &tee_buf->dma, gfp);
>> +	if (!tee_buf->vaddr || !tee_buf->dma) {
>> +		kfree(tee_buf);
>> +		return NULL;
>> +	}
>> +
>> +	tee_buf->size = size;
>> +
>> +	/* Check whether IOMMU is present. If present, translate IOVA
>> +	 * to physical address, else the dma handle is the physical
>> +	 * address.
>> +	 */
>> +	dom = iommu_get_domain_for_dev(psp->dev);
>> +	if (dom)
>> +		tee_buf->paddr = iommu_iova_to_phys(dom, tee_buf->dma);
>> +	else
> No, you can't mix the DMA API and iommu API.  You need to stick to one
> or the other.
Can you please elaborate?

--===============5047326750877414498==--

